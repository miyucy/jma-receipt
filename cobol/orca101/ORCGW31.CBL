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
       PROGRAM-ID.                               ORCGW31.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : 医療区分表示設定
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/10/14    NACL−太田    新規作成
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
       DATA                    DIVISION.
       FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    システム管理情報設定用共通パラメタ
           COPY    "W01COMMON-SPA".
      *
      *    コンスタント値
           COPY    "ENUM-VALUE".
      *
      *    画面用ＳＰＡ
       01  SPA-W31.
           03  SPA-GMN-CUR                         PIC 9(03).
           03  SPA-GMN-AREA.
               05  SPA-GMN-MEDKBN-G.
                   07  SPA-GMN-MEDKBN-MAX         PIC 9(03).
                   07  SPA-GMN-MEDKBN-OCC         OCCURS  40.
                       09  SPA-GMN-CHK-MEDKBN     PIC X(01).
                       09  SPA-GMN-CHK-LBLMEDKBN  PIC X(60).
           03  SPA-NAI-AREA.
               05  SPA-GMN-NAI-MEDKBN-G.
                   07  SPA-NAI-MEDKBN-OCC         OCCURS  40.
                       09  SPA-NAI-MEDKBN-ZAINUM  PIC 9(08).
                       09  SPA-NAI-MEDKBN-SRYCD   PIC X(09).
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-SYSKANRI                        PIC 9(01).
           03  FLG-TENSU                           PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                                PIC 9(05).
           03  IDX1                                PIC 9(05).
           03  IDX-CHK                             PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
      *    入力項目名
           03  WRK-MCP-WIDGET                      PIC X(64).
           03  WRK-WIDMSG                          PIC X(200).
           03  WRK-ZAINUM-X.
               05  WRK-ZAINUM                      PIC 9(08).
           03  WRK-TNS-SRYCD                       PIC X(09).
           03  WRK-WIDGET-MEDKBN-G.
               05  WRK-WIDGET-MEDKBN-LBL           PIC X(10).
               05  WRK-WIDGET-MEDKBN               PIC 9(02).
      *
      *
      *    固定値領域
       01  CONST-AREA.
           03  CONST-GMN-MEDKBN-MAX    PIC 9(05)   VALUE 40.
           03  CONST-MEDKBN-G.
               05  CONST-MEDKBN-VAL.
                   07                  PIC 9(01)   VALUE 1.
                   07                  PIC 9(04)   VALUE 2001.
                   07                  PIC X(09)   VALUE "820000057".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2002.
                   07                  PIC X(09)   VALUE "820000058".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2003.
                   07                  PIC X(09)   VALUE "820000059".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2004.
                   07                  PIC X(09)   VALUE "820000060".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2005.
                   07                  PIC X(09)   VALUE "820000061".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2006.
                   07                  PIC X(09)   VALUE "820000062".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2007.
                   07                  PIC X(09)   VALUE "820000063".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2008.
                   07                  PIC X(09)   VALUE "820000064".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2009.
                   07                  PIC X(09)   VALUE "820000065".
                   07                  PIC 9(01)   VALUE 1.
                   07                  PIC 9(04)   VALUE 2010.
                   07                  PIC X(09)   VALUE "820000066".
                   07                  PIC 9(01)   VALUE 1.
                   07                  PIC 9(04)   VALUE 2011.
                   07                  PIC X(09)   VALUE "820000067".
                   07                  PIC 9(01)   VALUE 1.
                   07                  PIC 9(04)   VALUE 2012.
                   07                  PIC X(09)   VALUE "820000068".
                   07                  PIC 9(01)   VALUE 1.
                   07                  PIC 9(04)   VALUE 2013.
                   07                  PIC X(09)   VALUE "820000069".
                   07                  PIC 9(01)   VALUE 1.
                   07                  PIC 9(04)   VALUE 2014.
                   07                  PIC X(09)   VALUE "820000070".
                   07                  PIC 9(01)   VALUE 1.
                   07                  PIC 9(04)   VALUE 2015.
                   07                  PIC X(09)   VALUE "820000071".
                   07                  PIC 9(01)   VALUE 1.
                   07                  PIC 9(04)   VALUE 2016.
                   07                  PIC X(09)   VALUE "820000072".
                   07                  PIC 9(01)   VALUE 1.
                   07                  PIC 9(04)   VALUE 2017.
                   07                  PIC X(09)   VALUE "820000073".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2018.
                   07                  PIC X(09)   VALUE "820000074".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2019.
                   07                  PIC X(09)   VALUE "820000075".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2020.
                   07                  PIC X(09)   VALUE "820000076".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2021.
                   07                  PIC X(09)   VALUE "820000077".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2022.
                   07                  PIC X(09)   VALUE "820000078".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2023.
                   07                  PIC X(09)   VALUE "820000079".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2024.
                   07                  PIC X(09)   VALUE "820000080".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2025.
                   07                  PIC X(09)   VALUE "820000081".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2026.
                   07                  PIC X(09)   VALUE "820000082".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2027.
                   07                  PIC X(09)   VALUE "820000083".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2028.
                   07                  PIC X(09)   VALUE "820000084".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2029.
                   07                  PIC X(09)   VALUE "820000085".
                   07                  PIC 9(01)   VALUE 1.
                   07                  PIC 9(04)   VALUE 2030.
                   07                  PIC X(09)   VALUE "820000086".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2031.
                   07                  PIC X(09)   VALUE "820000087".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2032.
                   07                  PIC X(09)   VALUE "820000088".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2033.
                   07                  PIC X(09)   VALUE "820000089".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2034.
                   07                  PIC X(09)   VALUE "820000090".
                   07                  PIC 9(01)   VALUE 0.
                   07                  PIC 9(04)   VALUE 2035.
                   07                  PIC X(09)   VALUE "820000091".
                   07                  PIC 9(01)   VALUE 1.
                   07                  PIC 9(04)   VALUE 2036.
                   07                  PIC X(09)   VALUE "820000092".
                   07                  PIC 9(01)   VALUE 1.
                   07                  PIC 9(04)   VALUE 2037.
                   07                  PIC X(09)   VALUE "820000093".
               05  CONST-MEDKBN-R REDEFINES CONST-MEDKBN-VAL.
                   07  CONST-MEDKBN-OCC    OCCURS  37.
                       09  CONST-MEDKBN-ALLKBN PIC 9(01).
                       09  CONST-MEDKBN-ZAINUM PIC 9(04).
                       09  CONST-MEDKBN-SRYCD  PIC X(09).
               05  CONST-MEDKBN-MAX        PIC 9(03)   VALUE   37.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY  "CPSYSKANRI.INC".
      *
      *    医療区分表示情報
           COPY  "CPSK5014.INC".
      *
      *    点数マスタ
           COPY  "CPTENSU.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
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
           COPY    "W01.INC".
           COPY    "W02.INC".
           COPY    "W03.INC".
           COPY    "W04.INC".
           COPY    "W05.INC".
           COPY    "W06.INC".
           COPY    "W07.INC".
           COPY    "W08.INC".
           COPY    "W09.INC".
           COPY    "W10.INC".
           COPY    "W11.INC".
           COPY    "W111.INC".
           COPY    "W12.INC".
           COPY    "W13.INC".
           COPY    "W14.INC".
           COPY    "W15.INC".
           COPY    "W16.INC".
           COPY    "W17.INC".
           COPY    "W18.INC".
           COPY    "W19.INC".
           COPY    "W20.INC".
           COPY    "W21.INC".
           COPY    "W22.INC".
           COPY    "W23.INC".
           COPY    "W24.INC".
           COPY    "W25.INC".
           COPY    "W26.INC".
           COPY    "W27.INC".
           COPY    "W28.INC".
           COPY    "W29.INC".
           COPY    "W30.INC".
           COPY    "W31.INC".
           COPY    "W60.INC".
           COPY    "W61.INC".
           COPY    "W62.INC".
           COPY    "W63.INC".
           COPY    "W98.INC".
           COPY    "W981.INC".
           COPY    "W97.INC".
           COPY    "W99.INC".
           COPY    "WERR.INC".
           COPY    "WID1.INC".
           COPY    "WID2.INC".
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
           MOVE    SPA-WORK        TO  SPA-W01KYOUTU
           MOVE    SPA-FREE        TO  SPA-W31
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN     "PUTG"         ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF    ( FLG-END         =   ZERO )
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-W31         TO  SPA-FREE
           MOVE    SPA-W01KYOUTU   TO  SPA-WORK 
           MOVE    SPA-AREA        TO  SPA-COMMON
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
           IF    ( SPA-MOTOPG          =   "WERR" )
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF    ( FLG-END         =   1 )
                   GO  TO  100-INIT-EXT
               END-IF 
      *
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  MCP-PUTTYPE
           MOVE    "W31    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC                  SECTION.
      *
      *    他のＬＤより
           IF    ( LINKAREA        NOT =   SPACE )
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG
           WHEN    "WID1"
               PERFORM 330-WID1-SET-SEC
               MOVE    SPACE           TO  SPA-WID1-FLG
               MOVE    SPACE           TO  SPA-WIDCD
               GO  TO      300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM 310-SPASET-SEC
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC                  SECTION.
      *
           INITIALIZE                  SPA-W31
      *
           PERFORM VARYING IDX-CHK    FROM    1   BY  1
                   UNTIL ( IDX-CHK    >   CONST-MEDKBN-MAX )
      *
               MOVE    CONST-MEDKBN-ZAINUM (IDX-CHK)
                                       TO  SPA-NAI-MEDKBN-ZAINUM
                                                              (IDX-CHK)
               MOVE    CONST-MEDKBN-SRYCD  (IDX-CHK)
                                       TO  SPA-NAI-MEDKBN-SRYCD
                                                              (IDX-CHK)
                                           WRK-TNS-SRYCD
               PERFORM 900-TENSU-KEY-SEL-SEC
               MOVE    TNS-NAME        TO  SPA-GMN-CHK-LBLMEDKBN
                                                              (IDX-CHK)
      *
               PERFORM 3101-SYS5014-SEL-SEC
               IF    ( SYS-5014-DISPKBN    =   "1" )
                   MOVE    "T"         TO  SPA-GMN-CHK-MEDKBN (IDX-CHK)
               ELSE
                   MOVE    "F"         TO  SPA-GMN-CHK-MEDKBN (IDX-CHK)
               END-IF
      *
           END-PERFORM
      *
           MOVE    CONST-MEDKBN-MAX    TO  SPA-GMN-MEDKBN-MAX
      *
           MOVE    1               TO  SPA-GMN-CUR
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    医療区分表示情報検索処理
      *****************************************************************
       3101-SYS5014-SEL-SEC            SECTION.
      *
           INITIALIZE                  SYS-5014-REC
           MOVE    "5014"          TO  SYS-5014-KANRICD
           MOVE    SPA-NAI-MEDKBN-ZAINUM (IDX-CHK)
                                   TO  WRK-ZAINUM
           MOVE    WRK-ZAINUM-X    TO  SYS-5014-KBNCD
           MOVE    SPA-W01-STYUKYMD
                                   TO  SYS-5014-STYUKYMD
                                       SYS-5014-EDYUKYMD
           MOVE    SYS-5014-REC    TO  SYSKANRI-REC
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           MOVE    SYSKANRI-REC    TO  SYS-5014-REC
      *
           .
       3101-SYS5014-SEL-EXT.
           EXIT.
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-WID1-SET-SEC            SECTION.
      *
           IF    ( SPA-WID1-FLG    =   "OK" )
               EVALUATE    SPA-WIDCD
               WHEN "3001"
                   PERFORM 4801-TOUROKU-SEC
               END-EVALUATE
           END-IF
      *
           .
       330-WID1-SET-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                           SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
      *
           MOVE    ZERO                TO  SPA-GMN-CUR
      *
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *    戻る
           WHEN    "CLICKED"       ALSO    "B01"
               MOVE   "CHANGE"         TO  MCP-PUTTYPE
               PERFORM  210-BACK
      *    全選択
           WHEN    "CLICKED"       ALSO    "B02"
               PERFORM 420-CLEAR-SEC
      *    医療区分
           WHEN    "CLICKED"       ALSO    "CHK_MEDKBN01"
                                     THRU  "CHK_MEDKBN40"
               PERFORM 4101-MEDKBN-CHK-SEC
      *    登録
           WHEN    "CLICKED"       ALSO    "B12"
               PERFORM 480-TOUROKU-SEC
      *
           END-EVALUATE
           .
      *
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                             SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
      *
      *    入力個所のセット
           PERFORM 400-GMN-INPUT-SEC
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
       400-GMN-INPUT-SEC          SECTION.
      *
           MOVE    ZERO        TO      SPA-GMN-CUR
      *
           .
      *
       400-GMN-INPUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC          SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
      *    基本チェック処理
           PERFORM 4102-KIHON-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
             OR  ( FLG-END     NOT =   ZERO  )
               GO  TO  410-INPUT-CHK-EXT
           END-IF
      *
           .
      *
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ＳＰＡ編集処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC            SECTION.
      *
      *
           .
      *
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC              SECTION.
      *
      *
           .
      *
       4102-KIHON-CHK-EXT.
           EXIT.
      *****************************************************************
      *    医療区分チェック処理
      *****************************************************************
       4101-MEDKBN-CHK-SEC             SECTION.
      *
           PERFORM 410-INPUT-CHK-SEC
      *
           MOVE    WRK-MCP-WIDGET      TO  WRK-WIDGET-MEDKBN-G
      *
           MOVE    WRK-WIDGET-MEDKBN   TO  IDX-CHK
      *
           MOVE    W31-CHK-MEDKBN (IDX-CHK)
                                       TO  SPA-GMN-CHK-MEDKBN (IDX-CHK)
      *
           .
       4101-MEDKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "W01"               TO  SPA-SAKIPG
           MOVE    "W31"               TO  SPA-MOTOPG
      *
      ***  MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE    "W01"               TO  MCP-WINDOW
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
      *    条件クリア処理
      *****************************************************************
       420-CLEAR-SEC               SECTION.
      *
           PERFORM VARYING IDX-CHK    FROM    1   BY  1
                   UNTIL ( IDX-CHK    >   CONST-MEDKBN-MAX )
      *
               MOVE    "T"             TO  SPA-GMN-CHK-MEDKBN (IDX-CHK)
      *
           END-PERFORM
      *
           MOVE    1                   TO  SPA-GMN-CUR
      *
           .
       420-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    登録処理
      *****************************************************************
       480-TOUROKU-SEC                 SECTION.
      *
      *    入力個所のチェック
           PERFORM 410-INPUT-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  480-TOUROKU-EXT
           END-IF
      *
           PERFORM 4900-KANRENCHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  480-TOUROKU-EXT
           END-IF
      *
           MOVE    "3001"          TO  SPA-WIDCD
      *
           .
       480-TOUROKU-EXT.
           EXIT.
      *****************************************************************
      *    登録処理
      *****************************************************************
       4801-TOUROKU-SEC                SECTION.
      *
           PERFORM 800-MCNDATE-SEC
      *
           INITIALIZE                      SYS-5014-REC
           MOVE    "5014"              TO  SYS-5014-KANRICD
           MOVE    "*"                 TO  SYS-5014-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  SYS-5014-STYUKYMD
                                           SYS-5014-EDYUKYMD
           MOVE    SYS-5014-REC        TO  SYSKANRI-REC
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           IF    ( FLG-SYSKANRI    =   ZERO )
               MOVE    SMCNDATE-YMD    TO  SYS-5014-UPYMD
               MOVE    SMCNDATE-HMS    TO  SYS-5014-UPHMS
