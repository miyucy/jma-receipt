#!/usr/bin/env ruby


# ======================================================================
# シーケンシャルファイルのXMLファイル変換・ソケット送信スクリプト

# これは、各モジュールを呼び出すだけのスクリプトです


#orca_send.rb [mode] [in_seq] [tmpl] [layout] [temp_file] [out_code] [out_lf] [host] [port] [option]
#・mode      - 実行モード [現在「1」で固定]
#・in_seq    - 入力シーケンシャルファイル名
#・tmpl      - テンプレートファイル名
#・layout    - レイアウト定義ファイル名
#・temp_file - 中間ファイル名(ソケット通信時に、リトライする場合に使用)
#・out_code  - 変換文字コード
#・out_lf    - 変換改行コード
#・host      - 送信ホスト名
#・port      - 送信ポート番号
#・option    - オプション(現在、未定)


# ======================================================================



if __FILE__ == $0

	debug = 1	# デバッグモードである

	# 起動情報の取り込み
	@arg = []
	@arg = ARGV

end



# ======================================================================


require 'orca_make_xml.rb'
require 'orca_jcnv.rb'
require 'orca_send_xml.rb'


# ======================================================================


# コマンド引数の文字コード判定
#    引数
# word - 判定対象コード [IN / String型]
#    戻り値
# 引数の文字コードを解読した結果のコード(nilの場合、文字コードの判定に失敗した)
#  1 - EUC-JP
#  2 - Shift_JIS
#  3 - UTF-8
#  4 - JIS
def decision_word_code(word)
	ret = nil

	case	word
	when	/euc/i, /euc-jp/i, /unix/i, /linux/i, '1'
		ret = 1
	when	/shift_jis/i, /shift-jis/i, /sjis/i, /s_jis/i, /s-jis/i, /mac/i, /machintosh/i, /win/i, /windows/i, /dos/i, '2'
		ret = 2
	when	/utf-8/i, /utf8/i, '3'
		ret = 3
	when	/jis/i, '4'
		ret = 4
	end

	return ret
end



# ----------------------------------------------------------------------


# コマンド引数の改行コード判定
#    引数
# word - 判定対象コード [IN / String型]
#    戻り値
# 引数の改行コードを解読した結果のコード(nilの場合、改行コードの判定に失敗した)
#   1 - UNIX系改行コード(LF(0xa)のみ)
#   2 - Machintosh系改行コード(CR(0xd)のみ)
#   3 - Windows系改行コード(CR(0xd)+LF(0xa))
def decision_linefeed_code(word)
	ret = nil

	case	word
	when	/unix/i, /linux/i, /0xa/i, '1'
		ret = 1
	when	/mac/i, /machintosh/i, /0xd/i, '2'
		ret = 2
	when	/windows/i, /win/i, /dos/i, /0xd0xa/i, '3'
		ret = 3
	end

	return ret
end



# ======================================================================


if __FILE__ == $0

	if @arg[0] =~ /^@(\S+?)/
		# レスポンスファイル経由のオプション指定
		resp_file = $1
		resp_data = ''
		open(resp_file, "r") do |fp|
			resp_data = fp.read
		end
		resp_data.gsub! /^\s*?\#.*?\n/, ''	# コメント行の削除
		resp_data.gsub! /^\s*?\n/, ''	# 改行のみの行の削除
		resp_data.gsub! /^.*?\#.*?\n/, ''	# コメントの削除

		# パラメータ名にする場合は、以下を変更すること
		@arg = resp_data.split("\n")	# 改行で分ける


		# ****************************************
		# レスポンスファイルのフォーマットについて
		#
		# 以下の形式が好ましい
		#   「#」行のコメント処理を加える
		#    空白行は無視
		#   「<パラメータ名>=<内容>」の方式にする
		# ****************************************
	end


	# ============================================================
	case	@arg[0]
	when	'1'
		# モード1である
		arg_mode, arg_in_seq, arg_tmpl, arg_layout, arg_temp_file, arg_out_code, arg_out_lf, arg_host, arg_port, arg_option = @arg


