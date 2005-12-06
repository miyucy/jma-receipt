CREATE TABLE "tbl_inputset" (
	"hospid" character(24) NOT NULL,
	"setcd" character(6) NOT NULL,
	"setseq" numeric(3,0) NOT NULL,
	"inputcd" character(9),
	"suryo1" numeric(10,3) DEFAULT 0,
	"suryo2" numeric(10,3) DEFAULT 0,
	"kaisu" numeric(3,0) DEFAULT 0,
	"coment" character varying(80),
	"atai1" character(8),
	"atai2" character(8),
	"atai3" character(8),
	"atai4" character(8),
	"termid" character varying(16),
	"opid" character varying(16),
	"creymd" character(8),
	"upymd" character(8),
	"uphms" character(6),
	Constraint "tbl_inputset_primary_key" Primary Key ("hospid", "setcd", "setseq")
);

COMMENT ON TABLE "tbl_inputset" IS '入力セット';

