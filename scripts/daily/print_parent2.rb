#!/usr/bin/ruby

# 文字列の改行区切りで配列にして、それを引数のプログラムに渡す処理
# (2002/03/07 竹田氏追加依頼)
# 引数指定のものを、一部dataファイルに含めるように変更(2002/04/16 :竹田氏依頼 :曳野対応)
#
# red2ps対応済み
# site-lib区分対応 (2002/10/16)
#   woody版では、site-libのdia/redファイルも見なければならないので、それに関する対応
#   基準ディレクトリを追加することで対応
#   dataファイルフォーマットを修正(LP名のあとに、site区分を追加)
# ディレクトリ位置対応 (2002/11/13)
#   コマンドライン引数3〜6のディレクトリ位置情報を使用するように修正

# ※複数のプロセスの実行はできない


# 引数指定方法
# 引数1 = 一時ファイル名
# 引数2 = 起動プログラム
# 引数3 = 日医標準レセプトformディレクトリ
# 引数4 = 日医標準レセプトrecordディレクトリ
# 引数5 = 日医標準レセプトsite固有formディレクトリ
# 引数6 = 日医標準レセプトsite固有recordディレクトリ
# 引数7 = dataファイル

# dataファイルフォーマット
# +------------------+------------+---------------+--------------------------+
# |ファイル名(30Byte)|LP名(20Byte)|site区分(1Byte)|帳票データ(Max10000バイト)|
# +------------------+------------+---------------+--------------------------+
# ファイル名に、拡張子とディレクトリ名を付加したものを子プロセスの引数に渡す
#    site区分
#      1 = orca標準
#      2 = site-libのカスタマイズ帳票
#
# ※LP名は空白の場合、子プロセスの引数を省略する





# ============================================================

# ヘルプ表示

help_flg = 0

case	ARGV[0]
when	nil
	help_flg = 1
when	'-?', '/?', '-h', '/h', '--help'
	help_flg = 1
else
	help_flg = 0
end

if (help_flg != 0)
	puts 'このスクリプトは、改行で区切って、引数のプログラムに渡すプログラムです'
	puts $0 + ' <temp> <exec> <form> <record> <site-form> <site-record> <data>'
	puts '<temp>        = 一時ファイル名'
	puts '<exec>        = 起動プログラム'
	puts '<form>        = 日医標準レセプトformディレクトリ'
	puts '<record>      = 日医標準レセプトrecordディレクトリ'
	puts '<site-form>   = 日医標準レセプトsite固有formディレクトリ'
	puts '<site-record> = 日医標準レセプトsite固有recordディレクトリ'
	puts '<data>        = dataファイル'
	exit 0
end


std_form = ''; std_record = ''; site_form = ''; site_record = ''

# 定数の指定(最後に、かならず「/」を付けた形にしてください)
std_form = ARGV[2] + '/'   		# 日レセ標準formディレクトリ
std_record = ARGV[3] + '/' 		# 日レセ標準recordディレクトリ
site_form = ARGV[4] + '/'  		# 日レセsite固有formディレクトリ
site_record = ARGV[5] + '/'		# 日レセsite固有recordディレクトリ


# .redからpsファイルに変換する際に使用するプログラム
RED_EXEC = 'red2ps'
# .redファイルで、LP名を省略された際に使用するプリンタ名
DEFAULT_LP = 'lp1'



# ============================================================
# 領域の初期化

# ファイル名領域
temp_file = ''; exec_file = ''; dia_file = ''; def_file = ''; data_file = ''; lp_name = ''
temp_file2 = ''; exec_file2 = ''; dia_file2 = ''; def_file2 = ''; data_file2 = ''; lp_name2 = ''
site_flag = ''; base_dir = ''
# 文字列領域
word1 = ''; word2 = []; word3 = ''
# exec用文字列領域
w_exec = ''
# fork用領域
pid = []
# カウンタ用領域
li_cnt1 = 0
# 文字列長用領域
d2_len = 0


# ============================================================
# 引数のセット

