#! /bin/sh
#
# Project code name "ORCA"
# 日医標準レセプトソフト(JMA standard receipt software)
#
# Copyright(C) 2002 JMA(Japan Medical Association)
#
# CREATE: 20020227
#
#
# 医療機関ＩＤリセット
#
#
echo
echo "医療機関ＩＤを振り直します"
echo
#
if [ $# -ne 0 ] ;       then
        HOSPID="$1"
else
        HOSPID="JPN000000000000"
fi
#
while [ "$OKFLG" != "Y" ] && [ "$OKFLG" != "y" ]
do
        echo
        echo -n "これでよければそのまま Enter キーを押してください " $HOSPID ": "
        read LASTHOSPID
        if [ -z $LASTHOSPID ] ;then
                LASTHOSPID="$HOSPID"
        else
                HOSPID="$LASTHOSPID"
        fi
        echo
        echo    "          ----*----*----* (15桁)"
        echo -n "HOSPID = " $LASTHOSPID " [ y/N ]: "
        read OKFLG
done
#
echo
echo "ＯＲＣＡＤＢテーブルの医療機関ＩＤをセットします"
for f in `echo "SELECT pg_class.relname FROM pg_class, pg_attribute WHERE  pg_class.relkind = 'r'  and pg_attribute.attnum > 0 and pg_attribute.attrelid = pg_class.oid and pg_attribute.attname = 'hospid';" | psql  orca | grep 'tbl'` ; do
	echo "$f ------------"
	echo "update $f set hospid = '$LASTHOSPID';" | psql orca
	echo "---------------------"
done
#
echo
echo "システム管理テーブルの医療機関ＩＤをセットします"
echo "update tbl_syskanri set kanritbl = substr(kanritbl,1,11) || '$LASTHOSPID' || '         ' || substr(kanritbl,36,465) where kanricd = '1001';" | psql orca
#
echo
echo "vacuum 処理を行います"
echo "vacuum analyze;" | psql orca
#
# 処理終了
#
echo
echo "処理はすべて終了しました"
exit 0