$stderr.puts '-' * 78 + "\n" + "引数の内容\n"				if (debug & 1) == 1
$stderr.puts "mode = [" + String(arg_mode) + "]"			if (debug & 1) == 1
$stderr.puts "in_seq = [" + String(arg_in_seq) + "]"		if (debug & 1) == 1
$stderr.puts "tmpl = [" + String(arg_tmpl) + "]"			if (debug & 1) == 1
$stderr.puts "layout = [" + String(arg_layout) + "]"		if (debug & 1) == 1
$stderr.puts "temp_file = [" + String(arg_temp_file) + "]"	if (debug & 1) == 1
$stderr.puts "out_code = [" + String(arg_out_code) + "]"	if (debug & 1) == 1
$stderr.puts "out_lf = [" + String(arg_out_lf) + "]"		if (debug & 1) == 1
$stderr.puts "host = [" + String(arg_host) + "]"			if (debug & 1) == 1
$stderr.puts "port = [" + String(arg_port) + "]"			if (debug & 1) == 1
$stderr.puts "option = [" + String(arg_option) + "]"		if (debug & 1) == 1
$stderr.puts '-' * 78										if (debug & 1) == 1


		# データ領域への格納

		# シーケンシャルファイルの読み込み
		seq_data = ''
		open(arg_in_seq, 'r') do |fp|
			seq_data = fp.read
		end

		# テンプレートXMLファイルの読み込み
		tmpl_data = ''
		open(arg_tmpl, 'r') do |fp|
			tmpl_data = fp.read
		end

		# レイアウト定義ファイルの読み込み
		layout_data = ''
		open(arg_layout, 'r') do |fp|
			layout_data = fp.read
		end

		# 出力文字コード
		out_code = ''
		out_code = decision_word_code(arg_out_code)
		if out_code == nil
			if arg_out_code == nil or arg_out_code == ''
				$stderr.puts '出力文字コードが指定されていません'
			else
				$stderr.puts '指定された出力文字コードは不正です(' + String(arg_out_code) + ')'
			end
			exit 2
		end


		# 出力改行コード
		out_lf = ''
		out_lf = decision_linefeed_code(arg_out_lf)
		if out_lf == nil
			if arg_out_lf == nil or arg_out_lf == ''
				$stderr.puts '出力改行コードが指定されていません'
			else
				$stderr.puts '指定された出力改行コードは不正です(' + String(arg_out_lf) + ')'
			end
			exit 2
		end


		# XMLコンバート処理

		ret_cd1 = nil
#		ret_cd1 = conversion_seq_to_xml(tmpl_data, seq_data, layout_data, 0)	# authentic
		ret_cd1 = conversion_seq_to_xml(tmpl_data, seq_data, layout_data, 1)	# debug
		if ret_cd1 == nil
			$stderr.puts '「conversion_seq_to_xml」からnilを受け取りました'
			exit 2
		end
		if ret_cd1[0] != 0
			$stderr.puts '「conversion_seq_to_xml」でエラーが発生しました'
			exit 2
		end

# ****************************************
$stderr.puts '文字コードの変換中です'		if (debug & 1) == 1
# ****************************************

		# 文字コードの変換
		ret_cd2 = nil
		ret_cd2 = xml_code_conversion(ret_cd1[1], out_code, out_lf, 1)
#		ret_cd2 = xml_code_conversion(ret_cd1[1], out_code, out_lf, 2)
		if ret_cd2 == nil
			$stderr.puts '「xml_code_conversion」からnilを受け取りました'
			exit 2
		end
		if ret_cd2[0] != 0
			# xml_code_conversionでエラー
			$stderr.puts String(ret_cd2[2])
			exit 2
		end

		# 中間ファイルへの書き込み
		open(arg_temp_file, 'wb') do |fp|
			fp.print ret_cd2[1]
		end

# ****************************************
$stderr.puts '文字コードの変換が終わりました'		if (debug & 1) == 1
# ****************************************

# ****************************************
$stderr.puts 'ソケット通信中です'		if (debug & 1) == 1
# ****************************************

		# ソケット通信処理
		ret_cd3 = 0
		ret_cd3 = xml_send(arg_temp_file, arg_host, arg_port)
		case	ret_cd3
		when	0
			# 正常終了
		when	-1
			# 接続エラー
			$stderr.puts 'ソケット通信時に、接続エラーが発生しました'
			exit 2
		when	-2
			# データ送信エラー
			$stderr.puts 'ソケット通信時に、データ送信エラーが発生しました'
			exit 2
		else
			$stderr.puts '「xml_send」から、予期せぬ値を取得しました'
			exit 2
		end

# ****************************************
$stderr.puts 'ソケット通信が終わりました'		if (debug & 1) == 1
# ****************************************


# ****************************************
$stderr.puts 'XML変換・送信処理がが終わりました'		if (debug & 1) == 1
# ****************************************


	# ============================================================

	when	'2'		# XML変換処理
		# モード2である
		arg_mode, arg_in_seq, arg_tmpl, arg_layout, arg_out_file, arg_option = @arg


		# データ領域への格納

		# シーケンシャルファイルの読み込み
		seq_data = ''
		open(arg_in_seq, 'r') do |fp|
			seq_data = fp.read
		end

		# テンプレートXMLファイルの読み込み
		tmpl_data = ''
		open(arg_tmpl, 'r') do |fp|
			tmpl_data = fp.read
		end

		# レイアウト定義ファイルの読み込み
		layout_data = ''
		open(arg_layout, 'r') do |fp|
			layout_data = fp.read
		end


		# XMLコンバート処理

		ret_cd1 = nil
