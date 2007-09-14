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
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCSC98.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 診療行為入力
      *  コンポーネント名  : 点数計算後共通チェック処理
      *                      （投薬量等のチェック）
      *                      （Ｋ０２、Ｊ０４のみ共通使用）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  06/12/12    NACL−多々納  新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
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
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                 PIC 9(01).
           03  FLG-SP                  PIC 9(01).
           03  FLG-TOUYO-CHK           PIC 9(01).
           03  FLG-TOUYO-CHK1          PIC 9(01).
           03  FLG-TOUYO-CHK2          PIC 9(01).
           03  FLG-NENREI-CD           PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDX3                PIC 9(04).
           03  IDM                 PIC 9(04).
           03  IDM2                PIC 9(04).
           03  IDX-Z               PIC 9(04).
           03  IDX-SET             PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-NEN                 PIC 9(03).
           03  WRK-TOURYO              PIC 9(05)V9(05).
      *
           03  WRK-SURYO           PIC 9(05)V9(05).
           03  WRK-SURYO-R         REDEFINES   WRK-SURYO.
               05  WRK-SURYO-S1    PIC 9(05).
               05  WRK-SURYO-S2    PIC 9(05).
      *
           03  WRK-SURYO-X.
               05  WRK-SURYO-Z1    PIC ZZZZZ.
               05  WRK-SURYO-Z1-9  REDEFINES   WRK-SURYO-Z1
                                   PIC ZZZZ9.
               05  WRK-SURYO-Z2    PIC X(01).
               05  WRK-SURYO-Z3    PIC ZZZZZ.
           03  WRK-SURYO-H         PIC X(11).
      *    年令チェック
           03  WRK-NENCD               PIC X(02).
           03  WRK-NENREI.
               05  WRK-NEN-YY          PIC 9(03).
               05  WRK-NEN-MM          PIC 9(02).
               05  WRK-NEN-DD          PIC 9(02).
      *
      *    年令単位テーブル
           COPY    "CMNENREICD.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *
      *    COPY    "MCPAREA".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *    投与量等チェックパラメタ
           COPY    "CPORCSC98.INC".
      *    ＳＰＡパラメタ
       01  SPA-SCR-REC.
           COPY    "CPK02SPASCR.INC".
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           ORCSC98AREA
           SPA-SCR-REC
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                      WRK-AREA
           INITIALIZE                      FLG-AREA
           INITIALIZE                      IDX-AREA
      *
           PERFORM 100-MAIN-SYORI-SEC
      *
           . 
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    メイン処理
      *****************************************************************
       100-MAIN-SYORI-SEC            SECTION.
      *
           MOVE    ZERO                TO  IDX-SET
           PERFORM VARYING     IDX-Z   FROM    1   BY  1
                   UNTIL      (IDX-Z       >   SPA-MAX-LINE     )   OR
                             ((SPA-GMN-INPUTCD (IDX-Z) =   SPACE ) AND
                              (SPA-COM-INPUTCD (IDX-Z) =   SPACE ))
                           OR (SPA-ERRCD   NOT =   SPACE   )
      *        セットの行位置
               IF      SPA-GMN-INPUTCD(IDX-Z)(1:1) =   "S"
                   MOVE    IDX-Z               TO  IDX-SET
               END-IF
      *        長期投薬期間
               IF     LNK-SC98-PG              =   "J04"
                   CONTINUE
               ELSE
                   IF    (SPA-COM-INPUTCD(IDX-Z)(1:1)  =   "6" ) AND
                         (SPA-COM-CHOKINISSU (IDX-Z)   >   ZERO) AND
                         (SPA-COM-CHOKINISSU (IDX-Z)   <   SPA-COM-KAISU
                                                          (IDX-Z))
                       PERFORM 10012-CHOKI-ERR-SEC
                   END-IF
               END-IF
      *        投与量
               IF    (SPA-COM-INPUTCD(IDX-Z)(1:1)  =   "6" ) AND
                     (SPA-ERRCD                    =   SPACE)
                   IF     (SPA-COM-SURFLG (IDX-Z)  =   "1" )  OR
                          (SPA-COM-SURCHK (IDX-Z)  NOT =   SPACE)
                       PERFORM 1001-TOUYO-CHK-SEC
                       MOVE    "1"             TO  SPA-COM-SURCHK
                                                              (IDX-Z)
                   ELSE
                       MOVE    "2"             TO  SPA-COM-SURCHK
                                                              (IDX-Z)
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       100-MAIN-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    長期日数エラー処理
      *****************************************************************
       10012-CHOKI-ERR-SEC            SECTION.
      *
           IF     (SPA-COM-CHOKIERR (IDX-Z)    =   9 )
               IF      SPA-COM-SET (IDX-Z) =   "1"
                   IF      SPA-COM-KZMFLG4 (IDX-SET) =   SPACE
                       MOVE    "K200"          TO  SPA-ERRCD
                       MOVE    "1"             TO  SPA-COM-KZMFLG4
                                                            (IDX-SET)
                       MOVE    "1"             TO  SPA-COM-CUR (IDX-SET)
                   END-IF
               ELSE
                   IF      SPA-COM-KZMFLG4 (IDX-Z) =   SPACE
                       MOVE    "K200"          TO  SPA-ERRCD
                       MOVE    "1"             TO  SPA-COM-KZMFLG4
                                                            (IDX-Z)
                       MOVE    "1"             TO  SPA-COM-CUR (IDX-Z)
                   END-IF
               END-IF
           ELSE
               MOVE    "0200"              TO  SPA-ERRCD
               IF      SPA-COM-SET (IDX-Z) =   "1"
                   MOVE    "1"             TO  SPA-COM-CUR (IDX-SET)
               ELSE
                   MOVE    "1"             TO  SPA-COM-CUR (IDX-Z)
               END-IF
           END-IF
      *
           MOVE    SPA-COM-CHOKINISSU (IDX-Z)
                                       TO  WRK-SURYO
           PERFORM 10021-SURYO-HEN-SEC
      *
           MOVE    SPACE               TO  LNK-SC98-ERRMSG
           STRING  "長期日数の上限は " DELIMITED  BY  SIZE
                   WRK-SURYO-H         DELIMITED  BY  SPACE
                   "日です。"          DELIMITED  BY  SIZE
                                       INTO    LNK-SC98-ERRMSG
           END-STRING
           .
       10012-CHOKI-ERR-EXT.
      *
      *****************************************************************
      *    投与量チェック処理
      *****************************************************************
       1001-TOUYO-CHK-SEC            SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX         >   10   )   OR
                              (SPA-ERRCD   NOT =   SPACE )
               MOVE    ZERO                TO  FLG-TOUYO-CHK
               IF     (SPA-COM-TOUYORYO1 (IDX-Z IDX) =   ZERO ) AND
                      (SPA-COM-TOUYORYO2 (IDX-Z IDX) =   ZERO )
      *            チェックなし
                   CONTINUE
               ELSE
                   EVALUATE    TRUE
      *                下限・上限設定なし
                       WHEN    (SPA-COM-TOUYOKGNAGE (IDX-Z IDX)
                                                   =   ZERO )  AND
                               (SPA-COM-TOUYOJGNAGE (IDX-Z IDX)
                                                   =   ZERO )
                           MOVE    1               TO  FLG-TOUYO-CHK
      *                下限のみ設定
                       WHEN    (SPA-COM-TOUYOKGNAGE (IDX-Z IDX)
                                               NOT =   ZERO )  AND
                               (SPA-COM-TOUYOJGNAGE (IDX-Z IDX)
                                                   =   ZERO )
                           PERFORM 10011-KGNAGE-CHK-SEC
                           IF      FLG-TOUYO-CHK1      =   1
                               MOVE    1               TO  FLG-TOUYO-CHK
                           END-IF
      *                上限のみ設定
                       WHEN    (SPA-COM-TOUYOKGNAGE (IDX-Z IDX)
                                                   =   ZERO )  AND
                               (SPA-COM-TOUYOJGNAGE (IDX-Z IDX)
                                               NOT =   ZERO )
                           PERFORM 10012-JGNAGE-CHK-SEC
                           IF      FLG-TOUYO-CHK2      =   1
                               MOVE    1               TO  FLG-TOUYO-CHK
                           END-IF
      *                共に設定あり
                       WHEN    (SPA-COM-TOUYOKGNAGE (IDX-Z IDX)
                                               NOT =   ZERO )  AND
                               (SPA-COM-TOUYOJGNAGE (IDX-Z IDX)
                                               NOT =   ZERO )
                           PERFORM 10011-KGNAGE-CHK-SEC
                           PERFORM 10012-JGNAGE-CHK-SEC
                           IF     (FLG-TOUYO-CHK1      =   1 ) AND
                                  (FLG-TOUYO-CHK2      =   1 )
                               MOVE    1               TO  FLG-TOUYO-CHK
                           END-IF
                   END-EVALUATE
               END-IF
      *
               IF      FLG-TOUYO-CHK       =   1
      *             投与量チェック
                   IF      SPA-COM-SRYKBN (IDX-Z)  =   "22"
      *                頓服判定
                       IF      (SPA-COM-TOUYORYO2 (IDX-Z IDX)  =   ZERO)
                           MOVE    SPA-COM-TOUYORYO1 (IDX-Z IDX)
                                                   TO  WRK-TOURYO
                       ELSE
                           MOVE    SPA-COM-TOUYORYO2 (IDX-Z IDX)
                                                   TO  WRK-TOURYO
                       END-IF
                       IF      (WRK-TOURYO         >   ZERO )  AND
                              ((SPA-COM-SURYO (IDX-Z)  *
                                SPA-COM-KAISU (IDX-Z)  )
                                                   >   WRK-TOURYO)
                           PERFORM 1002-TOUYO-ERR-SEC
                       END-IF
                   ELSE
                       IF      (SPA-COM-TOUYORYO1 (IDX-Z IDX)  >   ZERO)
                          AND  (SPA-COM-TOUYORYO1 (IDX-Z IDX)
                                                   <   SPA-COM-SURYO
                                                             (IDX-Z))
                           MOVE    SPA-COM-TOUYORYO1 (IDX-Z IDX)
                                                   TO  WRK-TOURYO
                           PERFORM 1002-TOUYO-ERR-SEC
                       END-IF
                   END-IF
               END-IF
           END-PERFORM
           .
       1001-TOUYO-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    下限年齢チェック処理
      *****************************************************************
       10011-KGNAGE-CHK-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-TOUYO-CHK1
           MOVE    SPA-COM-TOUYOKGNAGE (IDX-Z IDX)
                                       TO  WRK-NENCD
           PERFORM 10013-NENREICD-CHK-SEC
           IF      FLG-NENREI-CD       =   1
               CONTINUE
           ELSE
               MOVE    SPA-COM-TOUYOKGNAGE (IDX-Z IDX)
                                           TO  WRK-NEN-YY(2:2)
           END-IF
           IF      LNK-SC98-NENREI     <   WRK-NENREI
               CONTINUE
           ELSE
               MOVE    1               TO  FLG-TOUYO-CHK1
           END-IF
           .
       10011-KGNAGE-CHK-EXT.
           EXIT.
      *****************************************************************
      *    上限年齢チェック処理
      *****************************************************************
       10012-JGNAGE-CHK-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-TOUYO-CHK2
           MOVE    SPA-COM-TOUYOJGNAGE (IDX-Z IDX)
                                       TO  WRK-NENCD
           PERFORM 10013-NENREICD-CHK-SEC
           IF      FLG-NENREI-CD       =   1
               CONTINUE
           ELSE
               MOVE    SPA-COM-TOUYOJGNAGE (IDX-Z IDX)
                                           TO  WRK-NEN-YY(2:2)
           END-IF
           IF      LNK-SC98-NENREI     <   WRK-NENREI
               MOVE    1               TO  FLG-TOUYO-CHK2
           END-IF
           .
       10012-JGNAGE-CHK-EXT.
           EXIT.
      *****************************************************************
      *    年齢コードチェック処理
      *****************************************************************
       10013-NENREICD-CHK-SEC             SECTION.
      *
           MOVE    ZERO                TO  FLG-NENREI-CD
           MOVE    ZERO                TO  WRK-NENREI
      *
           SET     NENREI-IDX          TO  1
           SEARCH      NENREI-TBL-OCC VARYING   NENREI-IDX
               AT  END
                   MOVE    ZERO            TO  FLG-NENREI-CD
               WHEN    NENREI-NENCD(NENREI-IDX) 
                                           =   WRK-NENCD
                   MOVE    1               TO  FLG-NENREI-CD
                   MOVE    NENREI-DD (NENREI-IDX) 
                                           TO  WRK-NEN-DD
                   MOVE    NENREI-MM (NENREI-IDX) 
                                           TO  WRK-NEN-MM
           END-SEARCH
           .
       10013-NENREICD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    投与量チェック処理
      *****************************************************************
       1002-TOUYO-ERR-SEC            SECTION.
      *
           IF      SPA-COM-TOUYOERR(IDX-Z) =   9
               IF      SPA-COM-SET (IDX-Z) =   "1"
                   IF      SPA-COM-KZMFLG5 (IDX-SET) =   SPACE
                       MOVE    "1"         TO  SPA-COM-KZMFLG5(IDX-SET)
                       MOVE    "1"         TO  SPA-COM-CUR (IDX-SET)
                       MOVE    "K201"          TO  SPA-ERRCD
                   END-IF
               ELSE
                   IF      SPA-COM-KZMFLG5 (IDX-Z) =   SPACE
                       MOVE    "1"         TO  SPA-COM-KZMFLG5 (IDX-Z)
                       MOVE    "1"         TO  SPA-COM-CUR (IDX-Z)
                       MOVE    "K201"      TO  SPA-ERRCD
                   END-IF
               END-IF
           ELSE
               MOVE    "0201"              TO  SPA-ERRCD
               IF      SPA-COM-SET (IDX-Z) =   "1"
                   MOVE    "1"             TO  SPA-COM-CUR (IDX-SET)
               ELSE
                   MOVE    "1"             TO  SPA-COM-CUR (IDX-Z)
               END-IF
           END-IF
      *
           MOVE    WRK-TOURYO          TO  WRK-SURYO
           PERFORM 10021-SURYO-HEN-SEC
      *
           MOVE    SPACE               TO  LNK-SC98-ERRMSG
           IF      SPA-COM-SRYKBN (IDX-Z)  =   "22"
               STRING  "頓服の投与量の上限数量は "
                                               DELIMITED  BY  SIZE
                       WRK-SURYO-H             DELIMITED  BY  SPACE
                       " です。"               DELIMITED  BY  SIZE
                                           INTO    LNK-SC98-ERRMSG
               END-STRING
           ELSE
               STRING  "投与量の上限数量は "   DELIMITED  BY  SIZE
                       WRK-SURYO-H             DELIMITED  BY  SPACE
                       " です。"               DELIMITED  BY  SIZE
                                           INTO    LNK-SC98-ERRMSG
               END-STRING
           END-IF
           .
       1002-TOUYO-ERR-EXT.
      *
      *****************************************************************
      *    数量表示用編集処理
      *****************************************************************
       10021-SURYO-HEN-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-SURYO-X
           MOVE    WRK-SURYO-S1        TO  WRK-SURYO-Z1
      *
           MOVE    ZERO                TO  FLG-SP
           PERFORM VARYING     IDM     FROM    5  BY  -1
                   UNTIL       IDM     <   1
               IF      WRK-SURYO-S2(IDM:1) NOT =   ZERO
                   MOVE    1               TO  FLG-SP
               END-IF
               IF      FLG-SP          =   1
                   MOVE    WRK-SURYO-S2(IDM:1) TO  WRK-SURYO-Z3(IDM:1)
               END-IF
           END-PERFORM
      *
           IF      WRK-SURYO-Z3        NOT =   SPACE
               MOVE    "."                 TO  WRK-SURYO-Z2
               IF      WRK-SURYO-X(1:5)    =   SPACE
                   MOVE    WRK-SURYO-S1        TO  WRK-SURYO-Z1-9
               END-IF
           END-IF
           MOVE    ZERO                TO  IDM2
           MOVE    SPACE               TO  WRK-SURYO-H
           PERFORM VARYING     IDM     FROM    1  BY  1
                   UNTIL       IDM     >   11
              IF       WRK-SURYO-X (IDM:1) NOT =   SPACE
                   MOVE    WRK-SURYO-X(IDM:)   TO  WRK-SURYO-H(1:)
                   MOVE    11                  TO  IDM
              END-IF
           END-PERFORM
           .
       2001-SURYO-HEN-EXT.
           EXIT.
      *
