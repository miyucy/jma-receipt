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
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCR0430.
      *****************************************************************
      *  ¥·¥¹¥Æ¥àÌ¾        : £Ï£Ò£Ã£Á
      *  ¥µ¥Ö¥·¥¹¥Æ¥àÌ¾    : ¥ì¥»¥×¥È¡ÊÏ«ºÒ¡¦¼«ÇåÀÕ¡Ë
      *  ¥³¥ó¥Ý¡¼¥Í¥ó¥ÈÌ¾  : ·î¼¡¶ÈÌ³¡¡Ï«ºÒ¼«ÇåÀÕÌÀºÙ½ñ¥Õ¥¡¥¤¥ëºîÀ®
      *                      ¡Ê¥ì¥»¥×¥È¥³¥á¥ó¥ÈÊÔ½¸¡Ë 
      *  ´ÉÍý¼Ô            : 
      *  ºîÀ®ÆüÉÕ    ºî¶È¼Ô        µ­½Ò
      *  02/07/01    MCC-ÌçÏÆ¡¡    ¿·µ¬ºîÀ®
      *****************************************************************
      *  ¥×¥í¥°¥é¥à½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      *  01.00.01    NACL-ÌçÏÆ    02.09.18  ¼«ÇåÀÕÂÐ±þ¡¡¡¡¡¡¡¡¡¡¡¡
      *  01.00.02    NACL-ÌçÏÆ    02.11.29  Ê£¿ô¿ÇÎÅ²Ê¼õ¿Ç¤Î
      *                                     ¥³¥á¥ó¥Èº¹¹þ¤ß
      *  01.00.03    NACL-ÌçÏÆ    03.02.04  ºÞ¤Þ¤È¤áÂÐ±þÅù
      *  01.00.04    NACL-ÌçÏÆ    03.02.06  ¥³¥á¥ó¥È¥«¥¦¥ó¥È¥Õ¥é¥°¤Ç¤Î
      *                                     È½ÄêÄÉ²Ã
      *  01.00.05    NACL-ÌçÏÆ    03.03.03  ºÞÈÖ¹æ·å½¤ÀµÂÐ±þ
      *  01.00.06    NACL-ÌçÏÆ    03.03.12  £Ã£Ô¡¦£Í£Ò£É¤Î¼Â»ÜÆüÄÉ²Ã
      *  01.00.07    NACL-ÌçÏÆ    03.04.04  ½ýÉÂ¼êÅö¶â°Õ¸«½ñ¸òÉÕÎÁ¤Î¸òÉÕÆüÊÔ½¸
      *                                     ÎÅÍÜÈñÆ±°Õ½ñ¸òÉÕÎÁ¤Î¸òÉÕÆüÊÔ½¸
      *  01.00.08    NACL-ÌçÏÆ    03.04.24  Í¢·ì¤Ï¥³¥á¥ó¥ÈÊÔ½¸ÂÐ¾Ý³°¤È¤¹¤ë
      *  01.00.09    NACL-ÌçÏÆ    03.05.28  ¼õ¿ÇÍúÎò¥­¡¼¤ÎÊÑ¹¹
      *  01.00.10    NACL-ÌçÏÆ    03.06.19  Ê£¿ô¿ÇÎÅ²Ê¼õ¿Ç¤ÎÊÔ½¸½¤Àµ
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
           SELECT  RECE41-FILE     ASSIGN  RECE41PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE41-KEY
                                   FILE    STATUS  IS  STS-RECE41.
      *
           SELECT  RECE44-FILE     ASSIGN  RECE44PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE44-KEY
                                   FILE    STATUS  IS  STS-RECE44.
      *
           SELECT  RECE45-FILE     ASSIGN  RECE45PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE45-KEY
                                   FILE    STATUS  IS  STS-RECE45.
      *
           SELECT  RECE441-FILE    ASSIGN  RECE441PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE441-KEY
                                   FILE    STATUS  IS  STS-RECE441.
           SELECT  RECE4441-FILE   ASSIGN  RECE441PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE4441-KEY
                                   FILE    STATUS  IS  STS-RECE441.
      *
           SELECT  RECE451-FILE    ASSIGN  RECE451PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE451-KEY
                                   FILE    STATUS  IS  STS-RECE451.
           SELECT  RECE4551-FILE   ASSIGN  RECE451PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE4551-KEY
                                   FILE    STATUS  IS  STS-RECE451.
