CREATE TABLE tbl_prtdata (
    tbl_key character(8) NOT NULL,
    rennum numeric(4,0) DEFAULT 0 NOT NULL,
    tbl_group character(14) NOT NULL,
    shori_rennum numeric(4,0) DEFAULT 0 NOT NULL,
    shellid character varying(20),
    prtid character varying(20),
    sryym character varying(6),
    skyymd character varying(8),
    ptid numeric(10,0) DEFAULT 0,
    priority numeric(4,0) DEFAULT 0,
    page numeric(5,0) DEFAULT 0 NOT NULL,
    prtflg character(1) NOT NULL,
    sitekbn character(1) DEFAULT '0'::bpchar NOT NULL,
    prtnm character(16) DEFAULT ' '::bpchar NOT NULL,
    prtdata character varying(10000)
);

ALTER TABLE ONLY tbl_prtdata
    ADD CONSTRAINT tbl_prtdata_primary_key PRIMARY KEY (tbl_key, rennum, tbl_group, shori_rennum, page);

