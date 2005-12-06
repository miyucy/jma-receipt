CREATE TABLE "tbl_kensasort" (
	"knsbunrui" numeric(2,0) NOT NULL,
	"srycd" character(9) NOT NULL,
	"dspseq" numeric(4,0),
	"termid" character varying(32),
	"opid" character varying(16),
	"creymd" character(8),
	"upymd" character(8),
	"uphms" character(6),
	Constraint "tbl_kensasort_primary_key" Primary Key ("knsbunrui", "srycd")
);

COMMENT ON TABLE "tbl_kensasort" IS '∏°∫∫ ¨Œ‡';

