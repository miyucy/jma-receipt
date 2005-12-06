CREATE TABLE "tbl_nyuinryakusho" (
	"srycd" character(9) NOT NULL,
	"yukostymd" character(8) NOT NULL,
	"yukoedymd" character(8) NOT NULL,
	"ryakusho" character varying(20),
	"name" character varying(200),
	"termid" character varying(16),
	"opid" character varying(16),
	"creymd" character(8),
	"upymd" character(8),
	"uphms" character(6),
	Constraint "tbl_nyuinryakusho_primary_key" Primary Key ("srycd", "yukostymd", "yukoedymd")
);

COMMENT ON TABLE "tbl_nyuinryakusho" IS 'Æþ±¡¥ì¥»¥×¥Èµ­ºÜÎ¬¾Î';

