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
       PROGRAM-ID.             ORCBM001.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 社保・総括表（ＨＣ０８・９・１０）用集計処理
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC-藤原      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01.08.21  更新用ファイル追加  
      *  01.00.02    MCC-藤原     01.11.02  日・日時・共の集計が
      *                                     違っていたので修正
      *  01.00.03    MCC-藤原     01.11.09  ０件のときエラーにしない
      *  01.00.04    MCC-藤原     02.03.18  端末ＩＤ
      *                                     X(16)からX(32)に変更
      *  01.00.05    MCC-藤原     02/04/15  印刷管理・印刷ＤＢの追加
      *  01.00.06    MCC-藤原     02/05/09  頁数のジョブ管理ＤＢへの更新
      *  01.00.07    MCC-藤原     02/05/22  テスト患者は処理しない     
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    集計ファイル  
           SELECT  MF01-FILE     ASSIGN    MF01PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  MF01-KEY
                                   FILE    STATUS  IS  STS-MF01.
006900*
           SELECT  MF011-FILE    ASSIGN    MF01PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  MF011-KEY
                                   FILE    STATUS  IS  STS-MF01.
      *
006900*    請求ＤＢ更新用ファイル
           SELECT  UPD-FILE        ASSIGN  RECEUPD
                                   ORGANIZATION    IS  LINE
                                                       SEQUENTIAL 
                                   FILE    STATUS  IS  STS-RECEUPD.
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
       FD  MF011-FILE.
       01  MF011-REC. 
           COPY    "CPRMF001.INC"  REPLACING  //MF01//
                                   BY         //MF011//.
      *
006900*    請求ＤＢ更新用ファイル
       FD  UPD-FILE.
           COPY    "CPRCF010.INC"  REPLACING  //RECE10//
                                   BY         //RECE10X//.
      *
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //MF01//.
      *
