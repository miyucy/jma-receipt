--                                    --
-- 保険者情報テーブルの変更           --
--                                    --
-- 項目の追加                         --
--   給付割合（組合員） KYURATE1      --
--   給付割合（家族）   KYURATE2      --
--                                    --
-- Create Date : 2004/07/07           --
--                                    --

-- TBL_HKNJAINFWK 作成                --

create table TBL_HKNJAINFWK (
HOSPID				char(24)	not null,
HKNJANUM			char(8)		not null,
HKNJANAME			varchar(200),
HKNJANAME_TAN1			varchar(100),
HKNJANAME_TAN2			varchar(40),
HKNJANAME_TAN3			varchar(40),
HKNNUM  			char(3),
POST    			varchar(7),
ADRS				varchar(200),
BANTI				varchar(200),
TEL     			varchar(15),
KIGO				varchar(80),
IDOKBN				varchar(1),
IDOYMD				varchar(8),
TERMID				varchar(16),
OPID				varchar(16),
CREYMD				char(8),
UPYMD				char(8),
UPHMS				char(6),
constraint TBL_HKNJAINFWK_primary_key primary key (HOSPID,HKNJANUM));

-- TBL_HKNJAINF → TBL_HKNJAINFWK   --

insert into TBL_HKNJAINFWK
select * from TBL_HKNJAINF;

-- TBL_HKNJAINF 削除               --

drop table TBL_HKNJAINF;

-- TBL_HKNJAINF 作成               --

create table TBL_HKNJAINF (
HOSPID				char(24)	not null,
HKNJANUM			char(8)		not null,
HKNJANAME			varchar(200),
HKNJANAME_TAN1			varchar(100),
HKNJANAME_TAN2			varchar(40),
HKNJANAME_TAN3			varchar(40),
HKNNUM  			char(3),
KYURATE1			numeric(3)	default 0,
KYURATE2			numeric(3)	default 0,
POST    			varchar(7),
ADRS				varchar(200),
BANTI				varchar(200),
TEL     			varchar(15),
KIGO				varchar(80),
IDOKBN				varchar(1),
IDOYMD				varchar(8),
TERMID				varchar(16),
OPID				varchar(16),
CREYMD				char(8),
UPYMD				char(8),
UPHMS				char(6),
constraint TBL_HKNJAINF_primary_key primary key (HOSPID,HKNJANUM));

-- TBL_HKNJAINFWK → TBL_HKNJAINF   --

insert into TBL_HKNJAINF
(HOSPID,
HKNJANUM,
HKNJANAME,
HKNJANAME_TAN1,
HKNJANAME_TAN2,
HKNJANAME_TAN3,
HKNNUM,
-- KYURATE1 --
-- KYURATE2 --
POST,
ADRS,
BANTI,
TEL,
KIGO,
IDOKBN,
IDOYMD,
TERMID,
OPID,
CREYMD,
UPYMD,
UPHMS
)
select * from TBL_HKNJAINFWK;

-- TBL_HKNJAINFWK 削除             --

drop table TBL_HKNJAINFWK;
