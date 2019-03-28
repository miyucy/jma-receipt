      *******************************************************************
      * Project code name "ORCA"
      * 日医標準レセプトソフト（JMA standard receipt software）
      * Copyright(C) 2002 JMA (Japan Medical Association)
      *
      * This program is part of "JMA standard receipt software".
      *
      *     This program is distributed in the hope that it will be useful
      * for further advancement in medical care, according to JMA Open
      * Source License, but WITHOUT ANY WARRANTY.
      *     Everyone is granted permission to use, copy, modify and
      * redistribute this program, but only under the conditions described
      * in the JMA Open Source License. You should have received a copy of
      * this license along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
      ************************************************************
      *    入院CLAIM項目ID  COPY (CPNORDERID.INC)                *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付     内容
      ************************************************************
       01  NORDERID-AREA.
           03  NORDERID-ORDER-NYUIN        PIC X(02) VALUE "01".
           03  NORDERID-ORDER-KYUSYOKU     PIC X(02) VALUE "02".
           03  NORDERID-ORDER-DELNYUIN     PIC X(02) VALUE "11".
           03  NORDERID-ORDER-ALLDELNYUIN  PIC X(02) VALUE "12".
      *
           03  NORDERID-VAL.
      *
               05  NORDERID-NYUIN-G.
                   07  NORDERID-NYUINCL1   PIC X(02) VALUE "01".
                   07  NORDERID-NYUINCL2   PIC X(03) VALUE "001".
                   07  NORDERID-NYUINID    PIC X(04) VALUE "0101".
                   07  NORDERID-NYUINMES1  PIC X(30) VALUE "入院".
                   07  NORDERID-NYUINMES2  PIC X(20) VALUE "入院".
      *
               05  NORDERID-TAIIN-G.
                   07  NORDERID-TAIINCL1   PIC X(02) VALUE "01".
                   07  NORDERID-TAIINCL2   PIC X(03) VALUE "002".
                   07  NORDERID-TAIINID    PIC X(04) VALUE "0102".
                   07  NORDERID-TAIINMES1  PIC X(30) VALUE "退院".
                   07  NORDERID-TAIINMES2  PIC X(20) VALUE "退院".
      *
               05  NORDERID-IDOBTU-G.
                   07  NORDERID-IDOBTUCL1  PIC X(02) VALUE "01".
                   07  NORDERID-IDOBTUCL2  PIC X(03) VALUE "003".
                   07  NORDERID-IDOBTUID   PIC X(04) VALUE "0103".
                   07  NORDERID-IDOBTUMES1 PIC X(30) VALUE "転棟".
                   07  NORDERID-IDOBTUMES2 PIC X(20) VALUE "転棟".
      *
               05  NORDERID-IDOKA-G.
                   07  NORDERID-IDOKACL1   PIC X(02) VALUE "01".
                   07  NORDERID-IDOKACL2   PIC X(03) VALUE "004".
                   07  NORDERID-IDOKAID    PIC X(04) VALUE "0104".
                   07  NORDERID-IDOKAMES1  PIC X(30) VALUE "転科".
                   07  NORDERID-IDOKAMES2  PIC X(20) VALUE "転科".
      *
               05  NORDERID-IDOBRM-G.
                   07  NORDERID-IDOBRMCL1  PIC X(02) VALUE "01".
                   07  NORDERID-IDOBRMCL2  PIC X(03) VALUE "005".
                   07  NORDERID-IDOBRMID   PIC X(04) VALUE "0105".
                   07  NORDERID-IDOBRMMES1 PIC X(30) VALUE "転室".
                   07  NORDERID-IDOBRMMES2 PIC X(20) VALUE "転室".
      *
               05  NORDERID-IDODR-G.
                   07  NORDERID-IDODRCL1   PIC X(02) VALUE "01".
                   07  NORDERID-IDODRCL2   PIC X(03) VALUE "008".
                   07  NORDERID-IDODRID    PIC X(04) VALUE "0106".
                   07  NORDERID-IDODRMES1  PIC X(30) VALUE "担当医".
                   07  NORDERID-IDODRMES2  PIC X(20) VALUE "担当医".
      *
               05  NORDERID-DELNYUIN-G.
                   07  NORDERID-DELNYUINCL1    PIC X(02) VALUE "11".
                   07  NORDERID-DELNYUINCL2    PIC X(03) VALUE "001".
                   07  NORDERID-DELNYUINID     PIC X(04) VALUE "0107".
                   07  NORDERID-DELNYUINMES1   PIC X(30)
                                           VALUE "入院取消".
                   07  NORDERID-DELNYUINMES2   PIC X(20)
                                           VALUE "入院取消".
      *
               05  NORDERID-ALLDELNYUIN-G.
                   07  NORDERID-ALLDELNYUINCL1  PIC X(02) VALUE "12".
                   07  NORDERID-ALLDELNYUINCL2  PIC X(03) VALUE "001".
                   07  NORDERID-ALLDELNYUINID   PIC X(04) VALUE "0108".
                   07  NORDERID-ALLDELNYUINMES1 PIC X(30)
                                           VALUE "入院取消（会計含む）".
                   07  NORDERID-ALLDELNYUINMES2 PIC X(20)
                                           VALUE "入院取消（会計含む）".
      *
               05  NORDERID-NYUIN2-G.
                   07  NORDERID-NYUIN2CL1       PIC X(02) VALUE "XX".
                   07  NORDERID-NYUIN2CL2       PIC X(03) VALUE "XXX".
                   07  NORDERID-NYUIN2ID        PIC X(04) VALUE "0109".
                   07  NORDERID-NYUIN2MES1      PIC X(30) VALUE "入院".
                   07  NORDERID-NYUIN2MES2      PIC X(20) VALUE "入院".
      *
               05  NORDERID-TAIIN2-G.
                   07  NORDERID-TAIIN2CL1   PIC X(02) VALUE "XX".
                   07  NORDERID-TAIIN2CL2   PIC X(03) VALUE "XXX".
                   07  NORDERID-TAIIN2ID    PIC X(04) VALUE "0110".
                   07  NORDERID-TAIIN2MES1  PIC X(30) VALUE "退院".
                   07  NORDERID-TAIIN2MES2  PIC X(20) VALUE "退院".
      *
               05  NORDERID-HENKO-G.
                   07  NORDERID-HENKOCL1   PIC X(02) VALUE "XX".
                   07  NORDERID-HENKOCL2   PIC X(03) VALUE "XXX".
                   07  NORDERID-HENKOID    PIC X(04) VALUE "0111".
                   07  NORDERID-HENKOMES1  PIC X(30) VALUE "変更".
                   07  NORDERID-HENKOMES2  PIC X(20) VALUE "変更".
      *
               05  NORDERID-IDOALL-G.
                   07  NORDERID-IDOALLCL1   PIC X(02) VALUE "XX".
                   07  NORDERID-IDOALLCL2   PIC X(03) VALUE "XXX".
                   07  NORDERID-IDOALLID    PIC X(04) VALUE "0112".
                  07 NORDERID-IDOALLMES1 PIC X(30) VALUE "転科転棟転室".
                  07 NORDERID-IDOALLMES2 PIC X(20) VALUE "転科転棟転室".
      *
               05  NORDERID-CANNYUIN-G.
                   07  NORDERID-CANNYUINCL1    PIC X(02) VALUE "XX".
                   07  NORDERID-CANNYUINCL2    PIC X(03) VALUE "XXX".
                   07  NORDERID-CANNYUINID     PIC X(04) VALUE "0113".
                   07  NORDERID-CANNYUINMES1   PIC X(30)
                                           VALUE "入院取消".
                   07  NORDERID-CANNYUINMES2   PIC X(20)
                                           VALUE "入院取消".
      *
               05  NORDERID-ALLCANNYUIN-G.
                   07  NORDERID-ALLCANNYUINCL1  PIC X(02) VALUE "XX".
                   07  NORDERID-ALLCANNYUINCL2  PIC X(03) VALUE "XXX".
                   07  NORDERID-ALLCANNYUINID   PIC X(04) VALUE "0120".
                   07  NORDERID-ALLCANNYUINMES1 PIC X(30)
                                           VALUE "入院取消（会計含む）".
                   07  NORDERID-ALLCANNYUINMES2 PIC X(20)
                                           VALUE "入院・会計取消".
      *
               05  NORDERID-CANTAIIN-G.
                   07  NORDERID-CANTAIINCL1  PIC X(02) VALUE "XX".
                   07  NORDERID-CANTAIINL2   PIC X(03) VALUE "XXX".
                   07  NORDERID-CANTAIINID   PIC X(04) VALUE "0115".
                   07  NORDERID-CANTAIINMES1 PIC X(30) VALUE "退院取消".
                   07  NORDERID-CANTAIINMES2 PIC X(20) VALUE "退院取消".
      *
               05  NORDERID-CANIDO-G.
                   07  NORDERID-CANIDOCL1    PIC X(02) VALUE "XX".
                   07  NORDERID-CANIDOL2     PIC X(03) VALUE "XXX".
                   07  NORDERID-CANIDOID     PIC X(04) VALUE "0116".
                   07  NORDERID-CANIDOMES1   PIC X(30) VALUE "異動取消".
                   07  NORDERID-CANIDOMES2   PIC X(20) VALUE "異動取消".
      *
               05  NORDERID-TEISEI-G.
                   07  NORDERID-TEISEICL1    PIC X(02) VALUE "XX".
                   07  NORDERID-TEISEICL2    PIC X(03) VALUE "XXX".
                   07  NORDERID-TEISEIID     PIC X(04) VALUE "0117".
                   07  NORDERID-TEISEIMES1   PIC X(30)
                                           VALUE "入院（訂正）".
                   07  NORDERID-TEISEIMES2   PIC X(20)
                                           VALUE "入院（訂正）".
      *
               05  NORDERID-GCANCEL-G.
                   07  NORDERID-GCANCELCL1   PIC X(02) VALUE "XX".
                   07  NORDERID-GCANCELCL2   PIC X(03) VALUE "XXX".
                   07  NORDERID-GCANCELID    PIC X(04) VALUE "0200".
                   07  NORDERID-GCANCELMES1  PIC X(30) VALUE "外泊取消".
                   07  NORDERID-GCANCELMES2  PIC X(20) VALUE "外泊取消".
      *
               05  NORDERID-GAIHK-G.
                   07  NORDERID-GAIHKCL1   PIC X(02) VALUE "01".
                   07  NORDERID-GAIHKCL2   PIC X(03) VALUE "006".
                   07  NORDERID-GAIHKID    PIC X(04) VALUE "0201".
                   07  NORDERID-GAIHKMES1  PIC X(30) VALUE "外泊".
                   07  NORDERID-GAIHKMES2  PIC X(20) VALUE "外泊".
      *
               05  NORDERID-GCURE-G.
                   07  NORDERID-GCURECL1   PIC X(02) VALUE "XX".
                   07  NORDERID-GCURECL2   PIC X(03) VALUE "XXX".
                   07  NORDERID-GCUREID    PIC X(04) VALUE "0202".
                   07  NORDERID-GCUREMES1  PIC X(30) 
                                           VALUE "治療の為の外泊".
                   07  NORDERID-GCUREMES2  PIC X(20)
                                           VALUE "治療の為の外泊".
      *
               05  NORDERID-GSENT-G.
                   07  NORDERID-GSENTCL1   PIC X(02) VALUE "XX".
                   07  NORDERID-GSENTCL2   PIC X(03) VALUE "XXX".
                   07  NORDERID-GSENTID    PIC X(04) VALUE "0203".
                   07  NORDERID-GSENTMES1  PIC X(30) 
                                           VALUE "選定入院中の外泊".
                   07  NORDERID-GSENTMES2  PIC X(20)
                                           VALUE "選定入院中の外泊".
      *
               05  NORDERID-GBACK-G.
                   07  NORDERID-GBACKCL1   PIC X(02) VALUE "01".
                   07  NORDERID-GBACKCL2   PIC X(03) VALUE "007".
                   07  NORDERID-GBACKID    PIC X(04) VALUE "0205".
                   07  NORDERID-GBACKMES1  PIC X(30) VALUE "帰院".
                   07  NORDERID-GBACKMES2  PIC X(20) VALUE "帰院".
      *
               05  NORDERID-GPTST-G.
                   07  NORDERID-GPTSTCL1   PIC X(02) VALUE "XX".
                   07  NORDERID-GPTSTCL2   PIC X(03) VALUE "XXX".
                   07  NORDERID-GPTSTID    PIC X(04) VALUE "0206".
                   07  NORDERID-GPTSTMES1  PIC X(30) VALUE "外泊等".
                   07  NORDERID-GPTSTMES2  PIC X(20) VALUE "外泊等".
      *
               05  NORDERID-TAIJUSHIN40-G.
                   07  NORDERID-TAIJUSHIN40CL1   PIC X(02) VALUE "XX".
                   07  NORDERID-TAIJUSHIN40CL2   PIC X(03) VALUE "XXX".
                   07  NORDERID-TAIJUSHIN40ID    PIC X(04) VALUE "0207".
                   07  NORDERID-TAIJUSHIN40MES1  PIC X(30)
                               VALUE "他医療機関受診４０％減算".
                   07  NORDERID-TAIJUSHIN40MES2  PIC X(20)
                               VALUE "他医受診４０％減算".
      *
               05  NORDERID-TAIJUSHIN10-G.
                   07  NORDERID-TAIJUSHIN10CL1   PIC X(02) VALUE "XX".
                   07  NORDERID-TAIJUSHIN10CL2   PIC X(03) VALUE "XXX".
                   07  NORDERID-TAIJUSHIN10ID    PIC X(04) VALUE "0208".
                   07  NORDERID-TAIJUSHIN10MES1  PIC X(30)
                               VALUE "他医療機関受診１０％減算".
                   07  NORDERID-TAIJUSHIN10MES2  PIC X(20)
                               VALUE "他医受診１０％減算".
      *
               05  NORDERID-TAIJUSHIN20-G.
                   07  NORDERID-TAIJUSHIN20CL1   PIC X(02) VALUE "XX".
                   07  NORDERID-TAIJUSHIN20CL2   PIC X(03) VALUE "XXX".
                   07  NORDERID-TAIJUSHIN20ID    PIC X(04) VALUE "0209".
                   07  NORDERID-TAIJUSHIN20MES1  PIC X(30)
                               VALUE "他医療機関受診２０％減算".
                   07  NORDERID-TAIJUSHIN20MES2  PIC X(20)
                               VALUE "他医受診２０％減算".
      *
               05  NORDERID-TAIJUSHIN15-G.
                   07  NORDERID-TAIJUSHIN15CL1   PIC X(02) VALUE "XX".
                   07  NORDERID-TAIJUSHIN15CL2   PIC X(03) VALUE "XXX".
                   07  NORDERID-TAIJUSHIN15ID    PIC X(04) VALUE "0210".
                   07  NORDERID-TAIJUSHIN15MES1  PIC X(30)
                               VALUE "他医療機関受診１５％減算".
                   07  NORDERID-TAIJUSHIN15MES2  PIC X(20)
                               VALUE "他医受診１５％減算".
      *
               05  NORDERID-JIKANGEN-G.
                   07  NORDERID-JIKANGENCL1   PIC X(02) VALUE "XX".
                   07  NORDERID-JIKANGENCL2   PIC X(03) VALUE "XXX".
                   07  NORDERID-JIKANGENID    PIC X(04) VALUE "0211".
                   07  NORDERID-JIKANGENMES1  PIC X(30)
                               VALUE "特定時間退院減算".
                   07  NORDERID-JIKANGENMES2  PIC X(20)
                               VALUE "特定時間退院減算".
      *
               05  NORDERID-YOBIGEN-G.
                   07  NORDERID-YOBIGENCL1    PIC X(02) VALUE "XX".
                   07  NORDERID-YOBIGENCL2    PIC X(03) VALUE "XXX".
                   07  NORDERID-YOBIGENID     PIC X(04) VALUE "0212".
                   07  NORDERID-YOBIGENMES1   PIC X(30)
                               VALUE "特定曜日入退院減算".
                   07  NORDERID-YOBIGENMES2   PIC X(20)
                               VALUE "特定曜日入退院減算".
      *
               05  NORDERID-YOBI2GEN-G.
                   07  NORDERID-YOBI2GENCL1   PIC X(02) VALUE "XX".
                   07  NORDERID-YOBI2GENCL2   PIC X(03) VALUE "XXX".
                   07  NORDERID-YOBI2GENID    PIC X(04) VALUE "0213".
                   07  NORDERID-YOBI2GENMES1  PIC X(30)
                               VALUE "特定曜日入退院減＋他受１０％減".
                   07  NORDERID-YOBI2GENMES2  PIC X(20)
                               VALUE "土日減＋他受１０％減".
      *
               05  NORDERID-H30TAIJUSHIN35-G.
                   07 NORDERID-H30TAIJUSHIN35CL1 PIC X(02) VALUE "XX".
                   07 NORDERID-H30TAIJUSHIN35CL2 PIC X(03) VALUE "XXX".
                   07 NORDERID-H30TAIJUSHIN35ID  PIC X(04) VALUE "0214".
                   07 NORDERID-H30TAIJUSHIN35MES1  PIC X(30)
                               VALUE "他医療機関受診３５％減算".
                   07 NORDERID-H30TAIJUSHIN35MES2  PIC X(20)
                               VALUE "他医受診３５％減算".
      *
               05  NORDERID-H30TAIJUSHIN15-G.
                   07 NORDERID-H30TAIJUSHIN15CL1 PIC X(02) VALUE "XX".
                   07 NORDERID-H30TAIJUSHIN15CL2 PIC X(03) VALUE "XXX".
                   07 NORDERID-H30TAIJUSHIN15ID  PIC X(04) VALUE "0215".
                   07 NORDERID-H30TAIJUSHIN15MES1  PIC X(30)
                               VALUE "他医療機関受診１５％減算".
                   07 NORDERID-H30TAIJUSHIN15MES2  PIC X(20)
                               VALUE "他医受診１５％減算".
      *
               05  NORDERID-H30TAIJUSHIN5-G.
                   07 NORDERID-H30TAIJUSHIN5CL1  PIC X(02) VALUE "XX".
                   07 NORDERID-H30TAIJUSHIN5CL2  PIC X(03) VALUE "XXX".
                   07 NORDERID-H30TAIJUSHIN5ID   PIC X(04) VALUE "0216".
                   07 NORDERID-H30TAIJUSHIN5MES1 PIC X(30)
                               VALUE "他医療機関受診５％減算".
                   07 NORDERID-H30TAIJUSHIN5MES2 PIC X(20)
                               VALUE "他医受診５％減算".
      *
               05  NORDERID-H30YOBIGEN-G.
                   07 NORDERID-H30YOBIGENCL1  PIC X(02) VALUE "XX".
                   07 NORDERID-H30YOBIGENCL2  PIC X(03) VALUE "XXX".
                   07 NORDERID-H30YOBIGENID   PIC X(04) VALUE "0217".
                   07 NORDERID-H30YOBIGENMES1 PIC X(30)
                               VALUE "特定曜日入退院減＋他受５％減".
                   07 NORDERID-H30YOBIGENMES2 PIC X(20)
                               VALUE "土日減＋他受５％減".
      *
               05  NORDERID-FNORL-G.
                   07  NORDERID-FNORLCL1   PIC X(02) VALUE "02".
                   07  NORDERID-FNORLCL2   PIC X(03) VALUE "009".
                   07  NORDERID-FNORLID    PIC X(04) VALUE "0301".
                   07  NORDERID-FNORLMES1  PIC X(30)
                                           VALUE "一般食".
                   07  NORDERID-FNORLMES2  PIC X(20)
                                           VALUE "一般食".
      *
               05  NORDERID-FSPCL-G.
                   07  NORDERID-FSPCLCL1   PIC X(02) VALUE "02".
                   07  NORDERID-FSPCLCL2   PIC X(03) VALUE "010".
                   07  NORDERID-FSPCLID    PIC X(04) VALUE "0302".
                   07  NORDERID-FSPCLMES1  PIC X(30)
                                           VALUE "特別食".
                   07  NORDERID-FSPCLMES2  PIC X(20) VALUE "特別食".
      *
               05  NORDERID-FSELE-G.
                   07  NORDERID-FSELECL1   PIC X(02) VALUE "02".
                   07  NORDERID-FSELECL2   PIC X(03) VALUE "011".
                   07  NORDERID-FSELEID    PIC X(04) VALUE "0303".
                   07  NORDERID-FSELEMES1  PIC X(30)
                                           VALUE "選択食".
                   07  NORDERID-FSELEMES2  PIC X(20) VALUE "選択食".
      *
               05  NORDERID-FSPSL-G.
                   07  NORDERID-FSPSLCL1   PIC X(02) VALUE "02".
                   07  NORDERID-FSPSLCL2   PIC X(03) VALUE "013".
                   07  NORDERID-FSPSLID    PIC X(04) VALUE "0304".
                   07  NORDERID-FSPSLMES1  PIC X(30)
                                       VALUE "特別食＋選択食".
                   07  NORDERID-FSPSLMES2  PIC X(20)
                                       VALUE "特別食＋選択食".
      *
               05  NORDERID-FSTOP-G.
                   07  NORDERID-FSTOPCL1   PIC X(02) VALUE "02".
                   07  NORDERID-FSTOPCL2   PIC X(03) VALUE "012".
                   07  NORDERID-FSTOPID    PIC X(04) VALUE "0305".
                   07  NORDERID-FSTOPMES1  PIC X(30) VALUE "食止め".
                   07  NORDERID-FSTOPMES2  PIC X(20) VALUE "食止め".
      *
               05  NORDERID-FOOD-G.
                   07  NORDERID-FOODCL1    PIC X(02) VALUE "XX".
                   07  NORDERID-FOODCL2    PIC X(03) VALUE "XXX".
                   07  NORDERID-FOODID     PIC X(04) VALUE "0306".
                   07  NORDERID-FOODMES1   PIC X(30)
                                           VALUE "食事".
                   07  NORDERID-FOODMES2   PIC X(20)
                                           VALUE "食事".
      *
               05  NORDERID-FLIQUID-G.
                   07  NORDERID-FLIQUIDCL1  PIC X(02) VALUE "02".
                   07  NORDERID-FLIQUIDCL2  PIC X(03) VALUE "021".
                   07  NORDERID-FLIQUIDID   PIC X(04) VALUE "0307".
                   07  NORDERID-FLIQUIDMES1 PIC X(30)
                                           VALUE "経管栄養".
                   07  NORDERID-FOODMES2   PIC X(20)
                                           VALUE "経管栄養".
      *
               05  NORDERID-PTEVAL-G.
                   07  NORDERID-PTEVALCL1  PIC X(02) VALUE "XX".
                   07  NORDERID-PTEVALCL2  PIC X(03) VALUE "XXX".
                   07  NORDERID-PTEVALID   PIC X(04) VALUE "0401".
                   07  NORDERID-PTEVALMES1 PIC X(30)
                                           VALUE "医療区分・ＡＤＬ点数".
                   07  NORDERID-PTEVALMES2 PIC X(20)
                                           VALUE "医療区分・ＡＤＬ点数".
      *
               05  NORDERID-BUNBEN-G.
                   07  NORDERID-BUNBENCL1  PIC X(02) VALUE "XX".
                   07  NORDERID-BUNBENCL2  PIC X(03) VALUE "XXX".
                   07  NORDERID-BUNBENID   PIC X(04) VALUE "0501".
                   07  NORDERID-BUNBENMES1 PIC X(30)
                                           VALUE "出産育児一時金情報".
                   07  NORDERID-BUNBENMES2 PIC X(20)
                                           VALUE "出産育児一時金情報".
      *
               05  NORDERID-SAGAKU-G.
                   07  NORDERID-SAGAKUCL1  PIC X(02) VALUE "XX".
                   07  NORDERID-SAGAKUCL2  PIC X(03) VALUE "XXX".
                   07  NORDERID-SAGAKUID   PIC X(04) VALUE "0601".
                   07  NORDERID-SAGAKUMES1 PIC X(30)
                                           VALUE "室料差額".
                   07  NORDERID-SAGAKUMES2 PIC X(20)
                                           VALUE "室料差額".
               05  NORDERID-SAGAKUCANCEL-G.
                   07  NORDERID-SAGAKUCANCELCL1  PIC X(02) VALUE "XX".
                   07  NORDERID-SAGAKUCANCELCL2  PIC X(03) VALUE "XXX".
                   07  NORDERID-SAGAKUCANCELID   PIC X(04) VALUE "0602".
                   07  NORDERID-SAGAKUCANCELMES1 PIC X(30)
                                           VALUE "室料差額".
                   07  NORDERID-SAGAKUCANCELMES2 PIC X(20)
                                           VALUE "室料差額".
      *
               05  NORDERID-CRENACCT-G.
                   07  NORDERID-CRENACCTCL1    PIC X(02) VALUE "XX".
                   07  NORDERID-CRENACCTCL2    PIC X(03) VALUE "XXX".
                   07  NORDERID-CRENACCTID     PIC X(04) VALUE "9901".
                   07  NORDERID-CRENACCTMES1   PIC X(30)
                                               VALUE "入院会計作成".
                   07  NORDERID-NACCTMES2 PIC X(20)
                                               VALUE "入院会計作成".
      *
           03  NORDERID-R  REDEFINES       NORDERID-VAL.
               05  NORDERID-OCC            OCCURS    44.
                   07  NORDERID-CLAIMID.
                       09  NORDERID-CLAIMIDH   PIC X(02).
                       09  NORDERID-CLAIMIDT   PIC X(03).
                   07  NORDERID-ORCAID         PIC X(04).
                   07  NORDERID-ORCAMES1       PIC X(30).
                   07  NORDERID-ORCAMES2       PIC X(20).
      *
           03  NORDERID-MAX                PIC 9(03) VALUE 44.
