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
      *    Æü¼¡Åý·×ÍÑÆþ±¡¾ðÊó¼èÆÀ¥Ñ¥é¥á¥¿¡¡COPY (CPORCBT120SUB.INC)
      *                                »ÈÍÑ¥×¥í¥°¥é¥à (ORCBT120SUB.CBL)
      *    ÀßÄê¹àÌÜ
      *      °åÎÅµ¡´Ø£É£Ä
      *      ´µ¼Ô£É£Ä
      *      »»ÄêÇ¯·îÆü
      *      ¿ÇÎÅ²Ê
      ************************************************************
      ************************************************************
      *  ¥³¥Ô¡¼¶ç½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      ************************************************************
       01  ORCBT120SUB-AREA.
      *
      *°åÎÅµ¡´Ø£É£Ä
           03  LNK-ORCBT120SUB-HOSPID                  PIC  X(24).
      *´µ¼Ô£É£Ä
           03  LNK-ORCBT120SUB-PTID                    PIC  9(10).
      *»»ÄêÇ¯·îÆü
           03  LNK-ORCBT120SUB-SANTEIYMD               PIC  X(08).
      *¿ÇÎÅ²Ê¡Ê£°£°¡§Á´²Ê¤Ç¸ÇÄê¥»¥Ã¥È¡Ë
           03  LNK-ORCBT120SUB-SRYKA                   PIC  X(02).
      *¾ðÊóÊÖµÑ¹àÌÜ
           03  LNK-ORCBT120SUB-HENKYAKU-AREA.
      *°å»Õ¥³¡¼¥É
               05  LNK-ORCBT120SUB-DRCD                PIC  X(05).
      *ÆþÂà±¡¶èÊ¬¡Ê£±¡§ÅöÆüÆþ±¡¡¡£²¡§ÅöÆüÂà±¡¡¡£³¡§Æþ±¡Ãæ¡Ë
               05  LNK-ORCBT120SUB-NYUIN-KBN           PIC  9(01).
      *ÉÂÅïÈÖ¹æ
               05  LNK-ORCBT120SUB-BTUNUM              PIC  X(02).
      *ÉÂ¼¼ÈÖ¹æ
               05  LNK-ORCBT120SUB-BRMNUM              PIC  X(06).
      *Á°ÆüÉÂÅïÈÖ¹æ
               05  LNK-ORCBT120SUB-MAE-BTUNUM          PIC  X(02).
      *Á°ÆüÉÂ¼¼ÈÖ¹æ
               05  LNK-ORCBT120SUB-MAE-BRMNUM          PIC  X(06).
      *³°Çñ¶èÊ¬
               05  LNK-ORCBT120SUB-GAIHAKU-KBN         PIC  9(01).
      *¿©»ö¶èÊ¬
               05  LNK-ORCBT120SUB-SKJ-KBN             PIC  9(01).
      *Âà±¡»öÍ³
               05  LNK-ORCBT120SUB-TAIINCD             PIC  X(02).
      *Æþ±¡²Ê
               05  LNK-ORCBT120SUB-NYUINKA             PIC  X(02).
      *¥ì¥»ÅÅÆþ±¡²Ê
               05  LNK-ORCBT120SUB-RECENYUINKA         PIC  X(02).
      *Á°ÆüÆþ±¡²Ê
               05  LNK-ORCBT120SUB-MAE-NYUINKA         PIC  X(02).
      *Á°Æü¥ì¥»ÅÅÆþ±¡²Ê
               05  LNK-ORCBT120SUB-MAE-RECENYUINKA     PIC  X(02).
      *Æþ±¡ÊÝ¸±ÁÈ¹ç¤»ÈÖ¹æ
               05  LNK-ORCBT120SUB-NYU-HKNCOMBINUM     PIC  9(04).
      *¼ýÇ¼¾ðÊóÊÖµÑ¥¨¥ê¥¢
               05  LNK-ORCBT120SUB-SYU-AREA            OCCURS 10.
      *ÅÁÉ¼ÈÖ¹æ
                   07  LNK-ORCBT120SUB-DENPNUM         PIC  9(07).
      *ÅÁÉ¼¾õÂÖ¶èÊ¬
                   07  LNK-ORCBT120SUB-DENPJTIKBN      PIC  X(01).
      *ÅÁÉ¼ºîÀ®¶èÊ¬
                   07  LNK-ORCBT120SUB-CREATEKBN       PIC  9(07).
      *ÊÝ¸±ÅÀ¿ô
                   07  LNK-ORCBT120SUB-HKNTEN          PIC  9(07).
      *ÊÝ¸±ÉéÃ´¶â³Û
                   07  LNK-ORCBT120SUB-HKNMONEY        PIC  9(07).
      *ÊÝ¸±Å¬ÍÑ³°¶â³Û
                   07  LNK-ORCBT120SUB-TGMONEY         PIC  9(07).
      *ÊÝ¸±Å¬ÍÑ³°¶âÀÇ³Û
                   07  LNK-ORCBT120SUB-TGMONEY-TAX     PIC  9(07).
      *¼«Èñ¶â³Û
                   07  LNK-ORCBT120SUB-JIHI            PIC  9(07).
      *¼«ÈñÀÇ³Û
                   07  LNK-ORCBT120SUB-JIHI-TAX        PIC  9(07).
      *¿©»öÉéÃ´¶â³Û
                   07  LNK-ORCBT120SUB-SKJ             PIC  9(07).
      *¾ÃÈñÀÇ³Û
                   07  LNK-ORCBT120SUB-SKJ-TAX         PIC  9(07).
      *ÀÁµá¶â³Û
                   07  LNK-ORCBT120SUB-SKYMONEY        PIC  9(07).
      *ÊÝ¸±ÁÈ¹ç¤»ÈÖ¹æ
                   07  LNK-ORCBT120SUB-HKNCOMBINUM     PIC  9(04).
      *ÊÝ¸±ÈÖ¹æ
                   07  LNK-ORCBT120SUB-HKNNUM          PIC  X(03).
      *ÊÝ¸±£É£Ä
                   07  LNK-ORCBT120SUB-HKNID           PIC  9(10).
      *ÊÝ¸±¼ÔÈÖ¹æ
                   07  LNK-ORCBT120SUB-HKNJANUM        PIC  X(08).
      *ËÜ¿Í²ÈÂ²¶èÊ¬
                   07  LNK-ORCBT120SUB-HONKZKKBN       PIC  X(01).
      *Êä½õ¶èÊ¬
                   07  LNK-ORCBT120SUB-HOJOKBN         PIC  X(01).
      *·ÑÂ³¶èÊ¬
                   07  LNK-ORCBT120SUB-CONTKBN         PIC  X(01).
      *¸øÈñ¡ÝÉéÃ´¾ðÊó
                   07  LNK-ORCBT120SUB-KOHAREA.
      *¸øÈñ£±¡Ý¸øÈñÈÖ¹æ
                     09  LNK-ORCBT120SUB-KOH1HKNNUM    PIC  X(03).
      *¸øÈñ£±¡Ý¸øÈñ£É£Ä
                     09  LNK-ORCBT120SUB-KOH1ID        PIC  9(10).
      *¸øÈñ£±¡Ý»ÙÊ§¶èÊ¬
                     09  LNK-ORCBT120SUB-KOH1PAYKBN    PIC  X(02).
      *¸øÈñ£²¡Ý¸øÈñÈÖ¹æ
                     09  LNK-ORCBT120SUB-KOH2HKNNUM    PIC  X(03).
      *¸øÈñ£²¡Ý¸øÈñ£É£Ä
                     09  LNK-ORCBT120SUB-KOH2ID        PIC  9(10).
      *¸øÈñ£²¡Ý»ÙÊ§¶èÊ¬
                     09  LNK-ORCBT120SUB-KOH2PAYKBN    PIC  X(02).
      *¸øÈñ£³¡Ý¸øÈñÈÖ¹æ
                     09  LNK-ORCBT120SUB-KOH3HKNNUM    PIC  X(03).
      *¸øÈñ£³¡Ý¸øÈñ£É£Ä
                     09  LNK-ORCBT120SUB-KOH3ID        PIC  9(10).
      *¸øÈñ£³¡Ý»ÙÊ§¶èÊ¬
                     09  LNK-ORCBT120SUB-KOH3PAYKBN    PIC  X(02).
      *¸øÈñ£´¡Ý¸øÈñÈÖ¹æ
                     09  LNK-ORCBT120SUB-KOH4HKNNUM    PIC  X(03).
      *¸øÈñ£´¡Ý¸øÈñ£É£Ä
                     09  LNK-ORCBT120SUB-KOH4ID        PIC  9(10).
      *¸øÈñ£´¡Ý»ÙÊ§¶èÊ¬
                     09  LNK-ORCBT120SUB-KOH4PAYKBN    PIC  X(02).
      *¸øÈñ¡ÝÉéÃ´¾ðÊóºÆÄêµÁ
                   07  LNK-ORCBT120SUB-KOHFTN-TABLE  REDEFINES
                                        LNK-ORCBT120SUB-KOHAREA.
                     09  LNK-ORCBT120SUB-KOHFTN-TBL    OCCURS  4.
      *¸øÈñ¡Ý¸øÈñÈÖ¹æ
                       11  LNK-ORCBT120SUB-KOH-HKNNUM  PIC  X(03).
      *¸øÈñ¡Ý¸øÈñ£É£Ä
                       11  LNK-ORCBT120SUB-KOH-ID      PIC  9(10).
      *¸øÈñ¡Ý»ÙÊ§¶èÊ¬
                       11  LNK-ORCBT120SUB-KOH-PAYKBN  PIC  X(02).
      *Ï«ºÒÊÝ¸±¶èÊ¬
               05  LNK-ORCBT120SUB-RSIHKNKBN           PIC  X(01).
      *¼«ÇåÀÕÀÁµá
               05  LNK-ORCBT120SUB-JIBAIKBN            PIC  X(01).
      *
      *Éüµ¢¥³¡¼¥É¡Ê£±¡§»»ÄêÆü¥¨¥é¡¼¡¡£²¡§´µ¼Ô¸¡º÷¥¨¥é¡¼¡¡£³¡§¿ÇÎÅ²Ê¥¨¥é¡¼
      *            £´¡§Ì¤Æþ±¡¡¡£µ¡§¾ðÊó¼èÆÀ¥¨¥é¡¼¡Ë
           03  LNK-ORCBT120SUB-RC                    PIC S9(9) BINARY.