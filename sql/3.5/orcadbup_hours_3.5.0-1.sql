\set ON_ERROR_STOP

alter table tbl_hours add  column hospnum  integer;
update tbl_hours set hospnum = 1 ;
alter table tbl_hours drop constraint  tbl_hours_primary_key;
alter table tbl_hours add constraint tbl_hours_primary_key primary key (hospnum,sryymd, "time");
