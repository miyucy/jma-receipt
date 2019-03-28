--                                    --
-- 点数テーブルの変更       --
--                                    --
-- 項目の追加                         --
--   画像手術支援加算                 --
--   医療観察法対象区分               --
--   麻酔識別区分                     --
--                                    --
-- Create Date : 2008/03/07           --
--                                    --
\set ON_ERROR_STOP


--    項目追加                        --
alter table tbl_tensu
   add column gazoopesup numeric(01);
alter table tbl_tensu
   add column iryokansatukbn numeric(01);
alter table tbl_tensu
   add column masuiskbkbn numeric(01);

--    ゼロ設定                       --
alter table tbl_tensu
   alter gazoopesup set default 0;
alter table tbl_tensu
   alter iryokansatukbn set default 0;
alter table tbl_tensu
   alter masuiskbkbn set default 0;

update tbl_tensu set gazoopesup=0,iryokansatukbn=0,masuiskbkbn=0;
