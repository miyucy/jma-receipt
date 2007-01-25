\set ON_ERROR_STOP

alter table tbl_ryocom add  column hospnum  integer;
alter table tbl_ryocom drop column hospid;
update tbl_ryocom set hospnum = 1 ;
alter table tbl_ryocom add constraint tbl_ryocom_primary_key primary key (hospnum, nyugaikbn, ptid, sryym, zainum);
