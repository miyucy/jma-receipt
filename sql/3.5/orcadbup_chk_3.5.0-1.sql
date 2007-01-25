\set ON_ERROR_STOP

alter table tbl_chk add  column hospnum  integer;
update tbl_chk set hospnum = 1 ;
alter table tbl_chk drop constraint  tbl_chk_primary_key;
alter table tbl_chk add constraint tbl_chk_primary_key primary key (hospnum,chkkbn, srycd, yukostymd, yukoedymd, cdkbn, rennum);
