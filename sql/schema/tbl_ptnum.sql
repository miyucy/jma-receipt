CREATE TABLE tbl_ptnum (
    hospid character(24) NOT NULL,
    ptid numeric(10,0) NOT NULL,
    ptnum character(20) NOT NULL,
    hknid numeric(10,0) DEFAULT 0,
    kohid numeric(10,0) DEFAULT 0,
    autocombinum numeric(4,0) DEFAULT 0,
    manucombinum numeric(4,0) DEFAULT 0,
    tstptnumkbn character(1),
    termid character varying(16),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6)
);

CREATE INDEX idx_ptnum_ptnum ON tbl_ptnum USING btree (ptnum);

ALTER TABLE ONLY tbl_ptnum
    ADD CONSTRAINT tbl_ptnum_primary_key PRIMARY KEY (hospid, ptid);

COMMENT ON TABLE tbl_ptnum IS '患者番号変換';

