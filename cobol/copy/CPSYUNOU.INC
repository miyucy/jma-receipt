      *******************************************************************
      * Project code name "ORCA"
      * ∆¸∞Â…∏Ω‡•Ï•ª•◊•»•Ω•’•»° JMA standard receipt software°À
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
      *    º˝«º•ﬁ•π•ø         COPY (CPSYUNOU.INC)       *
      ************************************************************
      ************************************************************
      *  •≥•‘°º∂ÁΩ§¿µÕ˙ŒÚ
      * Maj/Min/Rev  Ω§¿µº‘       ∆¸…’      ∆‚Õ∆
      ************************************************************
      *01  SYUNOU-REC.
           03  SYU-KEY.
      *∞ÂŒ≈µ°¥ÿ£…£ƒ
               05  SYU-HOSPID          PIC  X(24).
      *∆˛≥∞∂Ë ¨
               05  SYU-NYUGAIKBN       PIC  X(01).
      *¥µº‘£…£ƒ
               05  SYU-PTID            PIC  9(10).
      *≈¡…º»÷πÊ
               05  SYU-DENPNUM         PIC  9(07).
      *≈¡…ºªﬁ»÷∫«Ω™»÷πÊ
           03  SYU-DENPLASTNUM         PIC  9(02).
      *ø«Œ≈≤ 
           03  SYU-SRYKA               PIC  X(02).
      *ø«Œ≈∆¸
           03  SYU-SRYYMD              PIC  X(08).
      *≈¡…ºæı¬÷∂Ë ¨
           03  SYU-DENPJTIKBN          PIC  X(01).
      *≈¡…º»Øπ‘∆¸
           03  SYU-DENPPRTYMD          PIC  X(08).
      *¿¡µ·¥¸¥÷
           03  SYU-SKY-KIKAN.
      *¿¡µ·≥´ªœ∆¸
               05  SYU-SKYSTYMD        PIC  X(08).
      *¿¡µ·Ω™Œª∆¸
               05  SYU-SKYEDYMD        PIC  X(08).
      * ›∏±¡»πÁ§ª»÷πÊ
           03  SYU-HKNCOMBINUM         PIC  X(04).
      *ºÁ ›∏±°› ›∏±»÷πÊ
           03  SYU-SYUHKNNUM           PIC  X(03).
      *ºÁ ›∏±°›¥µº‘…È√¥∂‚≥€
           03  SYU-SYUHKNFTNMONEY      PIC  9(07).
      *ºÁ ›∏±°›∑◊ªª…È√¥∂‚
           03  SYU-SYUCOMPFTN          PIC  9(07).
      *ºÁ ›∏±°›∑◊ªªÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
           03  SYU-SYUCOMPYKZFTN       PIC  9(07).
      *ºÁ ›∏±°›∑◊ªª…È√¥∂‚∑◊
           03  SYU-SYUCOMPTOTAL        PIC  9(07).
      *ºÁ ›∏±°›ÃÙ∫ﬁ…È√¥∂Ë ¨
           03  SYU-SYUYKZFTNKBN        PIC  X(01).
      *∏¯»Ò°›…È√¥æ Û
           03  SYU-KOH-AREA.
      *∏¯»Ò£±°› ›∏±»÷πÊ
               05  SYU-KOH1HKNNUM          PIC  X(03).
      *∏¯»Ò£±°›¥µº‘…È√¥∂‚≥€
               05  SYU-KOH1HKNFTNMONEY     PIC  9(07).
      *∏¯»Ò£±°›∑◊ªª…È√¥∂‚
               05  SYU-KOH1COMPFTN         PIC  9(07).
      *∏¯»Ò£±°›∑◊ªªÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
               05  SYU-KOH1COMPYKZFTN      PIC  9(07).
      *∏¯»Ò£±°›∑◊ªª…È√¥∂‚∑◊
               05  SYU-KOH1COMPTOTAL       PIC  9(07).
      *∏¯»Ò£±°›ÃÙ∫ﬁ…È√¥∂Ë ¨
               05  SYU-KOH1YKZFTNKBN       PIC  X(01).
      *∏¯»Ò£≤°› ›∏±»÷πÊ
               05  SYU-KOH2HKNNUM          PIC  X(03).
      *∏¯»Ò£≤°›¥µº‘…È√¥∂‚≥€
               05  SYU-KOH2HKNFTNMONEY     PIC  9(07).
      *∏¯»Ò£≤°›∑◊ªª…È√¥∂‚
               05  SYU-KOH2COMPFTN         PIC  9(07).
      *∏¯»Ò£≤°›∑◊ªªÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
               05  SYU-KOH2COMPYKZFTN      PIC  9(07).
      *∏¯»Ò£≤°›∑◊ªª…È√¥∂‚∑◊
               05  SYU-KOH2COMPTOTAL       PIC  9(07).
      *∏¯»Ò£≤°›ÃÙ∫ﬁ…È√¥∂Ë ¨
               05  SYU-KOH2YKZFTNKBN       PIC  X(01).
      *∏¯»Ò£≥°› ›∏±»÷πÊ
               05  SYU-KOH3HKNNUM          PIC  X(03).
      *∏¯»Ò£≥°›¥µº‘…È√¥∂‚≥€
               05  SYU-KOH3HKNFTNMONEY     PIC  9(07).
      *∏¯»Ò£≥°›∑◊ªª…È√¥∂‚
               05  SYU-KOH3COMPFTN         PIC  9(07).
      *∏¯»Ò£≥°›∑◊ªªÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
               05  SYU-KOH3COMPYKZFTN      PIC  9(07).
      *∏¯»Ò£≥°›∑◊ªª…È√¥∂‚∑◊
               05  SYU-KOH3COMPTOTAL       PIC  9(07).
      *∏¯»Ò£≥°›ÃÙ∫ﬁ…È√¥∂Ë ¨
               05  SYU-KOH3YKZFTNKBN       PIC  X(01).
      *∏¯»Ò£¥°› ›∏±»÷πÊ
               05  SYU-KOH4HKNNUM          PIC  X(03).
      *∏¯»Ò£¥°›¥µº‘…È√¥∂‚≥€
               05  SYU-KOH4HKNFTNMONEY     PIC  9(07).
      *∏¯»Ò£¥°›∑◊ªª…È√¥∂‚
               05  SYU-KOH4COMPFTN         PIC  9(07).
      *∏¯»Ò£¥°›∑◊ªªÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
               05  SYU-KOH4COMPYKZFTN      PIC  9(07).
      *∏¯»Ò£¥°›∑◊ªª…È√¥∂‚∑◊
               05  SYU-KOH4COMPTOTAL       PIC  9(07).
      *∏¯»Ò£¥°›ÃÙ∫ﬁ…È√¥∂Ë ¨
               05  SYU-KOH4YKZFTNKBN       PIC  X(01).
      *∏¯»Ò…È√¥æ Û∫∆ƒÍµ¡
           03  SYU-KOHFTN-TABLE  REDEFINES   SYU-KOH-AREA.
               05  SYU-KOHFTN-TBL          OCCURS  4.
      *∏¯»Ò°› ›∏±»÷πÊ
                 07  SYU-KOH-HKNNUM          PIC  X(03).
      *∏¯»Ò°›¥µº‘…È√¥∂‚≥€
                 07  SYU-KOH-HKNFTNMONEY     PIC  9(07).
      *∏¯»Ò°›∑◊ªª…È√¥∂‚
                 07  SYU-KOH-COMPFTN         PIC  9(07).
      *∏¯»Ò°›∑◊ªªÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
                 07  SYU-KOH-COMPYKZFTN      PIC  9(07).
      *∏¯»Ò°›∑◊ªª…È√¥∂‚∑◊
                 07  SYU-KOH-COMPTOTAL       PIC  9(07).
      *∏¯»Ò°›ÃÙ∫ﬁ…È√¥∂Ë ¨
                 07  SYU-KOH-YKZFTNKBN       PIC  X(01).
      *¥µº‘…È√¥Œ®
           03  SYU-PTFTNRATE           PIC  9(03).
      *…Ù≤∞£Œ£œ
           03  SYU-ROOMNUM             PIC  X(05).
      *…¬≈Ô•≥°º•…
           03  SYU-BYOTONUM            PIC  X(03).
      *¿¡µ·ΩÒ∫Ó¿Æ∂Ë ¨
           03  SYU-SKYKUKBN            PIC  X(01).
      *æ√»Ò¿«¬–æ›∂‚≥€
           03  SYU-TAX-TAISHOU         PIC  9(07).
      *æ√»Ò¿«° ∆‚¿«°À
           03  SYU-TAX-MONEY           PIC  9(07).
      *æ√»Ò¿«° πÁ∑◊°À
           03  SYU-SKYGK               PIC  9(07).
      *¿¡µ·∆‚Õ∆
           03  SYU-SKY-NAIYOU.
               05  SYU-SKY-TBL             OCCURS   12.
      *     ›∏±≈¿øÙ
                   09  SYU-HKNTEN          PIC  9(07).
      *    ∂‚≥€
                   09  SYU-MONEY           PIC  9(07).
      *    ≈¨Õ—≥∞∂‚≥€
                   09  SYU-TGMONEY         PIC  9(07).
      *    ≈¨Õ—≥∞∂‚≥€° æ√»Ò¿«§¢§Í°À
                   09  SYU-TGMONEY-TAX     PIC  9(07).
      *¿¡µ·∆‚Õ∆
           03  SYU-SKY-NAIYOU-R        REDEFINES   SYU-SKY-NAIYOU.
      *ø«Œ≈Œ¡(01)
              05  SYU-SSU.
                  09  SYU-SSU-HKNTEN          PIC  9(07).
                  09  SYU-SSU-MONEY           PIC  9(07).
                  09  SYU-SSU-TGMONEY         PIC  9(07).
                  09  SYU-SSU-TGMONEY-TAX     PIC  9(07).
      *ªÿ∆≥Œ¡(02)
              05  SYU-SDO.
                  09  SYU-SDO-HKNTEN          PIC  9(07).
                  09  SYU-SDO-MONEY           PIC  9(07).
                  09  SYU-SDO-TGMONEY         PIC  9(07).
                  09  SYU-SDO-TGMONEY-TAX     PIC  9(07).
      *∫ﬂ¬Œ¡(03)
              05  SYU-ZTK.
                  09  SYU-ZTK-HKNTEN          PIC  9(07).
                  09  SYU-ZTK-MONEY           PIC  9(07).
                  09  SYU-ZTK-TGMONEY         PIC  9(07).
                  09  SYU-ZTK-TGMONEY-TAX     PIC  9(07).
      *≈ÍÃÙŒ¡(04)
              05  SYU-TYK.
                  09  SYU-TYK-HKNTEN          PIC  9(07).
                  09  SYU-TYK-MONEY           PIC  9(07).
                  09  SYU-TYK-TGMONEY         PIC  9(07).
                  09  SYU-TYK-TGMONEY-TAX     PIC  9(07).
      *√ÌºÕŒ¡(05)
              05  SYU-CSY.
                  09  SYU-CSY-HKNTEN          PIC  9(07).
                  09  SYU-CSY-MONEY           PIC  9(07).
                  09  SYU-CSY-TGMONEY         PIC  9(07).
                  09  SYU-CSY-TGMONEY-TAX     PIC  9(07).
      *ΩË√÷Œ¡(06)
              05  SYU-SYC.
                  09  SYU-SYC-HKNTEN          PIC  9(07).
                  09  SYU-SYC-MONEY           PIC  9(07).
                  09  SYU-SYC-TGMONEY         PIC  9(07).
                  09  SYU-SYC-TGMONEY-TAX     PIC  9(07).
      *ºÍΩ—Œ¡(07)
              05  SYU-SJT.
                  09  SYU-SJT-HKNTEN          PIC  9(07).
                  09  SYU-SJT-MONEY           PIC  9(07).
                  09  SYU-SJT-TGMONEY         PIC  9(07).
                  09  SYU-SJT-TGMONEY-TAX     PIC  9(07).
      *∏°∫∫Œ¡(08)
              05  SYU-KNS.
                  09  SYU-KNS-HKNTEN          PIC  9(07).
                  09  SYU-KNS-MONEY           PIC  9(07).
                  09  SYU-KNS-TGMONEY         PIC  9(07).
                  09  SYU-KNS-TGMONEY-TAX     PIC  9(07).
      *£ÿ¿˛Œ¡(09)
              05  SYU-GZU.
                  09  SYU-GZU-HKNTEN          PIC  9(07).
                  09  SYU-GZU-MONEY           PIC  9(07).
                  09  SYU-GZU-TGMONEY         PIC  9(07).
                  09  SYU-GZU-TGMONEY-TAX     PIC  9(07).
      *§Ω§Œ¬æ(10)
              05  SYU-ETC.
                  09  SYU-ETC-HKNTEN          PIC  9(07).
                  09  SYU-ETC-MONEY           PIC  9(07).
                  09  SYU-ETC-TGMONEY         PIC  9(07).
                  09  SYU-ETC-TGMONEY-TAX     PIC  9(07).
      *∆˛±°Œ¡(11)
              05  SYU-NYN.
                  09  SYU-NYN-HKNTEN          PIC  9(07).
                  09  SYU-NYN-MONEY           PIC  9(07).
                  09  SYU-NYN-TGMONEY         PIC  9(07).
                  09  SYU-NYN-TGMONEY-TAX     PIC  9(07).
      *πÁ∑◊  (12)
              05  SYU-TOTAL.
                  09  SYU-TOTAL-HKNTEN        PIC  9(07).
                  09  SYU-TOTAL-MONEY         PIC  9(07).
                  09  SYU-TOTAL-TGMONEY       PIC  9(07).
                  09  SYU-TOTAL-TGMONEY-TAX   PIC  9(07).
      *º´»Ò£±§´§È£µ
           03  SYU-JIHI-NAIYOU.
               05  SYU-JIHI-1              PIC  9(07). 
               05  SYU-JIHI-1-TAX          PIC  9(07). 
               05  SYU-JIHI-2              PIC  9(07). 
               05  SYU-JIHI-2-TAX          PIC  9(07). 
               05  SYU-JIHI-3              PIC  9(07). 
               05  SYU-JIHI-3-TAX          PIC  9(07). 
               05  SYU-JIHI-4              PIC  9(07). 
               05  SYU-JIHI-4-TAX          PIC  9(07). 
               05  SYU-JIHI-5              PIC  9(07). 
               05  SYU-JIHI-5-TAX          PIC  9(07). 
           03  SYU-JIHI-NAIYOU-R           REDEFINES  SYU-JIHI-NAIYOU.
               05  SYU-JIHI-TBL            OCCURS   5.
                 07  SYU-JIHI-TAXNASI        PIC  9(07).
                 07  SYU-JIHI-TAXARI         PIC  9(07).
      *º´»ÒæÆ∑◊° æ√»Ò¿«§ §∑°À
           03  SYU-JIHI-TOTAL          PIC  9(07).
      *º´»ÒæÆ∑◊° æ√»Ò¿«§¢§Í°À
           03  SYU-JIHI-TOTAL-TAX      PIC  9(07).
      *º´»Ò∂‚≥€æ√»Ò¿«
           03  SYU-JIHI-TAX            PIC  9(07).
      *œ∑øÕ∞Ï…Ù…È√¥∂‚
           03  SYU-RJN-FTN             PIC  9(07).
      *∏¯»Ò∞Ï…Ù…È√¥∂‚
           03  SYU-KOH-FTN             PIC  9(07).
      *ÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
           03  SYU-YKZ-FTN             PIC  9(07).
      *•Ï•ª•◊•»Ω–ŒœÕ—ÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
           03  SYU-RESE-YKZ-FTN        PIC  9(07).
      *∏¯»Ò¬–æ›ÃÙ∫ﬁ∂Ë ¨
           03  SYU-KOHTAIYKZKBN        PIC  X(01).
      *ƒ¥¿∞∂‚
           03  SYU-CHOSEI              PIC S9(07).
      * ›æ⁄∂‚≥€
           03  SYU-SECMONEY            PIC  9(07).
      * ›∏±≈¨Õ—∂‚≥€
           03  SYU-HKNTEKMONEY         PIC  9(07).
      *…¬±°∏∫Ã»ªˆÕ≥∂Ë ¨
           03  SYU-DISCOUNT-KBN        PIC  X(02).
      *…¬±°∏∫Ã»ªˆÕ≥
           03  SYU-DISCOUNT-BODY       PIC  X(160).
      *≥‰∞˙Œ®∂Ë ¨
           03  SYU-DISCOUNT-RATEKBN    PIC  X(02).
      *ƒÍŒ®ƒÍ≥€∂Ë ¨
           03  SYU-DISCOUNT-TEIRITU    PIC  X(01).
      *≥‰∞˙Œ®
           03  SYU-DISCOUNT-RATE       PIC  9(07).
      *œ´∫“ ›∏±°›ΩÈø«Œ¡
           03  SYU-RSISHOSHIN-MONEY    PIC  9(07).
      *œ´∫“ ›∏±°›∫∆ø«Œ¡
           03  SYU-RSISAISHIN-MONEY    PIC  9(07).
      *œ´∫“ ›∏±°›ªÿ∆≥Œ¡
           03  SYU-RSISDO-MONEY        PIC  9(07).
      *œ´∫“ ›∏±°›§Ω§Œ¬æ
           03  SYU-RSIETC-MONEY        PIC  9(07).
      *¿¡µ·∂‚≥€
           03  SYU-SKYMONEY            PIC  9(07).
      *∆˛∂‚πÁ∑◊≥€
           03  SYU-NYUKIN-TOTAL        PIC  9(07).
      *∆˛∂‚≤ÛøÙ
           03  SYU-NYUKIN-KAISU        PIC  9(07).
      *Ã§º˝Õ˝Õ≥
           03  SYU-MISYURIYU           PIC  X(02).
      *•…•Ø•ø°º
           03  SYU-DRCD                PIC  X(04).
      *∆˛±°ΩÈø«≤ÛøÙ
           03  SYU-NYNSHOKAISU         PIC  9(02).
      *ÃÙ∫ﬁ»Ø∑Ù»÷πÊ
           03  SYU-YKZKENNUM           PIC  9(05).
      *ø©ªˆ£±§´§Èø©ªˆ£∑
           03  SYU-SHOKUJI-NAIYOU.
               05  SYU-SHOKUJI1        PIC  9(07).
               05  SYU-SHOKUJI2        PIC  9(07).
               05  SYU-SHOKUJI3        PIC  9(07).
               05  SYU-SHOKUJI4        PIC  9(07).
               05  SYU-SHOKUJI5        PIC  9(07).
               05  SYU-SHOKUJI6        PIC  9(07).
               05  SYU-SHOKUJI7        PIC  9(07).
           03  SYU-SYOKUJI-NAIYOUR     REDEFINES   SYU-SHOKUJI-NAIYOU.
               05  SYU-SHOKUJI         PIC  9(07)  OCCURS   7.
      *∫∆∑◊ªª∂Ë ¨
           03  SYU-SAIKEISANKBN        PIC  X(01).
      *±°≥∞ΩË ˝∂Ë ¨
           03  SYU-INGAISHOHOKBN       PIC  X(01).
      *∆±ª˛ø«Œ≈≈¡…º»÷πÊ
           03  SYU-DOUJI-DENPNUM       PIC  9(07).
      *∑—¬≥∂Ë ¨
           03  SYU-CONTKBN             PIC  X(01).
      *√ºÀˆ£…£ƒ
           03  SYU-TERMID              PIC  X(16).
      *•™•⁄°º•Ï°º•ø£…£ƒ
           03  SYU-OPID                PIC  X(16).
      *∫Ó¿Æ«Ø∑Ó∆¸
           03  SYU-CREYMD              PIC  X(08).
      *ππø∑«Ø∑Ó∆¸
           03  SYU-UPYMD               PIC  X(08).
      *ππø∑ª˛¥÷
           03  SYU-UPHMS               PIC  X(06).
      *
