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
           COPY    "CPORCHCM30.INC".
      *
      *    画面活性非活性
           COPY    "ENUM-VALUE".
      *
      *    スパ領域
       01  SPA-S04.
           03  SPA-GMN-CUR               PIC 9(02).
           03  SPA-GMN-AREA.
               05  SPA-GMN-PTNUM         PIC X(20).
               05  SPA-GMN-NAME          PIC X(100).
               05  SPA-GMN-KKN           PIC X       OCCURS  3.
               05  SPA-GMN-STRSRYYMD     PIC X(10).
               05  SPA-GMN-ENDSRYYMD     PIC X(10).
               05  SPA-GMN-CHK           PIC X       OCCURS  2.
           03  SPA-NAI-AREA.
               05  SPA-NAI-STRSRYYMD.
                   07  SPA-NAI-STRYY     PIC 9(04).
                   07  SPA-NAI-STRMM     PIC 9(02).
                   07  SPA-NAI-STRDD     PIC 9(02).
               05  SPA-NAI-ENDSRYYMD.
                   07  SPA-NAI-ENDYY     PIC 9(04).
                   07  SPA-NAI-ENDMM     PIC 9(02).
                   07  SPA-NAI-ENDDD     PIC 9(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
      *
      *    作業領域
       01  WRK-AREA.
           03  WRK-LNKYMD          PIC X(10).
           03  WRK-SRYYMD          PIC X(10).
           03  WRK-SYMD.
               05  WRK-SYY           PIC 9(04).
               05  WRK-SMM           PIC 9(02).
               05  WRK-SDD           PIC 9(02).
           03  WRK-YMD.
               05  WRK-YY            PIC S9(04).
               05  WRK-MM            PIC S9(02).
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
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
           COPY    "SERR.INC".
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
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *        画面遷移
               WHEN     "PUTG"           ALSO   "CLICKED"
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
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "S04    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *        登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 400-PRINT-SEC
               WHEN    "CLICKED"       ALSO    "KKN1" 
                   MOVE    S04-KKN(1)      TO  SPA-GMN-KKN(1)
                   PERFORM 400-SRYYMD-SET-SEC
               WHEN    "CLICKED"       ALSO    "KKN2" 
                   MOVE    S04-KKN(2)      TO  SPA-GMN-KKN(2)
                   PERFORM 400-SRYYMD-SET-SEC
               WHEN    "CLICKED"       ALSO    "KKN3" 
                   MOVE    S04-KKN(3)      TO  SPA-GMN-KKN(3)
                   PERFORM 400-SRYYMD-SET-SEC
               WHEN    "CLICKED"       ALSO    "CHK1" 
                   MOVE    S04-CHK(1)      TO  SPA-GMN-CHK(1)
               WHEN    "CLICKED"       ALSO    "CHK2" 
                   MOVE    S04-CHK(2)      TO  SPA-GMN-CHK(2)
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
           EVALUATE    MCP-EVENT        ALSO    MCP-WIDGET
               WHEN    "ACTIVATE"       ALSO    "STRSRYYMD"
                   PERFORM  400-STRSRYYMD-SEC
               WHEN    "ACTIVATE"       ALSO    "ENDSRYYMD"
                   PERFORM  400-ENDSRYYMD-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "S02"               TO  SPA-SAKIPG
           MOVE    "S04"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
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
      *************************************************************
      *    初期画面処理
      *************************************************************
       300-SCREEN-SEC             SECTION.
      *
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF
      *
           PERFORM 310-SPASET-SEC
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *************************************************************
      *    画面編集処理
      *************************************************************
       310-SPASET-SEC                  SECTION.
      *
           INITIALIZE                  SPA-GMN-AREA
      *
           MOVE    SPA-S01-PTNUM   TO  SPA-GMN-PTNUM
           MOVE    SPA-S01-NAME    TO  SPA-GMN-NAME
           MOVE    "T"             TO  SPA-GMN-KKN(1)
           MOVE    "F"             TO  SPA-GMN-KKN(2)
           MOVE    "F"             TO  SPA-GMN-KKN(3)
           MOVE    "T"             TO  SPA-GMN-CHK(1)
           MOVE    "F"             TO  SPA-GMN-CHK(2)
      *
           MOVE    SPA-SYSYMDWH    TO  SPA-GMN-STRSRYYMD
           MOVE    SPA-SYSYMD      TO  SPA-NAI-STRSRYYMD
           MOVE    SPA-SYSYMDWH    TO  SPA-GMN-ENDSRYYMD
           MOVE    SPA-SYSYMD      TO  SPA-NAI-ENDSRYYMD
      *
           MOVE    4               TO  SPA-GMN-CUR
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療年月日初期値
      *****************************************************************
       400-SRYYMD-SET-SEC               SECTION.
      *
           MOVE  SPACE                  TO  SPA-NAI-STRSRYYMD
           MOVE  SPACE                  TO  SPA-NAI-ENDSRYYMD
           MOVE  SPACE                  TO  SPA-GMN-STRSRYYMD
           MOVE  SPACE                  TO  SPA-GMN-ENDSRYYMD
           MOVE  SPACE                  TO  WRK-SRYYMD
      *
           IF      SPA-GMN-KKN(1)        =   "T"
               MOVE    SPA-SYSYMDWH     TO  SPA-GMN-STRSRYYMD
               MOVE    SPA-SYSYMD       TO  SPA-NAI-STRSRYYMD
               MOVE    SPA-SYSYMDWH     TO  SPA-GMN-ENDSRYYMD
               MOVE    SPA-SYSYMD       TO  SPA-NAI-ENDSRYYMD
           END-IF
      *
           IF      SPA-GMN-KKN(2)       =   "T"
               MOVE    SPA-SYSYMD       TO  WRK-SRYYMD
               MOVE    WRK-SRYYMD           TO  WRK-LNKYMD
               PERFORM 831-YMDCONV12-SEC
               IF  SPA-ERRCD            =   SPACE
                   MOVE    WRK-LNKYMD(1:3)  TO  SPA-GMN-STRSRYYMD
                   MOVE    WRK-SYY          TO  SPA-NAI-STRSRYYMD(1:4)
                   MOVE    "0101"           TO  SPA-NAI-STRSRYYMD(5:4)
               END-IF
               MOVE    WRK-SYY          TO  SPA-NAI-ENDSRYYMD(1:4)
               MOVE    "1231"           TO  SPA-NAI-ENDSRYYMD(5:4)
           END-IF
      *
           IF      SPA-GMN-KKN(3)       =   "T"
               MOVE    SPA-SYSYMD       TO  WRK-SYMD
               IF  WRK-SYMD(5:4)    <   "0401"
                   COMPUTE WRK-SYY          =   WRK-SYY -   1
               END-IF
               MOVE    WRK-SYY      TO  SPA-NAI-STRSRYYMD(1:4)
               MOVE    "0401"       TO  SPA-NAI-STRSRYYMD(5:4)
               MOVE    SPA-NAI-STRSRYYMD    TO  WRK-LNKYMD
               PERFORM 831-YMDCONV12-SEC
               IF      SPA-ERRCD            =   SPACE
                   MOVE    WRK-LNKYMD(1:3)  TO  SPA-GMN-STRSRYYMD
               END-IF
               COMPUTE WRK-SYY          =   WRK-SYY +   1
               MOVE    WRK-SYY          TO  SPA-NAI-ENDSRYYMD(1:4)
               MOVE    "0331"           TO  SPA-NAI-ENDSRYYMD(5:4)
           END-IF
      *
           MOVE  4                 TO  SPA-GMN-CUR
      *
           .
       400-SRYYMD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    開始診療年月日
      *****************************************************************
       400-STRSRYYMD-SEC                    SECTION.
      *
           MOVE  SPACE                  TO  SPA-NAI-STRSRYYMD
           MOVE  SPACE                  TO  WRK-SRYYMD
           MOVE  S04-STRSRYYMD          TO  SPA-GMN-STRSRYYMD
           MOVE  S04-STRSRYYMD          TO  WRK-SRYYMD
      *
          IF      SPA-GMN-KKN(1)        =   "T"
               PERFORM 400-SRYYMD1-SEC
           END-IF
      *
           IF      SPA-GMN-KKN(2)       =   "T"
               PERFORM 400-SRYYMD2-SEC
           END-IF
      *
           IF      SPA-GMN-KKN(3)       =   "T"
               PERFORM 400-SRYYMD3-SEC
           END-IF
      *
           .
       400-STRSRYYMD-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療年月日１
      *****************************************************************
       400-SRYYMD1-SEC                  SECTION.
      *
           IF  WRK-SRYYMD(4:)       =   SPACE
               MOVE    SPA-SYSYMDWH     TO  SPA-GMN-STRSRYYMD
               MOVE    SPA-SYSYMD       TO  SPA-NAI-STRSRYYMD
               MOVE    SPA-SYSYMDWH     TO  SPA-GMN-ENDSRYYMD
               MOVE    SPA-SYSYMD       TO  SPA-NAI-ENDSRYYMD
           ELSE
               MOVE    SPA-GMN-STRSRYYMD    TO  WRK-LNKYMD
               PERFORM 831-YMDCONV12-SEC
               IF      SPA-ERRCD        =   SPACE
                   MOVE    WRK-LNKYMD   TO  SPA-GMN-STRSRYYMD
                   MOVE    WRK-SYMD     TO  SPA-NAI-STRSRYYMD
               END-IF
           END-IF
      *
           MOVE  5                         TO  SPA-GMN-CUR
           .
       400-SRYYMD1-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療年月日２
      *****************************************************************
       400-SRYYMD2-SEC                  SECTION.
      *
           MOVE  SPACE                  TO  SPA-NAI-ENDSRYYMD
      *
           IF  WRK-SRYYMD               =   SPACE
               MOVE    SPA-SYSYMD       TO  WRK-SRYYMD
           ELSE
               IF  WRK-SRYYMD(4:)   =   SPACE
                   MOVE    "0101"           TO  WRK-SRYYMD(4:4)
               ELSE
                   IF  WRK-SRYYMD(5:)   =   SPACE
                       MOVE    "0101"           TO  WRK-SRYYMD(5:4)
                   END-IF
               END-IF
           END-IF
      *
           MOVE    WRK-SRYYMD           TO  WRK-LNKYMD
           PERFORM 831-YMDCONV12-SEC
           IF  SPA-ERRCD            =   SPACE
               MOVE    WRK-LNKYMD(1:3)  TO  SPA-GMN-STRSRYYMD
               MOVE    WRK-SYY          TO  SPA-NAI-STRSRYYMD(1:4)
               MOVE    "0101"           TO  SPA-NAI-STRSRYYMD(5:4)
           END-IF
      *
           MOVE    WRK-SYY          TO  SPA-NAI-ENDSRYYMD(1:4)
           MOVE    "1231"           TO  SPA-NAI-ENDSRYYMD(5:4)
      *
           MOVE  8                         TO  SPA-GMN-CUR
           .
       400-SRYYMD2-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療年月日３
      *****************************************************************
       400-SRYYMD3-SEC                  SECTION.
      *
           MOVE  SPACE                  TO  SPA-NAI-ENDSRYYMD
      *
           IF  WRK-SRYYMD               =   SPACE
               MOVE    SPA-SYSYMD       TO  WRK-SRYYMD
           ELSE
               IF  WRK-SRYYMD(4:)   =   SPACE
                   MOVE    "0401"           TO  WRK-SRYYMD(4:4)
               ELSE
                   IF  WRK-SRYYMD(5:)   =   SPACE
                       MOVE    "0401"           TO  WRK-SRYYMD(5:4)
                   END-IF
               END-IF
           END-IF
      *
           MOVE    WRK-SRYYMD           TO  WRK-LNKYMD
           PERFORM 831-YMDCONV12-SEC
           IF  SPA-ERRCD            =   SPACE
               IF  WRK-SYMD(5:4)    <   "0401"
                   COMPUTE WRK-SYY          =   WRK-SYY -   1
                   MOVE    WRK-SYY      TO  SPA-NAI-STRSRYYMD(1:4)
                   MOVE    "0401"       TO  SPA-NAI-STRSRYYMD(5:4)
                   MOVE    SPA-NAI-ENDSRYYMD    TO  WRK-SRYYMD
               END-IF
           END-IF
      *
           MOVE    WRK-SRYYMD           TO  WRK-LNKYMD
           PERFORM 831-YMDCONV12-SEC
           IF      SPA-ERRCD            =   SPACE
               MOVE    WRK-LNKYMD(1:3)  TO  SPA-GMN-STRSRYYMD
           END-IF
      *
           COMPUTE WRK-SYY          =   WRK-SYY +   1
           MOVE    WRK-SYY          TO  SPA-NAI-ENDSRYYMD(1:4)
           MOVE    "0331"           TO  SPA-NAI-ENDSRYYMD(5:4)
      *
           MOVE  8                         TO  SPA-GMN-CUR
           .
       400-SRYYMD3-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了診療年月日
      *****************************************************************
       400-ENDSRYYMD-SEC                    SECTION.
      *
           MOVE  S04-ENDSRYYMD          TO  SPA-GMN-ENDSRYYMD
      *
           MOVE  SPACE                  TO  SPA-NAI-ENDSRYYMD
      *
           IF  SPA-GMN-ENDSRYYMD(4:)    =   SPACE
               MOVE    SPA-SYSYMDWH     TO  SPA-GMN-ENDSRYYMD
               MOVE    SPA-SYSYMD       TO  SPA-NAI-ENDSRYYMD
           ELSE
               MOVE  SPA-GMN-ENDSRYYMD      TO  WRK-LNKYMD
               PERFORM 831-YMDCONV12-SEC
               IF      SPA-ERRCD            =   SPACE
                   MOVE    WRK-LNKYMD       TO  SPA-GMN-ENDSRYYMD
                   MOVE    WRK-SYMD         TO  SPA-NAI-ENDSRYYMD
               END-IF
           END-IF
      *
           MOVE    8                        TO  SPA-GMN-CUR
           .
       400-ENDSRYYMD-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷処理
      *****************************************************************
       400-PRINT-SEC                   SECTION.
      *
           IF      SPA-NAI-STRSRYYMD   =   SPACE
               OR  SPA-NAI-ENDSRYYMD   =   SPACE
               OR  SPA-NAI-STRSRYYMD  >   SPA-NAI-ENDSRYYMD
               MOVE    "0002"          TO  SPA-ERRCD
               GO  TO  400-PRINT-EXT
           END-IF
      *
           IF       SPA-GMN-PTNUM      =   SPACE
               MOVE    "0004"          TO  SPA-ERRCD
               GO  TO  400-PRINT-EXT
           END-IF
      *
           COMPUTE WRK-YY      =   SPA-NAI-ENDYY - SPA-NAI-STRYY
           COMPUTE WRK-MM      =   SPA-NAI-ENDMM - SPA-NAI-STRMM
      *
           IF          WRK-YY          <=  1
               IF          WRK-YY      =   1
                   AND     WRK-MM      >=  0
                   MOVE    "0003"           TO  SPA-ERRCD
                   GO  TO  400-PRINT-EXT
               END-IF
           ELSE
               MOVE    "0003"          TO  SPA-ERRCD
               GO  TO  400-PRINT-EXT
           END-IF
      *
           INITIALIZE                      ORCHCM30AREA
           MOVE   SPA-NAI-STRSRYYMD    TO  ORCHCM30-STRSRYYMD
           MOVE   SPA-NAI-ENDSRYYMD    TO  ORCHCM30-ENDSRYYMD
      *
           MOVE   SPA-S01-PTID         TO  SPA-PTID
           MOVE   SPA-S01-PTNUM        TO  SPA-PTNUM
           MOVE   SPA-S01-NAME         TO  SPA-NAME
      *
           IF     SPA-GMN-CHK(1)       =   "T"
               CALL   "ORCHCM30"           USING
                                           SPA-AREA
                                           ORCHCM30AREA
           ELSE
               CALL   "ORCHCM31"           USING
                                           SPA-AREA
                                           ORCHCM30AREA
           END-IF
      *
           PERFORM 210-BACK
      *
           .
       400-PRINT-EXT.
           EXIT.
      *
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
           MOVE    SPACE               TO  LNK-KYOUTU
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE
           MOVE    "S04    "           TO  MCP-WINDOW
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
       500-GMNHEN-SEC                  SECTION.
      *
           MOVE    SPACE               TO  S04
      *
           MOVE    SPA-GMN-PTNUM       TO  S04-PTNUM
           MOVE    SPA-GMN-NAME        TO  S04-NAME
           MOVE    SPA-GMN-KKN(1)      TO  S04-KKN(1)
           MOVE    SPA-GMN-KKN(2)      TO  S04-KKN(2)
           MOVE    SPA-GMN-KKN(3)      TO  S04-KKN(3)
           MOVE    SPA-GMN-STRSRYYMD   TO  S04-STRSRYYMD
           MOVE    SPA-GMN-ENDSRYYMD   TO  S04-ENDSRYYMD
           MOVE    SPA-GMN-CHK(1)      TO  S04-CHK(1)
           MOVE    SPA-GMN-CHK(2)      TO  S04-CHK(2)
      *
           IF  SPA-GMN-KKN(1)  =  "T"
               MOVE    WIDGET-NORMAL       TO  S04-ENDSRYYMD-STATE
           ELSE
               MOVE    SPACE               TO  SPA-GMN-ENDSRYYMD
               MOVE    WIDGET-INSENSITIVE  TO  S04-ENDSRYYMD-STATE
           END-IF
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *************************************************************
      *    画面カーソルセット処理
      *************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
       EVALUATE   SPA-GMN-CUR
           WHEN   1
               MOVE  "KKN1"           TO  MCP-WIDGET
           WHEN   2
               MOVE  "KKN2"           TO  MCP-WIDGET
           WHEN   3
               MOVE  "KKN3"           TO  MCP-WIDGET
           WHEN   4
               MOVE  "STRSRYYMD"      TO  MCP-WIDGET
           WHEN   5
               MOVE  "ENDSRYYMD"      TO  MCP-WIDGET
           WHEN   6
               MOVE  "CHK1"           TO  MCP-WIDGET
           WHEN   7
               MOVE  "CHK2"           TO  MCP-WIDGET
           WHEN   8
               MOVE  "B12"            TO  MCP-WIDGET
           WHEN   9
               MOVE  "B01"            TO  MCP-WIDGET
       END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      **************************************************************
      *    エラーメッセージ表示理
      **************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "入力エラー"     TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "診療期間が正しくありません"
                                            TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "診療期間が１２ヶ月を越えています"
                                            TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "患者が選択されていません"
                                            TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  SERR
           MOVE    SPA-ERRCD            TO  SERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  SERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "S04"                TO  SPA-MOTOPG
           MOVE    "SERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "SERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *   和暦年月日→西暦年月日（機能１２）
      *****************************************************************
       831-YMDCONV12-SEC               SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRCD
      *
           IF  WRK-LNKYMD  NOT  =  SPACE
      *        日付画面チェックサブ
               INITIALIZE                      ORCSGDAYAREA
               MOVE    WRK-LNKYMD          TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY         TO  WRK-LNKYMD
                   MOVE    SGDAY-SDAY          TO  WRK-SYMD
               ELSE
                   MOVE    "0002"              TO  SPA-ERRCD
               END-IF
           END-IF
           .
      *
       831-YMDCONV12-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
