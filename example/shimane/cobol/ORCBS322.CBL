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
       PROGRAM-ID.             ORCBS322.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 乳幼児医療費請求書（ＳＣ３２１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC-藤原      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    mcc-藤原     01.07.03  診療科と控除額の編集の変更 
      *  01.00.02    MCC-藤原     01.10.03  出力先プリンタ名編集
      *  01.00.03    MCC-藤原     01.10.24  出力先プリンタ名が取得
      *                                     できないときエラーにしない
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
      *    印刷用データ
           SELECT  PRT-FILE        ASSIGN  HC01PARA
                                   FILE    STATUS  IS  STS-PARA.
      *
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    請求書用ファイル   
       FD  MF02-FILE.
       01  MF02-REC. 
           COPY    "CPRMF002.INC".
      *
      *    印刷用データ
       FD  PRT-FILE.
           COPY    "SC321.INC".
      *
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
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
      *    スパ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
           03  STS-MF02            PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-MF02            PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-LINE            PIC 9(02).
           03  CNT-PAGE            PIC 9(06).
           03  CNT-MF02            PIC 9(05). 
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY          PIC 9(02).
               05  SYS-MM          PIC 9(02).
               05  SYS-DD          PIC 9(02).
           03  SYS-TIME            PIC 9(08).  
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
      *
           03  WRK-MISYU             PIC S9(08). 
      *
      **** 03  WRK-IN                PIC X(01).
           03  WRK-YM               PIC X(05).
      *
           03  WRK-PAGE              PIC ZZ9.
           03  WRK-NISSUX            PIC Z9.
           03  WRK-TENSUX            PIC ZZZ,ZZ9.
           03  WRK-GKENSUX           PIC ZZ,ZZ9.
           03  WRK-GNISSUX           PIC ZZ9.
           03  WRK-GTENSUX           PIC Z,ZZZ,ZZ9.
           03  WRK-GKOHFTNX          PIC ZZZ,ZZ9.
      *
           03  WRK-KOHFTNX.
               05  WRK-SRYKA         PIC X(02).
               05  WRK-KOHFTN        PIC ZZ9.
           03  WRK-KOHFTNN           PIC X(06).
      *
           03  WRK-KYURATE           PIC 9(01).     
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
      *   日本語数字
       01  TBL-SUJI-AREA.
           03  FILLER          PIC X(20)   VALUE
              "１２３４５６７８９０".
       01  TBL-SUJI-R          REDEFINES   TBL-SUJI-AREA.
           03  TBL-SUJI        PIC X(02)   OCCURS   10.
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
      *    出力先プリンタ名割り当て情報
           COPY  "CPSK1031.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    共通パラメタ
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
       01  WRK-PARA.
           03  WRK-PARA-SRYYM  PIC  X(06).
           03  WRK-PARA-TERMID PIC  X(16).
           03  WRK-PARA-SYSYMD PIC  X(08).
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
           ACCEPT  SYS-TIME            FROM    TIME     
      *
           MOVE    WRK-PARA-SRYYM      TO  WRK-SYMD (1:6)
           MOVE    "01"                TO  WRK-SYMD (7:2)
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG(1:16)   TO  WRK-DENPPRTYMWH
           MOVE    WRK-HENYMDG1        TO  WRK-SRYYM 
      *
           MOVE    "MF02ZZZ"           TO  MF02PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  MF02PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
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
           MOVE    WRK-PARA-SYSYMD     TO  WRK-SYMD
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
               MOVE    "*** ORCBS322 SYS1001 INVALID ***"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                   TO  FLG-END
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
               MOVE    "*** ORCBS322 SYS1002 INVALID ***"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                   TO  FLG-END
           END-IF 
      *
      *    出力先プリンタ名割り当て情報編集
           MOVE    SPACE               TO  SYS-1031-REC
           INITIALIZE                  SYS-1031-REC
           MOVE    "1031"              TO  SYS-1031-KANRICD
           MOVE    "*"                 TO  SYS-1031-KBNCD
           MOVE    SYS-1031-REC        TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1031-REC
           ELSE    
               INITIALIZE                  SYS-1031-REC
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
           INITIALIZE                       SUM-AREA    
      *
           MOVE    KEY-NEW              TO  KEY-OLD
           PERFORM              UNTIL   FLG-END     =   1
                                OR      KEY-NEW NOT =   KEY-OLD
      *    帳票編集<見出し>処理
               PERFORM 310-HEAD-HEN-SEC
      *    帳票編集<明細>処理
               PERFORM 320-BODY-HEN-SEC
           END-PERFORM
      *
      *    帳票編集<合計>処理
           PERFORM 330-TERM-HEN-SEC
      *    帳票印刷処理
           PERFORM 390-PRINT-OUT-SEC
           .
       200-MAIN-EXT.
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
           INITIALIZE                      SC321      
      *
           MOVE    WRK-DENPPRTYMWH     TO  SC321-PRTYM
      *
      ***  MOVE    ??                  TO  SC321-CITYNUM
      ***                                  SC321-CITYNAME
      *
           MOVE    SYS-1001-PREFNUM    TO  SC321-HOSPCD (1:2)
           MOVE    SYS-1001-HOSPCD     TO  SC321-HOSPCD (3:7)
      *
           MOVE    KEY-N-FTNJANUM      TO  SC321-FTNJANUM
      *
           MOVE    "○"                TO  SC321-KBN (1)   
      *
           MOVE    SYS-1002-ADRS       TO  SC321-ADRS
      *    
           MOVE    SYS-1001-HOSPNAME   TO  SC321-HOSPNAME
      *    
           MOVE    SYS-1001-KAISETUNAME
                                       TO  SC321-KAISETUNAME
      *
           MOVE    WRK-SYSYMDWH        TO  SC321-SEIYMD
      *
           MOVE    CNT-PAGE            TO  WRK-PAGE
           MOVE    WRK-PAGE            TO  SC321-PAGE
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
               MOVE    MF02-KOHJKYSNUM TO  SC321-JKYSNUM    (2 CNT-LINE)
      *    氏名
               MOVE    MF02-NAME       TO  SC321-NAME       (CNT-LINE)
      *    保険者番号
               MOVE    MF02-HKNJANUM   TO  SC321-HKNJANUM   (CNT-LINE)
      *    記号番号
               STRING  MF02-KIGO       DELIMITED   BY  SPACE
                       "　"            DELIMITED   BY  SIZE
                       MF02-NUM        DELIMITED   BY  SPACE
                       INTO            SC321-KIGOBANGO  (CNT-LINE) 
               END-STRING
      *    生年月日
               MOVE    MF02-BIRTHDAY   TO  WRK-SYMD
               PERFORM 31012-SEIWA-HEN-SEC
               MOVE    WRK-HENYMDG1(2:)
                                       TO  SC321-BIRTHDAY(CNT-LINE)
      *    診療年月
               MOVE    WRK-SRYYM (2:2) TO  SC321-SRYYM   (CNT-LINE)(1:2)
               MOVE    WRK-SRYYM (5:2) TO  SC321-SRYYM   (CNT-LINE)(4:2) 
      *    入外区分
               MOVE    MF02-NYUGAIKBN  TO  SC321-NYUGAIKBN  (CNT-LINE)
      *    給付割合
               COMPUTE WRK-KYURATE     =  (100   -   MF02-KYURATE)
                                           /   10
               MOVE    WRK-KYURATE     TO  SC321-KYURATE    (CNT-LINE)
      *    日数
               MOVE    MF02-JNISSU     TO  WRK-NISSUX
               MOVE    WRK-NISSUX      TO  SC321-NISSU      (CNT-LINE)
      *    点数
               MOVE    MF02-TOTALTEN   TO  WRK-TENSUX
               MOVE    WRK-TENSUX      TO  SC321-TENSU      (CNT-LINE)
      *    診療科・控除額
               INITIALIZE                  SYS-1005-REC
               MOVE    "1005"          TO  SYS-1005-KANRICD
               MOVE    MF02-SRYKA      TO  SYS-1005-KBNCD
               MOVE    SYS-1005-REC    TO  MCPDATA-REC
               PERFORM 800-SYSKANRI-READ-SEC
               IF      FLG-SYSKANRI    =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-1005-REC
                   MOVE    SYS-1005-SRYKANAME3
                                           TO  WRK-SRYKA
               END-IF
               MOVE    WRK-SRYKA       TO  SC321-KOHFTN (CNT-LINE)(1:)
               MOVE    MF02-FTNMONEY   TO  WRK-KOHFTN
               PERFORM 800-NUM-ZENKAKU-HENKAN-SEC
               MOVE    WRK-KOHFTNN     TO  SC321-KOHFTN (CNT-LINE)(3:)
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
                   ADD     MF02-KOHKENSU   TO  SUM-KENSU (IDX) 
                                               SUM-GOKEI 
                   ADD     MF02-JNISSU     TO  SUM-NISSU (IDX)
                   ADD     MF02-TOTALTEN   TO  SUM-TENSU (IDX)
                   ADD     MF02-FTNMONEY   TO  SUM-KOHFTN(IDX)
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
               MOVE    WRK-GKENSUX         TO  SC321-GKENSU (IDX)
               MOVE    SUM-NISSU (IDX)     TO  WRK-GNISSUX
               MOVE    WRK-GNISSUX         TO  SC321-GNISSU (IDX)
               MOVE    SUM-TENSU (IDX)     TO  WRK-GTENSUX 
               MOVE    WRK-GTENSUX         TO  SC321-GTENSU (IDX) 
               MOVE    SUM-KOHFTN(IDX)     TO  WRK-GKOHFTNX
               MOVE    WRK-GKOHFTNX        TO  SC321-GKOHFTN(IDX)
           END-PERFORM    
           MOVE    SUM-GOKEI           TO  WRK-GKENSUX
           MOVE    WRK-GKENSUX         TO  SC321-GOKEI
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
      *　　印刷用データ出力
           MOVE    "HC04"              TO  HC01PARA-FORM-ID
      *****MOVE    WRK-PARA-TERMID      TO  HC01PARA-TERMID
           MOVE    SYS-TIME             TO  HC01PARA-SYOHMS
           MOVE    CNT-PAGE            TO  HC01PARA-CNT
           OPEN    OUTPUT  PRT-FILE
           OPEN    OUTPUT               PRT-FILE
           WRITE  SC321
           CLOSE                       PRT-FILE
      *
           MOVE   "HC01.sh"            TO  SHELL-ID
           MOVE   "SC321.dia"           TO  SHELL-DIA
           MOVE   "SC321.def"           TO  SHELL-DEF
           MOVE   HC01PARA             TO  SHELL-DAT
           MOVE   SYS-1031-PRTNM(5)    TO  SHELL-PRTNM 
      *   印刷用スクリプト処理
      *★★ETC-EXEC SHELL SHELL-AREA 10
           MOVE    SHELL-NAME      TO  SHELLTBL-NAME
           MOVE    SHELL-ARG1      TO  SHELLTBL-ARG1
           MOVE    SHELL-ARG2      TO  SHELLTBL-ARG2
           MOVE    SHELL-ARG3      TO  SHELLTBL-ARG3
           MOVE    SHELL-ARG4      TO  SHELLTBL-ARG4
           MOVE    SHELL-ARG5      TO  SHELLTBL-ARG5
      *          
           MOVE    SHELLTBL        TO  MCPDATA-REC
           MOVE    "SHELL"         TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL
                                   TO  MCP-PATH
           CALL    "MCPSUB"        USING
                                       MCPAREA
                                       MCPDATA-REC                         
           .
       390-PRINT-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    数値半角→全角変換処理
      *****************************************************************
       800-NUM-ZENKAKU-HENKAN-SEC    SECTION.
      *
           MOVE    1                   TO  IDX3
           PERFORM VARYING     IDZ     FROM    1   BY  1
                   UNTIL       IDZ     >   3
               IF    WRK-KOHFTN(IDZ:1)  IS  NUMERIC
                   MOVE    WRK-KOHFTN (IDZ:1)  TO  IDX2
                   IF      IDX2        =   ZERO
                       MOVE    TBL-SUJI (10)
                                       TO  WRK-KOHFTNN (IDX3:)
                   ELSE
                       MOVE    TBL-SUJI (IDX2)
                                       TO  WRK-KOHFTNN (IDX3:)
                   END-IF                    
               ELSE
                   MOVE    "　"        TO  WRK-KOHFTNN (IDX3:)
               END-IF
               ADD     2               TO  IDX3
           END-PERFORM
      *
           .
       800-NUM-ZENKAKU-HENKAN-EXT.
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
      *
           OPEN    INPUT   RECEERR-FILE
           IF      STS-RECEERR         =   ZERO
               CONTINUE
           ELSE
               OPEN    OUTPUT              RECEERR-FILE
      *
               MOVE    WRK-RECEERR         TO  RECEERR-REC
               WRITE   RECEERR-REC
           END-IF
      *
           CLOSE   RECEERR-FILE
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
           DISPLAY "*** ORCBS322 IN   "  CNT-MF02
           DISPLAY "*** ORCBS322 PAGE "  CNT-PAGE 
      ***     DISPLAY "*** ORCBS322 END ***"
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
                   ADD     1                  TO  CNT-MF02
                   MOVE    MF02-KOHFTNJANUM   TO  KEY-N-FTNJANUM
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
           MOVE    WRK-PARA-SYSYMD     TO  ORC-DBYMD
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
