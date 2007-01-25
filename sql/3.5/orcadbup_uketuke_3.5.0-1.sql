\set ON_ERROR_STOP

alter table tbl_uketuke add  column hospnum  integer;
alter table tbl_uketuke drop column hospid;
update tbl_uketuke set hospnum = 1 ;
alter table tbl_uketuke add constraint tbl_uketuke_primary_key primary key (hospnum, ukeymd, ukeid);
