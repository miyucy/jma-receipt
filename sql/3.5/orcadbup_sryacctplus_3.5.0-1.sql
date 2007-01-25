\set ON_ERROR_STOP

alter table tbl_sryacctplus add  column hospnum  integer;
alter table tbl_sryacctplus drop column hospid;
update tbl_sryacctplus set hospnum = 1 ;
alter table tbl_sryacctplus add constraint tbl_sryacctplus_primary_key primary key (hospnum, nyugaikbn, ptid, sryka, sryym, zainum, rennum);
