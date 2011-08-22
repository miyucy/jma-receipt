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
       PROGRAM-ID.             ORCDBNACCT.
      *****************************************************************
      *  システム名        : ORCA
      *  サブシステム名    : 
      *  コンポーネント名  : ORCA DB 入院会計アクセスモジュール
      *  返却エラーコード  : 
      *  管理者            : 
      *  作成日付    作業者        記述
      *  11/08/22    NACL-小豆沢   新規作成
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                    DIVISION.
      *FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-NYUINACCT       PIC 9(01).
           03  FLG-NYUINACCT-SKJ   PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                PIC 9(05).
           03  IDX-DAY             PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-PATHNAME            PIC X(64).
           03  WRK-FUNC                PIC X(64).
           03  WRK-TABLE               PIC X(64).
           03  WRK-RENNUMMAX           PIC 9(03).
      *
           03  WRK-SKJ-AREA.
               05  WRK-SKJ-TBL         OCCURS  3.
                   07  WRK-SKJ         PIC 9(03)   OCCURS  31.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    入院会計
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    入院会計（食事情報取得用）
       01  NACCT-SKJ-REC.
           COPY    "CPNYUINACCT.INC"  REPLACING  //NACCT-//  BY
                                                 //NACCT-SKJ-//.
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK5000.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *    共通領域
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *
       PROCEDURE                    DIVISION    USING
           MCPAREA
           MCPDATA-REC
           SPA-AREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                 SECTION.
      *
           INITIALIZE                  WRK-AREA
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
      *
           MOVE    MCP-TABLE           TO  WRK-TABLE
           MOVE    MCP-PATHNAME        TO  WRK-PATHNAME
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-EDIT-NYUINACCT-SEC
      *
           .
      *
           EXIT PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           .
      *
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    入院診療会計編集処理
      *****************************************************************
       200-EDIT-NYUINACCT-SEC            SECTION.
      *
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    MCPDATA-REC         TO  NYUINACCT-REC
      *
           EVALUATE    MCP-FUNC
           WHEN    "DBFETCH"
               CALL    "MONFUNC"   USING
                                   MCPAREA
                                   MCPDATA-REC
               IF    ( MCP-RC  =   ZERO )
                   MOVE    MCPDATA-REC   TO   NYUINACCT-REC
                   IF    NACCT-SRYCDTOTAL  =  190120410
                       PERFORM 2001-EDIT-NYUINACCT-SEC
                   END-IF
               END-IF
           END-EVALUATE
      *
           MOVE    NYUINACCT-REC     TO  MCPDATA-REC
      *
           .
       200-EDIT-NYUINACCT-EXT.
           EXIT.
      *****************************************************************
      *    栄養管理実施加算の入院会計編集処理
      *****************************************************************
       2001-EDIT-NYUINACCT-SEC          SECTION.
      *
      *    システム管理５０００の栄養管理実施加算算定区分の検索
           MOVE    ZERO                TO  FLG-SYSKANRI
           INITIALIZE                      SYSKANRI-REC
           MOVE    NACCT-HOSPNUM       TO  SYS-HOSPNUM
           MOVE    "5000"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    NACCT-SRYYM         TO  SYS-STYUKYMD(1:6)
           MOVE    "01"                TO  SYS-STYUKYMD(7:2)
           MOVE    SYS-STYUKYMD        TO  SYS-EDYUKYMD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-5000-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYS-5000-REC
           END-IF
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
      *    食無し日は栄養管理実施加算を算定しない設定時は食事を
      *    検索し、対象日のカレンダーをゼロとする
           IF       SYS-5000-EIYOUKSNKBN   =    "1"
      *        食事の剤取得
               MOVE    SPACE               TO  WRK-SKJ-AREA
               INITIALIZE                      WRK-SKJ-AREA
               MOVE    ZERO                TO  FLG-NYUINACCT-SKJ
               INITIALIZE                      NACCT-SKJ-REC
               MOVE    NACCT-HOSPNUM       TO  NACCT-SKJ-HOSPNUM
               MOVE    NACCT-PTID          TO  NACCT-SKJ-PTID
               MOVE    NACCT-SRYYM         TO  NACCT-SKJ-SRYYM
               MOVE    NACCT-SRYYM         TO  SYS-STYUKYMD(1:6)
               MOVE    NACCT-SKJ-REC       TO  MCPDATA-REC
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key33"             TO  MCP-PATHNAME
               PERFORM 910-DBSELECT-SEC
               PERFORM     UNTIL  (MCP-RC   NOT =   ZERO)
                   MOVE    MCPDATA-REC     TO  NACCT-SKJ-REC
                   IF      NACCT-SKJ-SRYCDTOTAL   =   99999918
                       PERFORM    VARYING  IDX-DAY   FROM   1  BY  1
                         UNTIL   (IDX-DAY   >   31)
                             MOVE   NACCT-SKJ-DAY(IDX-DAY)
                                           TO  WRK-SKJ(1 IDX-DAY)
                       END-PERFORM
                   END-IF
                   IF      NACCT-SKJ-SRYCDTOTAL   =   99999919
                       PERFORM    VARYING  IDX-DAY   FROM   1  BY  1
                         UNTIL   (IDX-DAY   >   31)
                             MOVE   NACCT-SKJ-DAY(IDX-DAY)
                                           TO  WRK-SKJ(2 IDX-DAY)
                       END-PERFORM
                   END-IF
                   IF      NACCT-SKJ-SRYCDTOTAL   =   99999920
                       PERFORM    VARYING  IDX-DAY   FROM   1  BY  1
                         UNTIL   (IDX-DAY   >   31)
                             MOVE   NACCT-SKJ-DAY(IDX-DAY)
                                           TO  WRK-SKJ(3 IDX-DAY)
                       END-PERFORM
                   END-IF
                   MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
                   MOVE    "key33"             TO  MCP-PATHNAME
                   PERFORM 910-DBFETCH-SEC
               END-PERFORM
      *
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key33"             TO  MCP-PATHNAME
               PERFORM 910-DBCLOSECURSOR-SEC
      *
               PERFORM    VARYING  IDX-DAY   FROM   1  BY  1
                 UNTIL   (IDX-DAY   >   31)
                     IF    (WRK-SKJ(1 IDX-DAY)   =    ZERO)   AND
                           (WRK-SKJ(2 IDX-DAY)   =    ZERO)   AND
                           (WRK-SKJ(3 IDX-DAY)   =    ZERO)
                         MOVE    ZERO     TO   NACCT-DAY(IDX-DAY)
                     END-IF
               END-PERFORM
           END-IF
      *
           .
       2001-EDIT-NYUINACCT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC            SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MONFUNC"       USING
                                   MCPAREA
                                   MCPDATA-REC
      *
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC             SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "MONFUNC"       USING
                                   MCPAREA
                                   MCPDATA-REC
      *
           .
      *
       920-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクロース処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC       SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           CALL    "MONFUNC"       USING
                                   MCPAREA
                                   MCPDATA-REC
      *
           .
       990-DBCLOSECURSOR-EXT.
           EXIT.
