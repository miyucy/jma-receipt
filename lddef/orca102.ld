name	orca102;

arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGZ01";
bind	"Z01"		"OpenCOBOL"	"ORCGZ01";
bind	"Z02"		"OpenCOBOL"	"ORCGZ02";
bind	"Z03"		"OpenCOBOL"	"ORCGZ03";
bind	"Z04"		"OpenCOBOL"	"ORCGZ04";
bind	"Z05"		"OpenCOBOL"	"ORCGZ05";
bind	"Z06"		"OpenCOBOL"	"ORCGZ06";
bind	"Z90"		"OpenCOBOL"	"ORCGZ90";
bind	"Z91"		"OpenCOBOL"	"ORCGZ91";
bind	"Z97"		"OpenCOBOL"	"ORCGZ97";
bind	"Z98"		"OpenCOBOL"	"ORCGZ98";
bind	"Z99"		"OpenCOBOL"	"ORCGZ99";
bind	"ZERR"		"OpenCOBOL"	"ORCGZERR";
bind	"ZID1"		"OpenCOBOL"	"ORCGZID1";
bind	"ZID2"		"OpenCOBOL"	"ORCGZID2";

multiplex_group	orca102;

home	"/usr/local/orca/lib";

data	{
	spa	orcaspa;
#	linkage	orcalink;
	window	{
		Z01;
		Z02;
		Z03;
		Z04;
		Z05;
		Z06;
                Z90;
                Z91;
                Z97;
                Z98;  
		Z99;
		ZERR;
		ZID1;
		ZID2;
	};
};
db	{
	tbl_syskanri;
	tbl_byomei;
	tbl_chk;
	tbl_inputcd;
	tbl_hkncombi;
	tbl_hknnum;
	tbl_inputset;
	tbl_adrs;
	tbl_jyurrk;
	tbl_srykarrk;
	tbl_ptbyomei;
	tbl_ptcom;
	tbl_ptnum;
	tbl_pthkninf;
	tbl_ptkohinf;
	tbl_ptinf;
	tbl_kyuseirrk;
	tbl_sryacct;
	tbl_sryact;
	tbl_syumei;
	tbl_syunou;
	tbl_tsyrrk;
	tbl_tensu;
	tbl_uketuke;
	tbl_yyk;
	tbl_sykrrk;
	tbl_tnkrrk;
	tbl_wksryact;
	tbl_santei;
	tbl_para;
        tbl_receprt;
        tbl_srycdchg; 
        tbl_tensuplus;
	tbl_hknjainf;
	tbl_seikyu;
	view_bd001;
	view_bd002;
	tbl_userbyomei;
	tbl_jobkanri;
	tbl_rececom;
	tbl_example;
	tbl_dbkanri;
	tbl_recekanri;
	tbl_ptrsiinf;
	tbl_prtkanri;
	tbl_prtdata;
	query_ptinf;
	query_ptinf_cnt;
	tbl_interact;
	tbl_sskijyo;
	tbl_jinmei;
	tbl_monthlynum;
	view_Q001;
        tbl_yakujyo;
};
db	"shell"	{
	shell;
};


