#!/bin/bash
ORCABT=/usr/local/orca/lib
DBSTUB=/usr/local/panda/bin/dbstub
-------------------------------------------#
#    決定通知書作成
#        CPCOMMONSHELL1.INC  
#        $1 SRYYM TERID SYSYMD
#        $2 RECEKBN(総括表の種類)
#           1:社保　2:国保
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

##      決定通知書（社保）
        if  [ $2 = '1' ]; then
       	    $DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCBM020 -parameter $1$5
       	fi    

##      決定通知書（国保）
        if  [ $2 = '2' ]; then
       	    $DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCBM021 -parameter $1$5
       	fi    
