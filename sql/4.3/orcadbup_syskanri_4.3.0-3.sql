--                                    --
-- システム管理データ更新             --
-- 日次・月次統計プログラム           --
-- パラメタ情報更新SQL                --
--                                    --
-- Create Date : 2008/07/11           --
--                                    --

\set ON_ERROR_STOP

delete from tbl_syskanri where kanricd = '0043' and kbncd = '1010' and styukymd = '00000000' and  edyukymd = '99999999';

delete from tbl_syskanri where hospnum = 0;

COPY tbl_syskanri FROM stdin;
0043	1010    	00000000	99999999	収納日報                                                                                                                                                        ORCBD010                処理日              YMD       終了処理日          YMD       入外区分            PSN1      集計区分            PSN1      明細区分            PSN1      合計表印刷区分      PSN1                                                                                                                              121111    1			20070209	20080710	160049	0
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



		update tbl_syskanri set kanritbl = encode(substr(decode(replace(a.kanritbl,'\\','\\\\'),'escape')||decode(repeat(' ',500),'escape'),1,494)||(substr(decode(replace(tbl_syskanri.kanritbl,'\\','\\\\'),'escape')||decode(repeat(' ',500),'escape'),495,1)),'escape')
		from tbl_syskanri a
		where
		tbl_syskanri.hospnum = a.hospnum
		and  a.kanricd in ('0043','0044')
		and  tbl_syskanri.kanricd in ('3001','3002')
		and  substr(decode(replace(a.kanritbl,'\\','\\\\'),'escape'),161,24)
		  =  substr(decode(replace(tbl_syskanri.kanritbl,'\\','\\\\'),'escape'),161,24);
		;

