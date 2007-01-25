\set ON_ERROR_STOP

alter table tbl_jinmei add  column hospnum  integer;
update tbl_jinmei set hospnum = 1 ;
alter table tbl_jinmei drop constraint  tbl_jinmei_primary_key;
alter table tbl_jinmei add constraint tbl_jinmei_primary_key primary key (hospnum,kanji, kana);
drop index idx_jinmei_kana;
create index idx_jinmei_kana on tbl_jinmei(hospnum,kana);