006900*    請求ＤＢ更新用ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEUPD//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    スパ領域
       01  STS-AREA.
           03  STS-MF01            PIC X(02).
           03  STS-RECEERR         PIC X(02).
           03  STS-RECEUPD         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-MF01            PIC 9(01). 
           03  FLG-SEIKYU          PIC 9(01).
           03  FLG-UPD             PIC 9(01).
           03  FLG-UPDFILE         PIC 9(01). 
           03  FLG-ERR             PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
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
           03  WRK-PARA1.
               05  WRK-PARA-SKYYM  PIC X(06).
               05  WRK-PARA-TERMID PIC X(16).
               05  WRK-PARA-SYSYMD PIC X(08).
           03  WRK-PARA-HOSPID     PIC X(24).
           03  WRK-PARA-JOBID      PIC 9(07).
           03  WRK-PARA-SHELLID    PIC X(08).
           03  WRK-PARA-PAGE       PIC 9(10).
      *          
      *    一時領域
       01  WRK-AREA.
      *****03  WRK-IN              PIC X(01).
           03  WRK-KBN             PIC X(01). 
      *
           03  WRK-RECEERR         PIC X(200). 
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-RECE10          PIC 9(06).
           03  CNT-UPDFILE         PIC 9(06).
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
               05  SUM-GOK-SHOKENSU   PIC 9(06).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    患者
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
           COPY    "CPRCF010.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    共通パラメタ
           COPY    "MCPAREA".
      *
      *    ＤＢ検索
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
           INITIALIZE              FLG-AREA
           INITIALIZE              STS-AREA
           INITIALIZE              WRK-AREA
           INITIALIZE              CNT-AREA
           INITIALIZE              SUM-AREA
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
                                               WRK-PARA1
                                               WRK-PARA-HOSPID
                                               WRK-PARA-JOBID
                                               WRK-PARA-SHELLID
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCBM001"      TO  JOB-PGID
           MOVE    "社保総括表"    TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           MOVE    "MF01ZZZ"           TO  MF01PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  MF01PARA-TERMID
      *
           MOVE    "RECEUPD"           TO  RECEUPD-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEUPD-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
      *
           OPEN    OUTPUT              MF011-FILE
           CLOSE                       MF011-FILE
      *
           OPEN    I-O                 MF01-FILE
      *
           OPEN    OUTPUT              UPD-FILE
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
               IF      RECE10-KOHNUM (1)   NOT =   SPACE
                   MOVE    1                   TO  IDX 
               ELSE
                   MOVE    2                   TO  IDX 
               END-IF
               PERFORM 210-HKN-SYUKEI-SEC
           END-IF
      *     
      *    医療保険欄
           IF      RECE10-RJNHKNNUM        =   SPACE
           AND     RECE10-HKNNUM       NOT =   SPACE
               IF      RECE10-HONKZKKBN        =   "1"
                   IF      RECE10-KOHNUM (1)   NOT =   SPACE
                       MOVE    3                   TO  IDX 
                   ELSE
                       EVALUATE    RECE10-HKNNUM
                           WHEN    "001"
                               MOVE    4               TO  IDX
                           WHEN    "002"
                               MOVE    5               TO  IDX
                           WHEN    "003"
      ******                   MOVE    6               TO  IDX
                               MOVE    7               TO  IDX
                           WHEN    "004"
      ******                   MOVE    7               TO  IDX
                               MOVE    8               TO  IDX
                           WHEN    "031"  THRU  "034"
      ******                   MOVE    8               TO  IDX
                               MOVE    10              TO  IDX
                           WHEN    "006"
                               MOVE    11              TO  IDX
                           WHEN    "007"               
                               MOVE    12              TO  IDX
                           WHEN    "063"
                           WHEN    "072"  THRU  "075"
                               MOVE    13              TO  IDX
                       END-EVALUATE
                   END-IF
               ELSE
                   IF      RECE10-KOHNUM (1)   NOT =   SPACE
                       MOVE    15                  TO  IDX 
                   ELSE
                       EVALUATE    RECE10-HKNNUM
                           WHEN    "001"
                               MOVE    16              TO  IDX
                           WHEN    "002"
                               MOVE    17              TO  IDX
                           WHEN    "003"
                               MOVE    18              TO  IDX
                           WHEN    "004"
                               MOVE    19              TO  IDX
                           WHEN    "031"  THRU  "034"
                               MOVE    20              TO  IDX
                           WHEN    "006"
                               MOVE    21              TO  IDX
                           WHEN    "063"
                           WHEN    "072"  THRU  "075"
                               MOVE    22              TO  IDX
                       END-EVALUATE
                   END-IF
               END-IF
               PERFORM 210-HKN-SYUKEI-SEC
           END-IF    
      *
      *    公費負担分     
           IF      RECE10-KOHNUM (1)   NOT =   SPACE
               IF      RECE10-RJNHKNNUM    NOT =   SPACE
               OR      RECE10-HKNNUM       NOT =   SPACE
      *            公費と医保・老人の併用欄
                   MOVE    "2"                     TO  WRK-KBN
                   PERFORM 220-KOH-SYUKEI-SEC
               ELSE
                   IF      RECE10-KOHNUM (2)   NOT =   SPACE  
      *            公費と公費の併用欄
                       MOVE    "3"                     TO  WRK-KBN
                       PERFORM 220-KOH-SYUKEI-SEC
                   ELSE
      *            公費単独欄
                       MOVE    "4"                     TO  WRK-KBN
                       PERFORM 220-KOH-SYUKEI-SEC
                   END-IF
               END-IF     
           END-IF                
      *
      *    集計の対象にならなかったとき                
           IF      FLG-UPD             =   1
               PERFORM 230-UPD-FILE-HENSYU-SEC
      *
               MOVE    "SEIKYU-KEY3"       TO  ORC-DBPATH
               PERFORM 900-SEIKYU-READ-SEC
           ELSE
      ***      DISPLAY "*** ORCBM001 ERR KEY=" RECE10-KEY
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
           ADD     1                       TO  SUM-KENSU (IDX2)
           IF      RECE10-SHOKUJINISSU(IDX1)   >   ZERO
               ADD     1                   TO  SUM-SHOKUJIKENSU (IDX2)
           END-IF
      *    件数（合計）、総件数
           EVALUATE    IDX2
               WHEN    1
               WHEN    2
                   MOVE    1                   TO  IDX3
               WHEN    3   THRU    13
               WHEN    15  THRU    22
                   MOVE    2                   TO  IDX3
               WHEN    OTHER
                   MOVE    ZERO                TO  IDX3  
           END-EVALUATE     
           IF      IDX3                >   ZERO 
               ADD     1                   TO  SUM-GOK-KENSU (IDX3)
               ADD     1                   TO  SUM-GOK-KENSU (4)
               IF      RECE10-SHOKUJINISSU(IDX1)   >   ZERO
                   ADD     1               TO  SUM-SHOKUJIKENSU (IDX3)
                                               SUM-GOK-SHOKENSU (4) 
               END-IF
           END-IF
      *
      *    診療実日数〜一部負担金 
           ADD     RECE10-JNISSU         (IDX1)
                                         TO  SUM-NISSU          (IDX2)
           ADD     RECE10-TOTALTEN       (IDX1)
                                         TO  SUM-TOTALTEN       (IDX2)
           ADD     RECE10-YKZFTN         (IDX1)
                                         TO  SUM-YKZFTN         (IDX2)
           ADD     RECE10-FTNMONEY       (IDX1)
                                         TO  SUM-FTNMONEY       (IDX2)
           ADD     RECE10-SHOKUJINISSU   (IDX1)
                                         TO  SUM-SHOKUJINISSU   (IDX2)
           ADD     RECE10-SHOKUJIRYOYOHI (IDX1)
                                         TO  SUM-SHOKUJIRYOYOHI (IDX2)
           ADD     RECE10-SHOKUJIFTN     (IDX1)
                                         TO  SUM-SHOKUJIFTN     (IDX2)
      *
      *    計   
           EVALUATE    IDX2
               WHEN    4   THRU    13
                   MOVE    14                  TO  IDX3
               WHEN    16  THRU    22
                   MOVE    23                  TO  IDX3
               WHEN    OTHER
                   MOVE    ZERO                TO  IDX3  
           END-EVALUATE
           IF      IDX3                >   ZERO 
               ADD     1                   TO  SUM-KENSU          (IDX3)
               ADD     RECE10-JNISSU         (IDX1)
                                           TO  SUM-NISSU          (IDX3)
               ADD     RECE10-TOTALTEN       (IDX1)
                                           TO  SUM-TOTALTEN       (IDX3)
               ADD     RECE10-YKZFTN         (IDX1)
                                           TO  SUM-YKZFTN         (IDX3)
               ADD     RECE10-FTNMONEY       (IDX1)
                                           TO  SUM-FTNMONEY       (IDX3)
               IF      RECE10-SHOKUJINISSU(IDX1)    >   ZERO
                   ADD     1               TO  SUM-SHOKUJIKENSU   (IDX3)
               END-IF
               ADD     RECE10-SHOKUJINISSU   (IDX1)
                                           TO  SUM-SHOKUJINISSU   (IDX3)
               ADD     RECE10-SHOKUJIRYOYOHI (IDX1)
                                           TO  SUM-SHOKUJIRYOYOHI (IDX3)
               ADD     RECE10-SHOKUJIFTN     (IDX1)
                                           TO  SUM-SHOKUJIFTN     (IDX3)
           END-IF
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
           PERFORM VARYING IDZ     FROM    1   BY  1
                   UNTIL   IDZ     >       4
                   OR  RECE10-KOHNUM (IDZ) =   SPACE
               INITIALIZE                          MF01-REC
               MOVE    WRK-KBN                 TO  MF01-KBN
               MOVE    RECE10-KOHNUM (IDZ)     TO  MF01-KOHNUM (1)
               PERFORM 900-MF01-READ-SEC
               IF      FLG-MF01                =   1
                   INITIALIZE                       MF01-REC
                   MOVE    WRK-KBN                 TO  MF01-KBN
                   MOVE    RECE10-KOHNUM (IDZ)     TO  MF01-KOHNUM (1)
               END-IF
      *        療養の給付情報
               ADD     1                           TO  MF01-KENSU    (1)        
               COMPUTE IDY     =   IDZ     +   1
               ADD     RECE10-TOTALTEN       (IDY) TO  MF01-TOTALTEN (1)       
               ADD     RECE10-YKZFTN         (IDY) TO  MF01-YKZFTN   (1)         
               ADD     RECE10-FTNMONEY       (IDY) TO  MF01-FTNMONEY (1)
      *        食事療養費情報
               IF      RECE10-SHOKUJINISSU   (IDY) >   ZERO
                   ADD     1                   TO  MF01-SHOKUJIKENSU
               END-IF
               ADD     RECE10-SHOKUJIRYOYOHI (IDY)
                                               TO  MF01-SHOKUJIRYOYOHI 
               ADD     RECE10-SHOKUJIFTN     (IDY)
                                               TO  MF01-SHOKUJIFTN
      *        合計
               ADD     1                       TO  SUM-GOK-KENSU (3)
                                                   SUM-GOK-KENSU (4) 
               IF      RECE10-SHOKUJINISSU   (IDY) >   ZERO
                   ADD     1                   TO  SUM-GOK-SHOKENSU (3)
                                                   SUM-GOK-SHOKENSU (4) 
               END-IF
      *
               IF      FLG-MF01                =   1
                   WRITE   MF01-REC
               ELSE
                   REWRITE MF01-REC
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
006900*    請求ＤＢ更新用ファイル出力処理
      *****************************************************************
       230-UPD-FILE-HENSYU-SEC         SECTION.
      *
           MOVE    RECE10-REC          TO  RECE10X-REC
           WRITE   RECE10X-REC
      *
           ADD     1                   TO  CNT-UPDFILE
           .
       230-UPD-FILE-HENSYU-EXT.
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
                                           FLG-ERR     
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
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           CLOSE   MF01-FILE
                   UPD-FILE
      *
           DISPLAY "*** ORCBM001 IN  "  CNT-RECE10
           DISPLAY "***          UPD "  CNT-UPDFILE 
           DISPLAY "*** ORCBM001 END ***"
      ***     ACCEPT  WRK-IN
      *
           IF      CNT-RECE10            =   ZERO 
               CONTINUE
           ELSE
              IF      FLG-UPD        =   1
              AND     FLG-ERR        =   ZERO 
                  IF      CNT-UPDFILE    >   ZERO
                      PERFORM 310-SEIKYU-UPD-SEC
                  END-IF    
      *
                  CALL    "ORCBM002"          USING 
      *********** CALL    "ORCBM003"          USING
                                               SUM-AREA
                                               WRK-PARA
               END-IF
           END-IF    
      *     
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    WRK-PARA-PAGE   TO  JOB-UPDCNT                         
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
      *   請求管理ＤＢ更新処理
      *****************************************************************
       310-SEIKYU-UPD-SEC              SECTION.
      *
           OPEN    INPUT    UPD-FILE
      *
           PERFORM 900-UPD-FILE-READ-SEC
           PERFORM             UNTIL   FLG-UPDFILE    =   1
               MOVE    SPACE           TO  RECE10-REC   
               INITIALIZE                  RECE10-REC
               MOVE    RECE10X-KEY         TO  RECE10-KEY
               MOVE    RECE10-REC          TO  MCPDATA-REC
               PERFORM 910-SEIKYU-INV-SEC
               IF      FLG-SEIKYU          =   ZERO
                   MOVE    "2"             TO  RECE10-SKYKBN
                   MOVE    WRK-PARA-SKYYM  TO  RECE10-SKYYM
                   MOVE    WRK-PARA-SYSYMD TO  RECE10-UPDYMD  
                   MOVE    RECE10-REC      TO  MCPDATA-REC
                   MOVE    "DBUPDATE"      TO  MCP-FUNC
                   MOVE    "SEIKYU-KEY"    TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"      USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                   IF      MCP-RC          =   ZERO
                       PERFORM 900-UPD-FILE-READ-SEC
                   ELSE
                       MOVE  "*** ORCBM001 SEIKYU UPD ERR ***"
                                           TO  WRK-RECEERR
                       MOVE    RECE10-KEY  TO  WRK-RECEERR(33:)
                       PERFORM 500-ERR-HENSYU-SEC
                       MOVE    1           TO  FLG-UPDFILE
                   END-IF
               ELSE
                   MOVE  "*** ORCBM001 SEIKYU INVALID ***"
                                           TO  WRK-RECEERR
                   MOVE    RECE10X-KEY     TO  WRK-RECEERR(33:)
                   PERFORM 500-ERR-HENSYU-SEC
                   MOVE    1               TO  FLG-UPDFILE
               END-IF
           END-PERFORM  
      *
           CLOSE   UPD-FILE
           .
       310-SEIKYU-UPD-EXT.
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
           MOVE    WRK-PARA-SKYYM      TO  RECE10-SKYYM
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
      *    レセプト明細書読込
      *****************************************************************
       900-MF01-READ-SEC             SECTION.
      *
      *
           READ    MF01-FILE
               INVALID
                   MOVE    1           TO  FLG-MF01
               NOT INVALID
                   MOVE    ZERO        TO  FLG-MF01
           END-READ
           .
       900-MF01-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求管理ＤＢ更新用ファイル読込
      *****************************************************************
       900-UPD-FILE-READ-SEC             SECTION.
      *
           READ    UPD-FILE
               AT  END
                   MOVE    1           TO  FLG-UPDFILE
               NOT AT  END
                   MOVE    ZERO        TO  FLG-UPDFILE
           END-READ
           .
       900-UPD-FILE-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求管理マスタ読込
      *****************************************************************
       910-SEIKYU-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SEIKYU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SEIKYU-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-SEIKYU
                   MOVE    MCPDATA-REC         TO  RECE10-REC
               ELSE
                   MOVE    1                   TO  FLG-SEIKYU
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SEIKYU
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SEIKYU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       910-SEIKYU-INV-EXT.
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
