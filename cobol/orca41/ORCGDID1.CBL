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
       IDENTIFICATION                            DIVISION.
       PROGRAM-ID.                               ORCGDID1.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト作成指示
      *  コンポーネント名  : 確認画面１（ＤＩＤ１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/03/12    ひさなが　    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    ひさなが     03/07/29  チェック内容全件印刷追加
      *
      *****************************************************************
      *
       ENVIRONMENT                               DIVISION.
       CONFIGURATION                             SECTION.
       INPUT-OUTPUT                              SECTION.
       FILE-CONTROL.
      *
       DATA                                      DIVISION.
      *FILE                                      SECTION.
      *
      *
       WORKING-STORAGE                           SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
       01  SPA-D01.
           03  SPA-D01-AREA.
               05  SPA-GMN-PAGE               PIC 9(02).
               05  SPA-GMN-MAX                PIC 9(03).
               05  SPA-GMN-CUR                PIC 9(02).
               05  SPA-GMN-KBN                PIC X(02).
               05  SPA-GMN-RUN                PIC 9(01).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-HOSPID         PIC X(24).
                   07  SPA-GMN-SRYYMD         PIC X(08).
                   07  SPA-GMN-SRYYMD-S       PIC X(08).
                   07  SPA-GMN-SRYYM-D        PIC X(16).
                   07  SPA-GMN-NYUGAIKBN-DSP.
                       09  SPA-GMN-NYUGAIKBN      PIC X(01).
                       09  SPA-GMN-NYUGAIKBN-AKI  PIC X(01).
                       09  SPA-GMN-NYUGAIKBN-MSG  PIC X(14).
                   07  SPA-GMN-TBLG.
                       09  SPA-GMN-TBL1       OCCURS  5.
                           11  SPA-GMN-NYUGAIKBN-K    PIC X(01).
                           11  SPA-GMN-NYUGAIKBN-FL   PIC X(01).
                           11  SPA-GMN-NYUGAIKBN-M    PIC X(14).
                       09  SPA-GMN-TBL2       OCCURS  20.
                           11  SPA-GMN-MSG            PIC X(40).
                           11  SPA-GMN-CHKKBN         PIC X(20).
                           11  SPA-GMN-TBL3       OCCURS  5.
                               13  SPA-GMN-CHKKBN-K   PIC X(01).
                               13  SPA-GMN-CHKKBN-FL  PIC X(01).
                               13  SPA-GMN-CHKKBN-M   PIC X(18).
               05  SPA-NAI-AREA.
                   07  SPA-NAI-MOTOPG         PIC X(08).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                           PIC 9(01).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *     
           COPY    "CPORCMCP.INC".  
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                                  SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "D01.INC".
           COPY    "D99.INC".
           COPY    "DERR.INC".
           COPY    "DID1.INC".
           COPY    "DID2.INC".
      *
       PROCEDURE                                 DIVISION    USING
                                                             MCPAREA
                                                             SPAAREA
                                                             LINKAREA
                                                             SCRAREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                              SECTION.
      *
           MOVE    SPA-COMMON                    TO  SPA-AREA.
           MOVE    SPA-FREE                      TO  SPA-D01.
      * 
           EVALUATE    MCP-STATUS                ALSO    MCP-EVENT
               WHEN    "LINK"                    ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN     "PUTG"                   ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
           END-EVALUATE.
      *
           MOVE    SPA-AREA                      TO  SPA-COMMON.
           MOVE    SPA-D01                       TO  SPA-FREE.
      *
           EXIT    PROGRAM.
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                              SECTION.
      *
      *
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                               SECTION.
      *
           EVALUATE    MCP-EVENT                 ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"                 ALSO    "B01"
                   MOVE    SPACE                 TO  SPA-GMN-KBN
                   PERFORM 210-BACK
      *     登録
               WHEN    "CLICKED"                 ALSO    "B12"
                   MOVE    "OK"                  TO  SPA-GMN-KBN
                   PERFORM 210-BACK
           END-EVALUATE.
      *
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                                  SECTION.
      *
           MOVE    SPA-MOTOPG          TO  SPA-SAKIPG.
           MOVE    "DID1"              TO  SPA-MOTOPG.
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE.
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW                            SECTION.
      *
           MOVE   "PUTWINDOW"                    TO  MCP-FUNC.
           CALL   "ORCMCPSUB"                     USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC.
      *
       900-PUT-WINDOW-EXT.
           EXIT.
      *
