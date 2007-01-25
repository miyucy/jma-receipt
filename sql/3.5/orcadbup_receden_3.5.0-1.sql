\set ON_ERROR_STOP

alter table tbl_receden add  column hospnum  integer;
alter table tbl_receden drop column hospid;
update tbl_receden set hospnum = 1 ;
alter table tbl_receden add constraint tbl_receden_primary_key primary key (hospnum, sryym, nyugaikbn, ptid, receka, teisyutusaki, recesyubetu, hknjanum, hojokbn_key, tekstymd, reckbn, rennum);
