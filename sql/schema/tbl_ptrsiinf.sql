CREATE TABLE tbl_ptrsiinf (
    hospid character(24) NOT NULL,
    ptid numeric(10,0) NOT NULL,
    hknid numeric(10,0) NOT NULL,
    hknkbn character(1),
    hknnum character(3),
    kofunum character(14),
    hihknjaname character varying(100),
    jigyouname character varying(80),
    prefname character varying(20),
    prefkbn character(1),
    cityname character varying(80),
    citykbn character(1),
    sinkei character(1),
    tenki character(1),
    shobyoymd character(8),
    sisikbn character(1),
    ryostymd character(8),
    ryoedymd character(8),
    sonshoukbn character(2),
    sonshoukbn_edanum character(1),
    sinsatuymd character(8),
    sinsatuend character(8),
    kakuninymd character(8),
    sakujokbn character(1),
    "comment" character varying(200),
    saigaikbn character(1),
    jibaiseikbn character(1),
    drcd character(5) DEFAULT ' '::bpchar,
    hokenname character varying(80) DEFAULT ' '::character varying,
    termid character varying(16),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6)
);

ALTER TABLE ONLY tbl_ptrsiinf
    ADD CONSTRAINT tbl_ptrsiinf_primary_key PRIMARY KEY (hospid, ptid, hknid);

COMMENT ON TABLE tbl_ptrsiinf IS '´µ¼ÔÏ«ºÒÊÝ¸±¾ðÊó';

