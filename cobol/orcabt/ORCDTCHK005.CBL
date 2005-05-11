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
       IDENTIFICATION                  DIVISION.
       PROGRAM-ID.                     ORCDTCHK005.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : データチェック
      *  コンポーネント名  : 診療行為情報抽出
      *  管理者            :
      *  作成日付    作業者        記述
      *  05/03/31    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                     DIVISION.
       CONFIGURATION                   SECTION.
       INPUT-OUTPUT                    SECTION.
       FILE-CONTROL.
      *
      *
      *    データチェック中間ファイル（診療行為:入院）
           SELECT  DTCHK006N-FILE
                                   ASSIGN  DTCHK006NPARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  DTCHK006N-KEY
                                   FILE    STATUS  IS  STS-DTCHK006.
      *
      *    データチェック中間ファイル（診療行為:外来）
           SELECT  DTCHK006G-FILE
                                   ASSIGN  DTCHK006GPARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  DTCHK006G-KEY
                                   FILE    STATUS  IS  STS-DTCHK006.
      *
      *    データチェック診療行為
           SELECT  DCSRY-FILE
                                   ASSIGN  DTCHKSRYPARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  DCSRY-KEY
                                   FILE    STATUS  IS  STS-DCSRY.
      *    エラーファイル
           SELECT  DTCHKERR-FILE   ASSIGN  DTCHKERRPARA
                                   FILE    STATUS  IS  STS-DTCHKERR.
      *
       DATA                            DIVISION.
       FILE                            SECTION.
      *
      *
      *    データチェック中間ファイル（診療行為:入院）
       FD  DTCHK006N-FILE.
           COPY    "CPDTCHK006.INC"
                                   REPLACING  //DTCHK006//
                                   BY         //DTCHK006N//.
      *
      *    データチェック中間ファイル（診療行為:外来）
       FD  DTCHK006G-FILE.
           COPY    "CPDTCHK006.INC"
                                   REPLACING  //DTCHK006//
                                   BY         //DTCHK006G//.
      *
      *    データチェック診療行為
       FD  DCSRY-FILE.
       01  DCSRY-REC.
           COPY    "CPDCSRY.INC".
      *
      *    エラーファイル
       FD  DTCHKERR-FILE.
       01  DTCHKERR-REC                PIC X(200). 
      *
       WORKING-STORAGE                 SECTION.
      *
      *    エラーファイルファイル名称領域 
           COPY    "CPCOMMONDAT6.INC"
                                   REPLACING  //DTCHK//
                                   BY         //DTCHKERR//.
      *
      *    中間ファイルファイル名称領域 
           COPY    "CPCOMMONDAT6.INC"
                                   REPLACING  //DTCHK//
                                   BY         //DTCHK006N//.
           COPY    "CPCOMMONDAT6.INC"
                                   REPLACING  //DTCHK//
                                   BY         //DTCHK006G//.
           COPY    "CPCOMMONDAT6.INC"
                                   REPLACING  //DTCHK//
                                   BY         //DTCHKSRY//.
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-DTCHK006                            PIC X(02).
           03  STS-DTCHKERR                            PIC X(02).
           03  STS-DCSRY                               PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-ERR                                 PIC 9(01).
           03  FLG-SRYACT                              PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-DCSRY                               PIC 9(08). 
      *
       01  IDX-AREA.
           03  IDX0                                    PIC 9(05). 
           03  IDX1                                    PIC 9(05). 
           03  IDX2                                    PIC 9(05). 
      *
       01  WRK-AREA.
           03  WRK-SYMD                                PIC X(08).
           03  WRK-SRYYMD.
               05  WRK-SRYYM                           PIC X(06).
               05  WRK-SRYDAY                          PIC 9(02).
           03  WRK-DTCHKERR                            PIC X(200).
           03  WRK-JOB-YOBI                            PIC X(500).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID                          PIC 9(07).
           03  WRK-PARA-SHELLID                        PIC X(08).
           03  WRK-PARA-HOSPID                         PIC X(24).
      *
      *    データチェック一括処理パラメータ
           COPY    "CPORCBSD01PARA.INC".
      *
           COPY    "CPDTCHK006.INC".
      *
      *    固定値領域
       01  CONST-AREA.
           03  CONST-SRYCD-MAX                         PIC 9(05)
                                                       VALUE   5.
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    診療行為
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "MCPAREA".
           COPY    "ORCA-DBPATH".
      *
      ****************************************************************
       LINKAGE                         SECTION.
       01  DTCHK-RC        PIC S9(09).
       01  COMMAND-PARAM.
           02  FILLER      PIC X(2000).
      ****************************************************************
       PROCEDURE                       DIVISION
               USING
           DTCHK-RC
           COMMAND-PARAM.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           DISPLAY "*** ORCDTCHK005 START ***"
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           MOVE    FLG-ERR         TO  DTCHK-RC
      *
           EXIT    PROGRAM
      *
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           INITIALIZE                  STS-AREA
                                       IDX-AREA
                                       CNT-AREA
                                       FLG-AREA
                                       WRK-AREA
                                       WRK-PARA
                                       ORCBSD01PARA
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
                                               DTCHKERRPARA
                                               ORCBSD01-SRYYM
                                               ORCBSD01-NYUGAIKBN
                                               ORCBSD01-CHKKBN-G
                                               ORCBSD01-JIHIPROCKBN
                                               ORCBSD01-INGAIPROCKBN
      *
           PERFORM 900-DBSTART-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCDTCHK005"       TO  JOB-PGID
           MOVE    "診療行為情報抽出"
                                       TO  JOB-SHELLMSG
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           MOVE    ZERO                TO  FLG-END
                                           FLG-ERR
      *
      *    データチェック中間ファイル名
           MOVE    "DTCHK06N"          TO  DTCHK006N-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  DTCHK006N-TERMID
      *
           MOVE    "DTCHK06G"          TO  DTCHK006G-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  DTCHK006G-TERMID
      *
           MOVE    "DCSRY000"          TO  DTCHKSRY-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  DTCHKSRY-TERMID
      *
      *    初期値設定処理
           PERFORM 1001-INIT-VAL-SET-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期値設定処理
      *****************************************************************
       1001-INIT-VAL-SET-SEC           SECTION.
      *
           MOVE    ORCBSD01-SRYYM      TO  WRK-SYMD
           MOVE    "01"                TO  WRK-SYMD(7:2)
      *
           .
       1001-INIT-VAL-SET-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           MOVE    ZERO            TO  FLG-SRYACT
      *
      *    診療行為編集処理
           PERFORM 2001-SRYACT-EDIT-SEC
      *
      *    データチェック診療行為追加処理
           PERFORM 2001-DCSRY-INS-SEC
      *
           MOVE    1               TO  FLG-END
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    診療行為編集処理
      *****************************************************************
       2001-SRYACT-EDIT-SEC            SECTION.
      *
           OPEN    OUTPUT  DTCHK006N-FILE
           OPEN    OUTPUT  DTCHK006G-FILE
      *
           PERFORM 900-SRYACT-ALL2-SEL-SEC
      *
           PERFORM UNTIL ( FLG-SRYACT  NOT =   ZERO )
      *
               INITIALIZE                  DTCHK006-REC
               MOVE    SRY-PTID        TO  DTCHK006-PTID
               MOVE    SRY-ZAINUM      TO  DTCHK006-ZAINUM
               MOVE    SRY-SRYSYUKBN   TO  DTCHK006-SRYSYUKBN
      *
               PERFORM VARYING IDX0    FROM    1   BY  1
                       UNTIL ( IDX0    >   CONST-SRYCD-MAX )
                        OR   ( SRY-SRYCD (IDX0)    =   SPACE )
      *
                   COMPUTE DTCHK006-SRYRENNUM
                       = ( SRY-RENNUM  -   1 ) *   CONST-SRYCD-MAX
                       +   IDX0
      *
                   MOVE    SRY-SRYCD (IDX0)
                                       TO  DTCHK006-SRYCD
      *
                   IF    ( SRY-NYUGAIKBN   =   "1" )
      *
                       MOVE    DTCHK006-REC    TO  DTCHK006N-REC
                       WRITE   DTCHK006N-REC
      *
                   ELSE
      *
                       MOVE    DTCHK006-REC    TO  DTCHK006G-REC
                       WRITE   DTCHK006G-REC
      *
                   END-IF
      *
               END-PERFORM
      *
               PERFORM 900-SRYACT-ALL2-FET-SEC
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-SRYACT-ALL2    TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           CLOSE   DTCHK006N-FILE
           CLOSE   DTCHK006G-FILE
      *
           .
       2001-SRYACT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    データチェック診療行為テーブル追加処理
      *****************************************************************
       2001-DCSRY-INS-SEC              SECTION.
      *
           OPEN    INPUT               DTCHK006N-FILE
           OPEN    INPUT               DTCHK006G-FILE
      *
           OPEN    OUTPUT              DCSRY-FILE
      *
           PERFORM 900-DTCHK006N-READ-SEC
           PERFORM 900-DTCHK006G-READ-SEC
      *
           PERFORM UNTIL ( DTCHK006N-KEY   =   HIGH-VALUE )
                    AND  ( DTCHK006G-KEY   =   HIGH-VALUE )
      *
               EVALUATE    TRUE
               WHEN  ( DTCHK006N-PTID-X    >   DTCHK006G-PTID-X  )
                   IF    ( ORCBSD01-NYUGAIKBN  =   "1" )
                       PERFORM 900-DTCHK006G-READ-SEC
                   ELSE
                       MOVE    DTCHK006G-REC   TO  DTCHK006-REC
                       PERFORM 20011-DCSRY-INS-SEC
                       PERFORM 900-DTCHK006G-READ-SEC
                   END-IF
               WHEN  ( DTCHK006N-PTID-X    <   DTCHK006G-PTID-X  )
                   IF    ( ORCBSD01-NYUGAIKBN  =   "1" )
                       MOVE    DTCHK006N-REC   TO  DTCHK006-REC
                       PERFORM 20011-DCSRY-INS-SEC
                       PERFORM 900-DTCHK006N-READ-SEC
                   ELSE
                       PERFORM 900-DTCHK006N-READ-SEC
                   END-IF
               WHEN  ( DTCHK006N-PTID-X    =   DTCHK006G-PTID-X  )
      *
                   IF    ( ORCBSD01-NYUGAIKBN  =   "1" )
                       MOVE    DTCHK006G-REC   TO  DTCHK006-REC
                       PERFORM 20011-DCSRY-INS-SEC
                       PERFORM 900-DTCHK006G-READ-SEC
                   ELSE
                       MOVE    DTCHK006N-REC   TO  DTCHK006-REC
                       PERFORM 20011-DCSRY-INS-SEC
                       PERFORM 900-DTCHK006N-READ-SEC
                   END-IF
               END-EVALUATE
      *
           END-PERFORM
      *
      *
           CLOSE   DTCHK006N-FILE
           CLOSE   DTCHK006G-FILE
      *
           CLOSE   DCSRY-FILE
      *
           .
       2001-DCSRY-INS-EXT.
           EXIT.
      *****************************************************************
      *    データチェック診療行為テーブル追加処理
      *****************************************************************
       20011-DCSRY-INS-SEC              SECTION.
      *
           INITIALIZE              DCSRY-REC
      *
           MOVE    DTCHK006-PTID   TO  DCSRY-PTID
           MOVE    DTCHK006-ZAINUM TO  DCSRY-ZAINUM
           MOVE    "1"             TO  DCSRY-ACCTKBN
           MOVE    DTCHK006-SRYRENNUM
                                       TO  DCSRY-SRYRENNUM
           MOVE    DTCHK006-SRYSYUKBN
                                       TO  DCSRY-SRYSYUKBN
           MOVE    DTCHK006-SRYCD  TO  DCSRY-SRYCD
      *
           PERFORM 800-MCNDATE-SEC
           MOVE    SMCNDATE-YMD    TO  DCSRY-CREYMD
                                       DCSRY-UPYMD
           MOVE    SMCNDATE-HMS    TO  DCSRY-UPHMS
      *
           WRITE   DCSRY-REC
      *
           .
       20011-DCSRY-INS-EXT.
           EXIT.
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC              SECTION.
      *
           OPEN    INPUT   DTCHKERR-FILE
           IF    ( STS-DTCHKERR        =   ZERO )
               CLOSE   DTCHKERR-FILE
           ELSE
               OPEN    OUTPUT              DTCHKERR-FILE
      *
               MOVE    WRK-DTCHKERR    TO  DTCHKERR-REC
               WRITE   DTCHKERR-REC
               CLOSE   DTCHKERR-FILE
      *
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-DTCHKERR    TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
           END-IF
      *
           MOVE    1                   TO  FLG-END
           MOVE    1                   TO  FLG-ERR
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    ZERO            TO  JOB-UPDCNT
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA
                                   JOBKANRI-REC
      *
           PERFORM 900-DBCOMMIT-SEC
      *     
           DISPLAY "*** ORCDTCHK005 END ***"
           .
       300-END-EXT.
           EXIT.
      *****************************************************************
      *    ジョブ管理途中経過表示処理
      *****************************************************************
       800-ORCSJOB-STM-SEC             SECTION.
      *
           MOVE    "STM"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-JOB-YOBI        TO  JOB-YOBI
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCDTCHK004"       TO  JOB-PGID
           MOVE    "診療行為情報抽出"  TO  JOB-SHELLMSG
      *
           CALL    "ORCSJOB"               USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
           .
       800-ORCSJOB-STM-EXT.
           EXIT.
      *****************************************************************
      *    マシン日付取得サブ
      *****************************************************************
       800-MCNDATE-SEC         SECTION.
      *
           CALL    "ORCSMCNDATE"   USING   ORCSMCNDATEAREA
      *
           .
      *
       800-MCNDATE-EXT.
           EXIT.
      *****************************************************************
      *    データチェック中間ファイル（診療行為：入院）読込処理
      *****************************************************************
       900-DTCHK006N-READ-SEC          SECTION.
      *
           READ    DTCHK006N-FILE      NEXT
           AT  END
               MOVE    HIGH-VALUE  TO  DTCHK006N-KEY
           END-READ
      *
           .
       900-DTCHK006N-READ-EXT.
           EXIT.
      *****************************************************************
      *    データチェック中間ファイル（診療行為：外来）読込処理
      *****************************************************************
       900-DTCHK006G-READ-SEC          SECTION.
      *
           READ    DTCHK006G-FILE      NEXT
           AT  END
               MOVE    HIGH-VALUE  TO  DTCHK006G-KEY
           END-READ
      *
           .
       900-DTCHK006G-READ-EXT.
           EXIT.
      *****************************************************************
      *    診療行為検索処理(ALL2)
      *****************************************************************
       900-SRYACT-ALL2-SEL-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-SRYACT
           INITIALIZE                  SRYACT-REC
      *
           MOVE    ORCBSD01-SRYYM      TO  SRY-SRYYM
           MOVE    SRYACT-REC          TO  MCPDATA-REC
           MOVE    PATH-TBL-SRYACT-ALL2    TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  SRYACT-REC
           ELSE
               MOVE    1               TO  FLG-SRYACT
               INITIALIZE                  SRYACT-REC
           END-IF
      *
           .
       900-SRYACT-ALL2-SEL-EXT.
           EXIT.
      *****************************************************************
      *    診療行為FETCH処理(ALL2)
      *****************************************************************
       900-SRYACT-ALL2-FET-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-SRYACT
           INITIALIZE                  SRYACT-REC
      *
           MOVE    PATH-TBL-SRYACT-ALL2    TO  MCP-PATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  SRYACT-REC
           ELSE
               MOVE    1               TO  FLG-SRYACT
               INITIALIZE                  SRYACT-REC
           END-IF
      *
           .
       900-SRYACT-ALL2-FET-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHも行う)
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHは行わない)
      *****************************************************************
       911-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       911-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSE-SEC                 SECTION.
      *
      *    MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
      *    CALL    "MCPSUB"            USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
           .
      *
       910-DBCLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＤＥＬＥＴＥ処理
      *****************************************************************
       910-DBDELETE-SEC                 SECTION.
      *
           MOVE    "DBDELETE"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBDELETE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＩＮＳＥＲＴ処理
      *****************************************************************
       910-DBINSERT-SEC                SECTION.
      *
           MOVE    "DBINSERT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBINSERT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＳＴＡＲＴ処理
      *****************************************************************
       900-DBSTART-SEC                 SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBSTART"           TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       900-DBSTART-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＣＯＭＭＩＴ処理
      *****************************************************************
       900-DBCOMMIT-SEC                SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBCOMMIT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       900-DBCOMMIT-EXT.
           EXIT.
