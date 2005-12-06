CREATE TABLE "tbl_kohplus" (
	"hospid" character(24) NOT NULL,
	"prefnum" character(2) NOT NULL,
	"citynum" character(3) NOT NULL,
	"kohnum" character(3) NOT NULL,
	"ptkbn" character(1) NOT NULL,
	"yukostymd" character(8) NOT NULL,
	"yukoedymd" character(8),
	"ftnkbn" character(1),
	"nyuskjryykbn" character(1),
	"receskykbn" character(1),
	"seidoname" character varying(100),
	"termid" character varying(16),
	"opid" character varying(16),
	"creymd" character(8),
	"upymd" character(8),
	"uphms" character(6),
	Constraint "tbl_kohplus_primary_key" Primary Key ("hospid", "prefnum", "citynum", "kohnum", "ptkbn", "yukostymd")
);

COMMENT ON TABLE "tbl_kohplus" IS '∏¯»Ò…’≤√';

