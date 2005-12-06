CREATE TABLE "tbl_sskijyo" (
	"syojyoucd" character(7) NOT NULL,
	"syojyou" character varying(2048),
	"sayokijyo" character varying(2048),
	"termid" character varying(32),
	"opid" character varying(16),
	"creymd" character(8),
	"upymd" character(8),
	"uphms" character(6),
	Constraint "tbl_sskijyo_primary_key" Primary Key ("syojyoucd")
);

COMMENT ON TABLE "tbl_sskijyo" IS '¾É¾õÁ¼ÃÖµ¡½ø';

