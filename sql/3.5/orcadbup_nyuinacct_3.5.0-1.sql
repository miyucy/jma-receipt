\set ON_ERROR_STOP

alter table tbl_nyuinacct add  column hospnum  integer;
alter table tbl_nyuinacct drop column hospid;
update tbl_nyuinacct set hospnum = 1 ;
alter table tbl_nyuinacct add constraint tbl_nyuinacct_primary_key primary key (hospnum, nyugaikbn, ptid, sryka, sryym, srykbn, zainum);
