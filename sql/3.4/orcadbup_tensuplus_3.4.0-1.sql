--                                    --
-- 点数マスタプラス                   --
--                                    --
-- ユーザー設定上限回数の追加         --
--                                    --
--   算定履歴区分(SANTEIRRKKBN)       --
--   月上限回数(JGNCNT)               --
--   日上限回数(JGNCNT1D)             --
--   エラー処理(JGNCNTERR)            --
--                                    --
-- Create Date : 2006/03/13           --
--                                    --

-- TBL_TENSUPLUSWK  作成              --

create table TBL_TENSUPLUSWK (
SRYCD				char(9)		not null,
YUKOSTYMD			char(8)		not null,
YUKOEDYMD			char(8)		not null,
SHOYUKOKETA			numeric(2),
SHONAME				varchar(200),
SAIKETUKBN			numeric(1),
INPCHKKBN			numeric(1),
TENPUYAKKBN			char(2),
ALLSURYOKBN			char(1),
KANZANTANICD	        	char(3),
KANZANTANINAME		        varchar(24),
KANZANCHI			numeric(10,5),
TERMID   			varchar(16),
OPID     			varchar(16),
CREYMD   			char(8),
UPYMD    			char(8),
UPHMS				char(6),
constraint TBL_TENSUPLUSWK_primary_key primary key (SRYCD,YUKOSTYMD,YUKOEDYMD));

-- TBL_TENSUPLUS → TBL_TENSUPLUSWK   --

insert into TBL_TENSUPLUSWK
select * from TBL_TENSUPLUS;

-- TBL_TENSUPLUS 削除               --

drop table TBL_TENSUPLUS;

-- TBL_TENSUPLUS 作成               --

create table TBL_TENSUPLUS (
SRYCD				char(9)		not null,
YUKOSTYMD			char(8)		not null,
YUKOEDYMD			char(8)		not null,
SHOYUKOKETA			numeric(2),
SHONAME				varchar(200),
SAIKETUKBN			numeric(1),
INPCHKKBN			numeric(1),
TENPUYAKKBN			char(2),
ALLSURYOKBN			char(1),
KANZANTANICD       		char(3),
KANZANTANINAME  		varchar(24),
KANZANCHI			numeric(10,5),
SANTEIRRKKBN			numeric(1),
JGNCNT				numeric(3),
JGNCNT1D			numeric(3),
JGNCNTERR			numeric(1),
TERMID   			varchar(16),
OPID     			varchar(16),
CREYMD   			char(8),
UPYMD    			char(8),
UPHMS				char(6),
constraint TBL_TENSUPLUS_primary_key primary key (SRYCD,YUKOSTYMD,YUKOEDYMD));

-- TBL_TENSUPLUSWK → TBL_TENSUPLUS   --

insert into TBL_TENSUPLUS
(SRYCD,
YUKOSTYMD,
YUKOEDYMD,
SHOYUKOKETA,
SHONAME,
SAIKETUKBN,
INPCHKKBN,
TENPUYAKKBN,
ALLSURYOKBN,
KANZANTANICD,
KANZANTANINAME,
KANZANCHI,
SANTEIRRKKBN,
JGNCNT,
JGNCNT1D,
JGNCNTERR,
TERMID,
OPID,
CREYMD,
UPYMD,
UPHMS
)
select
SRYCD,
YUKOSTYMD,
YUKOEDYMD,
SHOYUKOKETA,
SHONAME,
SAIKETUKBN,
INPCHKKBN,
TENPUYAKKBN,
ALLSURYOKBN,
KANZANTANICD,
KANZANTANINAME,
KANZANCHI,
0,
0,
0,
0,
TERMID,
OPID,
CREYMD,   
UPYMD,
UPHMS
from TBL_TENSUPLUSWK;

-- TBL_TENSUPLUSWK 削除             --

drop table TBL_TENSUPLUSWK;

vacuum tbl_tensuplus;

