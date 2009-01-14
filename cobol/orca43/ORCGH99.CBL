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
       PROGRAM-ID.             ORCGH99.
      *****************************************************************
      *  ¥·¥¹¥Æ¥àÌ¾        : £Ï£Ò£Ã£Á
      *  ¥µ¥Ö¥·¥¹¥Æ¥àÌ¾    : ÀÁµá´ÉÍý
      *  ¥³¥ó¥Ý¡¼¥Í¥ó¥ÈÌ¾  : ÀÁµá´ÉÍý¡Ý¼ê½ñ¤­ÄûÀµ¡Ê£È£¹£¹¡Ë
      *  ´ÉÍý¼Ô            : 
      *  ºîÀ®ÆüÉÕ    ºî¶È¼Ô        µ­½Ò
      *  00/12/01    MCC¡ÝÆ£¸¶¡¡   ¿·µ¬ºîÀ®
      *****************************************************************
      *  ¥×¥í¥°¥é¥à½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      *  01.01.01    MCC-Æ£¸¶     01/09/21  JOIN¤Î½¤Àµ      
      *  01.01.02    MCC-Æ£¸¶     01/10/02  Ï¢ÈÖ¤ÎÄÉ²Ã      
      *  01.01.03    MCC-Æ£¸¶     01/10/26  ÊÝ¸±¼ïÊÌ¤Îµ­¹æ½¤Àµ
      *
      *  £²£°£°£²¡¥£±£°²þÀµÂÐ±þ 
      *  01.02.01    NACL-Æ£¸¶    02/10/10  ¥ì¥»¥×¥È¼ïÊÌ¤Î½ÐÎÏ¤Î½¤Àµ
      *  01.02.02    NACL-Æ£¸¶    02/12/10  ¥¨¥é¡¼¥á¥Ã¥»¡¼¥¸¤Î½¤Àµ
      *  01.02.03    NACL-Æ£¸¶    03/02/17  Êä½õ¶èÊ¬¤ÎÄÉ²Ã
      *  01.02.04    NACL-Æ£¸¶    03/05/28  Êä½õ¶èÊ¬¤ÎÈ½Äê¤Î½¤Àµ
      *  01.02.05    NACL-Æ£¸¶    04/01/26  ÇÓÂ¾À©¸æ½èÍýÄÉ²Ã
      *
      *  02.06.01    NACL-Æ£¸¶    05/09/29  Êä½õ¶èÊ¬¤«¤é¤ÎÊÔ½¸¤Î½¤Àµ
      *
      *  02.07.01    NACL-Æ£¸¶    05/08/20  ÆÃÊÌÎÅÍÜÈñÂÐ±þ
      *  02.07.02    NACL-Æ£¸¶    05/10/31  MONFUNCÂÐ±þ
      *
      *  02.08.01    NACL-Æ£¸¶    06/02/20  ¼ç²ÊÂÐ±þ
      *
      *  03.03.01    NACL-Æ£¸¶    06/09/27  £²£°£°£¶Ç¯£±£°·î²þÀµÂÐ±þ
      *
      *  03.05.01    NACL-Æ£¸¶    07/04/19  ¥°¥ë¡¼¥×¿ÇÎÅÂÐ±þ
      *
      *  04.01.01    NACL-Æ£¸¶    07/11/22  ¸ø³²¥ì¥»¥×¥ÈÂÐ±þ
      *
      *  04.02.01    NACL-Æ£¸¶    08/03/25  Ê¿À®£²£°Ç¯£´·î²þÀµÂÐ±þ
      *
      *  04.03.01    NACL-Æ£¸¶    08/05/07  ¸øÈñ£´¼ï¤Þ¤Ç¤ÎÊ»ÍÑ¤Îµ­Ï¿ÂÐ±þ
      *  04.03.02    NACL-Æ£¸¶    08/06/06  ¥ì¥»¥×¥È¼ïÊÌÌ¾¾Î¡¢ºîÀ®Æü¤ÎÄÉ²Ã
      *
      *  04.04.01    NACL-Æ£¸¶    09/12/10  ÊÖÌáÂÐ±þ
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    ¥¹¥ÑÎÎ°è
           COPY    "COMMON-SPA".
      *
      *    ÀÁµá´ÉÍý
           COPY    "H01COMMON-SPA".
      *
      *    ²èÌÌÍÑ£Ó£Ð£Á
           COPY    "H01SCR-SPA".
      *
      *    ÀßÄêºÑÊÖÌá¥Ç¡¼¥¿
           02  SPA-HENREI-B-REC.
           COPY    "CPHENREI-BODY.INC"
                                   REPLACING   //HENREI-B-//
                                   BY          //SPA-HENREI-B-//.
      *
      *    ÂÐ¾Ý°ìÍ÷ÍÑÊÖÌá¥Ç¡¼¥¿
           02  TBL-HENREI-B-REC    OCCURS  30.
           COPY    "CPHENREI-BODY.INC"
                                   REPLACING   //HENREI-B-//
                                   BY          //TBL-HENREI-B-//.
           02  TBL-HENREI-B-ERR    PIC 9(01)   OCCURS  30.
           02  TBL-HENREI-B-MAX    PIC 9(02).
      *
      *    ¹¹¿·ÂÐ¾ÝÊÖÌá¥Ç¡¼¥¿
           02  WRK-HENREI-B-REC.
           COPY    "CPHENREI-BODY.INC"
                                   REPLACING   //HENREI-B-//
                                   BY          //WRK-HENREI-B-//.
      *
           COPY    "ENUM-VALUE".
      *
      *    ¥Õ¥é¥°ÎÎ°è
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-SEIKYU          PIC 9(01).
      *
      *    ¥«¥¦¥ó¥ÈÎÎ°è
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    Åº»úÎÎ°è
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDX2                PIC 9(04).
      *
      *    °ì»þÎÎ°è
       01  WRK-AREA.
           03  WRK-Z9              PIC Z9.
           03  WRK-SELNO           PIC 9(02).
           03  WRK-RECESYUBETU     PIC X(44).
           03  WRK-YM              PIC X(07). 
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-SYURUINAME      PIC X(40).
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
      *
      *****************************************************************
      *    ¥Õ¥¡¥¤¥ë¥ì¥¤¥¢¥¦¥È
      *****************************************************************
      *
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1005.INC".
      *
           COPY    "CPSK2003.INC".
      *
           COPY    "CPRCF010.INC".
      *
      *****************************************************************
      *    ¥µ¥Ö¥×¥íÍÑ¡¡ÎÎ°è
      *****************************************************************
      *
      *   ÆüÉÕÊÑ´¹¥µ¥Ö
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *   ´µ¼ÔÈÖ¹æÊÑ´¹¥µ¥Ö
           COPY    "CPORCSPTID.INC".
      *
      *   ²èÌÌÆüÉÕÊÑ´¹¥µ¥Ö
          COPY    "CPORCSGDAY.INC".
      *
      *    £Ä£Â¸¡º÷
           COPY    "MCPDATA.INC".
      *
      *    ÇÓÂ¾À©¸æ¥µ¥Ö¥Ñ¥é¥á¥¿
           COPY    "CPORCSLOCK.INC".
      *
      *
      *****************************************************************
      *    Ï¢Íí¡¡ÎÎ°è
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "H01.INC".
           COPY    "H02.INC".
           COPY    "H99.INC".
           COPY    "HERR.INC".
           COPY    "HID1.INC".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *
      *****************************************************************
      *    ¼ç¡¡¡¡½èÍý
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-H01FREE
           MOVE    SPA-WORK        TO  SPA-H01KYOUTU
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    ²èÌÌÁ«°Ü
               WHEN     "PUTG"           ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    ÆþÎÏ
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    ²èÌÌÁ«°Ü¤¬¤Ê¤¤»þ¡¢²èÌÌÉ½¼¨¤Ø
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-H01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-H01FREE     TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    ½é´ü¡¡½èÍý
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
      *
      *    ¥¨¥é¡¼²èÌÌ¤è¤ê
           IF      SPA-MOTOPG          =   "HERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        ½é´ü²èÌÌ¥»¥Ã¥È
               PERFORM 300-SCREEN-SEC
      *        ²èÌÌÊÔ½¸
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "H99    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    ½é´ü²èÌÌ½èÍý
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           MOVE    4                   TO  SPA-H99GMN-CUR
      *
           PERFORM 41021-H99-HENSYU-SEC
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ²èÌÌÁ«°Ü½èÍý
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        Ìá¤ë
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *     ³ÎÄê
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 450-KAKUTEI-SEC
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    ²ñÏÃ¡¡½èÍý
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
               WHEN    "ACTIVATE"      ALSO    "SELNUM"
                   PERFORM 4104-SELNUM-CHK-SEC
               WHEN    ANY             ALSO    "RECELST"
                   PERFORM 4105-RECESEL-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥ì¥»¥×¥È¸¡º÷²èÌÌÊÔ½¸½èÍý
      *****************************************************************
       41021-H99-HENSYU-SEC         SECTION.
      *
      *    ÀÁµá´ÉÍý£Ä£Â¸¡º÷
           INITIALIZE                  RECE10-REC
           MOVE    SPA-HOSPNUM         TO  RECE10-HOSPNUM
           MOVE    SPA-H99NAI-PTID     TO  RECE10-PTID
           IF      SPA-H99GMN-SRYKA    =   SPACE
               MOVE    "%%"                TO  RECE10-RECEKA
           ELSE
               MOVE    SPA-H99GMN-SRYKA    TO  RECE10-RECEKA
           END-IF
           MOVE    SPA-H99NAI-SRYYM    TO  RECE10-SRYYM
           MOVE    RECE10-REC          TO  MCPDATA-REC
           MOVE    "tbl_seikyu"        TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
