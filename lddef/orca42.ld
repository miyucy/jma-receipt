# 1 "orca42.ld.in"
name	orca42;

arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGR01";
bind	"R01"		"OpenCOBOL"	"ORCGR01";
bind	"R02"		"OpenCOBOL"	"ORCGR02";
bind	"R03"		"OpenCOBOL"	"ORCGR03";
bind	"R04"		"OpenCOBOL"	"ORCGR04";
bind    "R98"		"OpenCOBOL"	"ORCGR98";
bind	"R99"		"OpenCOBOL"	"ORCGR99";
bind	"RERR"		"OpenCOBOL"	"ORCGRERR";
bind	"RID1"		"OpenCOBOL"	"ORCGRID1";
bind	"RID2"		"OpenCOBOL"	"ORCGRID2";

multiplex_group	orca42;

# 1 "orcahome.inc" 1
home	"/usr/local/orca/lib";
# 19 "orca42.ld.in" 2


data	{
	spa	orcaspa;
	window	{
		R01;
                R02;
                R03;
                R04;
                R98;
                R99;
		RERR;
                RID1;
                RID2;
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

# 36 "orca42.ld.in" 2


