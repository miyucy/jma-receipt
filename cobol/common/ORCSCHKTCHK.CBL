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
       PROGRAM-ID.                 ORCSCHKTCHK.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 診療行為入力
      *  コンポーネント名  : 包括診療行為チェック処理
      *  管理者            : 
      *  作成日付    作業者        記述
      *  07/02/XX    NACL−多々納  新規作成
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
           03  FLG-END                 PIC 9(01).
           03  FLG-ERR                 PIC 9(01).
           03  FLG-HKTSANTEI           PIC 9(01).
           03  FLG-HKTSRYCD            PIC 9(01).
           03  FLG-SYSKANRI            PIC 9(01).
           03  FLG-SANTEI              PIC 9(01).
      *
           03  FLG-CHK                 PIC 9(01).
           03  FLG-CHK2                PIC 9(01).
           03  FLG-CHK3                PIC 9(01).
           03  FLG-HOUKATU             PIC 9(01).
           03  FLG-SONOTA              PIC 9(01).
           03  FLG-ZAIARI              PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                     PIC 9(04).
           03  IDY                     PIC 9(04).
           03  IDZ                     PIC 9(04).
           03  IDX-S                   PIC 9(04).
           03  IDX-H                   PIC 9(04).
           03  IDX-K                   PIC 9(04).
           03  IDX-Z                   PIC 9(04).
           03  IDX-Z2                  PIC 9(04).
           03  IDX-Z3                  PIC 9(04).
      *
           03  IDX-L1                  PIC 9(04).
           03  IDX-L2                  PIC 9(04).
           03  IDX-ERR                 PIC 9(04).
      *
           03  IDD                     PIC 9(02).
           03  IDD2                    PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-TEI-CNT             PIC 9(03).
           03  WRK-DAY                 PIC S9(03).
           03  WRK-SRYCD               PIC X(09).
      *
      *    包括する診療区分
           03  WRK-HKT-SRYKBN-G.
               05  WRK-HKTKBN20        PIC 9(01).
               05  WRK-HKTKBN30        PIC 9(01).
               05  WRK-HKTKBN40        PIC 9(01).
               05  WRK-HKTKBN50        PIC 9(01).
               05  WRK-HKTKBN60        PIC 9(01).
               05  WRK-HKTKBN70        PIC 9(01).
               05  WRK-HKTKBN80        PIC 9(01).
               05  WRK-HKTKBN81        PIC 9(01).
               05  WRK-HKTKBN82        PIC 9(01).
               05  WRK-HKTKBN83        PIC 9(01).
      *
       01  TBL-AREA.
           03  TBL-DATA-G              OCCURS   100.
               05  TBL-KANRICD             PIC  X(03).
               05  TBL-SANTEI-HOU          PIC  X(01).
               05  TBL-SANTEI-KBN          PIC  X(01).
               05  TBL-NYUGAIKBN           PIC  X(01).
               05  TBL-HKNCOMBIKBN         PIC  X(01).
               05  TBL-SRYKBN-G.
                   07  TBL-SRYKBN-KBN      PIC X(01)
                                           OCCURS   50.
               05  TBL-SRYCD-G.
                   07  TBL-SRYCD           PIC X(09)
                                           OCCURS   50.
           03  TBL-MAX                 PIC 9(04).
       01  TBL-HKTSANTEI-AREA.
           03  TBL-HKTSANTEI-DATA-G        OCCURS   600.
               05  TBL-HKTSRYCD            PIC X(09).
               05  TBL-SANTEIKBN           PIC X(01).
               05  TBL-KENTAIKBN           PIC X(01).
      *
      *    保存ＳＰＡ領域ワーク
       01  HZN-SCR-REC.
           COPY    "CPK02SPASCR.INC"  REPLACING
                                       //SPA-// BY //HZN-//.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSK1014.INC".
      *    包括チェックマスタ
       01  HKTSANTEI-REC.
           COPY    "CPHKTSANTEI.INC".
      *    包括診療コードマスタ
       01  HKTSRYCD-REC.
           COPY    "CPHKTSRYCD.INC".
      *
      *    算定履歴
       01  SANTEI-REC.
           COPY    "CPSANTEI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    診療行為用共通パラメタ
           COPY    "K01COMMON-SPA".
      *
           COPY    "MCPAREA".
           COPY    "MCPDATA.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *    包括診療チェックパラメタ
           COPY    "CPORCSCHKTCHK.INC".
      *
      *    画面スパ領域
           COPY    "K02SCR-SPA".
      *    ＳＰＡパラメタ
       01  SPA-SCR-REC.
           COPY    "CPK02SPASCR.INC".
      *
      *    診療行為算定用共通パラメタ(自動発生分チェック）
           COPY    "CPORCSC00.INC".
      *
       PROCEDURE                   DIVISION    USING
           ORCSCHKTCHKAREA
           SPA-AREA
           SPA-K02
           SPA-SCR-REC
           ORCSC00AREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                      WRK-AREA
           INITIALIZE                      FLG-AREA
           INITIALIZE                      IDX-AREA
           IF      ORCSCHKTCHK-PG      =   "K02"
               MOVE    SPA-WORK            TO  SPA-K01KYOUTU
           ELSE
               INITIALIZE                      SPA-K01KYOUTU
           END-IF
           INITIALIZE                  ORCSCHKTCHK-OUTAREA
      *
           EVALUATE    ORCSCHKTCHK-SYORI
               WHEN    "1"
      *        全体チェック
      *            包括対象有無
                   PERFORM 100-INIT-SYORI-SEC
      *            チェック処理
                   PERFORM 200-MAIN-SYORI-SEC
               WHEN    "2"
      *        自動発生分
      *            包括対象有無
                   PERFORM 100-INIT-SYORI-SEC
      *            包括チェック
                   PERFORM 300-AUTO-SYORI-SEC
               WHEN    "3"
      *        エラー削除
                   PERFORM 400-ERR-DELETE-SEC
           END-EVALUATE
      *
           . 
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SYORI-SEC            SECTION.
      *
      *    システム管理検索
           MOVE    SPACE               TO  SYS-1014-REC
           INITIALIZE                  SYS-1014-REC
           MOVE    "1014"              TO  SYS-1014-KANRICD
           MOVE    SPA-SRYYMD          TO  SYS-1014-STYUKYMD
           MOVE    SPA-SRYYMD          TO  SYS-1014-EDYUKYMD
           MOVE    SYS-1014-REC        TO  MCPDATA-REC
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    ZERO                TO  IDX
           INITIALIZE                  TBL-AREA
           PERFORM UNTIL  (FLG-SYSKANRI    =   1  )
                       OR (IDX             >=  100 )
               MOVE    MCPDATA-REC         TO  SYS-1014-REC
               IF      SYS-1014-SANTEI-HOU     =   "1"
                                               OR  "2"
                   ADD     1               TO  IDX
                   MOVE    SYS-1014-KBNCD (1:3)
                                           TO  TBL-KANRICD (IDX)
      *            包括算定方法
                   MOVE    SYS-1014-SANTEI-HOU
                                           TO  TBL-SANTEI-HOU (IDX)
                   MOVE    SYS-1014-SANTEI-KBN
                                           TO  TBL-SANTEI-KBN (IDX)
                   MOVE    SYS-1014-NYUGAIKBN
                                           TO  TBL-NYUGAIKBN (IDX)
                   MOVE    SYS-1014-HKNCOMBI-KBN
                                           TO  TBL-HKNCOMBIKBN (IDX)
                   MOVE    SYS-1014-SRYKBN-G
                                           TO  TBL-SRYKBN-G (IDX)
                   PERFORM 1001-HKTSRYCD-HEN-SEC
                   MOVE    IDX             TO  TBL-MAX
               END-IF
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
           .
       100-INIT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    包括診療コード編集処理
      *****************************************************************
       1001-HKTSRYCD-HEN-SEC            SECTION.
      *
           MOVE    SPACE               TO  HKTSRYCD-REC
           INITIALIZE                  HKTSRYCD-REC
           MOVE    TBL-KANRICD (IDX)   TO  HKTSRYCD-KANRICD
           MOVE    SPA-SRYYMD          TO  HKTSRYCD-YUKOSTYMD
           MOVE    SPA-SRYYMD          TO  HKTSRYCD-YUKOEDYMD
           MOVE    HKTSRYCD-REC        TO  MCPDATA-REC
      *
           MOVE    "tbl_hktsrycd"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_hktsrycd"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 910-HKTSRYCD-READ-SEC
           ELSE
               MOVE    1               TO  FLG-HKTSRYCD
           END-IF
           MOVE    ZERO                TO  IDY
           PERFORM UNTIL  (FLG-HKTSRYCD    =   1  )
                      OR  (IDY             >=  50 )
               ADD     1                   TO  IDY
               MOVE    HKTSRYCD-SRYCD      TO  TBL-SRYCD (IDX IDY)
               MOVE    "tbl_hktsrycd"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 910-HKTSRYCD-READ-SEC
           END-PERFORM
           MOVE    "tbl_hktsrycd"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
           .
       1001-HKTSRYCD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    メイン処理
      *****************************************************************
       200-MAIN-SYORI-SEC            SECTION.
      *
      *    包括区分クリア
           PERFORM VARYING     IDX-Z   FROM    1   BY  1
                   UNTIL      (IDX-Z       >   SPA-GMN-MAX  ) 
               MOVE    ZERO            TO  SPA-COM-HOUKATU-FLG (IDX-Z)
               MOVE    ZERO            TO  SPA-COM-HOUKATU-FLG2(IDX-Z)
               MOVE    ZERO            TO  SPA-COM-HOUKATU-ZAI (IDX-Z)
               MOVE    ZERO            TO  SPA-COM-HOUKATU-ERR (IDX-Z)
           END-PERFORM
      *
      *    包括チェック判定
           PERFORM 2001-TAISYOU-CHK-SEC
      *
      *    包括コードがある剤はすべて包括とする
           MOVE    SPA-SCR-REC         TO  HZN-SCR-REC
           MOVE    ZERO                TO  IDX
           MOVE    1                   TO  IDX-S
           MOVE    ZERO                TO  IDX-ERR
           MOVE    ZERO                TO  FLG-HOUKATU
           MOVE    ZERO                TO  FLG-SONOTA
           MOVE    ZERO                TO  ORCSCHKTCHK-HKTERR
           PERFORM VARYING     IDX-Z   FROM    1   BY  1
                   UNTIL      (IDX-Z       >   200     )   OR
                             ((HZN-GMN-INPUTCD (IDX-Z) =   SPACE ) AND
                              (HZN-COM-INPUTCD (IDX-Z) =   SPACE ))
               IF     (SPA-COM-HOUKATU-ERR (IDX-Z) =   1  )
                   MOVE    1                   TO  ORCSCHKTCHK-HKTERR
               END-IF
               IF     (SPA-COM-HOUKATU-FLG (IDX-Z) =   1  )
                   MOVE    1                   TO  FLG-HOUKATU
               END-IF
               IF     (SPA-COM-HOUKATU-FLG (IDX-Z) =   ZERO  )
                   IF    ((SPA-COM-INPUTCD (IDX-Z)(1:1)    =   "1" )
                      AND (SPA-COM-DATAKBN (IDX-Z)         =   "1" ))
                   OR    ( SPA-COM-INPUTCD (IDX-Z)(1:1)    =   "6"
                                                           OR  "7" )
                   OR    ( SPA-COM-HOUKATU-FLG2 (IDX-Z)    =   1   )
                       MOVE    1                   TO  FLG-SONOTA
                   END-IF
               END-IF
               IF     (SPA-COM-ZAIEND (IDX-Z)  =   "1"   )
                   PERFORM VARYING     IDX     FROM    IDX-S  BY  1
                           UNTIL      (IDX         >   IDX-Z  )
                       MOVE    FLG-HOUKATU     TO  SPA-COM-HOUKATU-ZAI
                                                              (IDX)
      *                剤内に包括外がある場合、警告
                       IF     (FLG-HOUKATU     =   1   )  AND
                              (FLG-SONOTA      =   1   )  AND
                              (SPA-COM-HOUKATU-FLG (IDX) =   ZERO)
                           PERFORM 2002-HOUKATU-GAI-CHK-SEC
                       ELSE
                           MOVE    ZERO        TO  SPA-COM-HOUKATU-FLG2
                                                                (IDX) 
                       END-IF
                   END-PERFORM
                   MOVE    IDX                 TO  IDX-S
                   MOVE    ZERO                TO  FLG-HOUKATU
                   MOVE    ZERO                TO  FLG-SONOTA
               END-IF
           END-PERFORM
      *
           IF      IDX-ERR         NOT =   ZERO
               IF      SPA-HKTKEI-FLG      =   ZERO
                   MOVE    "K202"          TO  SPA-ERRCD
                   MOVE    1               TO  SPA-HKTKEI-FLG
                   MOVE    "1"             TO  SPA-COM-CUR(IDX-ERR)
               END-IF
           END-IF
      *
           .
       200-MAIN-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    包括外チェック処理
      *****************************************************************
       2002-HOUKATU-GAI-CHK-SEC            SECTION.
      *
           IF    (SPA-COM-INPUTCD (IDX)(1:1)   =   "6"
                                               OR  "7" )
               MOVE    1               TO  SPA-COM-HOUKATU-FLG2 (IDX)
           END-IF
           IF     (SPA-COM-INPUTCD (IDX)(1:1)  =   "1" ) AND
                  (SPA-COM-DATAKBN (IDX)       =   "1" )
               IF     (SPA-COM-SRYKBN (IDX)    =   "60"  ) AND
                      (SPA-COM-KENTAICOMMENT(IDX)  =   1 )
      *            検体検査コメントは対象外
                   CONTINUE
               ELSE
                   MOVE    1               TO  SPA-COM-HOUKATU-FLG2
                                                                (IDX)
               END-IF
           END-IF
           IF      SPA-COM-HOUKATU-FLG2 (IDX)  =   1
               IF      IDX-ERR             =   ZERO
                   MOVE    IDX                 TO  IDX-ERR
               END-IF
           END-IF
           .
       2002-HOUKATU-GAI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    包括判定・チェック処理
      *****************************************************************
       2001-TAISYOU-CHK-SEC            SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   TBL-MAX )
               MOVE    ZERO            TO  FLG-CHK
               PERFORM VARYING     IDX-Z   FROM    1   BY  1
                       UNTIL      (IDX-Z       >   SPA-GMN-MAX )
                               OR (FLG-CHK     =   1    )
                   IF     (SPA-COM-HKNCOMBI (IDX-Z)    NOT =   "9999")
                      AND (SPA-COM-SRYKBN (IDX-Z)(1:1) NOT =   "9"   )
      *                手技
                       IF     (SPA-COM-INPUTCD(IDX-Z)(1:1) =   "1" )
                           MOVE    SPA-COM-INPUTCD(IDX-Z)  TO  WRK-SRYCD
                           PERFORM 2001-HKTSRYCD-CHK-SEC
                           IF      FLG-CHK2            =   1
                               MOVE    1               TO  FLG-CHK
                           END-IF
                       ELSE
      *                外来診療料チェックは再診区分があれば対象
                           IF     (TBL-KANRICD (IDX)       =   "001")
                              AND (SPA-COM-SRYKBN (IDX-Z)  =   "12" )
      *                       一般病床数
                              AND  (SPA-BEDSUIPN        >=  200 )
                              AND  (SPA-HOSPSBT         =   1   )
                               MOVE    1               TO  FLG-CHK
                           END-IF
                       END-IF
                   END-IF
               END-PERFORM
               IF     (FLG-CHK                 =   ZERO )
                  AND (TBL-SANTEI-KBN(IDX) NOT =   "1" )
      *            算定履歴による包括診療チェック
                   PERFORM 2003-HKTSRYCD-RRK-SEC
               END-IF
               IF      FLG-CHK             =   1
                   MOVE    1               TO  ORCSCHKTCHK-HKTFLG
      *            入力項目の包括チェク
                   PERFORM 2002-HKTSANTEI-CHK-SEC
               END-IF
           END-PERFORM
      *
           .
       2001-TAISYOU-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    包括コードチェック処理
      *****************************************************************
       2001-HKTSRYCD-CHK-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-CHK2
           PERFORM VARYING     IDY     FROM    1   BY  1
                   UNTIL      (IDY     >   50   )  OR
                              (TBL-SRYCD (IDX IDY) =   SPACE)
               IF      WRK-SRYCD           =   TBL-SRYCD (IDX IDY)
                   MOVE    1                   TO  FLG-CHK2
                   MOVE    50                  TO  IDY
               END-IF
           END-PERFORM
      *
           .
       2001-HKTSRYCD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    算定履歴による包括診療チェック処理
      *****************************************************************
       2003-HKTSRYCD-RRK-SEC            SECTION.
      *
      *    算定履歴検索
           MOVE    SPACE               TO  SANTEI-REC
           INITIALIZE                  SANTEI-REC
           MOVE    SPA-HOSPID          TO  SANTEI-HOSPID
           MOVE    SPA-PTID            TO  SANTEI-PTID
           MOVE    SPA-SRYYMD (1:6)    TO  SANTEI-SRYYM
      *
           MOVE    SANTEI-REC          TO  MCPDATA-REC
           MOVE    "tbl_santei"        TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 920-SANTEI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SANTEI
           END-IF
      *
           PERFORM
               UNTIL      (FLG-SANTEI      =   1  )  OR
                          (FLG-CHK         =   1  )
               MOVE    SANTEI-SRYCD            TO  WRK-SRYCD
               PERFORM 2001-HKTSRYCD-CHK-SEC
               IF     (SANTEI-MSANTEICNT   >   ZERO )
                 AND  (FLG-CHK2            =   1    )
      *            保険別の時、保険組合せ判定
                   IF      (TBL-HKNCOMBIKBN(IDX)   =   "1" )
                       AND (SANTEI-HKNCOMBINUM NOT =   SPA-HKNCOMBINUM)
                       CONTINUE
                   ELSE
                       PERFORM 20031-SANTEI-CHK-SEC
                   END-IF
               END-IF
               MOVE    "tbl_santei"        TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 920-SANTEI-READ-SEC
           END-PERFORM
      *
           MOVE    "tbl_santei"        TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
           .
       2003-HKTSRYCD-RRK-EXT.
           EXIT.
      *
      *****************************************************************
      *    算定履歴の算定チェック処理
      *****************************************************************
       20031-SANTEI-CHK-SEC            SECTION.
      *
      *    訂正の時、当日算定有無の判定
           MOVE    ZERO                TO  WRK-TEI-CNT
           IF      SPA-SYORIFLG        =   1
               PERFORM VARYING IDZ     FROM    1   BY  1
                       UNTIL   (IDZ        >   100 )  OR
                               (SPA-K02-TEI-SRYCD(IDZ)
                                           =   SPACE )
                   IF      SPA-K02-TEI-SRYCD(IDZ)
                                           =   WRK-SRYCD
                       ADD     SPA-K02-TEI-KAISU(IDZ)
                                               TO  WRK-TEI-CNT
                   END-IF
               END-PERFORM
           END-IF
           MOVE    SPA-SRYYMD(7:2)     TO  IDD2
           EVALUATE    TBL-SANTEI-KBN(IDX)
               WHEN    "2"
      *            算定日
                   IF     (SANTEI-DAY (IDD2)   =   ZERO )  OR
                          (SANTEI-DAY (IDD2)   =   WRK-TEI-CNT)
                       CONTINUE
                   ELSE
                       MOVE    1               TO  FLG-CHK
                   END-IF
               WHEN    "3"
      *            算定月
                   COMPUTE WRK-DAY             =   SANTEI-MSANTEICNT
                                               -   WRK-TEI-CNT
                   IF      WRK-DAY             >   ZERO
                       MOVE    1               TO  FLG-CHK
                   END-IF
               WHEN    "4"
      *            算定日以降
                   PERFORM VARYING     IDD     FROM    1   BY  1
                           UNTIL       IDD     >   IDD2
                       IF     (SANTEI-DAY (IDD)    >   ZERO )
                           IF      (IDD            =   IDD2 )  AND
                                   (SANTEI-DAY (IDD)    =   WRK-TEI-CNT)
                               CONTINUE
                           ELSE
                               MOVE    1               TO  FLG-CHK
                           END-IF
                           MOVE    IDD2                TO  IDD
                       END-IF
                   END-PERFORM
           END-EVALUATE
           .
       20031-SANTEI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力項目の包括チェク処理
      *****************************************************************
       2002-HKTSANTEI-CHK-SEC            SECTION.
      *
           MOVE    SPACE               TO  HKTSANTEI-REC
           INITIALIZE                  HKTSANTEI-REC
           MOVE    TBL-KANRICD (IDX)   TO  HKTSANTEI-KANRICD
           MOVE    SPA-SRYYMD          TO  HKTSANTEI-YUKOSTYMD
           MOVE    SPA-SRYYMD          TO  HKTSANTEI-YUKOEDYMD
           MOVE    HKTSANTEI-REC       TO  MCPDATA-REC
      *
           MOVE    "tbl_hktsantei"     TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_hktsantei"     TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 910-HKTSANTEI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-HKTSANTEI
           END-IF
           INITIALIZE                  TBL-HKTSANTEI-AREA
           MOVE    ZERO                TO  IDX-H
           PERFORM UNTIL  (FLG-HKTSANTEI   =   1  )
                      OR  (IDX-H           >=  600 )
               ADD     1                   TO  IDX-H
               MOVE    HKTSANTEI-SRYCD     TO  TBL-HKTSRYCD (IDX-H)
               MOVE    HKTSANTEI-SANTEIKBN TO  TBL-SANTEIKBN (IDX-H)
               MOVE    HKTSANTEI-KENTAIKBN TO  TBL-KENTAIKBN (IDX-H)
               MOVE    "tbl_hktsantei"     TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 910-HKTSANTEI-READ-SEC
           END-PERFORM
           MOVE    "tbl_hktsantei"     TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           INITIALIZE                  WRK-HKT-SRYKBN-G
           PERFORM VARYING     IDX-K   FROM    1   BY  1
                   UNTIL      (IDX-K       >   9   )
               IF      TBL-SRYKBN-KBN (IDX IDX-K)  =   "1"
                   EVALUATE    IDX-K
                       WHEN    1
                           MOVE    1           TO  WRK-HKTKBN20
                       WHEN    2
                           MOVE    1           TO  WRK-HKTKBN30
                       WHEN    3
                           MOVE    1           TO  WRK-HKTKBN40
                       WHEN    4
                           MOVE    1           TO  WRK-HKTKBN50
                       WHEN    5
                           MOVE    1           TO  WRK-HKTKBN60
                       WHEN    6
                           MOVE    1           TO  WRK-HKTKBN70
                       WHEN    7
                           MOVE    1           TO  WRK-HKTKBN80
                       WHEN    8
                           MOVE    1           TO  WRK-HKTKBN81
                       WHEN    9
                           MOVE    1           TO  WRK-HKTKBN82
                   END-EVALUATE
               END-IF
           END-PERFORM
      *
           IF      ORCSCHKTCHK-SYORI   =   "1"
      *        入力項目
               PERFORM 20021-INPUT-CHK-SEC
           ELSE
      *        自動発生
               PERFORM 30021-AUTO-CHK-SEC
           END-IF
           .
       2002-HKTSANTEI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力項目包括診療コードチェック処理
      *****************************************************************
       20021-INPUT-CHK-SEC            SECTION.
      *
      *    診療区分による包括
           PERFORM VARYING     IDX-Z   FROM    1   BY  1
                   UNTIL      (IDX-Z       >   SPA-GMN-MAX  )
               IF     (SPA-COM-HKNCOMBI (IDX-Z)    =   "9999")
                   OR (SPA-COM-HOUKATU-FLG(IDX-Z)  =   1     )
                   OR (SPA-COM-HOUKATU-ERR(IDX-Z)  =   1     )
                   OR (SPA-GMN-INPUTCD (IDX-Z)(1:1)
                                                   =   "#"
                                                   OR  "$"
                                                   OR  "*"   )
                   CONTINUE
               ELSE
      *            剤点数がある剤のみ
                   IF     (SPA-COM-ZAIEND (IDX-Z)  =   "1" )  AND
                          (SPA-COM-TENSU  (IDX-Z)  >   ZERO)
                       PERFORM 20022-SRYKBN-CHECK-SEC
                   END-IF
               END-IF
           END-PERFORM
      *
      *    包括診療コードチェック
           PERFORM VARYING     IDX-Z   FROM    1   BY  1
                   UNTIL      (IDX-Z       >   SPA-GMN-MAX  )
               IF     (SPA-COM-HKNCOMBI (IDX-Z)    =   "9999")
                   OR (SPA-COM-HOUKATU-FLG(IDX-Z)  =   1     )
                   OR (SPA-COM-HOUKATU-ERR(IDX-Z)  =   1     )
                   OR (SPA-GMN-INPUTCD (IDX-Z)(1:1)
                                                   =   "#"
                                                   OR  "$"
                                                   OR  "*"   )
                   CONTINUE
               ELSE
                   IF      SPA-COM-INPUTCD (IDX-Z)(1:1) =   "1"
                       MOVE    SPA-COM-INPUTCD (IDX-Z)  TO  WRK-SRYCD
                       PERFORM 20021-SRYCD-CHECK-SEC
                   END-IF
               END-IF
           END-PERFORM
           .
       20021-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    包括診療コードチェック処理
      *****************************************************************
       20021-SRYCD-CHECK-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-CHK2
           MOVE    ZERO                TO  FLG-CHK3
           PERFORM VARYING     IDX-H    FROM    1   BY  1
                   UNTIL      (IDX-H    >  600   )  OR
                              (TBL-HKTSRYCD(IDX-H) =   SPACE)
               IF      WRK-SRYCD           =   TBL-HKTSRYCD (IDX-H)
                   MOVE    1               TO  FLG-CHK2
                   IF      TBL-SANTEIKBN (IDX-H)   =   "1"
                       MOVE    2               TO  FLG-CHK2
                   END-IF
                   IF      TBL-KENTAIKBN (IDX-H)    =   "1"
                       MOVE    1               TO  FLG-CHK3
                   END-IF
                   MOVE    600             TO  IDX-H
               END-IF
           END-PERFORM
      *
      *    外来診療料で上の行が検体コード尿の場合のみ対象
           IF      FLG-CHK3            =   1
               IF    (TBL-KANRICD (IDX)    =   "001")  AND
                     (FLG-CHK2             =   1    )
                   IF     (IDX-Z               >   1  )  AND
                          (SPA-COM-INPUTCD (IDX-Z - 1 )
                                               =   "160138910" )
                       MOVE    1               TO  FLG-CHK2
                   ELSE
                       MOVE    ZERO            TO  FLG-CHK2
                   END-IF
               ELSE
                   MOVE    ZERO                TO  FLG-CHK3
               END-IF
           END-IF
      *
      *    包括コード
           IF      FLG-CHK2            =   1
               IF      TBL-SANTEI-HOU (IDX)    =   "1"
      *            会計データ作成
                   MOVE    1           TO  SPA-COM-HOUKATU-FLG(IDX-Z)
               ELSE
      *            エラー
                   MOVE    1           TO  SPA-COM-HOUKATU-ERR(IDX-Z)
               END-IF
           END-IF
      *
           IF      FLG-CHK2            =   2
               MOVE    ZERO            TO  SPA-COM-HOUKATU-FLG(IDX-Z)
               MOVE    ZERO            TO  SPA-COM-HOUKATU-ERR(IDX-Z)
      *        加算の場合
               IF     (SPA-COM-DATAKBN (IDX-Z)     =   "2" )
                  AND (SPA-COM-AUTOKBN (IDX-Z) NOT =   "2" )
                   MOVE    1           TO  SPA-COM-HOUKATU-FLG2(IDX-Z)
               END-IF
           END-IF
      *
           .
       20021-SRYCD-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療区分による包括処理
      *****************************************************************
       20022-SRYKBN-CHECK-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-CHK3
           EVALUATE    SPA-COM-SRYKBN (IDX-Z)(1:1)
      *        投薬
               WHEN    "2"
                   IF      SPA-NYUGAIKBN       =   "1"
      *                入院
                       IF      WRK-HKTKBN20    =   1
                           MOVE    1           TO  FLG-CHK3
                       END-IF
                   ELSE
      *                外来
                       PERFORM 200221-SRYSYUKBN-HEN-SEC
                   END-IF
               WHEN    "3"
                   IF      WRK-HKTKBN30    =   1
                       MOVE    1           TO  FLG-CHK3
                   END-IF
               WHEN    "4"
                   IF      WRK-HKTKBN40    =   1
                       MOVE    1           TO  FLG-CHK3
                   END-IF
               WHEN    "5"
                   IF      WRK-HKTKBN50    =   1
                       MOVE    1           TO  FLG-CHK3
                   END-IF
               WHEN    "6"
                   IF      WRK-HKTKBN60    =   1
                       MOVE    1           TO  FLG-CHK3
                   END-IF
               WHEN    "7"
                   IF      WRK-HKTKBN70    =   1
                       MOVE    1           TO  FLG-CHK3
                   END-IF
               WHEN    "8"
                   IF      SPA-COM-SRYSYUKBN (IDX-Z)   =   "800"
                       IF      WRK-HKTKBN80    =   1
                           MOVE    1           TO  FLG-CHK3
                       END-IF
                   END-IF
                   IF      SPA-COM-SRYSYUKBN (IDX-Z)   =   "810"
                       IF      WRK-HKTKBN81    =   1
                           MOVE    1           TO  FLG-CHK3
                       END-IF
                   END-IF
                   IF      SPA-COM-SRYSYUKBN (IDX-Z)   =   "820"
                       IF      WRK-HKTKBN82    =   1
                           MOVE    1           TO  FLG-CHK3
                       END-IF
                   END-IF
           END-EVALUATE
      *    包括コード
           IF      FLG-CHK3            =   1
      *        剤をすべて
               PERFORM VARYING     IDX-Z2  FROM    IDX-Z  BY  -1
                       UNTIL      (IDX-Z2  <   1   )
                   IF     (IDX-Z           NOT =   IDX-Z2  )  AND
                          (SPA-COM-ZAIEND (IDX-Z2) =   "1" )
                       MOVE    1                   TO  IDX-Z2
                   ELSE
                       IF      TBL-SANTEI-HOU (IDX)    =   "1"
      *                会計データ作成
                           MOVE    1           TO  SPA-COM-HOUKATU-FLG
                                                           (IDX-Z)
                       ELSE
      *                エラー
                          MOVE    1           TO  SPA-COM-HOUKATU-ERR
                                                            (IDX-Z)
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
           .
       20022-SRYKBN-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    外来の投薬包括処理
      *****************************************************************
       200221-SRYSYUKBN-HEN-SEC         SECTION.
      *
           IF      SPA-COM-SRYSYUKBN(IDX-Z)    =   SPACE
                                               OR  "210"
                                               OR  "220"
                                               OR  "230"
                                               OR  "211"
                                               OR  "221"
                                               OR  "231"
      *        診療種別を包括剤に変更する
               PERFORM VARYING     IDX-Z2  FROM    IDX-Z  BY  -1
                       UNTIL      (IDX-Z2  <   1   )
                   IF     (IDX-Z           NOT =   IDX-Z2  )  AND
                          (SPA-COM-ZAIEND (IDX-Z2) =   "1" )
                       MOVE    1                   TO  IDX-Z2
                   ELSE
                       IF      SPA-GMN-INPUTCD (IDX)(1:1)  =   "."
                           MOVE    "3"             TO  SPA-GMN-INPUTCD
                                                        (IDX)(4:1)
                       END-IF
                       MOVE    "3"                 TO  SPA-COM-SRYSYUKBN
                                                        (IDX)(3:1)
                   END-IF
               END-PERFORM
           ELSE
               MOVE    1                   TO  FLG-CHK3
           END-IF
           .
       200221-SRYSYUKBN-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    自動発生分のみ処理
      *****************************************************************
       300-AUTO-SYORI-SEC         SECTION.
      *
      *    包括チェック判定
           PERFORM 2001-TAISYOU-CHK-SEC
      *
           .
       300-AUTO-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    自動発生チェック処理
      *****************************************************************
       30021-AUTO-CHK-SEC         SECTION.
      *
           PERFORM VARYING     IDX-L1  FROM    1   BY  1
                   UNTIL      (IDX-L1      >   10  )
               PERFORM VARYING     IDX-L2      FROM    1   BY  1
                       UNTIL      (IDX-L2      >   30      )
                   IF      LNK-ORCSC-SRYCD (IDX-L1 IDX-L2)
                                           NOT = SPACE
      *                診療区分による包括
                       PERFORM 30022-SRYKBN-CHECK-SEC
      *
                       MOVE    LNK-ORCSC-SRYCD (IDX-L1 IDX-L2)
                                                   TO  WRK-SRYCD
                       PERFORM 30021-SRYCD-CHECK-SEC
                   END-IF
               END-PERFORM
           END-PERFORM
           .
       3002-AUTO-HKTSANTEI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療区分による包括処理
      *****************************************************************
       30022-SRYKBN-CHECK-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-CHK3
           EVALUATE    LNK-ORCSC-SRYKBN (IDX-L1 IDX-L2)(1:1)
      *?       投薬（外来はチェックなし）
      *        WHEN    "2"
      *            IF      WRK-HKTKBN20    =   1
      *                MOVE    1           TO  FLG-CHK3
      *?           END-IF
               WHEN    "3"
                   IF      WRK-HKTKBN30    =   1
                       MOVE    1           TO  FLG-CHK3
                   END-IF
               WHEN    "4"
                   IF      WRK-HKTKBN40    =   1
                       MOVE    1           TO  FLG-CHK3
                   END-IF
               WHEN    "5"
                   IF      WRK-HKTKBN50    =   1
                       MOVE    1           TO  FLG-CHK3
                   END-IF
               WHEN    "6"
                   IF      WRK-HKTKBN60    =   1
                       MOVE    1           TO  FLG-CHK3
                   END-IF
               WHEN    "7"
                   IF      WRK-HKTKBN70    =   1
                       MOVE    1           TO  FLG-CHK3
                   END-IF
               WHEN    "8"
                   IF      SPA-COM-SRYSYUKBN (IDX-Z)   =   "800"
                       IF      WRK-HKTKBN80    =   1
                           MOVE    1           TO  FLG-CHK3
                       END-IF
                   END-IF
                   IF      SPA-COM-SRYSYUKBN (IDX-Z)   =   "810"
                       IF      WRK-HKTKBN81    =   1
                           MOVE    1           TO  FLG-CHK3
                       END-IF
                   END-IF
                   IF      SPA-COM-SRYSYUKBN (IDX-Z)   =   "820"
                       IF      WRK-HKTKBN82    =   1
                           MOVE    1           TO  FLG-CHK3
                       END-IF
                   END-IF
           END-EVALUATE
      *
           .
       30022-SRYKBN-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療区分による包括処理
      *****************************************************************
       30021-SRYCD-CHECK-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-CHK2
           MOVE    ZERO                TO  FLG-CHK3
           PERFORM VARYING     IDX-H    FROM    1   BY  1
                   UNTIL      (IDX-H    >  600   )  OR
                              (TBL-HKTSRYCD(IDX-H) =   SPACE)
               IF      WRK-SRYCD           =   TBL-HKTSRYCD (IDX-H)
                   MOVE    1               TO  FLG-CHK2
                   IF      TBL-SANTEIKBN (IDX-H)   =   "1"
                       MOVE    2               TO  FLG-CHK2
                   END-IF
                   IF      TBL-KENTAIKBN (IDX-H)    =   "1"
                       MOVE    1               TO  FLG-CHK3
                   END-IF
                   MOVE    600             TO  IDX-H
               END-IF
           END-PERFORM
      *
      *    外来診療料で上の行が検体コード尿の場合のみ対象
           IF      FLG-CHK3            =   1
               IF    (TBL-KANRICD (IDX)    =   "001")  AND
                     (FLG-CHK2             =   1    )
                   IF     (IDX-Z               >   1  )  AND
                          (SPA-COM-INPUTCD (IDX-Z - 1 )
                                               =   "160138910" )
                       MOVE    1               TO  FLG-CHK2
                   ELSE
                       MOVE    ZERO            TO  FLG-CHK2
                   END-IF
               ELSE
                   MOVE    ZERO                TO  FLG-CHK3
               END-IF
           END-IF
      *
      *    包括コード
           IF      FLG-CHK2            =   2
      *        包括対象外
               CONTINUE
           ELSE
      *        診療区分のエラーはすべて削除
               IF     (FLG-CHK3            =   1  )
      *            エラー（削除）
                   MOVE    SPACE       TO  LNK-ORCSC-SRYCD
                                                  (IDX-L1 IDX-L2)
               END-IF
               IF     (FLG-CHK2            =   1  )
                   IF      TBL-SANTEI-HOU (IDX)    =   "1"
      *                会計データ作成
                       MOVE    1           TO  LNK-ORCSC-HKTKBN 
                                                  (IDX-L1 IDX-L2)
                   ELSE
      *                エラー（削除）
                       MOVE    SPACE       TO  LNK-ORCSC-SRYCD
                                                  (IDX-L1 IDX-L2)
                   END-IF
               END-IF
           END-IF
           .
       30021-SRYCD-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラー削除処理
      *****************************************************************
       400-ERR-DELETE-SEC         SECTION.
      *
           PERFORM VARYING     IDX-Z   FROM    1   BY  1
                   UNTIL      (IDX-Z       >   200     )   OR
                             ((SPA-GMN-INPUTCD (IDX-Z) =   SPACE ) AND
                              (SPA-COM-INPUTCD (IDX-Z) =   SPACE ))
               IF     (SPA-COM-HOUKATU-ERR (IDX-Z) =   1  )
                   MOVE    SPACE           TO  SPA-GMN-INPUTCD (IDX-Z)
               END-IF
           END-PERFORM
      *    診療種別だけの剤は削除
           PERFORM VARYING     IDX-Z   FROM    1   BY  1
                   UNTIL      (IDX-Z       >   200     )   OR
                             ((SPA-GMN-INPUTCD (IDX-Z) =   SPACE ) AND
                              (SPA-COM-INPUTCD (IDX-Z) =   SPACE ))
               IF     (SPA-GMN-INPUTCD (IDX-Z) (1:1)   =   "." )
                   COMPUTE IDX-Z3              =   IDX-Z   +  1
                   MOVE    ZERO                TO  FLG-ZAIARI
                   PERFORM VARYING     IDX-Z2  FROM    IDX-Z3  BY  1
                           UNTIL      (IDX-Z2      >   200     )
                       IF      (SPA-GMN-INPUTCD (IDX-Z2)(1:1)
                                                   NOT =   "." ) AND
                               (SPA-GMN-INPUTCD (IDX-Z2) NOT =   SPACE)
                           MOVE    1               TO  FLG-ZAIARI
                       END-IF
                       IF      (SPA-COM-ZAIEND (IDX-Z2)    =   "1"  )
                           MOVE    200             TO  IDX-Z2
                       END-IF
                   END-PERFORM
                   IF      FLG-ZAIARI          =   ZERO
                       MOVE    SPACE       TO  SPA-GMN-INPUTCD (IDX-Z)
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       400-ERR-DELETE-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理読み込み
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    包括診療コード読み込み
      *****************************************************************
       910-HKTSRYCD-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  HKTSRYCD-REC
               MOVE    ZERO            TO  FLG-HKTSRYCD
           ELSE
               INITIALIZE                  HKTSRYCD-REC
               MOVE    1               TO  FLG-HKTSRYCD
           END-IF
      *
           .
       910-HKTSRYCD-READ-EXT.
           EXIT.
      *****************************************************************
      *    包括診療コード読み込み
      *****************************************************************
       910-HKTSANTEI-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  HKTSANTEI-REC
               MOVE    ZERO            TO  FLG-HKTSANTEI
           ELSE
               INITIALIZE                  HKTSANTEI-REC
               MOVE    1               TO  FLG-HKTSANTEI
           END-IF
      *
           .
       910-HKTSANTEI-READ-EXT.
           EXIT.
      *****************************************************************
      *    算定履歴読み込み
      *****************************************************************
       920-SANTEI-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SANTEI-REC
               MOVE    ZERO            TO  FLG-SANTEI
           ELSE
               INITIALIZE                  SANTEI-REC
               MOVE    1               TO  FLG-SANTEI
           END-IF
      *
           .
       920-SANTEI-READ-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       920-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       920-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクロース処理
      *****************************************************************
       990-DBCLOSE-SEC         SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       990-DBCLOSE-EXT.
           EXIT.
      *