# 引数の数チェック
for li_cnt1 in 1..6 do
	if ARGV[li_cnt1] == nil
		puts '引数の数が足りません'
		exit 1
	end
end


# 引数の領域から、文字列の取得
temp_file = String(ARGV[0])		# 一時ファイル
exec_file = String(ARGV[1])		# 起動プログラムファイル
data_file = String(ARGV[6])		# dataファイル名


# ============================================================
# 関数定義部


# ファイル名の前後の「'」「"」を取り除く処理
def filename_change(name)
	filename_change = name.gsub /\A[\'\"]([\s\S]*?)[\'\"][\s]*?\z/, '\1'
end


# ファイル名に空白がある場合、前後に「"」をセットする処理
def filename_unchange(name)
	if name =~ ' '
		filename_unchange = "\"" + name + "\""
	else
		filename_unchange = name
	end
end


# slashを付ける
def add_slash(str)
	if str =~ /[^\/]$/
		return (str += '/')
	else
		return str
	end
end



# ============================================================
# 引数の加工処理

# 関数を呼び出して、前後の「'」「"」を削除
temp_file = filename_change(temp_file)
exec_file = filename_change(exec_file)
data_file = filename_change(data_file)


# 逆に、間に空白がある文字列に、「"」を追加したものを用意
temp_file2 = filename_unchange(temp_file)
exec_file2 = filename_unchange(exec_file)
data_file2 = filename_unchange(data_file)


# コマンド引数のformやrecordのディレクトリ名に「/」がない場合、「/」を付ける処理
std_form = add_slash(std_form)
std_record = add_slash(std_record)
site_form = add_slash(site_form)
site_record = add_slash(site_record)


# デバッグ用の表示
#puts "一時ファイル   = [" + temp_file + "]"
#puts "起動プログラム = [" + exec_file + "]"
#puts "dataファイル   = [" + data_file + "]"


# ============================================================

# 一時ファイル存在チェック
begin
	if nil != File.size(temp_file)
		puts '一時ファイルが存在するので削除します'
		puts 'ファイル名 = [' + temp_file + ']'
		# 一時ファイルの削除
		File.delete(temp_file)
		puts '削除しました'
#		puts '一時ファイルが存在するため、書き込みできません'
#		puts 'ファイル名 = [' + temp_file + ']'
#		exit 2
	end
rescue
# 例外が発生すれば、一時ファイルが存在しないので、ＯＫ
end


# dataファイルの存在チェック
begin
	if nil == File.size(data_file)
		puts 'dataファイルが存在しません'
		puts 'ファイル名 = [' + data_file + ']'
		exit 3
	end
rescue
# 例外が発生すれば、dataファイルが存在しない
	puts 'dataファイルが存在しません'
	puts 'ファイル名 = [' + data_file + ']'
	exit 3
end


# ============================================================


# dataファイルの読み込み
# 入力ファイルの読み込み処理
open(data_file, "r") do |fp|
	word1 = fp.read
end


# -----------------------------------

# 改行区切り処理
#word2 = word1.split(/\s*\n\s*/)
word2 = word1.split(/\n/)


# -----------------------------------


li_cnt1 = 0

# 実行処理
word2.each do |d2|
# デバッグ用コード
#	puts '[' + d2 + ']'
	li_cnt1 = li_cnt1 + 1
	d2_len = d2.size	# 文字列の長さの取得


	# 先頭30バイトは、.diaと.defファイルのファイル名部分
	# あるいは、.redファイルの拡張子を含むファイル名
	dia_file = ''
	def_file = ''
	red_file = ''
	ls_w1 = ''	# 一時用文字列領域
	ls_w1 = d2[0, 30].strip	# ファイル名を後ろの空白を除いて取得
	site_flag = d2[50, 1].strip		# site固有判定フラグの取得
	if ls_w1 =~ /.red$/
		# .redファイルである

		# Redファイル名のセット
		case	site_flag
		when	'1'
			red_file = std_form + ls_w1
		when	'2'
			red_file = site_form + ls_w1
		else
			red_file = std_form + ls_w1
		end

		lp_name = d2[30, 20].strip	# LP名のセット
		word3 = d2[51, (d2_len - 51)]	# 一時ファイルへ出力する内容のセット

		# 一時ファイルへの書き込み
		open(temp_file, "w") do |fp|
			fp.print word3
			fp.print ' ' * 10000
		end

# デバッグ用の表示
		case	word3
		when	nil
			puts	'改行のみです' + '[' + String(li_cnt1) + ']'
		when	''
			puts	'改行のみです' + '[' + String(li_cnt1) + ']'
		else
			if d2 =~ /\A\s*\z/
				puts	'空白・改行です' + '[' + String(li_cnt1) + ']'
#			else
#				puts	'OK [' + String(li_cnt1) + ']'
			end
		end
		# LP名が指定されていなかったら、LP名をlp1にする
		if lp_name == ''
			lp_name = DEFAULT_LP
		end

		w_exec = RED_EXEC + ' ' + red_file + ' ' + temp_file + ' -p ' + lp_name

# デバッグ用の表示
#		puts w_exec
# **
		# 実行前メッセージ出力
		puts	'Print Start [' + String(li_cnt1) + ']'
		# プログラムの実行
		pid = fork do
			exec w_exec
		end
		sleep 0.01	# 予期せぬエラーの回避のため、待つ(これを行わないと、ruby ver1.4上で呼び出されたスクリプトにエラーが発生する)
		# 実行したプログラムが終わるまで待つ(引数の２番目は、1.4でのエラー回避のため)
		Process.waitpid(pid, 0)


	else
		# .redファイル以外である

		# Dia・defファイル名のセット
		case	site_flag
		when	'1'
			dia_file = std_form + ls_w1 + '.dia'
			def_file = std_record + ls_w1 + '.def'
		when	'2'
			dia_file = site_form + ls_w1 + '.dia'
			def_file = site_record + ls_w1 + '.def'
		else
			dia_file = std_form + ls_w1 + '.dia'
			def_file = std_record + ls_w1 + '.def'
		end

		lp_name = d2[30, 20].strip	# LP名のセット
		word3 = d2[51, (d2_len - 51)]	# 一時ファイルへ出力する内容のセット


		# 一時ファイルへの書き込み
		open(temp_file, "w") do |fp|
			fp.print word3
			fp.print ' ' * 10000
		end
# デバッグ用の表示
		case	word3
		when	nil
			puts	'改行のみです' + '[' + String(li_cnt1) + ']'
		when	''
			puts	'改行のみです' + '[' + String(li_cnt1) + ']'
		else
			if d2 =~ /\A\s*\z/
				puts	'空白・改行です' + '[' + String(li_cnt1) + ']'
#			else
#				puts	'OK [' + String(li_cnt1) + ']'
			end
		end
		w_exec = exec_file + ' ' + dia_file + ' ' + def_file + ' ' + temp_file
#		w_exec = exec_file + ' ' + dia_file2 + ' ' + def_file2 + ' ' + temp_file2
		# LP名が指定されていたら、引数に追加
		if lp_name != ''
			w_exec = w_exec + ' ' + lp_name
		end
# デバッグ用の表示
#		puts w_exec
# **
		# 実行前メッセージ出力
		puts	'Print Start [' + String(li_cnt1) + ']'
		# プログラムの実行
		pid = fork do
			exec w_exec
		end
		sleep 0.01	# 予期せぬエラーの回避のため、待つ(これを行わないと、ruby ver1.4上で呼び出されたスクリプトにエラーが発生する)
		# 実行したプログラムが終わるまで待つ(引数の２番目は、1.4でのエラー回避のため)
		Process.waitpid(pid, 0)

	end
end



# ============================================================

# 一時ファイル削除
begin
	if nil != File.size(temp_file)
		# 一時ファイルが存在する
		# 一時ファイルの削除
		File.delete(temp_file)
	end
rescue
# 例外が発生すれば、一時ファイルが存在しない
end



# ============================================================


