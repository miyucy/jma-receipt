CREATE TABLE tbl_toukeimemo (
    pgid character varying(20) NOT NULL,
    kanricd character(4) NOT NULL,
    kbncd character(8) NOT NULL,
    styukymd character(8) NOT NULL,
    edyukymd character(8) NOT NULL,
    para1 character varying(20),
    para2 character varying(20),
    para3 character varying(20),
    para4 character varying(20),
    para5 character varying(20),
    para6 character varying(20),
    para7 character varying(20),
    para8 character varying(20),
    memo character varying(6000),
    termid character varying(32),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6)
);

ALTER TABLE ONLY tbl_toukeimemo
    ADD CONSTRAINT tbl_toukeimemo_primary_key PRIMARY KEY (pgid, kanricd, kbncd, styukymd, edyukymd);

COMMENT ON TABLE tbl_toukeimemo IS '���׳н�';

