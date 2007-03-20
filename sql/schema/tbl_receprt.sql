CREATE TABLE tbl_receprt (
    prtid character(4) NOT NULL,
    receym character(6) NOT NULL,
    creymd character(8) NOT NULL,
    crehms character(6) NOT NULL,
    teisyutusaki character(1) NOT NULL,
    sryka character(2) DEFAULT '00'::bpchar NOT NULL,
    prefkbn_srt character(2) DEFAULT '99'::bpchar NOT NULL,
    hknjanum_srt character(1) DEFAULT '9'::bpchar NOT NULL,
    hknjanum character(8) NOT NULL,
    tekstymd character(8) NOT NULL,
    recesyubetu_srt character(3) DEFAULT '999'::bpchar NOT NULL,
    recesyubetu character(4) NOT NULL,
    prefkbn character(1) NOT NULL,
    prefnum character(2) NOT NULL,
    ptnum character(20) NOT NULL,
    sryym character(6) DEFAULT '000000'::bpchar,
    rennum numeric(3,0) DEFAULT 0 NOT NULL,
    recenum numeric(6,0) DEFAULT 0 NOT NULL,
    hknkbn character(1),
    kananame character varying(100),
    prtjyun numeric(2,0),
    prtrennum numeric(6,0),
    nyugaikbn character(1),
    zaitaku character(1) DEFAULT '9'::bpchar NOT NULL,
    chouki character(1) DEFAULT '9'::bpchar NOT NULL,
    hknjanum_s character(8) DEFAULT '99999999'::bpchar NOT NULL,
    formid character(20),
    prtdata character varying(10000),
    prtnm character(16) DEFAULT ' '::bpchar,
    termid character varying(64),
    opid character varying(16),
    prtjyun_syuka numeric(4,0) DEFAULT 0,
    kougaku character(1) DEFAULT '9'::bpchar,
    syubetu_srt1 integer DEFAULT 0,
    grp_no1 numeric(3,0) DEFAULT 0,
    honkzkkbn character(1),
    kouhi_no numeric(3,0) DEFAULT 0,
    syubetu_under_1 character varying(80),
    grp_no2 character(3),
    syubetu_under_2 character varying(40),
    syubetu_srt2 integer DEFAULT 0
);

ALTER TABLE ONLY tbl_receprt
    ADD CONSTRAINT tbl_receprt_primary_key PRIMARY KEY (prtid, receym, creymd, crehms, teisyutusaki, sryka, prefkbn_srt, hknjanum_srt, hknjanum, recesyubetu, tekstymd, zaitaku, chouki, ptnum, rennum, recenum);

COMMENT ON TABLE tbl_receprt IS 'レセプト明細書';

