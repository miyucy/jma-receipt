CREATE TABLE tbl_chk (
    chkkbn character(1) NOT NULL,
    srycd character(9) NOT NULL,
    yukostymd character(8) NOT NULL,
    yukoedymd character(8) NOT NULL,
    cdkbn character(1) NOT NULL,
    rennum numeric(2,0) NOT NULL,
    tekcdnum numeric(3,0) DEFAULT 0,
    cd1 character(9),
    cd2 character(9),
    cd3 character(9),
    cd4 character(9),
    cd5 character(9),
    cd6 character(9),
    cd7 character(9),
    cd8 character(9),
    cd9 character(9),
    cd10 character(9),
    termid character varying(16),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6)
);

ALTER TABLE ONLY tbl_chk
    ADD CONSTRAINT tbl_chk_primary_key PRIMARY KEY (chkkbn, srycd, yukostymd, yukoedymd, cdkbn, rennum);

COMMENT ON TABLE tbl_chk IS 'チェック';

