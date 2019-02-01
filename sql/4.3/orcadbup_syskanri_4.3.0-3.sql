--                                    --
-- システム管理データ更新             --
-- 日次・月次統計プログラム           --
-- パラメタ情報更新SQL                --
--                                    --
-- Create Date : 2008/07/11           --
--                                    --

\set ON_ERROR_STOP

delete from tbl_syskanri where kanricd = '0043' and kbncd in ('1010') and styukymd = '00000000' and  edyukymd = '99999999';
delete from tbl_syskanri where kanricd = '0044' and kbncd in ('1023','1024','1030','1031') and styukymd = '00000000' and  edyukymd = '99999999';

delete from tbl_syskanri where hospnum = 0;

COPY tbl_syskanri FROM stdin;
0043	1010    	00000000	99999999	収納日報                                                                                                                                                        ORCBD010                処理日              YMD       終了処理日          YMD       入外区分            PSN1      集計区分            PSN1      明細区分            PSN1      合計表印刷区分      PSN1                                                                                                                              121111    1			20070209	20080710	160049	0
0044	1023    	00000000	99999999	指定診療行為件数調                                                                                                                                              ORCBG016                診療年月            YM        入外区分            PSN1      診療科              SRYKA     診療行為１          SRYCD     診療行為２          SRYCD     診療行為３          SRYCD     診療行為４          SRYCD     診療行為５          SRYCD     診療行為６          SRYCD     診療行為７          SRYCD     1121222222			20060622	20080905	143956	0
0044	1024    	00000000	99999999	診療行為別集計表                                                                                                                                                ORCBG017                診療年月            YM        入外区分            PSN1      診療科              SRYKA     診療区分１          SRYKBN    診療区分２          SRYKBN    診療区分３          SRYKBN    診療区分４          SRYKBN    診療区分５          SRYKBN    診療区分６          SRYKBN    診療区分７          SRYKBN    1121222222			20060628	20080905	144546	0
0044	1030    	00000000	99999999	診療行為未入力患者一覧表                                                                                                                                        ORCBG020                開始診療年月        YM        終了診療年月        YM        並び順              PSN1                                                                                                                                                                                                                        221			20080905	20080905	145524	0
0044	1031    	00000000	99999999	入院診療行為照会情報作成                                                                                                                                        ORCBNSRYSRH             開始診療年月        YM                                                                                                                                                                                                                                                                                      2			20080905	20080905	150042	0
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
