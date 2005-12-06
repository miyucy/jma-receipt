CREATE TABLE "tbl_teikikanri" (
	"btunum" character(2) NOT NULL,
	"syokbn" character(1),
	"creymd" character(8),
	"crehms" character(6),
	"sryym" character(6),
	"page" numeric(5,0),
	"kensu" numeric(5,0),
	"termid" character varying(16),
	Constraint "tbl_teikikanri_primary_key" Primary Key ("btunum")
);

COMMENT ON TABLE "tbl_teikikanri" IS 'Äê´üÀÁµá´ÉÍı';

