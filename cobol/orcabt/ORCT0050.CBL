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
       PROGRAM-ID.             ORCT0050.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 定期請求
      *  コンポーネント名  : 定期請求エラー出力
      *  管理者            :
      *  作成日付    作業者        記述
      *  02/01/21    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
      *    エラーファイル
           SELECT  TEIKIERR-FILE   ASSIGN  TEIKIERR
                                   FILE    STATUS  IS  STS-TEIKIERR.
      *
       DATA                    DIVISION.
       FILE                    SECTION.
      *
      *    エラーファイル
       FD  TEIKIERR-FILE.
       01  TEIKIERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
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
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-ERR                                 PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-OUT1                                PIC 9(06).
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
           COPY    "MCPAREA".
      *
           COPY    "COMMON-SPA".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
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
           PERFORM 200-MAIN-SEC
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
      *
           MOVE    ZERO                TO  FLG-END
                                           FLG-ERR
      *
           MOVE    "TEIKIERR"          TO  TEIKIERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  TEIKIERR-TERMID
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
           OPEN    INPUT   TEIKIERR-FILE
           IF    ( STS-TEIKIERR    =   ZERO )
               READ    TEIKIERR-FILE
      *
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    TEIKIERR-REC    TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
           END-IF
      *
           CLOSE   TEIKIERR-FILE
      *
           MOVE    1                   TO  FLG-END
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
           PERFORM 900-DBDISCONNECT-SEC
      *     
           .
       300-TERM-EXT.
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
           MOVE    "DBCOMMIT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       900-DBCLOSE-EXT.
           EXIT.
