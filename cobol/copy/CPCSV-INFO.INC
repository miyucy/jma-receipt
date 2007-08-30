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
      *    £Ã£Ó£ÖÍÑ£Ä£Â                   (CPCSV-INFO.INC)       *
      ************************************************************
      ************************************************************
      *  ¥³¥Ô¡¼¶ç½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      ************************************************************
      *01  CSV-INFO-REC.
      *
          03  CSV-INFO-KEY.
      *
               05  CSV-INFO-HOSPNUM        PIC 9(2).
      *£Ë£Å£Ù
               05  CSV-INFO-TBL-KEY        PIC X(08).
      *¥·¥§¥ë£É£Ä
               05  CSV-INFO-SHELLID        PIC X(20).
      *½èÍýÆâÏ¢ÈÖ
               05  CSV-INFO-SHORI-RENNUM   PIC 9(03).
      *Ï¢ÈÖ
               05  CSV-INFO-RENNUM         PIC 9(03).
      *Ï¢ÈÖ
               05  CSV-INFO-SEQ-NO         PIC 9(06).
      *Æþ³°¶èÊ¬
           03  CSV-INFO-NYUGAIKBN          PIC X(01).
      *¿ÇÎÅÇ¯·î
           03  CSV-INFO-SRYYM              PIC X(06).
      *ÀÁµáÇ¯·îÆü
           03  CSV-INFO-SKYYMD             PIC X(08).
      *¿³ºº»ÙÊ§µ¡´Ø
           03  CSV-INFO-TEISYUTUSAKI       PIC X(01).
      *£Ð£Ô£É£Ä
           03  CSV-INFO-PTID               PIC 9(10).
      *£Ã£Ó£Ö¥Ç¡¼¥¿
           03  CSV-INFO-CSVDATA            PIC X(2000).
      *ºîÀ®Æü
           03  CSV-INFO-CREYMD             PIC X(08).
      *ºîÀ®»þ´Ö
           03  CSV-INFO-CREHMS             PIC X(06).
