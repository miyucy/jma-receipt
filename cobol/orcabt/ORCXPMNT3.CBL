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
       PROGRAM-ID.                 ORCXPMNT3.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : プログラム更新処理
      *  コンポーネント名  : プログラム複写処理
      *                    : 
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/02/04    NACL-森脇     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-竹田    04/03/31  シェル起動追加他
      *  01.00.02    NACL-伊藤    06/06/05  MONFUNC対応
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    出力：再起動スイッチファイル
           SELECT  OUT-FILE        ASSIGN
                                   ASS-OUT
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-OUT.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    再起動スイッチファイル
       FD  OUT-FILE.
       01  OUT-REC.
           03  OUT-RESTART             PIC X(32).
      *
       WORKING-STORAGE             SECTION.
grpsys*
grpsys COPY    "COMMON-SPA".
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
           03  FLG-RESTART             PIC 9(01).
           03  FLG-ERR                 PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-PGKANRI             PIC 9(06).
           03  CNT-ERR                 PIC 9(06).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-NAIYO               PIC X(256).
      *
           03  WRK-TIME                PIC X(06).
           03  WRK-SYMD.
               05  WRK-SYY             PIC 9(04).
               05  WRK-SMM             PIC 9(02).
               05  WRK-SDD             PIC 9(02).
           03  WRK-SYMD2.
               05  WRK-SYY2            PIC 9(02).
               05  WRK-SMM2            PIC 9(02).
               05  WRK-SDD2            PIC 9(02).
      *
           COPY  "CPMKPASS.INC".
      *
           COPY  "CPSHELLTBL.INC".
      *
           COPY  "ORCA-DBPATH".
      *
       01  SHELL-AREA.
           03  SHELL-NAME          PIC X(39)  VALUE
               "scripts/allways/program_upgrade_copy.sh".
           03  SHELL-NAME1         PIC X(42)  VALUE
               "scripts/allways/program_upgrade_restart.sh".
      *
       01  PARA-AREA.
           03  PARA-RSFILE           PIC X(32).
           03  PARA-DELHOME          PIC X(100).
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
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
       01  PARA-REC.
           03  PARA-RSAREA          PIC X(255).
      *
       PROCEDURE                   DIVISION
           USING
           PARA-REC.
      ****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           DISPLAY "PARA-RSAREA = [" PARA-RSAREA "]"
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
           UNSTRING    PARA-REC    DELIMITED  BY  ","
                                   INTO  PARA-RSFILE
                                         PARA-DELHOME
           END-UNSTRING                                  
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
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    メイン処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
      *    ＰＧ管理マスタ検索
           INITIALIZE                  PGKANRI-REC
grpsys*    MOVE SPA-HOSPNUM TO -HOSPNUM
           MOVE    PGKANRI-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "tbl_pgkanri"       TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
           IF      MCP-RC              =   ZERO
               PERFORM 910-PGKANRI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-PGKANRI
           END-IF
      *
           PERFORM UNTIL       FLG-PGKANRI =   1
               MOVE    SPACE           TO  SHELLTBL
               INITIALIZE              ORCSMKPASSAREA
               MOVE    SHELL-NAME      TO  MKPASS-IN-01
               CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
               MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *
               MOVE    PGKANRI-PGNAME  TO  SHELLTBL-ARG1
               MOVE    PGKANRI-INSTALLDIR
                                       TO  SHELLTBL-ARG2
grpsys*        MOVE SPA-HOSPNUM TO -HOSPNUM
               MOVE    SHELLTBL        TO  MCPDATA-REC
               MOVE    "SHELL"         TO  MCP-FUNC
               MOVE    PATH-SHELL-SHELL
                                       TO  MCP-PATH
               CALL    "MCPSUB"        USING
                                           MCPAREA
                                           MCPDATA-REC
      *
               PERFORM 210-KOUSHIN-SEC
               IF      FLG-RESTART     =   0   AND
                       PGKANRI-RESTARTFLG
                                       =   "T"
                       PERFORM 220-RESTART-WRITE-SEC
                       MOVE  1         TO  FLG-RESTART
               END-IF
      *
               PERFORM 910-PGKANRI-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           MOVE    "tbl_pgkanri"       TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
           .
      *
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *       更新処理
      *****************************************************************
       210-KOUSHIN-SEC                 SECTION.
      *
           ACCEPT  WRK-TIME            FROM    TIME
           MOVE    "T"                 TO  PGKANRI-UPDATEFLG
           MOVE    WRK-TIME            TO  PGKANRI-UPHMS
           MOVE    WRK-SYMD            TO  PGKANRI-UPYMD
      *
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    "tbl_pgkanri"       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
grpsys*    MOVE SPA-HOSPNUM TO -HOSPNUM
           MOVE    PGKANRI-REC         TO  MCPDATA-REC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
           IF      MCP-RC          NOT =   ZERO
               MOVE    1               TO  FLG-ERR
               ADD     1               TO  CNT-ERR
               GO  TO  210-KOUSHIN-EXT
           END-IF
      *
           ADD     1               TO  CNT-PGKANRI
           .
      *
       210-KOUSHIN-EXT.
           EXIT.
      *
      *****************************************************************
      *       ＭＯＮＩＴＯＲ再起動スイッチ出力処理
      *****************************************************************
       220-RESTART-WRITE-SEC           SECTION.
      *
      *    ファイル情報
           MOVE    PARA-RSFILE     TO  ASS-OUT
      *
      *    出力ファイル　オープン
           OPEN    OUTPUT          OUT-FILE
           IF      STS-OUT         NOT =   ZERO
               DISPLAY "*(ORCXPMNT3)* OUT-FILE OPN STS[" STS-OUT "]"
           ELSE
               MOVE    SPACE       TO  OUT-REC
               MOVE    "RESTART"   TO  OUT-RESTART
               WRITE                   OUT-REC
      *
           END-IF
      *
      *    出力ファイル　クローズ
           CLOSE   OUT-FILE
           .
      *
       220-RESTART-WRITE-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
      * オンラインリスタート用シェル起動
           IF      FLG-RESTART         =   1
               MOVE    SPACE           TO  SHELLTBL
               INITIALIZE              ORCSMKPASSAREA
               MOVE    SHELL-NAME1     TO  MKPASS-IN-01
               CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
               MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *
               MOVE    PARA-DELHOME    TO  SHELLTBL-ARG1
grpsys*        MOVE SPA-HOSPNUM TO -HOSPNUM
               MOVE    SHELLTBL        TO  MCPDATA-REC
               MOVE    "SHELL"         TO  MCP-FUNC
               MOVE    PATH-SHELL-SHELL
                                       TO  MCP-PATH
               CALL    "MCPSUB"        USING
                                           MCPAREA
                                           MCPDATA-REC
           END-IF
      *    DB DISCONNECT
           PERFORM 900-DBDISCONNECT-SEC
      *
           DISPLAY "*(ORCXPMNT3)* UPDATE /O   CNT[" CNT-PGKANRI "]"
      *****ACCEPT  WRK-IN
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＧ管理ファイル読込
      *****************************************************************
       910-PGKANRI-READ-SEC            SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           MOVE    "tbl_pgkanri"       TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
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
       100-DBOPEN-SEC                  SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBOPEN"            TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBSTART"           TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBCOMMIT"          TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-AREA
           .
       900-DBCLOSE-EXT.
           EXIT.
      *
