\set ON_ERROR_STOP

alter table tbl_ptkohinf add  column hospnum  integer;
alter table tbl_ptkohinf drop column hospid;
update tbl_ptkohinf set hospnum = 1 ;
alter table tbl_ptkohinf add constraint tbl_ptkohinf_primary_key primary key (hospnum, ptid, kohid);
