\set ON_ERROR_STOP

alter table tbl_tnkrrk add  column hospnum  integer;
alter table tbl_tnkrrk drop column hospid;
update tbl_tnkrrk set hospnum = 1 ;
alter table tbl_tnkrrk add constraint tbl_tnkrrk_primary_key primary key (hospnum, ptid, stymd);
