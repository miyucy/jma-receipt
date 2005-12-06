CREATE TABLE "tbl_kyuseirrk" (
	"hospid" character(24) NOT NULL,
	"ptid" numeric(10,0) NOT NULL,
	"chgymd" character(8) NOT NULL,
	"kananame" character varying(100),
	"name" character varying(100),
	"nickname" character varying(100),
	"termid" character varying(16),
	"opid" character varying(16),
	"creymd" character(8),
	"upymd" character(8),
	"uphms" character(6),
	Constraint "tbl_kyuseirrk_primary_key" Primary Key ("hospid", "ptid", "chgymd")
);

COMMENT ON TABLE "tbl_kyuseirrk" IS 'µìÀ«ÍúÎò';

