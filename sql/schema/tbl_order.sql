CREATE TABLE tbl_order (
    hospid character(24) NOT NULL,
    karte_key character varying(36) NOT NULL,
    nyugaikbn character(1) NOT NULL,
    ptnum character(20) NOT NULL,
    ptid numeric(10,0) NOT NULL,
    sryka character(2) NOT NULL,
    sryymd character(8) NOT NULL,
    hkncombi numeric(4,0) NOT NULL,
    drcd character(5) NOT NULL,
    orderid character(4) NOT NULL,
    ordernum numeric(2,0) NOT NULL,
    itemnum numeric(2,0) NOT NULL,
    ukeymd character(8) NOT NULL,
    ukehms character(6) NOT NULL,
    errcd1 character(4),
    errcd2 character(4),
    itemid character(5),
    item character varying(10),
    remarks character varying(80),
    errcd_order character(4),
    errcd_item character(4),
    status_order character(1),
    status_item character(1),
    modify character(1),
    keygenerate character(1),
    rrknum numeric(3,0),
    rrkedanum numeric(3,0),
    termid character varying(16),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6)
);

CREATE INDEX idx_order_ukeymd ON tbl_order USING btree (ukeymd);

CREATE INDEX idx_order_sryymd ON tbl_order USING btree (sryymd);

CREATE INDEX idx_order_ptnum ON tbl_order USING btree (ptnum);

ALTER TABLE ONLY tbl_order
    ADD CONSTRAINT tbl_order_primary_key PRIMARY KEY (hospid, karte_key, nyugaikbn, ptnum, ptid, sryka, sryymd, hkncombi, drcd, orderid, ordernum, itemnum, ukeymd, ukehms);

COMMENT ON TABLE tbl_order IS '入院オーダ';