grpsys*        MOVE SPA-HOSPNUM TO -HOSPNUM
               MOVE    SYS-5014-REC    TO  MCPDATA-REC
               PERFORM 910-DBUPDATE-SEC
               IF    ( MCP-RC      NOT =   ZERO )
                   MOVE    "4003"      TO  SPA-ERRCD
               END-IF
           ELSE
               MOVE    SPA-W01-STYUKYMD
                                       TO  SYS-5014-STYUKYMD
               MOVE    SPA-W01-EDYUKYMD
                                       TO  SYS-5014-EDYUKYMD
               MOVE    SMCNDATE-YMD    TO  SYS-5014-CREYMD
                                           SYS-5014-UPYMD
               MOVE    SMCNDATE-HMS    TO  SYS-5014-UPHMS
grpsys*        MOVE SPA-HOSPNUM TO -HOSPNUM
               MOVE    SYS-5014-REC    TO  MCPDATA-REC
               PERFORM 910-DBINSERT-SEC
               IF    ( MCP-RC      NOT =   ZERO )
                   MOVE    "4004"      TO  SPA-ERRCD
               END-IF
           END-IF
      *
      *
           PERFORM VARYING IDX-CHK    FROM    1   BY  1
                   UNTIL ( IDX-CHK    >   SPA-GMN-MEDKBN-MAX )
                    OR   ( SPA-ERRCD  NOT =   SPACE )
      *
               PERFORM 3101-SYS5014-SEL-SEC
               IF    ( FLG-SYSKANRI    =   ZERO )
                   IF    ( SPA-GMN-CHK-MEDKBN (IDX-CHK)    =   "T" )
                       MOVE    "1"         TO  SYS-5014-DISPKBN
                   ELSE
                       MOVE    SPACE       TO  SYS-5014-DISPKBN
                   END-IF
      *
                   MOVE    SMCNDATE-YMD    TO  SYS-5014-UPYMD
                   MOVE    SMCNDATE-HMS    TO  SYS-5014-UPHMS
