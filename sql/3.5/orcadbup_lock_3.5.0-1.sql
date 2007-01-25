\set ON_ERROR_STOP

alter table tbl_lock add  column hospnum  integer;
update tbl_lock set hospnum = 1 ;
alter table tbl_lock drop constraint  tbl_lock_pkey;
alter table tbl_lock add constraint tbl_lock_primary_key primary key (hospnum,lock_termid);
