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
       PROGRAM-ID.             SEIKYU003.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 福祉医療費請求書用ファイル作成（ＳＣ１２）
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
           SELECT  RECE02-FILE     ASSIGN  RECE02PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE02-KEY
                                   FILE    STATUS  IS  STS-RECE02.
      *
      *    請求書用ファイル  
           SELECT  MF04-FILE     ASSIGN    MF04PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  MF04-KEY
                                   FILE    STATUS  IS  STS-MF04.
006900*
           SELECT  MF041-FILE    ASSIGN    MF04PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  MF041-KEY
                                   FILE    STATUS  IS  STS-MF04.
      *
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
       FD  RECE02-FILE.
       01  RECE02-REC. 
           COPY    "CPRCF002.INC".
      *
      *    集計ファイル  
       FD  MF04-FILE.
       01  MF04-REC. 
           COPY    "CPSMF004.INC".
      *
       FD  MF041-FILE.
       01  MF041-REC. 
           COPY    "CPSMF004.INC"  REPLACING  //MF04//
                                   BY         //MF041//.
      *
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE02//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //MF04//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03                      PIC X(04)   VALUE   ".dat".
      *
      *    スパ領域
       01  STS-AREA.
           03  STS-MF04            PIC X(02).
           03  STS-RECE02          PIC X(02). 
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-SYUNOU          PIC 9(01).
           03  FLG-HKNNUM          PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
      *****03  WRK-IN              PIC X(01).
      *
           03  WRK-RECEERR         PIC X(200). 
      *
      *    パス名領域
       01  WK-PATH                 PIC X(20).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID      PIC 9(07).
           03  WRK-PARA-SHELLID    PIC X(08).
           03  WRK-PARA-HOSPID     PIC X(24).
           03  WRK-PARA-PAGE       PIC 9(10).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-RECE02          PIC 9(06).
           03  CNT-MF04            PIC 9(06).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    収納
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    保険番号
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    保険組合せ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
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
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
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
           INITIALIZE                  WRK-PARA
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
           MOVE    "SEIKYU001"     TO  JOB-PGID
           MOVE    "福祉医療費請求書" 
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           MOVE    "RECE02X"           TO  RECE02PARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID(1:16)
                                       TO  RECE02PARA-TERMID
      *
           MOVE    "MF04ZZZ"           TO  MF04PARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID(1:16)
                                       TO  MF04PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID(1:16)
                                       TO  RECEERR-TERMID
      *
           OPEN    INPUT               RECE02-FILE
      *
           OPEN    OUTPUT              MF041-FILE
           CLOSE                       MF041-FILE
      *
           OPEN    I-O                 MF04-FILE
      *  
           PERFORM 900-RECE02-READ-SEC 
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           INITIALIZE                      MF04-REC
      *
           MOVE    RECE02-HOSPID       TO  MF04-HOSPID
           MOVE    RECE02-PTNUM        TO  MF04-PTNUM
           MOVE    RECE02-RECEKA       TO  MF04-SRYKA
           MOVE    RECE02-HKNJANUM-KEY TO  MF04-HKNJANUM-KEY
           MOVE    RECE02-TEKSTYMD     TO  MF04-TEKSTYMD
           MOVE    RECE02-NYUGAIKBN    TO  MF04-NYUGAIKBN
      *
           MOVE    RECE02-PTID         TO  MF04-PTID
           MOVE    RECE02-NAME         TO  MF04-NAME
           MOVE    RECE02-BIRTHDAY     TO  MF04-BIRTHDAY
           MOVE    RECE02-HKN          TO  MF04-HKN
           MOVE    RECE02-RJNHKN       TO  MF04-RJNHKN
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       4
               IF      RECE02-KOHNUM (IDX) =   "191"
                   MOVE    RECE02-KOHFTNJANUM (IDX)
                                           TO  MF04-FTNJANUM
                   MOVE    RECE02-KOHINF      (IDX)
                                           TO  MF04-KOHINF
                   COMPUTE IDY     =       IDX     +   1
                   MOVE    RECE02-JNISSUINF   (IDY)
                                           TO  MF04-JNISSUINF   
                   MOVE    RECE02-TOTALTENINF (IDY)
                                           TO  MF04-TOTALTENINF 
                   MOVE    4               TO  IDX
               END-IF
           END-PERFORM
      *
           MOVE      ZERO                  TO   MF04-FTNMONEY
           MOVE      ZERO                  TO   MF04-YKZFTN
           PERFORM   VARYING   IDX   FROM   1  BY   1
                     UNTIL    (IDX   >      10)    OR
                              (RECE02-SRYKA(IDX)   =   SPACE)
               PERFORM    KOUJO-MONEY-SEC
           END-PERFORM
      *
      *    保険組合せ読込み
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       10
                   OR      RECE02-HKNCOMBI(IDX)    =   ZERO   
               INITIALIZE                      HKNCOMBI-REC
               MOVE    RECE02-HOSPID           TO  COMB-HOSPID
               MOVE    RECE02-PTID             TO  COMB-PTID
               MOVE    RECE02-HKNCOMBI(IDX)    TO  COMB-HKNCOMBINUM 
               MOVE    HKNCOMBI-REC            TO  MCPDATA-REC
               PERFORM 910-HKNCOMBI-INV-SEC
               IF      FLG-HKNCOMBI             =   ZERO 
                   PERFORM VARYING IDY    FROM    1    BY  1
                           UNTIL   IDY    >       4
                           OR      COMB-KOHHKNNUM (IDY)   =   SPACE
                       INITIALIZE                 HKNNUM-REC
                       MOVE    RECE02-HOSPID      TO  HKN-HOSPID
                       MOVE    COMB-KOHHKNNUM (IDY)
                                                  TO  HKN-HKNNUM
                       MOVE    "00"               TO  HKN-PAYKBN
                       MOVE    RECE02-SRYYM       TO  HKN-TEKSTYMD(1:6)
                       MOVE    "01"               TO  HKN-TEKSTYMD(7:2)
                       MOVE    RECE02-SRYYM       TO  HKN-TEKEDYMD(1:6)
                       MOVE    "01"               TO  HKN-TEKEDYMD(7:2)
                       MOVE    HKNNUM-REC         TO  MCPDATA-REC
                       PERFORM 900-HKNNUM-INV-SEC
                       IF      FLG-HKNNUM         =   ZERO
                           IF      HKN-HKNKOHSBTKBN   =   "2"
                               MOVE    "1"            TO  MF04-TOKKI
                               MOVE    4              TO  IDY
                               MOVE    10             TO  IDX
                           END-IF     
                       END-IF
                   END-PERFORM
               END-IF    
           END-PERFORM
      *
           WRITE   MF04-REC
           ADD     1                   TO  CNT-MF04
      *
           PERFORM 900-RECE02-READ-SEC
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルへの一部負担金セット
      *****************************************************************
       KOUJO-MONEY-SEC                SECTION.
      *
           INITIALIZE                           SYUNOU-REC
           MOVE    RECE02-HOSPID        TO      SYU-HOSPID
           MOVE    RECE02-NYUGAIKBN     TO      SYU-NYUGAIKBN
           MOVE    RECE02-PTID          TO      SYU-PTID
           MOVE    RECE02-SRYKA(IDX)    TO      SYU-SRYKA
           MOVE    SYUNOU-REC           TO      MCPDATA-REC
           MOVE    "DBSELECT"           TO      MCP-FUNC
           MOVE    "SYUNOU-KEY4"        TO      ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC               =       ZERO
               MOVE    "SYUNOU-KEY4"    TO      ORC-DBPATH
               PERFORM  SYUNOU-READ-SEC
               PERFORM  UNTIL
                  (FLG-SYUNOU             =    1)
                   PERFORM VARYING IDX1    FROM    1   BY  1
                           UNTIL   IDX1    >       10
                           OR      RECE02-HKNCOMBI (IDX1)   =   ZERO 
                       IF      SYU-HKNCOMBINUM   =
                                                RECE02-HKNCOMBI (IDX1)
                           IF   RECE02-SRYYM   =  SYU-SRYYMD(1:6)
                               PERFORM   KOUJO-ADD-SEC
                           END-IF
                           MOVE    10              TO  IDX1
                       END-IF
                   END-PERFORM          
                   MOVE     "SYUNOU-KEY4"   TO   ORC-DBPATH
                   PERFORM   SYUNOU-READ-SEC
               END-PERFORM
           ELSE
               DISPLAY   "SEIKYU003 SYUNOU SELECT ERR" 
      *         ACCEPT     WRK-IN FROM CONSOLE
           END-IF
      *
           MOVE   "SYUNOU-KEY4"      TO  WK-PATH
           PERFORM   CSR-CLOSE-SEC
      *
           .
       KOUJO-MONEY-EXT.
           EXIT.
      *
      *****************************************************************
      *    控除額の加算処理
      *****************************************************************
       KOUJO-ADD-SEC               SECTION.
      *
           PERFORM    VARYING   IDX2    FROM   1   BY   1
             UNTIL   (IDX2      >       4)
               IF     SYU-KOH-HKNNUM(IDX2)  =  "191"
                 COMPUTE  MF04-FTNMONEY = MF04-FTNMONEY         +
                                          SYU-KOH-COMPFTN(IDX2)
                 COMPUTE  MF04-YKZFTN =   MF04-YKZFTN           +
                                          SYU-KOH-COMPYKZFTN(IDX2)
                 MOVE    4    TO    IDX2       
               END-IF                           
           END-PERFORM
           .
       KOUJO-ADD-EXT.
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
           CLOSE   RECE02-FILE
           CLOSE   MF04-FILE
      *
           DISPLAY "*** SEIKYU003 IN  "  CNT-RECE02
           DISPLAY "*** SEIKYU003 OUT "  CNT-MF04 
      ***     DISPLAY "*** SEIKYU003 END ***"
      *
           IF      CNT-MF04         >   ZERO
               CALL    "SEIKYU004"      USING   WRK-PARA
           END-IF    
      *     
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-PAGE   TO  JOB-UPDCNT
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
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
      *    レセプト明細書読込
      *****************************************************************
       900-RECE02-READ-SEC             SECTION.
      *
           READ    RECE02-FILE         NEXT
               AT  END
                   MOVE    1           TO  FLG-END
               NOT AT  END
                   IF    ( RECE02-KOHNUM  (1) =   "191"   OR
                           RECE02-KOHNUM  (2) =   "191"   OR
                           RECE02-KOHNUM  (3) =   "191"   OR
                           RECE02-KOHNUM  (4) =   "191"      )    AND
                         ( RECE02-RJNHKNNUM   =   SPACE      )
                       ADD     1                  TO  CNT-RECE02
                   ELSE
                       GO  TO  900-RECE02-READ-SEC
                   END-IF
           END-READ
           .
       900-RECE02-READ-EXT.
           EXIT.
      *      
      *****************************************************************
      *    収納読込
      *****************************************************************
       SYUNOU-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
               MOVE    ZERO            TO  FLG-SYUNOU
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
           .
       SYUNOU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソルクローズ処理
      *****************************************************************
       CSR-CLOSE-SEC            SECTION.
      *
           INITIALIZE                  MCPAREA
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WK-PATH             TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       CSR-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    保険番号読込
      *****************************************************************
       900-HKNNUM-INV-SEC           SECTION.
      *
           MOVE    "DBSELECT"        TO  MCP-FUNC
           MOVE    "HKNNUM-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"       USING   MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
           IF      MCP-RC                =   ZERO
               MOVE    "HKNNUM-KEY"          TO  ORC-DBPATH
               MOVE    "DBFETCH"             TO  MCP-FUNC
               CALL    "ORCMCPSUB"           USING
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
           ELSE
               INITIALIZE                  HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING   MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
           .
       900-HKNNUM-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスタ読込
      *****************************************************************
       910-HKNCOMBI-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-HKNCOMBI
                   MOVE    MCPDATA-REC         TO  HKNCOMBI-REC
                   IF      COMB-DELKBN         =   "1"
                       MOVE    1                   TO  FLG-HKNCOMBI
                   END-IF
               ELSE
                   MOVE    1                   TO  FLG-HKNCOMBI
                   INITIALIZE                      HKNCOMBI-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-HKNCOMBI
               INITIALIZE                      HKNCOMBI-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       910-HKNCOMBI-INV-EXT.
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
      *
