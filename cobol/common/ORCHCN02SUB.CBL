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
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCHCN02SUB.
      *****************************************************************
      *  ¥·¥¹¥Æ¥àÌ¾        : £Ï£Ò£Ã£Á
      *  ¥µ¥Ö¥·¥¹¥Æ¥àÌ¾    : Æþ±¡
      *  ¥³¥ó¥Ý¡¼¥Í¥ó¥ÈÌ¾  : Âà±¡¾ÚÌÀ½ñÍÑÆþ±¡¼èÆÀ¥µ¥Ö
      *  ´ÉÍý¼Ô            : 
      *  ºîÀ®ÆüÉÕ    ºî¶È¼Ô        µ­½Ò
      *  06/06/08    NACL¡Ý¾®Æ¦Âô  ¿·µ¬ºîÀ®
      *****************************************************************
      *  ¥×¥í¥°¥é¥à½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      *****************************************************************
      *
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                        DIVISION.
      *FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    ¥Õ¥é¥°ÎÎ°è
       01  FLG-AREA.
           03  FLG-NYUINACCT               PIC 9(01).
           03  FLG-NYUINACT                PIC 9(01).
           03  FLG-TENSU                   PIC 9(01).
           03  FLG-PTINF                   PIC 9(01).
           03  FLG-MATCH                   PIC 9(01).
      *    Åº»úÎÎ°è
       01  IDX-AREA.
           03  IDX                         PIC 9(04).
           03  IDX1                        PIC 9(04).
           03  IDX2                        PIC 9(04).
           03  IDX3                        PIC 9(04).
           03  IDX4                        PIC 9(04).
           03  IDX5                        PIC 9(04).
           03  IDX6                        PIC 9(04).
           03  IDX7                        PIC 9(04).
           03  NYUIN-IDX                   PIC 9(04).
           03  ST-IDX                      PIC 9(04).
           03  ED-IDX                      PIC 9(04).
      *
      *    Æþ±¡ÆüÃÖ´¹¤¨ÍÑ
           03  WRK-DDX                     PIC X(02).
           03  WRK-DD9          REDEFINES  WRK-DDX
                                           PIC 9(02).
      *    ¥³¥ó¥¹¥¿¥ó¥ÈÃÍ
       01  CONSTANT-AREA.
      *    Æþ±¡¿ÇÎÅ·×²èÌ¤¼Â»Ü¸º»»
           03  CONS-KEIKAKU-GENSAN1        PIC X(09) VALUE "190080470".
           03  CONS-KEIKAKU-GENSAN2        PIC X(09) VALUE "190799670".
      *    ±¡Æâ´¶À÷ËÉ»ßÂÐºöÌ¤¼Â»Ü¸º»»
           03  CONS-INNAI-GENSAN1          PIC X(09) VALUE "190080570".
           03  CONS-INNAI-GENSAN2          PIC X(09) VALUE "190799770".
      *    °åÎÅ°ÂÁ´´ÉÍýÂÎÀ©Ì¤À°È÷¸º»»
           03  CONS-ANZEN-GENSAN1          PIC X(09) VALUE "190111690".
           03  CONS-ANZEN-GENSAN2          PIC X(09) VALUE "190809090".
      *    êóáìÂÐºöÌ¤¼Â»Ü¸º»»
           03  CONS-JYOKU-GENSAN1          PIC X(09) VALUE "190111790".
           03  CONS-JYOKU-GENSAN2          PIC X(09) VALUE "190809190".
      *    Æü¾ïÀ¸³è¾ã³²²Ã»»
           03  CONS-NICHIJOU-KSN1          PIC X(09) VALUE "190109170".
           03  CONS-NICHIJOU-KSN2          PIC X(09) VALUE "190807570".
      *    Ç§ÃÎ¾É²Ã»»
           03  CONS-CHIHOU-KSN1            PIC X(09) VALUE "190109270".
           03  CONS-CHIHOU-KSN2            PIC X(09) VALUE "190808670".
      *    êóáì´µ¼Ô´ÉÍý²Ã»»
           03  CONS-JYOKU-KSN1             PIC X(09) VALUE "190116990".
           03  CONS-JYOKU-KSN2             PIC X(09) VALUE "190813390".
      *    ÆÃÄê¹³Àº¿ÀÉÂÌô¼£ÎÅ´ÉÍý²Ã»»
           03  CONS-TOKUSEIYAKU-KSN        PIC X(09) VALUE "190117570".
      *    ¤½¤ÎÂ¾¿ÇÎÅ¹Ô°Ù¤ÇÆþÎÏ¤·¤¿Æþ±¡ÎÁ²Ã»»
           03  CONS-ETCNYUIN-TBL.
             05  CONS-ETCNYUIN-KSN         PIC X(09)  OCCURS 10.
      *    ÅÀ¿ô¥Þ¥¹¥¿ÆÉ¤ß¹þ¤ß¥ï¡¼¥¯ÍÑ
           03  TTNS-CONST-MAX              PIC 9(03) VALUE 200.
      *
      *    °ì»þÎÎ°è
       01  WRK-AREA.
      *
           03  WRK-GAIHAKU-SRYCD           PIC X(09).
           03  WRK-MEISAISU                PIC 9(03).
           03  WRK-KSNKBN                  PIC 9(03).
      *
           03  WRK-SYS5000-COUNT           PIC 9(02).
      *
           03  WRK-GENSAN2-MIJISI          PIC 9(01).
           03  WRK-GENSAN3-MIJISI          PIC 9(01).
           03  WRK-GENSAN4-MIJISI          PIC 9(01).
      *
      *    Æþ±¡²ñ·×¥ï¡¼¥¯
           03  WRK-NYUIN-TABLE.
               05  WRK-NYUIN-TBL           OCCURS  31.
                   07  WRK-HKNCOMBI-DAY    PIC 9(03).
                   07  WRK-SRYKBN          PIC X(02).
                   07  WRK-NYUINKHN        PIC X(09).
                   07  WRK-SHOKIKSN        PIC X(09).
                   07  WRK-GAIHAKU         PIC X(09).
                   07  WRK-NYUKHNKSNKBN    PIC 9(03).
                   07  WRK-GAIHAKU-KBN     PIC 9(01).
      *
      *    ÆüÉÕÁ´³ÑÊÑ´¹ÎÎ°è
       01  TBL-DAY-AREA.
           03  FILLER              PIC X(04)  VALUE "£°£±".
           03  FILLER              PIC X(04)  VALUE "£°£²".
           03  FILLER              PIC X(04)  VALUE "£°£³".
           03  FILLER              PIC X(04)  VALUE "£°£´".
           03  FILLER              PIC X(04)  VALUE "£°£µ".
           03  FILLER              PIC X(04)  VALUE "£°£¶".
           03  FILLER              PIC X(04)  VALUE "£°£·".
           03  FILLER              PIC X(04)  VALUE "£°£¸".
           03  FILLER              PIC X(04)  VALUE "£°£¹".
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
      *****************************************************************
      *    ¥Õ¥¡¥¤¥ë¥ì¥¤¥¢¥¦¥È
      *****************************************************************
      *
      *    Æþ±¡²ñ·×¥Þ¥¹¥¿¡Ý
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    Æþ±¡¿ÇÎÅ¹Ô°Ù¥Þ¥¹¥¿¡¼
       01  NYUINACT-REC.
           COPY    "CPNYUINACT.INC".
      *
      *    ÅÀ¿ô¥Þ¥¹¥¿¡Ý
           COPY    "CPTENSU.INC".
      *
      *    ´µ¼Ô¥Þ¥¹¥¿¡Ý
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *
      *    £Ä£Â¸¡º÷
           COPY    "MCPDATA.INC".
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    ¥µ¥Ö¥×¥íÍÑ¡¡ÎÎ°è
      *****************************************************************
      *
      *   ÆüÉÕÊÑ´¹¥µ¥Ö
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    ÄÌ»»Æü¿ô¼èÆÀ¥µ¥Ö
           COPY "CPORCSTUSAN.INC".
      *
      *****************************************************************
      *    Ï¢Íí¡¡ÎÎ°è
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    ¥¹¥ÑÎÎ°è
           COPY    "COMMON-SPA".
      *    Âà±¡¾ÚÌÀ½ñÍÑÆþ±¡¼èÆÀ¥Ñ¥é¥á¥¿
           COPY    "CPORCHCN02SUB.INC".
      *
       PROCEDURE                   DIVISION    USING
      *     SPA-AREA
            ORCHCN02SUB-AREA
           .
      *
      *****************************************************************
      *    ¼ç¡¡¡¡½èÍý
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  LNK-ORCHCN02SUB-HENKYAKU-AREA
           INITIALIZE                  CONS-ETCNYUIN-TBL
           MOVE    ZERO                TO  LNK-ORCHCN02SUB-RC
      *
      *    ¥Ñ¥é¥á¡¼¥¿¥Á¥§¥Ã¥¯
           PERFORM 100-PRM-CHK-SEC
           IF    ( LNK-ORCHCN02SUB-RC       NOT =   ZERO )
               GO  TO  000-PROC-EXT
           END-IF
      *
      *    ¼ç½èÍý
           IF      LNK-ORCHCN02SUB-RC      =    ZERO
               PERFORM 200-MAIN-SEC
           END-IF
      *
           .
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    ¥Ñ¥é¥á¡¼¥¿¥Á¥§¥Ã¥¯
      *****************************************************************
       100-PRM-CHK-SEC                     SECTION.
      *
      *    »»ÄêÇ¯·î¥Á¥§¥Ã¥¯
           IF    ( LNK-ORCHCN02SUB-HOSPID    =   SPACE )   OR
                 ( LNK-ORCHCN02SUB-PTID      =   SPACE )   OR
                 ( LNK-ORCHCN02SUB-NYUINYMD  =   SPACE )   OR
                 ( LNK-ORCHCN02SUB-TAIINYMD  =   SPACE )
               MOVE    1               TO  LNK-ORCHCN02SUB-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *    ´µ¼Ô¥Þ¥¹¥¿¡¼¸¡º÷
           INITIALIZE                       PTINF-REC
           MOVE    LNK-ORCHCN02SUB-HOSPID   TO  PTINF-HOSPID
           MOVE    LNK-ORCHCN02SUB-PTID     TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           IF      FLG-PTINF           NOT =   ZERO
               MOVE    1               TO  LNK-ORCHCN02SUB-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
           .
       100-PRM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼ç¼èÆÀ
      *****************************************************************
       200-MAIN-SEC            SECTION.
      *
      *Æþ±¡ÎÁ¤Î¼èÆÀ
           INITIALIZE                           NYUINACCT-REC
           MOVE    LNK-ORCHCN02SUB-HOSPID   TO  NACCT-HOSPID
           MOVE    LNK-ORCHCN02SUB-PTID     TO  NACCT-PTID
           MOVE    LNK-ORCHCN02SUB-NYUINYMD(1:6)
                                            TO  NACCT-SRYYM
           MOVE    "tbl_nyuinacct"          TO  MCP-TABLE
           MOVE    "key34"                  TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key34"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   UNTIL   (FLG-NYUINACCT    =   1)
      *
      *            ³ºÅöÆþ±¡¹Ô°Ù¥Æ¡¼¥Ö¥ë¤ÎÆÉ¤ß¹þ¤ß
                   PERFORM    210-NYUINACT-GET-SEC
      *
      *            Æþ±¡´ðËÜÎÁÃ±°Ì¤ÎÆþ±¡Æü¿ô¥«¥¦¥ó¥È
                   PERFORM    210-NYUIN-COUNT-SEC
      *
                   MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
                   MOVE    "key34"                 TO  MCP-PATHNAME
                   PERFORM 910-NYUINACCT-READ-SEC
               END-PERFORM
           END-IF
      *    Æþ±¡²ñ·×¥¯¥í¡¼¥º
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key34"                 TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
      *
      *
      *ÁªÄêÂÐ¾ÝÆü¿ô¤Î¼èÆÀ
           INITIALIZE                       ORCSTUSANAREA
           MOVE    LNK-ORCHCN02SUB-HOSPID   TO  STUSAN-HOSPID
           MOVE    LNK-ORCHCN02SUB-PTID     TO  STUSAN-PTID
           MOVE    LNK-ORCHCN02SUB-TAIINYMD TO  STUSAN-KJNYMD
           CALL    "ORCSTUSAN"     USING        ORCSTUSANAREA
           MOVE    STUSAN-NISSU04           TO  LNK-ORCHCN02SUB-TKIKAN
      *
      *
      *   ·ë²ÌÉ½¼¨
      *     PERFORM    VARYING   IDX1   FROM  1  BY  1
      *                UNTIL     (IDX1   >     5)
      *          DISPLAY  "IDX1 = " IDX1
      *          DISPLAY  "LNK-ORCHCN02SUB-SYUBETUCD = "
      *                    LNK-ORCHCN02SUB-SYUBETUCD(IDX1)
      *          DISPLAY  "LNK-ORCHCN02SUB-SYUBETUMEI = "
      *                    LNK-ORCHCN02SUB-SYUBETUMEI(IDX1)
      *          DISPLAY  "LNK-ORCHCN02SUB-NISSU = "
      *                    LNK-ORCHCN02SUB-NISSU(IDX1)
      *     END-PERFORM
            DISPLAY  "LNK-ORCHCN02SUB-TKIKAN = " LNK-ORCHCN02SUB-TKIKAN
            DISPLAY  "STUSAN-RC = " STUSAN-RC
      *
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    Æþ±¡ÎÁÃ±°Ì¤ÎÆü¿ô¥«¥¦¥ó¥È
      *****************************************************************
       210-NYUIN-COUNT-SEC            SECTION.
      *
           MOVE       ZERO      TO    FLG-MATCH
      *
           PERFORM    VARYING   NYUIN-IDX   FROM   1   BY   1
             UNTIL   (LNK-ORCHCN02SUB-SYUBETUCD(NYUIN-IDX) = SPACE) OR
                     (FLG-MATCH        =   1 )     OR
                     (NYUIN-IDX    >   5)
      *        ÅÀ¿ô¥Þ¥¹¥¿¤è¤êÆþ±¡ÎÁÌ¾¾Î¤Î¼èÆÀ¡Ê¥ï¡¼¥¯¤È¤ÎÈæ³ÓÍÑ¡Ë
               INITIALIZE    TNS-TENSU-REC
               MOVE   NSRY-SRYCD(1)   TO    TNS-SRYCD
               MOVE   NACCT-SRYYM     TO    TNS-YUKOSTYMD(1:6)
                                            TNS-YUKOEDYMD(1:6)
               MOVE   "01"            TO    TNS-YUKOSTYMD(7:2)
                                            TNS-YUKOEDYMD(7:2)
               PERFORM    910-TENSU-READ-SEC
               IF    (NACCT-SRYYM      >=   "200604")    AND
                     (NSRY-SRYCD(1)    =    "190097010"  OR
                                            "190097110"  OR
                                            "190119510"  OR
                                            "190119610")
                   MOVE   "111111111"     TO    NSRY-SRYCD(1)
                   MOVE   "Í­¾²¿ÇÎÅ½êÆþ±¡´ðËÜÎÁ£±"  TO   TNS-NAME
               END-IF
               IF    (NACCT-SRYYM      >=   "200604")    AND
                     (NSRY-SRYCD(1)    =    "190097210"  OR
                                            "190097310"  OR
                                            "190119710"  OR
                                            "190119810")
                   MOVE   "222222222"     TO    NSRY-SRYCD(1)
                   MOVE   "Í­¾²¿ÇÎÅ½êÆþ±¡´ðËÜÎÁ£²"  TO   TNS-NAME
               END-IF
               IF   (NSRY-SRYCD(1)  =
                          LNK-ORCHCN02SUB-SYUBETUCD(NYUIN-IDX))  AND
                    (TNS-NAME   = 
                          LNK-ORCHCN02SUB-SYUBETUMEI(NYUIN-IDX))
                    MOVE   1      TO    FLG-MATCH
                    IF   NACCT-SRYYM  =  LNK-ORCHCN02SUB-NYUINYMD(1:6)
                         MOVE   LNK-ORCHCN02SUB-NYUINYMD(7:2) 
                                         TO   WRK-DDX
                         MOVE   WRK-DD9  TO   ST-IDX
                    ELSE
                         MOVE    1       TO   ST-IDX
                    END-IF
                    IF   NACCT-SRYYM  =  LNK-ORCHCN02SUB-TAIINYMD(1:6)
                         MOVE   LNK-ORCHCN02SUB-TAIINYMD(7:2) 
                                         TO   WRK-DDX
                         MOVE   WRK-DD9  TO   ED-IDX
                    ELSE
                         MOVE   31       TO   ED-IDX
                    END-IF
                    PERFORM   VARYING   IDX1   FROM  ST-IDX  BY  1
                      UNTIL   IDX1      >   ED-IDX
                          IF   NACCT-DAY(IDX1)    NOT =  ZERO
                               ADD   1     TO
                                       LNK-ORCHCN02SUB-NISSU(NYUIN-IDX)
                          END-IF
                    END-PERFORM
               END-IF
           END-PERFORM
      *
           IF   (FLG-MATCH     =     ZERO)   AND
                (NYUIN-IDX     <=       5)
               MOVE  NSRY-SRYCD(1)   TO
                                 LNK-ORCHCN02SUB-SYUBETUCD(NYUIN-IDX)
      *        ÅÀ¿ô¥Þ¥¹¥¿¤è¤êÆþ±¡ÎÁÌ¾¾Î¤Î¼èÆÀ
               INITIALIZE    TNS-TENSU-REC
               MOVE   LNK-ORCHCN02SUB-SYUBETUCD(NYUIN-IDX)
                                            TO  TNS-SRYCD
               MOVE   NACCT-SRYYM     TO    TNS-YUKOSTYMD(1:6)
                                            TNS-YUKOEDYMD(1:6)
               MOVE   "01"            TO    TNS-YUKOSTYMD(7:2)
                                            TNS-YUKOEDYMD(7:2)
               PERFORM    910-TENSU-READ-SEC
               MOVE     TNS-NAME      TO
                             LNK-ORCHCN02SUB-SYUBETUMEI(NYUIN-IDX)
               IF    (NACCT-SRYYM      >=   "200604")    AND
                     (LNK-ORCHCN02SUB-SYUBETUCD(NYUIN-IDX)  =
                                            "190097010"  OR
                                            "190097110"  OR
                                            "190119510"  OR
                                            "190119610")
                   MOVE   "111111111"     TO
                               LNK-ORCHCN02SUB-SYUBETUCD(NYUIN-IDX)
                   MOVE   "Í­¾²¿ÇÎÅ½êÆþ±¡´ðËÜÎÁ£±"  TO
                               LNK-ORCHCN02SUB-SYUBETUMEI(NYUIN-IDX)
               END-IF
               IF    (NACCT-SRYYM      >=   "200604")    AND
                     (LNK-ORCHCN02SUB-SYUBETUCD(NYUIN-IDX)  =
                                            "190097210"  OR
                                            "190097310"  OR
                                            "190119710"  OR
                                            "190119810")
                   MOVE   "222222222"     TO
                               LNK-ORCHCN02SUB-SYUBETUCD(NYUIN-IDX)
                   MOVE   "Í­¾²¿ÇÎÅ½êÆþ±¡´ðËÜÎÁ£²"  TO
                               LNK-ORCHCN02SUB-SYUBETUMEI(NYUIN-IDX)
               END-IF
      *
               IF   NACCT-SRYYM  =  LNK-ORCHCN02SUB-NYUINYMD(1:6)
                    MOVE   LNK-ORCHCN02SUB-NYUINYMD(7:2) 
                                    TO   WRK-DDX
                    MOVE   WRK-DD9  TO   ST-IDX
               ELSE
                    MOVE    1       TO   ST-IDX
               END-IF
               IF   NACCT-SRYYM  =  LNK-ORCHCN02SUB-TAIINYMD(1:6)
                    MOVE   LNK-ORCHCN02SUB-TAIINYMD(7:2) 
                                    TO   WRK-DDX
                    MOVE   WRK-DD9  TO   ED-IDX
               ELSE
                    MOVE   31       TO   ED-IDX
               END-IF
               PERFORM   VARYING   IDX1   FROM  ST-IDX  BY  1
                 UNTIL   IDX1      >   ED-IDX
                     IF   NACCT-DAY(IDX1)    NOT =  ZERO
                          ADD   1     TO
                                  LNK-ORCHCN02SUB-NISSU(NYUIN-IDX)
                     END-IF
               END-PERFORM
           END-IF
      *
           .
       210-NYUIN-COUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    Æþ±¡¿ÇÎÅ¹Ô°Ù¼èÆÀ
      *****************************************************************
       210-NYUINACT-GET-SEC            SECTION.
      *
           INITIALIZE                      NYUINACT-REC
           MOVE    NACCT-HOSPID        TO  NSRY-HOSPID
           MOVE    NACCT-NYUGAIKBN     TO  NSRY-NYUGAIKBN
           MOVE    NACCT-PTID          TO  NSRY-PTID
           MOVE    NACCT-SRYYM         TO  NSRY-SRYYM
           MOVE    NACCT-ZAINUM        TO  NSRY-ZAINUM
           MOVE    "tbl_nyuinact"      TO  MCP-TABLE
           MOVE    "key9"              TO  MCP-PATHNAME
           PERFORM 910-NYUINACT-SELECT-SEC
           IF      FLG-NYUINACT        =   ZERO
               MOVE    "tbl_nyuinact"  TO  MCP-TABLE
               MOVE    "key9"          TO  MCP-PATHNAME
               PERFORM   910-NYUINACT-READ-SEC
           END-IF
      *
      *    Æþ±¡¹Ô°Ù¥¯¥í¡¼¥º
           MOVE     "tbl_nyuinact"     TO  MCP-TABLE
           MOVE     "key9"             TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
      *
           .
       210-NYUINACT-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ´µ¼Ô¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           CALL    "MONFUNC"               USING
                                           MCPAREA
                                           MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "tbl_ptinf"         TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               CALL    "MONFUNC"           USING
                                           MCPAREA
                                           MCPDATA-REC
               IF      MCP-RC          =   ZERO
                   MOVE    MCPDATA-REC TO  PTINF-REC
                   MOVE    ZERO        TO  FLG-PTINF
               ELSE
                   INITIALIZE              PTINF-REC
                   MOVE    1           TO  FLG-PTINF
               END-IF
           ELSE
               INITIALIZE                  PTINF-REC
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    Æþ±¡²ñ·×¥Þ¥¹¥¿¡¼¸¡º÷
      *****************************************************************
       910-NYUINACCT-SELECT-SEC        SECTION.
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-NYUINACCT
           ELSE
               MOVE    1                  TO  FLG-NYUINACCT
           END-IF
      *
           .
       910-NYUINACCT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    Æþ±¡²ñ·×¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       910-NYUINACCT-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  NYUINACCT-REC
               MOVE    ZERO               TO  FLG-NYUINACCT
           ELSE
               INITIALIZE                     NYUINACCT-REC
               MOVE    1                  TO  FLG-NYUINACCT
           END-IF
      *
           .
       910-NYUINACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    Æþ±¡¿ÇÎÅ¹Ô°Ù¥Þ¥¹¥¿¡¼¸¡º÷
      *****************************************************************
       910-NYUINACT-SELECT-SEC        SECTION.
      *
           MOVE    NYUINACT-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-NYUINACT
           ELSE
               MOVE    1                  TO  FLG-NYUINACT
           END-IF
      *
           .
       910-NYUINACT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    Æþ±¡¿ÇÎÅ¹Ô°Ù¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       910-NYUINACT-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  NYUINACT-REC
               MOVE    ZERO                TO  FLG-NYUINACT
           ELSE
               INITIALIZE                      NYUINACT-REC
               MOVE    1                   TO  FLG-NYUINACT
           END-IF
      *
           .
       910-NYUINACT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÅÀ¿ô¥Þ¥¹¥¿¡¼ÆÉ¹þ¡Ê¼ç¥­¡¼¡Ë
      *****************************************************************
       910-TENSU-READ-SEC         SECTION.
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "tbl_tensu"         TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               CALL    "MONFUNC"            USING
                                            MCPAREA
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
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
      *
           .
       910-TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ä£Â¥¯¥í¡¼¥º½èÍý
      *****************************************************************
       910-DB-CLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR"      TO  MCP-FUNC
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
      *
           .
      *
       910-DB-CLOSE-EXT.
           EXIT.
