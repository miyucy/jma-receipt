#!/bin/bash
#-------------------------------------------#
#    自院病名一覧出力設定
#        $1 TERMID     X(32)
#        $2 SYSYMD     X(8)
#        $3 HOSPID     X(24)
#-------------------------------------------#
DBSTUB=/usr/local/panda/bin/dbstub
#-------------------------------------------# 
            $DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca -bd orcabt ORHCML09 -parameter $1,$2,$3