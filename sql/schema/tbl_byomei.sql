CREATE TABLE "tbl_byomei" (
	"byomeicd" character(7) NOT NULL,
	"byomei" character varying(200) NOT NULL,
	"byomeimoji" numeric(3,0) DEFAULT 0,
	"tanbyomei" character varying(200) NOT NULL,
	"tanbyomeimoji" numeric(3,0) DEFAULT 0,
	"byomeikana" character varying(200) NOT NULL,
	"ikosakicd" character(7),
	"tokskncd" numeric(2,0) DEFAULT 0,
	"utagaiflg" character(1),
	"tandokukbn" numeric(2,0) DEFAULT 0,
	"hknskykbn" numeric(1,0) DEFAULT 0,
	"hyojuncd" character(8),
	"saitakukbn" character(1),
	"byomeichgcd" character varying(4),
	"icd10" character varying(5),
	"syusaiymd" character(8),
	"chgymd" character(8),
	"haisiymd" character(8),
	"termid" character varying(32),
	"opid" character varying(16),
	"creymd" character(8),
	"upymd" character(8),
	"uphms" character(6),
	Constraint "tbl_byomei_primary_key" Primary Key ("byomeicd")
);

CREATE INDEX idx_byomei_byomei ON tbl_byomei USING btree (byomei);

CREATE INDEX idx_byomei_byomeikana ON tbl_byomei USING btree (byomeikana);

COMMENT ON TABLE "tbl_byomei" IS 'ибл╬';

