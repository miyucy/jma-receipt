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
      *
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCGD01.
      *****************************************************************
      *  ¥·¥¹¥Æ¥àÌ¾        : £Ï£Ò£Ã£Á
      *  ¥µ¥Ö¥·¥¹¥Æ¥àÌ¾    : ¥Ç¡¼¥¿¥Á¥§¥Ã¥¯¥µ¥Ö
      *  ¥³¥ó¥Ý¡¼¥Í¥ó¥ÈÌ¾  : ¥Ç¡¼¥¿¥Á¥§¥Ã¥¯¾ò·ïÆþÎÏ
      *  ´ÉÍý¼Ô            : 
      *  ºîÀ®ÆüÉÕ    ºî¶È¼Ô        µ­½Ò
      *  01.07.13    ¤Ò¤µ¤Ê¤¬ ¡¡   ¿·µ¬ºîÀ®
      *****************************************************************
      *  ¥×¥í¥°¥é¥à½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      *  01.00.01    ¤Ò¤µ¤Ê¤¬     01/11/08  ¼ÂÆü¿ô¤Î³ÎÇ§ÄÉ²Ã
      *  01.00.01    ¤Ò¤µ¤Ê¤¬     02/01/25  ¿ÇÎÅÇ¯¤¬ÏÂÎñ¤Î¾ì¹çÀ¾ÎñÊÑ´¹
      *  01.00.01    ¤Ò¤µ¤Ê¤¬     02/03/18  ÌôºÞ¡¢Å¬±þÉÂÌ¾¤Î¥Á¥§¥¯ÄÉ²Ã
      *  01.00.02    ¤Ò¤µ¤Ê¤¬     02/05/10  ¥¸¥ç¥Ö´ÉÍý¸¡º÷ÄÉ²Ã
      *  01.00.02    ¤Ò¤µ¤Ê¤¬     02/05/10  È¾³Ñ¥Á¥§¥Ã¥¯¤ÎÄÉ²Ã
      *  01.00.02    ¤Ò¤µ¤Ê¤¬     02/06/26  °õºþ´ÉÍý¡¦°õºþ£Ä£ÂÄÉ²Ã
      *  01.00.03    ¤Ò¤µ¤Ê¤¬     02/09/13  ¥Ç¥£¥ì¥¯¥È¥ê¤ò¥µ¥Ö¥×¥í¤Ø
      *
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    ¥Á¥§¥¯¾ò·ïÍÑ¥Õ¥¡¥¤¥ë 
           SELECT  DID1-FILE       ASSIGN  DID1PARA
                                   FILE    STATUS  IS  STS-DID1.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    ¥Á¥§¥¯¾ò·ïÍÑ¥Õ¥¡¥¤¥ë
       FD  DID1-FILE.
       01  DID1-REC                PIC X(200). 
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    ¥Á¥§¥¯¾ò·ïÍÑ¥Õ¥¡¥¤¥ë Ì¾¾ÎÎÎ°è 
           COPY    "CPCOMMONDAT3.INC"
                                   REPLACING  //ORCGD//
                                   BY         //DID1//.
      *
      *    ¥¨¥é¡¼ÍÑ¥Õ¥¡¥¤¥ë Ì¾¾ÎÎÎ°è 
           COPY    "CPCOMMONDAT3.INC"
                                   REPLACING  //ORCGD//
                                   BY         //DID4//.
      *
      *    ¥Ç¡¼¥¿¥Á¥§¥Ã¥¯ ¥·¥§¥ëÎÎ°è 
           COPY    "CPCOMMONSHELL5.INC".
      *
      *    ¥¹¥ÑÎÎ°è
           COPY    "COMMON-SPA".
      *
       01  SPA-D01.
           03  SPA-D01-AREA.
               05  SPA-GMN-PAGE               PIC 9(02).
               05  SPA-GMN-MAX                PIC 9(03).
               05  SPA-GMN-CUR                PIC 9(02).
               05  SPA-GMN-KBN                PIC X(02).
               05  SPA-GMN-RUN                PIC 9(01).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-HOSPID         PIC X(24).
                   07  SPA-GMN-SRYYMD         PIC X(08).
                   07  SPA-GMN-SRYYMD-S       PIC X(08).
                   07  SPA-GMN-SRYYM-D        PIC X(16).
                   07  SPA-GMN-NYUGAIKBN      PIC X(01).
                   07  SPA-GMN-NYUGAIKBN-MSG  PIC X(10).
                   07  SPA-GMN-TBLG1.
                       09  SPA-GNM-TBL1       OCCURS  2.
                           11  SPA-GMN-GAI    PIC X(10).
                       09  SPA-GNM-TBL2       OCCURS  20.
                           11  SPA-GMN-MSG    PIC X(60).
                           11  SPA-GMN-BTN    PIC X(01).
                   07  SPA-GMN-TBLG2.
                       09  SPA-GNM-TBL3       OCCURS  20.
                           11  SPA-GMN-CNV    PIC X(01).
               05  SPA-NAI-AREA.
                   07  SPA-NAI-MOTOPG         PIC X(08).
      *
       01  SPA-WRK-AREA.
           03  SPA-WRK-WRK         PIC X(70).
           03  SPA-WRK-TBLG1       PIC X(1240).
           03  SPA-WRK-TBLG2       PIC X(20).
           03  SPA-WRK-MOTOPG      PIC X(08).
      *
       01  WRK-HEN-AREA.
           03  WRK-PAGE            PIC ZZZZZZZZZ9.
           03  WRK-HENTIME.
               05  WRK-HH          PIC X(02).
               05  FILLER          PIC X(01)   VALUE   ":".
               05  WRK-MM          PIC X(02).
               05  FILLER          PIC X(01)   VALUE   ":".
               05  WRK-SS          PIC X(02).
      *
      *    ¥Õ¥é¥°ÎÎ°è
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
      *
      *    ¥¨¥ó¥É¥¹¥Æ¡¼¥¿¥¹ÎÎ°è
       01  STS-AREA.
           03  STS-DID1            PIC X(02).
      *
      *    Åº»úÎÎ°è
       01  IDX-AREA.
           03  IDX1                PIC 9(03).
           03  IDX2                PIC 9(03).
      *
      *    ¥á¥Ã¥»¡¼¥¸ÎÎ°è
       01  T-MESSAGE-AREA.
           03  T-MESSAGE-800-01    PIC X(60)   VALUE
               "»ØÄê¤µ¤ì¤¿¾ò·ï¤Ç¥Á¥§¥Ã¥¯¼Â¹ÔÃæ¤Î¤¿¤á¤·¤Ð¤é¤¯¤ªÂÔ¤Á¤¯¤À¤µ
      -        "¤¤¡£".
           03  T-MESSAGE-800-02    PIC X(28)   VALUE
               "»ØÄê¤µ¤ì¤¿¾ò·ï¤Ç¤Î¥Á¥§¥Ã¥¯¤Ï".
           03  T-MESSAGE-800-03    PIC X(16)   VALUE
               "¤Ë½ªÎ»¤·¤Þ¤·¤¿¡£".
           03  T-MESSAGE-800-04    PIC X(26)   VALUE
               "Ê¬¥Á¥§¥Ã¥¯½èÍý¤ò¹Ô¤¤¤Þ¤¹¡£".
           03  T-MESSAGE-800-05    PIC X(32)   VALUE
               "¥Á¥§¥¯¾ò·ï¤¬»ØÄê¤µ¤ì¤Æ¤¤¤Þ¤»¤ó¡£".
           03  T-MESSAGE-800-06    PIC X(16)   VALUE
               "ÆþÎÏ¥¨¥é¡¼¤Ç¤¹¡£".
           03  T-MESSAGE-900-01    PIC X(10)   VALUE
               "Æþ±¡      ".
           03  T-MESSAGE-900-02    PIC X(10)   VALUE
               "³°Íè      ".
           03  T-MESSAGE-900-03    PIC X(60)   VALUE
               "ÊÝ¸±¼ÔÈÖ¹æÈ´¤±¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²
      -        "   ".
           03  T-MESSAGE-900-04    PIC X(60)   VALUE
               "ÈïÊÝ¸±¼Ôµ­¹æ¡¦ÈÖ¹æÈ´¤±¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²
      -        "   ".
           03  T-MESSAGE-900-05    PIC X(60)   VALUE
               "¸øÈñÉéÃ´¼ÔÈÖ¹æ¡¦¼õµë¼ÔÈÖ¹æÈ´¤±¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²
      -        "   ".
           03  T-MESSAGE-900-06    PIC X(60)   VALUE
               "ÊÝ¸±Å¬ÍÑÇ¯Îð¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²
      -        "   ".
           03  T-MESSAGE-900-07    PIC X(60)   VALUE
               "ÉÂÌ¾È´¤±¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²
      -        "   ".
           03  T-MESSAGE-900-08    PIC X(60)   VALUE
               "¿ÇÎÅ³«»ÏÆü¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²
      -        "   ".
           03  T-MESSAGE-900-09    PIC X(60)   VALUE
               "µ¿¤¤ÉÂÌ¾¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²
      -        "    ".
           03  T-MESSAGE-900-10    PIC X(60)   VALUE
               "ÌôºÞ¤ÈÉÂÌ¾¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²
      -        "    ".
           03  T-MESSAGE-900-11    PIC X(60)   VALUE
               "¿ÇÎÅ¹Ô°Ù¤ÈÉÂÌ¾¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²
      -        "    ".
           03  T-MESSAGE-900-12    PIC X(60)   VALUE
               "ÌôºÞ¤È¶Ø´÷¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²
      -        "    ".
           03  T-MESSAGE-900-13    PIC X(60)   VALUE
               "ÌôºÞ¤ÎÊ»ÍÑ¶Ø´÷¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²
      -        "    ".
           03  T-MESSAGE-900-14    PIC X(60)   VALUE
               "¿ÇÎÅ¹Ô°Ù¤ÎÊ»ÍÑ»»Äê¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²
      -        "    ".
           03  T-MESSAGE-900-15    PIC X(60)   VALUE
               "¼ÂÆü¿ô¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²
      -        "    ".
           03  T-MESSAGE-900-16    PIC X(60)   VALUE
               "´µ¼Ô»áÌ¾¡¦´µ¼ÔÉÂÌ¾¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²
      -        "    ".
           03  T-MESSAGE-900-17    PIC X(60)   VALUE
               "12345678901234567890123456789012345678901234567890123456
      -        "7890".
           03  T-MESSAGE-900-18    PIC X(60)   VALUE
               "12345678901234567890123456789012345678901234567890123456
      -        "7890".
           03  T-MESSAGE-900-19    PIC X(60)   VALUE
               "12345678901234567890123456789012345678901234567890123456
      -        "7890".
           03  T-MESSAGE-900-20    PIC X(60)   VALUE
               "12345678901234567890123456789012345678901234567890123456
      -        "7890".
      *
      *    ¥·¥§¥ëÍÑÎÎ°è
           COPY    "CPSHELLTBL.INC".
           COPY    "ORCA-DBPATH".
      *
      *    ¥¸¥ç¥Ö´ÉÍý
       01  WRK-JOBKANRI-AREA.
           03  WRK-JOBKANRI-MODE       PIC X(03).
           03  WRK-JOBKANRI-RETURN     PIC S9(03).
      *
      *    ¥¸¥ç¥Ö´ÉÍý¥Þ¥¹¥¿
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    ¥Õ¥£¥¢¥ë¥Ç¥¤¥ì¥¯¥È¥ê°ÌÃÖ»ØÄê¥µ¥Ö
           COPY  "CPMKPASS.INC".
      *
      *
      *****************************************************************
      *    Ï¢Íí¡¡ÎÎ°è
      *****************************************************************
      *
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *   ÆüÉÕÊÑ´¹¥µ¥Ö
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
           COPY    "CPORCSGDAY.INC".
      *
      *****************************************************************
      *    Ï¢Íí¡¡ÎÎ°è
      *****************************************************************
      *
        LINKAGE                     SECTION.
      *
      *     ¥Æ¡¼¥Ö¥ë¥¢¥¯¥»¥¹
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "D01.INC".
           COPY    "D99.INC".
           COPY    "DERR.INC".
           COPY    "DID1.INC".
           COPY    "DID2.INC".
      *
      *
       PROCEDURE                   DIVISION    USING
                                               MCPAREA
                                               SPAAREA
                                               LINKAREA
                                               SCRAREA.
      *****************************************************************
      *    ¼ç    ½è    Íý
      *****************************************************************
      *
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA.
           MOVE    SPA-FREE        TO  SPA-D01.
      *
           MOVE    SPACE           TO  SPA-ERRCD.
           MOVE    ZERO            TO  FLG-END.
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    ²èÌÌÁ«°Ü
               WHEN    "PUTG"          ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    ÆþÎÏ
               WHEN      OTHER
                   PERFORM 530-RIDSET2-SEC
                   IF  SPA-GMN-RUN   =   ZERO   OR   2
                       PERFORM 200-ENTRY
                   ELSE
                       MOVE    "D01"               TO  SPA-MOTOPG
                       MOVE    "DID2"              TO  SPA-SAKIPG
                       MOVE    "NEW"               TO  MCP-PUTTYPE
                       MOVE    "DID2"              TO  MCP-WINDOW
                       PERFORM 900-PUT-WINDOW
                       MOVE    1                   TO  FLG-END
                   END-IF
           END-EVALUATE.
      *    ²èÌÌÁ«°Ü¤¬¤Ê¤¤»þ¡¢²èÌÌÉ½¼¨¤Ø
           IF  FLG-END   =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF.
      *
           MOVE    SPA-AREA        TO  SPA-COMMON.
           MOVE    SPA-D01         TO  SPA-FREE.
      *
       000-PROC-SEC-EXT.
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    ½é´ü¡¡½èÍý
      *****************************************************************
       100-INIT-SEC                   SECTION.
      *
           INITIALIZE                  FLG-AREA.
      *    ¥¨¥é¡¼²èÌÌ¤è¤ê
           IF  SPA-MOTOPG   =   "DERR" OR "DID1" OR "DID2" OR "D99"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5011-MAPCUR-SEC
               IF  (SPA-GMN-RUN   =   ZERO  OR  2)  AND
                   (SPA-GMN-KBN   =   "OK")
                   MOVE    "CHK"               TO  WRK-JOBKANRI-MODE
                   INITIALIZE                      JOBKANRI-REC
                   MOVE    1                   TO  JOB-JOBID
                   MOVE    "ORCBSD1"           TO  JOB-SHELLID
                   MOVE    SPA-TERMID          TO  JOB-TERMID
                   CALL    "ORCSJOB"           USING
                                               WRK-JOBKANRI-AREA  
                                               JOBKANRI-REC
                   IF  WRK-JOBKANRI-RETURN   =   ZERO
                       INITIALIZE                      WRK-JOBKANRI-AREA
                       MOVE    "DEL"               TO  WRK-JOBKANRI-MODE
                       INITIALIZE                      JOBKANRI-REC
                       MOVE    1                   TO  JOB-JOBID
                       MOVE    "ORCBSD1"           TO  JOB-SHELLID
                       MOVE    SPA-TERMID          TO  JOB-TERMID
                       CALL    "ORCSJOB"           USING
                                                   WRK-JOBKANRI-AREA
                                                   JOBKANRI-REC
                   END-IF
                   MOVE    "CHK"               TO  WRK-JOBKANRI-MODE
                   INITIALIZE                      JOBKANRI-REC
                   MOVE    2                   TO  JOB-JOBID
                   MOVE    "ORCBSD1"           TO  JOB-SHELLID
                   MOVE    SPA-TERMID          TO  JOB-TERMID
                   CALL    "ORCSJOB"           USING
                                               WRK-JOBKANRI-AREA  
                                               JOBKANRI-REC
                   IF  WRK-JOBKANRI-RETURN   =   ZERO
                       INITIALIZE                      WRK-JOBKANRI-AREA
                       MOVE    "DEL"               TO  WRK-JOBKANRI-MODE
                       INITIALIZE                      JOBKANRI-REC
                       MOVE    2                   TO  JOB-JOBID
                       MOVE    "ORCBSD1"           TO  JOB-SHELLID
                       MOVE    SPA-TERMID          TO  JOB-TERMID
                       CALL    "ORCSJOB"           USING
                                                   WRK-JOBKANRI-AREA
                                                   JOBKANRI-REC
                   END-IF
                   INITIALIZE                      WRK-JOBKANRI-AREA
                   MOVE    "JBS"               TO  WRK-JOBKANRI-MODE
                   INITIALIZE                      JOBKANRI-REC
                   MOVE    1                   TO  JOB-JOBID
                   MOVE    "ORCBSD1"           TO  JOB-SHELLID
                   MOVE    SPA-TERMID          TO  JOB-TERMID
                   MOVE    "¥Á¥§¥Ã¥¯"          TO  JOB-SHELLMSG
                   CALL    "ORCSJOB"           USING
                                               WRK-JOBKANRI-AREA
                                               JOBKANRI-REC
                   OPEN    OUTPUT                  DID1-FILE
                   PERFORM T-000-RECECHEK-SEC
                   CLOSE                           DID1-FILE
                   MOVE    1                   TO  SPA-GMN-CUR
                   MOVE    1                   TO  FLG-END
                   MOVE    SPACE               TO  SPA-MOTOPG
                   MOVE    SPACE               TO  SPA-GMN-KBN
               END-IF
           ELSE
      *        ½é´ü²èÌÌ¥»¥Ã¥È
               PERFORM 300-SCREEN-SEC
      *        ²èÌÌÊÔ½¸
               PERFORM 500-GMNHEN-SEC
           END-IF.
      *
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "D01"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ½é´ü²èÌÌ½èÍý
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           INITIALIZE              SPA-D01.
      *
      *    Â¾¤Î£Ì£Ä¤è¤ê
           IF  LINKAREA   NOT =   SPACE
               MOVE    LNK-KYOUTU              TO  SPA-KYOUTU
               MOVE    LNK-SCRSPA              TO  SPA-WRK-AREA
           END-IF.
      *
           MOVE    1                       TO  SPA-GMN-CUR.
      *
           MOVE    SPACE                   TO  SPA-GMN-TBLG1.
           MOVE    "00000000000000000000"  TO  SPA-GMN-TBLG2.
           MOVE    "2"                     TO  SPA-GMN-NYUGAIKBN.
           MOVE    T-MESSAGE-900-02        TO  SPA-GMN-NYUGAIKBN-MSG.
           MOVE    T-MESSAGE-900-01        TO  SPA-GMN-GAI(1).
           MOVE    T-MESSAGE-900-02        TO  SPA-GMN-GAI(2).
           MOVE    T-MESSAGE-900-03(1:60)  TO  SPA-GMN-MSG(1).
           MOVE    SPACE                   TO  SPA-GMN-BTN(1).
           MOVE    T-MESSAGE-900-04(1:60)  TO  SPA-GMN-MSG(2).
           MOVE    SPACE                   TO  SPA-GMN-BTN(2).
           MOVE    T-MESSAGE-900-05(1:60)  TO  SPA-GMN-MSG(3).
           MOVE    SPACE                   TO  SPA-GMN-BTN(3).
           MOVE    T-MESSAGE-900-06(1:60)  TO  SPA-GMN-MSG(4).
           MOVE    SPACE                   TO  SPA-GMN-BTN(4).
           MOVE    T-MESSAGE-900-07(1:60)  TO  SPA-GMN-MSG(5).
           MOVE    SPACE                   TO  SPA-GMN-BTN(5).
           MOVE    T-MESSAGE-900-08(1:60)  TO  SPA-GMN-MSG(6).
           MOVE    SPACE                   TO  SPA-GMN-BTN(6).
           MOVE    T-MESSAGE-900-09(1:60)  TO  SPA-GMN-MSG(7).
           MOVE    SPACE                   TO  SPA-GMN-BTN(7).
           MOVE    T-MESSAGE-900-10(1:60)  TO  SPA-GMN-MSG(8).
           MOVE    SPACE                   TO  SPA-GMN-BTN(8).
           MOVE    T-MESSAGE-900-11(1:60)  TO  SPA-GMN-MSG(9).
           MOVE    SPACE                   TO  SPA-GMN-BTN(9).
           MOVE    T-MESSAGE-900-13(1:60)  TO  SPA-GMN-MSG(10).
           MOVE    SPACE                   TO  SPA-GMN-BTN(10).
           MOVE    T-MESSAGE-900-14(1:60)  TO  SPA-GMN-MSG(11).
           MOVE    SPACE                   TO  SPA-GMN-BTN(11).
           MOVE    T-MESSAGE-900-15(1:60)  TO  SPA-GMN-MSG(12).
           MOVE    SPACE                   TO  SPA-GMN-BTN(12).
           MOVE    T-MESSAGE-900-16(1:60)  TO  SPA-GMN-MSG(13).
           MOVE    SPACE                   TO  SPA-GMN-BTN(13).
           IF  SPA-MOTOPG   =   "XA01"  OR  "XB01"
               MOVE    SPA-WRK-AREA            TO  SPA-D01-AREA
           END-IF.
      *
           PERFORM 310-SPASET-SEC.
      *
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥¹¥Ñ½é´üÊÔ½¸½èÍý
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           MOVE    SPA-MOTOPG          TO  SPA-NAI-MOTOPG.
      *
           MOVE    1                   TO  SPA-GMN-CUR.
      *
           IF  (SPA-SRYYMD      NOT =   SPACE)  AND
               (SPA-NYUGAIKBN   NOT =   SPACE)
               MOVE    SPA-HOSPID      TO  SPA-GMN-HOSPID
               MOVE    SPA-SRYYMD      TO  SPA-GMN-SRYYMD-S
               MOVE    SPA-NYUGAIKBN   TO  SPA-GMN-NYUGAIKBN
               PERFORM T-000-RECECHEK-SEC
           ELSE
               MOVE    1               TO  SPA-GMN-PAGE
           END-IF.
      *
           PERFORM T-000-CHEKSETT-SEC.
      *
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ²èÌÌÁ«°Ü½èÍý
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM 530-RIDSET4-SEC
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 530-RIDSET3-SEC
               WHEN    "CLICKED"       ALSO    "B12"
                   IF  SPA-GMN-SRYYMD   NOT =   SPACE
                       PERFORM 530-RIDSET2-SEC
                   ELSE
                       MOVE    "9999"             TO  DERR-ERRCODE
                       MOVE    T-MESSAGE-800-05   TO  DERR-ERRMSG
                       MOVE    "B01"              TO  MCP-WIDGET
                       MOVE    "D01"              TO  SPA-MOTOPG
                       MOVE    "DERR"             TO  SPA-SAKIPG
                       MOVE    "NEW"              TO  MCP-PUTTYPE
                       MOVE    "DERR"             TO  MCP-WINDOW
                       PERFORM 900-PUT-WINDOW
                       MOVE    1                   TO  FLG-END
                   END-IF
               WHEN    "CLICKED"       ALSO    "B13"
                   PERFORM 530-RIDSET2-SEC
               WHEN    "CLICKED"       ALSO    "SRYYM"
                   IF  SPA-GMN-RUN   =   ZERO   OR   2
                       PERFORM T-000-YMDCHEK-SEC
                   END-IF
               WHEN    "CLICKED"       ALSO    "NYUGAIKBN"
                   IF  SPA-GMN-RUN   =   ZERO   OR   2
                       MOVE    23                  TO    SPA-GMN-CUR
                       PERFORM VARYING IDX1  FROM  1  BY 1
                               UNTIL   IDX1  >    20
                               IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                   COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                   MOVE    21               TO    IDX1
                               END-IF
                       END-PERFORM
                       EVALUATE    SPA-GMN-NYUGAIKBN
                           WHEN    "2"
                                   MOVE    "1"
                                           TO    SPA-GMN-NYUGAIKBN
                                   MOVE    SPA-GMN-GAI(1)
                                           TO    SPA-GMN-NYUGAIKBN-MSG
                           WHEN    OTHER
                                   MOVE    "2"
                                           TO    SPA-GMN-NYUGAIKBN
                                   MOVE    SPA-GMN-GAI(2)
                                           TO    SPA-GMN-NYUGAIKBN-MSG
                       END-EVALUATE
                   END-IF
               WHEN    "CLICKED"       ALSO    "CHKBTN1"
               WHEN    "CLICKED"       ALSO    "CHKBTN2"
               WHEN    "CLICKED"       ALSO    "CHKBTN3"
               WHEN    "CLICKED"       ALSO    "CHKBTN4"
               WHEN    "CLICKED"       ALSO    "CHKBTN5"
               WHEN    "CLICKED"       ALSO    "CHKBTN6"
               WHEN    "CLICKED"       ALSO    "CHKBTN7"
               WHEN    "CLICKED"       ALSO    "CHKBTN8"
               WHEN    "CLICKED"       ALSO    "CHKBTN9"
               WHEN    "CLICKED"       ALSO    "CHKBTN10"
               WHEN    "CLICKED"       ALSO    "CHKBTN11"
               WHEN    "CLICKED"       ALSO    "CHKBTN12"
               WHEN    "CLICKED"       ALSO    "CHKBTN13"
               WHEN    "CLICKED"       ALSO    "CHKBTN14"
               WHEN    "CLICKED"       ALSO    "CHKBTN15"
               WHEN    "CLICKED"       ALSO    "CHKBTN16"
               WHEN    "CLICKED"       ALSO    "CHKBTN17"
               WHEN    "CLICKED"       ALSO    "CHKBTN18"
               WHEN    "CLICKED"       ALSO    "CHKBTN19"
               WHEN    "CLICKED"       ALSO    "CHKBTN20"
                   IF  SPA-GMN-RUN   =   ZERO   OR   2
                       PERFORM T-000-CHEKCHEK-SEC
                   END-IF
               WHEN    OTHER
                   MOVE    1                   TO  SPA-GMN-CUR
           END-EVALUATE.
      *
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    ²ñÏÃ¡¡½èÍý
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
               WHEN    "ACTIVATE"      ALSO    "SRYYM"
                   PERFORM T-000-YMDCHEK-SEC
               WHEN    "ACTIVATE"      ALSO    "NYUGAIKBN"
                   MOVE    23                  TO    SPA-GMN-CUR
                   PERFORM VARYING IDX1  FROM  1  BY 1
                           UNTIL   IDX1  >    20
                           IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                               COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                               MOVE    21
                                       TO    IDX1
                           END-IF
                   END-PERFORM
                   EVALUATE    SPA-GMN-NYUGAIKBN
                       WHEN    "2"
                               MOVE    "1"
                                       TO    SPA-GMN-NYUGAIKBN
                               MOVE    SPA-GMN-GAI(1)
                                       TO    SPA-GMN-NYUGAIKBN-MSG
                       WHEN    OTHER
                               MOVE    "2"
                                       TO    SPA-GMN-NYUGAIKBN
                               MOVE    SPA-GMN-GAI(2)
                                       TO    SPA-GMN-NYUGAIKBN-MSG
                   END-EVALUATE
               WHEN    "ACTIVATE"      ALSO    "CHKBTN1"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN2"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN3"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN4"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN5"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN6"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN7"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN8"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN9"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN10"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN11"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN12"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN13"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN14"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN15"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN16"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN17"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN18"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN19"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN20"
                   PERFORM T-000-CHEKCHEK-SEC
               WHEN    OTHER
                   MOVE    1                   TO  SPA-GMN-CUR
           END-EVALUATE.
      *
           MOVE    SPA-HOSPID          TO  SPA-GMN-HOSPID.
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ìá¤ë¡¡½èÍý
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "M01"               TO  SPA-SAKIPG.
           MOVE    SPACE               TO  SPA-MOTOPG2.
           MOVE    "D01"               TO  SPA-MOTOPG.
      *
           MOVE    SPACE               TO  LINKAREA. 
           INITIALIZE                  SPA-KYOTUKEY.
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU.
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW.
           MOVE    "CHANGE"            TO  MCP-PUTTYPE.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼«²èÌÌÊÔ½¸½èÍý
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC.
      *
           MOVE    SPACE           TO  LINKAREA.
           MOVE    "CURRENT"       TO  MCP-PUTTYPE.
           MOVE    "D01"           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ²èÌÌÆâÍÆÊÔ½¸½èÍý
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    SPACE                   TO  D01.
      *
           MOVE    SPA-GMN-SRYYMD(1:6)     TO  D01-SRYYM.
           MOVE    SPA-GMN-NYUGAIKBN-MSG   TO  D01-NYUGAIMSG.
      *
           EVALUATE    SPA-GMN-NYUGAIKBN
               WHEN    "1"
                       MOVE    "F"             TO    D01-NYUGAIKBN
               WHEN    "2"
                       MOVE    "T"             TO    D01-NYUGAIKBN
           END-EVALUATE.
      *
           MOVE    SPA-GMN-MSG(1)          TO  D01-CHKMSG1.
           MOVE    SPA-GMN-MSG(2)          TO  D01-CHKMSG2.
           MOVE    SPA-GMN-MSG(3)          TO  D01-CHKMSG3.
           MOVE    SPA-GMN-MSG(4)          TO  D01-CHKMSG4.
           MOVE    SPA-GMN-MSG(5)          TO  D01-CHKMSG5.
           MOVE    SPA-GMN-MSG(6)          TO  D01-CHKMSG6.
           MOVE    SPA-GMN-MSG(7)          TO  D01-CHKMSG7.
           MOVE    SPA-GMN-MSG(8)          TO  D01-CHKMSG8.
           MOVE    SPA-GMN-MSG(9)          TO  D01-CHKMSG9.
           MOVE    SPA-GMN-MSG(10)         TO  D01-CHKMSG10.
           MOVE    SPA-GMN-MSG(11)         TO  D01-CHKMSG11.
           MOVE    SPA-GMN-MSG(12)         TO  D01-CHKMSG12.
           MOVE    SPA-GMN-MSG(13)         TO  D01-CHKMSG13.
           MOVE    SPA-GMN-MSG(14)         TO  D01-CHKMSG14.
           MOVE    SPA-GMN-MSG(15)         TO  D01-CHKMSG15.
           MOVE    SPA-GMN-MSG(16)         TO  D01-CHKMSG16.
           MOVE    SPA-GMN-MSG(17)         TO  D01-CHKMSG17.
           MOVE    SPA-GMN-MSG(18)         TO  D01-CHKMSG18.
           MOVE    SPA-GMN-MSG(19)         TO  D01-CHKMSG19.
           MOVE    SPA-GMN-MSG(20)         TO  D01-CHKMSG20.
      *
           EVALUATE    SPA-GMN-BTN(1)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN1
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN1
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(2)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN2
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN2
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(3)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN3
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN3
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(4)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN4
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN4
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(5)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN5
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN5
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(6)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN6
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN6
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(7)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN7
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN7
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(8)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN8
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN8
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(9)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN9
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN9
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(10)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN10
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN10
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(11)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN11
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN11
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(12)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN12
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN12
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(13)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN13
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN13
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(14)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN14
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN14
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(15)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN15
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN15
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(16)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN16
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN16
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(17)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN17
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN17
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(18)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN18
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN18
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(19)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN19
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN19
           END-EVALUATE.
           EVALUATE    SPA-GMN-BTN(20)
               WHEN    "F"
                       MOVE    "F"             TO  D01-CHKBTN20
               WHEN    "T"
                       MOVE    "T"             TO  D01-CHKBTN20
           END-EVALUATE.
      *
           PERFORM 5011-MAPCUR-SEC.
      *
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ²èÌÌ¥«¡¼¥½¥ë¥»¥Ã¥È½èÍý
      *****************************************************************
       5011-MAPCUR-SEC              SECTION.
      *
           EVALUATE    SPA-GMN-CUR
               WHEN    01
                   MOVE    "SRYYM"         TO  MCP-WIDGET
               WHEN    02
                   MOVE    "NYUGAIKBN"     TO  MCP-WIDGET
               WHEN    03
                   MOVE    "CHKBTN1"       TO  MCP-WIDGET
               WHEN    04
                   MOVE    "CHKBTN2"       TO  MCP-WIDGET
               WHEN    05
                   MOVE    "CHKBTN3"       TO  MCP-WIDGET
               WHEN    06
                   MOVE    "CHKBTN4"       TO  MCP-WIDGET
               WHEN    07
                   MOVE    "CHKBTN5"       TO  MCP-WIDGET
               WHEN    08
                   MOVE    "CHKBTN6"       TO  MCP-WIDGET
               WHEN    09
                   MOVE    "CHKBTN7"       TO  MCP-WIDGET
               WHEN    10
                   MOVE    "CHKBTN8"       TO  MCP-WIDGET
               WHEN    11
                   MOVE    "CHKBTN9"       TO  MCP-WIDGET
               WHEN    12
                   MOVE    "CHKBTN10"      TO  MCP-WIDGET
               WHEN    13
                   MOVE    "CHKBTN11"      TO  MCP-WIDGET
               WHEN    14
                   MOVE    "CHKBTN12"      TO  MCP-WIDGET
               WHEN    15
                   MOVE    "CHKBTN13"      TO  MCP-WIDGET
               WHEN    16
                   MOVE    "CHKBTN14"      TO  MCP-WIDGET
               WHEN    17
                   MOVE    "CHKBTN15"      TO  MCP-WIDGET
               WHEN    18
                   MOVE    "CHKBTN16"      TO  MCP-WIDGET
               WHEN    19
                   MOVE    "CHKBTN17"      TO  MCP-WIDGET
               WHEN    20
                   MOVE    "CHKBTN18"      TO  MCP-WIDGET
               WHEN    21
                   MOVE    "CHKBTN19"      TO  MCP-WIDGET
               WHEN    22
                   MOVE    "CHKBTN20"      TO  MCP-WIDGET
               WHEN    23
                   MOVE    "B12"           TO  MCP-WIDGET
           END-EVALUATE.
      *
       5011-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    ³ÎÇ§¥á¥Ã¥»¡¼¥¸É½¼¨Íý
      *****************************************************************
       530-RIDSET2-SEC              SECTION.
      *
      *    ¥¸¥ç¥Ö´ÉÍý¥Á¥§¥Ã¥¯½èÍý
      *
           MOVE    "CHK"              TO  WRK-JOBKANRI-MODE.
           INITIALIZE                     JOBKANRI-REC.
           MOVE    1                  TO  JOB-JOBID.
           MOVE    "ORCBSD1"          TO  JOB-SHELLID.
           MOVE    SPA-TERMID         TO  JOB-TERMID.
           CALL    "ORCSJOB"          USING
                                      WRK-JOBKANRI-AREA  
                                      JOBKANRI-REC.
           MOVE    SPACE              TO  DID2.
           MOVE    SPACE              TO  D99.
           MOVE    ZERO               TO  SPA-GMN-RUN.
           IF  WRK-JOBKANRI-RETURN   =   ZERO
               IF  JOB-ENDYMD   =   SPACE
                   MOVE    "7777"             TO  DID2-ID2CODE
                   MOVE    T-MESSAGE-800-01   TO  DID2-ID2MSG
                   MOVE    1                  TO  SPA-GMN-RUN
               ELSE
                   MOVE    2                  TO  SPA-GMN-RUN
               END-IF
               IF  MCP-WIDGET   =   "B13"
                   MOVE    JOB-JOBID          TO  D99-RENNUM   (1)
                   MOVE    JOB-SHELLMSG       TO  D99-SHORINM  (1)
                   MOVE    JOB-STARTTIME(1:2) TO  WRK-HH
                   MOVE    JOB-STARTTIME(3:2) TO  WRK-MM
                   MOVE    JOB-STARTTIME(5:2) TO  WRK-SS
                   MOVE    WRK-HENTIME        TO  D99-STARTTIME (1)
                   MOVE    JOB-ENDTIME(1:2)   TO  WRK-HH
                   MOVE    JOB-ENDTIME(3:2)   TO  WRK-MM
                   MOVE    JOB-ENDTIME(5:2)   TO  WRK-SS
                   MOVE    WRK-HENTIME        TO  D99-ENDTIME  (1)
                   MOVE    JOB-UPDCNT         TO  WRK-PAGE
                   MOVE    WRK-PAGE           TO  D99-PAGE     (1)
                   MOVE    JOB-YOBI           TO  D99-ERRMSG   (1)
                   IF  JOB-ENDYMD   =   SPACE
                       MOVE    "½èÍýÃæ¤Ç¤¹"   TO  D99-MSG
                   ELSE
                       IF  JOB-ERRCD   NOT =   SPACE
                           STRING  JOB-YOBI     DELIMITED  BY  SPACE
                                   "¡Ú"         DELIMITED  BY  SIZE
                                   JOB-SHELLMSG DELIMITED  BY  SPACE
                                   "¡Û"         DELIMITED  BY  SIZE
                                                INTO  D99-MSG
                       END-IF
                   END-IF    
                   MOVE    1                  TO  D99-COUNT
                   MOVE    "B01"              TO  MCP-WIDGET
                   IF  D99-MSG   =   SPACE
                       IF  D99-COUNT   >   ZERO    
                           MOVE    "½èÍý¤ÏÀµ¾ï¤Ë½ªÎ»¤·¤Þ¤·¤¿"
                                                       TO  D99-MSG
                       ELSE
                           MOVE    "³ºÅö¤¹¤ë½èÍý¤Ï¤¢¤ê¤Þ¤»¤ó"
                                                       TO  D99-MSG
                       END-IF                                 
                   ELSE                                        
                      MOVE    "B11"               TO  MCP-WIDGET
                   END-IF
                   MOVE    "D01"               TO  SPA-MOTOPG
                   MOVE    "D99"               TO  SPA-SAKIPG
                   MOVE    "NEW"               TO  MCP-PUTTYPE
                   MOVE    "D99"               TO  MCP-WINDOW
                   PERFORM 900-PUT-WINDOW
                   MOVE    1                   TO  FLG-END
               END-IF
           END-IF.
      *
           IF  MCP-WIDGET   =   "B12"
               IF  SPA-GMN-RUN        NOT =   1
                   MOVE    "1001"                TO  DID1-ID1CODE
                   MOVE    SPA-GMN-SRYYM-D(1:16) TO  DID1-ID1MSG(1:16)
                   MOVE    T-MESSAGE-800-04      TO  DID1-ID1MSG(17:26)
                   MOVE    "D01"                 TO  SPA-MOTOPG
                   MOVE    "DID1"                TO  SPA-SAKIPG
                   MOVE    "NEW"                 TO  MCP-PUTTYPE
                   MOVE    "DID1"                TO  MCP-WINDOW
               ELSE
                   MOVE    "D01"                 TO  SPA-MOTOPG
                   MOVE    "DID2"                TO  SPA-SAKIPG
                   MOVE    "NEW"                 TO  MCP-PUTTYPE
                   MOVE    "DID2"                TO  MCP-WINDOW
               END-IF
               PERFORM 900-PUT-WINDOW
               MOVE    1                     TO  FLG-END
           END-IF.
      *
       530-RIDSET2-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥¸¥ç¥Ö´ÉÍýÉ½¼¨Íý
      *****************************************************************
       530-RIDSET3-SEC              SECTION.
      *
      *    ²èÌÌ°Ü¹ÔÍÑ¤Î¥Ñ¥é¥á¥¿ÊÑ¹¹
           MOVE    "D01"               TO  SPA-MOTOPG.
           MOVE    "XB01"              TO  SPA-SAKIPG.
           INITIALIZE                  SPA-KYOTUKEY.
           INITIALIZE                  SPA-WORK.
           MOVE    "ORCBSD1"           TO  SPA-JOB-SHELLID.
           MOVE    SPACE               TO  LINKAREA.
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU.
           MOVE    SPA-D01-AREA        TO  LNK-SCRSPA.
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "XB01"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       530-RIDSET3-EXT.
           EXIT.
      *
      *****************************************************************
      *    °õºþ´ÉÍýÉ½¼¨Íý
      *****************************************************************
       530-RIDSET4-SEC              SECTION.
      *
      *    ²èÌÌ°Ü¹ÔÍÑ¤Î¥Ñ¥é¥á¥¿ÊÑ¹¹
           MOVE    "D01"               TO  SPA-MOTOPG.
           MOVE    "XA01"              TO  SPA-SAKIPG.
           INITIALIZE                  SPA-KYOTUKEY.
           INITIALIZE                  SPA-WORK.
           MOVE    "ORCBSD1"           TO  SPA-JOB-SHELLID.
           MOVE    "ORCBSD1"           TO  SPA-PRTKANRI-TBL-KEY.
           MOVE    SPACE               TO  LINKAREA.
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU.
           MOVE    SPA-D01-AREA        TO  LNK-SCRSPA.
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "XA01"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       530-RIDSET4-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ð£Õ£Ô¡¡½èÍý
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"                   TO  MCP-FUNC.
           CALL   "ORCMCPSUB"                   USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC.
      *
       900-PUT-WINDOW-EXT.
           EXIT.
      *
      *****************************************************************
      *    ³°Éô¥Õ¥¡¥¤¥ëÌ¾ ÀßÄê½èÍý
      *****************************************************************
       T-000-CHEKSETT-SEC                SECTION.
      *
           MOVE    "ORCGD1"      TO  DID1PARA-FILE-ID.
           MOVE    SPA-TERMID    TO  DID1PARA-TERMID.
      *
           MOVE    "ORCGD4"      TO  DID4PARA-FILE-ID.
           MOVE    SPA-TERMID    TO  DID4PARA-TERMID.
      *
       T-000-CHEKCHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼Â¹Ô¹àÌÜ ³ÎÇ§½èÍý
      *****************************************************************
       T-000-CHEKCHEK-SEC                SECTION.
      *
           EVALUATE    MCP-WIDGET
             WHEN    "CHKBTN1"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (1)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(1)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(1)
                           MOVE    "    "    TO  SPA-GMN-MSG(1)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(1)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(1)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(1)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(1)
                     END-EVALUATE
                     PERFORM VARYING IDX1  FROM  2  BY 1
                             UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                     END-PERFORM
                 END-IF
             WHEN    "CHKBTN2"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (2)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(2)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(2)
                           MOVE    "    "    TO  SPA-GMN-MSG(2)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(2)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(2)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(2)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(2)
                     END-EVALUATE
                     PERFORM VARYING IDX1  FROM  3  BY 1
                             UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                     END-PERFORM
                 END-IF
             WHEN    "CHKBTN3"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (3)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(3)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(3)
                           MOVE    "    "    TO  SPA-GMN-MSG(3)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(3)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(3)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(3)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(3)
                     END-EVALUATE
                     PERFORM VARYING IDX1  FROM  4  BY 1
                             UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                     END-PERFORM
                 END-IF
             WHEN    "CHKBTN4"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (4)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(4)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(4)
                           MOVE    "    "    TO  SPA-GMN-MSG(4)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(4)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(4)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(4)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(4)
                     END-EVALUATE
                 END-IF
                 PERFORM VARYING IDX1  FROM  5  BY 1
                         UNTIL   IDX1  >    20
                         IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                             COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                             MOVE    21       TO  IDX1
                         END-IF
                 END-PERFORM
             WHEN    "CHKBTN5"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (5)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(5)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(5)
                           MOVE    "    "    TO  SPA-GMN-MSG(5)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(5)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(5)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(5)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(5)
                     END-EVALUATE
                     PERFORM VARYING IDX1  FROM  6  BY 1
                             UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                     END-PERFORM
                 END-IF
             WHEN    "CHKBTN6"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (6)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(6)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(6)
                           MOVE    "    "    TO  SPA-GMN-MSG(6)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(6)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(6)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(6)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(6)
                     END-EVALUATE
                     PERFORM VARYING IDX1  FROM  7  BY 1
                             UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                     END-PERFORM
                 END-IF
             WHEN    "CHKBTN7"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (7)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(7)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(7)
                           MOVE    "    "    TO  SPA-GMN-MSG(7)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(7)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(7)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(7)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(7)
                     END-EVALUATE
                     PERFORM VARYING IDX1  FROM  8  BY 1
                             UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                     END-PERFORM
                 END-IF
             WHEN    "CHKBTN8"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (8)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(8)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(8)
                           MOVE    "    "    TO  SPA-GMN-MSG(8)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(8)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(8)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(8)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(8)
                     END-EVALUATE
                     PERFORM VARYING IDX1  FROM  9  BY 1
                             UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                     END-PERFORM
                 END-IF
             WHEN    "CHKBTN9"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (9)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(9)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(9)
                           MOVE    "    "    TO  SPA-GMN-MSG(9)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(9)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(9)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(9)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(9)
                     END-EVALUATE
                     PERFORM VARYING IDX1  FROM  10  BY 1
                             UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                     END-PERFORM
                 END-IF
             WHEN    "CHKBTN10"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (10)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(10)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(10)
                           MOVE    "    "    TO  SPA-GMN-MSG(10)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(10)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(10)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(10)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(10)
                     END-EVALUATE
                     PERFORM VARYING IDX1  FROM  11  BY 1
                             UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                     END-PERFORM
                 END-IF
             WHEN    "CHKBTN11"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (11)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(11)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(11)
                           MOVE    "    "    TO  SPA-GMN-MSG(11)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(11)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(11)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(11)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(11)
                     END-EVALUATE
                     PERFORM VARYING IDX1  FROM  12  BY 1
                             UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                     END-PERFORM
                 END-IF
             WHEN    "CHKBTN12"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (12)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(12)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(12)
                           MOVE    "    "    TO  SPA-GMN-MSG(12)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(12)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(12)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(12)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(12)
                     END-EVALUATE
                     PERFORM VARYING IDX1  FROM  13  BY 1
                             UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                     END-PERFORM
                 END-IF
             WHEN    "CHKBTN13"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (13)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(13)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(13)
                           MOVE    "    "    TO  SPA-GMN-MSG(13)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(13)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(13)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(13)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(13)
                     END-EVALUATE
                     PERFORM VARYING IDX1  FROM  14  BY 1
                             UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                     END-PERFORM
                 END-IF
             WHEN    "CHKBTN14"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (14)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(14)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(14)
                           MOVE    "    "    TO  SPA-GMN-MSG(14)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(14)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(14)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(14)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(14)
                     END-EVALUATE
                     PERFORM VARYING IDX1  FROM  15  BY 1
                             UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                     END-PERFORM
                 END-IF
             WHEN    "CHKBTN15"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (15)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(15)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(15)
                           MOVE    "    "    TO  SPA-GMN-MSG(15)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(15)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(15)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(15)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(15)
                     END-EVALUATE
                     PERFORM VARYING IDX1  FROM  16  BY 1
                             UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                     END-PERFORM
                 END-IF
             WHEN    "CHKBTN16"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (16)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(16)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(16)
                           MOVE    "    "    TO  SPA-GMN-MSG(16)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(16)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(16)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(16)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(16)
                     END-EVALUATE
                     PERFORM VARYING IDX1  FROM  17  BY 1
                             UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                     END-PERFORM
                 END-IF
             WHEN    "CHKBTN17"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (17)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(17)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(17)
                           MOVE    "    "    TO  SPA-GMN-MSG(17)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(17)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(17)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(17)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(17)
                     END-EVALUATE
                     PERFORM VARYING IDX1  FROM  18  BY 1
                             UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                     END-PERFORM
                 END-IF
             WHEN    "CHKBTN18"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (18)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(18)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(18)
                           MOVE    "    "    TO  SPA-GMN-MSG(18)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(18)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(18)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(18)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(18)
                     END-EVALUATE
                     PERFORM VARYING IDX1  FROM  19  BY 1
                             UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                     END-PERFORM
                 END-IF
             WHEN    "CHKBTN19"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (19)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(19)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(19)
                           MOVE    "    "    TO  SPA-GMN-MSG(19)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(19)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(19)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(19)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(19)
                     END-EVALUATE
                     PERFORM VARYING IDX1  FROM  20  BY 1
                             UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                     END-PERFORM
                 END-IF
             WHEN    "CHKBTN20"
                 MOVE    23                      TO  SPA-GMN-CUR
                 IF  SPA-GMN-MSG (20)  NOT =  SPACE
                     EVALUATE    SPA-GMN-BTN(20)
                       WHEN    "T"
                           MOVE    "F"       TO  SPA-GMN-BTN(20)
                           MOVE    "    "    TO  SPA-GMN-MSG(20)(57:4)
                           MOVE    "0"       TO  SPA-GMN-CNV(20)
                       WHEN    OTHER
                           MOVE    "T"       TO  SPA-GMN-BTN(20)
                           MOVE    "³ÎÇ§"    TO  SPA-GMN-MSG(20)(57:4)
                           MOVE    "1"       TO  SPA-GMN-CNV(20)
                     END-EVALUATE
                 END-IF
             WHEN    OTHER
                 MOVE    1                       TO  SPA-GMN-CUR
           END-EVALUATE.
      *
       T-000-CHEKCHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ³ÎÇ§¾ò·ï ½ÐÎÏ½èÍý
      *****************************************************************
       T-000-RECECHEK-SEC                SECTION.
      *
           MOVE    SPACE                       TO    DID1-REC.
           MOVE    SPA-GMN-HOSPID              TO    DID1-REC.
           WRITE   DID1-REC.
      *      
           MOVE    SPACE                       TO    DID1-REC.
           MOVE    SPA-GMN-SRYYMD(1:6)         TO    DID1-REC(1:6).
           MOVE    SPA-GMN-SRYYMD-S(1:6)       TO    DID1-REC(7:6).
           WRITE   DID1-REC.
      *
           MOVE    SPACE                       TO    DID1-REC.
           MOVE    SPA-GMN-NYUGAIKBN           TO    DID1-REC(1:1).
           MOVE    SPA-GMN-NYUGAIKBN-MSG       TO    DID1-REC(2:10).
           WRITE   DID1-REC.
      *
           MOVE    SPACE                       TO    DID1-REC.
           MOVE    SPA-GMN-TBLG2               TO    DID1-REC(1:20).
           WRITE   DID1-REC.
      *
      *½¤Àµ/*³«»Ï*02.09.13*********************************************
      *     MOVE    "orcbsd01.sh"           TO  SHELL-SHELL.
           INITIALIZE                                ORCSMKPASSAREA.
           MOVE    "scripts/allways/orcbsd01.sh" TO  MKPASS-IN-01.
           CALL    "ORCSMKPASS"               USING  ORCSMKPASSAREA.
           MOVE    MKPASS-OT-01                  TO  SHELL-NAME.
      *½¤Àµ/*½ªÎ»*02.09.13*********************************************
           MOVE    SPA-GMN-SRYYMD-S(1:6)       TO  SHELL-SRYYM.
           MOVE    SPA-TERMID                  TO  SHELL-TERMID
                                                   SHELL-WK-TERMID.
           MOVE    SPA-SYSYMD                  TO  SHELL-SYSYMD.
           MOVE    SPA-OPID                    TO  SHELL-OPID.
           MOVE    ZERO                        TO  SHELL-SYOKBN.
           MOVE    ZERO                        TO  SHELL-RECEKBN.
           MOVE    DID4PARA                    TO  SHELL-ERRFILE.
           MOVE    SHELL-NAME                  TO  SHELLTBL-NAME.
           MOVE    SHELL-ARG1                  TO  SHELLTBL-ARG1.
           MOVE    SHELL-ARG2                  TO  SHELLTBL-ARG2.
           MOVE    SHELL-ARG3                  TO  SHELLTBL-ARG3.
           MOVE    SHELL-ARG4                  TO  SHELLTBL-ARG4.
           MOVE    SHELL-ARG5                  TO  SHELLTBL-ARG5.
           MOVE    SHELLTBL                    TO  MCPDATA-REC.
           MOVE    "SHELL"                     TO  MCP-FUNC.
           MOVE    PATH-SHELL-SHELL            TO  MCP-PATH.
           CALL    "MCPSUB"                    USING
                                               MCPAREA
                                               MCPDATA-REC.
      *
       T-000-RECECHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¿ÇÎÅÇ¯·î ³ÎÇ§½èÍý
      *****************************************************************
       T-000-YMDCHEK-SEC                 SECTION.
      *
           MOVE    2                   TO  SPA-GMN-CUR.
      *
           INITIALIZE                  ORCSGDAYAREA.
           MOVE    "1"                 TO  SGDAY-INTYPE.
           MOVE    D01-SRYYM           TO  SGDAY-INDAY.
      *
           CALL    "ORCSGDAY"          USING   ORCSGDAYAREA.
      *
           IF  SGDAY-RC   =   ZERO
               MOVE    SGDAY-OTDAY(1:6)      TO  D01-SRYYM
               MOVE    SGDAY-SDAY(1:6)       TO  SPA-GMN-SRYYMD-S
      *
               INITIALIZE                    STS-AREA-DAY
               INITIALIZE                    LNK-DAY1-AREA
               MOVE    ZERO                  TO  LNK-DAY1-YMD
               MOVE    "11"                  TO  LNK-DAY1-IRAI
               MOVE    SPA-GMN-SRYYMD-S(1:6) TO  LNK-DAY1-YMD-X(1:6)
               MOVE    "01"                  TO  LNK-DAY1-YMD-X(7:2)
      *
               CALL    "ORCSDAY"             USING   STS-AREA-DAY
                                                     LNK-DAY1-AREA
      *
               IF  STS-DAY-RC1   NOT =   ZERO
                   MOVE    "0001"                TO  DERR-ERRCODE
                   MOVE    T-MESSAGE-800-06      TO  DERR-ERRMSG
                   MOVE    "B01"                 TO  MCP-WIDGET
                   MOVE    "D01"                 TO  SPA-MOTOPG
                   MOVE    "DERR"                TO  SPA-SAKIPG
                   MOVE    "NEW"                 TO  MCP-PUTTYPE
                   MOVE    "DERR"                TO  MCP-WINDOW
                   PERFORM 900-PUT-WINDOW
                   MOVE    1                     TO  SPA-GMN-CUR
                   MOVE    1                     TO  FLG-END
               ELSE
                   MOVE    D01-SRYYM(1:6)        TO  SPA-GMN-SRYYMD
                   INITIALIZE                        STS-AREA-DAY
                   INITIALIZE                        LNK-DAY2-AREA
                   MOVE    ZERO                  TO  LNK-DAY2-YMD
                   MOVE    "21"                  TO  LNK-DAY2-IRAI
                   MOVE    SPA-GMN-SRYYMD-S(1:6) TO  LNK-DAY2-YMD(1:6)
                   MOVE    "01"                  TO  LNK-DAY2-YMD(7:2)
                   CALL    "ORCSDAY"             USING   STS-AREA-DAY
                                                         LNK-DAY2-AREA
                   MOVE    LNK-DAY2-EDTYMD3(1:16) TO  SPA-GMN-SRYYM-D
               END-IF
           ELSE
               MOVE    "0001"                TO  DERR-ERRCODE
               MOVE    T-MESSAGE-800-06      TO  DERR-ERRMSG
               MOVE    "B01"                 TO  MCP-WIDGET
               MOVE    "D01"                 TO  SPA-MOTOPG
               MOVE    "DERR"                TO  SPA-SAKIPG
               MOVE    "NEW"                 TO  MCP-PUTTYPE
               MOVE    "DERR"                TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    1                     TO  SPA-GMN-CUR
               MOVE    1                     TO  FLG-END
           END-IF.
      *
       T-000-YMDCHEK-EXT.
           EXIT.
      *
