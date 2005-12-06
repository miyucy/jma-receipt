CREATE TABLE "tbl_sykrrk" (
	"hospid" character(24) NOT NULL,
	"ptid" numeric(10,0) NOT NULL,
	"sykkbn" character(1) NOT NULL,
	"sykymd" character(8) NOT NULL,
	"sykiryid" numeric(10,0) DEFAULT 0,
	"sykiryname" character varying(200),
	"sykka" character(2),
	"soap" character varying(200),
	"termid" character varying(16),
	"opid" character varying(16),
	"creymd" character(8),
	"upymd" character(8),
	"uphms" character(6),
	Constraint "tbl_sykrrk_primary_key" Primary Key ("hospid", "ptid", "sykkbn", "sykymd")
);

COMMENT ON TABLE "tbl_sykrrk" IS '¾Ò²ğÍúÎò¾ğÊó';

