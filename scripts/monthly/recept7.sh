#!/bin/bash
ORCABT=/usr/local/orca/lib
DBSTUB=/usr/local/panda/bin/dbstub
#-------------------------------------------#
#    労災医療請求書出力処理
#        CPCOMMONSHELL1.INC($3-$6)  
#        $1 JOBID 
#        $2 SHELLID
#        $3 SRYYM TERID SYSYMD
#        $4 実行プログラム
#           0:ORCR0101
#           1:ORCR0102 
#        $5 RECEKBN
#           3:全体  4:短期　5:傷病年金
#                   6:アフターケア
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
	   $DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCR0490 -parameter $1,$2,$3,$7,$8,$9,${10},
        else 
	   $DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCR0500 -parameter $1,$2,$3,$7,$8
           if  [ -e $6 ]; then
               exit 
           else
	       $DBSTUB -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCBJOB -parameter JBE$1$2
           fi
        fi

        exit