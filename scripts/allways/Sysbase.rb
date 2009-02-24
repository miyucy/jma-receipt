#!/usr/bin/ruby

$:.unshift(File.dirname(__FILE__) + "/../daily")

require	"apslib"
require	"kconv"

def sysbase_list_print_title
  $stderr.printf("\n グループ|医療機関| 期  限 |本分院|本分院|医療機関名\n") 
  $stderr.printf(  " 番    号|識別番号|        |番  号|区  分|(下段：システム管理)\n") 
  $stderr.printf(  " --------+--------+--------+------+------+----------------------------------------\n") 
end

def sysbase_list_print_body
    $stderr.printf("    %-9s%-6s%-11s%-7s%-5s%-s\n",@item[0],@item[1],@item[2],@item[3],@item[4],@item[5])
    $stderr.printf("                                          %s\n",@item[6])
end

def syskanri_hospname
  syskanri = PandaTable.new(@db,"tbl_syskanri")

  t = Time.new
  today = t.strftime("%Y%m%d")

  syskanri["tbl_syskanri.HOSPNUM"] = @item[1]
  syskanri["tbl_syskanri.KANRICD"] = "1001"
  syskanri["tbl_syskanri.KBNCD"] = "*"
  syskanri["tbl_syskanri.STYUKYMD"] = today
  syskanri["tbl_syskanri.EDYUKYMD"] = today

  syskanri.execFunction("DBSELECT","key10")

  if syskanri.execFunction("DBFETCH","key10") == 0
    @item[6] = syskanri["tbl_syskanri.KANRITBL"][35,100].strip
    if @item[6] != nil
      @item[6] = Kconv.kconv(@item[6],Kconv::UTF8)
    end
  end
  syskanri.execFunction("DBCLOSECURSOR","key10")
end

def sysbase_list
  sysbase = PandaTable.new(@db,"tbl_sysbase")

  if "#{@hbgroup}".size == 0
    key = 'all'
  elsif "#{@hbgroup}".size != 0
    key = 'key2'
    sysbase["tbl_sysbase.HONBUNGRP"] = @hbgroup
  else
    return
  end

  sysbase.execFunction("DBSELECT",key)

  sysbase_list_print_title

  while sysbase.execFunction("DBFETCH",key) == 0
    @item[0] = sysbase["tbl_sysbase.GRPNUM"]
    @item[1] = sysbase["tbl_sysbase.HOSPNUM"]
    @item[2] = sysbase["tbl_sysbase.KIGEN"]
    @item[3] = sysbase["tbl_sysbase.HONBUNGRP"]
    @item[4] = sysbase["tbl_sysbase.HONBUNKBN"]
    @item[5] = sysbase["tbl_sysbase.HOSPNAME"]
    if @item[5] != nil
      @item[5] = Kconv.kconv(@item[5],Kconv::UTF8)
    end
    syskanri_hospname
    sysbase_list_print_body
  end
  sysbase.execFunction("DBCLOSECURSOR",key)
end

def sysbase_add
  sysbase = PandaTable.new(@db,"tbl_sysbase")

  t = Time.new
  creymd = t.strftime("%Y%m%d")
  cretime = t.strftime("%H%M%S")
  p cretime

  sysbase["tbl_sysbase.GRPNUM"] = @groupnum
  sysbase["tbl_sysbase.HOSPNUM"] = @hospnum
  sysbase["tbl_sysbase.KIGEN"] = @kigen
  sysbase["tbl_sysbase.HONBUNGRP"] = @hbgroup
  sysbase["tbl_sysbase.HONBUNKBN"] = @hbkubun
  sysbase["tbl_sysbase.HOSPNAME"] = @hospname
  sysbase["tbl_sysbase.CREYMD"] = creymd
  sysbase["tbl_sysbase.UPYMD"] = ""
  sysbase["tbl_sysbase.UPHMS"] = cretime
  sysbase.execFunction("DBINSERT","key")
end

def sysbase_mod
  sysbase = PandaTable.new(@db,"tbl_sysbase")

  t = Time.new
  upymd = t.strftime("%Y%m%d")
  uptime = t.strftime("%H%M%S")

  if "#{@hospnum}".size != 0
    sysbase["tbl_sysbase.HOSPNUM"] = @hospnum
    if sysbase.execFunction("DBSELECT","key") == 0
      rc = sysbase.execFunction("DBFETCH","key")
      sysbase.execFunction("DBCLOSECURSOR","key")
      if rc != 0
        $stderr.printf("NOTICE: 指定された医療機関識別番号はありませんでした。\n")
        return
      end
    else
      $stderr.printf("ERROR: 医療機関識別番号が正しくありません。\n")
      return
    end
    if "#{@hospnum}".size != 0
      sysbase["tbl_sysbase.HOSPNUM"] = @hospnum
    end
    if "#{@kigen}".size != 0
      sysbase["tbl_sysbase.KIGEN"] = @kigen
    end
    if "#{@hbgroup}".size != 0
      sysbase["tbl_sysbase.HONBUNGRP"] = @hbgroup
    end
    if "#{@hbkubun}".size != 0
      sysbase["tbl_sysbase.HONBUNKBN"] = @hbkubun
    end
    if "#{@hospname}".size != 0
      sysbase["tbl_sysbase.HOSPNAME"] = @hospname
    end
    sysbase["tbl_sysbase.UPYMD"] = upymd
    sysbase["tbl_sysbase.UPHMS"] = uptime

    sysbase.execFunction("DBUPDATE","key")
  else
    $stderr.printf("ERROR: 医療機関識別番号を指定してください。\n")
  end
end

def sysbase_del
  sysbase = PandaTable.new(@db,"tbl_sysbase")

  if "#{@hospnum}".size != 0
    sysbase["tbl_sysbase.HOSPNUM"] = @hospnum
    if sysbase.execFunction("DBSELECT","key") == 0
      rc = sysbase.execFunction("DBFETCH","key")
      sysbase.execFunction("DBCLOSECURSOR","key")
      if rc != 0
        $stderr.printf("NOTICE: 指定された医療機関識別番号はありませんでした。\n")
        return
      end
    else
      $stderr.printf("ERROR: 医療機関識別番号が正しくありません。\n")
      return
    end
    sysbase.execFunction("DBDELETE","key")
  else
    $stderr.printf("ERROR: 医療機関識別番号を指定してください。\n")
  end
end

# Main

parameter = ARGV[0]
param = Array.new(8,nil)
param = parameter.split(",")

@item = Array.new(7)

command = param[0]
@groupnum = param[1]
@hospnum  = param[2]
@kigen    = param[3]
@hbgroup  = param[4]
@hbkubun  = param[5]
@hospname = param[6]
if param[6] != nil
  @hospname = Kconv.toeuc(param[6])
end

#$stderr.printf("command=[%s]\n",command)
#$stderr.printf("groupnum=[%s]\n",@groupnum)
#$stderr.printf("hospnum=[%s]\n",@hospnum)
#$stderr.printf("kigen=[%s]\n",@kigen)
#$stderr.printf("hbgroup=[%s]\n",@hbgroup)
#$stderr.printf("hbkubun=[%s]\n",@hbkubun)
#$stderr.printf("hospname=[%s]\n",@hospname)

@db = PandaDB.new
@db.execFunction("DBOPEN")
@db.execFunction("DBSTART")

case command
  when 'lst','LST'
      sysbase_list
  when 'add','ADD'
      sysbase_add
  when 'mod','MOD'
      sysbase_mod
  when 'del','DEL'
      sysbase_del
end

@db.execFunction("DBCOMMIT")
@db.execFunction("DBDISCONNECT")
