CREATE VIEW view_i001 AS
    SELECT a.hospid,
           a.ptid,
           b.rrknum,
           b.rrkedanum,
           c.ptnum,
           a.kananame,
           a.name,
           a.sex,
           a.birthday,
           a.home_post,
           a.home_adrs,
           a.home_banti,
           b.btunum,
           b.brmnum,
           b.nyuinka,
           b.nyuinymd,
           b.taiinymd,
           a.tstptnumkbn 
      FROM tbl_ptnyuinrrk b,
           tbl_ptnyuinrrk d,
           tbl_ptinf a,
           tbl_ptnum c 
     WHERE (((((((((((((b.hospid = a.hospid) 
       AND (b.ptid = a.ptid)) 
       AND (b.hospid = c.hospid)) 
       AND (b.ptid = c.ptid)) 
       AND (b.hospid = d.hospid)) 
       AND (b.ptid = d.ptid)) 
       AND (a.rrknum <> 0::numeric)) 
       AND (a.rrkedanum <> 0::numeric)) 
       AND (a.rrknum = d.rrknum)) 
       AND (a.rrkedanum = d.rrkedanum)) 
       AND (d.kensaku_dispkbn = '1'::bpchar)) 
       AND (b.rrkedanum = 
   (SELECT max(tbl_ptnyuinrrk.rrkedanum) AS max 
      FROM tbl_ptnyuinrrk 
     WHERE (((b.hospid = tbl_ptnyuinrrk.hospid) 
       AND (b.ptid = tbl_ptnyuinrrk.ptid)) 
       AND (b.rrknum = tbl_ptnyuinrrk.rrknum)) 
     GROUP BY tbl_ptnyuinrrk.hospid,
           tbl_ptnyuinrrk.ptid,
           tbl_ptnyuinrrk.rrknum))) 
       AND ((b.jtikbn <> '5'::bpchar) 
       AND (b.jtikbn <> '6'::bpchar)));

