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
      *  01.00.04    ¤Ò¤µ¤Ê¤¬     03/04/17  Æþ±¡»þÊÝ¸±ÁÈ¹ç¤»¥Á¥§¥Ã¥¯
      *  01.00.05    ¤Ò¤µ¤Ê¤¬     03/05/13  ¥Ü¥¿¥ó¤¬²¡¤»¤Ê¤¤¾ì¹ç½¤Àµ
      *  01.00.06    ¤Ò¤µ¤Ê¤¬     03/06/06  ÉÂÌ¾¥³¡¼¥ÉÈ´¤±¤Î¥Á¥§¥¯ÄÉ²Ã
      *  01.00.07    ¤Ò¤µ¤Ê¤¬     03/07/29  ¥Á¥§¥Ã¥¯ÆâÍÆÁ´·ï°õºþÄÉ²Ã
      *  01.00.08    ¤Ò¤µ¤Ê¤¬     03/08/26  ±¡³°½èÊý¡¢¼«Èñ¤Î»Ø¼¨ÄÉ²Ã
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
                   07  SPA-GMN-NYUGAIKBN-DSP.
                       09  SPA-GMN-NYUGAIKBN      PIC X(01).
                       09  SPA-GMN-NYUGAIKBN-AKI  PIC X(01).
                       09  SPA-GMN-NYUGAIKBN-MSG  PIC X(14).
                   07  SPA-GMN-TBLG.
                       09  SPA-GMN-TBL1       OCCURS  5.
                           11  SPA-GMN-NYUGAIKBN-K    PIC X(01).
                           11  SPA-GMN-NYUGAIKBN-FL   PIC X(01).
                           11  SPA-GMN-NYUGAIKBN-M    PIC X(14).
                       09  SPA-GMN-TBL2       OCCURS  20.
                           11  SPA-GMN-MSG            PIC X(40).
                           11  SPA-GMN-CHKKBN         PIC X(20).
                           11  SPA-GMN-TBL3       OCCURS  5.
                               13  SPA-GMN-CHKKBN-K   PIC X(01).
                               13  SPA-GMN-CHKKBN-FL  PIC X(01).
                               13  SPA-GMN-CHKKBN-M   PIC X(18).
               05  SPA-NAI-AREA.
                   07  SPA-NAI-MOTOPG         PIC X(08).
      *
       01  SPA-WRK-AREA.
           03  SPA-WRK-WRK         PIC X(82).
           03  SPA-WRK-TBLG        PIC X(3200).
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
           03  FLG-ERR             PIC 9(01).
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
           03  T-MESSAGE-800-51    PIC X(18)   VALUE
               "³ÎÇ§              ".
           03  T-MESSAGE-800-52    PIC X(18)   VALUE
               "³ÎÇ§  Á´°õºþ      ".
           03  T-MESSAGE-800-53    PIC X(18)   VALUE
               "±¡³°½èÊý¤ò´Þ¤à    ".
           03  T-MESSAGE-800-54    PIC X(18)   VALUE
               "±¡³°½èÊý  ¤Î¤ß    ".
           03  T-MESSAGE-800-55    PIC X(18)   VALUE
               "¼«ÈñÊÝ¸±´µ¼Ô¤ò´Þ¤à".
           03  T-MESSAGE-800-56    PIC X(18)   VALUE
               "¼«ÈñÊÝ¸±´µ¼Ô  ¤Î¤ß".
           03  T-MESSAGE-900-01    PIC X(10)   VALUE
               "Æþ±¡      ".
           03  T-MESSAGE-900-02    PIC X(10)   VALUE
               "³°Íè      ".
           03  T-MESSAGE-900-03    PIC X(40)   VALUE
               "ÊÝ¸±¼ÔÈÖ¹æÈ´¤±¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²".
           03  T-MESSAGE-900-04    PIC X(40)   VALUE
               "ÈïÊÝ¸±¼Ôµ­¹æ¡¦ÈÖ¹æÈ´¤±¡²¡²¡²¡²¡²¡²¡²¡²¡²".
           03  T-MESSAGE-900-05    PIC X(40)   VALUE
               "¸øÈñÉéÃ´¼ÔÈÖ¹æ¡¦¼õµë¼ÔÈÖ¹æÈ´¤±¡²¡²¡²¡²¡²".
           03  T-MESSAGE-900-06    PIC X(40)   VALUE
               "ÊÝ¸±Å¬ÍÑÇ¯Îð¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²".
           03  T-MESSAGE-900-07    PIC X(40)   VALUE
               "ÉÂÌ¾È´¤±¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²".
           03  T-MESSAGE-900-08    PIC X(40)   VALUE
               "¿ÇÎÅ³«»ÏÆü¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²".
           03  T-MESSAGE-900-09    PIC X(40)   VALUE
               "µ¿¤¤ÉÂÌ¾¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²".
           03  T-MESSAGE-900-10    PIC X(40)   VALUE
               "ÌôºÞ¤ÈÉÂÌ¾¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²".
           03  T-MESSAGE-900-11    PIC X(40)   VALUE
               "¿ÇÎÅ¹Ô°Ù¤ÈÉÂÌ¾¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²".
           03  T-MESSAGE-900-12    PIC X(40)   VALUE
               "ÌôºÞ¤È¶Ø´÷¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²".
           03  T-MESSAGE-900-13    PIC X(40)   VALUE
               "Ê»ÍÑ¶Ø´÷¤ÎÌôºÞ¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²".
           03  T-MESSAGE-900-14    PIC X(40)   VALUE
               "Ê»ÍÑ»»Äê¤Î¿ÇÎÅ¹Ô°Ù¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²".
           03  T-MESSAGE-900-15    PIC X(40)   VALUE
               "¼ÂÆü¿ô¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²".
           03  T-MESSAGE-900-16    PIC X(40)   VALUE
               "´µ¼Ô»áÌ¾¡¦´µ¼ÔÉÂÌ¾¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²".
           03  T-MESSAGE-900-17    PIC X(40)   VALUE
               "ÊÝ¸±ÁÈ¹ç¤»Í­¸ú´ü´Ö¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²".
           03  T-MESSAGE-900-18    PIC X(40)   VALUE
               "ÉÂÌ¾¥³¡¼¥ÉÈ´¤±¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²".
           03  T-MESSAGE-900-19    PIC X(40)   VALUE
               "±¡³°½èÊý¤Î½èÍý¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²".
           03  T-MESSAGE-900-20    PIC X(40)   VALUE
               "¼«ÈñÊÝ¸±´µ¼Ô¤Î½èÍý¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²¡²".
           03  T-MESSAGE-900-21    PIC X(40)   VALUE
               "1234567890123456789012345678901234567890".
           03  T-MESSAGE-900-22    PIC X(40)   VALUE
               "1234567890123456789012345678901234567890".
           03  T-MESSAGE-900-23    PIC X(40)   VALUE
               "1234567890123456789012345678901234567890".
           03  T-MESSAGE-900-24    PIC X(40)   VALUE
               "1234567890123456789012345678901234567890".
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
                   MOVE    SPACE               TO  SPA-GMN-KBN
               END-IF
               IF  (SPA-MOTOPG        =   "D99")        AND
                   (SPA-GMN-RUN   NOT =   ZERO  AND  2)
                   MOVE    "CHK"               TO  WRK-JOBKANRI-MODE
                   INITIALIZE                      JOBKANRI-REC
                   MOVE    1                   TO  JOB-JOBID
                   MOVE    "ORCBSD1"           TO  JOB-SHELLID
                   MOVE    SPA-TERMID          TO  JOB-TERMID
                   CALL    "ORCSJOB"           USING
                                               WRK-JOBKANRI-AREA
                                               JOBKANRI-REC
                   IF  WRK-JOBKANRI-RETURN   =   ZERO
                       IF  JOB-ENDYMD   NOT =   SPACE
                           MOVE    ZERO                TO  SPA-GMN-RUN
                       END-IF
                   END-IF
               END-IF
               MOVE    SPACE               TO  SPA-MOTOPG
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
           MOVE    1                      TO  SPA-GMN-CUR.
      *
           MOVE    SPACE                  TO  SPA-GMN-TBLG.
           MOVE    "2"                    TO  SPA-GMN-NYUGAIKBN.
           MOVE    T-MESSAGE-900-02       TO  SPA-GMN-NYUGAIKBN-MSG.
           MOVE    "1"                    TO  SPA-GMN-NYUGAIKBN-K (1).
           MOVE    "2"                    TO  SPA-GMN-NYUGAIKBN-K (2).
           MOVE    T-MESSAGE-900-01       TO  SPA-GMN-NYUGAIKBN-M (1).
           MOVE    T-MESSAGE-900-02       TO  SPA-GMN-NYUGAIKBN-M (2).
           MOVE    T-MESSAGE-900-03       TO  SPA-GMN-MSG (1).
           MOVE    "1"                    TO  SPA-GMN-CHKKBN-K (1 1).
           MOVE    "2"                    TO  SPA-GMN-CHKKBN-K (1 2).
           MOVE    T-MESSAGE-800-51       TO  SPA-GMN-CHKKBN-M (1 1).
           MOVE    T-MESSAGE-800-52       TO  SPA-GMN-CHKKBN-M (1 2).
           MOVE    T-MESSAGE-900-04       TO  SPA-GMN-MSG (2).
           MOVE    "1"                    TO  SPA-GMN-CHKKBN-K (2 1).
           MOVE    "2"                    TO  SPA-GMN-CHKKBN-K (2 2).
           MOVE    T-MESSAGE-800-51       TO  SPA-GMN-CHKKBN-M (2 1).
           MOVE    T-MESSAGE-800-52       TO  SPA-GMN-CHKKBN-M (2 2).
           MOVE    T-MESSAGE-900-05       TO  SPA-GMN-MSG (3).
           MOVE    "1"                    TO  SPA-GMN-CHKKBN-K (3 1).
           MOVE    "2"                    TO  SPA-GMN-CHKKBN-K (3 2).
           MOVE    T-MESSAGE-800-51       TO  SPA-GMN-CHKKBN-M (3 1).
           MOVE    T-MESSAGE-800-52       TO  SPA-GMN-CHKKBN-M (3 2).
           MOVE    T-MESSAGE-900-06       TO  SPA-GMN-MSG (4).
           MOVE    "1"                    TO  SPA-GMN-CHKKBN-K (4 1).
           MOVE    "2"                    TO  SPA-GMN-CHKKBN-K (4 2).
           MOVE    T-MESSAGE-800-51       TO  SPA-GMN-CHKKBN-M (4 1).
           MOVE    T-MESSAGE-800-52       TO  SPA-GMN-CHKKBN-M (4 2).
           MOVE    T-MESSAGE-900-07       TO  SPA-GMN-MSG (5).
           MOVE    "1"                    TO  SPA-GMN-CHKKBN-K (5 1).
           MOVE    "2"                    TO  SPA-GMN-CHKKBN-K (5 2).
           MOVE    T-MESSAGE-800-51       TO  SPA-GMN-CHKKBN-M (5 1).
           MOVE    T-MESSAGE-800-52       TO  SPA-GMN-CHKKBN-M (5 2).
           MOVE    T-MESSAGE-900-08       TO  SPA-GMN-MSG (6).
           MOVE    "1"                    TO  SPA-GMN-CHKKBN-K (6 1).
           MOVE    "2"                    TO  SPA-GMN-CHKKBN-K (6 2).
           MOVE    T-MESSAGE-800-51       TO  SPA-GMN-CHKKBN-M (6 1).
           MOVE    T-MESSAGE-800-52       TO  SPA-GMN-CHKKBN-M (6 2).
           MOVE    T-MESSAGE-900-09       TO  SPA-GMN-MSG (7).
           MOVE    "1"                    TO  SPA-GMN-CHKKBN-K (7 1).
           MOVE    "2"                    TO  SPA-GMN-CHKKBN-K (7 2).
           MOVE    T-MESSAGE-800-51       TO  SPA-GMN-CHKKBN-M (7 1).
           MOVE    T-MESSAGE-800-52       TO  SPA-GMN-CHKKBN-M (7 2).
           MOVE    T-MESSAGE-900-10       TO  SPA-GMN-MSG (8).
           MOVE    "1"                    TO  SPA-GMN-CHKKBN-K (8 1).
           MOVE    "2"                    TO  SPA-GMN-CHKKBN-K (8 2).
           MOVE    T-MESSAGE-800-51       TO  SPA-GMN-CHKKBN-M (8 1).
           MOVE    T-MESSAGE-800-52       TO  SPA-GMN-CHKKBN-M (8 2).
           MOVE    T-MESSAGE-900-11       TO  SPA-GMN-MSG (9).
           MOVE    "1"                    TO  SPA-GMN-CHKKBN-K (9 1).
           MOVE    "2"                    TO  SPA-GMN-CHKKBN-K (9 2).
           MOVE    T-MESSAGE-800-51       TO  SPA-GMN-CHKKBN-M (9 1).
           MOVE    T-MESSAGE-800-52       TO  SPA-GMN-CHKKBN-M (9 2).
           MOVE    T-MESSAGE-900-13       TO  SPA-GMN-MSG (10).
           MOVE    "1"                    TO  SPA-GMN-CHKKBN-K (10 1).
           MOVE    "2"                    TO  SPA-GMN-CHKKBN-K (10 2).
           MOVE    T-MESSAGE-800-51       TO  SPA-GMN-CHKKBN-M (10 1).
           MOVE    T-MESSAGE-800-52       TO  SPA-GMN-CHKKBN-M (10 2).
           MOVE    T-MESSAGE-900-14       TO  SPA-GMN-MSG (11).
           MOVE    "1"                    TO  SPA-GMN-CHKKBN-K (11 1).
           MOVE    "2"                    TO  SPA-GMN-CHKKBN-K (11 2).
           MOVE    T-MESSAGE-800-51       TO  SPA-GMN-CHKKBN-M (11 1).
           MOVE    T-MESSAGE-800-52       TO  SPA-GMN-CHKKBN-M (11 2).
           MOVE    T-MESSAGE-900-15       TO  SPA-GMN-MSG (12).
           MOVE    "1"                    TO  SPA-GMN-CHKKBN-K (12 1).
           MOVE    "2"                    TO  SPA-GMN-CHKKBN-K (12 2).
           MOVE    T-MESSAGE-800-51       TO  SPA-GMN-CHKKBN-M (12 1).
           MOVE    T-MESSAGE-800-52       TO  SPA-GMN-CHKKBN-M (12 2).
           MOVE    T-MESSAGE-900-16       TO  SPA-GMN-MSG (13).
           MOVE    "1"                    TO  SPA-GMN-CHKKBN-K (13 1).
           MOVE    "2"                    TO  SPA-GMN-CHKKBN-K (13 2).
           MOVE    T-MESSAGE-800-51       TO  SPA-GMN-CHKKBN-M (13 1).
           MOVE    T-MESSAGE-800-52       TO  SPA-GMN-CHKKBN-M (13 2).
           MOVE    T-MESSAGE-900-17       TO  SPA-GMN-MSG (14).
           MOVE    "1"                    TO  SPA-GMN-CHKKBN-K (14 1).
           MOVE    "2"                    TO  SPA-GMN-CHKKBN-K (14 2).
           MOVE    T-MESSAGE-800-51       TO  SPA-GMN-CHKKBN-M (14 1).
           MOVE    T-MESSAGE-800-52       TO  SPA-GMN-CHKKBN-M (14 2).
           MOVE    T-MESSAGE-900-18       TO  SPA-GMN-MSG (15).
           MOVE    "1"                    TO  SPA-GMN-CHKKBN-K (15 1).
           MOVE    "2"                    TO  SPA-GMN-CHKKBN-K (15 2).
           MOVE    T-MESSAGE-800-51       TO  SPA-GMN-CHKKBN-M (15 1).
           MOVE    T-MESSAGE-800-52       TO  SPA-GMN-CHKKBN-M (15 2).
           MOVE    T-MESSAGE-900-20       TO  SPA-GMN-MSG (19).
           MOVE    "1"                    TO  SPA-GMN-CHKKBN-K (19 1).
           MOVE    "2"                    TO  SPA-GMN-CHKKBN-K (19 2).
           MOVE    T-MESSAGE-800-55       TO  SPA-GMN-CHKKBN-M (19 1).
           MOVE    T-MESSAGE-800-56       TO  SPA-GMN-CHKKBN-M (19 2).
           MOVE    T-MESSAGE-900-19       TO  SPA-GMN-MSG (20).
           MOVE    "1"                    TO  SPA-GMN-CHKKBN-K (20 1).
           MOVE    "2"                    TO  SPA-GMN-CHKKBN-K (20 2).
           MOVE    T-MESSAGE-800-53       TO  SPA-GMN-CHKKBN-M (20 1).
           MOVE    T-MESSAGE-800-54       TO  SPA-GMN-CHKKBN-M (20 2).
           IF  SPA-MOTOPG   =   "XA01"  OR  "XB01"
               MOVE    LNK-SCRSPA              TO  SPA-D01-AREA
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
           IF  (SPA-SRYYMD      NOT =   SPACE)  AND
               (SPA-NYUGAIKBN   NOT =   SPACE)
               MOVE    SPA-HOSPID      TO  SPA-GMN-HOSPID
               MOVE    SPA-SRYYMD      TO  SPA-GMN-SRYYMD-S
               PERFORM VARYING IDX1  FROM  1  BY 1
                       UNTIL   IDX1  >     D01-NYUGAIKBN-COUNT
                   IF  SPA-NYUGAIKBN  =  SPA-GMN-NYUGAIKBN-K (IDX1)
                       MOVE    SPA-GMN-TBL1 (IDX1)
                                              TO  SPA-GMN-NYUGAIKBN-DSP
                   END-IF
               END-PERFORM
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
                       MOVE    1                  TO  FLG-END
                   END-IF
               WHEN    "CLICKED"       ALSO    "B13"
                   PERFORM 530-RIDSET2-SEC
               WHEN    "CLICKED"       ALSO    "SRYYM"
                   IF  SPA-GMN-RUN   =   ZERO   OR   2
                       PERFORM T-000-YMDCHEK-SEC
                   END-IF
               WHEN    "CHANGED"       ALSO    "NYUGAIKBN"
                   IF  SPA-GMN-RUN   =   ZERO   OR   2
                       PERFORM T-000-NYUGAICHEK-SEC
                   END-IF
               WHEN    "CHANGED"       ALSO    "CHKKBN01"
               WHEN    "CHANGED"       ALSO    "CHKKBN02"
               WHEN    "CHANGED"       ALSO    "CHKKBN03"
               WHEN    "CHANGED"       ALSO    "CHKKBN04"
               WHEN    "CHANGED"       ALSO    "CHKKBN05"
               WHEN    "CHANGED"       ALSO    "CHKKBN06"
               WHEN    "CHANGED"       ALSO    "CHKKBN07"
               WHEN    "CHANGED"       ALSO    "CHKKBN08"
               WHEN    "CHANGED"       ALSO    "CHKKBN09"
               WHEN    "CHANGED"       ALSO    "CHKKBN10"
               WHEN    "CHANGED"       ALSO    "CHKKBN11"
               WHEN    "CHANGED"       ALSO    "CHKKBN12"
               WHEN    "CHANGED"       ALSO    "CHKKBN13"
               WHEN    "CHANGED"       ALSO    "CHKKBN14"
               WHEN    "CHANGED"       ALSO    "CHKKBN15"
               WHEN    "CHANGED"       ALSO    "CHKKBN16"
               WHEN    "CHANGED"       ALSO    "CHKKBN17"
               WHEN    "CHANGED"       ALSO    "CHKKBN18"
               WHEN    "CHANGED"       ALSO    "CHKKBN19"
               WHEN    "CHANGED"       ALSO    "CHKKBN20"
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
                   PERFORM T-000-NYUGAICHEK-SEC
               WHEN    "ACTIVATE"      ALSO    "CHKKBN01"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN02"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN03"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN04"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN05"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN06"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN07"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN08"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN09"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN10"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN11"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN12"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN13"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN14"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN15"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN16"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN17"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN18"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN19"
               WHEN    "ACTIVATE"      ALSO    "CHKKBN20"
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
           MOVE    SPA-GMN-NYUGAIKBN-DSP   TO  D01-NYUGAIKBN.
           MOVE    ZERO                    TO  D01-NYUGAIKBN-COUNT.
      *
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >     5
               IF  SPA-GMN-TBL1 (IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL1 (IDX1)
                                         TO  D01-NYUGAIKBN-ITEM (IDX1)
                   MOVE    IDX1          TO  D01-NYUGAIKBN-COUNT
               END-IF
           END-PERFORM.
      *
           MOVE    SPA-GMN-MSG (1)        TO  D01-CHKMSG1.
           MOVE    SPA-GMN-MSG (2)        TO  D01-CHKMSG2.
           MOVE    SPA-GMN-MSG (3)        TO  D01-CHKMSG3.
           MOVE    SPA-GMN-MSG (4)        TO  D01-CHKMSG4.
           MOVE    SPA-GMN-MSG (5)        TO  D01-CHKMSG5.
           MOVE    SPA-GMN-MSG (6)        TO  D01-CHKMSG6.
           MOVE    SPA-GMN-MSG (7)        TO  D01-CHKMSG7.
           MOVE    SPA-GMN-MSG (8)        TO  D01-CHKMSG8.
           MOVE    SPA-GMN-MSG (9)        TO  D01-CHKMSG9.
           MOVE    SPA-GMN-MSG (10)       TO  D01-CHKMSG10.
           MOVE    SPA-GMN-MSG (11)       TO  D01-CHKMSG11.
           MOVE    SPA-GMN-MSG (12)       TO  D01-CHKMSG12.
           MOVE    SPA-GMN-MSG (13)       TO  D01-CHKMSG13.
           MOVE    SPA-GMN-MSG (14)       TO  D01-CHKMSG14.
           MOVE    SPA-GMN-MSG (15)       TO  D01-CHKMSG15.
           MOVE    SPA-GMN-MSG (16)       TO  D01-CHKMSG16.
           MOVE    SPA-GMN-MSG (17)       TO  D01-CHKMSG17.
           MOVE    SPA-GMN-MSG (18)       TO  D01-CHKMSG18.
           MOVE    SPA-GMN-MSG (19)       TO  D01-CHKMSG19.
           MOVE    SPA-GMN-MSG (20)       TO  D01-CHKMSG20.
      *
           MOVE    SPA-GMN-CHKKBN (1)     TO  D01-CHKKBN01.
           MOVE    SPA-GMN-CHKKBN (2)     TO  D01-CHKKBN02.
           MOVE    SPA-GMN-CHKKBN (3)     TO  D01-CHKKBN03.
           MOVE    SPA-GMN-CHKKBN (4)     TO  D01-CHKKBN04.
           MOVE    SPA-GMN-CHKKBN (5)     TO  D01-CHKKBN05.
           MOVE    SPA-GMN-CHKKBN (6)     TO  D01-CHKKBN06.
           MOVE    SPA-GMN-CHKKBN (7)     TO  D01-CHKKBN07.
           MOVE    SPA-GMN-CHKKBN (8)     TO  D01-CHKKBN08.
           MOVE    SPA-GMN-CHKKBN (9)     TO  D01-CHKKBN09.
           MOVE    SPA-GMN-CHKKBN (10)    TO  D01-CHKKBN10.
           MOVE    SPA-GMN-CHKKBN (11)    TO  D01-CHKKBN11.
           MOVE    SPA-GMN-CHKKBN (12)    TO  D01-CHKKBN12.
           MOVE    SPA-GMN-CHKKBN (13)    TO  D01-CHKKBN13.
           MOVE    SPA-GMN-CHKKBN (14)    TO  D01-CHKKBN14.
           MOVE    SPA-GMN-CHKKBN (15)    TO  D01-CHKKBN15.
           MOVE    SPA-GMN-CHKKBN (16)    TO  D01-CHKKBN16.
           MOVE    SPA-GMN-CHKKBN (17)    TO  D01-CHKKBN17.
           MOVE    SPA-GMN-CHKKBN (18)    TO  D01-CHKKBN18.
           MOVE    SPA-GMN-CHKKBN (19)    TO  D01-CHKKBN19.
           MOVE    SPA-GMN-CHKKBN (20)    TO  D01-CHKKBN20.
           MOVE    ZERO                   TO  D01-CHKKBN01-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN02-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN03-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN04-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN05-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN06-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN07-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN08-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN09-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN10-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN11-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN12-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN13-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN14-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN15-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN16-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN17-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN18-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN19-COUNT.
           MOVE    ZERO                   TO  D01-CHKKBN20-COUNT.
      *
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >     5
               IF  SPA-GMN-TBL3 (1 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (1 IDX1)
                                           TO  D01-CHKKBN01-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN01-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (2 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (2 IDX1)
                                           TO  D01-CHKKBN02-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN02-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (3 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (3 IDX1)
                                           TO  D01-CHKKBN03-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN03-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (4 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (4 IDX1)
                                           TO  D01-CHKKBN04-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN04-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (5 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (5 IDX1)
                                           TO  D01-CHKKBN05-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN05-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (6 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (6 IDX1)
                                           TO  D01-CHKKBN06-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN06-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (7 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (7 IDX1)
                                           TO  D01-CHKKBN07-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN07-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (8 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (8 IDX1)
                                           TO  D01-CHKKBN08-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN08-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (9 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (9 IDX1)
                                           TO  D01-CHKKBN09-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN09-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (10 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (10 IDX1)
                                           TO  D01-CHKKBN10-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN10-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (11 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (11 IDX1)
                                           TO  D01-CHKKBN11-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN11-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (12 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (12 IDX1)
                                           TO  D01-CHKKBN12-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN12-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (13 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (13 IDX1)
                                           TO  D01-CHKKBN13-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN13-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (14 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (14 IDX1)
                                           TO  D01-CHKKBN14-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN14-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (15 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (15 IDX1)
                                           TO  D01-CHKKBN15-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN15-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (16 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (16 IDX1)
                                           TO  D01-CHKKBN16-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN16-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (17 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (17 IDX1)
                                           TO  D01-CHKKBN17-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN17-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (18 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (18 IDX1)
                                           TO  D01-CHKKBN18-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN18-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (19 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (19 IDX1)
                                           TO  D01-CHKKBN19-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN19-COUNT
               END-IF
               IF  SPA-GMN-TBL3 (20 IDX1)  NOT =  SPACE
                   MOVE    SPA-GMN-TBL3 (20 IDX1)
                                           TO  D01-CHKKBN20-ITEM (IDX1)
                   MOVE    IDX1            TO  D01-CHKKBN20-COUNT
               END-IF
           END-PERFORM
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
                   MOVE    "CHKKBN01"      TO  MCP-WIDGET
               WHEN    04
                   MOVE    "CHKKBN02"      TO  MCP-WIDGET
               WHEN    05
                   MOVE    "CHKKBN03"      TO  MCP-WIDGET
               WHEN    06
                   MOVE    "CHKKBN04"      TO  MCP-WIDGET
               WHEN    07
                   MOVE    "CHKKBN05"      TO  MCP-WIDGET
               WHEN    08
                   MOVE    "CHKKBN06"      TO  MCP-WIDGET
               WHEN    09
                   MOVE    "CHKKBN07"      TO  MCP-WIDGET
               WHEN    10
                   MOVE    "CHKKBN08"      TO  MCP-WIDGET
               WHEN    11
                   MOVE    "CHKKBN09"      TO  MCP-WIDGET
               WHEN    12
                   MOVE    "CHKKBN10"      TO  MCP-WIDGET
               WHEN    13
                   MOVE    "CHKKBN11"      TO  MCP-WIDGET
               WHEN    14
                   MOVE    "CHKKBN12"      TO  MCP-WIDGET
               WHEN    15
                   MOVE    "CHKKBN13"      TO  MCP-WIDGET
               WHEN    16
                   MOVE    "CHKKBN14"      TO  MCP-WIDGET
               WHEN    17
                   MOVE    "CHKKBN15"      TO  MCP-WIDGET
               WHEN    18
                   MOVE    "CHKKBN16"      TO  MCP-WIDGET
               WHEN    19
                   MOVE    "CHKKBN17"      TO  MCP-WIDGET
               WHEN    20
                   MOVE    "CHKKBN18"      TO  MCP-WIDGET
               WHEN    21
                   MOVE    "CHKKBN19"      TO  MCP-WIDGET
               WHEN    22
                   MOVE    "CHKKBN20"      TO  MCP-WIDGET
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
                   MOVE    JOB-JOBID          TO  D99-RENNUM  (1)
                   MOVE    JOB-SHELLMSG       TO  D99-SHORINM (1)
                   MOVE    JOB-STARTTIME(1:2) TO  WRK-HH
                   MOVE    JOB-STARTTIME(3:2) TO  WRK-MM
                   MOVE    JOB-STARTTIME(5:2) TO  WRK-SS
                   MOVE    WRK-HENTIME        TO  D99-STARTTIME (1)
                   MOVE    JOB-ENDTIME(1:2)   TO  WRK-HH
                   MOVE    JOB-ENDTIME(3:2)   TO  WRK-MM
                   MOVE    JOB-ENDTIME(5:2)   TO  WRK-SS
                   MOVE    WRK-HENTIME        TO  D99-ENDTIME (1)
                   MOVE    JOB-UPDCNT         TO  WRK-PAGE
                   MOVE    WRK-PAGE           TO  D99-PAGE    (1)
                   MOVE    JOB-YOBI           TO  D99-ERRMSG  (1)
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
       T-000-CHEKSETT-EXT.
           EXIT.
      *
      *****************************************************************
      *    Æþ³°¶èÊ¬ ³ÎÇ§½èÍý
      *****************************************************************
       T-000-NYUGAICHEK-SEC              SECTION.
      *
           MOVE    SPACE              TO  SPA-GMN-NYUGAIKBN-DSP.
           MOVE    1                  TO  FLG-ERR.
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >     D01-NYUGAIKBN-COUNT
               IF  D01-NYUGAIKBN(1:1)  =  SPA-GMN-NYUGAIKBN-K (IDX1)
                   MOVE    SPA-GMN-TBL1 (IDX1)
                                              TO  SPA-GMN-NYUGAIKBN-DSP
                   MOVE    ZERO               TO  FLG-ERR
               END-IF
           END-PERFORM.
      *
           IF  FLG-ERR  =  ZERO
               MOVE    23                  TO  SPA-GMN-CUR
               PERFORM VARYING IDX1  FROM  1  BY 1
                       UNTIL   IDX1  >    20
                   IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                       COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                       MOVE    21              TO  IDX1
                   END-IF
               END-PERFORM
           ELSE
               MOVE    "0001"              TO  DERR-ERRCODE
               MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
               MOVE    "B01"               TO  MCP-WIDGET
               MOVE    "D01"               TO  SPA-MOTOPG
               MOVE    "DERR"              TO  SPA-SAKIPG
               MOVE    "NEW"               TO  MCP-PUTTYPE
               MOVE    "DERR"              TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    2                   TO  SPA-GMN-CUR
               MOVE    1                   TO  FLG-END
           END-IF.
      *
       T-000-NYUGAICHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼Â¹Ô¹àÌÜ ³ÎÇ§½èÍý
      *****************************************************************
       T-000-CHEKCHEK-SEC                SECTION.
      *
           EVALUATE    MCP-WIDGET
             WHEN    "CHKKBN01"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (1)
                 IF  SPA-GMN-MSG (1)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN01(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN01-COUNT
                             IF  D01-CHKKBN01(1:1) =
                                           SPA-GMN-CHKKBN-K (1 IDX1)
                                 MOVE    SPA-GMN-TBL3 (1 IDX1)
                                                TO  SPA-GMN-CHKKBN (1)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  2  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    3                   TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
                 END-IF
             WHEN    "CHKKBN02"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (2)
                 IF  SPA-GMN-MSG (2)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN02(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN02-COUNT
                             IF  D01-CHKKBN02(1:1) =
                                           SPA-GMN-CHKKBN-K (2 IDX1)
                                 MOVE    SPA-GMN-TBL3 (2 IDX1)
                                                TO  SPA-GMN-CHKKBN (2)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  3  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    4                   TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
                 END-IF
             WHEN    "CHKKBN03"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (3)
                 IF  SPA-GMN-MSG (3)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN03(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN03-COUNT
                             IF  D01-CHKKBN03(1:1) =
                                           SPA-GMN-CHKKBN-K (3 IDX1)
                                 MOVE    SPA-GMN-TBL3 (3 IDX1)
                                                TO  SPA-GMN-CHKKBN (3)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  4  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    5                   TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
                 END-IF
             WHEN    "CHKKBN04"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (4)
                 IF  SPA-GMN-MSG (4)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN04(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN04-COUNT
                             IF  D01-CHKKBN04(1:1) =
                                           SPA-GMN-CHKKBN-K (4 IDX1)
                                 MOVE    SPA-GMN-TBL3 (4 IDX1)
                                                TO  SPA-GMN-CHKKBN (4)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  5  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    6                   TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
                 END-IF
             WHEN    "CHKKBN05"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (5)
                 IF  SPA-GMN-MSG (5)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN05(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN05-COUNT
                             IF  D01-CHKKBN05(1:1) =
                                           SPA-GMN-CHKKBN-K (5 IDX1)
                                 MOVE    SPA-GMN-TBL3 (5 IDX1)
                                                TO  SPA-GMN-CHKKBN(5)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  6  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    7                   TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
                 END-IF
             WHEN    "CHKKBN06"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (6)
                 IF  SPA-GMN-MSG (6)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN06(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN06-COUNT
                             IF  D01-CHKKBN06(1:1) =
                                           SPA-GMN-CHKKBN-K (6 IDX1)
                                 MOVE    SPA-GMN-TBL3 (6 IDX1)
                                                TO  SPA-GMN-CHKKBN (6)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  7  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    8                   TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
                 END-IF
             WHEN    "CHKKBN07"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (7)
                 IF  SPA-GMN-MSG (7)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN07(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN07-COUNT
                             IF  D01-CHKKBN07(1:1) =
                                           SPA-GMN-CHKKBN-K (7 IDX1)
                                 MOVE    SPA-GMN-TBL3 (7 IDX1)
                                                TO  SPA-GMN-CHKKBN (7)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  8  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    9                   TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
                 END-IF
             WHEN    "CHKKBN08"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (8)
                 IF  SPA-GMN-MSG (8)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN08(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN08-COUNT
                             IF  D01-CHKKBN08(1:1) =
                                           SPA-GMN-CHKKBN-K (8 IDX1)
                                 MOVE    SPA-GMN-TBL3 (8 IDX1)
                                                TO  SPA-GMN-CHKKBN (8)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  9  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    10                  TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
                 END-IF
             WHEN    "CHKKBN09"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (9)
                 IF  SPA-GMN-MSG (9)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN09(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN09-COUNT
                             IF  D01-CHKKBN09(1:1) =
                                           SPA-GMN-CHKKBN-K (9 IDX1)
                                 MOVE    SPA-GMN-TBL3 (9 IDX1)
                                                TO  SPA-GMN-CHKKBN (9)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  10  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    11                  TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
                 END-IF
             WHEN    "CHKKBN10"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (10)
                 IF  SPA-GMN-MSG (10)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN10(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN10-COUNT
                             IF  D01-CHKKBN10(1:1) =
                                           SPA-GMN-CHKKBN-K (10 IDX1)
                                 MOVE    SPA-GMN-TBL3 (10 IDX1)
                                                TO  SPA-GMN-CHKKBN(10)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  11  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    12                  TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
                 END-IF
             WHEN    "CHKKBN11"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (11)
                 IF  SPA-GMN-MSG (11)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN11(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN11-COUNT
                             IF  D01-CHKKBN11(1:1) =
                                           SPA-GMN-CHKKBN-K (11 IDX1)
                                 MOVE    SPA-GMN-TBL3 (11 IDX1)
                                                TO  SPA-GMN-CHKKBN (11)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  12  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    13                  TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
                 END-IF
             WHEN    "CHKKBN12"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (12)
                 IF  SPA-GMN-MSG (12)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN12(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN12-COUNT
                             IF  D01-CHKKBN12(1:1) =
                                           SPA-GMN-CHKKBN-K (12 IDX1)
                                 MOVE    SPA-GMN-TBL3 (12 IDX1)
                                                TO  SPA-GMN-CHKKBN (12)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  13  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    14                  TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
                 END-IF
             WHEN    "CHKKBN13"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (13)
                 IF  SPA-GMN-MSG (13)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN13(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN13-COUNT
                             IF  D01-CHKKBN13(1:1) =
                                           SPA-GMN-CHKKBN-K (13 IDX1)
                                 MOVE    SPA-GMN-TBL3 (13 IDX1)
                                                TO  SPA-GMN-CHKKBN (13)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  14  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    15                  TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
                 END-IF
             WHEN    "CHKKBN14"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (14)
                 IF  SPA-GMN-MSG (14)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN14(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN14-COUNT
                             IF  D01-CHKKBN14(1:1) =
                                           SPA-GMN-CHKKBN-K (14 IDX1)
                                 MOVE    SPA-GMN-TBL3 (14 IDX1)
                                                TO  SPA-GMN-CHKKBN (14)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  15  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    16                  TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
                 END-IF
             WHEN    "CHKKBN15"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (15)
                 IF  SPA-GMN-MSG (15)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN15(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN15-COUNT
                             IF  D01-CHKKBN15(1:1) =
                                           SPA-GMN-CHKKBN-K (15 IDX1)
                                 MOVE    SPA-GMN-TBL3 (15 IDX1)
                                                TO  SPA-GMN-CHKKBN (15)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  16  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    17                  TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
                 END-IF
             WHEN    "CHKKBN16"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (16)
                 IF  SPA-GMN-MSG (16)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN16(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN16-COUNT
                             IF  D01-CHKKBN16(1:1) =
                                           SPA-GMN-CHKKBN-K (16 IDX1)
                                 MOVE    SPA-GMN-TBL3 (16 IDX1)
                                                TO  SPA-GMN-CHKKBN (16)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  17  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    18                  TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
                 END-IF
             WHEN    "CHKKBN17"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (17)
                 IF  SPA-GMN-MSG (17)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN17(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN17-COUNT
                             IF  D01-CHKKBN17(1:1) =
                                           SPA-GMN-CHKKBN-K (17 IDX1)
                                 MOVE    SPA-GMN-TBL3 (17 IDX1)
                                                TO  SPA-GMN-CHKKBN (17)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  18  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    19                  TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
             WHEN    "CHKKBN18"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (18)
                 IF  SPA-GMN-MSG (18)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN18(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN18-COUNT
                             IF  D01-CHKKBN18(1:1) =
                                           SPA-GMN-CHKKBN-K (18 IDX1)
                                 MOVE    SPA-GMN-TBL3 (18 IDX1)
                                                TO  SPA-GMN-CHKKBN (18)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  19  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    20                  TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
                 END-IF
             WHEN    "CHKKBN19"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (19)
                 IF  SPA-GMN-MSG (19)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN19(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN19-COUNT
                             IF  D01-CHKKBN19(1:1) =
                                           SPA-GMN-CHKKBN-K (19 IDX1)
                                 MOVE    SPA-GMN-TBL3 (19 IDX1)
                                                TO  SPA-GMN-CHKKBN (19)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         PERFORM VARYING IDX1  FROM  20  BY 1
                                 UNTIL   IDX1  >    20
                             IF  SPA-GMN-MSG (IDX1)  NOT =  SPACE
                                 COMPUTE SPA-GMN-CUR  =  IDX1  +  2
                                 MOVE    21       TO  IDX1
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    21                  TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
                 END-IF
             WHEN    "CHKKBN20"
                 MOVE    23                     TO  SPA-GMN-CUR
                 MOVE    SPACE                  TO  SPA-GMN-CHKKBN (20)
                 IF  SPA-GMN-MSG (20)  NOT =  SPACE
                     MOVE    1                      TO  FLG-ERR
                     IF  D01-CHKKBN20(1:1)  NOT =  SPACE
                         PERFORM VARYING IDX1  FROM  1  BY 1
                                 UNTIL   IDX1  >     D01-CHKKBN20-COUNT
                             IF  D01-CHKKBN20(1:1) =
                                           SPA-GMN-CHKKBN-K (20 IDX1)
                                 MOVE    SPA-GMN-TBL3 (20 IDX1)
                                                TO  SPA-GMN-CHKKBN(20)
                                 MOVE    ZERO   TO  FLG-ERR
                             END-IF
                         END-PERFORM
                     ELSE
                         MOVE    ZERO   TO  FLG-ERR
                     END-IF
                     IF  FLG-ERR  =  ZERO
                         CONTINUE
                     ELSE
                         MOVE    "0001"              TO  DERR-ERRCODE
                         MOVE    T-MESSAGE-800-06    TO  DERR-ERRMSG
                         MOVE    "B01"               TO  MCP-WIDGET
                         MOVE    "D01"               TO  SPA-MOTOPG
                         MOVE    "DERR"              TO  SPA-SAKIPG
                         MOVE    "NEW"               TO  MCP-PUTTYPE
                         MOVE    "DERR"              TO  MCP-WINDOW
                         PERFORM 900-PUT-WINDOW
                         MOVE    22                  TO  SPA-GMN-CUR
                         MOVE    1                   TO  FLG-END
                     END-IF
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
           MOVE    SPACE                       TO  DID1-REC.
           MOVE    SPA-GMN-HOSPID              TO  DID1-REC.
           WRITE   DID1-REC.
      *      
           MOVE    SPACE                       TO  DID1-REC.
           MOVE    SPA-GMN-SRYYMD(1:6)         TO  DID1-REC(1:6).
           MOVE    SPA-GMN-SRYYMD-S(1:6)       TO  DID1-REC(7:6).
           WRITE   DID1-REC.
      *
           MOVE    SPACE                       TO  DID1-REC.
           MOVE    SPA-GMN-NYUGAIKBN           TO  DID1-REC(1:1).
           MOVE    SPA-GMN-NYUGAIKBN-MSG       TO  DID1-REC(2:10).
           WRITE   DID1-REC.
      *
           MOVE    SPACE                       TO  DID1-REC.
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >    20
               MOVE    SPA-GMN-CHKKBN (IDX1)(1:1)  TO  DID1-REC(IDX1:1)
           END-PERFORM.
           WRITE   DID1-REC.
      *
           INITIALIZE                                ORCSMKPASSAREA.
           MOVE    "scripts/allways/orcbsd01.sh" TO  MKPASS-IN-01.
           CALL    "ORCSMKPASS"               USING  ORCSMKPASSAREA.
           MOVE    MKPASS-OT-01                  TO  SHELL-NAME.
           MOVE    SPA-GMN-SRYYMD-S(1:6)         TO  SHELL-SRYYM.
           MOVE    SPA-TERMID                    TO  SHELL-TERMID
                                                     SHELL-WK-TERMID.
           MOVE    SPA-SYSYMD                    TO  SHELL-SYSYMD.
           MOVE    SPA-OPID                      TO  SHELL-OPID.
           MOVE    ZERO                          TO  SHELL-SYOKBN.
           MOVE    ZERO                          TO  SHELL-RECEKBN.
           MOVE    DID4PARA                      TO  SHELL-ERRFILE.
           MOVE    SHELL-NAME                    TO  SHELLTBL-NAME.
           MOVE    SHELL-ARG1                    TO  SHELLTBL-ARG1.
           MOVE    SHELL-ARG2                    TO  SHELLTBL-ARG2.
           MOVE    SHELL-ARG3                    TO  SHELLTBL-ARG3.
           MOVE    SHELL-ARG4                    TO  SHELLTBL-ARG4.
           MOVE    SHELL-ARG5                    TO  SHELLTBL-ARG5.
           MOVE    SHELLTBL                      TO  MCPDATA-REC.
           MOVE    "SHELL"                       TO  MCP-FUNC.
           MOVE    PATH-SHELL-SHELL              TO  MCP-PATH.
           CALL    "MCPSUB"                      USING
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
