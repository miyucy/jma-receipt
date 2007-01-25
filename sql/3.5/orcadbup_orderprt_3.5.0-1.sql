\set ON_ERROR_STOP

alter table tbl_orderprt add  column hospnum  integer;
alter table tbl_orderprt drop column hospid;
update tbl_orderprt set hospnum = 1 ;
alter table tbl_orderprt add constraint tbl_orderprt_primary_key primary key (hospnum, ptid, ptnum, nyugaikbn, sryka, hkncombi, sysymd, printymd, printhms, prtkbn, ordernum, rennum);
