#!/usr/bin/env ruby


# XML送信モジュール
require "orca_send_xml.rb"



# サンプルのセット
send_file_name = "test.xml"
remort_host = "localhost"
remort_port = 8888


# ------------------------------------------------------------

# XMLへの変換処理




# ------------------------------------------------------------

# 漢字コード変換処理






# ------------------------------------------------------------


# XMLの送信処理
#   send_file_name - 送信ファイル名
#   remort_host    - 送信ホスト名
#   remort_port    - 送信ポート番号
ret_cd = xml_send(send_file_name, remort_host, remort_port)

puts ret_cd		# エラーコードの出力



# ------------------------------------------------------------