grpsys*            MOVE SPA-HOSPNUM TO -HOSPNUM
                   MOVE    SYS-5014-REC    TO  MCPDATA-REC
                   PERFORM 910-DBUPDATE-SEC
                   IF    ( MCP-RC      NOT =   ZERO )
                       MOVE    "4001"      TO  SPA-ERRCD
                   END-IF
      *
               ELSE
      *
                   INITIALIZE                  SYS-5014-REC
                   MOVE    "5014"      TO  SYS-5014-KANRICD
                   MOVE    SPA-NAI-MEDKBN-ZAINUM (IDX-CHK)
                                       TO  WRK-ZAINUM
                   MOVE    WRK-ZAINUM-X
                                       TO  SYS-5014-KBNCD
                   MOVE    SPA-W01-STYUKYMD
                                       TO  SYS-5014-STYUKYMD
                   MOVE    SPA-W01-EDYUKYMD
                                       TO  SYS-5014-EDYUKYMD
                   MOVE    SPA-NAI-MEDKBN-ZAINUM (IDX-CHK)
                                       TO  SYS-5014-ZAINUM
                   MOVE    SPA-NAI-MEDKBN-SRYCD  (IDX-CHK)
                                       TO  SYS-5014-SRYCD 
                   IF    ( SPA-GMN-CHK-MEDKBN (IDX-CHK)    =   "T" )
                       MOVE    "1"     TO  SYS-5014-DISPKBN
                   ELSE
                       MOVE    SPACE   TO  SYS-5014-DISPKBN
                   END-IF
      *
                   MOVE    SMCNDATE-YMD    TO  SYS-5014-CREYMD
                                               SYS-5014-UPYMD
                   MOVE    SMCNDATE-HMS    TO  SYS-5014-UPHMS
      *
