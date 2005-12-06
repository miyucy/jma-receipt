CREATE TABLE tbl_tsyrrk (
    hospid character(24) NOT NULL,
    ptid numeric(10,0) NOT NULL,
    ninstymd character(8) NOT NULL,
    ninedymd character(8),
    skjgnstymd character(8),
    termid character varying(16),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6)
);

ALTER TABLE ONLY tbl_tsyrrk
    ADD CONSTRAINT tbl_tsyrrk_primary_key PRIMARY KEY (hospid, ptid, ninstymd);

COMMENT ON TABLE tbl_tsyrrk IS 'ƒ„ΩÍ∆¿º‘Õ˙ŒÚ';

