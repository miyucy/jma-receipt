CREATE TABLE tbl_tensuplus (
    srycd character(9) NOT NULL,
    yukostymd character(8) NOT NULL,
    yukoedymd character(8) NOT NULL,
    shoyukoketa numeric(2,0),
    shoname character varying(200),
    saiketukbn numeric(1,0),
    inpchkkbn numeric(1,0),
    tenpuyakkbn character(2),
    allsuryokbn character(1),
    kanzantanicd character(3),
    kanzantaniname character varying(24),
    kanzanchi numeric(10,5),
    termid character varying(16),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6),
    santeirrkkbn numeric(1,0) DEFAULT 0,
    jgncnt numeric(3,0) DEFAULT 0,
    jgncnt1d numeric(3,0) DEFAULT 0,
    jgncnterr numeric(1,0) DEFAULT 0,
    souryohenkbn numeric(1,0) DEFAULT 0,
    ipnkisaikbn numeric(1,0) DEFAULT 0,
    ipnkanzantanicd character(3),
    ipnkanzantaniname character varying(24),
    ipnkanzanchi numeric(10,5) DEFAULT 0,
    hospnum numeric(2,0) NOT NULL,
    jgncntetcm numeric(2,0) DEFAULT 0,
    jgncntetc numeric(3,0) DEFAULT 0
);

ALTER TABLE ONLY tbl_tensuplus
    ADD CONSTRAINT tbl_tensuplus_primary_key PRIMARY KEY (hospnum, srycd, yukostymd, yukoedymd);

COMMENT ON TABLE tbl_tensuplus IS '点数付加';

