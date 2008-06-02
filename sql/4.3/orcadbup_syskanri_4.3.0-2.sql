--                                    --
-- システム管理データ更新             --
-- 月次統計プログラム 0044            --
--                                    --
--                                    --
-- Create Date : 2008/06/02           --
--                                    --

\set ON_ERROR_STOP

delete from tbl_syskanri where kanricd = '0044' and kbncd = '1029';
delete from tbl_syskanri where hospnum = 0;

COPY tbl_syskanri (kanricd, kbncd, styukymd, edyukymd, kanritbl, termid, opid, creymd, upymd, uphms, hospnum) FROM stdin;
0044	1029     	00000000	99999999	月遅れ分レセ電データ未作成患者一覧                                                                                                                              ORCBG019                診療年月            YM                                                                                                                                                                                                                                                                                      1			20080530	20080530	155116	0
\.


insert into tbl_syskanri
select
a.kanricd,
a.kbncd,
a.styukymd,
a.edyukymd,
a.kanritbl,
a.termid,
a.opid,
a.creymd,
a.upymd,
a.uphms,
b.hospnum
from tbl_syskanri a,tbl_sysbase b
where
    a.hospnum = 0 ;

delete from tbl_syskanri where hospnum = 0;


