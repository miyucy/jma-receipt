\set ON_ERROR_STOP

alter table tbl_srykarrk add  column hospnum  integer;
alter table tbl_srykarrk drop column hospid;
update tbl_srykarrk set hospnum = 1 ;
alter table tbl_srykarrk add constraint tbl_srykarrk_primary_key primary key (hospnum, ptid, sryka);
