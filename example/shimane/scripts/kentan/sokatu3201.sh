#!/bin/sh

. @jma-receipt-env@

RENNUM=0
-------------------------------------------#
#    決定通知書（社保）作成
#        $1-${11}
#              印刷ＤＢ用定固定引数(CPORCSRTLNK.INC)
#        ${12} ジョブＩＤ
#        ${13} シェルＩＤ
#        ${14} 総括表の種類
#           0:全体  1:社保　2:国保
#        ${15} 医療機関ＩＤ 
#        ${16} エラーファイル名 
#-------------------------------------------#
#
##      エラーファイル削除
	echo $#
	echo "echo " ${16}
        if  [ -e ${16} ]; then
            rm  ${16}
        fi
        
        cd  $ORCABT

##      決定通知書（社保）
        RENNUM=$(expr $RENNUM + 1) 
        $DBSTUB -host $DBHOST -record $SITERECORDDIR -dir $LDDEFDIR/directory -bddir $SITELDDEFDIR -db orca  -bd shimane SYUKEI001 -parameter $1,$2,$3,$RENNUM,$5,$6,$7,$8,$9,${10},${11},${12},${13},${15}
        if  [ -e ${16} ]; then
             exit
        fi
        
	$DBSTUB  -host $DBHOST -record $SITERECORDDIR -dir $LDDEFDIR/directory -bddir $SITELDDEFDIR -db orca  -bd orcabt ORCBJOB -parameter JBE${12}${13}


