# 薬剤情報マスタに登録する雛型マスタを提供サイトより引く
#
# 引数１：診療行為コード（医薬品コード）９桁
# 引数２：端末ＩＤ
# 引数３：雛型マスタ提供サイト
# 引数４：写真ファイルダウンロードサイト
# 引数５：写真ファイル格納テンポラリフォルダ

# 引数は環境変数 MEDSIORIPARAM から取得します
#

require	"monlib"
require	"apslib"

param = ENV["MEDSIORIPARAM"]

para = param.split(/,/)
srycd = para[0]
termid = para[1]
siorisite = para[2]
photosite = para[3]
phototemp = para[4]

db = PandaDB.new
db.execFunction("DBOPEN")
db.execFunction("DBSTART")

tempdb = PandaTable.new(db,"tbl_yakujyo_temp")
tempdb["tbl_yakujyo_temp.termid"] = termid
tempdb.execFunction("DBDELETE","termid")
	  
server = PG_Server.new(siorisite,0,"panda:siori","guest","")
server.setEncoding("euc-jp")
server.setValue("yjtemp.siorikey.srycd", srycd)
ev = server.event("Search")
count = server.getValue("yjtemp.siorirec.count").to_i

time = Time.new
creymd = time.strftime("%Y%m%d")

i = 0;

while i < count
	tempdb["tbl_yakujyo_temp.termid"] = termid
	tempdb["tbl_yakujyo_temp.srycd"] = server.getValue(sprintf("yjtemp.siorirec.item[%d].value1",i))
	tempdb["tbl_yakujyo_temp.yjcd"] = server.getValue(sprintf("yjtemp.siorirec.item[%d].value2",i))
	tempdb["tbl_yakujyo_temp.rennum"] = server.getValue(sprintf("yjtemp.siorirec.item[%d].value3",i))
	tempdb["tbl_yakujyo_temp.shape"] = server.getValue(sprintf("yjtemp.siorirec.item[%d].value4",i))
	tempdb["tbl_yakujyo_temp.color"] = server.getValue(sprintf("yjtemp.siorirec.item[%d].value5",i))
	tempdb["tbl_yakujyo_temp.mark"] = server.getValue(sprintf("yjtemp.siorirec.item[%d].value6",i))
	tempdb["tbl_yakujyo_temp.effect"] = server.getValue(sprintf("yjtemp.siorirec.item[%d].value7",i))
	tempdb["tbl_yakujyo_temp.caution"] = server.getValue(sprintf("yjtemp.siorirec.item[%d].value8",i))
	tempdb["tbl_yakujyo_temp.make_company"] = server.getValue(sprintf("yjtemp.siorirec.item[%d].value9",i))
	tempdb["tbl_yakujyo_temp.sale_company"] = server.getValue(sprintf("yjtemp.siorirec.item[%d].value10",i))

	filename = server.getValue(sprintf("yjtemp.siorirec.item[%d].value11",i))
	tempdb["tbl_yakujyo_temp.photo1_filename"] = filename
	if filename != ""
		system("/usr/bin/wget", "-q", "--passive-ftp", "-O", "#{phototemp}/#{filename}", "#{photosite}/#{filename}")
	end

	filename = server.getValue(sprintf("yjtemp.siorirec.item[%d].value12",i))
	tempdb["tbl_yakujyo_temp.photo2_filename"] = filename
	if filename != ""
		system("/usr/bin/wget", "-q", "--passive-ftp", "-O", "#{phototemp}/#{filename}", "#{photosite}/#{filename}")
	end
		
	filename = server.getValue(sprintf("yjtemp.siorirec.item[%d].value13",i))
	tempdb["tbl_yakujyo_temp.photo3_filename"] = filename
	if filename != ""
		system("/usr/bin/wget", "-q", "--passive-ftp", "-O", "#{phototemp}/#{filename}", "#{photosite}/#{filename}")
	end

	tempdb["tbl_yakujyo_temp.creymd"] = creymd
	tempdb.execFunction("DBINSERT","srycd")
	i += 1;
end

db.execFunction("DBCOMMIT")
db.execFunction("DBDISCONNECT")

server.close
