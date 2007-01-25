\set ON_ERROR_STOP

alter table tbl_nyuinkhn add  column hospnum  integer;
update tbl_nyuinkhn set hospnum = 1 ;
alter table tbl_nyuinkhn drop constraint  tbl_nyuinkhn_primary_key;
alter table tbl_nyuinkhn add constraint tbl_nyuinkhn_primary_key primary key (hospnum,khn_srycd, yukostymd, yukoedymd);
drop index idx_nyuinkhn_key2;
create index idx_nyuinkhn_key2 on tbl_nyuinkhn(hospnum,btusbtkbn, heikinzaikbn, kangohaichikbn, kangohiritukbn, kangohojohaichikbn);
