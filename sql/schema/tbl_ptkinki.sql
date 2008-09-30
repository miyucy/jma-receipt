CREATE TABLE tbl_ptkinki (
    hospnum numeric(2,0) NOT NULL,
    ptid numeric(10,0) NOT NULL,
    srycd character(9) NOT NULL,
    termid character varying(32),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6)
);

COMMENT ON TABLE tbl_ptkinki IS '´µ¼Ô¶Ø´÷ÌôºÞ';

ALTER TABLE ONLY tbl_ptkinki
    ADD CONSTRAINT tbl_ptkinki_primary_key PRIMARY KEY (hospnum, ptid, srycd);

