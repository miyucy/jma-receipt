#!/bin/bash
ORCADIR=/usr/local/orca
ORCABT="$ORCADIR"/lib
DBSTUB=/usr/local/panda/bin/dbstub
#-------------------------------------------#
#    医療請求書出力処理
#        CPCOMMONSHELL1.INC($3-$6)  
#        $1 JOBID 
#        $2 SHELLID
#        $3 SRYYM TERID SYSYMD
#        $4 実行プログラム
#           0:ORCR0101
#           1:ORCR0102 
#        $5 RECEKBN
#           0:全体  1:社保　2:国保
#        $6 エラーファイル名 
#        $7 印刷用条件パラメタ 
#        $8 印刷開始 
#        $8 端末ＩＤX(32)  （ＯＲＣＲ０１０２のとき）
#        $9 印刷終了
#        $10 帳票識別番号
#-------------------------------------------#
##      エラーファイル削除
	echo $#
	echo "echo " $6
        if  [ -e $6 ]; then
            rm  $6
        fi
        
###     cd  $ORCABT
        

        if [ $4 =  0 ]; then
#          fcu  -P$1 ORCR0101
	   $DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCR0101 -parameter $1,$2,$3,$7,$8,$9,${10},
        else 
	   $DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCR0102 -parameter $1,$2,$3,$7,$8
           if  [ -e $6 ]; then
               exit 
           else
	       $DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCBJOB -parameter JBE$1$2
           fi
        fi

        exit
