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
       PROGRAM-ID.                 ORCXRMST1.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : マスタ更新処理
      *  コンポーネント名  : 更新ファイル作成処理
      *                    : 
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/02/22    MCC-多々納    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-多々納  02/09/18  バージョン判定変更
      *  01.00.02    NACL-伊藤    05/04/05  マスタ単位に変更
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    入力：パラメータファイル
           SELECT  IN-FILE       ASSIGN
                                   ASS-IN
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-IN.
      *    出力：更新ファイル
           SELECT  OUT-FILE        ASSIGN
                                   ASS-OUT
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-OUT.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    入力ファイル
       FD  IN-FILE.
       01  IN-REC.
           03  IN-MASTER-KBN           PIC X(02).
           03  IN-MASTER-DELI          PIC X(01).
           03  IN-DBRVERVION           PIC X(21).
           03  IN-DBRNAME              PIC X(60).
           03  IN-UPFILE               PIC X(100).
           03  IN-UPPG                 PIC X(10).
      *
      *    更新ファイル
       FD  OUT-FILE.
       01  OUT-REC.
           03  OUT-MASTER-KBN          PIC X(02).
           03  OUT-MASTER-DELI         PIC X(01).
           03  OUT-DBRVERVION          PIC X(21).
           03  OUT-UPPG                PIC X(10).
           03  OUT-UPFILE              PIC X(100).
      *
       WORKING-STORAGE             SECTION.
      *
      *    ファイル指定領域
       01  ASS-AREA.
           03  ASS-IN                  PIC X(256).
           03  ASS-OUT                 PIC X(256).
           03  ASS-ERR                 PIC X(256).
           03  ASS-PLF                 PIC X(256).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-IN                  PIC X(02).
           03  STS-OUT                 PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-IN                  PIC 9(01).
           03  FLG-DBKANRI             PIC 9(01).
      *
           03  FLG-SYORI               PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-PARA                PIC 9(06).
           03  CNT-IN                  PIC 9(06).
           03  CNT-OUT                 PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                     PIC 9(04).
           03  IDY                     PIC 9(04).
           03  IDZ                     PIC 9(04).
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
           03  WRK-DBRVERSION          PIC X(64).
      *
           03  WRK-DBKANRI-VERSION     PIC X(64).
      *
           03  WRK-IN                  PIC X(01). 
      *
           03  WRK-TBL-DBRVERSION   OCCURS 100   INDEXED DBR-IDX.
               05  WRK-TBL-MASTER-KBN  PIC X(02).
               05  WRK-TBL-DBRVERSION1 PIC X(64).
               05  WRK-TBL-UPDATE-FLG  PIC X(01).
      *****************************************************************
      *    ファイル定義
      *****************************************************************
      *
      *    ＤＢ管理情報
       01  DBKANRI-REC.
           COPY    "CPDBKANRI.INC".
      *
      *
      *    共通パラメタ
           COPY    "ORCA-DBPATH".
           COPY    "MCPAREA".
           COPY    "MCPDATA.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
       01  PARA-REC.
           03  PARA-DBFILE             PIC X(13).
      *
       PROCEDURE                       DIVISION
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
                   UNTIL   FLG-IN      =   1
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
           MOVE    ZERO            TO  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
      *    DB OPEN
           PERFORM 100-DBOPEN-SEC
           IF      MCP-RC      NOT =   ZERO
               DISPLAY "DBOPEN ERR"
           END-IF.
      *
      *    ファイル情報
           PERFORM 101-ASSIN-GET-SEC
      *
      *    入力　初期処理
           OPEN    INPUT           IN-FILE
           IF      STS-IN          NOT =   ZERO
               MOVE    1           TO  FLG-IN
               DISPLAY "*(ORCXRMST1)* IN-FILE OPN STS["
                                       STS-IN "]"
           END-IF
      *
      *    出力ファイル　初期処理
           OPEN    OUTPUT          OUT-FILE
           IF      STS-OUT         NOT =   ZERO
               DISPLAY "*(ORCXRMST1)* OUT-FILE OPN STS["
                                       STS-OUT "]"
           END-IF
      *
      *    DBKANRI レコードバージョンのテーブル溜め込み
           PERFORM 101-DBR-TBL-SET-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイル情報取得
      *****************************************************************
       101-ASSIN-GET-SEC                SECTION.
      *
      *    入力ファイル
           MOVE    SPACE               TO  ASS-IN
           STRING  "/home/orca/"       DELIMITED  BY  SIZE
                   PARA-DBFILE         DELIMITED  BY  SPACE
      ************ "/ORCADBR.DAT"      DELIMITED  BY  SIZE
      * 2.5.0del * "/ORCADBR-1.DAT"    DELIMITED  BY  SIZE
                   "/ORCADBR-2.DAT"    DELIMITED  BY  SIZE
                                       INTO    ASS-IN
           END-STRING
      *
      *    出力ーファイル
           MOVE    SPACE               TO  ASS-OUT
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
      *    DBKANRI レコードバージョンのテーブル溜め込み処理
      *****************************************************************
       101-DBR-TBL-SET-SEC              SECTION.
      *
      *    ＤＢ管理マスタ検索
           INITIALIZE                  DBKANRI-REC
           MOVE    DBKANRI-REC         TO  MCPDATA-REC
           MOVE    PATH-TBL-DBKANRI-ALL
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               PERFORM 910-DBKANRI-READ-SEC
           ELSE
               INITIALIZE                      DBKANRI-REC
               MOVE    1                   TO  FLG-DBKANRI
           END-IF
      *
           MOVE    SPACE               TO  WRK-DBKANRI-VERSION
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  IDY
           MOVE    ZERO                TO  IDZ
           PERFORM UNTIL   FLG-DBKANRI     =   1
               IF      DBKANRI-KANRICD(7:2)    NUMERIC
                   ADD   1             TO  IDX
                   MOVE DBKANRI-KANRICD(7:2)
                                       TO  WRK-TBL-MASTER-KBN (IDX)
                   MOVE DBKANRI-DBRVERSION1
                                       TO  WRK-TBL-DBRVERSION1(IDX)
                   MOVE SPACE          TO  WRK-TBL-UPDATE-FLG (IDX)
               END-IF
               IF      DBKANRI-KANRICD(1:8) =  "ORCADB00"
                   PERFORM VARYING     IDZ     FROM    1   BY  1
                       UNTIL       IDZ     >   64
                     IF    (DBKANRI-VERSION(IDZ:1)   NOT =   SPACE)
                         ADD   1       TO  IDY
                         MOVE  DBKANRI-VERSION(IDZ:1)
                                       TO  WRK-DBKANRI-VERSION(IDY:1)
                     END-IF
                   END-PERFORM
               END-IF
               MOVE    PATH-TBL-DBKANRI-ALL    TO  MCP-PATH
               PERFORM 910-DBKANRI-READ-SEC
           END-PERFORM
      *
           .
       101-DBR-TBL-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    メイン処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
      *    レコード管理ファイル読込み
           PERFORM 900-IN-READ-SEC
           PERFORM
               UNTIL    FLG-IN         =   1
               MOVE     SPACE          TO  WRK-DBRVERSION
      *        該当マスタのレコードバージョン取得
               SET      DBR-IDX        TO  1
               SEARCH   WRK-TBL-DBRVERSION   VARYING   DBR-IDX
                     AT END
                        MOVE  SPACE    TO  WRK-DBRVERSION
                     WHEN     IN-MASTER-KBN
                                       =   WRK-TBL-MASTER-KBN(DBR-IDX)
                        MOVE  WRK-TBL-DBRVERSION1(DBR-IDX)
                                       TO  WRK-DBRVERSION
               END-SEARCH
               IF      WRK-DBRVERSION  NOT =   SPACE
      *        ＤＢレコードバージョンまで出力する
                 IF    IN-DBRVERVION       >   WRK-DBRVERSION
                   MOVE    1               TO  FLG-SYORI
                   IF      IN-DBRVERVION(3:IDY)
                                           >   WRK-DBKANRI-VERSION
                                                       (1:IDY)
                       CONTINUE
                   ELSE
                       PERFORM 210-OUTFILE-SEC
                       MOVE    IN-DBRVERVION
                                       TO  WRK-TBL-DBRVERSION1(DBR-IDX)
                       MOVE    "1"     TO  WRK-TBL-UPDATE-FLG(DBR-IDX)
                   END-IF
                 END-IF
               END-IF
      *
      *        レコード管理ファイル読込み
               PERFORM 900-IN-READ-SEC
           END-PERFORM
      *
      *    ＤＢ管理マスタ更新
           PERFORM     VARYING  IDX
                       FROM     1     BY   1
                       UNTIL    IDX   =    100   OR
                                WRK-TBL-MASTER-KBN(IDX) = SPACE
             IF      WRK-TBL-UPDATE-FLG(IDX)  =  "1"
               INITIALIZE              DBKANRI-REC
               MOVE    "ORCADB"        TO  DBKANRI-KANRICD
               MOVE    WRK-TBL-MASTER-KBN(IDX)
                                       TO  DBKANRI-KANRICD(7:2)
               MOVE    DBKANRI-REC     TO  MCPDATA-REC
               MOVE    PATH-TBL-DBKANRI-KEY
                                       TO  MCP-PATH
               PERFORM 910-DBSELECT-SEC
               IF      MCP-RC           =  ZERO
                   PERFORM 910-DBKANRI-READ-SEC
               ELSE
                   INITIALIZE              DBKANRI-REC
                   MOVE    1           TO  FLG-DBKANRI
               END-IF
      *
               IF      FLG-DBKANRI      =  ZERO
                   MOVE    WRK-TBL-DBRVERSION1(IDX)
                                       TO  DBKANRI-DBRVERSION2
                   MOVE    DBKANRI-REC TO  MCPDATA-REC
                   MOVE    "DBUPDATE"  TO  MCP-FUNC
                   MOVE    PATH-TBL-DBKANRI-KEY
                                       TO  MCP-PATH
                   CALL    "MCPSUB"        USING
                                           MCPAREA
                                           MCPDATA-REC
                   IF      MCP-RC   NOT =  ZERO
                     DISPLAY "ORCXRMST1 DBKANRI UPD ERR:" MCP-RC
                   END-IF
               END-IF
             END-IF
           END-PERFORM
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新ファイル出力  処理
      *****************************************************************
       210-OUTFILE-SEC               SECTION.
      *
           INITIALIZE                  OUT-REC
           MOVE    IN-MASTER-KBN       TO  OUT-MASTER-KBN
           MOVE    ":"                 TO  OUT-MASTER-DELI
           MOVE    IN-DBRVERVION       TO  OUT-DBRVERVION
      *
           MOVE    IN-UPFILE           TO  OUT-UPFILE
           MOVE    IN-UPPG             TO  OUT-UPPG
           WRITE                       OUT-REC
           ADD     1                   TO  CNT-OUT
      *
           .
       210-OUTFILE-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
      *    DB DISCONNECT
           PERFORM 900-DBDISCONNECT-SEC
      *
      *    出力ファイル　終了処理
           CLOSE                       IN-FILE
           CLOSE                       OUT-FILE
      *
           DISPLAY "*(ORCXRMST1)* INPUT  /I   CNT[" CNT-IN  "]"
           DISPLAY "*(ORCXRMST1)* OUTPUT /O   CNT[" CNT-OUT "]"
      *****ACCEPT  WRK-IN
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力ファイル読込み処理
      *****************************************************************
       900-IN-READ-SEC          SECTION.
      *
          READ    IN-FILE
              AT  END
                  MOVE    1               TO  FLG-IN
              NOT AT  END
                  MOVE    ZERO            TO  FLG-IN
                  ADD     1               TO  CNT-IN
          END-READ
      *
          .
       900-IN-READ-EXT.
          EXIT.
      *****************************************************************
      *    ＤＢ管理ファイル読込
      *****************************************************************
       910-DBKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MCPSUB"             USING
                                        MCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  DBKANRI-REC
               MOVE    ZERO                TO  FLG-DBKANRI
           ELSE
               INITIALIZE                  DBKANRI-REC
               MOVE    1                   TO  FLG-DBKANRI
           END-IF
      *
           .
       910-DBKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    ZERO            TO  MCP-RC
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
      *
           MOVE    "DBOPEN"            TO  MCP-FUNC.
           CALL    "MCPSUB"             USING
                                        MCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "MCPSUB"             USING
                                        MCPAREA
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
           CALL    "MCPSUB"             USING
                                        MCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "MCPSUB"             USING
                                        MCPAREA
                                        MCPDATA-REC.
           .
       900-DBCLOSE-EXT.
           EXIT.
      *
