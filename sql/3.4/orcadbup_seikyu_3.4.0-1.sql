--                                    --
-- 請求管理テーブルの変更             --
--                                    --
-- 項目の追加                         --
--   保険ＩＤ    (HKNID)              --
--   老人公費ＩＤ(RJNHKNID)           --
--   公費ＩＤ    (KOHID1)             --
--               (KOHID2)             --
--               (KOHID3)             --
--               (KOHID4)             --
--                                    --
-- Create Date : 2007/02/27           --
--                                    --
\set ON_ERROR_STOP

--    項目追加                        --
alter table tbl_seikyu
   add column HKNID  numeric(10);
alter table tbl_seikyu
   add column RJNHKNID  numeric(10);
alter table tbl_seikyu
   add column KOHID1  numeric(10);
alter table tbl_seikyu
   add column KOHID2  numeric(10);
alter table tbl_seikyu
   add column KOHID3  numeric(10);
alter table tbl_seikyu
   add column KOHID4  numeric(10);

--    ゼロ設定                       --
alter table tbl_seikyu
   alter HKNID set default 0;
alter table tbl_seikyu
   alter RJNHKNID set default 0;
alter table tbl_seikyu
   alter KOHID1 set default 0;
alter table tbl_seikyu
   alter KOHID2 set default 0;
alter table tbl_seikyu
   alter KOHID3 set default 0;
alter table tbl_seikyu
   alter KOHID4 set default 0;

update tbl_seikyu set HKNID = 0,RJNHKNID = 0,KOHID1 = 0,KOHID2 = 0,KOHID3 = 0,KOHID4 = 0;
