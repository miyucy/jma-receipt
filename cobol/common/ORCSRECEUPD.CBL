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
       PROGRAM-ID.             ORCSRECEUPD.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : 
      *  管理者            : レセプト管理更新処理
      *  05/02/08    NACL−藤原    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-多々納  05/11/11  MONFUNC 対応 他
      *  03.05.00    NACL-多々納  07/04/XX  グループ診療対応
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
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-JYURRK          PIC 9(01).
           03  FLG-RECEUPD         PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
      *
       01  WRK-AREA.
           03  WRK-SYSYMD.
               05  WRK-SYSYM       PIC X(06).
               05  WRK-SYSDD       PIC 9(02).
      *
           03  WRK-MCP-TABLE       PIC X(64).
           03  WRK-MCP-PATHNAME    PIC X(64).
      *     
      **** COPY    "ORCA-DBPATH".
           COPY    "ORCA-DBMETA".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    受診履歴
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *    レセプト作成管理
       01  RECEUPD-REC.
           COPY    "CPRECEUPD.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      **** COPY    "CPORCMCP.INC".
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPORCSRECEUPD.INC".
grpsys*
grpsys      COPY    "COMMON-SPA".
      *****************************************************************
     *
       PROCEDURE                   DIVISION    USING
                                   ORCSRECEUPDAREA
           SPA-AREA.
     *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *    
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
      *    更新日取得
           INITIALIZE                  ORCSMCNDATEAREA
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
      *
           MOVE    SMCNDATE-YMD        TO  WRK-SYSYMD
           IF      WRK-SYSDD           <=   10
               INITIALIZE                   STS-AREA-DAY
               INITIALIZE                   LNK-DAY6-AREA
               MOVE  "61"                   TO  LNK-DAY6-IRAI
               MOVE  WRK-SYSYMD             TO  LNK-DAY6-KIJUN
               MOVE  "2"                    TO  LNK-DAY6-ZOGENPTN
               MOVE  -1                     TO  LNK-DAY6-ZOGEN
               CALL  "ORCSDAY"              USING   STS-AREA-DAY
                                                    LNK-DAY6-AREA
               MOVE    LNK-DAY6-KEISAN      TO  WRK-SYSYMD 
           END-IF
      *
           MOVE    ZERO                TO  LNK-UPD-RC
      *
           EVALUATE    LNK-UPD-SYORI
               WHEN    "1"
                   INITIALIZE                  JYURRK-REC
                   MOVE    LNK-UPD-HOSPNUM TO  JYURRK-HOSPNUM
                   MOVE    LNK-UPD-PTID    TO  JYURRK-PTID
                   MOVE    WRK-SYSYMD(1:6) TO  JYURRK-SRYYMD (1:6)
                   MOVE    "__"            TO  JYURRK-SRYYMD (7:2)
                   MOVE    "tbl_jyurrk"    TO  WRK-MCP-TABLE
                   MOVE    "key27"         TO  WRK-MCP-PATHNAME
                   PERFORM 200-HENSYU-SEC
               WHEN    "2"
                   INITIALIZE                  JYURRK-REC
                   MOVE    LNK-UPD-HOSPNUM TO  JYURRK-HOSPNUM
                   MOVE    LNK-UPD-PTID    TO  JYURRK-PTID
                   MOVE    LNK-UPD-NYUGAIKBN
                                           TO  JYURRK-NYUGAIKBN
                   MOVE    LNK-UPD-SRYYM   TO  JYURRK-SRYYMD (1:6)
                   MOVE    "__"            TO  JYURRK-SRYYMD (7:2)
                   MOVE    LNK-UPD-HKNKBN  TO  JYURRK-HKNKBN
                   MOVE    "tbl_jyurrk"    TO  WRK-MCP-TABLE
                   MOVE    "key28"         TO  WRK-MCP-PATHNAME
                   PERFORM 200-HENSYU-SEC
               WHEN    OTHER
                   MOVE    "1"             TO  LNK-UPD-RC
           END-EVALUATE
           .
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
      *     
      *****************************************************************
      *    レセプト作成管理編集処理
      *****************************************************************
       200-HENSYU-SEC            SECTION.
      *
           MOVE    "tbl_jyurrk"        TO  MCP-TABLE
           MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    JYURRK-REC          TO  MCPDATA-REC
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_jyurrk"        TO  MCP-TABLE
               MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
               PERFORM 900-JYURRK-READ-N-SEC
           ELSE
               MOVE    1                  TO  FLG-JYURRK
           END-IF
      *
           PERFORM     UNTIL       FLG-JYURRK     =   1
                       OR          LNK-UPD-RC NOT =   ZERO
               INITIALIZE                  RECEUPD-REC
               MOVE    JYURRK-HOSPNUM  TO  RECEUPD-HOSPNUM
               MOVE    JYURRK-NYUGAIKBN
                                       TO  RECEUPD-NYUGAIKBN
               MOVE    JYURRK-PTID     TO  RECEUPD-PTID
               MOVE    JYURRK-SRYKA    TO  RECEUPD-SRYKA
               MOVE    JYURRK-SRYYMD (1:6)
                                       TO  RECEUPD-SRYYM
               MOVE    JYURRK-HKNKBN   TO  RECEUPD-HKNKBN
               MOVE    SPACE           TO  RECEUPD-HKNKBN2
               PERFORM 900-RECEUPD-READ-SEC
               IF      FLG-RECEUPD     =   1
                   INITIALIZE                  RECEUPD-REC
                   MOVE    JYURRK-HOSPNUM  TO  RECEUPD-HOSPNUM
                   MOVE    JYURRK-NYUGAIKBN
                                           TO  RECEUPD-NYUGAIKBN
                   MOVE    JYURRK-PTID     TO  RECEUPD-PTID
                   MOVE    JYURRK-SRYKA    TO  RECEUPD-SRYKA
                   MOVE    JYURRK-SRYYMD (1:6)
                                           TO  RECEUPD-SRYYM
                   MOVE    JYURRK-HKNKBN   TO  RECEUPD-HKNKBN
                   MOVE    SPACE           TO  RECEUPD-HKNKBN2
               END-IF
      *
               MOVE    "1"             TO  RECEUPD-ONLUPD
      *
               EVALUATE    FLG-RECEUPD
                   WHEN    1
                       MOVE    LNK-UPD-TERMID      TO  RECEUPD-TERMID
                       MOVE    LNK-UPD-OPID        TO  RECEUPD-OPID
                       MOVE    SMCNDATE-YMD        TO  RECEUPD-CREYMD
                       MOVE    SMCNDATE-YMD        TO  RECEUPD-UPYMD
                       MOVE    SMCNDATE-HMS        TO  RECEUPD-UPHMS
                       MOVE    "DBINSERT"          TO  MCP-FUNC
                   WHEN    ZERO
                       MOVE    SMCNDATE-YMD        TO  RECEUPD-UPYMD
                       MOVE    SMCNDATE-HMS        TO  RECEUPD-UPHMS
                       MOVE    "DBUPDATE"          TO  MCP-FUNC
               END-EVALUATE    
      *
               MOVE    RECEUPD-REC         TO  MCPDATA-REC
               MOVE    "tbl_receupd"       TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
