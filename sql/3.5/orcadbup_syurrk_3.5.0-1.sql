\set ON_ERROR_STOP

alter table tbl_syurrk add  column hospnum  integer;
alter table tbl_syurrk drop column hospid;
update tbl_syurrk set hospnum = 1 ;
alter table tbl_syurrk add constraint tbl_syurrk_primary_key primary key (hospnum, ptid, nyugaikbn, denpnum, syurrknum, syuedanum);
