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
       PROGRAM-ID.                 ORCSDRSET.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 共通
      *  コンポーネント名  : ドクター編集・チェック処理
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/02/24    NACL−多々納  新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
      *
       ENVIRONMENT                 DIVISION.
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
           03  FLG-SYSKANRI        PIC 9(01).
      *
           03  FLG-CHK             PIC 9(01).
           03  FLG-OK              PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX2                PIC 9(04).
      *
      *    一時領域
      *01  WRK-AREA.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    ドクター
           COPY    "CPSK1010.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *    ドクターセット領域
           COPY    "CPORCSDRSET.INC".
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           ORCSDRSETAREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
      *****INITIALIZE                  WRK-AREA
           INITIALIZE                  ORCSDR-ERRCD
      *
           EVALUATE    ORCSDR-KBN
      *        ドクターテーブル編集
               WHEN    "1"
                   PERFORM 100-DR-HENSYU-SEC
      *        ドクターチェック
               WHEN    "2"
                   PERFORM 200-DR-CHECK-SEC
           END-EVALUATE
      *
           .
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    ドクターテーブル編集処理
      *****************************************************************
       100-DR-HENSYU-SEC            SECTION.
      *
           INITIALIZE                  ORCSDR-OUT-AREA
      *
      *    職員情報（ドクター）
           MOVE    SPACE               TO  SYS-1010-REC
           INITIALIZE                  SYS-1010-REC
           MOVE    "1010"              TO  SYS-1010-KANRICD
      *
      *    システム管理検索
           MOVE    SYS-1010-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           MOVE    ORCSDR-SYSYMD       TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               INITIALIZE                  SYS-1010-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    ZERO                TO  IDX
           PERFORM
                   UNTIL       (IDX            >=   20  )  OR
                               (FLG-SYSKANRI   =   1    )
               MOVE    MCPDATA-REC             TO  SYS-1010-REC
               IF      SYS-1010-KBNCD(1:1)     =   "1"
                   MOVE    ZERO                TO  FLG-CHK
      *            科別の時（病院の）
                   IF     (ORCSDR-SRYKA    NOT =   SPACE )  AND
                          (SPA-HOSPSBT         =   1     )
                       PERFORM 1001-SEMONKACD-CHK-SEC
                   ELSE
                       MOVE    1               TO  FLG-CHK
                   END-IF
                   IF      FLG-CHK             =   1
                       ADD     1                   TO  IDX
                       MOVE    SYS-1010-KBNCD(2:4)
                                               TO  ORCSDR-DRCD   (IDX)
                       MOVE    SYS-1010-NAME   TO  ORCSDR-DRCDMEI(IDX)
                   END-IF
               END-IF
      *
               MOVE    "SYSKANRI-KEY2"    TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *
           MOVE    IDX                 TO  ORCSDR-DRCD-MAX
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
      *    CALL    "ORCMCPSUB"         USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
      *    ドクターコードがある時、ドクター編集
           IF      ORCSDR-IN-DRCD  NOT =   SPACE
      *        ドクターチェック
               PERFORM 200-DR-CHECK-SEC
           END-IF
      *
           .
       100-HENSYU-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    科別の専門家チェック処理
      *****************************************************************
       1001-SEMONKACD-CHK-SEC            SECTION.
      *
      *    専門科コード
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL      (IDX2            >   5   )   OR
                              (FLG-CHK     NOT =   ZERO )
               IF      SYS-1010-SEMONKACD (IDX2)   NOT =   SPACE
                   MOVE    1               TO  FLG-OK
                   IF      SYS-1010-SEMONKACD (IDX2)
                                           =   ORCSDR-SRYKA
                       MOVE    1               TO  FLG-CHK
                   END-IF
               END-IF
           END-PERFORM
      *
      *    専門科がない時、全科対象とする
           IF      FLG-OK              =   ZERO
               MOVE    1               TO  FLG-CHK
           END-IF
           .
       1001-SEMONKACD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ドクターチェック処理
      *****************************************************************
       200-DR-CHECK-SEC            SECTION.
      *
           IF      ORCSDR-IN-DRCD      =   SPACE
               MOVE    SPACE           TO  ORCSDR-IN-DRCD-G
               GO      TO      200-DR-CHECK-EXT
           END-IF
      *
      *    コード変換
           INITIALIZE                      ORCSNUMAREA
           MOVE    ORCSDR-IN-DRCD      TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-SEISUU         >   4     )   OR
                  (SNUM-SYOKBN         =   "1"   )   OR
                  (SNUM-MINKBN         =   "1"   )
               MOVE    2                   TO  ORCSDR-ERRCD
               GO      TO      200-DR-CHECK-EXT
           ELSE
               MOVE    SNUM-OUTEDT(12:4)   TO  ORCSDR-IN-DRCD
           END-IF
           MOVE    SPACE               TO  ORCSDR-IN-DRCD-H
           MOVE    SPACE               TO  ORCSDR-OUT-DRCDMEI
      *
      *    コードチェック
           MOVE    ZERO                TO  ORCSDR-DRCD-IDX
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING IDX         FROM    1   BY  1
                   UNTIL   IDX         >   ORCSDR-DRCD-MAX
               IF      ORCSDR-DRCD (IDX)   =   ORCSDR-IN-DRCD
                   MOVE    ORCSDR-DRCD-TBL (IDX)
                                           TO  ORCSDR-IN-DRCD-G
                   MOVE    IDX             TO  ORCSDR-DRCD-IDX
                   MOVE    ORCSDR-DRCD-MAX TO  IDX
                   MOVE    1               TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   1
               GO      TO      200-DR-CHECK-EXT
           END-IF
      *
      *    リストにない時
      *    職員情報（ドクター）
           MOVE    SPACE               TO  SYS-1010-REC
           INITIALIZE                  SYS-1010-REC
           MOVE    "1010"              TO  SYS-1010-KANRICD
           MOVE    "1"                 TO  SYS-1010-KBNCD(1:1)
           MOVE    ORCSDR-IN-DRCD      TO  SYS-1010-KBNCD(2:4)
      *
      *    システム管理検索
           MOVE    SYS-1010-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    ORCSDR-SYSYMD       TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               INITIALIZE                  SYS-1010-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *TEST
           DISPLAY "DRSET FLG-SYSKANRI:" FLG-SYSKANRI
                   ",MCP-RC:" MCP-RC
                   ",ORCSDR-SYSYMD:" ORCSDR-SYSYMD
                   ",SYS-1010-KANRICD:" SYS-1010-KANRICD
                    ".SYS-1010-KBNCD:" SYS-1010-KBNCD
      *TEST
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1010-REC
               MOVE    SPACE               TO  ORCSDR-IN-DRCD-H
               MOVE    SYS-1010-NAME       TO  ORCSDR-OUT-DRCDMEI
      *        最後の行へ編集する
               IF      ORCSDR-DRCD-MAX     =   20
                   MOVE    20              TO  ORCSDR-DRCD-MAX
               ELSE
                   ADD     1               TO  ORCSDR-DRCD-MAX
               END-IF
               MOVE    ORCSDR-IN-DRCD-G    TO  ORCSDR-DRCD-TBL
                                                      (ORCSDR-DRCD-MAX)
           ELSE
               MOVE    1                   TO  ORCSDR-ERRCD
           END-IF
      *
           .
       200-DR-CHECK-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-SYSKANRI
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
      *
