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
       PROGRAM-ID.             ORCBM008.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 福祉医療費請求書用ファイル作成
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC-藤原      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.02    MCC-藤原     02.03.18  端末ＩＤ
      *                                     X(16)からX(32)に変更
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
           COPY    "CPRMF004.INC".
      *
       FD  MF041-FILE.
       01  MF041-REC. 
           COPY    "CPRMF004.INC"  REPLACING  //MF04//
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
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
      *****03  WRK-IN              PIC X(01).
      *
           03  WRK-PARA.
               05  WRK-PARA-SRYYM  PIC  X(06).
               05  WRK-PARA-TERMID PIC  X(16).
               05  WRK-PARA-SYSYMD PIC  X(08).
               05  WRK-PARA-TERMID32
                                   PIC  X(32).
      *
           03  WRK-RECEERR         PIC X(200). 
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
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
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
      *
           PERFORM 100-DBOPEN-SEC
      *
           MOVE    COMMAND-PARAM       TO  WRK-PARA
      *
           MOVE    "RECE02X"           TO  RECE02PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE02PARA-TERMID
      *
           MOVE    "MF04ZZZ"           TO  MF04PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  MF04PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
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
                   MOVE    RECE02-FTNMONEYINF (IDY)
                                           TO  MF04-FTNMONEYINF 
                   MOVE    RECE02-YKZFTNINF   (IDY)
                                           TO  MF04-YKZFTNINF
                   MOVE    4               TO  IDX
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
           CLOSE   RECE02-FILE
           CLOSE   MF04-FILE
      *
           DISPLAY "*** ORCBM008 IN  "  CNT-RECE02
           DISPLAY "*** ORCBM008 OUT "  CNT-MF04 
      ***     DISPLAY "*** ORCBM008 END ***"
      *
          CALL    "ORCBM009"          USING   WRK-PARA
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
