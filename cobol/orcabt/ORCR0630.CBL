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
       PROGRAM-ID.             ORCR0630.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト（入院）
      *  コンポーネント名  : 
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/12/11    NaCl−門脇    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
           SELECT  RECE62-FILE     ASSIGN  RECE62PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE62-KEY
                                   FILE    STATUS  IS  STS-RECE62.
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                    SECTION.
      *
       FD  RECE62-FILE.
       01  RECE62-REC. 
           COPY    "CPRCF062.INC".
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE62//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECE62                              PIC X(02).
           03  STS-RECEERR                             PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-SHOSAISIN                           PIC 9(01).
           03  FLG-NYUINACCT                           PIC 9(01).
           03  FLG-SRYACCT                             PIC 9(01).
           03  FLG-RECE62                              PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-TBL-OCC                             OCCURS  2.
               05  CNT-IN                              PIC 9(06).
               05  CNT-MOD                             PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                                     PIC 9(03).
           03  IDY                                     PIC 9(03).
           03  IDZ                                     PIC 9(03).
	   03  IDX1                                    PIC 9(03).
           03  IDX2                                    PIC 9(03).
           03  HC-IDX                                  PIC 9(03).
           03  KH-IDX                                  PIC 9(03).
      *
      *    実日数カウント用領域
       01  TBL-JNISSU.
           03  TBL-JNISSU-HKN       OCCURS   5.
               05  TBL-JNISSU-DAY                      PIC X(01)
                                                       OCCURS   31.
      *
       01  WRK-DAY-TABLE.
           03  WRK-DAY-T                               OCCURS   31.
               05  WRK-DAY1                            PIC 9(04).
               05  WRK-DAY5                            PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-IN                                  PIC X(01).
           03  WRK-PARA.
               05  WRK-PARA-SRYYM                      PIC X(06).
               05  WRK-PARA-TERMID                     PIC X(16).
               05  WRK-PARA-SYSYMD                     PIC X(08).
               05  WRK-PARA-JOBID                      PIC 9(07).
               05  WRK-PARA-SHELLID                    PIC X(08).
      *
           03  WRK-RECEERR                             PIC X(200). 
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    入院会計
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    診療会計
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *    患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
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
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC    UNTIL   FLG-END =   1 
      *
           PERFORM 300-TERM-SEC
      *
           STOP    RUN
           .
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  CNT-AREA
                                       WRK-AREA
      *
           MOVE    ZERO                TO  FLG-END
      *
           MOVE    COMMAND-PARAM       TO  WRK-PARA
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCR0630"      TO  JOB-PGID
           MOVE    "診療実日数編集"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
          .
       100-INIT-EXT.
           EXIT.
      * 
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           PERFORM VARYING IDZ FROM    1   BY  1
                   UNTIL   IDZ >       2
                   OR      FLG-END     =   1
      *
               IF      IDZ             =   1               
      *    レセプト処理
                   MOVE    "RECE620"           TO  RECE62PARA-FILE-ID
               ELSE
      *    請求書処理
                   MOVE    "RECE62X"           TO  RECE62PARA-FILE-ID
               END-IF
               MOVE    WRK-PARA-TERMID         TO  RECE62PARA-TERMID
      *
               PERFORM 200-HENSYU-SEC
           END-PERFORM 
      *
           MOVE    1                   TO  FLG-END
           .
       200-MAIN-EXT.
           EXIT.
      * 
      *****************************************************************
      *    主処理
      *****************************************************************
       200-HENSYU-SEC                SECTION.
      *
           MOVE    ZERO                TO  FLG-RECE62
      *
           OPEN    I-O                 RECE62-FILE
      *
           PERFORM    RECE62-READ-SEC
      *
           PERFORM                     UNTIL   FLG-RECE62  =   1
               PERFORM     210-HENSYU-SEC
      *
               PERFORM     RECE62-READ-SEC
           END-PERFORM
      *
           CLOSE   RECE62-FILE
           .
       200-HENSYU-EXT.
           EXIT.
      * 
      *****************************************************************
      *    編集処理
      *****************************************************************
       210-HENSYU-SEC                   SECTION.
      *
           MOVE       SPACE             TO     TBL-JNISSU
           INITIALIZE                          TBL-JNISSU
      *
           MOVE       SPACE             TO     WRK-DAY-TABLE
           INITIALIZE                          WRK-DAY-TABLE
      *
           PERFORM    VARYING    IDX    FROM   1   BY   1
                      UNTIL     (IDX      >   10)  OR
                                (RECE62-SRYKA(IDX)   =   SPACE)
               PERFORM    RECE62-HENSYU-SEC
               PERFORM    RECE62-HENSYU2-SEC
           END-PERFORM
      *
           PERFORM     JNISSU-SET-SEC
      *
           PERFORM     RECE62-REWRITE-SEC
           .
       210-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの編集（Ｆ００２）
      *****************************************************************
       RECE62-HENSYU-SEC                SECTION.
      *
           INITIALIZE                            NYUINACCT-REC
           MOVE    RECE62-HOSPID         TO      NACCT-HOSPID
           MOVE    RECE62-NYUGAIKBN      TO      NACCT-NYUGAIKBN
           MOVE    RECE62-PTID           TO      NACCT-PTID
           MOVE    RECE62-SRYKA(IDX)     TO      NACCT-SRYKA
           MOVE    RECE62-SRYYM          TO      NACCT-SRYYM
           MOVE    NYUINACCT-REC         TO      MCPDATA-REC
           MOVE    "DBSELECT"            TO      MCP-FUNC
           MOVE    "NYUINACCT-KEY2"      TO      ORC-DBPATH
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
           IF      MCP-RC             =       ZERO
      *
               MOVE    "NYUINACCT-KEY2"  TO      ORC-DBPATH
               PERFORM  NYUINACCT-READ-SEC
               PERFORM  UNTIL  (FLG-NYUINACCT  =    "1")
      *
                 IF     NACCT-ZAISKBKBN    =    "1"  OR  "5"   
                       PERFORM    NYUIN-DAY-TAIHI-SEC
                 END-IF
      *
                 MOVE          "NYUINACCT-KEY2"  TO   ORC-DBPATH
                 PERFORM        NYUINACCT-READ-SEC
               END-PERFORM
      *
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "NYUINACCT-KEY2"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           PERFORM  VARYING  IDY    FROM    1   BY  1
                          UNTIL   IDY     >       31
      *
              PERFORM  VARYING  IDX1    FROM    1   BY  1
                          UNTIL   IDX1    >       10
                          OR      RECE62-HKNCOMBI (IDX1)  =   ZERO 
      *
                 IF        WRK-DAY5(IDY)   =   RECE62-HKNCOMBI (IDX1)
                      MOVE    ZERO            TO    FLG-SHOSAISIN
                      IF   WRK-DAY1(IDY)   NOT =    ZERO    
                               MOVE    1      TO    FLG-SHOSAISIN
                      END-IF
                      PERFORM   RECE62-TENSOU-SEC
                 END-IF
      *
              END-PERFORM
      *
           END-PERFORM
      *
           .
       RECE62-HENSYU-EXT.
           EXIT.
      *
      ******************************************************************
      *    会計フラグ退避処理                                          *
      ******************************************************************
       NYUIN-DAY-TAIHI-SEC         SECTION.
      *
           PERFORM    VARYING   IDY   FROM   1   BY   1
                                    UNTIL    IDY    >    31
      *
             IF       NACCT-DAY(IDY)   NOT =  ZERO 
      *
               IF     NACCT-ZAISKBKBN    =    "1"  
                    MOVE   NACCT-DAY(IDY)  TO   WRK-DAY1(IDY) 
               END-IF 
      *
               IF     NACCT-ZAISKBKBN    =    "5"  
                    MOVE   NACCT-DAY(IDY)  TO   WRK-DAY5(IDY) 
               END-IF 
      *
             END-IF
      *
           END-PERFORM.
      *
       NYUIN-DAY-TAIHI-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの項目転送（Ｆ００２）
      *****************************************************************
       RECE62-TENSOU-SEC                 SECTION.
      *
           IF    (RECE62-HKNNUM          NOT =   SPACE)   OR
                 (RECE62-RJNHKNNUM       NOT =   SPACE)
               IF   FLG-SHOSAISIN        =       1
                       MOVE    "1"   TO   TBL-JNISSU-DAY(1 IDY)
               END-IF
           END-IF
      *
           MOVE    ZERO             TO   HC-IDX
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       10
                   OR      RECE62-HKNCOMBI (IDX1)   =   ZERO 
               IF      WRK-DAY5(IDY)  =   RECE62-HKNCOMBI (IDX1)
                   MOVE    IDX1            TO  HC-IDX
                   MOVE    10              TO  IDX1
               END-IF
           END-PERFORM
      *
           MOVE       ZERO              TO   KH-IDX
           PERFORM    VARYING   IDX2    FROM   1   BY   1
                                UNTIL   (IDX2      >       4)
               IF     RECE62-KOHNUMHC(HC-IDX IDX2)  NOT =  SPACE
      *
                 IF   RECE62-KOHNUMHC(HC-IDX IDX2) =  RECE62-KOHNUM(1)
                      MOVE    2          TO        KH-IDX
                 END-IF
                 IF   RECE62-KOHNUMHC(HC-IDX IDX2) =  RECE62-KOHNUM(2)
                      MOVE    3          TO        KH-IDX
                 END-IF
                 IF   RECE62-KOHNUMHC(HC-IDX IDX2) =  RECE62-KOHNUM(3)
                      MOVE    4          TO        KH-IDX
                 END-IF
                 IF   RECE62-KOHNUMHC(HC-IDX IDX2) =  RECE62-KOHNUM(4)
                      MOVE    5          TO        KH-IDX
                 END-IF
      *
                 IF   KH-IDX             NOT =    ZERO
                   IF   FLG-SHOSAISIN      =    1
                         MOVE    "1"   TO   TBL-JNISSU-DAY(KH-IDX IDY)
                   END-IF
                 END-IF
               END-IF  
           END-PERFORM
           .
       RECE62-TENSOU-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの編集（Ｆ００２）
      *****************************************************************
       RECE62-HENSYU2-SEC                SECTION.
      *
           INITIALIZE                           SRYACCT-REC
           MOVE    RECE62-HOSPID        TO      ACCT-HOSPID
           MOVE    RECE62-NYUGAIKBN     TO      ACCT-NYUGAIKBN
           MOVE    RECE62-PTID          TO      ACCT-PTID
           MOVE    RECE62-SRYKA(IDX)    TO      ACCT-SRYKA
           MOVE    RECE62-SRYYM         TO      ACCT-SRYYM
           MOVE    SRYACCT-REC          TO      MCPDATA-REC
           MOVE    "DBSELECT"           TO      MCP-FUNC
           MOVE    "SRYACCT-KEY2"       TO      ORC-DBPATH
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
           IF      MCP-RC               =       ZERO
               MOVE    "SRYACCT-KEY2"   TO      ORC-DBPATH
               PERFORM  SRYACCT-READ-SEC
               PERFORM  UNTIL
                  (FLG-SRYACCT        =    1)
                   PERFORM VARYING IDX1    FROM    1   BY  1
                           UNTIL   IDX1    >       10
                           OR      RECE62-HKNCOMBI (IDX1)  =   ZERO 
                       IF      ACCT-HKNCOMBI   =
                                               RECE62-HKNCOMBI (IDX1)
                           IF   (ACCT-ZAITEN    NOT =    ZERO)    AND
                                (ACCT-ZAIKAISU  NOT =    ZERO)
                               PERFORM   RECE62-TENSOU2-SEC
                           END-IF
                       END-IF
                   END-PERFORM
                   MOVE     "SRYACCT-KEY2"   TO   ORC-DBPATH
                   PERFORM   SRYACCT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "SRYACCT-KEY2"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
       RECE62-HENSYU2-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの項目転送（Ｆ００２）
      *****************************************************************
       RECE62-TENSOU2-SEC                 SECTION.
      *
           IF    (RECE62-HKNNUM          NOT =   SPACE)   OR
                 (RECE62-RJNHKNNUM       NOT =   SPACE)
               IF        ACCT-SRYKBN        =    "95"   OR  "96"
                   CONTINUE
               ELSE
                 IF        ACCT-SRYCDTOTAL    =    630010002
                   COMPUTE  RECE62-TOTALTEN(1) =  RECE62-TOTALTEN(1) -
                                                 (ACCT-ZAITEN  *  
                                                  ACCT-ZAIKAISU)
                 ELSE
                   COMPUTE  RECE62-TOTALTEN(1) =  RECE62-TOTALTEN(1) +
                                                 (ACCT-ZAITEN  *  
                                                  ACCT-ZAIKAISU)
                 END-IF
               END-IF
           END-IF
      *
           MOVE    ZERO             TO   HC-IDX
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       10
                   OR      RECE62-HKNCOMBI (IDX1)   =   ZERO 
               IF      ACCT-HKNCOMBI   =
                                        RECE62-HKNCOMBI (IDX1)
                   MOVE    IDX1            TO  HC-IDX
                   MOVE    10              TO  IDX1
               END-IF
           END-PERFORM          
      *
           MOVE       ZERO              TO   KH-IDX
           PERFORM    VARYING   IDX2    FROM   1   BY   1
             UNTIL   (IDX2      >       4)
               IF     RECE62-KOHNUMHC(HC-IDX IDX2)  NOT =  SPACE
                 IF   RECE62-KOHNUMHC(HC-IDX IDX2) =  RECE62-KOHNUM(1)
                      MOVE    2          TO        KH-IDX
                 END-IF
                 IF   RECE62-KOHNUMHC(HC-IDX IDX2) =  RECE62-KOHNUM(2)
                      MOVE    3          TO        KH-IDX
                 END-IF
                 IF   RECE62-KOHNUMHC(HC-IDX IDX2) =  RECE62-KOHNUM(3)
                      MOVE    4          TO        KH-IDX
                 END-IF
                 IF   RECE62-KOHNUMHC(HC-IDX IDX2) =  RECE62-KOHNUM(4)
                      MOVE    5          TO        KH-IDX
                 END-IF
      *
                 IF   KH-IDX             NOT =    ZERO
                   IF        ACCT-SRYKBN        =    "95"   OR  "96"
                       CONTINUE
                   ELSE
                     IF        ACCT-SRYCDTOTAL    =    630010002
                       COMPUTE  RECE62-TOTALTEN(KH-IDX) =
                                         RECE62-TOTALTEN(KH-IDX) -
                                        (ACCT-ZAITEN * 
                                         ACCT-ZAIKAISU)
                     ELSE
                       COMPUTE  RECE62-TOTALTEN(KH-IDX) =
                                         RECE62-TOTALTEN(KH-IDX) +
                                        (ACCT-ZAITEN * 
                                         ACCT-ZAIKAISU)
                     END-IF
                   END-IF
                 END-IF
      *
               END-IF  
           END-PERFORM
           .
       RECE62-TENSOU2-EXT.
           EXIT.
      *
      *****************************************************************
      *    実日数の項目転送（Ｆ００２）
      *****************************************************************
       JNISSU-SET-SEC                    SECTION.
      *
           PERFORM    VARYING    IDX    FROM   1   BY   1
                      UNTIL      IDX    >      5
               PERFORM    VARYING    IDY    FROM    1   BY   1
                          UNTIL      IDY    >     31
                    IF    TBL-JNISSU-DAY(IDX IDY)  NOT =  SPACE
                          ADD    1      TO    RECE62-JNISSU(IDX)
                    END-IF
               END-PERFORM
           END-PERFORM
           .
       JNISSU-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    データ更新処理（Ｆ００２）
      *****************************************************************
       RECE62-REWRITE-SEC                SECTION.
      *
           REWRITE   RECE62-REC
      *
           ADD     1                   TO  CNT-MOD (IDZ)
      *
           .
       RECE62-WRITE-EXT.
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
      *    終了処理
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
      ***     DISPLAY "RECE620 IN  :" CNT-IN   (1) 
      ***     DISPLAY "        MOD :" CNT-MOD  (1) 
      ***     DISPLAY "RECE62X IN  :" CNT-IN   (2) 
      ***     DISPLAY "        MOD :" CNT-MOD  (2) 
              DISPLAY "*** ORCR0630 END ***"
      ***     ACCEPT  WRK-IN FROM CONSOLE 
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスター読込
      *****************************************************************
       NYUINACCT-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  NYUINACCT-REC
               MOVE    ZERO            TO  FLG-NYUINACCT
           ELSE
               INITIALIZE                  NYUINACCT-REC
               MOVE    1               TO  FLG-NYUINACCT
           END-IF
      *
           .
       NYUINACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計読込
      *****************************************************************
       SRYACCT-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACCT-REC
               MOVE    ZERO            TO  FLG-SRYACCT
           ELSE
               INITIALIZE                  SRYACCT-REC
               MOVE    1               TO  FLG-SRYACCT
           END-IF
      *
           .
       SRYACCT-READ-EXT.
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
      *****************************************************************
      *    中間ファイルＲＥＡＤ処理
      *****************************************************************
       RECE62-READ-SEC            SECTION.
      *
           READ    RECE62-FILE   NEXT
               AT  END
                   MOVE    1     TO    FLG-RECE62
               NOT  AT  END
                   ADD     1     TO    CNT-IN (IDZ)
           END-READ
           .
       RECE62-READ-EXT.
           EXIT.
      *
