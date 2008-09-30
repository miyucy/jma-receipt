CREATE TABLE tbl_userbyomei (
    cdsyu character(1) NOT NULL,
    byomeiinputcd character varying(20) NOT NULL,
    bunruicd character(3),
    dspseq numeric(2,0) DEFAULT 50,
    byomeicdsu numeric(2,0) DEFAULT 0,
    byomeicd_1 character(7),
    byomeicd_2 character(7),
    byomeicd_3 character(7),
    byomeicd_4 character(7),
    byomeicd_5 character(7),
    byomeicd_6 character(7),
    byomeicd_7 character(7),
    byomeicd_8 character(7),
    byomeicd_9 character(7),
    byomeicd_10 character(7),
    byomeicd_11 character(7),
    byomeicd_12 character(7),
    byomeicd_13 character(7),
    byomeicd_14 character(7),
    byomeicd_15 character(7),
    byomeicd_16 character(7),
    byomeicd_17 character(7),
    byomeicd_18 character(7),
    byomeicd_19 character(7),
    byomeicd_20 character(7),
    byomeicd_21 character(7),
    utagaiflg character(1),
    manseikbn numeric(2,0) DEFAULT 0,
    byomei character varying(160),
    byomeimoji numeric(2,0) DEFAULT 0,
    chartbyomei character varying(160),
    chartbyomeimoji numeric(2,0) DEFAULT 0,
    byomeihenflg character(1),
    hknbyomeiflg character(1),
    byomeisbt character(1),
    khnbyomeicd character(7),
    khnbuicd_1 character(7),
    khnbuicd_2 character(7),
    khnbuicd_3 character(7),
    termid character varying(16),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6),
    hospnum numeric(2,0) NOT NULL
);

COMMENT ON TABLE tbl_userbyomei IS '������̾';

ALTER TABLE ONLY tbl_userbyomei
    ADD CONSTRAINT tbl_userbyomei_primary_key PRIMARY KEY (hospnum, cdsyu, byomeiinputcd);

