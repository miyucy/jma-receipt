\set ON_ERROR_STOP

alter table tbl_hkncombi add  column hospnum  integer;
alter table tbl_hkncombi drop column hospid;
update tbl_hkncombi set hospnum = 1 ;
alter table tbl_hkncombi add constraint tbl_hkncombi_primary_key primary key (hospnum, ptid, hkncombinum);
