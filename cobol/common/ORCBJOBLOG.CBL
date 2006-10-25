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
       PROGRAM-ID.             ORCBJOBLOG.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : ジョブ管理
      *  コンポーネント名  : 終了情報書き込み
      *  管理者            : 
      *  作成日付    作業者        記述
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       DATA                    DIVISION.
       WORKING-STORAGE             SECTION.
       01  CNT-AREA.
           03  CNT-IN                                  PIC 9(06).
      *
      *    一時領域
      *
       01  WRK-AREA.
           03  WRK-SYSYMD-8.
               05  WRK-SYSYY           PIC 9(02).
               05  WRK-SYSYMD          PIC 9(06).
           03  WRK-TIME                PIC 9(08).
      *
       01  WRK-PARA.
           03  WRK-PARA-PROGNAME         PIC  X(20).
           03  WRK-PARA-KBNID            PIC  X(01).
           03  WRK-PARA-RESULT           PIC  X(01).
           03  WRK-PARA-OBJECTYYM        PIC  X(06).
           03  WRK-PARA-ERRCD            PIC  X(04).
           03  WRK-PARA-MSG              PIC  X(200).
      *    ジョブ管理マスタ
       01  JOBLOG-REC.
           COPY    "CPJOBLOG.INC".
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
      *
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(256).
      **************************************************************************
       PROCEDURE           DIVISION
               USING
           COMMAND-PARAM.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
           INITIALIZE                  WRK-AREA
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 100-DBOPEN-SEC

           PERFORM 200-MAIN-SEC

           PERFORM 900-DBDISCONNECT-SEC

           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  CNT-AREA
      *
           UNSTRING    COMMAND-PARAM   DELIMITED  BY  ","
                                       INTO    WRK-PARA-PROGNAME
                                               WRK-PARA-KBNID
                                               WRK-PARA-RESULT
                                               WRK-PARA-OBJECTYYM
                                               WRK-PARA-ERRCD
                                               WRK-PARA-MSG
           PERFORM 500-SYSYMD-HENSYU-SEC
           ACCEPT  WRK-TIME      FROM TIME

	   .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
           DISPLAY "ORCBJOBLOG:" WRK-PARA-PROGNAME "##"
           DISPLAY "ORCBJOBLOG:" WRK-PARA-KBNID "##"
           DISPLAY "ORCBJOBLOG:" WRK-PARA-RESULT "##"
           DISPLAY "ORCBJOBLOG:" WRK-PARA-OBJECTYYM "##"
           DISPLAY "ORCBJOBLOG:" WRK-PARA-ERRCD "##"
           DISPLAY "ORCBJOBLOG:" WRK-PARA-MSG "##"
           DISPLAY "ORCBJOBLOG:" WRK-SYSYMD-8 "##"
           DISPLAY "ORCBJOBLOG:" WRK-TIME "##"
           .
       200-MAIN-EXT.
           EXIT.             
      *****************************************************************
      *    システム日付編集処理
      *****************************************************************
       500-SYSYMD-HENSYU-SEC       SECTION.
      *
           ACCEPT  WRK-SYSYMD          FROM DATE
           MOVE    20                  TO  WRK-SYSYY
      *
           .
       500-SYSYMD-HENSYU-EXT.
           EXIT.
      * 
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
      *
           MOVE    "DBOPEN"            TO  MCP-FUNC.
           CALL    "MONFUNC"            USING
                                       MCPAREA
                                       MCPDATA-REC.
           MOVE    "DBSTART"           TO  MCP-FUNC.
           MOVE    LOW-VALUE           TO  MCP-PATH.
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC.
           .
       100-DBOPEN-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           MOVE    LOW-VALUE           TO  MCP-PATH.
           CALL    "MONFUNC"             USING
                                        MCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "MONFUNC"            USING
                                       MCPAREA
                                       MCPDATA-REC.
       900-DBDISCONNECT-EXT.
           EXIT.
