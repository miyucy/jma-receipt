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
       PROGRAM-ID.                 ORCSROUNYUIN.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院
      *  コンポーネント名  : 労災入院会計作成サブ
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/07/11    NACL−小豆沢  新規作成
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
       DATA                        DIVISION.
      *FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-NYUINACCT       PIC 9(01).
           03  FLG-NYUINACT        PIC 9(01).
           03  FLG-SRYACCT         PIC 9(01).
           03  FLG-SRYACT          PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01).
           03  FLG-RJN             PIC 9(01).
           03  FLG-ROUSAI          PIC 9(01).
      *
           03  FLG-OK              PIC 9(01).
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX2                PIC 9(04).
           03  KSN-IDX             PIC 9(04).
           03  GENSAN-IDX          PIC 9(04).
      *
      *    コンスタント値
       01  CONSTANT-AREA.
      *    入院診療計画未実施減算
           03  CONS-KEIKAKU-GENSAN1        PIC X(09) VALUE "190080470".
           03  CONS-KEIKAKU-GENSAN2        PIC X(09) VALUE "190799670".
      *    日常生活障害加算
           03  CONS-NICHIJOU-KSN1          PIC X(09) VALUE "190109170".
           03  CONS-NICHIJOU-KSN2          PIC X(09) VALUE "190807570".
      *    痴呆加算
           03  CONS-CHIHOU-KSN1            PIC X(09) VALUE "190109270".
           03  CONS-CHIHOU-KSN2            PIC X(09) VALUE "190808670".
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-STYMD.
               05  WRK-STYYMM.
                   07  WRK-STYY            PIC 9(04).
                   07  WRK-STMM            PIC 9(02).
               05  WRK-STDD                PIC 9(02).
           03  WRK-EDYMD.
               05  WRK-EDYYMM.
                   07  WRK-EDYY            PIC 9(04).
                   07  WRK-EDMM            PIC 9(02).
               05  WRK-EDDD                PIC 9(02).
      *
           03  WRK-RRK-YMD                 PIC X(08).
           03  WRK-YMD                     PIC X(08).
           03  WRK-YMDR        REDEFINES   WRK-YMD.
               05  WRK-YY                  PIC 9(04).
               05  WRK-MM                  PIC 9(02).
               05  WRK-DD                  PIC 9(02).
      *
           03  WRK-GAIHAKU-SRYCD           PIC X(09).
           03  WRK-CNT                     PIC 9(03).
           03  WRK-MEISAISU                PIC 9(03).
      *
      *    労災入院会計ワーク
           03  WRK-ROUSAI-TABLE.
               05  WRK-ROUSAI-TBL          OCCURS  31.
                   07  WRK-NYUINKHN        PIC X(09).
                   07  WRK-SHOKIKSN        PIC X(09).
                   07  WRK-GAIHAKU         PIC X(09).
                   07  WRK-NYUKHNKSNKBN    PIC 9(03).
      *
      *    入院料加算退避領域
           03  WRK-NYUKSN-AREA             OCCURS 20.
               05  WRK-NYUKSN              PIC X(09).
               05  WRK-NYUKSN-DAY          PIC 9(01)  OCCURS 31.
      *
      *    院内感染防止対策未実施減算ワーク
           03  WRK-GENSAN2                 PIC X(09).
      *    医療安全管理体制未整備減算ワーク
           03  WRK-GENSAN3                 PIC X(09).
      *    褥瘡対策未実施減算ワーク
           03  WRK-GENSAN4                 PIC X(09).
      *
      *    入院診療計画未実施減算ワーク
           03  WRK-KEIKAKU-GENSAN1         PIC 9(01) OCCURS 31.
           03  WRK-KEIKAKU-GENSAN2         PIC 9(01) OCCURS 31.
      *
      *    日常生活障害加算退避
           03  WRK-NICHIJOU-KSN1           PIC 9(01) OCCURS 31.
           03  WRK-NICHIJOU-KSN2           PIC 9(01) OCCURS 31.
      *
      *    痴呆加算退避
           03  WRK-CHIHOU-KSN1             PIC 9(01) OCCURS 31.
           03  WRK-CHIHOU-KSN2             PIC 9(09) OCCURS 31.
      *
      *    診療コード計集計用
           03  WRK-SRYCD-X                 PIC X(09).
           03  WRK-SRYCD-9    REDEFINES    WRK-SRYCD-X
                                           PIC 9(09).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1001.INC".
      *
           COPY    "CPSK5000.INC".
      *
      *    入院診療会計マスタ−
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    入院診療行為マスター
       01  NYUINACT-REC.
           COPY    "CPNYUINACT.INC".
      *
      *    点数マスタ−
           COPY    "CPTENSU.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "MCPAREA".
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    保険算定用年齢・割合計算サブ
           COPY    "CPORCSAGECHK.INC".
      *
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    労災入院会計作成用パラメタ
           COPY    "CPORCSROUNYUIN.INC".
      *    スパ領域
           COPY    "COMMON-SPA".
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           ORCSROUNYUIN-AREA
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
           INITIALIZE                  LNK-SROUNYUIN-HENKYAKU-AREA
           MOVE    ZERO                TO  LNK-SROUNYUIN-RC
      *
      *    パラメータチェック
           PERFORM 100-PRM-CHK-SEC
           IF    ( LNK-SROUNYUIN-RC       NOT =   ZERO )
               GO  TO  000-PROC-EXT
           END-IF
      *
      *    主処理
           IF      LNK-SROUNYUIN-RC      =    ZERO
               PERFORM 200-MAIN-SEC
           END-IF
      *
           .
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
     *
      *****************************************************************
      *    パラメータチェック
      *****************************************************************
       100-PRM-CHK-SEC                     SECTION.
      *
           IF    ( LNK-SROUNYUIN-SANTEIYM    =   SPACE )
               MOVE    1               TO  LNK-SROUNYUIN-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *    患者マスター検索
           INITIALIZE                      PTINF-REC
           MOVE    LNK-SROUNYUIN-HOSPID    TO  PTINF-HOSPID
           MOVE    LNK-SROUNYUIN-PTID      TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           IF      FLG-PTINF           NOT =   ZERO
               MOVE    2               TO  LNK-SROUNYUIN-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *    労災入院中のチェック（入院会計マスター検索）
           INITIALIZE                      NYUINACCT-REC
           MOVE    LNK-SROUNYUIN-HOSPID    TO  NACCT-HOSPID
           MOVE    LNK-SROUNYUIN-PTID      TO  NACCT-PTID
           MOVE    LNK-SROUNYUIN-SANTEIYM  TO  NACCT-SRYYM
           MOVE    "5"                     TO  NACCT-ZAISKBKBN
           MOVE    "NYUINACCT-KEY17"       TO  ORC-DBPATH
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           NOT =   ZERO
               MOVE    3               TO  LNK-SROUNYUIN-RC
               GO  TO  100-PRM-CHK-EXT
           ELSE
               MOVE    "NYUINACCT-KEY17"   TO  ORC-DBPATH
               PERFORM 910-NYUINACCT-READ-SEC
               IF   FLG-NYUINACCT          NOT =   ZERO
                    MOVE    3               TO  LNK-SROUNYUIN-RC
                    GO  TO  100-PRM-CHK-EXT
               ELSE
      *            労災保険の判定
                   MOVE      ZERO              TO  FLG-ROUSAI
                   PERFORM   VARYING   IDX   FROM  1   BY  1
                             UNTIL    IDX   >   31
                        IF   LNK-SROUNYUIN-HKNCOMBI  =
                                               NACCT-DAY(IDX)
                             MOVE    1         TO  FLG-ROUSAI
                             MOVE   "1"        TO  
                                          LNK-SROUNYUIN-NYUIN-FLG(IDX)
                        END-IF
                   END-PERFORM
                   IF   FLG-ROUSAI             =   ZERO
                        MOVE    3              TO  LNK-SROUNYUIN-RC
                   END-IF
               END-IF
           END-IF
      *
      *    入院会計クローズ
           MOVE    "NYUINACCT-KEY17"           TO  ORC-DBPATH
           PERFORM   910-DB-CLOSE-SEC
           .
       100-PRM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    主取得
      *****************************************************************
       200-MAIN-SEC            SECTION.
      *
      *労災入院料の取得
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-SROUNYUIN-HOSPID    TO  NACCT-HOSPID
           MOVE    LNK-SROUNYUIN-PTID      TO  NACCT-PTID
           MOVE    LNK-SROUNYUIN-SANTEIYM  TO  NACCT-SRYYM
           MOVE    "1"                     TO  NACCT-ZAISKBKBN
           MOVE    "NYUINACCT-KEY17"       TO  ORC-DBPATH
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE     "NYUINACCT-KEY17"  TO  ORC-DBPATH
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   UNTIL   (FLG-NYUINACCT    =   1)
                   IF    NACCT-SRYCDTOTAL     =    99999916
                       CONTINUE
                   ELSE
      *                該当入院行為テーブルの読み込み
                       PERFORM    210-NYUINACT-GET-SEC
      *                入院基本料と初期加算（長期減算）の退避
                       PERFORM    VARYING   IDX   FROM   1   BY   1
                                  UNTIL     IDX   >   31
                           IF    (LNK-SROUNYUIN-NYUIN-FLG(IDX) = "1")
                                      AND
                                 (NACCT-DAY(IDX)   =   1)
                               MOVE    NSRY-SRYCD(1)   TO  
                                                   WRK-NYUINKHN(IDX)
      *                        外泊コード編集用に入院基本料加算区分と
      *                        診療区分の退避
                               PERFORM   210-GAIHAKU-MAE-SEC
      *
                               IF   NSRY-SRYCD(2)  NOT =   SPACE
                                   MOVE   NSRY-SRYCD(2)  TO
                                                   WRK-SHOKIKSN(IDX)
                               END-IF
                           END-IF
                       END-PERFORM
                   END-IF
                   MOVE    "NYUINACCT-KEY17"       TO  ORC-DBPATH
                   PERFORM 910-NYUINACCT-READ-SEC
               END-PERFORM
           ELSE
               GO   TO    200-MAIN-EXT
           END-IF
      *    入院会計クローズ
           MOVE    "NYUINACCT-KEY17"           TO  ORC-DBPATH
           PERFORM   910-DB-CLOSE-SEC
      *
      *労災入院時の外泊取得
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-SROUNYUIN-HOSPID    TO  NACCT-HOSPID
           MOVE    LNK-SROUNYUIN-PTID      TO  NACCT-PTID
           MOVE    LNK-SROUNYUIN-SANTEIYM  TO  NACCT-SRYYM
           MOVE    "2"                     TO  NACCT-ZAISKBKBN
           MOVE    "NYUINACCT-KEY17"       TO  ORC-DBPATH
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE     "NYUINACCT-KEY17"  TO  ORC-DBPATH
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   UNTIL   (FLG-NYUINACCT    =   1)
      *            外泊区分の退避
                   PERFORM    VARYING   IDX   FROM   1   BY   1
                              UNTIL     IDX   >   31
                       IF    (LNK-SROUNYUIN-NYUIN-FLG(IDX) = "1")  AND
                             (NACCT-DAY(IDX)   NOT =   ZERO)
                              PERFORM     210-GAIHAKU-SET-SEC
                       END-IF
                   END-PERFORM
                   MOVE    "NYUINACCT-KEY17"       TO  ORC-DBPATH
                   PERFORM 910-NYUINACCT-READ-SEC
               END-PERFORM
           ELSE
               GO   TO    200-MAIN-EXT
           END-IF
      *    入院会計クローズ
           MOVE    "NYUINACCT-KEY17"           TO  ORC-DBPATH
           PERFORM   910-DB-CLOSE-SEC
      *
      *老人対象患者チェック
           PERFORM   210-RJN-TAISYO-CHK-SEC
      *
      *医療機関減算情報の取得（システム管理テーブルより）
           MOVE    ZERO                TO  FLG-SYSKANRI
           INITIALIZE                      SYSKANRI-REC
           MOVE    "5000"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    LNK-SROUNYUIN-SANTEIYM
                                       TO  ORC-DBYMD(1:6)
           MOVE    "01"                TO  ORC-DBYMD(7:2)
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               PERFORM  SYSKANRI-READ-SEC
               PERFORM  VARYING   GENSAN-IDX  FROM  1  BY  1
                        UNTIL     GENSAN-IDX   >   4
                    IF    SYS-5000-GENKBN(GENSAN-IDX)   =   "2"
                        EVALUATE  GENSAN-IDX
                            WHEN  2
                                MOVE  "190080570"  TO  WRK-GENSAN2
      **                          IF   FLG-RJN    =    ZERO
      **                              MOVE  "190080570"  TO  WRK-GENSAN2
      **                          ELSE
      **                              MOVE  "190799770"  TO  WRK-GENSAN2
      **                          END-IF
                            WHEN  3
                                MOVE  "190111690"  TO  WRK-GENSAN3
      **                          IF   FLG-RJN    =    ZERO
      **                              MOVE  "190111690"  TO  WRK-GENSAN3
      **                          ELSE
      **                              MOVE  "190809090"  TO  WRK-GENSAN3
      **                          END-IF
                            WHEN  4
                                MOVE  "190111790"  TO  WRK-GENSAN4
      **                          IF   FLG-RJN    =    ZERO
      **                              MOVE  "190111790"  TO  WRK-GENSAN4
      **                          ELSE
      **                              MOVE  "190809190"  TO  WRK-GENSAN4
      **                          END-IF
                        END-EVALUATE
                    END-IF
               END-PERFORM
           END-IF
      *
      *労災入院時の入院料加算取得（入院会計より）
           MOVE    ZERO                    TO  KSN-IDX
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-SROUNYUIN-HOSPID    TO  NACCT-HOSPID
           MOVE    LNK-SROUNYUIN-PTID      TO  NACCT-PTID
           MOVE    LNK-SROUNYUIN-SANTEIYM  TO  NACCT-SRYYM
           MOVE    "6"                     TO  NACCT-ZAISKBKBN
           MOVE    "NYUINACCT-KEY17"       TO  ORC-DBPATH
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE     "NYUINACCT-KEY17"  TO  ORC-DBPATH
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   UNTIL   (FLG-NYUINACCT    =   1)
      *            入院料加算の退避
                   ADD        1         TO         KSN-IDX
                   MOVE    NACCT-SRYCDTOTAL   TO   WRK-NYUKSN(KSN-IDX)
                   PERFORM    VARYING   IDX   FROM   1   BY   1
                              UNTIL     IDX   >   31
                       IF    (LNK-SROUNYUIN-NYUIN-FLG(IDX) = "1")  AND
                             (NACCT-DAY(IDX)   NOT =   ZERO)
                           MOVE   NACCT-DAY(IDX)
                                        TO  WRK-NYUKSN-DAY(KSN-IDX IDX)
                       END-IF
                   END-PERFORM
                   MOVE    "NYUINACCT-KEY17"       TO  ORC-DBPATH
                   PERFORM 910-NYUINACCT-READ-SEC
               END-PERFORM
           END-IF
      *    入院会計クローズ
           MOVE    "NYUINACCT-KEY17"           TO  ORC-DBPATH
           PERFORM   910-DB-CLOSE-SEC
      *
      *
      *    取得した労災入院情報から日単位の入院会計情報を再構築
           PERFORM      VARYING    IDX   FROM   1  BY  1
                        UNTIL      IDX   >   31
               MOVE     ZERO                TO  WRK-MEISAISU
      *        入院基本料
               ADD      1                   TO  WRK-MEISAISU
               MOVE     WRK-NYUINKHN(IDX)   TO  LNK-SROUNYUIN-SRYCD
                                           (IDX WRK-MEISAISU)
      *        外泊
               ADD      1                   TO  WRK-MEISAISU
               IF         WRK-GAIHAKU(IDX)   NOT =        SPACE
                   MOVE   WRK-GAIHAKU(IDX)  TO  LNK-SROUNYUIN-SRYCD
                                           (IDX WRK-MEISAISU)
               END-IF
      *        減算情報（システム管理）
               IF      (LNK-SROUNYUIN-GAIHAKU(IDX)   =   ZERO)    AND
                       (WRK-GENSAN2         NOT =    SPACE)
                   ADD      1               TO  WRK-MEISAISU
                   MOVE   WRK-GENSAN2       TO  LNK-SROUNYUIN-SRYCD
                                           (IDX WRK-MEISAISU)
               END-IF
               IF      (LNK-SROUNYUIN-GAIHAKU(IDX)   =   ZERO)    AND
                       (WRK-GENSAN3         NOT =    SPACE)
                   ADD      1               TO  WRK-MEISAISU
                   MOVE   WRK-GENSAN3       TO  LNK-SROUNYUIN-SRYCD
                                           (IDX WRK-MEISAISU)
               END-IF
               IF      (LNK-SROUNYUIN-GAIHAKU(IDX)   =   ZERO)    AND
                       (WRK-GENSAN4         NOT =    SPACE)
                   ADD      1               TO  WRK-MEISAISU
                   MOVE   WRK-GENSAN4       TO  LNK-SROUNYUIN-SRYCD
                                           (IDX WRK-MEISAISU)
               END-IF
      *        労災乗数（特定入院料の場合は労災乗数なし）
               IF       LNK-SROUNYUIN-SRYKBN(IDX)    =    "90"
                   EVALUATE  LNK-SROUNYUIN-JOUSU-KBN(IDX)
                       WHEN  "1"
                           ADD      1           TO  WRK-MEISAISU
                           MOVE   "101900010"   TO  LNK-SROUNYUIN-SRYCD
                                               (IDX WRK-MEISAISU)
                       WHEN  "2"
                           ADD      1           TO  WRK-MEISAISU
                           MOVE   "101900020"   TO  LNK-SROUNYUIN-SRYCD
                                               (IDX WRK-MEISAISU)
                   END-EVALUATE
               END-IF
      *        初期加算（長期減算）
               IF      (LNK-SROUNYUIN-GAIHAKU(IDX)   =   ZERO)    AND
                       (WRK-SHOKIKSN(IDX)   NOT =        SPACE)
                   ADD      1               TO  WRK-MEISAISU
                   MOVE   WRK-SHOKIKSN(IDX) TO  LNK-SROUNYUIN-SRYCD
                                           (IDX WRK-MEISAISU)
               END-IF
      *        入院料加算（入院会計）
               PERFORM   VARYING   KSN-IDX   FROM  1  BY  1
                         UNTIL    (WRK-NYUKSN(KSN-IDX)  =  SPACE)  OR
                                  (KSN-IDX             >  20)
                         ADD     1           TO  WRK-MEISAISU
                         MOVE WRK-NYUKSN(KSN-IDX)
                                             TO  LNK-SROUNYUIN-SRYCD
                                                 (IDX WRK-MEISAISU)
               END-PERFORM
           END-PERFORM
      *
      *    再構築した労災入院会計情報から点数の算定
           PERFORM      VARYING    IDX   FROM   1  BY  1
                        UNTIL      IDX   >   31
      *        点数マスタの読み込み
               PERFORM   VARYING   IDX2    FROM   1  BY   1
                         UNTIL (LNK-SROUNYUIN-SRYCD(IDX IDX2) = SPACE)
                            OR (IDX2    >      20)
                   PERFORM    210-TENSU-KEISAN-SEC
               END-PERFORM
           END-PERFORM
      *
      *    編集結果の表示
           PERFORM      VARYING    IDX   FROM   1  BY  1
                        UNTIL      IDX   >   31
               DISPLAY   "IDX = "  IDX
               DISPLAY   "ZAITEN = "  LNK-SROUNYUIN-ZAITEN(IDX)
               PERFORM   VARYING   IDX2    FROM   1  BY   1
                         UNTIL (LNK-SROUNYUIN-SRYCD(IDX IDX2) = SPACE)
                            OR (IDX2    >      20)
                   DISPLAY  "SRYCD = " LNK-SROUNYUIN-SRYCD(IDX IDX2)
               END-PERFORM
           END-PERFORM
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院診療行為取得
      *****************************************************************
       210-NYUINACT-GET-SEC            SECTION.
      *
           INITIALIZE                      NYUINACT-REC
           MOVE    NACCT-HOSPID        TO  NSRY-HOSPID
           MOVE    NACCT-NYUGAIKBN     TO  NSRY-NYUGAIKBN
           MOVE    NACCT-PTID          TO  NSRY-PTID
           MOVE    NACCT-SRYYM         TO  NSRY-SRYYM
           MOVE    NACCT-ZAINUM        TO  NSRY-ZAINUM
           MOVE    "NYUINACT-KEY9"     TO  ORC-DBPATH
           PERFORM 910-NYUINACT-SELECT-SEC
           IF      FLG-NYUINACT        =   ZERO
               MOVE     "NYUINACT-KEY9"    TO  ORC-DBPATH
               PERFORM   910-NYUINACT-READ-SEC
           END-IF
      *
      *    入院行為クローズ
           MOVE    "NYUINACT-KEY9"     TO  ORC-DBPATH
           PERFORM   910-DB-CLOSE-SEC
      *
           .
       210-NYUINACT-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    外泊前処理
      *****************************************************************
       210-GAIHAKU-MAE-SEC            SECTION.
      *
      *    外泊コード編集用に入院基本料加算区分と診療区分の退避
           INITIALIZE                      TNS-TENSU-REC
           MOVE    LNK-SROUNYUIN-SRYCD(IDX IDX2)
                                           TO  TNS-SRYCD
           MOVE    LNK-SROUNYUIN-SANTEIYM  TO  ORC-DBYMD(1:6)
           MOVE    "01"                    TO  ORC-DBYMD(7:2)
           PERFORM TENSU-READ-SEC
           MOVE    TNS-SRYKBN          TO  LNK-SROUNYUIN-SRYKBN(IDX)
           MOVE    TNS-NYUKHNKSNKBN    TO  WRK-NYUKHNKSNKBN(IDX)
      *
           .
       210-GAIHAKU-MAE-EXT.
           EXIT.
      *
      *****************************************************************
      *    外泊診療コード取得
      *****************************************************************
       210-GAIHAKU-SET-SEC            SECTION.
      *
           MOVE   NACCT-DAY(IDX)     TO    LNK-SROUNYUIN-GAIHAKU(IDX)
      *
      *    EVALUATE   NACCT-DAY(IDX)
      *        WHEN
      *        WHEN
      *            MOVE    *******     TO    WRK-GAIHAKU(IDX)
      *
      *           労さーん、ここよろしく  
      *           WRK-NYUKHNKSNKBN 9(3) を設定するようにしとくから
      *                                 参照してちょ
      *
      *    END-EVALUATE
      *
           .
       210-GAIHAKU-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    老人対象患者チェック
      *****************************************************************
       210-RJN-TAISYO-CHK-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-RJN
      *
      *    入院患者の老人保険判定
           MOVE    ZERO                TO   FLG-HKNCOMBI
           INITIALIZE                       HKNCOMBI-REC
           MOVE    LNK-SROUNYUIN-HOSPID TO  COMB-HOSPID
           MOVE    LNK-SROUNYUIN-PTID  TO   COMB-PTID
           MOVE    LNK-SROUNYUIN-HKNCOMBI
                                       TO   COMB-HKNCOMBINUM
           MOVE    "HKNCOMBI-KEY"      TO   ORC-DBPATH
           PERFORM 910-HKNCOMBI-SELECT-SEC
           IF      FLG-HKNCOMBI        =    ZERO
               MOVE     "HKNCOMBI-KEY" TO   ORC-DBPATH
               PERFORM   910-HKNCOMBI-READ-SEC
           END-IF
      *    保険組合せクローズ
           MOVE    "HKNCOMBI-KEY"      TO   ORC-DBPATH
           PERFORM   910-DB-CLOSE-SEC
      *
      *    入院患者の年齢計算
           INITIALIZE                      ORCSAGECHKAREA
           MOVE    LNK-SROUNYUIN-HOSPID
                                       TO  AGECHK-HOSPID
           MOVE    LNK-SROUNYUIN-PTID
                                       TO  AGECHK-PTID
           MOVE    LNK-SROUNYUIN-SANTEIYM
                                       TO  AGECHK-SRYYMD(1:6)
           MOVE    "01"                TO  AGECHK-SRYYMD(7:2)
           MOVE    PTINF-BIRTHDAY      TO  AGECHK-BIRTHDAY
           CALL    "ORCSAGECHK"        USING
                                           ORCSAGECHKAREA
           IF    ( AGECHK-RC           =   ZERO )
               CONTINUE
           ELSE
               INITIALIZE  ORCSAGECHKAREA
           END-IF
      *
      *    老人対象患者判定
           IF    ((FLG-HKNCOMBI        =   ZERO)    AND
                  (COMB-KOH1HKNNUM     =   "027"))   OR
                 ( AGECHK-NENREI      >=    75)      OR
                 ((AGECHK-NENREI      >=    70)     AND
                  (PTINF-BIRTHDAY     <=   "19320930"))
               MOVE    1               TO  FLG-RJN
           END-IF
      *
           .
       210-RJN-TAISYO-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数計算処理
      *****************************************************************
       210-TENSU-KEISAN-SEC            SECTION.
      *
           INITIALIZE                      TNS-TENSU-REC
           IF     (IDX2      =    1)      AND
                  (LNK-SROUNYUIN-GAIHAKU(IDX)   NOT =  ZERO)
               PERFORM    GAIHAKU-NYUINKHN-SET-SEC
               MOVE    WRK-GAIHAKU-SRYCD   TO  TNS-SRYCD
           ELSE
               MOVE    LNK-SROUNYUIN-SRYCD(IDX IDX2)
                                           TO  TNS-SRYCD
           END-IF
           MOVE    LNK-SROUNYUIN-SANTEIYM  TO  ORC-DBYMD(1:6)
           MOVE    "01"                    TO  ORC-DBYMD(7:2)
           PERFORM TENSU-READ-SEC
      *
      *    点数算定
           EVALUATE    TNS-TENSIKIBETU
      *        点数（プラス）
               WHEN    3
                   ADD   TNS-TEN     TO  LNK-SROUNYUIN-ZAITEN(IDX)
      *        ％加算
               WHEN    5
                   COMPUTE    LNK-SROUNYUIN-ZAITEN(IDX)  =
                              LNK-SROUNYUIN-ZAITEN(IDX)  +
                            ((LNK-SROUNYUIN-ZAITEN(IDX)  *  
                              (TNS-TEN   /  100))  + 0.5)
      *        ％減算
               WHEN    6
                   COMPUTE    LNK-SROUNYUIN-ZAITEN(IDX)  =
                              LNK-SROUNYUIN-ZAITEN(IDX)  -
                            ((LNK-SROUNYUIN-ZAITEN(IDX)  *  
                              (TNS-TEN   /  100))  + 0.5)
      *        点数（マイナス）
               WHEN    8
                   COMPUTE  LNK-SROUNYUIN-ZAITEN(IDX)  =
                            LNK-SROUNYUIN-ZAITEN(IDX)  -  TNS-TEN
      *        WHEN  OTHER
                   ADD   TNS-TEN     TO  LNK-SROUNYUIN-ZAITEN(IDX)
           END-EVALUATE
      *
      *    診療コード計
           MOVE    TNS-SRYCD          TO  WRK-SRYCD-X
           COMPUTE LNK-SROUNYUIN-SRYCDTOTAL(IDX)  =
                   LNK-SROUNYUIN-SRYCDTOTAL(IDX)  +   WRK-SRYCD-9
           ADD      1          TO  LNK-SROUNYUIN-MEISAISU(IDX)
      *
      *
           .
       210-TENSU-KEISAN-EXT.
           EXIT.
      *
      **************************************************************
      *    外泊時の入院基本料取得
      **************************************************************
       GAIHAKU-NYUINKHN-SET-SEC           SECTION.
      *
           MOVE    SPACE    TO   WRK-GAIHAKU-SRYCD
      *
           EVALUATE  LNK-SROUNYUIN-SRYCD(IDX IDX2)
               WHEN  "190078210"
                     MOVE  "190077410"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078310"
                     MOVE  "190077510"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078410"
                     MOVE  "190077610"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078510"
                     MOVE  "190077710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078610"
                     MOVE  "190077810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078710"
                     MOVE  "190077910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078810"
                     MOVE  "190078010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078910"
                     MOVE  "190078110"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190082410"
                     MOVE  "190081710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082510"
                     MOVE  "190081810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082610"
                     MOVE  "190081910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082710"
                     MOVE  "190082010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082810"
                     MOVE  "190082110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082910"
                     MOVE  "190082210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190083010"
                     MOVE  "190082310"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190084310"
                     MOVE  "190083610"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084410"
                     MOVE  "190083710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084510"
                     MOVE  "190083810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084610"
                     MOVE  "190083910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084710"
                     MOVE  "190084010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084810"
                     MOVE  "190084110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084910"
                     MOVE  "190084210"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190087410"
                     MOVE  "190085910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087510"
                     MOVE  "190086010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087610"
                     MOVE  "190086110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087710"
                     MOVE  "190086210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087810"
                     MOVE  "190086310"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087910"
                     MOVE  "190086410"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088010"
                     MOVE  "190086510"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088110"
                     MOVE  "190086610"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088210"
                     MOVE  "190086710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088310"
                     MOVE  "190086810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088410"
                     MOVE  "190086910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088510"
                     MOVE  "190087010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088610"
                     MOVE  "190087110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088710"
                     MOVE  "190087210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088810"
                     MOVE  "190087310"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190094710"
                     MOVE  "190093710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190094810"
                     MOVE  "190093810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190094910"
                     MOVE  "190093910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190095010"
                     MOVE  "190094010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190095110"
                     MOVE  "190094110"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190797410"
                     MOVE  "190796610"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797510"
                     MOVE  "190796710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797610"
                     MOVE  "190796810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797710"
                     MOVE  "190796910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797810"
                     MOVE  "190797010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797910"
                     MOVE  "190797110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190798010"
                     MOVE  "190797210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190798110"
                     MOVE  "190797310"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190803510"
                     MOVE  "190802810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190803610"
                     MOVE  "190802910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190803710"
                     MOVE  "190803010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190803810"
                     MOVE  "190803110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190803910"
                     MOVE  "190803210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190804010"
                     MOVE  "190803310"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190804110"
                     MOVE  "190803410"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190091210"
                     MOVE  "190090210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190091310"
                     MOVE  "190090310"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190109670"
                     MOVE  "190097010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190808870"
                     MOVE  "190805710"      TO   WRK-GAIHAKU-SRYCD
           END-EVALUATE
      *
           .
       GAIHAKU-NYUINKHN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスター読込
      *****************************************************************
       SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-5000-REC
               MOVE    ZERO                TO  FLG-SYSKANRI
           ELSE
               INITIALIZE                      SYS-5000-REC
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           .
       SUSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
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
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスター検索
      *****************************************************************
       910-NYUINACCT-SELECT-SEC        SECTION.
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-NYUINACCT
           ELSE
               MOVE    1                  TO  FLG-NYUINACCT
           END-IF
      *
           .
       910-NYUINACCT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスター読込
      *****************************************************************
       910-NYUINACCT-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  NYUINACCT-REC
               MOVE    ZERO               TO  FLG-NYUINACCT
           ELSE
               MOVE    1                  TO  FLG-NYUINACCT
           END-IF
      *
           .
       910-NYUINACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院診療行為マスター検索
      *****************************************************************
       910-NYUINACT-SELECT-SEC        SECTION.
      *
           MOVE    NYUINACT-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-NYUINACT
           ELSE
               MOVE    1                  TO  FLG-NYUINACT
           END-IF
      *
           .
       910-NYUINACT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院診療行為マスター読込
      *****************************************************************
       910-NYUINACT-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  NYUINACT-REC
               MOVE    ZERO                TO  FLG-NYUINACT
           ELSE
               INITIALIZE                      NYUINACT-REC
               MOVE    1                   TO  FLG-NYUINACT
           END-IF
      *
           .
       910-NYUINACT-READ-EXT.
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
           MOVE    WRK-YMD             TO  ORC-DBYMD
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
      *    保険組合せマスター検索
      *****************************************************************
       910-HKNCOMBI-SELECT-SEC        SECTION.
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-HKNCOMBI
           ELSE
               MOVE    1                  TO  FLG-HKNCOMBI
           END-IF
      *
           .
       910-HKNCOMBI-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスター読込
      *****************************************************************
       910-HKNCOMBI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  HKNCOMBI-REC
               MOVE    ZERO                TO  FLG-HKNCOMBI
           ELSE
               INITIALIZE                      HKNCOMBI-REC
               MOVE    1                   TO  FLG-HKNCOMBI
           END-IF
      *
           .
       910-HKNCOMBI-READ-EXT.
           EXIT.
      *****************************************************************
      *    点数マスター読込（主キー）
      *****************************************************************
       TENSU-READ-SEC         SECTION.
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
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
                   MOVE    1                   TO  FLG-TENSU
                   INITIALIZE                  TNS-TENSU-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-TENSU
               INITIALIZE                  TNS-TENSU-REC
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
       TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DB-CLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
      *
       910-DB-CLOSE-EXT.
           EXIT.
