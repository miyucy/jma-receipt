-- tbl_seikyu_main --

\set ON_ERROR_STOP

ALTER TABLE tbl_seikyu_main DROP CONSTRAINT tbl_seikyu_main_primary_key;
alter table tbl_seikyu_main add column kohid_key bigint default 0;
alter table tbl_seikyu_main add column skyiryo_nissu smallint default 0;
alter table tbl_seikyu_main add column skyiryo_totalten integer  default 0;
alter table tbl_seikyu_main add column skyiryo_ichibuftn integer  default 0;
alter table tbl_seikyu_main add column skyiryo_hokenja  integer  default 0;
alter table tbl_seikyu_main add column skyiryo_kohftn   integer  default 0;
alter table tbl_seikyu_main add column skyskj_kaisu     smallint default 0;
alter table tbl_seikyu_main add column skyskj_ryoyohi   integer  default 0;
alter table tbl_seikyu_main add column skyskj_ichibuftn integer  default 0;
alter table tbl_seikyu_main add column skyskj_hokenja   integer  default 0;
alter table tbl_seikyu_main add column skyskj_kohftn    integer  default 0;
alter table tbl_seikyu_main add column hkncombi1 smallint default 0;
alter table tbl_seikyu_main add column hkncombi2 smallint default 0;
alter table tbl_seikyu_main add column hkncombi3 smallint default 0;
alter table tbl_seikyu_main add column hkncombi4 smallint default 0;
alter table tbl_seikyu_main add column hkncombi5 smallint default 0;
alter table tbl_seikyu_main add column hkncombi6 smallint default 0;
alter table tbl_seikyu_main add column hkncombi7 smallint default 0;
alter table tbl_seikyu_main add column hkncombi8 smallint default 0;
alter table tbl_seikyu_main add column hkncombi9 smallint default 0;
alter table tbl_seikyu_main add column hkncombi10 smallint default 0;
alter table tbl_seikyu_main add column crehms char(6);
alter table tbl_seikyu_main add column updhms char(6);
update tbl_seikyu_main set kohid_key = 0;
update tbl_seikyu_main set skyiryo_nissu = 0;
update tbl_seikyu_main set skyiryo_totalten = 0;
update tbl_seikyu_main set skyiryo_ichibuftn = 0;
update tbl_seikyu_main set skyiryo_hokenja = 0;
update tbl_seikyu_main set skyiryo_kohftn = 0;
update tbl_seikyu_main set skyskj_kaisu = 0;
update tbl_seikyu_main set skyskj_ryoyohi = 0;
update tbl_seikyu_main set skyskj_ichibuftn = 0;
update tbl_seikyu_main set skyskj_hokenja = 0;
update tbl_seikyu_main set skyskj_kohftn = 0;
update tbl_seikyu_main set hkncombi1 = 0;
update tbl_seikyu_main set hkncombi2 = 0;
update tbl_seikyu_main set hkncombi3 = 0;
update tbl_seikyu_main set hkncombi4 = 0;
update tbl_seikyu_main set hkncombi5 = 0;
update tbl_seikyu_main set hkncombi6 = 0;
update tbl_seikyu_main set hkncombi7 = 0;
update tbl_seikyu_main set hkncombi8 = 0;
update tbl_seikyu_main set hkncombi9 = 0;
update tbl_seikyu_main set hkncombi10 = 0;
update tbl_seikyu_main set crehms = '';
update tbl_seikyu_main set updhms = '000000';
alter table tbl_seikyu_main alter column kohid_key set not null;
ALTER TABLE ONLY tbl_seikyu_main
ADD CONSTRAINT tbl_seikyu_main_primary_key PRIMARY KEY (hospnum, sryym, nyugaikbn, ptid, receka, teisyutusaki, recesyubetu, hknjanum, hojokbn_key, kohid_key, tekstymd);

