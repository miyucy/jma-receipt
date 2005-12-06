CREATE TABLE "tbl_rececom" (
	"hospid" character(24) NOT NULL,
	"ptid" numeric(10,0) NOT NULL,
	"nyugaikbn" character(1) DEFAULT '0' NOT NULL,
	"sryka" character(2) NOT NULL,
	"sryym" character(6) NOT NULL,
	"hkncombi" numeric(4,0) NOT NULL,
	"srydd" character(2) NOT NULL,
	"comment" character varying(1600),
	"termid" character varying(16),
	"opid" character varying(16),
	"creymd" character(8),
	"upymd" character(8),
	"uphms" character(6),
	Constraint "tbl_rececom_primary_key" Primary Key ("hospid", "ptid", "nyugaikbn", "sryka", "sryym", "hkncombi", "srydd")
);

COMMENT ON TABLE "tbl_rececom" IS 'レセプトコメント';

