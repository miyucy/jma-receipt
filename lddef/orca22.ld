# 1 "orca22.ld.in"
name	orca22;

arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGC02";
bind	"C02"		"OpenCOBOL"	"ORCGC02";
bind	"C03"		"OpenCOBOL"	"ORCGC03";
bind	"C04"		"OpenCOBOL"	"ORCGC04";
bind	"C05"		"OpenCOBOL"	"ORCGC05";
bind	"C06"		"OpenCOBOL"	"ORCGC06";
bind	"C07"		"OpenCOBOL"	"ORCGC07";
bind	"C08"		"OpenCOBOL"	"ORCGC08";
bind	"CERR"		"OpenCOBOL"	"ORCGCERR";
bind	"CID1"		"OpenCOBOL"	"ORCGCID1";
bind	"CID2"		"OpenCOBOL"	"ORCGCID2";

multiplex_group	orca22;

# 1 "orcahome.inc" 1
home	"/usr/local/orca/lib";
# 20 "orca22.ld.in" 2


data	{
	spa	orcaspa;
	window	{
		C02;
                C03;
		C04;
		C05;
		C06;
		C07;
		C08;
		CERR;
                CID1;
                CID2;
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

# 38 "orca22.ld.in" 2


