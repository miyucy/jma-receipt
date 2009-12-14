\set ON_ERROR_STOP

alter table tbl_syunou_main add column chosei1 numeric(7,0);
alter table tbl_syunou_main add column chosei2 numeric(7,0);
update tbl_syunou_main set chosei1 = chosei;
update tbl_syunou_main set chosei2 = 0 ;

