# 1 "orca24.ld.in"
name	orca24;

arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGJ02";
bind	"J02"		"OpenCOBOL"	"ORCGJ02";
bind	"J021"		"OpenCOBOL"	"ORCGJ021";
bind	"J022"		"OpenCOBOL"	"ORCGJ022";
bind	"J023"		"OpenCOBOL"	"ORCGJ023";
bind	"J024"		"OpenCOBOL"	"ORCGJ024";
bind	"J03"		"OpenCOBOL"	"ORCGJ03";
bind	"J04"		"OpenCOBOL"	"ORCGJ04";
bind	"J041"		"OpenCOBOL"	"ORCGJ041";
bind	"J042"		"OpenCOBOL"	"ORCGJ042";
bind	"J98"		"OpenCOBOL"	"ORCGJ98";
bind	"J99"		"OpenCOBOL"	"ORCGJ99";
bind	"JERR"		"OpenCOBOL"	"ORCGJERR";
bind	"JID1"		"OpenCOBOL"	"ORCGJID1";

multiplex_group	orca24;

# 1 "orcahome.inc" 1
home	"/usr/local/orca/lib";
# 23 "orca24.ld.in" 2



data	{
	spa	orcaspa;
	window	{
		J02;
		J021;
                J022;
                J023;
                J024;
		J03;
		J04;
		J041;
		J042;
		J98;
		J99;
                JERR;
                JID1;
	};
};


# 1 "orcadb.inc" 1
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
	q_tbl_ptinf;
	q_tbl_ptinf_cnt;
	tbl_interact;
	tbl_sskijyo;
};
db	"shell"	{
	shell;
};

# 46 "orca24.ld.in" 2