006900*    ¥¨¥é¡¼¥Õ¥¡¥¤¥ë
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
       FD  RECE41-FILE.
       01  RECE41-REC.
           COPY    "CPRCF041.INC".
      *
       FD  RECE44-FILE.
       01  RECE44-REC.
           COPY    "CPRCF044.INC".
      *
       FD  RECE45-FILE.
       01  RECE45-REC.
           COPY    "CPRCF045.INC".
      *
       FD  RECE441-FILE.
       01  RECE441-REC. 
           COPY    "CPRCF044.INC"  REPLACING   //RECE44//
                                   BY          //RECE441//.
      *
       FD  RECE451-FILE.
       01  RECE451-REC. 
           COPY    "CPRCF045.INC"  REPLACING   //RECE45//
                                   BY          //RECE451//.
      *
       FD  RECE4441-FILE.
       01  RECE4441-REC. 
           COPY    "CPRCF044.INC"  REPLACING   //RECE44//
                                   BY          //RECE4441//.
      *
       FD  RECE4551-FILE.
       01  RECE4551-REC. 
           COPY    "CPRCF045.INC"  REPLACING   //RECE45//
                                   BY          //RECE4551//.
      *    ¥¨¥é¡¼¥Õ¥¡¥¤¥ë
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *     ¥ì¥»¥×¥ÈÌÀºÙ¥Õ¥¡¥¤¥ë Ì¾¾ÎÎÎ°è 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE41//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE44//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE45//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE441//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE451//.
      *
      *    ¥¨¥é¡¼¥Õ¥¡¥¤¥ë Ì¾¾ÎÎÎ°è 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    ¥Õ¥é¥°ÎÎ°è
       01  STS-AREA.
           03  STS-RECE41          PIC X(02).
           03  STS-RECE44          PIC X(02).
           03  STS-RECE441         PIC X(02).
           03  STS-RECE45          PIC X(02).
           03  STS-RECE451         PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *    ¥Õ¥é¥°ÎÎ°è
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-RECE44          PIC 9(01).
           03  FLG-RECE45          PIC 9(01).
           03  FLG-SHUJUTU-COMMENT PIC 9(01).
           03  FLG-SYOBYO-COMMENT  PIC 9(01).
           03  FLG-RYOYO-COMMENT   PIC 9(01).
           03  FLG-WRKRECE45       PIC 9(01).
           03  FLG-SHIDOU-COMMENT  PIC 9(01).
           03  FLG-CTMRI-COMMENT   PIC 9(01).
           03  FLG-COMMENT         PIC 9(02).
           03  FLG-ARI             PIC 9(01).
           03  FLG-SANTEI          PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-JYURRK          PIC 9(01).
           03  FLG-FIRST           PIC 9(01).
      *
      *    ¥«¥¦¥ó¥ÈÎÎ°è
       01  CNT-AREA.
           03  CNT-RECE41          PIC 9(06).
           03  CNT-RECE44          PIC 9(06).
           03  CNT-RECE45          PIC 9(06).
           03  CNT-RIHA            PIC 9(06).
           03  CNT-JUSHIN          PIC 9(06).
           03  CNT-SANTEIKA        PIC 9(06).
           03  CNT-IN-COMMIT       PIC 9(06).
      *
      *    Åº»úÎÎ°è
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  DAY-IDX             PIC 9(04).
           03  IDX-RECE45          PIC 9(04).
      *     
      *    °ì»þÎÎ°è
       01  WRK-AREA.
           03  WRK-PARA.
               05  WRK-PARA-SRYYM              PIC  X(06).
               05  WRK-PARA-TERMID             PIC  X(16).
               05  WRK-PARA-SYSYMD             PIC  X(08).
               05  WRK-PARA-JOBID              PIC  9(07).
               05  WRK-PARA-SHELLID            PIC  X(08).
      *
           03  WRK-RENNUM          PIC 9(02).
           03  WRK-CNT-MEISAI      PIC 9(04).
           03  WRK-KETA            PIC 9(04).
           03  WRK-KETA-TAIHI      PIC 9(04).
           03  WRK-KETA2           PIC 9(04).
           03  WRK-RECEERR         PIC X(200).
      *
           03  WRK-DAY             PIC 9(02).
      *
           03  TBL-SANTEI-DAY.
               05  TB-SANTEI-DAY   PIC 9(02)   OCCURS  31.
      *
           03  WRK-HKNCOMBINUMX      PIC X(04).
           03  WRK-HKNCOMBINUM9      REDEFINES  WRK-HKNCOMBINUMX
                                     PIC 9(04).
      *
           03  WRK-SRYYMDX.
               05  WRK-SRYYM         PIC 9(06).
               05  WRK-SRYDD         PIC 9(02).
      *
           03  WRK-SRYCD             PIC X(09).
      *
       01  WRK-RECE44-REC. 
           COPY    "CPRCF044.INC"  REPLACING   //RECE44//
                                   BY          //WRK-RECE44//.
      *
       01  WRK-RECE45-REC. 
           COPY    "CPRCF045.INC"  REPLACING   //RECE45//
                                   BY          //WRK-RECE45//.
      *
       01  COM-RECE45-REC. 
           COPY    "CPRCF045.INC"  REPLACING   //RECE45//
                                   BY          //COM//.
      *
       01  WRK-SRYACTINF-AREA.
           03  WRK-SRYACTINF                   OCCURS  50.
               05  WK-RECE45-SRYCD           PIC  X(09).
               05  WK-RECE45-SRYSURYO        PIC  9(05)V9(03).
               05  WK-RECE45-SRYKAISU        PIC  9(03).
               05  WK-RECE45-TANICD          PIC  9(03).
               05  WK-RECE45-TANIMOJISU      PIC  9(01).
               05  WK-RECE45-TANINAME        PIC  X(24).
               05  WK-RECE45-TENSIKIBETU     PIC  9(01).
               05  WK-RECE45-TEN             PIC  9(09)V9(02).
               05  WK-RECE45-MEISKYFLG       PIC  X(01).
               05  WK-RECE45-AUTOKBN         PIC  X(01).
               05  WK-RECE45-INPUTNUM        PIC  9(03).
               05  WK-RECE45-TENTTLKBN       PIC  9(03).
      *
       01  WRK-NAMEINF-AREA.
           03  WRK-NAMEINF                     OCCURS 50.         
               05  WK-RECE45-YUKOKETA        PIC  9(02).
               05  WK-RECE45-NAME            PIC  X(200).
      *
       01  WRK-SIKFLGINF-AREA.
           03  WRK-SIKFLGINF                   OCCURS 50.         
               05  WK-RECE45-SIKFLG          PIC  X(01).
      *
       01  WRK-DATAKBNINF-AREA.
           03  WRK-DATAKBNINF                  OCCURS 50.         
               05  WK-RECE45-DATAKBN         PIC  9(01).
      *
       01  WRK-FREE-AREA.
           03  WRK-FREEINF                     OCCURS 49.         
               05  WK-FREE-YUKOKETA          PIC  9(02).
               05  WK-FREE-NAME              PIC  X(200).
      *
       01  WRK-FREE-AREA2.                                              
           03  WRK-FREEINF2                    OCCURS 50.               
               05  WK-FREE-YUKOKETA2         PIC  9(02).                
               05  WK-FREE-NAME2             PIC  X(200).               
      *
      *Íý³ØÎÅË¡ºÞÈÖ¹æÂàÈòÎÎ°è
       01  WRK-TAIHI-ZAINUM.
           03  WRK-RIGA1-SHU-ZAINUM          PIC  9(08).   
           03  WRK-RIGA1-KO-ZAINUM           PIC  9(08).   
           03  WRK-RIGA2-SHU-ZAINUM          PIC  9(08).   
           03  WRK-RIGA2-KO-ZAINUM           PIC  9(08).   
           03  WRK-RIGA3-SHU-ZAINUM          PIC  9(08).   
           03  WRK-RIGA3-KO-ZAINUM           PIC  9(08).   
           03  WRK-RIGA4-SHU-ZAINUM          PIC  9(08).   
           03  WRK-RIGA4-KO-ZAINUM           PIC  9(08).   
           03  WRK-SAGYO1-SHU-ZAINUM         PIC  9(08).   
           03  WRK-SAGYO2-SHU-ZAINUM         PIC  9(08).   
           03  WRK-SAGYO1-KO-ZAINUM          PIC  9(08).   
           03  WRK-SAGYO2-KO-ZAINUM          PIC  9(08).   
           03  WRK-GENGO1-SHU-ZAINUM         PIC  9(08).   
           03  WRK-GENGO1-KO-ZAINUM          PIC  9(08).   
           03  WRK-GENGO2-SHU-ZAINUM         PIC  9(08).   
           03  WRK-GENGO2-KO-ZAINUM          PIC  9(08).   
      *
       01  WRK-TAIHI-ZAINUM-R     REDEFINES   WRK-TAIHI-ZAINUM.
            03  WRK-RIHA-ZAINUM   PIC 9(08)   OCCURS   16.       
      *
      *Íý³ØÎÅË¡¼Â»Ü¥«¥ì¥ó¥À¡¼
       01  WRK-RIGAKU-AREA.
           03  WRK-RIGA1-SHU                 PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA1-KO                  PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA2-SHU                 PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA2-KO                  PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA3-SHU                 PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA3-KO                  PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA4-SHU                 PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA4-KO                  PIC  X(01)  OCCURS 31.   
           03  WRK-SAGYO1-SHU                PIC  X(01)  OCCURS 31.   
           03  WRK-SAGYO2-SHU                PIC  X(01)  OCCURS 31.   
           03  WRK-SAGYO1-KO                 PIC  X(01)  OCCURS 31.   
           03  WRK-SAGYO2-KO                 PIC  X(01)  OCCURS 31.   
           03  WRK-GENGO1-SHU                PIC  X(01)  OCCURS 31.   
           03  WRK-GENGO1-KO                 PIC  X(01)  OCCURS 31.   
           03  WRK-GENGO2-SHU                PIC  X(01)  OCCURS 31.   
           03  WRK-GENGO2-KO                 PIC  X(01)  OCCURS 31.   
      *
       01  WRK-RIGAKU-R        REDEFINES     WRK-RIGAKU-AREA.
           02  WRK-RIGAKU-OCC                OCCURS   16.
             03  WRK-RIGAKU-OCC2             OCCURS   31.
               04  WRK-RIGAKU                PIC  X(01).
      *
      *    ÆüÉÕÁ´³ÑÊÑ´¹ÎÎ°è
       01  TBL-DAY-AREA.
           03  FILLER              PIC X(04)  VALUE "¡¡£±".
           03  FILLER              PIC X(04)  VALUE "¡¡£²".
           03  FILLER              PIC X(04)  VALUE "¡¡£³".
           03  FILLER              PIC X(04)  VALUE "¡¡£´".
           03  FILLER              PIC X(04)  VALUE "¡¡£µ".
           03  FILLER              PIC X(04)  VALUE "¡¡£¶".
           03  FILLER              PIC X(04)  VALUE "¡¡£·".
           03  FILLER              PIC X(04)  VALUE "¡¡£¸".
           03  FILLER              PIC X(04)  VALUE "¡¡£¹".
           03  FILLER              PIC X(04)  VALUE "£±£°".
           03  FILLER              PIC X(04)  VALUE "£±£±".
           03  FILLER              PIC X(04)  VALUE "£±£²".
           03  FILLER              PIC X(04)  VALUE "£±£³".
           03  FILLER              PIC X(04)  VALUE "£±£´".
           03  FILLER              PIC X(04)  VALUE "£±£µ".
           03  FILLER              PIC X(04)  VALUE "£±£¶".
           03  FILLER              PIC X(04)  VALUE "£±£·".
           03  FILLER              PIC X(04)  VALUE "£±£¸".
           03  FILLER              PIC X(04)  VALUE "£±£¹".
           03  FILLER              PIC X(04)  VALUE "£²£°".
           03  FILLER              PIC X(04)  VALUE "£²£±".
           03  FILLER              PIC X(04)  VALUE "£²£²".
           03  FILLER              PIC X(04)  VALUE "£²£³".
           03  FILLER              PIC X(04)  VALUE "£²£´".
           03  FILLER              PIC X(04)  VALUE "£²£µ".
           03  FILLER              PIC X(04)  VALUE "£²£¶".
           03  FILLER              PIC X(04)  VALUE "£²£·".
           03  FILLER              PIC X(04)  VALUE "£²£¸".
           03  FILLER              PIC X(04)  VALUE "£²£¹".
           03  FILLER              PIC X(04)  VALUE "£³£°".
           03  FILLER              PIC X(04)  VALUE "£³£±".
       01  TBL-DAY-AREA-R          REDEFINES   TBL-DAY-AREA.
           03  TBL-DAY             PIC X(04)   OCCURS   31.
      *
       01  MAX-MEISAISU            PIC 9(07).
      *
      *    ¸ÇÄêÃÍ
       01  CONST-AREA.
      *    ½ýÉÂ¼êÅö¶â°Õ¸«½ñ¸òÉÕÎÁ
           03  CONS-SYOBYO-COMMENT  PIC X(09) VALUE "180000710".
      *    ÎÅÍÜÈñÆ±°Õ½ñ¸òÉÕÎÁ
           03  CONS-RYOYO-COMMENT   PIC X(09) VALUE "113004310".
      *    ¼ê½ÑÆü¥³¥á¥ó¥È
           03  CONS-SHUJUTU-COMMENT PIC X(09) VALUE "840000042".
      *    ËýÀ­¤È¤¦ÄË¼À´µ
           03  CONS-MANSEI          PIC X(09) VALUE "113006510".
      *    ½é¿ÇÎÁ»»Äê²Ê¡§
           03  CONS-SYOSINSANTEIKA  PIC X(09) VALUE "830000020".
      *    ºÆ¿ÇÎÁ»»Äê²Ê¡§
           03  CONS-SAISINSANTEIKA  PIC X(09) VALUE "830000021".
      *
      *   ¥ê¥Ï¥Ó¥ê¿ÇÎÅ¹Ô°Ù¥Æ¡¼¥Ö¥ë
       01  TBL-RIHA-AREA.
           03  FILLER          PIC X(09)   VALUE    "180706910".
           03  FILLER          PIC X(09)   VALUE    "180022210".
           03  FILLER          PIC X(09)   VALUE    "180706810".
           03  FILLER          PIC X(09)   VALUE    "180022110".
           03  FILLER          PIC X(09)   VALUE    "180707110".
           03  FILLER          PIC X(09)   VALUE    "180022410".
           03  FILLER          PIC X(09)   VALUE    "180707010".
           03  FILLER          PIC X(09)   VALUE    "180022310".
           03  FILLER          PIC X(09)   VALUE    "180707310".
           03  FILLER          PIC X(09)   VALUE    "180022610".
           03  FILLER          PIC X(09)   VALUE    "180707210".
           03  FILLER          PIC X(09)   VALUE    "180022510".
           03  FILLER          PIC X(09)   VALUE    "180707510".
           03  FILLER          PIC X(09)   VALUE    "180022810".
           03  FILLER          PIC X(09)   VALUE    "180707410".
           03  FILLER          PIC X(09)   VALUE    "180022710".
           03  FILLER          PIC X(09)   VALUE    "180708210".
           03  FILLER          PIC X(09)   VALUE    "180023710".
           03  FILLER          PIC X(09)   VALUE    "180708410".
           03  FILLER          PIC X(09)   VALUE    "180023910".
           03  FILLER          PIC X(09)   VALUE    "180708110".
           03  FILLER          PIC X(09)   VALUE    "180023610".
           03  FILLER          PIC X(09)   VALUE    "180708310".
           03  FILLER          PIC X(09)   VALUE    "180023810".
           03  FILLER          PIC X(09)   VALUE    "180024910".
           03  FILLER          PIC X(09)   VALUE    "180024810".
           03  FILLER          PIC X(09)   VALUE    "180025110".
           03  FILLER          PIC X(09)   VALUE    "180025010".
      *
       01  TBL-RIHA-R          REDEFINES   TBL-RIHA-AREA.
            03  TBL-RIHA       PIC X(09)   OCCURS   28.       
      *
       01  TBL-RIHA-MAX        PIC 9(02)   VALUE    28.  
      *
      *
      *   £Ã£Ô¡¦£Í£Ò£ÉÂÐ¾Ý¿ÇÎÅ¹Ô°Ù¥Æ¡¼¥Ö¥ë
       01  TBL-CTMRI-AREA.
      *    Æ¬ÉôÃ±½ã£Ã£Ô»£±Æ
           03  FILLER          PIC X(09)   VALUE   "170011710".
      *    ¶í´´Ã±½ã£Ã£Ô»£±Æ
           03  FILLER          PIC X(09)   VALUE   "170011810".
      *    »Í»èÃ±½ã£Ã£Ô»£±Æ
           03  FILLER          PIC X(09)   VALUE   "170011910".
      *    Ç¾Áå£Ã£ÔÂ¤±Æ
           03  FILLER          PIC X(09)   VALUE   "170012110".
      *    ðôÉôÃ±½ã£Ã£Ô»£±Æ
           03  FILLER          PIC X(09)   VALUE   "170015550".
      *    Æ¬ÉôÃ±½ã£Í£Ò£É»£±Æ
           03  FILLER          PIC X(09)   VALUE   "170015210".
      *    ¶í´´Ã±½ã£Í£Ò£É»£±Æ
           03  FILLER          PIC X(09)   VALUE   "170020110".
      *    »Í»èÃ±½ã£Í£Ò£É»£±Æ
           03  FILLER          PIC X(09)   VALUE   "170022110".
      *    £Ã£Ô¡¢£Í£Ò£É¡ÊÆ¬Éô¡Ë¡Ê£²²óÌÜ°Ê¹ß¡Ë
           03  FILLER          PIC X(09)   VALUE   "170022290".
      *    £Ã£Ô¡¢£Í£Ò£É¡Ê¶í´´¡Ë¡Ê£²²óÌÜ°Ê¹ß¡Ë
           03  FILLER          PIC X(09)   VALUE   "170022390".
      *    £Ã£Ô¡¢£Í£Ò£É¡Ê»Í»è¡Ë¡Ê£²²óÌÜ°Ê¹ß¡Ë
           03  FILLER          PIC X(09)   VALUE   "170022490".
      *    Æ¬ÉôÆÃ¼ì£Ã£Ô»£±Æ
           03  FILLER          PIC X(09)   VALUE   "170023010".
      *    ¶í´´ÆÃ¼ì£Ã£Ô»£±Æ
           03  FILLER          PIC X(09)   VALUE   "170023110".
      *    »Í»èÆÃ¼ì£Ã£Ô»£±Æ
           03  FILLER          PIC X(09)   VALUE   "170023210".
      *    Æ¬ÉôÆÃ¼ì£Í£Ò£É»£±Æ
           03  FILLER          PIC X(09)   VALUE   "170023310".
      *    ¶í´´ÆÃ¼ì£Í£Ò£É»£±Æ
           03  FILLER          PIC X(09)   VALUE   "170023410".
      *    »Í»èÆÃ¼ì£Í£Ò£É»£±Æ
           03  FILLER          PIC X(09)   VALUE   "170023510".
      *
       01  TBL-CTMRI-R         REDEFINES   TBL-CTMRI-AREA.
            03  TBL-CTMRI      PIC X(09)   OCCURS   17.       
      *
       01  TBL-CTMRI-MAX       PIC 9(02)   VALUE    17.  
      *
      *
      *    Ê£¿ô¿ÇÎÅ²Ê¼õ¿Ç¤ÎÂàÈò¥Æ¡¼¥Ö¥ë
       01  TBL-JUSHIN-INF.
           03  TBL-JUSHIN-INF2      OCCURS    50.
               05  TBL-JUSHIN-SRYKA       PIC X(02).
               05  TBL-JUSHIN-SRYKANAME   PIC X(80).
               05  TBL-JUSHIN-ARI         PIC X(01).
               05  TBL-JUSHIN-DAY         PIC X(01)   OCCURS  31.
      *
      *    ¥Ñ¥¹Ì¾ÎÎ°è
       01  WRK-PATH                        PIC X(64).
      *
           COPY    "MCPAREA".
      *
           COPY    "COMMON-SPA".
      *
      *****************************************************************
      *    ¥Õ¥¡¥¤¥ë¥ì¥¤¥¢¥¦¥È
      *****************************************************************
      *
      *    ¥¸¥ç¥Ö´ÉÍý¥Þ¥¹¥¿
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿
           COPY    "CPSYSKANRI.INC".
      *
      *    ¿ÇÎÅ²ÊÌÜ¾ðÊó
           COPY    "CPSK1005.INC".
      *
      *    ¿ÇÎÅ¹Ô°Ù
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    »»ÄêÍúÎò
       01  SANTEI-REC.
           COPY    "CPSANTEI.INC".
      *
      *    ¼õ¿ÇÍúÎò
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *****************************************************************
      *    ¥µ¥Ö¥×¥íÍÑÎÎ°è
      *****************************************************************
      *   ¥¸¥ç¥Ö´ÉÍý£Ä£ÂÀ©¸æ¥µ¥Ö
           COPY    "CPORCSJOBKANRI.INC".
      *     
      *    ¿ôÃÍÊÑ´¹¥µ¥Ö
           COPY    "CPORCSNUM.INC".
      *
      *    Á´³Ñ¥Á¥§¥Ã¥¯¥Ñ¥é¥á¥¿
           COPY    "CPORCSKANACHK.INC".
      *
      *    £Ä£Â¸¡º÷
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      ****************************************************************
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(256).
      ****************************************************************
       PROCEDURE           DIVISION
               USING
           COMMAND-PARAM.
      *
      *****************************************************************
      *    ¼ç¡¡¡¡½èÍý
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
                   UNTIL   FLG-END  =  1
      *
           PERFORM 300-END-SEC
      *
           STOP    RUN
           .
      *****************************************************************
      *    ½é´ü¡¡½èÍý
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
      *
      *    ¥Õ¥¡¥¤¥ë£Ï£Ð£Å£Î½èÍý
      *
           PERFORM 110-FILE-OPEN-SEC
           PERFORM 120-DBOPEN-SEC
      *
      *    ¥¹¥Æ¥Ã¥×´ÉÍý³«»Ï½èÍý
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCR0430"      TO  JOB-PGID
           MOVE    "¥³¥á¥ó¥ÈÊÔ½¸¡ÊÏ«ºÒ¡¦¼«ÇåÀÕ¡Ë"    TO  JOB-SHELLMSG   
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 990-RECE41-READ-SEC
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥Õ¥¡¥¤¥ë£Ï£Ð£Å£Î½èÍý
      *****************************************************************
       110-FILE-OPEN-SEC          SECTION.
      *
           MOVE    COMMAND-PARAM       TO  WRK-PARA
      *
           MOVE    "RECE410"           TO  RECE41PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE41PARA-TERMID
      *
           MOVE    "RECE44W"           TO  RECE44PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE44PARA-TERMID
      *
           MOVE    "RECE450"           TO  RECE45PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE45PARA-TERMID
      *
           MOVE    "RECE44A"           TO  RECE441PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE441PARA-TERMID
      *
           MOVE    "RECE45A"           TO  RECE451PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE451PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
           OPEN    INPUT               RECE41-FILE
      *
           OPEN    INPUT               RECE44-FILE
      *
           OPEN    INPUT               RECE45-FILE
      *
           OPEN    OUTPUT              RECE4441-FILE
           CLOSE                       RECE4441-FILE
      *
           OPEN    OUTPUT              RECE4551-FILE
           CLOSE                       RECE4551-FILE
      *
           OPEN    OUTPUT              RECE441-FILE
      *
           OPEN    OUTPUT              RECE451-FILE
      *
           .
       110-FILE-OPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼ç½èÍý
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           MOVE       ZERO             TO  CNT-SANTEIKA
           INITIALIZE                      WRK-RIGAKU-AREA
           INITIALIZE                      WRK-TAIHI-ZAINUM
      *
           IF   RECE41-COMCNTFLG   =   "1"
      *
             INITIALIZE                      RECE44-REC
             MOVE    RECE41-HOSPID       TO  RECE44-HOSPID
             MOVE    RECE41-SRYYM        TO  RECE44-SRYYM
             MOVE    RECE41-NYUGAIKBN    TO  RECE44-NYUGAIKBN
             MOVE    RECE41-PTID         TO  RECE44-PTID
             MOVE    RECE41-RECEKA       TO  RECE44-RECEKA
             MOVE    RECE41-HKNID        TO  RECE44-HKNID
             MOVE    RECE41-TEKSTYMD     TO  RECE44-TEKSTYMD
             MOVE    ZERO                TO  RECE44-ZAINUM
      *
             START   RECE44-FILE
                 KEY IS    >=   RECE44-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE44
                 NOT INVALID
                     PERFORM 990-RECE44-NEXT-SEC
             END-START
             PERFORM
               UNTIL  ( FLG-RECE44           =   1                   )
               OR     ( RECE41-HOSPID    NOT =   RECE44-HOSPID       )
               OR     ( RECE41-SRYYM     NOT =   RECE44-SRYYM        )
               OR     ( RECE41-NYUGAIKBN NOT =   RECE44-NYUGAIKBN    )
               OR     ( RECE41-PTID      NOT =   RECE44-PTID         )
               OR     ( RECE41-RECEKA    NOT =   RECE44-RECEKA       )
               OR     ( RECE41-HKNID     NOT =   RECE44-HKNID        )
               OR     ( RECE41-TEKSTYMD  NOT =   RECE44-TEKSTYMD     )
      *
               IF   RECE41-HKNKBN    NOT  =  "4"                        
                  EVALUATE      RECE44-SRYKBN
                      WHEN      "11"
      *               ¡Ê½é¿ÇÎÁ»»Äê²Ê¡§¤Î¥«¥¦¥ó¥È¡Ë
                         MOVE    CONS-SYOSINSANTEIKA  TO  WRK-SRYCD
                         PERFORM    2001-SANTEIKA-COUNT-SEC
                      WHEN      "12"
      *               ¡ÊºÆ¿ÇÎÁ»»Äê²Ê¡§¤Î¥«¥¦¥ó¥È¡Ë
                         MOVE    CONS-SAISINSANTEIKA  TO  WRK-SRYCD
                         PERFORM    2001-SANTEIKA-COUNT-SEC
                      WHEN      "80"
      *               ¡Ê¥ê¥Ï¥Ó¥ê¤Î¥«¥¦¥ó¥È¡Ë
                         PERFORM    2001-RIHA-COUNT-SEC
                  END-EVALUATE
               ELSE                                                     
                  EVALUATE      RECE44-SRYKBN  
                      WHEN      "11"
      *               ¡Ê½é¿ÇÎÁ»»Äê²Ê¡§¤Î¥«¥¦¥ó¥È¡Ë
                         MOVE    CONS-SYOSINSANTEIKA  TO  WRK-SRYCD
                         PERFORM    2001-SANTEIKA-COUNT-SEC
                      WHEN      "12"
      *               ¡ÊºÆ¿ÇÎÁ»»Äê²Ê¡§¤Î¥«¥¦¥ó¥È¡Ë
                         MOVE    CONS-SAISINSANTEIKA  TO  WRK-SRYCD
                         PERFORM    2001-SANTEIKA-COUNT-SEC
                      WHEN      "40"                                    
      *               ¡Ê¥ê¥Ï¥Ó¥ê¤Î¥«¥¦¥ó¥È¡Ë                            
                         PERFORM    2001-RIHA-COUNT-SEC                 
                  END-EVALUATE                                          
               END-IF                                                   
      *
               PERFORM 990-RECE44-NEXT-SEC
      *
             END-PERFORM
      *
           END-IF
      *
      *    Ê£¿ô¿ÇÎÅ²Ê¼õ¿Ç
      *
           IF   CNT-SANTEIKA   >  ZERO
      *
             MOVE       ZERO             TO  CNT-JUSHIN
             INITIALIZE                      TBL-JUSHIN-INF
      *      ¿ÇÎÅ²Ê¤Î¼èÆÀ
             INITIALIZE                      SYS-1005-REC
             MOVE    "1005"              TO  SYS-1005-KANRICD
             MOVE    ZERO                TO  SYS-1005-STYUKYMD
             MOVE    ALL "9"             TO  SYS-1005-EDYUKYMD
             MOVE    SYS-1005-REC        TO  MCPDATA-REC
             MOVE    "DBSELECT"          TO  MCP-FUNC
             MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
             MOVE    RECE41-SRYYM        TO  ORC-DBYMD(1:6)
             MOVE    "01"                TO  ORC-DBYMD(7:2)
             CALL    "ORCMCPSUB"         USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
             IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"  TO  ORC-DBPATH 
               PERFORM   SYSKANRI-READ-SEC
               PERFORM   VARYING   IDX    FROM   1   BY   1
                          UNTIL   (IDX             >      50)
                            OR    (FLG-SYSKANRI    =       1)
                   MOVE    SYS-1005-KBNCD  TO TBL-JUSHIN-SRYKA(IDX)
                   MOVE    SYS-1005-SRYKANAME   
                                           TO TBL-JUSHIN-SRYKANAME(IDX)
      *            ¼õ¿ÇÍúÎò¥Æ¡¼¥Ö¥ë¤«¤é¿ÇÎÅ²ÊËè¤Î¼õ¿ÇÆü¤ò¸¡º÷¥»¥Ã¥È
                   PERFORM   2001-JUSHIN-KENSAKU-SEC
      *
                   MOVE    "SYSKANRI-KEY2"  TO  ORC-DBPATH 
                   PERFORM   SYSKANRI-READ-SEC
               END-PERFORM
             END-IF
      *
             INITIALIZE                        MCPAREA
             MOVE    "DBCLOSE"         TO      MCP-FUNC
             MOVE    "SYSKANRI-KEY2"   TO      ORC-DBPATH
             CALL    "ORCMCPSUB"       USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
      *      Ê£¿ô¤Î¿ÇÎÅ²Ê¼õ¿Ç¤¬¤¢¤ë¤«È½Äê
             MOVE       ZERO       TO   IDZ  
             INITIALIZE            WRK-FREE-AREA
      *
             PERFORM   VARYING   IDX    FROM   1   BY   1
                            UNTIL   (IDX             >      50)
               IF   TBL-JUSHIN-ARI (IDX)  =  "1"
                   ADD       1     TO   CNT-JUSHIN
                   PERFORM  2002-FREE-COMMENT-SEC
               END-IF
             END-PERFORM
      *      Ê£¿ô¿ÇÎÅ²Ê¼õ¿Ç¤Î¥³¥á¥ó¥ÈÊÔ½¸
             IF    CNT-JUSHIN  >   1
                    PERFORM   2002-JUSHIN-COMMENT-SEC
             END-IF
      *
           END-IF
      *
      *    ¥Ñ¥é¥á¡¼¥¿£°£´¥Õ¥¡¥¤¥ë¤è¤êÊÔ½¸
           INITIALIZE                      RECE44-REC
           MOVE    RECE41-HOSPID       TO  RECE44-HOSPID
           MOVE    RECE41-SRYYM        TO  RECE44-SRYYM
           MOVE    RECE41-NYUGAIKBN    TO  RECE44-NYUGAIKBN
           MOVE    RECE41-PTID         TO  RECE44-PTID
           MOVE    RECE41-RECEKA       TO  RECE44-RECEKA
           MOVE    RECE41-HKNID        TO  RECE44-HKNID
           MOVE    RECE41-TEKSTYMD     TO  RECE44-TEKSTYMD
           MOVE    ZERO                TO  RECE44-ZAINUM
      *
           START   RECE44-FILE
               KEY IS    >=   RECE44-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE44
               NOT INVALID
                   PERFORM 990-RECE44-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( FLG-RECE44           =   1                   )
               OR     ( RECE41-HOSPID    NOT =   RECE44-HOSPID       )
               OR     ( RECE41-SRYYM     NOT =   RECE44-SRYYM        )
               OR     ( RECE41-NYUGAIKBN NOT =   RECE44-NYUGAIKBN    )
               OR     ( RECE41-PTID      NOT =   RECE44-PTID         )
               OR     ( RECE41-RECEKA    NOT =   RECE44-RECEKA       )
               OR     ( RECE41-HKNID     NOT =   RECE44-HKNID        )
               OR     ( RECE41-TEKSTYMD  NOT =   RECE44-TEKSTYMD     )
      *
               IF   RECE41-HKNKBN    NOT  =  "4"                        
                 EVALUATE      RECE44-SRYKBN                   
                   WHEN      "13"
                      MOVE   ZERO   TO  FLG-COMMENT
      *            ¡ÊËýÀ­áÖÄË¼À´µ´ÉÍýÎÁ»»ÄêÆü¤Î¥»¥Ã¥È¡Ë
                      IF   FLG-COMMENT  =  ZERO
                         PERFORM    2001-SHIDOU-HANTEI-SEC
                      END-IF
      *            ¡Ê½ýÉÂ¼êÅö¶â°Õ¸«½ñ¸òÉÕÎÁ¸òÉÕÆü¤Î¥»¥Ã¥È¡Ë
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-SYOBYO-HANTEI-SEC
                      END-IF
      *            ¡ÊÎÅÍÜÈñÆ±°Õ½ñ¸òÉÕÎÁ¸òÉÕÆü¤Î¥»¥Ã¥È¡Ë
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-RYOYO-HANTEI-SEC
                      END-IF
                      IF   FLG-COMMENT  =  ZERO
                         MOVE       RECE44-REC    TO   RECE441-REC
                         WRITE      RECE441-REC
                         ADD     1          TO      CNT-RECE44
                         PERFORM    2002-RECE45-TENSOU-SEC
                      END-IF
                   WHEN      "50"
      *            ¡Ê¼ê½ÑÆü¤Î¥»¥Ã¥È¡Ë
                      PERFORM    2001-SHUJUTSU-HANTEI-SEC
                   WHEN      "70"
      *            ¡Ê£Ã£Ô¡¦£Í£Ò£É¼Â»ÜÆü¤Î¥»¥Ã¥È¡Ë
                      PERFORM    2001-CTMRI-HANTEI-SEC
                   WHEN      "80"
      *            ¡Ê¥ê¥Ï¥Ó¥ê¤Î¥»¥Ã¥È¡Ë
                      MOVE    ZERO     TO    FLG-ARI
                      PERFORM   VARYING   IDX    FROM   1   BY   1
                            UNTIL   (IDX             >      16)
                             OR     (FLG-ARI         =       1)
                          IF  RECE44-ZAINUM  =  WRK-RIHA-ZAINUM(IDX)
                              MOVE    1    TO   FLG-ARI 
                          END-IF
                      END-PERFORM
                      IF  FLG-ARI  =  1
                          PERFORM   2001-RIHA-COMMENT-SEC
                      ELSE
                          MOVE       RECE44-REC    TO   RECE441-REC
                          WRITE      RECE441-REC
                          ADD     1          TO      CNT-RECE44
                          PERFORM    2002-RECE45-TENSOU-SEC
                      END-IF
                   WHEN   OTHER
                      MOVE       RECE44-REC    TO   RECE441-REC
                      WRITE      RECE441-REC
                      ADD     1          TO      CNT-RECE44
                      PERFORM    2002-RECE45-TENSOU-SEC
                 END-EVALUATE
               ELSE                                                     
                 EVALUATE      RECE44-SRYKBN                            
                   WHEN      "13"                                       
                      MOVE   ZERO   TO  FLG-COMMENT
      *            ¡ÊËýÀ­áÖÄË¼À´µ´ÉÍýÎÁ»»ÄêÆü¤Î¥»¥Ã¥È¡Ë
                      IF   FLG-COMMENT  =  ZERO
                         PERFORM    2001-SHIDOU-HANTEI-SEC
                      END-IF
      *            ¡Ê½ýÉÂ¼êÅö¶â°Õ¸«½ñ¸òÉÕÎÁ¸òÉÕÆü¤Î¥»¥Ã¥È¡Ë
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-SYOBYO-HANTEI-SEC
                      END-IF
      *            ¡ÊÎÅÍÜÈñÆ±°Õ½ñ¸òÉÕÎÁ¸òÉÕÆü¤Î¥»¥Ã¥È¡Ë
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-RYOYO-HANTEI-SEC
                      END-IF
                      IF   FLG-COMMENT  =  ZERO
                         MOVE       RECE44-REC    TO   RECE441-REC
                         WRITE      RECE441-REC
                         ADD     1          TO      CNT-RECE44
                         PERFORM    2002-RECE45-TENSOU-SEC
                      END-IF
                   WHEN      "50"                                       
      *            ¡Ê¼ê½ÑÆü¤Î¥»¥Ã¥È¡Ë                                   
                      PERFORM    2001-SHUJUTSU-HANTEI-SEC               
                   WHEN      "70"
      *            ¡Ê£Ã£Ô¡¦£Í£Ò£É¼Â»ÜÆü¤Î¥»¥Ã¥È¡Ë
                      PERFORM    2001-CTMRI-HANTEI-SEC
                   WHEN      "40"          
      *            ¡Ê¥ê¥Ï¥Ó¥ê¤Î¥»¥Ã¥È¡Ë
                      MOVE    ZERO     TO    FLG-ARI
                      PERFORM   VARYING   IDX    FROM   1   BY   1
                            UNTIL   (IDX             >      16)
                             OR     (FLG-ARI         =       1)
                          IF  RECE44-ZAINUM  =  WRK-RIHA-ZAINUM(IDX)
                              MOVE    1    TO   FLG-ARI 
                          END-IF
                      END-PERFORM
                      IF  FLG-ARI  =  1
                          PERFORM   2001-RIHA-COMMENT-SEC
                      ELSE
                          MOVE       RECE44-REC    TO   RECE441-REC
                          WRITE      RECE441-REC
                          ADD     1          TO      CNT-RECE44
                          PERFORM    2002-RECE45-TENSOU-SEC
                      END-IF
                   WHEN   OTHER                                         
                      MOVE       RECE44-REC    TO   RECE441-REC         
                      WRITE      RECE441-REC                            
                      ADD     1          TO      CNT-RECE44             
                      PERFORM    2002-RECE45-TENSOU-SEC                 
                 END-EVALUATE                                           
               END-IF                                                   
      *
               PERFORM 990-RECE44-NEXT-SEC
      *
           END-PERFORM
      *
      *
           PERFORM 990-RECE41-READ-SEC
      *
           IF  CNT-IN-COMMIT   =    300
                 MOVE  ZERO          TO      CNT-IN-COMMIT
                 PERFORM 900-DBCOMMIT-SEC
                 PERFORM 900-DBSTART-SEC
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    »»Äê²Ê¡§¤Î¥«¥¦¥ó¥È
      *****************************************************************
       2001-SANTEIKA-COUNT-SEC          SECTION.
      *
           INITIALIZE                          SRYACT-REC
           MOVE    RECE44-HOSPID       TO      SRY-HOSPID
           MOVE    RECE44-NYUGAIKBN    TO      SRY-NYUGAIKBN
           MOVE    RECE44-PTID         TO      SRY-PTID
           MOVE    RECE44-SRYYM        TO      SRY-SRYYM
           MOVE    RECE44-ZAINUM       TO      SRY-ZAINUM
           MOVE    WRK-SRYCD           TO      SRY-SRYCD (1)
           MOVE    WRK-SRYCD           TO      SRY-SRYCD (2)
           MOVE    WRK-SRYCD           TO      SRY-SRYCD (3)
           MOVE    WRK-SRYCD           TO      SRY-SRYCD (4)
           MOVE    WRK-SRYCD           TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   IF      RECE41-HKNKBN   NOT  =   "3"
                         ADD    RECE44-ZAIKAISU  
                                       TO   CNT-SANTEIKA
                   ELSE
                         MOVE   RECE41-TEKSTYMD(7:2)  TO  WRK-DAY
                         ADD    RECE44-KAISU(1 WRK-DAY) 
                                       TO   CNT-SANTEIKA
                   END-IF
               END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           .
       2001-SANTEIKA-COUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼õ¿ÇÍúÎò¥Æ¡¼¥Ö¥ë¤«¤é¿ÇÎÅ²ÊËè¤Î¼õ¿ÇÆü¤ò¸¡º÷¥»¥Ã¥È
      *****************************************************************
       2001-JUSHIN-KENSAKU-SEC             SECTION.
      *
      *    ¼õ¿ÇÎò¤Î¸¡º÷
           INITIALIZE                      JYURRK-REC
           MOVE    RECE41-HOSPID       TO  JYURRK-HOSPID
           MOVE    RECE41-PTID         TO  JYURRK-PTID
           MOVE    RECE41-NYUGAIKBN    TO  JYURRK-NYUGAIKBN
           MOVE    TBL-JUSHIN-SRYKA(IDX)
                                       TO  JYURRK-SRYKA
           MOVE    RECE41-SRYYM        TO  JYURRK-SRYYMD(1:6)
           MOVE    "01"                TO  JYURRK-SRYYMD(7:2)
           MOVE    RECE41-SRYYM        TO  JYURRK-UPSRYYMD(1:6)
           MOVE    "31"                TO  JYURRK-UPSRYYMD(7:2)
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "JYURRK-KEY24"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING   MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "JYURRK-KEY24"  TO  ORC-DBPATH 
               PERFORM   JYURRK-READ-SEC
               PERFORM   UNTIL   FLG-JYURRK   =    1
                  IF   RECE41-HKNKBN    NOT  =  "4" 
                   IF    JYURRK-HKNKBN    =       "1"
                      MOVE   JYURRK-HKNCOMBINUM
                                       TO  WRK-HKNCOMBINUMX
                      IF  WRK-HKNCOMBINUM9  =  RECE41-HKNCOMBI
                          IF  RECE41-HKNKBN   NOT =  "3"
                               MOVE   JYURRK-SRYYMD   TO   WRK-SRYYMDX
                               IF   RECE41-JNISSUTBL(WRK-SRYDD) = SPACE
                                  CONTINUE
                               ELSE
                                  MOVE   "1"     TO    
                                        TBL-JUSHIN-ARI (IDX)
                                  MOVE   "1"     TO    
                                        TBL-JUSHIN-DAY (IDX WRK-SRYDD)
                               END-IF
                          ELSE
                            IF  JYURRK-SRYYMD  =  RECE41-TEKSTYMD
                               MOVE   JYURRK-SRYYMD   TO   WRK-SRYYMDX
                               IF   RECE41-JNISSUTBL(WRK-SRYDD) = SPACE
                                  CONTINUE
                               ELSE
                                  MOVE   "1"     TO    
                                        TBL-JUSHIN-ARI (IDX)
                                  MOVE   "1"     TO    
                                        TBL-JUSHIN-DAY (IDX WRK-SRYDD)
                               END-IF
                            END-IF
                          END-IF
                      END-IF      
                   END-IF
                  ELSE
                   IF    JYURRK-HKNKBN    =       "2"
                      MOVE   JYURRK-HKNCOMBINUM
                                       TO  WRK-HKNCOMBINUMX
                      IF  WRK-HKNCOMBINUM9  =  RECE41-HKNCOMBI
                            MOVE   JYURRK-SRYYMD   TO   WRK-SRYYMDX
                            IF   RECE41-JNISSUTBL(WRK-SRYDD) = SPACE
                               CONTINUE
                            ELSE
                               MOVE   "1"     TO    
                                        TBL-JUSHIN-ARI (IDX)
                               MOVE   "1"     TO    
                                        TBL-JUSHIN-DAY (IDX WRK-SRYDD)
                            END-IF
                      END-IF      
                   END-IF
                  END-IF
      *
                  MOVE    "JYURRK-KEY24"  TO  ORC-DBPATH 
                  PERFORM   JYURRK-READ-SEC
               END-PERFORM
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "JYURRK-KEY24"    TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           .
       2001-JUSHIN-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ê£¿ô¿ÇÎÅ²Ê¼õ¿Ç¤Î²Ê¡¦ÆüÉÕ¤ÎÊÔ½¸
      *****************************************************************
       2002-FREE-COMMENT-SEC          SECTION.
      *
           ADD      1                      TO  IDZ
           MOVE     ZERO                   TO  WRK-KETA
                                               WRK-KETA-TAIHI
                                               WRK-KETA2
      *
           IF  TBL-JUSHIN-SRYKANAME(IDX)  NOT =  SPACE
             INITIALIZE                      ORCSKANACHKAREA
             MOVE    "2"                     TO  KANACHK-SYORI 
             MOVE  TBL-JUSHIN-SRYKANAME(IDX) TO  KANACHK-MAE-INPUT
             CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
             IF      KANACHK-RC      =   ZERO
                 COMPUTE WRK-KETA          =   KANACHK-MAX
                 COMPUTE WRK-KETA-TAIHI    =   KANACHK-MAX
                 COMPUTE WRK-KETA2         =   KANACHK-MAX  /  2
                 MOVE    WRK-KETA2   TO  WK-FREE-YUKOKETA(IDZ)
                 MOVE    KANACHK-OUT-INPUT(1:KANACHK-MAX)
                                   TO  WK-FREE-NAME(IDZ)(1:KANACHK-MAX)
             END-IF
           END-IF
      *
           MOVE      ZERO          TO  FLG-FIRST
      *
           PERFORM   VARYING   IDY    FROM   1   BY   1
                          UNTIL   (IDY             >      31)
      *
             IF  TBL-JUSHIN-DAY(IDX IDY) =  "1"
                 IF  FLG-FIRST  =  ZERO
                    IF  IDY     <  10 
                       ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                       MOVE    "¡¡"
                           TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
      *
                       ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                       MOVE    TBL-DAY(IDY)(3:2)     
                           TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
      *
                       ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                       MOVE    "Æü"
                           TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
                    ELSE
                       ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                       MOVE    "¡¡"
                           TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
      *
                       ADD   2  TO  WK-FREE-YUKOKETA(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                       MOVE    TBL-DAY(IDY)     
                           TO  WK-FREE-NAME(IDZ)(WRK-KETA:4)
      *
                       ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                       MOVE    "Æü"
                           TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
                    END-IF
                    MOVE      1              TO  FLG-FIRST
                 ELSE
                    IF  IDY     <  10 
                       IF    WK-FREE-YUKOKETA(IDZ)  =  25
                          PERFORM  2002-FREE-COMMENT-KAIGYO-SEC
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    "¡¢"
                                    TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
                       ELSE
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "¡¢"
                                    TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
      *
                       END-IF
      *
                       IF    WK-FREE-YUKOKETA(IDZ)  =  24 OR 25
                          PERFORM  2002-FREE-COMMENT-KAIGYO-SEC
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    TBL-DAY(IDY)(3:2)     
                                    TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "Æü"
                                   TO  WK-FREE-NAME(IDZ)(WRK-KETA:2) 
                       ELSE
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    TBL-DAY(IDY)(3:2)     
                                    TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "Æü"
                                   TO  WK-FREE-NAME(IDZ)(WRK-KETA:2) 
                       END-IF
                    ELSE
                       IF    WK-FREE-YUKOKETA(IDZ)  =  25
                          PERFORM  2002-FREE-COMMENT-KAIGYO-SEC
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    "¡¢"
                                   TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
                       ELSE
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "¡¢"
                                   TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
                       END-IF
      *
                       IF    WK-FREE-YUKOKETA(IDZ)  =  23 OR 24 OR 25
                          PERFORM  2002-FREE-COMMENT-KAIGYO-SEC
                          ADD   2  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    TBL-DAY(IDY)     
                                   TO  WK-FREE-NAME(IDZ)(WRK-KETA:4)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                          MOVE    "Æü"
                                   TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
                       ELSE
                          ADD   2  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    TBL-DAY(IDY)     
                                   TO  WK-FREE-NAME(IDZ)(WRK-KETA:4)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                          MOVE    "Æü"
                                   TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
                       END-IF
                    END-IF
                 END-IF
             END-IF
      *
           END-PERFORM
           .
       2002-FREE-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ê£¿ô¿ÇÎÅ²Ê¼õ¿Ç¤Î²Ê¡¦ÆüÉÕ¤ÎÊÔ½¸¡Ê²þ¹Ô¡Ë
      *****************************************************************
       2002-FREE-COMMENT-KAIGYO-SEC          SECTION.
      *
           ADD      1              TO  IDZ
      *
           MOVE    WRK-KETA-TAIHI  TO  WRK-KETA
           MOVE    WRK-KETA2       TO  WK-FREE-YUKOKETA(IDZ)
           MOVE    ALL "¡¡"        TO  WK-FREE-NAME(IDZ)(1:WRK-KETA)
      *
           .
       2002-FREE-COMMENT-KAIGYO-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ê£¿ô¿ÇÎÅ²Ê¼õ¿Ç¤Î¥³¥á¥ó¥ÈÊÔ½¸
      *****************************************************************
       2002-JUSHIN-COMMENT-SEC          SECTION.
      *
      *    £Ò£Å£Ã£Å£°£µ¥Õ¥¡¥¤¥ë¤ÎÆâÍÆ¤ò¥Æ¡¼¥Ö¥ë¤ËÂàÈò
           MOVE    ZERO                TO  IDX-RECE45
           MOVE    SPACE               TO  WRK-SRYACTINF-AREA
           INITIALIZE                      WRK-SRYACTINF-AREA
           MOVE    SPACE               TO  WRK-NAMEINF-AREA
           INITIALIZE                      WRK-NAMEINF-AREA
           MOVE    SPACE               TO  WRK-SIKFLGINF-AREA
           INITIALIZE                      WRK-SIKFLGINF-AREA
      *
           ADD     1                   TO  IDX-RECE45
           MOVE    SPACE               TO  COM-RECE45-REC
           INITIALIZE                      COM-RECE45-REC
           MOVE    "099999901"         TO  COM-SRYCD(1)
           MOVE    ZERO                TO  COM-SRYSURYO(1)
           MOVE    7                   TO  COM-YUKOKETA(1)
           MOVE    "Ê£¿ô¿ÇÎÅ²Ê¼õ¿Ç"    TO  COM-NAME(1)
           MOVE    "1"                 TO  COM-SIKFLG(1)
           MOVE    COM-SRYACTINF(1)    TO  WRK-SRYACTINF
                                               (IDX-RECE45)
           MOVE    COM-NAMEINF(1)      TO  WRK-NAMEINF
                                               (IDX-RECE45)
           MOVE    COM-SIKFLGINF(1)    TO  WRK-SIKFLGINF
                                               (IDX-RECE45)
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX               >   49    )
                         OR      ( WK-FREE-NAME(IDX) =   SPACE )
                ADD    1                  TO  IDX-RECE45
                MOVE   "810000001"        TO  COM-SRYCD(2)
                MOVE   ZERO               TO  COM-SRYSURYO(2)
                MOVE   "1"                TO  COM-SIKFLG(2)
                MOVE   COM-SRYACTINF(2)   TO  WRK-SRYACTINF(IDX-RECE45)
                MOVE   WRK-FREEINF(IDX)   TO  WRK-NAMEINF(IDX-RECE45)
                MOVE   COM-SIKFLGINF(2)   TO  WRK-SIKFLGINF(IDX-RECE45)  
           END-PERFORM 
      *
      *    ²Ê¡¦ÆüÉÕ¤ÎÊÔ½¸¤ò´Þ¤ó¤ÀÆâÍÆ¤ÇÃæ´Ö¥Õ¥¡¥¤¥ë¤ÎºÆºîÀ®
           MOVE       ZERO             TO      FLG-WRKRECE45
           MOVE       ZERO             TO      IDX
           MOVE       ZERO             TO      IDX-RECE45
           MOVE       ZERO             TO      WRK-RENNUM
           MOVE       ZERO             TO      WRK-CNT-MEISAI
           PERFORM    UNTIL     FLG-WRKRECE45  =    1
                INITIALIZE                      RECE451-REC
                MOVE    RECE41-HOSPID       TO  RECE451-HOSPID
                MOVE    RECE41-SRYYM        TO  RECE451-SRYYM
                MOVE    RECE41-NYUGAIKBN    TO  RECE451-NYUGAIKBN
                MOVE    RECE41-PTID         TO  RECE451-PTID
                MOVE    RECE41-RECEKA       TO  RECE451-RECEKA
                MOVE    RECE41-HKNID        TO  RECE451-HKNID
                MOVE    RECE41-TEKSTYMD     TO  RECE451-TEKSTYMD
      *         MOVE    ZERO                TO  RECE451-ZAINUM
                MOVE    99999999            TO  RECE451-ZAINUM
                MOVE    "99"                TO  RECE451-SRYKBN
                ADD     1                   TO  WRK-RENNUM
                MOVE    WRK-RENNUM          TO  RECE451-RENNUM
                PERFORM  VARYING   IDX   FROM   1   BY   1
                         UNTIL   (IDX       >    5)   OR
                                 (FLG-WRKRECE45   =   1)
                   ADD         1             TO    IDX-RECE45
                   IF  WK-RECE45-SRYCD(IDX-RECE45) = SPACE
                       MOVE    1             TO    FLG-WRKRECE45
                   ELSE
                       MOVE  WRK-SRYACTINF(IDX-RECE45)
                                        TO   RECE451-SRYACTINF(IDX)  
                       MOVE  WRK-NAMEINF(IDX-RECE45)
                                        TO   RECE451-NAMEINF(IDX)
                       MOVE  WRK-SIKFLGINF(IDX-RECE45)
                                        TO   RECE451-SIKFLGINF(IDX)
                       ADD   1          TO   WRK-CNT-MEISAI
                   END-IF  
                END-PERFORM
                WRITE   RECE451-REC
                ADD     1                    TO  CNT-RECE45
           END-PERFORM     
      *
      *
           INITIALIZE                      RECE441-REC
           MOVE    RECE41-HOSPID       TO  RECE441-HOSPID
           MOVE    RECE41-SRYYM        TO  RECE441-SRYYM
           MOVE    RECE41-NYUGAIKBN    TO  RECE441-NYUGAIKBN
           MOVE    RECE41-PTID         TO  RECE441-PTID
           MOVE    RECE41-RECEKA       TO  RECE441-RECEKA
           MOVE    RECE41-HKNID        TO  RECE441-HKNID
           MOVE    RECE41-TEKSTYMD     TO  RECE441-TEKSTYMD
      *    MOVE    ZERO                TO  RECE441-ZAINUM
           MOVE    99999999            TO  RECE441-ZAINUM
           MOVE    "99"                TO  RECE441-SRYKBN
      *
           MOVE    WRK-CNT-MEISAI      TO  RECE441-MEISAISU
      *
           WRITE   RECE441-REC
           ADD     1                   TO  CNT-RECE44
      *
           .
       2002-JUSHIN-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥ê¥Ï¥Ó¥ê¤Î¥«¥¦¥ó¥È
      *****************************************************************
       2001-RIHA-COUNT-SEC          SECTION.
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                     UNTIL   ( IDX           >   TBL-RIHA-MAX )
      *
              INITIALIZE                        SRYACT-REC
              MOVE    RECE44-HOSPID     TO      SRY-HOSPID
              MOVE    RECE44-NYUGAIKBN  TO      SRY-NYUGAIKBN
              MOVE    RECE44-PTID       TO      SRY-PTID
              MOVE    RECE44-SRYYM      TO      SRY-SRYYM
              MOVE    RECE44-ZAINUM     TO      SRY-ZAINUM
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (1)
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (2)
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (3)
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (4)
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (5)
      *
              MOVE    SRYACT-REC        TO      MCPDATA-REC
              MOVE    "DBSELECT"        TO      MCP-FUNC
              MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
              CALL    "ORCMCPSUB"       USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
              IF  MCP-RC                =       ZERO
                  MOVE    "DBFETCH"     TO      MCP-FUNC
                  MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
                  CALL    "ORCMCPSUB"           USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                  IF      MCP-RC        =       ZERO
                     EVALUATE    IDX
                        WHEN   1  
                        WHEN   2
                           MOVE    1    TO    IDX2   
                        WHEN   3  
                        WHEN   4
                           MOVE    2    TO    IDX2   
                        WHEN   5  
                        WHEN   6
                           MOVE    3    TO    IDX2   
                        WHEN   7  
                        WHEN   8
                           MOVE    4    TO    IDX2   
                        WHEN   9  
                        WHEN  10
                           MOVE    5    TO    IDX2   
                        WHEN  11  
                        WHEN  12
                           MOVE    6    TO    IDX2   
                        WHEN  13  
                        WHEN  14
                           MOVE    7    TO    IDX2   
                        WHEN  15  
                        WHEN  16
                           MOVE    8    TO    IDX2   
                        WHEN  17  
                        WHEN  18
                           MOVE    9    TO    IDX2   
                        WHEN  19  
                        WHEN  20
                           MOVE   10    TO    IDX2   
                        WHEN  21  
                        WHEN  22
                           MOVE   11    TO    IDX2   
                        WHEN  23  
                        WHEN  24
                           MOVE   12    TO    IDX2   
                        WHEN  25  
                           MOVE   13    TO    IDX2
                        WHEN  26
                           MOVE   14    TO    IDX2   
                        WHEN  27  
                           MOVE   15    TO    IDX2
                        WHEN  28
                           MOVE   16    TO    IDX2   
                     END-EVALUATE
                     IF      RECE41-HKNKBN   NOT  =   "3"
                        IF  RECE44-ZAINUM  >  WRK-RIHA-ZAINUM(IDX2)
                            MOVE  RECE44-ZAINUM  
                                          TO  WRK-RIHA-ZAINUM(IDX2)
                        END-IF
                        PERFORM  VARYING   IDX1  FROM  1  BY  1
                              UNTIL     IDX1  >   31
                            IF   RECE44-KAISU(1 IDX1)  NOT = ZERO
                                 MOVE  "1"  TO  WRK-RIGAKU(IDX2 IDX1)
                            END-IF
                        END-PERFORM
                     ELSE
                        MOVE   RECE41-TEKSTYMD(7:2)  TO  WRK-DAY
                        IF   RECE44-KAISU(1 WRK-DAY)  NOT = ZERO
                           IF  RECE44-ZAINUM  >  WRK-RIHA-ZAINUM(IDX2)
                               MOVE  RECE44-ZAINUM  
                                             TO  WRK-RIHA-ZAINUM(IDX2)
                           END-IF
                           MOVE  "1"  TO  WRK-RIGAKU(IDX2 WRK-DAY)
                        END-IF
                     END-IF
                  END-IF
              END-IF
      *
              INITIALIZE                        MCPAREA
              MOVE    "DBCLOSE"         TO      MCP-FUNC
              MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
              CALL    "ORCMCPSUB"       USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           END-PERFORM
      *
           .
       2001-RIHA-COUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ËýÀ­áÖÄË¼À´µ´ÉÍýÎÁ¤¬¤¢¤ë¤«È½Äê
      *****************************************************************
       2001-SHIDOU-HANTEI-SEC          SECTION.
      *
           IF      RECE41-HKNKBN   NOT  =   "3"
      *
             MOVE    ZERO              TO      FLG-SHIDOU-COMMENT
      *
             INITIALIZE                        SRYACT-REC
             MOVE    RECE44-HOSPID     TO      SRY-HOSPID
             MOVE    RECE44-NYUGAIKBN  TO      SRY-NYUGAIKBN
             MOVE    RECE44-PTID       TO      SRY-PTID
             MOVE    RECE44-SRYYM      TO      SRY-SRYYM
             MOVE    RECE44-ZAINUM     TO      SRY-ZAINUM
             MOVE    CONS-MANSEI       TO      SRY-SRYCD (1)
             MOVE    CONS-MANSEI       TO      SRY-SRYCD (2)
             MOVE    CONS-MANSEI       TO      SRY-SRYCD (3)
             MOVE    CONS-MANSEI       TO      SRY-SRYCD (4)
             MOVE    CONS-MANSEI       TO      SRY-SRYCD (5)
      *
             MOVE    SRYACT-REC        TO      MCPDATA-REC
             MOVE    "DBSELECT"        TO      MCP-FUNC
             MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
             CALL    "ORCMCPSUB"       USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
             IF  MCP-RC                NOT  =  ZERO
                 CONTINUE
             ELSE
                 MOVE    "DBFETCH"     TO      MCP-FUNC
                 MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
                 CALL    "ORCMCPSUB"           USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                 IF      MCP-RC        =       ZERO
                     MOVE    1         TO      FLG-SHIDOU-COMMENT
                 END-IF
             END-IF
      *
             INITIALIZE                        MCPAREA
             MOVE    "DBCLOSE"         TO      MCP-FUNC
             MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
             CALL    "ORCMCPSUB"       USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
      *      »»ÄêÍúÎò¸¡º÷
             INITIALIZE                  SANTEI-REC
             MOVE    RECE44-HOSPID       TO  SANTEI-HOSPID
             MOVE    RECE44-PTID         TO  SANTEI-PTID
             MOVE    RECE44-SRYYM        TO  SANTEI-SRYYM
             MOVE    CONS-MANSEI         TO  SANTEI-SRYCD
             MOVE    ZERO                TO  SANTEI-NYUGAIKBN
             MOVE    ZERO                TO  SANTEI-SRYKA
             MOVE    ZERO                TO  SANTEI-HKNCOMBINUM
             MOVE    SANTEI-REC          TO  MCPDATA-REC
             MOVE    "DBSELECT"          TO  MCP-FUNC
             MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
             CALL    "ORCMCPSUB"         USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
             IF      MCP-RC              =   ZERO
                  MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
                  PERFORM        SANTEI-READ-SEC
                  PERFORM   UNTIL   FLG-SANTEI  =   1
      *
                     IF     SANTEI-FSANTEIYMD(1:6)  =  RECE44-SRYYM   
                           CONTINUE
                     ELSE
                           MOVE    ZERO    TO      FLG-SHIDOU-COMMENT
                     END-IF
      * 
                     MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
                     PERFORM        SANTEI-READ-SEC
                  END-PERFORM
             END-IF
      *
             MOVE    "DBCLOSE"           TO  MCP-FUNC
             MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
             CALL    "ORCMCPSUB"         USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
      *
           ELSE
      *
             MOVE    ZERO              TO      FLG-SHIDOU-COMMENT
      *
             INITIALIZE                        SRYACT-REC
             MOVE    RECE44-HOSPID     TO      SRY-HOSPID
             MOVE    RECE44-NYUGAIKBN  TO      SRY-NYUGAIKBN
             MOVE    RECE44-PTID       TO      SRY-PTID
             MOVE    RECE44-SRYYM      TO      SRY-SRYYM
             MOVE    RECE44-ZAINUM     TO      SRY-ZAINUM
             MOVE    CONS-MANSEI       TO      SRY-SRYCD (1)
             MOVE    CONS-MANSEI       TO      SRY-SRYCD (2)
             MOVE    CONS-MANSEI       TO      SRY-SRYCD (3)
             MOVE    CONS-MANSEI       TO      SRY-SRYCD (4)
             MOVE    CONS-MANSEI       TO      SRY-SRYCD (5)
      *
             MOVE    SRYACT-REC        TO      MCPDATA-REC
             MOVE    "DBSELECT"        TO      MCP-FUNC
             MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
             CALL    "ORCMCPSUB"       USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
             IF  MCP-RC                =       ZERO
                 MOVE    "DBFETCH"     TO      MCP-FUNC
                 MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
                 CALL    "ORCMCPSUB"           USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                 IF      MCP-RC        =       ZERO
                      MOVE  RECE41-TEKSTYMD(7:2)  TO  WRK-DAY
                      IF   RECE44-KAISU(1 WRK-DAY)  NOT = ZERO
                          MOVE  1  TO   FLG-SHIDOU-COMMENT
                      END-IF
                 END-IF
             END-IF
      *
             INITIALIZE                        MCPAREA
             MOVE    "DBCLOSE"         TO      MCP-FUNC
             MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
             CALL    "ORCMCPSUB"       USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
      *      »»ÄêÍúÎò¸¡º÷
             INITIALIZE                  SANTEI-REC
             MOVE    RECE44-HOSPID       TO  SANTEI-HOSPID
             MOVE    RECE44-PTID         TO  SANTEI-PTID
             MOVE    RECE44-SRYYM        TO  SANTEI-SRYYM
             MOVE    CONS-MANSEI         TO  SANTEI-SRYCD
             MOVE    ZERO                TO  SANTEI-NYUGAIKBN
             MOVE    ZERO                TO  SANTEI-SRYKA
             MOVE    ZERO                TO  SANTEI-HKNCOMBINUM
             MOVE    SANTEI-REC          TO  MCPDATA-REC
             MOVE    "DBSELECT"          TO  MCP-FUNC
             MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
             CALL    "ORCMCPSUB"         USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
             IF      MCP-RC              =   ZERO
                  MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
                  PERFORM        SANTEI-READ-SEC
                  PERFORM   UNTIL   FLG-SANTEI  =   1
      *
                     IF     SANTEI-FSANTEIYMD(1:6)  =  RECE44-SRYYM   
                           CONTINUE
                     ELSE
                           MOVE    ZERO    TO      FLG-SHIDOU-COMMENT
                     END-IF
      * 
                     MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
                     PERFORM        SANTEI-READ-SEC
                  END-PERFORM
             END-IF
      *
             MOVE    "DBCLOSE"           TO  MCP-FUNC
             MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
             CALL    "ORCMCPSUB"         USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
      *
           END-IF
      *
      *
           IF      FLG-SHIDOU-COMMENT    =      1
               MOVE       99      TO     FLG-COMMENT
               PERFORM    2001-SHIDOU-COMMENT-SEC
           END-IF         
      *
           .
       2001-SHIDOU-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    ËýÀ­áÖÄË¼À´µ´ÉÍýÎÁ¤Î¥³¥á¥ó¥ÈÊÔ½¸
      *****************************************************************
       2001-SHIDOU-COMMENT-SEC          SECTION.
      *
           PERFORM   2001-SANTEI-DAY-SEC
      *
           MOVE       RECE44-REC    TO   RECE441-REC
           ADD        1             TO   RECE441-MEISAISU
           WRITE      RECE441-REC
           ADD        1             TO   CNT-RECE44
      *
           INITIALIZE                      RECE45-REC
           MOVE    RECE44-HOSPID       TO  RECE45-HOSPID
           MOVE    RECE44-SRYYM        TO  RECE45-SRYYM
           MOVE    RECE44-NYUGAIKBN    TO  RECE45-NYUGAIKBN
           MOVE    RECE44-PTID         TO  RECE45-PTID
           MOVE    RECE44-RECEKA       TO  RECE45-RECEKA
           MOVE    RECE44-HKNID        TO  RECE45-HKNID
           MOVE    RECE44-TEKSTYMD     TO  RECE45-TEKSTYMD
           MOVE    RECE44-ZAINUM       TO  RECE45-ZAINUM
           START   RECE45-FILE
                 KEY IS    >=   RECE45-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE45
                 NOT INVALID
                     PERFORM 990-RECE45-NEXT-SEC
           END-START
      *
           MOVE    RECE45-REC       TO      RECE451-REC
           MOVE    RECE45-SRYACTINF(1)  TO  RECE451-SRYACTINF(1)
           MOVE    RECE45-SRYACTINF(2)  TO  RECE451-SRYACTINF(3)
           MOVE    RECE45-SRYACTINF(3)  TO  RECE451-SRYACTINF(4)
           MOVE    RECE45-SRYACTINF(4)  TO  RECE451-SRYACTINF(5)
           MOVE    RECE45-NAMEINF(1)    TO  RECE451-NAMEINF(1)
           MOVE    RECE45-NAMEINF(2)    TO  RECE451-NAMEINF(3)
           MOVE    RECE45-NAMEINF(3)    TO  RECE451-NAMEINF(4)
           MOVE    RECE45-NAMEINF(4)    TO  RECE451-NAMEINF(5)
           MOVE    RECE45-SIKFLGINF(1)  TO  RECE451-SIKFLGINF(1)
           MOVE    RECE45-SIKFLGINF(2)  TO  RECE451-SIKFLGINF(3)
           MOVE    RECE45-SIKFLGINF(3)  TO  RECE451-SIKFLGINF(4)
           MOVE    RECE45-SIKFLGINF(4)  TO  RECE451-SIKFLGINF(5)
           MOVE    RECE45-DATAKBNINF(1) TO  RECE451-DATAKBNINF(1)
           MOVE    RECE45-DATAKBNINF(2) TO  RECE451-DATAKBNINF(3)
           MOVE    RECE45-DATAKBNINF(3) TO  RECE451-DATAKBNINF(4)
           MOVE    RECE45-DATAKBNINF(4) TO  RECE451-DATAKBNINF(5)
      *
           MOVE    SPACE                TO  RECE451-SRYACTINF(2)
           INITIALIZE                       RECE451-SRYACTINF(2)
           MOVE    SPACE                TO  RECE451-NAMEINF(2)
           INITIALIZE                       RECE451-NAMEINF(2)
           MOVE    SPACE                TO  RECE451-SIKFLGINF(2)
           INITIALIZE                       RECE451-SIKFLGINF(2) 
      *
           MOVE    "810000001"          TO  RECE451-SRYCD(2)
           MOVE    ZERO                 TO  RECE451-SRYSURYO(2)
           MOVE    15                   TO  RECE451-YUKOKETA(2)
           MOVE    "ËýÀ­áÖÄË¼À´µ´ÉÍý»»ÄêÆü¡¡¡¡¡¡Æü"
                                        TO  RECE451-NAME(2)
           MOVE     TB-SANTEI-DAY(1)    TO  DAY-IDX
           MOVE     TBL-DAY(DAY-IDX)    TO  RECE451-NAME(2)(25:4)
      *
           MOVE     "1"                 TO  RECE451-SIKFLG(2)
      *
           WRITE    RECE451-REC
           ADD      1                    TO  CNT-RECE45
      *
           .
       2001-SHIDOU-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ½ýÉÂ¼êÅö¶â°Õ¸«½ñ¸òÉÕÎÁ¤¬¤¢¤ë¤«È½Äê
      *****************************************************************
       2001-SYOBYO-HANTEI-SEC          SECTION.
      *
           IF      RECE41-HKNKBN   NOT  =   "3"
      *
             MOVE      ZERO            TO      FLG-SYOBYO-COMMENT
      *
             INITIALIZE                        SRYACT-REC
             MOVE    RECE44-HOSPID     TO      SRY-HOSPID
             MOVE    RECE44-NYUGAIKBN  TO      SRY-NYUGAIKBN
             MOVE    RECE44-PTID       TO      SRY-PTID
             MOVE    RECE44-SRYYM      TO      SRY-SRYYM
             MOVE    RECE44-ZAINUM     TO      SRY-ZAINUM
             MOVE    CONS-SYOBYO-COMMENT   TO  SRY-SRYCD (1)
             MOVE    CONS-SYOBYO-COMMENT   TO  SRY-SRYCD (2)
             MOVE    CONS-SYOBYO-COMMENT   TO  SRY-SRYCD (3)
             MOVE    CONS-SYOBYO-COMMENT   TO  SRY-SRYCD (4)
             MOVE    CONS-SYOBYO-COMMENT   TO  SRY-SRYCD (5)
      *
             MOVE    SRYACT-REC        TO      MCPDATA-REC
             MOVE    "DBSELECT"        TO      MCP-FUNC
             MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
             CALL    "ORCMCPSUB"       USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
             IF  MCP-RC                NOT  =  ZERO
                 CONTINUE
             ELSE
                 MOVE    "DBFETCH"     TO      MCP-FUNC
                 MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
                 CALL    "ORCMCPSUB"           USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                 IF      MCP-RC        =       ZERO
                     MOVE    1         TO      FLG-SYOBYO-COMMENT
                 END-IF
             END-IF
      *
             INITIALIZE                        MCPAREA
             MOVE    "DBCLOSE"         TO      MCP-FUNC
             MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
             CALL    "ORCMCPSUB"       USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           ELSE
      *
             MOVE      ZERO              TO      FLG-SYOBYO-COMMENT
             MOVE      ZERO              TO      FLG-ARI   
      *
             MOVE  RECE41-TEKSTYMD(7:2)  TO  WRK-DAY
             IF   RECE44-KAISU(1 WRK-DAY)  NOT = ZERO
                MOVE    1    TO    FLG-ARI
             END-IF
      *
             IF         FLG-ARI       =     1 
      *
               INITIALIZE                        SRYACT-REC
               MOVE    RECE44-HOSPID     TO      SRY-HOSPID
               MOVE    RECE44-NYUGAIKBN  TO      SRY-NYUGAIKBN
               MOVE    RECE44-PTID       TO      SRY-PTID
               MOVE    RECE44-SRYYM      TO      SRY-SRYYM
               MOVE    RECE44-ZAINUM     TO      SRY-ZAINUM
               MOVE    CONS-SYOBYO-COMMENT   TO  SRY-SRYCD (1)
               MOVE    CONS-SYOBYO-COMMENT   TO  SRY-SRYCD (2)
               MOVE    CONS-SYOBYO-COMMENT   TO  SRY-SRYCD (3)
               MOVE    CONS-SYOBYO-COMMENT   TO  SRY-SRYCD (4)
               MOVE    CONS-SYOBYO-COMMENT   TO  SRY-SRYCD (5)
      *
               MOVE    SRYACT-REC        TO      MCPDATA-REC
               MOVE    "DBSELECT"        TO      MCP-FUNC
               MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
               CALL    "ORCMCPSUB"       USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
      *
               IF  MCP-RC                NOT  =  ZERO
                   CONTINUE
               ELSE
                   MOVE    "DBFETCH"     TO      MCP-FUNC
                   MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"           USING
                                                 MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
                   IF      MCP-RC        =       ZERO
                       MOVE    1         TO      FLG-SYOBYO-COMMENT
                   END-IF
               END-IF
      *
               INITIALIZE                        MCPAREA
               MOVE    "DBCLOSE"         TO      MCP-FUNC
               MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
               CALL    "ORCMCPSUB"       USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
      *
             END-IF
      *
           END-IF
      *
           IF      FLG-SYOBYO-COMMENT   =      1
                MOVE       4       TO     FLG-COMMENT
                PERFORM    2001-SHUJUTSU-ETC2-COMMENT-SEC
           END-IF
      *
           .
       2001-SYOBYO-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÎÅÍÜÈñÆ±°Õ½ñ¸òÉÕÎÁ¤¬¤¢¤ë¤«È½Äê
      *****************************************************************
       2001-RYOYO-HANTEI-SEC          SECTION.
      *
           IF      RECE41-HKNKBN   NOT  =   "3"
      *
             MOVE      ZERO            TO      FLG-RYOYO-COMMENT
      *
             INITIALIZE                        SRYACT-REC
             MOVE    RECE44-HOSPID     TO      SRY-HOSPID
             MOVE    RECE44-NYUGAIKBN  TO      SRY-NYUGAIKBN
             MOVE    RECE44-PTID       TO      SRY-PTID
             MOVE    RECE44-SRYYM      TO      SRY-SRYYM
             MOVE    RECE44-ZAINUM     TO      SRY-ZAINUM
             MOVE    CONS-RYOYO-COMMENT    TO  SRY-SRYCD (1)
             MOVE    CONS-RYOYO-COMMENT    TO  SRY-SRYCD (2)
             MOVE    CONS-RYOYO-COMMENT    TO  SRY-SRYCD (3)
             MOVE    CONS-RYOYO-COMMENT    TO  SRY-SRYCD (4)
             MOVE    CONS-RYOYO-COMMENT    TO  SRY-SRYCD (5)
      *
             MOVE    SRYACT-REC        TO      MCPDATA-REC
             MOVE    "DBSELECT"        TO      MCP-FUNC
             MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
             CALL    "ORCMCPSUB"       USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
             IF  MCP-RC                NOT  =  ZERO
                 CONTINUE
             ELSE
                 MOVE    "DBFETCH"     TO      MCP-FUNC
                 MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
                 CALL    "ORCMCPSUB"           USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                 IF      MCP-RC        =       ZERO
                     MOVE    1         TO      FLG-RYOYO-COMMENT
                 END-IF
             END-IF
      *
             INITIALIZE                        MCPAREA
             MOVE    "DBCLOSE"         TO      MCP-FUNC
             MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
             CALL    "ORCMCPSUB"       USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           ELSE
      *
             MOVE      ZERO              TO      FLG-RYOYO-COMMENT
             MOVE      ZERO              TO      FLG-ARI   
      *
             MOVE  RECE41-TEKSTYMD(7:2)  TO  WRK-DAY
             IF   RECE44-KAISU(1 WRK-DAY)  NOT = ZERO
                MOVE    1    TO    FLG-ARI
             END-IF
      *
             IF         FLG-ARI       =     1 
      *
               INITIALIZE                        SRYACT-REC
               MOVE    RECE44-HOSPID     TO      SRY-HOSPID
               MOVE    RECE44-NYUGAIKBN  TO      SRY-NYUGAIKBN
               MOVE    RECE44-PTID       TO      SRY-PTID
               MOVE    RECE44-SRYYM      TO      SRY-SRYYM
               MOVE    RECE44-ZAINUM     TO      SRY-ZAINUM
               MOVE    CONS-RYOYO-COMMENT    TO  SRY-SRYCD (1)
               MOVE    CONS-RYOYO-COMMENT    TO  SRY-SRYCD (2)
               MOVE    CONS-RYOYO-COMMENT    TO  SRY-SRYCD (3)
               MOVE    CONS-RYOYO-COMMENT    TO  SRY-SRYCD (4)
               MOVE    CONS-RYOYO-COMMENT    TO  SRY-SRYCD (5)
      *
               MOVE    SRYACT-REC        TO      MCPDATA-REC
               MOVE    "DBSELECT"        TO      MCP-FUNC
               MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
               CALL    "ORCMCPSUB"       USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
      *
               IF  MCP-RC                NOT  =  ZERO
                   CONTINUE
               ELSE
                   MOVE    "DBFETCH"     TO      MCP-FUNC
                   MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"           USING
                                                 MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
                   IF      MCP-RC        =       ZERO
                       MOVE    1         TO      FLG-RYOYO-COMMENT
                   END-IF
               END-IF
      *
               INITIALIZE                        MCPAREA
               MOVE    "DBCLOSE"         TO      MCP-FUNC
               MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
               CALL    "ORCMCPSUB"       USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
      *
             END-IF
      *
           END-IF
      *
           IF      FLG-RYOYO-COMMENT   =      1
                MOVE       4       TO     FLG-COMMENT
                PERFORM    2001-SHUJUTSU-ETC2-COMMENT-SEC
           END-IF
      *
           .
       2001-RYOYO-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼ê½ÑÆü¤Î¥³¥á¥ó¥È¤¬¤¢¤ë¤«È½Äê
      *****************************************************************
       2001-SHUJUTSU-HANTEI-SEC          SECTION.
      *
           IF      RECE41-HKNKBN   NOT  =   "3"
      *
             MOVE    ZERO              TO      FLG-SHUJUTU-COMMENT
      *
             INITIALIZE                        SRYACT-REC
             MOVE    RECE44-HOSPID     TO      SRY-HOSPID
             MOVE    RECE44-NYUGAIKBN  TO      SRY-NYUGAIKBN
             MOVE    RECE44-PTID       TO      SRY-PTID
             MOVE    RECE44-SRYYM      TO      SRY-SRYYM
             MOVE    RECE44-ZAINUM     TO      SRY-ZAINUM
             MOVE    CONS-SHUJUTU-COMMENT  TO  SRY-SRYCD (1)
             MOVE    CONS-SHUJUTU-COMMENT  TO  SRY-SRYCD (2)
             MOVE    CONS-SHUJUTU-COMMENT  TO  SRY-SRYCD (3)
             MOVE    CONS-SHUJUTU-COMMENT  TO  SRY-SRYCD (4)
             MOVE    CONS-SHUJUTU-COMMENT  TO  SRY-SRYCD (5)
      *
             MOVE    SRYACT-REC        TO      MCPDATA-REC
             MOVE    "DBSELECT"        TO      MCP-FUNC
             MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
             CALL    "ORCMCPSUB"       USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
             IF  MCP-RC                NOT  =  ZERO
                 MOVE      1           TO      FLG-SHUJUTU-COMMENT
             ELSE
                 MOVE    "DBFETCH"     TO      MCP-FUNC
                 MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
                 CALL    "ORCMCPSUB"           USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                 IF      MCP-RC        =       ZERO
                     CONTINUE
                 ELSE
                     MOVE    1         TO      FLG-SHUJUTU-COMMENT
                 END-IF
             END-IF
      *
             INITIALIZE                        MCPAREA
             MOVE    "DBCLOSE"         TO      MCP-FUNC
             MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
             CALL    "ORCMCPSUB"       USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           ELSE
      *
             MOVE    ZERO              TO      FLG-SHUJUTU-COMMENT
             MOVE    ZERO              TO      FLG-ARI   
      *
             MOVE  RECE41-TEKSTYMD(7:2)  TO  WRK-DAY
             IF   RECE44-KAISU(1 WRK-DAY)  NOT = ZERO
                MOVE    1    TO    FLG-ARI
             END-IF
      *
             IF         FLG-ARI       =     1 
      *
               INITIALIZE                        SRYACT-REC
               MOVE    RECE44-HOSPID     TO      SRY-HOSPID
               MOVE    RECE44-NYUGAIKBN  TO      SRY-NYUGAIKBN
               MOVE    RECE44-PTID       TO      SRY-PTID
               MOVE    RECE44-SRYYM      TO      SRY-SRYYM
               MOVE    RECE44-ZAINUM     TO      SRY-ZAINUM
               MOVE    CONS-SHUJUTU-COMMENT  TO  SRY-SRYCD (1)
               MOVE    CONS-SHUJUTU-COMMENT  TO  SRY-SRYCD (2)
               MOVE    CONS-SHUJUTU-COMMENT  TO  SRY-SRYCD (3)
               MOVE    CONS-SHUJUTU-COMMENT  TO  SRY-SRYCD (4)
               MOVE    CONS-SHUJUTU-COMMENT  TO  SRY-SRYCD (5)
      *
               MOVE    SRYACT-REC        TO      MCPDATA-REC
               MOVE    "DBSELECT"        TO      MCP-FUNC
               MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
               CALL    "ORCMCPSUB"       USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
      *
               IF  MCP-RC                NOT  =  ZERO
                   MOVE      1           TO      FLG-SHUJUTU-COMMENT
               ELSE
                   MOVE    "DBFETCH"     TO      MCP-FUNC
                   MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"           USING
                                                 MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
                   IF      MCP-RC        =       ZERO
                       CONTINUE
                   ELSE
                       MOVE    1         TO      FLG-SHUJUTU-COMMENT
                   END-IF
               END-IF
      *
               INITIALIZE                        MCPAREA
               MOVE    "DBCLOSE"         TO      MCP-FUNC
               MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
               CALL    "ORCMCPSUB"       USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
      *
             END-IF    
      *
           END-IF
      *
      *    Í¢·ì¤Ï½ü¤¯
           INITIALIZE                      RECE45-REC
           MOVE    RECE44-HOSPID       TO  RECE45-HOSPID
           MOVE    RECE44-SRYYM        TO  RECE45-SRYYM
           MOVE    RECE44-NYUGAIKBN    TO  RECE45-NYUGAIKBN
           MOVE    RECE44-PTID         TO  RECE45-PTID
           MOVE    RECE44-RECEKA       TO  RECE45-RECEKA
           MOVE    RECE44-HKNID        TO  RECE45-HKNID
           MOVE    RECE44-TEKSTYMD     TO  RECE45-TEKSTYMD
           MOVE    RECE44-ZAINUM       TO  RECE45-ZAINUM
           START   RECE45-FILE
                 KEY IS    >=   RECE45-KEY
                 INVALID
                     MOVE    1         TO  FLG-RECE45
                 NOT INVALID
                     PERFORM 990-RECE45-NEXT-SEC
           END-START
           IF     RECE45-SRYSYUKBN  =  "510"
                    MOVE     ZERO      TO  FLG-SHUJUTU-COMMENT
           END-IF
      *
           IF     (FLG-SHUJUTU-COMMENT   =      1)  AND
                  (RECE44-SYUTEN1    NOT =   ZERO)
               MOVE       1       TO     FLG-COMMENT
               PERFORM    2001-SHUJUTSU-ETC-COMMENT-SEC
           ELSE
               MOVE       RECE44-REC    TO   RECE441-REC
               WRITE      RECE441-REC
               ADD     1          TO      CNT-RECE44
               PERFORM    2002-RECE45-TENSOU-SEC
           END-IF
      *
           .
       2001-SHUJUTSU-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ã£Ô¡¦£Í£Ò£É¤¬¤¢¤ë¤«È½Äê
      *****************************************************************
       2001-CTMRI-HANTEI-SEC          SECTION.
      *
           IF      RECE41-HKNKBN   NOT  =   "3"
      *
             MOVE      ZERO              TO      FLG-CTMRI-COMMENT
      *
             PERFORM   VARYING   IDX   FROM    1   BY  1
                       UNTIL   ( IDX           >   TBL-CTMRI-MAX )
                        OR     ( FLG-CTMRI-COMMENT  =   1        )
      *
               INITIALIZE                        SRYACT-REC
               MOVE    RECE44-HOSPID     TO      SRY-HOSPID
               MOVE    RECE44-NYUGAIKBN  TO      SRY-NYUGAIKBN
               MOVE    RECE44-PTID       TO      SRY-PTID
               MOVE    RECE44-SRYYM      TO      SRY-SRYYM
               MOVE    RECE44-ZAINUM     TO      SRY-ZAINUM
               MOVE    TBL-CTMRI(IDX)    TO      SRY-SRYCD (1)
               MOVE    TBL-CTMRI(IDX)    TO      SRY-SRYCD (2)
               MOVE    TBL-CTMRI(IDX)    TO      SRY-SRYCD (3)
               MOVE    TBL-CTMRI(IDX)    TO      SRY-SRYCD (4)
               MOVE    TBL-CTMRI(IDX)    TO      SRY-SRYCD (5)
      *
               MOVE    SRYACT-REC        TO      MCPDATA-REC
               MOVE    "DBSELECT"        TO      MCP-FUNC
               MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
               CALL    "ORCMCPSUB"       USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
      *
               IF  MCP-RC                NOT  =  ZERO
                   CONTINUE
               ELSE
                   MOVE    "DBFETCH"     TO      MCP-FUNC
                   MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"           USING
                                                 MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
                   IF      MCP-RC        =       ZERO
                       MOVE    1         TO      FLG-CTMRI-COMMENT
                   END-IF
               END-IF
      *
               INITIALIZE                        MCPAREA
               MOVE    "DBCLOSE"         TO      MCP-FUNC
               MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
               CALL    "ORCMCPSUB"       USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
      *
             END-PERFORM
      *
           ELSE
      *
             MOVE      ZERO              TO      FLG-CTMRI-COMMENT
             MOVE      ZERO              TO      FLG-ARI   
      *
             MOVE  RECE41-TEKSTYMD(7:2)  TO  WRK-DAY
             IF   RECE44-KAISU(1 WRK-DAY)  NOT = ZERO
                MOVE    1    TO    FLG-ARI
             END-IF
      *
             IF         FLG-ARI       =     1 
      *
               PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX           >   TBL-CTMRI-MAX )
                          OR     ( FLG-CTMRI-COMMENT  =   1        )
      *
                 INITIALIZE                        SRYACT-REC
                 MOVE    RECE44-HOSPID     TO      SRY-HOSPID
                 MOVE    RECE44-NYUGAIKBN  TO      SRY-NYUGAIKBN
                 MOVE    RECE44-PTID       TO      SRY-PTID
                 MOVE    RECE44-SRYYM      TO      SRY-SRYYM
                 MOVE    RECE44-ZAINUM     TO      SRY-ZAINUM
                 MOVE    TBL-CTMRI(IDX)    TO      SRY-SRYCD (1)
                 MOVE    TBL-CTMRI(IDX)    TO      SRY-SRYCD (2)
                 MOVE    TBL-CTMRI(IDX)    TO      SRY-SRYCD (3)
                 MOVE    TBL-CTMRI(IDX)    TO      SRY-SRYCD (4)
                 MOVE    TBL-CTMRI(IDX)    TO      SRY-SRYCD (5)
      *
                 MOVE    SRYACT-REC        TO      MCPDATA-REC
                 MOVE    "DBSELECT"        TO      MCP-FUNC
                 MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
                 CALL    "ORCMCPSUB"       USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
                 IF  MCP-RC                NOT  =  ZERO
                     CONTINUE
                 ELSE
                     MOVE    "DBFETCH"     TO      MCP-FUNC
                     MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
                     CALL    "ORCMCPSUB"           USING
                                                   MCPAREA
                                                   ORCMCPAREA
                                                   MCPDATA-REC
                     IF      MCP-RC        =       ZERO
                         MOVE    1         TO      FLG-CTMRI-COMMENT
                     END-IF
                 END-IF
      *
                 INITIALIZE                        MCPAREA
                 MOVE    "DBCLOSE"         TO      MCP-FUNC
                 MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
                 CALL    "ORCMCPSUB"       USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
               END-PERFORM
      *
             END-IF
      *
           END-IF
      *
           IF      FLG-CTMRI-COMMENT   =      1
                MOVE       2       TO     FLG-COMMENT
                PERFORM    2001-SHUJUTSU-ETC-COMMENT-SEC
           ELSE
                MOVE       RECE44-REC    TO   RECE441-REC
                WRITE      RECE441-REC
                ADD     1          TO      CNT-RECE44
                PERFORM    2002-RECE45-TENSOU-SEC
           END-IF
      *
           .
       2001-CTMRI-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼ê½ÑÆüÅù¤Î¥³¥á¥ó¥ÈÊÔ½¸
      *****************************************************************
       2001-SHUJUTSU-ETC-COMMENT-SEC          SECTION.
      *
           PERFORM   2001-SANTEI-DAY-SEC
      *
           MOVE       ZERO       TO   IDZ                               
           INITIALIZE            WRK-FREE-AREA2                         
      *
           PERFORM  2002-FREE-COMMENT2-SEC                              
      *
      *    ¢¨ÌÀºÙ¤¬£µ°Ê¾å¤Î¾ì¹ç
           INITIALIZE                      RECE45-REC
           MOVE    RECE44-HOSPID       TO  RECE45-HOSPID
           MOVE    RECE44-SRYYM        TO  RECE45-SRYYM
           MOVE    RECE44-NYUGAIKBN    TO  RECE45-NYUGAIKBN
           MOVE    RECE44-PTID         TO  RECE45-PTID
           MOVE    RECE44-RECEKA       TO  RECE45-RECEKA
           MOVE    RECE44-HKNID        TO  RECE45-HKNID
           MOVE    RECE44-TEKSTYMD     TO  RECE45-TEKSTYMD
           MOVE    RECE44-ZAINUM       TO  RECE45-ZAINUM
           START   RECE45-FILE
                 KEY IS    >=   RECE45-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE45
                 NOT INVALID
                     PERFORM 990-RECE45-NEXT-SEC
                     MOVE    RECE45-REC  TO  WRK-RECE45-REC
           END-START
      *
      *    £Ò£Å£Ã£Å£°£µ¥Õ¥¡¥¤¥ë¤ÎÆâÍÆ¤ò¥Æ¡¼¥Ö¥ë¤ËÂàÈò
           MOVE    ZERO                 TO  IDX-RECE45
           MOVE    SPACE                TO  WRK-SRYACTINF-AREA
           INITIALIZE                       WRK-SRYACTINF-AREA
           MOVE    SPACE                TO  WRK-NAMEINF-AREA
           INITIALIZE                       WRK-NAMEINF-AREA
           MOVE    SPACE                TO  WRK-SIKFLGINF-AREA
           INITIALIZE                       WRK-SIKFLGINF-AREA
           MOVE    SPACE                TO  WRK-DATAKBNINF-AREA
           INITIALIZE                       WRK-DATAKBNINF-AREA
      *    ¼ê½ÑÆü¥³¥á¥ó¥È¤ÎÁÞÆþ
      **** PERFORM  VARYING      IDX    FROM  1   BY   1
      ****          UNTIL       (IDX    >     31)      OR
      ****                      (TB-SANTEI-DAY(IDX)  =  ZERO)
      ****     ADD     1                    TO  IDX-RECE45
      ****     MOVE    SPACE                TO  COM-RECE45-REC
      ****     INITIALIZE                       COM-RECE45-REC
      ****     EVALUATE   FLG-COMMENT
      ****        WHEN    1
      ****          MOVE    CONS-SHUJUTU-COMMENT TO  COM-SRYCD(1)
      ****          MOVE    ZERO                 TO  COM-SRYSURYO(1)
      ****          MOVE    6                    TO  COM-YUKOKETA(1)
      ****          MOVE    "¼ê½Ñ¡¡¡¡¡¡Æü"       TO  COM-NAME(1)
      ****          MOVE    TB-SANTEI-DAY(IDX)   TO  DAY-IDX
      ****          MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(7:4)
      ****          MOVE    "1"                  TO  COM-SIKFLG(1)
      ****          MOVE    COM-SRYACTINF(1)     TO  WRK-SRYACTINF
      ****                                           (IDX-RECE45)
      ****          MOVE    COM-NAMEINF(1)       TO  WRK-NAMEINF
      ****                                           (IDX-RECE45)
      ****          MOVE    COM-SIKFLGINF(1)     TO  WRK-SIKFLGINF
      ****                                           (IDX-RECE45)
      ****        WHEN    2
      ****          MOVE    "810000001"          TO  COM-SRYCD(1)
      ****          MOVE    ZERO                 TO  COM-SRYSURYO(1)
      ****          MOVE    6                    TO  COM-YUKOKETA(1)
      ****          MOVE    "¼Â»Ü¡¡¡¡¡¡Æü"       TO  COM-NAME(1)
      ****          MOVE    TB-SANTEI-DAY(IDX)   TO  DAY-IDX
      ****          MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(7:4)
      ****          MOVE    "1"                  TO  COM-SIKFLG(1)
      ****          MOVE    COM-SRYACTINF(1)     TO  WRK-SRYACTINF
      ****                                           (IDX-RECE45)
      ****          MOVE    COM-NAMEINF(1)       TO  WRK-NAMEINF
      ****                                           (IDX-RECE45)
      ****          MOVE    COM-SIKFLGINF(1)     TO  WRK-SIKFLGINF
      ****                                           (IDX-RECE45)
      ****     END-EVALUATE
      **** END-PERFORM
      *
           MOVE    SPACE               TO  COM-RECE45-REC
           INITIALIZE                      COM-RECE45-REC
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX                >   50    )
                         OR      ( WK-FREE-NAME2(IDX) =   SPACE )
                ADD    1                  TO  IDX-RECE45
                MOVE   "810000001"        TO  COM-SRYCD(1)
                MOVE   ZERO               TO  COM-SRYSURYO(1)
                MOVE    "1"               TO  COM-SIKFLG(1)
                MOVE   COM-SRYACTINF(1)   TO  WRK-SRYACTINF(IDX-RECE45)
                MOVE   WRK-FREEINF2(IDX)  TO  WRK-NAMEINF(IDX-RECE45)
                MOVE   COM-SIKFLGINF(1)   TO  WRK-SIKFLGINF(IDX-RECE45)
           END-PERFORM 
      *
           PERFORM
             UNTIL  ( FLG-RECE45           =   1                   )
             OR     ( RECE44-HOSPID    NOT =   RECE45-HOSPID       )
             OR     ( RECE44-SRYYM     NOT =   RECE45-SRYYM        )
             OR     ( RECE44-NYUGAIKBN NOT =   RECE45-NYUGAIKBN    )
             OR     ( RECE44-PTID      NOT =   RECE45-PTID         )
             OR     ( RECE44-RECEKA    NOT =   RECE45-RECEKA       )
             OR     ( RECE44-HKNID     NOT =   RECE45-HKNID        )
             OR     ( RECE44-TEKSTYMD  NOT =   RECE45-TEKSTYMD     )
             OR     ( RECE44-ZAINUM    NOT =   RECE45-ZAINUM       )
      *
             PERFORM   VARYING   IDX   FROM    1   BY  1
                       UNTIL   ( IDX               >   5     )
                       OR      ( RECE45-SRYCD(IDX) =   SPACE )
                  ADD    1             TO      IDX-RECE45
                  MOVE   RECE45-SRYACTINF(IDX) TO
                                           WRK-SRYACTINF(IDX-RECE45)
                  MOVE   RECE45-NAMEINF(IDX)   TO
                                           WRK-NAMEINF(IDX-RECE45)
                  MOVE   RECE45-SIKFLGINF(IDX)   TO
                                           WRK-SIKFLGINF(IDX-RECE45)     
                  MOVE   RECE45-DATAKBNINF(IDX) TO
                                           WRK-DATAKBNINF(IDX-RECE45)
             END-PERFORM 
      *
             PERFORM 990-RECE45-NEXT-SEC
      *
           END-PERFORM
      *
      *    ¼ê½ÑÆü¥³¥á¥ó¥È¤ò´Þ¤ó¤ÀÆâÍÆ¤ÇÃæ´Ö¥Õ¥¡¥¤¥ë¤ÎºÆºîÀ®
           MOVE       ZERO             TO      FLG-WRKRECE45
           MOVE       ZERO             TO      IDX
           MOVE       ZERO             TO      IDX-RECE45
           MOVE       ZERO             TO      WRK-RENNUM
           MOVE       ZERO             TO      WRK-CNT-MEISAI
           PERFORM    UNTIL     FLG-WRKRECE45  =    1
      *
                  INITIALIZE                        RECE451-REC
                  MOVE    WRK-RECE45-KEY       TO   RECE451-KEY
                  ADD     1                    TO   WRK-RENNUM
                  MOVE    WRK-RENNUM           TO   RECE451-RENNUM
                  MOVE    WRK-RECE45-PTNUM     TO   RECE451-PTNUM
                  MOVE    WRK-RECE45-SRYKA     TO   RECE451-SRYKA
                  MOVE    WRK-RECE45-SRYKBN    TO   RECE451-SRYKBN
                  MOVE    WRK-RECE45-SRYSYUKBN TO   RECE451-SRYSYUKBN
                  MOVE    WRK-RECE45-JIHIMONEY TO   RECE451-JIHIMONEY
                  PERFORM  VARYING   IDX   FROM   1   BY   1
                           UNTIL   (IDX       >    5)   OR
                                   (FLG-WRKRECE45   =   1)
                     ADD         1             TO    IDX-RECE45
                     IF  WK-RECE45-SRYCD(IDX-RECE45) = SPACE
                         MOVE    1             TO    FLG-WRKRECE45
                     ELSE
                         MOVE  WRK-SRYACTINF(IDX-RECE45)
                                          TO   RECE451-SRYACTINF(IDX)  
                         MOVE  WRK-NAMEINF(IDX-RECE45)
                                          TO   RECE451-NAMEINF(IDX)
                         MOVE  WRK-SIKFLGINF(IDX-RECE45)
                                          TO   RECE451-SIKFLGINF(IDX)
                         MOVE  WRK-DATAKBNINF(IDX-RECE45)
                                          TO   RECE451-DATAKBNINF(IDX)
      *
                         IF    WRK-SIKFLGINF(IDX-RECE45)  =  "1"
                              ADD    1    TO   WRK-CNT-MEISAI
                         END-IF    
      *
                     END-IF  
                  END-PERFORM
                  WRITE   RECE451-REC
                  ADD     1                    TO  CNT-RECE45
           END-PERFORM     
      *
           MOVE    RECE44-REC        TO      RECE441-REC
           MOVE    WRK-CNT-MEISAI    TO      RECE441-MEISAISU
           WRITE   RECE441-REC
           ADD     1                 TO      CNT-RECE44
      *
           .
       2001-SHUJUTSU-ETC-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼ê½ÑÆüÅù¤Î¥³¥á¥ó¥ÈÊÔ½¸£²
      *****************************************************************
       2001-SHUJUTSU-ETC2-COMMENT-SEC          SECTION.
      *
           PERFORM   2001-SANTEI-DAY-SEC
      *
           MOVE       ZERO       TO   IDZ                               
           INITIALIZE            WRK-FREE-AREA2                         
      *
           PERFORM  2002-FREE-COMMENT2-SEC                              
      *
      *    ¢¨ÌÀºÙ¤¬£µ°Ê¾å¤Î¾ì¹ç
           INITIALIZE                      RECE45-REC
           MOVE    RECE44-HOSPID       TO  RECE45-HOSPID
           MOVE    RECE44-SRYYM        TO  RECE45-SRYYM
           MOVE    RECE44-NYUGAIKBN    TO  RECE45-NYUGAIKBN
           MOVE    RECE44-PTID         TO  RECE45-PTID
           MOVE    RECE44-RECEKA       TO  RECE45-RECEKA
           MOVE    RECE44-HKNID        TO  RECE45-HKNID
           MOVE    RECE44-TEKSTYMD     TO  RECE45-TEKSTYMD
           MOVE    RECE44-ZAINUM       TO  RECE45-ZAINUM
           START   RECE45-FILE
                 KEY IS    >=   RECE45-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE45
                 NOT INVALID
                     PERFORM 990-RECE45-NEXT-SEC
                     MOVE    RECE45-REC  TO  WRK-RECE45-REC
           END-START
      *
      *    £Ò£Å£Ã£Å£°£µ¥Õ¥¡¥¤¥ë¤ÎÆâÍÆ¤ò¥Æ¡¼¥Ö¥ë¤ËÂàÈò
           MOVE    ZERO                 TO  IDX-RECE45
           MOVE    SPACE                TO  WRK-SRYACTINF-AREA
           INITIALIZE                       WRK-SRYACTINF-AREA
           MOVE    SPACE                TO  WRK-NAMEINF-AREA
           INITIALIZE                       WRK-NAMEINF-AREA
           MOVE    SPACE                TO  WRK-SIKFLGINF-AREA
           INITIALIZE                       WRK-SIKFLGINF-AREA
           MOVE    SPACE                TO  WRK-DATAKBNINF-AREA
           INITIALIZE                       WRK-DATAKBNINF-AREA
      *
           MOVE    RECE44-MEISAISU      TO  MAX-MEISAISU
      *
      *    ¼ê½ÑÆü¥³¥á¥ó¥È¤ÎÁÞÆþ
      **** PERFORM  VARYING      IDX    FROM  1   BY   1
      ****          UNTIL       (IDX    >     31)      OR
      ****                      (TB-SANTEI-DAY(IDX)  =  ZERO)
      ****     ADD     1                    TO  IDX-RECE45
      ****     MOVE    SPACE                TO  COM-RECE45-REC
      ****     INITIALIZE                       COM-RECE45-REC
      ****     EVALUATE   FLG-COMMENT
      ****        WHEN    1
      ****          MOVE    CONS-SHUJUTU-COMMENT TO  COM-SRYCD(1)
      ****          MOVE    ZERO                 TO  COM-SRYSURYO(1)
      ****          MOVE    6                    TO  COM-YUKOKETA(1)
      ****          MOVE    "¼ê½Ñ¡¡¡¡¡¡Æü"       TO  COM-NAME(1)
      ****          MOVE    TB-SANTEI-DAY(IDX)   TO  DAY-IDX
      ****          MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(7:4)
      ****          MOVE    "1"                  TO  COM-SIKFLG(1)
      ****          MOVE    COM-SRYACTINF(1)     TO  WRK-SRYACTINF
      ****                                           (IDX-RECE45)
      ****          MOVE    COM-NAMEINF(1)       TO  WRK-NAMEINF
      ****                                           (IDX-RECE45)
      ****          MOVE    COM-SIKFLGINF(1)     TO  WRK-SIKFLGINF
      ****                                           (IDX-RECE45)
      ****        WHEN    2
      ****          MOVE    "810000001"          TO  COM-SRYCD(1)
      ****          MOVE    ZERO                 TO  COM-SRYSURYO(1)
      ****          MOVE    6                    TO  COM-YUKOKETA(1)
      ****          MOVE    "¼Â»Ü¡¡¡¡¡¡Æü"       TO  COM-NAME(1)
      ****          MOVE    TB-SANTEI-DAY(IDX)   TO  DAY-IDX
      ****          MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(7:4)
      ****          MOVE    "1"                  TO  COM-SIKFLG(1)
      ****          MOVE    COM-SRYACTINF(1)     TO  WRK-SRYACTINF
      ****                                           (IDX-RECE45)
      ****          MOVE    COM-NAMEINF(1)       TO  WRK-NAMEINF
      ****                                           (IDX-RECE45)
      ****          MOVE    COM-SIKFLGINF(1)     TO  WRK-SIKFLGINF
      ****                                           (IDX-RECE45)
      ****     END-EVALUATE
      **** END-PERFORM
      *
           MOVE    SPACE               TO  COM-RECE45-REC
           INITIALIZE                      COM-RECE45-REC
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX                >   50    )
                         OR      ( WK-FREE-NAME2(IDX) =   SPACE )
                COMPUTE  MAX-MEISAISU        =   MAX-MEISAISU  +  1
                MOVE   "810000001"        TO  COM-SRYCD(1)
                MOVE   ZERO               TO  COM-SRYSURYO(1)
                MOVE    "1"               TO  COM-SIKFLG(1)
                MOVE   COM-SRYACTINF(1)   TO  WRK-SRYACTINF
                                                         (MAX-MEISAISU)
                MOVE   WRK-FREEINF2(IDX)  TO  WRK-NAMEINF(MAX-MEISAISU)
                MOVE   COM-SIKFLGINF(1)   TO  WRK-SIKFLGINF
                                                         (MAX-MEISAISU)
           END-PERFORM 
      *
           PERFORM
             UNTIL  ( FLG-RECE45           =   1                   )
             OR     ( RECE44-HOSPID    NOT =   RECE45-HOSPID       )
             OR     ( RECE44-SRYYM     NOT =   RECE45-SRYYM        )
             OR     ( RECE44-NYUGAIKBN NOT =   RECE45-NYUGAIKBN    )
             OR     ( RECE44-PTID      NOT =   RECE45-PTID         )
             OR     ( RECE44-RECEKA    NOT =   RECE45-RECEKA       )
             OR     ( RECE44-HKNID     NOT =   RECE45-HKNID        )
             OR     ( RECE44-TEKSTYMD  NOT =   RECE45-TEKSTYMD     )
             OR     ( RECE44-ZAINUM    NOT =   RECE45-ZAINUM       )
      *
             PERFORM   VARYING   IDX   FROM    1   BY  1
                       UNTIL   ( IDX               >   5     )
                       OR      ( RECE45-SRYCD(IDX) =   SPACE )
                  ADD    1             TO      IDX-RECE45
                  MOVE   RECE45-SRYACTINF(IDX) TO
                                           WRK-SRYACTINF(IDX-RECE45)
                  MOVE   RECE45-NAMEINF(IDX)   TO
                                           WRK-NAMEINF(IDX-RECE45)
                  MOVE   RECE45-SIKFLGINF(IDX)   TO
                                           WRK-SIKFLGINF(IDX-RECE45)     
                  MOVE   RECE45-DATAKBNINF(IDX) TO
                                           WRK-DATAKBNINF(IDX-RECE45)
             END-PERFORM 
      *
             PERFORM 990-RECE45-NEXT-SEC
      *
           END-PERFORM
      *
      *    ¼ê½ÑÆü¥³¥á¥ó¥È¤ò´Þ¤ó¤ÀÆâÍÆ¤ÇÃæ´Ö¥Õ¥¡¥¤¥ë¤ÎºÆºîÀ®
           MOVE       ZERO             TO      FLG-WRKRECE45
           MOVE       ZERO             TO      IDX
           MOVE       ZERO             TO      IDX-RECE45
           MOVE       ZERO             TO      WRK-RENNUM
           MOVE       ZERO             TO      WRK-CNT-MEISAI
           PERFORM    UNTIL     FLG-WRKRECE45  =    1
      *
                  INITIALIZE                        RECE451-REC
                  MOVE    WRK-RECE45-KEY       TO   RECE451-KEY
                  ADD     1                    TO   WRK-RENNUM
                  MOVE    WRK-RENNUM           TO   RECE451-RENNUM
                  MOVE    WRK-RECE45-PTNUM     TO   RECE451-PTNUM
                  MOVE    WRK-RECE45-SRYKA     TO   RECE451-SRYKA
                  MOVE    WRK-RECE45-SRYKBN    TO   RECE451-SRYKBN
                  MOVE    WRK-RECE45-SRYSYUKBN TO   RECE451-SRYSYUKBN
                  MOVE    WRK-RECE45-JIHIMONEY TO   RECE451-JIHIMONEY
                  PERFORM  VARYING   IDX   FROM   1   BY   1
                           UNTIL   (IDX       >    5)   OR
                                   (FLG-WRKRECE45   =   1)
                     ADD         1             TO    IDX-RECE45
                     IF  WK-RECE45-SRYCD(IDX-RECE45) = SPACE
                         MOVE    1             TO    FLG-WRKRECE45
                     ELSE
                         MOVE  WRK-SRYACTINF(IDX-RECE45)
                                          TO   RECE451-SRYACTINF(IDX)  
                         MOVE  WRK-NAMEINF(IDX-RECE45)
                                          TO   RECE451-NAMEINF(IDX)
                         MOVE  WRK-SIKFLGINF(IDX-RECE45)
                                          TO   RECE451-SIKFLGINF(IDX)
                         MOVE  WRK-DATAKBNINF(IDX-RECE45)
                                          TO   RECE451-DATAKBNINF(IDX)
      *
                         IF    WRK-SIKFLGINF(IDX-RECE45)  =  "1"
                              ADD    1    TO   WRK-CNT-MEISAI
                         END-IF    
      *
                     END-IF  
                  END-PERFORM
                  WRITE   RECE451-REC
                  ADD     1                    TO  CNT-RECE45
           END-PERFORM     
      *
           MOVE    RECE44-REC        TO      RECE441-REC
           MOVE    WRK-CNT-MEISAI    TO      RECE441-MEISAISU
           WRITE   RECE441-REC
           ADD     1                 TO      CNT-RECE44
      *
           .
       2001-SHUJUTSU-ETC2-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    »»ÄêÆü¤Î³ÎÄê
      *****************************************************************
       2001-SANTEI-DAY-SEC          SECTION.
      *
           INITIALIZE                TBL-SANTEI-DAY
      *
           MOVE    ZERO          TO  DAY-IDX
           IF      RECE41-HKNKBN   NOT  =   "3"
              PERFORM    VARYING    IDX  FROM   1   BY   1
                         UNTIL     (IDX      >   31)  OR
                                   (DAY-IDX  >   31)
                   IF    RECE44-KAISU(1 IDX)  NOT =  ZERO
                       ADD   1     TO   DAY-IDX
                       MOVE  IDX   TO  TB-SANTEI-DAY(DAY-IDX)
                   END-IF
              END-PERFORM
           ELSE
              MOVE   RECE41-TEKSTYMD(7:2)  TO  WRK-DAY
              IF   RECE44-KAISU(1 WRK-DAY)  NOT = ZERO
                    MOVE  WRK-DAY  TO  TB-SANTEI-DAY(1)
              END-IF
           END-IF
      *
           .
       2001-SANTEI-DAY-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼ê½ÑÆüÅù¤ÎÆüÉÕ¤ÎÊÔ½¸
      *****************************************************************
       2002-FREE-COMMENT2-SEC          SECTION.                         
      *
           ADD      1          TO    IDZ
      *
           EVALUATE   FLG-COMMENT
              WHEN    1
                 MOVE     4          TO    WRK-KETA
                                           WRK-KETA-TAIHI
                 MOVE     2          TO    WRK-KETA2
                 MOVE    WRK-KETA2   TO    WK-FREE-YUKOKETA2(IDZ)
                 MOVE    "¼ê½Ñ"  TO    WK-FREE-NAME2(IDZ)(1:WRK-KETA)
              WHEN    2
                 MOVE     4          TO    WRK-KETA
                                           WRK-KETA-TAIHI
                 MOVE     2          TO    WRK-KETA2
                 MOVE    WRK-KETA2   TO    WK-FREE-YUKOKETA2(IDZ)
                 MOVE    "¼Â»Ü"  TO    WK-FREE-NAME2(IDZ)(1:WRK-KETA)
              WHEN    4
                 MOVE     4          TO    WRK-KETA
                                           WRK-KETA-TAIHI
                 MOVE     2          TO    WRK-KETA2
                 MOVE    WRK-KETA2   TO    WK-FREE-YUKOKETA2(IDZ)
                 MOVE    "¸òÉÕ"  TO    WK-FREE-NAME2(IDZ)(1:WRK-KETA)
           END-EVALUATE
      *
           MOVE      ZERO          TO  FLG-FIRST
      *
           PERFORM   VARYING   IDX    FROM   1   BY   1
                          UNTIL   (IDX                 >    31)
                           OR     (TB-SANTEI-DAY(IDX)  =  ZERO)
      *
                 IF  FLG-FIRST  =  ZERO
                    IF  TB-SANTEI-DAY(IDX)     <  10 
      *
                       MOVE   TB-SANTEI-DAY(IDX)  TO  IDY
      *
                       ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                       MOVE    "¡¡"
                           TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                       ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                       MOVE    TBL-DAY(IDY)(3:2)     
                           TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                       ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                       MOVE    "Æü"
                           TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                    ELSE
      *
                       MOVE   TB-SANTEI-DAY(IDX)  TO  IDY
      *
                       ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                       MOVE    "¡¡"
                           TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                       ADD   2  TO  WK-FREE-YUKOKETA2(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                       MOVE    TBL-DAY(IDY)     
                           TO  WK-FREE-NAME2(IDZ)(WRK-KETA:4)
      *
                       ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                       MOVE    "Æü"
                           TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                    END-IF
                    MOVE      1              TO  FLG-FIRST
                 ELSE
                    IF  TB-SANTEI-DAY(IDX)     <  10 
      *
                       MOVE   TB-SANTEI-DAY(IDX)  TO  IDY
      *
                       IF    WK-FREE-YUKOKETA2(IDZ)  =  25
                          PERFORM  2002-FREE-COMMENT2-KAIGYO-SEC
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    "¡¢"
                                    TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                       ELSE
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "¡¢"
                                    TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                       END-IF
      *
                       IF    WK-FREE-YUKOKETA2(IDZ)  =  24 OR 25
                          PERFORM  2002-FREE-COMMENT2-KAIGYO-SEC
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    TBL-DAY(IDY)(3:2)     
                                    TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "Æü"
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2) 
                       ELSE
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    TBL-DAY(IDY)(3:2)     
                                    TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "Æü"
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2) 
                       END-IF
                    ELSE
      *
                       MOVE   TB-SANTEI-DAY(IDX)  TO  IDY
      *
                       IF    WK-FREE-YUKOKETA2(IDZ)  =  25
                          PERFORM  2002-FREE-COMMENT2-KAIGYO-SEC
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    "¡¢"
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                       ELSE
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "¡¢"
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                       END-IF
      *
                       IF    WK-FREE-YUKOKETA2(IDZ)  =  23 OR 24 OR 25
                          PERFORM  2002-FREE-COMMENT2-KAIGYO-SEC
                          ADD   2  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    TBL-DAY(IDY)     
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:4)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                          MOVE    "Æü"
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                       ELSE
                          ADD   2  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    TBL-DAY(IDY)     
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:4)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                          MOVE    "Æü"
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                       END-IF
                    END-IF
                 END-IF
      *
           END-PERFORM
           .
       2002-FREE-COMMENT2-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼ê½ÑÆüÅù¤ÎÆüÉÕ¤ÎÊÔ½¸¡Ê²þ¹Ô¡Ë
      *****************************************************************
       2002-FREE-COMMENT2-KAIGYO-SEC          SECTION.                  
      *
           ADD      1              TO  IDZ
      *
           MOVE    WRK-KETA-TAIHI  TO  WRK-KETA
           MOVE    WRK-KETA2       TO  WK-FREE-YUKOKETA2(IDZ)
           MOVE    ALL "¡¡"        TO  WK-FREE-NAME2(IDZ)(1:WRK-KETA)
      *
           .
       2002-FREE-COMMENT2-KAIGYO-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥ê¥Ï¥Ó¥ê¤Î¥³¥á¥ó¥ÈÊÔ½¸
      *****************************************************************
       2001-RIHA-COMMENT-SEC          SECTION.
      *
           MOVE    RECE44-REC        TO      RECE441-REC
           ADD     1                 TO      RECE441-MEISAISU
           WRITE   RECE441-REC
           ADD     1                 TO      CNT-RECE44
      *
      *      ¢¨ÌÀºÙ¤¬£µ°Ê¾å¤Î¾ì¹ç
             INITIALIZE                      RECE45-REC
             MOVE    RECE44-HOSPID       TO  RECE45-HOSPID
             MOVE    RECE44-SRYYM        TO  RECE45-SRYYM
             MOVE    RECE44-NYUGAIKBN    TO  RECE45-NYUGAIKBN
             MOVE    RECE44-PTID         TO  RECE45-PTID
             MOVE    RECE44-RECEKA       TO  RECE45-RECEKA
             MOVE    RECE44-HKNID        TO  RECE45-HKNID
             MOVE    RECE44-TEKSTYMD     TO  RECE45-TEKSTYMD
             MOVE    RECE44-ZAINUM       TO  RECE45-ZAINUM
             START   RECE45-FILE
                 KEY IS    >=   RECE45-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE45
                 NOT INVALID
                     PERFORM 990-RECE45-NEXT-SEC
                     MOVE    RECE45-REC  TO  WRK-RECE45-REC
             END-START
      *
      *      £Ò£Å£Ã£Å£°£µ¥Õ¥¡¥¤¥ë¤ÎÆâÍÆ¤ò¥Æ¡¼¥Ö¥ë¤ËÂàÈò
             MOVE    ZERO                 TO  IDX-RECE45
             MOVE    SPACE                TO  WRK-SRYACTINF-AREA
             INITIALIZE                       WRK-SRYACTINF-AREA
             MOVE    SPACE                TO  WRK-NAMEINF-AREA
             INITIALIZE                       WRK-NAMEINF-AREA
             MOVE    SPACE                TO  WRK-SIKFLGINF-AREA
             INITIALIZE                       WRK-SIKFLGINF-AREA
             MOVE    SPACE                TO  WRK-DATAKBNINF-AREA
             INITIALIZE                       WRK-DATAKBNINF-AREA
      *      ¥ê¥Ï¥Ó¥ê¥³¥á¥ó¥È¤ÎÁÞÆþ
      *      ADD     1                    TO  IDX-RECE45
             MOVE    SPACE                TO  COM-RECE45-REC
             INITIALIZE                       COM-RECE45-REC
             MOVE    "810000001"          TO  COM-SRYCD(1)
             MOVE    ZERO                 TO  COM-SRYSURYO(1)
             MOVE    7                    TO  COM-YUKOKETA(1)
             MOVE    "¼Â»ÜÆü¿ô¡¡¡¡Æü"     TO  COM-NAME(1)
             MOVE    "1"                  TO  COM-SIKFLG(1) 
             MOVE    ZERO                 TO  CNT-RIHA
             EVALUATE   RECE44-ZAINUM
                 WHEN   WRK-RIGA1-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA1-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA2-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA2-SHU(IDX) NOT = SPACE
                                ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA3-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA3-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA4-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA4-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA1-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA1-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA2-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA2-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA3-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA3-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA4-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA4-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO1-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO1-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO2-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO2-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO1-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO1-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO2-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO2-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO1-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO1-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO2-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO2-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO1-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO1-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO2-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO2-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   OTHER
                        CONTINUE
             END-EVALUATE
             IF      CNT-RIHA             NOT =    ZERO
               MOVE    CNT-RIHA             TO  DAY-IDX
               MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(9:4)
               COMPUTE  MAX-MEISAISU        =   RECE44-MEISAISU  +  1
               MOVE    COM-SRYACTINF(1)     TO  WRK-SRYACTINF
                                                     (MAX-MEISAISU)
               MOVE    COM-NAMEINF(1)       TO  WRK-NAMEINF
                                                     (MAX-MEISAISU)
               MOVE    COM-SIKFLGINF(1)     TO  WRK-SIKFLGINF
                                                     (MAX-MEISAISU)
             END-IF
      *
             PERFORM
               UNTIL  ( FLG-RECE45           =   1                   )
               OR     ( RECE44-HOSPID    NOT =   RECE45-HOSPID       )
               OR     ( RECE44-SRYYM     NOT =   RECE45-SRYYM        )
               OR     ( RECE44-NYUGAIKBN NOT =   RECE45-NYUGAIKBN    )
               OR     ( RECE44-PTID      NOT =   RECE45-PTID         )
               OR     ( RECE44-RECEKA    NOT =   RECE45-RECEKA       )
               OR     ( RECE44-HKNID     NOT =   RECE45-HKNID        )
               OR     ( RECE44-TEKSTYMD  NOT =   RECE45-TEKSTYMD     )
               OR     ( RECE44-ZAINUM    NOT =   RECE45-ZAINUM       )
      *
               PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX               >   5     )
                         OR      ( RECE45-SRYCD(IDX) =   SPACE )
                    ADD    1             TO      IDX-RECE45
                    MOVE   RECE45-SRYACTINF(IDX) TO
                                             WRK-SRYACTINF(IDX-RECE45)
                    MOVE   RECE45-NAMEINF(IDX)   TO
                                             WRK-NAMEINF(IDX-RECE45)
                    MOVE   RECE45-SIKFLGINF(IDX)   TO
                                             WRK-SIKFLGINF(IDX-RECE45)     
                    MOVE   RECE45-DATAKBNINF(IDX) TO
                                             WRK-DATAKBNINF(IDX-RECE45)
               END-PERFORM 
      *
               PERFORM 990-RECE45-NEXT-SEC
      *
             END-PERFORM
      *
      *      ¥ê¥Ï¥Ó¥ê¥³¥á¥ó¥È¤ò´Þ¤ó¤ÀÆâÍÆ¤ÇÃæ´Ö¥Õ¥¡¥¤¥ë¤ÎºÆºîÀ®
             MOVE       ZERO             TO      FLG-WRKRECE45
             MOVE       ZERO             TO      IDX
             MOVE       ZERO             TO      IDX-RECE45
             MOVE       ZERO             TO      WRK-RENNUM
             PERFORM    UNTIL     FLG-WRKRECE45  =    1
                    INITIALIZE                        RECE451-REC
                    MOVE    WRK-RECE45-KEY       TO   RECE451-KEY
                    ADD     1                    TO   WRK-RENNUM
                    MOVE    WRK-RENNUM           TO   RECE451-RENNUM
                    MOVE    WRK-RECE45-PTNUM     TO   RECE451-PTNUM
                    MOVE    WRK-RECE45-SRYKA     TO   RECE451-SRYKA
                    MOVE    WRK-RECE45-SRYKBN    TO   RECE451-SRYKBN
                    MOVE    WRK-RECE45-SRYSYUKBN TO   RECE451-SRYSYUKBN
                    MOVE    WRK-RECE45-JIHIMONEY TO   RECE451-JIHIMONEY
                    PERFORM  VARYING   IDX   FROM   1   BY   1
                             UNTIL   (IDX       >    5)   OR
                                     (FLG-WRKRECE45   =   1)
                       ADD         1             TO    IDX-RECE45
                       IF  WK-RECE45-SRYCD(IDX-RECE45) = SPACE
                           MOVE    1             TO    FLG-WRKRECE45
                       ELSE
                           MOVE  WRK-SRYACTINF(IDX-RECE45)
                                            TO   RECE451-SRYACTINF(IDX)  
                           MOVE  WRK-NAMEINF(IDX-RECE45)
                                            TO   RECE451-NAMEINF(IDX)
                           MOVE  WRK-SIKFLGINF(IDX-RECE45)
                                            TO   RECE451-SIKFLGINF(IDX)
                           MOVE  WRK-DATAKBNINF(IDX-RECE45)
                                            TO   RECE451-DATAKBNINF(IDX)
                       END-IF  
                    END-PERFORM
                    WRITE   RECE451-REC
                    ADD     1                    TO  CNT-RECE45
             END-PERFORM     
      *
           .
       2001-RIHA-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥ì¥»¥×¥È£°£µÅ¾Á÷½èÍý
      *****************************************************************
       2002-RECE45-TENSOU-SEC     SECTION.
      *
           INITIALIZE                      RECE45-REC
           MOVE    RECE44-HOSPID       TO  RECE45-HOSPID
           MOVE    RECE44-SRYYM        TO  RECE45-SRYYM
           MOVE    RECE44-NYUGAIKBN    TO  RECE45-NYUGAIKBN
           MOVE    RECE44-PTID         TO  RECE45-PTID
           MOVE    RECE44-RECEKA       TO  RECE45-RECEKA
           MOVE    RECE44-HKNID        TO  RECE45-HKNID
           MOVE    RECE44-TEKSTYMD     TO  RECE45-TEKSTYMD
           MOVE    RECE44-ZAINUM       TO  RECE45-ZAINUM
           START   RECE45-FILE
               KEY IS    >=   RECE45-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE45
               NOT INVALID
                   PERFORM 990-RECE45-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( FLG-RECE45           =   1                   )
               OR     ( RECE44-HOSPID    NOT =   RECE45-HOSPID       )
               OR     ( RECE44-SRYYM     NOT =   RECE45-SRYYM        )
               OR     ( RECE44-NYUGAIKBN NOT =   RECE45-NYUGAIKBN    )
               OR     ( RECE44-PTID      NOT =   RECE45-PTID         )
               OR     ( RECE44-RECEKA    NOT =   RECE45-RECEKA       )
               OR     ( RECE44-HKNID     NOT =   RECE45-HKNID        )
               OR     ( RECE44-TEKSTYMD  NOT =   RECE45-TEKSTYMD     )
               OR     ( RECE44-ZAINUM    NOT =   RECE45-ZAINUM       )
      *
      *
               MOVE          RECE45-REC       TO      RECE451-REC
               WRITE         RECE451-REC
               ADD     1                 TO  CNT-RECE45
      *
               PERFORM 990-RECE45-NEXT-SEC
      *
           END-PERFORM
      *
           .
       2002-RECE45-TENSOU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥¨¥é¡¼½ÐÎÏ½èÍý
      *****************************************************************
       500-ERR-HENSYU-SEC                SECTION.
      *
           OPEN    INPUT   RECEERR-FILE
           IF      STS-RECEERR         =   ZERO
               CLOSE   RECEERR-FILE
           ELSE
               OPEN    OUTPUT              RECEERR-FILE
      *
               MOVE    WRK-RECEERR         TO  RECEERR-REC
               WRITE   RECEERR-REC
               CLOSE   RECEERR-FILE
      *         
      *        ¥¸¥ç¥Ö´ÉÍý³«»Ï½èÍý
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA  
                                       JOBKANRI-REC
           END-IF
      *                             
           MOVE    1                   TO  FLG-END
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ½ªÎ»¡¡¡¡½èÍý
      *****************************************************************
       300-END-SEC                 SECTION.
      *
      *    ¥Õ¥¡¥¤¥ë£Ã£Ì£Ï£Ó£Å½èÍý
           PERFORM 310-FILE-CLOSE-SEC
      *
      *    ¥¹¥Æ¥Ã¥×´ÉÍý½ªÎ»½èÍý
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           DISPLAY "RECE41  IN  " CNT-RECE41  
           DISPLAY "RECE44  CNT " CNT-RECE44  
           DISPLAY "RECE45  CNT " CNT-RECE45  
           DISPLAY "*** ORCR0430 END ***"
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥Õ¥¡¥¤¥ë£Ã£Ì£Ï£Ó£Å½èÍý
      *****************************************************************
       310-FILE-CLOSE-SEC              SECTION.
      *
           CLOSE                       RECE41-FILE
      *
           CLOSE                       RECE44-FILE
      *
           CLOSE                       RECE45-FILE
      *
           CLOSE                       RECE441-FILE     
           CLOSE                       RECE451-FILE     
      *
           .
       310-FILE-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥ì¥»¥×¥È£°£²¥Ç¡¼¥¿½ç¸¡º÷½èÍý
      *****************************************************************
       990-RECE41-READ-SEC           SECTION.
      *
           READ    RECE41-FILE         NEXT
               AT  END
                   MOVE    1           TO  FLG-END
               NOT AT  END
                   ADD     1           TO  CNT-RECE41
                   ADD     1           TO  CNT-IN-COMMIT
                   MOVE    ZERO        TO  FLG-END
           END-READ
      *
           .
       990-RECE41-READ-EXT.
           EXIT.
      *
      ****************************************************************
      *    ¥ì¥»¥×¥È£°£´¥Ç¡¼¥¿ÆÉ¤ß
      ****************************************************************
       990-RECE44-NEXT-SEC           SECTION.
      *
           READ    RECE44-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE44
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE44
           END-READ
      *
           .
       990-RECE44-NEXT-EXT.
           EXIT.
      *
      ****************************************************************
      *    ¥ì¥»¥×¥È£°£µ¥Ç¡¼¥¿ÆÉ¤ß
      ****************************************************************
       990-RECE45-NEXT-SEC           SECTION.
      *
           READ    RECE45-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE45
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE45
           END-READ
      *
           .
       990-RECE45-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    »»ÄêÎò¥Þ¥¹¥¿ÆÉ¤ß¹þ¤ß
      *****************************************************************
       SANTEI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SANTEI-REC
               MOVE    ZERO                TO  FLG-SANTEI
           ELSE
               INITIALIZE                      SANTEI-REC
               MOVE    1                   TO  FLG-SANTEI
           END-IF
      *
           .
       SANTEI-READ-EXT.
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
               MOVE    MCPDATA-REC     TO  SYS-1005-REC
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               INITIALIZE                  SYS-1005-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼õ¿ÇÍúÎòÆÉ¹þ
      *****************************************************************
       JYURRK-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  JYURRK-REC
               MOVE    ZERO            TO  FLG-JYURRK
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           .
       JYURRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥«¡¼¥½¥ë¥¯¥í¡¼¥º½èÍý
      *****************************************************************
       CSR-CLOSE-SEC            SECTION.
      *
           INITIALIZE                  MCPAREA
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       CSR-CLOSE-EXT.
           EXIT.
      *      
      *****************************************************************
      *    £Ä£Â¡¡¥ª¡¼¥×¥ó½èÍý
      *****************************************************************
       120-DBOPEN-SEC                SECTION.
      *
           MOVE    "DBOPEN"            TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ä£Â¡¡¥¯¥í¡¼¥º½èÍý
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       900-DBCLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ä£Â¡¡£Ã£Ï£Í£Í£É£Ô½èÍý
      *****************************************************************
       900-DBCOMMIT-SEC            SECTION.
      *
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "MCPSUB"          USING
                                        MCPAREA
                                        MCPDATA-REC.
      *
           .
       900-DBCOMMIT-EXT.
           EXIT.
      *      
      *****************************************************************
      *    £Ä£Â¡¡£Ó£Ô£Á£Ò£Ô½èÍý
      *****************************************************************
       900-DBSTART-SEC                SECTION.
      *
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       900-DBSTART-EXT.
           EXIT.
