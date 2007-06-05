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
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCSS003.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 日次統計
      *  コンポーネント名  : 初診／再診カウントサブ
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/04/22    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  03.05.00    NACL-太田    07/06/05  グループ診療対応
      *****************************************************************
      *
      *
       ENVIRONMENT                     DIVISION.
       CONFIGURATION                   SECTION.
       INPUT-OUTPUT                    SECTION.
       FILE-CONTROL.
      *
       DATA                            DIVISION.
      *FILE                            SECTION.
      *
       WORKING-STORAGE                 SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-JYURRK                      PIC 9(01).
           03  FLG-SRYACCT                     PIC 9(01).
           03  FLG-SRYACT                      PIC 9(01).
           03  FLG-TENSU                       PIC 9(01).
           03  FLG-END                         PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                            PIC 9(05).
           03  IDX-ZAINUM                      PIC 9(05).
           03  IDX-SRYCD                       PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYOSAISIN-KBN               PIC X(01).
      *
      *
       01  CONST-AREA.
           03  CONST-ZAINUM-MAX                PIC 9(05)   VALUE 15.
           03  CONST-SRYCD-MAX                 PIC 9(05)   VALUE 5.
      *
      *
           COPY    "CPTTNS.INC".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *
      *    診療会計
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    診療行為
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    受診履歴
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *    点数マスタ−
           COPY    "CPTENSU.INC".
      *
      *
      *
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
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                        SECTION.
      *
      *    初診／再診カウントサブ
           COPY    "CPORCSS003.INC".
           COPY    "COMMON-SPA".
      *
       PROCEDURE                       DIVISION    USING
           SS003-AREA
           SPA-AREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           INITIALIZE                      FLG-AREA
           INITIALIZE                      IDX-AREA
           INITIALIZE                      WRK-AREA
      *    INITIALIZE                      CNT-AREA
      *
           INITIALIZE                      SS003-OT
      *
      *    初期処理
           PERFORM 100-INIT-SEC
      *    主処理
           PERFORM 200-MAIN-SEC
      *    終了処理
           PERFORM 300-END-SEC
      *
           .
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           INITIALIZE                  WRK-SYOSAISIN-KBN
      *
           MOVE    ZERO            TO  FLG-END
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           IF    ( SS003-SYORIKBN  =   ZERO )
               INITIALIZE              TTNS-AREA
           ELSE
               PERFORM 2001-JYURRK-CHK-SEC
               MOVE    WRK-SYOSAISIN-KBN
                                   TO  SS003-SYOSAISIN-KBN
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴チェック処理
      *****************************************************************
       2001-JYURRK-CHK-SEC             SECTION.
      *
      *    受診履歴検索処理
           MOVE    ZERO                TO  FLG-JYURRK
           INITIALIZE                      JYURRK-REC
           MOVE    SS003-HOSPNUM        TO  JYURRK-HOSPNUM
           MOVE    SS003-PTID          TO  JYURRK-PTID
           MOVE    SS003-NYUGAIKBN     TO  JYURRK-NYUGAIKBN
           MOVE    SS003-DENPNUM       TO  JYURRK-DENPNUM
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "tbl_jyurrk"        TO  MCP-TABLE
           MOVE    "key6"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  JYURRK-REC
           ELSE
               MOVE    1               TO  FLG-JYURRK
               INITIALIZE                  JYURRK-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-JYURRK  NOT =   ZERO )
                    OR   ( FLG-END     NOT =   ZERO )
      *
               PERFORM VARYING IDX-ZAINUM  FROM    1   BY  1
                       UNTIL ( IDX-ZAINUM  >  CONST-ZAINUM-MAX )
                        OR   ( FLG-END     NOT =   ZERO )
      *
                   IF    ( JYURRK-ZAINUM (IDX-ZAINUM)  NOT =   ZERO )
                       PERFORM 2001-SRYACCT-CHK-SEC
                   END-IF
      *
               END-PERFORM
      *
               MOVE    "tbl_jyurrk"        TO  MCP-TABLE
               MOVE    "key6"              TO  MCP-PATHNAME
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC TO  JYURRK-REC
               ELSE
                   MOVE    1           TO  FLG-JYURRK
                   INITIALIZE              JYURRK-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    "tbl_jyurrk"        TO  MCP-TABLE
           MOVE    "key6"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       2001-JYURRK-CHK-EXT.
           EXIT.
      *****************************************************************
      *    診療会計チェック処理
      *****************************************************************
       2001-SRYACCT-CHK-SEC            SECTION.
      *
      *    診療会計検索
           MOVE    ZERO                TO  FLG-SRYACCT
           INITIALIZE                      SRYACCT-REC
           MOVE    JYURRK-HOSPNUM       TO  ACCT-HOSPNUM
           MOVE    JYURRK-NYUGAIKBN    TO  ACCT-NYUGAIKBN
           MOVE    JYURRK-PTID         TO  ACCT-PTID
           MOVE    JYURRK-SRYKA        TO  ACCT-SRYKA
           MOVE    JYURRK-SRYYMD(1:6)  TO  ACCT-SRYYM
           MOVE    JYURRK-ZAINUM (IDX-ZAINUM)
                                       TO  ACCT-ZAINUM
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "tbl_sryacct"       TO  MCP-TABLE
           MOVE    "key31"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SRYACCT-REC
           ELSE
               MOVE    1               TO  FLG-SRYACCT
               INITIALIZE                  SRYACCT-REC
           END-IF
      *
      *
           IF   (( ACCT-ZAITEN     NOT =   ZERO )
             AND ( ACCT-ZAIKAISU   NOT =   ZERO )
             AND ( ACCT-SRYKBN         =   "11"
                                       OR  "12" 
                                       OR  "13"
                                       OR  "14" ))
           OR   (( ACCT-ZAITEN         =   ZERO )
             AND ( ACCT-ZAIKAISU   NOT =   ZERO )
             AND(  ACCT-SRYKBN         =   "11"
                                       OR  "12"
                                       OR  "99" ))
      *
               PERFORM 2001-SRYACT-CHK-SEC
      *
           END-IF
      *
           MOVE    "tbl_sryacct"       TO  MCP-TABLE
           MOVE    "key31"             TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       2001-SRYACCT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    診療行為チェック処理
      *****************************************************************
       2001-SRYACT-CHK-SEC             SECTION.
      *
      *    診療行為検索
           MOVE    ZERO                TO  FLG-SRYACT
           INITIALIZE                      SRYACT-REC
           MOVE    ACCT-HOSPNUM         TO  SRY-HOSPNUM
           MOVE    ACCT-NYUGAIKBN      TO  SRY-NYUGAIKBN
           MOVE    ACCT-PTID           TO  SRY-PTID
           MOVE    ACCT-SRYKA          TO  SRY-SRYKA
           MOVE    ACCT-SRYYM          TO  SRY-SRYYM
           MOVE    ACCT-ZAINUM         TO  SRY-ZAINUM
      *
           MOVE    SRYACT-REC          TO  MCPDATA-REC
           MOVE    "tbl_sryact"        TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SRYACT-REC
           ELSE
               MOVE    1               TO  FLG-SRYACT
               INITIALIZE                  SRYACT-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-SRYACT  NOT =   ZERO )
                    OR   ( FLG-END     NOT =   ZERO )
      *
               PERFORM VARYING IDX-SRYCD   FROM    1   BY  1
                       UNTIL ( IDX-SRYCD   >   CONST-SRYCD-MAX )
                        OR   ( SRY-SRYCD (IDX-SRYCD)   =   SPACE)
                        OR   ( FLG-END             NOT =   ZERO )
      *
                   PERFORM 2001-SYOSAISIN-CHK-SEC
      *
               END-PERFORM
      *
               MOVE    SRYACT-REC      TO  MCPDATA-REC
               MOVE    "tbl_sryact"    TO  MCP-TABLE
               MOVE    "key2"          TO  MCP-PATHNAME
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC TO  SRYACT-REC
               ELSE
                   MOVE    1           TO  FLG-SRYACT
                   INITIALIZE              SRYACT-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    "tbl_sryact"    TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       2001-SRYACT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    初再診チェック処理
      *****************************************************************
       2001-SYOSAISIN-CHK-SEC          SECTION.
      *
           MOVE    SRY-SRYCD (IDX-SRYCD)   TO  TTNS-CHK-SRYCD
           MOVE    JYURRK-SRYYMD           TO  TTNS-CHK-YMD
      *
      *    点数マスタ検索
           PERFORM 900-TENSU-KEY-SEL-SEC
      *
      *    初診チェック
           IF   (( TNS-JITUDAY             =   2 )
             AND ( TNS-DAYCNT              =   1 ))
            OR  (  SRY-SRYCD (IDX-SRYCD)   =   "099110001" )
            OR  (  SRY-SRYCD (IDX-SRYCD)   =   "111011810" )
               MOVE    "1"                 TO  WRK-SYOSAISIN-KBN
           END-IF
      *
      *    再診チェック
           IF   (( TNS-JITUDAY             =   2 )
             AND ( TNS-DAYCNT              =   2 ))
            OR  (  SRY-SRYCD (IDX-SRYCD)   =   "112700850"
                                           OR  "099120001"
                                           OR  "099409901"
                                           OR  "099999902"
                                           OR  "112008350"
                                           OR  "112008350"
                                           OR  "112008850"
                                           OR  "112008850"
                                           OR  "112010150"
                                           OR  "112010150"
                                           OR  "112010650"
                                           OR  "112010650"
                                           OR  "112011710"
                                           OR  "112011710"
                                           OR  "112703050"
                                           OR  "112703450"
                                           OR  "112704450"
                                           OR  "112704850"
                                           OR  "112705850" )
               MOVE    "2"                 TO  WRK-SYOSAISIN-KBN
           END-IF
      *
           IF    ( WRK-SYOSAISIN-KBN   NOT =   SPACE )
               MOVE    1                   TO  FLG-END
           END-IF
      *
           .
       2001-SYOSAISIN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
      *
           .
       300-END-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索処理(KEY1)
      *****************************************************************
       900-TENSU-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-TENSU
      *
      *    点数マスタ退避ワークチェック
           PERFORM 9001-TTNS-CHK-SEC
      *
      *    退避ワークに存在しない場合はＤＢを検索
           IF    ( TTNS-FLG            =   ZERO )
      *
               INITIALIZE                      TNS-TENSU-REC
               MOVE    TTNS-CHK-SRYCD      TO  TNS-SRYCD
               MOVE    TTNS-CHK-YMD        TO  TNS-YUKOSTYMD
                                               TNS-YUKOEDYMD
               MOVE    SPA-HOSPNUM         TO  TNS-HOSPNUM
               MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
               MOVE    "tbl_tensu"         TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 910-DBSELECT-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
      *
      *            点数マスタ退避ワークに編集する
                   PERFORM 9001-TTNS-HEN-SEC
               ELSE
                   MOVE    1               TO  FLG-TENSU
                   INITIALIZE                  TNS-TENSU-REC
               END-IF
      *
               MOVE    "tbl_tensu"         TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 910-DBCLOSECURSOR-SEC
           END-IF
      *
           .
      *
       900-TENSU-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ退避ワークチェック処理
      *****************************************************************
       9001-TTNS-CHK-SEC               SECTION.
      *
           MOVE    ZERO                TO  TTNS-FLG
           INITIALIZE                      TNS-TENSU-REC
      *
           PERFORM VARYING TTNS-IDX    FROM    1   BY  1
                   UNTIL ( TTNS-IDX    >   TTNS-MAX )
                    OR   ( TTNS-FLG    =   1 )
               IF    ( TTNS-KEY-SRYCD (TTNS-IDX)
                                       =   TTNS-CHK-SRYCD )
                 AND ( TTNS-KEY-YUKOSTYMD (TTNS-IDX)
                                      <=   TTNS-CHK-YMD )
                 AND ( TTNS-KEY-YUKOEDYMD (TTNS-IDX)
                                      >=   TTNS-CHK-YMD )
                   MOVE    1           TO  TTNS-FLG
                   MOVE    TTNS-DAT (TTNS-IDX)
                                       TO  TNS-TENSU-REC
               END-IF
           END-PERFORM
      *
           .
       9001-TTNS-CHK-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ退避ワーク編集処理
      *****************************************************************
       9001-TTNS-HEN-SEC               SECTION.
      *
           IF    ( TTNS-CONST-MAX  >   TTNS-MAX )
               COMPUTE TTNS-MAX    =   TTNS-MAX    +   1
               MOVE    TNS-SRYCD       TO  TTNS-KEY-SRYCD
                                                   (TTNS-MAX)
               MOVE    TNS-YUKOSTYMD   TO  TTNS-KEY-YUKOSTYMD
                                                   (TTNS-MAX)
               MOVE    TNS-YUKOEDYMD   TO  TTNS-KEY-YUKOEDYMD
                                                   (TTNS-MAX)
               MOVE    TNS-TENSU-REC   TO  TTNS-DAT
                                                   (TTNS-MAX)
           END-IF
      *
           .
       9001-TTNS-HEN-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHも行う)
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHは行わない)
      *****************************************************************
       911-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
      *
       911-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC           SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
      *
       910-DBCLOSECURSOR-EXT.
           EXIT.
