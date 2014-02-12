#!/usr/bin/ruby
# coding : euc-jp
Encoding.default_external = "euc-jp" unless RUBY_VERSION == "1.8.7"



# Claim設定ファイルコンバータ(2003年夏バージョン)
# 旧形式データの互換性のために作成

# Repeat構文に対応したもの


# 既存の設定ファイル形式への変換時の引数指定

# claim_convert.rb -D [入力defファイル] [出力defファイル]
# claim_convert.rb -X [入力xmlファイル] [出力xmlファイル]
# claim_convert.rb -H [入力階層データファイル] [出力defファイル] [出力階層パラメータリンクファイル]


# ヘルプメッセージ
# claim_convert.rb --help
#
#
# 現在作業中
# なし
#
# 修正履歴
# 2003/06/27・defファイルの属性指定の並びをわかりやすくする。（COBOLのINCファイルにしやすくする）
# 2003/07/11 - 旧形式のファイルから新形式のファイルへの移行を考慮し、ヘッダ情報を追加する
# 2003/07/11 - 階層情報の旧形式への2ファイル分離処理を高速化(1時間を20秒に短縮(180倍の高速化))
#


# ※注意
# "〜"や'〜'の中に「,」が入っていた場合、正しい処理ができないので、注意すること
# $BaseStartと$Repeatでは、$Repeatを優先してしまうので、注意すること
# XMLの場合、EUCコード固定としている。UTF-8のXML等を変換する場合は、変換してから実行すること
# $define定義は、文字列の定義はできませんので、注意してください。（値の定義はできます）



if __FILE__ == $0


# =============================================================================
# デバッグ対応

	# デバッグ用引数指定
	debug_argv_set = 0	# デバッグではない
#	debug_argv_set = 1	# defファイルの既存への変換でのデバッグ
#	debug_argv_set = 2	# xmlテンプレートファイルの既存への変換でのデバッグ
#	debug_argv_set = 3	# 階層データファイルの既存への変換でのデバッグ
#	debug_argv_set = 13	# 階層データファイルのver2形式への変換でのデバッグ



	DEBUG = 0		# デバッグではない
#	DEBUG = 1		# デバッグメッセージを有効にする




# =============================================================================
# 定数の指定

# defファイルの既存形式への変換である
CONV_MODE_EXISTING_DEF = 1
# XMLテンプレートファイルの既存形式への変換である
CONV_MODE_EXISTING_XML = 2
# 階層データファイルの既存形式への変換である
CONV_MODE_EXISTING_HIR = 3
# Repeat定義の変換である
CONV_MODE_REPEAT = 4

# defファイルのver2形式への変換である
# CONV_MODE_VER200_DEF = 11
# XMLテンプレートファイルのver2形式への変換である
# CONV_MODE_VER200_XML = 12
# 階層データファイルのVER2形式への変換である
CONV_MODE_VER200_HIR = 13


# =============================================================================
# 引数の判定


	argv_size = 0	# ARGVの大きさ
	argv_size = ARGV.size

	help_flg = 0	# ヘルプ表示させるかのフラグ


	argv_f = []		# 引数で指定したファイル名を格納する領域
	conv_mode = 0	# 変換モード(1 = defファイル, 2 = XMLテンプレートファイル, 3 = 階層データファイル)


	case	debug_argv_set
	when	1
		# defファイルの既存への変換でのデバッグ
		argv_f.push 'test001.def'			# テスト実行時に読み込むファイル名
		argv_f.push 'test001out.def'		# テスト実行時の出力ファイル名
		conv_mode = CONV_MODE_EXISTING_DEF
	when	2
		# xmlテンプレートファイルの既存への変換でのデバッグ
		argv_f.push 'test002.xml'			# テスト時に読み込むXMLテンプレートファイル名
		argv_f.push 'test002out.xml'		# テスト時に出力するXMLテンプレートファイル名
		conv_mode = CONV_MODE_EXISTING_XML
	when	3
		# 階層データファイルの既存への変換でのデバッグ
		argv_f.push 'test003.hir'			# テスト時に読み込む階層データファイル名
		argv_f.push 'test003out.def'		# テスト時に出力するdefファイル名
		argv_f.push 'test003out.link'		# テスト時に出力する階層パラメータリンクファイル名
		conv_mode = CONV_MODE_EXISTING_HIR
	when	13
		# 階層データファイルのver2形式への変換でのデバッグ
		argv_f.push 'testa013.hir'			# テスト時に読み込む階層データファイル名
		argv_f.push 'testa013exe.hir'		# テスト時に出力する実行時階層データファイル名
		conv_mode = CONV_MODE_VER200_HIR
	end



	if argv_size != 0
		ARGV.each do |x|
			case	x
			when	'--help'
				# ヘルプメッセージを表示させる
				help_flg = 1
			when	'-D'
				# defファイルの既存形式への変換である
				conv_mode = CONV_MODE_EXISTING_DEF
			when	'-X'
				# XMLテンプレートファイルの既存形式への変換である
				conv_mode = CONV_MODE_EXISTING_XML
			when	'-H'
				# 階層データファイルの既存形式への変換である
				conv_mode = CONV_MODE_EXISTING_HIR
			when	'-h'
				# 階層データファイルのver2形式への変換である
				conv_mode = CONV_MODE_VER200_HIR
			when	'-r'
				# Repeat定義の変換である
				conv_mode = CONV_MODE_REPEAT
			else
				# ファイルの指定
				argv_f.push x	# ファイルリストにpushする
			end
		end
	else
		# 引数が指定されていない
		if debug_argv_set == 0
			help_flg = 1
		end
	end



	if help_flg == 1
		# ヘルプメッセージの表示
		mes = ''
		mes += __FILE__ + ' [opt] [ファイル名...]' + "\n"
		mes += '    -D [入力defファイル] [出力defファイル]' + "\n"
		mes += '        defファイルの既存形式への変換' + "\n"
		mes += '    -X [入力xmlファイル] [出力xmlファイル]' + "\n"
		mes += '        xmlテンプレートファイルの既存形式への変換' + "\n"
		mes += '    -H [入力階層データファイル] [出力defファイル] [出力階層パラメータリンクファイル]' + "\n"
		mes += '        階層データファイルの既存形式への変換' + "\n"
		mes += '    -h [入力階層データファイル] [出力階層データファイル]' + "\n"
		mes += '        階層データファイルのver2形式への変換' + "\n"
		mes += "\n"
		mes += __FILE__ + ' --help' + "\n"
		mes += '    ヘルプの表示' + "\n"
		mes += "\n"
		mes += "\n"

		$stdout.print	mes
		exit 0
	end



	case	conv_mode
	when	0
		puts '引数に変換のしかたが指定されていません'
		exit 10
	when	CONV_MODE_EXISTING_DEF
		# defファイルの変換である
		if argv_f.size != 2
			puts '引数に、入力defファイルと出力defファイルの２つを指定してください'
			exit 10
		end
	when	CONV_MODE_EXISTING_XML
		# XMLテンプレートファイルの変換である
		if argv_f.size != 2
			puts '引数に、入力xmlテンプレートファイルと出力xmlテンプレートファイルの２つを指定してください'
			exit 10
		end
	when	CONV_MODE_EXISTING_HIR
		# 階層データファイルである
		if argv_f.size != 3
			puts '引数に、入力階層データファイルと出力defファイルと出力階層パラメータリンクファイルの３つを指定してください'
			exit 10
		end
	when	CONV_MODE_REPEAT
		# Repeat定義の変換である
		if argv_f.size != 2
			puts '引数に、入力ファイルと出力ファイルの２つを指定してください'
			exit 10
		end
	when	CONV_MODE_VER200_HIR
		# 階層データファイルのver2形式への変換である
		if argv_f.size != 2
			puts '引数に、入力階層データファイルと出力階層データファイルの２つを指定してください'
			exit 10
		end
	else
		puts '実行時エラーです'
		exit 10
	end



