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
       PROGRAM-ID.                     ORCDTCHK001.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : データチェック
      *  コンポーネント名  : 対象患者抽出
      *  管理者            :
      *  作成日付    作業者        記述
      *  03/11/21    NACL−太田    新規作成
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
      *    データチェック中間ファイル（診療会計対象患者）
           SELECT  DTCHK001-FILE   ASSIGN  DTCHK001PARA
                                   FILE    STATUS  IS  STS-DTCHK001
                                   ORGANIZATION    IS  LINE SEQUENTIAL.
      *
      *    データチェック中間ファイル（入院診療会計対象患者）
           SELECT  DTCHK002-FILE   ASSIGN  DTCHK002PARA
                                   FILE    STATUS  IS  STS-DTCHK002
                                   ORGANIZATION    IS  LINE SEQUENTIAL.
      *
      *    データチェック中間ファイル（対象患者情報）
           SELECT  DTCHK003-FILE   ASSIGN  DTCHK003PARA
                                   FILE    STATUS  IS  STS-DTCHK003
                                   ORGANIZATION    IS  LINE SEQUENTIAL.
      *
      *    エラーファイル
           SELECT  DTCHKERR-FILE   ASSIGN  DTCHKERRPARA
                                   FILE    STATUS  IS  STS-DTCHKERR.
      *
       DATA                            DIVISION.
       FILE                            SECTION.
      *
      *    データチェック中間ファイル（診療会計対象患者）
       FD  DTCHK001-FILE.
           COPY    "CPDTCHK001.INC".
      *
      *    データチェック中間ファイル（入院診療会計対象患者）
       FD  DTCHK002-FILE.
           COPY    "CPDTCHK001.INC"
                                   REPLACING  //DTCHK001//
                                   BY         //DTCHK002//.
      *
      *    データチェック中間ファイル（患者情報）
       FD  DTCHK003-FILE.
           COPY    "CPDTCHK001.INC"
                                   REPLACING  //DTCHK001//
                                   BY         //DTCHK003//.
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
                                   BY         //DTCHK001//.
           COPY    "CPCOMMONDAT6.INC"
                                   REPLACING  //DTCHK//
                                   BY         //DTCHK002//.
           COPY    "CPCOMMONDAT6.INC"
                                   REPLACING  //DTCHK//
                                   BY         //DTCHK003//.
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-DTCHK001                            PIC X(02).
           03  STS-DTCHK002                            PIC X(02).
           03  STS-DTCHK003                            PIC X(02).
           03  STS-DTCHKERR                            PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-ERR                                 PIC 9(01).
           03  FLG-SRYACCT                             PIC 9(01).
           03  FLG-NYUINACCT                           PIC 9(01).
           03  FLG-PTINF                               PIC 9(01).
           03  FLG-DTCHK001                            PIC 9(01).
           03  FLG-DTCHK002                            PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-DTCHK001                            PIC 9(06).
           03  CNT-DTCHK002                            PIC 9(06).
           03  CNT-DTCHK003                            PIC 9(06).
      *
       01  IDX-AREA.
           03  IDX0                                    PIC 9(05). 
           03  IDX1                                    PIC 9(05). 
           03  IDX2                                    PIC 9(05). 
           03  IDX3                                    PIC 9(05). 
      *
       01  WRK-AREA.
           03  WRK-DTCHKERR                            PIC X(200).
      *
       01  KEY-AREA.
           03  KEY-HOSPID                              PIC X(24).
           03  KEY-PTID                                PIC 9(10).
      *
           03  KEY-ACCT.
               05  KEY-ACCT-HOSPID                     PIC X(24).
               05  KEY-ACCT-PTID                       PIC 9(10).
      *
           03  KEY-NACCT.
               05  KEY-NACCT-HOSPID                    PIC X(24).
               05  KEY-NACCT-PTID                      PIC 9(10).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID      PIC 9(07).
           03  WRK-PARA-SHELLID    PIC X(08).
           03  WRK-PARA-HOSPID     PIC X(24).
      *
      *    データチェック一括処理パラメータ
           COPY    "CPORCBSD01PARA.INC".
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
      *    診療会計マスタ−
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    入院診療会計マスター
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      ****************************************************************
       LINKAGE                         SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(2000).
      ****************************************************************
       PROCEDURE                       DIVISION
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
           PERFORM 300-END-SEC
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
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
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCDTCHK001"          TO  JOB-PGID
           MOVE    "対象患者抽出"      TO  JOB-SHELLMSG
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           MOVE    ZERO                TO  FLG-END
                                           FLG-ERR
      *
      *
      *    データチェック中間ファイル名
           MOVE    "DTCHK001"          TO  DTCHK001-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  DTCHK001-TERMID
      *
           MOVE    "DTCHK002"          TO  DTCHK002-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  DTCHK002-TERMID
      *
           MOVE    "DTCHK003"          TO  DTCHK003-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  DTCHK003-TERMID
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
      *
           .
       1001-INIT-VAL-SET-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
      *    会計テーブルより対象患者を抽出
           PERFORM 2001-ACCT-HEN-SEC
      *
      *    対象患者情報編集処理
           PERFORM 2001-DTCHK003-HEN-SEC
      *
           MOVE    1                   TO  FLG-END
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    会計テーブルより対象患者を抽出処理
      *****************************************************************
       2001-ACCT-HEN-SEC               SECTION.
      *
           OPEN    OUTPUT              DTCHK001-FILE
                                       DTCHK002-FILE
      *
      *    診療会計対象患者抽出
           PERFORM 20011-SRYACCT-CHK-SEC
      *
           IF    ( ORCBSD01-NYUGAIKBN  =   "1" )
      *
      *        入院診療会計対象患者抽出
               PERFORM 20011-NYUINACCT-CHK-SEC
           END-IF
      *
           CLOSE                       DTCHK001-FILE
                                       DTCHK002-FILE
      *
           .
       2001-ACCT-HEN-EXT.
           EXIT.
      *****************************************************************
      *    診療会計対象患者抽出
      *****************************************************************
       20011-SRYACCT-CHK-SEC               SECTION.
      *
           MOVE    ZERO                TO  CNT-DTCHK001
      *
           INITIALIZE                      KEY-HOSPID
                                           KEY-PTID
      *
      *    診療会計検索
           MOVE    ZERO                TO  FLG-SRYACCT
           INITIALIZE                      SRYACCT-REC
           MOVE    WRK-PARA-HOSPID     TO  ACCT-HOSPID
           MOVE    ORCBSD01-NYUGAIKBN  TO  ACCT-NYUGAIKBN
           MOVE    ORCBSD01-SRYYM      TO  ACCT-SRYYM
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "SRYACCT-KEY27"     TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-SRYACCT
           ELSE
               MOVE    MCPDATA-REC     TO  SRYACCT-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-SRYACCT NOT =   ZERO )
      *
               IF    ( KEY-HOSPID      NOT =   ACCT-HOSPID )
                OR   ( KEY-PTID        NOT =   ACCT-PTID   )
      *
                   MOVE    ACCT-HOSPID     TO  KEY-HOSPID
                   MOVE    ACCT-PTID       TO  KEY-PTID
      *
      *            患者情報取得処理
                   PERFORM 200111-PTINF-GET-SEC
      *
      *            テスト患者のデータは対象外とする
                   IF    ( PTINF-TSTPTNUMKBN   NOT =   "1" )
      *
                       INITIALIZE          DTCHK001-REC
                       MOVE    ACCT-HOSPID TO  DTCHK001-HOSPID
                       MOVE    ACCT-PTID   TO  DTCHK001-PTID
                       WRITE               DTCHK001-REC
      *
                       COMPUTE CNT-DTCHK001    =   CNT-DTCHK001    +   1
      *
                   END-IF
      *
               END-IF
      *
               MOVE    "SRYACCT-KEY27" TO  ORC-DBPATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC          NOT =   ZERO )
                   MOVE    1           TO  FLG-SRYACCT
               ELSE
                   MOVE    MCPDATA-REC TO  SRYACCT-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    "SRYACCT-KEY27"     TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       20011-SRYACCT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院診療会計対象患者抽出
      *****************************************************************
       20011-NYUINACCT-CHK-SEC         SECTION.
      *
           MOVE    ZERO                TO  CNT-DTCHK002
      *
           INITIALIZE                      KEY-HOSPID
                                           KEY-PTID
      *
      *    入院診療会計検索
           MOVE    ZERO                TO  FLG-NYUINACCT
           INITIALIZE                      NYUINACCT-REC
           MOVE    WRK-PARA-HOSPID     TO  NACCT-HOSPID
           MOVE    ORCBSD01-NYUGAIKBN  TO  NACCT-NYUGAIKBN
           MOVE    ORCBSD01-SRYYM      TO  NACCT-SRYYM
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "NYUINACCT-KEY20"   TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-NYUINACCT
           ELSE
               MOVE    MCPDATA-REC     TO  NYUINACCT-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-NYUINACCT   NOT =   ZERO )
      *
               IF    ( KEY-HOSPID          NOT =   NACCT-HOSPID )
                OR   ( KEY-PTID            NOT =   NACCT-PTID   )
      *
                   MOVE    NACCT-HOSPID    TO  KEY-HOSPID
                   MOVE    NACCT-PTID      TO  KEY-PTID
      *
      *            患者情報取得処理
                   PERFORM 200111-PTINF-GET-SEC
      *
      *            テスト患者のデータは対象外とする
                   IF    ( PTINF-TSTPTNUMKBN   NOT =   "1" )
      *
                       INITIALIZE          DTCHK002-REC
                       MOVE    NACCT-HOSPID    TO  DTCHK002-HOSPID
                       MOVE    NACCT-PTID      TO  DTCHK002-PTID
                       WRITE               DTCHK002-REC
      *
                       COMPUTE CNT-DTCHK002    =   CNT-DTCHK002    +   1
      *
                   END-IF
      *
               END-IF
      *
               MOVE    "NYUINACCT-KEY20"   TO  ORC-DBPATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC          NOT =   ZERO )
                   MOVE    1           TO  FLG-NYUINACCT
               ELSE
                   MOVE    MCPDATA-REC TO  NYUINACCT-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    "NYUINACCT-KEY20"   TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       20011-NYUINACCT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    患者情報取得処理
      *****************************************************************
       200111-PTINF-GET-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-PTINF
      *
           INITIALIZE                      PTINF-REC
           MOVE    KEY-HOSPID          TO  PTINF-HOSPID
           MOVE    KEY-PTID            TO  PTINF-PTID
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
           ELSE
               MOVE    MCPDATA-REC     TO  PTINF-REC
           END-IF
      *
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       200111-PTINF-GET-EXT.
           EXIT.
      *****************************************************************
      *    対象患者編集処理
      *****************************************************************
       2001-DTCHK003-HEN-SEC           SECTION.
      *
           OPEN    INPUT                   DTCHK001-FILE
                                           DTCHK002-FILE
      *
           OPEN    OUTPUT                  DTCHK003-FILE
      *
           MOVE    ZERO                TO  FLG-DTCHK001
                                           FLG-DTCHK002
      *
           MOVE    ZERO                TO  CNT-DTCHK003
      *
           MOVE    LOW-VALUE           TO  KEY-ACCT
                                           KEY-NACCT
      *
           PERFORM 900-DTCHK001-READ-SEC
      *
           PERFORM 900-DTCHK002-READ-SEC
      *
           PERFORM UNTIL ( FLG-DTCHK001    NOT =   ZERO )
                    AND  ( FLG-DTCHK002    NOT =   ZERO )
      *
               EVALUATE    TRUE
               WHEN    (   KEY-ACCT    =   KEY-NACCT )
      *
                   PERFORM 20011-DTCHK003-OT-SEC
      *
                   PERFORM 900-DTCHK001-READ-SEC
                   PERFORM 900-DTCHK002-READ-SEC
               WHEN    (   KEY-ACCT    <   KEY-NACCT )
      *
                   PERFORM 20011-DTCHK003-OT-SEC
      *
                   PERFORM 900-DTCHK001-READ-SEC
               WHEN    (   KEY-ACCT    >   KEY-NACCT )
      *
                   PERFORM 20012-DTCHK003-OT-SEC
      *
                   PERFORM 900-DTCHK002-READ-SEC
               END-EVALUATE
           END-PERFORM
      *
           CLOSE                           DTCHK001-FILE
                                           DTCHK002-FILE
                                           DTCHK003-FILE
      *
           .
       2001-DTCHK003-HEN-EXT.
           EXIT.
      *****************************************************************
      *    対象患者情報ファイル出力処理（診療会計情報より編集）
      *****************************************************************
       20011-DTCHK003-OT-SEC           SECTION.
      *
           INITIALIZE                      DTCHK003-REC
           MOVE    DTCHK001-HOSPID     TO  DTCHK003-HOSPID
           MOVE    DTCHK001-PTID       TO  DTCHK003-PTID
           WRITE                           DTCHK003-REC
      *
           COMPUTE CNT-DTCHK003    =   CNT-DTCHK003    +   1
      *
           .
       20011-DTCHK003-OT-EXT.
           EXIT.
      *****************************************************************
      *    対象患者情報ファイル出力処理（入院診療会計情報より編集）
      *****************************************************************
       20012-DTCHK003-OT-SEC           SECTION.
      *
           INITIALIZE                      DTCHK003-REC
           MOVE    DTCHK002-HOSPID     TO  DTCHK003-HOSPID
           MOVE    DTCHK002-PTID       TO  DTCHK003-PTID
           WRITE                           DTCHK003-REC
      *
           COMPUTE CNT-DTCHK003    =   CNT-DTCHK003    +   1
      *
           .
       20012-DTCHK003-OT-EXT.
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
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *     
           DISPLAY "*** ORCDTCHK001 END ***"
           DISPLAY "DTCHK001 CNT [" CNT-DTCHK001 "]"
           DISPLAY "DTCHK002 CNT [" CNT-DTCHK002 "]"
           DISPLAY "DTCHK003 CNT [" CNT-DTCHK003 "]"
           DISPLAY "***********************"
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計対象患者ファイル読込処理
      *****************************************************************
       900-DTCHK001-READ-SEC           SECTION.
      *
           READ    DTCHK001-FILE
           AT  END
               MOVE    1               TO  FLG-DTCHK001
           END-READ
      *
           IF    ( FLG-DTCHK001        =   ZERO )
               MOVE    DTCHK001-HOSPID TO  KEY-ACCT-HOSPID
               MOVE    DTCHK001-PTID   TO  KEY-ACCT-PTID
           ELSE
               MOVE    HIGH-VALUE      TO  KEY-ACCT
           END-IF
      *
           .
       900-DTCHK001-READ-EXT.
           EXIT.
      *****************************************************************
      *    入院診療会計対象患者ファイル読込処理
      *****************************************************************
       900-DTCHK002-READ-SEC           SECTION.
      *
           READ    DTCHK002-FILE
           AT  END
               MOVE    1               TO  FLG-DTCHK002
           END-READ
      *
           IF    ( FLG-DTCHK002        =   ZERO )
               MOVE    DTCHK002-HOSPID TO  KEY-NACCT-HOSPID
               MOVE    DTCHK002-PTID   TO  KEY-NACCT-PTID
           ELSE
               MOVE    HIGH-VALUE      TO  KEY-NACCT
           END-IF
      *
           .
       900-DTCHK002-READ-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DB-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
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
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBCLOSE-EXT.
           EXIT.
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
