CREATE TABLE "tbl_srycdchg" (
	"ipnsrycd" character(9) NOT NULL,
	"rjnsrycd" character(9) NOT NULL,
	"termid" character varying(16),
	"opid" character varying(16),
	"creymd" character(8),
	"upymd" character(8),
	"uphms" character(6),
	Constraint "tbl_srycdchg_primary_key" Primary Key ("ipnsrycd", "rjnsrycd")
);

CREATE INDEX idx_srycdchg_rjnsrycd ON tbl_srycdchg USING btree (rjnsrycd);

COMMENT ON TABLE "tbl_srycdchg" IS '一般老人置換';

