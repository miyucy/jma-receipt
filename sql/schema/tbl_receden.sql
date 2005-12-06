CREATE TABLE tbl_receden (
    hospid character(24) NOT NULL,
    sryym numeric(6,0) DEFAULT 0 NOT NULL,
    nyugaikbn character(1) NOT NULL,
    ptid numeric(10,0) DEFAULT 0 NOT NULL,
    receka character(2) NOT NULL,
    teisyutusaki numeric(1,0) DEFAULT 0 NOT NULL,
    recesyubetu character(4) NOT NULL,
    hknjanum character(8) NOT NULL,
    hojokbn_key character(1) NOT NULL,
    tekstymd character(8) NOT NULL,
    reckbn character(1) NOT NULL,
    rennum numeric(4,0) DEFAULT 0 NOT NULL,
    creymd character(8),
    totalten numeric(10,0) DEFAULT 0,
    recedata character varying(250)
);

ALTER TABLE ONLY tbl_receden
    ADD CONSTRAINT tbl_receden_primary_key PRIMARY KEY (hospid, sryym, nyugaikbn, ptid, receka, teisyutusaki, recesyubetu, hknjanum, hojokbn_key, tekstymd, reckbn, rennum);

COMMENT ON TABLE tbl_receden IS 'レセプト電算';

