\set ON_ERROR_STOP
--
-- 患者照会検索条件管理テープル
--
-- Create Date : 2007/08/08         --
--
create	table	tbl_shoukaikanri	(
	HOSPNUM		numeric(2,0) NOT NULL,
	UID				char(36) NOT NULL,
	RENNUM		numeric(5,0),
	NAME	  	varchar(100),
	NYUGAIKBN	char(01),
	TERMID		varchar(32),
	OPID			varchar(16),
	CREYMD		char(8),
	UPYMD			char(8),
	UPHMS			char(6),
	Constraint "tbl_shoukaikanri_primary_key" primary	key(
		HOSPNUM,
		UID
	)
);

