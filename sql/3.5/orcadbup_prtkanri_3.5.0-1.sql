\set ON_ERROR_STOP

alter table tbl_prtkanri add  column hospnum  integer;
update tbl_prtkanri set hospnum = 1 ;
alter table tbl_prtkanri drop constraint  tbl_prtkanri_primary_key;
alter table tbl_prtkanri add constraint tbl_prtkanri_primary_key primary key (hospnum,tbl_key, rennum, tbl_group, shori_rennum);
