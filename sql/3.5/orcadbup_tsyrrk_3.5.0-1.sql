\set ON_ERROR_STOP

alter table tbl_tsyrrk add  column hospnum  integer;
alter table tbl_tsyrrk drop column hospid;
update tbl_tsyrrk set hospnum = 1 ;
alter table tbl_tsyrrk add constraint tbl_tsyrrk_primary_key primary key (hospnum, ptid, ninstymd);
