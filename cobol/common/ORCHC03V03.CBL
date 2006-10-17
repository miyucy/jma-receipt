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
       PROGRAM-ID.             ORCHC03V03.
      *****************************************************************
      *  ¥·¥¹¥Æ¥àÌ¾        : £Ï£Ò£Ã£Á
      *  ¥µ¥Ö¥·¥¹¥Æ¥àÌ¾    : ´µ¼ÔÅÐÏ¿
      *  ¥³¥ó¥Ý¡¼¥Í¥ó¥ÈÌ¾  : ³°ÍèÀÁµá½ñ·óÎÎ¼ý½ñ¡¡°õºþ
      *                      ¼«Èñ£±£°¹àÌÜÂÐ±þ¡Ê£È£Ã£Í£°£³£Ö£°£³¡Ë
      *  ´ÉÍý¼Ô            : 
      *  ºîÀ®ÆüÉÕ    ºî¶È¼Ô        µ­½Ò
      *  05/07/08    NACL¡Ý¾®Æ¦Âô  ¿·µ¬ºîÀ®
      *****************************************************************
      *  ¥×¥í¥°¥é¥à½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      *  01.00.01    NACL-Â¿¡¹Ç¼  06/05/15  MONFUNC ÂÐ±þ
      *  01.00.02    NACL-ÂÀÅÄ    06/08/22  ¥Ñ¥é¥á¥¿¥Æ¡¼¥Ö¥ë¤è¤êÊÔ½¸¥Ç¡¼¥¿
      *                                     ¤ò»²¾È¤¹¤ë¶èÊ¬¤òÄÉ²Ã
      *                                     ·î¤Þ¤È¤áÀÁµá½ñÈ¯¹Ôµ¡Ç½ÄÉ²Ã
      *  03.03.00    NACL-Â¿¡¹Ç¼  06/10/02  ÊÖ¶âÂÐ±þÄÉ²Ã
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
      *****COPY    "HC03.INC".
           COPY    "HCM03V03.INC"  REPLACING   //HCM03V03//
                                   BY          //HC03//.
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
           03  FLG-PTRSIINF        PIC 9(01).
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
           03  IDX-JIHI            PIC 9(04).
      *
           03  IDX-SYU             PIC 9(04).
           03  IDH3                PIC 9(04).
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
           03  WRK-HKNCOMBIMEI     PIC X(40).
      *
           03  WRK-SKYMONEY        PIC S9(11).
           03  WRK-MISYUMONEY      PIC S9(11).
           03  WRK-MISYU           PIC S9(11).
           03  WRK-GOKTEN          PIC S9(11).
           03  WRK-SKYMONEY-TAX-SAI    PIC S9(11).
      *
           03  WRK-DENPNUM             PIC 9(07).
           03  WRK-SRYKA               PIC X(02).
           03  WRK-HKNCOMBI            PIC X(04).
      *
           03  WRK-WARI            PIC 9(02)V9.
      *****03  WRK-Z6              PIC ZZZZZZ.
      *****03  WRK-Z62             PIC ZZZ9.9.
           03  WRK-Z6              PIC ZZZ.
           03  WRK-Z62             PIC 9.9.
      *
           03  WRK-ZZZ             PIC ZZZ.
           03  WRK-NO              PIC Z(7).
           03  WRK-Z7-G.
               05  WRK-FIL             PIC X(09).
               05  WRK-Z7              PIC Z,ZZZ,ZZZ.
           03  WRK-Z72-G.
      *****    05  WRK-FIL2            PIC X(09).
      ****     05  WRK-Z72             PIC -,---,---.
               05  WRK-FIL2            PIC X(18).
           03  WRK-Z72                 PIC S9(07).
           03  WRK-Z72-H               PIC Z,ZZZ,ZZZ.
           03  WRK-Z72-HS              REDEFINES   WRK-Z72-H
                                       PIC -,---,---.
      *    ¼«Èñ½¸·×
           03  WRK-JIHI-REC.
               05  WRK-JIHI            PIC S9(07)   OCCURS 10.
           03  WRK-JIHI-TOTAL          PIC S9(08).
           03  WRK-JIHIMEI-REC.
               05  WRK-JIHIMEI         PIC X(20)   OCCURS 10.
      *
      *    Ê£¿ô²Ê¤Þ¤È¤á½¸·×
           03  WRK-HKNTEN-KIN              PIC 9(07).
           03  WRK-HKNTEN-KEI              PIC 9(07)V99.
           03  WRK-NYUKIN                  PIC S9(07).
      *
           03  WRK-NYUKIN-TOTAL            PIC S9(07).
           03  WRK-ZENMISYU                PIC S9(07).
      *
           03  WRK-SRYKA-MEI               PIC X(30).
           03  WRK-PAGE                    PIC 9(03).
      *
      *    Ê¸»úÊÑ´¹
           03  WRK-ZENKAKU-G.
               05  WRK-ZENKAKU         PIC X(02)   OCCURS   10.
           03  WRK-MOJI                PIC X(10).
           03  WRK-MOJISU              PIC 9(02).
           03  WRK-LBLSRYYMD           PIC X(10).
           03  WRK-SRYYMDG             PIC X(50).
           03  WRK-STSRYYMDG           PIC X(22).
           03  WRK-EDSRYYMDG           PIC X(22).
      *
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
      *    ´µ¼ÔÏ«ºÒÊÝ¸±¾ðÊó
       01  PTRSIINF-REC.
           COPY    "CPPTRSIINF.INC".
      *
      *    ¥Ñ¥é¥á¥¿¥Æ¡¼¥Ö¥ë
       01  PARA-REC.
           COPY    "CPPARA.INC".
           COPY    "CPSYUPARA03.INC".
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
      *    ¥ª¥ó¥é¥¤¥óÄ¢É¼Ì¾¡¦½ÐÎÏÀè¥×¥ê¥ó¥¿Ì¾¼èÆÀ¥Ñ¥é
           COPY    "CPORCSPRTNM.INC".
      *    ÀÁµá½ñ¼ýÇ¼¥Ñ¥é¥á¥¿
           COPY    "CPORCHC03SUB.INC".
      *
      *    °õºþ£Ä£ÂÀ©¸æ¥µ¥Ö
           COPY    "CPORCSPRT.INC".
      *
      *01  MCPDATA-REC                 PIC X(5000).
           COPY    "MCPDATA.INC".
      *****COPY    "CPORCMCP.INC".
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
      *    ÀÁµá½ñ¥Ñ¥é¥á¥¿
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
      *    ³Æ£Ä£ÂÆÉ¹þ
           PERFORM 100-SYORI-SEC
      *
           IF    ( ORCHC03-PARAFLG     =   1 )
                   PERFORM 203-PARA-SYUNOU-SEC
           ELSE
               IF      ORCHC03-HAKHOUFLG   =   ZERO
      *            ÂÐ¾Ý¤ÎÅÁÉ¼ÈÖ¹æÊ¬¤Î¤ß
                   PERFORM 201-ONLY-SYUNOU-SEC
               ELSE
      *            È¯¹Ô¶èÊ¬¤Ë¤è¤ë
                   PERFORM 202-KAKHOU-SYUNOU-SEC
               END-IF
           END-IF
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
           ADD     1                   TO  WRK-PAGE
           MOVE    WRK-PAGE            TO  HC01PARA-CNT
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
      ***** MOVE   "HC03.dia"          TO  MKPRT-DIA
      ***** MOVE   "HC03.def"          TO  MKPRT-DEF
            MOVE   "HCM03V03.red"      TO  MKPRT-DIA
            MOVE   SPACE               TO  MKPRT-DEF
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
      *    Ä¢É¼°õºþ½èÍý (°õºþ£Ä£Â¤Ë½ÐÎÏ¡Ë
      *****************************************************************
       401-PRINT-SEC                SECTION.
      *
           MOVE    ORCHC03-PRTAREA     TO  ORCSPRTAREA
      *
           MOVE    "HCM03V03.red"      TO  SPRT-PRTID
           MOVE    HC03                TO  SPRT-PRTDATA
      *-----------------------------------------------------------------
           MOVE    "1"                 TO  SPRT-SITEKBN
      *    ¥«¥¹¥¿¥Þ¥¤¥º£Ð£Ç¤Î¾ì¹ç"2"¤ò¥»¥Ã¥È¤¹¤ë¤³¤È¡£
      *    MOVE    "2"                 TO  SPRT-SITEKBN
      *-----------------------------------------------------------------
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF    ( SPRT-RETURN         =   ZERO )
               CONTINUE
           ELSE
               DISPLAY "ORCSPRT ERR: PTID = " SPRT-PTID
           END-IF
      *
           .
       401-PRINT-EXT.
           EXIT.
      *****************************************************************
      *   ÂÐ¾Ý¤ÎÅÁÉ¼ÈÖ¹æÊ¬¤Î¤ß½èÍý
      *****************************************************************
       201-ONLY-SYUNOU-SEC                SECTION.
      *
      *    ¼ýÇ¼¥Þ¥¹¥¿¸¡º÷
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-PTID            TO  SYU-PTID
           MOVE    ORCHC03-DENPNUM     TO  SYU-DENPNUM
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
      *
           MOVE    "tbl_syunou"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
      *    ¿ÇÎÅ²ÊÌ¾ÊÔ½¸
           MOVE    SPACE                TO  WRK-SRYKA-MEI
           MOVE    SYU-SRYKA            TO  WRK-SRYKA
           PERFORM 1000-SRYKAMEI-HEN-SEC
      *    ÊÝ¸±ÁÈ¹ç¤»
           PERFORM 1001-HKNCOMBI-HEN-SEC
      *
           MOVE    ORCHC03-DENPNUM     TO  WRK-DENPNUM
           MOVE    ORCHC03-SEIKYU      TO  WRK-SKYMONEY
           MOVE    ORCHC03-NYUKIN      TO  WRK-NYUKIN
           MOVE    ORCHC03-SEIKYU-TAX-SAI  TO  WRK-SKYMONEY-TAX-SAI
      **** MOVE    ORCHC03-ZENMISYU    TO  WRK-MISYUMONEY
      *---(03.03.00) LINE ADD  START -----------------------------------
           MOVE    ORCHC03-ZENMISYU-2  TO  WRK-MISYUMONEY
      *    Á°²óÀÁµá³Û
           IF      ORCHC03-ZEN-HENKIN  >   ZERO
      *        º£²óÊÖ¶â³Û
               COMPUTE WRK-MISYUMONEY      =   WRK-MISYUMONEY
                                           -   ORCHC03-ZEN-HENKIN
                                           -   ORCHC03-KON-HENKIN
                                                             (1)
           ELSE
      *        Á°²ó¤Þ¤Ç¤ÎÄ¶²á³Û
               COMPUTE WRK-MISYUMONEY      =   WRK-MISYUMONEY
                                           -   ORCHC03-HENKIN
           END-IF
      *    ÊÖ¶âÂÐ±þ
           IF      (ORCHC03-HAKKOFLG   =   ZERO )  AND
                   (ORCHC03-NYUKIN     =   ZERO )  AND
                   (ORCHC03-ZEN-HENKIN >   ZERO )  AND
                   (WRK-MISYUMONEY     <   ZERO )  AND
                   ((WRK-MISYUMONEY * -1 )
                                       >   WRK-SKYMONEY)
      *        ÊÖ¶â³Û¤¬º£²óÀÁµá³Û¤è¤êÂ¿¤¤»þ¡¢¥Þ¥¤¥Ê¥¹Æþ¶â¤È¤¹¤ë
               COMPUTE WRK-NYUKIN          =   WRK-SKYMONEY
                                           +   WRK-MISYUMONEY
           END-IF
      *---(03.03.00) LINE ADD  END   -----------------------------------
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
       201-ONLY-SYUNOU-EXT.
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
      *    ¥·¥¹¥Æ¥à´ÉÍý¸¡º÷
           MOVE    SPA-SRYYMD          TO  SYS-1001-STYUKYMD
           MOVE    SPA-SRYYMD          TO  SYS-1001-EDYUKYMD
      *    ¥·¥¹¥Æ¥à´ÉÍý¸¡º÷
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key10"             TO  MCP-PATHNAME
               PERFORM 900-KANRIMST-READ-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-1001-REC
               END-IF
           ELSE
               INITIALIZE                  SYS-1001-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
      *    °åÎÅµ¡´Ø¾ðÊó¡Ý½êºßÃÏ¡¢Ï¢ÍíÀè
           MOVE    SPACE               TO  SYS-1002-REC
           MOVE    "1002"              TO  SYS-1002-KANRICD
           MOVE    "*"                 TO  SYS-1002-KBNCD
           MOVE    SPA-SRYYMD          TO  SYS-1002-STYUKYMD
           MOVE    SPA-SRYYMD          TO  SYS-1002-EDYUKYMD
      *    ¥·¥¹¥Æ¥à´ÉÍý¸¡º÷
           MOVE    SYS-1002-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key10"             TO  MCP-PATHNAME
               PERFORM 900-KANRIMST-READ-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-1002-REC
               END-IF
           ELSE
               INITIALIZE                  SYS-1002-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
      *    ½ÐÎÏÀè¥×¥ê¥ó¥¿Ì¾³ä¤êÅö¤Æ¾ðÊóÊÔ½¸
           INITIALIZE                      SYS-1031-REC
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "2"                 TO  ORCSPRTNM-KBN
           MOVE    SPA-SRYYMD          TO  ORCSPRTNM-SRYYMD
           MOVE    "2"                 TO  ORCSPRTNM-NYUGAIKBN
           CALL    "ORCSPRTNM"         USING
                                           ORCSPRTNMAREA
                                           SPA-AREA
                                           SYS-1031-REC
      *
      *    Ï«ºÒ°åÎÅµ¡´Ø¾ðÊóÊÔ½¸
           MOVE    SPACE               TO  SYS-4001-REC
           INITIALIZE                  SYS-4001-REC
           MOVE    "4001"              TO  SYS-4001-KANRICD
           MOVE    "*"                 TO  SYS-4001-KBNCD
           MOVE    SPA-SRYYMD          TO  SYS-4001-STYUKYMD
           MOVE    SPA-SRYYMD          TO  SYS-4001-EDYUKYMD
      *    ¥·¥¹¥Æ¥à´ÉÍý¸¡º÷
           MOVE    SYS-4001-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key10"             TO  MCP-PATHNAME
               PERFORM 900-KANRIMST-READ-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-4001-REC
               END-IF
           ELSE
               INITIALIZE                  SYS-4001-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
      *    ¼«ÈñÌ¾¾ÎÊÔ½¸
           PERFORM 1002-JIHIMSG-HEN-SEC
      *
           .
       100-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    ¼«ÈñÌ¾¾ÎÊÔ½¸½èÍý
      *****************************************************************
       1002-JIHIMSG-HEN-SEC             SECTION.
      *
      *    °åÎÅµ¡´Ø¾ðÊó¡Ý½êºßÃÏ¡¢Ï¢ÍíÀè
           MOVE    SPACE               TO  SYS-1013-REC
           MOVE    "1013"              TO  SYS-1013-KANRICD
           MOVE    SPA-SRYYMD          TO  SYS-1013-STYUKYMD
           MOVE    SPA-SRYYMD          TO  SYS-1013-EDYUKYMD
      *    ¥·¥¹¥Æ¥à´ÉÍý¸¡º÷
           MOVE    SYS-1013-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               INITIALIZE                  SYS-1013-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           INITIALIZE                  WRK-JIHIMEI-REC
           PERFORM
               UNTIL       FLG-SYSKANRI    =   1
               MOVE    MCPDATA-REC         TO  SYS-1013-REC
               IF      SPA-NYUGAIKBN       =   SYS-1013-KBNCD(1:1)
                   EVALUATE    SYS-1013-KBNCD(2:1)
                       WHEN    "1"
                           MOVE    SYS-1013-JIHINAME   TO  WRK-JIHIMEI
                                                                    (1)
                       WHEN    "2"
                           MOVE    SYS-1013-JIHINAME   TO  WRK-JIHIMEI
                                                                    (2)
                       WHEN    "3"
                           MOVE    SYS-1013-JIHINAME   TO  WRK-JIHIMEI
                                                                    (3)
                       WHEN    "4"
                           MOVE    SYS-1013-JIHINAME   TO  WRK-JIHIMEI
                                                                    (4)
                       WHEN    "5"
                           MOVE    SYS-1013-JIHINAME   TO  WRK-JIHIMEI
                                                                    (5)
                       WHEN    "5"
                           MOVE    SYS-1013-JIHINAME   TO  WRK-JIHIMEI
                                                                    (5)
                       WHEN    "6"
                           MOVE    SYS-1013-JIHINAME   TO  WRK-JIHIMEI
                                                                    (6)
                       WHEN    "7"
                           MOVE    SYS-1013-JIHINAME   TO  WRK-JIHIMEI
                                                                    (7)
                       WHEN    "8"
                           MOVE    SYS-1013-JIHINAME   TO  WRK-JIHIMEI
                                                                    (8)
                       WHEN    "9"
                           MOVE    SYS-1013-JIHINAME   TO  WRK-JIHIMEI
                                                                    (9)
                       WHEN    "0"
                           MOVE    SYS-1013-JIHINAME   TO  WRK-JIHIMEI
                                                                   (10)
                   END-EVALUATE
               END-IF
      *
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 900-KANRIMST-READ-SEC
           END-PERFORM
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       1002-JIHIMSG-HEN-EXT.
           EXIT.
      *****************************************************************
      *    ÊÝ¸±ÁÈ¹ç¤»Ì¾¾ÎÊÔ½¸½èÍý
      *****************************************************************
       1001-HKNCOMBI-HEN-SEC             SECTION.
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
           PERFORM 10011-HKNCOMBIMEI-HEN-SEC
      *
           IF    ( COMB-HKNNUM         =   "971" OR "973" )
      *
      *        ´µ¼ÔÏ«ºÒÊÝ¸±¾ðÊó¸¡º÷
               INITIALIZE                      PTRSIINF-REC
               MOVE    SPA-HOSPID          TO  PTRSI-HOSPID
               MOVE    SPA-PTID            TO  PTRSI-PTID
               MOVE    COMB-HKNID          TO  PTRSI-HKNID
               PERFORM 910-PTRSIINF-READ-SEC
           ELSE
               INITIALIZE                      PTRSIINF-REC
           END-IF
      *
           .
       1001-HKNCOMBI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    ÊÝ¸±ÁÈ¹ç¤»Ì¾¾ÎÊÔ½¸½èÍý
      *****************************************************************
       10011-HKNCOMBIMEI-HEN-SEC             SECTION.
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
       10011-HKNCOMBIMEI-HEN-EXT.
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
           MOVE    WRK-SRYKA           TO  SYS-1005-KBNCD
           MOVE    SPA-SRYYMD          TO  SYS-1005-STYUKYMD
           MOVE    SPA-SRYYMD          TO  SYS-1005-EDYUKYMD
      *    ¥·¥¹¥Æ¥à´ÉÍý¸¡º÷
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key10"             TO  MCP-PATHNAME
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
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       1000-SRYKAMEI-HEN-EXT.
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
           MOVE    WRK-DENPNUM         TO  WRK-NO  
           MOVE    WRK-NO              TO  HC03-NO
      *    ¿ÇÎÅ²Ê
           MOVE    WRK-SRYKA-MEI(1:20) TO  HC03-MIDASI
      *    ´µ¼ÔÈÖ¹æ
           MOVE    SPA-PTNUM           TO  HC03-KNJNO
      *    ´µ¼ÔÌ¾¾Î
           MOVE    SPA-NAME            TO  HC03-KNJNAMW
      *    ÊÝ¸±¼ïÊÌ
           MOVE    WRK-HKNCOMBIMEI     TO  HC03-HOKEN
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
           PERFORM 3101-SRYYMD-HEN-SEC
           MOVE    WRK-LBLSRYYMD       TO  HC03-LBLSRYYMD
           MOVE    WRK-SRYYMDG         TO  HC03-SRYYMD
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
           MOVE    SYU-HKNTEN (01)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO1
      *    »ØÆ³²Ê
           MOVE    SYU-HKNTEN (02)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO2
      *    ºßÂð²Ê
           MOVE    SYU-HKNTEN (03)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO3
      *    ÅêÌô²Ê
           MOVE    SYU-HKNTEN (04)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO4
      *    Ãí¼Í²Ê
           MOVE    SYU-HKNTEN (05)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO5
      *    ½èÃÖ²Ê
           MOVE    SYU-HKNTEN (06)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO6
      *    ¼ê½Ñ²Ê
           MOVE    SYU-HKNTEN (07)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO7
      *    Ëã¿ì
           MOVE    SYU-HKNTEN (08)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO8
      *    ¸¡ºº²Ê
           MOVE    SYU-HKNTEN (09)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO9
      *    £ØÀþ²Ê
           MOVE    SYU-HKNTEN (10)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G          TO  HC03-HKNRYO10
      *    ¥ê¥Ï¥Ó¥ê
           MOVE    SYU-HKNTEN (11)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO11
      *    Àº¿À²ÊÀìÌç
           MOVE    SYU-HKNTEN (12)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO12
      *    Êü¼ÍÀþ¼£ÎÅ
           MOVE    SYU-HKNTEN (13)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO13
      *    Æþ±¡ÎÁ
           MOVE    SYU-HKNTEN (14)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO14
      *    ÎÅÍÜÃ´Åö¼êÅö¤Æ
           MOVE    SYU-HKNTEN (15)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO15
      *    ¸«½Ð¤·
           PERFORM 3001-MEISAI-HEN-SEC
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
                                       +   SYU-HKNTEN (11)
                                       +   SYU-HKNTEN (12)
                                       +   SYU-HKNTEN (13)
                                       +   SYU-HKNTEN (14)
                                       +   SYU-HKNTEN (15)
           MOVE    WRK-GOKTEN          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-GOKTEN
      *
      *    Ï«ºÒ¡¦¼«Çå¤Ç´µ¼ÔÀÁµá¤¬Ìµ¤¤¾ì¹ç¡¢ÅÀ¿ôÉ½¼¨¤Ê¤·
           IF    ( COMB-HKNNUM             =    "971"  AND
                   SYS-4001-RSIIRYOKBN     =    "1" )  OR
                 ( COMB-HKNNUM             =    "973"  AND
                   SYU-PTFTNRATE           =    ZERO )
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
               MOVE    SPACE               TO  HC03-HKNRYO11
               MOVE    SPACE               TO  HC03-HKNRYO12
               MOVE    SPACE               TO  HC03-HKNRYO13
               MOVE    SPACE               TO  HC03-HKNRYO14
               MOVE    SPACE               TO  HC03-HKNRYO15
               MOVE    ALL "*"             TO  HC03-GOKTEN
           END-IF
      *
      *    ÊÝ¸±Å¬ÍÑÊ¬
           MOVE    SYU-HKNTEKMONEY     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HOKENBUN
      *
      *    ÊÝ¸±Å¬ÍÑ³°ÊÔ½¸
           PERFORM     VARYING   IDX-JIHI FROM  1  BY  1
                       UNTIL     IDX-JIHI  >  15
               MOVE   ZERO      TO    WRK-Z72
               COMPUTE   WRK-Z72   =   SYU-TGMONEY(IDX-JIHI)  +
                                       SYU-TGMONEY-TAX(IDX-JIHI)
               PERFORM   800-HENKAN-SEC
               MOVE    WRK-Z72-G   TO  HC03-JIHIBUN(IDX-JIHI)
           END-PERFORM
      *
      *    ÊÝ¸±Å¬ÍÑ³°¾ÃÈñÀÇ¡ÊºÆ·Ç¡Ë
           MOVE    SYU-TGMONEY-TAX-SAI     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G               TO  HC03-HOKENZEI
      *
           IF    ( COMB-HKNNUM             =    "971"
                                           OR   "973" )
      *        Ï«ºÒ¡¦¼«Çå¤Î»þ¡¢ÅÀ¿ôÉ½¼¨¤Ê¤·
               EVALUATE    TRUE
               WHEN      ( COMB-HKNNUM             =    "971" )
                   AND   ( SYS-4001-RSIIRYOKBN NOT =   "1" )
      *
               WHEN      ( COMB-HKNNUM             =    "973" )
                   AND   ( PTRSI-HKNKBN        =    "4" ) 
                   AND   ( SYU-PTFTNRATE   NOT =   ZERO  )
      *
                   COMPUTE WRK-GOKTEN      =    SYU-HKNTEKMONEY
                                           +    SYU-RSISHOSHIN-MONEY
                                           +    SYU-RSISAISHIN-MONEY
                                           +    SYU-RSISDO-MONEY
                                           +    SYU-RSIETC-MONEY
                   MOVE    WRK-GOKTEN      TO  WRK-Z72
                   PERFORM 800-HENKAN-SEC
                   MOVE    WRK-Z72-G           TO  HC03-HOKENBUN
               WHEN    OTHER
                   MOVE    SPACE               TO  HC03-HOKENBUN
               END-EVALUATE
           END-IF
      *
      *    Ï«ºÒ¡¦¼«Çå¤Î¿Ç»¡ÎÁÅù¤Îµ­ºÜ
           IF   (SYU-RSI-TOTAL     NOT =   ZERO) AND
                (SYS-4001-RSIPRTKBN    =   "2")
               EVALUATE    COMB-HKNNUM
                   WHEN    "971"
                       MOVE  "¡ÊÆâÏ«ºÒ¿Ç»¡Åù¡Ë"  TO HC03-RSIMIDASI
                   WHEN    "973"
                       MOVE  "¡ÊÆâ¼«Çå¿Ç»¡Åù¡Ë"  TO HC03-RSIMIDASI
               END-EVALUATE
               MOVE    SYU-RSI-TOTAL          TO  WRK-Z72
               PERFORM 800-HENKAN-SEC
               MOVE    WRK-Z72-G              TO  HC03-RSIBUN
               MOVE    "±ß"                   TO  HC03-RSIEN
           ELSE
               MOVE    SPACE                  TO  HC03-RSIMIDASI
               MOVE    SPACE                  TO  HC03-RSIBUN
               MOVE    SPACE                  TO  HC03-RSIEN
           END-IF
      *
      *    ÊÝ¸±Å¬ÍÑ³°Ê¬
           MOVE    ZERO                TO  WRK-GOKTEN
           COMPUTE WRK-GOKTEN          =   SYU-TGMONEY (16)
                                       +   SYU-TGMONEY-TAX  (16)
           MOVE    WRK-GOKTEN          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HOKENGAI
      *    ¼«Èñ£±¤«¤é£µ
           MOVE    ZERO                TO  WRK-JIHI-REC
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   10
               COMPUTE WRK-JIHI (IDX)      =   SYU-JIHI-TAXNASI (IDX)
                                           +   SYU-JIHI-TAXARI  (IDX)
               MOVE    WRK-JIHI (IDX)  TO  WRK-Z72
               PERFORM 800-HENKAN-SEC
               MOVE    WRK-Z72-G       TO  HC03-JIHI(IDX)
           END-PERFORM
      *
      *    ¼«Èñ·×
           COMPUTE WRK-JIHI-TOTAL      =   SYU-JIHI-TOTAL
                                       +   SYU-JIHI-TOTAL-TAX
      *    ¼«Èñ¾ÃÈñÀÇ
           MOVE    SYU-JIHI-TAX        TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-JIHI(12)
      *    ¼«Èñ¹ç·×
           COMPUTE WRK-GOKTEN          =   WRK-JIHI-TOTAL
                                       +   SYU-JIHI-TAX
           MOVE    WRK-GOKTEN          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-JIHI(11)
      *    ÌôºÞ°ìÉôÉéÃ´
           MOVE    SYU-YKZ-FTN         TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-YAKUZAI
      *    Ï·¿Í°ìÉôÉéÃ´¶â
           MOVE    SYU-RJN-FTN         TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-ROUJIN
      *    ¸øÈñ°ìÉôÉéÃ´¶â
           MOVE    SYU-KOH-FTN         TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-KOUHI
      *
      *    Ä´À°¶â
           MOVE    SYU-CHOSEI          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-CHOSEI
      *    º£²óÀÁµá³Û
           MOVE    WRK-SKYMONEY        TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-KONSEIKYU
      *
      *    º£²óÀÁµá³Û¾ÃÈñÀÇ¡ÊºÆ·Ç¡Ë
           MOVE    WRK-SKYMONEY-TAX-SAI    TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-SEIKYUZEI
      *
      *    º£²óÆþ¶â³Û
           MOVE    WRK-NYUKIN          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-KONNYUKIN
      *    Á°²óÌ¤¼ý³Û·×»»
      *!!! PERFORM 3101-MISYU-HEN-SEC
      *****MOVE    ORCHC03-ZENMISYU    TO  WRK-MISYUMONEY
           MOVE    WRK-MISYUMONEY      TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-ZENMISYU
      *    ¹ç·×ÀÁµá³Û
           COMPUTE WRK-GOKTEN          =   WRK-SKYMONEY
                                       +   WRK-MISYUMONEY
           MOVE    WRK-GOKTEN          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-GOUKEIGAK
      *
      *    È¯¹Ô¶èÊ¬
           EVALUATE    ORCHC03-HAKKOFLG
      *        WHEN    1
      *            MOVE    "¡ÊºÆ¡Ë"        TO  HC03-MIDASHI
               WHEN    2
                   MOVE    "¡ÊÄûÀµ¡Ë"      TO  HC03-MIDASHI
           END-EVALUATE
      *
           .
       300-HC03-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *   ÌÀºÙ¸«½Ð¤·ÊÔ½¸½èÍý
      *****************************************************************
       3001-MEISAI-HEN-SEC                SECTION.
      *
           MOVE    "½é ¡¦ ºÆ ¿Ç ÎÁ"
                                       TO  HC03-MEISAI (1)
           MOVE    "°å ³Ø ´É Íý Åù"
                                       TO  HC03-MEISAI (2)
           MOVE    "ºß¡¡Âð¡¡°å¡¡ÎÅ"
                                       TO  HC03-MEISAI (3)
           MOVE    "Åê¡¡¡¡¡¡¡¡¡¡Ìô"
                                       TO  HC03-MEISAI (4)
           MOVE    "Ãí¡¡¡¡¡¡¡¡¡¡¼Í"
                                       TO  HC03-MEISAI (5)
           MOVE    "½è¡¡¡¡¡¡¡¡¡¡ÃÖ"
                                       TO  HC03-MEISAI (6)
           MOVE    "¼ê¡¡¡¡¡¡¡¡¡¡½Ñ"
                                       TO  HC03-MEISAI (7)
           MOVE    "Ëã¡¡¡¡¡¡¡¡¡¡¿ì"
                                       TO  HC03-MEISAI (8)
           MOVE    "¸¡¡¡¡¡¡¡¡¡¡¡ºº"
                                       TO  HC03-MEISAI (9)
           MOVE    "²è¡¡Áü¡¡¿Ç¡¡ÃÇ"
                                       TO  HC03-MEISAI (10)
           MOVE    "¥ê¥Ï¥Ó¥ê¥Æ¡¼¥·¥ç¥ó"
                                       TO  HC03-MEISAI (11)
           MOVE    "Àº¿À²ÊÀìÌçÎÅË¡"
                                       TO  HC03-MEISAI (12)
           MOVE    "Êü ¼Í Àþ ¼£ ÎÅ"
                                       TO  HC03-MEISAI (13)
           MOVE    "Æþ¡¡±¡¡¡ÎÁ¡¡Åù"
                                       TO  HC03-MEISAI (14)
           MOVE    "ÎÅÍÜÃ´Åö¼êÅö"
                                       TO  HC03-MEISAI (15)
      *    ÌÀºÙºï½ü
      *    ÎÅÍÜÃ´Åö¼êÅö¤Æ
           IF     (SYU-HKNTEN (15)     =   ZERO ) AND
                  (SYU-TGMONEY (15)    =   ZERO ) AND
                  (SYU-TGMONEY-TAX(15) =   ZERO )
               MOVE    SPACE               TO  HC03-MEISAI (15)
           END-IF
      *
           .
       3001-MEISAI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *   Ê£¿ô²Ê¡¦ÊÝ¸±ÆþÎÏ¤Î°õºþ½èÍý
      *****************************************************************
       202-KAKHOU-SYUNOU-SEC                SECTION.
      *
           INITIALIZE                  ORCHC03SUBAREA
      *    ¼ýÇ¼¥Þ¥¹¥¿¤Þ¤È¤á·×»»
           CALL    "ORCHC03SUB"        USING
                                       SPA-AREA
                                       ORCHC03AREA
                                       ORCHC03SUBAREA
      *    Æþ¶â¹ç·×
           MOVE    ZERO                TO  WRK-NYUKIN-TOTAL
           PERFORM VARYING IDX-SYU     FROM    1   BY  1
                   UNTIL   IDX-SYU     >   ORCHC03SUB-MAX
               ADD     ORCHC03SUB-NYUKIN-TOTAL(IDX-SYU)
                                           TO  WRK-NYUKIN-TOTAL
           END-PERFORM
      *    Æþ¶â¹ç·×¤«¤éÁ°²óÌ¤¼ý³Û¤ÎÆþ¶â³Û¤òµá¤á¤ë
           IF      ORCHC03-NYUKIN      >   WRK-NYUKIN-TOTAL
               COMPUTE WRK-ZENMISYU    =   ORCHC03-NYUKIN
                                       -   WRK-NYUKIN-TOTAL
           ELSE
               MOVE    ZERO            TO  WRK-ZENMISYU
           END-IF
      *
           PERFORM VARYING IDX-SYU     FROM    1   BY  1
                   UNTIL   IDX-SYU     >   ORCHC03SUB-MAX
               MOVE    ORCHC03SUB-SYUNOU-REC(IDX-SYU)
                                           TO  SYUNOU-REC
      *        ¿ÇÎÅ²ÊÌ¾ÊÔ½¸
               MOVE    SPACE               TO  WRK-SRYKA-MEI
               IF      ORCHC03SUB-DOUJI-SRYKA-G (IDX-SYU)
                                           =   SPACE
                   MOVE    SYU-SRYKA           TO  WRK-SRYKA
                   PERFORM 1000-SRYKAMEI-HEN-SEC
               ELSE
                   PERFORM 2021-GRP-SRYKAMEI-HEN-SEC
               END-IF
      *        ÊÝ¸±ÁÈ¹ç¤»
               IF      SYU-HKNCOMBINUM     =   ZERO  OR  SPACE
                   MOVE    "Ê£¿ôÊÝ¸±»ÈÍÑ"      TO  WRK-HKNCOMBIMEI
                   MOVE    ZERO                TO  SYU-PTFTNRATE
               ELSE
                   PERFORM 1001-HKNCOMBI-HEN-SEC
               END-IF
      *
               MOVE    SYU-DENPNUM         TO  WRK-DENPNUM
               MOVE    ORCHC03SUB-SKYMONEY (IDX-SYU)
                                           TO  WRK-SKYMONEY
               MOVE    ORCHC03SUB-NYUKIN-TOTAL (IDX-SYU)
                                           TO  WRK-NYUKIN
               MOVE    ORCHC03SUB-SKYMONEY-TAX-SAI (IDX-SYU)
                                           TO  WRK-SKYMONEY-TAX-SAI
      *
      *        £±ËçÌÜ¤ËÁ°²óÌ¤¼ý³Û¤òÉ½¼¨¤¹¤ë
               IF      IDX-SYU             =   1
      *---(03.03.00) LINE ADD  START -----------------------------------
                  AND  (ORCHC03-HAKKOFLG   =   ZERO )
      ***********  MOVE    ORCHC03-ZENMISYU    TO  WRK-MISYUMONEY
                   MOVE    ORCHC03-ZENMISYU-2  TO  WRK-MISYUMONEY
      *---(03.03.00) LINE ADD  END   -----------------------------------
                   COMPUTE WRK-NYUKIN          =   WRK-NYUKIN
                                               +   WRK-ZENMISYU
               ELSE
                   MOVE    ZERO                TO  WRK-MISYUMONEY
               END-IF
      *---(03.03.00) LINE ADD  START -----------------------------------
               IF      IDX-SYU             =   1
                   COMPUTE WRK-MISYUMONEY  =   WRK-MISYUMONEY
                                           -   ORCHC03-ZEN-HENKIN
                                           -   ORCHC03SUB-HENKIN
                                                         (IDX-SYU)
      *             ÊÖ¶âÂÐ±þ
                    IF      (ORCHC03-HAKKOFLG   =   ZERO )  AND
                            (WRK-NYUKIN         =   ZERO )  AND
                            (ORCHC03-ZEN-HENKIN >   ZERO )  AND
                            (WRK-MISYUMONEY     <   ZERO )  AND
                            ((WRK-MISYUMONEY * -1)
                                                >   WRK-SKYMONEY)
      *             ÊÖ¶â³Û¤¬º£²óÀÁµá³Û¤è¤êÂ¿¤¤»þ¡¢¥Þ¥¤¥Ê¥¹Æþ¶â¤È¤¹¤ë
                       COMPUTE WRK-NYUKIN      =   WRK-SKYMONEY
                                               +   WRK-MISYUMONEY
                   END-IF
               ELSE
                   COMPUTE WRK-MISYUMONEY  =   WRK-MISYUMONEY
                                           -   ORCHC03SUB-HENKIN
                                                         (IDX-SYU)
               END-IF
      *---(03.03.00) LINE ADD  END   -----------------------------------
      *
      *        Ä¢É¼°õºþ³«»Ï½èÍý
               PERFORM 400-SYOKI-PRINT-SEC
      *
      *        Ä¢É¼ÊÔ½¸½èÍý
               PERFORM 300-HC03-HEN-SEC
      *
      *        Ä¢É¼°õºþ½èÍý
               PERFORM 400-PRINT-SEC
           END-PERFORM
      *
           .
       202-KAKHOU-SYUNOU-EXT.
           EXIT.
      *
      *****************************************************************
      *   ¥Ñ¥é¥á¥¿¥Æ¡¼¥Ö¥ë¤«¤é¤Î°õºþ½èÍý
      *****************************************************************
       203-PARA-SYUNOU-SEC                 SECTION.
      *
           PERFORM 900-PARA-KEY5-SEL-SEC
      *
           PERFORM UNTIL ( FLG-PARA    NOT =   ZERO )
      *
               MOVE    PARA-DATA-REC       TO  SYUPARA03-AREA
               MOVE    SYUPARA03-SYU-DATA  TO  SYUNOU-REC
      *
               MOVE    SYUPARA03-DENPNUM   TO  WRK-DENPNUM
               MOVE    SYUPARA03-SEIKYU    TO  WRK-SKYMONEY
               MOVE    SYUPARA03-SEIKYU-TAX-SAI
                                           TO  WRK-SKYMONEY-TAX-SAI
               MOVE    SYUPARA03-NYUKIN    TO  WRK-NYUKIN
               MOVE    SYUPARA03-MISYU     TO  WRK-MISYUMONEY
               MOVE    SYUPARA03-SRYKAMEI  TO  WRK-SRYKA-MEI
      *
               INITIALIZE                      HKNCOMBI-REC
                                               PTRSIINF-REC
               IF    ( SYUPARA03-HKNCOMBI-MAX  =   1 )
                   PERFORM 1001-HKNCOMBI-HEN-SEC
               END-IF
      *
               MOVE    SYUPARA03-HKNCOMBIMEI
                                           TO  WRK-HKNCOMBIMEI
      *
               IF    ( ORCHC03-PRTKBN      =   "1" )
      *
      *            Ä¢É¼ÊÔ½¸½èÍý
                   PERFORM 300-HC03-HEN-SEC
      *
      *            Ä¢É¼°õºþ½èÍý
                   PERFORM 401-PRINT-SEC
               ELSE
      *
      *            Ä¢É¼°õºþ³«»Ï½èÍý
                   PERFORM 400-SYOKI-PRINT-SEC
      *
      *            Ä¢É¼ÊÔ½¸½èÍý
                   PERFORM 300-HC03-HEN-SEC
      *
      *            Ä¢É¼°õºþ½èÍý
                   PERFORM 400-PRINT-SEC
               END-IF
      *
               PERFORM 900-PARA-KEY5-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_para"          TO  MCP-TABLE
           MOVE    "key5"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       203-PARA-SYUNOU-EXT.
           EXIT.
      *****************************************************************
      *    Ê£¿ô¿ÇÎÅ²ÊÊÔ½¸½èÍý
      *****************************************************************
       2021-GRP-SRYKAMEI-HEN-SEC             SECTION.
      *
           PERFORM VARYING     IDH3    FROM    1   BY  1
                   UNTIL       IDH3    >   10
               IF      ORCHC03SUB-DOUJI-SRYKA (IDX-SYU IDH3)
                                       NOT =   SPACE
                   MOVE    ORCHC03SUB-DOUJI-SRYKA(IDX-SYU IDH3)
                                           TO  WRK-SRYKA
                   PERFORM 1000-SRYKAMEI-HEN-SEC
               END-IF
           END-PERFORM
           .
       2021-GRP-SRYKAMEI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    È¾³ÑÁ´³ÑÊÑ´¹½èÍý
      *****************************************************************
       800-HENKAN-SEC             SECTION.
     *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"                 TO  KANACHK-SYORI
      *****MOVE    WRK-Z72             TO  KANACHK-MAE-INPUT
           IF      WRK-Z72             <   ZERO
               MOVE    WRK-Z72             TO  WRK-Z72-HS
               MOVE    WRK-Z72-HS          TO  KANACHK-MAE-INPUT
           ELSE
               MOVE    WRK-Z72             TO  WRK-Z72-H
               MOVE    WRK-Z72-H           TO  KANACHK-MAE-INPUT
           END-IF
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
      *3101-MISYU-HEN-SEC             SECTION.
      *
      *    MOVE    ZERO                TO  WRK-MISYUMONEY
      *    MOVE    SYU-DENPNUM         TO  WRK-DENPNUM
      *    ¼ýÇ¼¥Æ¡¼¥Ö¥ëÆÉ¤ß¹þ¤ß
      *    INITIALIZE                  SYUNOU-REC
      *    MOVE    SPA-HOSPID          TO  SYU-HOSPID
      *    MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
      *    MOVE    SPA-PTID            TO  SYU-PTID
      *
      *    MOVE    SYUNOU-REC          TO  MCPDATA-REC
      *    MOVE    "DBSELECT"          TO  MCP-FUNC
      *    MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
      *    CALL    "ORCMCPSUB"          USING
      *                                 MCPAREA
      *                                 ORCMCPAREA
      *                                 MCPDATA-REC
      *    IF      MCP-RC              =   ZERO
      *        MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
      *        PERFORM 980-SYUNOU-READ-SEC
      *    ELSE
      *        INITIALIZE                  SYUNOU-REC
      *        MOVE    1               TO  FLG-SYUNOU
      *    END-IF
      *    MOVE    ZERO                TO  WRK-MISYUMONEY
      *    PERFORM
      *        UNTIL     FLG-SYUNOU    =   1
      *        IF      ORCHC03-FUKU-DENPNUM    =   ZERO
      *            IF      SYU-DENPNUM     NOT =   WRK-DENPNUM
      *                COMPUTE WRK-MISYU       =   SYU-SKYMONEY
      *                                        -   SYU-NYUKIN-TOTAL
      *                ADD     WRK-MISYU           TO  WRK-MISYUMONEY
      *            END-IF
      *        ELSE
      *            IF      SYU-FUKU-DENPNUM    =   ORCHC03-FUKU-DENPNUM
      *                CONTINUE
      *            ELSE
      *                COMPUTE WRK-MISYU       =   SYU-SKYMONEY
      *                                        -   SYU-NYUKIN-TOTAL
      *                ADD     WRK-MISYU           TO  WRK-MISYUMONEY
      *            END-IF
      *        END-IF
      *
      *        MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
      *        PERFORM 980-SYUNOU-READ-SEC
      *    END-PERFORM
      *
      *    MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
      *    MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
      *    CALL    "ORCMCPSUB"          USING
      *                                 MCPAREA
      *                                 ORCMCPAREA
      *                                 MCPDATA-REC
      *    .
      *3101-MISYU-HEN-EXT.
      *****EXIT.
      *
      *****************************************************************
      *    ¼«ÈñÌ¾¾ÎÊÔ½¸½èÍý
      *****************************************************************
       3102-JIHIMSG-HEN-SEC             SECTION.
      *
           MOVE    WRK-JIHIMEI(1)      TO  HC03-JIHIMSG1
           MOVE    WRK-JIHIMEI(2)      TO  HC03-JIHIMSG2
           MOVE    WRK-JIHIMEI(3)      TO  HC03-JIHIMSG3
           MOVE    WRK-JIHIMEI(4)      TO  HC03-JIHIMSG4
           MOVE    WRK-JIHIMEI(5)      TO  HC03-JIHIMSG5
           MOVE    WRK-JIHIMEI(6)      TO  HC03-JIHIMSG6
           MOVE    WRK-JIHIMEI(7)      TO  HC03-JIHIMSG7
           MOVE    WRK-JIHIMEI(8)      TO  HC03-JIHIMSG8
           MOVE    WRK-JIHIMEI(9)      TO  HC03-JIHIMSG9
           MOVE    WRK-JIHIMEI(10)     TO  HC03-JIHIMSG10
      *
           .
       3102-JIHIMSG-HEN-EXT.
           EXIT.
      *****************************************************************
      *    ¿ÇÎÅÆüÊÔ½¸½èÍý
      *****************************************************************
       3101-SRYYMD-HEN-SEC         SECTION.
      *
           MOVE    SPACE                   TO  WRK-SRYYMDG
                                               WRK-LBLSRYYMD
      *
           IF    ( ORCHC03-HAKKOFLG    =   4 )
                   MOVE    "¿ÇÎÅÇ¯·î"      TO  WRK-LBLSRYYMD
                   MOVE    SYU-SRYYMD      TO  WRK-SYMD
                   PERFORM 31012-SEIWA-HEN-SEC
                   MOVE    WRK-HENYMDG  (1:16)
                                           TO  WRK-SRYYMDG
           ELSE
               IF    ( ORCHC03-PARAFLG         =   1 )
                AND  ( SYUPARA03-STSRYYMD  NOT =   SYUPARA03-EDSRYYMD )
                   MOVE    "¿ÇÎÅÆü"        TO  WRK-LBLSRYYMD
                   PERFORM 31012-SRYYMD-HEN-SEC
               ELSE
                   MOVE    "¿ÇÎÅÆü"        TO  WRK-LBLSRYYMD
                   MOVE    SYU-SRYYMD      TO  WRK-SYMD
                   PERFORM 31012-SEIWA-HEN-SEC
                   MOVE    WRK-HENYMDG     TO  WRK-SRYYMDG
               END-IF
           END-IF
      *
           .
       3101-SRYYMD-HEN-EXT.
           EXIT.
      *****************************************************************
      *    ¿ÇÎÅÆüÊÔ½¸½èÍý
      *****************************************************************
       31012-SRYYMD-HEN-SEC        SECTION.
      *
           MOVE    SPACE               TO  WRK-SRYYMDG
      *
           MOVE    SYUPARA03-STSRYYMD  TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  WRK-STSRYYMDG
      *
           MOVE    SYUPARA03-EDSRYYMD  TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  WRK-EDSRYYMDG
      *
           STRING  WRK-STSRYYMDG       DELIMITED   BY  SIZE
                   " ¡Á "              DELIMITED   BY  SIZE
                   WRK-EDSRYYMDG       DELIMITED   BY  SIZE
           INTO    WRK-SRYYMDG
           END-STRING
      *
           .
       31012-SRYYMD-HEN-EXT.
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
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿ÆÉ¤ß¹þ¤ß½èÍý
      *****************************************************************
       900-KANRIMST-READ-SEC         SECTION.
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
      *
      *****************************************************************
      *    ´µ¼Ô¥Þ¥¹¥¿¡¼ÆÉ¤ß¹þ¤ß
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptinf"         TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 920-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  PTINF-REC
                   MOVE    ZERO            TO  FLG-PTINF
               ELSE
                   MOVE    1               TO  FLG-PTINF
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTINF
           END-IF
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *****************************************************************
      *    ¥Ñ¥é¥á¥¿¥Æ¡¼¥Ö¥ë¸¡º÷
      *****************************************************************
       900-PARA-KEY5-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-PARA
      *
           INITIALIZE                      PARA-REC
           MOVE    ORCHC03-PARA-GYOUMUID
                                       TO  PARA-GYOUMUID
           MOVE    ORCHC03-PARA-TERMID
                                       TO  PARA-TERMID
           MOVE    ORCHC03-PARA-FILEMEI
                                       TO  PARA-FILEMEI
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "tbl_para"          TO  MCP-TABLE
           MOVE    "key5"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               PERFORM 900-PARA-KEY5-FET-SEC
           ELSE
               MOVE    1               TO  FLG-PARA
               INITIALIZE                  PARA-REC
           END-IF
      *
           .
       900-PARA-KEY5-SEL-EXT.
           EXIT.
      *****************************************************************
      *    ¥Ñ¥é¥á¥¿¥Æ¡¼¥Ö¥ëFETCH
      *****************************************************************
       900-PARA-KEY5-FET-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-PARA
      *
           MOVE    "tbl_para"          TO  MCP-TABLE
           MOVE    "key5"              TO  MCP-PATHNAME
           PERFORM 920-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  PARA-REC
           ELSE
               MOVE    1               TO  FLG-PARA
               INITIALIZE                  PARA-REC
           END-IF
      *
           .
       900-PARA-KEY5-FET-EXT.
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
      *
      *****************************************************************
      *    ´µ¼ÔÏ«ºÒÊÝ¸±¾ðÊóÆÉ¤ß¹þ¤ß
      *****************************************************************
       910-PTRSIINF-READ-SEC         SECTION.
      *
           MOVE    PTRSIINF-REC        TO  MCPDATA-REC
           MOVE    "tbl_ptrsiinf"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptrsiinf"      TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 920-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  PTRSIINF-REC
                   MOVE    ZERO            TO  FLG-PTRSIINF
               ELSE
                   MOVE    1               TO  FLG-PTRSIINF
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTRSIINF
           END-IF
     *
           MOVE    "tbl_ptrsiinf"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       910-PTRSIINF-READ-EXT.
           EXIT.
      *****************************************************************
      *    ¥Æ¡¼¥Ö¥ë¸¡º÷½èÍý
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
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
      *
           .
      *
       920-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ä£Â¥¯¥í¡¼¥¹½èÍý
      *****************************************************************
       990-DBCLOSE-SEC         SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       990-DBCLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ½ªÎ»¡¡¡¡½èÍý
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           .
       300-END-EXT.
           EXIT.
      *
