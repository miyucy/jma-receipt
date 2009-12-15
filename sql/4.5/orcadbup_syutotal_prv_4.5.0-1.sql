\set ON_ERROR_STOP

alter table tbl_syutotal_prv add column chosei1 numeric(7,0);
alter table tbl_syutotal_prv add column chosei2 numeric(7,0);
update tbl_syutotal_prv set chosei1 = chosei;
update tbl_syutotal_prv set chosei2 = 0 ;

