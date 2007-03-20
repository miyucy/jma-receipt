CREATE TABLE tbl_srykarrk (
    hospid character(24) NOT NULL,
    ptid numeric(10,0) NOT NULL,
    sryka character(2) NOT NULL,
    syosinymd1 character(8),
    syosinymd2 character(8),
    lastymd character(8),
    termid character varying(16),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6)
);

ALTER TABLE ONLY tbl_srykarrk
    ADD CONSTRAINT tbl_srykarrk_primary_key PRIMARY KEY (hospid, ptid, sryka);

COMMENT ON TABLE tbl_srykarrk IS '���Ų�����';

