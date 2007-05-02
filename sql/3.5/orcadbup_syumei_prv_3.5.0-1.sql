\set ON_ERROR_STOP

alter table tbl_syumei_prv add  column hospnum  integer;
alter table tbl_syumei_prv drop column hospid;
update tbl_syumei_prv set hospnum = 1 ;
alter table tbl_syumei_prv add constraint tbl_syumei_prv_primary_key primary key (hospnum, nyugaikbn, ptid, denpnum, denpedanum, creymd);
