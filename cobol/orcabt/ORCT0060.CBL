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
       PROGRAM-ID.             ORCT0060.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 定期請求
      *  コンポーネント名  : 収納データ突合
      *  管理者            :
      *  作成日付    作業者        記述
      *  02/01/07    NACL−太田    新規作成
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
      *    定期請求収納ファイル(IN)
           SELECT  TEIKI01-FILE    ASSIGN   TEIKI01PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  TEIKI01-KEY
                                   FILE    STATUS  IS  STS-TEIKI01.
      *
      *    請求取消対象収納ファイル(IN)
           SELECT  TEIKI04-FILE    ASSIGN   TEIKI04PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  TEIKI04-KEY
                                   FILE    STATUS  IS  STS-TEIKI04.
      *
      *    定期請求収納ファイル(OT)
           SELECT  TEIKI06-FILE    ASSIGN   TEIKI06PARA
                   ORGANIZATION    LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-TEIKI06.
      *
      *    請求取消対象収納ファイル(OT)
           SELECT  TEIKI07-FILE    ASSIGN   TEIKI07PARA
                   ORGANIZATION    LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-TEIKI07.
      *
      *    エラーファイル
           SELECT  TEIKIERR-FILE   ASSIGN  TEIKIERR
                                   FILE    STATUS  IS  STS-TEIKIERR.
      *
       DATA                    DIVISION.
       FILE                    SECTION.
      *
      *    定期請求収納ファイル(IN)
       FD  TEIKI01-FILE.
       01  TEIKI01-REC.
           COPY  "CPTEIKI01.INC".
      *
      *    請求取消対象収納ファイル(IN)
       FD  TEIKI04-FILE.
       01  TEIKI04-REC.
           COPY  "CPTEIKI01.INC"       REPLACING   //TEIKI01-//
                                       BY          //TEIKI04-//.
      *
      *    定期請求収納ファイル(OT)
       FD  TEIKI06-FILE.
       01  TEIKI06-REC.
           COPY    "CPSYUNOU.INC"      REPLACING   //SYU-//
                                       BY          //TEIKI06-//.
      *    請求取消対象収納ファイル(OT)
       FD  TEIKI07-FILE.
       01  TEIKI07-REC.
           COPY    "CPSYUNOU.INC"      REPLACING   //SYU-//
                                       BY          //TEIKI07-//.
      *
      *    エラーファイル
       FD  TEIKIERR-FILE.
       01  TEIKIERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    定期請求収納ファイル名称領域(IN)
           COPY    "CPCOMMONDAT5.INC".
      *
      *    請求取消対象収納ファイル名称領域 (IN)
           COPY    "CPCOMMONDAT5.INC"
                                   REPLACING  //TEIKI01//
                                   BY         //TEIKI04//.
      *
      *    定期請求収納ファイル名称領域 (OT)
           COPY    "CPCOMMONDAT5.INC"
                                   REPLACING  //TEIKI01//
                                   BY         //TEIKI06//.
      *
      *    定期請求収納ファイル名称領域 (OT)
           COPY    "CPCOMMONDAT5.INC"
                                   REPLACING  //TEIKI01//
                                   BY         //TEIKI07//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT5.INC"
                                   REPLACING  //TEIKI01PARA//
                                   BY         //TEIKIERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-TEIKIERR                            PIC X(02).
           03  STS-TEIKI01                             PIC X(02).
           03  STS-TEIKI04                             PIC X(02).
           03  STS-TEIKI06                             PIC X(02).
           03  STS-TEIKI07                             PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-ERR                                 PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-OUT1                                PIC 9(06).
           03  CNT-OUT2                                PIC 9(06).
      *
       01  INDEX-AREA.
           03  IDX1                                    PIC 9(04). 
           03  IDX2                                    PIC 9(04). 
           03  IDX3                                    PIC 9(04). 
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME.
               05  SYS-THH         PIC 9(02).
               05  SYS-TMM         PIC 9(02).
               05  SYS-TSS         PIC 9(02).
               05  SYS-TDD         PIC 9(02).
           03  SYS-YMD.
               05  SYS-YY          PIC 9(04).
               05  SYS-MM          PIC 9(02).
               05  SYS-DD          PIC 9(02).
           03  SYS-WKYMD.
               05  SYS-WKYY        PIC 9(02).
               05  SYS-WKMM        PIC 9(02).
               05  SYS-WKDD        PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-DBPATH                          PIC  X(100).
           03  WRK-PARA.
               05  WRK-PARA-ARG1.
                   07   WRK-PARA-SRYYM             PIC  X(06).
                   07   WRK-PARA-TERMID            PIC  X(64).
                   07   WRK-PARA-SYSYMD            PIC  X(08).
               05  WRK-PARA-SYOKBN                 PIC  X(01).
               05  WRK-PARA-KIKAN-OCC  OCCURS 3.
                   07  WRK-PARA-KIKAN-ST       PIC  X(08).
                   07  WRK-PARA-KIKAN-ED       PIC  X(08).
                   07  WRK-PARA-KIKAN-KBN      PIC  X(01).
               05  WRK-PARA-JOBID              PIC  9(07).
               05  WRK-PARA-SHELLID            PIC  X(08).
      *
           03  WRK-TEIKIERR            PIC X(200).
      *
      *    ＫＥＹ領域
       01  KEY-AREA.
           03  KEY-ZOU.
               05  KEY-Z-HOSPID                PIC X(24).
               05  KEY-Z-PTID                  PIC 9(10).
               05  KEY-Z-SKYSTYMD              PIC X(08).
               05  KEY-Z-SKYEDYMD              PIC X(08).
               05  KEY-Z-HKNCOMBINUM           PIC 9(04).
           03  KEY-GEN.
               05  KEY-Z-HOSPID                PIC X(24).
               05  KEY-Z-PTID                  PIC 9(10).
               05  KEY-Z-SKYSTYMD              PIC X(08).
               05  KEY-Z-SKYEDYMD              PIC X(08).
               05  KEY-Z-HKNCOMBINUM           PIC 9(04).
      *
           COPY    "MCPAREA".
      *
           COPY    "COMMON-SPA".
      *
       01  ZOUSYUNOU-REC.
           COPY    "CPSYUNOU.INC"      REPLACING   //SYU-//
                                       BY          //ZOUSYU-//.
      *
       01  GENSYUNOU-REC.
           COPY    "CPSYUNOU.INC"      REPLACING   //SYU-//
                                       BY          //GENSYU-//.
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
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      ****************************************************************
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(2000).
      ****************************************************************
       PROCEDURE           DIVISION
               USING
           COMMAND-PARAM.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC    UNTIL ( FLG-END =   1 )
                                   OR    ( FLG-ERR =   1 )
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
           INITIALIZE                  INDEX-AREA
                                       CNT-AREA
                                       WRK-AREA
                                       SYS-AREA
                                       SPA-AREA
      *
           ACCEPT  SYS-TIME    FROM    TIME
      *
           ACCEPT  SYS-WKYMD   FROM    DATE
           COMPUTE SYS-YY  =   SYS-WKYY    +   2000
           COMPUTE SYS-MM  =   SYS-WKMM
           COMPUTE SYS-DD  =   SYS-WKDD
      *
           UNSTRING   COMMAND-PARAM    DELIMITED  BY  ","
                                       INTO    WRK-PARA-ARG1
                                               WRK-PARA-SYOKBN
                                               WRK-PARA-KIKAN-OCC (1)
                                               WRK-PARA-KIKAN-OCC (2)
                                               WRK-PARA-KIKAN-OCC (3)
                                               WRK-PARA-JOBID
                                               WRK-PARA-SHELLID
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCT0060"      TO  JOB-PGID
           MOVE    "収納データ突合"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           MOVE    ZERO                TO  FLG-END
                                           FLG-ERR
      *
           MOVE    "TEIKI001"          TO  TEIKI01PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  TEIKI01PARA-TERMID
      *
           MOVE    "TEIKI004"          TO  TEIKI04PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  TEIKI04PARA-TERMID
      *
           MOVE    "TEIKI006"          TO  TEIKI06PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  TEIKI06PARA-TERMID
      *
           MOVE    "TEIKI007"          TO  TEIKI07PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  TEIKI07PARA-TERMID
      *
           MOVE    "TEIKIERR"          TO  TEIKIERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  TEIKIERR-TERMID
      *
           OPEN    INPUT               TEIKI01-FILE
           OPEN    INPUT               TEIKI04-FILE
           OPEN    OUTPUT              TEIKI06-FILE
           OPEN    OUTPUT              TEIKI07-FILE
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
           PERFORM 910-TEIKI01-READ-SEC
           PERFORM 910-TEIKI04-READ-SEC
      *
      *
           PERFORM UNTIL ( KEY-ZOU     =   HIGH-VALUE )
                   AND   ( KEY-GEN     =   HIGH-VALUE )
      *
               EVALUATE    TRUE
               WHEN    KEY-ZOU         <   KEY-GEN
                   MOVE    TEIKI01-DAT TO  TEIKI06-REC
                   WRITE   TEIKI06-REC
                   COMPUTE CNT-OUT1    =   CNT-OUT1    +   1
                   PERFORM 910-TEIKI01-READ-SEC
               WHEN    KEY-ZOU         >   KEY-GEN
                   MOVE    TEIKI04-DAT TO  TEIKI07-REC
                   WRITE   TEIKI07-REC
                   COMPUTE CNT-OUT2    =   CNT-OUT2    +   1
                   PERFORM 910-TEIKI04-READ-SEC
               WHEN    KEY-ZOU         =   KEY-GEN
      *            同一収納チェック
                   PERFORM 2001-DOUITU-SYUNOU-CHK-SEC
                   PERFORM 910-TEIKI01-READ-SEC
                   PERFORM 910-TEIKI04-READ-SEC
               END-EVALUATE
      *
           END-PERFORM
      *
           MOVE    1                   TO  FLG-END
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    同一収納チェック
      *****************************************************************
       2001-DOUITU-SYUNOU-CHK-SEC      SECTION.
      *
           MOVE    TEIKI01-DAT     TO  ZOUSYUNOU-REC
           MOVE    TEIKI04-DAT     TO  GENSYUNOU-REC
      *
           INITIALIZE                  ZOUSYU-DENPNUM
                                       ZOUSYU-DENPLASTNUM
                                       ZOUSYU-DENPJTIKBN
                                       ZOUSYU-CREATEKBN
                                       ZOUSYU-DENPPRTYMD
                                       ZOUSYU-NYUKIN-TOTAL
                                       ZOUSYU-NYUKIN-KAISU
                                       ZOUSYU-TERMID
                                       ZOUSYU-OPID
                                       ZOUSYU-CREYMD
                                       ZOUSYU-UPYMD
                                       ZOUSYU-UPHMS
      *
           INITIALIZE                  GENSYU-DENPNUM
                                       GENSYU-DENPLASTNUM
                                       GENSYU-DENPJTIKBN
                                       GENSYU-CREATEKBN
                                       GENSYU-DENPPRTYMD
                                       GENSYU-NYUKIN-TOTAL
                                       GENSYU-NYUKIN-KAISU
                                       GENSYU-TERMID
                                       GENSYU-OPID
                                       GENSYU-CREYMD
                                       GENSYU-UPYMD
                                       GENSYU-UPHMS
      *
           IF    ( ZOUSYUNOU-REC   NOT =   GENSYUNOU-REC )
               MOVE    TEIKI01-DAT     TO  TEIKI06-REC
               WRITE   TEIKI06-REC
               COMPUTE CNT-OUT1    =   CNT-OUT1    +   1
      *
               MOVE    TEIKI04-DAT     TO  TEIKI07-REC
               WRITE   TEIKI07-REC
               COMPUTE CNT-OUT2    =   CNT-OUT2    +   1
           END-IF
      *
           .
       2001-DOUITU-SYUNOU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC                SECTION.
      *
           DISPLAY "WRK-TEIKIERR = " WRK-TEIKIERR
           DISPLAY "TEIKIERR = " TEIKIERR
           OPEN    INPUT   TEIKIERR-FILE
           IF      STS-TEIKIERR         =   ZERO
               CLOSE   TEIKIERR-FILE
           ELSE
               OPEN    OUTPUT              TEIKIERR-FILE
      *
               MOVE    WRK-TEIKIERR         TO  TEIKIERR-REC
               WRITE   TEIKIERR-REC
               CLOSE   TEIKIERR-FILE
      *
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-TEIKIERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA  
                                       JOBKANRI-REC
           END-IF
      *                             
           MOVE    1                   TO  FLG-ERR
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
           CLOSE   TEIKI01-FILE
                   TEIKI04-FILE
                   TEIKI06-FILE
                   TEIKI07-FILE
      *
           IF      CNT-OUT1            =   ZERO 
               MOVE    "処理対象のデータがありませんでした"
                                           TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
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
           DISPLAY "TEIKI01 (ORCT0060) CNT " CNT-OUT1 
           DISPLAY "*** ORCT0060 END ***"
      ***  ACCEPT  WRK-IN FROM CONSOLE 
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    定期請求収納ファイル読込
      *****************************************************************
       910-TEIKI01-READ-SEC            SECTION.
      *
           READ    TEIKI01-FILE        NEXT
           AT  END
               MOVE    HIGH-VALUE      TO  KEY-ZOU
           NOT AT END
               MOVE    TEIKI01-KEY     TO  KEY-ZOU
           END-READ
      *
           DISPLAY "KEY-ZOU = " KEY-ZOU
           .
       910-TEIKI01-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求取消対象収納ファイル読込
      *****************************************************************
       910-TEIKI04-READ-SEC            SECTION.
      *
           READ    TEIKI04-FILE        NEXT
           AT  END
               MOVE    HIGH-VALUE      TO  KEY-GEN
           NOT AT END
               MOVE    TEIKI04-KEY     TO  KEY-GEN
           END-READ
           DISPLAY "KEY-GEN = " KEY-GEN
      *
           .
       910-TEIKI04-READ-EXT.
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
