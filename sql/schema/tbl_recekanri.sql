CREATE TABLE "tbl_recekanri" (
	"prtid" character(4) NOT NULL,
	"syokbn" character(1) NOT NULL,
	"creymd" character(8) NOT NULL,
	"crehms" character(6) NOT NULL,
	"teisyutusaki" character(1) NOT NULL,
	"sryka" character(2) DEFAULT '00' NOT NULL,
	"prefkbn_srt" character(2) DEFAULT '99' NOT NULL,
	"hknjanum_srt" character(1) DEFAULT '9' NOT NULL,
	"hknjanum" character(8) DEFAULT '99999999' NOT NULL,
	"recesyubetu" character(4) NOT NULL,
	"recesyubetu_srt" character(3) DEFAULT '999' NOT NULL,
	"zaitaku" character(1) DEFAULT '9' NOT NULL,
	"chouki" character(1) DEFAULT '9' NOT NULL,
	"nyugaikbn" character(1),
	"sryym" character(6),
	"page" numeric(5,0) DEFAULT 0,
	"page_zaitaku" numeric(5,0) DEFAULT 0,
	"page_chouki" numeric(5,0) DEFAULT 0,
	"page_dup" numeric(5,0) DEFAULT 0,
	"kensu" numeric(5,0) DEFAULT 0,
	"recekbn" character(1),
	"syorisbt" character(1),
	"stymd" character(8),
	"edymd" character(8),
	"hseqnum" numeric(8,0) DEFAULT 0,
	"termid" character varying(64),
	"opid" character varying(16),
	Constraint "tbl_recekanri_primary_key" Primary Key ("prtid", "syokbn", "creymd", "crehms", "teisyutusaki", "sryka", "prefkbn_srt", "hknjanum_srt", "hknjanum", "recesyubetu", "recesyubetu_srt", "zaitaku", "chouki")
);

CREATE INDEX idx_recekanri_sryym ON tbl_recekanri USING btree (sryym);

COMMENT ON TABLE "tbl_recekanri" IS 'レセプト管理';

