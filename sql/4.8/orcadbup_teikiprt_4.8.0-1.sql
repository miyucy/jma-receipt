---------------------
-- 定期請求関係テーブル項目属性変更
-- 定期請求印刷情報
---------------------

\set ON_ERROR_STOP


-- tbl_teikiprt --
alter table tbl_teikiprt alter column hospnum type smallint;
alter table tbl_teikiprt alter column denpnum type integer;
alter table tbl_teikiprt alter column ptid    type smallint;
