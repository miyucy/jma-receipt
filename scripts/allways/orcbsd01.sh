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
##      エラーファイル削除
        if  [ -e $4 ]; then
            rm  $4
        fi

	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCGD02 -parameter $1$2$3

        if  [ -e ERFIL ]; then
            exit  
        else
	   $DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCGD03 -parameter $1$2$3
        fi

	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCGD04 -parameter $1$2$3

	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCBJOB -parameter JBE0000001ORCBSD1

##      作業ファイル削除
        if  [ -e /tmp/ORCGD1.$5.dat ]; then
             rm  /tmp/ORCGD1.$5.dat
        fi

        if  [ -e /tmp/ORCGD2.$5.dat ]; then
             rm  /tmp/ORCGD2.$5.dat
        fi

        if  [ -e /tmp/ORCGD3.$5.dat ]; then
             rm  /tmp/ORCGD3.$5.dat
        fi

        if  [ -e /tmp/ORCGD4.$5.dat ]; then
             rm  /tmp/ORCGD4.$5.dat
        fi

        if  [ -e /tmp/ORCGD5.$5.dat ]; then
             rm  /tmp/ORCGD5.$5.dat
        fi

        if  [ -e /tmp/ORCGD6.$5.dat ]; then
             rm  /tmp/ORCGD6.$5.dat
        fi

        if  [ -e /tmp/ORCGD7.$5.dat ]; then
             rm  /tmp/ORCGD7.$5.dat
        fi

        if  [ -e /tmp/ORCGD8.$5.dat ]; then
             rm  /tmp/ORCGD8.$5.dat
        fi

        if  [ -e /tmp/ORCGD9.$5.dat ]; then
             rm  /tmp/ORCGD9.$5.dat
        fi

        exit