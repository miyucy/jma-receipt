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
       PROGRAM-ID.             ORCGP99.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 住所検索
      *  コンポーネント名  : 住所一覧画面（Ｐ９９）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC-太田      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                               DIVISION.
       CONFIGURATION                             SECTION.
       INPUT-OUTPUT                              SECTION.
       FILE-CONTROL.
      *
       DATA                                      DIVISION.
       FILE                                      SECTION.
     *
       WORKING-STORAGE                           SECTION.
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
       01  SPA-GMN99-AREA.
           02  SPA-STS                           PIC 9(04).
           02  SPA-P99-AREA.
               05  SPA-CTLSEQ99                  PIC 9(02).
               05  SPA-GMN99-PAGE                PIC 9(02).
               05  SPA-GMN99-MAX                 PIC 9(02).
               05  SPA-GMN99-CUR                 PIC 9(02).
      *
               05  SPA-GMN99-AREAT.
                   07  SPA-GMN99-TBL             OCCURS   50.
                       09  SPA-GMN99-NUM         PIC 9(04).
                       09  SPA-GMN99-POST        PIC X(07).
                       09  SPA-GMN99-ADRS        PIC X(60).
                   07  SPA-GMN99-SELNUM          PIC X(04).
               05  SPA-NAI99-AREA.
                   07  SPA-NAI99-SELNUM          PIC 9(04).
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                           PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR                           PIC 9(06).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-RENNUMZ        PIC ZZZZ.
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY                        PIC 9(02).
               05  SYS-MM                        PIC 9(02).
               05  SYS-DD                        PIC 9(02).
           03  SYS-TIME.
               05  SYS-THH                       PIC 9(02).
               05  SYS-TMM                       PIC 9(02).
               05  SYS-TSS                       PIC 9(02).
               05  SYS-TDD                       PIC 9(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                               PIC 9(04).
           03  IDY                               PIC 9(04).
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *
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
           COPY    "PERR.INC".
           COPY    "PID1.INC".
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
       000-PROC-SEC                              SECTION.
      *
           MOVE    SPA-COMMON                    TO  SPA-AREA.
           MOVE    SPA-WORK                      TO  SPA-P02KYOUTU.
           MOVE    SPA-FREE                      TO  SPA-P02SCRAREA.
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
               PERFORM 500-SET-SCREEN-SEC
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
      *    DISPLAY "*** ORCSNPL    START  ***"
      *
           INITIALIZE                            FLG-AREA.
           INITIALIZE                            CNT-AREA.
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "PERR"
               MOVE    SPACE           TO  SPA-MOTOPG
               MOVE    "SELNUM"        TO  MCP-WIDGET
           ELSE
               MOVE  P99-ADRSLIST-COUNT          TO  SPA-GMN99-MAX
           END-IF
      *
           MOVE    SPA-WORK                      TO  SPA-P02KYOUTU.
      *
           MOVE    SPACE                         TO  LINKAREA.
      *
           MOVE    "NEW"                         TO  MCP-PUTTYPE.
           MOVE    "P99"                         TO  MCP-WINDOW.
           MOVE    "SELNUM"                      TO  MCP-WIDGET.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                             TO  FLG-END.
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    SPA-GMN99-SELNUM   TO  P99-SELNUM
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI-SEC                           SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 310-BACK-SEC
      *        確定
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 320-KAKUTEI-SEC
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
               WHEN    "ACTIVATE"      ALSO    "SELNUM"
                   PERFORM 330-SELNUM-CHK-SEC
           END-EVALUATE.
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       310-BACK-SEC                              SECTION.
      *
           MOVE    SPA-HZN-MOTOPG      TO  SPA-SAKIPG.
      *
           MOVE    "P99"               TO  SPA-MOTOPG.
      *
           MOVE    SPACE               TO  JPAR-POST.
           MOVE    SPACE               TO  JPAR-EDITADRS-NAME.
           MOVE    ZERO                TO  JPAR-CNT
           MOVE    ZERO                TO  JPAR-ERRCD
      *
      *****MOVE   "BACK"               TO  MCP-PUTTYPE.
           MOVE   "JOIN"               TO  MCP-PUTTYPE.
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                             TO  FLG-END.
       310-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    確定処理
      *****************************************************************
       320-KAKUTEI-SEC                           SECTION.
      *
           IF  P99-SELNUM                        =   SPACE
               MOVE    "0001"                    TO  SPA-ERRCD
               GO      TO      320-KAKUTEI-EXT
           END-IF.
      *
           IF  SPA-NAI99-SELNUM                  =   ZERO
               MOVE    "0001"                    TO  SPA-ERRCD
               GO      TO      320-KAKUTEI-EXT
           END-IF.
      *
           IF  SPA-NAI99-SELNUM                  >  P99-ADRSLIST-COUNT
               MOVE    "0001"                    TO  SPA-ERRCD
               GO      TO      320-KAKUTEI-EXT
           END-IF.
      *
      *    共通ＳＰＡ編集
      *
           MOVE    SPA-HZN-MOTOPG                TO  SPA-SAKIPG
      *
           MOVE    "P99"                         TO  SPA-MOTOPG
      *
      *
           MOVE    P99-POST(SPA-NAI99-SELNUM)    TO  JPAR-POST
           MOVE    P99-ADRS(SPA-NAI99-SELNUM)    TO  JPAR-EDITADRS-NAME
           MOVE    1                             TO  JPAR-CNT
           MOVE    ZERO                          TO  JPAR-ERRCD
      *
      *****MOVE   "BACK"                         TO  MCP-PUTTYPE
           MOVE   "JOIN"                         TO  MCP-PUTTYPE
           MOVE   SPA-SAKIPG                     TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                             TO  FLG-END
           .
      *
       320-KAKUTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *  　選択番号チェック
      *****************************************************************
       330-SELNUM-CHK-SEC                        SECTION.
      *
           INITIALIZE                            ORCSNUMAREA.
           MOVE    P99-SELNUM                    TO  SNUM-INX.
           MOVE    ZERO                          TO  SPA-NAI99-SELNUM.
           CALL    "ORCSNUM"                     USING
                                                 ORCSNUMAREA.
           IF     (SNUM-RC         NOT           =  ZERO  )   OR
                  (SNUM-MINKBN     NOT           =  SPACE )   OR
                  (SNUM-SYOKBN     NOT           =  SPACE )
               MOVE    "0002"                    TO  SPA-ERRCD
               GO      TO      330-SELNUM-CHK-EXT
           ELSE
               MOVE    SNUM-OUTNUM               TO  SPA-NAI99-SELNUM
               MOVE    SNUM-OUTNUM               TO  WRK-RENNUMZ
               MOVE    WRK-RENNUMZ               TO  SPA-GMN99-SELNUM
           END-IF.
      *
           IF  SPA-NAI99-SELNUM                  >   ZERO
	       IF  P99-NUM(SPA-NAI99-SELNUM)     =   SPACE
    	           MOVE    "0001"                TO  SPA-ERRCD
               ELSE
                   MOVE    "B12"                 TO  MCP-WIDGET
               END-IF
           ELSE
  	       MOVE    "0001"                TO  SPA-ERRCD
               GO      TO      330-SELNUM-CHK-EXT
           END-IF.
      *
       330-SELNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN-SEC                        SECTION.
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
           MOVE    "CURRENT"                     TO  MCP-PUTTYPE.
           MOVE    "P99    "                     TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
       500-SET-SCREEN-EXT.
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
           MOVE    "P99"               TO  SPA-MOTOPG
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
