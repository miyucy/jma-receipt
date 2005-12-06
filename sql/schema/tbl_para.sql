CREATE TABLE "tbl_para" (
	"gyoumuid" character(3) NOT NULL,
	"termid" character(64) NOT NULL,
	"filemei" character(20) NOT NULL,
	"edanum" numeric(3,0) NOT NULL,
	"data_rec" character(5000),
	Constraint "tbl_para_primary_key" Primary Key ("gyoumuid", "termid", "filemei", "edanum")
);

COMMENT ON TABLE "tbl_para" IS 'パラメタ';

