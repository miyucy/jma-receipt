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
      *
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCGI02.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院業務
      *  コンポーネント名  : 入院歴表示
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02.09.19    NACL-太田     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-太田    03.02.05  自院歴作成データを考慮する
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *
      *    画面非表示
           COPY    "ENUM-VALUE".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    入退院登録共通領域
           COPY    "I0COMMON-SPA".
      *
      *    画面用ＳＰＡ
           COPY    "I0SCR-SPA".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                     PIC 9(01).
           03  FLG-ERR                     PIC 9(01).
           03  FLG-DBRC                    PIC 9(01).
           03  FLG-ENTRYCHK                PIC 9(01).
           03  FLG-PTNYUINRRK              PIC 9(01).
           03  FLG-SYSKANRI                PIC 9(01).
           03  FLG-TAIN                    PIC 9(01).
           03  FLG-TAINFUKA                PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                        PIC 9(05).
           03  IDX2                        PIC 9(05).
           03  IDX3                        PIC 9(05).
           03  IDX4                        PIC 9(05).
           03  IDX5                        PIC 9(05).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD     PIC X(08).
           03  SYS-TIME    PIC X(06).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-MOTOPG                  PIC X(08).
           03  WRK-YMD                     PIC X(10). 
           03  WRK-SYMD.
               05  WRK-SYY                 PIC 9(04).
               05  WRK-SMM                 PIC 9(02).
               05  WRK-SDD                 PIC 9(02).
           03  WRK-HENYMDG                 PIC X(09).
           03  WRK-KANACHK-MAE-INPUT       PIC X(400).
           03  WRK-KBNCD                   PIC X(02).
           03  WRK-SRYKANAME               PIC X(20).
           03  WRK-BTUNAME                 PIC X(20).
           03  WRK-BRMNUM                  PIC X(06).
           03  WRK-DR                      PIC X(24).
           03  WRK-999999                  PIC 999999.
           03  WRK-ZZZZZ9                  PIC ZZZZZ9.
           03  WRK-ZZZZ9                   PIC ZZZZ9.
           03  WRK-DBPATH                  PIC X(20).
           03  WRK-STYMD                   PIC X(08).
           03  WRK-EDYMD                   PIC X(08).
           03  WRK-NISSU1                  PIC 9(05).
           03  WRK-NISSU2                  PIC 9(05).
           03  WRK-TUSAN                   PIC 9(05).
           03  WRK-NYUINYMD                PIC X(08).
           03  WRK-TAIINYMD                PIC X(08).
           03  WRK-COMBO.
               05  WRK-CMB-CD              PIC X(05).
               05  WRK-CMB-IDX             PIC 9(03).
               05  WRK-CMB-ITM             PIC X(100).
           03  WRK-KEY-AREA.
               05  WRK-KEY-BTUNUM          PIC X(02).
               05  WRK-KEY-BRMNUM          PIC X(08).
               05  WRK-KEY-NYUINKA         PIC X(02).
               05  WRK-KEY-TOKUTEI-KBN     PIC X(01).
               05  WRK-KEY-TOKUTEI-NYUIN   PIC X(02).
               05  WRK-KEY-HKNCOMBINUM     PIC X(04).
           03  WRK-BIKO-ITEM-AREA.
               05  WRK-BIKO-YMD            PIC X(10).
               05  WRK-BIKO-ITEM-CNT       PIC 9(03).
               05  WRK-BIKO-ITEM-OCC       OCCURS  4.
                   07  WRK-BIKO-ITEM-KBN   PIC 9(01).
                   07  WRK-BIKO-ITEM       PIC X(10).
               05  WRK-BIKO-NAIYO          PIC X(100).
               05  WRK-BIKO-PNT            PIC 9(03).
               05  WRK-BIKO-IDX            PIC 9(03).
           03  WRK-NYUINRRK-EDIT-MAX       PIC 9(05).
           03  WRK-IDO-CNT                 PIC 9(05).
           03  WRK-ST-IDX                  PIC 9(05).
      *
       01  CONST-AREA.
           03  CONST-BIKO-VAL.
               05                  PIC X(20)   VALUE "入院科".
               05                  PIC X(20)   VALUE "科".
      *
               05                  PIC X(20)   VALUE "病室".
               05                  PIC X(20)   VALUE "室".
      *
               05                  PIC X(20)   VALUE "入院料".
               05                  PIC X(20)   VALUE "入".
      *
               05                  PIC X(20)   VALUE "保険組合せ".
               05                  PIC X(20)   VALUE "保".
      *
           03  CONST-BIKO-R  REDEFINES CONST-BIKO-VAL.
               05    CONST-BIKO-OCC1        OCCURS  4.
                   07    CONST-BIKO-OCC2    OCCURS  2.
                       09  CONST-BIKO      PIC  X(20).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *    （診療科入院科情報）
           COPY    "CPSK1005.INC".
      *    （職員情報）
           COPY    "CPSK1010.INC".
      *    （病棟情報）
           COPY    "CPSK5001.INC".
      *    （病室情報）
           COPY    "CPSK5002.INC".
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *    患者病名
       01  PTBYOMEI-REC.
           COPY    "CPPTBYOMEI.INC".
      *
      *    他院歴付加情報
       01  PTTAINFUKA-REC.
           COPY    "CPPTTAINFUKA.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
           COPY    "CPORCSGDAY.INC".
      *
      *    数値号変換サブ
           COPY    "CPORCSNUM.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
      *
        LINKAGE                     SECTION.
      *
      *     テーブルアクセス
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "I01.INC".
           COPY    "I02.INC".
           COPY    "I03.INC".
           COPY    "I04.INC".
           COPY    "I0ERR.INC".
           COPY    "I0ID1.INC".
           COPY    "I0ID2.INC".
      *
      *
       PROCEDURE                   DIVISION    USING
                                               MCPAREA
                                               SPAAREA
                                               LINKAREA
                                               SCRAREA.
      *****************************************************************
      *    主    処    理
      *****************************************************************
      *
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA.
           MOVE    SPA-FREE        TO  SPA-I0FREE.
           MOVE    SPA-WORK        TO  SPA-I0KYOUTU
      *
           MOVE    SPACE           TO  SPA-ERRCD.
           MOVE    ZERO            TO  FLG-END.
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN    "PUTG"          ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF  FLG-END   =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF.
      *
           MOVE    SPA-I0KYOUTU    TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON.
           MOVE    SPA-I0FREE      TO  SPA-FREE
           .
      *
       000-PROC-SEC-EXT.
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                   SECTION.
      *
      *    エラー画面より
           IF    ( SPA-MOTOPG          =   "I0ERR" )
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
           MOVE    "I02"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
      *
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
               MOVE    SPA-MOTOPG          TO  WRK-MOTOPG
      *
           END-IF
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
           INITIALIZE              I02
                                   SPA-I02
      *
      *    最新入院歴検索処理
           PERFORM 3101-NEW-NYUINRRK-SEL-SEC
           IF    ( FLG-PTNYUINRRK      NOT =   ZERO )
               GO  TO  310-SPASET-EXT
           END-IF
      *
           MOVE    ZERO    TO  FLG-TAIN
      *
      *    最新入院歴編集処理
           PERFORM 3101-NEW-NYUINRRK-EDIT-SEC
      *
      *    入院歴リスト編集処理
           PERFORM 3101-NYUINRRKLST-EDIT-SEC
      *
      *    コンボボックス初期化
           PERFORM 310-CMB-SYOKI-SEC
      *
           MOVE    SPA-GMN-I02-NYUGAI-ITM (01)
                                       TO  SPA-GMN-I02-NYUGAI
      *
           IF    ( FLG-TAIN    =   ZERO )
               MOVE    ZERO    TO  SPA-NAI-I02-NYURRK-FLG
      *        病名リスト編集処理
               PERFORM 3101-BYOMEILST-EDIT-SEC
               MOVE    WIDGET-NORMAL   TO  SPA-GMN-I02-NYUGAI-STT
                                           SPA-GMN-I02-NYUGAI-ITM-STT
           ELSE
               MOVE    1       TO  SPA-NAI-I02-NYURRK-FLG
               MOVE    SPACE   TO  SPA-GMN-I02-NYUGAI
      *
               PERFORM 3101-TAINFUKA-SEL-SEC
               IF    ( FLG-TAINFUKA    =   ZERO )
      *
      *            入院料算定
                   MOVE    PTTAINFUKA-KHNRYO
                                       TO  SPA-GMN-I02-SANTEI
      *
      *            病名リスト編集処理
                   PERFORM 3101-BYOMEILST-EDIT2-SEC
               END-IF
      *
               MOVE    WIDGET-INSENSITIVE
                                       TO  SPA-GMN-I02-NYUGAI-STT
                                           SPA-GMN-I02-NYUGAI-ITM-STT
           END-IF
      *
           MOVE    1                   TO  SPA-GMN-I02-CUR
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    最新入院歴検索処理
      *****************************************************************
       3101-NEW-NYUINRRK-SEL-SEC       SECTION.
      *
      *    入院履歴検索処理
           MOVE    ZERO            TO  FLG-PTNYUINRRK
           INITIALIZE  PTNYUINRRK-REC
      *
           MOVE    SPA-HOSPID      TO  PTNYUINRRK-HOSPID
           MOVE    SPA-I01-I02-PTID
                                   TO  PTNYUINRRK-PTID
           MOVE    SPA-I01-I02-PTRRKNUM
                                   TO  PTNYUINRRK-RRKNUM
      *
           MOVE    PTNYUINRRK-REC  TO  MCPDATA-REC
           MOVE    "PTNYUINRRK-KEY4"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    NOT =   ZERO )
               MOVE    1           TO  FLG-PTNYUINRRK
           ELSE
               MOVE    MCPDATA-REC TO  PTNYUINRRK-REC
           END-IF
      *
      *    入院履歴クローズ
           MOVE    "PTNYUINRRK-KEY4"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       3101-NEW-NYUINRRK-SEL-EXT.
           EXIT.
      *****************************************************************
      *    最新入院歴編集処理
      *****************************************************************
       3101-NEW-NYUINRRK-EDIT-SEC      SECTION.
      *
           IF    ( PTNYUINRRK-JTIKBN   =   "5" OR "6" )
               MOVE    1           TO  FLG-TAIN
           ELSE
               MOVE    ZERO        TO  FLG-TAIN
           END-IF
      *
      *    初回
           EVALUATE    PTNYUINRRK-SHOKAIKBN
           WHEN    "1"
               MOVE    "初回"      TO  SPA-GMN-I02-SHOKAI
           WHEN    "2"
               MOVE    "継続"      TO  SPA-GMN-I02-SHOKAI
           END-EVALUATE
      *
      *    状態
           EVALUATE    TRUE
           WHEN    PTNYUINRRK-JTIKBN   =   "5"
               MOVE    "他院歴"    TO  SPA-GMN-I02-JYOTAI
           WHEN    PTNYUINRRK-JTIKBN   =   "6"
               MOVE    "自院入院歴"
                                   TO  SPA-GMN-I02-JYOTAI
           WHEN    PTNYUINRRK-TAIINYMD =   "99999999"
               MOVE    "入院中"    TO  SPA-GMN-I02-JYOTAI
           WHEN    OTHER
               MOVE    "退院済み"  TO  SPA-GMN-I02-JYOTAI
           END-EVALUATE
      *
      *    病棟名
           IF    ( PTNYUINRRK-JTIKBN   =   "5" OR "6" )
               MOVE    PTNYUINRRK-BTUNAME
                                       TO  SPA-GMN-I02-BTUNAME
           ELSE
               PERFORM 3101-S5001-SEL-SEC
               MOVE    WRK-BTUNAME     TO  SPA-GMN-I02-BTUNAME
           END-IF
      *
      *    病室番号
           PERFORM 3101-BRMNUM-EDIT-SEC
           MOVE    WRK-BRMNUM      TO  SPA-GMN-I02-BRMNUM
      *
      *    入院日
           MOVE    PTNYUINRRK-NYUINYMD
                                   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-I02-NYUINYMD
           MOVE    PTNYUINRRK-NYUINYMD
                                   TO  SPA-NAI-I02-NYUINYMD
      *
      *    退院日
           IF    ( PTNYUINRRK-TAIINYMD     =   "99999999" )
               MOVE    SPACE       TO  SPA-GMN-I02-TAIINYMD
                                       SPA-NAI-I02-TAIINYMD
           ELSE
               MOVE    PTNYUINRRK-TAIINYMD
                                   TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG TO  SPA-GMN-I02-TAIINYMD
               MOVE    PTNYUINRRK-TAIINYMD
                                   TO  SPA-NAI-I02-TAIINYMD
           END-IF
      *
      *    入院科
           MOVE    PTNYUINRRK-NYUINKA
                                   TO  WRK-KBNCD
           PERFORM 3101-S1005-SEL-SEC
           MOVE    WRK-SRYKANAME   TO  SPA-GMN-I02-NYUINKA
      *
      *    主治医
           PERFORM 3101-S1010-SEL-SEC
           MOVE    WRK-DR          TO  SPA-GMN-I02-DR
      *
           .
       3101-NEW-NYUINRRK-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病棟情報検索処理
      *****************************************************************
       3101-S5001-SEL-SEC              SECTION.
      *
           MOVE    SPACE           TO  WRK-BTUNAME
      *
           INITIALIZE              SYSKANRI-REC
           MOVE    "5001"          TO  SYS-KANRICD
           MOVE    PTNYUINRRK-BTUNUM
                                   TO  SYS-KBNCD
           MOVE    PTNYUINRRK-TENNYUYMD
                                   TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *
      *    システム管理マスタ検索処理
           MOVE    "SYSKANRI-KEY10"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-5001-REC
               MOVE    SYS-5001-BTU-NAME
                                   TO  WRK-BTUNAME
           END-IF
      *
      *    システム管理マスタクローズ処理
           MOVE    "SYSKANRI-KEY10"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
      *
       3101-S5001-SEL-EXT.
           EXIT.
      *****************************************************************
      *    病室番号編集処理
      *****************************************************************
       3101-BRMNUM-EDIT-SEC            SECTION.
      *
           MOVE    SPACE           TO  WRK-BRMNUM
      *
           IF    ( PTNYUINRRK-BRMNUM (3 : 6)
                                   IS  NUMERIC )
               MOVE    PTNYUINRRK-BRMNUM (3 : 6)
                                   TO  WRK-999999
               MOVE    WRK-999999
                                   TO  WRK-ZZZZZ9
               MOVE    WRK-ZZZZZ9
                                   TO  WRK-BRMNUM
           ELSE
               MOVE    PTNYUINRRK-BRMNUM (3 : 6)
                                   TO  WRK-BRMNUM
           END-IF
      *
           .
       3101-BRMNUM-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    診療科入院科情報検索処理
      *****************************************************************
       3101-S1005-SEL-SEC              SECTION.
      *
           MOVE    SPACE           TO  WRK-SRYKANAME
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "1005"          TO  SYS-KANRICD
           MOVE    WRK-KBNCD       TO  SYS-KBNCD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY10"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-1005-REC
               MOVE    SYS-1005-SRYKANAME
                                   TO  WRK-SRYKANAME
           END-IF
      *
           MOVE    "SYSKANRI-KEY10"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
           .
      *
       3101-S1005-SEL-EXT.
           EXIT.
      *****************************************************************
      *    職員情報検索処理
      *****************************************************************
       3101-S1010-SEL-SEC              SECTION.
      *
           MOVE    SPACE           TO  WRK-DR
      *
           INITIALIZE              SYSKANRI-REC
           MOVE    "1010"          TO  SYS-KANRICD
           MOVE    "1"             TO  SYS-KBNCD (1 : 1)
           MOVE    PTNYUINRRK-DRCD1 ( 2 : 4 )
                                   TO  SYS-KBNCD (2 : )
           MOVE    PTNYUINRRK-TENNYUYMD
                                   TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *
      *    システム管理マスタ検索処理
           MOVE    "SYSKANRI-KEY10"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-1010-REC
               MOVE    SYS-1010-NAME
                                   TO  WRK-DR
           END-IF
      *
      *    システム管理マスタクローズ処理
           MOVE    "SYSKANRI-KEY10"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
      *
       3101-S1010-SEL-EXT.
           EXIT.
      *****************************************************************
      *    他院付加情報検索処理
      *****************************************************************
       3101-TAINFUKA-SEL-SEC           SECTION.
      * 
      *
      *    他院付加情報検索処理
           INITIALIZE  PTTAINFUKA-REC
           MOVE    SPA-HOSPID      TO  PTTAINFUKA-HOSPID
           MOVE    SPA-I01-I02-PTID
                                   TO  PTTAINFUKA-PTID
           MOVE    SPA-I01-I02-PTRRKNUM
                                   TO  PTTAINFUKA-RRKNUM
           MOVE    PTTAINFUKA-REC  TO  MCPDATA-REC
           MOVE    "PTTAINFUKA-KEY"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        =   ZERO )
               MOVE    MCPDATA-REC TO  PTTAINFUKA-REC
           ELSE
               MOVE    1           TO  FLG-TAINFUKA
           END-IF
      *
           MOVE    "PTTAINFUKA-KEY"
                                       TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      * 
           .
      *
       3101-TAINFUKA-SEL-EXT.
           EXIT.
      *****************************************************************
      *    入院歴リスト編集処理
      *****************************************************************
       3101-NYUINRRKLST-EDIT-SEC       SECTION.
      *
           MOVE    ZERO            TO  WRK-NYUINRRK-EDIT-MAX
      *
      *    入院履歴検索
           INITIALIZE  PTNYUINRRK-REC
      *
           MOVE    SPA-HOSPID      TO  PTNYUINRRK-HOSPID
           MOVE    SPA-I01-I02-PTID
                                   TO  PTNYUINRRK-PTID
           MOVE    SPA-I01-I02-PTRRKNUM
                                   TO  PTNYUINRRK-RRKNUM
      *
           MOVE    PTNYUINRRK-REC  TO  MCPDATA-REC
           MOVE    "PTNYUINRRK-KEY5"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           PERFORM 3101-NYUINRRK-KEY-EDIT-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >       100 )
                OR       ( FLG-DBRC    NOT =   ZERO )
      *
               MOVE    IDX1        TO  SPA-GMN-I02-TENKALST-CNT
      *
               MOVE    MCPDATA-REC TO  PTNYUINRRK-REC
      *
      *        病棟／病室／入院科が変わっているかチェック
               IF    ( PTNYUINRRK-BTUNUM   NOT =   WRK-KEY-BTUNUM  )
                 OR  ( PTNYUINRRK-BRMNUM   NOT =   WRK-KEY-BRMNUM  )
                 OR  ( PTNYUINRRK-NYUINKA  NOT =   WRK-KEY-NYUINKA )
                   PERFORM 3101-NYUINRRK-EDIT-SEC
               END-IF
      *
      *        備考内容
               IF    ( IDX1        >   1 )
                   PERFORM 3101-NYUINRRKLST-BIKO-EDIT-SEC
                   MOVE    WRK-BIKO-NAIYO 
                                       TO  SPA-GMN-I02-TIDONAIYO (IDX1)
               END-IF
      *
      *        転入日
               MOVE    PTNYUINRRK-TENNYUYMD
                                       TO  SPA-NAI-I02-TTENNYUYMD (IDX1)
      *
      *        転出日
               MOVE    PTNYUINRRK-TENSTUYMD
                                       TO  SPA-NAI-I02-TTENSTUYMD (IDX1)
      *
               PERFORM 3101-NYUINRRK-KEY-EDIT-SEC
      *
      *        入院履歴読み込み
               MOVE    "PTNYUINRRK-KEY5"
                                   TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
      *    入院履歴クローズ
           MOVE    "PTNYUINRRK-KEY5"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
      *    転出日を再編集
           MOVE    1               TO  IDX1
           PERFORM UNTIL ( IDX1    >   SPA-GMN-I02-TENKALST-CNT )
      *
               IF    ( SPA-NAI-I02-TLSTEDIT-FLG (IDX1)     =   1 )
                   COMPUTE WRK-ST-IDX  =   IDX1    +   1
                   PERFORM VARYING IDX2    FROM    WRK-ST-IDX  BY  1
                           UNTIL ( IDX2    >   SPA-GMN-I02-TENKALST-CNT)
                             OR  ( SPA-NAI-I02-TLSTEDIT-FLG (IDX2)
                                           =   1 )
                       MOVE    SPA-NAI-I02-TTENSTUYMD (IDX2)
                           TO  SPA-NAI-I02-TTENSTUYMD (IDX1)
                   END-PERFORM
      *
                   MOVE    IDX2        TO  IDX1
      *
               ELSE
                   COMPUTE IDX1    =   IDX1    +   1
               END-IF
      *
           END-PERFORM
      *
      *    転入日・転出日・日数・通算日数を編集
           MOVE    ZERO            TO  WRK-TUSAN
                                       WRK-IDO-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   SPA-GMN-I02-TENKALST-CNT )
      *
               IF    ( SPA-NAI-I02-TLSTEDIT-FLG (IDX1) =   1 )
                   PERFORM 3101-IDOYMD-NISSU-EDIT-SEC
               END-IF
      *
           END-PERFORM
      *
      *    不要な行を削除する
           IF    ( SPA-GMN-I02-TNYUINKA (2)        =   SPACE )
             AND ( SPA-GMN-I02-TIDONAIYO(2)    NOT =   SPACE )
               MOVE    SPA-GMN-I02-TIDONAIYO(2)
                                           TO  SPA-GMN-I02-TIDONAIYO(1)
               PERFORM VARYING IDX1    FROM    2   BY  1
                       UNTIL ( IDX1    >=  SPA-GMN-I02-TENKALST-CNT )
      *
                   COMPUTE IDX2    =   IDX1    +   1
                   MOVE    SPA-GMN-I02-TENKALST-ITM (IDX2)
                                   TO  SPA-GMN-I02-TENKALST-ITM (IDX1)
                   MOVE    SPA-GMN-I02-TENKALST-ITM (IDX2)
                                   TO  SPA-GMN-I02-TENKALST-ITM (IDX1)
                   MOVE    SPA-NAI-I02-TENKALST-ITM (IDX2)
                                   TO  SPA-NAI-I02-TENKALST-ITM (IDX1)
      *
               END-PERFORM
      *
               MOVE    SPA-GMN-I02-TENKALST-CNT    TO  IDX1
      *
               INITIALIZE  SPA-NAI-I02-TENKALST-ITM (IDX1)
                           SPA-NAI-I02-TENKALST-ITM (IDX1)
               COMPUTE SPA-GMN-I02-TENKALST-CNT
                   =   SPA-GMN-I02-TENKALST-CNT    -   1
           END-IF
      *
      *
           .
      *
       3101-NYUINRRKLST-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    入院歴ＫＥＹ項目編集処理
      *****************************************************************
       3101-NYUINRRK-KEY-EDIT-SEC      SECTION.
      *
           MOVE    PTNYUINRRK-BTUNUM   TO  WRK-KEY-BTUNUM
           MOVE    PTNYUINRRK-BRMNUM   TO  WRK-KEY-BRMNUM
           MOVE    PTNYUINRRK-NYUINKA  TO  WRK-KEY-NYUINKA
           MOVE    PTNYUINRRK-TOKUTEI-KBN
                                       TO  WRK-KEY-TOKUTEI-KBN
           MOVE    PTNYUINRRK-TOKUTEI-NYUIN
                                       TO  WRK-KEY-TOKUTEI-NYUIN
           MOVE    PTNYUINRRK-HKNCOMBINUM
                                       TO  WRK-KEY-HKNCOMBINUM
      *
           .
       3101-NYUINRRK-KEY-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    入院歴編集処理
      *****************************************************************
       3101-NYUINRRK-EDIT-SEC          SECTION.
      *
           COMPUTE WRK-NYUINRRK-EDIT-MAX
               =   WRK-NYUINRRK-EDIT-MAX   +   1
      *
      *    入院科
           MOVE    PTNYUINRRK-NYUINKA
                                       TO  WRK-KBNCD
           PERFORM 3101-S1005-SEL-SEC
           MOVE    WRK-SRYKANAME
                                       TO  SPA-GMN-I02-TNYUINKA (IDX1)
      *
      *    病棟名
           IF    ( PTNYUINRRK-JTIKBN   =   "5" OR "6" )
               MOVE    PTNYUINRRK-BTUNAME
                                       TO  SPA-GMN-I02-TBTUNAME (IDX1)
           ELSE
               PERFORM 3101-S5001-SEL-SEC
               MOVE    WRK-BTUNAME     TO  SPA-GMN-I02-TBTUNAME (IDX1)
           END-IF
      *
      *    病室番号
           PERFORM 3101-BRMNUM-EDIT-SEC
           MOVE    WRK-BRMNUM      TO  SPA-GMN-I02-TBRMNUM (IDX1)
      *
      *    リスト編集フラグ
           MOVE    1               TO  SPA-NAI-I02-TLSTEDIT-FLG (IDX1)
      *
           .
      *
       3101-NYUINRRK-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    入院歴リスト備考編集処理
      *****************************************************************
       3101-NYUINRRKLST-BIKO-EDIT-SEC  SECTION.
      *
           INITIALIZE   WRK-BIKO-ITEM-AREA
      *
           MOVE    PTNYUINRRK-TENNYUYMD    TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG             TO  WRK-BIKO-YMD
      *
           MOVE    ZERO                    TO  IDX3
           MOVE    "--"                    TO  WRK-BIKO-ITEM (1)
      *
      *    入院科
           IF    ( PTNYUINRRK-NYUINKA  NOT =   WRK-KEY-NYUINKA )
               COMPUTE IDX3    =   IDX3    +   1
               MOVE    1                   TO  WRK-BIKO-ITEM-KBN (IDX3)
           END-IF
      *
      *    病室
           IF    ( PTNYUINRRK-BTUNUM   NOT =   WRK-KEY-BTUNUM )
             OR  ( PTNYUINRRK-BRMNUM   NOT =   WRK-KEY-BRMNUM )
               COMPUTE IDX3    =   IDX3    +   1
               MOVE    2                   TO  WRK-BIKO-ITEM-KBN (IDX3)
           END-IF
      *
      *    入院料
           IF    ( PTNYUINRRK-TOKUTEI-KBN
                                       NOT =   WRK-KEY-TOKUTEI-KBN )
             OR  ( PTNYUINRRK-TOKUTEI-NYUIN
                                       NOT =   WRK-KEY-TOKUTEI-NYUIN )
               COMPUTE IDX3    =   IDX3    +   1
               MOVE    3                   TO  WRK-BIKO-ITEM-KBN (IDX3)
           END-IF
      *
      *    保険組合せ
           IF    ( PTNYUINRRK-HKNCOMBINUM
                                       NOT =   WRK-KEY-HKNCOMBINUM )
               COMPUTE IDX3    =   IDX3    +   1
               MOVE    4                   TO  WRK-BIKO-ITEM-KBN (IDX3)
           END-IF
      *
           MOVE    IDX3                    TO  WRK-BIKO-ITEM-CNT
           MOVE    1                       TO  WRK-BIKO-IDX
      *    長い名称で編集
           PERFORM 3101-BIKO-EDIT-SEC
           IF    ( WRK-BIKO-PNT    >   34 )
      *        短い名称で編集
               MOVE    2                   TO  WRK-BIKO-IDX
               PERFORM 3101-BIKO-EDIT-SEC
           END-IF
      *
           .
      3101-NYUINRRKLST-BIKO-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    備考編集処理
      *****************************************************************
       3101-BIKO-EDIT-SEC              SECTION.
      *
           MOVE    SPACE                   TO  WRK-BIKO-NAIYO
      *
           PERFORM VARYING IDX3    FROM    1   BY  1
                   UNTIL ( IDX3        >   WRK-BIKO-ITEM-CNT )
               MOVE    WRK-BIKO-ITEM-KBN (IDX3)
                                           TO  IDX4
               MOVE    CONST-BIKO (IDX4 WRK-BIKO-IDX)
                                           TO  WRK-BIKO-ITEM (IDX3)
           END-PERFORM
      *
           MOVE    1                       TO  WRK-BIKO-PNT
           STRING  WRK-BIKO-YMD        DELIMITED   BY  SIZE
                   "［"                DELIMITED   BY  SIZE
                   WRK-BIKO-ITEM (1)
                                       DELIMITED   BY  SPACE
           INTO    WRK-BIKO-NAIYO
           WITH    POINTER WRK-BIKO-PNT
           END-STRING
      *
           PERFORM VARYING IDX3    FROM    2   BY  1
                   UNTIL ( IDX3        >   WRK-BIKO-ITEM-CNT )
      *
               STRING  "／"                    DELIMITED   BY  SIZE
                   WRK-BIKO-ITEM (IDX3)
                                               DELIMITED   BY  SPACE
               INTO    WRK-BIKO-NAIYO
               WITH    POINTER WRK-BIKO-PNT
               END-STRING
      *
           END-PERFORM
      *
           STRING "］"             DELIMITED   BY  SIZE
           INTO    WRK-BIKO-NAIYO
           WITH    POINTER WRK-BIKO-PNT
           END-STRING
      *
           COMPUTE WRK-BIKO-PNT    =   WRK-BIKO-PNT    -   1
      *
           .
       3101-BIKO-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    異動日・日数編集処理
      *****************************************************************
       3101-IDOYMD-NISSU-EDIT-SEC      SECTION.
      *
           COMPUTE WRK-IDO-CNT =   WRK-IDO-CNT +   1
      *
      *    転入日
           MOVE    SPA-NAI-I02-TTENNYUYMD (IDX1)
                                       TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG         TO  SPA-GMN-I02-TTENNYUYMD (IDX1)
      *
      *    転出日
           IF    ( SPA-NAI-I02-TTENSTUYMD (IDX1)
                                       =   "99999999" )
               MOVE    SPACE           TO  SPA-GMN-I02-TTENSTUYMD (IDX1)
           ELSE
               MOVE    SPA-NAI-I02-TTENSTUYMD (IDX1)
                                       TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG     TO  SPA-GMN-I02-TTENSTUYMD (IDX1)
           END-IF
      *
           MOVE    SPA-NAI-I02-TTENNYUYMD (IDX1)
                                       TO  WRK-STYMD
           MOVE    SPA-NAI-I02-TTENSTUYMD (IDX1)
                                       TO  WRK-EDYMD
      *
      *    日数の算出について
      *    １．最新歴の場合
      *       ・入院中の場合は空白
      *       ・退院済みの場合は転入日から転出日の間の日数
      *         （転出日を含める）
      *    ２．最新歴で無い場合
      *       ・転入日から転出日の間の日数
      *         （転出日を含めない）
           IF    ( WRK-IDO-CNT         =   WRK-NYUINRRK-EDIT-MAX )
               IF     ( SPA-GMN-I02-TTENSTUYMD (IDX1)
                                   =   SPACE )
                   MOVE    SPACE       TO  SPA-GMN-I02-TNISSU (IDX1)
                                           SPA-GMN-I02-TTUSAN (IDX1)
               ELSE
                   PERFORM 5002-KIKAN-CALC-SEC
                   MOVE    WRK-NISSU2  TO  WRK-ZZZZ9
                   MOVE    WRK-ZZZZ9   TO  SPA-GMN-I02-TNISSU (IDX1)
                   COMPUTE WRK-TUSAN   =  WRK-TUSAN  + WRK-NISSU2
                   MOVE    WRK-TUSAN   TO  WRK-ZZZZ9
                   MOVE    WRK-ZZZZ9   TO  SPA-GMN-I02-TTUSAN (IDX1)
               END-IF
           ELSE
               PERFORM 5002-KIKAN-CALC-SEC
               MOVE    WRK-NISSU1  TO  WRK-ZZZZ9
               MOVE    WRK-ZZZZ9   TO  SPA-GMN-I02-TNISSU (IDX1)
               COMPUTE WRK-TUSAN   =   WRK-TUSAN  + WRK-NISSU1
               MOVE    WRK-TUSAN   TO  WRK-ZZZZ9
               MOVE    WRK-ZZZZ9   TO  SPA-GMN-I02-TTUSAN (IDX1)
           END-IF
      *
           .
       3101-IDOYMD-NISSU-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病名リスト編集処理
      *****************************************************************
       3101-BYOMEILST-EDIT-SEC         SECTION.
      *
           INITIALIZE                  SPA-GMN-I02-BYOMEILST
      *
           MOVE    SPA-NAI-I02-NYUINYMD
                                       TO  WRK-NYUINYMD
           IF    ( SPA-NAI-I02-TAIINYMD
                                       =   SPACE )
               MOVE    "99999999"      TO  WRK-TAIINYMD
           ELSE
               MOVE    SPA-GMN-I02-TAIINYMD
                                       TO  WRK-TAIINYMD
           END-IF
      *
           MOVE    ZERO                TO  IDX2
      *
      *    患者病名マスタ検索
           INITIALIZE  PTBYOMEI-REC
           MOVE    SPA-HOSPID          TO  PTBYO-HOSPID
           MOVE    SPA-I01-I02-PTID
                                       TO  PTBYO-PTID
           MOVE    PTBYOMEI-REC        TO  MCPDATA-REC
           MOVE    "PTBYOMEI-KEY6"     TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1            >   500 )
                OR       ( FLG-DBRC    NOT =   ZERO )
      *
               MOVE    MCPDATA-REC     TO  PTBYOMEI-REC
      *
      *--------IF    ( WRK-NYUINYMD    <=  PTBYO-SRYYMD )
      *-------- AND  ( WRK-TAIINYMD    >=  PTBYO-SRYYMD )
               EVALUATE    TRUE
               WHEN    ( SPA-GMN-I02-NYUGAI-CD =  SPACE )
               WHEN    ( SPA-GMN-I02-NYUGAI-CD =  "1"   )
                   AND ( PTBYO-NYUGAIKBN       =  SPACE OR "1" )
               WHEN    ( SPA-GMN-I02-NYUGAI-CD =  "2"   )
                   AND ( PTBYO-NYUGAIKBN       =  SPACE OR "2" )
      *
                   PERFORM 3101-BYOMEI-EDIT-SEC
               END-EVALUATE
      *
      *--------END-IF
      *
      *        患者病名マスタ読み込み
               MOVE    "PTBYOMEI-KEY6" TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
      *    患者病名マスタクローズ
           MOVE    "PTBYOMEI-KEY6"     TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
      *
       3101-BYOMEILST-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病名編集処理
      *****************************************************************
       3101-BYOMEI-EDIT-SEC            SECTION.
      *
           COMPUTE IDX2    =   IDX2    +   1
           MOVE    IDX2    TO  SPA-GMN-I02-BYOMEILST-CNT
      *
      *    主病区分
           IF    ( PTBYO-SYUBYOFLG =   "1" )
               MOVE    "◎"    TO  SPA-GMN-I02-TSYUBYO (IDX2)
           END-IF
      *
      *    入外区分
           EVALUATE    PTBYO-NYUGAIKBN
           WHEN    SPACE
               MOVE    "入外" TO  SPA-GMN-I02-TNYUGAI (IDX2)
           WHEN    "1"
               MOVE    " 入"  TO  SPA-GMN-I02-TNYUGAI (IDX2)
           WHEN    "2"
               MOVE    " 外"  TO  SPA-GMN-I02-TNYUGAI (IDX2)
           END-EVALUATE
      *
      *    診療科
           MOVE    PTBYO-SRYKA TO  WRK-KBNCD
           PERFORM 3101-S1005-SEL-SEC
           MOVE    WRK-SRYKANAME
                                   TO  SPA-GMN-I02-TSRYKA (IDX2)
      *
      *    病名
           MOVE    PTBYO-BYOMEI
                                   TO  SPA-GMN-I02-TBYOMEI (IDX2)
      *
      *    開始日
           MOVE    PTBYO-SRYYMD
                                   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG TO  SPA-GMN-I02-TSTSRYYMD (IDX2)
      *
      *    転帰日
           MOVE    PTBYO-TENKIYMD
                                   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG TO  SPA-GMN-I02-TTENKIYMD (IDX2)
      *
      *    転帰理由
           EVALUATE    PTBYO-TENKIKBN
           WHEN "1"
                   MOVE    "治ゆ"  TO  SPA-GMN-I02-TTENKI (IDX2)
           WHEN "2"
                   MOVE    "死亡"  TO  SPA-GMN-I02-TTENKI (IDX2)
           WHEN "3"
                   MOVE    "中止"  TO  SPA-GMN-I02-TTENKI (IDX2)
           WHEN "4"
                   MOVE    "移行"  TO  SPA-GMN-I02-TTENKI (IDX2)
           END-EVALUATE
      *
           .
       3101-BYOMEI-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病名リスト編集処理（他院歴で入力された内容を表示）
      *****************************************************************
       3101-BYOMEILST-EDIT2-SEC        SECTION.
      *
      *    病名
           MOVE    ZERO            TO  IDX2
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   5 )
      *
               IF    ( PTTAINFUKA-BYOMEI (IDX1)    NOT =   SPACE )
                   COMPUTE IDX2    =   IDX2    +   1
                   MOVE    IDX2    TO  SPA-GMN-I02-BYOMEILST-CNT
                   IF    ( IDX1    =   1 )
                       MOVE    "◎"    TO  SPA-GMN-I02-TSYUBYO (IDX2)
                   END-IF
                   MOVE    PTTAINFUKA-BYOMEI (IDX1)
                                       TO  SPA-GMN-I02-TBYOMEI (IDX2)
               END-IF
      *
           END-PERFORM
      *
           .
      *
       3101-BYOMEILST-EDIT2-EXT.
           EXIT.
      *****************************************************************
      *    コンボボックス初期処理
      *****************************************************************
       310-CMB-SYOKI-SEC               SECTION.
      *
           INITIALIZE              SPA-GMN-I02-CMB-DAT-AREA
      *
      *    入外コンボ
           PERFORM 310-CMB-NYUGAI-SET-SEC
      *
           .
       310-CMB-SYOKI-EXT.
           EXIT.
      *****************************************************************
      *    入外コンボ初期処理
      *****************************************************************
       310-CMB-NYUGAI-SET-SEC          SECTION.
      *
           MOVE    3                   TO  SPA-GMN-I02-NYUGAI-CNT
      *
           MOVE    "  すべて"          TO  SPA-GMN-I02-NYUGAI-ITM (01)
           MOVE    "1 入院"            TO  SPA-GMN-I02-NYUGAI-ITM (02)
           MOVE    "2 入院外"          TO  SPA-GMN-I02-NYUGAI-ITM (03)
      *
           .
       310-CMB-NYUGAI-SET-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                     SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
           WHEN    "CLICKED"       ALSO    "B01"
               MOVE   "CHANGE"             TO  MCP-PUTTYPE
               PERFORM 210-BACK
           END-EVALUATE.
      *
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *    入外区分
           WHEN    "ACTIVATE"      ALSO    "NYUGAI"
               PERFORM 4101-NYUGAI-CHK-SEC
           END-EVALUATE
      *
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入外区分チェック処理
      *****************************************************************
       4101-NYUGAI-CHK-SEC             SECTION.
      *
           MOVE    1               TO  SPA-GMN-I02-CUR
           MOVE    I02-NYUGAI      TO  SPA-GMN-I02-NYUGAI
      *
      *    入外区分サーチ処理
           MOVE    SPA-GMN-I02-NYUGAI-CD
                                   TO  WRK-CMB-CD
           PERFORM 4103-CMB-NYUGAI-SRH-SEC
           IF    ( WRK-CMB-ITM     =   SPACE )
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4101-NYUGAI-CHK-EXT
           END-IF
      *
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-I02-NYUGAI
      *
           IF    ( SPA-NAI-I02-NYURRK-FLG     =   ZERO )
               PERFORM 3101-BYOMEILST-EDIT-SEC
           END-IF
      *
           .
      *
       4101-NYUGAI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入外区分サーチ処理
      *****************************************************************
       4103-CMB-NYUGAI-SRH-SEC         SECTION.
      *
           SET     CMB-IDX14       TO  1
           SEARCH  SPA-GMN-I02-NYUGAI-ITM
                   VARYING CMB-IDX14
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-I02-NYUGAI-ITM (CMB-IDX14) (1 : 1)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX14
               MOVE    SPA-GMN-I02-NYUGAI-ITM (CMB-IDX14)
                                   TO  WRK-CMB-ITM
           WHEN    SPA-GMN-I02-NYUGAI-ITM (CMB-IDX14)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-NYUGAI-SRH-EXT.
           EXIT.
     *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "I01"               TO  SPA-SAKIPG
           MOVE    "I02"               TO  SPA-MOTOPG
      *
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
      *
       210-BACK-EXT.
           EXIT.
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF    ( SPA-ERRCD       NOT =   SPACE )
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "I02    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面内容編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
      *    初回
           MOVE    SPA-GMN-I02-SHOKAI      TO  I02-SHOKAI
      *    状態
           MOVE    SPA-GMN-I02-JYOTAI      TO  I02-JYOTAI
      *    病棟名
           MOVE    SPA-GMN-I02-BTUNAME     TO  I02-BTUNAME
      *    病室番号
           MOVE    SPA-GMN-I02-BRMNUM      TO  I02-BRMNUM
      *    入院日
           MOVE    SPA-GMN-I02-NYUINYMD    TO  I02-NYUINYMD
      *    退院日
           MOVE    SPA-GMN-I02-TAIINYMD    TO  I02-TAIINYMD
      *    入院科
           MOVE    SPA-GMN-I02-NYUINKA     TO  I02-NYUINKA
      *    主治医
           MOVE    SPA-GMN-I02-DR          TO  I02-DR
      *    算定
           MOVE    SPA-GMN-I02-SANTEI      TO  I02-SANTEI
      *
      *    転科（転棟・転室）履歴
           MOVE    SPA-GMN-I02-TENKALST-CNT
                                           TO  I02-TENKALST-CNT
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   SPA-GMN-I02-TENKALST-CNT )
      *        入院科
               MOVE    SPA-GMN-I02-TNYUINKA   (IDX1)
                                           TO  I02-TNYUINKA   (IDX1)
      *        病棟名
               MOVE    SPA-GMN-I02-TBTUNAME   (IDX1)
                                           TO  I02-TBTUNAME   (IDX1)
      *        病室番号
               MOVE    SPA-GMN-I02-TBRMNUM    (IDX1)
                                           TO  I02-TBRMNUM    (IDX1)
      *        転入日
               MOVE    SPA-GMN-I02-TTENNYUYMD (IDX1)
                                           TO  I02-TTENNYUYMD (IDX1)
      *        転出日
               MOVE    SPA-GMN-I02-TTENSTUYMD (IDX1)
                                           TO  I02-TTENSTUYMD (IDX1)
      *        日数
               MOVE    SPA-GMN-I02-TNISSU (IDX1)
                                           TO  I02-TNISSU (IDX1)
      *        通算日数
               MOVE    SPA-GMN-I02-TTUSAN (IDX1)
                                           TO  I02-TTUSAN (IDX1)
               IF    ( SPA-GMN-I02-TENKALST-SEL
                                           =   IDX1    )
                   MOVE    "T"        TO  I02-TENKALST-SELECT(IDX1)
               ELSE
                   MOVE    "F"        TO  I02-TENKALST-SELECT(IDX1)
               END-IF
               MOVE    SPA-GMN-I02-TIDONAIYO (IDX1)
                                      TO  I02-TIDONAIYO (IDX1)
           END-PERFORM
      *
      *    入外区分
           MOVE    SPA-GMN-I02-NYUGAI
                                   TO  I02-NYUGAI
           MOVE    SPA-GMN-I02-NYUGAI-CNT
                                   TO  I02-NYUGAI-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   SPA-GMN-I02-NYUGAI-CNT )
               MOVE    SPA-GMN-I02-NYUGAI-ITM (IDX1)
                                   TO  I02-NYUGAI-ITM (IDX1)
           END-PERFORM
      *
      *    病名情報
           MOVE       SPA-GMN-I02-BYOMEILST-CNT
                                           TO   I02-BYOMEILST-CNT
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   SPA-GMN-I02-BYOMEILST-CNT )
      *        主病名区分
               MOVE    SPA-GMN-I02-TSYUBYO   (IDX1)
                                           TO   I02-TSYUBYO   (IDX1)
      *        入外区分
               MOVE    SPA-GMN-I02-TNYUGAI   (IDX1)
                                           TO   I02-TNYUGAI   (IDX1)
      *        診療科
               MOVE    SPA-GMN-I02-TSRYKA    (IDX1)
                                           TO   I02-TSRYKA    (IDX1)
      *        病名
               MOVE    SPA-GMN-I02-TBYOMEI   (IDX1)
                                           TO   I02-TBYOMEI   (IDX1)
      *        開始日
               MOVE    SPA-GMN-I02-TSTSRYYMD (IDX1)
                                           TO   I02-TSTSRYYMD (IDX1)
      *        終了日
               MOVE    SPA-GMN-I02-TTENKIYMD (IDX1)
                                           TO   I02-TTENKIYMD (IDX1)
      *        転帰日
               MOVE    SPA-GMN-I02-TTENKI    (IDX1)
                                           TO   I02-TTENKI    (IDX1)
               IF    ( SPA-GMN-I02-BYOMEILST-SEL
                                           =   IDX1    )
                   MOVE    "T"       TO   I02-BYOMEILST-SELECT(IDX1)
               ELSE
                   MOVE    "F"       TO   I02-BYOMEILST-SELECT(IDX1)
               END-IF
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
           MOVE    SPA-GMN-I02-NYUGAI-STT
                                   TO  I02-NYUGAI-STT
           MOVE    SPA-GMN-I02-NYUGAI-ITM-STT
                                   TO  I02-NYUGAI-ITM-STT
      *
           .
       500-GMNHEN-STATE-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC              SECTION.
      *
           IF    ( SPA-GMN-I02-CUR =   1   )
               IF    ( SPA-GMN-I02-NYUGAI-STT  =   WIDGET-NORMAL )
                   MOVE    "NYUGAI"    TO  MCP-WIDGET
               ELSE
                   MOVE    "B01"       TO  MCP-WIDGET
               END-IF
           ELSE
               MOVE    "B01"           TO  MCP-WIDGET
           END-IF
      *
           .
      *
       5001-MAPCUR-EXT.
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
               MOVE    "入力エラー"    TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  I0ERR
           MOVE    SPA-ERRCD            TO  I0ERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  I0ERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "I02"                TO  SPA-MOTOPG
           MOVE    "I0ERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "I0ERR"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC             SECTION.
      *
           MOVE    SPACE               TO  WRK-HENYMDG
                                           WRK-SYMD
      *
           IF    ( WRK-YMD         =   SPACE )
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
      *    期間算出処理
      *****************************************************************
       5002-KIKAN-CALC-SEC             SECTION.
      *
           MOVE    ZERO                TO  WRK-NISSU1
                                           WRK-NISSU2
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY5-AREA
           MOVE    "51"                TO  LNK-DAY5-IRAI
           MOVE    WRK-STYMD           TO  LNK-DAY5-START
           MOVE    WRK-EDYMD           TO  LNK-DAY5-END
           CALL  "ORCSDAY"             USING   STS-AREA-DAY
                                           LNK-DAY5-AREA
      *
           MOVE    LNK-DAY5-NISSU1     TO  WRK-NISSU1
           MOVE    LNK-DAY5-NISSU2     TO  WRK-NISSU2
      *
           .
       5002-KIKAN-CALC-EXT.
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

