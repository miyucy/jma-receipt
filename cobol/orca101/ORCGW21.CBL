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
       PROGRAM-ID.                               ORCGW21.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : 病室管理
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/08/20    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 00.00.01     NACL−太田   02/11/29  有効開始日を基準にシス管の
      *                                     情報を取得するよう修正
      * 00.00.02     NACL−太田   03/01/29  有効開始日のチェック追加
      *                                     入院中患者チェック追加
      * 00.00.03    NACL-太田     03/06/10  重症者等療養環境特別加算、
      *                                     無菌治療室管理加算を追加
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
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-SYSKANRI                        PIC 9(01).
           03  FLG-NYUKHN                          PIC 9(01).
           03  FLG-ENTRYCHK                        PIC 9(01).
           03  FLG-BRM-NUM                         PIC 9(01).
           03  FLG-KIKAN-DABURI                    PIC 9(01).
           03  FLG-UPD-KBN                         PIC 9(01).
           03  FLG-TENSU                           PIC 9(01).
           03  FLG-DBRC                            PIC 9(01).
           03  FLG-PTNYUINRRK                      PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                                PIC 9(05).
           03  IDX2                                PIC 9(05).
           03  IDX3                                PIC 9(05).
           03  IDX4                                PIC 9(05).
           03  IDX-BRMLST                          PIC 9(05).
           03  FLG-INPUT-AREA                      PIC 9(01).
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
           03  WRK-SYS5002-KBNCD.
               05  WRK-SYS5002-BTU-NUM             PIC X(02).
               05  WRK-SYS5002-BRM-NUM             PIC X(06).
           03  WRK-ZZZ9                            PIC ZZZ9.
           03  WRK-ZZZZ9                           PIC ZZZZ9.
           03  WRK-99999                           PIC 9(05).
           03  WRK-999999                          PIC 9(06).
           03  WRK-ZZZZZ9                          PIC Z(5)9.
           03  WRK-ZZZZZZZZZ9                      PIC Z(9)9.
           03  WRK-DBPATH                          PIC X(20).
           03  WRK-KBNCD                           PIC X(08).
           03  WRK-KANRI-AREA.
               05  WRK-KANRIDAT1                   PIC X(100).
               05  WRK-KANRIDAT1-R     REDEFINES   WRK-KANRIDAT1.
                   07  WRK-KANRIDAT1-DUMMY1        PIC X(03).
                   07  WRK-KANRIDAT1-99999         PIC 9(05).
                   07  WRK-KANRIDAT1-DUMMY2        PIC X(92).
               05  WRK-KANRIDAT2                   PIC X(100).
               05  WRK-KANRIDAT3                   PIC X(100).
               05  WRK-KANRIDAT4                   PIC X(100).
               05  WRK-KANRIIDX                    PIC 9(05).
           03  WRK-KIJUN-YMD                       PIC X(08).
           03  WRK-STR1                            PIC X(20).
           03  WRK-STR2                            PIC X(20).
           03  WRK-IDX1                            PIC 9(05).
           03  WRK-IDX2                            PIC 9(05).
           03  WRK-IDX3                            PIC 9(05).
           03  WRK-BRM-NUM                         PIC X(06).
           03  WRK-BRM-NUM-KEY                     PIC X(06).
           03  WRK-BRM-NUM-IN                      PIC X(06).
           03  WRK-BRM-NUM-EDT                     PIC X(06).
           03  WRK-BRM-NUM-OT                      PIC X(06).
           03  WRK-SELNUM                          PIC 9(05).
           03  WRK-TOKTEI-NYUIN                    PIC X(02).
           03  WRK-KHNSRYCD                        PIC X(09).
           03  WRK-KJN-YUKSTYMD                    PIC X(08).
           03  WRK-BTU-YUKSTYMD                    PIC X(08).
           03  WRK-YUKOSTYMD                       PIC X(08).
           03  WRK-YUKOEDYMD                       PIC X(08).
           03  WRK-HEN-SAGAKU.
               05  WRK-HEN-SAGAKU-Z9               PIC ZZZZ9.
               05  WRK-HEN-SAGAKU-EN               PIC X(02).
      *
      *    固定値領域
       01  CONST-AREA.
           03  CONST-SINSEIJI          PIC X(09) VALUE "190109770".
           03  CONST-SNR-RYOYO-VAL.
               05                      PIC X(09) VALUE "190106370".
               05                      PIC X(09) VALUE "190106470".
           03  CONST-SNR-RYOYO-R REDEFINES   CONST-SNR-RYOYO-VAL.
               05  CONST-SNR-RYOYO
                                       PIC X(09) OCCURS 2.
           03  CONST-HOSYASEN          PIC X(09) VALUE "190106670".
           03  CONST-RYOYO             PIC X(09) VALUE "190105570".
           03  CONST-BTU-RYOYO-VAL.
               05                      PIC X(09) VALUE "190106070".
               05                      PIC X(09) VALUE "190106170".
               05                      PIC X(09) VALUE "190106270".
           03  CONST-BTU-RYOYO-R   REDEFINES   CONST-BTU-RYOYO-VAL.
               05  CONST-BTU-RYOYO     PIC X(09) OCCURS 3.
           03  CONST-JYUTOK1           PIC X(09) VALUE "190105870".
           03  CONST-JYUTOK2           PIC X(09) VALUE "190105970".
           03  CONST-MUKIN             PIC X(09) VALUE "190106570".
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
      *    診療科コード
           COPY  "CPSK1005.INC".
      *    病室種別
           COPY  "CPSK5108.INC".
      *    特定入院料（病棟）
           COPY  "CPSK5110.INC".
      *    特定入院料（病室）
           COPY  "CPSK5111.INC".
      *    室料差額
           COPY  "CPSK5113.INC".
      *    性別特定
           COPY  "CPSK5109.INC".
      *    点数マスタ
           COPY  "CPTENSU.INC".
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY  "CPPTNYUINRRK.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
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
           COPY    "W28.INC".
           COPY    "W98.INC".
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
               MOVE    SPA-GMN-W21-MOTOPG
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
           MOVE    "W21    "           TO  MCP-WINDOW.
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
           WHEN    "W20"
               IF    ( SPA-MOTOPG2     =   "W21" )
                   MOVE    "W01"       TO  SPA-MOTOPG
                   MOVE    SPACE       TO  SPA-MOTOPG2
                                           SPA-MOTOPG3
      *
      *            病棟情報取得処理
                   PERFORM 3101-SYS-5001-GET-SEC
                   MOVE    SPA-GMN-W21-BTU-NUM
                                       TO  WRK-KBNCD
                   PERFORM 800-BTU-JOHO-SRH-SEC
                   IF    ( WRK-KANRIDAT1   =   SPACE )
                       GO  TO  300-SCREEN-EXT
                   END-IF
      *
                   MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W21-BTU-NAME
                   MOVE    WRK-KANRIDAT2   TO  WRK-TOKTEI-NYUIN
                   MOVE    WRK-KANRIDAT3   TO  WRK-KHNSRYCD
                   MOVE    WRK-KANRIDAT4   TO  WRK-BTU-YUKSTYMD
      *
      *            入院基本料編集処理
                   PERFORM 3101-BTU-KHNRYO-EDIT-SEC
      *
                   GO  TO  300-SCREEN-EXT
               ELSE
                   PERFORM 310-SPASET-SEC
      *            病棟情報設定処理
                   PERFORM 310-BTU-SET-SEC
                   GO  TO  300-SCREEN-EXT
               END-IF
           WHEN    "WID1"
               MOVE    SPA-GMN-W21-MOTOPG
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
           MOVE    SPACE           TO  SPA-W21
                                           W21
           INITIALIZE                  SPA-W21
                                           W21
      *
      *    病棟情報取得処理
           PERFORM 3101-SYS-5001-GET-SEC
      *
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
           MOVE    1               TO  SPA-GMN-W21-CUR
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    病棟名称設定処理（病棟画面より遷移時）
      *****************************************************************
       310-BTU-SET-SEC                 SECTION.
      *
      *
      *    クリア処理
           PERFORM 420-CLEAR-SEC
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-W20-W21-BTU-NUM
                                   TO  WRK-KBNCD
           PERFORM 800-BTU-JOHO-SRH-SEC
           IF    ( WRK-KANRIDAT1   =   SPACE )
               GO  TO  310-BTU-SET-EXT
           END-IF
      *
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W21-BTU-NAME
           MOVE    WRK-KANRIDAT2   TO  WRK-TOKTEI-NYUIN
           MOVE    WRK-KANRIDAT3   TO  WRK-KHNSRYCD
           MOVE    WRK-KANRIDAT4   TO  WRK-BTU-YUKSTYMD
      *
      *    入院基本料編集処理
           PERFORM 3101-BTU-KHNRYO-EDIT-SEC
      *
      *    病室管理情報検索（病室リストに表示）
           PERFORM 3101-SYS-5002-GET-SEC
      *
           IF    ( SPA-GMN-W21-BRMLST-CNT  >   ZERO )
               MOVE    2           TO  SPA-GMN-W21-CUR
           ELSE
               MOVE    3           TO  SPA-GMN-W21-CUR
           END-IF
      *
           .
       310-BTU-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院基本料編集処理
      *****************************************************************
       3101-BTU-KHNRYO-EDIT-SEC    SECTION.
      *
           IF    ( WRK-TOKTEI-NYUIN    =   SPACE )
      *        点数マスタを検索し、入院基本料名を設定する
               PERFORM 3101-TENSU-SEL-SEC
               IF    ( FLG-TENSU       =   ZERO )
                   MOVE    TNS-NAME    TO  SPA-GMN-W21-BTU-KHNRYO
               END-IF
           ELSE
      *
      *        システム管理マスタを検索し、特定入院料名称を設定する
               INITIALIZE  SYSKANRI-REC
               MOVE    "5110"          TO  SYS-KANRICD
               MOVE    WRK-TOKTEI-NYUIN
                                       TO  SYS-KBNCD
      *
               MOVE    WRK-BTU-YUKSTYMD
                                       TO  ORC-DBYMD
      *
      *        システム管理マスタ検索処理
               MOVE    SYSKANRI-REC    TO  MCPDATA-REC
               MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
               PERFORM 900-TBL-SELECT-SEC
               IF    ( FLG-DBRC        =   ZERO )
                   MOVE    MCPDATA-REC
                                       TO  SYS-5110-REC
                   MOVE    SYS-5110-BTU-TOKUTEINYUIN-NM
                                       TO  SPA-GMN-W21-BTU-KHNRYO
               END-IF
      *
      *        システム管理マスタクローズ
               MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
               PERFORM 900-TBL-CLOSE-SEC
           END-IF
      *
           .
       3101-BTU-KHNRYO-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ検索処理
      *****************************************************************
       3101-TENSU-SEL-SEC          SECTION.
      *
           MOVE    ZERO            TO  FLG-TENSU
      *
           INITIALIZE              TNS-TENSU-REC
      *
           MOVE    WRK-KHNSRYCD    TO  TNS-SRYCD
           MOVE    WRK-BTU-YUKSTYMD
                                   TO  ORC-DBYMD
           MOVE    TNS-TENSU-REC   TO  MCPDATA-REC
      *
      *    病棟情報検索
           MOVE    "TENSU-KEY" TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC      NOT =   ZERO )
               MOVE    1           TO  FLG-TENSU
           ELSE
               MOVE    MCPDATA-REC
                                   TO  TNS-TENSU-REC
           END-IF
      *
      *    病棟情報クローズ
           MOVE    "TENSU-KEY" TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
      *
       3101-TENSU-SEL-EXT.
           EXIT.
      *****************************************************************
      *    コンボボックス初期処理（病棟コンボを除く）
      *****************************************************************
       3101-CMB-SYOKI-SEC          SECTION.
      *
      *    診療科コード取得処理
           PERFORM 3101-SYS-1005-GET-SEC
      *
      *    病室種別取得処理
           PERFORM 3101-SYS-5108-GET-SEC
      *
      *    特定入院料（病室）取得処理
           PERFORM 3101-SYS-5111-GET-SEC
      *
      *    室料差額取得処理
           PERFORM 3101-SYS-5113-GET-SEC
      *
      *    性別特定取得処理
           PERFORM 3101-SYS-5109-GET-SEC
      *
           .
       3101-CMB-SYOKI-EXT.
           EXIT.
      *
      *****************************************************************
      *    病棟情報取得処理
      *****************************************************************
       3101-SYS-5001-GET-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W21-CMB-BTU-NAME
      *
      *    システム管理マスタ検索処理
           INITIALIZE  SYSKANRI-REC
           MOVE    "5001"          TO  SYS-KANRICD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-DBRC    NOT =   ZERO )
                 OR      ( IDX1    >   50 )
      *
               COMPUTE SPA-GMN-W21-BTU-NAME-CNT
                   =   SPA-GMN-W21-BTU-NAME-CNT    +   1
      *
               MOVE    MCPDATA-REC
                                   TO  SYS-5001-REC
               MOVE    SYS-5001-KBNCD
                                   TO  SPA-GMN-W21-BTU-NAME-ITM
                                                        (IDX1) (1 : 2)
               MOVE    SYS-5001-BTU-NAME
                                   TO  SPA-GMN-W21-BTU-NAME-ITM
                                                        (IDX1) (4 : )
               MOVE    SYS-5001-BTU-TOKTEI-NYUIN
                                   TO  SPA-GMN-W21-BTU-NAME-ITM2
                                                                 (IDX1)
               MOVE    SYS-5001-BTU-KHNSRYCD
                                   TO  SPA-GMN-W21-BTU-NAME-ITM3
                                                                 (IDX1)
               MOVE    SYS-5001-STYUKYMD
                                   TO  SPA-GMN-W21-BTU-NAME-ITM4
                                                                 (IDX1)
      *
               MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
      *    システム管理マスタクローズ
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       3101-SYS-5001-GET-EXT.
           EXIT.
      *****************************************************************
      *    診療科コード取得処理
      *****************************************************************
       3101-SYS-1005-GET-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W21-CMB-BRM-KA
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
               COMPUTE SPA-GMN-W21-BRM-KA-CNT
                   =   SPA-GMN-W21-BRM-KA-CNT  +   1
      *
               MOVE    SYSKANRI-REC
                                   TO  SYS-1005-REC
               MOVE    SYS-1005-KBNCD
                                   TO  SPA-GMN-W21-BRM-KA-ITM
                                               (IDX1) (1 : 2)
               MOVE    SYS-1005-SRYKANAME
                                   TO  SPA-GMN-W21-BRM-KA-ITM
                                               (IDX1) (4 : )
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
      *    病室種別取得処理
      *****************************************************************
       3101-SYS-5108-GET-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W21-CMB-BRM-SBT
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "5108"          TO  SYS-KANRICD
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
      *
      *    システム管理マスタ検索処理
           PERFORM 3102-SYS-KANRI-SEL-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYSKANRI    =   1 )
                 OR      ( IDX1    >   15 )
      *
               COMPUTE SPA-GMN-W21-BRM-SBT-CNT
                   =   SPA-GMN-W21-BRM-SBT-CNT +   1
      *
               MOVE    SYSKANRI-REC
                                   TO  SYS-5108-REC
               MOVE    SYS-5108-KBNCD
                                   TO  SPA-GMN-W21-BRM-SBT-ITM
                                                   (IDX1) (1 : 2)
               MOVE    SYS-5108-BRM-SBT-NM
                                   TO  SPA-GMN-W21-BRM-SBT-ITM
                                                   (IDX1) (4 : )
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
       3101-SYS-5108-GET-EXT.
           EXIT.
      *****************************************************************
      *    特定入院料取得処理
      *****************************************************************
       3101-SYS-5111-GET-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W21-CMB-BRM-TOKNYUIN
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "5111"          TO  SYS-KANRICD
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
      *
      *    システム管理マスタ検索処理
           PERFORM 3102-SYS-KANRI-SEL-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYSKANRI    =   1 )
                 OR      ( SPA-GMN-W21-BRM-TOKNYUIN-CNT
                                           >   20 )
      *
               MOVE    SYSKANRI-REC
                                       TO  SYS-5111-REC
      *
               IF    ( SYS-5111-KBNCD      >=  "20"
                                                    )
                   CONTINUE
               ELSE
                   COMPUTE SPA-GMN-W21-BRM-TOKNYUIN-CNT
                       =   SPA-GMN-W21-BRM-TOKNYUIN-CNT    +   1
      *
                   MOVE    SPA-GMN-W21-BRM-TOKNYUIN-CNT
                                       TO  WRK-IDX3
      *
                   MOVE    SYS-5111-KBNCD
                                       TO  SPA-GMN-W21-BRM-TOKNYUIN-ITM
                                                   (WRK-IDX3) (1 : 2)
                   MOVE    SYS-5111-BRM-TOKUTEINYUIN-NM
                                       TO  SPA-GMN-W21-BRM-TOKNYUIN-ITM
                                                   (WRK-IDX3) (4 : )
                   MOVE    SYS-5111-BRM-TOKUTEINYUIN-NM2
                                       TO  SPA-GMN-W21-BRM-TOKNYUIN-ITM2
                                                   (WRK-IDX3)
               END-IF
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
       3101-SYS-5111-GET-EXT.
           EXIT.
      *****************************************************************
      *    室料差額取得処理
      *****************************************************************
       3101-SYS-5113-GET-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W21-CMB-BRM-SAGAKU
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "5113"          TO  SYS-KANRICD
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
      *
      *    システム管理マスタ検索処理
           PERFORM 3102-SYS-KANRI-SEL-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYSKANRI    =   1 )
                 OR      ( IDX1    >   20 )
      *
               COMPUTE SPA-GMN-W21-BRM-SAGAKU-CNT
                   =   SPA-GMN-W21-BRM-SAGAKU-CNT  +   1
      *
               MOVE    SYSKANRI-REC
                                   TO  SYS-5113-REC
               MOVE    SYS-5113-KBNCD
                                   TO  SPA-GMN-W21-BRM-SAGAKU-ITM
                                                   (IDX1) (1 : 2)
               MOVE    SYS-5113-BRM-SAGAKU-NM
                                   TO  WRK-99999
               INITIALIZE          WRK-HEN-SAGAKU
               MOVE    WRK-99999   TO  WRK-HEN-SAGAKU-Z9
               MOVE    "円"        TO  WRK-HEN-SAGAKU-EN
               MOVE    WRK-HEN-SAGAKU
                                   TO  SPA-GMN-W21-BRM-SAGAKU-ITM
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
       3101-SYS-5113-GET-EXT.
           EXIT.
      *****************************************************************
      *    性別特定取得処理
      *****************************************************************
       3101-SYS-5109-GET-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W21-CMB-BRM-SEX
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "5109"          TO  SYS-KANRICD
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
      *
      *    システム管理マスタ検索処理
           PERFORM 3102-SYS-KANRI-SEL-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYSKANRI    =   1 )
                 OR      ( IDX1    >   10 )
      *
               COMPUTE SPA-GMN-W21-BRM-SEX-CNT
                   =   SPA-GMN-W21-BRM-SEX-CNT +   1
      *
               MOVE    SYSKANRI-REC
                                   TO  SYS-5109-REC
               MOVE    SYS-5109-KBNCD
                                   TO  SPA-GMN-W21-BRM-SEX-ITM
                                               (IDX1) (1 : 2)
               MOVE    SYS-5109-BRM-SEX-NM
                                   TO  SPA-GMN-W21-BRM-SEX-ITM
                                               (IDX1) (4 : )
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
       3101-SYS-5109-GET-EXT.
           EXIT.
      *****************************************************************
      *    病室管理情報検索処理
      *****************************************************************
       3101-SYS-5002-GET-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W21-BRMLST-TBL
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "5002"          TO  SYS-KANRICD
           MOVE    SPA-GMN-W21-BTU-NUM
                                   TO  SYS-KBNCD
      *
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *    システム管理マスタ検索処理
           MOVE    "SYSKANRI-KEY9" TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-DBRC    NOT =   ZERO )
                 OR      ( IDX1    >   200 )
      *
      *
               MOVE    MCPDATA-REC
                                   TO  SYS-5002-REC
      *
               MOVE    IDX1        TO  SPA-GMN-W21-BRMLST-CNT
      *
      *        病室リスト編集
               PERFORM 3102-BRMLST-EDIT-SEC
      *
      *        システム管理マスタ読込処理
               MOVE    "SYSKANRI-KEY9" TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
      *    システム管理マスタクローズ
           MOVE    "SYSKANRI-KEY9" TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           IF    ( SPA-GMN-W21-BRMLST-CNT  >=  200 )
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W21-B06-STATE
           END-IF
      *
      *
           .
       3101-SYS-5002-GET-EXT.
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
           IF    ( FLG-DBRC        =   ZERO )
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
      *    病室リスト編集処理
      *****************************************************************
       3102-BRMLST-EDIT-SEC            SECTION.
      *
      *    選択番号
           MOVE    IDX1    TO  SPA-GMN-W21-TSELNUM (IDX1)
      *    病室番号
           IF    ( SYS-5002-KBNCD ( 3 : )
                           IS  NUMERIC )
               MOVE    SYS-5002-KBNCD ( 3 : )
                           TO   WRK-999999
               MOVE    WRK-999999
                           TO   WRK-ZZZZZ9
               MOVE    WRK-ZZZZZ9
                           TO  SPA-GMN-W21-TBRM-NUM (IDX1)
           ELSE
               MOVE    SYS-5002-BRM-NUM
                           TO  SPA-GMN-W21-TBRM-NUM (IDX1)
           END-IF
      *
           MOVE    SYS-5002-BRM-NUM
                           TO  SPA-GMN-W21-TBRM-NUM2 (IDX1)
      *    病室種別
           MOVE    SYS-5002-BRM-SBT
                           TO  WRK-KBNCD
           PERFORM 800-BRM-SBT-SRH-SEC
           MOVE    WRK-KANRIDAT1 (4 : )
                           TO  SPA-GMN-W21-TBRM-SBT (IDX1)
      *    特定入院料
           MOVE    SYS-5002-BRM-TOKTEI-NYUIN
                           TO  WRK-KBNCD
           PERFORM 800-BRM-TOKUTEINYUIN-SRH-SEC
           MOVE    WRK-KANRIDAT2
                           TO  SPA-GMN-W21-TBRM-TOKNYUIN (IDX1)
      *    収容人数
           MOVE    SYS-5002-BRM-NINZU
                           TO  SPA-GMN-W21-TBRM-NINZU (IDX1)
      *    室料差額
           MOVE    SYS-5002-BRM-SAGAKU
                           TO  WRK-KBNCD
           PERFORM 800-BRM-SAGAKU-SRH-SEC
           MOVE    WRK-KANRIDAT1-99999
                           TO  SPA-GMN-W21-TBRM-SAGAKU (IDX1)
      *    性別特定
           MOVE    SYS-5002-BRM-SEX
                           TO  WRK-KBNCD
           PERFORM 800-BRM-SEX-SRH-SEC
           MOVE    WRK-KANRIDAT1 (3 : )
                           TO  SPA-GMN-W21-TBRM-SEX (IDX1)
      *
      *    内線番号
           MOVE    SYS-5002-BRM-NAITEL
                           TO  SPA-GMN-W21-TBRM-NAITEL (IDX1)
      *
      *    診療科
           MOVE    SYS-5002-BRM-KA
                           TO  WRK-KBNCD
           PERFORM 800-BRM-KA-SRH-SEC
           MOVE    WRK-KANRIDAT1 (4 : )
                           TO  SPA-GMN-W21-TBRM-KA (IDX1)
      *
      *    有効開始日
           MOVE    SYS-5002-STYUKYMD
                           TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG
                           TO  SPA-GMN-W21-TYUKOSTYMD (IDX1)
      *
      *    有効終了日
           MOVE    SYS-5002-EDYUKYMD
                           TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG
                           TO  SPA-GMN-W21-TYUKOEDYMD (IDX1)
      *
           .
       3102-BRMLST-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    入力項目領域編集処理
      *****************************************************************
       4100-INPUT-AREA-EDIT-SEC            SECTION.
      *
           MOVE    ZERO            TO  FLG-INPUT-AREA
      *
      *    病室情報検索処理
           PERFORM 4200-BRM-SEL-SEC
           IF    ( FLG-SYSKANRI    NOT =   ZERO )
               MOVE    1           TO  FLG-INPUT-AREA
               GO  TO  4100-INPUT-AREA-EDIT-EXT
           END-IF
      *
      *    画面状態
           IF    ( SYS-5002-EDYUKYMD   >=  SPA-SYSYMD )
               MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-W21-STATE
           ELSE
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W21-STATE
           END-IF
      *
      *    有効開始日
           MOVE    SYS-5002-STYUKYMD
                                   TO  SPA-NAI-W21-YUKOSTYMD
                                       SPA-NAI-W21-YUKOSTYMD-OLD
                                       WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-W21-YUKOSTYMD
      *
      *    有効終了日
           MOVE    SYS-5002-EDYUKYMD
                                   TO  SPA-NAI-W21-YUKOEDYMD
                                       SPA-NAI-W21-YUKOEDYMD-OLD
                                       WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-W21-YUKOEDYMD
      *
      *    システム管理情報再設定処理
           PERFORM 4100-SYS-KANRI-SAI-SET-SEC
      *
      *    区分コード
           MOVE    SYS-5002-KBNCD
                                   TO  SPA-NAI-W21-5002-KBNCD
      *
      *    選択番号１
           MOVE    WRK-SELNUM      TO  SPA-GMN-W21-SELNUM1
      *
      *    病室番号
           MOVE    SYS-5002-BRM-NUM
                                   TO  SPA-GMN-W21-BRM-NUM
                                       SPA-NAI-W21-BRM-NUM-OLD
      *
      *    病室種別
           MOVE    SYS-5002-BRM-SBT
                                   TO  WRK-KBNCD
           PERFORM 800-BRM-SBT-SRH-SEC
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W21-BRM-SBT
      *
      *    特定入院料
           MOVE    SYS-5002-BRM-TOKTEI-NYUIN
                                   TO  WRK-KBNCD
           PERFORM 800-BRM-TOKUTEINYUIN-SRH-SEC
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W21-BRM-TOKNYUIN
      *
      *    収容人数
           MOVE    SYS-5002-BRM-NINZU
                                   TO  SPA-GMN-W21-BRM-NINZU
      *
      *    室料差額
           MOVE    SYS-5002-BRM-SAGAKU
                                   TO  WRK-KBNCD
      *
           PERFORM 800-BRM-SAGAKU-SRH-SEC
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W21-BRM-SAGAKU
      *
      *    性別特定
           MOVE    SYS-5002-BRM-SEX
                                   TO  WRK-KBNCD
           PERFORM 800-BRM-SEX-SRH-SEC
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W21-BRM-SEX
      *
      *    内線番号
           MOVE    SYS-5002-BRM-NAITEL
                                   TO  SPA-GMN-W21-BRM-NAITEL
      *
      *    診療科
           MOVE    SYS-5002-BRM-KA TO  WRK-KBNCD
           PERFORM 800-BRM-KA-SRH-SEC
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W21-BRM-KA
      *
           .
       4100-INPUT-AREA-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    入力項目領域編集処理
      *****************************************************************
       4200-BRM-SEL-SEC                SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           INITIALIZE              SYS-5002-REC
           MOVE    "5002"          TO  SYS-5002-KANRICD
           MOVE    SPA-GMN-W21-BTU-NUM
                                   TO  WRK-SYS5002-BTU-NUM
      *
           PERFORM 4100-BRM-NUM-KEY-EDIT-SEC
           MOVE    WRK-BRM-NUM-KEY TO  WRK-SYS5002-BRM-NUM
      *
           MOVE    WRK-SYS5002-KBNCD
                                   TO  SYS-5002-KBNCD
      *
           MOVE    WRK-KIJUN-YMD   TO  ORC-DBYMD
           MOVE    SYS-5002-REC    TO  MCPDATA-REC
      *
      *    病棟情報検索
           MOVE    "SYSKANRI-KEY10"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    NOT =   ZERO )
               MOVE    1           TO  FLG-SYSKANRI
           ELSE
               MOVE    MCPDATA-REC
                                   TO  SYS-5002-REC
           END-IF
      *
      *    病棟情報クローズ
           MOVE    "SYSKANRI-KEY10"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       4200-BRM-SEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    履歴領域編集処理
      *****************************************************************
       4100-RIREKI-AREA-EDIT-SEC       SECTION.
      *
           INITIALIZE      SPA-GMN-W21-RIREKILST-TBL
                           SPA-NAI-W21-RIREKILST-TBL
      *
      *    病室情報検索
           PERFORM         4100-BRM-SEL-SEC
           IF   (  FLG-SYSKANRI    =   ZERO )
               CONTINUE
           ELSE
               GO  TO  4100-RIREKI-AREA-EDIT-EXT
           END-IF
      *
           MOVE    SPA-GMN-W21-BRMLST-SEL-NUM
                                       TO  SPA-NAI-W21-RIREKILST-SELNUM
      *
           MOVE    SPA-GMN-W21-BRM-NUM
                                       TO  SPA-NAI-W21-RIREKILST-BRM-NUM
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYSKANRI    NOT =   ZERO )
                 OR      ( IDX1        >   20 )
      *
               MOVE    IDX1            TO  SPA-GMN-W21-RIREKILST-CNT
      *
      *        選択番号
               MOVE    IDX1            TO  SPA-GMN-W21-TRSELNUM (IDX1) 
      *
      *        有効開始日
               MOVE    SYS-5002-STYUKYMD
                                   TO  SPA-NAI-W21-TRYUKOSTYMD (IDX1)
                                           WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG TO  SPA-GMN-W21-TRYUKOSTYMD (IDX1)
      *
      *        有効終了日
               MOVE    SYS-5002-EDYUKYMD
                                   TO  SPA-NAI-W21-TRYUKOEDYMD (IDX1)
                                       WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG TO  SPA-GMN-W21-TRYUKOEDYMD (IDX1)
      *
               IF    ( SPA-NAI-W21-YUKOSTYMD-OLD
                                   =   SPA-NAI-W21-TRYUKOSTYMD (IDX1))
                AND  ( SPA-NAI-W21-YUKOEDYMD-OLD
                                   =   SPA-NAI-W21-TRYUKOEDYMD (IDX1))
                   MOVE    IDX1    TO  SPA-GMN-W21-SELNUM2
                   MOVE    IDX1    TO  SPA-GMN-W21-RIREKILST-SEL-NUM
               END-IF
      *
      *        病棟データ読込処理
               PERFORM 4100-BRM-READ-SEC
      *
           END-PERFORM
      *
      *    病棟データクローズ処理
           PERFORM 4100-BRM-CLOSE-SEC
           .
      *
      *
       4100-RIREKI-AREA-EDIT-EXT.
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
           .
       330-WID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                           SECTION.
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
      *        病棟管理情報画面へ
               WHEN    "CLICKED"       ALSO    "B09"
                   IF  ( SPA-MOTOPG    =       "W01" )
                       MOVE   "CHANGE"             TO  MCP-PUTTYPE
                       PERFORM 420-BYOTO-KANRI-SENI-SEC
                   END-IF
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
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        病棟名称
               WHEN    "ACTIVATE"      ALSO    "BTU_NAME"
                   PERFORM 4100-BTU-NAME-CHK-SEC
      *        選択番号１
               WHEN    "ACTIVATE"      ALSO    "SELNUM1"
                   PERFORM 4100-SELNUM1-CHK-SEC
      *        選択番号
               WHEN    "ACTIVATE"      ALSO    "SELNUM2"
                   PERFORM 4100-SELNUM2-CHK-SEC
      *        病室リスト
               WHEN    ANY             ALSO    "BRMLST"
                   PERFORM 4100-BRMLST-CHK-SEC
      *        履歴リスト
               WHEN    ANY             ALSO    "RIREKILST"
                   PERFORM 4100-RIREKILST-CHK-SEC
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
           MOVE    ZERO        TO      SPA-GMN-W21-CUR
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
      *    病室番号
           MOVE    W21-BRM-NUM     TO  SPA-GMN-W21-BRM-NUM
      *
      *    病室種別
           MOVE    W21-BRM-SBT     TO  SPA-GMN-W21-BRM-SBT
      *
      *    特定入院料
           MOVE    W21-BRM-TOKUTEINYUIN
                                   TO  SPA-GMN-W21-BRM-TOKNYUIN
      *
      *    収容人数
           MOVE    W21-BRM-NINZU   TO  SPA-GMN-W21-BRM-NINZU
      *
      *    室料差額
           MOVE    W21-BRM-SAGAKU
                                   TO  SPA-GMN-W21-BRM-SAGAKU
      *
      *    性別特定
           MOVE    W21-BRM-SEX
                                   TO  SPA-GMN-W21-BRM-SEX
      *
      *    内線番号
           MOVE    W21-BRM-NAITEL  TO  SPA-GMN-W21-BRM-NAITEL
      *
      *    診療科
           MOVE    W21-BRM-KA      TO  SPA-GMN-W21-BRM-KA
      *
      *    有効期間開始日
           MOVE    W21-YUKOSTYMD   TO  SPA-GMN-W21-YUKOSTYMD
      *
      *    有効期間終了日
           MOVE    W21-YUKOEDYMD   TO  SPA-GMN-W21-YUKOEDYMD
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
      *    病棟名称チェック処理
           PERFORM 4101-BTU-NAME-CHK-SEC
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
      *    病室番号チェック処理
           PERFORM 4100-BRM-NUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    病室種別チェック処理
           PERFORM 4100-BRM-SBT-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    特定入院料チェック処理
           PERFORM 4100-BRM-TOKUTEINYUIN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    収容人数チェック処理
           PERFORM 4100-BRM-NINZU-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    室料差額チェック処理
           PERFORM 4100-BRM-SAGAKU-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    性別特定チェック処理
           PERFORM 4100-BRM-SEX-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    内線番号チェック処理
           PERFORM 4100-BRM-NAITEL-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    診療科チェック処理
           PERFORM 4100-BRM-KA-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
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
           MOVE    SPA-MOTOPG          TO  SPA-SAKIPG
           MOVE    SPA-MOTOPG2         TO  SPA-MOTOPG3
           MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
           MOVE    "W21"               TO  SPA-MOTOPG
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
           INITIALIZE  SPA-GMN-W21-RIREKILST-TBL
                       SPA-NAI-W21-RIREKILST-TBL
                       SPA-GMN-W21-BRMLST-TBL
      *
           PERFORM 4201-HEAD-AREA-CLEAR-SEC
      *
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
           MOVE    1               TO  SPA-GMN-W21-CUR
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
               MOVE    11          TO  SPA-GMN-W21-CUR
               GO  TO  420-TUIKA-EXT
           END-IF
      *
      *    病室情報追加編集処理
           PERFORM 4201-BRM-INSERT-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
      *        病室リストを再編集する
               PERFORM 3101-SYS-5002-GET-SEC
               GO  TO  420-TUIKA-EXT
           END-IF
      *
      *    病棟リストを再編集する
           PERFORM 3101-SYS-5002-GET-SEC
      *
           PERFORM 4100-BRM-NUM-LSTSEL-SEC
           IF    ( FLG-BRM-NUM =   ZERO )
               MOVE    IDX-BRMLST
                                   TO  SPA-GMN-W21-BRMLST-SEL-NUM
           END-IF
      *
      *    履歴リストを再編集する
           PERFORM 4100-RIREKI-AREA-EDIT-SEC
           MOVE    ZERO            TO  SPA-GMN-W21-RIREKILST-SEL-NUM
      *
      *    入力項目を初期化する
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
      *    病棟リスト最大件数チェック
           IF    ( SPA-GMN-W21-BRMLST-CNT  >=  200 )
               MOVE    "1001"      TO  SPA-ERRCD
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W21-B06-STATE
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
      *    選択番号が入力されていること
           IF    ( SPA-GMN-W21-SELNUM1 NOT =   ZERO )
               CONTINUE
           ELSE
               MOVE    "1105"      TO  SPA-ERRCD
               MOVE    2           TO  SPA-GMN-W21-CUR
               GO  TO  420-HENKOU-EXT
           END-IF
      *
      *    病室番号が変更されていないこと
           IF    ( SPA-GMN-W21-BRM-NUM     =   SPA-NAI-W21-BRM-NUM-OLD )
               CONTINUE
           ELSE
               MOVE    "1106"      TO  SPA-ERRCD
               MOVE    3           TO  SPA-GMN-W21-CUR
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
           IF    ( SPA-NAI-W21-YUKOSTYMD
                               NOT =   SPA-NAI-W21-YUKOSTYMD-OLD )
            AND
                 ( SPA-NAI-W21-YUKOEDYMD
                               NOT =   SPA-NAI-W21-YUKOEDYMD-OLD )
               MOVE    "1107"      TO  SPA-ERRCD
               MOVE    11          TO  SPA-GMN-W21-CUR
               GO  TO  420-HENKOU-EXT
           END-IF
      *
      *    既存の履歴データをチェックし、期間の重複したデータが
      *    存在しないこと
           MOVE    2                   TO  FLG-UPD-KBN
           PERFORM 4100-RIREKI-CHK-SEC
           IF   ( FLG-KIKAN-DABURI NOT =   ZERO )
               MOVE    "1104"          TO  SPA-ERRCD
               MOVE    11          TO  SPA-GMN-W21-CUR
               GO  TO  420-HENKOU-EXT
           END-IF
      *
      *    病室リスト更新処理
           PERFORM 4201-BRM-UPDATE-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
      *        病室リストを再編集する
               PERFORM 3101-SYS-5002-GET-SEC
               GO  TO  420-HENKOU-EXT
           END-IF
      *
      *    病室リストを再編集する
           PERFORM 3101-SYS-5002-GET-SEC
      *
           PERFORM 4100-BRM-NUM-LSTSEL-SEC
           IF    ( FLG-BRM-NUM =   ZERO )
               MOVE    IDX-BRMLST
                                   TO  SPA-GMN-W21-BRMLST-SEL-NUM
      *        履歴リストを再編集する
               PERFORM 4100-RIREKI-AREA-EDIT-SEC
               MOVE    ZERO        TO  SPA-GMN-W21-RIREKILST-SEL-NUM
      *
      *        入力項目を初期化する
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
           ELSE
      *        入力項目を初期化する
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
               PERFORM 4201-RIREKI-AREA-CLEAR-SEC
           END-IF
      *
           .
       420-HENKOU-EXT.
           EXIT.
      *****************************************************************
      *    削除処理
      *****************************************************************
       420-SAKUJO-SEC                  SECTION.
      *
      *    選択番号が入力されていること
           IF    ( SPA-GMN-W21-SELNUM1 NOT =   ZERO )
               CONTINUE
           ELSE
               MOVE    "1105"      TO  SPA-ERRCD
               MOVE    2           TO  SPA-GMN-W21-CUR
               GO  TO  420-SAKUJO-EXT
           END-IF
      *
      *    範囲内の選択番号が入力されていること
           IF    ( SPA-GMN-W21-SELNUM1 <=  SPA-GMN-W21-BRMLST-CNT )
               CONTINUE
           ELSE
               MOVE    "1008"      TO  SPA-ERRCD
               MOVE    2           TO  SPA-GMN-W21-CUR
               GO  TO  420-SAKUJO-EXT
           END-IF
      *
      *    入院中の患者が存在しないかチェック
           MOVE    ZERO            TO  FLG-PTNYUINRRK
           INITIALIZE              PTNYUINRRK-REC
           MOVE    SPA-HOSPID      TO  PTNYUINRRK-HOSPID
           MOVE    SPA-NAI-W21-5002-KBNCD
                                   TO  PTNYUINRRK-BRMNUM
           MOVE    SPA-NAI-W21-YUKOEDYMD-OLD
                                   TO  PTNYUINRRK-NYUINYMD
           MOVE    SPA-NAI-W21-YUKOSTYMD-OLD
                                   TO  PTNYUINRRK-TAIINYMD
           MOVE    PTNYUINRRK-REC  TO  MCPDATA-REC
           MOVE    "PTNYUINRRK-KEY15"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    NOT =   ZERO )
               MOVE    1           TO  FLG-PTNYUINRRK
           END-IF
      *
      *    病棟情報クローズ
           MOVE    "PTNYUINRRK-KEY15"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           IF    ( FLG-PTNYUINRRK  =   ZERO )
               MOVE    "1108"      TO  SPA-ERRCD
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
      *    病室情報削除処理
           PERFORM  4201-BRM-DELETE-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
      *        病棟リストを再編集する
               PERFORM 3101-SYS-5002-GET-SEC
               GO  TO  421-SAKUJO-EXT
           END-IF
      *
      *    病室リストを再編集する
           PERFORM 3101-SYS-5002-GET-SEC
      *
           PERFORM 4100-BRM-NUM-LSTSEL-SEC
           IF    ( FLG-BRM-NUM =   ZERO )
               MOVE    IDX-BRMLST
                                   TO  SPA-GMN-W21-BRMLST-SEL-NUM
      *        履歴リストを再編集する
               PERFORM 4100-RIREKI-AREA-EDIT-SEC
               MOVE    ZERO        TO  SPA-GMN-W21-RIREKILST-SEL-NUM
      *
      *        入力項目を初期化する
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
           ELSE
      *        画面を初期化する
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
               PERFORM 4201-RIREKI-AREA-CLEAR-SEC
           END-IF
           .
       421-SAKUJO-EXT.
           EXIT.
      *****************************************************************
      *    病棟管理遷移処理
      *****************************************************************
       420-BYOTO-KANRI-SENI-SEC        SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    SPA-GMN-W21-BTU-NUM TO  SPA-W20-W21-BTU-NUM
      *
           MOVE    "W20"               TO  SPA-SAKIPG
           MOVE    "W21"               TO  SPA-MOTOPG
           MOVE    "W01"               TO  SPA-MOTOPG2
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       420-BYOTO-KANRI-SENI-EXT.
           EXIT.
      *****************************************************************
      *    履歴チェック処理
      *****************************************************************
       4100-RIREKI-CHK-SEC             SECTION.
      *
           MOVE    ZERO            TO  FLG-KIKAN-DABURI
      *
      *    病棟情報検索処理
           PERFORM 4100-BRM-SEL-SEC
           IF   (  FLG-SYSKANRI    =   ZERO )
               CONTINUE
           ELSE
               GO  TO  4100-RIREKI-CHK-EXT
           END-IF
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYSKANRI    NOT =   ZERO )
      *
      *        有効期間が重複するデータがないかチェック
      *        （変更処理の場合、元データは対象外とする）
               IF    ( FLG-UPD-KBN           =  2 )
                AND  ( SPA-NAI-W21-BRM-NUM-OLD
                                             =   SYS-5002-BRM-NUM  )
                AND  ( SPA-NAI-W21-YUKOSTYMD-OLD
                                             =   SYS-5002-STYUKYMD )
                AND  ( SPA-NAI-W21-YUKOEDYMD-OLD
                                             =   SYS-5002-EDYUKYMD )
                   CONTINUE
               ELSE
                   IF    ( SPA-NAI-W21-YUKOEDYMD
                                             <   SYS-5002-STYUKYMD )
                     OR  ( SPA-NAI-W21-YUKOSTYMD
                                             >   SYS-5002-EDYUKYMD )
                       CONTINUE
                   ELSE
                       MOVE    "1"             TO  FLG-KIKAN-DABURI
                   END-IF
               END-IF
      *
      *        病棟データ読込処理
               PERFORM 4100-BRM-READ-SEC
      *
           END-PERFORM
      *
      *    病棟データクローズ処理
           PERFORM 4100-BRM-CLOSE-SEC
           .
      *
       4100-RIREKI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病室情報検索処理
      *****************************************************************
       4100-BRM-SEL-SEC            SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           INITIALIZE              SYS-5002-REC
           MOVE    "5002"          TO  SYS-5002-KANRICD
      *
           MOVE    SPA-GMN-W21-BTU-NUM
                                   TO  WRK-SYS5002-BTU-NUM
           MOVE    SPA-GMN-W21-BRM-NUM
                                   TO  WRK-BRM-NUM
           PERFORM 4100-BRM-NUM-KEY-EDIT-SEC
           MOVE    WRK-BRM-NUM-KEY TO  WRK-SYS5002-BRM-NUM
      *
           MOVE    WRK-SYS5002-KBNCD
                                   TO  SYS-5002-KBNCD
      *
           MOVE    "SYSKANRI-KEY8" TO  WRK-DBPATH
           MOVE    SYS-5002-REC    TO  MCPDATA-REC
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-5002-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
               GO  TO  4100-BRM-SEL-EXT
           END-IF
      *
           .
       4100-BRM-SEL-EXT.
           EXIT.
      *****************************************************************
      *    病室情報読込処理
      *****************************************************************
       4100-BRM-READ-SEC               SECTION.
      *
           MOVE    "SYSKANRI-KEY8" TO  WRK-DBPATH
           PERFORM 900-TBL-READ-SEC
           IF    ( FLG-DBRC        =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-5002-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
           END-IF
      *
           .
       4100-BRM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    病室情報クローズ処理
      *****************************************************************
       4100-BRM-CLOSE-SEC              SECTION.
      *
           MOVE    "SYSKANRI-KEY8" TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       4100-BRM-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    病室番号左詰処理
      *****************************************************************
       4100-BRM-NUM-LEFT-EDIT-SEC      SECTION.
      *
           IF    ( WRK-BRM-NUM-IN (1 : 1)  =   SPACE )
               MOVE    SPACE           TO  WRK-STR1
               MOVE    1               TO  WRK-IDX1
               UNSTRING    WRK-BRM-NUM-IN
                   DELIMITED   BY  ALL SPACE
                   INTO    WRK-STR1
                   WITH    POINTER WRK-IDX1
               END-UNSTRING
               MOVE    WRK-BRM-NUM-IN (WRK-IDX1 : )
                                       TO  WRK-BRM-NUM-EDT
           ELSE
               MOVE    WRK-BRM-NUM-IN  TO  WRK-BRM-NUM-EDT
           END-IF
      *
           PERFORM VARYING WRK-IDX1    FROM    6   BY  -1
               UNTIL     ( WRK-IDX1    <   1 )
                 OR      ( WRK-BRM-NUM-EDT (WRK-IDX1 : 1)
                                   NOT =   SPACE )
               CONTINUE
           END-PERFORM
      *
           IF    ( WRK-IDX1    <   1 )
               MOVE    WRK-BRM-NUM-EDT TO  WRK-BRM-NUM-OT
               GO  TO  4100-BRM-NUM-LEFT-EDIT-EXT
           END-IF
      *
      *    病室番号が数字の場合前ゼロをとる
           IF    ( WRK-BRM-NUM-EDT ( 1 : WRK-IDX1 )
                                       IS  NUMERIC )
               IF    ( WRK-BRM-NUM-EDT ( 1 : 1 )
                                       =   ZERO )
                   MOVE    1               TO  WRK-IDX2
                   MOVE    SPACE           TO  WRK-STR1
                   UNSTRING    WRK-BRM-NUM-EDT
                       DELIMITED BY  ALL ZERO
                   INTO    WRK-STR1
                   WITH    POINTER WRK-IDX2
                   END-UNSTRING
                   MOVE    WRK-BRM-NUM-EDT (WRK-IDX2 : )
                                           TO  WRK-BRM-NUM-OT
               ELSE
                   MOVE    WRK-BRM-NUM-EDT TO  WRK-BRM-NUM-OT
               END-IF
           ELSE
                   MOVE    WRK-BRM-NUM-EDT TO  WRK-BRM-NUM-OT
           END-IF
      *
           .
       4100-BRM-NUM-LEFT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病室番号キー作成処理
      *****************************************************************
       4100-BRM-NUM-KEY-EDIT-SEC       SECTION.
      *
           MOVE    SPACE           TO  WRK-STR1
           MOVE    1               TO  WRK-IDX1
           STRING  WRK-BRM-NUM
               DELIMITED   BY  SPACE
               INTO    WRK-STR1
               WITH    POINTER WRK-IDX1
           END-STRING
      *
           COMPUTE WRK-IDX1    =   WRK-IDX1    -   1
      *
           IF    ( WRK-IDX1    <   1 )
               MOVE    WRK-BRM-NUM TO  WRK-BRM-NUM-KEY
               GO  TO  4100-BRM-NUM-KEY-EDIT-EXT
           END-IF
      *
      *    病室番号が数字の場合ゼロ詰めを行う
           IF    ( WRK-BRM-NUM ( 1 : WRK-IDX1 )
                               IS  NUMERIC )
               COMPUTE WRK-IDX2    =   6   -   WRK-IDX1 + 1
               MOVE    ZERO    TO  WRK-BRM-NUM-KEY
               MOVE    WRK-BRM-NUM ( 1 : WRK-IDX1 )
                               TO  WRK-BRM-NUM-KEY (WRK-IDX2 : WRK-IDX1)
           ELSE
               MOVE    WRK-BRM-NUM TO  WRK-BRM-NUM-KEY
           END-IF
      *
           .
       4100-BRM-NUM-KEY-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病室情報更新処理
      *****************************************************************
       4201-BRM-UPDATE-SEC             SECTION.
      *
      *    アップデート対象のデータを読み直す
           MOVE    SPA-GMN-W21-BRM-NUM
                                   TO  WRK-BRM-NUM
           MOVE    SPA-NAI-W21-YUKOSTYMD-OLD
                                   TO  WRK-KIJUN-YMD
           PERFORM 4200-BRM-SEL-SEC
           IF   ( FLG-SYSKANRI     NOT =   ZERO )
               MOVE    "1201"      TO  SPA-ERRCD
               GO  TO  4201-BRM-UPDATE-EXT
           END-IF
      *
      *    病室情報編集処理
           PERFORM 4201-BRM-EDIT-SEC
      *
           MOVE    SYS-5002-REC    TO  SYSKANRI-REC
           MOVE    SYS-5002-KANRICD
                                   TO  SYSUP-KANRICD
           MOVE    SPA-NAI-W21-5002-KBNCD
                                   TO  SYSUP-KBNCD
           MOVE    SPA-NAI-W21-YUKOSTYMD-OLD
                                   TO  SYSUP-STYUKYMD
           MOVE    SPA-NAI-W21-YUKOEDYMD-OLD
                                   TO  SYSUP-EDYUKYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *
           MOVE    "SYSKANRI-UPD1" TO  WRK-DBPATH
      *
           PERFORM 900-TBL-UPDATE-SEC
           IF   (  FLG-DBRC        NOT =   ZERO )
               MOVE    "1201"      TO  SPA-ERRCD
               GO  TO  4201-BRM-UPDATE-EXT
           END-IF
           .
      *
       4201-BRM-UPDATE-EXT.
           EXIT.
      *****************************************************************
      *    病室情報追加処理
      *****************************************************************
       4201-BRM-INSERT-SEC             SECTION.
      *
      *    更新対象のデータが既に存在しないかチェック
           MOVE    SPA-GMN-W21-BRM-NUM
                                   TO  WRK-BRM-NUM
           MOVE    SPA-NAI-W21-YUKOSTYMD
                                   TO  WRK-KIJUN-YMD
           PERFORM 4200-BRM-SEL-SEC
           IF   ( FLG-SYSKANRI     =   ZERO )
               MOVE    "1201"      TO  SPA-ERRCD
               GO  TO  4201-BRM-INSERT-EXT
           END-IF
      *
           MOVE    SPACE       TO  SYS-5002-REC
           INITIALIZE              SYS-5002-REC
      *
      *    病室情報編集処理
           PERFORM 4201-BRM-EDIT-SEC
      *
      *    病室加算情報編集処理
           PERFORM 4201-BRM-KSN-EDIT-SEC
      *
           MOVE    SYS-5002-REC    TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-INSERT-SEC
           IF   (  FLG-DBRC        NOT =   ZERO )
               MOVE    "1202"      TO  SPA-ERRCD
               GO  TO  4201-BRM-INSERT-EXT
           END-IF
      *
           .
      *
       4201-BRM-INSERT-EXT.
           EXIT.
      *****************************************************************
      *    病室情報削除処理
      *****************************************************************
       4201-BRM-DELETE-SEC             SECTION.
      *
           INITIALIZE              SYS-5002-REC
           MOVE    "5002"          TO  SYS-5002-KANRICD
           MOVE    SPA-NAI-W21-5002-KBNCD
                                   TO  SYS-5002-KBNCD
           MOVE    SPA-NAI-W21-YUKOSTYMD-OLD
                                   TO  SYS-5002-STYUKYMD
           MOVE    SPA-NAI-W21-YUKOEDYMD-OLD
                                   TO  SYS-5002-EDYUKYMD
           MOVE    SYS-5002-REC    TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-DELETE-SEC
           IF   (  FLG-DBRC        NOT =   ZERO )
               MOVE    "1203"      TO  SPA-ERRCD
               GO  TO  4201-BRM-DELETE-EXT
           END-IF
      *
           .
       4201-BRM-DELETE-EXT.
           EXIT.
      *****************************************************************
      *    病室情報編集処理
      *****************************************************************
       4201-BRM-EDIT-SEC               SECTION.
      *
      *    MOVE    SPACE       TO  SYS-5002-REC
      *    INITIALIZE              SYS-5002-REC
      *
      *    管理コード
           MOVE    "5002"      TO  SYS-5002-KANRICD
      *
      *    区分コード
           MOVE    SPA-GMN-W21-BTU-NUM
                               TO  WRK-SYS5002-BTU-NUM
      *
           MOVE    SPA-GMN-W21-BRM-NUM
                               TO  WRK-BRM-NUM
           PERFORM 4100-BRM-NUM-KEY-EDIT-SEC
           MOVE    WRK-BRM-NUM-KEY
                               TO  WRK-SYS5002-BRM-NUM
      *
           MOVE    WRK-SYS5002-KBNCD
                               TO  SYS-5002-KBNCD
      *
      *    有効開始年月日
           MOVE    SPA-NAI-W21-YUKOSTYMD
                               TO  SYS-5002-STYUKYMD
      *
      *    有効終了年月日
           MOVE    SPA-NAI-W21-YUKOEDYMD
                               TO  SYS-5002-EDYUKYMD
      *
      *    病室番号
           MOVE    SPA-GMN-W21-BRM-NUM
                               TO  SYS-5002-BRM-NUM
      *
      *    病室種別
           MOVE    SPA-GMN-W21-BRM-SBT-CD
                               TO  SYS-5002-BRM-SBT
      *
      *    特定入院料
           MOVE    SPA-GMN-W21-BRM-TOKNYUIN-CD
                               TO  SYS-5002-BRM-TOKTEI-NYUIN
      *
      *    収容人数
           MOVE    SPA-GMN-W21-BRM-NINZU
                               TO  SYS-5002-BRM-NINZU
      *
      *    室料差額
           MOVE    SPA-GMN-W21-BRM-SAGAKU-CD
                               TO  SYS-5002-BRM-SAGAKU
      *
      *    性別特定
           MOVE    SPA-GMN-W21-BRM-SEX-CD
                               TO  SYS-5002-BRM-SEX
      *
      *    内線番号
           MOVE    SPA-GMN-W21-BRM-NAITEL
                               TO  SYS-5002-BRM-NAITEL
      *
      *    診療科
           MOVE    SPA-GMN-W21-BRM-KA-CD
                               TO  SYS-5002-BRM-KA
      *
           .
       4201-BRMLST-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病室情報編集処理
      *****************************************************************
       4201-BRM-KSN-EDIT-SEC           SECTION.
      *
      *    --  加算情報に初期値を設定  --
      *
      *    新生児入院医療管理加算
           MOVE    CONST-SINSEIJI  TO  SYS-5002-SINSEIJI-CD
           MOVE    "1"             TO  SYS-5002-SINSEIJI-KBN
      *
      *    診療所療養病床療養環境加算
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   2 )
               MOVE    CONST-SNR-RYOYO (IDX1)
                                   TO  SYS-5002-SNR-RYOYO-CD  (IDX1)
               MOVE    "1"         TO  SYS-5002-SNR-RYOYO-KBN (IDX1)
           END-PERFORM
      *
      *    放射線治療病室管理加算
           MOVE    CONST-HOSYASEN  TO  SYS-5002-HOSYASEN-CD
           MOVE    "1"             TO  SYS-5002-HOSYASEN-KBN
      *
      *    療養環境加算
           MOVE    CONST-RYOYO     TO  SYS-5002-RYOYO-CD
           MOVE    "1"             TO  SYS-5002-RYOYO-KBN
      *
      *    療養病棟療養環境加算
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   3 )
               MOVE    CONST-BTU-RYOYO (IDX1)
                                   TO  SYS-5002-BTU-RYOYO-CD  (IDX1)
               MOVE    "1"         TO  SYS-5002-BTU-RYOYO-KBN (IDX1)
           END-PERFORM
      *
      *    重症者等療養環境特別加算（個室）
           MOVE    CONST-JYUTOK1   TO  SYS-5002-JYUTOK1-CD
      *
      *    重症者等療養環境特別加算（２人部屋）
           MOVE    CONST-JYUTOK2   TO  SYS-5002-JYUTOK2-CD
      *
      *    無菌治療室管理加算
           MOVE    CONST-MUKIN     TO  SYS-5002-MUKIN-CD
      *
           .
       4201-BRM-KSN-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病棟名称
      *****************************************************************
       4100-BTU-NAME-CHK-SEC           SECTION.
      *
           MOVE    1           TO  SPA-GMN-W21-CUR
      *
      *    クリア処理
           PERFORM 420-CLEAR-SEC
      *
           MOVE    SPACE       TO  SPA-GMN-W21-BTU-KHNRYO
      *
           MOVE    W21-BTU-NAME    TO  SPA-GMN-W21-BTU-NAME
      *
           PERFORM 4101-BTU-NAME-CHK-SEC
           IF   (  SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-BTU-NAME-CHK-EXT
           END-IF
      *
      *    入院基本料編集処理
           PERFORM 3101-BTU-KHNRYO-EDIT-SEC
      *
      *    病室管理情報検索（病室リストに表示）
           PERFORM 3101-SYS-5002-GET-SEC
      *
           MOVE    2               TO  SPA-GMN-W21-CUR
      *
           .
      *
       4100-BTU-NAME-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟名称
      *****************************************************************
       4101-BTU-NAME-CHK-SEC           SECTION.
      *
           IF    ( SPA-GMN-W21-BTU-NAME
                                   =   SPACE )
               MOVE    "1006"      TO  SPA-ERRCD
               MOVE    1           TO  SPA-GMN-W21-CUR
               GO  TO  4101-BTU-NAME-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W21-BTU-NUM
                                   TO  WRK-KBNCD
           PERFORM 800-BTU-JOHO-SRH-SEC
           IF    ( WRK-KANRIDAT1   =   SPACE )
               MOVE    "1007"      TO  SPA-ERRCD
               MOVE    1           TO  SPA-GMN-W21-CUR
               GO  TO  4101-BTU-NAME-CHK-EXT
           END-IF
      *
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W21-BTU-NAME
           MOVE    WRK-KANRIDAT2   TO  WRK-TOKTEI-NYUIN
           MOVE    WRK-KANRIDAT3   TO  WRK-KHNSRYCD
           MOVE    WRK-KANRIDAT4   TO  WRK-BTU-YUKSTYMD
           .
      *
       4101-BTU-NAME-CHK-EXT.
           EXIT.
      *****************************************************************
      *    選択番号１
      *****************************************************************
       4100-SELNUM1-CHK-SEC            SECTION.
      *
           MOVE    2           TO  SPA-GMN-W21-CUR
      *
           MOVE    W21-SELNUM1 TO  SPA-GMN-W21-SELNUM1
      *
           IF    ( SPA-GMN-W21-SELNUM1 =   ZERO )
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
               PERFORM 4201-RIREKI-AREA-CLEAR-SEC
               MOVE    3           TO  SPA-GMN-W21-CUR
               GO  TO  4100-SELNUM1-CHK-EXT
           END-IF
      *
           IF    ( SPA-GMN-W21-SELNUM1 <=  SPA-GMN-W21-BRMLST-CNT )
               CONTINUE
           ELSE
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
               PERFORM 4201-RIREKI-AREA-CLEAR-SEC
               MOVE    W21-SELNUM1     TO  SPA-GMN-W21-SELNUM1
               MOVE    "1008"          TO  SPA-ERRCD
               GO  TO  4100-SELNUM1-CHK-EXT
           END-IF
      *
      *    入力項目領域編集処理
           MOVE    SPA-GMN-W21-TBRM-NUM2 (SPA-GMN-W21-SELNUM1)
                                   TO  WRK-BRM-NUM
           MOVE    SPA-SYSYMD      TO  WRK-KIJUN-YMD
      *
      *    入力領域初期化
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
      *    履歴領域初期化
           PERFORM 4201-RIREKI-AREA-CLEAR-SEC
      *
      *    入力データ編集処理
           MOVE    W21-SELNUM1     TO  WRK-SELNUM
           PERFORM 4100-INPUT-AREA-EDIT-SEC
           IF    ( FLG-INPUT-AREA  =   ZERO )
      *
               MOVE    W21-SELNUM1 TO  SPA-GMN-W21-BRMLST-SEL-NUM
      *
      *        履歴データ編集処理
               PERFORM 4100-RIREKI-AREA-EDIT-SEC
           ELSE
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
               PERFORM 4201-RIREKI-AREA-CLEAR-SEC
               MOVE    W21-SELNUM1 TO  SPA-GMN-W21-SELNUM1
           END-IF
      *
           MOVE    3           TO  SPA-GMN-W21-CUR
           .
      *
       4100-SELNUM1-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病室番号
      *****************************************************************
       4100-BRM-NUM-CHK-SEC            SECTION.
      *
           IF    ( SPA-GMN-W21-BRM-NUM =   SPACE   )
               GO  TO  4100-BRM-NUM-CHK-EXT
           END-IF
      *
      *    全角半角混在チェック
           MOVE    SPA-GMN-W21-BRM-NUM
                                   TO  WRK-KANACHK-MAE-INPUT
      *
           PERFORM     800-ENRTRY-CHK-SEC
           IF  ( FLG-ENTRYCHK      NOT =   1 )
               MOVE    3               TO  SPA-GMN-W21-CUR
               MOVE    "0002"          TO  SPA-ERRCD
               GO  TO  4100-BRM-NUM-CHK-EXT
           END-IF
      *
      *    左詰編集を行う
           MOVE    SPA-GMN-W21-BRM-NUM TO  WRK-BRM-NUM-IN
           PERFORM 4100-BRM-NUM-LEFT-EDIT-SEC
           MOVE    WRK-BRM-NUM-OT      TO  SPA-GMN-W21-BRM-NUM
      *
      *    間に空白文字が混入していないかチェック
           MOVE    SPACE           TO  WRK-STR1
                                       WRK-STR2
           UNSTRING    SPA-GMN-W21-BRM-NUM
               DELIMITED   BY  ALL SPACE
               INTO    WRK-STR1
                       WRK-STR2
           END-UNSTRING
      *
           IF    ( WRK-STR2        NOT =   SPACE )
               MOVE    3               TO  SPA-GMN-W21-CUR
               MOVE    "0001"          TO  SPA-ERRCD
               GO  TO  4100-BRM-NUM-CHK-EXT
           END-IF
      *
           .
      *
       4100-BRM-NUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病室種別
      *****************************************************************
       4100-BRM-SBT-CHK-SEC            SECTION.
      *
           IF    ( SPA-GMN-W21-BRM-SBT     =   SPACE )
               GO  TO  4100-BRM-SBT-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W21-BRM-SBT-CD
                                   TO  WRK-KBNCD
           PERFORM 800-BRM-SBT-SRH-SEC
           IF    ( WRK-KANRIDAT1   =   SPACE )
               MOVE    4           TO  SPA-GMN-W21-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-BRM-SBT-CHK-EXT
           END-IF
      *
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W21-BRM-SBT
      *
           .
      *
       4100-BRM-SBT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    特定入院料
      *****************************************************************
       4100-BRM-TOKUTEINYUIN-CHK-SEC   SECTION.
      *
           IF    ( SPA-GMN-W21-BRM-TOKNYUIN    =   SPACE )
               GO  TO  4100-BRM-TOKUTEINYUIN-CHK-EXT
           END-IF
      *
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W21-BRM-TOKNYUIN-CD
                                   TO  WRK-KBNCD
           PERFORM 800-BRM-TOKUTEINYUIN-SRH-SEC
           IF    ( WRK-KANRIDAT1   =   SPACE )
               MOVE    5           TO  SPA-GMN-W21-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-BRM-TOKUTEINYUIN-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-W21-BRM-TOKNYUIN-ITM (WRK-KANRIIDX)
                                   TO  SPA-GMN-W21-BRM-TOKNYUIN
      *
           .
      *
       4100-BRM-TOKUTEINYUIN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    収容人数
      *****************************************************************
       4100-BRM-NINZU-CHK-SEC          SECTION.
      *
      *
           .
      *
       4100-BRM-NINZU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    室料差額
      *****************************************************************
       4100-BRM-SAGAKU-CHK-SEC         SECTION.
      *
           IF    ( SPA-GMN-W21-BRM-SAGAKU
                                    =   SPACE )
               GO  TO  4100-BRM-SAGAKU-CHK-EXT
           END-IF
      *
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W21-BRM-SAGAKU-CD
                                   TO  WRK-KBNCD
           PERFORM 800-BRM-SAGAKU-SRH-SEC
           IF    ( WRK-KANRIDAT1   =   SPACE )
               MOVE    7           TO  SPA-GMN-W21-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-BRM-SAGAKU-CHK-EXT
           END-IF
      *
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W21-BRM-SAGAKU
      *
           .
      *
       4100-BRM-SAGAKU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    性別特定
      *****************************************************************
       4100-BRM-SEX-CHK-SEC            SECTION.
      *
           IF    ( SPA-GMN-W21-BRM-SEX =   SPACE )
               GO  TO  4100-BRM-SEX-CHK-EXT
           END-IF
      *
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W21-BRM-SEX-CD
                                   TO  WRK-KBNCD
           PERFORM 800-BRM-SEX-SRH-SEC
           IF    ( WRK-KANRIDAT1   =   SPACE )
               MOVE    8           TO  SPA-GMN-W21-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-BRM-SEX-CHK-EXT
           END-IF
      *
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W21-BRM-SEX
      *
           .
      *
       4100-BRM-SEX-CHK-EXT.
           EXIT.
      *****************************************************************
      *    内線番号
      *****************************************************************
       4100-BRM-NAITEL-CHK-SEC         SECTION.
      *
           IF    ( SPA-GMN-W21-BRM-NAITEL  =   SPACE   )
               GO  TO  4100-BRM-NAITEL-CHK-EXT
           END-IF
      *
      *    全角半角混在チェック
           MOVE    SPA-GMN-W21-BRM-NAITEL
                                   TO  WRK-KANACHK-MAE-INPUT
      *
           PERFORM     800-ENRTRY-CHK-SEC
           IF  ( FLG-ENTRYCHK      NOT =   1 )
               MOVE    9               TO  SPA-GMN-W21-CUR
               MOVE    "0002"          TO  SPA-ERRCD
               GO  TO  4100-BRM-NAITEL-CHK-EXT
           END-IF
      *
           .
      *
       4100-BRM-NAITEL-CHK-EXT.
           EXIT.
      *****************************************************************
      *    診療科
      *****************************************************************
       4100-BRM-KA-CHK-SEC   SECTION.
      *
           IF    ( SPA-GMN-W21-BRM-KA  =   SPACE )
               GO  TO  4100-BRM-KA-CHK-EXT
           END-IF
      *
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W21-BRM-KA-CD
                                   TO  WRK-KBNCD
           PERFORM 800-BRM-KA-SRH-SEC
           IF    ( WRK-KANRIDAT1   =   SPACE )
               MOVE    10          TO  SPA-GMN-W21-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-BRM-KA-CHK-EXT
           END-IF
      *
           MOVE    WRK-KANRIDAT1   TO  SPA-GMN-W21-BRM-KA
      *
           .
      *
       4100-BRM-KA-CHK-EXT.
           EXIT.
      *****************************************************************
      *    有効期間開始日
      *****************************************************************
       4100-YUKOSTYMD-CHK-SEC          SECTION.
      *
           MOVE    SPA-NAI-W21-YUKOSTYMD
                                   TO  WRK-YUKOSTYMD
           MOVE    SPACE           TO  SPA-NAI-W21-YUKOSTYMD
      *
      *    日付妥当性チェック＆編集処理
           IF    ( SPA-GMN-W21-YUKOSTYMD   =   SPACE )
               MOVE    SPA-SYSYMDWH (1 : 6)
                                       TO  SPA-GMN-W21-YUKOSTYMD (1 : 6)
               MOVE    ". 1"           TO  SPA-GMN-W21-YUKOSTYMD (7 : 3)
               MOVE    SPA-SYSYMD   (1 : 6)
                                       TO  SPA-NAI-W21-YUKOSTYMD (1 : 6)
               MOVE    "01"            TO  SPA-NAI-W21-YUKOSTYMD (7 : 2)
      *
      *        システム管理情報再設定
               PERFORM 4100-SYS-KANRI-SAI-SET-SEC
               GO  TO  4100-YUKOSTYMD-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-W21-YUKOSTYMD
                                   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           IF  ( SPA-ERRCD         =   SPACE )
               MOVE    WRK-HENYMDG
                                   TO  SPA-GMN-W21-YUKOSTYMD
               MOVE    WRK-SYMD    TO  SPA-NAI-W21-YUKOSTYMD
           ELSE
               MOVE    WRK-YUKOSTYMD
                                   TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG
                                   TO  SPA-GMN-W21-YUKOSTYMD
               MOVE    WRK-SYMD    TO  SPA-NAI-W21-YUKOSTYMD
               MOVE    11          TO  SPA-GMN-W21-CUR
               GO  TO  4100-YUKOSTYMD-CHK-EXT
           END-IF
      *
           IF    ( SPA-NAI-W21-YUKOSTYMD   <   "20020401" )
               MOVE    "0003"      TO  SPA-ERRCD
               MOVE    "H14. 4. 1" TO  SPA-GMN-W21-YUKOSTYMD
               MOVE    "20020401"  TO  SPA-NAI-W21-YUKOSTYMD
               MOVE    11          TO  SPA-GMN-W21-CUR
               GO  TO  4100-YUKOSTYMD-CHK-EXT
           END-IF
      *
           IF    ( SPA-NAI-W21-YUKOSTYMD
                               NOT =   SPA-NAI-W21-YUKOSTYMD-MOT )
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
           MOVE    SPA-NAI-W21-YUKOEDYMD
                                   TO  WRK-YUKOEDYMD
           MOVE    SPACE           TO  SPA-NAI-W21-YUKOEDYMD
      *
      *    日付妥当性チェック＆編集処理
           IF    ( SPA-GMN-W21-YUKOEDYMD   =   SPACE )
               MOVE    "99999999"  TO  SPA-GMN-W21-YUKOEDYMD
                                       SPA-NAI-W21-YUKOEDYMD
               GO  TO  4100-YUKOEDYMD-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-W21-YUKOEDYMD
                                   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           IF  ( SPA-ERRCD         =   SPACE )
               MOVE    WRK-HENYMDG
                                   TO  SPA-GMN-W21-YUKOEDYMD
               MOVE    WRK-SYMD    TO  SPA-NAI-W21-YUKOEDYMD
           ELSE
               MOVE    WRK-YUKOEDYMD
                                   TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG
                                   TO  SPA-GMN-W21-YUKOEDYMD
               MOVE    WRK-SYMD    TO  SPA-NAI-W21-YUKOEDYMD
               MOVE    12          TO  SPA-GMN-W21-CUR
               GO  TO  4100-YUKOEDYMD-CHK-EXT
           END-IF
      *
           .
      *
       4100-YUKOEDYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    選択番号２
      *****************************************************************
       4100-SELNUM2-CHK-SEC            SECTION.
      *
           MOVE    W21-SELNUM2     TO  SPA-GMN-W21-SELNUM2
      *
           IF  (   SPA-GMN-W21-SELNUM2 =   ZERO )
               MOVE    3           TO  SPA-GMN-W21-CUR
               GO  TO  4100-SELNUM2-CHK-EXT
           END-IF
      *
      *    範囲内の番号が選択されていること
           IF    ( SPA-GMN-W21-SELNUM2 >   SPA-GMN-W21-RIREKILST-CNT )
               MOVE    100         TO  SPA-GMN-W21-CUR
               MOVE    "1008"      TO  SPA-ERRCD
               GO  TO  4100-SELNUM2-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-W21-SELNUM2 TO  SPA-GMN-W21-RIREKILST-SEL-NUM
      *
      *    入力項目領域編集処理
           MOVE    SPA-NAI-W21-RIREKILST-BRM-NUM
                                   TO  WRK-BRM-NUM
           MOVE    SPA-NAI-W21-TRYUKOSTYMD (SPA-GMN-W21-SELNUM2)
                                   TO  WRK-KIJUN-YMD
      *
      *    入力領域初期化
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
           PERFORM 4100-INPUT-AREA-EDIT-SEC
      *
           MOVE    SPA-NAI-W21-RIREKILST-SELNUM
                                   TO  SPA-GMN-W21-SELNUM1
           MOVE    W21-SELNUM2     TO  SPA-GMN-W21-SELNUM2
      *
           IF    ( SPA-GMN-W21-STATE   =   WIDGET-NORMAL )
               MOVE    3               TO  SPA-GMN-W21-CUR
           ELSE
               MOVE    100             TO  SPA-GMN-W21-CUR
           END-IF
           .
      *
       4100-SELNUM2-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病室リスト
      *****************************************************************
       4100-BRMLST-CHK-SEC             SECTION.
      *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL     ( IDX2    >   200 )
               IF      (   W21-BRMLST-SEL  (IDX2)  =   "T" )
      *
      *            入力項目領域編集処理
                   MOVE    SPA-GMN-W21-TBRM-NUM2 (IDX2)
                                           TO  WRK-BRM-NUM
                   MOVE    SPA-SYSYMD      TO  WRK-KIJUN-YMD
      *
      *            入力領域初期化
                   PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
      *            履歴領域初期化
                   PERFORM 4201-RIREKI-AREA-CLEAR-SEC
      *
      *            入力データ編集処理
                   MOVE    IDX2            TO  WRK-SELNUM
                   PERFORM 4100-INPUT-AREA-EDIT-SEC
      *
                   MOVE    IDX2    TO  SPA-GMN-W21-BRMLST-SEL-NUM
      *
      *            履歴データ編集処理
                   PERFORM 4100-RIREKI-AREA-EDIT-SEC
      *
                   MOVE    200     TO  IDX2
               END-IF
           END-PERFORM
      *
           MOVE    3               TO  SPA-GMN-W21-CUR
      *
           .
       4100-BRMLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    履歴リスト
      *****************************************************************
       4100-RIREKILST-CHK-SEC      SECTION.
      *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL     ( IDX2    >   20 )
               IF    ( W21-RIREKILST-SEL (IDX2)
                                       =   "T" )
      *
      *            入力項目領域編集処理
                   MOVE    SPA-NAI-W21-RIREKILST-BRM-NUM
                                       TO  WRK-BRM-NUM
                   MOVE    SPA-NAI-W21-TRYUKOSTYMD (IDX2)
                                       TO  WRK-KIJUN-YMD
      *
      *            入力領域初期化
                   PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
                   PERFORM 4100-INPUT-AREA-EDIT-SEC
                   IF    ( SPA-GMN-W21-STATE   =   WIDGET-NORMAL )
                       MOVE    3       TO  SPA-GMN-W21-CUR
                   ELSE
                       MOVE    100     TO  SPA-GMN-W21-CUR
                   END-IF
      *
                   MOVE    SPA-NAI-W21-RIREKILST-SELNUM
                                       TO  SPA-GMN-W21-SELNUM1
                   MOVE    IDX2        TO  SPA-GMN-W21-RIREKILST-SEL-NUM
                                               SPA-GMN-W21-SELNUM2
      *
                   MOVE    20          TO  IDX2
               END-IF
           END-PERFORM
      *
           .
       4100-RIREKILST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    ヘッダ情報初期化処理
      *****************************************************************
       4201-HEAD-AREA-CLEAR-SEC        SECTION.
      *
           INITIALIZE  SPA-GMN-W21-HEAD-AREA
      *
           .
      *
       4201-HEAD-AREA-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    入力情報領域初期化処理
      *****************************************************************
       4201-INPUT-AREA-CLEAR-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W21-INPUT-AREA
                       SPA-NAI-W21-INPUT-AREA
      *
           MOVE    WIDGET-NORMAL   TO  SPA-GMN-W21-STATE
      *
           IF    ( SPA-MOTOPG      =   "W01" )
               MOVE    "病棟"      TO  SPA-GMN-W21-B09
           END-IF
      *
           MOVE    WIDGET-NORMAL   TO  SPA-GMN-W21-B02-STATE
                                       SPA-GMN-W21-B05-STATE
                                       SPA-GMN-W21-B06-STATE
                                       SPA-GMN-W21-B07-STATE
                                       SPA-GMN-W21-B08-STATE
                                       SPA-GMN-W21-B09-STATE
                                       SPA-GMN-W21-B12-STATE
      *
           IF    ( SPA-GMN-W21-BRMLST-CNT  >=  200 )
               MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-W21-B06-STATE
           END-IF
      *
      *    有効期間の開始日と終了日を設定
           MOVE    SPA-SYSYMDWH (1 : 6)
                                   TO  SPA-GMN-W21-YUKOSTYMD (1 : 6)
           MOVE    ". 1"           TO  SPA-GMN-W21-YUKOSTYMD (7 : 3)
           MOVE    SPA-SYSYMD   (1 : 6)
                                   TO  SPA-NAI-W21-YUKOSTYMD (1 : 6)
           MOVE    "01"            TO  SPA-NAI-W21-YUKOSTYMD (7 : 2)
      *
           MOVE    "99999999"      TO  SPA-GMN-W21-YUKOEDYMD
                                       SPA-NAI-W21-YUKOEDYMD
      *
      *    システム管理情報再設定処理
           PERFORM 4100-SYS-KANRI-SAI-SET-SEC
      *
           MOVE    2               TO  SPA-GMN-W21-CUR
           .
      *
       4201-INPUT-AREA-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *   履歴情報領域初期化処理
      *****************************************************************
       4201-RIREKI-AREA-CLEAR-SEC      SECTION.
      *
           INITIALIZE  SPA-GMN-W21-RIREKILST-TBL
                       SPA-NAI-W21-RIREKILST-TBL
           MOVE    ZERO                TO  SPA-GMN-W21-BRMLST-SEL-NUM
           .
      *
       4201-RIREKI-AREA-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    システム管理情報再設定処理
      *****************************************************************
       4100-SYS-KANRI-SAI-SET-SEC         SECTION.
      *
      *    コンボ初期処理
           MOVE    SPA-NAI-W21-YUKOSTYMD
                                   TO  WRK-KJN-YUKSTYMD
           PERFORM 3101-CMB-SYOKI-SEC
      *
           MOVE    SPA-NAI-W21-YUKOSTYMD
                                   TO  SPA-NAI-W21-YUKOSTYMD-MOT
           .
      *
       4100-SYS-KANRI-SAI-SET-EXT.
           EXIT.
      *****************************************************************
      *    病室番号入力チェック
      *****************************************************************
       4900-BRM-NUM-INPUT-CHK-SEC      SECTION.
      *
      *    病室番号が入力されていること
           IF    ( SPA-GMN-W21-BRM-NUM     NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "1101"          TO  SPA-ERRCD
               MOVE   3                TO  SPA-GMN-W21-CUR
               GO  TO  4900-BRM-NUM-INPUT-CHK-EXT
           END-IF
      *
           .
       4900-BRM-NUM-INPUT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    共通関連チェック
      *****************************************************************
       4900-KANRENCHK-SEC              SECTION.
      *
      *    病室番号が入力されていること
           PERFORM 4900-BRM-NUM-INPUT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    有効期間開始日が入力されていること
           IF    ( SPA-NAI-W21-YUKOSTYMD NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "1102"      TO  SPA-ERRCD
               MOVE    11          TO  SPA-GMN-W21-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    有効期間終了日が入力されていること
           IF    ( SPA-NAI-W21-YUKOEDYMD NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "1103"      TO  SPA-ERRCD
               MOVE    12          TO  SPA-GMN-W21-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    有効期間開始日≦有効期間終了日となっていること
           IF    ( SPA-NAI-W21-YUKOSTYMD <=  SPA-NAI-W21-YUKOEDYMD )
               CONTINUE
           ELSE
               MOVE    "1004"      TO  SPA-ERRCD
               MOVE    11          TO  SPA-GMN-W21-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    有効期間終了日が過去日付でないこと
           IF    ( SPA-NAI-W21-YUKOEDYMD >=  SPA-SYSYMD  )
               CONTINUE
           ELSE
               MOVE    "1005"      TO  SPA-ERRCD
               MOVE    12          TO  SPA-GMN-W21-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    収容人数が１以上であること
           IF    ( SPA-GMN-W21-BRM-NINZU   >   0 )
               CONTINUE
           ELSE
               MOVE    "1009"      TO  SPA-ERRCD
               MOVE    6           TO  SPA-GMN-W21-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
           .
      *
       4900-KANRENCHK-EXT.
           EXIT.
      *****************************************************************
      *       病室番号検索処理
      *****************************************************************
       4100-BRM-NUM-LSTSEL-SEC         SECTION.
      *
           MOVE    "1"             TO  FLG-BRM-NUM
           MOVE    ZERO            TO  IDX-BRMLST
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-BRM-NUM =   ZERO )
                OR       ( IDX1    >   SPA-GMN-W21-BRMLST-CNT )
      *
               IF    ( SPA-GMN-W21-BRM-NUM
                                   =   SPA-GMN-W21-TBRM-NUM2 (IDX1) )
                   MOVE    ZERO    TO  FLG-BRM-NUM
                   MOVE    IDX1    TO  IDX-BRMLST
               END-IF
      *
           END-PERFORM
      *
           .
      *
       4100-BRM-NUM-LSTSEL-EXT.
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
           MOVE    "W21    "           TO  MCP-WINDOW.
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
      *    病棟ボタン
           MOVE    SPA-GMN-W21-B09         TO  W21-B09
      *
      *    病棟名称コンボ
           MOVE    SPA-GMN-W21-BTU-NAME    TO  W21-BTU-NAME
           MOVE    SPA-GMN-W21-BTU-NAME-CNT
                                       TO  W21-BTU-NAME-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W21-BTU-NAME-CNT )
                MOVE   SPA-GMN-W21-BTU-NAME-ITM (IDX1)
                                   TO  W21-BTU-NAME-ITM (IDX1)
           END-PERFORM
      *
      *    病棟入院基本料
           MOVE    SPA-GMN-W21-BTU-KHNRYO  TO  W21-BTU-KHNRYO
      *
      *    選択番号１
           MOVE    SPA-GMN-W21-SELNUM1     TO  W21-SELNUM1
      *
      *    病室番号
           MOVE    SPA-GMN-W21-BRM-NUM     TO  W21-BRM-NUM
      *
      *    病室種別コンボ
           MOVE    SPA-GMN-W21-BRM-SBT     TO  W21-BRM-SBT
           MOVE    SPA-GMN-W21-BRM-SBT-CNT TO  W21-BRM-SBT-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W21-BRM-SBT-CNT )
                MOVE   SPA-GMN-W21-BRM-SBT-ITM (IDX1)
                                   TO  W21-BRM-SBT-ITM (IDX1)
           END-PERFORM
      *
      *    特定入院料コンボ
           MOVE    SPA-GMN-W21-BRM-TOKNYUIN
                                       TO  W21-BRM-TOKUTEINYUIN
           MOVE    SPA-GMN-W21-BRM-TOKNYUIN-CNT
                                       TO  W21-BRM-TOKUTEINYUIN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W21-BRM-TOKUTEINYUIN-CNT )
                MOVE   SPA-GMN-W21-BRM-TOKNYUIN-ITM (IDX1)
                                   TO  W21-BRM-TOKUTEINYUIN-ITM (IDX1)
           END-PERFORM
      *
      *    収容人数
           MOVE    SPA-GMN-W21-BRM-NINZU   TO  W21-BRM-NINZU
      *
      *    室料差額コンボ
           MOVE    SPA-GMN-W21-BRM-SAGAKU  TO  W21-BRM-SAGAKU
           MOVE    SPA-GMN-W21-BRM-SAGAKU-CNT
                                       TO  W21-BRM-SAGAKU-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W21-BRM-SAGAKU-CNT )
                MOVE   SPA-GMN-W21-BRM-SAGAKU-ITM (IDX1)
                                   TO  W21-BRM-SAGAKU-ITM (IDX1)
           END-PERFORM
      *
      *    性別特定コンボ
           MOVE    SPA-GMN-W21-BRM-SEX     TO  W21-BRM-SEX
           MOVE    SPA-GMN-W21-BRM-SEX-CNT TO  W21-BRM-SEX-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W21-BRM-SEX-CNT )
                MOVE   SPA-GMN-W21-BRM-SEX-ITM (IDX1)
                                   TO  W21-BRM-SEX-ITM (IDX1)
           END-PERFORM
      *
      *    内線番号
           MOVE    SPA-GMN-W21-BRM-NAITEL  TO  W21-BRM-NAITEL
      *
      *    病室科名コンボ
           MOVE    SPA-GMN-W21-BRM-KA      TO  W21-BRM-KA
           MOVE    SPA-GMN-W21-BRM-KA-CNT  TO  W21-BRM-KA-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W21-BRM-KA-CNT )
                MOVE   SPA-GMN-W21-BRM-KA-ITM (IDX1)
                                   TO  W21-BRM-KA-ITM (IDX1)
           END-PERFORM
      *
      *    有効期間開始日
           MOVE    SPA-GMN-W21-YUKOSTYMD   TO  W21-YUKOSTYMD
      *
      *    有効期間終了日
           MOVE    SPA-GMN-W21-YUKOEDYMD   TO  W21-YUKOEDYMD
      *
      *    選択番号２
           MOVE    SPA-GMN-W21-SELNUM2     TO  W21-SELNUM2
      *
      *    病室リスト
           MOVE    SPACE               TO  W21-BRMLST-TBL
      *
           MOVE    SPA-GMN-W21-BRMLST-CNT  TO  W21-BRMLST-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W21-BRMLST-CNT )
      *
               MOVE    SPA-GMN-W21-TSELNUM  (IDX1)
                                       TO  WRK-ZZZ9
               MOVE    WRK-ZZZ9
                                       TO  W21-TSELNUM  (IDX1)
               STRING  "    "
                       SPA-GMN-W21-TBRM-NUM (IDX1)
                       DELIMITED   BY  SIZE
                       INTO  W21-TBRM-NUM (IDX1)
               END-STRING
      *
               MOVE    SPA-GMN-W21-TBRM-SBT (IDX1)
                                       TO  W21-TBRM-SBT (IDX1)
               MOVE    SPA-GMN-W21-TBRM-TOKNYUIN (IDX1)
                                       TO  W21-TBRM-TOKUTEINYUIN (IDX1)
               MOVE    SPA-GMN-W21-TBRM-NINZU (IDX1)
                                       TO  WRK-ZZZZZZZZZ9
               MOVE    WRK-ZZZZZZZZZ9
                                       TO  W21-TBRM-NINZU (IDX1)
               MOVE    SPA-GMN-W21-TBRM-SAGAKU (IDX1)
                                       TO  WRK-ZZZZZZZZZ9
               MOVE    WRK-ZZZZZZZZZ9
                                       TO  W21-TBRM-SAGAKU (IDX1)
               MOVE    SPA-GMN-W21-TBRM-SEX (IDX1)
                                       TO  W21-TBRM-SEX (IDX1)
               MOVE    SPA-GMN-W21-TBRM-NAITEL (IDX1)
                                       TO  W21-TBRM-NAITEL (IDX1)
               MOVE    SPA-GMN-W21-TBRM-KA (IDX1)
                                       TO  W21-TBRM-KA (IDX1)
               MOVE    SPA-GMN-W21-TYUKOSTYMD (IDX1)
                                       TO  W21-TYUKOSTYMD (IDX1)
               MOVE    SPA-GMN-W21-TYUKOEDYMD (IDX1)
                                       TO  W21-TYUKOEDYMD (IDX1)
      *
               IF    ( SPA-GMN-W21-BRMLST-SEL-NUM  =   IDX1 )
                   MOVE    "T"         TO  W21-BRMLST-SEL (IDX1)
               ELSE
                   MOVE    "F"         TO  W21-BRMLST-SEL (IDX1)
               END-IF
      *
           END-PERFORM
      *
      *    履歴リスト
           INITIALIZE                      W21-RIREKILST-TBL
           MOVE    SPA-GMN-W21-RIREKILST-CNT
                                       TO  W21-RIREKILST-CNT
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   SPA-GMN-W21-RIREKILST-CNT )
      *
               MOVE    SPA-GMN-W21-TRSELNUM (IDX1)
                                       TO  WRK-ZZZ9
               MOVE    WRK-ZZZ9        TO  W21-TRSELNUM (IDX1)
      *
               STRING  SPA-GMN-W21-TRYUKOSTYMD (IDX1)
                       " 〜 "
                       SPA-GMN-W21-TRYUKOEDYMD (IDX1)
                       DELIMITED   BY  SIZE
               INTO    W21-TRIREKI (IDX1)
               END-STRING
      *
               IF    ( IDX1    =   SPA-GMN-W21-RIREKILST-SEL-NUM )
                   MOVE    "T"         TO  W21-RIREKILST-SEL (IDX1)
               ELSE
                   MOVE    "F"         TO  W21-RIREKILST-SEL (IDX1)
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
           MOVE    SPA-GMN-W21-B02-STATE   TO  W21-B02-STATE
      *
      *    棟歴ボタン
           MOVE    SPA-GMN-W21-B05-STATE   TO  W21-B05-STATE
      *
      *    追加ボタン
           MOVE    SPA-GMN-W21-B06-STATE   TO  W21-B06-STATE
      *
      *    変更ボタン
           MOVE    SPA-GMN-W21-B07-STATE   TO  W21-B07-STATE
      *
      *    削除ボタン
           MOVE    SPA-GMN-W21-B08-STATE   TO  W21-B08-STATE
      *
      *    病室ボタン
           MOVE    SPA-GMN-W21-B09-STATE   TO  W21-B09-STATE
      *
      *    登録ボタン
           MOVE    SPA-GMN-W21-B12-STATE   TO  W21-B12-STATE
      *
           MOVE    SPA-GMN-W21-STATE
                                       TO  W21-BRM-NUM-STT
                                           W21-BRM-SBT-STT
                                           W21-BRM-SBT-ITM-STT
                                           W21-BRM-TOKUTEINYUIN-STT
                                           W21-BRM-TOKUTEINYUIN-ITM-STT
                                           W21-BRM-NINZU-STT
                                           W21-BRM-SAGAKU-STT
                                           W21-BRM-SAGAKU-ITM-STT
                                           W21-BRM-SEX-STT
                                           W21-BRM-SEX-ITM-STT
                                           W21-BRM-NAITEL-STT
                                           W21-BRM-KA-STT
                                           W21-BRM-KA-ITM-STT
                                           W21-YUKOSTYMD-STT
                                           W21-YUKOEDYMD-STT
      *
           IF    ( SPA-GMN-W21-STATE       =   WIDGET-INSENSITIVE )
               MOVE    WIDGET-INSENSITIVE
                                       TO  W21-B06-STATE
                                           W21-B07-STATE
                                           W21-B08-STATE
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
                  (SPA-GMN-W21-CUR     =   ZERO )
               PERFORM 5011-INPUT-CUR-SEC
           END-IF
      *
           IF    ( SPA-GMN-W21-STATE   =   WIDGET-INSENSITIVE )
               MOVE  "SELNUM2"         TO   MCP-WIDGET
               GO  TO  5001-MAPCUR-EXT
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   1 )
               MOVE  "BTU_NAME"        TO   MCP-WIDGET
               GO  TO  5001-MAPCUR-EXT
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   2 )
               MOVE  "SELNUM1"         TO   MCP-WIDGET
               GO  TO  5001-MAPCUR-EXT
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   3 )
               IF    ( W21-BRM-NUM-STT =    WIDGET-NORMAL )
                   MOVE  "BRM_NUM"         TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W21-CUR =   SPA-GMN-W21-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   4 )
               IF    ( W21-BRM-SBT-ITM-STT
                                       =    WIDGET-NORMAL )
                   MOVE  "BRM_SBT"         TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W21-CUR =   SPA-GMN-W21-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   5 )
               IF    ( W21-BRM-TOKUTEINYUIN-STT
                                       =    WIDGET-NORMAL )
                   MOVE  "BRM_TOKUTEINYUIN"
                                       TO   MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W21-CUR =   SPA-GMN-W21-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   6 )
               IF    ( W21-BRM-NINZU-STT
                                       =    WIDGET-NORMAL )
                   MOVE  "BRM_NINZU"
                                       TO   MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W21-CUR =   SPA-GMN-W21-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   7 )
               IF    ( W21-BRM-SAGAKU-STT
                                       =    WIDGET-NORMAL )
                   MOVE  "BRM_SAGAKU"
                                       TO   MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W21-CUR =   SPA-GMN-W21-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   8 )
               IF    ( W21-BRM-SEX-STT
                                       =    WIDGET-NORMAL )
                   MOVE  "BRM_SEX"
                                       TO   MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W21-CUR =   SPA-GMN-W21-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   9 )
               IF    ( W21-BRM-NAITEL-STT
                                       =    WIDGET-NORMAL )
                   MOVE  "BRM_NAITEL"  TO   MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W21-CUR =   SPA-GMN-W21-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   10 )
               IF    ( W21-BRM-KA-STT
                                       =    WIDGET-NORMAL )
                   MOVE  "BRM_KA"      TO   MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W21-CUR =   SPA-GMN-W21-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   11 )
               IF    ( W21-YUKOSTYMD-STT
                                       =    WIDGET-NORMAL )
                   MOVE  "YUKOSTYMD"   TO   MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-W21-CUR =   SPA-GMN-W21-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   12 )
               IF    ( W21-YUKOEDYMD-STT
                                       =    WIDGET-NORMAL )
                   MOVE  "YUKOEDYMD"   TO   MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   MOVE    206         TO   SPA-GMN-W21-CUR
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   100 )
               MOVE  "SELNUM2"         TO   MCP-WIDGET
               GO  TO  5001-MAPCUR-EXT
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   206 )
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
           EVALUATE    MCP-WIDGET
           WHEN    "BTU_NAME"
               MOVE    001             TO  SPA-GMN-W21-CUR
           WHEN    "SELNUM1"
               MOVE    002             TO  SPA-GMN-W21-CUR
           WHEN    "BRM_NUM"
               MOVE    003             TO  SPA-GMN-W21-CUR
           WHEN    "BRM_SBT"
               MOVE    004             TO  SPA-GMN-W21-CUR
           WHEN    "BRM_TOKUTEINYUIN"
               MOVE    005             TO  SPA-GMN-W21-CUR
           WHEN    "BRM_NINZU"
               MOVE    006             TO  SPA-GMN-W21-CUR
           WHEN    "BRM_SAGAKU"
               MOVE    007             TO  SPA-GMN-W21-CUR
           WHEN    "BRM_SEX"
               MOVE    008             TO  SPA-GMN-W21-CUR
           WHEN    "BRM_NAITEL"
               MOVE    009             TO  SPA-GMN-W21-CUR
           WHEN    "BRM_KA"
               MOVE    010             TO  SPA-GMN-W21-CUR
           WHEN    "YUKOSTYMD"
               MOVE    011             TO  SPA-GMN-W21-CUR
           WHEN    "YUKOEDYMD"
               MOVE    012             TO  SPA-GMN-W21-CUR
           WHEN    "SELNUM2"
               MOVE    013             TO  SPA-GMN-W21-CUR
           END-EVALUATE
      *
      *    次カーソル位置を設定
           EVALUATE    MCP-WIDGET
           WHEN    "SELNUM2"
               MOVE    003             TO  SPA-GMN-W21-CUR
           WHEN    "YUKOEDYMD"
               MOVE    206             TO  SPA-GMN-W21-CUR
           WHEN    OTHER
               COMPUTE SPA-GMN-W21-CUR =   SPA-GMN-W21-CUR
                                           +   1
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
           WHEN    "0001"
                   MOVE    "入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0002"
               MOVE    "半角文字でのみ入力してください"
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
               MOVE    "病棟名称を選択して下さい"
                                       TO  SPA-ERRMSG
           WHEN    "1007"
               MOVE    "入力番号に該当する病棟は存在しません"
                                       TO  SPA-ERRMSG
           WHEN    "1008"
               MOVE    "範囲内の選択番号を入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "1009"
               MOVE    "収容人数に１以上を入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "1101"
               MOVE     "病室番号を入力してください"
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
               MOVE    "病室を選択してください"
                                       TO  SPA-ERRMSG
           WHEN    "1106"
               MOVE    "病室番号の変更はできません"
                                       TO  SPA-ERRMSG
           WHEN    "1107"
               MOVE    "有効期間の開始日と終了日は同時に変更できません"
                                       TO  SPA-ERRMSG
           WHEN    "1108"
               MOVE    "入院中の患者が存在するため削除できません"
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
           END-EVALUATE
      *
           MOVE    SPA-MOTOPG          TO  SPA-GMN-W21-MOTOPG
      *
           MOVE    SPACE               TO  WERR
           MOVE    SPA-ERRCD           TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  WERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "W21"               TO  SPA-MOTOPG
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
               MOVE    "該当の病室を削除します。よろしいですか"
                                        TO  WRK-WIDMSG
           END-EVALUATE
      *
      *
           MOVE    SPA-MOTOPG           TO  SPA-GMN-W21-MOTOPG
      *
           MOVE    SPACE                TO  WID1
           MOVE    SPA-WIDCD            TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG           TO  WID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "W21"                TO  SPA-MOTOPG
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
      *    病棟情報サーチ処理
      *****************************************************************
       800-BTU-JOHO-SRH-SEC            SECTION.
      *
           SET     CMB-IDX21   TO  1
           SEARCH  SPA-GMN-W21-BTU-NAME-ITM-OCC
                                   VARYING CMB-IDX21
           AT  END
               INITIALIZE          WRK-KANRI-AREA
           WHEN    SPA-GMN-W21-BTU-NAME-ITM (CMB-IDX21) (1 : 2)
                                   =   WRK-KBNCD
               SET WRK-KANRIIDX    TO  CMB-IDX21
               MOVE    SPA-GMN-W21-BTU-NAME-ITM (CMB-IDX21)
                               TO  WRK-KANRIDAT1
               MOVE    SPA-GMN-W21-BTU-NAME-ITM2 (CMB-IDX21)
                               TO  WRK-KANRIDAT2
               MOVE    SPA-GMN-W21-BTU-NAME-ITM3 (CMB-IDX21)
                               TO  WRK-KANRIDAT3
               MOVE    SPA-GMN-W21-BTU-NAME-ITM4 (CMB-IDX21)
                               TO  WRK-KANRIDAT4
           WHEN    SPA-GMN-W21-BTU-NAME-ITM (CMB-IDX21) (1 : 2)
                                   =   SPACE
               INITIALIZE          WRK-KANRI-AREA
           END-SEARCH
      *
           .
       800-BTU-JOHO-SRH-EXT.
           EXIT.
      *****************************************************************
      *    診療科コードサーチ処理
      *****************************************************************
       800-BRM-KA-SRH-SEC                  SECTION.
      *
           SET     CMB-IDX26   TO  1
           SEARCH  SPA-GMN-W21-BRM-KA-ITM  VARYING CMB-IDX26
           AT  END
               INITIALIZE          WRK-KANRI-AREA
           WHEN    SPA-GMN-W21-BRM-KA-ITM (CMB-IDX26) (1 : 2)
                                   =   WRK-KBNCD
               SET WRK-KANRIIDX    TO  CMB-IDX26
               MOVE    SPA-GMN-W21-BRM-KA-ITM (CMB-IDX26)
                               TO  WRK-KANRIDAT1
           WHEN    SPA-GMN-W21-BRM-KA-ITM (CMB-IDX26) (1 : 2)
                                   =   SPACE
               INITIALIZE          WRK-KANRI-AREA
           END-SEARCH
      *
           .
       800-BRM-KA-SRH-EXT.
           EXIT.
      *****************************************************************
      *    病室種別サーチ処理
      *****************************************************************
       800-BRM-SBT-SRH-SEC                 SECTION.
      *
           SET     CMB-IDX22   TO  1
           SEARCH  SPA-GMN-W21-BRM-SBT-ITM
                                   VARYING CMB-IDX22
           AT  END
               INITIALIZE          WRK-KANRI-AREA
           WHEN    SPA-GMN-W21-BRM-SBT-ITM (CMB-IDX22) (1 : 2)
                                   =   WRK-KBNCD
               SET WRK-KANRIIDX    TO  CMB-IDX22
               MOVE    SPA-GMN-W21-BRM-SBT-ITM (CMB-IDX22)
                               TO  WRK-KANRIDAT1
           WHEN    SPA-GMN-W21-BRM-SBT-ITM (CMB-IDX22) (1 : 2)
                                   =   SPACE
               INITIALIZE          WRK-KANRI-AREA
           END-SEARCH
      *
           .
       800-BRM-SBT-SRH-EXT.
           EXIT.
      *****************************************************************
      *    特定入院料サーチ処理
      *****************************************************************
       800-BRM-TOKUTEINYUIN-SRH-SEC    SECTION.
      *
           SET     CMB-IDX23   TO  1
           SEARCH  SPA-GMN-W21-BRM-TOKNYUIN-ITM-OCC
                                       VARYING CMB-IDX23
           AT  END
               INITIALIZE          WRK-KANRI-AREA
           WHEN    SPA-GMN-W21-BRM-TOKNYUIN-ITM (CMB-IDX23) (1 : 2)
                                           =   WRK-KBNCD
               SET WRK-KANRIIDX    TO  CMB-IDX23
               MOVE    SPA-GMN-W21-BRM-TOKNYUIN-ITM (CMB-IDX23)
                               TO  WRK-KANRIDAT1
               MOVE    SPA-GMN-W21-BRM-TOKNYUIN-ITM2(CMB-IDX23)
                               TO  WRK-KANRIDAT2
           WHEN    SPA-GMN-W21-BRM-TOKNYUIN-ITM (CMB-IDX23) (1 : 2)
                                           =   SPACE
               INITIALIZE          WRK-KANRI-AREA
           END-SEARCH
      *
           .
       800-BRM-TOKUTEINYUIN-SRH-EXT.
           EXIT.
      *****************************************************************
      *    室料差額サーチ処理
      *****************************************************************
       800-BRM-SAGAKU-SRH-SEC          SECTION.
      *
           SET     CMB-IDX24   TO  1
           SEARCH  SPA-GMN-W21-BRM-SAGAKU-ITM
                                       VARYING CMB-IDX24
           AT  END
               INITIALIZE          WRK-KANRI-AREA
           WHEN    SPA-GMN-W21-BRM-SAGAKU-ITM (CMB-IDX24) (1 : 2)
                                       =   WRK-KBNCD
               SET WRK-KANRIIDX    TO  CMB-IDX24
               MOVE    SPA-GMN-W21-BRM-SAGAKU-ITM (CMB-IDX24)
                               TO  WRK-KANRIDAT1
           WHEN    SPA-GMN-W21-BRM-SAGAKU-ITM (CMB-IDX24) (1 : 2)
                                       =   SPACE
               INITIALIZE          WRK-KANRI-AREA
           END-SEARCH
      *
           .
       800-BRM-SAGAKU-SRH-EXT.
           EXIT.
      *****************************************************************
      *    性別特定サーチ処理
      *****************************************************************
       800-BRM-SEX-SRH-SEC         SECTION.
      *
           SET     CMB-IDX25   TO  1
           SEARCH  SPA-GMN-W21-BRM-SEX-ITM VARYING CMB-IDX25
           AT  END
               INITIALIZE          WRK-KANRI-AREA
           WHEN    SPA-GMN-W21-BRM-SEX-ITM (CMB-IDX25) (1 : 1)
                                   =   WRK-KBNCD
               SET WRK-KANRIIDX    TO  CMB-IDX25
               MOVE    SPA-GMN-W21-BRM-SEX-ITM (CMB-IDX25)
                               TO  WRK-KANRIDAT1
           WHEN    SPA-GMN-W21-BRM-SEX-ITM (CMB-IDX25) (1 : 1)
                                   =   SPACE
               INITIALIZE          WRK-KANRI-AREA
           END-SEARCH
      *
           .
       800-BRM-SEX-SRH-EXT.
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
               MOVE    9           TO  FLG-ENTRYCHK
               GO  TO  800-ENRTRY-CHK-EXT
           END-IF
      *
           MOVE    KANACHK-SYUBETU TO  FLG-ENTRYCHK
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

