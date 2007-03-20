CREATE VIEW view_bd003 AS
    SELECT a.hospid,
           a.nyugaikbn,
           a.ptid,
           a.denpnum,
           a.denpedanum,
           a.skymoney,
           a.nyuhen_money,
           a.nyuhen_ymd,
           b.sryymd 
      FROM (tbl_syumei a JOIN tbl_syunou b 
     USING (hospid,
           nyugaikbn,
           ptid,
           denpnum));

COMMENT 
        ON VIEW view_bd003 IS '��Ǽ�ӥ塼3';

