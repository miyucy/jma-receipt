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
       PROGRAM-ID.             SYUKEI001.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 決定通知書（社保）（ＳＣ２６）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC-藤原      新規作成
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
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.

      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03                      PIC X(04)   VALUE   ".dat".
      *     
           COPY    "SC26.INC".
      *     
      *    スパ領域
       01  STS-AREA.
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-UPD             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-HKNNUM          PIC 9(01).
           03  FLG-SEIKYU          PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDW                 PIC 9(04).
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDX3                PIC 9(04).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID      PIC 9(07).
           03  WRK-PARA-SHELLID    PIC X(08).
           03  WRK-PARA-HOSPID     PIC X(24).
      *
      *    一時領域
       01  WRK-AREA.
      *****03  WRK-IN              PIC X(01).
      *
           03  WRK-SRYYMWH         PIC X(16).
           03  WRK-SRYYMD          PIC X(08).
      *
           03  WRK-RECEERR         PIC X(200). 
      *
           03  WRK-Z9              PIC ZZZZZ.
           03  WRK-ZZ9             PIC ZZZ,ZZZ,ZZZ.
      *
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-HENYMDG         PIC X(22).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-LINE            PIC 9(02).
           03  CNT-PAGE            PIC 9(03).
           03  CNT-RECE10          PIC 9(06).
      *
      *    集計領域
       01  SUM-AREA.
           03  SUM-TBL-G                   OCCURS  3.
               05  SUM-TBL                 OCCURS  2.
                   07  SUM-KENSU           PIC 9(06).
                   07  SUM-TOTALTEN        PIC 9(10).
                   07  SUM-FTNMONEY        PIC 9(10).
                   07  SUM-YKZFTN          PIC 9(10).
                   07  SUM-SHOKUJIKENSU    PIC 9(06).
                   07  SUM-SHOKUJIRYOYOHI  PIC 9(10).
                   07  SUM-SHOKUJIFTN      PIC 9(10).
           03  SUM-KOH-TBL-G               OCCURS  100.
               05  SUM-KOH-KOHNUM          PIC X(03).  
               05  SUM-KOH-KENSU           PIC 9(06).
               05  SUM-KOH-TOTALTEN        PIC 9(10).
               05  SUM-KOH-FTNMONEY        PIC 9(10).
               05  SUM-KOH-YKZFTN          PIC 9(10).
      *     
      *    シェル用領域
           COPY    "CPCOMMONSHELL.INC".
           COPY    "CPSHELLTBL.INC".
           COPY    "ORCA-DBPATH".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    患者
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
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
           COPY    "CPRCF010.INC".
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
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    印刷ＤＢ更新サブ
           COPY    "CPORCSPRT.INC".          
      *
      *    共通パラメタ
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      ****************************************************************
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(256).
      ****************************************************************
       PROCEDURE           DIVISION
               USING
           COMMAND-PARAM.
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
           STOP    RUN
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
           INITIALIZE                  SUM-AREA
      *
           PERFORM 100-DBOPEN-SEC
      *
           UNSTRING   COMMAND-PARAM    DELIMITED  BY  ","
                                       INTO    LNK-PRTKANRI-RENNUM
                                               LNK-PRTKANRI-TBL-KEY
                                               LNK-PRTKANRI-TBL-GROUP
                                               LNK-PRTKANRI-SHORI-RENNUM
                                               LNK-PRTKANRI-SRYYM
                                               LNK-PRTKANRI-SKYYMD
                                               LNK-PRTKANRI-SHELLID
                                               LNK-PRTKANRI-PRIORITY
                                               LNK-PRTKANRI-TERMID
                                               LNK-PRTKANRI-OPID    
                                               LNK-PRTKANRI-PRTNM    
                                               WRK-PARA-JOBID
                                               WRK-PARA-SHELLID
                                               WRK-PARA-HOSPID
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "SYUKEI001"     TO  JOB-PGID
           MOVE    "決定通知書（社保）"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID(1:16)
                                       TO  RECEERR-TERMID
      *     
           MOVE    LNK-PRTKANRI-SRYYM  TO  WRK-SRYYMD (1:6)
           MOVE    "01"                TO  WRK-SRYYMD (7:2)
           MOVE    LNK-PRTKANRI-SRYYM  TO  WRK-SYMD (1:6)
           MOVE    "01"                TO  WRK-SYMD (7:2)
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG(1:16)   TO  WRK-SRYYMWH 
      *
      *    医療機関ＩＤ編集
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
           ELSE
               MOVE    "医療機関情報が取得できませんでした"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
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
      *  
           PERFORM 900-SEIKYU-SELECT-SEC 
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           MOVE    ZERO                    TO  IDX-AREA
                                               FLG-UPD
      *
      *    老人保健欄
           IF      RECE10-RJNHKNNUM    NOT =   SPACE
               MOVE    1                   TO  IDX 
               PERFORM 210-HKN-SYUKEI-SEC
           END-IF
      *     
      *    医療保険欄
           IF      RECE10-RJNHKNNUM        =   SPACE
           AND     RECE10-HKNNUM       NOT =   SPACE
               IF      RECE10-HONKZKKBN        =   "1"
                   IF      RECE10-KOHNUM (1)   NOT =   SPACE
                       MOVE    2                   TO  IDX 
                   ELSE
                       EVALUATE    RECE10-HKNNUM
                           WHEN    "001"
                           WHEN    "002"
                           WHEN    "003"
                           WHEN    "004"
                           WHEN    "031"  THRU  "034"
                           WHEN    "006"
                           WHEN    "007"               
                           WHEN    "063"
                           WHEN    "072"  THRU  "075"
                               MOVE    2           TO  IDX 
                       END-EVALUATE
                   END-IF
               ELSE
                   IF      RECE10-KOHNUM (1)   NOT =   SPACE
                       MOVE    3                   TO  IDX 
                   ELSE
                       EVALUATE    RECE10-HKNNUM
                           WHEN    "001"
                           WHEN    "002"
                           WHEN    "003"
                           WHEN    "004"
                           WHEN    "031"  THRU  "034"
                           WHEN    "006"
                           WHEN    "063"
                           WHEN    "072"  THRU  "075"
                               MOVE    3            TO  IDX
                       END-EVALUATE
                   END-IF
               END-IF
               PERFORM 210-HKN-SYUKEI-SEC
           END-IF    
      *
      *    公費負担分     
           PERFORM VARYING IDZ     FROM    1   BY  1
                   UNTIL   IDZ     >       4
                   OR  RECE10-KOHNUM (IDZ) =   SPACE
               PERFORM 220-KOH-SYUKEI-SEC
           END-PERFORM                
      *
      *    集計の対象にならなかったとき                
           IF      FLG-UPD             =   1
               MOVE    "SEIKYU-KEY3"       TO  ORC-DBPATH
               PERFORM 900-SEIKYU-READ-SEC
           ELSE
               MOVE    SPACE               TO  WRK-RECEERR
               STRING "集計対象外　患者番号＝"     DELIMITED  BY  SIZE
                       RECE10-PTNUM                DELIMITED  BY  SPACE
                       " 診療年月＝"               DELIMITED  BY  SIZE
                       RECE10-SRYYM                DELIMITED  BY  SIZE
                       " レセ種別＝"               DELIMITED  BY  SIZE
                       RECE10-RECESYUBETU          DELIMITED  BY  SIZE
                                           INTO    WRK-RECEERR
               END-STRING                                
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                   TO  FLG-END
           END-IF 
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    医療保険・老人保健分集計処理
      *****************************************************************
       210-HKN-SYUKEI-SEC          SECTION.
      *
           IF      IDX             =   ZERO
               GO  TO  210-HKN-SYUKEI-EXT
           END-IF
      *
      *    医療保険・老人保健分
           MOVE    1                         TO  IDX1
           MOVE    IDX                       TO  IDX2
           PERFORM 2101-HKN-SYUKEI-01-SEC
      *
           .
       210-HKN-SYUKEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    医療保険・老人保健分集計処理
      *****************************************************************
       2101-HKN-SYUKEI-01-SEC      SECTION.
      *    
      *    件数
           ADD     1                       TO  SUM-KENSU (IDX2 2)
           IF      RECE10-SHOKUJINISSU(IDX1)   >   ZERO
               ADD     1                   TO  SUM-SHOKUJIKENSU(IDX2 2)
           END-IF
      *
      *    診療実日数〜一部負担金 
           ADD     RECE10-TOTALTEN       (IDX1)
                                         TO  SUM-TOTALTEN      (IDX2 2)
           ADD     RECE10-YKZFTN         (IDX1)
                                         TO  SUM-YKZFTN        (IDX2 2)
           ADD     RECE10-FTNMONEY       (IDX1)
                                         TO  SUM-FTNMONEY      (IDX2 2)
           ADD     RECE10-SHOKUJIRYOYOHI (IDX1)
                                         TO  SUM-SHOKUJIRYOYOHI(IDX2 2)
           ADD     RECE10-SHOKUJIFTN     (IDX1)
                                         TO  SUM-SHOKUJIFTN    (IDX2 2)
      *
           MOVE    1               TO  FLG-UPD 
           .
       2101-HKN-SYUKEI-01-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費負担分集計処理
      *****************************************************************
       220-KOH-SYUKEI-SEC        SECTION.
      *
           PERFORM VARYING IDW     FROM    1   BY  1
                   UNTIL   IDW     >       100
               IF      SUM-KOH-KOHNUM(IDW)     =   SPACE
                   MOVE    RECE10-KOHNUM (IDZ)
                                       TO  SUM-KOH-KOHNUM (IDW)
               END-IF
               IF      RECE10-KOHNUM (IDZ) =   SUM-KOH-KOHNUM (IDW)             
                   ADD     1           TO  SUM-KOH-KENSU         (IDW)
                   COMPUTE IDY     =   IDZ     +   1
                   ADD     RECE10-TOTALTEN (IDY)
                                       TO  SUM-KOH-TOTALTEN      (IDW)
                   ADD     RECE10-YKZFTN   (IDY)
                                       TO  SUM-KOH-YKZFTN        (IDW)      
                   ADD     RECE10-FTNMONEY (IDY)
                                       TO  SUM-KOH-FTNMONEY      (IDW) 
                   MOVE    100         TO  IDW                        
               END-IF
           END-PERFORM                                
      *
           MOVE    1               TO  FLG-UPD 
      *
           .
       220-KOH-SYUKEI-EXT.
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
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SEIKYU-KEY3"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           IF      CNT-RECE10          >   ZERO 
               PERFORM 310-PRINT-SEC
           END-IF    
      *
           DISPLAY "*** SYUKEI001 IN  "  CNT-RECE10
           DISPLAY "*** SYUKEI001 END ***"
      *     
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    CNT-PAGE        TO  JOB-UPDCNT                        
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷処理
      *****************************************************************
       310-PRINT-SEC                SECTION.
      *     
      *    帳票編集<見出し>処理
           PERFORM 310-HEAD-HEN-SEC
      *     
      *    帳票編集<明細>処理
           PERFORM 320-BODY-HEN-SEC
      *
      *    帳票印刷処理
           PERFORM 390-PRINT-OUT-SEC
           .
       310-PRINT-EXT.
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
           MOVE    SPACE               TO  SC26
      *
           MOVE    WRK-SRYYMWH         TO  SC26-PRTYM
           MOVE    SYS-1001-HOSPCDN    TO  SC26-HOSPCD
           .
       310-HEAD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<明細行>処理
      *****************************************************************
       320-BODY-HEN-SEC          SECTION.
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       3
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       2
                   MOVE    SUM-KENSU       (IDX IDY)
                                           TO  WRK-Z9
                   MOVE    WRK-Z9          TO  SC26-KENSU    (IDX IDY)
                   MOVE    SUM-TOTALTEN    (IDX IDY)
                                           TO  WRK-ZZ9
                   MOVE    WRK-ZZ9         TO  SC26-TENSU    (IDX IDY)
                   MOVE    SUM-YKZFTN      (IDX IDY)
                                           TO  WRK-ZZ9
                   MOVE    WRK-ZZ9         TO  SC26-YKZFTN   (IDX IDY)
                   MOVE    SUM-FTNMONEY    (IDX IDY)
                                           TO  WRK-ZZ9
                   MOVE    WRK-ZZ9         TO  SC26-ITBFTN   (IDX IDY)
                   MOVE    SUM-SHOKUJIKENSU(IDX IDY)
                                           TO  WRK-Z9
                   MOVE    WRK-Z9          TO  SC26-SYOKENSU (IDX)
                   MOVE    SUM-SHOKUJIRYOYOHI(IDX IDY)
                                           TO  WRK-ZZ9
                   MOVE    WRK-ZZ9         TO  SC26-SYOKINGAK(IDX)
                   MOVE    SUM-SHOKUJIFTN   (IDX IDY)
                                           TO  WRK-Z9
                   MOVE    WRK-ZZ9         TO  SC26-SYOFTNGAK(IDX)
               END-PERFORM    
           END-PERFORM
      *     
      *    帳票編集<公費分>処理
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       100
                   OR      SUM-KOH-KOHNUM (IDX)    =   SPACE
               PERFORM 330-BODY-KOH-HEN-SEC
           END-PERFORM    
           .
       320-BODY-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<明細行>処理
      *****************************************************************
       330-BODY-KOH-HEN-SEC      SECTION.
      *
           IF      CNT-LINE        >=  27
      *        帳票印刷処理
               PERFORM 390-PRINT-OUT-SEC
      *        帳票編集<見出し>処理
               PERFORM 310-HEAD-HEN-SEC
           END-IF                    
      *
           ADD     1               TO  CNT-LINE
      *     
           PERFORM 3202-HKNNUM-HENSYU-SEC     
      *
           MOVE    SUM-KOH-KENSU       (IDX)
                               TO  WRK-Z9
           MOVE    WRK-Z9      TO  SC26-KOHKENSU    (CNT-LINE)
           MOVE    SUM-KOH-TOTALTEN    (IDX)
                               TO  WRK-ZZ9
           MOVE    WRK-ZZ9     TO  SC26-KOHTENSU    (CNT-LINE)
           MOVE    SUM-KOH-YKZFTN      (IDX)
                               TO  WRK-ZZ9
           MOVE    WRK-ZZ9     TO  SC26-KOHYKZFTN   (CNT-LINE)
           MOVE    SUM-KOH-FTNMONEY    (IDX)
                               TO  WRK-ZZ9
           MOVE    WRK-ZZ9     TO  SC26-KOHFTNGAK   (CNT-LINE)
           .
       320-BODY-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費保険区分編集処理
      *****************************************************************
      *    
       3202-HKNNUM-HENSYU-SEC         SECTION.
      *
           MOVE    SUM-KOH-KOHNUM  (IDX) (2:2)
                                       TO  SC26-KOHNUM (CNT-LINE)
      *        保険番号読込み  
           INITIALIZE                      HKNNUM-REC
           MOVE   SYS-1001-HOSPID      TO  HKN-HOSPID
           MOVE   SUM-KOH-KOHNUM  (IDX)
                                       TO  HKN-HKNNUM
           MOVE    WRK-SRYYMD          TO  HKN-TEKSTYMD
                                           HKN-TEKEDYMD                               
           MOVE   HKNNUM-REC           TO  MCPDATA-REC
           MOVE   "DBSELECT"           TO  MCP-FUNC
           MOVE   "HKNNUM-KEY5"        TO  ORC-DBPATH
           CALL   "ORCMCPSUB"          USING MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNNUM-KEY5"       TO  ORC-DBPATH
               PERFORM 900-HKNNUM-READ-SEC
           ELSE
               MOVE    1                  TO  FLG-HKNNUM
           END-IF
      *
           PERFORM UNTIL       FLG-HKNNUM      =   1
               IF     SUM-KOH-KOHNUM  (IDX)    =   "027"
                   IF      SYS-1001-HOSPSBT    =   HKN-PAYKBN (1:1)
                   AND     SYS-1001-ROUPAYKBN  =   HKN-PAYKBN (2:1)
                       MOVE    HKN-TANSEIDONAME  
                                           TO  SC26-KOHKBN (CNT-LINE)
                       MOVE    1           TO  FLG-HKNNUM   
                   END-IF
               ELSE
                   MOVE    HKN-TANSEIDONAME    
                                           TO  SC26-KOHKBN (CNT-LINE)
                   MOVE    1               TO  FLG-HKNNUM   
               END-IF     
      *
               IF      FLG-HKNNUM           =   ZERO
                   MOVE    "HKNNUM-KEY5"       TO  ORC-DBPATH
                   PERFORM 900-HKNNUM-READ-SEC
               END-IF 
