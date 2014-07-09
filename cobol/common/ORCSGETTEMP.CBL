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
       PROGRAM-ID.                         ORCSGETTEMP.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 共通
      *  コンポーネント名  : 一時ファイル名取得
      *  返却エラーコード  : 00:正常　99:エラー
      *  管理者            : 
      *  作成日付    作業者        記述
      *  14/06/20    NACL-太田     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                         DIVISION.
       CONFIGURATION                       SECTION.
       INPUT-OUTPUT                        SECTION.
       DATA                                DIVISION.
       FILE                                SECTION.
       WORKING-STORAGE                     SECTION.
      *
       01  WRK-AREA.
           03  WRK-ORCB-TEMPDIR            PIC X(1024).
           03  WRK-FULLNAME                PIC X(1024).
           03  WRK-POINTER                 PIC 9(05).
           03  WRK-POINTER-PATH            PIC 9(05).
           03  WRK-SEQ-X.
               05  WRK-SEQ                 PIC 9(03).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                             SECTION.
      *
           COPY    "CPORCSGETTEMP.INC".
      *
       PROCEDURE                           DIVISION    USING
           SGETTEMP-AREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                        SECTION.
      *
           INITIALIZE                      WRK-AREA
      *
           MOVE      SPACE             TO  MCP-TEMPDIR
                                           WRK-ORCB-TEMPDIR
                                           SGETTEMP-FULLNAME-AREA
      *
           ACCEPT   MCP-TEMPDIR      FROM ENVIRONMENT  "MCP_TEMPDIR"
           ACCEPT   WRK-ORCB-TEMPDIR FROM ENVIRONMENT  "ORCB_TEMPDIR"
      *
           MOVE   1                    TO  WRK-POINTER-PATH
      *
           STRING FUNCTION TRIM(MCP-TEMPDIR)   DELIMITED BY SIZE
           INTO   WRK-FULLNAME
           WITH   POINTER  WRK-POINTER-PATH
           END-STRING
      *
           IF   ( WRK-ORCB-TEMPDIR     NOT =   SPACE )
               STRING "/"                      DELIMITED BY SIZE
                      FUNCTION TRIM(WRK-ORCB-TEMPDIR)
                                               DELIMITED BY SIZE
               INTO   WRK-FULLNAME
               WITH   POINTER  WRK-POINTER-PATH
               END-STRING
           END-IF
      *
           MOVE   WRK-POINTER-PATH TO  WRK-POINTER
           MOVE   WRK-FULLNAME     TO  SGETTEMP-TEMPDIR
      *
           STRING "/"
           INTO   SGETTEMP-FULLNAME
           WITH   POINTER  WRK-POINTER
           END-STRING
      *
           MOVE   WRK-POINTER-PATH TO  WRK-POINTER
           MOVE   WRK-FULLNAME     TO  SGETTEMP-FULLNAME
      *
           MOVE   WRK-POINTER      TO  SGETTEMP-ST
      *
           STRING "/"
                  FUNCTION TRIM(SGETTEMP-BASENAME) DELIMITED BY SIZE
           INTO   SGETTEMP-FULLNAME
           WITH   POINTER  WRK-POINTER
           END-STRING
      *
           MOVE    ZERO            TO  WRK-SEQ
           PERFORM VARYING WRK-SEQ FROM    1   BY  1
                   UNTIL ( WRK-SEQ > 10 )
      *
               MOVE   WRK-POINTER-PATH TO  WRK-POINTER
               MOVE   WRK-FULLNAME     TO  SGETTEMP-FULLNAMES (WRK-SEQ)
      *
               STRING "/"
                      FUNCTION TRIM(SGETTEMP-BASENAME) DELIMITED BY SIZE
                      "."                              DELIMITED BY SIZE
                      WRK-SEQ-X                        DELIMITED BY SIZE
               INTO   SGETTEMP-FULLNAMES (WRK-SEQ)
               WITH   POINTER  WRK-POINTER
               END-STRING
      *
           END-PERFORM
      *
           EXIT PROGRAM
      *
           .
       000-PROC-EXT.
           EXIT.
           .
      *

