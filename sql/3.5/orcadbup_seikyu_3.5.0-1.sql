\set ON_ERROR_STOP

alter table tbl_seikyu add  column hospnum  integer;
alter table tbl_seikyu drop column hospid;
update tbl_seikyu set hospnum = 1 ;
alter table tbl_seikyu add constraint tbl_seikyu_primary_key primary key (hospnum, sryym, nyugaikbn, ptid, receka, teisyutusaki, recesyubetu, hknjanum, hojokbn_key, tekstymd);
