#!/usr/bin/ruby
# coding : euc-jp
Encoding.default_external = "euc-jp"



# Claim既存形式→新形式変換コンバータ

# メモ
# $Repeat定義は手作業で修正してください。
# xmlテンプレートファイルは、変換の必要がありません。（$Repeat定義の修正は手作業です）
# equal定義のうち、文字列の定義をしてあるものは、あらかじめ手作業で修正してから行ってください。
# equal定義の「a, equal, b \n b, equal, c \n c, equal, a」のようなものには対応していません。（最悪、無限ループします）
#
#
# 現在作業中
# なし
#
# 修正履歴
# 2003/06/26 - 「-H」指定で、defファイルとlinkファイルの指定が逆になっていたのを修正
# 2003/06/27 - defファイルの属性指定の並びをわかりやすくする。（COBOLのINCファイルにしやすくする）
# 2003/07/11- - 旧形式のファイルから新形式のファイルへの移行を考慮し、ヘッダ情報を追加する




if __FILE__ == $0

# =============================================================================
# デバッグ対応

	# デバッグ用引数指定
	debug_argv_set = 0	# デバッグではない
#	debug_argv_set = 1	# defファイルの既存からの変換でのデバッグ
#	debug_argv_set = 2	# xmlテンプレートファイルの既存からの変換でのデバッグ
#	debug_argv_set = 3	# 階層データファイルの既存からの変換でのデバッグ



# =============================================================================
# 定数の指定

# defファイルの既存形式からの変換である
OLDCONV_MODE_DEF = 1
# XMLテンプレートファイルの既存形式からの変換である
OLDCONV_MODE_XML = 2
# 階層データファイルの既存形式からの変換である
OLDCONV_MODE_HIR = 3


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
		argv_f.push 'test011old.def'		# テスト実行時に読み込むファイル名
		argv_f.push 'test011new.def'		# テスト実行時の出力ファイル名
		conv_mode = OLDCONV_MODE_DEF
	when	2
		# xmlテンプレートファイルの既存への変換でのデバッグ
		argv_f.push 'test012old.xml'		# テスト時に読み込むXMLテンプレートファイル名
		argv_f.push 'test012new.xml'		# テスト時に出力するXMLテンプレートファイル名
		conv_mode = OLDCONV_MODE_XML
	when	3
		# 階層データファイルの既存への変換でのデバッグ
		argv_f.push 'test013old.def'		# テスト時に読み込むdefファイル名
		argv_f.push 'test013old.link'		# テスト時に読み込む階層パラメータリンクファイル名
		argv_f.push 'test013new.hir'		# テスト時に出力する階層データファイル名
		conv_mode = OLDCONV_MODE_HIR
	end



	if argv_size != 0
		ARGV.each do |x|
			case	x
			when	'--help'
				# ヘルプメッセージを表示させる
				help_flg = 1
			when	'-D'
				# defファイルの既存形式への変換である
				conv_mode = OLDCONV_MODE_DEF
			when	'-X'
				# XMLテンプレートファイルの既存形式への変換である
				conv_mode = OLDCONV_MODE_XML
			when	'-H'
				# 階層データファイルの既存形式への変換である
				conv_mode = OLDCONV_MODE_HIR
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
		mes += '        defファイルの既存形式からの変換' + "\n"
#		mes += '    -X [入力xmlファイル] [出力xmlファイル]' + "\n"
#		mes += '        xmlテンプレートファイルの既存形式からの変換' + "\n"
		mes += '    -H [入力defファイル] [入力階層パラメータリンクファイル] [出力階層データファイル]' + "\n"
		mes += '        階層データファイルの既存形式からの変換' + "\n"
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
	when	OLDCONV_MODE_DEF
		# defファイルの変換である
		if argv_f.size != 2
			puts '引数に、入力defファイルと出力defファイルの２つを指定してください'
			exit 10
		end
#	when	OLDCONV_MODE_XML
#		# XMLテンプレートファイルの変換である
#		if argv_f.size != 2
#			puts '引数に、入力xmlテンプレートファイルと出力xmlテンプレートファイルの２つを指定してください'
#			exit 10
#		end
	when	OLDCONV_MODE_HIR
		# 階層データファイルである
		if argv_f.size != 3
			puts '引数に、入力defファイルと入力階層パラメータリンクファイルと出力階層データファイルの３つを指定してください'
			exit 10
		end
	else
		puts '実行時エラーです'
		exit 10
	end



