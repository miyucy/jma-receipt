CREATE TABLE "tbl_pttainfuka" (
	"hospid" character(24) NOT NULL,
	"ptid" numeric(10,0) NOT NULL,
	"rrknum" numeric(3,0) NOT NULL,
	"byomei1" character varying(80),
	"byomei2" character varying(80),
	"byomei3" character varying(80),
	"byomei4" character varying(80),
	"byomei5" character varying(80),
	"khnryo" character varying(80),
	"termid" character varying(16),
	"opid" character varying(16),
	"creymd" character(8),
	"upymd" character(8),
	"uphms" character(6),
	Constraint "tbl_pttainfuka_primary_key" Primary Key ("hospid", "ptid", "rrknum")
);

COMMENT ON TABLE "tbl_pttainfuka" IS '患者他院歴付加情報';

