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
       PROGRAM-ID.             ORCHC03S02.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 診療行為
      *  コンポーネント名  : 請求書兼領収書収納編集（パラメタテーブルより）
      *  管理者            : 
      *  作成日付    作業者        記述
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
           03  FLG-PARA                PIC 9(01).
           03  FLG-HKNCOMBI            PIC 9(01).
           03  FLG-PTRSIINF            PIC 9(01).
           03  FLG-SYSKANRI            PIC 9(01).
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
           03  WRK-DENPNUM             PIC 9(07).
           03  WRK-SRYYM               PIC X(06).
           03  WRK-MAX                 PIC 9(05).
           03  WRK-NYUKIN-BF           PIC S9(10).
           03  WRK-SRYKAMEI            PIC X(20).
           03  WRK-HKNCOMBIMEI         PIC X(40).
           03  WRK-SRYKA-MAX           PIC 9(05).
           03  WRK-SRYKA-PNT           PIC 9(05).
           03  WRK-SRYYMD              PIC X(08).
           03  WRK-FILEMEI  .
               05  WRK-FILEMEI-YMD PIC X(08).
               05  WRK-FILEMEI-HMS PIC X(06).
               05  WRK-FILEMEI-CD  PIC X(06).
      *
       01  SRT-AREA.
           03  SRT-PNT                 PIC 9(05).
           03  SRT-IDX1                PIC 9(05).
           03  SRT-IDX2                PIC 9(05).
           03  SRT-ST                  PIC 9(05).
           03  SRT-MAX                 PIC 9(03).
           03  SRT-OCC                 OCCURS  1001.
               05  SRT-KEY.
                   07  SRT-SRYYM2.
                       09  SRT-SRYYM29 PIC 9(06).
                   07  SRT-SRTDENPNUM  PIC 9(07).
                   07  SRT-DENPNUM     PIC 9(07).
                   07  SRT-SRYYM.
                       09  SRT-SRYYM9  PIC 9(06).
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
               05  SRT-KBT-DENPNUM-MAX PIC 9(03).
               05  SRT-KBT-DENPNUM-OCC OCCURS  100.
                   07  SRT-KBT-DENPNUM PIC 9(07).
               05  SRT-KBT-DENPPRTYMD  PIC X(08).
               05  SRT-KBT-STSRYYMD    PIC X(08).
               05  SRT-KBT-EDSRYYMD    PIC X(08).
               05  SRT-KBT-TUIKANYUKINFLG
                                       PIC 9(01).
               05  SRT-KBT-SEIKYU      PIC S9(10).
               05  SRT-KBT-NYUKIN      PIC S9(10).
      *
       01  CONST-AREA.
           03  CONST-SRT-MAX           PIC 9(05)   VALUE   1000.
           03  CONST-SRT-TMP           PIC 9(05)   VALUE   1001.
           03  CONST-SRT-KBT-HKNCOMBI-MAX  PIC 9(03)   VALUE   50.
           03  CONST-SRT-KBT-SRYKA-MAX PIC 9(03)   VALUE   50.
           03  CONST-SRT-KBT-DENPNUM-MAX   PIC 9(03)   VALUE   100.
      *
       01  LNKSYU-REC.
         02  LNKSYU-MAX                PIC 9(05).
         02  LNKSYU-OCC                OCCURS    1000.
           COPY    "CPSYUNOU.INC"      REPLACING
                                       //SYU-//    BY  //LNKSYU-//.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
           COPY    "CPSYSKANRI.INC".
           COPY    "CPSK1005.INC".
      *
      *    収納
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    保険組合せ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    患者労災保険情報
       01  PTRSIINF-REC.
           COPY    "CPPTRSIINF.INC".
      *
      *    パラメタテーブル	
       01  PARA-REC.
           COPY    "CPPARA.INC".
           COPY    "CPSYUPARA01.INC".
           COPY    "CPSYUPARA02.INC".
           COPY    "CPSYUPARA03.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
           COPY    "MCPDATA.INC".
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                        SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
           COPY    "CPORCHC03S02.INC".
      *
       PROCEDURE                       DIVISION    USING
                                       SPA-AREA
                                       ORCHC03S02AREA.
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
                                       LNKSYU-REC
      *
           MOVE    ZERO            TO  ORCHC03S02-CNT
                                       ORCHC03S02-RC
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
      *    パラメタテーブル編集処理
           PERFORM 2001-EDIT-PARA-SEC
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
           PERFORM 900-PARA-KEY4-SEL-SEC
           MOVE    PARA-DATA-REC       TO  SYUPARA01-AREA
      *
           PERFORM 900-PARA-KEY6-SEL-SEC
      *
           PERFORM UNTIL ( FLG-PARA    NOT =   ZERO )
      *
               MOVE    PARA-DATA-REC       TO  SYUPARA02-AREA
      *
               PERFORM 900-SYUNOU-KEY-SEL-SEC
      *
               IF    ( SYUPARA01-SKYSUMFLG =   ZERO )
                       MOVE    SYU-SRYYMD (1:6) TO WRK-SRYYM
                       MOVE    SYU-DENPNUM     TO  WRK-DENPNUM
                       MOVE    SYU-SRYKA       TO  WRK-SRYKA
                       MOVE    SYU-HKNCOMBINUM TO  WRK-HKNCOMBI
                       PERFORM 20011-SYUNOU-SYUKEI-SEC
               ELSE
      *
                       MOVE    ZERO            TO  WRK-RSIJBIFLG
                       MOVE    ZERO            TO  WRK-DENPNUM
                       MOVE    SYU-SRYYMD (1:6) TO WRK-SRYYM
      *
                   IF    ( SYU-SYUHKNNUM   =   "971"   OR  "973" )
                       MOVE    1               TO  WRK-RSIJBIFLG
                       MOVE    SYU-SRYKA       TO  WRK-SRYKA
                       MOVE    SYU-HKNCOMBINUM TO  WRK-HKNCOMBI
                       PERFORM 20011-SYUNOU-SYUKEI-SEC
                   ELSE
      *
                       EVALUATE    SYUPARA01-SKYSUMFLG
      *
                       WHEN    2
                           MOVE    ZERO            TO  WRK-SRYKA
                           MOVE    SYU-HKNCOMBINUM TO  WRK-HKNCOMBI
                           PERFORM 20011-SYUNOU-SYUKEI-SEC
      *
                       WHEN    3
                           MOVE    SYU-SRYKA       TO  WRK-SRYKA
                           MOVE    ZERO            TO  WRK-HKNCOMBI
                           PERFORM 20011-SYUNOU-SYUKEI-SEC
      *
                       WHEN    4
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
               END-IF
      *
               PERFORM 900-PARA-KEY6-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_para"          TO  MCP-TABLE
           MOVE    "key6"              TO  MCP-PATHNAME
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
               IF    ( SRT-SRYYM     (IDX1)    =   WRK-SRYYM )
                AND  ( SRT-DENPNUM   (IDX1)    =   WRK-DENPNUM )
                AND  ( SRT-RSIJBIFLG (IDX1)    =   WRK-RSIJBIFLG )
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
      *
               IF    ( SYUPARA01-HAKKOFLG  =   4 )
                   CONTINUE
               ELSE
                   IF    ( SRT-SRTDENPNUM(SRT-MAX)
                                   >   SYU-DENPNUM )
                       MOVE    SYU-DENPNUM
                                   TO  SRT-SRTDENPNUM(SRT-MAX)
                   END-IF
               END-IF
      *
           ELSE
               IF    ( SRT-MAX     <   CONST-SRT-MAX )
                   COMPUTE SRT-MAX =   SRT-MAX     +   1
                   MOVE    WRK-SRYYM
                                   TO  SRT-SRYYM     (SRT-MAX)
                   MOVE    WRK-DENPNUM
                                   TO  SRT-DENPNUM   (SRT-MAX)
                   MOVE    WRK-RSIJBIFLG
                                   TO  SRT-RSIJBIFLG (SRT-MAX)
                   MOVE    WRK-SRYKA
                                   TO  SRT-SRYKA     (SRT-MAX)
                   MOVE    WRK-HKNCOMBI
                                   TO  SRT-HKNCOMBI  (SRT-MAX)
      *
                   IF    ( SYUPARA01-HAKKOFLG  =   4 )
                       CONTINUE
                   ELSE
                       MOVE    SYU-DENPNUM
                                   TO  SRT-SRTDENPNUM(SRT-MAX)
                   END-IF
      *
                   COMPUTE SRT-SRYYM29 (SRT-MAX)
                       =   SRT-SRYYM29 (SRT-MAX)
                       -   SRT-SRYYM9  (SRT-MAX)
      *
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
           PERFORM 20011-KBT-DENPNUM-HEN-SEC
      *
           PERFORM 20011-KBT-SRYYMD-HEN-SEC
      *
           PERFORM 20011-KBT-SEIKYU-HEN-SEC
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
                   UNTIL       IDX0    >   16
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
                                   <   CONST-SRT-KBT-SRYKA-MAX )
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
                                   <   CONST-SRT-KBT-HKNCOMBI-MAX )
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
      *    伝票番号退避処理
      *****************************************************************
       20011-KBT-DENPNUM-HEN-SEC       SECTION.
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   SRT-KBT-DENPNUM-MAX(IDX-SYU) )
                     OR  ( SRT-KBT-DENPNUM (IDX-SYU IDX0) 
                                   =   SYU-DENPNUM )
      *
               CONTINUE
      *
           END-PERFORM
      *
           IF    ( IDX0    >   SRT-KBT-DENPNUM-MAX (IDX-SYU) )
               IF    ( SRT-KBT-DENPNUM-MAX (IDX-SYU)
                                   <   CONST-SRT-KBT-DENPNUM-MAX )
                   COMPUTE SRT-KBT-DENPNUM-MAX (IDX-SYU)
                       =   SRT-KBT-DENPNUM-MAX (IDX-SYU)
                       +   1
                   MOVE    SRT-KBT-DENPNUM-MAX (IDX-SYU)
                                          TO  IDX3
                   MOVE    SYU-DENPNUM    TO  SRT-KBT-DENPNUM
                                         (IDX-SYU IDX3)
               END-IF
           END-IF
      *
           .
       20011-KBT-DENPNUM-HEN-EXT.
           EXIT.
      *****************************************************************
      *    診療日退避処理
      *****************************************************************
       20011-KBT-SRYYMD-HEN-SEC        SECTION.
      *
           MOVE    SYU-DENPPRTYMD  TO  SRT-KBT-DENPPRTYMD  (IDX-SYU)
      *
           IF    ( SRT-KBT-STSRYYMD (IDX-SYU)   =   SPACE )
               MOVE    SYU-SRYYMD  TO  SRT-KBT-STSRYYMD (IDX-SYU)
           ELSE
               IF    ( SYU-SRYYMD  <   SRT-KBT-STSRYYMD (IDX-SYU))
                   MOVE    SYU-SRYYMD
                                   TO  SRT-KBT-STSRYYMD (IDX-SYU)
               END-IF
           END-IF
      *
           IF    ( SRT-KBT-EDSRYYMD (IDX-SYU)   =   SPACE )
               MOVE    SYU-SRYYMD  TO  SRT-KBT-EDSRYYMD (IDX-SYU)
           ELSE
               IF    ( SYU-SRYYMD  >   SRT-KBT-EDSRYYMD (IDX-SYU))
                   MOVE    SYU-SRYYMD
                                   TO  SRT-KBT-EDSRYYMD (IDX-SYU)
               END-IF
           END-IF
      *
           .
       20011-KBT-SRYYMD-HEN-EXT.
           EXIT.
      *****************************************************************
      *    請求情報退避処理
      *****************************************************************
       20011-KBT-SEIKYU-HEN-SEC        SECTION.
      *
           COMPUTE SRT-KBT-SEIKYU (IDX-SYU)
               =   SRT-KBT-SEIKYU (IDX-SYU)
               +   SYU-SKYMONEY
               - ( SYU-NYUKIN-TOTAL    -   SYUPARA02-NYUKIN )
      *
           COMPUTE SRT-KBT-NYUKIN (IDX-SYU)
               =   SRT-KBT-NYUKIN (IDX-SYU)
               +   SYUPARA02-NYUKIN
      *
           IF    ( SYU-NYUKIN-TOTAL    NOT =   SYUPARA02-NYUKIN )
               MOVE    1           TO  SRT-KBT-TUIKANYUKINFLG (IDX-SYU)
           END-IF
      *
           .
       20011-KBT-SEIKYU-HEN-EXT.
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
      *    パラメタテーブル編集処理
      *****************************************************************
       2001-EDIT-PARA-SEC              SECTION.
      *
           INITIALIZE                  PARA-REC
           MOVE    ORCHC03S02-GYOUMUID TO  PARA-GYOUMUID
           MOVE    ORCHC03S02-TERMID   TO  PARA-TERMID
           MOVE    ORCHC03S02-FILEMEI  TO  WRK-FILEMEI
           MOVE    "00102"             TO  WRK-FILEMEI-CD
           MOVE    WRK-FILEMEI         TO  PARA-FILEMEI
      *
           PERFORM VARYING IDX4    FROM    1   BY  1
                   UNTIL ( IDX4    >   SRT-MAX )
                    OR   ( ORCHC03S02-RC   NOT =   ZERO )
      *
               IF    ( SYUPARA01-ZEROSKYKBN    =   "1" )
                   IF    ( LNKSYU-SKYMONEY(IDX4)    >      ZERO )
                       PERFORM 20011-EDIT-PARA-SEC
                   END-IF
               ELSE
                       PERFORM 20011-EDIT-PARA-SEC
               END-IF
      *
           END-PERFORM
      *
           MOVE    PARA-EDANUM         TO  ORCHC03S02-CNT
      *
           .
       2001-EDIT-PARA-EXT.
           EXIT.
      *****************************************************************
      *    パラメタテーブル編集処理
      *****************************************************************
       20011-EDIT-PARA-SEC               SECTION.
      *
           COMPUTE PARA-EDANUM =   PARA-EDANUM +   1
           INITIALIZE              SYUPARA03-AREA
      *
           IF    ( SYUPARA01-HAKKOFLG  =   4 )
               CONTINUE
           ELSE
               MOVE    SRT-SRTDENPNUM (IDX4)
                                           TO  SYUPARA03-DENPNUM
           END-IF
      *
           MOVE    SRT-KBT-SEIKYU(IDX4)    TO  SYUPARA03-SEIKYU
      *
           IF    ( SRT-KBT-TUIKANYUKINFLG (IDX4)
                                =   ZERO )
               MOVE   LNKSYU-SKYMONEY-TAX-SAI(IDX4)
                               TO  SYUPARA03-SEIKYU-TAX-SAI
           END-IF
      *
           IF    ( PARA-EDANUM     =   1 )
               IF    ( SYUPARA01-GAI-MISYU >=  ZERO )
                   MOVE    SYUPARA01-GAI-MISYU
                               TO  SYUPARA03-MISYU
               ELSE
                   MOVE    SYUPARA01-GAI-MISYU
                               TO  SYUPARA03-HENKIN
               END-IF
      *
               MOVE    SYUPARA01-GAI-MISYU-P
                               TO  SYUPARA03-MISYU-P
               MOVE    SYUPARA01-GAI-MISYU-M
                               TO  SYUPARA03-MISYU-M
               MOVE    SYUPARA01-NYU-MISYU
                               TO  SYUPARA03-NYU-MISYU
      *
           END-IF
           MOVE    SRT-KBT-NYUKIN  (IDX4)  TO  SYUPARA03-NYUKIN
           MOVE    SRT-KBT-STSRYYMD(IDX4)  TO  SYUPARA03-STSRYYMD
           MOVE    SRT-KBT-EDSRYYMD(IDX4)  TO  SYUPARA03-EDSRYYMD
      *
           MOVE    SRT-KBT-SRYKA-MAX (IDX4)
                           TO  SYUPARA03-SRYKA-MAX
      *
           MOVE    1       TO  WRK-SRYKA-PNT
           MOVE    SPACE   TO  WRK-SRYKAMEI
      *
           MOVE    SRT-KBT-SRYKA-MAX (IDX4)
                           TO  WRK-MAX
           PERFORM VARYING IDX5    FROM    1   BY  1
                   UNTIL ( IDX5    >   WRK-MAX )
      *
               MOVE    SRT-KBT-SRYKA (IDX4 IDX5)
                           TO  SYUPARA03-SRYKA (IDX5)
      *
               MOVE    SRT-KBT-SRYKA (IDX4 IDX5)
                           TO  WRK-SRYKA
               MOVE    SRT-KBT-STSRYYMD (IDX4)
                           TO  WRK-SRYYMD
               PERFORM 20011-SRYKAMEI-HEN-SEC
      *
           END-PERFORM
      *
           MOVE    WRK-SRYKAMEI    TO  SYUPARA03-SRYKAMEI
      *
           IF    ( SRT-KBT-SRYKA-MAX (IDX4)
                                   >       1 )
               CONTINUE
           ELSE
               MOVE    SRT-KBT-SRYKA (IDX4 1)
                                   TO  LNKSYU-SRYKA  (IDX4)
           END-IF
      *
           MOVE    SRT-KBT-HKNCOMBI-MAX (IDX4)
                           TO  SYUPARA03-HKNCOMBI-MAX
           MOVE    SRT-KBT-HKNCOMBI-MAX (IDX4)
                           TO  WRK-MAX
           PERFORM VARYING IDX5    FROM    1   BY  1
                   UNTIL ( IDX5    >   WRK-MAX )
      *
               MOVE    SRT-KBT-HKNCOMBI-OCC (IDX4 IDX5)
                           TO  SYUPARA03-HKNCOMBI-OCC (IDX5)
      *
           END-PERFORM
      *
           IF    ( SRT-KBT-HKNCOMBI-MAX (IDX4)
                                   >       1 )
               MOVE    "複数保険使用"  TO  SYUPARA03-HKNCOMBIMEI
               MOVE    ZERO            TO  LNKSYU-PTFTNRATE  (IDX4)
           ELSE
               MOVE    SRT-KBT-HKNCOMBI (IDX4 1)
                                       TO  LNKSYU-HKNCOMBINUM(IDX4)
               MOVE    SRT-KBT-PTFTNRATE(IDX4 1)
                                       TO  LNKSYU-PTFTNRATE  (IDX4)
               MOVE    SRT-KBT-HKNCOMBI (IDX4 1)
                                       TO  WRK-HKNCOMBI
               PERFORM 2001-HKNCOMBI-HEN-SEC
               MOVE    WRK-HKNCOMBIMEI TO  SYUPARA03-HKNCOMBIMEI
           END-IF
      *
           MOVE    SRT-KBT-DENPNUM-MAX (IDX4)
                           TO  SYUPARA03-GRP-DENPNUM-MAX
           MOVE    SRT-KBT-DENPNUM-MAX (IDX4)
                           TO  WRK-MAX
           PERFORM VARYING IDX5    FROM    1   BY  1
                   UNTIL ( IDX5    >   WRK-MAX )
      *
               MOVE    SRT-KBT-DENPNUM (IDX4 IDX5)
                           TO  SYUPARA03-GRP-DENPNUM (IDX5)
      *
           END-PERFORM
      *
           MOVE    SYUPARA03-STSRYYMD  TO  LNKSYU-SRYYMD (IDX4)
      *
           IF    ( SYUPARA01-SKYSUMFLG =   0 )
            OR   ( SYUPARA01-HAKKOFLG  =   1 )
               MOVE    SRT-KBT-DENPPRTYMD (IDX4)
                                       TO  LNKSYU-DENPPRTYMD (IDX4)
           ELSE
               MOVE    SYUPARA01-DENPPRTYMD
                                       TO  LNKSYU-DENPPRTYMD (IDX4)
           END-IF
      *
           MOVE    LNKSYU-OCC (IDX4)   TO  SYUPARA03-SYU-DATA
      *
           MOVE    SYUPARA03-AREA  TO  PARA-DATA-REC
           MOVE    SPA-HOSPNUM         TO  PARA-HOSPNUM
           MOVE    PARA-REC        TO  MCPDATA-REC
           MOVE    "tbl_para"      TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBINSERT-SEC
           IF    ( MCP-RC      NOT =   ZERO )
               MOVE    1           TO  ORCHC03S02-RC
           END-IF
      *
           .
       20011-EDIT-PARA-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ名称編集処理
      *****************************************************************
       2001-HKNCOMBI-HEN-SEC             SECTION.
      *
      *    保険組合せマスター検索
           PERFORM 900-HKNCOMBI-KEY-SEL-SEC
           IF    ( FLG-HKNCOMBI        =   1 )
                DISPLAY "*** HKNCOMBI  ERR:"   COMB-KEY "."
           END-IF
      *
           PERFORM 20011-HKNCOMBIMEI-HEN-SEC
      *
           IF    ( COMB-HKNNUM         =   "971" OR "973" )
      *
      *        患者労災保険情報検索
               PERFORM 900-PTRSIINF-KEY-SEC
           ELSE
               INITIALIZE                      PTRSIINF-REC
           END-IF
      *
           .
       2001-HKNCOMBI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ名称編集処理
      *****************************************************************
       20011-HKNCOMBIMEI-HEN-SEC             SECTION.
      *
           MOVE    SPACE               TO  WRK-HKNCOMBIMEI
      *
           STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                   "　"                    DELIMITED  BY  SIZE
                   COMB-KOH1-TANSEIDONAME  DELIMITED  BY  SPACE
                   "　"                    DELIMITED  BY  SIZE
                   COMB-KOH2-TANSEIDONAME  DELIMITED  BY  SPACE
                   "　"                    DELIMITED  BY  SIZE
                   COMB-KOH3-TANSEIDONAME  DELIMITED  BY  SPACE
                   "　"                    DELIMITED  BY  SIZE
                   COMB-KOH4-TANSEIDONAME  DELIMITED  BY  SPACE
                         INTO              WRK-HKNCOMBIMEI
           END-STRING
      *
           .
       20011-HKNCOMBIMEI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    診療科名編集処理
      *****************************************************************
       20011-SRYKAMEI-HEN-SEC              SECTION.
      *
      *    診療科
           INITIALIZE                      SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    WRK-SRYKA           TO  SYS-1005-KBNCD
           MOVE    WRK-SRYYMD          TO  SYS-1005-STYUKYMD
                                           SYS-1005-EDYUKYMD
           MOVE    SPA-HOSPNUM         TO  SYS-1005-HOSPNUM
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           IF    ( FLG-SYSKANRI        =   ZERO )
      *
               MOVE    MCPDATA-REC     TO  SYS-1005-REC
               IF    ( WRK-SRYKAMEI   =   SPACE )
                   STRING  SYS-1005-SRYKANAME2
                                               DELIMITED  BY  SPACE
                   INTO            WRK-SRYKAMEI
                   WITH    POINTER WRK-SRYKA-PNT
                   END-STRING
               ELSE
                   IF    ( WRK-SRYKAMEI(19:2) NOT =   SPACE )
                       CONTINUE
                   ELSE
                       STRING  "、"            DELIMITED  BY  SIZE
                               SYS-1005-SRYKANAME2
                                               DELIMITED  BY  SPACE
                       INTO            WRK-SRYKAMEI
                       WITH    POINTER WRK-SRYKA-PNT
                       END-STRING
                   END-IF
               END-IF
           END-IF
      *
           .
       20011-SRYKAMEI-HEN-EXT.
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
      *    パラメタテーブル検索処理
      *****************************************************************
       900-PARA-KEY4-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-PARA
      *
           INITIALIZE                      PARA-REC
           MOVE    ORCHC03S02-GYOUMUID TO  PARA-GYOUMUID
           MOVE    ORCHC03S02-TERMID   TO  PARA-TERMID
           MOVE    ORCHC03S02-FILEMEI  TO  PARA-FILEMEI
           MOVE    1                   TO  PARA-EDANUM
      *
           MOVE    SPA-HOSPNUM         TO  PARA-HOSPNUM
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "tbl_para"          TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  PARA-REC
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1               TO  FLG-PARA
           END-IF
      *
           MOVE    "tbl_para"          TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
      *
       900-PARA-KEY4-SEL-EXT.
           EXIT.
      *****************************************************************
      *    パラメタテーブル検索処理
      *****************************************************************
       900-PARA-KEY6-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-PARA
      *
           INITIALIZE                      PARA-REC
           MOVE    ORCHC03S02-GYOUMUID TO  PARA-GYOUMUID
           MOVE    ORCHC03S02-TERMID   TO  PARA-TERMID
           MOVE    ORCHC03S02-FILEMEI  TO  PARA-FILEMEI
           MOVE    2                   TO  PARA-EDANUM
      *
           MOVE    SPA-HOSPNUM         TO  PARA-HOSPNUM
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "tbl_para"          TO  MCP-TABLE
           MOVE    "key6"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  PARA-REC
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1               TO  FLG-PARA
           END-IF
      *
           .
      *
       900-PARA-KEY6-SEL-EXT.
           EXIT.
      *****************************************************************
      *    パラメタテーブルFETCH処理
      *****************************************************************
       900-PARA-KEY6-FET-SEC           SECTION.
      *
           MOVE    "tbl_para"          TO  MCP-TABLE
           MOVE    "key6"              TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  PARA-REC
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1               TO  FLG-PARA
           END-IF
      *
           .
      *
       900-PARA-KEY6-FET-EXT.
           EXIT.
      *****************************************************************
      *    収納テーブル検索処理
      *****************************************************************
       900-SYUNOU-KEY-SEL-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-SYUNOU
      *
           INITIALIZE                      SYUNOU-REC
           MOVE    SPA-HOSPNUM         TO  SYU-HOSPNUM
           MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-PTID            TO  SYU-PTID
           MOVE    SYUPARA02-DENPNUM   TO  SYU-DENPNUM
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "tbl_syunou"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
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
      *
       900-SYUNOU-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ検索処理(KEY)
      *****************************************************************
       900-HKNCOMBI-KEY-SEL-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-HKNCOMBI
      *
           INITIALIZE                      HKNCOMBI-REC
           MOVE    SPA-HOSPNUM         TO  COMB-HOSPNUM
           MOVE    SPA-PTID            TO  COMB-PTID
           MOVE    WRK-HKNCOMBI        TO  COMB-HKNCOMBINUM
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    "tbl_hkncombi"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  HKNCOMBI-REC
            ELSE
               INITIALIZE                  HKNCOMBI-REC
               MOVE    1               TO  FLG-HKNCOMBI
            END-IF
      *
           MOVE    "tbl_hkncombi"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-HKNCOMBI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者労災保険情報読み込み
      *****************************************************************
       900-PTRSIINF-KEY-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-PTRSIINF
      *
           INITIALIZE                      PTRSIINF-REC
           MOVE    SPA-HOSPNUM         TO  PTRSI-HOSPNUM
           MOVE    SPA-PTID            TO  PTRSI-PTID
           MOVE    COMB-HKNID          TO  PTRSI-HKNID
           MOVE    PTRSIINF-REC        TO  MCPDATA-REC
           MOVE    "tbl_ptrsiinf"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  PTRSIINF-REC
           ELSE
               MOVE    1               TO  FLG-PTRSIINF
               INITIALIZE                  PTRSIINF-REC
           END-IF
     *
           MOVE    "tbl_ptrsiinf"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-PTRSIINF-KEY-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ検索処理(KEY10)
      *****************************************************************
       900-SYSKANRI-KEY10-SEL-SEC      SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYSKANRI-REC
           END-IF
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-SYSKANRI-KEY10-SEL-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
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
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
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
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
      *
       910-DBCLOSECURSOR-EXT.
           EXIT.
           .
      *****************************************************************
      *    ＤＢインサート処理
      *****************************************************************
       910-DBINSERT-SEC                SECTION.
      *
           MOVE    "DBINSERT"          TO  MCP-FUNC
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
      *
       910-DBINSERT-EXT.
           EXIT.
