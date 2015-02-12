db_group {
 type "PostgreSQL";
# port "192.168.1.153";
# name "a48";
# password "orca"; 
 port "";
 name "r48";
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
