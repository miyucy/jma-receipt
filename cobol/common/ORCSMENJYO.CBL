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
       PROGRAM-ID.             ORCSMENJYO.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : 院外処方せん 免除判定サブプロ
      *  返却エラーコード  : 00:正常　10:パラメータ不正・対象データなし
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/04/19    MCC−多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
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
           03  FLG-TENSU           PIC 9(01).
           03  FLG-SANTEI          PIC 9(01).
           03  FLG-ARI             PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SRYCD               PIC X(09).
           03  WRK-MAE-SRYCD           PIC X(09).
           03  WRK-SRYYMD              PIC X(08).
      *
           03  WRK-DBPATH              PIC X(64). 
      *
      *    算定コードテーブル
       01  TBL-AREA.
      *    生活習慣病指導管理料
           03  FILLER              PIC X(09)   VALUE   "113003910".
           03  FILLER              PIC X(09)   VALUE   "113005810".
           03  FILLER              PIC X(09)   VALUE   "113005910".
           03  FILLER              PIC X(09)   VALUE   "113004010".
           03  FILLER              PIC X(09)   VALUE   "113006010".
           03  FILLER              PIC X(09)   VALUE   "113006110".
      *    寝たきり老人在宅総合診療料
           03  FILLER              PIC X(09)   VALUE   "114701210".
           03  FILLER              PIC X(09)   VALUE   "114701710".
      *    老人慢性疾患外来総合診療料
           03  FILLER              PIC X(09)   VALUE   "113701010".
           03  FILLER              PIC X(09)   VALUE   "113701110".
           03  FILLER              PIC X(09)   VALUE   "113701510".
      *    小児科外来診療料
           03  FILLER              PIC X(09)   VALUE   "113003510".
           03  FILLER              PIC X(09)   VALUE   "113003610".
           03  FILLER              PIC X(09)   VALUE   "113003710".
           03  FILLER              PIC X(09)   VALUE   "113003810".
       01  TBL-AREA-R              REDEFINES   TBL-AREA.
           03  TBL-OCC             OCCURS   15 INDEXED  TBL-IDX.
               05  TBL-SRYCD       PIC X(09).
      *
       01  TBL-MAX                 PIC 9(04)   VALUE   15.
      *
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    共通領域
           COPY    "MCPAREA".
      *
      *    点数マスタ−
           COPY    "CPTENSU.INC".
      *
      *    算定履歴
       01  SANTEI-REC.
           COPY    "CPSANTEI.INC".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPORCSMENJYO.INC".
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *
       PROCEDURE                    DIVISION    USING
           ORCSMENJYOAREA
           SPA-AREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                 SECTION.
      *
           INITIALIZE                  WRK-AREA
           INITIALIZE                  FLG-AREA
      *
      *    診療日付または、システム日付を日付とする
           IF      SPA-SRYYMD          =   SPACE
               MOVE    SPA-SYSYMD          TO  WRK-SRYYMD
           ELSE
               MOVE    SPA-SRYYMD          TO  WRK-SRYYMD
           END-IF
      *
           MOVE    ZERO                TO  MENJYO-FLG
      *    判定処理
           PERFORM 200-SYORI-SEC
      *
           .
      *
           EXIT PROGRAM
           .
      *
      *****************************************************************
      *    初回算定日決定処理
      *****************************************************************
       200-SYORI-SEC                SECTION.
      *
           MOVE    ZERO                TO  FLG-ARI
           PERFORM VARYING       IDX   FROM    1   BY  1
                   UNTIL        (IDX       >   TBL-MAX  )  OR
                                (FLG-ARI   =   1        )
      *
               MOVE    TBL-SRYCD (IDX)     TO  WRK-SRYCD
      *        算定履歴検索
               PERFORM 1001-SANTEI-KEN-SEC
               IF      FLG-SANTEI          =   ZERO
                   IF      SANTEI-MSANTEICNT   >   ZERO
                       MOVE    1               TO  FLG-ARI
                   END-IF
               END-IF
           END-PERFORM
      *
           IF     FLG-ARI              =   1
               MOVE    1               TO  MENJYO-FLG
           END-IF
      *
           .
       200-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    算定履歴チェック処理
      *****************************************************************
       1001-SANTEI-KEN-SEC                SECTION.
      *
      *
           MOVE    WRK-SRYCD           TO  TNS-SRYCD
           PERFORM 910-TENSU-READ-SEC
      *
      *    算定履歴検索
           INITIALIZE                  SANTEI-REC
           MOVE    SPA-HOSPID          TO  SANTEI-HOSPID
           MOVE    SPA-PTID            TO  SANTEI-PTID
           MOVE    WRK-SRYCD           TO  SANTEI-SRYCD
           MOVE    WRK-SRYYMD(1:6)     TO  SANTEI-SRYYM
           EVALUATE    TNS-SANTEIRRKKBN
               WHEN    1
                   MOVE    ZERO                TO  SANTEI-NYUGAIKBN
                   MOVE    ZERO                TO  SANTEI-SRYKA
               WHEN    2
                   MOVE    SPA-NYUGAIKBN       TO  SANTEI-NYUGAIKBN
                   MOVE    ZERO                TO  SANTEI-SRYKA
               WHEN    3
                   MOVE    ZERO                TO  SANTEI-NYUGAIKBN
                   MOVE    SPA-SRYKA           TO  SANTEI-SRYKA
               WHEN    4
                   MOVE    SPA-NYUGAIKBN       TO  SANTEI-NYUGAIKBN
                   MOVE    SPA-SRYKA           TO  SANTEI-SRYKA
           END-EVALUATE
      *
           MOVE    SANTEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
               PERFORM 920-SANTEI-READ-SEC
           ELSE
               INITIALIZE                  SANTEI-REC
               MOVE    1                   TO  FLG-SANTEI
           END-IF
           .
      *
       1001-SANTEI-KEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスター読込
      *****************************************************************
       910-TENSU-READ-SEC         SECTION.
      *
           MOVE    ZERO                TO  TNS-YUKOSTYMD
           MOVE    ALL "9"             TO  TNS-YUKOEDYMD
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           MOVE    WRK-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "TENSU-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
                   MOVE    ZERO                TO  FLG-TENSU
               ELSE
                   INITIALIZE                  TNS-TENSU-REC
                   MOVE    1                   TO  FLG-TENSU
               END-IF
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       910-TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    算定歴マスタ読み込み
      *****************************************************************
       920-SANTEI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SANTEI-REC
               MOVE    ZERO                TO  FLG-SANTEI
           ELSE
               INITIALIZE                      SANTEI-REC
               MOVE    1                   TO  FLG-SANTEI
           END-IF
      *
           .
       920-SANTEI-READ-EXT.
           EXIT.
      *
