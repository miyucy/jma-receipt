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
       PROGRAM-ID.             ORCHC03SUB.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 診療行為
      *  コンポーネント名  : 請求書兼領収書収納編集
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/07/16    NACL−多々納   新規作成
      *  05/07/14    NACL−小豆沢   自費１０項目対応
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  03.05.00    NACL-多々納  07/04/XX  グループ診療対応
      *  03.05.01    NACL-多々納  07/08/XX  訂正時の合計金額対応
      *  04.05.00    NACL-多々納  10/05/XX  請求書兼明細書対応
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
      *FILE-CONTROL.
      *
      *
       DATA                    DIVISION.
      *FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYUNOU          PIC 9(01).
           03  FLG-SYUTTL          PIC 9(01).
      *
           03  FLG-OK              PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDS1                PIC 9(04).
           03  IDH                 PIC 9(04).
           03  IDH1                PIC 9(04).
           03  IDH2                PIC 9(04).
           03  IDH3                PIC 9(04).
           03  IDX-SYU             PIC 9(04).
           03  IDX-TBL             PIC 9(04).
           03  IDX-DN              PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-HKNCOMBI        PIC X(04).
           03  WRK-SRYKA           PIC X(02).
           03  WRK-GRP-DENPNUM     PIC 9(07).
      *    請求額等
           03  WRK-SKYMONE-AREA.
               05  WRK-SKYMONEY           PIC S9(07).
               05  WRK-SKYMONEY-TAX       PIC S9(07).
               05  WRK-NYUKIN-TOTAL       PIC S9(07).
               05  WRK-HENKIN             PIC S9(07).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    収納
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    収納合計マスタ−
       01  SYUTTL-REC.
           COPY    "CPSYUTOTAL.INC".
      *
      *    保存用収納ワーク
       01  WRK-SYUNOU-REC.
           COPY    "CPSYUNOU.INC"  REPLACING
                                     //SYU-// BY //WRK-SYU-//.
      *    保存用収納ワーク
       01  TBL-SYUNOU-AREA.
         02  TBL-SYUNOU-REC        OCCURS   15.
           COPY    "CPSYUNOU.INC"  REPLACING
                                     //SYU-// BY //TBL-SYU-//.
      *    請求額等
       01  TBL-SEIKYU-AREA.
           03  TBL-SEIKYU-TBL       OCCURS   15.
               05  TBL-SKYMONEY           PIC S9(07).
               05  TBL-SKYMONEY-TAX       PIC S9(07).
               05  TBL-NYUKIN-TOTAL       PIC S9(07).
               05  TBL-HENKIN             PIC S9(07).
      *
      *    保存用収納ワーク２
       01  LNK-SYUNOU-AREA.
         02  LNK-SYUNOU-REC        OCCURS   15.
           COPY    "CPSYUNOU.INC"  REPLACING
                                     //SYU-// BY //LNK-SYU-//.
       01  LNK-DOUJI-AREA.
      *    同時入力診療科
           03  LNK-DOUJI-TBL       OCCURS   15.
               05  LNK-DOUJI-SRYKA-G.
                   07  LNK-DOUJI-SRYKA    PIC  X(02)
                                          OCCURS  10.
               05  LNK-DOUJI-HKNCOMBI-G.
                   07  LNK-DOUJI-HKNCOMBI     PIC  X(04)
                                          OCCURS  10.
       01  LNK-DOUJI-AREA2.
           03  LNK-DOUJI-TBL2       OCCURS   15.
               05  LNK-DOUJI-DENPNUM-G.
                   07  LNK-DOUJI-DENPNUM      PIC  9(07)
                                              OCCURS  15.
      *H27.8
      *まとめ用複数科保存
       01  WRK-DOUJI-SRYKA-G.
           05  WRK-DOUJI-SRYKA    PIC  X(02)
                                          OCCURS  10.
      *
      *    請求額等
       01  LNK-SEIKYU-AREA.
           03  LNK-SEIKYU-TBL       OCCURS   15.
               05  LNK-SKYMONEY           PIC S9(07).
               05  LNK-SKYMONEY-TAX       PIC S9(07).
               05  LNK-NYUKIN-TOTAL       PIC S9(07).
               05  LNK-HENKIN             PIC S9(07).
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
           COPY    "MCPDATA.INC".
      **** COPY    "CPORCMCP.INC".
      *
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    処方箋共通パラメタ
           COPY    "CPORCHC03.INC".
      *    処方箋共通パラメタ
           COPY    "CPORCHC03SUB.INC".
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           ORCHC03AREA
           ORCHC03SUBAREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  LNK-SYUNOU-AREA
           INITIALIZE                  LNK-DOUJI-AREA
           INITIALIZE                  LNK-SEIKYU-AREA
           INITIALIZE                  ORCHC03SUBAREA
      *
           PERFORM 100-SYUNOU-KEN-SEC
           IF      SYU-GRP-DENPNUM     =   ZERO
      *        単独入力
               PERFORM 200-ONLY-SYUNOU-HEN-SEC
           ELSE
      *        複数入力
               PERFORM 300-GRP-SYUNOU-HEN-SEC
           END-IF
      *
           .
       000-PROC-EXT.
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    主収納マスタ検索処理
      *****************************************************************
       100-SYUNOU-KEN-SEC             SECTION.
      *
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPNUM         TO  SYU-HOSPNUM
           MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-PTID            TO  SYU-PTID
           MOVE    ORCHC03-DENPNUM     TO  SYU-DENPNUM
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "tbl_syunou"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syunou"        TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 980-SYUNOU-READ-SEC
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
           MOVE    "tbl_syunou"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       100-SYUNOU-KEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納編集処理
      *****************************************************************
       200-ONLY-SYUNOU-HEN-SEC             SECTION.
      *
      *    訂正時の請求差額
           PERFORM 2001-TEISEI-SYORI-SEC
      *
           ADD     1               TO  IDX-SYU
           MOVE    SYUNOU-REC      TO  ORCHC03SUB-SYUNOU-REC(IDX-SYU)
           MOVE    WRK-SKYMONEY    TO  ORCHC03SUB-SKYMONEY  (IDX-SYU)
           MOVE    WRK-SKYMONEY-TAX
                                   TO  ORCHC03SUB-SKYMONEY-TAX-SAI
                                                            (IDX-SYU)
           MOVE    WRK-NYUKIN-TOTAL
                                   TO  ORCHC03SUB-NYUKIN-TOTAL(IDX-SYU)
           MOVE    WRK-HENKIN      TO  ORCHC03SUB-HENKIN(IDX-SYU)
           MOVE    SYU-DENPNUM     TO  ORCHC03SUB-DOUJI-DENPNUM
                                                        (IDX-SYU 1)
           MOVE    IDX-SYU         TO  ORCHC03SUB-MAX
           .
       200-ONLY-SYUNOU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    複数診療科・保険組合せ別編集処理
      *****************************************************************
       2001-TEISEI-SYORI-SEC             SECTION.
      *
           MOVE    SYU-SKYMONEY            TO  WRK-SKYMONEY
           MOVE    SYU-SKYMONEY-TAX-SAI    TO  WRK-SKYMONEY-TAX
           MOVE    SYU-NYUKIN-TOTAL        TO  WRK-NYUKIN-TOTAL
           MOVE    ZERO                    TO  WRK-HENKIN
      *    訂正時に合計金額表示の時、差額計算なし
           IF     (ORCHC03-TEIKIN-KBN  =   1   )  AND
                  (ORCHC03-HAKKOFLG    =   2   )
               CONTINUE
           ELSE
      *
           PERFORM VARYING     IDY     FROM    1   BY  1
                   UNTIL      (IDY     >   15  )
      *DDD              OR    (ORCHC03-OLD-DENPNUM(IDY)    =   ZERO)
               IF     (ORCHC03-OLD-DENPNUM(IDY)    =   SYU-DENPNUM)
                  AND (SYU-SRYKA               NOT =   ZERO  )
      *            訂正時の請求額差額
                   COMPUTE WRK-SKYMONEY    =   WRK-SKYMONEY
                                           -   ORCHC03-OLD-SKYMONEY
                                                             (IDY)
                   COMPUTE WRK-SKYMONEY-TAX
                                           =   WRK-SKYMONEY-TAX
                                           -   ORCHC03-OLD-SKYMONEY-SAI
                                                             (IDY)
      *            今回入金額
                   MOVE    ORCHC03-OLD-NYUKIN-TOTAL (IDY)
                                           TO  WRK-NYUKIN-TOTAL
      *            今回返金
                   MOVE    ORCHC03-KON-HENKIN (IDY)
                                           TO  WRK-HENKIN
                   MOVE    15              TO  IDY
               END-IF
           END-PERFORM
      *
           END-IF
           .
       2001-TEISEI-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    複数診療科・保険組合せ別編集処理
      *****************************************************************
       300-GRP-SYUNOU-HEN-SEC             SECTION.
      *
           INITIALIZE                  TBL-SYUNOU-AREA
           MOVE    ZERO                TO  IDX-TBL
           MOVE    SYU-GRP-DENPNUM     TO  WRK-GRP-DENPNUM
      *
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPNUM         TO  SYU-HOSPNUM
           MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-PTID            TO  SYU-PTID
           MOVE    WRK-GRP-DENPNUM     TO  SYU-GRP-DENPNUM
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "tbl_syunou"        TO  MCP-TABLE
           MOVE    "key27"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syunou"        TO  MCP-TABLE
               MOVE    "key27"             TO  MCP-PATHNAME
               PERFORM 980-SYUNOU-READ-SEC
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
           PERFORM
               UNTIL       FLG-SYUNOU      =   1
      *        訂正時の請求差額
               PERFORM 2001-TEISEI-SYORI-SEC
      *        収納編集
               ADD     1                   TO  IDX-TBL
      *!!!
      *        マル長の公費負担を保険適用金額へ
               IF      SYU-HKNTEKKBN   =   "1"
                   MOVE    SYU-KOH-FTN         TO  SYU-HKNTEKMONEY
                   MOVE    ZERO                TO  SYU-KOH-FTN
               END-IF
      *!!!
               MOVE    SYUNOU-REC          TO  TBL-SYUNOU-REC(IDX-TBL)
               MOVE    WRK-SKYMONEY        TO  TBL-SKYMONEY  (IDX-TBL)
               MOVE    WRK-SKYMONEY-TAX
                                           TO  TBL-SKYMONEY-TAX
                                                            (IDX-TBL)
               MOVE    WRK-NYUKIN-TOTAL    TO  TBL-NYUKIN-TOTAL(IDX-TBL)
               MOVE    WRK-HENKIN          TO  TBL-HENKIN   (IDX-TBL)
      *
               MOVE    "tbl_syunou"        TO  MCP-TABLE
               MOVE    "key27"             TO  MCP-PATHNAME
               PERFORM 980-SYUNOU-READ-SEC
           END-PERFORM
      *
           MOVE    "tbl_syunou"        TO  MCP-TABLE
           MOVE    "key27"             TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           INITIALIZE                  LNK-DOUJI-AREA2
           MOVE    ZERO                TO  IDX-DN
           EVALUATE    ORCHC03-HAKHOUFLG
      *        科・保険別
               WHEN    1
                   PERFORM 3001-SYORI-01-SEC
      *        保険別
               WHEN    2
                   PERFORM 3002-SYORI-02-SEC
      *        科別
               WHEN    3
                   PERFORM 3003-SYORI-03-SEC
      *        合計
               WHEN    4
                   PERFORM 3004-SYORI-04-SEC
           END-EVALUATE
           .
       300-GRP-SYUNOU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科・保険組合せ別編集処理
      *****************************************************************
       3001-SYORI-01-SEC             SECTION.
      *
           MOVE    ZERO                TO  IDX-SYU
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   IDX-TBL
               ADD     1                   TO  IDX-SYU
               MOVE    TBL-SYUNOU-REC(IDX) TO  ORCHC03SUB-SYUNOU-REC
                                                           (IDX-SYU)
               MOVE    TBL-SKYMONEY (IDX)  TO  ORCHC03SUB-SKYMONEY
                                                           (IDX-SYU)
               MOVE    TBL-SKYMONEY-TAX (IDX)
                                       TO  ORCHC03SUB-SKYMONEY-TAX-SAI
                                                           (IDX-SYU)
               MOVE    TBL-NYUKIN-TOTAL (IDX)
                                           TO  ORCHC03SUB-NYUKIN-TOTAL
                                                           (IDX-SYU)
               MOVE    TBL-HENKIN       (IDX)
                                           TO  ORCHC03SUB-HENKIN
                                                           (IDX-SYU)
               MOVE    IDX-SYU             TO  ORCHC03SUB-MAX
           END-PERFORM
           .
       3001-SYORI-01-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せ別編集処理
      *****************************************************************
       3002-SYORI-02-SEC               SECTION.
      *
           MOVE    ZERO                TO  IDX-SYU
           INITIALIZE                  LNK-SYUNOU-AREA
           INITIALIZE                  LNK-DOUJI-AREA
           INITIALIZE                  LNK-SEIKYU-AREA
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   IDX-TBL
               MOVE    TBL-SYUNOU-REC (IDX)    TO  WRK-SYUNOU-REC
               MOVE    TBL-SKYMONEY   (IDX)    TO  WRK-SKYMONEY
               MOVE    TBL-SKYMONEY-TAX (IDX)  TO  WRK-SKYMONEY-TAX
               MOVE    TBL-NYUKIN-TOTAL (IDX)  TO  WRK-NYUKIN-TOTAL
               MOVE    TBL-HENKIN       (IDX)  TO  WRK-HENKIN
               MOVE    ZERO                TO  FLG-OK
               PERFORM VARYING  IDX-SYU    FROM    1   BY  1
                       UNTIL   (IDX-SYU    >   15  )  OR
                               (FLG-OK     =   1   )
                   IF      LNK-SYU-HKNCOMBINUM(IDX-SYU)    =   SPACE
                       IF      WRK-SYU-FUKU-DENPNUM    =   ZERO
                           MOVE    TBL-SYUNOU-REC(IDX)
                                                   TO  LNK-SYUNOU-REC
                                                       (IDX-SYU)
                           MOVE    TBL-SKYMONEY   (IDX)
                                                   TO  LNK-SKYMONEY
                                                       (IDX-SYU)
                           MOVE    TBL-SKYMONEY-TAX(IDX)
                                                   TO  LNK-SKYMONEY-TAX
                                                       (IDX-SYU)
                           MOVE    TBL-NYUKIN-TOTAL   (IDX)
                                                   TO  LNK-NYUKIN-TOTAL
                                                       (IDX-SYU)
                           MOVE    TBL-HENKIN    (IDX)
                                                   TO  LNK-HENKIN
                                                       (IDX-SYU)
                       ELSE
                           PERFORM 30022-SYUTOTAL-CHK-SEC
                       END-IF
                       MOVE    1                   TO  FLG-OK
                       MOVE    ZERO                TO  IDX-DN
                   ELSE
                       IF      LNK-SYU-HKNCOMBINUM(IDX-SYU)
                                           =   WRK-SYU-HKNCOMBINUM
      *                    伝票番号
                           ADD     1               TO  IDX-DN
                           MOVE    WRK-SYU-DENPNUM
                                                   TO  LNK-DOUJI-DENPNUM
                                                       (IDX-SYU IDX-DN)
      *
                           IF      LNK-SYU-SRYKA (IDX-SYU)
                                               NOT =   ZERO
                               PERFORM 30021-SYUNOU-ADD-SEC
                               MOVE    WRK-SYU-SRYKA   TO  WRK-SRYKA
                               PERFORM 30041-DOUJI-SRYKA-SEC
                           END-IF
                           MOVE    1           TO  FLG-OK
                       END-IF
                   END-IF
               END-PERFORM
           END-PERFORM
      *    パラメタへ編集
           PERFORM 30023-LNK-TBL-HENSYU-SEC
      *
           .
       3002-SYORI-02-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納合計レコード編集処理
      *****************************************************************
       30023-LNK-TBL-HENSYU-SEC             SECTION.
      *
           INITIALIZE                  ORCHC03SUBAREA
           MOVE    ZERO                TO  IDX-SYU
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   15
               IF       LNK-SYU-PTID (IDX)  =   ZERO
                   CONTINUE
               ELSE
                   ADD     1                   TO  IDX-SYU
                   MOVE    LNK-SYUNOU-REC(IDX) TO  ORCHC03SUB-SYUNOU-REC
                                                           (IDX-SYU)
                   MOVE    LNK-SKYMONEY  (IDX) TO  ORCHC03SUB-SKYMONEY
                                                           (IDX-SYU)
                   MOVE    LNK-SKYMONEY-TAX  (IDX)
                                       TO  ORCHC03SUB-SKYMONEY-TAX-SAI
                                                           (IDX-SYU)
                   MOVE    LNK-NYUKIN-TOTAL  (IDX)
                                       TO  ORCHC03SUB-NYUKIN-TOTAL
                                                           (IDX-SYU)
                   MOVE    LNK-HENKIN        (IDX)
                                       TO  ORCHC03SUB-HENKIN
                                                           (IDX-SYU)
                   MOVE    LNK-DOUJI-SRYKA-G(IDX)
                                       TO  ORCHC03SUB-DOUJI-SRYKA-G
                                                           (IDX-SYU)
                   MOVE    LNK-DOUJI-HKNCOMBI-G(IDX)
                                       TO  ORCHC03SUB-DOUJI-HKNCOMBI-G
                                                           (IDX-SYU)
                   MOVE    LNK-DOUJI-DENPNUM-G(IDX)
                                       TO  ORCHC03SUB-DOUJI-DENPNUM-G
                                                           (IDX-SYU)
                   MOVE    IDX-SYU             TO  ORCHC03SUB-MAX
               END-IF
           END-PERFORM
      *
           .
       30023-LNK-TBL-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納合計レコード編集処理
      *****************************************************************
       30022-SYUTOTAL-CHK-SEC             SECTION.
      *
           INITIALIZE                  SYUTTL-REC
           MOVE    WRK-SYU-HOSPNUM     TO  SYUTTL-HOSPNUM 
           MOVE    WRK-SYU-NYUGAIKBN   TO  SYUTTL-NYUGAIKBN 
           MOVE    WRK-SYU-PTID        TO  SYUTTL-PTID 
           MOVE    WRK-SYU-FUKU-DENPNUM
                                       TO  SYUTTL-DENPNUM 
      *
           MOVE    SYUTTL-REC          TO  MCPDATA-REC
           MOVE    "tbl_syutotal"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syutotal"      TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 981-SYUTTL-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SYUTTL
               INITIALIZE              SYUTTL-REC
           END-IF
           MOVE    "tbl_syutotal"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *!!!
      *    マル長の公費負担を保険適用金額へ
           IF      SYUTTL-HKNTEKKBN    =   "1"
               MOVE    SYUTTL-KOH-FTN      TO  SYUTTL-HKNTEKMONEY
               MOVE    ZERO                TO  SYUTTL-KOH-FTN
           END-IF
      *!!!
      *
           MOVE    SPACE               TO  SYUNOU-REC
           INITIALIZE                  SYUNOU-REC
           MOVE    TBL-SYUNOU-REC(IDX) TO  SYUNOU-REC
      *診療科
           MOVE    SYUTTL-SRYKA        TO  SYU-SRYKA
      *伝票番号
           MOVE    SYUTTL-DENPNUM      TO  SYU-DENPNUM
      *請求内容
           MOVE    SYUTTL-SKY-NAIYOU   TO  SYU-SKY-NAIYOU
      *処方せん料再掲
           MOVE    SYUTTL-SHOHOU-SAI   TO  SYU-SHOHOU-SAI
      *保険適用外金額−消費税（再掲）
           MOVE    SYUTTL-TGMONEY-TAX-SAI TO  SYU-TGMONEY-TAX-SAI
      *自費１から５
           MOVE    SYUTTL-JIHI-NAIYOU     TO  SYU-JIHI-NAIYOU
      *自費小計（消費税なし）
           MOVE    SYUTTL-JIHI-TOTAL      TO  SYU-JIHI-TOTAL
           MOVE    SYUTTL-JIHI-TOTAL-TAX  TO  SYU-JIHI-TOTAL-TAX
           MOVE    SYUTTL-JIHI-TAX        TO  SYU-JIHI-TAX
      *老人一部負担金
           MOVE    SYUTTL-RJN-FTN         TO  SYU-RJN-FTN
           MOVE    SYUTTL-KOH-FTN         TO  SYU-KOH-FTN
           MOVE    SYUTTL-KOH-FTN-ENTANI  TO  SYU-KOH-FTN-ENTANI
      *調整金
           MOVE    SYUTTL-CHOSEI          TO  SYU-CHOSEI
           MOVE    SYUTTL-CHOSEI1         TO  SYU-CHOSEI1
           MOVE    SYUTTL-CHOSEI2         TO  SYU-CHOSEI2
      *まとめ入力差額
           MOVE    SYUTTL-GRP-SGKMONEY    TO  SYU-GRP-SGKMONEY
      *保険適用金額
           MOVE    SYUTTL-HKNTEKMONEY     TO  SYU-HKNTEKMONEY
      *病院減免事由区分
           MOVE    SYUTTL-DISCOUNT-KBN    TO  SYU-DISCOUNT-KBN
           MOVE    SYUTTL-DISCOUNT-BODY   TO  SYU-DISCOUNT-BODY
           MOVE    SYUTTL-DISCOUNT-RATEKBN
                                       TO  SYU-DISCOUNT-RATEKBN
           MOVE    SYUTTL-DISCOUNT-TEIRITU
                                       TO  SYU-DISCOUNT-TEIRITU
           MOVE    SYUTTL-DISCOUNT-RATE   TO  SYU-DISCOUNT-RATE
      *減免金額
           MOVE    SYU-DISCOUNT-MONEY  TO  SYUTTL-DISCOUNT-MONEY
      *労災保険
           MOVE    SYUTTL-RSISHOSHIN-MONEY
                                       TO  SYU-RSISHOSHIN-MONEY
           MOVE    SYUTTL-RSISAISHIN-MONEY
                                       TO  SYU-RSISAISHIN-MONEY
           MOVE    SYUTTL-RSISDO-MONEY    TO  SYU-RSISDO-MONEY
           MOVE    SYUTTL-RSIETC-MONEY    TO  SYU-RSIETC-MONEY
           MOVE    SYUTTL-RSI-TAX-SAI     TO  SYU-RSI-TAX-SAI
           MOVE    SYUTTL-RSI-TOTAL       TO  SYU-RSI-TOTAL
           MOVE    SYUTTL-RSIJIBAI-SKYMONEY
                                       TO  SYU-RSIJIBAI-SKYMONEY
      *請求金額−消費税（再掲）
           MOVE    SYUTTL-SKYMONEY-TAX-SAI
                                       TO  SYU-SKYMONEY-TAX-SAI
      *請求金額
           MOVE    SYUTTL-SKYMONEY        TO  SYU-SKYMONEY
           MOVE    SYUTTL-NYUKIN-TOTAL    TO  SYU-NYUKIN-TOTAL
           MOVE    SYUTTL-NYUKIN-KAISU    TO  SYU-NYUKIN-KAISU
      *未収理由
           MOVE    SYUTTL-MISYURIYU    TO  SYU-MISYURIYU
      *在総診区分
           MOVE    SYUTTL-ZAITAKU      TO  SYU-ZAITAKU
      *診療区分別給付外点数
           MOVE    SYUTTL-KYUFUGAI     TO  SYU-KYUFUGAI
      *保険適用区分
           MOVE    SYUTTL-HKNTEKKBN    TO  SYU-HKNTEKKBN
      *
      *    同時入力診療科
           PERFORM VARYING     IDH2    FROM    1   BY  1
                   UNTIL      (IDH2    >   10  )  OR
                              (SYUTTL-DOUJI-SRYKA(IDH2) =   SPACE)
               MOVE    SYUTTL-DOUJI-SRYKA (IDH2)
                                       TO  LNK-DOUJI-SRYKA
                                                       (IDX-SYU IDH2)
           END-PERFORM
      *    訂正時の請求額差額
           MOVE    SYUTTL-SKYMONEY         TO  WRK-SKYMONEY
           MOVE    SYUTTL-SKYMONEY-TAX-SAI TO  WRK-SKYMONEY-TAX
           MOVE    SYUTTL-NYUKIN-TOTAL     TO  WRK-NYUKIN-TOTAL
           MOVE    ZERO                    TO  WRK-HENKIN
      *    訂正時に合計金額表示の時、差額計算なし
           IF     (ORCHC03-TEIKIN-KBN  =   1   )  AND
                  (ORCHC03-HAKKOFLG    =   2   )
               CONTINUE
           ELSE
      *
           PERFORM VARYING     IDY     FROM    1   BY  1
                   UNTIL      (IDY     >   15  )
      *D                 OR   (ORCHC03-OLD-DENPNUM(IDY)    =   ZERO)
               IF     (ORCHC03-OLD-SRYKA (IDY)     =   SYU-SRYKA  )
                 AND  (ORCHC03-OLD-HKNCOMBI(IDY)   =   SYU-HKNCOMBINUM)
      *            訂正時の請求額差額
                   COMPUTE WRK-SKYMONEY    =   WRK-SKYMONEY
                                           -   ORCHC03-OLD-SKYMONEY
                                                             (IDY)
                   COMPUTE WRK-SKYMONEY-TAX
                                           =   WRK-SKYMONEY-TAX
                                           -   ORCHC03-OLD-SKYMONEY-SAI
                                                             (IDY)
                   MOVE    ORCHC03-OLD-NYUKIN-TOTAL (IDY)
                                           TO  WRK-NYUKIN-TOTAL
                   MOVE    ORCHC03-KON-HENKIN (IDY)
                                           TO  WRK-HENKIN
                   MOVE    15              TO  IDY
               END-IF
           END-PERFORM
      *
           END-IF
      *
           MOVE    SYUNOU-REC          TO  LNK-SYUNOU-REC
                                                       (IDX-SYU)
           MOVE    WRK-SKYMONEY        TO  LNK-SKYMONEY (IDX-SYU)
           MOVE    WRK-SKYMONEY-TAX    TO  LNK-SKYMONEY-TAX (IDX-SYU)
           MOVE    WRK-NYUKIN-TOTAL    TO  LNK-NYUKIN-TOTAL (IDX-SYU)
           MOVE    WRK-HENKIN          TO  LNK-HENKIN       (IDX-SYU)
      *
           .
       30022-SYUTOTAL-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納合計処理
      *****************************************************************
       30021-SYUNOU-ADD-SEC             SECTION.
      *
           MOVE    LNK-SYUNOU-REC(IDX-SYU)     TO  SYUNOU-REC
      *
           ADD     WRK-SYU-TAX-TAISHOU TO  SYU-TAX-TAISHOU
           ADD     WRK-SYU-TAX-MONEY   TO  SYU-TAX-MONEY
           ADD     WRK-SYU-SKYGK       TO  SYU-SKYGK
           ADD     WRK-SYU-HKNTEKMONEY TO  SYU-HKNTEKMONEY
           ADD     WRK-SYU-SHOHOU-SAI      TO  SYU-SHOHOU-SAI
           PERFORM VARYING     IDS1    FROM    1   BY  1
                   UNTIL       IDS1    >   17
               ADD    WRK-SYU-HKNTEN (IDS1)    TO  SYU-HKNTEN(IDS1)
               ADD    WRK-SYU-MONEY (IDS1)     TO  SYU-MONEY (IDS1)
               ADD    WRK-SYU-TGMONEY (IDS1)   TO  SYU-TGMONEY(IDS1)
               ADD    WRK-SYU-TGMONEY-TAX (IDS1)
                                               TO  SYU-TGMONEY-TAX(IDS1)
           END-PERFORM
           PERFORM VARYING     IDS1    FROM    1   BY  1
                   UNTIL       IDS1    >   10
               ADD    WRK-SYU-JIHI-TAXNASI (IDS1)
                                           TO  SYU-JIHI-TAXNASI(IDS1)
               ADD    WRK-SYU-JIHI-TAXARI (IDS1)
                                           TO  SYU-JIHI-TAXARI(IDS1)
           END-PERFORM
           ADD     WRK-SYU-JIHI-TOTAL       TO  SYU-JIHI-TOTAL
           ADD     WRK-SYU-JIHI-TOTAL-TAX   TO  SYU-JIHI-TOTAL-TAX
           ADD     WRK-SYU-JIHI-TAX         TO  SYU-JIHI-TAX
           ADD     WRK-SYU-RJN-FTN          TO  SYU-RJN-FTN
           ADD     WRK-SYU-KOH-FTN          TO  SYU-KOH-FTN
           ADD     WRK-SYU-KOH-FTN-ENTANI   TO  SYU-KOH-FTN-ENTANI
           ADD     WRK-SYU-YKZ-FTN          TO  SYU-YKZ-FTN
      *保険適用外金額−消費税（再掲）
           ADD     WRK-SYU-TGMONEY-TAX-SAI  TO  SYU-TGMONEY-TAX-SAI
      *調整金
           ADD     WRK-SYU-CHOSEI           TO  SYU-CHOSEI
           ADD     WRK-SYU-CHOSEI1          TO  SYU-CHOSEI1
           ADD     WRK-SYU-CHOSEI2          TO  SYU-CHOSEI2
      *請求金額−消費税（再掲）
           ADD     WRK-SYU-SKYMONEY-TAX-SAI TO  SYU-SKYMONEY-TAX-SAI
      *請求金額
           ADD     WRK-SYU-SKYMONEY         TO  SYU-SKYMONEY
      *入金合計額
           ADD     WRK-SYU-NYUKIN-TOTAL     TO  SYU-NYUKIN-TOTAL 
      *労災保険
           ADD     WRK-SYU-RSISHOSHIN-MONEY
                                           TO  SYU-RSISHOSHIN-MONEY
           ADD     WRK-SYU-RSISAISHIN-MONEY
                                           TO  SYU-RSISAISHIN-MONEY
           ADD     WRK-SYU-RSISDO-MONEY    TO  SYU-RSISDO-MONEY
           ADD     WRK-SYU-RSIETC-MONEY    TO  SYU-RSIETC-MONEY
           ADD     WRK-SYU-RSI-TAX-SAI     TO  SYU-RSI-TAX-SAI
           ADD     WRK-SYU-RSI-TOTAL       TO  SYU-RSI-TOTAL
           ADD     WRK-SYU-RSIJIBAI-SKYMONEY
                                           TO  SYU-RSIJIBAI-SKYMONEY
      *まとめ入力差額
           ADD     WRK-SYU-GRP-SGKMONEY    TO  SYU-GRP-SGKMONEY
      *
           MOVE    SYUNOU-REC          TO  LNK-SYUNOU-REC(IDX-SYU)
      *
           ADD     WRK-SKYMONEY        TO  LNK-SKYMONEY (IDX-SYU)
           ADD     WRK-SKYMONEY-TAX    TO  LNK-SKYMONEY-TAX (IDX-SYU)
           ADD     WRK-NYUKIN-TOTAL    TO  LNK-NYUKIN-TOTAL (IDX-SYU)
           ADD     WRK-HENKIN          TO  LNK-HENKIN       (IDX-SYU)
           .
       30021-SYUNOU-ADD-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科別編集処理
      *****************************************************************
       3003-SYORI-03-SEC               SECTION.
      *
           MOVE    ZERO                TO  IDX-SYU
           INITIALIZE                  LNK-SYUNOU-AREA
           INITIALIZE                  LNK-SEIKYU-AREA
           INITIALIZE                  LNK-DOUJI-AREA
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   IDX-TBL
               MOVE    TBL-SYUNOU-REC (IDX)    TO  WRK-SYUNOU-REC
               MOVE    TBL-SKYMONEY   (IDX)    TO  WRK-SKYMONEY
               MOVE    TBL-SKYMONEY-TAX (IDX)  TO  WRK-SKYMONEY-TAX
               MOVE    TBL-NYUKIN-TOTAL (IDX)  TO  WRK-NYUKIN-TOTAL
               MOVE    TBL-HENKIN       (IDX)  TO  WRK-HENKIN
               MOVE    ZERO                TO  FLG-OK
               PERFORM VARYING  IDX-SYU    FROM    1   BY  1
                       UNTIL   (IDX-SYU    >   15  )  OR
                               (FLG-OK     =   1   )
                   IF      LNK-SYU-SRYKA(IDX-SYU)    =   SPACE
                       MOVE    TBL-SYUNOU-REC(IDX)
                                               TO  LNK-SYUNOU-REC
                                                       (IDX-SYU)
                       MOVE    TBL-SKYMONEY   (IDX)
                                                   TO  LNK-SKYMONEY
                                                       (IDX-SYU)
                       MOVE    TBL-SKYMONEY-TAX(IDX)
                                                   TO  LNK-SKYMONEY-TAX
                                                       (IDX-SYU)
                       MOVE    TBL-NYUKIN-TOTAL   (IDX)
                                                   TO  LNK-NYUKIN-TOTAL
                                                       (IDX-SYU)
                       MOVE    TBL-HENKIN         (IDX)
                                                   TO  LNK-HENKIN
                                                       (IDX-SYU)
                       MOVE    1                   TO  FLG-OK
                       MOVE    ZERO                TO  IDX-DN
                   ELSE
                       IF      LNK-SYU-SRYKA (IDX-SYU)
                                           =   WRK-SYU-SRYKA
                           MOVE    LNK-SYU-HKNCOMBINUM(IDX-SYU)
                                               TO  WRK-HKNCOMBI
                           PERFORM 30031-DOUJI-HKNCOMBI-SEC
      *                    伝票番号
                           ADD     1               TO  IDX-DN
                           MOVE    WRK-SYU-DENPNUM TO  LNK-DOUJI-DENPNUM
                                                      (IDX-SYU IDX-DN)
      *                    複数保険
                           MOVE    ZERO        TO  LNK-SYU-HKNCOMBINUM
                                                           (IDX-SYU)
                           PERFORM 30021-SYUNOU-ADD-SEC
                           MOVE    1           TO  FLG-OK
                       END-IF
                   END-IF
               END-PERFORM
           END-PERFORM
      *    パラメタへ編集
           PERFORM 30023-LNK-TBL-HENSYU-SEC
      *
           .
       3003-SYORI-03-EXT.
           EXIT.
      *
      *****************************************************************
      *    まとめ複数保険編集処理
      *****************************************************************
       30031-DOUJI-HKNCOMBI-SEC               SECTION.
      *
           PERFORM VARYING     IDH3    FROM    1   BY  1
                   UNTIL       IDH3    >   10
               IF      LNK-DOUJI-HKNCOMBI (IDX-SYU IDH3)
                                       =   SPACE
                   MOVE    WRK-HKNCOMBI    TO   LNK-DOUJI-HKNCOMBI
                                                         (IDX-SYU IDH3)
               END-IF
               IF      LNK-DOUJI-HKNCOMBI (IDX-SYU IDH3)
                                       =   WRK-HKNCOMBI
                   MOVE    10          TO  IDH3
               END-IF
           END-PERFORM
      *
      *
           .
       30031-DOUJI-HKNCOMBI-EXT.
           EXIT.
      *
      *****************************************************************
      *    まとめ合計編集処理
      *****************************************************************
       3004-SYORI-04-SEC               SECTION.
      *
           INITIALIZE                  LNK-DOUJI-AREA2
           MOVE    ZERO                TO  IDX-DN
           PERFORM VARYING     IDX     FROM    2   BY  1
                   UNTIL       IDX     >   IDX-TBL
               MOVE    TBL-SYUNOU-REC (IDX)    TO  WRK-SYUNOU-REC
      *        伝票番号
               ADD     1                   TO  IDX-DN
               MOVE    WRK-SYU-DENPNUM     TO  LNK-DOUJI-DENPNUM
                                                 (1 IDX-DN)
           END-PERFORM
      *
      *H27.8
      *    診療科保存
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   IDX-TBL
               MOVE    TBL-SYUNOU-REC (IDX)    TO  WRK-SYUNOU-REC
      *        複数科
               MOVE    1                   TO  IDX-SYU
               MOVE    WRK-SYU-SRYKA       TO  WRK-SRYKA
               PERFORM 30041-DOUJI-SRYKA-SEC
           END-PERFORM
      *    診療科保存
           MOVE    LNK-DOUJI-SRYKA-G (1)   TO  WRK-DOUJI-SRYKA-G
      *
      *    保険別に集計する
           PERFORM 3002-SYORI-02-SEC
      *    合計する
           INITIALIZE                      TBL-SYUNOU-AREA
           MOVE    LNK-SYUNOU-AREA     TO  TBL-SYUNOU-AREA
           MOVE    LNK-SEIKYU-AREA     TO  TBL-SEIKYU-AREA
           MOVE    ZERO                TO  IDX-SYU
           INITIALIZE                  LNK-SYUNOU-AREA
           INITIALIZE                  LNK-SEIKYU-AREA
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   15   )  OR
                              (IDX     >   ORCHC03SUB-MAX)
               MOVE    TBL-SYUNOU-REC (IDX)    TO  WRK-SYUNOU-REC
               MOVE    TBL-SKYMONEY   (IDX)    TO  WRK-SKYMONEY
               MOVE    TBL-SKYMONEY-TAX (IDX)  TO  WRK-SKYMONEY-TAX
               MOVE    TBL-NYUKIN-TOTAL (IDX)  TO  WRK-NYUKIN-TOTAL
               MOVE    TBL-HENKIN       (IDX)  TO  WRK-HENKIN
               MOVE    1                   TO  IDX-SYU
               IF      IDX                 =   1
                   MOVE    TBL-SYUNOU-REC(IDX)
                                           TO  LNK-SYUNOU-REC
                                                       (IDX-SYU)
                   MOVE    TBL-SKYMONEY   (IDX)
                                           TO  LNK-SKYMONEY
                                                       (IDX-SYU)
                   MOVE    TBL-SKYMONEY-TAX(IDX)
                                           TO  LNK-SKYMONEY-TAX
                                                       (IDX-SYU)
                   MOVE    TBL-NYUKIN-TOTAL (IDX)
                                           TO  LNK-NYUKIN-TOTAL
                                                       (IDX-SYU)
                   MOVE    TBL-HENKIN       (IDX)
                                           TO  LNK-HENKIN
                                                       (IDX-SYU)
                   IF      ORCHC03SUB-MAX      >  1
      *                複数保険
                       MOVE    WRK-SYU-HKNCOMBINUM TO  WRK-HKNCOMBI
                       PERFORM 30031-DOUJI-HKNCOMBI-SEC
                   END-IF
      ****         複数科
      *            MOVE    WRK-SYU-SRYKA   TO  WRK-SRYKA
      ****         PERFORM 30041-DOUJI-SRYKA-SEC
               ELSE
                   PERFORM 30021-SYUNOU-ADD-SEC
      *            複数保険
                   MOVE    WRK-SYU-HKNCOMBINUM TO  WRK-HKNCOMBI
                   PERFORM 30031-DOUJI-HKNCOMBI-SEC
                   MOVE    ZERO            TO  LNK-SYU-HKNCOMBINUM
                                                           (IDX-SYU)
      ****         複数科
      *            MOVE    WRK-SYU-SRYKA   TO  WRK-SRYKA
      ****         PERFORM 30041-DOUJI-SRYKA-SEC
               END-IF
           END-PERFORM
      *H27.8
      *    診療科
           MOVE    WRK-DOUJI-SRYKA-G   TO  LNK-DOUJI-SRYKA-G (IDX-SYU)
      *    パラメタへ編集
           PERFORM 30023-LNK-TBL-HENSYU-SEC
      *
           .
       3004-SYORI-04-EXT.
           EXIT.
      *
      *****************************************************************
      *    同時入力診療科編集処理
      *****************************************************************
       30041-DOUJI-SRYKA-SEC             SECTION.
      *
           IF      WRK-SRYKA           =   SPACE
                                       OR  ZERO
               CONTINUE
           ELSE
      *
           PERFORM VARYING     IDH3    FROM    1   BY  1
                   UNTIL       IDH3    >   10
               IF      LNK-DOUJI-SRYKA (IDX-SYU IDH3)
                                       =   SPACE
                   MOVE    WRK-SRYKA       TO   LNK-DOUJI-SRYKA
                                                         (IDX-SYU IDH3)
               END-IF
               IF      LNK-DOUJI-SRYKA (IDX-SYU IDH3)
                                       =   WRK-SRYKA
                   MOVE    10          TO  IDH3
               END-IF
           END-PERFORM
      *
           END-IF
           .
       30041-DOUJI-SRYKA-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納マスター読込
      *****************************************************************
       980-SYUNOU-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
               MOVE    ZERO            TO  FLG-SYUNOU
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
           .
       980-SYUNOU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納合計マスター読込
      *****************************************************************
       981-SYUTTL-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYUTTL-REC
               MOVE    ZERO            TO  FLG-SYUTTL
           ELSE
               INITIALIZE                  SYUTTL-REC
               MOVE    1               TO  FLG-SYUTTL
           END-IF
      *
           .
       981-SYUTTL-READ-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       920-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
       920-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    クロース処理
      *****************************************************************
       990-DBCLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
       990-DBCLOSE-EXT.
           EXIT.
      *
