#!/usr/bin/env ruby


# デコード処理 ver0.11
#
#
# ver0.11 - 複数の単独タグへの対応
#
#
# 2001/10/15 - 置換方法を変更して、大きな単位の置換に対応した
# 2001/10/18 - 出力文字コードをEUC-JP/Shift_JIS固定にした


# =============================================================================
# 引数の判定


if __FILE__ == $0


	$h_char = '~'	# 階層の区切り文字
	$a_char = '!'	# 属性の区切り文字
	$out_word_code = '1'		# 出力文字コードはEUC-JPコード
#	$out_word_code = '2'		# 出力文字コードはShift_JISコード

	$in_xml = 'test_a.xml'					# テスト実行時に読み込むファイル名
	$layout_fname = 'orca_layout_decode.def'	# レイアウト定義ファイル名
	$link_fname = 'decode.def'				# パラメータリンクファイル名
	$seq_fname = 'seq.txt'					# 出力シーケンシャルファイル名
	$hirarcy_fname = 'hieracy.txt'			# 内部階層情報出力ファイル名

	$exec_mode = '0'	# 実行モード
	argv_size = 0	# ARGVの大きさ
	argv_size = ARGV.size

	help_flg = 0	# ヘルプ表示させるかのフラグ


	if argv_size != 0
		$exec_mode = String(ARGV.shift)
		case	$exec_mode
		when	'--help', '-?', '/?'
			# ヘルプ表示
			help_flg = 1
		when	'-execute', '-e', '1'
			# デコード実行
			if argv_size < 5
				$stderr.puts 'デコードの実行に必要な引数が不足しています'
				exit 2
			end
			$exec_mode= '1'
			$in_xml = String(ARGV.shift)
			$layout_fname = String(ARGV.shift)	# レイアウト定義ファイル名
			$link_fname = String(ARGV.shift)	# パラメータリンクファイル名
			$seq_fname = String(ARGV.shift)		# 出力シーケンシャルファイル名
			$hirarcy_fname = ''					# 内部階層情報出力ファイル名
		when	'-show', '-s', '2'
			# デコード結果の表示
			if argv_size < 4
				$stderr.puts 'デコード結果の表示に必要な引数が不足しています'
				exit 2
			end
			$exec_mode= '2'
			$in_xml = String(ARGV.shift)
			$layout_fname = String(ARGV.shift)	# レイアウト定義ファイル名
			$link_fname = String(ARGV.shift)	# パラメータリンクファイル名
			$hirarcy_fname = ''					# 内部階層情報出力ファイル名
		when	'-print', '-p', '-p1', '11'
			# 表示モード Type1
			if argv_size < 2
				$stderr.puts '階層情報の表示に必要な引数が不足しています'
				exit 2
			end
			$exec_mode= '11'
			$in_xml = String(ARGV.shift)
		when	'-p2', '12'
			# 表示モード Type2
			if argv_size < 2
				$stderr.puts '階層情報の表示に必要な引数が不足しています'
				exit 2
			end
			$exec_mode= '12'
			$in_xml = String(ARGV.shift)
		when	'-p3', '13'
			# 表示モード Type3
			if argv_size < 2
				$stderr.puts '階層情報の表示に必要な引数が不足しています'
				exit 2
			end
			$exec_mode= '13'
			$in_xml = String(ARGV.shift)
		else
			# 不明な引数である
			$stderr.puts '指定された引数は、不正です'
			exit 2
		end
	else
		help_flg = 1
	end



	if help_flg == 1
		mes = ''
		mes = mes + 'decode_xml.rb [mode] [...]' + "\n"
		mes = mes + "\n"
		mes = mes + "\n"
		mes = mes + 'mode = -e or -execute' + "\n"
		mes = mes + "  デコード処理の実行\n"
		mes = mes + "[-e] [in_file] [layout_file] [link_file] [out_file]\n"
		mes = mes + "    in_file     = XMLファイル名\n"
		mes = mes + "    layout_file = レイアウト定義ファイル名\n"
		mes = mes + "    link_file   = パラメータリンクファイル名\n"
		mes = mes + "    out_file    = 出力ファイル名\n"
		mes = mes + "\n"
		mes = mes + "\n"
		mes = mes + 'mode = -s or -show' + "\n"
		mes = mes + "  デコード処理の実行後、標準出力に表示\n"
		mes = mes + "[-s] [in_file] [layout_file] [link_file]\n"
		mes = mes + "    in_file     = XMLファイル名\n"
		mes = mes + "    layout_file = レイアウト定義ファイル名\n"
		mes = mes + "    link_file   = パラメータリンクファイル名\n"
		mes = mes + "\n"
		mes = mes + "\n"
		mes = mes + 'mode = -p or -p1 or -print' + "\n"
		mes = mes + "  階層情報の標準出力への表示\n"
		mes = mes + "[-p1] [in_file]\n"
		mes = mes + "    in_file     = 階層表示XMLファイル名\n"
		mes = mes + "\n"
		mes = mes + "\n"
		mes = mes + 'mode = -p2' + "\n"
		mes = mes + "  デバッグ用階層情報の標準出力への表示\n"
		mes = mes + "[-p2] [in_file]\n"
		mes = mes + "    in_file     = 階層表示XMLファイル名\n"
		mes = mes + "\n"
		mes = mes + "\n"

		$stdout.print	mes

		exit 0

	end

