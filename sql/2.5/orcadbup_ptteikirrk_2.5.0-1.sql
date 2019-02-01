--                                    --
-- 患者定期請求履歴テーブルの変更     --
--                                    --
-- 項目の追加                         --
-- 収納明細枝番                       --

-- (1)TBL_PTTEIKIRRK_WK 作成
CREATE TABLE "tbl_ptteikirrk_wk" (
	"hospid" character(24) NOT NULL,
	"ptid" numeric(10,0) NOT NULL,
	"sryym" character(6) NOT NULL,
	"sakkbn" character(1) NOT NULL,
	"hkncombinum" numeric(4,0) NOT NULL,
	"skystymd" character(8),
	"skyedymd" character(8),
	"skyten" numeric(9,0),
	"skymoney_tax_sai" numeric(7,0),
	"skymoney" numeric(9,0),
	"rrknum" numeric(3,0),
	"denpnum" numeric(7,0),
	"skyupdflg" numeric(1,0),
	"termid" character varying(16),
	"opid" character varying(16),
	"creymd" character varying(8),
	"upymd" character varying(8),
	"uphms" character varying(6)
);


-- (2)TBL_PTTEIKIRRK -> TBL_PTTEIKIRRK_WK
insert   into tbl_ptteikirrk_wk
select * from tbl_ptteikirrk;

-- (3)TBL_PTTEIKIRRK削除
drop  table tbl_ptteikirrk;

-- (4)TBL_PTTEIKIRRK作成
CREATE TABLE "tbl_ptteikirrk" (
	"hospid" character(24) NOT NULL,
	"ptid" numeric(10,0) NOT NULL,
	"sryym" character(6) NOT NULL,
	"sakkbn" character(1) NOT NULL,
	"hkncombinum" numeric(4,0) NOT NULL,
	"skystymd" character(8),
	"skyedymd" character(8),
	"skyten" numeric(9,0),
	"skymoney_tax_sai" numeric(7,0),
	"skymoney" numeric(9,0),
	"rrknum" numeric(3,0),
	"denpnum" numeric(7,0),
	"denpedanum" numeric(2,0),
	"skyupdflg" numeric(1,0),
	"termid" character varying(16),
	"opid" character varying(16),
	"creymd" character varying(8),
	"upymd" character varying(8),
	"uphms" character varying(6),
	Constraint "tbl_ptteikirrk_primary_key" Primary Key ("hospid", "ptid", "sryym", "sakkbn", "hkncombinum")
);

-- (5)TBL_PTTEIKIRRK_WK -> TBL_PTTEIKIRRK
insert   into tbl_ptteikirrk
(
hospid,
ptid,
sryym,
sakkbn,
hkncombinum,
skystymd,
skyedymd,
skyten,
skymoney_tax_sai,
skymoney,
rrknum,
denpnum,
denpedanum,
skyupdflg,
termid,
opid,
creymd,
upymd,
uphms
)
select 
hospid,
ptid,
sryym,
sakkbn,
hkncombinum,
skystymd,
skyedymd,
skyten,
skymoney_tax_sai,
skymoney,
rrknum,
denpnum,
0,
skyupdflg,
termid,
opid,
creymd,
upymd,
uphms
from tbl_ptteikirrk_wk;

-- (6)TBL_PTTEIKIRRK_WK 削除
drop  table tbl_ptteikirrk_wk;

-- (7)denpedanum更新
update tbl_ptteikirrk set denpedanum = b.denpedanum
from (select hospid,ptid,denpnum,max(denpedanum) as denpedanum from tbl_syumei
where nyugaikbn = '1'
and   joutaikbn in (' ','1','8','9') group by hospid,ptid,denpnum) b 
where  tbl_ptteikirrk.hospid = b.hospid
  and  tbl_ptteikirrk.ptid   = b.ptid
  and  tbl_ptteikirrk.denpnum  = b.denpnum
;

