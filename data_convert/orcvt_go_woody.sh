#!/bin/sh

if test -z "$JMARECEIPT_ENV" ; then
    JMARECEIPT_ENV="/etc/jma-receipt/jma-receipt.env"
fi
if ! test -f "$JMARECEIPT_ENV" ; then
    exit 0
fi

. $JMARECEIPT_ENV
export COB_LIBRARY_PATH="$ORCALIBDIR":/usr/lib/panda:/usr/lib/open-cobol

cd $exec_prefix

$DBSTUB -dir "$LDDEFDIR"/directory -bd orcabt $1
