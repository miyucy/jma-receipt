db_group {
 type "PostgreSQL";
 port "localhost";
 name "orca";
 redirect "log";
};
db_group "log" {
 priority 100;
 type "PostgreSQL";
 file "/var/lib/jma-receipt/dbredirector/orca.log";
 redirect_port "localhost:9300";
};
db_group "shell" {
 type "Shell";
 priority 1000;
};
db_group "system" {
 type "System";
};