115900     END-PERFORM
      * 
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNNUM-KEY5"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           .
       3202-HKNNUM-HENSYU-EXT.
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
           MOVE   "SC26"               TO  SPRT-PRTID
           MOVE    "決定通知書（社保）"
                                       TO  SPRT-TITLE
           MOVE    SC26                TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "2"                 TO  SPRT-SITEKBN
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
      *
      *****************************************************************
      *    請求管理読込
      *****************************************************************
       900-SEIKYU-SELECT-SEC             SECTION.
      *
      *    請求管理ＤＢ検索
           MOVE    SPACE               TO  RECE10-REC
           INITIALIZE                  RECE10-REC
           MOVE    WRK-PARA-HOSPID     TO  RECE10-HOSPID
           MOVE    LNK-PRTKANRI-SRYYM  TO  RECE10-SKYYM
           MOVE    RECE10-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SEIKYU-KEY3"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SEIKYU-KEY3"       TO  ORC-DBPATH
               PERFORM 900-SEIKYU-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-END
           END-IF
           .
       900-SEIKYU-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求マスター読込
      *****************************************************************
       900-SEIKYU-READ-SEC           SECTION.
      *
           MOVE    "SEIKYU-KEY3"       TO  ORC-DBPATH
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-END
               MOVE    MCPDATA-REC         TO  RECE10-REC
      *
      *        テスト患者のときは読み飛ばす
               MOVE    SPACE               TO  PTINF-REC
               INITIALIZE                      PTINF-REC
               MOVE    RECE10-HOSPID       TO  PTINF-HOSPID
               MOVE    RECE10-PTID         TO  PTINF-PTID
               MOVE    PTINF-REC           TO  MCPDATA-REC
               PERFORM 800-PTINF-READ-SEC
               IF      FLG-PTINF           =   ZERO
               AND     PTINF-TSTPTNUMKBN   =   "1"
                   GO  TO  900-SEIKYU-READ-SEC
               END-IF
      *         
               ADD     1                   TO  CNT-RECE10
           ELSE
               MOVE    1                   TO  FLG-END
           END-IF
      *
           .
       900-SEIKYU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスタ読込
      *****************************************************************
       800-PTINF-READ-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTINF-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-PTINF
                   MOVE    MCPDATA-REC         TO  PTINF-REC
               ELSE
                   MOVE    1                   TO  FLG-PTINF
                   INITIALIZE                  PTINF-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       800-PTINF-READ-EXT.
           EXIT.
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
      *      
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
      *
           MOVE    "DBOPEN"            TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       900-DBCLOSE-EXT.
           EXIT.
