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
      ******************************************************************
      *
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCL0012.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : ＣＬＡＩＭ
      *  コンポーネント名  : ＣＬＡＩＭ送信済み設定
      *  管理者            : 
      *  作成日付    作業者        記述
      *  05/12/06    NACL-多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
      *FILE-CONTROL.
      *
       DATA                        DIVISION.
      *FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-UKETUKE         PIC 9(01).
           03  FLG-OK              PIC 9(01).
      *
      *    添字領域
      *01  IDX-AREA.
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYSYMD.
               05  WRK-SYSYY         PIC 9(04).
               05  WRK-SYSMM         PIC 9(02).
               05  WRK-SYSDD         PIC 9(02).
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY          PIC 9(02).
               05  SYS-MM          PIC 9(02).
               05  SYS-DD          PIC 9(02).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    受付
       01  UKETUKE-REC.
           COPY    "CPUKETUKE.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    共通パラメタ
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
       01  LNK-KBN              PIC X(01).
       01  LNK-PTID             PIC 9(10).
       01  LNK-SRYKA            PIC X(02).
       01  LNK-TIME             PIC X(06).
       01  LNK-HOSPID           PIC X(24).
       01  LNK-IP-ADDRESS       PIC X(05).
       01  LNK-PORT             PIC X(05).
       01  LNK-DRCD             PIC X(05).
       01  LNK-HKNCOMBI         PIC X(04).
      *
      *
      ******************************************************************
      *
       PROCEDURE                       DIVISION
                                       USING   LNK-KBN
                                               LNK-PTID
                                               LNK-SRYKA
                                               LNK-TIME
                                               LNK-HOSPID
                                               LNK-IP-ADDRESS
                                               LNK-PORT
                                               LNK-DRCD
                                               LNK-HKNCOMBI.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
      *    システム日付セット
           ACCEPT  SYS-YMD         FROM    DATE
           COMPUTE WRK-SYSYY       =   SYS-YY      +   2000
           MOVE    SYS-MM              TO  WRK-SYSMM
           MOVE    SYS-DD              TO  WRK-SYSDD
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
      *    受付テーブル読み込み
           INITIALIZE                  UKETUKE-REC
           MOVE    LNK-HOSPID          TO  UKE-HOSPID
           MOVE    LNK-PTID            TO  UKE-PTID
           MOVE    WRK-SYSYMD          TO  UKE-UKEYMD
           MOVE    LNK-TIME            TO  UKE-UKETIME
           MOVE    UKETUKE-REC         TO  MCPDATA-REC
      *
           MOVE    "tbl_uketuke"       TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "key4"              TO  MCP-PATHNAME
               PERFORM 910-UKETUKE-READ-SEC
           ELSE
               INITIALIZE                  UKETUKE-REC
               MOVE    1               TO  FLG-UKETUKE
           END-IF
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM UNTIL     (FLG-UKETUKE      =  1  )  OR
                             (FLG-OK           =  1  )
      *
               IF     (UKE-UKEID           >   ZERO  )   AND
                      (UKE-KAIKEITIME      =   ZERO  )   AND
                      (UKE-SRYKA           =   LNK-SRYKA )
                   IF      (LNK-HKNCOMBI       =   SPACE )  OR
                          ((LNK-HKNCOMBI   NOT =   SPACE )  AND
                           (LNK-HKNCOMBI       =   UKE-HKNCOMBI))
      *                送信完了
                       MOVE    1                   TO  FLG-OK
                       MOVE    "00"                TO  UKE-SRFLG
                       MOVE    UKETUKE-REC         TO  MCPDATA-REC
      *
                       MOVE    "DBUPDATE"          TO  MCP-FUNC
                       MOVE    "tbl_uketuke"       TO  MCP-TABLE
                       MOVE    "key"               TO  MCP-PATHNAME
                       CALL    "MONFUNC"           USING
                                                   MCPAREA
                                                   MCPDATA-REC
                      IF      MCP-RC          NOT =   ZERO 
                           DISPLAY "ORCL0012 UKETUKE UPD ERR:"  MCP-RC
                                   ",KEY:" UKE-KEY
                       END-IF
                   END-IF
               END-IF
               MOVE    "key4"              TO  MCP-PATHNAME
               PERFORM 910-UKETUKE-READ-SEC
           END-PERFORM
      *
           MOVE    "tbl_uketuke"       TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    終了　処理
      *****************************************************************
       300-END-SEC                SECTION.
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    受付マスター読込
      *****************************************************************
       910-UKETUKE-READ-SEC         SECTION.
      *
           MOVE    "tbl_uketuke"       TO  MCP-TABLE
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-UKETUKE
               MOVE    MCPDATA-REC         TO  UKETUKE-REC
           ELSE
               MOVE    1                   TO  FLG-UKETUKE
           END-IF
      *
           .
       910-UKETUKE-READ-EXT.
           EXIT.
