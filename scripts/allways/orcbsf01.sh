#!/bin/bash
#-------------------------------------------#
#    バックアップ処理
#        $1   TABLE-NAME
#        $2   CNV-NAME
#        $3   OUT-NAME-WK
#        $4$5 OUT-NAME
#        $6   KBEN
#-------------------------------------------#
##

        if  [ $6 -ne 1 ]; then
            if  [ -e $4$5 ]; then
                rm  $4$5
            fi
            pg_dump -R -t $1 orca > $4$5
        else
            pg_dump -R -t $1 orca > /tmp/$2.out
            cat  /tmp/$2.out  /tmp/$3.out  >  $4$5
            rm   /tmp/$2.out
        fi

        cat  $4$5  >  /tmp/$3.out
