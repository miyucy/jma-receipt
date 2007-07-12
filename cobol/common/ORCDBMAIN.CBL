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
       PROGRAM-ID.             ORCDBMAIN.
      *****************************************************************
      *  システム名        : ORCA
      *  サブシステム名    : 
      *  コンポーネント名  : ORCA DB アクセスメインモジュール
      *  返却エラーコード  : 
      *  管理者            : 
      *  作成日付    作業者        記述
      *  07/01/23    NACL-竹田     新規作成
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
           03  FLG-END             PIC 9(01).
           03  FLG-ERR             PIC 9(01).
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYSYMD              PIC X(08).
           03  WRK-MCP-RC              PIC ---9.
           03  WRK-STR                 PIC X(500).
           03  WRK-ERRMSG              PIC X(500).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
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
      *
           PERFORM 100-INIT-SEC
      *
           IF    ( MCP-TABLE           =   "metadb"
                                        OR "blob" )
               CONTINUE
           ELSE
      *
               EVALUATE    MCP-FUNC
               WHEN    "DBOPEN"
               WHEN    "DBDISCONNECT"
               WHEN    "DBSTART"
               WHEN    "DBCOMMIT"
                   MOVE    LOW-VALUE       TO  MCP-TABLE
                                               MCP-PATHNAME
               WHEN    "PUTWINDOW"
                   CONTINUE
               WHEN    OTHER
                   IF    ( SPA-NOCHK-HOSPNUM   =   "1" )
                       CONTINUE
                   ELSE
                       IF    ( SPA-HOSPNUM     =   ZERO )
                        OR   ( SPA-HOSPNUM     IS  NOT NUMERIC )
      *
                           MOVE   1            TO  FLG-ERR
                       END-IF
                   END-IF
               END-EVALUATE
           END-IF
      *
           IF    ( FLG-ERR         =   ZERO )
               CALL    "MONFUNC"           USING
                                           MCPAREA
                                           MCPDATA-REC
      *
               IF    ( MCP-RC      =   ZERO OR 1)
                   CONTINUE
               ELSE
                   PERFORM 800-EDIT-ERRMSG-SEC
               END-IF
      *
           ELSE
               MOVE    51          TO  MCP-RC
               PERFORM 800-EDIT-ERRMSG-SEC
           END-IF
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
      *    更新日取得
           INITIALIZE                  ORCSMCNDATEAREA
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
      *
           .
      *
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    エラーメッセージ編集処理
      *****************************************************************
       800-EDIT-ERRMSG-SEC             SECTION.
      *
           MOVE   SPACE            TO  WRK-ERRMSG
           MOVE   MCP-RC           TO  WRK-MCP-RC
      *
           STRING "ORCDBMAIN ERROR RC[" DELIMITED   BY  SIZE
                  WRK-MCP-RC           DELIMITED   BY  SIZE
                  "] HOSPNUM["         DELIMITED   BY  SIZE
                  SPA-HOSPNUM          DELIMITED   BY  SIZE
                  "] FUNC["            DELIMITED   BY  SIZE
                  MCP-FUNC             DELIMITED   BY  SPACE
                  "] TABLE["           DELIMITED   BY  SIZE
                  MCP-TABLE            DELIMITED   BY  SPACE
                  "] PATHNAME["        DELIMITED   BY  SIZE
                  MCP-PATHNAME         DELIMITED   BY  SPACE
                  "] SPA["             DELIMITED   BY  SIZE
                  SPA-STAFFCD          DELIMITED   BY  SIZE
                  SPA-SYSYMD           DELIMITED   BY  SIZE
                  SPA-SYSYMDW          DELIMITED   BY  SIZE
                  SPA-SYSYMDWH         DELIMITED   BY  SIZE
                  SPA-SYSYMD-YOBI      DELIMITED   BY  SIZE
                  SPA-MACHIPG          DELIMITED   BY  SIZE
                  SPA-MOTOPG           DELIMITED   BY  SIZE
                  SPA-MOTOPG2          DELIMITED   BY  SIZE
                  "]"                  DELIMITED   BY  SIZE
                  LOW-VALUE            DELIMITED   BY  SIZE
           INTO   WRK-ERRMSG
           END-STRING
      *
           CALL    "coblog"    USING   WRK-ERRMSG
      *
           .
       800-EDIT-ERRMSG-EXT.
           EXIT.
