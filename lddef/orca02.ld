name	orca02;

arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGXB01";
bind	"XB01"		"OpenCOBOL"	"ORCGXB01";
bind	"XBER"   	"OpenCOBOL"	"ORCGXBERR";
bind	"XBID"   	"OpenCOBOL"	"ORCGXBID1";

multiplex_group	orca02;


data	{
	spa	orcaspa;
	window	{
		XB01;
                XBER;
                XBID;
	};
};

db	{
	tbl_jobkanri;
};

/* #include "orcadb.inc" */
#include "orcadbh.inc"
