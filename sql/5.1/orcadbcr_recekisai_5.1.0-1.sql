\set ON_ERROR_STOP
--
-- レセプト記載事項
--
-- Create Date : 2018/ 5/10
--
CREATE TABLE master.tbl_recekisai (
    c_group character varying(9) NOT NULL,
    stym character varying(6) NOT NULL,
    edym character varying(6) NOT NULL,
    kisainum smallint DEFAULT 0 NOT NULL,
    rennum smallint DEFAULT 0 NOT NULL,
    c_cd character varying(9) NOT NULL,
    syorikbn smallint DEFAULT 0 NOT NULL,
    creymd character varying(8),
    upymd character varying(8),
    uphms character varying(6)
);

ALTER TABLE ONLY master.tbl_recekisai
    ADD CONSTRAINT tbl_recekisai_primary_key PRIMARY KEY (c_group, stym, edym, kisainum, rennum);

CREATE VIEW tbl_recekisai AS SELECT * FROM master.tbl_recekisai;
