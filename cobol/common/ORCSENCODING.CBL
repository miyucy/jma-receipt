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
       PROGRAM-ID.             ORCSENCODING.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 業務選択
      *  コンポーネント名  : エンコード取得サブ
      *  管理者            : 
      *  09/12/14    NACL−多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
      *FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-OK              PIC 9(01).
      *
      *01  IDX-AREA.
      *    03  IDX                   PIC 9(03).
      *    03  IDY                   PIC 9(03).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-ERRMSG          PIC X(500).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システムカタログ
           COPY    "CPDBCTG.INC".
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      * 
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
           COPY    MCPAREA.
           COPY    COMMON-SPA.
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPA-AREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                     FLG-AREA
           INITIALIZE                     WRK-AREA
      *
      *    エンコード取得処理
           PERFORM 100-DBCATLG-GET-SEC
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    DBエンコーディング取得処理
      *****************************************************************
       100-DBCATLG-GET-SEC        SECTION.
      *
           MOVE    ZERO                TO  SPA-ENCODING
      *    エンコーディング取得処理
           INITIALIZE                      DBCATALOG-REC
           MOVE    DBCATALOG-REC       TO  MCPDATA-REC
           MOVE    "tbl_dbcatalog"     TO  MCP-TABLE
           MOVE    "enc"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_dbcatalog"     TO  MCP-TABLE
               MOVE    "enc"               TO  MCP-PATHNAME
               PERFORM 910-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  DBCATALOG-REC
      *            DISPLAY "エンコーディング情報  = " CPDBCTG-INFO-1
      *
                   EVALUATE    CPDBCTG-INFO-1
                       WHEN    "EUC_JP"
                           MOVE    1               TO  SPA-ENCODING
                       WHEN    "UTF8"
                           MOVE    2               TO  SPA-ENCODING
                       WHEN    OTHER
                           MOVE    3               TO  SPA-ENCODING
                   END-EVALUATE
      *            DISPLAY "SPA-ENCODING  = " SPA-ENCODING
      *        ELSE
      *            DISPLAY "ENCODING GET ERR = " MCP-RC
               END-IF
           END-IF
      *    CPDBCTG-INFO-1 = EUC_JP  or UTF8 or OTHER
      *
           MOVE    "tbl_dbcatalog"     TO  MCP-TABLE
           MOVE    "enc"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           IF      SPA-ENCODING        =   1
                                       OR  2
               CONTINUE
           ELSE
               MOVE    SPACE               TO  WRK-ERRMSG
               STRING  "tbl_dbcatalog CPDBCTG-INFO-1:"
                        CPDBCTG-INFO-1     DELIMITED  BY  SIZE
                                           INTO    WRK-ERRMSG
               END-STRING
               CALL    "coblog"    USING   WRK-ERRMSG
           END-IF
      *
      *  ロケール取得処理
           INITIALIZE                      DBCATALOG-REC
           MOVE    DBCATALOG-REC       TO  MCPDATA-REC
           MOVE    "tbl_dbcatalog"     TO  MCP-TABLE
           MOVE    "lcl"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_dbcatalog"     TO  MCP-TABLE
               MOVE    "lcl"               TO  MCP-PATHNAME
               PERFORM 910-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                  MOVE    MCPDATA-REC         TO  DBCATALOG-REC
      *           DISPLAY "ロケール情報  = " CPDBCTG-INFO-1
      *        ELSE
      *           DISPLAY "ENCODING GET ERR = " MCP-RC
               END-IF
           END-IF
      *    CPDBCTG-INFO-1 = EUC_JP  or UTF8 or OTHER
      *
           MOVE    "tbl_dbcatalog"     TO  MCP-TABLE
           MOVE    "lcl"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       100-DBCATLG-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                           MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
           .
       910-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルFETCH処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                           MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
           .
       910-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       990-DBCLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                           MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
           .
       990-DBCLOSE-EXT.
           EXIT.
      *
