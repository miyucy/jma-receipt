\set ON_ERROR_STOP

alter table tbl_prvkanri add  column hospnum  integer;
update tbl_prvkanri set hospnum = 1 ;
alter table tbl_prvkanri drop constraint  tbl_prvkanri_pkey;
alter table tbl_prvkanri add constraint tbl_prvkanri_primary_key primary key (hospnum,tbl_key, rennum, tbl_group, shori_rennum, page);
