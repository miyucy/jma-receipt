name	orca00;

arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGM00";
bind	"M00"		"OpenCOBOL"	"ORCGM00";
bind	"M01"		"OpenCOBOL"	"ORCGM01";
bind	"M02"		"OpenCOBOL"	"ORCGM02";
bind	"M95"		"OpenCOBOL"	"ORCGM95";
bind	"M96"		"OpenCOBOL"	"ORCGM96";
bind	"MERR"		"OpenCOBOL"	"ORCGMERR";
bind	"MID1"		"OpenCOBOL"	"ORCGMID1";
bind	"MVER"		"OpenCOBOL"	"ORCGMVER";

multiplex_group	orca00;

home	"/usr/local/orca/lib";

data	{
	spa	orcaspa;
#	linkage	orcalink;
	window	{
                M00;
		M01;
                M02;
                M95;
		M96;
                MERR;
                MID1;
		MVER;
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

