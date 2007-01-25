\set ON_ERROR_STOP

alter table tbl_nyuinact add  column hospnum  integer;
alter table tbl_nyuinact drop column hospid;
update tbl_nyuinact set hospnum = 1 ;
alter table tbl_nyuinact add constraint tbl_nyuinact_primary_key primary key (hospnum, nyugaikbn, ptid, sryka, sryym, zainum, rennum);
