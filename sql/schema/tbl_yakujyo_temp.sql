CREATE TABLE "tbl_yakujyo_temp" (
	"termid" character(64) NOT NULL,
	"srycd" character(9) NOT NULL,
	"yjcd" character(12) NOT NULL,
	"rennum" numeric(2,0) DEFAULT 0 NOT NULL,
	"shape" character varying(360),
	"color" character varying(360),
	"mark" character varying(360),
	"effect" character varying(400),
	"caution" character varying(850),
	"make_company" character varying(400),
	"sale_company" character varying(400),
	"photo1_filename" character varying(256),
	"photo2_filename" character varying(256),
	"photo3_filename" character varying(256),
	"creymd" character(8),
	Constraint "tbl_yakujyo_temp_primary_key" Primary Key ("termid", "srycd", "yjcd", "rennum")
);

COMMENT ON TABLE "tbl_yakujyo_temp" IS '薬剤情報参照用';

