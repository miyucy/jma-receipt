CREATE TABLE tbl_teikiprt (
    btunum character(2) NOT NULL,
    denpnum numeric(7,0) NOT NULL,
    hospid character(24),
    ptid numeric(10,0),
    ptnum character(20),
    name character(100)
);

ALTER TABLE ONLY tbl_teikiprt
    ADD CONSTRAINT tbl_teikiprt_primary_key PRIMARY KEY (btunum, denpnum);

