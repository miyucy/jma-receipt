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
       PROGRAM-ID.                 ORCXPMNT1.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : プログラム更新処理
      *  コンポーネント名  : プログラム管理情報取得登録
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/02/02    NACL-森脇     新規作成
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
      *    入力パラメータファイル
           SELECT  IN-FILE         ASSIGN
                                   ASS-IN
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-IN.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    入力ファイル
       FD  IN-FILE.
       01  IN-REC.
           COPY    "CPPGKANRIC.INC".
      *
       WORKING-STORAGE             SECTION.
      *
      *    ファイル指定領域
       01  ASS-AREA.
           03  ASS-IN                  PIC X(256).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-IN                  PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-IN                  PIC 9(01).
           03  FLG-ERR                 PIC 9(01).
           03  FLG-PGKANRI             PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-IN                  PIC 9(06).
           03  CNT-ERR                 PIC 9(06).
           03  CNT-PGKANRI             PIC 9(06).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD.
               05  WRK-SYY             PIC 9(04).
               05  WRK-SMM             PIC 9(02).
               05  WRK-SDD             PIC 9(02).
           03  WRK-SYMD2.
               05  WRK-SYY2            PIC 9(02).
               05  WRK-SMM2            PIC 9(02).
               05  WRK-SDD2            PIC 9(02).
      *
      *****************************************************************
      *    ファイル定義
      *****************************************************************
      *
      *    ＰＧ管理
       01  PGKANRI-REC.
           COPY    "CPPGKANRI.INC".
      *
      *    共通パラメタ
           COPY    "MCPAREA".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
       01  PARA-REC.
           03  PARA-DBFILE             PIC X(256).
      *
       PROCEDURE                   DIVISION
           USING
           PARA-REC.
       .
      ****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
                   UNTIL   FLG-IN      =   1
      *
           PERFORM 300-END-SEC
      *
           STOP    RUN
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
           ACCEPT  WRK-SYMD2       FROM    DATE
           MOVE    WRK-SYMD2       TO  WRK-SYMD (3:)
           ADD     2000            TO  WRK-SYY
      *
      *    ファイル情報
           MOVE    PARA-DBFILE     TO  ASS-IN
      *
      *    入力　初期処理
           OPEN    INPUT           IN-FILE
           IF      STS-IN          NOT =   ZERO
               MOVE    1           TO  FLG-IN
               DISPLAY "*(ORCXPMNT1)* IN-FILE OPN STS[" STS-IN "]"
               GO  TO  100-INIT-EXT
           END-IF
      *
      *    入力ファイル　検索処理
           PERFORM 900-IN-KENSAKU-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    メイン処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           IF      CNT-IN (4:3)        =   ZERO
               DISPLAY "***(ORCXPMNT1)*** CNT-IN[" CNT-IN "]"
           END-IF
      *
      *    項目別処理
           PERFORM 240-KOUMOKU-BETU-SEC
           IF      FLG-ERR         NOT =   ZERO
               COMPUTE CNT-ERR     =   CNT-ERR   +   1
           ELSE
               PERFORM 260-PGKANRI-EXIST-CHK-SEC
               IF      FLG-PGKANRI     =   ZERO
                   COMPUTE CNT-ERR     =   CNT-ERR   +   1
               ELSE
                   PERFORM 280-PGKANRI-INSERT-SEC
               END-IF
           END-IF
      *
      *    入力ファイル　検索処理
           PERFORM 900-IN-KENSAKU-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目別処理
      *****************************************************************
       240-KOUMOKU-BETU-SEC        SECTION.
      *
           IF      PGKANRIC-DEBIANVERSION  =   SPACE
               MOVE    1               TO  FLG-ERR
               GO  TO   240-KOUMOKU-BETU-EXT
           END-IF
      *
           IF      PGKANRIC-SYSTEMVERSION  =   SPACE
               MOVE    1               TO  FLG-ERR
               GO  TO   240-KOUMOKU-BETU-EXT
           END-IF
      *
           IF      PGKANRIC-PGNO           =   SPACE
               MOVE    1               TO  FLG-ERR
               GO  TO   240-KOUMOKU-BETU-EXT
           END-IF
      *
           IF      PGKANRIC-RELEASEYMD     =   SPACE
               MOVE    1               TO  FLG-ERR
               GO  TO   240-KOUMOKU-BETU-EXT
           END-IF
      *
           IF      PGKANRIC-PGNAME         =   SPACE
               MOVE    1               TO  FLG-ERR
               GO  TO   240-KOUMOKU-BETU-EXT
           END-IF
      *
           IF      PGKANRIC-RESTARTFLG     =   SPACE
               MOVE    1               TO  FLG-ERR
               GO  TO   240-KOUMOKU-BETU-EXT
           END-IF
      *
           IF      PGKANRIC-INSTALLDIR     =   SPACE
               MOVE    1               TO  FLG-ERR
               GO  TO   240-KOUMOKU-BETU-EXT
           END-IF
      *
           IF      PGKANRIC-COMMENT        =   SPACE
               MOVE    1               TO  FLG-ERR
               GO  TO   240-KOUMOKU-BETU-EXT
           END-IF
      *
           .
       240-KOUMOKU-BETU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＧ管理存在チェック
      *****************************************************************
       260-PGKANRI-EXIST-CHK-SEC   SECTION.
      *
           INITIALIZE                  PGKANRI-REC
           MOVE    PGKANRIC-DEBIANVERSION
                                   TO  PGKANRI-DEBIANVERSION
           MOVE    PGKANRIC-SYSTEMVERSION
                                   TO  PGKANRI-SYSTEMVERSION
           MOVE    PGKANRIC-PGNO   TO  PGKANRI-PGNO
      *
           MOVE    PGKANRI-REC     TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "PGKANRI-KEY"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "PGKANRI-KEY"   TO  ORC-DBPATH
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
           ELSE
               MOVE    1               TO  FLG-PGKANRI
           END-IF
      *
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           MOVE    "PGKANRI-KEY"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       260-PGKANRI-EXIST-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＧ管理情報　登録処理
      *****************************************************************
       280-PGKANRI-INSERT-SEC      SECTION.
      *
           MOVE    PGKANRIC-DEBIANVERSION
                                   TO  PGKANRI-DEBIANVERSION
           MOVE    PGKANRIC-SYSTEMVERSION
                                   TO  PGKANRI-SYSTEMVERSION
           MOVE    PGKANRIC-PGNO   TO  PGKANRI-PGNO
           MOVE    PGKANRIC-RELEASEYMD
                                   TO  PGKANRI-RELEASEYMD
           MOVE    PGKANRIC-PGNAME TO  PGKANRI-PGNAME
           MOVE    "F"             TO  PGKANRI-UPDATEFLG 
           MOVE    PGKANRIC-RESTARTFLG
                                   TO  PGKANRI-RESTARTFLG
           MOVE    PGKANRIC-INSTALLDIR
                                   TO  PGKANRI-INSTALLDIR
           MOVE    PGKANRIC-COMMENT
                                   TO  PGKANRI-COMMENT
           MOVE    SPACE           TO  PGKANRI-TERMID
           MOVE    SPACE           TO  PGKANRI-OPID
           MOVE    WRK-SYMD        TO  PGKANRI-CREYMD
           MOVE    SPACE           TO  PGKANRI-UPYMD
           MOVE    SPACE           TO  PGKANRI-UPHMS
      *
           MOVE    PGKANRI-REC     TO  MCPDATA-REC
           MOVE    "DBINSERT"      TO  MCP-FUNC
           MOVE    "PGKANRI-KEY"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
                MOVE    6              TO  FLG-ERR
                GO  TO  280-PGKANRI-INSERT-EXT
           END-IF
           ADD     1               TO  CNT-PGKANRI
      *
           .
       280-PGKANRI-INSERT-EXT.
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
      *    帳票出力　終了処理
           CLOSE   IN-FILE
      *
           DISPLAY "*(ORCXPMNT1)* IN      /I CNT[" CNT-IN      "]"
           DISPLAY "*(ORCXPMNT1)* PGKANRI /O CNT[" CNT-PGKANRI "]"
           DISPLAY "*(ORCXPMNT1)* ERR     /O CNT[" CNT-ERR     "]"
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力ファイル検索処理
      *****************************************************************
       900-IN-KENSAKU-SEC          SECTION.
      *
          MOVE    SPACE            TO  IN-REC
      *
          READ    IN-FILE
              AT  END
                  MOVE    1                TO  FLG-IN
              NOT AT  END
                  MOVE    ZERO             TO  FLG-IN
                  ADD     1                TO  CNT-IN
          END-READ
      *
          .
       900-IN-KENSAKU-EXT.
          EXIT.
      *
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC              SECTION.
      *
           MOVE    "DBOPEN"        TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "DBOPEN ERROR"
           END-IF
      *
           MOVE    "DBSTART"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "DBSTART ERROR"
           END-IF
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC        SECTION.
      *
           MOVE    "DBCOMMIT"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "DBCOMMIT ERROR"
           END-IF
      *
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "DBDISCONNECT ERROR"
           END-IF
           .
       900-DBCLOSE-EXT.
           EXIT.
      *
