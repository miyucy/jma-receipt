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
       PROGRAM-ID.             ORCHC03.
      *****************************************************************
      *  ¥·¥¹¥Æ¥àÌ¾        : £Ï£Ò£Ã£Á
      *  ¥µ¥Ö¥·¥¹¥Æ¥àÌ¾    : ´µ¼ÔÅÐÏ¿
      *  ¥³¥ó¥Ý¡¼¥Í¥ó¥ÈÌ¾  : ÀÁµá½ñ·óÎÎ¼ý½ñ¡¡°õºþ¡Ê£È£Ã£°£³¡Ë
      *  ´ÉÍý¼Ô            : 
      *  ºîÀ®ÆüÉÕ    ºî¶È¼Ô        µ­½Ò
      *  00/12/01    MCC¡ÝÂ¿¡¹Ç¼   ¿·µ¬ºîÀ®
      *****************************************************************
      *  ¥×¥í¥°¥é¥à½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      *  01.00.01    MCC-Æ£¸¶     01/10/03  ½ÐÎÏÀè¥×¥ê¥ó¥¿Ì¾ÊÔ½¸
      *  01.00.01    MCC-Æ£¸¶     02/03/18  Ä¢É¼¥Õ¥¡¥¤¥ëÌ¾¤ÎÊÑ¹¹
      *  01.00.02    MCC-Â¿¡¹Ç¼   02/05/01  ¥Þ¥¤¥Ê¥¹É½¼¨¤ò¹Ô¤¦¤è¤¦¤Ë¤·¤¿
      *  01.00.03    NACL-Â¿¡¹Ç¼  02/09/13  ¼«ÇåÀÕ¡¦°õºþ¥µ¥×¤ÎÄÉ²Ã
      *  01.00.04    NACL-Â¿¡¹Ç¼  02/11/15  ¼«Èñ¾ÃÈñÀÇÂÐ±þ½¤Àµ
      *  01.00.05    NACL-Â¿¡¹Ç¼  03/03/04  Ê£¿ô¿ÇÎÅ²Ê¤Þ¤È¤áÄÉ²Ã
      *  01.00.06    NACL-Â¿¡¹Ç¼  03/04/15  Ï«ºÒÊÔ½¸½¤Àµ
      *  01.00.07    NACL-Â¿¡¹Ç¼  03/05/13  ¼«ÇåÀÕÀÁµá½¤Àµ
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
           COPY    "HC03.INC".
      *
       WORKING-STORAGE             SECTION.
      *
      *     °õºþÍÑ¥Ç¡¼¥¿ Ì¾¾ÎÎÎ°è 
           COPY    "CPCOMMONPRT.INC".
      *    ¥·¥§¥ëÍÑÎÎ°è
      **** COPY    "CPCOMMONSHELL.INC".
      *
      *    ¥·¥§¥ëÍÑÎÎ°è
      *    COPY    "CPSHELLTBL.INC".
      *****COPY    "ORCA-DBPATH".
      *
      *
      *    ¥Õ¥é¥°ÎÎ°è
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
      *
      *    ¥Õ¥é¥°ÎÎ°è
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-PARA            PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-SYUNOU          PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
           03  FLG-SP              PIC 9(01).
           03  FLG-OK              PIC 9(01).
           03  FLG-CHK             PIC 9(01).
      *
      *    Åº»úÎÎ°è
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDX-Z               PIC 9(04).
           03  IDX-S               PIC 9(04).
           03  IDX-MAX             PIC 9(04).
           03  IDXA                PIC 9(04).
           03  IDX-ACT             PIC 9(02).
           03  IDX-REN             PIC 9(04).
           03  IDX-JYU             PIC 9(04).
      *
           03  IDX2                PIC 9(02).
           03  IDX3                PIC 9(02).
           03  IDXP                PIC 9(02).
           03  IDXM                PIC 9(02).
           03  IDK                 PIC 9(04).
           03  IDX2-1              PIC 9(01).
      *
      *    ¥·¥¹¥Æ¥àÎÎ°è
       01  SYS-AREA.
           03  SYS-TIME            PIC 9(08).
      *
      *    °ì»þÎÎ°è
       01  WRK-AREA.
      *
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WYY         PIC X(03).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-HENYMDG         PIC X(22).
      *
           03  WRK-HKNCOMBI        PIC X(40).
      *
           03  WRK-SKYMONEY        PIC S9(11).
           03  WRK-MISYUMONEY      PIC S9(11).
           03  WRK-MISYU           PIC S9(11).
           03  WRK-GOKTEN          PIC S9(11).
      *
           03  WRK-DENPNUM         PIC 9(07).
      *
           03  WRK-WARI            PIC 9(02)V9.
           03  WRK-Z6              PIC ZZZZZZ.
           03  WRK-Z62             PIC ZZZ9.9.
      *
           03  WRK-ZZZ             PIC ZZZ.
           03  WRK-NO              PIC Z(7).
           03  WRK-Z7-G.
               05  WRK-FIL             PIC X(09).
               05  WRK-Z7              PIC Z,ZZZ,ZZZ.
           03  WRK-Z72-G.
               05  WRK-FIL2            PIC X(09).
               05  WRK-Z72             PIC -,---,---.
      *    ¼«Èñ½¸·×
           03  WRK-JIHI-REC.
               05  WRK-JIHI            PIC S9(07)   OCCURS  5.
           03  WRK-JIHI-TOTAL          PIC S9(08).
      *
      *    Ê£¿ô²Ê¤Þ¤È¤á½¸·×
           03  WRK-HKNTEN-KIN              PIC 9(07).
           03  WRK-HKNTEN-KEI              PIC 9(07)V99.
           03  WRK-NYUKIN                  PIC 9(07).
      *
           03  WRK-SRYKA-MEI               PIC X(30).
      *
      *    Ê¸»úÊÑ´¹
           03  WRK-ZENKAKU-G.
               05  WRK-ZENKAKU         PIC X(02)   OCCURS   10.
           03  WRK-MOJI                PIC X(10).
           03  WRK-MOJISU              PIC 9(02).
      *
      *   ÆüËÜ¸ì¿ô»ú
       01  TBL-SUJI-AREA.
           03  FILLER          PIC X(20)   VALUE
              "£±£²£³£´£µ£¶£·£¸£¹£°".
       01  TBL-SUJI-R          REDEFINES   TBL-SUJI-AREA.
           03  TBL-SUJI        PIC X(02)   OCCURS   10.
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
      *
           COPY    "CPSK1010.INC".
      *
           COPY    "CPSK1013.INC".
      *
      *    Ï«ºÒ°åÎÅµ¡´Ø¾ðÊó
           COPY    "CPSK4001.INC".
      *
      *    ½ÐÎÏÀè¥×¥ê¥ó¥¿Ì¾³ä¤êÅö¤Æ¾ðÊó
           COPY  "CPSK1031.INC".
      *
      *    ´µ¼Ô¥Þ¥¹¥¿
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    ÊÝ¸±¥Þ¥¹¥¿
       01  PTHKNINF-REC.
           COPY    "CPPTHKNINF.INC".
      *
      *    ¼ýÇ¼
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    ÊÝ¸±ÁÈ¹ç¤»
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    ÊÝ¸±¥Þ¥¹¥¿
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
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
      *
      *    ¼õ¿ÇÍúÎò
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *    ÊÝÂ¸ÍÑ¼ýÇ¼¥ï¡¼¥¯
       01  WRK-SYUNOU-REC.
           COPY    "CPSYUNOU.INC"  REPLACING
                                     //SYU-// BY //WRK-SYU-//.
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
      *
      *    °õºþ¥Ñ¥é¥á¥¿
           COPY    "CPORCSMKPRT.INC".
      *
      *01  MCPDATA-REC                 PIC X(5000).
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
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
      *    ½èÊýäµ¶¦ÄÌ¥Ñ¥é¥á¥¿
           COPY    "CPORCHC03.INC".
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           ORCHC03AREA
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
      *
      *    ³Æ£Ä£ÂÆÉ¹þ
           PERFORM 100-SYORI-SEC
      *
      *    Ä¢É¼°õºþ³«»Ï½èÍý
           PERFORM 400-SYOKI-PRINT-SEC
      *
      *    Ä¢É¼ÊÔ½¸½èÍý
           PERFORM 300-HC03-HEN-SEC
      *
      *    Ä¢É¼°õºþ½èÍý
           PERFORM 400-PRINT-SEC
      *
           .
       000-PROC-EXT.
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    Ä¢É¼°õºþ³«»Ï½èÍý
      *****************************************************************
       400-SYOKI-PRINT-SEC             SECTION.
      *
      *    ¥Õ¥¡¥¤¥ë£Ï£Ð£Å£Î
           MOVE    "HC03"              TO  HC01PARA-FORM-ID
           MOVE    SPA-TERMID          TO  HC01PARA-TERMID
           MOVE    SYS-TIME            TO  HC01PARA-SYOHMS
      *    ÊÑ¹¹¡ú¡ú¡ú¡ú¡ú¡ú
           MOVE    "001"               TO  HC01PARA-CNT
           OPEN    OUTPUT               PRT-FILE
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
      *
      *¡¡¡¡°õºþÍÑ¥Ç¡¼¥¿½ÐÎÏ
              WRITE  HC03
      *
      ******MOVE   "HC01.sh"           TO  SHELL-ID
      *     MOVE   "HC03.dia"          TO  SHELL-DIA
      *     MOVE   "HC03.def"          TO  SHELL-DEF
      *     MOVE   HC01PARA            TO  SHELL-DAT
      ***** MOVE   SYS-1031-PRTNM(3)   TO  SHELL-PRTNM 
            CLOSE                       PRT-FILE
      *
            INITIALIZE                 ORCSMKPRTAREA
            MOVE   "HC01.sh"           TO  MKPRT-ID
            MOVE   "HC03.dia"          TO  MKPRT-DIA
            MOVE   "HC03.def"          TO  MKPRT-DEF
            MOVE   HC01PARA            TO  MKPRT-DAT
            MOVE   SYS-1031-PRTNM(3)   TO  MKPRT-PRTNM
            CALL   "ORCSMKPRT"         USING
                                       ORCSMKPRTAREA
      *
      *   °õºþÍÑ¥¹¥¯¥ê¥×¥È½èÍý
      *¡ú   ETC-EXEC SHELL   SHELL-AREA 10
      *    MOVE    SHELL-NAME          TO  SHELLTBL-NAME
      *    MOVE    SHELL-ARG1          TO  SHELLTBL-ARG1
      *    MOVE    SHELL-ARG2          TO  SHELLTBL-ARG2
      *    MOVE    SHELL-ARG3          TO  SHELLTBL-ARG3
      *    MOVE    SHELL-ARG4          TO  SHELLTBL-ARG4
      *    MOVE    SHELL-ARG5          TO  SHELLTBL-ARG5
      *    MOVE    SHELLTBL            TO  MCPDATA-REC
      *    MOVE    "SHELL"             TO  MCP-FUNC
      *    MOVE    PATH-SHELL-SHELL    TO  MCP-PATH
      *    CALL    "MCPSUB"            USING
      *            MCPAREA
      **********   MCPDATA-REC
      *
      *
           .
       400-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ½é´üÊÔ½¸½èÍý
      *****************************************************************
       100-SYORI-SEC                SECTION.
      *
      *    °åÎÅµ¡´Ø¾ðÊó¡Ý½êºßÃÏ¡¢Ï¢ÍíÀè
           MOVE    SPACE               TO  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    ZERO                TO  SYS-1001-STYUKYMD
           MOVE    ALL "9"             TO  SYS-1001-EDYUKYMD
      *    ¥·¥¹¥Æ¥à´ÉÍý¸¡º÷
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-1001-REC
               END-IF
           ELSE
               INITIALIZE                  SYS-1001-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *
      *    °åÎÅµ¡´Ø¾ðÊó¡Ý½êºßÃÏ¡¢Ï¢ÍíÀè
           MOVE    SPACE               TO  SYS-1002-REC
           MOVE    "1002"              TO  SYS-1002-KANRICD
           MOVE    "*"                 TO  SYS-1002-KBNCD
           MOVE    ZERO                TO  SYS-1002-STYUKYMD
           MOVE    ALL "9"             TO  SYS-1002-EDYUKYMD
      *    ¥·¥¹¥Æ¥à´ÉÍý¸¡º÷
           MOVE    SYS-1002-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-1002-REC
               END-IF
           ELSE
               INITIALIZE                  SYS-1002-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    ½ÐÎÏÀè¥×¥ê¥ó¥¿Ì¾³ä¤êÅö¤Æ¾ðÊóÊÔ½¸
           MOVE    SPACE               TO  SYS-1031-REC
           INITIALIZE                  SYS-1031-REC
           MOVE    "1031"              TO  SYS-1031-KANRICD
           MOVE    "*"                 TO  SYS-1031-KBNCD
           MOVE    SYS-1031-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-1031-REC
               END-IF
           ELSE
               INITIALIZE                  SYS-1031-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    Ï«ºÒ°åÎÅµ¡´Ø¾ðÊóÊÔ½¸
           MOVE    SPACE               TO  SYS-4001-REC
           INITIALIZE                  SYS-4001-REC
           MOVE    "4001"              TO  SYS-4001-KANRICD
           MOVE    "*"                 TO  SYS-4001-KBNCD
           MOVE    SYS-4001-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-4001-REC
               END-IF
           ELSE
               INITIALIZE                  SYS-4001-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    ¼ýÇ¼¥Þ¥¹¥¿¸¡º÷
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-PTID            TO  SYU-PTID
           MOVE    ORCHC03-DENPNUM     TO  SYU-DENPNUM
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           MOVE    SPACE                TO  WRK-SRYKA-MEI
      *    ¿ÇÎÅ²ÊÌ¾ÊÔ½¸
           PERFORM 1000-SRYKAMEI-HEN-SEC
      *
      *    Ê£¿ô²Ê¤Þ¤È¤á¤¬¤¢¤ë»þ¡¢¼ýÇ¼¤ò½¸·×¤¹¤ë
           IF      ORCHC03-FUKU-DENPNUM    NOT =   ZERO
               PERFORM 1001-FUKU-SYUNOU-SEC
           END-IF
      *
      *    ÊÝ¸±ÁÈ¹ç¤»¥Þ¥¹¥¿¡¼¸¡º÷
           INITIALIZE                      HKNCOMBI-REC
           MOVE    SPA-HOSPID          TO  COMB-HOSPID
           MOVE    SPA-PTID            TO  COMB-PTID
           MOVE    SYU-HKNCOMBINUM     TO  COMB-HKNCOMBINUM
           PERFORM 910-HKNCOMBI-READ-SEC
           IF      FLG-HKNCOMBI        =   1
                DISPLAY "*** HKNCOMBI  ERR:"   COMB-KEY "."
           END-IF
           PERFORM 1001-HKNCOMBI-HEN-SEC
      *
           .
       100-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    ÊÝ¸±ÁÈ¹ç¤»Ì¾¾ÎÊÔ½¸½èÍý
      *****************************************************************
       1001-HKNCOMBI-HEN-SEC             SECTION.
      *
           MOVE    SPACE               TO  WRK-HKNCOMBI
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
                         INTO              WRK-HKNCOMBI
           END-STRING
      *
           .
       1001-HKNCOMBI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¿ÇÎÅ²ÊÌ¾ÊÔ½¸½èÍý
      *****************************************************************
       1000-SRYKAMEI-HEN-SEC                SECTION.
      *
      *    ¿ÇÎÅ²Ê
           MOVE    SPACE               TO  SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    SYU-SRYKA           TO  SYS-1005-KBNCD
           MOVE    ZERO                TO  SYS-1005-STYUKYMD
           MOVE    ALL "9"             TO  SYS-1005-EDYUKYMD
      *    ¥·¥¹¥Æ¥à´ÉÍý¸¡º÷
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               INITIALIZE                  SYS-1005-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI              =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1005-REC
               IF      WRK-SRYKA-MEI       =   SPACE
                   MOVE    SYS-1005-SRYKANAME2
                                               TO  WRK-SRYKA-MEI
               ELSE
                   IF      WRK-SRYKA-MEI(19:2) NOT =   SPACE
                       CONTINUE
                   ELSE
                       STRING  WRK-SRYKA-MEI   DELIMITED  BY  SPACE
                               "¡¢"            DELIMITED  BY  SIZE
                               SYS-1005-SRYKANAME2
                                               DELIMITED  BY  SPACE
                               INTO                WRK-SRYKA-MEI
                       END-STRING
                   END-IF
               END-IF
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       1000-SRYKAMEI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ê£¿ô²Ê¤Þ¤È¤áÊÔ½¸½èÍý
      *****************************************************************
       1001-FUKU-SYUNOU-SEC                SECTION.
      *
           MOVE    SPACE                TO  WRK-SRYKA-MEI
           INITIALIZE                  WRK-SYUNOU-REC
      *
      *    ¼ýÇ¼¥Þ¥¹¥¿¸¡º÷
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-PTID            TO  SYU-PTID
           MOVE    ORCHC03-FUKU-DENPNUM
                                       TO  SYU-FUKU-DENPNUM
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY12"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYUNOU-KEY12"      TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
           MOVE    ZERO                TO  FLG-CHK
           PERFORM UNTIL    FLG-SYUNOU     =   1
      *
               IF      FLG-CHK             =   ZERO
                   MOVE    SYUNOU-REC          TO  WRK-SYUNOU-REC
      *            Æþ¶â³Û¤Ï¥¯¥ê¥¢¤·¤Æ¤ª¤¯
                   MOVE    ZERO                TO  WRK-SYU-NYUKIN-TOTAL
                   MOVE    ZERO                TO  WRK-SYU-CHOSEI
                   MOVE    1                   TO  FLG-CHK
               ELSE
                   PERFORM 10011-SYUNOU-ADD-SEC
               END-IF
      *        º£²óÆþÎÏÊ¬°Ê³°¤ÎÆþ¶â³Û½¸·×
               IF      SYU-DENPNUM     NOT =   ORCHC03-DENPNUM
      *            Æþ¶â³Û
                   ADD     SYU-NYUKIN-TOTAL    TO  WRK-SYU-NYUKIN-TOTAL
      *            Ä´À°¶â
                   ADD     SYU-CHOSEI          TO  WRK-SYU-CHOSEI
               END-IF
      *
      *        ¿ÇÎÅ²ÊÌ¾ÊÔ½¸
               PERFORM 1000-SRYKAMEI-HEN-SEC
      *
               MOVE    "SYUNOU-KEY12"      TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    Ä´À°¶â
           COMPUTE WRK-SYU-CHOSEI       =   WRK-SYU-CHOSEI
                                        +   ORCHC03-KON-CHOSEI
      *    ÊÝ¸±Å¬ÍÑ¶â³ÛºÆ·×»»
      *
      *    ½¸·×¤ÎÅÀ¿ô¤«¤éÉéÃ´³Û·×»»
           COMPUTE WRK-HKNTEN-KEI      =  (WRK-SYU-TOTAL-HKNTEN  *  10 )
                                       *  (SPA-FTNRATE   /  100)
           COMPUTE WRK-HKNTEN-KIN      =  (WRK-HKNTEN-KEI
                                       +   5  )
                                       /   10
           COMPUTE WRK-HKNTEN-KIN      =   WRK-HKNTEN-KIN
                                       *   10
           MOVE    WRK-HKNTEN-KIN      TO  WRK-SYU-HKNTEKMONEY
      *
      *    ¹ç·×¤·¤¿¼ýÇ¼¤òÊÔ½¸
           MOVE    WRK-SYUNOU-REC       TO  SYUNOU-REC
      *
           .
       1001-FUKU-SYUNOU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¹ç·×ÀÁµá³Û·×»»½èÍý
      *****************************************************************
       10011-SYUNOU-ADD-SEC           SECTION.
      *
      *    ÀÁµá³Û
           ADD     SYU-SKYMONEY        TO  WRK-SYU-SKYMONEY
      *    ÅÀ¿ô
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   12
               ADD     SYU-HKNTEN (IDX)    TO  WRK-SYU-HKNTEN (IDX)
               ADD     SYU-MONEY  (IDX)    TO  WRK-SYU-MONEY  (IDX)
               ADD     SYU-TGMONEY (IDX)   TO  WRK-SYU-TGMONEY(IDX)
               ADD     SYU-TGMONEY-TAX (IDX)
                                           TO  WRK-SYU-TGMONEY-TAX(IDX)
           END-PERFORM
      *    ¼«Èñ
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               ADD     SYU-JIHI-TAXNASI (IDX)
                                           TO  WRK-SYU-JIHI-TAXNASI(IDX)
               ADD     SYU-JIHI-TAXARI (IDX)
                                           TO  WRK-SYU-JIHI-TAXARI (IDX)
           END-PERFORM
           ADD     SYU-JIHI-TOTAL      TO  WRK-SYU-JIHI-TOTAL
           ADD     SYU-JIHI-TOTAL-TAX  TO  WRK-SYU-JIHI-TOTAL-TAX
           ADD     SYU-JIHI-TAX        TO  WRK-SYU-JIHI-TAX
      *
      *    ³Æ¶â³Û
           ADD     SYU-RJN-FTN         TO  WRK-SYU-RJN-FTN
           ADD     SYU-KOH-FTN         TO  WRK-SYU-KOH-FTN
           ADD     SYU-YKZ-FTN         TO  WRK-SYU-YKZ-FTN
           .
       10011-SYUNOU-ADD-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ä¢É¼ÊÔ½¸½èÍý
      *****************************************************************
       300-HC03-HEN-SEC                SECTION.
      *
           INITIALIZE                  HC03
      *
      *    ÅÁÉ¼ÈÖ¹æ
           MOVE    ORCHC03-DENPNUM     TO  WRK-NO  
           MOVE    WRK-NO              TO  HC03-NO
      *    ¿ÇÎÅ²Ê
      *****MOVE    SYS-1005-SRYKANAME2 TO  HC03-MIDASI
           MOVE    WRK-SRYKA-MEI(1:20) TO  HC03-MIDASI
      *    ´µ¼ÔÈÖ¹æ
           MOVE    SPA-PTNUM           TO  HC03-KNJNO
      *    ´µ¼ÔÌ¾¾Î
           MOVE    SPA-NAME            TO  HC03-KNJNAMW
      *    ÊÝ¸±¼ïÊÌ
           MOVE    WRK-HKNCOMBI        TO  HC03-HOKEN
      *    ÉéÃ´³ä¹ç
           IF      SYU-PTFTNRATE       >   ZERO
               COMPUTE WRK-WARI        =   SYU-PTFTNRATE   /   10
               IF      SYU-PTFTNRATE(3:1)  =   ZERO
                   MOVE    WRK-WARI            TO  WRK-Z6
                   MOVE    WRK-Z6              TO  HC03-FUTAN
               ELSE
                   MOVE    WRK-WARI            TO  WRK-Z62
                   MOVE    WRK-Z62             TO  HC03-FUTAN
               END-IF
           END-IF
      *    ¿ÇÎÅÆü
           MOVE    SYU-SRYYMD          TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  HC03-SRYYMD
      *    È¯¹ÔÆü
           MOVE    SYU-DENPPRTYMD      TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  HC03-HAKYMD
      *
      *    °åÎÅµ¡´Ø½»½ê
           MOVE    SYS-1002-ADRS       TO  HC03-IRYOADRS
      *    °åÎÅµ¡´ØÌ¾
           MOVE    SYS-1001-HOSPNAME   TO  HC03-IRYOMEI
      *    °åÎÅµ¡´Ø£Ô£Å£Ì
           MOVE    SYS-1002-TEL        TO  HC03-IRYOTEL
      *    ¼«ÈñÌ¾¾ÎÊÔ½¸
           PERFORM 3102-JIHIMSG-HEN-SEC
      *
           MOVE    SPACE               TO  WRK-Z7-G
           MOVE    SPACE               TO  WRK-Z72-G
      *    ¿ÇÎÅ²Ê
           MOVE    SYU-HKNTEN (01)     TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-HKNRYO1
      *    »ØÆ³²Ê
           MOVE    SYU-HKNTEN (02)     TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-HKNRYO2
      *    ºßÂð²Ê
           MOVE    SYU-HKNTEN (03)     TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-HKNRYO3
      *    ÅêÌô²Ê
           MOVE    SYU-HKNTEN (04)     TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-HKNRYO4
      *    Ãí¼Í²Ê
           MOVE    SYU-HKNTEN (05)     TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-HKNRYO5
      *    ½èÃÖ²Ê
           MOVE    SYU-HKNTEN (06)     TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-HKNRYO6
      *    ¼ê½Ñ²Ê
           MOVE    SYU-HKNTEN (07)     TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-HKNRYO7
      *    ¸¡ºº²Ê
           MOVE    SYU-HKNTEN (08)     TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-HKNRYO8
      *    £ØÀþ²Ê
           MOVE    SYU-HKNTEN (09)     TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-HKNRYO9
      *    ¤½¤ÎÂ¾ÎÁ
           MOVE    SYU-HKNTEN (10)     TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-HKNRYO10
      *    ¹ç·×ÅÀ¿ô
           COMPUTE WRK-GOKTEN          =   SYU-HKNTEN (01)
                                       +   SYU-HKNTEN (02)
                                       +   SYU-HKNTEN (03)
                                       +   SYU-HKNTEN (04)
                                       +   SYU-HKNTEN (05)
                                       +   SYU-HKNTEN (06)
                                       +   SYU-HKNTEN (07)
                                       +   SYU-HKNTEN (08)
                                       +   SYU-HKNTEN (09)
                                       +   SYU-HKNTEN (10)
           MOVE    WRK-GOKTEN          TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-GOKTEN
      *
      *    Ï«ºÒ¡¦¼«Çå¤Î»þ¡¢ÅÀ¿ôÉ½¼¨¤Ê¤·
           IF      SPA-HKNKBN          =   1
               MOVE    SPACE               TO  HC03-HKNRYO1
               MOVE    SPACE               TO  HC03-HKNRYO2
               MOVE    SPACE               TO  HC03-HKNRYO3
               MOVE    SPACE               TO  HC03-HKNRYO4
               MOVE    SPACE               TO  HC03-HKNRYO5
               MOVE    SPACE               TO  HC03-HKNRYO6
               MOVE    SPACE               TO  HC03-HKNRYO7
               MOVE    SPACE               TO  HC03-HKNRYO8
               MOVE    SPACE               TO  HC03-HKNRYO9
               MOVE    SPACE               TO  HC03-HKNRYO10
               MOVE    ALL "*"             TO  HC03-GOKTEN
           END-IF
      *
      *    ÊÝ¸±Å¬ÍÑÊ¬
           MOVE    SYU-HKNTEKMONEY     TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-HOKENBUN
      *    Ï«ºÒ¡¦¼«Çå¤Î»þ¡¢ÅÀ¿ôÉ½¼¨¤Ê¤·
           IF      SPA-HKNKBN          =   1
      *        ¼«Çå¡¦Ï«ºÒÈó»ØÄê°åÎÅµ¡´Ø
      ******** IF     (SPA-RSI-HKNKBN      =    "4" )  OR
               IF    ((SPA-RSI-HKNKBN      =    "4" )  AND
                      (SYU-PTFTNRATE   NOT =   ZERO  ))  OR
                      (SYS-4001-RSIIRYOKBN NOT =   "1" )
                   COMPUTE WRK-GOKTEN      =    SYU-HKNTEKMONEY
                                           +    SYU-RSISHOSHIN-MONEY
                                           +    SYU-RSISAISHIN-MONEY
                                           +    SYU-RSISDO-MONEY
                                           +    SYU-RSIETC-MONEY
                   MOVE    WRK-GOKTEN          TO  WRK-Z7
                   MOVE    WRK-Z7-G            TO  HC03-HOKENBUN
               ELSE
                   MOVE    SPACE               TO  HC03-HOKENBUN
               END-IF
           END-IF
      *
      *    ÊÝ¸±Å¬ÍÑ³°Ê¬
           MOVE    ZERO                TO  WRK-GOKTEN
      **** PERFORM VARYING     IDX     FROM    1   BY  1
      *            UNTIL       IDX     >   10
      *        COMPUTE WRK-GOKTEN      =   WRK-GOKTEN
      *                                +  (SYU-TGMONEY (IDX)
      *                                +   SYU-TGMONEY-TAX  (IDX) )
      *****END-PERFORM
           COMPUTE WRK-GOKTEN          =   SYU-TGMONEY (12)
                                       +   SYU-TGMONEY-TAX  (12)
      *****MOVE    SYU-TOTAL-TGMONEY   TO  WRK-Z72
           MOVE    WRK-GOKTEN          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HOKENGAI
      *    ¼«Èñ£±
           MOVE    ZERO                TO  WRK-JIHI-REC
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               COMPUTE WRK-JIHI (IDX)      =   SYU-JIHI-TAXNASI (IDX)
                                           +   SYU-JIHI-TAXARI  (IDX)
           END-PERFORM
      *
           MOVE    WRK-JIHI (1)        TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-JIHI1
           MOVE    WRK-JIHI (2)        TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-JIHI2
           MOVE    WRK-JIHI (3)        TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-JIHI3
           MOVE    WRK-JIHI (4)        TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-JIHI4
           MOVE    WRK-JIHI (5)        TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-JIHI5
      *    ¼«Èñ·×
           COMPUTE WRK-JIHI-TOTAL      =   SYU-JIHI-TOTAL
                                       +   SYU-JIHI-TOTAL-TAX
           MOVE    WRK-JIHI-TOTAL      TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-JIHI6
      *    ¼«Èñ¾ÃÈñÀÇ
           MOVE    SYU-JIHI-TAX        TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-JIHI7
      *    ¼«Èñ¹ç·×
           COMPUTE WRK-GOKTEN          =   WRK-JIHI-TOTAL
                                       +   SYU-JIHI-TAX
           MOVE    WRK-GOKTEN          TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-JIHI8
      *    ÌôºÞ°ìÉôÉéÃ´
           MOVE    SYU-YKZ-FTN         TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-YAKUZAI
      *    Ï·¿Í°ìÉôÉéÃ´¶â
           MOVE    SYU-RJN-FTN         TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-ROUJIN
      *    ¸øÈñ°ìÉôÉéÃ´¶â
           MOVE    SYU-KOH-FTN         TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-KOUHI
      *    Ê£¿ô²Ê¤Þ¤È¤á¤Î»þ¡¢¡ö¤È¤¹¤ë
           IF      ORCHC03-FUKU-DENPNUM    >   ZERO
               IF      SYU-RJN-FTN         >   ZERO
                   MOVE    ALL "*"             TO  HC03-ROUJIN
               END-IF
               IF      SYU-KOH-FTN         >   ZERO
                   MOVE    ALL "*"             TO  HC03-KOUHI
               END-IF
           END-IF
      *
      *    Ä´À°¶â
           MOVE    SYU-CHOSEI          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-CHOSEI
      *    º£²óÀÁµá³Û
           MOVE    ORCHC03-SEIKYU      TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-KONSEIKYU
           MOVE    ORCHC03-SEIKYU      TO  WRK-SKYMONEY
      *    Ê£¿ô²Ê¤Þ¤È¤á¤Î»þ¡¢¤Þ¤È¤á³Û
           IF      ORCHC03-FUKU-DENPNUM    >   ZERO
               MOVE    ORCHC03-KON-SEIKYU  TO  WRK-Z72
               PERFORM 800-HENKAN-SEC
               MOVE    WRK-Z72-G           TO  HC03-KONSEIKYU
               MOVE    ORCHC03-KON-SEIKYU  TO  WRK-SKYMONEY
           END-IF
      *
      *    º£²óÆþ¶â³Û
      *****MOVE    SYU-NYUKIN-TOTAL    TO  WRK-Z7
           MOVE    ORCHC03-NYUKIN      TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-KONNYUKIN
      *    Ê£¿ô²Ê¤Þ¤È¤á¤Î»þ¡¢¤Þ¤È¤á³Û
           IF      ORCHC03-FUKU-DENPNUM    >   ZERO
               MOVE    SPACE               TO  HC03-KONNYUKIN
               MOVE    SPACE               TO  WRK-Z7-G
               COMPUTE WRK-NYUKIN          =   SYU-NYUKIN-TOTAL
                                           +   ORCHC03-NYUKIN
               MOVE    WRK-NYUKIN          TO  WRK-Z7
               MOVE    WRK-Z7-G            TO  HC03-KONNYUKIN
           END-IF
      *    Á°²óÌ¤¼ý³Û·×»»
           PERFORM 3101-MISYU-HEN-SEC
           MOVE    WRK-MISYUMONEY      TO  WRK-Z7
           MOVE    WRK-Z7-G            TO  HC03-ZENMISYU
      *    ¹ç·×ÀÁµá³Û
           COMPUTE WRK-GOKTEN          =   WRK-SKYMONEY
                                       +   WRK-MISYUMONEY
           MOVE    WRK-GOKTEN          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-GOUKEIGAK
           .
       300-HC03-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    È¾³ÑÁ´³ÑÊÑ´¹½èÍý
      *****************************************************************
       800-HENKAN-SEC             SECTION.
     *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"                 TO  KANACHK-SYORI
           MOVE    WRK-Z72             TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF      KANACHK-RC          =   ZERO
               MOVE    KANACHK-OUT-INPUT(1:18)    TO  WRK-Z72-G
           END-IF
           .
       800-HENKAN-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ì¤¼ý¶â³ÛÊÔ½¸½èÍý
      *****************************************************************
       3101-MISYU-HEN-SEC             SECTION.
      *
           MOVE    ZERO                TO  WRK-MISYUMONEY
           MOVE    SYU-DENPNUM         TO  WRK-DENPNUM
      *    ¼ýÇ¼¥Æ¡¼¥Ö¥ëÆÉ¤ß¹þ¤ß
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-PTID            TO  SYU-PTID
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
           MOVE    ZERO                TO  WRK-MISYUMONEY
           PERFORM
               UNTIL     FLG-SYUNOU    =   1
               IF      ORCHC03-FUKU-DENPNUM    =   ZERO
                   IF      SYU-DENPNUM     NOT =   WRK-DENPNUM
                       COMPUTE WRK-MISYU       =   SYU-SKYMONEY
                                               -   SYU-NYUKIN-TOTAL
                       ADD     WRK-MISYU           TO  WRK-MISYUMONEY
                   END-IF
               ELSE
                   IF      SYU-FUKU-DENPNUM    =   ORCHC03-FUKU-DENPNUM
                       CONTINUE
                   ELSE
                       COMPUTE WRK-MISYU       =   SYU-SKYMONEY
                                               -   SYU-NYUKIN-TOTAL
                       ADD     WRK-MISYU           TO  WRK-MISYUMONEY
                   END-IF
               END-IF
      *
               MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       3101-MISYU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼«ÈñÌ¾¾ÎÊÔ½¸½èÍý
      *****************************************************************
       3102-JIHIMSG-HEN-SEC             SECTION.
      *
      *    °åÎÅµ¡´Ø¾ðÊó¡Ý½êºßÃÏ¡¢Ï¢ÍíÀè
           MOVE    SPACE               TO  SYS-1013-REC
           MOVE    "1013"              TO  SYS-1013-KANRICD
           MOVE    ZERO                TO  SYS-1013-STYUKYMD
           MOVE    ALL "9"             TO  SYS-1013-EDYUKYMD
      *    ¥·¥¹¥Æ¥à´ÉÍý¸¡º÷
           MOVE    SYS-1013-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-1013-REC
               END-IF
           ELSE
               INITIALIZE                  SYS-1013-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           PERFORM
               UNTIL       FLG-SYSKANRI    =   1
               IF      SPA-NYUGAIKBN       =   SYS-1013-KBNCD(1:1)
                   EVALUATE    SYS-1013-KBNCD(2:1)
                       WHEN    "1"
                           MOVE    SYS-1013-JIHINAME   TO  HC03-JIHIMSG1
                       WHEN    "2"
                           MOVE    SYS-1013-JIHINAME   TO  HC03-JIHIMSG2
                       WHEN    "3"
                           MOVE    SYS-1013-JIHINAME   TO  HC03-JIHIMSG3
                       WHEN    "4"
                           MOVE    SYS-1013-JIHINAME   TO  HC03-JIHIMSG4
                       WHEN    "5"
                           MOVE    SYS-1013-JIHINAME   TO  HC03-JIHIMSG5
                   END-EVALUATE
               END-IF
      *
               MOVE    "SYSKANRI-KEY2"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-1013-REC
               END-IF
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       3102-JIHIMSG-HEN-EXT.
           EXIT.
      *****************************************************************
      *    À¾ÎñÆüËÜ¸ìÊÑ´¹½èÍý
      *****************************************************************
       31012-SEIWA-HEN-SEC        SECTION.
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG
           .
       31012-SEIWA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    Á´³ÑÊÑ´¹½èÍý
      *****************************************************************
       2009-HENKAN-SEC                 SECTION.
      *
           MOVE    ALL "¡¡"            TO  WRK-ZENKAKU-G
      *
           PERFORM VARYING     IDK     FROM    1   BY  1
                   UNTIL       IDK     >   WRK-MOJISU
               IF      WRK-MOJI (IDK:1)    NUMERIC
                   MOVE    WRK-MOJI(IDK:1)     TO  IDX2-1
                   IF      IDX2-1              =   ZERO
                       MOVE    10                  TO  IDX2
                   ELSE
                       MOVE    IDX2-1              TO  IDX2
                   END-IF
                   MOVE    TBL-SUJI (IDX2)     TO  WRK-ZENKAKU(IDK)
               ELSE
                   IF      WRK-MOJI (IDK:1)    =   "."
                       MOVE    "¡¥"            TO  WRK-ZENKAKU(IDK)
                   END-IF
               END-IF
           END-PERFORM
           .
       2009-HENKAN-EXT.
           EXIT.
      *****************************************************************
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿ÆÉ¤ß¹þ¤ß½èÍý
      *****************************************************************
       900-KANRIMST-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-KANRIMST-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ´µ¼Ô¥Þ¥¹¥¿¡¼ÆÉ¤ß¹þ¤ß
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTINF-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  PTINF-REC
                   MOVE    ZERO            TO  FLG-PTINF
               ELSE
                   MOVE    1               TO  FLG-PTINF
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTINF
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *****************************************************************
      *    ¼ýÇ¼¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       980-SYUNOU-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
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
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
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
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       910-HKNCOMBI-READ-EXT.
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
