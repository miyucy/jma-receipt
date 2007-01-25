\set ON_ERROR_STOP

alter table tbl_teikikanri add  column hospnum  integer;
update tbl_teikikanri set hospnum = 1 ;
alter table tbl_teikikanri drop constraint  tbl_teikikanri_primary_key;
alter table tbl_teikikanri add constraint tbl_teikikanri_primary_key primary key (hospnum,btunum);
