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
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
       IDENTIFICATION      DIVISION.
       PROGRAM-ID.         ORCS01NEW.
      ****************************************************************
      *    OS           LINUX                                         
      *                                                               
      *    PROGRAM      ORCS01  /  ÉéÃ´¶â³Û»»Äê¥µ¥Ö                   
      *                          ¡Ê¿·Ï·¿ÍÊÝ¸±ÂÐ±þ¡Ë                   
      *  ´ÉÍý¼Ô            : 
      *  ºîÀ®ÆüÉÕ    ºî¶È¼Ô        µ­½Ò
      *  00/12/01    MCC¡Ý¾®Æ¦Âô   ¿·µ¬ºîÀ®
      ****************************************************************
      *  ¥×¥í¥°¥é¥à½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      *  01.00.01    MCC¡Ý¾®Æ¦Âô  01/06/05  ÌôºÞ°ìÉôÉéÃ´¶â¤Î»»Äê¥í¥¸¥Ã¥¯
      *                                     ½¤Àµ
      *  01.00.02    MCC¡Ý¾®Æ¦Âô  01/06/11  º£²óÀÁµá³Û¤ËÊÝ¸±Å¬ÍÑ³°¶â³Û¤Î
      *                                     ²Ã»»¤â¤ì
      *  01.00.03    MCC¡ÝÆ£¸¶    01/07/10  ÅêÌô¤Î¤È¤­ºÞ·¿¶èÊ¬¤Ç¤Þ¤È¤á¤ë
      *  01.00.04    MCC¡Ý¾®Æ¦Âô  01/08/08  ÌôºÞ°ìÉôÉéÃ´¶â¤Î»»Äê¥í¥¸¥Ã¥¯
      *                                     ½¤Àµ(¾å¸Â¥Á¥§¥Ã¥¯ÄÉ²Ã)
      *  01.00.05    MCC¡Ý¾®Æ¦Âô  01/10/17  ÌôºÞ°ìÉôÉéÃ´¶â¤Î»»Äê¥í¥¸¥Ã¥¯
      *                                     ½¤Àµ(ÆÖÉþÌôºÞ¤Î²ó¿ô¤ò£±¤Ë¥»¥Ã¥È)
      *  01.00.06    MCC¡Ý¾®Æ¦Âô  01/10/21  ÌôºÞ°ìÉôÉéÃ´¶â¤Î»»Äê¥í¥¸¥Ã¥¯
      *                                     ½¤Àµ(¾å¸Â¶â³Û¤Î»»½Ð¤ò½èÊýÌôºÞ¤Î
      *                                          ¹ç·×ÃÍ¤ËÊÑ¹¹)
      *  01.00.07    MCC¡Ý¾®Æ¦Âô  01/10/25  ÌôºÞ°ìÉôÉéÃ´¶â¤Î»»Äê¥í¥¸¥Ã¥¯
      *                                     ½¤Àµ(£Å£Ö£Á£Ì£Õ£Á£Ô£Å¤Î£×£È£Å£Î
      *                                          ¾ò·ï¤òÊÑ¹¹)
      *  01.00.08    MCC¡Ý¾®Æ¦Âô  02/01/09  ´µ¼ÔÉéÃ´Ìµ¤·¡¢ÌôºÞ°ìÉôÉéÃ´Í­¤ê
      *                                     ¤Î¸øÈñ»ÈÍÑ»þ¤ÎÀÁµá¶â³Û»»Äê¤ò½¤Àµ
      *  01.00.09    MCC¡Ý¾®Æ¦Âô  02/01/23  ÆâÉþÌôºÞº®¹ç»þ¤ÎÌôºÞ°ìÉôÉéÃ´¶â
      *                                     »»Äê¤ò½¤Àµ
      *  01.00.10    MCC¡Ý¾®Æ¦Âô  02/02/05  Ï·¿ÍÉéÃ´¤È¸øÈñÉéÃ´¤Î·×»»Á°¥¯¥ê¥¢
      *                                     ¤òÄÉ²Ã
      *  01.00.11    MCC¡Ý¾®Æ¦Âô  02/03/07  ÌôºÞ°ìÉôÉéÃ´¶â¤Î·×»»»þ¤ËºÞÅÀ¿ô¤¬
      *                                     £²£°ÅÀ¤Ç¤¢¤ì¤ÐÆ±°ìÌôºÞ¤Î¤Þ¤È¤á
      *                                     (¼ïÎà¿ô¤Î¥«¥¦¥ó¥È)¤ò¤·¤Ê¤¤¤è¤¦¤Ë
      *                                     ½¤Àµ
      *  01.00.12    MCC¡Ý¾®Æ¦Âô  02/02/12  Ï·¿Í£´£±ÊÝ¸±¤ÎÆþÎÏ»þ¤Ë¥ì¥»¥×¥È¤Î
      *                                     ´µ¼ÔÉéÃ´³Û¤ò£±£°±ßÌ¤Ëþ»Í¼Î¸ÞÆþ¤ò 
      *                                     ¹Ô¤Ê¤ï¤Ê¤¤¶â³Û¤Ë¤·¤¿
      *                                     (¸øÈñ£±¤Î¾å¸Â³Û¤¢¤ê¸ÂÄê¤ÇÄÉ²Ã)
      *  01.00.13    MCC¡Ý¾®Æ¦Âô  02/02/13  ´µ¼ÔÉéÃ´¶èÊ¬¤Ë£³¡§¸ÇÄê³Û¤òÄÉ²Ã
      *  01.00.14    MCC¡Ý¾®Æ¦Âô  02/04/12  Ï«ºÒÊÝ¸±ÂÐ±þ
      *                                     ºÆ·×»»»þ¤Ë¿ÇÎÅ¶èÊ¬Ëè¤ÎÅÀ¿ô½¸·×
      *                                     ¤«¤é±ß·ú¤Æ¹àÌÜÊ¬¤ÎÅÀ¿ô¤ò¸º»»¤¹¤ë
      *****************************************************************
       ENVIRONMENT         DIVISION.
       CONFIGURATION       SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                DIVISION.
       FILE                        SECTION.
      *
       WORKING-STORAGE SECTION.
      *
       01  WK-END                      PIC 9(08).
       01  STS-AREA.
           03  STS-SYUNOU              PIC X(02).
           03  STS-TSYRRK              PIC X(02).
           03  STS-TNKRRK              PIC X(02).
           03  STS-HKNNUM              PIC X(02).
           03  STS-HKNCOMBI            PIC X(02).
       01  SYURYO-YMD.
           03  SYURYO-YY               PIC 9(04).
           03  SYURYO-MM               PIC 9(02).
           03  SYURYO-DD               PIC 9(02).
       01  KEISAN-AREA.
           03  WK-KNJFTNKIN            PIC 9(10).
           03  WK-ZENGAKU              PIC 9(10).
           03  WK-FTNKIN1              PIC 9(10).
           03  WK-FTNKIN2              PIC 9(10).
           03  WK-FTNKIN3              PIC 9(10).
           03  WK-FUTANWARI            PIC 9V99.
           03  WK-SEIKYUGK             PIC 9(10).
           03  WK-YAKFTN-TENSUU        PIC 9(10).
           03  WK-GAIKFTNRATE          PIC 9(03).
           03  WK-GAIYKZFTNKBN         PIC X(01).
       01  SHOHOUSEN-AREA.
           03  FLG-INNAI               PIC X(01).
           03  FLG-INGAI               PIC X(01).
       01  WK-FLG.
           03  FLG-SYUNOU              PIC 9(01).
           03  FLG-TNKRRK              PIC 9(01).
           03  FLG-TSYRRK              PIC 9(01).
           03  FLG-HKNNUM              PIC 9(01).
           03  FLG-HKNCOMBI            PIC 9(01).
           03  FLG-SYSKANRI            PIC 9(01).
           03  FLG-PTINF               PIC 9(01).
           03  FLG-SANSHOU             PIC X(01).
           03  FLG-SANSHOU2            PIC X(01).
           03  FLG-SANTEI1             PIC X(01).
           03  FLG-SANTEI2             PIC X(01).
           03  FLG-SANTEI3             PIC X(01).
           03  FLG-SANTEI4             PIC X(01).
           03  FLG-FTNKIN1             PIC X(01).
           03  FLG-FTNKIN2             PIC X(01).
           03  FLG-FTNKIN3             PIC X(01).
           03  FLG-SHOHOZUMI           PIC X(01).
           03  FLG-YAKFTN              PIC X(01).
      *----(01.00.03) LINE ADD START --------------------------
           03  FLG-ZAIGATAKBN          PIC 9(01).
           03  FLG-TENSU               PIC 9(01).
           03  FLG-ADDKBN              PIC 9(01). 
      *----(01.00.03) LINE ADD END   --------------------------
           03  FLG-LOCALRJN            PIC 9(01).
      *
           03  WK-ERR                  PIC 9(01).
           03  WK-UERR                 PIC 9(01).
           03  WK-PAYKBN               PIC X(02).
      *
      *    ÊÝ¸±¶èÊ¬¡Ê¶õÇò¡§°åÊÝ¡¡£±¡§Ï«ºÒ¡¡£²¡§¼«ÇåÀÕ¡Ë
           03  WK-HKNKBN               PIC X(01).
      *
      *    ´µ¼ÔÉéÃ´·×»»»þ¤Î»Í¼Î¸ÞÆþÍÑ¥ï¡¼¥¯
           03  WK-FTN                  PIC 9(10).
      *
      *    ÉÂ±¡³ä°ú³Û·×»»»þ¤Î³ä°úÎ¨ÍÑ¥ï¡¼¥¯
           03  WK-RATE                 PIC 9(1)V9(2).
      *
      *    ¸øÈñ¤Î´µ¼ÔÉéÃ´¾å¸Â²ó¿ô¤È¾å¸Â¶â³Û¤ÎÂàÈòÍÑ¥¨¥ê¥¢
       01  HOKEN-MAX-AREA.
           03  MAX-KAI-KOHI1-D         PIC 9(05).
           03  MAX-KAI-KOHI2-D         PIC 9(05).
           03  MAX-KAI-KOHI3-D         PIC 9(05).
           03  MAX-KAI-KOHI4-D         PIC 9(05).
           03  MAX-KAI-KOHI1-M         PIC 9(05).
           03  MAX-KAI-KOHI2-M         PIC 9(05).
           03  MAX-KAI-KOHI3-M         PIC 9(05).
           03  MAX-KAI-KOHI4-M         PIC 9(05).
           03  MAX-KIN-KOHI1-D         PIC 9(08).
           03  MAX-KIN-KOHI2-D         PIC 9(08).
           03  MAX-KIN-KOHI3-D         PIC 9(08).
           03  MAX-KIN-KOHI4-D         PIC 9(08).
           03  MAX-KIN-KOHI1-M         PIC 9(08).
           03  MAX-KIN-KOHI2-M         PIC 9(08).
           03  MAX-KIN-KOHI3-M         PIC 9(08).
           03  MAX-KIN-KOHI4-M         PIC 9(08).
      *
      *    ¸øÈñ¤Î»ÈÍÑ²ó¿ô¥«¥¦¥ó¥ÈÍÑ¥¨¥ê¥¢
       01  HOKEN-KAISU-AREA.
           03  KAISU-KOHI1-D           PIC 9(05).
           03  KAISU-KOHI2-D           PIC 9(05).
           03  KAISU-KOHI3-D           PIC 9(05).
           03  KAISU-KOHI4-D           PIC 9(05).
           03  KAISU-KOHI1-M           PIC 9(05).
           03  KAISU-KOHI2-M           PIC 9(05).
           03  KAISU-KOHI3-M           PIC 9(05).
           03  KAISU-KOHI4-M           PIC 9(05).
      *
       01  HOKEN-KAISU-TABLE.
           03  HOKEN-KAISU-TBL         OCCURS  32.
               05  KOHI1-TBL           PIC 9(02).
               05  KOHI2-TBL           PIC 9(02).
               05  KOHI3-TBL           PIC 9(02).
               05  KOHI4-TBL           PIC 9(02).
      *
      *    ¸øÈñ¤Î´µ¼ÔÉéÃ´ºÑ¤ß¶â³Û¤Î²Ã»»ÍÑ¥¨¥ê¥¢
       01  HOKEN-FUTAN-AREA.
           03  FTN-KOHI1-D             PIC 9(08).
           03  FTN-KOHI2-D             PIC 9(08).
           03  FTN-KOHI3-D             PIC 9(08).
           03  FTN-KOHI4-D             PIC 9(08).
           03  FTN-KOHI1-M             PIC 9(08).
           03  FTN-KOHI2-M             PIC 9(08).
           03  FTN-KOHI3-M             PIC 9(08).
           03  FTN-KOHI4-M             PIC 9(08).
      *
      *    ¸øÈñ¤Î´µ¼ÔÉéÃ´²ÄÇ½¤Ê»Ä³Û»»ÄêÍÑ¥¨¥ê¥¢
       01  HOKEN-ZAN-AREA.
           03  ZAN-KOHI1-D             PIC 9(08).
           03  ZAN-KOHI2-D             PIC 9(08).
           03  ZAN-KOHI3-D             PIC 9(08).
           03  ZAN-KOHI4-D             PIC 9(08).
           03  ZAN-KOHI1-M             PIC 9(08).
           03  ZAN-KOHI2-M             PIC 9(08).
           03  ZAN-KOHI3-M             PIC 9(08).
           03  ZAN-KOHI4-M             PIC 9(08).
           03  ZAN-KOHI-AREA.
             05  ZAN-KOHI1             PIC 9(08).
             05  ZAN-KOHI2             PIC 9(08).
             05  ZAN-KOHI3             PIC 9(08).
             05  ZAN-KOHI4             PIC 9(08).
           03  ZAN-KOHI-TBL  REDEFINES  ZAN-KOHI-AREA
                                        OCCURS  4.
             05  ZAN-KOHI-T            PIC 9(08).
      *
      *    ´µ¼ÔÇ¯Îð»»½ÐÍÑ¥¨¥ê¥¢
       01  WRK-NENREI-AREA.
           03  WRK-NENREI              PIC 9(03).
           03  WRK-YMDS1.
               05  WRK-YYS1            PIC 9(04).
               05  WRK-MMS1            PIC 9(02).
               05  WRK-DDS1            PIC 9(02).
           03  WRK-YMDS2.
               05  WRK-YYS2            PIC 9(04).
               05  WRK-MMS2            PIC 9(02).
               05  WRK-DDS2            PIC 9(02).
      *
      *    ÌôºÞ°ìÉôÉéÃ´¶â¡Ê¸øÈñÊÌ·×»»¡ËÂàÈòÎÎ°è
       01  WK-YAKFTN.
           03  WK-SYU-YAKFTN           PIC 9(08).
           03  WK-KOH-YAKFTN-AREA.
             05  WK-KOH1-YAKFTN        PIC 9(08).
             05  WK-KOH2-YAKFTN        PIC 9(08).
             05  WK-KOH3-YAKFTN        PIC 9(08).
             05  WK-KOH4-YAKFTN        PIC 9(08).
           03  WK-KOH-YAKFTN-TBL    REDEFINES  WK-KOH-YAKFTN-AREA
                                               OCCURS  4.
             05  WK-KOH-YAKFTN-T       PIC 9(08).
                                                
      *
      *    ÌôºÞ°ìÉôÉéÃ´¶â·×»»¥¨¥ê¥¢
       01  YAKFTN-AREA.
      *
      *        ¥Ñ¥é¥á¥¿¤«¤é¤Î¼õ¤±¼è¤êÍÑ¡ÊÊ£¿ôÊÝ¸±ÁÈ¹ç¤»ÍÑ¡Ë
           03  LNK-S02-TBL         OCCURS   40.
               07  LNK-S02-SRYKBN       PIC  X(02).
               07  LNK-S02-ZAIBAN       PIC  9(08).
               07  LNK-S02-SRYCD        PIC  X(09).
               07  LNK-S02-SURYOU       PIC  9(05)V9(03).
               07  LNK-S02-KAISUU       PIC  9(03).
               07  LNK-S02-TENSUU       PIC  9(07).
      *
      *        ¥Ñ¥é¥á¥¿¤«¤é¤Î¼õ¤±¼è¤êÍÑ
           03  YAKFTN-TABLE.
               05  YAKFTN-TBL-OCC       OCCURS  40.
                   07  YAKFTN-KEY.
                       09  YAKFTN-SRYKBN
                                          PIC X(02).
                       09  YAKFTN-SRYCD   PIC X(09).
                   07  YAKFTN-ZAIBAN      PIC 9(08).
                   07  YAKFTN-TENSUU      PIC 9(07).
                   07  YAKFTN-KAISUU-TABLE.
                       09  YAKFTN-KAISUU  PIC 9(02)  OCCURS 180.
                   07  YAKFTN-MAX         PIC 9(03).
           03  YAKFTN-TABLE2.
               05  YAKFTN-TBL-OCC2       OCCURS  40.
                   07  YAKFTN-KEY2.
                       09  YAKFTN-SRYKBN2
                                          PIC X(02).
                       09  YAKFTN-SRYCD2   PIC X(09).
                       09  YAKFTN-ZAIBAN2  PIC 9(08).
                   07  YAKFTN-TENSUU2      PIC 9(07).
                   07  YAKFTN-KAISUU-TABLE2.
                       09  YAKFTN-KAISUU2  PIC 9(02)  OCCURS 180.
                   07  YAKFTN-MAX2         PIC 9(03).
      *
      *        ºÞÈÖ¹æÊÌÌôºÞ¿ô·×»»ÍÑ
           03  YAKFTN-ZAI-TABLE.
               05  YAKFTN-ZAI-TBL-OCC   OCCURS  40.
                   07  YAKFTN-ZAI-SRYKBN
                                        PIC X(02).
                   07  YAKFTN-ZAI-SRYCD PIC X(09).
                   07  YAKFTN-ZAI-ZAIBAN
                                        PIC 9(08).
                   07  YAKFTN-ZAI-TENSUU
                                        PIC 9(07).
                   07  YAKFTN-ZAI-KAISUU-TABLE.
                       09  YAKFTN-ZAI-KAISUU
                                        PIC 9(02)    OCCURS 180.
                   07  YAKFTN-ZAI-MAX   PIC 9(03).
      *        °ìÆü½èÊýÊ¬¤ÎÌôºÞ·×»»ÍÑ
           03  YAKFTN-TOTAL-TABLE.
               05  YAKFTN-TOTAL-TBL-OCC   OCCURS   3.
                   07  YAKFTN-TOTAL-KAISUU  PIC  9(2)  OCCURS  180.
      *
      *        ÊÂ¤ÓÂØ¤¨ÍÑ¥ï¡¼¥¯
           03  WK-SRT-YAKFTN-TABLE.
               05  WK-SRT-YAKFTN-KEY.
                   07  WK-SRT-YAKFTN-SRYKBN     PIC X(02).
                   07  WK-SRT-YAKFTN-SRYCD      PIC X(09).
               05  WK-SRT-YAKFTN-ZAIBAN         PIC 9(08).
               05  WK-SRT-YAKFTN-TENSUU         PIC 9(07).
               05  WK-SRT-YAKFTN-KAISUU         PIC 9(02)  OCCURS 180.
               05  WK-SRT-YAKFTN-MAX            PIC 9(03).
      *
           03  WK-KEY-SRY.
               05  WK-KEY-SRYKBN          PIC X(02).
               05  WK-KEY-SRYCD           PIC X(09).
           03  WK-KEY-ZAIBAN              PIC 9(08).  
      *
      *        ÉþÍÑ´ü´ÖÊÔ½¸ÍÑ¥ï¡¼¥¯
           03  WK-KAISUU-TABLE.
               05  WK-KAISUU           PIC 9(02)    OCCURS 180.
           03  WK-ZAI-KAISUU-TABLE.
               05  WK-ZAI-KAISUU       PIC 9(02)    OCCURS 180.
           03  WK-KINGAK               PIC 9(07).
           03  YAKFTN-SOGOKEI          PIC 9(07).
           03  WK-FUTAN                PIC 9(05).
           03  YAKFTN-JOUGEN           PIC 9(07).
      *
      *    ÊÝ¸±ÊÑ¹¹»þ¤Î·ÑÂ³ÆþÎÏÍÑ¤ÎÌôºÞ°ìÉôÉéÃ´¶âÎÎ°è
           03  WK-CONT-YAKFTNAREA.
               05  WK-CONT-YAKFTNKIN1  PIC 9(07).
               05  WK-CONT-YAKFTNKIN2  PIC 9(07).
      *
      *----(01.00.04) LINE ADD START --------------------------
           03  WK-KBNBETSU-YAKUZAI.
               05  WK-TOYAKU-TENSU     PIC 9(10)    OCCURS  4.
           03  WK-TOYAKU-ZAIBAN-AREA   OCCURS  40.
               05  WK-TOYAKU-SRYKBN    PIC X(02).
               05  WK-TOYAKU-ZAIBAN    PIC 9(08).
               05  WK-TOYAKU-ZAITEN    PIC 9(07).
           03  WK-NAI-FUTAN            PIC 9(05).
           03  WK-TON-FUTAN            PIC 9(05).
           03  WK-GAI-FUTAN            PIC 9(05).
      *----(01.00.04) LINE ADD END   --------------------------
      *
      *    Åº¤¨»úÎÎ°è
       01  IDX-AREA.
           03  IDX                     PIC  9(02)  VALUE  ZERO.
           03  IDX2X                   PIC  X(02).
           03  IDX2R                   REDEFINES    IDX2X.
               05  IDX2                PIC  9(02).
           03  Y-IDX                   PIC  9(03)  VALUE  ZERO.
           03  Y-IDX2                  PIC  9(03)  VALUE  ZERO.
           03  Y-IDX3                  PIC  9(03)  VALUE  ZERO.
           03  Y-IDX4                  PIC  9(03)  VALUE  ZERO.
           03  Y-IDX5                  PIC  9(03)  VALUE  ZERO.
           03  HKNGAI-IDX              PIC  9(02)  VALUE  ZERO.
           03  DSP-IDX                 PIC  9(02)  VALUE  ZERO.
           03  DSP-IDX2                PIC  9(02)  VALUE  ZERO.
           03  KOH-IDX                 PIC  9(02)  VALUE  ZERO.
      *****************************************************************
      *    ¥Õ¥¡¥¤¥ë¥ì¥¤¥¢¥¦¥È
      *****************************************************************
      *
      *    ¼ýÇ¼¥Þ¥¹¥¿¡¼
       01  SYU-SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    Äã½êÆÀ¼ÔÍúÎò
       01  TSYRRK-REC.
           COPY    "CPTSYRRK.INC".
      *
      *    Ç¯¶âÍúÎò
       01  TNKRRK-REC.
           COPY    "CPTNKRRK.INC".
      *
      *    ÊÝ¸±ÁÈ¤ß¹ç¤ï¤»
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    ÊÝ¸±ÈÖ¹æ
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    ÅÀ¿ô
           COPY    "CPTENSU.INC".
      *
      *    ¥·¥¹¥Æ¥à´ÉÍý
           COPY    "CPSK1001.INC".
           COPY    "CPSK1026.INC".
           COPY    "CPSK1027.INC".
           COPY    "CPSK4001.INC".
      *
      *    ´µ¼Ô¾ðÊó
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *****************************************************************
      *    ¥µ¥Ö¥×¥íÍÑ¡¡ÎÎ°è
      *****************************************************************
      *
      *    £Ä£Â¸¡º÷
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      /
      ***
       LINKAGE             SECTION.
           COPY  "MCPAREA". 
           COPY  "CPORCS01.INC".
       01  LNK-SYU-SYUNOU-REC.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-// BY //LNK-SYU-//.
      /
       PROCEDURE           DIVISION  USING
                                     MCPAREA
                                     LNK-ORCS01-REC
                                     LNK-SYU-SYUNOU-REC.
      ******************************************************************
      *        °ÍÍêÀ©¸æ½èÍý
      ******************************************************************
       MAIN-RTN            SECTION.
       MAIN-000.
           MOVE    ZERO            TO  LNK-S01-RC.
           MOVE    SPACE           TO  KEISAN-AREA.
           INITIALIZE                  KEISAN-AREA.
           MOVE    ZERO            TO  LNK-SYU-RJN-FTN
                                       LNK-SYU-KOH-FTN
                                       LNK-SYU-YKZ-FTN.
           MOVE    ZERO            TO  LNK-SYU-SYUHKNFTNMONEY
                                       LNK-SYU-SYUCOMPFTN
                                       LNK-SYU-SYUCOMPYKZFTN
                                       LNK-SYU-SYUCOMPTOTAL
           MOVE    SPACE    TO  LNK-SYU-SYUYKZFTNKBN.
           PERFORM   VARYING   IDX   FROM   1    BY   1
             UNTIL   IDX   >   4
                  MOVE    ZERO     TO  LNK-SYU-KOH-HKNFTNMONEY(IDX)
                                       LNK-SYU-KOH-COMPFTN(IDX)
                                       LNK-SYU-KOH-COMPYKZFTN(IDX)
                                       LNK-SYU-KOH-COMPTOTAL(IDX)
                  MOVE    SPACE    TO  LNK-SYU-KOH-YKZFTNKBN(IDX)
                                       
           END-PERFORM.
      *
      *    ÊÝ¸±ÁÈ¹ç¤»¥Þ¥¹¥¿¤Î»²¾ÈÉôÊ¬³ÎÄê
           PERFORM   100-KAKUTEI-SEC.
      *
      *    ÊÝ¸±ÁÈ¹ç¤»¥Þ¥¹¥¿¤Î¸¡º÷
           INITIALIZE                           HKNCOMBI-REC.
           MOVE    LNK-SYU-HOSPID       TO      COMB-HOSPID.
           MOVE    LNK-SYU-PTID         TO      COMB-PTID.
           MOVE    LNK-SYU-HKNCOMBINUM  TO      COMB-HKNCOMBINUM.
           MOVE    HKNCOMBI-REC         TO      MCPDATA-REC.
           MOVE    "DBSELECT"           TO      MCP-FUNC.
           MOVE    "HKNCOMBI-KEY"       TO      ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC.
           IF      MCP-RC               =       ZERO
               MOVE    "HKNCOMBI-KEY"   TO      ORC-DBPATH 
               PERFORM   HKNCOMBI-READ-SEC
               IF      FLG-HKNCOMBI     =       1
                   MOVE    "DBCLOSE"        TO      MCP-FUNC
                   MOVE    "HKNCOMBI-KEY"   TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING   MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                   DISPLAY "HKNCOMBI DBFETCH ERR"
                   MOVE     10          TO      LNK-S01-RC
                   GO   TO              MAIN-EXT
               END-IF
           ELSE
               MOVE    "DBCLOSE"        TO      MCP-FUNC
               MOVE    "HKNCOMBI-KEY"   TO      ORC-DBPATH
               CALL    "ORCMCPSUB"       USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
               MOVE    1                TO      FLG-HKNCOMBI
               DISPLAY "HKNCOMBI DBSELECT ERR"
               MOVE     10              TO      LNK-S01-RC
               GO   TO                  MAIN-EXT
           END-IF.
           MOVE    "DBCLOSE"            TO      MCP-FUNC.
           MOVE    "HKNCOMBI-KEY"       TO      ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC.
      *
      *    ÊÝ¸±ÁÈ¹ç¤»¥Þ¥¹¥¿¤«¤é¼çÊÝ¸±¤ÎÊÝ¸±¼ïÎà¤òÈ½Äê
      *    ¡Ê¶õÇò¡§°åÊÝ¡¢£±¡§Ï«ºÒ¡¢£²¡§¼«Çå¡Ë
           MOVE     SPACE               TO       WK-HKNKBN.
           EVALUATE    COMB-SYU-HKNKOHSBTKBN
               WHEN    "4"
                       MOVE    "1"      TO       WK-HKNKBN
           END-EVALUATE.
      *
      *    ÌôºÞ°ìÉôÉéÃ´¶â¤Î·×»»½èÍý
           MOVE         ZERO              TO     LNK-SYU-YKZ-FTN.
           MOVE         ZERO              TO     LNK-SYU-RESE-YKZ-FTN.
           PERFORM      YAKFTN-SANTEI-SEC.
           EVALUATE     FLG-SANSHOU
               WHEN     "1"
                   IF  COMB-GAI-YKZFTNKBN      NOT =   "0"
                       MOVE   YAKFTN-SOGOKEI   TO  LNK-SYU-RESE-YKZ-FTN
                       IF     COMB-GAI-YKZFTNKBN     =   "1"
                            MOVE   YAKFTN-SOGOKEI  TO  LNK-SYU-YKZ-FTN
                       END-IF
                   END-IF
               WHEN     "2"
                   IF  COMB-TSY-GAIYKZFTNKBN   NOT =   "0"
                       MOVE   YAKFTN-SOGOKEI   TO  LNK-SYU-RESE-YKZ-FTN
                       IF   COMB-TSY-GAIYKZFTNKBN  =   "1"
                            MOVE   YAKFTN-SOGOKEI  TO  LNK-SYU-YKZ-FTN
                       END-IF
                   END-IF
               WHEN     "3"
                   IF  COMB-TNK-GAIYKZFTNKBN   NOT =   "0"
                       MOVE   YAKFTN-SOGOKEI   TO  LNK-SYU-RESE-YKZ-FTN
                       IF   COMB-TNK-GAIYKZFTNKBN  =   "1"
                            MOVE   YAKFTN-SOGOKEI  TO  LNK-SYU-YKZ-FTN
                       END-IF
                   END-IF
           END-EVALUATE.
      *
      *    ´µ¼ÔÉéÃ´³Û¤Î»»Äê
           PERFORM       200-HKNFTN-SANTEI-SEC
           EVALUATE      FLG-SANSHOU
               WHEN      "1"
                   IF   (COMB-GAI-FTNKBN       =    "2")    AND
                        (COMB-GAI-YKZFTNKBN    =    "2")
                         MOVE   ZERO        TO   WK-KNJFTNKIN
                                                 LNK-SYU-SKYMONEY
                   END-IF
               WHEN      "2"
                   IF   (COMB-TSY-GAIFTNKBN    =    "2")    AND
                        (COMB-TSY-GAIYKZFTNKBN =    "2")
                         MOVE   ZERO        TO   WK-KNJFTNKIN
                                                 LNK-SYU-SKYMONEY
                   END-IF
               WHEN      "3"
                   IF   (COMB-TNK-GAIFTNKBN    =    "2")    AND
                        (COMB-TNK-GAIYKZFTNKBN =    "2")
                         MOVE   ZERO        TO   WK-KNJFTNKIN
                                                 LNK-SYU-SKYMONEY
                   END-IF
           END-EVALUATE.
           EVALUATE      FLG-SANSHOU
               WHEN      "1"
                   IF    COMB-GAI-YKZFTNKBN    =    "0"   OR  "3"
                         MOVE   ZERO        TO      LNK-SYU-YKZ-FTN
                   END-IF
               WHEN      "2"
                   IF    COMB-TSY-GAIYKZFTNKBN    =    "0"   OR  "3"
                         MOVE   ZERO        TO      LNK-SYU-YKZ-FTN
                   END-IF
               WHEN      "3"
                   IF    COMB-TNK-GAIYKZFTNKBN    =    "0"   OR  "3"
                         MOVE   ZERO        TO      LNK-SYU-YKZ-FTN
                   END-IF
           END-EVALUATE.
      *
      *    »»½ÐÀÁµá³Û¤Î£±£°±ßÌ¤Ëþ»Í¼Î¸ÞÆþ¡ÊÌôºÞ°ìÉôÉéÃ´¶â¤â´Þ¤à¡Ë
      *    ¢¨Ï«ºÒÊÝ¸±¤Î¾ì¹ç¤Ï»Í¼Î¸ÞÆþ¤ò¹Ô¤ï¤Ê¤¤
           IF     (LNK-SYU-SKYMONEY      NOT =   ZERO)   OR
                  (LNK-SYU-YKZ-FTN       NOT =   ZERO)
               IF   WK-HKNKBN            NOT =   "1"
                   COMPUTE  LNK-SYU-SKYMONEY = LNK-SYU-SKYMONEY  +
                                               LNK-SYU-YKZ-FTN
                   COMPUTE  LNK-SYU-SKYMONEY = LNK-SYU-SKYMONEY  +  5
                   COMPUTE  WK-SEIKYUGK      = LNK-SYU-SKYMONEY  /  10
                   COMPUTE  LNK-SYU-SKYMONEY = WK-SEIKYUGK       *  10
               ELSE
                   COMPUTE  LNK-SYU-SKYMONEY = LNK-SYU-SKYMONEY  +
                                               LNK-SYU-YKZ-FTN
               END-IF 
           END-IF.
      *
      *    ¼çÊÝ¸±¡¦Ï·¿Í¡¦¸øÈñ¤ÎÈ½ÊÌ
      *      ¡Ê¼çÊÝ¸±¡Ë
           IF     (LNK-SYU-SYUHKNNUM     NOT =   SPACE)    AND
                  (LNK-SYU-KOH1HKNNUM    =       SPACE)    AND
                  (LNK-SYU-KOH2HKNNUM    =       SPACE)    AND
                  (LNK-SYU-KOH3HKNNUM    =       SPACE)    AND
                  (LNK-SYU-KOH4HKNNUM    =       SPACE)
                   MOVE   LNK-SYU-SKYMONEY   TO   LNK-SYU-HKNTEKMONEY
                   IF     LNK-SYU-YKZ-FTN    NOT =   ZERO
                          COMPUTE  LNK-SYU-HKNTEKMONEY  =
                                   LNK-SYU-HKNTEKMONEY  -
                                   LNK-SYU-YKZ-FTN
                   END-IF
           END-IF.
      *       ¡ÊÏ·¿Í¡Ë 
      *
           IF     (LNK-SYU-KOH1HKNNUM    =   SPACE)    AND
                  (LNK-SYU-KOH2HKNNUM    =   SPACE)    AND
                  (LNK-SYU-KOH3HKNNUM    =   SPACE)    AND
                  (LNK-SYU-KOH4HKNNUM    =   SPACE)
                   CONTINUE
           ELSE
               IF      COMB-KOH1-HKNKOHSBTKBN    =       "3"
                  IF  (COMB-KOH2-HKNKOHSBTKBN    =     SPACE)  AND
                      (COMB-KOH3-HKNKOHSBTKBN    =     SPACE)  AND
                      (COMB-KOH4-HKNKOHSBTKBN    =     SPACE)
                       MOVE   LNK-SYU-SKYMONEY   TO   LNK-SYU-RJN-FTN
                  ELSE
      *            ¡Ê¸øÈñ¡Ë
                       MOVE   LNK-SYU-SKYMONEY   TO   LNK-SYU-KOH-FTN
                       IF     LNK-SYU-YKZ-FTN    NOT =   ZERO
                           IF   LNK-SYU-KOH-FTN  >    LNK-SYU-YKZ-FTN
                               COMPUTE  LNK-SYU-KOH-FTN  =
                                        LNK-SYU-KOH-FTN  -
                                        LNK-SYU-YKZ-FTN
                           ELSE
                               MOVE     ZERO     TO   LNK-SYU-KOH-FTN
                           END-IF               
                       END-IF
                  END-IF
               ELSE
      *            ¡Ê¸øÈñ¡Ë
                       MOVE   LNK-SYU-SKYMONEY   TO   LNK-SYU-KOH-FTN
                       IF     LNK-SYU-YKZ-FTN    NOT =   ZERO
                           IF   LNK-SYU-KOH-FTN  >    LNK-SYU-YKZ-FTN
                               COMPUTE  LNK-SYU-KOH-FTN  =
                                        LNK-SYU-KOH-FTN  -
                                        LNK-SYU-YKZ-FTN
                           ELSE
                               MOVE     ZERO     TO   LNK-SYU-KOH-FTN
                           END-IF               
                       END-IF
               END-IF
           END-IF.
      *
      *    ¼«Èñ¶â³Û¤Î¾ÃÈñÀÇ·×»»
           COMPUTE   LNK-SYU-JIHI-TOTAL =  (LNK-SYU-JIHI-TAXNASI(1)  +
                                            LNK-SYU-JIHI-TAXNASI(2)  +
                                            LNK-SYU-JIHI-TAXNASI(3)  +
                                            LNK-SYU-JIHI-TAXNASI(4)  +
                                            LNK-SYU-JIHI-TAXNASI(5)).
           COMPUTE   LNK-SYU-JIHI-TOTAL-TAX = (LNK-SYU-JIHI-TAXARI(1) +
                                               LNK-SYU-JIHI-TAXARI(2) +
                                               LNK-SYU-JIHI-TAXARI(3) +
                                               LNK-SYU-JIHI-TAXARI(4) +
                                               LNK-SYU-JIHI-TAXARI(5)).
           COMPUTE   LNK-SYU-JIHI-TAX = LNK-SYU-JIHI-TOTAL-TAX * 0.05.
      *
      *----(01.00.02) LINE ADD START -------------------------------
      *    ÊÝ¸±Å¬ÍÑ³°¶â³Û¤Î²Ã»»
           MOVE       ZERO              TO  LNK-SYU-TGMONEY(12).
           MOVE       ZERO              TO  LNK-SYU-TGMONEY-TAX(12).
           PERFORM    VARYING   HKNGAI-IDX   FROM   1   BY   1
                      UNTIL     HKNGAI-IDX   >     11
                      ADD       LNK-SYU-TGMONEY(HKNGAI-IDX)
                                            TO  LNK-SYU-TGMONEY(12)
                      ADD       LNK-SYU-TGMONEY-TAX(HKNGAI-IDX)
                                        TO  LNK-SYU-TGMONEY-TAX(12)
           END-PERFORM.
      *----(01.00.02) LINE ADD START -------------------------------
      *    ÀÁµá¶â³Û¤Î·×»»¡ÊÄ´À°¶â´Þ¤Þ¤º¡Ë
           COMPUTE    LNK-SYU-SKYMONEY  =   LNK-SYU-SKYMONEY    +
      *----(01.00.02) LINE ADD START -------------------------------
                                            LNK-SYU-TGMONEY(12) +
      *----(01.00.02) LINE ADD START -------------------------------
                                            LNK-SYU-TGMONEY-TAX(12) +
                                            LNK-SYU-JIHI-TOTAL  +
                                            LNK-SYU-JIHI-TOTAL-TAX  +
                                            LNK-SYU-JIHI-TAX.
      *    ÉÂ±¡¸ºÌÈ¤Î·×»»
           IF     LNK-SYU-SKYMONEY      NOT =   ZERO
               IF   LNK-S01-SAIKEISAN-KBN    =   "1"
                   IF   LNK-SYU-DISCOUNT-RATEKBN  NOT = SPACE AND  "00"
                        EVALUATE  LNK-SYU-DISCOUNT-TEIRITU
                            WHEN  "1"
                                MOVE    ZERO    TO   WK-RATE
                                COMPUTE  WK-RATE  =
                                        (100 - LNK-SYU-DISCOUNT-RATE) /
                                         100
                                COMPUTE  LNK-SYU-SKYMONEY  =
                                         LNK-SYU-SKYMONEY  *
                                         WK-RATE
                                COMPUTE  LNK-SYU-SKYMONEY  =
                                         LNK-SYU-SKYMONEY  +  5
                                COMPUTE  LNK-SYU-SKYMONEY  =
                                         LNK-SYU-SKYMONEY  / 10
                                COMPUTE  LNK-SYU-SKYMONEY  =
                                         LNK-SYU-SKYMONEY  * 10
                            WHEN  "2"
                                IF    LNK-SYU-DISCOUNT-RATE  >=
                                                     LNK-SYU-SKYMONEY
                                    MOVE  ZERO  TO  LNK-SYU-SKYMONEY
                                ELSE
                                    COMPUTE    LNK-SYU-SKYMONEY  =
                                               LNK-SYU-SKYMONEY  -
                                               LNK-SYU-DISCOUNT-RATE
                                END-IF
                        END-EVALUATE
                   END-IF
               ELSE
                   INITIALIZE                           PTINF-REC
                   MOVE    LNK-SYU-HOSPID       TO      PTINF-HOSPID
                   MOVE    LNK-SYU-PTID         TO      PTINF-PTID
                   MOVE    PTINF-REC            TO      MCPDATA-REC
                   MOVE    "DBSELECT"           TO      MCP-FUNC
                   MOVE    "PTINF-KEY"          TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"           USING   MCPAREA
                                                         ORCMCPAREA
                                                         MCPDATA-REC
                   IF      MCP-RC               =       ZERO
                       MOVE    "PTINF-KEY"      TO      ORC-DBPATH
                       PERFORM  PTINF-READ-SEC
                       IF       MCP-RC          =       ZERO
                           PERFORM   GENMEN-KEISAN-SEC
                       ELSE
                           DISPLAY  "PTINF FETCH ERR"
                       END-IF
                   ELSE
                       DISPLAY   "PTINF SELECT ERR"
                   END-IF
      *
                   MOVE    "DBCLOSE"            TO  MCP-FUNC
                   MOVE    "PTINF-KEY"          TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"           USING
                                                 MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
               END-IF
           END-IF.
      *
      *    ÀÁµá¶â³Û¤Î·×»»¡ÊÏ«ºÒÊÝ¸±Å¬ÍÑ»þ¤Î±ß·ú¤Æ¹àÌÜ²Ã»»¡Ë
           IF    WK-HKNKBN         =       "1"
             IF  COMB-GAI-FTNKBN   =       "1"
               COMPUTE  LNK-SYU-SKYMONEY =  LNK-SYU-SKYMONEY         +
                                            LNK-SYU-RSISHOSHIN-MONEY +
                                            LNK-SYU-RSISAISHIN-MONEY +
                                            LNK-SYU-RSISDO-MONEY     +
                                            LNK-SYU-RSIETC-MONEY
             END-IF
           END-IF.
      *
      *    ÀÁµá¶â³Û¤Î·×»»¡ÊÄ´À°¶â¤Î²Ã¸º»»¡Ë
           COMPUTE    LNK-SYU-SKYMONEY  =   LNK-SYU-SKYMONEY    +
                                            LNK-SYU-CHOSEI.
      *
       MAIN-EXT.
           EXIT PROGRAM
           STOP RUN.
      ******************************************************************
      *        ÉÂ±¡¸ºÌÈ·×»»½èÍý                                    *
      ******************************************************************
       GENMEN-KEISAN-SEC          SECTION.
      *
           MOVE    SPACE                TO      FLG-SANSHOU.
      *
           IF   PTINF-DISCOUNT  NOT =   SPACE  AND  "00"
               INITIALIZE                         SYS-1026-REC
               MOVE    "1026"               TO    SYS-1026-KANRICD
               MOVE    PTINF-DISCOUNT-KBN   TO    SYS-1026-KBNCD
               MOVE    LNK-SYU-SRYYMD       TO    ORC-DBYMD
               MOVE    SYS-1026-REC         TO    MCPDATA-REC
               MOVE    "DBSELECT"           TO    MCP-FUNC
               MOVE    "SYSKANRI-KEY"       TO    ORC-DBPATH
               CALL    "ORCMCPSUB"    USING        MCPAREA
                                                   ORCMCPAREA
                                                   MCPDATA-REC
               IF      MCP-RC               =     ZERO
                   MOVE     "SYSKANRI-KEY"  TO    ORC-DBPATH
                   PERFORM   SYSKANRI-READ-SEC
                   IF    MCP-RC             =     ZERO
                       MOVE   SYS-1026-KBNCD  TO  LNK-SYU-DISCOUNT-KBN
                       MOVE   SYS-1026-DISCOUNT-BODY
                                              TO  LNK-SYU-DISCOUNT-BODY
                   END-IF
               END-IF
      *
               MOVE    "DBCLOSE"            TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
      *
               INITIALIZE                         SYS-1027-REC
               MOVE    "1027"               TO    SYS-1027-KANRICD
               MOVE    PTINF-DISCOUNT       TO    SYS-1027-KBNCD
               MOVE    LNK-SYU-SRYYMD       TO    ORC-DBYMD
               MOVE    SYS-1027-REC         TO    MCPDATA-REC
               MOVE    "DBSELECT"           TO    MCP-FUNC
               MOVE    "SYSKANRI-KEY"       TO    ORC-DBPATH
               CALL    "ORCMCPSUB"    USING       MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
               IF      MCP-RC               =     ZERO
                   MOVE     "SYSKANRI-KEY"  TO    ORC-DBPATH
                   PERFORM   SYSKANRI-READ-SEC
                   IF    MCP-RC             =     ZERO
                       EVALUATE  SYS-1027-TEIRITU
                           WHEN  "1"
                               MOVE    ZERO    TO   WK-RATE
                               COMPUTE  WK-RATE  =  
                                        (100 - SYS-1027-DISCOUNT-RATE)
                                        /  100
                               COMPUTE    LNK-SYU-SKYMONEY  =
                                          LNK-SYU-SKYMONEY  *
                                          WK-RATE
                               COMPUTE    LNK-SYU-SKYMONEY  =
                                          LNK-SYU-SKYMONEY  +  5
                               COMPUTE    LNK-SYU-SKYMONEY  =
                                          LNK-SYU-SKYMONEY  / 10
                               COMPUTE    LNK-SYU-SKYMONEY  =
                                          LNK-SYU-SKYMONEY  * 10
                           WHEN  "2"
                               IF   SYS-1027-DISCOUNT-RATE >= 
                                                     LNK-SYU-SKYMONEY
                                    MOVE    ZERO   TO   LNK-SYU-SKYMONEY
                               ELSE
                                    COMPUTE    LNK-SYU-SKYMONEY  =
                                               LNK-SYU-SKYMONEY  -
                                               SYS-1027-DISCOUNT-RATE
                               END-IF
                       END-EVALUATE
                       MOVE   SYS-1027-KBNCD   TO
                                               LNK-SYU-DISCOUNT-RATEKBN
                       MOVE   SYS-1027-TEIRITU TO
                                               LNK-SYU-DISCOUNT-TEIRITU
                       MOVE  SYS-1027-DISCOUNT-RATE  TO
                                               LNK-SYU-DISCOUNT-RATE
                   END-IF
               END-IF
      *
               MOVE    "DBCLOSE"            TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
           END-IF.
      *
       GENMEN-KEISAN-EXT.
           EXIT.
      ******************************************************************
      *        ÊÝ¸±»²¾ÈÉôÊ¬³ÎÄê½èÍý                                    *
      ******************************************************************
       100-KAKUTEI-SEC          SECTION.
      *
           MOVE    SPACE                TO      FLG-SANSHOU.
      *
           INITIALIZE                           TNKRRK-REC.
           MOVE    LNK-SYU-HOSPID       TO      TNKRRK-HOSPID.
           MOVE    LNK-SYU-PTID         TO      TNKRRK-PTID.
           MOVE    TNKRRK-REC           TO      MCPDATA-REC.
           MOVE    "DBSELECT"           TO      MCP-FUNC.
           MOVE    "TNKRRK-KEY2"        TO      ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC.
           IF      MCP-RC               =       ZERO
               MOVE    "TNKRRK-KEY2"    TO      ORC-DBPATH
               PERFORM  TNKRRK-READ-SEC
               PERFORM  UNTIL
                          (FLG-TNKRRK     =    1)    OR
                          (TNKRRK-STYMD   <=   LNK-SYU-SRYYMD)  AND
                          (LNK-SYU-SRYYMD <=   TNKRRK-EDYMD)
                   PERFORM   TNKRRK-READ-SEC
               END-PERFORM
           ELSE
               MOVE    1                TO      FLG-TNKRRK
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "TNKRRK-KEY2"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
      *
           INITIALIZE                           TSYRRK-REC.
           MOVE    LNK-SYU-HOSPID       TO      TSYRRK-HOSPID.
           MOVE    LNK-SYU-PTID         TO      TSYRRK-PTID.
           MOVE    TSYRRK-REC           TO      MCPDATA-REC.
           MOVE    "DBSELECT"           TO      MCP-FUNC.
           MOVE    "TSYRRK-KEY2"        TO      ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC.
           IF      MCP-RC               =       ZERO
               MOVE    "TSYRRK-KEY2"    TO      ORC-DBPATH
               PERFORM  TSYRRK-READ-SEC
               PERFORM  UNTIL
                       (FLG-TSYRRK      =    1)    OR
                       (TSYRRK-NINSTYMD <=   LNK-SYU-SRYYMD)  AND
                       (LNK-SYU-SRYYMD  <=   TSYRRK-NINEDYMD)
                   PERFORM   TSYRRK-READ-SEC
               END-PERFORM
           ELSE
               MOVE    1                TO      FLG-TSYRRK
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "TSYRRK-KEY2"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
      *
           EVALUATE    FLG-TSYRRK       ALSO     FLG-TNKRRK
               WHEN    1                ALSO     0
               WHEN    1                ALSO     1
                       MOVE     "1"     TO       FLG-SANSHOU
               WHEN    0                ALSO     1
                       MOVE     "2"     TO       FLG-SANSHOU
               WHEN    0                ALSO     0
                       MOVE     "3"     TO       FLG-SANSHOU
           END-EVALUATE.
      *
      *    ¸øÈñÉéÃ´ÉôÊ¬¸¡º÷ÍÑ¤Î»²¾ÈÉôÊ¬¥»¥Ã¥È¡ÊËÜ¿Í¤Ç¸ÇÄê¡Ë
           MOVE       "1"       TO    FLG-SANSHOU2.
      *
       100-KAKUTEI-EXT.
           EXIT.
      ******************************************************************
      *        ÊÝ¸±ÉéÃ´³Û»»Äê½èÍý                                      *
      ******************************************************************
       200-HKNFTN-SANTEI-SEC          SECTION.
      *
           MOVE    SPACE                 TO    SHOHOUSEN-AREA
                                               HOKEN-MAX-AREA
                                               HOKEN-KAISU-AREA
                                               HOKEN-KAISU-TABLE
                                               HOKEN-FUTAN-AREA
                                               HOKEN-ZAN-AREA
                                               WK-YAKFTN.
           INITIALIZE                          SHOHOUSEN-AREA
                                               HOKEN-MAX-AREA
                                               HOKEN-KAISU-AREA
                                               HOKEN-KAISU-TABLE
                                               HOKEN-FUTAN-AREA
                                               HOKEN-ZAN-AREA
                                               WK-YAKFTN.
      *
      *    ´µ¼ÔÉéÃ´¶â»»½ÐÁ°¤Î£±£°£°¡óÉéÃ´³Û»»½Ð
           MOVE      ZERO         TO      WK-ZENGAKU.
           PERFORM   VARYING   IDX     FROM    1   BY  1
                     UNTIL     IDX         >   11
               COMPUTE WK-ZENGAKU  =   WK-ZENGAKU  +
                                      (LNK-SYU-HKNTEN (IDX) * 10)
           END-PERFORM.
      *
      *    ÊÝ¸±ÈÖ¹æ¥Æ¡¼¥Ö¥ë¤«¤é¸øÈñ¤ÎÉéÃ´¾å¸Â²ó¿ô¤È¾å¸Â¶â³Û¤Î¼èÆÀ
           PERFORM         210-HOKEN-KAISU-SEC.
      *
      *    ¿ÇÎÅ·îÆâ¤Î¼ýÇ¼¥Þ¥¹¥¿¤«¤é¸øÈñËè¤Î»ÈÍÑ²ó¿ô¤È´µ¼ÔÉéÃ´¶â³Û¤Î
      *    Îß·×¤òÄ´ºº
           PERFORM         220-SYUNOU-SEC.
      *
      *    ÊÝ¸±¡¦¸øÈñ¤ÎÉéÃ´¶â·×»»
           PERFORM         230-FTNKIN-SEC.
      *
       200-HKNFTN-SANTEI-EXT.
           EXIT.
      *
      ******************************************************************
      *        ÊÝ¸±¡¦¸øÈñ¤ÎÀßÄê¾å¸Â²ó¿ô¤È¾å¸Â¶â³Û¤Î¼èÆÀ                *
      ******************************************************************
       210-HOKEN-KAISU-SEC           SECTION.
      *
      *    °åÎÅµ¡´Ø¤Ç¤ÎÏ·¿ÍÊÝ¸±ÉéÃ´¼ïÊÌ¤ò¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿¤è¤ê¼èÆÀ
           IF    (COMB-KOH1-HKNKOHSBTKBN   =   "3")   OR
                 (COMB-KOH2-HKNKOHSBTKBN   =   "3")   OR
                 (COMB-KOH3-HKNKOHSBTKBN   =   "3")   OR
                 (COMB-KOH4-HKNKOHSBTKBN   =   "3")
               PERFORM    2101-ROUJIN-HKN-HANTEI-SEC
           END-IF.
      *
      *    °åÎÅµ¡´Ø¤¬¿ÇÎÅ½ê¤Î¾ì¹ç¡¢³ºÅö´µ¼Ô¤Î³ºÅö·î¤Ë±¡³°½èÊý¤¬£±ÅÙ¤Ç¤â
      *    ¤¢¤Ã¤¿¤«¸¡º÷¤¹¤ë
           IF     SYS-1001-HOSPSBT      =     "2"
               PERFORM    2102-SHOHOUSEN-HANTEI-SEC
           END-IF.
      *
      *    *¸øÈñ£±¤Î¾å¸Â²ó¿ô¡Ê¶â³Û¡Ë¼è¹þ¤ß
           IF (COMB-KOH1HKNNUM           NOT =  SPACE)    AND
              (COMB-KOH1-GAIJGNKBN       =     "1")
               INITIALIZE                      HKNNUM-REC
               MOVE   COMB-HOSPID        TO    HKN-HOSPID
               MOVE   COMB-KOH1HKNNUM    TO    HKN-HKNNUM
               IF     COMB-KOH1HKNNUM    =     "027"
                   MOVE     SYS-1001-HOSPSBT    TO  WK-PAYKBN(1:1)
                   MOVE     SYS-1001-ROUPAYKBN  TO  WK-PAYKBN(2:1)
               ELSE
                   MOVE     "00"         TO    WK-PAYKBN
               END-IF
               MOVE   HKNNUM-REC         TO    MCPDATA-REC
               MOVE   "DBSELECT"         TO    MCP-FUNC
               MOVE   "HKNNUM-KEY2"      TO    ORC-DBPATH
               CALL   "ORCMCPSUB"         USING MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
               IF      MCP-RC            =     ZERO
                   MOVE    "HKNNUM-KEY2" TO    ORC-DBPATH
                   PERFORM  HKNNUM-READ-SEC
                   PERFORM  UNTIL
                     (FLG-HKNNUM     =    1)                       OR
                     (HKN-TEKSTYMD(1:6)   <=  LNK-SYU-SRYYMD(1:6)) AND
                     (LNK-SYU-SRYYMD(1:6) <=  HKN-TEKEDYMD(1:6))   AND
                     (WK-PAYKBN            =  HKN-PAYKBN)
                       PERFORM   HKNNUM-READ-SEC
                   END-PERFORM
                   IF     FLG-HKNNUM         =       0
                          PERFORM   2103-KOH1-KAISU-SEC
                   END-IF
               END-IF
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "HKNNUM-KEY2"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
      *
      *    *¸øÈñ£²¤Î¾å¸Â²ó¿ô¡Ê¶â³Û¡Ë¼è¹þ¤ß
           IF (COMB-KOH2HKNNUM           NOT = SPACE)    AND
              (COMB-KOH2-GAIJGNKBN       =     "1")
               INITIALIZE                      HKNNUM-REC
               MOVE   COMB-HOSPID        TO    HKN-HOSPID
               MOVE   COMB-KOH2HKNNUM    TO    HKN-HKNNUM
               IF     COMB-KOH2HKNNUM    =     "027"
                   MOVE     SYS-1001-HOSPSBT    TO  WK-PAYKBN(1:1)
                   MOVE     SYS-1001-ROUPAYKBN  TO  WK-PAYKBN(2:1)
               ELSE
                   MOVE     "00"                TO  WK-PAYKBN
               END-IF
               MOVE   HKNNUM-REC         TO    MCPDATA-REC
               MOVE   "DBSELECT"         TO    MCP-FUNC
               MOVE   "HKNNUM-KEY2"      TO    ORC-DBPATH
               CALL   "ORCMCPSUB"         USING MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
               IF      MCP-RC            =     ZERO
                   MOVE    "HKNNUM-KEY2" TO    ORC-DBPATH
                   PERFORM  HKNNUM-READ-SEC
                   PERFORM  UNTIL
                     (FLG-HKNNUM     =    1)                      OR
                     (HKN-TEKSTYMD(1:6)   <= LNK-SYU-SRYYMD(1:6)) AND
                     (LNK-SYU-SRYYMD(1:6) <= HKN-TEKEDYMD(1:6))   AND
                     (WK-PAYKBN            = HKN-PAYKBN)
                       PERFORM   HKNNUM-READ-SEC
                   END-PERFORM
                   IF     FLG-HKNNUM         =       0
                          PERFORM   2104-KOH2-KAISU-SEC
                   END-IF
               END-IF
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "HKNNUM-KEY2"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
      *
      *    *¸øÈñ£³¤Î¾å¸Â²ó¿ô¡Ê¶â³Û¡Ë¼è¹þ¤ß
           IF (COMB-KOH3HKNNUM           NOT = SPACE)    AND
              (COMB-KOH3-GAIJGNKBN       =     "1")
               INITIALIZE                      HKNNUM-REC
               MOVE   COMB-HOSPID        TO    HKN-HOSPID
               MOVE   COMB-KOH3HKNNUM    TO    HKN-HKNNUM
               IF     COMB-KOH3HKNNUM    =     "027"
                   MOVE     SYS-1001-HOSPSBT    TO  WK-PAYKBN(1:1)
                   MOVE     SYS-1001-ROUPAYKBN  TO  WK-PAYKBN(2:1)
               ELSE
                   MOVE     "00"                TO  WK-PAYKBN
               END-IF
               MOVE   HKNNUM-REC         TO    MCPDATA-REC
               MOVE   "DBSELECT"         TO    MCP-FUNC
               MOVE   "HKNNUM-KEY2"      TO    ORC-DBPATH
               CALL   "ORCMCPSUB"         USING MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
               IF      MCP-RC            =     ZERO
                   MOVE    "HKNNUM-KEY2" TO    ORC-DBPATH
                   PERFORM  HKNNUM-READ-SEC
                   PERFORM  UNTIL
                     (FLG-HKNNUM     =    1)                      OR
                     (HKN-TEKSTYMD(1:6)   <= LNK-SYU-SRYYMD(1:6)) AND
                     (LNK-SYU-SRYYMD(1:6) <= HKN-TEKEDYMD(1:6))   AND
                     (WK-PAYKBN            = HKN-PAYKBN)
                       PERFORM   HKNNUM-READ-SEC
                   END-PERFORM
                   IF     FLG-HKNNUM         =       0
                          PERFORM   2105-KOH3-KAISU-SEC
                   END-IF
               END-IF
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "HKNNUM-KEY2"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
      *
      *    *¸øÈñ£´¤Î¾å¸Â²ó¿ô¡Ê¶â³Û¡Ë¼è¹þ¤ß
           IF (COMB-KOH4HKNNUM           NOT = SPACE)    AND
              (COMB-KOH4-GAIJGNKBN       =     "1")
               INITIALIZE                      HKNNUM-REC
               MOVE   COMB-HOSPID        TO    HKN-HOSPID
               MOVE   COMB-KOH4HKNNUM    TO    HKN-HKNNUM
               IF     COMB-KOH4HKNNUM    =     "027"
                   MOVE     SYS-1001-HOSPSBT    TO  WK-PAYKBN(1:1)
                   MOVE     SYS-1001-ROUPAYKBN  TO  WK-PAYKBN(2:1)
               ELSE
                   MOVE     "00"                TO  WK-PAYKBN
               END-IF
               MOVE   HKNNUM-REC         TO    MCPDATA-REC
               MOVE   "DBSELECT"         TO    MCP-FUNC
               MOVE   "HKNNUM-KEY2"      TO    ORC-DBPATH
               CALL   "ORCMCPSUB"         USING MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
               IF      MCP-RC            =     ZERO
                   MOVE    "HKNNUM-KEY2" TO    ORC-DBPATH
                   PERFORM  HKNNUM-READ-SEC
                   PERFORM  UNTIL
                     (FLG-HKNNUM     =    1)                       OR
                     (HKN-TEKSTYMD(1:6)   <= LNK-SYU-SRYYMD(1:6)) AND
                     (LNK-SYU-SRYYMD(1:6) <= HKN-TEKEDYMD(1:6))   AND
                     (WK-PAYKBN            = HKN-PAYKBN)
                       PERFORM   HKNNUM-READ-SEC
                   END-PERFORM
                   IF     FLG-HKNNUM         =       0
                          PERFORM   2106-KOH4-KAISU-SEC
                   END-IF
               END-IF
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "HKNNUM-KEY2"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
      *
       210-HOKEN-KAISU-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¥·¥¹¥Æ¥à´ÉÍý¥Æ¡¼¥Ö¥ë¤è¤êÏ·¿ÍÊÝ¸±¤Î»ÙÊ§ÊýË¡¤ò¼èÆÀ        *
      ******************************************************************
       2101-ROUJIN-HKN-HANTEI-SEC           SECTION.
      *
           INITIALIZE                         SYS-1001-REC.
           MOVE    "1001"               TO    SYS-1001-KANRICD.
           MOVE    "*"                  TO    SYS-1001-KBNCD.
           MOVE    LNK-SYU-SRYYMD       TO    ORC-DBYMD.
           MOVE    SYS-1001-REC         TO    MCPDATA-REC.
           MOVE    "DBSELECT"           TO    MCP-FUNC.
           MOVE    "SYSKANRI-KEY"       TO    ORC-DBPATH.
           CALL    "ORCMCPSUB"    USING        MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC.
           IF      MCP-RC               =     ZERO
               MOVE     "SYSKANRI-KEY"  TO    ORC-DBPATH
               PERFORM   SYSKANRI-READ-SEC
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "SYSKANRI-KEY"       TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
      *
       2101-ROUJIN-HKN-HANTEI-EXT.
           EXIT.
      *
      ***************************************************************
      *        ¼ýÇ¼¥Æ¡¼¥Ö¥ë¤«¤é±¡Æâ½èÊý¡¢±¡³°½èÊý¤ÎÈ½Äê             *
      ***************************************************************
       2102-SHOHOUSEN-HANTEI-SEC           SECTION.
      *
           IF      LNK-SYU-INGAISHOHOKBN  =      "1"
               MOVE       "1"             TO     FLG-INGAI
           ELSE
             MOVE    LNK-SYU-HOSPID       TO     SYU-HOSPID
             MOVE    LNK-SYU-NYUGAIKBN    TO     SYU-NYUGAIKBN
             MOVE    LNK-SYU-PTID         TO     SYU-PTID
             MOVE    SYU-SYUNOU-REC       TO     MCPDATA-REC 
             MOVE    "DBSELECT"           TO     MCP-FUNC
             MOVE    "SYUNOU-KEY2"        TO     ORC-DBPATH
             CALL    "ORCMCPSUB"           USING  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
             IF      MCP-RC               =      ZERO
                 MOVE    "SYUNOU-KEY2"    TO     ORC-DBPATH
                 PERFORM  SYUNOU-READ-SEC
                 PERFORM  UNTIL  (FLG-SYUNOU   =    "1")
                     IF (LNK-SYU-SRYYMD(1:6) = SYU-SRYYMD(1:6)) AND
                        (SYU-DENPJTIKBN  NOT =   "3")
                         IF   SYU-INGAISHOHOKBN   =     "1"
                              MOVE   "1"  TO     FLG-INGAI
                         ELSE
                              MOVE   "1"  TO     FLG-INNAI
                         END-IF
                     END-IF
                     MOVE      "SYUNOU-KEY2"  TO     ORC-DBPATH
                     PERFORM   SYUNOU-READ-SEC
                 END-PERFORM
             END-IF
             MOVE    "DBCLOSE"            TO  MCP-FUNC
             MOVE    "SYUNOU-KEY2"        TO  ORC-DBPATH
             CALL    "ORCMCPSUB"           USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           END-IF.
      *
       2102-SHOHOUSEN-HANTEI-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¸øÈñ£±¡Ê¶â³Û¡Ë¼è¹þ¤ß½èÍý                                *
      ******************************************************************
       2103-KOH1-KAISU-SEC           SECTION.
      *
           EVALUATE   FLG-SANSHOU2
               WHEN   "1"
                        MOVE  HKN-HON-GAIDJGNCNT TO  MAX-KAI-KOHI1-D
                        MOVE  HKN-HON-GAIMJGNCNT TO  MAX-KAI-KOHI1-M
                        MOVE  HKN-HON-GAIDJGNGAK TO  MAX-KIN-KOHI1-D
                        IF    FLG-INGAI          =   "1"
                              MOVE  HKN-HON-GAIMGAIJGNGAK
                                                 TO  MAX-KIN-KOHI1-M
                        ELSE
                              MOVE  HKN-HON-GAIMNAIJGNGAK
                                                 TO  MAX-KIN-KOHI1-M
                        END-IF
               WHEN   "2"
                        MOVE  HKN-TSY-GAIDJGNCNT TO  MAX-KAI-KOHI1-D
                        MOVE  HKN-TSY-GAIMJGNCNT TO  MAX-KAI-KOHI1-M
                        MOVE  HKN-TSY-GAIDJGNGAK TO  MAX-KIN-KOHI1-D
                        IF    FLG-INGAI          =   "1"
                              MOVE  HKN-TSY-GAIMGAIJGNGAK
                                                 TO  MAX-KIN-KOHI1-M
                        ELSE
                              MOVE  HKN-TSY-GAIMNAIJGNGAK
                                                 TO  MAX-KIN-KOHI1-M
                        END-IF
               WHEN   "3"
                        MOVE  HKN-TNK-GAIDJGNCNT TO  MAX-KAI-KOHI1-D
                        MOVE  HKN-TNK-GAIMJGNCNT TO  MAX-KAI-KOHI1-M
                        MOVE  HKN-TNK-GAIDJGNGAK TO  MAX-KIN-KOHI1-D
                        IF    FLG-INGAI          =   "1"
                              MOVE  HKN-TNK-GAIMGAIJGNGAK
                                                 TO  MAX-KIN-KOHI1-M
                        ELSE
                              MOVE  HKN-TNK-GAIMNAIJGNGAK
                                                 TO  MAX-KIN-KOHI1-M
                        END-IF
           END-EVALUATE.
      *
       2103-KOH1-KAISU-EXT.
           EXIT.
      ******************************************************************
      *        ¸øÈñ£²¡Ê¶â³Û¡Ë¼è¹þ¤ß½èÍý                                *
      ******************************************************************
       2104-KOH2-KAISU-SEC           SECTION.
      *
           EVALUATE   FLG-SANSHOU2
               WHEN   "1"
                        MOVE  HKN-HON-GAIDJGNCNT TO  MAX-KAI-KOHI2-D
                        MOVE  HKN-HON-GAIMJGNCNT TO  MAX-KAI-KOHI2-M
                        MOVE  HKN-HON-GAIDJGNGAK TO  MAX-KIN-KOHI2-D
                        IF    FLG-INGAI          =   "1"
                              MOVE  HKN-HON-GAIMGAIJGNGAK
                                                 TO  MAX-KIN-KOHI2-M
                        ELSE
                              MOVE  HKN-HON-GAIMNAIJGNGAK
                                                 TO  MAX-KIN-KOHI2-M
                        END-IF
               WHEN   "2"
                        MOVE  HKN-TSY-GAIDJGNCNT TO  MAX-KAI-KOHI2-D
                        MOVE  HKN-TSY-GAIMJGNCNT TO  MAX-KAI-KOHI2-M
                        MOVE  HKN-TSY-GAIDJGNGAK TO  MAX-KIN-KOHI2-D
                        IF    FLG-INGAI          =   "1"
                              MOVE  HKN-TSY-GAIMGAIJGNGAK
                                                 TO  MAX-KIN-KOHI2-M
                        ELSE
                              MOVE  HKN-TSY-GAIMNAIJGNGAK
                                                 TO  MAX-KIN-KOHI2-M
                        END-IF
               WHEN   "3"
                        MOVE  HKN-TNK-GAIDJGNCNT TO  MAX-KAI-KOHI2-D
                        MOVE  HKN-TNK-GAIMJGNCNT TO  MAX-KAI-KOHI2-M
                        MOVE  HKN-TNK-GAIDJGNGAK TO  MAX-KIN-KOHI2-D
                        IF    FLG-INGAI          =   "1"
                              MOVE  HKN-TNK-GAIMGAIJGNGAK
                                                 TO  MAX-KIN-KOHI2-M
                        ELSE
                              MOVE  HKN-TNK-GAIMNAIJGNGAK
                                                 TO  MAX-KIN-KOHI2-M
                        END-IF
           END-EVALUATE.
      *
       2104-KOH2-KAISU-EXT.
           EXIT.
      ******************************************************************
      *        ¸øÈñ£³¡Ê¶â³Û¡Ë¼è¹þ¤ß½èÍý                                *
      ******************************************************************
       2105-KOH3-KAISU-SEC           SECTION.
      *
           EVALUATE   FLG-SANSHOU2
               WHEN   "1"
                        MOVE  HKN-HON-GAIDJGNCNT TO   MAX-KAI-KOHI3-D
                        MOVE  HKN-HON-GAIMJGNCNT TO   MAX-KAI-KOHI3-M
                        MOVE  HKN-HON-GAIDJGNGAK TO   MAX-KIN-KOHI3-D
                        IF    FLG-INGAI          =   "1"
                              MOVE  HKN-HON-GAIMGAIJGNGAK
                                                 TO  MAX-KIN-KOHI3-M
                        ELSE
                              MOVE  HKN-HON-GAIMNAIJGNGAK
                                                 TO  MAX-KIN-KOHI3-M
                        END-IF
               WHEN   "2"
                        MOVE  HKN-TSY-GAIDJGNCNT TO  MAX-KAI-KOHI3-D
                        MOVE  HKN-TSY-GAIMJGNCNT TO  MAX-KAI-KOHI3-M
                        MOVE  HKN-TSY-GAIDJGNGAK TO  MAX-KIN-KOHI3-D
                        IF    FLG-INGAI          =   "1"
                              MOVE  HKN-TSY-GAIMGAIJGNGAK
                                                 TO  MAX-KIN-KOHI3-M
                        ELSE
                              MOVE  HKN-TSY-GAIMNAIJGNGAK
                                                 TO  MAX-KIN-KOHI3-M
                        END-IF
               WHEN   "3"
                        MOVE  HKN-TNK-GAIDJGNCNT TO  MAX-KAI-KOHI3-D
                        MOVE  HKN-TNK-GAIMJGNCNT TO  MAX-KAI-KOHI3-M
                        MOVE  HKN-TNK-GAIDJGNGAK TO  MAX-KIN-KOHI3-D
                        IF    FLG-INGAI          =   "1"
                              MOVE  HKN-TNK-GAIMGAIJGNGAK
                                                 TO  MAX-KIN-KOHI3-M
                        ELSE
                              MOVE  HKN-TNK-GAIMNAIJGNGAK
                                                 TO  MAX-KIN-KOHI3-M
                        END-IF
           END-EVALUATE.
      *
       2105-KOH3-KAISU-EXT.
           EXIT.
      ******************************************************************
      *        ¸øÈñ£´¡Ê¶â³Û¡Ë¼è¹þ¤ß½èÍý                                *
      ******************************************************************
       2106-KOH4-KAISU-SEC           SECTION.
      *
           EVALUATE   FLG-SANSHOU2
               WHEN   "1"
                        MOVE  HKN-HON-GAIDJGNCNT TO   MAX-KAI-KOHI4-D
                        MOVE  HKN-HON-GAIMJGNCNT TO   MAX-KAI-KOHI4-M
                        MOVE  HKN-HON-GAIDJGNGAK TO   MAX-KIN-KOHI4-D
                        IF    FLG-INGAI          =   "1"
                              MOVE  HKN-HON-GAIMGAIJGNGAK
                                                 TO  MAX-KIN-KOHI4-M
                        ELSE
                              MOVE  HKN-HON-GAIMNAIJGNGAK
                                                 TO  MAX-KIN-KOHI4-M
                        END-IF
               WHEN   "2"
                        MOVE  HKN-TSY-GAIDJGNCNT TO  MAX-KAI-KOHI4-D
                        MOVE  HKN-TSY-GAIMJGNCNT TO  MAX-KAI-KOHI4-M
                        MOVE  HKN-TSY-GAIDJGNGAK TO  MAX-KIN-KOHI4-D
                        IF    FLG-INGAI          =   "1"
                              MOVE  HKN-TSY-GAIMGAIJGNGAK
                                                 TO  MAX-KIN-KOHI4-M
                        ELSE
                              MOVE  HKN-TSY-GAIMNAIJGNGAK
                                                 TO  MAX-KIN-KOHI4-M
                        END-IF
               WHEN   "3"
                        MOVE  HKN-TNK-GAIDJGNCNT TO  MAX-KAI-KOHI4-D
                        MOVE  HKN-TNK-GAIMJGNCNT TO  MAX-KAI-KOHI4-M
                        MOVE  HKN-TNK-GAIDJGNGAK TO  MAX-KIN-KOHI4-D
                        IF    FLG-INGAI          =   "1"
                              MOVE  HKN-TNK-GAIMGAIJGNGAK
                                                 TO  MAX-KIN-KOHI4-M
                        ELSE
                              MOVE  HKN-TNK-GAIMNAIJGNGAK
                                                 TO  MAX-KIN-KOHI4-M
                        END-IF
           END-EVALUATE.
      *
       2106-KOH4-KAISU-EXT.
           EXIT.
      *
      ******************************************************************
      *    ¿ÇÎÅ·îÆâ¤Î¼ýÇ¼¥Þ¥¹¥¿¤«¤é¸øÈñËè¤Î»ÈÍÑ²ó¿ô¤È´µ¼ÔÉéÃ´¶â³Û¤Î
      *    Îß·×¤òÄ´ºº
      ******************************************************************
       220-SYUNOU-SEC           SECTION.
      *
           IF  (COMB-KOH1-GAIJGNKBN       =       "1")      OR
               (COMB-KOH2-GAIJGNKBN       =       "1")      OR
               (COMB-KOH3-GAIJGNKBN       =       "1")      OR
               (COMB-KOH4-GAIJGNKBN       =       "1")
               INITIALIZE                         SYU-SYUNOU-REC
               MOVE    LNK-SYU-HOSPID     TO      SYU-HOSPID
               MOVE    LNK-SYU-NYUGAIKBN  TO      SYU-NYUGAIKBN
               MOVE    LNK-SYU-PTID       TO      SYU-PTID
               MOVE    SYU-SYUNOU-REC     TO      MCPDATA-REC
               MOVE    "DBSELECT"         TO      MCP-FUNC
               MOVE    "SYUNOU-KEY2"      TO      ORC-DBPATH
               CALL    "ORCMCPSUB"         USING   MCPAREA
                                                   ORCMCPAREA
                                                   MCPDATA-REC
               IF      MCP-RC             =       ZERO
                   MOVE    "SYUNOU-KEY2"  TO      ORC-DBPATH
                   PERFORM  SYUNOU-READ-SEC
                   PERFORM  UNTIL  (FLG-SYUNOU   =    "1")
                     IF (LNK-SYU-SRYYMD(1:6) = SYU-SRYYMD(1:6)) AND
                        (SYU-DENPJTIKBN  NOT =  "3")
                             PERFORM        2201-SYUNOU-COUNT-SEC
                     END-IF
                     MOVE           "SYUNOU-KEY2"    TO   ORC-DBPATH
                     PERFORM        SYUNOU-READ-SEC
                   END-PERFORM
                   MOVE        LNK-SYU-SRYYMD(7:2)   TO   IDX2X
                   MOVE        KOHI1-TBL(IDX2) TO    KAISU-KOHI1-D
                   MOVE        KOHI2-TBL(IDX2) TO    KAISU-KOHI2-D
                   MOVE        KOHI3-TBL(IDX2) TO    KAISU-KOHI3-D
                   MOVE        KOHI4-TBL(IDX2) TO    KAISU-KOHI4-D
                   MOVE        KOHI1-TBL(32)   TO    KAISU-KOHI1-M
                   MOVE        KOHI2-TBL(32)   TO    KAISU-KOHI2-M
                   MOVE        KOHI3-TBL(32)   TO    KAISU-KOHI3-M
                   MOVE        KOHI4-TBL(32)   TO    KAISU-KOHI4-M
               ELSE
                   MOVE    12              TO        LNK-S01-RC
               END-IF
           END-IF.
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC.
           MOVE    "SYUNOU-KEY2"           TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC.
      *
       220-SYUNOU-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¿ÇÎÅ·î¤Î¼ýÇ¼¥Þ¥¹¥¿¤«¤é¸øÈñ¤Î²ó¿ô¡Ê¶â³Û¡Ë¥«¥¦¥ó¥È
      ******************************************************************
       2201-SYUNOU-COUNT-SEC          SECTION.
      *    ¸øÈñ£±¥«¥¦¥ó¥È
           IF  (COMB-KOH1HKNNUM               NOT =   SPACE)  AND
               (COMB-KOH1-GAIJGNKBN           =       "1")
               IF        (LNK-SYU-KOH1HKNNUM  =  SYU-KOH1HKNNUM)   OR
                         (LNK-SYU-KOH1HKNNUM  =  SYU-KOH2HKNNUM)   OR
                         (LNK-SYU-KOH1HKNNUM  =  SYU-KOH3HKNNUM)   OR
                         (LNK-SYU-KOH1HKNNUM  =  SYU-KOH4HKNNUM)
                   MOVE   SYU-SRYYMD(7:2)     TO   IDX2X
                   IF    (MAX-KAI-KOHI1-D     NOT = ZERO)  AND
                         (KOHI1-TBL(IDX2)     >=    MAX-KAI-KOHI1-D)
                       CONTINUE
                   ELSE
                       IF  KOHI1-TBL(IDX2)   =  ZERO
                           ADD     1      TO    KOHI1-TBL(IDX2)
                           ADD     1      TO    KOHI1-TBL(32)
                       END-IF
                   END-IF
                   IF        LNK-SYU-SRYYMD(7:2)    =  SYU-SRYYMD(7:2)
                       EVALUATE  TRUE
                           WHEN  (LNK-SYU-KOH1HKNNUM = SYU-KOH1HKNNUM)
                                 ADD   SYU-KOH1HKNFTNMONEY
                                                    TO  FTN-KOHI1-D
                           WHEN  (LNK-SYU-KOH1HKNNUM = SYU-KOH2HKNNUM)
                                 ADD   SYU-KOH2HKNFTNMONEY
                                                    TO  FTN-KOHI1-D
                           WHEN  (LNK-SYU-KOH1HKNNUM = SYU-KOH3HKNNUM)
                                 ADD   SYU-KOH3HKNFTNMONEY
                                                    TO  FTN-KOHI1-D
                           WHEN  (LNK-SYU-KOH1HKNNUM = SYU-KOH4HKNNUM)
                                 ADD   SYU-KOH4HKNFTNMONEY
                                                    TO  FTN-KOHI1-D
                       END-EVALUATE
                   END-IF
                   EVALUATE  TRUE
                       WHEN  (LNK-SYU-KOH1HKNNUM = SYU-KOH1HKNNUM)
                             ADD   SYU-KOH1HKNFTNMONEY
                                                TO  FTN-KOHI1-M
                       WHEN  (LNK-SYU-KOH1HKNNUM = SYU-KOH2HKNNUM)
                             ADD   SYU-KOH2HKNFTNMONEY
                                                TO  FTN-KOHI1-M
                       WHEN  (LNK-SYU-KOH1HKNNUM = SYU-KOH3HKNNUM)
                             ADD   SYU-KOH3HKNFTNMONEY
                                                TO  FTN-KOHI1-M
                       WHEN  (LNK-SYU-KOH1HKNNUM = SYU-KOH4HKNNUM)
                             ADD   SYU-KOH4HKNFTNMONEY
                                                TO  FTN-KOHI1-M
                   END-EVALUATE
               END-IF
           END-IF.
      *    ¸øÈñ£²¥«¥¦¥ó¥È
           IF  (COMB-KOH2HKNNUM               NOT = SPACE)   AND
               (COMB-KOH2-GAIJGNKBN           =     "1")
               IF        (LNK-SYU-KOH2HKNNUM  =  SYU-KOH1HKNNUM)   OR
                         (LNK-SYU-KOH2HKNNUM  =  SYU-KOH2HKNNUM)   OR
                         (LNK-SYU-KOH2HKNNUM  =  SYU-KOH3HKNNUM)   OR
                         (LNK-SYU-KOH2HKNNUM  =  SYU-KOH4HKNNUM)
                   MOVE   SYU-SRYYMD(7:2)     TO    IDX2X
                   IF    (MAX-KAI-KOHI2-D     NOT = ZERO)  AND
                         (KOHI2-TBL(IDX2)     >=    MAX-KAI-KOHI2-D)
                       CONTINUE
                   ELSE
                       IF  KOHI2-TBL(IDX2)   =  ZERO
                           ADD     1      TO    KOHI2-TBL(IDX2)
                           ADD     1      TO    KOHI2-TBL(32)
                       END-IF
                   END-IF
                   IF        LNK-SYU-SRYYMD(7:2) =  SYU-SRYYMD(7:2)
                       EVALUATE  TRUE
                           WHEN  (LNK-SYU-KOH2HKNNUM = SYU-KOH1HKNNUM)
                                 ADD   SYU-KOH1HKNFTNMONEY
                                                    TO  FTN-KOHI2-D
                           WHEN  (LNK-SYU-KOH2HKNNUM = SYU-KOH2HKNNUM)
                                 ADD   SYU-KOH2HKNFTNMONEY
                                                    TO  FTN-KOHI2-D
                           WHEN  (LNK-SYU-KOH2HKNNUM = SYU-KOH3HKNNUM)
                                 ADD   SYU-KOH3HKNFTNMONEY
                                                    TO  FTN-KOHI2-D
                           WHEN  (LNK-SYU-KOH2HKNNUM = SYU-KOH4HKNNUM)
                                 ADD   SYU-KOH4HKNFTNMONEY
                                                    TO  FTN-KOHI2-D
                       END-EVALUATE
                   END-IF
                   EVALUATE  TRUE
                       WHEN  (LNK-SYU-KOH2HKNNUM = SYU-KOH1HKNNUM)
                             ADD   SYU-KOH1HKNFTNMONEY
                                                TO  FTN-KOHI2-M
                       WHEN  (LNK-SYU-KOH2HKNNUM = SYU-KOH2HKNNUM)
                             ADD   SYU-KOH2HKNFTNMONEY
                                                TO  FTN-KOHI2-M
                       WHEN  (LNK-SYU-KOH2HKNNUM = SYU-KOH3HKNNUM)
                             ADD   SYU-KOH3HKNFTNMONEY
                                                TO  FTN-KOHI2-M
                       WHEN  (LNK-SYU-KOH2HKNNUM = SYU-KOH4HKNNUM)
                             ADD   SYU-KOH4HKNFTNMONEY
                                                TO  FTN-KOHI2-M
                   END-EVALUATE
               END-IF
           END-IF.
      *    ¸øÈñ£³¥«¥¦¥ó¥È
           IF  (COMB-KOH3HKNNUM               NOT = SPACE)   AND
               (COMB-KOH3-GAIJGNKBN           =     "1")
               IF        (LNK-SYU-KOH3HKNNUM  =  SYU-KOH1HKNNUM)   OR
                         (LNK-SYU-KOH3HKNNUM  =  SYU-KOH2HKNNUM)   OR
                         (LNK-SYU-KOH3HKNNUM  =  SYU-KOH3HKNNUM)   OR
                         (LNK-SYU-KOH3HKNNUM  =  SYU-KOH4HKNNUM)
                   MOVE   SYU-SRYYMD(7:2)     TO    IDX2X
                   IF    (MAX-KAI-KOHI3-D     NOT = ZERO)  AND
                         (KOHI3-TBL(IDX2)     >=    MAX-KAI-KOHI3-D)
                       CONTINUE
                   ELSE
                       IF  KOHI3-TBL(IDX2)   =  ZERO
                           ADD     1      TO    KOHI3-TBL(IDX2)
                           ADD     1      TO    KOHI3-TBL(32)
                       END-IF
                   END-IF
                   IF        LNK-SYU-SRYYMD(7:2)   =   SYU-SRYYMD(7:2)
                       EVALUATE  TRUE
                           WHEN  (LNK-SYU-KOH3HKNNUM = SYU-KOH1HKNNUM)
                                 ADD   SYU-KOH1HKNFTNMONEY
                                                    TO  FTN-KOHI3-D
                           WHEN  (LNK-SYU-KOH3HKNNUM = SYU-KOH2HKNNUM)
                                 ADD   SYU-KOH2HKNFTNMONEY
                                                    TO  FTN-KOHI3-D
                           WHEN  (LNK-SYU-KOH3HKNNUM = SYU-KOH3HKNNUM)
                                 ADD   SYU-KOH3HKNFTNMONEY
                                                    TO  FTN-KOHI3-D
                           WHEN  (LNK-SYU-KOH3HKNNUM = SYU-KOH4HKNNUM)
                                 ADD   SYU-KOH4HKNFTNMONEY
                                                    TO  FTN-KOHI3-D
                       END-EVALUATE
                   END-IF
                   EVALUATE  TRUE
                       WHEN  (LNK-SYU-KOH3HKNNUM = SYU-KOH1HKNNUM)
                             ADD   SYU-KOH1HKNFTNMONEY
                                                TO  FTN-KOHI3-M
                       WHEN  (LNK-SYU-KOH3HKNNUM = SYU-KOH2HKNNUM)
                             ADD   SYU-KOH2HKNFTNMONEY
                                                TO  FTN-KOHI3-M
                       WHEN  (LNK-SYU-KOH3HKNNUM = SYU-KOH3HKNNUM)
                             ADD   SYU-KOH3HKNFTNMONEY
                                                TO  FTN-KOHI3-M
                       WHEN  (LNK-SYU-KOH3HKNNUM = SYU-KOH4HKNNUM)
                             ADD   SYU-KOH4HKNFTNMONEY
                                                TO  FTN-KOHI3-M
                   END-EVALUATE
               END-IF
           END-IF.
      *    ¸øÈñ£´¥«¥¦¥ó¥È
           IF  (COMB-KOH4HKNNUM               NOT = SPACE)   AND
               (COMB-KOH4-GAIJGNKBN           =     "1")
               IF        (LNK-SYU-KOH4HKNNUM  =  SYU-KOH1HKNNUM)   OR
                         (LNK-SYU-KOH4HKNNUM  =  SYU-KOH2HKNNUM)   OR
                         (LNK-SYU-KOH4HKNNUM  =  SYU-KOH3HKNNUM)   OR
                         (LNK-SYU-KOH4HKNNUM  =  SYU-KOH4HKNNUM)
                   MOVE   SYU-SRYYMD(7:2)     TO    IDX2X
                   IF    (MAX-KAI-KOHI4-D     NOT = ZERO)  AND
                         (KOHI4-TBL(IDX2)     >=    MAX-KAI-KOHI4-D)
                       CONTINUE
                   ELSE
                       IF  KOHI4-TBL(IDX2)   =  ZERO
                           ADD     1      TO    KOHI4-TBL(IDX2)
                           ADD     1      TO    KOHI4-TBL(32)
                       END-IF
                   END-IF
                   IF        LNK-SYU-SRYYMD(7:2)   =  SYU-SRYYMD(7:2)
                       EVALUATE  TRUE
                           WHEN  (LNK-SYU-KOH4HKNNUM = SYU-KOH1HKNNUM)
                                 ADD   SYU-KOH1HKNFTNMONEY
                                                    TO  FTN-KOHI4-D
                           WHEN  (LNK-SYU-KOH4HKNNUM = SYU-KOH2HKNNUM)
                                 ADD   SYU-KOH2HKNFTNMONEY
                                                    TO  FTN-KOHI4-D
                           WHEN  (LNK-SYU-KOH4HKNNUM = SYU-KOH3HKNNUM)
                                 ADD   SYU-KOH3HKNFTNMONEY
                                                    TO  FTN-KOHI4-D
                           WHEN  (LNK-SYU-KOH4HKNNUM = SYU-KOH4HKNNUM)
                                 ADD   SYU-KOH4HKNFTNMONEY
                                                    TO  FTN-KOHI4-D
                       END-EVALUATE
                   END-IF
                   EVALUATE  TRUE
                       WHEN  (LNK-SYU-KOH4HKNNUM = SYU-KOH1HKNNUM)
                             ADD   SYU-KOH1HKNFTNMONEY
                                                TO  FTN-KOHI4-M
                       WHEN  (LNK-SYU-KOH4HKNNUM = SYU-KOH2HKNNUM)
                             ADD   SYU-KOH2HKNFTNMONEY
                                                TO  FTN-KOHI4-M
                       WHEN  (LNK-SYU-KOH4HKNNUM = SYU-KOH3HKNNUM)
                             ADD   SYU-KOH3HKNFTNMONEY
                                                TO  FTN-KOHI4-M
                       WHEN  (LNK-SYU-KOH4HKNNUM = SYU-KOH4HKNNUM)
                             ADD   SYU-KOH4HKNFTNMONEY
                                                TO  FTN-KOHI4-M
                   END-EVALUATE
               END-IF
           END-IF.
       2201-SYUNOU-COUNT-EXT.
           EXIT.
      *
      ******************************************************************
      *    ÊÝ¸±¡¦¸øÈñ¤ÎÉéÃ´¶â·×»»
      ******************************************************************
       230-FTNKIN-SEC           SECTION.
      *
      *
      *    »»Äê²ÄÇ½¥Õ¥é¥°¤Î½é´ü²½
           MOVE     SPACE                  TO     FLG-SANTEI1
                                                  FLG-SANTEI2
                                                  FLG-SANTEI3
                                                  FLG-SANTEI4.
      *
      *    ²áµî¤Î´µ¼ÔÉéÃ´²ó¿ô¤È¾å¸Â²ó¿ô¤ÎÈæ³Ó
           IF       MAX-KAI-KOHI1-D        NOT =  ZERO
               IF   KAISU-KOHI1-D          >=     MAX-KAI-KOHI1-D
                    MOVE     "1"           TO     FLG-SANTEI1
               END-IF
           END-IF.
           IF       MAX-KAI-KOHI2-D        NOT =  ZERO
               IF   KAISU-KOHI2-D          >=     MAX-KAI-KOHI2-D
                    MOVE     "1"           TO     FLG-SANTEI2
               END-IF
           END-IF.
           IF       MAX-KAI-KOHI3-D        NOT =  ZERO
               IF   KAISU-KOHI3-D          >=     MAX-KAI-KOHI3-D
                    MOVE     "1"           TO     FLG-SANTEI3
               END-IF
           END-IF.
           IF       MAX-KAI-KOHI4-D        NOT =  ZERO
               IF   KAISU-KOHI4-D          >=     MAX-KAI-KOHI4-D
                    MOVE     "1"           TO     FLG-SANTEI4
               END-IF
           END-IF.
           IF       MAX-KAI-KOHI1-M        NOT =  ZERO
               IF   KAISU-KOHI1-M          >=     MAX-KAI-KOHI1-M
                    MOVE     "1"           TO     FLG-SANTEI1
               END-IF
           END-IF.
           IF       MAX-KAI-KOHI2-M        NOT =  ZERO
               IF   KAISU-KOHI2-M          >=     MAX-KAI-KOHI2-M
                    MOVE     "1"           TO     FLG-SANTEI2
               END-IF
           END-IF.
           IF       MAX-KAI-KOHI3-M        NOT =  ZERO
               IF   KAISU-KOHI3-M          >=     MAX-KAI-KOHI3-M
                    MOVE     "1"           TO     FLG-SANTEI3
               END-IF
           END-IF.
           IF       MAX-KAI-KOHI4-M        NOT =  ZERO
               IF   KAISU-KOHI4-M          >=     MAX-KAI-KOHI4-M
                    MOVE     "1"           TO     FLG-SANTEI4
               END-IF
           END-IF.
      *    ²áµî¤Î´µ¼ÔÊÝ¸±ÉéÃ´Îß·×³Û¤È¾å¸Â¶â³Û¤ÎÈæ³Ó
           IF       MAX-KIN-KOHI1-D        NOT =  ZERO
               IF   FTN-KOHI1-D            >=     MAX-KIN-KOHI1-D
                    MOVE     "1"           TO     FLG-SANTEI1
               END-IF
           END-IF.
           IF       MAX-KIN-KOHI2-D        NOT =  ZERO
               IF   FTN-KOHI2-D            >=     MAX-KIN-KOHI2-D
                    MOVE     "1"           TO     FLG-SANTEI2
               END-IF
           END-IF.
           IF       MAX-KIN-KOHI3-D        NOT =  ZERO
               IF   FTN-KOHI3-D            >=     MAX-KIN-KOHI3-D
                    MOVE     "1"           TO     FLG-SANTEI3
               END-IF
           END-IF.
           IF       MAX-KIN-KOHI4-D        NOT =  ZERO
               IF   FTN-KOHI4-D            >=     MAX-KIN-KOHI4-D
                    MOVE     "1"           TO     FLG-SANTEI4
               END-IF
           END-IF.
           IF       MAX-KIN-KOHI1-M        NOT =  ZERO
               IF   FTN-KOHI1-M            >=     MAX-KIN-KOHI1-M
                    MOVE     "1"           TO     FLG-SANTEI1
               END-IF
           END-IF.
           IF       MAX-KIN-KOHI2-M        NOT =  ZERO
               IF   FTN-KOHI2-M            >=     MAX-KIN-KOHI2-M
                    MOVE     "1"           TO     FLG-SANTEI2
               END-IF
           END-IF.
           IF       MAX-KIN-KOHI3-M        NOT =  ZERO
               IF   FTN-KOHI3-M            >=     MAX-KIN-KOHI3-M
                    MOVE     "1"           TO     FLG-SANTEI3
               END-IF
           END-IF.
           IF       MAX-KIN-KOHI4-M        NOT =  ZERO
               IF   FTN-KOHI4-M            >=     MAX-KIN-KOHI4-M
                    MOVE     "1"           TO     FLG-SANTEI4
               END-IF
           END-IF.
      *
      *    ÊÝ¸±¡Ê¸øÈñ¡Ë¥Æ¡¼¥Ö¥ë¤Î´µ¼ÔÉéÃ´¾å¸Â³Û¤ÈÅö·î¤Î´µ¼ÔÉéÃ´Îß·×³Û
      *    ¤«¤é»»Äê²ÄÇ½»Ä³Û¤ò»»½Ð¤¹¤ë
           IF  FLG-SANTEI1               =     "1"
               MOVE     ZERO             TO    ZAN-KOHI1-D
           ELSE
               IF (COMB-KOH1HKNNUM           NOT = SPACE)    AND
                  (COMB-KOH1-GAIJGNKBN       =     "1")
                   IF       MAX-KIN-KOHI1-D       NOT = ZERO
                       IF   FTN-KOHI1-D           >=  MAX-KIN-KOHI1-D
                            MOVE     ZERO         TO  ZAN-KOHI1-D
                       ELSE
                            COMPUTE  ZAN-KOHI1-D  =   MAX-KIN-KOHI1-D -
                                                      FTN-KOHI1-D
                       END-IF
                   END-IF
               END-IF
           END-IF.
           IF  FLG-SANTEI2               =     "1"
               MOVE     ZERO             TO    ZAN-KOHI2-D
           ELSE
               IF (COMB-KOH2HKNNUM           NOT = SPACE)    AND
                  (COMB-KOH2-GAIJGNKBN       =     "1")
                   IF       MAX-KIN-KOHI2-D       NOT = ZERO
                       IF   FTN-KOHI2-D           >=  MAX-KIN-KOHI2-D
                            MOVE     ZERO         TO  ZAN-KOHI2-D
                       ELSE
                            COMPUTE  ZAN-KOHI2-D  =   MAX-KIN-KOHI2-D -
                                                      FTN-KOHI2-D
                       END-IF
                   END-IF
               END-IF
           END-IF.
           IF  FLG-SANTEI3               =     "1"
               MOVE     ZERO             TO    ZAN-KOHI3-D
           ELSE
               IF (COMB-KOH3HKNNUM           NOT = SPACE)    AND
                  (COMB-KOH3-GAIJGNKBN       =     "1")
                   IF       MAX-KIN-KOHI3-D       NOT = ZERO
                       IF   FTN-KOHI3-D           >=  MAX-KIN-KOHI3-D
                            MOVE     ZERO         TO  ZAN-KOHI3-D
                       ELSE
                            COMPUTE  ZAN-KOHI3-D  =   MAX-KIN-KOHI3-D -
                                                      FTN-KOHI3-D
                       END-IF
                   END-IF
               END-IF
           END-IF.
           IF  FLG-SANTEI4               =     "1"
               MOVE     ZERO             TO    ZAN-KOHI4-D
           ELSE
               IF (COMB-KOH4HKNNUM           NOT = SPACE)    AND
                  (COMB-KOH4-GAIJGNKBN       =     "1")
                   IF       MAX-KIN-KOHI4-D       NOT = ZERO
                       IF   FTN-KOHI4-D           >=  MAX-KIN-KOHI4-D
                            MOVE     ZERO         TO  ZAN-KOHI4-D
                       ELSE
                            COMPUTE  ZAN-KOHI4-D  =   MAX-KIN-KOHI4-D -
                                                      FTN-KOHI4-D
                       END-IF
                   END-IF
               END-IF
           END-IF.
           IF  FLG-SANTEI1               =     "1"
               MOVE     ZERO             TO    ZAN-KOHI1-M
           ELSE
               IF (COMB-KOH1HKNNUM           NOT = SPACE)    AND
                  (COMB-KOH1-GAIJGNKBN       =     "1")
                   IF       MAX-KIN-KOHI1-M       NOT = ZERO
                       IF   FTN-KOHI1-M           >=  MAX-KIN-KOHI1-M
                            MOVE     ZERO         TO  ZAN-KOHI1-M
                       ELSE
                            COMPUTE  ZAN-KOHI1-M  =   MAX-KIN-KOHI1-M -
                                                      FTN-KOHI1-M
                       END-IF
                   END-IF
               END-IF
           END-IF.
           IF  FLG-SANTEI2               =     "1"
               MOVE     ZERO             TO    ZAN-KOHI2-M
           ELSE
               IF (COMB-KOH2HKNNUM           NOT = SPACE)    AND
                  (COMB-KOH2-GAIJGNKBN       =     "1")
                   IF       MAX-KIN-KOHI2-M       NOT = ZERO
                       IF   FTN-KOHI2-M           >=  MAX-KIN-KOHI2-M
                            MOVE     ZERO         TO  ZAN-KOHI2-M
                       ELSE
                            COMPUTE  ZAN-KOHI2-M  =   MAX-KIN-KOHI2-M -
                                                      FTN-KOHI2-M
                       END-IF
                   END-IF
               END-IF
           END-IF.
           IF  FLG-SANTEI3               =     "1"
               MOVE     ZERO             TO    ZAN-KOHI3-M
           ELSE
               IF (COMB-KOH3HKNNUM           NOT = SPACE)    AND
                  (COMB-KOH3-GAIJGNKBN       =     "1")
                   IF       MAX-KIN-KOHI3-M       NOT = ZERO
                       IF   FTN-KOHI3-M           >=  MAX-KIN-KOHI3-M
                            MOVE     ZERO         TO  ZAN-KOHI3-M
                       ELSE
                            COMPUTE  ZAN-KOHI3-M  =   MAX-KIN-KOHI3-M -
                                                      FTN-KOHI3-M
                       END-IF
                   END-IF
               END-IF
           END-IF.
           IF  FLG-SANTEI4               =     "1"
               MOVE     ZERO             TO    ZAN-KOHI4-M
           ELSE
               IF (COMB-KOH4HKNNUM           NOT = SPACE)    AND
                  (COMB-KOH4-GAIJGNKBN       =     "1")
                   IF       MAX-KIN-KOHI4-M       NOT = ZERO
                       IF   FTN-KOHI4-M           >=  MAX-KIN-KOHI4-M
                            MOVE     ZERO         TO  ZAN-KOHI4-M
                       ELSE
                            COMPUTE  ZAN-KOHI4-M  =   MAX-KIN-KOHI4-M -
                                                      FTN-KOHI4-M
                       END-IF
                   END-IF
               END-IF
           END-IF.
      *
      *    Æü¤Î´µ¼ÔÉéÃ´²ÄÇ½»Ä³Û¤È·î¤Î´µ¼ÔÉéÃ´²ÄÇ½»Ä³Û¤òÈæ³Ó¤·¤Æ
      *    ÃÍ¤Î¾®¤µ¤¤¤Û¤¦¤ò¥»¥Ã¥È¤¹¤ë
           IF (COMB-KOH1HKNNUM              NOT = SPACE)    AND
              (COMB-KOH1-GAIJGNKBN          =     "1")
               EVALUATE   TRUE
                   WHEN  (MAX-KIN-KOHI1-D   NOT =   ZERO)   AND
                         (MAX-KIN-KOHI1-M   NOT =   ZERO)
                     IF    ZAN-KOHI1-D            >    ZAN-KOHI1-M
                           MOVE   ZAN-KOHI1-M     TO   ZAN-KOHI1
                     ELSE
                           MOVE   ZAN-KOHI1-D     TO   ZAN-KOHI1
                     END-IF
                   WHEN  (MAX-KIN-KOHI1-D   NOT =   ZERO)   AND
                         (MAX-KIN-KOHI1-M   =       ZERO)
                           MOVE   ZAN-KOHI1-D     TO   ZAN-KOHI1
                   WHEN  (MAX-KIN-KOHI1-D   =       ZERO)   AND
                         (MAX-KIN-KOHI1-M   NOT =   ZERO)
                           MOVE   ZAN-KOHI1-M     TO   ZAN-KOHI1
                   WHEN  (MAX-KIN-KOHI1-D   =       ZERO)   AND
                         (MAX-KIN-KOHI1-M   =       ZERO)
                           MOVE   ZERO            TO   ZAN-KOHI1
               END-EVALUATE
           END-IF.
      *
           IF (COMB-KOH2HKNNUM              NOT = SPACE)    AND
              (COMB-KOH2-GAIJGNKBN          =     "1")
               EVALUATE   TRUE
                   WHEN  (MAX-KIN-KOHI2-D   NOT =   ZERO)   AND
                         (MAX-KIN-KOHI2-M   NOT =   ZERO)
                     IF    ZAN-KOHI2-D            >    ZAN-KOHI2-M
                           MOVE   ZAN-KOHI2-M     TO   ZAN-KOHI2
                     ELSE
                           MOVE   ZAN-KOHI2-D     TO   ZAN-KOHI2
                     END-IF
                   WHEN  (MAX-KIN-KOHI2-D   NOT =   ZERO)   AND
                         (MAX-KIN-KOHI2-M   =       ZERO)
                           MOVE   ZAN-KOHI2-D     TO   ZAN-KOHI2
                   WHEN  (MAX-KIN-KOHI2-D   =       ZERO)   AND
                         (MAX-KIN-KOHI2-M   NOT =   ZERO)
                           MOVE   ZAN-KOHI2-M     TO   ZAN-KOHI2
                   WHEN  (MAX-KIN-KOHI2-D   =       ZERO)   AND
                         (MAX-KIN-KOHI2-M   =       ZERO)
                           MOVE   ZERO            TO   ZAN-KOHI2
               END-EVALUATE
           END-IF.
      *
           IF (COMB-KOH3HKNNUM              NOT = SPACE)    AND
              (COMB-KOH3-GAIJGNKBN          =     "1")
               EVALUATE   TRUE
                   WHEN  (MAX-KIN-KOHI3-D   NOT =   ZERO)   AND
                         (MAX-KIN-KOHI3-M   NOT =   ZERO)
                     IF    ZAN-KOHI3-D            >    ZAN-KOHI3-M
                           MOVE   ZAN-KOHI3-M     TO   ZAN-KOHI3
                     ELSE
                           MOVE   ZAN-KOHI3-D     TO   ZAN-KOHI3
                     END-IF
                   WHEN  (MAX-KIN-KOHI3-D   NOT =   ZERO)   AND
                         (MAX-KIN-KOHI3-M   =       ZERO)
                           MOVE   ZAN-KOHI3-D     TO   ZAN-KOHI3
                   WHEN  (MAX-KIN-KOHI3-D   =       ZERO)   AND
                         (MAX-KIN-KOHI3-M   NOT =   ZERO)
                           MOVE   ZAN-KOHI3-M     TO   ZAN-KOHI3
                   WHEN  (MAX-KIN-KOHI3-D   =       ZERO)   AND
                         (MAX-KIN-KOHI3-M   =       ZERO)
                           MOVE   ZERO            TO   ZAN-KOHI3
               END-EVALUATE
           END-IF.
      *
           IF (COMB-KOH4HKNNUM              NOT = SPACE)    AND
              (COMB-KOH4-GAIJGNKBN          =     "1")
               EVALUATE   TRUE
                   WHEN  (MAX-KIN-KOHI4-D   NOT =   ZERO)   AND
                         (MAX-KIN-KOHI4-M   NOT =   ZERO)
                     IF    ZAN-KOHI4-D            >    ZAN-KOHI4-M
                           MOVE   ZAN-KOHI4-M     TO   ZAN-KOHI4
                     ELSE
                           MOVE   ZAN-KOHI4-D     TO   ZAN-KOHI4
                     END-IF
                   WHEN  (MAX-KIN-KOHI4-D   NOT =   ZERO)   AND
                         (MAX-KIN-KOHI4-M   =       ZERO)
                           MOVE   ZAN-KOHI4-D     TO   ZAN-KOHI4
                   WHEN  (MAX-KIN-KOHI4-D   =       ZERO)   AND
                         (MAX-KIN-KOHI4-M   NOT =   ZERO)
                           MOVE   ZAN-KOHI4-M     TO   ZAN-KOHI4
                   WHEN  (MAX-KIN-KOHI4-D   =       ZERO)   AND
                         (MAX-KIN-KOHI4-M   =       ZERO)
                           MOVE   ZERO            TO   ZAN-KOHI4
               END-EVALUATE
           END-IF.
      *
      *    ÊÝ¸±¡¦¸øÈñËè¤Î´µ¼ÔÉéÃ´¶â³Û¤Î·×»»
           IF    ((COMB-KOH1-HKNKOHSBTKBN    =   "3")    AND
                  (COMB-KOH1HKNNUM           =   "027")) OR 
                 ((COMB-KOH2-HKNKOHSBTKBN    =   "3")    AND
                  (COMB-KOH2HKNNUM           =   "027")) OR 
                 ((COMB-KOH3-HKNKOHSBTKBN    =   "3")    AND
                  (COMB-KOH3HKNNUM           =   "027")) OR 
                 ((COMB-KOH4-HKNKOHSBTKBN    =   "3")    AND
                  (COMB-KOH4HKNNUM           =   "027")) 
               CONTINUE
           ELSE
               IF    COMB-HKNNUM             NOT =       SPACE
                  PERFORM    2301-SYUHOKEN-KEISAN-SEC
               END-IF
           END-IF.
      *
      *----(2002/03/13  ŽÍŽÝŽºŽ³)---------------------------------------
      *
           PERFORM    VARYING   KOH-IDX    FROM   1   BY   1
                      UNTIL    (KOH-IDX    >      4)
               IF   COMB-KOHHKNNUM(KOH-IDX)  NOT =  SPACE
                    PERFORM    2302-KOH-HKNREAD-SEC
                    IF   COMB-KOH-GAIJGNKBN(KOH-IDX)  =  "1"
                         PERFORM   2303-KOH-KEISAN-SEC
                    ELSE
                         PERFORM   2304-KOH-KEISAN-SEC
                    END-IF
           END-PERFORM.
      *-------------------------------------------------------------
      *
      *     ¸øÈñÃ±°Ì¤Ç·×»»¤·¤¿´µ¼ÔÉéÃ´¶â³Û¤«¤éºÇ¾®¤ÎÃÍ¤òÁªÂò¥»¥Ã¥È
            PERFORM   2314-FTNKIN-HIKAKU-SEC.
      *
       230-FTNKIN-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¼çÊÝ¸±¤Î´µ¼ÔÉéÃ´¶â³Û·×»»                                *
      ******************************************************************
       2301-SYUHOKEN-KEISAN-SEC           SECTION.
      *
      *    ³ºÅöÊÝ¸±ÈÖ¹æ¥Æ¡¼¥Ö¥ë¤Î¸¡º÷
           INITIALIZE                      HKNNUM-REC.
           MOVE   COMB-HOSPID        TO    HKN-HOSPID.
           MOVE   COMB-HKNNUM        TO    HKN-HKNNUM.
           MOVE   "00"               TO    WK-PAYKBN.
           MOVE   HKNNUM-REC         TO    MCPDATA-REC.
           MOVE   "DBSELECT"         TO    MCP-FUNC.
           MOVE   "HKNNUM-KEY2"      TO    ORC-DBPATH.
           CALL   "ORCMCPSUB"         USING MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC.
           IF      MCP-RC            =     ZERO
               MOVE    "HKNNUM-KEY2" TO    ORC-DBPATH
               PERFORM  HKNNUM-READ-SEC
               PERFORM  UNTIL
                 (FLG-HKNNUM     =    1)                       OR
                 (HKN-TEKSTYMD(1:6)   <=  LNK-SYU-SRYYMD(1:6)) AND
                 (LNK-SYU-SRYYMD(1:6) <=  HKN-TEKEDYMD(1:6))   AND
                 (WK-PAYKBN            =  HKN-PAYKBN)
                   PERFORM   HKNNUM-READ-SEC
               END-PERFORM
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "HKNNUM-KEY2"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
      *
      *    ÊÝ¸±ÁÈ¹ç¤»¥Æ¡¼¥Ö¥ë¤ÎÊä½õ¶èÊ¬¤«¤é´µ¼Ô¤ÎÉéÃ´³ä¹ç¤òÊÝ¸±ÈÖ¹æ
      *    ¥Æ¡¼¥Ö¥ë¤ËºÆ¥»¥Ã¥È¡Ê¹ñÊÝ¤Î¤ß¡Ë
           IF    COMB-HKNNUM           =    "060"
               EVALUATE   COMB-HOJOKBN
                   WHEN   "0"
                          MOVE   ZERO      TO   HKN-HON-GAIKFTNRATE
                                                HKN-KZK-GAIKFTNRATE
                                                HKN-TSY-GAIKFTNRATE
                                                HKN-TNK-GAIKFTNRATE
                   WHEN   "1"
                          MOVE   10        TO   HKN-HON-GAIKFTNRATE
                                                HKN-KZK-GAIKFTNRATE
                                                HKN-TSY-GAIKFTNRATE
                                                HKN-TNK-GAIKFTNRATE
                   WHEN   "2"
                          MOVE   20        TO   HKN-HON-GAIKFTNRATE
                                                HKN-KZK-GAIKFTNRATE
                                                HKN-TSY-GAIKFTNRATE
                                                HKN-TNK-GAIKFTNRATE
                   WHEN   "3"
                          MOVE   30        TO   HKN-HON-GAIKFTNRATE
                                                HKN-KZK-GAIKFTNRATE
                                                HKN-TSY-GAIKFTNRATE
                                                HKN-TNK-GAIKFTNRATE
               END-EVALUATE
           END-IF.
      *
      *    ¡Ê£×£Ë¡Ý£È£Ë£Î£Ë£Â£Î¡¡¶õÇò¡§°åÊÝ¡¡£±¡§Ï«ºÒ¡¡£²¡§¼«ÇåÀÕ¡Ë
           EVALUATE   WK-HKNKBN
             WHEN   SPACE
      *    ÉéÃ´¶â³Û¤Î·×»»
               EVALUATE   FLG-SANSHOU
                 WHEN   "1"
                   IF   COMB-HONKZKKBN        =   "1"
                        IF    HKN-HON-GAIKFTNRATE     NOT =    ZERO
                              COMPUTE   WK-FUTANWARI  =
                                        HKN-HON-GAIKFTNRATE  /  100
                              COMPUTE   LNK-SYU-SYUCOMPFTN  =
                                        WK-ZENGAKU   *  WK-FUTANWARI
                              COMPUTE   LNK-SYU-SYUCOMPFTN =
                                        LNK-SYU-SYUCOMPFTN  +  5
                              COMPUTE   WK-FTN      =
                                        LNK-SYU-SYUCOMPFTN  /  10
                              COMPUTE   LNK-SYU-SYUCOMPFTN =
                                        WK-FTN   *  10
                        END-IF
                        MOVE  HKN-HON-GAIYKZFTNKBN
                                             TO   LNK-SYU-SYUYKZFTNKBN
                        IF    HKN-HON-GAIYKZFTNKBN  NOT =  "0"
                            MOVE  YAKFTN-SOGOKEI
                                             TO   LNK-SYU-SYUCOMPYKZFTN
                            IF    HKN-HON-GAIYKZFTNKBN  =  "1"
                                  MOVE  YAKFTN-SOGOKEI
                                             TO   WK-SYU-YAKFTN
                            END-IF
                        END-IF
                        COMPUTE   LNK-SYU-SYUCOMPTOTAL   =
                                  LNK-SYU-SYUCOMPFTN     +
                                  LNK-SYU-SYUCOMPYKZFTN
                   ELSE
                        IF    HKN-KZK-GAIKFTNRATE     NOT =    ZERO
                              COMPUTE   WK-FUTANWARI  =
                                        HKN-KZK-GAIKFTNRATE  /  100
                              COMPUTE   LNK-SYU-SYUCOMPFTN  =
                                        WK-ZENGAKU   *  WK-FUTANWARI
                              COMPUTE   LNK-SYU-SYUCOMPFTN =
                                        LNK-SYU-SYUCOMPFTN  +  5
                              COMPUTE   WK-FTN      =
                                        LNK-SYU-SYUCOMPFTN  /  10
                              COMPUTE   LNK-SYU-SYUCOMPFTN =
                                        WK-FTN   *  10
                        END-IF
                        MOVE  HKN-KZK-GAIYKZFTNKBN
                                             TO   LNK-SYU-SYUYKZFTNKBN
                        IF    HKN-KZK-GAIYKZFTNKBN  NOT =  "0"
                            MOVE  YAKFTN-SOGOKEI
                                             TO   LNK-SYU-SYUCOMPYKZFTN
                            IF    HKN-KZK-GAIYKZFTNKBN  =  "1"
                                  MOVE  YAKFTN-SOGOKEI
                                             TO   WK-SYU-YAKFTN
                            END-IF
                        END-IF
                        COMPUTE   LNK-SYU-SYUCOMPTOTAL   =
                                  LNK-SYU-SYUCOMPFTN     +
                                  LNK-SYU-SYUCOMPYKZFTN
                   END-IF
                 WHEN   "2"
                   IF    HKN-TSY-GAIKFTNRATE     NOT =    ZERO
                         COMPUTE   WK-FUTANWARI  =
                                   HKN-TSY-GAIKFTNRATE  /  100
                         COMPUTE   LNK-SYU-SYUCOMPFTN  =
                                   WK-ZENGAKU   *  WK-FUTANWARI
                         COMPUTE   LNK-SYU-SYUCOMPFTN =
                                   LNK-SYU-SYUCOMPFTN  +  5
                         COMPUTE   WK-FTN      =
                                   LNK-SYU-SYUCOMPFTN  /  10
                         COMPUTE   LNK-SYU-SYUCOMPFTN =
                                   WK-FTN   *  10
                   END-IF
                   MOVE  HKN-TSY-GAIYKZFTNKBN
                                        TO   LNK-SYU-SYUYKZFTNKBN
                   IF    HKN-TSY-GAIYKZFTNKBN  NOT =  "0"
                       MOVE  YAKFTN-SOGOKEI
                                        TO   LNK-SYU-SYUCOMPYKZFTN
                   END-IF
                   COMPUTE   LNK-SYU-SYUCOMPTOTAL   =
                             LNK-SYU-SYUCOMPFTN     +
                             LNK-SYU-SYUCOMPYKZFTN
                 WHEN   "3"
                   IF    HKN-TNK-GAIKFTNRATE     NOT =    ZERO
                         COMPUTE   WK-FUTANWARI  =
                                   HKN-TNK-GAIKFTNRATE  /  100
                         COMPUTE   LNK-SYU-SYUCOMPFTN  =
                                   WK-ZENGAKU   *  WK-FUTANWARI
                         COMPUTE   LNK-SYU-SYUCOMPFTN =
                                   LNK-SYU-SYUCOMPFTN  +  5
                         COMPUTE   WK-FTN      =
                                   LNK-SYU-SYUCOMPFTN  /  10
                         COMPUTE   LNK-SYU-SYUCOMPFTN =
                                   WK-FTN   *  10
                   END-IF
                   MOVE  HKN-TNK-GAIYKZFTNKBN
                                        TO   LNK-SYU-SYUYKZFTNKBN
                   IF    HKN-TNK-GAIYKZFTNKBN  NOT =  "0"
                       MOVE  YAKFTN-SOGOKEI
                                        TO   LNK-SYU-SYUCOMPYKZFTN
                   END-IF
                   COMPUTE   LNK-SYU-SYUCOMPTOTAL   =
                             LNK-SYU-SYUCOMPFTN     +
                             LNK-SYU-SYUCOMPYKZFTN
               END-EVALUATE
             WHEN   "1"
      *        ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿¡Ê£´£°£°£±¡Ë¤«¤éÅÀ¿ôÃ±²Á¤Î¼èÆÀ
               INITIALIZE                         SYS-4001-REC
               MOVE    "4001"               TO    SYS-4001-KANRICD
               MOVE    "*"                  TO    SYS-4001-KBNCD
               MOVE    LNK-SYU-SRYYMD       TO    ORC-DBYMD
               MOVE    SYS-4001-REC         TO    MCPDATA-REC
               MOVE    "DBSELECT"           TO    MCP-FUNC
               MOVE    "SYSKANRI-KEY"       TO    ORC-DBPATH
               CALL    "ORCMCPSUB"    USING       MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
               IF      MCP-RC               =     ZERO
                   MOVE     "SYSKANRI-KEY"  TO    ORC-DBPATH
                   PERFORM   SYSKANRI-READ-SEC
                   IF    MCP-RC             =     ZERO
                       EVALUATE  SYS-4001-TENKBN
                           WHEN  "1"
                               COMPUTE  WK-ZENGAKU  =  
                                        WK-ZENGAKU  / 10 * 11.5
                           WHEN  "2"
                               COMPUTE  WK-ZENGAKU  =  
                                        WK-ZENGAKU  / 10 * 12.0
                       END-EVALUATE
                   END-IF
               END-IF
      *
               MOVE    "DBCLOSE"            TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
      *
               COMPUTE   WK-FUTANWARI  =
                         HKN-HON-GAIKFTNRATE  /  100
               COMPUTE   LNK-SYU-SYUCOMPFTN  =
                         WK-ZENGAKU   *  WK-FUTANWARI
      *         COMPUTE   LNK-SYU-SYUCOMPFTN =
      *                   LNK-SYU-SYUCOMPFTN  +  5
      *         COMPUTE   WK-FTN      =
      *                   LNK-SYU-SYUCOMPFTN  /  10
      *         COMPUTE   LNK-SYU-SYUCOMPFTN =
      *                   WK-FTN   *  10
               MOVE  HKN-HON-GAIYKZFTNKBN
                                   TO   LNK-SYU-SYUYKZFTNKBN
               IF    HKN-HON-GAIYKZFTNKBN  NOT =  "0"
                     MOVE  YAKFTN-SOGOKEI
                                   TO   LNK-SYU-SYUCOMPYKZFTN
               IF    HKN-HON-GAIYKZFTNKBN  =  "1"
                     MOVE  YAKFTN-SOGOKEI
                                   TO   WK-SYU-YAKFTN
               END-IF
               COMPUTE   LNK-SYU-SYUCOMPTOTAL   =
                         LNK-SYU-SYUCOMPFTN     +
                         LNK-SYU-SYUCOMPYKZFTN
           END-EVALUATE.
      *
       2301-SYUHOKEN-KEISAN-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¸øÈñ¤ÎÊÝ¸±ÈÖ¹æ¥Æ¡¼¥Ö¥ë¸¡º÷                              *
      ******************************************************************
       2302-KOH-HKNREAD-SEC           SECTION.
      *
      *    ³ºÅöÊÝ¸±ÈÖ¹æ¥Æ¡¼¥Ö¥ë¤Î¸¡º÷
           INITIALIZE                      HKNNUM-REC.
           MOVE   COMB-HOSPID        TO    HKN-HOSPID.
           MOVE   COMB-KOHHKNNUM(KOH-IDX)
                                     TO    HKN-HKNNUM.
           IF     COMB-KOHHKNNUM(KOH-IDX)  =     "027"
               MOVE     SYS-1001-HOSPSBT    TO  WK-PAYKBN(1:1)
               MOVE     SYS-1001-ROUPAYKBN  TO  WK-PAYKBN(2:1)
           ELSE
               MOVE     "00"         TO    WK-PAYKBN
           END-IF.
           MOVE   HKNNUM-REC         TO    MCPDATA-REC.
           MOVE   "DBSELECT"         TO    MCP-FUNC.
           MOVE   "HKNNUM-KEY2"      TO    ORC-DBPATH.
           CALL   "ORCMCPSUB"         USING MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC.
           IF      MCP-RC            =     ZERO
               MOVE    "HKNNUM-KEY2" TO    ORC-DBPATH
               PERFORM  HKNNUM-READ-SEC
               PERFORM  UNTIL
                 (FLG-HKNNUM     =    1)                       OR
                 (HKN-TEKSTYMD(1:6)   <=  LNK-SYU-SRYYMD(1:6)) AND
                 (LNK-SYU-SRYYMD(1:6) <=  HKN-TEKEDYMD(1:6))   AND
                 (WK-PAYKBN            =  HKN-PAYKBN)
                   PERFORM   HKNNUM-READ-SEC
               END-PERFORM
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "HKNNUM-KEY2"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
           MOVE       ZERO                TO   WK-GAIKFTNRATE.
           MOVE       SPACE               TO   WK-GAIYKZFTNKBN.
           EVALUATE   FLG-SANSHOU2
               WHEN   "1"
                   MOVE    HKN-HON-GAIKFTNRATE  TO   WK-GAIKFTNRATE
                   MOVE    HKN-HON-GAIYKZFTNKBN TO   WK-GAIYKZFTNKBN
               WHEN   "2"
                   MOVE    HKN-TSY-GAIKFTNRATE  TO   WK-GAIKFTNRATE
                   MOVE    HKN-TSY-GAIYKZFTNKBN TO   WK-GAIYKZFTNKBN
               WHEN   "3"
                   MOVE    HKN-TNK-GAIKFTNRATE  TO   WK-GAIKFTNRATE
                   MOVE    HKN-TNK-GAIYKZFTNKBN TO   WK-GAIYKZFTNKBN
           END-EVALUATE.
      *
       2302-KOH-HKNREAD-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¸øÈñ¤Î´µ¼ÔÉéÃ´¶â³Û·×»»¡Ê¾å¸Â³Û¤¢¤ê¡Ë                    *
      ******************************************************************
       2303-KOH-KEISAN-SEC           SECTION.
      *
      *    ÉéÃ´¶â³Û¤Î·×»»
           IF  WK-GAIKFTNRATE     NOT =    ZERO
               COMPUTE   WK-FUTANWARI  =
                              WK-GAIKFTNRATE  /  100
               COMPUTE   LNK-SYU-KOH-COMPFTN(KOH-IDX)  =
                         WK-ZENGAKU   *  WK-FUTANWARI
               IF ((HKN-HKNKOHSBTKBN     =       "3")    AND
                   (LNK-SYU-KOH-HKNNUM(KOH-IDX)  NOT =  "027")) OR
                   (LNK-SYU-KOH-HKNNUM(KOH-IDX)  =      "051")
                   CONTINUE
               ELSE
                   COMPUTE   LNK-SYU-KOH-COMPFTN(KOH-IDX)  =
                             LNK-SYU-KOH-COMPFTN(KOH-IDX)  +  5
                   COMPUTE   WK-FTN      =
                             LNK-SYU-KOH-COMPFTN(KOH-IDX)  / 10
                   COMPUTE   LNK-SYU-KOH-COMPFTN(KOH-IDX)  =
                             WK-FTN   *  10
               END-IF
               IF    LNK-SYU-KOH-COMPFTN(KOH-IDX)   >
                                            ZAN-KOHI-T(KOH-IDX)
                     MOVE   ZAN-KOHI-T(KOH-IDX)   TO
                                          LNK-SYU-KOH-COMPFTN(KOH-IDX)
                     MOVE   ZERO        TO  ZAN-KOHI-T(KOH-IDX)
               ELSE
                     COMPUTE  ZAN-KOHI-T(KOH-IDX)    =
                              ZAN-KOHI-T(KOH-IDX)    -
                              LNK-SYU-KOH-COMPFTN(KOH-IDX)
               END-IF
               MOVE  WK-GAIYKZFTNKBN
                                TO   LNK-SYU-KOH-YKZFTNKBN(KOH-IDX)
               EVALUATE   WK-GAIYKZFTNKBN
                   WHEN   "0"
                       MOVE  ZERO  TO  LNK-SYU-KOH-COMPYKZFTN(KOH-IDX)
                   WHEN   "1"
                       MOVE  YAKFTN-SOGOKEI   TO
                                LNK-SYU-KOH-COMPYKZFTN(KOH-IDX)
                                WK-KOH-YAKFTN-T(KOH-IDX)
                   WHEN   "2"
                       IF    YAKFTN-SOGOKEI  >  ZAN-KOHI-T(KOH-IDX)
                             MOVE   ZAN-KOHI-T(KOH-IDX)  TO  
                                       LNK-SYU-KOH-COMPYKZFTN(KOH-IDX)
                                       WK-KOH-YAKFTN-T(KOH-IDX)
                             MOVE   ZERO    TO
                                            ZAN-KOHI-T(KOH-IDX)
                       ELSE
                             MOVE  YAKFTN-SOGOKEI  TO
                                       LNK-SYU-KOH-COMPYKZFTN(KOH-IDX)
                                       WK-KOH-YAKFTN-T(KOH-IDX)
                             COMPUTE  ZAN-KOHI-T(KOH-IDX)   =
                                      ZAN-KOHI-T(KOH-IDX)   -
                                      LNK-SYU-KOH-COMPYKZFTN(KOH-IDX)
                       END-IF
                   WHEN   "3"
                       MOVE  YAKFTN-SOGOKEI TO  LNK-SYU-KOH-COMPYKZFTN
                                                            (KOH-IDX)
               END-EVALUATE
               COMPUTE   LNK-SYU-KOH-COMPTOTAL(KOH-IDX)   =
                         LNK-SYU-KOH-COMPFTN(KOH-IDX)     +
                         LNK-SYU-KOH-COMPYKZFTN(KOH-IDX)
           ELSE
               IF    LNK-SYU-SYUCOMPFTN   NOT =    ZERO
                   IF    LNK-SYU-SYUCOMPFTN   >    ZAN-KOHI-T(KOH-IDX)
                       MOVE   ZAN-KOHI-T(KOH-IDX)
                                        TO  LNK-SYU-KOH-COMPFTN
                                                     (KOH-IDX)
                       MOVE   ZERO      TO  ZAN-KOHI-T(KOH-IDX)
                   ELSE
                       MOVE  LNK-SYU-SYUCOMPFTN
                                        TO  LNK-SYU-KOH-COMPFTN
                                                     (KOH-IDX)
                       COMPUTE    ZAN-KOHI-T(KOH-IDX)  =
                                  ZAN-KOHI-T(KOH-IDX)  -
                                  LNK-SYU-KOH-COMPFTN(KOH-IDX)
                   END-IF
               ELSE
                   IF    WK-ZENGAKU    >    ZAN-KOHI-T(KOH-IDX)
                         MOVE   ZAN-KOHI-T(KOH-IDX)
                                      TO  LNK-SYU-KOH-COMPFTN(KOH-IDX)
                         MOVE   ZERO  TO  ZAN-KOHI-T(KOH-IDX)
                   ELSE
                         MOVE   WK-ZENGAKU   TO  LNK-SYU-KOH-COMPFTN
                                                           (KOH-IDX)
                         COMPUTE   ZAN-KOHI-T(KOH-IDX)  =
                                   ZAN-KOHI-T(KOH-IDX)  -
                                   LNK-SYU-KOH-COMPFTN(KOH-IDX)
                   END-IF
               END-IF
               MOVE  WK-GAIYKZFTNKBN   TO  LNK-SYU-KOH-YKZFTNKBN
                                                        (KOH-IDX)
               EVALUATE   WK-GAIYKZFTNKBN
                   WHEN   "0"
                       MOVE  ZERO  TO  LNK-SYU-KOH-COMPYKZFTN(KOH-IDX)
                   WHEN   "1"
                       MOVE  YAKFTN-SOGOKEI
                                   TO  LNK-SYU-KOH-COMPYKZFTN(KOH-IDX)
                                       WK-KOH-YAKFTN-T(KOH-IDX)
                   WHEN   "2"
                       IF    YAKFTN-SOGOKEI  >  ZAN-KOHI-T(KOH-IDX)
                             MOVE   ZAN-KOHI-T(KOH-IDX)  
                                   TO  LNK-SYU-KOH-COMPYKZFTN(KOH-IDX)
                                       WK-KOH-YAKFTN-T(KOH-IDX)
                             MOVE   ZERO    TO  ZAN-KOHI-T(KOH-IDX)
                       ELSE
                             MOVE  YAKFTN-SOGOKEI  TO
                                       LNK-SYU-KOH-COMPYKZFTN(KOH-IDX)
                                       WK-KOH-YAKFTN-T(KOH-IDX)
                             COMPUTE  ZAN-KOHI-T(KOH-IDX)   =
                                      ZAN-KOHI-T(KOH-IDX)   -
                                      LNK-SYU-KOH-COMPYKZFTN(KOH-IDX)
                       END-IF
                   WHEN   "3"
                       MOVE  YAKFTN-SOGOKEI
                                   TO  LNK-SYU-KOH-COMPYKZFTN(KOH-IDX)
               END-EVALUATE
               COMPUTE   LNK-SYU-KOH-COMPTOTAL(KOH-IDX)   =
                         LNK-SYU-KOH-COMPFTN(KOH-IDX)     +
                         LNK-SYU-KOH-COMPYKZFTN(KOH-IDX)
           END-IF.
      *
       2303-KOH-KEISAN-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¸øÈñ¤Î´µ¼ÔÉéÃ´¶â³Û·×»»¡Ê¾å¸Â³Û¤Ê¤·¡Ë                  *
      ******************************************************************
       2304-KOH-KEISAN-SEC           SECTION.
      *
      *    ÉéÃ´¶â³Û¤Î·×»»
           IF  WK-GAIKFTNRATE     NOT =    ZERO
               COMPUTE   WK-FUTANWARI  =
                              WK-GAIKFTNRATE  /  100
               COMPUTE   LNK-SYU-KOH-COMPFTN(KOH-IDX)  =
                         WK-ZENGAKU   *  WK-FUTANWARI
               IF    LNK-SYU-KOH-HKNNUM(KOH-IDX)  =   "051"
                   CONTINUE
               ELSE
                   COMPUTE   LNK-SYU-KOH-COMPFTN(KOH-IDX) =
                             LNK-SYU-KOH-COMPFTN(KOH-IDX)  +  5
                   COMPUTE   WK-FTN      =
                             LNK-SYU-KOH-COMPFTN(KOH-IDX)  /  10
                   COMPUTE   LNK-SYU-KOH-COMPFTN(KOH-IDX) =  WK-FTN
                                                              *  10
               END-IF
               MOVE  WK-GAIYKZFTNKBN TO  LNK-SYU-KOH-YKZFTNKBN(KOH-IDX)
           END-IF.
           EVALUATE   WK-GAIYKZFTNKBN
               WHEN   "0"
                   MOVE  ZERO  TO  LNK-SYU-KOH-COMPYKZFTN(KOH-IDX)
               WHEN   "1"
                   MOVE  YAKFTN-SOGOKEI
                               TO  LNK-SYU-KOH-COMPYKZFTN(KOH-IDX)
                                   WK-KOH-YAKFTN-T(KOH-IDX)
               WHEN   "2"
                   MOVE  YAKFTN-SOGOKEI
                               TO  LNK-SYU-KOH-COMPYKZFTN(KOH-IDX)
                                   WK-KOH-YAKFTN-T(KOH-IDX)
               WHEN   "3"
                   MOVE  YAKFTN-SOGOKEI
                               TO  LNK-SYU-KOH-COMPYKZFTN(KOH-IDX)
           END-EVALUATE.
           COMPUTE   LNK-SYU-KOH-COMPTOTAL(KOH-IDX)   =
                     LNK-SYU-KOH-COMPFTN(KOH-IDX)     +
                     LNK-SYU-KOH-COMPYKZFTN(KOH-IDX).
      *
       2304-KOH-KEISAN-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¸øÈñÃ±°Ì¤Ç·×»»¤·¤¿´µ¼ÔÉéÃ´¶â¤«¤éºÇ¾®¤ÎÃÍ¤òÁªÂò¥»¥Ã¥È
      ******************************************************************
       2314-FTNKIN-HIKAKU-SEC         SECTION.
      *
      *    ÀÁµá³ÛÈæ³Ó
           MOVE    ZERO               TO    WK-KNJFTNKIN.
      *    ¼çÊÝ¸±¤Î¤ß
           IF (COMB-KOH1HKNNUM              =    SPACE)    AND
              (COMB-KOH2HKNNUM              =    SPACE)    AND
              (COMB-KOH3HKNNUM              =    SPACE)    AND
              (COMB-KOH4HKNNUM              =    SPACE)
               MOVE   LNK-SYU-SYUCOMPFTN    TO   WK-KNJFTNKIN
               MOVE   LNK-SYU-SYUCOMPYKZFTN TO   LNK-SYU-YKZ-FTN
           END-IF.
      *    ¸øÈñ£±¤Î¤ß
           IF (COMB-KOH1HKNNUM              NOT = SPACE)   AND
              (COMB-KOH2HKNNUM              =     SPACE)   AND
              (COMB-KOH3HKNNUM              =     SPACE)   AND
              (COMB-KOH4HKNNUM              =     SPACE)
               MOVE   LNK-SYU-KOH1COMPFTN   TO    WK-KNJFTNKIN
               MOVE   WK-KOH1-YAKFTN        TO    LNK-SYU-YKZ-FTN
           END-IF.
      *    ¸øÈñ£±¤È¸øÈñ£²
           IF (COMB-KOH1HKNNUM              NOT = SPACE)   AND
              (COMB-KOH2HKNNUM              NOT = SPACE)   AND
              (COMB-KOH3HKNNUM              =     SPACE)   AND
              (COMB-KOH4HKNNUM              =     SPACE)
               MOVE    LNK-SYU-KOH1COMPFTN  TO    WK-KNJFTNKIN
               IF  LNK-SYU-KOH2COMPFTN      <     WK-KNJFTNKIN
                   MOVE   LNK-SYU-KOH2COMPFTN TO  WK-KNJFTNKIN
               END-IF
               MOVE    WK-KOH1-YAKFTN       TO    LNK-SYU-YKZ-FTN
               IF  WK-KOH2-YAKFTN           <     LNK-SYU-YKZ-FTN
                   MOVE   WK-KOH2-YAKFTN    TO    LNK-SYU-YKZ-FTN
               END-IF
           END-IF.
      *    ¸øÈñ£±¤È¸øÈñ£²¤È¸øÈñ£³
           IF (COMB-KOH1HKNNUM              NOT = SPACE)   AND
              (COMB-KOH2HKNNUM              NOT = SPACE)   AND
              (COMB-KOH3HKNNUM              NOT = SPACE)   AND
              (COMB-KOH4HKNNUM              =     SPACE)
               MOVE    LNK-SYU-KOH1COMPFTN  TO    WK-KNJFTNKIN
               IF  LNK-SYU-KOH2COMPFTN      <     WK-KNJFTNKIN
                   MOVE   LNK-SYU-KOH2COMPFTN     TO  WK-KNJFTNKIN
               END-IF
               IF  LNK-SYU-KOH3COMPFTN      <     WK-KNJFTNKIN
                   MOVE   LNK-SYU-KOH3COMPFTN TO  WK-KNJFTNKIN
               END-IF
               MOVE    WK-KOH1-YAKFTN       TO    LNK-SYU-YKZ-FTN
               IF  WK-KOH2-YAKFTN           <     LNK-SYU-YKZ-FTN
                   MOVE   WK-KOH2-YAKFTN    TO    LNK-SYU-YKZ-FTN
               END-IF
               IF  WK-KOH3-YAKFTN           <     LNK-SYU-YKZ-FTN
                   MOVE   WK-KOH3-YAKFTN    TO    LNK-SYU-YKZ-FTN
               END-IF
           END-IF.
      *    ¸øÈñ£±¤È¸øÈñ£²¤È¸øÈñ£³¤È¸øÈñ£´
           IF (COMB-KOH1HKNNUM              NOT = SPACE)   AND
              (COMB-KOH2HKNNUM              NOT = SPACE)   AND
              (COMB-KOH3HKNNUM              NOT = SPACE)   AND
              (COMB-KOH4HKNNUM              NOT = SPACE)
               MOVE    LNK-SYU-KOH1COMPFTN  TO    WK-KNJFTNKIN
               IF  LNK-SYU-KOH2COMPFTN      <     WK-KNJFTNKIN
                   MOVE   LNK-SYU-KOH2COMPFTN TO  WK-KNJFTNKIN
               END-IF
               IF  LNK-SYU-KOH3COMPFTN      <     WK-KNJFTNKIN
                   MOVE   LNK-SYU-KOH3COMPFTN TO  WK-KNJFTNKIN
               END-IF
               IF  LNK-SYU-KOH4COMPFTN      <     WK-KNJFTNKIN
                   MOVE   LNK-SYU-KOH4COMPFTN TO  WK-KNJFTNKIN
               END-IF
               MOVE    WK-KOH1-YAKFTN       TO    LNK-SYU-YKZ-FTN
               IF  WK-KOH2-YAKFTN           <     LNK-SYU-YKZ-FTN
                   MOVE   WK-KOH2-YAKFTN    TO    LNK-SYU-YKZ-FTN
               END-IF
               IF  WK-KOH3-YAKFTN           <     LNK-SYU-YKZ-FTN
                   MOVE   WK-KOH3-YAKFTN    TO    LNK-SYU-YKZ-FTN
               END-IF
               IF  WK-KOH4-YAKFTN           <     LNK-SYU-YKZ-FTN
                   MOVE   WK-KOH4-YAKFTN    TO    LNK-SYU-YKZ-FTN
               END-IF
           END-IF.
      *
      *    ¼ýÇ¼¥Æ¡¼¥Ö¥ë¤ÎÀÁµá³Û¤ò¥»¥Ã¥È
           MOVE    WK-KNJFTNKIN             TO  LNK-SYU-SKYMONEY.
      *
      *    ¼ýÇ¼¥Æ¡¼¥Ö¥ë¤Î¸øÈñËè¤Î´µ¼ÔÉéÃ´¶â³Û¤ò¥»¥Ã¥È¤¹¤ë
           IF   (COMB-KOH1HKNNUM         NOT = SPACE)   AND
                (COMB-KOH1-GAIJGNKBN     =     "1")
               IF   COMB-KOH1-HKNKOHSBTKBN   NOT =    "3"
                    MOVE   WK-KNJFTNKIN  TO  LNK-SYU-KOH1HKNFTNMONEY
                    IF     LNK-SYU-KOH1YKZFTNKBN   =    "2"
                           COMPUTE  LNK-SYU-KOH1HKNFTNMONEY  =
                                    LNK-SYU-KOH1HKNFTNMONEY  +
                                    LNK-SYU-KOH1COMPYKZFTN
                    END-IF
               ELSE
                    IF     COMB-KOH1HKNNUM     =    "027"
                        MOVE   LNK-SYU-KOH1COMPFTN
                                         TO  LNK-SYU-KOH1HKNFTNMONEY
                    ELSE
                        MOVE   WK-KNJFTNKIN  TO LNK-SYU-KOH1HKNFTNMONEY
                    END-IF
               END-IF
           END-IF.
           IF   (COMB-KOH2HKNNUM        NOT = SPACE)   AND
                (COMB-KOH2-GAIJGNKBN    =     "1")
               IF   COMB-KOH2-HKNKOHSBTKBN   NOT =    "3"
                    MOVE   WK-KNJFTNKIN  TO  LNK-SYU-KOH2HKNFTNMONEY
                    IF     LNK-SYU-KOH2YKZFTNKBN   =    "2"
                           COMPUTE  LNK-SYU-KOH2HKNFTNMONEY  =
                                    LNK-SYU-KOH2HKNFTNMONEY  +
                                    LNK-SYU-KOH2COMPYKZFTN
                    END-IF
               ELSE
                    IF     COMB-KOH2HKNNUM     =    "027"
                        MOVE   LNK-SYU-KOH2COMPFTN
                                         TO  LNK-SYU-KOH2HKNFTNMONEY
                    ELSE
                        MOVE   WK-KNJFTNKIN  TO LNK-SYU-KOH2HKNFTNMONEY
                    END-IF
               END-IF
           END-IF.
           IF   (COMB-KOH3HKNNUM        NOT = SPACE)   AND
                (COMB-KOH3-GAIJGNKBN    =     "1")
               IF   COMB-KOH3-HKNKOHSBTKBN   NOT =    "3"
                    MOVE   WK-KNJFTNKIN  TO  LNK-SYU-KOH3HKNFTNMONEY
                    IF     LNK-SYU-KOH3YKZFTNKBN   =    "2"
                           COMPUTE  LNK-SYU-KOH3HKNFTNMONEY  =
                                    LNK-SYU-KOH3HKNFTNMONEY  +
                                    LNK-SYU-KOH3COMPYKZFTN
                    END-IF
               ELSE
                    IF     COMB-KOH3HKNNUM     =    "027"
                        MOVE   LNK-SYU-KOH3COMPFTN
                                         TO  LNK-SYU-KOH3HKNFTNMONEY
                    ELSE
                        MOVE   WK-KNJFTNKIN  TO LNK-SYU-KOH3HKNFTNMONEY
                    END-IF
               END-IF
           END-IF.
           IF   (COMB-KOH4HKNNUM        NOT = SPACE)   AND
                (COMB-KOH4-GAIJGNKBN    =     "1")
               IF   COMB-KOH4-HKNKOHSBTKBN   NOT =    "3"
                    MOVE   WK-KNJFTNKIN  TO  LNK-SYU-KOH4HKNFTNMONEY
                    IF     LNK-SYU-KOH4YKZFTNKBN   =    "2"
                           COMPUTE  LNK-SYU-KOH4HKNFTNMONEY  =
                                    LNK-SYU-KOH4HKNFTNMONEY  +
                                    LNK-SYU-KOH4COMPYKZFTN
                    END-IF
               ELSE
                    IF     COMB-KOH4HKNNUM     =    "027"
                        MOVE   LNK-SYU-KOH4COMPFTN
                                         TO  LNK-SYU-KOH4HKNFTNMONEY
                    ELSE
                        MOVE   WK-KNJFTNKIN  TO LNK-SYU-KOH4HKNFTNMONEY
                    END-IF
               END-IF
           END-IF.
      *
       2314-FTNKIN-HIKAKU-EXT.
           EXIT.
      ******************************************************************
      *        ÌôºÞ°ìÉôÉéÃ´¶â¤Î»»Äê½èÍý                                *
      ******************************************************************
       YAKFTN-SANTEI-SEC              SECTION.
      *
           MOVE      SPACE       TO      YAKFTN-AREA.
           INITIALIZE                    YAKFTN-AREA.
      *
      *    ÌôºÞ°ìÉôÉéÃ´¶âÄ§¼ý²ÄÇ½¤ÎÈ½Äê
           PERFORM YAKFTN-HANTEI-SEC.
      *
           IF      FLG-YAKFTN    =    SPACE
      *
      *      ÌôºÞ°ìÉôÉéÃ´¶â¥Æ¡¼¥Ö¥ë¤Î¥»¥Ã¥È
             PERFORM        YAKFTN-TABLE-SET-SEC
      *
      *      ÌôºÞ°ìÉôÉéÃ´¶â¥Æ¡¼¥Ö¥ë¤òºÆ¸¡º÷¤·¤ÆÆ±°ìÌôºÞ¤Î¼ïÎà¿ô¤ò¸º»»
             PERFORM YAKFTN-KAISUU-HENSYU-SEC
      *
      *      ÌôºÞ°ìÉôÉéÃ´¶â¥Æ¡¼¥Ö¥ë¤òºÆ¸¡º÷¤·¤ÆºÞÈÖ¹æÊÌ¤ÎÌôºÞ¿ô¤ò·×»»
             PERFORM YAKFTN-SAI-KEISAN-SEC
      *
      *      ºÞÈÖ¹æÊÌ¤ÎÌôºÞ¿ô¤è¤êÌôºÞ°ìÉôÉéÃ´¶â¤ò·×»»
             PERFORM YAKFTN-KINGAKU-KEISAN-SEC
      *
      *      ÊÝ¸±ÀÚ¤êÂØ¤¨»þ¤Î·ÑÂ³¿ÇÎÅÆþÎÏ¤¬¤µ¤ì¤¿¾ì¹ç¤ÎÁ°ÆþÎÏÊ¬
      *      ¤ÎÌôºÞ°ìÉôÉéÃ´¶â¤Î»»½Ð
             IF      LNK-SYU-CONTKBN     =    "2"
                 PERFORM YAKFTN-CONT-SEC
             END-IF
      *
      *      ÌôºÞ°ìÉôÉéÃ´¶â¤Î¾å¸Â³Û¤ò¼çÊÝ¸±¤ÎÉéÃ´¶â³Û¤Þ¤Ç¤È¤¹¤ë
             PERFORM YAKFTN-JOUGEN-HANTEI-SEC
           END-IF.
      *
       YAKFTN-SANTEI-EXT.
           EXIT.
      *
      ******************************************************************
      *     Ç¯Îð¡¢ÊÝ¸±ÆâÍÆ¤«¤éÌôºÞ°ìÉôÉéÃ´¶â»»Äê²ÄÇ½´µ¼Ô¤Ç¤¢¤ë¤«È½Äê   *
      ******************************************************************
       YAKFTN-HANTEI-SEC           SECTION.
      *
           MOVE    SPACE                TO      FLG-YAKFTN.
      *
      *    Ç¯Îð£¶ºÍÌ¤Ëþ
           INITIALIZE                           PTINF-REC.
           MOVE    LNK-SYU-HOSPID       TO      PTINF-HOSPID.
           MOVE    LNK-SYU-PTID         TO      PTINF-PTID.
           MOVE    PTINF-REC            TO      MCPDATA-REC.
           MOVE    "DBSELECT"           TO      MCP-FUNC.
           MOVE    "PTINF-KEY"          TO      ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC.
           IF      MCP-RC               =       ZERO
               MOVE    "PTINF-KEY"      TO      ORC-DBPATH
               PERFORM  PTINF-READ-SEC
               IF       MCP-RC          =       ZERO
                    MOVE   PTINF-BIRTHDAY   TO  WRK-YMDS1
                    MOVE   LNK-SYU-SRYYMD   TO  WRK-YMDS2
                    MOVE   ZERO             TO  WRK-NENREI
                    COMPUTE  WRK-NENREI     =   WRK-YYS2
                                            -   WRK-YYS1
                    IF   WRK-YMDS1(5:4)     >   WRK-YMDS2(5:4)
                         ADD   -1           TO  WRK-NENREI
                    END-IF
               ELSE
                    DISPLAY  "PTINF FETCH ERR"
                    MOVE     ZERO   TO      WRK-NENREI
               END-IF
           ELSE
               DISPLAY   "PTINF SELECT ERR"
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "PTINF-KEY"          TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
      *
           IF      WRK-NENREI         <     6
               MOVE    "1"            TO      FLG-YAKFTN
           END-IF.
      *
      *    Á¥°÷ÊÝ¸±¤Î³ºÅö¼Ô¡§¿¦Ì³¾å
      *                    ¡§²¼Á¥¸å£³¥ö·î°ÊÆâ
      *                    ¡§ÄÌ¶ÐºÒ³²
           IF     (COMB-HKNNUM        =     "002")   AND
                  (COMB-HOJOKBN       =  "1"  OR  "2"  OR  "3")
               MOVE    "1"            TO      FLG-YAKFTN
           END-IF.
      *
       YAKFTN-HANTEI-EXT.
           EXIT.
      *
      ******************************************************************
      *     °ú¤­ÅÏ¤·¥Ñ¥é¥á¥¿¤«¤éÌôºÞ°ìÉôÉéÃ´¶â¥Æ¡¼¥Ö¥ë¤Ø¤Î¥»¥Ã¥È½èÍý   *
      ******************************************************************
       YAKFTN-TABLE-SET-SEC           SECTION.
      *
           MOVE    ZERO                 TO      Y-IDX3.
           PERFORM VARYING     Y-IDX    FROM    1   BY  1
                   UNTIL      (Y-IDX        >       3)
             PERFORM VARYING     Y-IDX2    FROM    1   BY  1
                     UNTIL    (Y-IDX2       >       40)
               IF    (LNK-S01-SRYKBN(Y-IDX Y-IDX2)  NOT =  SPACE) AND
                     (LNK-S01-SRYCD(Y-IDX Y-IDX2) (1:1) =  "6")
                   ADD        1     TO    Y-IDX3
                   MOVE  LNK-S01-SRYKBN (Y-IDX Y-IDX2)
                                         TO    LNK-S02-SRYKBN (Y-IDX3)
                   MOVE  LNK-S01-ZAIBAN (Y-IDX Y-IDX2)
                                         TO    LNK-S02-ZAIBAN (Y-IDX3)
                   MOVE  LNK-S01-SRYCD  (Y-IDX Y-IDX2)
                                         TO    LNK-S02-SRYCD  (Y-IDX3)
                   MOVE  LNK-S01-SURYOU (Y-IDX Y-IDX2)
                                         TO    LNK-S02-SURYOU (Y-IDX3)
                   MOVE  LNK-S01-KAISUU (Y-IDX Y-IDX2)
                                         TO    LNK-S02-KAISUU (Y-IDX3)
                   MOVE  LNK-S01-TENSUU (Y-IDX Y-IDX2)
                                         TO    LNK-S02-TENSUU (Y-IDX3)
               END-IF
             END-PERFORM
           END-PERFORM.
      *
           PERFORM VARYING     Y-IDX    FROM    1   BY  1
                   UNTIL      (LNK-S02-SRYKBN(Y-IDX)    =   SPACE) OR
                              (Y-IDX                    >   40   )
               MOVE  LNK-S02-SRYKBN (Y-IDX) TO YAKFTN-SRYKBN (Y-IDX)
               MOVE  LNK-S02-ZAIBAN (Y-IDX) TO YAKFTN-ZAIBAN (Y-IDX)
               MOVE  LNK-S02-SRYCD  (Y-IDX) TO YAKFTN-SRYCD  (Y-IDX)
               MOVE  LNK-S02-TENSUU (Y-IDX) TO YAKFTN-TENSUU (Y-IDX)
               IF    LNK-S02-SRYKBN(Y-IDX)  =  "22"
                     MOVE    1              TO LNK-S02-KAISUU(Y-IDX)
               END-IF
               MOVE  LNK-S02-KAISUU (Y-IDX) TO YAKFTN-MAX    (Y-IDX)
               MOVE  LNK-S02-KAISUU (Y-IDX) TO Y-IDX3
               PERFORM VARYING     Y-IDX2   FROM    1   BY  1
                       UNTIL       Y-IDX2   >       Y-IDX3
                    MOVE    1      TO    YAKFTN-KAISUU   (Y-IDX Y-IDX2)
              END-PERFORM
           END-PERFORM.
      *
      *----(01.00.04) LINE ADD START -------------------------------------
      *    ÌôºÞ°ìÉôÉéÃ´¶â¤Î¾å¸Â³ÛÈ½ÄêÍÑ¤Ë¿ÇÎÅ¶èÊ¬ÊÌ¤ÎÌôºÞÅÀ¿ô¤ò¼èÆÀ
           PERFORM VARYING     Y-IDX    FROM    1   BY  1
                   UNTIL      (Y-IDX                    >   40   )  OR
                              (LNK-S02-SRYKBN(Y-IDX)    =   SPACE)
               PERFORM   VARYING   Y-IDX2    FROM   1   BY   1
                         UNTIL     Y-IDX2    >          40
                        IF   LNK-S02-ZAIBAN(Y-IDX)  =  
                                              WK-TOYAKU-ZAIBAN(Y-IDX2)
                             MOVE   41      TO   Y-IDX2
                        ELSE
                          IF   WK-TOYAKU-ZAIBAN(Y-IDX2)    =   ZERO
                              MOVE   LNK-S02-SRYKBN(Y-IDX) TO
                                              WK-TOYAKU-SRYKBN(Y-IDX2)
                              MOVE   LNK-S02-ZAIBAN(Y-IDX) TO
                                              WK-TOYAKU-ZAIBAN(Y-IDX2)
                              IF     LNK-S02-SRYKBN(Y-IDX)  =  "21" OR
                                                               "22"
                                  COMPUTE    WK-TOYAKU-ZAITEN(Y-IDX2)
                                          =  LNK-S02-TENSUU(Y-IDX)
                                          *  LNK-S02-KAISUU(Y-IDX)
                              ELSE
                                  MOVE   LNK-S02-TENSUU(Y-IDX) TO
                                              WK-TOYAKU-ZAITEN(Y-IDX2)
                              END-IF
                              MOVE   41       TO   Y-IDX2
                          END-IF
                        END-IF
               END-PERFORM
           END-PERFORM.
           PERFORM    VARYING    Y-IDX   FROM  1   BY   1
                      UNTIL     (Y-IDX       >   40)    OR
                                (WK-TOYAKU-SRYKBN(Y-IDX)   =    SPACE)
                  EVALUATE    WK-TOYAKU-SRYKBN(Y-IDX)
                      WHEN    "21"
                          ADD   WK-TOYAKU-ZAITEN(Y-IDX)    TO
                                                    WK-TOYAKU-TENSU(1)
                      WHEN    "22"
                          ADD   WK-TOYAKU-ZAITEN(Y-IDX)    TO
                                                    WK-TOYAKU-TENSU(2)
                      WHEN    "23"
                          ADD   WK-TOYAKU-ZAITEN(Y-IDX)    TO
                                                    WK-TOYAKU-TENSU(3)
                  END-EVALUATE
           END-PERFORM.
           COMPUTE    WK-TOYAKU-TENSU(1)  =  WK-TOYAKU-TENSU(1) *  10.
           COMPUTE    WK-TOYAKU-TENSU(2)  =  WK-TOYAKU-TENSU(2) *  10.
           COMPUTE    WK-TOYAKU-TENSU(3)  =  WK-TOYAKU-TENSU(3) *  10.
      *               
      *----(01.00.04) LINE ADD END   -------------------------------------
      *
       YAKFTN-TABLE-SET-EXT.
           EXIT.
      *
      ******************************************************************
      *    ÌôºÞ°ìÉôÉéÃ´¶â¥Æ¡¼¥Ö¥ë¤òºÆ¸¡º÷¤·¤ÆÆ±°ìÌôºÞ¤Î¼ïÎà¿ô¤ò·×»»    *
      ******************************************************************
       YAKFTN-KAISUU-HENSYU-SEC          SECTION.
      *
      *        ¿ÇÎÅ¶èÊ¬¡¦¿ÇÎÅ¥³¡¼¥É¤ÇÊÂ¤ÓÂØ¤¨
      *
      *   (2001/03/07  ŽÂŽ²Ž¶)
           MOVE   YAKFTN-TABLE      TO    YAKFTN-TABLE2.
           PERFORM VARYING     Y-IDX   FROM    1   BY  1
                   UNTIL      (YAKFTN-SRYKBN2(Y-IDX)    =   SPACE)  OR
                              (Y-IDX                   >   39   )
               COMPUTE Y-IDX2  =   Y-IDX       +   1
               PERFORM VARYING     Y-IDX3  FROM    Y-IDX2  BY  1
                       UNTIL      (YAKFTN-SRYKBN2(Y-IDX3) = SPACE)  OR
                                  (Y-IDX3              >   40   )
                   IF      YAKFTN-KEY2 (Y-IDX) > YAKFTN-KEY2 (Y-IDX3)
                       MOVE    YAKFTN-TBL-OCC2(Y-IDX)   TO
                                               WK-SRT-YAKFTN-TABLE
                       MOVE    YAKFTN-TBL-OCC2(Y-IDX3)  TO
                                               YAKFTN-TBL-OCC2(Y-IDX)
                       MOVE    WK-SRT-YAKFTN-TABLE     TO
                                               YAKFTN-TBL-OCC2(Y-IDX3)
                   END-IF
               END-PERFORM
           END-PERFORM.       
           MOVE   YAKFTN-TABLE2     TO    YAKFTN-TABLE.
      *   (2001/03/07  ŽÂŽ²Ž¶ ŽµŽÜŽØ)
      *//     PERFORM VARYING     Y-IDX   FROM    1   BY  1
      *//             UNTIL      (YAKFTN-SRYKBN(Y-IDX)    =   SPACE)  OR
      *//                        (Y-IDX                   >   39   )
      *//         COMPUTE Y-IDX2  =   Y-IDX       +   1
      *//        PERFORM VARYING     Y-IDX3  FROM    Y-IDX2  BY  1
      *//                 UNTIL      (YAKFTN-SRYKBN(Y-IDX3) = SPACE)  OR
      *//                            (Y-IDX3              >   40   )
      *//             IF      YAKFTN-KEY (Y-IDX) > YAKFTN-KEY (Y-IDX3)
      *//                 MOVE    YAKFTN-TBL-OCC(Y-IDX)   TO
      *//                                         WK-SRT-YAKFTN-TABLE
      *//                 MOVE    YAKFTN-TBL-OCC(Y-IDX3)  TO
      *//                                         YAKFTN-TBL-OCC(Y-IDX)
      *//                 MOVE    WK-SRT-YAKFTN-TABLE     TO
      *//                                         YAKFTN-TBL-OCC(Y-IDX3)
      *//            END-IF
      *//         END-PERFORM
      *//     END-PERFORM.       
      *
      *     DISPLAY  "*****  ŽºŽ°ŽÄŽÞŽÅŽ×ŽËŽÞŽ¶Ž´ŽºŽÞ *******".
      *     PERFORM   VARYING  DSP-IDX   FROM   1   BY   1
      *                UNTIL  DSP-IDX   >   10
      *         DISPLAY  "YAKFTN-SRYCD(DSP-IDX)  = "
      *                                   YAKFTN-SRYCD(DSP-IDX)
      *         DISPLAY  "YAKFTN-ZAIBAN(DSP-IDX) = "
      *                                   YAKFTN-ZAIBAN(DSP-IDX)
      *         DISPLAY  "YAKFTN-TENSUU(DSP-IDX) = "
      *                                   YAKFTN-TENSUU(DSP-IDX)
      *       PERFORM    VARYING   DSP-IDX2   FROM  1  BY  1
      *                  UNTIL     DSP-IDX2   >   5  
      *         DISPLAY "YAKFTN-KAISUU(" DSP-IDX ":" DSP-IDX2 ") = "
      *                           YAKFTN-KAISUU(DSP-IDX DSP-IDX2)
      *       END-PERFORM
      *     END-PERFORM.                             
      *               
      *
      *        ¿ÇÎÅ¶èÊ¬¡¦¿ÇÎÅ¥³¡¼¥ÉÊÌ¤ËÉþÍÑ´ü´Ö¤ÎÊÔ½¸
           MOVE    ZERO                 TO  WK-KAISUU-TABLE
           MOVE    1                    TO  Y-IDX
           PERFORM UNTIL      (YAKFTN-SRYKBN(Y-IDX)   =   SPACE)   OR
                              (Y-IDX                   >   40  )
               MOVE    YAKFTN-KEY   (Y-IDX)     TO  WK-KEY-SRY
               MOVE    YAKFTN-KAISUU-TABLE(Y-IDX)
                                                TO  WK-KAISUU-TABLE
               MOVE    YAKFTN-TENSUU(Y-IDX)
                                                TO  WK-YAKFTN-TENSUU
               ADD     1                        TO  Y-IDX
               PERFORM UNTIL      (YAKFTN-SRYKBN(Y-IDX)  =  SPACE) OR
                                  (Y-IDX                 >  40   ) OR
                                  (WK-KEY-SRY              NOT =
                                                  YAKFTN-KEY (Y-IDX))
      *
                   PERFORM VARYING Y-IDX3  FROM    1   BY  1
                           UNTIL   Y-IDX3  >       YAKFTN-MAX (Y-IDX)
                       IF      WK-KAISUU    (Y-IDX3)   =   1
                             AND  YAKFTN-TENSUU(Y-IDX)  >  20   AND
                                  WK-YAKFTN-TENSUU      >  20
                           MOVE  ZERO  TO  YAKFTN-KAISUU(Y-IDX Y-IDX3)
                       END-IF
      *                 IF  YAKFTN-TENSUU (Y-IDX)  <=   20
      *                     MOVE  1     TO  YAKFTN-KAISUU(Y-IDX Y-IDX3)
      *                 END-IF
                   END-PERFORM
      *
                   PERFORM VARYING Y-IDX3  FROM    1   BY  1
                           UNTIL   Y-IDX3  > YAKFTN-MAX (Y-IDX)
                       IF      YAKFTN-KAISUU(Y-IDX Y-IDX3) =  1
                           MOVE    1       TO  WK-KAISUU   (Y-IDX3)
                       END-IF
                   END-PERFORM
      *
                   MOVE    YAKFTN-TENSUU(Y-IDX)    TO  WK-YAKFTN-TENSUU
                   ADD     1                       TO  Y-IDX
              END-PERFORM
      *
           END-PERFORM.       
      *
      *     DISPLAY  "*****  ŽÌŽ¸ŽÖŽ³Ž·Ž¶ŽÝŽÍŽÝŽ¼ŽÕŽ³ŽºŽÞ *******".
      *     PERFORM   VARYING  DSP-IDX   FROM   1   BY   1
      *                UNTIL  DSP-IDX   >   10
      *         DISPLAY  "YAKFTN-SRYCD(DSP-IDX)  = "
      *                                   YAKFTN-SRYCD(DSP-IDX)
      *         DISPLAY  "YAKFTN-ZAIBAN(DSP-IDX) = "
      *                                   YAKFTN-ZAIBAN(DSP-IDX)
      *         DISPLAY  "YAKFTN-TENSUU(DSP-IDX) = "
      *                                   YAKFTN-TENSUU(DSP-IDX)
      *       PERFORM    VARYING   DSP-IDX2   FROM  1  BY  1
      *                  UNTIL     DSP-IDX2   >   5  
      *         DISPLAY "YAKFTN-KAISUU(" DSP-IDX ":" DSP-IDX2 ") = "
      *                           YAKFTN-KAISUU(DSP-IDX DSP-IDX2)
      *       END-PERFORM
      *     END-PERFORM.                             
      *               
      *
       YAKFTN-KAISUU-HENSYU-EXT.
           EXIT.
      *
      ******************************************************************
      *    ÌôºÞ°ìÉôÉéÃ´¶â¥Æ¡¼¥Ö¥ë¤òºÆ¸¡º÷¤·¤ÆºÞÈÖ¹æÊÌ¤ÎÌôºÞ¿ô¤ò·×»»    *
      ******************************************************************
       YAKFTN-SAI-KEISAN-SEC                SECTION.
      *
      *        ºÞÈÖ¹æ¤ÇÊÂ¤ÓÂØ¤¨
           PERFORM VARYING     Y-IDX   FROM    1   BY  1
                   UNTIL      (YAKFTN-SRYKBN(Y-IDX)  =  SPACE) OR
                              (Y-IDX                 >  39   )
               COMPUTE Y-IDX2  =   Y-IDX       +   1
               PERFORM VARYING     Y-IDX3  FROM    Y-IDX2  BY  1
                       UNTIL      (YAKFTN-SRYKBN(Y-IDX3) = SPACE)  OR
                                  (Y-IDX3                >   40 )
                   IF     YAKFTN-ZAIBAN(Y-IDX) > YAKFTN-ZAIBAN(Y-IDX3)
                       MOVE    YAKFTN-TBL-OCC(Y-IDX)  TO
                                                WK-SRT-YAKFTN-TABLE
                       MOVE    YAKFTN-TBL-OCC(Y-IDX3) TO
                                                YAKFTN-TBL-OCC(Y-IDX)
                       MOVE    WK-SRT-YAKFTN-TABLE    TO
                                                YAKFTN-TBL-OCC(Y-IDX3)
                   END-IF
               END-PERFORM
           END-PERFORM.       
      *
      *
      *     DISPLAY  "*****  Ž»ŽÞŽ²ŽÊŽÞŽÝŽºŽÞŽ³ŽÅŽ×ŽËŽÞŽ¶Ž´ŽºŽÞ*******".
      *     PERFORM   VARYING  DSP-IDX   FROM   1   BY   1
      *                UNTIL  DSP-IDX   >   10
      *         DISPLAY  "YAKFTN-SRYCD(DSP-IDX)  = "
      *                                   YAKFTN-SRYCD(DSP-IDX)
      *         DISPLAY  "YAKFTN-ZAIBAN(DSP-IDX) = "
      *                                   YAKFTN-ZAIBAN(DSP-IDX)
      *         DISPLAY  "YAKFTN-TENSUU(DSP-IDX) = "
      *                                   YAKFTN-TENSUU(DSP-IDX)
      *       PERFORM    VARYING   DSP-IDX2   FROM  1  BY  1
      *                  UNTIL     DSP-IDX2   >   5  
      *         DISPLAY "YAKFTN-KAISUU(" DSP-IDX ":" DSP-IDX2 ") = "
      *                           YAKFTN-KAISUU(DSP-IDX DSP-IDX2)
      *       END-PERFORM
      *     END-PERFORM.                             
      *               
      *        ºÞÈÖ¹æÊÌ¤ËÌôºÞ¿ô¤ò·×»»
      *----(01.00.03) LINE ADD START -------------------------------------
           MOVE    ZERO                 TO  FLG-ZAIGATAKBN
      *----(01.00.03) LINE ADD END   -------------------------------------
           MOVE    1                    TO  Y-IDX
           MOVE    ZERO                 TO  Y-IDX4
           PERFORM UNTIL      (YAKFTN-SRYKBN(Y-IDX)   =   SPACE)   OR
                              (Y-IDX                   >   40  )
               ADD     1                        TO  Y-IDX4
               MOVE    YAKFTN-SRYKBN  (Y-IDX)   TO
                                           YAKFTN-ZAI-SRYKBN  (Y-IDX4)
               MOVE    YAKFTN-ZAIBAN  (Y-IDX)   TO
                                           YAKFTN-ZAI-ZAIBAN  (Y-IDX4)
               MOVE    YAKFTN-SRYCD   (Y-IDX)   TO
                                           YAKFTN-ZAI-SRYCD   (Y-IDX4)
               MOVE    YAKFTN-TENSUU  (Y-IDX)   TO
                                           YAKFTN-ZAI-TENSUU  (Y-IDX4)
               MOVE    YAKFTN-ZAIBAN  (Y-IDX)   TO
                                           WK-KEY-ZAIBAN
               MOVE    ZERO                     TO
                                           WK-ZAI-KAISUU-TABLE
      *-------------------------------------------------------------------
           MOVE    ZERO                 TO  FLG-ZAIGATAKBN
      *----(01.00.03) LINE ADD END   -------------------------------------
              PERFORM UNTIL  (YAKFTN-SRYKBN(Y-IDX)  =  SPACE)   OR
                             (Y-IDX                 >  40   )   OR
                             (WK-KEY-ZAIBAN   NOT =
                                                YAKFTN-ZAIBAN(Y-IDX))
      *
      *----(01.00.03) LINE ADD START -------------------------------------
                 MOVE    ZERO                    TO  FLG-ADDKBN
      *
      *        ¡ÊÆâÉþÌôºÞ¤Îº®¹ç¡Ë
                 IF      YAKFTN-SRYKBN (Y-IDX)   =   "21"
                     INITIALIZE                      TNS-TENSU-REC
                     MOVE    YAKFTN-SRYCD (Y-IDX)    TO  TNS-SRYCD
                     MOVE    LNK-SYU-SRYYMD          TO  ORC-DBYMD
                     PERFORM TENSU-READ-SEC
                     IF      TNS-ZAIGATAKBN          =   "1" OR
                                                         "2" OR
                                                         "3"
                        IF      FLG-ZAIGATAKBN       =   1
                            MOVE    1                TO  FLG-ADDKBN
                        END-IF
                        MOVE    1                    TO  FLG-ZAIGATAKBN
                     END-IF        
                 END-IF
                 IF     FLG-ADDKBN              =   ZERO
      *----(01.00.03) LINE ADD END   -------------------------------------
                    PERFORM VARYING Y-IDX3  FROM    1   BY  1
                            UNTIL   Y-IDX3  >       YAKFTN-MAX (Y-IDX)
                        IF      YAKFTN-KAISUU(Y-IDX Y-IDX3)   >   0
                            ADD     YAKFTN-KAISUU(Y-IDX Y-IDX3)
                                            TO  WK-ZAI-KAISUU (Y-IDX3)
                            IF      Y-IDX3    >  YAKFTN-ZAI-MAX(Y-IDX4)
                                MOVE Y-IDX3  TO  YAKFTN-ZAI-MAX(Y-IDX4)
                            END-IF
                        END-IF
                    END-PERFORM
                END-IF    
      *
                ADD     1                       TO  Y-IDX      
              END-PERFORM
              MOVE    WK-ZAI-KAISUU-TABLE     TO
                                      YAKFTN-ZAI-KAISUU-TABLE (Y-IDX4)
           END-PERFORM.
      *
      *     DISPLAY "*** ZAIBANGTOU BETSU YAKUZAISUU KEISANGO  ***".
      *
      *     PERFORM   VARYING  DSP-IDX   FROM   1   BY   1
      *                UNTIL  DSP-IDX   >   10
      *         DISPLAY  "YAKFTN-ZAI-SRYCD(DSP-IDX)  = "
      *                                   YAKFTN-ZAI-SRYCD(DSP-IDX)
      *         DISPLAY  "YAKFTN-ZAI-ZAIBAN(DSP-IDX) = "
      *                                   YAKFTN-ZAI-ZAIBAN(DSP-IDX)
      *         DISPLAY  "YAKFTN-ZAI-TENSUU(DSP-IDX) = "
      *                                   YAKFTN-ZAI-TENSUU(DSP-IDX)
      *       PERFORM    VARYING   DSP-IDX2   FROM  1  BY  1
      *                  UNTIL     DSP-IDX2   >   5  
      *         DISPLAY "YAKFTN-ZAI-KAISUU(" DSP-IDX ":" DSP-IDX2 ") = "
      *                           YAKFTN-ZAI-KAISUU(DSP-IDX DSP-IDX2)
      *       END-PERFORM
      *     END-PERFORM.                             
      *               
      *
           PERFORM VARYING     Y-IDX   FROM    1   BY  1
                   UNTIL   (YAKFTN-ZAI-SRYKBN(Y-IDX)   =   SPACE)  OR
                           (Y-IDX                      >   40  )
      *        ¡Ê£²£°ÅÀ°Ê²¼ÂÐ±þ¡Ë
               IF      YAKFTN-ZAI-TENSUU (Y-IDX)   <=  20
                   PERFORM VARYING Y-IDX2  FROM    1   BY  1
                           UNTIL   Y-IDX2  >     YAKFTN-ZAI-MAX(Y-IDX)
                       IF      YAKFTN-ZAI-KAISUU (Y-IDX Y-IDX2) >   0
                           MOVE    1               TO
                                     YAKFTN-ZAI-KAISUU (Y-IDX Y-IDX2)
                       END-IF
                   END-PERFORM
               END-IF
      *        ¡Ê³°ÍÑÌô¤Îº®¹ç¡Ë
               IF      YAKFTN-ZAI-SRYKBN (Y-IDX)   =   "23"
                   PERFORM VARYING Y-IDX2  FROM    1   BY  1
                           UNTIL   Y-IDX2  >    YAKFTN-ZAI-MAX(Y-IDX)
                       IF      YAKFTN-ZAI-KAISUU (Y-IDX Y-IDX2) >   0
                           MOVE    1               TO
                                     YAKFTN-ZAI-KAISUU (Y-IDX Y-IDX2)
                       END-IF
                   END-PERFORM
               END-IF
           END-PERFORM.
      *
       YAKFTN-SAI-KEISAN-EXT.
           EXIT.
      *
      ******************************************************************
      *    ÌôºÞ°ìÉôÉéÃ´¶â¥Æ¡¼¥Ö¥ë¤òºÆ¸¡º÷¤·¤ÆºÞÈÖ¹æÊÌ¤ÎÌôºÞ¿ô¤ò·×»»    *
      ******************************************************************
       YAKFTN-KINGAKU-KEISAN-SEC                SECTION.
      *
      *----(01.00.01) LINE MOD START -------------------------------
      *
      *    MOVE    ZERO                 TO  YAKFTN-SOGOKEI
      *
      *    PERFORM VARYING     Y-IDX   FROM    1   BY  1
      *          UNTIL      (YAKFTN-ZAI-SRYKBN(Y-IDX)   =   SPACE)   OR
      *                       (Y-IDX                      >   40  )
      *      PERFORM VARYING Y-IDX2  FROM    1   BY  1
      *              UNTIL   Y-IDX2  >       YAKFTN-ZAI-MAX(Y-IDX)
      *          IF      YAKFTN-ZAI-KAISUU(Y-IDX Y-IDX2)    >   0
      *              EVALUATE    TRUE
      *                  WHEN  YAKFTN-ZAI-SRYKBN(Y-IDX)    =   "21" AND
      *                        YAKFTN-ZAI-KAISUU(Y-IDX Y-IDX2) =   1
      *                      MOVE    ZERO             TO  WK-FUTAN
      *                  WHEN  YAKFTN-ZAI-SRYKBN(Y-IDX)    =   "21" AND
      *                        YAKFTN-ZAI-KAISUU(Y-IDX Y-IDX2) = 2 OR 3
      *                      MOVE    30               TO  WK-FUTAN
      *                  WHEN  YAKFTN-ZAI-SRYKBN(Y-IDX)    =   "21" AND
      *                      YAKFTN-ZAI-KAISUU(Y-IDX Y-IDX2) =  4 OR 5
      *                      MOVE    60               TO  WK-FUTAN
      *                  WHEN  YAKFTN-ZAI-SRYKBN(Y-IDX)    =   "21" AND
      *                        YAKFTN-ZAI-KAISUU(Y-IDX Y-IDX2) >  5
      *                      MOVE    100              TO  WK-FUTAN
      *                  WHEN  YAKFTN-ZAI-SRYKBN(Y-IDX)    =   "22" 
      *                      COMPUTE  WK-FUTAN    =   
      *                        YAKFTN-ZAI-KAISUU(Y-IDX Y-IDX2)  *   10
      *                  WHEN  YAKFTN-ZAI-SRYKBN(Y-IDX)    =   "23" AND
      *                        YAKFTN-ZAI-KAISUU(Y-IDX Y-IDX2) =   1
      *	                     MOVE     50              TO  WK-FUTAN    
      *                  WHEN  YAKFTN-ZAI-SRYKBN(Y-IDX)    =   "23" AND
      *                        YAKFTN-ZAI-KAISUU(Y-IDX Y-IDX2) =   2
      *                     MOVE     100              TO  WK-FUTAN
      *                  WHEN  YAKFTN-ZAI-SRYKBN(Y-IDX)    =  "23" AND
      *                        YAKFTN-ZAI-KAISUU(Y-IDX Y-IDX2) >   2
      *                     MOVE     150              TO  WK-FUTAN
      *              END-EVALUATE
      *              ADD     WK-FUTAN             TO  YAKFTN-SOGOKEI
      *          END-IF
      *      END-PERFORM
      *    END-PERFORM.
      *
      *
           MOVE    ZERO                 TO  YAKFTN-SOGOKEI
      *
           PERFORM VARYING     Y-IDX   FROM    1   BY  1
                 UNTIL      (YAKFTN-ZAI-SRYKBN(Y-IDX)   =   SPACE)   OR
                              (Y-IDX                      >   40  )
             PERFORM VARYING Y-IDX2  FROM    1   BY  1
                     UNTIL   Y-IDX2  >       YAKFTN-ZAI-MAX(Y-IDX)
                 IF      YAKFTN-ZAI-KAISUU(Y-IDX Y-IDX2)    >   0
                     EVALUATE    TRUE
                         WHEN  YAKFTN-ZAI-SRYKBN(Y-IDX)    =   "21"
                               ADD  YAKFTN-ZAI-KAISUU(Y-IDX Y-IDX2) TO
                                    YAKFTN-TOTAL-KAISUU(1 Y-IDX2)
                         WHEN  YAKFTN-ZAI-SRYKBN(Y-IDX)    =   "22"
                               ADD  YAKFTN-ZAI-KAISUU(Y-IDX Y-IDX2) TO
                                    YAKFTN-TOTAL-KAISUU(2 Y-IDX2)
                         WHEN  YAKFTN-ZAI-SRYKBN(Y-IDX)    =   "23"
                               ADD  YAKFTN-ZAI-KAISUU(Y-IDX Y-IDX2) TO
                                    YAKFTN-TOTAL-KAISUU(3 Y-IDX2)
                     END-EVALUATE
                 END-IF
             END-PERFORM
           END-PERFORM.
      *
           PERFORM VARYING     Y-IDX   FROM    1   BY  1
                   UNTIL     (Y-IDX               >   3  )
             PERFORM VARYING Y-IDX2  FROM    1   BY  1
                     UNTIL    (Y-IDX2              >       180)
                 IF      YAKFTN-TOTAL-KAISUU(Y-IDX Y-IDX2)    >   0
                     EVALUATE    TRUE
                         WHEN  Y-IDX       =     1     AND
                               YAKFTN-TOTAL-KAISUU(Y-IDX Y-IDX2) =   1
                             MOVE    ZERO             TO  WK-FUTAN
                         WHEN  Y-IDX       =     1     AND
                               YAKFTN-TOTAL-KAISUU(Y-IDX Y-IDX2) = 2
                             MOVE    30               TO  WK-FUTAN
                         WHEN  Y-IDX       =     1     AND
                               YAKFTN-TOTAL-KAISUU(Y-IDX Y-IDX2) = 3
                             MOVE    30               TO  WK-FUTAN
                         WHEN  Y-IDX       =     1     AND
                             YAKFTN-TOTAL-KAISUU(Y-IDX Y-IDX2) =   4
                             MOVE    60               TO  WK-FUTAN
                         WHEN  Y-IDX       =     1     AND
                             YAKFTN-TOTAL-KAISUU(Y-IDX Y-IDX2) =   5
                             MOVE    60               TO  WK-FUTAN
                         WHEN  Y-IDX       =     1     AND
                               YAKFTN-TOTAL-KAISUU(Y-IDX Y-IDX2) >  5
                             MOVE    100              TO  WK-FUTAN
                         WHEN  Y-IDX       =     2 
                             COMPUTE  WK-FUTAN    =   
                               YAKFTN-TOTAL-KAISUU(Y-IDX Y-IDX2)  *  10
                         WHEN  Y-IDX       =     3     AND
                               YAKFTN-TOTAL-KAISUU(Y-IDX Y-IDX2) =   1
      	                     MOVE     50              TO  WK-FUTAN    
                         WHEN  Y-IDX       =     3     AND
                               YAKFTN-TOTAL-KAISUU(Y-IDX Y-IDX2) =   2
                            MOVE     100              TO  WK-FUTAN
                         WHEN  Y-IDX       =     3     AND
                               YAKFTN-TOTAL-KAISUU(Y-IDX Y-IDX2) >   2
                            MOVE     150              TO  WK-FUTAN
                     END-EVALUATE
                     EVALUATE    Y-IDX
                         WHEN    1
                                ADD    WK-FUTAN   TO  WK-NAI-FUTAN
                         WHEN    2
                                ADD    WK-FUTAN   TO  WK-TON-FUTAN
                         WHEN    3
                                ADD    WK-FUTAN   TO  WK-GAI-FUTAN
                     END-EVALUATE
      *----(01.00.04) LINE DEL START -------------------------------
      ***           ADD     WK-FUTAN             TO  YAKFTN-SOGOKEI
      *----(01.00.04) LINE DEL END   -------------------------------
                 END-IF
             END-PERFORM
           END-PERFORM.
      *----(01.00.01) LINE MOD END   -------------------------------
      *
      *----(01.00.04) LINE ADD START -------------------------------
      **     IF    WK-TOYAKU-TENSU(1)     <   WK-NAI-FUTAN
      **          MOVE    WK-TOYAKU-TENSU(1)   TO   WK-NAI-FUTAN
      **     END-IF. 
      **     IF    WK-TOYAKU-TENSU(2)     <   WK-TON-FUTAN
      **           MOVE    WK-TOYAKU-TENSU(2)   TO   WK-TON-FUTAN
      **     END-IF. 
      **     IF    WK-TOYAKU-TENSU(3)     <   WK-GAI-FUTAN
      **           MOVE    WK-TOYAKU-TENSU(3)   TO   WK-GAI-FUTAN
      **     END-IF. 
           COMPUTE   YAKFTN-SOGOKEI   =   WK-NAI-FUTAN   +
                                          WK-TON-FUTAN   +
                                          WK-GAI-FUTAN.
           COMPUTE   WK-TOYAKU-TENSU(4)   =    WK-TOYAKU-TENSU(1)    +
                                               WK-TOYAKU-TENSU(2)    +
                                               WK-TOYAKU-TENSU(3).
           IF        YAKFTN-SOGOKEI       >    WK-TOYAKU-TENSU(4)
               MOVE  WK-TOYAKU-TENSU(4)   TO   YAKFTN-SOGOKEI
           END-IF.
      *----(01.00.04) LINE ADD END   -------------------------------
      *      
       YAKFTN-KINGAKU-KEISAN-EXT.
           EXIT.
      *
      ******************************************************************
      *    ÊÝ¸±ÀÚ¤êÂØ¤¨»þ¤Î·ÑÂ³¿ÇÎÅÆþÎÏ¤¬¤µ¤ì¤¿¾ì¹ç¤ÎÁ°ÆþÎÏÊ¬
      *    ¤ÎÌôºÞ°ìÉôÉéÃ´¶â¤Î»»½Ð¡Ê¼ýÇ¼¥Æ¡¼¥Ö¥ë¤è¤ê¡Ë
      ******************************************************************
       YAKFTN-CONT-SEC                SECTION.
      *
           MOVE    LNK-SYU-HOSPID       TO     SYU-HOSPID.
           MOVE    LNK-SYU-NYUGAIKBN    TO     SYU-NYUGAIKBN.
           MOVE    LNK-SYU-PTID         TO     SYU-PTID.
           MOVE    LNK-SYU-DOUJI-DENPNUM TO    SYU-DOUJI-DENPNUM.
           MOVE    SYU-SYUNOU-REC       TO     MCPDATA-REC.
           MOVE    "DBSELECT"           TO     MCP-FUNC.
           MOVE    "SYUNOU-KEY3"        TO     ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING  MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC.
           IF      MCP-RC               =      ZERO
               MOVE    "SYUNOU-KEY3"    TO     ORC-DBPATH
               PERFORM  SYUNOU-READ-SEC
               PERFORM  UNTIL  (FLG-SYUNOU   =    "1")
                   IF  WK-CONT-YAKFTNKIN1    =    ZERO
                       MOVE   SYU-RESE-YKZ-FTN
                                        TO     WK-CONT-YAKFTNKIN1
                   ELSE
                       MOVE   SYU-RESE-YKZ-FTN
                                        TO     WK-CONT-YAKFTNKIN2
                   END-IF
                   MOVE      "SYUNOU-KEY3"  TO     ORC-DBPATH
                   PERFORM   SYUNOU-READ-SEC
               END-PERFORM
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "SYUNOU-KEY3"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
      *    ¥È¡¼¥¿¥ë¤ÎÌôºÞ°ìÉôÉéÃ´¶â¤«¤éÁ°¿ÇÎÅ¤ÎÌôºÞ°ìÉôÉéÃ´¶â¤ò¸º»»
           COMPUTE   YAKFTN-SOGOKEI   =   YAKFTN-SOGOKEI
                                      -   WK-CONT-YAKFTNKIN1
                                      -   WK-CONT-YAKFTNKIN2.
      *
       YAKFTN-CONT-EXT.
           EXIT.
      *
      ******************************************************************
      *    ÌôºÞ°ìÉôÉéÃ´¶â¤Î¾å¸Â³Û¤ò¼çÊÝ¸±¤ÎÊÝ¸±ÉéÃ´¶â³Û¤Þ¤Ç¤È¤¹¤ë      *
      ******************************************************************
       YAKFTN-JOUGEN-HANTEI-SEC                SECTION.
      *
           MOVE    ZERO                 TO  YAKFTN-JOUGEN
      *
           IF    (COMB-KOH1-HKNKOHSBTKBN   =   "3")   OR
                 (COMB-KOH2-HKNKOHSBTKBN   =   "3")   OR
                 (COMB-KOH3-HKNKOHSBTKBN   =   "3")   OR
                 (COMB-KOH4-HKNKOHSBTKBN   =   "3")
               CONTINUE
           ELSE
               INITIALIZE                      HKNNUM-REC
               MOVE   COMB-HOSPID        TO    HKN-HOSPID
               MOVE   COMB-HKNNUM        TO    HKN-HKNNUM
               MOVE   "00"               TO    WK-PAYKBN
               MOVE   HKNNUM-REC         TO    MCPDATA-REC
               MOVE   "DBSELECT"         TO    MCP-FUNC
               MOVE   "HKNNUM-KEY2"      TO    ORC-DBPATH
               CALL   "ORCMCPSUB"         USING MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
               IF      MCP-RC            =     ZERO
                   MOVE    "HKNNUM-KEY2" TO    ORC-DBPATH
                   PERFORM  HKNNUM-READ-SEC
                   PERFORM  UNTIL 
                     (FLG-HKNNUM     =    1)                       OR
                     (HKN-TEKSTYMD(1:6)   <=  LNK-SYU-SRYYMD(1:6)) AND
                     (LNK-SYU-SRYYMD(1:6) <=  HKN-TEKEDYMD(1:6))   AND
                     (WK-PAYKBN            =  HKN-PAYKBN)
                       PERFORM   HKNNUM-READ-SEC
                   END-PERFORM
                   IF     FLG-HKNNUM     =       0
                       PERFORM   YAKFTN-JOUGEN-SANTEI-SEC
                       IF    YAKFTN-SOGOKEI     >=   YAKFTN-JOUGEN
                           MOVE    YAKFTN-JOUGEN   TO  YAKFTN-SOGOKEI
                       END-IF
                   END-IF
               END-IF
      *
               MOVE    "DBCLOSE"         TO  MCP-FUNC
               MOVE    "HKNNUM-KEY2"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"        USING
                                          MCPAREA
                                          ORCMCPAREA
                                          MCPDATA-REC
      *
           END-IF.
      *
       YAKFTN-JOUGEN-HANTEI-EXT.
           EXIT.
      *
      ******************************************************************
      *    ÌôºÞ°ìÉôÉéÃ´¶â¤Î¾å¸Â³Û¤ò»»Äê¤¹¤ë                            *
      ******************************************************************
       YAKFTN-JOUGEN-SANTEI-SEC                SECTION.
      *
           MOVE    ZERO             TO    YAKFTN-JOUGEN.
      *    ´µ¼ÔÉéÃ´¶â»»½ÐÁ°¤Î£±£°£°¡óÉéÃ´³Û»»½Ð
           MOVE      ZERO         TO      WK-ZENGAKU.
           PERFORM   VARYING   IDX     FROM    1   BY  1
                     UNTIL     IDX         >   11
               COMPUTE WK-ZENGAKU  =   WK-ZENGAKU  +
                                      (LNK-SYU-HKNTEN (IDX) * 10)
           END-PERFORM.
      *    ÊÝ¸±ÁÈ¹ç¤»¥Æ¡¼¥Ö¥ë¤ÎÊä½õ¶èÊ¬¤«¤éÊÝ¸±¤ÎÉéÃ´³ä¹ç¤òÊÝ¸±ÈÖ¹æ
      *    ¥Æ¡¼¥Ö¥ë¤ËºÆ¥»¥Ã¥È
           IF    COMB-HKNNUM           =    "060"
               EVALUATE   COMB-HOJOKBN
                   WHEN   "0"
                          MOVE   100       TO   HKN-HON-GAIKFTNRATE
                                                HKN-KZK-GAIKFTNRATE
                                                HKN-TSY-GAIKFTNRATE
                                                HKN-TNK-GAIKFTNRATE
                   WHEN   "1"
                          MOVE   90        TO   HKN-HON-GAIKFTNRATE
                                                HKN-KZK-GAIKFTNRATE
                                                HKN-TSY-GAIKFTNRATE
                                                HKN-TNK-GAIKFTNRATE
                   WHEN   "2"
                          MOVE   80        TO   HKN-HON-GAIKFTNRATE
                                                HKN-KZK-GAIKFTNRATE
                                                HKN-TSY-GAIKFTNRATE
                                                HKN-TNK-GAIKFTNRATE
                   WHEN   "3"
                          MOVE   70        TO   HKN-HON-GAIKFTNRATE
                                                HKN-KZK-GAIKFTNRATE
                                                HKN-TSY-GAIKFTNRATE
                                                HKN-TNK-GAIKFTNRATE
               END-EVALUATE
           ELSE
               COMPUTE   HKN-HON-GAIKFTNRATE
                         =  100  -  HKN-HON-GAIKFTNRATE
               COMPUTE   HKN-KZK-GAIKFTNRATE
                         =  100  -  HKN-KZK-GAIKFTNRATE
               COMPUTE   HKN-TSY-GAIKFTNRATE
                         =  100  -  HKN-TSY-GAIKFTNRATE
               COMPUTE   HKN-TNK-GAIKFTNRATE
                         =  100  -  HKN-TNK-GAIKFTNRATE
           END-IF.
      *
           EVALUATE    FLG-SANSHOU
               WHEN    "1"
                   IF   COMB-HONKZKKBN    =   "1"
                       IF   HKN-HON-GAIKFTNRATE  NOT =   ZERO
                            COMPUTE    WK-FUTANWARI  =
                                           HKN-HON-GAIKFTNRATE  /  100
                            COMPUTE    YAKFTN-JOUGEN    =
                                           WK-ZENGAKU * WK-FUTANWARI
                       END-IF
                   ELSE
                       IF   HKN-KZK-GAIKFTNRATE  NOT =   ZERO
                            COMPUTE    WK-FUTANWARI  =
                                           HKN-KZK-GAIKFTNRATE  /  100
                            COMPUTE    YAKFTN-JOUGEN    =
                                           WK-ZENGAKU * WK-FUTANWARI
                       END-IF
                   END-IF
               WHEN    "2"
                   IF   HKN-TSY-GAIKFTNRATE     NOT =   ZERO
                        COMPUTE    WK-FUTANWARI  =
                                       HKN-TSY-GAIKFTNRATE
                                                      /  100
                        COMPUTE    YAKFTN-JOUGEN    =
                                       WK-ZENGAKU * WK-FUTANWARI
                   END-IF
               WHEN    "3"
                   IF   HKN-TNK-GAIKFTNRATE     NOT =   ZERO
                        COMPUTE    WK-FUTANWARI  =
                                       HKN-TNK-GAIKFTNRATE
                                                      /  100
                        COMPUTE    YAKFTN-JOUGEN    =
                                       WK-ZENGAKU * WK-FUTANWARI
                   END-IF
           END-EVALUATE.
      *
       YAKFTN-JOUGEN-SANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ç¯¶âÍúÎòÆÉ¹þ
      *****************************************************************
       TNKRRK-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  TNKRRK-REC
               MOVE    ZERO            TO  FLG-TNKRRK
           ELSE
               INITIALIZE                  TNKRRK-REC
               MOVE    1               TO  FLG-TNKRRK
           END-IF
      *
           .
       TNKRRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    Äã½êÆÀ¼ÔÍúÎòÆÉ¹þ
      *****************************************************************
       TSYRRK-READ-SEC          SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  TSYRRK-REC
               MOVE    ZERO            TO  FLG-TSYRRK
           ELSE
               INITIALIZE                  TSYRRK-REC
               MOVE    1               TO  FLG-TSYRRK
           END-IF
      *
           .
       TSYRRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÊÝ¸±ÈÖ¹æ¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       HKNNUM-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  HKNNUM-REC
               MOVE    ZERO            TO  FLG-HKNNUM
           ELSE
               INITIALIZE                  HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
      *
           .
       HKNNUM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÊÝ¸±ÁÈ¹ç¤»¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       HKNCOMBI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  HKNCOMBI-REC
               MOVE    ZERO            TO  FLG-HKNCOMBI
           ELSE
               INITIALIZE                  HKNCOMBI-REC
               MOVE    1               TO  FLG-HKNCOMBI
           END-IF
      *
           .
       HKNCOMBI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1001-REC
                                           SYS-1026-REC
                                           SYS-1027-REC
                                           SYS-4001-REC
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               INITIALIZE                  SYS-1001-REC
                                           SYS-1026-REC
                                           SYS-1027-REC
                                           SYS-4001-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       SYSKANRI-READ-EXT.
           EXIT.
      *****************************************************************
      *    ¼ýÇ¼¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       SYUNOU-READ-SEC          SECTION.
      *
       SYUNOU-READ-100.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYU-SYUNOU-REC
               IF     (LNK-S01-SAIKEISAN-KBN    =   "1")    AND
                      (LNK-S01-SAIKEISAN-DENPYO <=   SYU-DENPNUM)
                       GO    TO    SYUNOU-READ-100
               ELSE
                       MOVE    ZERO    TO  FLG-SYUNOU
               END-IF
           ELSE
               INITIALIZE                  SYU-SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
           .
       SYUNOU-READ-EXT.
           EXIT.
      
      *****************************************************************
      *    ´µ¼Ô¾ðÊóÆÉ¹þ
      *****************************************************************
       PTINF-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTINF-REC
               MOVE    ZERO            TO  FLG-PTINF
           ELSE
               INITIALIZE                  PTINF-REC
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           .
       PTINF-READ-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    ÅÀ¿ô¥Þ¥¹¥¿¡¼ÆÉ¹þ¡Ê¼ç¥­¡¼¡Ë
      *****************************************************************
       TENSU-READ-SEC         SECTION.
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "TENSU-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
                   MOVE    ZERO                TO  FLG-TENSU
               ELSE
                   MOVE    1                   TO  FLG-TENSU
                   INITIALIZE                  TNS-TENSU-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-TENSU
               INITIALIZE                  TNS-TENSU-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       TENSU-READ-EXT.
           EXIT.
      