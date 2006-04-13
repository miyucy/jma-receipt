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
       PROGRAM-ID.             ORCHCN04.
      *****************************************************************
      *  ¥·¥¹¥Æ¥àÌ¾        : £Ï£Ò£Ã£Á
      *  ¥µ¥Ö¥·¥¹¥Æ¥àÌ¾    : ´µ¼ÔÅÐÏ¿
      *  ¥³¥ó¥Ý¡¼¥Í¥ó¥ÈÌ¾  : Æþ±¡¿ÇÎÅÈñÌÀºÙ½ñ¡¡°õºþ¡Ê£È£Ã£Î£°£´¡Ë
      *  ´ÉÍý¼Ô            : 
      *  ºîÀ®ÆüÉÕ    ºî¶È¼Ô        µ­½Ò
      *  06/04/12    NACL¡ÝÂ¿¡¹Ç¼  ¿·µ¬ºîÀ®
      *****************************************************************
      *  ¥×¥í¥°¥é¥à½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    °õºþÍÑ¥Ç¡¼¥¿
           SELECT  PRT-FILE        ASSIGN  HC01PARA
                                   FILE    STATUS  IS  STS-PARA.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    °õºþÍÑ¥Ç¡¼¥¿
       FD  PRT-FILE.
           COPY    "HCN04.INC".
      *
       WORKING-STORAGE             SECTION.
      *
      *     °õºþÍÑ¥Ç¡¼¥¿ Ì¾¾ÎÎÎ°è 
           COPY    "CPCOMMONPRT.INC".
      *
      *    ¥Õ¥é¥°ÎÎ°è
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
      *
      *    ¥Õ¥é¥°ÎÎ°è
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-PARA            PIC 9(01).
           03  FLG-JYURRK          PIC 9(01).
           03  FLG-SRYACT          PIC 9(01).
           03  FLG-SRYACCT         PIC 9(01).
           03  FLG-SRYACCTPLUS     PIC 9(01).
           03  FLG-SYUNOU          PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
      *
           03  FLG-SP              PIC 9(01).
           03  FLG-OK              PIC 9(01).
           03  FLG-CHK             PIC 9(01).
           03  FLG-PLUSKBN         PIC 9(01).
      *
      *    Åº»úÎÎ°è
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDXA                PIC 9(04).
           03  IDX2                PIC 9(04).
      *
           03  IDX-JYU             PIC 9(04).
           03  IDX-REN             PIC 9(04).
           03  IDX-ACT             PIC 9(02).
           03  IDX-S               PIC 9(04).
           03  IDX-H               PIC 9(04).
           03  IDX-SYU             PIC 9(04).
           03  IDX-HZN             PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDXM                PIC 9(04).
           03  IDXJ                PIC 9(04).
      *
           03  IDX-STR             PIC 9(02).
           03  IDX-END             PIC 9(02).
      *
      *    ¥·¥¹¥Æ¥àÎÎ°è
       01  SYS-AREA.
           03  SYS-TIME            PIC 9(08).
      *
      *    °ì»þÎÎ°è
       01  WRK-AREA.
      *
           03  WRK-SYMD.
               05  WRK-SYY             PIC 9(04).
               05  WRK-SMM             PIC 9(02).
               05  WRK-SDD             PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WYY             PIC X(03).
               05  WRK-WMM             PIC 9(02).
               05  WRK-WDD             PIC 9(02).
           03  WRK-HENYMDG             PIC X(22).
      *
           03  WRK-SRYYMD              PIC X(08).
      *
           03  WRK-ROOM                PIC X(50).
           03  WRK-ROOMNUM-NAME        PIC X(10).
           03  WRK-SRYKA               PIC X(02).
           03  WRK-SRYKA-MEI           PIC X(30).
           03  WRK-PAGE                PIC 9(03).
           03  WRK-PAGE-CNT            PIC 9(03).
           03  WRK-PAGE-MAX            PIC 9(03).
      *
           03  WRK-KAISU               PIC 9(03).
           03  WRK-SRYKBN              PIC X(02).
           03  WRK-SRYSYUKBN           PIC X(03).
           03  WRK-KINGAKU             PIC S9(11).
           03  WRK-SRYMEI              PIC X(10).
           03  WRK-SRYMEI-OLD          PIC X(10).
      *
           03  WRK-Z119                PIC Z,ZZZ,ZZ9.
           03  WRK-Z119-2              PIC -,---,--9.
           03  WRK-ZZ9                 PIC ZZ9.
           03  WRK-NO                  PIC Z(7).
           03  WRK-WARI                PIC 9(02)V9.
           03  WRK-Z6                  PIC ZZZ.
           03  WRK-Z62                 PIC 9.9.
      *
           03  WRK-HKNCOMBIMEI     PIC X(40).
      *
           03  WRK-DENPNUM             PIC 9(07).
           03  WRK-GRP-DENPNUM         PIC 9(07).
      *
           03  WRK-SURYO           PIC 9(05)V9(03).
           03  WRK-SURYO-R         REDEFINES   WRK-SURYO.
               05  WRK-SURYO-S1    PIC 9(05).
               05  WRK-SURYO-S2    PIC 9(03).
      *
           03  WRK-SURYO-X.
               05  WRK-SURYO-Z1    PIC ZZZ9.
               05  WRK-SURYO-Z2    PIC X(01).
               05  WRK-SURYO-Z3    PIC ZZZ.
           03  WRK-SURYO-X-R       REDEFINES   WRK-SURYO-X.
               05  WRK-SURYO-ZF    PIC X(03).
               05  WRK-SURYO-Z4    PIC ZZZZ9.
      *
      *
       01  TBL-DATA-AREA.
           03  TBL-SRYKBN              PIC X(02).
           03  TBL-SRYSYUKBN           PIC X(03).
           03  TBL-ZAITENSU            PIC S9(07).
           03  TBL-KINGAKU             PIC S9(08).
           03  TBL-KAISU               PIC 9(03).
           03  TBL-ZAI-TBL             OCCURS   50.
               05  TBL-SRYCD           PIC X(09).
               05  TBL-NAME            PIC X(80).
               05  TBL-TANINAME        PIC X(10).
               05  TBL-SURYO           PIC 9(05)V9(3).
               05  TBL-JIHIMONEY       PIC S9(07).
      *    ¼«ÈñÊ¬
       01  TBL-JIHI-AREA.
           03  TBL-JIHI-TBL            OCCURS   300.
               05  TBL-JIHI-SRYKBN          PIC X(02).
               05  TBL-JIHI-SRYSYUKBN       PIC X(03).
               05  TBL-JIHI-KAISU           PIC 9(03).
               05  TBL-JIHI-SRYCD           PIC X(09).
               05  TBL-JIHI-NAME            PIC X(80).
               05  TBL-JIHI-JIHIMONEY       PIC S9(07).
           03  IDX-JIHI                PIC 9(04).
      *
      *
       01  TBL-MEISAI-AREA.
           05  TBL-MEISA-REC           OCCURS   70.
               07  TBL-H-SRYKBN          PIC X(10).
               07  TBL-H-SRYMEI          PIC X(80).
               07  TBL-H-TANINAME        PIC X(10).
               07  TBL-H-SURYO           PIC X(08).
               07  TBL-H-KAISU           PIC X(03).
               07  TBL-H-KINGAKU         PIC X(11).
      *
      *Ä¢É¼ÌÀºÙ¿ô
       01  LINE-MAX                    PIC 9(03)   VALUE   70.
      *
      *****************************************************************
      *    ¥Õ¥¡¥¤¥ë¥ì¥¤¥¢¥¦¥È
      *****************************************************************
      *
      *    °åÎÅµ¡´Ø¾ðÊó¡Ý´ðËÜ¾ðÊó 
           COPY    "CPSK1001.INC".
      *    °åÎÅµ¡´Ø¾ðÊó¡Ý½êºßÃÏ¡¢Ï¢ÍíÀè 
           COPY    "CPSK1002.INC".
      *
           COPY    "CPSK1005.INC".
           COPY    "CPSK5001.INC".
      *
      *    ½ÐÎÏÀè¥×¥ê¥ó¥¿Ì¾³ä¤êÅö¤Æ¾ðÊó
           COPY    "CPSK1034.INC".
      *
      *    ´µ¼Ô¥Þ¥¹¥¿
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    ¼ýÇ¼
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    ÊÝ¸±ÁÈ¹ç¤»
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    ÅÀ¿ô¥Þ¥¹¥¿¡Ý
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *    ¿ÇÎÅ¹Ô°Ù¥Þ¥¹¥¿¡Ý
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    ¿ÇÎÅ²ñ·×¥Þ¥¹¥¿¡Ý
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *    ¿ÇÎÅ²ñ·×Éí²Ã¾ðÊó¥Þ¥¹¥¿¡Ý
       01  SRYACCTPLUS-REC.
           COPY    "CPSRYACCTPLUS.INC".
      *
      *    ¼õ¿ÇÍúÎò
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *****************************************************************
      *    ¥µ¥Ö¥×¥íÍÑ¡¡ÎÎ°è
      *****************************************************************
      *
      *   ÆüÉÕÊÑ´¹¥µ¥Ö
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    Á´³Ñ¥Á¥§¥Ã¥¯¥Ñ¥é¥á¥¿
           COPY    "CPORCSKANACHK.INC".
      *    ÉÂ¼¼Ì¾¾ÎÊÔ½¸
           COPY    "CPORCSBRMNUM.INC".
      *
      *    Æþ±¡²ñ·×ºîÀ®¥Ñ¥é
           COPY    "CPORCHCM34S01.INC".
      *
      *    °õºþ¥Ñ¥é¥á¥¿
           COPY    "CPORCSMKPRT.INC".
      *
      *    ¥ª¥ó¥é¥¤¥óÄ¢É¼Ì¾¡¦½ÐÎÏÀè¥×¥ê¥ó¥¿Ì¾¼èÆÀ¥Ñ¥é
           COPY    "CPORCSPRTNM.INC".
      *
           COPY    "MCPDATA.INC".
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    Ï¢Íí¡¡ÎÎ°è
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    ¥¹¥ÑÎÎ°è
           COPY    "COMMON-SPA".
      *
      *    ÀÁµá½ñ¥Ñ¥é¥á¥¿
           COPY    "CPORCHCN04.INC".
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           ORCHCN04AREA
           .
      *
      *****************************************************************
      *    ¼ç¡¡¡¡½èÍý
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
      *
           ACCEPT  SYS-TIME            FROM    TIME
      *
      *    ³Æ£Ä£ÂÆÉ¹þ
           PERFORM 100-SYORI-SEC
      *
           PERFORM VARYING IDX-SYU     FROM    1   BY  1
                   UNTIL   (IDX-SYU    >   10  )   OR
                           (ORCHCN04-DENPNUM (IDX-SYU) =   ZERO)
               MOVE    ORCHCN04-DENPNUM (IDX-SYU)  TO  WRK-DENPNUM
      *        ÅÁÉ¼ÈÖ¹æËè¤Î°õºþ
               PERFORM 200-MAIN-SYORI-SEC
           END-PERFORM
      *
           .
       000-PROC-EXT.
           EXIT    PROGRAM
           .
      *****************************************************************
      *    ½é´üÊÔ½¸½èÍý
      *****************************************************************
       100-SYORI-SEC                SECTION.
      *
      *    °åÎÅµ¡´Ø¾ðÊó¡Ý½êºßÃÏ¡¢Ï¢ÍíÀè
           MOVE    SPACE               TO  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    SPA-SYSYMD          TO  SYS-1001-STYUKYMD
           MOVE    SPA-SYSYMD          TO  SYS-1001-EDYUKYMD
      *    ¥·¥¹¥Æ¥à´ÉÍý¸¡º÷
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-KEY10-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1001-REC
           ELSE
               INITIALIZE                  SYS-1001-REC
           END-IF
      *
      *    °åÎÅµ¡´Ø¾ðÊó¡Ý½êºßÃÏ¡¢Ï¢ÍíÀè
           MOVE    SPACE               TO  SYS-1002-REC
           MOVE    "1002"              TO  SYS-1002-KANRICD
           MOVE    "*"                 TO  SYS-1002-KBNCD
           MOVE    SPA-SYSYMD          TO  SYS-1002-STYUKYMD
           MOVE    SPA-SYSYMD          TO  SYS-1002-EDYUKYMD
      *    ¥·¥¹¥Æ¥à´ÉÍý¸¡º÷
           MOVE    SYS-1002-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-KEY10-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1002-REC
           ELSE
               INITIALIZE                  SYS-1002-REC
           END-IF
      *
      *    ½ÐÎÏÀè¥×¥ê¥ó¥¿Ì¾³ä¤êÅö¤Æ¾ðÊóÊÔ½¸
           INITIALIZE                      SYS-1034-REC
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "2"                 TO  ORCSPRTNM-KBN
           MOVE    SPA-SYSYMD          TO  ORCSPRTNM-SRYYMD
           MOVE    "1"                 TO  ORCSPRTNM-NYUGAIKBN
           CALL    "ORCSPRTNM"         USING
                                           ORCSPRTNMAREA
                                           SPA-AREA
                                           SYS-1034-REC
      *
           .
       100-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ä¢É¼°õºþ³«»Ï½èÍý
      *****************************************************************
       400-SYOKI-PRINT-SEC             SECTION.
      *
      *    ¥Õ¥¡¥¤¥ë£Ï£Ð£Å£Î
           MOVE    "HC04"              TO  HC01PARA-FORM-ID
           MOVE    SPA-TERMID          TO  HC01PARA-TERMID
           MOVE    SYS-TIME            TO  HC01PARA-SYOHMS
      *
           ADD     1                   TO  WRK-PAGE-CNT
           MOVE    WRK-PAGE-CNT        TO  HC01PARA-CNT
           OPEN    OUTPUT              PRT-FILE
      *
           .
       400-SYOKI-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ä¢É¼°õºþ½èÍý
      *****************************************************************
       400-PRINT-SEC                SECTION.
      *
      *    °õºþÍÑ¥Ç¡¼¥¿½ÐÎÏ
           WRITE  HCN04
      *
           CLOSE                       PRT-FILE
      *
           INITIALIZE                 ORCSMKPRTAREA
           MOVE   "HC01.sh"           TO  MKPRT-ID
           MOVE   "HCN04.red"         TO  MKPRT-DIA
           MOVE   SPACE               TO  MKPRT-DEF
           MOVE   HC01PARA            TO  MKPRT-DAT
           MOVE   SYS-1034-PRTNM(09)  TO  MKPRT-PRTNM
           CALL   "ORCSMKPRT"         USING
                                      ORCSMKPRTAREA
      *
           .
       400-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *   ÅÁÉ¼ÈÖ¹æËè¤Î°õºþ½èÍý
      *****************************************************************
       200-MAIN-SYORI-SEC                SECTION.
      *
      *    ½é´ü
           MOVE    ZERO                TO  WRK-PAGE
           MOVE    SPACE               TO  WRK-SRYMEI-OLD
           INITIALIZE                  TBL-MEISAI-AREA
           MOVE    ZERO                TO  IDX-H
      *    ¼ýÇ¼¸¡º÷
           PERFORM 2001-SYUNOU-HEN-SEC
           IF      FLG-SYUNOU          =   ZERO
      *        ÉÂÅïÂ¾£Ä£Â¸¡º÷
               PERFORM 2002-DB-KENSAKU-SEC
      *        ¿ÇÎÅ¹Ô°Ù°õºþ
               PERFORM 2003-SRYACCT-SYORI-SEC
      *        Æþ±¡ÎÁ°õºþ
               PERFORM 2004-NYUIN-SYORI-SEC
      *        ¼«ÈñÊ¬°õºþ
               PERFORM 2005-JIHI-SYORI-SEC
      *
      *        ºÇ½ª¹Ô
               IF      IDX-H           >   ZERO
                   PERFORM 2006-LAST-PRINT-SEC
               END-IF
           END-IF
           .
       200-MAIN-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼ýÇ¼¸¡º÷½èÍý
      *****************************************************************
       2001-SYUNOU-HEN-SEC             SECTION.
      *
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    "1"                 TO  SYU-NYUGAIKBN
           MOVE    ORCHCN04-PTID       TO  SYU-PTID
           MOVE    WRK-DENPNUM         TO  SYU-DENPNUM
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "tbl_syunou"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syunou"        TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 980-SYUNOU-READ-SEC
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
           MOVE    "tbl_syunou"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       2001-SYUNOU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *   ÉÂÅïÂ¾£Ä£Â¸¡º÷½èÍý
      *****************************************************************
       2002-DB-KENSAKU-SEC          SECTION.
      *
      *    ¿ÇÎÅ²ÊÌ¾ÊÔ½¸
           MOVE    SPACE                TO  WRK-SRYKA-MEI
           PERFORM 20011-SRYKAMEI-HEN-SEC
      *    ÊÝ¸±ÁÈ¹ç¤»
           PERFORM 20012-HKNCOMBI-HEN-SEC
      *    ÉÂÅï¡¦ÉÂ¼¼
           PERFORM 20013-BYOTO-HEN-SEC
           .
       2002-DB-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÊÝ¸±ÁÈ¹ç¤»Ì¾¾ÎÊÔ½¸½èÍý
      *****************************************************************
       20012-HKNCOMBI-HEN-SEC         SECTION.
      *
      *    ÊÝ¸±ÁÈ¹ç¤»¥Þ¥¹¥¿¡¼¸¡º÷
           INITIALIZE                      HKNCOMBI-REC
           MOVE    SYU-HOSPID          TO  COMB-HOSPID
           MOVE    SYU-PTID            TO  COMB-PTID
           MOVE    SYU-HKNCOMBINUM     TO  COMB-HKNCOMBINUM
           PERFORM 910-HKNCOMBI-READ-SEC
           IF      FLG-HKNCOMBI        =   1
                DISPLAY "*** HKNCOMBI  ERR:"   COMB-KEY "."
           END-IF
           PERFORM 20012-HKNCOMBIMEI-HEN-SEC
      *
           .
       20012-HKNCOMBI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    ÊÝ¸±ÁÈ¹ç¤»Ì¾¾ÎÊÔ½¸½èÍý
      *****************************************************************
       20012-HKNCOMBIMEI-HEN-SEC             SECTION.
      *
           MOVE    SPACE               TO  WRK-HKNCOMBIMEI
      *
           STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                   "¡¡"                    DELIMITED  BY  SIZE
                   COMB-KOH1-TANSEIDONAME  DELIMITED  BY  SPACE
                   "¡¡"                    DELIMITED  BY  SIZE
                   COMB-KOH2-TANSEIDONAME  DELIMITED  BY  SPACE
                   "¡¡"                    DELIMITED  BY  SIZE
                   COMB-KOH3-TANSEIDONAME  DELIMITED  BY  SPACE
                   "¡¡"                    DELIMITED  BY  SIZE
                   COMB-KOH4-TANSEIDONAME  DELIMITED  BY  SPACE
                         INTO              WRK-HKNCOMBIMEI
           END-STRING
      *
           .
       20012-HKNCOMBIMEI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¿ÇÎÅ²ÊÌ¾ÊÔ½¸½èÍý
      *****************************************************************
       20011-SRYKAMEI-HEN-SEC                SECTION.
      *
      *    ¿ÇÎÅ²Ê
           MOVE    SPACE               TO  SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    SYU-SRYKA           TO  SYS-1005-KBNCD
           MOVE    SPA-SYSYMD          TO  SYS-1005-STYUKYMD
           MOVE    SPA-SYSYMD          TO  SYS-1005-EDYUKYMD
      *    ¥·¥¹¥Æ¥à´ÉÍý¸¡º÷
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-KEY10-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1005-REC
           ELSE
               INITIALIZE                  SYS-1005-REC
           END-IF
      *
           .
       20011-SRYKAMEI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÉÂÅï¡¦ÉÂ¼¼ÊÔ½¸½èÍý
      *****************************************************************
       20013-BYOTO-HEN-SEC                SECTION.
      *
      *    ÉÂÅï¾ðÊó¸¡º÷
           MOVE    SPACE               TO  SYS-5001-REC
           MOVE    "5001"              TO  SYS-5001-KANRICD
           MOVE    SYU-BYOTONUM        TO  SYS-5001-KBNCD
           MOVE    SYU-SKYSTYMD        TO  SYS-5001-STYUKYMD
           MOVE    SYU-SKYSTYMD        TO  SYS-5001-EDYUKYMD
      *
           MOVE    SYS-5001-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-KEY10-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-5001-REC
           ELSE
               INITIALIZE                  SYS-5001-REC
           END-IF
      *    ÉÂ¼¼Ì¾ÊÔ½¸½èÍý
           MOVE    SPACE               TO  WRK-ROOMNUM-NAME
           INITIALIZE                      ORCSBRMNUMAREA
           MOVE    "1"                 TO  SBRMNUM-IN-PROCKBN
           MOVE    SYU-ROOMNUM(3:6)    TO  SBRMNUM-IN-BRMNUM
           CALL    "ORCSBRMNUM"        USING    ORCSBRMNUMAREA
           IF       SBRMNUM-RC         =   ZERO
      *        Á´³ÑÊÔ½¸½èÍý
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "2"                 TO  KANACHK-SYORI
               MOVE    SBRMNUM-OT-BRMNUM   TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"       USING
                                           ORCSKANACHKAREA
               IF      KANACHK-RC          =   ZERO
                   MOVE    KANACHK-OUT-INPUT
                                           TO  WRK-ROOMNUM-NAME
               END-IF
           END-IF
           MOVE    SPACE               TO  WRK-ROOM
           IF      WRK-ROOMNUM-NAME    =   SPACE
               STRING  SYS-5001-BTU-NAME   DELIMITED   BY  SPACE
                       "¡¡¡¡¡¡¡¡"          DELIMITED   BY  SIZE
                       "¹æ¼¼"              DELIMITED   BY  SIZE
                                       INTO    WRK-ROOM
               END-STRING
           ELSE
               STRING  SYS-5001-BTU-NAME   DELIMITED   BY  SPACE
                       "¡¡"                DELIMITED   BY  SIZE
                       WRK-ROOMNUM-NAME    DELIMITED   BY  SPACE
                       "¹æ¼¼"              DELIMITED   BY  SIZE
                                       INTO    WRK-ROOM
               END-STRING
           END-IF
      *
           .
       20013-BYOTO-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *   ¿ÇÎÅ¹Ô°Ù°õºþ½èÍý
      *****************************************************************
       2003-SRYACCT-SYORI-SEC          SECTION.
      *
      *    ÂÐ¾Ý´ü´Ö
           MOVE    SYU-SKYSTYMD(7:2)   TO  IDX-STR
           MOVE    SYU-SKYEDYMD(7:2)   TO  IDX-END
           MOVE    SYU-SKYSTYMD        TO  WRK-SRYYMD
      *
           INITIALIZE                      TBL-JIHI-AREA
      *    ¿ÇÎÅ²ñ·×
           INITIALIZE                      SRYACCT-REC
           MOVE    SYU-HOSPID          TO  ACCT-HOSPID
           MOVE    SYU-NYUGAIKBN       TO  ACCT-NYUGAIKBN
           MOVE    SYU-PTID            TO  ACCT-PTID
           MOVE    SYU-SRYYMD(1:6)     TO  ACCT-SRYYM
           MOVE    SYU-HKNCOMBINUM     TO  ACCT-HKNCOMBI
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "tbl_sryacct"       TO  MCP-TABLE
           MOVE    "key47"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_sryacct"       TO  MCP-TABLE
               MOVE    "key47"             TO  MCP-PATHNAME
               PERFORM 930-SRYACCT-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SRYACCT
           END-IF
           PERFORM
                   UNTIL    FLG-SRYACCT    =   1
      *        ÂÐ¾Ý´ü´Ö¤Î²ó¿ô
               MOVE    ZERO                TO  WRK-KAISU
               PERFORM VARYING     IDX     FROM    IDX-STR   BY  1
                       UNTIL       IDX     >   IDX-END
                   ADD     ACCT-DAY (1 IDX)    TO  WRK-KAISU
               END-PERFORM
               IF      WRK-KAISU           >   ZERO
                   PERFORM 20031-MEI-HENSYU-SEC
               END-IF
      *
               MOVE    "tbl_sryacct"       TO  MCP-TABLE
               MOVE    "key47"             TO  MCP-PATHNAME
               PERFORM 930-SRYACCT-READ-SEC
           END-PERFORM
      *
           MOVE    "tbl_sryacct"       TO  MCP-TABLE
           MOVE    "key47"             TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
           .
       2003-SRYACCT-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    ÌÀºÙÊÔ½¸½èÍý
      *****************************************************************
       20031-MEI-HENSYU-SEC          SECTION.
      *
           INITIALIZE                  TBL-DATA-AREA
      *
           INITIALIZE                  SRYACT-REC
           MOVE    ACCT-HOSPID         TO  SRY-HOSPID
           MOVE    ACCT-NYUGAIKBN      TO  SRY-NYUGAIKBN
           MOVE    ACCT-PTID           TO  SRY-PTID
           MOVE    ACCT-SRYKA          TO  SRY-SRYKA
           MOVE    ACCT-SRYYM          TO  SRY-SRYYM
           MOVE    ACCT-ZAINUM         TO  SRY-ZAINUM
      *
           MOVE    SRYACT-REC          TO  MCPDATA-REC
           MOVE    "tbl_sryact"        TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_sryact"        TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 920-SRYACT-READ-SEC
           ELSE
               INITIALIZE                  SRYACT-REC
               MOVE    1               TO  FLG-SRYACT
           END-IF
      *
           MOVE    ZERO                TO  IDX-S
           PERFORM
                   UNTIL   FLG-SRYACT      =   1
               PERFORM VARYING     IDXA    FROM    1   BY  1
                       UNTIL      (IDXA    >   5   )   OR
                                  (SRY-SRYCD (IDXA)    =   SPACE)
      *            ¿ÇÎÅ¡¦ÌôºÞ¡¦´ïºà¡¦Éô°Ì¡¦¼«Èñ¤òÂÐ¾Ý¤È¤¹¤ë
                   IF      (SRY-SRYCD (IDXA)(1:1)      =   "1"
                                                       OR  "6"
                                                       OR  "7" ) OR
                           (SRY-SRYCD (IDXA)(1:3)      =   "059"
                                                       OR  "002"
                                                       OR  "095"
                                                       OR  "096")
                       PERFORM 200321-MEISAI-HEN-SEC
                   END-IF
               END-PERFORM
               MOVE    "tbl_sryact"        TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 920-SRYACT-READ-SEC
           END-PERFORM
      *
           MOVE    "tbl_sryact"        TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
      *    ºÞ¤´¤È¤Ë¡¢ÊÔ½¸¤¹¤ë
           IF      IDX-S               >   ZERO
               IF      ACCT-SRYKBN         =   "95"   OR  "96"
      *            ¼«ÈñÊ¬
                   PERFORM 200322-JIHI-HENSYU-SEC
               ELSE
                   PERFORM 20023-TBL-HENSYU-SEC
               END-IF
           END-IF
           .
       20031-MEI-HENSYU-EXT.
           EXIT.
      *****************************************************************
      *        ÌÀºÙÊÔ½¸½èÍý
      *****************************************************************
       200321-MEISAI-HEN-SEC      SECTION.
      *
           MOVE    SRY-SRYCD (IDXA)    TO  TNS-SRYCD
           PERFORM 910-TENSU-READ-SEC
      *
           ADD     1                   TO  IDX-S
           MOVE    SRY-SRYCD (IDXA)    TO  TBL-SRYCD (IDX-S)
           MOVE    TNS-NAME            TO  TBL-NAME  (IDX-S)
           IF      TNS-TANICD          =   ZERO
                                       OR  SPACE
               CONTINUE
           ELSE
               MOVE    TNS-TANINAME        TO  TBL-TANINAME(IDX-S)
               MOVE    SRY-SRYSURYO(IDXA)  TO  TBL-SURYO (IDX-S)
           END-IF
           IF      SRY-SRYKBN          =   "95"
                                       OR  "96"
      *        ¼«Èñ¤Ï£±¹Ô£±ÌÀºÙ¤È¤¹¤ë
               COMPUTE TBL-JIHIMONEY(IDX-S)
                                       =  (SRY-JIHIMONEY(IDXA)
                                       *   SRY-SRYSURYO (IDXA))
                                       *   WRK-KAISU
               MOVE    ZERO                TO  TBL-SURYO (IDX-S)
           END-IF
           MOVE    SRY-SRYSYUKBN       TO  WRK-SRYSYUKBN
           .
       200321-MEISAI-HEN-EXT.
           EXIT.
      *****************************************************************
      *        ¥Æ¡¼¥Ö¥ëÊÔ½¸½èÍý
      *****************************************************************
       20023-TBL-HENSYU-SEC      SECTION.
      *
           IF      ACCT-ZAIREQFLG      =   "1"
      *        Éí²Ã¾ðÊó¤¢¤ê
               PERFORM 200231-SRYACCTPLUS-CHK-SEC
           ELSE
               MOVE    ACCT-ZAITEN     TO  TBL-ZAITENSU
           END-IF
           MOVE    ACCT-SRYKBN         TO  TBL-SRYKBN 
           MOVE    WRK-SRYSYUKBN       TO  TBL-SRYSYUKBN
           MOVE    WRK-KAISU           TO  TBL-KAISU
      *    ¶â³Û
           COMPUTE TBL-KINGAKU         =  (TBL-ZAITENSU
                                       *   TBL-KAISU )
                                       *   10
      *
      *    Ä¢É¼°õºþ
           PERFORM 2005-PRINT-SYORI-SEC
      *
           .
       20023-TBL-HENSYU-EXT.
           EXIT.
      *****************************************************************
      *    Éí²Ã¾ðÊóÊÔ½¸½èÍý
      *****************************************************************
       200231-SRYACCTPLUS-CHK-SEC       SECTION.
      *
           MOVE    SPACE               TO  SRYACCTPLUS-REC
           INITIALIZE                  SRYACCTPLUS-REC
           MOVE    ACCT-HOSPID         TO  ACCTP-HOSPID
           MOVE    ACCT-NYUGAIKBN      TO  ACCTP-NYUGAIKBN
           MOVE    ACCT-PTID           TO  ACCTP-PTID
           MOVE    ACCT-SRYKA          TO  ACCTP-SRYKA
           MOVE    ACCT-SRYYM          TO  ACCTP-SRYYM
           MOVE    ACCT-ZAINUM         TO  ACCTP-ZAINUM
      *
           MOVE    SRYACCTPLUS-REC     TO  MCPDATA-REC
           MOVE    "tbl_sryacctplus"   TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_sryacctplus"   TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 930-SRYACCTPLUS-READ-SEC
           ELSE
               INITIALIZE                  SRYACCTPLUS-REC
               MOVE    1               TO  FLG-SRYACCTPLUS
           END-IF
           MOVE    "tbl_sryacctplus"   TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           MOVE    ZERO                TO  FLG-PLUSKBN
           IF      FLG-SRYACCTPLUS     =   ZERO
               IF  ACCTP-PLUSKBN       =   1
      *            ¥Þ¥¤¥Ê¥¹ÅÀ¿ô
                   COMPUTE TBL-ZAITENSU    =   ACCT-ZAITEN
                                           *   -1
               ELSE
                   MOVE    ACCT-ZAITEN     TO  TBL-ZAITENSU
               END-IF
           ELSE
               MOVE    ACCT-ZAITEN     TO  TBL-ZAITENSU
           END-IF
      *
           .
       200231-SRYACCTPLUS-CHK-EXT.
           EXIT.
      *****************************************************************
      *    ¼«Èñ¥Æ¡¼¥Ö¥ëÊÔ½¸½èÍý
      *****************************************************************
       200322-JIHI-HENSYU-SEC      SECTION.
      *
           PERFORM VARYING     IDXJ    FROM    1   BY  1
                   UNTIL      (IDXJ    >   50  )   OR
                              (TBL-SRYCD (IDXJ)    =   SPACE)
               ADD     1                   TO  IDX-JIHI
               IF      IDX-JIHI            >   300
                   DISPLAY "ORCHCN40 JIHI 300 OVER!!"
               ELSE
                   MOVE    ACCT-SRYKBN     TO  TBL-JIHI-SRYKBN(IDX-JIHI)
                   MOVE    WRK-KAISU       TO  TBL-JIHI-KAISU(IDX-JIHI)
                   MOVE    WRK-SRYSYUKBN   TO  TBL-JIHI-SRYSYUKBN
                                                            (IDX-JIHI)
                   MOVE    TBL-SRYCD (IDXJ)
                                           TO  TBL-JIHI-SRYCD
                                                            (IDX-JIHI)
                   MOVE    TBL-NAME (IDXJ)
                                           TO  TBL-JIHI-NAME
                                                            (IDX-JIHI)
                   MOVE    TBL-JIHIMONEY (IDXJ)
                                           TO  TBL-JIHI-JIHIMONEY
                                                            (IDX-JIHI)
               END-IF
           END-PERFORM
           .
       200322-JIHI-HENSYU-EXT.
           EXIT.
      *****************************************************************
      *    Ä¢É¼°õºþ½èÍý
      *****************************************************************
       2005-PRINT-SYORI-SEC                SECTION.
      *
      *    Ä¢É¼¥Æ¡¼¥Ö¥ëÊÔ½¸
           PERFORM 20052-TBL-HEN-SEC
      *
           .
       2005-PRINT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ä¢É¼¥Æ¡¼¥Ö¥ëÊÔ½¸½èÍý
      *****************************************************************
       20052-TBL-HEN-SEC             SECTION.
      *
      *    ºÞËè¤ËÊÔ½¸
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL      (IDX2    >   50  )  OR
                              (TBL-SRYCD (IDX2)    =  SPACE)
               ADD     1               TO  IDX-H
               IF      IDX-H           >=  LINE-MAX
                   PERFORM 200520-PAGE-CNT-SEC
               END-IF
      *        Ì¾¾Î¤ÈÃ±°ÌÌ¾¾Î¥Á¥§¥Ã¥¯
               IF     (TBL-TANINAME (IDX2)         NOT =   SPACE)
                 AND  (TBL-NAME     (IDX2)(71:)    NOT =   SPACE)
      *            ºÇ½ª¹Ô¤Î»þ¡¢²þ¥Ú¡¼¥¸
                   IF      IDX-H          >=  (LINE-MAX - 1 )
                       PERFORM 200520-PAGE-CNT-SEC
                   END-IF
               END-IF
               IF     IDX2                =   1
                   PERFORM 200521-SRYSYUMEI-SEC
                   IF      WRK-SRYMEI     NOT  =   WRK-SRYMEI-OLD
                       MOVE    WRK-SRYMEI      TO  TBL-H-SRYKBN
                                                       (IDX-H)
                       MOVE    WRK-SRYMEI      TO  WRK-SRYMEI-OLD
                   END-IF
               END-IF
               MOVE    TBL-NAME (IDX2)     TO  TBL-H-SRYMEI
                                                     (IDX-H)
      *        Ã±°ÌÌ¾¾Î
               IF     (TBL-TANINAME (IDX2)     NOT =   SPACE)
                 AND  (TBL-NAME (IDX2)(71:)    NOT =   SPACE)
                   ADD     1                   TO  IDX-H
               END-IF
               MOVE    TBL-TANINAME (IDX2)     TO  TBL-H-TANINAME
                                                       (IDX-H)
               IF      TBL-SURYO (IDX2)        >   ZERO
                   MOVE    TBL-SURYO (IDX2)    TO  WRK-SURYO
                   PERFORM 200521-SURYO-HEN-SEC
                   MOVE    WRK-SURYO-X         TO  TBL-H-SURYO
                                                       (IDX-H)
               END-IF
               IF      TBL-JIHIMONEY (IDX2)     >   ZERO
                   MOVE    TBL-JIHIMONEY(IDX2) TO  WRK-Z119
                   MOVE    WRK-Z119            TO  TBL-H-KINGAKU
                                                      (IDX-H)
               END-IF
           END-PERFORM
           IF      TBL-SRYKBN          =   "95"
                                       OR  "96"
               CONTINUE
           ELSE
      *        ¶â³Û
               IF      TBL-KINGAKU        >   ZERO
                   MOVE    TBL-KINGAKU    TO  WRK-Z119
                   MOVE    WRK-Z119       TO  TBL-H-KINGAKU
                                                      (IDX-H)
               ELSE
                   MOVE    TBL-KINGAKU    TO  WRK-Z119-2
                   MOVE    WRK-Z119-2     TO  TBL-H-KINGAKU
                                                      (IDX-H)
               END-IF
           END-IF
      *    ²ó¿ô
           MOVE    TBL-KAISU           TO  WRK-ZZ9
           MOVE    WRK-ZZ9             TO  TBL-H-KAISU (IDX-H)
      *    ºÞËè¤Ë£±¹Ô³«¤±¤ë
           ADD     1                   TO  IDX-H
      *
           .
       20052-TBL-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥Ú¡¼¥¸¥«¥¦¥ó¥È½èÍý
      *****************************************************************
       200520-PAGE-CNT-SEC                  SECTION.
      *
           MOVE    LINE-MAX            TO  IDX-H
           MOVE    "¼¡¥Ú¡¼¥¸¤ØÂ³¤¯"    TO  TBL-H-SRYMEI
                                                   (IDX-H)(30:)
      *    Ä¢É¼°õºþ
           PERFORM 400-PRINT-SYORI-SEC
           MOVE    1                   TO  IDX-H
           MOVE    SPACE               TO  WRK-SRYMEI-OLD
           INITIALIZE                  TBL-MEISAI-AREA
           .
       200520-PAGE-CNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¿ôÎÌÉ½¼¨ÍÑÊÔ½¸½èÍý
      *****************************************************************
       200521-SURYO-HEN-SEC                  SECTION.
      *
           MOVE    SPACE               TO  WRK-SURYO-X
           MOVE    WRK-SURYO-S1        TO  WRK-SURYO-Z1
      *
           MOVE    ZERO                TO  FLG-SP
           PERFORM VARYING     IDXM   FROM    3  BY  -1
                   UNTIL       IDXM    <   1
               IF      WRK-SURYO-S2(IDXM:1) NOT =   ZERO
                   MOVE    1               TO  FLG-SP
               END-IF
               IF      FLG-SP          =   1
                   MOVE    WRK-SURYO-S2(IDXM:1) TO  WRK-SURYO-Z3(IDXM:1)
               END-IF
           END-PERFORM
      *
           IF      WRK-SURYO-Z3        NOT =   SPACE
               MOVE    "."                 TO  WRK-SURYO-Z2
           ELSE
               MOVE    SPACE               TO  WRK-SURYO-X
               MOVE    WRK-SURYO           TO  WRK-SURYO-Z4
           END-IF
      *
           .
       200521-SURYO-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *     ¿ÇÎÅ¼ïÊÌ¶èÊ¬Ì¾¾Î½èÍý
      *****************************************************************
       200521-SRYSYUMEI-SEC             SECTION.
      *
           EVALUATE    TBL-SRYKBN
               WHEN    "11"
               WHEN    "12"
                   MOVE    "½é¡¦ºÆ¿ÇÎÁ"        TO  WRK-SRYMEI
               WHEN    "13"
                   MOVE    "°å³Ø´ÉÍýÅù"        TO  WRK-SRYMEI
               WHEN    "14"
                   MOVE    "ºßÂð°åÎÅ"          TO  WRK-SRYMEI
               WHEN    "21"
               WHEN    "22"
               WHEN    "23"
               WHEN    "24"
               WHEN    "25"
               WHEN    "26"
               WHEN    "27"
                   MOVE    "Åê¡¡¡¡Ìô"          TO  WRK-SRYMEI
               WHEN    "31"
               WHEN    "32"
               WHEN    "33"
                   MOVE    "Ãí¡¡¡¡¼Í"          TO  WRK-SRYMEI
               WHEN    "40"
                   MOVE    "½è¡¡¡¡ÃÖ"          TO  WRK-SRYMEI
               WHEN    "50"
                   MOVE    "¼ê¡¡¡¡½Ñ"          TO  WRK-SRYMEI
               WHEN    "54"
                   MOVE    "Ëã¡¡¡¡¿ì"          TO  WRK-SRYMEI
               WHEN    "60"
                   MOVE    "¸¡¡¡¡¡ºº"          TO  WRK-SRYMEI
               WHEN    "70"
                   MOVE    "²èÁü¿ÇÃÇ"          TO  WRK-SRYMEI
               WHEN    "80"
                   MOVE    "¤½¤ÎÂ¾"            TO  WRK-SRYMEI
               WHEN    "90"
               WHEN    "92"
                   MOVE    "Æþ±¡ÎÁÅù"          TO  WRK-SRYMEI
               WHEN    "97"
                   MOVE    "Æþ±¡ÎÁÅù"          TO  WRK-SRYMEI
               WHEN    "95"
               WHEN    "96"
                   MOVE    "µëÉÕ³°"            TO  WRK-SRYMEI
               WHEN    OTHER
                   MOVE    "¤½¤ÎÂ¾"            TO  WRK-SRYMEI
           END-EVALUATE
           .
       200521-SRYSYUMEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    ºÇ½ª°õºþ½èÍý
      *****************************************************************
       2006-LAST-PRINT-SEC             SECTION.
      *
      *    ºÇ½ª¹Ô
           IF      TBL-H-SRYMEI(LINE-MAX)
                                       =   SPACE
               ADD     1                   TO  IDX-H
               IF      IDX-H               >   LINE-MAX
                   MOVE    LINE-MAX            TO  IDX-H
               END-IF
               MOVE    "°Ê²¼Í¾Çò"          TO  TBL-H-SRYMEI
                                                    (IDX-H)(30:)
           END-IF
      *    Ä¢É¼°õºþ
           PERFORM 400-PRINT-SYORI-SEC
           .
       2006-LAST-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    °õºþ½èÍý
      *****************************************************************
       400-PRINT-SYORI-SEC          SECTION.
      *
      *    Ä¢É¼°õºþ³«»Ï½èÍý
           PERFORM 400-SYOKI-PRINT-SEC
      *
      *    Ä¢É¼ÊÔ½¸½èÍý
           PERFORM 300-HCN04-HEN-SEC
      *
      *    Ä¢É¼°õºþ½èÍý
           PERFORM 400-PRINT-SEC
      *
           .
       400-PRINT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ä¢É¼ÊÔ½¸½èÍý
      *****************************************************************
       300-HCN04-HEN-SEC                SECTION.
      *
           INITIALIZE                  HCN04
      *
           ADD     1                   TO  WRK-PAGE
      *    ÅÁÉ¼ÈÖ¹æ
           MOVE    WRK-PAGE            TO  WRK-ZZ9
           MOVE    WRK-ZZ9             TO  HCN04-PAGE
      *    ÅÁÉ¼ÈÖ¹æ
           MOVE    SYU-DENPNUM         TO  WRK-NO
           MOVE    WRK-NO              TO  HCN04-NO
      *    ¿ÇÎÅ²Ê
           MOVE    WRK-SRYKA-MEI(1:20) TO  HCN04-SRYKANAME
      *    ´µ¼ÔÈÖ¹æ
           MOVE    ORCHCN04-PTNUM      TO  HCN04-PTNUM
      *    ´µ¼ÔÌ¾¾Î
           MOVE    ORCHCN04-NAME       TO  HCN04-NAME
      *    ÊÝ¸±¼ïÊÌ
           MOVE    WRK-HKNCOMBIMEI     TO  HCN04-HOKEN
      *    ÉéÃ´³ä¹ç
           IF      SYU-PTFTNRATE       >   ZERO
               COMPUTE WRK-WARI        =   SYU-PTFTNRATE   /   10
               IF      SYU-PTFTNRATE(3:1)  =   ZERO
                   MOVE    WRK-WARI            TO  WRK-Z6
                   MOVE    WRK-Z6              TO  HCN04-FUTAN
               ELSE
                   MOVE    WRK-WARI            TO  WRK-Z62
                   MOVE    WRK-Z62             TO  HCN04-FUTAN
               END-IF
           END-IF
      *    È¯¹ÔÆü
           MOVE    SYU-DENPPRTYMD      TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  HCN04-HAKYMD
      *    ÀÁµá³«»ÏÆü
           MOVE    SYU-SKYSTYMD        TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  HCN04-NYUINSTRYMD
           MOVE    SYU-SKYEDYMD        TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  HCN04-NYUINENDYMD
      *
      *    ÉÂÅï
           MOVE    WRK-ROOM            TO  HCN04-ROOM
      *    °åÎÅµ¡´Ø½»½ê
           MOVE    SYS-1002-ADRS       TO  HCN04-IRYOADRS
      *    °åÎÅµ¡´ØÌ¾
           MOVE    SYS-1001-HOSPNAME   TO  HCN04-IRYOMEI
      *    °åÎÅµ¡´Ø£Ô£Å£Ì
           MOVE    SYS-1002-TEL        TO  HCN04-IRYOTEL
      *
      *    ÌÀºÙÆâÍÆ
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL       IDX2    >   LINE-MAX
               MOVE    TBL-H-SRYKBN (IDX2) TO  HCN04-SRYKBN (IDX2)
               MOVE    TBL-H-SRYMEI (IDX2) TO  HCN04-SRYMEI (IDX2)
               MOVE    TBL-H-TANINAME(IDX2)
                                           TO  HCN04-TANI  (IDX2)
               MOVE    TBL-H-SURYO  (IDX2) TO  HCN04-SURYO (IDX2)
               MOVE    TBL-H-KAISU  (IDX2) TO  HCN04-KAISU (IDX2)
               MOVE    TBL-H-KINGAKU(IDX2) TO  HCN04-KINGAKU(IDX2)
           END-PERFORM
           .
       300-HCN04-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *   Æþ±¡´ðËÜÎÁÊÔ½¸½èÍý
      *****************************************************************
       2004-NYUIN-SYORI-SEC                SECTION.
      *
           INITIALIZE                      HCM34S01-AREA
           MOVE    SYU-HOSPID          TO  HCM34S01-HOSPID
           MOVE    SYU-PTID            TO  HCM34S01-PTID
           MOVE    SYU-SRYYMD(1:6)     TO  HCM34S01-SANTEIYM
           MOVE    "1"                 TO  HCM34S01-KIKANKBN
           MOVE    SYU-SKYSTYMD        TO  HCM34S01-SKYSTYMD
           MOVE    SYU-SKYEDYMD        TO  HCM34S01-SKYEDYMD
           MOVE    SYU-HKNCOMBINUM     TO  HCM34S01-HKNCOMBI
           MOVE    SYU-SYUHKNNUM       TO  HCM34S01-HKNNUM
      *
           IF      SYU-SYUHKNNUM       =   "971"
                                       OR  "973"
               CALL    "ORCHCM34S02"       USING
                                           HCM34S01-AREA
                                           SPA-AREA
           ELSE
               CALL    "ORCHCM34S01"       USING
                                           HCM34S01-AREA
                                           SPA-AREA
           END-IF
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   HCM34S01-HENKYAKU-MAX
               INITIALIZE                  TBL-DATA-AREA
               MOVE    ZERO            TO  IDX-S
               PERFORM VARYING     IDX2    FROM    1   BY  1
                       UNTIL      (IDX2    >   20   )  OR
                                  (HCM34S01-SRYCD(IDX IDX2)
                                               =   SPACE   )
                   PERFORM 20041-SRYCD-HEN-SEC
               END-PERFORM
               PERFORM 20042-NYUTBL-HENSYU-SEC
           END-PERFORM
      *    ÁªÄêÆþ±¡ÎÁ´µ¼Ô¼«¸ÊÉéÃ´³Û
           IF      HCM34S01-SENTEI-PTFTN   >   ZERO
               PERFORM 20043-SENTEI-HENSYU-SEC
           END-IF
          .
       2004-NYUIN-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *   Æþ±¡´ðËÜÎÁÌÀºÙÊÔ½¸
      *****************************************************************
       20041-SRYCD-HEN-SEC                SECTION.
      *
           MOVE    HCM34S01-SRYCD(IDX IDX2)    TO  TNS-SRYCD
           PERFORM 910-TENSU-READ-SEC
      *
           ADD     1                   TO  IDX-S
           MOVE    HCM34S01-SRYCD(IDX IDX2)
                                       TO  TBL-SRYCD (IDX-S)
           MOVE    TNS-NAME            TO  TBL-NAME  (IDX-S)
           IF      TNS-TANICD          =   ZERO
                                       OR  SPACE
               CONTINUE
           ELSE
               MOVE    TNS-TANINAME        TO  TBL-TANINAME(IDX-S)
               MOVE    1                   TO  TBL-SURYO (IDX-S)
           END-IF
          .
       20041-SRYCD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *   Æþ±¡°õºþ½èÍý
      *****************************************************************
       20042-NYUTBL-HENSYU-SEC                SECTION.
      *
           MOVE    HCM34S01-SRYKBN (IDX)   TO  TBL-SRYKBN
           MOVE    HCM34S01-SRYSYUKBN(IDX) TO  TBL-SRYSYUKBN
      *    ºÞÅÀ¿ô
           MOVE    HCM34S01-ZAITEN (IDX)   TO  TBL-ZAITENSU
      *    ºÞ²ó¿ô
           MOVE    HCM34S01-ZAIKAISU(IDX)  TO  TBL-KAISU
      *    ¶â³Û
      *    ¿©»ö¤Ï¶â³Û
           IF      HCM34S01-ZAISKBKBN(IDX) =   "4"
               COMPUTE TBL-KINGAKU         =  (TBL-ZAITENSU
                                           *   TBL-KAISU )
           ELSE
               COMPUTE TBL-KINGAKU         =  (TBL-ZAITENSU
                                           *   TBL-KAISU )
                                           *   10
           END-IF
      *
      *    Ä¢É¼°õºþ
           PERFORM 2005-PRINT-SYORI-SEC
           .
       20042-NYUTBL-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *   ÁªÄêÆþ±¡ÎÁ´µ¼Ô¼«¸ÊÉéÃ´³Û°õºþ½èÍý
      *****************************************************************
       20043-SENTEI-HENSYU-SEC                SECTION.
      *
           INITIALIZE                  TBL-DATA-AREA
           MOVE    "95"                TO  TBL-SRYKBN
           MOVE    1                   TO  TBL-KAISU
           MOVE    "99999999"          TO  TBL-SRYCD  (1)
           MOVE    "ÁªÄêÆþ±¡ÎÁ¼«¸ÊÉéÃ´³Û"
                                       TO  TBL-NAME   (1)
           MOVE    HCM34S01-SENTEI-PTFTN
                                       TO  TBL-JIHIMONEY(1)
      *    Ä¢É¼°õºþ
           PERFORM 2005-PRINT-SYORI-SEC
           .
       20043-SENTEI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *   ¼«ÈñÊ¬°õºþ½èÍý
      *****************************************************************
       2005-JIHI-SYORI-SEC                SECTION.
      *
           PERFORM VARYING     IDXJ    FROM    1   BY  1
                   UNTIL      (IDXJ    >   50  )   OR
                              (TBL-JIHI-SRYCD(IDXJ)    =   SPACE)
      *        £±ÌÀºÙ£±ºÞ¤È¤¹¤ë
               INITIALIZE                  TBL-DATA-AREA
               MOVE    TBL-JIHI-SRYKBN(IDXJ)   TO  TBL-SRYKBN
               MOVE    TBL-JIHI-KAISU (IDXJ)   TO  TBL-KAISU
               MOVE    TBL-JIHI-SRYSYUKBN(IDXJ)
                                               TO  TBL-SRYSYUKBN
               MOVE    TBL-JIHI-SRYCD(IDXJ)    TO  TBL-SRYCD(1)
               MOVE    TBL-JIHI-NAME(IDXJ)     TO  TBL-NAME(1)
               MOVE    TBL-JIHI-JIHIMONEY(IDXJ)
                                               TO  TBL-JIHIMONEY(1)
      *        Ä¢É¼°õºþÊÔ½¸
               PERFORM 2005-PRINT-SYORI-SEC
           END-PERFORM
      *
           .
       2005-JIHI-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    À¾ÎñÆüËÜ¸ìÊÑ´¹½èÍý
      *****************************************************************
       800-SEIWA-HEN-SEC        SECTION.
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG
           .
       800-SEIWA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿¼ç¥­¡¼ÆÉ¤ß¹þ¤ß½èÍý
      *****************************************************************
       900-SYSKANRI-KEY10-SEC         SECTION.
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key10"             TO  MCP-PATHNAME
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       900-KANRIMST-KEY10-EXT.
           EXIT.
      *****************************************************************
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿ÆÉ¤ß¹þ¤ß½èÍý
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-KANRIMST-READ-EXT.
           EXIT.
      *****************************************************************
      *    ¼õ¿ÇÍúÎò¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       910-JYURRK-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  JYURRK-REC
               MOVE    ZERO            TO  FLG-JYURRK
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           .
       910-JYURRK-READ-EXT.
           EXIT.
      *****************************************************************
      *    ¿ÇÎÅ²ñ·×¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       920-SRYACT-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACT-REC
               MOVE    ZERO            TO  FLG-SRYACT
           ELSE
               INITIALIZE                  SRYACT-REC
               MOVE    1               TO  FLG-SRYACT
           END-IF
      *
           .
       920-SRYACT-READ-EXT.
           EXIT.
      *****************************************************************
      *    ¿ÇÎÅ²ñ·×¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       930-SRYACCT-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACCT-REC
               MOVE    ZERO            TO  FLG-SRYACCT
           ELSE
               INITIALIZE                  SRYACCT-REC
               MOVE    1               TO  FLG-SRYACCT
           END-IF
      *
           .
       930-SRYACCT-READ-EXT.
           EXIT.
      *****************************************************************
      *    ¿ÇÎÅ²ñ·×¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       930-SRYACCTPLUS-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACCTPLUS-REC
               MOVE    ZERO            TO  FLG-SRYACCTPLUS
           ELSE
               INITIALIZE                  SRYACCTPLUS-REC
               MOVE    1               TO  FLG-SRYACCTPLUS
           END-IF
      *
           .
       930-SRYACCTPLUS-READ-EXT.
           EXIT.
      *****************************************************************
      *    ¼ýÇ¼¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       980-SYUNOU-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
               MOVE    ZERO            TO  FLG-SYUNOU
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
           .
       980-SYUNOU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÊÝ¸±ÁÈ¹ç¤»¥Þ¥¹¥¿¡¼ÆÉ¤ß¹þ¤ß
      *****************************************************************
       910-HKNCOMBI-READ-SEC         SECTION.
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    "tbl_hkncombi"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_hkncombi"      TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 920-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  HKNCOMBI-REC
                   MOVE    ZERO            TO  FLG-HKNCOMBI
               ELSE
                   MOVE    1               TO  FLG-HKNCOMBI
               END-IF
           ELSE
               MOVE    1               TO  FLG-HKNCOMBI
           END-IF
     *
           MOVE    "tbl_hkncombi"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       910-HKNCOMBI-READ-EXT.
           EXIT.
      *****************************************************************
      *    ÅÀ¿ô¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       910-TENSU-READ-SEC         SECTION.
      *
           MOVE    WRK-SRYYMD          TO  TNS-YUKOSTYMD
           MOVE    WRK-SRYYMD          TO  TNS-YUKOEDYMD
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_tensu"         TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 920-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
                   MOVE    ZERO                TO  FLG-TENSU
               ELSE
                   INITIALIZE                  TNS-TENSU-REC
                   MOVE    1                   TO  FLG-TENSU
               END-IF
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
           .
       910-TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥Æ¡¼¥Ö¥ë¸¡º÷½èÍý
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    £Ä£ÂÆÉ¤ß¹þ¤ß½èÍý
      *****************************************************************
       920-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       920-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥¯¥í¡¼¥¹½èÍý
      *****************************************************************
       990-DBCLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       990-DBCLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    ½ªÎ»¡¡¡¡½èÍý
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           .
       300-END-EXT.
           EXIT.
      *
