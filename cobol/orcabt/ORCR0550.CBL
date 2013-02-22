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
       PROGRAM-ID.             ORCR0550.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト（労災）
      *  コンポーネント名  : レセプト電算ファイル作成
      *                      並び替え処理（診療種別順）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  13/02/07    NACL−藤原    新規作成
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
           SELECT  RECE44-FILE     ASSIGN  RECE44PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE44-KEY
                                   FILE    STATUS  IS  STS-RECE44.
      *
           SELECT  RECE441-FILE    ASSIGN  RECE441PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE441-KEY
                                   FILE    STATUS  IS  STS-RECE441.
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
       FD  RECE44-FILE.
       01  RECE44-REC. 
           COPY    "CPRCF0441.INC" REPLACING  //RECE441//
                                   BY         //RECE44//.
      *
       FD  RECE441-FILE.
       01  RECE441-REC. 
           COPY    "CPRCF0441.INC".
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC                 PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
           COPY    "COMMON-SPA".
      *
      *     ファイル名称領域
           COPY    "CPRECEDAT1.INC"    REPLACING  //RECEDAT1//
                                       BY         //RECE44//.
      *
           COPY    "CPRECEDAT1.INC"    REPLACING  //RECEDAT1//
                                       BY         //RECE441//.
      *
      *    エラーファイル名称領域 
           COPY    "CPERRFL.INC"       REPLACING  //ERRFLPARA//
                                       BY         //RECEERR//.
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECE44              PIC X(02).
           03  STS-RECE441             PIC X(02).
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
           03  WRK-PARA-HOSPNUM        PIC 9(02).
      *
       01  WRK-ERR-AREA.
           03  WRK-RECEERR             PIC X(200).
           03  WRK-ERRMSG              PIC X(300).
           03  WRK-MCP-RC              PIC 9(9).
           03  WRK-ERR-FILE-STS        PIC X(02).
           03  WRK-ERR-FILE-MSG        PIC X(100).
           03  WRK-ERR-FILE-MSG1       PIC X(17).
           03  WRK-ERR-FLG             PIC 9(01).
      *    エラーファイル名称領域 
           COPY    "CPRECEDAT1.INC"    REPLACING  //RECEDAT1PARA//
                                       BY         //WRK-ERR-FILE-NM//.
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
      *    サブプロ用領域
      *****************************************************************
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "MCPAREA".
      *     
      *****************************************************************
       LINKAGE                     SECTION.
       01  COMMAND-PARAM.
           02  FILLER                  PIC X(1000).
      *****************************************************************
       PROCEDURE                   DIVISION
                                   USING   COMMAND-PARAM.
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
      *    初期処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  CNT-AREA
                                       WRK-AREA
                                       SPA-AREA
                                       FLG-AREA
      *
           UNSTRING    COMMAND-PARAM   DELIMITED  BY  ","
                                       INTO    WRK-PARA1
                                               WRK-PARA-JOBID
                                               WRK-PARA-SHELLID
                                               WRK-PARA-HOSPNUM
                                               RECEERR
           END-UNSTRING
           MOVE    WRK-PARA-HOSPNUM    TO  SPA-HOSPNUM
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    "レセ電用データ並び変え"
                                       TO  JOB-SHELLMSG
           MOVE    "ORCR0550"          TO  JOB-PGID
           PERFORM 900-CALL-ORCSJOB-SEC
      *
           MOVE    "RECE44F"           TO  RECE44PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE44PARA-TERMID
           MOVE    WRK-PARA-HOSPNUM    TO  RECE44PARA-HOSPNUM
      *
           MOVE    "RECE448"           TO  RECE441PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE441PARA-TERMID
           MOVE    WRK-PARA-HOSPNUM    TO  RECE441PARA-HOSPNUM
      *
           OPEN    INPUT               RECE44-FILE
           IF      STS-RECE44          =   "00"
               CONTINUE
           ELSE
               MOVE    SPACE               TO  WRK-ERR-AREA
               INITIALIZE                      WRK-ERR-AREA
               MOVE    1                   TO  WRK-ERR-FLG
               MOVE    RECE44PARA          TO  WRK-ERR-FILE-NM
               MOVE    STS-RECE44          TO  WRK-ERR-FILE-STS
               PERFORM 500-FILE-ERR-ABORT-SEC
           END-IF
      *
           OPEN    OUTPUT              RECE441-FILE
           CLOSE                       RECE441-FILE
           OPEN    I-O                 RECE441-FILE
      *
           OPEN    INPUT               RECE44-FILE
      *
           PERFORM 900-RECE44-READ-SEC
           .
       100-INIT-EXT.
           EXIT.
      * 
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           INITIALIZE                      RECE441-REC
           MOVE    RECE44-REC          TO  RECE441-REC
           IF      RECE44-SRYKBN   =   "99"
               IF      RECE44-SRYSYUKBN    =   "991"
                   MOVE    "99"            TO  RECE441-SRYKBN
               ELSE
                   MOVE    "01"            TO  RECE441-SRYKBN
               END-IF
           ELSE
               IF      RECE44-SRYKBN   =   "64"
                   MOVE    "60"            TO  RECE441-SRYKBN
               ELSE
                   MOVE    RECE44-SRYKBN   TO  RECE441-SRYKBN
               END-IF
           END-IF
      *
           WRITE   RECE441-REC
           IF      STS-RECE441         =   "00"
               CONTINUE
           ELSE
               MOVE    SPACE               TO  WRK-ERR-AREA
               INITIALIZE                      WRK-ERR-AREA
      *
               MOVE    3                   TO  WRK-ERR-FLG
               MOVE    RECE441PARA         TO  WRK-ERR-FILE-NM
               MOVE    STS-RECE441         TO  WRK-ERR-FILE-STS
               PERFORM 500-FILE-ERR-ABORT-SEC
           END-IF
      *
           ADD     1                   TO  CNT-OUT
      *
           PERFORM 900-RECE44-READ-SEC      
           .
       200-MAIN-EXT.
           EXIT. 
      *
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC          SECTION.
      *
           OPEN    INPUT   RECEERR-FILE
           IF      STS-RECEERR         =   ZERO
               CLOSE   RECEERR-FILE
           ELSE
               OPEN    OUTPUT              RECEERR-FILE
      *
               MOVE    WRK-RECEERR     TO  RECEERR-REC
               WRITE   RECEERR-REC
               CLOSE   RECEERR-FILE
      *         
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               PERFORM 900-CALL-ORCSJOB-SEC
           END-IF
      *                             
           MOVE    SPACE               TO  WRK-ERRMSG
           STRING  "ORCR0550 "         DELIMITED  BY  SIZE
                   WRK-RECEERR         DELIMITED  BY  SIZE
                   LOW-VALUE           DELIMITED  BY  SIZE
                                       INTO    WRK-ERRMSG
           END-STRING
           PERFORM 500-COBABORT-SEC
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラー時終了処理
      *****************************************************************
       500-COBABORT-SEC            SECTION.
      *
           CALL    "cobabort"          USING   WRK-ERRMSG
      *
           .
       500-COBABORT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイルエラー処理
      *****************************************************************
       500-FILE-ERR-ABORT-SEC      SECTION.
      *
           EVALUATE    WRK-ERR-FLG
               WHEN    1
                   MOVE    "ファイルＯＰＥＮエラー　FILE="
                                           TO  WRK-ERR-FILE-MSG
                   MOVE    "file open err" TO  WRK-ERR-FILE-MSG1
               WHEN    2
                   MOVE    "ファイル読み込みエラー　FILE="
                                           TO  WRK-ERR-FILE-MSG
                   MOVE    "file read err" TO  WRK-ERR-FILE-MSG1
               WHEN    3
                   MOVE    "ファイル書き込みエラー　FILE="
                                           TO  WRK-ERR-FILE-MSG
                   MOVE    "file write err"
                                           TO  WRK-ERR-FILE-MSG1
               WHEN    4
                   MOVE    "ファイル更新エラー　FILE="
                                           TO  WRK-ERR-FILE-MSG
                   MOVE    "file rewrite err"
                                           TO  WRK-ERR-FILE-MSG1
           END-EVALUATE
      *
           STRING  WRK-ERR-FILE-MSG        DELIMITED   BY  SPACE
                   WRK-ERR-FILE-NM-FILE-ID DELIMITED   BY  SIZE
                   " STS="                 DELIMITED   BY  SIZE
                   WRK-ERR-FILE-STS        DELIMITED   BY  SIZE
                                           INTO    WRK-RECEERR
           END-STRING
           PERFORM 500-ERR-HENSYU-SEC
      *
           STRING  "ORCR0550 "             DELIMITED   BY  SIZE
                   WRK-ERR-FILE-MSG1       DELIMITED   BY  SIZE
                   " FILE="                DELIMITED   BY  SIZE
                   WRK-ERR-FILE-NM         DELIMITED   BY  SIZE
                   "  STS="                DELIMITED   BY  SIZE
                   WRK-ERR-FILE-STS        DELIMITED   BY  SIZE
                   LOW-VALUE               DELIMITED   BY  SIZE
                                           INTO    WRK-ERRMSG
           END-STRING
           PERFORM 500-COBABORT-SEC
      *
           .
       500-FILE-ERR-ABORT-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
           CLOSE   RECE44-FILE
           CLOSE   RECE441-FILE
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           PERFORM 900-CALL-ORCSJOB-SEC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           DISPLAY "RECE44  IN  " CNT-IN
           DISPLAY "RECE441 OUT " CNT-OUT 
           DISPLAY "*** ORCR0550 END ***"
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト明細読込
      *****************************************************************
       900-RECE44-READ-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-READ
      *
           PERFORM                 UNTIL   FLG-END     =   1
                                   OR      FLG-READ    =   1            
               READ    RECE44-FILE         NEXT
                   AT  END
                       MOVE    1           TO  FLG-END
                   NOT AT  END
                       IF      STS-RECE44          =   "00"
                           CONTINUE
                       ELSE
                           MOVE    SPACE           TO  WRK-ERR-AREA
                           INITIALIZE                  WRK-ERR-AREA
                           MOVE    2               TO  WRK-ERR-FLG
                           MOVE    RECE44PARA      TO  WRK-ERR-FILE-NM
                           MOVE    STS-RECE44      TO  WRK-ERR-FILE-STS
                           PERFORM 500-FILE-ERR-ABORT-SEC
                       END-IF
      *??
           DISPLAY "RECE44-RECESYUBETU=" RECE44-RECESYUBETU "#" 
                     RECE44-SRYKBN "#" RECE44-MEISAISU
      *??
      *
                       IF    ( RECE44-RECESYUBETU  =   ZERO
                                                   OR  7021      )
                       OR    ( RECE44-SRYKBN       =   "95"   OR
                                                       "96"      )
                       OR    ( RECE44-MEISAISU     =   0         )
                           CONTINUE
                       ELSE
                           MOVE    1           TO  FLG-READ
                       END-IF      
      *
                       IF      FLG-READ            =   1
                           ADD     1               TO  CNT-IN
      *
                           DISPLAY "PTNUM=" RECE44-PTNUM
      *??
           DISPLAY "SYUTEN=" RECE44-SRYKBN "#" 
                     RECE44-ZAITEN "#" RECE441-SYUTEN1 "#"
                             RECE441-SYUTEN2 "#" RECE44-ZAI-KINGAKU
                            "#" RECE44-ZAI-TENSU "#"
      *??
                       END-IF
               END-READ
           END-PERFORM
           .
       900-RECE44-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ管理ＤＢ制御処理
      *****************************************************************
       900-CALL-ORCSJOB-SEC        SECTION.
      *
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
           MOVE    SPA-HOSPNUM         TO  JOB-HOSPNUM
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA 
                                       JOBKANRI-REC
                                       SPA-AREA
           .
       900-CALL-ORCSJOB-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルアクセス処理
      *****************************************************************
       900-ORCDBMAIN-SEC               SECTION.
      *
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
      *
       900-ORCDBMAIN-EXT.
           EXIT.
      *      
      *****************************************************************
      *    ＤＢオープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBOPEN"            TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBSTART"           TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBCOMMIT"          TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
           .
       900-DBDISCONNECT-EXT.
           EXIT.
