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
       PROGRAM-ID.                               ORCGW24.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : 医療機関入院基本情報設定
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/07/30    NACL−太田    新規作成
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
           COPY    "W24SCR-SPA".
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-DBRC                            PIC 9(01).
           03  FLG-SYSKANRI                        PIC 9(01).
           03  FLG-TENSU                           PIC 9(01).
           03  FLG-KANJI                           PIC 9(01).
           03  FLG-KENSAKU                         PIC 9(01).
           03  FLG-ENTRYCHK                        PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                                PIC 9(05).
           03  IDX2                                PIC 9(05).
           03  IDX3                                PIC 9(05).
           03  IDX4                                PIC 9(05).
           03  IDXC                                PIC 9(05).
           03  IDXY                                PIC 9(05).
           03  IDXZ                                PIC 9(05).
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
               05  WRK-CMB-CD                      PIC X(05).
               05  WRK-CMB-IDX                     PIC 9(03).
               05  WRK-CMB-ITM                     PIC X(100).
               05  WRK-CMB-ITM2                    PIC X(100).
           03  WRK-SRYCD                           PIC X(09).
           03  WRK-INPUTCD                         PIC X(09).
           03  WRK-CD-MCNT                         PIC 9(02).
           03  WRK-TNS-SRYCD                       PIC X(09).
           03  WRK-TNS-NAME                        PIC X(100).
      *
      *    固定値領域
       01  CONST-AREA.
      *    入院時食事療養
           03  CONST-SHOKUJIRYOYOCD-VAL.
               05                      PIC X(09)   VALUE   "197000110".
               05                      PIC X(09)   VALUE   "197000710".
           03  CONST-SHOKUJIRYOYOCD-R
                       REDEFINES   CONST-SHOKUJIRYOYOCD-VAL.
               05  CONST-SHOKUJIRYOYOCD-OCC        OCCURS  2.
                   07  CONST-SHOKUJIRYOYOCD
                                       PIC X(09).
      *    食事情報
           03  CONST-SHOKU-VAL.
               05                      PIC X(09)   VALUE   "197000270".
               05                      PIC X(09)   VALUE   "197000570".
               05                      PIC X(09)   VALUE   "         ".
               05                      PIC X(09)   VALUE   "         ".
               05                      PIC X(09)   VALUE   "         ".
           03  CONST-SHOKU-R
                       REDEFINES   CONST-SHOKU-VAL.
               05  CONST-SHOKU-OCC                 OCCURS  5.
                   07  CONST-SHOKUCD
                                       PIC X(09).
      *
      *    医療機関減算情報
           03  CONST-GEN-VAL.
               05                      PIC X(09)   VALUE   "190080470".
               05                      PIC X(09)   VALUE   "190080570".
               05                      PIC X(09)   VALUE   "190111690".
               05                      PIC X(09)   VALUE   "190111790".
               05                      PIC X(09)   VALUE   "         ".
           03  CONST-GEN-R
                       REDEFINES   CONST-GEN-VAL.
               05  CONST-GEN-OCC                   OCCURS  5.
                   07  CONST-GENCD
                                       PIC X(09).
      *
      *    入院加算情報
           03  CONST-NYUKSN-SRYCD-VAL.
               05                      PIC X(09)   VALUE   "190098870".
               05                      PIC X(09)   VALUE   "190098970".
               05                      PIC X(09)   VALUE   "190099170".
               05                      PIC X(09)   VALUE   "190099270".
               05                      PIC X(09)   VALUE   "190099570".
               05                      PIC X(09)   VALUE   "190099870".
               05                      PIC X(09)   VALUE   "190099970".
               05                      PIC X(09)   VALUE   "190100370".
               05                      PIC X(09)   VALUE   "190100470".
               05                      PIC X(09)   VALUE   "190100770".
               05                      PIC X(09)   VALUE   "190100670".
               05                      PIC X(09)   VALUE   "190100970".
               05                      PIC X(09)   VALUE   "190107170".
               05                      PIC X(09)   VALUE   "         ".
               05                      PIC X(09)   VALUE   "         ".
               05                      PIC X(09)   VALUE   "         ".
               05                      PIC X(09)   VALUE   "         ".
               05                      PIC X(09)   VALUE   "         ".
               05                      PIC X(09)   VALUE   "         ".
               05                      PIC X(09)   VALUE   "         ".
           03  CONST-NYUKSN-SRYCD-R
                       REDEFINES   CONST-NYUKSN-SRYCD-VAL.
               05  CONST-NYUKSN-SRYCD-OCC  OCCURS  20.
                   07  CONST-NYUKSN-SRYCD  PIC X(09).
      *
      *    地域加算情報
           03  CONST-CHIIKIKSNSRYCD-VAL.
               05                      PIC X(09)   VALUE   "190077070".
               05                      PIC X(09)   VALUE   "190077170".
               05                      PIC X(09)   VALUE   "190077270".
               05                      PIC X(09)   VALUE   "190077370".
               05                      PIC X(09)   VALUE   "         ".
           03  CONST-CHIIKIKSNSRYCD-R
                       REDEFINES   CONST-CHIIKIKSNSRYCD-VAL.
               05  CONST-CHIIKIKSNSRYCD-OCC    OCCURS  5.
                   07  CONST-CHIIKIKSNSRYCD    PIC X(09).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY  "CPSYSKANRI.INC".
      *    医療機関情報
           COPY  "CPSK1001.INC".
      *    施設基準コードフラグ情報
           COPY  "CPSK1006.INC".
      *    医療機関入院基本情報
           COPY  "CPSK5000.INC".
      *    点数マスタ
           COPY  "CPTENSU.INC".
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
           MOVE    SPA-FREE        TO  SPA-W24FREE
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
           MOVE    SPA-W24FREE     TO  SPA-FREE
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
           MOVE    "W24    "           TO  MCP-WINDOW.
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
           WHEN    "W25"
      *        診療行為セット処理
               PERFORM 320-W25SPASET-SEC
               GO  TO  300-SCREEN-EXT
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
           MOVE    SPACE           TO  SPA-W24
                                           W24
           INITIALIZE                  SPA-W24
                                           W24
      *
      *    コンボボックス初期化
           PERFORM 310-CMB-SYOKI-SEC
      *
      *
      *    入力情報領域初期化処理
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
      *    入力情報編集処理
           PERFORM 310-INPUT-AREA-EDIT-SEC
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
           INITIALIZE              SPA-GMN-W24-CMB-DAT-AREA
      *
      *    入院時食事療養コンボ
           PERFORM 310-CMB-SK-NYUSYOKU-SET-SEC
      *
      *    特別管理加算コンボ
           PERFORM 310-CMB-SK-TOKKSN-SET-SEC
      *
      *    食堂加算コンボ
           PERFORM 310-CMB-SK-SYOKUDO-SET-SEC
      *
      *    入院診療計画未実施減算コンボ
           PERFORM 310-CMB-GN-NYUSRY-SET-SEC
      *
      *    院内感染防止対策未実施減算コンボ
           PERFORM 310-CMB-GN-INKANSEN-SET-SEC
      *
      *    医療安全管理体制未実施減算コンボ
           PERFORM 310-CMB-GN-ANZEN-SET-SEC
      *
      *    褥瘡対策未実施減算コンボ
           PERFORM 310-CMB-GN-JOKUSO-SET-SEC
      *
      *    地域加算コンボ
           PERFORM 310-CMB-CHIIKIKSN-SET-SEC
      *
           .
       310-CMB-SYOKI-EXT.
           EXIT.
      *****************************************************************
      *    入院時食事療養コンボ
      *****************************************************************
       310-CMB-SK-NYUSYOKU-SET-SEC      SECTION.
      *
           MOVE    2               TO  SPA-GMN-W24-SK-NYUSYOKU-CNT
      *
           MOVE    "1 入院時食事療療（１）"
                                   TO  SPA-GMN-W24-SK-NYUSYOKU-ITM (1)

           MOVE    "2 入院時食事療療（２）"
                                   TO  SPA-GMN-W24-SK-NYUSYOKU-ITM (2)
      *
           .
       310-CMB-SK-NYUSYOKU-EXT.
           EXIT.
      *****************************************************************
      *    特別管理加算コンボ
      *****************************************************************
       310-CMB-SK-TOKKSN-SET-SEC      SECTION.
      *
           MOVE    2               TO  SPA-GMN-W24-SK-TOKKSN-CNT
      *
           MOVE    "1 算定しない"
                                   TO  SPA-GMN-W24-SK-TOKKSN-ITM (1)
           MOVE    "2 算定する" 
                                   TO  SPA-GMN-W24-SK-TOKKSN-ITM (2)
      *
           .
       310-CMB-SK-TOKKSN-EXT.
           EXIT.
      *****************************************************************
      *    食堂加算コンボ
      *****************************************************************
       310-CMB-SK-SYOKUDO-SET-SEC      SECTION.
      *
           MOVE    2               TO  SPA-GMN-W24-SK-SYOKUDO-CNT
      *
           MOVE    "1 算定しない"
                                   TO  SPA-GMN-W24-SK-SYOKUDO-ITM (1)
           MOVE    "2 算定する" 
                                   TO  SPA-GMN-W24-SK-SYOKUDO-ITM (2)
      *
      *
           .
       310-CMB-SK-SYOKUDO-EXT.
           EXIT.
      *****************************************************************
      *    入院診療計画未実施減算コンボ 
      *****************************************************************
       310-CMB-GN-NYUSRY-SET-SEC      SECTION.
      *
           MOVE    2               TO  SPA-GMN-W24-GN-NYUSRY-CNT
      *
           MOVE    "1 減算しない" 
                                   TO  SPA-GMN-W24-GN-NYUSRY-ITM (1)
           MOVE    "2 減算する" 
                                   TO  SPA-GMN-W24-GN-NYUSRY-ITM (2)
      *
           .
       310-CMB-GN-NYUSRY-EXT.
           EXIT.
      *****************************************************************
      *    院内感染防止対策未実施減算コンボ
      *****************************************************************
       310-CMB-GN-INKANSEN-SET-SEC      SECTION.
      *
           MOVE    2               TO  SPA-GMN-W24-GN-INKANSEN-CNT
      *
           MOVE    "1 減算しない" 
                                   TO  SPA-GMN-W24-GN-INKANSEN-ITM (1)
           MOVE    "2 減算する" 
                                   TO  SPA-GMN-W24-GN-INKANSEN-ITM (2)
      *
           .
       310-CMB-GN-INKANSEN-EXT.
           EXIT.
      *****************************************************************
      *    医療安全管理体制未実施減算コンボ
      *****************************************************************
       310-CMB-GN-ANZEN-SET-SEC      SECTION.
      *
           MOVE    2               TO  SPA-GMN-W24-GN-ANZEN-CNT
      *
           MOVE    "1 減算しない" 
                                   TO  SPA-GMN-W24-GN-ANZEN-ITM (1)
           MOVE    "2 減算する" 
                                   TO  SPA-GMN-W24-GN-ANZEN-ITM (2)
      *
           .
       310-CMB-GN-ANZEN-EXT.
           EXIT.
      *****************************************************************
      *    褥瘡対策未実施減算コンボ
      *****************************************************************
       310-CMB-GN-JOKUSO-SET-SEC      SECTION.
      *
           MOVE    2               TO  SPA-GMN-W24-GN-JOKUSO-CNT
      *
           MOVE    "1 減算しない" 
                                   TO  SPA-GMN-W24-GN-JOKUSO-ITM (1)
           MOVE    "2 減算する" 
                                   TO  SPA-GMN-W24-GN-JOKUSO-ITM (2)
      *
           .
       310-CMB-GN-JOKUSO-EXT.
           EXIT.
      *****************************************************************
      *    地域加算コンボ
      *****************************************************************
       310-CMB-CHIIKIKSN-SET-SEC      SECTION.
      *
           MOVE    4               TO  SPA-GMN-W24-CHIIKIKSN-CNT
      *
           MOVE    "1 １種地域加算" 
                                   TO  SPA-GMN-W24-CHIIKIKSN-ITM (1)
      *
           MOVE    "2 ２種地域加算" 
                                   TO  SPA-GMN-W24-CHIIKIKSN-ITM (2)
      *
           MOVE    "3 ３種地域加算" 
                                   TO  SPA-GMN-W24-CHIIKIKSN-ITM (3)
      *
           MOVE    "4 ４種地域加算" 
                                   TO  SPA-GMN-W24-CHIIKIKSN-ITM (4)
      *
           .
       310-CMB-CHIIKIKSN-SET-EXT.
           EXIT.
      *****************************************************************
      *    入力情報編集処理
      *****************************************************************
       310-INPUT-AREA-EDIT-SEC     SECTION.
      *
      *    医療機関入院基本情報検索処理
           PERFORM 310-SYS-5000-SEL-SEC
           IF    ( FLG-SYSKANRI    NOT =   ZERO )
               GO  TO  310-INPUT-AREA-EDIT-EXT
           END-IF
      *
      *    食事療養費
           IF    ( SYS-5000-SHOKUJIRYOYOCD NOT =   SPACE )
               PERFORM VARYING IDX1    FROM    1   BY  1
                       UNTIL ( IDX1    >   2 )
                   IF    ( SYS-5000-SHOKUJIRYOYOCD
                                   =   CONST-SHOKUJIRYOYOCD (IDX1) )
                       MOVE    SPA-GMN-W24-SK-NYUSYOKU-ITM (IDX1)
                                       TO  SPA-GMN-W24-SK-NYUSYOKU
                   END-IF
               END-PERFORM
           END-IF
      *
      *    特別管理加算
           MOVE    SYS-5000-SHOKUKBN (1)
                                       TO  WRK-CMB-CD
           PERFORM 4103-CMB-SK-TOKKSN-SRH-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-SK-TOKKSN
      *
      *    食堂加算
           MOVE    SYS-5000-SHOKUKBN (2)
                                       TO  WRK-CMB-CD
           PERFORM 4103-CMB-SK-SYOKUDO-SRH-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-SK-SYOKUDO
      *
      *    入院診療計画未実施減算
           MOVE    SYS-5000-GENKBN (1) TO  WRK-CMB-CD
           PERFORM 4103-CMB-GN-NYUSRY-SRH-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-GN-NYUSRY
      *
      *    院内感染防止対策未実施減算
           MOVE    SYS-5000-GENKBN (2) TO  WRK-CMB-CD
           PERFORM 4103-CMB-GN-INKANSEN-SRH-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-GN-INKANSEN
      *
      *    医療安全管理体制未実施減算
           MOVE    SYS-5000-GENKBN (3) TO  WRK-CMB-CD
           PERFORM 4103-CMB-GN-ANZEN-SRH-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-GN-ANZEN
      *
      *    褥瘡入院診療計画未実施減算
           MOVE    SYS-5000-GENKBN (4) TO  WRK-CMB-CD
           PERFORM 4103-CMB-GN-JOKUSO-SRH-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-GN-JOKUSO
      *
      *    入院料加算情報
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >    20 )
               IF    ( SYS-5000-KSNKBN (IDX1)
                                   =    "1" )
                   MOVE    "F"     TO   SPA-GMN-W24-CHK-NYUKSNFLG (IDX1)
               ELSE
                   MOVE    "T"     TO   SPA-GMN-W24-CHK-NYUKSNFLG (IDX1)
               END-IF
           END-PERFORM
      *
      *    地域加算情報
           IF    ( SYS-5000-CHIIKIKSN  NOT =   SPACE )
               PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   5 )
      *
                   IF    ( CONST-CHIIKIKSNSRYCD (IDX1)
                                       =   SYS-5000-CHIIKIKSN )
                       MOVE    SPA-GMN-W24-CHIIKIKSN-ITM (IDX1)
                                   TO  SPA-GMN-W24-CHIIKIKSN
                   END-IF
      *
               END-PERFORM
           END-IF
      *
      *    入院会計テーブル表示情報
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >    10 )
               MOVE    SYS-5000-DSPCD (IDX1)
                                   TO  SPA-GMN-W24-SRYCD (IDX1)
                                       WRK-SRYCD
               IF    ( WRK-SRYCD   NOT =   SPACE )
                   PERFORM 4201-TENSU-SEL-SEC
                   IF    ( FLG-TENSU       =   ZERO )
                       MOVE    TNS-NAME    TO  SPA-GMN-W24-SRYACT (IDX1)
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           .
       310-INPUT-AREA-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    医療機関入院基本情報検索処理
      *****************************************************************
       310-SYS-5000-SEL-SEC        SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
      *    施設基準情報検索
           INITIALIZE  SYSKANRI-REC
           MOVE    "5000"          TO  SYS-KANRICD
           MOVE    "*"             TO  SYS-KBNCD
           MOVE    SPA-W01-STYUKYMD
                                   TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        NOT =   ZERO )
               MOVE    1           TO  FLG-SYSKANRI
           ELSE
               MOVE    MCPDATA-REC TO  SYS-5000-REC
           END-IF
      *
      *    施設基準情報クローズ
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
           .
      *
       310-SYS-5000-SEL-EXT.
           EXIT.
      *****************************************************************
      *    診療行為コードセット処理
      *****************************************************************
       320-W25SPASET-SEC           SECTION.
      *
           IF    ( SPA-W25-SRYCD   NOT =   SPACE )
               MOVE    SPA-GMN-W24-MOTOIDX
                                       TO  IDXZ
               MOVE    SPA-W25-SRYCD   TO  SPA-GMN-W24-SRYCD (IDXZ)
               PERFORM 4100-SRYCD-CHK-SEC
           ELSE
               COMPUTE SPA-GMN-W24-CUR =   SPA-GMN-W24-MOTOIDX +   28
           END-IF 
           .
       320-W25SPASET-EXT.
           EXIT.
      *
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
               PERFORM 420-CLEAR-SEC
      *    登録
           WHEN    "CLICKED"       ALSO    "B12"
               MOVE   "CHANGE"             TO  MCP-PUTTYPE
               PERFORM 480-TOUROKU-SEC
      *    入院加算情報
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN01"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN02"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN03"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN04"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN05"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN06"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN07"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN08"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN09"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN10"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN11"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN12"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN13"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN14"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN15"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN16"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN17"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN18"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN19"
           WHEN    "CLICKED"       ALSO    "CHK_NYUKSN20"
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
      *    EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *
      *    WHEN    OTHER
      *
      *        入力個所のセット
               PERFORM 400-GMN-INPUT-SEC
      *        入力チェック処理
               PERFORM 410-INPUT-CHK-SEC
      *    END-EVALUATE
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
           MOVE    ZERO        TO      SPA-GMN-W24-CUR
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
      *    入院時食事療養
           MOVE    W24-SK-NYUSYOKU     TO  SPA-GMN-W24-SK-NYUSYOKU
      *    特別管理加算
           MOVE    W24-SK-TOKKSN       TO  SPA-GMN-W24-SK-TOKKSN
      *    食堂加算
           MOVE    W24-SK-SYOKUDO      TO  SPA-GMN-W24-SK-SYOKUDO
      *    入院診療計画未実施減算
           MOVE    W24-GN-NYUSRY       TO  SPA-GMN-W24-GN-NYUSRY
      *    院内感染防止対策未実施減算
           MOVE    W24-GN-INKANSEN     TO  SPA-GMN-W24-GN-INKANSEN
      *    医療安全管理体制未実施減算
           MOVE    W24-GN-ANZEN        TO  SPA-GMN-W24-GN-ANZEN
      *    褥瘡対策未実施減算
           MOVE    W24-GN-JOKUSO       TO  SPA-GMN-W24-GN-JOKUSO
      *
      *    入院加算情報
           PERFORM VARYING     IDX1    FROM    1   BY  1
                   UNTIL     ( IDX1    >   20 )
               MOVE    W24-CHK-NYUKSNFLG (IDX1)
                                   TO  SPA-GMN-W24-CHK-NYUKSNFLG (IDX1)
           END-PERFORM
      *
      *    入院会計表示情報
           PERFORM VARYING     IDX1    FROM    1   BY  1
                   UNTIL     ( IDX1    >   10 )
               MOVE    W24-SRYCD (IDX1)
                                   TO  SPA-GMN-W24-SRYCD (IDX1)
           END-PERFORM
      *
      *    地域加算
           MOVE    W24-CHIIKIKSN       TO  SPA-GMN-W24-CHIIKIKSN
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
      *    入院時食事療養チェック処理
           PERFORM 4100-SK-NYUSYOKU-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    特別管理加算チェック処理
           PERFORM 4100-SK-TOKKSN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    食堂加算チェック処理
           PERFORM 4100-SK-SYOKUDO-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    入院診療計画未実施減算チェック処理
           PERFORM 4100-GN-NYUSRY-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    院内感染防止対策未実施減算チェック処理
           PERFORM 4100-GN-INKANSEN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    医療安全管理体制未実施減算チェック処理
           PERFORM 4100-GN-ANZEN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    褥瘡対策未実施減算チェック処理
           PERFORM 4100-GN-JOKUSO-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    入院加算情報チェック処理
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   20 )
               PERFORM 4100-CHK-NYUKSN-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4102-KIHON-CHK-EXT
               END-IF
           END-PERFORM
      *
      *    入院加算情報チェック処理-施設基準チェック処理
           PERFORM 4100-SSTKIJUN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    地域加算チェック処理
           PERFORM 4100-CHIIKIKSN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    入院会計表示情報チェック処理
           PERFORM VARYING IDXZ    FROM    1   BY  1
                   UNTIL ( IDXZ    >   10 )
               PERFORM 4100-SRYCD-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                 OR  ( FLG-END     NOT =   ZERO  )
                   GO  TO  4102-KIHON-CHK-EXT
               END-IF
           END-PERFORM
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
           MOVE    "W24"               TO  SPA-MOTOPG
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
      *    検索処理
      *****************************************************************
       409-KENSAKU-SEC             SECTION.
      *
           MOVE    IDXZ                TO  SPA-GMN-W24-MOTOIDX
           PERFORM 5011-INPUT-CUR-SEC
      *
      *    共通ＳＰＡ編集
           INITIALIZE                  SPA-W25-AREA
           MOVE    "2"                 TO  SPA-W25-TYPE
      *
           INITIALIZE                  SPA-W25GMN-AREA
           IF      WRK-INPUTCD         NOT =   SPACE
      *        診療行為で検索（オリジナルのＺ９８は内服）
               MOVE    "8"                 TO  SPA-W25-GMN-SYORI
      *        MOVE    "3"                 TO  SPA-W25-GMN-SYORI
               MOVE    WRK-INPUTCD         TO  SPA-W25-INPUTCD
               MOVE    "1"                 TO  SPA-W25-TYPE
               IF      FLG-KANJI           =   1
                   MOVE    "J"             TO  SPA-W25-CDSYUBETU
               ELSE
                   IF      WRK-INPUTCD(1:1)    NUMERIC
                       EVALUATE    WRK-CD-MCNT
                           WHEN    3
                           WHEN    6
                               MOVE    "6"     TO  SPA-W25-CDSYUBETU
                           WHEN    4
                               MOVE    "4"     TO  SPA-W25-CDSYUBETU
                           WHEN    5
                               MOVE    "5"     TO  SPA-W25-CDSYUBETU
                       END-EVALUATE
                   ELSE
                       MOVE    "A"             TO  SPA-W25-CDSYUBETU
                   END-IF
               END-IF
      *        画面編集
               PERFORM 41011-W25-SET-SEC
      *        点数マスタ編集で、対象データなしの時、診療行為で検索する
               IF     (SPA-W25-GMN-MAX     =   ZERO )  AND
                      (SPA-W25-CDSYUBETU   =   "J"  )
                   INITIALIZE                  SPA-W25GMN-AREA
                   MOVE    "8"                 TO  SPA-W25-GMN-SYORI
      *            画面編集
                   PERFORM 41011-W25-SET-SEC
               END-IF
           ELSE
      *        画面編集
               PERFORM 41011-W25-SET-SEC
           END-IF
      *
           MOVE    "W24"               TO  SPA-MOTOPG
           MOVE    "W25"               TO  SPA-SAKIPG
           MOVE    "W24"               TO  SPA-W25-MOTOPG
      *
           IF      SPA-W25-GMN-MAX     =   ZERO
               MOVE    "INPUT"             TO  MCP-WIDGET
           ELSE
               MOVE    "SELNUM1"           TO  MCP-WIDGET
           END-IF
      *
           MOVE   "NEW"                TO  MCP-PUTTYPE.
           MOVE   "W25    "            TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       409-KENSAKU-EXT.
           EXIT.
      *****************************************************************
      *    検索画面編集処理
      *****************************************************************
       41011-W25-SET-SEC                           SECTION.
      *
      *
           MOVE    SPA-AREA            TO  SPA-COMMON
           MOVE    SPA-WORK            TO  SPA-W01KYOUTU
           MOVE    SPA-W24FREE         TO  SPA-FREE
      *
           MOVE    "LINK"              TO  MCP-STATUS
           MOVE    SPACE               TO  MCP-EVENT
      *
           CALL    "ORCGW25"           USING
                                       MCPAREA
                                       SPAAREA
                                       LINKAREA
                                       SCRAREA.
      *
      *
           MOVE    SPA-COMMON           TO  SPA-AREA
           MOVE    SPA-W01KYOUTU        TO  SPA-WORK 
           MOVE    SPA-FREE             TO  SPA-W24FREE
      *
           .
       41011-W25-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    条件クリア処理
      *****************************************************************
       420-CLEAR-SEC               SECTION.
      *
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
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
      *
           INITIALIZE      SYS-5000-REC
           MOVE    "5000"          TO  SYS-5000-KANRICD
           MOVE    "*"             TO  SYS-5000-KBNCD
           MOVE    SPA-W01-STYUKYMD
                                   TO  SYS-5000-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD
                                   TO  SYS-5000-EDYUKYMD
           MOVE    SYS-5000-REC    TO  MCPDATA-REC
           MOVE    SPA-W01-STYUKYMD
                                   TO  ORC-DBYMD
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    =   ZERO )
               PERFORM 4811-HOSP-NYUINKHN-EDIT-SEC
               MOVE    SYS-5000-REC    TO  MCPDATA-REC
               MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
               PERFORM 900-TBL-UPDATE-SEC
           ELSE
               PERFORM 4811-HOSP-NYUINKHN-EDIT-SEC
               MOVE    SYS-5000-REC    TO  MCPDATA-REC
               MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
               PERFORM 900-TBL-INSERT-SEC
           END-IF
      *
           IF    ( FLG-DBRC    NOT =   ZERO )
               MOVE    "1201"      TO  SPA-ERRCD
               GO  TO  481-TOUROKU-EXT
           END-IF
      *
           MOVE    "JOIN"          TO  MCP-PUTTYPE.
           PERFORM 210-BACK
      *
           .
       481-TOUROKU-EXT.
           EXIT.
      *****************************************************************
      *    医療機関入院基本情報編集処理
      *****************************************************************
       4811-HOSP-NYUINKHN-EDIT-SEC     SECTION.
      *
           INITIALIZE      SYS-5000-REC
      *
      *    管理コード
           MOVE    "5000"
                                   TO  SYS-5000-KANRICD
      *    区分コード
           MOVE    "*"
                                   TO  SYS-5000-KBNCD
      *    有効開始年月日
           MOVE    SPA-W01-STYUKYMD
                                   TO  SYS-5000-STYUKYMD
      *    有効終了年月日
           MOVE    SPA-W01-EDYUKYMD
                                   TO  SYS-5000-EDYUKYMD
      *    食事療養費
           EVALUATE    SPA-GMN-W24-SK-NYUSYOKU-CD
           WHEN    "1"
               MOVE    CONST-SHOKUJIRYOYOCD (1)
                                   TO  SYS-5000-SHOKUJIRYOYOCD
           WHEN    "2"
               MOVE    CONST-SHOKUJIRYOYOCD (2)
                                   TO  SYS-5000-SHOKUJIRYOYOCD
           END-EVALUATE
      *
      *    特別管理加算
           MOVE    CONST-SHOKUCD (1)
                                   TO  SYS-5000-SHOKUCD (1)
           MOVE    SPA-GMN-W24-SK-TOKKSN-CD
                                   TO  SYS-5000-SHOKUKBN (1)
      *    食堂加算
           MOVE    CONST-SHOKUCD (2)
                                   TO  SYS-5000-SHOKUCD (2)
           MOVE    SPA-GMN-W24-SK-SYOKUDO-CD
                                   TO  SYS-5000-SHOKUKBN (2)
      *
      *    入院診療計画未実施減算
           MOVE    CONST-GENCD (1)
                                   TO  SYS-5000-GENCD (1)
           MOVE    SPA-GMN-W24-GN-NYUSRY-CD
                                   TO  SYS-5000-GENKBN (1)
      *
      *    院内感染防止対策未実施減算
           MOVE    CONST-GENCD (2)
                                   TO  SYS-5000-GENCD (2)
           MOVE    SPA-GMN-W24-GN-INKANSEN-CD
                                   TO  SYS-5000-GENKBN (2)
      *
      *    医療安全管理体制未実施減算
           MOVE    CONST-GENCD (3)
                                   TO  SYS-5000-GENCD (3)
           MOVE    SPA-GMN-W24-GN-ANZEN-CD
                                   TO  SYS-5000-GENKBN (3)
      *
      *    褥瘡入院診療計画未実施減算
           MOVE    CONST-GENCD (4)
                                   TO  SYS-5000-GENCD (4)
           MOVE    SPA-GMN-W24-GN-JOKUSO-CD
                                   TO  SYS-5000-GENKBN (4)
      *
      *    入院料加算情報
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >    20 )
               MOVE    CONST-NYUKSN-SRYCD (IDX1)
                                   TO   SYS-5000-KSNCD (IDX1)
               IF    ( SPA-GMN-W24-CHK-NYUKSNFLG (IDX1)
                                   =    "F" )
                   MOVE    "1"     TO   SYS-5000-KSNKBN (IDX1)
               ELSE
                   MOVE    "2"     TO   SYS-5000-KSNKBN (IDX1)
               END-IF
           END-PERFORM
      *
      *    地域加算情報
           IF    ( SPA-GMN-W24-CHIIKIKSN-CD    >=  "1")
            AND  ( SPA-GMN-W24-CHIIKIKSN-CD    <=  "4" )
               MOVE    SPA-GMN-W24-CHIIKIKSN-CD
                                   TO  IDXY
               MOVE    CONST-CHIIKIKSNSRYCD (IDXY)
                                   TO  SYS-5000-CHIIKIKSN
           END-IF
      *
      *    入院会計テーブル表示情報
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >    10 )
               MOVE    SPA-GMN-W24-SRYCD (IDX1)
                                   TO  SYS-5000-DSPCD (IDX1)
           END-PERFORM
      *
           .
      *
       4811-HOSP-NYUINKHN-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    入院時食事療養チェック処理
      *****************************************************************
       4100-SK-NYUSYOKU-CHK-SEC        SECTION.
      *
           IF    ( SPA-GMN-W24-SK-NYUSYOKU =   SPACE )
               GO  TO  4100-SK-NYUSYOKU-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W24-SK-NYUSYOKU-CD
                                       TO  WRK-CMB-CD
           PERFORM 4103-CMB-SK-NYUSYOKU-SRH-SEC
           IF   (  WRK-CMB-ITM     =   SPACE )
               MOVE    1           TO  SPA-GMN-W24-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-SK-NYUSYOKU-CHK-EXT
           END-IF
      *
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-SK-NYUSYOKU
      *
           .
      *
       4100-SK-NYUSYOKU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    特別管理加算チェック処理
      *****************************************************************
       4100-SK-TOKKSN-CHK-SEC        SECTION.
      *
           IF    ( SPA-GMN-W24-SK-TOKKSN =   SPACE )
               MOVE   "1"              TO  WRK-CMB-CD
               PERFORM 4103-CMB-SK-TOKKSN-SRH-SEC
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-SK-TOKKSN
               GO  TO  4100-SK-TOKKSN-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W24-SK-TOKKSN-CD
                                       TO  WRK-CMB-CD
           PERFORM 4103-CMB-SK-TOKKSN-SRH-SEC
           IF   (  WRK-CMB-ITM     =   SPACE )
               MOVE    2           TO  SPA-GMN-W24-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-SK-TOKKSN-CHK-EXT
           END-IF
      *
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-SK-TOKKSN
      *
           .
      *
       4100-SK-TOKKSN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    食堂加算チェック処理
      *****************************************************************
       4100-SK-SYOKUDO-CHK-SEC         SECTION.
      *
           IF    ( SPA-GMN-W24-SK-SYOKUDO =   SPACE )
               MOVE   "1"              TO  WRK-CMB-CD
               PERFORM 4103-CMB-SK-SYOKUDO-SRH-SEC
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-SK-SYOKUDO
               GO  TO  4100-SK-SYOKUDO-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W24-SK-SYOKUDO-CD
                                       TO  WRK-CMB-CD
           PERFORM 4103-CMB-SK-SYOKUDO-SRH-SEC
           IF   (  WRK-CMB-ITM     =   SPACE )
               MOVE    3           TO  SPA-GMN-W24-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-SK-SYOKUDO-CHK-EXT
           END-IF
      *
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-SK-SYOKUDO
      *
           .
      *
       4100-SK-SYOKUDO-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院診療計画未実施減算チェック処理
      *****************************************************************
       4100-GN-NYUSRY-CHK-SEC          SECTION.
      *
           IF    ( SPA-GMN-W24-GN-NYUSRY =   SPACE )
               MOVE   "1"              TO  WRK-CMB-CD
               PERFORM 4103-CMB-GN-NYUSRY-SRH-SEC
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-GN-NYUSRY
               GO  TO  4100-GN-NYUSRY-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W24-GN-NYUSRY-CD
                                       TO  WRK-CMB-CD
           PERFORM 4103-CMB-GN-NYUSRY-SRH-SEC
           IF   (  WRK-CMB-ITM     =   SPACE )
               MOVE    4           TO  SPA-GMN-W24-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-GN-NYUSRY-CHK-EXT
           END-IF
      *
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-GN-NYUSRY
      *
           .
      *
       4100-GN-NYUSRY-CHK-EXT.
           EXIT.
      *****************************************************************
      *    院内感染防止対策未実施減算チェック処理
      *****************************************************************
       4100-GN-INKANSEN-CHK-SEC        SECTION.
      *
           IF    ( SPA-GMN-W24-GN-INKANSEN =   SPACE )
               MOVE   "1"              TO  WRK-CMB-CD
               PERFORM 4103-CMB-GN-INKANSEN-SRH-SEC
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-GN-INKANSEN
               GO  TO  4100-GN-INKANSEN-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W24-GN-INKANSEN-CD
                                       TO  WRK-CMB-CD
           PERFORM 4103-CMB-GN-INKANSEN-SRH-SEC
           IF   (  WRK-CMB-ITM     =   SPACE )
               MOVE    5           TO  SPA-GMN-W24-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-GN-INKANSEN-CHK-EXT
           END-IF
      *
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-GN-INKANSEN
      *
           .
      *
       4100-GN-INKANSEN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    医療安全管理体制未実施減算チェック処理
      *****************************************************************
       4100-GN-ANZEN-CHK-SEC           SECTION.
      *
           IF    ( SPA-GMN-W24-GN-ANZEN =   SPACE )
               MOVE   "1"              TO  WRK-CMB-CD
               PERFORM 4103-CMB-GN-ANZEN-SRH-SEC
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-GN-ANZEN
               GO  TO  4100-GN-ANZEN-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W24-GN-ANZEN-CD
                                       TO  WRK-CMB-CD
           PERFORM 4103-CMB-GN-ANZEN-SRH-SEC
           IF   (  WRK-CMB-ITM     =   SPACE )
               MOVE    6           TO  SPA-GMN-W24-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-GN-ANZEN-CHK-EXT
           END-IF
      *
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-GN-ANZEN
      *
           .
      *
       4100-GN-ANZEN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    褥瘡対策未実施減算チェック処理
      *****************************************************************
       4100-GN-JOKUSO-CHK-SEC          SECTION.
      *
           IF    ( SPA-GMN-W24-GN-JOKUSO =   SPACE )
               MOVE   "1"              TO  WRK-CMB-CD
               PERFORM 4103-CMB-GN-JOKUSO-SRH-SEC
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-GN-JOKUSO
               GO  TO  4100-GN-JOKUSO-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W24-GN-JOKUSO-CD
                                       TO  WRK-CMB-CD
           PERFORM 4103-CMB-GN-JOKUSO-SRH-SEC
           IF   (  WRK-CMB-ITM     =   SPACE )
               MOVE    7           TO  SPA-GMN-W24-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-GN-JOKUSO-CHK-EXT
           END-IF
      *
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-GN-JOKUSO
      *
           .
      *
       4100-GN-JOKUSO-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院加算情報チェック処理
      *****************************************************************
       4100-CHK-NYUKSN-CHK-SEC         SECTION.
      *
           IF    ( SPA-GMN-W24-NYUKSNNM (IDX1) =  SPACE )
               MOVE    "F"         TO  SPA-GMN-W24-CHK-NYUKSNFLG (IDX1)
           END-IF
      *
           .
      *
       4100-CHK-NYUKSN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    施設基準チェック処理
      *****************************************************************
       4100-SSTKIJUN-CHK-SEC           SECTION.
      *
      *    施設基準検索処理
           PERFORM 4100-SYS-1006-SEL-SEC
           IF    ( FLG-SYSKANRI    NOT =   ZERO )
               GO  TO  4100-SSTKIJUN-CHK-EXT
           END-IF
      *
      *    入院時医学管理料チェック処理
           PERFORM 4100-A200-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-SSTKIJUN-CHK-EXT
           END-IF
      *
      *    紹介外来加算チェック処理
           PERFORM 4100-A201-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-SSTKIJUN-CHK-EXT
           END-IF
      *
      *    急性期入院加算チェック処理
           PERFORM 4100-A202-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-SSTKIJUN-CHK-EXT
           END-IF
      *
      *    急性期特定入院加算チェック処理
           PERFORM 4100-A203-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-SSTKIJUN-CHK-EXT
           END-IF
      *
      *    地域支援病院入院診療加算チェック処理
           PERFORM 4100-A204-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-SSTKIJUN-CHK-EXT
           END-IF
      *
      *    診療録管理体制加算チェック処理
           PERFORM 4100-A207-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-SSTKIJUN-CHK-EXT
           END-IF
      *
      *    乳児加算・幼児加算チェック処理
           PERFORM 4100-A208-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-SSTKIJUN-CHK-EXT
           END-IF
      *
      *    精神病棟入院時医学管理料チェック処理
           PERFORM 4100-A230-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-SSTKIJUN-CHK-EXT
           END-IF
      *
           .
       4100-SSTKIJUN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院時医学管理料チェック処理
      *****************************************************************
       4100-A200-CHK-SEC               SECTION.
      *
           IF    ( SPA-GMN-W24-CHK-NYUKSNFLG (01)  =   "T" )
               IF  ( SYS-1006-SSTKIJUN (201)   =   1 )
                   CONTINUE
               ELSE
                   MOVE    8       TO  SPA-GMN-W24-CUR
                   MOVE    "0004"  TO  SPA-ERRCD
                   MOVE    "F"     TO  SPA-GMN-W24-CHK-NYUKSNFLG (01)
                   GO  TO  4100-A200-CHK-EXT
               END-IF
           END-IF
      *
           .
       4100-A200-CHK-EXT.
           EXIT.
      *****************************************************************
      *    紹介外来加算チェック処理
      *****************************************************************
       4100-A201-CHK-SEC               SECTION.
      *
           IF    ( SPA-GMN-W24-CHK-NYUKSNFLG (02)  =   "T" )
               IF    ( SYS-1006-SSTKIJUN (202) =   1 )
                AND (( SYS-1006-SSTKIJUN (147) =   1 )
                 OR  ( SYS-1006-SSTKIJUN (148) =   1 )
                 OR  ( SYS-1006-SSTKIJUN (107) =   1 )
                 OR  ( SYS-1006-SSTKIJUN (108) =   1 ))
                   CONTINUE
               ELSE
                   MOVE    9       TO  SPA-GMN-W24-CUR
                   MOVE    "0004"  TO  SPA-ERRCD
                   MOVE    "F"     TO  SPA-GMN-W24-CHK-NYUKSNFLG (02)
                   GO  TO  4100-A201-CHK-EXT
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W24-CHK-NYUKSNFLG (03)  =   "T" )
               IF    ( SYS-1006-SSTKIJUN (202) =   1 )
                AND  ( SYS-1006-SSTKIJUN (203) =   1 )
                AND (( SYS-1006-SSTKIJUN (147) =   1 )
                 OR  ( SYS-1006-SSTKIJUN (148) =   1 )
                 OR  ( SYS-1006-SSTKIJUN (107) =   1 )
                 OR  ( SYS-1006-SSTKIJUN (108) =   1 ))
                   CONTINUE
               ELSE
                   MOVE    10      TO  SPA-GMN-W24-CUR
                   MOVE    "0004"  TO  SPA-ERRCD
                   MOVE    "F"     TO  SPA-GMN-W24-CHK-NYUKSNFLG (03)
                   GO  TO  4100-A201-CHK-EXT
               END-IF
           END-IF
      *
           .
       4100-A201-CHK-EXT.
           EXIT.
      *****************************************************************
      *    急性期入院加算チェック処理
      *****************************************************************
       4100-A202-CHK-SEC               SECTION.
      *
           IF    ( SPA-GMN-W24-CHK-NYUKSNFLG (04)  =   "T" )
               IF  ( SYS-1006-SSTKIJUN (323)   =   1 )
                   CONTINUE
               ELSE
                   MOVE    11      TO  SPA-GMN-W24-CUR
                   MOVE    "0004"  TO  SPA-ERRCD
                   MOVE    "F"     TO  SPA-GMN-W24-CHK-NYUKSNFLG (04)
                   GO  TO  4100-A202-CHK-EXT
               END-IF
           END-IF
      *
           .
       4100-A202-CHK-EXT.
           EXIT.
      *****************************************************************
      *    急性期特定入院加算チェック処理
      *****************************************************************
       4100-A203-CHK-SEC               SECTION.
      *
           IF    ( SPA-GMN-W24-CHK-NYUKSNFLG (05)  =   "T" )
               IF  ( SYS-1006-SSTKIJUN (324)   =   1 )
                   CONTINUE
               ELSE
                   MOVE    12      TO  SPA-GMN-W24-CUR
                   MOVE    "0004"  TO  SPA-ERRCD
                   MOVE    "F"     TO  SPA-GMN-W24-CHK-NYUKSNFLG (05)
                   GO  TO  4100-A203-CHK-EXT
               END-IF
           END-IF
      *
           .
       4100-A203-CHK-EXT.
           EXIT.
      *****************************************************************
      *    地域支援病院入院診療加算チェック処理
      *****************************************************************
       4100-A204-CHK-SEC               SECTION.
      *
           IF    ( SPA-GMN-W24-CHK-NYUKSNFLG (06)  =   "T" )
               IF  ( SYS-1006-SSTKIJUN (146)   =   1 )
                   CONTINUE
               ELSE
                   MOVE    13      TO  SPA-GMN-W24-CUR
                   MOVE    "0004"  TO  SPA-ERRCD
                   MOVE    "F"     TO  SPA-GMN-W24-CHK-NYUKSNFLG (06)
                   GO  TO  4100-A204-CHK-EXT
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W24-CHK-NYUKSNFLG (07)  =   "T" )
               IF    ( SYS-1006-SSTKIJUN (146)   =   1 )
                AND  ( SYS-1006-SSTKIJUN (147)   =   1 )
                AND  ( SYS-1006-SSTKIJUN (156)   =   1 )
                   CONTINUE
               ELSE
                   MOVE    14      TO  SPA-GMN-W24-CUR
                   MOVE    "0004"  TO  SPA-ERRCD
                   MOVE    "F"     TO  SPA-GMN-W24-CHK-NYUKSNFLG (07)
                   GO  TO  4100-A204-CHK-EXT
               END-IF
           END-IF
      *
           .
       4100-A204-CHK-EXT.
           EXIT.
      *****************************************************************
      *    診療録管理体制加算チェック処理
      *****************************************************************
       4100-A207-CHK-SEC               SECTION.
      *
           IF    ( SPA-GMN-W24-CHK-NYUKSNFLG (08)  =   "T" )
               IF    ( SYS-1006-SSTKIJUN (206)   =   1 )
                   CONTINUE
               ELSE
                   MOVE    15      TO  SPA-GMN-W24-CUR
                   MOVE    "0004"  TO  SPA-ERRCD
                   MOVE    "F"     TO  SPA-GMN-W24-CHK-NYUKSNFLG (08)
                   GO  TO  4100-A207-CHK-EXT
               END-IF
           END-IF
      *
           .
       4100-A207-CHK-EXT.
           EXIT.
      *****************************************************************
      *    乳児加算・幼児加算チェック処理
      *****************************************************************
       4100-A208-CHK-SEC               SECTION.
      *
      *
           .
       4100-A208-CHK-EXT.
           EXIT.
      *****************************************************************
      *    精神病棟入院時医学管理料チェック処理
      *****************************************************************
       4100-A230-CHK-SEC               SECTION.
      *
           IF    ( SPA-GMN-W24-CHK-NYUKSNFLG (13)  =   "T" )
               IF    ( SYS-1006-SSTKIJUN (207)   =   1 )
                   CONTINUE
               ELSE
                   MOVE    20      TO  SPA-GMN-W24-CUR
                   MOVE    "0004"  TO  SPA-ERRCD
                   MOVE    "F"     TO  SPA-GMN-W24-CHK-NYUKSNFLG (13)
                   GO  TO  4100-A230-CHK-EXT
               END-IF
           END-IF
      *
           .
       4100-A230-CHK-EXT.
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
           MOVE    SPA-W01-STYUKYMD
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
      *    地域加算チェック処理
      *****************************************************************
       4100-CHIIKIKSN-CHK-SEC          SECTION.
      *
           IF    ( SPA-GMN-W24-CHIIKIKSN =   SPACE )
               GO  TO  4100-CHIIKIKSN-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W24-CHIIKIKSN-CD
                                       TO  WRK-CMB-CD
           PERFORM 4103-CMB-CHIIKIKSN-SRH-SEC
           IF   (  WRK-CMB-ITM     =   SPACE )
               MOVE    28          TO  SPA-GMN-W24-CUR
               MOVE    "0001"      TO  SPA-ERRCD
               GO  TO  4100-CHIIKIKSN-CHK-EXT
           END-IF
      *
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W24-CHIIKIKSN
           .
      *
       4100-CHIIKIKSN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院会計表示情報チェック処理
      *****************************************************************
       4100-SRYCD-CHK-SEC              SECTION.
      *
           IF    ( SPA-GMN-W24-SRYCD (IDXZ)    =   SPACE )
               MOVE    SPACE       TO  SPA-GMN-W24-SRYACT (IDXZ)
               GO  TO  4100-SRYCD-CHK-EXT
           END-IF
      *
      *    "//" 入力の時、検索画面へ
           IF    ( SPA-GMN-W24-SRYCD (IDXZ)(1 : 2)   =  "//" )
               MOVE    SPACE           TO  WRK-INPUTCD
               PERFORM 409-KENSAKU-SEC
               GO  TO  4100-SRYCD-CHK-EXT
           END-IF
      *
      *    入力コードチェック
           PERFORM 4010-SRYCD-CHK-SEC
           IF    ( FLG-KENSAKU         =   1 )
               GO  TO  4100-SRYCD-CHK-EXT
           END-IF
      *
           EVALUATE  SPA-GMN-W24-SRYCD (IDXZ) (1 : 1)
           WHEN  "0"
               IF  ( SPA-GMN-W24-SRYCD (IDXZ)(2 : 2) = "00" )
                   MOVE    "0003"    TO  SPA-ERRCD
                   GO  TO  4100-SRYCD-CHK-EXT
               END-IF
           WHEN  "1"
           WHEN  "6"
           WHEN  "7"
           WHEN  "8"
               CONTINUE
           WHEN  OTHER
               MOVE    "0003"      TO  SPA-ERRCD
               GO  TO  4100-SRYCD-CHK-EXT
           END-EVALUATE
      *
      *    点数マスタ該当データ読み出し
           MOVE    SPA-GMN-W24-SRYCD (IDXZ)
                                   TO  WRK-SRYCD
           PERFORM 4201-TENSU-SEL-SEC
           IF    ( FLG-TENSU       NOT =   ZERO )
               COMPUTE SPA-GMN-W24-CUR =   IDXZ    +   28
               MOVE    "0002"      TO  SPA-ERRCD
           END-IF
      *
           MOVE    TNS-NAME        TO  SPA-GMN-W24-SRYACT (IDXZ)
      *
           .
      *
       4100-SRYCD-CHK-EXT.
           EXIT.
      *****************************************************************
      *  入力コードチェック処理
      *****************************************************************
       4010-SRYCD-CHK-SEC                        SECTION.
      *
           MOVE    ZERO               TO  FLG-KENSAKU
      *
           MOVE    ZERO               TO  WRK-CD-MCNT
           MOVE    ZERO               TO  FLG-KANJI
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    SPA-GMN-W24-SRYCD (IDXZ)
                                       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF      KANACHK-RC      NOT =   ZERO
      *        全角半角混在エラー
               MOVE    "0003"              TO  SPA-ERRCD
               GO      TO    4010-SRYCD-CHK-EXT
           ELSE
               MOVE    KANACHK-MAX         TO  WRK-CD-MCNT
      *        全角
               IF      KANACHK-SYUBETU     =   2
                   MOVE    1               TO  FLG-KANJI
               ELSE
                   MOVE    ZERO            TO  FLG-KANJI
               END-IF
           END-IF
      *
      *    半角で９文字の時、点数マスタチェックへ
           IF     (WRK-CD-MCNT         =   9  )  AND
                  (FLG-KANJI           =   ZERO )  AND
                  (SPA-GMN-W24-SRYCD (IDXZ) (1 : 9 )
                                       IS  NUMERIC  )
               GO      TO    4010-SRYCD-CHK-EXT
           END-IF
      *
           MOVE    1                   TO  FLG-KENSAKU
           MOVE    SPA-GMN-W24-SRYCD (IDXZ)
                                       TO  WRK-INPUTCD
           PERFORM 409-KENSAKU-SEC
      *
           .
       4010-SRYCD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院時食事療養サーチ処理
      *****************************************************************
       4103-CMB-SK-NYUSYOKU-SRH-SEC    SECTION.
      *
           SET     CMB-IDX01       TO  1
           SEARCH  SPA-GMN-W24-SK-NYUSYOKU-ITM
                   VARYING CMB-IDX01
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-W24-SK-NYUSYOKU-ITM (CMB-IDX01) (1 : 1)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX01
               MOVE    SPA-GMN-W24-SK-NYUSYOKU-ITM (CMB-IDX01)
                                   TO  WRK-CMB-ITM
           WHEN    SPA-GMN-W24-SK-NYUSYOKU-ITM (CMB-IDX01)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-SK-NYUSYOKU-SRH-EXT.
           EXIT.
      *****************************************************************
      *    入院時食事療養サーチ処理
      *****************************************************************
       4103-CMB-SK-TOKKSN-SRH-SEC      SECTION.
      *
           SET     CMB-IDX02       TO  1
           SEARCH  SPA-GMN-W24-SK-TOKKSN-ITM
                   VARYING CMB-IDX02
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-W24-SK-TOKKSN-ITM (CMB-IDX02) (1 : 1)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX02
               MOVE    SPA-GMN-W24-SK-TOKKSN-ITM (CMB-IDX02)
                                   TO  WRK-CMB-ITM
           WHEN    SPA-GMN-W24-SK-TOKKSN-ITM (CMB-IDX02)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-SK-TOKKSN-SRH-EXT.
           EXIT.
      *****************************************************************
      *    食堂加算サーチ処理
      *****************************************************************
       4103-CMB-SK-SYOKUDO-SRH-SEC      SECTION.
      *
           SET     CMB-IDX03       TO  1
           SEARCH  SPA-GMN-W24-SK-SYOKUDO-ITM
                   VARYING CMB-IDX03
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-W24-SK-SYOKUDO-ITM (CMB-IDX03) (1 : 1)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX03
               MOVE    SPA-GMN-W24-SK-SYOKUDO-ITM (CMB-IDX03)
                                   TO  WRK-CMB-ITM
           WHEN    SPA-GMN-W24-SK-SYOKUDO-ITM (CMB-IDX03)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-SK-SYOKUDO-SRH-EXT.
           EXIT.
      *****************************************************************
      *    入院診療計画未実施減算サーチ処理
      *****************************************************************
       4103-CMB-GN-NYUSRY-SRH-SEC      SECTION.
      *
           SET     CMB-IDX04       TO  1
           SEARCH  SPA-GMN-W24-GN-NYUSRY-ITM
                   VARYING CMB-IDX04
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-W24-GN-NYUSRY-ITM (CMB-IDX04) (1 : 1)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX04
               MOVE    SPA-GMN-W24-GN-NYUSRY-ITM (CMB-IDX04)
                                   TO  WRK-CMB-ITM
           WHEN    SPA-GMN-W24-GN-NYUSRY-ITM (CMB-IDX04)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-GN-NYUSRY-SRH-EXT.
           EXIT.
      *****************************************************************
      *    院内感染防止対策未実施減算サーチ処理
      *****************************************************************
       4103-CMB-GN-INKANSEN-SRH-SEC    SECTION.
      *
           SET     CMB-IDX05       TO  1
           SEARCH  SPA-GMN-W24-GN-INKANSEN-ITM
                   VARYING CMB-IDX05
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-W24-GN-INKANSEN-ITM (CMB-IDX05) (1 : 1)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX05
               MOVE    SPA-GMN-W24-GN-INKANSEN-ITM (CMB-IDX05)
                                   TO  WRK-CMB-ITM
           WHEN    SPA-GMN-W24-GN-INKANSEN-ITM (CMB-IDX05)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-GN-INKANSEN-SRH-EXT.
           EXIT.
      *****************************************************************
      *    医療安全管理体制未実施減算サーチ処理
      *****************************************************************
       4103-CMB-GN-ANZEN-SRH-SEC    SECTION.
      *
           SET     CMB-IDX06       TO  1
           SEARCH  SPA-GMN-W24-GN-ANZEN-ITM
                   VARYING CMB-IDX06
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-W24-GN-ANZEN-ITM (CMB-IDX06) (1 : 1)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX06
               MOVE    SPA-GMN-W24-GN-ANZEN-ITM (CMB-IDX06)
                                   TO  WRK-CMB-ITM
           WHEN    SPA-GMN-W24-GN-ANZEN-ITM (CMB-IDX06)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-GN-ANZEN-SRH-EXT.
           EXIT.
      *****************************************************************
      *    褥瘡対策未実施減算サーチ処理
      *****************************************************************
       4103-CMB-GN-JOKUSO-SRH-SEC      SECTION.
      *
           SET     CMB-IDX07       TO  1
           SEARCH  SPA-GMN-W24-GN-JOKUSO-ITM
                   VARYING CMB-IDX07
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-W24-GN-JOKUSO-ITM (CMB-IDX07) (1 : 1)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX07
               MOVE    SPA-GMN-W24-GN-JOKUSO-ITM (CMB-IDX07)
                                   TO  WRK-CMB-ITM
           WHEN    SPA-GMN-W24-GN-JOKUSO-ITM (CMB-IDX07)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-GN-JOKUSO-SRH-EXT.
           EXIT.
      *****************************************************************
      *    地域加算サーチ処理
      *****************************************************************
       4103-CMB-CHIIKIKSN-SRH-SEC      SECTION.
      *
           SET     CMB-IDX08       TO  1
           SEARCH  SPA-GMN-W24-CHIIKIKSN-ITM-OCC
                   VARYING CMB-IDX08
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-W24-CHIIKIKSN-ITM (CMB-IDX08) (1 : 1)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX08
               MOVE    SPA-GMN-W24-CHIIKIKSN-ITM (CMB-IDX08)
                                   TO  WRK-CMB-ITM
           WHEN    SPA-GMN-W24-CHIIKIKSN-ITM (CMB-IDX08)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-CHIIKIKSN-SRH-EXT.
           EXIT.
      *****************************************************************
      *    入力情報領域初期化処理
      *****************************************************************
       4201-INPUT-AREA-CLEAR-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W24-INPUT-AREA
           PERFORM VARYING IDXC    FROM    1   BY  1
                   UNTIL ( IDXC    >   20 )
      *
               MOVE    "F"         TO  SPA-GMN-W24-CHK-NYUKSNFLG (IDXC)
      *
           END-PERFORM
      *
           MOVE    SPA-W01-STYUKYMDH
                                   TO  SPA-GMN-W24-STYUKYMD
           MOVE    SPA-W01-EDYUKYMDH
                                   TO  SPA-GMN-W24-EDYUKYMD
      *
           MOVE    SPA-GMN-W24-SK-TOKKSN-ITM (1)
                                   TO  SPA-GMN-W24-SK-TOKKSN
      *
           MOVE    SPA-GMN-W24-SK-SYOKUDO-ITM (1)
                                   TO  SPA-GMN-W24-SK-SYOKUDO
      *
           MOVE    SPA-GMN-W24-GN-NYUSRY-ITM (1)
                                   TO  SPA-GMN-W24-GN-NYUSRY
      *
           MOVE    SPA-GMN-W24-GN-INKANSEN-ITM (1)
                                   TO  SPA-GMN-W24-GN-INKANSEN
      *
           MOVE    SPA-GMN-W24-GN-ANZEN-ITM (1)
                                   TO  SPA-GMN-W24-GN-ANZEN
      *
           MOVE    SPA-GMN-W24-GN-JOKUSO-ITM (1)
                                   TO  SPA-GMN-W24-GN-JOKUSO
      *
      *    入院加算名称編集処理
           PERFORM 4201-NYUKSNNM-EDIT-SEC
      *
           MOVE    1               TO  SPA-GMN-W24-CUR
      *
           .
      *
       4201-INPUT-AREA-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    入院加算名称編集処理
      *****************************************************************
       4201-NYUKSNNM-EDIT-SEC          SECTION.
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   20 )
                    OR   ( CONST-NYUKSN-SRYCD (IDX1)   =   SPACE )
               MOVE    CONST-NYUKSN-SRYCD (IDX1)
                                   TO  WRK-SRYCD
               PERFORM 4201-TENSU-SEL-SEC
               IF    ( FLG-TENSU   =   ZERO )
      *            MOVE    TNS-SRYCD
      *                            TO  SPA-GMN-W24-NYUKSNSRYCD (IDX1)
                   MOVE    TNS-NAME
                                   TO  SPA-GMN-W24-NYUKSNNM (IDX1)
               END-IF
           END-PERFORM
      *
      *
           .
       4201-NYUKSNNM-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    医療機関情報検索処理
      *****************************************************************
       4201-SYS-1001-SEL-SEC           SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
      *    医療機関情報検索
           INITIALIZE  SYSKANRI-REC
           MOVE    "1001"          TO  SYS-KANRICD
           MOVE    "*"             TO  SYS-KBNCD
           MOVE    SPA-W01-STYUKYMD
                                   TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        NOT =   ZERO )
               MOVE    1           TO  FLG-SYSKANRI
           ELSE
               MOVE    MCPDATA-REC TO  SYS-1001-REC
           END-IF
      *
      *    医療機関情報クローズ
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       4201-SYS-1001-SEL-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索処理
      *****************************************************************
       4201-TENSU-SEL-SEC          SECTION.
      *
           MOVE    ZERO            TO  FLG-TENSU
      *
      *    点数マスタ検索
           INITIALIZE  TNS-TENSU-REC
           MOVE    WRK-SRYCD       TO  TNS-SRYCD
           MOVE    SPA-W01-STYUKYMD
                                   TO  ORC-DBYMD
           MOVE    TNS-TENSU-REC   TO  MCPDATA-REC
           MOVE    "TENSU-KEY" TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    NOT =   ZERO )
               MOVE    1           TO  FLG-TENSU
           ELSE
               MOVE    MCPDATA-REC
                                   TO  TNS-TENSU-REC
           END-IF
      *
      *    点数マスタクローズ
           MOVE    "TENSU-KEY"     TO  ORC-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       4201-TENSU-SEL-EXT.
           EXIT.
      *****************************************************************
      *    共通関連チェック
      *****************************************************************
       4900-KANRENCHK-SEC              SECTION.
      *
      *    急性期病院加算と急性期特定病院加算が
      *    同時に算定されていないこと
           IF    ( SPA-GMN-W24-CHK-NYUKSNFLG (04)  =   "T" )
            AND  ( SPA-GMN-W24-CHK-NYUKSNFLG (05)  =   "T" )
             MOVE    11            TO  SPA-GMN-W24-CUR
             MOVE    "1001"        TO  SPA-ERRCD
             GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    地域医療支援病院入院診療加算１と２が
      *    同時に算定されていないこと
           IF    ( SPA-GMN-W24-CHK-NYUKSNFLG (06)  =   "T" )
            AND  ( SPA-GMN-W24-CHK-NYUKSNFLG (07)  =   "T" )
             MOVE    13            TO  SPA-GMN-W24-CUR
             MOVE    "1002"        TO  SPA-ERRCD
             GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    医療機関情報より病院か診療所を判断し、
      *    乳幼児加算のチェックが妥当であること
           PERFORM 4201-SYS-1001-SEL-SEC
           EVALUATE    SYS-1001-HOSPSBT
           WHEN    "1"
               IF    ( SPA-GMN-W24-CHK-NYUKSNFLG (11)  =   "T" )
                   MOVE    18            TO  SPA-GMN-W24-CUR
                   MOVE    "1003"        TO  SPA-ERRCD
                   GO  TO  4900-KANRENCHK-EXT
               END-IF
      *
               IF    ( SPA-GMN-W24-CHK-NYUKSNFLG (12)  =   "T" )
                   MOVE    19            TO  SPA-GMN-W24-CUR
                   MOVE    "1003"        TO  SPA-ERRCD
                   GO  TO  4900-KANRENCHK-EXT
               END-IF
      *
           WHEN    "2"
               IF    ( SPA-GMN-W24-CHK-NYUKSNFLG (09)  =   "T" )
                   MOVE    16            TO  SPA-GMN-W24-CUR
                   MOVE    "1004"        TO  SPA-ERRCD
                   GO  TO  4900-KANRENCHK-EXT
               END-IF
      *
               IF    ( SPA-GMN-W24-CHK-NYUKSNFLG (10)  =   "T" )
                   MOVE    17            TO  SPA-GMN-W24-CUR
                   MOVE    "1004"        TO  SPA-ERRCD
                   GO  TO  4900-KANRENCHK-EXT
               END-IF
      *
           END-EVALUATE
      *
      *    重複して診療行為コードが設定されていないこと
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   19 )
               IF    ( SPA-GMN-W24-SRYCD (IDX1)    NOT =   SPACE )
                   COMPUTE IDX3    =   IDX1    +   1
                   PERFORM VARYING IDX2    FROM    20      BY  -1
                           UNTIL ( IDX2    <   IDX3 )
                       IF    ( SPA-GMN-W24-SRYCD (IDX1)
                                           = SPA-GMN-W24-SRYCD (IDX2))
                           COMPUTE SPA-GMN-W24-CUR =   IDX2    +   28
                           MOVE    "1005"  TO  SPA-ERRCD
                           GO  TO  4900-KANRENCHK-EXT
                       END-IF
                   END-PERFORM
               END-IF
           END-PERFORM
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
           MOVE    "W24    "           TO  MCP-WINDOW.
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
           MOVE    SPA-GMN-W24-STYUKYMD
                                   TO  W24-STYUKYMD
      *    有効終了日
           MOVE    SPA-GMN-W24-EDYUKYMD
                                   TO  W24-EDYUKYMD
      *    入院時食事療養
           MOVE    SPA-GMN-W24-SK-NYUSYOKU
                                   TO  W24-SK-NYUSYOKU
           MOVE    SPA-GMN-W24-SK-NYUSYOKU-CNT
                                   TO  W24-SK-NYUSYOKU-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   W24-SK-NYUSYOKU-CNT )
      *
               MOVE    SPA-GMN-W24-SK-NYUSYOKU-ITM (IDX1)
                                   TO  W24-SK-NYUSYOKU-ITM (IDX1)
      *
           END-PERFORM
      *
      *    特別管理加算
           MOVE    SPA-GMN-W24-SK-TOKKSN
                                   TO  W24-SK-TOKKSN
           MOVE    SPA-GMN-W24-SK-TOKKSN-CNT
                                   TO  W24-SK-TOKKSN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   W24-SK-TOKKSN-CNT )
      *
               MOVE    SPA-GMN-W24-SK-TOKKSN-ITM (IDX1)
                                   TO  W24-SK-TOKKSN-ITM (IDX1)
      *
           END-PERFORM
      *
      *    食堂加算
           MOVE    SPA-GMN-W24-SK-SYOKUDO
                                   TO  W24-SK-SYOKUDO
           MOVE    SPA-GMN-W24-SK-SYOKUDO-CNT
                                   TO  W24-SK-SYOKUDO-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   W24-SK-SYOKUDO-CNT )
      *
               MOVE    SPA-GMN-W24-SK-SYOKUDO-ITM (IDX1)
                                   TO  W24-SK-SYOKUDO-ITM (IDX1)
      *
           END-PERFORM
      *
      *    入院診療計画未実施減算
           MOVE    SPA-GMN-W24-GN-NYUSRY
                                   TO  W24-GN-NYUSRY
           MOVE    SPA-GMN-W24-GN-NYUSRY-CNT
                                   TO  W24-GN-NYUSRY-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   W24-GN-NYUSRY-CNT )
      *
               MOVE    SPA-GMN-W24-GN-NYUSRY-ITM (IDX1)
                                   TO  W24-GN-NYUSRY-ITM (IDX1)
      *
           END-PERFORM
      *
      *    院内感染防止対策未実施減算
           MOVE    SPA-GMN-W24-GN-INKANSEN
                                   TO  W24-GN-INKANSEN
           MOVE    SPA-GMN-W24-GN-INKANSEN-CNT
                                   TO  W24-GN-INKANSEN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   W24-GN-INKANSEN-CNT )
      *
               MOVE    SPA-GMN-W24-GN-INKANSEN-ITM (IDX1)
                                   TO  W24-GN-INKANSEN-ITM (IDX1)
      *
           END-PERFORM
      *
      *    医療安全管理体制未実施減算
           MOVE    SPA-GMN-W24-GN-ANZEN
                                   TO  W24-GN-ANZEN
           MOVE    SPA-GMN-W24-GN-ANZEN-CNT
                                   TO  W24-GN-ANZEN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   W24-GN-ANZEN-CNT )
      *
               MOVE    SPA-GMN-W24-GN-ANZEN-ITM (IDX1)
                                   TO  W24-GN-ANZEN-ITM (IDX1)
      *
           END-PERFORM
      *
      *    褥瘡対策未実施減算
           MOVE    SPA-GMN-W24-GN-JOKUSO
                                   TO  W24-GN-JOKUSO
           MOVE    SPA-GMN-W24-GN-JOKUSO-CNT
                                   TO  W24-GN-JOKUSO-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   W24-GN-JOKUSO-CNT )
      *
               MOVE    SPA-GMN-W24-GN-JOKUSO-ITM (IDX1)
                                   TO  W24-GN-JOKUSO-ITM (IDX1)
      *
           END-PERFORM
      *
      *    入院加算情報
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   20 )
               MOVE    SPA-GMN-W24-NYUKSNNM (IDX1)
                                   TO  W24-NYUKSNNM (IDX1)
               MOVE    SPA-GMN-W24-CHK-NYUKSNFLG (IDX1)
                                   TO  W24-CHK-NYUKSNFLG (IDX1)
               MOVE    SPA-GMN-W24-CHK-NYUKSNNM (IDX1)
                                   TO  W24-CHK-NYUKSNNM (IDX1)
           END-PERFORM
      *
      *    入院会計表示情報
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   10 )
               MOVE    SPA-GMN-W24-SRYCD (IDX1)
                                   TO  W24-SRYCD (IDX1)
               MOVE    SPA-GMN-W24-SRYACT (IDX1)
                                   TO  W24-SRYACT (IDX1)
           END-PERFORM
      *
      *    地域加算
           MOVE    SPA-GMN-W24-CHIIKIKSN
                                   TO  W24-CHIIKIKSN
           MOVE    SPA-GMN-W24-CHIIKIKSN-CNT
                                   TO  W24-CHIIKIKSN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   W24-CHIIKIKSN-CNT )
      *
               MOVE    SPA-GMN-W24-CHIIKIKSN-ITM (IDX1)
                                   TO  W24-CHIIKIKSN-ITM (IDX1)
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
                  (SPA-GMN-W24-CUR     =   ZERO )
               PERFORM 5011-INPUT-CUR-SEC
           END-IF
      *
           EVALUATE    SPA-GMN-W24-CUR
           WHEN    001
               MOVE    "SK_NYUSYOKU"   TO  MCP-WIDGET
           WHEN    002
               MOVE    "SK_TOKKSN"     TO  MCP-WIDGET
           WHEN    003
               MOVE    "SK_SYOKUDO"    TO  MCP-WIDGET
           WHEN    004
               MOVE    "GN_NYUSRY"     TO  MCP-WIDGET
           WHEN    005
               MOVE    "GN_INKANSEN"   TO  MCP-WIDGET
           WHEN    006
               MOVE    "GN_ANZEN"      TO  MCP-WIDGET
           WHEN    007
               MOVE    "GN_JOKUSO"     TO  MCP-WIDGET
           WHEN    008
               MOVE    "CHK_NYUKSN01"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (1)    =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    009
               MOVE    "CHK_NYUKSN02"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (2)    =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    010
               MOVE    "CHK_NYUKSN03"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (3)    =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    011
               MOVE    "CHK_NYUKSN04"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (4)    =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    012
               MOVE    "CHK_NYUKSN05"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (5)    =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    013
               MOVE    "CHK_NYUKSN06"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (6)    =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    014
               MOVE    "CHK_NYUKSN07"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (7)    =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    015
               MOVE    "CHK_NYUKSN08"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (8)    =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    016
               MOVE    "CHK_NYUKSN09"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (9)    =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    017
               MOVE    "CHK_NYUKSN10"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (10)   =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    018
               MOVE    "CHK_NYUKSN11"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (11)   =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    019
               MOVE    "CHK_NYUKSN12"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (12)   =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    020
               MOVE    "CHK_NYUKSN13"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (13)   =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    021
               MOVE    "CHK_NYUKSN14"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (14)   =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    022
               MOVE    "CHK_NYUKSN15"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (15)   =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    023
               MOVE    "CHK_NYUKSN16"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (16)   =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    024
               MOVE    "CHK_NYUKSN17"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (17)   =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    025
               MOVE    "CHK_NYUKSN18"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (18)   =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    026
               MOVE    "CHK_NYUKSN19"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (19)   =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    027
               MOVE    "CHK_NYUKSN20"  TO  MCP-WIDGET
               IF    ( SPA-GMN-W24-NYUKSNNM (20)   =   SPACE )
                   MOVE    "CHIIKIKSN" TO  MCP-WIDGET
               END-IF
           WHEN    028
               MOVE    "CHIIKIKSN"     TO  MCP-WIDGET
           WHEN    029
               MOVE    "SRYCD01"       TO  MCP-WIDGET
           WHEN    030
               MOVE    "SRYCD02"       TO  MCP-WIDGET
           WHEN    031
               MOVE    "SRYCD03"       TO  MCP-WIDGET
           WHEN    032
               MOVE    "SRYCD04"       TO  MCP-WIDGET
           WHEN    033
               MOVE    "SRYCD05"       TO  MCP-WIDGET
           WHEN    034
               MOVE    "SRYCD06"       TO  MCP-WIDGET
           WHEN    035
               MOVE    "SRYCD07"       TO  MCP-WIDGET
           WHEN    036
               MOVE    "SRYCD08"       TO  MCP-WIDGET
           WHEN    037
               MOVE    "SRYCD09"       TO  MCP-WIDGET
           WHEN    038
               MOVE    "SRYCD10"       TO  MCP-WIDGET
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
           EVALUATE    MCP-WIDGET
           WHEN    "SK_NYUSYOKU"
               MOVE    001             TO  SPA-GMN-W24-CUR
           WHEN    "SK_TOKKSN"
               MOVE    002             TO  SPA-GMN-W24-CUR
           WHEN    "SK_SYOKUDO"
               MOVE    003             TO  SPA-GMN-W24-CUR
           WHEN    "GN_NYUSRY"
               MOVE    004             TO  SPA-GMN-W24-CUR
           WHEN    "GN_INKANSEN"
               MOVE    005             TO  SPA-GMN-W24-CUR
           WHEN    "GN_ANZEN"
               MOVE    006             TO  SPA-GMN-W24-CUR
           WHEN    "GN_JOKUSO"
               MOVE    007             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN01"
               MOVE    008             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN02"
               MOVE    009             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN03"
               MOVE    010             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN04"
               MOVE    011             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN05"
               MOVE    012             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN06"
               MOVE    013             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN07"
               MOVE    014             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN08"
               MOVE    015             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN09"
               MOVE    016             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN10"
               MOVE    017             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN11"
               MOVE    018             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN12"
               MOVE    019             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN13"
               MOVE    020             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN14"
               MOVE    021             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN15"
               MOVE    022             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN16"
               MOVE    023             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN17"
               MOVE    024             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN18"
               MOVE    025             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN19"
               MOVE    026             TO  SPA-GMN-W24-CUR
           WHEN    "CHK_NYUKSN20"
               MOVE    027             TO  SPA-GMN-W24-CUR
           WHEN    "CHIIKIKSN"
               MOVE    028             TO  SPA-GMN-W24-CUR
           WHEN    "SRYCD01"
               MOVE    029             TO  SPA-GMN-W24-CUR
           WHEN    "SRYCD02"
               MOVE    030             TO  SPA-GMN-W24-CUR
           WHEN    "SRYCD03"
               MOVE    031             TO  SPA-GMN-W24-CUR
           WHEN    "SRYCD04"
               MOVE    032             TO  SPA-GMN-W24-CUR
           WHEN    "SRYCD05"
               MOVE    033             TO  SPA-GMN-W24-CUR
           WHEN    "SRYCD06"
               MOVE    034             TO  SPA-GMN-W24-CUR
           WHEN    "SRYCD07"
               MOVE    035             TO  SPA-GMN-W24-CUR
           WHEN    "SRYCD08"
               MOVE    036             TO  SPA-GMN-W24-CUR
           WHEN    "SRYCD09"
               MOVE    037             TO  SPA-GMN-W24-CUR
           WHEN    "SRYCD10"
               MOVE    038             TO  SPA-GMN-W24-CUR
           END-EVALUATE
      *
      *    次カーソル位置を設定
           EVALUATE    MCP-WIDGET
           WHEN    "SRYCD10"
               MOVE    212             TO  SPA-GMN-W24-CUR
           WHEN    OTHER
               COMPUTE SPA-GMN-W24-CUR =   SPA-GMN-W24-CUR
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
               MOVE    "該当の診療コードは存在しません"
                                       TO  SPA-ERRMSG
           WHEN    "0003"
               MOVE    "診療コード入力規則にあっていません"
                                       TO  SPA-ERRMSG
           WHEN    "0004"
               MOVE    "加算に必要な施設基準が設定されていません"
                                       TO  SPA-ERRMSG
           WHEN    "1001"
               MOVE    "急性期病院加算と急性期特定病院加算は同時"
                                       TO  SPA-ERRMSG (1 : 40)
               MOVE    "に加算できません"
                                       TO  SPA-ERRMSG (41 : )
           WHEN    "1002"
               MOVE    "地域医療支援病院入院診療加算１と２は同時"
                                       TO  SPA-ERRMSG (1 : 40)
               MOVE    "に加算できません"
                                       TO  SPA-ERRMSG (41 : )
           WHEN    "1003"
               MOVE    "診療所に関する加算は行えません"
                                       TO  SPA-ERRMSG
           WHEN    "1004"
               MOVE    "病院に関する加算は行えません"
                                       TO  SPA-ERRMSG
           WHEN    "1005"
               MOVE    "同じ診療行為が重複して設定されています"
                                       TO  SPA-ERRMSG
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
           MOVE    "W24"               TO  SPA-MOTOPG
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
           MOVE    "W24"                TO  SPA-MOTOPG
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

