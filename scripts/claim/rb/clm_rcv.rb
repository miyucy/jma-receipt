#!/usr/bin/env ruby

# claim test Rcv server script
#   args  0:[port]
#         1:[directory of save file]
# 
# version 1.3.0
#                  '01-10-30 by Ymmt
# version 1.4.0 マルチスレッド対応
#                  '02-11-12 by hiki

require 'socket'
require 'xml_valid.rb'
EXP = "export"

$port, $file_path = ARGV
$file_path.chomp!('/')

$dtdfl = "/usr/local/orca/scripts/claim/dtd/MML1014_euc.dtd"
$logfl = "../log/claim_rcv.log"

$sh_path_name = "../../../scripts/claim/HL03.sh"
# 2002/11/12 add start (hiki)
# 識別番号
$seq_put = 0        # 格納時にセットした識別番号
$seq_exec = 0       # 実行中識別番号
$seq_max = 32767    # 識別番号の最大値
$thr_sleeptime = 1  # スレッドの順序待ち時のsleep時間
# 2002/11/12 add end (hiki)

#----- Define Classes --------------------------------

class FileSockRcv
  def initialize(fl, s)
    @fl_path_name = fl
    @sckt = s
    @eot = 0x04.chr
  end

  def start
    open(@fl_path_name, "wb") do |f|
      buf = ""
      while @eot != (buf = @sckt.read(1))
        print buf
        f.print buf
      end
    end
  end
end

class SndRsp
  def initialize(s)
    @sckt = s
    @ack = 0x06.chr
    @nak = 0x15.chr
  end

  def ok
    @sckt << @ack
  end

  def ng
    @sckt << @nak
  end
end

# 2002/11/12 add start (hiki)
# マルチスレッド時に実行するクラス
class ExecThreadMain
  # コンストラクタ
  #    引数
  # seq <= 生成スレッドのシーケンシャル番号(0〜32767)
  # sh_path <= 起動シェルのフルパス名
  # xml_path <= 読み込みXMLファイルのフルパス名
  # out_file <= 出力テキストファイル名
  #    注意
  # $seq_putの値は、スレッドに値を渡してからカウントアップしてください。
  def initialize(seq, sh_path, xml_path, out_file)
    @thr_seq = seq          # シーケンシャル番号をクラス変数領域に保存
    @sh_pathname = sh_path
    @xml_pathname = xml_path
    @out_filename = out_file
  end


  # デコードメイン処理
  def decode_main
    `#{@sh_pathname} #{@xml_pathname} #{@out_filename}`
  end


  # 実行待ち関数
  #    格納識別番号と実行識別番号の比較とウエイト処理と格納識別番号のカウントアップ
  def exec_start
    while @thr_seq != $seq_exec
      sleep $thr_sleeptime   # 順序待ち
    end
  end


  # 実行完了関数
  #    実行識別番号のカウントアップ
  def exec_end
    $seq_exec += 1
    # 32768以上になったら、０に戻す
    if $seq_exec > $seq_max
      $seq_exec = 0
    end
  end


  # スレッドメイン処理
  #    ここから、順次実行待ち・処理実行を呼び出す(public)
  def main
    exec_start      # 順序待ち
    decode_main # 順次実行
    exec_end    # 処理終了通知
  end


  public  :main
  private :decode_main
  private :exec_start
  private :exec_end
end
# 2002/11/12 add end (hiki)

#----- Define Methods --------------------------------

def file_chk(fl)
  if File.exists?(fl)
    ans = fl + " exists. Overwrite!"
  else 
    ans = fl + " is New file!"
  end
end

def make_file_name
  flname = "claim_rcv_" + Time.now.strftime("%m%d_%H%M%S") + ".xml"
end

#----- Main -----------------------------------------

svppt = "server:>> "
system(EXP, "LD_LIBRARY_PATH=.:/usr/local/orca/lib")

while true
  gsock = TCPServer.open($port)
  print svppt + "No #{$port} port open [" + Time.now.strftime("%H:%M:%S") + "]\n"
  print svppt + "Waiting...\n"
  sock = gsock.accept
  print svppt + "Client login\n"

  file_path_name = File.join($file_path, make_file_name)
  print svppt + file_chk(file_path_name) + "\n"

  rcvbuf = FileSockRcv.new(file_path_name, sock)
  ans = SndRsp.new(sock)
  
  print svppt + "Start Receiving File --------------------------\n"
  rcvbuf.start
  print svppt + "Complete Receiving File -----------------------\n"
  
#----- convert claim data J-code to UTF8 ---------------
  print svppt + "Convert to UTF-8\n"
  u8_file = file_path_name.gsub(/.xml$/, "_u8.xml")
  `ruby xml_jcnv.rb #{file_path_name} tou8 -f > #{u8_file}`  
  file_path_name = u8_file

#----- check claim data and send respons to client -----
  print svppt + "Claim valid check\n"
  if parser_check(file_path_name, $dtdfl, $logfl)
    print svppt + "Send [ack] to client\n" ; ans.ok ; valid_check_flg = true
  else
    print svppt + "Send [nak] to client\n" ; ans.ng ; valid_check_flg = false
  end

#-------------------------------------------------------
  print svppt + "Client disconnects\n"
  gsock.close
  print svppt + "Close port [" + Time.now.strftime("%H:%M:%S") + "]\n\n"

#----- kick shell script ( decode(ruby) and cobol) ) ---
  if valid_check_flg
    out_file = file_path_name.gsub(/_u8.xml$/, ".txt")
    print svppt + "Decode claim data to #{out_file} and kick COBOL\n"
    print "#{$sh_path_name} #{file_path_name} #{out_file}\n\n"
# 2002/11/12 update start (hiki)
#    `#{$sh_path_name} #{file_path_name} #{out_file}`
    # スレッドの生成処理
    thr_execflg = 0
    Thread.start {
      print svppt + "Thread Start[" + String($seq_put + 1) + "]\n"     if $debug != 0
      thr_start_time = ''; thr_end_time = ''                           if $debug != 0
      thr_start_time = Time.now.strftime("%H:%M:%S")                   if $debug != 0
      thr = nil
      # スレッド生成メイン処理
      thr = ExecThreadMain.new($seq_put, $sh_path_name, file_path_name, out_file)
      $seq_put += 1
      if $seq_put > $seq_max
        $seq_put = 0
      end
      thr_execflg = 1
      thr.main  # メイン処理
      thr_end_time = Time.now.strftime("%H:%M:%S")                      if $debug != 0
      print svppt + "Thread End[" + String($seq_exec) + "] [" + thr_start_time + "〜" + thr_end_time + "]\n"       if $debug != 0
      print svppt + "End Sequence NO. = [" + String($seq_put) + "]\n"       if $debug != 0
    }
    # スレッド生成のウエイト処理
    while thr_execflg == 0
      sleep 1
    end
# 2002/11/12 update end (hiki)
  end
end
#----- Script end -----------------------------------
