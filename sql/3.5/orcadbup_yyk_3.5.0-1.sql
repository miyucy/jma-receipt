\set ON_ERROR_STOP

alter table tbl_yyk add  column hospnum  integer;
alter table tbl_yyk drop column hospid;
update tbl_yyk set hospnum = 1 ;
alter table tbl_yyk add constraint tbl_yyk_primary_key primary key (hospnum, srynaiyo, drcd, yykymd, keyyyktime, yykid);
