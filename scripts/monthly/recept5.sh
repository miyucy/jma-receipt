#!/bin/bash
ORCABT=/usr/local/orca/lib
DBSTUB=/usr/local/panda/bin/dbstub
-------------------------------------------#
#    未請求一覧作成
#        CPCOMMONSHELL1.INC  
#        $1 SRYYM TERID SYSYMD
#        $2 RECEKBN(総括表の種類)
#           0:全体  1:社保　2:国保
#        $3 エラーファイル名 
#        $4 医療機関ＩＤ 
#        $5 端末ＩＤ　Ｘ（３２） 
#-------------------------------------------#
##      エラーファイル削除
	echo $#
	echo "echo " $3
        if  [ -e $3 ]; then
            rm  $3
        fi
        
        cd  $ORCABT

##      未請求一覧
     	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCBM005 -parameter $1,$4,$2,$5
