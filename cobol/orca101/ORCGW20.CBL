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
           03  FLG-BTU-KHNRYO                      PIC 9(01).
           03  FLG-NYUKHN                          PIC 9(01).
           03  FLG-READ-SKIP                       PIC 9(01).
           03  FLG-DBRC                            PIC 9(01).
           03  FLG-INPUT-AREA                      PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                                PIC 9(05).
           03  IDX2                                PIC 9(05).
           03  IDX3                                PIC 9(05).
           03  IDX4                                PIC 9(05).
           03  IDX-BTULST                          PIC 9(05).
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
           03  WRK-BTU-NUM                         PIC 9(02).
           03  WRK-ZZZ9                            PIC ZZZ9.
           03  WRK-ZZZZZZZZZ9                      PIC Z(09)9.
           03  WRK-DBPATH                          PIC X(20).
           03  WRK-KANRICD                         PIC X(08).
           03  WRK-KANRI-AREA.
               05  WRK-KANRIDAT1                   PIC X(100).
               05  WRK-KANRIDAT2                   PIC X(100).
               05  WRK-KANRIIDX                    PIC 9(05).
           03  WRK-KIJUN-YMD                       PIC X(08).
           03  WRK-BTU-NINZU                       PIC 9(05).
           03  WRK-BTULST                          PIC 9(05).
           03  WRK-TNS-NAME                        PIC X(30).
           03  WRK-EDYUKYMD                        PIC X(08).
           03  WRK-CDKBNNUM                        PIC 9(03).
           03  WRK-CDKOUBAN                        PIC 9(02).
           03  WRK-TK-CDKBNNUM                     PIC 9(03).
           03  WRK-TK-CDKOUBAN                     PIC 9(02).
           03  WRK-SRYCD-KEY                       PIC X(09).
           03  WRK-99                              PIC 9(02).
           03  WRK-BTU-HEIZAIKBN.
               05  WRK-BTU-HEIZAIKBN-CD            PIC X(02).
               05                                  PIC X(01).
               05  WRK-BTU-HEIZAIKBN-NM            PIC X(13).
           03  WRK-BTU-KNGHAIKBN.
               05  WRK-BTU-KNGHAIKBN-CD            PIC X(02).
               05                                  PIC X(01).
               05  WRK-BTU-KNGHAIKBN-NM            PIC X(15).
           03  WRK-BTU-KNGHIRIT.
               05  WRK-BTU-KNGHIRIT-CD
                                                   PIC X(02).
               05                                  PIC X(01).
               05  WRK-BTU-KNGHIRIT-NM             PIC X(21).
           03  WRK-BTU-KNGHJOHAI.
               05  WRK-BTU-KNGHJOHAI-CD            PIC X(02).
               05                                  PIC X(01).
               05  WRK-BTU-KNGHJOHAI-NM            PIC X(11).
           03  WRK-BTULST-SEL-NUM                  PIC 9(02).
      *    入力項目名
           03  WRK-MCP-WIDGET                      PIC X(64).
           03  WRK-YUKOSTYMD                       PIC X(08).
           03  WRK-YUKOEDYMD                       PIC X(08).
           03  WRK-KJN-YUKSTYMD                    PIC X(08).
      *
      *    固定値領域
       01  CONST-AREA.
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
           03  CONST-KANGOCD-R     REDEFINES   CONST-KANGOCD-VAL.
               05  CONST-KANGOCD       PIC X(09) OCCURS 5.
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
           COPY    "W99.INC".
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
           MOVE    SPA-FREE        TO  SPA-W20FREE
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
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG
           WHEN    "W21"
               IF    ( SPA-MOTOPG2     =   "W20" )
                   MOVE    "W01"       TO  SPA-MOTOPG
                   MOVE    SPACE       TO  SPA-MOTOPG2
                                           SPA-MOTOPG3
      *            病棟リストを再編集する
                   MOVE    SPA-GMN-W20-BTULST-SEL-NUM
                                       TO  WRK-BTULST-SEL-NUM
                   PERFORM 3101-SYS-5001-GET-SEC
                   MOVE    WRK-BTULST-SEL-NUM
                                       TO  SPA-GMN-W20-BTULST-SEL-NUM
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
           MOVE    SPACE           TO  SPA-W20
                                           W20
           INITIALIZE                  SPA-W20
                                           W20
      *
      *    医療機関情報取得処理
           MOVE    SPA-SYSYMD      TO  WRK-KJN-YUKSTYMD
           PERFORM 3101-SYS-1001-GET-SEC
      *
      *    コンボ初期処理
           MOVE    SPA-SYSYMD      TO  WRK-KJN-YUKSTYMD
           PERFORM 3101-CMB-SYOKI-SEC
      *
           MOVE    SPA-GMN-W20-BTU-EDKBN-ITM (1)
                                   TO  SPA-GMN-W20-BTU-EDKBN
      *
      *    病棟管理情報（病棟リストに表示）
           PERFORM 3101-SYS-5001-GET-SEC
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
                                   TO  WRK-BTU-NUM
           MOVE    SPA-SYSYMD      TO  WRK-KIJUN-YMD
      *
      *    画面初期化
           PERFORM 420-CLEAR-SEC
      *
           PERFORM 4100-INPUT-AREA-EDIT-SEC
           IF    ( FLG-INPUT-AREA  NOT =   ZERO )
               GO  TO  310-BTU-SET-EXT
           END-IF
      *
           PERFORM 4100-BTU-NUM-LSTSEL-SEC
           IF    ( FLG-BTU-NUM =   ZERO )
               MOVE    IDX-BTULST
                               TO  SPA-GMN-W20-BTULST-SEL-NUM
           END-IF
      *
      *    履歴データ編集処理
           PERFORM 4100-RIREKI-AREA-EDIT-SEC
      *
           MOVE    2               TO  SPA-GMN-W20-CUR
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
           PERFORM 3101-SYS-5110-GET-SEC
      *
      *    病棟科名取得処理
           PERFORM 3101-SYS-1005-GET-SEC
      *
      *    病棟種別取得処理
           PERFORM 3101-SYS-5101-GET-SEC
      *
      *    平均在院日数取得処理
           PERFORM 3101-SYS-5102-GET-SEC
      *
      *    看護配置取得処理
           PERFORM 3101-SYS-5103-GET-SEC
      *
      *    看護師比率取得処理
           PERFORM 3101-SYS-5104-GET-SEC
      *
      *    看護補助加算取得処理
           PERFORM 3101-SYS-5105-GET-SEC
      *
      *    夜間勤務等看護加算取得処理
           PERFORM 3101-SYS-5106-GET-SEC
      *
      *    看護補助配置取得処理
           PERFORM 3101-SYS-5115-GET-SEC
      *
      *    レセプト表示区分
           PERFORM 3101-RECEDSPKBN-GET-SEC
      *
      *    終了区分
           MOVE    2       TO  SPA-GMN-W20-BTU-EDKBN-CNT
           MOVE    "1 "    TO  SPA-GMN-W20-BTU-EDKBN-ITM (1) (1 : 2)
           MOVE    "継続"  TO  SPA-GMN-W20-BTU-EDKBN-ITM (1) (4 : )
           MOVE    "2 "    TO  SPA-GMN-W20-BTU-EDKBN-ITM (2) (1 : 2)
           MOVE    "廃止"  TO  SPA-GMN-W20-BTU-EDKBN-ITM (2) (4 : )
      *
           .
       3101-CMB-SYOKI-EXT.
           EXIT.
      *
      *****************************************************************
      *    医療機関情報取得処理
      *****************************************************************
       3101-SYS-1001-GET-SEC       SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           INITIALIZE              SYSKANRI-REC
           MOVE    "1001"          TO  SYS-KANRICD
           MOVE    "*"             TO  SYS-KBNCD
           MOVE    WRK-KJN-YUKSTYMD
                                   TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *
      *    医療機関情報検索
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        NOT =   ZERO )
               MOVE    1           TO  FLG-SYSKANRI
           ELSE
               MOVE    MCPDATA-REC
                                   TO  SYS-1001-REC
           END-IF
      *
      *    医療機関情報クローズ
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           MOVE    ZERO            TO  SPA-NAI-W20-HOSPSBT
           IF    ( FLG-SYSKANRI    =   ZERO )
               MOVE    SYS-1001-HOSPSBT
                                   TO  SPA-NAI-W20-HOSPSBT
           END-IF
      *
      *
           .
       3101-SYS-1001-GET-EXT.
           EXIT.
      *****************************************************************
      *    施設基準取得処理
      *****************************************************************
       3101-SYS-1006-GET-SEC       SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           INITIALIZE              SYSKANRI-REC
           MOVE    "1006"          TO  SYS-KANRICD
           MOVE    "1"             TO  SYS-KBNCD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *
      *    施設基準情報検索
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    NOT =   ZERO )
               MOVE    1           TO  FLG-SYSKANRI
           ELSE
               MOVE    MCPDATA-REC
                                   TO  SYS-1006-REC
           END-IF
      *
      *    施設基準情報クローズ
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       3101-SYS-1006-GET-EXT.
           EXIT.
      *****************************************************************
      *    特定入院料取得処理
      *****************************************************************
       3101-SYS-5110-GET-SEC       SECTION.
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "5110"          TO  SYS-KANRICD
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
      *
      *    システム管理マスタ検索処理
           PERFORM 3102-SYS-KANRI-SEL-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYSKANRI    =   1 )
                 OR      ( IDX1    >   15 )
      *
               COMPUTE SPA-GMN-W20-BTU-TOKNYUIN-CNT
                   =   SPA-GMN-W20-BTU-TOKNYUIN-CNT    +   1
      *
               MOVE    SYSKANRI-REC
                                   TO  SYS-5110-REC
               MOVE    SYS-5110-KBNCD
                           TO  SPA-GMN-W20-BTU-TOKNYUIN-ITM
                                                       (IDX1) (1 : 2)
               MOVE    SYS-5110-BTU-TOKUTEINYUIN-NM
                           TO  SPA-GMN-W20-BTU-TOKNYUIN-ITM
                                                       (IDX1) (4 : )
               MOVE    SYS-5110-BTU-TOKUTEINYUIN-NM2
                           TO  SPA-GMN-W20-BTU-TOKNYUIN-ITM2(IDX1)
      *
      *        システム管理マスタ読込処理
               MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
               PERFORM 3102-SYS-KANRI-READ-SEC
      *
           END-PERFORM
      *
      *    システム管理マスタクローズ
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 3102-SYS-KANRI-CLOSE-SEC
      *
           .
       3101-SYS-5110-GET-EXT.
           EXIT.
      *****************************************************************
      *    診療科コード取得処理
      *****************************************************************
       3101-SYS-1005-GET-SEC       SECTION.
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "1005"          TO  SYS-KANRICD
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
      *
      *    システム管理マスタ検索処理
           PERFORM 3102-SYS-KANRI-SEL-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYSKANRI    =   1 )
                 OR      ( IDX1    >   99 )
      *
               COMPUTE SPA-GMN-W20-BTU-KA-CNT
                   =   SPA-GMN-W20-BTU-KA-CNT  +   1
      *
               MOVE    SYSKANRI-REC
                                   TO  SYS-1005-REC
               MOVE    SYS-1005-KBNCD
                           TO  SPA-GMN-W20-BTU-KA-ITM (IDX1) (1 : 2)
               MOVE    SYS-1005-SRYKANAME
                           TO  SPA-GMN-W20-BTU-KA-ITM (IDX1) (4 :  )
      *
      *        システム管理マスタ読込処理
               MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
               PERFORM 3102-SYS-KANRI-READ-SEC
      *
           END-PERFORM
      *
      *    システム管理マスタクローズ
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 3102-SYS-KANRI-CLOSE-SEC
      *
           .
       3101-SYS-1005-GET-EXT.
           EXIT.
      *****************************************************************
      *    病棟種別取得処理
      *****************************************************************
       3101-SYS-5101-GET-SEC       SECTION.
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "5101"          TO  SYS-KANRICD
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
      *
      *    システム管理マスタ検索処理
           PERFORM 3102-SYS-KANRI-SEL-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYSKANRI    =   1 )
                 OR      ( IDX1    >   15 )
      *
               COMPUTE SPA-GMN-W20-BTU-SBT-CNT
                   =   SPA-GMN-W20-BTU-SBT-CNT +   1
      *
               MOVE    SYSKANRI-REC
                                   TO  SYS-5101-REC
               MOVE    SYS-5101-KBNCD
                           TO  SPA-GMN-W20-BTU-SBT-ITM (IDX1) (1 : 2)
               MOVE    SYS-5101-BTU-SBT-NM
                           TO  SPA-GMN-W20-BTU-SBT-ITM (IDX1) (4 :  )
      *
      *        システム管理マスタ読込処理
               MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
               PERFORM 3102-SYS-KANRI-READ-SEC
      *
           END-PERFORM
      *
      *    システム管理マスタクローズ
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 3102-SYS-KANRI-CLOSE-SEC
      *
           .
       3101-SYS-5101-GET-EXT.
           EXIT.
      *****************************************************************
      *    平均在院日数取得処理
      *****************************************************************
       3101-SYS-5102-GET-SEC       SECTION.
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "5102"          TO  SYS-KANRICD
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
      *
      *    システム管理マスタ検索処理
           PERFORM 3102-SYS-KANRI-SEL-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYSKANRI    =   1 )
                 OR      ( IDX1    >   15 )
      *
               COMPUTE SPA-GMN-W20-BTU-HEIZAIKBN-CNT
                   =   SPA-GMN-W20-BTU-HEIZAIKBN-CNT   +   1
      *
               MOVE    SYSKANRI-REC
                                   TO  SYS-5102-REC
               MOVE    SYS-5102-KBNCD
                           TO  SPA-GMN-W20-BTU-HEIZAIKBN-ITM
                                                       (IDX1) (1 : 2)
               MOVE    SYS-5102-BTU-HEIKINZAIKBN-NM
                           TO  SPA-GMN-W20-BTU-HEIZAIKBN-ITM
                                                       (IDX1) (4 :  )
      *
      *        システム管理マスタ読込処理
               MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
               PERFORM 3102-SYS-KANRI-READ-SEC
      *
           END-PERFORM
      *
      *    システム管理マスタクローズ
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 3102-SYS-KANRI-CLOSE-SEC
      *
           .
       3101-SYS-5102-GET-EXT.
           EXIT.
      *****************************************************************
      *    看護配置取得処理
      *****************************************************************
       3101-SYS-5103-GET-SEC       SECTION.
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "5103"          TO  SYS-KANRICD
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
      *
      *    システム管理マスタ検索処理
           PERFORM 3102-SYS-KANRI-SEL-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYSKANRI    =   1 )
                 OR      ( IDX1    >   20 )
      *
               COMPUTE SPA-GMN-W20-BTU-KNGHAIKBN-CNT
                   =   SPA-GMN-W20-BTU-KNGHAIKBN-CNT   +   1
      *
               MOVE    SYSKANRI-REC
                                   TO  SYS-5103-REC
               MOVE    SYS-5103-KBNCD
                           TO  SPA-GMN-W20-BTU-KNGHAIKBN-ITM
                                                       (IDX1) (1 : 2)
               MOVE    SYS-5103-BTU-KNGHAICHIKBN-NM
                           TO  SPA-GMN-W20-BTU-KNGHAIKBN-ITM
                                                       (IDX1) (4 :  )
      *
      *        システム管理マスタ読込処理
               MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
               PERFORM 3102-SYS-KANRI-READ-SEC
      *
           END-PERFORM
      *
      *    システム管理マスタクローズ
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 3102-SYS-KANRI-CLOSE-SEC
      *
           .
       3101-SYS-5103-GET-EXT.
           EXIT.
      *****************************************************************
      *    看護師比率取得処理
      *****************************************************************
       3101-SYS-5104-GET-SEC       SECTION.
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "5104"          TO  SYS-KANRICD
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
      *
      *    システム管理マスタ検索処理
           PERFORM 3102-SYS-KANRI-SEL-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYSKANRI    =   1 )
                 OR      ( IDX1    >   10 )
      *
               COMPUTE SPA-GMN-W20-BTU-KNGHIRIT-CNT
                   =   SPA-GMN-W20-BTU-KNGHIRIT-CNT    +   1
      *
               MOVE    SYSKANRI-REC
                                   TO  SYS-5104-REC
               MOVE    SYS-5104-KBNCD
                           TO  SPA-GMN-W20-BTU-KNGHIRIT-ITM
                                                       (IDX1) (1 : 2)
               MOVE    SYS-5104-BTU-KNGHIRITUKBN-NM
                           TO  SPA-GMN-W20-BTU-KNGHIRIT-ITM
                                                       (IDX1) (4 :  )
      *
      *        システム管理マスタ読込処理
               MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
               PERFORM 3102-SYS-KANRI-READ-SEC
      *
           END-PERFORM
      *
      *    システム管理マスタクローズ
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 3102-SYS-KANRI-CLOSE-SEC
      *
           .
       3101-SYS-5104-GET-EXT.
           EXIT.
      *****************************************************************
      *    看護補助加算取得処理
      *****************************************************************
       3101-SYS-5105-GET-SEC       SECTION.
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "5105"          TO  SYS-KANRICD
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
      *
      *    システム管理マスタ検索処理
           PERFORM 3102-SYS-KANRI-SEL-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYSKANRI    =   1 )
                 OR      ( IDX1    >   10 )
      *
               COMPUTE SPA-GMN-W20-BTU-KNGHJOKSN-CNT
                   =   SPA-GMN-W20-BTU-KNGHJOKSN-CNT   +   1
      *
               MOVE    SYSKANRI-REC
                                   TO  SYS-5105-REC
               MOVE    SYS-5105-KBNCD
                                   TO  SPA-GMN-W20-BTU-KNGHJOKSN-ITM
                                                       (IDX1) (1 : 2)
               MOVE    SYS-5105-BTU-KNGHJOKSN-NM
                                   TO  SPA-GMN-W20-BTU-KNGHJOKSN-ITM
                                                       (IDX1) (4 :  )
      *
      *        システム管理マスタ読込処理
               MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
               PERFORM 3102-SYS-KANRI-READ-SEC
      *
           END-PERFORM
      *
      *    システム管理マスタクローズ
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 3102-SYS-KANRI-CLOSE-SEC
      *
           .
       3101-SYS-5105-GET-EXT.
           EXIT.
      *****************************************************************
      *    夜間勤務等看護加算取得処理
      *****************************************************************
       3101-SYS-5106-GET-SEC       SECTION.
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "5106"          TO  SYS-KANRICD
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
      *
      *    システム管理マスタ検索処理
           PERFORM 3102-SYS-KANRI-SEL-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYSKANRI    =   1 )
                 OR      ( IDX1    >   10 )
      *
               COMPUTE SPA-GMN-W20-BTU-YKNKNGKSN-CNT
                   =   SPA-GMN-W20-BTU-YKNKNGKSN-CNT   +   1
      *
               MOVE    SYSKANRI-REC
                                   TO  SYS-5106-REC
               MOVE    SYS-5106-KBNCD
                                   TO  SPA-GMN-W20-BTU-YKNKNGKSN-ITM
                                                       (IDX1) (1 : 2)
               MOVE    SYS-5106-BTU-YAKANKNGKSN-NM
                                   TO  SPA-GMN-W20-BTU-YKNKNGKSN-ITM
                                                       (IDX1) (4 :  )
      *
      *        システム管理マスタ読込処理
               MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
               PERFORM 3102-SYS-KANRI-READ-SEC
      *
           END-PERFORM
      *
      *    システム管理マスタクローズ
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 3102-SYS-KANRI-CLOSE-SEC
      *
           .
       3101-SYS-5106-GET-EXT.
           EXIT.
      *****************************************************************
      *    看護補助配置取得処理
      *****************************************************************
       3101-SYS-5115-GET-SEC       SECTION.
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "5115"          TO  SYS-KANRICD
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
      *
      *    システム管理マスタ検索処理
           PERFORM 3102-SYS-KANRI-SEL-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYSKANRI    =   1 )
                 OR      ( IDX1    >   10 )
      *
               COMPUTE SPA-GMN-W20-BTU-KNGHJOHAI-CNT
                   =   SPA-GMN-W20-BTU-KNGHJOHAI-CNT   +   1
      *
               MOVE    SYSKANRI-REC
                                   TO  SYS-5115-REC
               MOVE    SYS-5115-KBNCD
                                   TO  SPA-GMN-W20-BTU-KNGHJOHAI-ITM
                                                       (IDX1) (1 : 2)
               MOVE    SYS-5115-BTU-KNGHJOHAI-NM
                                   TO  SPA-GMN-W20-BTU-KNGHJOHAI-ITM
                                                       (IDX1) (4 :  )
      *
      *        システム管理マスタ読込処理
               MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
               PERFORM 3102-SYS-KANRI-READ-SEC
      *
           END-PERFORM
      *
      *    システム管理マスタクローズ
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 3102-SYS-KANRI-CLOSE-SEC
      *
           .
       3101-SYS-5115-GET-EXT.
           EXIT.
      *****************************************************************
      *    病棟管理情報検索処理
      *****************************************************************
       3101-SYS-5001-GET-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W20-BTULST-TBL
      *
      *
           INITIALIZE  SYSKANRI-REC
      *    システム管理マスタ検索処理
           MOVE    "5001"          TO  SYS-KANRICD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    "SYSKANRI-KEY7" TO  WRK-DBPATH
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *
      *    システム管理マスタ検索処理
           PERFORM 900-TBL-SELECT-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-DBRC    NOT =   ZERO )
                 OR      ( IDX1    >   50 )
      *
      *
               MOVE    MCPDATA-REC
                                   TO  SYS-5001-REC
      *
               MOVE    IDX1        TO  SPA-GMN-W20-BTULST-CNT
      *
      *        病棟リスト編集
               PERFORM 3102-BTULST-EDIT-SEC
      *
      *        システム管理マスタ読込処理
               MOVE    "SYSKANRI-KEY7" TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
      **   収容人数設定処理
           PERFORM 3102-BTU-NINZU-GET-SEC
      *
      *    システム管理マスタクローズ
           MOVE    "SYSKANRI-KEY7" TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           IF    ( SPA-GMN-W20-BTULST-CNT  >=  50 )
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W20-B06-STATE
           END-IF
      *
           .
       3101-SYS-5001-GET-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ検索処理
      *****************************************************************
       3102-SYS-KANRI-SEL-SEC      SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    WRK-KJN-YUKSTYMD
                                   TO  ORC-DBYMD
      *
      *    システム管理マスタ検索処理
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    =   ZERO )
               MOVE    MCPDATA-REC TO  SYSKANRI-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
               GO  TO  3102-SYS-KANRI-SEL-EXT
           END-IF
      *
           .
       3102-SYS-KANRI-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ読込処理
      *****************************************************************
       3102-SYS-KANRI-READ-SEC         SECTION.
      *
           PERFORM 900-TBL-READ-SEC
           IF    ( FLG-DBRC    =   ZERO )
               MOVE    MCPDATA-REC TO  SYSKANRI-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
           END-IF
      *
           .
       3102-SYS-KANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理クローズ処理
      *****************************************************************
       3102-SYS-KANRI-CLOSE-SEC        SECTION.
      *
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       3102-SYS-KANRI-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    レセプト表示区分取得処理
      *****************************************************************
       3101-RECEDSPKBN-GET-SEC         SECTION.
      *
           INITIALIZE  SPA-GMN-W20-CMB-RECEDSPKBN
      *
           MOVE    "01"    TO  SPA-GMN-W20-RECEDSPKBN-ITM (1) (1 : 2)
           MOVE    "02"    TO  SPA-GMN-W20-RECEDSPKBN-ITM (2) (1 : 2)
           MOVE    "03"    TO  SPA-GMN-W20-RECEDSPKBN-ITM (3) (1 : 2)
           MOVE    "05"    TO  SPA-GMN-W20-RECEDSPKBN-ITM (4) (1 : 2)
           MOVE    "07"    TO  SPA-GMN-W20-RECEDSPKBN-ITM (5) (1 : 2)
           MOVE    "08"    TO  SPA-GMN-W20-RECEDSPKBN-ITM (6) (1 : 2)
           MOVE    "09"    TO  SPA-GMN-W20-RECEDSPKBN-ITM (7) (1 : 2)
      *
           MOVE    "精神"  TO  SPA-GMN-W20-RECEDSPKBN-ITM (1) (4 : )
           MOVE    "結核"  TO  SPA-GMN-W20-RECEDSPKBN-ITM (2) (4 : )
           MOVE    "特例"  TO  SPA-GMN-W20-RECEDSPKBN-ITM (3) (4 : )
           MOVE    "老人"  TO  SPA-GMN-W20-RECEDSPKBN-ITM (4) (4 : )
           MOVE    "療養"  TO  SPA-GMN-W20-RECEDSPKBN-ITM (5) (4 : )
           MOVE    "複合"  TO  SPA-GMN-W20-RECEDSPKBN-ITM (6) (4 : )
           MOVE    "複療"  TO  SPA-GMN-W20-RECEDSPKBN-ITM (7) (4 : )
      *
           MOVE    "02"        TO  SPA-GMN-W20-RECEDSPKBN-ITM2 (1)
           MOVE    "03"        TO  SPA-GMN-W20-RECEDSPKBN-ITM2 (2)
           MOVE    "**"        TO  SPA-GMN-W20-RECEDSPKBN-ITM2 (3)
           MOVE    "07"        TO  SPA-GMN-W20-RECEDSPKBN-ITM2 (4)
           MOVE    "04"        TO  SPA-GMN-W20-RECEDSPKBN-ITM2 (5)
           MOVE    "**"        TO  SPA-GMN-W20-RECEDSPKBN-ITM2 (6)
           MOVE    "**"        TO  SPA-GMN-W20-RECEDSPKBN-ITM2 (7)
      *
           MOVE    7           TO  SPA-GMN-W20-RECEDSPKBN-CNT
      *
           .
       3101-RECEDSPKBN-GET-EXT.
           EXIT.
      *****************************************************************
      *    病棟リスト編集処理
      *****************************************************************
       3102-BTULST-EDIT-SEC            SECTION.
      *
      *    病棟番号
           MOVE    SYS-5001-BTU-NUM
                           TO  SPA-GMN-W20-TBTU-NUM (IDX1)
      *    病棟名称
           MOVE    SYS-5001-BTU-NAME
                           TO  SPA-GMN-W20-TBTU-NAME (IDX1)
      *    短縮病棟名称
           MOVE    SYS-5001-BTU-TANNAME
                           TO  SPA-GMN-W20-TBTU-TANNAME (IDX1)
      *
      **   病棟種別
           MOVE    SYS-5001-BTU-SBT
                           TO  WRK-KANRICD
           PERFORM 800-BTU-SBT-SRH-SEC
           MOVE    WRK-KANRIDAT1 (4 : )
                           TO  SPA-GMN-W20-TBTU-SBT (IDX1)
      *
      *    特定入院料
           MOVE    SYS-5001-BTU-TOKTEI-NYUIN
                           TO  WRK-KANRICD
           PERFORM 800-BTU-TOKUTEINYUIN-SRH-SEC
           MOVE    WRK-KANRIDAT2
                           TO  SPA-GMN-W20-TBTU-TOKNYUIN (IDX1)
      *
      *    病棟科名
           MOVE    SYS-5001-BTU-KA
                           TO  WRK-KANRICD
           PERFORM 800-BTU-KA-SRH-SEC
           MOVE    WRK-KANRIDAT1 (4 : )
                           TO  SPA-GMN-W20-TBTU-KA (IDX1)
      *
           MOVE    SYS-5001-BTU-KHNSRYCD
                           TO  SPA-GMN-W20-TBTU-KHNSRYCD (IDX1)
      *
      *    入院基本点数をサブプロより取得する
           INITIALIZE W20SUB01-LNK
           MOVE    "1"             TO  W20SUB01-I-KBN
           MOVE    SYS-5001-BTU-KHNSRYCD
                                   TO  W20SUB01-I-KHNSRYCD
           MOVE    SYS-5001-STYUKYMD
                                   TO  W20SUB01-I-KJNYMD
      *
           CALL    "ORCGW20SUB01"      USING
                                       W20SUB01-LNK
           IF    ( W20SUB01-O-RC   =   ZERO )
               MOVE    W20SUB01-O-NAME
                                   TO  SPA-GMN-W20-TBTU-KHNRYO (IDX1)
               MOVE    W20SUB01-O-KHNTEN
                                   TO  SPA-GMN-W20-TBTU-KHNTEN (IDX1)
           END-IF
      *
      *    看護配置
           MOVE    SYS-5001-BTU-KNGHAICHIKBN
                           TO  WRK-KANRICD
           PERFORM 800-BTU-KNGHAICHIKBN-SRH-SEC
           MOVE    WRK-KANRIDAT1 (4 : )
                           TO  SPA-GMN-W20-TBTU-KNGHAIKBN (IDX1)
      *
      *    看護師比率
           MOVE    SYS-5001-BTU-KNGHIRITUKBN
                           TO  WRK-KANRICD
           PERFORM 800-BTU-KNGHIRITUKBN-SRH-SEC
           MOVE    WRK-KANRIDAT1 (4 : )
                           TO  SPA-GMN-W20-TBTU-KNGHIRIT (IDX1)
      *
      *    平均在院日数
           MOVE    SYS-5001-BTU-HEIKINZAIKBN
                           TO  WRK-KANRICD
           PERFORM 800-BTU-HEIKINZAIKBN-SRH-SEC
           MOVE    WRK-KANRIDAT1 (4 : )
                           TO  SPA-GMN-W20-TBTU-HEIZAIKBN (IDX1)
      *
      *    看護補助加算
           MOVE    SYS-5001-BTU-KNGHJOKSN
                           TO  WRK-KANRICD
           PERFORM 800-BTU-KNGHJOKSN-SRH-SEC
           MOVE    WRK-KANRIDAT1 (4 : )
                           TO  SPA-GMN-W20-TBTU-KNGHJOKSN (IDX1)
      *
      *    看護補助配置
           MOVE    SYS-5001-BTU-KNGHJOHAI
                           TO  WRK-KANRICD
           PERFORM 800-BTU-KNGHJOHAI-SRH-SEC
           MOVE    WRK-KANRIDAT1 (4 : )
                           TO  SPA-GMN-W20-TBTU-KNGHJOHAI (IDX1)
      *
      *    夜間勤務等看護加算
           MOVE    SYS-5001-BTU-YAKANKNGKSN
                           TO  WRK-KANRICD
           PERFORM 800-BTU-YAKANKNGKSN-SRH-SEC
           MOVE    WRK-KANRIDAT1 (4 : )
                           TO  SPA-GMN-W20-TBTU-YKNKNGKSN (IDX1)
      *
      *    食堂加算区分
           IF    ( SYS-5001-BTU-SYOKUDOKBN     =   "2" )
               MOVE    "T" TO  SPA-GMN-W20-TBTU-SYOKUDOKBN (IDX1)
           ELSE
               MOVE    "F" TO  SPA-GMN-W20-TBTU-SYOKUDOKBN (IDX1)
           END-IF
      *
      *    看護師人数区分
           IF    ( SYS-5001-BTU-KNGSISUKBN =   "2" )
               MOVE    "T" TO  SPA-GMN-W20-TBTU-KNGSISUKBN (IDX1)
           ELSE
               MOVE    "F" TO  SPA-GMN-W20-TBTU-KNGSISUKBN (IDX1)
           END-IF
      *
      *    保育士人数区分
           IF    ( SYS-5001-BTU-HIKSISUKBN =   "2" )
               MOVE    "T" TO  SPA-GMN-W20-TBTU-HIKSISUKBN (IDX1)
           ELSE
               MOVE    "F" TO  SPA-GMN-W20-TBTU-HIKSISUKBN (IDX1)
           END-IF
      *
      *    有効開始日
           MOVE    SYS-5001-STYUKYMD
                           TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG
                           TO  SPA-GMN-W20-TYUKOSTYMD (IDX1)
      *
      *    有効終了日
           MOVE    SYS-5001-EDYUKYMD
                           TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG
                           TO  SPA-GMN-W20-TYUKOEDYMD (IDX1)
      *
           .
       3102-BTULST-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病棟人数取得処理
      *****************************************************************
       3102-BTU-NINZU-GET-SEC      SECTION.
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >    SPA-GMN-W20-BTULST-CNT )
      *
               INITIALIZE      SYSKANRI-REC
                               WRK-BTU-NINZU
               MOVE    ZERO            TO  FLG-SYSKANRI
      *
               MOVE    "5002"          TO  SYS-KANRICD
               MOVE    SPA-GMN-W20-TBTU-NUM (IDX1)
                                       TO  SYS-KBNCD
               MOVE    SPA-SYSYMD      TO  ORC-DBYMD
               MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
      *
      *        システム管理マスタ検索処理
               MOVE    SYSKANRI-REC    TO  MCPDATA-REC
               PERFORM 900-TBL-SELECT-SEC
      *
               PERFORM UNTIL ( FLG-DBRC    =   1 )
      *
                   MOVE    MCPDATA-REC
                                       TO  SYS-5002-REC
      *
                   COMPUTE WRK-BTU-NINZU
                       =   WRK-BTU-NINZU   +   SYS-5002-BRM-NINZU
      *
      *            システム管理マスタ読込処理
                   MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
                   PERFORM 900-TBL-READ-SEC
      *
               END-PERFORM
      *
      *        システム管理マスタクローズ
               MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
               PERFORM 900-TBL-CLOSE-SEC
      *
               MOVE    WRK-BTU-NINZU   TO  SPA-GMN-W20-TBTU-NINZU (IDX1)
      *
            END-PERFORM
      *
           .
       3102-BTU-NINZU-GET-EXT.
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
           EVALUATE    MCP-EVENT       ALSO      MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE   "CHANGE"             TO  MCP-PUTTYPE
                   PERFORM  210-BACK
      *        クリア
               WHEN    "CLICKED"       ALSO    "B02"
                   MOVE   "CHANGE"             TO  MCP-PUTTYPE
                   PERFORM 420-CLEAR-SEC
      *        追加
               WHEN    "CLICKED"       ALSO    "B06"
                   MOVE   "CHANGE"             TO  MCP-PUTTYPE
                   PERFORM 420-TUIKA-SEC
      *        変更
               WHEN    "CLICKED"       ALSO    "B07"
                   MOVE   "CHANGE"             TO  MCP-PUTTYPE
                   PERFORM 420-HENKOU-SEC
      *        削除
               WHEN    "CLICKED"       ALSO    "B08"
                   MOVE   "CHANGE"             TO  MCP-PUTTYPE
                   PERFORM 420-SAKUJO-SEC
      *        病室管理情報画面へ
               WHEN    "CLICKED"       ALSO    "B09"
                   IF  ( SPA-MOTOPG    =       "W01" )
                       MOVE   "CHANGE"             TO  MCP-PUTTYPE
                       PERFORM 420-BYOSITU-KANRI-SEC
                   END-IF
      *        食堂加算区分
      *        看護師数区分
      *        保育士数区分
               WHEN    "CLICKED"       ALSO    "CHK_BTU_SYOKUDOKBN"
               WHEN    "CLICKED"       ALSO    "CHK_BTU_KNGSISUKBN"
               WHEN    "CLICKED"       ALSO    "CHK_BTU_HIKSISUKBN"
                   MOVE   "CHANGE"             TO  MCP-PUTTYPE
      *
      *            入力個所のセット
                   PERFORM 400-GMN-INPUT-SEC
      *            入力チェック処理
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
           WHEN    "ACTIVATE"      ALSO    "BTU_NUM"
                   PERFORM 4100-BTU-NUM-CHK-SEC
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
           WHEN    "ACTIVATE"      ALSO    "BTU_KHNRYO"
      *
      *        入院基本料チェック処理
               PERFORM 4100-BTU-KHNRYO-CHK-SEC
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
           MOVE    W20-BTU-NAME    TO  SPA-GMN-W20-BTU-NAME
      *
      *    短縮病棟名
           MOVE    W20-BTU-TANNAME TO  SPA-GMN-W20-BTU-TANNAME
      *
      *    特定入院料
           MOVE    W20-BTU-TOKUTEINYUIN
                                   TO  SPA-GMN-W20-BTU-TOKNYUIN
      *
      *    病棟科名
           MOVE    W20-BTU-KA      TO  SPA-GMN-W20-BTU-KA
      *
      *    病棟種別
           MOVE    W20-BTU-SBT     TO  SPA-GMN-W20-BTU-SBT
      *
      *    平均在院日数
           MOVE    W20-BTU-HEIKINZAIKBN
                                   TO  SPA-GMN-W20-BTU-HEIZAIKBN
      *
      *    看護配置
           MOVE    W20-BTU-KNGHAICHIKBN
                                   TO  SPA-GMN-W20-BTU-KNGHAIKBN
      *
      *    看護師比率
           MOVE    W20-BTU-KNGHIRITUKBN
                                   TO  SPA-GMN-W20-BTU-KNGHIRIT
      *
      *    看護補助配置
           MOVE    W20-BTU-KNGHJOHAI
                                   TO  SPA-GMN-W20-BTU-KNGHJOHAI
      *
      *    看護補助加算
           MOVE    W20-BTU-KNGHJOKSN
                                   TO  SPA-GMN-W20-BTU-KNGHJOKSN
      *
      *    夜間勤務看護加算
           MOVE    W20-BTU-YAKANKNGKSN
                                   TO  SPA-GMN-W20-BTU-YKNKNGKSN
      *
      *    食堂加算区分
           MOVE    W20-CHK-BTU-SYOKUDOKBN
                                   TO  SPA-GMN-W20-CHK-BTU-SYOKUDOKBN
      *
      *    看護師人数
           MOVE    W20-CHK-BTU-KNGSISUKBN
                                   TO  SPA-GMN-W20-CHK-BTU-KNGSIS
      *
      *    保育士人数
           MOVE    W20-CHK-BTU-HIKSISUKBN
                                   TO  SPA-GMN-W20-CHK-BTU-HIKSIS
      *
      *    レセプト表示区分
           MOVE    W20-RECEDSPKBN  TO  SPA-GMN-W20-RECEDSPKBN
      *
      *    有効期間開始日
           MOVE    W20-YUKOSTYMD   TO  SPA-GMN-W20-YUKOSTYMD
      *
      *    有効期間終了日
           MOVE    W20-YUKOEDYMD   TO  SPA-GMN-W20-YUKOEDYMD
      *
      *    病棟終了区分
           MOVE    W20-BTU-EDKBN   TO  SPA-GMN-W20-BTU-EDKBN
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
           PERFORM 4101-BTU-NUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               PERFORM 420-CLEAR-SEC
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    有効期間開始日チェック処理
           PERFORM 4100-YUKOSTYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    有効期間終了日チェック処理
           PERFORM 4100-YUKOEDYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    病棟名称チェック処理
           PERFORM 4100-BTU-NAME-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    短縮病棟名チェック処理
           PERFORM 4100-BTU-TANNAME-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    特定入院料チェック処理
           PERFORM 4100-BTU-TOKUTEINYUIN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    病棟科名チェック処理
           PERFORM 4100-BTU-KA-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    病棟種別チェック処理
           PERFORM 4100-BTU-SBT-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    平均在院日数チェック処理
           PERFORM 4100-BTU-HEIKINZAIKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    看護配置チェック処理
           PERFORM 4100-BTU-KNGHAICHIKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    看護師比率チェック処理
           PERFORM 4100-BTU-KNGHIRITUKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    看護補助配置チェック処理
           PERFORM 4100-BTU-KNGHJOHAI-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    看護補助加算チェック処理
           PERFORM 4100-BTU-KNGHJOKSN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    夜間勤務等看護加算チェック処理
           PERFORM 4100-BTU-YAKANKNGKSN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    食堂加算区分チェック処理
           PERFORM 4100-BTU-SYOKUDOKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    看護師人数チェック処理
           PERFORM 4100-BTU-KNGSISUKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    保育士人数チェック処理
           PERFORM 4100-BTU-HIKSISUKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    レセプト表示区分チェック処理
           PERFORM 4100-RECEDSPKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    病棟継続区分チェック処理
           PERFORM 4100-BTU-EDKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    入院基本料チェック
           IF    ( SPA-GMN-W20-BTU-KHNRYO
                                   NOT =   SPACE )
               PERFORM 4101-BTU-KHNRYO-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4102-KIHON-CHK-EXT
               END-IF
           END-IF
      *
      *    入院基本料を求める
           PERFORM 4100-NYUKHN-KHNTEN-GET-SEC
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
           IF    ( SPA-GMN-W20-BTU-EDKBN-CD
                                       =   "2" )
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
      *        病棟リストを再編集する
               PERFORM 3101-SYS-5001-GET-SEC
               GO  TO  420-TUIKA-EXT
           END-IF
      *
      *    病棟リストを再編集する
           PERFORM 3101-SYS-5001-GET-SEC
      *
           PERFORM 4100-BTU-NUM-LSTSEL-SEC
           IF    ( FLG-BTU-NUM =   ZERO )
               MOVE    IDX-BTULST
                                   TO  SPA-GMN-W20-BTULST-SEL-NUM
           END-IF
      *
      *    履歴リストを再編集する
           PERFORM 4100-RIREKI-AREA-EDIT-SEC
           MOVE    ZERO            TO  SPA-GMN-W20-RIREKILST-SEL-NUM
      *
      *    入力項目を初期化する
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
      *    病棟リスト最大件数チェック
           IF    ( SPA-GMN-W20-BTULST-CNT  >=  50 )
               MOVE    "1001"      TO  SPA-ERRCD
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W20-B06-STATE
           END-IF
      *
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
           PERFORM 4100-BTU-NUM-LSTSEL-SEC
           IF    ( FLG-BTU-NUM      =   ZERO )
               CONTINUE
           ELSE
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
           IF    ( SPA-GMN-W20-BTU-EDKBN-CD
                                       =   "2" )
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
      *        病棟リストを再編集する
               PERFORM 3101-SYS-5001-GET-SEC
               GO  TO  420-HENKOU-EXT
           END-IF
      *
      *    病棟リストを再編集する
           PERFORM 3101-SYS-5001-GET-SEC
      *
           PERFORM 4100-BTU-NUM-LSTSEL-SEC
           IF    ( FLG-BTU-NUM =   ZERO )
               MOVE    IDX-BTULST
                                   TO  SPA-GMN-W20-BTULST-SEL-NUM
      *        履歴リストを再編集する
               PERFORM 4100-RIREKI-AREA-EDIT-SEC
               MOVE    ZERO        TO  SPA-GMN-W20-RIREKILST-SEL-NUM
      *
      *        入力項目を初期化する
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
           ELSE
      *        画面を初期化する
               PERFORM 420-CLEAR-SEC
           END-IF
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
           PERFORM 4100-BTU-SEL-SEC
           IF   (  FLG-SYSKANRI    =   ZERO )
               CONTINUE
           ELSE
               GO  TO  4100-RIREKI-CHK-EXT
           END-IF
      *
           PERFORM
               UNTIL     ( FLG-SYSKANRI    NOT =   ZERO )
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
                       MOVE    "1"         TO  FLG-KIKAN-DABURI
                   END-IF
               END-IF
      *
      *        病棟データ読込処理
               PERFORM 4100-BTU-READ-SEC
      *
           END-PERFORM
      *
      *    病棟データクローズ処理
           PERFORM 4100-BTU-CLOSE-SEC
           .
      *
       4100-RIREKI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟情報検索処理
      *****************************************************************
       4100-BTU-SEL-SEC            SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           INITIALIZE                  SYS-5001-REC
           MOVE    "5001"          TO  SYS-5001-KANRICD
           MOVE    SPA-GMN-W20-BTU-NUM TO  SYS-5001-KBNCD
           MOVE    "SYSKANRI-KEY8" TO  WRK-DBPATH
           MOVE    SYS-5001-REC    TO  MCPDATA-REC
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-5001-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
               GO  TO  4100-BTU-SEL-EXT
           END-IF
      *
           .
       4100-BTU-SEL-EXT.
           EXIT.
      *****************************************************************
      *    病棟情報読込処理
      *****************************************************************
       4100-BTU-READ-SEC               SECTION.
      *
           MOVE    "SYSKANRI-KEY8" TO  WRK-DBPATH
           PERFORM 900-TBL-READ-SEC
           IF    ( FLG-DBRC        =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-5001-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
           END-IF
      *
           .
       4100-BTU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    病棟情報クローズ処理
      *****************************************************************
       4100-BTU-CLOSE-SEC              SECTION.
      *
           MOVE    "SYSKANRI-KEY8" TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       4100-BTU-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    削除処理
      *****************************************************************
       420-SAKUJO-SEC                  SECTION.
      *
      *    病棟番号チェック処理
           PERFORM 4101-BTU-NUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               PERFORM 420-CLEAR-SEC
               GO  TO  420-SAKUJO-EXT
           END-IF
      *
      *   リストに該当番号の病棟が存在するかチェック
           PERFORM 4100-BTU-NUM-LSTSEL-SEC
           IF    ( FLG-BTU-NUM      =   ZERO )
               MOVE    IDX-BTULST   TO  WRK-BTULST
           ELSE
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
      *        病棟リストを再編集する
               PERFORM 3101-SYS-5001-GET-SEC
               GO  TO  421-SAKUJO-EXT
           END-IF
      *
      *    病棟リストを再編集する
           PERFORM 3101-SYS-5001-GET-SEC
      *
           PERFORM 4100-BTU-NUM-LSTSEL-SEC
           IF    ( FLG-BTU-NUM =   ZERO )
               MOVE    IDX-BTULST
                                   TO  SPA-GMN-W20-BTULST-SEL-NUM
      *        履歴リストを再編集する
               PERFORM 4100-RIREKI-AREA-EDIT-SEC
               MOVE    ZERO        TO  SPA-GMN-W20-RIREKILST-SEL-NUM
      *
      *        入力項目を初期化する
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
           ELSE
      *        画面を初期化する
               PERFORM 420-CLEAR-SEC
           END-IF
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
      *
           MOVE    ZERO            TO  FLG-BRM-SONZAI
      *
           INITIALIZE      SYSKANRI-REC
      *
           MOVE    "5002"          TO  SYS-KANRICD
           MOVE    SPA-GMN-W20-TBTU-NUM (WRK-BTULST)
                                   TO  SYS-KBNCD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
      *
           MOVE    "SYSKANRI-KEY4" TO  WRK-DBPATH
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *    システム管理マスタ検索処理
           PERFORM 900-TBL-SELECT-SEC
      *
           PERFORM UNTIL ( FLG-BRM-SONZAI  =   1 )
                   OR    ( FLG-DBRC    NOT =   ZERO )
      *
               MOVE    MCPDATA-REC TO  SYS-5002-REC
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
      *        システム管理マスタ読込処理
               MOVE    "SYSKANRI-KEY4" TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
      *    システム管理マスタクローズ
           MOVE    "SYSKANRI-KEY4" TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
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
           IF    ( SPA-GMN-W20-BTULST-SEL-NUM
                                       NOT =   ZERO )
                 MOVE    SPA-GMN-W20-BTULST-SEL-NUM 
                                       TO  IDX1
                 MOVE    SPA-GMN-W20-TBTU-NUM (IDX1)
                                       TO  SPA-W20-W21-BTU-NUM
           END-IF
      *
           MOVE    "W21"               TO  SPA-SAKIPG
           MOVE    "W20"               TO  SPA-MOTOPG
           MOVE    "W01"               TO  SPA-MOTOPG2
      *
      ***  MOVE   "CHANGE"             TO  MCP-PUTTYPE
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
           PERFORM 4201-BRM-SEL-SEC
      *
           PERFORM
               UNTIL     ( FLG-SYSKANRI    =   1 )
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
               MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *
               MOVE    "SYSKANRI-UPD1" TO  WRK-DBPATH
      *
               PERFORM 900-TBL-UPDATE-SEC
      *
               IF   (  FLG-DBRC        NOT =   ZERO )
                   MOVE    "1204"      TO  SPA-ERRCD
                   GO  TO  4201-BRM-UPDATE-EXT
               END-IF
      *
      *        病室管理情報読込処理
               PERFORM 4201-BRM-READ-SEC
      *
           END-PERFORM
      *
      *    病室管理情報クローズ
           PERFORM 4201-BRM-CLOSE-SEC
      *
           .
      *
       4201-BRM-UPDATE-EXT.
           EXIT.
      *****************************************************************
      *    病室管理情報検索処理
      *****************************************************************
       4201-BRM-SEL-SEC                SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           INITIALIZE  SYSKANRI-REC
      *
           MOVE    "5002"          TO  SYS-KANRICD
           MOVE    SPA-GMN-W20-BTU-NUM
                                   TO  SYS-KBNCD
           MOVE    SPA-NAI-W20-YUKOEDYMD
                                   TO  ORC-DBYMD
      *
      *    病室管理情報検索処理
           MOVE    "SYSKANRI-KEY" TO  WRK-DBPATH
           MOVE    SYSKANRI-REC   TO  MCPDATA-REC
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    =   ZERO )
      *
               MOVE    MCPDATA-REC TO  SYS-5002-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
               GO  TO  4201-BRM-SEL-EXT
           END-IF
      *
           .
       4201-BRM-SEL-EXT.
           EXIT.
      *****************************************************************
      *    病室管理情報読込処理
      *****************************************************************
       4201-BRM-READ-SEC               SECTION.
      *
           MOVE    "SYSKANRI-KEY" TO  WRK-DBPATH
           PERFORM 900-TBL-READ-SEC
           IF    ( FLG-DBRC    =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-5002-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
           END-IF
      *
           .
       4201-BRM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    病室管理情報クローズ処理
      *****************************************************************
       4201-BRM-CLOSE-SEC              SECTION.
      *
           MOVE    "SYSKANRI-KEY" TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       4201-BRM-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    病棟情報更新処理
      *****************************************************************
       4201-BTU-UPDATE-SEC             SECTION.
      *
      *    アップデート対象のデータを読み直す
            MOVE   SPA-GMN-W20-BTU-NUM
                                   TO  WRK-BTU-NUM
            MOVE   SPA-NAI-W20-YUKOSTYMD-OLD
                                   TO  WRK-KIJUN-YMD
            PERFORM    4200-BTU-SEL-SEC
            IF   ( FLG-SYSKANRI    NOT =   ZERO )
               MOVE    "1201"      TO  SPA-ERRCD
               GO  TO  4201-BTU-UPDATE-EXT
            END-IF
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
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *
           MOVE    "SYSKANRI-UPD1" TO  WRK-DBPATH
      *
           PERFORM 900-TBL-UPDATE-SEC
      *
           IF   (  FLG-DBRC        NOT =   ZERO )
               MOVE    "1201"      TO  SPA-ERRCD
               GO  TO  4201-BTU-UPDATE-EXT
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
      *     更新対象のデータが既に存在しないかチェック
            MOVE   SPA-GMN-W20-BTU-NUM
                                   TO  WRK-BTU-NUM
            MOVE   SPA-NAI-W20-YUKOSTYMD
                                   TO  WRK-KIJUN-YMD
            PERFORM    4200-BTU-SEL-SEC
            IF   ( FLG-SYSKANRI    =   ZERO )
               MOVE    "1202"      TO  SPA-ERRCD
               GO  TO  4201-BTU-INSERT-EXT
            END-IF
      *
           MOVE    SPACE       TO  SYS-5001-REC
           INITIALIZE              SYS-5001-REC
      *
      *    病棟情報編集処理
           PERFORM 4201-BTU-EDIT-SEC
      *
      *    病棟加算情報編集処理
           PERFORM 4201-BTU-KSN-EDIT-SEC
      *
           MOVE    SYS-5001-REC    TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-INSERT-SEC
           IF   (  FLG-DBRC        NOT =   ZERO )
               MOVE    "1202"      TO  SPA-ERRCD
               GO  TO  4201-BTU-INSERT-EXT
           END-IF
           .
      *
       4201-BTU-INSERT-EXT.
           EXIT.
      *****************************************************************
      *    病棟情報削除処理
      *****************************************************************
       4201-BTU-DELETE-SEC             SECTION.
      *
           INITIALIZE              SYS-5001-REC
           MOVE    "5001"          TO  SYS-5001-KANRICD
           MOVE    SPA-GMN-W20-BTU-NUM TO  SYS-5001-KBNCD
           MOVE    SPA-NAI-W20-YUKOSTYMD-OLD
                                   TO  SYS-5001-STYUKYMD
           MOVE    SPA-NAI-W20-YUKOEDYMD-OLD
                                   TO  SYS-5001-EDYUKYMD
           MOVE    SYS-5001-REC    TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-DELETE-SEC
           IF   (  FLG-DBRC        NOT =   ZERO )
               MOVE    "1203"      TO  SPA-ERRCD
               GO  TO  4201-BTU-DELETE-EXT
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
           MOVE    "5001"      TO  SYS-5001-KANRICD
      *
      *    区分コード
           MOVE    SPA-GMN-W20-BTU-NUM
                               TO  WRK-BTU-NUM
           MOVE    WRK-BTU-NUM
                               TO  SYS-5001-KBNCD
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
           MOVE    WRK-BTU-NUM TO  SYS-5001-BTU-NUM
      *
      *    病棟名称
           MOVE    SPA-GMN-W20-BTU-NAME
                               TO  SYS-5001-BTU-NAME
      *
      *    病棟短縮名称
           MOVE    SPA-GMN-W20-BTU-TANNAME
                               TO  SYS-5001-BTU-TANNAME
      *
      *    特定入院料
           MOVE    SPA-GMN-W20-BTU-TOKNYUIN-CD
                               TO  SYS-5001-BTU-TOKTEI-NYUIN
      *
      *    病棟科
           MOVE    SPA-GMN-W20-BTU-KA-CD
                               TO  SYS-5001-BTU-KA
      *
      *    病棟種別
           MOVE    SPA-GMN-W20-BTU-SBT-CD
                               TO  SYS-5001-BTU-SBT
      *
      *    平均在院日数区分
           MOVE    SPA-GMN-W20-BTU-HEIZAIKBN-CD
                               TO  SYS-5001-BTU-HEIKINZAIKBN
      *
      *    看護配置区分
           MOVE    SPA-GMN-W20-BTU-KNGHAIKBN-CD
                               TO  SYS-5001-BTU-KNGHAICHIKBN
      *
      *    看護師比率区分
           MOVE    SPA-GMN-W20-BTU-KNGHIRIT-CD
                               TO  SYS-5001-BTU-KNGHIRITUKBN
      *
      *    看護補助配置区分
           MOVE    SPA-GMN-W20-BTU-KNGHJOHAI-CD
                               TO  SYS-5001-BTU-KNGHJOHAI
      *
      *    看護補助加算区分
           MOVE    SPA-GMN-W20-BTU-KNGHJOKSN-CD
                               TO  SYS-5001-BTU-KNGHJOKSN
      *
      *    夜間勤務等看護加算区分
           MOVE    SPA-GMN-W20-BTU-YKNKNGKSN-CD
                               TO  SYS-5001-BTU-YAKANKNGKSN
      *
      *    食堂加算区分
           IF    ( SPA-GMN-W20-CHK-BTU-SYOKUDOKBN  =   "T" )
               MOVE    "2"     TO  SYS-5001-BTU-SYOKUDOKBN
           ELSE
               MOVE    "1"     TO  SYS-5001-BTU-SYOKUDOKBN
           END-IF
      *
      *    看護師人数区分
           IF    ( SPA-GMN-W20-CHK-BTU-KNGSIS  =   "T" )
               MOVE    "2"     TO  SYS-5001-BTU-KNGSISUKBN
           ELSE
               MOVE    "1"     TO  SYS-5001-BTU-KNGSISUKBN
           END-IF
      *
      *    保育士人数区分
           IF    ( SPA-GMN-W20-CHK-BTU-HIKSIS  =   "T" )
               MOVE    "2"     TO  SYS-5001-BTU-HIKSISUKBN
           ELSE
               MOVE    "1"     TO  SYS-5001-BTU-HIKSISUKBN
           END-IF
      *
      *    レセプト表示区分
           MOVE    SPA-GMN-W20-RECEDSPKBN-CD
                               TO  SYS-5001-RECEDSPKBN
      *
      *    入院基本料点数コード
           MOVE    SPA-NAI-W20-BTU-KHNSRYCD
                               TO  SYS-5001-BTU-KHNSRYCD
      *
      *    病棟終了区分
           MOVE    SPA-GMN-W20-BTU-EDKBN-CD
                               TO  SYS-5001-BTU-EDKBN
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
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   3 )
               MOVE    CONST-YORYOCD (IDX1)
                                   TO  SYS-5001-YORYO-CD (IDX1)
               MOVE    "1"         TO  SYS-5001-YORYO-KBN (IDX1)
           END-PERFORM
      *
      *    児童・思春期精神科入院医療管理加算
           MOVE    CONST-JIDOCD    TO  SYS-5001-JIDO-CD
           MOVE    "1"             TO  SYS-5001-JIDO-KBN
      *
      *    精神科応急入院施設管理加算
           MOVE    CONST-SEISINCD  TO  SYS-5001-SEISIN-CD
           MOVE    "1"             TO  SYS-5001-SEISIN-KBN
      *
      *    看護配置加算
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   5 )
               MOVE    CONST-KANGOCD (IDX1)
                                   TO  SYS-5001-KANGO-CD (IDX1)
               MOVE    "1"         TO  SYS-5001-KANGO-KBN (IDX1)
           END-PERFORM
      *
           .
       4201-BTU-KSN-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病棟番号
      *****************************************************************
       4100-BTU-NUM-CHK-SEC            SECTION.
      *
           MOVE    1               TO  SPA-GMN-W20-CUR
      *
           MOVE    W20-BTU-NUM     TO  SPA-GMN-W20-BTU-NUM
      *
           PERFORM 4101-BTU-NUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               PERFORM 420-CLEAR-SEC
               GO  TO  4100-BTU-NUM-CHK-EXT
           END-IF
      *
      *    入力項目領域編集処理
           MOVE    SPA-GMN-W20-BTU-NUM TO  WRK-BTU-NUM
           MOVE    SPA-SYSYMD          TO  WRK-KIJUN-YMD
      *
      *    画面初期化
           PERFORM 420-CLEAR-SEC
      *
           PERFORM 4100-INPUT-AREA-EDIT-SEC
           IF    ( FLG-INPUT-AREA      =   ZERO )
      *
               PERFORM 4100-BTU-NUM-LSTSEL-SEC
               IF    ( FLG-BTU-NUM =   ZERO )
                   MOVE    IDX-BTULST
                                   TO  SPA-GMN-W20-BTULST-SEL-NUM
               END-IF
      *
      *        履歴データ編集処理
               PERFORM 4100-RIREKI-AREA-EDIT-SEC
           ELSE
               PERFORM 420-CLEAR-SEC
               MOVE    W20-BTU-NUM     TO  SPA-GMN-W20-BTU-NUM
      *        有効期間の開始日と終了日を設定
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
      *
      *        システム管理情報再設定
               PERFORM 4100-SYS-KANRI-SAI-SET-SEC
      *
               MOVE    SPA-GMN-W20-BTU-EDKBN-ITM (1)
                                       TO  SPA-GMN-W20-BTU-EDKBN
      *
               MOVE    SPA-NAI-W20-YUKOSTYMD
                                       TO  SPA-NAI-W20-YUKOSTYMD-MOT
      *
           END-IF
      *
           MOVE    2               TO  SPA-GMN-W20-CUR
           .
      *
       4100-BTU-NUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟番号
      *****************************************************************
       4101-BTU-NUM-CHK-SEC            SECTION.
      *
           IF    ( SPA-GMN-W20-BTU-NUM     =   ZERO )
               MOVE    "1101"          TO  SPA-ERRCD
               MOVE    1               TO  SPA-GMN-W20-CUR
               GO  TO  4101-BTU-NUM-CHK-EXT
           END-IF
           .
      *
       4101-BTU-NUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟名称
      *****************************************************************
       4100-BTU-NAME-CHK-SEC           SECTION.
      *
      *    全角半角チェック
           MOVE    SPA-GMN-W20-BTU-NAME
                                   TO  WRK-KANACHK-MAE-INPUT
           PERFORM 800-ENRTRY-CHK-SEC
           IF    ( FLG-ENTRYCHK    NOT =   ZERO )
               MOVE    2           TO  SPA-GMN-W20-CUR
               MOVE    "0002"      TO  SPA-ERRCD
               GO  TO  4100-BTU-NAME-CHK-EXT
           END-IF
      *
           .
      *
       4100-BTU-NAME-CHK-EXT.
           EXIT.
      *****************************************************************
      *    短縮病棟名
      *****************************************************************
       4100-BTU-TANNAME-CHK-SEC        SECTION.
      *
      *    全角半角チェック
           MOVE    SPA-GMN-W20-BTU-TANNAME
                                   TO  WRK-KANACHK-MAE-INPUT
           PERFORM 800-ENRTRY-CHK-SEC
           IF    ( FLG-ENTRYCHK    NOT =   ZERO )
               MOVE    3           TO  SPA-GMN-W20-CUR
               MOVE    "0002"      TO  SPA-ERRCD
               GO  TO  4100-BTU-TANNAME-CHK-EXT
           END-IF
      *
           .
      *
       4100-BTU-TANNAME-CHK-EXT.
           EXIT.
      *****************************************************************
      *    特定入院料
      *****************************************************************
       4100-BTU-TOKUTEINYUIN-CHK-SEC   SECTION.
      *
      *
           IF    ( SPA-GMN-W20-BTU-TOKNYUIN    =   SPACE )
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W20-CHK-BTU-HIKSIS-STT
               MOVE    "F"         TO  SPA-GMN-W20-CHK-BTU-HIKSIS
               GO  TO  4100-BTU-TOKUTEINYUIN-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W20-BTU-TOKNYUIN-CD
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-TOKUTEINYUIN-SRH-SEC
           IF    ( WRK-KANRIDAT1   =   SPACE )
               MOVE    4           TO  SPA-GMN-W20-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-BTU-TOKUTEINYUIN-CHK-EXT
           END-IF
      *
           MOVE    WRK-KANRIDAT1
                                   TO  SPA-GMN-W20-BTU-TOKNYUIN
      *
           IF    ( SPA-GMN-W20-BTU-TOKNYUIN-CD
                                   =   "01" OR "02" )
               MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-W20-CHK-BTU-HIKSIS-STT
           ELSE
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W20-CHK-BTU-HIKSIS-STT
               MOVE    "F"         TO  SPA-GMN-W20-CHK-BTU-HIKSIS
           END-IF
      *
           .
      *
       4100-BTU-TOKUTEINYUIN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟科名
      *****************************************************************
       4100-BTU-KA-CHK-SEC             SECTION.
      *
           IF    ( SPA-GMN-W20-BTU-KA  =   SPACE )
               GO  TO  4100-BTU-KA-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W20-BTU-KA-CD
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-KA-SRH-SEC
           IF    ( WRK-KANRIDAT1   =   SPACE )
               MOVE    5           TO  SPA-GMN-W20-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-BTU-KA-CHK-EXT
           END-IF
      *
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-BTU-KA
      *
           .
      *
       4100-BTU-KA-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟種別
      *****************************************************************
       4100-BTU-SBT-CHK-SEC            SECTION.
      *
           INITIALIZE  SPA-NAI-W20-BTU-KHNSRYCD-TBL
                       SPA-GMN-W20-CMB-BTU-KHNRYO
                       SPA-NAI-W20-BTU-KHNTEN-TBL
      *
           IF    ( SPA-GMN-W20-BTU-SBT =   SPACE )
               MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-W20-BTU-KNGHJOHAI-STT
                                       SPA-GMN-W20-BTU-KNGHJOHAI-ITM-STT
               MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-W20-BTU-KNGHJOKSN-STT
                                       SPA-GMN-W20-BTU-KNGHJOKSN-ITM-STT
               MOVE    SPACE       TO  SPA-GMN-W20-BTU-KHNRYO
               GO  TO  4100-BTU-SBT-CHK-EXT
           END-IF
      *
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W20-BTU-SBT-CD
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-SBT-SRH-SEC
           IF    ( WRK-KANRIDAT1   =   SPACE )
               MOVE    6           TO  SPA-GMN-W20-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-BTU-SBT-CHK-EXT
           END-IF
      *
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-BTU-SBT
      *
      *    療養・老人・有床療養以外は看護補助配置を入力不可とする
           IF    ( SPA-GMN-W20-BTU-SBT-CD  =   "04" OR "07" OR "09" )
               MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-W20-BTU-KNGHJOHAI-STT
                                       SPA-GMN-W20-BTU-KNGHJOHAI-ITM-STT
           ELSE
               MOVE    SPACE       TO  SPA-GMN-W20-BTU-KNGHJOHAI
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W20-BTU-KNGHJOHAI-STT
                                       SPA-GMN-W20-BTU-KNGHJOHAI-ITM-STT
           END-IF
      *
      *    療養・老人・有床・有床療養は看護補助配置を入力不可とする
           IF    ( SPA-GMN-W20-BTU-SBT-CD  =   "04" OR "07" OR "08"
                                           OR  "09" )
               MOVE    SPACE       TO  SPA-GMN-W20-BTU-KNGHJOKSN
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W20-BTU-KNGHJOKSN-STT
                                       SPA-GMN-W20-BTU-KNGHJOKSN-ITM-STT
           ELSE
               MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-W20-BTU-KNGHJOKSN-STT
                                       SPA-GMN-W20-BTU-KNGHJOKSN-ITM-STT
           END-IF
      *
      *    入院基本料コンボ編集処理
           PERFORM 4100-NYUKHN-KHNRYO-CMB-EDT-SEC
      *    看護師人数チェックボタンの活性編集
           IF    ( SPA-GMN-W20-BTU-SBT-CD
                                   =   "08" )
               MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-W20-CHK-BTU-KNGSIS-STT
           ELSE
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W20-CHK-BTU-KNGSIS-STT
               MOVE    "F"         TO  SPA-GMN-W20-CHK-BTU-KNGSIS
           END-IF
      *
           IF  ( SPA-GMN-W20-BTU-SBT-CD
                               NOT =   SPA-NAI-W20-BTU-SBT-MOT )
      *
               MOVE    SPACE       TO  SPA-GMN-W20-RECEDSPKBN
               PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1        >   SPA-GMN-W20-RECEDSPKBN-CNT )
      *
                   IF    ( SPA-GMN-W20-RECEDSPKBN-ITM2 (IDX1)
                                       =   SPA-GMN-W20-BTU-SBT-CD )
                       MOVE    SPA-GMN-W20-RECEDSPKBN-ITM (IDX1)
                                   TO      SPA-GMN-W20-RECEDSPKBN
                       MOVE    SPA-GMN-W20-RECEDSPKBN-CNT
                                   TO      IDX1
                   END-IF
      *
               END-PERFORM
      *
           END-IF
      *
           .
      *
       4100-BTU-SBT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院基本料コンボ編集処理
      *****************************************************************
       4100-NYUKHN-KHNRYO-CMB-EDT-SEC  SECTION.
      *
           MOVE    ZERO            TO  FLG-TENSU
      *
           INITIALIZE  SPA-NAI-W20-BTU-KHNSRYCD-TBL
                       SPA-GMN-W20-CMB-BTU-KHNRYO
                       SPA-NAI-W20-BTU-KHNTEN-TBL
      *
      *    点数マスタ検索処理
           PERFORM 4100-TENSU-SEL-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-TENSU       NOT =   ZERO )
                OR       ( IDX1    >       50 )
      *
               MOVE    IDX1        TO  SPA-GMN-W20-BTU-KHNRYO-CNT
      *
               MOVE    TNS-SRYCD   TO  SPA-NAI-W20-BTU-KHNSRYCD-ITM
                                                       (IDX1)
      *
               MOVE    IDX1        TO  WRK-99
               MOVE    WRK-99      TO  SPA-GMN-W20-BTU-KHNRYO-ITM
                                                       (IDX1) (1 : 2)
               MOVE    TNS-NAME    TO  SPA-GMN-W20-BTU-KHNRYO-ITM
                                                       (IDX1) (4 : )
      *
               MOVE    TNS-TEN     TO  SPA-NAI-W20-BTU-KHNTEN-ITM
                                                       (IDX1)
      *
      *        点数マスタ読込処理
               PERFORM 4100-TENSU-READ-SEC
      *
           END-PERFORM
      *
      *    点数マスタクローズ処理
           PERFORM 4100-TENSU-CLOSE-SEC
      *
           .
      *
       4100-NYUKHN-KHNRYO-CMB-EDT-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索処理
      *****************************************************************
       4100-TENSU-SEL-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-TENSU
      *
           INITIALIZE  TNS-TENSU-REC
      *
           IF    ( SPA-GMN-W20-BTU-SBT-CD
                                   =   "07" )
               MOVE    "-"         TO  TNS-CDKBN-KBN
           ELSE
               MOVE    "A"         TO  TNS-CDKBN-KBN
           END-IF
      *
      *    区分番号設定処理
           PERFORM 4100-CDKBNNUM-SET-SEC
           MOVE    WRK-CDKBNNUM    TO  TNS-CDKBN-KBNNUM
           MOVE    WRK-CDKOUBAN    TO  TNS-CDKBN-KOUBAN
           MOVE    WRK-TK-CDKBNNUM TO  TNSXX-TK-CDKBN-KBNNUM
           MOVE    WRK-TK-CDKOUBAN TO  TNSXX-TK-CDKBN-KOUBAN
      *
      *
           MOVE    SPA-NAI-W20-YUKOSTYMD
                                   TO  ORC-DBYMD
      *
      *    点数マスタ検索
           EVALUATE    SPA-GMN-W20-BTU-SBT-CD
           WHEN    "01"
           WHEN    "02"
           WHEN    "03"
               MOVE    "TENSU-KEY15"   TO  WRK-DBPATH
           WHEN    "07"
               MOVE    "TENSU-KEY14"   TO  WRK-DBPATH
           WHEN    OTHER
               MOVE    "TENSU-KEY13"   TO  WRK-DBPATH
           END-EVALUATE
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           PERFORM 900-TBL-SELECT-SEC
      *
           IF    ( FLG-DBRC    =   ZERO )
               MOVE    MCPDATA-REC TO  TNS-TENSU-REC
           ELSE
               MOVE    1           TO  FLG-TENSU
               GO  TO  4100-TENSU-SEL-EXT
           END-IF
      *
           .
      *
       4100-TENSU-SEL-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ読込処理
      *****************************************************************
       4100-TENSU-READ-SEC             SECTION.
      *
           PERFORM 900-TBL-READ-SEC
           IF    ( FLG-DBRC        =   ZERO )
               MOVE    MCPDATA-REC TO  TNS-TENSU-REC
           ELSE
               MOVE    1           TO  FLG-TENSU
           END-IF
      *
           .
      *
       4100-TENSU-READ-EXT.
           EXIT.
      *****************************************************************
      *    点数クローズ処理
      *****************************************************************
       4100-TENSU-CLOSE-SEC             SECTION.
      *
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
      *
       4100-TENSU-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    区分番号設定処理
      *****************************************************************
       4100-CDKBNNUM-SET-SEC           SECTION.
      *
           INITIALIZE                  WRK-CDKBNNUM
                                       WRK-CDKOUBAN
                                       WRK-TK-CDKBNNUM
                                       WRK-TK-CDKOUBAN
      *
           EVALUATE    SPA-GMN-W20-BTU-SBT-CD
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
       4100-CDKBNNUM-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院基本料設定処理
      *****************************************************************
       4100-BTU-KHNRYO-SET-SEC         SECTION.
      *
           MOVE    ZERO            TO  FLG-BTU-KHNRYO
      *
           INITIALIZE                  SPA-NAI-W20-BTU-KHNSRYCD
                                       SPA-GMN-W20-BTU-KHNRYO
                                       SPA-NAI-W20-BTU-KHNTEN
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL ( IDX1        >   50 )
                OR   ( FLG-BTU-KHNRYO
                                   =   1 )
                OR   ( SPA-NAI-W20-BTU-KHNSRYCD-ITM (IDX1)
                                   =   SPACE )
      *
               IF  (  SPA-NAI-W20-BTU-KHNSRYCD-ITM (IDX1)
                                   =   WRK-SRYCD-KEY )
                   MOVE    1       TO  FLG-BTU-KHNRYO
      *
                   MOVE    SPA-NAI-W20-BTU-KHNSRYCD-ITM (IDX1)
                                   TO  SPA-NAI-W20-BTU-KHNSRYCD
      *
                   MOVE    SPA-GMN-W20-BTU-KHNRYO-ITM (IDX1)
                                   TO  SPA-GMN-W20-BTU-KHNRYO
      *
                   MOVE    SPA-NAI-W20-BTU-KHNTEN-ITM (IDX1)
                                   TO  SPA-NAI-W20-BTU-KHNTEN
      *
               END-IF
      *
           END-PERFORM
      *
           .
      *
       4100-BTU-KHNRYO-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    平均在院日数
      *****************************************************************
       4100-BTU-HEIKINZAIKBN-CHK-SEC   SECTION.
      *
      *
           IF    ( SPA-GMN-W20-BTU-HEIZAIKBN
                                   =   SPACE )
               GO  TO  4100-BTU-HEIKINZAIKBN-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W20-BTU-HEIZAIKBN-CD
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-HEIKINZAIKBN-SRH-SEC
           IF    ( WRK-KANRIDAT1   =   SPACE )
               MOVE    7           TO  SPA-GMN-W20-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-BTU-HEIKINZAIKBN-CHK-EXT
           END-IF
      *
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-BTU-HEIZAIKBN
      *
           .
      *
       4100-BTU-HEIKINZAIKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    看護配置
      *****************************************************************
       4100-BTU-KNGHAICHIKBN-CHK-SEC   SECTION.
      *
           IF    ( SPA-GMN-W20-BTU-KNGHAIKBN
                                   =   SPACE )
               GO  TO  4100-BTU-KNGHAICHIKBN-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W20-BTU-KNGHAIKBN-CD
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-KNGHAICHIKBN-SRH-SEC
           IF    ( WRK-KANRIDAT1   =   SPACE )
               MOVE    8           TO  SPA-GMN-W20-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-BTU-KNGHAICHIKBN-CHK-EXT
           END-IF
      *
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-BTU-KNGHAIKBN
      *
           .
      *
       4100-BTU-KNGHAICHIKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    看護師比率
      *****************************************************************
       4100-BTU-KNGHIRITUKBN-CHK-SEC   SECTION.
      *
           IF    ( SPA-GMN-W20-BTU-KNGHIRIT
                                   =   SPACE )
               GO  TO  4100-BTU-KNGHIRITUKBN-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W20-BTU-KNGHIRIT-CD
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-KNGHIRITUKBN-SRH-SEC
           IF    ( WRK-KANRIDAT1   =   SPACE )
               MOVE    9           TO  SPA-GMN-W20-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-BTU-KNGHIRITUKBN-CHK-EXT
           END-IF
      *
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-BTU-KNGHIRIT
           .
      *
       4100-BTU-KNGHIRITUKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    看護補助配置
      *****************************************************************
       4100-BTU-KNGHJOHAI-CHK-SEC      SECTION.
      *
           IF    ( SPA-GMN-W20-BTU-KNGHJOHAI
                                   =   SPACE )
               GO  TO  4100-BTU-KNGHJOHAI-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W20-BTU-KNGHJOHAI-CD
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-KNGHJOHAI-SRH-SEC
           IF    ( WRK-KANRIDAT1   =   SPACE )
               MOVE    10          TO  SPA-GMN-W20-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-BTU-KNGHJOHAI-CHK-EXT
           END-IF
      *
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-BTU-KNGHJOHAI
      *
           .
      *
       4100-BTU-KNGHJOHAI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    看護補助加算
      *****************************************************************
       4100-BTU-KNGHJOKSN-CHK-SEC      SECTION.
      *
           IF    ( SPA-GMN-W20-BTU-KNGHJOKSN
                                   =   SPACE )
               GO  TO  4100-BTU-KNGHJOKSN-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W20-BTU-KNGHJOKSN-CD
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-KNGHJOKSN-SRH-SEC
           IF    ( WRK-KANRIDAT1   =   SPACE )
               MOVE    11          TO  SPA-GMN-W20-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-BTU-KNGHJOKSN-CHK-EXT
           END-IF
      *
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-BTU-KNGHJOKSN
      *
           .
      *
       4100-BTU-KNGHJOKSN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    夜間勤務等看護加算
      *****************************************************************
       4100-BTU-YAKANKNGKSN-CHK-SEC    SECTION.
      *
      *
           IF    ( SPA-GMN-W20-BTU-YKNKNGKSN
                                   =   SPACE )
               GO  TO  4100-BTU-YAKANKNGKSN-CHK-EXT
      *
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W20-BTU-YKNKNGKSN-CD
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-YAKANKNGKSN-SRH-SEC
           IF    ( WRK-KANRIDAT1   =   SPACE )
               MOVE    12          TO  SPA-GMN-W20-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-BTU-YAKANKNGKSN-CHK-EXT
           END-IF
      *
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-BTU-YKNKNGKSN
      *
           .
      *
       4100-BTU-YAKANKNGKSN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    食堂加算区分
      *****************************************************************
       4100-BTU-SYOKUDOKBN-CHK-SEC     SECTION.
      *
      *
           .
      *
       4100-BTU-SYOKUDOKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    看護師人数
      *****************************************************************
       4100-BTU-KNGSISUKBN-CHK-SEC     SECTION.
      *
      *
           .
      *
       4100-BTU-KNGSISUKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    保育士人数
      *****************************************************************
       4100-BTU-HIKSISUKBN-CHK-SEC     SECTION.
      *
      *
           .
      *
       4100-BTU-HIKSISUKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    レセプト表示区分
      *****************************************************************
       4100-RECEDSPKBN-CHK-SEC     SECTION.
      *
           IF    ( SPA-GMN-W20-RECEDSPKBN
                                   =   SPACE )
               GO  TO  4100-RECEDSPKBN-CHK-EXT
      *
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W20-RECEDSPKBN-CD
                                   TO  WRK-KANRICD
           PERFORM 800-RECEDSPKBN-SRH-SEC
           IF    ( WRK-KANRIDAT1   =   SPACE )
               MOVE    16          TO  SPA-GMN-W20-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-RECEDSPKBN-CHK-EXT
           END-IF
      *
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-RECEDSPKBN
      *
           .
      *
       4100-RECEDSPKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    有効期間開始日
      *****************************************************************
       4100-YUKOSTYMD-CHK-SEC          SECTION.
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
               GO  TO  4100-YUKOSTYMD-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-W20-YUKOSTYMD
                                   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           IF  ( SPA-ERRCD         =   SPACE )
               MOVE    WRK-HENYMDG
                                   TO  SPA-GMN-W20-YUKOSTYMD
               MOVE    WRK-SYMD    TO  SPA-NAI-W20-YUKOSTYMD
           ELSE
               MOVE    WRK-YUKOSTYMD
                                   TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG
                                   TO  SPA-GMN-W20-YUKOSTYMD
               MOVE    WRK-SYMD    TO  SPA-NAI-W20-YUKOSTYMD
               MOVE    17          TO  SPA-GMN-W20-CUR
               GO  TO  4100-YUKOSTYMD-CHK-EXT
           END-IF
      *
           IF    ( SPA-NAI-W20-YUKOSTYMD   <   "20020401" )
               MOVE    "0003"      TO  SPA-ERRCD
               MOVE    "H14. 4. 1" TO  SPA-GMN-W20-YUKOSTYMD
               MOVE    "20020401"  TO  SPA-NAI-W20-YUKOSTYMD
               MOVE    17          TO  SPA-GMN-W20-CUR
               GO  TO  4100-YUKOSTYMD-CHK-EXT
           END-IF
      *
           IF    ( SPA-NAI-W20-YUKOSTYMD
                               NOT =   SPA-NAI-W20-YUKOSTYMD-MOT )
      *        システム管理情報再設定
               PERFORM 4100-SYS-KANRI-SAI-SET-SEC
           END-IF
      *
           .
      *
       4100-YUKOSTYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    有効期間終了日
      *****************************************************************
       4100-YUKOEDYMD-CHK-SEC           SECTION.
      *
           MOVE    SPA-NAI-W20-YUKOEDYMD
                                   TO  WRK-YUKOEDYMD
           MOVE    SPACE           TO  SPA-NAI-W20-YUKOEDYMD
      *
      *    日付妥当性チェック＆編集処理
           IF    ( SPA-GMN-W20-YUKOEDYMD   =   SPACE )
               MOVE    "99999999"  TO  SPA-GMN-W20-YUKOEDYMD
                                       SPA-NAI-W20-YUKOEDYMD
               GO  TO  4100-YUKOEDYMD-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-W20-YUKOEDYMD
                                   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           IF  ( SPA-ERRCD         =   SPACE )
               MOVE    WRK-HENYMDG
                                   TO  SPA-GMN-W20-YUKOEDYMD
               MOVE    WRK-SYMD    TO  SPA-NAI-W20-YUKOEDYMD
           ELSE
               MOVE    WRK-YUKOEDYMD
                                   TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG
                                   TO  SPA-GMN-W20-YUKOEDYMD
               MOVE    WRK-SYMD    TO  SPA-NAI-W20-YUKOEDYMD
               MOVE    18          TO  SPA-GMN-W20-CUR
               GO  TO  4100-YUKOEDYMD-CHK-EXT
           END-IF
      *
           .
      *
       4100-YUKOEDYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟終了区分
      *****************************************************************
       4100-BTU-EDKBN-CHK-SEC          SECTION.
      *
           IF    ( SPA-GMN-W20-BTU-EDKBN
                                   =   SPACE )
               MOVE    SPA-GMN-W20-BTU-EDKBN-ITM (1)
                                   TO  SPA-GMN-W20-BTU-EDKBN
               GO  TO  4100-BTU-EDKBN-CHK-EXT
      *
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           EVALUATE    SPA-GMN-W20-BTU-EDKBN-CD
           WHEN    "1"
               MOVE    1           TO  WRK-KANRIIDX
           WHEN    "2"
               MOVE    2           TO  WRK-KANRIIDX
           WHEN    OTHER
               MOVE    1           TO  WRK-KANRIIDX
           END-EVALUATE
      *
           MOVE    SPA-GMN-W20-BTU-EDKBN-ITM (WRK-KANRIIDX)
                                   TO  SPA-GMN-W20-BTU-EDKBN
      *
      *
           .
      *
       4100-BTU-EDKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院基本料
      *****************************************************************
       4100-BTU-KHNRYO-CHK-SEC         SECTION.
      *
      *
           INITIALIZE              SPA-NAI-W20-BTU-KHNSRYCD
                                   SPA-NAI-W20-BTU-KHNTEN
      *
           MOVE    W20-BTU-KHNRYO  TO  SPA-GMN-W20-BTU-KHNRYO
      *
           IF    ( SPA-GMN-W20-BTU-KHNRYO
                                   =   SPACE )
      *
      *        入院基本料を求める
               PERFORM 4100-NYUKHN-KHNTEN-GET-SEC
               MOVE    206         TO  SPA-GMN-W20-CUR
               GO  TO  4100-BTU-KHNRYO-CHK-EXT
      *
           END-IF
      *
      *    入院基本料チェック
           PERFORM 4101-BTU-KHNRYO-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4100-BTU-KHNRYO-CHK-EXT
           END-IF
      *
      *    診療行為コードで入院基本マスタを検索
      *    入院基本点数をサブプロより取得する
           INITIALIZE W20SUB01-LNK
           MOVE    "1"             TO  W20SUB01-I-KBN
           MOVE    SPA-NAI-W20-BTU-KHNSRYCD
                                   TO  W20SUB01-I-KHNSRYCD
           MOVE    SPA-NAI-W20-YUKOSTYMD
                                   TO  W20SUB01-I-KJNYMD
      *
           CALL    "ORCGW20SUB01"      USING
                                       W20SUB01-LNK
           IF    ( W20SUB01-O-RC   =   ZERO )
      *        サブプロからの返却値の内容で看護配置等を置き換える
               PERFORM 4100-BTU-ITEM-REPLACE-SEC
               PERFORM 4101-NYUKHN-COD-TAIHI-SEC
           END-IF
      *
           MOVE    206             TO  SPA-GMN-W20-CUR
      *
           .
      *
       4100-BTU-KHNRYO-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院基本料
      *****************************************************************
       4101-BTU-KHNRYO-CHK-SEC         SECTION.
      *
           MOVE    ZERO            TO  FLG-BTU-KHNRYO
      *
      *    コンボに該当のコードが存在するかチェック
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL ( IDX1        >   50 )
                OR   ( FLG-BTU-KHNRYO
                                   =   1 )
                OR   ( SPA-GMN-W20-BTU-KHNRYO-ITM (IDX1)
                                   =   SPACE )
      *
               IF  (  SPA-GMN-W20-BTU-KHNRYO-ITM (IDX1) (1 : 2)
                                   =   SPA-GMN-W20-BTU-KHNRYO-CD )
      *
                   MOVE    1       TO  FLG-BTU-KHNRYO
      *
                   MOVE    SPA-NAI-W20-BTU-KHNSRYCD-ITM (IDX1)
                                   TO  SPA-NAI-W20-BTU-KHNSRYCD
      *
                   MOVE    SPA-GMN-W20-BTU-KHNRYO-ITM (IDX1)
                                   TO  SPA-GMN-W20-BTU-KHNRYO
      *
                   MOVE    SPA-NAI-W20-BTU-KHNTEN-ITM (IDX1)
                                   TO  SPA-NAI-W20-BTU-KHNTEN
      *
               END-IF
      *
           END-PERFORM
      *
           IF    ( FLG-BTU-KHNRYO =    ZERO )
               MOVE    "0001"      TO  SPA-ERRCD
               MOVE    20          TO  SPA-GMN-W20-CUR
               GO  TO  4101-BTU-KHNRYO-CHK-EXT
           END-IF
      *
           .
      *
       4101-BTU-KHNRYO-CHK-EXT.
           EXIT.
      *****************************************************************
      *    項目置換え処理
      *****************************************************************
       4100-BTU-ITEM-REPLACE-SEC       SECTION.
      *
           MOVE    SPACE           TO  WRK-BTU-HEIZAIKBN
                                       WRK-BTU-KNGHAIKBN
                                       WRK-BTU-KNGHIRIT
                                       WRK-BTU-KNGHJOHAI
      *
      *    平均在院日数区分
           MOVE    W20SUB01-O-HEIKINZAIKBN
                           TO  WRK-KANRICD
           PERFORM 800-BTU-HEIKINZAIKBN-SRH-SEC
           IF    ( WRK-KANRIDAT1   NOT =   SPACE )
               MOVE    WRK-KANRIDAT1
                                   TO  WRK-BTU-HEIZAIKBN
           END-IF
      *
           IF    ( SPA-GMN-W20-BTU-SBT-CD  =   "01" OR "02" OR "03"
                                            OR "06" )
               MOVE    WRK-BTU-HEIZAIKBN
                                   TO  SPA-GMN-W20-BTU-HEIZAIKBN
           END-IF
      *
      *    看護配置区分
           MOVE    W20SUB01-O-KANGOHAICHIKBN
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-KNGHAICHIKBN-SRH-SEC
           IF    ( WRK-KANRIDAT1   NOT =   SPACE )
               MOVE    WRK-KANRIDAT1
                                   TO  WRK-BTU-KNGHAIKBN
           END-IF
      *
           MOVE    WRK-BTU-KNGHAIKBN
                               TO  SPA-GMN-W20-BTU-KNGHAIKBN
      *
      *    看護師比率区分
           MOVE    W20SUB01-O-KANGOHIRITUKBN
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-KNGHIRITUKBN-SRH-SEC
           IF    ( WRK-KANRIDAT1   NOT =   SPACE )
               MOVE    WRK-KANRIDAT1
                                   TO  WRK-BTU-KNGHIRIT
           END-IF
      *
           IF    ( SPA-GMN-W20-BTU-SBT-CD  =   "01" OR "02" OR "03"
                                            OR "04" OR "05" OR "06"
                                            OR "07" )
               MOVE    WRK-BTU-KNGHIRIT
                                   TO  SPA-GMN-W20-BTU-KNGHIRIT
           END-IF
      *
      *    看護補助配置区分
           MOVE    W20SUB01-O-KANGOHOJOHAICHIKBN
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-KNGHJOHAI-SRH-SEC
           IF    ( WRK-KANRIDAT1   NOT =   SPACE )
               MOVE    WRK-KANRIDAT1
                                   TO  WRK-BTU-KNGHJOHAI
           END-IF
      *
           IF    ( SPA-GMN-W20-BTU-SBT-CD  =   "04" OR "07" OR "08"
               OR                              "09" )
               MOVE    WRK-BTU-KNGHJOHAI
                                   TO  SPA-GMN-W20-BTU-KNGHJOHAI
           END-IF
      *
      *    看護師３人以上
           IF    ( SPA-GMN-W20-BTU-SBT-CD  =   "08" )
            AND  ( W20SUB01-O-SSTKIJUNKBN  =   "3" )
                   MOVE    "T"     TO  SPA-GMN-W20-CHK-BTU-KNGSIS
           ELSE
                   MOVE    "F"     TO  SPA-GMN-W20-CHK-BTU-KNGSIS
           END-IF
      *
           .
      *
       4100-BTU-ITEM-REPLACE-EXT.
           EXIT.
      *****************************************************************
      *    入院基本点数取得処理
      *****************************************************************
       4100-NYUKHN-KHNTEN-GET-SEC          SECTION.
      *
           IF    ( SPA-GMN-W20-CHK-BTU-KNGSIS
                                   =   SPA-NAI-W20-CHK-BTU-KNGSIS-MOT )
            AND  ( SPA-GMN-W20-BTU-SBT-CD
                                   =   SPA-NAI-W20-BTU-SBT-MOT )
            AND  ( SPA-GMN-W20-BTU-HEIZAIKBN-CD
                                   =   SPA-NAI-W20-BTU-HEIZAIKBN-MOT )
            AND  ( SPA-GMN-W20-BTU-KNGHAIKBN-CD
                                   =   SPA-NAI-W20-BTU-KNGHAIKBN-MOT )
            AND  ( SPA-GMN-W20-BTU-KNGHIRIT-CD
                                   =   SPA-NAI-W20-BTU-KNGHIRIT-MOT )
            AND  ( SPA-GMN-W20-BTU-KNGHJOHAI-CD
                                   =   SPA-NAI-W20-BTU-KNGHJOHAI-MOT )
               GO  TO  4100-NYUKHN-KHNTEN-GET-EXT
           END-IF
      *
           PERFORM 4101-NYUKHN-COD-TAIHI-SEC
      *
      *    入院基本点数をサブプロより取得する
           INITIALIZE W20SUB01-LNK
           MOVE    "2"             TO  W20SUB01-I-KBN
           MOVE    SPA-NAI-W20-YUKOSTYMD
                                   TO  W20SUB01-I-KJNYMD
      *
      *    IF    ( SPA-GMN-W20-CHK-BTU-KNGSIS  =   "T" )
      *        MOVE    "1"             TO  W20SUB01-I-KNGSISUKBN
      *    ELSE
      *        MOVE    SPACE           TO  W20SUB01-I-KNGSISUKBN
      *    END-IF
      *
           MOVE    SPA-GMN-W20-BTU-SBT-CD
                                       TO  W20SUB01-I-BTUSBTKBN
           MOVE    SPA-GMN-W20-BTU-HEIZAIKBN-CD
                                       TO  W20SUB01-I-HEIKINZAIKBN
           MOVE    SPA-GMN-W20-BTU-KNGHAIKBN-CD
                                       TO  W20SUB01-I-KANGOHAICHIKBN
           MOVE    SPA-GMN-W20-BTU-KNGHIRIT-CD
                                       TO  W20SUB01-I-KANGOHIRITUKBN
           MOVE    SPA-GMN-W20-BTU-KNGHJOHAI-CD
                                       TO  W20SUB01-I-KANGOHOJOHAICHIKBN
      *
           CALL    "ORCGW20SUB01"      USING
                                       W20SUB01-LNK
      *
           IF    ( W20SUB01-O-RC   =   ZERO )
               MOVE    W20SUB01-O-KHNSRYCD
                                   TO  WRK-SRYCD-KEY
      *
      *        入院基本料設定処理
               PERFORM 4100-BTU-KHNRYO-SET-SEC
           ELSE
               INITIALIZE              SPA-NAI-W20-BTU-KHNSRYCD
                                       SPA-GMN-W20-BTU-KHNRYO
                                       SPA-NAI-W20-BTU-KHNTEN
           END-IF
      *
           .
      *
       4100-NYUKHN-KHNTEN-GET-EXT.
           EXIT.
      *****************************************************************
      *    入院基本点数取得用コード退避処理
      *****************************************************************
       4101-NYUKHN-COD-TAIHI-SEC          SECTION.
      *
           MOVE    SPA-GMN-W20-CHK-BTU-KNGSIS
                                   TO  SPA-NAI-W20-CHK-BTU-KNGSIS-MOT
           MOVE    SPA-GMN-W20-BTU-SBT-CD
                                   TO  SPA-NAI-W20-BTU-SBT-MOT
           MOVE    SPA-GMN-W20-BTU-HEIZAIKBN-CD
                                   TO  SPA-NAI-W20-BTU-HEIZAIKBN-MOT
           MOVE    SPA-GMN-W20-BTU-KNGHAIKBN-CD
                                   TO  SPA-NAI-W20-BTU-KNGHAIKBN-MOT
           MOVE    SPA-GMN-W20-BTU-KNGHIRIT-CD
                                   TO  SPA-NAI-W20-BTU-KNGHIRIT-MOT
           MOVE    SPA-GMN-W20-BTU-KNGHJOHAI-CD
                                   TO  SPA-NAI-W20-BTU-KNGHJOHAI-MOT
      *
           .
      *
       4101-NYUKHN-COD-TAIHI-EXT.
           EXIT.
      *****************************************************************
      *    選択番号
      *****************************************************************
       4100-SELNUM-CHK-SEC             SECTION.
      *
           MOVE    W20-SELNUM      TO  SPA-GMN-W20-SELNUM
      *
           IF  (   SPA-GMN-W20-SELNUM  =   ZERO )
               MOVE    2           TO  SPA-GMN-W20-CUR
               GO  TO  4100-SELNUM-CHK-EXT
           END-IF
      *
      *    範囲内の番号が選択されていること
           IF    ( SPA-GMN-W20-SELNUM  >   SPA-GMN-W20-RIREKILST-CNT )
               MOVE    100         TO  SPA-GMN-W20-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-SELNUM-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-W20-SELNUM  TO  SPA-GMN-W20-RIREKILST-SEL-NUM
      *
      *    入力項目領域編集処理
           MOVE    SPA-NAI-W20-RIREKILST-BTU-NUM
                                   TO  WRK-BTU-NUM
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
           IF    ( SPA-GMN-W20-STATE   =   WIDGET-NORMAL )
               MOVE    2               TO  SPA-GMN-W20-CUR
           ELSE
               MOVE    100             TO  SPA-GMN-W20-CUR
           END-IF
           .
      *
       4100-SELNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟リスト
      *****************************************************************
       4100-BTULST-CHK-SEC                 SECTION.
      *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL     ( IDX2    >   50 )
               IF      (   W20-BTULST-SEL  (IDX2)  =   "T" )
      *
      *            入力項目領域編集処理
                   MOVE    SPA-GMN-W20-TBTU-NUM (IDX2)
                                           TO  WRK-BTU-NUM
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
                   MOVE    IDX2        TO  SPA-GMN-W20-BTULST-SEL-NUM
      *
                   MOVE    50          TO  IDX2
               END-IF
           END-PERFORM
      *
           .
       4100-BTULST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    履歴リスト
      *****************************************************************
       4100-RIREKILST-CHK-SEC      SECTION.
      *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL     ( IDX2    >   20 )
               IF    ( W20-RIREKILST-SEL (IDX2)
                                       =   "T" )
      *
      *            入力項目領域編集処理
                   MOVE    SPA-NAI-W20-RIREKILST-BTU-NUM
                                       TO  WRK-BTU-NUM
                   MOVE    SPA-NAI-W20-TRYUKOSTYMD (IDX2)
                                       TO  WRK-KIJUN-YMD
      *
      *            入力領域初期化
                   PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
                   PERFORM 4100-INPUT-AREA-EDIT-SEC
                   IF    ( SPA-GMN-W20-STATE   =   WIDGET-NORMAL )
                       MOVE    2           TO  SPA-GMN-W20-CUR
                   ELSE
                       MOVE    100         TO  SPA-GMN-W20-CUR
                   END-IF
      *
                   MOVE    IDX2        TO  SPA-GMN-W20-RIREKILST-SEL-NUM
                                           SPA-GMN-W20-SELNUM
      *
                   MOVE    20          TO  IDX2
               END-IF
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
           MOVE    ZERO            TO  FLG-INPUT-AREA
      *
      *    病棟情報検索処理
           PERFORM 4200-BTU-SEL-SEC
           IF    ( FLG-SYSKANRI    NOT =   ZERO )
               MOVE    1           TO  FLG-INPUT-AREA
               GO  TO  4100-INPUT-AREA-EDIT-EXT
           END-IF
      *
      *    画面状態
           IF    ( SYS-5001-EDYUKYMD   >=  SPA-SYSYMD )
               MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-W20-STATE
           ELSE
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W20-STATE
           END-IF
      *
      *    有効開始日
           MOVE    SYS-5001-STYUKYMD
                                   TO  SPA-NAI-W20-YUKOSTYMD
                                       SPA-NAI-W20-YUKOSTYMD-OLD
                                       WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-W20-YUKOSTYMD
      *
      *    有効終了日
           MOVE    SYS-5001-EDYUKYMD
                                   TO  SPA-NAI-W20-YUKOEDYMD
                                       SPA-NAI-W20-YUKOEDYMD-OLD
                                       WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-W20-YUKOEDYMD
      *
      *    システム管理情報再設定
           PERFORM 4100-SYS-KANRI-SAI-SET-SEC
      *
      *    病棟番号
           MOVE    SYS-5001-BTU-NUM
                                   TO  SPA-GMN-W20-BTU-NUM
      *
      *    病棟名称
           MOVE    SYS-5001-BTU-NAME
                                   TO  SPA-GMN-W20-BTU-NAME
      *
      *    短縮病棟名称
           MOVE    SYS-5001-BTU-TANNAME
                                   TO  SPA-GMN-W20-BTU-TANNAME
      *
      *    特定入院料
           MOVE    SYS-5001-BTU-TOKTEI-NYUIN
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-TOKUTEINYUIN-SRH-SEC
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-BTU-TOKNYUIN
      *
           IF    ( SPA-GMN-W20-BTU-TOKNYUIN-CD
                                   =   "01" OR "02" )
               MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-W20-CHK-BTU-HIKSIS-STT
           ELSE
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W20-CHK-BTU-HIKSIS-STT
           END-IF
      *
      *    病棟科名
           MOVE    SYS-5001-BTU-KA TO  WRK-KANRICD
           PERFORM 800-BTU-KA-SRH-SEC
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-BTU-KA
      *
      *    病棟種別
           MOVE    SYS-5001-BTU-SBT
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-SBT-SRH-SEC
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-BTU-SBT
      *
      *    療養・老人・有床療養以外は看護補助配置を入力不可とする
           IF    ( SPA-GMN-W20-BTU-SBT-CD  =   "04" OR "07" OR "09" )
               MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-W20-BTU-KNGHJOHAI-STT
                                       SPA-GMN-W20-BTU-KNGHJOHAI-ITM-STT
           ELSE
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W20-BTU-KNGHJOHAI-STT
                                       SPA-GMN-W20-BTU-KNGHJOHAI-ITM-STT
           END-IF
      *
      *    療養・老人・有床・有床療養は看護補助配置を入力不可とする
           IF    ( SPA-GMN-W20-BTU-SBT-CD  =   "04" OR "07" OR "08"
                                           OR  "09" )
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W20-BTU-KNGHJOKSN-STT
                                       SPA-GMN-W20-BTU-KNGHJOKSN-ITM-STT
           ELSE
               MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-W20-BTU-KNGHJOKSN-STT
                                       SPA-GMN-W20-BTU-KNGHJOKSN-ITM-STT
           END-IF
      *
      *
      *    平均在院日数
           MOVE    SYS-5001-BTU-HEIKINZAIKBN
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-HEIKINZAIKBN-SRH-SEC
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-BTU-HEIZAIKBN
      *
      *    看護配置
           MOVE    SYS-5001-BTU-KNGHAICHIKBN
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-KNGHAICHIKBN-SRH-SEC
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-BTU-KNGHAIKBN
      *
      *    看護比率
           MOVE    SYS-5001-BTU-KNGHIRITUKBN
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-KNGHIRITUKBN-SRH-SEC
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-BTU-KNGHIRIT
      *
      *    看護補助配置
           MOVE    SYS-5001-BTU-KNGHJOHAI
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-KNGHJOHAI-SRH-SEC
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-BTU-KNGHJOHAI
      *
      *    看護補助加算
           MOVE    SYS-5001-BTU-KNGHJOKSN
                                   TO  SPA-GMN-W20-BTU-KNGHJOKSN-CD
                                       WRK-KANRICD
           PERFORM 800-BTU-KNGHJOKSN-SRH-SEC
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-BTU-KNGHJOKSN
      *
      *    夜間勤務等看護加算
           MOVE    SYS-5001-BTU-YAKANKNGKSN
                                   TO  WRK-KANRICD
           PERFORM 800-BTU-YAKANKNGKSN-SRH-SEC
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-BTU-YKNKNGKSN
      *
      *    食堂加算
           IF    ( SYS-5001-BTU-SYOKUDOKBN     =   "2" )
               MOVE    "T" TO  SPA-GMN-W20-CHK-BTU-SYOKUDOKBN
           ELSE
               MOVE    "F" TO  SPA-GMN-W20-CHK-BTU-SYOKUDOKBN
           END-IF
      *
      *    看護師人数区分
           IF    ( SYS-5001-BTU-KNGSISUKBN     =   "2" )
               MOVE    "T" TO  SPA-GMN-W20-CHK-BTU-KNGSIS
           ELSE
               MOVE    "F" TO  SPA-GMN-W20-CHK-BTU-KNGSIS
           END-IF
      *
           IF    ( SPA-GMN-W20-BTU-SBT-CD  =   "08" )
               MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-W20-CHK-BTU-KNGSIS-STT
           ELSE
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W20-CHK-BTU-KNGSIS-STT
           END-IF
      *
      *    保育士人数区分
           IF    ( SYS-5001-BTU-HIKSISUKBN     =   "2" )
               MOVE    "T" TO  SPA-GMN-W20-CHK-BTU-HIKSIS
           ELSE
               MOVE    "F" TO  SPA-GMN-W20-CHK-BTU-HIKSIS
           END-IF
      *
           IF    ( SPA-GMN-W20-BTU-TOKNYUIN-CD =   "01" OR "02" )
               MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-W20-CHK-BTU-HIKSIS-STT
           ELSE
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W20-CHK-BTU-HIKSIS-STT
           END-IF
      *
      *    レセプト表示区分
           MOVE    SYS-5001-RECEDSPKBN
                                   TO  WRK-KANRICD
           PERFORM 800-RECEDSPKBN-SRH-SEC
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W20-RECEDSPKBN
      *
      *    病棟終了区分
           MOVE    SYS-5001-BTU-EDKBN
                                   TO  SPA-GMN-W20-BTU-EDKBN-CD
           EVALUATE    SPA-GMN-W20-BTU-EDKBN-CD
           WHEN    "1"
               MOVE    "1 "      TO  SPA-GMN-W20-BTU-EDKBN (1 : 2)
               MOVE    "継続"    TO  SPA-GMN-W20-BTU-EDKBN (4 : )
           WHEN    "2"
               MOVE    "2 "      TO  SPA-GMN-W20-BTU-EDKBN (1 : 2)
               MOVE    "廃止"    TO  SPA-GMN-W20-BTU-EDKBN (4 : )
           END-EVALUATE
      *
      *    入院基本料コンボ編集処理
           PERFORM 4100-NYUKHN-KHNRYO-CMB-EDT-SEC
      *
           MOVE    SYS-5001-BTU-KHNSRYCD
                                   TO  SPA-NAI-W20-BTU-KHNSRYCD
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
                                   TO  WRK-SRYCD-KEY
      *        入院基本料設定処理
               PERFORM 4100-BTU-KHNRYO-SET-SEC
               PERFORM 4101-NYUKHN-COD-TAIHI-SEC
           END-IF
      *
           .
       4100-INPUT-AREA-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病棟情報検索処理
      *****************************************************************
       4200-BTU-SEL-SEC                SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           INITIALIZE              SYS-5001-REC
           MOVE    "5001"          TO  SYS-5001-KANRICD
           MOVE    WRK-BTU-NUM     TO  SYS-5001-KBNCD
           MOVE    WRK-KIJUN-YMD   TO  ORC-DBYMD
           MOVE    SYS-5001-REC    TO  MCPDATA-REC
      *
      *    病棟情報検索
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    NOT =   ZERO )
               MOVE    1           TO  FLG-SYSKANRI
           ELSE
               MOVE    MCPDATA-REC
                                   TO  SYS-5001-REC
           END-IF
      *
      *    病棟情報クローズ
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       4200-BTU-SEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    履歴領域編集処理
      *****************************************************************
       4100-RIREKI-AREA-EDIT-SEC       SECTION.
      *
           INITIALIZE      SPA-GMN-W20-RIREKILST-TBL
                           SPA-NAI-W20-RIREKILST-TBL
      *
      *    病棟情報検索
           PERFORM         4100-BTU-SEL-SEC
           IF   (  FLG-SYSKANRI    =   ZERO )
               CONTINUE
           ELSE
               GO  TO  4100-RIREKI-AREA-EDIT-EXT
           END-IF
      *
           MOVE    SPA-GMN-W20-BTU-NUM
                                   TO  SPA-NAI-W20-RIREKILST-BTU-NUM
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYSKANRI    NOT =   ZERO )
                 OR      ( IDX1        >   20 )
      *
               MOVE    IDX1        TO  SPA-GMN-W20-RIREKILST-CNT
      *
      *        選択番号
               MOVE    IDX1        TO  SPA-GMN-W20-TRSELNUM (IDX1) 
      *
      *        有効開始日
               MOVE    SYS-5001-STYUKYMD
                                   TO  SPA-NAI-W20-TRYUKOSTYMD (IDX1) 
                                           WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG TO  SPA-GMN-W20-TRYUKOSTYMD (IDX1) 
      *
      *        有効終了日
               MOVE    SYS-5001-EDYUKYMD
                                   TO  SPA-NAI-W20-TRYUKOEDYMD (IDX1)
                                           WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG TO  SPA-GMN-W20-TRYUKOEDYMD (IDX1) 
      *
               IF    ( SPA-NAI-W20-YUKOSTYMD-OLD
                                   =   SPA-NAI-W20-TRYUKOSTYMD (IDX1))
                AND  ( SPA-NAI-W20-YUKOEDYMD-OLD
                                   =   SPA-NAI-W20-TRYUKOEDYMD (IDX1))
                   MOVE    IDX1    TO  SPA-GMN-W20-SELNUM
                   MOVE    IDX1    TO  SPA-GMN-W20-RIREKILST-SEL-NUM
               END-IF
      *
      *        病棟データ読込処理
               PERFORM 4100-BTU-READ-SEC
      *
           END-PERFORM
      *
      *    病棟データクローズ処理
           PERFORM 4100-BTU-CLOSE-SEC
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
           MOVE    WIDGET-NORMAL   TO  SPA-GMN-W20-STATE
      *
           IF    ( SPA-MOTOPG      =   "W01" )
               MOVE    "病室"      TO  SPA-GMN-W20-B09
           END-IF
      *
           MOVE    WIDGET-NORMAL   TO  SPA-GMN-W20-B02-STATE
                                       SPA-GMN-W20-B05-STATE
                                       SPA-GMN-W20-B06-STATE
                                       SPA-GMN-W20-B07-STATE
                                       SPA-GMN-W20-B08-STATE
                                       SPA-GMN-W20-B09-STATE
                                       SPA-GMN-W20-B12-STATE
                                       SPA-GMN-W20-BTU-KNGHJOHAI-STT
                                       SPA-GMN-W20-BTU-KNGHJOHAI-ITM-STT
                                       SPA-GMN-W20-BTU-KNGHJOKSN-STT
                                       SPA-GMN-W20-BTU-KNGHJOKSN-ITM-STT
      *
           IF    ( SPA-GMN-W20-BTULST-CNT  >=  50 )
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W20-B06-STATE
           END-IF
      *
           MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W20-CHK-BTU-KNGSIS-STT
                                       SPA-GMN-W20-CHK-BTU-HIKSIS-STT
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
           INITIALIZE  SPA-GMN-W20-RIREKILST-TBL
                       SPA-NAI-W20-RIREKILST-TBL
      *
           MOVE    ZERO        TO  SPA-GMN-W20-BTULST-SEL-NUM
      *
           .
       4201-RIREKI-AREA-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    システム管理情報再設定処理
      *****************************************************************
       4100-SYS-KANRI-SAI-SET-SEC         SECTION.
      *
      *    医療機関情報取得処理
           MOVE    SPA-NAI-W20-YUKOSTYMD
                                   TO  WRK-KJN-YUKSTYMD
           PERFORM 3101-SYS-1001-GET-SEC
      *
      *    コンボ初期処理
           MOVE    SPA-NAI-W20-YUKOSTYMD
                                   TO  WRK-KJN-YUKSTYMD
           PERFORM 3101-CMB-SYOKI-SEC
      *
           MOVE    SPA-NAI-W20-YUKOSTYMD
                                   TO  SPA-NAI-W20-YUKOSTYMD-MOT
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
           IF    ( SPA-GMN-W20-BTU-NAME    NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "1007"      TO  SPA-ERRCD
               MOVE    2           TO  SPA-GMN-W20-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    短縮病棟名が入力されていること
           IF    ( SPA-GMN-W20-BTU-TANNAME NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "1008"      TO  SPA-ERRCD
               MOVE    3           TO  SPA-GMN-W20-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    病院の場合、病院の種別が選択されていること
           IF    ( SPA-NAI-W20-HOSPSBT     =   1 )
               IF    ( SPA-GMN-W20-BTU-SBT-CD  =   "01"
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
               IF    ( SPA-GMN-W20-BTU-SBT-CD  =   "08"
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
               MOVE    17          TO  SPA-GMN-W20-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    有効期間終了日が入力されていること
           IF    ( SPA-NAI-W20-YUKOEDYMD   NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "1103"      TO  SPA-ERRCD
               MOVE    18          TO  SPA-GMN-W20-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    有効期間開始日≦有効期間終了日となっていること
           IF    ( SPA-NAI-W20-YUKOSTYMD   <=  SPA-NAI-W20-YUKOEDYMD )
               CONTINUE
           ELSE
               MOVE    "1004"      TO  SPA-ERRCD
               MOVE    17          TO  SPA-GMN-W20-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    有効期間終了日が過去日付でないこと
           IF    ( SPA-NAI-W20-YUKOEDYMD   >=  SPA-SYSYMD  )
               CONTINUE
           ELSE
               MOVE    "1005"      TO  SPA-ERRCD
               MOVE    18          TO  SPA-GMN-W20-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    特定入院料が設定されていない場合病棟ごとに必須項目を
      *    チェックする
           IF    ( SPA-GMN-W20-BTU-TOKNYUIN    =   SPACE )
      *
      *        病棟種別が設定されていること
               IF    ( SPA-GMN-W20-BTU-SBT-CD  NOT =   SPACE )
                   CONTINUE
               ELSE
                   MOVE    "1009"  TO  SPA-ERRCD
                   MOVE    6       TO  SPA-GMN-W20-CUR
                   GO  TO  4900-KANRENCHK-EXT
               END-IF
      *
               EVALUATE    SPA-GMN-W20-BTU-SBT-CD
      *
      *        一般病棟
               WHEN    "01"
                   PERFORM 4200-IPPAN-CHK-SEC
      *        精神病棟
               WHEN    "02"
                   PERFORM 4200-SEISIN-CHK-SEC
      *        結核病棟
               WHEN    "03"
                   PERFORM 4200-KEKKAKU-CHK-SEC
      *        療養病棟
               WHEN    "04"
                   PERFORM 4200-RYOYO-CHK-SEC
      *        障害者施設
               WHEN    "05"
                   PERFORM 4200-SYOGAI-CHK-SEC
      *        専門病院
               WHEN    "06"
                   PERFORM 4200-SENMON-CHK-SEC
      *        老人病棟
               WHEN    "07"
                   PERFORM 4200-ROJIN-CHK-SEC
      *        有床診療所入院基本料
               WHEN    "08"
                   PERFORM 4200-SINRYO-CHK-SEC
      *        有床診療所療養病床入院料
               WHEN    "09"
                   PERFORM 4200-SINRYORYOYO-CHK-SEC
               END-EVALUATE
      *
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4900-KANRENCHK-EXT
               END-IF
      *
      *        入院基本料が算定されていること
               IF    ( SPA-GMN-W20-BTU-KHNRYO  NOT =   SPACE )
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
      *       一般病棟の場合
      *****************************************************************
       4200-IPPAN-CHK-SEC              SECTION.
      *
      *    看護配置必須入力チェック
           PERFORM 4200-BTU-KNGHAIKBN-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4200-IPPAN-CHK-EXT
           END-IF
      *
      *    IF    ( SPA-W20-1006-TOKKINOHOSPKBN
      *                                =   "1" )
      *        平均在院日数必須入力チェック
      *        PERFORM 4200-BTU-HEIKINZAIKBN-CHK-SEC
      *        IF    ( SPA-ERRCD       NOT =   SPACE )
      *            GO  TO  4200-IPPAN-CHK-EXT
      *        END-IF
      *
      *        看護師比率必須入力チェック
      *        PERFORM 4200-BTU-KNGHIRITUKBN-CHK-SEC
      *        IF    ( SPA-ERRCD       NOT =   SPACE )
      *            GO  TO  4200-IPPAN-CHK-EXT
      *        END-IF
      *    END-IF
      *
           .
      *
       4200-IPPAN-CHK-EXT.
           EXIT.
      *****************************************************************
      *       精神病棟
      *****************************************************************
       4200-SEISIN-CHK-SEC             SECTION.
      *
      *    IF    ( SPA-W20-1006-TOKKINOHOSPKBN
      *                                =   "1" )
      *        平均在院日数必須入力チェック
      *        PERFORM 4200-BTU-HEIKINZAIKBN-CHK-SEC
      *        IF    ( SPA-ERRCD       NOT =   SPACE )
      *            GO  TO  4200-SEISIN-CHK-EXT
      *        END-IF
      *
      *    END-IF
      *
      *    看護配置必須入力チェック
           PERFORM 4200-BTU-KNGHAIKBN-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4200-SEISIN-CHK-EXT
           END-IF
      *
      *    看護師比率必須入力チェック
           PERFORM 4200-BTU-KNGHIRITUKBN-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4200-SEISIN-CHK-EXT
           END-IF
           .
      *
       4200-SEISIN-CHK-EXT.
           EXIT.
      *****************************************************************
      *       結核病棟
      *****************************************************************
       4200-KEKKAKU-CHK-SEC            SECTION.
      *
      *    IF    ( SPA-W20-1006-TOKKINOHOSPKBN
      *                                =   "1" )
      *        平均在院日数必須入力チェック
      *        PERFORM 4200-BTU-HEIKINZAIKBN-CHK-SEC
      *        IF    ( SPA-ERRCD       NOT =   SPACE )
      *            GO  TO  4200-KEKKAKU-CHK-EXT
      *        END-IF
      *
      *    END-IF
      *
      *    看護配置必須入力チェック
           PERFORM 4200-BTU-KNGHAIKBN-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4200-KEKKAKU-CHK-EXT
           END-IF
      *
      *    看護師比率必須入力チェック
           PERFORM 4200-BTU-KNGHIRITUKBN-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4200-KEKKAKU-CHK-EXT
           END-IF
           .
      *
       4200-KEKKAKU-CHK-EXT.
           EXIT.
      *****************************************************************
      *       療養病棟
      *****************************************************************
       4200-RYOYO-CHK-SEC              SECTION.
      *
      *    看護配置必須入力チェック
           PERFORM 4200-BTU-KNGHAIKBN-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4200-RYOYO-CHK-EXT
           END-IF
      *
      *    看護補助配置比率必須入力チェック
           PERFORM 4200-BTU-KNGHJOHAI-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4200-RYOYO-CHK-EXT
           END-IF
           .
      *
       4200-RYOYO-CHK-EXT.
           EXIT.
      *****************************************************************
      *       障害者施設
      *****************************************************************
       4200-SYOGAI-CHK-SEC             SECTION.
      *
      *    看護配置必須入力チェック
           PERFORM 4200-BTU-KNGHAIKBN-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4200-SYOGAI-CHK-EXT
           END-IF
      *
      *    看護師比率必須入力チェック
           PERFORM 4200-BTU-KNGHIRITUKBN-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4200-SYOGAI-CHK-EXT
           END-IF
           .
      *
       4200-SYOGAI-CHK-EXT.
           EXIT.
      *****************************************************************
      *       専門病院
      *****************************************************************
       4200-SENMON-CHK-SEC             SECTION.
      *
      *    平均在院日数必須入力チェック
           PERFORM 4200-BTU-HEIKINZAIKBN-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4200-SENMON-CHK-EXT
           END-IF
      *
      *    看護師比率必須入力チェック
           PERFORM 4200-BTU-KNGHIRITUKBN-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4200-SENMON-CHK-EXT
           END-IF
      *
           .
      *
       4200-SENMON-CHK-EXT.
           EXIT.
      *****************************************************************
      *       老人病棟
      *****************************************************************
       4200-ROJIN-CHK-SEC             SECTION.
      *
      *    看護配置必須入力チェック
           PERFORM 4200-BTU-KNGHAIKBN-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4200-ROJIN-CHK-EXT
           END-IF
      *
      *    看護補助配置比率必須入力チェック
           PERFORM 4200-BTU-KNGHJOHAI-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4200-ROJIN-CHK-EXT
           END-IF
           .
      *
       4200-ROJIN-CHK-EXT.
           EXIT.
      *****************************************************************
      *       有床診療所入院基本料
      *****************************************************************
       4200-SINRYO-CHK-SEC             SECTION.
      *
      *
           .
       4200-SINRYO-CHK-EXT.
           EXIT.
      *****************************************************************
      *       有床診療所療養病床入院料
      *****************************************************************
       4200-SINRYORYOYO-CHK-SEC        SECTION.
      *
      *    看護配置必須入力チェック
           PERFORM 4200-BTU-KNGHAIKBN-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4200-SINRYORYOYO-CHK-EXT
           END-IF
      *
      *    看護補助配置比率必須入力チェック
           PERFORM 4200-BTU-KNGHJOHAI-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4200-SINRYORYOYO-CHK-EXT
           END-IF
           .
      *
       4200-SINRYORYOYO-CHK-EXT.
           EXIT.
      *****************************************************************
      *        平均在日数必須入力チェック
      *****************************************************************
       4200-BTU-HEIKINZAIKBN-CHK-SEC    SECTION.
      *
      *    平均在日数が入力されていること
           IF    ( SPA-GMN-W20-BTU-HEIZAIKBN
                                   NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "1013"  TO  SPA-ERRCD
               MOVE    7       TO  SPA-GMN-W20-CUR
               GO  TO  4200-BTU-HEIKINZAIKBN-CHK-EXT
           END-IF
      *
           .
      *
       4200-BTU-HEIKINZAIKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *        看護配置必須入力チェック
      *****************************************************************
       4200-BTU-KNGHAIKBN-CHK-SEC    SECTION.
      *
      *    看護配置が入力されていること
           IF    ( SPA-GMN-W20-BTU-KNGHAIKBN
                                   NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "1010"  TO  SPA-ERRCD
               MOVE    8       TO  SPA-GMN-W20-CUR
               GO  TO  4200-BTU-KNGHAIKBN-CHK-EXT
           END-IF
           .
      *
       4200-BTU-KNGHAIKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *        看護師比率必須入力チェック
      *****************************************************************
       4200-BTU-KNGHIRITUKBN-CHK-SEC    SECTION.
      *
      *    看護師比率が入力されていること
           IF    ( SPA-GMN-W20-BTU-KNGHIRIT
                                   NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "1011"  TO  SPA-ERRCD
               MOVE    9       TO  SPA-GMN-W20-CUR
               GO  TO  4200-BTU-KNGHIRITUKBN-CHK-EXT
           END-IF
           .
      *
       4200-BTU-KNGHIRITUKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *        看護補助配置必須入力チェック
      *****************************************************************
       4200-BTU-KNGHJOHAI-CHK-SEC    SECTION.
      *
      *    看護補助配置が入力されていること
           IF    ( SPA-GMN-W20-BTU-KNGHJOHAI
                                   NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "1012"  TO  SPA-ERRCD
               MOVE    10      TO  SPA-GMN-W20-CUR
               GO  TO  4200-BTU-KNGHJOHAI-CHK-EXT
           END-IF
           .
      *
       4200-BTU-KNGHJOHAI-CHK-EXT.
           EXIT.
      *****************************************************************
      *       病棟番号検索処理
      *****************************************************************
       4100-BTU-NUM-LSTSEL-SEC         SECTION.
      *
           MOVE    "1"                 TO  FLG-BTU-NUM
           MOVE    ZERO                TO  IDX-BTULST
      *
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-BTU-NUM =   ZERO )
                OR       ( IDX1    >   SPA-GMN-W20-BTULST-CNT )
      *
      *
               IF    ( SPA-GMN-W20-BTU-NUM
                                       =   SPA-GMN-W20-TBTU-NUM (IDX1) )
                   MOVE    ZERO    TO  FLG-BTU-NUM
                   MOVE    IDX1    TO  IDX-BTULST
               END-IF
      *
           END-PERFORM
      *
           .
      *
       4100-BTU-NUM-LSTSEL-EXT.
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
      *    病室ボタン
           MOVE    SPA-GMN-W20-B09         TO  W20-B09
      *
      *    病棟番号
           MOVE    SPA-GMN-W20-BTU-NUM     TO  W20-BTU-NUM
      *
      *    病棟名称
           MOVE    SPA-GMN-W20-BTU-NAME    TO  W20-BTU-NAME
      *
      *    短縮病棟名
           MOVE    SPA-GMN-W20-BTU-TANNAME TO  W20-BTU-TANNAME
      *
      *    特定入院料コンボ
           MOVE    SPA-GMN-W20-BTU-TOKNYUIN
                                       TO  W20-BTU-TOKUTEINYUIN
           MOVE    SPA-GMN-W20-BTU-TOKNYUIN-CNT
                                       TO  W20-BTU-TOKUTEINYUIN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-BTU-TOKUTEINYUIN-CNT )
                MOVE   SPA-GMN-W20-BTU-TOKNYUIN-ITM (IDX1)
                                   TO  W20-BTU-TOKUTEINYUIN-ITM (IDX1)
           END-PERFORM
      *
      *    病棟科名コンボ
           MOVE    SPA-GMN-W20-BTU-KA      TO  W20-BTU-KA
           MOVE    SPA-GMN-W20-BTU-KA-CNT  TO  W20-BTU-KA-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-BTU-KA-CNT )
                MOVE   SPA-GMN-W20-BTU-KA-ITM (IDX1)
                                   TO  W20-BTU-KA-ITM (IDX1)
           END-PERFORM
      *
      *    病棟種別コンボ
           MOVE    SPA-GMN-W20-BTU-SBT     TO  W20-BTU-SBT
           MOVE    SPA-GMN-W20-BTU-SBT-CNT TO  W20-BTU-SBT-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-BTU-SBT-CNT )
                MOVE   SPA-GMN-W20-BTU-SBT-ITM (IDX1)
                                   TO  W20-BTU-SBT-ITM (IDX1)
           END-PERFORM
      *
      *    平均在院日数コンボ
           MOVE    SPA-GMN-W20-BTU-HEIZAIKBN
                                       TO  W20-BTU-HEIKINZAIKBN
           MOVE    SPA-GMN-W20-BTU-HEIZAIKBN-CNT
                                       TO  W20-BTU-HEIZAIKBN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-BTU-HEIZAIKBN-CNT )
                MOVE   SPA-GMN-W20-BTU-HEIZAIKBN-ITM (IDX1)
                                   TO  W20-BTU-HEIZAIKBN-ITM (IDX1)
           END-PERFORM
      *
      *    看護配置コンボ
           MOVE    SPA-GMN-W20-BTU-KNGHAIKBN
                                       TO  W20-BTU-KNGHAICHIKBN
           MOVE    SPA-GMN-W20-BTU-KNGHAIKBN-CNT
                                       TO  W20-BTU-KNGHAICHIKBN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-BTU-KNGHAICHIKBN-CNT )
                MOVE   SPA-GMN-W20-BTU-KNGHAIKBN-ITM (IDX1)
                                   TO  W20-BTU-KNGHAICHIKBN-ITM (IDX1)
           END-PERFORM
      *
      *    看護師比率コンボ
           MOVE    SPA-GMN-W20-BTU-KNGHIRIT
                                       TO  W20-BTU-KNGHIRITUKBN
           MOVE    SPA-GMN-W20-BTU-KNGHIRIT-CNT
                                       TO  W20-BTU-KNGHIRIT-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-BTU-KNGHIRIT-CNT )
                MOVE   SPA-GMN-W20-BTU-KNGHIRIT-ITM (IDX1)
                                   TO  W20-BTU-KNGHIRIT-ITM (IDX1)
           END-PERFORM
      *
      *    看護補助配置コンボ
           MOVE    SPA-GMN-W20-BTU-KNGHJOHAI
                                       TO  W20-BTU-KNGHJOHAI
           MOVE    SPA-GMN-W20-BTU-KNGHJOHAI-CNT
                                       TO  W20-BTU-KNGHJOHAI-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-BTU-KNGHJOHAI-CNT )
                MOVE   SPA-GMN-W20-BTU-KNGHJOHAI-ITM (IDX1)
                                   TO  W20-BTU-KNGHJOHAI-ITM (IDX1)
           END-PERFORM
      *
      *    看護補助加算コンボ
           MOVE    SPA-GMN-W20-BTU-KNGHJOKSN
                                       TO  W20-BTU-KNGHJOKSN
           MOVE    SPA-GMN-W20-BTU-KNGHJOKSN-CNT
                                       TO  W20-BTU-KNGHJOKSN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-BTU-KNGHJOKSN-CNT )
                MOVE   SPA-GMN-W20-BTU-KNGHJOKSN-ITM (IDX1)
                                   TO  W20-BTU-KNGHJOKSN-ITM (IDX1)
           END-PERFORM
      *
      *    夜間勤務看護加算コンボ
           MOVE    SPA-GMN-W20-BTU-YKNKNGKSN
                                       TO  W20-BTU-YAKANKNGKSN
           MOVE    SPA-GMN-W20-BTU-YKNKNGKSN-CNT
                                       TO  W20-BTU-YKNKNGKSN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-BTU-YKNKNGKSN-CNT )
                MOVE   SPA-GMN-W20-BTU-YKNKNGKSN-ITM (IDX1)
                                   TO  W20-BTU-YKNKNGKSN-ITM (IDX1)
           END-PERFORM
      *
      *    食堂加算区分
           MOVE    SPA-GMN-W20-CHK-BTU-SYOKUDOKBN
                                       TO  W20-CHK-BTU-SYOKUDOKBN
      *
      *    看護師人数
           MOVE    SPA-GMN-W20-CHK-BTU-KNGSIS
                                       TO  W20-CHK-BTU-KNGSISUKBN
      *
      *    保育士人数
           MOVE    SPA-GMN-W20-CHK-BTU-HIKSIS
                                       TO  W20-CHK-BTU-HIKSISUKBN
      *
      *    レセプト表示区分
           MOVE    SPA-GMN-W20-RECEDSPKBN   TO  W20-RECEDSPKBN
           MOVE    SPA-GMN-W20-RECEDSPKBN-CNT
                                       TO  W20-RECEDSPKBN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-RECEDSPKBN-CNT )
                MOVE   SPA-GMN-W20-RECEDSPKBN-ITM (IDX1)
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
           MOVE    SPA-GMN-W20-BTU-EDKBN   TO  W20-BTU-EDKBN
           MOVE    SPA-GMN-W20-BTU-EDKBN-CNT
                                       TO  W20-BTU-EDKBN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-BTU-EDKBN-CNT )
                MOVE   SPA-GMN-W20-BTU-EDKBN-ITM (IDX1)
                                   TO  W20-BTU-EDKBN-ITM (IDX1)
           END-PERFORM
      *
      *    入院基本料コンボ
           MOVE    SPA-GMN-W20-BTU-KHNRYO  TO  W20-BTU-KHNRYO
           MOVE    SPA-GMN-W20-BTU-KHNRYO-CNT
                                           TO  W20-BTU-KHNRYO-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-BTU-KHNRYO-CNT )
                MOVE   SPA-GMN-W20-BTU-KHNRYO-ITM (IDX1)
                                   TO  W20-BTU-KHNRYO-ITM (IDX1)
           END-PERFORM
      *
      *    入院基本点数
           MOVE    SPA-NAI-W20-BTU-KHNTEN  TO  W20-BTU-KHNTEN
      *
      *    選択番号
           MOVE    SPA-GMN-W20-SELNUM      TO  W20-SELNUM
      *
      *    病棟リスト
           MOVE    SPACE               TO  W20-BTULST-TBL
      *
           MOVE    SPA-GMN-W20-BTULST-CNT  TO  W20-BTULST-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W20-BTULST-CNT )
      *
      *        病棟番号
               MOVE    SPA-GMN-W20-TBTU-NUM (IDX1)
                                       TO  WRK-ZZZ9
               MOVE    WRK-ZZZ9
                                       TO  W20-TBTU-NUM (IDX1)
      *
      *        病棟名称
               MOVE    SPA-GMN-W20-TBTU-NAME (IDX1)
                                       TO  W20-TBTU-NAME (IDX1)
      *
      *        病棟種別
               MOVE    SPA-GMN-W20-TBTU-SBT (IDX1)
                                       TO  W20-TBTU-SBT (IDX1)
      *
      *        特定入院料
               MOVE    SPA-GMN-W20-TBTU-TOKNYUIN (IDX1)
                                       TO  W20-TBTU-TOKUTEINYUIN (IDX1)
      *
      *        病棟科名
               MOVE    SPA-GMN-W20-TBTU-KA (IDX1)
                                       TO  W20-TBTU-KA (IDX1)
      *
      *        入院基本料
               MOVE    SPA-GMN-W20-TBTU-KHNRYO (IDX1)
                                       TO  W20-TBTU-KHNRYO (IDX1)
      *
      *        入院基本点数
               MOVE    SPA-GMN-W20-TBTU-KHNTEN (IDX1)
                                       TO  W20-TBTU-KHNTEN (IDX1)
      *
      *        収容人数
               MOVE    SPA-GMN-W20-TBTU-NINZU (IDX1)
                                       TO  WRK-ZZZZZZZZZ9
               MOVE    WRK-ZZZZZZZZZ9
                                       TO  W20-TBTU-NINZU (IDX1)
      *
      *        看護配置
               MOVE    SPA-GMN-W20-TBTU-KNGHAIKBN (IDX1)
                                       TO  W20-TBTU-KNGHAIKBN (IDX1)
      *
      *        看護師比率
               MOVE    SPA-GMN-W20-TBTU-KNGHIRIT (IDX1)
                                       TO  W20-TBTU-KNGHIRIT (IDX1)
      *
      *        平均在日数区分
               MOVE    SPA-GMN-W20-TBTU-HEIZAIKBN (IDX1)
                                       TO  W20-TBTU-HEIZAIKBN (IDX1)
      *
      *        看護補助加算
               MOVE    SPA-GMN-W20-TBTU-KNGHJOKSN (IDX1)
                                       TO  W20-TBTU-KNGHJOKSN (IDX1)
      *
      *        看護補助配置
               MOVE    SPA-GMN-W20-TBTU-KNGHJOHAI (IDX1)
                                       TO  W20-TBTU-KNGHJOHAI (IDX1)
      *
      *        夜間勤務等看護加算
               MOVE    SPA-GMN-W20-TBTU-YKNKNGKSN (IDX1)
                                       TO  W20-TBTU-YAKANKNGKSN (IDX1)
      *
      *        食堂加算
               IF    ( SPA-GMN-W20-TBTU-SYOKUDOKBN (IDX1)
                                       =   "T" )
                   MOVE    "　　○"    TO  W20-TBTU-SYOKUDOKBN (IDX1)
               END-IF
      *
      *        看護師数区分
               IF    ( SPA-GMN-W20-TBTU-KNGSISUKBN (IDX1)
                                       =   "T" )
                   MOVE    "　　　○"  TO  W20-TBTU-KNGSISUKBN (IDX1)
               END-IF
      *
      *        保育士数区分
               IF    ( SPA-GMN-W20-TBTU-HIKSISUKBN (IDX1)
                                       =   "T" )
                   MOVE    "　　　○"  TO  W20-TBTU-HIKSISUKBN (IDX1)
               END-IF
      *
      *        有効期間開始日
               MOVE    SPA-GMN-W20-TYUKOSTYMD (IDX1)
                                       TO  W20-TYUKOSTYMD (IDX1)
      *
      *        有効期間終了日
               MOVE    SPA-GMN-W20-TYUKOEDYMD (IDX1)
                                       TO  W20-TYUKOEDYMD (IDX1)
      *
               IF    ( SPA-GMN-W20-BTULST-SEL-NUM  =   IDX1 )
                   MOVE    "T"         TO  W20-BTULST-SEL (IDX1)
               ELSE
                   MOVE    "F"         TO  W20-BTULST-SEL (IDX1)
               END-IF
      *
           END-PERFORM
      *
      *    履歴リスト
           INITIALIZE                      W20-RIREKILST-TBL
           MOVE    SPA-GMN-W20-RIREKILST-CNT
                                       TO  W20-RIREKILST-CNT
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   SPA-GMN-W20-RIREKILST-CNT )
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
               IF    ( IDX1    =   SPA-GMN-W20-RIREKILST-SEL-NUM )
                   MOVE    "T"         TO  W20-RIREKILST-SEL (IDX1)
               ELSE
                   MOVE    "F"         TO  W20-RIREKILST-SEL (IDX1)
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
      *
      *    クリアボタン
           MOVE    SPA-GMN-W20-B02-STATE   TO  W20-B02-STATE
      *
      *    棟歴ボタン
           MOVE    SPA-GMN-W20-B05-STATE   TO  W20-B05-STATE
      *
      *    追加ボタン
           MOVE    SPA-GMN-W20-B06-STATE   TO  W20-B06-STATE
      *
      *    変更ボタン
           MOVE    SPA-GMN-W20-B07-STATE   TO  W20-B07-STATE
      *
      *    削除ボタン
           MOVE    SPA-GMN-W20-B08-STATE   TO  W20-B08-STATE
      *
      *    病室ボタン
           MOVE    SPA-GMN-W20-B09-STATE   TO  W20-B09-STATE
      *
      *    登録ボタン
           MOVE    SPA-GMN-W20-B12-STATE   TO  W20-B12-STATE
      *
      *    看護補助配置
           MOVE    SPA-GMN-W20-BTU-KNGHJOHAI-STT
                                       TO  W20-BTU-KNGHJOHAI-STT
           MOVE    SPA-GMN-W20-BTU-KNGHJOHAI-ITM-STT
                                       TO  W20-BTU-KNGHJOHAI-ITM-STT
      *
      *    看護補助加算
           MOVE    SPA-GMN-W20-BTU-KNGHJOKSN-STT
                                       TO  W20-BTU-KNGHJOKSN-STT
           MOVE    SPA-GMN-W20-BTU-KNGHJOKSN-ITM-STT
                                       TO  W20-BTU-KNGHJOKSN-ITM-STT
      *
      *    看護師数区分
           MOVE    SPA-GMN-W20-CHK-BTU-KNGSIS-STT
                                       TO  W20-CHK-BTU-KNGSISUKBN-STT
      *
      *    保育士数区分
           MOVE    SPA-GMN-W20-CHK-BTU-HIKSIS-STT
                                       TO  W20-CHK-BTU-HIKSISUKBN-STT
      *
           MOVE    SPA-GMN-W20-STATE   TO  W20-BTU-NAME-STT
                                           W20-BTU-TANNAME-STT
                                           W20-BTU-TOKUTEINYUIN-STT
                                           W20-BTU-TOKUTEINYUIN-ITM-STT
                                           W20-BTU-KA-STT
                                           W20-BTU-KA-ITM-STT
                                           W20-BTU-SBT-STT
                                           W20-BTU-SBT-ITM-STT
                                           W20-BTU-HEIKINZAIKBN-STT
                                           W20-BTU-HEIZAIKBN-ITM-STT
                                           W20-BTU-KNGHAICHIKBN-STT
                                           W20-BTU-KNGHAICHIKBN-ITM-STT
                                           W20-BTU-KNGHIRITUKBN-STT
                                           W20-BTU-KNGHIRIT-ITM-STT
                                           W20-BTU-YAKANKNGKSN-STT
                                           W20-BTU-YKNKNGKSN-ITM-STT
                                           W20-CHK-BTU-SYOKUDOKBN-STT
                                           W20-RECEDSPKBN-STT
                                           W20-RECEDSPKBN-ITM-STT
                                           W20-YUKOSTYMD-STT
                                           W20-YUKOEDYMD-STT
                                           W20-BTU-EDKBN-STT
                                           W20-BTU-EDKBN-ITM-STT
                                           W20-BTU-KHNRYO-STT
                                           W20-BTU-KHNRYO-ITM-STT
                                           W20-BTU-KHNTEN-STT
      *
           IF    ( SPA-GMN-W20-STATE       =   WIDGET-INSENSITIVE )
               MOVE    WIDGET-INSENSITIVE
                                       TO  W20-B06-STATE
                                           W20-B07-STATE
                                           W20-B08-STATE
                                           W20-BTU-KNGHJOHAI-STT
                                           W20-BTU-KNGHJOHAI-ITM-STT
                                           W20-BTU-KNGHJOKSN-STT
                                           W20-BTU-KNGHJOKSN-ITM-STT
                                           W20-CHK-BTU-KNGSISUKBN-STT
                                           W20-CHK-BTU-HIKSISUKBN-STT
           END-IF
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
                  (SPA-GMN-W20-CUR     =   ZERO )
               PERFORM 5011-INPUT-CUR-SEC
           END-IF
      *
           IF    ( SPA-GMN-W20-STATE   =   WIDGET-INSENSITIVE )
               MOVE  "SELNUM"          TO   MCP-WIDGET
               GO  TO  5001-MAPCUR-EXT
           END-IF
      *
      *    病棟番号
           IF    ( SPA-GMN-W20-CUR     =    1 )
               MOVE  "BTU_NUM"         TO   MCP-WIDGET
               GO  TO  5001-MAPCUR-EXT
           END-IF
      *
      *    病棟名称
           IF    ( SPA-GMN-W20-CUR     =   2 )
               IF    ( W20-BTU-NAME-STT    =  WIDGET-NORMAL )
                   MOVE  "BTU_NAME"        TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR +   1
               END-IF
           END-IF
      *
      *    短縮病棟名
           IF    ( SPA-GMN-W20-CUR     =   3 )
               IF    ( W20-BTU-TANNAME-STT
                                       =   WIDGET-NORMAL )
                   MOVE  "BTU_TANNAME"     TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR +   1
               END-IF
           END-IF
      *
      *    特定入院料
           IF    ( SPA-GMN-W20-CUR     =   4 )
               IF    ( W20-BTU-TOKUTEINYUIN-STT
                                       =   WIDGET-NORMAL )
                   MOVE  "BTU_TOKUTEINYUIN"
                                           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR +   1
               END-IF
           END-IF
      *
      *    病棟科名
           IF    ( SPA-GMN-W20-CUR     =   5 )
               IF    ( W20-BTU-KA-STT
                                       =   WIDGET-NORMAL )
                   MOVE  "BTU_KA"
                                           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR +   1
               END-IF
           END-IF
      *
      *    病棟種別
           IF    ( SPA-GMN-W20-CUR     =   6 )
               IF    ( W20-BTU-SBT-STT
                                       =   WIDGET-NORMAL )
                   MOVE  "BTU_SBT"
                                           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR +   1
               END-IF
           END-IF
      *
      *    平均在院日数
           IF    ( SPA-GMN-W20-CUR     =   7 )
               IF    ( W20-BTU-HEIKINZAIKBN-STT
                                       =   WIDGET-NORMAL )
                   MOVE  "BTU_HEIKINZAIKBN"
                                           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR +   1
               END-IF
           END-IF
      *
      *    看護配置
           IF    ( SPA-GMN-W20-CUR     =   8 )
               IF    ( W20-BTU-KNGHAICHIKBN-STT
                                       =   WIDGET-NORMAL )
                   MOVE  "BTU_KNGHAICHIKBN"
                                           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR +   1
               END-IF
           END-IF
      *
      *    看護師比率
           IF    ( SPA-GMN-W20-CUR     =   9 )
               IF    ( W20-BTU-KNGHIRITUKBN-STT
                                       =   WIDGET-NORMAL )
                   MOVE  "BTU_KNGHIRITUKBN"
                                           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR +   1
               END-IF
           END-IF
      *
      *    看護補助配置
           IF    ( SPA-GMN-W20-CUR     =   10 )
               IF    ( W20-BTU-KNGHJOHAI-STT
                                       =   WIDGET-NORMAL )
                   MOVE  "BTU_KNGHJOHAI"
                                           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR +   1
               END-IF
           END-IF
      *
      *    看護補助加算
           IF    ( SPA-GMN-W20-CUR     =   11 )
               IF    ( W20-BTU-KNGHJOKSN-STT
                                       =   WIDGET-NORMAL )
                   MOVE  "BTU_KNGHJOKSN"
                                           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR +   1
               END-IF
           END-IF
      *
      *    夜間勤務看護加算
           IF    ( SPA-GMN-W20-CUR     =   12 )
               IF    ( W20-BTU-YAKANKNGKSN-STT
                                       =   WIDGET-NORMAL )
                   MOVE  "BTU_YAKANKNGKSN"
                                           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR +   1
               END-IF
           END-IF
      *
      *    食堂加算区分
           IF    ( SPA-GMN-W20-CUR     =   13 )
               IF    ( W20-CHK-BTU-SYOKUDOKBN-STT
                                       =   WIDGET-NORMAL )
                   MOVE  "CHK_BTU_SYOKUDOKBN"
                                           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR +   1
               END-IF
           END-IF
      *
      *    看護師人数
           IF    ( SPA-GMN-W20-CUR     =   14 )
               IF    ( W20-CHK-BTU-KNGSISUKBN-STT
                                       =   WIDGET-NORMAL )
                   MOVE  "CHK_BTU_KNGSISUKBN"
                                           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR +   1
               END-IF
           END-IF
      *
      *    保育士人数
           IF    ( SPA-GMN-W20-CUR     =   15 )
               IF    ( W20-CHK-BTU-HIKSISUKBN-STT
                                       =   WIDGET-NORMAL )
                   MOVE  "CHK_BTU_HIKSISUKBN"
                                           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR +   1
               END-IF
           END-IF
      *
      *    レセプト表示区分
           IF    ( SPA-GMN-W20-CUR     =   16 )
               IF    ( W20-RECEDSPKBN-STT
                                       =   WIDGET-NORMAL )
                   MOVE  "RECEDSPKBN"
                                           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR +   1
               END-IF
           END-IF
      *
      *    有効期間開始日
           IF    ( SPA-GMN-W20-CUR     =   17 )
               IF    ( W20-YUKOSTYMD-STT
                                       =   WIDGET-NORMAL )
                   MOVE  "YUKOSTYMD"
                                           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR +   1
               END-IF
           END-IF
      *
      *    有効期間終了日
           IF    ( SPA-GMN-W20-CUR     =   18 )
               IF    ( W20-YUKOEDYMD-STT
                                       =   WIDGET-NORMAL )
                   MOVE  "YUKOEDYMD"
                                           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR +   1
               END-IF
           END-IF
      *
      *    病棟終了区分
           IF    ( SPA-GMN-W20-CUR     =   19 )
               IF    ( W20-BTU-EDKBN-STT
                                       =   WIDGET-NORMAL )
                   MOVE  "BTU_EDKBN"
                                           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR +   1
               END-IF
           END-IF
      *
      *    入院基本料
           IF    ( SPA-GMN-W20-CUR     =   20 )
               IF    ( W20-BTU-KHNRYO-STT
                                       =   WIDGET-NORMAL )
                   MOVE  "BTU_KHNRYO"      TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   MOVE    206         TO  SPA-GMN-W20-CUR
               END-IF
           END-IF
      *
      *    選択番号
           IF    ( SPA-GMN-W20-CUR     =   100 )
               MOVE  "SELNUM"          TO  MCP-WIDGET
               GO  TO  5001-MAPCUR-EXT
           END-IF
      *
      *    追加ボタン
           IF    ( SPA-GMN-W20-CUR     =   206 )
               MOVE  "B06"             TO   MCP-WIDGET
               GO  TO  5001-MAPCUR-EXT
           END-IF
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
           WHEN    "BTU_NUM"
               MOVE    001             TO  SPA-GMN-W20-CUR
           WHEN    "BTU_NAME"
               MOVE    002             TO  SPA-GMN-W20-CUR
           WHEN    "BTU_TANNAME"
               MOVE    003             TO  SPA-GMN-W20-CUR
           WHEN    "BTU_TOKUTEINYUIN"
               MOVE    004             TO  SPA-GMN-W20-CUR
           WHEN    "BTU_KA"
               MOVE    005             TO  SPA-GMN-W20-CUR
           WHEN    "BTU_SBT"
               MOVE    006             TO  SPA-GMN-W20-CUR
           WHEN    "BTU_HEIKINZAIKBN"
               MOVE    007             TO  SPA-GMN-W20-CUR
           WHEN    "BTU_KNGHAICHIKBN"
               MOVE    008             TO  SPA-GMN-W20-CUR
           WHEN    "BTU_KNGHIRITUKBN"
               MOVE    009             TO  SPA-GMN-W20-CUR
           WHEN    "BTU_KNGHJOHAI"
               MOVE    010             TO  SPA-GMN-W20-CUR
           WHEN    "BTU_KNGHJOKSN"
               MOVE    011             TO  SPA-GMN-W20-CUR
           WHEN    "BTU_YAKANKNGKSN"
               MOVE    012             TO  SPA-GMN-W20-CUR
           WHEN    "CHK_BTU_SYOKUDOKBN"
               MOVE    013             TO  SPA-GMN-W20-CUR
           WHEN    "CHK_BTU_KNGSISUKBN"
               MOVE    014             TO  SPA-GMN-W20-CUR
           WHEN    "CHK_BTU_HIKSISUKBN"
               MOVE    015             TO  SPA-GMN-W20-CUR
           WHEN    "RECEDSPKBN"
               MOVE    016             TO  SPA-GMN-W20-CUR
           WHEN    "YUKOSTYMD"
               MOVE    017             TO  SPA-GMN-W20-CUR
           WHEN    "YUKOEDYMD"
               MOVE    018             TO  SPA-GMN-W20-CUR
           WHEN    "BTU_EDKBN"
               MOVE    019             TO  SPA-GMN-W20-CUR
           WHEN    "BTU_KHNRYO"
               MOVE    020             TO  SPA-GMN-W20-CUR
           WHEN    "SELNUM"
               MOVE    100             TO  SPA-GMN-W20-CUR
           END-EVALUATE
      *
      *    次カーソル位置を設定
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "SELNUM"
               MOVE    002             TO  SPA-GMN-W20-CUR
           WHEN    "BTU_KHNRYO"
               MOVE    206             TO  SPA-GMN-W20-CUR
           WHEN    OTHER
               COMPUTE SPA-GMN-W20-CUR =   SPA-GMN-W20-CUR
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
               MOVE    "全角文字でのみ入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "0003"
               MOVE    SPACE           TO  SPA-ERRMSG
               STRING  "有効開始日は平成１４年４月１日以降にして"
                       "ください"
                       DELIMITED   BY  SIZE
               INTO    SPA-ERRMSG
               END-STRING
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
           WHEN    "1010"
               MOVE    "看護配置を入力して下さい"
                                       TO  SPA-ERRMSG
           WHEN    "1011"
               MOVE    "看護師比率を入力して下さい"
                                       TO  SPA-ERRMSG
           WHEN    "1012"
               MOVE    "看護補助配置を入力して下さい"
                                       TO  SPA-ERRMSG
           WHEN    "1013"
               MOVE    "平均在日数を入力して下さい"
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
      *    特定入院料サーチ処理
      *****************************************************************
       800-BTU-TOKUTEINYUIN-SRH-SEC        SECTION.
      *
           SET     CMB-IDX01   TO  1
           SEARCH  SPA-GMN-W20-BTU-TOKNYUIN-OCC
                                   VARYING CMB-IDX01
           AT  END
               INITIALIZE          WRK-KANRI-AREA
           WHEN    SPA-GMN-W20-BTU-TOKNYUIN-ITM
                               (CMB-IDX01)(1 : 2)  =   WRK-KANRICD
               SET WRK-KANRIIDX    TO  CMB-IDX01
               MOVE    SPA-GMN-W20-BTU-TOKNYUIN-ITM  (CMB-IDX01)
                               TO  WRK-KANRIDAT1
               MOVE    SPA-GMN-W20-BTU-TOKNYUIN-ITM2 (CMB-IDX01)
                               TO  WRK-KANRIDAT2
           WHEN    SPA-GMN-W20-BTU-TOKNYUIN-ITM
                               (CMB-IDX01)(1 : 2)  =   SPACE
               INITIALIZE          WRK-KANRI-AREA
           END-SEARCH
      *
           .
       800-BTU-TOKUTEINYUIN-SRH-EXT.
           EXIT.
      *****************************************************************
      *    診療科コードサーチ処理
      *****************************************************************
       800-BTU-KA-SRH-SEC                  SECTION.
      *
           SET     CMB-IDX02   TO  1
           SEARCH  SPA-GMN-W20-BTU-KA-ITM  VARYING CMB-IDX02
           AT  END
               INITIALIZE          WRK-KANRI-AREA
           WHEN    SPA-GMN-W20-BTU-KA-ITM
                               (CMB-IDX02) (1 : 2) =   WRK-KANRICD
               SET WRK-KANRIIDX    TO  CMB-IDX02
               MOVE    SPA-GMN-W20-BTU-KA-ITM (CMB-IDX02)
                               TO  WRK-KANRIDAT1
           WHEN    SPA-GMN-W20-BTU-KA-ITM
                               (CMB-IDX02) (1 : 2) =   SPACE
               INITIALIZE          WRK-KANRI-AREA
           END-SEARCH
      *
           .
       800-BTU-KA-SRH-EXT.
           EXIT.
      *****************************************************************
      *    病棟種別サーチ処理
      *****************************************************************
       800-BTU-SBT-SRH-SEC                 SECTION.
      *
           SET     CMB-IDX03   TO  1
           SEARCH  SPA-GMN-W20-BTU-SBT-ITM VARYING CMB-IDX03
           AT  END
               INITIALIZE          WRK-KANRI-AREA
           WHEN    SPA-GMN-W20-BTU-SBT-ITM
                                   (CMB-IDX03) (1 : 2) =   WRK-KANRICD
               SET WRK-KANRIIDX    TO  CMB-IDX03
               MOVE    SPA-GMN-W20-BTU-SBT-ITM (CMB-IDX03)
                               TO  WRK-KANRIDAT1
           WHEN    SPA-GMN-W20-BTU-SBT-ITM
                                   (CMB-IDX03) (1 : 2) =   SPACE
               INITIALIZE          WRK-KANRI-AREA
           END-SEARCH
      *
           .
       800-BTU-SBT-SRH-EXT.
           EXIT.
      *****************************************************************
      *    平均在院日数サーチ処理
      *****************************************************************
       800-BTU-HEIKINZAIKBN-SRH-SEC        SECTION.
      *
           SET     CMB-IDX04   TO  1
           SEARCH  SPA-GMN-W20-BTU-HEIZAIKBN-ITM
                                           VARYING CMB-IDX04
           AT  END
               INITIALIZE          WRK-KANRI-AREA
           WHEN    SPA-GMN-W20-BTU-HEIZAIKBN-ITM
                                       (CMB-IDX04) (1 : 2)
                                               =   WRK-KANRICD
               SET WRK-KANRIIDX    TO  CMB-IDX04
               MOVE    SPA-GMN-W20-BTU-HEIZAIKBN-ITM (CMB-IDX04)
                               TO  WRK-KANRIDAT1
           WHEN    SPA-GMN-W20-BTU-HEIZAIKBN-ITM
                                       (CMB-IDX04) (1 : 2)
                                               =   SPACE
               INITIALIZE          WRK-KANRI-AREA
           END-SEARCH
      *
           .
       800-BTU-HEIKINZAIKBN-SRH-EXT.
           EXIT.
      *****************************************************************
      *    看護配置サーチ処理
      *****************************************************************
       800-BTU-KNGHAICHIKBN-SRH-SEC        SECTION.
      *
           SET     CMB-IDX05   TO  1
           SEARCH  SPA-GMN-W20-BTU-KNGHAIKBN-ITM
                                       VARYING CMB-IDX05
           AT  END
               INITIALIZE          WRK-KANRI-AREA
           WHEN    SPA-GMN-W20-BTU-KNGHAIKBN-ITM
                                   (CMB-IDX05) (1 : 2) =   WRK-KANRICD
               SET WRK-KANRIIDX    TO  CMB-IDX05
               MOVE    SPA-GMN-W20-BTU-KNGHAIKBN-ITM (CMB-IDX05)
                               TO  WRK-KANRIDAT1
           WHEN    SPA-GMN-W20-BTU-KNGHAIKBN-ITM
                                   (CMB-IDX05) (1 : 2) =   SPACE
               INITIALIZE          WRK-KANRI-AREA
           END-SEARCH
      *
           .
       800-BTU-KNGHAICHIKBN-SRH-EXT.
           EXIT.
      *****************************************************************
      *    看護師比率サーチ処理
      *****************************************************************
       800-BTU-KNGHIRITUKBN-SRH-SEC        SECTION.
      *
           SET     CMB-IDX06   TO  1
           SEARCH  SPA-GMN-W20-BTU-KNGHIRIT-ITM
                                       VARYING CMB-IDX06
           AT  END
               INITIALIZE          WRK-KANRI-AREA
           WHEN    SPA-GMN-W20-BTU-KNGHIRIT-ITM
                                   (CMB-IDX06) (1 : 2) =   WRK-KANRICD
               SET WRK-KANRIIDX    TO  CMB-IDX06
               MOVE    SPA-GMN-W20-BTU-KNGHIRIT-ITM (CMB-IDX06)
                               TO  WRK-KANRIDAT1
           WHEN    SPA-GMN-W20-BTU-KNGHIRIT-ITM
                                   (CMB-IDX06) (1 : 2) =   SPACE
               INITIALIZE          WRK-KANRI-AREA
           END-SEARCH
      *
           .
       800-BTU-KNGHIRITUKBN-SRH-EXT.
           EXIT.
      *****************************************************************
      *    看護補助配置サーチ処理
      *****************************************************************
       800-BTU-KNGHJOHAI-SRH-SEC           SECTION.
      *
           SET     CMB-IDX07   TO  1
           SEARCH  SPA-GMN-W20-BTU-KNGHJOHAI-ITM
                                           VARYING CMB-IDX07
           AT  END
               INITIALIZE          WRK-KANRI-AREA
           WHEN    SPA-GMN-W20-BTU-KNGHJOHAI-ITM
                                   (CMB-IDX07) (1 : 2) =   WRK-KANRICD
               SET WRK-KANRIIDX    TO  CMB-IDX07
               MOVE    SPA-GMN-W20-BTU-KNGHJOHAI-ITM (CMB-IDX07)
                               TO  WRK-KANRIDAT1
           WHEN    SPA-GMN-W20-BTU-KNGHJOHAI-ITM
                                   (CMB-IDX07) (1 : 2) =   SPACE
               INITIALIZE          WRK-KANRI-AREA
           END-SEARCH
      *
           .
       800-BTU-KNGHJOHAI-SRH-EXT.
           EXIT.
      *****************************************************************
      *    看護補助加算サーチ処理
      *****************************************************************
       800-BTU-KNGHJOKSN-SRH-SEC           SECTION.
      *
           SET     CMB-IDX08   TO  1
           SEARCH  SPA-GMN-W20-BTU-KNGHJOKSN-ITM
                                           VARYING CMB-IDX08
           AT  END
               INITIALIZE          WRK-KANRI-AREA
           WHEN    SPA-GMN-W20-BTU-KNGHJOKSN-ITM  (CMB-IDX08)(1 : 2)
                                                   =   WRK-KANRICD
               SET WRK-KANRIIDX    TO  CMB-IDX08
               MOVE    SPA-GMN-W20-BTU-KNGHJOKSN-ITM (CMB-IDX08)
                               TO  WRK-KANRIDAT1
           WHEN    SPA-GMN-W20-BTU-KNGHJOKSN-ITM  (CMB-IDX08)(1 : 2)
                                                   =   SPACE
               INITIALIZE          WRK-KANRI-AREA
           END-SEARCH
      *
           .
       800-BTU-KNGHJOKSN-SRH-EXT.
           EXIT.
      *****************************************************************
      *    夜間勤務等看護加算サーチ処理
      *****************************************************************
       800-BTU-YAKANKNGKSN-SRH-SEC         SECTION.
      *
           SET     CMB-IDX09   TO  1
           SEARCH  SPA-GMN-W20-BTU-YKNKNGKSN-ITM
                                           VARYING CMB-IDX09
           AT  END
               INITIALIZE          WRK-KANRI-AREA
           WHEN    SPA-GMN-W20-BTU-YKNKNGKSN-ITM
                                   (CMB-IDX09) (1 : 2) =   WRK-KANRICD
               SET WRK-KANRIIDX    TO  CMB-IDX09
               MOVE    SPA-GMN-W20-BTU-YKNKNGKSN-ITM (CMB-IDX09)
                               TO  WRK-KANRIDAT1
           WHEN    SPA-GMN-W20-BTU-YKNKNGKSN-ITM
                                   (CMB-IDX09) (1 : 2) =   SPACE
               INITIALIZE          WRK-KANRI-AREA
           END-SEARCH
      *
           .
       800-BTU-YAKANKNGKSN-SRH-EXT.
           EXIT.
      *****************************************************************
      *    レセプト表示区分サーチ処理
      *****************************************************************
       800-RECEDSPKBN-SRH-SEC          SECTION.
      *
           SET     CMB-IDX12   TO  1
           SEARCH  SPA-GMN-W20-RECEDSPKBN-ITM-OCC
                                           VARYING CMB-IDX12
           AT  END
               INITIALIZE          WRK-KANRI-AREA
           WHEN    SPA-GMN-W20-RECEDSPKBN-ITM
                                   (CMB-IDX12) (1 : 2) =   WRK-KANRICD
               SET WRK-KANRIIDX    TO  CMB-IDX12
               MOVE    SPA-GMN-W20-RECEDSPKBN-ITM (CMB-IDX12)
                               TO  WRK-KANRIDAT1
           WHEN    SPA-GMN-W20-RECEDSPKBN-ITM
                                   (CMB-IDX12) (1 : 2) =   SPACE
               INITIALIZE          WRK-KANRI-AREA
           END-SEARCH
      *
           .
       800-RECEDSPKBN-SRH-EXT.
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

