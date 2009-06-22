\set ON_ERROR_STOP

create  view view_q003 as
	select	hospnum,ptid,nyugaikbn,sryka,srykbn,srysyukbn,srycd1,srycd2,srycd3,srycd4,srycd5 from tbl_sryact
union all
	select	hospnum,ptid,'1' as nyugaikbn ,sryka,srykbn,'',srycd as srycd1 ,'' as srycd2 , '' as srycd3, '' as srycd4,'' as srycd5     from tbl_nsrysrh
;

COMMENT 
        ON VIEW view_q003 IS '患者照会ビュー3';
