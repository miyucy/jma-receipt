\set ON_ERROR_STOP
--
-- 照会請求情報テーブル
-- Create Date : 2010/09/29        --
--
create	table	tbl_skysrh	(
	HOSPNUM	smallint,
	TERMID	char(64),
	PTID	bigint,
	NYUGAIKBN	char(1),
	SRYYM	char(6),
	HKNID	bigint,
	HKNNUM	char(3),
	KOHNUM1	char(3),
	KOHNUM2	char(3),
	TOTALTEN	bigint,
	TOKKI1	varchar(2),
	TOKKI2	varchar(2),
	TOKKI3	varchar(2),
	TOKKI4	varchar(2),
	TOKKI5	varchar(2),
	TOKKINM1	varchar(12),
	TOKKINM2	varchar(12),
	TOKKINM3	varchar(12),
	TOKKINM4	varchar(12),
	TOKKINM5	varchar(12),
	ETC_YKZFTN1	integer
) with oids ;
