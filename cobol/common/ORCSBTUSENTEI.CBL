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
       IDENTIFICATION                      DIVISION.
       PROGRAM-ID.                         ORCSBTUSENTEI.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : 病棟選定入院自己負担取得サブ
      *  返却エラーコード  : 00:正常　99:エラー
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/02/06    NACL-太田     新規作成
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
      *
       DATA                                DIVISION.
      *FILE                                SECTION.
      *
      *
       WORKING-STORAGE                     SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-ERR                     PIC 9(01).
           03  FLG-SYSKANRI                PIC 9(01).
           03  FLG-PTNYUINRRK              PIC 9(01).
           03  FLG-DBRC                    PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                        PIC 9(05).
           03  IDX2                        PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-YMD                     PIC X(10). 
           03  WRK-HENYMDG                 PIC X(09).
           03  WRK-SYMD.
               05  WRK-SYY                 PIC 9(04).
               05  WRK-SMM                 PIC 9(02).
               05  WRK-SDD                 PIC 9(02).
           03  WRK-DBPATH                  PIC X(20).
           03  WRK-STYMD                   PIC X(08).
           03  WRK-EDYMD                   PIC X(08).
           03  WRK-NISSU1                  PIC 9(05).
           03  WRK-NISSU2                  PIC 9(05).
           03  WRK-MMSTYMD                 PIC X(08).
           03  WRK-MMEDYMD                 PIC X(08).
           03  WRK-STIDX                   PIC 9(02).
           03  WRK-EDIDX                   PIC 9(02).
           03  WRK-CHK-BTUNUM              PIC X(02).
           03  WRK-CHK-YMD                 PIC X(08).
      *
       01  SRH-5001-AREA.
           03  SRH-5001-OCC                OCCURS  300
                                           INDEXED BY SRH-5001-IDX.
               05  SRH-5001-BTUNUM         PIC X(02).
               05  SRH-5001-STYUKYMD       PIC X(08).
               05  SRH-5001-EDYUKYMD       PIC X(08).
               05  SRH-5001-FTNKBN         PIC X(01).
               05  SRH-5001-TAXKBN         PIC X(01).
               05  SRH-5001-TANKA          PIC 9(02).
               05  SRH-5001-KINGAKU        PIC 9(04).
      *
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *    （病棟情報）
           COPY    "CPSK5001.INC".
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
           COPY    "CPORCSGDAY.INC".
      *
      *    共通領域
           COPY    "ORCA-DBPATH".
           COPY    "MCPAREA".
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                             SECTION.
      *
           COPY    "CPORCSBTUSENTEI.INC".
      *
       PROCEDURE                           DIVISION    USING
           ORCSBTUSENTEIAREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                        SECTION.
      *
           INITIALIZE                      WRK-AREA
           INITIALIZE                      FLG-AREA
           INITIALIZE                      IDX-AREA
           INITIALIZE                      SBTUSENTEI-OUT-AREA
           INITIALIZE                      SBTUSENTEI-RC
      *
           MOVE    ZERO                TO  FLG-ERR
      *
      *    パラメータチェック
           PERFORM 100-PRM-CHK-SEC
           IF    ( SBTUSENTEI-RC        NOT =   ZERO )
               GO  TO  000-PROC-EXT
           END-IF
      *
      *    主処理
           PERFORM 200-MAIN-SEC
           IF    ( SBTUSENTEI-RC        NOT =   ZERO )
               GO  TO  000-PROC-EXT
           END-IF
      *
           .
       000-PROC-EXT.
           EXIT.
      *
           EXIT PROGRAM
           .
      *
      *****************************************************************
      *    パラメータチェック
      *****************************************************************
       100-PRM-CHK-SEC                     SECTION.
      *
           IF    ( SBTUSENTEI-SRYYM    =   SPACE )
               MOVE    99              TO  SBTUSENTEI-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
           MOVE    SBTUSENTEI-SRYYM    TO  WRK-YMD
           MOVE    "01"                TO  WRK-YMD (7:2)
           PERFORM 800-HIZUKE-CHK-SEC
           IF    ( SBTUSENTEI-RC       NOT =   ZERO )
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
           .
       100-PRM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                        SECTION.
      *
      *    月初日編集
           MOVE    SBTUSENTEI-SRYYM    TO  WRK-MMSTYMD
           MOVE    "01"                TO  WRK-MMSTYMD (7:2)
      *
      *    月末日取得処理
           MOVE    SBTUSENTEI-SRYYM    TO  WRK-YMD
           PERFORM 2100-GETUMATU-GET-SEC
           MOVE    WRK-YMD             TO  WRK-MMEDYMD
      *
      *    病棟情報取得
           PERFORM 2100-SYS-5001-GET-SEC
           IF    ( SBTUSENTEI-RC       NOT =   ZERO )
               GO  TO  200-MAIN-EXT
           END-IF
      *
      *    入院履歴編集処理
           PERFORM 2100-PTNYUINRRK-EDIT-SEC
           IF    ( SBTUSENTEI-RC       NOT =   ZERO )
               GO  TO  200-MAIN-EXT
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    月末日取得処理
      *****************************************************************
       2100-GETUMATU-GET-SEC           SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY1-AREA
           MOVE    "71"                TO   LNK-DAY7-IRAI
           MOVE    WRK-YMD (1:6)       TO   LNK-DAY7-YM
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                       LNK-DAY7-AREA
           MOVE    LNK-DAY7-KOYOMI     TO  WRK-YMD
      *
           .
       2100-GETUMATU-GET-EXT.
            EXIT.
      *****************************************************************
      *    病棟情報取得
      *****************************************************************
       2100-SYS-5001-GET-SEC               SECTION.
      *
           INITIALIZE                      SRH-5001-AREA
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           INITIALIZE                      SYSKANRI-REC
           MOVE    "5001"              TO  SYS-KANRICD
           MOVE    WRK-MMEDYMD         TO  SYS-STYUKYMD
           MOVE    WRK-MMSTYMD         TO  SYS-EDYUKYMD
           MOVE    PATH-TBL-SYSKANRI-KEY2
                                       TO  MCP-PATH
           MOVE     SYSKANRI-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
      **   有効期間の開始日・終了日を個別に指定したい為に
      **   MCPSUBを直接呼んでいるので注意
           CALL    "MCPSUB"                USING
                                           MCPAREA
                                           MCPDATA-REC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-SYSKANRI
           ELSE
               MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
               IF    ( FLG-DBRC    NOT =   ZERO )
                   MOVE    1           TO  FLG-SYSKANRI
               END-IF
           END-IF
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( FLG-SYSKANRI    NOT =   ZERO )
                   OR    ( IDX1    >       300 )
      *
               MOVE    MCPDATA-REC         TO  SYS-5001-REC
      *
               MOVE    SYS-5001-KBNCD      TO  SRH-5001-BTUNUM  (IDX1)
               MOVE    SYS-5001-STYUKYMD   TO  SRH-5001-STYUKYMD(IDX1)
               MOVE    SYS-5001-EDYUKYMD   TO  SRH-5001-EDYUKYMD(IDX1)
      *
               EVALUATE SYS-5001-SENTEI-FTNKBN
               WHEN    "1"
                   MOVE    SYS-5001-SENTEI-FTNKBN
                                           TO  SRH-5001-FTNKBN (IDX1)
                   MOVE    SYS-5001-SENTEI-TANKA
                                           TO  SRH-5001-TANKA  (IDX1)
                   MOVE    SYS-5001-SENTEI-TAXKBN
                                           TO  SRH-5001-TAXKBN (IDX1)
                   MOVE     ZERO           TO  SRH-5001-KINGAKU(IDX1)
               WHEN    "2"
                   MOVE    SYS-5001-SENTEI-FTNKBN
                                           TO  SRH-5001-FTNKBN (IDX1)
                   MOVE    ZERO            TO  SRH-5001-TANKA  (IDX1)
                   MOVE    SYS-5001-SENTEI-TAXKBN
                                           TO  SRH-5001-TAXKBN (IDX1)
                   MOVE    SYS-5001-SENTEI-KINGAKU
                                           TO  SRH-5001-KINGAKU(IDX1)
               WHEN    OTHER
                   MOVE    "1"             TO  SRH-5001-FTNKBN (IDX1)
                   MOVE     10             TO  SRH-5001-TANKA  (IDX1)
                   MOVE     "0"            TO  SRH-5001-TAXKBN (IDX1)
                   MOVE     ZERO           TO  SRH-5001-KINGAKU(IDX1)
               END-EVALUATE
      *
               MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
               IF    ( FLG-DBRC    NOT =   ZERO )
                   MOVE    1           TO  FLG-SYSKANRI
               END-IF
      *
           END-PERFORM
      *
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       2100-SYS-5001-GET-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴編集処理
      *****************************************************************
       2100-PTNYUINRRK-EDIT-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-PTNYUINRRK
      *
           INITIALIZE  PTNYUINRRK-REC
           MOVE    SBTUSENTEI-HOSPID   TO  PTNYUINRRK-HOSPID
           MOVE    SBTUSENTEI-PTID     TO  PTNYUINRRK-PTID
           MOVE    WRK-MMEDYMD         TO  PTNYUINRRK-NYUINYMD
           MOVE    WRK-MMSTYMD         TO  PTNYUINRRK-TAIINYMD
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "PTNYUINRRK-KEY11"  TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    NOT =   ZERO )
               MOVE    1               TO  FLG-PTNYUINRRK
           END-IF
      *
           PERFORM UNTIL ( FLG-PTNYUINRRK  NOT =   ZERO )
      *
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
      *
      *        日単位で入院していた病棟の情報を編集する
               PERFORM 2100-DAY-BTUINF-EDIT-SEC
               IF    ( SBTUSENTEI-RC       NOT =   ZERO )
                   GO  TO  2100-PTNYUINRRK-EDIT-EXT
               END-IF
      *
               MOVE    "PTNYUINRRK-KEY11"  TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
               IF    ( FLG-DBRC    NOT =   ZERO )
                   MOVE    1           TO  FLG-PTNYUINRRK
               END-IF
      *
           END-PERFORM
      *
           MOVE    "PTNYUINRRK-KEY11"  TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       2100-PTNYUINRRK-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    日別病棟情報編集する
      *****************************************************************
       2100-DAY-BTUINF-EDIT-SEC             SECTION.
      *
           IF    ( PTNYUINRRK-TENNYUYMD    <   WRK-MMSTYMD )
               MOVE    WRK-MMSTYMD (7:2)   TO  WRK-STIDX
           ELSE
               MOVE    PTNYUINRRK-TENNYUYMD (7:2)
                                           TO  WRK-STIDX
           END-IF
      *
           IF    ( PTNYUINRRK-TENSTUYMD    >   WRK-MMEDYMD )
               MOVE    WRK-MMEDYMD (7:2)   TO  WRK-EDIDX
           ELSE
               MOVE    PTNYUINRRK-TENSTUYMD (7:2)
                                           TO  WRK-EDIDX
           END-IF
      *
           PERFORM VARYING IDX2    FROM    WRK-STIDX   BY  1
                   UNTIL ( IDX2    >   WRK-EDIDX )
      *
               IF    ( SBTUSENTEI-DAY-BTUNUM (IDX2)    =   SPACE )
      *            選定入院料情報設定処理
                   PERFORM 2100-SENTEI-SET-SEC
                   IF    ( SBTUSENTEI-RC       NOT =   ZERO )
                       GO  TO  2100-DAY-BTUINF-EDIT-EXT
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           .
       2100-DAY-BTUINF-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    選定入院料情報設定処理
      *****************************************************************
       2100-SENTEI-SET-SEC                 SECTION.
      *
           MOVE    PTNYUINRRK-BTUNUM   TO  WRK-CHK-BTUNUM
           MOVE    SBTUSENTEI-SRYYM    TO  WRK-CHK-YMD
           MOVE    IDX2 (4:2)          TO  WRK-CHK-YMD (7:2)
      *
           SET     SRH-5001-IDX        TO  1
           SEARCH  SRH-5001-OCC        VARYING SRH-5001-IDX
           AT      END
               MOVE    99              TO  SBTUSENTEI-RC
               GO  TO  2100-SENTEI-SET-EXT
           WHEN  ( SRH-5001-BTUNUM (SRH-5001-IDX)
                                       =   SPACE )
               MOVE    99              TO  SBTUSENTEI-RC
               GO  TO  2100-SENTEI-SET-EXT
           WHEN  ( SRH-5001-BTUNUM (SRH-5001-IDX)
                                       =   WRK-CHK-BTUNUM )
            AND  ( SRH-5001-STYUKYMD (SRH-5001-IDX)
                                       <=  WRK-CHK-YMD )
            AND  ( SRH-5001-EDYUKYMD (SRH-5001-IDX)
                                       >=  WRK-CHK-YMD )
                                       
               MOVE    SRH-5001-BTUNUM (SRH-5001-IDX)
                                       TO  SBTUSENTEI-DAY-BTUNUM (IDX2)
               MOVE    SRH-5001-FTNKBN (SRH-5001-IDX)
                                       TO  SBTUSENTEI-DAY-FTNKBN (IDX2)
               MOVE    SRH-5001-TAXKBN (SRH-5001-IDX)
                                       TO  SBTUSENTEI-DAY-TAXKBN (IDX2)
               MOVE    SRH-5001-TANKA  (SRH-5001-IDX)
                                       TO  SBTUSENTEI-DAY-TANKA  (IDX2)
               MOVE    SRH-5001-KINGAKU(SRH-5001-IDX)
                                       TO  SBTUSENTEI-DAY-KINGAKU(IDX2)
           END-SEARCH
      *
           .
       2100-SENTEI-SET-EXT.
           EXIT.
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       800-HIZUKE-CHK-SEC                  SECTION.
      *
           MOVE    SPACE                   TO  WRK-HENYMDG
                                               WRK-SYMD
      *
           IF    ( WRK-YMD                 =   SPACE )
               GO  TO  800-HIZUKE-CHK-EXT
           END-IF
      *
           INITIALIZE                          ORCSGDAYAREA
           MOVE    WRK-YMD                 TO  SGDAY-INDAY
           CALL    "ORCSGDAY"                  USING
                                               ORCSGDAYAREA
           IF  ( SGDAY-RC                  =   ZERO )
               MOVE    SGDAY-OTDAY         TO  WRK-HENYMDG
               MOVE    SGDAY-SDAY          TO  WRK-SYMD
           ELSE
               MOVE    99                  TO  SBTUSENTEI-RC
           END-IF
           .
       800-HIZUKE-CHK-EXT.
           EXIT.
      *****************************************************************
      *    期間算出処理
      *****************************************************************
       800-KIKAN-CALC-SEC                  SECTION.
      *
           INITIALIZE                      WRK-NISSU1
                                           WRK-NISSU2
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY5-AREA
           MOVE    "51"                TO  LNK-DAY5-IRAI
           MOVE    WRK-STYMD           TO  LNK-DAY5-START
           MOVE    WRK-EDYMD           TO  LNK-DAY5-END
           CALL    "ORCSDAY"               USING
                                           STS-AREA-DAY
                                           LNK-DAY5-AREA
           IF    ( STS-DAY-RC1     NOT =   ZERO )
               MOVE    99              TO  SBTUSENTEI-RC
               GO  TO                      800-KIKAN-CALC-EXT
           END-IF
      *
           MOVE    LNK-DAY5-NISSU1     TO  WRK-NISSU1
           MOVE    LNK-DAY5-NISSU2     TO  WRK-NISSU2
      *
           .
       800-KIKAN-CALC-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       900-TBL-SELECT-SEC                  SECTION.
      *
           MOVE    ZERO                TO  FLG-DBRC
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           PERFORM 910-DB-SELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    WRK-DBPATH      TO  ORC-DBPATH
               PERFORM 910-DB-READ-SEC
               IF    ( MCP-RC          =   ZERO )
                   CONTINUE
               ELSE
                   MOVE    1           TO  FLG-DBRC
               END-IF
           ELSE
               MOVE    1               TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル読込処理
      *****************************************************************
       900-TBL-READ-SEC                    SECTION.
      *
           MOVE    ZERO                TO  FLG-DBRC
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           PERFORM 910-DB-READ-SEC
           IF    ( MCP-RC              =   ZERO )
               CONTINUE
           ELSE
               MOVE    1               TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-READ-EXT.
           EXIT.
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       900-TBL-CLOSE-SEC                   SECTION.
      *
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           PERFORM 910-DB-CLOSE-SEC
      *
           .
       900-TBL-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       910-DB-SELECT-SEC                   SECTION.
      *
           MOVE    "DBSELECT"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           .
      *
       910-DB-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DB-READ-SEC                     SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
      *
       910-DB-READ-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DB-CLOSE-SEC                    SECTION.
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
      *
       910-DB-CLOSE-EXT.
           EXIT.