end




# =============================================================================


require 'xmlparser'
require 'kconv'
require 'uconv'
include Uconv

require 'orca_lib.rb'




# hierarchy - 階層

# UTF-8から、直接Shift_JISに変換すると、正しく実行されないので、
# EUCに変換してから、Shift_JISに変換している




# =============================================================================


# XMLの階層情報の取得
#    引数
# in_xml        - 入力XML文書 [IN / String型]
# section_code  - 階層を区分するコード [IN / String型]
# atr_sec_code  - 階層名と属性を区分するコード [IN / String型]
# out_word_code - 出力文字コード [IN / String型]
#                    '1' - EUCコード
#                    '2' - シフトJISコード
#    戻り値
# [x][0] - 階層名情報 [OUT / String型配列]
# [x][1] - 階層値情報 [OUT / String型配列]
#    備考
# XMLのパースに失敗しましたら、例外が発生しますので、注意してください
#  もしも、例外判定を行いたい場合は、
#  この関数の外側で、例外捕捉処理を追加してください
# 階層や属性を区分するコードに使用する文字は、半角記号で、「_」や「-」など、
#  エレメント名に出てくるような記号は、さけてください
def get_xml_hierarcyinfo(in_xml, section_code, atr_sec_code, out_word_code)

	h_stack = []	# 現在の階層スタック
	now_hiera = ''	# 現在の階層

	h_stack_o = []	# 階層スタック
	v_stack_o = []	# 値スタック
	wd_h = ''	# 階層名称、ワーク領域
	wd_ha = ''	# 属性の階層名称、ワーク領域
	wd_v = ''	# 値、ワーク領域
	wd_name = ''	# 名称のワーク領域
	wd_an1 = ''	# 名称の配列化で使用するワーク領域
	wd_an2 = ''
	wd_an3 = ''
	wd_an4 = ''
	wd_an5 = ''
	idx1 = 0
	idx2 = 0
	flg1 = 0
	flg2 = 0
	idx3 = 0
	encoding = ''	# 文字列の漢字コード
	o_encoding = ''	# 出力文字列の漢字コード
	xml = ''	# XML文字列の格納場所


	# 出力文字列の漢字コードのセット
	case String(out_word_code)
	when '1'
		o_encoding = 'EUC-JP'
	when '2'
		o_encoding = 'Shift_JIS'
	when /EUC-JP/i
		o_encoding = 'EUC-JP'
	when /Shift_JIS/i
		o_encoding = 'Shift_JIS'
	end


	# １行目の取得
	idx3 = in_xml.index("\n")
	xml = in_xml[0, idx3]

	# ヘッダの変換
	# ※注意 : UTFの判定を先に行うこと()
	# encodingの記述がなければ、UTF-8として扱う
	if xml =~ /^.*?(<\?xml\sversion\s*?=\s*?\"[\.\d]+?\")\s*?(\?\>)/i 
#	if xml =~ /^.*?(<\?xml\sversion\s*?=\s*?\".+?\")\s*?(\?\>)/i 
		xml = $1 + " encoding=\"UTF-8\"" + $2 + "\n"
	end
	if xml =~ /^.*?(<\?xml\sversion\s*?=.+\sencoding\s*?=\s*?.UTF-8.*?)/i
		xml.gsub!(/UTF-8/i, "UTF-8")
		encoding = "UTF-8"
	end
	if xml =~ /^<\?xml\sversion\s*?=.+\sencoding\s*?=\s*?.EUC-JP./i
		xml.gsub!(/EUC-JP/i, "UTF-8")
		encoding = "EUC-JP"
	end
#	if xml =~ /^<\?xml\sversion=.+\sencoding=.Shift_JIS./i
	if xml =~ /^<\?xml\s*?version\s*?=.+\sencoding\s*?=\s*?.Shift_JIS./i
		xml.gsub!(/Shift_JIS/i, "UTF-8")
		encoding = "Shift_JIS"
	end
	if xml =~ /^<\?xml\s*?version\s*?=.+\sencoding\s*?=\s*?.JIS./i
		xml.gsub!(/JIS/i, "UTF-8")
		encoding = "JIS"
	end

	# 残りの文字列を取得して、変換
	xml += in_xml[idx3 .. -1]
	case encoding
	when "EUC-JP"
		xml = euctou8(xml)
	when "Shift_JIS"
		xml = Uconv.euctou8(Kconv::toeuc(xml))
#		xml = sjistou8(xml)
	when "JIS"
		xml = Uconv::euctou8(Kconv::toeuc(xml))
	when "UTF-8"
#		xml = xml
		xml = euctou8(Uconv.u8toeuc(xml))
#		if xml[0] != '<'
#			xml = xml[3 .. -1]		# ゴミが混じっていたら、取り除く
#		end
	else
		# 未対応の文字コードなので、例外を発生させる
		raise '入力された文字コードは対応していません [' + String(encoding) + ']'
	end


	parser = XMLParser.new
	def parser.default
	end


	parser.parse(xml) do |type, name, data|
		case type
		when XMLParser::START_ELEM
			case o_encoding
			when "EUC-JP"
				wd_name = Uconv.u8toeuc(name)
			when "Shift_JIS"
				wd_name = Kconv::tosjis(Uconv.u8toeuc(name))
#			when "UTF-8"
#				wd_name = name
			end
			# 現在の階層等の配列化
			wd_an1 = now_hiera
			wd_an1 = wd_an1 + section_code		if wd_an1 != ''
			idx1 = 1
			flg1 = 0
			# 同じ配列が見つかる間、繰り返す
			while flg1 == 0
				wd_an2 = wd_name + '(' + String(idx1) + ')'
				wd_an3 = wd_an1 + wd_an2
				if h_stack_o.include?(wd_an3) == false
					flg1 = 1
					break	# while文から抜ける
				end
				idx1 += 1
			end

			# 単独タグの配列形式への対応
			# なお、配列がなければ、無視する
			if data.size > 0
				idx2 = idx1
				flg2 = 0
				while flg2 == 0
					wd_an4 = wd_name + '(' + String(idx2) + ')'
					data.each do |key, value|
						case o_encoding
						when "EUC-JP"
							wd_ha = Uconv.u8toeuc(key)
						when "Shift_JIS"
							wd_ha = Kconv::tosjis(Uconv.u8toeuc(key))
#						when "UTF-8"
#							wd_ha = key
						end
						wd_an5 = wd_an1 + wd_an4 + atr_sec_code + wd_ha
						if h_stack_o.include?(wd_an5) == false
							wd_an2 = wd_an4		# 該当位置の配列の名前をセット
							flg2 = 1
							break	# each文から抜ける
						end
					end
					if flg2 != 0
						break	# while文から抜ける
					end
					idx2 += 1
				end
				wd_ha = ''
				wd_v = ''
			end

			h_stack.push wd_an2		# 現在の階層をスタックに積む

			now_hiera = h_stack.join section_code	# 現在の階層の取得
			# 属性の名前の表示
			data.each do |key, value|
				case o_encoding
				when "EUC-JP"
#					puts now_hiera + atr_sec_code + Uconv.u8toeuc(key) + ' = [' + Uconv.u8toeuc(value) + ']'
					wd_ha = now_hiera + atr_sec_code + Uconv.u8toeuc(key)
					wd_v = Uconv.u8toeuc(value)
				when "Shift_JIS"
#					puts now_hiera + atr_sec_code + Kconv::tosjis(Uconv.u8toeuc(key)) + ' = [' + Kconv::tosjis(Uconv.u8toeuc(value)) + ']'
					wd_ha = now_hiera + atr_sec_code + Kconv::tosjis(Uconv.u8toeuc(key))
					wd_v = Kconv::tosjis(Uconv.u8toeuc(value))
#				when "UTF-8"
#					wd_ha = now_hiera + atr_sec_code + key
#					wd_v = value
				end
				h_stack_o.push wd_ha
				v_stack_o.push wd_v
			end
		when XMLParser::END_ELEM
			h_stack.pop		# 元の階層に戻す
			now_hiera = h_stack.join section_code	# 現在の階層の取得
		when XMLParser::CDATA
			case o_encoding
			when "EUC-JP"
				c_data = Uconv.u8toeuc data
			when "Shift_JIS"
#				c_data = Uconv.u8toeuc data
#				c_data = Kconv::tosjis c_data
				c_data = Kconv::tosjis(Uconv.u8toeuc(data))
#				c_data = Uconv.u8tosjis data
#			when "UTF-8"
#				c_data = data
			end
			c_data = ''		if c_data == nil
			c_data.strip!
#			if c_data.strip != ''
#				puts now_hiera + ' = [' + c_data + ']'
				h_stack_o.push now_hiera
				v_stack_o.push c_data
#			end
			# 空白スタックを含めないと、配列化に支障があるので、空白もセット
		when XMLParser::PI
#		when XMLParser::START_DOCTYPE_DECL
#		when XMLParser::END_DOCTYPE_DECL
		when XMLParser::DEFAULT
		else
		end
	end
	del_idx = []	# 削除インデックスの格納場所
	h_stack_o.each_index do |e_i|
		wd_v = v_stack_o[e_i]
		if wd_v == ''
			del_idx.unshift(e_i)	# 最後のデータを、前からセットしていく
		end
	end
	del_idx.each do |e_i|
		h_stack_o.delete_at(e_i)
		v_stack_o.delete_at(e_i)
	end

	ret = []
	h_stack_o.each_index do |e_i|
		ret.push [h_stack_o[e_i], v_stack_o[e_i]]
	end

	return ret
end



# =============================================================================


# 階層情報表示処理
#    引数
# in_xml        - 入力XML文書 [IN / String型]
# section_code  - 階層を区分するコード [IN / String型]
# atr_sec_code  - 階層名と属性を区分するコード [IN / String型]
# out_word_code - 出力文字コード [IN / String]
#                    '1' - EUCコード
#                    '2' - シフトJISコード
# show_mode     - 表示モード [IN / Numeric型 / デフォルト値 = 0]
#                   1 - データ作成向け表示モード
#                   2 - 階層名のみの表示モード
#                  10 - デバッグ向けの表示モード
#    戻り値
# なし
#    備考
#
def print_hierarcy(in_xml, section_code, atr_sec_code, out_word_code, show_mode = 10)

	hiera = []

	# 階層情報の取得
	hiera = get_xml_hierarcyinfo(in_xml, section_code, atr_sec_code, out_word_code)

	# 階層情報の表示
	case	show_mode
	when	1
		hiera.each do |e|
			# 名称・値スタック領域の表示
			$stdout.puts e[0] + " = " + e[1] + "\n"
		end
		$stderr.puts '表示処理が終了しました'
	when	2
		hiera.each do |e|
			# 名称スタック領域の表示
			$stdout.puts e[0] + "\n"
		end
		$stderr.puts '表示処理が終了しました'
	when	10
		hiera.each do |e|
			$stdout.puts '-' * 78
			# 名称・値スタック領域の表示
			$stdout.puts "[" + e[0] + "]\n" + e[1] + "\n"
		end
		$stderr.puts '表示処理が終了しました'
	end


	nil
end



# =============================================================================


# 該当階層のパラメータの取得
#    引数
# param_data - パラメーターデータ [IN / String型]
# hierarcy   - 階層名 [IN / String型]
#    戻り値
# パラメータ名(nilの場合、見つからなかった)
#    備考
#
def get_hierarcy_parameter(param_data, hierarcy)
	# 「(」や「)」の正規表現判定がうまくいかないので、変換
	w_h = hierarcy.clone
	d_gsub = [['\(', '\\('], ['\)', '\\)']]
	d_gsub.each do |e1|
		w_h.gsub! /#{e1[0]}/, e1[1]
	end
#	w_h = hierarcy.gsub /\(/, '\\('
#	w_h = w_h.gsub /\)/, '\\)'
	ret = ''
#	if param_data =~ /#{w_h}/
	if param_data =~ /^\s*?#{w_h}\s*?=\s*?(\S*?)\s*?$/
		# $1にパラメータ名が入っている
		ret = $1
		ret = ''		if ret == nil
		ret.strip!
		ret = nil		if ret == ''
	else
		# 階層名が見つからなかったので、パラメータはなし
		ret = nil
	end
	return ret
end



# =============================================================================


# 抽象形式等の階層名を、正規表現形式にする
#    引数
# mode    - 1固定 [IN]
#   0 - 単純に正規表現に使える形式にする
#   1 - 抽象形式の階層名を正規表現形式にする
# in_name - 階層名 [IN]
#    戻り値
# 正規表現形式の階層名
def exchange_hierarcy_name(mode, in_name)
	case	mode
	when	0, 1
		# 「(」や「)」の正規表現判定がうまくいかないので、変換
		h_name = in_name.clone
		d_gsub = [['\(', '\\('], ['\)', '\\)']]
		d_gsub.each do |e1|
			h_name.gsub! /#{e1[0]}/, e1[1]
		end

		if mode == 1
			# 検索階層名の不定配列の記述部分を正規表現の形式に変換
			h_name.gsub! /\\\([xX]\\\)/, '\\([0-9]+?\\)'
		end
	end

	return h_name
end



# =============================================================================


# 指定階層の階層情報からの検索
#    引数
# h_name   - 検索階層名 [IN / String型]
# hierarcy - 階層情報 [IN / 2階層配列(String)型]
#    戻り値
# 以下の配列型
# [0] - 階層名
# [1] - 階層の値
# nilの場合、見つからなかった
#    備考
# 「h_name」は、抽象的な名前が使用可能である
def search_hierarcy_data(h_name, hierarcy)
	ret = []

	# 階層名を、抽象階層名から、正規表現形式階層名に変換
	find_hierarcy = exchange_hierarcy_name(1, h_name)

#	# 「(」や「)」の正規表現判定がうまくいかないので、変換
#	find_hierarcy = h_name.clone
#	d_gsub = [['\(', '\\('], ['\)', '\\)']]
#	d_gsub.each do |e1|
#		find_hierarcy.gsub! /#{e1[0]}/, e1[1]
#	end
#
#	# 検索階層名の不定配列の記述部分を正規表現の形式に変換
#	find_hierarcy.gsub! /\\\([x]\\\)/, '\\([0-9]+?\\)'


	# 配列に対して、eachを活用して、正規表現検索を繰り返す
	hierarcy.each do |e1|
		if e1[0] =~/^#{find_hierarcy}$/
			ret.push e1
		end
	end

	ret = nil		if ret.size == 0

	return ret
end



# =============================================================================


# 正規表現に使える文字列への変換関数
#    引数
# mode - 変換モード [IN]
#  現在、modeは予約で、0固定とする
# word - 変換対象文字列 [IN / String型]
#    戻り値
# 変換後文字列
def exchange_regular_expression(mode, word)
	w_d = word.clone

	d_gsub = [['\(', '\\('], ['\)', '\\)'], ['\$', '\\$'], ['\=', '\\=']]
	d_gsub.each do |e1|
		w_d.gsub! /#{e1[0]}/, e1[1]
	end


	return w_d
end



# =============================================================================


# パラメータデータのLineTargetマクロ処理
#    引数
# param_data - パラメータデータ [IN / String型]
# h_data - 階層情報データ [IN / 2階層配列(String)型]
#    戻り値
# nil - エラーが発生した
# 変換後のパラメータデータ
def exec_param_LineTagetMacro(param_data, h_data)


# 	# ****************************************
# 	$stderr.puts	'*' * 78
# 	$stderr.puts	'デバッグ開始(exec_param_LineTagetMacro)'
# 	dbg_ary = search_hierarcy_data('Mml(1)~MmlHeader(1)~toc(1)~tocItem(x)', h_data)
# 	if dbg_ary != nil
# 		dbg_ary.each do |dbg_e|
# 			$stderr.puts '[' + dbg_e[0] + ']=[' + dbg_e[1] + ']'
# 		end
# 	else
# 		$stderr.puts	'nilが返ってきました'
# 	end
# 	$stderr.puts	'デバッグ終了(exec_param_LineTagetMacro)'
# 	$stderr.puts	'*' * 78
# 	# ****************************************
# 
# 
# 	return param_data



# 上記は、テスト的に実行しているもの
# 完成したら、上記のコードを削除してください。

	# LineTargetマクロの実行
	p_word = param_data.clone

	while p_word =~ /^(\s*?\$LineTargetStart\s*?,\s*?(\S+?)\s*?,(.+?)\n)/i or p_word =~ /^(\s*?\$LTStart\s*?,\s*?(\S+?)\s*?,(.+?)\n)/i

		# マクロ命令がパラメータデータに存在する
		# $1 = マクロ命令が出現した行
		# $2 = マクロのシンボル名
		# $3 = シンボル名から後のパラメータ情報
		macro_startline = $1
		macro_symbol = $2
		macro_param = $3


		# マクロ命令の終了位置の取得
		if p_word =~ /^(\s*?\$LineTargetEnd\s*?,\s*?#{macro_symbol}\s*?\n)/i or p_word =~ /^(\s*?\$LTEnd\s*?,\s*?#{macro_symbol}\s*?\n)/i
			# $1 = 終了マクロ命令が出現した行
			macro_endline = $1
		else
			$stderr.puts '終了マクロが存在しません (シンボル名 = ' + String(macro_symbol) + ')'
			exit 2
		end

		# 取得した内容を、正規表現で使えるように変換
		macro_startline = exchange_regular_expression(0, macro_startline)
		macro_endline = exchange_regular_expression(0, macro_endline)

		r1_word = ''
		r2_word = ''
		if p_word =~ /(#{macro_startline}([\s\S]*?)#{macro_endline})/
			# $1 - 置換前対象
			# $2 - 置換後対象
			r1_word = $1.clone			# 置換前内容の格納領域
			r2_word = $2.clone		# 置換後内容の格納領域
		end

		# パラメータ情報の取得
		arg1 = []
		arg1 = macro_param.split ','
		arg1.each_index do |ei1|
			# 各配列の空白削除処理
			arg1[ei1].strip!
		end

		base_hierarcy = arg1[0]			# 基準階層の取得
		mean_decision = arg1[1]			# 判定方法
		decision_hierarcy = arg1[2]		# 判定階層
		decision_value = arg1[3]		# 判定内容
		arg_num = Integer(arg1[4])		# 対象配列番号


		# +++++
		find_flg1 = 0	# 検索フラグ
		# +++++


		# 判定階層の名称と内容を取得
		arg2 = []
		arg2 = search_hierarcy_data(decision_hierarcy, h_data)
		if arg2 == nil or arg2.size == 0
			# +++++
			find_flg1 = 1	# 検索フラグのセット
			# +++++
#			$stderr.puts '階層データが存在しません (判定階層 = ' + String(decision_hierarcy) + ')'
#			exit 2
		end
		# 取得した内容と判定内容比較
		# +++++
		if find_flg1 == 0
		# +++++
			h_name_arg1 = []
			h_value_arg1 = []
			arg2.each do |e1|
				if e1[1] == decision_value
					# 取得内容と判定内容が一致したので、配列にセットする
					h_name_arg1.push e1[0]
					h_value_arg1.push e1[1]
				end
			end
			if h_value_arg1 == nil or h_value_arg1 == []
				# +++++
				find_flg1 = 2	# 検索フラグのセット
				# +++++
#				$stderr.puts '指定された階層に該当の内容が存在しません (判定階層 = ' + String(decision_hierarcy) + ') = (' + decision_value + ')'
#				exit 2
			end
		# +++++
		end
		# +++++


		# ターゲット配列の抽出
		# +++++
		if find_flg1 == 0
		# +++++
			h_name1 = ''
			h_value1 = ''
			h_name1 = h_name_arg1[arg_num]
			h_value1 = h_value_arg1[arg_num]
			if h_name1 == nil
				# +++++
				find_flg1 = 3	# 検索フラグのセット
				# +++++
#				$stderr.puts '指定された配列の階層に該当の内容が存在しません (判定階層 = ' + String(decision_hierarcy) + ') = (' + decision_value + ') (配列 = ' + String(arg_num) + ')'
#				exit 2
			end
		# +++++
		end
		# +++++


		# +++++
		if find_flg1 == 0
		# +++++
			# 階層が見つかった
			# この時点で、h_name1に該当する階層情報が入っている
			h_name2 = exchange_hierarcy_name(1, base_hierarcy)		# 基準階層を、変換する
			# 同じものが見つかった場合、基準階層の抽象表現を、実表現に変換する
			if h_name1 =~ /(#{h_name2})/
				# 基準階層の正規表現と判定階層が一致した
				h_name3 = $1	# 基準階層の実階層名の取得
				# 基準階層名と実階層名の置換処理
				r2_word.gsub! /#{exchange_regular_expression(0, base_hierarcy)}/, h_name3
				# 全体に対しての置換処理(ここが、実置換処理である)
#				p_word.gsub! /#{exchange_regular_expression(0, r1_word)}/, r2_word
#				p_word.gsub! Regexp.quote(r1_word), r2_word

				idx1 = 0
				idx1 = p_word.index r1_word		# 変換前文字列を検索する
				idx2 = r1_word.size
				idx3 = p_word.size
				p_word = p_word[0 .. (idx1 - 1)] + r2_word + p_word[(idx1 + idx2) ... idx3]


			else
				# 基準階層の正規表現と判定階層が一致しなかった
				$stderr.puts '判定階層は、基準階層の中になければなりません (判定階層 = ' + String(decision_hierarcy) + '), (基準階層 = ' + base_hierarcy + ')'
				exit 2
			end
		# +++++
		else
			# 階層が見つからなかった
			# 該当場所の内容を削除してしまう(階層がないとみなす)
#			p_word.gsub! /#{exchange_regular_expression(0, r1_word)}/, ''
			# 上記gsubを使うと、長すぎて異常終了するので、以下の方法で代用

			idx1 = 0
			idx1 = p_word.index r1_word		# 変換前文字列を検索する
			idx2 = r1_word.size
			idx3 = p_word.size
			p_word = p_word[0 .. (idx1 - 1)] + p_word[(idx1 + idx2) ... idx3]

		end
		# +++++
	end


	# 抽象階層情報を実階層情報に変換
	while p_word =~ /^\s*?(.*?\([xX]\).*?)\s*?=.*?\n/
		# $1 = 階層名
		w_hname = $1.strip
		r1_data = []
		r1_data = search_hierarcy_data(w_hname, h_data)
		if r1_data == nil or r1_data.size == 0
			# 指定された階層データは、存在しない
			$stderr.puts '指定された階層データは存在しません {' + String(w_hname) + ']'
			exit 2
		end
		r2_data = r1_data[0]
		w_hname = exchange_hierarcy_name(0, w_hname)	# 正規表現に使える形式に変換
		p_word.gsub! /#{w_hname}/, r2_data[0]	# 置換処理
	end


	return p_word
end



# =============================================================================


# 該当パラメータのデータ位置の取得
#    引数
# layout_data - レイアウト定義データ [IN / String型]
# param_name  - パラメータデータ [IN / String型]
#    戻り値
# [x][0] - 起点位置 (Integer型)
# [x][1] - 格納バイト数 (Integer型)
# nilの場合、該当パラメータが存在しない
#    備考
# レイアウト定義データのコメント等は、はずしてから実行してください
# また、equalマクロも、変換が終わってから実行してください
def get_parameter_seqpoint(layout_data, param_name)
	return nil		if param_name == nil

	ret = []
	layout_data.scan /^\s*?#{param_name}\s*?.*?$/ do |s|
		w_param1 = s.strip.split /\s*,\s*/	# 「,」で分ける
		case w_param1[1]
		when	nil		# データが入っていない
		when	'nowdate1'		# 今日の日付のセット(パターン1)
		when	'nowdate2'		# 今日の日付のセット(パターン2)
		when	'const'			# 固定データのセット
#		else			# 素直に項目のセット
		when	'0'		# 素直に項目のセット
#		when	'0', 'attribute'		# 素直に項目のセット
			# 位置情報の読み込み
			sp = w_param1[2]	# 開始位置(StartPoint)
#			if sp.class.name!='Fixnum'
				# 足し算やかけ算等がある場合、それに対処
				sp = eval(sp)
#			end
			wbyte = Integer(w_param1[3])		# 文字バイト数
			sp = Integer(sp)
			if wbyte != 0
				# バイト数が０バイトでなければ、戻り値の領域にセットする
				ret.push [sp, wbyte]
			end
		end
	end


	ret = nil		if ret.size == 0

	return ret
end



# =============================================================================


# 該当レイアウトデータの最大データ長の取得
#    引数
# layout_data - 配列型レイアウトデータ
#    戻り値
# 文字サイズ(nilの場合、取得に失敗)
#    備考
# 他のモジュールでも使用しているので、できれば、共通ライブラリに登録したい
# レイアウト定義データは、空白行等を削除してから、実行してください
def get_layout_maxrecordlength(layout_data)
	maxpoint = -1	# 最後尾項目位置
	maxsize = 0		# 最後尾項目の長さ
	ret = nil
#	w_layout = []
	w_layout = layout_data.split '\n'
#	wd1 = ''	# 文字列データとして初期化
	wd1 = []	# 配列データとして初期化
#	wbyte = 0
#	sp = 0
	w_layout.each do |e|
		wd1 = e.split /\s*,\s*/	# 配列に分ける
		case	wd1[1]
		when	nil		# データが入っていない
		when	'nowdate1'		# 今日の日付のセット(パターン1)
		when	'nowdate2'		# 今日の日付のセット(パターン2)
		when	'const'			# 固定データのセット
		when	'ifdef'
		when	'endif'
#		else			# 素直に項目のセット
		when	'0'		# 素直に項目のセット
#		when	'0', 'attribute'		# 素直に項目のセット
			if wd1[0]==nil or wd1[2]==nil or wd1[3]==nil
				ret = nil
#				break
				return
			else
				sp = wd1[2]	# 開始位置(StartPoint)
#				if sp.class.name!='Fixnum'
					# 足し算やかけ算等がある場合、それに対処
					sp = eval(sp)
#				end
				wbyte = Integer(wd1[3])		# 文字バイト数
				sp = Integer(sp)
				if maxpoint < sp
					maxpoint = sp
					maxsize = wbyte
					ret = maxpoint + maxsize
				end
			end
		end
	end
	ret
end



# =============================================================================


# 該当階層のパラメータのセット
#    引数
# in_xml        - 入力XML文書 [IN / String型]
# section_code  - 階層を区分するコード [IN / String型]
# atr_sec_code  - 階層名と属性を区分するコード [IN / String型]
# param_data    - パラメーターデータ [IN / String型]
# layout_data   - レイアウト定義データ [IN / String型]
# h_file        - 階層情報の出力ファイル名 [IN / String型]
# out_word_code - 出力文字コード [IN / String型]
#                    '1' - EUCコード
#                    '2' - シフトJISコード
#    戻り値
# シーケンシャルデータ
#    備考
# h_fileが空白等の場合、階層情報は出力しません
def set_sequenth_xmldata(in_xml, section_code, atr_sec_code, param_data, layout_data, h_file, out_word_code)

	h_data = []		# 階層情報領域
	seq_maxsize = 0	# シーケンシャルファイルの最大サイズの取得
	seq_data = ''	# シーケンシャルデータ領域
	w_data1 = ''	# 文字列の一時的な領域


	# レイアウト定義データの初期化
	$stderr.puts	'equalマクロの展開中です'
	# レイアウトデータのうち、equalマクロ情報を展開
	macro_execute_equal(layout_data)
	$stderr.puts	'equalマクロの展開が終了しました'


	# シーケンシャルファイルのデータ長の取得
	seq_maxsize = get_layout_maxrecordlength(layout_data)
	if seq_maxsize == nil
		$stderr.puts 'レイアウト定義データの取得に失敗しました'
		exit 2
	end
#	$stderr.puts	'データ長 = [' + String(seq_maxsize) + ']'

	seq_data = ' ' * seq_maxsize	# シーケンシャルデータ領域の確保


	# 階層情報の取得
	$stderr.puts	'階層情報の取得中です'
	h_data = get_xml_hierarcyinfo(in_xml, section_code, atr_sec_code, out_word_code)
	$stderr.puts	'階層情報を取得しました'


	if h_file != '' and h_file != nil
		# 階層情報の出力
		open(h_file, 'w') do |fp|
			h_data.each do |e_h|
				fp.puts '<' + e_h[0] + '> = [' + e_h[1] + ']'
			end
		end
	end


	# パラメータ情報のコメントや空白行の削除
	record_del_comment_space(param_data)


	$stderr.puts	'LineTargetマクロの処理中です'
	# パラメータデータのLineTargetマクロ処理
	param_data = exec_param_LineTagetMacro(param_data, h_data)
	$stderr.puts	'LineTargetマクロの処理が終了しました'


	$stderr.puts	'階層情報・定義情報を元に、シーケンシャルデータの作成中です'
	# 階層情報分、繰り返す
	h_data.each do |e1|
		# [0] = 階層名, [1] = 値
		# 該当階層のパラメータ名の取得
		p_name = get_hierarcy_parameter(param_data, e1[0])
		if p_name != nil
			# 該当パラメータは存在する
			seq_pnt = []
			# 起点位置や格納バイト数などの取得
			seq_pnt = get_parameter_seqpoint(layout_data, p_name)
			if seq_pnt != nil
				seq_pnt.each do |e2|
					# シーケンシャル領域へのセット
#					seq_data[e2[0], e2[1]] = e1[1]
					w_data1 = e1[1]
					if w_data1.size < e2[1]
						w_data1 = w_data1 + (' ' * (e2[1] - w_data1.size))
					else
						if w_data1.size > e2[1]
							$stderr.puts '該当文字は長すぎるので、値を切り捨てます' + "\n" + '切り捨て前[' + w_data1 + ']'
							w_data1 = w_data1[0, e2[1]]
							$stderr.puts '切り捨て後[' + w_data1 + ']'
						end
					end
					seq_data[e2[0], e2[1]] = w_data1
					# この時点で、途中でシーケンシャルデータに出力するバイト数が
					# 少なくなっている可能性があるので、サイズを補完する
					if seq_data.size < seq_maxsize
						seq_data = seq_data + (' ' * (seq_maxsize - seq_data.size))
					end
				end
			end
		end
	end
	$stderr.puts	'シーケンシャルデータの作成ができました'


	return seq_data
end



# =============================================================================




# ======================================================================

# ======================================================================


# =============================================================================
# main処理部


if __FILE__ == $0

	xml_data = ''

# 	xml_data = $stdin.read		# 標準入力から、xmlデータの読み込み

	if $in_xml != '' and $in_xml != nil
		open($in_xml, 'r') do |fp_x|
			xml_data = fp_x.read
		end
	end


	# -------------------------------------------------------------------------
	case	$exec_mode
	when	'1'
		# デコード実行
		layout_data = ''	# レイアウトデータ
		link_data = ''		# リンクデータ
		seq_data = ''		# シーケンシャルデータ

		# ファイルデータの読み込み
		open($layout_fname, 'r') do |fp_l|
			layout_data = fp_l.read
		end
		open($link_fname, 'r') do |fp_k|
			link_data = fp_k.read
		end


		# 該当階層のパラメータのセット
		seq_data = set_sequenth_xmldata(xml_data, '~', '!', link_data, layout_data, $hirarcy_fname, $out_word_code)

		# 標準出力へ内容を出力
		open($seq_fname, 'w') do |fp_o|
			fp_o.write seq_data
		end


	# -------------------------------------------------------------------------
	when	'2'
		# デコード結果の表示
		layout_data = ''	# レイアウトデータ
		link_data = ''		# リンクデータ
		seq_data = ''		# シーケンシャルデータ

		# ファイルデータの読み込み
		open($layout_fname, 'r') do |fp_l|
			layout_data = fp_l.read
		end
		open($link_fname, 'r') do |fp_k|
			link_data = fp_k.read
		end


		# 該当階層のパラメータのセット
		seq_data = set_sequenth_xmldata(xml_data, '~', '!', link_data, layout_data, $hirarcy_fname, $out_word_code)

		# 標準出力へ内容を出力
		$stdout.print seq_data
	# -------------------------------------------------------------------------
	when	'11'
		# 表示モード Type1
		print_hierarcy(xml_data, '~', '!', $out_word_code, 1)
# 		print_hierarcy(xml_data, '+', '@', $out_word_code, 1)
	# -------------------------------------------------------------------------
	when	'12'
		# 表示モード Type2
		print_hierarcy(xml_data, '~', '!', $out_word_code, 2)
# 		print_hierarcy(xml_data, '+', '@', $out_word_code, 2)
	# -------------------------------------------------------------------------
	when	'13'
		# 表示モード Type3
		print_hierarcy(xml_data, '~', '!', $out_word_code, 10)
# 		print_hierarcy(xml_data, '+', '@', $out_word_code, 10)
	# -------------------------------------------------------------------------
	else
		$stderr.puts '「$exe_mode」の値が不正です'
		exit 2
	end


	exit 0	# ここで終了させる

end


