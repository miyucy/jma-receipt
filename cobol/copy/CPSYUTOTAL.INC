      *******************************************************************
      * Project code name "ORCA"
      * Æü°åÉ¸½à¥ì¥»¥×¥È¥½¥Õ¥È¡ÊJMA standard receipt software¡Ë
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
      *    ¼ýÇ¼¹ç·×¥Þ¥¹¥¿         COPY (CPSYUTOTAL.INC)       *
      ************************************************************
      ************************************************************
      *  ¥³¥Ô¡¼¶ç½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      ************************************************************
      *01  SYUTTL-REC.
           03  SYUTTL-KEY.
      *°åÎÅµ¡´Ø£É£Ä
               05  SYUTTL-HOSPID          PIC  X(24).
      *Æþ³°¶èÊ¬
               05  SYUTTL-NYUGAIKBN       PIC  X(01).
      *´µ¼Ô£É£Ä
               05  SYUTTL-PTID            PIC  9(10).
      *ÅÁÉ¼ÈÖ¹æ
               05  SYUTTL-DENPNUM         PIC  9(07).
      *¿ÇÎÅ²Ê¡Ê¹ç·×Ê¬¤Î°Ù£°£°¤Ç¸ÇÄê¡Ë
           03  SYUTTL-SRYKA               PIC  X(02).
      *Æ±»þÆþÎÏ¿ÇÎÅ²Ê
           03  SYUTTL-DOUJI-SRYKA         PIC  X(02)
                                          OCCURS  10.
      *¿ÇÎÅÆü
           03  SYUTTL-SRYYMD              PIC  X(08).
      *ÅÁÉ¼¾õÂÖ¶èÊ¬
           03  SYUTTL-DENPJTIKBN          PIC  X(01).
      *ÅÁÉ¼ºîÀ®¶èÊ¬¡Ê¶õÇò¡§³°Íè¡¡£±¡§Âà±¡»þºîÀ®¡¡£²¡§Äê´üÀÁµá
      *              £³¡§Æþ±¡¥ì¥»¥×¥ÈÍÑ¥À¥ß¡¼¡Ë
           03  SYUTTL-CREATEKBN           PIC  X(01).
      *ÅÁÉ¼È¯¹ÔÆü
           03  SYUTTL-DENPPRTYMD          PIC  X(08).
      *ÀÁµá´ü´Ö
           03  SYUTTL-SKY-KIKAN.
      *ÀÁµá³«»ÏÆü
               05  SYUTTL-SKYSTYMD        PIC  X(08).
      *ÀÁµá½ªÎ»Æü
               05  SYUTTL-SKYEDYMD        PIC  X(08).
      *ÊÝ¸±ÁÈ¹ç¤»ÈÖ¹æ
           03  SYUTTL-HKNCOMBINUM         PIC  X(04).
      *¼çÊÝ¸±¡ÝÊÝ¸±ÈÖ¹æ
           03  SYUTTL-SYUHKNNUM           PIC  X(03).
      *¼çÊÝ¸±¡Ý´µ¼ÔÉéÃ´¶â³Û
           03  SYUTTL-SYUHKNFTNMONEY      PIC  9(07).
      *¼çÊÝ¸±¡Ý·×»»ÉéÃ´¶â
           03  SYUTTL-SYUCOMPFTN          PIC  9(07).
      *¼çÊÝ¸±¡Ý·×»»ÉéÃ´¶â¡Ê±ßÃ±°Ìµ­Ï¿ÍÑ¡Ë
           03  SYUTTL-SYUCOMPFTN-ENTANI   PIC  9(07)V9(01).
      *¼çÊÝ¸±¡Ý·×»»ÌôºÞ°ìÉôÉéÃ´¶â
           03  SYUTTL-SYUCOMPYKZFTN       PIC  9(07).
      *¼çÊÝ¸±¡Ý·×»»ÉéÃ´¶â·×
           03  SYUTTL-SYUCOMPTOTAL        PIC  9(07).
      *¼çÊÝ¸±¡ÝÌôºÞÉéÃ´¶èÊ¬
           03  SYUTTL-SYUYKZFTNKBN        PIC  X(01).
      *¸øÈñ¡ÝÉéÃ´¾ðÊó
           03  SYUTTL-KOH-AREA.
      *¸øÈñ£±¡ÝÊÝ¸±ÈÖ¹æ
               05  SYUTTL-KOH1HKNNUM          PIC  X(03).
      *¸øÈñ£±¡Ý´µ¼ÔÉéÃ´¶â³Û
               05  SYUTTL-KOH1HKNFTNMONEY     PIC  9(07).
      *¸øÈñ£±¡Ý·×»»ÉéÃ´¶â
               05  SYUTTL-KOH1COMPFTN         PIC  9(07).
      *¸øÈñ£±¡Ý·×»»ÉéÃ´¶â¡Ê±ßÃ±°Ìµ­Ï¿ÍÑ¡Ë
               05  SYUTTL-KOH1COMPFTN-ENTANI  PIC  9(07)V9(01).
      *¸øÈñ£±¡Ý·×»»ÌôºÞ°ìÉôÉéÃ´¶â
               05  SYUTTL-KOH1COMPYKZFTN      PIC  9(07).
      *¸øÈñ£±¡Ý·×»»ÉéÃ´¶â·×
               05  SYUTTL-KOH1COMPTOTAL       PIC  9(07).
      *¸øÈñ£±¡ÝÌôºÞÉéÃ´¶èÊ¬
               05  SYUTTL-KOH1YKZFTNKBN       PIC  X(01).
      *¸øÈñ£²¡ÝÊÝ¸±ÈÖ¹æ
               05  SYUTTL-KOH2HKNNUM          PIC  X(03).
      *¸øÈñ£²¡Ý´µ¼ÔÉéÃ´¶â³Û
               05  SYUTTL-KOH2HKNFTNMONEY     PIC  9(07).
      *¸øÈñ£²¡Ý·×»»ÉéÃ´¶â
               05  SYUTTL-KOH2COMPFTN         PIC  9(07).
      *¸øÈñ£²¡Ý·×»»ÉéÃ´¶â¡Ê±ßÃ±°Ìµ­Ï¿ÍÑ¡Ë
               05  SYUTTL-KOH2COMPFTN-ENTANI  PIC  9(07)V9(01).
      *¸øÈñ£²¡Ý·×»»ÌôºÞ°ìÉôÉéÃ´¶â
               05  SYUTTL-KOH2COMPYKZFTN      PIC  9(07).
      *¸øÈñ£²¡Ý·×»»ÉéÃ´¶â·×
               05  SYUTTL-KOH2COMPTOTAL       PIC  9(07).
      *¸øÈñ£²¡ÝÌôºÞÉéÃ´¶èÊ¬
               05  SYUTTL-KOH2YKZFTNKBN       PIC  X(01).
      *¸øÈñ£³¡ÝÊÝ¸±ÈÖ¹æ
               05  SYUTTL-KOH3HKNNUM          PIC  X(03).
      *¸øÈñ£³¡Ý´µ¼ÔÉéÃ´¶â³Û
               05  SYUTTL-KOH3HKNFTNMONEY     PIC  9(07).
      *¸øÈñ£³¡Ý·×»»ÉéÃ´¶â
               05  SYUTTL-KOH3COMPFTN         PIC  9(07).
      *¸øÈñ£³¡Ý·×»»ÉéÃ´¶â¡Ê±ßÃ±°Ìµ­Ï¿ÍÑ¡Ë
               05  SYUTTL-KOH3COMPFTN-ENTANI  PIC  9(07)V9(01).
      *¸øÈñ£³¡Ý·×»»ÌôºÞ°ìÉôÉéÃ´¶â
               05  SYUTTL-KOH3COMPYKZFTN      PIC  9(07).
      *¸øÈñ£³¡Ý·×»»ÉéÃ´¶â·×
               05  SYUTTL-KOH3COMPTOTAL       PIC  9(07).
      *¸øÈñ£³¡ÝÌôºÞÉéÃ´¶èÊ¬
               05  SYUTTL-KOH3YKZFTNKBN       PIC  X(01).
      *¸øÈñ£´¡ÝÊÝ¸±ÈÖ¹æ
               05  SYUTTL-KOH4HKNNUM          PIC  X(03).
      *¸øÈñ£´¡Ý´µ¼ÔÉéÃ´¶â³Û
               05  SYUTTL-KOH4HKNFTNMONEY     PIC  9(07).
      *¸øÈñ£´¡Ý·×»»ÉéÃ´¶â
               05  SYUTTL-KOH4COMPFTN         PIC  9(07).
      *¸øÈñ£´¡Ý·×»»ÉéÃ´¶â¡Ê±ßÃ±°Ìµ­Ï¿ÍÑ¡Ë
               05  SYUTTL-KOH4COMPFTN-ENTANI  PIC  9(07)V9(01).
      *¸øÈñ£´¡Ý·×»»ÌôºÞ°ìÉôÉéÃ´¶â
               05  SYUTTL-KOH4COMPYKZFTN      PIC  9(07).
      *¸øÈñ£´¡Ý·×»»ÉéÃ´¶â·×
               05  SYUTTL-KOH4COMPTOTAL       PIC  9(07).
      *¸øÈñ£´¡ÝÌôºÞÉéÃ´¶èÊ¬
               05  SYUTTL-KOH4YKZFTNKBN       PIC  X(01).
      *¸øÈñÉéÃ´¾ðÊóºÆÄêµÁ
           03  SYUTTL-KOHFTN-TABLE  REDEFINES   SYUTTL-KOH-AREA.
               05  SYUTTL-KOHFTN-TBL          OCCURS  4.
      *¸øÈñ¡ÝÊÝ¸±ÈÖ¹æ
                 07  SYUTTL-KOH-HKNNUM          PIC  X(03).
      *¸øÈñ¡Ý´µ¼ÔÉéÃ´¶â³Û
                 07  SYUTTL-KOH-HKNFTNMONEY     PIC  9(07).
      *¸øÈñ¡Ý·×»»ÉéÃ´¶â
                 07  SYUTTL-KOH-COMPFTN         PIC  9(07).
      *¸øÈñ¡Ý·×»»ÉéÃ´¶â¡Ê±ßÃ±°Ìµ­Ï¿ÍÑ¡Ë
                 07  SYUTTL-KOH-COMPFTN-ENTANI  PIC  9(07)V9(01).
      *¸øÈñ¡Ý·×»»ÌôºÞ°ìÉôÉéÃ´¶â
                 07  SYUTTL-KOH-COMPYKZFTN      PIC  9(07).
      *¸øÈñ¡Ý·×»»ÉéÃ´¶â·×
                 07  SYUTTL-KOH-COMPTOTAL       PIC  9(07).
      *¸øÈñ¡ÝÌôºÞÉéÃ´¶èÊ¬
                 07  SYUTTL-KOH-YKZFTNKBN       PIC  X(01).
      *´µ¼ÔÉéÃ´Î¨
           03  SYUTTL-PTFTNRATE           PIC  9(03).
      *ÀÁµá½ñºîÀ®¶èÊ¬
           03  SYUTTL-SKYKUKBN            PIC  X(01).
      *ÀÁµáÆâÍÆ
           03  SYUTTL-SKY-NAIYOU.
               05  SYUTTL-SKY-TBL             OCCURS   12.
      *    ÊÝ¸±ÅÀ¿ô
                   09  SYUTTL-HKNTEN          PIC  9(07).
      *    ¶â³Û
                   09  SYUTTL-MONEY           PIC  9(07).
      *    Å¬ÍÑ³°¶â³Û
                   09  SYUTTL-TGMONEY         PIC  9(07).
      *    Å¬ÍÑ³°¶â³Û¡Ê¾ÃÈñÀÇ¤¢¤ê¡Ë
                   09  SYUTTL-TGMONEY-TAX     PIC  9(07).
      *ÀÁµáÆâÍÆ
           03  SYUTTL-SKY-NAIYOU-R        REDEFINES   SYUTTL-SKY-NAIYOU.
      *¿ÇÎÅÎÁ(01)
              05  SYUTTL-SSU.
                  09  SYUTTL-SSU-HKNTEN          PIC  9(07).
                  09  SYUTTL-SSU-MONEY           PIC  9(07).
                  09  SYUTTL-SSU-TGMONEY         PIC  9(07).
                  09  SYUTTL-SSU-TGMONEY-TAX     PIC  9(07).
      *»ØÆ³ÎÁ(02)
              05  SYUTTL-SDO.
                  09  SYUTTL-SDO-HKNTEN          PIC  9(07).
                  09  SYUTTL-SDO-MONEY           PIC  9(07).
                  09  SYUTTL-SDO-TGMONEY         PIC  9(07).
                  09  SYUTTL-SDO-TGMONEY-TAX     PIC  9(07).
      *ºßÂðÎÁ(03)
              05  SYUTTL-ZTK.
                  09  SYUTTL-ZTK-HKNTEN          PIC  9(07).
                  09  SYUTTL-ZTK-MONEY           PIC  9(07).
                  09  SYUTTL-ZTK-TGMONEY         PIC  9(07).
                  09  SYUTTL-ZTK-TGMONEY-TAX     PIC  9(07).
      *ÅêÌôÎÁ(04)
              05  SYUTTL-TYK.
                  09  SYUTTL-TYK-HKNTEN          PIC  9(07).
                  09  SYUTTL-TYK-MONEY           PIC  9(07).
                  09  SYUTTL-TYK-TGMONEY         PIC  9(07).
                  09  SYUTTL-TYK-TGMONEY-TAX     PIC  9(07).
      *Ãí¼ÍÎÁ(05)
              05  SYUTTL-CSY.
                  09  SYUTTL-CSY-HKNTEN          PIC  9(07).
                  09  SYUTTL-CSY-MONEY           PIC  9(07).
                  09  SYUTTL-CSY-TGMONEY         PIC  9(07).
                  09  SYUTTL-CSY-TGMONEY-TAX     PIC  9(07).
      *½èÃÖÎÁ(06)
              05  SYUTTL-SYC.
                  09  SYUTTL-SYC-HKNTEN          PIC  9(07).
                  09  SYUTTL-SYC-MONEY           PIC  9(07).
                  09  SYUTTL-SYC-TGMONEY         PIC  9(07).
                  09  SYUTTL-SYC-TGMONEY-TAX     PIC  9(07).
      *¼ê½ÑÎÁ(07)
              05  SYUTTL-SJT.
                  09  SYUTTL-SJT-HKNTEN          PIC  9(07).
                  09  SYUTTL-SJT-MONEY           PIC  9(07).
                  09  SYUTTL-SJT-TGMONEY         PIC  9(07).
                  09  SYUTTL-SJT-TGMONEY-TAX     PIC  9(07).
      *¸¡ººÎÁ(08)
              05  SYUTTL-KNS.
                  09  SYUTTL-KNS-HKNTEN          PIC  9(07).
                  09  SYUTTL-KNS-MONEY           PIC  9(07).
                  09  SYUTTL-KNS-TGMONEY         PIC  9(07).
                  09  SYUTTL-KNS-TGMONEY-TAX     PIC  9(07).
      *£ØÀþÎÁ(09)
              05  SYUTTL-GZU.
                  09  SYUTTL-GZU-HKNTEN          PIC  9(07).
                  09  SYUTTL-GZU-MONEY           PIC  9(07).
                  09  SYUTTL-GZU-TGMONEY         PIC  9(07).
                  09  SYUTTL-GZU-TGMONEY-TAX     PIC  9(07).
      *¤½¤ÎÂ¾(10)
              05  SYUTTL-ETC.
                  09  SYUTTL-ETC-HKNTEN          PIC  9(07).
                  09  SYUTTL-ETC-MONEY           PIC  9(07).
                  09  SYUTTL-ETC-TGMONEY         PIC  9(07).
                  09  SYUTTL-ETC-TGMONEY-TAX     PIC  9(07).
      *Æþ±¡ÎÁ(11)
              05  SYUTTL-NYN.
                  09  SYUTTL-NYN-HKNTEN          PIC  9(07).
                  09  SYUTTL-NYN-MONEY           PIC  9(07).
                  09  SYUTTL-NYN-TGMONEY         PIC  9(07).
                  09  SYUTTL-NYN-TGMONEY-TAX     PIC  9(07).
      *¹ç·×  (12)
              05  SYUTTL-TOTAL.
                  09  SYUTTL-TOTAL-HKNTEN        PIC  9(07).
                  09  SYUTTL-TOTAL-MONEY         PIC  9(07).
                  09  SYUTTL-TOTAL-TGMONEY       PIC  9(07).
                  09  SYUTTL-TOTAL-TGMONEY-TAX   PIC  9(07).
      *ÊÝ¸±Å¬ÍÑ³°¶â³Û¡Ý¾ÃÈñÀÇ¡ÊºÆ·Ç¡Ë
           03  SYUTTL-TGMONEY-TAX-SAI         PIC  9(07).
      *¼«Èñ£±¤«¤é£µ
           03  SYUTTL-JIHI-NAIYOU.
               05  SYUTTL-JIHI-1              PIC  9(07). 
               05  SYUTTL-JIHI-1-TAX          PIC  9(07). 
               05  SYUTTL-JIHI-2              PIC  9(07). 
               05  SYUTTL-JIHI-2-TAX          PIC  9(07). 
               05  SYUTTL-JIHI-3              PIC  9(07). 
               05  SYUTTL-JIHI-3-TAX          PIC  9(07). 
               05  SYUTTL-JIHI-4              PIC  9(07). 
               05  SYUTTL-JIHI-4-TAX          PIC  9(07). 
               05  SYUTTL-JIHI-5              PIC  9(07). 
               05  SYUTTL-JIHI-5-TAX          PIC  9(07). 
           03  SYUTTL-JIHI-NAIYOU-R           REDEFINES
                                              SYUTTL-JIHI-NAIYOU.
               05  SYUTTL-JIHI-TBL            OCCURS   5.
                 07  SYUTTL-JIHI-TAXNASI        PIC  9(07).
                 07  SYUTTL-JIHI-TAXARI         PIC  9(07).
      *¼«Èñ¾®·×¡Ê¾ÃÈñÀÇ¤Ê¤·¡Ë
           03  SYUTTL-JIHI-TOTAL          PIC  9(07).
      *¼«Èñ¾®·×¡Ê¾ÃÈñÀÇ¤¢¤ê¡Ë
           03  SYUTTL-JIHI-TOTAL-TAX      PIC  9(07).
      *¼«Èñ¶â³Û¾ÃÈñÀÇ
           03  SYUTTL-JIHI-TAX            PIC  9(07).
      *Ï·¿Í°ìÉôÉéÃ´¶â
           03  SYUTTL-RJN-FTN             PIC  9(07).
      *¸øÈñ°ìÉôÉéÃ´¶â
           03  SYUTTL-KOH-FTN             PIC  9(07).
      *¸øÈñ°ìÉôÉéÃ´¶â¡Ê±ßÃ±°Ì¡Ë
           03  SYUTTL-KOH-FTN-ENTANI      PIC  9(07)V9(01).
      *Ä´À°¶â
           03  SYUTTL-CHOSEI              PIC S9(07).
      *¤Þ¤È¤áÆþÎÏº¹³Û
           03  SYUTTL-GRP-SGKMONEY        PIC S9(07).
      *ÊÝ¸±Å¬ÍÑ¶â³Û
           03  SYUTTL-HKNTEKMONEY         PIC  9(07).
      *ÉÂ±¡¸ºÌÈ»öÍ³¶èÊ¬
           03  SYUTTL-DISCOUNT-KBN        PIC  X(02).
      *ÉÂ±¡¸ºÌÈ»öÍ³
           03  SYUTTL-DISCOUNT-BODY       PIC  X(160).
      *³ä°úÎ¨¶èÊ¬
           03  SYUTTL-DISCOUNT-RATEKBN    PIC  X(02).
      *ÄêÎ¨Äê³Û¶èÊ¬
           03  SYUTTL-DISCOUNT-TEIRITU    PIC  X(01).
      *³ä°úÎ¨
           03  SYUTTL-DISCOUNT-RATE       PIC  9(07).
      *Ï«ºÒÊÝ¸±¡Ý½é¿ÇÎÁ
           03  SYUTTL-RSISHOSHIN-MONEY    PIC  9(07).
      *Ï«ºÒÊÝ¸±¡ÝºÆ¿ÇÎÁ
           03  SYUTTL-RSISAISHIN-MONEY    PIC  9(07).
      *Ï«ºÒÊÝ¸±¡Ý»ØÆ³ÎÁ
           03  SYUTTL-RSISDO-MONEY        PIC  9(07).
      *Ï«ºÒÊÝ¸±¡Ý¤½¤ÎÂ¾
           03  SYUTTL-RSIETC-MONEY        PIC  9(07).
      *Ï«ºÒÊÝ¸±¡Ý¾ÃÈñÀÇ¡ÊºÆ·Ç¡Ë
           03  SYUTTL-RSI-TAX-SAI         PIC  9(07).
      *Ï«ºÒÊÝ¸±¡Ý´µ¼ÔÀÁµáÊ¬±ß·ú¤Æ¹ç·×³Û
           03  SYUTTL-RSI-TOTAL           PIC  9(07).
      *Ï«ºÒ¼«Çå¡ÝÀÁµá¶â³Û¡ÊÆü·×É½µ­ºÜÍÑ¡Ë
           03  SYUTTL-RSIJIBAI-SKYMONEY   PIC  9(07).
      *ÀÁµá¶â³Û¡Ý¾ÃÈñÀÇ¡ÊºÆ·Ç¡Ë
           03  SYUTTL-SKYMONEY-TAX-SAI    PIC  9(07).
      *ÀÁµá¶â³Û
           03  SYUTTL-SKYMONEY            PIC  9(07).
      *Æþ¶â¹ç·×³Û
           03  SYUTTL-NYUKIN-TOTAL        PIC  9(07).
      *Æþ¶â²ó¿ô
           03  SYUTTL-NYUKIN-KAISU        PIC  9(07).
      *Ì¤¼ýÍýÍ³
           03  SYUTTL-MISYURIYU           PIC  X(02).
      *ºßÁí¿Ç¶èÊ¬
           03  SYUTTL-ZAITAKU             PIC  X(01).
      *¿ÇÎÅ¶èÊ¬ÊÌµëÉÕ³°ÅÀ¿ô
           03  SYUTTL-KYUFUGAI.
               05  SYUTTL-KYUFUGAI-TBL          OCCURS   6.
      *    µëÉÕÂÐ¾Ý³°ÅÀ¿ô
                   09  SYUTTL-KYUFUGAI-TEN      PIC  9(07).
      *¿ÇÎÅ¶èÊ¬ÊÌµëÉÕ³°ÅÀ¿ôºÆÄêµÁ
           03  SYUTTL-KYUFUGAI-R      REDEFINES   SYUTTL-KYUFUGAI.
      *µëÉÕÂÐ¾Ý³°ÅÀ¿ô¡Ê½é¿Ç¡Ë
              05  SYUTTL-KYUFUGAI-SHOSHIN-TEN    PIC  9(07).
      *µëÉÕÂÐ¾Ý³°ÅÀ¿ô¡Ê»ØÆ³¡Ë
              05  SYUTTL-KYUFUGAI-SIDOU-TEN      PIC  9(07).
      *µëÉÕÂÐ¾Ý³°ÅÀ¿ô¡Ê±ý¿Ç¡Ë
              05  SYUTTL-KYUFUGAI-OSIN1-TEN      PIC  9(07).
      *µëÉÕÂÐ¾Ý³°ÅÀ¿ô¡Ê±ý¿Ç¡¿Ìë´Ö¡Ë
              05  SYUTTL-KYUFUGAI-OSIN2-TEN      PIC  9(07).
      *µëÉÕÂÐ¾Ý³°ÅÀ¿ô¡Ê±ý¿Ç¡¿¿¼Ìë¡¿¶ÛµÞ¡Ë
              05  SYUTTL-KYUFUGAI-OSIN3-TEN      PIC  9(07).
      *µëÉÕÂÐ¾Ý³°ÅÀ¿ô¡Ê¹ç·×¡Ë
              05  SYUTTL-KYUFUGAI-GOKEI-TEN      PIC  9(07).
      *Ã¼Ëö£É£Ä
           03  SYUTTL-TERMID              PIC  X(16).
      *¥ª¥Ú¡¼¥ì¡¼¥¿£É£Ä
           03  SYUTTL-OPID                PIC  X(16).
      *ºîÀ®Ç¯·îÆü
           03  SYUTTL-CREYMD              PIC  X(08).
      *¹¹¿·Ç¯·îÆü
           03  SYUTTL-UPYMD               PIC  X(08).
      *¹¹¿·»þ´Ö
           03  SYUTTL-UPHMS               PIC  X(06).
      *
