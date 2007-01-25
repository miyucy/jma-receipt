\set ON_ERROR_STOP

alter table tbl_teikirrk add  column hospnum  integer;
update tbl_teikirrk set hospnum = 1 ;
alter table tbl_teikirrk drop constraint  tbl_teikirrk_primary_key;
alter table tbl_teikirrk add constraint tbl_teikirrk_primary_key primary key (hospnum,sryym, kbt);
