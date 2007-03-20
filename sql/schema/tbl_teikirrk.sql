CREATE TABLE tbl_teikirrk (
    sryym character(6) NOT NULL,
    kbt character(1) NOT NULL,
    termid character varying(16),
    opid character varying(16),
    creymd character varying(8),
    upymd character varying(8),
    uphms character varying(6)
);

ALTER TABLE ONLY tbl_teikirrk
    ADD CONSTRAINT tbl_teikirrk_primary_key PRIMARY KEY (sryym, kbt);

COMMENT ON TABLE tbl_teikirrk IS '�����������';

