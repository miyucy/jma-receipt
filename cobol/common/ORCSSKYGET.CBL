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
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCSSKYGET.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : 保険者負担等の請求額取り込みサブ
      *  管理者            : 
      *  作成日付    作業者        記述
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
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
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-KOHSKY                PIC 9(01).
           03  FLG-SYUNOU                PIC 9(01).
           03  FLG-SYUKEI                PIC 9(01).
           03  FLG-JIHIRANSYUKEI         PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                      PIC 9(03).
           03  IDX2                      PIC 9(01).
           03  IDX3                      PIC 9(02).
      *
      *    ワーク領域
       01  WRK-AREA.
           03  WRK-KEISAN                PIC S9(09).
           03  WRK-KEISAN2               PIC S9(09).
      *
           03  WRK-TAIHI-AREA.
             05  WRK-TAIHI-PTID          PIC 9(10).
             05  WRK-TAIHI-HKNCOMBINUM   PIC X(04).
      *
           03  WRK-TAIHI-AREA2.
             05  WRK-TAIHI-DAY           PIC 9(01)   OCCURS   31.
      *
      *    共通領域
           COPY    "MCPAREA".
      *
      *    公費請求
           COPY    "CPKOHSKY.INC".
      *
      *    収納
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
           COPY    "MCPDATA.INC".
      *
      *    患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPORCSSKYGET.INC".
      *
           COPY    "CPRCF010.INC".
      *
           COPY    "COMMON-SPA".
      *
       PROCEDURE                    DIVISION    USING
           ORCSSKYGETAREA
           RECE10-REC
           SPA-AREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                 SECTION.
      *
           MOVE    ZERO    TO    LNK-SKYGET-RC
           INITIALIZE            LNK-SKYGET-OUT-AREA
           INITIALIZE            LNK-SKYGET-OUT2-AREA
      *
           INITIALIZE            FLG-AREA
           INITIALIZE            IDX-AREA
           INITIALIZE            WRK-AREA
      *
      *    パラメタチェック
           PERFORM   100-PRM-CHK-SEC
      *
           IF    LNK-SKYGET-RC    =   ZERO
               PERFORM   200-MAIN-SEC
           END-IF
      *
           .
       000-PROC-EXT.
      *
           EXIT PROGRAM
           .
      *
      *****************************************************************
      *    パラメタチェック
      *****************************************************************
       100-PRM-CHK-SEC                     SECTION.
      *
           EVALUATE    LNK-SKYGET-KBN
      *      ＜社保・国保・後期高齢の請求管理データ単位の編集＞
             WHEN      "1"
               IF      LNK-SKYGET-SRYYM  <  201004
                      MOVE    1     TO   LNK-SKYGET-RC
               ELSE
                 IF    RECE10-REC        =  SPACE
                      MOVE    2     TO   LNK-SKYGET-RC
                 ELSE
                   IF  RECE10-SRYYM      <  201004
                      MOVE    3     TO   LNK-SKYGET-RC
                   END-IF
                 END-IF
               END-IF
      *      ＜社保・国保・後期高齢の自費分以下の編集＞
      *      ＜特別療養費、自費保険、治験、労災、自賠責、公害の編集＞
             WHEN      "2"
               IF      LNK-SKYGET-SRYYM  <  201004
                      MOVE    4     TO   LNK-SKYGET-RC
               END-IF
             WHEN      OTHER
                      MOVE    5     TO   LNK-SKYGET-RC
           END-EVALUATE
      *
           .
       100-PRM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    主取得
      *****************************************************************
       200-MAIN-SEC            SECTION.
      *
           EVALUATE    LNK-SKYGET-KBN
             WHEN      "1"
               PERFORM    2001-HENSYU1-SEC
             WHEN      "2"
               PERFORM    2002-HENSYU2-SEC
           END-EVALUATE
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    区分”１”の編集
      *****************************************************************
       2001-HENSYU1-SEC            SECTION.
      *
           MOVE   RECE10-SKYIRYO-INF   TO   LNK-SKYGET-IRYO-INF
           MOVE   RECE10-SKYSKJ-INF    TO   LNK-SKYGET-SKJ-INF
      *
           IF    (LNK-SKYGET-IRYO-TOTALTEN   NOT = ZERO)
           OR    (LNK-SKYGET-SKJ-RYOYOHI     NOT = ZERO)
             PERFORM   VARYING   IDX1   FROM  1  BY  1
                        UNTIL    IDX1                >  4
               IF   RECE10-KOHNUM(IDX1)  NOT = SPACE
                 MOVE  RECE10-KOHNUM(IDX1)
                            TO  LNK-SKYGET-KOH-HKNNUM(IDX1)
                 MOVE  RECE10-JNISSU(IDX1 + 1)
                            TO  LNK-SKYGET-KOH-NISSU(IDX1)
                 MOVE  RECE10-TOTALTEN(IDX1 + 1)
                            TO  LNK-SKYGET-KOH-TOTALTEN(IDX1)
                 MOVE  RECE10-FTNMONEY(IDX1 + 1)
                            TO  LNK-SKYGET-KOH-FTNMONEY(IDX1)
                 MOVE  RECE10-SHOKUJINISSU(IDX1 + 1)
                            TO  LNK-SKYGET-KOH-KAISU(IDX1)
                 MOVE  RECE10-SHOKUJIRYOYOHI(IDX1 + 1)
                            TO  LNK-SKYGET-KOH-RYOYOHI(IDX1)
                 MOVE  RECE10-SHOKUJIFTN(IDX1 + 1)
                            TO  LNK-SKYGET-KOH-SHOKUJIFTN(IDX1)
               END-IF
             END-PERFORM
      *
             INITIALIZE                          KOHSKY-REC
             MOVE     RECE10-KEY             TO  KOHSKY-KEY
             PERFORM  900-KOHSKY-READ-SEC
             IF       FLG-KOHSKY  =   ZERO
               PERFORM   VARYING   IDX1   FROM  1  BY  1
                          UNTIL    IDX1                >  4
                IF  (KOHSKY-KOHNUM(IDX1) NOT = SPACE                   )
                AND (KOHSKY-KOHNUM(IDX1) NOT = LNK-SKYGET-KOH-HKNNUM(1))
                AND (KOHSKY-KOHNUM(IDX1) NOT = LNK-SKYGET-KOH-HKNNUM(2))
                AND (KOHSKY-KOHNUM(IDX1) NOT = LNK-SKYGET-KOH-HKNNUM(3))
                AND (KOHSKY-KOHNUM(IDX1) NOT = LNK-SKYGET-KOH-HKNNUM(4))
                 MOVE  KOHSKY-KOHNUM(IDX1)
                            TO  LNK-SKYGET-KOHETC-HKNNUM(IDX1)
                 MOVE  KOHSKY-JNISSU(IDX1 + 1)
                            TO  LNK-SKYGET-KOHETC-NISSU(IDX1)
                 MOVE  KOHSKY-TOTALTEN(IDX1 + 1)
                            TO  LNK-SKYGET-KOHETC-TOTALTEN(IDX1)
                 MOVE  KOHSKY-FTNMONEY(IDX1 + 1)
                            TO  LNK-SKYGET-KOHETC-FTNMONEY(IDX1)
                 MOVE  KOHSKY-SHOKUJINISSU(IDX1 + 1)
                            TO  LNK-SKYGET-KOHETC-KAISU(IDX1)
                 MOVE  KOHSKY-SHOKUJIRYOYOHI(IDX1 + 1)
                            TO  LNK-SKYGET-KOHETC-RYOYOHI(IDX1)
                 MOVE  KOHSKY-SHOKUJIFTN(IDX1 + 1)
                            TO  LNK-SKYGET-KOHETC-SHOKUJIFTN(IDX1)
                END-IF
               END-PERFORM
             END-IF
           ELSE
             MOVE    11     TO  LNK-SKYGET-RC
           END-IF
      *
           .
       2001-HENSYU1-EXT.
           EXIT.
      *
      *****************************************************************
      *    区分”２”の編集
      *****************************************************************
       2002-HENSYU2-SEC            SECTION.
      *
      *    入院（仮収納）
           MOVE    ZERO                  TO   FLG-SYUKEI
           INITIALIZE                         WRK-TAIHI-AREA
           INITIALIZE                         WRK-TAIHI-AREA2
           INITIALIZE                         SYUNOU-REC
           MOVE    SPA-HOSPNUM           TO   SYU-HOSPNUM
           MOVE    "1"                   TO   SYU-NYUGAIKBN
           MOVE    LNK-SKYGET-SRYYM      TO   SYU-SRYYMD(1:6)
           MOVE    "__"                  TO   SYU-SRYYMD(7:2)
           MOVE    SYUNOU-REC            TO   MCPDATA-REC
           MOVE    "tbl_syunou"          TO   MCP-TABLE
           MOVE    "key76"               TO   MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
           IF      MCP-RC   =   ZERO
             MOVE    "tbl_syunou"        TO   MCP-TABLE
             MOVE    "key76"             TO   MCP-PATHNAME
             PERFORM 900-SYUNOU-READ-SEC
             PERFORM    UNTIL   (FLG-SYUNOU   =   1)
               IF  SYU-DENPJTIKBN    NOT =  "3"
                 MOVE      1             TO   IDX2
                 PERFORM   20021-KINGAKU-HENSYU-SEC
               END-IF
               MOVE    "tbl_syunou"      TO   MCP-TABLE
               MOVE    "key76"           TO   MCP-PATHNAME
               PERFORM 900-SYUNOU-READ-SEC
             END-PERFORM
           END-IF
           MOVE    "tbl_syunou"          TO   MCP-TABLE
           MOVE    "key76"               TO   MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
      *    外来
           MOVE    ZERO                  TO   FLG-SYUKEI
           INITIALIZE                         WRK-TAIHI-AREA
           INITIALIZE                         WRK-TAIHI-AREA2
           INITIALIZE                         SYUNOU-REC
           MOVE    SPA-HOSPNUM           TO   SYU-HOSPNUM
           MOVE    "2"                   TO   SYU-NYUGAIKBN
           MOVE    LNK-SKYGET-SRYYM      TO   SYU-SRYYMD(1:6)
           MOVE    "__"                  TO   SYU-SRYYMD(7:2)
           MOVE    SYUNOU-REC            TO   MCPDATA-REC
           MOVE    "tbl_syunou"          TO   MCP-TABLE
           MOVE    "key75"               TO   MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
           IF      MCP-RC   =   ZERO
             MOVE    "tbl_syunou"        TO   MCP-TABLE
             MOVE    "key75"             TO   MCP-PATHNAME
             PERFORM 900-SYUNOU-READ-SEC
             PERFORM    UNTIL   (FLG-SYUNOU   =   1)
               IF  SYU-DENPJTIKBN    NOT =  "3"
                 MOVE      2             TO   IDX2
                 PERFORM   20021-KINGAKU-HENSYU-SEC
               END-IF
               MOVE    "tbl_syunou"      TO   MCP-TABLE
               MOVE    "key75"           TO   MCP-PATHNAME
               PERFORM 900-SYUNOU-READ-SEC
             END-PERFORM
           END-IF
           MOVE    "tbl_syunou"          TO   MCP-TABLE
           MOVE    "key75"               TO   MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
      *    入院（本収納）
           MOVE    ZERO                  TO   FLG-SYUKEI
           INITIALIZE                         WRK-TAIHI-AREA
           INITIALIZE                         WRK-TAIHI-AREA2
           INITIALIZE                         SYUNOU-REC
           MOVE    SPA-HOSPNUM           TO   SYU-HOSPNUM
           MOVE    "1"                   TO   SYU-NYUGAIKBN
           MOVE    LNK-SKYGET-SRYYM      TO   SYU-SRYYMD(1:6)
           MOVE    "__"                  TO   SYU-SRYYMD(7:2)
           MOVE    SYUNOU-REC            TO   MCPDATA-REC
           MOVE    "tbl_syunou"          TO   MCP-TABLE
           MOVE    "key75"               TO   MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
           IF      MCP-RC   =   ZERO
             MOVE    "tbl_syunou"        TO   MCP-TABLE
             MOVE    "key75"             TO   MCP-PATHNAME
             PERFORM 900-SYUNOU-READ-SEC
             PERFORM    UNTIL   (FLG-SYUNOU   =   1)
               IF  SYU-DENPJTIKBN    NOT =  "3"
                 MOVE      3             TO   IDX2
                 PERFORM   20021-KINGAKU-HENSYU-SEC
               END-IF
               MOVE    "tbl_syunou"      TO   MCP-TABLE
               MOVE    "key75"           TO   MCP-PATHNAME
               PERFORM 900-SYUNOU-READ-SEC
             END-PERFORM
           END-IF
           MOVE    "tbl_syunou"          TO   MCP-TABLE
           MOVE    "key75"               TO   MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       2002-HENSYU2-EXT.
           EXIT.
      *
      *****************************************************************
      *    区分”２”（金額編集）
      *****************************************************************
       20021-KINGAKU-HENSYU-SEC            SECTION.
      *
      *    インデックス編集
           PERFORM   200211-INDEX-HENSYU-SEC
      *
           IF  (WRK-TAIHI-PTID         =  SYU-PTID       )
           AND (WRK-TAIHI-HKNCOMBINUM  =  SYU-HKNCOMBINUM)
             CONTINUE
           ELSE
             MOVE   1                TO    FLG-SYUKEI
             INITIALIZE                    WRK-TAIHI-AREA
             MOVE   SYU-PTID         TO    WRK-TAIHI-PTID
             MOVE   SYU-HKNCOMBINUM  TO    WRK-TAIHI-HKNCOMBINUM
             INITIALIZE                    WRK-TAIHI-AREA2
           END-IF
      *
           MOVE     ZERO     TO    FLG-JIHIRANSYUKEI
           IF  (SYU-TOTAL-HKNTEN      =  ZERO)
           AND (SYU-TOTAL-MONEY   NOT =  ZERO)
           AND (IDX1                  =   5  )
           AND (SYU-JYO-COMPFTN   NOT =  ZERO)
           AND (LNK-SKYGET-SRYYM  >=   201103)
             MOVE    1       TO    FLG-JIHIRANSYUKEI
           END-IF
      *
           IF  (SYU-TOTAL-HKNTEN      =  ZERO)
           AND (IDX1                  =   5  )
           AND (SYU-JYO-COMPFTN       =  ZERO)
           AND (LNK-SKYGET-SRYYM  >=   201103)
      *      入院（仮収納）のDISPLAYがでてなくて、
      *      入院（本収納）のDISPLAYがでていたら、
      *      入院（本収納）の再処理が必要となる。
             DISPLAY   "*******"
             DISPLAY   "NYUGAIKBN=" SYU-NYUGAIKBN
             DISPLAY   "IDX2="      IDX2
             DISPLAY   "SRYYM="     LNK-SKYGET-SRYYM
             INITIALIZE             ORCSPTIDAREA
             MOVE  SPA-HOSPNUM  TO  SPTID-HOSPNUM
             MOVE  SYU-PTID     TO  SPTID-PTID
             CALL "ORCSPTID"    USING   ORCSPTIDAREA
                                        SPA-AREA
             IF   SPTID-RC  =   ZERO
               DISPLAY "PTNUM="     SPTID-PTNUM
             END-IF
             DISPLAY   "PTID="      SYU-PTID
             DISPLAY   "DENPNUM="   SYU-DENPNUM
             DISPLAY   "*******"
           END-IF
      *
           IF   (IDX1  =   4  OR  5  OR  6)
           AND  (IDX2  =   1  OR  2       )
      *
             IF    FLG-SYUKEI   =   1
               IF  SYU-TOTAL-HKNTEN    NOT =  ZERO
               OR  SYU-RYOYOHI-SKJ     NOT =  ZERO
               OR  SYU-RYOYOHI-LIFE    NOT =  ZERO
               OR  FLG-JIHIRANSYUKEI       =   1
                 COMPUTE  LNK-SKYGET-KENSU(IDX1 IDX2) =
                          LNK-SKYGET-KENSU(IDX1 IDX2) +
                          1
                 MOVE     ZERO    TO    FLG-SYUKEI
               END-IF
             END-IF
      *
             IF    SYU-TOTAL-HKNTEN    NOT =  ZERO
             OR    FLG-JIHIRANSYUKEI       =   1
               EVALUATE  SYU-NYUGAIKBN
                 WHEN      "1"
                   PERFORM   VARYING   IDX3   FROM  1  BY  1
                              UNTIL    IDX3    >   31
                     IF  (SYU-DAY(IDX3)        =  "1" OR "2")
                     AND (WRK-TAIHI-DAY(IDX3)  =  ZERO      )
                       COMPUTE  LNK-SKYGET-IRYO2-NISSU(IDX1 IDX2) =
                                LNK-SKYGET-IRYO2-NISSU(IDX1 IDX2) +
                                1
                       MOVE       1     TO    WRK-TAIHI-DAY(IDX3)
                     END-IF
                   END-PERFORM
                 WHEN      "2"
                   MOVE   SYU-SRYYMD(7:2)   TO   IDX3
                   IF     WRK-TAIHI-DAY(IDX3)  =  ZERO
                       COMPUTE  LNK-SKYGET-IRYO2-NISSU(IDX1 IDX2) =
                                LNK-SKYGET-IRYO2-NISSU(IDX1 IDX2) +
                                1
                       MOVE       1     TO    WRK-TAIHI-DAY(IDX3)
                   END-IF
               END-EVALUATE
             END-IF
             IF    SYU-TOTAL-HKNTEN    NOT =  ZERO
               COMPUTE    LNK-SKYGET-IRYO2-TOTALTEN(IDX1 IDX2) =
                          LNK-SKYGET-IRYO2-TOTALTEN(IDX1 IDX2) +
                          SYU-TOTAL-HKNTEN
               IF    IDX1  =   4  OR  5
                 COMPUTE  LNK-SKYGET-IRYO2-ICHIBUFTN(IDX1 IDX2) =
                          LNK-SKYGET-IRYO2-ICHIBUFTN(IDX1 IDX2) +
                          SYU-HKNTEKMONEY
               ELSE
                 COMPUTE  LNK-SKYGET-IRYO2-HOKENJA(IDX1 IDX2) =
                          LNK-SKYGET-IRYO2-HOKENJA(IDX1 IDX2) +
                          SYU-HKNTEKMONEY
               END-IF
             ELSE
               IF    FLG-JIHIRANSYUKEI   =   1
                 COMPUTE    LNK-SKYGET-IRYO2-TOTALTEN(IDX1 IDX2) =
                            LNK-SKYGET-IRYO2-TOTALTEN(IDX1 IDX2) +
                            SYU-TOTAL-MONEY
                 COMPUTE    LNK-SKYGET-IRYO2-ICHIBUFTN(IDX1 IDX2) =
                            LNK-SKYGET-IRYO2-ICHIBUFTN(IDX1 IDX2) +
                            SYU-JYO-COMPFTN
               END-IF
             END-IF
      *
             COMPUTE    LNK-SKYGET-SKJ2-KAISU(IDX1 IDX2) =
                        LNK-SKYGET-SKJ2-KAISU(IDX1 IDX2) +
                        SYU-SYUSKJ-NISSU
             COMPUTE    LNK-SKYGET-SKJ2-RYOYOHI(IDX1 IDX2) =
                        LNK-SKYGET-SKJ2-RYOYOHI(IDX1 IDX2) +
                        SYU-RYOYOHI-SKJ                    +
                        SYU-RYOYOHI-LIFE
             IF    IDX1  =   4  OR  5
               COMPUTE  LNK-SKYGET-SKJ2-ICHIBUFTN(IDX1 IDX2) =
                        LNK-SKYGET-SKJ2-ICHIBUFTN(IDX1 IDX2) +
                        SYU-SKYMONEY-SKJ-KEI                 +
                        SYU-SKYMONEY-LIFE-KEI
             ELSE
               COMPUTE  LNK-SKYGET-SKJ2-HOKENJA(IDX1 IDX2) =
                        LNK-SKYGET-SKJ2-HOKENJA(IDX1 IDX2) +
                        SYU-SKYMONEY-SKJ-KEI               +
                        SYU-SKYMONEY-LIFE-KEI
             END-IF
      *
           END-IF
      *
           IF   (IDX1  =   7  OR  8  OR  9)
           AND  (IDX2  =   1  OR  2       )
      *
             COMPUTE    WRK-KEISAN                 =
                        SYU-SYUSKJ-RYOYOHI         +
                        SYU-RMSAGAKU               +
                        SYU-SKYMONEY-SKJ-JIHI-KEI  +
                        SYU-SKYMONEY-LIFE-JIHI-KEI +
                        SYU-TOTAL-TGMONEY          +
                        SYU-TOTAL-TGMONEY-TAX      +
                        SYU-JIHI-TOTAL             +
                        SYU-JIHI-TOTAL-TAX
             COMPUTE    WRK-KEISAN2           =
                        SYU-RSIJIBAI-SKYMONEY -
                        WRK-KEISAN
      *
             IF    FLG-SYUKEI   =   1
               IF  WRK-KEISAN2         NOT =  ZERO
               OR  SYU-SYUSKJ-RYOYOHI  NOT =  ZERO
                 COMPUTE  LNK-SKYGET-KENSU(IDX1 IDX2) =
                          LNK-SKYGET-KENSU(IDX1 IDX2) +
                          1
                 MOVE     ZERO    TO    FLG-SYUKEI
               END-IF
             END-IF
      *
             IF    WRK-KEISAN2  NOT =  ZERO
               EVALUATE  SYU-NYUGAIKBN
                 WHEN      "1"
                   PERFORM   VARYING   IDX3   FROM  1  BY  1
                              UNTIL    IDX3    >   31
                     IF  (SYU-DAY(IDX3)        =  "1" OR "2")
                     AND (WRK-TAIHI-DAY(IDX3)  =  ZERO      )
                       COMPUTE  LNK-SKYGET-IRYO2-NISSU(IDX1 IDX2) =
                                LNK-SKYGET-IRYO2-NISSU(IDX1 IDX2) +
                                1
                       MOVE       1     TO    WRK-TAIHI-DAY(IDX3)
                     END-IF
                   END-PERFORM
                 WHEN      "2"
                   MOVE   SYU-SRYYMD(7:2)   TO   IDX3
                   IF     WRK-TAIHI-DAY(IDX3)  =  ZERO
                       COMPUTE  LNK-SKYGET-IRYO2-NISSU(IDX1 IDX2) =
                                LNK-SKYGET-IRYO2-NISSU(IDX1 IDX2) +
                                1
                       MOVE       1     TO    WRK-TAIHI-DAY(IDX3)
                   END-IF
               END-EVALUATE
             END-IF
             COMPUTE    LNK-SKYGET-IRYO2-TOTALTEN(IDX1 IDX2) =
                        LNK-SKYGET-IRYO2-TOTALTEN(IDX1 IDX2) +
                        SYU-TOTAL-HKNTEN
             IF    SYU-PTFTNRATE    =  100
               COMPUTE  LNK-SKYGET-IRYO2-ICHIBUFTN(IDX1 IDX2) =
                        LNK-SKYGET-IRYO2-ICHIBUFTN(IDX1 IDX2) +
                        WRK-KEISAN2
             ELSE
               COMPUTE  LNK-SKYGET-IRYO2-HOKENJA(IDX1 IDX2) =
                        LNK-SKYGET-IRYO2-HOKENJA(IDX1 IDX2) +
                        WRK-KEISAN2
             END-IF
      *
             COMPUTE    LNK-SKYGET-SKJ2-KAISU(IDX1 IDX2) =
                        LNK-SKYGET-SKJ2-KAISU(IDX1 IDX2) +
                        SYU-SYUSKJ-NISSU
             COMPUTE    LNK-SKYGET-SKJ2-RYOYOHI(IDX1 IDX2) =
                        LNK-SKYGET-SKJ2-RYOYOHI(IDX1 IDX2) +
                        SYU-SYUSKJ-RYOYOHI
             IF    SYU-PTFTNRATE    =  100
               COMPUTE  LNK-SKYGET-SKJ2-ICHIBUFTN(IDX1 IDX2) =
                        LNK-SKYGET-SKJ2-ICHIBUFTN(IDX1 IDX2) +
                        SYU-SYUSKJ-RYOYOHI
             ELSE
               COMPUTE  LNK-SKYGET-SKJ2-HOKENJA(IDX1 IDX2) =
                        LNK-SKYGET-SKJ2-HOKENJA(IDX1 IDX2) +
                        SYU-SYUSKJ-RYOYOHI
             END-IF
      *
           END-IF
      *
      ***
      *
           COMPUTE      LNK-SKYGET-JIHI(IDX1 IDX2) =
                        LNK-SKYGET-JIHI(IDX1 IDX2) +
                        SYU-RMSAGAKU               +
                        SYU-SKYMONEY-SKJ-JIHI-KEI  +
                        SYU-SKYMONEY-LIFE-JIHI-KEI +
                        SYU-TOTAL-TGMONEY          +
                        SYU-TOTAL-TGMONEY-TAX      +
                        SYU-JIHI-TOTAL             +
                        SYU-JIHI-TOTAL-TAX
      *
           IF    FLG-JIHIRANSYUKEI   =   1
             COMPUTE    LNK-SKYGET-JIHI(IDX1 IDX2) =
                        LNK-SKYGET-JIHI(IDX1 IDX2) -
                        SYU-JYO-COMPFTN
           END-IF
      *
           COMPUTE      WRK-KEISAN2        =
                        SYU-DISCOUNT-MONEY *
                        -1
           COMPUTE      LNK-SKYGET-DISCOUNT-MONEY(IDX1 IDX2) =
                        LNK-SKYGET-DISCOUNT-MONEY(IDX1 IDX2) +
                        WRK-KEISAN2
      *
           COMPUTE      LNK-SKYGET-CHOSEI (IDX1 IDX2) =
                        LNK-SKYGET-CHOSEI (IDX1 IDX2) +
                        SYU-CHOSEI
      *
           COMPUTE      LNK-SKYGET-CHOSEI1(IDX1 IDX2) =
                        LNK-SKYGET-CHOSEI1(IDX1 IDX2) +
                        SYU-CHOSEI1
      *
           COMPUTE      LNK-SKYGET-CHOSEI2(IDX1 IDX2) =
                        LNK-SKYGET-CHOSEI2(IDX1 IDX2) +
                        SYU-CHOSEI2
      *
           IF    IDX1  =   7  OR  8  OR  9
             IF   SYU-PTFTNRATE   =  100
               COMPUTE  WRK-KEISAN            =
                        SYU-RSIJIBAI-SKYMONEY -
                        SYU-DISCOUNT-MONEY    +
                        SYU-CHOSEI
             ELSE
               COMPUTE  WRK-KEISAN                 =
                        SYU-RMSAGAKU               +
                        SYU-SKYMONEY-SKJ-JIHI-KEI  +
                        SYU-SKYMONEY-LIFE-JIHI-KEI +
                        SYU-TOTAL-TGMONEY          +
                        SYU-TOTAL-TGMONEY-TAX      +
                        SYU-JIHI-TOTAL             +
                        SYU-JIHI-TOTAL-TAX         -
                        SYU-DISCOUNT-MONEY         +
                        SYU-CHOSEI
             END-IF
           ELSE
             COMPUTE    WRK-KEISAN                 =
                        SYU-HKNTEKMONEY            +
                        SYU-KOH-FTN                +
                        SYU-SKYMONEY-SKJ-KEI       +
                        SYU-SKYMONEY-LIFE-KEI      +
                        SYU-RMSAGAKU               +
                        SYU-SKYMONEY-SKJ-JIHI-KEI  +
                        SYU-SKYMONEY-LIFE-JIHI-KEI +
                        SYU-TOTAL-TGMONEY          +
                        SYU-TOTAL-TGMONEY-TAX      +
                        SYU-JIHI-TOTAL             +
                        SYU-JIHI-TOTAL-TAX         -
                        SYU-DISCOUNT-MONEY         +
                        SYU-CHOSEI
           END-IF
           COMPUTE      WRK-KEISAN2  =
                        SYU-SKYMONEY -
                        WRK-KEISAN
           COMPUTE      LNK-SKYGET-HASU(IDX1 IDX2) =
                        LNK-SKYGET-HASU(IDX1 IDX2) +
                        WRK-KEISAN2
      *
           .
       20021-KINGAKU-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    区分”２”（インデックス編集）
      *****************************************************************
       200211-INDEX-HENSYU-SEC            SECTION.
      *
           MOVE      ZERO            TO    IDX1
      *    自費保険
           IF    SYU-SYUHKNNUM(1:2)   =   "98"
              MOVE     5             TO    IDX1
           END-IF
      *    治験
           IF    SYU-SYUHKNNUM(1:2)   =   "90" OR "91"
              MOVE     6             TO    IDX1
           END-IF
      *    労災
           IF    SYU-SYUHKNNUM        =   "971"
              MOVE     7             TO    IDX1
           END-IF
      *    自賠責
           IF    SYU-SYUHKNNUM        =   "973"
              MOVE     8             TO    IDX1
           END-IF
      *    公害
           IF    SYU-SYUHKNNUM        =   "975"
              MOVE     9             TO    IDX1
           END-IF
      *    国保
           IF    SYU-SYUHKNNUM   =  "060" OR "067"
              MOVE     2             TO    IDX1
           END-IF
      *    後期高齢
           IF    SYU-SYUHKNNUM   =  "039"
              MOVE     3             TO    IDX1
           END-IF
      *    特別療養費
           IF    SYU-SYUHKNNUM   =  "068" OR "069" OR "040"
              MOVE     4             TO    IDX1
           END-IF
      *    社保
           IF    IDX1   =   ZERO
              MOVE     1             TO    IDX1
           END-IF
      *
           .
       200211-INDEX-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納読込
      *****************************************************************
       900-SYUNOU-READ-SEC           SECTION.
      *
           PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
               MOVE    ZERO            TO  FLG-SYUNOU
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
           .
       900-SYUNOU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費請求検索
      *****************************************************************
       900-KOHSKY-READ-SEC        SECTION.
      *
           MOVE    KOHSKY-REC           TO  MCPDATA-REC
           MOVE    "tbl_kohsky"         TO  MCP-TABLE
           MOVE    "key"                TO  MCP-PATHNAME
           MOVE    "DBSELECT"           TO  MCP-FUNC
           CALL    "ORCDBMAIN"          USING   MCPAREA
                                                MCPDATA-REC
                                                SPA-AREA
           IF      MCP-RC               =   ZERO
               MOVE    "tbl_kohsky"     TO  MCP-TABLE
               MOVE    "key"            TO  MCP-PATHNAME
               MOVE    "DBFETCH"        TO  MCP-FUNC
               CALL    "ORCDBMAIN"      USING   MCPAREA
                                                MCPDATA-REC
                                                SPA-AREA
               IF      MCP-RC           =   ZERO
                   MOVE    MCPDATA-REC  TO  KOHSKY-REC
                   MOVE    ZERO         TO  FLG-KOHSKY
               ELSE
                   INITIALIZE               KOHSKY-REC
                   MOVE    1            TO  FLG-KOHSKY
               END-IF
           ELSE
               INITIALIZE                   KOHSKY-REC
               MOVE    1                TO  FLG-KOHSKY
           END-IF
           MOVE    "tbl_kohsky"         TO  MCP-TABLE
           MOVE    "key"                TO  MCP-PATHNAME
           PERFORM  900-CLOSE-SEC
      *
           .
       900-KOHSKY-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＳＥＬＥＣＴ処理
      *****************************************************************
       900-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
           IF      MCP-RC              =   ZERO
               CONTINUE
           ELSE
               DISPLAY "SELECT ERR table=" MCP-TABLE
                       " pathname="        MCP-PATHNAME
           END-IF
      *
           .
       900-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＦＥＴＣＨ処理
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
      *    テーブルクローズ処理
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
      *    テーブルアクセス処理
      *****************************************************************
       900-ORCDBMAIN-SEC               SECTION.
      *
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
      *
       900-ORCDBMAIN-EXT.
           EXIT.
      *
