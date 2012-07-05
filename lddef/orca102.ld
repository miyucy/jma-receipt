name	orca102;

arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGZ01";
bind	"Z01"		"OpenCOBOL"	"ORCGZ01";
bind	"Z02"		"OpenCOBOL"	"ORCGZ02";
bind	"Z03"		"OpenCOBOL"	"ORCGZ03";
bind	"Z04"		"OpenCOBOL"	"ORCGZ04";
bind	"Z05"		"OpenCOBOL"	"ORCGZ05";
bind	"Z06"		"OpenCOBOL"	"ORCGZ06";
bind	"Z07"		"OpenCOBOL"	"ORCGZ07";
bind	"Z08"		"OpenCOBOL"	"ORCGZ08";
bind	"Z90"		"OpenCOBOL"	"ORCGZ90";
bind	"Z91"		"OpenCOBOL"	"ORCGZ91";
bind	"Z97"		"OpenCOBOL"	"ORCGZ97";
bind	"Z98"		"OpenCOBOL"	"ORCGZ98";
bind	"Z99"		"OpenCOBOL"	"ORCGZ99";
bind	"ZERR"		"OpenCOBOL"	"ORCGZERR";
bind	"ZID1"		"OpenCOBOL"	"ORCGZID1";
bind	"ZID2"		"OpenCOBOL"	"ORCGZID2";
bind	"ZID3"		"OpenCOBOL"	"ORCGZID3";
bind	"Z100"		"OpenCOBOL"	"ORCGZ100";
bindapi	"medicatonmod"	"OpenCOBOL"	"ORAPI102S1";

multiplex_group	orca102;


data	{
	spa	orcaspa;
	window	{
		Z01;
		Z02;
		Z03;
		Z04;
		Z05;
		Z06;
		Z07;
		Z08;
                Z90;
                Z91;
                Z97;
                Z98;  
		Z99;
		ZERR;
		ZID1;
		ZID2;
		ZID3;
		Z100;
		medicatonmod;
	};
};
db "xml" {
 xml_medicationreq;
 xml_medicationres;
};


#include "orcadb.inc"
#include "orcadbh.inc"
