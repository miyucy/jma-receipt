CREATE TABLE tbl_toukeimemo (
    pgid character varying(20) NOT NULL,
    kanricd character(4) NOT NULL,
    kbncd character(8) NOT NULL,
    styukymd character(8) NOT NULL,
    edyukymd character(8) NOT NULL,
    memo character varying(6000),
    termid character varying(32),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6)
);

ALTER TABLE ONLY tbl_toukeimemo
    ADD CONSTRAINT tbl_toukeimemo_primary_key PRIMARY KEY (pgid, kanricd, kbncd, styukymd, edyukymd);

COMMENT ON TABLE tbl_toukeimemo IS 'Åý·×³Ð½ñ';

