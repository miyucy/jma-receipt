#!/bin/bash
ORCABT=/usr/local/orca/lib
DBSTUB=/usr/local/panda/bin/dbstub
#-------------------------------------------#
#    労災請求書用ファイル作成
#        CPCOMMONSHELL1.INC  
#        $1 SRYYM TERID SYSYMD
#        $2 SYOKBN
#           1:一括作成  2:個別作成
#        $3 RECEKBN
#           3:全体  
#        $4 エラーファイル名 
#        $5 JOBID 
#        $6 SHELLID
#-------------------------------------------#
##      エラーファイル削除
	echo $#
	echo "echo " $4
        if  [ -e $4 ]; then
            rm  $4
        fi
        
        rm  /var/tmp/RECE4*
        
     cd  $ORCABT

	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCR0400 -parameter $1$2$3$5$6
	
	   
        if  [ -e $4 ]; then
            exit  
        else 
	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCR0410 -parameter $1$5$6
        fi 

        if  [ -e $4 ]; then
            exit 
        else 
	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCR0420 -parameter $1$5$6
        fi

        if  [ -e $4 ]; then
            exit 
        else 
	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCR0430 -parameter $1$5$6
        fi

        if  [ -e $4 ]; then
            exit 
        else 
	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCR0435 -parameter $1$5$6
        fi

 
        if  [ -e $4 ]; then
            exit 
        else 
	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCR0440 -parameter $1$5$6
        fi

        if  [ -e $4 ]; then
           exit 
        else 
	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCR0450 -parameter $1$5$6
        fi
 
        if  [ -e $4 ]; then
            exit 
        else 
	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCR0460 -parameter $1$5$6
        fi

        if  [ -e $4 ]; then
            exit 
        else 
	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCR0465 -parameter $1$5$6
        fi

        if  [ -e $4 ]; then
            exit 
        else 
	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCR0466 -parameter $1$5$6
        fi

 
        if  [ -e $4 ]; then
            exit 
        else 
	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCR0470 -parameter $1$5$6
        fi

        if  [ -e $4 ]; then
            exit 
        else 
           $DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCR0480 -parameter $1$3$5$6
        fi
        
        if  [ -e $4 ]; then
            exit 
        else 
       	    $DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCR0481 -parameter $1$3$5$6
        fi
            

        if  [ -e $4 ]; then
            exit 
        else 
       	    $DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCR0482 -parameter $1$3$5$6
        fi
     
        if  [ -e $4 ]; then
            exit 
        else
	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCBJOB -parameter JBE$5$6
	fi
	
        exit 
