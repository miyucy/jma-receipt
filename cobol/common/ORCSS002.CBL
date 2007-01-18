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
       PROGRAM-ID.             ORCSS002.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 共通
      *  コンポーネント名  : 収納更新差額取得
      *  管理者            : 
      *  作成日付    作業者        記述
      *  06/07/14    NACL−太田    新規作成
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
       FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYUNOU          PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                PIC 9(05).
           03  IDX-SYU             PIC 9(05).
           03  IDX-JIHI            PIC 9(05).
           03  IDX-BF              PIC 9(05).
           03  IDX-AF              PIC 9(05).
      *
      *    収納集計領域
       01  SUMSYU-AREA.
           03  SUMSYU-OCC                  OCCURS  2.
               05  SUMSYU-SKYMONEY         PIC S9(08).
               05  SUMSYU-HKNTEN           PIC S9(08).
               05  SUMSYU-HKNMONEY         PIC S9(08).
               05  SUMSYU-SKJMONEY         PIC S9(08).
               05  SUMSYU-LIFEMONEY        PIC S9(08).
               05  SUMSYU-JIHIMONEY        PIC S9(08).
               05  SUMSYU-CHOSEI           PIC S9(08).
               05  SUMSYU-DISCOUNTMONEY    PIC S9(08).
               05  SUMSYU-JIHI-G.
                   07  SUMSYU-JIHI         PIC S9(08)
                                           OCCURS  10.
               05  SUMSYU-RMSAGAKU         PIC S9(08).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    収納マスタ
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
           COPY    "MCPDATA.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY  "CPORCSS002.INC".
       01  LNKSYU-REC.
           COPY    "CPSYUNOU.INC"      REPLACING
                                       //SYU-// BY //LNKSYU-//.
      *
       PROCEDURE                   DIVISION    USING
           SS002-AREA
           LNKSYU-REC
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  SUMSYU-AREA
      *    INITIALIZE                  WRK-AREA
           INITIALIZE                  SS002-OT
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           .
       000-PROC-EXT.
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           MOVE    1               TO  IDX-BF
           MOVE    2               TO  IDX-AF
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           MOVE    LNKSYU-REC      TO  SYUNOU-REC
           MOVE    IDX-AF          TO  IDX-SYU
           PERFORM 2001-SUMSYU-SEC
      *
           PERFORM 900-SYUNOU-KEY-SEL-SEC
           MOVE    IDX-BF          TO  IDX-SYU
           PERFORM 2001-SUMSYU-SEC
      *
           PERFORM 2001-EDIT-SS002-OT-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    収納集計処理
      *****************************************************************
       2001-SUMSYU-SEC             SECTION.
      *
           IF    ( SYU-DENPJTIKBN      =   "3" )
               CONTINUE
           ELSE
               PERFORM 20011-SUMSYU-SEC
           END-IF
      *
           .
       2001-SUMSYU-EXT.
           EXIT.
      *****************************************************************
      *    収納集計処理
      *****************************************************************
       20011-SUMSYU-SEC            SECTION.
      *
      *
           IF    ( SYU-SYUHKNNUM (1:2) =   "98" )
      *
      *        保険組合せ取得
               PERFORM 900-HKNCOMBI-KEY-SEL-SEC
      *
               COMPUTE SUMSYU-JIHIMONEY (IDX-SYU)
                   =   SYU-HKNTEKMONEY
                   +   SYU-RJN-FTN
                   +   SYU-KOH-FTN
                   +   SYU-RSI-TOTAL
      *
                   +   SYU-SKYMONEY-SKJ-KEI
                   +   SYU-SKYMONEY-LIFE-KEI
      *
                   +   SYU-RMSAGAKU
                   +   SYU-SKYMONEY-SKJ-JIHI-KEI
                   +   SYU-SKYMONEY-LIFE-JIHI-KEI
                   +   SYU-TOTAL-TGMONEY
                   +   SYU-TOTAL-TGMONEY-TAX
                   +   SYU-JIHI-TOTAL
                   +   SYU-JIHI-TOTAL-TAX
                   +   SYU-JIHI-TAX
                   IF    ( COMB-HOJOKBN     =   "1" )
                       COMPUTE SUMSYU-JIHIMONEY (IDX-SYU)
                           =   SUMSYU-JIHIMONEY (IDX-SYU)
                           +   SYU-SKYMONEY-TAX-SAI
                   END-IF
      *
           ELSE
      *        保険点数
               COMPUTE SUMSYU-HKNTEN (IDX-SYU)
                   =   SYU-TOTAL-HKNTEN
      *
      *        保険分負担額
               COMPUTE SUMSYU-HKNMONEY(IDX-SYU)
                   =   SYU-HKNTEKMONEY
                   +   SYU-RJN-FTN
                   +   SYU-KOH-FTN
                   +   SYU-RSI-TOTAL
      *
      *        食事負担額
               COMPUTE SUMSYU-SKJMONEY  (IDX-SYU)
                   =   SYU-SKYMONEY-SKJ-KEI
      *
      *        生活負担額
               COMPUTE SUMSYU-LIFEMONEY (IDX-SYU)
                   =   SYU-SKYMONEY-LIFE-KEI
      *
      *        自費分負担額
               COMPUTE SUMSYU-JIHIMONEY (IDX-SYU)
                   =   SYU-RMSAGAKU
                   +   SYU-SKYMONEY-SKJ-JIHI-KEI
                   +   SYU-SKYMONEY-LIFE-JIHI-KEI
                   +   SYU-TOTAL-TGMONEY
                   +   SYU-TOTAL-TGMONEY-TAX
                   +   SYU-JIHI-TOTAL
                   +   SYU-JIHI-TOTAL-TAX
                   +   SYU-JIHI-TAX
           END-IF
      *
           COMPUTE SUMSYU-SKYMONEY (IDX-SYU)
               =   SYU-SKYMONEY
      *
           COMPUTE SUMSYU-CHOSEI (IDX-SYU)
               =   SYU-CHOSEI
      *
           COMPUTE SUMSYU-DISCOUNTMONEY (IDX-SYU)
               =   SYU-DISCOUNT-MONEY
      *
           PERFORM VARYING IDX-JIHI    FROM    1   BY  1
                   UNTIL  (IDX-JIHI    >   10 )
               COMPUTE SUMSYU-JIHI  (IDX-SYU IDX-JIHI)
                   =   SYU-JIHI-TAXNASI (IDX-JIHI)
                   +   SYU-JIHI-TAXARI  (IDX-JIHI)
           END-PERFORM
      *
           COMPUTE SUMSYU-RMSAGAKU (IDX-SYU)
               =   SYU-RMSAGAKU
      *
           .
       20011-SUMSYU-EXT.
           EXIT.
      *****************************************************************
      *    返却値編集処理
      *****************************************************************
       2001-EDIT-SS002-OT-SEC      SECTION.
      *
           COMPUTE SS002-SKYMONEY
               =   SUMSYU-SKYMONEY (IDX-AF)
               -   SUMSYU-SKYMONEY (IDX-BF)
      *
           COMPUTE SS002-HKNTEN
               =   SUMSYU-HKNTEN (IDX-AF)
               -   SUMSYU-HKNTEN (IDX-BF)
      *
           COMPUTE SS002-HKNMONEY
               =   SUMSYU-HKNMONEY (IDX-AF)
               -   SUMSYU-HKNMONEY (IDX-BF)
      *
           COMPUTE SS002-SKJMONEY
               =   SUMSYU-SKJMONEY (IDX-AF)
               -   SUMSYU-SKJMONEY (IDX-BF)
      *
           COMPUTE SS002-LIFEMONEY
               =   SUMSYU-LIFEMONEY (IDX-AF)
               -   SUMSYU-LIFEMONEY (IDX-BF)
      *
           COMPUTE SS002-JIHIMONEY
               =   SUMSYU-JIHIMONEY (IDX-AF)
               -   SUMSYU-JIHIMONEY (IDX-BF)
      *
           COMPUTE SS002-CHOSEI
               =   SUMSYU-CHOSEI (IDX-AF)
               -   SUMSYU-CHOSEI (IDX-BF)
      *
           COMPUTE SS002-DISCOUNTMONEY
               =   SUMSYU-DISCOUNTMONEY (IDX-AF)
               -   SUMSYU-DISCOUNTMONEY (IDX-BF)
      *
           PERFORM VARYING IDX-JIHI    FROM    1   BY  1
                   UNTIL  (IDX-JIHI    >   10 )
               COMPUTE SS002-JIHI  (IDX-JIHI)
                   =   SUMSYU-JIHI (IDX-AF IDX-JIHI)
                   -   SUMSYU-JIHI (IDX-BF IDX-JIHI)
           END-PERFORM
      *
           COMPUTE SS002-RMSAGAKU
               =   SUMSYU-RMSAGAKU (IDX-AF)
               -   SUMSYU-RMSAGAKU (IDX-BF)
      *
           .
       2001-EDIT-SS002-OT-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                SECTION.
      *
      *
           .
       300-END-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ検索処理
      *****************************************************************
       900-HKNCOMBI-KEY-SEL-SEC    SECTION.
      *
           MOVE    ZERO            TO  FLG-HKNCOMBI
      *
           INITIALIZE                  HKNCOMBI-REC
           MOVE    SYU-HOSPID      TO  COMB-HOSPID
           MOVE    SYU-PTID        TO  COMB-PTID
           MOVE    SYU-HKNCOMBINUM TO  COMB-HKNCOMBINUM
           MOVE    HKNCOMBI-REC    TO  MCPDATA-REC
           MOVE    "tbl_hkncombi"  TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  HKNCOMBI-REC
           ELSE
               INITIALIZE              HKNCOMBI-REC
               MOVE    1           TO  FLG-HKNCOMBI
           END-IF
      *
           MOVE    "tbl_hkncombi"  TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-HKNCOMBI-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    収納検索処理
      *****************************************************************
       900-SYUNOU-KEY-SEL-SEC      SECTION.
      *
           MOVE    ZERO                TO  FLG-SYUNOU
      *
           MOVE    LNKSYU-REC          TO  MCPDATA-REC
           MOVE    "tbl_syunou"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
           MOVE    "tbl_syunou"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-SYUNOU-KEY-SEL-EXT.
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
       910-DBCLOSECURSOR-SEC           SECTION.
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
