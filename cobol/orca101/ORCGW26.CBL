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
       PROGRAM-ID.                               ORCGW26.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : 病棟入院基本料加算情報設定
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/10/22    NACL−太田    新規作成
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
           COPY    "W26SCR-SPA".
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-DBRC                            PIC 9(01).
           03  FLG-SYSKANRI                        PIC 9(01).
           03  FLG-KANJI                           PIC 9(01).
           03  FLG-TENSU                           PIC 9(01).
           03  FLG-ENTRYCHK                        PIC 9(01).
           03  FLG-NYUKSNCHK                       PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                                PIC 9(05).
           03  IDX2                                PIC 9(05).
           03  IDX3                                PIC 9(05).
           03  IDX4                                PIC 9(05).
           03  IDX-LST                             PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-WIDMSG                          PIC X(70). 
           03  WRK-YMD                             PIC X(10). 
           03  WRK-SYMD.
               05  WRK-SYY                         PIC 9(04).
               05  WRK-SMM                         PIC 9(02).
               05  WRK-SDD                         PIC 9(02).
           03  WRK-HENYMDG                         PIC X(09).
           03  WRK-KANACHK-MAE-INPUT               PIC X(400).
           03  WRK-DBPATH                          PIC X(20).
           03  WRK-COMBO.
               05  WRK-CMB-CD                      PIC X(10).
               05  WRK-CMB-IDX                     PIC 9(03).
               05  WRK-CMB-ITM                     PIC X(100).
               05  WRK-CMB-ITM2                    PIC X(100).
               05  WRK-CMB-ITM3                    PIC X(100).
           03  WRK-KANRICD                         PIC X(04).
           03  WRK-KBNCD                           PIC X(08).
           03  WRK-IDX                             PIC 9(05).
           03  WRK-SEL-CNT                         PIC 9(05).
           03  WRK-SEL-IDX                         PIC 9(05).
           03  WRK-KJNYMD                          PIC X(08).
           03  WRK-NYUKSNKBN                       PIC X(03).
           03  WRK-BTU-NYUKSNKBN                   PIC X(03).
           03  WRK-KSN-NYUKSNKBN                   PIC X(03).
           03  WRK-SRYCD                           PIC X(09).
           03  WRK-STYUKYMD                        PIC X(08).
           03  WRK-BTU-NAME                        PIC X(20).
           03  WRK-SELNUM                          PIC 9(03).
      *    入力項目名
           03  WRK-MCP-WIDGET                      PIC X(64).
      *
      *    固定値領域
       01  CONST-AREA.
           03  CONST-BTU-TOKNYUIN-MAX  PIC 9(05) VALUE 13.
           03  CONST-BTU-TOKNYUIN-VAL.
               05                      PIC X(12) VALUE "01 190111110".
               05                      PIC X(12) VALUE "02 190111210".
               05                      PIC X(12) VALUE "03 190055210".
               05                      PIC X(12) VALUE "04 190055310".
               05                      PIC X(12) VALUE "05 190739910".
               05                      PIC X(12) VALUE "06 190740110".
               05                      PIC X(12) VALUE "07 190055010".
               05                      PIC X(12) VALUE "08 190055110".
               05                      PIC X(12) VALUE "09 190028910".
               05                      PIC X(12) VALUE "10 190111410".
               05                      PIC X(12) VALUE "11 190066910".
               05                      PIC X(12) VALUE "12 190067010".
               05                      PIC X(12) VALUE "13 190075910".
           03  CONST-BTU-TOKNYUIN-R
                                   REDEFINES   CONST-BTU-TOKNYUIN-VAL.
               05   CONST-BTU-TOKNYUIN-OCC       OCCURS 13.
                   07  CONST-BTU-TOKNYUIN-KBN
                                       PIC X(02).
                   07                  PIC X(01).
                   07  CONST-BTU-TOKNYUIN-CD
                                       PIC X(09).
           03  CONST-BRM-TOKNYUIN-MAX  PIC 9(05) VALUE 13.
           03  CONST-BRM-TOKNYUIN-VAL.
               05                      PIC X(12) VALUE "01 190075710".
               05                      PIC X(12) VALUE "02 190774110".
               05                      PIC X(12) VALUE "03 190024510".
               05                      PIC X(12) VALUE "04 190024310".
               05                      PIC X(12) VALUE "05 190024610".
               05                      PIC X(12) VALUE "06 190024710".
               05                      PIC X(12) VALUE "07 190066710".
               05                      PIC X(12) VALUE "08 190066810".
               05                      PIC X(12) VALUE "09 190024810".
               05                      PIC X(12) VALUE "10 190075510".
               05                      PIC X(12) VALUE "11 190788810".
               05                      PIC X(12) VALUE "20 190076710".
               05                      PIC X(12) VALUE "21 190076810".
           03  CONST-BRM-TOKNYUIN-R
                                   REDEFINES   CONST-BRM-TOKNYUIN-VAL.
               05   CONST-BRM-TOKNYUIN-OCC       OCCURS 13.
                   07  CONST-BRM-TOKNYUIN-KBN
                                       PIC X(02).
                   07                  PIC X(01).
                   07  CONST-BRM-TOKNYUIN-CD
                                       PIC X(09).
      *
      *    03  CONST-NANBYO            PIC X(09) VALUE "190101770".
      *    03  CONST-TOKUSYUCD         PIC X(09) VALUE "190101970".
      *    03  CONST-YORYOCD-VAL.
      *        05                      PIC X(09) VALUE "190106070".
      *        05                      PIC X(09) VALUE "190106170".
      *        05                      PIC X(09) VALUE "190106270".
      *    03  CONST-YORYOCD-R     REDEFINES   CONST-YORYOCD-VAL.
      *        05  CONST-YORYOCD       PIC X(09) OCCURS 3.
      *    03  CONST-JIDOCD            PIC X(09) VALUE "190110170".
      *    03  CONST-SEISINCD          PIC X(09) VALUE "190106970".
      *    03  CONST-KANGOCD-VAL.
      *        05                      PIC X(09) VALUE "190102070".
      *        05                      PIC X(09) VALUE "190102170".
      *        05                      PIC X(09) VALUE "190102270".
      *        05                      PIC X(09) VALUE "190102370".
      *        05                      PIC X(09) VALUE "190102470".
      *    03  CONST-KANGOCD-R     REDEFINES   CONST-KANGOCD-VAL.
      *        05  CONST-KANGOCD       PIC X(09) OCCURS 5.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY  "CPSYSKANRI.INC".
      *    施設基準コードフラグ情報
           COPY  "CPSK1006.INC".
      *    病棟情報
           COPY  "CPSK5001.INC".
      *    病棟種別
           COPY  "CPSK5101.INC".
      *    病棟特定入院料
           COPY  "CPSK5110.INC".
      *
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *    入院料加算チェック
       01  NYUKSNCHK-REC.
           COPY    "CPNYUKSNCHK.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
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
           COPY    "W12.INC".
           COPY    "W13.INC".
           COPY    "W14.INC".
           COPY    "W15.INC".
           COPY    "W20.INC".
           COPY    "W21.INC".
           COPY    "W22.INC".
           COPY    "W23.INC".
           COPY    "W24.INC".
           COPY    "W25.INC".
           COPY    "W26.INC".
           COPY    "W27.INC".
           COPY    "WERR.INC".
           COPY    "WID1.INC".
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
           MOVE    SPA-FREE        TO  SPA-W26FREE
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
           IF    ( FLG-END         =   ZERO )
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-W26FREE     TO  SPA-FREE
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
           MOVE    "W26    "           TO  MCP-WINDOW.
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
       300-SCREEN-SEC              SECTION.
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
       310-SPASET-SEC              SECTION.
      *
           MOVE    SPACE           TO  SPA-W26
                                           W26
           INITIALIZE                  SPA-W26
                                           W26
      *
      *    コンボボックス初期化
           PERFORM 310-CMB-SYOKI-SEC
      *
      *
      *    画面初期化処理
           PERFORM 420-CLEAR-SEC
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    コンボボックス初期処理
      *****************************************************************
       310-CMB-SYOKI-SEC               SECTION.
      *
           INITIALIZE              SPA-GMN-W26-CMB-DAT-AREA
      *
      *    病棟コンボ
           PERFORM 310-CMB-BTU-NAME-SET-SEC
      *
           .
       310-CMB-SYOKI-EXT.
           EXIT.
      *****************************************************************
      *    病棟コンボ設定処理
      *****************************************************************
       310-CMB-BTU-NAME-SET-SEC      SECTION.
      *
      *    病棟情報検索処理
           INITIALIZE  SYSKANRI-REC
           MOVE    "5001"          TO  SYS-KANRICD
           MOVE    SPA-SYSYMD
                                   TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           MOVE    ZERO            TO  SPA-GMN-W26-BTU-NAME-CNT
           PERFORM UNTIL ( FLG-DBRC    NOT =   ZERO )
                     OR  ( SPA-GMN-W26-BTU-NAME-CNT    >   50 )
      *
               COMPUTE SPA-GMN-W26-BTU-NAME-CNT
                   =   SPA-GMN-W26-BTU-NAME-CNT    +   1
      *
               MOVE    SPA-GMN-W26-BTU-NAME-CNT
                                   TO  IDX1
      *
               MOVE    MCPDATA-REC TO  SYS-5001-REC
      *
      *        病棟名
               MOVE    SYS-5001-KBNCD
                                   TO  SPA-GMN-W26-BTU-NAME-ITM
                                                       (IDX1) (1 : 2)
               MOVE    SYS-5001-BTU-NAME
                                   TO  SPA-GMN-W26-BTU-NAME-ITM
                                                       (IDX1) (4 : )
      *
      *        病棟種別
               MOVE    "5101"      TO  WRK-KANRICD
               MOVE    SYS-5001-BTU-SBT
                                   TO  WRK-KBNCD
               MOVE    SPA-SYSYMD
                                   TO  WRK-KJNYMD
               PERFORM 3101-SYSKANRI-SEL-SEC
               IF    ( FLG-SYSKANRI    =   ZERO )
                   MOVE    MCPDATA-REC TO  SYS-5101-REC
                   MOVE    SYS-5101-BTU-SBT-NM
                                   TO  SPA-GMN-W26-BTU-NAME-ITM2 (IDX1)
               END-IF
      *
      *        入院料
               IF    ( SYS-5001-BTU-TOKTEI-NYUIN
                                           =   SPACE )
      *            点数マスタを検索し、入院基本料名を設定する
                   PERFORM 3101-TENSU-SEL-SEC
                   IF    ( FLG-TENSU       =   ZERO )
                       MOVE    TNS-NAME
                                   TO  SPA-GMN-W26-BTU-NAME-ITM3 (IDX1)
                   END-IF
               ELSE
      *
      *            システム管理マスタを検索し、特定入院料名称を設定する
                   MOVE    "5110"          TO  WRK-KANRICD
                   MOVE    SYS-5001-BTU-TOKTEI-NYUIN
                                           TO  WRK-KBNCD
                   MOVE    SPA-SYSYMD      TO  WRK-KJNYMD
                   PERFORM 3101-SYSKANRI-SEL-SEC
                   IF    ( FLG-SYSKANRI    =   ZERO )
                       MOVE    MCPDATA-REC TO  SYS-5110-REC
                       MOVE    SYS-5110-BTU-TOKUTEINYUIN-NM
                                   TO  SPA-GMN-W26-BTU-NAME-ITM3 (IDX1)
                   END-IF
               END-IF
      *
      *        病棟情報クローズ
               MOVE    "SYSKANRI-KEY2"  TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
      *    病棟情報クローズ
           MOVE    "SYSKANRI-KEY2"  TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       310-CMB-BTU-NAME-SET-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ検索処理
      *****************************************************************
       3101-SYSKANRI-SEL-SEC       SECTION.
      *
           INITIALIZE              SYSKANRI-REC
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    WRK-KANRICD     TO  SYS-KANRICD
           MOVE    WRK-KBNCD       TO  SYS-KBNCD
           MOVE    WRK-KJNYMD      TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY10"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    =   ZERO )
               CONTINUE
           ELSE
               MOVE    1          TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "SYSKANRI-KEY10"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       3101-SYSKANRI-SEL-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索処理
      *****************************************************************
       3101-TENSU-SEL-SEC          SECTION.
      *
           MOVE    ZERO            TO  FLG-TENSU
      *
           INITIALIZE              TNS-TENSU-REC
      *
           MOVE    SYS-5001-BTU-KHNSRYCD
                                   TO  TNS-SRYCD
           MOVE    SPA-SYSYMD
                                   TO  ORC-DBYMD
           MOVE    TNS-TENSU-REC   TO  MCPDATA-REC
      *
      *    点数マスタ検索
           MOVE    "TENSU-KEY" TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        =   ZERO )
               MOVE    MCPDATA-REC TO  TNS-TENSU-REC
           ELSE
               MOVE    1           TO  FLG-TENSU
           END-IF
      *
      *    点数マスタクローズ
           MOVE    "TENSU-KEY"     TO  ORC-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
      *
       3101-TENSU-SEL-EXT.
           EXIT.
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-WID1-SET-SEC            SECTION.
      *
           IF    ( SPA-WID1-FLG    =   "OK" )
               EVALUATE    SPA-WIDCD
               WHEN "3001"
                   PERFORM 481-TOUROKU-SEC
               END-EVALUATE
           END-IF
      *
      *
           .
       330-WID1-SET-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                           SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO      MCP-WIDGET
      *    戻る
           WHEN    "CLICKED"       ALSO    "B01"
               MOVE   "CHANGE"             TO  MCP-PUTTYPE
               PERFORM  210-BACK
      *    クリア
           WHEN    "CLICKED"       ALSO    "B02"
               MOVE   "CHANGE"             TO  MCP-PUTTYPE
      *        PERFORM 4201-CHK-BTN-CLEAR-SEC
      *        MOVE    2                   TO  SPA-GMN-W26-CUR
               PERFORM 420-CLEAR-SEC
      *    選択番号
           WHEN    "CLICKED"       ALSO    "B03"
               MOVE   "CHANGE"             TO  MCP-PUTTYPE
               PERFORM 4101-GMN-SPA-SET-SEC
               MOVE    100                 TO  SPA-GMN-W26-CUR
      *    登録
           WHEN    "CLICKED"       ALSO    "B12"
               MOVE   "CHANGE"             TO  MCP-PUTTYPE
               PERFORM 480-TOUROKU-SEC
      *    入院加算情報
           WHEN    "CLICKED"       ALSO    "CHK_NANBYO"
           WHEN    "CLICKED"       ALSO    "CHK_TOKUSYU"
           WHEN    "CLICKED"       ALSO    "CHK_YORYO1"
           WHEN    "CLICKED"       ALSO    "CHK_YORYO2"
           WHEN    "CLICKED"       ALSO    "CHK_YORYO3"
           WHEN    "CLICKED"       ALSO    "CHK_JIDO"
           WHEN    "CLICKED"       ALSO    "CHK_SEISIN"
           WHEN    "CLICKED"       ALSO    "CHK_KANGO1"
           WHEN    "CLICKED"       ALSO    "CHK_KANGO2"
           WHEN    "CLICKED"       ALSO    "CHK_KANGO3"
           WHEN    "CLICKED"       ALSO    "CHK_KANGO4"
           WHEN    "CLICKED"       ALSO    "CHK_KANGO5"
               MOVE   "CHANGE"             TO  MCP-PUTTYPE
      *
      *        入力個所のセット
               PERFORM 400-GMN-INPUT-SEC
      *        入力チェック処理
               PERFORM 410-INPUT-CHK-SEC
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
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *    病棟名称
           WHEN    "ACTIVATE"      ALSO    "BTU_NAME"
               PERFORM 4100-BTU-NAME-CHK-SEC
      *
      *    選択番号
           WHEN    "ACTIVATE"      ALSO    "SELNUM"
               PERFORM 4100-SELNUM-CHK-SEC
      *
      *    有効期間リスト
           WHEN        ANY         ALSO    "YUKOYMDLST"
               PERFORM 4101-YUKOYMDLST-SEL-SEC
      *
           WHEN    OTHER
      *
      *        入力個所のセット
               PERFORM 400-GMN-INPUT-SEC
      *        入力チェック処理
               PERFORM 410-INPUT-CHK-SEC
           END-EVALUATE
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
           MOVE    ZERO            TO  SPA-GMN-W26-CUR
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
      *    有効開始日
      *    MOVE    W26-STYUKYMD    TO  SPA-GMN-W26-STYUKYMD
      *
      *    有効終了日
      *    MOVE    W26-EDYUKYMD    TO  SPA-GMN-W26-EDYUKYMD
      *
      *    難病特別入院診療加算
           MOVE    W26-CHK-NANBYO  TO  SPA-GMN-W26-CHK-NANBYO
      *
      *    特定疾患入院施設管理加算
           MOVE    W26-CHK-TOKUSYU TO  SPA-GMN-W26-CHK-TOKUSYU
      *
      *    療養病棟環境加算
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   3 )
               MOVE    W26-CHK-YORYO (IDX1)
                                   TO  SPA-GMN-W26-CHK-YORYO (IDX1)
           END-PERFORM
      *
      *    児童・思春期精神科入院医療管理加算
           MOVE    W26-CHK-JIDO    TO  SPA-GMN-W26-CHK-JIDO
      *
      *    精神科応急入院施設管理加算
           MOVE    W26-CHK-SEISIN  TO  SPA-GMN-W26-CHK-SEISIN
      *
      *    看護配置加算
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   5 )
               MOVE    W26-CHK-KANGO (IDX1)
                                   TO  SPA-GMN-W26-CHK-KANGO (IDX1)
           END-PERFORM
      *
           .
      *
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    有効期間リスト選択処理
      *****************************************************************
       4101-YUKOYMDLST-SEL-SEC       SECTION.
      *
           PERFORM VARYING     IDX-LST FROM    1   BY  1
                   UNTIL     ( IDX-LST >   SPA-GMN-W26-YUKOYMDLST-CNT )
      *
               IF    ( W26-YUKOYMDLST-SELECT (IDX-LST) =   "T"  )
                   MOVE    IDX-LST     TO  SPA-GMN-W26-YUKOYMDLST-SEL
                   MOVE    SPA-GMN-W26-TSTYUKYMD-S (IDX-LST)
                                       TO  WRK-STYUKYMD
                   PERFORM 4100-INPUT-AREA-EDIT-SEC
                   MOVE    SPA-GMN-W26-TSELNUM (IDX-LST)
                                       TO  SPA-GMN-W26-SELNUM
                   MOVE    SPA-GMN-W26-YUKOYMDLST-CNT
                                       TO  IDX-LST
               END-IF
      *
           END-PERFORM
           .
      *
       4101-YUKOYMDLST-SEL-EXT.
           EXIT.
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC              SECTION.
      *
      *    病棟名称チェック処理
           PERFORM 4101-BTU-NAME-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               MOVE    SPA-GMN-W26-BTU-NAME
                                   TO  WRK-BTU-NAME
               PERFORM 420-CLEAR-SEC
               MOVE    WRK-BTU-NAME
                                   TO  SPA-GMN-W26-BTU-NAME
               MOVE    1           TO  SPA-GMN-W26-CUR
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    選択番号チェック
           PERFORM 4101-SELNUM-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               MOVE    SPA-GMN-W26-SELNUM
                                   TO  WRK-SELNUM
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
               MOVE    WRK-SELNUM  TO  SPA-GMN-W26-SELNUM
               MOVE    ZERO        TO  SPA-GMN-W26-YUKOYMDLST-SEL
               MOVE    100         TO  SPA-GMN-W26-CUR
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    施設基準チェック処理
           PERFORM 4100-SSTKIJUN-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
           .
      *
       4102-KIHON-CHK-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "W01"               TO  SPA-SAKIPG
           MOVE    "W26"               TO  SPA-MOTOPG
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
           INITIALIZE  SPA-GMN-W26-HEAD-AREA
                       SPA-GMN-W26-INPUT-AREA
                       SPA-GMN-W26-YUKOYMDLST
           PERFORM 4201-CHK-BTN-CLEAR-SEC
      *
           MOVE    WIDGET-NORMAL
                               TO  SPA-GMN-W26-STATE
      *
           MOVE    1           TO  SPA-GMN-W26-CUR
      *
           .
       420-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    登録処理
      *****************************************************************
       480-TOUROKU-SEC             SECTION.
      *
      *    入力個所のチェック
           PERFORM 410-INPUT-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
             OR  ( FLG-END     NOT =   ZERO  )
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
       481-TOUROKU-SEC                 SECTION.
      *
           MOVE    "5001"          TO  WRK-KANRICD
           MOVE    SPA-GMN-W26-BTU-NAME-CD
                                   TO  WRK-KBNCD
           MOVE    SPA-GMN-W26-STYUKYMD-S
                                   TO  WRK-KJNYMD
      *
      *    更新対象のデータが存在するかチェック
           PERFORM 3101-SYSKANRI-SEL-SEC
           IF    ( FLG-SYSKANRI    NOT =   ZERO )
               MOVE    "1201"      TO  SPA-ERRCD
               GO  TO  481-TOUROKU-EXT
           END-IF
      *
           MOVE    MCPDATA-REC     TO  SYS-5001-REC
      *
           PERFORM 4811-BTU-KSN-EDIT-SEC
           MOVE    SYS-5001-REC    TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-UPDATE-SEC
      *
           IF    ( FLG-DBRC    NOT =   ZERO )
               MOVE    "1201"      TO  SPA-ERRCD
               GO  TO  481-TOUROKU-EXT
           END-IF
      *
      *    画面処理化
           PERFORM 420-CLEAR-SEC
      *
           .
       481-TOUROKU-EXT.
           EXIT.
      *****************************************************************
      *    病棟加算編集処理
      *****************************************************************
       4811-BTU-KSN-EDIT-SEC           SECTION.
      *
      *    難病患者等特別入院診療加算
      *    MOVE    CONST-NANBYO    TO  SYS-5001-NANBYO-CD
           IF    ( SPA-GMN-W26-CHK-NANBYO      =   "F" )
               MOVE    "1"         TO  SYS-5001-NANBYO-KBN
           ELSE
               MOVE    "2"         TO  SYS-5001-NANBYO-KBN
           END-IF
      *
      *    特殊疾患入院施設管理加算
      *    MOVE    CONST-TOKUSYUCD TO  SYS-5001-TOKUSYU-CD
           IF    ( SPA-GMN-W26-CHK-TOKUSYU     =   "F" )
               MOVE    "1"         TO  SYS-5001-TOKUSYU-KBN
           ELSE
               MOVE    "2"         TO  SYS-5001-TOKUSYU-KBN
           END-IF
      *
      *    療養病棟療養環境加算
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   3 )
      *        MOVE    CONST-YORYOCD (IDX1)
      *                            TO  SYS-5001-YORYO-CD (IDX1)
               IF    ( SPA-GMN-W26-CHK-YORYO  (IDX1)  =   "F" )
                   MOVE    "1"         TO  SYS-5001-YORYO-KBN (IDX1)
               ELSE
                   MOVE    "2"         TO  SYS-5001-YORYO-KBN (IDX1)
               END-IF
           END-PERFORM
      *
      *    児童・思春期精神科入院医療管理加算
      *    MOVE    CONST-JIDOCD        TO  SYS-5001-JIDO-CD
           IF    ( SPA-GMN-W26-CHK-JIDO        =   "F" )
               MOVE    "1"             TO  SYS-5001-JIDO-KBN
           ELSE
               MOVE    "2"             TO  SYS-5001-JIDO-KBN
           END-IF
      *
      *    精神科応急入院施設管理加算
      *    MOVE    CONST-SEISINCD      TO  SYS-5001-SEISIN-CD
           IF    ( SPA-GMN-W26-CHK-SEISIN      =   "F" )
               MOVE    "1"             TO  SYS-5001-SEISIN-KBN
           ELSE
               MOVE    "2"             TO  SYS-5001-SEISIN-KBN
           END-IF
      *
      *    看護配置加算
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   5 )
      *        MOVE    CONST-KANGOCD (IDX1)
      *                                TO  SYS-5001-KANGO-CD (IDX1)
               IF    ( SPA-GMN-W26-CHK-KANGO (IDX1)    =   "F" )
                   MOVE    "1"         TO  SYS-5001-KANGO-KBN (IDX1)
               ELSE
                   MOVE    "2"         TO  SYS-5001-KANGO-KBN (IDX1)
               END-IF
           END-PERFORM
      *
           .
      *
       4811-BTU-KSN-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病棟名称チェック処理
      *****************************************************************
       4100-BTU-NAME-CHK-SEC           SECTION.
      *
           PERFORM 420-CLEAR-SEC
      *
           MOVE    W26-BTU-NAME    TO  SPA-GMN-W26-BTU-NAME
      *
           PERFORM 4101-BTU-NAME-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               MOVE    1           TO  SPA-GMN-W26-CUR
               GO  TO  4100-BTU-NAME-CHK-EXT
           END-IF
      *
      *    入力領域編集処理
           MOVE    SPA-SYSYMD      TO  WRK-STYUKYMD
           PERFORM 4100-INPUT-AREA-EDIT-SEC
      *
      *    有効期間リスト編集処理
           PERFORM 4100-YUKOYMDLST-EDIT-SEC
      *
           MOVE    2           TO  SPA-GMN-W26-CUR
      *
           .
      *
       4100-BTU-NAME-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟名称チェック処理
      *****************************************************************
       4101-BTU-NAME-CHK-SEC           SECTION.
      *
           IF    ( SPA-GMN-W26-BTU-NAME    =   SPACE )
               MOVE    "0002"      TO  SPA-ERRCD
               GO  TO  4101-BTU-NAME-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W26-BTU-NAME-CD
                                       TO  WRK-CMB-CD
           PERFORM 4103-CMB-BTU-NAME-SRH-SEC
           IF   (  WRK-CMB-ITM     =   SPACE )
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4101-BTU-NAME-CHK-EXT
           END-IF
      *
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W26-BTU-NAME
           MOVE    WRK-CMB-ITM2    TO  SPA-GMN-W26-BTU-SBT
           MOVE    WRK-CMB-ITM3    TO  SPA-GMN-W26-BTU-KHNRYO
           .
      *
       4101-BTU-NAME-CHK-EXT.
           EXIT.
      *****************************************************************
      *    選択番号チェック処理
      *****************************************************************
       4100-SELNUM-CHK-SEC             SECTION.
      *
           MOVE    W26-SELNUM      TO  SPA-GMN-W26-SELNUM
      *
           PERFORM 4101-SELNUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
               MOVE    W26-SELNUM  TO  SPA-GMN-W26-SELNUM
               MOVE    ZERO        TO  SPA-GMN-W26-YUKOYMDLST-SEL
               MOVE    100         TO  SPA-GMN-W26-CUR
               GO  TO  4100-SELNUM-CHK-EXT
           END-IF
           
      *
           MOVE    SPA-GMN-W26-SELNUM
                                   TO  SPA-GMN-W26-YUKOYMDLST-SEL
           MOVE    SPA-GMN-W26-TEDYUKYMD-S (SPA-GMN-W26-SELNUM)
                                   TO  WRK-STYUKYMD
           PERFORM 4100-INPUT-AREA-EDIT-SEC
           MOVE    W26-SELNUM      TO  SPA-GMN-W26-SELNUM
      *
           MOVE    2               TO  SPA-GMN-W26-CUR
      *
           .
      *
       4100-SELNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    選択番号チェック処理
      *****************************************************************
       4101-SELNUM-CHK-SEC             SECTION.
      *
           IF    ( SPA-GMN-W26-SELNUM  <=   ZERO )
               MOVE    "0006"      TO  SPA-ERRCD
               GO  TO  4101-SELNUM-CHK-EXT
           END-IF
      *
           IF    ( SPA-GMN-W26-SELNUM  >   SPA-GMN-W26-YUKOYMDLST-CNT )
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4101-SELNUM-CHK-EXT
           END-IF
      *
           .
      *
       4101-SELNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    有効期間リスト編集処理
      *****************************************************************
       4100-YUKOYMDLST-EDIT-SEC        SECTION.
      *
           INITIALIZE      SPA-GMN-W26-YUKOYMDLST
                           SYSKANRI-REC
      *
           MOVE    "5001"          TO  SYS-KANRICD
           MOVE    SPA-GMN-W26-BTU-NAME-CD
                                   TO  SYS-KBNCD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY4" TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           PERFORM VARYING IDX-LST FROM    1   BY  1
                   UNTIL (FLG-DBRC NOT =   ZERO )
                    OR   ( IDX-LST >   100 )
      *
               MOVE    MCPDATA-REC TO  SYS-5001-REC
      *
               MOVE    IDX-LST     TO  SPA-GMN-W26-YUKOYMDLST-CNT
      *
      *        選択番号
               MOVE    IDX-LST     TO  SPA-GMN-W26-TSELNUM (IDX-LST)
      *
      *        有効開始年月日
               MOVE    SYS-5001-STYUKYMD
                                   TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG TO  SPA-GMN-W26-TSTYUKYMD   (IDX-LST)
               MOVE    WRK-SYMD    TO  SPA-GMN-W26-TSTYUKYMD-S (IDX-LST)
      *
      *        有効終了年月日
               MOVE    SYS-5001-EDYUKYMD
                                   TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG TO  SPA-GMN-W26-TEDYUKYMD   (IDX-LST)
               MOVE    WRK-SYMD    TO  SPA-GMN-W26-TEDYUKYMD-S (IDX-LST)
      *
               IF    ( SPA-SYSYMD  >=  SYS-5001-STYUKYMD )
                AND  ( SPA-SYSYMD  <=  SYS-5001-EDYUKYMD )
                   MOVE    IDX-LST TO  SPA-GMN-W26-YUKOYMDLST-SEL
                                       SPA-GMN-W26-SELNUM
               END-IF
      *
               MOVE    "SYSKANRI-KEY4" TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
           MOVE    "SYSKANRI-KEY4" TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
           .
      *
       4100-YUKOYMDLST-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力領域編集処理
      *****************************************************************
       4100-INPUT-AREA-EDIT-SEC        SECTION.
      *
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
           MOVE    "5001"          TO  WRK-KANRICD
           MOVE    SPA-GMN-W26-BTU-NAME-CD
                                   TO  WRK-KBNCD
           MOVE    WRK-STYUKYMD    TO  WRK-KJNYMD
           PERFORM 3101-SYSKANRI-SEL-SEC
           IF    ( FLG-SYSKANRI    NOT =   ZERO )
               MOVE    "0004"      TO  SPA-ERRCD
               GO  TO  4100-INPUT-AREA-EDIT-EXT
           END-IF
      *
           MOVE    MCPDATA-REC     TO  SYS-5001-REC
      *
           IF    ( SYS-5001-EDYUKYMD   <   SPA-SYSYMD )
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W26-STATE
           ELSE
               MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-W26-STATE
           END-IF
      *
      *    有効期間開始日
           MOVE    SYS-5001-STYUKYMD
                                   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
      *
           MOVE    WRK-HENYMDG     TO  SPA-GMN-W26-STYUKYMD
           MOVE    WRK-SYMD        TO  SPA-GMN-W26-STYUKYMD-S
      *
      *    有効期間終了日
           MOVE    SYS-5001-EDYUKYMD
                                   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
      *
           MOVE    WRK-HENYMDG     TO  SPA-GMN-W26-EDYUKYMD
           MOVE    WRK-SYMD        TO  SPA-GMN-W26-EDYUKYMD-S
      *
      *    難病患者等特別入院診療加算
           IF    ( SYS-5001-NANBYO-KBN     =   2 )
               MOVE    "T"         TO  SPA-GMN-W26-CHK-NANBYO
           ELSE
               MOVE    "F"         TO  SPA-GMN-W26-CHK-NANBYO
           END-IF
      *    特殊疾患入院施設管理加算
           IF    ( SYS-5001-TOKUSYU-KBN    =   2 )
               MOVE    "T"         TO  SPA-GMN-W26-CHK-TOKUSYU
           ELSE
               MOVE    "F"         TO  SPA-GMN-W26-CHK-TOKUSYU
           END-IF
      *    療養病棟療養環境加算
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   3 )
               IF    ( SYS-5001-YORYO-KBN (IDX1)   =   2 )
                   MOVE    "T"     TO  SPA-GMN-W26-CHK-YORYO (IDX1)
               ELSE
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-YORYO (IDX1)
               END-IF
           END-PERFORM
      *    児童・思春期精神科入院医療管理加算
           IF    ( SYS-5001-JIDO-KBN   =   2 )
               MOVE    "T"     TO  SPA-GMN-W26-CHK-JIDO
           ELSE
               MOVE    "F"     TO  SPA-GMN-W26-CHK-JIDO
           END-IF
      *    精神科応急入院施設管理加算
           IF    ( SYS-5001-SEISIN-KBN =   2 )
               MOVE    "T"     TO  SPA-GMN-W26-CHK-SEISIN
           ELSE
               MOVE    "F"     TO  SPA-GMN-W26-CHK-SEISIN
           END-IF
      *    看護配置加算
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   5 )
               IF    ( SYS-5001-KANGO-KBN (IDX1)   =   2 )
                   MOVE    "T"     TO  SPA-GMN-W26-CHK-KANGO (IDX1)
               ELSE
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-KANGO (IDX1)
               END-IF
           END-PERFORM
           .
      *
       4100-INPUT-AREA-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    施設基準チェック処理
      *****************************************************************
       4100-SSTKIJUN-CHK-SEC           SECTION.
      *
           MOVE    SPA-GMN-W26-TSTYUKYMD-S (SPA-GMN-W26-SELNUM)
                                   TO  WRK-STYUKYMD
      *
           MOVE    SPACE           TO  WRK-BTU-NYUKSNKBN
                                       WRK-KSN-NYUKSNKBN
      *
      *    病棟情報検索処理
           PERFORM 4100-SYS-5001-SEL-SEC
           IF    ( FLG-SYSKANRI    =   ZERO )
      *        病棟入院料加算情報取得処理
               PERFORM 4100-BTU-NYUKSN-GET-SEC
           END-IF
      *
      *    施設基準検索処理
           PERFORM 4100-SYS-1006-SEL-SEC
           IF    ( FLG-SYSKANRI    NOT =   ZERO )
               GO  TO  4100-SSTKIJUN-CHK-EXT
           END-IF
      *
      *    難病患者等特別入院診療加算
           PERFORM 4100-A210-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-SSTKIJUN-CHK-EXT
           END-IF
      *
      *    特殊疾患入院施設管理加算
           PERFORM 4100-A211-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-SSTKIJUN-CHK-EXT
           END-IF
      *
      *    療養病棟療養環境加算
           PERFORM 4100-A222-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-SSTKIJUN-CHK-EXT
           END-IF
      *
      *    児童・思春期精神科入院医療管理加算
           PERFORM 4100-A231-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-SSTKIJUN-CHK-EXT
           END-IF
      *
      *    精神科応急入院施設管理加算
           PERFORM 4100-A228-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-SSTKIJUN-CHK-EXT
           END-IF
      *
      *    看護配置加算
           PERFORM 4100-A213-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-SSTKIJUN-CHK-EXT
           END-IF
      *
           .
       4100-SSTKIJUN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院料加算チェック処理
      *****************************************************************
       4100-NYUKSN-CHK-SEC             SECTION.
      *
           MOVE    ZERO            TO  FLG-NYUKSNCHK
      *
           INITIALIZE  NYUKSNCHK-REC
      *
           MOVE    WRK-BTU-NYUKSNKBN
                                   TO  NYUKSNCHK-NYUINKBN
           MOVE    WRK-KSN-NYUKSNKBN
                                   TO  NYUKSNCHK-KSNKBN
           MOVE    WRK-STYUKYMD    TO  ORC-DBYMD
      *
           MOVE    "NYUKSNCHK-KEY" TO  WRK-DBPATH
           MOVE    NYUKSNCHK-REC   TO  MCPDATA-REC
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        =   ZERO )
               MOVE    MCPDATA-REC TO  NYUKSNCHK-REC
           ELSE
               GO  TO          4100-NYUKSN-CHK-EXT
           END-IF
      *
           IF    ( NYUKSNCHK-CHKKBN    =   "1" OR "2" )
               CONTINUE
           ELSE
               MOVE    "0005"      TO  SPA-ERRCD
               GO  TO  4100-NYUKSN-CHK-EXT
           END-IF
      *
           .
       4100-NYUKSN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    難病患者等特別入院診療加算チェック処理
      *****************************************************************
       4100-A210-CHK-SEC               SECTION.
      *
           IF    ( SPA-GMN-W26-CHK-NANBYO  =   "T" )
      *        加算可能かチェック
               MOVE    SYS-5001-NANBYO-CD
                                   TO  WRK-SRYCD
               PERFORM 4100-TENSU-SEL-SEC
      *
               MOVE    WRK-NYUKSNKBN
                                   TO  WRK-KSN-NYUKSNKBN
      *
               PERFORM 4100-NYUKSN-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
      *
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-NANBYO
      *
                   MOVE    2       TO  SPA-GMN-W26-CUR
                   GO  TO  4100-A210-CHK-EXT
               END-IF
      *
           END-IF
      *
           .
       4100-A210-CHK-EXT.
           EXIT.
      *****************************************************************
      *    特殊疾患入院施設管理加算チェック処理
      *****************************************************************
       4100-A211-CHK-SEC               SECTION.
      *
           IF    ( SPA-GMN-W26-CHK-TOKUSYU     =   "T" )
      *        加算可能かチェック
               MOVE    SYS-5001-TOKUSYU-CD
                                   TO  WRK-SRYCD
               PERFORM 4100-TENSU-SEL-SEC
      *
               MOVE    WRK-NYUKSNKBN
                                   TO  WRK-KSN-NYUKSNKBN
      *
               PERFORM 4100-NYUKSN-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
      *
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-TOKUSYU
      *
                   MOVE    3       TO  SPA-GMN-W26-CUR
                   GO  TO  4100-A211-CHK-EXT
               END-IF
      *
      *        施設基準をチェック
               IF  ( SYS-1006-SSTKIJUN (009)   =   1 )
                   CONTINUE
               ELSE
                   MOVE    3       TO  SPA-GMN-W26-CUR
      *
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-TOKUSYU
      *
                   MOVE    "0003"  TO  SPA-ERRCD
                   GO  TO  4100-A211-CHK-EXT
               END-IF
           END-IF
      *
           .
       4100-A211-CHK-EXT.
           EXIT.
      *****************************************************************
      *    療養病棟環境加算チェック処理
      *****************************************************************
       4100-A222-CHK-SEC               SECTION.
      *
           IF  ( SPA-GMN-W26-CHK-YORYO (1)     =   "T" )
      *        加算可能かチェック
               MOVE    SYS-5001-YORYO-CD (1)
                                   TO  WRK-SRYCD
               PERFORM 4100-TENSU-SEL-SEC
      *
               MOVE    WRK-NYUKSNKBN
                                   TO  WRK-KSN-NYUKSNKBN
      *
               PERFORM 4100-NYUKSN-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
      *
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-YORYO (1)
      *
                   MOVE    4       TO  SPA-GMN-W26-CUR
                   GO  TO  4100-A222-CHK-EXT
               END-IF
      *
      *        施設基準をチェック
               IF    ( SYS-1006-SSTKIJUN (090) =   1 )
                   CONTINUE
               ELSE
                   MOVE    4       TO  SPA-GMN-W26-CUR
      *
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-YORYO (1)
      *
                   MOVE    "0003"  TO  SPA-ERRCD
                   GO  TO  4100-A222-CHK-EXT
               END-IF
           END-IF
      *
           IF  ( SPA-GMN-W26-CHK-YORYO (2)     =   "T" )
      *        加算可能かチェック
               MOVE    SYS-5001-YORYO-CD (2)
                                   TO  WRK-SRYCD
               PERFORM 4100-TENSU-SEL-SEC
      *
               MOVE    WRK-NYUKSNKBN
                                   TO  WRK-KSN-NYUKSNKBN
      *
               PERFORM 4100-NYUKSN-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
      *
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-YORYO (2)
      *
                   MOVE    5       TO  SPA-GMN-W26-CUR
                   GO  TO  4100-A222-CHK-EXT
               END-IF
      *
      *        施設基準をチェック
               IF    ( SYS-1006-SSTKIJUN (091) =   1 )
                   CONTINUE
               ELSE
                   MOVE    5       TO  SPA-GMN-W26-CUR
                   MOVE    "0003"  TO  SPA-ERRCD
      *
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-YORYO (2)
      *
                   GO  TO  4100-A222-CHK-EXT
               END-IF
           END-IF
      *
           IF  ( SPA-GMN-W26-CHK-YORYO (3)     =   "T" )
      *        加算可能かチェック
               MOVE    SYS-5001-YORYO-CD (3)
                                   TO  WRK-SRYCD
               PERFORM 4100-TENSU-SEL-SEC
      *
               MOVE    WRK-NYUKSNKBN
                                   TO  WRK-KSN-NYUKSNKBN
      *
               PERFORM 4100-NYUKSN-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
      *
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-YORYO (3)
      *
                   MOVE    6       TO  SPA-GMN-W26-CUR
                   GO  TO  4100-A222-CHK-EXT
               END-IF
      *
      *        施設基準をチェック
               IF    ( SYS-1006-SSTKIJUN (110) =   1 )
                   CONTINUE
               ELSE
                   MOVE    6       TO  SPA-GMN-W26-CUR
                   MOVE    "0003"  TO  SPA-ERRCD
      *
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-YORYO (3)
      *
                   GO  TO  4100-A222-CHK-EXT
               END-IF
           END-IF
      *
           .
       4100-A222-CHK-EXT.
           EXIT.
      *****************************************************************
      *    児童・思春期精神科入院医療管理加算チェック処理
      *****************************************************************
       4100-A231-CHK-SEC               SECTION.
      *
           IF  ( SPA-GMN-W26-CHK-JIDO  =   "T" )
      *        加算可能かチェック
               MOVE    SYS-5001-JIDO-CD
                                   TO  WRK-SRYCD
               PERFORM 4100-TENSU-SEL-SEC
      *
               MOVE    WRK-NYUKSNKBN
                                   TO  WRK-KSN-NYUKSNKBN
      *
               PERFORM 4100-NYUKSN-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
      *
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-JIDO
      *
                   MOVE    7       TO  SPA-GMN-W26-CUR
                   GO  TO  4100-A231-CHK-EXT
               END-IF
      *
      *        施設基準をチェック
               IF    ( SYS-1006-SSTKIJUN (225) =   1 )
                   CONTINUE
               ELSE
                   MOVE    7       TO  SPA-GMN-W26-CUR
                   MOVE    "0003"  TO  SPA-ERRCD
      *
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-JIDO
      *
                   GO  TO  4100-A231-CHK-EXT
               END-IF
           END-IF
      *
           .
       4100-A231-CHK-EXT.
           EXIT.
      *****************************************************************
      *    精神科応急入院施設管理加算チェック処理
      *****************************************************************
       4100-A228-CHK-SEC               SECTION.
      *
           IF  ( SPA-GMN-W26-CHK-SEISIN    =   "T" )
      *        加算可能かチェック
               MOVE    SYS-5001-SEISIN-CD
                                   TO  WRK-SRYCD
               PERFORM 4100-TENSU-SEL-SEC
      *
               MOVE    WRK-NYUKSNKBN
                                   TO  WRK-KSN-NYUKSNKBN
      *
               PERFORM 4100-NYUKSN-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
      *
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-SEISIN
      *
                   MOVE    8       TO  SPA-GMN-W26-CUR
                   GO  TO  4100-A228-CHK-EXT
               END-IF
      *
      *        施設基準をチェック
               IF    ( SYS-1006-SSTKIJUN (031) =   1 )
                   CONTINUE
               ELSE
                   MOVE    8       TO  SPA-GMN-W26-CUR
                   MOVE    "0003"  TO  SPA-ERRCD
      *
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-SEISIN
      *
                   GO  TO  4100-A228-CHK-EXT
               END-IF
           END-IF
      *
           .
       4100-A228-CHK-EXT.
           EXIT.
      *****************************************************************
      *    看護配置加算チェック処理
      *****************************************************************
       4100-A213-CHK-SEC               SECTION.
      *
           IF    ( SPA-GMN-W26-CHK-KANGO (1)   =   "T" )
      *        加算可能かチェック
               MOVE    SYS-5001-KANGO-CD (1)
                                   TO  WRK-SRYCD
               PERFORM 4100-TENSU-SEL-SEC
      *
               MOVE    WRK-NYUKSNKBN
                                   TO  WRK-KSN-NYUKSNKBN
      *
               PERFORM 4100-NYUKSN-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
      *
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-KANGO (1)
      *
                   MOVE    9       TO  SPA-GMN-W26-CUR
                   GO  TO  4100-A213-CHK-EXT
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W26-CHK-KANGO (2)   =   "T" )
      *        加算可能かチェック
               MOVE    SYS-5001-KANGO-CD (2)
                                   TO  WRK-SRYCD
               PERFORM 4100-TENSU-SEL-SEC
      *
               MOVE    WRK-NYUKSNKBN
                                   TO  WRK-KSN-NYUKSNKBN
      *
               PERFORM 4100-NYUKSN-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
      *
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-KANGO (2)
      *
                   MOVE    10      TO  SPA-GMN-W26-CUR
                   GO  TO  4100-A213-CHK-EXT
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W26-CHK-KANGO (3)   =   "T" )
      *        加算可能かチェック
               MOVE    SYS-5001-KANGO-CD (3)
                                   TO  WRK-SRYCD
               PERFORM 4100-TENSU-SEL-SEC
      *
               MOVE    WRK-NYUKSNKBN
                                   TO  WRK-KSN-NYUKSNKBN
      *
               PERFORM 4100-NYUKSN-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
      *
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-KANGO (3)
      *
                   MOVE    11      TO  SPA-GMN-W26-CUR
                   GO  TO  4100-A213-CHK-EXT
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W26-CHK-KANGO (4)   =   "T" )
      *        加算可能かチェック
               MOVE    SYS-5001-KANGO-CD (4)
                                   TO  WRK-SRYCD
               PERFORM 4100-TENSU-SEL-SEC
      *
               MOVE    WRK-NYUKSNKBN
                                   TO  WRK-KSN-NYUKSNKBN
      *
               PERFORM 4100-NYUKSN-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
      *
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-KANGO (4)
      *
                   MOVE    12      TO  SPA-GMN-W26-CUR
                   GO  TO  4100-A213-CHK-EXT
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W26-CHK-KANGO (5)   =   "T" )
      *        加算可能かチェック
               MOVE    SYS-5001-KANGO-CD (5)
                                   TO  WRK-SRYCD
               PERFORM 4100-TENSU-SEL-SEC
      *
               MOVE    WRK-NYUKSNKBN
                                   TO  WRK-KSN-NYUKSNKBN
      *
               PERFORM 4100-NYUKSN-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
      *
                   MOVE    "F"     TO  SPA-GMN-W26-CHK-KANGO (5)
      *
                   MOVE    13      TO  SPA-GMN-W26-CUR
                   GO  TO  4100-A213-CHK-EXT
               END-IF
           END-IF
      *
           .
       4100-A213-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟情報検索処理
      *****************************************************************
       4100-SYS-5001-SEL-SEC           SECTION.
      *
      *    病棟情報検索
           MOVE    "5001"          TO  WRK-KANRICD
           MOVE    SPA-GMN-W26-BTU-NAME-CD
                                   TO  WRK-KBNCD
           MOVE    WRK-STYUKYMD    TO  WRK-KJNYMD
           PERFORM 3101-SYSKANRI-SEL-SEC
           IF    ( FLG-SYSKANRI    =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-5001-REC
           ELSE
               MOVE    SPACE       TO  SYS-5001-REC
           END-IF
      *
           .
       4100-SYS-5001-SEL-EXT.
           EXIT.
      *****************************************************************
      *    病棟入院料加算情報取得処理
      *****************************************************************
       4100-BTU-NYUKSN-GET-SEC         SECTION.
      *
           MOVE    SPACE           TO  WRK-SRYCD
      *
      *    点数マスタ検索
      *
           IF    ( SYS-5001-BTU-KHNSRYCD
                                       =   SPACE )
               PERFORM VARYING IDX2    FROM    1   BY  1
                       UNTIL ( IDX2    >   CONST-BTU-TOKNYUIN-MAX )
                   IF    ( SYS-5001-BTU-TOKTEI-NYUIN
                                       =   CONST-BTU-TOKNYUIN-KBN 
                                                             (IDX2))
                       MOVE    CONST-BTU-TOKNYUIN-CD (IDX2)
                                       TO  WRK-SRYCD
                       MOVE    CONST-BTU-TOKNYUIN-MAX
                                       TO  IDX2
                   END-IF
               END-PERFORM
      *
           ELSE
               MOVE    SYS-5001-BTU-KHNSRYCD
                                   TO  WRK-SRYCD
           END-IF
      *
           PERFORM 4100-TENSU-SEL-SEC
      *
           MOVE    WRK-NYUKSNKBN   TO  WRK-BTU-NYUKSNKBN
           .
      *
       4100-BTU-NYUKSN-GET-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索処理
      *****************************************************************
       4100-TENSU-SEL-SEC              SECTION.
      *
           MOVE    SPACE           TO  WRK-NYUKSNKBN
      *
           MOVE    ZERO            TO  FLG-TENSU
           INITIALIZE              TNS-TENSU-REC
      *
           MOVE    WRK-SRYCD       TO  TNS-SRYCD
           MOVE    WRK-STYUKYMD    TO  ORC-DBYMD
           MOVE    TNS-TENSU-REC   TO  MCPDATA-REC
      *
           MOVE    "TENSU-KEY"     TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        =   ZERO )
               MOVE    MCPDATA-REC TO  TNS-TENSU-REC
           ELSE
               MOVE    1           TO  FLG-TENSU
           END-IF
      *
      *    点数マスタクローズ
           MOVE    "TENSU-KEY"     TO  ORC-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           IF    ( FLG-TENSU       NOT =   ZERO )
               GO  TO  4100-TENSU-SEL-EXT
           END-IF
      *
           MOVE    TNS-NYUKHNKSNKBN
                                   TO  WRK-NYUKSNKBN
           .
      *
       4100-TENSU-SEL-EXT.
           EXIT.
      *****************************************************************
      *    施設基準検索処理
      *****************************************************************
       4100-SYS-1006-SEL-SEC           SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
      *    施設基準情報検索
           INITIALIZE  SYSKANRI-REC
           MOVE    "1006"          TO  SYS-KANRICD
           MOVE    "1"             TO  SYS-KBNCD
           MOVE    WRK-STYUKYMD
                                   TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        NOT =   ZERO )
               MOVE    1           TO  FLG-SYSKANRI
           ELSE
               MOVE    MCPDATA-REC TO  SYS-1006-REC
           END-IF
      *
      *    施設基準情報クローズ
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       4100-SYS-1006-SEL-EXT.
           EXIT.
      *****************************************************************
      *    入力情報領域初期化処理
      *****************************************************************
       4201-INPUT-AREA-CLEAR-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W26-INPUT-AREA
           PERFORM 4201-CHK-BTN-CLEAR-SEC
      *
           MOVE    WIDGET-NORMAL
                               TO  SPA-GMN-W26-STATE
      *
           MOVE    2           TO  SPA-GMN-W26-CUR
      *
           .
      *
       4201-INPUT-AREA-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    チェックボタン初期化処理
      *****************************************************************
       4201-CHK-BTN-CLEAR-SEC       SECTION.
      *
           MOVE   "F"              TO  SPA-GMN-W26-CHK-NANBYO
                                       SPA-GMN-W26-CHK-TOKUSYU
                                       SPA-GMN-W26-CHK-YORYO (1)
                                       SPA-GMN-W26-CHK-YORYO (2)
                                       SPA-GMN-W26-CHK-YORYO (3)
                                       SPA-GMN-W26-CHK-JIDO
                                       SPA-GMN-W26-CHK-SEISIN
                                       SPA-GMN-W26-CHK-KANGO (1)
                                       SPA-GMN-W26-CHK-KANGO (2)
                                       SPA-GMN-W26-CHK-KANGO (3)
                                       SPA-GMN-W26-CHK-KANGO (4)
                                       SPA-GMN-W26-CHK-KANGO (5)
      *
           .
       4201-CHK-BTN-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    病棟名称サーチ処理
      *****************************************************************
       4103-CMB-BTU-NAME-SRH-SEC       SECTION.
      *
           SET     CMB-IDX01       TO  1
           SEARCH  SPA-GMN-W26-BTU-NAME-ITM-OCC
                   VARYING CMB-IDX01
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-ITM2
                                   WRK-CMB-ITM3
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-W26-BTU-NAME-ITM (CMB-IDX01) (1 : 2)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX01
               MOVE    SPA-GMN-W26-BTU-NAME-ITM  (CMB-IDX01)
                                   TO  WRK-CMB-ITM
               MOVE    SPA-GMN-W26-BTU-NAME-ITM2 (CMB-IDX01)
                                   TO  WRK-CMB-ITM2
               MOVE    SPA-GMN-W26-BTU-NAME-ITM3 (CMB-IDX01)
                                   TO  WRK-CMB-ITM3
           WHEN    SPA-GMN-W26-BTU-NAME-ITM (CMB-IDX01)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-ITM2
                                   WRK-CMB-ITM3
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-BTU-NAME-SRH-EXT.
           EXIT.
      *****************************************************************
      *    共通関連チェック
      *****************************************************************
       4900-KANRENCHK-SEC              SECTION.
      *
      *    難病患者等特別入院診療加算と特殊疾患入院施設管理加算
      *    が同時に算定されていないこと
           IF    ( SPA-GMN-W26-CHK-NANBYO          =   "T" )
            AND  ( SPA-GMN-W26-CHK-TOKUSYU         =   "T" )
             MOVE    2             TO  SPA-GMN-W26-CUR
             MOVE    "1001"        TO  SPA-ERRCD
             GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    療養病棟療養環境加算の１２３のいずれかのみ
      *    選択されていること
           INITIALIZE  WRK-SEL-CNT
                       WRK-SEL-IDX
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   3 )
      *
               IF    ( SPA-GMN-W26-CHK-YORYO (IDX1)    =   "T" )
                   COMPUTE WRK-SEL-CNT =   WRK-SEL-CNT +   1
                   MOVE    IDX1        TO  WRK-SEL-IDX
               END-IF
      *
           END-PERFORM
      *
           IF    ( WRK-SEL-CNT     >   1 )
               COMPUTE SPA-GMN-W26-CUR =   WRK-SEL-IDX +   3
               MOVE    "1002"          TO  SPA-ERRCD
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    看護配置加算の１２３４５のいずれかのみ
      *    選択されていること
           INITIALIZE  WRK-SEL-CNT
                       WRK-SEL-IDX
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   5 )
      *
               IF    ( SPA-GMN-W26-CHK-KANGO (IDX1)    =   "T" )
                   COMPUTE WRK-SEL-CNT =   WRK-SEL-CNT +   1
                   MOVE    IDX1        TO  WRK-SEL-IDX
               END-IF
      *
           END-PERFORM
      *
           IF    ( WRK-SEL-CNT     >   1 )
               COMPUTE SPA-GMN-W26-CUR =   WRK-SEL-IDX +   8
               MOVE    "1003"          TO  SPA-ERRCD
               GO  TO  4900-KANRENCHK-EXT
           END-IF
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
           MOVE    "W26    "           TO  MCP-WINDOW.
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
      *    有効開始日
           MOVE    SPA-GMN-W26-STYUKYMD
                                   TO  W26-STYUKYMD
      *    有効終了日
           MOVE    SPA-GMN-W26-EDYUKYMD
                                   TO  W26-EDYUKYMD
      *    病棟名称
           MOVE    SPA-GMN-W26-BTU-NAME
                                   TO  W26-BTU-NAME
           MOVE    SPA-GMN-W26-BTU-NAME-CNT
                                   TO  W26-BTU-NAME-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   SPA-GMN-W26-BTU-NAME-CNT )
               MOVE    SPA-GMN-W26-BTU-NAME-ITM (IDX1)
                                   TO  W26-BTU-NAME-ITM (IDX1)
           END-PERFORM
      *    病棟種別
           MOVE     SPA-GMN-W26-BTU-SBT
                                   TO  W26-BTU-SBT
      *    入院基本料
           MOVE     SPA-GMN-W26-BTU-KHNRYO
                                   TO  W26-BTU-KHNRYO
      *    難病患者等特別入院診療加算
           MOVE     SPA-GMN-W26-CHK-NANBYO
                                   TO  W26-CHK-NANBYO
      *    特殊疾患入院施設管理加算
           MOVE     SPA-GMN-W26-CHK-TOKUSYU
                                   TO  W26-CHK-TOKUSYU
      *    療養病棟療養環境加算
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   3 )
               MOVE    SPA-GMN-W26-CHK-YORYO (IDX1)
                                   TO  W26-CHK-YORYO (IDX1)
           END-PERFORM
      *
      *    児童・思春期精神科入院医療管理加算
           MOVE    SPA-GMN-W26-CHK-JIDO
                                   TO  W26-CHK-JIDO
      *    精神科応急入院施設管理加算
           MOVE    SPA-GMN-W26-CHK-SEISIN
                                   TO  W26-CHK-SEISIN
      *    看護配置加算
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   5 )
               MOVE    SPA-GMN-W26-CHK-KANGO (IDX1)
                                   TO  W26-CHK-KANGO (IDX1)
           END-PERFORM
      *
      *    選択番号
           MOVE    SPA-GMN-W26-SELNUM
                                   TO  W26-SELNUM
      *
      *    有効期間リスト
           MOVE    SPA-GMN-W26-YUKOYMDLST-CNT
                                   TO  W26-YUKOYMDLST-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   SPA-GMN-W26-YUKOYMDLST-CNT )
      *
      *        選択番号
               MOVE    SPA-GMN-W26-TSELNUM (IDX1)
                                   TO  W26-TSELNUM (IDX1)
      *        有効期間開始日
               MOVE    SPA-GMN-W26-TSTYUKYMD (IDX1)
                                   TO  W26-TSTYUKYMD (IDX1)
      *        有効期間終了日
               MOVE    SPA-GMN-W26-TEDYUKYMD (IDX1)
                                   TO  W26-TEDYUKYMD (IDX1)
      *
               IF    ( IDX1    =   SPA-GMN-W26-YUKOYMDLST-SEL )
                   MOVE    "T"     TO  W26-YUKOYMDLST-SELECT (IDX1)
               ELSE
                   MOVE    "F"     TO  W26-YUKOYMDLST-SELECT (IDX1)
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
           MOVE    SPA-GMN-W26-STATE   TO  W26-B12-STATE
                                           W26-CHK-NANBYO-STATE
                                           W26-CHK-TOKUSYU-STATE
                                           W26-CHK-YORYO-STATE (1)
                                           W26-CHK-YORYO-STATE (2)
                                           W26-CHK-YORYO-STATE (3)
                                           W26-CHK-JIDO-STATE
                                           W26-CHK-SEISIN-STATE
                                           W26-CHK-KANGO-STATE (1)
                                           W26-CHK-KANGO-STATE (2)
                                           W26-CHK-KANGO-STATE (3)
                                           W26-CHK-KANGO-STATE (4)
                                           W26-CHK-KANGO-STATE (5)
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
                  (SPA-GMN-W26-CUR     =   ZERO )
               PERFORM 5011-INPUT-CUR-SEC
           END-IF
      *
           IF    ( SPA-GMN-W26-STATE   =   WIDGET-NORMAL )
               CONTINUE
           ELSE
               MOVE    "SELNUM"        TO  MCP-WIDGET
               GO  TO  5001-MAPCUR-EXT
           END-IF
      *
           EVALUATE    SPA-GMN-W26-CUR
           WHEN    001
               MOVE    "BTU_NAME"      TO  MCP-WIDGET
           WHEN    002
               MOVE    "CHK_NANBYO"    TO  MCP-WIDGET
           WHEN    003
               MOVE    "CHK_TOKUSYU"   TO  MCP-WIDGET
           WHEN    004
               MOVE    "CHK_YORYO1"    TO  MCP-WIDGET
           WHEN    005
               MOVE    "CHK_YORYO2"    TO  MCP-WIDGET
           WHEN    006
               MOVE    "CHK_YORYO3"    TO  MCP-WIDGET
           WHEN    007
               MOVE    "CHK_JIDO"      TO  MCP-WIDGET
           WHEN    008
               MOVE    "CHK_SEISIN"    TO  MCP-WIDGET
           WHEN    009
               MOVE    "CHK_KANGO1"    TO  MCP-WIDGET
           WHEN    010
               MOVE    "CHK_KANGO2"    TO  MCP-WIDGET
           WHEN    011
               MOVE    "CHK_KANGO3"    TO  MCP-WIDGET
           WHEN    012
               MOVE    "CHK_KANGO4"    TO  MCP-WIDGET
           WHEN    013
               MOVE    "CHK_KANGO5"    TO  MCP-WIDGET
           WHEN    100
               MOVE    "SELNUM"        TO  MCP-WIDGET
           WHEN    212
               MOVE    "B12"           TO  MCP-WIDGET
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
           WHEN    "BTU_NAME"
               MOVE    001             TO  SPA-GMN-W26-CUR
           WHEN    "CHK_NANBYO"
               MOVE    002             TO  SPA-GMN-W26-CUR
           WHEN    "CHK_TOKUSYU"
               MOVE    003             TO  SPA-GMN-W26-CUR
           WHEN    "CHK_YORYO1"
               MOVE    004             TO  SPA-GMN-W26-CUR
           WHEN    "CHK_YORYO2"
               MOVE    005             TO  SPA-GMN-W26-CUR
           WHEN    "CHK_YORYO3"
               MOVE    006             TO  SPA-GMN-W26-CUR
           WHEN    "CHK_JIDO"
               MOVE    007             TO  SPA-GMN-W26-CUR
           WHEN    "CHK_SEISIN"
               MOVE    008             TO  SPA-GMN-W26-CUR
           WHEN    "CHK_KANGO1"
               MOVE    009             TO  SPA-GMN-W26-CUR
           WHEN    "CHK_KANGO2"
               MOVE    010             TO  SPA-GMN-W26-CUR
           WHEN    "CHK_KANGO3"
               MOVE    011             TO  SPA-GMN-W26-CUR
           WHEN    "CHK_KANGO4"
               MOVE    012             TO  SPA-GMN-W26-CUR
           WHEN    "CHK_KANGO5"
               MOVE    013             TO  SPA-GMN-W26-CUR
           END-EVALUATE
      *
      *    次カーソル位置を設定
           EVALUATE    MCP-WIDGET
           WHEN    "CHK_KANGO5"
               MOVE    212             TO  SPA-GMN-W26-CUR
           WHEN    OTHER
               COMPUTE SPA-GMN-W26-CUR =   SPA-GMN-W26-CUR
                                           +   1
           END-EVALUATE
      *
           .
      *
       5011-INPUT-CUR-EXT.
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
                   MOVE    "入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0002"
               MOVE    "病棟名称を選択してください"
                                       TO  SPA-ERRMSG
           WHEN    "0003"
               MOVE    "加算に必要な施設基準が設定されていません"
                                       TO  SPA-ERRMSG
           WHEN    "0004"
               MOVE    "病棟加算情報の取得に失敗しました"
                                       TO  SPA-ERRMSG
           WHEN    "0005"
               MOVE    "当該入院料において、この加算は算定できません"
                                       TO  SPA-ERRMSG
           WHEN    "0006"
               MOVE    "選択番号を入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "1001"
               MOVE    "難病患者等特別入院と特殊疾患入院は同時に"
                                       TO  SPA-ERRMSG (1 : 40)
               MOVE    "加算できません"
                                       TO  SPA-ERRMSG (41 : )
           WHEN    "1002"
               MOVE    "療養病棟療養環境加算はいずれか１つのみ選"
                                       TO  SPA-ERRMSG (1 : 40)
               MOVE    "択してください"
                                       TO  SPA-ERRMSG (41 : )
           WHEN    "1003"
               MOVE    "看護配置加算はいずれか１つのみ選択してく"
                                       TO  SPA-ERRMSG (1 : 40)
               MOVE    "ださい"        TO  SPA-ERRMSG (41 : )
           WHEN    "1201"
               MOVE    "更新できませんでした"
                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  WERR
           MOVE    SPA-ERRCD           TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  WERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "W26"               TO  SPA-MOTOPG
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
               MOVE    "登録処理をします"
                                        TO  WRK-WIDMSG
           END-EVALUATE
      *
      *
           MOVE    SPACE                TO  WID1
           MOVE    SPA-WIDCD            TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG           TO  WID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "W26"                TO  SPA-MOTOPG
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
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC             SECTION.
      *
           IF    ( WRK-YMD         =   "00000000" 
                                   OR  "99999999" )
               MOVE    WRK-YMD     TO  WRK-HENYMDG
                                       WRK-SYMD
               GO  TO  5002-HIZUKE-CHK-EXT
           END-IF
      *
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    WRK-YMD             TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
           IF  ( SGDAY-RC              =   ZERO )
               MOVE    SGDAY-OTDAY     TO  WRK-HENYMDG
               MOVE    SGDAY-SDAY      TO  WRK-SYMD
           ELSE
               MOVE    "0001"          TO  SPA-ERRCD
           END-IF
           .
       5002-HIZUKE-CHK-EXT.
           EXIT.
      *****************************************************************
      *    全角半角混在チェック
      *****************************************************************
       800-ENRTRY-CHK-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-ENTRYCHK
      *
           IF  ( WRK-KANACHK-MAE-INPUT
                                   =   SPACE )
               GO  TO  800-ENRTRY-CHK-EXT
           END-IF
      *
           MOVE    SPACE           TO  ORCSKANACHKAREA
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"             TO  KANACHK-SYORI
           MOVE    WRK-KANACHK-MAE-INPUT
                                   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      ( KANACHK-RC    NOT =   ZERO )
               MOVE    1           TO  FLG-ENTRYCHK
               GO  TO  800-ENRTRY-CHK-EXT
           END-IF
      *
      *    全角でない場合はエラーとする。
           IF      ( KANACHK-SYUBETU   NOT =   2 )
               MOVE    1           TO  FLG-ENTRYCHK
           END-IF
      *
           .
       800-ENRTRY-CHK-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       900-TBL-SELECT-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           PERFORM 910-DB-SELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    WRK-DBPATH  TO  ORC-DBPATH
               PERFORM 910-DB-READ-SEC
               IF    ( MCP-RC          =   ZERO )
                   CONTINUE
               ELSE
                   MOVE    1       TO  FLG-DBRC
               END-IF
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル読込処理
      *****************************************************************
       900-TBL-READ-SEC                SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           PERFORM 910-DB-READ-SEC
           IF    ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-READ-EXT.
           EXIT.
      *****************************************************************
      *    テーブル更新処理
      *****************************************************************
       900-TBL-UPDATE-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           PERFORM 910-DB-UPDATE-SEC
           IF    ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-UPDATE-EXT.
           EXIT.
      *****************************************************************
      *    テーブル追加処理
      *****************************************************************
       900-TBL-INSERT-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           PERFORM 910-DB-INSERT-SEC
           IF    ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-INSERT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル削除処理
      *****************************************************************
       900-TBL-DELETE-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           PERFORM 910-DB-DELETE-SEC
           IF    ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-DELETE-EXT.
           EXIT.
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       900-TBL-CLOSE-SEC               SECTION.
      *
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           PERFORM 910-DB-CLOSE-SEC
      *
           .
       900-TBL-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ削除処理
      *****************************************************************
       910-DB-DELETE-SEC               SECTION.
      *
           MOVE    "DBDELETE"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DB-UPDATE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ更新処理
      *****************************************************************
       910-DB-UPDATE-SEC               SECTION.
      *
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DB-UPDATE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ追加処理
      *****************************************************************
       910-DB-INSERT-SEC               SECTION.
      *
           MOVE    "DBINSERT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DB-INSERT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       910-DB-SELECT-SEC               SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
      *
       910-DB-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DB-READ-SEC                 SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DB-READ-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DB-CLOSE-SEC                SECTION.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
      *
       910-DB-CLOSE-EXT.
           EXIT.
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

