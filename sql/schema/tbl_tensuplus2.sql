CREATE TABLE tbl_tensuplus2 (
    srycd character(9) NOT NULL,
    chokinissu numeric(3,0),
    chokikigen character(8),
    chokierr numeric(1,0),
    touyokgnage1 character(2),
    touyojgnage1 character(2),
    touyoryo11 numeric(10,5),
    touyoryo21 numeric(10,5),
    touyokgnage2 character(2),
    touyojgnage2 character(2),
    touyoryo12 numeric(10,5),
    touyoryo22 numeric(10,5),
    touyokgnage3 character(2),
    touyojgnage3 character(2),
    touyoryo13 numeric(10,5),
    touyoryo23 numeric(10,5),
    touyokgnage4 character(2),
    touyojgnage4 character(2),
    touyoryo14 numeric(10,5),
    touyoryo24 numeric(10,5),
    touyokgnage5 character(2),
    touyojgnage5 character(2),
    touyoryo15 numeric(10,5),
    touyoryo25 numeric(10,5),
    touyokgnage6 character(2),
    touyojgnage6 character(2),
    touyoryo16 numeric(10,5),
    touyoryo26 numeric(10,5),
    touyokgnage7 character(2),
    touyojgnage7 character(2),
    touyoryo17 numeric(10,5),
    touyoryo27 numeric(10,5),
    touyokgnage8 character(2),
    touyojgnage8 character(2),
    touyoryo18 numeric(10,5),
    touyoryo28 numeric(10,5),
    touyokgnage9 character(2),
    touyojgnage9 character(2),
    touyoryo19 numeric(10,5),
    touyoryo29 numeric(10,5),
    touyokgnage10 character(2),
    touyojgnage10 character(2),
    touyoryo110 numeric(10,5),
    touyoryo210 numeric(10,5),
    touyoerr numeric(1,0),
    naifukukbn numeric(1,0),
    termid character varying(16),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6),
    hospnum numeric(2,0) NOT NULL
);

COMMENT ON TABLE tbl_tensuplus2 IS '�����ղ�2';

ALTER TABLE ONLY tbl_tensuplus2
    ADD CONSTRAINT tbl_tensuplus2_primary_key PRIMARY KEY (hospnum, srycd);

