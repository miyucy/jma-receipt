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
       PROGRAM-ID.             ORCSS001.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 共通
      *  コンポーネント名  : 保険分類
      *  管理者            : 
      *  作成日付    作業者        記述
      *  06/07/14    NACL−太田    新規作成
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
       DATA                        DIVISION.
       FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
grpsys*
grpsys COPY    "COMMON-SPA".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-JYURRK          PIC 9(01).
           03  FLG-NYUINACCT       PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                PIC 9(05).
           03  IDX2                PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-COMB-HKNCOMBINUM    PIC 9(04).
      *
       01  TCOMBI-AREA.
           03  TCOMBI-MAX              PIC 9(05).
           03  TCOMBI-OCC              OCCURS  31.
               05  TCOMBI-HKNCOMBI     PIC 9(04).
      *
       01  CONST-AREA.
           03  CONST-ROUSAI            PIC X(03)   VALUE   "971".
           03  CONST-JIBAI             PIC X(03)   VALUE   "973".
           03  CONST-TCOMBI-MAX        PIC 9(05)   VALUE   31.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    入院診療会計マスター
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    保険組合せ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    受診履歴
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
           COPY    "MCPDATA.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY  "CPORCSS001.INC".
      *
       PROCEDURE                   DIVISION    USING
           SS001-AREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  SS001-HKNGRP-G
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           .
       000-PROC-EXT.
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           PERFORM 2001-HKNGRP-EDIT-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    患者情報編集処理
      *****************************************************************
       2001-HKNGRP-EDIT-SEC        SECTION.
      *
           PERFORM 20011-GAIHKN-EDIT-SEC
      *
           PERFORM 20011-NYUHKN-EDIT-SEC
      *
           .
       2001-HKNGRP-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    外来保険情報編集処理
      *****************************************************************
       20011-GAIHKN-EDIT-SEC           SECTION.
      *
           PERFORM 900-JYURRK-KEY37-SEL-SEC
      *
           PERFORM UNTIL ( FLG-JYURRK  NOT =   ZERO )
      *
               EVALUATE    JYURRK-NYUGAIKBN ALSO JYURRK-HKNKBN
               WHEN        "1"     ALSO "0"
                   MOVE    1           TO  SS001-NIHO-FLG
               WHEN        "1"     ALSO "1"
                   MOVE    1           TO  SS001-NRSI-FLG
               WHEN        "1"     ALSO "2"
               WHEN        "1"     ALSO "4"
                   MOVE    1           TO  SS001-NJBI-FLG
               WHEN        "2"     ALSO "0"
                   MOVE    1           TO  SS001-GIHO-FLG
               WHEN        "2"     ALSO "1"
                   MOVE    1           TO  SS001-GRSI-FLG
               WHEN        "2"     ALSO "2"
               WHEN        "2"     ALSO "4"
                   MOVE    1           TO  SS001-GJBI-FLG
               END-EVALUATE
      *
               PERFORM 900-JYURRK-KEY37-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_jyurrk"        TO  MCP-TABLE
           MOVE    "key37"             TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       20011-GAIHKN-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    入院保険情報編集処理
      *****************************************************************
       20011-NYUHKN-EDIT-SEC           SECTION.
      *
           PERFORM 900-NYUINACCT-KEY17-SEL-SEC
           IF    ( FLG-NYUINACCT       =   ZERO )
      *
               PERFORM 200111-TCOMBI-EDIT-SEC
      *
               PERFORM VARYING IDX1    FROM    1   BY  1
                       UNTIL ( IDX1    >   TCOMBI-MAX )
      *
                   MOVE    TCOMBI-HKNCOMBI (IDX1)
                                   TO  WRK-COMB-HKNCOMBINUM
                   PERFORM 900-HKNCOMBI-KEY-SEL-SEC
                   IF    ( FLG-HKNCOMBI    =   ZERO )
                       EVALUATE    COMB-HKNNUM
                       WHEN    CONST-ROUSAI
                           MOVE    1       TO  SS001-NRSI-FLG
                       WHEN    CONST-JIBAI
                           MOVE    1       TO  SS001-NJBI-FLG
                       WHEN    OTHER
                           MOVE    1       TO  SS001-NIHO-FLG
                       END-EVALUATE
                   END-IF
      *
               END-PERFORM
           END-IF
      *
           .
       20011-NYUHKN-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ退避領域編集処理
      *****************************************************************
       200111-TCOMBI-EDIT-SEC          SECTION.
      *
           INITIALIZE                  TCOMBI-AREA
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   31 )
      *
               IF    ( NACCT-DAY (IDX1)    >   ZERO )
      *
                   PERFORM VARYING IDX2    FROM    1   BY  1
                           UNTIL ( IDX2    >   TCOMBI-MAX )
                           OR    ( NACCT-DAY (IDX1)
                                           =   TCOMBI-HKNCOMBI (IDX2) )
      *
                       CONTINUE
      *
                   END-PERFORM
      *
                   IF    (     IDX2                >   TCOMBI-MAX )
                       IF    ( CONST-TCOMBI-MAX    >   TCOMBI-MAX )
                           COMPUTE TCOMBI-MAX  =   TCOMBI-MAX  +   1
                           MOVE    NACCT-DAY (IDX1)
                                           TO  TCOMBI-HKNCOMBI
                                                       (TCOMBI-MAX)
                       END-IF
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           .
       200111-TCOMBI-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                SECTION.
      *
      *
           .
       300-END-EXT.
           EXIT.
      *****************************************************************
      *    受診履歴検索処理
      *****************************************************************
       900-JYURRK-KEY37-SEL-SEC    SECTION.
      *
           MOVE    ZERO                TO  FLG-JYURRK
      *
           INITIALIZE                  JYURRK-REC
           MOVE    SS001-HOSPID        TO  JYURRK-HOSPID
           MOVE    SS001-PTID          TO  JYURRK-PTID
           STRING  SS001-SRYYM         DELIMITED   BY  SIZE
                   "%"                 DELIMITED   BY  SIZE
           INTO    JYURRK-SRYYMD
           END-STRING
