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
      *
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCGD03.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : データチェックサブ
      *  コンポーネント名  : チェック確認データ振り分け
      *  管理者            : 
      *  作成日付    作業者        記述
      *  01.07.13    ひさなが      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    ひさなが     01/10/15  印刷順を患者番号へ変更
      *  01.00.01    ひさなが     01/11/08  実日数の確認追加
      *  01.00.01    ひさなが     02/03/01  印刷順、印刷グループの変更
      *  01.00.01    ひさなが     02/03/14  メッセージのコードを名称へ
      *  01.00.02    ひさなが     02/05/07  半角チェックの追加
      *  01.00.03    ひさなが     03/07/29  チェック内容全件印刷追加
      *                                     科情報の印刷
      *
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    チェク条件用ファイル
           SELECT  DID1-FILE       ASSIGN  DID1PARA
                                   FILE    STATUS  IS  STS-DID1.
      *    確認抽出用ファイル１
           SELECT  DID2-FILE       ASSIGN  DID2PARA
                                   FILE    STATUS  IS  STS-DID2.
      *    振り分け用ファイル１
           SELECT  DID5-FILE       ASSIGN  DID5PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  DID5-KEY
                                   FILE    STATUS  IS  STS-DID5.
      *    振り分け用ファイル２
           SELECT  DID6-FILE       ASSIGN  DID6PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  DID6-KEY
                                   FILE    STATUS  IS  STS-DID6.
      *    振り分け用ファイル３
           SELECT  DID7-FILE       ASSIGN  DID7PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  DID7-KEY
                                   FILE    STATUS  IS  STS-DID7.
      *    振り分け用ファイル４
           SELECT  DID9-FILE       ASSIGN  DID9PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  DID9-KEY
                                   FILE    STATUS  IS  STS-DID9.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    チェク条件用ファイル
       FD  DID1-FILE.
       01  DID1-REC                PIC X(200). 
      *    確認抽出用ファイル１
       FD  DID2-FILE.
       01  DID2-REC                PIC X(200).
      *    振り分け用ファイル１
       FD  DID5-FILE.
       01  DID5-REC.
           COPY    "CPRECORCGD06.INC"
                                   REPLACING  //DID6//
                                   BY         //DID5//.
      *    振り分け用ファイル２
       FD  DID6-FILE.
       01  DID6-REC. 
           COPY    "CPRECORCGD06.INC".
      *    振り分け用ファイル３
       FD  DID7-FILE.
       01  DID7-REC. 
           COPY    "CPRECORCGD06.INC"
                                   REPLACING  //DID6//
                                   BY         //DID7//.
      *    振り分け用ファイル４
       FD  DID9-FILE.
       01  DID9-REC. 
           COPY    "CPRECORCGD06.INC"
                                   REPLACING  //DID6//
                                   BY         //DID9//.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    チェク条件用ファイル 名称領域 
           COPY    "CPCOMMONDAT3.INC"
                                   REPLACING  //ORCGD//
                                   BY         //DID1//.
      *
      *    確認抽出用ファイル１ 名称領域 
           COPY    "CPCOMMONDAT3.INC"
                                   REPLACING  //ORCGD//
                                   BY         //DID2//.
      *
      *    振り分け用ファイル１ 名称領域 
           COPY    "CPCOMMONDAT3.INC"
                                   REPLACING  //ORCGD//
                                   BY         //DID5//.
      *
      *    振り分け用ファイル２ 名称領域 
           COPY    "CPCOMMONDAT3.INC"
                                   REPLACING  //ORCGD//
                                   BY         //DID6//.
      *
      *    振り分け用ファイル３ 名称領域
           COPY    "CPCOMMONDAT3.INC"
                                   REPLACING  //ORCGD//
                                   BY         //DID7//.
      *
      *    振り分け用ファイル４ 名称領域
           COPY    "CPCOMMONDAT3.INC"
                                   REPLACING  //ORCGD//
                                   BY         //DID9//.
      *
      *    診療年月領域
       01  T-SINRYOU-AREA.
           03  T-SINRYOU-Y         PIC 9(04).
           03  T-SINRYOU-M         PIC 9(02).
      *
      *    判定、カウント領域
       01  T-HANTEI-CNT-AREA.
           03  T-HANNTEI1          PIC X(01).
           03  T-CNT-IN            PIC 9(09).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-MCP1            PIC 9(01).
           03  FLG-MCP2            PIC 9(01).
      *
      *    エンドステータス領域
       01  STS-AREA.
           03  STS-DID1            PIC X(02).
           03  STS-DID2            PIC X(02).
           03  STS-DID5            PIC X(02).
           03  STS-DID6            PIC X(02).
           03  STS-DID7            PIC X(02).
           03  STS-DID9            PIC X(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                PIC 9(03).
           03  IDY1                PIC 9(03).
           03  IDY2                PIC 9(03).
      *
      *    氏名、生年月日、年齢、患者番号、編集作業領域
       01  W-SAGIYOU.
           03  W-NAME              PIC X(100).
           03  W-NENREI            PIC 9(002).
           03  W-BIRTHDAY.
               05  W-BIRTHDAY-Y    PIC 9(004).
               05  W-BIRTHDAY-M    PIC 9(002).
               05  W-BIRTHDAY-D    PIC 9(002).
           03  WRK-PARA.
               05  WRK-PARA-SRYYM                  PIC X(06).
               05  WRK-PARA-TERMID                 PIC X(64).
               05  WRK-PARA-SYSYMD                 PIC X(08).
               05  WRK-PARA-OPID                   PIC X(16).
               05  WRK-PARA-SYOKBN                 PIC X(01).
               05  WRK-PARA-RECEKBN                PIC X(01).
           03  W-PTNUM             PIC X(020).
           03  W-HOSPID            PIC X(024).
           03  W-PTID              PIC X(010).
           03  W-MESG              PIC X(200).
           03  W-MESG-NAME1        PIC X(200).
           03  W-MESG-NAME2        PIC X(200).
           03  W-MESG-SEIDONAME    PIC X(100).
      *
      *    診療科情報作業
       01  W-SYS-SRYKA-AREA.
           03  W-SYS-SRYKA-LIST               OCCURS  100.
               05  W-SYS-SRYKA         PIC X(02).
               05  W-SYS-SRYKAMEI      PIC X(12).
           03  W-SYS-SRYKA-MAX1        PIC 9(04).
      *
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSK1005.INC".
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    患者番号変換
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *    保険番号
       01  HKNNUM-REC. 
           COPY    "CPHKNNUM.INC".
      *
      *    点数マスタ
           COPY    "CPTENSU.INC".
      *
      *    診療会計
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    連絡
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *     テーブルアクセス
           COPY    "MCPAREA".
      *
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
      *
        LINKAGE                     SECTION.
      *
        01  COMMAND-PARAM.
            02  FILLSE              PIC X(2000).
      *
      *
       PROCEDURE                   DIVISION    USING
                                               COMMAND-PARAM.
      *****************************************************************
      *    主    処    理
      *****************************************************************
      *
       000-PROC-SEC                SECTION.
      *    初期処理
           PERFORM T-000-CHEKINIT-SEC.
      *    チェック確認データ 振り分け処理
           PERFORM T-100-CHEKCHEK-SEC  UNTIL   FLG-END =   1.
      *    終了処理
           PERFORM T-000-CHEKTERM-SEC.
      *
       000-PROC-SEC-EXT.
           STOP    RUN.
      *
      *****************************************************************
      *    初　期　処　理
      *****************************************************************
       T-000-CHEKINIT-SEC                SECTION.
      *    ＤＢ　 オープン処理
           PERFORM 000-DBOPEN-SEC.
      *    外部ファイル名 設定処理
           PERFORM T-000-CHEKSETT-SEC.
      *
           OPEN    INPUT                   DID1-FILE.
           OPEN    INPUT                   DID2-FILE.
           OPEN    OUTPUT                  DID5-FILE.
           OPEN    OUTPUT                  DID6-FILE.
           OPEN    OUTPUT                  DID7-FILE.
           OPEN    OUTPUT                  DID9-FILE.
           MOVE    ZERO                TO  FLG-END.
           MOVE    ZERO                TO  T-CNT-IN.
           MOVE    SPACE               TO  W-HOSPID.
           MOVE    SPACE               TO  W-PTID.
      *    診療年月 入力処理
           PERFORM T-000-CHEKCHEK-SEC  VARYING IDX1  FROM  1  BY 1
                                       UNTIL   IDX1  >     2.
      *
      *修正/*開始*03.07.29*********************************************
      *    診療科 入力処理
           INITIALIZE                  W-SYS-SRYKA-AREA.
           INITIALIZE                  SYS-1005-REC.
           MOVE    "1005"              TO  SYS-1005-KANRICD.
           MOVE    ZERO                TO  SYS-1005-STYUKYMD.
           MOVE    ALL "9"             TO  SYS-1005-EDYUKYMD.
           MOVE    SYS-1005-REC        TO  MCPDATA-REC.
           MOVE    T-SINRYOU-AREA(1:6) TO  ORC-DBYMD(1:6).
           MOVE    "01"                TO  ORC-DBYMD(7:2).
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH.
      *
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           IF  MCP-RC   =   ZERO
               PERFORM T-000-KANRIMST-READ-SEC
               PERFORM VARYING     IDY1    FROM    1   BY  1
                       UNTIL      (IDY1            >   100)  OR
                                  (MCP-RC      NOT =   ZERO)
                   MOVE    MCPDATA-REC           TO  SYS-1005-REC
                   MOVE    SYS-1005-KBNCD (1:2)  TO
                                                 W-SYS-SRYKA (IDY1)
                   MOVE    SYS-1005-SRYKANAME2   TO
                                                 W-SYS-SRYKAMEI (IDY1)
                   MOVE    IDY1                  TO  W-SYS-SRYKA-MAX1
                   PERFORM T-000-KANRIMST-READ-SEC
               END-PERFORM
           END-IF.
      *
           INITIALIZE                  MCPAREA.
           MOVE    "DBCLOSE"           TO  MCP-FUNC.
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *修正/*終了*03.07.29*********************************************
      *
       T-000-CHEKINITK-EXT.
           EXIT.
      *
      *******************
      *
       T-000-KANRIMST-READ-SEC          SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC.
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
      *****************************************************************
      *    終　了　処　理
      *****************************************************************
       T-000-CHEKTERM-SEC                SECTION.
      *
           CLOSE                           DID1-FILE.
           CLOSE                           DID2-FILE.
           CLOSE                           DID5-FILE.
           CLOSE                           DID6-FILE.
           CLOSE                           DID7-FILE.
           CLOSE                           DID9-FILE.
      *    ＤＢ　 クローズ処理
           PERFORM 000-DBCLOSE-SEC.
      *
       T-000-CHEKTERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　 オープン処理
      *****************************************************************
       000-DBOPEN-SEC                 SECTION.
      *
           MOVE    "DBOPEN"            TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
       000-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　 クローズ処理
      *****************************************************************
       000-DBCLOSE-SEC                SECTION.
      *
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
       000-DBCLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    外部ファイル名 設定処理
      *****************************************************************
       T-000-CHEKSETT-SEC                SECTION.
      *
           MOVE    COMMAND-PARAM       TO  WRK-PARA.
      *
           MOVE    "ORCGD1"            TO  DID1PARA-FILE-ID.
           MOVE    WRK-PARA-TERMID     TO  DID1PARA-TERMID.
      *
           MOVE    "ORCGD2"            TO  DID2PARA-FILE-ID.
           MOVE    WRK-PARA-TERMID     TO  DID2PARA-TERMID.
      *
           MOVE    "ORCGD5"            TO  DID5PARA-FILE-ID.
           MOVE    WRK-PARA-TERMID     TO  DID5PARA-TERMID.
      *
           MOVE    "ORCGD6"            TO  DID6PARA-FILE-ID.
           MOVE    WRK-PARA-TERMID     TO  DID6PARA-TERMID.
      *
           MOVE    "ORCGD7"            TO  DID7PARA-FILE-ID.
           MOVE    WRK-PARA-TERMID     TO  DID7PARA-TERMID.
      *
           MOVE    "ORCGD9"            TO  DID9PARA-FILE-ID.
           MOVE    WRK-PARA-TERMID     TO  DID9PARA-TERMID.
      *
       T-000-CHEKCHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療年月 入力処理
      *****************************************************************
       T-000-CHEKCHEK-SEC                SECTION.
      *
           READ    DID1-FILE
                   AT   END
                        MOVE     3                     TO    IDX1
                   NOT  AT  END
                        EVALUATE    IDX1
                            WHEN    02
                               MOVE    DID1-REC(7:6)
                                       TO    T-SINRYOU-AREA(1:6)
                        END-EVALUATE
           END-READ.
      *
       T-000-CHEKCHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    チェック確認データ 振り分け処理
      *****************************************************************
       T-100-CHEKCHEK-SEC                SECTION.
      *
           READ    DID2-FILE
                   AT   END
                        MOVE     1                     TO    FLG-END
                   NOT  AT  END
      *修正/*開始*03.07.29*********************************************
                        PERFORM T-101-CHEKCHEK-SEC
      *修正/*終了*03.07.29*********************************************
                        EVALUATE    DID2-REC(71:3)
                            WHEN    "100"
                            WHEN    "200"
                            WHEN    "300"
                            WHEN    "400"
                            WHEN    "500"
                               COMPUTE T-CNT-IN  =  T-CNT-IN  +  1
                               PERFORM T-201-CHEKCHEK-SEC
                            WHEN    "510"
                               COMPUTE T-CNT-IN  =  T-CNT-IN  +  1
                               PERFORM T-203-CHEKCHEK-SEC
                            WHEN    "520"
                            WHEN    "530"
                            WHEN    "540"
                               COMPUTE T-CNT-IN  =  T-CNT-IN  +  1
                               PERFORM T-202-CHEKCHEK-SEC
                            WHEN    "600"
                               COMPUTE T-CNT-IN  =  T-CNT-IN  +  1
                               PERFORM T-204-CHEKCHEK-SEC
                        END-EVALUATE
           END-READ.
      *
       T-100-CHEKCHEK-EXT.
           EXIT.
      *修正/*開始*03.07.29*********************************************
      *
      *****************************************************************
      *    科情報の決定 処理
      *****************************************************************
       T-101-CHEKCHEK-SEC                SECTION.
      *
           MOVE    ZERO                  TO  IDY2.
           PERFORM VARYING    IDY1   FROM   1   BY  1
                   UNTIL      IDY1   >   W-SYS-SRYKA-MAX1
               IF  W-SYS-SRYKA (IDY1)   =   DID2-REC(191:2)
                   MOVE    IDY1                  TO  IDY2
                   MOVE    200                   TO  IDY1
               END-IF
           END-PERFORM.
      *
       T-101-CHEKCHEK-EXT.
           EXIT.
      *修正/*終了*03.07.29*********************************************
      *
      *****************************************************************
      *    チェック確認データ 振り分けデータ１出力 処理
      *****************************************************************
       T-201-CHEKCHEK-SEC                SECTION.
      *
           INITIALIZE                  DID5-REC.
           MOVE    DID2-REC(71:6)      TO  DID5-MESGID.
           MOVE    DID2-REC(1:24)      TO  DID5-HOSPID.
           MOVE    T-CNT-IN            TO  DID5-SEQNO.
      *修正/*開始*03.07.29*********************************************
      *     MOVE    DID2-REC(1:200)     TO  DID5-MESG.
      *修正/*終了*03.07.29*********************************************
           IF  (DID2-REC(1:24)    NOT =   W-HOSPID)  OR
               (DID2-REC(26:10)   NOT =   W-PTID)
               PERFORM T-300-CHEKCHEK-SEC
               PERFORM T-400-CHEKCHEK-SEC
               MOVE    DID2-REC(1:24)      TO  W-HOSPID
               MOVE    DID2-REC(26:10)     TO  W-PTID
           END-IF,
           MOVE    W-NAME              TO  DID5-NAME.
           MOVE    W-NENREI            TO  DID5-NENREI.
           MOVE    W-PTNUM             TO  DID5-PTNUM.
      *修正/*開始*03.07.29*********************************************
      *     IF  DID2-REC(71:6) =  "400-06"
      *         MOVE    DID2-REC(37:10)     TO    DID5-MESG(135:10)
      *         PERFORM T-500-CHEKCHEK-SEC
      *     END-IF.
           EVALUATE    DID2-REC(71:6)
               WHEN    "400-06"
                  PERFORM T-500-CHEKCHEK-SEC
               WHEN    OTHER
                  PERFORM T-201-CHEKCHEK-HEN1-SEC
           END-EVALUATE.
           MOVE    W-MESG              TO  DID5-MESG.
      *修正/*終了*03.07.29*********************************************
           WRITE   DID5-REC.
      *
       T-201-CHEKCHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    チェック確認データ 振り分けデータ２出力 処理
      *****************************************************************
       T-202-CHEKCHEK-SEC                SECTION.
      *
           INITIALIZE                  DID6-REC.
           MOVE    DID2-REC(71:6)      TO  DID6-MESGID.
           MOVE    DID2-REC(1:24)      TO  DID6-HOSPID.
           MOVE    T-CNT-IN            TO  DID6-SEQNO.
      *修正/*開始*03.07.29*********************************************
      *     MOVE    DID2-REC(1:200)     TO  DID6-MESG.
      *修正/*終了*03.07.29*********************************************
           IF  (DID2-REC(1:24)    NOT =   W-HOSPID)  OR
               (DID2-REC(26:10)   NOT =   W-PTID)
               PERFORM T-300-CHEKCHEK-SEC
               PERFORM T-400-CHEKCHEK-SEC
               MOVE    DID2-REC(1:24)      TO  W-HOSPID
               MOVE    DID2-REC(26:10)     TO  W-PTID
           END-IF,
           MOVE    W-NAME              TO  DID6-NAME.
           MOVE    W-NENREI            TO  DID6-NENREI.
           MOVE    W-PTNUM             TO  DID6-PTNUM.
      *修正/*開始*03.07.29*********************************************
      *     IF  DID2-REC(71:6) =  "530-07"  OR  "530-06"
      *         MOVE    DID2-REC(37:9)      TO    DID6-MESG(121:9)
      *         MOVE    DID2-REC(47:9)      TO    DID6-MESG(153:9)
      *         PERFORM T-510-CHEKCHEK-SEC
      *     END-IF.
      *     IF  DID2-REC(71:6) =  "530-04"  OR  "530-03"
      *         MOVE    DID2-REC(37:9)      TO    DID6-MESG(135:9)
      *         PERFORM T-512-CHEKCHEK-SEC
      *     END-IF.
      *     IF  DID2-REC(71:6) =  "540-02"  OR  "540-03"
      *         MOVE    DID2-REC(37:9)      TO    DID6-MESG(131:9)
      *         PERFORM T-512-CHEKCHEK-SEC
      *     END-IF.
           MOVE    ALL SPACE           TO    W-MESG-NAME1.
           MOVE    ALL SPACE           TO    W-MESG-NAME2.
           EVALUATE    DID2-REC(71:6)
               WHEN    "530-07"
               WHEN    "530-06"
                  MOVE    DID2-REC(37:9)      TO    W-MESG-NAME1
                  MOVE    DID2-REC(47:9)      TO    W-MESG-NAME2
                  PERFORM T-510-CHEKCHEK-SEC
               WHEN    "530-04"
               WHEN    "530-03"
                  MOVE    DID2-REC(37:9)      TO    W-MESG-NAME1
                  PERFORM T-512-CHEKCHEK-SEC
               WHEN    "540-03"
               WHEN    "540-02"
                  MOVE    DID2-REC(37:9)      TO    W-MESG-NAME1
                  PERFORM T-512-CHEKCHEK-SEC
               WHEN    OTHER
                  PERFORM T-201-CHEKCHEK-HEN1-SEC
           END-EVALUATE.
           MOVE    W-MESG              TO  DID6-MESG.
      *修正/*終了*03.07.29*********************************************
           IF  DID2-REC(71:6) =  "530-07"  OR  "530-06"
               PERFORM T-520-CHEKCHEK-SEC
               IF  (FLG-MCP1 =  1)  AND  (FLG-MCP2 =  1)
                   WRITE   DID6-REC
               END-IF
           ELSE
               WRITE   DID6-REC
           END-IF.
      *
       T-202-CHEKCHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    チェック確認データ 振り分けデータ３出力 処理
      *****************************************************************
       T-203-CHEKCHEK-SEC                SECTION.
      *
           INITIALIZE                  DID7-REC.
           MOVE    DID2-REC(71:6)      TO  DID7-MESGID.
           MOVE    DID2-REC(1:24)      TO  DID7-HOSPID.
           MOVE    T-CNT-IN            TO  DID7-SEQNO.
      *修正/*開始*03.07.29*********************************************
      *     MOVE    DID2-REC(1:200)     TO  DID7-MESG.
      *修正/*終了*03.07.29*********************************************
           IF  (DID2-REC(1:24)    NOT =   W-HOSPID)  OR
               (DID2-REC(26:10)   NOT =   W-PTID)
               PERFORM T-300-CHEKCHEK-SEC
               PERFORM T-400-CHEKCHEK-SEC
               MOVE    DID2-REC(1:24)      TO  W-HOSPID
               MOVE    DID2-REC(26:10)     TO  W-PTID
           END-IF,
           MOVE    W-NAME              TO  DID7-NAME.
           MOVE    W-NENREI            TO  DID7-NENREI.
           MOVE    W-PTNUM             TO  DID7-PTNUM.
      *修正/*開始*03.07.29*********************************************
           PERFORM T-201-CHEKCHEK-HEN1-SEC.
           MOVE    W-MESG              TO  DID7-MESG.
      *修正/*終了*03.07.29*********************************************
           WRITE   DID7-REC.
      *
       T-203-CHEKCHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    チェック確認データ 振り分けデータ４出力 処理
      *****************************************************************
       T-204-CHEKCHEK-SEC                SECTION.
      *
           INITIALIZE                  DID9-REC.
           MOVE    DID2-REC(71:6)      TO  DID9-MESGID.
           MOVE    DID2-REC(1:24)      TO  DID9-HOSPID.
           MOVE    T-CNT-IN            TO  DID9-SEQNO.
      *修正/*開始*03.07.29*********************************************
      *     MOVE    DID2-REC(1:200)     TO  DID9-MESG.
      *修正/*終了*03.07.29*********************************************
           IF  (DID2-REC(1:24)    NOT =   W-HOSPID)  OR
               (DID2-REC(26:10)   NOT =   W-PTID)
               PERFORM T-300-CHEKCHEK-SEC
               PERFORM T-400-CHEKCHEK-SEC
               MOVE    DID2-REC(1:24)      TO  W-HOSPID
               MOVE    DID2-REC(26:10)     TO  W-PTID
           END-IF,
           MOVE    W-NAME              TO  DID9-NAME.
           MOVE    W-NENREI            TO  DID9-NENREI.
           MOVE    W-PTNUM             TO  DID9-PTNUM.
      *修正/*開始*03.07.29*********************************************
           PERFORM T-201-CHEKCHEK-HEN1-SEC.
           MOVE    W-MESG              TO  DID9-MESG.
      *修正/*終了*03.07.29*********************************************
           WRITE   DID9-REC.
      *
       T-204-CHEKCHEK-EXT.
           EXIT.
      *修正/*開始*03.07.29*********************************************
      *
      *****************************************************************
      *    科情報のメッセージに取り込み編集１ 処理
      *****************************************************************
       T-201-CHEKCHEK-HEN1-SEC           SECTION.
      *
           MOVE    ALL SPACE           TO  W-MESG.
           IF  IDY2    =   ZERO
               EVALUATE    DID2-REC(194:1)
                   WHEN    "1"
                      STRING  "［入院］"             DELIMITED BY SIZE
                              DID2-REC(77:90)        DELIMITED BY SPACE
                                    INTO             W-MESG
                      END-STRING
                   WHEN    "2"
                      STRING  "［診療］"             DELIMITED BY SIZE
                              DID2-REC(77:90)        DELIMITED BY SPACE
                                    INTO             W-MESG
                      END-STRING
                   WHEN    OTHER
                      STRING  DID2-REC(77:90)        DELIMITED BY SPACE
                                    INTO             W-MESG
                      END-STRING
               END-EVALUATE
           ELSE
               EVALUATE    DID2-REC(194:1)
                   WHEN    "1"
                      STRING  "［"                   DELIMITED BY SIZE
                              W-SYS-SRYKAMEI (IDY2)  DELIMITED BY SPACE
                              "（入院）］"           DELIMITED BY SIZE
                              DID2-REC(77:90)        DELIMITED BY SPACE
                                    INTO             W-MESG
                      END-STRING
                   WHEN    "2"
                      STRING  "［"                   DELIMITED BY SIZE
                              W-SYS-SRYKAMEI (IDY2)  DELIMITED BY SPACE
                              "（診療）］"           DELIMITED BY SIZE
                              DID2-REC(77:90)        DELIMITED BY SPACE
                                    INTO             W-MESG
                      END-STRING
                   WHEN    OTHER
                      STRING  "［"                   DELIMITED BY SIZE
                              W-SYS-SRYKAMEI (IDY2)  DELIMITED BY SPACE
                              "］"                   DELIMITED BY SIZE
                              DID2-REC(77:90)        DELIMITED BY SPACE
                                    INTO             W-MESG
                      END-STRING
               END-EVALUATE
           END-IF.
      *
       T-201-CHEKCHEK-HEN1-EXT.
           EXIT.
      *修正/*終了*03.07.29*********************************************
      *
      *****************************************************************
      *    患者情報テーブル 参照処理
      *****************************************************************
       T-300-CHEKCHEK-SEC                SECTION.
      *
           INITIALIZE                  PTINF-REC.
           MOVE    DID2-REC(1:24)      TO  PTINF-HOSPID.
           MOVE    DID2-REC(26:10)     TO  PTINF-PTID.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC.
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           IF  MCP-RC    =   ZERO
               PERFORM T-300-CHEKCHEK-READ-SEC
               IF  MCP-RC    =   ZERO
                   MOVE    MCPDATA-REC         TO  PTINF-REC
                   MOVE    PTINF-NAME          TO  W-NAME
                   MOVE    PTINF-BIRTHDAY      TO  W-BIRTHDAY
                   COMPUTE W-NENREI  =  T-SINRYOU-Y - W-BIRTHDAY-Y
                   IF  T-SINRYOU-M    <   W-BIRTHDAY-M
                       COMPUTE W-NENREI  =  W-NENREI  -  1
                   END-IF
               END-IF
           END-IF.
      *
           INITIALIZE                  MCPAREA.
           MOVE    "DBCLOSE"           TO  MCP-FUNC.
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
       T-300-CHEKCHEK-EXT.
           EXIT.
      *
      *******************
      *
       T-300-CHEKCHEK-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC.
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
       T-300-CHEKCHEK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号変換 参照処理
      *****************************************************************
       T-400-CHEKCHEK-SEC                SECTION.
      *
           INITIALIZE                  PTNUM-REC.
           MOVE    DID2-REC(1:24)      TO  PTNUM-HOSPID.
           MOVE    DID2-REC(26:10)     TO  PTNUM-PTID.
      *
           MOVE    PTNUM-REC           TO  MCPDATA-REC.
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           IF  MCP-RC    =   ZERO
               PERFORM T-400-CHEKCHEK-READ-SEC
               IF  MCP-RC    =   ZERO
                   MOVE    MCPDATA-REC         TO  PTNUM-REC
                   MOVE    PTNUM-PTNUM         TO  W-PTNUM
               END-IF
           END-IF.
      *
           INITIALIZE                  MCPAREA.
           MOVE    "DBCLOSE"           TO  MCP-FUNC.
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
       T-400-CHEKCHEK-EXT.
           EXIT.
      *
      *******************
      *
       T-400-CHEKCHEK-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC.
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
       T-400-CHEKCHEK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険番号 参照処理
      *****************************************************************
       T-500-CHEKCHEK-SEC                SECTION.
      *
      *修正/*開始*03.07.29*********************************************
           MOVE    ALL SPACE           TO  W-MESG.
           MOVE    ALL SPACE           TO  W-MESG-SEIDONAME.
           MOVE    DID2-REC(37:3)      TO  W-MESG-SEIDONAME.
      *修正/*終了*03.07.29*********************************************
           INITIALIZE                  HKNNUM-REC.
           MOVE    DID2-REC(1:24)      TO  HKN-HOSPID.
           MOVE    DID2-REC(37:3)      TO  HKN-HKNNUM.
      *
           MOVE    HKNNUM-REC          TO  MCPDATA-REC.
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    "HKNNUM-KEY2"       TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           IF  MCP-RC    =   ZERO
               PERFORM T-500-CHEKCHEK-READ-SEC
               IF  MCP-RC    =   ZERO
                   MOVE    MCPDATA-REC         TO  HKNNUM-REC
      *修正/*開始*03.07.29*********************************************
      *             MOVE    HKN-SEIDONAME(1:64) TO  DID5-MESG(135:64)
                   MOVE    HKN-SEIDONAME       TO  W-MESG-SEIDONAME
      *修正/*終了*03.07.29*********************************************
               END-IF
           END-IF.
      *修正/*開始*03.07.29*********************************************
           STRING  DID2-REC(77:90)        DELIMITED BY SPACE
                   "、"                   DELIMITED BY SIZE
                   W-MESG-SEIDONAME       DELIMITED BY SPACE
                         INTO             W-MESG
           END-STRING.
      *修正/*終了*03.07.29*********************************************
      *
           INITIALIZE                  MCPAREA.
           MOVE    "DBCLOSE"           TO  MCP-FUNC.
           MOVE    "HKNNUM-KEY2"       TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
       T-500-CHEKCHEK-EXT.
           EXIT.
      *
      *******************
      *
       T-500-CHEKCHEK-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC.
           MOVE    "HKNNUM-KEY2"       TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
       T-500-CHEKCHEK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ 参照処理
      *****************************************************************
       T-510-CHEKCHEK-SEC                SECTION.
      *
           INITIALIZE                  TNS-TENSU-REC.
           MOVE    DID2-REC(37:9)      TO  TNS-SRYCD.
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC.
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH.
           MOVE    T-SINRYOU-AREA(1:6) TO  ORC-DBYMD(1:6).
           MOVE    "01"                TO  ORC-DBYMD(7:2).
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           IF  MCP-RC    =   ZERO
               PERFORM T-510-CHEKCHEK-READ-SEC
               IF  MCP-RC    =   ZERO
                   MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
      *修正/*開始*03.07.29*********************************************
      *             MOVE    TNS-NAME(1:28)      TO  DID6-MESG(107:31)
                   MOVE    TNS-NAME            TO  W-MESG-NAME1
      *修正/*終了*03.07.29*********************************************
               END-IF
           END-IF.
      *
           INITIALIZE                  MCPAREA.
           MOVE    "DBCLOSE"           TO  MCP-FUNC.
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *****
           INITIALIZE                  TNS-TENSU-REC.
           MOVE    DID2-REC(47:9)      TO  TNS-SRYCD.
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC.
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH.
           MOVE    T-SINRYOU-AREA(1:6) TO  ORC-DBYMD(1:6).
           MOVE    "01"                TO  ORC-DBYMD(7:2).
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           IF  MCP-RC    =   ZERO
               PERFORM T-510-CHEKCHEK-READ-SEC
               IF  MCP-RC    =   ZERO
                   MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
      *修正/*開始*03.07.29*********************************************
      *             MOVE    TNS-NAME(1:28)      TO  DID6-MESG(138:28)
                   MOVE    TNS-NAME            TO  W-MESG-NAME2
      *修正/*終了*03.07.29*********************************************
               END-IF
           END-IF.
      *
           INITIALIZE                  MCPAREA.
           MOVE    "DBCLOSE"           TO  MCP-FUNC.
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
      *修正/*開始*03.07.29*********************************************
           MOVE    ALL SPACE           TO  W-MESG.
           IF  IDY2    =   ZERO
               EVALUATE    DID2-REC(194:1)
                   WHEN    "1"
                      STRING  "［入院］"             DELIMITED BY SIZE
                              DID2-REC(77:90)        DELIMITED BY SPACE
                              "、"                   DELIMITED BY SIZE
                              W-MESG-NAME1           DELIMITED BY SPACE
                              "、"                   DELIMITED BY SIZE
                              W-MESG-NAME2           DELIMITED BY SPACE
                                    INTO             W-MESG
                      END-STRING
                   WHEN    "2"
                      STRING  "［診療］"             DELIMITED BY SIZE
                              DID2-REC(77:90)        DELIMITED BY SPACE
                              "、"                   DELIMITED BY SIZE
                              W-MESG-NAME1           DELIMITED BY SPACE
                              "、"                   DELIMITED BY SIZE
                              W-MESG-NAME2           DELIMITED BY SPACE
                                    INTO             W-MESG
                      END-STRING
                   WHEN    OTHER
                      STRING  DID2-REC(77:90)        DELIMITED BY SPACE
                              "、"                   DELIMITED BY SIZE
                              W-MESG-NAME1           DELIMITED BY SPACE
                              "、"                   DELIMITED BY SIZE
                              W-MESG-NAME2           DELIMITED BY SPACE
                                    INTO             W-MESG
                      END-STRING
               END-EVALUATE
           ELSE
               EVALUATE    DID2-REC(194:1)
                   WHEN    "1"
                      STRING  "［"                   DELIMITED BY SIZE
                              W-SYS-SRYKAMEI (IDY2)  DELIMITED BY SPACE
                              "（入院）］"           DELIMITED BY SIZE
                              DID2-REC(77:90)        DELIMITED BY SPACE
                              "、"                   DELIMITED BY SIZE
                              W-MESG-NAME1           DELIMITED BY SPACE
                              "、"                   DELIMITED BY SIZE
                              W-MESG-NAME2           DELIMITED BY SPACE
                                    INTO             W-MESG
                      END-STRING
                   WHEN    "2"
                      STRING  "［"                   DELIMITED BY SIZE
                              W-SYS-SRYKAMEI (IDY2)  DELIMITED BY SPACE
                              "（診療）］"           DELIMITED BY SIZE
                              DID2-REC(77:90)        DELIMITED BY SPACE
                              "、"                   DELIMITED BY SIZE
                              W-MESG-NAME1           DELIMITED BY SPACE
                              "、"                   DELIMITED BY SIZE
                              W-MESG-NAME2           DELIMITED BY SPACE
                                    INTO             W-MESG
                      END-STRING
                   WHEN    OTHER
                      STRING  "［"                   DELIMITED BY SIZE
                              W-SYS-SRYKAMEI (IDY2)  DELIMITED BY SPACE
                              "］"                   DELIMITED BY SIZE
                              DID2-REC(77:90)        DELIMITED BY SPACE
                              "、"                   DELIMITED BY SIZE
                              W-MESG-NAME1           DELIMITED BY SPACE
                              "、"                   DELIMITED BY SIZE
                              W-MESG-NAME2           DELIMITED BY SPACE
                                    INTO             W-MESG
                      END-STRING
               END-EVALUATE
           END-IF.
      *修正/*終了*03.07.29*********************************************
      *
       T-510-CHEKCHEK-EXT.
           EXIT.
      *
      *******************
      *
       T-512-CHEKCHEK-SEC                SECTION.
      *
           INITIALIZE                  TNS-TENSU-REC.
           MOVE    DID2-REC(37:9)      TO  TNS-SRYCD.
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC.
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH.
           MOVE    T-SINRYOU-AREA(1:6) TO  ORC-DBYMD(1:6).
           MOVE    "01"                TO  ORC-DBYMD(7:2).
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           IF  MCP-RC    =   ZERO
               PERFORM T-510-CHEKCHEK-READ-SEC
               IF  MCP-RC    =   ZERO
                   MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
      *修正/*開始*03.07.29*********************************************
      *             MOVE    TNS-NAME(1:70)      TO  DID6-MESG(131:70)
                   MOVE    TNS-NAME            TO  W-MESG-NAME1
      *修正/*終了*03.07.29*********************************************
           END-IF.
      *
           INITIALIZE                  MCPAREA.
           MOVE    "DBCLOSE"           TO  MCP-FUNC.
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
      *修正/*開始*03.07.29*********************************************
           MOVE    ALL SPACE           TO  W-MESG.
           IF  IDY2    =   ZERO
               EVALUATE    DID2-REC(194:1)
                   WHEN    "1"
                      STRING  "［入院］"             DELIMITED BY SIZE
                              DID2-REC(77:90)        DELIMITED BY SPACE
                              "、"                   DELIMITED BY SIZE
                              W-MESG-NAME1           DELIMITED BY SPACE
                                    INTO             W-MESG
                      END-STRING
                   WHEN    "2"
                      STRING  "［診療］"             DELIMITED BY SIZE
                              DID2-REC(77:90)        DELIMITED BY SPACE
                              "、"                   DELIMITED BY SIZE
                              W-MESG-NAME1           DELIMITED BY SPACE
                                    INTO             W-MESG
                      END-STRING
                   WHEN    OTHER
                      STRING  DID2-REC(77:90)        DELIMITED BY SPACE
                              "、"                   DELIMITED BY SIZE
                              W-MESG-NAME1           DELIMITED BY SPACE
                                    INTO             W-MESG
                      END-STRING
               END-EVALUATE
           ELSE
               EVALUATE    DID2-REC(194:1)
                   WHEN    "1"
                      STRING  "［"                   DELIMITED BY SIZE
                              W-SYS-SRYKAMEI (IDY2)  DELIMITED BY SPACE
                              "（入院）］"           DELIMITED BY SIZE
                              DID2-REC(77:90)        DELIMITED BY SPACE
                              "、"                   DELIMITED BY SIZE
                              W-MESG-NAME1           DELIMITED BY SPACE
                                    INTO             W-MESG
                      END-STRING
                   WHEN    "2"
                      STRING  "［"                   DELIMITED BY SIZE
                              W-SYS-SRYKAMEI (IDY2)  DELIMITED BY SPACE
                              "（診療）］"           DELIMITED BY SIZE
                              DID2-REC(77:90)        DELIMITED BY SPACE
                              "、"                   DELIMITED BY SIZE
                              W-MESG-NAME1           DELIMITED BY SPACE
                                    INTO             W-MESG
                      END-STRING
                   WHEN    OTHER
                      STRING  "［"                   DELIMITED BY SIZE
                              W-SYS-SRYKAMEI (IDY2)  DELIMITED BY SPACE
                              "］"                   DELIMITED BY SIZE
                              DID2-REC(77:90)        DELIMITED BY SPACE
                              "、"                   DELIMITED BY SIZE
                              W-MESG-NAME1           DELIMITED BY SPACE
                                    INTO             W-MESG
                      END-STRING
               END-EVALUATE
           END-IF.
      *修正/*終了*03.07.29*********************************************
      *
       T-512-CHEKCHEK-EXT.
           EXIT.
      *
      *******************
      *
       T-510-CHEKCHEK-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC.
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.    
      *
       T-510-CHEKCHEK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計 参照処理
      *****************************************************************
       T-520-CHEKCHEK-SEC                SECTION.
      *
           INITIALIZE                  SRYACCT-REC.
           MOVE    ZERO                TO  FLG-MCP1.
           MOVE    DID2-REC(1:24)      TO  ACCT-HOSPID.
           MOVE    DID2-REC(194:1)     TO  ACCT-NYUGAIKBN.
           MOVE    DID2-REC(26:10)     TO  ACCT-PTID.
           MOVE    DID2-REC(191:2)     TO  ACCT-SRYKA.
           MOVE    T-SINRYOU-AREA      TO  ACCT-SRYYM.
           MOVE    DID2-REC(171:8)     TO  ACCT-ZAINUM.
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC.
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    "SRYACCT-KEY5"      TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           IF  MCP-RC    =   ZERO
               PERFORM T-520-CHEKCHEK-READ-SEC
               IF  MCP-RC    =   ZERO
                   MOVE    1                   TO  FLG-MCP1
               END-IF
           END-IF.
      *
           INITIALIZE                  MCPAREA.
           MOVE    "DBCLOSE"           TO  MCP-FUNC.
           MOVE    "SRYACCT-KEY5"      TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *****
           INITIALIZE                  SRYACCT-REC.
           MOVE    ZERO                TO  FLG-MCP2.
           MOVE    DID2-REC(1:24)      TO  ACCT-HOSPID.
           MOVE    DID2-REC(194:1)     TO  ACCT-NYUGAIKBN.
           MOVE    DID2-REC(26:10)     TO  ACCT-PTID.
           MOVE    DID2-REC(191:2)     TO  ACCT-SRYKA.
           MOVE    T-SINRYOU-AREA      TO  ACCT-SRYYM.
           MOVE    DID2-REC(181:8)     TO  ACCT-ZAINUM.
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC.
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    "SRYACCT-KEY5"      TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           IF  MCP-RC    =   ZERO
               PERFORM T-520-CHEKCHEK-READ-SEC
               IF  MCP-RC    =   ZERO
                   MOVE    1                   TO  FLG-MCP2
               END-IF
           END-IF.
      *
           INITIALIZE                  MCPAREA.
           MOVE    "DBCLOSE"           TO  MCP-FUNC.
           MOVE    "SRYACCT-KEY5"      TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
       T-520-CHEKCHEK-EXT.
           EXIT.
      *
      *******************
      *
       T-520-CHEKCHEK-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC.
           MOVE    "SRYACCT-KEY5"      TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.    
      *
       T-520-CHEKCHEK-READ-EXT.
           EXIT.
      *
