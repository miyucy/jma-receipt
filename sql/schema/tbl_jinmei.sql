CREATE TABLE "tbl_jinmei" (
	"kanji" character varying(50) NOT NULL,
	"kana" character varying(50) NOT NULL,
	"upymd" character varying(8) NOT NULL,
	"uphms" character varying(6) NOT NULL,
	Constraint "tbl_jinmei_primary_key" Primary Key ("kanji", "kana")
);

CREATE INDEX idx_jinmei_kana ON tbl_jinmei USING btree (kana);

COMMENT ON TABLE "tbl_jinmei" IS '¿ÍÌ¾¼­½ñ';

