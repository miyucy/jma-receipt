# 1 "orca21.ld.in"
name	orca21;

arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGK02";
bind	"K01"		"OpenCOBOL"	"ORCGK01";
bind	"K02"		"OpenCOBOL"	"ORCGK02";
bind	"K021"		"OpenCOBOL"	"ORCGK021";
bind	"K022"		"OpenCOBOL"	"ORCGK022";
bind	"K023"		"OpenCOBOL"	"ORCGK023";
bind	"K03"		"OpenCOBOL"	"ORCGK03";
bind	"K04"		"OpenCOBOL"	"ORCGK04";
bind	"K05"		"OpenCOBOL"	"ORCGK05";
bind	"K051"		"OpenCOBOL"	"ORCGK051";
bind	"K052"		"OpenCOBOL"	"ORCGK052";
bind	"K06"		"OpenCOBOL"	"ORCGK06";
bind	"K07"		"OpenCOBOL"	"ORCGK07";
bind	"K08"		"OpenCOBOL"	"ORCGK08";
bind	"K09"		"OpenCOBOL"	"ORCGK09";
bind	"K10"		"OpenCOBOL"	"ORCGK10";
bind	"K98"		"OpenCOBOL"	"ORCGK98";
bind	"K99"		"OpenCOBOL"	"ORCGK99";
bind	"KERR"		"OpenCOBOL"	"ORCGKERR";
bind	"KERR2"		"OpenCOBOL"	"ORCGKERR2";
bind	"KID1"		"OpenCOBOL"	"ORCGKID1";
bind	"KID2"		"OpenCOBOL"	"ORCGKID2";

multiplex_group	orca21;

# 1 "orcahome.inc" 1
home	"/usr/local/orca/lib";
# 31 "orca21.ld.in" 2


data	{
	spa	orcaspa;
	window	{
		K01;
		K02;
		K021;
		K022;
		K023;
		K03;
		K04;
                K05;
                K051;
                K052;
                K06;
		K07;
                K08;
                K09;
                K10;
		K98;
		K99;
                KERR;
                KERR2;
                KID1;
                KID2;
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

# 60 "orca21.ld.in" 2


