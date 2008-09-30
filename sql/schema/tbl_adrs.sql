CREATE TABLE tbl_adrs (
    lpubcd character(5) NOT NULL,
    post character(7) NOT NULL,
    rennum numeric(2,0) NOT NULL,
    prefkana character varying(40),
    citykana character varying(200),
    townkana character varying(200),
    prefname character varying(20),
    cityname character varying(100),
    townname character varying(100),
    editadrs_kana character varying(440),
    editadrs_name character varying(220),
    towndivflg character(1) DEFAULT '0'::bpchar,
    manytownflg character(1) DEFAULT '0'::bpchar,
    hospnum numeric(2,0) NOT NULL
);

COMMENT ON TABLE tbl_adrs IS '����';

ALTER TABLE ONLY tbl_adrs
    ADD CONSTRAINT tbl_adrs_primary_key PRIMARY KEY (hospnum, lpubcd, post, rennum);

CREATE INDEX idx_adrs_post ON tbl_adrs USING btree (hospnum, post);

