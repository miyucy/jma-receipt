#!/usr/bin/env ruby

# claim test Rcv server script
#   args  0:[port]
#         1:[directory of save file]
# 
# version 1.3.0
#                  '01-10-30 by Ymmt
# version 1.4.0 �ޥ������å��б�
#                  '02-11-12 by hiki
# version 1.4.1 �������ʣ�������б�
#               ���ˡ��������٤˥�����ȥ��åפ�����ֹ���ղä��Ƥ���
#                  '03-10-15 by hiki

require 'socket'
require 'xml_valid.rb'
EXP = "export"

$port, $file_path = ARGV
$file_path.chomp!('/')

$dtdfl = "/usr/local/orca/scripts/claim/dtd/MML1014_euc.dtd"
$logfl = "/tmp/claim_rcv.log"

$sh_path_name = "../../../scripts/claim/HL03.sh"
# 2002/11/12 add start (hiki)
# �����ֹ�
$seq_put = 0        # ��Ǽ���˥��åȤ��������ֹ�
$seq_exec = 0       # �¹��漱���ֹ�
$seq_max = 32767    # �����ֹ�κ�����
$thr_sleeptime = 1  # ����åɤν���Ԥ�����sleep����
# 2002/11/12 add end (hiki)
# 2003/10/15 add start (hiki)
$fname_seq = 0      # ����������(�ե�����̾�˻��Ѥ���)
# 2002/10/15 add end (hiki)

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
# �ޥ������åɻ��˼¹Ԥ��륯�饹
class ExecThreadMain
  # ���󥹥ȥ饯��
  #    ����
  # seq <= ��������åɤΥ������󥷥���ֹ�(0��32767)
  # sh_path <= ��ư������Υե�ѥ�̾
  # xml_path <= �ɤ߹���XML�ե�����Υե�ѥ�̾
  # out_file <= ���ϥƥ����ȥե�����̾
  #    ���
  # $seq_put���ͤϡ�����åɤ��ͤ��Ϥ��Ƥ��饫����ȥ��åפ��Ƥ���������
  def initialize(seq, sh_path, xml_path, out_file)
    @thr_seq = seq          # �������󥷥���ֹ�򥯥饹�ѿ��ΰ����¸
    @sh_pathname = sh_path
    @xml_pathname = xml_path
    @out_filename = out_file
  end


  # �ǥ����ɥᥤ�����
  def decode_main
    `#{@sh_pathname} #{@xml_pathname} #{@out_filename}`
  end


  # �¹��Ԥ��ؿ�
  #    ��Ǽ�����ֹ�ȼ¹Լ����ֹ����Ӥȥ������Ƚ����ȳ�Ǽ�����ֹ�Υ�����ȥ��å�
  def exec_start
    while @thr_seq != $seq_exec
      sleep $thr_sleeptime   # ����Ԥ�
    end
  end


  # �¹Դ�λ�ؿ�
  #    �¹Լ����ֹ�Υ�����ȥ��å�
  def exec_end
    $seq_exec += 1
    # 32768�ʾ�ˤʤä��顢�����᤹
    if $seq_exec > $seq_max
      $seq_exec = 0
    end
  end


  # ����åɥᥤ�����
  #    �������顢�缡�¹��Ԥ��������¹Ԥ�ƤӽФ�(public)
  def main
    exec_start      # ����Ԥ�
    decode_main # �缡�¹�
    exec_end    # ������λ����
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
# 2003/10/15 edit start (hiki)
#  flname = "claim_rcv_" + Time.now.strftime("%m%d_%H%M%S") + ".xml"
  flname = "claim_rcv_" + Time.now.strftime("%m%d_%H%M%S") + "_" + sprintf("%02d", $fname_seq) + ".xml"
  $fname_seq += 1
  if $fname_seq > 99
    $fname_seq = 0
  end
  return flname
# 2002/10/15 edit end (hiki)
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
    # ����åɤ���������
    thr_execflg = 0
    Thread.start {
      print svppt + "Thread Start[" + String($seq_put + 1) + "]\n"     if $debug != 0
      thr_start_time = ''; thr_end_time = ''                           if $debug != 0
      thr_start_time = Time.now.strftime("%H:%M:%S")                   if $debug != 0
      thr = nil
      # ����å������ᥤ�����
      thr = ExecThreadMain.new($seq_put, $sh_path_name, file_path_name, out_file)
      $seq_put += 1
      if $seq_put > $seq_max
        $seq_put = 0
      end
      thr_execflg = 1
      thr.main  # �ᥤ�����
      thr_end_time = Time.now.strftime("%H:%M:%S")                      if $debug != 0
      print svppt + "Thread End[" + String($seq_exec) + "] [" + thr_start_time + "��" + thr_end_time + "]\n"       if $debug != 0
      print svppt + "End Sequence NO. = [" + String($seq_put) + "]\n"       if $debug != 0
    }
    # ����å������Υ������Ƚ���
    while thr_execflg == 0
      sleep 1
    end
# 2002/11/12 update end (hiki)
  end
end
#----- Script end -----------------------------------
