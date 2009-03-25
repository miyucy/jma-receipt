CREATE TABLE tbl_nrrksrh (
    hospnum numeric(2,0) NOT NULL,
    ptid numeric(10,0) NOT NULL,
    sryymd character(8) NOT NULL,
    zainum numeric(9,0) NOT NULL,
    rrknum numeric(3,0) NOT NULL,
    termid character varying(16),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6)
);

COMMENT ON TABLE tbl_nrrksrh IS 'Æþ±¡ÍúÎò¾È²ñ';

ALTER TABLE ONLY tbl_nrrksrh
    ADD CONSTRAINT tbl_nrrksrh_primary_key PRIMARY KEY (hospnum, ptid, sryymd, zainum, rrknum);

