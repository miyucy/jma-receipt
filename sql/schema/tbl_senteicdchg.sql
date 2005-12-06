CREATE TABLE "tbl_senteicdchg" (
	"ipnsrycd" character(9) NOT NULL,
	"senteisrycd" character(9) NOT NULL,
	"termid" character varying(16),
	"opid" character varying(16),
	"creymd" character(8),
	"upymd" character(8),
	"uphms" character(6),
	Constraint "tbl_senteicdchg_primary_key" Primary Key ("ipnsrycd", "senteisrycd")
);

CREATE INDEX idx_senteicdchg_senteisrycd ON tbl_senteicdchg USING btree (senteisrycd);

COMMENT ON TABLE "tbl_senteicdchg" IS '联年闻蛙锐ˇ办忍コ〖ド慷仑';