grpsys     PERFORM 900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_seikyu"        TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 900-SEIKYU-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SEIKYU
           END-IF
      *
           MOVE    ZERO                TO  IDX 
           PERFORM     UNTIL       FLG-SEIKYU     =   1
                       OR          IDX            =  10
               ADD     1                   TO  IDX
               MOVE    MCPDATA-REC     TO  RECE10-REC
               MOVE    RECE10-KEY      TO
                                   SPA-H99NAI-RECE10-KEY (IDX)
               MOVE    IDX             TO  WRK-Z9
               MOVE    WRK-Z9          TO
                                   SPA-H99GMN-TRENNUM    (IDX)
               IF      RECE10-NYUGAIKBN    =   "1"
                   MOVE    "Æþ  ±¡"    TO
                                   SPA-H99GMN-TNYUGAIKBN (IDX)
               ELSE    
                   MOVE    "Æþ±¡³°"    TO
                                   SPA-H99GMN-TNYUGAIKBN (IDX)
               END-IF
               IF      RECE10-RECEKA   =   ZERO
                   CONTINUE
               ELSE
                   INITIALIZE              SYS-1005-REC
                   MOVE    "1005"          TO  SYS-1005-KANRICD
                   MOVE    RECE10-RECEKA   TO  SYS-1005-KBNCD
                   MOVE    SPA-SYSYMD      TO  SYS-1005-STYUKYMD
                                               SYS-1005-EDYUKYMD
