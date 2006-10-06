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
       PROGRAM-ID.                 ORCSRYOCOM.
      *****************************************************************
      *  ¥·¥¹¥Æ¥àÌ¾        : £Ï£Ò£Ã£Á
      *  ¥µ¥Ö¥·¥¹¥Æ¥àÌ¾    : Æþ±¡
      *  ¥³¥ó¥Ý¡¼¥Í¥ó¥ÈÌ¾  : ÎÅÍÜ¥ì¥»¥³¥á¥ó¥È¼èÆÀ¥µ¥Ö
      *  ´ÉÍý¼Ô            : 
      *  ºîÀ®ÆüÉÕ    ºî¶È¼Ô        µ­½Ò
      *  06/10/06    NACL¡Ý¾®Æ¦Âô  ¿·µ¬ºîÀ®
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
           03  FLG-PTINF                   PIC 9(01).
           03  FLG-RYOUYOCOM               PIC 9(01).
           03  FLG-RYOYO-NYUIN             PIC 9(01).
      *    Åº»úÎÎ°è
       01  IDX-AREA.
           03  IDX                         PIC 9(04).
           03  IDX1                        PIC 9(04).
           03  IDX2                        PIC 9(04).
      *
      *    ¥³¥ó¥¹¥¿¥ó¥ÈÃÍ
       01  CONSTANT-AREA.
           03  CONS-RYOYO-NYUIN.
      *        ÎÅÍÜÉÂÅïÆþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Á¡Ë
               05                          PIC X(09) VALUE "190121310".
      *        ÎÅÍÜÉÂÅïÆþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Â¡Ë
               05                          PIC X(09) VALUE "190121410".
      *        ÎÅÍÜÉÂÅïÆþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Ã¡Ë
               05                          PIC X(09) VALUE "190121510".
      *        ÎÅÍÜÉÂÅïÆþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Ä¡Ë
               05                          PIC X(09) VALUE "190121610".
      *        ÎÅÍÜÉÂÅïÆþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Å¡Ë
               05                          PIC X(09) VALUE "190121710".
      *        ÎÅÍÜÉÂÅïÆþ±¡´ðËÜÎÁ£²¡ÊÆÃÊÌÆþ±¡´ðËÜÎÁ¡Ë
               05                          PIC X(09) VALUE "190121810".
      *        ÎÅÍÜÉÂÅïÆþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Á¡Ë¡ÊÀ¸³èÎÅÍÜ¡Ë
               05                          PIC X(09) VALUE "190123710".
      *        ÎÅÍÜÉÂÅïÆþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Â¡Ë¡ÊÀ¸³èÎÅÍÜ¡Ë
               05                          PIC X(09) VALUE "190123810".
      *        ÎÅÍÜÉÂÅïÆþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Ã¡Ë¡ÊÀ¸³èÎÅÍÜ¡Ë
               05                          PIC X(09) VALUE "190123910".
      *        ÎÅÍÜÉÂÅïÆþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Ä¡Ë¡ÊÀ¸³èÎÅÍÜ¡Ë
               05                          PIC X(09) VALUE "190124010".
      *        ÎÅÍÜÉÂÅïÆþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Å¡Ë¡ÊÀ¸³èÎÅÍÜ¡Ë
               05                          PIC X(09) VALUE "190124110".
      *        ÎÅÍÜÉÂÅïÆþ±¡´ðËÜÎÁ£²¡ÊÆÃÊÌÆþ±¡´ðËÜÎÁ¡Ë¡ÊÀ¸³èÎÅÍÜ¡Ë
               05                          PIC X(09) VALUE "190124210".
      *        Í­¾²¿ÇÎÅ½êÎÅÍÜÉÂ¾²Æþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Á¡Ë
               05                          PIC X(09) VALUE "190122010".
      *        Í­¾²¿ÇÎÅ½êÎÅÍÜÉÂ¾²Æþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Â¡Ë
               05                          PIC X(09) VALUE "190122110".
      *        Í­¾²¿ÇÎÅ½êÎÅÍÜÉÂ¾²Æþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Ã¡Ë
               05                          PIC X(09) VALUE "190122210".
      *        Í­¾²¿ÇÎÅ½êÎÅÍÜÉÂ¾²Æþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Ä¡Ë
               05                          PIC X(09) VALUE "190122310".
      *        Í­¾²¿ÇÎÅ½êÎÅÍÜÉÂ¾²Æþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Å¡Ë
               05                          PIC X(09) VALUE "190122410".
      *        Í­¾²¿ÇÎÅ½êÎÅÍÜÉÂ¾²Æþ±¡´ðËÜÎÁ£²¡ÊÆÃÊÌÆþ±¡´ðËÜÎÁ¡Ë
               05                          PIC X(09) VALUE "190122510".
      *        Í­¾²¿ÇÎÅ½êÎÅÍÜÉÂ¾²Æþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Á¡Ë¡ÊÀ¸³èÎÅÍÜ¡Ë
               05                          PIC X(09) VALUE "190124310".
      *        Í­¾²¿ÇÎÅ½êÎÅÍÜÉÂ¾²Æþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Â¡Ë¡ÊÀ¸³èÎÅÍÜ¡Ë
               05                          PIC X(09) VALUE "190124410".
      *        Í­¾²¿ÇÎÅ½êÎÅÍÜÉÂ¾²Æþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Ã¡Ë¡ÊÀ¸³èÎÅÍÜ¡Ë
               05                          PIC X(09) VALUE "190124510".
      *        Í­¾²¿ÇÎÅ½êÎÅÍÜÉÂ¾²Æþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Ä¡Ë¡ÊÀ¸³èÎÅÍÜ¡Ë
               05                          PIC X(09) VALUE "190124610".
      *        Í­¾²¿ÇÎÅ½êÎÅÍÜÉÂ¾²Æþ±¡´ðËÜÎÁ£²¡ÊÆþ±¡´ðËÜÎÁ£Å¡Ë¡ÊÀ¸³èÎÅÍÜ¡Ë
               05                          PIC X(09) VALUE "190124710".
      *        Í­¾²¿ÇÎÅ½êÎÅÍÜÉÂ¾²Æþ±¡´ðËÜÎÁ£²¡ÊÆÃÊÌÆþ±¡´ðËÜÎÁ¡Ë¡ÊÀ¸³èÎÅÍÜ¡Ë
               05                          PIC X(09) VALUE "190124810".
           03  CONS-RYOYO-NYUINR      REDEFINES    CONS-RYOYO-NYUIN.
               05  CONS-RYOYO-NYUIN-OCC    OCCURS  24.
                   07  CONS-RYOYO-SRYCD    PIC X(09).
      *
      *    °ì»þÎÎ°è
       01  WRK-AREA.
      *
           03  WRK-SYS5000-COUNT           PIC 9(02).
      *
      *    £Á£Ä£ÌÅÀ¿ôÁ´³ÑÊÑ´¹ÎÎ°è
       01  TBL-ADLTEN-AREA.
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
       01  TBL-ADLTEN-AREA-R       REDEFINES  TBL-ADLTEN-AREA.
           03  TBL-ADLTEN          PIC X(04)   OCCURS   24.
      *
      *****************************************************************
      *    ¥Õ¥¡¥¤¥ë¥ì¥¤¥¢¥¦¥È
      *****************************************************************
      *
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK5000.INC".
      *
      *    Æþ±¡¿ÇÎÅ²ñ·×¥Þ¥¹¥¿¡Ý
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    Æþ±¡¿ÇÎÅ¹Ô°Ù¥Þ¥¹¥¿¡¼
       01  NYUINACT-REC.
           COPY    "CPNYUINACT.INC".
      *
      *    ´µ¼Ô¥Þ¥¹¥¿¡Ý
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    ÎÅÍÜ¥ì¥»¥×¥È¥³¥á¥ó¥È¥Þ¥¹¥¿¡Ý
       01  RYOUYOCOM-REC.
           COPY    "CPRYOCOM.INC".
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
      *****************************************************************
      *    Ï¢Íí¡¡ÎÎ°è
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    ¥¹¥ÑÎÎ°è
           COPY    "COMMON-SPA".
      *    ÎÅÍÜ¥ì¥»¥³¥á¥ó¥È¼èÆÀ¥Ñ¥é¥á¥¿
           COPY    "CPORCSRYOCOM.INC".
      *
       PROCEDURE                   DIVISION    USING
      *     SPA-AREA
           ORCSRYOCOM-AREA
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
           INITIALIZE                  LNK-RYOCOM-HENKYAKU-AREA
           MOVE    ZERO                TO  LNK-RYOCOM-RC
      *
      *    ¥Ñ¥é¥á¡¼¥¿¥Á¥§¥Ã¥¯
           PERFORM 100-PRM-CHK-SEC
           IF    ( LNK-RYOCOM-RC       NOT =   ZERO )
               GO  TO  000-PROC-EXT
           END-IF
      *
      *    ¼ç½èÍý
           IF      LNK-RYOCOM-RC      =    ZERO
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
           IF    ( LNK-RYOCOM-SANTEIYM    =   SPACE )
               MOVE    1               TO  LNK-RYOCOM-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *    ´µ¼Ô¥Þ¥¹¥¿¡¼¸¡º÷
           INITIALIZE                      PTINF-REC
           MOVE    LNK-RYOCOM-HOSPID   TO  PTINF-HOSPID
           MOVE    LNK-RYOCOM-PTID     TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           IF      FLG-PTINF           NOT =   ZERO
               MOVE    2               TO  LNK-RYOCOM-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *
      *    Æþ±¡Ãæ¤Î¥Á¥§¥Ã¥¯¡ÊÆþ±¡²ñ·×¥Þ¥¹¥¿¡¼¸¡º÷¡Ë
           INITIALIZE                      NYUINACCT-REC
           MOVE    LNK-RYOCOM-HOSPID   TO  NACCT-HOSPID
           MOVE    LNK-RYOCOM-PTID     TO  NACCT-PTID
           MOVE    LNK-RYOCOM-SANTEIYM TO  NACCT-SRYYM
           MOVE    "5"                     TO  NACCT-ZAISKBKBN
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           NOT =   ZERO
               MOVE    3               TO  LNK-RYOCOM-RC
           ELSE
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key17"             TO  MCP-PATHNAME
               PERFORM 910-NYUINACCT-READ-SEC
               IF   FLG-NYUINACCT          NOT =   ZERO
                    MOVE    3              TO  LNK-RYOCOM-RC
               END-IF
           END-IF
      *
      *    Æþ±¡²ñ·×¥¯¥í¡¼¥º
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
      *
      *
      *    ÎÅÍÜÆþ±¡»»Äê¤Î¥Á¥§¥Ã¥¯¡ÊÆþ±¡²ñ·×¥Þ¥¹¥¿¡¼¸¡º÷¡Ë
           IF      LNK-RYOCOM-RC    =    ZERO
               INITIALIZE                      NYUINACCT-REC
               MOVE    LNK-RYOCOM-HOSPID   TO  NACCT-HOSPID
               MOVE    LNK-RYOCOM-PTID     TO  NACCT-PTID
               MOVE    LNK-RYOCOM-SANTEIYM TO  NACCT-SRYYM
               MOVE    "1"                 TO  NACCT-ZAISKBKBN
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key17"             TO  MCP-PATHNAME
               PERFORM 910-NYUINACCT-SELECT-SEC
               IF      FLG-NYUINACCT           NOT =   ZERO
                   MOVE    4               TO  LNK-RYOCOM-RC
               ELSE
                   MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
                   MOVE    "key17"             TO  MCP-PATHNAME
                   PERFORM 910-NYUINACCT-READ-SEC
                   IF   FLG-NYUINACCT          NOT =   ZERO
                        MOVE    4              TO  LNK-RYOCOM-RC
                   ELSE
                        PERFORM   UNTIL  FLG-NYUINACCT    =   1
                            PERFORM   100-PRM-RYOYO-NYUINCHK-SEC
                            MOVE    "tbl_nyuinacct"   TO  MCP-TABLE
                            MOVE    "key17"           TO  MCP-PATHNAME
                            PERFORM 910-NYUINACCT-READ-SEC
                        END-PERFORM
                   END-IF
               END-IF
      *        Æþ±¡²ñ·×¥¯¥í¡¼¥º
               MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
               MOVE    "key17"                 TO  MCP-PATHNAME
               PERFORM   910-DB-CLOSE-SEC
      *
               IF   FLG-RYOYO-NYUIN    =   ZERO
                   MOVE    4           TO  LNK-RYOCOM-RC
               END-IF
           END-IF
      *
           .
       100-PRM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÎÅÍÜÉÂÅï¡ÊÉÂ¾²¡Ë¤Ç¤ÎÆþ±¡¥Á¥§¥Ã¥¯
      *****************************************************************
       100-PRM-RYOYO-NYUINCHK-SEC          SECTION.
      *
           INITIALIZE                      NYUINACT-REC
           MOVE    NACCT-HOSPID        TO  NSRY-HOSPID
           MOVE    NACCT-NYUGAIKBN     TO  NSRY-NYUGAIKBN
           MOVE    NACCT-PTID          TO  NSRY-PTID
           MOVE    NACCT-SRYKA         TO  NSRY-SRYKA
           MOVE    NACCT-SRYYM         TO  NSRY-SRYYM
           MOVE    NACCT-ZAINUM        TO  NSRY-ZAINUM
           MOVE    "tbl_nyuinact"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-NYUINACT-SELECT-SEC
           IF      FLG-NYUINACT        =   ZERO
               MOVE    "tbl_nyuinact"  TO  MCP-TABLE
               MOVE    "key2"          TO  MCP-PATHNAME
               PERFORM 910-NYUINACT-READ-SEC
               PERFORM   VARYING  IDX   FROM   1   BY  1
                 UNTIL  (IDX      >     26)
                   IF   NSRY-SRYCD(1)   =    CONS-RYOYO-SRYCD(IDX)
                       PERFORM   VARYING  IDX1   FROM   1  BY  1
                         UNTIL  (IDX1    >   31)
                           IF   NACCT-DAY(IDX1)    =   1
                               MOVE "1"  TO  LNK-RYOCOM-NYUINKBN(IDX1)
                               MOVE  1   TO  FLG-RYOYO-NYUIN
                           END-IF
                       END-PERFORM
                   END-IF
               END-PERFORM
           END-IF
      *
           MOVE    "tbl_nyuinact"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DB-CLOSE-SEC
      *
           .
       100-PRM-RYOYO-NYUINCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼ç¼èÆÀ
      *****************************************************************
       200-MAIN-SEC            SECTION.
      *
      *    ÎÅÍÜ¥ì¥»¥×¥È¥³¥á¥ó¥È¥Þ¥¹¥¿¤Î¾ðÊó¼èÆÀ
           INITIALIZE                      RYOUYOCOM-REC
           MOVE    LNK-RYOCOM-HOSPID   TO  RYOCOM-HOSPID
           MOVE    "1"                 TO  RYOCOM-NYUGAIKBN
           MOVE    LNK-RYOCOM-PTID     TO  RYOCOM-PTID
           MOVE    LNK-RYOCOM-SANTEIYM TO  RYOCOM-SRYYM
           MOVE    "tbl_ryocom"        TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-RYOUYOCOM-SELECT-SEC
           IF      FLG-RYOUYOCOM       NOT =   ZERO
      *         MOVE    5               TO  LNK-RYOCOM-RC
               CONTINUE
           ELSE
               MOVE    "tbl_ryocom"    TO  MCP-TABLE
               MOVE    "key2"          TO  MCP-PATHNAME
               PERFORM 910-RYOUYOCOM-READ-SEC
               IF   FLG-RYOUYOCOM      NOT =   ZERO
      *              MOVE    5          TO  LNK-RYOCOM-RC
                    CONTINUE
               ELSE
                    PERFORM   UNTIL  FLG-RYOUYOCOM    =   1
                        PERFORM   210-RYOCOM-REC-SEC
                        MOVE    "tbl_ryocom"      TO  MCP-TABLE
                        MOVE    "key2"            TO  MCP-PATHNAME
                        PERFORM 910-RYOUYOCOM-READ-SEC
                    END-PERFORM
               END-IF
           END-IF
      *    ÎÅÍÜ¥ì¥»¥×¥È¥³¥á¥ó¥È¥¯¥í¡¼¥º
           MOVE    "tbl_ryocom"            TO  MCP-TABLE
           MOVE    "key2"                  TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
      *
      *
      *    ¼èÆÀ¤·¤¿£Á£Ä£ÌÅÀ¿ô¤òÁ´³ÑÊÑ´¹
           PERFORM   VARYING   IDX   FROM  1  BY  1
             UNTIL   IDX    >   31
               IF   LNK-RYOCOM-NYUINKBN(IDX)  =  "1"
                  MOVE   "840000103"   TO   LNK-RYOCOM-ADL-SRYCD(IDX)
                  IF   LNK-RYOCOM-ADL-TEN(IDX)   =  ZERO
                      MOVE  "£°£°"     TO
                                       LNK-RYOCOM-ADL-TEN-MOJI(IDX)
                  ELSE
                      MOVE  LNK-RYOCOM-ADL-TEN(IDX)   TO  IDX1
                      MOVE  TBL-ADLTEN(IDX1)
                                   TO  LNK-RYOCOM-ADL-TEN-MOJI(IDX)
                  END-IF
               END-IF
           END-PERFORM
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÎÅÍÜ¥ì¥»¥³¥á¥ó¥È¤Îµ­Ï¿
      *****************************************************************
       210-RYOCOM-REC-SEC            SECTION.
      *
      *    £Á£Ä£ÌÅÀ¿ô½¸·×
           IF     (RYOCOM-ZAINUM       >=  1000)     AND
                  (RYOCOM-ZAINUM       <=  1999)
               IF   RYOCOM-MONTH       NOT =     ZERO
                   PERFORM   VARYING  IDX   FROM  1  BY  1
                     UNTIL   IDX      >   31
                       IF   LNK-RYOCOM-NYUINKBN(IDX)  =  "1"
                           ADD   RYOCOM-MONTH  TO
                                        LNK-RYOCOM-ADL-TEN(IDX)
                       END-IF
                   END-PERFORM
               ELSE
                   PERFORM   VARYING  IDX   FROM  1  BY  1
                     UNTIL   IDX      >   31
                       IF   (LNK-RYOCOM-NYUINKBN(IDX)  =  "1")  AND
                            (RYOCOM-DAY(IDX)      NOT =   ZERO)
                           ADD  RYOCOM-DAY(IDX)   TO
                                        LNK-RYOCOM-ADL-TEN(IDX)
                       END-IF
                   END-PERFORM
               END-IF
           END-IF
      *
      *    °åÎÅ¶èÊ¬½¸·×
           IF     (RYOCOM-ZAINUM       >=  2000)     AND
                  (RYOCOM-ZAINUM       <=  2999)
               IF   RYOCOM-MONTH       NOT =     ZERO
                   PERFORM   VARYING  IDX   FROM  1  BY  1
                     UNTIL   IDX      >   31
                       IF   LNK-RYOCOM-NYUINKBN(IDX)  =  "1"
                           ADD    1   TO    LNK-RYOCOM-MEISAISU(IDX)
                           MOVE   LNK-RYOCOM-MEISAISU(IDX)  TO  IDX2
                           MOVE   RYOCOM-SRYCD  TO
                                        LNK-RYOCOM-IRYO-SRYCD(IDX IDX2)
                       END-IF
                   END-PERFORM
               ELSE
                   PERFORM   VARYING  IDX   FROM  1  BY  1
                     UNTIL   IDX      >   31
                       IF   (LNK-RYOCOM-NYUINKBN(IDX)  =  "1")  AND
                            (RYOCOM-DAY(IDX)      NOT =   ZERO)
                           ADD    1   TO    LNK-RYOCOM-MEISAISU(IDX)
                           MOVE   LNK-RYOCOM-MEISAISU(IDX)  TO  IDX2
                           MOVE   RYOCOM-SRYCD  TO
                                        LNK-RYOCOM-IRYO-SRYCD(IDX IDX2)
                       END-IF
                   END-PERFORM
               END-IF
           END-IF
      *
           .
       210-RYOCOM-REC-EXT.
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
      *    ÎÅÍÜ¥ì¥»¥×¥È¥³¥á¥ó¥È¥Þ¥¹¥¿¡Ý¸¡º÷
      *****************************************************************
       910-RYOUYOCOM-SELECT-SEC        SECTION.
      *
           MOVE    RYOUYOCOM-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-RYOUYOCOM
           ELSE
               MOVE    1                  TO  FLG-RYOUYOCOM
           END-IF
      *
           .
       910-RYOUYOCOM-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÎÅÍÜ¥ì¥»¥×¥È¥³¥á¥ó¥È¥Þ¥¹¥¿¡ÝÆÉ¹þ
      *****************************************************************
       910-RYOUYOCOM-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  RYOUYOCOM-REC
               MOVE    ZERO               TO  FLG-RYOUYOCOM
           ELSE
               INITIALIZE                     RYOUYOCOM-REC
               MOVE    1                  TO  FLG-RYOUYOCOM
           END-IF
      *
           .
       910-RYOUYOCOM-READ-EXT.
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
