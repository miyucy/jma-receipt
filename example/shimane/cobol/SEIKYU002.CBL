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
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             SEIKYU002.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 乳幼児医療費請求書の印刷（ＳＣ１１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC-藤原      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01.05.02  ジョブ管理ＤＢ・帳票管理ＤＢ追加   
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    請求書用ファイル  
           SELECT  MF02-FILE     ASSIGN    MF02PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  MF02-KEY
                                   FILE    STATUS  IS  STS-MF02.
      *
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    請求書用ファイル   
       FD  MF02-FILE.
       01  MF02-REC. 
           COPY    "CPSMF002.INC".
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *    シェル用領域
           COPY    "CPCOMMONSHELL.INC".
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //MF02//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03                      PIC X(04)   VALUE   ".dat".
      *
           COPY    "SC11.INC".
      *     
      *    スパ領域
       01  STS-AREA.
           03  STS-MF02            PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-MF02            PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-HKNJAINF        PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-LINE            PIC 9(02).
           03  CNT-PAGE            PIC 9(06).
           03  CNT-MF02            PIC 9(05). 
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDX2                PIC 9(01).
           03  IDX3                PIC 9(04). 
      *
      *    一時領域
       01  WRK-AREA.
      *
           03  WRK-RECEERR         PIC X(200). 
           03  WRK-DENPPRTYM        PIC X(06).
           03  WRK-SRYKANAME         PIC X(02).
           03  WRK-DENPPRTYMWH       PIC X(16).
           03  WRK-SYSYMDWH          PIC X(22).
           03  WRK-SRYYM             PIC X(09).
      *  
           03  WRK-SYMD.
               05  WRK-SYY           PIC 9(04).
               05  WRK-SMM           PIC 9(02).
               05  WRK-SDD           PIC 9(02).
           03  WRK-HENYMDG           PIC X(22).
           03  WRK-HENYMDG1          PIC X(09).
           03  WRK-HENYMDG2          PIC X(20).
      *
           03  WRK-MISYU             PIC S9(08). 
      *
           03  WRK-PAGE              PIC ZZ9.
           03  WRK-NISSUX            PIC Z9.
           03  WRK-TENSUX            PIC ZZZ,ZZ9.
           03  WRK-GKENSUX           PIC ZZ,ZZ9.
           03  WRK-GNISSUX           PIC ZZ9.
           03  WRK-GTENSUX           PIC Z,ZZZ,ZZ9.
           03  WRK-GKOHFTNX          PIC ZZZ,ZZ9.
      *
           03  WRK-KOHFTN            PIC ZZ9.
      *
           03  WRK-KYURATE           PIC 9(01). 
      *
           03  WRK-HKN.     
               05  WRK-HKN-NUM       PIC X(50).
               05  WRK-HKN-KIGO      PIC X(50).
      *
       01  SUM-AREA                         VALUE   ZERO.
           03  SUM-OCC               OCCURS  4.
               05  SUM-KENSU         PIC 9(08).
               05  SUM-NISSU         PIC 9(08).
               05  SUM-TENSU         PIC 9(08).
               05  SUM-KOHFTN        PIC 9(08).
           03  SUM-GOKEI             PIC 9(08).
      *
       01  KEY-AREA                         VALUE   LOW-VALUE.
           03  KEY-NEW.
               05  KEY-N-FTNJANUM    PIC X(08).
           03  KEY-OLD.
               05  KEY-O-FTNJANUM    PIC X(08).  
      *
           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
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
      *    診療科目情報情報
           COPY    "CPSK1005.INC".
      *
       01  HKNJAINF-REC.
           COPY    "CPHKNJAINF.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    印刷管理マスタ
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *    印刷マスタ
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
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    共通パラメタ
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    印刷ＤＢ制御サブ
           COPY    "CPORCSPRT.INC".          
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID      PIC 9(07).
           03  WRK-PARA-SHELLID    PIC X(08).
           03  WRK-PARA-HOSPID     PIC X(24).
           03  WRK-PARA-PAGE       PIC 9(10).
      *
      ******************************************************************
      *
       PROCEDURE                       DIVISION
                                       USING   WRK-PARA.
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
      *
           MOVE    LNK-PRTKANRI-SRYYM  TO  WRK-SYMD (1:6)
           MOVE    "01"                TO  WRK-SYMD (7:2)
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG(1:16)   TO  WRK-DENPPRTYMWH
           MOVE    WRK-HENYMDG1        TO  WRK-SRYYM 
      *
           MOVE    "MF02ZZZ"           TO  MF02PARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID(1:16)
                                       TO  MF02PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID(1:16)
                                       TO  RECEERR-TERMID
      *
           OPEN    INPUT               MF02-FILE
      *
      *    システム管理マスタ（医療機関情報）
           PERFORM 120-HOSPINF-GET-SEC
      *  
           PERFORM 900-MF02-READ-SEC 
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
           MOVE    LNK-PRTKANRI-SKYYMD TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  WRK-SYSYMDWH
      *
      *    医療機関ＩＤ編集
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC        TO  SYS-1001-REC
           ELSE
               MOVE    "医療機関情報が取得できませんでした"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF 
      *
      *    医療機関情報−所在地、連絡先
           INITIALIZE                      SYS-1002-REC
           MOVE    "1002"              TO  SYS-1002-KANRICD
           MOVE    "*"                 TO  SYS-1002-KBNCD
           MOVE    SYS-1002-REC        TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC        TO  SYS-1002-REC
           ELSE
               MOVE    "医療機関情報（所在地）が取得できませんでした"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
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
           MOVE    SPACE               TO  HKNJAINF-REC
           INITIALIZE                      HKNJAINF-REC
           MOVE    SYS-1001-HOSPID     TO  HKNJA-HOSPID
           MOVE    KEY-N-FTNJANUM(3:5) TO  HKNJA-HKNJANUM
           MOVE    HKNJAINF-REC        TO  MCPDATA-REC
           PERFORM 900-HKNJAINF-INV-SEC
           IF      FLG-HKNJAINF        =   ZERO
               CONTINUE
           ELSE
               INITIALIZE              HKNJAINF-REC
           END-IF        
      *     
      *    合計集計処理
           INITIALIZE                       SUM-AREA    
      *
           MOVE    KEY-NEW              TO  KEY-OLD
           PERFORM              UNTIL   FLG-END     =   1
                                OR      KEY-NEW NOT =   KEY-OLD
               PERFORM 2001-GOKEI-SYUKEI-SEC
           END-PERFORM                         
      *
      *    明細編集処理
           MOVE    ZERO                TO  FLG-END
      *     
           INITIALIZE                      MF02-REC
           MOVE    SYS-1001-HOSPID     TO  MF02-HOSPID
           MOVE    KEY-O-FTNJANUM      TO  MF02-FTNJANUM
           START   MF02-FILE
               KEY IS    >=   MF02-KEY
               INVALID
                   MOVE    1           TO  FLG-END
               NOT INVALID
                   PERFORM 900-MF02-READ-SEC 
           END-START
      *         
           MOVE    KEY-NEW              TO  KEY-OLD
      *     
      *    帳票編集<見出し>処理
           PERFORM 310-HEAD-HEN-SEC
      *
      *    帳票編集<合計>処理
           PERFORM 330-TERM-HEN-SEC
      *
      *    帳票編集<明細>処理
           PERFORM              UNTIL   FLG-END     =   1
                                OR      KEY-NEW NOT =   KEY-OLD
      *         
               PERFORM 320-BODY-HEN-SEC
           END-PERFORM
      *     
      *    帳票印刷処理
           PERFORM 390-PRINT-OUT-SEC
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    合計集計処理
      *****************************************************************
       2001-GOKEI-SYUKEI-SEC     SECTION.
      *
           ADD     1                  TO  CNT-MF02
      *     
      *    給付割合
           COMPUTE WRK-KYURATE     =  (100   -   MF02-KYURATE)
                                           /   10
      *
      *    合計
           EVALUATE    WRK-KYURATE     ALSO    MF02-NYUGAIKBN      
               WHEN    8   ALSO    "1"               
                   MOVE    1           TO  IDX
               WHEN    7   ALSO    "1"               
                   MOVE    2           TO  IDX
               WHEN    8   ALSO    "2"               
                   MOVE    3           TO  IDX
               WHEN    7   ALSO    "2"               
                   MOVE    4           TO  IDX
               WHEN    OTHER
                   MOVE    ZERO        TO  IDX 
           END-EVALUATE
           IF      IDX                 >   ZERO
               ADD     1               TO  SUM-KENSU (IDX) 
                                           SUM-GOKEI 
               ADD     MF02-JNISSU     TO  SUM-NISSU (IDX)
               ADD     MF02-TOTALTEN   TO  SUM-TENSU (IDX)
               ADD     MF02-FTNMONEY   TO  SUM-KOHFTN(IDX)
           END-IF
      *             
           PERFORM 900-MF02-READ-SEC 
           .
       2001-GOKEI-SYUKEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<ヘッダー部>処理
      *****************************************************************
       310-HEAD-HEN-SEC          SECTION.
      *
           MOVE    ZERO                TO  CNT-LINE
           ADD     1                   TO  CNT-PAGE
      *
           MOVE    SPACE               TO  SC11   
           INITIALIZE                      SC11      
      *
           MOVE    WRK-DENPPRTYMWH     TO  SC11-PRTYM
      *     
           MOVE    HKNJA-HKNJANAME     TO  SC11-CITYNAME
           MOVE    HKNJA-HKNJANUM(1:6) TO  SC11-CITYNUM 
      *
           MOVE    SYS-1001-PREFNUM    TO  SC11-HOSPCD (1:2)
           MOVE    SYS-1001-HOSPCD     TO  SC11-HOSPCD (3:7)
      *
           MOVE    KEY-N-FTNJANUM      TO  SC11-FTNJANUM
      *
           MOVE    "○"                TO  SC11-KBN (1)   
      *
           MOVE    SYS-1002-ADRS       TO  SC11-ADRS
      *    
           MOVE    SYS-1001-HOSPNAME   TO  SC11-HOSPNAME
      *    
           MOVE    SYS-1001-KAISETUNAME
                                       TO  SC11-KAISETUNAME
      *
           MOVE    WRK-SYSYMDWH        TO  SC11-SEIYMD
      *
           MOVE    CNT-PAGE            TO  WRK-PAGE
           MOVE    WRK-PAGE            TO  SC11-PAGE
      *
           .
       310-HEAD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<明細行>処理
      *****************************************************************
       320-BODY-HEN-SEC      SECTION.
      *
           MOVE    ZERO                TO  CNT-LINE
      *
           PERFORM             UNTIL   FLG-END     =   1
                               OR      KEY-NEW NOT =   KEY-OLD
                               OR      CNT-LINE    =   22
      *
               ADD     1               TO  CNT-LINE  
      *    受給資格証記号番号
               INITIALIZE              ORCSKANACHKAREA
               MOVE    "2"             TO  KANACHK-SYORI 
               MOVE    MF02-KOHJKYSNUM TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
               IF      KANACHK-RC      =   ZERO
                   MOVE    KANACHK-OUT-INPUT(1:KANACHK-MAX)
                                           TO  SC11-JKYSNUM(CNT-LINE)
               END-IF    
      *    氏名
               MOVE    MF02-NAME       TO  SC11-NAME       (CNT-LINE)
      *    保険者番号
               MOVE    MF02-HKNJANUM   TO  SC11-HKNJANUM   (CNT-LINE)
      *    記号番号
               MOVE    SPACE           TO  WRK-HKN
      *          
               INITIALIZE              ORCSKANACHKAREA
               MOVE    "2"             TO  KANACHK-SYORI 
               MOVE    MF02-KIGO       TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
               IF      KANACHK-RC      =   ZERO
                   MOVE    KANACHK-OUT-INPUT(1:KANACHK-MAX)
                                           TO  WRK-HKN-KIGO
               END-IF    
               INITIALIZE              ORCSKANACHKAREA
               MOVE    "2"             TO  KANACHK-SYORI 
               MOVE    MF02-NUM        TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
               IF      KANACHK-RC      =   ZERO
                   MOVE    KANACHK-OUT-INPUT(1:KANACHK-MAX)
                                           TO  WRK-HKN-NUM
               END-IF    
               STRING  WRK-HKN-KIGO    DELIMITED   BY  SPACE
                       "　"            DELIMITED   BY  SIZE
                       WRK-HKN-NUM     DELIMITED   BY  SPACE
                       INTO            SC11-KIGOBANGO  (CNT-LINE) 
      *    生年月日
               MOVE    MF02-BIRTHDAY   TO  WRK-SYMD
               PERFORM 31012-SEIWA-HEN-SEC
               MOVE    WRK-HENYMDG1(2:)
                                       TO  SC11-BIRTHDAY(CNT-LINE)
      *    診療年月
               MOVE    WRK-SRYYM (2:2) TO  SC11-SRYYM   (CNT-LINE)(1:2)
               MOVE    WRK-SRYYM (5:2) TO  SC11-SRYYM   (CNT-LINE)(4:2) 
      *    入外区分
               MOVE    MF02-NYUGAIKBN  TO  SC11-NYUGAIKBN  (CNT-LINE)
      *    給付割合
               COMPUTE WRK-KYURATE     =  (100   -   MF02-KYURATE)
                                           /   10
               MOVE    WRK-KYURATE     TO  SC11-KYURATE    (CNT-LINE)
      *    日数
               MOVE    MF02-JNISSU     TO  WRK-NISSUX
               MOVE    WRK-NISSUX      TO  SC11-NISSU      (CNT-LINE)
      *    点数
               MOVE    MF02-TOTALTEN   TO  WRK-TENSUX
               MOVE    WRK-TENSUX      TO  SC11-TENSU      (CNT-LINE)
      *    診療科・控除額
               IF      MF02-SRYKA      NOT =   SPACE 
                   INITIALIZE                  SYS-1005-REC
                   MOVE    "1005"          TO  SYS-1005-KANRICD
                   MOVE    MF02-SRYKA      TO  SYS-1005-KBNCD
                   MOVE    SYS-1005-REC    TO  MCPDATA-REC
                   PERFORM 800-SYSKANRI-READ-SEC
                   IF      FLG-SYSKANRI    =   ZERO
                       MOVE    MCPDATA-REC     TO  SYS-1005-REC
                       MOVE    SYS-1005-SRYKANAME3 (1:2)
                                       TO  SC11-KOHFTN (CNT-LINE)(1:)
                   END-IF                                       
               END-IF    
               MOVE    MF02-FTNMONEY   TO  WRK-KOHFTN
               INITIALIZE              ORCSKANACHKAREA
               MOVE    "2"             TO  KANACHK-SYORI 
               MOVE    WRK-KOHFTN      TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
               IF      KANACHK-RC      =   ZERO
                   MOVE    KANACHK-OUT-INPUT(1:KANACHK-MAX)
                                       TO  SC11-KOHFTN (CNT-LINE)(3:)
               END-IF    
      *  
               PERFORM 900-MF02-READ-SEC 
           END-PERFORM     
      *
           IF      KEY-NEW            =   KEY-OLD
      *    帳票印刷処理
               PERFORM 390-PRINT-OUT-SEC
      *    帳票編集<見出し>処理
               PERFORM 310-HEAD-HEN-SEC
           END-IF
      *
           .
       320-BODY-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *          *    帳票編集<合計>処理
      *****************************************************************
      *    
       330-TERM-HEN-SEC         SECTION.
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       4
               MOVE    SUM-KENSU (IDX)     TO  WRK-GKENSUX
               MOVE    WRK-GKENSUX         TO  SC11-GKENSU (IDX)
               MOVE    SUM-NISSU (IDX)     TO  WRK-GNISSUX
               MOVE    WRK-GNISSUX         TO  SC11-GNISSU (IDX)
               MOVE    SUM-TENSU (IDX)     TO  WRK-GTENSUX 
               MOVE    WRK-GTENSUX         TO  SC11-GTENSU (IDX) 
               MOVE    SUM-KOHFTN(IDX)     TO  WRK-GKOHFTNX
               MOVE    WRK-GKOHFTNX        TO  SC11-GKOHFTN(IDX)
           END-PERFORM    
           MOVE    SUM-GOKEI           TO  WRK-GKENSUX
           MOVE    WRK-GKENSUX         TO  SC11-GOKEI
      *
           .
       330-TERM-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       390-PRINT-OUT-SEC                SECTION.
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
           MOVE   "SC11"               TO  SPRT-PRTID
           MOVE    "乳幼児医療費請求書"
                                       TO  SPRT-TITLE
           MOVE    SC11                TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF      SPRT-RETURN         =   ZERO
               CONTINUE
           ELSE
               MOVE    "帳票ＤＢに更新できませんでした"
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
           MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG1 
           MOVE    LNK-DAY2-EDTYMD2    TO  WRK-HENYMDG2 
           INSPECT WRK-HENYMDG    REPLACING  ALL "  "  BY  "　"
           .
       31012-SEIWA-HEN-EXT.
           EXIT.
      *
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
      *        ジョブ終了処理
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
           CLOSE   MF02-FILE
      *
           MOVE    CNT-PAGE        TO  WRK-PARA-PAGE
      *     
           DISPLAY "*** SEIKYU002 IN   "  CNT-MF02
           DISPLAY "*** SEIKYU002 PAGE "  CNT-PAGE 
      *****DISPLAY "*** SEIKYU002 END ***"
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト明細書読込
      *****************************************************************
       900-MF02-READ-SEC             SECTION.
      *
           READ    MF02-FILE         NEXT
               AT  END
                   MOVE    HIGH-VALUE         TO  KEY-NEW
                   MOVE    1                  TO  FLG-END
               NOT AT  END
      *************ADD     1                  TO  CNT-MF02
                   MOVE    MF02-FTNJANUM      TO  KEY-N-FTNJANUM
           END-READ
           .
       900-MF02-READ-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    管理マスタ読み込み
      *****************************************************************
       800-SYSKANRI-READ-SEC           SECTION.
      *
           MOVE    LNK-PRTKANRI-SRYYM  TO  ORC-DBYMD(1:6)
           MOVE    "01"                TO  ORC-DBYMD(7:2) 
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
      *    保険者マスター読込（キー）
      *****************************************************************
       900-HKNJAINF-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNJAINF-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "HKNJAINF-KEY2"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-HKNJAINF
                   MOVE    MCPDATA-REC         TO  HKNJAINF-REC
               ELSE
                   MOVE    1                   TO  FLG-HKNJAINF
               END-IF
           ELSE
               MOVE    1                   TO  FLG-HKNJAINF
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNJAINF-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-HKNJAINF-INV-EXT.
           EXIT.
