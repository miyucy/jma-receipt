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
       PROGRAM-ID.             ORCGT98.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 総括表・公費請求書
      *  コンポーネント名  : オンライン請求−レセ電作成指示
      *  管理者            : 
      *  作成日付    作業者        記述
      *  08/09/05    NACL−藤原    新規作成
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
           COPY    "COMMON-SPA".
      *
           COPY    "T01COMMON-SPA".
      *
           COPY    "T06SCR-SPA".
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-MCP-WIDGET      PIC X(64).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-TOUROKU         PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    クライアント保存可否情報取得サブ
           COPY    "CPORCSCLIENTSV.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
      *****************************************************************
      *    連絡領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "T01.INC".
           COPY    "T02.INC".
           COPY    "T03.INC".
           COPY    "T04.INC".
           COPY    "T05.INC".
           COPY    "T06.INC".
           COPY    "T07.INC".
           COPY    "T08.INC".
           COPY    "T09.INC".
           COPY    "T91.INC".
           COPY    "T98.INC".
           COPY    "T99.INC".
           COPY    "TERR.INC".
           COPY    "TID1.INC".
           COPY    "TID2.INC".
           COPY    "TFIL.INC".
      *
       PROCEDURE                   DIVISION    USING
                                               MCPAREA
                                               SPAAREA
                                               LINKAREA
                                               SCRAREA.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-T06
           MOVE    SPA-WORK        TO  SPA-T01KYOUTU
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
           MOVE    SPA-T01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-T06         TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
                                       WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "TERR"
               MOVE    SPACE               TO  SPA-MOTOPG
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
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "T98"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           INITIALIZE                  SPA-T98-AREA
      *
      *    クライアント保存可否情報取得サブ
           INITIALIZE                      ORCSCLIENTSVAREA
           CALL    "ORCSCLIENTSV"  USING   ORCSCLIENTSVAREA
                                           SPA-AREA
      *
           MOVE    "1"             TO  SPA-GMN-T98-DATAKBNL        (1)
           MOVE    "フロッピィ"    TO  SPA-GMN-T98-DATAKBNMEIL     (1)
           MOVE    "2"             TO  SPA-GMN-T98-DATAKBNL        (2)
           MOVE    "ＭＯ"          TO  SPA-GMN-T98-DATAKBNMEIL     (2)
           MOVE    "3"             TO  SPA-GMN-T98-DATAKBNL        (3)
           MOVE    "システム管理設定場所（フロッピィ用）"
                                   TO  SPA-GMN-T98-DATAKBNMEIL     (3)
           MOVE    "4"             TO  SPA-GMN-T98-DATAKBNL        (4)
           MOVE    "システム管理設定場所（ＭＯ用）"
                                   TO  SPA-GMN-T98-DATAKBNMEIL     (4)
           MOVE    4               TO  SPA-GMN-T98-DATAKBN-MAX
           IF      SCLIENTSV-CLIENT-SAVE
                                   =   "1"
               MOVE    "5"             TO  SPA-GMN-T98-DATAKBNL    (5)
               MOVE    "クライアント保存"
                                       TO  SPA-GMN-T98-DATAKBNMEIL (5)
               MOVE    5               TO  SPA-GMN-T98-DATAKBN-MAX
           END-IF
      *
           MOVE    "1"                 TO  SPA-GMN-T98-PRTKBNL     (1)
           MOVE    "提出用"            TO  SPA-GMN-T98-PRTKBNMEIL  (1)
           MOVE    "2"                 TO  SPA-GMN-T98-PRTKBNL     (2)
           MOVE    "点検用（院外処方含）"
                                       TO  SPA-GMN-T98-PRTKBNMEIL  (2)
           MOVE    2                   TO  SPA-GMN-T98-PRTKBN-MAX
      *
           MOVE    SPA-GMN-T98-PRTKBNLST (1)
                                       TO  SPA-GMN-T98-PRTKBN-G
           MOVE    SPA-GMN-T98-DATAKBNLST (1)
                                       TO  SPA-GMN-T98-DATAKBN-G
      *
           MOVE    1               TO  SPA-GMN-T98-CUR
           .
      *
       300-SCREEN-EXT.
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
                   MOVE    SPACE       TO  SPA-TID1-FLG
                   PERFORM 210-BACK
      *     確定
               WHEN    "CLICKED"       ALSO    "B11"
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 450-KAKUTEI-SEC
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        一括分
               WHEN    "ACTIVATE"       ALSO    ANY
                   PERFORM 400-ENTRY-SYORI-SEC
           END-EVALUATE
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    一括分入力処理
      *****************************************************************
       400-ENTRY-SYORI-SEC             SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           MOVE    ZERO                TO  SPA-GMN-T98-CUR
      *
      *    入力チェック処理
           MOVE    ZERO                TO  FLG-TOUROKU
           PERFORM 410-INPUT-CHK-SEC
           .
       400-ENTRY-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC       SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *    基本チェック処理
           PERFORM 4102-KIHON-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      410-INPUT-CHK-EXT
           END-IF
      *
           IF      FLG-TOUROKU         =   1
      *        更新前チェック処理
               PERFORM 4103-KAKUTEI-CHK-SEC
           END-IF
      *
           .
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面をＳＰＡセット処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC       SECTION.
      *
           MOVE    T98-DATA            TO  SPA-GMN-T98-DATAKBN-G
           MOVE    T98-PRTKBN          TO  SPA-GMN-T98-PRTKBN-G
      *
           .
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC       SECTION.
      *
           PERFORM 41021-DATAKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 41022-PRTKBN-CHK-SEC
      *
           .
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイル出力先入力処理
      *****************************************************************
       41021-DATAKBN-CHK-SEC            SECTION.
      *
           IF      SPA-GMN-T98-DATAKBN     =   SPACE
               MOVE    SPA-GMN-T98-DATAKBNLST (1)
                                           TO  SPA-GMN-T98-DATAKBN-G
           ELSE
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SPA-GMN-T98-DATAKBN-MAX
                   IF        SPA-GMN-T98-DATAKBN
                                   =   SPA-GMN-T98-DATAKBNL (IDX)
                       MOVE    SPA-GMN-T98-DATAKBNMEIL (IDX)
                                           TO  SPA-GMN-T98-DATAKBNMEI
                       MOVE    SPA-GMN-T98-DATAKBN-MAX
                                           TO  IDX
                   END-IF
               END-PERFORM        
               IF      SPA-GMN-T98-DATAKBNMEI  =   SPACE  
                   MOVE    SPA-GMN-T98-DATAKBNLST (1)
                                               TO  SPA-GMN-T98-DATAKBN-G
               END-IF
           END-IF
           .
       41021-DATAKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセ電データ作成区分  入力処理
      *****************************************************************
       41022-PRTKBN-CHK-SEC          SECTION.
      *
           IF      SPA-GMN-T98-PRTKBN   =   SPACE
               MOVE    SPA-GMN-T98-PRTKBNLST (1)
                                           TO  SPA-GMN-T98-PRTKBN-G
           ELSE
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SPA-GMN-T98-PRTKBN-MAX
                   IF        SPA-GMN-T98-PRTKBN
                                   =   SPA-GMN-T98-PRTKBNL (IDX)
                       MOVE    SPA-GMN-T98-PRTKBNMEIL (IDX)
                                           TO  SPA-GMN-T98-PRTKBNMEI
                       MOVE    SPA-GMN-T98-PRTKBN-MAX
                                           TO  IDX
                   END-IF
               END-PERFORM        
               IF      SPA-GMN-T98-PRTKBNMEI  =   SPACE  
                   MOVE    SPA-GMN-T98-PRTKBNLST (1)
                                               TO  SPA-GMN-T98-PRTKBN-G
               END-IF
           END-IF
           .
       41022-PRTKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    確定ボタン押下時チェック処理
      *****************************************************************
       4103-KAKUTEI-CHK-SEC        SECTION.
      *
      *
           .
       4103-KAKUTEI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る処理
      *****************************************************************
       210-BACK                    SECTION.
      *   
           MOVE    "T06"               TO  SPA-SAKIPG
           MOVE    "T98"               TO  SPA-MOTOPG
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
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
      *    確定処理
      *****************************************************************
       450-KAKUTEI-SEC                SECTION.
      *
           MOVE    1                  TO  FLG-TOUROKU
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  450-KAKUTEI-EXT
           END-IF
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
               WHEN    "CLICKED"       ALSO    "B11"
                   MOVE    "NO"            TO  SPA-TID1-FLG
               WHEN    "CLICKED"       ALSO    "B12"
                   MOVE    "OK"            TO  SPA-TID1-FLG
           END-EVALUATE
      *
           PERFORM 210-BACK
           .
       450-KAKUTEI-EXT.
           EXIT.
      *
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
           MOVE    "CURRENT"           TO  MCP-PUTTYPE
           MOVE    "T98"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           INITIALIZE                  T98
      *
           MOVE
               "レセプト電算データを作成します（症状詳記の印刷を指定）"
                                       TO  T98-ID1MSG
      *
           MOVE    SPA-GMN-T98-DATAKBN-G
                                       TO  T98-DATA
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       SPA-GMN-T98-DATAKBN-MAX
               MOVE    SPA-GMN-T98-DATAKBNLST (IDX)
                                           TO  T98-DATA-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-GMN-T98-DATAKBN-MAX TO  T98-DATA-COUNT
      *
           MOVE    SPA-GMN-T98-PRTKBN-G
                                       TO  T98-PRTKBN
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       SPA-GMN-T98-PRTKBN-MAX
               MOVE    SPA-GMN-T98-PRTKBNLST (IDX)
                                           TO  T98-PRTKBN-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-GMN-T98-PRTKBN-MAX  TO  T98-PRTKBN-COUNT
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
           IF    ( SPA-ERRCD           =   SPACE )
           AND   ( SPA-GMN-T98-CUR     =   ZERO  )
               PERFORM 50011-INPUT-CUR-SEC
           END-IF
      *
         EVALUATE    SPA-GMN-T98-CUR
             WHEN    1
                    MOVE  "PRTKBN"       TO  MCP-WIDGET
             WHEN    2
                    MOVE  "DATA"         TO  MCP-WIDGET
             WHEN    99
                    MOVE  "B12"          TO  MCP-WIDGET
         END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       50011-INPUT-CUR-SEC             SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
               WHEN    "PRTKBN"
                   MOVE    2               TO  SPA-GMN-T98-CUR
               WHEN    "DATA"
                   MOVE    99              TO  SPA-GMN-T98-CUR
               WHEN    OTHER
                   MOVE    99              TO  SPA-GMN-T98-CUR
           END-EVALUATE
           .
      *
       50011-INPUT-CUR-EXT.
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
               WHEN    "9999"
                   MOVE    SPACE       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  TERR
           MOVE    SPA-ERRCD           TO  TERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  TERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "T98"               TO  SPA-MOTOPG
           MOVE    "TERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "TERR"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END              
      *
           .
       510-ERRMSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルアクセス処理
      *****************************************************************
       900-ORCDBMAIN-SEC               SECTION.
      *
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
      *
       900-ORCDBMAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"          TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
           .
      *
       900-PUT-WINDOW-EXT.
           EXIT.
