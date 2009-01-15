--                                              --
-- ビュー再作成                                 --
-- view_q002   照会２                           --
-- view_q003   照会３                           --
--                                              --
-- Create Date : 2009/01/15                     --
--                                              --
\set ON_ERROR_STOP

CREATE VIEW view_q002 AS
    SELECT a.hospnum,
           a.ptid,
           a.nyugaikbn,
           a.sryka,
           a.srykbn,
           a.srysyukbn,
           b.sryymd,
           a.srycd1,
           a.srycd2,
           a.srycd3,
           a.srycd4,
           a.srycd5 
      FROM tbl_sryact a,
           tbl_jyurrk b 
     WHERE (((((a.hospnum = b.hospnum) 
       AND (a.ptid = b.ptid)) 
       AND (a.nyugaikbn = b.nyugaikbn)) 
       AND (a.sryka = b.sryka)) 
       AND (((((((((((((((a.zainum = b.zainum1) 
        OR (a.zainum = b.zainum2)) 
        OR (a.zainum = b.zainum3)) 
        OR (a.zainum = b.zainum4)) 
        OR (a.zainum = b.zainum5)) 
        OR (a.zainum = b.zainum6)) 
        OR (a.zainum = b.zainum7)) 
        OR (a.zainum = b.zainum8)) 
        OR (a.zainum = b.zainum9)) 
        OR (a.zainum = b.zainum10)) 
        OR (a.zainum = b.zainum11)) 
        OR (a.zainum = b.zainum12)) 
        OR (a.zainum = b.zainum13)) 
        OR (a.zainum = b.zainum14)) 
        OR (a.zainum = b.zainum15)))
union all
	select	a.hospnum,a.ptid,'1' as nyugaikbn ,b.sryka,b.srykbn,'',a.sryymd,b.srycd as srycd1 ,'' as srycd2 , '' as srycd3, '' as srycd4,'' as srycd5     from tbl_nrrksrh a , tbl_nsrysrh b where a.hospnum = b.hospnum and a.ptid = b.ptid and a.zainum = b.zainum 
;
COMMENT 
        ON VIEW view_q002 IS '患者照会ビュー2';



create  view view_q003 as
	select	hospnum,ptid,nyugaikbn,sryka,srykbn,srysyukbn,srycd1,srycd2,srycd3,srycd4,srycd5 from tbl_sryact
union all
	select	hospnum,ptid,'1' as nyugaikbn ,sryka,srykbn,'',srycd as srycd1 ,'' as srycd2 , '' as srycd3, '' as srycd4,'' as srycd5     from tbl_nsrysrh
;

COMMENT 
        ON VIEW view_q003 IS '患者照会ビュー3';

