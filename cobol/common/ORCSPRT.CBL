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
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCSPRT.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 帳票管理
      *  コンポーネント名  : 帳票印刷管理・印刷ＤＢ制御
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/04/16    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-藤原    02/10/10  サイト区分追加
      *****************************************************************
001200*
001300 ENVIRONMENT             DIVISION.
001400 CONFIGURATION           SECTION.
001500 INPUT-OUTPUT            SECTION.
001600 FILE-CONTROL.
007000 DATA                    DIVISION.
010200 WORKING-STORAGE         SECTION.
      *
018000*    フラグ領域
      *
018100 01  FLG-AREA.
           03  FLG-END                 PIC 9(01).
018900     03  FLG-PRTKANRI            PIC 9(01).
           03  FLG-PRTDATA             PIC 9(01). 
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    印刷管理ＤＢ
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
      *    印刷ＤＢ
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".          
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "ORCA-DBPATH".
           COPY    "CPORCMCP.INC".
      *
           COPY    "MCPAREA".
      *     
      **************************************************************************
      *
       LINKAGE                 SECTION.
      *   印刷ＤＢ制御サブ
           COPY    "CPORCSPRT.INC".
      *
      **************************************************************************
       PROCEDURE           DIVISION
               USING
               ORCSPRTAREA.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
      *    処理モードのチェック
           EVALUATE    SPRT-MODE
               WHEN    "INS"
                       PERFORM 110-INS-SEC
               WHEN    "DEL"
                       PERFORM 140-DEL-SEC
               WHEN    OTHER
                       MOVE  10            TO  SPRT-RETURN  
           END-EVALUATE
      *
           .
       000-PROC-EXT.
           EXIT PROGRAM
           .
      *****************************************************************
      *    印刷ＤＢ追加処理
      *****************************************************************
       110-INS-SEC                 SECTION.
      *
           PERFORM 200-PRTKANRI-HENSYU-SEC
      *
           IF      MCP-RC          =   ZERO
               PERFORM 210-PRTDATA-HENSYU-SEC
           END-IF         
      *
           IF      MCP-RC          =   ZERO
               CONTINUE
           ELSE
               MOVE  MCP-RC            TO  SPRT-RETURN
           END-IF
      *
           .
       110-INS-EXT.
           EXIT.
      * 
      *****************************************************************
      *    削除処理
      *****************************************************************
       140-DEL-SEC                 SECTION.
      *
      *
           .
       140-DEL-EXT.
           EXIT.
      * 
      *****************************************************************
      *    印刷管理ＤＢ更新処理
      *****************************************************************
       200-PRTKANRI-HENSYU-SEC         SECTION.
      * 
           MOVE    SPACE               TO  PRTKANRI-REC
           INITIALIZE                      PRTKANRI-REC
           MOVE    SPRT-TBL-KEY        TO  PRTKANRI-TBL-KEY
           MOVE    SPRT-RENNUM         TO  PRTKANRI-RENNUM
           MOVE    SPRT-TBL-GROUP      TO  PRTKANRI-TBL-GROUP
           MOVE    SPRT-SHORI-RENNUM   TO  PRTKANRI-SHORI-RENNUM
           MOVE    PRTKANRI-REC        TO  MCPDATA-REC
           PERFORM 910-PRTKANRI-INV-SEC
           IF      FLG-PRTKANRI        =  ZERO
               ADD     1                   TO  PRTKANRI-PAGE
           ELSE
               MOVE    SPACE               TO  PRTKANRI-REC
               INITIALIZE                      PRTKANRI-REC
               MOVE    SPRT-TBL-KEY        TO  PRTKANRI-TBL-KEY
               MOVE    SPRT-RENNUM         TO  PRTKANRI-RENNUM
               MOVE    SPRT-TBL-GROUP      TO  PRTKANRI-TBL-GROUP
               MOVE    SPRT-SHELLID        TO  PRTKANRI-SHELLID
               MOVE    SPRT-SHORI-RENNUM   TO  PRTKANRI-SHORI-RENNUM
               MOVE    SPRT-SRYYM          TO  PRTKANRI-SRYYM
               MOVE    SPRT-SKYYMD         TO  PRTKANRI-SKYYMD
               MOVE    SPRT-PRIORITY       TO  PRTKANRI-PRIORITY
               MOVE    1                   TO  PRTKANRI-PAGE
               MOVE    SPACE               TO  PRTKANRI-PRTFLG
               MOVE    SPRT-TITLE          TO  PRTKANRI-TITLE
               MOVE    SPRT-TERMID         TO  PRTKANRI-TERMID
               MOVE    SPRT-OPID           TO  PRTKANRI-OPID
               MOVE    SPRT-PRTNM          TO  PRTKANRI-PRTNM
           END-IF
      *
           MOVE    PRTKANRI-REC        TO  MCPDATA-REC
           MOVE    PATH-TBL-PRTKANRI-KEY
                                       TO  MCP-PATH
           IF      FLG-PRTKANRI        =   ZERO     
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               CALL    "MCPSUB"            USING
                                           MCPAREA
                                       MCPDATA-REC      
               IF      MCP-RC     =   ZERO
                   MOVE  MCP-RC            TO  SPRT-RETURN
               ELSE
                   DISPLAY "PRTKANRI UPDATE ERR KEY = ["
                                      MCP-RC  " " PRTKANRI-KEY  "]"   
                   MOVE  MCP-RC            TO  SPRT-RETURN
               END-IF
           ELSE
               MOVE    "DBINSERT"          TO  MCP-FUNC
               CALL    "MCPSUB"            USING
                                           MCPAREA
                                           MCPDATA-REC      
               IF      MCP-RC     =   ZERO
                   MOVE  MCP-RC            TO  SPRT-RETURN
               ELSE
                   DISPLAY "PRTKANRI INSERT ERR KEY = ["
                                      MCP-RC  " " PRTKANRI-KEY  "]"   
                   MOVE  MCP-RC            TO  SPRT-RETURN
               END-IF
           END-IF    
      *
      *
           .
       200-PRTKANRI-HENSYU-EXT.
           EXIT.
      *
      * 
      *****************************************************************
      *    印刷ＤＢ更新処理
      *****************************************************************
       210-PRTDATA-HENSYU-SEC          SECTION.
      * 
           MOVE    SPACE               TO  PRTDATA-REC
           INITIALIZE                      PRTDATA-REC
           MOVE    SPRT-TBL-KEY        TO  PRTDATA-TBL-KEY
           MOVE    SPRT-RENNUM         TO  PRTDATA-RENNUM
           MOVE    SPRT-TBL-GROUP      TO  PRTDATA-TBL-GROUP
           MOVE    SPRT-SHELLID        TO  PRTDATA-SHELLID
           MOVE    SPRT-PRTID          TO  PRTDATA-PRTID
           MOVE    SPRT-SHORI-RENNUM   TO  PRTDATA-SHORI-RENNUM
           MOVE    SPRT-SRYYM          TO  PRTDATA-SRYYM
           MOVE    SPRT-SKYYMD         TO  PRTDATA-SKYYMD
           MOVE    SPRT-PTID           TO  PRTDATA-PTID 
           MOVE    SPRT-PRIORITY       TO  PRTDATA-PRIORITY
           MOVE    PRTKANRI-PAGE       TO  PRTDATA-PAGE
           MOVE    SPACE               TO  PRTDATA-PRTFLG
           IF      SPRT-SITEKBN        =   SPACE
               MOVE    "0"                 TO  PRTDATA-SITEKBN
           ELSE    
               MOVE    SPRT-SITEKBN        TO  PRTDATA-SITEKBN
           END-IF    
           MOVE    SPRT-PRTDATA        TO  PRTDATA-PRTDATA
      *
           MOVE    PRTDATA-REC         TO  MCPDATA-REC
           MOVE    PATH-TBL-PRTDATA-KEY
                                       TO  MCP-PATH
           MOVE    "DBINSERT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC 
      *                                      
           IF      MCP-RC     =   ZERO
               MOVE  MCP-RC            TO  SPRT-RETURN
           ELSE
               DISPLAY "PRTDATA INSERT ERR KEY = ["
                                  MCP-RC  " " PRTDATA-KEY  "]"   
               MOVE  MCP-RC            TO  SPRT-RETURN
           END-IF
      *
           .
       210-PRTDATA-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷管理マスタ読込
      *****************************************************************
       910-PRTKANRI-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    PATH-TBL-PRTKANRI-KEY
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    PATH-TBL-PRTKANRI-KEY
                                       TO  MCP-PATH
               CALL    "MCPSUB"        USING
                                       MCPAREA
                                       MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  PRTKANRI-REC
                   MOVE    ZERO                TO  FLG-PRTKANRI
               ELSE
                   MOVE    1                   TO  FLG-PRTKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PRTKANRI
           END-IF
      *
           .
       910-PRTKANRI-INV-EXT.
           EXIT.
           .