grpsys*            MOVE SPA-HOSPNUM TO -HOSPNUM
                   MOVE    SYS-5014-REC    TO  MCPDATA-REC
                   PERFORM 910-DBINSERT-SEC
                   IF    ( MCP-RC      NOT =   ZERO )
                       MOVE    "4002"      TO  SPA-ERRCD
                   END-IF
      *
               END-IF
      *
           END-PERFORM
      *
           IF    ( SPA-ERRCD           =   SPACE )
               MOVE   "JOIN"           TO  MCP-PUTTYPE
               PERFORM 210-BACK
           END-IF
      *
           .
       4801-TOUROKU-EXT.
           EXIT.
      *****************************************************************
      *    共通関連チェック
      *****************************************************************
       4900-KANRENCHK-SEC              SECTION.
      *
      *
           .
      *
       4900-KANRENCHK-EXT.
           EXIT.
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN                  SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-WIDCD       NOT =   SPACE
               PERFORM 520-WIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "W31    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           INITIALIZE                      W31
      *
           MOVE    SPA-W01-STYUKYMDH   TO  W31-STYUKYMD
           MOVE    SPA-W01-EDYUKYMDH   TO  W31-EDYUKYMD
      *
           PERFORM VARYING IDX-CHK    FROM    1   BY  1
                   UNTIL ( IDX-CHK     >   CONST-GMN-MEDKBN-MAX )
      *
               MOVE    SPA-GMN-CHK-MEDKBN (IDX-CHK)
                                       TO  W31-CHK-MEDKBN (IDX-CHK)
               MOVE    SPA-GMN-CHK-LBLMEDKBN (IDX-CHK)
                                       TO  W31-CHK-LBLMEDKBN
                                                          (IDX-CHK)
      *
               IF    ( IDX-CHK         >   SPA-GMN-MEDKBN-MAX )
                   MOVE    "F"         TO  W31-CHK-MEDKBN (IDX-CHK)
               END-IF
      *
           END-PERFORM
      *
      *    項目状態編集
           PERFORM 500-GMNHEN-STATE-EDIT-SEC
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目状態編集処理
      *****************************************************************
       500-GMNHEN-STATE-EDIT-SEC       SECTION.
      *
           PERFORM VARYING IDX-CHK    FROM    1   BY  1
                   UNTIL ( IDX-CHK    >   CONST-GMN-MEDKBN-MAX )
      *
               MOVE    WIDGET-NORMAL  TO  W31-CHK-MEDKBN-STATE (IDX-CHK)
               IF    ( IDX-CHK         >   SPA-GMN-MEDKBN-MAX )
                   MOVE    WIDGET-INSENSITIVE
                                      TO  W31-CHK-MEDKBN-STATE (IDX-CHK)
               END-IF
      *
           END-PERFORM
      *
           .
       500-GMNHEN-STATE-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
           IF     (SPA-ERRCD           =   SPACE)  AND
                  (SPA-GMN-CUR         =   ZERO )
               PERFORM 5011-INPUT-CUR-SEC
           END-IF
      *
           PERFORM 5012-SKIP-CUR-SEC
      *
           EVALUATE    SPA-GMN-CUR
           WHEN    001 THRU    040
               MOVE    "CHK_MEDKBN"        TO  WRK-WIDGET-MEDKBN-LBL
               MOVE    SPA-GMN-CUR         TO  WRK-WIDGET-MEDKBN
               MOVE    WRK-WIDGET-MEDKBN-G TO  MCP-WIDGET
           WHEN    212
               MOVE    "B12"               TO  MCP-WIDGET
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
           WHEN    "CHK_MEDKBN01"      THRU    "CHK_MEDKBN39"
               MOVE    WRK-MCP-WIDGET  TO  WRK-WIDGET-MEDKBN-G
               COMPUTE SPA-GMN-CUR =   WRK-WIDGET-MEDKBN   +   1
           WHEN    "CHK_MEDKBN40"
               MOVE    212         TO  SPA-GMN-CUR
           END-EVALUATE
      *
           .
      *
       5011-INPUT-CUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソルスキップ処理
      *****************************************************************
       5012-SKIP-CUR-SEC           SECTION.
      *
           PERFORM VARYING IDX-CHK    FROM    1   BY  1
                   UNTIL ( IDX-CHK    >   CONST-GMN-MEDKBN-MAX )
      *
               IF    ( SPA-GMN-CUR    =   IDX-CHK )
                 AND ( W31-CHK-MEDKBN-STATE (IDX-CHK)
                                      =   WIDGET-INSENSITIVE )
                   IF    ( IDX-CHK    =   CONST-GMN-MEDKBN-MAX )
                       COMPUTE SPA-GMN-CUR =   212
                   ELSE
                       COMPUTE SPA-GMN-CUR =   SPA-GMN-CUR +   1
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           .
      *
       5012-SKIP-CUR-EXT.
           EXIT.
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
           WHEN    "4001"  THRU    "4999"
               MOVE    "更新処理に失敗しました"
                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  WERR
           MOVE    SPA-ERRCD           TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  WERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "W31"               TO  SPA-MOTOPG
           MOVE    "WERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "WERR"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ガイドメッセージ表示
      *****************************************************************
       520-WIDSET-SEC              SECTION.
      *
           EVALUATE    SPA-WIDCD
           WHEN    "3001"
               MOVE    "登録します。よろしいですか"
                                        TO  WRK-WIDMSG
           END-EVALUATE
      *
      *
           MOVE    SPACE                TO  WID1
           MOVE    SPA-WIDCD            TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG           TO  WID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "W31"                TO  SPA-MOTOPG
           MOVE    "WID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "WID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-WIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    マシン日付取得サブ
      *****************************************************************
       800-MCNDATE-SEC         SECTION.
      *
           CALL    "ORCSMCNDATE"   USING   ORCSMCNDATEAREA
      *
           .
      *
       800-MCNDATE-EXT.
           EXIT.
      *****************************************************************
      *    システム管理検索処理
      *****************************************************************
       900-SYSKANRI-KEY10-SEL-SEC      SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
