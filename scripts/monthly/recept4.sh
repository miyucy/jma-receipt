#!/bin/bash
ORCADIR=/usr/local/orca
ORCABT="$ORCADIR"/lib
DBSTUB=/usr/local/panda/bin/dbstub
#-------------------------------------------#
#    レセ電ファイル作成処理
#        CPCOMMONSHELL1.INC  
#        $1 SRYYM TERID SYSYMD
#        $2 請求年月
#        $3 提出先
#        $4 ファイル形式
#        $5 レセ電ファイル出力先
#        $6 JOBID 
#        $7 SHELLID
#        $8 エラーファイル名 
#-------------------------------------------#
##      エラーファイル削除
	echo $#
	echo "echo " $8
        if  [ -e $8 ]; then
            rm  $8
        fi
        
     cd  $ORCABT

        $DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCR0200 -parameter $1$6$7
        
        if  [ $4 = '1' ]; then          
#           固定長のとき
	    $DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCR0210 -parameter $1,$2,$3,$6,$7
        else 
#           ＣＳＶのとき 
	    $DBSTUB -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCR0300 -parameter $1,$2,$3,$6,$7
        fi 
        
        if  [ -e $8 ]; then
            exit 
        fi
        
	$DBSTUB  -record "$ORCADIR"/record/ -dir "$ORCADIR"/lddef/directory -bddir "$ORCADIR"/lddef -db orca  -bd orcabt ORCBJOB -parameter JBE$6$7

        

#       漢字コード変換（ＥＵＣからシフトＪＩＳ）	
        if  [ $4 = '1' ]; then          
#           固定長のとき
	    nkf -s /var/tmp/RECE200.dat > $5RECEIPTJ.UKE
	else
#           ＣＳＶのとき 
	    nkf -s /var/tmp/RECE300.dat > $5RECEIPTC.UKE
	fi
	    
        exit 
