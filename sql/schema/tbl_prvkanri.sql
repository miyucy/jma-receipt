CREATE TABLE tbl_prvkanri (
    tbl_key character(8) NOT NULL,
    rennum numeric(4,0) NOT NULL,
    tbl_group character(14) NOT NULL,
    shori_rennum numeric(4,0) NOT NULL,
    shellid character varying(20),
    prtid character varying(20),
    sryym character varying(6),
    skyymd character varying(8),
    ptid numeric(10,0),
    page numeric(5,0) NOT NULL,
    mod_flg character(1),
    shori_mod_flg character(1),
    filename character varying(200),
    title character varying(100),
    prtnm character varying(16),
    ptnum character varying(20),
    memo character varying(100),
    rece_flg numeric(4,0),
    shori_kbn character(1),
    tbl_group1 character(14),
    tbl_group2 character(14),
    tbl_group3 character(14),
    tbl_group4 character(14),
    tbl_group5 character(14),
    termid character varying(32),
    opid character varying(16),
    creymd character varying(8),
    upymd character varying(8),
    uphms character varying(6)
);

ALTER TABLE ONLY tbl_prvkanri
    ADD CONSTRAINT tbl_prvkanri_pkey PRIMARY KEY (tbl_key, rennum, tbl_group, shori_rennum, page);

COMMENT ON TABLE tbl_prvkanri IS '�ץ�ӥ塼����';

