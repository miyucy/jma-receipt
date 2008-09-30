CREATE TABLE tbl_hkncombi (
    ptid numeric(10,0) NOT NULL,
    hkncombinum numeric(4,0) NOT NULL,
    hknid numeric(10,0),
    hknnum character(3),
    honkzkkbn character(1),
    hojokbn character(1),
    contkbn character(1),
    koh1id numeric(10,0),
    koh1hknnum character(3),
    koh1paykbn character(2),
    koh2id numeric(10,0),
    koh2hknnum character(3),
    koh2paykbn character(2),
    koh3id numeric(10,0),
    koh3hknnum character(3),
    koh3paykbn character(2),
    koh4id numeric(10,0),
    koh4hknnum character(3),
    koh4paykbn character(2),
    tekstymd character(8),
    tekedymd character(8),
    syu_tanseidoname character varying(40),
    syu_hknkohsbtkbn character(1),
    syu_gaijgnkbn character(1),
    syu_nyujgnkbn character(1),
    koh1_tanseidoname character varying(20),
    koh1_hknkohsbtkbn character(1),
    koh1_gaijgnkbn character(1),
    koh1_nyujgnkbn character(1),
    koh2_tanseidoname character varying(20),
    koh2_hknkohsbtkbn character(1),
    koh2_gaijgnkbn character(1),
    koh2_nyujgnkbn character(1),
    koh3_tanseidoname character varying(20),
    koh3_hknkohsbtkbn character(1),
    koh3_gaijgnkbn character(1),
    koh3_nyujgnkbn character(1),
    koh4_tanseidoname character varying(20),
    koh4_hknkohsbtkbn character(1),
    koh4_gaijgnkbn character(1),
    koh4_nyujgnkbn character(1),
    gai_ftnkbn character(1),
    gai_kftnrate numeric(3,0) DEFAULT 0,
    gai_kkotgak numeric(6,0) DEFAULT 0,
    gai_kjgngak numeric(6,0) DEFAULT 0,
    gai_djgngak numeric(6,0) DEFAULT 0,
    gai_djgncnt numeric(2,0) DEFAULT 0,
    gai_mnaijgngak numeric(6,0) DEFAULT 0,
    gai_mgaijgngak numeric(6,0) DEFAULT 0,
    gai_mjgncnt numeric(2,0) DEFAULT 0,
    gai_ykzftnkbn character(1),
    nyu_ftnkbn character(1),
    nyu_kftnrate numeric(3,0) DEFAULT 0,
    nyu_kkotgak numeric(6,0) DEFAULT 0,
    nyu_kjgngak numeric(6,0) DEFAULT 0,
    nyu_djgngak numeric(6,0) DEFAULT 0,
    nyu_djgncnt numeric(2,0) DEFAULT 0,
    nyu_mjgngak numeric(6,0) DEFAULT 0,
    nyu_mjgncnt numeric(2,0) DEFAULT 0,
    nyu_skjryokbn character(1),
    tsy_gaiftnkbn character(1),
    tsy_gaikftnrate numeric(3,0) DEFAULT 0,
    tsy_gaikkotgak numeric(6,0) DEFAULT 0,
    tsy_gaikjgngak numeric(6,0) DEFAULT 0,
    tsy_gaidjgngak numeric(6,0) DEFAULT 0,
    tsy_gaidjgncnt numeric(2,0) DEFAULT 0,
    tsy_gaimnaijgngak numeric(6,0) DEFAULT 0,
    tsy_gaimgaijgngak numeric(6,0) DEFAULT 0,
    tsy_gaimjgncnt numeric(2,0) DEFAULT 0,
    tsy_gaiykzftnkbn character(1),
    tsy_nyuftnkbn character(1),
    tsy_nyukftnrate numeric(3,0) DEFAULT 0,
    tsy_nyukkotgak numeric(6,0) DEFAULT 0,
    tsy_nyukjgngak numeric(6,0) DEFAULT 0,
    tsy_nyudjgngak numeric(6,0) DEFAULT 0,
    tsy_nyudjgncnt numeric(2,0) DEFAULT 0,
    tsy_nyumjgngak numeric(6,0) DEFAULT 0,
    tsy_nyumjgncnt numeric(2,0) DEFAULT 0,
    tsy_nyuskjryokbn character(1),
    tnk_gaiftnkbn character(1),
    tnk_gaikftnrate numeric(3,0) DEFAULT 0,
    tnk_gaikkotgak numeric(6,0) DEFAULT 0,
    tnk_gaikjgngak numeric(6,0) DEFAULT 0,
    tnk_gaidjgngak numeric(6,0) DEFAULT 0,
    tnk_gaidjgncnt numeric(2,0) DEFAULT 0,
    tnk_gaimnaijgngak numeric(6,0) DEFAULT 0,
    tnk_gaimgaijgngak numeric(6,0) DEFAULT 0,
    tnk_gaimjgncnt numeric(2,0) DEFAULT 0,
    tnk_gaiykzftnkbn character(1),
    tnk_nyuftnkbn character(1),
    tnk_nyukftnrate numeric(3,0) DEFAULT 0,
    tnk_nyukkotgak numeric(6,0) DEFAULT 0,
    tnk_nyukjgngak numeric(6,0) DEFAULT 0,
    tnk_nyudjgngak numeric(6,0) DEFAULT 0,
    tnk_nyudjgncnt numeric(2,0) DEFAULT 0,
    tnk_nyumjgngak numeric(6,0) DEFAULT 0,
    tnk_nyumjgncnt numeric(2,0) DEFAULT 0,
    tnk_nyuskjryokbn character(1),
    tentnk numeric(4,0) DEFAULT 0,
    taxkbn character(1),
    chgkbn character(1),
    delkbn character(1),
    termid character varying(16),
    opid character varying(16),
    creymd character(8),
    upymd character(8),
    uphms character(6),
    hospnum numeric(2,0) NOT NULL,
    hyojikbn character(1)
);

COMMENT ON TABLE tbl_hkncombi IS '�ݸ��ȹ礻';

ALTER TABLE ONLY tbl_hkncombi
    ADD CONSTRAINT tbl_hkncombi_primary_key PRIMARY KEY (hospnum, ptid, hkncombinum);

