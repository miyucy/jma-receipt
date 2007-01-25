\set ON_ERROR_STOP

alter table tbl_syuday add  column hospnum  integer;
alter table tbl_syuday drop column hospid;
update tbl_syuday set hospnum = 1 ;
alter table tbl_syuday add constraint tbl_syuday_primary_key primary key (hospnum, nyugaikbn, ptid, denpnum);
