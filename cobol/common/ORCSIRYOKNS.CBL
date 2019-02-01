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
       PROGRAM-ID.                 ORCSIRYOKNS.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院
      *  コンポーネント名  : 医療観察入院料コード取得サブ
      *  管理者            : 
      *  作成日付    作業者        記述
      *  10/08/24    NACL−小豆沢  新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                        DIVISION.
      *FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-SYSKANRI                PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                         PIC 9(04).
           03  IDX1                        PIC 9(04).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
           COPY    "CPSK5001.INC".
      *
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    医療観察入院料コード取得パラメタ
           COPY    "CPORCSIRYOKNS.INC".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
       PROCEDURE                   DIVISION    USING
           ORCSIRYOKNS-AREA
           SPA-AREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
      *
           PERFORM    200-EDIT-SEC
           .
      *
       000-PROC-EXT.
           EXIT   PROGRAM
           .
      *
      *****************************************************************
      *    医療観察入院料コードセット
      *****************************************************************
       200-EDIT-SEC                    SECTION.
      *
           INITIALIZE                  LNK-IRYOKNS-HENKYAKU-AREA
           MOVE    ZERO                TO  LNK-IRYOKNS-RC
           MOVE    ZERO                TO  IDX
      *
           IF  LNK-IRYOKNS-KBN      =      "4"
      *
      *(8801-0)入院医学管理料のセット
             EVALUATE    LNK-IRYOKNS-NYUIN
      *        急性期入院対象者入院医学管理料
               WHEN    "01"
               WHEN    "02"
               WHEN    "03"
                       ADD     1            TO  IDX
                       MOVE   "188000110"   TO  LNK-IRYOKNS-SRYCD(IDX)
      *        回復期入院対象者入院医学管理料
               WHEN    "04"
               WHEN    "11"
               WHEN    "18"
                       ADD     1            TO  IDX
                       MOVE   "188000510"   TO  LNK-IRYOKNS-SRYCD(IDX)
      *        社会復帰期入院対象者入院医学管理料
               WHEN    "05"
               WHEN    "06"
               WHEN    "07"
               WHEN    "08"
               WHEN    "09"
               WHEN    "10"
               WHEN    "12"
               WHEN    "13"
               WHEN    "14"
               WHEN    "15"
               WHEN    "16"
               WHEN    "17"
                       ADD     1            TO  IDX
                       MOVE   "188000610"   TO  LNK-IRYOKNS-SRYCD(IDX)
             END-EVALUATE
      *
      *
      *(8801-1)未基準減算（病棟に係る基準を満たさない場合）のセット
             INITIALIZE                   SYSKANRI-REC
             MOVE    LNK-IRYOKNS-HOSPNUM
                                      TO  SYS-HOSPNUM
             MOVE    "5001"           TO  SYS-KANRICD
             MOVE    LNK-IRYOKNS-BTUNUM
                                      TO  SYS-KBNCD
             MOVE    LNK-IRYOKNS-SANTEIYM
                                      TO  SYS-STYUKYMD(1:6)
             MOVE    "01"             TO  SYS-STYUKYMD(7:2)
             MOVE    SYS-STYUKYMD     TO  SYS-EDYUKYMD
             MOVE    "tbl_syskanri"   TO  MCP-TABLE
             MOVE    "key10"          TO  MCP-PATHNAME
             PERFORM  910-SYSKANRI-SELECT-SEC
             IF      FLG-SYSKANRI     =   ZERO
               MOVE    "tbl_syskanri" TO  MCP-TABLE
               MOVE    "key10"        TO  MCP-PATHNAME
               PERFORM  910-SYSKANRI-READ-SEC
               IF     FLG-SYSKANRI     =   ZERO
                   PERFORM  VARYING  IDX1  FROM  1  BY  1
                      UNTIL (IDX1     >   14)   OR
                            (SYS-5001-KSNCD(IDX1)  =   SPACE)
                        IF  (SYS-5001-KSNCD(IDX1)  =  "188000270") AND
                            (SYS-5001-KSNKBN(IDX1) =  "2")
                           ADD     1            TO  IDX
                           MOVE   "188000270"   TO  LNK-IRYOKNS-SRYCD
                                                                 (IDX)
                        END-IF
                   END-PERFORM
               END-IF
             END-IF
      *
             MOVE    "tbl_syskanri"      TO  MCP-TABLE
             MOVE    "key10"             TO  MCP-PATHNAME
             PERFORM   900-CLOSE-SEC
      *
      *
      *(8801-2)急性期入院対象者入院医学管理料の未適合減算のセット
             EVALUATE    LNK-IRYOKNS-NYUIN
               WHEN    "02"
      *                未適合減算（入院決定日から９１日以上１年以内）
                       ADD     1            TO  IDX
                       MOVE   "188000370"   TO  LNK-IRYOKNS-SRYCD(IDX)
               WHEN    "03"
      *                未適合減算（入院決定日から１年超）
                       ADD     1            TO  IDX
                       MOVE   "188000470"   TO  LNK-IRYOKNS-SRYCD(IDX)
             END-EVALUATE
      *
      *
      *(8801-2)観察回復期減算のセット（算定開始日から２７１日以上）
             EVALUATE    LNK-IRYOKNS-NYUIN
               WHEN    "11"
                       ADD     1            TO  IDX
                       MOVE   "188006570"   TO  LNK-IRYOKNS-SRYCD(IDX)
             END-EVALUATE
      *
      *
      *(8801-2)観察回復期減算のセット（算定開始日から１年９０日超）
             EVALUATE    LNK-IRYOKNS-NYUIN
               WHEN    "18"
                       ADD     1            TO  IDX
                       MOVE   "188010170"   TO  LNK-IRYOKNS-SRYCD(IDX)
             END-EVALUATE
      *
      *
      *(8801-2)観察社会復帰期減算のセット
             EVALUATE    LNK-IRYOKNS-NYUIN
               WHEN    "06"
               WHEN    "15"
      *                観察社会復帰期減算（算定開始日から１８１日以上
      *                                    １年以内）
                       ADD     1            TO  IDX
                       MOVE   "188000770"   TO  LNK-IRYOKNS-SRYCD(IDX)
               WHEN    "07"
      *                観察社会復帰期減算（算定開始日から１年超
      *                                    １年１８０日以内）
                       ADD     1            TO  IDX
                       MOVE   "188000870"   TO  LNK-IRYOKNS-SRYCD(IDX)
               WHEN    "08"
      *                観察社会復帰期減算（算定開始日から１年１８０日超）
                       ADD     1            TO  IDX
                       MOVE   "188005870"   TO  LNK-IRYOKNS-SRYCD(IDX)
               WHEN    "16"
      *                観察社会復帰期減算（算定開始日から１年超
      *                                    １年１８０日以内・遠隔地加算）
                       ADD     1            TO  IDX
                       MOVE   "188009170"   TO  LNK-IRYOKNS-SRYCD(IDX)
               WHEN    "17"
      *                観察社会復帰期減算（算定開始日から１年１８０日超
      *                                    ・遠隔地加算）
                       ADD     1            TO  IDX
                       MOVE   "188009270"   TO  LNK-IRYOKNS-SRYCD(IDX)
             END-EVALUATE
      *
      *
      *(8801-2)未経過減算のセット
             EVALUATE    LNK-IRYOKNS-NYUIN
               WHEN    "09"
      *                未経過減算（算定開始日１年超、退院許可の申立て
      *                            １８０日以内）
                       ADD     1            TO  IDX
                       MOVE   "188000970"   TO  LNK-IRYOKNS-SRYCD(IDX)
               WHEN    "10"
      *                未経過減算（算定開始日１年１８０日超、退院許可の申立て
      *                        １８０日以内）
                       ADD     1            TO  IDX
                       MOVE   "188005970"   TO  LNK-IRYOKNS-SRYCD(IDX)
             END-EVALUATE
      *
      *
      *(8801-3)社会復帰期移行加算のセット
             EVALUATE    LNK-IRYOKNS-NYUIN
               WHEN    "12"
               WHEN    "14"
                       ADD     1            TO  IDX
                       MOVE   "188006670"   TO  LNK-IRYOKNS-SRYCD(IDX)
             END-EVALUATE
      *
      *
      *(8801-4)遠隔地加算のセット
             EVALUATE    LNK-IRYOKNS-NYUIN
               WHEN    "13"
               WHEN    "14"
               WHEN    "15"
                       ADD     1            TO  IDX
                       MOVE   "188009070"   TO  LNK-IRYOKNS-SRYCD(IDX)
             END-EVALUATE
      *
      *
      *(8801-5)小規格病棟病床数加算のセット
             INITIALIZE                   SYSKANRI-REC
             MOVE    LNK-IRYOKNS-HOSPNUM
                                      TO  SYS-HOSPNUM
             MOVE    "5001"           TO  SYS-KANRICD
             MOVE    LNK-IRYOKNS-BTUNUM
                                      TO  SYS-KBNCD
             MOVE    LNK-IRYOKNS-SANTEIYM
                                      TO  SYS-STYUKYMD(1:6)
             MOVE    "01"             TO  SYS-STYUKYMD(7:2)
             MOVE    SYS-STYUKYMD     TO  SYS-EDYUKYMD
             MOVE    "tbl_syskanri"   TO  MCP-TABLE
             MOVE    "key10"          TO  MCP-PATHNAME
             PERFORM  910-SYSKANRI-SELECT-SEC
             IF      FLG-SYSKANRI     =   ZERO
               MOVE    "tbl_syskanri" TO  MCP-TABLE
               MOVE    "key10"        TO  MCP-PATHNAME
               PERFORM  910-SYSKANRI-READ-SEC
               IF     FLG-SYSKANRI     =   ZERO
                   PERFORM  VARYING  IDX1  FROM  1  BY  1
                      UNTIL (IDX1     >   14)   OR
                            (SYS-5001-KSNCD(IDX1)  =   SPACE)
      *                 小規格病棟病床数加算（１５床）
                        IF  (SYS-5001-KSNCD(IDX1)  =  "188001070") AND
                            (SYS-5001-KSNKBN(IDX1) =  "2")
                           ADD     1            TO  IDX
                           MOVE   "188001070"   TO  LNK-IRYOKNS-SRYCD
                                                                 (IDX)
                        END-IF
      *                 小規格病棟病床数加算（１６床）
                        IF  (SYS-5001-KSNCD(IDX1)  =  "188001170") AND
                            (SYS-5001-KSNKBN(IDX1) =  "2")
                           ADD     1            TO  IDX
                           MOVE   "188001170"   TO  LNK-IRYOKNS-SRYCD
                                                                 (IDX)
                        END-IF
      *                 小規格病棟病床数加算（１７床）
                        IF  (SYS-5001-KSNCD(IDX1)  =  "188001270") AND
                            (SYS-5001-KSNKBN(IDX1) =  "2")
                           ADD     1            TO  IDX
                           MOVE   "188001270"   TO  LNK-IRYOKNS-SRYCD
                                                                 (IDX)
                        END-IF
      *                 小規格病棟病床数加算（１８床）
                        IF  (SYS-5001-KSNCD(IDX1)  =  "188001370") AND
                            (SYS-5001-KSNKBN(IDX1) =  "2")
                           ADD     1            TO  IDX
                           MOVE   "188001370"   TO  LNK-IRYOKNS-SRYCD
                                                                 (IDX)
                        END-IF
      *                 小規格病棟病床数加算（１９床）
                        IF  (SYS-5001-KSNCD(IDX1)  =  "188001470") AND
                            (SYS-5001-KSNKBN(IDX1) =  "2")
                           ADD     1            TO  IDX
                           MOVE   "188001470"   TO  LNK-IRYOKNS-SRYCD
                                                                 (IDX)
                        END-IF
      *                 小規格病棟病床数加算（２０床）
                        IF  (SYS-5001-KSNCD(IDX1)  =  "188001570") AND
                            (SYS-5001-KSNKBN(IDX1) =  "2")
                           ADD     1            TO  IDX
                           MOVE   "188001570"   TO  LNK-IRYOKNS-SRYCD
                                                                 (IDX)
                        END-IF
      *                 小規格病棟病床数加算（２１床）
                        IF  (SYS-5001-KSNCD(IDX1)  =  "188001670") AND
                            (SYS-5001-KSNKBN(IDX1) =  "2")
                           ADD     1            TO  IDX
                           MOVE   "188001670"   TO  LNK-IRYOKNS-SRYCD
                                                                 (IDX)
                        END-IF
      *                 小規格病棟病床数加算（２２床）
                        IF  (SYS-5001-KSNCD(IDX1)  =  "188001770") AND
                            (SYS-5001-KSNKBN(IDX1) =  "2")
                           ADD     1            TO  IDX
                           MOVE   "188001770"   TO  LNK-IRYOKNS-SRYCD
                                                                 (IDX)
                        END-IF
      *                 小規格病棟病床数加算（２３床）
                        IF  (SYS-5001-KSNCD(IDX1)  =  "188001870") AND
                            (SYS-5001-KSNKBN(IDX1) =  "2")
                           ADD     1            TO  IDX
                           MOVE   "188001870"   TO  LNK-IRYOKNS-SRYCD
                                                                 (IDX)
                        END-IF
      *                 小規格病棟病床数加算（２４床）
                        IF  (SYS-5001-KSNCD(IDX1)  =  "188001970") AND
                            (SYS-5001-KSNKBN(IDX1) =  "2")
                           ADD     1            TO  IDX
                           MOVE   "188001970"   TO  LNK-IRYOKNS-SRYCD
                                                                 (IDX)
                        END-IF
      *                 小規格病棟病床数加算（２５床）
                        IF  (SYS-5001-KSNCD(IDX1)  =  "188002070") AND
                            (SYS-5001-KSNKBN(IDX1) =  "2")
                           ADD     1            TO  IDX
                           MOVE   "188002070"   TO  LNK-IRYOKNS-SRYCD
                                                                 (IDX)
                        END-IF
      *                 小規格病棟病床数加算（２６床）
                        IF  (SYS-5001-KSNCD(IDX1)  =  "188002170") AND
                            (SYS-5001-KSNKBN(IDX1) =  "2")
                           ADD     1            TO  IDX
                           MOVE   "188002170"   TO  LNK-IRYOKNS-SRYCD
                                                                 (IDX)
                        END-IF
      *                 小規格病棟病床数加算（２７床）
                        IF  (SYS-5001-KSNCD(IDX1)  =  "188002270") AND
                            (SYS-5001-KSNKBN(IDX1) =  "2")
                           ADD     1            TO  IDX
                           MOVE   "188002270"   TO  LNK-IRYOKNS-SRYCD
                                                                 (IDX)
                        END-IF
      *                 小規格病棟病床数加算（２８床）
                        IF  (SYS-5001-KSNCD(IDX1)  =  "188002370") AND
                            (SYS-5001-KSNKBN(IDX1) =  "2")
                           ADD     1            TO  IDX
                           MOVE   "188002370"   TO  LNK-IRYOKNS-SRYCD
                                                                 (IDX)
                        END-IF
      *                 小規格病棟病床数加算（２９床）
                        IF  (SYS-5001-KSNCD(IDX1)  =  "188002470") AND
                            (SYS-5001-KSNKBN(IDX1) =  "2")
                           ADD     1            TO  IDX
                           MOVE   "188002470"   TO  LNK-IRYOKNS-SRYCD
                                                                 (IDX)
                        END-IF
                   END-PERFORM
               END-IF
             END-IF
      *
             MOVE    "tbl_syskanri"      TO  MCP-TABLE
             MOVE    "key10"             TO  MCP-PATHNAME
             PERFORM   900-CLOSE-SEC
      *
           END-IF
      *
      *
           IF    LNK-IRYOKNS-SRYCD(1)    =   SPACE
               MOVE    1                 TO  LNK-IRYOKNS-RC
           END-IF
      *
           .
       200-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスター検索
      *****************************************************************
       910-SYSKANRI-SELECT-SEC        SECTION.
      *
           MOVE      SYSKANRI-REC         TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC                 =   ZERO
               MOVE    ZERO               TO  FLG-SYSKANRI
           ELSE
               MOVE    1                  TO  FLG-SYSKANRI
           END-IF
      *
           .
       910-SYSKANRI-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスター読込
      *****************************************************************
       910-SYSKANRI-READ-SEC        SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  SYS-5001-REC
               MOVE    ZERO               TO  FLG-SYSKANRI
           ELSE
               INITIALIZE                     SYS-5001-REC
               MOVE    1                  TO  FLG-SYSKANRI
           END-IF
      *
           .
       910-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＳＥＬＥＣＴ処理
      *****************************************************************
       900-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
           IF      MCP-RC              =   ZERO
               CONTINUE
           ELSE
               DISPLAY "SELECT ERR table=" MCP-TABLE
                       " pathname="        MCP-PATHNAME
           END-IF
           .
       900-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＦＥＴＣＨ処理
      *****************************************************************
       900-DBFETCH-SEC                SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルアクセス処理
      *****************************************************************
       900-ORCDBMAIN-SEC               SECTION.
      *
           CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
           .
      *
       900-ORCDBMAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       900-CLOSE-SEC               SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-CLOSE-EXT.
           EXIT.
