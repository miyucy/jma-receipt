create	table	tbl_rece_puth	(
	HOSPID	char(24),
	PREFKBN_PRTJYUN	char(1),
	HKNJANUM_PRTJYUN	char(1),
	HKNJANUM	char(8),
	HKNJANUM_PRTKBN	char(1),
	SRT_01_1	char(2),
	KKHKBN_1	char(2),
	CHOUKI_1	char(1),
	ZAITAKU_1	char(1),
	KOUGAKU_TEN_1	numeric(7,0),
	SRT_LAST_1	char(1),
	SRT_01_2	char(2),
	KKHKBN_2	char(2),
	CHOUKI_2	char(1),
	ZAITAKU_2	char(1),
	KOUGAKU_TEN_2	numeric(7,0),
	SRT_LAST_2	char(1),
	STYUKYMD	char(8),
	EDYUKYMD	char(8),
	TERMID	varchar(64),
	OPID	varchar(16),
	CREYMD	char(8),
	UPYMD	char(8),
	UPHMS	char(6),
	primary	key(
		HOSPID,
		STYUKYMD,
		EDYUKYMD
	)
);
