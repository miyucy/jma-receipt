#!/bin/bash
ORCABT=/usr/local/orca/lib
DBSTUB=/usr/local/panda/bin/dbstub
#-------------------------------------------#
#    データチェク処理
#        CPCOMMONSHELL5.INC
#        $1 SRYYM TERID SYSYMD
#        $2 SYOKBN
#        $3 RECEKBN
#        $4 エラーファイル名 
#-------------------------------------------#
##

	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCGE03 -parameter $1$2$3
	
	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCBJOB -parameter JBE0000001ORCBSE1
	
        exit
