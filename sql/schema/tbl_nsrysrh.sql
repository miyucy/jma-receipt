CREATE TABLE tbl_nsrysrh (
    hospnum numeric(2,0) NOT NULL,
    ptid numeric(10,0) NOT NULL,
    zainum numeric(9,0) NOT NULL,
    sryym character(6) NOT NULL,
    sryka character(2),
    hkncombinum character(4),
    srykbn character(2),
    srycd character(9),
    brmnum character(8),
    rm_sagaku character(2),
    termid character varying(16),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6)
);

COMMENT ON TABLE tbl_nsrysrh IS 'Æþ±¡¿ÇÎÅ¹Ô°Ù¾È²ñ';

ALTER TABLE ONLY tbl_nsrysrh
    ADD CONSTRAINT tbl_nsrysrh_primary_key PRIMARY KEY (hospnum, ptid, zainum, sryym);

