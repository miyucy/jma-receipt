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
       PROGRAM-ID.                               ORCGP98.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 住所検索
      *  コンポーネント名  : 周辺住所画面（P98）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC-太田      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-多々納  02/09/03  住所一覧を５０件へ変更
      *****************************************************************
      *
       ENVIRONMENT                               DIVISION.
       CONFIGURATION                             SECTION.
       INPUT-OUTPUT                              SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    患者登録用共通パラメタ
           COPY    "P02COMMON-SPA".
      *
      *    患者画面スパ領域
           COPY    "P02SCR-SPA".
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                           PIC 9(01).
           03  FLG-SYSKANRI                      PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR                           PIC 9(06).
      *
      *
      *    添字領域
       01  IDX-AREA.
           03  IDXX                              PIC 9(03).
           03  IDXY                              PIC 9(03).
           03  IDXZ                              PIC 9(03).
           03  IDX                               PIC 9(03).
      *
           03  IDX1                              PIC 9(01).
           03  IDX2                              PIC 9(02).
      *
        01 WRK-AREA.
           03  WRK-IDX3                          PIC 9(03).
      *
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *    （周辺町域情報）
           COPY    "CPSK1015.INC".
      *    住所マスタ
       01  ADRS-REC.
           COPY    "CPADRS.INC".
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "P02.INC".
           COPY    "P02A.INC".
      *****COPY    "P02B.INC".
      *****COPY    "P02C.INC".
           COPY    "P02D.INC".
           COPY    "P02E.INC".
           COPY    "P02F.INC".
           COPY    "P014.INC".
           COPY    "P98.INC".
           COPY    "P981.INC".
           COPY    "P99.INC".
           COPY    "P0201.INC".
           COPY    "P982.INC".
           COPY    "P100.INC".
           COPY    "P02X.INC".
           COPY    "PERR.INC".
           COPY    "PID1.INC".
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
           INITIALIZE                            FLG-AREA.
           INITIALIZE                            CNT-AREA.
      *
           MOVE    SPA-COMMON                    TO  SPA-AREA.
           MOVE    SPA-FREE                      TO  SPA-P02SCRAREA.
           MOVE    SPA-WORK                      TO  SPA-P02KYOUTU.
      *
           MOVE    SPACE                         TO  SPA-ERRCD.
           MOVE    ZERO                          TO  FLG-END.
      *
           EVALUATE    MCP-STATUS       ALSO    MCP-EVENT
               WHEN    "LINK"           ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN    "PUTG"           ALSO   "CLICKED"
                   PERFORM 200-GMNSENI-SEC
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY-SEC
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END                       =   ZERO
               PERFORM 330-SET-SCREEN-SEC
           END-IF.
      *
           MOVE    SPA-P02KYOUTU                 TO  SPA-WORK
           MOVE    SPA-AREA                      TO  SPA-COMMON
           MOVE    SPA-P02SCRAREA                TO  SPA-FREE
      *
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                              SECTION.
      *
           INITIALIZE                            FLG-AREA.
           INITIALIZE                            CNT-AREA.
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "PERR"
               MOVE    SPACE           TO  SPA-MOTOPG
           END-IF
      *
      *    住所登録画面より
           IF      SPA-MOTOPG          =   "P981"
               PERFORM 310-P981SPASET-SEC
           END-IF
      *
           MOVE    1                   TO  SPA-GMN98-CUR
           PERFORM  500-GMNHEN-SEC
      *
           MOVE    SPACE                         TO  LINKAREA.
      *
           MOVE    "NEW"                         TO  MCP-PUTTYPE.
           MOVE    "P98"                         TO  MCP-WINDOW.
           MOVE    "SELNUM"                      TO  MCP-WIDGET.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                             TO  FLG-END.
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       310-P981SPASET-SEC                         SECTION.
      *
           INITIALIZE                            SPA-GMN98-TABLE.
           MOVE  ZERO                        TO  SPA-GMN98-MAX
           MOVE  ZERO                        TO  SPA-GMN98-PAGE
      *    システム管理より周辺住所を取る
           INITIALIZE                            SYS-1015-REC.
           MOVE  "1015"                          TO  SYS-1015-KANRICD.
           MOVE  SYS-1015-REC                    TO  MCPDATA-REC.
      *
           MOVE  "DBSELECT"                      TO  MCP-FUNC.
           MOVE  SPA-SYSYMD                      TO  ORC-DBYMD.
           MOVE  "SYSKANRI-KEY2"                 TO  ORC-DBPATH.
           CALL  "ORCMCPSUB"                      USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC.
      *
           IF      MCP-RC                        =   ZERO
               MOVE  "SYSKANRI-KEY2"                 TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    ZERO                TO  IDXX
           PERFORM             UNTIL   FLG-SYSKANRI   =   1
                               OR      IDXX           >=  100
               ADD     1                  TO  IDXX
               MOVE    MCPDATA-REC        TO  SYS-1015-REC
               MOVE    SYS-1015-KBNCD     TO  SPA-GMN98-KBNCD  (IDXX)
               MOVE    SYS-1015-LPUBCD    TO  SPA-GMN98-TLPUBCD(IDXX)
               MOVE    SYS-1015-POST      TO  SPA-GMN98-TPOST (IDXX)
               MOVE    SYS-1015-RENNUM    TO  SPA-GMN98-TRENNUM(IDXX)
               MOVE    SYS-1015-TOWNNAMEDSP
                                          TO  SPA-GMN98-TADRS (IDXX)
      *
               MOVE    "SYSKANRI-KEY2"       TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *
           MOVE  "SYSKANRI-KEY2"             TO  ORC-DBPATH
           MOVE  "DBCLOSE"                   TO  MCP-FUNC
           CALL  "ORCMCPSUB"                  USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
      *
      *****COMPUTE SPA-GMN98-MAX =   (IDXX   -   1)  /   25  +   1    
           COMPUTE SPA-GMN98-MAX =   (IDXX   -   1)  /   50  +   1    
      *
           IF      IDXX                      >   ZERO
               MOVE    1                         TO  SPA-GMN98-PAGE
           END-IF
      *
           INITIALIZE                  SPA-GMN98-SELNUM
           INITIALIZE                  SPA-GMN98-ADRS
           INITIALIZE                  SPA-GMN98-POST
      *
           MOVE    1                   TO  SPA-GMN98-CUR
      *
           .
       310-P981SPASET-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI-SEC                           SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM  210-BACK-SEC
      *        住所登録
               WHEN    "CLICKED"       ALSO    "B04"
                   PERFORM  420-ADRUP-SEC
      *        クリア
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM  420-CLERA-SEC
      *        前画面
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM  430-ADRFW-SEC
      *        次画面
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM  440-ADRBK-SEC
      *        確定
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM  450-KAKUTEI-SEC
      *        住所一覧
               WHEN    "CLICKED"       ALSO    ANY
                   PERFORM  490-ADRS-CHK-SEC
           END-EVALUATE.
      *
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY-SEC                             SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        患者番号
               WHEN    "ACTIVATE"       ALSO    "SELNUM"
                   PERFORM  510-SELNUM-CHK-SEC
           END-EVALUATE.
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面セット処理
      *****************************************************************
       500-GMNHEN-SEC                            SECTION.
      *
           MOVE    SPACE               TO  P98
      *
           COMPUTE IDXY    =  (SPA-GMN98-PAGE  -   1)  *   50
      *
           PERFORM VARYING     IDXX    FROM    1   BY  1
                   UNTIL       IDXX    >       50
               COMPUTE IDXZ    =       IDXY    +   IDXX
               MOVE  SPA-GMN98-KBNCD(IDXZ) TO  P98-TADRS(IDXX)(1:3)
               MOVE  SPA-GMN98-TADRS(IDXZ)
                                           TO  P98-TADRS(IDXX)(5:16)
	   END-PERFORM
      *
           MOVE    SPA-GMN98-ADRS      TO  P98-ADRS 
           MOVE    SPA-GMN98-POST      TO  P98-POST
           MOVE    SPA-GMN98-SELNUM    TO  P98-SELNUM  
      *
           PERFORM 5001-MAPCUR-SEC
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
           EVALUATE    SPA-GMN98-CUR
               WHEN    1
                   MOVE    "SELNUM"        TO  MCP-WIDGET
               WHEN    2
                   MOVE    "B12"           TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC                            SECTION.
           MOVE    SPACE                         TO  SPA-ERRMSG.
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "入力された番号は選択できません"
                                                  TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "数字のみ入力可能です" TO  SPA-ERRMSG
           END-EVALUATE.
      *
           MOVE    SPACE               TO  PERR
           MOVE    SPA-ERRCD           TO  PERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  PERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "P98"               TO  SPA-MOTOPG
           MOVE    "PERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "PERR"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       330-SET-SCREEN-SEC                        SECTION.
      *
           PERFORM  500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  330-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE                         TO  LINKAREA
      *
           MOVE    "CURRENT"                     TO  MCP-PUTTYPE.
           MOVE    "P98    "                     TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
       330-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    クリア処理
      *****************************************************************
       420-CLERA-SEC           SECTION.
      *
           INITIALIZE                  SPA-GMN98-SELNUM
           INITIALIZE                  SPA-GMN98-ADRS
           INITIALIZE                  SPA-GMN98-POST
      *
           MOVE    1                   TO  SPA-GMN98-CUR
      *
           .
       420-CLERA-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK-SEC                              SECTION.
      *
      *    共通ＳＰＡ編集
      *
           MOVE  SPA-GMN98-MOTOPG            TO  SPA-SAKIPG.
      *
           MOVE  "P98"                       TO  SPA-MOTOPG.
      *
           MOVE  SPACE                       TO  JPAR-POST.
           MOVE  SPACE                       TO  JPAR-EDITADRS-NAME.
           MOVE  ZERO                        TO  JPAR-CNT.
           MOVE  ZERO                        TO  JPAR-ERRCD.
      *
      *****MOVE   "BACK"                     TO  MCP-PUTTYPE.
           MOVE   "JOIN"                     TO  MCP-PUTTYPE.
           MOVE    SPA-SAKIPG                TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                             TO  FLG-END.
       410-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    検索処理
      *****************************************************************
       420-ADRUP-SEC             SECTION.
      *
           MOVE    "P98"               TO  SPA-MOTOPG
           MOVE    "P981"              TO  SPA-SAKIPG
      *
           MOVE    "KBNCD"             TO  MCP-WIDGET
      *
           INITIALIZE                  SPA-GMN981-AREA
           MOVE    "P98"               TO  SPA-GMN981-MOTOPG
           MOVE    SPACE               TO  P981
      *
           MOVE   "NEW"                TO  MCP-PUTTYPE.
           MOVE   "P981   "            TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       420-ADRUP-EXT.
           EXIT.
      *
      *****************************************************************
      *   前ページ処理
      *****************************************************************
       430-ADRFW-SEC                             SECTION.
      *
           IF SPA-GMN98-PAGE                     >  1
               COMPUTE  SPA-GMN98-PAGE  =  SPA-GMN98-PAGE    -  1
           END-IF.
           MOVE    1                   TO  SPA-GMN98-CUR
      *
           .
      *
       430-ADRFW-EXT.
           EXIT.
      *
      *****************************************************************
      *   後ろページ処理
      *****************************************************************
       440-ADRBK-SEC                             SECTION.
      *
           IF  SPA-GMN98-PAGE                    <  SPA-GMN98-MAX
               COMPUTE  SPA-GMN98-PAGE  =  SPA-GMN98-PAGE    +  1
           END-IF
           MOVE    1                   TO  SPA-GMN98-CUR
      *
           .
       440-ADRBK-EXT.
           EXIT.
      *
      *****************************************************************
      *    確定処理
      *****************************************************************
       450-KAKUTEI-SEC                           SECTION.
      *
           IF  SPA-GMN98-PAGE                    =   ZERO
               GO    TO      450-KAKUTEI-EXT
           END-IF
      *
           IF  SPA-GMN98-SELNUM              =   ZERO
               MOVE  "0001"                      TO  SPA-ERRCD
               GO    TO      450-KAKUTEI-EXT
           END-IF.
      *
      *    共通ＳＰＡ編集
      *
           MOVE    SPA-GMN98-MOTOPG    TO  SPA-SAKIPG
      *
           MOVE  "P98"                 TO  SPA-MOTOPG.
      *
           MOVE  P98-POST              TO  JPAR-POST.
           MOVE  P98-ADRS              TO  JPAR-EDITADRS-NAME.
           MOVE  1                     TO  JPAR-CNT.
           MOVE  ZERO                  TO  JPAR-ERRCD.
      *
      *****MOVE  "BACK"                TO  MCP-PUTTYPE.
           MOVE  "JOIN"                TO  MCP-PUTTYPE.
           MOVE  SPA-SAKIPG            TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE  1                               TO  FLG-END.
      *
       450-KAKUTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    住所選択処理
      *****************************************************************
       490-ADRS-CHK-SEC                SECTION.
      *
           MOVE    ZERO                TO  WRK-IDX3
           IF      MCP-WIDGET(1:9)     =   "CHK_TADRS"
               IF      MCP-WIDGET(10:3)    NUMERIC
                   MOVE    MCP-WIDGET(10:3)    TO  WRK-IDX3
               END-IF
           END-IF
           IF      WRK-IDX3            =   ZERO
               GO      TO      490-ADRS-CHK-EXT
           END-IF
      *
           MOVE    WRK-IDX3(1:2)       TO  IDX2
           MOVE    WRK-IDX3(3:1)       TO  IDX1
           COMPUTE IDXZ                =   ((IDX2   -   1  )  *  5 )
                                       +   IDX1
           COMPUTE IDXY        =  ((SPA-GMN98-PAGE  -   1)  *   50)
                               +  IDXZ
           MOVE    IDXY                TO  IDXZ
      *
           MOVE    1                   TO  SPA-GMN98-CUR
           IF     (IDXZ                >   ZERO  AND  <=   100  )  AND
                  (SPA-GMN98-KBNCD(IDXZ)   NOT =   SPACE )
               MOVE    SPA-GMN98-KBNCD(IDXZ)   TO  SPA-GMN98-SELNUM
               PERFORM 5101-ADRS-HENSYU-SEC
               MOVE    2                   TO  SPA-GMN98-CUR
           END-IF
           .
      *
       490-ADRS-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　選択番号チェック
      *****************************************************************
       510-SELNUM-CHK-SEC                        SECTION.
      *
           MOVE    1                   TO  SPA-GMN98-CUR
      *
           MOVE  SPACE                   TO  SPA-GMN98-POST
           MOVE  SPACE                   TO  SPA-GMN98-ADRS
      *
           MOVE  P98-SELNUM              TO  SPA-GMN98-SELNUM
      *
           COMPUTE IDXY    =  (SPA-GMN98-PAGE  -   1)  *   50
           PERFORM VARYING     IDXX    FROM    1   BY  1
                   UNTIL       IDXX    >       50
               COMPUTE IDXZ    =       IDXY    +   IDXX
               IF      SPA-GMN98-KBNCD(IDXZ)       =   SPACE
                   MOVE    50                          TO  IDXX
               ELSE
                   IF      SPA-GMN98-KBNCD(IDXZ)   =   SPA-GMN98-SELNUM
                       PERFORM 5101-ADRS-HENSYU-SEC
                       GO      TO      510-SELNUM-CHK-EXT
                   END-IF
               END-IF     
	   END-PERFORM
      *
           MOVE    "0001"                TO  SPA-ERRCD
           .
      *
       510-SELNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　住所編集
      *****************************************************************
       5101-ADRS-HENSYU-SEC                        SECTION.
      *
      *    住所データ読み出し
           INITIALIZE                            ADRS-REC
           MOVE  SPA-GMN98-TLPUBCD(IDXZ)     TO  ADRS-LPUBCD
           MOVE  SPA-GMN98-TPOST  (IDXZ)     TO  ADRS-POST
           MOVE  SPA-GMN98-TRENNUM(IDXZ)     TO  ADRS-EDANUM
           MOVE  ADRS-REC                    TO  MCPDATA-REC
           MOVE  "DBSELECT"                  TO  MCP-FUNC
           MOVE  "ADRS-KEY"                  TO  ORC-DBPATH
           CALL  "ORCMCPSUB"                  USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
           IF  MCP-RC                        =  ZERO
               MOVE  "DBFETCH"               TO  MCP-FUNC
               MOVE  "ADRS-KEY"              TO  ORC-DBPATH
               CALL  "ORCMCPSUB"              USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
               IF  MCP-RC                    =   ZERO
                   MOVE  MCPDATA-REC         TO  ADRS-REC
                   MOVE  ADRS-POST           TO  SPA-GMN98-POST
                   MOVE  ADRS-EDITADRS-NAME  TO  SPA-GMN98-ADRS
               END-IF
           END-IF
      *
           MOVE  "ADRS-KEY"                  TO  ORC-DBPATH
           MOVE  "DBCLOSE"                   TO  MCP-FUNC
           CALL  "ORCMCPSUB"                  USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
      * 
           MOVE    2                   TO  SPA-GMN98-CUR 
           .
      *
       5101-ADRS-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読み込み処理
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW                            SECTION.
      *
           MOVE   "PUTWINDOW"                    TO  MCP-FUNC.
           CALL   "ORCMCPSUB"                     USING  MCPAREA
                                                         ORCMCPAREA
                                                         MCPDATA-REC.
      *
       900-PUT-WINDOW-EXT.
           EXIT.
      *
