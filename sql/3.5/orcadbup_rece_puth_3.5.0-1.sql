\set ON_ERROR_STOP

alter table tbl_rece_puth add  column hospnum  integer;
alter table tbl_rece_puth drop column hospid;
update tbl_rece_puth set hospnum = 1 ;
alter table tbl_rece_puth add constraint tbl_rece_puth_primary_key primary key (hospnum, styukymd, edyukymd);
