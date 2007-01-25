\set ON_ERROR_STOP

alter table tbl_hknnum add  column hospnum  integer;
alter table tbl_hknnum drop column hospid;
update tbl_hknnum set hospnum = 1 ;
alter table tbl_hknnum add constraint tbl_hknnum_primary_key primary key (hospnum, hknnum, tekstymd, paykbn);
