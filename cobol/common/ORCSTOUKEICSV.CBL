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
       PROGRAM-ID.             ORCSTOUKEICSV.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 統計データＣＳＶ管理
      *  コンポーネント名  : 統計データＣＳＶ制御
      *  管理者            : 
      *  作成日付    作業者        記述
      *  09/09/17    NACL−藤原    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
       DATA                        DIVISION.
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-TOUKEICSV-H     PIC 9(01).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    統計ＣＳＶ管理ＤＢ
       01  TOUKEICSV-H-REC.
           COPY    "CPTOUKEICSV-H.INC".
      *
      *    統計ＣＳＶ明細ＤＢ
       01  TOUKEICSV-B-REC.
           COPY    "CPTOUKEICSV-B.INC".          
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "MCPAREA".
      *     
      *****************************************************************
      *
       LINKAGE                     SECTION.
      *   統計ＣＳＶ制御サブ
           COPY    "CPORCSTOUKEICSV.INC".
      *
           COPY    "COMMON-SPA".
      *
      *****************************************************************
       PROCEDURE                   DIVISION
                                   USING
                                   ORCSTOUKEICSVAREA
                                   SPA-AREA
           .
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
      *    処理モードのチェック
           EVALUATE    STOUKEICSV-MODE
               WHEN    "INS"
                       PERFORM 110-INS-SEC
               WHEN    "UPD"
                       PERFORM 120-UPD-SEC
               WHEN    "DEL"
                       PERFORM 140-DEL-SEC
               WHEN    OTHER
                       MOVE  10            TO  STOUKEICSV-RETURN  
           END-EVALUATE
      *
           .
       000-PROC-EXT.
           EXIT PROGRAM
           .
      *
      *****************************************************************
      *    統計ＣＳＶＤＢ追加処理
      *****************************************************************
       110-INS-SEC                 SECTION.
      *
           PERFORM 1101-TOUKEICSV-H-HENSYU-SEC
      *
           IF      MCP-RC          =   ZERO
               PERFORM 1102-TOUKEICSV-B-HENSYU-SEC
           END-IF         
      *
           IF      MCP-RC          =   ZERO
               CONTINUE
           ELSE
               MOVE  MCP-RC            TO  STOUKEICSV-RETURN
           END-IF
      *
           .
       110-INS-EXT.
           EXIT.
      * 
      *****************************************************************
      *    統計ＣＳＶ管理ＤＢ更新処理
      *****************************************************************
       1101-TOUKEICSV-H-HENSYU-SEC SECTION.
      * 
           MOVE    SPACE               TO  TOUKEICSV-H-REC
           INITIALIZE                      TOUKEICSV-H-REC
           MOVE    SPA-HOSPNUM         TO  TOUKEICSV-H-HOSPNUM
           MOVE    STOUKEICSV-TBL-KEY  TO  TOUKEICSV-H-TBL-KEY
           MOVE    STOUKEICSV-RENNUM   TO  TOUKEICSV-H-RENNUM
           MOVE    STOUKEICSV-TBL-GROUP
                                       TO  TOUKEICSV-H-TBL-GROUP
           MOVE    STOUKEICSV-SHORI-RENNUM
                                       TO  TOUKEICSV-H-SHORI-RENNUM
           MOVE    TOUKEICSV-H-REC     TO  MCPDATA-REC
           PERFORM 900-TOUKEICSV-H-INV-SEC
           IF      FLG-TOUKEICSV-H     =   ZERO
               ADD     1                   TO  TOUKEICSV-H-CNT
           ELSE
               MOVE    SPACE               TO  TOUKEICSV-H-REC
               INITIALIZE                      TOUKEICSV-H-REC
               MOVE    SPA-HOSPNUM         TO  TOUKEICSV-H-HOSPNUM
               MOVE    STOUKEICSV-TBL-KEY  TO  TOUKEICSV-H-TBL-KEY
               MOVE    STOUKEICSV-RENNUM   TO  TOUKEICSV-H-RENNUM
               MOVE    STOUKEICSV-TBL-GROUP
                                           TO  TOUKEICSV-H-TBL-GROUP
               MOVE    STOUKEICSV-SHORI-RENNUM
                                           TO  TOUKEICSV-H-SHORI-RENNUM
               MOVE    STOUKEICSV-SHELLID  TO  TOUKEICSV-H-SHELLID
               MOVE    STOUKEICSV-SRYYM    TO  TOUKEICSV-H-SRYYM
               MOVE    STOUKEICSV-SRYYMD   TO  TOUKEICSV-H-SRYYMD
               MOVE    1                   TO  TOUKEICSV-H-CNT
               IF      STOUKEICSV-PUTFLG   =   "1"
                   MOVE    "1"                 TO  TOUKEICSV-H-PUTFLG
               ELSE
                   MOVE    SPACE               TO  TOUKEICSV-H-PUTFLG
               END-IF
               MOVE    STOUKEICSV-NYUGAIKBN
                                           TO  TOUKEICSV-H-NYUGAIKBN
               MOVE    STOUKEICSV-TO-FOLDER
                                           TO  TOUKEICSV-H-TO-FOLDER
               MOVE    STOUKEICSV-TO-DATA  TO  TOUKEICSV-H-TO-DATA
               MOVE    STOUKEICSV-CODE-TYPE
                                           TO  TOUKEICSV-H-CODE-TYPE
               MOVE    STOUKEICSV-TITLE    TO  TOUKEICSV-H-TITLE
           END-IF
      *
           MOVE    STOUKEICSV-TBL-GROUP(1:8)
                                       TO  TOUKEICSV-H-CREYMD
      *
           MOVE    TOUKEICSV-H-REC     TO  MCPDATA-REC
           MOVE    "tbl_toukeicsv_h"   TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           IF      FLG-TOUKEICSV-H     =   ZERO     
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               PERFORM 900-ORCDBMAIN-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCP-RC              TO  STOUKEICSV-RETURN
               ELSE
                   DISPLAY "TOUKEICSV-H UPDATE ERR KEY = ["
                                      MCP-RC  " " TOUKEICSV-H-KEY  "]" 
                   MOVE  MCP-RC                TO  STOUKEICSV-RETURN
               END-IF
           ELSE
               MOVE    "DBINSERT"              TO  MCP-FUNC
               PERFORM 900-ORCDBMAIN-SEC
               IF      MCP-RC              =   ZERO
                   MOVE  MCP-RC                TO  STOUKEICSV-RETURN
               ELSE
                   DISPLAY "TOUKEICSV-H INSERT ERR KEY = ["
                                      MCP-RC  " " TOUKEICSV-H-KEY  "]"   
                   MOVE  MCP-RC                TO  STOUKEICSV-RETURN
               END-IF
           END-IF    
      *
           .
       1101-TOUKEICSV-H-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    統計ＣＳＶ明細ＤＢ更新処理
      *****************************************************************
       1102-TOUKEICSV-B-HENSYU-SEC SECTION.
      * 
           MOVE    SPACE               TO  TOUKEICSV-B-REC
           INITIALIZE                      TOUKEICSV-B-REC
           MOVE    SPA-HOSPNUM         TO  TOUKEICSV-B-HOSPNUM
           MOVE    STOUKEICSV-TBL-KEY  TO  TOUKEICSV-B-TBL-KEY
           MOVE    STOUKEICSV-RENNUM   TO  TOUKEICSV-B-RENNUM
           MOVE    STOUKEICSV-TBL-GROUP
                                       TO  TOUKEICSV-B-TBL-GROUP
           MOVE    STOUKEICSV-SHORI-RENNUM
                                       TO  TOUKEICSV-B-SHORI-RENNUM
           MOVE    STOUKEICSV-SHELLID  TO  TOUKEICSV-B-SHELLID
           MOVE    STOUKEICSV-SRYYM    TO  TOUKEICSV-B-SRYYM
           MOVE    STOUKEICSV-SRYYMD   TO  TOUKEICSV-B-SRYYMD
           MOVE    STOUKEICSV-PTID     TO  TOUKEICSV-B-PTID 
           MOVE    TOUKEICSV-H-CNT     TO  TOUKEICSV-B-SEQ-NO
           MOVE    STOUKEICSV-CSVDATA  TO  TOUKEICSV-B-CSVDATA
           MOVE    STOUKEICSV-TBL-GROUP(1:8)
                                       TO  TOUKEICSV-B-CREYMD
      *
           MOVE    TOUKEICSV-B-REC     TO  MCPDATA-REC
           MOVE    "tbl_toukeicsv_b"   TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           MOVE    "DBINSERT"          TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
      *                                      
           IF      MCP-RC     =   ZERO
               MOVE  MCP-RC            TO  STOUKEICSV-RETURN
           ELSE
               DISPLAY "TOUKEICSV-B INSERT ERR KEY = ["
      ****                        MCP-RC  " " TOUKEICSV-B-KEY  "]"   
                                  MCP-RC  " "    
               MOVE  MCP-RC            TO  STOUKEICSV-RETURN
           END-IF
      *
           .
       1102-TOUKEICSV-B-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    統計ＣＳＶＤＢ更新処理
      *****************************************************************
       120-UPD-SEC                 SECTION.
      *
           CALL    "ORCSMCNDATE"   USING   ORCSMCNDATEAREA
      *
      *    統計ＣＳＶ管理ＤＢ更新処理
           MOVE    SPACE               TO  TOUKEICSV-H-REC
           INITIALIZE                      TOUKEICSV-H-REC
           MOVE    SPA-HOSPNUM         TO  TOUKEICSV-H-HOSPNUM
           MOVE    STOUKEICSV-TBL-KEY  TO  TOUKEICSV-H-TBL-KEY
           MOVE    STOUKEICSV-RENNUM   TO  TOUKEICSV-H-RENNUM
           MOVE    STOUKEICSV-TBL-GROUP
                                       TO  TOUKEICSV-H-TBL-GROUP
           MOVE    STOUKEICSV-SHORI-RENNUM
                                       TO  TOUKEICSV-H-SHORI-RENNUM
           MOVE    TOUKEICSV-H-REC     TO  MCPDATA-REC
           PERFORM 900-TOUKEICSV-H-INV-SEC
           IF      FLG-TOUKEICSV-H     =   ZERO
               MOVE    "1"                 TO  TOUKEICSV-H-PUTFLG
               MOVE    SMCNDATE-YMD        TO  TOUKEICSV-H-UPYMD
               MOVE    SMCNDATE-HMS        TO  TOUKEICSV-H-UPHMS
      *
               MOVE    TOUKEICSV-H-REC     TO  MCPDATA-REC
               MOVE    "tbl_toukeicsv_h"   TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               PERFORM 900-ORCDBMAIN-SEC
      *
               IF      MCP-RC     =   ZERO
                   MOVE  MCP-RC            TO  STOUKEICSV-RETURN
               ELSE
                   DISPLAY "TOUKEICSV-H UPDATE ERR MCP-RC = ["
                                  MCP-RC  " " TOUKEICSV-H-KEY  "]"
                   MOVE  MCP-RC            TO  STOUKEICSV-RETURN
                   GO  TO  120-UPD-EXT
               END-IF
           ELSE
               DISPLAY "TOUKEICSV-H UPDATE NOT FOUND KEY = ["
                                           TOUKEICSV-H-KEY  "]"
               MOVE  9                TO  STOUKEICSV-RETURN
               GO  TO  120-UPD-EXT
           END-IF
      *
           .
       120-UPD-EXT.
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
      *    統計ＣＳＶ管理マスタ読込
      *****************************************************************
       900-TOUKEICSV-H-INV-SEC         SECTION.
      *
           MOVE    "tbl_toukeicsv_h"   TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_toukeicsv_h"   TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 900-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  TOUKEICSV-H-REC
                   MOVE    ZERO                TO  FLG-TOUKEICSV-H
               ELSE
                   MOVE    1                   TO  FLG-TOUKEICSV-H
               END-IF
           ELSE
               MOVE    1                   TO  FLG-TOUKEICSV-H
           END-IF
      *
           MOVE    "tbl_toukeicsv_h"   TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-TOUKEICSV-H-INV-EXT.
           EXIT.
           .
      *
      *****************************************************************
      *    ＤＢＳＥＬＥＣＴ処理
      *****************************************************************
       900-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
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
      *
      *****************************************************************
      *    テーブルアクセス処理
      *****************************************************************
       900-ORCDBMAIN-SEC               SECTION.
      *
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
      *
       900-ORCDBMAIN-EXT.
           EXIT.
