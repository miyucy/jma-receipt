CREATE TABLE "tbl_adrs" (
	"lpubcd" character(5) NOT NULL,
	"post" character(7) NOT NULL,
	"rennum" numeric(2,0) NOT NULL,
	"prefkana" character varying(40),
	"citykana" character varying(200),
	"townkana" character varying(200),
	"prefname" character varying(20),
	"cityname" character varying(100),
	"townname" character varying(100),
	"editadrs_kana" character varying(440),
	"editadrs_name" character varying(220),
	"towndivflg" character(1) DEFAULT '0',
	"manytownflg" character(1) DEFAULT '0',
	Constraint "tbl_adrs_primary_key" Primary Key ("lpubcd", "post", "rennum")
);

CREATE INDEX idx_adrs_post ON tbl_adrs USING btree (post);

COMMENT ON TABLE "tbl_adrs" IS '½»½ê';

