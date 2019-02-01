--                                      
-- 点数テーブル
--                                    
-- 副鼻腔手術用内視鏡加算追加
-- 副鼻腔手術用骨軟部組織切除機器加算追加
-- 長時間麻酔管理加算追加
-- ＤＰＣ区分追加
--                                   
-- Create Date : 2014/03/06      

\set ON_ERROR_STOP

alter table tbl_tensu add column fukubikunaikbn smallint default 0;
alter table tbl_tensu add column fukubikukotukbn smallint default 0;
alter table tbl_tensu add column timemasuikbn smallint default 0;
alter table tbl_tensu add column dpckbn smallint default 0;
-- update tbl_tensu set fukubikunaikbn=0,fukubikukotukbn=0,timemasuikbn=0,dpckbn=0;
