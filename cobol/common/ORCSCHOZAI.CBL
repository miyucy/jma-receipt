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
       PROGRAM-ID.                 ORCSCHOZAI.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院会計照会
      *  コンポーネント名  : 入院用入院調剤料更新処理
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/01/10    NACL−多々納  新規作成
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
           03  FLG-SRYACT          PIC 9(01).
           03  FLG-SRYACCT         PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-NYUINACCT       PIC 9(01).
           03  FLG-PTNYUINRRK      PIC 9(01).
      *
           03  FLG-ARI             PIC 9(01).
           03  FLG-MADOKU          PIC 9(01).
      *
           03  FLG-OK              PIC 9(01).
      *
           03  FLG-TOU-NASI        PIC 9(01).
           03  FLG-MAD-NASI        PIC 9(01).
           03  FLG-SYORI           PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDX3                PIC 9(04).
           03  IDY                 PIC 9(04).
      *
           03  IDX-T               PIC 9(04).
           03  IDX-H               PIC 9(04).
           03  IDX-D               PIC 9(02).
           03  IDY2                PIC 9(02).
      *
           03  IDX-S               PIC 9(02).
           03  IDX-E               PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
      *
           03  WRK-DD              PIC 9(02).
           03  WRK-MAX             PIC 9(02).
      *
           03  WRK-SRYCD               PIC X(08).
      *    末日
           03  WRK-MATU                PIC 9(02).
           03  WRK-SRYYM.
               05  WRK-SRYYY           PIC 9(04).
               05  WRK-SRYMM           PIC 9(02).
           03  WRK-SRYKBN              PIC X(02).
           03  WRK-KAISU               PIC 9(03).
      *
      *    投薬日
       01  TBL-TOUYAKU-AREA.
           03  TBL-TOUYAKU-OCC1        OCCURS   2.
               05  TBL-TOUYAKU-OCC         OCCURS   31.
                   07  TBL-TOU-DAY         PIC 9(01).
                   07  TBL-DOK-DAY         PIC 9(01).
                   07  TBL-TOU-SRYKA       PIC X(02).
                   07  TBL-TOU-HKNCOMBI    PIC X(04).
      *    調剤料
       01  TBL-CHOZAI-AREA.
           03  TBL-CHOZAI-OCC         OCCURS   10.
               05  TBL-CHO-ZAINUM          PIC 9(08).
               05  TBL-CHO-SRYKA           PIC X(02).
               05  TBL-CHO-HKNCOMBI        PIC X(04).
      *        作成
               05  TBL-CHO-DAY-AREA.
                   07  TBL-CHO-DAY-TBL     OCCURS   4.
                        09  TBL-CHO-DAY    PIC 9(03)
                                           OCCURS  31.
      *    麻毒料
       01  TBL-MADOKU-AREA.
           03  TBL-MADOKU-OCC         OCCURS   10.
               05  TBL-MAD-ZAINUM          PIC 9(08).
               05  TBL-MAD-SRYKA           PIC X(02).
               05  TBL-MAD-HKNCOMBI        PIC X(04).
      *        作成
               05  TBL-MAD-DAY-AREA.
                   07  TBL-MAD-DAY-TBL     OCCURS   4.
                        09  TBL-MAD-DAY    PIC 9(03)
                                           OCCURS  31.
      *    外泊
       01  TBL-GAIHAKU-AREA.
           03  TBL-GAIHAKU-OCC         OCCURS   31.
               05  TBL-GAI-DAY         PIC 9(01).
      *    入院期間
       01  TBL-NYUIN-AREA.
           03  TBL-NYUIN-OCC         OCCURS   31.
               05  TBL-NYU-DAY         PIC 9(01).
               05  TBL-NYU-SRYKA       PIC X(02).
               05  TBL-NYU-HKNCOMBI    PIC X(04).
      *
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    診療行為マスター
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    診療会計マスタ−
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    受診履歴
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *    入院診療会計マスタ−
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *   算定履歴更新サブ
           COPY    "CPORCSSANTEI.INC".
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
      *    診療行為入院更新パラメタ領域
           COPY    "CPORCSCHOZAI.INC".
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           ORCSCHOZAIAREA
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
           INITIALIZE                  TBL-TOUYAKU-AREA
           INITIALIZE                  TBL-CHOZAI-AREA
           INITIALIZE                  TBL-MADOKU-AREA
           INITIALIZE                  TBL-GAIHAKU-AREA
      *
           INITIALIZE                  ORCSCHO-ERRCD
      *
      *    投薬の日数編集
           PERFORM 100-TOUYAKU-HEN-SEC
      *
      *    外泊の編集
           PERFORM 200-GAIHAKU-HEN-SEC
      *
      *    入院調剤料と麻毒の確定
           PERFORM 300-CHOZAI-HEN-SEC
      *
      *    入院調剤料と麻毒の更新
           PERFORM 400-SANTEI-SYORI-SEC
      *
           .
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
      *****************************************************************
      *    投薬の日数編集処理
      *****************************************************************
       100-TOUYAKU-HEN-SEC             SECTION.
      *
           INITIALIZE                  TBL-TOUYAKU-AREA
           MOVE    ORCSCHO-SRYYM       TO  WRK-SRYYM
      *    前後３月分
           COMPUTE WRK-SRYMM           =   WRK-SRYMM   -   1
           IF      WRK-SRYMM           =   ZERO
               COMPUTE WRK-SRYYY       =   WRK-SRYYY   -   1
               MOVE    12              TO  WRK-SRYMM
           END-IF
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
      *        診療年月の末日算定
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY7-AREA
               MOVE    "71"                TO  LNK-DAY7-IRAI
               MOVE    WRK-SRYYM           TO  LNK-DAY7-YM
               CALL    "ORCSDAY"           USING
                                           STS-AREA-DAY
                                           LNK-DAY7-AREA
               MOVE    LNK-DAY7-KOYOMI(7:2)    TO  WRK-MATU
      *
               MOVE    "21"                TO  WRK-SRYKBN
               PERFORM 10011-SRYACCT-21HEN-SEC
      *        次月
               COMPUTE WRK-SRYMM           =   WRK-SRYMM   +   1
               IF      WRK-SRYMM           >   12
                   COMPUTE WRK-SRYYY       =   WRK-SRYYY   +   1
                   MOVE    1               TO  WRK-SRYMM
               END-IF
      *
           END-PERFORM
      *    頓服
           MOVE    "22"                TO  WRK-SRYKBN
           MOVE    ORCSCHO-SRYYM       TO  WRK-SRYYM
           PERFORM 10012-SRYACCT-HEN-SEC
      *    外用
           MOVE    "23"                TO  WRK-SRYKBN
           MOVE    ORCSCHO-SRYYM       TO  WRK-SRYYM
           PERFORM 10012-SRYACCT-HEN-SEC
      *
           .
       100-TOUYAKU-HEN-EXT.
           EXIT.
      *****************************************************************
      *    投薬の編集処理
      *****************************************************************
       10011-SRYACCT-21HEN-SEC             SECTION.
      *
      *    診療年月の診療会計マスタ読み込み
           MOVE    SPACE               TO  SRYACCT-REC
           INITIALIZE                      SRYACCT-REC
           MOVE    SPA-HOSPID          TO  ACCT-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  ACCT-NYUGAIKBN
           MOVE    ORCSCHO-PTID        TO  ACCT-PTID
           MOVE    WRK-SRYYM           TO  ACCT-SRYYM
           MOVE    "21"                TO  ACCT-SRYKBN
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
               PERFORM 930-SRYACCT-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SRYACCT
           END-IF
           PERFORM
               UNTIL       (FLG-SRYACCT         =   1       )
             IF      ACCT-YKZTEN       >   ZERO
      *        最初の日を保存（点数マスタ検索のため）
               MOVE    01                  TO  WRK-DD
               PERFORM VARYING     IDY2    FROM    1   BY  1
                       UNTIL       IDY2    >   31
                   IF      ACCT-DAY (1 IDY2)   >   ZERO
                       MOVE    IDY2                TO  WRK-DD
                   END-IF
               END-PERFORM
      *        診療行為より麻毒判定
               PERFORM 600111-SRYACT-HEN-SEC
      *        回数により保存
               PERFORM VARYING     IDY2    FROM    1   BY  1
                       UNTIL       IDY2    >   31
                   IF      ACCT-DAY (1 IDY2)   >   ZERO
                       MOVE    ACCT-DAY (1 IDY2)   TO  WRK-KAISU
                       PERFORM VARYING IDX2    FROM    1   BY   1
                               UNTIL   IDX2    >   WRK-KAISU
                           COMPUTE IDX3        =   IDY2
                                               +   IDX2
                                               -   1
                           IF      IDX3        >   WRK-MATU
      *                        翌月へ
                               COMPUTE IDX3        =   IDX3
                                                   -   WRK-MATU
      *                        ２月以上またがらないこととする
                               IF      IDX3        >   31
                                   MOVE    31          TO  IDX3
                               END-IF
                               COMPUTE IDX1            =   IDX   +   1
                           ELSE
                               MOVE    IDX             TO  IDX1
                           END-IF
                           MOVE    1               TO  TBL-TOU-DAY
                                                            (IDX1 IDX3)
                           MOVE    ACCT-SRYKA      TO  TBL-TOU-SRYKA
                                                            (IDX1 IDX3)
                           MOVE    ACCT-HKNCOMBI   TO  TBL-TOU-HKNCOMBI
                                                            (IDX1 IDX3)
                           IF      FLG-MADOKU      =   1
                               MOVE    1               TO  TBL-DOK-DAY
                                                            (IDX1 IDX3)
                           END-IF
                       END-PERFORM
                   END-IF
               END-PERFORM
      *
             END-IF
      *
               MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
               PERFORM 930-SRYACCT-READ-SEC
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
      *    CALL    "ORCMCPSUB"         USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
      *
           .
       10011-SRYACCT-21HEN-EXT.
           EXIT.
      *****************************************************************
      *    頓服・外用の編集処理
      *****************************************************************
       10012-SRYACCT-HEN-SEC             SECTION.
      *
      *    診療年月の診療会計マスタ読み込み
           MOVE    SPACE               TO  SRYACCT-REC
           INITIALIZE                      SRYACCT-REC
           MOVE    SPA-HOSPID          TO  ACCT-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  ACCT-NYUGAIKBN
           MOVE    ORCSCHO-PTID        TO  ACCT-PTID
           MOVE    WRK-SRYYM           TO  ACCT-SRYYM
           MOVE    WRK-SRYKBN          TO  ACCT-SRYKBN
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
               PERFORM 930-SRYACCT-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SRYACCT
           END-IF
           PERFORM
               UNTIL       (FLG-SRYACCT         =   1       )
               IF      ACCT-YKZTEN       >   ZERO
      *            最初の日を保存（点数マスタ検索のため）
                   MOVE    01                  TO  WRK-DD
                   PERFORM VARYING     IDY2    FROM    1   BY  1
                           UNTIL       IDY2    >   31
                       IF      ACCT-DAY (1 IDY2)   >   ZERO
                           MOVE    IDY2                TO  WRK-DD
                       END-IF
                   END-PERFORM
      *            診療行為より麻毒判定
                   PERFORM 600111-SRYACT-HEN-SEC
      *            回数により保存
                   PERFORM VARYING     IDY2    FROM    1   BY  1
                           UNTIL       IDY2    >   31
                       IF      ACCT-DAY (1 IDY2)   >   ZERO
                           MOVE    1               TO  TBL-TOU-DAY
                                                            (2  IDX3)
                           IF      TBL-TOU-SRYKA(IDX1 IDX3) =   SPACE
                               MOVE    ACCT-SRYKA      TO  TBL-TOU-SRYKA
                                                            (IDX1 IDX3)
                               MOVE    ACCT-HKNCOMBI   TO
                                                       TBL-TOU-HKNCOMBI
                                                            (IDX1 IDX3)
                           END-IF
                           IF      FLG-MADOKU      =   1
                               MOVE    1               TO  TBL-DOK-DAY
                                                            (2  IDX3)
                           END-IF
                       END-IF
                   END-PERFORM
               END-IF
      *
               MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
               PERFORM 930-SRYACCT-READ-SEC
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
      *    CALL    "ORCMCPSUB"         USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
      *
           .
       10012-SRYACCT-HEN-EXT.
           EXIT.
      *****************************************************************
      *    診療行為マスター編集処理
      *****************************************************************
       600111-SRYACT-HEN-SEC             SECTION.
      *
           MOVE    ZERO                TO  FLG-ARI
           MOVE    ZERO                TO  FLG-MADOKU
      *    診療会計マスターから診療行為マスターを検索する
           MOVE    SPACE               TO  SRYACT-REC
           INITIALIZE                      SRYACT-REC
           MOVE    ACCT-HOSPID         TO  SRY-HOSPID
           MOVE    ACCT-NYUGAIKBN      TO  SRY-NYUGAIKBN
           MOVE    ACCT-PTID           TO  SRY-PTID
           MOVE    ACCT-SRYKA          TO  SRY-SRYKA
           MOVE    ACCT-SRYYM          TO  SRY-SRYYM
           MOVE    ACCT-ZAINUM         TO  SRY-ZAINUM
      *
           MOVE    SRYACT-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               PERFORM 920-SRYACT-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-SRYACT
           END-IF
           PERFORM UNTIL      FLG-SRYACT   =   1
               PERFORM VARYING     IDX2    FROM    1   BY  1
                       UNTIL      (IDX2            >   5   )  OR
                                  (FLG-MADOKU      =   1    )  OR
                                  (SRY-SRYCD(IDX2) =   SPACE )
      *            薬剤
                   IF      SRY-SRYCD (IDX2)(1:1)   =   "6"
                       MOVE    1                   TO  FLG-ARI
      *                点数マスタ
                       MOVE    SRY-SRYCD (IDX2)    TO  TNS-SRYCD
                       PERFORM 910-TENSU-READ-SEC
                       IF      TNS-MADOKUKBN       NOT =   ZERO
                           MOVE    1               TO  FLG-MADOKU
                       END-IF
                   END-IF
               END-PERFORM
      *
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               PERFORM 920-SRYACT-NEXT-SEC
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
      *    CALL    "ORCMCPSUB"         USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *                                MCPDATA-REC
      *
      *
           .
       600111-SRYACT-HEN-EXT.
           EXIT.
      *****************************************************************
      *    外泊の編集処理
      *****************************************************************
       200-GAIHAKU-HEN-SEC             SECTION.
      *
      *    診療会計マスターを特定する
           INITIALIZE                      NYUINACCT-REC
           MOVE    SPA-HOSPID          TO  NACCT-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  NACCT-NYUGAIKBN
           MOVE    ORCSCHO-PTID        TO  NACCT-PTID
           MOVE    ORCSCHO-SRYYM       TO  NACCT-SRYYM
           MOVE    "2"                 TO  NACCT-ZAISKBKBN
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "NYUINACCT-KEY17"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "NYUINACCT-KEY17"    TO  ORC-DBPATH
               PERFORM 930-NYUINACCT-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-NYUINACCT
           END-IF
           PERFORM
               UNTIL   FLG-NYUINACCT       =   1
               PERFORM VARYING     IDX     FROM    1   BY  1
                       UNTIL       IDX     >   31
                   IF      NACCT-DAY (IDX) >   ZERO
                       MOVE    NACCT-DAY (IDX)     TO  TBL-GAI-DAY(IDX)
                   END-IF
               END-PERFORM
      *
               MOVE    "NYUINACCT-KEY17"    TO  ORC-DBPATH
               PERFORM 930-NYUINACCT-READ-SEC
           END-PERFORM
      *
      *
      *    入院履歴判定
           MOVE    SPACE               TO  PTNYUINRRK-REC
           INITIALIZE                  PTNYUINRRK-REC
           MOVE    SPA-HOSPID          TO  PTNYUINRRK-HOSPID
           MOVE    ORCSCHO-PTID        TO  PTNYUINRRK-PTID
           MOVE    ORCSCHO-SRYYM       TO  PTNYUINRRK-NYUINYMD(1:6)
           MOVE    "01"                TO  PTNYUINRRK-NYUINYMD(7:2)
           MOVE    ORCSCHO-SRYYM       TO  PTNYUINRRK-TAIINYMD(1:6)
           MOVE    "01"                TO  PTNYUINRRK-TAIINYMD(7:2)
      *
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTNYUINRRK-KEY11"  TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTNYUINRRK-KEY11"  TO  ORC-DBPATH
               PERFORM 910-PTNYUINRRK-READ-SEC
           ELSE
               MOVE    1               TO  FLG-PTNYUINRRK
               INITIALIZE                  PTNYUINRRK-REC
           END-IF
           INITIALIZE                  TBL-NYUIN-AREA
           MOVE    ZERO                TO  FLG-OK
           PERFORM
                   UNTIL      (FLG-PTNYUINRRK      =   1 )  OR
                              (FLG-OK              =   1 )
      *        入院日から９０日以上の判定
               MOVE    ZERO                    TO  WRK-MAX
               IF      PTNYUINRRK-NYUINYMD(1:6)    <   ORCSCHO-SRYYM
                   INITIALIZE                      STS-AREA-DAY
                   INITIALIZE                      LNK-DAY6-AREA
                   MOVE    "61"                TO  LNK-DAY6-IRAI
                   MOVE    PTNYUINRRK-NYUINYMD TO  LNK-DAY6-KIJUN
                   MOVE    "1"                 TO  LNK-DAY6-ZOGENPTN
                   MOVE    90                  TO  LNK-DAY6-ZOGEN
                   CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                       LNK-DAY6-AREA
                   IF      LNK-DAY6-KOYOMI(1:6)    =   ORCSCHO-SRYYM
                       MOVE    LNK-DAY6-KOYOMI(7:2)    TO  WRK-MAX
                   END-IF
                   IF      LNK-DAY6-KOYOMI(1:6)    <   ORCSCHO-SRYYM
                       MOVE    31                      TO  WRK-MAX
                   END-IF
               END-IF
      *
      *        入院中の時
               MOVE    ZERO                TO  IDX-S
               MOVE    ZERO                TO  IDX-E
               IF     (PTNYUINRRK-NYUINYMD(1:6)  <   ORCSCHO-SRYYM) AND
                      (PTNYUINRRK-TAIINYMD(1:6)  >   ORCSCHO-SRYYM)
                   MOVE    1               TO  IDX-S
                   MOVE    31              TO  IDX-E
                   MOVE    1               TO  FLG-OK
               END-IF
      *        入院日
               IF      PTNYUINRRK-NYUINYMD(1:6)  =   ORCSCHO-SRYYM
                   MOVE    PTNYUINRRK-TAIINYMD(7:2)  TO  IDX-S
               END-IF
               IF      PTNYUINRRK-NYUINYMD(1:6)  <   ORCSCHO-SRYYM
                   MOVE    1                         TO  IDX-S
               END-IF
      *        退院日
               IF     PTNYUINRRK-TAIINYMD(1:6)   =   ORCSCHO-SRYYM
                   MOVE    PTNYUINRRK-TAIINYMD(7:2)  TO  IDX-E
               END-IF
               IF     PTNYUINRRK-TAIINYMD(1:6)   >   ORCSCHO-SRYYM
                   MOVE    31                        TO  IDX-E
               END-IF
      *
               IF     (IDX-S               >   ZERO )  AND
                      (IDX-E               >   ZERO )
                   PERFORM VARYING     IDX     FROM    IDX-S  BY  1
                           UNTIL       IDX     >   IDX-E
                       MOVE    1                   TO  TBL-NYU-DAY(IDX)
      *                入院の科と保険
                       MOVE    PTNYUINRRK-NYUINKA  TO  TBL-NYU-SRYKA
                                                                  (IDX)
                       MOVE    PTNYUINRRK-HKNCOMBINUM
                                                   TO  TBL-NYU-HKNCOMBI
                                                                  (IDX)
                   END-PERFORM
               END-IF
      *
               IF      WRK-MAX             >   ZERO
                   ADD     1               TO  WRK-MAX
                   PERFORM VARYING     IDX     FROM    WRK-MAX BY  1
                           UNTIL       IDX     >   31
                       MOVE    ZERO                TO  TBL-NYU-DAY(IDX)
                   END-PERFORM
               END-IF
      *
               MOVE    "PTNYUINRRK-KEY11"  TO  ORC-DBPATH
               PERFORM 910-PTNYUINRRK-READ-SEC
           END-PERFORM
      *
           .
       200-GAIHAKU-HEN-EXT.
           EXIT.
      *****************************************************************
      *    入院調剤料と麻毒の確定処理
      *****************************************************************
       300-CHOZAI-HEN-SEC             SECTION.
      *
      *    調剤料
           MOVE    ZERO                TO  IDX1
           INITIALIZE                  TBL-CHOZAI-AREA
      *
      *    診療年月の診療会計マスタ読み込み
           MOVE    SPACE               TO  SRYACCT-REC
           INITIALIZE                      SRYACCT-REC
           MOVE    SPA-HOSPID          TO  ACCT-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  ACCT-NYUGAIKBN
           MOVE    ORCSCHO-PTID        TO  ACCT-PTID
           MOVE    ORCSCHO-SRYYM       TO  ACCT-SRYYM
           MOVE    "24"                TO  ACCT-SRYKBN
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
               PERFORM 930-SRYACCT-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SRYACCT
           END-IF
           PERFORM
               UNTIL       (FLG-SRYACCT         =   1 )  OR
                           (IDX1                >=  10 )
               ADD     1                   TO  IDX1
               MOVE    ACCT-ZAINUM         TO  TBL-CHO-ZAINUM  (IDX1)
               MOVE    ACCT-SRYKA          TO  TBL-CHO-SRYKA   (IDX1)
               MOVE    ACCT-HKNCOMBI       TO  TBL-CHO-HKNCOMBI(IDX1)
               MOVE    ACCT-DAY-AREA       TO  TBL-CHO-DAY-AREA(IDX1)
      *
               MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
               PERFORM 930-SRYACCT-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       MCPDATA-REC
      *
      *    麻毒料
           MOVE    ZERO                TO  IDX1
           INITIALIZE                  TBL-MADOKU-AREA
      *
      *    診療年月の診療会計マスタ読み込み
           MOVE    SPACE               TO  SRYACCT-REC
           INITIALIZE                      SRYACCT-REC
           MOVE    SPA-HOSPID          TO  ACCT-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  ACCT-NYUGAIKBN
           MOVE    ORCSCHO-PTID        TO  ACCT-PTID
           MOVE    ORCSCHO-SRYYM       TO  ACCT-SRYYM
           MOVE    "26"                TO  ACCT-SRYKBN
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
               PERFORM 930-SRYACCT-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SRYACCT
           END-IF
           PERFORM
               UNTIL       (FLG-SRYACCT         =   1 )  OR
                           (IDX1                >=  10 )
               ADD     1                   TO  IDX1
               MOVE    ACCT-ZAINUM         TO  TBL-MAD-ZAINUM  (IDX1)
               MOVE    ACCT-SRYKA          TO  TBL-MAD-SRYKA   (IDX1)
               MOVE    ACCT-HKNCOMBI       TO  TBL-MAD-HKNCOMBI(IDX1)
               MOVE    ACCT-DAY-AREA       TO  TBL-MAD-DAY-AREA(IDX1)
      *
               MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
               PERFORM 930-SRYACCT-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       300-CHOZAI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    調剤料再編集処理
      *****************************************************************
       400-SANTEI-SYORI-SEC            SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   31
               IF     (TBL-TOU-DAY (2 IDX)     =   ZERO )  OR
                      (TBL-GAI-DAY (IDX)       >   ZERO )  OR
                      (TBL-NYU-DAY (IDX)       =   ZERO )
      *            調剤料なし
                   PERFORM 4001-TOU-DEL-SYORI-SEC
               ELSE
      *            調剤料あり
                   PERFORM 4002-TOU-ADD-SYORI-SEC
               END-IF
      *
               IF     (TBL-DOK-DAY (2 IDX)     =   ZERO )  OR
                      (TBL-GAI-DAY (IDX)       >   ZERO )  OR
                      (TBL-NYU-DAY (IDX)       =   ZERO )
      *            調剤料なし
                   PERFORM 4003-MAD-DEL-SYORI-SEC
               ELSE
      *            調剤料あり
                   PERFORM 4004-MAD-ADD-SYORI-SEC
               END-IF
           END-PERFORM
      *
      *    調剤料更新
           PERFORM 4005-CHOU-UPDATE-SEC
      *
      *    麻毒更新
           PERFORM 4006-MADO-UPDATE-SEC
           .
      *
       400-SANTEI-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    調剤料なし処理
      *****************************************************************
       4001-TOU-DEL-SYORI-SEC            SECTION.
      *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL      (IDX2    >   10  )  OR
                              (TBL-CHO-ZAINUM(IDX2)    =   ZERO )
               MOVE    ZERO           TO  TBL-CHO-DAY (IDX2 1 IDX)
               MOVE    ZERO           TO  TBL-CHO-DAY (IDX2 2 IDX)
               MOVE    ZERO           TO  TBL-CHO-DAY (IDX2 3 IDX)
               MOVE    ZERO           TO  TBL-CHO-DAY (IDX2 4 IDX)
           END-PERFORM
           .
      *
       4001-TOU-DEL-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    調剤料あり処理
      *****************************************************************
       4002-TOU-ADD-SYORI-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-ARI
      *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL      (IDX2    >   10  )  OR
                              (TBL-CHO-ZAINUM(IDX2)    =   ZERO )
               IF      TBL-CHO-DAY (IDX2 1 IDX)   >   ZERO
                   MOVE    1               TO  FLG-ARI
               END-IF
           END-PERFORM
           IF     FLG-ARI              =   1
               GO      TO      4002-TOU-ADD-SYORI-EXT
           END-IF
      *    当日調剤料指定がない時、最初の剤へ
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL      (IDX2    >   10  )  OR
                              (TBL-CHO-ZAINUM(IDX2)    =   ZERO )
               IF     (TBL-CHO-SRYKA(IDX2)     =   TBL-TOU-SRYKA
                                                         (2 IDX)) AND
                      (TBL-CHO-HKNCOMBI(IDX2)  =   TBL-TOU-HKNCOMBI
                                                         (2 IDX))
                   MOVE    1               TO  TBL-CHO-DAY (IDX2 1 IDX)
                   MOVE    1               TO  TBL-CHO-DAY (IDX2 2 IDX)
                   MOVE    1               TO  FLG-ARI
               END-IF
           END-PERFORM
      *
      *    当日調剤料指定がない時、最初の剤へ
           IF     FLG-ARI              =   ZERO
               IF      TBL-CHO-ZAINUM(1)   =   ZERO
                   MOVE    1               TO  ORCSCHO-ERRCD
                   MOVE    1               TO  FLG-TOU-NASI
               END-IF
               MOVE    1               TO  TBL-CHO-DAY (1 1 IDX)
               MOVE    1               TO  TBL-CHO-DAY (1 2 IDX)
           END-IF
           .
      *
       4002-TOU-ADD-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    麻毒なし処理
      *****************************************************************
       4003-MAD-DEL-SYORI-SEC            SECTION.
      *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL      (IDX2    >   10  )  OR
                              (TBL-MAD-ZAINUM(IDX2)    =   ZERO )
               MOVE    ZERO           TO  TBL-MAD-DAY (IDX2 1 IDX)
               MOVE    ZERO           TO  TBL-MAD-DAY (IDX2 2 IDX)
               MOVE    ZERO           TO  TBL-MAD-DAY (IDX2 3 IDX)
               MOVE    ZERO           TO  TBL-MAD-DAY (IDX2 4 IDX)
           END-PERFORM
           .
      *
       4003-MAD-DEL-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    麻毒あり処理
      *****************************************************************
       4004-MAD-ADD-SYORI-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-ARI
      *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL      (IDX2    >   10  )  OR
                              (TBL-MAD-ZAINUM(IDX2)    =   ZERO )
               IF      TBL-MAD-DAY (IDX2 1 IDX)   >   ZERO
                   MOVE    1               TO  FLG-ARI
               END-IF
           END-PERFORM
           IF     FLG-ARI              =   1
               GO      TO      4004-MAD-ADD-SYORI-EXT
           END-IF
      *    当日調剤料指定がない時、最初の剤へ
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL      (IDX2    >   10  )  OR
                              (TBL-MAD-ZAINUM(IDX2)    =   ZERO )
               IF     (TBL-MAD-SRYKA(IDX2)     =   TBL-TOU-SRYKA
                                                         (2 IDX)) AND
                      (TBL-MAD-HKNCOMBI(IDX2)  =   TBL-TOU-HKNCOMBI
                                                         (2 IDX))
                   MOVE    1               TO  TBL-MAD-DAY (IDX2 1 IDX)
                   MOVE    1               TO  TBL-MAD-DAY (IDX2 2 IDX)
                   MOVE    1               TO  FLG-ARI
               END-IF
           END-PERFORM
      *    当日調剤料指定がない時、最初の剤へ
           IF     FLG-ARI              =   ZERO
               IF      TBL-MAD-ZAINUM(1)   =   ZERO
                   MOVE    2               TO  ORCSCHO-ERRCD
                   MOVE    1               TO  FLG-MAD-NASI
               END-IF
               MOVE    1               TO  TBL-MAD-DAY (1 1 IDX)
               MOVE    1               TO  TBL-MAD-DAY (1 2 IDX)
           END-IF
           .
      *
       4004-MAD-ADD-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    調剤料更新処理
      *****************************************************************
       4005-CHOU-UPDATE-SEC            SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   10  )  OR
                              (TBL-CHO-ZAINUM(IDX) =   ZERO )
               INITIALIZE                      SRYACCT-REC
               MOVE    SPA-HOSPID          TO  ACCT-HOSPID
               MOVE    SPA-NYUGAIKBN       TO  ACCT-NYUGAIKBN
               MOVE    ORCSCHO-PTID        TO  ACCT-PTID
               MOVE    TBL-CHO-SRYKA (IDX) TO  ACCT-SRYKA
               MOVE    ORCSCHO-SRYYM       TO  ACCT-SRYYM
               MOVE    "24"                TO  ACCT-SRYKBN
               MOVE    TBL-CHO-ZAINUM(IDX) TO  ACCT-ZAINUM
      *
               MOVE    SRYACCT-REC         TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
                   PERFORM 930-SRYACCT-READ-SEC
               ELSE
                   INITIALIZE                  SRYACCT-REC
                   MOVE    1               TO  FLG-SRYACCT
               END-IF
               IF      FLG-SRYACCT          =   ZERO
      *            診療会計マスターを変更する
                   MOVE    TBL-CHO-DAY-AREA(IDX)   TO  ACCT-DAY-AREA
                   PERFORM 40051-DAY-UPD-SEC
      *
                   MOVE    SRYACCT-REC         TO  MCPDATA-REC
                   MOVE    "DBUPDATE"          TO  MCP-FUNC
                   MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                   IF      MCP-RC          NOT =   ZERO
                        DISPLAY "ORCSCHOZAI SRYACCT UPD ERR:" MCP-RC
                                ",KEY:" ACCT-KEY
                        MOVE    1               TO  ORCSCHO-ERRCD
                        GO  TO  4005-CHOU-UPDATE-EXT
                   END-IF
               ELSE
                   DISPLAY "ORCSCHOZAII SRYACCT READ ERR:" ACCT-KEY
               END-IF
      *
               MOVE    "DBCLOSE"           TO  MCP-FUNC
               MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           END-PERFORM
      *
      *    当月入院調剤料の剤がない時、作成する
           IF      FLG-TOU-NASI        =   1
               MOVE    1               TO  FLG-SYORI
               PERFORM 40052-CHOUZAI-INS-SEC
           END-IF
      *
           .
       4005-CHOU-UPDATE-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計マスター変更編集処理
      *****************************************************************
       40051-DAY-UPD-SEC           SECTION.
      *
           MOVE    ZERO                TO  ACCT-ZAIKAISU
           PERFORM VARYING     IDX-D   FROM    1   BY  1
                   UNTIL       IDX-D   >   31
              IF      ACCT-DAY (1 IDX-D)   >   ZERO
      *            剤回数　変更
                   COMPUTE ACCT-ZAIKAISU       =   ACCT-ZAIKAISU
                                               +   ACCT-DAY
                                                       (1  IDX-D)
               END-IF
           END-PERFORM
           .
       40051-DAY-UPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    麻毒更新処理
      *****************************************************************
       4006-MADO-UPDATE-SEC            SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   10  )  OR
                              (TBL-MAD-ZAINUM(IDX) =   ZERO )
               INITIALIZE                      SRYACCT-REC
               MOVE    SPA-HOSPID          TO  ACCT-HOSPID
               MOVE    SPA-NYUGAIKBN       TO  ACCT-NYUGAIKBN
               MOVE    ORCSCHO-PTID        TO  ACCT-PTID
               MOVE    TBL-MAD-SRYKA (IDX) TO  ACCT-SRYKA
               MOVE    ORCSCHO-SRYYM       TO  ACCT-SRYYM
               MOVE    "26"                TO  ACCT-SRYKBN
               MOVE    TBL-MAD-ZAINUM(IDX) TO  ACCT-ZAINUM
      *
               MOVE    SRYACCT-REC         TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
                   PERFORM 930-SRYACCT-READ-SEC
               ELSE
                   INITIALIZE                  SRYACCT-REC
                   MOVE    1               TO  FLG-SRYACCT
               END-IF
               IF      FLG-SRYACCT          =   ZERO
      *            診療会計マスターを変更する
                   MOVE    TBL-MAD-DAY-AREA(IDX)   TO  ACCT-DAY-AREA
                   PERFORM 40051-DAY-UPD-SEC
      *
                   MOVE    SRYACCT-REC         TO  MCPDATA-REC
                   MOVE    "DBUPDATE"          TO  MCP-FUNC
                   MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                   IF      MCP-RC          NOT =   ZERO
                        DISPLAY "ORCSCHOZAI SRYACCT UPD ERR:" MCP-RC
                                ",KEY:" ACCT-KEY
                        MOVE    3               TO  ORCSCHO-ERRCD
                        GO  TO  4006-MADO-UPDATE-EXT
                   END-IF
               ELSE
                   DISPLAY "ORCSCHOZAI SRYACCT READ ERR:" ACCT-KEY
               END-IF
      *
      *        MOVE    "DBCLOSE"           TO  MCP-FUNC
      *        MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
      *        CALL    "ORCMCPSUB"          USING
      *                                     MCPAREA
      *                                     ORCMCPAREA
      *                                     MCPDATA-REC
           END-PERFORM
      *
      *    当月入院調剤料の剤がない時、作成する
           IF      FLG-MAD-NASI        =   1
               MOVE    2               TO  FLG-SYORI
               PERFORM 40052-CHOUZAI-INS-SEC
           END-IF
      *
           .
       4006-MADO-UPDATE-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計作成処理
      *****************************************************************
       40052-CHOUZAI-INS-SEC         SECTION.
      *
      *
           .
       40052-CHOUZAI-INS-EXT.
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
           MOVE    ORCSCHO-SRYYM       TO  ORC-DBYMD(1:6)
           MOVE    WRK-DD              TO  ORC-DBYMD(7:2)
      *
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
      *    診療行為マスター読込
      *****************************************************************
       920-SRYACT-NEXT-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SRYACT-REC
               MOVE    ZERO                TO  FLG-SRYACT
           ELSE
               INITIALIZE                      SRYACT-REC
               MOVE    1                   TO  FLG-SRYACT
           END-IF
      *
           .
       920-SRYACT-NEXT-EXT.
           EXIT.
      *****************************************************************
      *    診療会計マスター読込
      *****************************************************************
       930-SRYACCT-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SRYACCT-REC
               MOVE    ZERO                TO  FLG-SRYACCT
           ELSE
               INITIALIZE                      SRYACCT-REC
               MOVE    1                   TO  FLG-SRYACCT
           END-IF
      *
           .
       930-SRYACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院診療会計マスター読込
      *****************************************************************
       930-NYUINACCT-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  NYUINACCT-REC
               MOVE    ZERO                TO  FLG-NYUINACCT
           ELSE
               INITIALIZE                      NYUINACCT-REC
               MOVE    1                   TO  FLG-NYUINACCT
           END-IF
      *
           .
       930-NYUINACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院履歴マスター読込
      *****************************************************************
       910-PTNYUINRRK-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
               MOVE    ZERO            TO  FLG-PTNYUINRRK
           ELSE
               INITIALIZE                  PTNYUINRRK-REC
               MOVE    1               TO  FLG-PTNYUINRRK
           END-IF
      *
           .
       910-PTNYUINRRK-READ-EXT.
           EXIT.
      *
