CREATE TABLE "tbl_chktrd" (
	"chkkbn" character(1) NOT NULL,
	"srycd" character(9) NOT NULL,
	"yukostymd" character(8) NOT NULL,
	"yukoedymd" character(8) NOT NULL,
	"cdkbn" character(1) NOT NULL,
	"rennum" numeric(3,0) NOT NULL,
	"cd" character(9),
	"nyugaikbn" character(1),
	"nyugaibndkbn" character(1),
	"daymonthkbn" character(1),
	"termid" character varying(16),
	"opid" character varying(16),
	"creymd" character(8),
	"upymd" character(8),
	"uphms" character(6),
	Constraint "tbl_chktrd_primary_key" Primary Key ("chkkbn", "srycd", "yukostymd", "yukoedymd", "cdkbn", "rennum")
);

COMMENT ON TABLE "tbl_chktrd" IS 'チェック3';
