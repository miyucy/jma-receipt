      *******************************************************************
      * Project code name "ORCA"
      * 日医標準レセプトソフト（JMA standard receipt software）
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
       PROGRAM-ID.                     ORCGQSUB01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者照会
      *  コンポーネント名  : 患者照会サブ
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/05/16    MCC−太田　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    ＳＰＡデータ
           SELECT  SPA-FILE        ASSIGN  FILE-NAME1
                                   ORGANIZATION    IS  SEQUENTIAL
                                   FILE    STATUS  IS  STS-SPA.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    ＳＰＡパラメタデータ
       FD  SPA-FILE.
       01  SPA-DATA-REC            PIC X(30000).
      *
       WORKING-STORAGE             SECTION.
      *
      * ＳＰＡデータ
       01  FILE-NAME1.
           03  FILLER              PIC X(09)   VALUE   "/var/tmp/".
           03  FILLER              PIC X(06)   VALUE   "Q02SPA".
           03  FILE-TERMID1        PIC X(32)   VALUE   SPACE.
           03  FILLER              PIC X(04)   VALUE   ".TXT".
      *
      *    ステータス領域
       01  STS-AREA.
           03  STS-SPA             PIC X(02).
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-SPA-READ        PIC 9(01).
           03  FLG-END             PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPQSUB01.INC".
      *
       PROCEDURE                   DIVISION    USING
           QSUB01-LNK.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           MOVE    QSUB01-TERMID   TO  FILE-TERMID1
      *
           IF  ( QSUB01-KBN        =   "I" )
               PERFORM 100-SPA-INPUT-SEC
           ELSE
               PERFORM 200-SPA-OUTPUT-SEC
           END-IF
      *
           EXIT PROGRAM
           .
      *
      *****************************************************************
      *    ＳＣＲＳＰＡ読込処理
      *****************************************************************
       100-SPA-INPUT-SEC               SECTION.
      *
           MOVE    ZERO        TO  FLG-SPA-READ
           MOVE    SPACE       TO  QSUB01-SPA-AREA
      *
           OPEN    INPUT           SPA-FILE
           IF      STS-SPA         NOT =   ZERO
               MOVE    1       TO  FLG-SPA-READ
           END-IF
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   ( IDX1              >   10 )
                OR     ( FLG-SPA-READ  NOT =   ZERO )
      *
               READ    SPA-FILE
               AT  END
                   MOVE    1               TO  FLG-SPA-READ
               NOT AT  END
                   MOVE    SPA-DATA-REC    TO  QSUB01-SPA (IDX1)
               END-READ
      *
           END-PERFORM
      *
           CLOSE   SPA-FILE
      *
           .
       100-SPA-INPUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＳＣＲＳＰＡ出力処理
      *****************************************************************
       200-SPA-OUTPUT-SEC              SECTION.
      *
           MOVE    ZERO        TO  FLG-SPA-READ
      *
           OPEN    OUTPUT          SPA-FILE
           IF      STS-SPA         NOT =   ZERO
               GO  TO              200-SPA-OUTPUT-EXT
           END-IF
      *
           PERFORM VARYING IDX1    FROM    10  BY  -1
               UNTIL  ( QSUB01-SPA (IDX1)
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
                   MOVE    QSUB01-SPA (IDX2)   TO  SPA-DATA-REC
      *
                   WRITE   SPA-DATA-REC
      *
               END-PERFORM
           END-IF
      *
           CLOSE   SPA-FILE
      *
           .
       200-SPA-OUTPUT-EXT.
           EXIT.
