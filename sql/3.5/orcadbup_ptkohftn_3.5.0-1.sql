\set ON_ERROR_STOP

alter table tbl_ptkohftn add  column hospnum  integer;
alter table tbl_ptkohftn drop column hospid;
update tbl_ptkohftn set hospnum = 1 ;
alter table tbl_ptkohftn add constraint tbl_ptkohftn_primary_key primary key (hospnum, ptid, kohid, rennum);
