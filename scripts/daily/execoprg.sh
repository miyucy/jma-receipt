#!/bin/bash
ORCABT=/usr/local/orca/lib
DBSTUB=/usr/local/panda/bin/dbstub
RENNUM=0
#-------------------------------------------#
#    日次統計出力処理
#        $1-${11} 印刷ＤＢ用固定引数
#        ${12} ジョブＩＤ
#        ${13} シェルＩＤ
#        ${14} 医療機関ＩＤ 
#        $15 PRGRAMID   X(08)
#        $16 PARA (1)   X(10)
#        $17 PARA (2)   X(10)
#        $18 PARA (3)   X(10)
#        $19 エラーファイル名 
#-------------------------------------------#
##
	echo $#
##      cd  ../orcabt
##      エラーファイル削除
	echo "echo " $19
        if  [ -e $19 ]; then
            rm  $19
        fi
##
        RENNUM=$(expr $RENNUM + 1) 
	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ${15} -parameter $1,$2,$3,$RENNUM,$5,$6,$7,$8,$9,${10},${11},${12},${13},${14},${16},${17},${18}

        if  [ -e ${19} ]; then
            exit
        fi
       
       $DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCBJOB -parameter JBE${12}${13}

        exit 
