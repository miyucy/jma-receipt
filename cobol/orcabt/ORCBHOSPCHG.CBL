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
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCBHOSPCHG.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 随時
      *  コンポーネント名  : 会計クリア（月途中医療機関コード変更対応）
      *  管理者            : 
      *  作成日付    作業者        記述
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  03.05.01    NACL-小豆沢  07/06/15  グループ診療対応
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *    エラーファイル
           SELECT  RECEERR-FILE        ASSIGN  RECEERR
                                       FILE    STATUS  IS  STS-RECEERR.
      *
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200).
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    エラーファイル 名称領域 
      **     COPY    "CPCOMMONDAT2.INC"
      **                             REPLACING  //RECE01PARA//
      **                             BY         //RECEERR//.
      **     03  FILLER              PIC X(04)   VALUE   ".dat".
      *
       01  STS-AREA.
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                 PIC 9(01).
           03  FLG-SRYACCT             PIC 9(01).
           03  FLG-NYUINACCT           PIC 9(01).
           03  FLG-SANTEI              PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-SRYACCT-UPD         PIC 9(05).
           03  CNT-NYUINACCT-UPD       PIC 9(05).
           03  CNT-SANTEI-UPD          PIC 9(05).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY              PIC 9(02).
               05  SYS-MM              PIC 9(02).
               05  SYS-DD              PIC 9(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                    PIC 9(05).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID          PIC 9(07).
           03  WRK-PARA-SHELLID        PIC X(08).
           03  WRK-PARA-HOSPNUM        PIC 9(02).
           03  RECEERR                 PIC X(100).
           03  WRK-PARA-SRYYM          PIC X(06).
           03  WRK-PARA-STIDX          PIC X(02).
           03  WRK-PARA-EDIDX          PIC X(02).
      *
      *    一時領域
       01  WRK-AREA.
      *
           03  WRK-RECEERR             PIC X(200).
           03  WRK-STIDX               PIC 9(05).
           03  WRK-EDIDX               PIC 9(05).
      *
      *    COPY    "CPSHELLTBL.INC".
      *
      *    COPY    "ORCA-DBPATH".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *
      *    診療会計マスタ
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    入院診療会計マスタ−
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    算定履歴
       01  SANTEI-REC.
           COPY    "CPSANTEI.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
      *
           COPY    "COMMON-SPA".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
       01  COMMAND-PARAM.
           02  FILLER                  PIC X(256).
      *
      ******************************************************************
      *
       PROCEDURE               DIVISION
                                       USING
                                       COMMAND-PARAM.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           IF    ( FLG-END =   ZERO )
               PERFORM 200-MAIN-SEC
           END-IF
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  SPA-AREA
      *
           PERFORM 100-DBOPEN-SEC
      *
           UNSTRING    COMMAND-PARAM   DELIMITED  BY  ","
                       INTO            LNK-PRTKANRI-RENNUM
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
                                       WRK-PARA-HOSPNUM
                                       RECEERR
                                       WRK-PARA-SRYYM
                                       WRK-PARA-STIDX
                                       WRK-PARA-EDIDX
           END-UNSTRING
           MOVE    WRK-PARA-HOSPNUM    TO   SPA-HOSPNUM
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    "ORCBHOSPCHG"   TO  JOB-PGID
           MOVE    "会計クリア処理"
                                   TO  JOB-SHELLMSG
           PERFORM   900-CALL-ORCSJOB-SEC
      *
      **     MOVE    "RECEERR"       TO  RECEERR-FILE-ID
      **     MOVE    LNK-PRTKANRI-TERMID
      **                             TO  RECEERR-TERMID
      *
      *    パラメタ編集処理
           PERFORM 110-PARA-HENSYU-SEC
           IF    ( FLG-END     NOT =   ZERO )
               GO  TO  100-INIT-EXT
           END-IF
      *
           MOVE    WRK-PARA-STIDX    TO  WRK-STIDX
           MOVE    WRK-PARA-EDIDX    TO  WRK-EDIDX
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタ編集処理
      *****************************************************************
       110-PARA-HENSYU-SEC         SECTION.
      *
           MOVE    SPACE           TO  WRK-RECEERR
           IF ( WRK-PARA-STIDX     >=   "01")   AND
              ( WRK-PARA-STIDX     <=   "31")
               CONTINUE
           ELSE
               MOVE    "開始日が誤りです"   TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  110-PARA-HENSYU-EXT
           END-IF
           IF ( WRK-PARA-EDIDX     >=   "01")   AND
              ( WRK-PARA-EDIDX     <=   "31")
               CONTINUE
           ELSE
               MOVE    "終了日が誤りです"   TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  110-PARA-HENSYU-EXT
           END-IF
           IF ( WRK-PARA-STIDX     <=    WRK-PARA-EDIDX)
               CONTINUE
           ELSE
               MOVE    "開始日が終了日より後日付です"
                                   TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  110-PARA-HENSYU-EXT
           END-IF
      *
           .
       110-PARA-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    診療会計更新処理
           PERFORM 201-SRYACCT-UPD-SEC
           IF    ( FLG-END     NOT =   ZERO )
               GO  TO  200-MAIN-EXT
           END-IF
      *
      *    入院会計更新処理
           PERFORM 201-NYUINACCT-UPD-SEC
           IF    ( FLG-END     NOT =   ZERO )
               GO  TO  200-MAIN-EXT
           END-IF
      *
      *    算定履歴更新処理
           PERFORM 201-SANTEI-UPD-SEC
           IF    ( FLG-END     NOT =   ZERO )
               GO  TO  200-MAIN-EXT
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計更新処理
      *****************************************************************
       201-SRYACCT-UPD-SEC             SECTION.
      *
           MOVE    ZERO            TO  FLG-SRYACCT
      *
           INITIALIZE                  SRYACCT-REC
           MOVE    WRK-PARA-SRYYM  TO  ACCT-SRYYM
           MOVE    SPA-HOSPNUM     TO  ACCT-HOSPNUM
           MOVE    SRYACCT-REC     TO  MCPDATA-REC
           MOVE    "tbl_sryacct"   TO  MCP-TABLE
           MOVE    "all2"          TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SRYACCT-REC
           ELSE
               MOVE    1           TO  FLG-SRYACCT
           END-IF
      *
           PERFORM UNTIL ( FLG-SRYACCT NOT =   ZERO )
      *
               PERFORM VARYING IDX1    FROM    WRK-STIDX   BY  1
                       UNTIL ( IDX1    >       WRK-EDIDX )
      *
                   COMPUTE ACCT-ZAIKAISU   =   ACCT-ZAIKAISU
                                           -   ACCT-DAY (1 IDX1)
      *
                   MOVE    ZERO        TO  ACCT-DAY (1 IDX1 )
                                           ACCT-DAY (2 IDX1 )
                                           ACCT-DAY (3 IDX1 )
                                           ACCT-DAY (4 IDX1 )
                                           ACCT-DAY (5 IDX1 )
                                           ACCT-DAY (6 IDX1 )
                                           ACCT-DAY (7 IDX1 )
                                           ACCT-DAY (8 IDX1 )
                                           ACCT-DAY (9 IDX1 )
                                           ACCT-DAY (10 IDX1 )
      *
               END-PERFORM
      *
               MOVE    SRYACCT-REC     TO  MCPDATA-REC
               MOVE    "DBUPDATE"      TO  MCP-FUNC
               MOVE    "tbl_sryacct"   TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               PERFORM   900-ORCDBMAIN-SEC
               IF    ( MCP-RC      NOT =   ZERO )
                   DISPLAY "ORCBMRECE SRYACCT UPD ERR:"  MCP-RC
                           ",PTID:"   ACCT-PTID
                   MOVE    "診療会計の更新に失敗しました"
                                       TO  WRK-RECEERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  201-SRYACCT-UPD-EXT
               END-IF
      *
               COMPUTE CNT-SRYACCT-UPD =   CNT-SRYACCT-UPD +   1
      *
               MOVE    "tbl_sryacct"   TO  MCP-TABLE
               MOVE    "all2"          TO  MCP-PATHNAME
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC TO  SRYACCT-REC
               ELSE
                   MOVE    1           TO  FLG-SRYACCT
               END-IF
      *
           END-PERFORM
      *
           MOVE    "tbl_sryacct"       TO  MCP-TABLE
           MOVE    "all2"              TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       201-SRYACCT-UPD-EXT.
           EXIT.
      *****************************************************************
      *    入院会計更新処理
      *****************************************************************
       201-NYUINACCT-UPD-SEC           SECTION.
      *
           MOVE    ZERO            TO  FLG-NYUINACCT
      *
           INITIALIZE                  NYUINACCT-REC
           MOVE    WRK-PARA-SRYYM  TO  NACCT-SRYYM
           MOVE    SPA-HOSPNUM     TO  NACCT-HOSPNUM
           MOVE    NYUINACCT-REC   TO  MCPDATA-REC
           MOVE    "tbl_nyuinacct" TO  MCP-TABLE
           MOVE    "all2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  NYUINACCT-REC
           ELSE
               MOVE    1           TO  FLG-NYUINACCT
           END-IF
      *
           PERFORM UNTIL ( FLG-NYUINACCT NOT =   ZERO )
      *
               PERFORM VARYING IDX1    FROM    WRK-STIDX   BY  1
                       UNTIL ( IDX1    >       WRK-EDIDX )
      *
                   COMPUTE NACCT-ZAIKAISU  =   NACCT-ZAIKAISU
                                           -   NACCT-DAY (IDX1)
      *
                   MOVE    ZERO        TO  NACCT-DAY (IDX1)
      *
               END-PERFORM
      *
               MOVE    NYUINACCT-REC   TO  MCPDATA-REC
               MOVE    "DBUPDATE"      TO  MCP-FUNC
               MOVE    "tbl_nyuinacct" TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               PERFORM   900-ORCDBMAIN-SEC
               IF    ( MCP-RC      NOT =   ZERO )
                   DISPLAY "ORCBMRECE NYUINACCT UPD ERR:"  MCP-RC
                           ",PTID:"   NACCT-PTID
                   MOVE    "入院会計の更新に失敗しました"
                                       TO  WRK-RECEERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  201-NYUINACCT-UPD-EXT
               END-IF
      *
               COMPUTE CNT-NYUINACCT-UPD   =   CNT-NYUINACCT-UPD   +   1
      *
               MOVE    "tbl_nyuinacct" TO  MCP-TABLE
               MOVE    "all2"          TO  MCP-PATHNAME
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC TO  NYUINACCT-REC
               ELSE
                   MOVE    1           TO  FLG-NYUINACCT
               END-IF
      *
           END-PERFORM
      *
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "all2"              TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       201-NYUINACCT-UPD-EXT.
           EXIT.
      *****************************************************************
      *    算定更新処理
      *****************************************************************
       201-SANTEI-UPD-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-SANTEI
      *
           INITIALIZE                  SANTEI-REC
           MOVE    WRK-PARA-SRYYM  TO  SANTEI-SRYYM
           MOVE    SPA-HOSPNUM     TO  SANTEI-HOSPNUM
           MOVE    SANTEI-REC      TO  MCPDATA-REC
           MOVE    "tbl_santei"    TO  MCP-TABLE
           MOVE    "all2"          TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SANTEI-REC
           ELSE
               MOVE    1           TO  FLG-SANTEI
           END-IF
      *
           PERFORM UNTIL ( FLG-SANTEI NOT =   ZERO )
      *
               PERFORM VARYING IDX1    FROM    WRK-STIDX   BY  1
                       UNTIL ( IDX1    >       WRK-EDIDX )
      *
                   MOVE    ZERO        TO  SANTEI-DAY (IDX1)
      *
               END-PERFORM
      *
               MOVE    SANTEI-REC      TO  MCPDATA-REC
               MOVE    "DBUPDATE"      TO  MCP-FUNC
               MOVE    "tbl_santei"    TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               PERFORM   900-ORCDBMAIN-SEC
               IF    ( MCP-RC      NOT =   ZERO )
                   DISPLAY "ORCBMRECE SANTEI UPD ERR:"  MCP-RC
                           ",PTID:"   SANTEI-PTID
                   MOVE    "算定履歴の更新に失敗しました"
                                       TO  WRK-RECEERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  201-SANTEI-UPD-EXT
               END-IF
      *
               COMPUTE CNT-SANTEI-UPD  =   CNT-SANTEI-UPD   +   1
      *
               MOVE    "tbl_santei"    TO  MCP-TABLE
               MOVE    "all2"          TO  MCP-PATHNAME
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC TO  SANTEI-REC
               ELSE
                   MOVE    1           TO  FLG-SANTEI
               END-IF
      *
           END-PERFORM
      *
           MOVE    "tbl_santei"        TO  MCP-TABLE
           MOVE    "all2"              TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       201-SANTEI-UPD-EXT.
           EXIT.
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           DISPLAY "*** ORCBMRECE SRYACCT   UPD:"     CNT-SRYACCT-UPD
           DISPLAY "*** ORCBMRECE NYUINACCT UPD:"     CNT-NYUINACCT-UPD
           DISPLAY "*** ORCBMRECE SANTEI    UPD:"     CNT-SANTEI-UPD
           DISPLAY "*** ORCBMRECE END ***"
      *     
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    CNT-SRYACCT-UPD TO  JOB-UPDCNT
           PERFORM   900-CALL-ORCSJOB-SEC
      *
           PERFORM 900-DBDISCONNECT-SEC
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC          SECTION.
      *
           OPEN    INPUT               RECEERR-FILE
           IF          STS-RECEERR     =   ZERO
               CONTINUE
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
               PERFORM   900-CALL-ORCSJOB-SEC
           END-IF
      *
           MOVE    1                   TO  FLG-END
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       900-CLOSE-SEC               SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ管理ＤＢ制御処理
      *****************************************************************
       900-CALL-ORCSJOB-SEC            SECTION.
      *
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    SPA-HOSPNUM     TO  JOB-HOSPNUM
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA 
                                   JOBKANRI-REC
                                   SPA-AREA
           .
       900-CALL-ORCSJOB-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ検索処理（FHETCHも行う)
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           PERFORM   900-ORCDBMAIN-SEC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           PERFORM   900-ORCDBMAIN-SEC
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルアクセス処理
      *****************************************************************
       900-ORCDBMAIN-SEC               SECTION.
      *
           CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
           .
      *
       900-ORCDBMAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC              SECTION.
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
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC        SECTION.
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
       900-DBCLOSE-EXT.
           EXIT.
