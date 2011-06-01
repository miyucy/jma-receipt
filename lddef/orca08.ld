name	orca08;

arraysize	20;
textsize	400;

bind	""		"OpenCOBOL"	"ORCGM80";
bind	"M80"		"OpenCOBOL"	"ORCGM80";
bind	"M80ERR"	"OpenCOBOL"	"ORCGM80ERR";
bind	"M80ID1"	"OpenCOBOL"	"ORCGM80ID1";

multiplex_group	orca08;


data	{
	spa	orcaspa;
	window	{
		M80;
		M80ERR;
		M80ID1;
	};
};

db	{
	tbl_file_info;
	tbl_jobkanri;
	tbl_syskanri;
};

/* #include "orcadb.inc" */
#include "orcadbh.inc"
