create	table	tbl_toukeicsv_b	(
	HOSPNUM	numeric(2,0),
	TBL_KEY	char(8),
	RENNUM	numeric(4,0),
	TBL_GROUP	char(14),
	SHORI_RENNUM	numeric(4,0),
	SHELLID	varchar(20),
	SRYYM	varchar(6),
	SRYYMD	varchar(8),
	PTID	numeric(10,0),
	CNT	numeric(5,0),
	PUTFLG	char(1),
	CSVDATA	varchar(20000),
	CREYMD	varchar(8),
	primary	key(
		HOSPNUM,
		TBL_KEY,
		RENNUM,
		TBL_GROUP,
		SHORI_RENNUM,
		CNT
	)
);
