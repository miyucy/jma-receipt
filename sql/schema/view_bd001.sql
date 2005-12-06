CREATE VIEW view_bd001 AS
    SELECT a.hospid,
           a.ptid,
           b.ptnum,
           c.name,
           c.sex,
           c.birthday,
           a.sryka,
           a.denpprtymd,
           a.skymoney,
           a.nyukin_total 
      FROM tbl_syunou a,
           tbl_ptnum b,
           tbl_ptinf c 
     WHERE ((((((((a.hospid = b.hospid) 
       AND (a.ptid = b.ptid)) 
       AND (a.hospid = c.hospid)) 
       AND (a.ptid = c.ptid)) 
       AND (a.denpjtikbn <> '3'::bpchar)) 
       AND (a.denpjtikbn <> '7'::bpchar)) 
       AND (a.createkbn <> '3'::bpchar)) 
       AND (c.tstptnumkbn <> '1'::bpchar));

