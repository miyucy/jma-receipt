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
           03  GENSAN-IDX          PIC 9(04).
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
           03  WRK-CNT                     PIC 9(03).
      *
      *    労災入院会計ワーク
           03  WRK-ROUSAI-TABLE.
               05  WRK-ROUSAI-TBL          OCCURS  31.
                   07  WRK-NYUINKHN        PIC X(09).
                   07  WRK-SHOKIKSN        PIC X(09).
                   07  WRK-GAIHAKU         PIC X(09).
                   07  WRK-NYUKHNKSNKBN    PIC 9(03).
      *
      *    入院診療計画未実施減算ワーク
           03  WRK-GENSAN1                 PIC X(09).
      *    院内感染防止対策未実施減算ワーク
           03  WRK-GENSAN2                 PIC X(09).
      *    医療安全管理体制未整備減算ワーク
           03  WRK-GENSAN3                 PIC X(09).
      *    褥瘡対策未実施減算ワーク
           03  WRK-GENSAN4                 PIC X(09).
      *
      *    日常生活障害加算
           03  WRK-NICHIJOU-KSN            PIC X(09).
      *    痴呆加算
           03  WRK-CHIHOU-KSN              PIC X(09).
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
                             UNTIL    (FLG-ROUSAI   =   1)  OR
                                      (IDX   >   31)
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
      *    取得した労災入院情報から日単位の入院会計情報を再構築
           PERFORM      VARYING    IDX   FROM   1  BY  1
                        UNTIL      IDX   >   31
      *        入院基本料
               ADD      1                   TO  LNK-SROUNYUIN-MEISAISU
               MOVE     WRK-NYUINKHN(IDX)   TO  LNK-SROUNYUIN-SRYCD
                                           (IDX LNK-SROUNYUIN-MEISAISU)
      *        外泊
               IF         WRK-GAIHAKU(IDX)   NOT =        SPACE
                   ADD    1                 TO  LNK-SROUNYUIN-MEISAISU
                   MOVE   WRK-GAIHAKU(IDX)  TO  LNK-SROUNYUIN-SRYCD
                                           (IDX LNK-SROUNYUIN-MEISAISU)
               END-IF
      *        減算情報（システム管理）
               IF      (LNK-SROUNYUIN-GAIHAKU(IDX)   =   ZERO)    AND
                       (WRK-GENSAN2         NOT =    SPACE)
                   ADD    1                 TO  LNK-SROUNYUIN-MEISAISU
                   MOVE   WRK-GENSAN2       TO  LNK-SROUNYUIN-SRYCD
                                           (IDX LNK-SROUNYUIN-MEISAISU)
               END-IF
               IF      (LNK-SROUNYUIN-GAIHAKU(IDX)   =   ZERO)    AND
                       (WRK-GENSAN3         NOT =    SPACE)
                   ADD    1                 TO  LNK-SROUNYUIN-MEISAISU
                   MOVE   WRK-GENSAN3       TO  LNK-SROUNYUIN-SRYCD
                                           (IDX LNK-SROUNYUIN-MEISAISU)
               END-IF
               IF      (LNK-SROUNYUIN-GAIHAKU(IDX)   =   ZERO)    AND
                       (WRK-GENSAN4         NOT =    SPACE)
                   ADD    1                 TO  LNK-SROUNYUIN-MEISAISU
                   MOVE   WRK-GENSAN4       TO  LNK-SROUNYUIN-SRYCD
                                           (IDX LNK-SROUNYUIN-MEISAISU)
               END-IF
      *        労災乗数
               EVALUATE  LNK-SROUNYUIN-JOUSU-KBN(IDX)
                   WHEN  "1"
                       ADD    1             TO  LNK-SROUNYUIN-MEISAISU
                       MOVE   "101900010"   TO  LNK-SROUNYUIN-SRYCD
                                           (IDX LNK-SROUNYUIN-MEISAISU)
                   WHEN  "2"
                       ADD    1             TO  LNK-SROUNYUIN-MEISAISU
                       MOVE   "101900020"   TO  LNK-SROUNYUIN-SRYCD
                                           (IDX LNK-SROUNYUIN-MEISAISU)
               END-EVALUATE
      *        初期加算（長期減算）
               IF      (LNK-SROUNYUIN-GAIHAKU(IDX)   =   ZERO)    AND
                       (WRK-SHOKIKSN(IDX)   NOT =        SPACE)
                   ADD    1                 TO  LNK-SROUNYUIN-MEISAISU
                   MOVE   WRK-SHOKIKSN(IDX) TO  LNK-SROUNYUIN-SRYCD
                                           (IDX LNK-SROUNYUIN-MEISAISU)
               END-IF
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
           MOVE    LNK-SROUNYUIN-SRYCD(IDX IDX2)
                                           TO  TNS-SRYCD
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
      *
      *
           .
       210-TENSU-KEISAN-EXT.
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
      *****************************************************************
      *    診療行為マスター読込
      *****************************************************************
       920-NYUINACT-READ-SEC         SECTION.
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
       920-NYUINACT-READ-EXT.
           EXIT.
      *****************************************************************
      *    診療会計マスター読込
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