grpsys*    MOVE SPA-HOSPNUM TO -HOSPNUM
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "tbl_jyurrk"        TO  MCP-TABLE
           MOVE    "key37"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  JYURRK-REC
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           .
       900-JYURRK-KEY37-SEL-EXT.
           EXIT.
      *****************************************************************
      *    受診履歴FETCH処理
      *****************************************************************
       900-JYURRK-KEY37-FET-SEC    SECTION.
      *
           MOVE    ZERO                TO  FLG-JYURRK
      *
           MOVE    "tbl_jyurrk"        TO  MCP-TABLE
           MOVE    "key37"             TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  JYURRK-REC
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           .
       900-JYURRK-KEY37-FET-EXT.
           EXIT.
      *****************************************************************
      *    入院会計検索処理(KEY17)
      *****************************************************************
       900-NYUINACCT-KEY17-SEL-SEC     SECTION.
      *
           MOVE    ZERO                TO  FLG-NYUINACCT
           INITIALIZE                  NYUINACCT-REC
      *
           MOVE    SS001-HOSPID        TO  NACCT-HOSPID
           MOVE    SS001-PTID          TO  NACCT-PTID
           MOVE    SS001-SRYYM         TO  NACCT-SRYYM
           MOVE    "1"                 TO  NACCT-NYUGAIKBN
           MOVE    "5"                 TO  NACCT-ZAISKBKBN
grpsys*    MOVE SPA-HOSPNUM TO -HOSPNUM
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "key17"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  NYUINACCT-REC
           ELSE
               MOVE    1               TO  FLG-NYUINACCT
               INITIALIZE                  NYUINACCT-REC
           END-IF
      *
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "key17"             TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-NYUINACCT-KEY17-SEL-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ取得処理
      *****************************************************************
       900-HKNCOMBI-KEY-SEL-SEC        SECTION.
      *
           MOVE    ZERO                    TO  FLG-HKNCOMBI
      *
           INITIALIZE                          HKNCOMBI-REC
           MOVE    SS001-HOSPID            TO  COMB-HOSPID
           MOVE    SS001-PTID              TO  COMB-PTID
           MOVE    WRK-COMB-HKNCOMBINUM    TO  COMB-HKNCOMBINUM
grpsys*    MOVE SPA-HOSPNUM TO -HOSPNUM
           MOVE    HKNCOMBI-REC            TO  MCPDATA-REC
           MOVE    "tbl_hkncombi"          TO  MCP-TABLE
           MOVE    "key"                   TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC                  =   ZERO )
               MOVE    MCPDATA-REC         TO  HKNCOMBI-REC
           ELSE
               MOVE    1                   TO  FLG-HKNCOMBI
               INITIALIZE                      HKNCOMBI-REC
           END-IF
      *
           MOVE    "tbl_hkncombi"          TO  MCP-TABLE
           MOVE    "key"                   TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-HKNCOMBI-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHも行う)
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHは行わない)
      *****************************************************************
       911-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
      *
           .
      *
       911-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC           SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
      *
           .
      *
       910-DBCLOSECURSOR-EXT.
           EXIT.
