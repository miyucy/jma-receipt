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
       PROGRAM-ID.             ORCSSYOTOKU.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : 患者所得情報編集
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
           03  FLG-TNKRRK            PIC 9(01).
           03  FLG-TSYRRK            PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                   PIC 9(02).
           03  IDX-ST                PIC 9(02).
           03  IDX-ED                PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-DAY-TABLE.
             05  WRK-DAY-T             OCCURS   31.
               07  WRK-DAY-SYU-TNK     PIC X(01).
               07  WRK-DAY-SYU-TSY     PIC X(01).
               07  WRK-DAY-CHI-TNK     PIC X(01).
               07  WRK-DAY-CHI-TSY     PIC X(01).
               07  WRK-DAY-SKJ-TNK     PIC X(01).
               07  WRK-DAY-SKJ-TSY     PIC X(01).
      *
           03  WRK-SYOTOKU-YMD.
               05  WRK-SYOTOKU-YM      PIC 9(06).
               05  WRK-SYOTOKU-DD      PIC 9(02).
      *
      *    固定値
       01  WRK-CONS-AREA.
      *
           03  WRK-CONS-SRYYM-200610   PIC 9(06)   VALUE   200610.
           03  WRK-CONS-SRYYM-200604   PIC 9(06)   VALUE   200604.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    共通領域
           COPY    "MCPAREA".
      *
      *    低１
       01  TNKRRK-REC.
           COPY    "CPTNKRRK.INC".
      *
      *    低２
       01  TSYRRK-REC.
           COPY    "CPTSYRRK.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
           COPY    "MCPDATA.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPORCSSYOTOKU.INC".
           COPY    "COMMON-SPA".
      *
       PROCEDURE                    DIVISION    USING
           ORCSSYOTOKUAREA
           SPA-AREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                 SECTION.
      *
           MOVE    ZERO                TO  LNK-SYOTOKU-RC
           INITIALIZE                      LNK-SYOTOKU-HENKYAKU-AREA
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
      *    パラメータチェック
           PERFORM   100-PRM-CHK-SEC
           IF    LNK-SYOTOKU-RC   NOT =   ZERO
               GO   TO   000-PROC-EXT
           END-IF
      *
           IF    LNK-SYOTOKU-RC       =   ZERO
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
      *    パラメータチェック
      *****************************************************************
       100-PRM-CHK-SEC                     SECTION.
      *
      *    処理年月チェック
           IF      LNK-SYOTOKU-SRYYM    =   SPACE
               MOVE    1                 TO  LNK-SYOTOKU-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *    患者ＩＤチェック
           IF      LNK-SYOTOKU-PTID     =   ZERO
               MOVE    2                 TO  LNK-SYOTOKU-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
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
      *    低１
           INITIALIZE                        TNKRRK-REC
           MOVE    LNK-SYOTOKU-HOSPNUM   TO  TNKRRK-HOSPNUM
           MOVE    LNK-SYOTOKU-PTID      TO  TNKRRK-PTID
           MOVE    TNKRRK-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"            TO  MCP-FUNC
           MOVE    "tbl_tnkrrk"          TO  MCP-TABLE
           MOVE    "key3"                TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"           USING   MCPAREA
                                                 MCPDATA-REC
                                                 SPA-AREA
           IF      MCP-RC                =   ZERO
              MOVE   "tbl_tnkrrk"        TO  MCP-TABLE
              MOVE   "key3"              TO  MCP-PATHNAME
              PERFORM 910-TNKRRK-READ-SEC
              PERFORM   UNTIL
                     (FLG-TNKRRK         =      1             ) OR
                     (TNKRRK-EDYMD(1:6)  <   LNK-SYOTOKU-SRYYM)
                 IF  (TNKRRK-STYMD(1:6)  <=  LNK-SYOTOKU-SRYYM)
                 AND (LNK-SYOTOKU-SRYYM  <=  TNKRRK-EDYMD(1:6))
                   IF LNK-SYOTOKU-SRYYM  >=  WRK-CONS-SRYYM-200604
                      PERFORM  210-TNK-HENSYU-SEC
                   ELSE
                      PERFORM  211-TNK-HENSYU2-SEC
                   END-IF
                 END-IF
                 MOVE   "tbl_tnkrrk"     TO  MCP-TABLE
                 MOVE   "key3"           TO  MCP-PATHNAME
                 PERFORM 910-TNKRRK-READ-SEC
              END-PERFORM
           ELSE
              MOVE    3                  TO  LNK-SYOTOKU-RC
           END-IF
           MOVE     "tbl_tnkrrk"         TO  MCP-TABLE
           MOVE     "key3"               TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
      *
      *    低２
           INITIALIZE                        TSYRRK-REC
           MOVE    LNK-SYOTOKU-HOSPNUM   TO  TSYRRK-HOSPNUM
           MOVE    LNK-SYOTOKU-PTID      TO  TSYRRK-PTID
           MOVE    TSYRRK-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"            TO  MCP-FUNC
           MOVE    "tbl_tsyrrk"          TO  MCP-TABLE
           MOVE    "key3"                TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"           USING   MCPAREA
                                                 MCPDATA-REC
                                                 SPA-AREA
           IF      MCP-RC              =   ZERO
              MOVE   "tbl_tsyrrk"        TO  MCP-TABLE
              MOVE   "key3"              TO  MCP-PATHNAME
              PERFORM 910-TSYRRK-READ-SEC
              PERFORM   UNTIL
                     (FLG-TSYRRK            =      1             ) OR
                     (TSYRRK-NINEDYMD(1:6)  <   LNK-SYOTOKU-SRYYM)
                 IF  (TSYRRK-NINSTYMD(1:6)  <=  LNK-SYOTOKU-SRYYM   )
                 AND (LNK-SYOTOKU-SRYYM     <=  TSYRRK-NINEDYMD(1:6))
                   IF LNK-SYOTOKU-SRYYM     >=  WRK-CONS-SRYYM-200604
                      PERFORM  220-TSY-HENSYU-SEC
                   ELSE
                      PERFORM  221-TSY-HENSYU2-SEC
                   END-IF
                 END-IF
                 MOVE   "tbl_tsyrrk"     TO  MCP-TABLE
                 MOVE   "key3"           TO  MCP-PATHNAME
                 PERFORM 910-TSYRRK-READ-SEC
              END-PERFORM
           ELSE
              MOVE    4                  TO  LNK-SYOTOKU-RC
           END-IF
           MOVE     "tbl_tsyrrk"         TO  MCP-TABLE
           MOVE     "key3"               TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
      *
      *    結果編集
           IF        LNK-SYOTOKU-RC      =   ZERO
      *
             PERFORM   VARYING   IDX     FROM    1   BY  1
                        UNTIL    IDX      >     31
      *
              EVALUATE WRK-DAY-SYU-TSY(IDX) ALSO WRK-DAY-SYU-TNK(IDX)
                 WHEN    SPACE              ALSO    SPACE
                       MOVE   SPACE   TO    LNK-SYOTOKU-SYUKBN(IDX)
                 WHEN    SPACE              ALSO    "1"
                       MOVE   "1"     TO    LNK-SYOTOKU-SYUKBN(IDX)
                 WHEN    SPACE              ALSO    "4"
                       MOVE   "4"     TO    LNK-SYOTOKU-SYUKBN(IDX)
                 WHEN    "2"                ALSO    SPACE
                       MOVE   "2"     TO    LNK-SYOTOKU-SYUKBN(IDX)
                 WHEN    "2"                ALSO    "1"
                       MOVE   "1"     TO    LNK-SYOTOKU-SYUKBN(IDX)
                 WHEN    "2"                ALSO    "4"
                       MOVE   "4"     TO    LNK-SYOTOKU-SYUKBN(IDX)
              END-EVALUATE
      *
              EVALUATE WRK-DAY-CHI-TSY(IDX) ALSO WRK-DAY-CHI-TNK(IDX)
                 WHEN    SPACE              ALSO    SPACE
                       MOVE   SPACE   TO    LNK-SYOTOKU-CHIKBN(IDX)
                 WHEN    SPACE              ALSO    "1"
                       MOVE   "1"     TO    LNK-SYOTOKU-CHIKBN(IDX)
                 WHEN    "2"                ALSO    SPACE
                       MOVE   "2"     TO    LNK-SYOTOKU-CHIKBN(IDX)
                 WHEN    "2"                ALSO    "1"
                       MOVE   "1"     TO    LNK-SYOTOKU-CHIKBN(IDX)
              END-EVALUATE
      *
              EVALUATE WRK-DAY-SKJ-TSY(IDX) ALSO WRK-DAY-SKJ-TNK(IDX)
                 WHEN    SPACE              ALSO    SPACE
                       MOVE   SPACE   TO    LNK-SYOTOKU-SKJKBN(IDX)
                 WHEN    SPACE              ALSO    "1"
                       MOVE   "1"     TO    LNK-SYOTOKU-SKJKBN(IDX)
                 WHEN    SPACE              ALSO    "4"
                       MOVE   "4"     TO    LNK-SYOTOKU-SKJKBN(IDX)
                 WHEN    "2"                ALSO    SPACE
                       MOVE   "2"     TO    LNK-SYOTOKU-SKJKBN(IDX)
                 WHEN    "2"                ALSO    "1"
                       MOVE   "1"     TO    LNK-SYOTOKU-SKJKBN(IDX)
                 WHEN    "2"                ALSO    "4"
                       MOVE   "4"     TO    LNK-SYOTOKU-SKJKBN(IDX)
                 WHEN    "3"                ALSO    SPACE
                       MOVE   "3"     TO    LNK-SYOTOKU-SKJKBN(IDX)
                 WHEN    "3"                ALSO    "1"
                       MOVE   "1"     TO    LNK-SYOTOKU-SKJKBN(IDX)
                 WHEN    "3"                ALSO    "4"
                       MOVE   "4"     TO    LNK-SYOTOKU-SKJKBN(IDX)
              END-EVALUATE
      *
             END-PERFORM
      *
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    低１編集
      *****************************************************************
       210-TNK-HENSYU-SEC            SECTION.
      *
           IF   TNKRRK-STYMD(1:6)  <  LNK-SYOTOKU-SRYYM
               MOVE    1                   TO   IDX-ST
           ELSE
               MOVE    TNKRRK-STYMD(7:2)   TO   IDX-ST
           END-IF
           IF   LNK-SYOTOKU-SRYYM  <  TNKRRK-EDYMD(1:6)
               MOVE    31                  TO   IDX-ED
           ELSE
               MOVE    TNKRRK-EDYMD(7:2)   TO   IDX-ED
           END-IF
      *
           PERFORM   VARYING   IDX     FROM   IDX-ST   BY  1
                      UNTIL    IDX      >     IDX-ED
      *
              MOVE    LNK-SYOTOKU-SRYYM    TO  WRK-SYOTOKU-YM
              MOVE    IDX                  TO  WRK-SYOTOKU-DD
      *
              IF    TNKRRK-HKNTEKKBN  = "0" OR "1"
                 MOVE    "1"     TO    WRK-DAY-SYU-TNK(IDX)
                 IF  (LNK-SYOTOKU-SRYYM    >=  WRK-CONS-SRYYM-200610 )
                 AND (TNKRRK-RRI-FUKUSHI-KBN  =   "1"                )
                     MOVE  "4"   TO    WRK-DAY-SYU-TNK(IDX)
                 END-IF
              END-IF
      *
              IF    TNKRRK-HKNTEKKBN  = "0" OR "2"
                 MOVE    "1"     TO    WRK-DAY-CHI-TNK(IDX)
              END-IF
      *
              IF  (TNKRRK-HKNTEKKBN         = "0" OR "1"      )
              AND (TNKRRK-SKJNINSTYMD   NOT =  SPACE          )
              AND (TNKRRK-SKJNINSTYMD      <=  WRK-SYOTOKU-YMD)
              AND (TNKRRK-EDYMD            >=  WRK-SYOTOKU-YMD)
                 MOVE    "1"     TO    WRK-DAY-SKJ-TNK(IDX)
                 IF  (LNK-SYOTOKU-SRYYM    >=  WRK-CONS-SRYYM-200610 )
                 AND (TNKRRK-RRI-FUKUSHI-KBN  =   "1"                )
                     MOVE  "4"   TO    WRK-DAY-SKJ-TNK(IDX)
                 END-IF
              END-IF
      *
           END-PERFORM
      *
           .
       210-TNK-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    低２編集
      *****************************************************************
       220-TSY-HENSYU-SEC            SECTION.
      *
           IF   TSYRRK-NINSTYMD(1:6)  <  LNK-SYOTOKU-SRYYM
               MOVE    1                      TO   IDX-ST
           ELSE
               MOVE    TSYRRK-NINSTYMD(7:2)   TO   IDX-ST
           END-IF
           IF   LNK-SYOTOKU-SRYYM     <  TSYRRK-NINEDYMD(1:6)
               MOVE    31                     TO   IDX-ED
           ELSE
               MOVE    TSYRRK-NINEDYMD(7:2)   TO   IDX-ED
           END-IF
      *
           PERFORM   VARYING   IDX     FROM   IDX-ST   BY  1
                      UNTIL    IDX      >     IDX-ED
      *
              MOVE    LNK-SYOTOKU-SRYYM    TO  WRK-SYOTOKU-YM
              MOVE    IDX                  TO  WRK-SYOTOKU-DD
      *
              IF    TSYRRK-HKNTEKKBN  = "0" OR "1"
                 MOVE    "2"     TO    WRK-DAY-SYU-TSY(IDX)
              END-IF
      *
              IF    TSYRRK-HKNTEKKBN  = "0" OR "2"
                 MOVE    "2"     TO    WRK-DAY-CHI-TSY(IDX)
              END-IF
      *
              IF  (TSYRRK-HKNTEKKBN         = "0" OR "1"      )
              AND (TSYRRK-SKJNINSTYMD   NOT =  SPACE          )
              AND (TSYRRK-SKJNINSTYMD      <=  WRK-SYOTOKU-YMD)
              AND (TSYRRK-NINEDYMD         >=  WRK-SYOTOKU-YMD)
                 MOVE    "2"     TO    WRK-DAY-SKJ-TSY(IDX)
                 IF  (TSYRRK-SKJGNSTYMD NOT =  SPACE          )
                 AND (TSYRRK-SKJGNSTYMD    <=  WRK-SYOTOKU-YMD)
                 AND (TSYRRK-NINEDYMD      >=  WRK-SYOTOKU-YMD)
                   MOVE  "3"     TO    WRK-DAY-SKJ-TSY(IDX)
                 END-IF
              END-IF
      *
           END-PERFORM
      *
           .
       220-TSY-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    低１編集（２００６年３月まで）
      *****************************************************************
       211-TNK-HENSYU2-SEC            SECTION.
      *
           MOVE    LNK-SYOTOKU-SRYYM    TO  WRK-SYOTOKU-YM
           MOVE    01                   TO  WRK-SYOTOKU-DD
      *
           IF  (TNKRRK-STYMD     <=  WRK-SYOTOKU-YMD)
           AND (WRK-SYOTOKU-YMD  <=  TNKRRK-EDYMD   )
      *
              PERFORM   VARYING   IDX     FROM    1   BY  1
                         UNTIL    IDX      >     31
                  MOVE    "1"     TO    WRK-DAY-SYU-TNK(IDX)
                  MOVE    "1"     TO    WRK-DAY-CHI-TNK(IDX)
                  MOVE    "1"     TO    WRK-DAY-SKJ-TNK(IDX)
              END-PERFORM
      *
           END-IF
      *
           .
       211-TNK-HENSYU2-EXT.
           EXIT.
      *
      *****************************************************************
      *    低２編集（２００６年３月まで）
      *****************************************************************
       221-TSY-HENSYU2-SEC            SECTION.
      *
           MOVE    LNK-SYOTOKU-SRYYM    TO  WRK-SYOTOKU-YM
           MOVE    01                   TO  WRK-SYOTOKU-DD
      *
           IF  (TSYRRK-NINSTYMD  <=  WRK-SYOTOKU-YMD)
           AND (WRK-SYOTOKU-YMD  <=  TSYRRK-NINEDYMD)
      *
              PERFORM   VARYING   IDX     FROM    1   BY  1
                         UNTIL    IDX      >     31
      *
                  MOVE    "2"     TO    WRK-DAY-SYU-TSY(IDX)
                  MOVE    "2"     TO    WRK-DAY-CHI-TSY(IDX)
      *
                  MOVE    "2"     TO    WRK-DAY-SKJ-TSY(IDX)
                  IF  (TSYRRK-SKJGNSTYMD NOT =  SPACE          )
                  AND (TSYRRK-SKJGNSTYMD    <=  WRK-SYOTOKU-YMD)
                  AND (TSYRRK-NINEDYMD      >=  WRK-SYOTOKU-YMD)
                    MOVE  "3"     TO    WRK-DAY-SKJ-TSY(IDX)
                  END-IF
      *
              END-PERFORM
      *
           END-IF
      *
           .
       221-TSY-HENSYU2-EXT.
           EXIT.
      *
      *****************************************************************
      *    低所得１マスタ読み込み
      *****************************************************************
       910-TNKRRK-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  TNKRRK-REC
               MOVE    ZERO            TO  FLG-TNKRRK
           ELSE
               INITIALIZE                  TNKRRK-REC
               MOVE    1               TO  FLG-TNKRRK
           END-IF
      *
           .
       910-TNKRRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    低所得２マスタ読み込み
      *****************************************************************
       910-TSYRRK-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  TSYRRK-REC
               MOVE    ZERO            TO  FLG-TSYRRK
           ELSE
               INITIALIZE                  TSYRRK-REC
               MOVE    1               TO  FLG-TSYRRK
           END-IF
      *
           .
       910-TSYRRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DB-CLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR"      TO  MCP-FUNC
           CALL    "ORCDBMAIN"          USING   MCPAREA
                                                MCPDATA-REC
                                                SPA-AREA
      *
           .
      *
       910-DB-CLOSE-EXT.
           EXIT.
