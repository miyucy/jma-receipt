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
       IDENTIFICATION                  DIVISION.
       PROGRAM-ID.                     ORCGQSUB02.
      *****************************************************************
      *  ¥·¥¹¥Æ¥àÌ¾        : £Ï£Ò£Ã£Á
      *  ¥µ¥Ö¥·¥¹¥Æ¥àÌ¾    : ´µ¼Ô¾È²ñ
      *  ¥³¥ó¥Ý¡¼¥Í¥ó¥ÈÌ¾  : ´µ¼Ô¾È²ñ¥µ¥Ö¡Ê¸¡º÷£Ó£Ñ£ÌºîÀ®¡Ë
      *  ´ÉÍý¼Ô            : 
      *  ºîÀ®ÆüÉÕ    ºî¶È¼Ô        µ­½Ò
      *  03/06/18    NACL¡ÝÂÀÅÄ    ¿·µ¬ºîÀ®
      *****************************************************************
      *  ¥×¥í¥°¥é¥à½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      *****************************************************************
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    ¥Õ¥é¥°ÎÎ°è
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-JYOKEN                          PIC 9(01).
           03  FLG-JYOKEN-AND                      PIC 9(01).
           03  FLG-JYOKEN-OR                       PIC 9(01).
      *
      *    Åº»úÎÎ°è
       01  IDX-AREA.
           03  IDX1                                PIC 9(05).
           03  IDX2                                PIC 9(05).
           03  IDXA                                PIC 9(05).
           03  IDX-LEN                             PIC 9(05).
           03  IDX-KMK1                            PIC 9(05).
           03  IDX-KMK2                            PIC 9(05).
           03  IDX-KMK3                            PIC 9(05).
           03  IDX-SRT1                            PIC 9(05).
           03  IDX-SRT2                            PIC 9(05).
           03  IDX-SRT3                            PIC 9(05).
      *
      *    ¥«¥¦¥ó¥ÈÎÎ°è
       01  CNT-AREA.
           03  CNT-JYOKEN                          PIC 9(05).
      *
      *    °ì»þÎÎ°è
       01  WRK-AREA.
           03  WRK-KIGO-LEN                        PIC 9(05).
           03  WRK-NUM-LEN                         PIC 9(05).
           03  WRK-STR                             PIC X(20000).
           03  WRK-STR-LEN                         PIC 9(05).
           03  WRK-SQL-TBL-NAME                    PIC X(30).
           03  WRK-STSRYYMD                        PIC X(08).
           03  WRK-EDSRYYMD                        PIC X(08).
           03  WRK-STBIRTHDAY                      PIC X(08).
           03  WRK-EDBIRTHDAY                      PIC X(08).
           03  WRK-STLASTYMD                       PIC X(08).
           03  WRK-EDLASTYMD                       PIC X(08).
           03  WRK-EDPTNUM                         PIC X(20).
           03  WRK-SQL-PNT                         PIC 9(05).
           03  WRK-SQL                             PIC X(20000).
           03  WRK-SQL-COUNT                       PIC X(20000).
           03  WRK-NAME-SEQ                        PIC 9(01).
           03  WRK-KOHNUM                          PIC X(04).
           03  WRK-PAYKBN                          PIC X(02).
      *
      *    ¸ÇÄêÃÍÎÎ°è
       01  CONST-AREA.
           03  CONST-PTINF-MAX     PIC 9(05)   VALUE 50.
           03  CONST-KMK-ITEM-AREA.
               05  FILLER          PIC X(10)   VALUE "ptnum".
               05  FILLER          PIC X(10)   VALUE "kananame".
               05  FILLER          PIC X(10)   VALUE "sex".
               05  FILLER          PIC X(10)   VALUE "birthday".
               05  FILLER          PIC X(10)   VALUE "home_adrs".
           03  CONST-KMK-ITEM-R    REDEFINES   CONST-KMK-ITEM-AREA.
               05  CONST-KMK-ITEM  PIC X(10)   OCCURS  5.
      *
           03  CONST-ORDER-AREA.
               05  FILLER          PIC X(5)    VALUE "asc".
               05  FILLER          PIC X(5)    VALUE "desc".
           03  CONST-ORDER-R       REDEFINES   CONST-ORDER-AREA.
               05  CONST-ORDER     PIC X(5)    OCCURS  2.
      *
      *****************************************************************
      *    ¥µ¥Ö¥×¥íÍÑ¡¡ÎÎ°è
      *****************************************************************
      *
      *****************************************************************
      *    Ï¢Íí¡¡ÎÎ°è
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "COMMON-SPA".
           COPY    "Q01SCR-SPA".
           COPY    "CPQSUB02.INC".
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           SPA-Q01FREE
           QSUB02-LNK.
      *****************************************************************
      *    ¼ç¡¡¡¡½èÍý
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE              QSUB02-OT-AREA
                                   FLG-AREA
                                   IDX-AREA
                                   CNT-AREA
                                   WRK-AREA
      *
           PERFORM 100-JYOKEN-EDIT-SEC
      *
           MOVE    WRK-SQL         TO  QSUB02-SQL
           MOVE    WRK-SQL-COUNT   TO  QSUB02-SQL-CNT
      *
           EXIT PROGRAM
           .
      *
      *****************************************************************
      *    ¸¡º÷¾ò·ïÊÔ½¸½èÍý
      *****************************************************************
       100-JYOKEN-EDIT-SEC          SECTION.
      *
           INITIALIZE                  WRK-SQL
                                       WRK-SQL-COUNT
      *
           MOVE    1               TO  WRK-SQL-PNT
      *
           IF      ( SPA-Q01-STSRYYMD  =   SPACE )
               MOVE    ALL "0"     TO  WRK-STSRYYMD
           ELSE
               MOVE    SPA-Q01-STSRYYMD
                                   TO  WRK-STSRYYMD
           END-IF
      *
           IF      ( SPA-Q01-EDSRYYMD  =   SPACE )
               MOVE    ALL "9"     TO  WRK-EDSRYYMD
           ELSE
               MOVE    SPA-Q01-EDSRYYMD
                                   TO  WRK-EDSRYYMD
           END-IF
      *
           IF      ( SPA-Q01-STBIRTHDAY
                                       =   SPACE )
               MOVE    ALL "0"     TO  WRK-STBIRTHDAY
           ELSE
               MOVE    SPA-Q01-STBIRTHDAY
                                   TO  WRK-STBIRTHDAY
           END-IF
      *
           IF      ( SPA-Q01-EDBIRTHDAY
                                       =   SPACE )
               MOVE    ALL "9"     TO  WRK-EDBIRTHDAY
           ELSE
               MOVE    SPA-Q01-EDBIRTHDAY
                                   TO  WRK-EDBIRTHDAY
           END-IF
      *
           IF      ( SPA-Q01-STLASTYMD =   SPACE )
               MOVE    ALL "0"     TO  WRK-STLASTYMD
           ELSE
               MOVE    SPA-Q01-STLASTYMD
                                   TO  WRK-STLASTYMD
           END-IF
      *
           IF      ( SPA-Q01-EDLASTYMD =   SPACE )
               MOVE    ALL "9"     TO  WRK-EDLASTYMD
           ELSE
               MOVE    SPA-Q01-EDLASTYMD
                                   TO  WRK-EDLASTYMD
           END-IF
      *
           IF      ( SPA-Q01-EDPTNUM   =   SPACE )
               MOVE    ALL "Z"     TO  WRK-EDPTNUM
           ELSE
               MOVE    SPA-Q01-EDPTNUM
                                   TO  WRK-EDPTNUM
           END-IF
      *
      *    ºÇ½ª¼õ¿ÇÆü
           IF  ( SPA-Q01-GTBL (3)  =   "1" )
               STRING  ",tbl_srykarrk b"       DELIMITED  BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
           END-IF
      *
      *    ÉÂÌ¾¥³¡¼¥É
           IF  ( SPA-Q01-GTBL (4)  =   "1" )
               PERFORM 1001-BYOMEI-JYOKEN-EDIT-SEC
           END-IF
      *
           IF      ((  SPA-Q01-GTBL (5)    =   "1" )
                OR  (  SPA-Q01-GTBL (6)    =   "1" ))
            AND    (   SPA-Q01-GTBL (8)    =   "1" )
               PERFORM 1001-VIEWQ001-JYOKEN-EDIT-SEC
      *
           ELSE
      *        ÊÝ¸±µ­¹æ¡¦ÈÖ¹æ
               IF   ( SPA-Q01-GTBL (5)  =   "1" )
                   STRING  ",tbl_pthkninf d"   DELIMITED  BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
               END-IF
      *
      *        ¸øÈñÊÝ¸±µ­¹æÈÖ¹æ¡¦ÉéÃ´¼ÔÈÖ¹æ
               IF   ( SPA-Q01-GTBL (6)  =   "1" )
                   PERFORM 1001-PTKOHINF-JYOKEN-EDIT-SEC
               END-IF
           END-IF
      *
      *    ¿Ç»¡Ç¯·îÆü
           IF   ( SPA-Q01-GTBL (8)  =   "1" )
               IF    ( SPA-Q01-GTBL (4)  =   "1" )
                OR   ( SPA-Q01-GTBL (5)  =   "1" )
                OR   ( SPA-Q01-GTBL (6)  =   "1" )
                OR   ( SPA-Q01-GTBL (9)  =   "1" )
                   CONTINUE
               ELSE
                   STRING  ",tbl_jyurrk f"         DELIMITED  BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
               END-IF
           END-IF
      *
      *    ¿ÇÎÅ¹Ô°Ù¥³¡¼¥É
           IF   ( SPA-Q01-GTBL (9)  =   "1" )
               PERFORM 1001-SRYACT-JYOKEN-EDIT-SEC
           END-IF
      *
           STRING  " where a.hospid='"         DELIMITED  BY   SIZE
                   SPA-HOSPID                   DELIMITED  BY  SIZE
                   "' and "                     DELIMITED  BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER WRK-SQL-PNT
           END-STRING
      *
      *    ¥«¥Ê»áÌ¾¡¦´Á»ú»áÌ¾
           IF  ( SPA-Q01-GTBL (2)  =   "1" )
               MOVE    FLG-JYOKEN      TO  FLG-JYOKEN-AND
               PERFORM     1001-PTINF-SQL-EDIT2-SEC
               MOVE    1               TO  FLG-JYOKEN
           END-IF
      *
      *    ºÇ½ª¼õ¿ÇÆü
           IF  ( SPA-Q01-GTBL (3)  =   "1" )
               MOVE    ZERO            TO  FLG-JYOKEN-AND
               PERFORM     1001-SRYKARRK-SQL-EDIT-SEC
               MOVE    1               TO  FLG-JYOKEN
           END-IF
      *
      *    ÉÂÌ¾¥³¡¼¥É
           IF  ( SPA-Q01-GTBL (4)  =   "1" )
               IF    ( SPA-Q01-BYOMEI-JKN  =   "1" )
                 AND ( SPA-Q01-BYOMEI-G    NOT =   SPACE )
                   PERFORM 1001-PTBYOMEI-SQL-AND-EDIT-SEC
               ELSE
                   MOVE    ZERO            TO  FLG-JYOKEN-AND
                   PERFORM 1001-PTBYOMEI-SQL-OR-EDIT-SEC
                   MOVE    1               TO  FLG-JYOKEN
               END-IF
           END-IF
      *
      *    ÊÝ¸±µ­¹æ¡¦ÈÖ¹æ¡¦¸øÈñÊÝ¸±µ­¹æÈÖ¹æ¡¦ÉéÃ´¼ÔÈÖ¹æ
           IF      ((  SPA-Q01-GTBL (5)    =   "1" )
                OR  (  SPA-Q01-GTBL (6)    =   "1" ))
               IF  (   SPA-Q01-GTBL (8)    =   "1" )
                   IF    ( SPA-Q01-KOHNUM-JKN      =   "1" )
                    AND  ( SPA-Q01-KOHNUM-G    NOT =   SPACE )
                       PERFORM 1001-VIEWQ001-SQL-AND-EDIT-SEC
                   ELSE
                       MOVE    ZERO        TO  FLG-JYOKEN-AND
                       PERFORM 1001-VIEWQ001-SQL-OR-EDIT-SEC
                       MOVE    1           TO  FLG-JYOKEN
                   END-IF
               ELSE
                   IF   ( SPA-Q01-GTBL (5)  =   "1" )
                       MOVE    ZERO        TO  FLG-JYOKEN-AND
                       PERFORM 1001-PTHKNINF-SQL-EDIT-SEC
                       MOVE    1           TO  FLG-JYOKEN
                   END-IF
      *
                   IF   ( SPA-Q01-GTBL (6)  =   "1" )
                       IF    ( SPA-Q01-KOHNUM-JKN      =   "1" )
                        AND  ( SPA-Q01-KOHNUM-G    NOT =   SPACE )
                           PERFORM 1001-PTKOHINF-SQL-AND-EDIT-SEC
                       ELSE
                           MOVE    ZERO        TO  FLG-JYOKEN-AND
                           PERFORM 1001-PTKOHINF-SQL-OR-EDIT-SEC
                           MOVE    1           TO  FLG-JYOKEN
                       END-IF
                   END-IF
               END-IF
           END-IF
      *
      *    À¸Ç¯·îÆü¡¦À­ÊÌ¡¦½»½ê¡¦¥³¥á¥ó¥È
           IF   ( SPA-Q01-GTBL (7)  =   "1" )
               MOVE    FLG-JYOKEN      TO  FLG-JYOKEN-AND
               PERFORM     1001-PTINF-SQL-EDIT3-SEC
               MOVE    1               TO  FLG-JYOKEN
           END-IF
      *
      *    ¥Æ¥¹¥È´µ¼Ô¶èÊ¬
           IF    ( SPA-Q01-CHKTSTPT    =   "F" )
               MOVE    FLG-JYOKEN      TO  FLG-JYOKEN-AND
               PERFORM     1001-PTINF-SQL-EDIT4-SEC
               MOVE    1               TO  FLG-JYOKEN
           END-IF
      *
      *    ¿Ç»¡Ç¯·îÆü
           IF   ( SPA-Q01-GTBL (8)  =   "1" )
               IF    ( SPA-Q01-GTBL (4)  =   "1" )
                OR   ( SPA-Q01-GTBL (5)  =   "1" )
                OR   ( SPA-Q01-GTBL (6)  =   "1" )
                OR   ( SPA-Q01-GTBL (9)  =   "1" )
                   CONTINUE
               ELSE
                   MOVE    ZERO            TO  FLG-JYOKEN-AND
                   PERFORM     1001-JYURRK-SQL-EDIT-SEC
                   MOVE    1               TO  FLG-JYOKEN
               END-IF
           END-IF
      *
      *    ¿ÇÎÅ¹Ô°Ù¥³¡¼¥É
           IF   ( SPA-Q01-GTBL (9)  =   "1" )
               IF    ( SPA-Q01-SRYACT-JKN  =   "1" )
                AND  ( SPA-Q01-SRYCD-G NOT =   SPACE )
                   PERFORM     1001-SRYACT-SQL-AND-EDIT-SEC
               ELSE
                   MOVE    ZERO            TO  FLG-JYOKEN-AND
                   PERFORM     1001-SRYACT-SQL-OR-EDIT-SEC
                   MOVE    1               TO  FLG-JYOKEN
               END-IF
           END-IF
      *
      *    ´µ¼ÔÈÖ¹æ
           MOVE    ZERO            TO  FLG-JYOKEN-AND
           PERFORM 1001-PTNUM-SQL-EDIT-SEC
           MOVE    1               TO  FLG-JYOKEN
      *
      *    Áí·ï¿ô¼èÆÀÍÑ¤Ë£Ó£Ñ£ÌÊ¸¤òÂàÈò
           MOVE    WRK-SQL         TO  WRK-SQL-COUNT
      *
      *    ÊÂ¤ÙÂØ¤¨½çÊÔ½¸½èÍý
           PERFORM 1001-ORDER-EDIT-SEC
      *
      *
           .
       100-JYOKEN-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¾È²ñ¥Ó¥å¡¼¾ò·ïÊÔ½¸½èÍý
      *****************************************************************
       1001-VIEWQ001-JYOKEN-EDIT-SEC   SECTION.
      *
           IF    ( SPA-Q01-KOHNUM-JKN      =   "1" )
            AND  ( SPA-Q01-KOHNUM-G    NOT =   SPACE )
               PERFORM VARYING IDX2    FROM    1   BY  1
                       UNTIL ( IDX2    >   5 )
      *
                   IF    ( SPA-Q01-KOHNUM (IDX2)   NOT =   SPACE )
                       MOVE    IDX2    TO  WRK-NAME-SEQ
                       STRING  ",view_Q001 i"      DELIMITED  BY  SIZE
                               WRK-NAME-SEQ        DELIMITED  BY  SIZE
                       INTO    WRK-SQL
                       WITH    POINTER WRK-SQL-PNT
                       END-STRING
                   END-IF
      *
               END-PERFORM
           ELSE
               STRING  ",view_Q001 i"          DELIMITED  BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
           END-IF
      *
           .
       1001-VIEWQ001-JYOKEN-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ´µ¼Ô¸øÈñ¾ðÊó¥Æ¡¼¥Ö¥ë¸¡º÷¾ðÊóÊÔ½¸½èÍý
      *****************************************************************
       1001-PTKOHINF-JYOKEN-EDIT-SEC   SECTION.
      *
           IF    ( SPA-Q01-KOHNUM-JKN      =   "1" )
            AND  ( SPA-Q01-KOHNUM-G    NOT =   SPACE )
               PERFORM VARYING IDX2    FROM    1   BY  1
                       UNTIL ( IDX2    >   5 )
      *
                   IF    (SPA-Q01-KOHNUM (IDX2)    NOT =   SPACE )
                       MOVE    IDX2    TO  WRK-NAME-SEQ
                       STRING  ",tbl_ptkohinf e"   DELIMITED  BY  SIZE
                               WRK-NAME-SEQ        DELIMITED  BY  SIZE
                       INTO    WRK-SQL
                       WITH    POINTER WRK-SQL-PNT
                       END-STRING
                   END-IF
      *
               END-PERFORM
           ELSE
               STRING  ",tbl_ptkohinf e"   DELIMITED  BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
           END-IF
      *
           .
      *
           .
       1001-PTKOHINF-JYOKEN-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ÉÂÌ¾¥Æ¡¼¥Ö¥ë¾ò·ïÊÔ½¸½èÍý
      *****************************************************************
       1001-BYOMEI-JYOKEN-EDIT-SEC     SECTION.
      *
           IF    ( SPA-Q01-BYOMEI-JKN      =   "1" )
             AND ( SPA-Q01-BYOMEI-G    NOT =   SPACE )
               PERFORM VARYING IDX2    FROM    1   BY  1
                       UNTIL ( IDX2    >   5 )
      *
                   IF    (SPA-Q01-BYOMEI (IDX2)   NOT =   SPACE )
                       MOVE    IDX2    TO  WRK-NAME-SEQ
                       STRING  ",tbl_ptbyomei c"   DELIMITED  BY  SIZE
                               WRK-NAME-SEQ        DELIMITED  BY  SIZE
                       INTO    WRK-SQL
                       WITH    POINTER WRK-SQL-PNT
                       END-STRING
                   END-IF
      *
               END-PERFORM
           ELSE
               STRING  ",tbl_ptbyomei c"       DELIMITED  BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
           END-IF
      *
           .
       1001-BYOMEI-JYOKEN-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ¿ÇÎÅ¹Ô°Ù¥Æ¡¼¥Ö¥ë¾ò·ïÊÔ½¸½èÍý
      *****************************************************************
       1001-SRYACT-JYOKEN-EDIT-SEC     SECTION.
      *
           IF    ( SPA-Q01-SRYACT-JKN  =   "1" )
            AND  ( SPA-Q01-SRYCD-G NOT =   SPACE )
               PERFORM VARYING IDX2    FROM    1   BY  1
                       UNTIL ( IDX2    >   5 )
      *
                   IF    (SPA-Q01-SRYCD (IDX2) NOT =   SPACE )
                       IF    ( SPA-Q01-GTBL(8) =   SPACE )
                           MOVE    IDX2    TO  WRK-NAME-SEQ
                           STRING  ",tbl_sryact g" DELIMITED  BY  SIZE
                                   WRK-NAME-SEQ    DELIMITED  BY  SIZE
                           INTO    WRK-SQL
                           WITH    POINTER WRK-SQL-PNT
                           END-STRING
                       ELSE
                           MOVE    IDX2    TO  WRK-NAME-SEQ
                           STRING  ",view_q002 g"  DELIMITED  BY  SIZE
                                   WRK-NAME-SEQ    DELIMITED  BY  SIZE
                           INTO    WRK-SQL
                           WITH    POINTER WRK-SQL-PNT
                           END-STRING
                       END-IF
                   END-IF
      *
               END-PERFORM
           ELSE
               IF    ( SPA-Q01-GTBL(8) =   SPACE )
                   STRING  ",tbl_sryact g"         DELIMITED  BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
               ELSE
                   STRING  ",view_q002 g"          DELIMITED  BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
               END-IF
           END-IF
      *
           .
       1001-SRYACT-JYOKEN-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ´µ¼Ô¥Þ¥¹¥¿¸¡º÷¾ò·ïÊÔ½¸½èÍý£²
      *****************************************************************
       1001-PTINF-SQL-EDIT2-SEC        SECTION.
      *
      *    ¥«¥Ê»áÌ¾¸¡º÷¾ò·ïÊÔ½¸½èÍý
           PERFORM 10011-KANANAME-SELECT-EDIT-SEC
      *
      *    ´Á»ú»áÌ¾¸¡º÷¾ò·ïÊÔ½¸½èÍý
           PERFORM 10011-NAME-SELECT-EDIT-SEC
      *
           .
       1001-PTINF-SQL-EDIT2-EXT.
           EXIT.
      *****************************************************************
      *    ´µ¼Ô¥Þ¥¹¥¿¸¡º÷¾ò·ïÊÔ½¸½èÍý£³
      *****************************************************************
       1001-PTINF-SQL-EDIT3-SEC        SECTION.
      *
      *    À¸Ç¯·îÆü¸¡º÷¾ò·ïÊÔ½¸½èÍý
           PERFORM 10011-BIRTH-SELECT-EDIT-SEC
      *
      *    À­ÊÌ¸¡º÷¾ò·ïÊÔ½¸½èÍý
           PERFORM 10011-SEX-SELECT-EDIT-SEC
      *
      *    ½»½ê¸¡º÷¾ò·ïÊÔ½¸½èÍý
           PERFORM 10011-HOME-ADRS-SELECT-EDIT-SEC
      *
      *    ¥³¥á¥ó¥È¸¡º÷¾ò·ïÊÔ½¸½èÍý
           PERFORM 10011-COMMENT-SELECT-EDIT-SEC
      *
           .
       1001-PTINF-SQL-EDIT3-EXT.
           EXIT.
      *****************************************************************
      *    ´µ¼Ô¥Þ¥¹¥¿¸¡º÷¾ò·ïÊÔ½¸½èÍý£´
      *****************************************************************
       1001-PTINF-SQL-EDIT4-SEC        SECTION.
      *
          MOVE     1               TO  CNT-JYOKEN
      *
          PERFORM  900-SQL-JYOKEN-EDIT2-SEC
      *
          STRING   "(a.tstptnumkbn <> '1')"    DELIMITED   BY  SIZE
          INTO     WRK-SQL
          WITH     POINTER     WRK-SQL-PNT
          END-STRING
      *
          PERFORM  900-SQL-JYOKEN-EDIT3-SEC
           .
       1001-PTINF-SQL-EDIT4-EXT.
           EXIT.
      *****************************************************************
      *    ¿ÇÎÅ²ÊÍúÎò¥Þ¥¹¥¿¸¡º÷¾ò·ïÊÔ½¸½èÍý
      *****************************************************************
       1001-SRYKARRK-SQL-EDIT-SEC      SECTION.
      *
           MOVE    "b"             TO  WRK-SQL-TBL-NAME
           PERFORM 900-SQL-JYOKEN-EDIT1-SEC
      *
           STRING  "((b.lastymd >= '"          DELIMITED   BY  SIZE
                   WRK-STLASTYMD               DELIMITED   BY  SIZE
                   "') and "                   DELIMITED   BY  SIZE
                   "(b.lastymd <= '"           DELIMITED   BY  SIZE
                   WRK-EDLASTYMD               DELIMITED   BY  SIZE
                   "'))"                       DELIMITED   BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER     WRK-SQL-PNT
           END-STRING
      *
           PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
      *
           .
       1001-SRYKARRK-SQL-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ´µ¼ÔÉÂÌ¾¥Þ¥¹¥¿¸¡º÷¾ò·ïÊÔ½¸½èÍý¡ÊOR¡Ë
      *****************************************************************
       1001-PTBYOMEI-SQL-OR-EDIT-SEC       SECTION.
      *
           MOVE    "c"             TO  WRK-SQL-TBL-NAME
           PERFORM 900-SQL-JYOKEN-EDIT1-SEC
      *
           STRING "(((c.sryymd <= '"
                  WRK-EDSRYYMD
                  "') and (c.tenkiymd >= '"
                  WRK-STSRYYMD
                  "')) or "
                  "((c.sryymd <= '"
                  WRK-EDSRYYMD
                  "') and (c.tenkiymd = '        '"
                  "))) and "
           DELIMITED   BY  SIZE
           INTO        WRK-SQL
           WITH POINTER WRK-SQL-PNT
           END-STRING
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
      *
               IF  ( SPA-Q01-BYOMEI (IDX1)   NOT =   SPACE )
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *
      *            ÉÂÌ¾¤Î¹àÌÜÄ¹¤òµá¤á¤ë
                   MOVE    1               TO  WRK-STR-LEN
                   MOVE    SPACE           TO  WRK-STR
                   STRING  SPA-Q01-BYOMEI (IDX1)
                                               DELIMITED   BY  SIZE
                   INTO    WRK-STR
                   WITH POINTER WRK-STR-LEN
                   END-STRING
                   COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *            ÉÂÌ¾¤Î¼ÂºÝ¤ÎÊ¸»úÎóÄ¹¤òµá¤á¤ë
                   MOVE    SPA-Q01-BYOMEI (IDX1)
                                               TO  WRK-STR
                   PERFORM 900-STR-LEN-GET-SEC
                   MOVE    WRK-STR-LEN         TO  WRK-NUM-LEN
      *
                   STRING
                       "(c.byomei like '"      DELIMITED   BY  SIZE
                       SPA-Q01-BYOMEI (IDX1)   DELIMITED   BY  SPACE
                       "%')"                   DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
               END-IF
      *
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
           .
       1001-PTBYOMEI-SQL-OR-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ´µ¼ÔÉÂÌ¾¥Þ¥¹¥¿¸¡º÷¾ò·ïÊÔ½¸½èÍý¡ÊAND¡Ë
      *****************************************************************
       1001-PTBYOMEI-SQL-AND-EDIT-SEC      SECTION.
      *
           PERFORM VARYING IDXA    FROM    1   BY  1
               UNTIL   (   IDXA    >   5 )
      *
               IF    (SPA-Q01-BYOMEI (IDXA)    NOT =   SPACE )
      *
                   MOVE    ZERO            TO  FLG-JYOKEN-AND
      *
                   MOVE    IDXA            TO  WRK-NAME-SEQ
                   MOVE    "c"             TO  WRK-SQL-TBL-NAME
                   MOVE    WRK-NAME-SEQ    TO  WRK-SQL-TBL-NAME (2 : 1)
      *
                   PERFORM 900-SQL-JYOKEN-EDIT1-SEC
      *
                   STRING "((("                    DELIMITED BY SIZE
                          WRK-SQL-TBL-NAME         DELIMITED BY SPACE
                          ".sryymd <= '"           DELIMITED BY SIZE
                          WRK-EDSRYYMD             DELIMITED BY SIZE
                          "') and ("               DELIMITED BY SIZE
                          WRK-SQL-TBL-NAME         DELIMITED BY SPACE
                          ".tenkiymd >= '"         DELIMITED BY SIZE
                          WRK-STSRYYMD             DELIMITED BY SIZE
                          "')) or "                DELIMITED BY SIZE
                          "(("                     DELIMITED BY SIZE
                          WRK-SQL-TBL-NAME         DELIMITED BY SPACE
                          ".sryymd <= '"           DELIMITED BY SIZE
                          WRK-EDSRYYMD             DELIMITED BY SIZE
                          "') and ("               DELIMITED BY SIZE
                          WRK-SQL-TBL-NAME         DELIMITED BY SPACE
                          ".tenkiymd = '        '" DELIMITED BY SIZE
                          "))) and "               DELIMITED BY SIZE
                   INTO        WRK-SQL
                   WITH POINTER WRK-SQL-PNT
                   END-STRING
      *
                   MOVE    1               TO  CNT-JYOKEN
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *
      *            ÉÂÌ¾¤Î¹àÌÜÄ¹¤òµá¤á¤ë
                   MOVE    1               TO  WRK-STR-LEN
                   MOVE    SPACE           TO  WRK-STR
                   STRING  SPA-Q01-BYOMEI (IDXA)
                                               DELIMITED   BY  SIZE
                   INTO    WRK-STR
                   WITH POINTER WRK-STR-LEN
                   END-STRING
      *
                   COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *            ÉÂÌ¾¤Î¼ÂºÝ¤ÎÊ¸»úÎóÄ¹¤òµá¤á¤ë
                   MOVE    SPA-Q01-BYOMEI (IDXA)
                                           TO  WRK-STR
                   PERFORM 900-STR-LEN-GET-SEC
                   MOVE    WRK-STR-LEN     TO  WRK-NUM-LEN
      *
                   STRING
                       "("                     DELIMITED   BY  SIZE
                       WRK-SQL-TBL-NAME        DELIMITED   BY  SPACE
                       ".byomei like '"        DELIMITED   BY  SIZE
                       SPA-Q01-BYOMEI (IDXA)   DELIMITED   BY  SPACE 
                       "%')"                   DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
      *
                   PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
                   PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
                   MOVE    1               TO  FLG-JYOKEN
      *
               END-IF
      *
           END-PERFORM
      *
           .
       1001-PTBYOMEI-SQL-AND-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ¾È²ñ¥Ó¥å¡¼¸¡º÷¾ò·ïÊÔ½¸½èÍý(AND)
      *****************************************************************
       1001-VIEWQ001-SQL-AND-EDIT-SEC  SECTION.
      *
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
      *
               IF    (SPA-Q01-KOHNUM (IDXA) NOT =   SPACE )
                   MOVE    ZERO            TO  FLG-JYOKEN-AND
      *
                   MOVE    IDXA            TO  WRK-NAME-SEQ
                   MOVE    "i"             TO  WRK-SQL-TBL-NAME
                   MOVE    WRK-NAME-SEQ    TO  WRK-SQL-TBL-NAME (2 : 1)
      *
                   PERFORM 900-SQL-JYOKEN-EDIT1-SEC
      *
                   STRING "(("             DELIMITED   BY  SIZE
                      WRK-SQL-TBL-NAME     DELIMITED   BY  SPACE
                      ".sryymd <= '"       DELIMITED   BY  SIZE
                      WRK-EDSRYYMD         DELIMITED   BY  SIZE
                      "') and ("           DELIMITED   BY  SIZE
                      WRK-SQL-TBL-NAME     DELIMITED   BY  SPACE
                      ".sryymd >= '"       DELIMITED   BY  SIZE
                      WRK-STSRYYMD         DELIMITED   BY  SIZE
                      "')) and"            DELIMITED   BY  SIZE
                   INTO        WRK-SQL
                   WITH POINTER WRK-SQL-PNT
                   END-STRING
      *
                   IF   ( SPA-Q01-GTBL (6)  =   "1" )
      *                ´µ¼Ô¸øÈñ¾ðÊó£Ó£Ñ£ÌÊÔ½¸½èÍý
                       MOVE    SPA-Q01-KOHNUM (IDXA)
                                           TO  WRK-KOHNUM
                       MOVE    SPA-Q01-PAYKBN (IDXA)
                                           TO  WRK-PAYKBN
                       PERFORM 10012-PTKOHINF-KOHNUM-EDIT-SEC
                   END-IF
      *
                   PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
                   MOVE    1               TO  FLG-JYOKEN
      *
               END-IF
      *
           END-PERFORM
      *
      *    ¸øÈñÉéÃ´¼ÔÈÖ¹æ£Ó£Ñ£ÌÊÔ½¸½èÍý
           IF    ( SPA-Q01-FTNJANUM-G      NOT =   SPACE )
               MOVE    ZERO            TO  FLG-JYOKEN-OR
      *
               PERFORM 900-SQL-JYOKEN-EDIT5-SEC
      *
               PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
      *
                   IF    (SPA-Q01-KOHNUM (IDXA) NOT =   SPACE )
                       MOVE    ZERO    TO  FLG-JYOKEN-AND
      *
                       MOVE    IDXA        TO  WRK-NAME-SEQ
                       MOVE    "i"         TO  WRK-SQL-TBL-NAME
                       MOVE    WRK-NAME-SEQ
                                           TO  WRK-SQL-TBL-NAME (2 : 1)
      *
                       PERFORM 900-SQL-JYOKEN-EDIT6-SEC
                       PERFORM 10011-PTKOHINF-FTNNUM-EDIT-SEC
                       PERFORM 900-SQL-JYOKEN-EDIT4-SEC
                   END-IF
      *
               END-PERFORM
      *
               PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
               MOVE    1               TO  FLG-JYOKEN
           END-IF
      *
      *    ´µ¼ÔÊÝ¸±¾ðÊó£Ó£Ñ£ÌÊÔ½¸½èÍý
           IF   ( SPA-Q01-GTBL (5)  =   "1" )
      *
               MOVE    ZERO            TO  FLG-JYOKEN-OR
      *
               PERFORM 900-SQL-JYOKEN-EDIT5-SEC
      *
               PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
      *
                   IF    (SPA-Q01-KOHNUM (IDXA) NOT =   SPACE )
                       MOVE    ZERO        TO  FLG-JYOKEN-AND
      *
                       MOVE    IDXA        TO  WRK-NAME-SEQ
                       MOVE    "i"         TO  WRK-SQL-TBL-NAME
                       MOVE    WRK-NAME-SEQ
                                           TO  WRK-SQL-TBL-NAME (2 : 1)
      *
                       PERFORM 900-SQL-JYOKEN-EDIT6-SEC
                       PERFORM 10011-PTHKNINF-SQL-EDIT-SEC
                       PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
                   END-IF
      *
               END-PERFORM
      *
               PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
               MOVE    1               TO  FLG-JYOKEN
      *
           END-IF
      *
           .
       1001-VIEWQ001-SQL-AND-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¾È²ñ¥Ó¥å¡¼¸¡º÷¾ò·ïÊÔ½¸½èÍý(OR)
      *****************************************************************
       1001-VIEWQ001-SQL-OR-EDIT-SEC   SECTION.
      *
           MOVE    "i"                 TO  WRK-SQL-TBL-NAME
      *
           PERFORM 900-SQL-JYOKEN-EDIT1-SEC
      *
           STRING "((i.sryymd <= '"
                      WRK-EDSRYYMD
                      "') and (i.sryymd >= '"
                      WRK-STSRYYMD
                      "')) and"
           DELIMITED   BY  SIZE
           INTO        WRK-SQL
           WITH POINTER WRK-SQL-PNT
           END-STRING
      *
           IF   ( SPA-Q01-GTBL (5)  =   "1" )
      *        ´µ¼ÔÊÝ¸±¾ðÊó£Ó£Ñ£ÌÊÔ½¸½èÍý
               PERFORM 10011-PTHKNINF-SQL-EDIT-SEC
           END-IF
      *
           IF   ( SPA-Q01-GTBL (6)  =   "1" )
      *        ´µ¼Ô¸øÈñ¾ðÊó£Ó£Ñ£ÌÊÔ½¸½èÍý
               PERFORM 10011-PTKOHINF-KOHNUM-EDIT-SEC
               PERFORM 10011-PTKOHINF-FTNNUM-EDIT-SEC
           END-IF
      *
      *
           PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
           .
       1001-VIEWQ001-SQL-OR-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ÊÝ¸±¾ðÊó£Ó£Ñ£ÌÊÔ½¸½èÍý
      *****************************************************************
       10011-PTHKNINF-SQL-EDIT-SEC     SECTION.
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
      *
               IF  ( SPA-Q01-HKNJANUM (IDX1)
                                           NOT =   SPACE )
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *
      *            ÊÝ¸±¼ÔÈÖ¹æ¤Î¹àÌÜÄ¹¤òµá¤á¤ë
                   MOVE    1               TO  WRK-STR-LEN
                   MOVE    SPACE           TO  WRK-STR
                   STRING  SPA-Q01-HKNJANUM (IDX1) 
                                           DELIMITED   BY  SIZE
                   INTO    WRK-STR
                   WITH POINTER WRK-STR-LEN
                   END-STRING
                   COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *            ÊÝ¸±¼ÔÈÖ¹æ¤Î¼ÂºÝ¤ÎÊ¸»úÎóÄ¹¤òµá¤á¤ë
                   MOVE    SPA-Q01-HKNJANUM (IDX1) TO  WRK-STR
                   PERFORM 900-STR-LEN-GET-SEC
                   MOVE    WRK-STR-LEN             TO  WRK-KIGO-LEN
      *
                   STRING  "("             DELIMITED   BY  SIZE
                       WRK-SQL-TBL-NAME    DELIMITED   BY  SPACE
                       ".hknjanum ='"      DELIMITED   BY  SIZE
                       SPA-Q01-HKNJANUM (IDX1)(1: WRK-KIGO-LEN)
                                           DELIMITED   BY  SIZE
                       "')"                DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
               END-IF
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           IF      ( SPA-Q01-HONKZKKBN NOT =   SPACE )
      *
               MOVE    1                   TO  CNT-JYOKEN
      *
               PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
               STRING  "("
                       WRK-SQL-TBL-NAME        DELIMITED   BY  SPACE
                       ".honkzkkbn = '"        DELIMITED   BY  SIZE
                       SPA-Q01-HONKZKKBN       DELIMITED   BY  SIZE
                       "')"                    DELIMITED   BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
      *
               PERFORM 900-SQL-JYOKEN-EDIT3-SEC
           END-IF
      *
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
      *
               IF  ( SPA-Q01-HKNNUM (IDX1) NOT =   SPACE )
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
                   STRING  "("             DELIMITED   BY  SIZE
                       WRK-SQL-TBL-NAME    DELIMITED   BY  SPACE
                       ".hknnum ='"        DELIMITED   BY  SIZE
                       SPA-Q01-HKNNUM (IDX1)
                                           DELIMITED   BY  SIZE
                       "')"                DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
               END-IF
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
      *
               IF      ( SPA-Q01-KIGO (IDX1)   NOT =   SPACE )
                OR     ( SPA-Q01-NUM  (IDX1)   NOT =   SPACE )
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
                   STRING  "("           DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
      *
                   IF  ( SPA-Q01-KIGO (IDX1)   NOT =   SPACE )
      *                µ­¹æ¤Î¹àÌÜÄ¹¤òµá¤á¤ë
                       MOVE    1               TO  WRK-STR-LEN
                       MOVE    SPACE           TO  WRK-STR
                       STRING  SPA-Q01-KIGO (IDX1) DELIMITED   BY  SIZE
                       INTO    WRK-STR
                       WITH POINTER WRK-STR-LEN
                       END-STRING
                       COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *                µ­¹æ¤Î¼ÂºÝ¤ÎÊ¸»úÎóÄ¹¤òµá¤á¤ë
                       MOVE    SPA-Q01-KIGO (IDX1) TO  WRK-STR
                       PERFORM 900-STR-LEN-GET-SEC
                       MOVE    WRK-STR-LEN         TO  WRK-KIGO-LEN
      *
                       STRING  "("                 DELIMITED   BY  SIZE
                           WRK-SQL-TBL-NAME        DELIMITED   BY  SPACE
                           ".kigo like '"          DELIMITED   BY  SIZE
                           SPA-Q01-KIGO (IDX1)(1: WRK-KIGO-LEN)
                                                   DELIMITED   BY  SIZE
                           "%')"                   DELIMITED   BY  SIZE
                       INTO    WRK-SQL
                       WITH    POINTER WRK-SQL-PNT
                       END-STRING
                       IF  ( SPA-Q01-NUM  (IDX1)   NOT =   SPACE )
                           STRING  "and"           DELIMITED   BY  SIZE
                           INTO    WRK-SQL
                           WITH    POINTER WRK-SQL-PNT
                           END-STRING
                       END-IF
                   END-IF
      *
                   IF  ( SPA-Q01-NUM  (IDX1)   NOT =   SPACE )
      *                ÈÖ¹æ¤Î¹àÌÜÄ¹¤òµá¤á¤ë
                       MOVE    1               TO  WRK-STR-LEN
                       MOVE    SPACE           TO  WRK-STR
                       STRING  SPA-Q01-KIGO (IDX1) DELIMITED   BY  SIZE
                       INTO    WRK-STR
                       WITH POINTER WRK-STR-LEN
                       END-STRING
                       COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *                ÈÖ¹æ¤Î¼ÂºÝ¤ÎÊ¸»úÎóÄ¹¤òµá¤á¤ë
                       MOVE    SPA-Q01-NUM (IDX1) TO  WRK-STR
                       PERFORM 900-STR-LEN-GET-SEC
                       MOVE    WRK-STR-LEN         TO  WRK-NUM-LEN
      *
                       STRING  "("                 DELIMITED   BY  SIZE
                           WRK-SQL-TBL-NAME        DELIMITED   BY  SPACE
                               ".num like '"       DELIMITED   BY  SIZE
                               SPA-Q01-NUM  (IDX1)(1: WRK-NUM-LEN)
                                                   DELIMITED   BY  SIZE
                               "%')"               DELIMITED   BY  SIZE
                       INTO    WRK-SQL
                       WITH    POINTER WRK-SQL-PNT
                       END-STRING
                   END-IF
      *
                   STRING  ")"                     DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
      *
               END-IF
      *
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           .
       10011-PTHKNINF-SQL-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ´µ¼Ô¸øÈñ¥Þ¥¹¥¿¡Ê¸øÈñ¤Î¼ïÎà¡Ë¸¡º÷¾ò·ïÊÔ½¸½èÍý
      *    ¡ÊOR¾ò·ïÍÑ¡Ë
      *****************************************************************
       10011-PTKOHINF-KOHNUM-EDIT-SEC  SECTION.
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
      *
               IF  ( SPA-Q01-KOHNUM (IDX1) NOT =   SPACE )
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *            ÊÝ¸±ÈÖ¹æ¤Î¹àÌÜÄ¹¤òµá¤á¤ë
                   MOVE    1               TO  WRK-STR-LEN
                   MOVE    SPACE           TO  WRK-STR
                   STRING  SPA-Q01-KOHNUM (IDX1) 
                                           DELIMITED   BY  SIZE
                   INTO    WRK-STR
                   WITH POINTER WRK-STR-LEN
                   END-STRING
                   COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *            ÊÝ¸±ÈÖ¹æ¤Î¼ÂºÝ¤ÎÊ¸»úÎóÄ¹¤òµá¤á¤ë
                   MOVE    SPA-Q01-KOHNUM (IDX1)   TO  WRK-STR
                   PERFORM 900-STR-LEN-GET-SEC
                   MOVE    WRK-STR-LEN             TO  WRK-KIGO-LEN
      *
                   IF    ( SPA-Q01-KOHNUM (IDX1)   =   "027" )
                    AND  ( SPA-Q01-PAYKBN (IDX1)   =   "01" OR "02" )
                       STRING  "(("            DELIMITED   BY  SIZE
                           WRK-SQL-TBL-NAME    DELIMITED   BY  SPACE
                           ".kohnum ='"        DELIMITED   BY  SIZE
                           SPA-Q01-KOHNUM (IDX1)(1: WRK-KIGO-LEN)
                                               DELIMITED   BY  SIZE
                           "')and("            DELIMITED   BY  SIZE
                           WRK-SQL-TBL-NAME    DELIMITED   BY  SPACE
                           ".paykbn ='"        DELIMITED   BY  SIZE
                           SPA-Q01-PAYKBN (IDX1)
                                               DELIMITED   BY  SIZE
                           "'))"               DELIMITED   BY  SIZE
                       INTO    WRK-SQL
                       WITH    POINTER WRK-SQL-PNT
                       END-STRING
                   ELSE
                       STRING  "("             DELIMITED   BY  SIZE
                           WRK-SQL-TBL-NAME    DELIMITED   BY  SPACE
                           ".kohnum ='"        DELIMITED   BY  SIZE
                           SPA-Q01-KOHNUM (IDX1)(1: WRK-KIGO-LEN)
                                               DELIMITED   BY  SIZE
                           "')"                DELIMITED   BY  SIZE
                       INTO    WRK-SQL
                       WITH    POINTER WRK-SQL-PNT
                       END-STRING
                   END-IF
               END-IF
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           .
       10011-PTKOHINF-KOHNUM-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ´µ¼Ô¸øÈñ¥Þ¥¹¥¿¡Ê¸øÈñ¤Î¼ïÎà¡Ë¸¡º÷¾ò·ïÊÔ½¸½èÍý
      *    ¡ÊAND¾ò·ïÍÑ¡Ë
      *****************************************************************
       10012-PTKOHINF-KOHNUM-EDIT-SEC  SECTION.
      *
           MOVE    1               TO  CNT-JYOKEN
      *
           PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *    ÊÝ¸±ÈÖ¹æ¤Î¹àÌÜÄ¹¤òµá¤á¤ë
           MOVE    1               TO  WRK-STR-LEN
           MOVE    SPACE           TO  WRK-STR
           STRING  WRK-KOHNUM
                                           DELIMITED   BY  SIZE
           INTO    WRK-STR
           WITH POINTER WRK-STR-LEN
           END-STRING
           COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *    ÊÝ¸±ÈÖ¹æ¤Î¼ÂºÝ¤ÎÊ¸»úÎóÄ¹¤òµá¤á¤ë
           MOVE    WRK-KOHNUM      TO  WRK-STR
           PERFORM 900-STR-LEN-GET-SEC
           MOVE    WRK-STR-LEN             TO  WRK-KIGO-LEN
      *
           IF    ( WRK-KOHNUM          =   "027" )
            AND  ( WRK-PAYKBN          =   "01" OR "02" )
               STRING  "(("            DELIMITED   BY  SIZE
                   WRK-SQL-TBL-NAME    DELIMITED   BY  SPACE
                   ".kohnum ='"        DELIMITED   BY  SIZE
                   WRK-KOHNUM (1: WRK-KIGO-LEN)
                                       DELIMITED   BY  SIZE
                   "')and("            DELIMITED   BY  SIZE
                   WRK-SQL-TBL-NAME    DELIMITED   BY  SPACE
                   ".paykbn ='"        DELIMITED   BY  SIZE
                   WRK-PAYKBN          DELIMITED   BY  SIZE
                   "'))"               DELIMITED   BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
           ELSE
               STRING  "("             DELIMITED   BY  SIZE
                   WRK-SQL-TBL-NAME    DELIMITED   BY  SPACE
                   ".kohnum ='"        DELIMITED   BY  SIZE
                   WRK-KOHNUM (1: WRK-KIGO-LEN)
                                       DELIMITED   BY  SIZE
                   "')"                DELIMITED   BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
           END-IF
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           .
       10012-PTKOHINF-KOHNUM-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ´µ¼Ô¸øÈñ¥Þ¥¹¥¿¡Ê¸øÈñ¤Î¼ïÎà¡Ë¸¡º÷¾ò·ïÊÔ½¸½èÍý
      *****************************************************************
       10011-PTKOHINF-FTNNUM-EDIT-SEC  SECTION.
      *
           MOVE    ZERO    TO      CNT-JYOKEN
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
      *
               IF  ( SPA-Q01-FTNJANUM  (IDX1)  NOT =   SPACE )
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *            ÉéÃ´¼ÔÈÖ¹æ¤Î¹àÌÜÄ¹¤òµá¤á¤ë
                   MOVE    1               TO  WRK-STR-LEN
                   MOVE    SPACE           TO  WRK-STR
                   STRING  SPA-Q01-FTNJANUM (IDX1)
                                               DELIMITED   BY  SIZE
                   INTO    WRK-STR
                   WITH POINTER WRK-STR-LEN
                   END-STRING
                   COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *            ÉéÃ´¼ÔÈÖ¹æ¤Î¼ÂºÝ¤ÎÊ¸»úÎóÄ¹¤òµá¤á¤ë
                   MOVE    SPA-Q01-FTNJANUM (IDX1) TO  WRK-STR
                   PERFORM 900-STR-LEN-GET-SEC
                   MOVE    WRK-STR-LEN         TO  WRK-NUM-LEN
      *
                   STRING  "("                 DELIMITED   BY  SIZE
                           WRK-SQL-TBL-NAME    DELIMITED   BY  SPACE
                           ".ftnjanum like '"
                                               DELIMITED   BY  SIZE
                           SPA-Q01-FTNJANUM  (IDX1)(1: WRK-NUM-LEN)
                                               DELIMITED   BY  SIZE
                           "%')"               DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
      *
               END-IF
      *
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
      *
           .
       10011-PTKOHINF-FTNNUM-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ´µ¼ÔÊÝ¸±¥Þ¥¹¥¿¸¡º÷¾ò·ïÊÔ½¸½èÍý
      *****************************************************************
       1001-PTHKNINF-SQL-EDIT-SEC      SECTION.
      *
           MOVE    "d"             TO  WRK-SQL-TBL-NAME
      *
           PERFORM 900-SQL-JYOKEN-EDIT1-SEC
      *
      *    ÊÝ¸±¾ðÊó£Ó£Ñ£ÌÊÔ½¸½èÍý
           PERFORM 10011-PTHKNINF-SQL-EDIT-SEC
      *
           STRING "and (d.sakjokbn = ' ')  "
           DELIMITED   BY  SIZE
           INTO        WRK-SQL
           WITH POINTER WRK-SQL-PNT
           END-STRING
      *
           PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
           .
       1001-PTHKNINF-SQL-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ´µ¼Ô¸øÈñ¥Þ¥¹¥¿¸¡º÷¾ò·ïÊÔ½¸½èÍý(OR)
      *****************************************************************
       1001-PTKOHINF-SQL-OR-EDIT-SEC   SECTION.
      *
           MOVE    "e"                 TO  WRK-SQL-TBL-NAME
      *
           PERFORM 900-SQL-JYOKEN-EDIT1-SEC
      *
      *    ¸øÈñ¾ðÊó£Ó£Ñ£ÌÊÔ½¸½èÍý
           PERFORM 10011-PTKOHINF-KOHNUM-EDIT-SEC
           PERFORM 10011-PTKOHINF-FTNNUM-EDIT-SEC
      *
           STRING "and (e.sakjokbn = ' ')  "
           DELIMITED   BY  SIZE
           INTO        WRK-SQL
           WITH POINTER WRK-SQL-PNT
           END-STRING
      *
           PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
           .
       1001-PTKOHINF-SQL-OR-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ´µ¼Ô¸øÈñ¥Þ¥¹¥¿¸¡º÷¾ò·ïÊÔ½¸½èÍý(AND)
      *****************************************************************
       1001-PTKOHINF-SQL-AND-EDIT-SEC   SECTION.
      *
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
      *
               IF    (SPA-Q01-KOHNUM (IDXA) NOT =   SPACE )
                   MOVE    ZERO            TO  FLG-JYOKEN-AND
      *
                   MOVE    IDXA            TO  WRK-NAME-SEQ
                   MOVE    "e"             TO  WRK-SQL-TBL-NAME
                   MOVE    WRK-NAME-SEQ    TO  WRK-SQL-TBL-NAME (2 : 1)
      *
                   PERFORM 900-SQL-JYOKEN-EDIT1-SEC
      *
      *            ´µ¼Ô¸øÈñ¾ðÊó£Ó£Ñ£ÌÊÔ½¸½èÍý
                   MOVE    SPA-Q01-KOHNUM (IDXA)
                                           TO  WRK-KOHNUM
                   MOVE    SPA-Q01-PAYKBN (IDXA)
                                           TO  WRK-PAYKBN
                   PERFORM 10012-PTKOHINF-KOHNUM-EDIT-SEC
      *
                   PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
                   MOVE    1               TO  FLG-JYOKEN
      *
               END-IF
      *
           END-PERFORM
      *
           IF    ( SPA-Q01-FTNJANUM-G      NOT =   SPACE )
               MOVE    ZERO                TO  FLG-JYOKEN-OR
      *
               PERFORM 900-SQL-JYOKEN-EDIT5-SEC
      *
               PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
      *
                   IF    (SPA-Q01-KOHNUM (IDXA) NOT =   SPACE )
      *
                       MOVE    ZERO        TO  FLG-JYOKEN-AND
      *
                       MOVE    IDXA        TO  WRK-NAME-SEQ
                       MOVE    "e"         TO  WRK-SQL-TBL-NAME
                       MOVE    WRK-NAME-SEQ
                                           TO  WRK-SQL-TBL-NAME (2 : 1)
      *
                       PERFORM 900-SQL-JYOKEN-EDIT6-SEC
                       PERFORM 10011-PTKOHINF-FTNNUM-EDIT-SEC
                       PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
                   END-IF
      *
               END-PERFORM
      *
               PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
               MOVE    1               TO  FLG-JYOKEN
           END-IF
      *
           PERFORM 900-SQL-JYOKEN-EDIT5-SEC
      *
           MOVE    ZERO                TO  FLG-JYOKEN-AND
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
      *
               IF    (SPA-Q01-KOHNUM (IDXA) NOT =   SPACE )
      *
                   MOVE    IDXA        TO  WRK-NAME-SEQ
                   MOVE    "e"         TO  WRK-SQL-TBL-NAME
                   MOVE    WRK-NAME-SEQ
                                       TO  WRK-SQL-TBL-NAME (2 : 1)
      *
                   MOVE    1           TO  CNT-JYOKEN
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
                   STRING  "("                 DELIMITED   BY  SIZE
                           WRK-SQL-TBL-NAME    DELIMITED   BY  SPACE
                           ".sakjokbn = ' ')"  DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH POINTER WRK-SQL-PNT
                   END-STRING
      *
                   PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
               END-IF
      *
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
           .
       1001-PTKOHINF-SQL-AND-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ¼õ¿ÇÍúÎò¥Þ¥¹¥¿¸¡º÷¾ò·ïÊÔ½¸½èÍý
      *****************************************************************
       1001-JYURRK-SQL-EDIT-SEC        SECTION.
      *
      *
           MOVE    "f"             TO  WRK-SQL-TBL-NAME
           PERFORM 900-SQL-JYOKEN-EDIT1-SEC
      *
      *
      *    ºÇ½ª¼õ¿ÇÆü¸¡º÷¾ò·ïÊÔ½¸
           STRING  "(f.sryymd >= '"            DELIMITED   BY  SIZE
                   WRK-STSRYYMD                DELIMITED   BY  SIZE
                   "') and (f.sryymd <= '"     DELIMITED   BY  SIZE
                   WRK-EDSRYYMD                DELIMITED   BY  SIZE
                   "')"                        DELIMITED   BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER     WRK-SQL-PNT
           END-STRING
      *
           PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
           .
       1001-JYURRK-SQL-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ¿ÇÎÅ¹Ô°Ù¥Þ¥¹¥¿¸¡º÷¾ò·ïÊÔ½¸½èÍý¡ÊOR¡Ë
      *****************************************************************
       1001-SRYACT-SQL-OR-EDIT-SEC     SECTION.
      *
           MOVE    "g"             TO  WRK-SQL-TBL-NAME
           PERFORM 900-SQL-JYOKEN-EDIT1-SEC
      *
           IF    ( SPA-Q01-GTBL(8) =   SPACE )
               STRING "((g.sryym  <= '"
                      WRK-EDSRYYMD (1 : 6)
                      "') and (g.sryym >= '"
                      WRK-STSRYYMD (1 : 6) 
                      "')) and"
               DELIMITED   BY  SIZE
               INTO        WRK-SQL
               WITH POINTER WRK-SQL-PNT
               END-STRING
           ELSE
               STRING "((g.sryymd <= '"
                      WRK-EDSRYYMD
                      "') and (g.sryymd >= '"
                      WRK-STSRYYMD
                      "')) and"
               DELIMITED   BY  SIZE
               INTO        WRK-SQL
               WITH POINTER WRK-SQL-PNT
               END-STRING
           END-IF
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
      *
               IF      ( SPA-Q01-SRYCD     (IDX1)  NOT =   SPACE )
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
                   STRING  "(g.srycd1 = '"         DELIMITED   BY  SIZE
                           SPA-Q01-SRYCD (IDX1)    DELIMITED   BY  SIZE
                           "') or"                 DELIMITED   BY  SIZE
                           "(g.srycd2 = '"         DELIMITED   BY  SIZE
                           SPA-Q01-SRYCD (IDX1)    DELIMITED   BY  SIZE
                           "') or"                 DELIMITED   BY  SIZE
                           "(g.srycd3 = '"         DELIMITED   BY  SIZE
                           SPA-Q01-SRYCD (IDX1)    DELIMITED   BY  SIZE
                           "') or"                 DELIMITED   BY  SIZE
                           "(g.srycd4 = '"         DELIMITED   BY  SIZE
                           SPA-Q01-SRYCD (IDX1)    DELIMITED   BY  SIZE
                           "') or"                 DELIMITED   BY  SIZE
                           "(g.srycd5 = '"         DELIMITED   BY  SIZE
                           SPA-Q01-SRYCD (IDX1)    DELIMITED   BY  SIZE
                           "')"                    DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
      *
               END-IF
      *
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
           .
       1001-SRYACT-SQL-OR-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ¿ÇÎÅ¹Ô°Ù¥Þ¥¹¥¿¸¡º÷¾ò·ïÊÔ½¸½èÍý¡ÊAND¡Ë
      *****************************************************************
       1001-SRYACT-SQL-AND-EDIT-SEC    SECTION.
      *
           PERFORM VARYING IDXA    FROM    1   BY  1
               UNTIL   (   IDXA    >   5 )
      *
               IF      ( SPA-Q01-SRYCD     (IDXA)  NOT =   SPACE )
      *
                   MOVE    ZERO            TO  FLG-JYOKEN-AND
      *
                   MOVE    IDXA            TO  WRK-NAME-SEQ
                   MOVE    "g"             TO  WRK-SQL-TBL-NAME
                   MOVE    WRK-NAME-SEQ    TO  WRK-SQL-TBL-NAME (2 : 1)
                   PERFORM 900-SQL-JYOKEN-EDIT1-SEC
      *
                   IF    ( SPA-Q01-GTBL(8) =   SPACE )
                       STRING "(("                 DELIMITED BY SIZE
                              WRK-SQL-TBL-NAME     DELIMITED BY SPACE
                              ".sryym  <= '"       DELIMITED BY SIZE
                              WRK-EDSRYYMD (1 : 6) DELIMITED BY SIZE
                              "') and ("           DELIMITED BY SIZE
                              WRK-SQL-TBL-NAME     DELIMITED BY SPACE
                              ".sryym  >= '"       DELIMITED BY SIZE
                              WRK-STSRYYMD (1 : 6) DELIMITED BY SIZE
                              "')) and"            DELIMITED BY SIZE
                       INTO   WRK-SQL
                       WITH POINTER WRK-SQL-PNT
                       END-STRING
                   ELSE
                       STRING "(("                 DELIMITED BY SIZE
                              WRK-SQL-TBL-NAME     DELIMITED BY SPACE
                              ".sryymd <= '"       DELIMITED BY SIZE
                              WRK-EDSRYYMD         DELIMITED BY SIZE
                              "') and ("           DELIMITED BY SIZE
                              WRK-SQL-TBL-NAME     DELIMITED BY SPACE
                              ".sryymd >= '"       DELIMITED BY SIZE
                              WRK-STSRYYMD         DELIMITED BY SIZE
                              "')) and"            DELIMITED BY SIZE
                       INTO   WRK-SQL
                       WITH POINTER WRK-SQL-PNT
                       END-STRING
                   END-IF
      *
                   MOVE    1               TO      CNT-JYOKEN
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
                   STRING  "("                     DELIMITED BY SIZE
                           WRK-SQL-TBL-NAME        DELIMITED BY SPACE
                           ".srycd1 = '"           DELIMITED BY SIZE
                           SPA-Q01-SRYCD (IDXA)    DELIMITED BY SIZE
                           "') or"                 DELIMITED BY SIZE
                           "("                     DELIMITED BY SIZE
                           WRK-SQL-TBL-NAME        DELIMITED BY SPACE
                           ".srycd2 = '"           DELIMITED BY SIZE
                           SPA-Q01-SRYCD (IDXA)    DELIMITED BY SIZE
                           "') or"                 DELIMITED BY SIZE
                           "("                     DELIMITED BY SIZE
                           WRK-SQL-TBL-NAME        DELIMITED BY SPACE
                           ".srycd3 = '"           DELIMITED BY SIZE
                           SPA-Q01-SRYCD (IDXA)    DELIMITED BY SIZE
                           "') or"                 DELIMITED BY SIZE
                           "("                     DELIMITED BY SIZE
                           WRK-SQL-TBL-NAME        DELIMITED BY SPACE
                           ".srycd4 = '"           DELIMITED BY SIZE
                           SPA-Q01-SRYCD (IDXA)    DELIMITED BY SIZE
                           "') or"                 DELIMITED BY SIZE
                           "("                     DELIMITED BY SIZE
                           WRK-SQL-TBL-NAME        DELIMITED BY SPACE
                           ".srycd5 = '"           DELIMITED BY SIZE
                           SPA-Q01-SRYCD (IDXA)    DELIMITED BY SIZE
                           "')"                    DELIMITED BY SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
      *
                   PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
                   PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
                   MOVE    1               TO  FLG-JYOKEN
      *
               END-IF
      *
           END-PERFORM
      *
           .
       1001-SRYACT-SQL-AND-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ´µ¼ÔÈÖ¹æ¥Þ¥¹¥¿¸¡º÷¾ò·ïÊÔ½¸½èÍý
      *****************************************************************
       1001-PTNUM-SQL-EDIT-SEC         SECTION.
      *
           IF  ( FLG-JYOKEN        =   1 )
               STRING " and "      DELIMITED   BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER     WRK-SQL-PNT
               END-STRING
           END-IF
      *
           STRING  "((h.hospid='"              DELIMITED   BY  SIZE
                   SPA-HOSPID                  DELIMITED   BY  SIZE
                   "')and("                    DELIMITED   BY  SIZE
                   "h.ptid=a.ptid) "           DELIMITED   BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER     WRK-SQL-PNT
           END-STRING
      *
           IF  ( SPA-Q01-GTBL (1)  =   "1" )
               STRING  "and (h.ptnum>='"   DELIMITED  BY  SIZE
                       SPA-Q01-STPTNUM     DELIMITED  BY  SIZE
                       "') and "           DELIMITED  BY  SIZE
                       "(h.ptnum<='"       DELIMITED  BY  SIZE
                       WRK-EDPTNUM         DELIMITED  BY  SIZE
                       "')"                DELIMITED  BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
           END-IF
      *
           STRING  ")"         DELIMITED   BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER     WRK-SQL-PNT
           END-STRING
      *
           .
       1001-PTNUM-SQL-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ¥«¥Ê»áÌ¾¸¡º÷¾ò·ïÊÔ½¸½èÍý
      *****************************************************************
       10011-KANANAME-SELECT-EDIT-SEC       SECTION.
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
               IF  ( SPA-Q01-KANANAME (IDX1)   NOT =   SPACE)
      *
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *            ¥«¥Ê»áÌ¾¤Î¹àÌÜÄ¹¤òµá¤á¤ë
                   MOVE    1               TO  WRK-STR-LEN
                   MOVE    SPACE           TO  WRK-STR
                   STRING  SPA-Q01-KANANAME (IDX1) DELIMITED   BY  SIZE
                   INTO    WRK-STR
                   WITH POINTER WRK-STR-LEN
                   END-STRING
                   COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *            ¥«¥Ê»áÌ¾¤Î¼ÂºÝ¤ÎÊ¸»úÎóÄ¹¤òµá¤á¤ë
                   MOVE    SPA-Q01-KANANAME (IDX1)   TO  WRK-STR
                   PERFORM 900-STR-LEN-GET-SEC
      *
                   STRING  "(a.kananame like '"    DELIMITED   BY  SIZE
                           SPA-Q01-KANANAME (IDX1)(1: WRK-STR-LEN) 
                                                   DELIMITED   BY  SIZE
                           "%')"                   DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
      *
               END-IF
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           .
       10011-KANANAME-SELECT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ´Á»ú»áÌ¾¸¡º÷¾ò·ïÊÔ½¸½èÍý
      *****************************************************************
       10011-NAME-SELECT-EDIT-SEC           SECTION.
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
               IF  ( SPA-Q01-NAME (IDX1)   NOT =   SPACE)
      *
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *            ¥«¥Ê»áÌ¾¤Î¹àÌÜÄ¹¤òµá¤á¤ë
                   MOVE    1               TO  WRK-STR-LEN
                   MOVE    SPACE           TO  WRK-STR
                   STRING  SPA-Q01-NAME (IDX1)   DELIMITED   BY  SIZE
                   INTO    WRK-STR
                   WITH POINTER WRK-STR-LEN
                   END-STRING
                   COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *            ¥«¥Ê»áÌ¾¤Î¼ÂºÝ¤ÎÊ¸»úÎóÄ¹¤òµá¤á¤ë
                   MOVE    SPA-Q01-NAME (IDX1)   TO  WRK-STR
                   PERFORM 900-STR-LEN-GET-SEC
      *
                   STRING  "(a.name like '"        DELIMITED   BY  SIZE
                           SPA-Q01-NAME (IDX1)(1: WRK-STR-LEN) 
                                                   DELIMITED   BY  SIZE
                           "%')"                   DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
      *
               END-IF
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           .
       10011-NAME-SELECT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    À¸Ç¯·îÆü¸¡º÷¾ò·ïÊÔ½¸½èÍý
      *****************************************************************
       10011-BIRTH-SELECT-EDIT-SEC          SECTION.
      *
           IF      ( SPA-Q01-STBIRTHDAY    =   SPACE )
            AND    ( SPA-Q01-EDBIRTHDAY    =   SPACE )
               GO  TO  10011-BIRTH-SELECT-EDIT-EXT
           END-IF
      *
           MOVE    1                   TO  CNT-JYOKEN
      *
           PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
           STRING  "(birthday >= '"        DELIMITED   BY  SIZE
                   WRK-STBIRTHDAY          DELIMITED   BY  SIZE
                   "') and "               DELIMITED   BY  SIZE
                   "(birthday  <= '"       DELIMITED   BY  SIZE
                   WRK-EDBIRTHDAY          DELIMITED   BY  SIZE
                   "')"                    DELIMITED   BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER WRK-SQL-PNT
           END-STRING
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
      *
           .
       10011-BIRTH-SELECT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    À­ÊÌ¸¡º÷¾ò·ïÊÔ½¸½èÍý
      *****************************************************************
       10011-SEX-SELECT-EDIT-SEC            SECTION.
      *
           IF      ( SPA-Q01-SEX       =   SPACE )
               GO  TO  10011-SEX-SELECT-EDIT-EXT
           END-IF
      *
           MOVE    1                   TO  CNT-JYOKEN
      *
           PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
           STRING  "(sex = '"       DELIMITED   BY  SIZE
                   SPA-Q01-SEX      DELIMITED   BY  SIZE
                   "')"             DELIMITED   BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER WRK-SQL-PNT
           END-STRING
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           .
       10011-SEX-SELECT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ½»½ê¸¡º÷¾ò·ïÊÔ½¸½èÍý
      *****************************************************************
       10011-HOME-ADRS-SELECT-EDIT-SEC      SECTION.
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
               IF  ( SPA-Q01-JYUSHO (IDX1) NOT =   SPACE)
      *
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *            ½»½ê¤Î¹àÌÜÄ¹¤òµá¤á¤ë
                   MOVE    1               TO  WRK-STR-LEN
                   MOVE    SPACE           TO  WRK-STR
                   STRING  SPA-Q01-JYUSHO (IDX1)   DELIMITED   BY  SIZE
                   INTO    WRK-STR
                   WITH POINTER WRK-STR-LEN
                   END-STRING
                   COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *            ½»½ê¤Î¼ÂºÝ¤ÎÊ¸»úÎóÄ¹¤òµá¤á¤ë
                   MOVE    SPA-Q01-JYUSHO (IDX1)   TO  WRK-STR
                   PERFORM 900-STR-LEN-GET-SEC
      *
                   STRING  "(home_adrs like '"     DELIMITED   BY  SIZE
                           SPA-Q01-JYUSHO (IDX1)(1: WRK-STR-LEN) 
                                                   DELIMITED   BY  SIZE
                           "%')"                   DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
      *
                END-IF
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           .
       10011-HOME-ADRS-SELECT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ¥³¥á¥ó¥È¸¡º÷¾ò·ïÊÔ½¸½èÍý
      *****************************************************************
       10011-COMMENT-SELECT-EDIT-SEC        SECTION.
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
               IF  ( SPA-Q01-COMMENT (IDX1) NOT =   SPACE)
      *
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *            ¥³¥á¥ó¥È¤Î¹àÌÜÄ¹¤òµá¤á¤ë
                   MOVE    1               TO  WRK-STR-LEN
                   MOVE    SPACE           TO  WRK-STR
                   STRING  SPA-Q01-COMMENT (IDX1)  DELIMITED   BY  SIZE
                   INTO    WRK-STR
                   WITH POINTER WRK-STR-LEN
                   END-STRING
                   COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *            ¥³¥á¥ó¥È¤Î¼ÂºÝ¤ÎÊ¸»úÎóÄ¹¤òµá¤á¤ë
                   MOVE    SPA-Q01-COMMENT (IDX1)  TO  WRK-STR
                   PERFORM 900-STR-LEN-GET-SEC
      *
                   STRING  "(comment_1 like '"     DELIMITED   BY  SIZE
                           SPA-Q01-COMMENT (IDX1)(1: WRK-STR-LEN) 
                                                   DELIMITED   BY  SIZE
                           "%')or"                 DELIMITED   BY  SIZE
                           " (comment_2 like '"    DELIMITED   BY  SIZE
                           SPA-Q01-COMMENT (IDX1)(1: WRK-STR-LEN) 
                                                   DELIMITED   BY  SIZE
                           "%')"                   DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
      *
                END-IF
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
      *
           .
       10011-COMMENT-SELECT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ÊÂ¤ÙÂØ¤¨½çÊÔ½¸½èÍý
      *****************************************************************
       1001-ORDER-EDIT-SEC                 SECTION.
      *
           MOVE    SPA-Q01-KMK (1)     TO  IDX-KMK1
           MOVE    SPA-Q01-KMK (2)     TO  IDX-KMK2
           MOVE    SPA-Q01-KMK (3)     TO  IDX-KMK3
      *
           MOVE    SPA-Q01-NARABE (1)  TO  IDX-SRT1
           MOVE    SPA-Q01-NARABE (2)  TO  IDX-SRT2
           MOVE    SPA-Q01-NARABE (3)  TO  IDX-SRT3
      *
           STRING  " ORDER BY "                DELIMITED   BY  SIZE
                   CONST-KMK-ITEM (IDX-KMK1)   DELIMITED   BY  SPACE
                   " "                         DELIMITED   BY  SIZE
                   CONST-ORDER (IDX-SRT1)
                                               DELIMITED   BY  SPACE
                   ","                         DELIMITED   BY  SIZE
                   CONST-KMK-ITEM (IDX-KMK2)   DELIMITED   BY  SPACE
                   " "                         DELIMITED   BY  SIZE
                   CONST-ORDER (IDX-SRT2)
                                               DELIMITED   BY  SPACE
                   ","                         DELIMITED   BY  SIZE
                   CONST-KMK-ITEM (IDX-KMK3)   DELIMITED   BY  SPACE
                   " "                         DELIMITED   BY  SIZE
                   CONST-ORDER (IDX-SRT3)
                                               DELIMITED   BY  SPACE
           INTO    WRK-SQL
           WITH    POINTER WRK-SQL-PNT
           END-STRING
      *
           .
      *
       1001-ORDER-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    £Ó£Ñ£Ì¾ò·ïÊÔ½¸½èÍý£±
      *****************************************************************
       900-SQL-JYOKEN-EDIT1-SEC            SECTION.
      *
           IF  ( FLG-JYOKEN        =   1 )
               STRING " and "      DELIMITED   BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER     WRK-SQL-PNT
               END-STRING
           END-IF
      *
           STRING  "(("                        DELIMITED   BY  SIZE
                   WRK-SQL-TBL-NAME            DELIMITED   BY  SPACE
                   ".hospid='"                 DELIMITED   BY  SIZE
                   SPA-HOSPID                  DELIMITED   BY  SIZE
                   "')and("                    DELIMITED   BY  SIZE
                   WRK-SQL-TBL-NAME            DELIMITED   BY  SPACE
                   ".ptid=a.ptid) "            DELIMITED   BY  SIZE
                   "and"                       DELIMITED   BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER     WRK-SQL-PNT
           END-STRING
      *
           .
       900-SQL-JYOKEN-EDIT1-EXT.
           EXIT.
      *****************************************************************
      *    £Ó£Ñ£Ì¾ò·ïÊÔ½¸½èÍý£²
      *****************************************************************
       900-SQL-JYOKEN-EDIT2-SEC            SECTION.
      *
           IF  ( CNT-JYOKEN    =   1 )
               IF  (   FLG-JYOKEN-AND  =   "1" )
                   STRING  " and "         DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
               END-IF
      *
               STRING  "("                 DELIMITED   BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
           ELSE
               STRING  "or "               DELIMITED   BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
           END-IF
      *
           .
       900-SQL-JYOKEN-EDIT2-EXT.
           EXIT.
      *****************************************************************
      *    £Ó£Ñ£Ì¾ò·ïÊÔ½¸½èÍý£³
      *****************************************************************
       900-SQL-JYOKEN-EDIT3-SEC            SECTION.
      *
           IF  ( CNT-JYOKEN    >   0 )
               STRING  ")"      DELIMITED   BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
               MOVE    1           TO  FLG-JYOKEN-AND
           END-IF
      *
           .
       900-SQL-JYOKEN-EDIT3-EXT.
           EXIT.
      *****************************************************************
      *    £Ó£Ñ£Ì¾ò·ïÊÔ½¸½èÍý£´
      *****************************************************************
       900-SQL-JYOKEN-EDIT4-SEC            SECTION.
      *
           STRING  ")"         DELIMITED   BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER     WRK-SQL-PNT
           END-STRING
      *
           .
       900-SQL-JYOKEN-EDIT4-EXT.
           EXIT.
      *****************************************************************
      *    £Ó£Ñ£Ì¾ò·ïÊÔ½¸½èÍý£µ
      *****************************************************************
       900-SQL-JYOKEN-EDIT5-SEC            SECTION.
      *
           IF  ( FLG-JYOKEN        =   1 )
               STRING " and "      DELIMITED   BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER     WRK-SQL-PNT
               END-STRING
           END-IF
      *
           STRING  "("             DELIMITED   BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER         WRK-SQL-PNT
           END-STRING
      *
           .
       900-SQL-JYOKEN-EDIT5-EXT.
           EXIT.
      *****************************************************************
      *    £Ó£Ñ£Ì¾ò·ïÊÔ½¸½èÍý£¶
      *****************************************************************
       900-SQL-JYOKEN-EDIT6-SEC            SECTION.
      *
           IF  ( FLG-JYOKEN-OR     =   1 )
               STRING " or"        DELIMITED   BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER     WRK-SQL-PNT
               END-STRING
           ELSE
               MOVE    1           TO  FLG-JYOKEN-OR
           END-IF
      *
           STRING  "("             DELIMITED   BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER     WRK-SQL-PNT
           END-STRING
      *
           .
       900-SQL-JYOKEN-EDIT6-EXT.
           EXIT.
      *****************************************************************
      *    Ê¸»úÎóÄ¹¼èÆÀ½èÍý
      *****************************************************************
       900-STR-LEN-GET-SEC                 SECTION.
      *
           PERFORM VARYING IDX-LEN FROM    WRK-STR-LEN BY  -1
               UNTIL   ( IDX-LEN   <   1)
                OR     ( WRK-STR (IDX-LEN : 1) NOT =   SPACE)
      *
               CONTINUE
           END-PERFORM
      *
           MOVE    IDX-LEN     TO  WRK-STR-LEN
      *
           .
       900-STR-LEN-GET-EXT.
           EXIT.
