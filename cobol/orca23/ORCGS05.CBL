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
       PROGRAM-ID.                 ORCGS05.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 収納登録
      *  コンポーネント名  : 未収検索画面　（Ｓ０５）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/09/30    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    診療行為用共通パラメタ
           COPY    "S01COMMON-SPA".
      *
           COPY    ENUM-VALUE.
      *
      *    スパ領域
       01  SPA-S05.
      *
           03  SPA-S05-AREA.
               05  SPA-GMN-CUR                     PIC 9(02).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-HEAD.
                       09  SPA-GMN-PTID            PIC 9(10).
                       09  SPA-GMN-PTNUM           PIC X(20).
                       09  SPA-GMN-LBLMSG          PIC X(50).
                       09  SPA-GMN-NAME            PIC X(100).
                   07  SPA-GMN-INPUT.
                       09  SPA-GMN-SELNUM          PIC 9(04).
                   07  SPA-GMN-MISYU.
                       09  SPA-GMN-GAI-MISYU       PIC S9(08).
                       09  SPA-GMN-NYU-MISYU       PIC S9(08).
                   07  SPA-GMN-SYULIST-PAGE        PIC 9(05).
                   07  SPA-GMN-SYULIST.
                       09  SPA-GMN-SYULIST-MAX     PIC 9(05).
                       09  SPA-GMN-SYULIST-NEXT    PIC 9(01).
                       09  SPA-GMN-SYULIST-OCC     OCCURS   200.
                           11  SPA-GMN-TBANGO      PIC 9(03).
                           11  SPA-GMN-TDENPNUM    PIC 9(07).
                           11  SPA-GMN-TNYUGAIKBN  PIC X(04).
                           11  SPA-GMN-TSRYKA      PIC X(06).
                           11  SPA-GMN-THKNCOMBI   PIC X(50).
                           11  SPA-GMN-TFTNRATE    PIC X(08).
                           11  SPA-GMN-TSRYYMD     PIC X(15).
                           11  SPA-GMN-TSKYEDYMD   PIC X(06).
                           11  SPA-GMN-THAKYMD     PIC X(09).
                           11  SPA-GMN-TSEIKYU     PIC 9(10).
                           11  SPA-GMN-TMISYU      PIC S9(10).
                           11  SPA-GMN-TJYOTAI     PIC X(16).
                       09  SPA-GMN-SYULIST-SEL     PIC 9(05).
      *
                   07  SPA-NAI-SYULIST.
                       09  SPA-NAI-SYULIST-OCC     OCCURS  200.
                           11  SPA-NAI-TSRYKA      PIC  X(02).
                           11  SPA-NAI-TSRYYMD     PIC  X(08).
                           11  SPA-NAI-THKNNUM     PIC  X(03).
                           11  SPA-NAI-THAKYMD     PIC  X(08).
                           11  SPA-NAI-TSKYEDYMD   PIC  X(08).
                           11  SPA-NAI-TNYUGAIKBN  PIC  X(01).
                           11  SPA-NAI-TJYOTAIKBN  PIC  X(01).
               05  SPA-NAI-AREA.
                   07  SPA-NAI-MISYUFLG            PIC  9(01).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-DBRC                            PIC 9(01).
           03  FLG-SYUNOU                          PIC 9(01).
           03  FLG-SKIP                            PIC 9(01).
           03  FLG-HIZUKE-ERR                      PIC 9(01).
           03  FLG-SYSKANRI                        PIC 9(01).
      *
      *    カウント領域
      * 01  CNT-AREA.
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                                PIC 9(05).
           03  IDXA                                PIC 9(05).
           03  IDXB                                PIC 9(05).
           03  IDX-LST                             PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-YMD                     PIC X(10).
           03  WRK-SYMD                    PIC X(08).
           03  WRK-HENYMDG                 PIC X(10).
           03  WRK-DBPATH                  PIC X(100).
           03  WRK-SKIP-KNS                PIC 9(05).
           03  WRK-SKIP-MAX                PIC 9(05).
           03  WRK-SEIKYU                  PIC ZZ,ZZZ,ZZZ.
           03  WRK-MISYU                   PIC --,---,---.
           03  WRK-MCP-WIDGET              PIC X(64).
           03  WRK-SRYKALST-G.
               05  WRK-SRYKALST-MAX        PIC 9(05).
               05  WRK-SRYKALST-OCC        OCCURS 50.
                   07  WRK-SRYKAL          PIC X(02).
                   07  WRK-SRYKAL-STYUKYMD PIC X(08).
                   07  WRK-SRYKAL-EDYUKYMD PIC X(08).
                   07  WRK-SRYKAMEIL       PIC X(12).
      *
      *    保険組合せ名称
           03  WRK-KUMINO                  PIC X(04).
           03  WRK-HKNKUMI                 PIC X(40).
           03  WRK-HKNNUM                  PIC X(03).
           03  WRK-ZZZ                     PIC ZZZ.
           03  WRK-SELNUMST                PIC 9(05).
           03  WRK-SELNUMED                PIC 9(05).
      *
       01  WK-GMN-RITU.
           03  WK-GMN-FTNRITU              PIC ZZZ.
           03  WK-GMN-PA                   PIC X(01).
           03  FILLER                      PIC X(01).
      *
       01  CONST-AREA.
           03  CONST-SYULIST-MAX           PIC 9(05)   VALUE 200.
      *
      *    スパ領域 ワーク
           COPY "COMMON-SPA"       REPLACING //SPA-//
                                   BY        //WRK-SPA-//.
      *
      *************************************************************
      *    ファイルレイアウト
      *************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
           COPY    "CPSK1005.INC".
      *
      *    収納マスター
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *************************************************************
      *    サブプロ用　領域
      *************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    保険組み合せ取得
           COPY    "CPORCSHKNSET.INC".
      *
      *   画面日付変換サブ
          COPY    "CPORCSGDAY.INC".
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *************************************************************
      *    連絡　領域
      *************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
      *****COPY    "S01.INC".
           COPY    "S02.INC".
           COPY    "S03.INC".
           COPY    "S03N.INC".
           COPY    "S04.INC".
           COPY    "S05.INC".
           COPY    "SERR.INC".
           COPY    "SID1.INC".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *
      *************************************************************
      *    主　　処理
      *************************************************************
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-S01KYOUTU
           MOVE    SPA-FREE        TO  SPA-S05
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN     "PUTG"           ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-S01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-S05         TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *************************************************************
      *    初期　処理
      *************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
      *    INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "SERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "S05"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
          .
       100-INIT-EXT.
           EXIT.
      *
      *************************************************************
      *    初期画面処理
      *************************************************************
       300-SCREEN-SEC             SECTION.
      *
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF
      *
           MOVE    SPA-WORK        TO  SPA-S01KYOUTU
      *
           PERFORM                 310-SPA-SET-SEC
      *
           .
      *
       300-SCREEN-EXT.
           EXIT.
      *
      *************************************************************
      *    画面編集処理
      *************************************************************
       310-SPA-SET-SEC                 SECTION.
      *
           INITIALIZE                  SPA-S05.
      *
           MOVE    SPA-S01-PTID        TO  SPA-GMN-PTID
           MOVE    SPA-S01-PTNUM       TO  SPA-GMN-PTNUM
           MOVE    SPA-S01-NAME        TO  SPA-GMN-NAME
           MOVE    SPA-S01-GAI-MISYU   TO  SPA-GMN-GAI-MISYU
           MOVE    SPA-S01-NYU-MISYU   TO  SPA-GMN-NYU-MISYU
      *
      *    検索結果リスト編集処理
           MOVE    1                   TO  SPA-GMN-SYULIST-PAGE
           PERFORM 3101-SYULIST-HEN-SEC
      *
           MOVE    1                   TO  SPA-GMN-CUR
      *
           IF    ( SPA-GMN-SYULIST-MAX =   ZERO )
               MOVE    1               TO  SPA-NAI-MISYUFLG
               MOVE    "未収金（過入金）はありません"
                                       TO  SPA-GMN-LBLMSG
           END-IF
      *
           .
       310-SPA-SET-EXT.
           EXIT.
      *
      *************************************************************
      *    検索結果リスト編集処理
      *************************************************************
       3101-SYULIST-HEN-SEC            SECTION.
      *
           INITIALIZE  SPA-GMN-SYULIST
                       SPA-NAI-SYULIST
      *
      *    診療科ワーク編集処理
           PERFORM 3101-SRYKALST-HEN-SEC
      *
      *    保険組み合わせ編集処理
           PERFORM 3101-HKNCOMBI-HEN-SEC
      *
           MOVE    ZERO                    TO  FLG-SYUNOU
           INITIALIZE                          SYUNOU-REC
      *
           MOVE    SPA-HOSPID              TO  SYU-HOSPID
           MOVE    SPA-S01-PTID            TO  SYU-PTID
           MOVE    SYUNOU-REC              TO  MCPDATA-REC
           MOVE    "SYUNOU-KEY24"          TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC            NOT =   ZERO )
               MOVE    1                   TO  FLG-SYUNOU
           ELSE
               MOVE    MCPDATA-REC         TO  SYUNOU-REC
           END-IF
      *
           PERFORM 3101-SYUNOU-SKIP-SEC
      *
           PERFORM UNTIL ( FLG-SYUNOU  NOT =   ZERO )
                    OR   ( SPA-GMN-SYULIST-MAX
                                           >=  CONST-SYULIST-MAX )
      *
               PERFORM 31011-SYULIST-HEN-SEC
      *
               MOVE    "SYUNOU-KEY24"          TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
               IF    ( FLG-DBRC            NOT =   ZERO )
                   MOVE    1                   TO  FLG-SYUNOU
               ELSE
                   MOVE    MCPDATA-REC         TO  SYUNOU-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    "SYUNOU-KEY24"              TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           IF    ( FLG-SYUNOU              =   ZERO )
                   MOVE    1                   TO  SPA-GMN-SYULIST-NEXT
           END-IF
      *
           .
       3101-SYULIST-HEN-EXT.
           EXIT.
      *************************************************************
      *    診療科ワーク編集処理
      *************************************************************
       3101-SRYKALST-HEN-SEC           SECTION.
      *
           INITIALIZE  WRK-SRYKALST-G
      *
           INITIALIZE  SYS-1005-REC
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY5"     TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        NOT =   ZERO )
               MOVE    1               TO  FLG-SYSKANRI
           ELSE
               MOVE    MCPDATA-REC     TO  SYS-1005-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-SYSKANRI    NOT =   ZERO )
                    OR   ( WRK-SRYKALST-MAX   >=   50   )
      *
               COMPUTE WRK-SRYKALST-MAX
                   =   WRK-SRYKALST-MAX    +   1
      *
               MOVE    WRK-SRYKALST-MAX    TO  IDXA
      *
               MOVE    SYS-1005-KBNCD      TO  WRK-SRYKAL    (IDXA)
               MOVE    SYS-1005-STYUKYMD   TO  WRK-SRYKAL-STYUKYMD
                                                             (IDXA)
               MOVE    SYS-1005-EDYUKYMD   TO  WRK-SRYKAL-EDYUKYMD
                                                             (IDXA)
               MOVE    SYS-1005-SRYKANAME1 TO  WRK-SRYKAMEIL
                                                             (IDXA)
      *
               MOVE    "SYSKANRI-KEY5"     TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
               IF    ( FLG-DBRC        NOT =   ZERO )
                   MOVE    1               TO  FLG-SYSKANRI
               ELSE
                   MOVE    MCPDATA-REC     TO  SYS-1005-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       3101-SRYKALST-HEN-EXT.
           EXIT.
      *************************************************************
      *    収納マスタ読込スキップ処理
      *************************************************************
       3101-SYUNOU-SKIP-SEC              SECTION.
      *
           COMPUTE WRK-SKIP-MAX    = ( SPA-GMN-SYULIST-PAGE   -   1 )
                                   *   CONST-SYULIST-MAX
      *
           MOVE    ZERO                    TO  WRK-SKIP-KNS
      *
           PERFORM UNTIL ( FLG-SYUNOU  NOT =   ZERO )
                    OR   ( WRK-SKIP-KNS    >=  WRK-SKIP-MAX )
      *
               COMPUTE WRK-SKIP-KNS    =   WRK-SKIP-KNS
                                       +   1
      *
               MOVE    "SYUNOU-KEY24"      TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
               IF    ( FLG-DBRC            NOT =   ZERO )
                   MOVE    1               TO  FLG-SYUNOU
               ELSE
                   MOVE    MCPDATA-REC     TO  SYUNOU-REC
               END-IF
      *
           END-PERFORM
      *
           .
       3101-SYUNOU-SKIP-EXT.
           EXIT.
      *************************************************************
      *    保険組み合わせ編集処理
      *************************************************************
       3101-HKNCOMBI-HEN-SEC           SECTION.
      *
           INITIALIZE                  ORCSHKNSETAREA
                                       WRK-SPA-AREA
      *
           MOVE    SPA-AREA            TO  WRK-SPA-AREA
      *
           MOVE    SPA-S01-PTID        TO  WRK-SPA-PTID
           MOVE    SPA-S01-BIRTHDAY    TO  WRK-SPA-BIRTHDAY
           MOVE    "2"                 TO  ORCSHKN-KBN
      *
           CALL    "ORCSHKNSET"        USING   WRK-SPA-AREA
                                               ORCSHKNSETAREA
           IF    ( ORCSHKN-ERRCD   NOT =   ZERO )
               INITIALIZE              ORCSHKNSETAREA
           END-IF
      *
           .
       3101-HKNCOMBI-HEN-EXT.
           EXIT.
      *************************************************************
      *    検索結果リスト編集処理
      *************************************************************
       31011-SYULIST-HEN-SEC           SECTION.
      *
      *    収納マスタ内容編集
      *
           COMPUTE SPA-GMN-SYULIST-MAX
               =   SPA-GMN-SYULIST-MAX    +   1
      *
           MOVE    SPA-GMN-SYULIST-MAX    TO  IDX-LST
      *
           COMPUTE SPA-GMN-TBANGO (IDX-LST)
               = ( SPA-GMN-SYULIST-PAGE   -   1 )
               *   CONST-SYULIST-MAX
               +   IDX-LST
      *
           MOVE    SYU-DENPNUM         TO  SPA-GMN-TDENPNUM (IDX-LST)
      *
      *    入外区分
           MOVE    SYU-NYUGAIKBN       TO  SPA-NAI-TNYUGAIKBN  (IDX-LST)
           EVALUATE    SYU-NYUGAIKBN
           WHEN    "1"
               MOVE    "入"            TO  SPA-GMN-TNYUGAIKBN  (IDX-LST)
           WHEN    "2"
               MOVE    "外"            TO  SPA-GMN-TNYUGAIKBN  (IDX-LST)
           END-EVALUATE
      *
      *    診療科名
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1        >   WRK-SRYKALST-MAX )
      *
               IF    ( SYU-SRYKA       =   WRK-SRYKAL (IDX1))
                AND  ( SYU-SRYYMD     >=   WRK-SRYKAL-STYUKYMD (IDX1))
                AND  ( SYU-SRYYMD     <=   WRK-SRYKAL-EDYUKYMD (IDX1))
                   MOVE    WRK-SRYKAMEIL (IDX1)
                                       TO  SPA-GMN-TSRYKA (IDX-LST)
                   MOVE    WRK-SRYKAL (IDX1)
                                       TO  SPA-NAI-TSRYKA (IDX-LST)
                   MOVE    WRK-SRYKALST-MAX
                                       TO  IDX1
               END-IF
      *
           END-PERFORM
      *
      *    診療日
           EVALUATE    SYU-NYUGAIKBN
           WHEN    "1"
               MOVE    SYU-SKYSTYMD    TO  SPA-NAI-TSRYYMD   (IDX-LST)
               MOVE    SYU-SKYSTYMD    TO  WRK-YMD
               PERFORM 800-SEIWA-HEN-SEC
               MOVE    WRK-HENYMDG     TO  SPA-GMN-TSRYYMD   (IDX-LST)
               MOVE    SYU-SKYEDYMD    TO  SPA-NAI-TSKYEDYMD (IDX-LST)
               MOVE    SYU-SKYEDYMD    TO  WRK-YMD
               PERFORM 800-SEIWA-HEN-SEC
               MOVE    "-"             TO  SPA-GMN-TSRYYMD (IDX-LST)
                                                           (10:1)
               MOVE    WRK-HENYMDG (5:5)
                                       TO  SPA-GMN-TSRYYMD (IDX-LST)
                                                           (11:5)
           WHEN    "2" 
               MOVE    SYU-SRYYMD      TO  SPA-NAI-TSRYYMD (IDX-LST)
               MOVE    SYU-SRYYMD      TO  WRK-YMD
               PERFORM 800-SEIWA-HEN-SEC
               MOVE    WRK-HENYMDG     TO  SPA-GMN-TSRYYMD (IDX-LST)
           END-EVALUATE
      *
      *    発行日
           MOVE    SYU-DENPPRTYMD      TO  SPA-NAI-THAKYMD (IDX-LST)
           MOVE    SYU-DENPPRTYMD      TO  WRK-YMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  SPA-GMN-THAKYMD (IDX-LST)
      *    請求金額
           MOVE    SYU-SKYMONEY        TO  SPA-GMN-TSEIKYU (IDX-LST)
      *    未収金額
           COMPUTE SPA-GMN-TMISYU(IDX-LST) =   SYU-SKYMONEY
                                           -   SYU-NYUKIN-TOTAL
      *
      *    保険組合せより（保険と負担）
           MOVE    SYU-HKNCOMBINUM     TO  WRK-KUMINO
           PERFORM 31011-HKNCOMBIMEI-HEN-SEC
           MOVE    WRK-HKNKUMI         TO  SPA-GMN-THKNCOMBI (IDX-LST)
           MOVE    WRK-HKNNUM          TO  SPA-NAI-THKNNUM   (IDX-LST)
      *
      *    患者負担率
           IF    ( SYU-PTFTNRATE       =   ZERO )
               MOVE    SPACE           TO  SPA-GMN-TFTNRATE (IDX-LST)
           ELSE
               MOVE    SPACE           TO  WK-GMN-RITU
               MOVE    SYU-PTFTNRATE   TO  WK-GMN-FTNRITU
               MOVE    "%"             TO  WK-GMN-PA
               MOVE    WK-GMN-RITU     TO  SPA-GMN-TFTNRATE (IDX-LST)
           END-IF
      *
           MOVE    SYU-DENPJTIKBN      TO  SPA-NAI-TJYOTAIKBN (IDX-LST)
      *
      *    伝票状態区分
           EVALUATE   SYU-DENPJTIKBN   ALSO   SYU-CREATEKBN
           WHEN   SPACE                ALSO   SPACE
               MOVE  "請求額なし"      TO  SPA-GMN-TJYOTAI (IDX-LST)
           WHEN   "1"                  ALSO   SPACE
               MOVE  "入金済"          TO  SPA-GMN-TJYOTAI (IDX-LST)
           WHEN   "2"                  ALSO   SPACE
               MOVE  "未入金"          TO  SPA-GMN-TJYOTAI (IDX-LST)
           WHEN   "3"                  ALSO   SPACE
               MOVE  "請求取消し"      TO  SPA-GMN-TJYOTAI (IDX-LST)
           WHEN   "7"                  ALSO   SPACE
               MOVE  "継続"            TO  SPA-GMN-TJYOTAI (IDX-LST)
           WHEN   SPACE                ALSO   "1"
               MOVE  "請求額なし（退）"
                                       TO  SPA-GMN-TJYOTAI (IDX-LST)
           WHEN   "1"                  ALSO   "1"
               MOVE  "入金済（退）"
                                       TO  SPA-GMN-TJYOTAI (IDX-LST)
           WHEN   "2"                  ALSO   "1"
               MOVE  "未入金（退）"
                                       TO  SPA-GMN-TJYOTAI (IDX-LST)
           WHEN   "3"                  ALSO   "1"
               MOVE  "請求取消し（退）"
                                       TO  SPA-GMN-TJYOTAI (IDX-LST)
           WHEN   "7"                  ALSO   "1"
               MOVE  "継続（退）"      TO  SPA-GMN-TJYOTAI (IDX-LST)
           WHEN   SPACE                ALSO   "2"
               MOVE  "請求額なし（定）"
                                       TO  SPA-GMN-TJYOTAI (IDX-LST)
           WHEN   "1"                  ALSO   "2"
               MOVE  "入金済（定）"    TO  SPA-GMN-TJYOTAI (IDX-LST)
           WHEN   "2"                  ALSO   "2"
               MOVE  "未入金（定）"    TO  SPA-GMN-TJYOTAI (IDX-LST)
           WHEN   "3"                  ALSO   "2"
               MOVE  "請求取消し（定）"
                                       TO  SPA-GMN-TJYOTAI (IDX-LST)
           WHEN   "7"                  ALSO   "2"
               MOVE  "継続（定）"      TO  SPA-GMN-TJYOTAI (IDX-LST)
           END-EVALUATE
      *
           .
       31011-SYULIST-HEN-EXT.
           EXIT.
      *************************************************************
      *    保険組み合わせ名称編集処理
      *************************************************************
       31011-HKNCOMBIMEI-HEN-SEC       SECTION.
      *
      *    対象の保険組み合わせが存在すればその名称を、
      *    なければ保険組み合わせ番号を表示する
      *
           MOVE    SPACE           TO  WRK-HKNKUMI
                                       WRK-HKNNUM
      *
           PERFORM VARYING IDXB    FROM    1   BY  1
                   UNTIL ( IDXB   >    100 )
      *
               IF    ( WRK-KUMINO  =   ORCSHKN-GMN-HKNCOMBINUM (IDXB))
                   MOVE    ORCSHKN-GMN-HKNCOMBIMEI (IDXB)
                                       TO  WRK-HKNKUMI
                   MOVE    ORCSHKN-NAI-HKNNUM  (IDXB)
                                       TO  WRK-HKNNUM
                   MOVE    100         TO  IDXB
               END-IF
      *
           END-PERFORM
      *
           IF    ( WRK-HKNKUMI     =   SPACE )
               MOVE    WRK-KUMINO  TO  WRK-HKNKUMI
           END-IF
      *
           .
       31011-HKNCOMBIMEI-HEN-EXT.
           EXIT.
      *************************************************************
      *    画面遷移処理
      *************************************************************
       200-GMNSENI                   SECTION.
      *
           MOVE    MCP-WIDGET      TO      WRK-MCP-WIDGET
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *
      *    戻る
           WHEN    "CLICKED"       ALSO    "B01"
               MOVE    ZERO        TO      SPA-S01-DENPNUM
               PERFORM 210-BACK
      *
      *    前頁
           WHEN    "CLICKED"       ALSO    "B06"
               PERFORM 220-PAGE-BACK-SEC
      *
      *    次頁
           WHEN    "CLICKED"       ALSO    "B07"
               PERFORM 230-PAGE-NEXT-SEC
           END-EVALUATE
           .
       200-GMNSENI-EXT.
           EXIT.
      *************************************************************
      *    会話　処理
      *************************************************************
       200-ENTRY                       SECTION.
      *
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
      *
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *
      *    選択番号
           WHEN    "ACTIVATE"      ALSO    "SELNUM"
                   PERFORM 4100-SELNUM-CHK-SEC
      *
      *    収納情報リスト
           WHEN    ANY             ALSO    "SYULIST"
                   PERFORM 4100-SYULIST-CHK-SEC
           WHEN    OTHER
      *
               MOVE    ZERO            TO  SPA-GMN-CUR
      *
      *        入力チェック処理
               PERFORM 410-INPUT-CHK-SEC
      *
           END-EVALUATE
      *
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
      *
           .
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC              SECTION.
      *
           .
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納情報リストチェック
      *****************************************************************
       4100-SYULIST-CHK-SEC            SECTION.
      *
           MOVE    ZERO                TO  SPA-GMN-SELNUM
                                           SPA-GMN-SYULIST-SEL
      *
           PERFORM VARYING IDX-LST     FROM    1   BY  1
                   UNTIL ( IDX-LST     >   SPA-GMN-SYULIST-MAX )
      *
               IF    ( S05-SYULIST-SELECT (IDX-LST) =   "T" )
                   MOVE    IDX-LST     TO  SPA-GMN-SYULIST-SEL
      *
                   COMPUTE SPA-GMN-SELNUM
                       = ( SPA-GMN-SYULIST-PAGE  - 1 )
                       *   CONST-SYULIST-MAX
                       +   IDX-LST
      *
                   MOVE    SPA-GMN-SYULIST-MAX
                                       TO  IDX-LST
               END-IF
      *
           END-PERFORM
      *
           IF    ( SPA-GMN-SYULIST-SEL     >   ZERO )
               PERFORM 4200-S01-SPA-SET-SEC
               PERFORM 210-BACK
           END-IF
      *
           .
      *
       4100-SYULIST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    選択番号チェック
      *****************************************************************
       4100-SELNUM-CHK-SEC             SECTION.
      *
           MOVE    1                   TO  SPA-GMN-CUR
      *
           MOVE    ZERO                TO  SPA-GMN-SYULIST-SEL
           MOVE    S05-SELNUM          TO  SPA-GMN-SELNUM
      *
           IF    ( SPA-GMN-SELNUM      =   ZERO )
               MOVE    1               TO  SPA-GMN-CUR
               GO  TO  4100-SELNUM-CHK-EXT
           END-IF
      *
           PERFORM 41001-SELNUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-SELNUM-CHK-EXT
           END-IF
      *
           COMPUTE SPA-GMN-SYULIST-SEL
               =   SPA-GMN-SELNUM
               - ( SPA-GMN-SYULIST-PAGE  - 1 )
               *   CONST-SYULIST-MAX
      *
           PERFORM 4200-S01-SPA-SET-SEC
           PERFORM 210-BACK
      *
           .
      *
       4100-SELNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    選択番号チェック
      *****************************************************************
       41001-SELNUM-CHK-SEC            SECTION.
      *
           COMPUTE WRK-SELNUMST
               = ( SPA-GMN-SYULIST-PAGE  - 1 )
               *   CONST-SYULIST-MAX
               +   1
      *
           COMPUTE WRK-SELNUMED
               = ( SPA-GMN-SYULIST-PAGE  - 1 )
               *   CONST-SYULIST-MAX
               +   SPA-GMN-SYULIST-MAX
      *
           IF    ( SPA-GMN-SELNUM      >=  WRK-SELNUMST )
            AND  ( SPA-GMN-SELNUM      <=  WRK-SELNUMED )
               CONTINUE
           ELSE
               MOVE    "0001"          TO  SPA-ERRCD
               MOVE    1               TO  SPA-GMN-CUR
               GO  TO  41001-SELNUM-CHK-EXT
           END-IF
      *
           .
       41001-SELNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    返却値設定処理
      *****************************************************************
       4200-S01-SPA-SET-SEC            SECTION.
      *
           MOVE    SPA-GMN-SYULIST-SEL     TO  IDX1
           MOVE    SPA-NAI-TSRYYMD (IDX1) (1:6)
                                           TO  SPA-S01-SRYYM
           MOVE    SPA-GMN-TSRYYMD (IDX1) (1:6)
                                           TO  SPA-S01-SRYYMW
           MOVE    SPA-GMN-TDENPNUM(IDX1)  TO  SPA-S01-DENPNUM
      *
           .
       4200-S01-SPA-SET-EXT.
           EXIT.
      *************************************************************
      *    戻る　処理
      *************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "S02"               TO  SPA-SAKIPG
           MOVE    "S05"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *************************************************************
      *    前頁処理
      *************************************************************
       220-PAGE-BACK-SEC               SECTION.
      *
           IF    ( SPA-GMN-SYULIST-PAGE   <=   1 )
               GO  TO  220-PAGE-BACK-EXT
           END-IF
      *
           COMPUTE SPA-GMN-SYULIST-PAGE
               =   SPA-GMN-SYULIST-PAGE   -   1
      *
           PERFORM 3101-SYULIST-HEN-SEC
      *
           .
       220-PAGE-BACK-EXT.
           EXIT.
      *************************************************************
      *    次頁処理
      *************************************************************
       230-PAGE-NEXT-SEC               SECTION.
      *
           IF    ( SPA-GMN-SYULIST-NEXT    NOT =   1 )
               GO  TO  230-PAGE-NEXT-EXT
           END-IF
      *
           COMPUTE SPA-GMN-SYULIST-PAGE
               =   SPA-GMN-SYULIST-PAGE    +   1
      *
           PERFORM 3101-SYULIST-HEN-SEC
      *
           .
       230-PAGE-NEXT-EXT.
           EXIT.
      *************************************************************
      *    自画面編集処理
      *************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC.
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF.
      *
      *
      *    PERFORM 510-ERRSET-SEC.
      *
           MOVE    SPACE               TO  LNK-KYOUTU.
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "S05    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *
      *************************************************************
      *    画面編集処理
      *************************************************************
       500-GMNHEN-SEC                  SECTION.
      *
           MOVE    SPACE               TO  S05
           INITIALIZE                      S05
      *
           MOVE   SPA-GMN-PTNUM        TO  S05-PTNUM
           MOVE   SPA-GMN-NAME         TO  S05-NAME
      *
           MOVE   SPA-GMN-SELNUM       TO  S05-SELNUM
           MOVE   SPA-GMN-GAI-MISYU    TO  S05-GAI-MISYU
           MOVE   SPA-GMN-NYU-MISYU    TO  S05-NYU-MISYU
      *
           MOVE   SPA-GMN-SYULIST-MAX  TO  S05-SYULIST-COUNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   SPA-GMN-SYULIST-MAX )
      *
               MOVE    SPA-GMN-TBANGO (IDX1)   TO  WRK-ZZZ
               MOVE    WRK-ZZZ                 TO  S05-TNUM       (IDX1)
               MOVE    SPA-GMN-TDENPNUM(IDX1)  TO  S05-TDENPNUM   (IDX1)
               MOVE    SPA-GMN-TNYUGAIKBN(IDX1)
                                               TO  S05-TNYUGAI    (IDX1)
               MOVE    SPA-GMN-TSRYKA(IDX1)    TO  S05-TSRYKA     (IDX1)
               MOVE    SPA-GMN-THKNCOMBI(IDX1) TO  S05-THKN       (IDX1)
               MOVE    SPA-GMN-TFTNRATE(IDX1)  TO  S05-TFTNRATE   (IDX1)
               MOVE    SPA-GMN-THAKYMD (IDX1)  TO  S05-TSKYSTYMD  (IDX1)
               MOVE    SPA-GMN-TSRYYMD (IDX1)  TO  S05-TSRYYMD    (IDX1)
               MOVE    SPA-GMN-TSEIKYU(IDX1)   TO  WRK-SEIKYU
               MOVE    WRK-SEIKYU              TO  S05-TSKYMONEY  (IDX1)
               MOVE    SPA-GMN-TMISYU (IDX1)   TO  WRK-MISYU
               MOVE    WRK-MISYU               TO  S05-TMISYUMONEY(IDX1)
               MOVE    SPA-GMN-TJYOTAI (IDX1)  TO  S05-TDENPJTI   (IDX1)
      *
               IF    ( SPA-GMN-SYULIST-SEL     =   IDX1 )
                   MOVE    "T"                 TO  S05-SYULIST-SELECT
                                                                  (IDX1)
               ELSE
                   MOVE    "F"                 TO  S05-SYULIST-SELECT
                                                                  (IDX1)
               END-IF
      *
           END-PERFORM
      *
           IF    ( SPA-GMN-SYULIST-PAGE   <=   1 )
               MOVE    WIDGET-INSENSITIVE  TO  S05-B06-STATE
           ELSE
               MOVE    WIDGET-NORMAL       TO  S05-B06-STATE
           END-IF
      *
           IF    ( SPA-GMN-SYULIST-NEXT    =   ZERO )
               MOVE    WIDGET-INSENSITIVE  TO  S05-B07-STATE
           ELSE
               MOVE    WIDGET-NORMAL       TO  S05-B07-STATE
           END-IF
      *
           IF    ( SPA-NAI-MISYUFLG        =   1 )
               MOVE    "blue"              TO  S05-LBLMSG-STYLE
               MOVE    SPA-GMN-LBLMSG      TO  S05-LBLMSG
           END-IF
      *
           PERFORM 5001-MAPCUR-SEC
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *************************************************************
      *    エラーメッセージ表示理
      *************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    SPACE                   TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
           WHEN    "0001"
               MOVE    "選択番号入力エラー"
                                           TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                   TO  SERR
           MOVE    SPA-ERRCD               TO  SERR-ERRCODE
           MOVE    SPA-ERRMSG              TO  SERR-ERRMSG
           MOVE    "B01"                   TO  MCP-WIDGET
      *
           MOVE    "S05"                   TO  SPA-MOTOPG
           MOVE    "SERR"                  TO  SPA-SAKIPG
      *
           MOVE    "NEW"                   TO  MCP-PUTTYPE
           MOVE    "SERR"                  TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                       TO  FLG-END
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理    
      *****************************************************************
       5001-MAPCUR-SEC                 SECTION.
      *
           IF    ( SPA-GMN-CUR         =   ZERO )
               PERFORM 50011-GMN-CUR-SET-SEC
           END-IF
      *
           EVALUATE    SPA-GMN-CUR
           WHEN    01
               MOVE  "SELNUM"          TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力カーソル位置編集処理
      *****************************************************************
       50011-GMN-CUR-SET-SEC      SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "SELNUM"
               MOVE    01              TO  SPA-GMN-CUR
           END-EVALUATE
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "SELNUM"
               MOVE    01              TO  SPA-GMN-CUR
           END-EVALUATE
      *
           .
       50011-GMN-CUR-SET-EXT.
           EXIT.
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
      *    テーブル検索処理
      *****************************************************************
       900-TBL-SELECT-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               MOVE    WRK-DBPATH  TO  ORC-DBPATH
               MOVE    "DBFETCH"   TO  MCP-FUNC
               CALL    "ORCMCPSUB"     USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
               IF    ( MCP-RC          =   ZERO )
                   CONTINUE
               ELSE
                   MOVE    1       TO  FLG-DBRC
               END-IF
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル読込処理
      *****************************************************************
       900-TBL-READ-SEC                SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-READ-EXT.
           EXIT.
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       900-TBL-CLOSE-SEC               SECTION.
      *
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-TBL-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    テーブル更新処理
      *****************************************************************
       900-TBL-UPDATE-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           MOVE    "DBUPDATE"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-UPDATE-EXT.
           EXIT.
      *****************************************************************
      *    テーブル追加処理
      *****************************************************************
       900-TBL-INSERT-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           MOVE    "DBINSERT"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-INSERT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル削除処理
      *****************************************************************
       900-TBL-DELETE-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           MOVE    "DBDELETE"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-DELETE-EXT.
           EXIT.
      *************************************************************
      *    ＰＵＴ　処理
      *************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL   "ORCMCPSUB"   USING
                                MCPAREA
                                ORCMCPAREA
                                MCPDATA-REC.
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