grpsys*    MOVE SPA-HOSPNUM TO -HOSPNUM
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key10"         TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SYSKANRI-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
               INITIALIZE              SYSKANRI-REC
           END-IF
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key10"         TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-SYSKANRI-KEY10-SEL-EXT.
            EXIT.
      *****************************************************************
      *    点数マスタ検索処理(KEY)
      *****************************************************************
       900-TENSU-KEY-SEL-SEC       SECTION.
      *
           MOVE    ZERO            TO  FLG-TENSU
      *
           INITIALIZE                  TNS-TENSU-REC
      *
           MOVE    WRK-TNS-SRYCD   TO  TNS-SRYCD
           MOVE    SPA-W01-STYUKYMD
                                   TO  TNS-YUKOSTYMD
                                       TNS-YUKOEDYMD
grpsys*    MOVE SPA-HOSPNUM TO -HOSPNUM
           MOVE    TNS-TENSU-REC   TO  MCPDATA-REC
      *
           MOVE    "tbl_tensu"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  TNS-TENSU-REC
           ELSE
               INITIALIZE              TNS-TENSU-REC
               MOVE    1           TO  FLG-TENSU
           END-IF
      *
           MOVE    "tbl_tensu"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
      *
       900-TENSU-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ削除処理
      *****************************************************************
       910-DBDELETE-SEC                SECTION.
      *
           MOVE    "DBDELETE"          TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
      *
           .
      *
       910-DBDELETE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ更新処理
      *****************************************************************
       910-DBUPDATE-SEC                SECTION.
      *
           MOVE    "DBUPDATE"          TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
      *
           .
      *
       910-DBUPDATE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ追加処理
      *****************************************************************
       910-DBINSERT-SEC                SECTION.
      *
           MOVE    "DBINSERT"          TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
      *
           .
      *
       910-DBINSERT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
      *
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC           SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
      *
           .
      *
       910-DBCLOSECURSOR-EXT.
           EXIT.
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"      TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.

