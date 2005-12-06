CREATE TABLE "tbl_hours" (
	"sryymd" character(8) NOT NULL,
	"time" character(4) NOT NULL,
	"id" character(12),
	"hourskbn" character(1),
	"termid" character varying(32),
	"opid" character varying(16),
	"creymd" character(8),
	"upymd" character(8),
	"uphms" character(6),
	Constraint "tbl_hours_primary_key" Primary Key ("sryymd", "time")
);

COMMENT ON TABLE "tbl_hours" IS 'Äù¤á»þ¹ï´ÉÍý';

