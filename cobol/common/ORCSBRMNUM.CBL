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
       IDENTIFICATION                      DIVISION.
       PROGRAM-ID.                         ORCSBRMNUM.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : 病室名編集サブ
      *  返却エラーコード  : 00:正常　99:エラー
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/05/14    NACL-太田     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                         DIVISION.
       CONFIGURATION                       SECTION.
       INPUT-OUTPUT                        SECTION.
       DATA                                DIVISION.
       FILE                                SECTION.
       WORKING-STORAGE                     SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                     PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                        PIC 9(05).
           03  IDX2                        PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-BRM-NUM-EDT             PIC X(06).
           03  WRK-STR                     PIC X(20).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                             SECTION.
      *
           COPY    "CPORCSBRMNUM.INC".
      *
       PROCEDURE                           DIVISION    USING
           ORCSBRMNUMAREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                        SECTION.
      *
           INITIALIZE                      WRK-AREA
           INITIALIZE                      FLG-AREA
           INITIALIZE                      IDX-AREA
           INITIALIZE                      SBRMNUM-RC
      *
           PERFORM 100-EDIT-SEC
      *
           .
       000-PROC-EXT.
           EXIT.
      *
           EXIT PROGRAM
           .
      *
      *****************************************************************
      *    編集処理
      *****************************************************************
       100-EDIT-SEC                        SECTION.
      *
           IF    ( SBRMNUM-IN-BRMNUM (1 : 1)  =   SPACE )
               MOVE    SPACE           TO  WRK-STR
               MOVE    1               TO  IDX1
               UNSTRING    SBRMNUM-IN-BRMNUM
                   DELIMITED   BY  ALL SPACE
                   INTO    WRK-STR
                   WITH    POINTER IDX1
               END-UNSTRING
               MOVE    SBRMNUM-IN-BRMNUM (IDX1 : )
                                       TO  WRK-BRM-NUM-EDT
           ELSE
               MOVE    SBRMNUM-IN-BRMNUM  TO  WRK-BRM-NUM-EDT
           END-IF
      *
           PERFORM VARYING IDX1    FROM    6   BY  -1
               UNTIL     ( IDX1    <   1 )
                 OR      ( WRK-BRM-NUM-EDT (IDX1 : 1)
                                   NOT =   SPACE )
               CONTINUE
           END-PERFORM
      *
           IF    ( IDX1    <   1 )
               MOVE    WRK-BRM-NUM-EDT     TO  SBRMNUM-OT-BRMNUM
               GO  TO  100-EDIT-EXT
           END-IF
      *
      *    病室番号が数字の場合前ゼロをとる
           IF    ( WRK-BRM-NUM-EDT ( 1 : IDX1 )
                                       IS  NUMERIC )
               IF    ( WRK-BRM-NUM-EDT ( 1 : 1 )
                                       =   ZERO )
                   MOVE    1               TO  IDX2
                   MOVE    SPACE           TO  WRK-STR
                   UNSTRING    WRK-BRM-NUM-EDT
                       DELIMITED BY  ALL ZERO
                   INTO    WRK-STR
                   WITH    POINTER IDX2
                   END-UNSTRING
                   MOVE    WRK-BRM-NUM-EDT (IDX2 : )
                                           TO  SBRMNUM-OT-BRMNUM
               ELSE
                   MOVE    WRK-BRM-NUM-EDT TO  SBRMNUM-OT-BRMNUM
               END-IF
           ELSE
                   MOVE    WRK-BRM-NUM-EDT TO  SBRMNUM-OT-BRMNUM
           END-IF
      *
           .
       100-EDIT-EXT.
           EXIT.
      *
