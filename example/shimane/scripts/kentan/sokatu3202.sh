#!/bin/sh

. @jma-receipt-env@

RENNUM=0
-------------------------------------------#
#    決定通知書（国保）作成
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
        

##      決定通知書（国保）
        RENNUM=$(expr $RENNUM + 1) 
        $DBSTUB -dir $LDDEFDIR/directory -bd shimane SYUKEI002 -parameter  $1,$2,$3,$RENNUM,$5,$6,$7,$8,$9,${10},${11},${12},${13},${15}
        if  [ -e ${16} ]; then
             exit
        fi
        
	$DBSTUB -dir $LDDEFDIR/directory -bd orcabt ORCBJOB -parameter JBE${12}${13}
