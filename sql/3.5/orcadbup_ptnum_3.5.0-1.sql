\set ON_ERROR_STOP

alter table tbl_ptnum add  column hospnum  integer;
alter table tbl_ptnum drop column hospid;
update tbl_ptnum set hospnum = 1 ;
alter table tbl_ptnum add constraint tbl_ptnum_primary_key primary key (hospnum, ptid);
drop index idx_ptnum_ptnum;
create index idx_ptnum_ptnum on tbl_ptnum(hospnum,ptnum);
