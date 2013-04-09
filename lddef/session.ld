name    session;

bind	"session_end"		"OpenCOBOL"	"ORCGSESEND";

data {
 spa orcaspa;
	window {
		session_end;
	};
};

db {
 tbl_lock;
};

#include "orcadbh.inc"
