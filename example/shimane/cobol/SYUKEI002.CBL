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
       PROGRAM-ID.             SYUKEI002.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 決定通知書（国保）（ＨＣ２７）
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
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *     
           COPY    "SC27.INC".
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
           03  FLG-RECE10          PIC 9(01).
           03  FLG-HKNJAINF        PIC 9(01).
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
      *          
      *****03  WRK-IN              PIC X(01).
      *
           03  WRK-SRYYMWH         PIC X(16).
           03  WRK-SRYYMD          PIC X(08).
      *
           03  WRK-RECEERR         PIC X(200). 
      *
           03  WRK-Z9              PIC ZZZZ9.
      *
           03  WRK-SYMD.
               05  WRK-SYY           PIC 9(04).
               05  WRK-SMM           PIC 9(02).
               05  WRK-SDD           PIC 9(02).
           03  WRK-HENYMDG           PIC X(22).
      *
           03  WRK-PATH              PIC X(64).     
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-LINE              PIC 9(02).
           03  CNT-LINE1             PIC 9(02).
           03  CNT-PAGE              PIC 9(03).
           03  CNT-RECE10            PIC 9(06).
      *
      *    集計領域
       01  SUM-AREA.
           03  SUM-HKN-AREA.
               05  SUM-HKN-TBL         OCCURS  3.
                   07  SUM-HKN-TBL-G   OCCURS  2.
                       09  SUM-KENSU   PIC 9(05).
           03  SUM-GOK-AREA.
               05  SUM-GOK-TBL         OCCURS  3.
                   07  SUM-GOK-TBL-G   OCCURS  2.
                       09  SUM-GOK-KENSU
                                       PIC 9(05).
           03  SUM-KOH-AREA.
               05  SUM-KOH-TBL         OCCURS  50.
                   07  SUM-KOH-HKNNUM  PIC X(03).
                   07  SUM-KOH-TBL-G   OCCURS  2.
                       09  SUM-KOH-KENSU
                                       PIC 9(05).
      *
       01  WRK-KOH-LINE-MAX                 PIC 9(03)   VALUE   6.
       01  WRK-HKN-LINE-MAX                 PIC 9(03)   VALUE   84.                          
      *
       01  KEY-AREA                            VALUE   LOW-VALUE.
           03  KEY-NEW.
               05  KEY-N-HKNJANUM      PIC X(08).
           03  KEY-OLD.
               05  KEY-O-HKNJANUM      PIC X(08). 
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
       01  HKNJAINF-REC.
           COPY    "CPHKNJAINF.INC".
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
           MOVE    "SYUKEI002"     TO  JOB-PGID
           MOVE    "決定通知書（国保）"
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
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      * 
      *    県内分
      *
           MOVE    ZERO            TO  SUM-GOK-AREA     
      *     
           MOVE    "SEIKYU-KEY6"   TO  WRK-PATH 
           PERFORM 900-SEIKYU-SELECT-SEC 
      *
           PERFORM             UNTIL   FLG-RECE10  =   1     
               INITIALIZE                  SUM-HKN-AREA
               MOVE    KEY-NEW             TO  KEY-OLD      
               PERFORM             UNTIL   FLG-RECE10  =   1
                                   OR      KEY-NEW NOT =   KEY-OLD
                   PERFORM 2001-SYUKEI-SEC
               END-PERFORM
      *         
               PERFORM 2002-PRINT-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           IF      CNT-RECE10          >   ZERO
               PERFORM 2003-GOKEI-PRINT-SEC
           END-IF
      *
      *    県外分
      *
           MOVE    ZERO            TO  SUM-GOK-AREA     
      *     
           MOVE    "SEIKYU-KEY7"   TO  WRK-PATH 
           PERFORM 900-SEIKYU-SELECT-SEC
           IF      FLG-RECE10          =   ZERO
               IF      CNT-LINE            >   ZERO
                   ADD     1                   TO  CNT-LINE
               END-IF
           END-IF         
      *
           PERFORM             UNTIL   FLG-RECE10  =   1     
               INITIALIZE                  SUM-HKN-AREA
               MOVE    KEY-NEW             TO  KEY-OLD      
               PERFORM             UNTIL   FLG-RECE10  =   1
                                   OR      KEY-NEW NOT =   KEY-OLD
                   PERFORM 2001-SYUKEI-SEC
               END-PERFORM
      *
               PERFORM 2002-PRINT-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           IF      CNT-RECE10          >   ZERO
               PERFORM 2003-GOKEI-PRINT-SEC
           END-IF                                     
      *
      *    県単医療分処理
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >   50
                   OR      SUM-KOH-HKNNUM (IDX)    =   SPACE
               PERFORM 2004-BODY-KOH-HEN-SEC 
           END-PERFORM
      *            
      *    帳票印刷処理
           IF      CNT-RECE10          >   ZERO
               PERFORM 2005-PRINT-OUT-SEC
           END-IF    
      *
           MOVE    1                   TO  FLG-END                                 
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険者番号別集計処理
      *****************************************************************
       2001-SYUKEI-SEC                SECTION.
      * 
           MOVE    ZERO                    TO  IDX-AREA
                                               FLG-UPD 
      *
           EVALUATE    RECE10-NYUGAIKBN
               WHEN    "1"
                   MOVE    1                 TO  IDX3
               WHEN    "2"
                   MOVE    2                 TO  IDX3
           END-EVALUATE           
      *
      *        老人保健
           IF      RECE10-RJNHKNNUM    NOT =   SPACE
               MOVE    3                       TO  IDX
           ELSE
      *        国民健康保険
               EVALUATE    RECE10-HKNNUM-S
                       WHEN    "060"
                           MOVE    1               TO  IDX
                       WHEN    "067"
                           MOVE    2               TO  IDX
               END-EVALUATE
           END-IF
           PERFORM 210-HKN-SYUKEI-SEC
      *
      *    公費負担分     
           IF      RECE10-KOHNUM (1)   NOT =   SPACE
               PERFORM 220-KOH-SYUKEI-SEC
           END-IF
      *
      *    集計の対象にならなかったとき                
           IF      FLG-UPD             =   1
               MOVE    WRK-PATH            TO  ORC-DBPATH
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
               MOVE    1                   TO  FLG-RECE10
           END-IF 
           .
       2001-SYUKEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    医療保険・老人保健分集計処理
      *****************************************************************
       210-HKN-SYUKEI-SEC          SECTION.
      *
           IF      IDX             >   ZERO
      *        件数
               ADD     1               TO  SUM-KENSU     (IDX IDX3)
                                           SUM-GOK-KENSU (IDX IDX3)
      *
               MOVE    1               TO  FLG-UPD 
           END-IF
           .
 
       210-HKN-SYUKEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費負担分集計処理
      *****************************************************************
       220-KOH-SYUKEI-SEC        SECTION.
      *
           PERFORM VARYING IDZ     FROM    1   BY  1
                   UNTIL   IDZ     >       4
                   OR  RECE10-KOHNUM (IDZ) =   SPACE
               IF      RECE10-KOHNUM (IDZ) (1:1)   >=  "1" AND <=  "8"
                   PERFORM VARYING IDW FROM    1   BY  1
                           UNTIL   IDW >       WRK-KOH-LINE-MAX
                       IF      SUM-KOH-HKNNUM(IDW) =   SPACE
                           MOVE    RECE10-KOHNUM (IDZ)
                                               TO  SUM-KOH-HKNNUM (IDW)
                       END-IF                             
                       IF      RECE10-KOHNUM (IDZ)
                                               =   SUM-KOH-HKNNUM (IDW)
                           ADD     1       TO  SUM-KOH-KENSU (IDW IDX3)
                           MOVE    WRK-KOH-LINE-MAX     TO  IDW
                       END-IF
                   END-PERFORM
               END-IF            
           END-PERFORM        
      *
           .
       220-KOH-SYUKEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷処理
      *****************************************************************
       2002-PRINT-SEC                SECTION.
      *
           IF      CNT-LINE          =   ZERO      
      *        帳票編集<見出し>処理
               PERFORM 20021-HEAD-HEN-SEC
           END-IF    
      *     
      *    帳票編集<明細>処理
           PERFORM 20022-BODY-HEN-SEC
           .
       2002-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<ヘッダー部>処理
      *****************************************************************
       20021-HEAD-HEN-SEC          SECTION.
      *
           MOVE    ZERO                TO  CNT-LINE
                                           CNT-LINE1
           ADD     1                   TO  CNT-PAGE
      *
           MOVE    SPACE               TO  SC27
      *
           MOVE    WRK-SRYYMWH         TO  SC27-PRTYM
           MOVE    SYS-1001-HOSPCDN    TO  SC27-HOSPCD
           MOVE    SYS-1001-HOSPNAME   TO  SC27-HOSPNAME
           .
       20021-HEAD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<明細行>処理
      *****************************************************************
       20022-BODY-HEN-SEC          SECTION.
      *     
           IF      CNT-LINE            >=  WRK-HKN-LINE-MAX
      *        帳票印刷処理
               PERFORM 2005-PRINT-OUT-SEC
      *        帳票編集<見出し>処理
               PERFORM 20021-HEAD-HEN-SEC
           END-IF    
      *
           ADD     1                   TO  CNT-LINE
      *     
           INITIALIZE                      HKNJAINF-REC
           MOVE   SYS-1001-HOSPID      TO  HKNJA-HOSPID
           MOVE   KEY-O-HKNJANUM       TO  HKNJA-HKNJANUM
           MOVE   HKNJAINF-REC         TO  MCPDATA-REC
           PERFORM 900-HKNJAINF-READ-SEC
           IF      FLG-HKNJAINF        =   ZERO
      *********MOVE    HKNJA-HKNJANAME-TAN1  
               MOVE    HKNJA-HKNJANAME     TO  SC27-NAME (CNT-LINE)
           ELSE
               MOVE    KEY-O-HKNJANUM(1:6) TO  SC27-NAME (CNT-LINE)                            
           END-IF                            
      *  
      *    入院外のみ
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       3
               PERFORM VARYING IDY FROM    2   BY  1
                       UNTIL   IDY >       2
                   MOVE    SUM-KENSU   (IDX IDY)
                                       TO  WRK-Z9
                   MOVE    WRK-Z9      TO  SC27-KENSU (IDX CNT-LINE)
               END-PERFORM    
           END-PERFORM
           .
       20022-BODY-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<合計行>処理
      *****************************************************************
       2003-GOKEI-PRINT-SEC          SECTION.
      *     
           IF      CNT-LINE            >=  WRK-HKN-LINE-MAX
      *        帳票印刷処理
               PERFORM 2005-PRINT-OUT-SEC
      *        帳票編集<見出し>処理
               PERFORM 20021-HEAD-HEN-SEC
           END-IF    
      *
           ADD     1                   TO  CNT-LINE
      *
           IF      WRK-PATH            =   "SEIKYU-KEY6"     
               MOVE    "県合計"            TO  SC27-NAME (CNT-LINE)
           ELSE    
               MOVE    "県外計"            TO  SC27-NAME (CNT-LINE)
           END-IF    
      *  
      *    入院外のみ
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       3
               PERFORM VARYING IDY FROM    2   BY  1
                       UNTIL   IDY >       2
                   MOVE    SUM-GOK-KENSU   (IDX IDY)
                                       TO  WRK-Z9
                   MOVE    WRK-Z9      TO  SC27-KENSU (IDX CNT-LINE)
               END-PERFORM    
           END-PERFORM
           .
       2003-GOKEI-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<県単医療分>処理
      *****************************************************************
       2004-BODY-KOH-HEN-SEC      SECTION.
      *     
           IF      CNT-LINE1           >=  WRK-KOH-LINE-MAX
      *        帳票印刷処理
               PERFORM 2005-PRINT-OUT-SEC
      *        帳票編集<見出し>処理
               PERFORM 20021-HEAD-HEN-SEC
           END-IF    
      *
           ADD     1                   TO  CNT-LINE1
      *
      *    保険名称  
           INITIALIZE                      HKNNUM-REC
           MOVE   SYS-1001-HOSPID      TO  HKN-HOSPID
           MOVE   SUM-KOH-HKNNUM  (IDX)
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
           IF      FLG-HKNNUM      =   ZERO
               MOVE    HKN-TANSEIDONAME
                                       TO  SC27-KOHNAME (CNT-LINE1)
