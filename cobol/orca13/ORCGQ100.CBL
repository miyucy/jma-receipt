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
       PROGRAM-ID.                 ORCGQ100.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者照会
      *  コンポーネント名  : 出力指示画面（Ｑ１００）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/06/11    MCC−太田     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-太田    03/06/10 一括入力対応
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                        DIVISION.
      *FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    画面用ＳＰＡ
           COPY    "Q01SCR-SPA".
      *
      *    コンスタント値
           COPY    "ENUM-VALUE".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                                PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-NUM                             PIC 9(09).
           03  WRK-MCP-WIDGET                      PIC X(64).
      *
      *    固定値領域
       01  CONST-AREA.
           03  CONST-LINE                          PIC 9(05)
               VALUE   30.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
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
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "Q01.INC".
           COPY    "Q02.INC".
           COPY    "Q97.INC".
           COPY    "Q98.INC".
           COPY    "Q99.INC".
           COPY    "Q100.INC".
           COPY    "QERR.INC".
           COPY    "QID1.INC".
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
      *----(01.00.02) LINE ADD START ----------------------------------
           INITIALIZE                  FLG-AREA
                                       IDX-AREA
                                       WRK-AREA
      *----(01.00.02) LINE ADD END   ----------------------------------
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-Q01FREE
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN     "PUTG"           ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF  ( FLG-END           =   ZERO )
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-Q01FREE     TO  SPA-FREE
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
                                       IDX-AREA
                                       WRK-AREA
      *
      *    エラー画面より
           IF  ( SPA-MOTOPG            =   "QERR" )
               MOVE    SPACE           TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  MCP-PUTTYPE
           MOVE    "Q100"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-Q100
           INITIALIZE                      SPA-Q100
      *
           MOVE  4                     TO  SPA-GMN-Q100-CUR
      *
           IF  ( SPA-Q02-Q100-PROC-FLG     =   ZERO )
      *        ＣＳＶ出力処理
               MOVE    "3001"          TO  SPA-GMN-Q100-CD
               MOVE    "ＣＳＶ出力を開始します"
                                       TO  SPA-GMN-Q100-MSG
               MOVE    "出力ファイル名"
                                       TO  SPA-GMN-Q100-LBLFILENAME
               MOVE    "/tmp/OUTPUT.csv"
                                       TO  SPA-GMN-Q100-FILENAME
               MOVE    WIDGET-NORMAL   TO  SPA-GMN-Q100-FILENAME-STATE
               MOVE    "件数指定"      TO  SPA-GMN-Q100-LBLNUMSEL
           ELSE
               MOVE    "3002"          TO  SPA-GMN-Q100-CD
               MOVE    "印刷処理を開始します"
                                       TO  SPA-GMN-Q100-MSG
               MOVE    SPACE           TO  SPA-GMN-Q100-LBLFILENAME
                                           SPA-GMN-Q100-FILENAME
               MOVE    WIDGET-INSENSITIVE
                                       TO  SPA-GMN-Q100-FILENAME-STATE
               MOVE    "ページ指定"    TO  SPA-GMN-Q100-LBLNUMSEL
           END-IF
      *
           MOVE    SPA-Q02-Q100-STNUM      TO  SPA-GMN-Q100-STNUM
           MOVE    SPA-Q02-Q100-EDNUM      TO  SPA-GMN-Q100-EDNUM
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           MOVE    MCP-WIDGET          TO        WRK-MCP-WIDGET
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *     戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *     確定
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 490-KAKUTEI
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                             SECTION.
      *
           MOVE    MCP-WIDGET          TO        WRK-MCP-WIDGET
      *
      *    入力個所のセット
           PERFORM 400-GMN-INPUT-SEC
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
      *
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       400-GMN-INPUT-SEC           SECTION.
      *
           MOVE    ZERO        TO      SPA-GMN-Q100-CUR
      *
           .
      *
       400-GMN-INPUT-EXT.
           EXIT.
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC           SECTION.
      *
      *    画面をＳＰＡにセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
      *    ファイル名チェック
           PERFORM 4100-FILENAME-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  410-INPUT-CHK-EXT
           END-IF
      *
      *    開始件数（ページ数）チェック
           PERFORM 4100-STNUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  410-INPUT-CHK-EXT
           END-IF
      *
      *    終了件数（ページ数）チェック
           PERFORM 4100-EDNUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  410-INPUT-CHK-EXT
           END-IF
      *
           .
      *
       410-INPUT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    画面ＳＰＡ編集処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC        SECTION.
      *
      *    ファイル名
           MOVE    Q100-FILENAME   TO  SPA-GMN-Q100-FILENAME
      *
      *    開始件数（ページ数）
           MOVE    Q100-STNUM      TO  SPA-GMN-Q100-STNUM
      *
      *    終了件数（ページ数）
           MOVE    Q100-EDNUM      TO  SPA-GMN-Q100-EDNUM
      *
           .
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *****************************************************************
      *    ファイル名チェック
      *****************************************************************
       4100-FILENAME-CHK-SEC           SECTION.
      *
           .
       4100-FILENAME-CHK-EXT.
           EXIT.
      *****************************************************************
      *    開始件数（ページ数）チェック
      *****************************************************************
       4100-STNUM-CHK-SEC              SECTION.
      *
           MOVE    SPA-GMN-Q100-STNUM
                                   TO  WRK-NUM
      *
      *    件数（ページ数）範囲チェック
           PERFORM 4100-NUM-HANI-CHK-SEC
      *
           MOVE    WRK-NUM         TO  SPA-GMN-Q100-STNUM
      *
           .
       4100-STNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    終了件数（ページ数）チェック
      *****************************************************************
       4100-EDNUM-CHK-SEC              SECTION.
      *
           MOVE    SPA-GMN-Q100-EDNUM
                                   TO  WRK-NUM
      *
      *    件数（ページ数）範囲チェック
           PERFORM 4100-NUM-HANI-CHK-SEC
      *
           MOVE    WRK-NUM         TO  SPA-GMN-Q100-EDNUM
      *
           .
       4100-STNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    件数（ページ数）範囲チェック
      *****************************************************************
       4100-NUM-HANI-CHK-SEC           SECTION.
      *
           IF    ( WRK-NUM         <   1 )
               MOVE    1           TO  WRK-NUM
           END-IF
      *
           IF    ( WRK-NUM         >   SPA-Q02-Q100-EDNUM )
               MOVE    SPA-Q02-Q100-EDNUM
                                   TO  WRK-NUM
           END-IF
      *
           .
       4100-NUM-HANI-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    ZERO                TO  SPA-Q02-Q100-RTOK-FLG
      *
           MOVE    "Q02"               TO  SPA-SAKIPG
           MOVE    "Q100"              TO  SPA-MOTOPG
      *
      *****MOVE    "BACK"              TO  MCP-PUTTYPE
           MOVE    "JOIN"              TO  MCP-PUTTYPE.
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    確定　処理
      *****************************************************************
       490-KAKUTEI                 SECTION.
      *
      *    入力時チェック
           PERFORM 410-INPUT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  490-KAKUTEI-EXT
           END-IF
      *
      *    出力ファイル名未入力チェック（ＣＳＶ出力時）
           IF  ( SPA-Q02-Q100-PROC-FLG     =   ZERO )
               IF  ( SPA-GMN-Q100-FILENAME
                                       =   SPACE )
                   MOVE    "1001"      TO  SPA-ERRCD
                   MOVE    1           TO  SPA-GMN-Q100-CUR
                   GO  TO  490-KAKUTEI-EXT
               END-IF
           END-IF
      *
      *    件数(ぺージ数）指定チェック
           IF  ( SPA-GMN-Q100-STNUM    >   SPA-GMN-Q100-EDNUM )
      *
               IF  ( SPA-Q02-Q100-PROC-FLG =   ZERO )
                   MOVE    "1002"      TO  SPA-ERRCD
               ELSE
                   MOVE    "1003"      TO  SPA-ERRCD
               END-IF
      *
               MOVE    2           TO  SPA-GMN-Q100-CUR
               GO  TO  490-KAKUTEI-EXT
           END-IF
      *
      *    Ｑ０２に戻る
           MOVE    SPA-GMN-Q100-FILENAME
                                       TO  SPA-Q02-Q100-FILENAME
      *
           IF  ( SPA-Q02-Q100-PROC-FLG     =   1 )
      *        開始件数
               COMPUTE SPA-Q02-Q100-STKNS
                   = ( SPA-GMN-Q100-STNUM  -   1 ) *   CONST-LINE  +   1
      *        終了件数
               COMPUTE SPA-Q02-Q100-EDKNS
                   =   SPA-GMN-Q100-EDNUM          *   CONST-LINE
      *        開始ページ
               MOVE    SPA-GMN-Q100-STNUM
                                       TO  SPA-Q02-Q100-STPAGE
      *        終了ページ
               MOVE    SPA-GMN-Q100-EDNUM
                                       TO  SPA-Q02-Q100-EDPAGE
           ELSE
      *        開始件数
               MOVE    SPA-GMN-Q100-STNUM
                                       TO  SPA-Q02-Q100-STKNS
      *        終了件数
               MOVE    SPA-GMN-Q100-EDNUM
                                       TO  SPA-Q02-Q100-EDKNS
           END-IF
      *
           MOVE    1                   TO  SPA-Q02-Q100-RTOK-FLG
      *
           MOVE    "Q02"               TO  SPA-SAKIPG
           MOVE    "Q100"              TO  SPA-MOTOPG
      *
           MOVE    "JOIN"              TO  MCP-PUTTYPE
           MOVE    "Q02"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       490-KAKUTEI-EXT.
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
           MOVE    "Q100"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC                  SECTION.
      *
      *    メッセージコード
           MOVE    SPA-GMN-Q100-CD     TO  Q100-ID1CODE
      *
      *    メッセージ
           MOVE    SPA-GMN-Q100-MSG    TO  Q100-ID1MSG
      *
      *    ファイル名（ラベル）
           MOVE    SPA-GMN-Q100-LBLFILENAME
                                       TO  Q100-LBLFILENAME
      *
      *    ファイル名
           MOVE    SPA-GMN-Q100-FILENAME
                                       TO  Q100-FILENAME
           MOVE    SPA-GMN-Q100-FILENAME-STATE
                                       TO  Q100-FILENAME-STATE
      *
      *    ファイル名（ラベル）
           MOVE    SPA-GMN-Q100-LBLNUMSEL
                                       TO  Q100-LBLNUMSEL
      *
      *    開始件数（ページ）数
           MOVE    SPA-GMN-Q100-STNUM
                                       TO  Q100-STNUM
      *
      *    終了件数（ページ）数
           MOVE    SPA-GMN-Q100-EDNUM
                                       TO  Q100-EDNUM
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
           IF     (SPA-ERRCD           =   SPACE)  AND
                  (SPA-GMN-Q100-CUR    =   ZERO )
               PERFORM 5011-INPUT-CUR-SEC
           END-IF
      *
           EVALUATE    SPA-GMN-Q100-CUR
      *
      *    ファイル名
           WHEN   001
               MOVE  "FILENAME"    TO  MCP-WIDGET
      *
      *    開始件数（ページ）数
           WHEN   002
               MOVE  "STNUM"       TO  MCP-WIDGET
      *
      *    終了件数（ページ）数
           WHEN   003
               MOVE  "EDNUM"       TO  MCP-WIDGET
      *
      *    確定ボタン
           WHEN   004
               MOVE  "B12"         TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       5011-INPUT-CUR-SEC          SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
      *
      *    表題
           WHEN    "FILENAME"
               MOVE    001         TO  SPA-GMN-Q100-CUR
      *
      *    条件上段
           WHEN    "STNUM"
               MOVE    002         TO  SPA-GMN-Q100-CUR
      *
      *    条件下段
           WHEN    "EDNUM"
               MOVE    003         TO  SPA-GMN-Q100-CUR
      *
           END-EVALUATE
      *
      *    次カーソル位置を設定
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "EDNUM"
               MOVE    004         TO  SPA-GMN-Q100-CUR
           WHEN    OTHER
               COMPUTE SPA-GMN-Q100-CUR    =   SPA-GMN-Q100-CUR +   1
           END-EVALUATE
      *
           .
      *
       5011-INPUT-CUR-EXT.
           EXIT.
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
           WHEN    "1001"
               MOVE    "出力ファイル名が入力されいていません"
                                       TO  SPA-ERRMSG
           WHEN    "1002"
               MOVE    "開始件数＞終了件数となっています"
                                       TO  SPA-ERRMSG
           WHEN    "1003"
               MOVE    "開始ページ＞終了ページとなっています"
                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  QERR
           MOVE    SPA-ERRCD            TO  QERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  QERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "Q100"               TO  SPA-MOTOPG
           MOVE    "QERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "QERR"               TO  MCP-WINDOW
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
           CALL   "ORCMCPSUB"   USING
                                MCPAREA
                                ORCMCPAREA
                                MCPDATA-REC.
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
