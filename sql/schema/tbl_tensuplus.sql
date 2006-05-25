CREATE TABLE "tbl_tensuplus" (
	"srycd" character(9) NOT NULL,
	"yukostymd" character(8) NOT NULL,
	"yukoedymd" character(8) NOT NULL,
	"shoyukoketa" numeric(2,0),
	"shoname" character varying(200),
	"saiketukbn" numeric(1,0),
	"inpchkkbn" numeric(1,0),
	"tenpuyakkbn" character(2),
	"allsuryokbn" character(1),
	"kanzantanicd" character(3),
	"kanzantaniname" character varying(24),
	"kanzanchi" numeric(10,5),
	"termid" character varying(16),
	"opid" character varying(16),
	"creymd" character(8),
	"upymd" character(8),
	"uphms" character(6),
	Constraint "tbl_tensuplus_primary_key" Primary Key ("srycd", "yukostymd", "yukoedymd")
);

COMMENT ON TABLE "tbl_tensuplus" IS '�����ղ�';

