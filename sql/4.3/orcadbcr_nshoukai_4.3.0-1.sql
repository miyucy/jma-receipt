create	table	tbl_nshoukai	(
	HOSPNUM	numeric(2,0),
	PTID	numeric(10,0),
	SRYYMD	char(8),
	SRYKA	char(2),
	HKNCOMBINUM	char(4),
	SRYCD	char(9),
	TERMID	varchar(16),
	OPID	varchar(16),
	CREYMD	char(8),
	UPYMD	char(8),
	UPHMS	char(6),
	primary	key(
		HOSPNUM,
		PTID,
		SRYYMD,
		SRYKA,
		HKNCOMBINUM,
		SRYCD
	)
);
