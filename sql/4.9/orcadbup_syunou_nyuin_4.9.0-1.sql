--
-- ¼ıÇ¼¡ÊÆş±¡¡Ë¥Æ¡¼¥Ö¥ë
-- ¹àÌÜÄÉ²Ã¡§¿©»ö£±£±¡Á¿©»ö£±£´
--           Æş±¡¤½¤ÎÂ¾£±¤«¤é£µ
-- Create Date : 2016/2/23

\set ON_ERROR_STOP

alter table tbl_syunou_nyuin add column shokuji11_nissu smallint;
alter table tbl_syunou_nyuin add column shokuji11 integer;
alter table tbl_syunou_nyuin add column shokuji12_nissu smallint;
alter table tbl_syunou_nyuin add column shokuji12 integer;
alter table tbl_syunou_nyuin add column shokuji13_nissu smallint;
alter table tbl_syunou_nyuin add column shokuji13 integer;
alter table tbl_syunou_nyuin add column shokuji14_nissu smallint;
alter table tbl_syunou_nyuin add column shokuji14 integer;
alter table tbl_syunou_nyuin add column nyuinetc1 integer;
alter table tbl_syunou_nyuin add column nyuinetc2 integer;
alter table tbl_syunou_nyuin add column nyuinetc3 integer;
alter table tbl_syunou_nyuin add column nyuinetc4 integer;
alter table tbl_syunou_nyuin add column nyuinetc5 integer;
update tbl_syunou_nyuin set shokuji11_nissu = 0;
update tbl_syunou_nyuin set shokuji11 = 0;
update tbl_syunou_nyuin set shokuji12_nissu = 0;
update tbl_syunou_nyuin set shokuji12 = 0;
update tbl_syunou_nyuin set shokuji13_nissu = 0;
update tbl_syunou_nyuin set shokuji13 = 0;
update tbl_syunou_nyuin set shokuji14_nissu = 0;
update tbl_syunou_nyuin set shokuji14 = 0;
update tbl_syunou_nyuin set nyuinetc1 = 0;
update tbl_syunou_nyuin set nyuinetc2 = 0;
update tbl_syunou_nyuin set nyuinetc3 = 0;
update tbl_syunou_nyuin set nyuinetc4 = 0;
update tbl_syunou_nyuin set nyuinetc5 = 0;