end



# =============================================================================


# defファイルデータの変換
#    引数
# in_data - 変換対象defファイルデータ [String型/IN]
#    戻り値
# 変換後のdefファイルデータ [String型/OUT]
def	def_convert_proc(in_data)

	w_line1 = []	# 行単位で配列に分けたものを入れる領域
	w_line2 = []	# 項目単位で配列に分けたものを入れる領域
	w_line3 = ''	# 行末コメントを除いた文字列の格納領域
	w_str1 = ''
	w_str2 = ''
	w_str3 = ''
	w_str4 = ''

	w_comment1 = ''		# 行末コメントの格納領域

	w_idx1 = 0
	w_idx2 = 0


	w_line1 = in_data.split("\n")		# 改行で配列に分ける


	w_line1.each_index do |w_idx1|

		# 行末コメントのみ、別領域に保存（ただし、コメントのみの行は除く）
		if w_line1[w_idx1] =~ /^([\s\S]*?\S+)(\s*?\#[\s\S]*?)$/
			w_line3 = $1
			w_comment1 = $2
		else
			w_line3 = w_line1[w_idx1]
			w_comment1 = ''
		end


		# equal定義に文字列があったり、空欄があれば、警告メッセージを出す。
		if w_line3 =~ /^(\s*?\S+?\s*?,\s*?equal\s*?,([\S\s]+?))$/i
			w_str2 = $1
			w_str3 = $2
			if w_str3 =~ /^\s*?$/
				puts 'equal文の中に、空白をセットしているものがあります'
				puts w_str2
				puts '新しいclaim通信は、文字列のequal定義をサポートしていませんので、注意してください'
				puts ''
			elsif w_str3 !~ /^\s*?[0-9\+\*\-\/\(\)\s]+?\s*?$/
				puts 'equal文の中に、数字以外をセットしているものがあります'
				puts w_str2
				puts '新しいclaim通信は、文字列のequal定義をサポートしていませんので、注意してください'
				puts ''
			end
		end


		if w_line3 =~ /^\s*?\#/i
			# コメントである
		elsif w_line3 =~ /^\s*?$/i
			# 空白の行である
		elsif w_line3 =~ /^(\s*?)(\S+?)\s*?,\s*?equal\s*?,(\s*?)([\S\s]+?)\s*?$/i
			# equal構文の変換
				# $1 = 前の空白
				# $2 = 定義名
				# $3 = 値の前の空白
				# $4 = 値
			w_line1[w_idx1] = $1 + '$define, ' + $2 + ',' + $3 + $4 + w_comment1
		elsif w_line3 =~ /^(\s*?)(\S+?)\s*?,\s*?const\s*?,(\s*?)([\S\s]+?)\s*?$/i
			# const構文の変換
				# $1 = 前の空白
				# $2 = パラメータ名
				# $3 = 内容の前の空白
				# $4 = 内容
			w_line1[w_idx1] = $1 + '$const, ' + $2 + ',' + $3 + $4 + w_comment1
		elsif w_line3 =~ /^(\s*?)(\S+?)\s*?,\s*?nowdate1\s*?$/i
			# nowdate1構文の変換
				# $1 = 前の空白
				# $2 = パラメータ名
			w_line1[w_idx1] = $1 + '$nowdate, ' + $2 + ', %Y-%m-%d' + w_comment1
		elsif w_line3 =~ /^(\s*?)(\S+?)\s*?,\s*?nowdate2\s*?$/i
			# nowdate2構文の変換
				# $1 = 前の空白
				# $2 = パラメータ名
			w_line1[w_idx1] = $1 + '$nowdate, ' + $2 + ', %Y-%m-%dT%H:%M:%S' + w_comment1
		elsif w_line3 =~ /^(\s*?)(\S+?)\s*?,\s*?ifdef\s*?,([\S\s]+?)\s*?$/i
			# ifdef構文の変換
				# $1 = 前の空白
				# $2 = 識別名
				# $3 = [and または or]以降の内容
			w_line1[w_idx1] = $1 + '$ifdef, ' + $3 + w_comment1
		elsif w_line3 =~ /^(\s*?)(\S+?)\s*?,\s*?endif\s*?$/i
			# endif構文の変換
				# $1 = 前の空白
				# $2 = 識別名
			w_line1[w_idx1] = $1 + '$endif' + w_comment1
		else
			# パラメータの行と思われる
			w_line2 = w_line3.split(',')
			# 前後の空白を取り除く
			w_line2.each_index do |w_idx2|
				w_line2[w_idx2].strip!
			end
			if (w_line2[5] == nil) or (w_line2[5] == '')
				# ６番目の項目が空欄の場合等は、通常のパラメータである
				w_line3 =~ /^(\s*?)(\S+?)\s*?,\s*?0,\s*?([^,]+?)\s*?,(\s*?[\S\s]+?)$/
					# $1 = 前の空白
					# $2 = パラメータ名
					# $3 = オフセット
					# $4 = バイト数(前の空白を含む)
				w_str2 = $1 + $2 + ','
				w_str3 = $4
				w_str3.gsub! /^([^,]*?),/, '\1'	# 後ろのコンマ削除は、２回繰り返す(空欄の場合があるので)
				w_str3.gsub! /^([^,]*?),/, '\1'
				w_line1[w_idx1] = w_str2 + w_str3 + w_comment1
			else
				# ６番目の項目に何か入っている場合等は、属性のパラメータである
				w_line3 =~ /^(\s*?)(\S+?)\s*?,\s*?0,\s*?([^,]+?)\s*?,(\s*?[^,]+?)\s*?,[^,]*?,(\s*?[\S\s]+?)$/
					# $1 = 前の空白
					# $2 = パラメータ名
					# $3 = オフセット
					# $4 = バイト数(前の空白を含む)
					# $5 = 属性名(前の空白を含む)
				w_str2 = $1 + $2 + ','
				w_str3 = $4 + ','
				w_str4 = $5
				w_str4.gsub! /^([^,]*?),/, '\1'	# 後ろのコンマ削除は、２回繰り返す(空欄の場合があるので)
				w_str4.gsub! /^([^,]*?),/, '\1'
				w_line1[w_idx1] = w_str2 + w_str3 + w_str4 + w_comment1
#				w_line1[w_idx1] = $1 + $2 + ',' + $4 + ',' + $5 + w_comment1
			end
		end
	end


	# 識別情報を冒頭に追加する
	w_line1.unshift('#$ type="figure-define" version="2.0" encoding="EUC-JP"')


	# 配列に分けたものを元に戻す
	out_data = w_line1.join("\n")




	return out_data

end



# =============================================================================



# =============================================================================


# 旧defファイルデータのequal定義展開処理
#    引数
# in_def - 旧defファイルデータのequal定義展開前データ (String型/IN)
#    戻り値
# defファイルデータのequal定義展開後のデータ (String型/OUT)
def defdata_expand_equal(in_def)

	w_def1 = []

	out_def = ''

	w_idx1 = 0
	w_idx2 = 0
	w_idx3 = 0
	w_line1 = ''
	w_line2 = []
	w_line3 = []
	w_line4 = ''

	w_ary1 = []

	equal_stack = []		# equalデータスタック 1配列に[パラメータ名, 中に入れる内容]が入る

	chg_flg1 = 0		# 変換フラグ(0 = 変換しなかった, 1 = 変換した)
	chg_flg2 = 0		# １行の変換フラグの初期化(0 = 変更しなかった, 1 = 変更した)
	chg_flg3 = 0		# １行の変換フラグの初期化(0 = 変更しなかった, 1 = 変更した)


	# 行単位で配列にする
	w_def1 = in_def.split("\n")


	# equalデータをスタックにためて、元の領域から削除
	w_def1.each_index do |w_idx1|
		w_line1 = w_def1[w_idx1]
		if w_line1 =~ /^\s*?$/
			# 空白行である
		elsif w_line1 =~ /^\s*?\#[\s\S]*?$/
			# コメント行である
		else
			# 空白行やコメント行ではない
			w_line2 = w_line1.split(',')
			w_line2.each_index do |w_idx2|
				w_line2[w_idx2].strip!
			end
			if w_line2[1] == 'equal'
				# 該当行は、equal定義の行である。
				equal_stack.push [w_line2[0], w_line2[2]]
				# equal定義の行なので、該当行を空白にする
				w_def1[w_idx1] = ''
			end
		end
	end


	# equalスタックの内部で、さらにequal定義の展開を行う。（ただし、ループ中で展開を１度もしなければ、致命的な変換エラー）
	chg_flg1 = 1		# 変換フラグ(0 = 変換しなかった, 1 = 変換した)
	notnum_flg = 1	# 数字以外存在フラグ(0 = 数字以外が存在しなかった, 1 = 数字以外が存在した)
	while notnum_flg == 1
		chg_flg1 = 0		# 変換フラグの初期化(0 = 変換しなかった)
		notnum_flg = 0	# 数字以外存在フラグの初期化(0 = 数字以外が存在しなかった)

		equal_stack.each_index do |w_idx3|
			w_line3 = equal_stack[w_idx3]

			chg_flg2 = 0		# １行の変換フラグの初期化(0 = 変更しなかった, 1 = 変更した)



			# 数字以外かの判定
			if w_line3[1] !~ /^\s*?[0-9]+?\s*?$/
				# 数字以外である
				notnum_flg = 1	# 数字以外存在フラグのセット

				# 「+-*/()」で分けた文字を使い、スタック内のパラメータを検索する
				# ただし、数字のみ・「+-*/()」のみを除く
				# 見つかったら、パラメータの展開をし、変換フラグをセットする
				w_len1 = 0
				w_idx4 = 0
				w_idx5 = 0
				w_idx6 = 0
				w_idx7 = 0
				w_item1 = []
				w_str1 = ''
				w_str2 = ''
				w_str3 = ''

				w_str1 = w_line3[1]
				w_len1 = w_str1.length	# 文字の長さを取得

				for w_idx4 in 0..(w_len1 - 1) do
					w_str3 = w_str1[w_idx4, 1]	# 対象の１文字を抽出
					case	w_str3
					when	'+', '-', '*', '/', '(', ')'
						# 区切りである
						w_item1.push w_str2.strip		# 項目名スタックにセット
						w_item1.push w_str3		# 区切り記号も入れる
						w_str2 = ''		# 項目名の初期化
					else
						# 区切り以外である
						w_str2 += w_str3
					end
				end
				if w_str2 != ''
					w_item1.push w_str2.strip
					w_str2 = ''		# 項目名の初期化
				end


				# パラメータの展開をし、変換フラグをセット
				# もしも、右辺と左辺が同じ場合は、致命的エラーなので、強制終了させる
				w_item1.each_index do |w_idx5|
					# 右辺と同じ名前が左辺にあれば、致命的エラーとする
					if w_line3[1] == w_item1[w_idx5]
						puts 'equal文に、式が展開できないものがあります'
						puts '[' + w_line3[1] + ']'
						exit 10
					end
					case	w_item1[w_idx5]
					when	'+' , '-', '*', '/', '(', ')'
						# 区切り文字である
					else
						# 数字以外が入っていれば、展開する
						if w_item1[w_idx5] =~ /[^0-9]/
							# 数字以外である
							if w_item1[w_idx5] =~ /^\s*?$/
								# 空白である
								# 0にする
								w_item1[w_idx5] = '0'
							else
								# 空白以外である
								# パラメータをequalデータスタックから検索し、展開作業をする
								# ただし、相手先が数字のみであること。（それ以外は、最初は展開しない。理由は、「+」より「*」を優先して式を評価するという、数学上の定理を崩すことになるので。このようにすると、意図した動きになると思われる）
								equal_stack.each_index do |w_idx6|
									if equal_stack[w_idx6][0] == w_item1[w_idx5]

										# パラメータが見つかった
										if equal_stack[w_idx6][1] !~ /^\s*?[0-9]+?\s*?$/
											# 数字以外が含まれている
										else
											# 数字以外が含まれていないので、セットする
											w_item1[w_idx5] = equal_stack[w_idx6][1]
											chg_flg1 = 1		# 変換フラグのセット
											chg_flg2 = 1		# １行の変換フラグのセット
										end
										break	# each_indexから抜ける
									end
								end
							end
						end
					end
				end


				# 配列型から、文字列型に戻す
#				w_line4 = w_item1.join('')
				w_line4 = w_item1.to_s

				if w_line4 =~ /[^0-9\+\-\*\/\(\)]+?/
					# 数式以外である
					# そのままにする
				else
					# 数式の可能性がある
					if w_line4 !~ /[\+\-\*\/\(\)]+?/
						# 数字のみである
					else
						# 数式である
						# 式を展開する
						w_line4 = String(eval(w_line4))
						chg_flg1 = 1		# 変換フラグのセット
						chg_flg2 = 1		# １行の変換フラグのセット
					end
				end

				if chg_flg2 == 1
					# 変更フラグがセットされているので、パラメータの内容が変更された
					equal_stack[w_idx3][1] = w_line4
					chg_flg1 = 1
					chg_flg2 = 0
				end
			end
			w_line3 = []
		end

		if (chg_flg1 == 0) and (notnum_flg == 1)
			# 数字以外が存在するのに、変換しなかった
			puts 'equal定義で、数字に変換できないものがあります'
			# ここで、できれば、equal定義で数字以外のパラメータ名を表示

			exit 10
		end

	end


# ---------------------------------------------------------

# equalスタックがすべて数値に変換されれば、該当パラメータを置換する。
# ただし、最初は通常パラメータのみとし、その後で、無条件gsubを行う。

# equal_stack

	equal_stack.each_index do |w_idx3|
		w_line3 = equal_stack[w_idx3]
		w_def1.each_index do |w_idx1|
			chg_flg3 = 0		# １行の変換フラグの初期化(0 = 変更しなかった, 1 = 変更した)
			w_line1 = w_def1[w_idx1]
			if w_line1 =~ /^\s*?$/
				# 空白行である
			elsif w_line1 =~ /^\s*?\#[\s\S]*?$/
				# コメント行である
			else
				# 空白行やコメント行ではない
				w_line2 = w_line1.split(',')
				w_line2.each_index do |w_idx2|
					w_line2[w_idx2].strip!
				end
				if w_line2[1] == '0'
					# 該当行は、通常のパラメータ定義の行である
#					if w_line2[2] =~ /^\s*?[^0-9]+?\s*?$/
					if w_line2[2] !~ /^\s*?[0-9]+?\s*?$/
						# 数字以外が入っている
#						w_line2[2].gsub! /#{w_line3[0]}/, w_line3[1]
						w_line2[2].gsub! /#{Regexp.quote(w_line3[0])}/, w_line3[1]
						chg_flg3 = 1	# 変更フラグのセット
#						if w_line2[2] =~ /^\s*?[^0-9\+\-\*\/\(\)]+?\s*?$/
						if w_line2[2] !~ /^\s*?[0-9\+\-\*\/\(\)]+?\s*?$/
							# まだパラメータが残っているので、式の展開はしない
						else
							# すでに演算子と数字のみなので、式の展開をする
							w_line2[2] = String(eval(w_line2[2]))
						end
					end
					if w_line2[3] !~ /^\s*?[0-9]+?\s*?$/
#					if w_line2[3] =~ /^\s*?[^0-9]+?\s*?$/
						# 数字以外が入っている
						w_line2[3].gsub! /#{Regexp.quote(w_line3[0])}/, w_line3[1]
#						w_line2[3].gsub! /#{w_line3[0]}/, w_line3[1]
						chg_flg3 = 1	# 変更フラグのセット
#						if w_line2[3] =~ /^\s*?[^0-9\+\-\*\/\(\)]+?\s*?$/
						if w_line2[3] !~ /^\s*?[0-9\+\-\*\/\(\)]+?\s*?$/
							# まだパラメータが残っているので、式の展開はしない
						else
							# すでに演算子と数字のみなので、式の展開をする
							w_line2[3] = String(eval(w_line2[3]))
						end
					end
					if chg_flg3 != 0
						# 変更があった
						# w_line2の配列内容をマージし、格納する
						w_def1[w_idx1] = w_line2.join(',')
					end


				end
			end
		end

	end


	# 配列形式のdefデータをString型に戻す
	out_def = w_def1.join("\n")


	return	out_def

end



# =============================================================================


# 該当パラメータの旧defファイルデータからの抽出
#    引数
# in_def - 旧defファイルデータ (String型/IN)
# param_name - 内容を取得するパラメータ名 (String型/IN)
#    戻り値
# パラメータ情報[オフセット値, バイト数] (配列型/OUT)
#      nilの場合、見つからなかった。
#    メモ
# equal定義に注意を払うこと
def get_param_from_defdata(in_def, param_name)

	w_str1 = ''

	# defデータのequal展開処理


	if in_def =~ /^(\s*?#{Regexp.quote(param_name)}[\s\S]*?)$/
		# 該当パラメータが見つかった
		w_str1 = $1

		w_param1 = []
		out_param = []

		w_param1 = w_str1.split(',')
		# パラメータ数チェック
		if w_param1.size < 4
			puts 'defファイルのパラメータのうち、指定のパラメータが４つ未満です'
			puts w_str1
		end
		# 前後の空白を取り除く
		w_param1.each_index do |i|
			w_param1[i].strip!
		end

		# (0オリジンの)2番目がオフセット
		out_param.push w_param1[2]
		# (0オリジンの)3番目がバイト数
		out_param.push w_param1[3]
	else
#		puts '指定されたパラメータが、defファイルから見つかりませんでした [' + param_name + ']'
		out_param = nil
	end


	return out_param
end


# =============================================================================

# 階層パラメータリンクファイルとdefファイルからの階層データファイルへの変換
#    引数
# in_def    - 変換対象defファイルデータ (String型/IN)
# in_hirlnk - 変換対象階層パラメータリンクデータ (String型/IN)
#    戻り値
# 変換後の階層データ (配列型/OUT)
def	hierarchy_convert_proc(in_def, in_hirlnk)

	w_hirlnk1 = ''		# 階層パラメータリンクデータ一時領域
	w_hirlnk2 = []

	w_def1 = ''			# defデータの一時領域

	w_hirline = []		# １行を配列に分けた時の一時領域

	w_hirout = []		# 出力する階層データ

	w_str1 = ''
	w_str2 = ''



	# 独自表記形式のものを、XMLパス形式への変換
	w_hirlnk1 = in_hirlnk
	w_hirlnk1.gsub! /~/, '/'
	w_hirlnk1.gsub! /!/, '@'
	w_hirlnk1.gsub! /\(/, '['
	w_hirlnk1.gsub! /\)/, ']'

	# defデータのequal定義を展開する
	w_def1 = defdata_expand_equal(in_def)


	# 配列にする
	w_hirlnk2 = w_hirlnk1.split("\n")


	# LineTarget構文の既存形式から新形式への変換
	w_hirlnk2.each_index do |i|
		w_str1 = ''
		w_str2 = ''
		w_hirline = []
		w_str1 = w_hirlnk2[i]
		if w_str1 =~ /^(\s*?)\$LineTargetStart/i
			# $LineTargetStart定義である
			w_str2 = $1
			w_hirline = w_str1.split(',')		# 「,」で区切って、配列にする
			if w_hirline.size != 7
				puts '$LineTargetStart文の引数の数が異なります'
				puts w_str1
			end
			# 前後の空白を取る
			w_hirline.each_index do |j|
				w_hirline[j].strip!
			end
			# 開始位置を0オリジンから1オリジンにする
			w_hirline[6] = String(Integer(w_hirline[6]) + 1)

			# 既存形式の先頭に「~」がないが、新形式には先頭に「/」があるので、追加する
			# 比較対象階層の置換(w_hirline[4])
			if w_hirline[4] =~ /^(\s*?)([^\/\s][\s\S]*?)$/
				# 先頭に変換後のXMLパス「/」が存在しないので、追加
				w_hirline[4] = $1 + '/' + $2
			end
			# 置換対象階層の置換(w_hirline[2])
			if w_hirline[2] =~ /^(\s*?)([^\/\s][\s\S]*?)$/
				# 先頭に変換後のXMLパス「/」が存在しないので、追加
				w_hirline[2] = $1 + '/' + $2
			end

			# 並べ替えを行う
			w_str2 = w_str2 + w_hirline[0] + ', ' + w_hirline[4] + ' = ' + w_hirline[5] + ', ' + w_hirline[6] + ', ' + w_hirline[2]
			# 配列にセット
			w_hirlnk2[i] = w_str2
		elsif w_str1 =~ /^(\s*?\$LineTargetEnd)/i
			# $LineTargetEnd定義である
			w_hirlnk2[i] = $1
		elsif w_str1 =~ /^\s*?\$/
			# $定義である
		elsif w_str1 =~ /^\s*?\#/
			# 「#」コメントである
		elsif w_str1 =~ /^\s*?$/
			# 空白行である
		else
			# パラメータである

			# 既存形式の先頭に「~」がないが、新形式には先頭に「/」があるので、追加する
			if w_str1 =~ /^(\s*?)([^\/\s][\s\S]*?)$/
				# 先頭に変換後のXMLパス「/」が存在しないので、追加
				w_hirlnk2[i] = $1 + '/' + $2
			end


		end

	end


# $LineTargetStart,  LT_1,  ~Mml(1)~Body(2)~MemoB(x), =,  ~Mml(1)~Body(2)~MemoB(x)~code(1)!atr, 'char', 0
#   ↓
# $LineTargetStart, /Mml[1]/Body[2]/MemoB[x]/code[1]@atr='char', 1, /Mml[1]/Body[2]/MemoB[x]



	# defファイルと階層パラメータの統合処理
	w_hirlnk2.each_index do |i|
		w_str1 = ''
		w_str2 = ''
#		w_hirline = []
		w_str1 = w_hirlnk2[i]
		if w_str1 =~ /^(\s*?)\$LineTargetStart/i
			# $LineTargetStartである
#			w_str2 = $1
#			w_hirline = w_str1.split(',')		# 「,」で区切って、配列にする

		elsif w_str1 =~ /^(\s*?\$LineTargetEnd)/i
			# $LineTargetEndである
		elsif w_str1 =~ /^\s*?\$/
			# $定義である
		elsif w_str1 =~ /^\s*?\#/
			# 「#」コメントである
		else
			# パラメータである
			w_str1.scan(/^(\s*?\S+?\s*?\=\s*?)(\S+?)\s*?$/) do |x, y|
				w_param1 = get_param_from_defdata(w_def1, y)
				w_hirlnk2[i] = x + w_param1[1]
			end
		end


	end


	w_hirout = w_hirlnk2

	# 識別情報を冒頭に追加する
	w_hirout.unshift('#$ type="hierarchy" version="2.0" encoding="EUC-JP"' + "\n")



	return	w_hirout

end



# =============================================================================


case	conv_mode
when	OLDCONV_MODE_DEF
	# defファイルの既存形式からの変換である

	in_def = ''
	out_def = ''

	# defファイルの読み込み
	open(argv_f[0], "r") do |fp1|
		in_def = fp1.read
	end


	# defファイルデータの変換
	out_def = def_convert_proc(in_def)


	# ファイルの書き込み
	open(argv_f[1], "w") do |fp2|
		fp2.print out_def
	end


# ------------------------------------------------------------
when	OLDCONV_MODE_XML
	# XMLテンプレートファイルの既存形式からの変換である

	puts 'XMLテンプレートファイルは、既存の形式がそのまま使えます'
	puts 'ただし、$Repeat定義については、手作業での修正が必要です'


# ------------------------------------------------------------
when	OLDCONV_MODE_HIR
	# 階層データファイルの既存形式からの変換である

	in_hirlnk = ''
	in_def = ''

	# defファイルの読み込み
	open(argv_f[0], "r") do |fp1|
		in_def = fp1.read
	end

	# 階層パラメータリンクファイルの読み込み
	open(argv_f[1], "r") do |fp2|
		in_hirlnk = fp2.read
	end


	# 階層パラメータリンクファイルとdefファイルからの階層データファイルへの変換
	out_hir = hierarchy_convert_proc(in_def, in_hirlnk)


	# ファイルの書き込み
	open(argv_f[2], "w") do |fp3|
		out_hir.each do |x|
			fp3.puts x
		end
	end




end