grpsys         CALL    "ORCDBMAIN"         USING   MCPAREA
                                                   MCPDATA-REC
                                                   SPA-AREA
               IF      MCP-RC          NOT =   ZERO
                   MOVE    "2"                 TO  LNK-UPD-RC
               ELSE
                   MOVE    "tbl_jyurrk"        TO  MCP-TABLE
                   MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
                   PERFORM 900-JYURRK-READ-N-SEC
               END-IF
           END-PERFORM      
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           MOVE    "tbl_jyurrk"        TO  MCP-TABLE
           MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
       200-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト作成管理読込
      *****************************************************************
       900-RECEUPD-READ-SEC         SECTION.
      *
           MOVE    RECEUPD-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "tbl_receupd"       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_receupd"       TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               MOVE    "DBFETCH"           TO  MCP-FUNC
grpsys         CALL    "ORCDBMAIN"         USING   MCPAREA
                                                   MCPDATA-REC
                                                   SPA-AREA
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-RECEUPD
                   MOVE    MCPDATA-REC         TO  RECEUPD-REC
               ELSE
                  MOVE    1                    TO  FLG-RECEUPD
               END-IF
           ELSE
               MOVE    1                       TO  FLG-RECEUPD
           END-IF
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           MOVE    "tbl_receupd"       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
       900-RECEUPD-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴読込
      *****************************************************************
       900-JYURRK-READ-N-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-JYURRK
               MOVE    MCPDATA-REC     TO  JYURRK-REC
           ELSE
              MOVE    1               TO  FLG-JYURRK
              INITIALIZE                  JYURRK-REC
           END-IF
           .
       900-JYURRK-READ-N-EXT.
           EXIT.
      *
