\set ON_ERROR_STOP

alter table tbl_syumei add  column hospnum  integer;
alter table tbl_syumei drop column hospid;
update tbl_syumei set hospnum = 1 ;
alter table tbl_syumei add constraint tbl_syumei_primary_key primary key (hospnum, nyugaikbn, ptid, denpnum, denpedanum);
