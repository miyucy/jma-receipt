CREATE TABLE "tbl_teikirrk" (
	"sryym" character(6) NOT NULL,
	"sakkbn" character(1) NOT NULL,
	"skystymd" character(8),
	"skyedymd" character(8),
	"skyten" numeric(9,0),
	"skymoney" numeric(9,0),
	"saiskykbn" character(1),
	"termid" character varying(16),
	"opid" character varying(16),
	"creymd" character varying(8),
	"upymd" character varying(8),
	"uphms" character varying(6),
	Constraint "tbl_teikirrk_primary_key" Primary Key ("sryym", "sakkbn")
);

COMMENT ON TABLE "tbl_teikirrk" IS 'Äê´üÀÁµáÍúÎò';

