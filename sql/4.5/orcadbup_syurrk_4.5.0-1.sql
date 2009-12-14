\set ON_ERROR_STOP

alter table tbl_syurrk add column chosei1 numeric(7,0);
alter table tbl_syurrk add column chosei2 numeric(7,0);
update tbl_syurrk set chosei1 = chosei;
update tbl_syurrk set chosei2 = 0 ;