end



# =============================================================================


# Repeat定義処理
#    引数
# in_data - Repeat定義が存在すると思われる文字列 (String型/IN)
#    戻り値
# Repeat展開した文字列 (String型/OUT)
#
def repeat_extend_proc(in_data)
	# ネストしたRepeat定義へ対応できるように、前処理
	# この段階で、何回Repeat定義の処理をするかも確定する。（これで、次のwhile文をfor文に変更する）
	# ネストに対応する際に、Repeat定義の名前を変更するので、
	#   変更した名前をスタックして、あとでシフトで取り出せるようにすること
	# 識別子を加えると、「$Repeat」から「$REPEAT_1」になるようにする
	# まず、配列化し、その後にマージして対応する（concat処理は重いと聞いているが・・・）
	w_data1 = []	# 配列化データ領域
	w_data2 = ''	# 一時的な文字列領域
	w_data3 = []

	repeat_indexname1 = []	# Repeat定義の識別名のみを格納する場所（あとでfor文で使用）
	repeat_indexname2 = []	# Repeat定義の識別名のみを格納するスタック領域（ワーク用）
	repeat_indexcount = 0	# repeat定義にセットする識別子のカウント用

	# 識別子は、「_」を付けた、可変長数字をセットする

	w_data1 = in_data.split("\n")	# Repeat定義に対応できるように配列化
	w_data1.each_index do |x|
		w_str1 = ''
		w_str2 = ''
		if w_data1[x] =~ /^\s*?(\$Repeat)\s*?,/i
			repeat_indexcount += 1		# カウント値をあらかじめ＋１する
			w_str1 = ''
			w_str1 = '_' + String(repeat_indexcount)
			repeat_indexname2.push w_str1
			repeat_indexname1.push w_str1
			w_data1[x].gsub!(/^(\s*?\$Repeat)(\s*?,)/i, '\1' + w_str1 + '\2')
		end


		if w_data1[x] =~ /^\s*?(\$EndRepeat)\s*?/i
			if repeat_indexname2.size == 0
				# $Repeatがない$EndRepeatがある
				puts '関連する$Repeatのないの$EndRepeat定義があります'
			end
			w_str2 = repeat_indexname2.pop	# 対応する識別子を取得
			w_data1[x].gsub!(/^(\s*?\$EndRepeat)(\s*?)/i, '\1' + w_str2 + '\2')
		end

	end


	if repeat_indexname2.size > 0
		# $EndRepeatがない$Repeatがある
		puts '$EndRepeat定義がない$Repeat定義が存在します'
	end


	w_data2 = w_data1.join("\n")
	w_data1 = []


	# Repeat定義処理(1) [ネスト対応版]
	repeat_indexname1.each do |rname|
		repeat_alldata = ''		# Repeat定義を含めた全体の文字列
		repeat_count = 0		# 繰り返し回数
		repeat_string = ''		# 置換対象文字列
		repeat_figures = 0		# 桁数指定(0の場合、自由桁数)
		repeat_target = ''		# 繰り返しターゲット領域
		repeat_figformat = ''	# 桁数をsprintfで表現する際の表現を格納する領域

		if w_data2 =~ /^(\s*?\$Repeat#{rname}\s*?,[\s\S]*?)\n/
			w_data3 = $1.split(',')
			if (w_data3.size != 4)
				puts 'Repeat定義の中で、引数の指定が3つではないものがあります'
			end
		end


		while w_data2 =~ /^(\s*?\$Repeat#{rname}\s*?,\s*?([0-9]+?)\s*?,\s*?(\S+?)\s*?,\s*?([0-9]+?)[\s\S]*?\n([\s\S]*?)^\s*?\$EndRepeat#{rname}[\s\S]*?)\n/i
			# $1 = $Repeat定義の開始行から終了行までの全体
			# $2 = 繰り返し回数
			# $3 = 置換対象文字列
			# $4 = 桁数指定(0の場合、自由桁数)
			# $5 = 繰り返し・置換ターゲット領域
			repeat_alldata = $1
			repeat_count = $2.to_i	# 繰り返し回数を数値に変換してセット
			repeat_string = $3
			repeat_figures = $4.to_i	# 桁数を数値に変換
			repeat_target = $5

			if repeat_figures == 0
				repeat_figformat = '%d'
			else
				repeat_figformat = '%0' + String(repeat_figures) + 'd'
			end

			put_data = ''	# セットデータの格納領域
			for x in 1..repeat_count do
				put_data += repeat_target.gsub(/#{Regexp.quote(repeat_string)}/, sprintf(repeat_figformat, x))
			end

			# Repeat定義の置換処理
			w_data2.gsub!(/#{Regexp.quote(repeat_alldata)}/, put_data)
			put_data = ''
		end

	end

	return w_data2
end


# =============================================================================


# defデータのコンバート処理
#    引数
# in_data - コンバート前のdefデータ (String型)
#    戻り値
# コンバート後のdefデータ ((String型の)配列型)
#    備考
# このコンバート処理は、既存の形式に変換するものです。
# 後に高速化対応のため、別のシンプルな形式に変換するものに変更する
def def_conversion_proc_a(in_data)
	out_data1 = []
	if_stack1 = []		# if文用のスタック領域(「IF_識別番号」の形式)
	if_count1 = 0		# if文に識別子を割り当てるためのカウント領域
	offset_count1 = 0	# パラメータ情報のオフセット値のカウント領域


	data2 = in_data.split("\n")		# 入力データの配列化


	data2.each do |x|
		w_str1 = ''			# 文字列用ワーク領域
		w_str2 = ''

		x1 = x
		if x1 =~ /^\s*?\#/
			# コメント行は、空白にする。
			x1 = ''
			# ※変更時は「#$ type=figure-define version=2.0 encoding=EUC-JP」が出てきた場合のことも考えること
		end
		if x1 == nil or x1 == ''
			x1 == ''
		else
#			out_data1.push x
			w_data1 = []	# 「,」で区切った配列領域の初期化
			w_data1 = x.split(',')
			# 空白除去処理
			w_data1.each_index do |i|
				w_data1[i].strip!
			end
			w_data2 = []
			# ----------------------------------------
			case	(w_data1[0].gsub /\s*?\#[\S\s]*?$/, '')
#			case	w_data1[0]
			when	'$define'
				#define文である
				w_data2.push w_data1[1]
				w_data2.push 'equal'
				w_str1 = w_data1[2].gsub /\s*?\#[\S\s]*?$/, ''
				w_data2.push w_str1
#				w_data2.push w_data1[2]
			# --------------------
			when	'$const'
				# const文である
				w_data2.push w_data1[1]
				w_data2.push 'const'
				w_str1 = w_data1[2].gsub /\s*?\#[\S\s]*?$/, ''
				w_data2.push w_str1
#				w_data2.push w_data1[2]
			# --------------------
			when	'$nowdate'
				# nowdate文である
				w_str1 = w_data1[2].gsub /\s*?\#[\S\s]*?$/, ''
				case	w_str1
#				case	w_data1[2]
				when	'%Y-%m-%d'
					w_data2.push w_data1[1]
					w_data2.push 'nowdate1'
				when	'%Y-%m-%dT%H:%M:%S'
					w_data2.push w_data1[1]
					w_data2.push 'nowdate2'
				else
					# 他のフォーマット（現在未対応）
					puts '現在、nowdateの引数に指定できるのは「%Y-%m-%d」と「%Y-%m-%dT%H:%M:%S」です'
				end
			# --------------------
			when	'$ifdef'
				# ifdef文である
				if_count1 += 1		# if文スタックを加算
				w_str1 = 'IF_' + String(if_count1)
				if_stack1.push w_str1
				w_data2.push w_str1
				w_data2.push 'ifdef'
				# ここで、引数2のチェックができる
				w_data2.push w_data1[1]
				# ここで、引数3以降引数があるかのチェックができる
				for lcnt1 in 2..(w_data1.size - 1) do
					if lcnt1 != (w_data1.size - 1)
						# 一番最後の引数ではない
						w_data2.push w_data1[lcnt1]
					else
						# 一番最後の引数である
						w_data2.push((w_data1[lcnt1].gsub /\s*?\#[\S\s]*?$/, ''))
					end
				end
			# --------------------
			when	'$endif'
				# endif文である
				# ここで、if_stack1の数を見て、ifdef文がないのにendif文があるかのチェックができる
				w_data2.push if_stack1.pop
				w_data2.push 'endif'
			# --------------------
			else
				# 通常のパラメータである
				case	w_data1.size
				when	2
					# 通常のパラメータ
					w_data2.push w_data1[0]
					w_data2.push '0'
					w_data2.push String(offset_count1)
					w_str1 = w_data1[1].gsub /\s*?\#[\S\s]*?$/, ''
					w_data2.push w_str1
					offset_count1 += Integer(w_str1)
#					w_data2.push w_data1[1]
#					offset_count1 += Integer(w_data1[1])
				when	3
					# 属性のパラメータ
					w_data2.push w_data1[0]
					w_data2.push '0'
					w_data2.push String(offset_count1)
					w_str1 = w_data1[1].gsub /\s*?\#[\S\s]*?$/, ''
					w_data2.push w_str1
					w_data2.push ''
					w_str2 = w_data1[2].gsub /\s*?\#[\S\s]*?$/, ''
					w_data2.push w_str2
#					w_data2.push w_data1[2]
					offset_count1 += Integer(w_str1)
#					w_data2.push w_data1[1]
#					w_data2.push ''
#					w_data2.push w_data1[2]
#					offset_count1 += Integer(w_data1[1])
				else
					# 無効なパラメータ
					puts 'パラメータ値の指定が無効です'
					w_data1.each do |y1|
						print '[' + y1 + ']  '
					end
					puts ''
				end
			end
			# ----------------------------------------
			out_data1.push w_data2.join(',')
			w_data2 = []
		end
	end



	return out_data1
end


# =============================================================================


# 相対パスを絶対パスに変換
#    引数
# soc_path  - 比較対象パス (String型/IN)
# base_path - 相対パス時のベースパス(String型/IN)
#    戻り値
# 絶対パス (String型/OUT)
#    備考
# コメントや定義のはじめである「#」「$」で始まるものについては、この関数での処理はしません
def exchange_absolute_path(soc_path, base_path)

	if soc_path =~ /^\s*?\#/
		# コメントである
		w_path = soc_path
	elsif soc_path =~ /^\s*?[^\$\#]/
		# 通常の行
		if soc_path =~ /^(\s*?)\.(\/[\s\S]*?)$/
			# 相対アドレス指定である(./指定あり)
			w_path = $1 + base_path + $2
		elsif soc_path =~ /^(\s*?)([^\/\s][\s\S]*?)$/
			# 相対アドレス指定である(./指定なし)
			w_path = $1 + base_path + '/' + $2
		else
			# 絶対アドレス指定である
			w_path = soc_path
		end
	else
		# 定義である
		w_path = soc_path
	end

	return w_path

end


# =============================================================================


# 階層データのbase定義処理
#    引数
# in_data - base定義処理対象文字列 (String型/IN)
#    戻り値
# base定義処理後の文字列 (String型/OUT)
#    備考
def basehierarchy_extend_proc(in_data)

# ネストに対応できるようにすること
# そのため、BaseStartとBaseEndの識別子をあらかじめ加えること。
# また、ベース階層の出入りでスタック操作をする
# gsubでの一気の変換はせず、行単位で該当するベース階層の置換処理を行うようにする。
#   （そうしないと、ネストへの対応ができない）


	# 識別子設定処理
	# ネストしたBase定義へ対応できるように、識別子を設定する前処理
	w_data1 = []	# 配列化データ領域
	w_data2 = ''	# 一時的な文字列領域
	w_data3 = []	# LineTarget命令で使用する配列データ領域

#	base_indexname1 = []	# Base定義の識別名のみを格納するスタック領域（Base定義展開時用）
	base_indexname2 = []	# Base定義の識別名のみを格納するスタック領域（識別名セット時用）
	base_indexcount = 0		# Base定義にセットする識別子のカウント用

	# 識別子は、「_」を付けた、可変長数字をセットする

	w_data1 = in_data.split("\n")	# Base定義に対応できるように配列化
	w_data1.each_index do |x|
		w_str1 = ''
		w_str2 = ''
		if w_data1[x] =~ /^\s*?(\$BaseStart)\s*?,/i
			base_indexcount += 1		# カウント値をあらかじめ＋１する
			w_str1 = ''
			w_str1 = '_' + String(base_indexcount)
			base_indexname2.push w_str1
			w_data1[x].gsub!(/^(\s*?\$BaseStart)(\s*?,)/i, '\1' + w_str1 + '\2')
		end

		# ここでエラーチェックができる（$BaseStartがない$BaseEndがある）

		if w_data1[x] =~ /^\s*?(\$BaseEnd)\s*?/i
			w_str2 = base_indexname2.pop	# 対応する識別子を取得
			w_data1[x].gsub!(/^(\s*?\$BaseEnd)(\s*?)/i, '\1' + w_str2 + '\2')
		end

	end


	# ここでエラーチェックができる ($BaseEndがない$BaseStartがある)


	base_indexname2 = []
	hierarchy_stack = []
	now_hierarchy = ''		# 現在のディレクトリ
	w_str1 = ''

#	base_indexname1.push w_str1

	# base定義実行処理
	w_data1.each_index do |x|
		if w_data1[x] =~ /^\s*?\$BaseStart(\_[0-9]+?)\s*?,\s*?([\s\S]*?)\s*?$/i
			# BaseStart定義
#			base_indexname1.push $1
			w_str1 = $2
			hierarchy_stack.push now_hierarchy
			if w_str1 =~ /^\s*?\//
				now_hierarchy = w_str1.strip
			elsif w_str1 =~ /^\s*?\.\/([\s\S]*?)$/
				now_hierarchy += '/' + $1.strip
			elsif w_str1 =~ /^\s*?([^\/][\s\S]*?)$/
				now_hierarchy += '/' + $1.strip
			end
			now_hierarchy.gsub! /\/$/, ''		# 末尾に「/」を付けていたら、はずす
		elsif w_data1[x] =~ /^\s*?\$BaseEnd(\_[0-9]+?)\s*?$/i
			# BaseEnd定義
#			base_indexname1.pop
			now_hierarchy = hierarchy_stack.pop
# base_indexname1を使うと思ったが、実際は使う必要がないと思われる
		elsif w_data1[x] =~ /^\s*?\$LineTargetStart/i
			# $LineTarget命令
			# $LineTargetStart [比較対象階層] = [内容], [１オリジンの開始位置], [置換対象階層]
			# 比較対象階層・置換対象階層が階層情報に相当
			w_data3 = []
			# 「,」単位で配列化する
			w_data3 = w_data1[x].split(',')
			# 比較対象階層を相対パスから絶対パスに変換
			w_data3[1] = exchange_absolute_path(w_data3[1], now_hierarchy)
			# 置換対象階層を相対パスから絶対パスに変換
			w_data3[3] = exchange_absolute_path(w_data3[3], now_hierarchy)
			# 「,」単位で配列化したものを、元に戻す
			w_data1[x] = w_data3.join(',')

		else
			# 通常の行
			# 相対パスの行を絶対パスに変換する
			w_data1[x] = exchange_absolute_path(w_data1[x], now_hierarchy)
		end
	end


	# base定義の削除処理
	w_data1.each_index do |x|
		if w_data1[x] =~ /^\s*?\$BaseStart_[0-9]+?\s*?/i
			# BaseStart文の行である
			w_data1[x] = ''
#			w_data1[x] = "\n"
		elsif w_data1[x] =~ /^\s*?\$BaseEnd_[0-9]+?\s*?/i
			# BaseEnd文の行である
			w_data1[x] = ''
#			w_data1[x] = "\n"
		end
	end


	w_data2 = w_data1.join("\n")
	w_data1 = []

	return w_data2

end



# =============================================================================


# 階層データのLineTarget命令への識別子セット処理
#    引数
# in_data - LineTarget命令の識別子セット処理対象文字列 (String型/IN)
#    戻り値
# LineTarget命令への識別子セット処理後の文字列 (String型/OUT)
#    備考
# 新しい形式の階層データファイルコンバート後の形式に変換するので、
#   既存の場合には置き換えに注意すること
def linetarget_setmark_proc(in_data)

	marknum = 0		# 識別子に付ける番号の初期化
	out_data = ''	# 識別子セット後の格納領域の初期化
	w_data1 = []	# 改行で区切った文字列の格納配列領域の初期化
	w_data2 = ''	# 識別子の一時格納領域
	marknum_stack = []	# ネストに対応するためのスタック領域


	w_data1 = in_data.split("\n")

	w_data1.each_index do |i|
		w_data2 = ''	# １行のデータの一時格納領域
		if w_data1[i] =~ /^(\s*?\$LineTargetStart\s*?)(,[\s\S]+?)$/i
			# LineTargetStart文である
			marknum += 1
			w_data2 = 'LT_' + String(marknum)
			w_data1[i] = $1 + ', ' + w_data2 + $2
			marknum_stack.push w_data2
		elsif w_data1[i] =~ /^(\s*?\$LineTargetEnd\s*?)$/i
			# LineTargetEnd文である
			w_data1[i] = $1 + ',  ' + marknum_stack.pop
#		else
#			# その他の行である
		end
	end


	out_data = w_data1.join("\n")

	return out_data

end



# =============================================================================


# 階層データのコンバート処理 (ver2形式)
#    引数
# in_data - コンバート前の階層データ (String型)
#    戻り値
# コンバート後の階層データ ((String型の)配列型)
#    備考
# Repeat定義の実行を、あらかじめ完了していること
def hierarchy_conversion_proc_ver200(in_data)


	w_data1 = ''
	w_data2 = []

	w_str1 = []
	w_str2 = []
	w_str3 = ''


	# 階層データのbase定義処理
	w_data1 = basehierarchy_extend_proc(in_data)


	# LineTargetStartとLineTargetEndの識別子設定対応
	w_data1 = linetarget_setmark_proc(w_data1)



# 作成中


































































	return w_data1
end



# =============================================================================


# 階層データ保存処理 (ver2形式)
#    引数
# in_data - コンバート後の階層データ (String型)
# hir_filename - 階層データファイル名
#    備考
def hierarchy_save_proc_ver200(in_data, hir_filename)

	def_data = []		# defファイルに出力するデータ
	hir_data = []		# 階層パラメータリンクファイルに出力するデータ
	# ※高速化のため、上記を配列化(1時間の処理が16秒に短縮...)
	param_num = 0		# パラメータ名で使用する番号の初期化
	offset_count = 0	# バイト数からオフセットを計算する
	w_data1 = []
	w_data2 = []
	w_data3 = []
	w_str1 = ''
	w_str2 = ''


	w_data1 = in_data.split("\n")


	# 先頭行に「#$ type=hierarchy version=2.0」があれば、
	# 実行時の表記「#$ type=hierarchy-execute version=2.0」に変換する
	if w_data1[0] =~ /\A\s*?\#\$([\s\S]+?)$/
		# 先頭行に表記が見つかった
		w_str1 = $1
		w_str1.gsub! /(\S)\s+?(\=)\s+?(\S)/, '\1\2\3'
		if w_str1 =~ /type=hierarchy/i
			w_data1[0] = '#$ type=hierarchy-execute version=2.0 encoding=EUC-JP'
		else
			puts 'ファイル識別情報に「type=hierarchy」が見つかりませんでした。'
		end
	else
		# 先頭行に表記が見つからなかった
		puts 'ファイル識別情報が見つかりませんでした。'
		puts '先頭行に「#$ type=hierarchy ...」を記述してください'
		exit 10
	end


	# 通常のパラメータで「*** = 999, NAMAE」といった表記があったら、最初の「,」以降を無効にする
	# これは、将来COBOLのCOPY句自動生成を作成しても支障がないようにするための措置である
	

	w_data1.each_index do |i|
		if w_data1[i] =~ /^[\s]*?\$LineTargetStart/i
			# $LineTargetStart定義である
			# 先頭の空白をなくす
			w_data1[i].gsub! /^\s*?([^\s])/, '\1'
			# 「,」前後の空白をなくす
			w_data1[i].gsub! /([^\s])\s*?(\,)\s*?([^\s])/, '\1\2\3'
			# 「=」の前後の空白をなくす
			w_data1[i].gsub! /([^\s])\s*?(\=)\s*?([^\s])/, '\1\2\3'
		elsif w_data1[i] =~ /^(\s*?\$LineTargetEnd)/i
			# $LineTargetEnd定義である
			# 先頭の空白をなくす
			w_data1[i].gsub! /^\s*?([^\s])/, '\1'
			# 「,」前後の空白をなくす
			w_data1[i].gsub! /([^\s])\s*?(\,)\s*?([^\s])/, '\1\2\3'
		elsif w_data1[i] =~ /^\s*?\$/
			# $定義である
			# 先頭の空白をなくす
			w_data1[i].gsub! /^\s*?([^\s])/, '\1'
		elsif w_data1[i] =~ /^\s*?\#/
			# 「#」コメントである
			if i > 0
				# コメント行をなくす
				w_data1[i] = ''
			end
#			# 先頭の空白をなくす
#			w_data1[i].gsub! /^\s*?([^\s])/, '\1'
		elsif w_data1[i] =~ /^\s*?$/
			# 空白行である
		else
			# パラメータである
			# 先頭の空白をなくす
			w_data1[i].gsub! /^\s*?([^\s])/, '\1'
			# 「=」の前後の空白をなくす
			w_data1[i].gsub! /([^\s])\s*?(\=)\s*?([^\s])/, '\1\2\3'
			# 右辺の「,」以降をなくす
			w_data1[i].gsub! /^([^\,]+?)\,[\s\S]*?$/, '\1'
			w_data1[i].gsub! /([^\S])\s$/, '\1'
		end
	end


	# 空白行をなくす
	w_data2 = w_data1
	w_data1 = []
	w_data2.each do |d|
		if d =~ /^[\s]*?\$LineTargetStart/i
			# $LineTargetStart定義である
			w_data1.push d
		elsif d =~ /^(\s*?\$LineTargetEnd)/i
			# $LineTargetEnd定義である
			w_data1.push d
		elsif d =~ /^\s*?\$/
			# $定義である
			w_data1.push d
		elsif d =~ /^\s*?\#/
			# 「#」コメントである
			if d =~ /^\s*?\#\$/
				# １行目のコメントのみ残す
				w_data1.push d
			end
		elsif d =~ /^\s*?$/
			# 空白行である
		else
			# パラメータである
			w_data1.push d
		end
	end













	hir_data = w_data1



	# ファイルへの書き込み
# ****************************************
$stderr.puts '  階層データファイルへ書き込み中です'		if (DEBUG & 1) == 1
# ****************************************
	open(hir_filename, "w") do |fp2|
		hir_data.each do |x2|
			fp2.puts x2
		end
	end
# ****************************************
$stderr.puts '  階層パラメータリンクファイルへの書き込みが終わりました'		if (DEBUG & 1) == 1
# ****************************************


end



# =============================================================================


# 階層データのコンバート処理 (既存形式)
#    引数
# in_data - コンバート前の階層データ (String型)
#    戻り値
# コンバート後の階層データ ((String型の)配列型)
#    備考
# このコンバート処理は、既存の形式に変換するものである
# 後に高速化対応のため、別のシンプルな形式に変換するものに変更する
# 高速化対応の際には、元データに対して、さらに変更が必要になる(defファイルとの統合のため、バイト数の内容を取り込む必要があるためである)
# Repeat定義の実行を、あらかじめ完了していること
def hierarchy_conversion_proc_a(in_data)

	w_data1 = ''
	w_data2 = []

	w_str1 = []
	w_str2 = []
	w_str3 = ''


	# 階層データのbase定義処理
	w_data1 = basehierarchy_extend_proc(in_data)


	# LineTargetStartとLineTargetEndの識別子設定対応
	w_data1 = linetarget_setmark_proc(w_data1)


	# LineTargetStartの既存形式への変換
	w_data2 = w_data1.split("\n")

	w_data2.each_index do |i|
		if w_data2[i] =~ /^[\s]*?\$LineTargetStart/i
			# $LineTargetStart定義である
#		if w_data2[i] =~ /^[^\s]*?$/ and w_data2[i] =~ /^\s*?[^\#]+/
			w_str1 = w_data2[i].split(',')
			# w_str1[0] = $LineTargetStart
			# w_str1[1] = 識別子
			# w_str1[2] = 比較対象階層 = 内容
			# w_str1[3] = １オリジンの開始位置
			# w_str1[4] = 置換対象階層
			w_str2 = w_str1[2].split('=')		# 識別子の次の比較を分解する
			# 新形式には先頭に「/」があるが、既存形式の先頭に「~」がないので、削除する
			if w_str1[4] =~ /^(\s*?)\/([\s\S]*?)$/
				w_str1[4] = $1 + $2
			end
			if w_str2[0] =~ /^(\s*?)\/([\s\S]*?)$/
				w_str2[0] = $1 + $2
			end
			w_str3 = w_str1[0] + ', ' + w_str1[1] + ', ' + w_str1[4] + ', =, ' + w_str2[0] + ', ' + w_str2[1] + ', ' + String(Integer(w_str1[3]) - 1)
			w_data2[i] = w_str3

			w_str1 = []
			w_str2 = []
			w_str3 = ''
		elsif w_data2[i] =~ /^(\s*?\$LineTargetEnd)/i
			# $LineTargetEnd定義である
		elsif w_data2[i] =~ /^\s*?\$/
			# $定義である
		elsif w_data2[i] =~ /^\s*?\#/
			# 「#」コメントである
		elsif w_data2[i] =~ /^\s*?$/
			# 空白行である
		else
			# パラメータである
			# 新形式には先頭に「/」があるが、既存形式の先頭に「~」がないので、削除する
			if w_data2[i] =~ /^(\s*?)\/([\s\S]*?)$/
				w_data2[i] = $1 + $2
			end
		end
	end

	# 既存形式は、先頭に「~」がつかないので、この時点で、先頭の「/」をなくす。
	w_data2.each_index do |i|
		if w_data2[i] =~ /^[\s]*?\$LineTargetStart/i
			# $LineTargetStart定義である
		elsif w_data2[i] =~ /^(\s*?\$LineTargetEnd)/i
			# $LineTargetEnd定義である
		elsif w_data2[i] =~ /^\s*?\$/
			# $定義である
		elsif w_data2[i] =~ /^\s*?\#/
			# 「#」コメントである
		elsif w_data2[i] =~ /^\s*?$/
			# 空白行である
		else
			# パラメータである
		end
	end


	# 行頭に空白があれば、空白を削除する
	w_data2.each_index do |i|
		w_data2[i].gsub! /^\s+?([^\s])/, '\1'
	end


	# 絶対パスになったものに対して、既存形式
	w_data1 = w_data2.join("\n")



	# 通常のデータを「/タグ名[配列番号]/タグ名[配列番号]@属性名」から
	#   「~タグ名(配列番号)~タグ名(配列番号)!属性名」に変換する
	w_data1.gsub! /\//, '~'
	w_data1.gsub! /\@/, '!'
	w_data1.gsub! /\[/, '('
	w_data1.gsub! /\]/, ')'


	return w_data1

end



# =============================================================================

# 階層データ保存処理 (既存形式)
#    引数
# in_data - コンバート後の階層データ (String型)
# hir_filename - 階層データファイル名
# def_filename - 出力defファイル名
#    備考
# この階層データ保存処理は、既存の形式に変換するものである
# ひとつにまとめてあるファイルを、既存の形式に分割・変換して保存する
def hierarchy_save_proc_a(in_data, hir_filename, def_filename)

	def_data = []		# defファイルに出力するデータ
	hir_data = []		# 階層パラメータリンクファイルに出力するデータ
	# ※高速化のため、上記を配列化(1時間の処理が16秒に短縮...)
	param_num = 0		# パラメータ名で使用する番号の初期化
	offset_count = 0	# バイト数からオフセットを計算する
	w_data1 = []
	w_data2 = []
	w_data3 = []
	w_str1 = ''
	w_str2 = ''


	w_data1 = in_data.split("\n")


	# 先頭行の「#$ type=hierarchy version=2.0 encoding=EUC-JP」を削除する
	if w_data1[0] =~ /\A\s*?\#\$[\s\S]+?$/
		w_data1.shift
	end



# ****************************************
$stderr.puts '  階層データをdefデータと階層リンクデータに分離します'		if (DEBUG & 1) == 1
# ****************************************

	w_data1.each do |x|
		if x =~ /^\s*?$/
			# 空行である
			def_data.push "\n"
			hir_data.push "\n"
		elsif x =~ /^\s*?\#[\s\S]*?$/
			# コメント行である
			def_data.push x + "\n"
			hir_data.push x + "\n"
		elsif x =~ /^\s*?\$LineTargetStart\s*?,\s*?(\S*?)/i
			def_data.push '# LineTargetStart [' + $1 + "]\n"
			hir_data.push x + "\n"
		elsif x =~ /^\s*?\$LineTargetEnd\s*?,\s*?(\S*?)/i
			def_data.push '# LineTargetEnd   [' + $1 + "]\n"
			hir_data.push x + "\n"
		else
			# 階層情報行である
			param_num += 1		# パラメータ番号の加算
			w_str1 = '%' + sprintf("%06d", param_num) + '%'		# パラメータ名のセット(maxは99万まで)
			if x !~ /=/
				puts '階層情報に「=」が含まれていない行があります'
				puts x
				puts ''
			end
			w_data2 = x.split('=')
			w_data3 = w_data2[1].split(',')		# バイト数とCOBOL側名称の両方がある場合を考慮
			def_data.push w_str1 + ', 0, ' + String(offset_count) + ', ' + w_data3[0]
			if w_data2[0] =~ /^[\S\s]+?\!([\S]+?)\s*?$/
				# 属性である
				def_data.push ', , ' + $1
			end
			def_data.push "\n"
			hir_data.push w_data2[0] + ' = ' + w_str1 + "\n"
			offset_count += Integer(w_data3[0])
		end

	end

# ****************************************
$stderr.puts '  分離処理が終わりました'		if (DEBUG & 1) == 1
# ****************************************

	# ファイルへの書き込み
# ****************************************
$stderr.puts '  階層パラメータリンクファイルへ書き込み中です'		if (DEBUG & 1) == 1
# ****************************************
	open(hir_filename, "w") do |fp2|
		hir_data.each do |x2|
			fp2.print x2
		end
	end
# ****************************************
$stderr.puts '  階層パラメータリンクファイルへの書き込みが終わりました'		if (DEBUG & 1) == 1
# ****************************************
# ****************************************
$stderr.puts '  defファイルへ書き込み中です'		if (DEBUG & 1) == 1
# ****************************************
	open(def_filename, "w") do |fp3|
		def_data.each do |x3|
			fp3.print x3
		end
	end
# ****************************************
$stderr.puts '  defファイルへの書き込みが終わりました'		if (DEBUG & 1) == 1
# ****************************************


	return
end



# =============================================================================



# =============================================================================



case	conv_mode
when	CONV_MODE_EXISTING_DEF
	# defファイルの既存形式への変換である

	in_data1 = ''		# 入力ファイルの内容
	data2 = []		# 入力ファイルの内容を配列化したもの
	out_data1 = []		# 出力内容(最後まで配列にする(1.6までは、文字列でマージすると、速度が遅くなる))

	# ファイルの読み込み
	open(argv_f[0], "r") do |fp1|
		in_data1 = fp1.read
	end

	# Repeat定義処理
	in_data1 = repeat_extend_proc(in_data1)

	# defデータのコンバート処理
	out_data1 = def_conversion_proc_a(in_data1)

	# ファイルの書き込み
	open(argv_f[1], "w") do |fp2|
		out_data1.each do |x|
			fp2.puts x
		end
	end


# ------------------------------------------------------------
when	CONV_MODE_EXISTING_XML
	# XMLテンプレートファイルの既存形式への変換である

	in_data1 = ''		# 入力ファイルの内容
#	out_data1 = []		# 出力内容(最後まで配列にする(1.6までは、文字列でマージすると、速度が遅くなる))
	out_data1 = ''		# 出力内容

	# ファイルの読み込み
	open(argv_f[0], "r") do |fp1|
		in_data1 = fp1.read
	end


	# Repeat定義処理
	out_data1 = repeat_extend_proc(in_data1)

	# ファイルの書き込み
	open(argv_f[1], "w") do |fp2|
		fp2.print out_data1
	end


# ------------------------------------------------------------
when	CONV_MODE_EXISTING_HIR
	# 階層データファイルの既存形式への変換である

	in_data1 = ''		# 入力ファイルの内容
#	out_data1 = []		# 出力内容(最後まで配列にする(1.6までは、文字列でマージすると、速度が遅くなる))
	out_data1 = ''		# 出力内容

	# ファイルの読み込み
	open(argv_f[0], "r") do |fp1|
		in_data1 = fp1.read
	end

	# Repeat定義処理
# ****************************************
$stderr.puts 'Repeat定義処理を開始します'		if (DEBUG & 1) == 1
# ****************************************
	in_data1 = repeat_extend_proc(in_data1)
# ****************************************
$stderr.puts 'Repeat定義処理が終わりました'		if (DEBUG & 1) == 1
# ****************************************

	# 階層データのコンバート処理
# ****************************************
$stderr.puts '階層データのコンバート処理を開始します'		if (DEBUG & 1) == 1
# ****************************************
	out_data1 = hierarchy_conversion_proc_a(in_data1)
# ****************************************
$stderr.puts '階層データのコンバート処理が終わりました'		if (DEBUG & 1) == 1
# ****************************************

	# 階層データ保存処理
# ****************************************
$stderr.puts '階層データ保存処理を開始します'		if (DEBUG & 1) == 1
# ****************************************
	hierarchy_save_proc_a(out_data1, argv_f[2], argv_f[1])
# ****************************************
$stderr.puts '階層データ保存処理が終わりました'		if (DEBUG & 1) == 1
# ****************************************


# ------------------------------------------------------------
when	CONV_MODE_REPEAT
	# Repeat定義の変換である

	in_data1 = ''		# 入力ファイルの内容
#	out_data1 = []		# 出力内容(最後まで配列にする(1.6までは、文字列でマージすると、速度が遅くなる))
	out_data1 = ''		# 出力内容

	# ファイルの読み込み
	open(argv_f[0], "r") do |fp1|
		in_data1 = fp1.read
	end


	# Repeat定義処理
	out_data1 = repeat_extend_proc(in_data1)

	# ファイルの書き込み
	open(argv_f[1], "w") do |fp2|
		fp2.print out_data1
	end


# ------------------------------------------------------------
when	CONV_MODE_VER200_HIR
	# 階層データファイルのver2形式への変換である
	in_data1 = ''		# 入力ファイルの内容
#	out_data1 = []		# 出力内容(最後まで配列にする(1.6までは、文字列でマージすると、速度が遅くなる))
	out_data1 = ''		# 出力内容

	# ファイルの読み込み
	open(argv_f[0], "r") do |fp1|
		in_data1 = fp1.read
	end

	# Repeat定義処理
# ****************************************
$stderr.puts 'Repeat定義処理を開始します'		if (DEBUG & 1) == 1
# ****************************************
	in_data1 = repeat_extend_proc(in_data1)
# ****************************************
$stderr.puts 'Repeat定義処理が終わりました'		if (DEBUG & 1) == 1
# ****************************************
	# 階層データのコンバート処理 (ver2形式)
# ****************************************
$stderr.puts '階層データのコンバート処理を開始します'		if (DEBUG & 1) == 1
# ****************************************
	out_data1 = hierarchy_conversion_proc_ver200(in_data1)
# ****************************************
$stderr.puts '階層データのコンバート処理が終わりました'		if (DEBUG & 1) == 1
# ****************************************

	# 階層データ保存処理 (ver2形式)
# ****************************************
$stderr.puts '階層データ保存処理を開始します'		if (DEBUG & 1) == 1
# ****************************************
	hierarchy_save_proc_ver200(out_data1, argv_f[1])
# ****************************************
$stderr.puts '階層データ保存処理が終わりました'		if (DEBUG & 1) == 1
# ****************************************




# ------------------------------------------------------------
end
