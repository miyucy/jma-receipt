#!/bin/sh

. @jma-receipt-env@

-------------------------------------------#
#    孟数给锐懒滇今磅湖
#        $1 SRYYM TERID SYSYMD
#        $2 エラ〖ファイル叹 
#-------------------------------------------#
##      エラ〖ファイル猴近
	echo $#
	echo "echo " $2
        if  [ -e $2 ]; then
            rm  $2
        fi
        
##      讫湍基板闻懒滇今
        $DBSTUB -host $DBHOST -record $SITERECORDDIR -dir $LDDEFDIR/directory -bddir $SITELDDEFDIR -db orca  -bd shimane ORCBS321 -parameter $1
        if  [ -e $2 ]; then
            exit
        fi
  
##      省汇板闻懒滇今
        $DBSTUB -host $DBHOST -record $SITERECORDDIR -dir $LDDEFDIR/directory -bddir $SITELDDEFDIR -db orca  -bd shimane ORCBS323 -parameter $1
        if  [ -e $2 ]; then
            exit
        fi  
 
##      省汇戏客板闻懒滇今
        $DBSTUB -host $DBHOST -record $SITERECORDDIR -dir $LDDEFDIR/directory -bddir $SITELDDEFDIR -db orca  -bd shimane ORCBS325 -parameter $1
        if  [ -e $2 ]; then
            exit
        fi  

        exit 
