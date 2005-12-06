CREATE TABLE "tbl_example" (
	"hospid" character(24) NOT NULL,
	"kubun" character(1) NOT NULL,
	"rennum" numeric(3,0) DEFAULT 0 NOT NULL,
	"comment" character varying(800),
	"termid" character varying(16),
	"opid" character varying(16),
	"creymd" character(8),
	"upymd" character(8),
	"uphms" character(6),
	Constraint "tbl_example_primary_key" Primary Key ("hospid", "kubun", "rennum")
);

COMMENT ON TABLE "tbl_example" IS '¿÷·¿';