115900     END-IF
      * 
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNNUM-KEY5"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           MOVE    SUM-KOH-KENSU       (IDX 2)
                               TO  WRK-Z9
           MOVE    WRK-Z9      TO  SC27-KOHKENSU    (CNT-LINE1)
           .
       2004-BODY-KOH-HEN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       2005-PRINT-OUT-SEC                SECTION.
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
           MOVE   "SC27"               TO  SPRT-PRTID
           MOVE    "決定通知書（国保）"
                                       TO  SPRT-TITLE
           MOVE    SC27                TO  SPRT-PRTDATA
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
       2005-PRINT-OUT-EXT.
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
      *
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
           DISPLAY "*** SYUKEI002 IN  "  CNT-RECE10
           DISPLAY "*** SYUKEI002 END ***"
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
           MOVE    SYS-1001-PREFNUM    TO  RECE10-XXPREFNUM
           MOVE    RECE10-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-PATH        TO  ORC-DBPATH
               PERFORM 900-SEIKYU-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-RECE10
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
           MOVE    WRK-PATH            TO  ORC-DBPATH
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-RECE10
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
               MOVE    RECE10-HKNJANUM-S   TO  KEY-N-HKNJANUM
               ADD     1                   TO  CNT-RECE10
           ELSE
               MOVE    HIGH-VALUE          TO  KEY-NEW 
               MOVE    1                   TO  FLG-RECE10
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
      *****************************************************************
      *    保険者番号マスター読込
      *****************************************************************
       900-HKNJAINF-READ-SEC         SECTION.
      * 
           MOVE   "DBSELECT"           TO  MCP-FUNC
           MOVE   "HKNJAINF-KEY"       TO  ORC-DBPATH
           CALL   "ORCMCPSUB"          USING MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNJAINF-KEY"      TO  ORC-DBPATH
               MOVE    "DBFETCH"           TO  MCP-FUNC
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  HKNJAINF-REC
                   MOVE    ZERO            TO  FLG-HKNJAINF
               ELSE
                   MOVE    1               TO  FLG-HKNJAINF
               END-IF
           ELSE
               MOVE    1                   TO  FLG-HKNJAINF
           END-IF
      *
           MOVE   "DBCLOSE"            TO  MCP-FUNC
           MOVE   "HKNJAINF-KEY"       TO  ORC-DBPATH
           CALL   "ORCMCPSUB"          USING MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
           .
       900-HKNJAINF-READ-EXT.
           EXIT.
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
