name	orca13;

arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGQ01";
bind	"Q01"		"OpenCOBOL"	"ORCGQ01";
bind	"Q02"		"OpenCOBOL"	"ORCGQ02";
bind	"Q97"		"OpenCOBOL"	"ORCGQ97";
bind	"Q98"		"OpenCOBOL"	"ORCGQ98";
bind	"Q99"		"OpenCOBOL"	"ORCGQ99";
bind	"Q100"		"OpenCOBOL"	"ORCGQ100";
bind	"QERR"		"OpenCOBOL"	"ORCGQERR";
bind	"QID1"		"OpenCOBOL"	"ORCGQID1";

multiplex_group	orca13;

home	"/usr/local/orca/lib";

data	{
	spa	orcaspa;
#	linkage	orcalink;
	window	{
		Q01;
		Q02;
		Q97;
		Q98;
		Q99;
		Q100;
                QERR;
                QID1;
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



