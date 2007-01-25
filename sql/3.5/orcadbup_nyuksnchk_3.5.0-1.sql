\set ON_ERROR_STOP

alter table tbl_nyuksnchk add  column hospnum  integer;
update tbl_nyuksnchk set hospnum = 1 ;
alter table tbl_nyuksnchk drop constraint  tbl_nyuksnchk_primary_key;
alter table tbl_nyuksnchk add constraint tbl_nyuksnchk_primary_key primary key (hospnum,nyuinkbn, ksnkbn, yukostymd, yukoedymd);
