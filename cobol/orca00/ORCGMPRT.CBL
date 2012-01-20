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
       PROGRAM-ID.                 ORCGMPRT.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : クライアント印刷
      *  コンポーネント名  : 印刷APIモジュール
      *  管理者            : 
      *  作成日付    作業者        記述
      *  11/03/07    NACL−竹田　   新規作成
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
      *
       DATA                        DIVISION.
      *
       FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
       01  FILE-NAME1.
           03  FILLER              PIC X(512).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-FILE1           PIC X(02).
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                 PIC 9(01).
           03  FLG-PRTCTRL             PIC 9(01).
           03  FLG-PRTKANRI            PIC 9(01).
           03  FLG-PRTDATA             PIC 9(01).
           03  FLG-OK                  PIC 9(01).
           03  FLG-ONLINE              PIC 9(01).
           03  FLG-CANCEL              PIC 9(01).
      *
       01  INDEX-AREA.
           03  IDX                     PIC 9(04).
           03  IDY                     PIC 9(04).
           03  IDZ                     PIC 9(04).
      *    一時領域
       01  WRK-AREA.
           03  WK-CONT-FLG         PIC 9(02).
           03  WK-ST-PAGE          PIC 9(05).
           03  WK-ED-PAGE          PIC 9(05).
           03  WK-FILE-NAME        PIC X(256).
           03  WK-FILE-NAME2       PIC X(256).
           03  WK-FILE-NAME-CK     PIC X(256).
           03  WK-FILE-OC-AREA.
             05 WK-FILE-OC         PIC X(01) OCCURS 256.
           03  WRK-ERRCD           PIC X(03).
           03  WRK-SYMD.
               05  WRK-SYY             PIC X(04).
               05  WRK-SMM             PIC X(02).
               05  WRK-SDD             PIC X(02).
           03  WRK-HEN-DATE.
               05  WRK-HEN-YY          PIC X(04).
               05  WRK-HEN-H1          PIC X(01).
               05  WRK-HEN-MM          PIC X(02).
               05  WRK-HEN-H2          PIC X(01).
               05  WRK-HEN-DD          PIC X(02).
      *    時間編集
           03  WRK-THMS.
               05  WRK-THH             PIC X(02).
               05  WRK-TMM             PIC X(02).
               05  WRK-TSS             PIC X(02).
           03  WRK-HEN-TIME.
               05  WRK-HEN-THH         PIC X(02).
               05  WRK-HEN-T1          PIC X(01).
               05  WRK-HEN-TMM         PIC X(02).
               05  WRK-HEN-T2          PIC X(01).
               05  WRK-HEN-TSS         PIC X(02).
           03  WRK-FILE-TYPE           PIC X(05).
      *    ＱＲ作成用
           COPY    "CPORCSQRENCODE.INC".
      *
       01  WKPRTCTRL-REC.
           COPY    "CPPRTCTRL.INC"      REPLACING
                                     //PRTCTRL-// BY //WPRTCTRL-//.
      *

      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    職員情報
           COPY  "CPSK1010.INC".
      *    印刷制御マスタ
       01  PRTCTRL-REC.
           COPY    "CPPRTCTRL.INC".
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
           COPY    "CPORCSCOMMON.INC".
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
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
           COPY    "M00.INC".
           COPY    "M01.INC".
           COPY    "M01N.INC".
           COPY    "M02.INC". 
           COPY    "M95.INC".
           COPY    "M96.INC".
           COPY    "M97.INC".
           COPY    "MERR.INC".
           COPY    "MID1.INC".
           COPY    "MVER.INC".
           COPY    "M98.INC".
           COPY    "MUID.INC".
           COPY    "M99.INC".
           COPY    "MID2.INC".
           COPY    "MDAS.INC".
           COPY    "MLOG.INC".
           COPY    "MINF.INC".
           COPY    "MPRT.INC".
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
           DISPLAY "ORCGMPRT MPRT-FILENAME = " MPRT-FILENAME
           INITIALIZE WRK-AREA
                      FLG-AREA
      *    初期処理
           PERFORM 100-INIT-SEC
      *    主処理
           IF      FLG-OK              =   1
               PERFORM 200-MAIN-SEC
           END-IF
      *    終了処理
           PERFORM 300-CANCEL-CHECK-SEC
      *
           DISPLAY "MPRT-HTTPSTATUS = " MPRT-HTTPSTATUS
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
      *    更新日取得
           INITIALIZE                  PRTCTRL-REC
           INITIALIZE                  ORCSMCNDATEAREA
                                       SPA-AREA
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
      *
           MOVE    MCP-USER            TO  SPA-OPID
           MOVE    SMCNDATE-YMD        TO  SPA-SYSYMD
      *    日付・時間出力編集
           MOVE    SMCNDATE-YMD        TO  WRK-SYMD
           MOVE    SMCNDATE-HMS        TO  WRK-THMS
           PERFORM 801-DAYHEN01-SEC
      *
      *    医療機関識別番号セット 
           CALL    "ORCSHOSPNUM"       USING
                                       MCPAREA
                                       SPA-AREA
           IF      SPA-ERRCD       NOT =   SPACE
               MOVE   "99"             TO  WRK-ERRCD
               DISPLAY "IRYO No ERR SPA-ERRCD = " SPA-ERRCD
               GO  TO         100-INIT-EXT
           END-IF
      *    ＳＰＡ共通設定
           INITIALIZE                  SYS-1010-REC
           INITIALIZE                  ORCSCOMMONAREA
           MOVE    "M00"               TO  ORCSCOMMON-PG
           CALL    "ORCSCOMMON"        USING
                                       MCPAREA
                                       SPA-AREA
                                       ORCSCOMMONAREA
                                       SYS-1010-REC
           IF      SPA-ERRCD       NOT =   SPACE
               MOVE   "98"             TO  WRK-ERRCD
           END-IF
      *
           PERFORM 100-AGENTGET-SEC
      *
           PERFORM 110-FILE-CHECK
           IF      FLG-ONLINE          =   1
               PERFORM 110-FILE-ID
             IF    ORCF-RET            =   ZERO
               MOVE  1                 TO  FLG-OK
             END-IF
           ELSE
               MOVE  1                 TO  FLG-OK
           END-IF
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
             DISPLAY "Main start " 
      *--------> ここで印刷APIをキャンセルするURLを設定する。
           IF      FLG-ONLINE      =   1
             IF    PRTCTRL-SHORI-RENNUM  =  99
               PERFORM 2001-99DEL-SEC
               GO              TO  200-MAIN-EXT
             ELSE
               PERFORM 210-PRTDATA-EXIST-SEC
             END-IF
           END-IF
      * 
      *    IF      FLG-CANCEL      =   1
      *      DISPLAY "This data cansel " 
      *               MPRT-FILENAME 
      *        GO              TO  200-MAIN-EXT
      *    END-IF
      * 
           MOVE   'BLOBLOOKUP'     TO  MCP-FUNC
           MOVE   'blob'           TO  MCP-TABLE
           MOVE   'key'            TO  MCP-PATHNAME
           MOVE   MPRT-FILENAME    TO  ORCA-BLOB-FILE
           MOVE   LOW-VALUE        TO  ORCA-BLOB-OBJECT
           CALL   'ORCDBMAIN'      USING
                                   MCPAREA
                                   ORCA-BLOB
                                   SPA-AREA
           IF ORCA-BLOB-OBJECT     = LOW-VALUE
             MOVE   'BLOBIMPORT' TO  MCP-FUNC
             STRING "/tmp/"      DELIMITED   BY  SIZE
                    MPRT-FILENAME
                                 DELIMITED   BY  SPACE
             INTO   ORCA-BLOB-FILE 
             END-STRING
             MOVE  ORCA-BLOB-FILE    TO  WK-FILE-NAME
                                         WK-FILE-NAME2
             PERFORM 110-FILE-ID
             IF    ORCF-RET          NOT = ZERO
      *            DISPLAY "FILE NOT EXIST"
                   GO              TO  200-MAIN-EXT
             END-IF
             MOVE   LOW-VALUE        TO  ORCA-BLOB-OBJECT
             CALL   'ORCDBMAIN'      USING
                                     MCPAREA
                                     ORCA-BLOB
                                     SPA-AREA
             IF ORCA-BLOB-OBJECT     = LOW-VALUE
                DISPLAY "imp ORCA-BLOB-OBJECT is LOW-VALUE " 
             ELSE
                DISPLAY "imp ORCA-BLOB-OBJECT is not LOW-VALUE " 
             END-IF
           IF ORCA-BLOB-OBJECT    NOT = LOW-VALUE
             PERFORM 110-CTRLFILE-CHECK
             MOVE   'blob'         TO  MCP-TABLE
             MOVE   'key'          TO  MCP-PATHNAME
             MOVE   MPRT-FILENAME  TO  ORCA-BLOB-FILE
             MOVE   'BLOBREGISTER' TO  MCP-FUNC
             CALL   'ORCDBMAIN'      USING
                                     MCPAREA
                                     ORCA-BLOB
                                     SPA-AREA
             PERFORM 110-FILE-DEL
             PERFORM 11011-DBDEL-SEC
           END-IF
           ELSE
             STRING "/tmp/"      DELIMITED   BY  SIZE
                    MPRT-FILENAME
                                 DELIMITED   BY  SPACE
             INTO   ORCA-BLOB-FILE 
             END-STRING
             MOVE  ORCA-BLOB-FILE    TO  WK-FILE-NAME
                                         WK-FILE-NAME2
             PERFORM 110-FILE-DEL
             PERFORM 11011-DBDEL-SEC
           END-IF
           MOVE ORCA-BLOB-OBJECT   TO MPRT-BODY
      *
           MOVE    SPA-AREA        TO  SPA-COMMON
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    印刷データ存在チェック
      *****************************************************************
       300-CANCEL-CHECK-SEC        SECTION.
      *
      *--------> ここで印刷APIをキャンセルするURLを設定する。
      *    IF      FLG-ONLINE      =   1
      *      IF    PRTCTRL-SHORI-RENNUM  =  99
      *        PERFORM 2001-99DEL-SEC
      *      ELSE
      *        PERFORM 210-PRTDATA-EXIST-SEC
      *      END-IF
      *    END-IF
      * 
           IF      FLG-CANCEL      =   1
             DISPLAY "This data cansel " 
                      MPRT-FILENAME 
      *      MOVE  500                 TO  MPRT-HTTPSTATUS
             MOVE  204                 TO  MPRT-HTTPSTATUS
           END-IF
      *
           .
       300-CANCEL-CHECK-EXT.
           EXIT.
      *****************************************************************
      *    印刷データ存在チェック
      *****************************************************************
       210-PRTDATA-EXIST-SEC       SECTION.
      *
           MOVE    PRTCTRL-REC         TO  WKPRTCTRL-REC
           DISPLAY "PRTCTRL-SHORI-RENNUM = "
                                  PRTCTRL-SHORI-RENNUM
           MOVE    99                  TO  PRTCTRL-SHORI-RENNUM
           PERFORM 1101-CTRLDATA-READ-SEC
           MOVE    WKPRTCTRL-REC   TO  PRTCTRL-REC
           IF      FLG-PRTCTRL         = ZERO
      *    DISPLAY "CTRL DATA HIT !!"
               MOVE    99              TO  PRTCTRL-SHORI-RENNUM
               MOVE    2               TO  PRTCTRL-DATA-KBN
               MOVE    2               TO  PRTCTRL-CONT-FLG
               MOVE    1               TO  PRTCTRL-PAGE
      *        PERFORM 1101-CTRLDATA-UPDATE-SEC
               MOVE    WKPRTCTRL-REC   TO  PRTCTRL-REC
               PERFORM 1101-CTRLDATA-READ-SEC
               IF  FLG-PRTCTRL         = 1
                   MOVE  1             TO  FLG-CANCEL
               END-IF
      *    DISPLAY "MAI2 PRTCTRL-SHORI-RENNUM = " PRTCTRL-SHORI-RENNUM
      *        IF      FLG-PRTCTRL     NOT = ZERO
      *        DISPLAY "NO " PRTCTRL-SHORI-RENNUM " PRINT DATA NOT"
      *        ELSE
      *        DISPLAY "NO " PRTCTRL-SHORI-RENNUM " PRINT DATA HIT"
      *        END-IF
           END-IF
      *
           .
       210-PRTDATA-EXIST-EXT.
           EXIT.
      *****************************************************************
      *    日付編集処理
      *****************************************************************
       801-DAYHEN01-SEC                SECTION.
      *
           INITIALIZE                  WRK-HEN-DATE
           MOVE    WRK-SYY             TO  WRK-HEN-YY
           MOVE    WRK-SMM             TO  WRK-HEN-MM
           MOVE    WRK-SDD             TO  WRK-HEN-DD
           MOVE    "-"                 TO  WRK-HEN-H1
           MOVE    "-"                 TO  WRK-HEN-H2
           IF      WRK-SYMD            =   "99999999"
               MOVE    "12"                TO  WRK-HEN-MM
               MOVE    "31"                TO  WRK-HEN-DD
           END-IF
      *
           IF      WRK-TSS             =   SPACE
               MOVE    ZERO                TO  WRK-TSS
           END-IF
           INITIALIZE                  WRK-HEN-TIME
           MOVE    WRK-THH             TO  WRK-HEN-THH
           MOVE    WRK-TMM             TO  WRK-HEN-TMM
           MOVE    WRK-TSS             TO  WRK-HEN-TSS
           MOVE    ":"                 TO  WRK-HEN-T1
           MOVE    ":"                 TO  WRK-HEN-T2
           .
       801-DAYHEN01-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイルチェック　処理
      *****************************************************************
       110-FILE-CHECK                SECTION.
      * MPRT-FILENAME の文字数をチェック(75以上は、オンライン帳票)
           MOVE    100                 TO  IDZ
           PERFORM VARYING     IDX     FROM    99   BY  -1
                   UNTIL       IDX     <   1
               IF  MPRT-FILENAME(IDX:1)    =   SPACE
                   COMPUTE IDZ         =   IDZ - 1
               ELSE
                   MOVE  1             TO  IDX
               END-IF
           END-PERFORM
      *
           IF      IDZ                 <   75
               GO  TO                  110-FILE-CHECK-EXT
           END-IF
           MOVE    1                   TO  FLG-ONLINE
      *  MPRT-FILENAME を分割してキーを生成
           MOVE    SPA-HOSPNUM         TO  PRTCTRL-HOSPNUM
           MOVE    SPA-TERMID          TO  PRTCTRL-TERMID
           MOVE    2                   TO  PRTCTRL-DATA-KBN
           MOVE    MPRT-FILENAME(3:6)
                                       TO  PRTCTRL-TBL-KEY
           MOVE    MPRT-FILENAME(9:4)
                                       TO  PRTCTRL-RENNUM
           MOVE    MPRT-FILENAME(13:14)
                                       TO  PRTCTRL-TBL-GROUP
           MOVE    MPRT-FILENAME(27:4)
                                       TO  PRTCTRL-SHORI-RENNUM
           MOVE    MPRT-FILENAME(31:5)
                                       TO  WK-ED-PAGE
           MOVE    MPRT-FILENAME(36:5)
                                       TO  WK-ST-PAGE
           MOVE    MPRT-FILENAME(41:36)
                                       TO  PRTCTRL-TBL-UUID
      *
             STRING "/tmp/"      DELIMITED   BY  SIZE
                    SPA-HOSPNUM  DELIMITED   BY  SPACE
                    PRTCTRL-TBL-KEY
                                 DELIMITED   BY  SPACE
                    PRTCTRL-RENNUM
                                 DELIMITED   BY  SPACE
                    PRTCTRL-TBL-GROUP
                                 DELIMITED   BY  SPACE
                    "0099"
                                 DELIMITED   BY  SIZE
                    WK-ED-PAGE
                                 DELIMITED   BY  SPACE
                    WK-ST-PAGE
                                 DELIMITED   BY  SPACE
                    PRTCTRL-TBL-UUID
                                 DELIMITED   BY  SPACE
                    ".pdf"
                                 DELIMITED   BY  SIZE
             INTO   WK-FILE-NAME
             END-STRING
      *    DISPLAY "IN PRTCTRL-SHORI-RENNUM = " PRTCTRL-SHORI-RENNUM
           .
       110-FILE-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    PRTCTRLデータ検索　処理
      *****************************************************************
       110-CTRLFILE-CHECK                SECTION.
      * MPRT-FILENAME の文字数をチェック(75以上は、オンライン帳票)
           MOVE    100                 TO  IDZ
           PERFORM VARYING     IDX     FROM    99   BY  -1
                   UNTIL       IDX     <   1
               IF  MPRT-FILENAME(IDX:1)    =   SPACE
                   COMPUTE IDZ         =   IDZ - 1
               ELSE
                   MOVE  1             TO  IDX
               END-IF
           END-PERFORM
      *
           IF      IDZ                 <   75
               GO  TO                  110-CTRLFILE-CHECK-EXT
           END-IF
      *  MPRT-FILENAME を分割してキーを生成
           MOVE    SPA-HOSPNUM         TO  PRTCTRL-HOSPNUM
           MOVE    SPA-TERMID          TO  PRTCTRL-TERMID
      *    MOVE    2                   TO  PRTCTRL-DATA-KBN
      *    EVALUATE    IDZ
      *        WHEN    80
                   MOVE    MPRT-FILENAME(3:6)
                                       TO  PRTCTRL-TBL-KEY
                   MOVE    MPRT-FILENAME(9:4)
                                       TO  PRTCTRL-RENNUM
                   MOVE    MPRT-FILENAME(13:14)
                                       TO  PRTCTRL-TBL-GROUP
                   MOVE    MPRT-FILENAME(27:4)
                                       TO  PRTCTRL-SHORI-RENNUM
                   MOVE    MPRT-FILENAME(41:36)
                                       TO  PRTCTRL-TBL-UUID
      *        WHEN    81
      *            MOVE    MPRT-FILENAME(3:7)
      *                                TO  PRTCTRL-TBL-KEY
      *            MOVE    MPRT-FILENAME(10:4)
      *                                TO  PRTCTRL-RENNUM
      *            MOVE    MPRT-FILENAME(14:14)
      *                                TO  PRTCTRL-TBL-GROUP
      *            MOVE    MPRT-FILENAME(28:4)
      *                                TO  PRTCTRL-SHORI-RENNUM
      *            MOVE    MPRT-FILENAME(42:36)
      *                                TO  PRTCTRL-TBL-UUID
      *    END-EVALUATE
      *
           MOVE    PRTCTRL-REC         TO  WKPRTCTRL-REC
           PERFORM 1101-CTRLDATA-READ-SEC
      *
      *    IF      FLG-PRTCTRL             = ZERO
      *        PERFORM 11011-DBDEL-SEC
      *    END-IF
      *
      *
      *    DISPLAY "-----------------------------------------"
      *    DISPLAY "PRTCTRL-HOSPNUM = " PRTCTRL-HOSPNUM
      *    DISPLAY "PRTCTRL-TERMID = " PRTCTRL-TERMID
      *    DISPLAY "PRTCTRL-TBL-KEY = " PRTCTRL-TBL-KEY
      *    DISPLAY "PRTCTRL-RENNUM  = " PRTCTRL-RENNUM
      *    DISPLAY "PRTCTRL-TBL-GROUP = " PRTCTRL-TBL-GROUP
      *    DISPLAY "PRTCTRL-TBL-UUID = " PRTCTRL-TBL-UUID
      *    DISPLAY "PRTCTRL-SHORI-RENNUM = " PRTCTRL-SHORI-RENNUM
      *    DISPLAY "MCP-TERM = " MCP-TERM
      *    DISPLAY "-----------------------------------------"
           .
       110-CTRLFILE-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷制御(99レコード)検索、削除　処理
      *****************************************************************
       2001-99DEL-SEC              SECTION.
      *
           MOVE    PRTCTRL-REC         TO  WKPRTCTRL-REC
           MOVE    99                  TO  PRTCTRL-SHORI-RENNUM
           PERFORM 1101-CTRLDATA-READ-SEC
           IF      FLG-PRTCTRL         = ZERO
               DISPLAY "PRTCTRL-CONT-FLG = " PRTCTRL-CONT-FLG
               MOVE  PRTCTRL-CONT-FLG  TO  WK-CONT-FLG
           END-IF
           MOVE    WKPRTCTRL-REC       TO  PRTCTRL-REC
           IF      FLG-PRTCTRL         = ZERO
               PERFORM 20011-NOMALDATA-READ-SEC
               IF  FLG-PRTCTRL         =   1
                   PERFORM 20011-99DELETE-SEC
               ELSE
                   DISPLAY "ALL DATA NOT YET !!"
               END-IF
           ELSE
               DISPLAY "CHECK SKIP"
           END-IF
           .
       2001-99DEL-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    印刷制御(99レコード)検索、削除　処理
      *****************************************************************
       20011-99DELETE-SEC             SECTION.
      *
           DISPLAY "WK-CONT-FLG = " WK-CONT-FLG
           IF      WK-CONT-FLG         =  1
                   MOVE  1             TO  FLG-CANCEL
                   DISPLAY "================="
                   DISPLAY "ALL DATA WRITE !!"
                   DISPLAY "ALL DATA WRITE !!"
                   DISPLAY "ALL DATA WRITE !!"
                   DISPLAY "================="
                   PERFORM 11011-DBDEL-SEC
                   STRING "/tmp/"      DELIMITED   BY  SIZE
                       MPRT-FILENAME
                                       DELIMITED   BY  SPACE
                   INTO   ORCA-BLOB-FILE 
                   END-STRING
                   MOVE  ORCA-BLOB-FILE    TO  WK-FILE-NAME
                                               WK-FILE-NAME2
                   PERFORM 110-FILE-DEL
           ELSE
           DISPLAY "PRTCTRL-CONT-FLG set 1  " 
               MOVE    99              TO  PRTCTRL-SHORI-RENNUM
               MOVE    2               TO  PRTCTRL-DATA-KBN
               MOVE    1               TO  PRTCTRL-CONT-FLG
               MOVE    1               TO  PRTCTRL-PAGE
               PERFORM 1101-CTRLDATA-UPDATE-SEC
           END-IF
      *
           .
       20011-99DELETE-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷制御(99以外レコード)検索、削除　処理
      *****************************************************************
       20011-NOMALDATA-READ-SEC    SECTION.
      *
           MOVE    "tbl_prtctrl"       TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           MOVE    PRTCTRL-REC         TO  MCPDATA-REC
           PERFORM 900-DBSELECT-SEC
      *
           IF      MCP-RC              =   ZERO
      *        MOVE    MCPDATA-REC         TO  PRTCTRL-REC
               MOVE    ZERO                TO  FLG-PRTCTRL
           ELSE
               MOVE    1                   TO  FLG-PRTCTRL
               DISPLAY "SYSTEM ERR !!"
               GO                          TO  1101-CTRLDATA-READ-EXT
           END-IF
           MOVE    "tbl_prtctrl"       TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           MOVE    PRTCTRL-REC         TO  MCPDATA-REC
           PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  PRTCTRL-REC
               MOVE    ZERO                TO  FLG-PRTCTRL
           ELSE
               MOVE    1                   TO  FLG-PRTCTRL
      *        DISPLAY "PRTCTRL DATA NOT FOUND"
      *        GO                          TO  1101-CTRLDATA-READ-EXT
           END-IF
           MOVE    "tbl_prtctrl"       TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           MOVE    PRTCTRL-REC         TO  MCPDATA-REC
           PERFORM 900-DBCLOSE-SEC
           .
       2001-99DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷データ検索　処理
      *****************************************************************
       1101-CTRLDATA-READ-SEC        SECTION.
      *
           MOVE    "tbl_prtctrl"       TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           MOVE    PRTCTRL-REC         TO  MCPDATA-REC
           PERFORM 900-DBSELECT-SEC
      *
           IF      MCP-RC              =   ZERO
      *        MOVE    MCPDATA-REC         TO  PRTCTRL-REC
               MOVE    ZERO                TO  FLG-PRTCTRL
           ELSE
               MOVE    1                   TO  FLG-PRTCTRL
               DISPLAY "SYSTEM ERR !!"
               GO                          TO  1101-CTRLDATA-READ-EXT
           END-IF
           MOVE    "tbl_prtctrl"       TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           MOVE    PRTCTRL-REC         TO  MCPDATA-REC
           PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  PRTCTRL-REC
               MOVE    ZERO                TO  FLG-PRTCTRL
           ELSE
               MOVE    1                   TO  FLG-PRTCTRL
      *        DISPLAY "PRTCTRL DATA NOT FOUND"
      *        GO                          TO  1101-CTRLDATA-READ-EXT
           END-IF
           MOVE    "tbl_prtctrl"       TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           MOVE    PRTCTRL-REC         TO  MCPDATA-REC
           PERFORM 900-DBCLOSE-SEC
      *
      *    IF      PRTCTRL-PAGE        =   ZERO
      *        MOVE  PRTCTRL-QR-DATA   TO  ORCSQRENCODEAREA
      *        MOVE  QREN-FILENAME     TO  FILE-NAME1
      *        OPEN    OUTPUT          QRCSV-FILE
      *      IF    STS-FILE1           NOT =   ZERO
      *        DISPLAY "QRCSV-FILE OPEN ERR"
      *      END-IF
      *    END-IF
      *
      *    PERFORM 900-CTRLFETCH-SEC
      *    PERFORM UNTIL     FLG-PRTCTRL   = 1
      *        MOVE  PRTCTRL-QR-DATA   TO  QRCSV-REC
      *        WRITE QRCSV-REC
      *    DISPLAY "QR DATA write !!"
      *        PERFORM 900-CTRLFETCH-SEC
      *    END-PERFORM
      *
      *    CLOSE                       QRCSV-FILE
      *    CALL    "orcqrencode"       USING   ORCSQRENCODEAREA
      *
           .
       1101-CTRLDATA-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷データ検索　処理
      *****************************************************************
       1101-CTRLDATA-UPDATE-SEC        SECTION.
      *
           MOVE    "tbl_prtctrl"       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           MOVE    PRTCTRL-REC         TO  MCPDATA-REC
           PERFORM 900-DBUPDATE-SEC
      *
           IF      MCP-RC              =   ZERO
      *        MOVE    MCPDATA-REC         TO  PRTCTRL-REC
               MOVE    ZERO                TO  FLG-PRTCTRL
           ELSE
               MOVE    1                   TO  FLG-PRTCTRL
               DISPLAY "SYSTEM ERR !!"
           END-IF
      *
           .
       1101-CTRLDATA-UPDATE-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷データ検索　処理
      *****************************************************************
       11011-DBDEL-SEC             SECTION.
      * ----> 印刷管理、印刷データ、印刷制御を削除
           IF      PRTCTRL-DATA-KBN    =  2
               PERFORM 800-PRTKANRIDEL-SEC
               PERFORM 800-PRTDATADEL-SEC
               PERFORM 800-PRTCTRlDEL-SEC
           ELSE
               PERFORM 800-PRTCTRlDEL-SEC
           END-IF
      *
      *
           .
       11011-DBDEL-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    印刷管理データ削除　処理
      *****************************************************************
       800-PRTKANRIDEL-SEC             SECTION.
      * ----> 印刷管理、印刷データ、印刷制御を削除
      *    DISPLAY "-------------DELETE st--------------------"
      *    DISPLAY "PRTCTRL-HOSPNUM = " PRTCTRL-HOSPNUM
      *    DISPLAY "PRTCTRL-TERMID = " PRTCTRL-TERMID
      *    DISPLAY "PRTCTRL-TBL-KEY = " PRTCTRL-TBL-KEY
      *    DISPLAY "PRTCTRL-RENNUM  = " PRTCTRL-RENNUM
      *    DISPLAY "PRTCTRL-TBL-GROUP = " PRTCTRL-TBL-GROUP
      *    DISPLAY "PRTCTRL-TBL-UUID = " PRTCTRL-TBL-UUID
      *    DISPLAY "PRTCTRL-SHORI-RENNUM = " PRTCTRL-SHORI-RENNUM
      *    DISPLAY "PRTCTRL-DATA-KBN = " PRTCTRL-DATA-KBN
      *    DISPLAY "-------------DELETE ed--------------------"
           INITIALIZE                  PRTKANRI-REC
           MOVE    PRTCTRL-HOSPNUM     TO  PRTKANRI-HOSPNUM
           MOVE    PRTCTRL-TBL-KEY     TO  PRTKANRI-TBL-KEY
           MOVE    PRTCTRL-RENNUM      TO  PRTKANRI-RENNUM
           MOVE    PRTCTRL-TBL-GROUP   TO  PRTKANRI-TBL-GROUP
           MOVE    PRTCTRL-TBL-UUID    TO  PRTKANRI-TBL-UUID
           MOVE    PRTCTRL-SHORI-RENNUM
                                       TO  PRTKANRI-SHORI-RENNUM
           MOVE    "tbl_prtkanri"      TO  MCP-TABLE
           MOVE    "del14"             TO  MCP-PATHNAME
           MOVE    PRTKANRI-REC        TO  MCPDATA-REC
           PERFORM 900-DBDELETE-SEC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "SYSTEM ERR dbkanri not delete "
           END-IF
      *
           .
       800-PRTKANRIDEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷データ削除　処理
      *****************************************************************
       800-PRTDATADEL-SEC             SECTION.
      * ----> 印刷管理、印刷データ、印刷制御を削除
           INITIALIZE                  PRTDATA-REC
           MOVE    PRTCTRL-HOSPNUM     TO  PRTDATA-HOSPNUM
           MOVE    PRTCTRL-TBL-KEY     TO  PRTDATA-TBL-KEY
           MOVE    PRTCTRL-RENNUM      TO  PRTDATA-RENNUM
           MOVE    PRTCTRL-TBL-GROUP   TO  PRTDATA-TBL-GROUP
           MOVE    PRTCTRL-TBL-UUID    TO  PRTDATA-TBL-UUID
           MOVE    PRTCTRL-SHORI-RENNUM
                                       TO  PRTDATA-SHORI-RENNUM
           MOVE    "tbl_prtdata"       TO  MCP-TABLE
           MOVE    "del14"             TO  MCP-PATHNAME
           MOVE    PRTDATA-REC         TO  MCPDATA-REC
           PERFORM 900-DBDELETE-SEC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "SYSTEM ERR prtdata not delete "
           END-IF
      *
           .
       800-PRTDATADEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷制御データ削除　処理
      *****************************************************************
       800-PRTCTRlDEL-SEC             SECTION.
      * ----> 印刷管理、印刷データ、印刷制御を削除
      *    DISPLAY "---------prtctrl DELETE st--------------------"
      *    DISPLAY "PRTCTRL-HOSPNUM = " PRTCTRL-HOSPNUM
      *    DISPLAY "PRTCTRL-TERMID = " PRTCTRL-TERMID
      *    DISPLAY "PRTCTRL-TBL-KEY = " PRTCTRL-TBL-KEY
      *    DISPLAY "PRTCTRL-RENNUM  = " PRTCTRL-RENNUM
      *    DISPLAY "PRTCTRL-TBL-GROUP = " PRTCTRL-TBL-GROUP
      *    DISPLAY "PRTCTRL-TBL-UUID = " PRTCTRL-TBL-UUID
      *    DISPLAY "PRTCTRL-SHORI-RENNUM = " PRTCTRL-SHORI-RENNUM
      *    DISPLAY "PRTCTRL-DATA-KBN = " PRTCTRL-DATA-KBN
      *    DISPLAY "-------------DELETE ed--------------------"
      *
           MOVE    "tbl_prtctrl"       TO  MCP-TABLE
           MOVE    "del11"             TO  MCP-PATHNAME
           MOVE    PRTCTRL-REC         TO  MCPDATA-REC
           PERFORM 900-DBDELETE-SEC
      *
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "SYSTEM ERR prtctrl not delete "
           END-IF
      *
           .
       800-PRTCTRlDEL-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    印刷データ検索　処理
      *****************************************************************
       110-FILE-ID                 SECTION.
      *
           MOVE    "r"                 TO  ORCF-FILE-MODE
           IF    WRK-FILE-TYPE =   ".ps"
               INSPECT WK-FILE-NAME REPLACING  ALL "ps " BY  "api"
           ELSE
               INSPECT WK-FILE-NAME REPLACING  ALL "pdf" BY  "api"
           END-IF
           MOVE    WK-FILE-NAME        TO  ORCF-FILE-NAME
           CALL    "orcfileio"         USING ST  ORCFILEGET-AREA
      *    IF      ORCF-RET            =   ZERO
      *            DISPLAY "file exist"
      *    ELSE
      *            DISPLAY "file NO"
      *    END-IF
      *
           .
       110-FILE-IO-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷データ削除　処理
      *****************************************************************
       110-FILE-DEL                SECTION.
      *
      *    DISPLAY "WRK-FILE-TYPE = " WRK-FILE-TYPE
           IF    WRK-FILE-TYPE =   ".ps"
               MOVE    ZERO            TO  IF-RESULT
               MOVE    WK-FILE-NAME2   TO  IF-FILENAME
               CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
               INSPECT WK-FILE-NAME2 REPLACING  ALL "ps " BY  "api"
               MOVE    ZERO            TO  IF-RESULT
               MOVE    WK-FILE-NAME2   TO  IF-FILENAME
               CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
               INSPECT WK-FILE-NAME2 REPLACING  ALL "api" BY  "pdf"
      *    DISPLAY "FILE del start "  WK-FILE-NAME2
               MOVE    ZERO            TO  IF-RESULT
               MOVE    WK-FILE-NAME2   TO  IF-FILENAME
               CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
           ELSE
               MOVE    ZERO            TO  IF-RESULT
               MOVE    WK-FILE-NAME2   TO  IF-FILENAME
               CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
      *    DISPLAY "FILE del start "  IF-FILENAME(1:90)
               INSPECT WK-FILE-NAME2 REPLACING  ALL "pdf" BY  "api"
               MOVE    ZERO            TO  IF-RESULT
               MOVE    WK-FILE-NAME2   TO  IF-FILENAME
               CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
      *    DISPLAY "IF-RESULT =  "  IF-RESULT
      *    DISPLAY "FILE del start "  IF-FILENAME(1:90)
               INSPECT WK-FILE-NAME2 REPLACING  ALL "api" BY  "ps "
               MOVE    ZERO            TO  IF-RESULT
               MOVE    WK-FILE-NAME2   TO  IF-FILENAME
      *    DISPLAY "FILE del start "  IF-FILENAME(1:90)
               CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
           END-IF
      *
           .
       110-FILE-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    端末種別取得処理(印刷APIでは、AGENTが取得不能か
      *****************************************************************
       100-AGENTGET-SEC            SECTION.
      *
           MOVE    MPRT-FILENAME       TO  WK-FILE-OC-AREA
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   256
               IF  WK-FILE-OC(IDX)     =   SPACE
                   MOVE  IDX           TO  IDY
                   MOVE  256           TO  IDX
               END-IF
           END-PERFORM 
           COMPUTE IDX = IDY - 3
      *    DISPLAY "MPRT-FILENAME(IDX:3) = " MPRT-FILENAME(IDX:3)
           IF    MPRT-FILENAME(IDX:3)  =   ".ps"
                 MOVE  ".ps"           TO  WRK-FILE-TYPE
                 DISPLAY "ps hit !!"
           ELSE
                 DISPLAY "pdf hit !!"
                 MOVE  ".pdf"          TO  WRK-FILE-TYPE
           END-IF
      *    AGENT 取得
      *    INITIALIZE                      ORCA-SYSTEM
      *    MOVE    "GETVALUE"          TO  MCP-FUNC
      *    MOVE    MCP-TERM            TO  ORCA-SYSTEM-ID
      *    MOVE    10                  TO  ORCA-SYSTEM-NUM
      *    MOVE    "agent"             TO  ORCA-SYSTEM-KEY(1)
      *    MOVE    ORCA-SYSTEM         TO  MCPDATA-REC
      *    MOVE    "system"            TO  MCP-TABLE
      *    MOVE    "key"               TO  MCP-PATHNAME
      *    CALL   "ORCDBMAIN"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *                                SPA-AREA
      *    IF    ( MCP-RC              =   ZERO    OR  1 )
      *        MOVE    MCPDATA-REC         TO  ORCA-SYSTEM
      *    ELSE
      *        INITIALIZE                      ORCA-SYSTEM
      *    END-IF
      *
      *    DISPLAY "ORCA-SYSTEM-VALUE(1)(1:9) = "
      *               ORCA-SYSTEM-VALUE(1)(1:9)
      *
      *    IF    ORCA-SYSTEM-VALUE(1)(1:9) = "glclient/"
      *          MOVE  ".ps"           TO  WRK-FILE-TYPE
      *    ELSE
      *          MOVE  ".pdf"          TO  WRK-FILE-TYPE
      *    END-IF
      *
           .
       100-AGENTGET-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル更新処理
      *****************************************************************
       900-DBUPDATE-SEC            SECTION.
      *
           MOVE    "DBUPDATE"      TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
       900-DBUPDATE-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       900-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
       900-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル読み込み処理
      *****************************************************************
       900-CTRLFETCH-SEC                SECTION.
      *
           MOVE    "tbl_prtctrl"       TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           MOVE    PRTCTRL-REC         TO  MCPDATA-REC
           PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  PRTCTRL-REC
               MOVE    ZERO                TO  FLG-PRTCTRL
           ELSE
               MOVE    1                   TO  FLG-PRTCTRL
               DISPLAY "QR DATA AT END"
           END-IF
      *
           .
       900-CTRLFETCH-EXT.
           EXIT.
      *****************************************************************
      *    テーブル読み込み処理
      *****************************************************************
       900-DBFETCH-SEC                SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
       900-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル削除処理
      *****************************************************************
       900-DBDELETE-SEC            SECTION.
      *
           MOVE    "DBDELETE"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
       900-DBDELETE-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルCLOSE処理
      *****************************************************************
       900-DBCLOSE-SEC                SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
       900-DBCLOSE-EXT.
           EXIT.
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
