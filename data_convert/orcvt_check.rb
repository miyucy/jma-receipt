#!/usr/bin/ruby
require "jcode"

# 半角英数字記号 -> 全角変換(EUC) バグ対応
#     orcvt_euc.rb のバグにより変換ミスをしたデータの表示 
#
#     パラメータファイル /home/orca/ORCADC.PARA [ $file_path_name ]
#     対象項目番号 16,17,18,19,20 [ $tgt_csv_no ] ( 入力コード１〜５ )
# 01/11/05 by 山本

$KCODE = "euc"

$file_path_name = "/home/orca/ORCADC.PARA"
$tgt_csv_no = [16,17,18,19,20]

# パラメータファイルから入力ファイル名をセットする
def set_in_f(idct)
  # パラメータファイルの存在確認
  if !File.exists?($file_path_name)
    print "ERR: no file [ " + $file_path_name + " ]\n"
    exit
  end
  open($file_path_name,"r") do |f|
    while buf = f.gets
      if /^#{idct}/ =~ buf.chop!
        buf.gsub!(idct,"")
        buf.gsub!(/(,T)$/,"")
        return buf
      end
    end
  end
end

#----- Main --------------------------------------------------
cnt = 0 ; lcnt = 0
# 入力ファイル名のセット
in_file = set_in_f('@01-5:')
# ファイルの存在確認
if !File.exists?(in_file)
  print "ERR: no file [ " + in_file + " ]\n"
  exit
end

# 入力ファイルオープン
open(in_file,"r") do |f|
  # 入力ファイルから1行読み込み
  while buf = f.gets
    lcnt = lcnt + 1
    ary = Array.new
    # 行末の改行コードを削除
    buf.chop!
    # デリミタをカンマとし配列にセット（０オリジン）
    ary = buf.split(",",-1)

    # 対象項目についてのみチェック
    flg = false
    $tgt_csv_no.each{|s|
      # 'ｯ','-'が含まれるか?
      if /[ｯ-]/e =~ ary[s-1]
        flg = true
      end
    }

    if flg
      cnt = cnt + 1
      printf("[line:%d] -------------- \n",lcnt)
      puts buf
    end
  end
end
printf("\n**(orcvt_chek.rb)**  checked CSV file [ %s (%d lines) ] miss data %d\n\n",in_file,lcnt,cnt)
#----- Script end -------------------------------------------
