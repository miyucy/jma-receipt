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
       PROGRAM-ID.             ORCR0650.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト（入院）
      *  コンポーネント名  : 
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/12/13    NaCl−門脇    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
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
           SELECT  RECE64-FILE     ASSIGN  RECE64PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE64-KEY
                                   FILE    STATUS  IS  STS-RECE64.
           SELECT  RECE65-FILE     ASSIGN  RECE65PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE65-KEY
                                   FILE    STATUS  IS  STS-RECE65.
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
       FD  RECE64-FILE.
       01  RECE64-REC. 
           COPY    "CPRCF064.INC".
      *
       FD  RECE65-FILE.
       01  RECE65-REC. 
           COPY    "CPRCF065.INC".
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
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE64//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE65//.
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
           03  STS-RECE64                              PIC X(02).
           03  STS-RECE65                              PIC X(02).
           03  STS-RECEERR                             PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-RECE64                              PIC 9(01).
           03  FLG-RECE65                              PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-IN                                  PIC 9(06).
           03  CNT-OUT1                                PIC 9(06).
           03  CNT-OUT2                                PIC 9(06).
           03  CNT-OUT3                                PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                                     PIC 9(03).
           03  IDX2                                    PIC 9(03).
           03  HC-IDX                                  PIC 9(03).
           03  KH-IDX                                  PIC 9(03).
           03  BUN-IDX                                 PIC 9(03).
      *
      *    剤番号の退避
       01  WK-ZAINUM                                   PIC 9(08).
      *
      *    剤連番の退避
       01  WK-ZAIREN                                   PIC 9(02).
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
      *    サブプロ用領域
      *****************************************************************
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *     
           COPY    "CPORCMCP.INC".  
      *
           COPY    "MCPAREA".
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
           MOVE    "ORCR0650"      TO  JOB-PGID
           MOVE    "公費分点数判定"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           MOVE    "RECE620"           TO  RECE62PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE62PARA-TERMID
      *
           MOVE    "RECE640"           TO  RECE64PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE64PARA-TERMID
      *
           MOVE    "RECE650"           TO  RECE65PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE65PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
           OPEN    INPUT               RECE62-FILE
           OPEN    I-O                 RECE64-FILE
                                       RECE65-FILE
      *
           PERFORM    RECE62-READ-SEC
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
           PERFORM     210-HENSYU-SEC
      *
           PERFORM     RECE62-READ-SEC
           .
       200-MAIN-EXT.
           EXIT.
      * 
      *****************************************************************
      *    編集処理
      *****************************************************************
       210-HENSYU-SEC                   SECTION.
      *
           IF (RECE62-TOTALTEN(2)       =      ZERO)    AND
              (RECE62-TOTALTEN(3)       =      ZERO)
               CONTINUE
           ELSE
               IF (RECE62-TOTALTEN(2)   NOT =  ZERO)              AND
                  (RECE62-TOTALTEN(1)   NOT =  RECE62-TOTALTEN(2))
                   MOVE      1          TO     BUN-IDX
                   PERFORM   RECE64-HENSYU-SEC
               END-IF
               IF (RECE62-TOTALTEN(3)   NOT =  ZERO)              AND
                  (RECE62-TOTALTEN(1)   NOT =  RECE62-TOTALTEN(3))
                   MOVE      2          TO     BUN-IDX
                   PERFORM   RECE64-HENSYU-SEC
               END-IF
           END-IF
           .
       210-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの作成（Ｆ００４）
      *****************************************************************
       RECE64-HENSYU-SEC                SECTION.
      *
           MOVE    SPACE                TO      RECE64-REC
           INITIALIZE                           RECE64-REC
           MOVE    RECE62-HOSPID        TO      RECE64-HOSPID
           MOVE    RECE62-SRYYM         TO      RECE64-SRYYM
           MOVE    RECE62-NYUGAIKBN     TO      RECE64-NYUGAIKBN
           MOVE    RECE62-PTID          TO      RECE64-PTID
           MOVE    RECE62-RECEKA        TO      RECE64-RECEKA
           MOVE    RECE62-TEISYUTUSAKI  TO      RECE64-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU   TO      RECE64-RECESYUBETU
           MOVE    RECE62-HKNJANUM-KEY  TO      RECE64-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY   TO      RECE64-HOJOKBN
           MOVE    RECE62-TEKSTYMD      TO      RECE64-TEKSTYMD
           START   RECE64-FILE   KEY  IS  >=    RECE64-KEY
                   INVALID
                       MOVE   1         TO      FLG-RECE64
                   NOT  INVALID
                       MOVE   ZERO      TO      FLG-RECE64
                       PERFORM   RECE64-NEXT-SEC
           END-START
           PERFORM   UNTIL
                    (RECE62-HOSPID    NOT = RECE64-HOSPID)    OR
                    (RECE62-NYUGAIKBN NOT = RECE64-NYUGAIKBN) OR
                    (RECE62-PTID      NOT = RECE64-PTID)      OR
                    (RECE62-RECEKA    NOT = RECE64-RECEKA)    OR
                    (RECE62-TEISYUTUSAKI NOT = RECE64-TEISYUTUSAKI) OR
                    (RECE62-RECESYUBETU  NOT = RECE64-RECESYUBETU)  OR
                    (RECE62-HKNJANUM-KEY NOT = RECE64-HKNJANUM)  OR
                    (RECE62-HOJOKBN-KEY  NOT = RECE64-HOJOKBN)  OR
                    (RECE62-TEKSTYMD  NOT = RECE64-TEKSTYMD)  OR
                    (FLG-RECE64       =    1)
                     MOVE   RECE64-ZAINUM    TO   WK-ZAINUM
                     MOVE   RECE64-ZAIREN    TO   WK-ZAIREN
                     PERFORM      KOHBUNRI-SET-SEC
                     PERFORM      RECE64-REWRITE-SEC
                     PERFORM      RECE65-HENSYU-SEC
                     PERFORM      RECE64-NEXT-SEC
           END-PERFORM
      *
           .
       RECE64-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費分離区分の算出
      *****************************************************************
       KOHBUNRI-SET-SEC               SECTION.
      *
           MOVE    ZERO                TO  HC-IDX
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       10
                   OR      RECE62-HKNCOMBI (IDX)   =   ZERO 
               IF      RECE64-HKNCOMBI     =   RECE62-HKNCOMBI (IDX)
                     MOVE     IDX              TO  HC-IDX
                     MOVE    10                TO  IDX
               END-IF
           END-PERFORM          
      *
           MOVE       ZERO              TO   KH-IDX
           IF  (RECE62-KOHNUMHC(HC-IDX 1) =  RECE62-KOHNUM(BUN-IDX)) OR
               (RECE62-KOHNUMHC(HC-IDX 2) =  RECE62-KOHNUM(BUN-IDX)) OR
               (RECE62-KOHNUMHC(HC-IDX 3) =  RECE62-KOHNUM(BUN-IDX)) OR
               (RECE62-KOHNUMHC(HC-IDX 4) =  RECE62-KOHNUM(BUN-IDX))
                MOVE    BUN-IDX     TO        KH-IDX
           END-IF
      *
           IF    RECE64-KOHBUNRI     =      ZERO
               MOVE    KH-IDX          TO        RECE64-KOHBUNRI
           END-IF
           .
       KOHBUNRI-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの作成（Ｆ００５）
      *****************************************************************
       RECE65-HENSYU-SEC               SECTION.
      *
           MOVE    SPACE                TO      RECE65-REC
           INITIALIZE                           RECE65-REC
           MOVE    RECE62-HOSPID        TO      RECE65-HOSPID
           MOVE    RECE62-SRYYM         TO      RECE65-SRYYM
           MOVE    RECE62-NYUGAIKBN     TO      RECE65-NYUGAIKBN
           MOVE    RECE62-PTID          TO      RECE65-PTID
           MOVE    RECE62-RECEKA        TO      RECE65-RECEKA
           MOVE    RECE62-TEISYUTUSAKI  TO      RECE65-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU   TO      RECE65-RECESYUBETU
           MOVE    RECE62-HKNJANUM-KEY  TO      RECE65-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY   TO      RECE65-HOJOKBN
           MOVE    RECE62-TEKSTYMD      TO      RECE65-TEKSTYMD
           MOVE    WK-ZAINUM            TO      RECE65-ZAINUM
           MOVE    WK-ZAIREN            TO      RECE65-ZAIREN
           START   RECE65-FILE   KEY  IS  >=    RECE65-KEY
                   INVALID
                       MOVE    1        TO      FLG-RECE65
                   NOT  INVALID
                       MOVE    ZERO     TO      FLG-RECE65
                       PERFORM   RECE65-NEXT-SEC
           END-START
           PERFORM   UNTIL
                  (RECE62-HOSPID        NOT =  RECE65-HOSPID)    OR
                  (RECE62-NYUGAIKBN     NOT =  RECE65-NYUGAIKBN) OR
                  (RECE62-PTID          NOT =  RECE65-PTID)      OR
                  (RECE62-RECEKA        NOT =  RECE65-RECEKA)    OR
                  (RECE62-TEISYUTUSAKI  NOT =  RECE65-TEISYUTUSAKI) OR
                  (RECE62-RECESYUBETU   NOT =  RECE65-RECESYUBETU)  OR
                  (RECE62-HKNJANUM-KEY  NOT =  RECE65-HKNJANUM)  OR
                  (RECE62-HOJOKBN-KEY   NOT =  RECE65-HOJOKBN )  OR
                  (RECE62-TEKSTYMD      NOT =  RECE65-TEKSTYMD)  OR
                  (WK-ZAINUM            NOT =  RECE65-ZAINUM)    OR
                  (WK-ZAIREN            NOT =  RECE65-ZAIREN)    OR
                  (FLG-RECE65           =      1)
                   MOVE   KH-IDX        TO     RECE65-KOHBUNRI
                   PERFORM      RECE65-REWRITE-SEC
                   PERFORM      RECE65-NEXT-SEC
           END-PERFORM
      *
           .
       RECE65-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    データ出力処理（Ｆ００４）
      *****************************************************************
       RECE64-REWRITE-SEC                SECTION.
      *
           REWRITE   RECE64-REC
      *
           ADD     1                   TO  CNT-OUT1
      *
           .
       RECE64-REWRITE-EXT.
           EXIT.
      *
      *****************************************************************
      *    データ出力処理（Ｆ００５）
      *****************************************************************
       RECE65-REWRITE-SEC                SECTION.
      *
           REWRITE   RECE65-REC
      *
           ADD     1                   TO  CNT-OUT2
      *
           .
       RECE65-REWRITE-EXT.
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
           CLOSE   RECE62-FILE
                   RECE64-FILE
                   RECE65-FILE
      *
           DISPLAY "RECE62-IN  :" CNT-IN   
           DISPLAY "RECE64-MOD :" CNT-OUT1  
           DISPLAY "RECE65-MOD :" CNT-OUT2 
           DISPLAY "*** ORCR0650 END ***"
      *
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    中間ファイルＲＥＡＤ処理（Ｆ００２）
      *****************************************************************
       RECE62-READ-SEC            SECTION.
      *
           READ    RECE62-FILE   NEXT
               AT  END
                   MOVE    1     TO    FLG-END
               NOT  AT  END
                   ADD     1     TO    CNT-IN
      *
                   DISPLAY "RECE62  PTNUM=" RECE62-PTNUM
      *
           END-READ
           .
       RECE62-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    中間ファイルＲＥＡＤ処理（Ｆ００４）
      *****************************************************************
       RECE64-NEXT-SEC            SECTION.
      *
           MOVE    ZERO          TO    FLG-RECE64
           READ    RECE64-FILE   NEXT
               AT  END
                   MOVE    1     TO    FLG-RECE64
           END-READ
           .
       RECE64-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    中間ファイルＲＥＡＤ処理（Ｆ００５）
      *****************************************************************
       RECE65-NEXT-SEC            SECTION.
      *
           MOVE    ZERO          TO    FLG-RECE65
           READ    RECE65-FILE   NEXT
               AT  END
                   MOVE    1     TO    FLG-RECE65
           END-READ
           .
       RECE65-READ-EXT.
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
