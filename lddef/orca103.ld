# 1 "orca103.ld.in"
name	orca103;

arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGX01";
bind	"X01"		"OpenCOBOL"	"ORCGX01";
bind	"X02"		"OpenCOBOL"	"ORCGX02";
bind	"X98"		"OpenCOBOL"	"ORCGX98";
bind	"XERR"		"OpenCOBOL"	"ORCGXERR";
bind	"XID1"		"OpenCOBOL"	"ORCGXID1";

multiplex_group	orca103;

# 1 "orcahome.inc" 1
home	"/usr/local/orca/lib";
# 15 "orca103.ld.in" 2


data	{
	spa	orcaspa;
	window	{
		X01;
		X02;
                X98;
		XERR;
		XID1;
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

# 28 "orca103.ld.in" 2



