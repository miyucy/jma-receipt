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
       PROGRAM-ID.                 ORCGXE01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : QRコードテストプロ
      *  コンポーネント名  : QRコードマスタ登録
      *  管理者            : 
      *  作成日付    作業者        記述
      *  05/01/21    NACL-竹田     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
      *FILE-CONTROL.
      *
      *
       DATA                        DIVISION.
      *FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    画面色等
           COPY    "ENUM-VALUE".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-OK              PIC 9(01).
           03  FLG-ERR             PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-ORC-DBPATH          PIC X(64).
           03  WRK-MCP-WIDGET          PIC X(60).
           03  WRK-SELNUM              PIC 9(04).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    ヘルプマスタ−
       01  HELP-REC.
           COPY    "CPHELP.INC".
      *
      *    ヘルプマスタ−ワーク
       01  WRK-HELP-REC.
           COPY    "CPHELP.INC"        REPLACING
                                       //HELP-// BY //WRK-HELP-//.
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *    全角変換サブ
           COPY    "CPORCSKANACHK.INC".
      *
      *    業務名
           COPY    "CPLOCKCONST.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "XE01.INC".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
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
           MOVE    SPA-COMMON      TO  SPA-AREA
      *    MOVE    SPA-WORK        TO  SPA-N41KYOUTU
      *    MOVE    SPA-FREE        TO  SPA-N41
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN     "PUTG"           ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE
      *
      *    画面遷移がない時、画面表示へ
      *
      *    MOVE    SPA-N41KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
      *    MOVE    SPA-N41         TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
      *    エラー画面より
      *        初期画面編集
               PERFORM 300-SCREEN-SEC
      *        画面編集
      *
           IF      FLG-END             =   ZERO
               MOVE    SPACE               TO  LINKAREA
      *
               MOVE   SPACE                TO  MCP-PUTTYPE
               MOVE   "XE01"             TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
      *
               MOVE    1                   TO  FLG-END
           END-IF
           .
      *
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC             SECTION.
      *
           IF      LNK-KYOUTU      NOT =  SPACE
               MOVE    LNK-KYOUTU      TO  SPA-AREA
           END-IF
      *
      *    内部画面より
           EVALUATE    SPA-MOTOPG
               WHEN    "XE01"
                   PERFORM 3001-SPA-SET-SEC
           END-EVALUATE
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面編集処理
      *****************************************************************
       3001-SPA-SET-SEC             SECTION.
      *
           DISPLAY "spa-set"
           .
       3001-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *        登録
               WHEN    "CLICKED"       ALSO    "B12"
                    PERFORM 412-TOROKU-SEC
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "XE01"            TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                        SECTION.
      *
           MOVE    "M02"               TO  SPA-SAKIPG
           MOVE    "N41"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
           INITIALIZE                  SPA-KYOTUKEY
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    確定　処理
      *****************************************************************
       412-TOROKU-SEC             SECTION.
      *
      *    入力チェック処理
      *
      *    更新前チェック
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    "tbl_help"          TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
      *    CALL    "MONFUNC"           USING
      *                                MCPAREA
      *                                MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               MOVE    "1000"          TO  SPA-ERRCD
               DISPLAY "N41 HELP UPD ERR:" MCP-RC
           END-IF
      *
           .
       412-TOROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MONFUNC"           USING
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
           CALL    "MONFUNC"           USING
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
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       990-DBCLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
