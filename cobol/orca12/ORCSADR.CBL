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
       IDENTIFICATION                            DIVISION.
       PROGRAM-ID.                               ORCSADR.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 住所検索サブプログラム
      *  コンポーネント名  : 住所検索サブプログラム
      *  管理者            : 
      *  作成日付    作業者        記述
      *  XX.XX.XX    ＮＮＮ        新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-多々納  02/09/03  住所一覧を５０件へ変更
      *****************************************************************
      *
       ENVIRONMENT                               DIVISION.
       CONFIGURATION                             SECTION.
       INPUT-OUTPUT                              SECTION.
       FILE-CONTROL.
      *
       DATA                                      DIVISION.
       FILE                                      SECTION.
      *
       WORKING-STORAGE                           SECTION.
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA                          PIC X(02).
           03  STS-JYUMST                        PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                           PIC X(03).
           03  FLG-JYUSYO                        PIC X(01).
           03  FLG-SYSKANRI                      PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR                           PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDXX                              PIC 9(04).
           03  IDXY                              PIC 9(04).
           03  IDXZ                              PIC 9(04).
      *
      *    ワークエリア
       01  WORK-AREA.
           03  WRK-NUM                           PIC ZZZ9.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *    （周辺町域情報）
           COPY    "CPSK1015.INC".
      *    住所マスタ
       01  ADRS-REC.
           COPY    "CPADRS.INC".
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "MCPAREA".
      *
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                                  SECTION.
      *
      *    患者登録用共通パラメタ
           COPY    "P02COMMON-SPA".
      *
      *    Ｐ０２画面ＳＰＡ
           COPY    "P02SCR-SPA".
      *
      *    Ｐ９９画面エリア
       01  P98-AREA.
           COPY    "P98.INC".
       01  P99-AREA.
           COPY    "P99.INC".
       01  SYS-DATE.
           03  SYS-YMD    PIC X(08).
      *
       PROCEDURE                                 DIVISION    USING
                                                 SPA-P02KYOUTU
                                                 SPA-P02SCRAREA
                                                 P98-AREA
                                                 P99-AREA
                                                 SYS-DATE.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                              SECTION.
      *
           INITIALIZE                            P98-AREA.
           INITIALIZE                            P99-AREA.
           INITIALIZE                            ADRS-REC.
           IF   JPAR-POST  =  SPACE
                IF  SPA-GMN98-MAX                =  0
                   DISPLAY    "P98-DATASET"
                    PERFORM  100-P98DATA-SEC
                END-IF
                PERFORM  100-P98GMN-SEC
           ELSE
                PERFORM  200-P99-SEC
           END-IF
      *
           DISPLAY    "SPA-PAGE=" SPA-GMN98-PAGE
           EXIT  PROGRAM.
      *
      *****************************************************************
      *    Ｐ９８用データセット処理
      *****************************************************************
       100-P98DATA-SEC                           SECTION.
      *
           INITIALIZE                            SPA-GMN98-TABLE.
           MOVE  ZERO                        TO  SPA-GMN98-MAX
           MOVE  ZERO                        TO  SPA-GMN98-PAGE
      *    システム管理より周辺住所を取る
           INITIALIZE                            SYS-1015-REC.
           MOVE  "1015"                          TO  SYS-1015-KANRICD.
           MOVE  SYS-1015-REC                    TO  MCPDATA-REC.
      *
           MOVE  "DBSELECT"                      TO  MCP-FUNC.
           MOVE  SYS-DATE                        TO  ORC-DBYMD.
           MOVE  "SYSKANRI-KEY2"                 TO  ORC-DBPATH.
           CALL  "ORCMCPSUB"                      USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC.
      *
           IF      MCP-RC                        =   ZERO
               MOVE  "SYSKANRI-KEY2"                 TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    ZERO                TO  IDXX
           PERFORM             UNTIL   FLG-SYSKANRI   =   1
                               OR      IDXX           >=  100
               ADD     1                  TO  IDXX
               MOVE    MCPDATA-REC        TO  SYS-1015-REC
               MOVE    SYS-1015-KBNCD     TO SPA-GMN98-KBNCD  (IDXX)
               MOVE    SYS-1015-LPUBCD    TO SPA-GMN98-TLPUBCD(IDXX)
               MOVE    SYS-1015-POST      TO  SPA-GMN98-TPOST (IDXX)
               MOVE    SYS-1015-RENNUM    TO SPA-GMN98-TRENNUM(IDXX)
               MOVE    SYS-1015-TOWNNAMEDSP
                                          TO  SPA-GMN98-TADRS (IDXX)
      *
               MOVE    "SYSKANRI-KEY2"       TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *
           MOVE  "SYSKANRI-KEY2"             TO  ORC-DBPATH
           MOVE  "DBCLOSE"                   TO  MCP-FUNC
           CALL  "ORCMCPSUB"                  USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
      *
           COMPUTE SPA-GMN98-MAX =   (IDXX   -   1)  /   50  +   1    
      *
           IF      IDXX                      >   ZERO
               MOVE    1                         TO  SPA-GMN98-PAGE
           END-IF.
       100-P98DATA-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｐ９８用画面セット処理
      *****************************************************************
       100-P98GMN-SEC                           SECTION.
      *
           MOVE    SPACE               TO  P98
      *
           COMPUTE IDXY    =  (SPA-GMN98-PAGE  -   1)  *   50
      *
           PERFORM VARYING     IDXX    FROM    1   BY  1
                   UNTIL       IDXX    >       50
               COMPUTE IDXZ    =       IDXY    +   IDXX
               MOVE  SPA-GMN98-KBNCD(IDXZ)     TO  P98-TADRS(IDXX)(1:3)
               MOVE  SPA-GMN98-TADRS(IDXZ)     TO  P98-TADRS(IDXX)(5:16)
	   END-PERFORM
           .
      *
       100-P98GMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｐ９９用処理
      *****************************************************************
       200-P99-SEC                               SECTION.
           MOVE  JPAR-POST                       TO  ADRS-POST.
           MOVE  ADRS-REC                        TO  MCPDATA-REC.
           MOVE  "DBSELECT"                      TO  MCP-FUNC.
           MOVE  "ADRS-KEY2"                     TO  ORC-DBPATH.
           CALL  "ORCMCPSUB"                      USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC.
           IF  MCP-RC                            =  ZERO
               MOVE  "DBFETCH"                   TO  MCP-FUNC
               MOVE  "ADRS-KEY2"                 TO  ORC-DBPATH
               CALL  "ORCMCPSUB"                  USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
               MOVE  ZERO                        TO  IDXX
               PERFORM UNTIL      IDXX                >   49    OR
                              MCP-RC  NOT        =   ZERO  
                   COMPUTE  IDXX   =             IDXX  +  1
      *
                   MOVE  MCPDATA-REC             TO  ADRS-REC
                   MOVE  IDXX                    TO  WRK-NUM
                   MOVE  WRK-NUM                 TO  P99-NUM(IDXX)
                   MOVE  ADRS-POST               TO  P99-POST(IDXX)
                   MOVE  ADRS-EDITADRS-NAME      TO  P99-ADRS(IDXX)
      *
                   MOVE  "DBFETCH"               TO  MCP-FUNC
                   MOVE  "ADRS-KEY2"             TO  ORC-DBPATH
                   CALL  "ORCMCPSUB"              USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
      *
               END-PERFORM
               MOVE  IDXX                        TO  JPAR-CNT
               MOVE  IDXX                        TO  P99-ADRSLIST-COUNT
               MOVE  ZERO                        TO  JPAR-ERRCD
               MOVE  P99-ADRS(1)                 TO  JPAR-EDITADRS-NAME
           ELSE
               MOVE  ZERO                        TO  JPAR-CNT
               MOVE  1                           TO  JPAR-ERRCD
           END-IF.
      *
           MOVE  "DBCLOSE"                       TO  MCP-FUNC.
           MOVE  "ADRS-KEY2"                     TO  ORC-DBPATH.
           CALL  "ORCMCPSUB"                      USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC.
       200-P99-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読み込み処理
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
