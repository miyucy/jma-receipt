#!/bin/bash
ORCABT=/usr/local/orca/lib
DBSTUB=/usr/local/panda/bin/dbstub
#-------------------------------------------#
#    バックアップ処理
#        $1   TABLE-NAME
#        $2   CNV-NAME
#        $3   OUT-NAME-WK
#        $4$5 OUT-NAME
#        $6   KBEN
#-------------------------------------------#
##

        if  [ -e $4$5 ]; then
            rm  $4$5
        fi

        pg_dump -R orca > $4$5

	$DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCBJOB -parameter JBE0000001ORCBSF1

        exit