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
       PROGRAM-ID.             ORCBM027.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 社保・総括表（医科・入院外）
      *                      ＨＣＭ２Ｋ、ＨＣＭ２Ｌ
      *                      ２００３．４改正対応
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/10/08    NACL-藤原      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
           COPY    "HCM2K.INC".
           COPY    "HCM2L.INC".
      *
      *    スパ領域
       01  STS-AREA.
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-HKNNUM          PIC 9(01).
           03  FLG-MF01-END        PIC 9(01).
           03  FLG-PRTKBN          PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-LINE            PIC 9(02).
           03  CNT-PAGE            PIC 9(03).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY          PIC 9(02).
               05  SYS-MM          PIC 9(02).
               05  SYS-DD          PIC 9(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
      *
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).      
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SEIYMD        PIC X(08).
           03  WRK-SEIYMDWH      PIC X(22).
           03  WRK-SRYYMWH       PIC X(16).
           03  WRK-SRYYMD        PIC X(08).
      *
           03  WRK-SYMD.
               05  WRK-SYY           PIC 9(04).
               05  WRK-SMM           PIC 9(02).
               05  WRK-SDD           PIC 9(02).
           03  WRK-HENYMDG           PIC X(22).
      *
           03  WRK-RECEERR             PIC X(200). 
      *
           03  WRK-YMD               PIC X(07).
      *
           03  WRK-Z9                PIC ZZZZZ.
           03  WRK-ZZ9               PIC ZZ,ZZZ,ZZZ.
           03  WRK-NISSUZ            PIC ZZZZZZ.
           03  WRK-KENSUZ            PIC ZZZZZZ.
           03  WRK-TENSUZ            PIC ZZ,ZZZ,ZZZ.
           03  WRK-FTNMONEYZ         PIC Z,ZZZ,ZZZ. 
           03  WRK-GKENSUZ           PIC ZZZZZZZ. 
      *             
           03  WRK-KOHKBN.
               05  WRK-KOHNUM        PIC X(04).
               05  WRK-HKNNAME       PIC X(40). 
      *
           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".
      *
      *    ２００３年４月改正
           03  WRK-CONS-SRYYM-200304   PIC X(06)   VALUE   "200304".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *     
      *    保険番号
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    医療機関情報情報
           COPY    "CPSK1001.INC".
      *
      *    医療機関情報−所在地、連絡先 
           COPY    "CPSK1002.INC".
      *
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".          
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    半角チェックサブ
           COPY    "CPORCSKANACHK.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    印刷ＤＢ更新サブ
           COPY    "CPORCSPRT.INC".          
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    共通パラメタ
           COPY    "MCPAREA".
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
      *    集計領域
       01  SUM-AREA.
      *    1:その他のレセ、2:在総診を算定したレセ 
           03  SUM-TBL-OCC         OCCURS  2.
      *        医療保険　1,2:７０以上 3:本人 4:家族 5:三歳 
               05  SUM-TABLE           OCCURS  5. 
                   07  SUM-TBL             OCCURS  12.
                       09  SUM-KENSU          PIC  9(06).
                       09  SUM-NISSU          PIC  9(06).
                       09  SUM-TOTALTEN       PIC  9(10).
                       09  SUM-FTNMONEY       PIC  9(10).
                       09  SUM-YKZFTN         PIC  9(10).
                       09  SUM-SHOKUJIKENSU   PIC  9(06).
                       09  SUM-SHOKUJINISSU   PIC  9(06).
                       09  SUM-SHOKUJIRYOYOHI PIC  9(10).
                       09  SUM-SHOKUJIFTN     PIC  9(10).
      *        老人保健
               05  SUM-ROU-TABLE           OCCURS  2. 
                   07  SUM-ROU-TBL             OCCURS  3.
                       09  SUM-ROU-KENSU          PIC  9(06).
                       09  SUM-ROU-NISSU          PIC  9(06).
                       09  SUM-ROU-TOTALTEN       PIC  9(10).
                       09  SUM-ROU-FTNMONEY       PIC  9(10).
                       09  SUM-ROU-SHOKUJIKENSU   PIC  9(06).
                       09  SUM-ROU-SHOKUJINISSU   PIC  9(06).
                       09  SUM-ROU-SHOKUJIRYOYOHI PIC  9(10).
                       09  SUM-ROU-SHOKUJIFTN     PIC  9(10).
               05  SUM-ROU-GOKEI.
                   07  SUM-ROU-GOK-NISSU          PIC  9(06).
                   07  SUM-ROU-GOK-TOTALTEN       PIC  9(10).
                   07  SUM-ROU-GOK-FTNMONEY       PIC  9(10).
                   07  SUM-ROU-GOK-SHOKUJINISSU   PIC  9(06).
                   07  SUM-ROU-GOK-SHOKUJIRYOYOHI PIC  9(10).
                   07  SUM-ROU-GOK-SHOKUJIFTN     PIC  9(10).
      *        公費負担 
               05  SUM-KOH-TABLE           OCCURS  3. 
                   07  SUM-KOH-TBL         OCCURS  100.
                       09  SUM-KOH-KOHNUM         PIC  X(03).
                       09  SUM-KOH-KENSU          PIC  9(06).
                       09  SUM-KOH-TOTALTEN       PIC  9(10).
                       09  SUM-KOH-FTNMONEY       PIC  9(10).
                       09  SUM-KOH-YKZFTN         PIC  9(10).
                       09  SUM-KOH-SHOKUJIKENSU   PIC  9(06).
                       09  SUM-KOH-SHOKUJIRYOYOHI PIC  9(10).
                       09  SUM-KOH-SHOKUJIFTN     PIC  9(10).
      *        合計         
               05  SUM-GOK-TBL         OCCURS  4.
                   07  SUM-GOK-KENSU      PIC 9(06).    
                   07  SUM-GOK-SHOKENSU   PIC 9(06).
      *         
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-HOSPID     PIC X(24).
           03  WRK-PARA-JOBID      PIC 9(07).
           03  WRK-PARA-SHELLID    PIC X(08).
           03  WRK-PARA-PAGE       PIC 9(10).
           03  WRK-PARA-NYUGAIKBN  PIC X(01).
      *
      ******************************************************************
      *
       PROCEDURE                       DIVISION
                                       USING   SUM-AREA
                                               WRK-PARA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
                   UNTIL       FLG-END     =   1
      *
           PERFORM 300-END-SEC
      *
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           DISPLAY "*** ORCBM027 START ***"
      * 
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
      *
           MOVE    LNK-PRTKANRI-SRYYM  TO  WRK-SRYYMD (1:6)
           MOVE    "01"                TO  WRK-SRYYMD (7:2)
           MOVE    LNK-PRTKANRI-SRYYM  TO  WRK-SYMD (1:6)
           MOVE    "01"                TO  WRK-SYMD (7:2)
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG(1:16)   TO  WRK-SRYYMWH 
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  RECEERR-TERMID
      *
      *    システム管理マスタ（医療機関情報）
           PERFORM 120-HOSPINF-GET-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    医療機関情報検索
      *****************************************************************
       120-HOSPINF-GET-SEC            SECTION.
      *
      *    システム日付セット
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    LNK-PRTKANRI-SKYYMD TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA          
           IF      STS-DAY-RC1         =   ZERO 
               MOVE    LNK-DAY2-EDTYMD3    TO  WRK-SEIYMDWH
           END-IF
      *
      *    医療機関ＩＤ編集
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC        TO  SYS-1001-REC
               IF      SYS-1001-HOSPNAME   =   LOW-VALUE
                   MOVE    SPACE               TO  SYS-1001-HOSPNAME
               END-IF    
               IF      SYS-1001-KAISETUNAME    =   LOW-VALUE
                   MOVE    SPACE               TO  SYS-1001-KAISETUNAME
               END-IF    
           ELSE
               MOVE    "医療機関情報が取得できませんでした"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                   TO  FLG-END
           END-IF 
      *
      *    医療機関情報−所在地、連絡先
           INITIALIZE                  SYS-1002-REC
           MOVE    "1002"              TO  SYS-1002-KANRICD
           MOVE    "*"                 TO  SYS-1002-KBNCD
           MOVE    SYS-1002-REC        TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC        TO  SYS-1002-REC
               IF      SYS-1002-ADRS       =   LOW-VALUE
                   MOVE    SPACE               TO  SYS-1002-ADRS
               END-IF    
           ELSE
               MOVE    "医療機関情報（所在地）が取得できませんでした"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                   TO  FLG-END
           END-IF 
           .
       120-HOSPINF-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           MOVE    ZERO                TO  FLG-MF01-END 
      *     
           PERFORM VARYING IDX1    FROM   1   BY  1
                   UNTIL   IDX1    >   2
               IF      SUM-GOK-KENSU (IDX1 4)     >   ZERO 
                   MOVE    ZERO            TO  FLG-PRTKBN
      *           
      *            帳票編集<見出し・ＨＣＭ２Ｋ>処理
                   PERFORM 310-HEAD-HEN-01-SEC
      *            帳票編集<見出し・ＨＣＭ２Ｌ>処理
                   PERFORM 310-HEAD-HEN-02-SEC
      *            帳票編集<明細>処理
                   PERFORM 320-BODY-HEN-SEC
      *            帳票編集<合計>処理
                   PERFORM 330-TERM-HEN-SEC
      *            帳票印刷処理（２頁以降）
                   PERFORM 390-PRINT-OUT-SEC
               END-IF    
           END-PERFORM    
      *
           MOVE    1                  TO  FLG-END
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<見出し・ＨＣＭ２Ｋ>処理
      *****************************************************************
       310-HEAD-HEN-01-SEC          SECTION.
      *
           INITIALIZE                      HCM2K      
      *
           MOVE    WRK-SEIYMDWH        TO  HCM2K-SEIYMD
      *
           MOVE    WRK-SRYYMWH         TO  HCM2K-PRTYM
      *
      *    医療機関住所
           MOVE    SYS-1002-ADRS       TO  HCM2K-ADRS
      *    医療機関名
           MOVE    SYS-1001-HOSPNAME   TO  HCM2K-HOSPNAME
      *    開設者名
           MOVE    SYS-1001-KAISETUNAME
                                       TO  HCM2K-KAISETUNAME
      *    
           MOVE    SYS-1001-HOSPCDN    TO  HCM2K-HOSPCD
      *
           EVALUATE    IDX1
               WHEN    1
                   MOVE    "その他のレセ"      TO  HCM2K-TITLE  
               WHEN    2
                   MOVE    "在総診または在医総を算定したレセ"
                                               TO  HCM2K-TITLE     
           END-EVALUATE
           .
       310-HEAD-HEN-01-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<見出し・ＨＣＭ２Ｌ>処理
      *****************************************************************
       310-HEAD-HEN-02-SEC          SECTION.
      *
           INITIALIZE                      HCM2L
      *    
           MOVE    SYS-1001-HOSPCDN    TO  HCM2L-HOSPCD 
      *
           EVALUATE    IDX1
               WHEN    1
                   MOVE    "その他のレセ"      TO  HCM2L-TITLE  
               WHEN    2
                   MOVE    "在総診または在医総を算定したレセ"
                                               TO  HCM2L-TITLE     
           END-EVALUATE
      *
           .
       310-HEAD-HEN-02-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<明細行>処理
      *****************************************************************
       320-BODY-HEN-SEC      SECTION.
      *
      *    医保単独（７０以上９割）
           MOVE    1                   TO  IDX
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       10
               MOVE    SUM-KENSU    (IDX1 IDX IDY)  TO  WRK-KENSUZ
               MOVE    WRK-KENSUZ              TO  HCM2K-KENSU1 (IDY)
               MOVE    SUM-NISSU    (IDX1 IDX IDY)  TO  WRK-NISSUZ 
               MOVE    WRK-NISSUZ              TO  HCM2K-NISSU1 (IDY) 
               MOVE    SUM-TOTALTEN (IDX1 IDX IDY)  TO  WRK-TENSUZ
               MOVE    WRK-TENSUZ              TO  HCM2K-TENSU1 (IDY)
               MOVE    SUM-FTNMONEY (IDX1 IDX IDY)  TO  WRK-FTNMONEYZ
               MOVE    WRK-FTNMONEYZ           TO  HCM2K-ITBFTN1(IDY)
           END-PERFORM
           MOVE    SUM-KENSU    (IDX1 IDX 12)   TO  WRK-KENSUZ
           MOVE    WRK-KENSUZ              TO  HCM2K-KENSU1 (11)
           MOVE    SUM-NISSU    (IDX1 IDX 12)   TO  WRK-NISSUZ 
           MOVE    WRK-NISSUZ              TO  HCM2K-NISSU1 (11) 
           MOVE    SUM-TOTALTEN (IDX1 IDX 12)   TO  WRK-TENSUZ
           MOVE    WRK-TENSUZ              TO  HCM2K-TENSU1 (11)
           MOVE    SUM-FTNMONEY (IDX1 IDX 12)   TO  WRK-FTNMONEYZ
           MOVE    WRK-FTNMONEYZ           TO  HCM2K-ITBFTN1(11)
      *
      *    医保単独（７０以上８割）
           MOVE    2                   TO  IDX
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       8
               MOVE    SUM-KENSU    (IDX1 IDX IDY)  TO  WRK-KENSUZ
               MOVE    WRK-KENSUZ              TO  HCM2K-KENSU2 (IDY)
               MOVE    SUM-NISSU    (IDX1 IDX IDY)  TO  WRK-NISSUZ 
               MOVE    WRK-NISSUZ              TO  HCM2K-NISSU2 (IDY) 
               MOVE    SUM-TOTALTEN (IDX1 IDX IDY)  TO  WRK-TENSUZ
               MOVE    WRK-TENSUZ              TO  HCM2K-TENSU2 (IDY)
               MOVE    SUM-FTNMONEY (IDX1 IDX IDY)  TO  WRK-FTNMONEYZ
               MOVE    WRK-FTNMONEYZ           TO  HCM2K-ITBFTN2(IDY)
           END-PERFORM
           MOVE    SUM-KENSU    (IDX1 IDX 12)   TO  WRK-KENSUZ
           MOVE    WRK-KENSUZ              TO  HCM2K-KENSU2 (9)
           MOVE    SUM-NISSU    (IDX1 IDX 12)   TO  WRK-NISSUZ 
           MOVE    WRK-NISSUZ              TO  HCM2K-NISSU2 (9) 
           MOVE    SUM-TOTALTEN (IDX1 IDX 12)   TO  WRK-TENSUZ
           MOVE    WRK-TENSUZ              TO  HCM2K-TENSU2 (9)
           MOVE    SUM-FTNMONEY (IDX1 IDX 12)   TO  WRK-FTNMONEYZ
           MOVE    WRK-FTNMONEYZ           TO  HCM2K-ITBFTN2(9)
      *
      *    医保単独（本人）
           MOVE    3                   TO  IDX
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       11
               MOVE    SUM-KENSU    (IDX1 IDX IDY)  TO  WRK-KENSUZ
               MOVE    WRK-KENSUZ              TO  HCM2K-KENSU3 (IDY)
               MOVE    SUM-NISSU    (IDX1 IDX IDY)  TO  WRK-NISSUZ 
               MOVE    WRK-NISSUZ              TO  HCM2K-NISSU3 (IDY) 
               MOVE    SUM-TOTALTEN (IDX1 IDX IDY)  TO  WRK-TENSUZ
               MOVE    WRK-TENSUZ              TO  HCM2K-TENSU3 (IDY)
               IF      IDY             =   3
                   MOVE    SUM-FTNMONEY (IDX1 IDX IDY) 
                                               TO  WRK-FTNMONEYZ
                   MOVE    WRK-FTNMONEYZ       TO  HCM2K-ITBFTN3
               END-IF
           END-PERFORM
           MOVE    SUM-KENSU    (IDX1 IDX 12)   TO  WRK-KENSUZ
           MOVE    WRK-KENSUZ              TO  HCM2K-KENSU3 (12)
           MOVE    SUM-NISSU    (IDX1 IDX 12)   TO  WRK-NISSUZ 
           MOVE    WRK-NISSUZ              TO  HCM2K-NISSU3 (12) 
           MOVE    SUM-TOTALTEN (IDX1 IDX 12)   TO  WRK-TENSUZ
           MOVE    WRK-TENSUZ              TO  HCM2K-TENSU3 (12)
      *
      *    医保単独（家族）
           MOVE    4                   TO  IDX
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       8
               MOVE    SUM-KENSU    (IDX1 IDX IDY)  TO  WRK-KENSUZ
               MOVE    WRK-KENSUZ              TO  HCM2K-KENSU4 (IDY)
               MOVE    SUM-NISSU    (IDX1 IDX IDY)  TO  WRK-NISSUZ 
               MOVE    WRK-NISSUZ              TO  HCM2K-NISSU4 (IDY) 
               MOVE    SUM-TOTALTEN (IDX1 IDX IDY)  TO  WRK-TENSUZ
               MOVE    WRK-TENSUZ              TO  HCM2K-TENSU4 (IDY)
           END-PERFORM
           MOVE    SUM-KENSU    (IDX1 IDX 12)   TO  WRK-KENSUZ
           MOVE    WRK-KENSUZ              TO  HCM2K-KENSU4 (9)
           MOVE    SUM-NISSU    (IDX1 IDX 12)   TO  WRK-NISSUZ 
           MOVE    WRK-NISSUZ              TO  HCM2K-NISSU4 (9) 
           MOVE    SUM-TOTALTEN (IDX1 IDX 12)   TO  WRK-TENSUZ
           MOVE    WRK-TENSUZ              TO  HCM2K-TENSU4 (9)
      *
      *    医保単独（三歳）
           MOVE    5                   TO  IDX
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       8
               MOVE    SUM-KENSU    (IDX1 IDX IDY)  TO  WRK-KENSUZ
               MOVE    WRK-KENSUZ              TO  HCM2K-KENSU5 (IDY)
               MOVE    SUM-NISSU    (IDX1 IDX IDY)  TO  WRK-NISSUZ 
               MOVE    WRK-NISSUZ              TO  HCM2K-NISSU5 (IDY) 
               MOVE    SUM-TOTALTEN (IDX1 IDX IDY)  TO  WRK-TENSUZ
               MOVE    WRK-TENSUZ              TO  HCM2K-TENSU5 (IDY)
           END-PERFORM
           MOVE    SUM-KENSU    (IDX1 IDX 12)   TO  WRK-KENSUZ
           MOVE    WRK-KENSUZ              TO  HCM2K-KENSU5 (9)
           MOVE    SUM-NISSU    (IDX1 IDX 12)   TO  WRK-NISSUZ 
           MOVE    WRK-NISSUZ              TO  HCM2K-NISSU5 (9) 
           MOVE    SUM-TOTALTEN (IDX1 IDX 12)   TO  WRK-TENSUZ
           MOVE    WRK-TENSUZ              TO  HCM2K-TENSU5 (9)
      *
           MOVE    SUM-GOK-KENSU (IDX1 1)  TO  WRK-KENSUZ
           MOVE    WRK-KENSUZ              TO  HCM2K-KENSUG   
      *
      *    老人保健
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       2
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       3
                   MOVE    SUM-ROU-KENSU    (IDX1 IDX IDY) 
                                           TO  WRK-KENSUZ
                   MOVE    WRK-KENSUZ      TO  HCM2L-ROU-KENSU (IDX IDY) 
                   IF      IDY                 <   3
                       MOVE    SUM-ROU-NISSU    (IDX1 IDX IDY)
                                           TO  WRK-NISSUZ 
                       MOVE    WRK-NISSUZ  TO  HCM2L-ROU-NISSU (IDX IDY) 
                       MOVE    SUM-ROU-TOTALTEN (IDX1 IDX IDY)
                                           TO  WRK-TENSUZ
                       MOVE    WRK-TENSUZ  TO  HCM2L-ROU-TENSU (IDX IDY) 
                   END-IF
               END-PERFORM    
           END-PERFORM
      *     
           MOVE    SUM-GOK-KENSU (IDX1 2)  TO  WRK-KENSUZ
           MOVE    WRK-KENSUZ              TO  HCM2L-KENSUG (1)    
      *     
      *    帳票印刷処理（１頁目）
           MOVE    ZERO                TO  FLG-PRTKBN
           PERFORM 390-PRINT-OUT-SEC
           MOVE    1                   TO  FLG-PRTKBN
      *    公費負担分編集処理
           MOVE    ZERO                TO  FLG-MF01-END
           MOVE    1                   TO  IDX2
      * 
           PERFORM 3201-KOH-HENSYU-SEC
                                   UNTIL   FLG-MF01-END   =   1
           .
       320-BODY-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<公費負担分>処理
      *****************************************************************
      *    
       3201-KOH-HENSYU-SEC         SECTION.
      *
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       6         
                   OR      FLG-MF01-END    =   1  
               IF      SUM-KOH-KOHNUM (IDX1 1 IDX2)    =   SPACE
               AND     SUM-KOH-KOHNUM (IDX1 2 IDX2)    =   SPACE
               AND     SUM-KOH-KOHNUM (IDX1 3 IDX2)    =   SPACE
                   MOVE    1                   TO  FLG-MF01-END
               ELSE    
                   PERFORM VARYING IDX     FROM    1   BY  1
                           UNTIL   IDX     >       3
                       IF      SUM-KOH-KOHNUM (IDX1 IDX IDX2)  =   SPACE
                           CONTINUE
                       ELSE    
                           PERFORM 3202-HKNNUM-HENSYU-SEC     
                           MOVE    SUM-KOH-KENSU (IDX1 IDX IDX2)
                                           TO  WRK-KENSUZ        
                           MOVE    WRK-KENSUZ
                                           TO  HCM2L-KOH-KENSU (IDX IDY)
                           MOVE    SUM-KOH-TOTALTEN (IDX1 IDX IDX2)
                                           TO  WRK-TENSUZ         
                           MOVE    WRK-TENSUZ
                                           TO  HCM2L-KOH-TENSU (IDX IDY)
                           MOVE    SUM-KOH-FTNMONEY (IDX1 IDX IDX2)
                                           TO  WRK-FTNMONEYZ
                           MOVE    WRK-FTNMONEYZ
                                           TO  HCM2L-KOH-ITBFTN(IDX IDY)
                       END-IF
                   END-PERFORM
                   ADD     1                   TO  IDX2   
               END-IF        
           END-PERFORM
      *
           IF      SUM-KOH-KOHNUM (IDX1 1 IDX2)    =   SPACE
           AND     SUM-KOH-KOHNUM (IDX1 2 IDX2)    =   SPACE
           AND     SUM-KOH-KOHNUM (IDX1 3 IDX2)    =   SPACE
               MOVE    1                      TO  FLG-MF01-END
           ELSE
      *        帳票印刷処理（２頁以降）
               PERFORM 390-PRINT-OUT-SEC
      *        帳票編集<見出し>処理
               PERFORM 310-HEAD-HEN-02-SEC
           END-IF     
      *
           .
       3201-KOH-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費保険区分編集処理
      *****************************************************************
      *    
       3202-HKNNUM-HENSYU-SEC         SECTION.
      *
           MOVE    SPACE               TO  WRK-KOHKBN
      *
           MOVE    SUM-KOH-KOHNUM (IDX1 IDX IDX2)
                                       TO  WRK-Z9
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"                 TO  KANACHK-SYORI 
           MOVE    WRK-Z9 (4:2)        TO  KANACHK-MAE-INPUT 
           CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
           IF      KANACHK-RC          =   ZERO
           AND     KANACHK-MAX         >   ZERO
               MOVE    KANACHK-OUT-INPUT(1:KANACHK-MAX)
                                           TO  WRK-KOHNUM
           END-IF    
      *    保険番号読込み  
           INITIALIZE                      HKNNUM-REC
           MOVE   SYS-1001-HOSPID      TO    HKN-HOSPID
           MOVE   SUM-KOH-KOHNUM (IDX1 IDX IDX2)
                                       TO    HKN-HKNNUM
           MOVE   HKNNUM-REC           TO    MCPDATA-REC
           MOVE   "DBSELECT"           TO    MCP-FUNC
           MOVE   "HKNNUM-KEY2"        TO    ORC-DBPATH
           CALL   "ORCMCPSUB"           USING MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNNUM-KEY2"       TO  ORC-DBPATH
               PERFORM 900-HKNNUM-READ-SEC
           ELSE
               MOVE    1                  TO  FLG-HKNNUM
           END-IF
      *
           PERFORM UNTIL       FLG-HKNNUM      =   1
               IF      HKN-TEKSTYMD            <=  WRK-SRYYMD
               AND     HKN-TEKEDYMD            >=  WRK-SRYYMD
                   IF     SUM-KOH-KOHNUM (IDX1 IDX IDX2)    =   "027"
                       IF      SYS-1001-HOSPSBT    =   HKN-PAYKBN (1:1)
                       AND     SYS-1001-ROUPAYKBN  =   HKN-PAYKBN (2:1)
                           STRING  "（"            DELIMITED  BY  SIZE
                                   HKN-TANSEIDONAME
                                                   DELIMITED  BY  SPACE
                                   "）"            DELIMITED  BY  SIZE
                                                   INTO   WRK-HKNNAME
                           END-STRING
                           MOVE    1                   TO  FLG-HKNNUM
                       END-IF
                   ELSE
                       STRING  "（"                DELIMITED  BY  SIZE
                               HKN-TANSEIDONAME    DELIMITED  BY  SPACE
                               "）"                DELIMITED  BY  SIZE
                                                   INTO   WRK-HKNNAME
                       END-STRING
                       MOVE    1                   TO  FLG-HKNNUM 
                   END-IF     
               END-IF
      *
               IF      FLG-HKNNUM           =   ZERO
                   MOVE    "HKNNUM-KEY2"       TO  ORC-DBPATH
                   PERFORM 900-HKNNUM-READ-SEC
               END-IF 
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNNUM-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           MOVE    WRK-KOHKBN          TO  HCM2L-KOHKBN (IDX IDY)
           .
       3202-HKNNUM-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<合計>処理
      *****************************************************************
      *    
       330-TERM-HEN-SEC         SECTION.
      *    合計・総合計
      *
           MOVE    SUM-GOK-KENSU (IDX1 3)  TO  WRK-KENSUZ
           MOVE    WRK-KENSUZ              TO  HCM2L-KENSUG (2)
      *
           MOVE    SUM-GOK-KENSU (IDX1 4)  TO  WRK-GKENSUZ
           MOVE    WRK-GKENSUZ             TO  HCM2L-GKENSU
           .
       330-TERM-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       390-PRINT-OUT-SEC                SECTION.
      *
           ADD     1                   TO  CNT-PAGE
      *     
           INITIALIZE                  ORCSPRTAREA
           MOVE    "INS"               TO  SPRT-MODE
           MOVE    LNK-PRTKANRI-RENNUM TO  SPRT-RENNUM
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  SPRT-TBL-KEY
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  SPRT-TBL-GROUP
           MOVE    LNK-PRTKANRI-SRYYM  TO  SPRT-SRYYM
           MOVE    LNK-PRTKANRI-SKYYMD TO  SPRT-SKYYMD
           MOVE    LNK-PRTKANRI-SHELLID 
                                       TO  SPRT-SHELLID
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                       TO  SPRT-SHORI-RENNUM
           MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  SPRT-PRIORITY
           IF      FLG-PRTKBN          =   ZERO                            
               MOVE    "HCM2K.red"         TO  SPRT-PRTID
               MOVE    HCM2K               TO  SPRT-PRTDATA
           ELSE                          
               MOVE    "HCM2L.red"         TO  SPRT-PRTID
               MOVE    HCM2L               TO  SPRT-PRTDATA
           END-IF    
           EVALUATE    IDX1
               WHEN    1                            
                   MOVE    "社保総括表"        TO  SPRT-TITLE
               WHEN    2                            
                   MOVE    "社保総括表（在総診等）"
                                               TO  SPRT-TITLE
           END-EVALUATE        
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF      SPRT-RETURN         =   ZERO
               CONTINUE
           ELSE
               MOVE    "印刷ＤＢに更新できませんでした"
                                          TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC                           
           END-IF                                                              
           .
       390-PRINT-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       31012-SEIWA-HEN-SEC        SECTION.
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG
           INSPECT WRK-HENYMDG    REPLACING  ALL "  "  BY  "　"
           .
       31012-SEIWA-HEN-EXT.
           EXIT.
