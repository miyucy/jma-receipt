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
       IDENTIFICATION                  DIVISION.
       PROGRAM-ID.                     ORCHCM43S02.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者登録
      *  コンポーネント名  : 外来月別請求書発行サブ
      *  管理者            : 
      *  作成日付    作業者        記述
      *  05/01/13    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                     DIVISION.
       CONFIGURATION                   SECTION.
       INPUT-OUTPUT                    SECTION.
       FILE-CONTROL.
      *
      *
       DATA                            DIVISION.
       FILE                            SECTION.
      *
      *
       WORKING-STORAGE                 SECTION.
      *
       01  FLG-AREA.
           03  FLG-SYUNOU              PIC 9(01).
           03  FLG-HIT                 PIC 9(01).
      *
       01  IDX-AREA.
           03  IDX0                    PIC 9(05).
           03  IDX1                    PIC 9(05).
           03  IDX2                    PIC 9(05).
           03  IDX3                    PIC 9(05).
           03  IDX4                    PIC 9(05).
           03  IDX5                    PIC 9(05).
           03  IDX-SYU                 PIC 9(05).
      *
       01  WRK-AREA.
           03  WRK-RSIJBIFLG           PIC 9(01).
           03  WRK-HKNCOMBI            PIC X(04).
           03  WRK-SRYKA               PIC X(02).
           03  WRK-MAX                 PIC 9(05).
      *
       01  SRT-AREA.
           03  SRT-PNT                 PIC 9(05).
           03  SRT-IDX1                PIC 9(05).
           03  SRT-IDX2                PIC 9(05).
           03  SRT-ST                  PIC 9(05).
           03  SRT-MAX                 PIC 9(03).
           03  SRT-OCC                 OCCURS  51.
               05  SRT-KEY.
                   07  SRT-RSIJBIFLG   PIC 9(01).
                   07  SRT-SRYKA       PIC X(02).
                   07  SRT-HKNCOMBI    PIC X(04).
               05  SRT-KBT-SRYKA-MAX   PIC 9(03).
               05  SRT-KBT-SRYKA       PIC X(02)
                                       OCCURS  50.
               05  SRT-KBT-HKNCOMBI-MAX   PIC 9(03).
               05  SRT-KBT-HKNCOMBI-OCC   OCCURS  50.
                   07  SRT-KBT-HKNCOMBI   PIC X(04).
                   07  SRT-KBT-PTFTNRATE  PIC 9(03).
      *
       01  CONST-AREA.
           03  CONST-SRT-MAX           PIC 9(03)   VALUE   50.
           03  CONST-SRT-TMP           PIC 9(03)   VALUE   51.
           03  CONST-SRT-KBT-MAX       PIC 9(03)   VALUE   50.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    収納
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
           COPY    "MCPDATA.INC".
           COPY    "MCPAREA".
           COPY    "ORCA-DBPATH".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                        SECTION.
      *
           COPY    "COMMON-SPA".
           COPY    "CPORCHCM43.INC".
           COPY    "CPORCHCM43S01.INC".
       01  LNKSYU-REC.
         02    LNKSYU-OCC             OCCURS  50.
           COPY    "CPSYUNOU.INC"     REPLACING //SYU-//
                                      BY        //LNKSYU-//.
      *
       PROCEDURE                       DIVISION    USING
           SPA-AREA
           ORCHCM43AREA
           HCM43S01-AREA
           LNKSYU-REC
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
      *    初期処理
           PERFORM 100-INIT-SEC
      *
      *    主処理
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
       100-INIT-SEC                    SECTION.
      *
           INITIALIZE                  FLG-AREA
                                       IDX-AREA
                                       WRK-AREA
                                       SRT-AREA
                                       HCM43S01-HENKYAKU-AREA
                                       LNKSYU-REC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
      *    収納集計処理
           PERFORM 2001-SYUSUM-SEC
      *
      *    収納並べ替え処理
           PERFORM 2001-SYUSRT-SEC
      *
           MOVE    SRT-MAX             TO  HCM43S01-GRP-MAX
      *
           PERFORM VARYING IDX4    FROM    1   BY  1
                   UNTIL ( IDX4    >   SRT-MAX )
      *
               MOVE    SRT-KBT-SRYKA-MAX (IDX4)
                               TO  HCM43S01-GRP-SRYKA-MAX (IDX4)
               MOVE    SRT-KBT-SRYKA-MAX (IDX4)
                               TO  WRK-MAX
               PERFORM VARYING IDX5    FROM    1   BY  1
                       UNTIL ( IDX5    >   WRK-MAX )
      *
                   MOVE    SRT-KBT-SRYKA (IDX4 IDX5)
                               TO  HCM43S01-GRP-SRYKA (IDX4 IDX5)
      *
               END-PERFORM
      *
               MOVE    SRT-KBT-HKNCOMBI-MAX (IDX4)
                               TO  HCM43S01-GRP-HKNCOMBI-MAX (IDX4)
               MOVE    SRT-KBT-HKNCOMBI-MAX (IDX4)
                               TO  WRK-MAX
               PERFORM VARYING IDX5    FROM    1   BY  1
                       UNTIL ( IDX5    >   WRK-MAX )
      *
                   MOVE    SRT-KBT-HKNCOMBI-OCC (IDX4 IDX5)
                               TO  HCM43S01-GRP-HKNCOMBI-OCC (IDX4 IDX5)
      *
               END-PERFORM
      *
           END-PERFORM
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科・保険組合せ取得処理
      *****************************************************************
       2001-SYUSUM-SEC                 SECTION.
      *
           PERFORM 900-SYUNOU-KEY37-SEL-SEC
      *
           PERFORM UNTIL ( FLG-SYUNOU  NOT =   ZERO )
      *
               MOVE    ZERO            TO  WRK-RSIJBIFLG
               IF    ( SYU-SYUHKNNUM   =   "971"   OR  "973" )
                       MOVE    1           TO  WRK-RSIJBIFLG
                       MOVE    SYU-SRYKA       TO  WRK-SRYKA
                       MOVE    SYU-HKNCOMBINUM TO  WRK-HKNCOMBI
                       PERFORM 20011-SYUNOU-SYUKEI-SEC
               ELSE
      *
                   EVALUATE    ORCHCM43-HAKUHOUFLG
      *
                   WHEN    "2"
                       MOVE    ZERO            TO  WRK-SRYKA
                       MOVE    SYU-HKNCOMBINUM TO  WRK-HKNCOMBI
                       PERFORM 20011-SYUNOU-SYUKEI-SEC
      *
                   WHEN    "3"
                       MOVE    SYU-SRYKA       TO  WRK-SRYKA
                       MOVE    ZERO            TO  WRK-HKNCOMBI
                       PERFORM 20011-SYUNOU-SYUKEI-SEC
      *
                   WHEN    "4"
      *
                       MOVE    ZERO            TO  WRK-SRYKA
                       MOVE    ZERO            TO  WRK-HKNCOMBI
                       PERFORM 20011-SYUNOU-SYUKEI-SEC
      *
                   WHEN    OTHER
                       MOVE    SYU-SRYKA       TO  WRK-SRYKA
                       MOVE    SYU-HKNCOMBINUM TO  WRK-HKNCOMBI
                       PERFORM 20011-SYUNOU-SYUKEI-SEC
      *
                   END-EVALUATE
               END-IF
      *
               PERFORM 900-SYUNOU-KEY37-FET-SEC
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-SYUNOU-KEY37   TO  MCP-PATH
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       2001-SYUSUM-EXT.
           EXIT.
      *****************************************************************
      *    診療科・保険組合せ別集計処理
      *****************************************************************
       20011-SYUNOU-SYUKEI-SEC     SECTION.
      *
           MOVE    ZERO            TO  SRT-PNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1        >   SRT-MAX )
                    OR   ( SRT-PNT     >   ZERO  )
      *
               IF    ( SRT-RSIJBIFLG (IDX1)    =   WRK-RSIJBIFLG )
                AND  ( SRT-SRYKA     (IDX1)    =   WRK-SRYKA )
                AND  ( SRT-HKNCOMBI  (IDX1)    =   WRK-HKNCOMBI )
                    MOVE    IDX1   TO  SRT-PNT
               END-IF
      *
           END-PERFORM
      *
           IF    ( SRT-PNT         >   ZERO )
               MOVE    SRT-PNT     TO  IDX-SYU
               PERFORM 20011-SYUNOU-GRP-SEC
           ELSE
               IF    ( SRT-MAX     <   CONST-SRT-MAX )
                   COMPUTE SRT-MAX =   SRT-MAX     +   1
                   MOVE    WRK-RSIJBIFLG
                                   TO  SRT-RSIJBIFLG (SRT-MAX)
                   MOVE    WRK-SRYKA
                                   TO  SRT-SRYKA     (SRT-MAX)
                   MOVE    WRK-HKNCOMBI
                                   TO  SRT-HKNCOMBI  (SRT-MAX)
                   MOVE    SRT-MAX TO  IDX-SYU
                   PERFORM 20011-SYUNOU-GRP-SEC
               END-IF
           END-IF
      *
           .
       20011-SYUNOU-SYUKEI-EXT.
           EXIT.
      *****************************************************************
      *    収納まとめ処理
      *****************************************************************
       20011-SYUNOU-GRP-SEC                SECTION.
      *
           PERFORM 20011-SYUNOU-SUM-SEC
      *
           PERFORM 20011-KBT-SRYKA-HEN-SEC
      *
           PERFORM 20011-KBT-HKNCOMBI-HEN-SEC
      *
           .
       20011-SYUNOU-GRP-EXT.
           EXIT.
      *****************************************************************
      *    収納集計処理
      *****************************************************************
       20011-SYUNOU-SUM-SEC                SECTION.
      *
           ADD SYU-TAX-TAISHOU     TO  LNKSYU-TAX-TAISHOU (IDX-SYU)
           ADD SYU-TAX-MONEY       TO  LNKSYU-TAX-MONEY   (IDX-SYU)
           ADD SYU-TGMONEY-TAX-SAI TO  LNKSYU-TGMONEY-TAX-SAI
                                                          (IDX-SYU)
           ADD SYU-SKYGK           TO  LNKSYU-SKYGK       (IDX-SYU)
           ADD SYU-HKNTEKMONEY     TO  LNKSYU-HKNTEKMONEY (IDX-SYU)
           PERFORM VARYING     IDX0    FROM    1   BY  1
                   UNTIL       IDX0    >   12
               ADD SYU-HKNTEN (IDX0)
                                   TO  LNKSYU-HKNTEN(IDX-SYU IDX0)
               ADD SYU-MONEY  (IDX0)
                                   TO  LNKSYU-MONEY (IDX-SYU IDX0)
               ADD SYU-TGMONEY(IDX0)
                                   TO  LNKSYU-TGMONEY(IDX-SYU IDX0)
               ADD SYU-TGMONEY-TAX (IDX0)
                                   TO  LNKSYU-TGMONEY-TAX(IDX-SYU IDX0)
           END-PERFORM
      *
           PERFORM VARYING     IDX0    FROM    1   BY  1
                   UNTIL       IDX0    >   10
               ADD    SYU-JIHI-TAXNASI(IDX0)
                                   TO  LNKSYU-JIHI-TAXNASI(IDX-SYU IDX0)
               ADD    SYU-JIHI-TAXARI (IDX0)
                                   TO  LNKSYU-JIHI-TAXARI(IDX-SYU IDX0)
           END-PERFORM
      *
           ADD SYU-JIHI-TOTAL      TO  LNKSYU-JIHI-TOTAL     (IDX-SYU)
           ADD SYU-JIHI-TOTAL-TAX  TO  LNKSYU-JIHI-TOTAL-TAX (IDX-SYU)
           ADD SYU-JIHI-TAX        TO  LNKSYU-JIHI-TAX       (IDX-SYU)
           ADD SYU-RJN-FTN         TO  LNKSYU-RJN-FTN        (IDX-SYU)
           ADD SYU-KOH-FTN         TO  LNKSYU-KOH-FTN        (IDX-SYU)
           ADD SYU-KOH-FTN-ENTANI  TO  LNKSYU-KOH-FTN-ENTANI (IDX-SYU)
           ADD SYU-YKZ-FTN         TO  LNKSYU-YKZ-FTN        (IDX-SYU)
      *
      *調整金
           ADD SYU-CHOSEI          TO  LNKSYU-CHOSEI         (IDX-SYU)
      *請求金額−消費税（再掲）
           ADD SYU-SKYMONEY-TAX-SAI TO LNKSYU-SKYMONEY-TAX-SAI(IDX-SYU)
      *請求金額
           ADD SYU-SKYMONEY        TO  LNKSYU-SKYMONEY       (IDX-SYU)
      *入金合計額
           ADD SYU-NYUKIN-TOTAL    TO  LNKSYU-NYUKIN-TOTAL   (IDX-SYU)
      *労災保険
           ADD SYU-RSISHOSHIN-MONEY
                                   TO  LNKSYU-RSISHOSHIN-MONEY(IDX-SYU)
           ADD SYU-RSISAISHIN-MONEY
                                   TO  LNKSYU-RSISAISHIN-MONEY(IDX-SYU)
           ADD SYU-RSISDO-MONEY    TO  LNKSYU-RSISDO-MONEY    (IDX-SYU)
           ADD SYU-RSIETC-MONEY    TO  LNKSYU-RSIETC-MONEY    (IDX-SYU)
           ADD SYU-RSI-TAX-SAI     TO  LNKSYU-RSI-TAX-SAI     (IDX-SYU)
           ADD SYU-RSI-TOTAL       TO  LNKSYU-RSI-TOTAL       (IDX-SYU)
           ADD SYU-RSIJIBAI-SKYMONEY
                                   TO  LNKSYU-RSIJIBAI-SKYMONEY(IDX-SYU)
      *
           .
       20011-SYUNOU-SUM-EXT.
           EXIT.
      *****************************************************************
      *    診療科退避処理
      *****************************************************************
       20011-KBT-SRYKA-HEN-SEC         SECTION.
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   SRT-KBT-SRYKA-MAX (IDX-SYU) )
                     OR  ( SRT-KBT-SRYKA (IDX-SYU IDX0) 
                                   =   SYU-SRYKA )
      *
               CONTINUE
      *
           END-PERFORM
      *
           IF    ( IDX0    >   SRT-KBT-SRYKA-MAX (IDX-SYU) )
               IF    ( SRT-KBT-SRYKA-MAX (IDX-SYU)
                                   <   CONST-SRT-KBT-MAX )
                   COMPUTE SRT-KBT-SRYKA-MAX (IDX-SYU)
                       =   SRT-KBT-SRYKA-MAX (IDX-SYU) +   1
                   MOVE    SRT-KBT-SRYKA-MAX (IDX-SYU)
                                       TO  IDX3
                   MOVE    SYU-SRYKA   TO  SRT-KBT-SRYKA
                                             (IDX-SYU IDX3)
               END-IF
           END-IF
      *
           .
       20011-KBT-SRYKA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ退避処理
      *****************************************************************
       20011-KBT-HKNCOMBI-HEN-SEC      SECTION.
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   SRT-KBT-HKNCOMBI-MAX(IDX-SYU) )
                     OR  ( SRT-KBT-HKNCOMBI (IDX-SYU IDX0) 
                                   =   SYU-HKNCOMBINUM )
      *
               CONTINUE
      *
           END-PERFORM
      *
           IF    ( IDX0    >   SRT-KBT-HKNCOMBI-MAX (IDX-SYU) )
               IF    ( SRT-KBT-HKNCOMBI-MAX (IDX-SYU)
                                               <   CONST-SRT-KBT-MAX )
                   COMPUTE SRT-KBT-HKNCOMBI-MAX (IDX-SYU)
                       =   SRT-KBT-HKNCOMBI-MAX (IDX-SYU)
                       +   1
                   MOVE    SRT-KBT-HKNCOMBI-MAX (IDX-SYU)
                                           TO  IDX3
                   MOVE    SYU-HKNCOMBINUM TO  SRT-KBT-HKNCOMBI
                                         (IDX-SYU IDX3)
                   MOVE    SYU-PTFTNRATE   TO  SRT-KBT-PTFTNRATE
                                         (IDX-SYU IDX3)
               END-IF
           END-IF
      *
           .
       20011-KBT-HKNCOMBI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    収納並べ替え処理
      *****************************************************************
       2001-SYUSRT-SEC                 SECTION.
      *
           PERFORM VARYING SRT-IDX1    FROM    1   BY  1
                   UNTIL ( SRT-IDX1    >=      SRT-MAX )
      *
               COMPUTE SRT-ST  =   SRT-IDX1    +   1
      *
               PERFORM VARYING SRT-IDX2    FROM    SRT-ST  BY  1
                       UNTIL ( SRT-IDX2    >       SRT-MAX )
                   IF    ( SRT-KEY (SRT-IDX1)    > SRT-KEY (SRT-IDX2) )
                       MOVE    SRT-OCC (SRT-IDX1)
                                       TO  SRT-OCC (CONST-SRT-TMP)
                       MOVE    SRT-OCC (SRT-IDX2)
                                       TO  SRT-OCC (SRT-IDX1)
                       MOVE    SRT-OCC (CONST-SRT-TMP)
                                       TO  SRT-OCC (SRT-IDX2)
      *
                       MOVE    LNKSYU-OCC (SRT-IDX1)
                                       TO  SYUNOU-REC
                       MOVE    LNKSYU-OCC (SRT-IDX2)
                                       TO  LNKSYU-OCC (SRT-IDX1)
                       MOVE    SYUNOU-REC
                                       TO  LNKSYU-OCC (SRT-IDX2)
      *
                   END-IF
               END-PERFORM
      *
           END-PERFORM
      *
           .
       2001-SYUSRT-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納検索処理(KEY37)
      *****************************************************************
       900-SYUNOU-KEY37-SEL-SEC        SECTION.
      *
           MOVE    ZERO            TO  FLG-SYUNOU
      *
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-PTID            TO  SYU-PTID
           STRING  ORCHCM43-STSRYYM    DELIMITED   BY  SPACE
                   "%"                 DELIMITED   BY  SIZE
           INTO    SYU-SRYYMD
           END-STRING
      *
           MOVE    SYUNOU-REC      TO  MCPDATA-REC
           MOVE    PATH-TBL-SYUNOU-KEY37
                                   TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SYUNOU-REC
           ELSE
               INITIALIZE              SYUNOU-REC
               MOVE    1           TO  FLG-SYUNOU
           END-IF
      *
           .
      *
       900-SYUNOU-KEY37-SEL-EXT.
           EXIT.
      *****************************************************************
      *    収納フェッチ処理(KEY37)
      *****************************************************************
       900-SYUNOU-KEY37-FET-SEC        SECTION.
      *
           MOVE    PATH-TBL-SYUNOU-KEY37
                                   TO  MCP-PATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SYUNOU-REC
           ELSE
               INITIALIZE              SYUNOU-REC
               MOVE    1           TO  FLG-SYUNOU
           END-IF
      *
           .
      *
       900-SYUNOU-KEY37-FET-EXT.
           EXIT.
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
           .
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBCLOSECURSOR-EXT.
           EXIT.
           .
