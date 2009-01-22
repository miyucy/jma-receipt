\set ON_ERROR_STOP
--
-- 予約メモテーブル
--
-- Create Date : 2009/01/16         --
--
create	table	tbl_yykcom	(
	HOSPNUM		numeric(2,0) NOT NULL,
	SRYNAIYO	char(2)  NOT NULL,
	DRCD    	char(5)  NOT NULL,
	YYKYMD  	char(8)  NOT NULL,
	KEYYYKTIME  	numeric(4,0)  NOT NULL,
	YYKID   	numeric(2,0)  NOT NULL,
	RENNUM        	numeric(1,0)  NOT NULL,
	COMMENT  	varchar(100),
	TERMID  	varchar(16),
	OPID    	varchar(16),
	CREYMD  	char(8),
	UPYMD    	char(8),
	UPHMS		char(6),
	Constraint "tbl_yykcom_key" primary	key(
		HOSPNUM,
		SRYNAIYO,
		DRCD,
		YYKYMD,
		KEYYYKTIME,
		YYKID,
		RENNUM
	)
);
