CREATE TABLE tbl_ptnyuinrrk (
    hospid character(24) NOT NULL,
    ptid numeric(10,0) NOT NULL,
    rrknum numeric(3,0) NOT NULL,
    rrkedanum numeric(3,0) NOT NULL,
    btunum character(2),
    btuname character varying(20),
    brmnum character(8),
    nyuinka character(2),
    hkncombinum character(4),
    nyuinymd character(8),
    taiinymd character(8),
    taiincd character(2),
    tokutei_kbn character(1),
    tokutei_nyuin character(2),
    rm_sagaku character(2),
    teiki_seikyukbn character(1),
    kensaku_dispkbn character(1),
    shokaikbn character(1),
    shonum numeric(3,0),
    drcd1 character(5),
    drcd2 character(5),
    drcd3 character(5),
    jtikbn character(1),
    santei_btunum character(2),
    santei_brmnum character(8),
    tennyuymd character(8),
    tenstuymd character(8),
    taisyonissu numeric(5,0),
    tusannissu1 numeric(5,0),
    tusannissu2 numeric(5,0),
    nyuinchukbn character(1),
    doujitsukbn character(1),
    termid character varying(16),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6)
);

ALTER TABLE ONLY tbl_ptnyuinrrk
    ADD CONSTRAINT tbl_ptnyuinrrk_primary_key PRIMARY KEY (hospid, ptid, rrknum, rrkedanum);

COMMENT ON TABLE tbl_ptnyuinrrk IS '´µ¼ÔÆş±¡ÍúÎò';

