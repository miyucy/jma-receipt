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
       PROGRAM-ID.                     ORCGI0SUB01.
      *****************************************************************
      *  ¥·¥¹¥Æ¥àÌ¾        : £Ï£Ò£Ã£Á
      *  ¥µ¥Ö¥·¥¹¥Æ¥àÌ¾    : Æþ±¡ÅÐÏ¿
      *  ¥³¥ó¥Ý¡¼¥Í¥ó¥ÈÌ¾  : Æþ±¡ÅÐÏ¿¥µ¥Ö
      *  ´ÉÍý¼Ô            : 
      *  ºîÀ®ÆüÉÕ    ºî¶È¼Ô        µ­½Ò
      *  02/05/16    MCC¡ÝÂÀÅÄ¡¡   ¿·µ¬ºîÀ®
      *****************************************************************
      *  ¥×¥í¥°¥é¥à½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      *****************************************************************
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    £Ó£Ã£Ò£Ó£Ð£Á¥Ç¡¼¥¿
           SELECT  SCRSPA-FILE     ASSIGN  FILE-NAME1
                                   ORGANIZATION    IS  SEQUENTIAL
                                   FILE    STATUS  IS  STS-SCRSPA.
      *
      *    £Ã£Ï£Í£Í£Ï£Î¥Ç¡¼¥¿
           SELECT  COMMON-FILE     ASSIGN  FILE-NAME2
                                   ORGANIZATION    IS  SEQUENTIAL
                                   FILE    STATUS  IS  STS-COMMON.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    £Ó£Ã£Ò£Ó£Ð£Á¥Ç¡¼¥¿
       FD  SCRSPA-FILE.
       01  SCRSPA-DATA-REC         PIC X(30000).
      *
      *    £Ã£Ï£Í£Í£Ï£Î¥Ç¡¼¥¿
       FD  COMMON-FILE.
       01  COMMON-DATA-REC         PIC X(10000).
      *
       WORKING-STORAGE             SECTION.
      *
      *    £Ó£Ã£Ò£Ó£Ð£Á¥Ç¡¼¥¿
       01  FILE-NAME1.
           03  FILLER              PIC X(09)   VALUE   "/var/tmp/".
           03  FILLER              PIC X(09)   VALUE   "I01SCRSPA".
           03  FILE-TERMID1        PIC X(64)   VALUE   SPACE.
           03  FILLER              PIC X(04)   VALUE   ".TXT".
      *
      *    £Ã£Ï£Í£Í£Ï£Î¥Ç¡¼¥¿
       01  FILE-NAME2.
           03  FILLER              PIC X(09)   VALUE   "/var/tmp/".
           03  FILLER              PIC X(09)   VALUE   "I01COMMON".
           03  FILE-TERMID2        PIC X(64)   VALUE   SPACE.
           03  FILLER              PIC X(04)   VALUE   ".TXT".
      *
      *    ¥¹¥Æ¡¼¥¿¥¹ÎÎ°è
       01  STS-AREA.
           03  STS-SCRSPA          PIC X(02).
           03  STS-COMMON          PIC X(02).
      *    ¥Õ¥é¥°ÎÎ°è
       01  FLG-AREA.
           03  FLG-READ            PIC 9(01).
           03  FLG-END             PIC 9(01).
      *
      *    Åº»úÎÎ°è
       01  IDX-AREA.
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
      *
      *****************************************************************
      *    Ï¢Íí¡¡ÎÎ°è
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPI0SUB01.INC".
      *
       PROCEDURE                   DIVISION    USING
           I0SUB01-LNK.
      *****************************************************************
      *    ¼ç¡¡¡¡½èÍý
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           MOVE    I0SUB01-TERMID  TO  FILE-TERMID1
                                       FILE-TERMID2
      *
           IF  ( I0SUB01-KBN       =   "I" )
               PERFORM 100-SPA-INPUT-SEC
           ELSE
               PERFORM 200-SPA-OUTPUT-SEC
           END-IF
      *
           EXIT PROGRAM
           .
      *
      *****************************************************************
      *    £Ó£Ã£Ò£Ó£Ð£ÁÆÉ¹þ½èÍý
      *****************************************************************
       100-SPA-INPUT-SEC               SECTION.
      *
           MOVE    ZERO        TO  FLG-READ
           MOVE    SPACE       TO  I0SUB01-SCRSPA-AREA
      *
           OPEN    INPUT           SCRSPA-FILE
           IF      STS-SCRSPA      NOT =   ZERO
               MOVE    1       TO  FLG-READ
           END-IF
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   ( IDX1              >   10 )
                OR     ( FLG-READ  NOT =   ZERO )
      *
               READ    SCRSPA-FILE
               AT  END
                   MOVE    1               TO  FLG-READ
               NOT AT  END
                   MOVE    SCRSPA-DATA-REC TO  I0SUB01-SCRSPA (IDX1)
               END-READ
      *
           END-PERFORM
      *
           CLOSE   SCRSPA-FILE
      *
           OPEN    INPUT           COMMON-FILE
           IF      STS-COMMON      NOT =   ZERO
               MOVE    1       TO  FLG-READ
           END-IF
      *
           READ    COMMON-FILE
      *
           MOVE    COMMON-DATA-REC
                               TO  I0SUB01-COMMON
      *
           CLOSE   COMMON-FILE
      *
           .
       100-SPA-INPUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ó£Ã£Ò£Ó£Ð£Á½ÐÎÏ½èÍý
      *****************************************************************
       200-SPA-OUTPUT-SEC              SECTION.
      *
           OPEN    OUTPUT          SCRSPA-FILE
           IF      STS-SCRSPA      NOT =   ZERO
               GO  TO              200-SPA-OUTPUT-EXT
           END-IF
      *
           PERFORM VARYING IDX1    FROM    10  BY  -1
               UNTIL  ( I0SUB01-SCRSPA (IDX1)
                                   NOT =   SPACE )
                   OR ( IDX1           <   1 )
      *
               CONTINUE
      *
           END-PERFORM
      *
           IF    ( IDX1               >=   ZERO )
               PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL   ( IDX2              >   IDX1 )
      *
                   MOVE    I0SUB01-SCRSPA (IDX2)   TO  SCRSPA-DATA-REC
      *
                   WRITE   SCRSPA-DATA-REC
      *
               END-PERFORM
           END-IF
      *
           CLOSE   SCRSPA-FILE
      *
           OPEN    OUTPUT          COMMON-FILE
           IF      STS-COMMON      NOT =   ZERO
               GO  TO              200-SPA-OUTPUT-EXT
           END-IF
      *
           MOVE    I0SUB01-COMMON  TO  COMMON-DATA-REC
      *
           WRITE   COMMON-DATA-REC
      *
           CLOSE   COMMON-FILE
      *
           .
       200-SPA-OUTPUT-EXT.
           EXIT.
