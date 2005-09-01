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
       PROGRAM-ID.             ORCSUSERPG.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 共通
      *  コンポーネント名  : ユーザプログラム起動サブ
      *  管理者            : 
      *  作成日付    作業者        記述
      *  05/09/01    NACL−多々納  新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
      *FILE-CONTROL.
      *
      *
       DATA                    DIVISION.
      *FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-OK              PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
      *
      *    一時領域
      *01  WRK-AREA.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY  "CPSYSKANRI.INC".
      *    ユーザプログラム起動
           COPY  "CPSK9700.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "ORCA-DBPATH".
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    ユーザプログラム起動サブパラメタ
           COPY    "CPORCSUSERPG.INC".
      *
       PROCEDURE                   DIVISION    USING
           ORCSUSERPGAREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
      *TEST
           DISPLAY "ORCSUSERPGAREA:" ORCSUSERPGAREA
      *TEST
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
      *
           PERFORM 100-SYSKANRI-CHK-SEC
           IF      FLG-OK              =   1
      *        ユーザプログラム起動
               PERFORM 200-SHELL-SYORI-SEC
           END-IF
      *
           .
       000-PROC-EXT.
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    ユーザプログラム起動チェク処理
      *****************************************************************
       100-SYSKANRI-CHK-SEC             SECTION.
      *
           MOVE    SPACE               TO  SYS-9700-REC
           INITIALIZE                      SYS-9700-REC
           MOVE    "9700"              TO  SYS-9700-KANRICD
           STRING  ORCSUSERPG-GMNPG    DELIMITED BY  SPACE
                   "%"                 DELIMITED BY  SIZE
                                   INTO    SYS-9700-KBNCD
           END-STRING
           MOVE    "00000000"          TO  SYS-9700-STYUKYMD
           MOVE    "99999999"          TO  SYS-9700-EDYUKYMD
           MOVE    SYS-9700-REC        TO  MCPDATA-REC
           MOVE    PATH-TBL-SYSKANRI-KEY   TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    PATH-TBL-SYSKANRI-KEY   TO  MCP-PATH
               PERFORM 990-SYSKANRI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
           MOVE    ZERO                TO  FLG-OK
           PERFORM UNTIL   (FLG-SYSKANRI   =   1 )  OR
                           (FLG-OK         =   1 )
               MOVE    MCPDATA-REC         TO  SYS-9700-REC
               IF      SYS-9700-KBNCD      =   ORCSUSERPG-GMNPG
                   MOVE    1                   TO  FLG-OK
               ELSE
                   MOVE    PATH-TBL-SYSKANRI-KEY   TO  MCP-PATH
                   PERFORM 990-SYSKANRI-READ-SEC
               END-IF
           END-PERFORM
           MOVE    PATH-TBL-SYSKANRI-KEY   TO  MCP-PATH
           PERFORM 990-DBCLOSE-SEC
      *
           .
       100-SYSKANRI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ユーザプログラム起動処理
      *****************************************************************
       200-SHELL-SYORI-SEC             SECTION.
      *
           IF      SYS-9700-EXECUTE-SW     =   "1"
      *        実行可
      ******** SYS-9700-SHELL
               CONTINUE
           END-IF
           .
       200-SHELL-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       990-SYSKANRI-READ-SEC                SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       990-SYSKANRI-READ-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       920-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       920-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクロース処理
      *****************************************************************
       990-DBCLOSE-SEC           SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       990-DBCLOSE-EXT.
           EXIT.
      *
