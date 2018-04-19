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
       PROGRAM-ID.             ORCSRECESRCHK.
      *****************************************************************
      *  ¥·¥¹¥Æ¥àÌ¾        : £Ï£Ò£Ã£Á
      *  ¥µ¥Ö¥·¥¹¥Æ¥àÌ¾    : 
      *  ¥³¥ó¥Ý¡¼¥Í¥ó¥ÈÌ¾  : ¥ª¥ó¥é¥¤¥ó¿ÇÎÅÎÁÅù¤Ë´Ø¤ï¤ë´ÉÍýÎÁ¡¦»ØÆ³ÎÁ¤Î
      *                      »»ÄêÍúÎò¥Á¥§¥Ã¥¯¥µ¥Ö
      *  ´ÉÍý¼Ô            : 
      *  18/04/19    NACL¡ÝÆ£¸¶    ¿·µ¬ºîÀ®
      *****************************************************************
      *  ¥×¥í¥°¥é¥à½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                        DIVISION.
      *
       WORKING-STORAGE             SECTION.
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SANTEI          PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
      *
           03  FLG-CHK             PIC 9(01).
      *
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
      *
           03  IDXX                PIC 9(04).
           03  IDYY                PIC 9(04).
      *
       01  WRK-AREA.
           03  WRK-ST-IDX          PIC 9(03).
           03  WRK-ED-IDX          PIC 9(03).
      *
           03  WRK-SANTEIYM        PIC X(06).
      *
       01  WRK-CONS-AREA.
           03  WRK-CONS-SRYCD-TABLE.
               05 FILLER           PIC X(09)   VALUE   "113001810". 
               05 FILLER           PIC X(09)   VALUE   "113001910". 
               05 FILLER           PIC X(09)   VALUE   "113002010". 
               05 FILLER           PIC X(333)  VALUE   SPACE.
      *
               05 FILLER           PIC X(09)   VALUE   "113002210". 
               05 FILLER           PIC X(351)  VALUE   SPACE.
      *
               05 FILLER           PIC X(09)   VALUE   "113002850". 
               05 FILLER           PIC X(351)  VALUE   SPACE.
      *
               05 FILLER           PIC X(09)   VALUE   "113002910". 
               05 FILLER           PIC X(351)  VALUE   SPACE.
      *
               05 FILLER           PIC X(09)   VALUE   "113013610". 
               05 FILLER           PIC X(09)   VALUE   "113015610". 
               05 FILLER           PIC X(342)  VALUE   SPACE.
      *
               05 FILLER           PIC X(09)   VALUE   "113015810". 
               05 FILLER           PIC X(09)   VALUE   "113024810". 
               05 FILLER           PIC X(342)  VALUE   SPACE.
      *
               05 FILLER           PIC X(09)   VALUE   "113018410".
               05 FILLER           PIC X(09)   VALUE   "113025710".
               05 FILLER           PIC X(342)  VALUE   SPACE.
      *
               05 FILLER           PIC X(09)   VALUE   "113003910".
               05 FILLER           PIC X(09)   VALUE   "113004010".
               05 FILLER           PIC X(09)   VALUE   "113005810".
               05 FILLER           PIC X(09)   VALUE   "113005910".
               05 FILLER           PIC X(09)   VALUE   "113006010".
               05 FILLER           PIC X(09)   VALUE   "113006110".
               05 FILLER           PIC X(306)  VALUE   SPACE.
      *
               05 FILLER           PIC X(09)   VALUE   "114030710".
               05 FILLER           PIC X(09)   VALUE   "114030810".
               05 FILLER           PIC X(09)   VALUE   "114030910".
               05 FILLER           PIC X(09)   VALUE   "114031010".
               05 FILLER           PIC X(09)   VALUE   "114031110".
               05 FILLER           PIC X(09)   VALUE   "114031210".
               05 FILLER           PIC X(09)   VALUE   "114031310".
               05 FILLER           PIC X(09)   VALUE   "114031410".
               05 FILLER           PIC X(09)   VALUE   "114031510".
               05 FILLER           PIC X(09)   VALUE   "114031610".
               05 FILLER           PIC X(09)   VALUE   "114031710".
               05 FILLER           PIC X(09)   VALUE   "114031810".
               05 FILLER           PIC X(09)   VALUE   "114031910".
               05 FILLER           PIC X(09)   VALUE   "114032010".
               05 FILLER           PIC X(09)   VALUE   "114032110".
               05 FILLER           PIC X(09)   VALUE   "114032210".
               05 FILLER           PIC X(09)   VALUE   "114032310".
               05 FILLER           PIC X(09)   VALUE   "114032410".
               05 FILLER           PIC X(09)   VALUE   "114032510".
               05 FILLER           PIC X(09)   VALUE   "114032610".
               05 FILLER           PIC X(09)   VALUE   "114032710".
               05 FILLER           PIC X(09)   VALUE   "114032810".
               05 FILLER           PIC X(09)   VALUE   "114032910".
               05 FILLER           PIC X(09)   VALUE   "114033010".
               05 FILLER           PIC X(09)   VALUE   "114033110".
               05 FILLER           PIC X(09)   VALUE   "114033210".
               05 FILLER           PIC X(09)   VALUE   "114033310".
               05 FILLER           PIC X(09)   VALUE   "114033410".
               05 FILLER           PIC X(09)   VALUE   "114033510".
               05 FILLER           PIC X(09)   VALUE   "114033610".
               05 FILLER           PIC X(09)   VALUE   "114033710".
               05 FILLER           PIC X(09)   VALUE   "114033810".
               05 FILLER           PIC X(09)   VALUE   "114033910".
               05 FILLER           PIC X(09)   VALUE   "114034010".
               05 FILLER           PIC X(09)   VALUE   "114034110".
               05 FILLER           PIC X(09)   VALUE   "114034210".
               05 FILLER           PIC X(36)   VALUE   SPACE.
      *
               05 FILLER           PIC X(09)   VALUE   "180057210".
               05 FILLER           PIC X(09)   VALUE   "180057310".
               05 FILLER           PIC X(09)   VALUE   "180057410".
               05 FILLER           PIC X(09)   VALUE   "180057510".
               05 FILLER           PIC X(09)   VALUE   "180057610".
               05 FILLER           PIC X(09)   VALUE   "180057710".
               05 FILLER           PIC X(09)   VALUE   "180057810".
               05 FILLER           PIC X(09)   VALUE   "180057910".
               05 FILLER           PIC X(09)   VALUE   "180058010".
               05 FILLER           PIC X(09)   VALUE   "180058110".
               05 FILLER           PIC X(270)  VALUE   SPACE.
           03  WRK-CONS-SRYCD-TABLE-R          REDEFINES
                                       WRK-CONS-SRYCD-TABLE.
               05  WRK-CONS-SRYCD-G            OCCURS  10.
                   07  WRK-CONS-SRYCD
                                   PIC X(09)   OCCURS  40.
      *
           03  WRK-CONS-COMMENT-SRYCD-TABLE.
      *        ÆÃÄê¼À´µÎÅÍÜ´ÉÍýÎÁ»»Äê´µ¼Ô
               05 FILLER           PIC X(09)   VALUE   "820100006".
      *        ¾®»ù²ÊÎÅÍÜ»ØÆ³ÎÁ»»Äê´µ¼Ô
               05 FILLER           PIC X(09)   VALUE   "820100007".
      *        ¤Æ¤ó¤«¤ó»ØÆ³ÎÁ»»Äê´µ¼Ô
               05 FILLER           PIC X(09)   VALUE   "820100008".
      *        ÆñÉÂ³°Íè»ØÆ³´ÉÍýÎÁ»»Äê´µ¼Ô
               05 FILLER           PIC X(09)   VALUE   "820100009".
      *        ÅüÇ¢ÉÂÆ©ÀÏÍ½ËÉ»ØÆ³´ÉÍýÎÁ»»Äê´µ¼Ô
               05 FILLER           PIC X(09)   VALUE   "820100010".
      *        ÃÏ°èÊñ³ç¿ÇÎÅÎÁ»»Äê´µ¼Ô
               05 FILLER           PIC X(09)   VALUE   "820100011".
      *        Ç§ÃÎ¾ÉÃÏ°èÊñ³ç¿ÇÎÅÎÁ»»Äê´µ¼Ô
               05 FILLER           PIC X(09)   VALUE   "820100012".
      *        À¸³è½¬´·ÉÂ´ÉÍýÎÁ»»Äê´µ¼Ô
               05 FILLER           PIC X(09)   VALUE   "820100013".
      *        ºßÂð»þ°å³ØÁí¹ç´ÉÍýÎÁ»»Äê´µ¼Ô
               05 FILLER           PIC X(09)   VALUE   "820100014".
      *        Àº¿À²ÊºßÂð´µ¼Ô»Ù±ç´ÉÍýÎÁ»»Äê´µ¼Ô
               05 FILLER           PIC X(09)   VALUE   "820100015".
           03  WRK-CONS-COMMENT-SRYCD-TABLE-R  REDEFINES
                                      WRK-CONS-COMMENT-SRYCD-TABLE.
               05  WRK-CONS-COMMENT-SRYCD-G    OCCURS  10.
                   07  WRK-CONS-COMMENT-SRYCD
                                   PIC X(09).
      *
           03 WRK-CONS-SRYCD-MAX   PIC 9(03)   VALUE   40.
      *
      *****************************************************************
      *    ¥Õ¥¡¥¤¥ë¥ì¥¤¥¢¥¦¥È
      *****************************************************************
      *
      *    »»ÄêÍúÎò
       01  SANTEI-REC.
           COPY    "CPSANTEI.INC".
      *
      *    ´µ¼Ô
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *****************************************************************
      *    ¥µ¥Ö¥×¥íÍÑÎÎ°è
      *****************************************************************
      *
      *    ÆüÉÕÊÑ´¹¥µ¥Ö
           COPY    "CPORCSGDAY.INC".
      *
      *    ÆüÉÕÊÑ´¹¥µ¥Ö
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    £Ä£Â¸¡º÷
           COPY    "MCPDATA.INC".
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    Ï¢ÍíÎÎ°è
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "COMMON-SPA".
      *
           COPY    "CPORCSRECESRCHK.INC".
      *
      *****************************************************************
      *
       PROCEDURE                   DIVISION    USING
                                   SPA-AREA
                                   ORCSRECESRCHKAREA.
      *
      *****************************************************************
      *    ¼ç½èÍý
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC    UNTIL   FLG-END =   1
      *
           PERFORM 300-END-SEC
           .
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    ½é´ü½èÍý
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           DISPLAY "LNK-RECESRCHK PTID  =" LNK-RECESRCHK-PTID
           DISPLAY "LNK-RECESRCHK SRYYM =" LNK-RECESRCHK-SRYYM
           DISPLAY "LNK-RECESRCHK CHKKBN=" LNK-RECESRCHK-CHKKBN
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    ZERO                TO  LNK-RECESRCHK-RC
           INITIALIZE                      LNK-RECESRCHK-HENKYAKU-AREA
      *
      *    ÆþÎÏÃÍ¥Á¥§¥Ã¥¯
           IF    ( LNK-RECESRCHK-HOSPNUM   =   ZERO  )
           OR    ( LNK-RECESRCHK-PTID      =   ZERO  )
           OR    ( LNK-RECESRCHK-SRYYM     =   SPACE )
           OR    ( LNK-RECESRCHK-CHKKBN    =   SPACE )
               MOVE    1                   TO  LNK-RECESRCHK-RC
           ELSE
      *        ½èÍýÇ¯·î¥Á¥§¥Ã¥¯
               INITIALIZE                      ORCSGDAYAREA
               MOVE    "1"                 TO  SGDAY-INTYPE
               MOVE    LNK-RECESRCHK-SRYYM TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   IF     LNK-RECESRCHK-SRYYM  <  "201804"
                       MOVE    2               TO  LNK-RECESRCHK-RC
                   END-IF
               ELSE
                   MOVE    2               TO  LNK-RECESRCHK-RC
               END-IF
      *
               IF      LNK-RECESRCHK-RC    =   ZERO
      *            ´µ¼Ô£É£Ä¥Á¥§¥Ã¥¯
                   INITIALIZE                      PTINF-REC
                   MOVE    LNK-RECESRCHK-HOSPNUM
                                               TO  PTINF-HOSPNUM
                   MOVE    LNK-RECESRCHK-PTID  TO  PTINF-PTID
                   PERFORM 900-PTINF-READ-SEC
                   IF      FLG-PTINF       NOT =   ZERO
                       MOVE    3                   TO  LNK-RECESRCHK-RC
                   END-IF
               END-IF
      *
               IF      LNK-RECESRCHK-RC    =   ZERO
      *            ¥Á¥§¥Ã¥¯¶èÊ¬¥Á¥§¥Ã¥¯
                   EVALUATE    LNK-RECESRCHK-CHKKBN
                       WHEN    "1"
                       WHEN    "2"
                       WHEN    "3"
                       WHEN    "4"
                           CONTINUE
                       WHEN   OTHER
                           MOVE    4               TO  LNK-RECESRCHK-RC
                   END-EVALUATE
               END-IF
           END-IF
      *
           IF      LNK-RECESRCHK-RC    =   ZERO
               CONTINUE
           ELSE
               MOVE    1                   TO  FLG-END
           END-IF
      *
           .
       100-INIT-EXT.
           EXIT
           .
      *
      *****************************************************************
      *    ¼ç½èÍý
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           MOVE    ZERO            TO  WRK-ST-IDX
                                       WRK-ED-IDX
                                       FLG-CHK
      *
           EVALUATE    LNK-RECESRCHK-CHKKBN
               WHEN    "1"
                   MOVE    1               TO  WRK-ST-IDX
                   MOVE    10              TO  WRK-ED-IDX
               WHEN    "2"
                   MOVE    1               TO  WRK-ST-IDX
                   MOVE    8               TO  WRK-ED-IDX
               WHEN    "3"
                   MOVE    9               TO  WRK-ST-IDX
                   MOVE    9               TO  WRK-ED-IDX
               WHEN    "4"
                   MOVE    10              TO  WRK-ST-IDX
                   MOVE    10              TO  WRK-ED-IDX
           END-EVALUATE
      *
      *    ½èÍýÇ¯·î¤Î»°¥ö·îÁ°¤Þ¤Ç¤Î»»ÄêÍúÎò¤ò¥Á¥§¥Ã¥¯
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       3
                   OR      FLG-CHK =       1
               INITIALIZE                  STS-AREA-DAY
               INITIALIZE                  LNK-DAY6-AREA
               MOVE    "61"            TO  LNK-DAY6-IRAI
               MOVE    LNK-RECESRCHK-SRYYM
                                       TO  LNK-DAY6-KIJUN (1:6)
               MOVE    "01"            TO  LNK-DAY6-KIJUN (7:2)
               MOVE    "2"             TO  LNK-DAY6-ZOGENPTN
               COMPUTE LNK-DAY6-ZOGEN  =   -1  *   IDX
               CALL    "ORCSDAY"       USING   STS-AREA-DAY
                                               LNK-DAY6-AREA
               MOVE    LNK-DAY6-KEISAN (1:6)
                                       TO  WRK-SANTEIYM
               DISPLAY "SANTEIYM=" WRK-SANTEIYM
      *
               PERFORM VARYING IDXX    FROM    WRK-ST-IDX  BY  1
                       UNTIL   IDXX    >       WRK-ED-IDX
                       OR      FLG-CHK =       1
                   PERFORM VARYING IDYY    FROM    1   BY  1
                           UNTIL   IDYY    >       WRK-CONS-SRYCD-MAX
                           OR      WRK-CONS-SRYCD (IDXX IDYY)
                                           =       SPACE
                           OR      FLG-CHK =       1
                       DISPLAY "SRYCD=" IDXX " " IDYY " " 
                                WRK-CONS-SRYCD (IDXX IDYY)
      *
                       INITIALIZE                  SANTEI-REC
                       MOVE    LNK-RECESRCHK-HOSPNUM
                                               TO  SANTEI-HOSPNUM
                       MOVE    LNK-RECESRCHK-PTID
                                               TO  SANTEI-PTID
                       MOVE    WRK-SANTEIYM    TO  SANTEI-SRYYM
                       MOVE    WRK-CONS-SRYCD (IDXX IDYY)
                                               TO  SANTEI-SRYCD
                       MOVE    ZERO            TO  SANTEI-NYUGAIKBN
                       MOVE    ZERO            TO  SANTEI-SRYKA
                       MOVE    ZERO            TO  SANTEI-HKNCOMBINUM
                       MOVE    SANTEI-REC      TO  MCPDATA-REC
                       MOVE    "tbl_santei"    TO  MCP-TABLE
                       MOVE    "key"           TO  MCP-PATHNAME
                       PERFORM  900-SANTEI-READ-SEC
                       IF       FLG-SANTEI     =   ZERO
                           MOVE    SANTEI-SRYYM    TO
                                               LNK-RECESRCHK-SANTEIYM
                           MOVE    SANTEI-SRYCD    TO
                                               LNK-RECESRCHK-SRYCD
                           MOVE    SANTEI-FSANTEIYMD
                                                   TO
                                               LNK-RECESRCHK-FSANTEIYMD
                           MOVE    SANTEI-MSANTEID TO
                                               LNK-RECESRCHK-MSANTEID
                           MOVE    SANTEI-SRYCD    TO
                                               LNK-RECESRCHK-SRYCD
                           MOVE    WRK-CONS-COMMENT-SRYCD (IDXX)
                                                   TO
                                               LNK-RECESRCHK-COMCD
                           MOVE    1               TO  FLG-CHK
                       END-IF
                   END-PERFORM
               END-PERFORM
           END-PERFORM
      *    
           IF      FLG-CHK         =   ZERO
      *        »»ÄêÍúÎò¾ðÊóÊÔ½¸¤Ê¤·
               MOVE    5               TO  LNK-RECESRCHK-RC
           END-IF
      *
           MOVE    1               TO  FLG-END
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ½ªÎ»½èÍý
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           DISPLAY "LNK-RECESRCHK RC        =" LNK-RECESRCHK-RC
           DISPLAY "LNK-RECESRCHK SANTEIYM  =" LNK-RECESRCHK-SANTEIYM
           DISPLAY "LNK-RECESRCHK SRYCD     =" LNK-RECESRCHK-SRYCD
           DISPLAY "LNK-RECESRCHK FSANTEIYMD=" LNK-RECESRCHK-FSANTEIYMD
           DISPLAY "LNK-RECESRCHK MSANTEID  =" LNK-RECESRCHK-MSANTEID
           DISPLAY "LNK-RECESRCHK COMCD     =" LNK-RECESRCHK-COMCD
      *
           .
       300-END-EXT.
           EXIT. 
      *
      *****************************************************************
      *    »»ÄêÍúÎòÆÉ¹þ
      *****************************************************************
       900-SANTEI-READ-SEC          SECTION.
      *
           MOVE    "tbl_santei"    TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
           IF      MCP-RC          =   ZERO
               MOVE    "tbl_santei"    TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               PERFORM 900-DBFETCH-SEC
               IF      MCP-RC          =   ZERO
                   MOVE    MCPDATA-REC     TO  SANTEI-REC
                   MOVE    ZERO            TO  FLG-SANTEI
               ELSE
                   MOVE    1               TO  FLG-SANTEI
                   INITIALIZE                   SANTEI-REC
               END-IF
           ELSE
               MOVE    1               TO  FLG-SANTEI
               INITIALIZE                  SANTEI-REC
           END-IF
      *
           MOVE    "tbl_santei"    TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-SANTEI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ´µ¼ÔÆÉ¹þ
      *****************************************************************
       900-PTINF-READ-SEC          SECTION.
      *
           MOVE    PTINF-REC       TO  MCPDATA-REC
           MOVE    "tbl_ptinf"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC          =   ZERO
               MOVE    "tbl_ptinf"     TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               PERFORM   900-DBFETCH-SEC
               IF      MCP-RC          =   ZERO
                   MOVE    MCPDATA-REC     TO  PTINF-REC
                   MOVE    ZERO            TO  FLG-PTINF
               ELSE
                   INITIALIZE                  PTINF-REC
                   MOVE    1               TO  FLG-PTINF
               END-IF
           ELSE
               INITIALIZE                  PTINF-REC
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           MOVE    "tbl_ptinf"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ä£Â£Ó£Å£Ì£Å£Ã£Ô½èÍý
      *****************************************************************
       900-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
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
           PERFORM 900-ORCDBMAIN-SEC
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
           PERFORM 900-ORCDBMAIN-SEC
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
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
      *
       900-ORCDBMAIN-EXT.
           EXIT.
