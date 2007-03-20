CREATE TABLE tbl_rece_puth (
    hospid character(24) NOT NULL,
    prefkbn_prtjyun character(1),
    hknjanum_prtjyun character(1),
    hknjanum character(8),
    hknjanum_prtkbn character(1),
    srt_01_1 character(2),
    kkhkbn_1 character(2),
    chouki_1 character(1),
    zaitaku_1 character(1),
    kougaku_ten_1 numeric(7,0),
    srt_last_1 character(1),
    srt_01_2 character(2),
    kkhkbn_2 character(2),
    chouki_2 character(1),
    zaitaku_2 character(1),
    kougaku_ten_2 numeric(7,0),
    srt_last_2 character(1),
    styukymd character(8) NOT NULL,
    edyukymd character(8) NOT NULL,
    termid character varying(64),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6)
);

ALTER TABLE ONLY tbl_rece_puth
    ADD CONSTRAINT tbl_rece_puth_pkey PRIMARY KEY (hospid, styukymd, edyukymd);

COMMENT ON TABLE tbl_rece_puth IS '¥ì¥»¥×¥ÈÊÔÄÖ½ç¥Ø¥Ã¥À';

