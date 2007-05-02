\set ON_ERROR_STOP

alter table tbl_tensuplus2 add  column hospnum  integer;
update tbl_tensuplus2 set hospnum = 1 ;
alter table tbl_tensuplus2 drop constraint  tbl_tensuplus2_primary_key;
alter table tbl_tensuplus2 add constraint tbl_tensuplus2_primary_key primary key (hospnum, srycd);
