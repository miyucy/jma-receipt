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
       PROGRAM-ID.                               ORCGW20.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : 病棟管理
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/07/30    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 00.00.01     NACL−太田   02/11/29  有効開始日を基準にシス管の
      *                                     情報を取得するよう修正
      *                                     病棟科を最大９９件に変更
      * 00.00.02     NACL−太田   03/01/29  有効開始日のチェック追加
      * 01.00.01     NACL-太田    03.11.17  更新日付編集対応
      * 02.08.00     NACL-太田    06.03.09  平成１８年度改正対応
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
           COPY    "W20SCR-SPA".
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-SYSKANRI                        PIC 9(01).
           03  FLG-ENTRYCHK                        PIC 9(01).
           03  FLG-BTU-NUM                         PIC 9(01).
           03  FLG-KIKAN-DABURI                    PIC 9(01).
           03  FLG-UPD-KBN                         PIC 9(01).
           03  FLG-BRM-SONZAI                      PIC 9(01).
           03  FLG-TENSU                           PIC 9(01).
           03  FLG-NYUKHN                          PIC 9(01).
           03  FLG-SYS5001                         PIC 9(01).
           03  FLG-HIZUKE-ERR                      PIC 9(01).
           03  FLG-SETKHNRYO                       PIC 9(01).
           03  FLG-BTULST-ROW                      PIC 9(01).

      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                                PIC 9(05).
           03  IDX2                                PIC 9(05).
           03  IDX3                                PIC 9(05).
           03  IDX4                                PIC 9(05).
           03  IDX-CMB                             PIC 9(05).
           03  IDX-MAX                             PIC 9(05).
           03  IDX-LST                             PIC 9(05).
           03  IDX-BTULST                          PIC 9(05).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-STR                             PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-WIDMSG                          PIC X(70). 
           03  WRK-MAX                             PIC 9(05).
           03  WRK-YMD                             PIC X(10). 
           03  WRK-SYMD.
               05  WRK-SYY                         PIC 9(04).
               05  WRK-SMM                         PIC 9(02).
               05  WRK-SDD                         PIC 9(02).
           03  WRK-HENYMDG                         PIC X(09).
           03  WRK-KANACHK-MAE-INPUT               PIC X(400).
           03  WRK-KANACHK-OUT-INPUT               PIC X(400).
           03  WRK-BTUNUM                          PIC 9(02).
           03  WRK-ZZZ9                            PIC ZZZ9.
           03  WRK-ZZZZZZZZZ9                      PIC Z(09)9.
           03  WRK-CMB-CD                          PIC X(10).
           03  WRK-CMB-ITM-G.
               05  WRK-CMB-ITM                     PIC X(200).
               05  WRK-CMB-ITM2                    PIC X(200).
               05  WRK-CMB-ITM3                    PIC X(200).
           03  WRK-KIJUN-YMD                       PIC X(08).
           03  WRK-BTU-NINZU                       PIC 9(05).
           03  WRK-BTULST                          PIC 9(05).
           03  WRK-TNS-NAME                        PIC X(30).
           03  WRK-EDYUKYMD                        PIC X(08).
           03  WRK-CDKBNNUM                        PIC 9(03).
           03  WRK-CDKOUBAN                        PIC 9(02).
           03  WRK-TK-CDKBNNUM                     PIC 9(03).
           03  WRK-TK-CDKOUBAN                     PIC 9(02).
           03  WRK-TNS-SRYCD                       PIC X(09).
           03  WRK-TNS-KJNYMD                      PIC X(08).
           03  WRK-99                              PIC 9(02).
           03  WRK-BTULST-SEL                      PIC 9(02).
           03  WRK-STATE                           PIC S9(9) BINARY.
      *    入力項目名
           03  WRK-MCP-WIDGET                      PIC X(64).
           03  WRK-YUKOSTYMD                       PIC X(08).
           03  WRK-YUKOEDYMD                       PIC X(08).
           03  WRK-KJN-YUKSTYMD                    PIC X(08).
           03  WRK-PATHNAME                        PIC X(64).
      *
       01  WRK-ROW.
           03  WRK-BTULST-ROW                      PIC S9(9)   BINARY.
      *
      *    固定値領域
       01  CONST-AREA.
           03  CONST-BTULST-MAX        PIC 9(03) VALUE 50.
           03  CONST-RIREKILST-MAX     PIC 9(03) VALUE 20.
           03  CONST-TOKNYUIN-MAX      PIC 9(03) VALUE 15.
           03  CONST-SRYKA-MAX         PIC 9(03) VALUE 99.
           03  CONST-SBT-MAX           PIC 9(03) VALUE 15.
           03  CONST-KNGHJOKSN-MAX     PIC 9(03) VALUE 10.
           03  CONST-YKNKNGKSN-MAX     PIC 9(03) VALUE 10.
           03  CONST-KHNRYO-MAX        PIC 9(03) VALUE 50.
           03  CONST-NANBYO            PIC X(09) VALUE "190101770".
           03  CONST-TOKUSYUCD         PIC X(09) VALUE "190101970".
           03  CONST-YORYOCD-VAL.
               05                      PIC X(09) VALUE "190106070".
               05                      PIC X(09) VALUE "190106170".
               05                      PIC X(09) VALUE "190106270".
           03  CONST-YORYOCD-R     REDEFINES   CONST-YORYOCD-VAL.
               05  CONST-YORYOCD       PIC X(09) OCCURS 3.
           03  CONST-JIDOCD            PIC X(09) VALUE "190110170".
           03  CONST-SEISINCD          PIC X(09) VALUE "190106970".
           03  CONST-KANGOCD-VAL.
               05                      PIC X(09) VALUE "190102070".
               05                      PIC X(09) VALUE "190102170".
               05                      PIC X(09) VALUE "190102270".
               05                      PIC X(09) VALUE "190102370".
               05                      PIC X(09) VALUE "190102470".
           03  CONST-KANGOCD-R         REDEFINES   CONST-KANGOCD-VAL.
               05  CONST-KANGOCD       PIC X(09) OCCURS 5.
           03  CONST-KNGTEKCD          PIC X(09) VALUE "190109670".
           03  CONST-DRTEKCD           PIC X(09) VALUE "190117070".
           03  CONST-H180401           PIC X(08) VALUE "20060401".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY  "CPSYSKANRI.INC".
      *    病棟管理
           COPY  "CPSK5001.INC".
      *    病室管理
           COPY  "CPSK5002.INC".
      *    医療機関情報
           COPY  "CPSK1001.INC".
      *    施設基準
           COPY  "CPSK1006.INC".
      *    診療科コード
           COPY  "CPSK1005.INC".
      *    病棟種別
           COPY  "CPSK5101.INC".
      *    平均在院日数
           COPY  "CPSK5102.INC".
      *    看護配置
           COPY  "CPSK5103.INC".
      *    看護師比率
           COPY  "CPSK5104.INC".
      *    看護補助加算
           COPY  "CPSK5105.INC".
      *    夜間勤務等看護加算
           COPY  "CPSK5106.INC".
      *    特定入院料（病棟）
           COPY  "CPSK5110.INC".
      *    看護補助配置
           COPY  "CPSK5115.INC".
      *
      *    入院料算定マスタ
      *01  NYUINKHN-REC.
      *    COPY  "CPNYUINKHN.INC".
      *    点数マスタ
           COPY  "CPTENSU.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *
      *    入院基本料算定サブ
           COPY  "CPW20SUB01.INC".
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
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
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
           COPY    "W60.INC".
           COPY    "W61.INC".
           COPY    "W98.INC".
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
           INITIALIZE                  CNT-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-W01KYOUTU
           MOVE    SPA-FREE        TO  SPA-W20FREE
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
           WHEN        "LINK"          ALSO    ANY
               PERFORM 100-INIT-SEC
      *    画面遷移
           WHEN     "PUTG"             ALSO   "CLICKED"
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
           MOVE    SPA-W20FREE     TO  SPA-FREE
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
               MOVE    SPA-GMN-W20-MOTOPG
                                       TO  SPA-MOTOPG
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
           MOVE    "W20    "           TO  MCP-WINDOW.
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
               MOVE    LNK-KYOUTU      TO  SPA-KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG
           WHEN    "W21"
               IF    ( SPA-MOTOPG2     =   "W20" )
                   MOVE    "W01"       TO  SPA-MOTOPG
                   MOVE    SPACE       TO  SPA-MOTOPG2
                                           SPA-MOTOPG3
      *            病棟リストを再編集する
                   MOVE    SPA-GMN-W20-BTULST-SEL
                                       TO  WRK-BTULST-SEL
                   PERFORM 3101-EDIT-BTULST-SEC 
                   MOVE    WRK-BTULST-SEL
                                       TO  SPA-GMN-W20-BTULST-SEL
                   GO  TO  300-SCREEN-EXT
               ELSE
                   PERFORM 310-SPASET-SEC
      *            病棟情報設定処理
                   PERFORM 310-BTU-SET-SEC
                   GO  TO  300-SCREEN-EXT
               END-IF
           WHEN    "WID1"
               MOVE    SPA-GMN-W20-MOTOPG
                                       TO  SPA-MOTOPG
               PERFORM 330-WID1-SET-SEC
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
           INITIALIZE                  SPA-W20-AREA
      *
      *    医療機関情報取得処理
           MOVE    SPA-SYSYMD      TO  WRK-KJN-YUKSTYMD
           PERFORM 3101-GET-SYS1001-SEC
      *
      *    コンボ初期処理
           MOVE    SPA-SYSYMD      TO  WRK-KJN-YUKSTYMD
           PERFORM 3101-CMB-SYOKI-SEC
      *
           MOVE    SPA-GMN-W20-EDKBNLST (1)
                                   TO  SPA-GMN-W20-EDKBN-G
      *
      *    病棟管理情報（病棟リストに表示）
           PERFORM 3101-EDIT-BTULST-SEC
      *
      *    入力情報領域初期化処理
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    病棟情報設定処理（病室画面より遷移時）
      *****************************************************************
       310-BTU-SET-SEC                 SECTION.
      *
           MOVE    1               TO  SPA-GMN-W20-CUR
      *
      *    入力項目領域編集処理
           MOVE    SPA-W20-W21-BTU-NUM
                                   TO  WRK-BTUNUM 
           MOVE    SPA-SYSYMD      TO  WRK-KIJUN-YMD
      *
      *    画面初期化
           PERFORM 420-CLEAR-SEC
      *
           PERFORM 4100-INPUT-AREA-EDIT-SEC
           IF    ( FLG-SYS5001     =   ZERO )
      *
               PERFORM 4100-BTUNUM-LSTSEL-SEC
               MOVE    IDX-BTULST  TO  SPA-GMN-W20-BTULST-SEL
      *
      *        履歴データ編集処理
               PERFORM 4100-RIREKI-AREA-EDIT-SEC
      *
               MOVE    2           TO  SPA-GMN-W20-CUR
      *
           END-IF
      *
           .
       310-BTU-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    コンボ初期処理
      *****************************************************************
       3101-CMB-SYOKI-SEC          SECTION.
      *
           INITIALIZE  SPA-GMN-W20-CMB-DAT-AREA
      *
      *    特定入院料取得処理
           PERFORM 3101-GET-SYS5110-SEC
      *
      *    病棟科名取得処理
           PERFORM 3101-GET-SYS1005-SEC
      *
      *    病棟種別取得処理
           PERFORM 3101-GET-SYS5101-SEC
      *
      *    看護補助加算取得処理
           PERFORM 3101-GET-SYS5105-SEC
      *
      *    夜間勤務等看護加算取得処理
           PERFORM 3101-GET-SYS5106-SEC
      *
      *    レセプト表示区分
           PERFORM 3101-RECEDSPKBN-GET-SEC
      *
      *    終了区分
           MOVE    2       TO  SPA-GMN-W20-EDKBN-MAX
           MOVE    "1"     TO  SPA-GMN-W20-EDKBNL    (1)
           MOVE    "継続"  TO  SPA-GMN-W20-EDKBNMEIL (1)
           MOVE    "2"     TO  SPA-GMN-W20-EDKBNL    (2)
           MOVE    "廃止"  TO  SPA-GMN-W20-EDKBNMEIL (2)
      *
      *    入院基本料コンボ編集処理
           PERFORM 4100-KHNRYO-CMB-EDT-SEC
      *
           .
       3101-CMB-SYOKI-EXT.
           EXIT.
      *
      *****************************************************************
      *    医療機関情報取得処理
      *****************************************************************
       3101-GET-SYS1001-SEC            SECTION.
      *
           INITIALIZE                  SYSKANRI-REC
           MOVE    "1001"          TO  SYS-KANRICD
           MOVE    "*"             TO  SYS-KBNCD
           MOVE    WRK-KJN-YUKSTYMD    TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           MOVE    SYSKANRI-REC    TO  SYS-1001-REC
           MOVE    SYS-1001-HOSPSBT
                                   TO  SPA-NAI-W20-HOSPSBT
      *
           .
       3101-GET-SYS1001-EXT.
           EXIT.
      *****************************************************************
      *    特定入院料取得処理
      *****************************************************************
       3101-GET-SYS5110-SEC            SECTION.
      *
           INITIALIZE                  SYSKANRI-REC
           MOVE    "5110"          TO  SYS-KANRICD
           MOVE    WRK-KJN-YUKSTYMD    TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY2-SEL-SEC
      *
           MOVE    ZERO            TO  IDX-CMB
           PERFORM UNTIL ( FLG-SYSKANRI    =   1 )
                    OR   ( IDX-CMB        >=   CONST-TOKNYUIN-MAX )
      *
               COMPUTE IDX-CMB =   IDX-CMB +   1
               MOVE    IDX-CMB         TO  SPA-GMN-W20-TOKNYUIN-MAX
      *
               MOVE    SYSKANRI-REC    TO  SYS-5110-REC
      *
               MOVE    SYS-5110-KBNCD
                           TO  SPA-GMN-W20-TOKNYUINL   (IDX-CMB)
               MOVE    SYS-5110-BTU-TOKUTEINYUIN-NM
                           TO  SPA-GMN-W20-TOKNYUINMEIL
                                                       (IDX-CMB)
               MOVE    SYS-5110-BTU-TOKUTEINYUIN-NM2
                           TO  SPA-NAI-W20-TOKNYUINLST (IDX-CMB)
      *
               PERFORM 900-SYSKANRI-KEY2-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       3101-GET-SYS5110-EXT.
           EXIT.
      *****************************************************************
      *    診療科コード取得処理
      *****************************************************************
       3101-GET-SYS1005-SEC            SECTION.
      *
           INITIALIZE                  SYSKANRI-REC
           MOVE    "1005"          TO  SYS-KANRICD
           MOVE    WRK-KJN-YUKSTYMD    TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY2-SEL-SEC
      *
           MOVE    ZERO            TO  IDX-CMB
           PERFORM UNTIL ( FLG-SYSKANRI    =   1 )
                    OR   ( IDX-CMB        >=   CONST-SRYKA-MAX )
      *
               COMPUTE IDX-CMB =   IDX-CMB +   1
               MOVE    IDX-CMB         TO  SPA-GMN-W20-SRYKA-MAX
      *
               MOVE    SYSKANRI-REC    TO  SYS-1005-REC
      *
               MOVE    SYS-1005-KBNCD
                           TO  SPA-GMN-W20-SRYKAL   (IDX-CMB)
               MOVE    SYS-1005-SRYKANAME
                           TO  SPA-GMN-W20-SRYKAMEIL(IDX-CMB)
      *
               PERFORM 900-SYSKANRI-KEY2-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       3101-GET-SYS1005-EXT.
           EXIT.
      *****************************************************************
      *    病棟種別取得処理
      *****************************************************************
       3101-GET-SYS5101-SEC            SECTION.
      *
           INITIALIZE                  SYSKANRI-REC
           MOVE    "5101"          TO  SYS-KANRICD
           MOVE    WRK-KJN-YUKSTYMD    TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY2-SEL-SEC
      *
           MOVE    ZERO            TO  IDX-CMB
           PERFORM UNTIL ( FLG-SYSKANRI    =   1 )
                    OR   ( IDX-CMB        >=   CONST-SBT-MAX )
      *
               COMPUTE IDX-CMB =   IDX-CMB +   1
               MOVE    IDX-CMB         TO  SPA-GMN-W20-SBT-MAX
      *
               MOVE    SYSKANRI-REC    TO  SYS-5101-REC
      *
               MOVE    SYS-5101-KBNCD
                           TO  SPA-GMN-W20-SBTL   (IDX-CMB)
               MOVE    SYS-5101-BTU-SBT-NM
                           TO  SPA-GMN-W20-SBTMEIL(IDX-CMB)
      *
               PERFORM 900-SYSKANRI-KEY2-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       3101-GET-SYS5101-EXT.
           EXIT.
      *****************************************************************
      *    看護補助加算取得処理
      *****************************************************************
       3101-GET-SYS5105-SEC        SECTION.
      *
           INITIALIZE                  SYSKANRI-REC
           MOVE    "5105"          TO  SYS-KANRICD
           MOVE    WRK-KJN-YUKSTYMD    TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY2-SEL-SEC
      *
           MOVE    ZERO            TO  IDX-CMB
           PERFORM UNTIL ( FLG-SYSKANRI    =   1 )
                    OR   ( IDX-CMB        >=   CONST-KNGHJOKSN-MAX )
      *
               COMPUTE IDX-CMB =   IDX-CMB +   1
               MOVE    IDX-CMB         TO  SPA-GMN-W20-KNGHJOKSN-MAX
      *
               MOVE    SYSKANRI-REC    TO  SYS-5105-REC
      *
               MOVE    SYS-5105-KBNCD
                           TO  SPA-GMN-W20-KNGHJOKSNL   (IDX-CMB)
               MOVE    SYS-5105-BTU-KNGHJOKSN-NM
                           TO  SPA-GMN-W20-KNGHJOKSNMEIL(IDX-CMB)
      *
               PERFORM 900-SYSKANRI-KEY2-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       3101-GET-SYS5105-EXT.
           EXIT.
      *****************************************************************
      *    夜間勤務等看護加算取得処理
      *****************************************************************
       3101-GET-SYS5106-SEC        SECTION.
      *
           INITIALIZE                  SYSKANRI-REC
           MOVE    "5106"          TO  SYS-KANRICD
           MOVE    WRK-KJN-YUKSTYMD    TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY2-SEL-SEC
      *
           MOVE    ZERO            TO  IDX-CMB
           PERFORM UNTIL ( FLG-SYSKANRI    =   1 )
                    OR   ( IDX-CMB        >=   CONST-YKNKNGKSN-MAX )
      *
               COMPUTE IDX-CMB =   IDX-CMB +   1
               MOVE    IDX-CMB         TO  SPA-GMN-W20-YKNKNGKSN-MAX
      *
               MOVE    SYSKANRI-REC    TO  SYS-5106-REC
      *
               MOVE    SYS-5106-KBNCD
                           TO  SPA-GMN-W20-YKNKNGKSNL   (IDX-CMB)
               MOVE    SYS-5106-BTU-YAKANKNGKSN-NM
                           TO  SPA-GMN-W20-YKNKNGKSNMEIL(IDX-CMB)
      *
               PERFORM 900-SYSKANRI-KEY2-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       3101-GET-SYS5106-EXT.
           EXIT.
      *****************************************************************
      *    病棟管理情報検索処理
      *****************************************************************
       3101-EDIT-BTULST-SEC        SECTION.
      *
      *    システム日付の内容でコンボを再編集
           MOVE    SPA-SYSYMD      TO  WRK-KJN-YUKSTYMD
           PERFORM 3101-CMB-SYOKI-SEC
      *
           INITIALIZE                  SPA-GMN-W20-BTULST
      *
           INITIALIZE                  SYSKANRI-REC
           MOVE    "5001"          TO  SYS-KANRICD
           MOVE    SPA-SYSYMD      TO  SYS-STYUKYMD
                                       SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY7-SEL-SEC
      *
           MOVE    ZERO            TO  IDX-LST
           PERFORM UNTIL ( FLG-SYSKANRI    =   1 )
                    OR   ( IDX-LST        >=   CONST-BTULST-MAX )
      *
               COMPUTE IDX-LST =   IDX-LST +   1
               MOVE    IDX-LST TO  SPA-GMN-W20-BTULST-MAX
      *
               MOVE    SYSKANRI-REC    TO  SYS-5001-REC
      *
      *        病棟リスト編集
               PERFORM 31011-EDIT-BTULST-SEC
      *
               PERFORM 900-SYSKANRI-KEY7-FET-SEC
      *
           END-PERFORM
      *
      **   収容人数設定処理
           PERFORM 31011-GET-BTU-NINZU-SEC
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key7"          TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           MOVE    1               TO  FLG-BTULST-ROW
      *
           .
       3101-EDIT-BTULST-EXT.
           EXIT.
      *****************************************************************
      *    レセプト表示区分取得処理
      *****************************************************************
       3101-RECEDSPKBN-GET-SEC         SECTION.
      *
           INITIALIZE  SPA-GMN-W20-RECEDSPKBNLST-G
                       SPA-NAI-W20-RECEDSPKBNLST-G
      *
           MOVE    "01"    TO  SPA-GMN-W20-RECEDSPKBNL (1)
           MOVE    "02"    TO  SPA-GMN-W20-RECEDSPKBNL (2)
           MOVE    "03"    TO  SPA-GMN-W20-RECEDSPKBNL (3)
           MOVE    "05"    TO  SPA-GMN-W20-RECEDSPKBNL (4)
           MOVE    "07"    TO  SPA-GMN-W20-RECEDSPKBNL (5)
           MOVE    "08"    TO  SPA-GMN-W20-RECEDSPKBNL (6)
           MOVE    "09"    TO  SPA-GMN-W20-RECEDSPKBNL (7)
      *
           MOVE    "精神"  TO  SPA-GMN-W20-RECEDSPKBNMEIL(1)
           MOVE    "結核"  TO  SPA-GMN-W20-RECEDSPKBNMEIL(2)
           MOVE    "特例"  TO  SPA-GMN-W20-RECEDSPKBNMEIL(3)
           MOVE    "老人"  TO  SPA-GMN-W20-RECEDSPKBNMEIL(4)
           MOVE    "療養"  TO  SPA-GMN-W20-RECEDSPKBNMEIL(5)
           MOVE    "複合"  TO  SPA-GMN-W20-RECEDSPKBNMEIL(6)
           MOVE    "複療"  TO  SPA-GMN-W20-RECEDSPKBNMEIL(7)
      *
           MOVE    "02"        TO  SPA-NAI-W20-RECEDSPKBNLST (1)
           MOVE    "03"        TO  SPA-NAI-W20-RECEDSPKBNLST (2)
           MOVE    "**"        TO  SPA-NAI-W20-RECEDSPKBNLST (3)
           MOVE    "07"        TO  SPA-NAI-W20-RECEDSPKBNLST (4)
           MOVE    "04"        TO  SPA-NAI-W20-RECEDSPKBNLST (5)
           MOVE    "**"        TO  SPA-NAI-W20-RECEDSPKBNLST (6)
           MOVE    "**"        TO  SPA-NAI-W20-RECEDSPKBNLST (7)
      *
           MOVE    7           TO  SPA-GMN-W20-RECEDSPKBN-MAX
      *
           .
       3101-RECEDSPKBN-GET-EXT.
           EXIT.
      *****************************************************************
      *    病棟リスト編集処理
      *****************************************************************
       31011-EDIT-BTULST-SEC           SECTION.
      *
      *    病棟番号
           MOVE    SYS-5001-BTU-NUM
                           TO  SPA-GMN-W20-TBTUNUM (IDX-LST)
      *    病棟名称
           MOVE    SYS-5001-BTU-NAME
                           TO  SPA-GMN-W20-TNAME (IDX-LST)
      *    短縮病棟名称
           MOVE    SYS-5001-BTU-TANNAME
                           TO  SPA-GMN-W20-TTANNAME (IDX-LST)
      *
      **   病棟種別
           MOVE    SYS-5001-BTU-SBT    TO  WRK-CMB-CD
           PERFORM 4200-SBTLST-CHK-SEC
           MOVE    WRK-CMB-ITM (4:)
                           TO  SPA-GMN-W20-TSBT (IDX-LST)
      *
      *    特定入院料
           MOVE    SYS-5001-BTU-TOKTEI-NYUIN
                                       TO  WRK-CMB-CD
           PERFORM 4200-TOKNYUINLST-CHK-SEC
           MOVE    WRK-CMB-ITM2
                           TO  SPA-GMN-W20-TTOKNYUIN (IDX-LST)
      *
      *    病棟科名
           MOVE    SYS-5001-BTU-KA     TO  WRK-CMB-CD
           PERFORM 4200-SRYKALST-CHK-SEC
           MOVE    WRK-CMB-ITM (4:)
                           TO  SPA-GMN-W20-TSRYKA (IDX-LST)
      *
           MOVE    SYS-5001-BTU-KHNSRYCD
                           TO  SPA-GMN-W20-TKHNSRYCD (IDX-LST)
      *
      *    入院基本点数をサブプロより取得する
           INITIALIZE                      W20SUB01-LNK
           MOVE    "1"                 TO  W20SUB01-I-KBN
           MOVE    SYS-5001-BTU-KHNSRYCD
                                       TO  W20SUB01-I-KHNSRYCD
           MOVE    SYS-5001-STYUKYMD   TO  W20SUB01-I-KJNYMD
      *
           CALL    "ORCGW20SUB01"      USING
                                       W20SUB01-LNK
           IF    ( W20SUB01-O-RC   =   ZERO )
               MOVE    W20SUB01-O-NAME
                                   TO  SPA-GMN-W20-TKHNRYO (IDX-LST)
               MOVE    W20SUB01-O-KHNTEN
                                   TO  SPA-GMN-W20-TKHNTEN (IDX-LST)
           END-IF
      *
      *    有効開始日
           MOVE    SYS-5001-STYUKYMD   TO  WRK-YMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  SPA-GMN-W20-TYUKOSTYMD
                                                           (IDX-LST)
      *
      *    有効終了日
           MOVE    SYS-5001-EDYUKYMD   TO  WRK-YMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  SPA-GMN-W20-TYUKOEDYMD
                                                           (IDX-LST)
      *
           .
       31011-EDIT-BTULST-EXT.
           EXIT.
      *****************************************************************
      *    病棟人数取得処理
      *****************************************************************
       31011-GET-BTU-NINZU-SEC     SECTION.
      *
           PERFORM VARYING IDX-LST FROM    1   BY  1
                   UNTIL ( IDX-LST  >  SPA-GMN-W20-BTULST-MAX )
      *
               INITIALIZE                  WRK-BTU-NINZU
      *
               INITIALIZE                  SYSKANRI-REC
               MOVE    "5002"          TO  SYS-KANRICD
               MOVE    SPA-GMN-W20-TBTUNUM (IDX-LST)
                                       TO  SYS-KBNCD
               MOVE    "%"             TO  SYS-KBNCD(3:1)
               MOVE    SPA-SYSYMD      TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
               PERFORM 900-SYSKANRI-KEY-SEL-SEC
      *
               PERFORM UNTIL ( FLG-SYSKANRI    =   1 )
      *
                   MOVE    SYSKANRI-REC
                                       TO  SYS-5002-REC
      *
                   COMPUTE WRK-BTU-NINZU
                       =   WRK-BTU-NINZU   +   SYS-5002-BRM-NINZU
      *
                   PERFORM 900-SYSKANRI-KEY-FET-SEC
      *
               END-PERFORM
      *
               MOVE    "tbl_syskanri"  TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               PERFORM 910-DBCLOSECURSOR-SEC
      *
               MOVE    WRK-BTU-NINZU
                                   TO  SPA-GMN-W20-TNINZU (IDX-LST)
      *
            END-PERFORM
      *
           .
       31011-GET-BTU-NINZU-EXT.
           EXIT.
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-WID1-SET-SEC            SECTION.
      *
           IF    ( SPA-WID1-FLG    =   "OK" )
               EVALUATE    SPA-WIDCD
               WHEN "2001"
                       PERFORM 421-SAKUJO-SEC
               END-EVALUATE
           END-IF
      *
           MOVE    SPACE           TO  SPA-WID1-FLG
           MOVE    SPACE           TO  SPA-WIDCD      
      *
           .
       330-WID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                           SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
      *
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *    戻る
           WHEN    "CLICKED"       ALSO    "B01"
               MOVE   "CHANGE"         TO  MCP-PUTTYPE
               PERFORM  210-BACK
      *    クリア
           WHEN    "CLICKED"       ALSO    "B02"
               PERFORM 420-CLEAR-SEC
      *    追加
           WHEN    "CLICKED"       ALSO    "B06"
               PERFORM 420-TUIKA-SEC
      *    変更
           WHEN    "CLICKED"       ALSO    "B07"
               PERFORM 420-HENKOU-SEC
      *    削除
           WHEN    "CLICKED"       ALSO    "B08"
               PERFORM 420-SAKUJO-SEC
      *    病室管理情報画面へ
           WHEN    "CLICKED"       ALSO    "B09"
               IF  ( SPA-MOTOPG    =       "W01" )
                   PERFORM 420-BYOSITU-KANRI-SEC
               END-IF
      *    食堂加算区分
      *    保育士数区分
           WHEN    "CLICKED"       ALSO    "CHK_SYOKUDOKBN"
           WHEN    "CLICKED"       ALSO    "CHK_HIKSISUKBN"
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
      *    病棟番号
           WHEN    "ACTIVATE"      ALSO    "BTUNUM"
                   PERFORM 4100-BTUNUM-CHK-SEC
      *
      *    病棟種別
           WHEN    "ACTIVATE"      ALSO    "SBT"
                   PERFORM 4100-SBT-CHK-SEC
      *    選択番号
           WHEN    "ACTIVATE"      ALSO    "SELNUM"
                   PERFORM 4100-SELNUM-CHK-SEC
      *    病棟リスト
           WHEN    ANY             ALSO    "BTULST"
               PERFORM 4100-BTULST-CHK-SEC
      *    履歴リスト
           WHEN    ANY             ALSO    "RIREKILST"
                   PERFORM 4100-RIREKILST-CHK-SEC
      *    入院基本料
           WHEN    "ACTIVATE"      ALSO    "KHNRYO"
      *
      *        入院基本料チェック処理
               PERFORM 4100-KHNRYO-CHK-SEC
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
       400-GMN-INPUT-SEC          SECTION.
      *
           MOVE    ZERO        TO      SPA-GMN-W20-CUR
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
      *    病棟名称
           MOVE    W20-NAME        TO  SPA-GMN-W20-NAME
      *
      *    短縮病棟名
           MOVE    W20-TANNAME     TO  SPA-GMN-W20-TANNAME
      *
      *    特定入院料
           MOVE    W20-TOKUTEINYUIN
                                   TO  SPA-GMN-W20-TOKNYUIN-G
      *
      *    病棟科名
           MOVE    W20-SRYKA       TO  SPA-GMN-W20-SRYKA-G
      *
      *    看護補助加算
           MOVE    W20-KNGHJOKSN   TO  SPA-GMN-W20-KNGHJOKSN-G
      *
      *    夜間勤務看護加算
           MOVE    W20-YAKANKNGKSN TO  SPA-GMN-W20-YKNKNGKSN-G
      *
      *    食堂加算区分
           MOVE    W20-CHK-SYOKUDOKBN
                                   TO  SPA-GMN-W20-CHK-SYOKUDOKBN
      *
      *    保育士人数
           MOVE    W20-CHK-HIKSISUKBN
                                   TO  SPA-GMN-W20-CHK-HIKSIS
      *
      *    レセプト表示区分
           MOVE    W20-RECEDSPKBN  TO  SPA-GMN-W20-RECEDSPKBN-G
      *
      *    有効期間開始日
           MOVE    W20-YUKOSTYMD   TO  SPA-GMN-W20-YUKOSTYMD
      *
      *    有効期間終了日
           MOVE    W20-YUKOEDYMD   TO  SPA-GMN-W20-YUKOEDYMD
      *
      *    病棟終了区分
           MOVE    W20-EDKBN       TO  SPA-GMN-W20-EDKBN-G
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
      *    病棟番号チェック処理
           PERFORM 4101-BTUNUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               PERFORM 420-CLEAR-SEC
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    有効期間開始日チェック処理
           PERFORM 4101-YUKOSTYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    有効期間終了日チェック処理
           PERFORM 4101-YUKOEDYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    病棟名称チェック処理
           PERFORM 4101-NAME-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    短縮病棟名チェック処理
           PERFORM 4101-TANNAME-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    特定入院料チェック処理
           PERFORM 4101-TOKUTEINYUIN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    病棟科名チェック処理
           PERFORM 4101-SRYKA-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    病棟種別チェック処理
           PERFORM 4101-SBT-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    看護補助加算チェック処理
           PERFORM 4101-KNGHJOKSN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    夜間勤務等看護加算チェック処理
           PERFORM 4101-YAKANKNGKSN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    レセプト表示区分チェック処理
           PERFORM 4101-RECEDSPKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    病棟継続区分チェック処理
           PERFORM 4101-EDKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    入院基本料チェック
           PERFORM 4101-KHNRYO-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
           .
      *
       4102-KIHON-CHK-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    SPA-MOTOPG          TO  SPA-SAKIPG
           MOVE    SPA-MOTOPG2         TO  SPA-MOTOPG3
           MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
           MOVE    "W20"               TO  SPA-MOTOPG
      *
      ***  MOVE   "CHANGE"             TO  MCP-PUTTYPE
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
      *    条件クリア処理
      *****************************************************************
       420-CLEAR-SEC               SECTION.
      *
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
           PERFORM 4201-RIREKI-AREA-CLEAR-SEC
      *
           .
       420-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    追加処理
      *****************************************************************
       420-TUIKA-SEC               SECTION.
      *
      *    入力項目入力時チェック
           PERFORM 410-INPUT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  420-TUIKA-EXT
           END-IF
      *
      *    共通関連チェック
           PERFORM 4900-KANRENCHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  420-TUIKA-EXT
           END-IF
      *
      *    既存の履歴データをチェックし、期間の重複したデータが
      *    存在しないこと
           MOVE    1                   TO  FLG-UPD-KBN
           PERFORM 4100-RIREKI-CHK-SEC
           IF   ( FLG-KIKAN-DABURI NOT =   ZERO )
               MOVE    "1104"          TO  SPA-ERRCD
               MOVE    17          TO  SPA-GMN-W20-CUR
               GO  TO  420-TUIKA-EXT
           END-IF
      *
      *    病棟終了区分が廃止の場合、
      *    病室管理情報（有効期間終了日）を更新する
           IF    ( SPA-GMN-W20-EDKBN   =   "2" )
      *        病室管理情報更新処理
               PERFORM 4201-BRM-UPDATE-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  420-TUIKA-EXT
               END-IF
      *
           END-IF
      *
      *    病棟情報追加編集処理
           PERFORM 4201-BTU-INSERT-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  420-TUIKA-EXT
           END-IF
      *
      *    病棟リストを再編集する
           PERFORM 3101-EDIT-BTULST-SEC 
      *
           PERFORM 4100-BTUNUM-LSTSEL-SEC
           MOVE    IDX-BTULST      TO  SPA-GMN-W20-BTULST-SEL
      *
      *    履歴リストを再編集する
           PERFORM 4100-RIREKI-AREA-EDIT-SEC
           MOVE    ZERO            TO  SPA-GMN-W20-RIREKILST-SEL
      *
      *    入力項目を初期化する
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
      *    病棟リスト最大件数チェック
           IF    ( SPA-GMN-W20-BTULST-MAX  >=  CONST-BTULST-MAX )
               MOVE    "1001"      TO  SPA-ERRCD
           END-IF
      *
           IF    ( SPA-GMN-W20-BTULST-SEL  =   SPA-GMN-W20-BTULST-MAX )
               MOVE    2           TO  FLG-BTULST-ROW
           ELSE
               MOVE    ZERO        TO  FLG-BTULST-ROW
           END-IF
      *
           .
       420-TUIKA-EXT.
           EXIT.
      *****************************************************************
      *    変更処理
      *****************************************************************
       420-HENKOU-SEC                  SECTION.
      *
      *    入力項目入力時チェック
           PERFORM 410-INPUT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  420-HENKOU-EXT
           END-IF
      *
      *    リストに該当番号の病棟が存在するかチェック
           PERFORM 4100-BTUNUM-LSTSEL-SEC
           IF    ( IDX-BTULST      =   ZERO )
               MOVE    "1002"      TO  SPA-ERRCD
               GO  TO  420-HENKOU-EXT
           END-IF
      *
      *    共通関連チェック
           PERFORM 4900-KANRENCHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  420-HENKOU-EXT
           END-IF
      *
      *    有効期間の開始日と終了日が同時に変更されていないこと
           IF    ( SPA-NAI-W20-YUKOSTYMD
                                   NOT =   SPA-NAI-W20-YUKOSTYMD-OLD )
            AND
                 ( SPA-NAI-W20-YUKOEDYMD
                                   NOT =   SPA-NAI-W20-YUKOEDYMD-OLD )
               MOVE    "1105"      TO  SPA-ERRCD
               MOVE    17          TO  SPA-GMN-W20-CUR
               GO  TO  420-HENKOU-EXT
           END-IF
      *
      *    既存の履歴データをチェックし、期間の重複したデータが
      *    存在しないこと
           MOVE    2                   TO  FLG-UPD-KBN
           PERFORM 4100-RIREKI-CHK-SEC
           IF   ( FLG-KIKAN-DABURI NOT =   ZERO )
               MOVE    "1104"          TO  SPA-ERRCD
               MOVE    17          TO  SPA-GMN-W20-CUR
               GO  TO  420-HENKOU-EXT
           END-IF
      *
      *    病棟終了区分が廃止の場合、
      *    病室管理情報（有効期間終了日）を更新する
           IF    ( SPA-GMN-W20-EDKBN   =   "2" )
      *        病室管理情報更新処理
               PERFORM 4201-BRM-UPDATE-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  420-HENKOU-EXT
               END-IF
      *
           END-IF
      *
      *    病棟管理情報更新処理
           PERFORM 4201-BTU-UPDATE-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  420-HENKOU-EXT
           END-IF
      *
      *    病棟リストを再編集する
           PERFORM 3101-EDIT-BTULST-SEC 
      *
           PERFORM 4100-BTUNUM-LSTSEL-SEC
           IF    ( IDX-BTULST      >   ZERO )
               MOVE    IDX-BTULST
                                   TO  SPA-GMN-W20-BTULST-SEL
      *        履歴リストを再編集する
               PERFORM 4100-RIREKI-AREA-EDIT-SEC
               MOVE    ZERO        TO  SPA-GMN-W20-RIREKILST-SEL
      *
      *        入力項目を初期化する
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
           ELSE
      *        画面を初期化する
               PERFORM 420-CLEAR-SEC
           END-IF
      *
           MOVE    ZERO            TO  FLG-BTULST-ROW
      *
           .
       420-HENKOU-EXT.
           EXIT.
      *****************************************************************
      *    履歴チェック処理
      *****************************************************************
       4100-RIREKI-CHK-SEC             SECTION.
      *
           MOVE    ZERO            TO  FLG-KIKAN-DABURI
      *
      *    病棟情報検索処理
           PERFORM 900-SYSKANRI-KEY8-SEL-SEC
      *
           PERFORM UNTIL ( FLG-SYSKANRI    NOT =   ZERO )
                    OR   ( FLG-KIKAN-DABURI    =   1    )
      *
      *        有効期間が重複するデータがないかチェック
      *        （変更処理の場合、元データは対象外とする）
               IF    ( FLG-UPD-KBN         =  2 )
                AND  ( SPA-NAI-W20-YUKOSTYMD-OLD 
                                           =   SYS-5001-STYUKYMD )
                AND  ( SPA-NAI-W20-YUKOEDYMD-OLD
                                           =   SYS-5001-EDYUKYMD )
                   CONTINUE
               ELSE
                   IF    ( SPA-NAI-W20-YUKOEDYMD
                                           <   SYS-5001-STYUKYMD )
                     OR  ( SPA-NAI-W20-YUKOSTYMD
                                           >   SYS-5001-EDYUKYMD )
                       CONTINUE
                   ELSE
                       MOVE    1           TO  FLG-KIKAN-DABURI
                   END-IF
               END-IF
      *
               PERFORM 900-SYSKANRI-KEY8-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key8"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
           .
      *
       4100-RIREKI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    削除処理
      *****************************************************************
       420-SAKUJO-SEC                  SECTION.
      *
      *    病棟番号チェック処理
           PERFORM 4101-BTUNUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               PERFORM 420-CLEAR-SEC
               GO  TO  420-SAKUJO-EXT
           END-IF
      *
      *   リストに該当番号の病棟が存在するかチェック
           PERFORM 4100-BTUNUM-LSTSEL-SEC
           IF    ( IDX-BTULST      =   ZERO )
               MOVE    "1003"      TO  SPA-ERRCD
               GO  TO  420-SAKUJO-EXT
           END-IF
      *
      *    削除する病棟の有効期間内に病室の情報が存在しないかチェック
           PERFORM 4200-BRM-SONZAI-CHK-SEC
           IF    ( FLG-BRM-SONZAI  =   ZERO )
               CONTINUE
           ELSE
               MOVE    "1006"      TO  SPA-ERRCD
               GO  TO  420-SAKUJO-EXT
           END-IF
      *
           MOVE    "2001"          TO  SPA-WIDCD
      *
           .
       420-SAKUJO-EXT.
           EXIT.
      *****************************************************************
      *    削除処理
      *****************************************************************
       421-SAKUJO-SEC                  SECTION.
      *
      *    病棟情報削除処理
           PERFORM  4201-BTU-DELETE-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  421-SAKUJO-EXT
           END-IF
      *
      *    病棟リストを再編集する
           PERFORM 3101-EDIT-BTULST-SEC 
      *
           PERFORM 4100-BTUNUM-LSTSEL-SEC
           IF    ( IDX-BTULST  >   ZERO )
      *
               MOVE    IDX-BTULST  TO  SPA-GMN-W20-BTULST-SEL
      *
      *        履歴リストを再編集する
               PERFORM 4100-RIREKI-AREA-EDIT-SEC
               MOVE    ZERO        TO  SPA-GMN-W20-RIREKILST-SEL
      *
      *        入力項目を初期化する
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
           ELSE
      *        画面を初期化する
               PERFORM 420-CLEAR-SEC
           END-IF
      *
           MOVE    ZERO            TO  FLG-BTULST-ROW
      *
           .
       421-SAKUJO-EXT.
           EXIT.
      *****************************************************************
      *    病室管理情報存在チェック処理
      *****************************************************************
       4200-BRM-SONZAI-CHK-SEC         SECTION.
      *
      *    削除する病棟の有効期間内に病室の情報が存在しないかチェック
      *    する
           MOVE    ZERO            TO  FLG-BRM-SONZAI
      *
           PERFORM 900-SYSKANRI-KEY4-SEL-SEC
      *
           PERFORM UNTIL ( FLG-BRM-SONZAI      =   1 )
                   OR    ( FLG-SYSKANRI    NOT =   ZERO )
      *
               IF    ( SPA-NAI-W20-YUKOSTYMD-OLD
                                      >=   SYS-5002-EDYUKYMD )
                 OR  ( SPA-NAI-W20-YUKOEDYMD-OLD
                                      <=   SYS-5002-STYUKYMD )
                   CONTINUE
               ELSE
      *
                   MOVE    1       TO  FLG-BRM-SONZAI
      *
               END-IF
      *
               PERFORM 900-SYSKANRI-KEY4-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       4200-BRM-SONZAI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    病室管理へ
      *****************************************************************
       420-BYOSITU-KANRI-SEC           SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           INITIALIZE  SPA-W20-W21-AREA
      *
      *    病棟が選択されている場合は、病室管理画面に病棟番号を引継ぐ
           IF    ( SPA-GMN-W20-BTULST-SEL
                                       NOT =   ZERO )
                 MOVE    SPA-GMN-W20-BTULST-SEL 
                                       TO  IDX1
                 MOVE    SPA-GMN-W20-TBTUNUM (IDX1)
                                       TO  SPA-W20-W21-BTU-NUM
           END-IF
      *
           MOVE    "W21"               TO  SPA-SAKIPG
           MOVE    "W20"               TO  SPA-MOTOPG
           MOVE    "W01"               TO  SPA-MOTOPG2
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       420-BYOSITU-KANRI-EXT.
           EXIT.
      *****************************************************************
      *    病室管理情報更新処理
      *****************************************************************
       4201-BRM-UPDATE-SEC             SECTION.
      *
      *    病室管理情報検索処理
           INITIALIZE                  SYSKANRI-REC
           MOVE    "5002"          TO  SYS-KANRICD
           MOVE    SPA-GMN-W20-BTUNUM
                                   TO  SYS-KBNCD
           MOVE    "%"             TO  SYS-KBNCD(3:1)
           MOVE    SPA-SYSYMD      TO  SYS-STYUKYMD
                                       SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY-SEL-SEC
      *
           PERFORM UNTIL ( FLG-SYSKANRI    =   1 )
      *
               MOVE    SYSKANRI-REC    TO  SYS-5002-REC
      *
               MOVE    SYS-5002-EDYUKYMD
                                       TO  WRK-EDYUKYMD
      *
      *        変更項目
               MOVE    SPA-NAI-W20-YUKOEDYMD
                                       TO  SYS-5002-EDYUKYMD
      *
               MOVE    SYS-5002-REC    TO  SYSKANRI-REC
      *
      *        キー項目
               MOVE    SYS-5002-KANRICD
                                       TO  SYSUP-KANRICD
               MOVE    SYS-5002-KBNCD
                                       TO  SYSUP-KBNCD
               MOVE    SYS-5002-STYUKYMD
                                       TO  SYSUP-STYUKYMD
               MOVE    WRK-EDYUKYMD    TO  SYSUP-EDYUKYMD
      *
               PERFORM 800-MCNDATE-SEC
               MOVE    SMCNDATE-YMD    TO  SYS-UPYMD
               MOVE    SMCNDATE-HMS    TO  SYS-UPHMS
      *
               MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *
               MOVE    "tbl_syskanri"  TO  MCP-TABLE
               MOVE    "upd1"          TO  MCP-PATHNAME
               PERFORM 910-DBUPDATE-SEC
               IF   (  MCP-RC      NOT =   ZERO )
                   MOVE    "1204"      TO  SPA-ERRCD
                   GO  TO  4201-BRM-UPDATE-EXT
               END-IF
      *
               PERFORM 900-SYSKANRI-KEY-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
      *
       4201-BRM-UPDATE-EXT.
           EXIT.
      *****************************************************************
      *    病棟情報更新処理
      *****************************************************************
       4201-BTU-UPDATE-SEC             SECTION.
      *
      *    アップデート対象のデータを読み直す
           INITIALIZE                  SYSKANRI-REC
      *
            MOVE   "5001"              TO  SYS-KANRICD
            MOVE   SPA-GMN-W20-BTUNUM  TO  SYS-KBNCD
            MOVE   SPA-NAI-W20-YUKOSTYMD-OLD
                                       TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           IF   ( FLG-SYSKANRI    NOT =   ZERO )
               MOVE    "1201"      TO  SPA-ERRCD
               GO  TO  4201-BTU-UPDATE-EXT
           END-IF
      *
           MOVE    SYSKANRI-REC    TO  SYS-5001-REC
      *
      *    病棟情報編集処理
           PERFORM 4201-BTU-EDIT-SEC
      *
           MOVE    SYS-5001-REC    TO  SYSKANRI-REC
           MOVE    SYS-5001-KANRICD
                                   TO  SYSUP-KANRICD
           MOVE    SYS-5001-KBNCD  TO  SYSUP-KBNCD
           MOVE    SPA-NAI-W20-YUKOSTYMD-OLD
                                   TO  SYSUP-STYUKYMD
           MOVE    SPA-NAI-W20-YUKOEDYMD-OLD
                                   TO  SYSUP-EDYUKYMD
      *
           PERFORM 800-MCNDATE-SEC
           MOVE    SMCNDATE-YMD    TO  SYS-UPYMD
           MOVE    SMCNDATE-HMS    TO  SYS-UPHMS
      *
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "upd1"          TO  MCP-PATHNAME
           PERFORM 910-DBUPDATE-SEC
           IF   (  MCP-RC      NOT =   ZERO )
               MOVE    "1201"      TO  SPA-ERRCD
           END-IF
           .
      *
       4201-BTU-UPDATE-EXT.
           EXIT.
      *****************************************************************
      *    病棟情報追加処理
      *****************************************************************
       4201-BTU-INSERT-SEC             SECTION.
      *
           INITIALIZE                  SYS-5001-REC
      *
      *    病棟情報編集処理
           PERFORM 4201-BTU-EDIT-SEC
      *
      *    病棟加算情報編集処理
           PERFORM 4201-BTU-KSN-EDIT-SEC
      *
           PERFORM 800-MCNDATE-SEC
           MOVE    SMCNDATE-YMD    TO  SYS-5001-CREYMD
                                       SYS-5001-UPYMD
           MOVE    SMCNDATE-HMS    TO  SYS-5001-UPHMS
      *
           MOVE    SYS-5001-REC    TO  SYSKANRI-REC
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           IF    ( FLG-SYSKANRI    =   ZERO )
               MOVE    "1202"      TO  SPA-ERRCD
           ELSE
               MOVE    SYS-5001-REC    TO  MCPDATA-REC
               MOVE    "tbl_syskanri"  TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               PERFORM 910-DBINSERT-SEC
               IF   (  MCP-RC      NOT =   ZERO )
                   MOVE    "1202"      TO  SPA-ERRCD
               END-IF
           END-IF
      *
           .
      *
       4201-BTU-INSERT-EXT.
           EXIT.
      *****************************************************************
      *    病棟情報削除処理
      *****************************************************************
       4201-BTU-DELETE-SEC             SECTION.
      *
           INITIALIZE                     SYS-5001-REC
           MOVE    "5001"             TO  SYS-5001-KANRICD
           MOVE    SPA-GMN-W20-BTUNUM TO  SYS-5001-KBNCD
           MOVE    SPA-NAI-W20-YUKOSTYMD-OLD
                                      TO  SYS-5001-STYUKYMD
           MOVE    SPA-NAI-W20-YUKOEDYMD-OLD
                                      TO  SYS-5001-EDYUKYMD
           MOVE    SYS-5001-REC       TO  MCPDATA-REC
           MOVE    "tbl_syskanri"     TO  MCP-TABLE
           MOVE    "key"              TO  MCP-PATHNAME
           PERFORM 910-DBDELETE-SEC
           IF   (  MCP-RC         NOT =   ZERO )
               MOVE    "1203"      TO  SPA-ERRCD
           END-IF
      *
           .
       4201-BTU-DELETE-EXT.
           EXIT.
      *****************************************************************
      *    病棟情報編集処理
      *****************************************************************
       4201-BTU-EDIT-SEC               SECTION.
      *
      *    MOVE    SPACE       TO  SYS-5001-REC
      *    INITIALIZE              SYS-5001-REC
      *
      *    管理コード
           MOVE    "5001"              TO  SYS-5001-KANRICD
      *
      *    区分コード
           MOVE    SPA-GMN-W20-BTUNUM  TO  WRK-BTUNUM 
           MOVE    WRK-BTUNUM          TO  SYS-5001-KBNCD
      *
      *    有効開始年月日
           MOVE    SPA-NAI-W20-YUKOSTYMD
                                       TO  SYS-5001-STYUKYMD
      *
      *    有効終了年月日
           MOVE    SPA-NAI-W20-YUKOEDYMD
                                       TO  SYS-5001-EDYUKYMD
      *
      *    病棟番号
           MOVE    WRK-BTUNUM          TO  SYS-5001-BTU-NUM
      *
      *    病棟名称
           MOVE    SPA-GMN-W20-NAME    TO  SYS-5001-BTU-NAME
      *
      *    病棟短縮名称
           MOVE    SPA-GMN-W20-TANNAME TO  SYS-5001-BTU-TANNAME
      *
      *    特定入院料
           MOVE    SPA-GMN-W20-TOKNYUIN
                                       TO  SYS-5001-BTU-TOKTEI-NYUIN
      *
      *    病棟科
           MOVE    SPA-GMN-W20-SRYKA   TO  SYS-5001-BTU-KA
      *
      *    病棟種別
           MOVE    SPA-GMN-W20-SBT     TO  SYS-5001-BTU-SBT
      *
      *    看護補助加算区分
           MOVE    SPA-GMN-W20-KNGHJOKSN
                                       TO  SYS-5001-BTU-KNGHJOKSN
      *
      *    夜間勤務等看護加算区分
           MOVE    SPA-GMN-W20-YKNKNGKSN
                                       TO  SYS-5001-BTU-YAKANKNGKSN
      *
      *    食堂加算区分
           IF    ( SPA-GMN-W20-CHK-SYOKUDOKBN  =   "T" )
               MOVE    "2"             TO  SYS-5001-BTU-SYOKUDOKBN
           ELSE
               MOVE    "1"             TO  SYS-5001-BTU-SYOKUDOKBN
           END-IF
      *
      *    保育士人数区分
           IF    ( SPA-GMN-W20-CHK-HIKSIS  =   "T" )
               MOVE    "2"             TO  SYS-5001-BTU-HIKSISUKBN
           ELSE
               MOVE    "1"             TO  SYS-5001-BTU-HIKSISUKBN
           END-IF
      *
      *    レセプト表示区分
           MOVE    SPA-GMN-W20-RECEDSPKBN
                                       TO  SYS-5001-RECEDSPKBN
      *
      *    入院基本料点数コード
           MOVE    SPA-NAI-W20-KHNSRYCD
                                       TO  SYS-5001-BTU-KHNSRYCD
      *
      *    病棟終了区分
           MOVE    SPA-GMN-W20-EDKBN   TO  SYS-5001-BTU-EDKBN
      *
           .
       4201-BTU-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病棟情報編集処理
      *****************************************************************
       4201-BTU-KSN-EDIT-SEC           SECTION.
      *
      *    --  加算情報に初期値を設定  --
      *
      *    難病患者等特別入院診療加算
           MOVE    CONST-NANBYO    TO  SYS-5001-NANBYO-CD
           MOVE    "1"             TO  SYS-5001-NANBYO-KBN
      *
      *    特殊疾患入院施設管理加算
           MOVE    CONST-TOKUSYUCD TO  SYS-5001-TOKUSYU-CD
           MOVE    "1"             TO  SYS-5001-TOKUSYU-KBN
      *
      *    療養病棟療養環境加算
      *    PERFORM VARYING IDX1    FROM    1   BY  1
      *            UNTIL ( IDX1    >   3 )
      *        MOVE    CONST-YORYOCD (IDX1)
      *                            TO  SYS-5001-YORYO-CD (IDX1)
      *        MOVE    "1"         TO  SYS-5001-YORYO-KBN (IDX1)
      *    END-PERFORM
      *
      *    児童・思春期精神科入院医療管理加算
           MOVE    CONST-JIDOCD    TO  SYS-5001-JIDO-CD
           MOVE    "1"             TO  SYS-5001-JIDO-KBN
      *
      *    精神科応急入院施設管理加算
           MOVE    CONST-SEISINCD  TO  SYS-5001-SEISIN-CD
           MOVE    "1"             TO  SYS-5001-SEISIN-KBN
      *
      *
           IF    ( SPA-NAI-W20-YUKOSTYMD   >=  CONST-H180401 )
               MOVE    CONST-KANGOCD (1)
                                   TO  SYS-5001-KANGO-CD  (1)
               MOVE    "1"         TO  SYS-5001-KANGO-KBN (1)
           ELSE
      *        看護配置加算
               PERFORM VARYING IDX1    FROM    1   BY  1
                       UNTIL ( IDX1    >   5 )
                   MOVE    CONST-KANGOCD (IDX1)
                                       TO  SYS-5001-KANGO-CD (IDX1)
                   MOVE    "1"         TO  SYS-5001-KANGO-KBN (IDX1)
               END-PERFORM
           END-IF
      *
           IF    ( SPA-NAI-W20-YUKOSTYMD   >=  CONST-H180401 )
               MOVE    CONST-KNGTEKCD
                                   TO  SYS-5001-KNGTEK-CD
               MOVE    "1"         TO  SYS-5001-KNGTEK-KBN
      *
               MOVE    CONST-DRTEKCD
                                   TO  SYS-5001-DRTEK-CD
               MOVE    "1"         TO  SYS-5001-DRTEK-KBN
           END-IF
      *
           .
       4201-BTU-KSN-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病棟番号
      *****************************************************************
       4100-BTUNUM-CHK-SEC             SECTION.
      *
           MOVE    ZERO            TO  SPA-GMN-W20-CUR
      *
           MOVE    W20-BTUNUM      TO  SPA-GMN-W20-BTUNUM
      *
           PERFORM 4101-BTUNUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               PERFORM 420-CLEAR-SEC
               GO  TO  4100-BTUNUM-CHK-EXT
           END-IF
      *
      *    入力項目領域編集処理
           MOVE    SPA-GMN-W20-BTUNUM  TO  WRK-BTUNUM
           MOVE    SPA-SYSYMD          TO  WRK-KIJUN-YMD
      *
      *    画面初期化
           PERFORM 420-CLEAR-SEC
      *
           PERFORM 4100-INPUT-AREA-EDIT-SEC
           IF    ( FLG-SYS5001      =   ZERO )
      *
               PERFORM 4100-BTUNUM-LSTSEL-SEC
               MOVE    IDX-BTULST   TO  SPA-GMN-W20-BTULST-SEL
      *
      *        履歴データ編集処理
               PERFORM 4100-RIREKI-AREA-EDIT-SEC
           ELSE
      *
               MOVE    W20-BTUNUM      TO  SPA-GMN-W20-BTUNUM
      *
      *        システム管理情報再設定
               PERFORM 4100-SYS-KANRI-SAI-SET-SEC
      *
               MOVE    SPA-GMN-W20-EDKBNLST (1)
                                       TO  SPA-GMN-W20-EDKBN-G
           END-IF
      *
           MOVE    ZERO            TO  SPA-GMN-W20-CUR
      *
           .
      *
       4100-BTUNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟種別
      *****************************************************************
       4100-SBT-CHK-SEC                SECTION.
      *
           MOVE    ZERO            TO  SPA-GMN-W20-CUR
      *
           MOVE    W20-SBT         TO  SPA-GMN-W20-SBT-G
      *
           IF    ( SPA-GMN-W20-SBT-G   =   SPACE )
      *
               INITIALIZE  SPA-NAI-W20-KHNSRYCDLST-G
                           SPA-GMN-W20-KHNRYOLST-G
                           SPA-NAI-W20-KHNTENLST-G
      *
               INITIALIZE  SPA-GMN-W20-KHNRYO-G
                           SPA-NAI-W20-KHNSRYCD
                           SPA-NAI-W20-KHNTEN
                           SPA-GMN-W20-RECEDSPKBN-G
                           SPA-NAI-W20-SBT-MOT
               GO  TO  4100-SBT-CHK-EXT
           END-IF
      *
           PERFORM 4101-SBT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4100-SBT-CHK-EXT
           END-IF
      *
           IF    ( SPA-GMN-W20-SBT     =   SPA-NAI-W20-SBT-MOT )
               GO  TO  4100-SBT-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-W20-SBT     TO  SPA-NAI-W20-SBT-MOT
      *
           INITIALIZE      SPA-NAI-W20-KHNSRYCDLST-G
                           SPA-GMN-W20-KHNRYOLST-G
                           SPA-NAI-W20-KHNTENLST-G
      *
           INITIALIZE      SPA-GMN-W20-KHNRYO-G
                           SPA-NAI-W20-KHNSRYCD
                           SPA-NAI-W20-KHNTEN
                           SPA-GMN-W20-RECEDSPKBN-G
      *
      *    入院基本料コンボ編集処理
           PERFORM 4100-KHNRYO-CMB-EDT-SEC
      *
      *    療養・老人・有床・有床療養は看護補助配置を入力不可とする
           IF    ( SPA-GMN-W20-SBT =   "04" OR "07" OR "08" OR "09" )
               MOVE    SPACE       TO  SPA-GMN-W20-KNGHJOKSN-G
           END-IF
      *
           IF    ( SPA-NAI-W20-YUKOSTYMD  >=   CONST-H180401 )
               IF    ( SPA-GMN-W20-SBT NOT =   "04" )
                   MOVE    SPACE       TO  SPA-GMN-W20-YKNKNGKSN-G
               END-IF
           END-IF
      *
           MOVE    SPA-GMN-W20-SBT     TO  WRK-CMB-CD
           PERFORM 4201-RECEDSPKBNLST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-W20-RECEDSPKBN-G
      *
           MOVE    ZERO            TO  SPA-GMN-W20-CUR
      *
           .
      *
       4100-SBT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟番号
      *****************************************************************
       4101-BTUNUM-CHK-SEC             SECTION.
      *
           IF    ( SPA-GMN-W20-BTUNUM      =   ZERO )
               MOVE    "1101"          TO  SPA-ERRCD
               MOVE    1               TO  SPA-GMN-W20-CUR
           END-IF
           .
      *
       4101-BTUNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟名称
      *****************************************************************
       4101-NAME-CHK-SEC               SECTION.
      *
      *    全角半角チェック
           MOVE    SPA-GMN-W20-NAME
                                   TO  WRK-KANACHK-MAE-INPUT
           PERFORM 800-ENRTRY-CHK-SEC
           MOVE    WRK-KANACHK-OUT-INPUT
                                   TO  SPA-GMN-W20-NAME
           IF    ( FLG-ENTRYCHK    NOT =   ZERO )
               MOVE    2           TO  SPA-GMN-W20-CUR
               MOVE    "0002"      TO  SPA-ERRCD
           END-IF
      *
           .
      *
       4101-NAME-CHK-EXT.
           EXIT.
      *****************************************************************
      *    短縮病棟名
      *****************************************************************
       4101-TANNAME-CHK-SEC        SECTION.
      *
      *    全角半角チェック
           MOVE    SPA-GMN-W20-TANNAME
                                   TO  WRK-KANACHK-MAE-INPUT
           PERFORM 800-ENRTRY-CHK-SEC
           MOVE    WRK-KANACHK-OUT-INPUT
                                   TO  SPA-GMN-W20-TANNAME
           IF    ( FLG-ENTRYCHK    NOT =   ZERO )
               MOVE    3           TO  SPA-GMN-W20-CUR
               MOVE    "0002"      TO  SPA-ERRCD
           END-IF
      *
           .
      *
       4101-TANNAME-CHK-EXT.
           EXIT.
      *****************************************************************
      *    特定入院料
      *****************************************************************
       4101-TOKUTEINYUIN-CHK-SEC   SECTION.
      *
           IF    ( SPA-GMN-W20-TOKNYUIN-G  =   SPACE )
               GO  TO  4101-TOKUTEINYUIN-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W20-TOKNYUIN    TO  WRK-CMB-CD
           PERFORM 4200-TOKNYUINLST-CHK-SEC
           IF    ( WRK-CMB-ITM     =   SPACE )
               MOVE    4           TO  SPA-GMN-W20-CUR
               MOVE    "0004"      TO  SPA-ERRCD
           ELSE
               MOVE    WRK-CMB-ITM TO  SPA-GMN-W20-TOKNYUIN-G 
           END-IF
      *
           .
      *
       4101-TOKUTEINYUIN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟科名
      *****************************************************************
       4101-SRYKA-CHK-SEC             SECTION.
      *
           IF    ( SPA-GMN-W20-SRYKA-G =   SPACE )
               GO  TO  4101-SRYKA-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W20-SRYKA   TO  WRK-CMB-CD
           PERFORM 4200-SRYKALST-CHK-SEC
           IF    ( WRK-CMB-ITM     =   SPACE )
               MOVE    5           TO  SPA-GMN-W20-CUR
               MOVE    "0005"      TO  SPA-ERRCD
           ELSE
               MOVE    WRK-CMB-ITM TO  SPA-GMN-W20-SRYKA-G
           END-IF
      *
           .
      *
       4101-SRYKA-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟種別
      *****************************************************************
       4101-SBT-CHK-SEC                SECTION.
      *
           IF    ( SPA-GMN-W20-SBT-G   =   SPACE )
               GO  TO  4101-SBT-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-W20-SBT TO  WRK-CMB-CD
           PERFORM 4200-SBTLST-CHK-SEC
           IF    ( WRK-CMB-ITM     =   SPACE )
               MOVE    6           TO  SPA-GMN-W20-CUR
               MOVE    "0006"      TO  SPA-ERRCD
               GO  TO  4101-SBT-CHK-EXT
           ELSE
               MOVE    WRK-CMB-ITM TO  SPA-GMN-W20-SBT-G
           END-IF
      *
           .
      *
       4101-SBT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院基本料コンボ編集処理
      *****************************************************************
       4100-KHNRYO-CMB-EDT-SEC     SECTION.
      *
           MOVE    ZERO            TO  FLG-TENSU
      *
           INITIALIZE  SPA-NAI-W20-KHNSRYCDLST-G
                       SPA-GMN-W20-KHNRYOLST-G
                       SPA-NAI-W20-KHNTENLST-G
      *
           MOVE    ZERO            TO  IDX-CMB
      *
           IF    ( SPA-NAI-W20-YUKOSTYMD  >=   CONST-H180401 )
            AND  ( SPA-GMN-W20-SBT         =   "08" )
               PERFORM 41001-KHNRYO-CMB-EDT-SEC
           ELSE
               PERFORM 41002-KHNRYO-CMB-EDT-SEC
           END-IF
      *
           .
      *
       4100-KHNRYO-CMB-EDT-EXT.
           EXIT.
      *****************************************************************
      *    入院基本料コンボ編集処理
      *****************************************************************
       41001-KHNRYO-CMB-EDT-SEC     SECTION.
      *
           MOVE    "099999950"         TO  WRK-TNS-SRYCD
           MOVE    SPA-NAI-W20-YUKOSTYMD
                                       TO  WRK-TNS-KJNYMD
           PERFORM 900-TENSU-KEY-SEL-SEC
           IF    ( FLG-TENSU           =   ZERO )
               PERFORM 410011-KHNRYO-CMB-SET-SEC
           END-IF
      *
           MOVE    "099999951"         TO  WRK-TNS-SRYCD
           MOVE    SPA-NAI-W20-YUKOSTYMD
                                       TO  WRK-TNS-KJNYMD
      *
           PERFORM 900-TENSU-KEY-SEL-SEC
           IF    ( FLG-TENSU           =   ZERO )
               PERFORM 410011-KHNRYO-CMB-SET-SEC
           END-IF
      *
           .
      *
       41001-KHNRYO-CMB-EDT-EXT.
           EXIT.
      *****************************************************************
      *    入院基本料コンボ編集処理
      *****************************************************************
       410011-KHNRYO-CMB-SET-SEC       SECTION.
      *
           COMPUTE IDX-CMB     =   IDX-CMB    +   1
           MOVE    IDX-CMB     TO  SPA-GMN-W20-KHNRYO-MAX
      *
           MOVE    TNS-SRYCD   TO  SPA-NAI-W20-KHNSRYCDLST
                                               (IDX-CMB)
      *
           MOVE    IDX-CMB     TO  WRK-99
           MOVE    WRK-99      TO  SPA-GMN-W20-KHNRYOL
                                                   (IDX-CMB)
           MOVE    TNS-NAME    TO  SPA-GMN-W20-KHNRYOMEIL
                                                   (IDX-CMB)
           MOVE    TNS-TEN     TO  SPA-NAI-W20-KHNTENLST
                                                   (IDX-CMB)
      *
           .
       410011-KHNRYO-CMB-SET-EXT.
           EXIT.
      *****************************************************************
      *    入院基本料コンボ編集処理
      *****************************************************************
       41002-KHNRYO-CMB-EDT-SEC     SECTION.
      *
      *    点数マスタ検索処理
           PERFORM 900-TENSU-SEL-SEC
      *
           PERFORM UNTIL ( FLG-TENSU   NOT =   ZERO )
                OR       ( IDX-CMB        >=   CONST-KHNRYO-MAX  )
      *
               MOVE    1           TO  FLG-SETKHNRYO
      *
      *        選定入院料は読み飛ばす
               MOVE    ZERO        TO  CNT-STR
               INSPECT TNS-NAME    TALLYING   CNT-STR
                       FOR     ALL "（選）", ALL "（選定療養）"
      *
      *
               IF    ( CNT-STR     >   ZERO )
                   MOVE    ZERO    TO  FLG-SETKHNRYO
               END-IF
      *
               IF    ( TNS-ROUTEKKBN       =   "2" )
                   MOVE    ZERO    TO  FLG-SETKHNRYO
               END-IF
      *
               IF    ( FLG-SETKHNRYO   =   1 )
                   PERFORM 410011-KHNRYO-CMB-SET-SEC
               END-IF
      *
      *        点数マスタ読込処理
               PERFORM 900-TENSU-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    WRK-PATHNAME        TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
      *
       41002-KHNRYO-CMB-EDT-EXT.
           EXIT.
      *****************************************************************
      *    看護補助加算
      *****************************************************************
       4101-KNGHJOKSN-CHK-SEC      SECTION.
      *
           IF    ( SPA-GMN-W20-KNGHJOKSN
                                   =   SPACE )
               GO  TO  4101-KNGHJOKSN-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W20-KNGHJOKSN   TO  WRK-CMB-CD
           PERFORM 4200-KNGHJOKSNLST-CHK-SEC
           IF    ( WRK-CMB-ITM     =   SPACE )
               MOVE    7           TO  SPA-GMN-W20-CUR
               MOVE    "0007"      TO  SPA-ERRCD
           ELSE
               MOVE    WRK-CMB-ITM TO  SPA-GMN-W20-KNGHJOKSN-G
           END-IF
      *
           .
      *
       4101-KNGHJOKSN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    夜間勤務等看護加算
      *****************************************************************
       4101-YAKANKNGKSN-CHK-SEC    SECTION.
      *
           IF    ( SPA-GMN-W20-YKNKNGKSN
                                   =   SPACE )
               GO  TO  4101-YAKANKNGKSN-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W20-YKNKNGKSN
                                   TO  WRK-CMB-CD
           PERFORM 4200-YAKANKNGKSNLST-CHK-SEC
           IF    ( WRK-CMB-ITM     =   SPACE )
               MOVE    8           TO  SPA-GMN-W20-CUR
               MOVE    "0008"      TO  SPA-ERRCD
           ELSE
               MOVE    WRK-CMB-ITM TO  SPA-GMN-W20-YKNKNGKSN-G
           END-IF
      *
           .
      *
       4101-YAKANKNGKSN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    レセプト表示区分
      *****************************************************************
       4101-RECEDSPKBN-CHK-SEC     SECTION.
      *
           IF    ( SPA-GMN-W20-RECEDSPKBN-G
                                   =   SPACE )
               GO  TO  4101-RECEDSPKBN-CHK-EXT
      *
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W20-RECEDSPKBN
                                   TO  WRK-CMB-CD
           PERFORM 4200-RECEDSPKBNLST-CHK-SEC
           IF    ( WRK-CMB-ITM     =   SPACE )
               MOVE    14          TO  SPA-GMN-W20-CUR
               MOVE    "0009"      TO  SPA-ERRCD
           ELSE
               MOVE    WRK-CMB-ITM TO  SPA-GMN-W20-RECEDSPKBN-G
           END-IF
      *
           .
      *
       4101-RECEDSPKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    有効期間開始日
      *****************************************************************
       4101-YUKOSTYMD-CHK-SEC          SECTION.
      *
           MOVE    SPA-NAI-W20-YUKOSTYMD
                                   TO  WRK-YUKOSTYMD
           MOVE    SPACE           TO  SPA-NAI-W20-YUKOSTYMD
      *
      *    日付妥当性チェック＆編集処理
           IF    ( SPA-GMN-W20-YUKOSTYMD   =   SPACE )
               MOVE    SPA-SYSYMDWH (1 : 6)
                                       TO  SPA-GMN-W20-YUKOSTYMD (1 : 6)
               MOVE    ". 1"           TO  SPA-GMN-W20-YUKOSTYMD (7 : 3)
               MOVE    SPA-SYSYMD   (1 : 6)
                                       TO  SPA-NAI-W20-YUKOSTYMD (1 : 6)
               MOVE    "01"            TO  SPA-NAI-W20-YUKOSTYMD (7 : 2)
      *
      *
      *        システム管理情報再設定
               PERFORM 4100-SYS-KANRI-SAI-SET-SEC
      *
               GO  TO  4101-YUKOSTYMD-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-W20-YUKOSTYMD   TO  WRK-YMD
           PERFORM 800-SEIWA-HEN-SEC
           IF  ( FLG-HIZUKE-ERR    =   ZERO )
               MOVE    WRK-HENYMDG
                                   TO  SPA-GMN-W20-YUKOSTYMD
               MOVE    WRK-SYMD    TO  SPA-NAI-W20-YUKOSTYMD
           ELSE
               MOVE    WRK-YUKOSTYMD
                                   TO  WRK-YMD
               PERFORM 800-SEIWA-HEN-SEC
               MOVE    WRK-HENYMDG
                                   TO  SPA-GMN-W20-YUKOSTYMD
               MOVE    WRK-SYMD    TO  SPA-NAI-W20-YUKOSTYMD
               MOVE    "0010"      TO  SPA-ERRCD
               MOVE    12          TO  SPA-GMN-W20-CUR
               GO  TO  4101-YUKOSTYMD-CHK-EXT
           END-IF
      *
           IF    ( SPA-NAI-W20-YUKOSTYMD   <   "20020401" )
               MOVE    "0003"      TO  SPA-ERRCD
               MOVE    "H14. 4. 1" TO  SPA-GMN-W20-YUKOSTYMD
               MOVE    "20020401"  TO  SPA-NAI-W20-YUKOSTYMD
               MOVE    12          TO  SPA-GMN-W20-CUR
               GO  TO  4101-YUKOSTYMD-CHK-EXT
           END-IF
      *
           IF    ( SPA-NAI-W20-YUKOSTYMD
                               NOT =   SPA-NAI-W20-YUKOSTYMD-MOT )
      *        システム管理情報再設定
               PERFORM 4100-SYS-KANRI-SAI-SET-SEC
           END-IF
      *
           IF    ( SPA-NAI-W20-YUKOSTYMD  >=   CONST-H180401 )
               IF    ( SPA-NAI-W20-YUKOSTYMD-MOT   <   CONST-H180401 )
                   INITIALIZE              SPA-NAI-W20-KHNSRYCD
                                           SPA-NAI-W20-KHNTEN
                                           SPA-GMN-W20-KHNRYO-G
                                           SPA-GMN-W20-KNGHJOKSN-G
               END-IF
      *
               IF    ( SPA-GMN-W20-SBT NOT =   "04" )
                   MOVE    SPACE   TO  SPA-GMN-W20-YKNKNGKSN-G
               END-IF
      *
           END-IF
      *
           MOVE    SPA-NAI-W20-YUKOSTYMD
                                   TO  SPA-NAI-W20-YUKOSTYMD-MOT
      *
           .
      *
       4101-YUKOSTYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    有効期間終了日
      *****************************************************************
       4101-YUKOEDYMD-CHK-SEC           SECTION.
      *
           MOVE    SPA-NAI-W20-YUKOEDYMD
                                   TO  WRK-YUKOEDYMD
           MOVE    SPACE           TO  SPA-NAI-W20-YUKOEDYMD
      *
      *    日付妥当性チェック＆編集処理
           IF    ( SPA-GMN-W20-YUKOEDYMD   =   SPACE )
               MOVE    "99999999"  TO  SPA-GMN-W20-YUKOEDYMD
                                       SPA-NAI-W20-YUKOEDYMD
               GO  TO  4101-YUKOEDYMD-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-W20-YUKOEDYMD
                                   TO  WRK-YMD
           PERFORM 800-SEIWA-HEN-SEC
           IF  ( FLG-HIZUKE-ERR    =   ZERO )
               MOVE    WRK-HENYMDG
                                   TO  SPA-GMN-W20-YUKOEDYMD
               MOVE    WRK-SYMD    TO  SPA-NAI-W20-YUKOEDYMD
           ELSE
               MOVE    WRK-YUKOEDYMD
                                   TO  WRK-YMD
               PERFORM 800-SEIWA-HEN-SEC
               MOVE    WRK-HENYMDG
                                   TO  SPA-GMN-W20-YUKOEDYMD
               MOVE    WRK-SYMD    TO  SPA-NAI-W20-YUKOEDYMD
               MOVE    "0011"      TO  SPA-ERRCD
               MOVE    13          TO  SPA-GMN-W20-CUR
               GO  TO  4101-YUKOEDYMD-CHK-EXT
           END-IF
      *
           .
      *
       4101-YUKOEDYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟終了区分
      *****************************************************************
       4101-EDKBN-CHK-SEC          SECTION.
      *
           MOVE    SPA-GMN-W20-EDKBN   TO  WRK-CMB-CD
           PERFORM 4200-EDKBNLST-CHK-SEC
           IF    ( WRK-CMB-ITM     =   SPACE )
               MOVE    SPA-GMN-W20-EDKBNLST (1)
                                       TO  SPA-GMN-W20-EDKBN-G
           ELSE
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-W20-EDKBN-G
           END-IF
      *
           .
      *
       4101-EDKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院基本料
      *****************************************************************
       4100-KHNRYO-CHK-SEC         SECTION.
      *
           MOVE    ZERO            TO  SPA-GMN-W20-CUR
      *
           INITIALIZE              SPA-NAI-W20-KHNSRYCD
                                   SPA-NAI-W20-KHNTEN
      *
           MOVE    W20-KHNRYO      TO  SPA-GMN-W20-KHNRYO-G
      *
      *    入院基本料チェック
           PERFORM 4101-KHNRYO-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4100-KHNRYO-CHK-EXT
           END-IF
      *
           MOVE    ZERO            TO  SPA-GMN-W20-CUR
      *
           .
      *
       4100-KHNRYO-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院基本料
      *****************************************************************
       4101-KHNRYO-CHK-SEC         SECTION.
      *
           IF    ( SPA-GMN-W20-KHNRYO
                                   =   SPACE )
               GO  TO  4101-KHNRYO-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-W20-KHNRYO  TO  WRK-CMB-CD
           PERFORM 4200-KHNRYOLST-CHK-SEC
           IF    ( WRK-CMB-ITM         =   SPACE )
               MOVE    "0012"          TO  SPA-ERRCD
               MOVE    15              TO  SPA-GMN-W20-CUR
           ELSE
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-W20-KHNRYO-G
               MOVE    WRK-CMB-ITM2    TO  SPA-NAI-W20-KHNSRYCD
               MOVE    WRK-CMB-ITM3    TO  SPA-NAI-W20-KHNTEN
           END-IF
      *
           .
      *
       4101-KHNRYO-CHK-EXT.
           EXIT.
      *****************************************************************
      *    選択番号
      *****************************************************************
       4100-SELNUM-CHK-SEC             SECTION.
      *
           MOVE    ZERO            TO  SPA-GMN-W20-CUR
      *
           MOVE    W20-SELNUM      TO  SPA-GMN-W20-SELNUM
      *
           IF  (   SPA-GMN-W20-SELNUM  =   ZERO )
               GO  TO  4100-SELNUM-CHK-EXT
           END-IF
      *
      *    範囲内の番号が選択されていること
           IF    ( SPA-GMN-W20-SELNUM  >   SPA-GMN-W20-RIREKILST-MAX )
               MOVE    100         TO  SPA-GMN-W20-CUR
               MOVE    "0013"      TO  SPA-ERRCD
               GO  TO  4100-SELNUM-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-W20-SELNUM  TO  SPA-GMN-W20-RIREKILST-SEL
      *
      *    入力項目領域編集処理
           MOVE    SPA-NAI-W20-RIREKILST-BTUNUM 
                                   TO  WRK-BTUNUM 
           MOVE    SPA-NAI-W20-TRYUKOSTYMD (SPA-GMN-W20-SELNUM)
                                   TO  WRK-KIJUN-YMD
      *
      *    入力領域初期化
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
           PERFORM 4100-INPUT-AREA-EDIT-SEC
      *
           MOVE    W20-SELNUM      TO  SPA-GMN-W20-SELNUM
      *
           MOVE    ZERO            TO  SPA-GMN-W20-CUR
      *
           .
      *
       4100-SELNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟リスト
      *****************************************************************
       4100-BTULST-CHK-SEC                 SECTION.
      *
           MOVE    ZERO                TO  SPA-GMN-W20-BTULST-SEL
      *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL     ( IDX2    >   CONST-BTULST-MAX )
                     OR      ( SPA-GMN-W20-BTULST-SEL
                                       >   ZERO )
      *
               IF      (   W20-BTULST-SEL  (IDX2)  =   "T" )
      *
      *            入力項目領域編集処理
                   MOVE    SPA-GMN-W20-TBTUNUM (IDX2)
                                           TO  WRK-BTUNUM 
                   MOVE    SPA-SYSYMD      TO  WRK-KIJUN-YMD
      *
      *            画面初期化
                   PERFORM 420-CLEAR-SEC
      *
                   PERFORM 4100-INPUT-AREA-EDIT-SEC
      *
      *            履歴データ編集処理
                   PERFORM 4100-RIREKI-AREA-EDIT-SEC
      *
                   MOVE    IDX2        TO  SPA-GMN-W20-BTULST-SEL
      *
               END-IF
      *
           END-PERFORM
      *
           .
       4100-BTULST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    履歴リスト
      *****************************************************************
       4100-RIREKILST-CHK-SEC          SECTION.
      *
           MOVE    ZERO            TO  SPA-GMN-W20-RIREKILST-SEL
      *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL     ( IDX2    >   CONST-RIREKILST-MAX )
                    OR       ( SPA-GMN-W20-RIREKILST-SEL
                                       >   ZERO )
      *
               IF    ( W20-RIREKILST-SEL (IDX2)
                                       =   "T" )
      *
      *            入力項目領域編集処理
                   MOVE    SPA-NAI-W20-RIREKILST-BTUNUM 
                                       TO  WRK-BTUNUM 
                   MOVE    SPA-NAI-W20-TRYUKOSTYMD (IDX2)
                                       TO  WRK-KIJUN-YMD
      *
      *            入力領域初期化
                   PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
                   PERFORM 4100-INPUT-AREA-EDIT-SEC
      *
                   MOVE    IDX2        TO  SPA-GMN-W20-RIREKILST-SEL
                                           SPA-GMN-W20-SELNUM
               END-IF
      *
           END-PERFORM
      *
           .
       4100-RIREKILST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入力項目領域編集処理
      *****************************************************************
       4100-INPUT-AREA-EDIT-SEC            SECTION.
      *
           MOVE    ZERO            TO  FLG-SYS5001
      *
      *    病棟情報検索処理
           INITIALIZE                  SYS-5001-REC
           MOVE    "5001"          TO  SYS-5001-KANRICD
           MOVE    WRK-BTUNUM      TO  SYS-5001-KBNCD
           MOVE    WRK-KIJUN-YMD   TO  SYS-5001-STYUKYMD
                                       SYS-5001-EDYUKYMD
           MOVE    SYS-5001-REC    TO  SYSKANRI-REC
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           IF    ( FLG-SYSKANRI    =   1 )
               MOVE    1           TO  FLG-SYS5001
               GO  TO  4100-INPUT-AREA-EDIT-EXT
           END-IF
      *
           MOVE    SYSKANRI-REC    TO  SYS-5001-REC
      *
      *    有効開始日
           MOVE    SYS-5001-STYUKYMD
                                   TO  SPA-NAI-W20-YUKOSTYMD
                                       SPA-NAI-W20-YUKOSTYMD-OLD
                                       SPA-NAI-W20-YUKOSTYMD-MOT
                                       WRK-YMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-W20-YUKOSTYMD
      *
      *    有効終了日
           MOVE    SYS-5001-EDYUKYMD
                                   TO  SPA-NAI-W20-YUKOEDYMD
                                       SPA-NAI-W20-YUKOEDYMD-OLD
                                       WRK-YMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-W20-YUKOEDYMD
      *
      *    システム管理情報再設定
           PERFORM 4100-SYS-KANRI-SAI-SET-SEC
      *
      *    病棟番号
           MOVE    SYS-5001-BTU-NUM    TO  SPA-GMN-W20-BTUNUM
      *
      *    病棟名称
           MOVE    SYS-5001-BTU-NAME   TO  SPA-GMN-W20-NAME
      *
      *    短縮病棟名称
           MOVE    SYS-5001-BTU-TANNAME
                                       TO  SPA-GMN-W20-TANNAME
      *
      *    特定入院料
           MOVE    SYS-5001-BTU-TOKTEI-NYUIN
                                       TO  WRK-CMB-CD
           PERFORM 4200-TOKNYUINLST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-W20-TOKNYUIN-G
      *
      *    病棟科名
           MOVE    SYS-5001-BTU-KA     TO  WRK-CMB-CD
           PERFORM 4200-SRYKALST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-W20-SRYKA-G
      *
      *    病棟種別
           MOVE    SYS-5001-BTU-SBT    TO  WRK-CMB-CD
           PERFORM 4200-SBTLST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-W20-SBT-G
           MOVE    SYS-5001-BTU-SBT    TO  SPA-NAI-W20-SBT-MOT
      *
      *    看護補助加算
           MOVE    SYS-5001-BTU-KNGHJOKSN
                                       TO  WRK-CMB-CD
           PERFORM 4200-KNGHJOKSNLST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-W20-KNGHJOKSN-G
      *
      *    夜間勤務等看護加算
           MOVE    SYS-5001-BTU-YAKANKNGKSN
                                       TO  WRK-CMB-CD
           PERFORM 4200-YAKANKNGKSNLST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-W20-YKNKNGKSN-G
      *
      *    食堂加算
           IF    ( SYS-5001-BTU-SYOKUDOKBN =   "2" )
               MOVE    "T" TO  SPA-GMN-W20-CHK-SYOKUDOKBN
           ELSE
               MOVE    "F" TO  SPA-GMN-W20-CHK-SYOKUDOKBN
           END-IF
      *
      *    保育士人数区分
           IF    ( SYS-5001-BTU-HIKSISUKBN     =   "2" )
               MOVE    "T" TO  SPA-GMN-W20-CHK-HIKSIS
           ELSE
               MOVE    "F" TO  SPA-GMN-W20-CHK-HIKSIS
           END-IF
      *
      *    レセプト表示区分
           MOVE    SYS-5001-RECEDSPKBN TO  WRK-CMB-CD
           PERFORM 4200-RECEDSPKBNLST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-W20-RECEDSPKBN-G
      *
      *    病棟終了区分
           MOVE    SYS-5001-BTU-EDKBN  TO  WRK-CMB-CD
           PERFORM 4200-EDKBNLST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-W20-EDKBN-G
      *
      *    入院基本料コンボ編集処理
           PERFORM 4100-KHNRYO-CMB-EDT-SEC
      *
           MOVE    SYS-5001-BTU-KHNSRYCD
                                   TO  SPA-NAI-W20-KHNSRYCD
      *
      *    入院基本点数をサブプロより取得する
           INITIALIZE W20SUB01-LNK
           MOVE    "1"             TO  W20SUB01-I-KBN
           MOVE    SYS-5001-BTU-KHNSRYCD
                                   TO  W20SUB01-I-KHNSRYCD
           MOVE    SPA-NAI-W20-YUKOSTYMD
                                   TO  W20SUB01-I-KJNYMD
      *
           CALL    "ORCGW20SUB01"      USING
                                       W20SUB01-LNK
           IF    ( W20SUB01-O-RC   =   ZERO )
               MOVE    W20SUB01-O-KHNSRYCD
                                   TO  WRK-CMB-CD
               PERFORM 4201-KHNRYOLST-CHK-SEC
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-W20-KHNRYO-G
               MOVE    WRK-CMB-ITM2    TO  SPA-NAI-W20-KHNSRYCD
               MOVE    WRK-CMB-ITM3    TO  SPA-NAI-W20-KHNTEN
           END-IF
      *
           .
       4100-INPUT-AREA-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    履歴領域編集処理
      *****************************************************************
       4100-RIREKI-AREA-EDIT-SEC       SECTION.
      *
           INITIALIZE      SPA-GMN-W20-RIREKILST
                           SPA-NAI-W20-RIREKILST
      *
           MOVE    SPA-GMN-W20-BTUNUM
                                   TO  SPA-NAI-W20-RIREKILST-BTUNUM 
      *
           PERFORM 900-SYSKANRI-KEY8-SEL-SEC
      *
           MOVE    ZERO            TO  IDX-LST
           PERFORM UNTIL ( FLG-SYSKANRI    NOT =   ZERO )
                 OR      ( IDX-LST            >=   CONST-RIREKILST-MAX )
      *
               COMPUTE IDX-LST =   IDX-LST +   1
               MOVE    IDX-LST    TO  SPA-GMN-W20-RIREKILST-MAX
      *
      *        選択番号
               MOVE    IDX-LST    TO  SPA-GMN-W20-TRSELNUM (IDX-LST)
      *
      *        有効開始日
               MOVE    SYS-5001-STYUKYMD
                                  TO  SPA-NAI-W20-TRYUKOSTYMD (IDX-LST)
                                          WRK-YMD
               PERFORM 800-SEIWA-HEN-SEC
               MOVE    WRK-HENYMDG
                                  TO  SPA-GMN-W20-TRYUKOSTYMD (IDX-LST)
      *
      *        有効終了日
               MOVE    SYS-5001-EDYUKYMD
                                   TO  SPA-NAI-W20-TRYUKOEDYMD(IDX-LST)
                                           WRK-YMD
               PERFORM 800-SEIWA-HEN-SEC
               MOVE    WRK-HENYMDG TO  SPA-GMN-W20-TRYUKOEDYMD(IDX-LST)
      *
               IF    ( SPA-NAI-W20-YUKOSTYMD-OLD
                                   =   SPA-NAI-W20-TRYUKOSTYMD(IDX-LST))
                AND  ( SPA-NAI-W20-YUKOEDYMD-OLD
                                   =   SPA-NAI-W20-TRYUKOEDYMD(IDX-LST))
                   MOVE    IDX-LST    TO  SPA-GMN-W20-SELNUM
                   MOVE    IDX-LST    TO  SPA-GMN-W20-RIREKILST-SEL
               END-IF
      *
               PERFORM 900-SYSKANRI-KEY8-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key8"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
           .
      *
      *
       4100-RIREKI-AREA-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    入力情報領域初期化処理
      *****************************************************************
       4201-INPUT-AREA-CLEAR-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W20-INPUT-AREA
                       SPA-NAI-W20-INPUT-AREA
      *
           IF    ( SPA-MOTOPG      =   "W01" )
               MOVE    "病室"      TO  SPA-GMN-W20-B09
           END-IF
      *
      *    有効期間の開始日と終了日を設定
           MOVE    SPA-SYSYMDWH (1 : 6)
                                   TO  SPA-GMN-W20-YUKOSTYMD (1 : 6)
           MOVE    ". 1"           TO  SPA-GMN-W20-YUKOSTYMD (7 : 3)
           MOVE    SPA-SYSYMD   (1 : 6)
                                   TO  SPA-NAI-W20-YUKOSTYMD (1 : 6)
           MOVE    "01"            TO  SPA-NAI-W20-YUKOSTYMD (7 : 2)
      *
           MOVE    "99999999"      TO  SPA-GMN-W20-YUKOEDYMD
                                       SPA-NAI-W20-YUKOEDYMD
      *
           MOVE    1               TO  SPA-GMN-W20-CUR
      *
           .
      *
       4201-INPUT-AREA-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *   履歴情報領域初期化処理
      *****************************************************************
       4201-RIREKI-AREA-CLEAR-SEC      SECTION.
      *
           INITIALIZE  SPA-GMN-W20-RIREKILST
                       SPA-NAI-W20-RIREKILST
      *
           MOVE    ZERO        TO  SPA-GMN-W20-BTULST-SEL
      *
           .
       4201-RIREKI-AREA-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    システム管理情報再設定処理
      *****************************************************************
       4100-SYS-KANRI-SAI-SET-SEC      SECTION.
      *
      *    医療機関情報取得処理
           MOVE    SPA-NAI-W20-YUKOSTYMD
                                   TO  WRK-KJN-YUKSTYMD
           PERFORM 3101-GET-SYS1001-SEC
      *
      *    コンボ初期処理
           MOVE    SPA-NAI-W20-YUKOSTYMD
                                   TO  WRK-KJN-YUKSTYMD
           PERFORM 3101-CMB-SYOKI-SEC
      *
           .
      *
       4100-SYS-KANRI-SAI-SET-EXT.
           EXIT.
      *****************************************************************
      *    共通関連チェック
      *****************************************************************
       4900-KANRENCHK-SEC              SECTION.
      *
      *    病棟名称が入力されていること
           IF    ( SPA-GMN-W20-NAME    NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "1007"      TO  SPA-ERRCD
               MOVE    2           TO  SPA-GMN-W20-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    短縮病棟名が入力されていること
           IF    ( SPA-GMN-W20-TANNAME NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "1008"      TO  SPA-ERRCD
               MOVE    3           TO  SPA-GMN-W20-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    病院の場合、病院の種別が選択されていること
           IF    ( SPA-NAI-W20-HOSPSBT     =   1 )
               IF    ( SPA-GMN-W20-SBT     =   "01"
                                           OR  "02"
                                           OR  "03"
                                           OR  "04"
                                           OR  "05"
                                           OR  "06"
                                           OR  "07" )
                   CONTINUE
               ELSE
                   MOVE    "1106"      TO  SPA-ERRCD
                   MOVE    6           TO  SPA-GMN-W20-CUR
                   GO  TO  4900-KANRENCHK-EXT
               END-IF
           END-IF
      *
      *    診療所の場合、診療所の種別が選択されていること
           IF    ( SPA-NAI-W20-HOSPSBT     =   2 )
               IF    ( SPA-GMN-W20-SBT     =   "08"
                                           OR  "09" )
                   CONTINUE
               ELSE
                   MOVE    "1107"      TO  SPA-ERRCD
                   MOVE    6           TO  SPA-GMN-W20-CUR
                   GO  TO  4900-KANRENCHK-EXT
               END-IF
           END-IF
      *
      *    有効期間開始日が入力されていること
           IF    ( SPA-NAI-W20-YUKOSTYMD   NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "1102"      TO  SPA-ERRCD
               MOVE    12          TO  SPA-GMN-W20-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    有効期間終了日が入力されていること
           IF    ( SPA-NAI-W20-YUKOEDYMD   NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "1103"      TO  SPA-ERRCD
               MOVE    13          TO  SPA-GMN-W20-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    有効期間開始日≦有効期間終了日となっていること
           IF    ( SPA-NAI-W20-YUKOSTYMD   <=  SPA-NAI-W20-YUKOEDYMD )
               CONTINUE
           ELSE
               MOVE    "1004"      TO  SPA-ERRCD
               MOVE    12          TO  SPA-GMN-W20-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    有効期間終了日が過去日付でないこと
           IF    ( SPA-NAI-W20-YUKOEDYMD   >=  SPA-SYSYMD  )
               CONTINUE
           ELSE
               MOVE    "1005"      TO  SPA-ERRCD
               MOVE    13          TO  SPA-GMN-W20-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    特定入院料が設定されていない場合病棟ごとに必須項目を
      *    チェックする
           IF    ( SPA-GMN-W20-TOKNYUIN-G      =   SPACE )
      *
      *        病棟種別が設定されていること
               IF    ( SPA-GMN-W20-SBT     NOT =   SPACE )
                   CONTINUE
               ELSE
                   MOVE    "1009"  TO  SPA-ERRCD
                   MOVE    6       TO  SPA-GMN-W20-CUR
                   GO  TO  4900-KANRENCHK-EXT
               END-IF
      *
      *        入院基本料が算定されていること
               IF    ( SPA-GMN-W20-KHNRYO  NOT =   SPACE )
                   CONTINUE
               ELSE
                   MOVE    "1014"  TO  SPA-ERRCD
                   GO  TO  4900-KANRENCHK-EXT
               END-IF
           END-IF
      *
           .
      *
       4900-KANRENCHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟番号検索処理
      *****************************************************************
       4100-BTUNUM-LSTSEL-SEC         SECTION.
      *
           MOVE    ZERO                TO  IDX-BTULST
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX-BTULST  >   ZERO )
                OR       ( IDX1        >   SPA-GMN-W20-BTULST-MAX )
      *
      *
               IF    ( SPA-GMN-W20-BTUNUM
                                       =   SPA-GMN-W20-TBTUNUM (IDX1) )
                   MOVE    IDX1    TO  IDX-BTULST
               END-IF
      *
           END-PERFORM
      *
           .
      *
       4100-BTUNUM-LSTSEL-EXT.
           EXIT.
      *****************************************************************
      *    特定入院料コンボチェック処理
      *****************************************************************
       4200-TOKNYUINLST-CHK-SEC        SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-W20-TOKNYUIN-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-GMN-W20-TOKNYUINL (IDX-CMB)
                                       =   WRK-CMB-CD )
                   MOVE    SPA-GMN-W20-TOKNYUINLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
                   MOVE    SPA-NAI-W20-TOKNYUINLST (IDX-CMB)
                                       TO  WRK-CMB-ITM2
               END-IF
      *
           END-PERFORM
      *
           .
       4200-TOKUTEINYUINLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    診療科コードコンボチェック処理
      *****************************************************************
       4200-SRYKALST-CHK-SEC           SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-W20-SRYKA-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-GMN-W20-SRYKAL (IDX-CMB)
                                       =   WRK-CMB-CD )
                   MOVE    SPA-GMN-W20-SRYKALST (IDX-CMB)
                                       TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       4200-SRYKALST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟種別コンボチェック処理
      *****************************************************************
       4200-SBTLST-CHK-SEC             SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-W20-SBT-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-GMN-W20-SBTL (IDX-CMB)
                                       =   WRK-CMB-CD )
                   MOVE    SPA-GMN-W20-SBTLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       4200-SBTLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    看護補助加算コンボチェック処理
      *****************************************************************
       4200-KNGHJOKSNLST-CHK-SEC       SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-W20-KNGHJOKSN-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-GMN-W20-KNGHJOKSNL (IDX-CMB)
                                       =   WRK-CMB-CD )
                   MOVE    SPA-GMN-W20-KNGHJOKSNLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       4200-KNGHJOKSNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    夜間勤務等看護加算コンボチェック処理
      *****************************************************************
       4200-YAKANKNGKSNLST-CHK-SEC         SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-W20-YKNKNGKSN-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-GMN-W20-YKNKNGKSNL (IDX-CMB)
                                       =   WRK-CMB-CD )
                   MOVE    SPA-GMN-W20-YKNKNGKSNLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       4200-YAKANKNGKSNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    レセプト表示区分コンボチェック処理
      *****************************************************************
       4200-RECEDSPKBNLST-CHK-SEC      SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-W20-RECEDSPKBN-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-GMN-W20-RECEDSPKBNL (IDX-CMB)
                                       =   WRK-CMB-CD )
                   MOVE    SPA-GMN-W20-RECEDSPKBNLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
                   MOVE    SPA-NAI-W20-RECEDSPKBNLST (IDX-CMB)
                                       TO  WRK-CMB-ITM2
               END-IF
      *
           END-PERFORM
      *
           .
       4200-RECEDSPKBNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    レセプト表示区分コンボチェック処理
      *****************************************************************
       4201-RECEDSPKBNLST-CHK-SEC      SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-W20-RECEDSPKBN-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-NAI-W20-RECEDSPKBNLST (IDX-CMB)
                                       =   WRK-CMB-CD )
                   MOVE    SPA-GMN-W20-RECEDSPKBNLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
                   MOVE    SPA-NAI-W20-RECEDSPKBNLST (IDX-CMB)
                                       TO  WRK-CMB-ITM2
               END-IF
      *
           END-PERFORM
      *
           .
       4201-RECEDSPKBNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    終了区分区分コンボチェック処理
      *****************************************************************
       4200-EDKBNLST-CHK-SEC           SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-W20-EDKBN-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-GMN-W20-EDKBNL (IDX-CMB)
                                       =   WRK-CMB-CD )
                   MOVE    SPA-GMN-W20-EDKBNLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       4200-EDKBNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    基本料コンボチェック処理
      *****************************************************************
       4200-KHNRYOLST-CHK-SEC          SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-W20-KHNRYO-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-GMN-W20-KHNRYOL (IDX-CMB)
                                       =   WRK-CMB-CD )
      *
                   MOVE    SPA-GMN-W20-KHNRYOLST   (IDX-CMB)
                                   TO  WRK-CMB-ITM
      *
                   MOVE    SPA-NAI-W20-KHNSRYCDLST (IDX-CMB)
                                   TO  WRK-CMB-ITM2
      *
                   MOVE    SPA-NAI-W20-KHNTENLST   (IDX-CMB)
                                   TO  WRK-CMB-ITM3
               END-IF
      *
           END-PERFORM
      *
           .
       4200-KHNRYOLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    基本料コンボチェック処理
      *****************************************************************
       4201-KHNRYOLST-CHK-SEC          SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-W20-KHNRYO-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-NAI-W20-KHNSRYCDLST (IDX-CMB)
                                       =   WRK-CMB-CD )
      *
                   MOVE    SPA-GMN-W20-KHNRYOLST   (IDX-CMB)
                                   TO  WRK-CMB-ITM
      *
                   MOVE    SPA-NAI-W20-KHNSRYCDLST (IDX-CMB)
                                   TO  WRK-CMB-ITM2
      *
                   MOVE    SPA-NAI-W20-KHNTENLST   (IDX-CMB)
                                   TO  WRK-CMB-ITM3
               END-IF
      *
           END-PERFORM
      *
           .
       4201-KHNRYOLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN                  SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF    ( SPA-ERRCD       NOT =   SPACE )
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF    ( SPA-WIDCD       NOT =   SPACE )
               PERFORM 520-WIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "W20    "           TO  MCP-WINDOW.
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
           MOVE    W20-BTULST-ROW          TO  WRK-BTULST-ROW
      *
           INITIALIZE                          W20
      *
      *    病室ボタン
           MOVE    SPA-GMN-W20-B09         TO  W20-B09
      *
      *    病棟番号
           MOVE    SPA-GMN-W20-BTUNUM      TO  W20-BTUNUM
      *
      *    病棟名称
           MOVE    SPA-GMN-W20-NAME        TO  W20-NAME
      *
      *    短縮病棟名
           MOVE    SPA-GMN-W20-TANNAME     TO  W20-TANNAME
      *
      *    特定入院料コンボ
           MOVE    SPA-GMN-W20-TOKNYUIN-G  TO  W20-TOKUTEINYUIN
           MOVE    SPA-GMN-W20-TOKNYUIN-MAX
                                           TO  W20-TOKUTEINYUIN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   W20-TOKUTEINYUIN-CNT )
                MOVE   SPA-GMN-W20-TOKNYUINLST (IDX1)
                                   TO  W20-TOKUTEINYUIN-ITM (IDX1)
           END-PERFORM
      *
      *    病棟科名コンボ
           MOVE    SPA-GMN-W20-SRYKA-G     TO  W20-SRYKA
           MOVE    SPA-GMN-W20-SRYKA-MAX   TO  W20-SRYKA-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   W20-SRYKA-CNT )
                MOVE   SPA-GMN-W20-SRYKALST (IDX1)
                                   TO  W20-SRYKA-ITM (IDX1)
           END-PERFORM
      *
      *    病棟種別コンボ
           MOVE    SPA-GMN-W20-SBT-G   TO  W20-SBT
           MOVE    SPA-GMN-W20-SBT-MAX TO  W20-SBT-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-SBT-CNT )
                MOVE   SPA-GMN-W20-SBTLST (IDX1)
                                   TO  W20-SBT-ITM (IDX1)
           END-PERFORM
      *
      *    看護補助加算コンボ
           MOVE    SPA-GMN-W20-KNGHJOKSN-G
                                       TO  W20-KNGHJOKSN
           MOVE    SPA-GMN-W20-KNGHJOKSN-MAX
                                       TO  W20-KNGHJOKSN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-KNGHJOKSN-CNT )
                MOVE   SPA-GMN-W20-KNGHJOKSNLST (IDX1)
                                   TO  W20-KNGHJOKSN-ITM (IDX1)
           END-PERFORM
      *
      *    夜間勤務看護加算コンボ
           MOVE    SPA-GMN-W20-YKNKNGKSN-G
                                       TO  W20-YAKANKNGKSN
           MOVE    SPA-GMN-W20-YKNKNGKSN-MAX
                                       TO  W20-YKNKNGKSN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-YKNKNGKSN-CNT )
                MOVE   SPA-GMN-W20-YKNKNGKSNLST (IDX1)
                                   TO  W20-YKNKNGKSN-ITM (IDX1)
           END-PERFORM
      *
      *    食堂加算区分
           MOVE    SPA-GMN-W20-CHK-SYOKUDOKBN
                                       TO  W20-CHK-SYOKUDOKBN
      *
      *    保育士人数
           MOVE    SPA-GMN-W20-CHK-HIKSIS
                                       TO  W20-CHK-HIKSISUKBN
      *
      *    レセプト表示区分
           MOVE    SPA-GMN-W20-RECEDSPKBN-G    TO  W20-RECEDSPKBN
           MOVE    SPA-GMN-W20-RECEDSPKBN-MAX
                                       TO  W20-RECEDSPKBN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-RECEDSPKBN-CNT )
                MOVE   SPA-GMN-W20-RECEDSPKBNLST (IDX1)
                                   TO  W20-RECEDSPKBN-ITM (IDX1)
           END-PERFORM
      *
      *    有効期間開始日
           MOVE    SPA-GMN-W20-YUKOSTYMD   TO  W20-YUKOSTYMD
      *
      *    有効期間終了日
           MOVE    SPA-GMN-W20-YUKOEDYMD   TO  W20-YUKOEDYMD
      *
      *    病棟終了区分
           MOVE    SPA-GMN-W20-EDKBN-G     TO  W20-EDKBN
           MOVE    SPA-GMN-W20-EDKBN-MAX   TO  W20-EDKBN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   W20-EDKBN-CNT )
                MOVE   SPA-GMN-W20-EDKBNLST (IDX1)
                                   TO  W20-EDKBN-ITM (IDX1)
           END-PERFORM
      *
      *    入院基本料コンボ
           MOVE    SPA-GMN-W20-KHNRYO-G    TO  W20-KHNRYO
           MOVE    SPA-GMN-W20-KHNRYO-MAX  TO  W20-KHNRYO-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-KHNRYO-CNT )
                MOVE   SPA-GMN-W20-KHNRYOLST (IDX1)
                                   TO  W20-KHNRYO-ITM (IDX1)
           END-PERFORM
      *
      *    入院基本点数
           MOVE    SPA-NAI-W20-KHNTEN      TO  W20-KHNTEN
      *
      *    選択番号
           MOVE    SPA-GMN-W20-SELNUM      TO  W20-SELNUM
      *
      *    病棟リスト
           MOVE    SPA-GMN-W20-BTULST-MAX  TO  W20-BTULST-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   W20-BTULST-CNT )
      *
      *        病棟番号
               MOVE    SPA-GMN-W20-TBTUNUM (IDX1)
                                       TO  WRK-ZZZ9
               MOVE    WRK-ZZZ9        TO  W20-TBTUNUM (IDX1)
      *
      *        病棟名称
               MOVE    SPA-GMN-W20-TNAME (IDX1)
                                       TO  W20-TNAME (IDX1)
      *
      *        病棟種別
               MOVE    SPA-GMN-W20-TSBT (IDX1)
                                       TO  W20-TSBT (IDX1)
      *
      *        特定入院料
               MOVE    SPA-GMN-W20-TTOKNYUIN (IDX1)
                                       TO  W20-TTOKUTEINYUIN (IDX1)
      *
      *        病棟科名
               MOVE    SPA-GMN-W20-TSRYKA (IDX1)
                                       TO  W20-TSRYKA (IDX1)
      *
      *        入院基本料
               MOVE    SPA-GMN-W20-TKHNRYO (IDX1)
                                       TO  W20-TKHNRYO (IDX1)
      *
      *        入院基本点数
               MOVE    SPA-GMN-W20-TKHNTEN (IDX1)
                                       TO  W20-TKHNTEN (IDX1)
      *
      *        収容人数
               MOVE    SPA-GMN-W20-TNINZU (IDX1)
                                       TO  WRK-ZZZZZZZZZ9
               MOVE    WRK-ZZZZZZZZZ9
                                       TO  W20-TNINZU (IDX1)
      *
      *        有効期間開始日
               MOVE    SPA-GMN-W20-TYUKOSTYMD (IDX1)
                                       TO  W20-TYUKOSTYMD (IDX1)
      *
      *        有効期間終了日
               MOVE    SPA-GMN-W20-TYUKOEDYMD (IDX1)
                                       TO  W20-TYUKOEDYMD (IDX1)
      *
               IF    ( SPA-GMN-W20-BTULST-SEL  =   IDX1 )
                   MOVE    "T"         TO  W20-BTULST-SEL (IDX1)
               ELSE
                   MOVE    "F"         TO  W20-BTULST-SEL (IDX1)
               END-IF
      *
           END-PERFORM
      *
      *    履歴リスト
           MOVE    SPA-GMN-W20-RIREKILST-MAX
                                       TO  W20-RIREKILST-CNT
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-RIREKILST-CNT )
      *
               MOVE    SPA-GMN-W20-TRSELNUM (IDX1)
                                       TO  WRK-ZZZ9
               MOVE    WRK-ZZZ9        TO  W20-TSELNUM (IDX1)
      *
               STRING  SPA-GMN-W20-TRYUKOSTYMD (IDX1)
                       " 〜 "
                       SPA-GMN-W20-TRYUKOEDYMD (IDX1)
                       DELIMITED   BY  SIZE
               INTO    W20-TRIREKI (IDX1)
               END-STRING
      *
               IF    ( IDX1    =   SPA-GMN-W20-RIREKILST-SEL )
                   MOVE    "T"         TO  W20-RIREKILST-SEL (IDX1)
               ELSE
                   MOVE    "F"         TO  W20-RIREKILST-SEL (IDX1)
               END-IF
      *
           END-PERFORM
      *
           MOVE    "食堂加算"          TO  W20-CHK-SYOKUDOKBN-LBL
      *
           EVALUATE    FLG-BTULST-ROW
           WHEN    1
               MOVE    ZERO               TO  W20-BTULST-ROW
               MOVE    ZERO               TO  W20-BTULST-ROWATTR
           WHEN    2
               MOVE    W20-BTULST-CNT     TO  W20-BTULST-ROW
               MOVE    1                  TO  W20-BTULST-ROWATTR
           WHEN    OTHER
               MOVE    WRK-BTULST-ROW     TO  W20-BTULST-ROW
               MOVE    ZERO               TO  W20-BTULST-ROWATTR
           END-EVALUATE
      *
      *    項目状態編集
           PERFORM 500-EDIT-GMNHEN-STATE-SEC
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
       500-EDIT-GMNHEN-STATE-SEC       SECTION.
      *
           IF    ( SPA-NAI-W20-YUKOEDYMD-OLD   NOT =  SPACE )
            AND  ( SPA-NAI-W20-YUKOEDYMD-OLD       <  SPA-SYSYMD )
               MOVE    WIDGET-INSENSITIVE   TO WRK-STATE
           ELSE
               MOVE    WIDGET-NORMAL        TO WRK-STATE
           END-IF
      *
           MOVE    WRK-STATE       TO  W20-B02-STATE
                                       W20-B05-STATE
                                       W20-B06-STATE
                                       W20-B07-STATE
                                       W20-B08-STATE
                                       W20-B09-STATE
                                       W20-B12-STATE
                                       W20-NAME-STATE
                                       W20-TANNAME-STATE
                                       W20-TOKUTEINYUIN-STATE
                                       W20-TOKUTEINYUIN-ITM-STATE
                                       W20-SRYKA-STATE
                                       W20-SRYKA-ITM-STATE
                                       W20-SBT-STATE
                                       W20-SBT-ITM-STATE
                                       W20-KNGHJOKSN-STATE
                                       W20-KNGHJOKSN-ITM-STATE
                                       W20-YAKANKNGKSN-STATE
                                       W20-YKNKNGKSN-ITM-STATE
                                       W20-CHK-SYOKUDOKBN-STATE
                                       W20-CHK-HIKSISUKBN-STATE
                                       W20-RECEDSPKBN-STATE
                                       W20-RECEDSPKBN-ITM-STATE
                                       W20-YUKOSTYMD-STATE
                                       W20-YUKOEDYMD-STATE
                                       W20-EDKBN-STATE
                                       W20-EDKBN-ITM-STATE
                                       W20-KHNRYO-STATE
                                       W20-KHNRYO-ITM-STATE
                                       W20-KHNTEN-STATE
      *
      *    療養・老人・有床・有床療養は看護補助配置を入力不可とする
           IF    ( SPA-GMN-W20-SBT     =   "04" OR "07" 
                                        OR "08" OR "09" )
               MOVE    WIDGET-INSENSITIVE
                                       TO  W20-KNGHJOKSN-STATE
                                           W20-KNGHJOKSN-ITM-STATE
           END-IF
      *
           IF    ( SPA-GMN-W20-TOKNYUIN
                                       =   "01" OR "02" )
               CONTINUE
           ELSE
               MOVE    WIDGET-INSENSITIVE
                                       TO  W20-CHK-HIKSISUKBN-STATE
           END-IF
      *
           IF    ( SPA-GMN-W20-BTULST-MAX >=   CONST-BTULST-MAX )
               MOVE    WIDGET-INSENSITIVE
                                       TO  W20-B06-STATE
           END-IF
      *
           IF    ( SPA-NAI-W20-YUKOSTYMD  >=   CONST-H180401 )
               IF    ( SPA-GMN-W20-SBT NOT =   "04" )
                   MOVE    WIDGET-INSENSITIVE
                                       TO  W20-YAKANKNGKSN-STATE
                                           W20-YKNKNGKSN-ITM-STATE
               END-IF
           END-IF
      *
           .
       500-EDIT-GMNHEN-STATE-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
           IF     (SPA-ERRCD           =   SPACE)  AND
                  (SPA-GMN-W20-CUR     =   ZERO )
               PERFORM 5011-INPUT-CUR-SEC
           END-IF
      *
           PERFORM 5012-SKIP-CUR-SEC
      *
           EVALUATE    SPA-GMN-W20-CUR
           WHEN    001
               MOVE    "BTUNUM"            TO  MCP-WIDGET
           WHEN    002
               MOVE    "NAME"              TO  MCP-WIDGET
           WHEN    003
               MOVE    "TANNAME"           TO  MCP-WIDGET
           WHEN    004
               MOVE    "TOKUTEINYUIN"      TO  MCP-WIDGET
           WHEN    005
               MOVE    "SRYKA"             TO  MCP-WIDGET
           WHEN    006
               MOVE    "SBT"               TO  MCP-WIDGET
           WHEN    007
               MOVE    "KNGHJOKSN"         TO  MCP-WIDGET
           WHEN    008
               MOVE    "YAKANKNGKSN"       TO  MCP-WIDGET
           WHEN    009
               MOVE    "CHK_SYOKUDOKBN"    TO  MCP-WIDGET
           WHEN    010
               MOVE    "CHK_HIKSISUKBN"    TO  MCP-WIDGET
           WHEN    011
               MOVE    "RECEDSPKBN"        TO  MCP-WIDGET
           WHEN    012
               MOVE    "YUKOSTYMD"         TO  MCP-WIDGET
           WHEN    013
               MOVE    "YUKOEDYMD"         TO  MCP-WIDGET
           WHEN    014
               MOVE    "EDKBN"             TO  MCP-WIDGET
           WHEN    015
               MOVE    "KHNRYO"            TO  MCP-WIDGET
           WHEN    100
               MOVE    "SELNUM"            TO  MCP-WIDGET
           WHEN    206
               MOVE    "B06"               TO  MCP-WIDGET
           WHEN    207
               MOVE    "B07"               TO  MCP-WIDGET
           WHEN    208
               MOVE    "B08"               TO  MCP-WIDGET
           WHEN    209
               MOVE    "B09"               TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソルスキップ処理
      *****************************************************************
       5012-SKIP-CUR-SEC           SECTION.
      *
           IF    ( SPA-NAI-W20-YUKOEDYMD-OLD   NOT =  SPACE )
            AND  ( SPA-NAI-W20-YUKOEDYMD-OLD       <  SPA-SYSYMD )
                   MOVE    100         TO  SPA-GMN-W20-CUR
           END-IF
      *
           IF    ( SPA-GMN-W20-CUR     =   7 )
               IF    ( W20-KNGHJOKSN-STATE
                                       =   WIDGET-INSENSITIVE )
                   MOVE    8           TO  SPA-GMN-W20-CUR
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W20-CUR     =   8 )
               IF    ( W20-YAKANKNGKSN-STATE
                                       =   WIDGET-INSENSITIVE )
                   MOVE    9           TO  SPA-GMN-W20-CUR
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W20-CUR     =   9 )
               IF    ( W20-CHK-SYOKUDOKBN-STATE
                                       =   WIDGET-INSENSITIVE )
                   MOVE    10          TO  SPA-GMN-W20-CUR
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W20-CUR     =   10 )
               IF    ( W20-CHK-HIKSISUKBN-STATE
                                       =   WIDGET-INSENSITIVE )
                   MOVE    11          TO  SPA-GMN-W20-CUR
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W20-CUR     =   206 )
               IF    ( W20-B06-STATE   =   WIDGET-INSENSITIVE )
                   MOVE    207         TO  SPA-GMN-W20-CUR
               END-IF
           END-IF
      *
           .
       5012-SKIP-CUR-EXT.
           EXIT.
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       5011-INPUT-CUR-SEC          SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "BTUNUM"
               MOVE    002             TO  SPA-GMN-W20-CUR
           WHEN    "NAME"
               MOVE    003             TO  SPA-GMN-W20-CUR
           WHEN    "TANNAME"
               MOVE    004             TO  SPA-GMN-W20-CUR
           WHEN    "TOKUTEINYUIN"
               MOVE    005             TO  SPA-GMN-W20-CUR
           WHEN    "SRYKA"
               MOVE    006             TO  SPA-GMN-W20-CUR
           WHEN    "SBT"
               MOVE    015             TO  SPA-GMN-W20-CUR
           WHEN    "KNGHJOKSN"
               MOVE    008             TO  SPA-GMN-W20-CUR
           WHEN    "YAKANKNGKSN"
               MOVE    009             TO  SPA-GMN-W20-CUR
           WHEN    "CHK_SYOKUDOKBN"
               MOVE    010             TO  SPA-GMN-W20-CUR
           WHEN    "CHK_HIKSISUKBN"
               MOVE    011             TO  SPA-GMN-W20-CUR
           WHEN    "RECEDSPKBN"
               MOVE    012             TO  SPA-GMN-W20-CUR
           WHEN    "YUKOSTYMD"
               MOVE    013             TO  SPA-GMN-W20-CUR
           WHEN    "YUKOEDYMD"
               MOVE    014             TO  SPA-GMN-W20-CUR
           WHEN    "EDKBN"
               MOVE    206             TO  SPA-GMN-W20-CUR
           WHEN    "KHNRYO"
               MOVE    007             TO  SPA-GMN-W20-CUR
           WHEN    "SELNUM"
               MOVE    002             TO  SPA-GMN-W20-CUR
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
               MOVE    "全角文字でのみ入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "0003"
               MOVE    SPACE           TO  SPA-ERRMSG
               STRING  "有効期間開始日は平成１４年４月１日以降にして"
                       "ください"
                       DELIMITED   BY  SIZE
               INTO    SPA-ERRMSG
               END-STRING
           WHEN    "0004"
                   MOVE    "特定入院料入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0005"
                   MOVE    "診療科入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0006"
                   MOVE    "病棟種別入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0007"
                   MOVE    "看護補助加算入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0008"
                   MOVE    "夜間勤務等看護加算入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0009"
                   MOVE    "レセプト表示区分入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0010"
                   MOVE    "有効開始日入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0011"
                   MOVE    "有効終了日入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0012"
                   MOVE    "入院基本料入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0013"
                   MOVE    "選択番号入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "1001"
               MOVE    "追加可能最大件数に達しました"
                                       TO  SPA-ERRMSG
           WHEN    "1002"
               MOVE    "変更対象の病棟は存在しません"
                                       TO  SPA-ERRMSG
           WHEN    "1003"
               MOVE    "削除対象の病棟は存在しません"
                                       TO  SPA-ERRMSG
           WHEN    "1004"
               MOVE    "有効期間開始日＞有効期間終了日となっています"
                                       TO  SPA-ERRMSG
           WHEN    "1005"
               MOVE    SPACE           TO  SPA-ERRMSG
               STRING  "有効期間終了日が過去日となるデータの"
                       "追加・変更は行えません"
                       DELIMITED   BY  SIZE
               INTO    SPA-ERRMSG
               END-STRING
           WHEN    "1006"
               MOVE    SPACE           TO  SPA-ERRMSG
               STRING  "病棟の有効期間内に病室管理情報が存在するため"
                       "削除できません"
                       DELIMITED   BY  SIZE
               INTO    SPA-ERRMSG
               END-STRING
           WHEN    "1007"
               MOVE    "病棟名称を入力して下さい"
                                       TO  SPA-ERRMSG
           WHEN    "1008"
               MOVE    "短縮病棟名を入力して下さい"
                                       TO  SPA-ERRMSG
           WHEN    "1009"
               MOVE    "病棟種別を入力して下さい"
                                       TO  SPA-ERRMSG
           WHEN    "1014"
               MOVE    "入院基本料が算定されていません"
                                       TO  SPA-ERRMSG
           WHEN    "1101"
               MOVE     "病棟番号を入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "1102"
               MOVE     "有効期間開始日を入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "1103"
               MOVE     "有効期間終了日を入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "1104"
               MOVE    "有効期間の重複するデータが存在します"
                                       TO  SPA-ERRMSG
           WHEN    "1105"
               MOVE    "有効期間の開始日と終了日は同時に変更できません"
                                       TO  SPA-ERRMSG
           WHEN    "1106"
               MOVE    "病院の病棟種別を選択してください"
                                       TO  SPA-ERRMSG
           WHEN    "1107"
               MOVE    "診療所の病棟種別を選択してください"
                                       TO  SPA-ERRMSG
           WHEN    "1201"
               MOVE    "更新できませんでした"
                                       TO  SPA-ERRMSG
           WHEN    "1202"
               MOVE    "追加できませんでした"
                                       TO  SPA-ERRMSG
           WHEN    "1203"
               MOVE    "削除できませんでした"
                                       TO  SPA-ERRMSG
           WHEN    "1204"
               MOVE    "病室管理情報の更新に失敗しました"
                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPA-MOTOPG          TO  SPA-GMN-W20-MOTOPG
      *
           MOVE    SPACE               TO  WERR
           MOVE    SPA-ERRCD           TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  WERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "W20"               TO  SPA-MOTOPG
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
           WHEN    "2001"
               MOVE    "該当の病棟を削除します。よろしいですか"
                                        TO  WRK-WIDMSG
           END-EVALUATE
      *
      *
           MOVE    SPA-MOTOPG           TO  SPA-GMN-W20-MOTOPG
      *
           MOVE    SPACE                TO  WID1
           MOVE    SPA-WIDCD            TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG           TO  WID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "W20"                TO  SPA-MOTOPG
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
      *    全角半角混在チェック
      *****************************************************************
       800-ENRTRY-CHK-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-ENTRYCHK
      *
           MOVE    SPACE           TO  WRK-KANACHK-OUT-INPUT
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
           MOVE    KANACHK-OUT-INPUT
                                   TO  WRK-KANACHK-OUT-INPUT
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
      *    西暦日本語変換処理
      *****************************************************************
       800-SEIWA-HEN-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-HIZUKE-ERR
           MOVE    SPACE               TO  WRK-SYMD
                                           WRK-HENYMDG
      *
           IF    ( WRK-YMD         =   "00000000" 
                                   OR  "99999999" )
               MOVE    WRK-YMD     TO  WRK-HENYMDG
                                       WRK-SYMD
               GO  TO  800-SEIWA-HEN-EXT
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
               MOVE    1               TO  FLG-HIZUKE-ERR
           END-IF
      *
           .
       800-SEIWA-HEN-EXT.
           EXIT.
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
      *    システム管理検索処理(KEY10)
      *****************************************************************
       900-SYSKANRI-KEY10-SEL-SEC      SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
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
      *    システム管理検索処理(KEY2)
      *****************************************************************
       900-SYSKANRI-KEY2-SEL-SEC       SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SYSKANRI-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
               INITIALIZE              SYSKANRI-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY2-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理FETCH処理(KEY2)
      *****************************************************************
       900-SYSKANRI-KEY2-FET-SEC       SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SYSKANRI-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
               INITIALIZE              SYSKANRI-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY2-FET-EXT.
           EXIT.
      *****************************************************************
      *    システム管理検索処理(KEY)
      *****************************************************************
       900-SYSKANRI-KEY-SEL-SEC        SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SYSKANRI-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
               INITIALIZE              SYSKANRI-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理FETCH処理(KEY)
      *****************************************************************
       900-SYSKANRI-KEY-FET-SEC        SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SYSKANRI-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
               INITIALIZE              SYSKANRI-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY-FET-EXT.
           EXIT.
      *****************************************************************
      *    システム管理検索処理(KEY7)
      *****************************************************************
       900-SYSKANRI-KEY7-SEL-SEC       SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key7"          TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SYSKANRI-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
               INITIALIZE              SYSKANRI-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY7-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理FETCH処理(KEY7)
      *****************************************************************
       900-SYSKANRI-KEY7-FET-SEC       SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key7"          TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SYSKANRI-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
               INITIALIZE              SYSKANRI-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY7-FET-EXT.
           EXIT.
      *****************************************************************
      *    システム管理検索処理(KEY8)
      *****************************************************************
       900-SYSKANRI-KEY8-SEL-SEC       SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           INITIALIZE                      SYS-5001-REC
           MOVE    "5001"              TO  SYS-5001-KANRICD
           MOVE    SPA-GMN-W20-BTUNUM  TO  SYS-5001-KBNCD
           MOVE    SYS-5001-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key8"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-5001-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
               INITIALIZE              SYS-5001-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY8-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理FETCH処理(KEY8)
      *****************************************************************
       900-SYSKANRI-KEY8-FET-SEC       SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key8"          TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-5001-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
               INITIALIZE              SYS-5001-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY8-FET-EXT.
           EXIT.
      *****************************************************************
      *    システム管理検索処理(KEY4)
      *****************************************************************
       900-SYSKANRI-KEY4-SEL-SEC       SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           INITIALIZE                      SYS-5002-REC
           MOVE    "5002"              TO  SYS-5002-KANRICD
           MOVE    SPA-GMN-W20-BTUNUM  TO  SYS-5002-KBNCD
           MOVE    "%"                 TO  SYS-5002-KBNCD (3:1)
           MOVE    SYS-5002-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-5002-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
               INITIALIZE              SYS-5002-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY4-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理FETCH処理(KEY4)
      *****************************************************************
       900-SYSKANRI-KEY4-FET-SEC       SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key4"          TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-5002-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
               INITIALIZE              SYS-5002-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY4-FET-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索処理
      *****************************************************************
       900-TENSU-SEL-SEC               SECTION.
      *
           MOVE    ZERO            TO  FLG-TENSU
      *
           INITIALIZE                  TNS-TENSU-REC
      *
           IF    ( SPA-NAI-W20-YUKOSTYMD  >=   CONST-H180401 )
               PERFORM 9002-EDIT-TENSU-PATH-SEC
           ELSE
               PERFORM 9001-EDIT-TENSU-PATH-SEC
           END-IF
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    WRK-PATHNAME        TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC      =   ZERO )
               MOVE    MCPDATA-REC TO  TNS-TENSU-REC
           ELSE
               MOVE    1           TO  FLG-TENSU
               INITIALIZE              TNS-TENSU-REC
           END-IF
      *
           .
      *
       900-TENSU-SEL-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索パス編集処理（平成１７年度まで）
      *****************************************************************
       9001-EDIT-TENSU-PATH-SEC         SECTION.
      *
           IF    ( SPA-GMN-W20-SBT =   "07" )
               MOVE    "-"         TO  TNS-CDKBN-KBN
           ELSE
               MOVE    "A"         TO  TNS-CDKBN-KBN
           END-IF
      *
      *    区分番号設定処理
           PERFORM 9001-CDKBNNUM-SET-SEC
           MOVE    WRK-CDKBNNUM    TO  TNS-CDKBN-KBNNUM
           MOVE    WRK-CDKOUBAN    TO  TNS-CDKBN-KOUBAN
           MOVE    WRK-TK-CDKBNNUM TO  TNSXX-TK-CDKBN-KBNNUM
           MOVE    WRK-TK-CDKOUBAN TO  TNSXX-TK-CDKBN-KOUBAN
      *
           MOVE    SPA-NAI-W20-YUKOSTYMD
                                   TO  TNS-YUKOSTYMD
                                       TNS-YUKOEDYMD
      *
      *    点数マスタ検索
           EVALUATE    SPA-GMN-W20-SBT
           WHEN    "01"
           WHEN    "02"
           WHEN    "03"
               MOVE    "key15"     TO  WRK-PATHNAME
           WHEN    "07"
               MOVE    "key14"     TO  WRK-PATHNAME
           WHEN    OTHER
               MOVE    "key13"     TO  WRK-PATHNAME
           END-EVALUATE
      *
           .
       9001-EDIT-TENSU-PATH-EXT.
           EXIT.
      *****************************************************************
      *    区分番号設定処理（平成１７年度まで）
      *****************************************************************
       9001-CDKBNNUM-SET-SEC           SECTION.
      *
           INITIALIZE                  WRK-CDKBNNUM
                                       WRK-CDKOUBAN
                                       WRK-TK-CDKBNNUM
                                       WRK-TK-CDKOUBAN
      *
           EVALUATE    SPA-GMN-W20-SBT
      *    一般病棟
           WHEN    "01"
               MOVE    104             TO  WRK-TK-CDKBNNUM
               MOVE    1               TO  WRK-TK-CDKOUBAN
               MOVE    100             TO  WRK-CDKBNNUM
      *    精神病棟
           WHEN    "02"
               MOVE    104             TO  WRK-TK-CDKBNNUM
               MOVE    3               TO  WRK-TK-CDKOUBAN
               MOVE    103             TO  WRK-CDKBNNUM
      *    結核病棟
           WHEN    "03"
               MOVE    104             TO  WRK-TK-CDKBNNUM
               MOVE    2               TO  WRK-TK-CDKOUBAN
               MOVE    102             TO  WRK-CDKBNNUM
      *    療養病棟
           WHEN    "04"
               MOVE    101             TO  WRK-CDKBNNUM
      *    障害者施設
           WHEN    "05"
               MOVE    106             TO  WRK-CDKBNNUM
      *    専門病院
           WHEN    "06"
               MOVE    105             TO  WRK-CDKBNNUM
      *    老人病棟
           WHEN    "07"
               MOVE    ZERO            TO  WRK-CDKBNNUM
               MOVE    8               TO  WRK-CDKOUBAN
      *    有床診療所入院基本料
           WHEN    "08"
               MOVE    108             TO  WRK-CDKBNNUM
      *    有床診療所療養病床入院料
           WHEN    "09"
               MOVE    109             TO  WRK-CDKBNNUM
           END-EVALUATE
      *
           .
      *
       9001-CDKBNNUM-SET-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索パス編集処理（平成１８年度以降）
      *****************************************************************
       9002-EDIT-TENSU-PATH-SEC         SECTION.
      *
           MOVE    "A"             TO  TNS-CDKBN-KBN
      *
      *    区分番号設定処理
           PERFORM 9002-CDKBNNUM-SET-SEC
           MOVE    WRK-CDKBNNUM    TO  TNS-CDKBN-KBNNUM
           MOVE    WRK-CDKOUBAN    TO  TNS-CDKBN-KOUBAN
           MOVE    WRK-TK-CDKBNNUM TO  TNSXX-TK-CDKBN-KBNNUM
           MOVE    WRK-TK-CDKOUBAN TO  TNSXX-TK-CDKBN-KOUBAN
      *
           MOVE    SPA-NAI-W20-YUKOSTYMD
                                   TO  TNS-YUKOSTYMD
                                       TNS-YUKOEDYMD
      *
      *    点数マスタ検索
           MOVE    "key25"         TO  WRK-PATHNAME
      *
           .
       9002-EDIT-TENSU-PATH-EXT.
           EXIT.
      *****************************************************************
      *    区分番号設定処理（平成１８年度以降）
      *****************************************************************
       9002-CDKBNNUM-SET-SEC           SECTION.
      *
           INITIALIZE                  WRK-CDKBNNUM
                                       WRK-CDKOUBAN
                                       WRK-TK-CDKBNNUM
                                       WRK-TK-CDKOUBAN
      *
           EVALUATE    SPA-GMN-W20-SBT
      *    一般病棟
           WHEN    "01"
               MOVE    104             TO  WRK-TK-CDKBNNUM
               MOVE    1               TO  WRK-TK-CDKOUBAN
               MOVE    100             TO  WRK-CDKBNNUM
      *    精神病棟
           WHEN    "02"
               MOVE    104             TO  WRK-TK-CDKBNNUM
               MOVE    3               TO  WRK-TK-CDKOUBAN
               MOVE    103             TO  WRK-CDKBNNUM
      *    結核病棟
           WHEN    "03"
               MOVE    104             TO  WRK-TK-CDKBNNUM
               MOVE    2               TO  WRK-TK-CDKOUBAN
               MOVE    102             TO  WRK-CDKBNNUM
      *    療養病棟
           WHEN    "04"
               MOVE    101             TO  WRK-CDKBNNUM
      *    障害者施設
           WHEN    "05"
               MOVE    106             TO  WRK-CDKBNNUM
      *    専門病院
           WHEN    "06"
               MOVE    105             TO  WRK-CDKBNNUM
      *    有床診療所療養病床入院料
           WHEN    "09"
               MOVE    109             TO  WRK-CDKBNNUM
           END-EVALUATE
      *
           .
      *
       9002-CDKBNNUM-SET-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタFETCH処理
      *****************************************************************
       900-TENSU-FET-SEC               SECTION.
      *
           MOVE    ZERO            TO  FLG-TENSU
      *
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    WRK-PATHNAME        TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC      =   ZERO )
               MOVE    MCPDATA-REC TO  TNS-TENSU-REC
           ELSE
               MOVE    1           TO  FLG-TENSU
               INITIALIZE              TNS-TENSU-REC
           END-IF
      *
           .
      *
       900-TENSU-FET-EXT.
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
           MOVE    WRK-TNS-KJNYMD  TO  TNS-YUKOSTYMD
                                       TNS-YUKOEDYMD
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
      *    点数マスタクローズ
           MOVE    "tbl_tensu"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
      *
       900-TENSU-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHも行う)
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHは行わない)
      *****************************************************************
       911-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       911-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBCLOSECURSOR-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＤＥＬＥＴＥ処理
      *****************************************************************
       910-DBDELETE-SEC                 SECTION.
      *
           MOVE    "DBDELETE"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBDELETE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＩＮＳＥＲＴ処理
      *****************************************************************
       910-DBINSERT-SEC                SECTION.
      *
           MOVE    "DBINSERT"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBINSERT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＵＰＤＡＴＥ処理
      *****************************************************************
       910-DBUPDATE-SEC                SECTION.
      *
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBUPDATE-EXT.
           EXIT.
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"      TO  MCP-FUNC.
           CALL   "MONFUNC"        USING
                                   MCPAREA
                                   MCPDATA-REC.
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.

