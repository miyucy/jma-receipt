# 1 "orca01.ld.in"
name	orca01;

arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGXA01";
bind	"XA01"		"OpenCOBOL"	"ORCGXA01";
bind	"XA99"		"OpenCOBOL"	"ORCGXA99";
bind	"XAERR"		"OpenCOBOL"	"ORCGXAERR";
bind	"XAID1"		"OpenCOBOL"	"ORCGXAID1";

multiplex_group	orca01;

# 1 "orcahome.inc" 1
home	"/usr/local/orca/lib";
# 14 "orca01.ld.in" 2


data	{
	spa	orcaspa;
	window	{
		XA01;
		XA99;
		XAERR;
                XAID1;
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

# 26 "orca01.ld.in" 2



