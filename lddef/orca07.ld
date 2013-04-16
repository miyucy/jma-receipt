name	orca07;

arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGXG01";
bind	"XG01"		"OpenCOBOL"	"ORCGXG01";
bind	"XG02"		"OpenCOBOL"	"ORCGXG02";
bind	"XG99"		"OpenCOBOL"	"ORCGXG99";
bind	"XGERR"		"OpenCOBOL"	"ORCGXGERR";
bind	"XGID1"		"OpenCOBOL"	"ORCGXGID1";

multiplex_group	orca07;


data	{
	spa	orcaspa;
	window	{
		XG01;
		XG02;
		XG99;
		XGERR;
		XGID1;
	};
};

db	{
	tbl_file_info;
	tbl_jobkanri;
	tbl_syskanri;
	tbl_toukeicsv_h;
	tbl_toukeicsv_b;
	tbl_sysuser;
};

/* #include "orcadb.inc" */
#include "orcadbh.inc"
