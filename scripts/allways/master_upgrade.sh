#!/bin/bash
ORCADIR=/usr/local/orca
HOME=/home/orca
MSTDIR=orca-$(date +%Y%m%d)

#デバッグ用
#APSCOBOL=/home/orca/panda-0.9.17/aps/aps
#DBSTUB=/home/orca/panda-0.9./aps/dbstub
#FTP=orca:orca@localhost/pub/orca_data/
DBHOST=localhost
UPDFILE=/home/orca/$MSTDIR/ORCADBR.OUT
LEN=100
#本番用
APSCOBOL=/usr/local/panda/bin/aps
DBSTUB=/usr/local/panda/bin/dbstub
FTP=ftp.orca.med.or.jp/pub/orca_data/
#FTP=beta:inisalo@ftp.orca.med.or.jp/pub/orca_data/
#UPDFILE=/home/orca/$MSTDIR/ORCADBR.OUT

COBOLDIR=$ORCADIR/lib
function orcawget () {
#受信ファイル削除
	if [	-e	$1	]
	then
#	echo "rm start" $1
		rm $1;
	fi
	wget -q --passive-ftp ftp://$FTP/$1
#接続確認
	if [ $? -eq 0 ]	;	then 
#	echo "wget end OK"
		return 0;
	else
		return 1;
	fi
#ファイルサイズチェック
	if [	-s	$1	]
	then
		return 0;
	else
		return 1;
	fi
}

function orcatar () {
	TARFL=`echo $1 | awk '{i=split($0,arr,"/"); print arr[i]} ' `
	TAR=`echo $TARFL | awk '{i=split($0,arr,"."); print arr[i-1] arr[i]} ' `
	LOCALFL=`echo $TARFL | awk '{i=split($0,arr,"."); print arr[1]".dat"} ' ` 
	echo $LOCALFL "LOCALFL"
	echo $TARFL "TARFL"
#受信ファイル削除
	echo $1
	if [	$TAR = "targz" ]
	then
		echo $TAR "TAR"
		tar zxf $TARFL
		echo $TAR "END"
	else
		echo "NO tar end"
		return 0;
	fi
#tar確認
	if [ $? -eq 0 ]	;	then 
		echo "tar end OK"
	else
		echo "tar end NG"
		return 1;
	fi
#ファイルサイズチェック
	if [	-s	$LOCALFL	]
	then
		return 0;
	else
		return 1;
	fi
}

echo $MSTDIR
echo $UPDFILE
if ! [	-d	$HOME/$MSTDIR	];	then 
	cd $HOME
	mkdir $MSTDIR
fi
if ! [	-d	$HOME/orca-mstlog	];	then 
	cd $HOME
	mkdir orca-mstlog 
fi
cd $HOME/$MSTDIR
rm -f *.*
#センタからのDB構造体ダウンロード
if	orcawget info/ORCADBR.DAT ;	then
	echo "センタからのDBレコード管理情報のダウンロードが終了しました"
else
	echo "センタからのDBレコード管理情報のダウンロードに失敗しました"
	$DBSTUB  -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCBJOB -parameter JBE0000001MSTMNT99
        exit 99
fi

#ダウンロードファイル生成
	$DBSTUB   -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCXRMST1 -parameter $MSTDIR
	if [ $? -ne 0 ]	;	then 
		echo "ダウンロードファイル生成に失敗しました"
		$DBSTUB  -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCBJOB -parameter JBE0000001MSTMNT99
		exit 99
	fi
#更新用ダウンロードファイル受信
#ファイルサイズチェック
	if [	-s	$UPDFILE	]
	then
		echo "更新用ダウンロードファイルの作成が終了しました"
	else
		echo "更新用ダウンロードファイルの作成に失敗しました"
		$DBSTUB  -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCBJOB -parameter JBE0000001MSTMNT01
		exit 99
	fi

UPDLIST=`awk '{gsub(/\t| |;/,""); print} ' $UPDFILE`

for UPD in $UPDLIST
do
	echo ${UPD:31:$LEN}
	if	orcawget ${UPD:31:$LEN} ;	then
		echo ${UPD:31:$LEN} "ダウンロードが終了しました"
	else
		echo ${UPD:31:$LEN} "ダウンロードに失敗しました"
		$DBSTUB  -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCBJOB -parameter JBE0000001MSTMNT99
	        exit 99
	fi
done

for UPD in $UPDLIST
do
#	echo $UPD
	if	orcatar $UPD ;	then
		echo $UPD "解凍処理が終了しました"
	else
		$DBSTUB  -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCBJOB -parameter JBE0000001MSTMNT99
		echo $UPD "解凍処理に失敗しました"
	        exit 99
	fi
done
#DB構造変更処理
for UPD in $UPDLIST
do
	UPD1=`echo $UPD | awk '{gsub(/.tar.gz/,".dat"); print} ' `
	echo $UPD1 "DB更新"
#ダウンロードファイル生成
	$DBSTUB   -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCXRMST2 -parameter $MSTDIR$UPD1*****************************************************
	echo $?
	if [ $? -ne 0 ]	;	then 
		echo $UDP1 "更新処理に失敗しました"
		$DBSTUB  -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCBJOB -parameter JBE0000001MSTMNT99
		exit 99
	fi
	echo "vacuum ANALYZE tbl_tensu;" | psql orca
done
	echo "vacuum ANALYZE tbl_syskanri;" | psql orca
	echo "vacuum ANALYZE tbl_chk;" | psql orca

echo  "全ての処理が完了しました"
rm -r $HOME/$MSTDIR
	$DBSTUB  -record /usr/local/orca/record/ -dir /usr/local/orca/lddef/directory -bddir /usr/local/orca/lddef -db orca  -bd orcabt ORCBJOB -parameter JBE0000001MSTMNT00


#wait
