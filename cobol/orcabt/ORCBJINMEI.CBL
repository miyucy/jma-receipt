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
       PROGRAM-ID.             ORCBJINMEI.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 随時
      *  コンポーネント名  : 人名辞書再作成
      *  管理者            : 
      *  作成日付    作業者        記述
      *  05/05/26    NACL-小豆沢   新規作成
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
           03  FLG-JINMEI                  PIC 9(01).
           03  FLG-PTINF                   PIC 9(01).
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
           03  IDX0                        PIC 9(05).
           03  IDX1                        PIC 9(05).
           03  IDX2                        PIC 9(05).
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
           03  WRK-RECEERR                         PIC X(200).
           03  WRK-KANA-SEI                        PIC X(50).
           03  WRK-KANA-MEI                        PIC X(50).
           03  WRK-KANJI-SEI                       PIC X(50).
           03  WRK-KANJI-MEI                       PIC X(50).
      *
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    人名
       01  JINMEI-REC.
           COPY    "CPJINMEI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
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
           MOVE    "ORCBJINMEI"        TO  JOB-PGID
           MOVE    "人名辞書再作成"    TO  JOB-SHELLMSG
      *
           CALL    "ORCSJOB"               USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  RECEERR-TERMID
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
      *    患者検索
           MOVE    ZERO                 TO      FLG-PTINF
           INITIALIZE                           PTINF-REC
           MOVE    "PTINF-ALL"          TO      ORC-DBPATH
           PERFORM   910-PTINF-SELECT-SEC
           IF      FLG-PTINF            =       ZERO
               MOVE    "PTINF-ALL"      TO      ORC-DBPATH
               PERFORM  910-PTINF-READ-SEC
               PERFORM  UNTIL  FLG-PTINF    =    1
                   PERFORM  2001-JINMEI-INS-SEC
                   MOVE    "PTINF-ALL"    TO      ORC-DBPATH
                   PERFORM  910-PTINF-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE     "PTINF-ALL"          TO  ORC-DBPATH
           PERFORM   900-TBL-CLOSE-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    人名辞書再登録処理
      *****************************************************************
       2001-JINMEI-INS-SEC          SECTION.
      *
           UNSTRING    PTINF-KANANAME  DELIMITED  BY  "　"
                       INTO            WRK-KANA-SEI
                                       WRK-KANA-MEI
           END-UNSTRING
           UNSTRING    PTINF-NAME      DELIMITED  BY  "　"
                       INTO            WRK-KANJI-SEI
                                       WRK-KANJI-MEI
           END-UNSTRING
      *
           DISPLAY "WRK-KANA-SEI = " WRK-KANA-SEI
           DISPLAY "WRK-KANA-MEI = " WRK-KANA-MEI
           DISPLAY "WRK-KANJI-SEI = " WRK-KANJI-SEI
           DISPLAY "WRK-KANJI-MEI = " WRK-KANJI-MEI
      *
           IF     (WRK-KANA-MEI   =  SPACE)  OR
                  (WRK-KANJI-MEI   =  SPACE)
               CONTINUE
           ELSE
               IF    WRK-KANA-SEI   NOT =  WRK-KANJI-SEI
                   INITIALIZE   JINMEI-REC
                   MOVE   WRK-KANA-SEI   TO  JINMEI-KANA
                   MOVE   WRK-KANJI-SEI  TO  JINMEI-KANJI
                   MOVE   JINMEI-REC     TO  MCPDATA-REC
                   MOVE   "DBINSERT"     TO  MCP-FUNC
                   MOVE   "JINMEI-KEY"   TO  ORC-DBPATH
                   CALL   "ORCMCPSUB"    USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
               END-IF
               IF    WRK-KANA-MEI   NOT =  WRK-KANJI-MEI
                   INITIALIZE   JINMEI-REC
                   MOVE   WRK-KANA-MEI   TO  JINMEI-KANA
                   MOVE   WRK-KANJI-MEI  TO  JINMEI-KANJI
                   MOVE   JINMEI-REC     TO  MCPDATA-REC
                   MOVE   "DBINSERT"     TO  MCP-FUNC
                   MOVE   "JINMEI-KEY"   TO  ORC-DBPATH
                   CALL   "ORCMCPSUB"    USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
               END-IF
           END-IF
           .
       2001-JINMEI-INS-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
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
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-TBL-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC              SECTION.
      *
           MOVE    "DBOPEN"        TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           MOVE    "DBSTART"       TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC        SECTION.
      *
           MOVE    "DBCOMMIT"      TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
       900-DBDISCONNECT-EXT.
           EXIT.
      *      
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBCLOSE-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBCLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者情報マスター検索
      *****************************************************************
       910-PTINF-SELECT-SEC        SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-PTINF
           ELSE
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           .
       910-PTINF-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者情報マスター読込
      *****************************************************************
       910-PTINF-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTINF-REC
               MOVE    ZERO            TO  FLG-PTINF
           ELSE
               INITIALIZE                  PTINF-REC
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           .
       910-PTINF-READ-EXT.
           EXIT.
