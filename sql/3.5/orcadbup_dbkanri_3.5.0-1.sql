\set ON_ERROR_STOP

alter table tbl_dbkanri add  column hospnum  integer;
update tbl_dbkanri set hospnum = 1 ;
alter table tbl_dbkanri drop constraint  tbl_dbkanri_primary_key;
alter table tbl_dbkanri add constraint tbl_dbkanri_primary_key primary key (hospnum,kanricd);
