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
       PROGRAM-ID.             ORCBCOPY.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 随時
      *  コンポーネント名  : データ退避プログラム
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/05/15    NACL-小豆沢   新規作成
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
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC                     PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"      REPLACING   //RECE01PARA//
                                           BY          //RECEERR//.
           03  FILLER                      PIC X(04)   VALUE   ".dat".
      *    ステータス領域
      *
      *
       01  STS-AREA.
           03  STS-RECEERR                 PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-SYSKANRI                PIC 9(01).
           03  FLG-SEIKYU                  PIC 9(01).
           03  FLG-PTRSIINF                PIC 9(01).
           03  FLG-NYUINACCT               PIC 9(01).
           03  FLG-NYUINACCT-UPD           PIC 9(01).
           03  FLG-NYUINACT                PIC 9(01).
           03  FLG-TENSU                   PIC 9(01).
           03  FLG-DBRC                    PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-LINE                    PIC 9(05).
           03  CNT-PAGE                    PIC 9(05).
           03  CNT-JOB-UPDCNT              PIC 9(06).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME                    PIC 9(08).
           03  SYS-YMD.
               05  SYS-YY                  PIC 9(02).
               05  SYS-MM                  PIC 9(02).
               05  SYS-DD                  PIC 9(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                                 PIC 9(05).
      *
      *    パラメタ領域
       01  PARA-AREA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID                      PIC 9(07).
           03  WRK-PARA-SHELLID                    PIC X(08).
           03  WRK-PARA-HOSPID                     PIC X(24).
           03  WRK-PARA-SRYYM                      PIC X(06).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-DBPATH                          PIC X(100).
           03  WRK-ERRNO                           PIC 9(2).
           03  WRK-RECEERR                         PIC X(200).
           03  WRK-HOSPID                          PIC X(24).
           03  WRK-MEISAISU                        PIC 9(07).
           03  WRK-SURYOTOTAL                      PIC 9(07).
           03  WRK-SRYCDTOTAL                      PIC 9(14).
           03  WRK-SRYCDX                          PIC X(09).
           03  WRK-SRYCD9       REDEFINES     WRK-SRYCDX
                                                   PIC 9(09).
           03  WRK-ZAITEN                          PIC 9(08).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
           COPY    "CPSK1001.INC".
      *
      *    請求管理
           COPY    "CPRCF010.INC".
      *
      *    退避用請求管理
           COPY    "CPRCF010.INC" REPLACING //RECE10-//
                                                    BY //BAK-RECE10-//.
      *
      *    患者労災保険情報
       01  PTRSIINF-REC.
           COPY    "CPPTRSIINF.INC".
      *
      *    入院会計
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    入院行為
       01  NYUINACT-REC.
           COPY    "CPNYUINACT.INC".
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
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
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
           02  FILLER                  PIC X(1000).
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
           DISPLAY "000-PROC-SEC"
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           .
       000-PROC-EXT.
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
           DISPLAY "100-INIT-SEC"
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
      *
           PERFORM 100-DBOPEN-SEC
      *
           INITIALIZE                  PARA-AREA
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
                                       WRK-PARA-HOSPID
                                       WRK-PARA-SRYYM
           END-UNSTRING
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCBCOPY"          TO  JOB-PGID
           MOVE    "データ退避処理"    TO  JOB-SHELLMSG
      *
           CALL    "ORCSJOB"               USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  RECEERR-TERMID
      *
      *    更新日取得
           INITIALIZE                  ORCSMCNDATEAREA
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
      *
      *    医療機関ＩＤ編集
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1001"              TO  SYS-KANRICD
           MOVE    "*%"                TO  SYS-KBNCD
           MOVE    WRK-PARA-SRYYM      TO  SYS-STYUKYMD (1:6)
           MOVE    "01"                TO  SYS-STYUKYMD (7:2)
           MOVE    SYS-STYUKYMD        TO  SYS-EDYUKYMD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-SYSKANRI-SELECT-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM     910-SYSKANRI-READ-SEC
                   IF    FLG-SYSKANRI  =   ZERO
                         MOVE    SYS-1001-HOSPID  TO  WRK-HOSPID
                   ELSE
                         MOVE  "医療機関情報が取得できませんでした。"
                                           TO  WRK-RECEERR
                         PERFORM 500-ERR-HENSYU-SEC
                         GO  TO  100-INIT-EXT
                   END-IF
           ELSE
               MOVE    "医療機関情報が取得できませんでした。"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  100-INIT-EXT
           END-IF
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    入院分退避処理
      *
           IF   SYS-1001-BEDSU          NOT =  ZERO
               MOVE    ZERO                TO  FLG-SEIKYU
               INITIALIZE                      RECE10-REC
               MOVE    SYS-1001-HOSPID     TO  RECE10-HOSPID
               MOVE    WRK-PARA-SRYYM      TO  RECE10-SRYYM
                                               RECE10-SKYYM
               MOVE    "1"                 TO  RECE10-NYUGAIKBN
               MOVE    "tbl_seikyu"        TO  MCP-TABLE
               MOVE    "key42"             TO  MCP-PATHNAME
               PERFORM 910-SEIKYU-SELECT-SEC
               IF      FLG-SEIKYU          =   ZERO
      *
                   MOVE    "tbl_seikyu"        TO  MCP-TABLE
                   MOVE    "key42"             TO  MCP-PATHNAME
                   PERFORM 910-SEIKYU-READ-SEC
                   PERFORM  UNTIL  FLG-SEIKYU    =    1
      *                労災保険の判定
                       MOVE    SYS-1001-HOSPID     TO  PTRSI-HOSPID
                       MOVE    RECE10-PTID         TO  PTRSI-PTID
                       MOVE    "tbl_ptrsiinf"      TO  MCP-TABLE
                       MOVE    "key3"              TO  MCP-PATHNAME
                       PERFORM 910-PTRSIINF-SELECT-SEC
                       MOVE    "tbl_ptrsiinf"      TO  MCP-TABLE
                       MOVE    "key3"              TO  MCP-PATHNAME
                       PERFORM 910-PTRSIINF-READ-SEC
                       MOVE    "tbl_ptrsiinf"      TO  MCP-TABLE
                       MOVE    "key3"              TO  MCP-PATHNAME
                       PERFORM 910-TBL-CLOSE-SEC
                       IF      FLG-PTRSIINF  NOT =   ZERO
      *                    退避処理
                           PERFORM   210-TAIHI-SEC
                       END-IF
      *
                       MOVE    "tbl_seikyu"        TO  MCP-TABLE
                       MOVE    "key42"             TO  MCP-PATHNAME
                       PERFORM 910-SEIKYU-READ-SEC
                   END-PERFORM
               END-IF
      *
               MOVE    "tbl_seikyu"        TO  MCP-TABLE
               MOVE    "key42"             TO  MCP-PATHNAME
               PERFORM 910-TBL-CLOSE-SEC
           END-IF
      *
      *    入院外分退避処理
      *
           MOVE    ZERO                TO  FLG-SEIKYU
           INITIALIZE                      RECE10-REC
           MOVE    SYS-1001-HOSPID     TO  RECE10-HOSPID
           MOVE    WRK-PARA-SRYYM      TO  RECE10-SRYYM
                                           RECE10-SKYYM
           MOVE    "2"                 TO  RECE10-NYUGAIKBN
           MOVE    "tbl_seikyu"        TO  MCP-TABLE
           MOVE    "key42"             TO  MCP-PATHNAME
           PERFORM 910-SEIKYU-SELECT-SEC
           IF      FLG-SEIKYU          =   ZERO
      *
               MOVE    "tbl_seikyu"        TO  MCP-TABLE
               MOVE    "key42"             TO  MCP-PATHNAME
               PERFORM 910-SEIKYU-READ-SEC
               PERFORM  UNTIL  FLG-SEIKYU    =    1
      *                労災保険の判定
                       MOVE    SYS-1001-HOSPID     TO  PTRSI-HOSPID
                       MOVE    RECE10-PTID         TO  PTRSI-PTID
                       MOVE    "tbl_ptrsiinf"      TO  MCP-TABLE
                       MOVE    "key3"              TO  MCP-PATHNAME
                       PERFORM 910-PTRSIINF-SELECT-SEC
                       MOVE    "tbl_ptrsiinf"      TO  MCP-TABLE
                       MOVE    "key3"              TO  MCP-PATHNAME
                       PERFORM 910-PTRSIINF-READ-SEC
                       MOVE    "tbl_ptrsiinf"      TO  MCP-TABLE
                       MOVE    "key3"              TO  MCP-PATHNAME
                       PERFORM 910-TBL-CLOSE-SEC
                       IF      FLG-PTRSIINF  NOT =   ZERO
      *                    退避処理
                           PERFORM   210-TAIHI-SEC
                       END-IF
      *
                   MOVE    "tbl_seikyu"        TO  MCP-TABLE
                   MOVE    "key42"             TO  MCP-PATHNAME
                   PERFORM 910-SEIKYU-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "tbl_seikyu"        TO  MCP-TABLE
           MOVE    "key42"             TO  MCP-PATHNAME
           PERFORM 910-TBL-CLOSE-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    退避処理（入院、入院外共通処理）
      *****************************************************************
       210-TAIHI-SEC          SECTION.
      *
           DISPLAY "RECE10-PTID = " RECE10-PTID
           DISPLAY "RECE10-SRYYM = " RECE10-SRYYM
      *    請求管理退避
           MOVE     RECE10-REC         TO  MCPDATA-REC
           MOVE    "bak_tbl_seikyu"    TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           MOVE    "DBINSERT"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE     RECE10-REC         TO  MCPDATA-REC
               MOVE    "tbl_seikyu"        TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               MOVE    "DBDELETE"          TO  MCP-FUNC
               CALL    "MONFUNC"           USING
                                           MCPAREA
                                           MCPDATA-REC
           ELSE
               DISPLAY "BAK-TBL-SEIKYU TAIHI-ERR PTID  = " RECE10-PTID
               DISPLAY "                        SRYYM  = " RECE10-SRYYM
           END-IF
      *
           .
       210-TAIHI-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    CNT-PAGE        TO  JOB-UPDCNT
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           .
       300-END-EXT.
           EXIT.
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC              SECTION.
      *
           OPEN    OUTPUT      RECEERR-FILE
      *
           MOVE    WRK-RECEERR     TO  RECEERR-REC
           WRITE   RECEERR-REC
           CLOSE   RECEERR-FILE
      *
      *    ジョブ管理終了処理
           MOVE    "JBE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    WRK-RECEERR     TO  JOB-YOBI
           MOVE    "9999"          TO  JOB-ERRCD
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           STOP RUN
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       900-TBL-CLOSE-SEC               SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       900-TBL-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       910-TBL-CLOSE-SEC               SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-TBL-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC              SECTION.
      *
           MOVE    LOW-VALUE       TO  MCP-TABLE
                                       MCP-PATHNAME
           MOVE    "DBOPEN"        TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           MOVE    LOW-VALUE       TO  MCP-TABLE
                                       MCP-PATHNAME
           MOVE    "DBSTART"       TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC        SECTION.
      *
           MOVE    LOW-VALUE       TO  MCP-TABLE
                                       MCP-PATHNAME
           MOVE    "DBCOMMIT"      TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           MOVE    LOW-VALUE       TO  MCP-TABLE
                                       MCP-PATHNAME
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           .
      *
       900-DBDISCONNECT-EXT.
           EXIT.
      *      
      *****************************************************************
      *    システム管理マスター検索
      *****************************************************************
       910-SYSKANRI-SELECT-SEC        SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       910-SYSKANRI-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスター読込
      *****************************************************************
       910-SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC    TO  SYS-1001-REC
               MOVE    ZERO           TO  FLG-SYSKANRI
           ELSE
               INITIALIZE                 SYS-1001-REC
               MOVE    1              TO  FLG-SYSKANRI
           END-IF
      *
           .
       910-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求管理検索
      *****************************************************************
       910-SEIKYU-SELECT-SEC        SECTION.
      *
           MOVE    RECE10-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SEIKYU
           ELSE
               MOVE    1               TO  FLG-SEIKYU
           END-IF
      *
           .
       910-SEIKYU-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求管理読込
      *****************************************************************
       910-SEIKYU-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  RECE10-REC
               MOVE    ZERO            TO  FLG-SEIKYU
           ELSE
               INITIALIZE                  RECE10-REC
               MOVE    1               TO  FLG-SEIKYU
           END-IF
      *
           .
       910-SEIKYU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者労災保険情報検索
      *****************************************************************
       910-PTRSIINF-SELECT-SEC        SECTION.
      *
           MOVE    PTRSIINF-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-PTRSIINF
           ELSE
               MOVE    1               TO  FLG-PTRSIINF
           END-IF
      *
           .
       910-PTRSIINF-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者労災保険情報読込
      *****************************************************************
       910-PTRSIINF-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTRSIINF-REC
               MOVE    ZERO            TO  FLG-PTRSIINF
           ELSE
               INITIALIZE                  PTRSIINF-REC
               MOVE    1               TO  FLG-PTRSIINF
           END-IF
      *
           .
       910-PTRSIINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスター検索
      *****************************************************************
       910-NYUINACCT-SELECT-SEC        SECTION.
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-NYUINACCT
           ELSE
               MOVE    1               TO  FLG-NYUINACCT
           END-IF
      *
           .
       910-NYUINACCT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスター読込
      *****************************************************************
       910-NYUINACCT-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  NYUINACCT-REC
               MOVE    ZERO            TO  FLG-NYUINACCT
           ELSE
               INITIALIZE                  NYUINACCT-REC
               MOVE    1               TO  FLG-NYUINACCT
           END-IF
      *
           .
       910-NYUINACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院診療行為マスター検索
      *****************************************************************
       910-NYUINACT-SELECT-SEC        SECTION.
      *
           MOVE    NYUINACT-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-NYUINACT
           ELSE
               MOVE    1               TO  FLG-NYUINACT
           END-IF
      *
           .
       910-NYUINACT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院診療行為マスター読込
      *****************************************************************
       910-NYUINACT-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  NYUINACT-REC
               MOVE    ZERO            TO  FLG-NYUINACT
           ELSE
               INITIALIZE                  NYUINACT-REC
               MOVE    1               TO  FLG-NYUINACT
           END-IF
      *
           .
       910-NYUINACT-READ-EXT.
           EXIT.
