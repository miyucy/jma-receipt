name	orca101;
arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGW01";
bind	"W01"		"OpenCOBOL"	"ORCGW01";
bind	"W02"		"OpenCOBOL"	"ORCGW02";
bind	"W03"		"OpenCOBOL"	"ORCGW03";
bind	"W04"		"OpenCOBOL"	"ORCGW04";
bind	"W05"		"OpenCOBOL"	"ORCGW05";
bind	"W06"		"OpenCOBOL"	"ORCGW06";
bind	"W07"		"OpenCOBOL"	"ORCGW07";
bind	"W08"		"OpenCOBOL"	"ORCGW08";
bind	"W09"		"OpenCOBOL"	"ORCGW09";
bind	"W10"		"OpenCOBOL"	"ORCGW10";
bind	"W11"		"OpenCOBOL"	"ORCGW11";
bind	"W12"		"OpenCOBOL"	"ORCGW12";
bind	"W13"		"OpenCOBOL"	"ORCGW13";
bind	"W14"		"OpenCOBOL"	"ORCGW14";
bind	"WERR"		"OpenCOBOL"	"ORCGWERR";
bind	"WID1"		"OpenCOBOL"	"ORCGWID1";

multiplex_group	orca101;

home	"/usr/local/orca/lib";

data	{
	spa	orcaspa;
#	linkage	orcalink;
	window	{
		W01;
		W02;
                W03;
                W04;
                W05;
                W06;
                W07;
                W08;
                W09;
                W10;
		W11;
		W12;
		W13;
		W14;
		WERR;
		WID1;
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

