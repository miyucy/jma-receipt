\set ON_ERROR_STOP
--
-- 予約文例雛形テーブル
--
-- Create Date : 2009/01/16         --
--
create	table	tbl_yykexample	(
	HOSPNUM		numeric(2,0) NOT NULL,
	RENNUM        	numeric(3,0)  NOT NULL,
	HYOKBN        	numeric(1,0)  NOT NULL,
	COMMENT  	varchar(100),
	TERMID  	varchar(16),
	OPID    	varchar(16),
	CREYMD  	char(8),
	UPYMD    	char(8),
	UPHMS		char(6),
	Constraint "tbl_yykexample_key" primary	key(
		HOSPNUM,
		RENNUM
	)
);
