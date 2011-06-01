name    sessionend;

bind	""		"OpenCOBOL"	"ORCGSESEND";

data {
 spa orcaspa;
	window {
		sessionend;
	};
};

db {
 tbl_lock;
};

#include "orcadbh.inc"
