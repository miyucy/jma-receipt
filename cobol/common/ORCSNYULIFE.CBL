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
       PROGRAM-ID.                 ORCSNYULIFE.
      *****************************************************************
      *  ¥·¥¹¥Æ¥àÌ¾        : £Ï£Ò£Ã£Á
      *  ¥µ¥Ö¥·¥¹¥Æ¥àÌ¾    : Æþ±¡
      *  ¥³¥ó¥Ý¡¼¥Í¥ó¥ÈÌ¾  : Æþ±¡»þÀ¸³èÎÅÍÜÈñÉéÃ´³Û¼èÆÀ¥µ¥Ö
      *                      ¡ÊÊ¿À®£±£¸Ç¯£±£°·î²þÀµÂÐ±þ¡Ë
      *  ´ÉÍý¼Ô            : 
      *  ºîÀ®ÆüÉÕ    ºî¶È¼Ô        µ­½Ò
      *  06/09/12    NACL¡Ý¾®Æ¦Âô  ¿·µ¬ºîÀ®
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
           03  FLG-SYSKANRI                PIC 9(01).
           03  FLG-OK                      PIC 9(01).
           03  FLG-TSYRRK                  PIC 9(01).
           03  FLG-TNKRRK                  PIC 9(01).
           03  FLG-RJN                     PIC 9(01).
      *    Åº»úÎÎ°è
       01  IDX-AREA.
           03  IDX                         PIC 9(04).
           03  IDX1                        PIC 9(04).
           03  TSY90-IDX                   PIC 9(02).
      *
      *    ¥³¥ó¥¹¥¿¥ó¥ÈÃÍ
       01  CONSTANT-AREA.
      *    ÎÅÍÜÉÂÅïÆþ±¡´ðËÜÎÁ£²
           03   CONS-RYOYO2A               PIC X(09) VALUE "190123710".
           03   CONS-RYOYO2B               PIC X(09) VALUE "190123810".
           03   CONS-RYOYO2C               PIC X(09) VALUE "190123910".
           03   CONS-RYOYO2D               PIC X(09) VALUE "190124010".
           03   CONS-RYOYO2E               PIC X(09) VALUE "190124110".
           03   CONS-RYOYO2TOKU            PIC X(09) VALUE "190124210".
      *    Í­¾²¿ÇÎÅ½êÎÅÍÜÉÂ¾²Æþ±¡´ðËÜÎÁ£²
           03   CONS-SRYOYO2A              PIC X(09) VALUE "190124310".
           03   CONS-SRYOYO2B              PIC X(09) VALUE "190124410".
           03   CONS-SRYOYO2C              PIC X(09) VALUE "190124510".
           03   CONS-SRYOYO2D              PIC X(09) VALUE "190124610".
           03   CONS-SRYOYO2E              PIC X(09) VALUE "190124710".
           03   CONS-SRYOYO2TOKU           PIC X(09) VALUE "190124810".
      *    ²óÉü´ü¥ê¥Ï¥Ó¥ê¥Æ¡¼¥·¥ç¥óÉÂÅïÆþ±¡ÎÁ
           03   CONS-KAIFUKU               PIC X(09) VALUE "190124910".
      *    ¿ÇÎÅ½êÏ·¿Í°åÎÅ´ÉÍýÎÁ
           03   CONS-ROUKAN1               PIC X(09) VALUE "190125010".
           03   CONS-ROUKAN2               PIC X(09) VALUE "190125110".
           03   CONS-ROUKAN3               PIC X(09) VALUE "190125210".
      *    Ã»´üÂÚºß¼ê½Ñ´ðËÜÎÁ£²
           03   CONS-TANKI2                PIC X(09) VALUE "190125310".
      *
      *    °ì»þÎÎ°è
       01  WRK-AREA.
      *
           03  WRK-GAIHAKU-SRYCD           PIC X(09).
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
      *    ´µ¼Ô¸øÈñ¾ðÊó¥Þ¥¹¥¿¡Ý
       01  PTKOHINF-REC.
           COPY    "CPPTKOHINF.INC".
      *
      *    Äã½êÆÀ
       01  TSYRRK-REC.
           COPY    "CPTSYRRK.INC".
      *
      *    Ç¯¶â
       01  TNKRRK-REC.
           COPY    "CPTNKRRK.INC".
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
      *    ÊÝ¸±»»ÄêÍÑÇ¯Îð¡¦³ä¹ç·×»»¥µ¥Ö
           COPY    "CPORCSAGECHK.INC".
      *
      *****************************************************************
      *    Ï¢Íí¡¡ÎÎ°è
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    ¥¹¥ÑÎÎ°è
           COPY    "COMMON-SPA".
      *    Æþ±¡²ñ·×ºîÀ®ÍÑ¥Ñ¥é¥á¥¿
           COPY    "CPORCSNYULIFE.INC".
      *
       PROCEDURE                   DIVISION    USING
      *     SPA-AREA
           ORCSNYULIFE-AREA
           .
      *
      *****************************************************************
      *    ¼ç¡¡¡¡½èÍý
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  LNK-NYULIFE-HENKYAKU-AREA
           MOVE    ZERO                TO  LNK-NYULIFE-RC
      *
      *    ¥Ñ¥é¥á¡¼¥¿¥Á¥§¥Ã¥¯
           PERFORM 100-PRM-CHK-SEC
           IF    ( LNK-NYULIFE-RC       NOT =   ZERO )
               GO  TO  000-PROC-EXT
           END-IF
      *
      *    ¼ç½èÍý
           IF      LNK-NYULIFE-RC      =    ZERO
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
           IF      LNK-NYULIFE-SANTEIYM    =   SPACE
               MOVE    1               TO  LNK-NYULIFE-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *    ´µ¼Ô¥Þ¥¹¥¿¡¼¸¡º÷
           INITIALIZE                       PTINF-REC
           MOVE    LNK-NYULIFE-HOSPID   TO  PTINF-HOSPID
           MOVE    LNK-NYULIFE-PTID     TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           IF      FLG-PTINF            NOT =   ZERO
               MOVE    2                TO  LNK-NYULIFE-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *    Æþ±¡Ãæ¤Î¥Á¥§¥Ã¥¯¡ÊÆþ±¡²ñ·×¥Þ¥¹¥¿¡¼¸¡º÷¡Ë
           INITIALIZE                      NYUINACCT-REC
           MOVE    LNK-NYULIFE-HOSPID   TO  NACCT-HOSPID
           MOVE    LNK-NYULIFE-PTID     TO  NACCT-PTID
           MOVE    LNK-NYULIFE-SANTEIYM TO  NACCT-SRYYM
           MOVE    "5"                  TO  NACCT-ZAISKBKBN
           MOVE    "tbl_nyuinacct"      TO  MCP-TABLE
           MOVE    "key17"              TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT        NOT =   ZERO
               MOVE    3                TO  LNK-NYULIFE-RC
           ELSE
               MOVE    "tbl_nyuinacct"  TO  MCP-TABLE
               MOVE    "key17"          TO  MCP-PATHNAME
               PERFORM 910-NYUINACCT-READ-SEC
               IF   FLG-NYUINACCT       NOT =   ZERO
                    MOVE    3           TO  LNK-NYULIFE-RC
               END-IF
           END-IF
      *
      *    Æþ±¡²ñ·×¥¯¥í¡¼¥º
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
           .
       100-PRM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼ç¼èÆÀ
      *****************************************************************
       200-MAIN-SEC            SECTION.
      *
      *    Æþ±¡»þÀ¸³èÎÅÍÜÈñ¤Î³ºÅöÆü¤È·Ú¸º¶èÊ¬£²¡ÊÆþ±¡ÎÁÈ½Äê¡Ë¤ò¼èÆÀ
           MOVE    ZERO                    TO  FLG-OK
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-NYULIFE-HOSPID      TO  NACCT-HOSPID
           MOVE    LNK-NYULIFE-PTID        TO  NACCT-PTID
           MOVE    LNK-NYULIFE-SANTEIYM    TO  NACCT-SRYYM
           MOVE    "1"                     TO  NACCT-ZAISKBKBN
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key17"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   UNTIL   (FLG-NYUINACCT    =   1)
                   IF    NACCT-SRYCDTOTAL     =    99999916
                       CONTINUE
                   ELSE
      *                À¸³èÎÅÍÜ¤Ë³ºÅö¤¹¤ëÆþ±¡ÎÁ¤òÈ½Äê¤·¡¢
      *                ÊÖµÑÃÍ¤ÎÂÐ¾Ý¶èÊ¬¤òÀßÄê¤¹¤ë
                       PERFORM    210-NYUINACT-GET-SEC
                       IF   NSRY-SRYCD(1)   =  CONS-RYOYO2A     OR
                                               CONS-RYOYO2B     OR
                                               CONS-RYOYO2C     OR
                                               CONS-RYOYO2D     OR
                                               CONS-RYOYO2E     OR
                                               CONS-RYOYO2TOKU  OR
                                               CONS-SRYOYO2A    OR
                                               CONS-SRYOYO2B    OR
                                               CONS-SRYOYO2C    OR
                                               CONS-SRYOYO2D    OR
                                               CONS-SRYOYO2E    OR
                                               CONS-SRYOYO2TOKU OR
                                               CONS-KAIFUKU     OR
                                               CONS-ROUKAN1     OR
                                               CONS-ROUKAN2     OR
                                               CONS-ROUKAN3     OR
                                               CONS-TANKI2
                          PERFORM    VARYING   IDX1   FROM   1   BY   1
                                  UNTIL     IDX1   >   31
                            IF     NACCT-DAY(IDX1)  NOT =  ZERO
                               MOVE   "1"     TO   LNK-NYULIFE-KBN(IDX1)
                               MOVE    1      TO   FLG-OK
      *                        ÉÂ¾õ¤ÎÄøÅÙ¡¢¼£ÎÅ¤ÎÆâÍÆ¤ò¤·¤ó¼à¤·¤ÆÉ¸½à
      *                        ÉéÃ´³Û¤ò·Ú¸º¤¹¤ë´µ¼Ô¤ÎÈ½Äê¡ÊÆþ±¡ÎÁÈ½ÃÇ¡Ë
                               IF  NSRY-SRYCD(1)  =  CONS-RYOYO2A  OR
                                                     CONS-RYOYO2B  OR
                                                     CONS-RYOYO2C  OR
                                                     CONS-SRYOYO2A OR
                                                     CONS-SRYOYO2B OR
                                                     CONS-SRYOYO2C OR
                                                     CONS-KAIFUKU  OR
                                                     CONS-ROUKAN1  OR
                                                     CONS-TANKI2
                                   MOVE   "1"   TO   
                                             LNK-NYULIFE-FTNKBN2(IDX1)
                               END-IF
                            END-IF
                          END-PERFORM
                       END-IF
                   END-IF
                   MOVE    "tbl_nyuinacct"      TO  MCP-TABLE
                   MOVE    "key17"              TO  MCP-PATHNAME
                   PERFORM 910-NYUINACCT-READ-SEC
               END-PERFORM
           END-IF
      *
      *    Æþ±¡²ñ·×¥¯¥í¡¼¥º
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
      *
      *¡Ý¡Ý¡Ý¡Ý°åÎÅµ¡´Ø¿©»ö¾ðÊó¼èÆÀ¤³¤³¤«¤é¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý
      *°åÎÅµ¡´Ø¿©»ö¾ðÊó¤Î¼èÆÀ¡Ê¥·¥¹¥Æ¥à´ÉÍý¥Æ¡¼¥Ö¥ë¤è¤ê¡Ë
           MOVE    ZERO                TO  FLG-SYSKANRI
           INITIALIZE                      SYSKANRI-REC
           MOVE    "5000"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    LNK-NYULIFE-SANTEIYM
                                       TO  SYS-STYUKYMD(1:6)
           MOVE    "01"                TO  SYS-STYUKYMD(7:2)
           MOVE    SYS-STYUKYMD        TO  SYS-EDYUKYMD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           CALL    "MONFUNC"               USING
                                           MCPAREA
                                           MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"  TO  MCP-TABLE
               MOVE    "key10"         TO  MCP-PATHNAME
               PERFORM  910-SYSKANRI-READ-SEC
      *        ¿©»ö¾ðÊó¤ÎÂàÈò
               IF     SYS-5000-SHOKUJIRYOYOCD  NOT =  SPACE
                   PERFORM    VARYING   IDX1  FROM  1  BY  1
                          UNTIL     IDX1   >    31
                       IF    LNK-NYULIFE-KBN(IDX1)   =   "1"
      *                   Æþ±¡»þ¿©»öÎÅÍÜÈñ
                           IF   SYS-5000-SHOKUJIRYOYOCD  = "197000110"
                                MOVE   "1"     TO  
                                          LNK-NYULIFE-SKJKBN(IDX1)
                           ELSE
                                MOVE   "2"     TO  
                                          LNK-NYULIFE-SKJKBN(IDX1)
                           END-IF
                       END-IF
                   END-PERFORM
               END-IF
           END-IF
      *    ¥·¥¹¥Æ¥à´ÉÍý¥¯¥í¡¼¥º
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
      *¡Ý¡Ý¡Ý¡Ý°åÎÅµ¡´Ø¿©»ö¾ðÊó¼èÆÀ¼èÆÀ¤³¤³¤Þ¤Ç¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý
      *
      *
           IF    FLG-OK   =    1
      *
      *        Ï·¿ÍÊÝ·ò¤Î¥Á¥§¥Ã¥¯
               MOVE    ZERO                 TO  FLG-RJN 
               INITIALIZE                       PTKOHINF-REC
               MOVE    LNK-NYULIFE-HOSPID   TO  PTKOH-HOSPID
               MOVE    LNK-NYULIFE-PTID     TO  PTKOH-PTID
               MOVE    "027"                TO  PTKOH-KOHNUM
               PERFORM 900-PTKOHINF-READ-SEC
      *
      *¡Ý¡Ý¡Ý¡Ý½êÆÀ¾ðÊó¤Î¼èÆÀ¤³¤³¤«¤é¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý
      *
      *      ·Ú¸º¶èÊ¬£±¡Ê½êÆÀÈ½Äê¡Ë¤ò¼èÆÀ
      *
      *      Äã½êÆÀ¾ðÊó¤Î¼èÆÀ
               INITIALIZE                          TSYRRK-REC
               MOVE    LNK-NYULIFE-HOSPID      TO  TSYRRK-HOSPID
               MOVE    LNK-NYULIFE-PTID        TO  TSYRRK-PTID
               MOVE    "tbl_tsyrrk"            TO  MCP-TABLE
               MOVE    "key3"                  TO  MCP-PATHNAME
               PERFORM 910-TSYRRK-SELECT-SEC
               IF      FLG-TSYRRK              =   ZERO
                   MOVE    "tbl_tsyrrk"        TO  MCP-TABLE
                   MOVE    "key3"              TO  MCP-PATHNAME
                   PERFORM 910-TSYRRK-READ-SEC
                   PERFORM  UNTIL  
                      ( FLG-TSYRRK          =   1                ) OR
                     (( TSYRRK-NINSTYMD(1:6) <= LNK-NYULIFE-SANTEIYM AND
                        LNK-NYULIFE-SANTEIYM <= TSYRRK-NINEDYMD(1:6) ))
      *
                       MOVE    "tbl_tsyrrk"     TO  MCP-TABLE
                       MOVE    "key3"           TO  MCP-PATHNAME
                       PERFORM 910-TSYRRK-READ-SEC
      *
                   END-PERFORM
               END-IF
               IF      FLG-TSYRRK              =   ZERO
                  IF  (LNK-NYULIFE-SANTEIYM   =  TSYRRK-NINSTYMD(1:6))
                  AND (TSYRRK-NINSTYMD(7:2)      NOT =  "01")
                    CONTINUE
                  ELSE
                    PERFORM   VARYING   IDX1   FROM   1  BY  1
                              UNTIL     IDX1   >    31
                        IF   LNK-NYULIFE-KBN(IDX1)   =   "1"
                            MOVE   "1"    TO  LNK-NYULIFE-FTNKBN1(IDX1)
                        END-IF
                    END-PERFORM
                  END-IF
               END-IF
      *
               MOVE     "tbl_tsyrrk"        TO  MCP-TABLE
               MOVE     "key3"              TO  MCP-PATHNAME
               PERFORM   910-DB-CLOSE-SEC
      *
      *      £¹£°Æü±Û¤¨¡ÊÄã½êÆÀ¾ðÊó¡Ë
               IF  (TSYRRK-SKJGNSTYMD(1:6)  <= LNK-NYULIFE-SANTEIYM) AND
                   (TSYRRK-SKJGNSTYMD       NOT = SPACE)
                 IF (LNK-NYULIFE-SANTEIYM  = TSYRRK-SKJGNSTYMD(1:6)) AND
                    (TSYRRK-SKJGNSTYMD(7:2)   NOT = "01")
                   CONTINUE
                 ELSE
                   IF  TSYRRK-SKJGNSTYMD(1:6)  <  LNK-NYULIFE-SANTEIYM
                       MOVE   1             TO   TSY90-IDX
                   ELSE
                       MOVE   TSYRRK-SKJGNSTYMD(7:2)   TO  TSY90-IDX
                   END-IF
                   PERFORM   VARYING   IDX1   FROM   TSY90-IDX  BY  1
                             UNTIL     IDX1   >    31
                        IF   LNK-NYULIFE-KBN(IDX1)   =   "1"
                            MOVE   "2"    TO  LNK-NYULIFE-FTNKBN1(IDX1)
                        END-IF
                   END-PERFORM
                 END-IF
               END-IF
      *
      *      ÄãÇ¯¶â¾ðÊó¤Î¼èÆÀ
               INITIALIZE                          TNKRRK-REC
               MOVE    LNK-NYULIFE-HOSPID      TO  TNKRRK-HOSPID
               MOVE    LNK-NYULIFE-PTID        TO  TNKRRK-PTID
               MOVE    "tbl_tnkrrk"            TO  MCP-TABLE
               MOVE    "key3"                  TO  MCP-PATHNAME
               PERFORM 910-TNKRRK-SELECT-SEC
               IF      FLG-TNKRRK              =   ZERO
                   MOVE    "tbl_tnkrrk"        TO  MCP-TABLE
                   MOVE    "key3"              TO  MCP-PATHNAME
                   PERFORM 910-TNKRRK-READ-SEC
                   PERFORM  UNTIL  
                      ( FLG-TNKRRK          =   1                ) OR
                     (( TNKRRK-STYMD(1:6) <= LNK-NYULIFE-SANTEIYM AND
                        LNK-NYULIFE-SANTEIYM <= TNKRRK-EDYMD(1:6) ))
      *
                       MOVE    "tbl_tnkrrk"       TO  MCP-TABLE
                       MOVE    "key3"             TO  MCP-PATHNAME
                       PERFORM 910-TNKRRK-READ-SEC
      *
                   END-PERFORM
               END-IF
               IF      FLG-TNKRRK              =   ZERO
                  IF  (LNK-NYULIFE-SANTEIYM   =  TNKRRK-STYMD(1:6))
                  AND (TNKRRK-STYMD(7:2)     NOT =  "01")
                    CONTINUE
                  ELSE
                    PERFORM   VARYING   IDX1   FROM   1  BY  1
                              UNTIL     IDX1   >    31
                        IF    LNK-NYULIFE-KBN(IDX1)   =   "1"
                            IF  TNKRRK-RRI-FUKUSHI-KBN = SPACE OR "0"
                                MOVE  "3"   TO
                                            LNK-NYULIFE-FTNKBN1(IDX1)
                            ELSE
                                MOVE  "4"   TO
                                            LNK-NYULIFE-FTNKBN1(IDX1)
                            END-IF
                        END-IF
                    END-PERFORM
                  END-IF
               END-IF
      *
               MOVE     "tbl_tnkrrk"        TO  MCP-TABLE
               MOVE     "key3"              TO  MCP-PATHNAME
               PERFORM   910-DB-CLOSE-SEC
      *
      *¡Ý¡Ý¡Ý¡Ý½êÆÀ¾ðÊó¤Î¼èÆÀ¤³¤³¤Þ¤Ç¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý¡Ý
      *
      *¡Ý¡Ý¡Ý¡Ý¿©»öÎÅÍÜ¡¢´Ä¶­ÎÅÍÜ¥³¡¼¥É¡¢Ã±²ÁÀßÄê¤³¤³¤«¤é¡Ý¡Ý¡Ý¡Ý¡Ý
             PERFORM   VARYING   IDX1   FROM   1  BY  1
               UNTIL   IDX1   >    31
                IF   LNK-NYULIFE-KBN(IDX1)   =   "1"
                    EVALUATE  LNK-NYULIFE-SKJKBN(IDX1)
                        WHEN  "1"
                            MOVE  "197001310"   TO
                                            LNK-NYULIFE-SKJ-SRYCD(IDX1)
                            MOVE   554          TO
                                            LNK-NYULIFE-SKJ-MONEY(IDX1)
                            MOVE  "197001410"   TO
                                            LNK-NYULIFE-KAN-SRYCD(IDX1)
                            MOVE   398          TO
                                            LNK-NYULIFE-KAN-MONEY(IDX1)
                        WHEN  "2"
                            MOVE  "197001710"   TO
                                            LNK-NYULIFE-SKJ-SRYCD(IDX1)
                            MOVE   420          TO
                                            LNK-NYULIFE-SKJ-MONEY(IDX1)
                            MOVE  "197001810"   TO
                                            LNK-NYULIFE-KAN-SRYCD(IDX1)
                            MOVE   398          TO
                                            LNK-NYULIFE-KAN-MONEY(IDX1)
                    END-EVALUATE
                END-IF
             END-PERFORM
      *¡Ý¡Ý¡Ý¡Ý¿©»öÎÅÍÜ¡¢´Ä¶­ÎÅÍÜ¥³¡¼¥É¡¢Ã±²ÁÀßÄê¤³¤³¤Þ¤Ç¡Ý¡Ý¡Ý¡Ý¡Ý
      *
      *¡Ý¡Ý¡Ý¡Ý¿©»öÉéÃ´¡¢´Ä¶­ÎÅÍÜÉéÃ´¥³¡¼¥É¡¢Ã±²ÁÀßÄê¤³¤³¤«¤é¡Ý¡Ý¡Ý
      *      À¸³èÎÅÍÜ¿©»öÉ¸½àÉéÃ´³ÛÀßÄê¡Ê°ìÈÌ¡Ë
             PERFORM   VARYING   IDX1   FROM   1  BY  1
               UNTIL   IDX1   >    31
                IF   LNK-NYULIFE-KBN(IDX1)   =   "1"
                    EVALUATE  LNK-NYULIFE-SKJKBN(IDX1)
                        WHEN  "1"
                            MOVE  "197002010"   TO
                                         LNK-NYULIFE-SKJFTN-SRYCD(IDX1)
                            MOVE   460          TO
                                         LNK-NYULIFE-SKJFTN-MONEY(IDX1)
                        WHEN  "2"
                            MOVE  "197002110"   TO
                                         LNK-NYULIFE-SKJFTN-SRYCD(IDX1)
                            MOVE   420          TO
                                         LNK-NYULIFE-SKJFTN-MONEY(IDX1)
                    END-EVALUATE
                END-IF
             END-PERFORM
      *
      *      À¸³èÎÅÍÜ¿©»öÉ¸½àÉéÃ´³ÛÀßÄê¡Ê·Ú¸º¤¢¤ê¤Î´µ¼Ô¡Ë
             PERFORM   VARYING   IDX1   FROM   1  BY  1
               UNTIL   IDX1   >    31
                IF   LNK-NYULIFE-KBN(IDX1)   =   "1"
                    EVALUATE  LNK-NYULIFE-FTNKBN2(IDX1)
                        WHEN  SPACE
      *                   ½êÆÀ¤Î¾õ¶·¤Ë¤è¤ë·Ú¸º
                            EVALUATE   LNK-NYULIFE-FTNKBN1(IDX1)
                                WHEN   "1"
                                WHEN   "2"
      *                           ¡ÊÄã£²¡Ë
                                    MOVE  "197002210"   TO
                                         LNK-NYULIFE-SKJFTN-SRYCD(IDX1)
                                    MOVE   210          TO
                                         LNK-NYULIFE-SKJFTN-MONEY(IDX1)
                                WHEN   "3"
      *                           ¡ÊÄã£±¡Ë
                                    IF   FLG-RJN    =   0
                                       MOVE  "197002310"   TO
                                         LNK-NYULIFE-SKJFTN-SRYCD(IDX1)
                                       MOVE   130          TO
                                         LNK-NYULIFE-SKJFTN-MONEY(IDX1)
                                    ELSE
                                       MOVE  "197002410"   TO
                                         LNK-NYULIFE-SKJFTN-SRYCD(IDX1)
                                       MOVE   130          TO
                                         LNK-NYULIFE-SKJFTN-MONEY(IDX1)
                                    END-IF
                                WHEN   "4"
      *                           ¡ÊÄã£±¡ÝÏ·ÎðÊ¡»ãÇ¯¶â¼õµë¼Ô¡Ë
                                    MOVE  "197002510"   TO
                                         LNK-NYULIFE-SKJFTN-SRYCD(IDX1)
                                    MOVE   100          TO
                                         LNK-NYULIFE-SKJFTN-MONEY(IDX1)
                            END-EVALUATE
                        WHEN  "1"
      *                   ÉÂ¾õ¤ÎÄøÅÙ¤Ë¤è¤ë·Ú¸º
                            EVALUATE   LNK-NYULIFE-FTNKBN1(IDX1)
                                WHEN   SPACE
      *                           ¡Ê°åÎÅ¶èÊ¬£²¡¢£³¡Ê°ìÈÌ¡Ë¡Ë
                                    MOVE  "197002710"   TO
                                         LNK-NYULIFE-SKJFTN-SRYCD(IDX1)
                                    MOVE   260          TO
                                         LNK-NYULIFE-SKJFTN-MONEY(IDX1)
                                WHEN   "1"
      *                           ¡Ê°åÎÅ¶èÊ¬£²¡¢£³¡ÊÄã£²¡¡£¹£°Æü°Ê²¼¡Ë¡Ë
                                    MOVE  "197002810"   TO
                                         LNK-NYULIFE-SKJFTN-SRYCD(IDX1)
                                    MOVE   210          TO
                                         LNK-NYULIFE-SKJFTN-MONEY(IDX1)
                                WHEN   "2"
      *                           ¡Ê°åÎÅ¶èÊ¬£²¡¢£³¡ÊÄã£²¡¡£¹£°ÆüÄ¶¡Ë¡Ë
                                    MOVE  "197002910"   TO
                                         LNK-NYULIFE-SKJFTN-SRYCD(IDX1)
                                    MOVE   160          TO
                                         LNK-NYULIFE-SKJFTN-MONEY(IDX1)
                                WHEN   "3"
                                WHEN   "4"
      *                           ¡Ê°åÎÅ¶èÊ¬£²¡¢£³¡ÊÄã£±¡Ë¡Ë
                                    MOVE  "197003010"   TO
                                         LNK-NYULIFE-SKJFTN-SRYCD(IDX1)
                                    MOVE   100          TO
                                         LNK-NYULIFE-SKJFTN-MONEY(IDX1)
                            END-EVALUATE
                    END-EVALUATE
                END-IF
             END-PERFORM
      *
      *      À¸³èÎÅÍÜ´Ä¶­ÎÅÍÜÉ¸½àÉéÃ´³ÛÀßÄê
             PERFORM   VARYING   IDX1   FROM   1  BY  1
               UNTIL   IDX1   >    31
                IF   LNK-NYULIFE-KBN(IDX1)   =   "1"
                    IF  LNK-NYULIFE-FTNKBN2(IDX1)   =   SPACE
                        MOVE  "197001910"       TO
                                        LNK-NYULIFE-KANFTN-SRYCD(IDX1)
                        MOVE  320       TO
                                        LNK-NYULIFE-KANFTN-MONEY(IDX1)
                    END-IF
                END-IF
             END-PERFORM
      *
      *¡Ý¡Ý¡Ý¡Ý¿©»öÉéÃ´¡¢´Ä¶­ÎÅÍÜÉéÃ´¥³¡¼¥É¡¢Ã±²ÁÀßÄê¤³¤³¤Þ¤Ç¡Ý¡Ý¡Ý
      *
           END-IF
      *
           IF   FLG-OK   =   ZERO
               MOVE   4      TO   LNK-NYULIFE-RC
           END-IF
      *
           PERFORM   VARYING  IDX1   FROM  1   BY  1
                     UNTIL  IDX1   >   31
                DISPLAY "IDX1 = " IDX1
                DISPLAY "LNK-NYULIFE-FTNKBN1(IDX1) = " 
                         LNK-NYULIFE-FTNKBN1(IDX1)
                DISPLAY "LNK-NYULIFE-FTNKBN2(IDX1) = " 
                         LNK-NYULIFE-FTNKBN2(IDX1)
                DISPLAY  "LNK-NYULIFE-SKJ-SRYCD(IDX1) = "
                          LNK-NYULIFE-SKJ-SRYCD(IDX1)
                DISPLAY "LNK-NYULIFE-SKJ-MONEY(IDX1) = "
                         LNK-NYULIFE-SKJ-MONEY(IDX1)
                DISPLAY  "LNK-NYULIFE-SKJFTN-SRYCD(IDX1) = "
                          LNK-NYULIFE-SKJFTN-SRYCD(IDX1)
                DISPLAY "LNK-NYULIFE-SKJFTN-MONEY(IDX1) = "
                         LNK-NYULIFE-SKJFTN-MONEY(IDX1)
                DISPLAY  "LNK-NYULIFE-KAN-SRYCD(IDX1) = "
                          LNK-NYULIFE-KAN-SRYCD(IDX1)
                DISPLAY "LNK-NYULIFE-KAN-MONEY(IDX1) = "
                         LNK-NYULIFE-KAN-MONEY(IDX1)
                DISPLAY  "LNK-NYULIFE-KANFTN-SRYCD(IDX1) = "
                          LNK-NYULIFE-KANFTN-SRYCD(IDX1)
                DISPLAY "LNK-NYULIFE-KANFTN-MONEY(IDX1) = "
                         LNK-NYULIFE-KANFTN-MONEY(IDX1)
           END-PERFORM
           .
       200-MAIN-EXT.
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
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       910-SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-5000-REC
               MOVE    ZERO                TO  FLG-SYSKANRI
           ELSE
               INITIALIZE                      SYS-5000-REC
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           .
       910-SYSKANRI-READ-EXT.
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
      *    ´µ¼Ô¸øÈñ¾ðÊó¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       900-PTKOHINF-READ-SEC         SECTION.
      *
           MOVE    PTKOHINF-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "tbl_ptkohinf"      TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           CALL    "MONFUNC"               USING
                                           MCPAREA
                                           MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "tbl_ptkohinf"  TO  MCP-TABLE
               MOVE    "key4"          TO  MCP-PATHNAME
               CALL    "MONFUNC"           USING
                                           MCPAREA
                                           MCPDATA-REC
               IF      MCP-RC          =   ZERO
                   MOVE    1           TO  FLG-RJN
               END-IF
           ELSE
               INITIALIZE                  PTINF-REC
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           MOVE    "tbl_ptkohinf"      TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
      *
           .
       900-PTKOHINF-READ-EXT.
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
      *    Äã½êÆÀ¥Þ¥¹¥¿¡¼¸¡º÷
      *****************************************************************
       910-TSYRRK-SELECT-SEC        SECTION.
      *
           MOVE    TSYRRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-TSYRRK
           ELSE
               MOVE    1                  TO  FLG-TSYRRK
           END-IF
      *
           .
       910-TSYRRK-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    Äã½êÆÀ¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       910-TSYRRK-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  TSYRRK-REC
               MOVE    ZERO               TO  FLG-TSYRRK
           ELSE
               INITIALIZE                     TSYRRK-REC
               MOVE    1                  TO  FLG-TSYRRK
           END-IF
      *
           .
       910-TSYRRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÄãÇ¯¶â¥Þ¥¹¥¿¡¼¸¡º÷
      *****************************************************************
       910-TNKRRK-SELECT-SEC        SECTION.
      *
           MOVE    TNKRRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-TNKRRK
           ELSE
               MOVE    1                  TO  FLG-TNKRRK
           END-IF
      *
           .
       910-TNKRRK-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÄãÇ¯¶â¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       910-TNKRRK-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  TNKRRK-REC
               MOVE    ZERO               TO  FLG-TNKRRK
           ELSE
               INITIALIZE                     TNKRRK-REC
               MOVE    1                  TO  FLG-TNKRRK
           END-IF
      *
           .
       910-TNKRRK-READ-EXT.
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
