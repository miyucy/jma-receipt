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
      *    °õºþÍÑ¥Ç¡¼¥¿     COPY (CPPRTDATA.INC)                *
      ************************************************************
      ************************************************************
      *  ¥³¥Ô¡¼¶ç½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      ************************************************************
      *01  PRTDATA-REC.
      *
           03  PRTDATA-KEY.
      *£Ë£Å£Ù
               05  PRTDATA-TBL-KEY    PIC X(08).
      *Ï¢ÈÖ
               05  PRTDATA-RENNUM     PIC 9(04).
      *¥°¥ë¡¼¥×
               05  PRTDATA-TBL-GROUP  PIC X(14).
      *½èÍýÆâÏ¢ÈÖ
               05  PRTDATA-SHORI-RENNUM
                                      PIC 9(04).
      *¥·¥§¥ë£É£Ä
           03  PRTDATA-SHELLID        PIC X(20).
      *Ä¢É¼£É£Ä
           03  PRTDATA-PRTID          PIC X(20).
      *¿ÇÎÅÇ¯·î
           03  PRTDATA-SRYYM          PIC X(06).
      *ÀÁµáÇ¯·îÆü
           03  PRTDATA-SKYYMD         PIC X(08).
      *´µ¼Ô£É£Ä
           03  PRTDATA-PTID           PIC 9(10).
      *°õºþ½çÏ¢ÈÖ
           03  PRTDATA-PRIORITY       PIC 9(04).
      *ÊÇ
           03  PRTDATA-PAGE           PIC 9(05).
      *°õºþ¥Õ¥é¥°
           03  PRTDATA-PRTFLG         PIC X(01).
      *Ä¢É¼¥Ç¡¼¥¿
           03  PRTDATA-PRTDATA        PIC X(10000).
      *
      *¸¡º÷ÍÑ¹àÌÜ
           03  PRTDATAXX-STPAGE       PIC 9(05).
           03  PRTDATAXX-EDPAGE       PIC 9(05).    