057400*
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC                SECTION.
      *
           OPEN    INPUT   RECEERR-FILE
           IF      STS-RECEERR         =   ZERO
               CLOSE   RECEERR-FILE
           ELSE
               OPEN    OUTPUT              RECEERR-FILE
      *
               MOVE    WRK-RECEERR         TO  RECEERR-REC
               WRITE   RECEERR-REC
               CLOSE   RECEERR-FILE
      *         
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA  
                                       JOBKANRI-REC
           END-IF
      *
           MOVE    1                   TO  FLG-END     
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           ADD     CNT-PAGE        TO  WRK-PARA-PAGE
      *
           DISPLAY "*** ORCBM027 PAGE  "  CNT-PAGE 
           DISPLAY "*** ORCBM027 END ***"
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスタ読み込み
      *****************************************************************
       800-SYSKANRI-READ-SEC           SECTION.
      *
           MOVE    LNK-PRTKANRI-SKYYMD     TO  ORC-DBYMD
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO            TO  FLG-SYSKANRI
               ELSE
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       800-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険番号マスター読込
      *****************************************************************
       900-HKNNUM-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  HKNNUM-REC
               MOVE    ZERO            TO  FLG-HKNNUM
           ELSE
               INITIALIZE                  HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
      *
           .
       900-HKNNUM-READ-EXT.
           EXIT.
      *
