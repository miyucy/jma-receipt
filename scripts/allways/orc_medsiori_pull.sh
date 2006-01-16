#!/bin/sh

if test -z "$JMARECEIPT_ENV" ; then
    JMARECEIPT_ENV="./etc/jma-receipt.env"
fi
if ! test -f "$JMARECEIPT_ENV"; then
    exit 0
fi

. $JMARECEIPT_ENV

# DBSTUB="/usr/lib/panda/sbin/dbstub -nocheck "
# LDDIRECTORY=./directory
MEDSIORISITE="192.168.1.104"
MEDPHOTOSITE="ftp://orca:orca@192.168.1.104/public_html/jma-siori-photo"
MEDPHOTOTEMP="/tmp/medphoto"

# SRYCD="610443074"
# TERMID="toshichan"

#-------------------------------------------#
#    薬剤情報マスタ医薬品しおりダウンロード処理
#
#	引数より
#        $1  SRYCD 医薬品コード（９桁）
#        $2  TERMID
#        $3  JOBID 
#        $4  SHELLID
#
#	環境変数より
#        $5  MEDSIORISITE
#        $6  MEDSIORISITE
#        $7  MEDPHOTOTEMP
#-------------------------------------------#

# 画像ファイル格納ディレクトリの作成
	if ! [ -d   $MEDPHOTOTEMP ];	then
		mkdir $MEDPHOTOTEMP
	fi

# センターサーバより雛型を取り込む
	MEDSIORIPARAM="$1,$2,$MEDSIORISITE,$MEDPHOTOSITE,$MEDPHOTOTEMP"
	export MEDSIORIPARAM

	$DBSTUB -dir $LDDIRECTORY -bd orcabt OrcSioriPull -parameter ""
	
	$DBSTUB -dir $LDDIRECTORY -bd orcabt ORCBJOB -parameter JBE$3$4
	exit 
