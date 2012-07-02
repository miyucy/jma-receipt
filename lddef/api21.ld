name	api21;

arraysize	20;
textsize	400;

bindapi	"medicalmod"	"OpenCOBOL"	"ORAPI021S1";
bindapi	"medicalmodv2"	"OpenCOBOL"	"ORAPI021S1V2";

multiplex_group	api21;


data	{
	spa	orcaspa;
	window	{
		medicalmod;
		medicalmodv2;
	};
};
db "xml" {
 xml_medicalreq;
 xml_medicalres;
};
db "xml2" {
 xml_medicalv2req;
 xml_medicalv2res;
};

#include "orcadb.inc"
#include "orcadbh.inc"
