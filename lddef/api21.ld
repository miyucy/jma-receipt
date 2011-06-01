name	api21;

arraysize	20;
textsize	400;

bindapi	"medicalmod"	"OpenCOBOL"	"ORAPI021S1";

multiplex_group	api21;


data	{
	spa	orcaspa;
	window	{
		medicalmod;
	};
};
db "xml" {
 xml_medicalreq;
 xml_medicalres;
};

#include "orcadb.inc"
#include "orcadbh.inc"
