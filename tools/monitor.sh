#! /bin/sh

####################################################################
# jma-receiptサーバーをソースの位置から起動する
# 開発用 monitor
# monitor.sh [LD名]
#
# 例) 
# $ cd jma-receipt
# $ tools/monitor.sh orca21
####################################################################

# glserver を起動するか？
Start_GLSERVER=true

# jma-receipt の位置
# . は jma-receipt/ 直下で起動される事を想定している
ORCA_DIR=.

# 起動する LDのリスト(引数により上書きされる)
LD="orca01 orca02 orca11 orca12 orca13 orca14 orca18 orca19 orca21 orca22 
    orca23 orca24 orca31 orca32 orca33 orca34 orca36 orca41 orca42 orca43
    orca44 orca51 orca52 orca71 orca82 orca101 orca102 orca103 orca104 
    orca105 orca106 orca107 claim"

# 常に起動するLD
# このLDは引数に関係なく起動される
ALWAYS_LD="orca00"

# aps のポート番号 
# この番号+ LDの数値 (orca101 なら 101) = 9201
# で起動される。
START_PORT=9100

COB_LIBRARY_PATH=/usr/lib:"$ORCA_DIR"/cobol/common:"$ORCA_DIR"/cobol/orcabt

####################################################################

if test -x /usr/local/panda/bin/aps; then
    PANDA_SERVER_DIR=/usr/local/panda/bin
else
    PANDA_SERVER_DIR=/usr/lib/panda/sbin
fi
APS="$PANDA_SERVER_DIR"/aps
WFC="$PANDA_SERVER_DIR"/wfc
GLSERVER="$PANDA_SERVER_DIR"/glserver

DIRECTORY="$ORCA_DIR"/lddef/directory
LDDEF="$ORCA_DIR"/lddef
SCREEN="$ORCA_DIR"/screen
RECORD="$ORCA_DIR"/record

####################################################################

if test "x"$1 != "x"; then
    LD=$@
fi

for i in $ALWAYS_LD $LD; do
    COB_LIBRARY_PATH=$COB_LIBRARY_PATH:"$ORCA_DIR"/cobol/"$i"
done
export COB_LIBRARY_PATH
export JMARECEIPT_ENV="$ORCA_DIR"/etc/jma-receipt.env

if test "x"$Start_GLSERVER = "xtrue"; then
    trap "server_exit" 2
    #server end
    server_exit()
    {
	kill $glpid
	exit
    }
    #server start
    $GLSERVER -screen $SCREEN -record $RECORD &
    glpid=`echo $!`
fi


for i in $ALWAYS_LD; do
    LDNUM=`echo $i|sed -e "s/[^0-9]//g"`
    ORCA_PORT=`expr $START_PORT + $LDNUM`
    $APS -dir $DIRECTORY -lddir $LDDEF -base $ORCA_DIR $i -port $ORCA_PORT >/dev/null&
done

for i in $LD; do
    LDNUM=`echo $i|sed -e "s/[^0-9]//g"`
    ORCA_PORT=`expr $START_PORT + $LDNUM`
    $APS -dir $DIRECTORY -lddir $LDDEF -base $ORCA_DIR $i -port $ORCA_PORT &
done

$WFC -dir $DIRECTORY -lddir $LDDEF -base $ORCA_DIR >/dev/null


