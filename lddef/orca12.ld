# 1 "orca12.ld.in"
name	orca12;

arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGP02";
bind	"P02"		"OpenCOBOL"	"ORCGP02";
bind	"P02A"		"OpenCOBOL"	"ORCGP02A";
bind	"P02D"		"OpenCOBOL"	"ORCGP02D";
bind	"P02E"		"OpenCOBOL"	"ORCGP02E";
bind	"P02F"		"OpenCOBOL"	"ORCGP02F";
bind	"P014"		"OpenCOBOL"	"ORCGP014";
bind	"P98"		"OpenCOBOL"	"ORCGP98";
bind	"P981"		"OpenCOBOL"	"ORCGP981";
bind	"P99"		"OpenCOBOL"	"ORCGP99";
bind	"P0201"		"OpenCOBOL"	"ORCGP0201";
bind	"P982"		"OpenCOBOL"	"ORCGP982";
bind	"P100"		"OpenCOBOL"	"ORCGP100";
bind	"PERR"		"OpenCOBOL"	"ORCGPERR";
bind	"PID1"		"OpenCOBOL"	"ORCGPID1";

multiplex_group	orca12;

# 1 "orcahome.inc" 1
home	"/usr/local/orca/lib";
# 24 "orca12.ld.in" 2


data	{
	spa	orcaspa;
	window	{
		P02;
		P02A;
		P02D;
		P02E;
		P02F;
		P014;
		P98;
                P981;
		P99;
		P0201;
                P982;
		P100;
		PERR;
                PID1;
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

# 46 "orca12.ld.in" 2


