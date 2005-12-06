CREATE TABLE tbl_pthkninf (
    hospid character(24) NOT NULL,
    ptid numeric(10,0) NOT NULL,
    hknid numeric(10,0) NOT NULL,
    hknnum character(3),
    hknjanum character(8),
    hihknjaname character varying(100),
    honkzkkbn character(1),
    hojokbn character(1),
    contkbn character(1),
    kigo character varying(80),
    num character varying(80),
    skkgetymd character(8),
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

ALTER TABLE ONLY tbl_pthkninf
    ADD CONSTRAINT tbl_pthkninf_primary_key PRIMARY KEY (hospid, ptid, hknid);

