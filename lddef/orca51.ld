# 1 "orca51.ld.in"
name	orca51;

arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGL01";
bind	"L01"		"OpenCOBOL"	"ORCGL01";
bind	"L99"		"OpenCOBOL"	"ORCGL99";
bind	"LERR"		"OpenCOBOL"	"ORCGLERR";
bind	"LID1"		"OpenCOBOL"	"ORCGLID1";

multiplex_group	orca51;

# 1 "orcahome.inc" 1
home	"/usr/local/orca/lib";
# 14 "orca51.ld.in" 2


data	{
	spa	orcaspa;
	window	{
                L01;
                L99;
		LERR;
		LID1;
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

# 26 "orca51.ld.in" 2


