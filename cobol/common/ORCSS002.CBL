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
      *  コンポーネント名  : 収納履歴テーブル更新
      *  管理者            : 
      *  作成日付    作業者        記述
      *  07/01/19    NACL−太田    新規作成
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
           03  FLG-SYURRK          PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                PIC 9(05).
           03  IDX-SYU             PIC 9(05).
           03  IDX-JIHI            PIC 9(05).
           03  IDX-BF              PIC 9(05).
           03  IDX-AF              PIC 9(05).
      *
       01  WRK-AREA.
           03  WRK-SYURRKNUM       PIC S9(09)  BINARY.
           03  WRK-SYUEDANUM       PIC S9(09)  BINARY.
           03  WRK-SYURRKUPDKBN    PIC X(01).
      *
      *    収納履歴集計領域
       01  SUMSYU-AREA.
         02  SUMSYU-OCC            OCCURS  2.
           COPY    "CPSYURRK.INC"  REPLACING
                                   //SYURRK-// BY //SUMSYU-//.
      *
      *    収納作業領域
       01  WKSYUNOU-REC.
           COPY    "CPSYUNOU.INC"  REPLACING
                                   //SYU-// BY //WKSYU-//.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    収納マスタ
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    収納履歴
       01  SYURRK-REC.
           COPY    "CPSYURRK.INC".
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
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
           INITIALIZE                  WRK-AREA
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
           PERFORM 800-MCNDATE-SEC
      *
           PERFORM 900-SYURRK-KEY2-SEL-SEC
           COMPUTE WRK-SYURRKNUM
               =   SYURRK-SYURRKNUM   +   1
           MOVE    ZERO            TO  WRK-SYUEDANUM
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           IF    ( LNKSYU-DENPJTIKBN   =   "3" )
               INITIALIZE              SUMSYU-AREA
               MOVE    IDX-BF      TO  IDX-SYU
               MOVE    LNKSYU-REC  TO  WKSYUNOU-REC
               PERFORM 2001-SUMSYU-SEC
               PERFORM 2001-EDIT-SYURRK-SEC
           ELSE
               PERFORM 900-SYUNOU-KEY-SEL-SEC
               IF    ( FLG-SYUNOU  =   ZERO )
                   IF    ( LNKSYU-SRYKA        =   SYU-SRYKA )
                    AND  ( LNKSYU-HKNCOMBINUM  =   SYU-HKNCOMBINUM )
                       INITIALIZE              SUMSYU-AREA
                       MOVE    IDX-BF      TO  IDX-SYU
                       MOVE    SYUNOU-REC  TO  WKSYUNOU-REC
                       PERFORM 2001-SUMSYU-SEC
      *
                       MOVE    IDX-AF      TO  IDX-SYU
                       MOVE    LNKSYU-REC  TO  WKSYUNOU-REC
                       PERFORM 2001-SUMSYU-SEC
                       PERFORM 2001-EDIT-SYURRK-SEC
                   ELSE
      *
                       MOVE    "1"         TO  WRK-SYURRKUPDKBN
      *
                       INITIALIZE              SUMSYU-AREA
                       MOVE    IDX-BF      TO  IDX-SYU
                       MOVE    SYUNOU-REC  TO  WKSYUNOU-REC
                       PERFORM 2001-SUMSYU-SEC
                       PERFORM 2001-EDIT-SYURRK-SEC
      *
                       INITIALIZE              SUMSYU-AREA
                       MOVE    IDX-AF      TO  IDX-SYU
                       MOVE    LNKSYU-REC  TO  WKSYUNOU-REC
                       PERFORM 2001-SUMSYU-SEC
                       PERFORM 2001-EDIT-SYURRK-SEC
                   END-IF
               ELSE
                   INITIALIZE              SUMSYU-AREA
                   MOVE    IDX-AF      TO  IDX-SYU
                   MOVE    LNKSYU-REC  TO  WKSYUNOU-REC
                   PERFORM 2001-SUMSYU-SEC
                   PERFORM 2001-EDIT-SYURRK-SEC
               END-IF
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    収納集計処理
      *****************************************************************
       2001-SUMSYU-SEC             SECTION.
      *
           MOVE    WKSYU-TOTAL-HKNTEN
                                   TO  SUMSYU-TOTAL-HKNTEN (IDX-SYU)
           MOVE    WKSYU-HKNTEKMONEY
                                   TO  SUMSYU-HKNTEKMONEY  (IDX-SYU)
           MOVE    WKSYU-RJN-FTN
                                   TO  SUMSYU-RJN-FTN      (IDX-SYU)
           MOVE    WKSYU-KOH-FTN
                                   TO  SUMSYU-KOH-FTN      (IDX-SYU)
           MOVE    WKSYU-RSI-TOTAL
                                   TO  SUMSYU-RSI-TOTAL    (IDX-SYU)
           MOVE    WKSYU-JIHI-TOTAL
                                   TO  SUMSYU-JIHI-TOTAL   (IDX-SYU)
           MOVE    WKSYU-JIHI-TOTAL-TAX
                                   TO  SUMSYU-JIHI-TOTAL-TAX
                                                           (IDX-SYU)
           MOVE    WKSYU-JIHI-TAX
                                   TO  SUMSYU-JIHI-TAX     (IDX-SYU)
           MOVE    WKSYU-TOTAL-TGMONEY
                                   TO  SUMSYU-TOTAL-TGMONEY(IDX-SYU)
           MOVE    WKSYU-TOTAL-TGMONEY-TAX
                                   TO  SUMSYU-TOTAL-TGMONEY-TAX
                                                           (IDX-SYU)
           MOVE    WKSYU-SKYMONEY-SKJ-JIHI-KEI
                                   TO  SUMSYU-SKYMONEY-SKJ-JIHI-KEI
                                                           (IDX-SYU)
           MOVE    WKSYU-SKYMONEY-LIFE-JIHI-KEI
                                   TO  SUMSYU-SKYMONEY-LIFE-JIHI-KEI
                                                           (IDX-SYU)
           MOVE    WKSYU-RMSAGAKU  TO  SUMSYU-RMSAGAKU     (IDX-SYU)
           MOVE    WKSYU-SKYMONEY-SKJ-KEI
                                   TO  SUMSYU-SKYMONEY-SKJ-KEI
                                                           (IDX-SYU)
           MOVE    WKSYU-SKYMONEY-LIFE-KEI
                                   TO  SUMSYU-SKYMONEY-LIFE-KEI
                                                           (IDX-SYU)
           MOVE    WKSYU-SKYMONEY  TO  SUMSYU-SKYMONEY     (IDX-SYU)
           MOVE    WKSYU-CHOSEI    TO  SUMSYU-CHOSEI       (IDX-SYU)
           MOVE    WKSYU-DISCOUNT-MONEY
                                   TO  SUMSYU-DISCOUNT-MONEY
                                                           (IDX-SYU)
      *
           PERFORM VARYING IDX-JIHI    FROM   1    BY  1
                   UNTIL ( IDX-JIHI    >   10 )
               MOVE    WKSYU-JIHI-TAXNASI (IDX-JIHI)
                                   TO  SUMSYU-JIHI-TAXNASI
                                                  (IDX-SYU IDX-JIHI)
               MOVE    WKSYU-JIHI-TAXARI  (IDX-JIHI)
                                   TO  SUMSYU-JIHI-TAXARI
                                                  (IDX-SYU IDX-JIHI)
           END-PERFORM
      *
           .
       2001-SUMSYU-EXT.
           EXIT.
      *****************************************************************
      *    収納履歴更新処理
      *****************************************************************
       2001-EDIT-SYURRK-SEC        SECTION.
      *
           COMPUTE WRK-SYUEDANUM   =   WRK-SYUEDANUM       +   1
      *
           INITIALIZE                      SYURRK-REC
           MOVE    WKSYU-HOSPID        TO  SYURRK-HOSPID
           MOVE    WKSYU-PTID          TO  SYURRK-PTID
           MOVE    WKSYU-NYUGAIKBN     TO  SYURRK-NYUGAIKBN
           MOVE    WKSYU-DENPNUM       TO  SYURRK-DENPNUM
      *
           MOVE    WRK-SYURRKNUM       TO  SYURRK-SYURRKNUM
           MOVE    WRK-SYUEDANUM       TO  SYURRK-SYUEDANUM
      *
           MOVE    WKSYU-SRYKA         TO  SYURRK-SRYKA
           MOVE    WKSYU-HKNCOMBINUM   TO  SYURRK-HKNCOMBINUM
      *
           COMPUTE SYURRK-TOTAL-HKNTEN
               =   SUMSYU-TOTAL-HKNTEN (IDX-AF)
               -   SUMSYU-TOTAL-HKNTEN (IDX-BF)
      *
           COMPUTE SYURRK-HKNTEKMONEY
               =   SUMSYU-HKNTEKMONEY  (IDX-AF)
               -   SUMSYU-HKNTEKMONEY  (IDX-BF)
      *
           COMPUTE SYURRK-RJN-FTN
               =   SUMSYU-RJN-FTN (IDX-AF)
               -   SUMSYU-RJN-FTN (IDX-BF)
      *
           COMPUTE SYURRK-KOH-FTN
               =   SUMSYU-KOH-FTN (IDX-AF)
               -   SUMSYU-KOH-FTN (IDX-BF)
      *
           COMPUTE SYURRK-RSI-TOTAL
               =   SUMSYU-RSI-TOTAL (IDX-AF)
               -   SUMSYU-RSI-TOTAL (IDX-BF)
      *
           COMPUTE SYURRK-JIHI-TOTAL
               =   SUMSYU-JIHI-TOTAL (IDX-AF)
               -   SUMSYU-JIHI-TOTAL (IDX-BF)
      *
           COMPUTE SYURRK-JIHI-TOTAL-TAX
               =   SUMSYU-JIHI-TOTAL-TAX (IDX-AF)
               -   SUMSYU-JIHI-TOTAL-TAX (IDX-BF)
      *
           COMPUTE SYURRK-JIHI-TAX
               =   SUMSYU-JIHI-TAX  (IDX-AF)
               -   SUMSYU-JIHI-TAX  (IDX-BF)
      *
           COMPUTE SYURRK-TOTAL-TGMONEY
               =   SUMSYU-TOTAL-TGMONEY  (IDX-AF)
               -   SUMSYU-TOTAL-TGMONEY  (IDX-BF)
      *
           COMPUTE SYURRK-TOTAL-TGMONEY-TAX
               =   SUMSYU-TOTAL-TGMONEY-TAX  (IDX-AF)
               -   SUMSYU-TOTAL-TGMONEY-TAX  (IDX-BF)
      *
           COMPUTE SYURRK-SKYMONEY-SKJ-JIHI-KEI
               =   SUMSYU-SKYMONEY-SKJ-JIHI-KEI  (IDX-AF)
               -   SUMSYU-SKYMONEY-SKJ-JIHI-KEI  (IDX-BF)
      *
           COMPUTE SYURRK-SKYMONEY-LIFE-JIHI-KEI
               =   SUMSYU-SKYMONEY-LIFE-JIHI-KEI (IDX-AF)
               -   SUMSYU-SKYMONEY-LIFE-JIHI-KEI (IDX-BF)
      *
           COMPUTE SYURRK-RMSAGAKU
               =   SUMSYU-RMSAGAKU (IDX-AF)
               -   SUMSYU-RMSAGAKU (IDX-BF)
      *
           COMPUTE SYURRK-SKYMONEY-SKJ-KEI
               =   SUMSYU-SKYMONEY-SKJ-KEI (IDX-AF)
               -   SUMSYU-SKYMONEY-SKJ-KEI (IDX-BF)
      *
           COMPUTE SYURRK-SKYMONEY-LIFE-KEI
               =   SUMSYU-SKYMONEY-LIFE-KEI (IDX-AF)
               -   SUMSYU-SKYMONEY-LIFE-KEI (IDX-BF)
      *
           COMPUTE SYURRK-SKYMONEY
               =   SUMSYU-SKYMONEY (IDX-AF)
               -   SUMSYU-SKYMONEY (IDX-BF)
      *
           COMPUTE SYURRK-CHOSEI
               =   SUMSYU-CHOSEI (IDX-AF)
               -   SUMSYU-CHOSEI (IDX-BF)
      *
           COMPUTE SYURRK-DISCOUNT-MONEY
               =   SUMSYU-DISCOUNT-MONEY (IDX-AF)
               -   SUMSYU-DISCOUNT-MONEY (IDX-BF)
      *
           PERFORM VARYING IDX-JIHI    FROM   1    BY  1
                   UNTIL ( IDX-JIHI    >   10 )
               COMPUTE SYURRK-JIHI-TAXNASI (IDX-JIHI)
                   =   SUMSYU-JIHI-TAXNASI (IDX-AF IDX-JIHI)
                   -   SUMSYU-JIHI-TAXNASI (IDX-BF IDX-JIHI)
      *
               COMPUTE SYURRK-JIHI-TAXARI (IDX-JIHI)
                   =   SUMSYU-JIHI-TAXARI (IDX-AF IDX-JIHI)
                   -   SUMSYU-JIHI-TAXARI (IDX-BF IDX-JIHI)
           END-PERFORM
      *
           MOVE    SMCNDATE-YMD        TO  SYURRK-CREYMD
                                           SYURRK-UPYMD
           MOVE    SMCNDATE-HMS        TO  SYURRK-UPHMS
           MOVE    SYURRK-REC          TO  MCPDATA-REC
           MOVE    "tbl_syurrk"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBINSERT-SEC
           IF    ( MCP-RC      NOT =   ZERO )
               MOVE    1               TO  SS002-RC
           END-IF
      *
      *
           .
       2001-EDIT-SYURRK-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                SECTION.
      *
           MOVE    WRK-SYURRKNUM   TO  SS002-SYURRKNUM
           MOVE    WRK-SYUEDANUM   TO  SS002-SYUEDANUM
           MOVE    WRK-SYURRKUPDKBN TO SS002-SYURRKUPDKBN
      *
           .
       300-END-EXT.
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
      *    収納履歴検索処理
      *****************************************************************
       900-SYURRK-KEY2-SEL-SEC     SECTION.
      *
           MOVE    ZERO                TO  FLG-SYURRK
      *
           INITIALIZE                      SYURRK-REC
           MOVE    LNKSYU-HOSPID       TO  SYURRK-HOSPID
           MOVE    LNKSYU-PTID         TO  SYURRK-PTID
           MOVE    LNKSYU-NYUGAIKBN    TO  SYURRK-NYUGAIKBN
           MOVE    LNKSYU-DENPNUM      TO  SYURRK-DENPNUM
      *
           MOVE    SYURRK-REC          TO  MCPDATA-REC
           MOVE    "tbl_syurrk"        TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYURRK-REC
           ELSE
               INITIALIZE                  SYURRK-REC
               MOVE    1               TO  FLG-SYURRK
           END-IF
      *
           MOVE    "tbl_syurrk"        TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-SYURRK-KEY2-SEL-EXT.
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
      *****************************************************************
      *    ＤＢ追加処理
      *****************************************************************
       910-DBINSERT-SEC                SECTION.
      *
           MOVE    "DBINSERT"      TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBINSERT-EXT.
           EXIT.
