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
       PROGRAM-ID.                 ORCGI22.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者照会
      *  コンポーネント名  : 出力指示画面（Ｉ２２）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/10/14    NACL-太田     新規作成
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
      *FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    入院患者照会共通ＳＰＡ
           COPY    "I2SCR-SPA".
      *
      *    入院患者照会用共通パラメタ
           COPY    "I2COMMON-SPA".
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
           COPY    "I20.INC".
           COPY    "I21.INC".
           COPY    "I22.INC".
           COPY    "I23.INC".
           COPY    "I2ERR.INC".
           COPY    "I2ID1.INC".
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
                                       IDX-AREA
                                       WRK-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-I2FREE
           MOVE    SPA-WORK        TO  SPA-I2KYOUTU
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
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-I2KYOUTU    TO  SPA-WORK  
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-I2FREE      TO  SPA-FREE
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
           IF  ( SPA-MOTOPG            =   "I2ERR" )
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
           MOVE    "I22"               TO  MCP-WINDOW
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
           MOVE    SPACE               TO  SPA-I22-AREA
           INITIALIZE                      SPA-I22-AREA
      *
           MOVE  4                     TO  SPA-GMN-I22-CUR
      *
           IF  ( SPA-I20-I22-PROC-FLG     =   ZERO )
      *        ＣＳＶ出力処理
               MOVE    "3001"          TO  SPA-GMN-I22-CD
               MOVE    "ＣＳＶ出力を開始します"
                                       TO  SPA-GMN-I22-MSG
               MOVE    "出力ファイル名"
                                       TO  SPA-GMN-I22-LBLFILENAME
               MOVE    "/tmp/OUTPUT.csv"
                                       TO  SPA-GMN-I22-FILENAME
               MOVE    WIDGET-NORMAL   TO  SPA-GMN-I22-FILENAME-STATE
               MOVE    "件数指定"      TO  SPA-GMN-I22-LBLNUMSEL
           ELSE
               MOVE    "3002"          TO  SPA-GMN-I22-CD
               MOVE    "印刷処理を開始します"
                                       TO  SPA-GMN-I22-MSG
               MOVE    SPACE           TO  SPA-GMN-I22-LBLFILENAME
                                           SPA-GMN-I22-FILENAME
               MOVE    WIDGET-INSENSITIVE
                                       TO  SPA-GMN-I22-FILENAME-STATE
               MOVE    "ページ指定"    TO  SPA-GMN-I22-LBLNUMSEL
           END-IF
      *
           MOVE    SPA-I20-I22-STNUM      TO  SPA-GMN-I22-STNUM
           MOVE    SPA-I20-I22-EDNUM      TO  SPA-GMN-I22-EDNUM
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
           MOVE    ZERO        TO      SPA-GMN-I22-CUR
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
           MOVE    I22-FILENAME   TO  SPA-GMN-I22-FILENAME
      *
      *    開始件数（ページ数）
           MOVE    I22-STNUM      TO  SPA-GMN-I22-STNUM
      *
      *    終了件数（ページ数）
           MOVE    I22-EDNUM      TO  SPA-GMN-I22-EDNUM
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
           MOVE    SPA-GMN-I22-STNUM
                                   TO  WRK-NUM
      *
      *    件数（ページ数）範囲チェック
           PERFORM 4100-NUM-HANI-CHK-SEC
      *
           MOVE    WRK-NUM         TO  SPA-GMN-I22-STNUM
      *
           .
       4100-STNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    終了件数（ページ数）チェック
      *****************************************************************
       4100-EDNUM-CHK-SEC              SECTION.
      *
           MOVE    SPA-GMN-I22-EDNUM
                                   TO  WRK-NUM
      *
      *    件数（ページ数）範囲チェック
           PERFORM 4100-NUM-HANI-CHK-SEC
      *
           MOVE    WRK-NUM         TO  SPA-GMN-I22-EDNUM
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
           IF    ( WRK-NUM         >   SPA-I20-I22-EDNUM )
               MOVE    SPA-I20-I22-EDNUM
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
           MOVE    ZERO                TO  SPA-I20-I22-RTOK-FLG
      *
           MOVE    "I20"               TO  SPA-SAKIPG
           MOVE    "I22"              TO  SPA-MOTOPG
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
           IF  ( SPA-I20-I22-PROC-FLG     =   ZERO )
               IF  ( SPA-GMN-I22-FILENAME
                                       =   SPACE )
                   MOVE    "1001"      TO  SPA-ERRCD
                   MOVE    1           TO  SPA-GMN-I22-CUR
                   GO  TO  490-KAKUTEI-EXT
               END-IF
           END-IF
      *
      *    件数(ぺージ数）指定チェック
           IF  ( SPA-GMN-I22-STNUM    >   SPA-GMN-I22-EDNUM )
      *
               IF  ( SPA-I20-I22-PROC-FLG =   ZERO )
                   MOVE    "1002"      TO  SPA-ERRCD
               ELSE
                   MOVE    "1003"      TO  SPA-ERRCD
               END-IF
      *
               MOVE    2           TO  SPA-GMN-I22-CUR
               GO  TO  490-KAKUTEI-EXT
           END-IF
      *
      *    Ｑ０２に戻る
           MOVE    SPA-GMN-I22-FILENAME
                                       TO  SPA-I20-I22-FILENAME
      *
           IF  ( SPA-I20-I22-PROC-FLG     =   1 )
      *        開始件数
               COMPUTE SPA-I20-I22-STKNS
                   = ( SPA-GMN-I22-STNUM  -   1 ) *   CONST-LINE  +   1
      *        終了件数
               COMPUTE SPA-I20-I22-EDKNS
                   =   SPA-GMN-I22-EDNUM          *   CONST-LINE
      *        開始ページ
               MOVE    SPA-GMN-I22-STNUM
                                       TO  SPA-I20-I22-STPAGE
      *        終了ページ
               MOVE    SPA-GMN-I22-EDNUM
                                       TO  SPA-I20-I22-EDPAGE
           ELSE
      *        開始件数
               MOVE    SPA-GMN-I22-STNUM
                                       TO  SPA-I20-I22-STKNS
      *        終了件数
               MOVE    SPA-GMN-I22-EDNUM
                                       TO  SPA-I20-I22-EDKNS
           END-IF
      *
           MOVE    1                   TO  SPA-I20-I22-RTOK-FLG
      *
           MOVE    "I20"               TO  SPA-SAKIPG
           MOVE    "I22"               TO  SPA-MOTOPG
      *
           MOVE    "JOIN"              TO  MCP-PUTTYPE
           MOVE    "I20"               TO  MCP-WINDOW
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
           MOVE    "I22"              TO  MCP-WINDOW.
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
           MOVE    SPA-GMN-I22-CD     TO  I22-ID1CODE
      *
      *    メッセージ
           MOVE    SPA-GMN-I22-MSG    TO  I22-ID1MSG
      *
      *    ファイル名（ラベル）
           MOVE    SPA-GMN-I22-LBLFILENAME
                                       TO  I22-LBLFILENAME
      *
      *    ファイル名
           MOVE    SPA-GMN-I22-FILENAME
                                       TO  I22-FILENAME
           MOVE    SPA-GMN-I22-FILENAME-STATE
                                       TO  I22-FILENAME-STATE
      *
      *    ファイル名（ラベル）
           MOVE    SPA-GMN-I22-LBLNUMSEL
                                       TO  I22-LBLNUMSEL
      *
      *    開始件数（ページ）数
           MOVE    SPA-GMN-I22-STNUM
                                       TO  I22-STNUM
      *
      *    終了件数（ページ）数
           MOVE    SPA-GMN-I22-EDNUM
                                       TO  I22-EDNUM
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
                  (SPA-GMN-I22-CUR    =   ZERO )
               PERFORM 5011-INPUT-CUR-SEC
           END-IF
      *
           EVALUATE    SPA-GMN-I22-CUR
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
               MOVE    001         TO  SPA-GMN-I22-CUR
      *
      *    条件上段
           WHEN    "STNUM"
               MOVE    002         TO  SPA-GMN-I22-CUR
      *
      *    条件下段
           WHEN    "EDNUM"
               MOVE    003         TO  SPA-GMN-I22-CUR
      *
           END-EVALUATE
      *
      *    次カーソル位置を設定
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "EDNUM"
               MOVE    004         TO  SPA-GMN-I22-CUR
           WHEN    OTHER
               COMPUTE SPA-GMN-I22-CUR    =   SPA-GMN-I22-CUR +   1
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
           MOVE    SPACE                TO  I2ERR
           MOVE    SPA-ERRCD            TO  I2ERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  I2ERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "I22"                TO  SPA-MOTOPG
           MOVE    "I2ERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "I2ERR"              TO  MCP-WINDOW
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
