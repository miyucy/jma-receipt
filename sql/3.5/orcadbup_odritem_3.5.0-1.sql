\set ON_ERROR_STOP

alter table tbl_odritem add  column hospnum  integer;
alter table tbl_odritem drop column hospid;
update tbl_odritem set hospnum = 1 ;
alter table tbl_odritem add constraint tbl_odritem_primary_key primary key (hospnum, karte_key, ordernum, itemnum);
