      ************************************************************
      *    ∆¸∑◊…ΩÕ—º˝«º•ﬁ•π•ø         COPY (CPBD002.INC)     *
      ************************************************************
      ************************************************************
      *  •≥•‘°º∂ÁΩ§¿µÕ˙ŒÚ
      * Maj/Min/Rev  Ω§¿µº‘       ∆¸…’      ∆‚Õ∆
      *  01.00.01    MCC-∆£∏∂     02.02.27  º˝«º£ƒ£¬§Œ —ππ§À§Ë§ÍΩ§¿µ
      ************************************************************
      *01  BD002-REC.
           03  BD002-KEY.
      *∞ÂŒ≈µ°¥ÿ£…£ƒ
               05  BD002-HOSPID          PIC  X(24).
      *∆˛≥∞∂Ë ¨
               05  BD002-NYUGAIKBN       PIC  X(01).
      *¥µº‘£…£ƒ
               05  BD002-PTID            PIC  9(10).
      *≈¡…º»÷πÊ
               05  BD002-DENPNUM         PIC  9(07).
      *≈¡…ºªﬁ»÷∫«Ω™»÷πÊ
           03  BD002-DENPLASTNUM         PIC  9(02).
      *ø«Œ≈≤ 
           03  BD002-SRYKA               PIC  X(02).
      *ø«Œ≈∆¸
           03  BD002-SRYYMD              PIC  X(08).
      *≈¡…ºæı¬÷∂Ë ¨
           03  BD002-DENPJTIKBN          PIC  X(01).
      *≈¡…º»Øπ‘∆¸
           03  BD002-DENPPRTYMD          PIC  X(08).
      *¿¡µ·¥¸¥÷
           03  BD002-SKY-KIKAN.
      *¿¡µ·≥´ªœ∆¸
               05  BD002-SKYSTYMD        PIC  X(08).
      *¿¡µ·Ω™Œª∆¸
               05  BD002-SKYEDYMD        PIC  X(08).
      * ›∏±¡»πÁ§ª»÷πÊ
           03  BD002-HKNCOMBINUM         PIC  X(04).
      *ºÁ ›∏±°› ›∏±»÷πÊ
           03  BD002-SYUHKNNUM           PIC  X(03).
      *ºÁ ›∏±°›¥µº‘…È√¥∂‚≥€
           03  BD002-SYUHKNFTNMONEY      PIC  9(07).
      *ºÁ ›∏±°›∑◊ªª…È√¥∂‚
           03  BD002-SYUCOMPFTN          PIC  9(07).
      *ºÁ ›∏±°›∑◊ªªÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
           03  BD002-SYUCOMPYKZFTN       PIC  9(07).
      *ºÁ ›∏±°›∑◊ªª…È√¥∂‚∑◊
           03  BD002-SYUCOMPTOTAL        PIC  9(07).
      *ºÁ ›∏±°›ÃÙ∫ﬁ…È√¥∂Ë ¨
           03  BD002-SYUYKZFTNKBN        PIC  X(01).
      *∏¯»Ò£±°› ›∏±»÷πÊ
           03  BD002-KOH1HKNNUM          PIC  X(03).
      *∏¯»Ò£±°›¥µº‘…È√¥∂‚≥€
           03  BD002-KOH1HKNFTNMONEY     PIC  9(07).
      *∏¯»Ò£±°›∑◊ªª…È√¥∂‚
           03  BD002-KOH1COMPFTN         PIC  9(07).
      *∏¯»Ò£±°›∑◊ªªÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
           03  BD002-KOH1COMPYKZFTN      PIC  9(07).
      *∏¯»Ò£±°›∑◊ªª…È√¥∂‚∑◊
           03  BD002-KOH1COMPTOTAL       PIC  9(07).
      *∏¯»Ò£±°›ÃÙ∫ﬁ…È√¥∂Ë ¨
           03  BD002-KOH1YKZFTNKBN       PIC  X(01).
      *∏¯»Ò£≤°› ›∏±»÷πÊ
           03  BD002-KOH2HKNNUM          PIC  X(03).
      *∏¯»Ò£≤°›¥µº‘…È√¥∂‚≥€
           03  BD002-KOH2HKNFTNMONEY     PIC  9(07).
      *∏¯»Ò£≤°›∑◊ªª…È√¥∂‚
           03  BD002-KOH2COMPFTN         PIC  9(07).
      *∏¯»Ò£≤°›∑◊ªªÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
           03  BD002-KOH2COMPYKZFTN      PIC  9(07).
      *∏¯»Ò£≤°›∑◊ªª…È√¥∂‚∑◊
           03  BD002-KOH2COMPTOTAL       PIC  9(07).
      *∏¯»Ò£≤°›ÃÙ∫ﬁ…È√¥∂Ë ¨
           03  BD002-KOH2YKZFTNKBN       PIC  X(01).
      *∏¯»Ò£≥°› ›∏±»÷πÊ
           03  BD002-KOH3HKNNUM          PIC  X(03).
      *∏¯»Ò£≥°›¥µº‘…È√¥∂‚≥€
           03  BD002-KOH3HKNFTNMONEY     PIC  9(07).
      *∏¯»Ò£≥°›∑◊ªª…È√¥∂‚
           03  BD002-KOH3COMPFTN         PIC  9(07).
      *∏¯»Ò£≥°›∑◊ªªÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
           03  BD002-KOH3COMPYKZFTN      PIC  9(07).
      *∏¯»Ò£≥°›∑◊ªª…È√¥∂‚∑◊
           03  BD002-KOH3COMPTOTAL       PIC  9(07).
      *∏¯»Ò£≥°›ÃÙ∫ﬁ…È√¥∂Ë ¨
           03  BD002-KOH3YKZFTNKBN       PIC  X(01).
      *∏¯»Ò£¥°› ›∏±»÷πÊ
           03  BD002-KOH4HKNNUM          PIC  X(03).
      *∏¯»Ò£¥°›¥µº‘…È√¥∂‚≥€
           03  BD002-KOH4HKNFTNMONEY     PIC  9(07).
      *∏¯»Ò£¥°›∑◊ªª…È√¥∂‚
           03  BD002-KOH4COMPFTN         PIC  9(07).
      *∏¯»Ò£¥°›∑◊ªªÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
           03  BD002-KOH4COMPYKZFTN      PIC  9(07).
      *∏¯»Ò£¥°›∑◊ªª…È√¥∂‚∑◊
           03  BD002-KOH4COMPTOTAL       PIC  9(07).
      *∏¯»Ò£¥°›ÃÙ∫ﬁ…È√¥∂Ë ¨
           03  BD002-KOH4YKZFTNKBN       PIC  X(01).
      *¥µº‘…È√¥Œ®
           03  BD002-PTFTNRATE           PIC  9(03).
      *…Ù≤∞£Œ£œ
           03  BD002-ROOMNUM             PIC  X(05).
      *…¬≈Ô•≥°º•…
           03  BD002-BYOTONUM            PIC  X(03).
      *¿¡µ·ΩÒ∫Ó¿Æ∂Ë ¨
           03  BD002-SKYKUKBN            PIC  X(01).
      *æ√»Ò¿«¬–æ›∂‚≥€
           03  BD002-TAX-TAISHOU         PIC  9(07).
      *æ√»Ò¿«° ∆‚¿«°À
           03  BD002-TAX-MONEY           PIC  9(07).
      *æ√»Ò¿«° πÁ∑◊°À
           03  BD002-SKYGK               PIC  9(07).
      *¿¡µ·∆‚Õ∆
           03  BD002-SKY-NAIYOU.
               05  BD002-SKY-TBL             OCCURS   12.
      *     ›∏±≈¿øÙ
                   09  BD002-HKNTEN          PIC  9(07).
      *    ∂‚≥€
                   09  BD002-MONEY           PIC  9(07).
      *    ≈¨Õ—≥∞∂‚≥€
                   09  BD002-TGMONEY         PIC  9(07).
      *    ≈¨Õ—≥∞∂‚≥€° æ√»Ò¿«§¢§Í°À
                   09  BD002-TGMONEY-TAX     PIC  9(07).
      *¿¡µ·∆‚Õ∆
           03  BD002-SKY-NAIYOU-R        REDEFINES   BD002-SKY-NAIYOU.
      *ø«Œ≈Œ¡(01)
              05  BD002-SSU.
                  09  BD002-SSU-HKNTEN          PIC  9(07).
                  09  BD002-SSU-MONEY           PIC  9(07).
                  09  BD002-SSU-TGMONEY         PIC  9(07).
                  09  BD002-SSU-TGMONEY-TAX     PIC  9(07).
      *ªÿ∆≥Œ¡(02)
              05  BD002-SDO.
                  09  BD002-SDO-HKNTEN          PIC  9(07).
                  09  BD002-SDO-MONEY           PIC  9(07).
                  09  BD002-SDO-TGMONEY         PIC  9(07).
                  09  BD002-SDO-TGMONEY-TAX     PIC  9(07).
      *∫ﬂ¬Œ¡(03)
              05  BD002-ZTK.
                  09  BD002-ZTK-HKNTEN          PIC  9(07).
                  09  BD002-ZTK-MONEY           PIC  9(07).
                  09  BD002-ZTK-TGMONEY         PIC  9(07).
                  09  BD002-ZTK-TGMONEY-TAX     PIC  9(07).
      *≈ÍÃÙŒ¡(04)
              05  BD002-TYK.
                  09  BD002-TYK-HKNTEN          PIC  9(07).
                  09  BD002-TYK-MONEY           PIC  9(07).
                  09  BD002-TYK-TGMONEY         PIC  9(07).
                  09  BD002-TYK-TGMONEY-TAX     PIC  9(07).
      *√ÌºÕŒ¡(05)
              05  BD002-CSY.
                  09  BD002-CSY-HKNTEN          PIC  9(07).
                  09  BD002-CSY-MONEY           PIC  9(07).
                  09  BD002-CSY-TGMONEY         PIC  9(07).
                  09  BD002-CSY-TGMONEY-TAX     PIC  9(07).
      *ΩË√÷Œ¡(06)
              05  BD002-SYC.
                  09  BD002-SYC-HKNTEN          PIC  9(07).
                  09  BD002-SYC-MONEY           PIC  9(07).
                  09  BD002-SYC-TGMONEY         PIC  9(07).
                  09  BD002-SYC-TGMONEY-TAX     PIC  9(07).
      *ºÍΩ—Œ¡(07)
              05  BD002-SJT.
                  09  BD002-SJT-HKNTEN          PIC  9(07).
                  09  BD002-SJT-MONEY           PIC  9(07).
                  09  BD002-SJT-TGMONEY         PIC  9(07).
                  09  BD002-SJT-TGMONEY-TAX     PIC  9(07).
      *∏°∫∫Œ¡(08)
              05  BD002-KNS.
                  09  BD002-KNS-HKNTEN          PIC  9(07).
                  09  BD002-KNS-MONEY           PIC  9(07).
                  09  BD002-KNS-TGMONEY         PIC  9(07).
                  09  BD002-KNS-TGMONEY-TAX     PIC  9(07).
      *£ÿ¿˛Œ¡(09)
              05  BD002-GZU.
                  09  BD002-GZU-HKNTEN          PIC  9(07).
                  09  BD002-GZU-MONEY           PIC  9(07).
                  09  BD002-GZU-TGMONEY         PIC  9(07).
                  09  BD002-GZU-TGMONEY-TAX     PIC  9(07).
      *§Ω§Œ¬æ(10)
              05  BD002-ETC.
                  09  BD002-ETC-HKNTEN          PIC  9(07).
                  09  BD002-ETC-MONEY           PIC  9(07).
                  09  BD002-ETC-TGMONEY         PIC  9(07).
                  09  BD002-ETC-TGMONEY-TAX     PIC  9(07).
      *∆˛±°Œ¡(11)
              05  BD002-NYN.
                  09  BD002-NYN-HKNTEN          PIC  9(07).
                  09  BD002-NYN-MONEY           PIC  9(07).
                  09  BD002-NYN-TGMONEY         PIC  9(07).
                  09  BD002-NYN-TGMONEY-TAX     PIC  9(07).
      *πÁ∑◊  (12)
              05  BD002-TOTAL.
                  09  BD002-TOTAL-HKNTEN        PIC  9(07).
                  09  BD002-TOTAL-MONEY         PIC  9(07).
                  09  BD002-TOTAL-TGMONEY       PIC  9(07).
                  09  BD002-TOTAL-TGMONEY-TAX   PIC  9(07).
      *º´»Ò£±§´§È£µ
           03  BD002-JIHI-NAIYOU.
               05  BD002-JIHI-1              PIC  9(07). 
               05  BD002-JIHI-1-TAX          PIC  9(07). 
               05  BD002-JIHI-2              PIC  9(07). 
               05  BD002-JIHI-2-TAX          PIC  9(07). 
               05  BD002-JIHI-3              PIC  9(07). 
               05  BD002-JIHI-3-TAX          PIC  9(07). 
               05  BD002-JIHI-4              PIC  9(07). 
               05  BD002-JIHI-4-TAX          PIC  9(07). 
               05  BD002-JIHI-5              PIC  9(07). 
               05  BD002-JIHI-5-TAX          PIC  9(07). 
           03  BD002-JIHI-NAIYOU-R       REDEFINES  BD002-JIHI-NAIYOU.
               05  BD002-JIHI-TBL            OCCURS   5.
                 07  BD002-JIHI-TAXNASI        PIC  9(07).
                 07  BD002-JIHI-TAXARI         PIC  9(07).
      *º´»ÒæÆ∑◊° æ√»Ò¿«§ §∑°À
           03  BD002-JIHI-TOTAL          PIC  9(07).
      *º´»ÒæÆ∑◊° æ√»Ò¿«§¢§Í°À
           03  BD002-JIHI-TOTAL-TAX      PIC  9(07).
      *º´»Ò∂‚≥€æ√»Ò¿«
           03  BD002-JIHI-TAX            PIC  9(07).
      *œ∑øÕ∞Ï…Ù…È√¥∂‚
           03  BD002-RJN-FTN             PIC  9(07).
      *∏¯»Ò∞Ï…Ù…È√¥∂‚
           03  BD002-KOH-FTN             PIC  9(07).
      *ÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
           03  BD002-YKZ-FTN             PIC  9(07).
      *•Ï•ª•◊•»Ω–ŒœÕ—ÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
           03  BD002-RESE-YKZ-FTN        PIC  9(07).
      *∏¯»Ò¬–æ›ÃÙ∫ﬁ∂Ë ¨
           03  BD002-KOHTAIYKZKBN        PIC  X(01).
      *ƒ¥¿∞∂‚
           03  BD002-CHOSEI              PIC S9(07).
      * ›æ⁄∂‚≥€
           03  BD002-SECMONEY            PIC  9(07).
      * ›∏±≈¨Õ—∂‚≥€
           03  BD002-HKNTEKMONEY         PIC  9(07).
      *…¬±°∏∫Ã»ªˆÕ≥∂Ë ¨
           03  BD002-DISCOUNT-KBN        PIC  X(02).
      *…¬±°∏∫Ã»ªˆÕ≥
           03  BD002-DISCOUNT-BODY       PIC  X(160).
      *≥‰∞˙Œ®∂Ë ¨
           03  BD002-DISCOUNT-RATEKBN    PIC  X(02).
      *ƒÍŒ®ƒÍ≥€∂Ë ¨
           03  BD002-DISCOUNT-TEIRITU    PIC  X(01).
      *≥‰∞˙Œ®
           03  BD002-DISCOUNT-RATE       PIC  9(07).
      *¿¡µ·∂‚≥€
           03  BD002-SKYMONEY            PIC  9(07).
      *∆˛∂‚πÁ∑◊≥€
           03  BD002-NYUKIN-TOTAL        PIC  9(07).
      *∆˛∂‚≤ÛøÙ
           03  BD002-NYUKIN-KAISU        PIC  9(07).
      *Ã§º˝Õ˝Õ≥
           03  BD002-MISYURIYU           PIC  X(02).
      *•…•Ø•ø°º
           03  BD002-DRCD                PIC  X(04).
      *∆˛±°ΩÈø«≤ÛøÙ
           03  BD002-NYNSHOKAISU         PIC  9(02).
      *ÃÙ∫ﬁ»Ø∑Ù»÷πÊ
           03  BD002-YKZKENNUM           PIC  9(05).
      *ø©ªˆ£±§´§Èø©ªˆ£∑
           03  BD002-SHOKUJI-NAIYOU.
               05  BD002-SHOKUJI1        PIC  9(07).
               05  BD002-SHOKUJI2        PIC  9(07).
               05  BD002-SHOKUJI3        PIC  9(07).
               05  BD002-SHOKUJI4        PIC  9(07).
               05  BD002-SHOKUJI5        PIC  9(07).
               05  BD002-SHOKUJI6        PIC  9(07).
               05  BD002-SHOKUJI7        PIC  9(07).
           03  BD002-SYOKUJI-NAIYOUR REDEFINES   BD002-SHOKUJI-NAIYOU.
               05  BD002-SHOKUJI         PIC  9(07)  OCCURS   7.
      *∫∆∑◊ªª∂Ë ¨
           03  BD002-SAIKEISANKBN        PIC  X(01).
      *±°≥∞ΩË ˝∂Ë ¨
           03  BD002-INGAISHOHOKBN       PIC  X(01).
      *∆±ª˛ø«Œ≈≈¡…º»÷πÊ
           03  BD002-DOUJI-DENPNUM       PIC  9(07).
      *∑—¬≥∂Ë ¨
           03  BD002-CONTKBN             PIC  X(01).
      *√ºÀˆ£…£ƒ
           03  BD002-TERMID              PIC  X(16).
      *•™•⁄°º•Ï°º•ø£…£ƒ
           03  BD002-OPID                PIC  X(16).
      *∫Ó¿Æ«Ø∑Ó∆¸
           03  BD002-CREYMD              PIC  X(08).
      *ππø∑«Ø∑Ó∆¸
           03  BD002-UPYMD               PIC  X(08).
      *ππø∑ª˛¥÷
           03  BD002-UPHMS               PIC  X(06).
      *
      *
      *¥µº‘»÷πÊ
           03  BD002-PTNUM               PIC  X(20).
