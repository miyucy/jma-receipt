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
       PROGRAM-ID.                     ORCGDSUB01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院登録
      *  コンポーネント名  : 入院登録サブ
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
       DATA                        DIVISION.
       FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SPATMP          PIC 9(01).
      *
       01  WRK-AREA.
           03  WRK-FILEMEI         PIC X(20).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ＳＰＡ一時テーブル
       01  SPATMP-REC.
           COPY    "CPSPA-TMP.INC".
      *
           COPY    "MCPDATA2.INC".
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPDSUB01.INC".
           COPY    "COMMON-SPA".
      *
       PROCEDURE                   DIVISION    USING
           DSUB01-LNK
           SPA-AREA.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE              FLG-AREA
                                   WRK-AREA
      *
      *
           IF  ( DSUB01-KBN       =   "I" )
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
           MOVE    "SCREEN"        TO  WRK-FILEMEI
           PERFORM 1001-SPA-INPUT-SEC
      *
           MOVE    "COMMON"        TO  WRK-FILEMEI
           PERFORM 1001-SPA-INPUT-SEC
      *
           .
       100-SPA-INPUT-EXT.
           EXIT.
      *****************************************************************
      *    ＳＣＲＳＰＡ読込処理
      *****************************************************************
       1001-SPA-INPUT-SEC               SECTION.
      *
           PERFORM 900-SPATMP-KEY-SEL-SEC
           IF    ( WRK-FILEMEI     =   "SCREEN" )
               MOVE    SPATMP-DATA-REC
                                   TO  DSUB01-SCRSPA-AREA
           ELSE
               MOVE    SPATMP-DATA-REC
                                   TO  DSUB01-COMMON
           END-IF
      *
           MOVE    SPATMP-REC      TO  MCPDATA2-REC
           MOVE    "tbl_spa_tmp"   TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 920-DBDELETE-SEC
      *
           .
       1001-SPA-INPUT-EXT.
           EXIT.
      *****************************************************************
      *    ＳＣＲＳＰＡ出力処理
      *****************************************************************
       200-SPA-OUTPUT-SEC              SECTION.
      *
           MOVE    "SCREEN"        TO  WRK-FILEMEI
           PERFORM 2001-SPA-OUTPUT-SEC
      *
           MOVE    "COMMON"        TO  WRK-FILEMEI
           PERFORM 2001-SPA-OUTPUT-SEC
      *
           .
       200-SPA-OUTPUT-EXT.
           EXIT.
      *****************************************************************
      *    ＳＣＲＳＰＡ出力処理
      *****************************************************************
       2001-SPA-OUTPUT-SEC             SECTION.
      *
           INITIALIZE                  SPATMP-REC
      *
           PERFORM 9001-SPATMP-KEY-EDIT-SEC
      *
           IF    ( WRK-FILEMEI     =   "SCREEN" )
               MOVE    DSUB01-SCRSPA-AREA
                                   TO  SPATMP-DATA-REC
           ELSE
               MOVE    DSUB01-COMMON
                                   TO  SPATMP-DATA-REC
           END-IF
      *
           MOVE    SPATMP-REC      TO  MCPDATA2-REC
           MOVE    "tbl_spa_tmp"   TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 920-DBINSERT-SEC
      *
           .
       2001-SPA-OUTPUT-EXT.
           EXIT.
      *****************************************************************
      *    一時保存テーブル検索処理
      *****************************************************************
       900-SPATMP-KEY-SEL-SEC          SECTION.
      *
           MOVE    ZERO            TO  FLG-SPATMP
      *
           INITIALIZE                  SPATMP-REC
      *
           PERFORM 9001-SPATMP-KEY-EDIT-SEC
      *
           MOVE    SPATMP-REC      TO  MCPDATA2-REC
           MOVE    "tbl_spa_tmp"   TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 920-DBSELECT-SEC
           IF    ( FLG-SPATMP      =   ZERO )
               MOVE    MCPDATA2-REC TO SPATMP-REC
           ELSE
               MOVE    1           TO  FLG-SPATMP
               INITIALIZE              SPATMP-REC
           END-IF
      *
           MOVE    "tbl_spa_tmp"   TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 920-DBCLOSECURSOR-SEC
      *
           .
       900-SPATMP-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    一時保存テーブル検索条件編集処理
      *****************************************************************
       9001-SPATMP-KEY-EDIT-SEC        SECTION.
      *
           MOVE    SPA-HOSPNUM     TO  SPATMP-HOSPNUM
           MOVE    "D04"           TO  SPATMP-GYOUMUID
           MOVE    SPA-TERMID      TO  SPATMP-TERMID
           MOVE    WRK-FILEMEI     TO  SPATMP-FILEMEI
           MOVE    1               TO  SPATMP-EDANUM
      *
           .
       9001-SPATMP-KEY-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       920-DBSELECT-SEC               SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           PERFORM 920-ORCDBSPATMP-SEC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 920-DBFETCH-SEC
           END-IF
      *
           .
      *
       920-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       920-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           PERFORM 920-ORCDBSPATMP-SEC
      *
           .
      *
       920-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       920-DBCLOSECURSOR-SEC           SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           PERFORM 920-ORCDBSPATMP-SEC
      *
           .
      *
       920-DBCLOSECURSOR-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＩＮＳＥＲＴ処理
      *****************************************************************
       920-DBINSERT-SEC                SECTION.
      *
           MOVE    "DBINSERT"      TO  MCP-FUNC
           PERFORM 920-ORCDBSPATMP-SEC
      *
           .
      *
       920-DBINSERT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＤＥＬＥＴＥ処理
      *****************************************************************
       920-DBDELETE-SEC                SECTION.
      *
           MOVE    "DBDELETE"      TO  MCP-FUNC
           PERFORM 920-ORCDBSPATMP-SEC
      *
           .
      *
       920-DBDELETE-EXT.
           EXIT.
      *****************************************************************
      *    ＯＲＣＳＰＡＴＭＰ呼出処理
      *****************************************************************
       920-ORCDBSPATMP-SEC                SECTION.
      *
           CALL    "ORCDBSPATMP"       USING
                                       MCPAREA
                                       MCPDATA2-REC
                                       SPA-AREA
      *
           .
      *
       920-ORCDBSPATMP-EXT.
           EXIT.
