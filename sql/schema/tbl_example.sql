CREATE TABLE tbl_example (
    hospid character(24) NOT NULL,
    kubun character(1) NOT NULL,
    rennum numeric(3,0) DEFAULT 0 NOT NULL,
    "comment" character varying(800),
    termid character varying(16),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6)
);

ALTER TABLE ONLY tbl_example
    ADD CONSTRAINT tbl_example_primary_key PRIMARY KEY (hospid, kubun, rennum);

