\set ON_ERROR_STOP

alter table tbl_prtdata add  column hospnum  integer;
update tbl_prtdata set hospnum = 1 ;
alter table tbl_prtdata drop constraint  tbl_prtdata_primary_key;
alter table tbl_prtdata add constraint tbl_prtdata_primary_key primary key (hospnum,tbl_key, rennum, tbl_group, shori_rennum, page);
