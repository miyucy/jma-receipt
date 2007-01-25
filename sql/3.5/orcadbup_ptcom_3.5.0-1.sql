\set ON_ERROR_STOP

alter table tbl_ptcom add  column hospnum  integer;
alter table tbl_ptcom drop column hospid;
update tbl_ptcom set hospnum = 1 ;
alter table tbl_ptcom add constraint tbl_ptcom_primary_key primary key (hospnum, ptid, zainum, srycd, rennum);