#		ret_cd1 = conversion_seq_to_xml(tmpl_data, seq_data, layout_data, 0)	# authentic
		ret_cd1 = conversion_seq_to_xml(tmpl_data, seq_data, layout_data, 1)	# debug
		if ret_cd1 == nil
			$stderr.puts '「conversion_seq_to_xml」からnilを受け取りました'
			exit 2
		end
		if ret_cd1[0] != 0
			$stderr.puts '「conversion_seq_to_xml」でエラーが発生しました'
			exit 2
		end


		# 出力ファイルへの書き込み
		open(arg_out_file, 'wb') do |fp|
			fp.print ret_cd1[1]
		end


# ****************************************
$stderr.puts 'XML変換処理がが終わりました'		if (debug & 1) == 1
# ****************************************


	# ============================================================

	when	'3'		# 文字コード変換処理
		# モード3である
		arg_mode, arg_in_file, arg_out_file, arg_out_code, arg_out_lf, arg_option = @arg


		# データ領域への格納

		# 入力ファイルの読み込み
		in_file = ''
		open(arg_in_file, 'r') do |fp|
			in_file = fp.read
		end

		# 出力文字コード
		out_code = ''
		out_code = decision_word_code(arg_out_code)
		if out_code == nil
			if arg_out_code == nil or arg_out_code == ''
				$stderr.puts '出力文字コードが指定されていません'
			else
				$stderr.puts '指定された出力文字コードは不正です(' + String(arg_out_code) + ')'
			end
			exit 2
		end


		# 出力改行コード
		out_lf = ''
		out_lf = decision_linefeed_code(arg_out_lf)
		if out_lf == nil
			if arg_out_lf == nil or arg_out_lf == ''
				$stderr.puts '出力改行コードが指定されていません'
			else
				$stderr.puts '指定された出力改行コードは不正です(' + String(arg_out_lf) + ')'
			end
			exit 2
		end


		# 文字コードの変換
		ret_cd2 = nil
		ret_cd2 = xml_code_conversion(in_file, out_code, out_lf, 1)
