\set ON_ERROR_STOP

alter table tbl_chksnd add  column hospnum  integer;
update tbl_chksnd set hospnum = 1 ;
alter table tbl_chksnd drop constraint  tbl_chksnd_primary_key;
alter table tbl_chksnd add constraint tbl_chksnd_primary_key primary key (hospnum,chkkbn, srycd, yukostymd, yukoedymd, cdkbn, rennum);
