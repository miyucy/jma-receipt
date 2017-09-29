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
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCBBLOBIMPORT.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : 大容量ＡＰＩへの更新
      *  管理者            : 
      *  作成日付    作業者        記述
      *  17/09/26    NACL−藤原    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
      *
       DATA                        DIVISION.
       WORKING-STORAGE             SECTION.
      *
       01  WRK-AREA.
           03  WRK-PARA-MONBLOB-ID PIC X(37).
           03  WRK-PARA-FILE-TYPE  PIC X(10).
           03  WRK-PARA-FILENM     PIC X(100).
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
           COPY    "CPORCSGETTEMP.INC".
      *
           COPY    "MCPAREA".
           COPY    "MCPDATA.INC".
           COPY    "MONBLOB".
           COPY    "ORCA-BLOB".
      *
           COPY    "COMMON-SPA".
      *
      *****************************************************************
       LINKAGE                     SECTION.
       01  COMMAND-PARAM.
           02  FILLER              PIC X(256).
      *****************************************************************
       PROCEDURE                   DIVISION
                                   USING
                                   COMMAND-PARAM.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  WRK-AREA
                                       SPA-AREA
      *
           UNSTRING    COMMAND-PARAM   DELIMITED  BY  ","
                                       INTO  WRK-PARA-FILENM
                                             WRK-PARA-FILE-TYPE
                                             WRK-PARA-MONBLOB-ID
           END-UNSTRING
           DISPLAY "WRK-PARA-FILENM    =" WRK-PARA-FILENM
           DISPLAY "WRK-PARA-FILE-TYPE =" WRK-PARA-FILE-TYPE
           DISPLAY "WRK-PARA-MONBLOB-ID=" WRK-PARA-MONBLOB-ID
      *
           PERFORM 100-DBOPEN-SEC
      *
           INITIALIZE                      SGETTEMP-AREA
           MOVE    WRK-PARA-FILENM     TO   SGETTEMP-BASENAME
           CALL    "ORCSGETTEMP"       USING   SGETTEMP-AREA
      *
           INITIALIZE                      MONBLOB
           MOVE    SGETTEMP-FULLNAME   TO  MONBLOB-FILENAME
           MOVE    WRK-PARA-MONBLOB-ID TO  MONBLOB-ID
           STRING  "application/"      DELIMITED   BY  SIZE
                   WRK-PARA-FILE-TYPE  DELIMITED   BY  SPACE
                                       INTO    MONBLOB-CONTENT-TYPE
           END-STRING
           MOVE    "MONBLOBIMPORT"     TO  MCP-FUNC
           MOVE    "key"               TO  MCP-PATHNAME
           MOVE    "monblob"           TO  MCP-TABLE
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MONBLOB
           DISPLAY "MCP-RC=" MCP-RC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           STOP    RUN
           .
      *
      *****************************************************************
      *    テーブルアクセス処理
      *****************************************************************
       900-ORCDBMAIN-SEC           SECTION.
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
      *    ＤＢオープン処理
      *****************************************************************
       100-DBOPEN-SEC              SECTION.
      *
           MOVE    LOW-VALUE       TO  MCP-TABLE
                                       MCP-PATHNAME
           MOVE    "DBOPEN"        TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
      *
           MOVE    LOW-VALUE       TO  MCP-TABLE
                                       MCP-PATHNAME
           MOVE    "DBSTART"       TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC        SECTION.
      *
           MOVE    LOW-VALUE       TO  MCP-TABLE
                                       MCP-PATHNAME
           MOVE    "DBCOMMIT"      TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
      *
           MOVE    LOW-VALUE       TO  MCP-TABLE
                                       MCP-PATHNAME
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
           .
       900-DBDISCONNECT-EXT.
           EXIT.
