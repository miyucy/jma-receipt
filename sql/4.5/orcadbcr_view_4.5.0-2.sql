\set ON_ERROR_STOP

CREATE VIEW view_q003 AS
    SELECT tbl_sryact.hospnum,
           tbl_sryact.ptid,
           tbl_sryact.nyugaikbn,
           tbl_sryact.sryka,
           tbl_sryact.srykbn,
           tbl_sryact.srysyukbn,
           tbl_sryact.srycd1,
           tbl_sryact.srycd2,
           tbl_sryact.srycd3,
           tbl_sryact.srycd4,
           tbl_sryact.srycd5 
      FROM tbl_sryact 
     UNION ALL SELECT tbl_nsrysrh.hospnum,
           tbl_nsrysrh.ptid,
           '1' AS nyugaikbn,
           tbl_nsrysrh.sryka,
           tbl_nsrysrh.srykbn,
           '   '::character(3) AS srysyukbn,
           tbl_nsrysrh.srycd AS srycd1,
           tbl_nsrysrh.srycd AS srycd2,
           tbl_nsrysrh.srycd AS srycd3,
           tbl_nsrysrh.srycd AS srycd4,
           tbl_nsrysrh.srycd AS srycd5 
      FROM tbl_nsrysrh;

COMMENT 
        ON VIEW view_q003 IS '患者照会ビュー3';

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
     UNION ALL SELECT a.hospnum,
           a.ptid,
           '1' AS nyugaikbn,
           b.sryka,
           b.srykbn,
           '   '::character(3) AS srysyukbn,
           a.sryymd,
           b.srycd AS srycd1,
           b.srycd AS srycd2,
           b.srycd AS srycd3,
           b.srycd AS srycd4,
           b.srycd AS srycd5 
      FROM tbl_nrrksrh a,
           tbl_nsrysrh b 
     WHERE (((a.hospnum = b.hospnum) 
       AND (a.ptid = b.ptid)) 
       AND (a.zainum = b.zainum));

COMMENT 
        ON VIEW view_q002 IS '患者照会ビュー2';

CREATE VIEW view_i001 AS
    SELECT a.hospnum,
           a.ptid,
           b.rrknum,
           b.rrkedanum,
           e.rrkedanum_max,
           c.ptnum,
           a.kananame,
           a.name,
           a.sex,
           a.birthday,
           a.home_post,
           a.home_adrs,
           a.home_banti,
           a.deathkbn,
           b.btunum,
           b.brmnum,
           b.nyuinka,
           b.nyuinymd,
           b.taiinymd,
           b.taiincd,
           b.tennyuymd,
           b.tenstuymd,
           a.tstptnumkbn 
      FROM tbl_ptnyuinrrk b,
           tbl_ptnyuinrrk d,
           
   (SELECT tbl_ptnyuinrrk.hospnum,
           tbl_ptnyuinrrk.ptid,
           tbl_ptnyuinrrk.rrknum,
           max(tbl_ptnyuinrrk.rrkedanum) AS rrkedanum_max 
      FROM tbl_ptnyuinrrk 
     GROUP BY tbl_ptnyuinrrk.hospnum,
           tbl_ptnyuinrrk.ptid,
           tbl_ptnyuinrrk.rrknum) e,
           tbl_ptinf a,
           tbl_ptnum c 
     WHERE ((((((((((((((((b.hospnum = a.hospnum) 
       AND (b.ptid = a.ptid)) 
       AND (b.hospnum = c.hospnum)) 
       AND (b.ptid = c.ptid)) 
       AND (b.hospnum = d.hospnum)) 
       AND (b.ptid = d.ptid)) 
       AND (a.rrknum <> (0)::numeric)) 
       AND (a.rrkedanum <> (0)::numeric)) 
       AND (a.rrknum = d.rrknum)) 
       AND (a.rrkedanum = d.rrkedanum)) 
       AND (d.kensaku_dispkbn = '1'::bpchar)) 
       AND (b.jtikbn <> '5'::bpchar)) 
       AND (b.jtikbn <> '6'::bpchar)) 
       AND (b.hospnum = e.hospnum)) 
       AND (b.ptid = e.ptid)) 
       AND (b.rrknum = e.rrknum));

COMMENT 
        ON VIEW view_i001 IS '入院患者照会ビュー';

