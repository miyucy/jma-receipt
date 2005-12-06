CREATE TABLE tbl_yakujyo (
    hospid character(24) NOT NULL,
    srycd character(9) NOT NULL,
    teknum numeric(2,0) DEFAULT 0 NOT NULL,
    name character varying(170),
    effect character varying(400),
    caution character varying(850),
    photo character varying(256),
    color character varying(360),
    shape character varying(360),
    mark character varying(360),
    termid character varying(32),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6)
);

ALTER TABLE ONLY tbl_yakujyo
    ADD CONSTRAINT tbl_yakujyo_primary_key PRIMARY KEY (hospid, srycd, teknum);

