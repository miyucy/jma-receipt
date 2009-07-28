\set ON_ERROR_STOP
--
-- 分娩管理テーブル
--
-- Create Date : 2009/07/27         --
--
create	table	tbl_bunben	(
	HOSPNUM		smallint NOT NULL,
	PTID		bigint DEFAULT 0 NOT NULL,
	SKYYM		char(6) NOT NULL,
	PTNUM	        char(20) NOT NULL,
	SKYKBN		char(1) NOT NULL,
	BUNBENKBN	smallint DEFAULT 0 NOT NULL,
	RRKNUM	        smallint DEFAULT 0 NOT NULL,
	TEISYUTUSAKI	smallint DEFAULT 0 NOT NULL,
	KANYUKBN	smallint DEFAULT 0 NOT NULL,
	HONKZKKBN	smallint DEFAULT 0 NOT NULL,
	HKNJANUM	char(8) NOT NULL,
	KIGO		varchar(40) NOT NULL,
	NUM		varchar(40) NOT NULL,
	NAME		varchar(40) NOT NULL,
	ZAIWEEK		smallint DEFAULT 0 NOT NULL,
	BIRTHDAY	char(8) NOT NULL,
	SIZANKBN	smallint DEFAULT 0 NOT NULL,
	BIRTHCNT	smallint DEFAULT 0 NOT NULL,
	NYUIN_DAY	smallint DEFAULT 0 NOT NULL,
	SANKAKBN	smallint DEFAULT 0 NOT NULL,
	NYU_MONEY	integer DEFAULT 0,
	RMSGK_MONEY	integer DEFAULT 0,
	KAIJO_MONEY	integer DEFAULT 0,
	BUNBEN_MONEY	integer DEFAULT 0,
	SHIN_MONEY	integer DEFAULT 0,
	KNS_MONEY	integer DEFAULT 0,
	SYC_MONEY	integer DEFAULT 0,
	SNK_MONEY	integer DEFAULT 0,
	ETC_MONEY	integer DEFAULT 0,
	ICBFTN_MONEY	integer DEFAULT 0,
	NINPUFTN_MONEY	integer DEFAULT 0,
	DAIRI_MONEY	integer DEFAULT 0,
	BIKOU		varchar(50) NOT NULL,
	UPDKBN		smallint DEFAULT 0 NOT NULL,
	TERMID		varchar(16),
	OPID		varchar(16),
	CREYMD		char(8),
	UPYMD		char(8),
	UPHMS		char(6),
	Constraint "tbl_bunben_primary_key" primary key(
		HOSPNUM,
		PTID,
		SKYYM
	)
);
