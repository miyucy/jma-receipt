#! /bin/sh

INITDIR=/usr/local/orca/init
PATH=$PATH:/usr/lib/postgresql/bin

if su - postgres -c 'psql template1 -l|grep orca'
then
    echo "Database exist."
else
    su - postgres -c "psql -e template1 < $INITDIR/orca_user.dump"
    su - orca -c createdb
    su - orca -c "psql -e orca < $INITDIR/orca_dbkanri_orig.dump"
fi
echo "Done."
