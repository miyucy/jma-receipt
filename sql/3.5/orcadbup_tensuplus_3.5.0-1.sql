\set ON_ERROR_STOP

alter table tbl_tensuplus add  column hospnum  integer;
update tbl_tensuplus set hospnum = 1 ;
alter table tbl_tensuplus drop constraint  tbl_tensuplus_primary_key;
alter table tbl_tensuplus add constraint tbl_tensuplus_primary_key primary key (hospnum, srycd, yukostymd, yukoedymd);