grpsys             MOVE    SPA-HOSPNUM     TO  SYS-1005-HOSPNUM
                   MOVE    SYS-1005-REC    TO  MCPDATA-REC
                   PERFORM 910-SYSKANRI-INV-SEC
                   IF      FLG-SYSKANRI    =   ZERO
                       MOVE    MCPDATA-REC     TO  SYS-1005-REC
                   ELSE
                       INITIALIZE              SYS-1005-REC 
                   END-IF
                   MOVE    SYS-1005-SRYKANAME  TO
                                       SPA-H99GMN-TSRYKA(IDX)
               END-IF
               EVALUATE    RECE10-TEISYUTUSAKI
                   WHEN    "1"
                       MOVE    "»ÙÊ§´ð¶â"      TO
                                           SPA-H99GMN-TTEISYUTUSAKI(IDX)
                   WHEN    "2"
                       MOVE    "¹ñÊÝÏ¢¹ç²ñ"    TO
                                           SPA-H99GMN-TTEISYUTUSAKI(IDX)
                   WHEN    "5"
                       MOVE    "¸ø³²"          TO
                                           SPA-H99GMN-TTEISYUTUSAKI(IDX)
                   WHEN    "6"
                       MOVE    "¹­°èÏ¢¹ç"      TO
                                           SPA-H99GMN-TTEISYUTUSAKI(IDX)
               END-EVALUATE
      *
               PERFORM 530-RECESYUBETU-HENSYU-SEC
               MOVE    WRK-RECESYUBETU  TO
                                   SPA-H99GMN-TRECESYUBETU (IDX)
      *
               EVALUATE    RECE10-TEISYUTUSAKI
                   WHEN    "1"
                   WHEN    "2"
                   WHEN    "6"
                       IF      RECE10-HKNJANUM     NOT =   "00000000"
                           MOVE    RECE10-HKNJANUM     TO
                                           SPA-H99GMN-THKNJANUM (IDX)
                       END-IF
               END-EVALUATE
      *
               EVALUATE    RECE10-HKNNUM
                   WHEN    "002"
                   WHEN    "031"  THRU  "034"
                       EVALUATE    RECE10-HOJOKBN-KEY
                           WHEN    "1"
                           WHEN    "A"
                           WHEN    "D"
                           WHEN    "G"
                               MOVE    "¿¦Ì³¾å"    TO
                                               SPA-H99GMN-THOJOKBN(IDX)
                           WHEN    "2"
                           WHEN    "B"
                           WHEN    "E"
                           WHEN    "H"
                               MOVE    "²¼Á¥£³·î"  TO
                                               SPA-H99GMN-THOJOKBN(IDX)
                           WHEN    "3"
                           WHEN    "C"
                           WHEN    "F"
                           WHEN    "I"
                               MOVE    "ÄÌ¶ÐºÒ³²"  TO
                                               SPA-H99GMN-THOJOKBN(IDX)
                       END-EVALUATE
               END-EVALUATE
               EVALUATE    RECE10-TEISYUTUSAKI
                   WHEN    "6"
                       MOVE    RECE10-NUM  TO  SPA-H99GMN-TKIGO(IDX)
                   WHEN    OTHER
                       STRING  RECE10-KIGO     DELIMITED   BY  SPACE
                               "¡¡"            DELIMITED   BY  SIZE
                               RECE10-NUM      DELIMITED   BY  SPACE
                                       INTO    SPA-H99GMN-TKIGO(IDX)
                       END-STRING
               END-EVALUATE
               MOVE    RECE10-CREYMD       TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG         TO  SPA-H99GMN-TCREYMD (IDX)
      *
               MOVE    "tbl_seikyu"        TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 900-SEIKYU-READ-SEC
           END-PERFORM
      *   
      *    ¥«¡¼¥½¥ë¥¯¥í¡¼¥¹
           MOVE    "tbl_seikyu"        TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           MOVE    IDX                 TO  SPA-H99GMN-MAX
      *
           MOVE    4                   TO  SPA-H99GMN-CUR
           .
       41021-H99-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥ì¥»¥×¥È¼ïÊÌÊÔ½¸½èÍý
      *****************************************************************
       530-RECESYUBETU-HENSYU-SEC          SECTION.
      *
           MOVE   SPACE                TO  WRK-RECESYUBETU
      * 
           IF      RECE10-TEISYUTUSAKI =   "5"
      ***      MOVE    "¸ø³²"              TO  WRK-RECESYUBETU
               GO  TO  530-RECESYUBETU-HENSYU-EXT
           END-IF        
      *
           IF      RECE10-RECESYUBETU  =   "6666"
               MOVE    "ÆÃÊÌÎÅÍÜÈñ"        TO  WRK-RECESYUBETU
               GO  TO  530-RECESYUBETU-HENSYU-EXT
           END-IF        
      *
           IF      RECE10-SRYYM        >   "200209"
               MOVE    RECE10-RECESYUBETU  TO  WRK-RECESYUBETU
               EVALUATE    RECE10-RECESYUBETU  (3:1)
                   WHEN    "4"
                   WHEN    "5"
                       MOVE    "3"             TO  WRK-RECESYUBETU (3:1)
               END-EVALUATE
      *
               INITIALIZE                      SYS-2003-REC
               MOVE    "2003"              TO  SYS-2003-KANRICD
               MOVE    SPA-HOSPNUM         TO  SYS-2003-HOSPNUM
               MOVE    RECE10-SRYYM        TO  SYS-2003-STYUKYMD (1:6)
               MOVE    "01"                TO  SYS-2003-STYUKYMD (7:2)
               MOVE    SYS-2003-STYUKYMD   TO  SYS-2003-EDYUKYMD
               MOVE    SYS-2003-REC        TO  MCPDATA-REC
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
grpsys         PERFORM 900-DBSELECT-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    "tbl_syskanri"      TO  MCP-TABLE
                   MOVE    "key2"              TO  MCP-PATHNAME
                   PERFORM 900-SYSKANRI-READ-SEC
               ELSE
                   INITIALIZE                  SYS-2003-REC
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
      *
               PERFORM    UNTIL   FLG-SYSKANRI     =   1
                   MOVE    MCPDATA-REC   TO  SYS-2003-REC
                   IF    ( SYS-2003-TEISYUTUSAKI   =
                                           RECE10-TEISYUTUSAKI )
                   AND   ( SYS-2003-NYUGAIKBN      =
                                           RECE10-NYUGAIKBN    )
                   AND   ( SYS-2003-SYUBETU (1)    =
                                           RECE10-RECESYUBETU  )
                       MOVE    SYS-2003-SYURUINAME(1:6)
                                               TO  WRK-SYURUINAME
                       MOVE    5               TO  IDY
                       PERFORM VARYING IDZ FROM    7   BY  2
                               UNTIL   IDZ >       39
                               OR      SYS-2003-SYURUINAME (IDZ:2)
                                           =       "  "
                           IF      SYS-2003-SYURUINAME (IDZ:2)
                                                   =   "¡¡"
                               CONTINUE
                           ELSE
                               ADD     2       TO  IDY
                               MOVE    SYS-2003-SYURUINAME(IDZ:2)
                                               TO  WRK-SYURUINAME(IDY:2)
                           END-IF
                       END-PERFORM    
                       MOVE    WRK-SYURUINAME  TO  WRK-RECESYUBETU(5:)
                       MOVE    1               TO  FLG-SYSKANRI
                   ELSE
                       MOVE    "tbl_syskanri"      TO  MCP-TABLE
                       MOVE    "key2"              TO  MCP-PATHNAME
                       PERFORM 900-SYSKANRI-READ-SEC
                   END-IF
               END-PERFORM
      *
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 900-CLOSE-SEC
      *
               GO  TO  530-RECESYUBETU-HENSYU-EXT
           END-IF        
      *         
           EVALUATE  RECE10-RECESYUBETU
                                 ALSO  RECE10-TEISYUTUSAKI
           WHEN    1111      ALSO      2
               IF  RECE10-HONKZKKBN    =   2
                   MOVE    "¡ú¡ú¡ú"    TO  WRK-RECESYUBETU
               ELSE
                   MOVE    "¡ú"        TO  WRK-RECESYUBETU
               END-IF
           WHEN    1111      ALSO      1
           WHEN    1111      ALSO      ANY
               MOVE    "¡ú"            TO  WRK-RECESYUBETU
      *
           WHEN    1112      ALSO      2
               IF  RECE10-HONKZKKBN    =   2
                   MOVE    "¡ù¡ù¡ù¡ù"  TO  WRK-RECESYUBETU
               ELSE
                   MOVE    "¡ù¡ù"      TO  WRK-RECESYUBETU
               END-IF
           WHEN    1112      ALSO      1
               MOVE    "¡ù¡ù"          TO  WRK-RECESYUBETU
      *
           WHEN    1115      ALSO      ANY
               MOVE    "¡ú¡ú¡ú"        TO  WRK-RECESYUBETU
      *
           WHEN    1116      ALSO      ANY
               MOVE    "¡ù¡ù¡ù¡ù"      TO  WRK-RECESYUBETU
      ****     MOVE    "¡ú¡ú¡ú¡ú"      TO  WRK-RECESYUBETU
      *
           WHEN    1121      ALSO      2
               IF  RECE10-HONKZKKBN    =   2
                   MOVE    "¡ú¡ú¡ú"    TO  WRK-RECESYUBETU
               ELSE
                   MOVE    "¡ú"        TO  WRK-RECESYUBETU
               END-IF
           WHEN    1121      ALSO      1
               MOVE    "¡ú"            TO  WRK-RECESYUBETU
      *
           WHEN    1122      ALSO      2
               IF  RECE10-HONKZKKBN    =   2
                   MOVE    "¡ù¡ù¡ù¡ù"  TO  WRK-RECESYUBETU
               ELSE
                   MOVE    "¡ù¡ù"      TO  WRK-RECESYUBETU
               END-IF
           WHEN    1122      ALSO      1
               MOVE    "¡ù¡ù"          TO  WRK-RECESYUBETU
      *
           WHEN    1125      ALSO      ANY
               MOVE    "¡ú¡ú¡ú"        TO  WRK-RECESYUBETU
      *
           WHEN    1126      ALSO      ANY
               MOVE    "¡ù¡ù¡ù¡ù"      TO  WRK-RECESYUBETU
      *
           WHEN    1131      ALSO      2
               IF  RECE10-HONKZKKBN    =   2
                   MOVE    "¡ú¡ú¡ú"    TO  WRK-RECESYUBETU
               ELSE
                   MOVE    "¡ú"        TO  WRK-RECESYUBETU
               END-IF
           WHEN    1131      ALSO      1
               MOVE    "¡ú"            TO  WRK-RECESYUBETU
      *
           WHEN    1132      ALSO      2
               IF  RECE10-HONKZKKBN    =   2
                   MOVE    "¡ù¡ù¡ù¡ù"  TO  WRK-RECESYUBETU
               ELSE
                   MOVE    "¡ù¡ù"      TO  WRK-RECESYUBETU
               END-IF
           WHEN    1132      ALSO      1
               MOVE    "¡ù¡ù"          TO  WRK-RECESYUBETU
      *
           WHEN    1135      ALSO      ANY
               MOVE    "¡ú¡ú¡ú"        TO  WRK-RECESYUBETU
      *
           WHEN    1136      ALSO      ANY
               MOVE    "¡ù¡ù¡ù¡ù"      TO  WRK-RECESYUBETU
      *
           WHEN    1211      ALSO      ANY
           WHEN    1221      ALSO      ANY
           WHEN    1231      ALSO      ANY
               MOVE    "¡ü"            TO  WRK-RECESYUBETU
      *
           WHEN    1212      ALSO      ANY
           WHEN    1222      ALSO      ANY
           WHEN    1232      ALSO      ANY
               MOVE    "¡û¡û"          TO  WRK-RECESYUBETU
      *
           WHEN    1311      ALSO      ANY
           WHEN    1321      ALSO      ANY
           WHEN    1331      ALSO      ANY
               MOVE    "¢¥"            TO  WRK-RECESYUBETU
      *
           WHEN    1312      ALSO      ANY
           WHEN    1322      ALSO      ANY
           WHEN    1332      ALSO      ANY
               MOVE    "¢¤¢¤"          TO  WRK-RECESYUBETU
      *
           WHEN    1411      ALSO      ANY
           WHEN    1421      ALSO      ANY
           WHEN    1431      ALSO      ANY
               MOVE    "¢¡"            TO  WRK-RECESYUBETU
      *
           WHEN    1412      ALSO      ANY
           WHEN    1422      ALSO      ANY
           WHEN    1432      ALSO      ANY
               MOVE    "¡þ¡þ"          TO  WRK-RECESYUBETU
      *
           WHEN    1415      ALSO      ANY
           WHEN    1425      ALSO      ANY
           WHEN    1435      ALSO      ANY
               MOVE    "¢¡¢¡¢¡"        TO  WRK-RECESYUBETU
      *
           WHEN    1416      ALSO      ANY
           WHEN    1426      ALSO      ANY
           WHEN    1436      ALSO      ANY
               MOVE    "¡þ¡þ¡þ¡þ"      TO  WRK-RECESYUBETU
           END-EVALUATE
      *
           .
       530-RECESYUBETU-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÁªÂòÈÖ¹æ¡¡ÆþÎÏ½èÍý
      *****************************************************************
       4104-SELNUM-CHK-SEC          SECTION.
      *
           MOVE    4               TO  SPA-H99GMN-CUR
      *
           MOVE    H99-SELNUM      TO  SPA-H99GMN-SELNUM
      *
           IF      SPA-H99GMN-SELNUM   <   1   OR
                   SPA-H99GMN-SELNUM   >   SPA-H99GMN-MAX
               MOVE    "0001"              TO  SPA-ERRCD
           ELSE
               MOVE    SPA-H99NAI-RECE10-KEY (SPA-H99GMN-SELNUM)
                                       TO  SPA-H99-KEY
               PERFORM 210-BACK
           END-IF
           .
       4104-SELNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¹ÔÁªÂò½èÍý
      *****************************************************************
       4105-RECESEL-SEC               SECTION.
      *        ¹ÔÁªÂò
           MOVE    ZERO                TO  WRK-SELNO
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               IF      H99-SELECT (IDX)    =   "T"
                   MOVE    IDX             TO  WRK-SELNO
                   MOVE    5               TO  IDX
               END-IF    
           END-PERFORM
      *
           MOVE    WRK-SELNO           TO  SPA-H99GMN-SELNUM
      *
           MOVE    SPA-H99NAI-RECE10-KEY (SPA-H99GMN-SELNUM)
                                       TO  SPA-H99-KEY
           PERFORM 210-BACK
           .
       41016-BYOMEISEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ìá¤ë¡¡½èÍý
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "H01"               TO  SPA-SAKIPG
           MOVE    "H99"               TO  SPA-MOTOPG
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ½ÐÎÏ½èÍý
      *****************************************************************
       450-KAKUTEI-SEC                SECTION.
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       5
               IF      H99-SELECT (IDX)    =   "T"
                   MOVE    SPA-H99NAI-RECE10-KEY (IDX)
                                           TO  SPA-H99-KEY
                   MOVE    5               TO  IDX 
               END-IF
           END-PERFORM
      * 
           MOVE    SPA-H99GMN-PTNUM    TO  SPA-H01GMN-PTNUM
           MOVE    SPA-H99NAI-PTID     TO  SPA-H01NAI-PTID
           MOVE    SPA-H99GMN-SRYYM    TO  SPA-H01GMN-SRYYM
           MOVE    SPA-H99NAI-SRYYM    TO  SPA-H01NAI-SRYYM
           MOVE    SPA-H99GMN-NAME     TO  SPA-H01GMN-NAME 
      *
           PERFORM 210-BACK
           .
       450-KAKUTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼«²èÌÌÊÔ½¸½èÍý
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE
           MOVE    "H99    "           TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ²èÌÌÊÔ½¸½èÍý
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           INITIALIZE                   H99
           MOVE    SPA-H99GMN-PTNUM     TO  H99-PTNUM
           MOVE    SPA-H99GMN-NAME      TO  H99-NAME-VALUE
           MOVE    SPA-H99GMN-SRYYM     TO  H99-SRYYM
           MOVE    SPA-H99GMN-SRYKA     TO  H99-SRYKA
           MOVE    SPA-H99GMN-SRYKANAME TO
                                        H99-SRYKANAME-VALUE
      *
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       5
                   OR      SPA-H99GMN-TNYUGAIKBN (IDX)
                                               =   SPACE
               MOVE    SPA-H99GMN-TRENNUM      (IDX)
                                   TO  H99-TRENNUM      (IDX)
               MOVE    SPA-H99GMN-TNYUGAIKBN   (IDX)
                                   TO  H99-TNYUGAIKBN   (IDX)
               MOVE    SPA-H99GMN-TSRYKA       (IDX)
                                   TO  H99-TSRYKA       (IDX)
               MOVE    SPA-H99GMN-TTEISYUTUSAKI(IDX)
                                   TO  H99-TTEISYUTUSAKI(IDX)
               MOVE    SPA-H99GMN-TRECESYUBETU (IDX)
                                   TO  H99-TRECESYUBETU (IDX)
               MOVE    SPA-H99GMN-THKNJANUM    (IDX)
                                   TO  H99-THKNJANUM    (IDX)
               MOVE    SPA-H99GMN-THOJOKBN     (IDX)
                                   TO  H99-THOJOKBN     (IDX)
               MOVE    SPA-H99GMN-TKIGO        (IDX)
                                   TO  H99-TKIGO        (IDX)
               MOVE    SPA-H99GMN-TCREYMD      (IDX)
                                   TO  H99-TCREYMD      (IDX)
               MOVE    IDX         TO  H99-COUNT
           END-PERFORM
      ***  MOVE    "T"              TO  H99-SELECT (1)
      *            
           MOVE    "blue"              TO  H99-NAME-STYLE
                                           H99-SRYKANAME-STYLE
      *            
           IF      SPA-SYS-1001-HOSPSBT1   =   "0"
               MOVE    WIDGET-INSENSITIVE  TO  H99-SRYKA-STATE
           ELSE
               MOVE    WIDGET-NORMAL       TO  H99-SRYKA-STATE
           END-IF  
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ²èÌÌ¥«¡¼¥½¥ë¥»¥Ã¥È½èÍý
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
         EVALUATE    SPA-H99GMN-CUR
             WHEN    4
                    MOVE  "SELNUM"       TO  MCP-WIDGET
             WHEN    12
                    MOVE  "B12"          TO  MCP-WIDGET   
         END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥¨¥é¡¼¥á¥Ã¥»¡¼¥¸É½¼¨Íý
      *****************************************************************
       510-ERRSET-SEC              SECTION.
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "ÆþÎÏ¥¨¥é¡¼¤Ç¤¹"  TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "ÂÐ¾Ý¤Î¥ì¥»¥×¥È¤ÏÂ¸ºß¤·¤Þ¤»¤ó"
                                             TO  SPA-ERRMSG
      *
               WHEN    "9999"
                   MOVE    "Â¾Ã¼Ëö¤Ç»ÈÍÑÃæ¤Ç¤¹¡£"
                                               TO  SPA-ERRMSG
                   MOVE    SLOCK-MSG           TO  SPA-ERRMSG(21:)
           END-EVALUATE
      *
           MOVE    SPACE                TO  HERR
           MOVE    SPA-ERRCD            TO  HERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  HERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "H99"                TO  SPA-MOTOPG
           MOVE    "HERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "HERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       510-ERRMSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÏÂÎñÀ¾ÎñÊÑ´¹ÊÔ½¸½èÍý
      *****************************************************************
       5002-HIZUKE-HEN-SEC          SECTION.
      *
           IF      WRK-SYMD (1:6)          =   ZERO    OR  SPACE
               MOVE    SPACE                   TO  WRK-HENYMDG
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
           END-IF
      *
           .
       5002-HIZUKE-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿ÆÉ¹þ
      *****************************************************************
       910-SYSKANRI-INV-SEC         SECTION.
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
grpsys     PERFORM 900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key10"             TO  MCP-PATHNAME
grpsys         PERFORM 900-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-SYSKANRI
               ELSE
                   MOVE    1                   TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       910-SYSKANRI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÀÁµá¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       900-SEIKYU-READ-SEC           SECTION.
      *
