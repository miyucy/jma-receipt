CREATE TABLE "tbl_chk004" (
	"kanricd" character(4) NOT NULL,
	"kbncd" character(8) NOT NULL,
	"styukymd" character(8) NOT NULL,
	"edyukymd" character(8) NOT NULL,
	"kanritbl" character varying(500),
	"termid" character varying(16),
	"opid" character varying(16),
	"creymd" character(8),
	"upymd" character(8),
	"uphms" character(6),
	Constraint "tbl_chk004_primary_key" Primary Key ("kanricd", "kbncd", "styukymd", "edyukymd")
);

COMMENT ON TABLE "tbl_chk004" IS 'チェックマスタ４';

