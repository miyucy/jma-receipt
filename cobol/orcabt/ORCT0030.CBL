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
       PROGRAM-ID.             ORCT0030.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 定期請求
      *  コンポーネント名  : 収納データチェック
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
      *    定期請求期間情報ファイル(IN)
           SELECT  TEIKI03-FILE    ASSIGN  TEIKI03PARA
                   ORGANIZATION   LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-TEIKI03.
      *
      *    請求取消対象収納ファイル(初期化用)
           SELECT  TEIKI04CL-FILE
                                  ASSIGN   TEIKI04PARA
                                  ORGANIZATION    IS  INDEXED
                                  ACCESS  MODE    IS  SEQUENTIAL
                                  RECORD  KEY     IS  TEIKI04CL-KEY
                                  FILE    STATUS  IS  STS-TEIKI04CL.
      *
      *
      *    請求取消対象収納ファイル(OT)
           SELECT  TEIKI04-FILE   ASSIGN   TEIKI04PARA
                                  ORGANIZATION    IS  INDEXED
                                  ACCESS  MODE    IS  DYNAMIC
                                  RECORD  KEY     IS  TEIKI04-KEY
                                  FILE    STATUS  IS  STS-TEIKI04.
      *
      *    削除対象患者請求履歴ファイル(OT)
           SELECT  TEIKI05-FILE    ASSIGN  TEIKI05PARA
                   ORGANIZATION   LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-TEIKI05.
      *
      *    エラーファイル
           SELECT  TEIKIERR-FILE   ASSIGN  TEIKIERR
                                   FILE    STATUS  IS  STS-TEIKIERR.
      *
       DATA                    DIVISION.
       FILE                    SECTION.
      *
      *    定期請求期間情報
       FD  TEIKI03-FILE.
           COPY "CPTEIKI03.INC".
      *
      *    請求取消対象収納ファイル（初期化用）
       FD  TEIKI04CL-FILE.
       01  TEIKI04CL-REC.
           COPY "CPTEIKI01.INC"        REPLACING   //TEIKI01-//
                                       BY          //TEIKI04CL-//.
      *
      *    請求取消対象収納ファイル
       FD  TEIKI04-FILE.
       01  TEIKI04-REC.
           COPY "CPTEIKI01.INC"        REPLACING   //TEIKI01-//
                                       BY          //TEIKI04-//.
      *
      *    削除対象患者請求履歴ファイル
       FD  TEIKI05-FILE.
       01  TEIKI05-REC.
           COPY    "CPPTTEIKIRRK.INC"  REPLACING   //PTTEIKIRRK-//
                                       BY          //TEIKI05-//.
      *
      *    エラーファイル
       FD  TEIKIERR-FILE.
       01  TEIKIERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    定期請求期間情報名称領域 
           COPY    "CPCOMMONDAT5.INC"
                                   REPLACING  //TEIKI01//
                                   BY         //TEIKI03//.
      *
      *    請求取消対象収納ファイル名称領域 
           COPY    "CPCOMMONDAT5.INC"
                                   REPLACING  //TEIKI01//
                                   BY         //TEIKI04//.
      *
      *
      *    削除対象患者請求履歴ファイル名称領域 
           COPY    "CPCOMMONDAT5.INC"
                                   REPLACING  //TEIKI01//
                                   BY         //TEIKI05//.
      *
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
           03  STS-TEIKI03                             PIC X(02).
           03  STS-TEIKI04                             PIC X(02).
           03  STS-TEIKI04CL                           PIC X(02).
           03  STS-TEIKI05                             PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-ERR                                 PIC 9(01).
           03  FLG-TEIKI03                             PIC 9(01).
           03  FLG-SYUNOU                              PIC 9(01).
           03  FLG-PTTEIKIRRK                          PIC 9(01).
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
      *    収納マスター
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    患者定期請求履歴
       01  PTTEIKIRRK-REC.
           COPY    "CPPTTEIKIRRK.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    定期請求用収納作成サブ
       01  LNK-ORCS02-REC.
           COPY  "CPORCS02.INC".
       01  LNK-SYUNOU-REC-T.
         02 LNK-SYUNOU-REC     OCCURS 10.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-// BY //LNK-SYU-//.
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
           MOVE    "ORCT0030"      TO  JOB-PGID
           MOVE    "収納データチェック"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           MOVE    ZERO                TO  FLG-END
                                           FLG-ERR
      *
           MOVE    "TEIKI003"          TO  TEIKI03PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  TEIKI03PARA-TERMID
      *
           MOVE    "TEIKI004"          TO  TEIKI04PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  TEIKI04PARA-TERMID
      *
           MOVE    "TEIKI005"          TO  TEIKI05PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  TEIKI05PARA-TERMID
      *
           MOVE    "TEIKIERR"          TO  TEIKIERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  TEIKIERR-TERMID
      *
      *    請求取消対象収納ファイル初期化
           OPEN    OUTPUT              TEIKI04CL-FILE
           CLOSE   TEIKI04CL-FILE
      *
           OPEN    INPUT               TEIKI03-FILE
           OPEN    OUTPUT              TEIKI04-FILE
           OPEN    OUTPUT              TEIKI05-FILE
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
           MOVE    ZERO                TO  FLG-TEIKI03
      *
           PERFORM 910-TEIKI03-READ-SEC
      *
           PERFORM UNTIL ( FLG-TEIKI03 NOT =   ZERO )
      *
      *        収納データチェック処理
               PERFORM 2001-SYUNOU-CHK-SEC
               IF    ( FLG-ERR     =   1 )
                   GO  TO  200-MAIN-EXT
               END-IF
      *
      *        患者定期請求履歴チェック処理
               PERFORM 2001-PTTEIKIRRK-CHK-SEC
               IF    ( FLG-ERR     =   1 )
                   GO  TO  200-MAIN-EXT
               END-IF
      *
               PERFORM 910-TEIKI03-READ-SEC
      *
           END-PERFORM
      *
           MOVE    1                   TO  FLG-END
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納データチェック処理
      *****************************************************************
       2001-SYUNOU-CHK-SEC             SECTION.
      *
           MOVE    ZERO                TO  FLG-SYUNOU
           INITIALIZE   SYUNOU-REC
           MOVE    TEIKI03-HOSPID      TO  SYU-HOSPID
           MOVE     "1"                TO  SYU-NYUGAIKBN
           MOVE    TEIKI03-PTID        TO  SYU-PTID
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-SYUNOU-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
      *    今回定期請求期間にかかる収納データを抽出する
           PERFORM UNTIL ( FLG-SYUNOU  NOT     =   ZERO )
      *
               IF    ( TEIKI03-SKYSTYMD       <=  SYU-SKYEDYMD )
                AND  ( TEIKI03-SKYEDYMD       >=  SYU-SKYSTYMD )
                   IF    ( SYU-DENPJTIKBN  NOT =   "3" )
                       PERFORM 20011-TEIKI04-OUTPUT-SEC
                   END-IF
               END-IF
      *
               PERFORM 910-SYUNOU-READ-SEC
      *
           END-PERFORM
      *
           MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
       2001-SYUNOU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    請求取消対象収納ファイル出力処理
      *****************************************************************
       20011-TEIKI04-OUTPUT-SEC      SECTION.
      *
           MOVE    WRK-PARA-TERMID     TO  SYU-TERMID
           MOVE    SYS-YMD             TO  SYU-CREYMD
                                           SYU-UPYMD
           MOVE    SYS-TIME            TO  SYU-UPHMS
      *
           MOVE    SYUNOU-REC          TO  TEIKI04-DAT
      *
           MOVE    SYU-HOSPID          TO  TEIKI04-HOSPID
           MOVE    SYU-PTID            TO  TEIKI04-PTID
           MOVE    SYU-SKYSTYMD        TO  TEIKI04-SKYSTYMD
           MOVE    SYU-SKYEDYMD        TO  TEIKI04-SKYEDYMD
           MOVE    SYU-HKNCOMBINUM     TO  TEIKI04-HKNCOMBINUM
      *
           WRITE   TEIKI04-REC
      *
           COMPUTE CNT-OUT1    =   CNT-OUT1    +   1
      *
           .
       20011-TEIKI04-OUTPUT-EXT.
           EXIT. 
      *****************************************************************
      *    削除対象患者請求履歴ファイル出力処理
      *****************************************************************
       2001-PTTEIKIRRK-CHK-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-PTTEIKIRRK
           INITIALIZE   PTTEIKIRRK-REC
           MOVE    TEIKI03-HOSPID      TO  PTTEIKIRRK-HOSPID
           MOVE    TEIKI03-PTID        TO  PTTEIKIRRK-PTID
           MOVE    TEIKI03-SKYSTYMD (1 : 6)
                                       TO  PTTEIKIRRK-SRYYM
           MOVE    PTTEIKIRRK-REC      TO  MCPDATA-REC
           MOVE    "PTTEIKIRRK-KEY2"   TO  ORC-DBPATH
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-PTTEIKIRRK-READ-SEC
           ELSE
               MOVE    1               TO  FLG-PTTEIKIRRK
           END-IF
      *
           PERFORM UNTIL ( FLG-PTTEIKIRRK  NOT =   ZERO )
      *
               IF    ( TEIKI03-SKYSTYMD       <=  PTTEIKIRRK-SKYEDYMD )
                AND  ( TEIKI03-SKYEDYMD       >=  PTTEIKIRRK-SKYSTYMD )
                   PERFORM 20011-TEIKI05-OUTPUT-SEC
               END-IF
      *
               PERFORM 910-PTTEIKIRRK-READ-SEC
      *
           END-PERFORM
      *
           MOVE    "PTTEIKIRRK-KEY2"   TO  ORC-DBPATH
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
       2001-PTTEIKIRRK-CHK-EXT.
           EXIT.
      *****************************************************************
      *    患者請求履歴定期請求ワーク格納処理
      *****************************************************************
       20011-TEIKI05-OUTPUT-SEC      SECTION.
      *
           MOVE    PTTEIKIRRK-REC      TO  TEIKI05-REC
      *
           MOVE    WRK-PARA-TERMID     TO  TEIKI05-TERMID
           MOVE    SYS-YMD             TO  TEIKI05-CREYMD
                                           TEIKI05-UPYMD
           MOVE    SYS-TIME            TO  TEIKI05-UPHMS
      *
           WRITE   TEIKI05-REC
      *
           COMPUTE CNT-OUT2    =   CNT-OUT2    +   1
      *
           .
       20011-TEIKI05-OUTPUT-EXT.
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
           CLOSE   TEIKI03-FILE
                   TEIKI04-FILE
                   TEIKI05-FILE
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
           DISPLAY "TEIKI01 (ORCT0030) CNT " CNT-OUT1 
           DISPLAY "*** ORCT0030 END ***"
      ***  ACCEPT  WRK-IN FROM CONSOLE 
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納マスター読込
      *****************************************************************
       910-SYUNOU-READ-SEC             SECTION.
      *
           MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
           ELSE
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
           .
       910-SYUNOU-READ-EXT.
           EXIT.
      *****************************************************************
      *    患者定期請求履歴読込
      *****************************************************************
       910-PTTEIKIRRK-READ-SEC         SECTION.
      *
           MOVE    "PTTEIKIRRK-KEY2"   TO  ORC-DBPATH
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTTEIKIRRK-REC
           ELSE
               MOVE    1               TO  FLG-PTTEIKIRRK
           END-IF
      *
           .
       910-PTTEIKIRRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    定期請求期間情報読込
      *****************************************************************
       910-TEIKI03-READ-SEC            SECTION.
      *
           READ    TEIKI03-FILE
           AT  END
               MOVE    1               TO  FLG-TEIKI03
           END-READ
      *
           .
       910-TEIKI03-READ-EXT.
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
