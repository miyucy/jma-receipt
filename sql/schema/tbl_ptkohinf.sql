CREATE TABLE tbl_ptkohinf (
    hospid character(24) NOT NULL,
    ptid numeric(10,0) NOT NULL,
    kohid numeric(10,0) NOT NULL,
    kohnum character(3),
    paykbn character(2),
    ftnjanum character(8),
    jkysnum character(20),
    tekstymd character(8),
    tekedymd character(8),
    kakuninymd character(8),
    sakjokbn character(1),
    termid character varying(16),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6)
);

ALTER TABLE ONLY tbl_ptkohinf
    ADD CONSTRAINT tbl_ptkohinf_primary_key PRIMARY KEY (hospid, ptid, kohid);

