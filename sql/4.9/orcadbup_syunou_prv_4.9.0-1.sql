--
-- 収納（プレビュー）テーブル
-- 項目追加：食事１１〜食事１４
--           入院その他１から５
-- Create Date : 2016/2/23

\set ON_ERROR_STOP

alter table tbl_syunou_prv add column shokuji11_nissu smallint;
alter table tbl_syunou_prv add column shokuji11 integer;
alter table tbl_syunou_prv add column shokuji12_nissu smallint;
alter table tbl_syunou_prv add column shokuji12 integer;
alter table tbl_syunou_prv add column shokuji13_nissu smallint;
alter table tbl_syunou_prv add column shokuji13 integer;
alter table tbl_syunou_prv add column shokuji14_nissu smallint;
alter table tbl_syunou_prv add column shokuji14 integer;
alter table tbl_syunou_prv add column nyuinetc1 integer;
alter table tbl_syunou_prv add column nyuinetc2 integer;
alter table tbl_syunou_prv add column nyuinetc3 integer;
alter table tbl_syunou_prv add column nyuinetc4 integer;
alter table tbl_syunou_prv add column nyuinetc5 integer;
update tbl_syunou_prv set shokuji11_nissu = 0;
update tbl_syunou_prv set shokuji11 = 0;
update tbl_syunou_prv set shokuji12_nissu = 0;
update tbl_syunou_prv set shokuji12 = 0;
update tbl_syunou_prv set shokuji13_nissu = 0;
update tbl_syunou_prv set shokuji13 = 0;
update tbl_syunou_prv set shokuji14_nissu = 0;
update tbl_syunou_prv set shokuji14 = 0;
update tbl_syunou_prv set nyuinetc1 = 0;
update tbl_syunou_prv set nyuinetc2 = 0;
update tbl_syunou_prv set nyuinetc3 = 0;
update tbl_syunou_prv set nyuinetc4 = 0;
update tbl_syunou_prv set nyuinetc5 = 0;
