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
       PROGRAM-ID.             ORCGM95.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 業務選択
      *  コンポーネント名  : 日付セット（Ｍ９５）
      *  管理者            : 
      *  00/12/01    MCC−多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.01.01    MCC-多々納   01/09/20  JOINの修正      
      *  01.01.02    MCC-藤原     01/09/27  MVERの追加  
      *  01.02.01    MCC-藤原     01/11/21  ORCMCPSUBへ変更  
      *  01.02.02    MCC-多々納   02/02/22  MID1の追加
      *  01.02.03    NACL-多々納  04/02/02  外来時間外区分追加
      *  01.02.04    NACL-伊藤    04/02/05  M97の追加
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
      *    スパ領域
           COPY    "COMMON-SPA".
      *    スパ領域
           COPY    "M00COMMON-SPA".
      *
      *
      *    Ｍ００スパ領域
           COPY    "M00SCR-SPA".
      *
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
           03  FLG-CHK             PIC 9(01).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY          PIC 9(02).
               05  SYS-MM          PIC 9(02).
               05  SYS-DD          PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
      *    選択日付
           03  WRK-CAL-YMD.
               05  WRK-CAL-YEAR        PIC 9(04).
               05  WRK-CAL-MONTH       PIC 9(02).
               05  WRK-CAL-DAY         PIC 9(02).
           03  IDX                   PIC 9(03).
           03  WRK-SYSYMD.
               05  WRK-SYSYY         PIC 9(04).
               05  WRK-SYSMM         PIC 9(02).
               05  WRK-SYSDD         PIC 9(02).
           03  WRK-WSYSYMDH          PIC X(09).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *
      *
       01  WRK-HENSYU-AREA.
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HMM         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HDD         PIC Z9.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
           COPY    "CPORCMCP.INC".     
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *****COPY    "MCPAREA.INC".
           COPY    MCPAREA.
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "M00.INC".
           COPY    "M01.INC".
           COPY    "M01N.INC".
           COPY    "M02.INC". 
           COPY    "M95.INC".
           COPY    "M96.INC".
           COPY    "M97.INC".
           COPY    "MERR.INC".
           COPY    "MID1.INC".
           COPY    "MVER.INC".
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
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-M00KYOUTU
      **** MOVE    SPA-FREE        TO  SPA-M00
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS  ALSO MCP-EVENT ALSO MCP-WIDGET(1:1)
               WHEN    "LINK"      ALSO ANY       ALSO ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN    "PUTG"      ALSO "CLICKED" ALSO "B"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-M00KYOUTU        TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
      **** MOVE    SPA-M00         TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "MERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
      *
               IF      SPA-ERRCD       NOT =   SPACE
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "M95    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           MOVE    SPA-SYSYMD      TO  SPA-NAI-SYSYMD
           MOVE    SPA-SYSYMDW     TO  SPA-NAI-SYSYMDW
           MOVE    SPA-SYSYMDWH    TO  SPA-GMN-SYSYMD
      *
      *    時間外区分
           MOVE    "0 時間内"          TO  SPA-GMN-JIKANKBN-LST(1)
           MOVE    "1 時間外"          TO  SPA-GMN-JIKANKBN-LST(2)
           MOVE    "2 休日"            TO  SPA-GMN-JIKANKBN-LST(3)
           MOVE    "3 深夜"            TO  SPA-GMN-JIKANKBN-LST(4)
           MOVE    "4 時間外特例"      TO  SPA-GMN-JIKANKBN-LST(5)
      *
           MOVE    SPA-GAI-JIKANKBN    TO  SPA-GMN-JIKANKBN
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               IF      SPA-GMN-JIKANKBN    =   SPA-GMN-JIKANKBN-LST
                                                          (IDX)(1:1)
                   MOVE    SPA-GMN-JIKANKBN-LST (IDX)
                                           TO  SPA-GMN-JIKANKBN-G
                   MOVE   5                TO  IDX
               END-IF
           END-PERFORM
      *
           MOVE    1               TO  SPA-GMN-CUR
      *
      *
           .
       3OO-SCREEN-EXT.
           EXIT.
      *
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
                   PERFORM 400-TOROKU-SEC
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
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
               WHEN    "ACTIVATE"      ALSO    "SYSYMD"
                   PERFORM 4101-SYSYMD-SEC
               WHEN    "ACTIVATE"      ALSO    "JIKANKBN"
                   PERFORM 4103-JIKANKBN-SEC
      *        カレンダー選択
               WHEN    "CLICKED"       ALSO    "C01"
               WHEN    "CLICKED"       ALSO    "CALENDAR1"
                   PERFORM 4102-CALENDAR-SEC
          END-EVALUATE
      *
          .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力　処理
      *****************************************************************
       4101-SYSYMD-SEC            SECTION.
      *
           MOVE    M95-SYSYMD      TO  SPA-GMN-SYSYMD
      *
           .
       4101-SYSYMD-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力　処理
      *****************************************************************
       4102-CALENDAR-SEC            SECTION.
      *
           MOVE    1                   TO  SPA-GMN-CUR
      *
      *    画面入力の年月＝ＳＰＡの年月のチェック
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    M95-YEAR            TO  WRK-CAL-YEAR
           MOVE    M95-MONTH           TO  WRK-CAL-MONTH
           MOVE    M95-DAY             TO  WRK-CAL-DAY
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-CAL-YMD         TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"      USING    STS-AREA-DAY
                                           LNK-DAY2-AREA
           IF      STS-DAY-RC1         =   ZERO
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
               MOVE    WRK-HENYMDG         TO  SPA-GMN-SYSYMD
               MOVE    WRK-CAL-YMD         TO  SPA-NAI-SYSYMD
           ELSE
               MOVE    "0001"              TO  SPA-ERRCD
               GO      TO      4102-CALENDAR-EXT
           END-IF
      *
           MOVE    3                   TO  SPA-GMN-CUR
      *
           .
       4102-CALENDAR-EXT.
           EXIT.
      *****************************************************************
      *     時間外登録  処理
      *****************************************************************
       4103-JIKANKBN-SEC                 SECTION.
      *
           MOVE    M95-JIKANKBN        TO  SPA-GMN-JIKANKBN-G
      *
           MOVE    ZERO                TO  FLG-CHK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               IF      SPA-GMN-JIKANKBN    =   SPA-GMN-JIKANKBN-LST
                                                          (IDX)(1:1)
                   MOVE    SPA-GMN-JIKANKBN-LST (IDX)
                                           TO  SPA-GMN-JIKANKBN-G
                   MOVE    1               TO  FLG-CHK
                   MOVE    5               TO  IDX
               END-IF
           END-PERFORM
      *
           IF      FLG-CHK             =   ZERO
               MOVE    "0003"          TO  SPA-ERRCD
               MOVE    2               TO  SPA-GMN-CUR
           END-IF
      *
           MOVE    3                   TO  SPA-GMN-CUR
      *
           .
       4103-JIKANKBN-EXT.
           EXIT.
      *****************************************************************
      *     登録  処理
      *****************************************************************
       400-TOROKU-SEC                 SECTION.
      *
      *    画面入力の和暦変換
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY1-AREA
           MOVE    "11"                TO  LNK-DAY1-IRAI
           MOVE    SPA-NAI-SYSYMD      TO  LNK-DAY1-YMD
           CALL    "ORCSDAY"      USING    STS-AREA-DAY
                                           LNK-DAY1-AREA
           IF      STS-DAY-RC1         =   ZERO
               MOVE    LNK-DAY1-WYMD       TO  SPA-NAI-SYSYMDW
           ELSE
               MOVE    "0001"              TO  SPA-ERRCD
               GO      TO      400-TOROKU-EXT
           END-IF
      *
           MOVE    SPA-GMN-SYSYMD      TO  SPA-SYSYMDWH
           MOVE    SPA-NAI-SYSYMD      TO  SPA-SYSYMD
           MOVE    SPA-NAI-SYSYMDW     TO  SPA-SYSYMDW
      *
           MOVE    SPA-GMN-JIKANKBN    TO  SPA-GAI-JIKANKBN
      *
           PERFORM 210-BACK
           .
       400-TOROKU-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
      *****MOVE    "M00"               TO  SPA-SAKIPG
           MOVE    SPA-M95-MOTOPG      TO  SPA-SAKIPG
           MOVE    "M95"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
      **** MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE    "JOIN"              TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "M95    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           INITIALIZE                  M95
      *
           MOVE    SPA-GMN-SYSYMD      TO  M95-SYSYMD
           MOVE    SPA-NAI-SYSYMD      TO  WRK-SYMD
           MOVE    WRK-SYY             TO  M95-YEAR
           MOVE    WRK-SMM             TO  M95-MONTH
           MOVE    WRK-SDD             TO  M95-DAY
      *
      *
           MOVE    SPA-GMN-JIKANKBN-G  TO  M95-JIKANKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               MOVE    SPA-GMN-JIKANKBN-LST (IDX)
                                           TO  M95-JIKANKBN-ITEM (IDX)
           END-PERFORM
           MOVE    5                   TO  M95-JIKANKBN-COUNT
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
           EVALUATE    SPA-GMN-CUR
               WHEN    1
                   MOVE  "SYSYMD"    TO  MCP-WIDGET
               WHEN    2
                   MOVE  "JIKANKBN"  TO  MCP-WIDGET
               WHEN    3
                   MOVE  "B12"       TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "入力エラー"        TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "時間外区分エラー"  TO  SPA-ERRMSG
           END-EVALUATE
      *
      *
           MOVE    SPACE                TO  MERR
           MOVE    SPA-ERRCD            TO  MERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  MERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "M95"                TO  SPA-MOTOPG
           MOVE    "MERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "MERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
