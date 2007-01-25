\set ON_ERROR_STOP

alter table tbl_hknjainf add  column hospnum  integer;
alter table tbl_hknjainf drop column hospid;
update tbl_hknjainf set hospnum = 1 ;
alter table tbl_hknjainf add constraint tbl_hknjainf_primary_key primary key (hospnum, hknjanum);
