db_group {
 type "PostgreSQL";
 port "localhost";
 name "orca";
 file "orca.log";
 redirect_port "localhost";
 redirect "log";
};
db_group "log" {
 priority 100;
 type "PostgreSQL";
 port "localhost";
 name "orca";
 file "/var/lib/jma-receipt/dbredirector/orca.log";
};
db_group "shell" {
 type "shell";
 priority 1000;
};
