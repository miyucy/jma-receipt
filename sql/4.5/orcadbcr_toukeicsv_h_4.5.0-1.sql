create	table	tbl_toukeicsv_h	(
	HOSPNUM		numeric(2,0),
	TBL_KEY		char(8),
	RENNUM		numeric(4,0),
	TBL_GROUP	char(14),
	SHORI_RENNUM	numeric(4,0),
	SHELLID		varchar(20),
	SRYYM		varchar(6),
	SRYYMD		varchar(8),
	CNT		numeric(5,0),
	NYUGAIKBN	char(1),
	TO_FOLDER	varchar(200),
	TO_DATA		varchar(200),
	PUTFLG		char(1),
	TITLE		varchar(100),
	TERMID		varchar(32),
	OPID		varchar(16),
	CREYMD		varchar(8),
	primary	key(
		HOSPNUM,
		TBL_KEY,
		RENNUM,
		TBL_GROUP,
		SHORI_RENNUM
	)
);
