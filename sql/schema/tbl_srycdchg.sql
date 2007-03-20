CREATE TABLE tbl_srycdchg (
    ipnsrycd character(9) NOT NULL,
    rjnsrycd character(9) NOT NULL,
    termid character varying(16),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6)
);

CREATE INDEX idx_srycdchg_rjnsrycd ON tbl_srycdchg USING btree (rjnsrycd);

ALTER TABLE ONLY tbl_srycdchg
    ADD CONSTRAINT tbl_srycdchg_primary_key PRIMARY KEY (ipnsrycd, rjnsrycd);

COMMENT ON TABLE tbl_srycdchg IS '一般老人置換';

