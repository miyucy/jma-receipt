\set ON_ERROR_STOP

delete from tbl_toukeimemo where pgid in ('ORCBG013V02') and kanricd = '0000';
delete from tbl_toukeimemo where pgid in ('ORCBHYOUKETU') and kanricd = '0000';

COPY "tbl_toukeimemo" FROM stdin;
ORCBHYOUKETU	0000	000     	00000000	99999999									処理区分\n１：標欠会計更新１００分の１０\n２：標欠会計更新１００分の１５\n３：標欠会計更新１００分の２\n４：標欠会計更新１００分の３\n５：標欠会計更新（取消し）\n			20060818	20060818	153238
\.
