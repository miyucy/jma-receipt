name	orca52;

arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGG01";
bind	"G01"		"OpenCOBOL"	"ORCGG01";
bind	"G99"		"OpenCOBOL"	"ORCGG99";
bind	"GERR"		"OpenCOBOL"	"ORCGGERR";
bind	"GID1"		"OpenCOBOL"	"ORCGGID1";

multiplex_group	orca52;

home	"/usr/local/orca/lib";

data	{
	spa	orcaspa;
#	linkage	orcalink;
	window	{
                G01;
                G99;
		GERR;
		GID1;
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


