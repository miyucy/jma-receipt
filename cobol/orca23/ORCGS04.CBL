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
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCGS04.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 収納登録
      *  コンポーネント名  : 支払証明書発行（Ｓ０４）
      *  管理者            : 
      *  02/12/19    NACL−森脇   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.01.01     NACL-森脇    04/11/15  設定画面変更
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                        DIVISION.
      *FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    診療行為用共通パラメタ
           COPY    "S01COMMON-SPA".
      *
      *    支払証明書パラメータ
           COPY    "CPORCHCM31.INC".
      *
      *    画面活性非活性
           COPY    "ENUM-VALUE".
      *
      *    スパ領域
       01  SPA-S04.
           03  SPA-GMN-CUR                 PIC 9(03).
           03  SPA-GMN-AREA.
               05  SPA-GMN-PTNUM           PIC X(20).
               05  SPA-GMN-NAME            PIC X(100).
               05  SPA-GMN-KIKANKBN-G.
                   07  SPA-GMN-KIKANKBN    PIC X(01).
                   07  FILLER              PIC X(01).
                   07  SPA-GMN-KIKANMEI    PIC X(08).
               05  SPA-GMN-KKNKBN          PIC X       OCCURS  2.
               05  SPA-GMN-STRSRYYMD       PIC X(10).
               05  SPA-GMN-ENDSRYYMD       PIC X(10).
               05  SPA-GMN-SYORIKBN-G.
                   07  SPA-GMN-SYORIKBN    PIC X(01).
                   07  FILLER              PIC X(01).
                   07  SPA-GMN-SYORIMEI    PIC X(16).
               05  SPA-GMN-DSPKBN-G.
                   07  SPA-GMN-DSPKBN      PIC X(01).
                   07  FILLER              PIC X(01).
                   07  SPA-GMN-DSPMEI      PIC X(10).
               05  SPA-GMN-PRTKBN          PIC X       OCCURS  2.
      *
               05  SPA-GMN-KIKANLIST-G.
                   07  SPA-GMN-KIKANLIST-MAX   PIC 9(05).
                   07  SPA-GMN-KIKANLIST               OCCURS  2.
                       09  SPA-GMN-KIKANKBNL   PIC X(01).
                       09  FILLER              PIC X(01).
                       09  SPA-GMN-KIKANMEIL   PIC X(08).
      *
               05  SPA-GMN-SYORILIST-G.
                   07  SPA-GMN-SYORILIST-MAX   PIC 9(05).
                   07  SPA-GMN-SYORILIST               OCCURS  2.
                       09  SPA-GMN-SYORIKBNL   PIC X(01).
                       09  FILLER              PIC X(01).
                       09  SPA-GMN-SYORIMEIL   PIC X(16).
      *
               05  SPA-GMN-DSPLIST-G.
                   07  SPA-GMN-DSPLIST-MAX     PIC 9(05).
                   07  SPA-GMN-DSPLIST                 OCCURS  2.
                       09  SPA-GMN-DSPKBNL     PIC X(01).
                       09  FILLER              PIC X(01).
                       09  SPA-GMN-DSPMEIL     PIC X(10).
      *
           03  SPA-NAI-AREA.
               05  SPA-NAI-STRSRYYMD.
                   07  SPA-NAI-STRYY       PIC 9(04).
                   07  SPA-NAI-STRMM       PIC 9(02).
                   07  SPA-NAI-STRDD       PIC 9(02).
               05  SPA-NAI-ENDSRYYMD.
                   07  SPA-NAI-ENDYY       PIC 9(04).
                   07  SPA-NAI-ENDMM       PIC 9(02).
                   07  SPA-NAI-ENDDD       PIC 9(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-OK              PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(05).
      *
      *    作業領域
       01  WRK-AREA.
           03  WRK-MCP-WIDGET      PIC X(64).
           03  WRK-LNKYMD          PIC X(10).
           03  WRK-SRYYMD          PIC X(10).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-YMD.
               05  WRK-YY          PIC S9(04).
               05  WRK-MM          PIC S9(02).
      *
           03  WRK-SYORI-PG        PIC X(20).
           03  WRK-SIDMSG          PIC X(70).
           03  WRK-ERRMSG          PIC X(80).
      *
       01  CONST-AREA.
      *
      *    システム管理ＤＢ（３００３）のキー値
           03  CONST-3003-KBNCD            PIC X(08)   VALUE "023".
      *
      *    印刷管理ＤＢのキー値
           03  CONST-PRTKANRI-TBL-KEY      PIC X(08)   VALUE "ORCBS01".
           03  CONST-PRTKANRI-TBL-GROUP    PIC X(14)   VALUE SPACE.
      *
      *    ジョブ管理ＤＢのキー値
           03  CONST-JOB-SHELLID           PIC X(08)   VALUE "ORCBS01".
           03  CONST-JOB-JOBID             PIC 9(07)   VALUE ZERO.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
           COPY    "CPSK3003.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "ORCA-DBPATH".
      *
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "S02.INC".
           COPY    "S03.INC".
           COPY    "S03N.INC".
           COPY    "S04.INC".
           COPY    "S05.INC".
           COPY    "S06.INC".
           COPY    "S99.INC".
           COPY    "SERR.INC".
           COPY    "SID1.INC".
           COPY    "SID2.INC".
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
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-S01KYOUTU
           MOVE    SPA-FREE        TO  SPA-S04
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS  ALSO    MCP-EVENT
               WHEN    "LINK"      ALSO    ANY
                   PERFORM 100-INIT-SEC
      *        画面遷移
               WHEN     "PUTG"     ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *        入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-S01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-S04         TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "SERR"
               MOVE    SPACE           TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF    ( FLG-END         =   1 )
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE           TO  LINKAREA
      *
           MOVE    SPACE           TO  MCP-PUTTYPE.
           MOVE    "S04    "       TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1               TO  FLG-END
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                 SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
      *
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *    戻る
           WHEN    "CLICKED"   ALSO    "B01"
      *
               INITIALIZE              SPA-S01-SHIHARAI-PARA
               PERFORM 210-BACK
      *    登録
           WHEN    "CLICKED"   ALSO    "B12"
               PERFORM 410-PRINT-MAE-CHK-SEC
      *    期間選択
           WHEN    "CLICKED"   ALSO    "KKNKBN1" 
           WHEN    "CLICKED"   ALSO    "KKNKBN2" 
               PERFORM 400-KKNKBN-SET-SEC
      *    帳票選択
           WHEN    "CLICKED"   ALSO    "PRTKBN1" 
           WHEN    "CLICKED"   ALSO    "PRTKBN2" 
               MOVE    ZERO            TO  SPA-GMN-CUR
               MOVE    S04-PRTKBN(1)   TO  SPA-GMN-PRTKBN(1)
               MOVE    S04-PRTKBN(2)   TO  SPA-GMN-PRTKBN(2)
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
      *
      *    入力個所のセット
           PERFORM 400-GMN-INPUT-SEC
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       400-GMN-INPUT-SEC          SECTION.
      *
           MOVE    ZERO            TO  SPA-GMN-CUR
      *
           .
      *
       400-GMN-INPUT-EXT.
           EXIT.
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC          SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
      *    期間区分
           PERFORM 4001-KIKANKBN-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  410-INPUT-CHK-EXT
           END-IF
      *
      *    期間開始日付
           PERFORM 4001-STRSRYYMD-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  410-INPUT-CHK-EXT
           END-IF
      *
      *    期間終了日付
           IF    ( SPA-GMN-KKNKBN(1)   =   "T" )
               PERFORM 4001-ENDSRYYMD-SEC
               IF    ( SPA-ERRCD       NOT =   SPACE )
                   GO  TO  410-INPUT-CHK-EXT
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-KIKANKBN    =   "1" )
      *
      *        処理区分
               PERFORM 4001-SYORIKBN-SEC
               IF    ( SPA-ERRCD       NOT =   SPACE )
                   GO  TO  410-INPUT-CHK-EXT
               END-IF
      *
      *        印字区分
               PERFORM 4001-DSPKBN-SEC
               IF    ( SPA-ERRCD       NOT =   SPACE )
                   GO  TO  410-INPUT-CHK-EXT
               END-IF
           END-IF
      *
           .
      *
       410-INPUT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    画面ＳＰＡセット処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC            SECTION.
      *
           MOVE    S04-STRSRYYMD   TO  SPA-GMN-STRSRYYMD
           MOVE    S04-ENDSRYYMD   TO  SPA-GMN-ENDSRYYMD
           MOVE    S04-SYORIKBN    TO  SPA-GMN-SYORIKBN-G
           MOVE    S04-KIKANKBN    TO  SPA-GMN-KIKANKBN-G
           MOVE    S04-DSPKBN      TO  SPA-GMN-DSPKBN-G
      *
           .
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "B01"           TO  MCP-WIDGET
      *
           MOVE    "S02"           TO  SPA-SAKIPG
           MOVE    "S04"           TO  SPA-MOTOPG
      *
           MOVE    SPACE           TO  LINKAREA
      *
           MOVE   "JOIN"           TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG      TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1               TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *************************************************************
      *    初期画面処理
      *************************************************************
       300-SCREEN-SEC              SECTION.
      *
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU      TO  SPA-KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG
           WHEN    "SID2"
               PERFORM 330-SID2-SET-SEC
               GO  TO  300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM 310-SPASET-SEC
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
     *****************************************************************
      *    確認画面（ＳＩＤ２）ＯＫ処理
      *****************************************************************
       330-SID2-SET-SEC            SECTION.
      *
      *
           IF      SPA-SID1-FLG    =   "OK" OR "NO"
               IF      SPA-SIDCD   =   "1001"
                   PERFORM 4900-JOBKANRICHK-SEC
                   IF    ( SPA-ERRCD   =    SPACE )
                       PERFORM 400-PRINT-SEC
                   END-IF
               END-IF
           END-IF
      *
           MOVE    SPACE           TO  SPA-SID1-FLG
           MOVE    SPACE           TO  SPA-SIDCD
      *
           .
       330-SID2-SET-EXT.
           EXIT.
      *
      *************************************************************
      *    画面編集処理
      *************************************************************
       310-SPASET-SEC              SECTION.
      *
           INITIALIZE                  SPA-GMN-AREA
      *
           PERFORM 3101-COMBO-SYOKI-SEC
      *
           MOVE    SPA-S01-PTNUM   TO  SPA-GMN-PTNUM
           MOVE    SPA-S01-NAME    TO  SPA-GMN-NAME
           MOVE    "T"             TO  SPA-GMN-KKNKBN(1)
           MOVE    "F"             TO  SPA-GMN-KKNKBN(2)
           MOVE    "T"             TO  SPA-GMN-PRTKBN(1)
           MOVE    "F"             TO  SPA-GMN-PRTKBN(2)
      *
           MOVE    SPA-SYSYMDWH    TO  SPA-GMN-STRSRYYMD
           MOVE    SPA-SYSYMD      TO  SPA-NAI-STRSRYYMD
           MOVE    SPA-SYSYMDWH    TO  SPA-GMN-ENDSRYYMD
           MOVE    SPA-SYSYMD      TO  SPA-NAI-ENDSRYYMD
      *
           MOVE    SPA-GMN-KIKANLIST(1)
                                   TO  SPA-GMN-KIKANKBN-G
           MOVE    SPA-GMN-SYORILIST(1)
                                   TO  SPA-GMN-SYORIKBN-G
           MOVE    SPA-GMN-DSPLIST(1)
                                   TO  SPA-GMN-DSPKBN-G
      *
           MOVE    1               TO  SPA-GMN-CUR
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *************************************************************
      *    コンボ初期処理
      *************************************************************
       3101-COMBO-SYOKI-SEC            SECTION.
      *
           PERFORM 3101-KIKANLIST-SET-SEC
      *
           PERFORM 3101-SYORILIST-SET-SEC
      *
           PERFORM 3101-DSPLIST-SET-SEC
      *
           .
       3101-COMBO-SYOKI-EXT.
           EXIT.
      *************************************************************
      *    期間指定コンボ設定処理
      *************************************************************
       3101-KIKANLIST-SET-SEC          SECTION.
      *
           INITIALIZE                  SPA-GMN-KIKANLIST-G
      *
           MOVE    "1 診療期間"    TO  SPA-GMN-KIKANLIST(1)
           MOVE    "2 支払期間"    TO  SPA-GMN-KIKANLIST(2)
      *
           MOVE    2               TO  SPA-GMN-KIKANLIST-MAX
      *
           .
       3101-KIKANLIST-SET-EXT.
           EXIT.
      *************************************************************
      *    処理区分設定処理
      *************************************************************
       3101-SYORILIST-SET-SEC          SECTION.
      *
           INITIALIZE                  SPA-GMN-SYORILIST-G
      *
           MOVE    "1 支払額に含める"
                                   TO  SPA-GMN-SYORILIST(1)
      *
           MOVE    "2 支払額に含めない"
                                   TO  SPA-GMN-SYORILIST(2)
      *
           MOVE    2               TO  SPA-GMN-SYORILIST-MAX
      *
           .
       3101-SYORILIST-SET-EXT.
           EXIT.
      *************************************************************
      *    印字区分設定処理
      *************************************************************
       3101-DSPLIST-SET-SEC            SECTION.
      *
           INITIALIZE                  SPA-GMN-DSPLIST-G
      *
           MOVE    "1 印字する"    TO  SPA-GMN-DSPLIST(1)
           MOVE    "2 印字しない"  TO  SPA-GMN-DSPLIST(2)
      *
           MOVE    2               TO  SPA-GMN-DSPLIST-MAX
      *
           .
       3101-DSPLIST-SET-EXT.
           EXIT.
      *****************************************************************
      *    期間指定初期値
      *****************************************************************
       400-KKNKBN-SET-SEC          SECTION.
      *
           MOVE    ZERO            TO  SPA-GMN-CUR
      *
           MOVE    S04-KKNKBN(1)   TO  SPA-GMN-KKNKBN(1)
           MOVE    S04-KKNKBN(2)   TO  SPA-GMN-KKNKBN(2)
      *
           MOVE    SPACE           TO  SPA-NAI-STRSRYYMD
                                       SPA-NAI-ENDSRYYMD
                                       SPA-GMN-STRSRYYMD
                                       SPA-GMN-ENDSRYYMD
                                       WRK-SRYYMD
      *
           IF      SPA-GMN-KKNKBN(1)   =   "T"
               MOVE    SPA-SYSYMDWH    TO  SPA-GMN-STRSRYYMD
               MOVE    SPA-SYSYMD      TO  SPA-NAI-STRSRYYMD
               MOVE    SPA-SYSYMDWH    TO  SPA-GMN-ENDSRYYMD
               MOVE    SPA-SYSYMD      TO  SPA-NAI-ENDSRYYMD
           END-IF
      *
           IF      SPA-GMN-KKNKBN(2)   =   "T"
               MOVE    SPA-SYSYMDWH (1:3)
                                       TO  SPA-GMN-STRSRYYMD
               MOVE    SPA-SYSYMD   (1:4)
                                       TO  SPA-NAI-STRSRYYMD
           END-IF
      *
           .
       400-KKNKBN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    開始診療年月日
      *****************************************************************
       4001-STRSRYYMD-SEC          SECTION.
      *
           MOVE    SPACE           TO  SPA-NAI-STRSRYYMD
      *
           IF    ( SPA-GMN-STRSRYYMD   =   SPACE )
      *
               MOVE    SPACE       TO  SPA-GMN-STRSRYYMD
                                       SPA-NAI-STRSRYYMD
      *
               IF    ( SPA-GMN-KKNKBN(1)   =   "T" )
      *
                   MOVE    SPA-SYSYMDWH    TO  SPA-GMN-STRSRYYMD
                   MOVE    SPA-SYSYMD      TO  SPA-NAI-STRSRYYMD
               END-IF
      *
               IF    ( SPA-GMN-KKNKBN(2)   =   "T" )
                   MOVE    SPA-SYSYMDWH (1:3)
                                           TO  SPA-GMN-STRSRYYMD
                   MOVE    SPA-SYSYMD   (1:4)
                                           TO  SPA-NAI-STRSRYYMD
               END-IF
      *
               GO  TO  4001-STRSRYYMD-EXT
      *
           END-IF
      *
           MOVE    SPA-GMN-STRSRYYMD   TO  WRK-LNKYMD
           PERFORM 800-ORCSGDAY-SEC
           IF    ( SPA-ERRCD           =   SPACE )
               IF    ( SPA-GMN-KKNKBN(1)   =   "T" )
      *
                   IF    ( WRK-SYMD (8:1)  =   SPACE )
                       MOVE    "0002"      TO  SPA-ERRCD
                       MOVE    4           TO  SPA-GMN-CUR
                   ELSE
                       MOVE    WRK-LNKYMD  TO  SPA-GMN-STRSRYYMD
                       MOVE    WRK-SYMD    TO  SPA-NAI-STRSRYYMD
                   END-IF
      *
               END-IF
      *
               IF    ( SPA-GMN-KKNKBN(2)   =   "T" )
                   MOVE    WRK-LNKYMD (1:3)
                                           TO  SPA-GMN-STRSRYYMD
                   MOVE    WRK-SYMD (1:4)  TO  SPA-NAI-STRSRYYMD
               END-IF
           ELSE
               MOVE    4               TO  SPA-GMN-CUR
           END-IF
      *
           .
       4001-STRSRYYMD-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了診療年月日
      *****************************************************************
       4001-ENDSRYYMD-SEC              SECTION.
      *
           MOVE    SPACE           TO  SPA-NAI-ENDSRYYMD
      *
           IF    ( SPA-GMN-ENDSRYYMD   =   SPACE )
      *
               MOVE    SPA-SYSYMDWH    TO  SPA-GMN-ENDSRYYMD
               MOVE    SPA-SYSYMD      TO  SPA-NAI-ENDSRYYMD
      *
               GO  TO  4001-ENDSRYYMD-EXT
           END-IF
      *
           MOVE    SPA-GMN-ENDSRYYMD   TO  WRK-LNKYMD
           PERFORM 831-YMDCONV12-SEC
           IF    ( SPA-ERRCD           =   SPACE )
               MOVE    WRK-LNKYMD  TO  SPA-GMN-ENDSRYYMD
               MOVE    WRK-SYMD    TO  SPA-NAI-ENDSRYYMD
           ELSE
               MOVE    "0003"      TO  SPA-ERRCD
               MOVE    5           TO  SPA-GMN-CUR
           END-IF
      *
           .
       4001-ENDSRYYMD-EXT.
           EXIT.
      *
      *****************************************************************
      *    期間区分
      *****************************************************************
       4001-KIKANKBN-SEC               SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
      *
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL ( IDX     >   SPA-GMN-KIKANLIST-MAX )
                    OR   ( FLG-OK  NOT =   ZERO )
      *
               IF    ( SPA-GMN-KIKANKBN   =   SPA-GMN-KIKANKBNL(IDX) )
                   MOVE    SPA-GMN-KIKANLIST(IDX) TO  SPA-GMN-KIKANKBN-G
                   MOVE    1                      TO  FLG-OK
               END-IF
      *
           END-PERFORM
      *
           IF    ( FLG-OK          =   ZERO )
               MOVE    "0001"          TO  SPA-ERRCD
               MOVE    1               TO  SPA-GMN-CUR
           END-IF
      *
           IF    ( SPA-GMN-KIKANKBN    =   "2" )
               MOVE    SPACE           TO  SPA-GMN-SYORIKBN-G
               MOVE    SPA-GMN-DSPLIST(2)
                                       TO  SPA-GMN-DSPKBN-G
           ELSE
               IF    ( SPA-GMN-SYORIKBN-G  =   SPACE )
                   MOVE    SPA-GMN-DSPLIST(1)
                                       TO  SPA-GMN-DSPKBN-G
                   MOVE    SPA-GMN-SYORILIST (1)
                                       TO  SPA-GMN-SYORIKBN-G
               END-IF
           END-IF
      *
           .
       4001-KIKANKBN-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理区分
      *****************************************************************
       4001-SYORIKBN-SEC               SECTION.
      *
           MOVE    ZERO            TO  FLG-OK
      *
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL ( IDX     >   SPA-GMN-SYORILIST-MAX )
                    OR   ( FLG-OK  NOT =   ZERO )
      *
               IF    ( SPA-GMN-SYORIKBN    =   SPA-GMN-SYORIKBNL(IDX) )
                   MOVE    SPA-GMN-SYORILIST(IDX)
                                       TO  SPA-GMN-SYORIKBN-G
                   MOVE    1           TO  FLG-OK
               END-IF
      *
           END-PERFORM
      *
           IF    ( FLG-OK          =   ZERO )
               MOVE    "0004"          TO  SPA-ERRCD
               MOVE    6               TO  SPA-GMN-CUR
           END-IF
      *
           .
       400-SYORIKBN-EXT.
           EXIT.
      *
      *****************************************************************
      *    印字区分
      *****************************************************************
       4001-DSPKBN-SEC                 SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
      *
           PERFORM VARYING IDX     FROM   1   BY  1
                   UNTIL ( IDX     >   SPA-GMN-DSPLIST-MAX )
                    OR   ( FLG-OK  NOT =   ZERO )
      *
               IF    ( SPA-GMN-DSPKBN  =   SPA-GMN-DSPKBNL(IDX) )
                   MOVE    SPA-GMN-DSPLIST(IDX)   TO  SPA-GMN-DSPKBN-G
                   MOVE    1                      TO  FLG-OK
               END-IF
           END-PERFORM
      *
           IF    ( FLG-OK          =   ZERO )
               MOVE    "0005"          TO  SPA-ERRCD
               MOVE    7               TO  SPA-GMN-CUR
           END-IF
      *
           .
       4001-DSPKBN-EXT.
           EXIT.
      *
     *****************************************************************
      *    印刷前チェック
      *****************************************************************
       410-PRINT-MAE-CHK-SEC       SECTION.
      *
           PERFORM 410-INPUT-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  410-PRINT-MAE-CHK-EXT
           END-IF
      *
      *    期間範囲大小チェック
           IF    ( SPA-GMN-KKNKBN(1)       =   "T" )
               IF    ( SPA-NAI-STRSRYYMD   >   SPA-NAI-ENDSRYYMD )
                   MOVE    "0006"          TO  SPA-ERRCD
                   MOVE    5               TO  SPA-GMN-CUR
                   GO  TO  410-PRINT-MAE-CHK-EXT
               END-IF
      *
      *        一年オーバーチェック
               COMPUTE WRK-YY      =   SPA-NAI-ENDYY   -   SPA-NAI-STRYY
               COMPUTE WRK-MM      =   SPA-NAI-ENDMM   -   SPA-NAI-STRMM
      *
               IF    ( WRK-YY          <=  1 )
                   IF    ( WRK-YY      =   1 ) AND   ( WRK-MM  >=  0 )
                       MOVE    "0007"      TO  SPA-ERRCD
                       MOVE    5           TO  SPA-GMN-CUR
                       GO  TO  410-PRINT-MAE-CHK-EXT
                   END-IF
               ELSE
                   MOVE    "0007"          TO  SPA-ERRCD
                   MOVE    5               TO  SPA-GMN-CUR
                   GO  TO  410-PRINT-MAE-CHK-EXT
               END-IF
           END-IF
      *
           PERFORM 4900-JOBKANRICHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  410-PRINT-MAE-CHK-EXT
           END-IF
      *
           MOVE    "1001"              TO  SPA-SIDCD
      *
           .
       410-PRINT-MAE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷処理
      *****************************************************************
       400-PRINT-SEC               SECTION.
      *
           INITIALIZE                  SPA-S01-SHIHARAI-PARA
      *
           MOVE    SPA-SID1-FLG        TO  SPA-S01-SHR-ORDER
      *
           MOVE    SPA-GMN-KIKANKBN    TO  SPA-S01-SHR-KIKANKBN
           MOVE    SPA-GMN-SYORIKBN    TO  SPA-S01-SHR-SYORIKBN
           MOVE    SPA-GMN-DSPKBN      TO  SPA-S01-SHR-DSPKBN
      *
           IF    ( SPA-GMN-KKNKBN(1)   =  "T" )
               MOVE    SPA-NAI-STRSRYYMD
                                       TO  SPA-S01-SHR-STYMD
               MOVE    SPA-NAI-ENDSRYYMD
                                       TO  SPA-S01-SHR-EDYMD
           ELSE
               MOVE    SPA-NAI-STRSRYYMD
                                       TO  SPA-S01-SHR-STYMD
                                           SPA-S01-SHR-EDYMD
               MOVE    "0101"          TO  SPA-S01-SHR-STYMD (5:)
               MOVE    "1231"          TO  SPA-S01-SHR-EDYMD (5:)
           END-IF
      *
           IF    ( SPA-GMN-PRTKBN(1)   =   "T" )
               MOVE    1               TO  SPA-S01-SHR-HCM31FLG
           END-IF
      *
           IF    ( SPA-GMN-PRTKBN(2)   =   "T" )
               MOVE    1               TO  SPA-S01-SHR-HCM32FLG
           END-IF
      *
           PERFORM 210-BACK
      *
           .
       400-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ管理チェック処理
      *****************************************************************
       4900-JOBKANRICHK-SEC            SECTION.
      *
      *    ジョブ管理チェック
           MOVE    SPACE               TO  WRK-ERRMSG
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    CONST-3003-KBNCD    TO  SYS-3003-KBNCD
      *
           MOVE    SPA-SYSYMD          TO  SYS-3003-STYUKYMD
                                           SYS-3003-EDYUKYMD
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
      *
           MOVE    PATH-TBL-SYSKANRI-KEY10 TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-3003-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYS-3003-REC
           END-IF
      *
           MOVE    PATH-TBL-SYSKANRI-KEY10 TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( FLG-SYSKANRI        =   ZERO )
      *
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL ( IDX >       SYS-3003-JOBID )
                        OR   ( WRK-ERRMSG  NOT =   SPACE )
      *
      *            ジョブ管理チェック処理
                   MOVE    "CHK"               TO  SJOBKANRI-MODE
                   INITIALIZE                      JOBKANRI-REC
                   MOVE    IDX                 TO  JOB-JOBID
                   MOVE    CONST-JOB-SHELLID   TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
                   IF    ( SJOBKANRI-RETURN    =   ZERO )
                       IF    ( JOB-ENDYMD      =   SPACE )
                           MOVE    "7777"      TO  SPA-ERRCD
                           STRING  "処理中です【"  DELIMITED  BY  SIZE
                                   JOB-SHELLMSG    DELIMITED  BY  SPACE
                                   "】"            DELIMITED  BY  SIZE
                                                   INTO  WRK-ERRMSG
                           END-STRING
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
      *
           .
       4900-JOBKANRICHK-EXT.
           EXIT.
      *************************************************************
      *    自画面編集処理
      *************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF.
      *
           IF      SPA-SIDCD       NOT =   SPACE
               PERFORM 520-SIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE          TO  LNK-KYOUTU
      *
           MOVE    "CURRENT"      TO  MCP-PUTTYPE
           MOVE    "S04    "      TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *************************************************************
      *    画面編集処理
      *************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           INITIALIZE                  S04
      *
           MOVE    SPA-GMN-PTNUM       TO  S04-PTNUM
           MOVE    SPA-GMN-NAME        TO  S04-NAME
           MOVE    SPA-GMN-KKNKBN(1)   TO  S04-KKNKBN(1)
           MOVE    SPA-GMN-KKNKBN(2)   TO  S04-KKNKBN(2)
           MOVE    SPA-GMN-STRSRYYMD   TO  S04-STRSRYYMD
           MOVE    SPA-GMN-ENDSRYYMD   TO  S04-ENDSRYYMD
           MOVE    SPA-GMN-PRTKBN(1)   TO  S04-PRTKBN(1)
           MOVE    SPA-GMN-PRTKBN(2)   TO  S04-PRTKBN(2)
      *
      *    期間区分コンボ
           MOVE    SPA-GMN-KIKANKBN-G  TO  S04-KIKANKBN
           MOVE    SPA-GMN-KIKANLIST-MAX
                                       TO  S04-KIKAN-COUNT
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL ( IDX     >   SPA-GMN-KIKANLIST-MAX )
               MOVE    SPA-GMN-KIKANLIST(IDX)
                                       TO  S04-KIKA-LIST(IDX)
           END-PERFORM
      *
      *    処理区分コンボ
           MOVE    SPA-GMN-SYORIKBN-G  TO  S04-SYORIKBN
           MOVE    SPA-GMN-SYORILIST-MAX
                                       TO  S04-SYORI-COUNT
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL ( IDX     >   SPA-GMN-SYORILIST-MAX )
               MOVE    SPA-GMN-SYORILIST(IDX)
                                       TO  S04-SYORI-LIST(IDX)
           END-PERFORM
      *
      *    印字区分コンボ
           MOVE    SPA-GMN-DSPKBN-G    TO  S04-DSPKBN
           MOVE    SPA-GMN-DSPLIST-MAX TO  S04-DSP-COUNT
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL ( IDX     >   SPA-GMN-DSPLIST-MAX )
               MOVE    SPA-GMN-DSPLIST(IDX)
                                       TO  S04-DSP-LIST(IDX)
           END-PERFORM
      *
           IF    ( SPA-GMN-KKNKBN(1)   =  "T" )
               MOVE    WIDGET-NORMAL       TO  S04-ENDSRYYMD-STATE
           ELSE
               MOVE    WIDGET-INSENSITIVE  TO  S04-ENDSRYYMD-STATE
           END-IF
      *
           IF    ( SPA-GMN-KIKANKBN    =   "2" )
      *
               MOVE    WIDGET-INSENSITIVE  TO  S04-SYORIKBN-STATE
                                               S04-SYORI-LIST-STATE
                                               S04-DSPKBN-STATE
                                               S04-DSP-LIST-STATE
           ELSE
               MOVE    "期間終了日以後の支払い"
                                           TO  S04-LBLSYORIKBN
               MOVE    WIDGET-NORMAL       TO  S04-SYORIKBN-STATE
                                               S04-SYORI-LIST-STATE
                                               S04-DSPKBN-STATE
                                               S04-DSP-LIST-STATE
           END-IF
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ガイドメッセージ表示
      *****************************************************************
       520-SIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-SIDMSG
      *
           EVALUATE    SPA-SIDCD
           WHEN    "1001"
               MOVE    "印刷を行います"
                                        TO  WRK-SIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  SID2
           MOVE    SPA-SIDCD            TO  SID2-ID1CODE
           MOVE    WRK-SIDMSG           TO  SID2-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "S04"                TO  SPA-MOTOPG
           MOVE    "SID2"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "SID2"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
      *
           .
       520-SIDSET-EXT.
           EXIT.
      *************************************************************
      *    画面カーソルセット処理
      *************************************************************
       5001-MAPCUR-SEC                 SECTION.
      *
          IF   ( SPA-GMN-CUR           =   ZERO )
              PERFORM 50011-CUR-SET-SEC
          END-IF
      *
      *
           IF    ( SPA-GMN-CUR         =   3 )
               IF    ( S04-ENDSRYYMD-STATE =   WIDGET-INSENSITIVE )
                   MOVE        4       TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-CUR         =   4 )
               IF    ( S04-SYORIKBN-STATE  =   WIDGET-INSENSITIVE )
                   MOVE        5       TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-CUR         =   5 )
               IF    ( S04-DSPKBN-STATE  =   WIDGET-INSENSITIVE )
                   MOVE        112     TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           EVALUATE   SPA-GMN-CUR
           WHEN   1
               MOVE  "KIKANKBN"        TO  MCP-WIDGET
           WHEN   2
               MOVE  "STRSRYYMD"       TO  MCP-WIDGET
           WHEN   3
               MOVE  "ENDSRYYMD"       TO  MCP-WIDGET
           WHEN   4
               MOVE  "SYORIKBN"        TO  MCP-WIDGET
           WHEN   5
               MOVE  "DSPKBN"          TO  MCP-WIDGET
           WHEN   112
               MOVE  "B12"             TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理（入力位置より）
      *****************************************************************
       50011-CUR-SET-SEC             SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "KIKANKBN"
           WHEN    "KKNKBN1"
           WHEN    "KKNKBN2"
               MOVE    2               TO  SPA-GMN-CUR
           WHEN    "STRSRYYMD"
               MOVE    3               TO  SPA-GMN-CUR
           WHEN    "ENDSRYYMD"
               MOVE    4               TO  SPA-GMN-CUR
           WHEN    "SYORIKBN"
               MOVE    5               TO  SPA-GMN-CUR
           WHEN    "DSPKBN"
           WHEN    "PRTKBN1"
           WHEN    "PRTKBN2"
               MOVE    112             TO  SPA-GMN-CUR
      *
           END-EVALUATE
      *
           .
       50011-CUR-SET-EXT.
           EXIT.
      **************************************************************
      *    エラーメッセージ表示理
      **************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    SPACE           TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
           WHEN    "0001"
               MOVE    "期間指定区分入力エラー"
                                           TO  SPA-ERRMSG
           WHEN    "0002"
               MOVE    "期間開始入力エラー"
                                           TO  SPA-ERRMSG
           WHEN    "0003"
               MOVE    "期間終了入力エラー"
                                           TO  SPA-ERRMSG
           WHEN    "0004"
               MOVE    "支払区分入力エラー"
                                           TO  SPA-ERRMSG
           WHEN    "0005"
               MOVE    "請求内容印字区分入力エラー"
                                           TO  SPA-ERRMSG
           WHEN    "0006"
               MOVE    "期間を正しく入力してください"
                                           TO  SPA-ERRMSG
           WHEN    "0007"
               MOVE    "指定された期間が１２ヶ月を超えています"
                                           TO  SPA-ERRMSG
           WHEN    "7777"
               MOVE    WRK-ERRMSG          TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE           TO  SERR
           MOVE    SPA-ERRCD       TO  SERR-ERRCODE
           MOVE    SPA-ERRMSG      TO  SERR-ERRMSG
           MOVE    "B01"           TO  MCP-WIDGET
      *
           MOVE    "S04"           TO  SPA-MOTOPG
           MOVE    "SERR"          TO  SPA-SAKIPG
      *
           MOVE    "NEW"           TO  MCP-PUTTYPE
           MOVE    "SERR"          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1               TO  FLG-END
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *   和暦年月日→西暦年月日（機能１２）
      *****************************************************************
       831-YMDCONV12-SEC           SECTION.
      *
           IF      WRK-LNKYMD      NOT =   SPACE
      *        日付画面チェックサブ
               INITIALIZE                  ORCSGDAYAREA
               MOVE    WRK-LNKYMD      TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY     TO  WRK-LNKYMD
                   MOVE    SGDAY-SDAY      TO  WRK-SYMD
               ELSE
                   MOVE    "0002"          TO  SPA-ERRCD
               END-IF
           END-IF
           .
      *
       831-YMDCONV12-EXT.
           EXIT.
      *****************************************************************
      *   画面日付編集処理
      *****************************************************************
       800-ORCSGDAY-SEC                SECTION.
      *
      *    日付画面チェックサブ
           INITIALIZE                  ORCSGDAYAREA
           MOVE    "2"             TO  SGDAY-INTYPE
           MOVE    WRK-LNKYMD      TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                       ORCSGDAYAREA
           IF    ( SGDAY-RC            =   ZERO )
               MOVE    SGDAY-OTDAY     TO  WRK-LNKYMD
               MOVE    SGDAY-SDAY      TO  WRK-SYMD
           ELSE
               MOVE    "0002"          TO  SPA-ERRCD
           END-IF
           .
      *
       800-ORCSGDAY-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DB-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       911-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DB-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MCPSUB"            USING
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
       910-DBCLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBCLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE    "PUTWINDOW"     TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
