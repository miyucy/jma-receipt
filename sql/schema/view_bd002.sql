CREATE VIEW "view_bd002" as SELECT a.hospid,
           a.nyugaikbn,
           a.ptid,
           a.denpnum,
           a.denplastnum,
           a.sryka,
           a.sryymd,
           a.denpjtikbn,
           a.createkbn,
           a.denpprtymd,
           a.skystymd,
           a.skyedymd,
           a.hkncombinum,
           a.syuhknnum,
           a.syuhknftnmoney,
           a.syucompftn,
           a.syucompftn_entani,
           a.syucompykzftn,
           a.syucomptotal,
           a.syuykzftnkbn,
           a.koh1hknnum,
           a.koh1hknftnmoney,
           a.koh1compftn,
           a.koh1compftn_entani,
           a.koh1compykzftn,
           a.koh1comptotal,
           a.koh1ykzftnkbn,
           a.koh2hknnum,
           a.koh2hknftnmoney,
           a.koh2compftn,
           a.koh2compftn_entani,
           a.koh2compykzftn,
           a.koh2comptotal,
           a.koh2ykzftnkbn,
           a.koh3hknnum,
           a.koh3hknftnmoney,
           a.koh3compftn,
           a.koh3compftn_entani,
           a.koh3compykzftn,
           a.koh3comptotal,
           a.koh3ykzftnkbn,
           a.koh4hknnum,
           a.koh4hknftnmoney,
           a.koh4compftn,
           a.koh4compftn_entani,
           a.koh4compykzftn,
           a.koh4comptotal,
           a.koh4ykzftnkbn,
           a.ptftnrate,
           a.roomnum,
           a.byotonum,
           a.skykukbn,
           a.tax_taishou,
           a.tax_money,
           a.skygk,
           a.ssu_hknten,
           a.ssu_money,
           a.ssu_tgmoney,
           a.ssu_tgmoney_tax,
           a.sdo_hknten,
           a.sdo_money,
           a.sdo_tgmoney,
           a.sdo_tgmoney_tax,
           a.ztk_hknten,
           a.ztk_money,
           a.ztk_tgmoney,
           a.ztk_tgmoney_tax,
           a.tyk_hknten,
           a.tyk_money,
           a.tyk_tgmoney,
           a.tyk_tgmoney_tax,
           a.csy_hknten,
           a.csy_money,
           a.csy_tgmoney,
           a.csy_tgmoney_tax,
           a.syc_hknten,
           a.syc_money,
           a.syc_tgmoney,
           a.syc_tgmoney_tax,
           a.sjt_hknten,
           a.sjt_money,
           a.sjt_tgmoney,
           a.sjt_tgmoney_tax,
           a.kns_hknten,
           a.kns_money,
           a.kns_tgmoney,
           a.kns_tgmoney_tax,
           a.gzu_hknten,
           a.gzu_money,
           a.gzu_tgmoney,
           a.gzu_tgmoney_tax,
           a.etc_hknten,
           a.etc_money,
           a.etc_tgmoney,
           a.etc_tgmoney_tax,
           a.nyn_hknten,
           a.nyn_money,
           a.nyn_tgmoney,
           a.nyn_tgmoney_tax,
           a.total_hknten,
           a.total_money,
           a.total_tgmoney,
           a.total_tgmoney_tax,
           a.tgmoney_tax_sai,
           a.jihi_1,
           a.jihi_1_tax,
           a.jihi_2,
           a.jihi_2_tax,
           a.jihi_3,
           a.jihi_3_tax,
           a.jihi_4,
           a.jihi_4_tax,
           a.jihi_5,
           a.jihi_5_tax,
           a.jihi_6,
           a.jihi_6_tax,
           a.jihi_7,
           a.jihi_7_tax,
           a.jihi_8,
           a.jihi_8_tax,
           a.jihi_9,
           a.jihi_9_tax,
           a.jihi_10,
           a.jihi_10_tax,
           a.jihi_total,
           a.jihi_total_tax,
           a.jihi_tax,
           a.rjn_ftn,
           a.koh_ftn,
           a.koh_ftn_entani,
           a.ykz_ftn,
           a.rese_ykz_ftn,
           a.kohtaiykzkbn,
           a.chosei,
           a.grp_denpnum,
           a.grp_rennum,
           a.grp_sgkmoney,
           a.secmoney,
           a.hkntekmoney,
           a.discount_kbn,
           a.discount_body,
           a.discount_ratekbn,
           a.discount_teiritu,
           a.discount_rate,
           a.discount_money,
           a.rsishoshin_money,
           a.rsisaishin_money,
           a.rsisdo_money,
           a.rsietc_money,
           a.rsi_tax_sai,
           a.rsi_total,
           a.rsijibai_skymoney,
           a.skymoney_tax_sai,
           a.skymoney,
           a.nyukin_total,
           a.nyukin_kaisu,
           a.misyuriyu,
           a.drcd,
           a.nynshokaisu,
           a.ykzkennum,
           a.rmsagaku,
           a.rmsagaku_tax_sai,
           a.shokuji1_nissu,
           a.shokuji1,
           a.shokuji2_nissu,
           a.shokuji2,
           a.shokuji3_nissu,
           a.shokuji3,
           a.shokuji4_nissu,
           a.shokuji4,
           a.shokuji5_nissu,
           a.shokuji5,
           a.shokuji6_nissu,
           a.shokuji6,
           a.shokuji7_nissu,
           a.shokuji7,
           a.syuskj_nissu,
           a.syuskj_ryoyohi,
           a.syuskj_ftn,
           a.syuskj_ftn_rece,
           a.syuskj_ftnkbn,
           a.koh1skj_nissu,
           a.koh1skj_ryoyohi,
           a.koh1skj_ftn,
           a.koh1skj_ftn_rece,
           a.koh1skj_ftnkbn,
           a.koh2skj_nissu,
           a.koh2skj_ryoyohi,
           a.koh2skj_ftn,
           a.koh2skj_ftn_rece,
           a.koh2skj_ftnkbn,
           a.koh3skj_nissu,
           a.koh3skj_ryoyohi,
           a.koh3skj_ftn,
           a.koh3skj_ftn_rece,
           a.koh3skj_ftnkbn,
           a.koh4skj_nissu,
           a.koh4skj_ryoyohi,
           a.koh4skj_ftn,
           a.koh4skj_ftn_rece,
           a.koh4skj_ftnkbn,
           a.ryoyohi_skj,
           a.skymoney_skj,
           a.skymoney_skj_tax,
           a.skymoney_skj_kei,
           a.ryoyohi_skj_jihi,
           a.skymoney_skj_jihi,
           a.skymoney_skj_jihi_tax,
           a.skymoney_skj_jihi_kei,
           a.skj_ftngaku1,
           a.skj_ftnday1,
           a.skj_ftngaku2,
           a.skj_ftnday2,
           a.skj_ftngaku3,
           a.skj_ftnday3,
           a.saikeisankbn,
           a.ingaishohokbn,
           a.douji_denpnum,
           a.contkbn,
           a.day_1,
           a.day_2,
           a.day_3,
           a.day_4,
           a.day_5,
           a.day_6,
           a.day_7,
           a.day_8,
           a.day_9,
           a.day_10,
           a.day_11,
           a.day_12,
           a.day_13,
           a.day_14,
           a.day_15,
           a.day_16,
           a.day_17,
           a.day_18,
           a.day_19,
           a.day_20,
           a.day_21,
           a.day_22,
           a.day_23,
           a.day_24,
           a.day_25,
           a.day_26,
           a.day_27,
           a.day_28,
           a.day_29,
           a.day_30,
           a.day_31,
           a.fuku_denpnum,
           a.fuku_kbn,
           a.zaitaku,
           a.kyufugai_shoshin_ten,
           a.kyufugai_sidou_ten,
           a.kyufugai_osin1_ten,
           a.kyufugai_osin2_ten,
           a.kyufugai_osin3_ten,
           a.kyufugai_gokei_ten,
           a.dayinfflg,
           a.nyuin_rrknum,
           a.acct_updkbn,
           a.jyo_hknftnmoney,
           a.jyo_compftn,
           a.jyo_compftn_entani,
           a.termid,
           a.opid,
           a.creymd,
           a.upymd,
           a.uphms,
           b.ptnum 
      FROM tbl_syunou a,
           tbl_ptnum b,
           tbl_ptinf c 
     WHERE (((((((b.hospid = a.hospid) 
       AND (b.ptid = a.ptid)) 
       AND (b.hospid = c.hospid)) 
       AND (b.ptid = c.ptid)) 
       AND (a.denpjtikbn <> '3'::bpchar)) 
       AND (a.createkbn <> '3'::bpchar)) 
       AND (c.tstptnumkbn <> '1'::bpchar));

COMMENT ON VIEW "view_bd002" IS '��Ǽ�ӥ塼2';

