\set ON_ERROR_STOP

alter table tbl_chk005 add  column hospnum  integer;
update tbl_chk005 set hospnum = 1 ;
alter table tbl_chk005 drop constraint  tbl_chk005_primary_key;
alter table tbl_chk005 add constraint tbl_chk005_primary_key primary key (hospnum, chkkbn, id, rennum);
drop index idx_chk005_rennum;
create index idx_chk005_rennum on tbl_chk005(hospnum, chkkbn, rennum);
