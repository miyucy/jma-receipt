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
       PROGRAM-ID.             ORCSPTNUM.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : 患者番号入力処理
      *  返却エラーコード  : 00:正常　99:混在エラー
      *                      10:対象データなし
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02.06.04    多々納        新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者        日付      内容
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
           03  FLG-PTNUM           PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-OK              PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
      *
      *    ワーク領域
       01  WRK-AREA.
           03  WRK-PTNUM           PIC X(20).
           03  WRK-PTID            PIC 9(10).
      *
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *    患者番号変換マスタ
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
           COPY    "MCPAREA".
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPORCSPTNUM.INC".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
       PROCEDURE                    DIVISION    USING
           ORCSPTNUMAREA
           SPA-AREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                 SECTION.
      *
           MOVE    ZERO                TO  SPTNUM-RC
           MOVE    ZERO                TO  SPTNUM-SYUBETU
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    SPTNUM-PTNUM        TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF      KANACHK-RC      NOT =   ZERO
      *        混在エラー
               MOVE    99              TO  SPTNUM-RC
               GO      TO      000-PROC-EXT
           END-IF
      *
           EVALUATE    KANACHK-SYUBETU
               WHEN    1
      *            半角（患者番号）
                   PERFORM 100-PTID-SET-SEC
               WHEN    2
      *            全角（患者氏名）
                   MOVE    KANACHK-OUT-INPUT   TO  SPTNUM-PTNUM
                   PERFORM 200-NAME-SET-SEC
      *
               WHEN    OTHER
                   MOVE    99              TO  SPTNUM-RC
           END-EVALUATE
           .
      *
       000-PROC-EXT.
      *
           EXIT PROGRAM
           .
      *
      *****************************************************************
      *    患者ＩＤ検索処理
      *****************************************************************
       100-PTID-SET-SEC                SECTION.
      *
           MOVE    1                   TO  SPTNUM-SYUBETU
      *
      *
           INITIALIZE                      ORCSPTIDAREA
           MOVE    SPA-HOSPID          TO  SPTID-HOSPID
           MOVE    SPTNUM-PTNUM        TO  SPTID-PTNUM
           CALL    "ORCSPTID"          USING   ORCSPTIDAREA
                                               SPA-1009-TBL
           IF      SPTID-RC        NOT =   ZERO
               MOVE    10                  TO  SPTNUM-RC
           ELSE
               MOVE    SPTID-PTID          TO  SPTNUM-PTID
               MOVE    SPTID-PTNUM         TO  SPTNUM-PTNUM
           END-IF
      *
           .
       100-PTID-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者氏名検索処理
      *****************************************************************
       200-NAME-SET-SEC                SECTION.
      *
           MOVE    2                   TO  SPTNUM-SYUBETU
      *
      *    漢字検索
           INITIALIZE                  PTINF-REC
           MOVE    SPA-HOSPID          TO  PTINF-HOSPID
           MOVE    SPACE               TO  PTINF-NAME
           MOVE    SPTNUM-PTNUM(1:KANACHK-MAX)
                                       TO  PTINF-NAME
           MOVE    SPTNUM-PTNUM(1:KANACHK-MAX)
                                       TO  PTINF-KANANAME
      *
      *    患者マスターを漢字氏名で検索
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTINF-KEY5"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTINF-KEY5"        TO  ORC-DBPATH
               PERFORM 910-PTINF-READ-SEC
           ELSE
               INITIALIZE                  PTINF-REC
               MOVE    1                   TO  FLG-PTINF
           END-IF
      *
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  WRK-PTID
           PERFORM UNTIL      (IDX             >   1         ) OR
                              (FLG-PTINF       =   1         )
               ADD     1                   TO  IDX
               MOVE    PTINF-PTID          TO  WRK-PTID
      *
               MOVE    "PTINF-KEY5"        TO  ORC-DBPATH
               PERFORM 910-PTINF-READ-SEC
           END-PERFORM
      *
      *    患者決定
           IF      IDX                 =   1
               INITIALIZE                      ORCSPTIDAREA
               MOVE    SPA-HOSPID          TO  SPTID-HOSPID
               MOVE    WRK-PTID            TO  SPTID-PTID
               CALL    "ORCSPTID"          USING   ORCSPTIDAREA
                                                   SPA-1009-TBL
               IF      SPTID-RC        NOT =   ZERO
                   MOVE    10                  TO  SPTNUM-RC
               ELSE
                   MOVE    SPTID-PTID          TO  SPTNUM-PTID
                   MOVE    SPTID-PTNUM         TO  SPTNUM-PTNUM
               END-IF
           END-IF
      *    患者なし
           IF      IDX                 =   0
               MOVE    10                  TO  SPTNUM-RC
           END-IF
      *    患者複数
           IF      IDX                 >   1
               MOVE    20                  TO  SPTNUM-RC
           END-IF
      *
           .
       200-NAME-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込処理
      *****************************************************************
       910-PTINF-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-PTINF
               MOVE    MCPDATA-REC         TO  PTINF-REC
           ELSE
               MOVE    1                   TO  FLG-PTINF
           END-IF
      *
           .
       910-PTINF-READ-EXT.
           EXIT.
      *
