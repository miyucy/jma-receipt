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
       PROGRAM-ID.             ORCGX03.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : チェックマスタ情報設定
      *  コンポーネント名  : チェック項目複写
      *  管理者            : 
      *  04/02/27    NACL-太田    新規作成
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
       DATA                    DIVISION.
       FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    画面活性非活性
           COPY    "ENUM-VALUE".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    チェックマスタ設定用共通パラメタ
           COPY    "X01COMMON-SPA".
      *
      *    第一画面ＳＰＡエリア
           COPY    "X01SCR-SPA".
      *
       01  CNT-AREA.
           03  CNT-SELCHKLST               PIC 9(05).
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                     PIC 9(01).
           03  FLG-HIT                     PIC 9(01).
           03  FLG-CHK                     PIC 9(01).
           03  FLG-CHKSND                  PIC 9(01).
           03  FLG-TENSU                   PIC 9(01).
           03  FLG-HIZUKE-ERR              PIC 9(01).
           03  FLG-ENTRYCHK                PIC 9(01).
           03  FLG-SRYCD-DEL               PIC 9(01).
           03  FLG-OK                      PIC 9(01).
           03  FLG-LCHKLST-ROW             PIC 9(01).
           03  FLG-RCHKLST-ROW             PIC 9(01).
           03  FLG-SELCHKLST-ROW           PIC 9(01).
           03  FLG-MEDYAKKO                PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                        PIC 9(05).
           03  IDX1                        PIC 9(05).
           03  IDX2                        PIC 9(05).
           03  IDX3                        PIC 9(05).
           03  IDX4                        PIC 9(05).
           03  IDX5                        PIC 9(05).
           03  IDX6                        PIC 9(05).
           03  IDX7                        PIC 9(05).
           03  IDXA                        PIC 9(05).
           03  IDX-CMB                     PIC 9(05).
           03  IDX-LST                     PIC 9(05).
      *
       01  WRK-AREA.
           03  WRK-MCP-WIDGET              PIC X(64).
           03  WRK-YMD                     PIC X(10).
           03  WRK-SYMD                    PIC X(08).
           03  WRK-HENYMDG                 PIC X(10).
           03  WRK-CMB-CD                  PIC X(10).
           03  WRK-CMB-ITM-G.
               07  WRK-CMB-ITM             PIC X(200).
           03  WRK-ZZZZ                    PIC ZZZZ.
           03  WRK-SRYCD                   PIC X(09).
           03  WRK-SKIP-MAX                PIC 9(05).
           03  WRK-KJNYMD-MOT              PIC X(08).
           03  WRK-KANACHK-MAE-INPUT       PIC X(400).
           03  WRK-KANACHK-OUT-INPUT       PIC X(400).
           03  WRK-RCHKLST-SRYCD           PIC X(09).
           03  WRK-TNS-NAME                PIC X(70).
           03  WRK-CHK-CD                  PIC X(09).
           03  WRK-NAME                    PIC X(70).
           03  WRK-KEY-CD-G.
               05  WRK-KEY-CD-OCC          OCCURS  21.
                   07  WRK-KEY-CD          PIC X(07).
                   07  WRK-KEY-CDSEP       PIC X(01).
      *
       01  WRK-LCHKLST-AREA.
           03  WRK-LCHKLST-MAX             PIC 9(05).
           03  WRK-LCHKLST-OCC             OCCURS   100.
               05  WRK-LCHKLST-NAME        PIC X(100).
               05  WRK-LCHKLST-SRYCD       PIC X(09).
               05  WRK-LCHKLST-JYKN        PIC X(01).
               05  WRK-LCHKLST-BYOCD       PIC X(07)
                                           OCCURS   21.
               05  WRK-LCHKLST-BYOSTATUS   PIC X(01).
      *
       01  WRK-ROW-AREA.
           03  WRK-LCHKLST-ROW             PIC S9(9)   BINARY.
           03  WRK-RCHKLST-ROW             PIC S9(9)   BINARY.
           03  WRK-SELCHKLST-ROW           PIC S9(9)   BINARY.
      *
       01  CONST-AREA.
           03  CONST-MKCD-MAX              PIC 9(05)   VALUE   21.
           03  CONST-SELCHKLST-MAX         PIC 9(05)   VALUE   50.
           03  CONST-CHKLST-MAX            PIC 9(05)   VALUE   100.
           03  CONST-JYKN-MAX              PIC 9(05)   VALUE   4.
           03  CONST-JYKN-VAL.
               05                          PIC X(01)   VALUE   "1".
               05                          PIC X(04)   VALUE   "部分".
               05                          PIC X(01)   VALUE   "2".
               05                          PIC X(04)   VALUE   "完全".
               05                          PIC X(01)   VALUE   "3".
               05                          PIC X(04)   VALUE   "前方".
               05                          PIC X(01)   VALUE   "4".
               05                          PIC X(04)   VALUE   "後方".
           03  CONST-JYKN-R                REDEFINES   CONST-JYKN-VAL.
               05  CONST-JYKN-OCC          OCCURS  4.
                   07  CONST-JYKN-CD       PIC X(01).
                   07  CONST-JYKN-MEI      PIC X(04).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *    チェック
       01  CHK-REC.
           COPY    "CPCHK.INC".
      *
      *    チェック２
       01  CHKSND-REC.
           COPY    "CPCHKSND.INC".
      *
      *    薬効マスター
       01  MEDYAKKO-REC.
           COPY    "CPMEDYAKKO.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "ORCA-DBPATH".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "X01.INC".
           COPY    "X02.INC".
           COPY    "X03.INC".
           COPY    "X04.INC".
           COPY    "X91.INC".
           COPY    "X97.INC".
           COPY    "X98.INC". 
           COPY    "XERR.INC".
           COPY    "XID1.INC".
           COPY    "XID2.INC".
      *
       PROCEDURE                                 DIVISION    USING
                                                 MCPAREA
                                                 SPAAREA
                                                 LINKAREA
                                                 SCRAREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  CNT-AREA
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA.
           MOVE    SPA-WORK        TO  SPA-X01KYOUTU
           MOVE    SPA-FREE        TO  SPA-X01FREE
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS  ALSO    MCP-EVENT
           WHEN    "LINK"          ALSO    ANY
               PERFORM 100-INIT-SEC
      *    画面遷移
           WHEN     "PUTG"         ALSO    "CLICKED"
               PERFORM 200-GMNSENI
      *    入力
           WHEN      OTHER
               PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF    ( FLG-END         =   ZERO )
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-X01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-X01FREE     TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
      *    エラー画面より
           IF    ( SPA-MOTOPG          =   "XERR" )
               MOVE    SPACE       TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF    ( FLG-END     =   1 )
                   GO  TO  100-INIT-EXT
               END-IF
      *
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
      ***  MOVE    "NEW"           TO  MCP-PUTTYPE.
           MOVE    SPACE           TO  MCP-PUTTYPE.
           MOVE    "X03"           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1               TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
      *    他のＬＤより
           IF    ( LINKAREA        NOT =   SPACE )
               MOVE    LNK-KYOUTU      TO  SPA-KYOUTU
      *
               MOVE    SPA-MOTOPG      TO  SPA-MOTOPG2
      *
               MOVE    SPACE           TO  SPA-XID1-FLG
               MOVE    SPACE           TO  SPA-XIDCD
           END-IF
      *
      *    EVALUATE    SPA-MOTOPG
      *    WHEN    "xxx"
      *        GO  TO      300-SCREEN-EXT
      *    END-EVALUATE
      *
           PERFORM 310-SPASET-SEC
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC                  SECTION.
      *
           MOVE    1                   TO  FLG-LCHKLST-ROW
      *
      *    ※画面のINITIALIZE,左側のコラムリストの設定は呼出元で行う
      *
           MOVE    SPA-X01-KJNYMD      TO  SPA-X03-NAI-KJNYMD
           MOVE    SPA-X03-NAI-KJNYMD  TO  WRK-YMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  SPA-X03-GMN-KJNYMD
      *
      *    コンボ項目設定処理
           PERFORM 3101-COMBO-SET-SEC
      *
      *    選択用チェック区分コンボ初期値設定
           MOVE    SPA-X01-CHKKBN      TO  WRK-CMB-CD
           PERFORM 4200-CHKKBNLST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-X03-GMN-CHKKBN-G
      *
           MOVE    SPACE               TO  SPA-X03-GMN-SELNAME
      *
           MOVE    1                   TO  SPA-X03-GMN-PAGE
      *
      *    チェック項目リスト編集処理
           PERFORM 3101-SELCHKLST-HEN-SEC
      *
           MOVE    2                   TO  SPA-X03-GMN-CUR
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    コンボ項目設定処理
      *****************************************************************
       3101-COMBO-SET-SEC              SECTION.
      *
      *    選択用チェック区分コンボ設定処理
           PERFORM 3101-CHKKBNLST-SET-SEC
      *
           . 
       3101-CMB-DAT-SET-EXT.
           EXIT.
      *****************************************************************
      *    選択用チェック区分コンボ設定処理
      *****************************************************************
       3101-CHKKBNLST-SET-SEC          SECTION.
      *
           INITIALIZE                      SPA-X03-GMN-CHKKBNLST-G
      *
           EVALUATE    SPA-X01-CHKKBN
           WHEN    "1"
      *
      *?       MOVE    3                   TO  SPA-X03-GMN-CHKKBN-MAX
      *
      *?       MOVE    "1"                 TO  SPA-X03-GMN-CHKKBNL   (1)
      *?       MOVE    "薬剤と病名"        TO  SPA-X03-GMN-CHKKBNMEIL(1)
      *?       MOVE    "2"                 TO  SPA-X03-GMN-CHKKBNL   (2)
      *?       MOVE    "診療行為と病名"    TO  SPA-X03-GMN-CHKKBNMEIL(2)
      *?       MOVE    "M"                 TO  SPA-X03-GMN-CHKKBNL   (3)
      *?       MOVE    "薬効"              TO  SPA-X03-GMN-CHKKBNMEIL(3)
           WHEN    "2"
      *
               MOVE    2                   TO  SPA-X03-GMN-CHKKBN-MAX
      *
               MOVE    "1"                 TO  SPA-X03-GMN-CHKKBNL   (1)
               MOVE    "薬剤と病名"        TO  SPA-X03-GMN-CHKKBNMEIL(1)
               MOVE    "2"                 TO  SPA-X03-GMN-CHKKBNL   (2)
               MOVE    "診療行為と病名"    TO  SPA-X03-GMN-CHKKBNMEIL(2)
           WHEN    "4"
      *
               MOVE    1                   TO  SPA-X03-GMN-CHKKBN-MAX
      *
               MOVE    "4"                 TO  SPA-X03-GMN-CHKKBNL   (1)
               MOVE    "薬剤と併用禁忌"    TO  SPA-X03-GMN-CHKKBNMEIL(1)
           WHEN    "5"
      *
               MOVE    1                   TO  SPA-X03-GMN-CHKKBN-MAX
      *
               MOVE    "5"                 TO  SPA-X03-GMN-CHKKBNL   (1)
               MOVE    "診療行為の併用算定"
                                           TO  SPA-X03-GMN-CHKKBNMEIL(1)
           END-EVALUATE
      *
           . 
       3101-CHKKBNLST-SET-EXT.
           EXIT.
      *****************************************************************
      *    チェック項目リスト編集処理
      *****************************************************************
       3101-SELCHKLST-HEN-SEC          SECTION.
      *
           EVALUATE    SPA-X03-GMN-CHKKBN
           WHEN    "1"
           WHEN    "2"
               PERFORM 3101-SELCHKLST-CHKSND-SEC
           WHEN    "M"
               IF    ( SPA-X03-GMN-SELNAME =   SPACE )
                   INITIALIZE              SPA-X03-GMN-SELCHKLST
                                           SPA-X03-NAI-SELCHKLST
                                           SPA-X03-GMN-NEXT
               ELSE
                   PERFORM 3101-SELCHKLST-MEDYAK-SEC
               END-IF
           WHEN    OTHER
               PERFORM 3101-SELCHKLST-CHKMST-SEC
           END-EVALUATE
      *
           . 
       3101-SELCHKLST-HEN-EXT.
           EXIT.
      *****************************************************************
      *    チェック項目リスト編集処理（チェックマスタより）
      *****************************************************************
       3101-SELCHKLST-CHKMST-SEC       SECTION.
      *
           MOVE    1                   TO  FLG-SELCHKLST-ROW
      *
           INITIALIZE                  SPA-X03-GMN-SELCHKLST
                                       SPA-X03-NAI-SELCHKLST
      *
           MOVE    ZERO                TO  CNT-SELCHKLST
      *
      *    チェックマスタ検索
           PERFORM 900-CHK-KEY11-SEL-SEC
           IF    ( FLG-CHK         =   ZERO )
               PERFORM 900-CHK-KEY11-FET-SEC
               IF    ( FLG-CHK     =   ZERO )
                   COMPUTE CNT-SELCHKLST = CNT-SELCHKLST   +   1
               END-IF
           END-IF
      *
      *    読込スキップ処理
           PERFORM 3101-SELCHKLST-SKIP-SEC
      *
           PERFORM UNTIL ( FLG-CHK     NOT =   ZERO )
                    OR   ( SPA-X03-GMN-SELCHKLST-MAX
                                          >= CONST-SELCHKLST-MAX )
      *
               COMPUTE SPA-X03-GMN-SELCHKLST-MAX
                   =   SPA-X03-GMN-SELCHKLST-MAX   +   1
      *
               MOVE    SPA-X03-GMN-SELCHKLST-MAX
                                       TO  IDX-LST
      *
               MOVE    CNT-SELCHKLST   TO  SPA-X03-GMN-TSEL-CHKNUM
                                                               (IDX-LST)
      *
               MOVE    CHK-SRYCD       TO  WRK-SRYCD
               MOVE    SPA-X03-NAI-KJNYMD
                                       TO  WRK-YMD
               PERFORM 900-TENSU-KEY-SEL-SEC
               IF     (TNS-SRYCD(1:1)      =   "1") AND
                      (TNS-ROUTEKKBN       =   2  )
                   MOVE    SPACE           TO  SPA-X03-GMN-TSEL-NAME
                                                               (IDX-LST)
                   STRING  "［老］"        DELIMITED   BY  SIZE
                           TNS-NAME        DELIMITED   BY  SIZE
                   INTO    SPA-X03-GMN-TSEL-NAME (IDX-LST)
                   END-STRING
               ELSE
                   MOVE    TNS-NAME        TO  SPA-X03-GMN-TSEL-NAME
                                                               (IDX-LST)
               END-IF
      *
               MOVE    CHK-YUKOSTYMD   TO  SPA-X03-NAI-TSEL-YUKOSTYMD
                                                               (IDX-LST)
               IF    ( CHK-YUKOSTYMD   =   "00000000" )
                   MOVE    CHK-YUKOSTYMD
                                       TO  SPA-X03-GMN-TSEL-YUKOSTYMD
                                                           (IDX-LST)
               ELSE
                   MOVE    CHK-YUKOSTYMD
                                       TO  WRK-YMD
                   PERFORM 800-SEIWA-HEN-SEC
                   MOVE    WRK-HENYMDG TO  SPA-X03-GMN-TSEL-YUKOSTYMD
                                                           (IDX-LST)
               END-IF
      *
               MOVE    CHK-YUKOEDYMD   TO  SPA-X03-NAI-TSEL-YUKOEDYMD
                                                               (IDX-LST)
               IF    ( CHK-YUKOEDYMD   =   "99999999" )
                   MOVE    CHK-YUKOEDYMD
                                       TO  SPA-X03-GMN-TSEL-YUKOEDYMD
                                                           (IDX-LST)
               ELSE
                   MOVE    CHK-YUKOEDYMD
                                       TO  WRK-YMD
                   PERFORM 800-SEIWA-HEN-SEC
                   MOVE    WRK-HENYMDG TO  SPA-X03-GMN-TSEL-YUKOEDYMD
                                                           (IDX-LST)
               END-IF
      *
               MOVE    CHK-SRYCD       TO  SPA-X03-NAI-TSEL-SRYCD
                                                               (IDX-LST)
      *
      *        チェックマスタ読込処理
               PERFORM 900-CHK-KEY11-FET-SEC
               IF    ( FLG-CHK     =   ZERO )
                   COMPUTE CNT-SELCHKLST = CNT-SELCHKLST   +   1
               END-IF
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-CHK-KEY11  TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( FLG-CHK             =   ZERO )
               MOVE    1               TO  SPA-X03-GMN-NEXT
           ELSE
               MOVE    ZERO            TO  SPA-X03-GMN-NEXT
           END-IF
      *
           . 
       3101-SELCHKLST-CHKMST-EXT.
           EXIT.
      *****************************************************************
      *    チェック項目リスト編集処理（チェックマスタ２より）
      *****************************************************************
       3101-SELCHKLST-CHKSND-SEC       SECTION.
      *
           MOVE    1                   TO  FLG-SELCHKLST-ROW
      *
           INITIALIZE                  SPA-X03-GMN-SELCHKLST
                                       SPA-X03-NAI-SELCHKLST
      *
           MOVE    ZERO                TO  CNT-SELCHKLST
      *
      *    チェックマスタ検索
           PERFORM 900-CHKSND-KEY11-SEL-SEC
           IF    ( FLG-CHKSND         =   ZERO )
               PERFORM 900-CHKSND-KEY11-FET-SEC
               IF    ( FLG-CHKSND     =   ZERO )
                   COMPUTE CNT-SELCHKLST  = CNT-SELCHKLST   +   1
               END-IF
           END-IF
      *
      *    読込スキップ処理
           PERFORM 3101-SELCHKLST-SKIP-SEC
      *
           PERFORM UNTIL ( FLG-CHKSND      NOT =   ZERO )
                    OR   ( SPA-X03-GMN-SELCHKLST-MAX
                                          >= CONST-SELCHKLST-MAX )
      *
               COMPUTE SPA-X03-GMN-SELCHKLST-MAX
                   =   SPA-X03-GMN-SELCHKLST-MAX   +   1
      *
               MOVE    SPA-X03-GMN-SELCHKLST-MAX
                                       TO  IDX-LST
      *
               MOVE    CNT-SELCHKLST   TO  SPA-X03-GMN-TSEL-CHKNUM
                                                               (IDX-LST)
      *
               MOVE    CHKSND-SRYCD    TO  WRK-SRYCD
               MOVE    SPA-X03-NAI-KJNYMD
                                       TO  WRK-YMD
               PERFORM 900-TENSU-KEY-SEL-SEC
               IF     (TNS-SRYCD(1:1)      =   "1") AND
                      (TNS-ROUTEKKBN       =   2  )
                   MOVE    SPACE       TO  SPA-X03-GMN-TSEL-NAME
                                                               (IDX-LST)
                   STRING  "［老］"        DELIMITED   BY  SIZE
                           TNS-NAME        DELIMITED   BY  SIZE
                   INTO    SPA-X03-GMN-TSEL-NAME (IDX-LST)
                   END-STRING
               ELSE
                   MOVE    TNS-NAME    TO  SPA-X03-GMN-TSEL-NAME
                                                               (IDX-LST)
               END-IF
      *
               MOVE    CHKSND-YUKOSTYMD
                                       TO  SPA-X03-NAI-TSEL-YUKOSTYMD
                                                               (IDX-LST)
               IF    ( CHKSND-YUKOSTYMD   =   "00000000" )
                   MOVE    CHKSND-YUKOSTYMD
                                       TO  SPA-X03-GMN-TSEL-YUKOSTYMD
                                                           (IDX-LST)
               ELSE
                   MOVE    CHKSND-YUKOSTYMD
                                       TO  WRK-YMD
                   PERFORM 800-SEIWA-HEN-SEC
                   MOVE    WRK-HENYMDG TO  SPA-X03-GMN-TSEL-YUKOSTYMD
                                                           (IDX-LST)
               END-IF
      *
               MOVE    CHKSND-YUKOEDYMD
                                       TO  SPA-X03-NAI-TSEL-YUKOEDYMD
                                                               (IDX-LST)
               IF    ( CHKSND-YUKOEDYMD   =   "99999999" )
                   MOVE    CHKSND-YUKOEDYMD
                                       TO  SPA-X03-GMN-TSEL-YUKOEDYMD
                                                           (IDX-LST)
               ELSE
                   MOVE    CHKSND-YUKOEDYMD
                                       TO  WRK-YMD
                   PERFORM 800-SEIWA-HEN-SEC
                   MOVE    WRK-HENYMDG TO  SPA-X03-GMN-TSEL-YUKOEDYMD
                                                           (IDX-LST)
               END-IF
      *
               MOVE    CHKSND-SRYCD    TO  SPA-X03-NAI-TSEL-SRYCD
                                                           (IDX-LST)
      *
      *        チェックマスタ読込処理
               PERFORM 900-CHKSND-KEY11-FET-SEC
               IF    ( FLG-CHKSND     =    ZERO )
                   COMPUTE CNT-SELCHKLST   = CNT-SELCHKLST   +   1
               END-IF
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-CHKSND-KEY11  TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( FLG-CHKSND              =   ZERO )
               MOVE    1               TO  SPA-X03-GMN-NEXT
           ELSE
               MOVE    ZERO            TO  SPA-X03-GMN-NEXT
           END-IF
      *
           . 
       3101-SELCHKLST-CHKSND-EXT.
           EXIT.
      *****************************************************************
      *    チェック項目リスト編集処理（薬効マスタより）
      *****************************************************************
       3101-SELCHKLST-MEDYAK-SEC       SECTION.
      *
           MOVE    1                   TO  FLG-SELCHKLST-ROW
      *
           INITIALIZE                  SPA-X03-GMN-SELCHKLST
                                       SPA-X03-NAI-SELCHKLST
      *
           MOVE    ZERO                TO  CNT-SELCHKLST
      *
      *    薬効マスタ検索
           PERFORM 900-MEDYAKKO-KEY4-SEL-SEC
           IF    ( FLG-MEDYAKKO        =   ZERO )
               PERFORM 900-MEDYAKKO-KEY4-FET-SEC
               IF    ( FLG-MEDYAKKO    =   ZERO )
                   COMPUTE CNT-SELCHKLST  = CNT-SELCHKLST   +   1
               END-IF
           END-IF
      *
      *    読込スキップ処理
           PERFORM 3101-SELCHKLST-SKIP-SEC
      *
           PERFORM UNTIL ( FLG-MEDYAKKO    NOT =   ZERO )
                    OR   ( SPA-X03-GMN-SELCHKLST-MAX
                                          >= CONST-SELCHKLST-MAX )
      *
               COMPUTE SPA-X03-GMN-SELCHKLST-MAX
                   =   SPA-X03-GMN-SELCHKLST-MAX   +   1
      *
               MOVE    SPA-X03-GMN-SELCHKLST-MAX
                                       TO  IDX-LST
      *
               MOVE    CNT-SELCHKLST   TO  SPA-X03-GMN-TSEL-CHKNUM
                                                               (IDX-LST)
      *
               MOVE    MYAK-IYAKUHINCD TO  WRK-SRYCD
               MOVE    SPA-X03-NAI-KJNYMD
                                       TO  WRK-YMD
               PERFORM 900-TENSU-KEY-SEL-SEC
               IF     (TNS-SRYCD(1:1)      =   "1") AND
                      (TNS-ROUTEKKBN       =   2  )
                   MOVE    SPACE       TO  SPA-X03-GMN-TSEL-NAME
                                                               (IDX-LST)
                   STRING  "［老］"        DELIMITED   BY  SIZE
                           TNS-NAME        DELIMITED   BY  SIZE
                   INTO    SPA-X03-GMN-TSEL-NAME (IDX-LST)
                   END-STRING
               ELSE
                   MOVE    TNS-NAME    TO  SPA-X03-GMN-TSEL-NAME
                                                               (IDX-LST)
               END-IF
      *
               MOVE    "00000000"      TO  SPA-X03-NAI-TSEL-YUKOSTYMD
                                                               (IDX-LST)
                                           SPA-X03-GMN-TSEL-YUKOSTYMD
                                                           (IDX-LST)
               MOVE    "99999999"      TO  SPA-X03-NAI-TSEL-YUKOEDYMD
                                                               (IDX-LST)
                                           SPA-X03-GMN-TSEL-YUKOEDYMD
                                                           (IDX-LST)
      *
               MOVE    MYAK-IYAKUHINCD TO  SPA-X03-NAI-TSEL-SRYCD
                                                           (IDX-LST)
      *
      *        薬効マスタ読込処理
               PERFORM 900-MEDYAKKO-KEY4-FET-SEC
               IF    ( FLG-MEDYAKKO    =    ZERO )
                   COMPUTE CNT-SELCHKLST   = CNT-SELCHKLST   +   1
               END-IF
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-MEDYAKKO-KEY4  TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( FLG-MEDYAKKO            =   ZERO )
               MOVE    1               TO  SPA-X03-GMN-NEXT
           ELSE
               MOVE    ZERO            TO  SPA-X03-GMN-NEXT
           END-IF
      *
           . 
       3101-SELCHKLST-MEDYAK-EXT.
           EXIT.
      *****************************************************************
      *    読込スキップ処理
      *****************************************************************
       3101-SELCHKLST-SKIP-SEC         SECTION.
      *
           COMPUTE WRK-SKIP-MAX    = ( SPA-X03-GMN-PAGE    -   1 )
                                   *   CONST-SELCHKLST-MAX
      *
           EVALUATE    SPA-X03-GMN-CHKKBN
           WHEN    "1"
           WHEN    "2"
               PERFORM UNTIL ( FLG-CHKSND  NOT =   ZERO )
                        OR   ( CNT-SELCHKLST   >   WRK-SKIP-MAX )
      *
                   PERFORM 900-CHKSND-KEY11-FET-SEC
                   IF    ( FLG-CHKSND      =   ZERO )
                       COMPUTE CNT-SELCHKLST = CNT-SELCHKLST   +   1
                   END-IF
      *
               END-PERFORM
           WHEN    "M"
               PERFORM UNTIL ( FLG-CHK     NOT =   ZERO )
                        OR   ( CNT-SELCHKLST   >   WRK-SKIP-MAX )
      *
                   PERFORM 900-MEDYAKKO-KEY4-FET-SEC
                   IF    ( FLG-CHK     =   ZERO )
                       COMPUTE CNT-SELCHKLST = CNT-SELCHKLST   +   1
                   END-IF
      *
               END-PERFORM
           WHEN    OTHER
               PERFORM UNTIL ( FLG-CHK     NOT =   ZERO )
                        OR   ( CNT-SELCHKLST   >   WRK-SKIP-MAX )
      *
                   PERFORM 900-CHK-KEY11-FET-SEC
                   IF    ( FLG-CHK     =   ZERO )
                       COMPUTE CNT-SELCHKLST = CNT-SELCHKLST   +   1
                   END-IF
      *
               END-PERFORM
           END-EVALUATE
      *
           . 
       3101-SELCHKLST-SKIP-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                     SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
      *
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *    戻る
           WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *    追加
           WHEN    "CLICKED"       ALSO    "BTN_INS"
               PERFORM 4101-LCHKLST-INS-SEC
      *    全て追加
           WHEN    "CLICKED"       ALSO    "BTN_ALLINS"
               PERFORM 4101-LCHKLST-ALLINS-SEC
      *    削除
           WHEN    "CLICKED"       ALSO    "BTN_DEL"
               PERFORM 4101-LCHKLST-DEL-SEC
      *    選択解除
           WHEN    "CLICKED"       ALSO    "B09S"
               PERFORM 490-CANCEL-SEL-SEC
      *    前頁
           WHEN    "CLICKED"       ALSO    "B09"
           WHEN    "CLICKED"       ALSO    "B09_2"
               PERFORM 490-PAGE-PREV-SEC
      *    次頁
           WHEN    "CLICKED"       ALSO    "B10"
           WHEN    "CLICKED"       ALSO    "B10_2"
               PERFORM 490-PAGE-NEXT-SEC
      *    確定
           WHEN    "CLICKED"       ALSO    "B12"
               PERFORM 490-KAKUTEI-SEC
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
      *
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *    基準日
           WHEN    "ACTIVATE"      ALSO    "KJNYMD"
               PERFORM 4100-KJNYMD-CHK-SEC
           WHEN        ANY         ALSO    "LCHKLST"
               PERFORM 4101-LCHKLST-SEL-SEC
           WHEN        ANY         ALSO    "RCHKLST"
               PERFORM 4101-RCHKLST-SEL-SEC
           WHEN        ANY         ALSO    "SELCHKLST"
               PERFORM 4101-SELCHKLST-SEL-SEC
           WHEN    OTHER
      *
               MOVE    ZERO            TO  SPA-X03-GMN-CUR
      *
      *        入力チェック処理
               PERFORM 410-INPUT-CHK-SEC
      *
           END-EVALUATE
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC       SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
      *    基本チェック処理
           PERFORM 4102-KIHON-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  410-INPUT-CHK-EXT
           END-IF
      *
           .
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面をＳＰＡセット処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC            SECTION.
      *
           MOVE    X03-CHKKBN          TO  SPA-X03-GMN-CHKKBN-G
           MOVE    X03-SELNAME         TO  SPA-X03-GMN-SELNAME
      *
           .
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *****************************************************************
      *    基準日チェック処理
      *****************************************************************
       4100-KJNYMD-CHK-SEC             SECTION.
      *
           MOVE    X03-KJNYMD          TO  SPA-X03-GMN-KJNYMD
      *
           PERFORM 4101-KJNYMD-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4100-KJNYMD-CHK-EXT
           END-IF
      *
           MOVE    1                   TO  SPA-X03-GMN-PAGE
           PERFORM 3101-SELCHKLST-HEN-SEC
      *
           .
       4100-KJNYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC              SECTION.
      *
      *    基準日チェック
           PERFORM 4101-KJNYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    チェック区分チェック
           PERFORM 4101-CHKKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    チェック名称
           PERFORM 4101-SELNAME-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
           .
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    基準日チェック処理
      *****************************************************************
       4101-KJNYMD-CHK-SEC             SECTION.
      *
           MOVE    SPA-X03-NAI-KJNYMD  TO  WRK-KJNYMD-MOT
      *
           MOVE    SPACE               TO  SPA-X03-NAI-KJNYMD
      *
           IF    ( SPA-X03-GMN-KJNYMD (1:3) = SPACE )
               MOVE    SPA-X01-KJNYMD  TO  SPA-X03-GMN-KJNYMD
           END-IF
      *
           IF    ( SPA-X03-GMN-KJNYMD (1:3) = "000" )
               MOVE    "00000000"      TO   SPA-X03-GMN-KJNYMD
           END-IF
      *
           IF    ( SPA-X03-GMN-KJNYMD (1:3) = "999" )
               MOVE    "99999999"      TO   SPA-X03-GMN-KJNYMD
           END-IF
      *
           IF    ( SPA-X03-GMN-KJNYMD  =   "00000000"
                                       OR  "99999999" )
               MOVE    SPA-X03-GMN-KJNYMD  TO  SPA-X03-NAI-KJNYMD
               GO  TO  4101-KJNYMD-CHK-EXT
           END-IF
      *
           MOVE    SPA-X03-GMN-KJNYMD  TO  WRK-YMD
           PERFORM 800-SEIWA-HEN-SEC
           IF    ( FLG-HIZUKE-ERR  NOT =   ZERO )
               MOVE    WRK-KJNYMD-MOT  TO  SPA-X03-NAI-KJNYMD
               IF    ( SPA-X03-NAI-KJNYMD  =   "00000000"
                                           OR  "99999999" )
                   MOVE    SPA-X03-NAI-KJNYMD
                                       TO  SPA-X03-GMN-KJNYMD
               ELSE
                   MOVE    SPA-X03-NAI-KJNYMD  TO  WRK-YMD
                   PERFORM 800-SEIWA-HEN-SEC
                   MOVE    WRK-HENYMDG TO  SPA-X03-GMN-KJNYMD
               END-IF
      *
               MOVE    "0001"      TO  SPA-ERRCD
               MOVE    3           TO  SPA-X03-GMN-CUR
               GO  TO  4101-KJNYMD-CHK-EXT
           END-IF
      *
           MOVE    WRK-SYMD        TO  SPA-X03-NAI-KJNYMD
           MOVE    WRK-HENYMDG     TO  SPA-X03-GMN-KJNYMD
      *
           .
       4101-KJNYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    チェック区分チェック処理
      *****************************************************************
       4101-CHKKBN-CHK-SEC             SECTION.
      *
           IF    ( SPA-X03-GMN-CHKKBN-MAX  =   1 )
               MOVE    SPA-X03-GMN-CHKKBNLST (1)
                                       TO  SPA-X03-GMN-CHKKBN-G
               GO  TO  4101-CHKKBN-CHK-EXT
           END-IF
      *
           MOVE    SPA-X03-GMN-CHKKBN  TO  WRK-CMB-CD
           PERFORM 4200-CHKKBNLST-CHK-SEC
           IF    ( WRK-CMB-ITM     NOT =   SPACE )
               MOVE    WRK-CMB-ITM     TO  SPA-X03-GMN-CHKKBN-G
           ELSE
               MOVE    "0002"          TO  SPA-ERRCD
               MOVE    1               TO  SPA-X03-GMN-PAGE
               PERFORM 3101-SELCHKLST-HEN-SEC
               GO  TO  4101-CHKKBN-CHK-EXT
           END-IF
      *
           IF    ( WRK-MCP-WIDGET      =   "CHKKBN" )
               MOVE    1               TO  SPA-X03-GMN-PAGE
               PERFORM 3101-SELCHKLST-HEN-SEC
           END-IF
      *
           .
       4101-CHKKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    チェック名称チェック処理
      *****************************************************************
       4101-SELNAME-CHK-SEC            SECTION.
      *
           IF    ( SPA-X03-GMN-SELNAME NOT =   SPACE )
               MOVE    SPA-X03-GMN-SELNAME TO  WRK-KANACHK-MAE-INPUT
               PERFORM 800-ENRTRY-CHK-SEC
               MOVE    WRK-KANACHK-OUT-INPUT
                                           TO  SPA-X03-GMN-SELNAME
               IF    ( FLG-ENTRYCHK    NOT =   2 )
                   MOVE    "0003"          TO  SPA-ERRCD
                   MOVE    2               TO  SPA-X03-GMN-CUR
               END-IF
               MOVE    WRK-KANACHK-OUT-INPUT
                                           TO  SPA-X03-GMN-SELNAME
           END-IF
      *
           IF    ( WRK-MCP-WIDGET          =   "SELNAME" )
               MOVE    1                   TO  SPA-X03-GMN-PAGE
               PERFORM 3101-SELCHKLST-HEN-SEC
           END-IF
      *
           .
       4101-SELNAME-CHK-EXT.
           EXIT.
      *****************************************************************
      *    チェック元リスト選択処理
      *****************************************************************
       4101-LCHKLST-SEL-SEC            SECTION.
      *
           PERFORM VARYING IDX4    FROM    1   BY  1
                   UNTIL ( IDX4   >   SPA-X03-GMN-LCHKLST-MAX )
      *
               IF    ( X03-LCHKLST-SELECT (IDX4)   =   "T" )
                   MOVE    1       TO  SPA-X03-GMN-LCHKLST-FLG (IDX4)
               ELSE
                   MOVE    ZERO    TO  SPA-X03-GMN-LCHKLST-FLG (IDX4)
               END-IF
      *
           END-PERFORM
      *
      *    チェック先リストの選択状態を解除
           PERFORM VARYING IDX4    FROM    1   BY  1
                   UNTIL ( IDX4   >   SPA-X03-GMN-RCHKLST-MAX )
      *
               MOVE    ZERO    TO  SPA-X03-GMN-RCHKLST-FLG (IDX4)
      *
           END-PERFORM
      *
           .
       4101-RCHKLST-SEL-EXT.
           EXIT.
      *****************************************************************
      *    チェック先リスト選択処理
      *****************************************************************
       4101-RCHKLST-SEL-SEC            SECTION.
      *
           PERFORM VARYING IDX4    FROM    1   BY  1
                   UNTIL ( IDX4   >   SPA-X03-GMN-RCHKLST-MAX )
      *
               IF    ( X03-RCHKLST-SELECT (IDX4)   =   "T" )
                AND  ( SPA-X03-NAI-TRCHK-DELFLG  (IDX4)
                                                   =   ZERO )
                AND  ( SPA-X03-NAI-TRCHK-SRYCD   (IDX4)
                                               NOT =   SPA-X01-SRYCD )
                   MOVE    1       TO  SPA-X03-GMN-RCHKLST-FLG (IDX4)
               ELSE
                   MOVE    ZERO    TO  SPA-X03-GMN-RCHKLST-FLG (IDX4)
               END-IF
      *
           END-PERFORM
      *
      *    チェック元リストの選択状態を解除
           PERFORM VARYING IDX4    FROM    1   BY  1
                   UNTIL ( IDX4   >   SPA-X03-GMN-LCHKLST-MAX )
      *
               MOVE    ZERO    TO  SPA-X03-GMN-LCHKLST-FLG (IDX4)
      *
           END-PERFORM
      *
           .
       4101-RCHKLST-SEL-EXT.
           EXIT.
      *****************************************************************
      *    チェック名称リスト選択処理
      *****************************************************************
       4101-SELCHKLST-SEL-SEC          SECTION.
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >   SPA-X03-GMN-SELCHKLST-MAX )
      *
               IF    ( X03-SELCHKLST-SELECT (IDX2) =   "T" )
                   MOVE    IDX2    TO  SPA-X03-GMN-SELCHKLST-SEL
      *
                   MOVE    SPA-X03-GMN-CHKKBN-G
                                   TO  SPA-X03-GMN-RCHKKBNMEI
      *
                   MOVE    SPA-X03-GMN-TSEL-NAME (IDX2)
                                   TO  SPA-X03-GMN-RNAME
      *
                   MOVE    SPA-X03-GMN-TSEL-YUKOSTYMD (IDX2)
                                   TO  SPA-X03-GMN-RYUKOSTYMD
                   MOVE    SPA-X03-NAI-TSEL-YUKOSTYMD (IDX2)
                                   TO  SPA-X03-NAI-RYUKOSTYMD
      *
                   MOVE    SPA-X03-GMN-TSEL-YUKOEDYMD (IDX2)
                                   TO  SPA-X03-GMN-RYUKOEDYMD
                   MOVE    SPA-X03-NAI-TSEL-YUKOEDYMD (IDX2)
                                   TO  SPA-X03-NAI-RYUKOEDYMD
      *
                   MOVE    SPA-X03-NAI-TSEL-SRYCD (IDX2)
                                   TO  WRK-RCHKLST-SRYCD
      *            チェック先リスト編集処理
                   EVALUATE    SPA-X03-GMN-CHKKBN
                   WHEN  "1"
                   WHEN  "2"
                       PERFORM 41011-RCHKLST-CHKSND-HEN-SEC
                   WHEN  "M"
                       PERFORM 41011-RCHKLST-MEDYAKKO-HEN-SEC
                   WHEN  OTHER
                       PERFORM 41011-RCHKLST-CHKMST-HEN-SEC
                   END-EVALUATE
                   MOVE    SPA-X03-GMN-SELCHKLST-MAX
                                       TO  IDX2
               END-IF
      *
           END-PERFORM
      *
           .
       4101-SELCHKLST-SEL-EXT.
           EXIT.
      *****************************************************************
      *    チェック先リスト編集処理（チェックマスタ２より)
      *****************************************************************
       41011-RCHKLST-CHKSND-HEN-SEC    SECTION.
      *
           MOVE    1                   TO  FLG-RCHKLST-ROW
      *
           INITIALIZE                      SPA-X03-GMN-RCHKLST
                                           SPA-X03-NAI-RCHKLST
      *
           MOVE    ZERO                TO  FLG-CHKSND
      *
      *    チェックマスタ読み込み 
           INITIALIZE                  CHKSND-REC
           MOVE    SPA-X03-GMN-CHKKBN  TO  CHKSND-CHKKBN
           MOVE    WRK-RCHKLST-SRYCD   TO  CHKSND-SRYCD
           MOVE    SPA-X03-NAI-KJNYMD  TO  CHKSND-YUKOSTYMD
                                           CHKSND-YUKOEDYMD
           MOVE    CHKSND-REC          TO  MCPDATA-REC
           MOVE    PATH-TBL-CHKSND-KEY2    TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  CHKSND-REC
           ELSE
               MOVE    1               TO  FLG-CHKSND
               INITIALIZE                  CHKSND-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-CHKSND  NOT =   ZERO )
                   OR    ( SPA-X03-GMN-RCHKLST-MAX
                                          >=   CONST-CHKLST-MAX )
      *
               COMPUTE SPA-X03-GMN-RCHKLST-MAX
                   =   SPA-X03-GMN-RCHKLST-MAX +   1
      *
               MOVE    SPA-X03-GMN-RCHKLST-MAX
                                           TO  IDXA
      *
               MOVE    IDXA                TO  SPA-X03-GMN-TRCHK-NUM
                                                                  (IDXA)
               MOVE    CHKSND-CD           TO  WRK-KEY-CD-G
               MOVE    WRK-KEY-CD (1)      TO  SPA-X03-NAI-TRCHK-SRYCD
                                                                  (IDXA)
               PERFORM VARYING IDX7    FROM    1   BY  1
                       UNTIL ( IDX7    >   CONST-MKCD-MAX )
      *
                   MOVE    WRK-KEY-CD (IDX7)
                                           TO  SPA-X03-NAI-TRCHK-BYOCD
                                                             (IDXA IDX7)
      *
               END-PERFORM
      *
               IF    ( CHKSND-BYOMEI       =   SPACE )
                   MOVE    WRK-KEY-CD (1)  TO  SPA-X03-GMN-TRCHK-NAME
                                                               (IDXA)
                   MOVE    1               TO  SPA-X03-NAI-TRCHK-DELFLG
                                                               (IDXA)
               ELSE
                   MOVE    CHKSND-BYOMEI   TO  SPA-X03-GMN-TRCHK-NAME
                                                               (IDXA)
                   MOVE    ZERO            TO  SPA-X03-NAI-TRCHK-DELFLG
                                                               (IDXA)
               END-IF
      *
               MOVE    CHKSND-COMPKBN      TO  SPA-X03-GMN-TRCHK-JYKN
                                                               (IDXA)
               MOVE    CHKSND-BYOMEIHENFLG 
                                       TO  SPA-X03-NAI-TRCHK-BYOSTATUS
                                                               (IDXA)
      *
               MOVE    PATH-TBL-CHKSND-KEY2    TO  MCP-PATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC TO  CHKSND-REC
               ELSE
                   MOVE    1           TO  FLG-CHKSND
                   INITIALIZE          CHKSND-REC
               END-IF
      *
           END-PERFORM
      *
      *    カーソルクロース
           MOVE    PATH-TBL-CHKSND-KEY2    TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       41011-RCHKLST-CHKSND-HEN-EXT.
           EXIT.
      *****************************************************************
      *    チェック先リスト編集処理（チェックマスタより)
      *****************************************************************
       41011-RCHKLST-CHKMST-HEN-SEC        SECTION.
      *
           MOVE    1                   TO  FLG-RCHKLST-ROW
      *
           INITIALIZE                      SPA-X03-GMN-RCHKLST
                                           SPA-X03-NAI-RCHKLST
      *
           MOVE    ZERO                TO  FLG-CHK
      *
      *    チェックマスタ読み込み 
           INITIALIZE                  CHK-REC
           MOVE    SPA-X03-GMN-CHKKBN  TO  CHK-CHKKBN
           MOVE    WRK-RCHKLST-SRYCD   TO  CHK-SRYCD
           MOVE    SPA-X03-NAI-KJNYMD  TO  CHK-YUKOSTYMD
                                           CHK-YUKOEDYMD
           MOVE    CHK-REC             TO  MCPDATA-REC
           MOVE    PATH-TBL-CHK-KEY2   TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  CHK-REC
           ELSE
               MOVE    1               TO  FLG-CHK
               INITIALIZE              CHK-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-CHK     NOT =   ZERO )
                   OR    ( SPA-X03-GMN-RCHKLST-MAX
                                          >=   CONST-CHKLST-MAX )
      *
               PERFORM VARYING IDX3    FROM    1   BY  1
                       UNTIL ( IDX3    >   10 )
                       OR    ( CHK-CD (IDX3)   =   SPACE  )
                       OR    ( SPA-X03-GMN-RCHKLST-MAX
                                              >=   CONST-CHKLST-MAX )
      *
                   COMPUTE SPA-X03-GMN-RCHKLST-MAX
                       =   SPA-X03-GMN-RCHKLST-MAX +   1
      *
                   MOVE    SPA-X03-GMN-RCHKLST-MAX
                                           TO  IDXA
      *
                   MOVE    IDXA            TO  SPA-X03-GMN-TRCHK-NUM
                                                                  (IDXA)
                   MOVE    CHK-CD (IDX3)   TO  SPA-X03-NAI-TRCHK-SRYCD
                                                                  (IDXA)
      *
                   EVALUATE    SPA-X03-GMN-CHKKBN
                   WHEN    "4"
                   WHEN    "5"  
      *                点数マスタ読み込み
                       MOVE    CHK-CD (IDX3)
                                           TO  WRK-CHK-CD
                       PERFORM 41011-TNS-NAME-HEN-SEC
                       MOVE    WRK-NAME    TO  SPA-X03-GMN-TRCHK-NAME
                                                               (IDXA)
                       MOVE    FLG-SRYCD-DEL
                                           TO  SPA-X03-NAI-TRCHK-DELFLG
                                                               (IDXA)
                   END-EVALUATE
               END-PERFORM
      *
               MOVE    PATH-TBL-CHK-KEY2   TO  MCP-PATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC TO  CHK-REC
               ELSE
                   MOVE    1           TO  FLG-CHK
                   INITIALIZE          CHK-REC
               END-IF
      *
           END-PERFORM
      *
      *    カーソルクロース
           MOVE    PATH-TBL-CHK-KEY2   TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       41011-RCHKLST-CHKMST-HEN-EXT.
           EXIT.
      *****************************************************************
      *    チェック先リスト編集処理（薬効マスタより)
      *****************************************************************
       41011-RCHKLST-MEDYAKKO-HEN-SEC    SECTION.
      *
           MOVE    1                   TO  FLG-RCHKLST-ROW
      *
           INITIALIZE                      SPA-X03-GMN-RCHKLST
                                           SPA-X03-NAI-RCHKLST
      *
           MOVE    ZERO                TO  FLG-MEDYAKKO
      *
      *    チェックマスタ読み込み 
           INITIALIZE                  MEDYAKKO-REC
           MOVE    WRK-RCHKLST-SRYCD   TO  MYAK-IYAKUHINCD
           MOVE    MEDYAKKO-REC        TO  MCPDATA-REC
           MOVE    PATH-TBL-MEDYAKKO-KEY2  TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  MEDYAKKO-REC
           ELSE
               MOVE    1               TO  FLG-MEDYAKKO
               INITIALIZE                  MEDYAKKO-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-MEDYAKKO  NOT =   ZERO )
                   OR    ( SPA-X03-GMN-RCHKLST-MAX
                                          >=   CONST-CHKLST-MAX )
      *
               COMPUTE SPA-X03-GMN-RCHKLST-MAX
                   =   SPA-X03-GMN-RCHKLST-MAX +   1
      *
               MOVE    SPA-X03-GMN-RCHKLST-MAX
                                           TO  IDXA
      *
               MOVE    IDXA                TO  SPA-X03-GMN-TRCHK-NUM
                                                                  (IDXA)
               MOVE    MYAK-BYOMEICD (1)   TO  SPA-X03-NAI-TRCHK-SRYCD
                                                                  (IDXA)
               PERFORM VARYING IDX7    FROM    1   BY  1
                       UNTIL ( IDX7    >   CONST-MKCD-MAX )
      *
                   MOVE    MYAK-BYOMEICD (IDX7)
                                           TO  SPA-X03-NAI-TRCHK-BYOCD
                                                             (IDXA IDX7)
      *
               END-PERFORM
      *
               IF    ( MYAK-TEKIOUBYOMEI       =   SPACE )
                   MOVE    MYAK-BYOMEICD (1)
                                       TO  SPA-X03-GMN-TRCHK-NAME
                                                               (IDXA)
                   MOVE    1           TO  SPA-X03-NAI-TRCHK-DELFLG
                                                               (IDXA)
               ELSE
                   MOVE    MYAK-TEKIOUBYOMEI
                                       TO  SPA-X03-GMN-TRCHK-NAME
                                                               (IDXA)
                   MOVE    ZERO        TO  SPA-X03-NAI-TRCHK-DELFLG
                                                               (IDXA)
               END-IF
      *
               MOVE    "1"             TO  SPA-X03-GMN-TRCHK-JYKN
                                                               (IDXA)
               MOVE    MYAK-BYOMEIHENFLG
                                       TO  SPA-X03-NAI-TRCHK-BYOSTATUS
                                                               (IDXA)
      *
               MOVE    PATH-TBL-MEDYAKKO-KEY2    TO  MCP-PATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC TO  MEDYAKKO-REC
               ELSE
                   MOVE    1           TO  FLG-MEDYAKKO
                   INITIALIZE          MEDYAKKO-REC
               END-IF
      *
           END-PERFORM
      *
      *    カーソルクロース
           MOVE    PATH-TBL-MEDYAKKO-KEY2    TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       41011-RCHKLST-MEDYAKKO-HEN-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ読み込み処理
      *****************************************************************
       41011-TNS-NAME-HEN-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
           MOVE    SPACE               TO  WRK-TNS-NAME
           MOVE    ZERO                TO  FLG-SRYCD-DEL
      *
           MOVE    ZERO                TO  FLG-TENSU
      *
           INITIALIZE                      TNS-TENSU-REC
           MOVE    WRK-CHK-CD          TO  TNS-SRYCD
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    PATH-TBL-TENSU-KEY4 TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
           ELSE
               MOVE    1               TO  FLG-TENSU
               INITIALIZE                  TNS-TENSU-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-TENSU       =   1 )
                     OR  ( FLG-OK          =   1 )
      *
               IF    ( TNS-SRYCD(1:1)      =   "1" )
                AND  ( TNS-ROUTEKKBN       =   2   )
                   STRING  "［老］"        DELIMITED   BY  SIZE
                           TNS-NAME        DELIMITED   BY  SIZE
                   INTO    WRK-TNS-NAME
                   END-STRING
               ELSE
                   MOVE    TNS-NAME    TO  WRK-TNS-NAME
               END-IF
      *
      *        有効終了日が対象のマスタを対象とする
               IF    ( SPA-X01-KJNYMD <=   TNS-YUKOEDYMD )
                   MOVE    1               TO  FLG-OK
               END-IF
      *
               MOVE    PATH-TBL-TENSU-KEY4 TO  MCP-PATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
               ELSE
                   MOVE    1               TO  FLG-TENSU
                   INITIALIZE                  TNS-TENSU-REC
               END-IF
           END-PERFORM
      *
           MOVE    PATH-TBL-TENSU-KEY4 TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           MOVE    WRK-TNS-NAME        TO  WRK-NAME
      *
           IF    ( FLG-OK              =   ZERO )
      *
               MOVE    1               TO  FLG-SRYCD-DEL
      *
               IF    ( WRK-TNS-NAME    NOT =   SPACE)
      *
                   MOVE    SPACE       TO  WRK-NAME
                   STRING  "★削除済★"    DELIMITED   BY  SIZE
                           WRK-TNS-NAME    DELIMITED   BY  SIZE
                   INTO    WRK-NAME
                   END-STRING
               ELSE
                   MOVE    SPACE       TO  WRK-NAME
                   STRING  "★削除済★"    DELIMITED   BY  SIZE
                           WRK-CHK-CD      DELIMITED   BY  SIZE
                   INTO    WRK-NAME
                   END-STRING
               END-IF
           END-IF
      *
           .
       41011-TNS-NAME-HEN-EXT.
           EXIT.
      *****************************************************************
      *    チェック元リスト追加処理
      *****************************************************************
       4101-LCHKLST-INS-SEC            SECTION.
      *
           INITIALIZE                  WRK-LCHKLST-AREA
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   SPA-X03-GMN-RCHKLST-MAX )
      *
               IF    ( SPA-X03-GMN-RCHKLST-FLG (IDX0)
                                                   =   1 )
      *
                   MOVE    ZERO            TO  FLG-HIT
                   PERFORM VARYING IDX6    FROM    1   BY  1
                           UNTIL ( IDX6    >   SPA-X03-GMN-LCHKLST-MAX )
                            OR   ( FLG-HIT =   1 )
      *
                       IF    ( SPA-X03-GMN-CHKKBN  =   "1"
                                                   OR  "2"
                                                   OR  "M" )
                           IF    ( SPA-X03-GMN-TRCHK-NAME  (IDX0)
                               =   SPA-X03-GMN-TLCHK-NAME  (IDX6) )
                            AND  ( SPA-X03-GMN-TRCHK-JYKN  (IDX0)
                               =   SPA-X03-GMN-TLCHK-JYKN  (IDX6) )
                               MOVE    1   TO  FLG-HIT
                           END-IF
                       ELSE
                           IF    ( SPA-X03-NAI-TRCHK-SRYCD (IDX0)
                               =   SPA-X03-NAI-TLCHK-SRYCD (IDX6) )
                               MOVE    1   TO  FLG-HIT
                           END-IF
                       END-IF
      *
                   END-PERFORM
      *
                   IF    ( FLG-HIT         =   ZERO )
                    AND  ( CONST-CHKLST-MAX    >   WRK-LCHKLST-MAX )
      *
                       COMPUTE WRK-LCHKLST-MAX =   WRK-LCHKLST-MAX +   1
      *
                       MOVE    SPA-X03-GMN-TRCHK-NAME (IDX0)
                                       TO  WRK-LCHKLST-NAME 
                                                      (WRK-LCHKLST-MAX)
                       MOVE    SPA-X03-NAI-TRCHK-SRYCD (IDX0)
                                       TO  WRK-LCHKLST-SRYCD
                                                      (WRK-LCHKLST-MAX)
      *
                       MOVE    SPA-X03-GMN-TRCHK-JYKN (IDX0)
                                       TO  WRK-LCHKLST-JYKN
                                                      (WRK-LCHKLST-MAX)
                       PERFORM VARYING IDX7    FROM    1   BY  1
                           UNTIL ( IDX7    >   CONST-MKCD-MAX )
                           MOVE    SPA-X03-NAI-TRCHK-BYOCD(IDX0 IDX7)
                                       TO  WRK-LCHKLST-BYOCD
                                                 (WRK-LCHKLST-MAX IDX7)
                       END-PERFORM
      *
                       MOVE    SPA-X03-NAI-TRCHK-BYOSTATUS (IDX0)
                                       TO  WRK-LCHKLST-BYOSTATUS
                                                      (WRK-LCHKLST-MAX)
      *
                   END-IF
               END-IF
           END-PERFORM
      *
           IF    ( WRK-LCHKLST-MAX +   SPA-X03-GMN-LCHKLST-MAX
                                       >   CONST-CHKLST-MAX )
               MOVE    "1001"      TO  SPA-ERRCD
               GO  TO  4101-LCHKLST-INS-EXT
           END-IF
      *
      *    チェック元リスト追加処理
           PERFORM 41011-LCHKLST-INS-SEC
      *
           .
       4101-LCHKLST-INS-EXT.
           EXIT.
      *****************************************************************
      *    チェック元リスト追加処理
      *****************************************************************
       41011-LCHKLST-INS-SEC           SECTION.
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   WRK-LCHKLST-MAX )
                     OR  ( SPA-X03-GMN-LCHKLST-MAX
                                   >=  CONST-CHKLST-MAX )
      *
               COMPUTE SPA-X03-GMN-LCHKLST-MAX
                   =   SPA-X03-GMN-LCHKLST-MAX +   1
      *
               MOVE    SPA-X03-GMN-LCHKLST-MAX
                                       TO  IDXA
      *
               MOVE    IDXA            TO  SPA-X03-GMN-TLCHK-NUM  (IDXA)
      *
               MOVE    WRK-LCHKLST-NAME (IDX0)
                                       TO  SPA-X03-GMN-TLCHK-NAME (IDXA)
               MOVE    WRK-LCHKLST-SRYCD(IDX0)
                                       TO  SPA-X03-NAI-TLCHK-SRYCD(IDXA)
               MOVE    WRK-LCHKLST-JYKN (IDX0)
                                       TO  SPA-X03-GMN-TLCHK-JYKN (IDXA)
               PERFORM VARYING IDX7    FROM    1   BY  1
                       UNTIL ( IDX7    >   CONST-MKCD-MAX )
                   MOVE    WRK-LCHKLST-BYOCD (IDX0 IDX7)
                               TO  SPA-X03-NAI-TLCHK-BYOCD (IDXA IDX7)
               END-PERFORM
      *
               MOVE    WRK-LCHKLST-BYOSTATUS (IDX0)
                               TO  SPA-X03-NAI-TLCHK-BYOSTATUS (IDXA)
      *
           END-PERFORM
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   SPA-X03-GMN-RCHKLST-MAX )
      *
               MOVE    ZERO        TO  SPA-X03-GMN-RCHKLST-FLG (IDX0)
      *
           END-PERFORM
      *
           .
       41011-LCHKLST-INS-EXT.
           EXIT.
      *****************************************************************
      *    チェック元リスト全追加処理
      *****************************************************************
       4101-LCHKLST-ALLINS-SEC         SECTION.
      *
           INITIALIZE                  WRK-LCHKLST-AREA
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   SPA-X03-GMN-RCHKLST-MAX )
      *
               IF    ( SPA-X03-NAI-TRCHK-DELFLG  (IDX0)
                                                   =   ZERO )
                AND  ( SPA-X03-NAI-TRCHK-SRYCD   (IDX0)
                                               NOT =   SPA-X01-SRYCD )
      *
                   MOVE    ZERO            TO  FLG-HIT
                   PERFORM VARYING IDX6    FROM    1   BY  1
                           UNTIL ( IDX6    >   SPA-X03-GMN-LCHKLST-MAX )
                            OR   ( FLG-HIT =   1 )
      *
                       IF    ( SPA-X03-GMN-CHKKBN  =   "1"
                                                   OR  "2"
                                                   OR  "M" )
                           IF    ( SPA-X03-GMN-TRCHK-NAME  (IDX0)
                               =   SPA-X03-GMN-TLCHK-NAME  (IDX6) )
                            AND  ( SPA-X03-GMN-TRCHK-JYKN  (IDX0)
                               =   SPA-X03-GMN-TLCHK-JYKN  (IDX6) )
                               MOVE    1   TO  FLG-HIT
                           END-IF
                       ELSE
                           IF    ( SPA-X03-NAI-TRCHK-SRYCD (IDX0)
                               =   SPA-X03-NAI-TLCHK-SRYCD (IDX6) )
                               MOVE    1   TO  FLG-HIT
                           END-IF
                       END-IF
      *
                   END-PERFORM
      *
                   IF    ( FLG-HIT         =   ZERO )
                    AND  ( CONST-CHKLST-MAX    >   WRK-LCHKLST-MAX )
      *
                       COMPUTE WRK-LCHKLST-MAX =   WRK-LCHKLST-MAX +   1
      *
                       MOVE    SPA-X03-GMN-TRCHK-NAME (IDX0)
                                       TO  WRK-LCHKLST-NAME 
                                                      (WRK-LCHKLST-MAX)
                       MOVE    SPA-X03-NAI-TRCHK-SRYCD (IDX0)
                                       TO  WRK-LCHKLST-SRYCD
                                                      (WRK-LCHKLST-MAX)
      *
                       MOVE    SPA-X03-GMN-TRCHK-JYKN (IDX0)
                                       TO  WRK-LCHKLST-JYKN
                                                      (WRK-LCHKLST-MAX)
                       PERFORM VARYING IDX7    FROM    1   BY  1
                           UNTIL ( IDX7    >   CONST-MKCD-MAX )
                           MOVE    SPA-X03-NAI-TRCHK-BYOCD(IDX0 IDX7)
                                       TO  WRK-LCHKLST-BYOCD
                                                 (WRK-LCHKLST-MAX IDX7)
                       END-PERFORM
      *
                       MOVE    SPA-X03-NAI-TRCHK-BYOSTATUS (IDX0)
                                       TO  WRK-LCHKLST-BYOSTATUS
                                                      (WRK-LCHKLST-MAX)
      *
                   END-IF
               END-IF
           END-PERFORM
      *
           IF    ( WRK-LCHKLST-MAX +   SPA-X03-GMN-LCHKLST-MAX
                                       >   CONST-CHKLST-MAX )
               MOVE    "1001"      TO  SPA-ERRCD
               GO  TO  4101-LCHKLST-ALLINS-EXT
           END-IF
      *
      *    チェック元リスト追加処理
           PERFORM 41011-LCHKLST-INS-SEC
      *
           .
       4101-LCHKLST-ALLINS-EXT.
           EXIT.
      *****************************************************************
      *    チェック元リスト削除処理
      *****************************************************************
       4101-LCHKLST-DEL-SEC            SECTION.
      *
           INITIALIZE                  WRK-LCHKLST-AREA
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   SPA-X03-GMN-LCHKLST-MAX )
      *
               IF    ( SPA-X03-GMN-LCHKLST-FLG (IDX0)    = ZERO )
                   COMPUTE WRK-LCHKLST-MAX =   WRK-LCHKLST-MAX +   1
      *
                   MOVE    SPA-X03-GMN-TLCHK-NAME (IDX0)
                                       TO  WRK-LCHKLST-NAME 
                                                      (WRK-LCHKLST-MAX)
                   MOVE    SPA-X03-NAI-TLCHK-SRYCD (IDX0)
                                       TO  WRK-LCHKLST-SRYCD
                                                      (WRK-LCHKLST-MAX)
      *
                   MOVE    SPA-X03-GMN-TLCHK-JYKN (IDX0)
                                       TO  WRK-LCHKLST-JYKN
                                                      (WRK-LCHKLST-MAX)
                   PERFORM VARYING IDX7    FROM    1   BY  1
                           UNTIL ( IDX7    >   CONST-MKCD-MAX )
                       MOVE    SPA-X03-NAI-TLCHK-BYOCD (IDX0 IDX7)
                                       TO  WRK-LCHKLST-BYOCD
                                                 (WRK-LCHKLST-MAX IDX7)
                   END-PERFORM
      *
                   MOVE    SPA-X03-NAI-TLCHK-BYOSTATUS (IDX0)
                                       TO  WRK-LCHKLST-BYOSTATUS
                                                      (WRK-LCHKLST-MAX)
      *
               END-IF
      *
           END-PERFORM
      *
           INITIALIZE                  SPA-X03-GMN-LCHKLST
                                       SPA-X03-NAI-LCHKLST
      *
           MOVE    WRK-LCHKLST-MAX     TO  SPA-X03-GMN-LCHKLST-MAX
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   WRK-LCHKLST-MAX )
      *
               MOVE    IDX0            TO  SPA-X03-GMN-TLCHK-NUM (IDX0)
               MOVE    WRK-LCHKLST-NAME (IDX0)
                                       TO  SPA-X03-GMN-TLCHK-NAME (IDX0)
               MOVE    WRK-LCHKLST-SRYCD(IDX0)
                                       TO  SPA-X03-NAI-TLCHK-SRYCD(IDX0)
               MOVE    WRK-LCHKLST-JYKN (IDX0)
                                       TO  SPA-X03-GMN-TLCHK-JYKN (IDX0)
               PERFORM VARYING IDX7    FROM    1   BY  1
                       UNTIL ( IDX7    >   CONST-MKCD-MAX )
                   MOVE    WRK-LCHKLST-BYOCD (IDX0 IDX7)
                               TO  SPA-X03-NAI-TLCHK-BYOCD (IDX0 IDX7)
               END-PERFORM
      *
               MOVE    WRK-LCHKLST-BYOSTATUS (IDX0)
                               TO  SPA-X03-NAI-TLCHK-BYOSTATUS (IDX0)
      *
           END-PERFORM
      *
           .
       4101-LCHKLST-DEL-EXT.
           EXIT.
      *****************************************************************
      *    チェック区分コンボチェック処理
      *****************************************************************
       4200-CHKKBNLST-CHK-SEC          SECTION.
      *
           MOVE    SPACE               TO  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
               UNTIL ( IDX-CMB     >   SPA-X03-GMN-CHKKBN-MAX )
                OR   ( WRK-CMB-CD  =   SPA-X03-GMN-CHKKBNL (IDX-CMB) )
      *
               CONTINUE
      *
           END-PERFORM
      *
           IF    ( IDX-CMB     <=  SPA-X03-GMN-CHKKBN-MAX )
               MOVE    SPA-X03-GMN-CHKKBNLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
           END-IF
      *
           .
       4200-CHKKBNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           IF    ( SPA-X01-CHKKBN  =   "1" OR "2" )
               MOVE    "X04"           TO  SPA-SAKIPG
           ELSE
               MOVE    "X02"           TO  SPA-SAKIPG
           END-IF
      *
           MOVE    "X03"               TO  SPA-MOTOPG
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    前頁　処理
      *****************************************************************
       490-PAGE-PREV-SEC               SECTION.
      *
           IF    ( SPA-X03-GMN-PAGE    >   1 )
               COMPUTE SPA-X03-GMN-PAGE
                   =   SPA-X03-GMN-PAGE    -   1
               PERFORM 3101-SELCHKLST-HEN-SEC
           END-IF
      *
           .
       490-PAGE-PREV-EXT.
           EXIT.
      *****************************************************************
      *    次頁　処理
      *****************************************************************
       490-PAGE-NEXT-SEC               SECTION.
      * 
           IF    ( SPA-X03-GMN-NEXT    =   1 )
               COMPUTE SPA-X03-GMN-PAGE
                   =   SPA-X03-GMN-PAGE    +   1
               PERFORM 3101-SELCHKLST-HEN-SEC
           END-IF
      *
           .
       490-PAGE-NEXT-EXT.
           EXIT.
      *****************************************************************
      *    チェック先リスト選択解除処理
      *****************************************************************
       490-CANCEL-SEL-SEC              SECTION.
      *
           INITIALIZE                  SPA-X03-GMN-RCHKLST-FLG-G
      *
           .
       490-CANCEL-EXT.
           EXIT.
      *****************************************************************
      *    確定　処理
      *****************************************************************
       490-KAKUTEI-SEC                 SECTION.
      *
           MOVE    1                   TO  SPA-X03-GMN-KAKUTEI
      *
           IF    ( SPA-X01-CHKKBN  =   "1" OR "2" )
               MOVE    "X04"           TO  SPA-SAKIPG
           ELSE
               MOVE    "X02"           TO  SPA-SAKIPG
           END-IF
      *
           MOVE    "X03"               TO  SPA-MOTOPG
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       490-KAKUTEI-EXT.
           EXIT.
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF    ( SPA-ERRCD       NOT =   SPACE )
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "X03    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    X03-LCHKLST-ROW         TO  WRK-LCHKLST-ROW
           MOVE    X03-RCHKLST-ROW         TO  WRK-RCHKLST-ROW
           MOVE    X03-SELCHKLST-ROW       TO  WRK-SELCHKLST-ROW
      *
           INITIALIZE                      X03
      *
           MOVE    SPA-X03-GMN-LCHKKBNMEI  TO  X03-LCHKKBNMEI
           MOVE    SPA-X03-GMN-LYUKOSTYMD  TO  X03-LYUKOSTYMD
           MOVE    SPA-X03-GMN-LYUKOEDYMD  TO  X03-LYUKOEDYMD
           MOVE    SPA-X03-GMN-LNAME       TO  X03-LNAME
           MOVE    SPA-X03-GMN-LCHKLST-MAX TO  X03-LCHKLST-COUNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   SPA-X03-GMN-LCHKLST-MAX )
      *
               MOVE    SPA-X03-GMN-TLCHK-NUM  (IDX1)
                                       TO  WRK-ZZZZ
               MOVE    WRK-ZZZZ        TO  X03-TLCHK-NUM  (IDX1)
               MOVE    SPA-X03-GMN-TLCHK-NAME (IDX1)
                                       TO  X03-TLCHK-NAME (IDX1)
      *
               PERFORM VARYING IDX0    FROM    1   BY  1
                       UNTIL ( IDX0    >   CONST-JYKN-MAX )
                   IF    ( SPA-X03-GMN-TLCHK-JYKN (IDX1)
                                       =   CONST-JYKN-CD (IDX0))
                       MOVE    CONST-JYKN-MEI (IDX0)
                                       TO  X03-TLCHK-JYKN(IDX1)
                   END-IF
               END-PERFORM
      *
               IF    ( SPA-X03-GMN-LCHKLST-FLG (IDX1)  =   ZERO )
                   MOVE    "F"         TO  X03-LCHKLST-SELECT (IDX1)
               ELSE
                   MOVE    "T"         TO  X03-LCHKLST-SELECT (IDX1)
               END-IF
      *
           END-PERFORM
      *
           MOVE    SPA-X03-GMN-RCHKKBNMEI  TO  X03-RCHKKBNMEI
           MOVE    SPA-X03-GMN-RYUKOSTYMD  TO  X03-RYUKOSTYMD
           MOVE    SPA-X03-GMN-RYUKOEDYMD  TO  X03-RYUKOEDYMD
           MOVE    SPA-X03-GMN-RNAME       TO  X03-RNAME
           MOVE    SPA-X03-GMN-RCHKLST-MAX TO  X03-RCHKLST-COUNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   SPA-X03-GMN-RCHKLST-MAX )
      *
               MOVE    SPA-X03-GMN-TRCHK-NUM  (IDX1)
                                       TO  WRK-ZZZZ
               MOVE    WRK-ZZZZ        TO  X03-TRCHK-NUM  (IDX1)
               MOVE    SPA-X03-GMN-TRCHK-NAME (IDX1)
                                       TO  X03-TRCHK-NAME (IDX1)
      *
               PERFORM VARYING IDX0    FROM    1   BY  1
                       UNTIL ( IDX0    >   CONST-JYKN-MAX )
                   IF    ( SPA-X03-GMN-TRCHK-JYKN (IDX1))
                                       =   CONST-JYKN-CD (IDX0)
                       MOVE    CONST-JYKN-MEI (IDX0)
                                       TO  X03-TRCHK-JYKN(IDX1)
                   END-IF
               END-PERFORM
      *
               IF    ( SPA-X03-GMN-RCHKLST-FLG (IDX1)  =   ZERO )
                   MOVE    "F"         TO  X03-RCHKLST-SELECT (IDX1)
               ELSE
                   MOVE    "T"         TO  X03-RCHKLST-SELECT (IDX1)
               END-IF
      *
           END-PERFORM
      *
           MOVE    SPA-X03-GMN-CHKKBN-G    TO  X03-CHKKBN
      *
           MOVE    SPA-X03-GMN-CHKKBN-MAX  TO  X03-CHKKBN-COUNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   SPA-X03-GMN-CHKKBN-MAX )
                   MOVE    SPA-X03-GMN-CHKKBNLST (IDX1)
                                           TO  X03-CHKKBN-ITEM (IDX1)
      *
           END-PERFORM
      *
           MOVE    SPA-X03-GMN-SELNAME     TO  X03-SELNAME
      *
           MOVE    SPA-X03-GMN-SELCHKLST-MAX
                                           TO  X03-SELCHKLST-COUNT
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   SPA-X03-GMN-SELCHKLST-MAX )
      *
               MOVE    SPA-X03-GMN-TSEL-CHKNUM (IDX1)
                                       TO  WRK-ZZZZ
               MOVE    WRK-ZZZZ        TO  X03-TSEL-CHKNUM (IDX1)
               MOVE    SPA-X03-GMN-TSEL-NAME   (IDX1)
                                       TO  X03-TSEL-NAME   (IDX1)
               MOVE    SPA-X03-GMN-TSEL-YUKOSTYMD (IDX1)
                                       TO  X03-TSEL-YUKOSTYMD (IDX1)
               MOVE    SPA-X03-GMN-TSEL-YUKOEDYMD (IDX1)
                                       TO  X03-TSEL-YUKOEDYMD (IDX1)
      *
               IF    ( SPA-X03-GMN-SELCHKLST-SEL   =   IDX1 )
                   MOVE    "T"         TO  X03-SELCHKLST-SELECT (IDX1)
               ELSE
                   MOVE    "F"         TO  X03-SELCHKLST-SELECT (IDX1)
               END-IF
      *
           END-PERFORM
      *
           MOVE    SPA-X03-GMN-KJNYMD  TO  X03-KJNYMD
      *
           IF    ( SPA-X01-CHKKBN  =   "1" OR "2" )
               MOVE    "一致"          TO  X03-LBLLJYKN
                                           X03-LBLRJYKN
           END-IF
      *
           IF    ( FLG-LCHKLST-ROW     =   1 )
               MOVE    ZERO            TO  X03-LCHKLST-ROW
               MOVE    ZERO            TO  X03-LCHKLST-ROWATTR
           ELSE
               MOVE    WRK-LCHKLST-ROW TO  X03-LCHKLST-ROW
               MOVE    ZERO            TO  X03-LCHKLST-ROWATTR
           END-IF
      *
           IF    ( FLG-RCHKLST-ROW     =   1 )
               MOVE    ZERO            TO  X03-RCHKLST-ROW
               MOVE    ZERO            TO  X03-RCHKLST-ROWATTR
           ELSE
               MOVE    WRK-RCHKLST-ROW TO  X03-RCHKLST-ROW
               MOVE    ZERO            TO  X03-RCHKLST-ROWATTR
           END-IF
      *
           IF    ( FLG-SELCHKLST-ROW   =   1 )
               MOVE    ZERO            TO  X03-SELCHKLST-ROW
               MOVE    ZERO            TO  X03-SELCHKLST-ROWATTR
           ELSE
               MOVE    WRK-SELCHKLST-ROW
                                       TO  X03-SELCHKLST-ROW
               MOVE    ZERO            TO  X03-SELCHKLST-ROWATTR
           END-IF
      *
           MOVE    WIDGET-NORMAL       TO  X03-B09-STATE
                                           X03-B09-2-STATE
                                           X03-B10-STATE
                                           X03-B10-2-STATE
      *
           IF    ( SPA-X03-GMN-PAGE   <=  1 )
               MOVE    WIDGET-INSENSITIVE  TO  X03-B09-STATE
               MOVE    WIDGET-INSENSITIVE  TO  X03-B09-2-STATE
           END-IF
      *
           IF    ( SPA-X03-GMN-NEXT     =  ZERO )
               MOVE    WIDGET-INSENSITIVE  TO  X03-B10-STATE
               MOVE    WIDGET-INSENSITIVE  TO  X03-B10-2-STATE
           END-IF
      *
      *    カーソル位置
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソル位置処理
      *****************************************************************
       5001-MAPCUR-SEC                 SECTION.
      *
           IF    ( SPA-ERRCD           =   SPACE )
             AND ( SPA-X03-GMN-CUR     =   ZERO  )
               PERFORM 5011-INPUT-CUR-SEC
           END-IF
      *
           EVALUATE    SPA-X03-GMN-CUR
           WHEN    01
               MOVE    "CHKKBN"        TO  MCP-WIDGET
           WHEN    02
               MOVE    "SELNAME"       TO  MCP-WIDGET
           WHEN    03
               MOVE    "KJNYMD"        TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       5011-INPUT-CUR-SEC              SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "CHKKBN"
               MOVE    02              TO  SPA-X03-GMN-CUR
           WHEN    "SELNAME"
               MOVE    02              TO  SPA-X03-GMN-CUR
           WHEN    "KJNYMD"
               MOVE    02              TO  SPA-X03-GMN-CUR
           END-EVALUATE
      *
           .
      *
       5011-INPUT-CUR-EXT.
           EXIT.
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC                  SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
           WHEN    "0001"
               MOVE    "基準日入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0002"
               MOVE    "チェック区分入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0003"
               MOVE    "チェック名称入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "1001"
               MOVE    "登録上限数を超えています"
                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  XERR
           MOVE    SPA-ERRCD           TO  XERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  XERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "X03"               TO  SPA-MOTOPG
           MOVE    "XERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "XERR"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       800-SEIWA-HEN-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-HIZUKE-ERR
           MOVE    SPACE               TO  WRK-SYMD
                                           WRK-HENYMDG
      *
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    WRK-YMD             TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
           IF  ( SGDAY-RC              =   ZERO )
               MOVE    SGDAY-OTDAY     TO  WRK-HENYMDG
               MOVE    SGDAY-SDAY      TO  WRK-SYMD
           ELSE
               MOVE    1               TO  FLG-HIZUKE-ERR
           END-IF
      *
           .
       800-SEIWA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    全角半角混在チェック
      *****************************************************************
       800-ENRTRY-CHK-SEC              SECTION.
      *
           MOVE    ZERO                TO  FLG-ENTRYCHK
      *
           IF  ( WRK-KANACHK-MAE-INPUT =   SPACE )
               GO  TO  800-ENRTRY-CHK-EXT
           END-IF
      *
           MOVE    SPACE               TO  ORCSKANACHKAREA
           INITIALIZE                      ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    WRK-KANACHK-MAE-INPUT
                                       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           MOVE    KANACHK-OUT-INPUT   TO  WRK-KANACHK-OUT-INPUT
           IF      ( KANACHK-RC    NOT =   ZERO )
               MOVE    9               TO  FLG-ENTRYCHK
               GO  TO  800-ENRTRY-CHK-EXT
           END-IF
      *
           MOVE    KANACHK-SYUBETU     TO  FLG-ENTRYCHK
      *
           .
       800-ENRTRY-CHK-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ検索処理（ＫＥＹ１１）
      *****************************************************************
       900-CHK-KEY11-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-CHK
      *
           INITIALIZE                      CHK-REC
           MOVE    SPA-X03-GMN-CHKKBN  TO  CHK-CHKKBN
           MOVE    SPA-X03-NAI-KJNYMD  TO  CHK-YUKOSTYMD
                                           CHK-YUKOEDYMD
      *
           PERFORM VARYING IDX0    FROM    70  BY  -1
                   UNTIL ( IDX0    <   1 )
                    OR   ( SPA-X03-GMN-SELNAME (IDX0:1)
                               NOT =   SPACE )
      *
               CONTINUE
      *
           END-PERFORM
      *
           IF    ( IDX0    >   ZERO )
               STRING  SPA-X03-GMN-SELNAME (1:IDX0)
                                           DELIMITED   BY  SIZE
                       "%"                 DELIMITED   BY  SIZE
               INTO    CHK-SELNAME
               END-STRING
           ELSE
               MOVE    "%"             TO  CHK-SELNAME
           END-IF
      *
           MOVE    CHK-REC             TO  MCPDATA-REC
           MOVE    PATH-TBL-CHK-KEY11  TO  MCP-PATH
           PERFORM 911-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-CHK
               INITIALIZE                  CHK-REC
           END-IF
      *
           .
       900-CHK-KEY11-SEL-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ読込処理（ＫＥＹ１１）
      *****************************************************************
       900-CHK-KEY11-FET-SEC           SECTION.
      *
           MOVE    PATH-TBL-CHK-KEY11  TO  MCP-PATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  CHK-REC
           ELSE
               MOVE    1               TO  FLG-CHK
               INITIALIZE                  CHK-REC
           END-IF
      *
           .
       900-CHK-KEY11-FET-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ２検索処理（ＫＥＹ１１）
      *****************************************************************
       900-CHKSND-KEY11-SEL-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-CHKSND
      *
           INITIALIZE                      CHKSND-REC
           MOVE    SPA-X03-GMN-CHKKBN  TO  CHKSND-CHKKBN
           MOVE    SPA-X03-NAI-KJNYMD  TO  CHKSND-YUKOSTYMD
                                           CHKSND-YUKOEDYMD
      *
           PERFORM VARYING IDX0    FROM    70  BY  -1
                   UNTIL ( IDX0    <   1 )
                    OR   ( SPA-X03-GMN-SELNAME (IDX0:1)
                               NOT =   SPACE )
      *
               CONTINUE
      *
           END-PERFORM
      *
           IF    ( IDX0    >   ZERO )
               STRING  SPA-X03-GMN-SELNAME (1:IDX0)
                                           DELIMITED   BY  SIZE
                       "%"                 DELIMITED   BY  SIZE
               INTO    CHKSND-SELNAME
               END-STRING
           ELSE
               MOVE    "%"             TO  CHKSND-SELNAME
           END-IF
      *
           MOVE    CHKSND-REC          TO  MCPDATA-REC
           MOVE    PATH-TBL-CHKSND-KEY11   TO  MCP-PATH
           PERFORM 911-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-CHKSND
               INITIALIZE                  CHKSND-REC
           END-IF
      *
           .
       900-CHKSND-KEY11-SEL-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ２読込処理（ＫＥＹ１１）
      *****************************************************************
       900-CHKSND-KEY11-FET-SEC        SECTION.
      *
           MOVE    PATH-TBL-CHKSND-KEY11   TO  MCP-PATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  CHKSND-REC
           ELSE
               MOVE    1               TO  FLG-CHKSND
               INITIALIZE                  CHKSND-REC
           END-IF
      *
           .
       900-CHKSND-KEY11-FET-EXT.
           EXIT.
      *****************************************************************
      *    薬効マスタ検索処理（ＫＥＹ４）
      *****************************************************************
       900-MEDYAKKO-KEY4-SEL-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-MEDYAKKO
      *
           INITIALIZE                      MEDYAKKO-REC
           MOVE    SPA-X03-NAI-KJNYMD  TO  MYAK-SELYUKOSTYMD
                                           MYAK-SELYUKOEDYMD
      *
           PERFORM VARYING IDX0    FROM    70  BY  -1
                   UNTIL ( IDX0    <   1 )
                    OR   ( SPA-X03-GMN-SELNAME (IDX0:1)
                               NOT =   SPACE )
      *
               CONTINUE
      *
           END-PERFORM
      *
           IF    ( IDX0    >   ZERO )
               STRING  SPA-X03-GMN-SELNAME (1:IDX0)
                                           DELIMITED   BY  SIZE
                       "%"                 DELIMITED   BY  SIZE
               INTO    MYAK-SELNAME
               END-STRING
           ELSE
               MOVE    "%"             TO  MYAK-SELNAME
           END-IF
      *
           MOVE    MEDYAKKO-REC          TO  MCPDATA-REC
           MOVE    PATH-TBL-MEDYAKKO-KEY4   TO  MCP-PATH
           PERFORM 911-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-MEDYAKKO
               INITIALIZE                  MEDYAKKO-REC
           END-IF
      *
           .
       900-MEDYAKKO-KEY4-SEL-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ２読込処理（ＫＥＹ１１）
      *****************************************************************
       900-MEDYAKKO-KEY4-FET-SEC        SECTION.
      *
           MOVE    PATH-TBL-MEDYAKKO-KEY4   TO  MCP-PATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  MEDYAKKO-REC
           ELSE
               MOVE    1               TO  FLG-MEDYAKKO
               INITIALIZE                  MEDYAKKO-REC
           END-IF
      *
           .
       900-MEDYAKKO-KEY4-FET-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索処理
      *****************************************************************
       900-TENSU-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-TENSU
           INITIALIZE                      TNS-TENSU-REC
           MOVE    WRK-SRYCD           TO  TNS-SRYCD
           MOVE    WRK-YMD             TO  TNS-YUKOSTYMD
                                           TNS-YUKOEDYMD
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    PATH-TBL-TENSU-KEY  TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
           ELSE
               MOVE    1               TO  FLG-TENSU
               INITIALIZE                  TNS-TENSU-REC
           END-IF
      *
           MOVE    PATH-TBL-TENSU-KEY  TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-TENSU-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHも行う)
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHは行わない)
      *****************************************************************
       911-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       911-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBCLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"          TO  MCP-FUNC.
           CALL   "MCPSUB"         USING   MCPAREA
                                           MCPDATA-REC.
      *
       900-PUT-WINDOW-EXT.
           EXIT.