grpsys     PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SEIKYU
           ELSE
               MOVE    1               TO  FLG-SEIKYU
           END-IF
      *
           .
       900-SEIKYU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿£Ò£Å£Á£Ä
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
grpsys     PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÇÓÂ¾À©¸æ½èÍý
      *****************************************************************
       990-LOCK-IN-SEC         SECTION.
      *
      *    ÇÓÂ¾À©¸æ½èÍý
           MOVE    1                   TO  SLOCK-MODE
           MOVE    SPA-H01NAI-PTID     TO  SLOCK-PTID
           CALL    "ORCSLOCK"          USING
                                       MCPAREA
                                       SPA-AREA
                                       ORCSLOCKAREA
           IF      SLOCK-RETURN    NOT =   ZERO
               MOVE    "9999"              TO  SPA-ERRCD
           END-IF
           .
       990-LOCK-IN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÇÓÂ¾À©¸æ²ò½ü½èÍý
      *****************************************************************
       990-LOCK-OUT-SEC         SECTION.
      *
      *    ÇÓÂ¾À©¸æ²ò½ü½èÍý
           MOVE    2                   TO  SLOCK-MODE
           CALL    "ORCSLOCK"          USING
                                       MCPAREA
                                       SPA-AREA
                                       ORCSLOCKAREA
           .
       990-LOCK-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ä£Â£Ó£Å£Ì£Å£Ã£Ô½èÍý
      *****************************************************************
       900-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
           .
       900-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ä£Â£Æ£Å£Ô£Ã£È½èÍý
      *****************************************************************
       900-DBFETCH-SEC                SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥Æ¡¼¥Ö¥ë¥¯¥í¡¼¥º½èÍý
      *****************************************************************
       900-CLOSE-SEC               SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥Æ¡¼¥Ö¥ë¥¢¥¯¥»¥¹½èÍý
      *****************************************************************
       900-ORCDBMAIN-SEC               SECTION.
      *
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
      *
       900-ORCDBMAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ð£Õ£Ô¡¡½èÍý
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"          TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
           .
      *
       900-PUT-WINDOW-EXT.
           EXIT.
