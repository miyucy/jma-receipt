#!/bin/sh

. @jma-receipt-env@

RENNUM=0
-------------------------------------------#
#    另崇山脱ファイル侯喇
#        $1-${11}
#              磅湖ＤＢ脱年盖年苞眶(CPORCSRTLNK.INC)
#        ${12} ジョブＩＤ
#        ${13} シェルＩＤ
#        ${14} 板闻怠簇ＩＤ 
#        ${15} エラ〖ファイル叹 
#-------------------------------------------#
#
##      エラ〖ファイル猴近
	echo $#
	echo "echo " ${15}
        if  [ -e ${15} ]; then
            rm  ${15}
        fi
        
        cd  $ORCABT


##          讫湍基板闻懒滇今
            RENNUM=$(expr $RENNUM + 1) 
       	    $DBSTUB -host $DBHOST -record $SITERECORDDIR -dir $LDDERDIR/directory -bddir $SITELDDEFDIR -db orca  -bd shimane SEIKYU001 -parameter $1,$2,$3,$RENNUM,$5,$6,$7,$8,$9,${10},${11},${12},${13},${14}
            if  [ -e ${15} ]; then
                exit
            fi

            
  
##          省汇板闻懒滇今
            RENNUM=$(expr $RENNUM + 1) 
       	    $DBSTUB -host $DBHOST -record $SITERECORDDIR -dir $LDDEFDIR/directory -bddir $LDDERDIR -db orca  -bd shimane SEIKYU003 -parameter $1,$2,$3,$RENNUM,$5,$6,$7,$8,$9,${10},${11},${12},${13},${14}
            if  [ -e ${15} ]; then
                exit
            fi
 
##          省汇戏客板闻懒滇今
            RENNUM=$(expr $RENNUM + 1) 
       	    $DBSTUB -host $DBHOST -record $SITERECORDDIR -dir $LDDERDIR/directory -bddir $SITELDDEFDIR -db orca  -bd shimane SEIKYU005 -parameter $1,$2,$3,$RENNUM,$5,$6,$7,$8,$9,${10},${11},${12},${13},${14}
            if  [ -e ${15} ]; then
                exit
            fi
            
	    $DBSTUB  -host $DBHOST -record $SITERECORDDIR -dir $LDDEFDIR/directory -bddir $SITELDDEFDIR -db orca  -bd orcabt ORCBJOB -parameter JBE${12}${13}

        exit 
