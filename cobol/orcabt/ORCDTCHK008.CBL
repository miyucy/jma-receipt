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
       PROGRAM-ID.                     ORCDTCHK008.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : データチェック
      *  コンポーネント名  : チェックリスト前処理
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
      *    データチェック中間ファイル（チェック結果）
           SELECT  DTCHK004-FILE
                                   ASSIGN  DTCHK004PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  DTCHK004-KEY
                                   FILE    STATUS  IS  STS-DTCHK004.
      *
      *    データチェック中間ファイル（複数保険エラー患者）
           SELECT  DTCHK007-FILE
                                   ASSIGN  DTCHK007PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  DTCHK007-KEY
                                   FILE    STATUS  IS  STS-DTCHK007.
      *
      *    エラーファイル
           SELECT  DTCHKERR-FILE   ASSIGN  DTCHKERRPARA
                                   FILE    STATUS  IS  STS-DTCHKERR.
      *
       DATA                            DIVISION.
       FILE                            SECTION.
      *
      *    データチェック中間ファイル（チェック結果）
       FD  DTCHK004-FILE.
           COPY    "CPDTCHK004.INC".
      *
      *    データチェック中間ファイル（複数保険エラー患者）
       FD  DTCHK007-FILE.
           COPY    "CPDTCHK007.INC".
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
                                   BY         //DTCHK004//.
      *
      *    中間ファイルファイル名称領域 
           COPY    "CPCOMMONDAT6.INC"
                                   REPLACING  //DTCHK//
                                   BY         //DTCHK007//.
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-DTCHK004                            PIC X(02).
           03  STS-DTCHK007                            PIC X(02).
           03  STS-DTCHKERR                            PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-ERR                                 PIC 9(01).
           03  FLG-DTCHK004                            PIC 9(01).
           03  FLG-DTCHK007                            PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-DTCHK004                            PIC 9(06).
           03  CNT-DTCHK007                            PIC 9(06).
           03  CNT-HKN                                 PIC 9(06).
      *
       01  IDX-AREA.
           03  IDX0                                    PIC 9(05). 
      *
       01  WRK-AREA.
           03  WRK-DTCHKERR                            PIC X(200).
           03  WRK-HKNOTHERS                           PIC X(1).
      *
       01  KEY-AREA.
           03  KEY-NEW.
               05  KEY-N-PTID                          PIC 9(10).
               05  KEY-N-HKNKBN                        PIC X(1).
           03  KEY-OLD.
               05  KEY-O-PTID                          PIC 9(10).
               05  KEY-O-HKNKBN                        PIC X(1).
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
      *    固定値領域
      *01  CONST-AREA.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    データチェック機能情報２
           COPY    "CPSK1101.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "ORCA-DBPATH".
           COPY    "MCPAREA".
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
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC    UNTIL ( FLG-END =   1 )
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
                                       KEY-AREA
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
                                               ORCBSD01-SYAHOPROCKBN
                                               ORCBSD01-KOKUHOPROCKBN
                                               ORCBSD01-RSIPROCKBN
                                               ORCBSD01-JBIPROCKBN
                                               ORCBSD01-JIHIPROCKBN
                                               ORCBSD01-INGAIPROCKBN
                                               ORCBSD01-PRTSRTKBN
                                               ORCBSD01-PRTPTLSTKBN
      *
           PERFORM 900-DBSTART-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCDTCHK008"       TO  JOB-PGID
           MOVE    "リスト作成前処理"
                                       TO  JOB-SHELLMSG
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           MOVE    ZERO                TO  FLG-END
                                           FLG-ERR
      *
      *    データチェック中間ファイル名
           MOVE    "DTCHK004"          TO  DTCHK004-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  DTCHK004-TERMID
      *
      *    データチェック中間ファイル名
           MOVE    "DTCHK007"          TO  DTCHK007-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  DTCHK007-TERMID
      *
      *
      *    データチェック２機能情報
           PERFORM 1001-SYS1101-GET-SEC
      *
      *    初期値設定処理
           PERFORM 1001-INIT-VAL-SET-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    データチェック２機能情報
      *****************************************************************
       1001-SYS1101-GET-SEC            SECTION.
      *
           INITIALIZE                      SYS-1101-REC
           MOVE    "1101"              TO  SYS-1101-KANRICD
           MOVE    "*%"                TO  SYS-1101-KBNCD
           MOVE    ORCBSD01-SRYYM      TO  SYS-1101-STYUKYMD
           MOVE    "01"                TO  SYS-1101-STYUKYMD (7:2)
           MOVE    SYS-1101-STYUKYMD   TO  SYS-1101-EDYUKYMD
           MOVE    SYS-1101-REC        TO  MCPDATA-REC
           MOVE    PATH-TBL-SYSKANRI-KEY   TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-1101-REC
           ELSE
               INITIALIZE                  SYS-1101-REC
           END-IF
      *
           MOVE    PATH-TBL-SYSKANRI-KEY   TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       1001-SYS1101-GET-EXT.
           EXIT.
      *****************************************************************
      *    初期値設定処理
      *****************************************************************
       1001-INIT-VAL-SET-SEC           SECTION.
      *
            IF   ( ORCBSD01-PRTSRTKBN  =   "3" OR  "4" )
                MOVE   1               TO  FLG-END
            END-IF
      *
           .
       1001-INIT-VAL-SET-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           PERFORM 2001-DTCHK007-EDIT-SEC
      *
           PERFORM 2001-DTCHK004-EDIT-SEC
      *
           MOVE    1               TO  FLG-END
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    複数保険エラー患者ファイル編集処理
      *****************************************************************
       2001-DTCHK007-EDIT-SEC          SECTION.
      *
           OPEN    INPUT               DTCHK004-FILE
           OPEN    OUTPUT              DTCHK007-FILE
      *
           MOVE    ZERO            TO  FLG-DTCHK004
      *
      *    チェック結果ファイル読込
           PERFORM 900-DTCHK004-READ-SEC
      *
           PERFORM UNTIL ( FLG-DTCHK004    =   1 )
      *
               MOVE    ZERO        TO  CNT-HKN
               MOVE    KEY-NEW     TO  KEY-OLD
      *
               PERFORM UNTIL ( FLG-DTCHK004    =   1 )
                        OR   ( KEY-N-PTID  NOT =   KEY-O-PTID )
      *
                   MOVE    KEY-NEW     TO  KEY-OLD
      *
                   PERFORM UNTIL ( FLG-DTCHK004    =   1 )
                            OR   ( KEY-N-PTID      NOT =   KEY-O-PTID )
                            OR   ( KEY-N-HKNKBN    NOT =   KEY-O-HKNKBN)
      *
      *                チェック結果ファイル読込
                       PERFORM 900-DTCHK004-READ-SEC
      *
                   END-PERFORM
      *
                   COMPUTE  CNT-HKN    =   CNT-HKN +   1
      *
               END-PERFORM
      *
               IF    ( CNT-HKN     >   1 )
                   INITIALIZE          DTCHK007-REC
                   MOVE    KEY-O-PTID  TO  DTCHK007-PTID
                   WRITE   DTCHK007-REC
               END-IF
      *
           END-PERFORM
      *
           CLOSE                       DTCHK004-FILE
                                       DTCHK007-FILE
      *
           .
       2001-DTCHK007-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    チェック結果ファイル複数保険エラー編集処理
      *****************************************************************
       2001-DTCHK004-EDIT-SEC          SECTION.
      *
           OPEN    I-O                 DTCHK004-FILE
           OPEN    INPUT               DTCHK007-FILE
      *
           MOVE    ZERO            TO  FLG-DTCHK004
      *
      *    チェック結果ファイル読込
           PERFORM 900-DTCHK004-READ-SEC
      *
           PERFORM UNTIL ( FLG-DTCHK004    =   1 )
      *
               MOVE    KEY-NEW     TO  KEY-OLD
      *
               MOVE    SPACE       TO  WRK-HKNOTHERS
               PERFORM 900-DTCHK007-READ-SEC
               IF    ( FLG-DTCHK007    =   ZERO )
                   MOVE    "1"     TO  WRK-HKNOTHERS
               END-IF
      *
                   DISPLAY "DTCHK004-PTNUM =" DTCHK004-PTNUM
                   DISPLAY "WRK-HKNOTHERS  =" WRK-HKNOTHERS
               PERFORM UNTIL ( FLG-DTCHK004    =   1 )
                        OR   ( KEY-N-PTID  NOT =   KEY-O-PTID )
      *
                   MOVE    WRK-HKNOTHERS   TO  DTCHK004-HKNOTHERS
      *
                   REWRITE DTCHK004-REC
      *
      *            チェック結果ファイル読込
                   PERFORM 900-DTCHK004-READ-SEC
      *
               END-PERFORM
      *
           END-PERFORM
      *
           CLOSE                       DTCHK004-FILE
                                       DTCHK007-FILE
      *
           .
       2001-DTCHK004-EDIT-EXT.
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
           MOVE    1                   TO  FLG-END
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
           DISPLAY "*** ORCDTCHK008 END ***"
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    チェック結果ファイル読込処理
      *****************************************************************
       900-DTCHK004-READ-SEC           SECTION.
      *
           READ    DTCHK004-FILE       NEXT
           AT  END
               MOVE    1               TO  FLG-DTCHK004
           END-READ
      *
           IF    ( FLG-DTCHK004        =   ZERO )
               MOVE    DTCHK004-PTID   TO  KEY-N-PTID
               MOVE    DTCHK004-HKNKBN TO  KEY-N-HKNKBN
               COMPUTE CNT-DTCHK004    =   CNT-DTCHK004    +   1
           ELSE
               MOVE    HIGH-VALUE      TO  KEY-NEW
           END-IF
      *
           .
       900-DTCHK004-READ-EXT.
           EXIT.
      *****************************************************************
      *    複数保険エラー患者ファイル読み込み処理
      *****************************************************************
       900-DTCHK007-READ-SEC            SECTION.
      *
           MOVE    ZERO            TO  FLG-DTCHK007
      *
           INITIALIZE                  DTCHK007-REC
           MOVE    DTCHK004-PTID   TO  DTCHK007-PTID
      *
           READ    DTCHK007-FILE
           INVALID KEY
               MOVE    1           TO  FLG-DTCHK007
           END-READ
      *
           .
       900-DTCHK007-READ-EXT.
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
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBCLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       900-DBSTART-SEC                 SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       900-DBSTART-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBCOMMIT-SEC                SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC.
           .
       900-DBCOMMIT-EXT.
           EXIT.
