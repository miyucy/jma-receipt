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
       PROGRAM-ID.                     ORCBS01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 日次統計
      *  コンポーネント名  : 収納支払証明書発行
      *  管理者            :
      *  作成日付    作業者        記述
      *  03/04/08    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                         DIVISION.
       CONFIGURATION                       SECTION.
       INPUT-OUTPUT                        SECTION.
       FILE-CONTROL.
      *
      *    エラーファイル
           SELECT  ORCBS01ERR-FILE ASSIGN  WRK-PARA-ERRFILE
                                   FILE    STATUS  IS  STS-ORCBS01ERR.
      *
       DATA                                DIVISION.
       FILE                                SECTION.
      *    エラーファイル
       FD  ORCBS01ERR-FILE.
       01  ORCBS01ERR-REC                  PIC X(200).
      *
       WORKING-STORAGE                     SECTION.
      *
      *    ステータス領域
       01  STS-AREA.
           03  STS-ORCBS01ERR                  PIC X(02).
      *
      *    フラグ
       01  FLG-AREA.
           03  FLG-END                         PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-OUT1                        PIC 9(06).
      *
       01  INDEX-AREA.
           03  IDX1                            PIC 9(05). 
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID                  PIC 9(07).
           03  WRK-PARA-SHELLID                PIC X(08).
           03  WRK-PARA-ERRFILE                PIC X(100).
           03  WRK-PARA-HOSPID                 PIC X(24).
           03  WRK-PARA-PGTYPE                 PIC X(20).
           03  WRK-PARA-PGNAME                 PIC X(20).
           03  WRK-PARA-STAFFCD                PIC X(05).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME.
               05  SYS-THH                     PIC 9(02).
               05  SYS-TMM                     PIC 9(02).
               05  SYS-TSS                     PIC 9(02).
               05  SYS-TDD                     PIC 9(02).
           03  SYS-YMD.
               05  SYS-YY                      PIC 9(04).
               05  SYS-MM                      PIC 9(02).
               05  SYS-DD                      PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-JOBTITLE                    PIC X(100).
           03  WRK-PRTTITLE                    PIC X(100).
           03  WRK-ERRMSG                      PIC X(200).
      *
           COPY    "MCPAREA".
      *
           COPY    "COMMON-SPA".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    患者番号
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "ORCA-DBPATH".
      *
      *    支払証明書
           COPY    "CPORCHCM31.INC".
      *
      *    印刷ＤＢ制御
           COPY    "CPORCSPRT.INC".
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                 SECTION.
      *
       01  COMMAND-PARAM       PIC X(400).
      *
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
                                       INDEX-AREA
                                       CNT-AREA
                                       WRK-AREA
                                       SYS-AREA
                                       WRK-PARA
                                       ORCHCM31AREA
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
                                       WRK-PARA-ERRFILE
                                       WRK-PARA-HOSPID
                                       WRK-PARA-PGTYPE
                                       WRK-PARA-PGNAME
                                       WRK-PARA-STAFFCD
                                       ORCHCM31-STRSRYYMD
                                       ORCHCM31-ENDSRYYMD
                                       ORCHCM31-KIKANKBN
                                       ORCHCM31-SYORIKBN
                                       ORCHCM31-DSPKBN
                                       ORCHCM31-PTID
      *
           PERFORM 100-DBOPEN-SEC
      *
           PERFORM 1001-SPA-AREA-SET-SEC
      *
           PERFORM 900-PTINF-KEY-SEL-SEC
      *
           MOVE    SPACE           TO  WRK-JOBTITLE
                                       WRK-PRTTITLE
      *
           EVALUATE    WRK-PARA-PGTYPE
           WHEN    "HC31"
               STRING  "支払日別："        DELIMITED   BY  SIZE
                       PTINF-NAME          DELIMITED   BY  SPACE
               INTO    WRK-PRTTITLE
               END-STRING
      *
               MOVE    "支払証明書（日別）"
                                   TO  WRK-JOBTITLE
      *
           WHEN    "HC32"
               STRING  "支払月別："        DELIMITED   BY  SIZE
                       PTINF-NAME          DELIMITED   BY  SPACE
               INTO    WRK-PRTTITLE
               END-STRING
      *
               MOVE    "支払証明書（月別）"
                                   TO  WRK-JOBTITLE
      *
           WHEN    OTHER
               STRING  "支払証明："        DELIMITED   BY  SIZE
                       PTINF-NAME          DELIMITED   BY  SPACE
               INTO    WRK-PRTTITLE
               END-STRING
               MOVE    "支払証明書"
                                   TO  WRK-JOBTITLE
           END-EVALUATE
      *
           PERFORM 1001-ORCSPRTAREA-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    WRK-PARA-PGNAME TO  JOB-PGID
      *
           MOVE    WRK-JOBTITLE    TO  JOB-SHELLMSG
      *
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           .
       100-INIT-EXT.
           EXIT.
      * 
      *****************************************************************
      *    ＳＰＡ領域設定処理
      *****************************************************************
       1001-SPA-AREA-SET-SEC           SECTION.
      *
           INITIALIZE                  SPA-AREA
      *
           MOVE    WRK-PARA-HOSPID     TO  SPA-HOSPID
           MOVE    ORCHCM31-PTID       TO  SPA-PTID
           MOVE    WRK-PARA-STAFFCD    TO  SPA-STAFFCD
           MOVE    LNK-PRTKANRI-SKYYMD TO  SPA-SYSYMD
      *
           .
       1001-SPA-AREA-SET-EXT.
           EXIT.
      *****************************************************************
      *    印刷ＤＢ制御情報領域設定処理
      *****************************************************************
       1001-ORCSPRTAREA-SEC            SECTION.
      *
      *    印刷パラメタ編集
           INITIALIZE                      ORCSPRTAREA
           MOVE    "INS"               TO  SPRT-MODE
           MOVE    LNK-PRTKANRI-RENNUM TO  SPRT-RENNUM
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  SPRT-TBL-KEY
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  SPRT-TBL-GROUP
           MOVE    LNK-PRTKANRI-SRYYM  TO  SPRT-SRYYM
           MOVE    LNK-PRTKANRI-SKYYMD TO  SPRT-SKYYMD
           MOVE    LNK-PRTKANRI-SHELLID
                                       TO  SPRT-SHELLID
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                       TO  SPRT-SHORI-RENNUM
           MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  SPRT-PRIORITY
           MOVE    WRK-PRTTITLE        TO  SPRT-TITLE
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
           MOVE    SPA-PTID            TO  SPRT-PTID
      *
           .
       1001-ORCSPRTAREA-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
      *    処理プログラム呼出
           CALL    WRK-PARA-PGNAME USING   SPA-AREA
                                           ORCSPRTAREA
                                           ORCHCM31AREA
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC          SECTION.
      *
           OPEN    INPUT               ORCBS01ERR-FILE
           IF        ( STS-ORCBS01ERR  =   ZERO )
               CONTINUE
           ELSE
               OPEN    OUTPUT              ORCBS01ERR-FILE
      *
               MOVE    WRK-ERRMSG      TO  ORCBS01ERR-REC
               WRITE   ORCBS01ERR-REC
               CLOSE   ORCBS01ERR-FILE
      *
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-ERRMSG      TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"           USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
           END-IF
      *
           MOVE    1                   TO  FLG-END
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
           IF    ( ORCHCM31-OT-CNT =   ZERO )
               MOVE    "処理対象のデータがありませんでした"
                                   TO  WRK-ERRMSG
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    ORCHCM31-OT-CNT TO  JOB-UPDCNT
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者情報検索処理(KEY)
      *****************************************************************
       900-PTINF-KEY-SEL-SEC           SECTION.
      *
           INITIALIZE                  PTINF-REC
           MOVE    SPA-HOSPID      TO  PTINF-HOSPID
           MOVE    SPA-PTID        TO  PTINF-PTID
           MOVE    PTINF-REC       TO  MCPDATA-REC
           MOVE    PATH-TBL-PTINF-KEY  TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  PTINF-REC
           ELSE
               INITIALIZE              PTINF-REC
           END-IF
      *
           MOVE    PATH-TBL-PTINF-KEY  TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-PTINF-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC          SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF        ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル読込処理
      *****************************************************************
       910-DBFETCH-SEC            SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       910-DBCLOSE-SEC           SECTION.
      *
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DBCLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
      *
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBOPEN"            TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBSTART"           TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC.
           .
       900-DBDISCONNECT-EXT.
           EXIT.
