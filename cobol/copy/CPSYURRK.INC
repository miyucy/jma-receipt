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
      *    º˝«ºÕ˙ŒÚ•ﬁ•π•ø  COPY (CPSYURRK.INC)                   *
      ************************************************************
      ************************************************************
      *  •≥•‘°º∂ÁΩ§¿µÕ˙ŒÚ
      * Maj/Min/Rev  Ω§¿µº‘       ∆¸…’      ∆‚Õ∆
      ************************************************************
      *01  SYURRK-REC.
           03  SYURRK-KEY.
      *∞ÂŒ≈µ°¥ÿ£…£ƒ
               05  SYURRK-HOSPNUM         PIC  S9(9) BINARY.
      *¥µº‘£…£ƒ
               05  SYURRK-PTID            PIC  9(10).
      *∆˛≥∞∂Ë ¨
               05  SYURRK-NYUGAIKBN       PIC  X(01).
      *≈¡…º»÷πÊ
               05  SYURRK-DENPNUM         PIC S9(9)   BINARY.
      *º˝«ºÕ˙ŒÚ»÷πÊ
               05  SYURRK-SYURRKNUM       PIC S9(9)   BINARY.
      *º˝«ºÕ˙ŒÚªﬁ»÷πÊ
               05  SYURRK-SYUEDANUM       PIC S9(9)   BINARY.
      *æı¬÷∂Ë ¨
               05  SYURRK-JOUTAIKBN       PIC  X(01).
      *ø«Œ≈≤ 
           03  SYURRK-SRYKA               PIC  X(02).
      * ›∏±¡»πÁ§ª»÷πÊ
           03  SYURRK-HKNCOMBINUM         PIC  X(04).
      *¿¡µ·∆‚Õ∆
           03  SYURRK-SKY-NAIYOU.
               05  SYURRK-SKY-TBL             OCCURS   16.
      *     ›∏±≈¿øÙ
                   09  SYURRK-HKNTEN      PIC S9(9)   BINARY.
      *    ∂‚≥€
                   09  SYURRK-MONEY       PIC S9(9)   BINARY.
      *    ≈¨Õ—≥∞∂‚≥€
                   09  SYURRK-TGMONEY     PIC S9(9)   BINARY.
      *    ≈¨Õ—≥∞∂‚≥€° æ√»Ò¿«§¢§Í°À
                   09  SYURRK-TGMONEY-TAX PIC S9(9)   BINARY.
      *¿¡µ·∆‚Õ∆
           03  SYURRK-SKY-NAIYOU-R        REDEFINES   SYURRK-SKY-NAIYOU.
      *ø«Œ≈Œ¡(01)
              05  SYURRK-SSU.
                  09  SYURRK-SSU-HKNTEN       PIC S9(9)   BINARY.
                  09  SYURRK-SSU-MONEY        PIC S9(9)   BINARY.
                  09  SYURRK-SSU-TGMONEY      PIC S9(9)   BINARY.
                  09  SYURRK-SSU-TGMONEY-TAX  PIC S9(9)   BINARY.
      *ªÿ∆≥Œ¡(02)
              05  SYURRK-SDO.
                  09  SYURRK-SDO-HKNTEN       PIC S9(9)   BINARY.
                  09  SYURRK-SDO-MONEY        PIC S9(9)   BINARY.
                  09  SYURRK-SDO-TGMONEY      PIC S9(9)   BINARY.
                  09  SYURRK-SDO-TGMONEY-TAX  PIC S9(9)   BINARY.
      *∫ﬂ¬Œ¡(03)
              05  SYURRK-ZTK.
                  09  SYURRK-ZTK-HKNTEN          PIC  S9(9)   BINARY.
                  09  SYURRK-ZTK-MONEY           PIC  S9(9)   BINARY.
                  09  SYURRK-ZTK-TGMONEY         PIC  S9(9)   BINARY.
                  09  SYURRK-ZTK-TGMONEY-TAX     PIC  S9(9)   BINARY.
      *≈ÍÃÙŒ¡(04)
              05  SYURRK-TYK.
                  09  SYURRK-TYK-HKNTEN          PIC  S9(9)   BINARY.
                  09  SYURRK-TYK-MONEY           PIC  S9(9)   BINARY.
                  09  SYURRK-TYK-TGMONEY         PIC  S9(9)   BINARY.
                  09  SYURRK-TYK-TGMONEY-TAX     PIC  S9(9)   BINARY.
      *√ÌºÕŒ¡(05)
              05  SYURRK-CSY.
                  09  SYURRK-CSY-HKNTEN          PIC  S9(9)   BINARY.
                  09  SYURRK-CSY-MONEY           PIC  S9(9)   BINARY.
                  09  SYURRK-CSY-TGMONEY         PIC  S9(9)   BINARY.
                  09  SYURRK-CSY-TGMONEY-TAX     PIC  S9(9)   BINARY.
      *ΩË√÷Œ¡(06)
              05  SYURRK-SYC.
                  09  SYURRK-SYC-HKNTEN          PIC  S9(9)   BINARY.
                  09  SYURRK-SYC-MONEY           PIC  S9(9)   BINARY.
                  09  SYURRK-SYC-TGMONEY         PIC  S9(9)   BINARY.
                  09  SYURRK-SYC-TGMONEY-TAX     PIC  S9(9)   BINARY.
      *ºÍΩ—Œ¡(07)
              05  SYURRK-SJT.
                  09  SYURRK-SJT-HKNTEN          PIC  S9(9)   BINARY.
                  09  SYURRK-SJT-MONEY           PIC  S9(9)   BINARY.
                  09  SYURRK-SJT-TGMONEY         PIC  S9(9)   BINARY.
                  09  SYURRK-SJT-TGMONEY-TAX     PIC  S9(9)   BINARY.
      *À„øÏ(08)
              05  SYURRK-MSI.
                  09  SYURRK-MSI-HKNTEN          PIC  S9(9)   BINARY.
                  09  SYURRK-MSI-MONEY           PIC  S9(9)   BINARY.
                  09  SYURRK-MSI-TGMONEY         PIC  S9(9)   BINARY.
                  09  SYURRK-MSI-TGMONEY-TAX     PIC  S9(9)   BINARY.
      *∏°∫∫Œ¡(09)
              05  SYURRK-KNS.
                  09  SYURRK-KNS-HKNTEN          PIC  S9(9)   BINARY.
                  09  SYURRK-KNS-MONEY           PIC  S9(9)   BINARY.
                  09  SYURRK-KNS-TGMONEY         PIC  S9(9)   BINARY.
                  09  SYURRK-KNS-TGMONEY-TAX     PIC  S9(9)   BINARY.
      *£ÿ¿˛Œ¡(10)
              05  SYURRK-GZU.
                  09  SYURRK-GZU-HKNTEN          PIC  S9(9)   BINARY.
                  09  SYURRK-GZU-MONEY           PIC  S9(9)   BINARY.
                  09  SYURRK-GZU-TGMONEY         PIC  S9(9)   BINARY.
                  09  SYURRK-GZU-TGMONEY-TAX     PIC  S9(9)   BINARY.
      *•Í•œ(11)
              05  SYURRK-ETC.
                  09  SYURRK-ETC-HKNTEN          PIC  S9(9)   BINARY.
                  09  SYURRK-ETC-MONEY           PIC  S9(9)   BINARY.
                  09  SYURRK-ETC-TGMONEY         PIC  S9(9)   BINARY.
                  09  SYURRK-ETC-TGMONEY-TAX     PIC  S9(9)   BINARY.
      *¿∫ø¿≤ ¿ÏÃÁŒ≈À°(12)
              05  SYURRK-SSN.
                  09  SYURRK-SSN-HKNTEN          PIC  S9(9)   BINARY.
                  09  SYURRK-SSN-MONEY           PIC  S9(9)   BINARY.
                  09  SYURRK-SSN-TGMONEY         PIC  S9(9)   BINARY.
                  09  SYURRK-SSN-TGMONEY-TAX     PIC  S9(9)   BINARY.
      * ¸ºÕ¿˛(13)
              05  SYURRK-HOU.
                  09  SYURRK-HOU-HKNTEN          PIC  S9(9)   BINARY.
                  09  SYURRK-HOU-MONEY           PIC  S9(9)   BINARY.
                  09  SYURRK-HOU-TGMONEY         PIC  S9(9)   BINARY.
                  09  SYURRK-HOU-TGMONEY-TAX     PIC  S9(9)   BINARY.
      *∆˛±°Œ¡(14)
              05  SYURRK-NYN.
                  09  SYURRK-NYN-HKNTEN          PIC  S9(9)   BINARY.
                  09  SYURRK-NYN-MONEY           PIC  S9(9)   BINARY.
                  09  SYURRK-NYN-TGMONEY         PIC  S9(9)   BINARY.
                  09  SYURRK-NYN-TGMONEY-TAX     PIC  S9(9)   BINARY.
      *Œ≈Õ‹√¥≈ˆºÍ≈ˆ(15)
              05  SYURRK-RYO.
                  09  SYURRK-RYO-HKNTEN          PIC  S9(9)   BINARY.
                  09  SYURRK-RYO-MONEY           PIC  S9(9)   BINARY.
                  09  SYURRK-RYO-TGMONEY         PIC  S9(9)   BINARY.
                  09  SYURRK-RYO-TGMONEY-TAX     PIC  S9(9)   BINARY.
      *πÁ∑◊  (16)
              05  SYURRK-TOTAL.
                  09  SYURRK-TOTAL-HKNTEN        PIC  S9(9)   BINARY.
                  09  SYURRK-TOTAL-MONEY         PIC  S9(9)   BINARY.
                  09  SYURRK-TOTAL-TGMONEY       PIC  S9(9)   BINARY.
                  09  SYURRK-TOTAL-TGMONEY-TAX   PIC  S9(9)   BINARY.
      *ΩË ˝§ª§ÛŒ¡∫∆∑«
           03  SYURRK-SHOHOU-SAI                 PIC  S9(9)   BINARY.
      * ›∏±≈¨Õ—≥∞∂‚≥€°›æ√»Ò¿«° ∫∆∑«°À
           03  SYURRK-TGMONEY-TAX-SAI            PIC  S9(9)   BINARY.
      *º´»Ò£±§´§È£±£∞
           03  SYURRK-JIHI-NAIYOU.
               05  SYURRK-JIHI-1              PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-1-TAX          PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-2              PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-2-TAX          PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-3              PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-3-TAX          PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-4              PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-4-TAX          PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-5              PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-5-TAX          PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-6              PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-6-TAX          PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-7              PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-7-TAX          PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-8              PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-8-TAX          PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-9              PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-9-TAX          PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-10             PIC  S9(9)   BINARY.
               05  SYURRK-JIHI-10-TAX         PIC  S9(9)   BINARY.
           03  SYURRK-JIHI-NAIYOU-R    REDEFINES  SYURRK-JIHI-NAIYOU.
               05  SYURRK-JIHI-TBL            OCCURS   10.
                 07  SYURRK-JIHI-TAXNASI      PIC  S9(9)   BINARY.
                 07  SYURRK-JIHI-TAXARI       PIC  S9(9)   BINARY.
      *º´»ÒæÆ∑◊° æ√»Ò¿«§ §∑°À
           03  SYURRK-JIHI-TOTAL          PIC  S9(9)   BINARY.
      *º´»ÒæÆ∑◊° æ√»Ò¿«§¢§Í°À
           03  SYURRK-JIHI-TOTAL-TAX      PIC  S9(9)   BINARY.
      *º´»Ò∂‚≥€æ√»Ò¿«
           03  SYURRK-JIHI-TAX            PIC  S9(9)   BINARY.
      *œ∑øÕ∞Ï…Ù…È√¥∂‚
           03  SYURRK-RJN-FTN             PIC  S9(9)   BINARY.
      *∏¯»Ò∞Ï…Ù…È√¥∂‚
           03  SYURRK-KOH-FTN             PIC  S9(9)   BINARY.
      *ÃÙ∫ﬁ∞Ï…Ù…È√¥∂‚
           03  SYURRK-YKZ-FTN             PIC  S9(9)   BINARY.
      *ƒ¥¿∞∂‚
           03  SYURRK-CHOSEI              PIC S9(9)   BINARY.
      * ›∏±≈¨Õ—∂‚≥€
           03  SYURRK-HKNTEKMONEY         PIC  S9(9)   BINARY.
      *…¬±°∏∫Ã»ªˆÕ≥∂Ë ¨
           03  SYURRK-DISCOUNT-KBN        PIC  X(02).
      *∏∫Ã»∂‚≥€
           03  SYURRK-DISCOUNT-MONEY      PIC  S9(9)   BINARY.
      *œ´∫“ ›∏±°›ΩÈø«Œ¡
           03  SYURRK-RSISHOSHIN-MONEY    PIC  S9(9)   BINARY.
      *œ´∫“ ›∏±°›∫∆ø«Œ¡
           03  SYURRK-RSISAISHIN-MONEY    PIC  S9(9)   BINARY.
      *œ´∫“ ›∏±°›ªÿ∆≥Œ¡
           03  SYURRK-RSISDO-MONEY        PIC  S9(9)   BINARY.
      *œ´∫“ ›∏±°›§Ω§Œ¬æ
           03  SYURRK-RSIETC-MONEY        PIC  S9(9)   BINARY.
      *œ´∫“ ›∏±°›æ√»Ò¿«° ∫∆∑«°À
           03  SYURRK-RSI-TAX-SAI         PIC  S9(9)   BINARY.
      *œ´∫“ ›∏±°›¥µº‘¿¡µ· ¨±ﬂ∑˙§∆πÁ∑◊≥€
           03  SYURRK-RSI-TOTAL           PIC  S9(9)   BINARY.
      *œ´∫“º´«Â°›¿¡µ·∂‚≥€° ∆¸∑◊…Ωµ≠∫‹Õ—°À
           03  SYURRK-RSIJIBAI-SKYMONEY   PIC  S9(9)   BINARY.
      *¿¡µ·∂‚≥€°›æ√»Ò¿«° ∫∆∑«°À
           03  SYURRK-SKYMONEY-TAX-SAI    PIC  S9(9)   BINARY.
      *¿¡µ·∂‚≥€
           03  SYURRK-SKYMONEY            PIC  S9(9)   BINARY.
      *ººŒ¡∫π≥€
           03  SYURRK-RMSAGAKU            PIC  S9(9)   BINARY.
      *ººŒ¡∫π≥€°›æ√»Ò¿«° ∫∆∑«°À
           03  SYURRK-RMSAGAKU-TAX-SAI    PIC  S9(9)   BINARY.
      *ø©ªˆŒ≈Õ‹»Ò°  ›∏±°À
           03  SYURRK-RYOYOHI-SKJ         PIC  S9(9)   BINARY.
      *ø©ªˆ…È√¥≥€°  ›∏±°ßº´∏ …È√¥°À
           03  SYURRK-SKYMONEY-SKJ        PIC  S9(9)   BINARY.
      *ø©ªˆ…È√¥≥€°  ›∏±°ßº´∏ …È√¥æ√»Ò¿«°À
           03  SYURRK-SKYMONEY-SKJ-TAX    PIC  S9(9)   BINARY.
      *ø©ªˆ…È√¥≥€°  ›∏±°ßº´∏ …È√¥πÁ∑◊°À
           03  SYURRK-SKYMONEY-SKJ-KEI    PIC  S9(9)   BINARY.
      *ø©ªˆŒ≈Õ‹»Ò° º´»Ò°À
           03  SYURRK-RYOYOHI-SKJ-JIHI    PIC  S9(9)   BINARY.
      *ø©ªˆ…È√¥≥€° º´»Ò°ßº´∏ …È√¥°À
           03  SYURRK-SKYMONEY-SKJ-JIHI   PIC  S9(9)   BINARY.
      *ø©ªˆ…È√¥≥€° º´»Ò°ßº´∏ …È√¥æ√»Ò¿«°À
           03  SYURRK-SKYMONEY-SKJ-JIHI-TAX    PIC  S9(9)   BINARY.
      *ø©ªˆ…È√¥≥€° º´»Ò°ßº´∏ …È√¥πÁ∑◊°À
           03  SYURRK-SKYMONEY-SKJ-JIHI-KEI    PIC  S9(9)   BINARY.
      *∆˛±°ª˛¿∏≥ËŒ≈Õ‹»Ò°  ›∏±°À
           03  SYURRK-RYOYOHI-LIFE             PIC  S9(9)   BINARY.
      *∆˛±°ª˛¿∏≥ËŒ≈Õ‹»Ò…È√¥≥€°  ›∏±°ßº´∏ …È√¥°À
           03  SYURRK-SKYMONEY-LIFE            PIC  S9(9)   BINARY.
      *∆˛±°ª˛¿∏≥ËŒ≈Õ‹»Ò…È√¥≥€°  ›∏±°ßº´∏ …È√¥æ√»Ò¿«°À
           03  SYURRK-SKYMONEY-LIFE-TAX        PIC  S9(9)   BINARY.
      *∆˛±°ª˛¿∏≥ËŒ≈Õ‹»Ò…È√¥≥€°  ›∏±°ßº´∏ …È√¥πÁ∑◊°À
           03  SYURRK-SKYMONEY-LIFE-KEI        PIC  S9(9)   BINARY.
      *∆˛±°ª˛¿∏≥ËŒ≈Õ‹»Ò»Ò° º´»Ò°À
           03  SYURRK-RYOYOHI-LIFE-JIHI        PIC  S9(9)   BINARY.
      *∆˛±°ª˛¿∏≥ËŒ≈Õ‹»Ò…È√¥≥€° º´»Ò°ßº´∏ …È√¥°À
           03  SYURRK-SKYMONEY-LIFE-JIHI       PIC  S9(9)   BINARY.
      *∆˛±°ª˛¿∏≥ËŒ≈Õ‹»Ò…È√¥≥€° º´»Ò°ßº´∏ …È√¥æ√»Ò¿«°À
           03  SYURRK-SKYMONEY-LIFE-JIHI-TAX
                                               PIC  S9(9)   BINARY.
      *∆˛±°ª˛¿∏≥ËŒ≈Õ‹»Ò…È√¥≥€° º´»Ò°ßº´∏ …È√¥πÁ∑◊°À
           03  SYURRK-SKYMONEY-LIFE-JIHI-KEI   PIC  S9(9)   BINARY.
      *√ºÀˆ£…£ƒ
           03  SYURRK-TERMID              PIC  X(16).
      *•™•⁄°º•Ï°º•ø£…£ƒ
           03  SYURRK-OPID                PIC  X(16).
      *∫Ó¿Æ«Ø∑Ó∆¸
           03  SYURRK-CREYMD              PIC  X(08).
      *ππø∑«Ø∑Ó∆¸
           03  SYURRK-UPYMD               PIC  X(08).
      *ππø∑ª˛¥÷
           03  SYURRK-UPHMS               PIC  X(06).
      *
