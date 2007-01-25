\set ON_ERROR_STOP

alter table tbl_ptrsiinf add  column hospnum  integer;
alter table tbl_ptrsiinf drop column hospid;
update tbl_ptrsiinf set hospnum = 1 ;
alter table tbl_ptrsiinf add constraint tbl_ptrsiinf_primary_key primary key (hospnum, ptid, hknid);
