db_group {
 type "PostgreSQL";
 port "";
 name "orca";
 encoding "euc-jisx0213";
 redirect "log";
};
db_group "log" {
 priority 100;
 type "PostgreSQL";
 port "sub-jma-receipt";
 name "orca";
 file "/var/lib/jma-receipt/dbredirector/orca.log";
 redirect_port "localhost";
};
