CREATE TABLE tbl_tensuplus (
    srycd character(9) NOT NULL,
    yukostymd character(8) NOT NULL,
    yukoedymd character(8) NOT NULL,
    shoyukoketa numeric(2,0),
    shoname character(200),
    saiketukbn numeric(1,0),
    inpchkkbn numeric(1,0),
    tenpuyakkbn character(2),
    termid character varying(16),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6)
);

ALTER TABLE ONLY tbl_tensuplus
    ADD CONSTRAINT tbl_tensuplus_primary_key PRIMARY KEY (srycd, yukostymd, yukoedymd);

