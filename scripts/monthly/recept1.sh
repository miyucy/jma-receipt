#!/bin/bash
ORCADIR=/usr/local/orca
ORCABT="$ORCADIR"/lib
DBSTUB=/usr/local/panda/bin/dbstub
#-------------------------------------------#
#    医療請求書用ファイル作成
#        ２００２年１０月改正対応
#
#        CPCOMMONSHELL1.INC  
#        $1 SRYYM TERID SYSYMD
#        $2 SYOKBN
#           1:一括作成  2:個別作成
#        $3 RECEKBN
#           0:全体  1:社保　2:国保
#        $4 エラーファイル名 
#        $5 JOBID 
#        $6 SHELLID
#        $7 県単用項目編集プログラム名
#        $8 処理年月
#-------------------------------------------#
##      エラーファイル削除
	echo $#
	echo "echo " $4
        if  [ -e $4 ]; then
            rm  $4
        fi
        
        rm  /var/tmp/RECE*
        
     cd  $ORCABT

	$DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCR0010 -parameter $1$2$3$5$6
	
        if  [ -e $4 ]; then
            exit  
        else 
	$DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCR0020 -parameter $1$5$6
        fi 

        if  [ -e $4 ]; then
            exit 
        else 
	$DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCR0025 -parameter $1$5$6
        fi
 
        if  [ -e $4 ]; then
            exit 
        else 
	$DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCR0030 -parameter $1$5$6
        fi
 
        if  [ -e $4 ]; then
            exit 
        else 
	$DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCR0035 -parameter $1$5$6
        fi
 
        if  [ -e $4 ]; then
            exit 
        else 
	$DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCR0040 -parameter $1$5$6
        fi
 
        if  [ -e $4 ]; then
            exit 
        else 
	$DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCR0050 -parameter $1$5$6
        fi

        if  [ -e $4 ]; then
           exit 
        else 
	$DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCR0055 -parameter $1$5$6
        fi
 
        if  [ -e $4 ]; then
            exit 
        else 
	$DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCR0090 -parameter $1$5$6
        fi
 
        if  [ -e $4 ]; then
            exit 
        else 
	$DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCR0091 -parameter $1$5$6
        fi
 
        if  [ -e $4 ]; then
            exit 
        else 
           if  [ $7 != "NOPG" ]; then
	      $DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd recept $7 -parameter $1$5$6
	   fi
        fi

 
        if  [ -e $4 ]; then
            exit 
        else 
            if  [ $8 -lt '200210' ]; then
	        $DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCR0100 -parameter $1$3$8$5$6
            else 
	        $DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCR0103 -parameter $1$3$8$5$6
	    fi    
        fi
        
        if  [ -e $4 ]; then
            exit 
        else
	$DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCBJOB -parameter JBE$5$6
	fi
	
        exit 
