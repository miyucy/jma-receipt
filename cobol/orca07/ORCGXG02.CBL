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
       PROGRAM-ID.                 ORCGXG02.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 統計ＣＳＶ出力
      *  コンポーネント名  : 出力指示画面
      *  管理者            : 
      *  作成日付    作業者        記述
      *  09/09/30    NACL-藤原     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
      *
       DATA                        DIVISION.
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    共通パラメタ
           COPY    "XG01COMMON-SPA".
      *
      *    画面用ＳＰＡ
           COPY    "XG01SCR-SPA".
      *
           COPY    "ENUM-VALUE".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-TOUROKU         PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                PIC 9(05).
           03  IDX2                PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-MCP-WIDGET      PIC X(64).
      *
       01  WRK-CONS-AREA.
      *    ジョブ管理ＤＢのキー値  
           03  WRK-CONS-JOB-SHELLID
                                   PIC X(08)   VALUE   "PUTCSV".
           03  WRK-CONS-JOB-JOBID  PIC 9(07)   VALUE   1.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    クライアント保存可否情報取得サブ
           COPY    "CPORCSCLIENTSV.INC".
      *
      *****************************************************************
      *    連絡領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    MCPAREA.
           COPY    "ORCA-SPA".
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "XG01.INC".
           COPY    "XG02.INC".
           COPY    "XG99.INC".
           COPY    "XGFIL.INC".
           COPY    "XGERR.INC".
           COPY    "XGID1.INC".
      *
      ******************************************************************
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  IDX-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-XG01FREE
           MOVE    SPA-WORK        TO  SPA-XG01KYOUTU 
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS  ALSO    MCP-EVENT
               WHEN    "LINK"      ALSO    ANY
                   PERFORM 100-INIT-SEC
      *        画面遷移
               WHEN     "PUTG"     ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *        入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END         =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-XG01KYOUTU  TO  SPA-WORK  
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-XG01FREE    TO  SPA-FREE
      *
           EXIT    PROGRAM.
           .
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
      *    エラー画面からの戻り時
           IF      SPA-MOTOPG      =   "XGERR"
               MOVE    SPACE           TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面処理
               PERFORM 300-SCREEN-SEC
               IF      FLG-END         =   1
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集処理
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE    SPACE           TO  MCP-PUTTYPE
           MOVE    "XG02"          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1               TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           INITIALIZE              SPA-XG02-AREA
      *
      *    クライアント保存可否情報取得サブ
           INITIALIZE                      ORCSCLIENTSVAREA
           CALL    "ORCSCLIENTSV"  USING   ORCSCLIENTSVAREA
                                           SPA-AREA
           MOVE    SCLIENTSV-CLIENT-SAVE
                                   TO  SPA-XG02-CLIENT-SAVE
           IF      SPA-XG02-CLIENT-SAVE
                                   =   "1"
               MOVE    "1"             TO  SPA-GMN-XG02-FILEL   (1)
               MOVE    "クライアント保存"
                                       TO  SPA-GMN-XG02-FILEMEIL(1)
               MOVE    1               TO  SPA-GMN-XG02-FILE-MAX
           END-IF
           MOVE    "1"             TO  SPA-GMN-XG02-CDKBNL   (1)
           MOVE    "ＥＵＣ"        TO  SPA-GMN-XG02-CDKBNMEIL(1)
           MOVE    "2"             TO  SPA-GMN-XG02-CDKBNL   (2)
           MOVE    "Ｓ−ｊｉｓ"    TO  SPA-GMN-XG02-CDKBNMEIL(2)
           MOVE    2               TO  SPA-GMN-XG02-CDKBN-MAX
           MOVE    SPA-GMN-XG02-CDKBNLST (1)
                                   TO  SPA-GMN-XG02-CDKBN-G
      *
           STRING   SPA-NAI-TTO-FOLDER (SPA-NAI-SELNUM)
                                           DELIMITED   BY  SPACE
                    "/"                    DELIMITED   BY  SIZE
                    SPA-NAI-TTO-DATA   (SPA-NAI-SELNUM)
                                           DELIMITED   BY  SPACE
                                           INTO    SPA-GMN-XG02-FILENAME
           END-STRING
      *
           MOVE  1                 TO  SPA-GMN-XG02-CUR
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                 SECTION.
      *
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"   ALSO    "B01"
                   MOVE    SPACE           TO  SPA-XGID1-FLG
                   PERFORM 210-BACK
      *        確定
               WHEN    "CLICKED"   ALSO    "B12"
                   PERFORM 490-KAKUTEI
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話処理
      *****************************************************************
       200-ENTRY                             SECTION.
      *
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
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
           MOVE    ZERO                TO  SPA-GMN-XG02-CUR
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
       410-INPUT-CHK-SEC           SECTION.
      *
      *    画面をＳＰＡにセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
      *    基本チェック処理
           PERFORM 4102-KIHON-CHK-SEC
           IF      SPA-ERRCD   NOT =   SPACE
               GO  TO  410-INPUT-CHK-EXT
           END-IF
      *
           IF      FLG-TOUROKU     =   1
      *        更新前
               PERFORM 4103-KAKUTEI-CHK-SEC
           END-IF
      *
           .
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ＳＰＡ編集処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC        SECTION.
      *
           MOVE    XG02-FILENAME   TO  SPA-GMN-XG02-FILENAME
           MOVE    XG02-FILE       TO  SPA-GMN-XG02-FILE-G
           MOVE    XG02-CDKBN      TO  SPA-GMN-XG02-CDKBN-G
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
      *    ファイル名チェック
           PERFORM 41021-FILENAME-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    出力先チェック
           PERFORM 41022-FILE-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    文字コードチェック
           PERFORM 41023-CDKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
           .
       4102-KIHON-CHK-EXT.
           EXIT.
      *****************************************************************
      *    ファイル名チェック
      *****************************************************************
       41021-FILENAME-CHK-SEC           SECTION.
      *
           IF      SPA-GMN-XG02-FILENAME   =   SPACE
               STRING   SPA-NAI-TTO-FOLDER (SPA-NAI-SELNUM)
                                               DELIMITED   BY  SPACE
                        "/"                    DELIMITED   BY  SIZE
                        SPA-NAI-TTO-DATA   (SPA-NAI-SELNUM)
                                               DELIMITED   BY  SPACE
                                           INTO    SPA-GMN-XG02-FILENAME
               END-STRING
           ELSE
               PERFORM VARYING IDX2    FROM    1   BY  1
                       UNTIL   IDX2    >       100
                       OR      SPA-GMN-XG02-FILENAME (IDX2:1)
                                           =   SPACE
                   IF        SPA-GMN-XG02-FILENAME (IDX2:1)
                                               =   "\" OR  ":" 
                       MOVE    "1004"              TO  SPA-ERRCD
                       MOVE    1                   TO  SPA-GMN-XG02-CUR
                       MOVE    100                 TO  IDX2
                   END-IF
               END-PERFORM        
           END-IF
           .
       41021-FILENAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    出力先チェック処理
      *****************************************************************
       41022-FILE-CHK-SEC          SECTION.
      *
           PERFORM VARYING IDX2 FROM    1   BY  1
                   UNTIL   IDX2 >       SPA-GMN-XG02-FILE-MAX
               IF        SPA-GMN-XG02-FILE
                                   =   SPA-GMN-XG02-FILEL (IDX2)
                   MOVE    SPA-GMN-XG02-FILEMEIL (IDX2)
                                           TO  SPA-GMN-XG02-FILEMEI
                   MOVE    SPA-GMN-XG02-FILE-MAX
                                           TO  IDX2
               END-IF
           END-PERFORM        
           .
       41022-FILE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    文字コードチェック処理
      *****************************************************************
       41023-CDKBN-CHK-SEC           SECTION.
      *
           IF      SPA-GMN-XG02-CDKBN  =   SPACE
               IF      SPA-GMN-XG02-FILE   =   "1"
                   MOVE    SPA-GMN-XG02-CDKBNLST (1)
                                           TO  SPA-GMN-XG02-CDKBN-G
               END-IF
           ELSE
               PERFORM VARYING IDX2    FROM   1   BY  1
                       UNTIL   IDX2    >      SPA-GMN-XG02-CDKBN-MAX
                   IF        SPA-GMN-XG02-CDKBN
                                       =   SPA-GMN-XG02-CDKBNL (IDX2)
                       MOVE    SPA-GMN-XG02-CDKBNMEIL (IDX2)
                                               TO  SPA-GMN-XG02-CDKBNMEI
                       MOVE    SPA-GMN-XG02-CDKBN-MAX
                                               TO  IDX2
                   END-IF
               END-PERFORM        
               IF      SPA-GMN-XG02-CDKBNMEI   =   SPACE  
                   MOVE    SPA-GMN-XG02-CDKBNLST (1)
                                           TO  SPA-GMN-XG02-CDKBN-G
               END-IF
           END-IF
           .
       41023-CDKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    確定ボタン押下時チェック処理
      *****************************************************************
       4103-KAKUTEI-CHK-SEC        SECTION.
      *
      *    出力ファイル名未入力チェック
           IF  (   SPA-GMN-XG02-FILENAME
                                   =   SPACE )
               MOVE    "1001"          TO  SPA-ERRCD
               MOVE    1               TO  SPA-GMN-XG02-CUR
               GO  TO  4103-KAKUTEI-CHK-EXT
           END-IF
      *
           MOVE    SPA-NAI-TTO-FOLDER (SPA-NAI-SELNUM)
                                       TO  SPA-NAI-XG02-TO-FOLDER
           MOVE    SPA-NAI-TTO-DATA   (SPA-NAI-SELNUM)
                                       TO  SPA-NAI-XG02-TO-DATA
           .
       4103-KAKUTEI-CHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    戻る処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "XG01"          TO  SPA-SAKIPG
           MOVE    "XG02"          TO  SPA-MOTOPG
      *
           MOVE    "JOIN"          TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG      TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1               TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    確定処理
      *****************************************************************
       490-KAKUTEI                 SECTION.
      *
      *    入力時チェック
           MOVE    1               TO  FLG-TOUROKU
           PERFORM 410-INPUT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  490-KAKUTEI-EXT
           END-IF
      *
           MOVE    "OK"            TO  SPA-XGID1-FLG
      *
           PERFORM 210-BACK
      *
           .
       490-KAKUTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD   NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE           TO  LINKAREA
      *
           MOVE    "CURRENT"       TO  MCP-PUTTYPE
           MOVE    "XG02"          TO  MCP-WINDOW
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
           INITIALIZE                  XG02
      *
           MOVE    SPA-GMN-XG02-FILENAME
                                   TO  XG02-FILENAME
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL   IDX2    >       SPA-GMN-XG02-FILE-MAX
               MOVE    SPA-GMN-XG02-FILELST (IDX2)
                                           TO  XG02-FILE-ITEM (IDX2)
           END-PERFORM
           MOVE    SPA-GMN-XG02-FILE-MAX   TO  XG02-FILE-COUNT
           MOVE    SPA-GMN-XG02-FILE-G     TO  XG02-FILE
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL   IDX2    >       SPA-GMN-XG02-CDKBN-MAX
               MOVE    SPA-GMN-XG02-CDKBNLST (IDX2)
                                           TO  XG02-CDKBN-ITEM (IDX2)
           END-PERFORM
           MOVE    SPA-GMN-XG02-CDKBN-MAX  TO  XG02-CDKBN-COUNT
           MOVE    SPA-GMN-XG02-CDKBN-G    TO  XG02-CDKBN
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
           IF    ( SPA-ERRCD           =   SPACE ) AND
                 ( SPA-GMN-XG02-CUR    =   ZERO  )
               PERFORM 5011-INPUT-CUR-SEC
           END-IF
      *
           EVALUATE    SPA-GMN-XG02-CUR
               WHEN    1
                   MOVE    "FILENAME"    TO  MCP-WIDGET
               WHEN    2
                   MOVE    "FILE"        TO  MCP-WIDGET
               WHEN    3
                   MOVE    "CDKBN"       TO  MCP-WIDGET
               WHEN    99
                   MOVE    "B12"         TO  MCP-WIDGET
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
               WHEN    "FILENAME"
                   IF      SPA-XG02-CLIENT-SAVE
                                           =   "1"
                       MOVE    2           TO  SPA-GMN-XG02-CUR
                   ELSE
                       MOVE    3           TO  SPA-GMN-XG02-CUR
                   END-IF
               WHEN   "FILE"
                   MOVE    3           TO  SPA-GMN-XG02-CUR
               WHEN   "CDKBN"
                   MOVE    99          TO  SPA-GMN-XG02-CUR
           END-EVALUATE
           .
      *
       5011-INPUT-CUR-EXT.
           EXIT.
      *****************************************************************
      *    エラーメッセージ表示処理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    SPACE           TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
           WHEN    "1001"
               MOVE    "出力ファイル名が入力されていません"
                                       TO  SPA-ERRMSG
           WHEN    "1004"
               STRING   "出力ファイル名に" DELIMITED  BY  SIZE
                        "”：”、”￥”が入力してあります"
                                             DELIMITED  BY  SIZE
                                             INTO  SPA-ERRMSG
               END-STRING
           END-EVALUATE
      *
           MOVE    SPACE           TO  XGERR
           MOVE    SPA-ERRCD       TO  XGERR-ERRCODE
           MOVE    SPA-ERRMSG      TO  XGERR-ERRMSG
           MOVE    "B01"           TO  MCP-WIDGET
      *
           MOVE    "XG02"          TO  SPA-MOTOPG
           MOVE    "XGERR"         TO  SPA-SAKIPG
      *
           MOVE    "NEW"           TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG      TO  MCP-WINDOW
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
      *    ＰＵＴ処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE    "PUTWINDOW"     TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
