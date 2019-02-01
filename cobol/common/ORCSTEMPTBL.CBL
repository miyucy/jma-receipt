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
       PROGRAM-ID.             ORCSTEMPTBL.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 共通
      *  コンポーネント名  : 一時テーブル編集サブ
      *  管理者            : 
      *  作成日付    作業者        記述
      *  14/04/07    NACL−太田    新規作成
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
       FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                PIC 9(05).
           03  IDXD                PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-TEXT            PIC  X(10).
      *
       01  CONST-AREA.
           03  CONST-SRYACCT       PIC X(20)   VALUE "SRYACCT".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    診療会計（主）
       01  ACCTM-REC.
           COPY    "CPSRYACCTM.INC".
      *
      *    診療会計（副）
       01  ACCTS-REC.
           COPY    "CPSRYACCTS.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
           COPY    "MCPAREA".
           COPY    "MCPDATA.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPORCSTEMPTBL.INC".
           COPY    "COMMON-SPA".
      *
       PROCEDURE                   DIVISION    USING
           STEMPTBL-AREA
           SPA-AREA
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
           EVALUATE    STEMPTBL-TABLE
           WHEN    CONST-SRYACCT
               EVALUATE    STEMPTBL-FUNC
               WHEN    "DBCREATE"
                   PERFORM 210-CREATE-TEMP-SRYACCT-SEC
               WHEN    "DBDROP"
                   PERFORM 220-DROP-TEMP-SRYACCT-SEC
               END-EVALUATE
           END-EVALUATE
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    診療会計一時テーブル作成処理
      *****************************************************************
       210-CREATE-TEMP-SRYACCT-SEC     SECTION.
      *
           INITIALIZE                      ACCTM-REC
           MOVE    SPA-HOSPNUM         TO  ACCTM-HOSPNUM
           MOVE    STEMPTBL-SRYYM      TO  ACCTM-SRYYM
           MOVE    ACCTM-REC           TO  MCPDATA-REC
           MOVE    "tbl_sryacct_main"  TO  MCP-TABLE
           MOVE    "tmpkey"            TO  MCP-PATHNAME
           PERFORM 910-DBCREATE-SEC
      *
           INITIALIZE                  ACCTM-REC
           PERFORM VARYING IDXD    FROM    1   BY  1
                   UNTIL ( IDXD    >   31 )
      *
               IF    ( IDXD    >=   STEMPTBL-FROM )
                AND  ( IDXD    <=   STEMPTBL-TO )
                   MOVE    1       TO  ACCTM-DAY (IDXD)
               END-IF
      *
           END-PERFORM
      *
           MOVE    ACCTM-REC           TO  MCPDATA-REC
           MOVE    "tbl_sryacct_main"  TO  MCP-TABLE
           MOVE    "tmpupd1"           TO  MCP-PATHNAME
           PERFORM 910-DBUPDATE-SEC
      *
           INITIALIZE                      ACCTM-REC
           MOVE    ACCTM-REC           TO  MCPDATA-REC
           MOVE    "tbl_sryacct_main"  TO  MCP-TABLE
           MOVE    "tmpupd2"           TO  MCP-PATHNAME
           PERFORM 910-DBUPDATE-SEC
      *
           INITIALIZE                      ACCTM-REC
           MOVE    ACCTM-REC           TO  MCPDATA-REC
           MOVE    "tbl_sryacct_main"  TO  MCP-TABLE
           MOVE    "tmpkey"            TO  MCP-PATHNAME
           PERFORM 910-DBCREATEINDEX-SEC
      *
           INITIALIZE                      ACCTS-REC
           MOVE    SPA-HOSPNUM         TO  ACCTS-HOSPNUM
           MOVE    STEMPTBL-SRYYM      TO  ACCTS-VSRYYM
           MOVE    ACCTS-REC           TO  MCPDATA-REC
           MOVE    "tbl_sryacct_sub"   TO  MCP-TABLE
           MOVE    "tmpkey"            TO  MCP-PATHNAME
           PERFORM 910-DBCREATE-SEC
      *
           INITIALIZE                      ACCTS-REC
           MOVE    ACCTS-REC           TO  MCPDATA-REC
           MOVE    STEMPTBL-FROM       TO  ACCTS-VFROM
           MOVE    STEMPTBL-TO         TO  ACCTS-VTO
           MOVE    ACCTS-REC           TO  MCPDATA-REC
           MOVE    "tbl_sryacct_sub"   TO  MCP-TABLE
           MOVE    "tmpupd1"           TO  MCP-PATHNAME
           PERFORM 910-DBUPDATE-SEC
      *
           INITIALIZE                      ACCTS-REC
           MOVE    ACCTS-REC           TO  MCPDATA-REC
           MOVE    "tbl_sryacct_sub"   TO  MCP-TABLE
           MOVE    "tmpkey"            TO  MCP-PATHNAME
           PERFORM 910-DBCREATEINDEX-SEC
      *
           .
       210-CREATE-TEMP-SRYACCT-EXT.
           EXIT.
      *****************************************************************
      *    診療会計一時テーブル破棄処理
      *****************************************************************
       220-DROP-TEMP-SRYACCT-SEC       SECTION.
      *
           INITIALIZE                      ACCTM-REC
           MOVE    ACCTM-REC           TO  MCPDATA-REC
           MOVE    "tbl_sryacct_main"  TO  MCP-TABLE
           MOVE    "tmpkey"            TO  MCP-PATHNAME
           PERFORM 910-DBDROP-SEC
      *
           INITIALIZE                      ACCTS-REC
           MOVE    ACCTS-REC           TO  MCPDATA-REC
           MOVE    "tbl_sryacct_sub"   TO  MCP-TABLE
           MOVE    "tmpkey"            TO  MCP-PATHNAME
           PERFORM 910-DBDROP-SEC
      *
           .
       220-DROP-TEMP-SRYACCT-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
      *
           .
       300-END-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHも行う)
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
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
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
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
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
      *
       910-DBCLOSECURSOR-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＵＰＤＡＴＥ
      *****************************************************************
       910-DBUPDATE-SEC                    SECTION.
      *
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
      *
       910-DBUPDATE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＣＲＥＡＴＥ
      *****************************************************************
       910-DBCREATE-SEC                    SECTION.
      *
           MOVE    "DBCREATE"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
      *
       910-DBCREATE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＣＲＥＡＴＥＩＮＤＥＸ
      *****************************************************************
       910-DBCREATEINDEX-SEC               SECTION.
      *
           MOVE    "DBCREATEINDEX"     TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
      *
       910-DBCREATEINDEX-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＤＲＯＰ
      *****************************************************************
       910-DBDROP-SEC                      SECTION.
      *
           MOVE    "DBDROP"            TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
      *
       910-DBDROP-EXT.
           EXIT.
