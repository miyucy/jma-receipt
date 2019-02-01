\set ON_ERROR_STOP
--
-- 患者禁忌薬剤テーブル
--
-- Create Date : 2007/12/03         --
--
create	table	tbl_ptkinki	(
	HOSPNUM		numeric(2,0) NOT NULL,
	PTID		numeric(10,0)  NOT NULL,
	SRYCD     	char(9),
	TERMID	varchar(32),
	OPID	varchar(16),
	CREYMD	char(8),
	UPYMD	char(8),
	UPHMS	char(6),
	Constraint "tbl_ptkinki_key" primary	key(
		HOSPNUM,
		PTID,
		SRYCD
	)
);
