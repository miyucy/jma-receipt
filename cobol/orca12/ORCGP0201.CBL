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
       PROGRAM-ID.             ORCGP0201.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者登録
      *  コンポーネント名  : 未登録受付者一覧（Ｐ０２０１）
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
      *    患者登録スパ領域
           COPY    "P02COMMON-SPA".
      *    患者画面スパ領域
           COPY    "P02SCR-SPA".
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                           PIC 9(01).
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR                           PIC 9(06).
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
      *    一時領域
       01  WRK-AREA.
           03  WRK-RENNUMZ                       PIC ZZZZ.
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                               PIC 9(04).
           03  IDY                               PIC 9(04).
           03  IDX2                              PIC 9(02).
           03  IDX3                              PIC 9(02).
           03  IDX4                              PIC 9(02).
           03  IDX-LINE                          PIC 9(04).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
       01  UKETUKE-REC.
           COPY    "CPUKETUKE.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *    （周辺町域情報）
           COPY    "CPSK1005.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡領域
      *****************************************************************
        LINKAGE                                  SECTION.
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
      *    主処理
      *****************************************************************
       000-PROC-SEC                     SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON           TO  SPA-AREA.
           MOVE    SPA-FREE             TO  SPA-P02SCRAREA
           MOVE    SPA-WORK             TO  SPA-P02KYOUTU
      *
           MOVE    SPACE                TO  SPA-ERRCD.
           MOVE    ZERO                 TO  FLG-END.
      *
           EVALUATE    MCP-STATUS    ALSO     MCP-EVENT
               WHEN    "LINK"        ALSO     ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN    "PUTG"        ALSO     "CLICKED"
                   PERFORM 200-GMNSENI-SEC
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY-SEC
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END           =   ZERO
               PERFORM 400-SET-SCREEN-SEC
           END-IF.
      *
           MOVE    SPA-P02KYOUTU                 TO  SPA-WORK
           MOVE    SPA-AREA                      TO  SPA-COMMON
           MOVE    SPA-P02SCRAREA                TO  SPA-FREE
           .
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
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 500-GMNHEN-SEC
           ELSE
      *
      *        初期画面編集
      *        PERFORM 300-SCREEN-SEC
      *        IF      FLG-END             =   1
      *            GO      TO      100-INIT-EXT
      *        END-IF
      *
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
      *****初期画面セット
      **** PERFORM 420-ERRSET-SEC.
      *
           MOVE    "NEW"                         TO  MCP-PUTTYPE.
           MOVE    "P0201"                       TO  MCP-WINDOW.
           MOVE    "SELNUM"                      TO  MCP-WIDGET.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                             TO  FLG-END.
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI-SEC                           SECTION.
      *
           MOVE  SPACE                 TO  UKEPAR-REC
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 310-BACK-SEC
      *        確定
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 320-KAKUTEI-SEC
      *            IF  SPA-ERRCD       =   SPACE
      *                PERFORM 310-BACK-SEC
      *            END-IF
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
      *        患者番号
               WHEN    ANY             ALSO    "YYKLIST"
                   PERFORM 340-YYKLIST-CHK-SEC
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
           MOVE    "P02"                         TO  SPA-SAKIPG.
           MOVE    "P0201"                       TO  SPA-MOTOPG.
      *
      *****MOVE   "BACK"                         TO  MCP-PUTTYPE.
           MOVE   "JOIN"                         TO  MCP-PUTTYPE.
           MOVE    SPA-SAKIPG                    TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                             TO  FLG-END.
      *
       310-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    確定処理
      *****************************************************************
       320-KAKUTEI-SEC                           SECTION.
      *
           IF  P0201-SELNUM                      =   SPACE
               MOVE    "0001"                    TO  SPA-ERRCD
               GO      TO      320-KAKUTEI-EXT
           ELSE
               IF  SPA-NAI201-SELNUM             =   ZERO
                   MOVE    "0001"                TO  SPA-ERRCD
                   GO      TO      320-KAKUTEI-EXT
               END-IF
      *
               IF  SPA-NAI201-SELNUM             >   SPA-GMN201-MAX
                   MOVE    "0001"                TO  SPA-ERRCD
                   GO      TO      320-KAKUTEI-EXT
               END-IF
           END-IF
      *
      *    既に患者を選択している時、エラーとする
           IF      SPA-GMN-PTNUM   NOT =   SPACE
               MOVE    "0001"                TO  SPA-ERRCD
               GO      TO      320-KAKUTEI-EXT
           END-IF
      *
      *    共通ＳＰＡ編集
           MOVE  SPACE                           TO  UKETUKE-REC
           MOVE  SPA-HOSPID                      TO  UKE-HOSPID.
           MOVE  SPA-SYSYMD                      TO  UKE-UKEYMD.
           MOVE  SPA-NAI201-UKEID (SPA-NAI201-SELNUM)
                                                 TO  UKE-UKEID.
           MOVE  UKETUKE-REC                     TO  MCPDATA-REC.
      *
           MOVE  "DBSELECT"                      TO  MCP-FUNC.
           MOVE  "UKETUKE-KEY"                   TO  ORC-DBPATH.
           CALL  "ORCMCPSUB"                      USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC.
      *
           IF  MCP-RC                            =  ZERO
               MOVE  ZERO                        TO  IDX
               MOVE  "DBFETCH"                   TO  MCP-FUNC
               MOVE  "UKETUKE-KEY"               TO  ORC-DBPATH
               CALL  "ORCMCPSUB"                  USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
               IF  MCP-RC                        =  ZERO
                   MOVE  MCPDATA-REC             TO  UKEPAR-REC
               ELSE
                   MOVE  SPACE                   TO  UKEPAR-REC
               END-IF
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "UKETUKE-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF      SPA-ERRCD           =   SPACE
              PERFORM 310-BACK-SEC
           END-IF
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
           MOVE    P0201-SELNUM                  TO  SPA-GMN201-SELNUM.
           MOVE    ZERO                          TO  SPA-NAI201-SELNUM.
      *
           INITIALIZE                            ORCSNUMAREA.
           MOVE    P0201-SELNUM                  TO  SNUM-INX.
           CALL    "ORCSNUM"                     USING
                                                 ORCSNUMAREA.
           IF     (SNUM-RC         NOT           =  ZERO  )   OR
                  (SNUM-MINKBN     NOT           =  SPACE )   OR
                  (SNUM-SYOKBN     NOT           =  SPACE )
               MOVE    "0002"                    TO  SPA-ERRCD
               GO      TO      330-SELNUM-CHK-EXT
           ELSE
               MOVE    SNUM-OUTEDT               TO  SPA-NAI201-SELNUM
               MOVE    SNUM-OUTEDT               TO  WRK-RENNUMZ
               MOVE    WRK-RENNUMZ               TO  SPA-GMN201-SELNUM
           END-IF.
      *
           IF  SPA-NAI201-SELNUM                 >   ZERO
	       IF  P0201-NUM(SPA-NAI201-SELNUM)  =   SPACE
    	           MOVE    "0001"                TO  SPA-ERRCD
               ELSE
                   PERFORM 320-KAKUTEI-SEC
      *************MOVE    "B01"                 TO  MCP-WIDGET
               END-IF
           ELSE
  	       MOVE    "0001"                    TO  SPA-ERRCD
               GO      TO      330-SELNUM-CHK-EXT
           END-IF.
      *
       330-SELNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号一覧表選択処理
      *****************************************************************
       340-YYKLIST-CHK-SEC             SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   20
               IF      P0201-SELECT (IDX)      =   "T"
                   MOVE    IDX                 TO  P0201-SELNUM
                   MOVE    20                  TO  IDX
               END-IF
           END-PERFORM
      *
           IF      P0201-SELNUM    NOT =   ZERO
               PERFORM 330-SELNUM-CHK-SEC
           END-IF
           .
      *
       340-YYKLIST-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       400-SET-SCREEN-SEC                        SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
                PERFORM 420-ERRSET-SEC
               GO      TO              400-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE                         TO  LINKAREA.
      *
           MOVE    "CURRENT"                     TO  MCP-PUTTYPE.
           MOVE    "P0201  "                     TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
       400-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    SPA-GMN201-SELNUM   TO  P0201-SELNUM
      *
           MOVE    "B12"               TO  MCP-WIDGET
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面セット処理
      *****************************************************************
       410-SCREEN-SEC                            SECTION.
      *
           INITIALIZE                            SPA-GMN-AREA.
      *
           INITIALIZE                            UKETUKE-REC.
           INITIALIZE                            P0201.
           MOVE  SPA-HOSPID                      TO  UKE-HOSPID.
           MOVE  SPA-SYSYMD                      TO  UKE-UKEYMD.
           MOVE  ZERO                            TO  UKE-PTID.
           MOVE  UKETUKE-REC                     TO  MCPDATA-REC.
      *
           MOVE  "DBSELECT"                      TO  MCP-FUNC.
           MOVE  "UKETUKE-KEY2"                  TO  ORC-DBPATH.
           CALL  "ORCMCPSUB"                      USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC.
      *
           IF  MCP-RC                            =  ZERO
               MOVE  ZERO                        TO  IDX
               MOVE  "DBFETCH"                   TO  MCP-FUNC
               MOVE  "UKETUKE-KEY2"              TO  ORC-DBPATH
               CALL  "ORCMCPSUB"                  USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
      *
               PERFORM  UNTIL     IDX            >   19    OR
                              MCP-RC  NOT        =   ZERO  
                   MOVE  MCPDATA-REC             TO  UKETUKE-REC
                   COMPUTE  IDX                  =  IDX  +  1
                   MOVE  IDX                     TO P0201-NUM(IDX)
                   MOVE  UKE-UKETIME(1:2)    TO P0201-YYKTIME(IDX)(1:2)
                   MOVE  ":"                 TO P0201-YYKTIME(IDX)(3:1)
                   MOVE  UKE-UKETIME(3:2)    TO P0201-YYKTIME(IDX)(4:2)
                   MOVE  UKE-NAME                TO P0201-NAME(IDX)
                   INITIALIZE                    SYS-1005-REC
                   MOVE  "1005"                  TO  SYS-1005-KANRICD
                   MOVE  UKE-SRYKA               TO  SYS-1005-KBNCD
                   MOVE  SYS-1005-REC            TO  MCPDATA-REC
      *
                   MOVE  "DBSELECT"              TO  MCP-FUNC
                   MOVE  "SYSKANRI-KEY"          TO  ORC-DBPATH
                   MOVE   SPA-SYSYMD             TO  ORC-DBYMD
                   CALL  "ORCMCPSUB"              USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
      *
                   IF  MCP-RC                    =  ZERO
                       MOVE  "DBFETCH"           TO  MCP-FUNC
                       MOVE  "SYSKANRI-KEY4"     TO  ORC-DBPATH
                       CALL  "ORCMCPSUB"          USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
                       MOVE  MCPDATA-REC         TO  SYS-1005-REC
                       MOVE  SYS-1005-SRYKANAME1 TO  P0201-SRYKA(IDX)
                   END-IF
      *
                   MOVE  "SYSKANRI-KEY4"         TO  ORC-DBPATH
                   MOVE  "DBCLOSE"               TO  MCP-FUNC
                   CALL  "ORCMCPSUB"              USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
      *
                   MOVE  "DBFETCH"               TO  MCP-FUNC
                   MOVE  "UKETUKE-KEY2"          TO  ORC-DBPATH
                   CALL  "ORCMCPSUB"              USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
               END-PERFORM
      *
               MOVE  "UKETUKE-KEY2"              TO  ORC-DBPATH
               MOVE  "DBCLOSE"                   TO  MCP-FUNC
               CALL  "ORCMCPSUB"                  USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
      *
               MOVE  IDX                         TO  SPA-GMN201-MAX
      *
           ELSE
               MOVE  ZERO                        TO  SPA-GMN201-MAX
           END-IF.
           MOVE  SPA-GMN201-MAX                  TO  P0201-COUNT.
      *
       41O-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       420-ERRSET-SEC                            SECTION.
           MOVE    SPACE                         TO  SPA-ERRMSG.
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "入力された番号は選択できません" 
                                           TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "既に患者が選択されています。選択できません" 
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
           MOVE    "P0201"             TO  SPA-MOTOPG
           MOVE    "PERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "PERR"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
      *
       420-ERRSET-EXT.
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