#		ret_cd2 = xml_code_conversion(in_file, out_code, out_lf, 2)
		if ret_cd2 == nil
			$stderr.puts '「xml_code_conversion」からnilを受け取りました'
			exit 2
		end
		if ret_cd2[0] != 0
			# xml_code_conversionでエラー
			$stderr.puts String(ret_cd2[2])
			exit 2
		end

		# 出力ファイルへの書き込み
		open(arg_out_file, 'wb') do |fp|
			fp.print ret_cd2[1]
		end



	# ============================================================

	when	'4'		# ソケット通信処理
		# モード4である
		arg_mode, arg_send_file, arg_host, arg_port, arg_option = @arg


		# ソケット通信処理
		ret_cd3 = 0
		ret_cd3 = xml_send(arg_send_file, arg_host, arg_port)
		case	ret_cd3
		when	0
			# 正常終了
		when	-1
			# 接続エラー
			$stderr.puts 'ソケット通信時に、接続エラーが発生しました'
			exit 2
		when	-2
			# データ送信エラー
			$stderr.puts 'ソケット通信時に、データ送信エラーが発生しました'
			exit 2
		else
			$stderr.puts '「xml_send」から、予期せぬ値を取得しました'
			exit 2
		end



	# ============================================================

	when	'5'		# 文字コード変換のみ
		# モード5である
		arg_mode, arg_in_file, arg_out_file, arg_in_code, arg_out_code, arg_out_lf, arg_option = @arg


		# データ領域への格納

		# 入力ファイルの読み込み
		in_file = ''
		open(arg_in_file, 'r') do |fp|
			in_file = fp.read
		end


		# 入力文字コード
		in_code = ''
		in_code = decision_word_code(arg_in_code)
		if in_code == nil
			if arg_in_code == nil or arg_in_code == ''
				$stderr.puts '入力文字コードが指定されていません'
			else
				$stderr.puts '指定された入力文字コードは不正です(' + String(arg_in_code) + ')'
			end
			exit 2
		end


		# 出力文字コード
		out_code = ''
		out_code = decision_word_code(arg_out_code)
		if out_code == nil
			if arg_out_code == nil or arg_out_code == ''
				$stderr.puts '出力文字コードが指定されていません'
			else
				$stderr.puts '指定された出力文字コードは不正です(' + String(arg_out_code) + ')'
			end
			exit 2
		end


		# 出力改行コード
		out_lf = ''
		out_lf = decision_linefeed_code(arg_out_lf)
		if out_lf == nil
			if arg_out_lf == nil or arg_out_lf == ''
				$stderr.puts '出力改行コードが指定されていません'
			else
				$stderr.puts '指定された出力改行コードは不正です(' + String(arg_out_lf) + ')'
			end
			exit 2
		end


		# 文字コードの変換
		ret_cd2 = nil
		ret_cd2 = word_code_conversion(in_file, in_code, out_code, out_lf)
		if ret_cd2 == nil
			$stderr.puts '「word_code_conversion」からnilを受け取りました'
			exit 2
		end
		if ret_cd2[0] != 0
			# xml_code_conversionでエラー
			$stderr.puts String(ret_cd2[2])
			exit 2
		end

		# 出力ファイルへの書き込み
		open(arg_out_file, 'wb') do |fp|
			fp.print ret_cd2[1]
		end



	# ============================================================

	when	nil, '', '--help', '-?', '/?'
		mes = ''
		mes += "このスクリプトは、シーケンシャルファイルをXMLに変換し、ソケット通信するスクリプトです\n"
		mes += "\n"
		mes += "\n"
		mes += "XML変換・文字コード変換・ソケット通信処理[モード1]\n"
		mes += "\n"
		mes += "orca_send.rb [mode] [in_seq] [tmpl] [layout] [temp_file] [out_code] [out_lf] [host] [port] [option]\n"
		mes += "   [mode]      - 実行モード [「1」をセット]\n"
		mes += "   [in_seq]    - 入力シーケンシャルファイル名\n"
		mes += "   [tmpl]      - テンプレートファイル名\n"
		mes += "   [layout]    - レイアウト定義ファイル名\n"
		mes += "   [temp_file] - 中間ファイル名(ソケット通信時に、リトライする場合に使用)\n"
		mes += "   [out_code]  - 変換文字コード\n"
		mes += "   [out_lf]    - 変換改行コード\n"
		mes += "   [host]      - 送信ホスト名\n"
		mes += "   [port]      - 送信ポート番号\n"
		mes += "   [option]    - オプション(現在、未定)\n"
		mes += "\n"
		mes += "\n"
		mes += "\n"
		mes += "XML変換処理[モード2]\n"
		mes += "\n"
		mes += "orca_send.rb [mode] [in_seq] [tmpl] [layout] [out_file] [option]\n"
		mes += "   [mode]      - 実行モード [「2」をセット]\n"
		mes += "   [in_seq]    - 入力シーケンシャルファイル名\n"
		mes += "   [tmpl]      - テンプレートファイル名\n"
		mes += "   [layout]    - レイアウト定義ファイル名\n"
		mes += "   [out_file]  - 出力ファイル名\n"
		mes += "   [option]    - オプション(現在、未定)\n"
		mes += "\n"
		mes += "\n"
		mes += "\n"
		mes += "XML文字コード変換処理[モード3]\n"
		mes += "\n"
		mes += "orca_send.rb [mode] [in_file] [out_file] [out_code] [out_lf] [option]\n"
		mes += "   [mode]      - 実行モード [「3」をセット]\n"
		mes += "   [in_file]   - 入力ファイル名\n"
		mes += "   [out_file]  - 出力ファイル名\n"
		mes += "   [out_code]  - 変換文字コード\n"
		mes += "   [out_lf]    - 変換改行コード\n"
		mes += "   [option]    - オプション(現在、未定)\n"
		mes += "\n"
		mes += "\n"
		mes += "\n"
		mes += "ソケット通信処理[モード4]\n"
		mes += "\n"
		mes += "orca_send.rb [mode] [send_file] [host] [port] [option]\n"
		mes += "   [mode]      - 実行モード [「4」をセット]\n"
		mes += "   [send_file] - 送信ファイル名\n"
		mes += "   [host]      - 送信ホスト名\n"
		mes += "   [port]      - 送信ポート番号\n"
		mes += "   [option]    - オプション(現在、未定)\n"
		mes += "\n"
		mes += "\n"
		mes += "\n"
		mes += "文字コード変換処理[モード5]\n"
		mes += "\n"
		mes += "orca_send.rb [mode] [in_file] [out_file] [in_code] [out_code] [out_lf] [option]\n"
		mes += "   [mode]      - 実行モード [「5」をセット]\n"
		mes += "   [in_file]   - 入力ファイル名\n"
		mes += "   [out_file]  - 出力ファイル名\n"
		mes += "   [in_code]   - 変換前文字コード\n"
		mes += "   [out_code]  - 変換後文字コード\n"
		mes += "   [out_lf]    - 変換改行コード\n"
		mes += "   [option]    - オプション(現在、未定)\n"
		mes += "\n"
		mes += "\n"
		mes += "\n"


		$stdout.puts	mes
		exit


	# ============================================================

	else
		$stderr.puts	'引数の内容が不正です mode = [' + String(@arg[0]) + ']'
		exit 2
	end


end



# ======================================================================



