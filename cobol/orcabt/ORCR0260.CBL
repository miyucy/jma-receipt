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
       PROGRAM-ID.             ORCR0260.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト（入院）
      *  コンポーネント名  : レセプト電算ファイル作成
      *                      傷病名データの並び替え処理 
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/04/28    NACL−藤原    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
      *
      *    レセプト明細書  
      *
           SELECT  RECE63-FILE     ASSIGN  RECE63PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE631-KEY
                                   FILE    STATUS  IS  STS-RECE63.
      *
           SELECT  RECE639-FILE    ASSIGN  RECE639PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE639-KEY
                                   FILE    STATUS  IS  STS-RECE639.
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                    SECTION.
      *
      *    レセプト明細書  
       FD  RECE63-FILE.
       01  RECE631-REC. 
           COPY    "CPRCF0631.INC".
      *
       FD  RECE639-FILE.
       01  RECE639-REC. 
           COPY    "CPRCF0631.INC"  REPLACING  //RECE631//
                                   BY          //RECE639//.
           03  RECE639-SYUBYOFLG-X PIC X(01).
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル 名称領域 
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE63//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE639//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECE639             PIC X(02).
           03  STS-RECE63              PIC X(02).
           03  STS-RECEERR             PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                 PIC 9(01).
           03  FLG-READ                PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-IN                  PIC 9(06).
           03  CNT-OUT                 PIC 9(06).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-PARA.
               05  WRK-PARA1.
                   07  WRK-PARA-SRYYM  PIC X(06).
                   07  WRK-PARA-TERMID PIC X(16).
                   07  WRK-PARA-SYSYMD PIC X(08).
               05  WRK-PARA-JOBID      PIC 9(07).
               05  WRK-PARA-SHELLID    PIC X(08).
               05  WRK-PARA-TEISYUTUSAKI
                                       PIC X(01).
               05  WRK-PARA-SYARECEKBN PIC X(01).
               05  WRK-PARA-KKHRECEKBN PIC X(01).
      *
           03  WRK-RECEERR             PIC X(200). 
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
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
                           USING       COMMAND-PARAM.
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
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  CNT-AREA
                                       WRK-AREA
                                       FLG-AREA
      *
           UNSTRING    COMMAND-PARAM   DELIMITED  BY  ","
                                       INTO    WRK-PARA1
                                               WRK-PARA-TEISYUTUSAKI
                                               WRK-PARA-SYARECEKBN
                                               WRK-PARA-KKHRECEKBN
                                               WRK-PARA-JOBID
                                               WRK-PARA-SHELLID
           END-UNSTRING                                  
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCR0260"      TO  JOB-PGID
           MOVE    "傷病名並び変え"    TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           MOVE    "RECE631"           TO  RECE63PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE63PARA-TERMID
      *
           MOVE    "RECE639"           TO  RECE639PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE639PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
           OPEN    INPUT               RECE63-FILE
           OPEN    OUTPUT              RECE639-FILE
      *
           PERFORM 900-RECE63-READ-SEC
           .
       100-INIT-EXT.
           EXIT.
      * 
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           MOVE    RECE631-REC         TO  RECE639-REC
           MOVE    RECE639-SYUBYOFLG   TO  RECE639-SYUBYOFLG-X
           MOVE    SPACE               TO  RECE639-SYUBYOFLG
      *
           WRITE   RECE639-REC
           ADD     1                   TO  CNT-OUT
      *
           PERFORM 900-RECE63-READ-SEC      
           .
       200-MAIN-EXT.
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
           CLOSE   RECE63-FILE
           CLOSE   RECE639-FILE
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
           DISPLAY "RECE63  CNT-IN  :" CNT-IN
           DISPLAY "RECE639 CNT-OUT :" CNT-OUT
           DISPLAY "*** ORCR0260 END ***"
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト明細書０２読込
      *****************************************************************
       900-RECE63-READ-SEC             SECTION.
      *
           MOVE    ZERO                TO  FLG-READ
      *
           PERFORM                 UNTIL   FLG-END     =   1
                                   OR      FLG-READ    =   1            
               READ    RECE63-FILE         NEXT
                   AT  END
                       MOVE    1           TO  FLG-END
                   NOT AT  END
                       IF    ( WRK-PARA-SYARECEKBN =   ZERO )
                       AND   (  RECE631-TEISYUTUSAKI
                                                   =   "1"  )
                           CONTINUE
                       ELSE 
                           IF    ( WRK-PARA-KKHRECEKBN =   ZERO )
                           AND   (  RECE631-TEISYUTUSAKI
                                                       =   "2"  )
                               CONTINUE
                           ELSE 
                               IF      RECE631-RECESYUBETU
                                                   =   ZERO   OR  8888
                                   CONTINUE
                               ELSE
                                   MOVE    1           TO  FLG-READ
                               END-IF
                           END-IF
                       END-IF
      *
                       IF      FLG-READ            =   1         
                           ADD     1           TO  CNT-IN
                           MOVE    ZERO        TO  FLG-END
      *
                           DISPLAY "RECE63  PTID=" RECE631-PTID
                       END-IF
               END-READ
           END-PERFORM
           .
       900-RECE63-READ-EXT.
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
