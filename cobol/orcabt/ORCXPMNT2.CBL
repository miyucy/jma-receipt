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
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCXPMNT2.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : マスタ更新処理
      *  コンポーネント名  : 更新ファイル作成処理
      *                    : 
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/02/03    NACL-森脇     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    出力：更新ファイル
           SELECT  OUT-FILE        ASSIGN
                                   ASS-OUT
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-OUT.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    更新ファイル
       FD  OUT-FILE.
       01  OUT-REC.
           03  OUT-NAIYO               PIC X(256).
      *
       WORKING-STORAGE             SECTION.
      *
      *    ファイル指定領域
       01  ASS-AREA.
           03  ASS-OUT                 PIC X(256).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-OUT                 PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-PGKANRI             PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-OUT                 PIC 9(06).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-NAIYO               PIC X(256).
      *
      *****************************************************************
      *    ファイル定義
      *****************************************************************
      *
      *    ＰＧ管理情報
       01  PGKANRI-REC.
           COPY    "CPPGKANRI.INC".
      *
      *    共通パラメタ
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
       01  PARA-REC.
           03  PARA-DBFILE             PIC X(13).
      *
       PROCEDURE                   DIVISION
           USING
           PARA-REC.
      ****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
                   UNTIL   FLG-PGKANRI      =   1
      *
           PERFORM 300-END-SEC
      *
           STOP    RUN
      *
           .
      *
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           MOVE    ZERO            TO  FLG-AREA
           MOVE    ZERO            TO  CNT-AREA
           INITIALIZE                  WRK-AREA
      *
      *    DB OPEN
           PERFORM 100-DBOPEN-SEC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "DBOPEN ERR"
           END-IF
      *
      *    ファイル情報
           PERFORM 101-ASSIN-GET-SEC
      *
      *    出力ファイル　初期処理
           OPEN    OUTPUT          OUT-FILE
           IF      STS-OUT         NOT =   ZERO
               DISPLAY "*(ORCXPMNT2)* OUT-FILE OPN STS[" STS-OUT "]"
           END-IF
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイル情報取得
      *****************************************************************
       101-ASSIN-GET-SEC           SECTION.
      *
      *    出力ーファイル
           MOVE    SPACE           TO  ASS-OUT
           STRING  "/home/orca/"       DELIMITED  BY  SIZE
                   PARA-DBFILE         DELIMITED  BY  SPACE
                   "/ORCADBR.OUT"      DELIMITED  BY  SIZE
                                       INTO    ASS-OUT
           END-STRING
      *
           .
       101-ASSIN-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    メイン処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    ＰＧ管理マスタ検索
           INITIALIZE                  PGKANRI-REC
           MOVE    PGKANRI-REC     TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "PGKANRI-KEY2"  TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               PERFORM 910-PGKANRI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-PGKANRI
           END-IF
      *
           PERFORM UNTIL       FLG-PGKANRI =   1
               MOVE    SPACE           TO  WRK-NAIYO
               STRING  PGKANRI-DEBIANVERSION   DELIMITED  BY  SPACE
                       "/"                     DELIMITED  BY  SIZE
                       PGKANRI-SYSTEMVERSION   DELIMITED  BY  SPACE
                       "/"                     DELIMITED  BY  SIZE
                       PGKANRI-PGNAME          DELIMITED  BY  SPACE
                                       INTO    WRK-NAIYO
               END-STRING
      *
               INITIALIZE                  OUT-REC
               MOVE    WRK-NAIYO       TO  OUT-NAIYO
               WRITE                       OUT-REC
               ADD     1               TO  CNT-OUT
      *
               PERFORM 910-PGKANRI-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           MOVE    "PGKANRI-KEY2"  TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
      *
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
      *    DB DISCONNECT
           PERFORM 900-DBDISCONNECT-SEC
      *
      *    出力ファイル　終了処理
           CLOSE   OUT-FILE
      *
           DISPLAY "*(ORCXPMNT2)* OUTPUT /O   CNT[" CNT-OUT "]"
      *****ACCEPT  WRK-IN
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＧ管理ファイル読込
      *****************************************************************
       910-PGKANRI-READ-SEC        SECTION.
      *
           MOVE    "PGKANRI-KEY2"  TO  ORC-DBPATH
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PGKANRI-REC
               MOVE    ZERO            TO  FLG-PGKANRI
           ELSE
               INITIALIZE                  PGKANRI-REC
               MOVE    1               TO  FLG-PGKANRI
           END-IF
      *
           .
       910-PGKANRI-READ-EXT.
           EXIT.
      *
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
           .
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
           .
       900-DBCLOSE-EXT.
           EXIT.
      *
