name	orca41;

arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGD01";
bind	"D01"		"OpenCOBOL"	"ORCGD01";
bind	"D02"		"OpenCOBOL"	"ORCGD02";
bind	"D03"		"OpenCOBOL"	"ORCGD03";
bind	"D04"		"OpenCOBOL"	"ORCGD04";
bind	"D05"		"OpenCOBOL"	"ORCGD05";
bind	"D99"		"OpenCOBOL"	"ORCGD99";
bind	"DERR"		"OpenCOBOL"	"ORCGDERR";
bind	"DID1"		"OpenCOBOL"	"ORCGDID1";
bind	"DID2"		"OpenCOBOL"	"ORCGDID2";

multiplex_group	orca41;



data	{
	spa	orcaspa;
	window	{
		D01;
		D02;
		D03;
		D04;
		D05;
		D99;
		DERR;
		DID1;
		DID2;
	};
};

db	{
	tbl_syskanri;
	tbl_jobkanri;
	tbl_chk004;
	tbl_ptinf;
	tbl_ptnum;
	tbl_jyurrk;
	tbl_nyuinacct;
	tbl_hkncombi;
	tbl_lock;
	tbl_ldmap;
	tbl_ptnyuinrrk;
	tbl_tensu;
	tbl_ptbyomei;
	tbl_chksnd;
	tbl_sryacct_main;
	tbl_sryacct_sub;
	tbl_pthkninf;
	tbl_ptkohinf;
	tbl_ptrsiinf;
	tbl_hknnum;
	tbl_chkreigai;
	tbl_inputcd;
};

/* #include "orcadb.inc" */
#include "orcadbh.inc"
