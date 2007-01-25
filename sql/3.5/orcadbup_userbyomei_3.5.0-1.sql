\set ON_ERROR_STOP

alter table tbl_userbyomei add  column hospnum  integer;
alter table tbl_userbyomei drop column hospid;
update tbl_userbyomei set hospnum = 1 ;
alter table tbl_userbyomei add constraint tbl_userbyomei_primary_key primary key (hospnum, cdsyu, byomeiinputcd);
