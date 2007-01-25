\set ON_ERROR_STOP

alter table tbl_inputcd add  column hospnum  integer;
alter table tbl_inputcd drop column hospid;
update tbl_inputcd set hospnum = 1 ;
alter table tbl_inputcd add constraint tbl_inputcd_primary_key primary key (hospnum, cdsyu, inputcd);
create index idx_inputcd_key2 on tbl_inputcd(srycd, hospnum);
