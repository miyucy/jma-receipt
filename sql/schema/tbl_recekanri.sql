CREATE TABLE tbl_recekanri (
    prtid character(4) NOT NULL,
    syokbn character(1) NOT NULL,
    creymd character(8) NOT NULL,
    crehms character(6) NOT NULL,
    teisyutusaki character(1) NOT NULL,
    recesyubetu character(4) NOT NULL,
    nyugaikbn character(1),
    sryym character(6),
    page numeric(5,0) DEFAULT 0,
    kensu numeric(5,0) DEFAULT 0,
    recekbn character(1),
    syorisbt character(1),
    stymd character(8),
    edymd character(8),
    termid character varying(16)
);

ALTER TABLE ONLY tbl_recekanri
    ADD CONSTRAINT tbl_recekanri_primary_key PRIMARY KEY (prtid, syokbn, creymd, crehms, teisyutusaki, recesyubetu);

COMMENT ON TABLE tbl_recekanri IS 'レセプト管理';

