--                                    --
-- 点数マスタプラス                   --
-- 添付資料用薬剤分類区分の追加       --
--                                    --
--   添付資料用薬剤分類区分(TENPUYAKKBN) --
--                                    --
-- Create Date : 2003/08/05           --
--                                    --

-- TBL_TENSUPLUSWK  作成              --

create table TBL_TENSUPLUSWK (
SRYCD				char(9)		not null,
YUKOSTYMD			char(8)		not null,
YUKOEDYMD			char(8)		not null,
SHOYUKOKETA			numeric(2),
SHONAME				char(200),
SAIKETUKBN			numeric(1),
INPCHKKBN			numeric(1),
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
SHONAME				char(200),
SAIKETUKBN			numeric(1),
INPCHKKBN			numeric(1),
TENPUYAKKBN			char(2),
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
'  ',
TERMID,
OPID,
CREYMD,   
UPYMD,
UPHMS
from TBL_TENSUPLUSWK;


-- TBL_TENSUPLUSWK 削除             --

drop table TBL_TENSUPLUSWK;
