      ************************************************************
      *    ∆¸∑◊…ΩÕ—º˝«º•ﬁ•π•ø         COPY (CPBD002.INC)     *
      ************************************************************
      ************************************************************
      *  •≥•‘°º∂ÁΩ§¿µÕ˙ŒÚ
      * Maj/Min/Rev  Ω§¿µº‘       ∆¸…’      ∆‚Õ∆
      *  01.00.01    MCC-∆£∏∂     02.02.27  º˝«º£ƒ£¬§Œ —ππ§À§Ë§ÍΩ§¿µ
      *  01.00.02    NACL-æÆ∆¶¬Ù  04.01.21  º˝«º£ƒ£¬§Œ —ππ§À§Ë§ÍΩ§¿µ
      ************************************************************
      *01  BD002-REC.
           03  BD002-KEY.
      *
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
      *≈¡…º∫Ó¿Æ∂Ë ¨° ∂ı«Ú°ß≥∞ÕË°°£±°ß¬‡±°ª˛∫Ó¿Æ°°£≤°ßƒÍ¥¸¿¡µ·
      *              £≥°ß∆˛±°•Ï•ª•◊•»Õ—•¿•ﬂ°º°À
           03  BD002-CREATEKBN           PIC  X(01).
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
      *ºÁ ›∏±°›∑◊ªª…È√¥∂‚° ±ﬂ√±∞Ãµ≠œøÕ—°À
           03  BD002-SYUCOMPFTN-ENTANI   PIC  9(07).
      *ºÁ ›∏±°›∑◊ªªÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
           03  BD002-SYUCOMPYKZFTN       PIC  9(07).
      *ºÁ ›∏±°›∑◊ªª…È√¥∂‚∑◊
           03  BD002-SYUCOMPTOTAL        PIC  9(07).
      *ºÁ ›∏±°›ÃÙ∫ﬁ…È√¥∂Ë ¨
           03  BD002-SYUYKZFTNKBN        PIC  X(01).
      *∏¯»Ò°›…È√¥æ Û
           03  BD002-KOH-AREA.
      *∏¯»Ò£±°› ›∏±»÷πÊ
               05  BD002-KOH1HKNNUM          PIC  X(03).
      *∏¯»Ò£±°›¥µº‘…È√¥∂‚≥€
               05  BD002-KOH1HKNFTNMONEY     PIC  9(07).
      *∏¯»Ò£±°›∑◊ªª…È√¥∂‚
               05  BD002-KOH1COMPFTN         PIC  9(07).
      *∏¯»Ò£±°›∑◊ªª…È√¥∂‚° ±ﬂ√±∞Ãµ≠œøÕ—°À
               05  BD002-KOH1COMPFTN-ENTANI  PIC  9(07).
      *∏¯»Ò£±°›∑◊ªªÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
               05  BD002-KOH1COMPYKZFTN      PIC  9(07).
      *∏¯»Ò£±°›∑◊ªª…È√¥∂‚∑◊
               05  BD002-KOH1COMPTOTAL       PIC  9(07).
      *∏¯»Ò£±°›ÃÙ∫ﬁ…È√¥∂Ë ¨
               05  BD002-KOH1YKZFTNKBN       PIC  X(01).
      *∏¯»Ò£≤°› ›∏±»÷πÊ
               05  BD002-KOH2HKNNUM          PIC  X(03).
      *∏¯»Ò£≤°›¥µº‘…È√¥∂‚≥€
               05  BD002-KOH2HKNFTNMONEY     PIC  9(07).
      *∏¯»Ò£≤°›∑◊ªª…È√¥∂‚
               05  BD002-KOH2COMPFTN         PIC  9(07).
      *∏¯»Ò£≤°›∑◊ªª…È√¥∂‚° ±ﬂ√±∞Ãµ≠œøÕ—°À
               05  BD002-KOH2COMPFTN-ENTANI  PIC  9(07).
      *∏¯»Ò£≤°›∑◊ªªÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
               05  BD002-KOH2COMPYKZFTN      PIC  9(07).
      *∏¯»Ò£≤°›∑◊ªª…È√¥∂‚∑◊
               05  BD002-KOH2COMPTOTAL       PIC  9(07).
      *∏¯»Ò£≤°›ÃÙ∫ﬁ…È√¥∂Ë ¨
               05  BD002-KOH2YKZFTNKBN       PIC  X(01).
      *∏¯»Ò£≥°› ›∏±»÷πÊ
               05  BD002-KOH3HKNNUM          PIC  X(03).
      *∏¯»Ò£≥°›¥µº‘…È√¥∂‚≥€
               05  BD002-KOH3HKNFTNMONEY     PIC  9(07).
      *∏¯»Ò£≥°›∑◊ªª…È√¥∂‚
               05  BD002-KOH3COMPFTN         PIC  9(07).
      *∏¯»Ò£≥°›∑◊ªª…È√¥∂‚° ±ﬂ√±∞Ãµ≠œøÕ—°À
               05  BD002-KOH3COMPFTN-ENTANI  PIC  9(07).
      *∏¯»Ò£≥°›∑◊ªªÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
               05  BD002-KOH3COMPYKZFTN      PIC  9(07).
      *∏¯»Ò£≥°›∑◊ªª…È√¥∂‚∑◊
               05  BD002-KOH3COMPTOTAL       PIC  9(07).
      *∏¯»Ò£≥°›ÃÙ∫ﬁ…È√¥∂Ë ¨
               05  BD002-KOH3YKZFTNKBN       PIC  X(01).
      *∏¯»Ò£¥°› ›∏±»÷πÊ
               05  BD002-KOH4HKNNUM          PIC  X(03).
      *∏¯»Ò£¥°›¥µº‘…È√¥∂‚≥€
               05  BD002-KOH4HKNFTNMONEY     PIC  9(07).
      *∏¯»Ò£¥°›∑◊ªª…È√¥∂‚
               05  BD002-KOH4COMPFTN         PIC  9(07).
      *∏¯»Ò£¥°›∑◊ªª…È√¥∂‚° ±ﬂ√±∞Ãµ≠œøÕ—°À
               05  BD002-KOH4COMPFTN-ENTANI  PIC  9(07).
      *∏¯»Ò£¥°›∑◊ªªÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
               05  BD002-KOH4COMPYKZFTN      PIC  9(07).
      *∏¯»Ò£¥°›∑◊ªª…È√¥∂‚∑◊
               05  BD002-KOH4COMPTOTAL       PIC  9(07).
      *∏¯»Ò£¥°›ÃÙ∫ﬁ…È√¥∂Ë ¨
               05  BD002-KOH4YKZFTNKBN       PIC  X(01).
      *∏¯»Ò…È√¥æ Û∫∆ƒÍµ¡
           03  BD002-KOHFTN-TABLE  REDEFINES   BD002-KOH-AREA.
               05  BD002-KOHFTN-TBL          OCCURS  4.
      *∏¯»Ò°› ›∏±»÷πÊ
                 07  BD002-KOH-HKNNUM          PIC  X(03).
      *∏¯»Ò°›¥µº‘…È√¥∂‚≥€
                 07  BD002-KOH-HKNFTNMONEY     PIC  9(07).
      *∏¯»Ò°›∑◊ªª…È√¥∂‚
                 07  BD002-KOH-COMPFTN         PIC  9(07).
      *∏¯»Ò°›∑◊ªª…È√¥∂‚° ±ﬂ√±∞Ãµ≠œøÕ—°À
                 07  BD002-KOH-COMPFTN-ENTANI  PIC  9(07).
      *∏¯»Ò°›∑◊ªªÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
                 07  BD002-KOH-COMPYKZFTN      PIC  9(07).
      *∏¯»Ò°›∑◊ªª…È√¥∂‚∑◊
                 07  BD002-KOH-COMPTOTAL       PIC  9(07).
      *∏¯»Ò°›ÃÙ∫ﬁ…È√¥∂Ë ¨
                 07  BD002-KOH-YKZFTNKBN       PIC  X(01).
      *¥µº‘…È√¥Œ®
           03  BD002-PTFTNRATE           PIC  9(03).
      *…Ù≤∞£Œ£œ
           03  BD002-ROOMNUM             PIC  X(08).
      *…¬≈Ô•≥°º•…
           03  BD002-BYOTONUM            PIC  X(02).
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
      * ›∏±≈¨Õ—≥∞∂‚≥€°›æ√»Ò¿«° ∫∆∑«°À
           03  BD002-TGMONEY-TAX-SAI         PIC  9(07).
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
      *œ´∫“ ›∏±°›ΩÈø«Œ¡
           03  BD002-RSISHOSHIN-MONEY    PIC  9(07).
      *œ´∫“ ›∏±°›∫∆ø«Œ¡
           03  BD002-RSISAISHIN-MONEY    PIC  9(07).
      *œ´∫“ ›∏±°›ªÿ∆≥Œ¡
           03  BD002-RSISDO-MONEY        PIC  9(07).
      *œ´∫“ ›∏±°›§Ω§Œ¬æ
           03  BD002-RSIETC-MONEY        PIC  9(07).
      *œ´∫“ ›∏±°›æ√»Ò¿«° ∫∆∑«°À
           03  BD002-RSI-TAX-SAI         PIC  9(07).
      *œ´∫“ ›∏±°›¥µº‘¿¡µ· ¨±ﬂ∑˙§∆πÁ∑◊≥€
           03  BD002-RSI-TOTAL           PIC  9(07).
      *œ´∫“º´«Â°›¿¡µ·∂‚≥€° ∆¸∑◊…Ωµ≠∫‹Õ—°À
           03  BD002-RSIJIBAI-SKYMONEY   PIC  9(07).
      *¿¡µ·∂‚≥€°›æ√»Ò¿«° ∫∆∑«°À
           03  BD002-SKYMONEY-TAX-SAI    PIC  9(07).
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
      *ººŒ¡∫π≥€
           03  BD002-RMSAGAKU            PIC  9(07).
      *ººŒ¡∫π≥€°›æ√»Ò¿«° ∫∆∑«°À
           03  BD002-RMSAGAKU-TAX-SAI    PIC  9(07).
      *ø©ªˆ£±§´§Èø©ªˆ£∑
           03  BD002-SHOKUJI-NAIYOU.
               05  BD002-SHOKUJI1-NISSU  PIC  9(02).
               05  BD002-SHOKUJI1        PIC  9(07).
               05  BD002-SHOKUJI2-NISSU  PIC  9(02).
               05  BD002-SHOKUJI2        PIC  9(07).
               05  BD002-SHOKUJI3-NISSU  PIC  9(02).
               05  BD002-SHOKUJI3        PIC  9(07).
               05  BD002-SHOKUJI4-NISSU  PIC  9(02).
               05  BD002-SHOKUJI4        PIC  9(07).
               05  BD002-SHOKUJI5-NISSU  PIC  9(02).
               05  BD002-SHOKUJI5        PIC  9(07).
               05  BD002-SHOKUJI6-NISSU  PIC  9(02).
               05  BD002-SHOKUJI6        PIC  9(07).
               05  BD002-SHOKUJI7-NISSU  PIC  9(02).
               05  BD002-SHOKUJI7        PIC  9(07).
           03  BD002-SYOKUJI-NAIYOUR REDEFINES   BD002-SHOKUJI-NAIYOU.
               05  BD002-SYOKUJI-TBL     OCCURS   7.
                 07  BD002-SHOKUJI-NISSU   PIC  9(02).
                 07  BD002-SHOKUJI         PIC  9(07).
      *ø©ªˆŒ≈Õ‹»Òæ Û° ø©ªˆ∆¸øÙ°¶ø©ªˆŒ≈Õ‹»Ò°¶…∏Ω‡…È√¥≥€°À
           03  BD002-SKJ-AREA.
               05  BD002-SYUSKJ-NISSU      PIC  9(02).
               05  BD002-SYUSKJ-RYOYOHI    PIC  9(07).
               05  BD002-SYUSKJ-FTN        PIC  9(07).
               05  BD002-SYUSKJ-FTN-RECE   PIC  9(07).
               05  BD002-SYUSKJ-FTNKBN     PIC  X(01).
           03  BD002-SKJ-AREA2.
               05  BD002-KOH1SKJ-NISSU     PIC  9(02).
               05  BD002-KOH1SKJ-RYOYOHI   PIC  9(07).
               05  BD002-KOH1SKJ-FTN       PIC  9(07).
               05  BD002-KOH1SKJ-FTN-RECE  PIC  9(07).
               05  BD002-KOH1SKJ-FTNKBN    PIC  X(01).
               05  BD002-KOH2SKJ-NISSU     PIC  9(02).
               05  BD002-KOH2SKJ-RYOYOHI   PIC  9(07).
               05  BD002-KOH2SKJ-FTN       PIC  9(07).
               05  BD002-KOH2SKJ-FTN-RECE  PIC  9(07).
               05  BD002-KOH2SKJ-FTNKBN    PIC  X(01).
               05  BD002-KOH3SKJ-NISSU     PIC  9(02).
               05  BD002-KOH3SKJ-RYOYOHI   PIC  9(07).
               05  BD002-KOH3SKJ-FTN       PIC  9(07).
               05  BD002-KOH3SKJ-FTN-RECE  PIC  9(07).
               05  BD002-KOH3SKJ-FTNKBN    PIC  X(01).
               05  BD002-KOH4SKJ-NISSU     PIC  9(02).
               05  BD002-KOH4SKJ-RYOYOHI   PIC  9(07).
               05  BD002-KOH4SKJ-FTN       PIC  9(07).
               05  BD002-KOH4SKJ-FTN-RECE  PIC  9(07).
               05  BD002-KOH4SKJ-FTNKBN    PIC  X(01).
           03  BD002-SKJ-AREA2R          REDEFINES   BD002-SKJ-AREA2.
               05  BD002-SKJ-TBL         OCCURS   4.
                 07  BD002-SKJ-NISSU       PIC  9(02).
                 07  BD002-SKJ-RYOYOHI     PIC  9(07).
                 07  BD002-SKJ-FTN         PIC  9(07).
                 07  BD002-SKJ-FTN-RECE    PIC  9(07).
                 07  BD002-SKJ-FTNKBN      PIC  X(01).
      *ø©ªˆŒ≈Õ‹»Ò°  ›∏±°À
           03  BD002-RYOYOHI-SKJ         PIC  9(07).
      *ø©ªˆ…È√¥≥€°  ›∏±°ßº´∏ …È√¥°À
           03  BD002-SKYMONEY-SKJ        PIC  9(07).
      *ø©ªˆ…È√¥≥€°  ›∏±°ßº´∏ …È√¥æ√»Ò¿«°À
           03  BD002-SKYMONEY-SKJ-TAX    PIC  9(07).
      *ø©ªˆ…È√¥≥€°  ›∏±°ßº´∏ …È√¥πÁ∑◊°À
           03  BD002-SKYMONEY-SKJ-KEI    PIC  9(07).
      *ø©ªˆŒ≈Õ‹»Ò° º´»Ò°À
           03  BD002-RYOYOHI-SKJ-JIHI    PIC  9(07).
      *ø©ªˆ…È√¥≥€° º´»Ò°ßº´∏ …È√¥°À
           03  BD002-SKYMONEY-SKJ-JIHI   PIC  9(07).
      *ø©ªˆ…È√¥≥€° º´»Ò°ßº´∏ …È√¥æ√»Ò¿«°À
           03  BD002-SKYMONEY-SKJ-JIHI-TAX
                                       PIC  9(07).
      *ø©ªˆ…È√¥≥€° º´»Ò°ßº´∏ …È√¥πÁ∑◊°À
           03  BD002-SKYMONEY-SKJ-JIHI-KEI
                                       PIC  9(07).
      *ø©ªˆ…È√¥° …È√¥≥€ Ã¥…Õ˝Õ—°À
           03  BD002-SKJ-PTFTN           OCCURS 3.
               05  BD002-SKJ-FTNGAKU     PIC  9(05).
               05  BD002-SKJ-FTNDAY      PIC  9(02).
      *∫∆∑◊ªª∂Ë ¨
           03  BD002-SAIKEISANKBN        PIC  X(01).
      *±°≥∞ΩË ˝∂Ë ¨
           03  BD002-INGAISHOHOKBN       PIC  X(01).
      *∆±ª˛ø«Œ≈≈¡…º»÷πÊ
           03  BD002-DOUJI-DENPNUM       PIC  9(07).
      *∑—¬≥∂Ë ¨
           03  BD002-CONTKBN             PIC  X(01).
      *ø«Œ≈•’•È•∞•∆°º•÷•Î
           03  BD002-DAY-AREA.
      *        ø«Œ≈•’•È•∞•∆°º•÷•Î
             04  BD002-DAY-TBL.
      *        ø«Œ≈•’•È•∞° £±∆¸§´§È£≥£±∆¸°À
               05  BD002-DAY-1           PIC  X(01).
               05  BD002-DAY-2           PIC  X(01).
               05  BD002-DAY-3           PIC  X(01).
               05  BD002-DAY-4           PIC  X(01).
               05  BD002-DAY-5           PIC  X(01).
               05  BD002-DAY-6           PIC  X(01).
               05  BD002-DAY-7           PIC  X(01).
               05  BD002-DAY-8           PIC  X(01).
               05  BD002-DAY-9           PIC  X(01).
               05  BD002-DAY-10          PIC  X(01).
               05  BD002-DAY-11          PIC  X(01).
               05  BD002-DAY-12          PIC  X(01).
               05  BD002-DAY-13          PIC  X(01).
               05  BD002-DAY-14          PIC  X(01).
               05  BD002-DAY-15          PIC  X(01).
               05  BD002-DAY-16          PIC  X(01).
               05  BD002-DAY-17          PIC  X(01).
               05  BD002-DAY-18          PIC  X(01).
               05  BD002-DAY-19          PIC  X(01).
               05  BD002-DAY-20          PIC  X(01).
               05  BD002-DAY-21          PIC  X(01).
               05  BD002-DAY-22          PIC  X(01).
               05  BD002-DAY-23          PIC  X(01).
               05  BD002-DAY-24          PIC  X(01).
               05  BD002-DAY-25          PIC  X(01).
               05  BD002-DAY-26          PIC  X(01).
               05  BD002-DAY-27          PIC  X(01).
               05  BD002-DAY-28          PIC  X(01).
               05  BD002-DAY-29          PIC  X(01).
               05  BD002-DAY-30          PIC  X(01).
               05  BD002-DAY-31          PIC  X(01).
           03  BD002-DAY-AREA-R          REDEFINES   BD002-DAY-AREA.
      *        ø«Œ≈≤ÛøÙ•∆°º•÷•Î
               05  BD002-DAY-TBL2.
                   07  BD002-DAY         PIC  X(01)
                                         OCCURS   31.
      * £øÙ≤ §ﬁ§»§·º± Ã≈¡…º»÷πÊ
           03  BD002-FUKU-DENPNUM        PIC  9(07).
      * £øÙ≤ §ﬁ§»§·∂Ë ¨° £±°ß∑—¬≥°°£≤°ß≥ŒƒÍ°À
           03  BD002-FUKU-KBN            PIC  X(01).
      *∫ﬂ¡Ìø«∂Ë ¨
           03  BD002-ZAITAKU             PIC  X(01).
      *ø«Œ≈∂Ë ¨ ÃµÎ…’≥∞≈¿øÙ
           03  BD002-KYUFUGAI.
               05  BD002-KYUFUGAI-TBL          OCCURS   6.
      *    µÎ…’¬–æ›≥∞≈¿øÙ
                   09  BD002-KYUFUGAI-TEN      PIC  9(07).
      *ø«Œ≈∂Ë ¨ ÃµÎ…’≥∞≈¿øÙ∫∆ƒÍµ¡
           03  BD002-KYUFUGAI-R      REDEFINES   BD002-KYUFUGAI.
      *µÎ…’¬–æ›≥∞≈¿øÙ° ΩÈø«°À
              05  BD002-KYUFUGAI-SHOSHIN-TEN    PIC  9(07).
      *µÎ…’¬–æ›≥∞≈¿øÙ° ªÿ∆≥°À
              05  BD002-KYUFUGAI-SIDOU-TEN      PIC  9(07).
      *µÎ…’¬–æ›≥∞≈¿øÙ° ±˝ø«°À
              05  BD002-KYUFUGAI-OSIN1-TEN      PIC  9(07).
      *µÎ…’¬–æ›≥∞≈¿øÙ° ±˝ø«°øÃÎ¥÷°À
              05  BD002-KYUFUGAI-OSIN2-TEN      PIC  9(07).
      *µÎ…’¬–æ›≥∞≈¿øÙ° ±˝ø«°øøºÃÎ°ø∂€µﬁ°À
              05  BD002-KYUFUGAI-OSIN3-TEN      PIC  9(07).
      *µÎ…’¬–æ›≥∞≈¿øÙ° πÁ∑◊°À
              05  BD002-KYUFUGAI-GOKEI-TEN      PIC  9(07).
      *∆¸ Ãº˝«º•’•È•∞
           03  BD002-DAYINFFLG           PIC  X(01).
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
      *      *
      *¥µº‘»÷πÊ
           03  BD002-PTNUM               PIC  X(20).
