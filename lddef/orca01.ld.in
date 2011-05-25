name	orca01;

arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGXA01";
bind	"XA01"		"OpenCOBOL"	"ORCGXA01";
bind	"XA02"		"OpenCOBOL"	"ORCGXA02";
bind	"XA99"		"OpenCOBOL"	"ORCGXA99";
bind	"XAERR"		"OpenCOBOL"	"ORCGXAERR";
bind	"XAID1"		"OpenCOBOL"	"ORCGXAID1";
bind	"XAID2"		"OpenCOBOL"	"ORCGXAID2";

multiplex_group	orca01;


data	{
	spa	orcaspa;
	window	{
		XA01;
		XA02;
		XA99;
		XAERR;
                XAID1;
                XAID2;
	};
};

db	{
	tbl_syskanri;
	tbl_jobkanri;
	tbl_prtkanri;
	tbl_prtdata;
	tbl_ldmap;
	tbl_ptinf;
	tbl_ptnum;
};

/* #include "orcadb.inc" */
#include "orcadbh.inc"
