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
       PROGRAM-ID.             ORCBM003.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 社保・総括表（ＨＣ０９・１０）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC-藤原      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/08/10  印刷用データの追加  
      *  01.00.02    MCC-藤原     01/10/30  公費番号の出力を二桁に変更   
      *  01.00.03    MCC-藤原     01/11/08  住所・名称・開設者名が
      *                                     未入力のとき空白を編集    
      *  01.01.01    MCC-藤原     02/01/31  数字の編集をすべてＺに変更
      *  01.00.02    MCC-藤原     02.03.18  端末ＩＤ
      *                                     X(16)からX(32)に変更
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    集計ファイル  
           SELECT  MF01-FILE     ASSIGN    MF01PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  MF01-KEY
                                   FILE    STATUS  IS  STS-MF01.
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
      *    集計ファイル  
       FD  MF01-FILE.
       01  MF01-REC. 
           COPY    "CPRMF001.INC".
      *
      *    印刷用データ
       FD  PRT-FILE.
       01  PRT-REC                 PIC X(3000).
      *
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
      *****03                      PIC X(02)   VALUE   ",T".
      *    シェル用領域
           COPY    "CPCOMMONSHELL.INC".
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //MF01//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
           COPY    "HC09.INC".
           COPY    "HC10.INC".
      *
      *    スパ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
           03  STS-MF01            PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-INPUT           PIC 9(01).
           03  FLG-MF01            PIC 9(01). 
           03  FLG-MF01-END        PIC 9(01).
           03  FLG-HKNNUM          PIC 9(01).

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
           03  SYS-TIME            PIC 9(08).  
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SEIYMD        PIC X(08).
           03  WRK-SEIYMDWH      PIC X(22).
           03  WRK-SRYYMWH       PIC X(16).
           03  WRK-SRYYMD        PIC X(08).
      *
           03  WRK-RECEERR             PIC X(200). 
      *     
           03  WRK-HC01PARA-CNT        PIC  9(06).
      *
           03  WRK-SYMD.
               05  WRK-SYY           PIC 9(04).
               05  WRK-SMM           PIC 9(02).
               05  WRK-SDD           PIC 9(02).
           03  WRK-HENYMDG           PIC X(22).
      *
      *****03  WRK-IN                PIC X(01).
           03  WRK-YMD               PIC X(07).
           03  WRK-KBN               PIC X(01).
           03  WRK-MF01-AREA.
               05  WRK-MF01-KEY      OCCURS  3.
                   07  WRK-MF01-KBN  PIC X(01).
                   07                PIC X(12). 
      *
           03  WRK-Z9                PIC ZZZZZZ.
           03  WRK-ZZ9               PIC ZZZ,ZZZ,ZZZ.
           03  WRK-GOKEI             PIC 9(10).
           03  WRK-FORM-ID           PIC X(04).
      *
           03  WRK-KOHKBN.
      ****     05  WRK-KOHNUM        PIC X(03).
               05  WRK-KOHNUM        PIC X(02).
               05  WRK-HKNNAME       PIC X(20). 
      *
           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
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
           03  SUM-TBL             OCCURS  23.
               05  SUM-KENSU          PIC  9(06).
               05  SUM-NISSU          PIC  9(06).
               05  SUM-TOTALTEN       PIC  9(10).
               05  SUM-FTNMONEY       PIC  9(10).
               05  SUM-YKZFTN         PIC  9(10).
               05  SUM-SHOKUJIKENSU   PIC  9(06).
               05  SUM-SHOKUJINISSU   PIC  9(06).
               05  SUM-SHOKUJIRYOYOHI PIC  9(10).
               05  SUM-SHOKUJIFTN     PIC  9(10).
           03  SUM-GOK-TBL         OCCURS  4.
               05  SUM-GOK-KENSU      PIC 9(06).    
               05  SUM-GOK-SHOKUJIKENSU   PIC 9(06).
      *  
       01  WRK-PARA.
           03  WRK-PARA-SKYYM         PIC  X(06).
           03  WRK-PARA-TERMID        PIC  X(16).
           03  WRK-PARA-SYSYMD        PIC  X(08).
           03  WRK-PARA-TERMID32      PIC  X(32).
           03  WRK-PARA-HOSPID        PIC  X(24).
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
      *
           ACCEPT  SYS-TIME            FROM    TIME     
      *
           MOVE    WRK-PARA-SKYYM      TO  WRK-SRYYMD (1:6)
           MOVE    "01"                TO  WRK-SRYYMD (7:2)
           MOVE    WRK-PARA-SKYYM      TO  WRK-SYMD (1:6)
           MOVE    "01"                TO  WRK-SYMD (7:2)
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG(1:16)   TO  WRK-SRYYMWH 
      *
           MOVE    "MF01ZZZ"           TO  MF01PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  MF01PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
           OPEN    INPUT               MF01-FILE
      *
      *    システム管理マスタ（医療機関情報）
           PERFORM 120-HOSPINF-GET-SEC
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
           MOVE    WRK-PARA-SYSYMD     TO  LNK-DAY2-YMD
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
      *    老人・医療保健出力
      *
           MOVE    "HC09"          TO  WRK-FORM-ID 
      *    帳票印刷開始処理
           PERFORM 130-SYOKI-PRINT-SEC 
      *    帳票編集<見出し>処理
           PERFORM 310-HEAD-HEN-SEC
      *    帳票編集<明細>処理
           PERFORM 320-BODY-HEN-SEC
      *    帳票印刷処理
           PERFORM 390-PRINT-OUT-SEC
      *
      *    公費負担出力
      *
           MOVE    "HC10"          TO  WRK-FORM-ID 
      *    帳票印刷開始処理
           PERFORM 130-SYOKI-PRINT-SEC 
      *    帳票編集<見出し>処理
           PERFORM 310-HEAD-HEN-SEC
      *    帳票編集<明細>処理
           PERFORM 320-BODY-HEN-SEC
      *    帳票編集<合計>処理
           PERFORM 330-TERM-HEN-SEC
      *    帳票印刷処理
           PERFORM 390-PRINT-OUT-SEC
      *
           MOVE    1                  TO  FLG-END
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷開始処理
      *****************************************************************
       130-SYOKI-PRINT-SEC             SECTION.
      *
           .
       130-SYOKI-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<ヘッダー部>処理
      *****************************************************************
       310-HEAD-HEN-SEC          SECTION.
      *
           ADD     1                   TO  CNT-PAGE
      *
           EVALUATE    WRK-FORM-ID
               WHEN    "HC09"
                   INITIALIZE                      HC09      
      *
                   MOVE    WRK-SEIYMDWH        TO  HC09-SEIYMD
      *
                   MOVE    WRK-SRYYMWH         TO  HC09-PRTYM
      *
      *    医療機関住所
                   MOVE    SYS-1002-ADRS       TO  HC09-ADRS
      *    医療機関名
                   MOVE    SYS-1001-HOSPNAME   TO  HC09-HOSPNAME
      *    
                   MOVE    SYS-1001-KAISETUNAME
                                               TO  HC09-KAISETUNAME
      *    
                   MOVE    SYS-1001-HOSPCD     TO  HC09-HOSPCD
               WHEN    "HC10"
                   INITIALIZE                      HC10      
                   MOVE    SYS-1001-HOSPCD     TO  HC10-HOSPCD
           END-EVALUATE 
           .
       310-HEAD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<明細行>処理
      *****************************************************************
       320-BODY-HEN-SEC      SECTION.
      *
      *
           EVALUATE    WRK-FORM-ID
               WHEN    "HC09"
                   PERFORM 3201-HC09-HEN-SEC
               WHEN    "HC10"
                   PERFORM 3201-HC10-HEN-SEC
           END-EVALUATE
           .
       320-BODY-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<ＨＣ０９明細行>処理
      *****************************************************************
       3201-HC09-HEN-SEC      SECTION.
      *
      *    
      *    医療保険・老人保健分編集処理
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       23
               MOVE    SUM-KENSU       (IDX)   TO  WRK-Z9
               MOVE    WRK-Z9                  TO  HC09-KENSU    (IDX)
               MOVE    SUM-NISSU       (IDX)   TO  WRK-Z9 
               MOVE    WRK-Z9 (2:)             TO  HC09-NISSU    (IDX) 
               MOVE    SUM-TOTALTEN    (IDX)   TO  WRK-ZZ9
               MOVE    WRK-ZZ9                 TO  HC09-TENSU    (IDX)
               MOVE    SUM-SHOKUJIKENSU(IDX)   TO  WRK-Z9
               MOVE    WRK-Z9                  TO  HC09-SYOKENSU (IDX)
               MOVE    SUM-SHOKUJINISSU(IDX)   TO  WRK-Z9
               MOVE    WRK-Z9 (2:)             TO  HC09-SYONISSU (IDX) 
               MOVE    SUM-SHOKUJIRYOYOHI(IDX) TO  WRK-ZZ9
               MOVE    WRK-ZZ9                 TO  HC09-SYOKINGAK(IDX)
               MOVE    SUM-SHOKUJIFTN   (IDX)  TO  WRK-Z9
               MOVE    WRK-ZZ9                 TO  HC09-SYOFTNGAK(IDX)
               IF      IDX                     =   1   OR  2   OR
                                                   5   OR  9
                   CONTINUE
               ELSE
                   MOVE    SUM-YKZFTN      (IDX)   TO  WRK-ZZ9
                   MOVE    WRK-ZZ9                 TO  HC09-YKZFTN(IDX)
               END-IF
               IF      IDX                     =   9   OR
                       IDX                     >   14  
                   CONTINUE
               ELSE
                   MOVE    SUM-FTNMONEY    (IDX)   TO  WRK-ZZ9
                   MOVE    WRK-ZZ9                 TO  HC09-ITBFTN(IDX)
               END-IF
           END-PERFORM
      *
      *    医療保険・老人保健分編集処理
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       2
               MOVE    SUM-GOK-KENSU   (IDX)   TO  WRK-Z9
               MOVE    WRK-Z9                  TO  HC09-GOKEI    (IDX)
               MOVE    SUM-GOK-SHOKUJIKENSU (IDX)   TO  WRK-Z9
               MOVE    WRK-Z9                  TO  HC09-SYOGOKEI (IDX)
           END-PERFORM
           .
       3201-HC09-HEN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    帳票編集<ＨＣ１０明細行>処理
      *****************************************************************
       3201-HC10-HEN-SEC      SECTION.
      *
      *    公費負担分編集処理
           INITIALIZE                      WRK-MF01-AREA
           MOVE    "2"                     TO  WRK-MF01-KBN (1)
           MOVE    "3"                     TO  WRK-MF01-KBN (2)
           MOVE    "4"                     TO  WRK-MF01-KBN (3)
           MOVE    ZERO                    TO  FLG-MF01-END 
      * 
           PERFORM 3201-KOH-HENSYU-SEC
                                   UNTIL   FLG-MF01-END   =   1
      *
           .
       3201-HC10-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<公費負担分>処理
      *****************************************************************
      *    
       3201-KOH-HENSYU-SEC         SECTION.
      *
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       3
               IF      WRK-MF01-KEY (IDX)      =   SPACE
                   CONTINUE
               ELSE    
                   MOVE    ZERO                TO  IDY
      *
                   MOVE    WRK-MF01-KEY (IDX)  TO  MF01-KEY
                   START   MF01-FILE   KEY IS  >=  MF01-KEY
                       INVALID
                           MOVE    1               TO  FLG-MF01
                       NOT INVALID
                           PERFORM 900-MF01-READ-SEC
                   END-START     
      *
                   MOVE    WRK-MF01-KBN (IDX)  TO  WRK-KBN    
                   MOVE    SPACE               TO  WRK-MF01-KEY (IDX)
                   PERFORM UNTIL   FLG-MF01        =   1
                           OR      MF01-KBN    NOT =   WRK-KBN
                           OR      IDY             >   6
                       ADD     1                   TO  IDY
      *
                       IF      IDY             =   7
                           MOVE    MF01-KEY    TO  WRK-MF01-KEY (IDX)
                       ELSE
                           PERFORM 3202-HKNNUM-HENSYU-SEC     
                           MOVE    MF01-KENSU    (1)
                                               TO  WRK-Z9
                           MOVE    WRK-Z9 (2:) TO
                                               HC10-KOHKENSU (IDX IDY)
                           MOVE    MF01-TOTALTEN (1)
                                               TO  WRK-ZZ9         
                           MOVE    WRK-ZZ9(2:) TO
                                               HC10-KOHTENSU (IDX IDY)
                           IF      IDX                 =   1          
                               MOVE    MF01-YKZFTN  (1)
                                               TO  WRK-ZZ9          
                               MOVE    WRK-ZZ9(2:)
                                               TO
                                               HC10-KOHYKZFTN(IDX IDY)
                           END-IF          
                           MOVE    MF01-FTNMONEY (1)
                                               TO  WRK-ZZ9
                           MOVE    WRK-ZZ9(2:) TO
                                               HC10-KOHFTNGAK(IDX IDY)
                           MOVE    MF01-SHOKUJIKENSU
                                               TO  WRK-Z9         
                           MOVE    WRK-Z9      TO
                                               HC10-SYOKENSU (IDX IDY)
                           MOVE    MF01-SHOKUJIRYOYOHI
                                               TO  WRK-ZZ9         
                           MOVE    WRK-ZZ9     TO
                                               HC10-SYOKINGAK(IDX IDY)
                           IF      IDX                 =   1          
                               MOVE    MF01-SHOKUJIFTN
                                               TO  WRK-ZZ9          
                               MOVE    WRK-ZZ9 TO
                                               HC10-SYOFTNGAK(IDX IDY)
                           END-IF          
      *      
                           PERFORM 900-MF01-READ-SEC
                       END-IF      
                   END-PERFORM
               END-IF    
           END-PERFORM
      *
           IF      WRK-MF01-KEY (1)       =   SPACE
           AND     WRK-MF01-KEY (2)       =   SPACE
           AND     WRK-MF01-KEY (3)       =   SPACE
               MOVE    1                      TO  FLG-MF01-END
           ELSE
      *    帳票印刷処理
               PERFORM 390-PRINT-OUT-SEC
      *    帳票印刷開始処理
               PERFORM 130-SYOKI-PRINT-SEC 
      *    帳票編集<見出し>処理
               PERFORM 310-HEAD-HEN-SEC
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
           MOVE    MF01-KOHNUM (1)     TO  WRK-Z9
      **** MOVE    WRK-Z9 (4:3)        TO  WRK-KOHNUM
           MOVE    WRK-Z9 (5:2)        TO  WRK-KOHNUM
      *        保険番号読込み  
           INITIALIZE                      HKNNUM-REC
           MOVE   SYS-1001-HOSPID      TO    HKN-HOSPID
           MOVE   MF01-KOHNUM (1)      TO    HKN-HKNNUM
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
                   IF     MF01-KOHNUM (1)      =   "027"
                       IF      SYS-1001-HOSPSBT    =   HKN-PAYKBN (1:1)
                       AND     SYS-1001-ROUPAYKBN  =   HKN-PAYKBN (2:1)
                           STRING  "（"        DELIMITED  BY  SIZE
                                   HKN-TANSEIDONAME
                                               DELIMITED  BY  SPACE
                                   "）"        DELIMITED  BY  SIZE
                                               INTO   WRK-HKNNAME
                           END-STRING
                           MOVE    1               TO  FLG-HKNNUM   
                       END-IF
                   ELSE
                       STRING  "（"            DELIMITED  BY  SIZE
                               HKN-TANSEIDONAME
                                               DELIMITED  BY  SPACE
                               "）"            DELIMITED  BY  SIZE
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
115900     END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNNUM-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           MOVE    WRK-KOHKBN          TO  HC10-KOHKBN (IDX IDY)
           .
       3202-HKNNUM-HENSYU-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *          *    帳票編集<合計>処理
      *****************************************************************
      *    
       330-TERM-HEN-SEC         SECTION.
      *
           MOVE    SUM-GOK-KENSU   (3)     TO  WRK-Z9
           MOVE    WRK-Z9                  TO  HC10-GOKEI    
      *
           MOVE    SUM-GOK-SHOKUJIKENSU(3) TO  WRK-Z9
           MOVE    WRK-Z9                  TO  HC10-SYOGOKEI 
      *
           COMPUTE WRK-GOKEI   =   SUM-GOK-KENSU        (4)     +
                                   SUM-GOK-SHOKUJIKENSU (4)    
           MOVE    WRK-GOKEI               TO  WRK-Z9
           MOVE    WRK-Z9                  TO  HC10-GKENSU
           .
       330-TERM-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       390-PRINT-OUT-SEC                SECTION.
      * 
           MOVE    1                   TO  WRK-HC01PARA-CNT
      *
      *　　印刷用データ出力
           EVALUATE    WRK-FORM-ID
               WHEN    "HC09"
                   MOVE    "HC09"               TO  HC01PARA-FORM-ID
                   MOVE    WRK-PARA-TERMID      TO  HC01PARA-TERMID
                   MOVE    SYS-TIME             TO  HC01PARA-SYOHMS
                   MOVE    WRK-HC01PARA-CNT     TO  HC01PARA-CNT
                   OPEN    OUTPUT  PRT-FILE
                   MOVE    HC09                 TO  PRT-REC
                   WRITE   PRT-REC
                   CLOSE                        PRT-FILE  
                   MOVE   "HC09.dia"            TO  SHELL-DIA
                   MOVE   "HC09.def"            TO  SHELL-DEF
               WHEN    "HC10"
                   MOVE    "HC10"               TO  HC01PARA-FORM-ID
                   MOVE    WRK-PARA-TERMID      TO  HC01PARA-TERMID
                   MOVE    SYS-TIME             TO  HC01PARA-SYOHMS
                   MOVE    WRK-HC01PARA-CNT     TO  HC01PARA-CNT
                   OPEN    OUTPUT  PRT-FILE
                   MOVE    HC10                 TO  PRT-REC
                   WRITE   PRT-REC
                   CLOSE                        PRT-FILE
                   MOVE   "HC10.dia"            TO  SHELL-DIA
                   MOVE   "HC10.def"            TO  SHELL-DEF
           END-EVALUATE
           MOVE   "HC01.sh"            TO  SHELL-ID
           MOVE   HC01PARA             TO  SHELL-DAT
           MOVE   SYS-1031-PRTNM(5)    TO  SHELL-PRTNM 
      *
      *   印刷用スクリプト処理
      *
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
           CLOSE   MF01-FILE
      *
      **     DISPLAY "  "
      **     DISPLAY "*** ORCBM003 PAGE  "  CNT-PAGE 
      **     DISPLAY "*** ORCBM003 END ***"
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    集計ファイル読込
      *****************************************************************
       900-MF01-READ-SEC             SECTION.
      *
           READ    MF01-FILE   NEXT
               AT  END
                   MOVE    1           TO  FLG-MF01
               NOT AT  END
                   MOVE    ZERO        TO  FLG-MF01
           END-READ
           .
       900-MF01-READ-EXT.
           EXIT.
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
