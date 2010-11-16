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
       PROGRAM-ID.                 ORCGXAPRT.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : クライアント印刷
      *  コンポーネント名  : 印刷用データ作成
      *  管理者            : 
      *  10/11/10    NACL−竹田　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                        DIVISION.
      *FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
      *
      *    一時領域
       01  WRK-AREA.
           03  WK-FILE-NAME        PIC X(256).
           03  WK-FILE-NAME2       PIC X(256).
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *     
           COPY    "CPORCMCP.INC".  
      *
           COPY    "ORCA-BLOB".  
           COPY    "ORCA-SYSTEM".  
      *    ファイル削除パラメタ
           COPY    "CPORCSFDEL.INC".
      *   ファイル取得関数
       01 ORCFILEGET-AREA.
           03  ORCF-FILE-MODE   PIC X(1).
           03  ORCF-FILE-NAME   PIC X(200).
           03  ORCF-DATA        PIC X(100000).
           03  ORCF-RET         PIC X(2).
       01  ST                PIC 9(2).
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *****COPY    "MCPAREA.INC".
           COPY    MCPAREA.
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "XA01.INC".
           COPY    "XA02.INC".
           COPY    "XA99.INC".
           COPY    "XAERR.INC".
           COPY    "XAID1.INC".
           COPY    "XAID2.INC".
           COPY    "XAPRT.INC".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           DISPLAY "クライアント印刷開始"
           DISPLAY "XA01-FILENAME = " XA01-FILENAME
           MOVE    SPA-COMMON      TO  SPA-AREA
      * 
           MOVE   'BLOBLOOKUP'     TO  MCP-FUNC
           MOVE   'blob'           TO  MCP-TABLE
           MOVE   'key'            TO  MCP-PATHNAME
           MOVE   XA01-FILENAME    TO  ORCA-BLOB-FILE
           MOVE   LOW-VALUE        TO  ORCA-BLOB-OBJECT
           CALL   'ORCDBMAIN'      USING
                MCPAREA
                ORCA-BLOB
                SPA-AREA
           IF ORCA-BLOB-OBJECT     = LOW-VALUE
             DISPLAY "ORCA-BLOB-OBJECT is LOW-VALUE " 
             MOVE   'BLOBIMPORT' TO  MCP-FUNC
             STRING "/tmp/"      DELIMITED   BY  SIZE
                    XA01-FILENAME
                                 DELIMITED   BY  SPACE
             INTO   ORCA-BLOB-FILE 
             END-STRING
             MOVE  ORCA-BLOB-FILE    TO  WK-FILE-NAME
                                         WK-FILE-NAME2
             PERFORM 110-FILE-ID
             IF    ORCF-RET          NOT = ZERO
                   DISPLAY "FILE NOT EXIST"
                   EXIT    PROGRAM
             END-IF
             MOVE   LOW-VALUE        TO  ORCA-BLOB-OBJECT
             DISPLAY 'importpath:' ORCA-BLOB-FILE
             CALL   'ORCDBMAIN'      USING
                                     MCPAREA
                                     ORCA-BLOB
                                     SPA-AREA
             DISPLAY "MCP-RC = " MCP-RC
             IF ORCA-BLOB-OBJECT     = LOW-VALUE
                DISPLAY "imp ORCA-BLOB-OBJECT is LOW-VALUE " 
             ELSE
                DISPLAY "imp ORCA-BLOB-OBJECT is not LOW-VALUE " 
             END-IF
           IF ORCA-BLOB-OBJECT    NOT = LOW-VALUE
             DISPLAY "BLOBREGISTER is run"
             MOVE   XA01-FILENAME  TO  ORCA-BLOB-FILE
             MOVE   'BLOBREGISTER' TO  MCP-FUNC
             CALL   'ORCDBMAIN'      USING
                                     MCPAREA
                                     ORCA-BLOB
                                     SPA-AREA
             PERFORM 110-FILE-DEL
           END-IF
           ELSE
             DISPLAY "ORCA-BLOB-OBJECT is not LOW-VALUE " 
             STRING "/tmp/"      DELIMITED   BY  SIZE
                    XA01-FILENAME
                                 DELIMITED   BY  SPACE
             INTO   ORCA-BLOB-FILE 
             END-STRING
             MOVE  ORCA-BLOB-FILE    TO  WK-FILE-NAME
                                         WK-FILE-NAME2
             PERFORM 110-FILE-DEL
           END-IF
           MOVE ORCA-BLOB-OBJECT   TO XA01-BODY
      *
           MOVE    SPA-AREA        TO  SPA-COMMON
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    SPA-MOTOPG          TO  SPA-SAKIPG
           MOVE    "XAERR"              TO  SPA-MOTOPG
     *
           MOVE    "JOIN"              TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       110-FILE-ID                 SECTION.
      *
           MOVE    "r"                 TO  ORCF-FILE-MODE
           INSPECT WK-FILE-NAME REPLACING  ALL "pdf" BY  "api"
           MOVE    WK-FILE-NAME        TO  ORCF-FILE-NAME
           CALL    "orcfileio"         USING ST  ORCFILEGET-AREA
           IF      ORCF-RET            =   ZERO
                   DISPLAY "file exist"
           ELSE
                   DISPLAY "file NO"
           END-IF
      *
           .
       110-FILE-IO-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       110-FILE-DEL                SECTION.
      *
      *    CALL    "cobsleep"      USING 5
           DISPLAY "FILE del start "  WK-FILE-NAME2
           MOVE    ZERO            TO  IF-RESULT
           MOVE    WK-FILE-NAME2   TO  IF-FILENAME
           CALL    "orcfiledel"    USING
                                   ORCSFDELAREA
           INSPECT WK-FILE-NAME REPLACING  ALL "pdf" BY  "api"
           DISPLAY "FILE del start "  WK-FILE-NAME
           MOVE    ZERO            TO  IF-RESULT
           MOVE    WK-FILE-NAME    TO  IF-FILENAME
           CALL    "orcfiledel"    USING
                                   ORCSFDELAREA
           INSPECT WK-FILE-NAME REPLACING  ALL "api" BY  "ps"
           DISPLAY "FILE del start "  WK-FILE-NAME
           MOVE    ZERO            TO  IF-RESULT
           MOVE    WK-FILE-NAME    TO  IF-FILENAME
           CALL    "orcfiledel"    USING
                                   ORCSFDELAREA
      *
           .
       110-FILE-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL   "ORCDBMAIN"       USING
                                        MCPAREA
                                        MCPDATA-REC
                                        SPA-AREA
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
