CREATE TABLE "tbl_teikiprt" (
	"btunum" character(2) NOT NULL,
	"denpnum" numeric(7,0) NOT NULL,
	"hospid" character(24),
	"ptid" numeric(10,0),
	"ptnum" character(20),
	"name" character(100),
	Constraint "tbl_teikiprt_primary_key" Primary Key ("btunum", "denpnum")
);

COMMENT ON TABLE "tbl_teikiprt" IS 'Äê´üÀÁµá°õºş¾ğÊó';

