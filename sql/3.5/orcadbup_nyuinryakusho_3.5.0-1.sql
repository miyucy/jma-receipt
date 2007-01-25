\set ON_ERROR_STOP

alter table tbl_nyuinryakusho add  column hospnum  integer;
update tbl_nyuinryakusho set hospnum = 1 ;
alter table tbl_nyuinryakusho drop constraint  tbl_nyuinryakusho_primary_key;
alter table tbl_nyuinryakusho add constraint tbl_nyuinryakusho_primary_key primary key (hospnum,srycd, yukostymd, yukoedymd);
