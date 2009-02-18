--                                    --
-- 統計覚え書きデータ更新             --
-- 日次・月次統計プログラム           --
--                                    --
-- Create Date : 2008/07/11           --
--                                    --

\set ON_ERROR_STOP

delete from tbl_toukeimemo where pgid = 'ORCBNYUALL' and kanricd = '0000' and kbncd = '000';
delete from tbl_toukeimemo where hospnum = 0;

COPY tbl_toukeimemo FROM stdin;
ORCBNYUALL	0000	000     	00000000	99999999									診療年月日　　　取込対象とする診療年月日を入力します。\n処理区分　　　　０：全てのデータを対象とします。\n　　　　　　　　１：外部連携（ＣＬＡＩＭ等）のデータのみ対象とします。\nリスト区分　　　０：取込分、エラー分全てを印刷対象とします\n　　　　　　　　１：エラー分（警告も含め)のみのデータを印刷対象とします。\n\n\n			20081203	20081203	160343	0	 		
\.

insert into tbl_toukeimemo select a.pgid,a.kanricd,a.kbncd,a.styukymd,a.edyukymd,a.para1,a.para2,a.para3,a.para4,a.para5,
a.para6,a.para7,a.para8,a.memo,a.termid,a.opid,to_char(now(),'yyyymmdd'),to_char(now(),'yyyymmdd'),to_char(now(),'hh24miss'),
b.hospnum,a.savepara,a.para9,a.para10
from tbl_toukeimemo a,tbl_sysbase b where a.hospnum = 0;

delete from tbl_toukeimemo where hospnum = 0;
