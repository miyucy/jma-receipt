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
       PROGRAM-ID.                 ORCSTENTEK.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院会計照会
      *  コンポーネント名  : 入院用点滴集計処理
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
           03  FLG-PTINF           PIC 9(01).
           03  FLG-SRYACT          PIC 9(01).
           03  FLG-SRYACCT         PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-JYURRK          PIC 9(01).
      *
           03  FLG-ZAIARI          PIC 9(01).
           03  FLG-SEIBUTU         PIC 9(01).
           03  FLG-SEIBUTU-OK      PIC 9(01).
           03  FLG-MADOKU          PIC 9(01).
           03  FLG-MADOKU-OK       PIC 9(01).
           03  FLG-CHU-ARI         PIC 9(01).
      *
           03  FLG-OK              PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDX3                PIC 9(04).
           03  IDY                 PIC 9(04).
      *
           03  IDX-T               PIC 9(04).
           03  IDX-H               PIC 9(04).
           03  IDX-D               PIC 9(02).
           03  IDY2                PIC 9(02).
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
      *
           03  WRK-TENSU           PIC 9(07)V9(03).
           03  WRK-SURYO           PIC 9(07)V9(03).
           03  WRK-EKIRYOU         PIC 9(07)V9(03).
      *
           03  WRK-SRYCD               PIC X(08).
           03  WRK-MAX-RYOU            PIC 9(07).
      *
           03  WRK-BYMD.
               05  WRK-BYY             PIC 9(04).
               05  WRK-BMM             PIC 9(02).
               05  WRK-BDD             PIC 9(02).
      *
      *    液量集計用
       01  TBL-AREA.
           03  TBL-AREA-OCC            OCCURS   50.
               05  TBL-SRYCD           PIC X(09).
               05  TBL-TEN             PIC 9(07)V99.
               05  TBL-CSYYOURYO       PIC 9(07)V99.
      *
               05  TBL-SEIBUTU         PIC 9(01).
               05  TBL-MADOKU          PIC 9(01).
               05  TBL-DAY-AREA        OCCURS   31.
                   07  TBL-DAY             PIC 9(01).
                   07  TBL-SURYO           PIC 9(05)V9(03).
                   07  TBL-CHUSYARYO       PIC 9(07)V9(03).
      *            保険組合せ
                   07  TBL-HKNCOMBI        PIC X(04).
                   07  TBL-SRYKA           PIC X(02).
      *
      *    手技料用
       01  TBL2-AREA.
           03  TBL2-AREA-OCC           OCCURS   50.
               05  TBL2-SRYCD           PIC X(09).
               05  TBL2-DATAKBN         PIC X(01).
               05  TBL2-SEIBUTU         PIC 9(01).
               05  TBL2-MADOKU          PIC 9(01).
               05  TBL2-DAY-AREA        OCCURS   31.
                   07  TBL2-DAY             PIC 9(01).
                   07  TBL2-ZAINUM          PIC 9(08).
      *            診療科
                   07  TBL2-SRYKA           PIC X(02).
      *            保険組合せ
                   07  TBL2-HKNCOMBI        PIC X(04).
      *
      *    変更テーブル
       01  TBL-HEN-AREA.
           03  TBL-HEN-OCC                 OCCURS  50.
               05  TBL-HEN-ZAINUM          PIC 9(08).
               05  TBL-HEN-SRYKA           PIC X(02).
               05  TBL-HEN-HKNCOMBI        PIC X(04).
      *        削除
               05  TBL-HEN-DEL             PIC 9(01)
                                           OCCURS  31.
      *    算定不可条件
       01  TBL-CHK-AREA.
      *    手術有無
           03  TBL-SYU-ARI         PIC 9(01)
                                       OCCURS   31.
      *    中心静脈有無
           03  TBL-CHU-ARI         PIC 9(01)
                                       OCCURS   31.
      *
      *    当日分
       01  TBL-SYUKEI-AREA.
           03  TBL-SYUKEI-OCC          OCCURS  31.
               05  TBL-S-SEIBUTU       PIC 9(01).
               05  TBL-S-MADOKU        PIC 9(01).
      *
      *    受診履歴
       01  TBL-JYURRK-AREA.
           02  TBL-JYURRK-REC         OCCURS  15.
           COPY    "CPJYURRK.INC"     REPLACING
                                     //JYURRK-// BY //TBL-JYURRK-//.
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
           COPY    "CPORCSTENTEK.INC".
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           ORCSTENTEKAREA
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
           INITIALIZE                  TBL-AREA
           INITIALIZE                  TBL2-AREA
           INITIALIZE                  TBL-HEN-AREA
           INITIALIZE                  TBL-CHK-AREA
      *
           INITIALIZE                  ORCSTEN-OUT-AREA
           INITIALIZE                  ORCSTEN-DAY-AREA
           INITIALIZE                  ORCSTEN-ERRCD
           MOVE    ZERO                TO  ORCSTEN-HENFLG
      *
      *    診療行為編集処理
           PERFORM 100-HENSYU-SYORI-SEC
      *    点数計算処理
           PERFORM 200-KEISAN-SYORI-SEC
      *
           IF      ORCSTEN-KBN         =   "1"  OR  "3"
      *        手技料一括変更処理
               PERFORM 300-KOUSIN-SYORI-SEC
           END-IF
      *
           .
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    診療行為編集処理
      *****************************************************************
       100-HENSYU-SYORI-SEC            SECTION.
      *
      *    診療年月の診療会計マスタ読み込み
           MOVE    SPACE               TO  SRYACCT-REC
           INITIALIZE                      SRYACCT-REC
           MOVE    SPA-HOSPID          TO  ACCT-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  ACCT-NYUGAIKBN
           MOVE    ORCSTEN-PTID        TO  ACCT-PTID
           MOVE    ORCSTEN-SRYYM       TO  ACCT-SRYYM
           MOVE    "33"                TO  ACCT-SRYKBN
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
               IF      ACCT-ZAIKAISU       =   ZERO
                   MOVE    ZERO                TO  FLG-ZAIARI
               ELSE
                   MOVE    1                   TO  FLG-ZAIARI
               END-IF
               MOVE    ZERO                TO  WRK-DD
      *        最初の日を保存
               PERFORM VARYING     IDY2    FROM    1   BY  1
                       UNTIL       IDY2    >   31
                   IF      ACCT-DAY (1 IDY2)   >   ZERO
                       MOVE    IDY2                TO  WRK-DD
                       MOVE    1                   TO  FLG-ZAIARI
                   END-IF
               END-PERFORM
      *        保険チェック
               IF     (ORCSTEN-KBN         =   "2"    )  AND
                      (ACCT-HKNCOMBI   NOT =   ORCSTEN-HKNCOMBI)
                   MOVE    ZERO                TO  FLG-ZAIARI
               END-IF
      *
      *        回数があるもの
               IF      FLG-ZAIARI          =   1
      *            診療行為より液量集計
                   PERFORM 1001-SRYACT-HEN-SEC
               END-IF
      *
               MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
               PERFORM 930-SRYACCT-READ-SEC
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SRYACCT-KEY14"     TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
           .
       100-HENSYU-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    診療行為マスター編集処理
      *****************************************************************
       1001-SRYACT-HEN-SEC            SECTION.
      *
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
                       UNTIL      (IDX2        >   5   )  OR
                                  (SRY-SRYCD(IDX2)     =   SPACE )
      *            薬剤
                   IF     (SRY-SRYCD (IDX2)(1:1)   =   "6" )  AND
                          (SRY-SRYSYUKBN           =   "330"  OR
                                                       "331")
                       PERFORM 10012-TBL-HENSYU-SEC
                   END-IF
      *            手技料
                   IF     (SRY-SRYCD (IDX2)(1:1)   =   "1" )  AND
                          (SRY-SRYSYUKBN           =   "330" )
                       PERFORM 10013-SYUG-HENSYU-SEC
                   END-IF
      *            手技料（中心静脈）
                   IF      SRY-SRYCD (IDX2)        =   "130004410"
                       PERFORM 10014-CHU-HENSYU-SEC
                   END-IF
               END-PERFORM
      *
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               PERFORM 920-SRYACT-NEXT-SEC
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *                                MCPDATA-REC
           .
       100-HENSYU-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル編集処理
      *****************************************************************
       10012-TBL-HENSYU-SEC            SECTION.
      *
      *    同一コードチェック
           PERFORM VARYING IDX-T       FROM    1   BY  1
                   UNTIL   IDX-T       >   50
               IF      SRY-SRYCD (IDX2)    =   TBL-SRYCD (IDX-T)
                   PERFORM 100121-DAY-HEN-SEC
                   MOVE    50              TO  IDX-T
               ELSE
                   IF      TBL-SRYCD (IDX-T)   =   SPACE
                       MOVE    SRY-SRYCD (IDX2)    TO  TBL-SRYCD (IDX-T)
      *                点数マスタ
                       MOVE    SRY-SRYCD (IDX2)    TO  TNS-SRYCD
                       PERFORM 910-TENSU-READ-SEC
                       IF      FLG-TENSU           =   ZERO
      *                    点数
                           MOVE    TNS-TEN         TO  TBL-TEN   (IDX-T)
      *                    液量
                           IF      TNS-CSYYOURYO   =   ZERO
                               MOVE    1               TO  TBL-CSYYOURYO
                                                                 (IDX-T)
                           ELSE
                               MOVE    TNS-CSYYOURYO   TO  TBL-CSYYOURYO
                                                                 (IDX-T)
                           END-IF
      *                    生物学的製剤区分
                           MOVE    TNS-SEIBUTUGAKUKBN  TO  TBL-SEIBUTU
                                                               (IDX-T)
      *                    麻毒
                           MOVE    TNS-MADOKUKBN       TO  TBL-MADOKU
                                                               (IDX-T)
      *
                           PERFORM 100121-DAY-HEN-SEC
                       END-IF
                       MOVE    50              TO  IDX-T
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       10012-TBL-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル編集処理
      *****************************************************************
       100121-DAY-HEN-SEC            SECTION.
      *
           PERFORM VARYING     IDX-D   FROM    1   BY  1
                   UNTIL       IDX-D   >   31
               IF      ACCT-DAY (1 IDX-D)  >   ZERO
                   ADD     ACCT-DAY (1 IDX-D)  TO  TBL-DAY (IDX-T IDX-D)
      *            数量
                   COMPUTE WRK-SURYO            =   SRY-SRYSURYO(IDX2)
                                                *   ACCT-DAY (1 IDX-D)
                   ADD     WRK-SURYO            TO  TBL-SURYO
                                                      (IDX-T IDX-D)
      *            液量
                   COMPUTE WRK-EKIRYOU     =   TBL-CSYYOURYO (IDX-T)
                                           *   WRK-SURYO
                   ADD     WRK-EKIRYOU     TO  TBL-CHUSYARYO
                                                      (IDX-T IDX-D)
      *            診療科・保険
      *        １つの薬剤は１日に同じ科・保険でのみ使用するものとする
                   MOVE    ACCT-SRYKA          TO  TBL-SRYKA
                                                      (IDX-T IDX-D)
                   MOVE    ACCT-HKNCOMBI       TO  TBL-HKNCOMBI
                                                      (IDX-T IDX-D)
               END-IF
      *TEST
               IF    ACCT-DAY (1 IDX-D) >  ZERO
                   DISPLAY "TBL-SRYCD:" TBL-SRYCD (IDX-T)
                        ",CSYYOURYO:" TBL-CSYYOURYO (IDX-T)
                        ",CHUSYARYO:" TBL-CHUSYARYO  (IDX-T IDX-D)
                       ",IDX-D:" IDX-D
                       ",ACCT-ZAINUM:" ACCT-ZAINUM
               END-IF
      *TEST
           END-PERFORM
      *
           .
       100121-DAY-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    手技料（中心静脈）編集処理
      *****************************************************************
       10014-CHU-HENSYU-SEC            SECTION.
      *
      *
           PERFORM VARYING     IDX-D   FROM    1   BY  1
                   UNTIL       IDX-D   >   31
               IF      ACCT-DAY (1 IDX-D)  >   ZERO
                   MOVE    1               TO  TBL-CHU-ARI (IDX-D)
               END-IF
           END-PERFORM
      *
           .
       10014-CHU-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    手技料編集処理
      *****************************************************************
       10013-SYUG-HENSYU-SEC            SECTION.
      *
      *    同一コードチェック
           PERFORM VARYING IDX-T       FROM    1   BY  1
                   UNTIL   IDX-T       >   50
               IF      SRY-SRYCD (IDX2)    =   TBL2-SRYCD (IDX-T)
                   PERFORM 100131-SYU-DAY-HEN-SEC
                   MOVE    50              TO  IDX-T
               ELSE
                   IF      TBL2-SRYCD (IDX-T)  =   SPACE
                       MOVE    SRY-SRYCD (IDX2)    TO  TBL2-SRYCD(IDX-T)
      *                点数マスタ
                       MOVE    SRY-SRYCD (IDX2)    TO  TNS-SRYCD
                       PERFORM 910-TENSU-READ-SEC
                       IF      FLG-TENSU           =   ZERO
      *                    区分
                           MOVE    TNS-DATAKBN     TO  TBL2-DATAKBN
                                                             (IDX-T)
                       END-IF
      *                生物学的製剤区分
                       IF      SRY-SRYCD (IDX2)    =   "130000110"
                           MOVE    1               TO  TBL2-SEIBUTU
                                                                (IDX-T)
                       END-IF
      *                麻毒
                       IF      SRY-SRYCD (IDX2)    =   "130000310"
                           MOVE    1               TO  TBL2-MADOKU
                                                               (IDX-T)
                       END-IF
      *
                       PERFORM 100131-SYU-DAY-HEN-SEC
                       MOVE    50              TO  IDX-T
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       10013-SYUG-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル編集処理
      *****************************************************************
       100131-SYU-DAY-HEN-SEC            SECTION.
      *
           PERFORM VARYING     IDX-D   FROM    1   BY  1
                   UNTIL       IDX-D   >   31
               ADD     ACCT-DAY (1 IDX-D)  TO  TBL2-DAY (IDX-T IDX-D)
      *        診療科・保険
               IF      ACCT-DAY (1 IDX-D)  >   ZERO
                   IF      TBL2-SRYKA (IDX-T IDX-D)    =   SPACE
                       MOVE    ACCT-SRYKA          TO  TBL2-SRYKA
                                                      (IDX-T IDX-D)
                       MOVE    ACCT-HKNCOMBI       TO  TBL2-HKNCOMBI
                                                      (IDX-T IDX-D)
                       MOVE    ACCT-ZAINUM         TO  TBL2-ZAINUM
                                                      (IDX-T IDX-D)
                   ELSE
      *                同じ診療コードは１日に１回のみとする
                       PERFORM 1001311-SYU-ERR-SEC
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       100131-SYU-DAY-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    同日複数算定エラー処理
      *****************************************************************
       1001311-SYU-ERR-SEC            SECTION.
      *
           MOVE    1                   TO  ORCSTEN-FUKU-DAY (IDX-D)
           .
       1001311-SYU-ERR-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数計算処理
      *****************************************************************
       200-KEISAN-SYORI-SEC            SECTION.
      *
           INITIALIZE                  TBL-SYUKEI-AREA
      *
           PERFORM VARYING     IDX-D   FROM    1   BY  1
                   UNTIL       IDX-D   >   31
               MOVE    ZERO            TO  IDX
               PERFORM VARYING     IDX-T   FROM    1   BY  1
                       UNTIL      (IDX-T   >   50  )  OR
                                  (TBL-SRYCD (IDX-T)   =   SPACE)
                   IF      TBL-DAY (IDX-T IDX-D)   >   ZERO
                       ADD     1               TO  IDX
                       IF      IDX             <=  50
                           PERFORM 2001-TBL-HENSYU-SEC
                       END-IF
                   END-IF
               END-PERFORM
           END-PERFORM
      *
           .
       200-KEISAN-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数編集処理
      *****************************************************************
       2001-TBL-HENSYU-SEC            SECTION.
      *
           MOVE    TBL-SRYCD (IDX-T)   TO  ORCSTEN-SRYCD (IDX IDX-D)
           MOVE    TBL-SURYO (IDX-T IDX-D)
                                       TO  ORCSTEN-SURYO (IDX IDX-D)
      *
           COMPUTE WRK-TENSU           =   TBL-TEN  (IDX-T)
                                       *   TBL-SURYO (IDX-T IDX-D)
           ADD     WRK-TENSU           TO  ORCSTEN-ZAITEN (IDX-D)
      *    液量
           ADD     TBL-CHUSYARYO (IDX-T IDX-D)
                                       TO  ORCSTEN-CHUSYARYO (IDX-D)
      *
      *   生物学的製剤区分
           IF      TBL-SEIBUTU (IDX-T) =   1
               MOVE    1               TO  TBL-S-SEIBUTU (IDX-D)
           END-IF
      *    麻毒
           IF      TBL-MADOKU (IDX-T)  =   1
               MOVE    1               TO  TBL-S-MADOKU (IDX-D)
           END-IF
      *
           .
       200-KEISAN-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    手技料一括変更処理
      *****************************************************************
       300-KOUSIN-SYORI-SEC         SECTION.
      *
      *    患者マスター存在チェック
           MOVE    SPA-HOSPID          TO  PTINF-HOSPID
           MOVE    ORCSTEN-PTID        TO  PTINF-PTID
           PERFORM 940-PTINF-READ-SEC
           IF      FLG-PTINF      NOT =   ZERO
               MOVE    9                   TO  ORCSTEN-ERRCD
               GO      TO      300-KOUSIN-SYORI-EXT
           END-IF
      *    年齢計算
      *    ６歳到達日
           MOVE    PTINF-BIRTHDAY      TO  WRK-BYMD
           COMPUTE WRK-BYY             =   WRK-BYY
                                       +   6
      *
      *    すべての手術の有無を判定
           PERFORM 3001-SYUJYU-HEN-SEC
      *    今回分液量集計編集
           PERFORM VARYING    IDX-D    FROM    1   BY  1
                   UNTIL      IDX-D    >   31
      *        最大液量と対象診療コード
               PERFORM 3004-TENSRYCD-HEN-SEC
      *TEST
               DISPLAY IDX-D
                      "ORCSTEN-CHUSYARYO:" ORCSTEN-CHUSYARYO(IDX-D)
                     ",WRK-MAX-RYOU:" WRK-MAX-RYOU
                     ",SYU-ARI:" TBL-SYU-ARI       (IDX-D)
      *TEST
      *        液量が対象で手術なしの時
               IF     (ORCSTEN-CHUSYARYO (IDX-D) >=  WRK-MAX-RYOU) AND
                      (TBL-SYU-ARI       (IDX-D) =   ZERO        )
      *            手技料あり
                   PERFORM 49004-SYUGI-ARI-SEC
               ELSE
      *            手技料なし
                   MOVE    ZERO            TO  FLG-CHU-ARI
                   PERFORM 49005-SYUGI-NASI-SEC
               END-IF
           END-PERFORM
      *
      *    一括変更の時
           IF      ORCSTEN-KBN         =   "1"
      *        マスタ更新
               PERFORM 49006-SRYACCT-UPDATE-SEC
           END-IF
      *
           .
       300-KOUSIN-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    手術編集処理
      *****************************************************************
       3001-SYUJYU-HEN-SEC           SECTION.
      *
      *    診療年月の診療会計マスタ読み込み
           MOVE    SPACE               TO  SRYACCT-REC
           INITIALIZE                      SRYACCT-REC
           MOVE    SPA-HOSPID          TO  ACCT-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  ACCT-NYUGAIKBN
           MOVE    ORCSTEN-PTID        TO  ACCT-PTID
           MOVE    ORCSTEN-SRYYM       TO  ACCT-SRYYM
           MOVE    "50"                TO  ACCT-SRYKBN
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
           PERFORM UNTIL       (FLG-SRYACCT         =   1       )
      *        手技料があるもの
               IF      ACCT-SYUTEN1        >   ZERO
                   PERFORM VARYING     IDX2    FROM    1   BY  1
                           UNTIL       IDX2    >   31
      *                手術有
                       IF      ACCT-DAY (1 IDX2)   >   ZERO
                           ADD     ACCT-DAY (1 IDX2)   TO  TBL-SYU-ARI
                                                                 (IDX2)
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
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
           .
       3001-SYUJYU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    点滴手技料と対象液量編集処理
      *****************************************************************
       3004-TENSRYCD-HEN-SEC           SECTION.
      *
           EVALUATE    TRUE
      *        ６歳未満
               WHEN    WRK-BYMD(1:6)       >   ORCSTEN-SRYYM
                   MOVE    "130003710"     TO  WRK-SRYCD
                   MOVE    100             TO  WRK-MAX-RYOU
      *        ６歳
               WHEN    WRK-BYMD(1:6)       =   ORCSTEN-SRYYM
                   IF      WRK-BDD         <=  IDX-D
                       MOVE    "130003810"     TO  WRK-SRYCD
                       MOVE    500             TO  WRK-MAX-RYOU
                   ELSE
                       MOVE    "130003710"     TO  WRK-SRYCD
                       MOVE    100             TO  WRK-MAX-RYOU
                   END-IF
      *        ６歳以上
               WHEN    WRK-BYMD(1:6)       <   ORCSTEN-SRYYM
                   MOVE    "130003810"     TO  WRK-SRYCD
                   MOVE    500             TO  WRK-MAX-RYOU
           END-EVALUATE
      *
           .
       3004-TENSRYCD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    手技料あり編集処理
      *****************************************************************
       49004-SYUGI-ARI-SEC             SECTION.
      *
      *    中心静脈あり
           IF      TBL-CHU-ARI (IDX-D) =   1
               MOVE    1               TO  FLG-CHU-ARI
      *        他の点滴手技料を削除する
               PERFORM 49005-SYUGI-NASI-SEC
               GO      TO      49004-SYUGI-ARI-EXT
           END-IF
      *
      *    対象の剤判定
           MOVE    ZERO                TO  FLG-OK
           MOVE    ZERO                TO  FLG-SEIBUTU-OK
           MOVE    ZERO                TO  FLG-MADOKU-OK
           PERFORM VARYING    IDY      FROM    1   BY  1
                   UNTIL      IDY      >   50
      *        手技料
               IF     (TBL2-DAY (IDY IDX-D)    >   ZERO )  AND
                      (TBL2-DATAKBN (IDY)      =   "1"  )  AND
                      (TBL2-SEIBUTU (IDY)      =   ZERO )  AND
                      (TBL2-MADOKU  (IDY)      =   ZERO )
                   MOVE    1                   TO  FLG-OK
               END-IF
      *        加算
               IF     (TBL2-DAY (IDY IDX-D)    >   ZERO )  AND
                      (TBL2-SEIBUTU (IDY)      =   1    )  AND
                      (TBL-S-SEIBUTU (IDX-D)   =   1    )
                   MOVE    1                   TO  FLG-SEIBUTU-OK
               END-IF
               IF     (TBL2-DAY (IDY IDX-D)    >   ZERO )  AND
                      (TBL2-MADOKU (IDY)       =   1    )  AND
                      (TBL-S-MADOKU (IDX-D)    =   1    )
                   MOVE    1                   TO  FLG-MADOKU-OK
               END-IF
           END-PERFORM
      *
      *    手技料未算定
           IF      FLG-OK              =   ZERO
               MOVE    1               TO  ORCSTEN-MI-DAY (IDX-D)
               GO      TO      49004-SYUGI-ARI-EXT
           END-IF
      *    生物学的
           IF      TBL-S-SEIBUTU (IDX-D)   =   1
               IF      FLG-SEIBUTU-OK      =   ZERO
                   MOVE    2               TO  ORCSTEN-MI-DAY (IDX-D)
                   GO      TO      49004-SYUGI-ARI-EXT
               END-IF
           END-IF
      *    麻毒
           IF      TBL-S-MADOKU (IDX-D)    =   1
               IF      FLG-MADOKU-OK       =   ZERO
                   MOVE    2               TO  ORCSTEN-MI-DAY (IDX-D)
                   GO      TO      49004-SYUGI-ARI-EXT
               END-IF
           END-IF
      *
           .
       49004-SYUGI-ARI-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    手技料なし編集処理
      *****************************************************************
       49005-SYUGI-NASI-SEC            SECTION.
      *
      *    対象の剤判定
           PERFORM VARYING    IDY      FROM    1   BY  1
                   UNTIL     (IDY      >   50 )  OR
                             (TBL2-SRYCD(IDY)  =   SPACE)
               MOVE    ZERO                TO  FLG-OK
               IF      TBL2-DAY (IDY IDX-D)    >   ZERO
      *            当日の中心静脈点滴あり
                   IF      FLG-CHU-ARI         =   1
                       IF     (TBL-S-SEIBUTU (IDX-D)   =   1  )  AND
                              (TBL2-SEIBUTU  (IDY)     =   1  )
                           MOVE    1               TO  FLG-OK
                       END-IF
                       IF     (TBL-S-MADOKU (IDX-D)    =   1  )  AND
                              (TBL2-MADOKU  (IDY)      =   1  )
                           MOVE    1               TO  FLG-OK
                       END-IF
                   END-IF
                   IF      FLG-OK              =   ZERO
      *                当日削除
                       PERFORM 490051-SYUGI-DEL-SEC
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       49005-SYUGI-NASI-EXT.
           EXIT.
      *
      *****************************************************************
      *    手技料削除編集処理
      *****************************************************************
       490051-SYUGI-DEL-SEC           SECTION.
      *
           PERFORM VARYING     IDX-H   FROM    1   BY  1
                   UNTIL       IDX-H   >   50
               IF      TBL-HEN-ZAINUM (IDX-H)  =   ZERO
                   MOVE    TBL2-ZAINUM (IDY IDX-D)
                                           TO  TBL-HEN-ZAINUM(IDX-H)
                   MOVE    TBL2-SRYKA  (IDY IDX-D)
                                           TO  TBL-HEN-SRYKA (IDX-H)
                   MOVE    TBL2-HKNCOMBI(IDY IDX-D)
                                           TO  TBL-HEN-HKNCOMBI
                                                             (IDX-H)
      *TEST
                 DISPLAY "TBL-HEN-ZAINUM:" TBL-HEN-ZAINUM(IDX-H)
      *TEST
               END-IF
      *        削除
               IF      TBL-HEN-ZAINUM (IDX-H)  =   TBL2-ZAINUM
                                                           (IDY IDX-D)
                   MOVE    1               TO  TBL-HEN-DEL (IDX-H IDX-D)
      *            変更あり
                   MOVE    1                   TO  ORCSTEN-HENFLG
      *
                   MOVE    50              TO  IDX-H
               END-IF
           END-PERFORM
      *
           .
       490051-SYUGI-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計更新処理
      *****************************************************************
       49006-SRYACCT-UPDATE-SEC           SECTION.
      *
           PERFORM VARYING    IDY      FROM    1   BY  1
                   UNTIL     (IDY      >   50 )  OR
                             (TBL-HEN-ZAINUM (IDY) =   ZERO)
               INITIALIZE                      SRYACCT-REC
               MOVE    SPA-HOSPID          TO  ACCT-HOSPID
               MOVE    SPA-NYUGAIKBN       TO  ACCT-NYUGAIKBN
               MOVE    ORCSTEN-PTID        TO  ACCT-PTID
               MOVE    TBL-HEN-SRYKA (IDY) TO  ACCT-SRYKA
               MOVE    ORCSTEN-SRYYM       TO  ACCT-SRYYM
               MOVE    "33"                TO  ACCT-SRYKBN
               MOVE    TBL-HEN-ZAINUM(IDY) TO  ACCT-ZAINUM
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
                   PERFORM 490061-DAY-DEL-SEC
      *
                   MOVE    SRYACCT-REC         TO  MCPDATA-REC
                   MOVE    "DBUPDATE"          TO  MCP-FUNC
                   MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                   IF      MCP-RC          NOT =   ZERO
                        DISPLAY "ORCSTENTEKI SRYACCT UPD ERR:" MCP-RC
                                ",KEY:" ACCT-KEY
                        MOVE    1               TO  ORCSTEN-ERRCD
                        GO  TO  49006-SRYACCT-UPDATE-EXT
                   END-IF
               ELSE
                   DISPLAY "ORCSTENTEKI SRYACCT READ ERR:" ACCT-KEY
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
           .
       49006-SRYACCT-UPDATE-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計マスター変更編集処理
      *****************************************************************
       490061-DAY-DEL-SEC           SECTION.
      *
           PERFORM VARYING     IDX-D   FROM    1   BY  1
                   UNTIL       IDX-D   >   31
              IF      TBL-HEN-DEL (IDY IDX-D) =   1
      *            剤回数　変更
                   COMPUTE ACCT-ZAIKAISU       =   ACCT-ZAIKAISU
                                               -   ACCT-DAY
                                                       (1  IDX-D)
                   MOVE    ZERO                TO  ACCT-DAY (1 IDX-D)
                   MOVE    ZERO                TO  ACCT-DAY (2 IDX-D)
                   MOVE    ZERO                TO  ACCT-DAY (3 IDX-D)
                   MOVE    ZERO                TO  ACCT-DAY (4 IDX-D)
      *            受診履歴変更
                   PERFORM 490062-JYURRK-HEN-SEC
              END-IF
           END-PERFORM
           .
       490061-DAY-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴変更処理
      *****************************************************************
       490062-JYURRK-HEN-SEC           SECTION.
      *
      *    受診歴を検索する  医療機関、患者ＩＤ、伝票番号
           INITIALIZE                  JYURRK-REC
           MOVE    ACCT-HOSPID         TO  JYURRK-HOSPID
           MOVE    ACCT-PTID           TO  JYURRK-PTID
           MOVE    ACCT-NYUGAIKBN      TO  JYURRK-NYUGAIKBN
           MOVE    ACCT-SRYKA          TO  JYURRK-SRYKA 
           MOVE    ACCT-SRYYM          TO  JYURRK-SRYYMD(1:6)
           MOVE    IDX-D               TO  JYURRK-SRYYMD(7:2)
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "JYURRK-KEY4"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "JYURRK-KEY4"       TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *TEST
           DISPLAY "FLG-JYURRK:" FLG-JYURRK
      *TEST
      *
           INITIALIZE                  TBL-JYURRK-AREA
           MOVE    ZERO                TO  IDX-H
           PERFORM UNTIL  (FLG-JYURRK         =   1  )  OR
                          (IDX-H              >   15 )
               ADD     1                   TO  IDX-H
               MOVE    JYURRK-REC          TO  TBL-JYURRK-REC (IDX-H)
      *TEST
              DISPLAY "JYURRK-SRYKA:" JYURRK-SRYKA
                      ",RENNUM" JYURRK-RENNUM
                      ",DOUJI:"  JYURRK-DOUJI-RENNUM
      *TEST
      *
               MOVE    "JYURRK-KEY4"       TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           END-PERFORM
      *
           PERFORM VARYING IDX         FROM    1   BY  1
                   UNTIL   IDX         >   IDX-H
               PERFORM VARYING IDX2        FROM    1   BY  1
                       UNTIL   IDX2        >   15
                   IF      TBL-JYURRK-ZAINUM(IDX IDX2)
                                           =   TBL-HEN-ZAINUM(IDY)
                       MOVE    ZERO        TO  TBL-JYURRK-ZAINUM
                                                           (IDX IDX2)
                   END-IF
                   IF      TBL-JYURRK-ZAINUM(IDX IDX2) =   ZERO
                       IF       IDX2           <   15
                           COMPUTE IDX3        =   IDX2    +   1
                           MOVE    TBL-JYURRK-ZAINUM(IDX IDX3)
                                               TO  TBL-JYURRK-ZAINUM
                                                          (IDX IDX2)
                           MOVE    ZERO        TO  TBL-JYURRK-ZAINUM
                                                          (IDX IDX3)
                       ELSE
                           IF      IDX         <   IDX-H
                               COMPUTE IDX3        =   IDX-H   +   1
                               MOVE    TBL-JYURRK-ZAINUM(IDX3 1)
                                                   TO  TBL-JYURRK-ZAINUM
                                                          (IDX IDX2)
                               MOVE    ZERO        TO  TBL-JYURRK-ZAINUM
                                                          (IDX3 1)
                           END-IF
                       END-IF
                   END-IF
               END-PERFORM
           END-PERFORM
      *    ＤＢ更新
           PERFORM VARYING IDX         FROM    1   BY  1
                   UNTIL   IDX         >   IDX-H
               MOVE    TBL-JYURRK-REC (IDX-H)  TO  JYURRK-REC
      *
               MOVE    JYURRK-REC          TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "JYURRK-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *!        IF      MCP-RC          NOT =   ZERO
                    DISPLAY "ORCSTENTEKI JYURRK  UPD ERR:" MCP-RC
                            ",KEY:" JYURRK-KEY
      *!             MOVE    2               TO  ORCSTEN-ERRCD
      *!        END-IF
           END-PERFORM
      *
           .
       490062-JYURRK-HEN-EXT.
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
           MOVE    ORCSTEN-SRYYM       TO  ORC-DBYMD(1:6)
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
      *    患者マスター読込
      *****************************************************************
       940-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTINF-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC        TO  PTINF-REC
                   MOVE    ZERO               TO  FLG-PTINF
               ELSE
                   MOVE    1                  TO  FLG-PTINF
               END-IF
           ELSE
               MOVE    1              TO  FLG-PTINF
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       940-PTINF-READ-EXT.
           EXIT.
      *****************************************************************
      *    受診履歴マスター読込
      *****************************************************************
       970-JYURRK-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  JYURRK-REC
               MOVE    ZERO            TO  FLG-JYURRK
           ELSE
      *********INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           .
       970-JYURRK-READ-EXT.
           EXIT.
      *
      *
