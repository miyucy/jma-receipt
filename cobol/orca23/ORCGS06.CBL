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
       PROGRAM-ID.                 ORCGS06.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 収納登録
      *  コンポーネント名  : 一括入金画面　（Ｓ０６）
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
      *    収納共通パラメタ
           COPY    "S01COMMON-SPA".
      *
           COPY    ENUM-VALUE.
      *
      *    スパ領域
       01  SPA-S06.
      *
           03  SPA-S06-AREA.
               05  SPA-GMN-CUR                     PIC 9(03).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-HEAD.
                       09  SPA-GMN-PTID            PIC 9(10).
                       09  SPA-GMN-PTNUM           PIC X(20).
                       09  SPA-GMN-NAME            PIC X(100).
                       09  SPA-GMN-NYUGAIKBN-G.
                           11  SPA-GMN-NYUGAIKBN   PIC X(01).
                           11                      PIC X(01).
                           11  SPA-GMN-NYUGAIKBNMEI
                                                   PIC X(08).
                       09  SPA-GMN-LBLMSG          PIC X(50).
                   07  SPA-GMN-INPUT.
                       09  SPA-GMN-SELNUM          PIC 9(03).
                       09  SPA-GMN-RD-NYUKIN-IKT   PIC X(01).
                       09  SPA-GMN-RD-NYUKIN-KBT   PIC X(01).
                       09  SPA-GMN-NYKNKNRKBN-G.
                           11  SPA-GMN-NYKNKNRKBN  PIC X(01).
                           11                      PIC X(01).
                           11  SPA-GMN-NYKNKNRKBNMEI
                                                   PIC X(40).
                       09  SPA-GMN-NYUKINYMD       PIC X(10).
                       09  SPA-GMN-SKYPRTKBN-G.
                           11  SPA-GMN-SKYPRTKBN   PIC X(01).
                           11                      PIC X(01).
                           11  SPA-GMN-SKYPRTKBNMEI
                                                   PIC X(12).
                       09  SPA-GMN-IKT-NYUKIN-VAL.
                           11  SPA-GMN-NYU-NYUKIN      PIC S9(09).
                           11  SPA-GMN-NYU-NYUKIN-MAX  PIC S9(09).
                           11  SPA-GMN-GAI-NYUKIN      PIC S9(09).
                           11  SPA-GMN-GAI-NYUKIN-MAX  PIC S9(09).
                       09  SPA-GMN-IKT-NYUKIN-R REDEFINES
                                                SPA-GMN-IKT-NYUKIN-VAL.
                           11  SPA-GMN-IKT-NYUKIN-OCC  OCCURS  2.
                               13  SPA-GMN-IKT-NYUKIN  PIC S9(09).
                               13  SPA-GMN-IKT-NYUKIN-MAX
                                                       PIC S9(09).
                       09  SPA-GMN-KBT-NYUKIN-VAL.
                           11  SPA-GMN-NYUKIN      PIC S9(09).
                           11  SPA-GMN-NYUKIN-MAX  PIC S9(09).
                   07  SPA-GMN-MISYU.
                       09  SPA-GMN-GAI-MISYU       PIC S9(08).
                       09  SPA-GMN-NYU-MISYU       PIC S9(08).
                   07  SPA-GMN-NYUGAIKBNLST-G.
                       09  SPA-GMN-NYUGAIKBN-MAX   PIC 9(03).
                       09  SPA-GMN-NYUGAIKBNLST    OCCURS  3.
                           11  SPA-GMN-NYUGAIKBNL  PIC X(01).
                           11                      PIC X(01).
                           11  SPA-GMN-NYUGAIKBNMEIL
                                                   PIC X(08).
                   07  SPA-GMN-NYKNKNRKBNLST-G.
                       09  SPA-GMN-NYKNKNRKBN-MAX  PIC 9(03).
                       09  SPA-GMN-NYKNKNRKBNLST   OCCURS  5.
                           11  SPA-GMN-NYKNKNRKBNL PIC X(01).
                           11                      PIC X(01).
                           11  SPA-GMN-NYKNKNRKBNMEIL
                                                   PIC X(40).
                   07  SPA-GMN-SKYPRTKBNLST-G.
                       09  SPA-GMN-SKYPRTKBN-MAX   PIC 9(03).
                       09  SPA-GMN-SKYPRTKBNLST    OCCURS  2.
                           11  SPA-GMN-SKYPRTKBNL  PIC X(01).
                           11                      PIC X(01).
                           11  SPA-GMN-SKYPRTKBNMEIL
                                                   PIC X(12).
                   07  SPA-GMN-SYULIST.
                       09  SPA-GMN-SYULIST-MAX     PIC 9(05).
                       09  SPA-GMN-SYULIST-OCC     OCCURS   400.
                           11  SPA-GMN-TBANGO      PIC 9(03).
                           11  SPA-GMN-TDENPNUM    PIC 9(07).
                           11  SPA-GMN-TNYUGAIKBN  PIC X(04).
                           11  SPA-GMN-TSRYKA      PIC X(06).
                           11  SPA-GMN-THKNCOMBI   PIC X(50).
                           11  SPA-GMN-TFTNRATE    PIC X(08).
                           11  SPA-GMN-TSRYYMD     PIC X(15).
                           11  SPA-GMN-TSKYEDYMD   PIC X(06).
                           11  SPA-GMN-THAKYMD     PIC X(09).
                           11  SPA-GMN-TSEIKYU     PIC S9(10).
                           11  SPA-GMN-TMISYU      PIC S9(10).
                           11  SPA-GMN-TNYUKIN     PIC S9(10).
      *
      *                コラムリストに表示させる収納の連番情報
                       09  SPA-GMN-SYULIST-OUT-G.
                           11  SPA-GMN-SYULIST-OUT-MAX
                                                   PIC 9(05).
                           11  SPA-GMN-SYULIST-OUT-OCC OCCURS  400.
                               13  SPA-GMN-SYULIST-OUT-IDX
                                                   PIC 9(03).
      *
                       09  SPA-GMN-SYULIST-SEL     PIC 9(05).
      *
                   07  SPA-NAI-SYULIST.
                       09  SPA-NAI-SYULIST-OCC     OCCURS  400.
                           11  SPA-NAI-TSRYKA      PIC  X(02).
                           11  SPA-NAI-TSRYYMD     PIC  X(08).
                           11  SPA-NAI-THAKYMD     PIC  X(08).
                           11  SPA-NAI-TNYUGAIKBN  PIC  X(01).
                           11  SPA-NAI-TDENPJTIKBN PIC  X(01).
               05  SPA-NAI-AREA.
                   07  SPA-NAI-HEAD.
                       09  SPA-NAI-MISYUFLG        PIC  9(01).
                   07  SPA-NAI-INPUT.
                       09  SPA-NAI-NYUKINYMD       PIC  X(08).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-SYUNOU                          PIC 9(01).
           03  FLG-HIZUKE-ERR                      PIC 9(01).
           03  FLG-SYSKANRI                        PIC 9(01).
           03  FLG-SYULIST-HEN                     PIC 9(01).
           03  FLG-LOOP-END                        PIC 9(01).
           03  FLG-GMN-INIT                        PIC 9(01).
      *
      *    カウント領域
      * 01  CNT-AREA.
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                                PIC 9(05).
           03  IDX1                                PIC 9(05).
           03  IDX2                                PIC 9(05).
           03  IDX3                                PIC 9(05).
           03  IDXA                                PIC 9(05).
           03  IDXB                                PIC 9(05).
           03  IDX-OUT                             PIC 9(05).
           03  IDX-LST                             PIC 9(05).
           03  IDX-KBT                             PIC 9(05).
           03  IDX-CMB                             PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-YMD                     PIC X(10).
           03  WRK-SYMD                    PIC X(08).
           03  WRK-HENYMDG                 PIC X(10).
           03  WRK-CMB-CD                  PIC X(10).
           03  WRK-CMB-ITM-G.
               07  WRK-CMB-ITM             PIC X(200).
           03  WRK-KINGAKU                 PIC ---,---,---.
           03  WRK-MCP-WIDGET              PIC X(64).
           03  WRK-NYUGAIKBN               PIC X(01).
           03  WRK-DENPNUM                 PIC 9(07).
           03  WRK-SIDMSG                  PIC X(70).
      *
      *    保険組合せ名称
           03  WRK-KUMINO                  PIC X(04).
           03  WRK-HKNKUMI                 PIC X(40).
           03  WRK-HKNNUM                  PIC X(03).
           03  WRK-ZZZ                     PIC ZZZ.
           03  WRK-NYU-NYUKIN              PIC 9(10).
           03  WRK-GAI-NYUKIN              PIC 9(10).
           03  WRK-NYUKIN                  PIC 9(10).
           03  WRK-NYU-SEIKYU-PG           PIC X(20).
           03  WRK-GAI-SEIKYU-PG           PIC X(20).
      *
       01  WRK-ROW-AREA.
           03  WRK-SYULIST-ROW             PIC S9(9)   BINARY.
      *
       01  WK-GMN-RITU.
           03  WK-GMN-FTNRITU              PIC ZZZ.
           03  WK-GMN-PA                   PIC X(01).
           03  FILLER                      PIC X(01).
      *
       01  S1005-SRYKALST-G.
           03  S1005-SRYKALST-MAX          PIC 9(05).
           03  S1005-SRYKALST-OCC          OCCURS 50.
               05  S1005-SRYKAL            PIC X(02).
               05  S1005-SRYKAL-STYUKYMD   PIC X(08).
               05  S1005-SRYKAL-EDYUKYMD   PIC X(08).
               05  S1005-SRYKAMEIL         PIC X(12).
      *
       01  CONST-AREA.
           03  CONST-SYULIST-MAX           PIC 9(05)   VALUE 400.
           03  CONST-SYULIST-OUT-MAX       PIC 9(05)   VALUE 400.
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
           COPY    "CPSK1032.INC".
           COPY    "CPSK1035.INC".
           COPY    "CPSK1039.INC".
      *
      *    収納マスター
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *************************************************************
      *    サブプロ用　領域
      *************************************************************
      *
      *    請求書印刷パラメタ
           COPY    "CPORCHC03.INC".
      *
      *    入院請求書印刷パラメタ
           COPY    "CPORCHCN03.INC".
      *
      *    まとめ入金編集サブ
           COPY    "CPORCSNYUKINS.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    保険組み合せ取得
           COPY    "CPORCSHKNSET.INC".
      *
      *    画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
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
           COPY    "S06.INC".
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
           MOVE    SPA-FREE        TO  SPA-S06
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *    INITIALIZE                  CNT-AREA
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
           MOVE    SPA-S06         TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *************************************************************
      *    初期　処理
      *************************************************************
       100-INIT-SEC                SECTION.
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "SERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF    ( FLG-END         =   1 )
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "S06"               TO  MCP-WINDOW.
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
           EVALUATE    SPA-MOTOPG
           WHEN    "SID1"
               PERFORM 330-SID1-SET-SEC
               GO  TO  300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM                 310-SPA-SET-SEC
      *
           .
      *
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＳＩＤ１）ＯＫ処理
      *****************************************************************
       330-SID1-SET-SEC            SECTION.
      *
           IF      SPA-SID1-FLG    =   "OK"
               IF      SPA-SIDCD            =   "2001"
                   PERFORM 4801-TOUROKU-SEC
               END-IF
           END-IF
      *
           MOVE    SPACE           TO  SPA-SID1-FLG
           MOVE    SPACE           TO  SPA-SIDCD
           .
       330-SID1-SET-EXT.
           EXIT.
      *************************************************************
      *    画面編集処理
      *************************************************************
       310-SPA-SET-SEC                 SECTION.
      *
           INITIALIZE                  SPA-S06.
      *
           MOVE    SPA-S01-PTID        TO  SPA-GMN-PTID
           MOVE    SPA-S01-PTNUM       TO  SPA-GMN-PTNUM
           MOVE    SPA-S01-NAME        TO  SPA-GMN-NAME
      *
      *    収納機能情報取得
           PERFORM 3101-SYS-1039-GET-SEC
      *
      *    入外区分コンボ編集
           PERFORM 3101-NYUGAIKBNLST-HEN-SEC
      *
      *    入金管理区分コンボ編集
           PERFORM 3101-NYKNKNRKBNLST-HEN-SEC
      *
      *    請求書発行区分コンボ編集
           PERFORM 3101-SKYPRTKBNLST-HEN-SEC
      *
      *    入外区分コンボ初期値
           MOVE    SPA-GMN-NYUGAIKBNLST (1)
                                       TO  SPA-GMN-NYUGAIKBN-G
      *
      *    入金管理区分コンボ初期値
           MOVE    SYS-1039-NYKNKNRKBN TO  WRK-CMB-CD
           PERFORM 4200-NYKNKNRKBNLST-CHK-SEC
           IF    ( WRK-CMB-ITM         =   SPACE )
               MOVE    SPA-GMN-NYKNKNRKBNLST (1)
                                       TO  SPA-GMN-NYKNKNRKBN-G
           ELSE
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-NYKNKNRKBN-G
           END-IF
      *
      *    請求書兼領収書発行区分コンボ初期値
           MOVE    SYS-1039-SKYPRTKBN  TO  WRK-CMB-CD
           PERFORM 4200-SKYPRTKBNLST-CHK-SEC
           IF    ( WRK-CMB-ITM         =   SPACE )
               MOVE    SPA-GMN-SKYPRTKBNLST (1)
                                       TO  SPA-GMN-SKYPRTKBN-G
           ELSE
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-SKYPRTKBN-G
           END-IF
      *
           MOVE    "T"                 TO  SPA-GMN-RD-NYUKIN-IKT
           MOVE    "F"                 TO  SPA-GMN-RD-NYUKIN-KBT
      *
           MOVE    SPA-SYSYMDWH        TO  SPA-GMN-NYUKINYMD
           MOVE    SPA-SYSYMD          TO  SPA-NAI-NYUKINYMD
      *
      *    初期表示処理
           PERFORM 310-SYOKI-HYOJI-SEC
      *
           .
       310-SPA-SET-EXT.
           EXIT.
      *
      *************************************************************
      *    初期表示処理
      *************************************************************
       310-SYOKI-HYOJI-SEC             SECTION.
      *
      *    検索結果リスト編集処理
           PERFORM 3101-SYULIST-HEN-SEC
      *
      *    収納情報リスト画面表示編集処理
           PERFORM 3101-SYULIST-OUT-HEN-SEC
      *
      *    未収額合計編集処理
           PERFORM 3101-MISYU-HEN-SEC
      *
      *    初期表示時カーソル位置編集処理
           PERFORM 3101-SYOKI-CUR-HEN-SEC
      *
           IF    ( SPA-GMN-SYULIST-MAX =   ZERO )
               MOVE    1               TO  SPA-NAI-MISYUFLG
               MOVE    "未収金（過入金）はありません"
                                       TO  SPA-GMN-LBLMSG
           END-IF
      *
           .
       310-SYOKI-HYOJI-EXT.
           EXIT.
      *************************************************************
      *    収納機能情報取得処理
      *************************************************************
       3101-SYS-1039-GET-SEC           SECTION.
      *
           INITIALIZE  SYS-1039-REC
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    "1039"              TO  SYS-1039-KANRICD
           MOVE    "*"                 TO  SYS-1039-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-1039-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYS-1039-REC
           ELSE
               MOVE    MCPDATA-REC     TO  SYS-1039-REC
           END-IF
      *
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
           .
      *
       3101-SYS-1039-GET-EXT.
           EXIT.
      *************************************************************
      *    検索結果リスト編集処理（初期表示時）
      *************************************************************
       3101-SYULIST-HEN-SEC            SECTION.
      *
           INITIALIZE              SPA-GMN-SYULIST
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
           MOVE    "SYUNOU-KEY24"          TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              NOT =   ZERO )
               MOVE    1                   TO  FLG-SYUNOU
           ELSE
               MOVE    MCPDATA-REC         TO  SYUNOU-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-SYUNOU  NOT =   ZERO )
                    OR   ( SPA-GMN-SYULIST-MAX
                                           >=  CONST-SYULIST-MAX )
      *
               PERFORM 31011-SYULIST-HEN-SEC
      *
               MOVE    "SYUNOU-KEY24"      TO  ORC-DBPATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC              NOT =   ZERO )
                   MOVE    1               TO  FLG-SYUNOU
               ELSE
                   MOVE    MCPDATA-REC     TO  SYUNOU-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    "SYUNOU-KEY24"          TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       3101-SYULIST-HEN-EXT.
           EXIT.
      *************************************************************
      *    診療科ワーク編集処理
      *************************************************************
       3101-SRYKALST-HEN-SEC           SECTION.
      *
           INITIALIZE  S1005-SRYKALST-G
      *
           INITIALIZE  SYS-1005-REC
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY5"     TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-SYSKANRI
           ELSE
               MOVE    MCPDATA-REC     TO  SYS-1005-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-SYSKANRI    NOT =   ZERO )
                    OR   ( S1005-SRYKALST-MAX   >=   50   )
      *
               COMPUTE S1005-SRYKALST-MAX
                   =   S1005-SRYKALST-MAX    +   1
      *
               MOVE    S1005-SRYKALST-MAX  TO  IDXA
      *
               MOVE    SYS-1005-KBNCD      TO  S1005-SRYKAL  (IDXA)
               MOVE    SYS-1005-STYUKYMD   TO  S1005-SRYKAL-STYUKYMD
                                                             (IDXA)
               MOVE    SYS-1005-EDYUKYMD   TO  S1005-SRYKAL-EDYUKYMD
                                                             (IDXA)
               MOVE    SYS-1005-SRYKANAME1 TO  S1005-SRYKAMEIL
                                                             (IDXA)
      *
               MOVE    "SYSKANRI-KEY5"     TO  ORC-DBPATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC        NOT =   ZERO )
                   MOVE    1               TO  FLG-SYSKANRI
               ELSE
                   MOVE    MCPDATA-REC     TO  SYS-1005-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    "SYSKANRI-KEY5"     TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       3101-SRYKALST-HEN-EXT.
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
           COMPUTE SPA-GMN-SYULIST-MAX
               =   SPA-GMN-SYULIST-MAX    +   1
      *
           MOVE    SPA-GMN-SYULIST-MAX TO  IDX-LST
      *
           MOVE    IDX-LST             TO  SPA-GMN-TBANGO   (IDX-LST)
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
      *    状態区分
           MOVE    SYU-DENPJTIKBN      TO  SPA-NAI-TDENPJTIKBN (IDX-LST)
      *
      *    診療科名
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1        >   S1005-SRYKALST-MAX )
      *
               IF    ( SYU-SRYKA       =   S1005-SRYKAL (IDX1))
                AND  ( SYU-SRYYMD     >=   S1005-SRYKAL-STYUKYMD (IDX1))
                AND  ( SYU-SRYYMD     <=   S1005-SRYKAL-EDYUKYMD (IDX1))
                   MOVE    S1005-SRYKAMEIL (IDX1)
                                       TO  SPA-GMN-TSRYKA (IDX-LST)
                   MOVE    S1005-SRYKAL (IDX1)
                                       TO  SPA-NAI-TSRYKA (IDX-LST)
                   MOVE    S1005-SRYKALST-MAX
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
      *    入金額
           MOVE    ZERO                TO  SPA-GMN-TNYUKIN (IDX-LST)
      *
      *    保険組合せより（保険と負担）
           MOVE    SYU-HKNCOMBINUM     TO  WRK-KUMINO
           PERFORM 31011-HKNCOMBIMEI-HEN-SEC
           MOVE    WRK-HKNKUMI         TO  SPA-GMN-THKNCOMBI (IDX-LST)
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
      *    入金上限額編集処理
      *************************************************************
       3101-NYUKIN-MAX-HEN-SEC     SECTION.
      *
           MOVE    ZERO            TO  SPA-GMN-NYU-NYUKIN
                                       SPA-GMN-GAI-NYUKIN
                                       SPA-GMN-NYUKIN
                                       SPA-GMN-NYU-NYUKIN-MAX
                                       SPA-GMN-GAI-NYUKIN-MAX
                                       SPA-GMN-NYUKIN-MAX
      *
           IF    ( SPA-GMN-RD-NYUKIN-IKT   =   "T" )
               PERFORM 31011-NYUKIN-MAX-IKT-HEN-SEC
           ELSE
               PERFORM 31011-SYULIST-OUT-IDX-CHK-SEC
               IF    ( IDX-OUT     NOT =   ZERO )
                   MOVE    IDX-OUT     TO  IDX-KBT
                   PERFORM 31011-NYUKIN-MAX-KBT-HEN-SEC
               END-IF
           END-IF
      *
           .
       3101-NYUKIN-MAX-HEN-EXT.
           EXIT.
      *************************************************************
      *    入金上限額（一括）編集処理
      *************************************************************
       31011-NYUKIN-MAX-IKT-HEN-SEC     SECTION.
      *
           PERFORM VARYING IDX-LST    FROM    1   BY  1
                   UNTIL ( IDX-LST >  SPA-GMN-SYULIST-MAX )
      *
               IF    ( SPA-GMN-TMISYU (IDX-LST)    >   ZERO )
                   IF    ( SPA-NAI-TNYUGAIKBN (IDX-LST)
                                                   =   "1" )
                       COMPUTE SPA-GMN-NYU-NYUKIN-MAX
                           =   SPA-GMN-NYU-NYUKIN-MAX
                           +   SPA-GMN-TMISYU  (IDX-LST)
                   ELSE
                       COMPUTE SPA-GMN-GAI-NYUKIN-MAX
                           =   SPA-GMN-GAI-NYUKIN-MAX
                           +   SPA-GMN-TMISYU  (IDX-LST)
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           .
       31011-NYUKIN-MAX-IKT-HEN-EXT.
           EXIT.
      *****************************************************************
      *    入金上限額（個別）編集処理
      *****************************************************************
       31011-NYUKIN-MAX-KBT-HEN-SEC SECTION.
      *
           COMPUTE SPA-GMN-NYUKIN-MAX
               =   SPA-GMN-TMISYU (IDX-KBT)
               +   SPA-GMN-TNYUKIN (IDX-KBT)
      *
           IF    ( SPA-GMN-TNYUKIN (IDX-KBT)   =   ZERO )
               MOVE    SPA-GMN-NYUKIN-MAX
                                       TO  SPA-GMN-NYUKIN
           ELSE
               MOVE    SPA-GMN-TNYUKIN (IDX-KBT)
                                       TO  SPA-GMN-NYUKIN
           END-IF
      *
           .
       31011-NYUKIN-MAX-KBT-HEN-EXT.
           EXIT.
      *************************************************************
      *    入外区分コンボ編集処理
      *************************************************************
       3101-NYUGAIKBNLST-HEN-SEC       SECTION.
      *
           INITIALIZE                  SPA-GMN-NYUGAIKBNLST-G
      *
           MOVE    "0"                 TO  SPA-GMN-NYUGAIKBNL       (1)
           MOVE    "全部"              TO  SPA-GMN-NYUGAIKBNMEIL    (1)
           MOVE    "1"                 TO  SPA-GMN-NYUGAIKBNL       (2)
           MOVE    "入院"              TO  SPA-GMN-NYUGAIKBNMEIL    (2)
           MOVE    "2"                 TO  SPA-GMN-NYUGAIKBNL       (3)
           MOVE    "外来"              TO  SPA-GMN-NYUGAIKBNMEIL    (3)
      *
           MOVE    3                   TO  SPA-GMN-NYUGAIKBN-MAX
      *
           .
       3101-NYUGAIKBNLST-HEN-EXT.
           EXIT.
      *************************************************************
      *    入金管理区分コンボ編集処理
      *************************************************************
       3101-NYKNKNRKBNLST-HEN-SEC      SECTION.
      *
           INITIALIZE                  SPA-GMN-NYKNKNRKBNLST-G
      *
           MOVE    "1"                 TO  SPA-GMN-NYKNKNRKBNL (1)
           MOVE    "伝票の古い未収順に入金"
                                       TO  SPA-GMN-NYKNKNRKBNMEIL (1)
           MOVE    "2"                 TO  SPA-GMN-NYKNKNRKBNL (2)
           MOVE    "伝票の新しい未収順に入金"
                                       TO  SPA-GMN-NYKNKNRKBNMEIL (2)
      *
           MOVE    2                   TO  SPA-GMN-NYKNKNRKBN-MAX
      *
           .
       3101-NYKNKNRKBNLST-HEN-EXT.
           EXIT.
      *************************************************************
      *    請求書発行区分コンボ編集処理
      *************************************************************
       3101-SKYPRTKBNLST-HEN-SEC       SECTION.
      *
           INITIALIZE                  SPA-GMN-SKYPRTKBNLST-G
      *
           MOVE    "0"                 TO  SPA-GMN-SKYPRTKBNL (1)
           MOVE    "発行しない"        TO  SPA-GMN-SKYPRTKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-SKYPRTKBNL (2)
           MOVE    "発行する"          TO  SPA-GMN-SKYPRTKBNMEIL (2)
      *
           MOVE    2                   TO  SPA-GMN-SKYPRTKBN-MAX
      *
           .
       3101-SKYPRTKBNLST-HEN-EXT.
           EXIT.
      *****************************************************************
      *    収納情報リスト画面表示編集処理
      *****************************************************************
       3101-SYULIST-OUT-HEN-SEC        SECTION.
      *
           MOVE    1                   TO  FLG-GMN-INIT
      *
           INITIALIZE                  WRK-NYUGAIKBN
                                       WRK-DENPNUM
      *
           MOVE    SPA-GMN-NYU-NYUKIN  TO  WRK-NYU-NYUKIN
           MOVE    SPA-GMN-GAI-NYUKIN  TO  WRK-GAI-NYUKIN
           MOVE    SPA-GMN-NYUKIN      TO  WRK-NYUKIN
      *
           MOVE    ZERO                TO  SPA-GMN-NYU-NYUKIN
           MOVE    ZERO                TO  SPA-GMN-GAI-NYUKIN
           MOVE    ZERO                TO  SPA-GMN-NYUKIN
      *
           PERFORM 31011-SYULIST-OUT-IDX-CHK-SEC
           IF    ( IDX-OUT         NOT =   ZERO )
               MOVE    SPA-NAI-TNYUGAIKBN (IDX-OUT)
                                       TO  WRK-NYUGAIKBN
               MOVE    SPA-GMN-TDENPNUM (IDX-OUT)
                                       TO  WRK-DENPNUM
           END-IF
      *
           INITIALIZE                  SPA-GMN-SELNUM
                                       SPA-GMN-SYULIST-SEL
      *
           INITIALIZE                  SPA-GMN-SYULIST-OUT-G
      *
           PERFORM VARYING IDX-LST FROM    1   BY  1
                   UNTIL ( IDX-LST     >   SPA-GMN-SYULIST-MAX )
      *
               MOVE    1               TO  FLG-SYULIST-HEN
      *
               IF    ( SPA-GMN-NYUGAIKBN   NOT =   "0" )
                   IF    ( SPA-GMN-NYUGAIKBN
                                   NOT =   SPA-NAI-TNYUGAIKBN (IDX-LST))
                       MOVE    ZERO    TO  FLG-SYULIST-HEN
                   END-IF
               END-IF
      *
               IF    ( FLG-SYULIST-HEN =    1 )
                   IF    ( SPA-GMN-SYULIST-OUT-MAX
                                          < CONST-SYULIST-OUT-MAX )
                       COMPUTE SPA-GMN-SYULIST-OUT-MAX
                           =   SPA-GMN-SYULIST-OUT-MAX +   1
                       MOVE    SPA-GMN-TBANGO (IDX-LST)
                                       TO  SPA-GMN-SYULIST-OUT-IDX
                                             (SPA-GMN-SYULIST-OUT-MAX)
                       IF    ( SPA-NAI-TNYUGAIKBN (IDX-LST)
                                       =   WRK-NYUGAIKBN )
                        AND  ( SPA-GMN-TDENPNUM (IDX-LST)
                                       =   WRK-DENPNUM )
                           MOVE    SPA-GMN-SYULIST-OUT-MAX
                                       TO  SPA-GMN-SELNUM
                                           SPA-GMN-SYULIST-SEL
                       END-IF
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           PERFORM 3101-NYUKIN-MAX-HEN-SEC
      *
           IF    ( SPA-GMN-RD-NYUKIN-IKT   =   "T" )
               MOVE    WRK-NYU-NYUKIN  TO  SPA-GMN-NYU-NYUKIN
               MOVE    WRK-GAI-NYUKIN  TO  SPA-GMN-GAI-NYUKIN
           ELSE
               IF    ( SPA-GMN-SYULIST-SEL >   ZERO )
                   MOVE    WRK-NYUKIN  TO  SPA-GMN-NYUKIN
               END-IF
           END-IF
      *
           .
       3101-SYULIST-OUT-HEN-EXT.
           EXIT.
      
      *****************************************************************
      *    未収額合計編集処理
      *****************************************************************
       3101-MISYU-HEN-SEC              SECTION.
      *
           MOVE    ZERO                TO  SPA-GMN-NYU-MISYU
                                           SPA-GMN-GAI-MISYU
      *
           PERFORM VARYING IDX-LST FROM    1   BY  1
                   UNTIL ( IDX-LST >   CONST-SYULIST-MAX )
      *
               IF    ( SPA-NAI-TNYUGAIKBN (IDX-LST)    =   "1" )
                   COMPUTE SPA-GMN-NYU-MISYU
                       =   SPA-GMN-NYU-MISYU
                       +   SPA-GMN-TMISYU (IDX-LST)
               ELSE
                   COMPUTE SPA-GMN-GAI-MISYU
                       =   SPA-GMN-GAI-MISYU
                       +   SPA-GMN-TMISYU (IDX-LST)
               END-IF
      *
           END-PERFORM
      *
           .
       3101-MISYU-HEN-EXT.
           EXIT.
      *****************************************************************
      *    収納情報リストインデックスチェック処理
      *****************************************************************
       31011-SYULIST-OUT-IDX-CHK-SEC   SECTION.
      *
           MOVE    ZERO                TO  IDX-OUT
      *
           IF    ( SPA-GMN-SYULIST-SEL >=  1 )
            AND  ( SPA-GMN-SYULIST-SEL <=  CONST-SYULIST-OUT-MAX )
                MOVE   SPA-GMN-SYULIST-OUT-IDX (SPA-GMN-SYULIST-SEL)
                                       TO  IDX-OUT
           END-IF
      *
           .
       31011-SYULIST-OUT-IDX-CHK-EXT.
           EXIT.
      *****************************************************************
      *    初期表示時カーソル位置編集処理
      *****************************************************************
       3101-SYOKI-CUR-HEN-SEC          SECTION.
      *
           IF    ( SPA-GMN-RD-NYUKIN-IKT   =   "T" )
               MOVE    4               TO  SPA-GMN-CUR
           ELSE
               IF    ( SPA-GMN-SELNUM  >   ZERO )
                   MOVE    6           TO  SPA-GMN-CUR
               ELSE
                   MOVE    2           TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           .
       3101-SYOKI-CUR-HEN-EXT.
           EXIT.
      *************************************************************
      *    画面遷移処理
      *************************************************************
       200-GMNSENI                     SECTION.
      *
           MOVE    MCP-WIDGET      TO      WRK-MCP-WIDGET
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *
      *    戻る
           WHEN    "CLICKED"       ALSO    "B01"
               PERFORM 210-BACK
      *
      *    クリア
           WHEN    "CLICKED"       ALSO    "B02"
               PERFORM 220-CLEAR
      *
      *    入金日
           WHEN    "CLICKED"       ALSO    "B04"
               MOVE    07          TO      SPA-GMN-CUR
      *
      *    一括／個別
           WHEN    "CLICKED"       ALSO    "B08"
               IF    ( SPA-GMN-RD-NYUKIN-IKT   =   "T" )
                   MOVE    "F"     TO      S06-RD-NYUKIN-IKT
                   MOVE    "T"     TO      S06-RD-NYUKIN-KBT
               ELSE
                   MOVE    "T"     TO      S06-RD-NYUKIN-IKT
                   MOVE    "F"     TO      S06-RD-NYUKIN-KBT
               END-IF
      *
               PERFORM 4101-RD-NYUKIN-CHK-SEC
      *
      *    登録
           WHEN    "CLICKED"       ALSO    "B12"
               PERFORM 480-TOUROKU-SEC
      *
      *    一括入金
      *    個別入金
           WHEN    "CLICKED"       ALSO    "RD_NYUKIN_IKT"
           WHEN    "CLICKED"       ALSO    "RD_NYUKIN_KBT"
               PERFORM 4101-RD-NYUKIN-CHK-SEC
           END-EVALUATE
      *
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
      *    入外区分
           WHEN    "ACTIVATE"      ALSO    "NYUGAIKBN"
                   PERFORM 4100-NYUGAIKBN-CHK-SEC
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
      *    入金管理区分
           MOVE    S06-NYKNKNRKBN      TO  SPA-GMN-NYKNKNRKBN-G
      *    入金日
           MOVE    S06-NYUKINYMD       TO  SPA-GMN-NYUKINYMD
      *    請求書発行区分
           MOVE    S06-SKYPRTKBN       TO  SPA-GMN-SKYPRTKBN-G
      *    外来入金額
           MOVE    S06-GAI-NYUKIN      TO  SPA-GMN-GAI-NYUKIN
      *    入院入金額
           MOVE    S06-NYU-NYUKIN      TO  SPA-GMN-NYU-NYUKIN
      *    個別入金額
           MOVE    S06-NYUKIN          TO  SPA-GMN-NYUKIN
      *
           .
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC              SECTION.
      *
      *    入外区分チェック
           PERFORM 41001-NYUGAIKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
           IF    ( SPA-GMN-RD-NYUKIN-IKT   =   "T" )
      *
      *        入金管理区分チェック
               PERFORM 4101-NYKNKNRKBN-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4102-KIHON-CHK-EXT
               END-IF
      *
      *        外来入金額チェック
               PERFORM 4101-GAI-NYUKIN-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4102-KIHON-CHK-EXT
               END-IF
      *
      *        入院入金額チェック
               PERFORM 4101-NYU-NYUKIN-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4102-KIHON-CHK-EXT
               END-IF
           ELSE
      *
      *        選択番号チェック
               PERFORM 4101-SELNUM-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4102-KIHON-CHK-EXT
               END-IF
      *
      *        入金額チェック
               PERFORM 4101-NYUKIN-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4102-KIHON-CHK-EXT
               END-IF
           END-IF
      *
      *    入金日チェック処理
           PERFORM 4101-NYUKINYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    請求書兼領収書発行区分チェック
      *    PERFORM 4101-SKYPRTKBN-CHK-SEC
      *    IF    ( SPA-ERRCD   NOT =   SPACE )
      *        GO  TO  4102-KIHON-CHK-EXT
      *    END-IF
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
           IF    ( SPA-GMN-RD-NYUKIN-IKT   =   "T" )
               GO  TO  4100-SYULIST-CHK-EXT
           END-IF
      *
           PERFORM VARYING IDX-LST     FROM    1   BY  1
                   UNTIL ( IDX-LST     >   SPA-GMN-SYULIST-OUT-MAX )
      *
               IF    ( S06-SYULIST-SELECT (IDX-LST) =   "T" )
                   MOVE    IDX-LST     TO  SPA-GMN-SYULIST-SEL
                                           SPA-GMN-SELNUM
      *
                   MOVE    IDX-LST     TO  IDX-KBT
      *
                   MOVE    SPA-GMN-SYULIST-OUT-MAX
                                       TO  IDX-LST
               END-IF
      *
           END-PERFORM
      *
           PERFORM 3101-NYUKIN-MAX-HEN-SEC
      *
           PERFORM 3101-SYOKI-CUR-HEN-SEC
      *
           .
      *
       4100-SYULIST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入外区分チェック
      *****************************************************************
       4100-NYUGAIKBN-CHK-SEC          SECTION.
      *
           MOVE    1                   TO  SPA-GMN-CUR
      *
           MOVE    S06-NYUGAIKBN       TO  SPA-GMN-NYUGAIKBN-G
      *
           PERFORM 41001-NYUGAIKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-NYUGAIKBN-CHK-EXT
           END-IF
      *
           PERFORM 3101-SYULIST-OUT-HEN-SEC
      *
           PERFORM 3101-SYOKI-CUR-HEN-SEC
      *
           .
      *
       4100-NYUGAIKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    選択番号チェック
      *****************************************************************
       4100-SELNUM-CHK-SEC             SECTION.
      *
           MOVE    2                   TO  SPA-GMN-CUR
      *
           MOVE    ZERO                TO  SPA-GMN-SYULIST-SEL
                                           SPA-GMN-NYUKIN
                                           SPA-GMN-NYUKIN-MAX
      *
           MOVE    S06-SELNUM          TO  SPA-GMN-SELNUM
      *
           IF    ( SPA-GMN-RD-NYUKIN-IKT   =   "T" )
               MOVE    ZERO            TO  SPA-GMN-SELNUM
           END-IF
      *
           IF    ( SPA-GMN-SELNUM      =   ZERO )
               MOVE    2               TO  SPA-GMN-CUR
               GO  TO  4100-SELNUM-CHK-EXT
           END-IF
      *
           PERFORM 41001-SELNUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-SELNUM-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-SELNUM      TO  SPA-GMN-SYULIST-SEL
      *
           MOVE    SPA-GMN-SELNUM      TO  IDX-KBT
      *
           PERFORM 3101-NYUKIN-MAX-HEN-SEC
      *
           MOVE    6                   TO  SPA-GMN-CUR
      *
           .
      *
       4100-SELNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入外区分チェック
      *****************************************************************
       41001-NYUGAIKBN-CHK-SEC         SECTION.
      *
           MOVE    SPA-GMN-NYUGAIKBN   TO  WRK-CMB-CD
           PERFORM 4200-NYUGAIKBNLST-CHK-SEC
           IF    ( WRK-CMB-ITM             =   SPACE )
               MOVE    "0001"          TO  SPA-ERRCD
               MOVE    1               TO  SPA-GMN-CUR
               GO  TO  41001-NYUGAIKBN-CHK-EXT
           ELSE
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-NYUGAIKBN-G
           END-IF
      *
           .
       41001-NYUGAIKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    選択番号チェック
      *****************************************************************
       41001-SELNUM-CHK-SEC            SECTION.
      *
           IF    ( SPA-GMN-SELNUM      >=  ZERO )
            AND  ( SPA-GMN-SELNUM      <=  SPA-GMN-SYULIST-OUT-MAX )
               CONTINUE
           ELSE
               MOVE    "0002"          TO  SPA-ERRCD
               MOVE    2               TO  SPA-GMN-CUR
               GO  TO  41001-SELNUM-CHK-EXT
           END-IF
      *
           .
       41001-SELNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    一括／個別入金ラジオボタンチェック処理
      *****************************************************************
       4101-RD-NYUKIN-CHK-SEC          SECTION.
      *
           MOVE    S06-RD-NYUKIN-IKT   TO  SPA-GMN-RD-NYUKIN-IKT
           MOVE    S06-RD-NYUKIN-KBT   TO  SPA-GMN-RD-NYUKIN-KBT
      *
           IF    ( SPA-GMN-RD-NYUKIN-IKT   =   "T" )
               MOVE    ZERO            TO  SPA-GMN-SELNUM
                                           SPA-GMN-SYULIST-SEL
           END-IF
      *
           PERFORM 3101-NYUKIN-MAX-HEN-SEC
      *
           PERFORM 3101-SYOKI-CUR-HEN-SEC
      *
           .
       4101-RD-NYUKIN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    選択番号チェック処理
      *****************************************************************
       4101-SELNUM-CHK-SEC             SECTION.
      *
           IF    ( SPA-GMN-SELNUM  =   ZERO )
               MOVE    "0013"      TO  SPA-ERRCD
               MOVE    2           TO  SPA-GMN-CUR
               GO  TO  4101-SELNUM-CHK-EXT
           END-IF
      *
           PERFORM 41001-SELNUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4101-SELNUM-CHK-EXT
           END-IF
      *
           .
       4101-SELNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入金管理区分チェック処理
      *****************************************************************
       4101-NYKNKNRKBN-CHK-SEC         SECTION.
      *
           MOVE    SPA-GMN-NYKNKNRKBN  TO  WRK-CMB-CD
           PERFORM 4200-NYKNKNRKBNLST-CHK-SEC
           IF    ( WRK-CMB-ITM             =   SPACE )
               MOVE    "0003"          TO  SPA-ERRCD
               MOVE    3               TO  SPA-GMN-CUR
               GO  TO  4101-NYKNKNRKBN-CHK-EXT
           ELSE
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-NYKNKNRKBN-G
           END-IF
      *
           .
       4101-NYKNKNRKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    外来入金額チェック処理
      *****************************************************************
       4101-GAI-NYUKIN-CHK-SEC         SECTION.
      *
           IF    ( SPA-GMN-GAI-NYUKIN  <   ZERO )
               MOVE    "0004"          TO  SPA-ERRCD
               MOVE    4               TO  SPA-GMN-CUR
               GO  TO  4101-GAI-NYUKIN-CHK-EXT
           END-IF
      *
           IF    ( SPA-GMN-GAI-NYUKIN  >   SPA-GMN-GAI-NYUKIN-MAX )
               MOVE    "0005"          TO  SPA-ERRCD
               MOVE    4               TO  SPA-GMN-CUR
               GO  TO  4101-GAI-NYUKIN-CHK-EXT
           END-IF
      *
           IF    ( WRK-MCP-WIDGET      =   "GAI_NYUKIN" )
               PERFORM 41011-IKT-KARINYUKIN-SEC
           END-IF
      *
           .
       4101-GAI-NYUKIN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院入金額チェック処理
      *****************************************************************
       4101-NYU-NYUKIN-CHK-SEC         SECTION.
      *
           IF    ( SPA-GMN-NYU-NYUKIN  <   ZERO )
               MOVE    "0006"          TO  SPA-ERRCD
               MOVE    5               TO  SPA-GMN-CUR
               GO  TO  4101-NYU-NYUKIN-CHK-EXT
           END-IF
      *
           IF    ( SPA-GMN-NYU-NYUKIN  >   SPA-GMN-NYU-NYUKIN-MAX )
               MOVE    "0007"          TO  SPA-ERRCD
               MOVE    5               TO  SPA-GMN-CUR
               GO  TO  4101-NYU-NYUKIN-CHK-EXT
           END-IF
      *
           IF    ( WRK-MCP-WIDGET      =   "NYU_NYUKIN" )
               PERFORM 41011-IKT-KARINYUKIN-SEC
           END-IF
      *
           .
       4101-NYU-NYUKIN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入金額チェック処理
      *****************************************************************
       4101-NYUKIN-CHK-SEC         SECTION.
      *
           IF    ( SPA-GMN-NYUKIN-MAX  <   ZERO )
               IF    ( SPA-GMN-NYUKIN  <=  ZERO )
                AND  ( SPA-GMN-NYUKIN  >=  SPA-GMN-NYUKIN-MAX )
                   CONTINUE
               ELSE
                   MOVE    "0008"          TO  SPA-ERRCD
                   MOVE    6               TO  SPA-GMN-CUR
                   GO  TO  4101-NYUKIN-CHK-EXT
               END-IF
           ELSE
      *
               IF    ( SPA-GMN-NYUKIN  <   ZERO )
                   MOVE    "0009"          TO  SPA-ERRCD
                   MOVE    6               TO  SPA-GMN-CUR
                   GO  TO  4101-NYUKIN-CHK-EXT
               END-IF
      *
               IF    ( SPA-GMN-NYUKIN  >   SPA-GMN-NYUKIN-MAX )
                   MOVE    "0010"          TO  SPA-ERRCD
                   MOVE    6               TO  SPA-GMN-CUR
                   GO  TO  4101-NYUKIN-CHK-EXT
               END-IF
           END-IF
      *
           IF    ( WRK-MCP-WIDGET      =   "NYUKIN" )
               PERFORM 41011-KBT-KARINYUKIN-SEC
           END-IF
      *
           .
       4101-NYUKIN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    一括仮入金処理
      *****************************************************************
       41011-IKT-KARINYUKIN-SEC        SECTION.
      *
           MOVE    ZERO            TO  FLG-LOOP-END
      *
           EVALUATE    SPA-GMN-NYKNKNRKBN
           WHEN    "1"
               PERFORM VARYING IDX-LST
                       FROM    1   BY  1
                       UNTIL ( IDX-LST >   CONST-SYULIST-MAX )
                        OR   ( FLG-LOOP-END    =   1 )
      *
                   PERFORM 41011-IKT-KARINYUKIN-HEN-SEC
      *
               END-PERFORM
           WHEN    "2"
               PERFORM VARYING IDX-LST
                       FROM    CONST-SYULIST-MAX   BY  -1
                       UNTIL ( IDX-LST <   1 )
                        OR   ( FLG-LOOP-END    =   1 )
      *
                   PERFORM 41011-IKT-KARINYUKIN-HEN-SEC
      *
               END-PERFORM
           END-EVALUATE
      *
      *    未収額合計編集処理
           PERFORM 3101-MISYU-HEN-SEC
      *
      *    入金上限額編集処理
           PERFORM 3101-NYUKIN-MAX-HEN-SEC
      *
           .
       41011-IKT-KARINYUKIN-EXT.
           EXIT.
      *****************************************************************
      *    一括仮入金編集処理
      *****************************************************************
       41011-IKT-KARINYUKIN-HEN-SEC    SECTION.
      *
           IF    ( SPA-NAI-TNYUGAIKBN (IDX-LST)
                                           =   "1" )
               MOVE    1           TO  IDX3
           ELSE
               MOVE    2           TO  IDX3
           END-IF
      *
           IF    ( SPA-GMN-IKT-NYUKIN (IDX3)    >   ZERO )
            AND  ( SPA-GMN-TMISYU (IDX-LST)     >   ZERO )
      *
               IF    ( SPA-GMN-TMISYU (IDX-LST)
                                       >   SPA-GMN-IKT-NYUKIN (IDX3) )
                   COMPUTE SPA-GMN-TNYUKIN (IDX-LST)
                       =   SPA-GMN-TNYUKIN (IDX-LST)
                       +   SPA-GMN-IKT-NYUKIN (IDX3)
                   COMPUTE SPA-GMN-TMISYU (IDX-LST)
                       =   SPA-GMN-TMISYU (IDX-LST)
                       -   SPA-GMN-IKT-NYUKIN (IDX3)
                   MOVE    ZERO    TO  SPA-GMN-IKT-NYUKIN (IDX3)
               ELSE
                   COMPUTE SPA-GMN-TNYUKIN (IDX-LST)
                       =   SPA-GMN-TNYUKIN (IDX-LST)
                       +   SPA-GMN-TMISYU (IDX-LST)
                   COMPUTE SPA-GMN-IKT-NYUKIN (IDX3)
                       =   SPA-GMN-IKT-NYUKIN (IDX3)
                       -   SPA-GMN-TMISYU (IDX-LST)
                   MOVE    ZERO    TO  SPA-GMN-TMISYU (IDX-LST)
               END-IF
      *
               IF    ( SPA-GMN-NYU-NYUKIN  <=  ZERO )
                AND  ( SPA-GMN-GAI-NYUKIN  <=  ZERO )
                   MOVE    1       TO  FLG-LOOP-END
               END-IF
           END-IF
      *
           .
       41011-IKT-KARINYUKIN-HEN-EXT.
           EXIT.
      *****************************************************************
      *    個別仮入金処理
      *****************************************************************
       41011-KBT-KARINYUKIN-SEC        SECTION.
      *
           PERFORM 31011-SYULIST-OUT-IDX-CHK-SEC
           IF    ( IDX-OUT         NOT =   ZERO )
               COMPUTE SPA-GMN-TMISYU (IDX-OUT)
                   =   SPA-GMN-TMISYU (IDX-OUT)
                   +   SPA-GMN-TNYUKIN (IDX-OUT)
                   -   SPA-GMN-NYUKIN
               MOVE    SPA-GMN-NYUKIN  TO  SPA-GMN-TNYUKIN (IDX-OUT)
           END-IF
      *
      *    未収額合計編集処理
           PERFORM 3101-MISYU-HEN-SEC
      *
      *    入金上限額編集処理
           PERFORM 3101-NYUKIN-MAX-HEN-SEC
      *
           .
       41011-KBT-KARINYUKIN-EXT.
           EXIT.
      *****************************************************************
      *    入金日チェック処理
      *****************************************************************
       4101-NYUKINYMD-CHK-SEC          SECTION.
      *
            MOVE   SPACE               TO  SPA-NAI-NYUKINYMD
      *
            IF   ( SPA-GMN-NYUKINYMD   =   SPACE )
             AND ( WRK-MCP-WIDGET      =   "NYUKINYMD" )
               MOVE    SPA-SYSYMDWH    TO  SPA-GMN-NYUKINYMD
               MOVE    SPA-SYSYMD      TO  SPA-NAI-NYUKINYMD
               GO  TO  4101-NYUKINYMD-CHK-EXT
            END-IF
      *
            MOVE   SPA-GMN-NYUKINYMD   TO  WRK-YMD
            PERFORM    800-SEIWA-HEN-SEC
            IF   ( FLG-HIZUKE-ERR  NOT =   ZERO )
               MOVE    7               TO  SPA-GMN-CUR
               MOVE    "0012"          TO  SPA-ERRCD
               GO  TO  4101-NYUKINYMD-CHK-EXT
            END-IF
      *
            MOVE   WRK-HENYMDG         TO  SPA-GMN-NYUKINYMD
            MOVE   WRK-SYMD            TO  SPA-NAI-NYUKINYMD
      *
           .
       4101-NYUKINYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    請求書兼領収書発行区分チェック処理
      *****************************************************************
       4101-SKYPRTKBN-CHK-SEC          SECTION.
      *
           MOVE    SPA-GMN-SKYPRTKBN   TO  WRK-CMB-CD
           PERFORM 4200-SKYPRTKBNLST-CHK-SEC
           IF    ( WRK-CMB-ITM             =   SPACE )
               MOVE    "0011"          TO  SPA-ERRCD
               MOVE    8               TO  SPA-GMN-CUR
               GO  TO  4101-SKYPRTKBN-CHK-EXT
           ELSE
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-SKYPRTKBN-G
           END-IF
      *
           .
       4101-SKYPRTKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入外区分コンボチェック処理
      *****************************************************************
       4200-NYUGAIKBNLST-CHK-SEC       SECTION.
      *
           MOVE    SPACE               TO  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
               UNTIL ( IDX-CMB     >   SPA-GMN-NYUGAIKBN-MAX )
                OR   ( WRK-CMB-CD  =   SPA-GMN-NYUGAIKBNL (IDX-CMB))
      *
               CONTINUE
      *
           END-PERFORM
      *
           IF    ( IDX-CMB     <=  SPA-GMN-NYUGAIKBN-MAX )
               MOVE    SPA-GMN-NYUGAIKBNLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
           END-IF
      *
           .
       4200-NYUGAIKBNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入金管理区分コンボチェック処理
      *****************************************************************
       4200-NYKNKNRKBNLST-CHK-SEC      SECTION.
      *
           MOVE    SPACE               TO  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
               UNTIL ( IDX-CMB     >   SPA-GMN-NYKNKNRKBN-MAX )
                OR   ( WRK-CMB-CD  =   SPA-GMN-NYKNKNRKBNL (IDX-CMB))
      *
               CONTINUE
      *
           END-PERFORM
      *
           IF    ( IDX-CMB     <=  SPA-GMN-NYKNKNRKBN-MAX )
               MOVE    SPA-GMN-NYKNKNRKBNLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
           END-IF
      *
           .
       4200-NYKNKNRKBNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    請求書兼領収書区分コンボチェック処理
      *****************************************************************
       4200-SKYPRTKBNLST-CHK-SEC       SECTION.
      *
           MOVE    SPACE               TO  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
               UNTIL ( IDX-CMB     >   SPA-GMN-SKYPRTKBN-MAX )
                OR   ( WRK-CMB-CD  =   SPA-GMN-SKYPRTKBNL (IDX-CMB))
      *
               CONTINUE
      *
           END-PERFORM
      *
           IF    ( IDX-CMB     <=  SPA-GMN-SKYPRTKBN-MAX )
               MOVE    SPA-GMN-SKYPRTKBNLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
           END-IF
      *
           .
       4200-SKYPRTKBNLST-CHK-EXT.
           EXIT.
      *************************************************************
      *    戻る　処理
      *************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "S02"               TO  SPA-SAKIPG
           MOVE    "S06"               TO  SPA-MOTOPG
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
      *************************************************************
      *    クリア　処理
      *************************************************************
       220-CLEAR                       SECTION.
      *
           PERFORM 310-SPA-SET-SEC
      *
           .
       220-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    登録処理
      *****************************************************************
       480-TOUROKU-SEC                 SECTION.
      *
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           PERFORM 4801-KANREN-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  480-TOUROKU-EXT
           END-IF
      *
           MOVE    "2001"              TO  SPA-SIDCD
      *
           .
       480-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    関連チェック
      *****************************************************************
       4801-KANREN-CHK-SEC             SECTION.
      *
      *    入金日チェック
           PERFORM 4101-NYUKINYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4801-KANREN-CHK-EXT
           END-IF
      *
      *    請求書兼領収書発行区分チェック
      *    PERFORM 4101-SKYPRTKBN-CHK-SEC
      *    IF    ( SPA-ERRCD   NOT =   SPACE )
      *        GO  TO  4801-KANREN-CHK-EXT
      *    END-IF
      *
           .
       4801-KANREN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    登録処理
      *****************************************************************
       4801-TOUROKU-SEC                SECTION.
      *
      *    まとめ入金サブ呼出処理
           PERFORM 4801-ORCSNYUKINS-CALL-SEC
      *
      *    請求書出力処理
      *    PERFORM 4801-SEIKYUSYO-OUT-SEC
      *
           MOVE    SPA-GMN-NYUGAIKBNLST (1)
                                       TO  SPA-GMN-NYUGAIKBN-G
      *
           PERFORM 310-SYOKI-HYOJI-SEC
      *
           .
       4801-TOUROKU-EXT.
           EXIT.
      *************************************************************
      *    まとめ入金サブ呼出処理
      *************************************************************
       4801-ORCSNYUKINS-CALL-SEC   SECTION.
      *
           INITIALIZE                      ORCSNYUKINAREAS
           MOVE    SPA-HOSPID          TO  LNK-SCNYUKINS-HOSPID
           MOVE    SPA-GMN-PTID        TO  LNK-SCNYUKINS-PTID
           MOVE    SPA-NAI-NYUKINYMD   TO  LNK-SCNYUKINS-NYUKIN-YMD
      *
           MOVE    ZERO                TO  LNK-SCNYUKINS-MAX
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   SPA-GMN-SYULIST-MAX )
      *
               IF    ( SPA-GMN-TNYUKIN (IDX0)  NOT =   ZERO )
                   COMPUTE LNK-SCNYUKINS-MAX
                       =   LNK-SCNYUKINS-MAX   +   1
      *
      *            入外区分
                   MOVE    SPA-NAI-TNYUGAIKBN (IDX0)
                                       TO  LNK-SCNYUKINS-NYUGAIKBN
                                                 (LNK-SCNYUKINS-MAX)
      *            伝票番号
                   MOVE    SPA-GMN-TDENPNUM (IDX0)
                                       TO  LNK-SCNYUKINS-DENPNUM
                                                 (LNK-SCNYUKINS-MAX)
      *            入金額
                   MOVE    SPA-GMN-TNYUKIN  (IDX0)
                                       TO  LNK-SCNYUKINS-NYUKIN-MONEY
                                                 (LNK-SCNYUKINS-MAX)
      *
               END-IF
      *
           END-PERFORM
      *
           CALL    "ORCSNYUKINS"   USING   ORCSNYUKINAREAS
           IF    ( LNK-SCNYUKINS-RC    NOT =   ZERO )
               MOVE    "4001"          TO  SPA-ERRCD
               GO  TO  4801-ORCSNYUKINS-CALL-EXT
           END-IF
      *
           .
       4801-ORCSNYUKINS-CALL-EXT.
           EXIT.
      *************************************************************
      *    請求書出力処理
      *************************************************************
       4801-SEIKYUSYO-OUT-SEC      SECTION.
      *
      *    帳票プログラム取得（入院）
      *    PERFORM 4801-NYU-PRINT-PG-SEC
      *
      *    帳票プログラム取得（外来）
      *    PERFORM 4801-PRINT-PG-SEC
      *
      *    MOVE   SPA-AREA             TO  WRK-SPA-AREA
      *    MOVE   SPA-GMN-PTID         TO  WRK-SPA-PTID
      *    MOVE   SPA-GMN-PTNUM        TO  WRK-SPA-PTNUM
      *    MOVE   SPA-GMN-NAME         TO  WRK-SPA-NAME
      *
      *    PERFORM VARYING IDX0    FROM    1   BY  1
      *            UNTIL ( IDX0    >   SPA-GMN-SYULIST-MAX )
      *
      *        IF    ( SPA-GMN-TNYUKIN (IDX0)  NOT =   ZERO )
      *         AND  ( SPA-NAI-TDENPJTIKBN (IDX0)
      *                                       NOT =   "3"  )
      *            MOVE    SPA-NAI-TSRYYMD (IDX0)
      *                                TO  WRK-SPA-SRYYMD
      *            MOVE    SPA-NAI-TNYUGAIKBN (IDX0)
      *                                TO  WRK-SPA-NYUGAIKBN
      *
      *            IF    ( SPA-NAI-TNYUGAIKBN (IDX0)   =   "1" )
      *                INITIALIZE      ORCHCN03AREA
      *                MOVE    WRK-SPA-HOSPID  TO  ORCHCN03-HEAD-HOSPID
      *                MOVE    WRK-SPA-STAFFCD TO  ORCHCN03-STAFFCD
      *                MOVE    WRK-SPA-SYSYMD  TO  ORCHCN03-SYSYMD
      *                MOVE    WRK-SPA-TERMID  TO  ORCHCN03-TERMID
      *                MOVE    1               TO  ORCHCN03-CNT
      *
      *                MOVE    WRK-SPA-HOSPID  TO  ORCHCN03-HOSPID (1)
      *                MOVE    WRK-SPA-PTID    TO  ORCHCN03-PTID   (1)
      *                MOVE    WRK-SPA-PTNUM   TO  ORCHCN03-PTNUM  (1)
      *                MOVE    "1"         TO  ORCHCN03-NYUGAIKBN (1)
      *
      *                MOVE    SPA-NAI-TSRYYMD (IDX0)
      *                                    TO  ORCHCN03-KJNYMD  (1)
      *                MOVE    SPA-GMN-TDENPNUM (IDX0)
      *                                    TO  ORCHCN03-DENPNUM (1)
      *
      *                COMPUTE ORCHCN03-SEIKYU  (1)
      *                    =   SPA-GMN-TMISYU (IDX0)
      *                    +   SPA-GMN-TNYUKIN (IDX0)
      *
      *                MOVE    SPA-GMN-TNYUKIN (IDX0)
      *                                    TO  ORCHCN03-NYUKIN  (1)
      *
      *                CALL    WRK-NYU-SEIKYU-PG
      *                                    USING   ORCHCN03AREA
      *
      *            ELSE
      *                INITIALIZE      ORCHC03AREA
      *                MOVE    SPA-GMN-TDENPNUM (IDX0)
      *                                    TO  ORCHC03-DENPNUM
      *
      *                COMPUTE ORCHC03-SEIKYU
      *                    =   SPA-GMN-TMISYU (IDX0)
      *                    +   SPA-GMN-TNYUKIN (IDX0)
      *
      *                MOVE    SPA-GMN-TNYUKIN (IDX0)
      *                                    TO  ORCHC03-NYUKIN
      *                MOVE   1            TO  ORCHC03-HAKKOFLG
      *                CALL  WRK-GAI-SEIKYU-PG USING
      *                                        WRK-SPA-AREA
      *                                        ORCHC03AREA
      *            END-IF
      *        END-IF
      *
      *    END-PERFORM
      *
      *    .
      *4801-SEIKYUSYO-OUT-EXT.
      *    EXIT.
      *****************************************************************
      *    帳票プログラム取得処理 （入院）
      *****************************************************************
      *4801-NYU-PRINT-PG-SEC           SECTION.
      *
      *    請求書
      *    MOVE    SPACE               TO  WRK-NYU-SEIKYU-PG
      *
      *    INITIALIZE                      ORCSPRTNMAREA
      *    MOVE    "1"                 TO  ORCSPRTNM-KBN
      *    MOVE    "00000003"          TO  ORCSPRTNM-KBNCD
      *    MOVE    SPA-SYSYMD          TO  ORCSPRTNM-SRYYMD
      *    MOVE    "1"                 TO  ORCSPRTNM-NYUGAIKBN
      *    CALL    "ORCSPRTNM"         USING
      *                                    ORCSPRTNMAREA
      *                                    WRK-SPA-AREA
      *                                    SYS-1035-REC
      *    IF    ( ORCSPRTNM-RC        =   ZERO )
      *       MOVE    ORCSPRTNM-PRTPG  TO  WRK-NYU-SEIKYU-PG
      *    ELSE
      *       MOVE    "ORCHCN03"       TO  WRK-NYU-SEIKYU-PG
      *    END-IF
      *
      *    .
      *
      *4801-NYU-PRINT-PG-EXT.
      *    EXIT.
      *****************************************************************
      *    帳票プログラム取得処理
      *****************************************************************
      *4801-PRINT-PG-SEC               SECTION.
      *
      *    請求書
      *    MOVE    SPACE               TO  WRK-GAI-SEIKYU-PG
      *
      *    INITIALIZE                      ORCSPRTNMAREA
      *    MOVE    "1"                 TO  ORCSPRTNM-KBN
      *    MOVE    "00000003"          TO  ORCSPRTNM-KBNCD
      *    MOVE    SPA-SYSYMD          TO  ORCSPRTNM-SRYYMD
      *    MOVE    "2"                 TO  ORCSPRTNM-NYUGAIKBN
      *    CALL    "ORCSPRTNM"         USING
      *                                    ORCSPRTNMAREA
      *                                    WRK-SPA-AREA
      *                                    SYS-1032-REC
      *    IF    ( ORCSPRTNM-RC        =   ZERO )
      *       MOVE    ORCSPRTNM-PRTPG  TO  WRK-GAI-SEIKYU-PG
      *    ELSE
      *       MOVE    "ORCHC03"        TO  WRK-GAI-SEIKYU-PG
      *    END-IF
      *
      *    .
      *4801-PRINT-PG-EXT.
      *    EXIT.
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
           IF      SPA-SIDCD       NOT =   SPACE
               PERFORM 520-SIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LNK-KYOUTU.
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "S06    "           TO  MCP-WINDOW.
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
           MOVE    S06-SYULIST-ROW     TO  WRK-SYULIST-ROW
      *
           MOVE    SPACE               TO  S06
           INITIALIZE                      S06
      *
           IF    ( FLG-GMN-INIT        =   1 )
               MOVE    ZERO            TO  S06-SYULIST-ROW
               MOVE    ZERO            TO  S06-SYULIST-ROWATTR
           ELSE
               MOVE    WRK-SYULIST-ROW TO  S06-SYULIST-ROW
               MOVE    ZERO            TO  S06-SYULIST-ROWATTR
           END-IF
      *
           MOVE    SPA-GMN-PTNUM       TO  S06-PTNUM
           MOVE    SPA-GMN-NAME        TO  S06-NAME
      *
           MOVE    SPA-GMN-NYUGAIKBN-G TO  S06-NYUGAIKBN
           MOVE    SPA-GMN-NYUGAIKBN-MAX
                                       TO  S06-NYUGAIKBN-COUNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   SPA-GMN-NYUGAIKBN-MAX )
               MOVE    SPA-GMN-NYUGAIKBNLST (IDX1)
                                       TO  S06-NYUGAIKBN-ITEM (IDX1)
           END-PERFORM
      *
           MOVE    SPA-GMN-NYU-MISYU   TO  S06-NYU-MISYU
           MOVE    SPA-GMN-GAI-MISYU   TO  S06-GAI-MISYU
      *
           MOVE    SPA-GMN-SELNUM      TO  S06-SELNUM
      *
           MOVE    SPA-GMN-RD-NYUKIN-KBT
                                       TO  S06-RD-NYUKIN-KBT
           MOVE    SPA-GMN-RD-NYUKIN-IKT
                                       TO  S06-RD-NYUKIN-IKT
      *
           MOVE    SPA-GMN-NYKNKNRKBN-G
                                       TO  S06-NYKNKNRKBN
           MOVE    SPA-GMN-NYKNKNRKBN-MAX
                                       TO  S06-NYKNKNRKBN-COUNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   SPA-GMN-NYKNKNRKBN-MAX )
               MOVE    SPA-GMN-NYKNKNRKBNLST (IDX1)
                                       TO  S06-NYKNKNRKBN-ITEM (IDX1)
           END-PERFORM
      *
           MOVE    SPA-GMN-NYUKINYMD   TO  S06-NYUKINYMD
      *
           MOVE    SPA-GMN-SKYPRTKBN-G
                                       TO  S06-SKYPRTKBN
           MOVE    SPA-GMN-SKYPRTKBN-MAX
                                       TO  S06-SKYPRTKBN-COUNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   SPA-GMN-SKYPRTKBN-MAX )
               MOVE    SPA-GMN-SKYPRTKBNLST (IDX1)
                                       TO  S06-SKYPRTKBN-ITEM (IDX1)
           END-PERFORM
      *
           MOVE    SPA-GMN-NYU-NYUKIN  TO  S06-NYU-NYUKIN
           MOVE    SPA-GMN-NYU-NYUKIN-MAX
                                       TO  S06-NYU-NYUKIN-MAX
           MOVE    SPA-GMN-GAI-NYUKIN  TO  S06-GAI-NYUKIN
           MOVE    SPA-GMN-GAI-NYUKIN-MAX
                                       TO  S06-GAI-NYUKIN-MAX
           MOVE    SPA-GMN-NYUKIN      TO  S06-NYUKIN
           MOVE    SPA-GMN-NYUKIN-MAX
                                       TO  S06-NYUKIN-MAX
      *
           MOVE   SPA-GMN-SYULIST-OUT-MAX
                                       TO  S06-SYULIST-COUNT
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >   SPA-GMN-SYULIST-OUT-MAX )
      *
               MOVE    SPA-GMN-SYULIST-OUT-IDX (IDX2)
                                       TO  IDX1
      *
               MOVE    IDX2                    TO  WRK-ZZZ
               MOVE    WRK-ZZZ                 TO  S06-TNUM       (IDX2)
               MOVE    SPA-GMN-TDENPNUM(IDX1)  TO  S06-TDENPNUM   (IDX2)
               MOVE    SPA-GMN-TNYUGAIKBN(IDX1)
                                               TO  S06-TNYUGAI    (IDX2)
               MOVE    SPA-GMN-TSRYKA(IDX1)    TO  S06-TSRYKA     (IDX2)
               MOVE    SPA-GMN-THKNCOMBI(IDX1) TO  S06-THKN       (IDX2)
               MOVE    SPA-GMN-TFTNRATE(IDX1)  TO  S06-TFTNRATE   (IDX2)
               MOVE    SPA-GMN-THAKYMD (IDX1)  TO  S06-TSKYSTYMD  (IDX2)
               MOVE    SPA-GMN-TSRYYMD (IDX1)  TO  S06-TSRYYMD    (IDX2)
               MOVE    SPA-GMN-TSEIKYU(IDX1)   TO  WRK-KINGAKU
               MOVE    WRK-KINGAKU             TO  S06-TSKYMONEY  (IDX2)
               MOVE    SPA-GMN-TMISYU (IDX1)   TO  WRK-KINGAKU
               MOVE    WRK-KINGAKU             TO  S06-TMISYUMONEY(IDX2)
               MOVE    SPA-GMN-TNYUKIN (IDX1)  TO  WRK-KINGAKU
               MOVE    WRK-KINGAKU             TO  S06-TNYKNMONEY(IDX2)
      *
               IF    ( SPA-GMN-SYULIST-SEL     =   IDX2 )
                   MOVE    "T"                 TO  S06-SYULIST-SELECT
                                                                  (IDX2)
               ELSE
                   MOVE    "F"                 TO  S06-SYULIST-SELECT
                                                                  (IDX2)
               END-IF
      *
           END-PERFORM
      *
           IF    ( SPA-NAI-MISYUFLG        =   1 )
               MOVE    "blue"              TO  S06-LBLMSG-STYLE
               MOVE    SPA-GMN-LBLMSG      TO  S06-LBLMSG
           END-IF
      *
           PERFORM 5001-GMNHEN-STATE-EDIT-SEC
      *
           PERFORM 5001-MAPCUR-SEC
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目状態編集処理
      *****************************************************************
       5001-GMNHEN-STATE-EDIT-SEC      SECTION.
      *
           MOVE    WIDGET-NORMAL       TO  S06-SELNUM-STATE
                                           S06-NYKNKNRKBN-STATE
                                           S06-NYKNKNRKBN-ITEM-STATE
                                           S06-NYU-NYUKIN-STATE
                                           S06-NYU-NYUKIN-MAX-STATE
                                           S06-GAI-NYUKIN-STATE
                                           S06-GAI-NYUKIN-MAX-STATE
                                           S06-NYUKIN-STATE
                                           S06-NYUKIN-MAX-STATE
      *
           IF    ( SPA-GMN-RD-NYUKIN-IKT   =   "T" )
               MOVE    WIDGET-INSENSITIVE
                                       TO  S06-SELNUM-STATE
                                           S06-NYUKIN-STATE
                                           S06-NYUKIN-MAX-STATE
           ELSE
               MOVE    WIDGET-INSENSITIVE
                                       TO  S06-NYKNKNRKBN-STATE
                                           S06-NYKNKNRKBN-ITEM-STATE
                                           S06-NYU-NYUKIN-STATE
                                           S06-NYU-NYUKIN-MAX-STATE
                                           S06-GAI-NYUKIN-STATE
                                           S06-GAI-NYUKIN-MAX-STATE
           END-IF
      *
           .
       5001-GMNHEN-STATE-EDIT-EXT.
           EXIT.
      *************************************************************
      *    エラーメッセージ表示理
      *************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    SPACE                   TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
           WHEN    "0001"
               MOVE    "入外区分入力エラー"
                                           TO  SPA-ERRMSG
           WHEN    "0002"
               MOVE    "選択番号入力エラー"
                                           TO  SPA-ERRMSG
           WHEN    "0003"
               MOVE    "入金管理区分入力エラー"
                                           TO  SPA-ERRMSG
           WHEN    "0004"
               MOVE    "外来入金額にマイナスは設定できません"
                                           TO  SPA-ERRMSG
           WHEN    "0005"
               MOVE    "外来入金額が入金上限額を上回っています"
                                           TO  SPA-ERRMSG
           WHEN    "0006"
               MOVE    "入院入金額にマイナスは設定できません"
                                           TO  SPA-ERRMSG
           WHEN    "0007"
               MOVE    "入院入金額が入金上限額を上回っています"
                                           TO  SPA-ERRMSG
           WHEN    "0008"
               MOVE    "入金額を入金上限額〜０円の範囲で入力して"
                                           TO  SPA-ERRMSG (1:40)
               MOVE    "ください"
                                           TO  SPA-ERRMSG (41:)
           WHEN    "0009"
               MOVE    "マイナスの入金額は入金上限額がプラスの場"
                                           TO  SPA-ERRMSG (1:40)
               MOVE    "合入力できません"
                                           TO  SPA-ERRMSG (41:)
           WHEN    "0010"
               MOVE    "入金額が入金上限額を上回っています"
                                           TO  SPA-ERRMSG
           WHEN    "0011"
               MOVE    "請求書兼領収書発行区分入力エラー"
                                           TO  SPA-ERRMSG
           WHEN    "0012"
               MOVE    "入金日入力エラー"
                                           TO  SPA-ERRMSG
           WHEN    "0013"
               MOVE    "選択番号を入力してください"
                                           TO  SPA-ERRMSG
           WHEN    "4001"  THRU    "4999"
               MOVE    "更新処理に失敗しました"
                                           TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                   TO  SERR
           MOVE    SPA-ERRCD               TO  SERR-ERRCODE
           MOVE    SPA-ERRMSG              TO  SERR-ERRMSG
           MOVE    "B01"                   TO  MCP-WIDGET
      *
           MOVE    "S06"                   TO  SPA-MOTOPG
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
      *    ガイドメッセージ表示
      *****************************************************************
       520-SIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-SIDMSG
      *
           EVALUATE    SPA-SIDCD
           WHEN    "2001"
               MOVE    "入金処理を行います"
                                        TO  WRK-SIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  SID1
           MOVE    SPA-SIDCD            TO  SID1-ID1CODE
           MOVE    WRK-SIDMSG           TO  SID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "S06"                TO  SPA-MOTOPG
           MOVE    "SID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "SID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
      *
           .
       520-SIDSET-EXT.
           EXIT.
      *****************************************************************
      *    画面カーソルセット処理    
      *****************************************************************
       5001-MAPCUR-SEC                 SECTION.
      *
           IF    ( SPA-GMN-CUR         =   ZERO )
               PERFORM 50011-GMN-CUR-SET-SEC
           END-IF
      *
           PERFORM 50012-CUR-SKIP-SEC
      *
           EVALUATE    SPA-GMN-CUR
           WHEN    01
               MOVE  "NYUGAIKBN"       TO  MCP-WIDGET
           WHEN    02
               MOVE  "SELNUM"          TO  MCP-WIDGET
           WHEN    03
               MOVE  "NYKNKNRKBN"      TO  MCP-WIDGET
           WHEN    04
               MOVE  "GAI_NYUKIN"      TO  MCP-WIDGET
           WHEN    05
               MOVE  "NYU_NYUKIN"      TO  MCP-WIDGET
           WHEN    06
               MOVE  "NYUKIN"          TO  MCP-WIDGET
           WHEN    07
               MOVE  "NYUKINYMD"       TO  MCP-WIDGET
           WHEN    08
               MOVE  "SKYPRTKBN"       TO  MCP-WIDGET
           WHEN    212
               MOVE  "B12"             TO  MCP-WIDGET
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
      *    次のカーソル位置を決定
           EVALUATE    WRK-MCP-WIDGET
      *    入外区分　　　　→　外来入金額（または入金額）
           WHEN    "NYUGAIKBN"
               IF    ( SPA-GMN-RD-NYUKIN-IKT   =   "T" )
                   MOVE    04          TO  SPA-GMN-CUR
               ELSE
                   MOVE    06          TO  SPA-GMN-CUR
               END-IF
      *    選択番号　　　　→　入金額
           WHEN    "SELNUM"
               MOVE    06              TO  SPA-GMN-CUR
      *    入金管理区分　　→　外来入金額
           WHEN    "NYKNKNRKBN"
               MOVE    04              TO  SPA-GMN-CUR
      *    外来入金額　　　→　入院入金額
           WHEN    "GAI_NYUKIN"
               MOVE    05              TO  SPA-GMN-CUR
      *    入院入金額　　　→　外来入院入金額
           WHEN    "NYU_NYUKIN"
               MOVE    04              TO  SPA-GMN-CUR
      *    入金額　　　　　→　選択番号
           WHEN    "NYUKIN"
               MOVE    02              TO  SPA-GMN-CUR
      *    入金日　　→請求書兼領収書
           WHEN    "NYUKINYMD"
               MOVE    08              TO  SPA-GMN-CUR
      *    請求兼領収書　　→外来入金額
           WHEN    "SKYPRTKBN"
               MOVE    04              TO  SPA-GMN-CUR
           END-EVALUATE
      *
           .
       50011-GMN-CUR-SET-EXT.
           EXIT.
      *****************************************************************
      *    カーソルスキップ処理
      *****************************************************************
       50012-CUR-SKIP-SEC              SECTION.
      *
           IF    ( SPA-GMN-CUR         =   02 )
               IF    ( S06-SELNUM-STATE    =   WIDGET-INSENSITIVE )
                   MOVE    04              TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-CUR         =   06 )
               IF    ( S06-NYUKIN-STATE
                                       =   WIDGET-INSENSITIVE )
                   MOVE    04              TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-CUR         =   03 )
               IF    ( S06-NYKNKNRKBN-STATE
                                       =   WIDGET-INSENSITIVE )
                   MOVE    06              TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-CUR         =   04 )
               IF    ( S06-GAI-NYUKIN-STATE
                                       =   WIDGET-INSENSITIVE )
                   MOVE    06              TO  SPA-GMN-CUR
               ELSE
                   IF    ( SPA-GMN-GAI-NYUKIN-MAX  <=  ZERO )
                    AND  ( SPA-GMN-GAI-NYUKIN       =  ZERO )
                       MOVE    05          TO  SPA-GMN-CUR
                   END-IF
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-CUR         =   05 )
               IF    ( S06-NYU-NYUKIN-STATE
                                       =   WIDGET-INSENSITIVE )
                   MOVE    06              TO  SPA-GMN-CUR
               ELSE
                   IF    ( SPA-GMN-NYU-NYUKIN-MAX  <=  ZERO )
                    AND  ( SPA-GMN-NYU-NYUKIN       =  ZERO )
                       MOVE    05          TO  SPA-GMN-CUR
                   END-IF
               END-IF
           END-IF
      *
           .
      *
       50012-CUR-SKIP-EXT.
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
      *    ＤＢ検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DB-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
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
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBCLOSE-EXT.
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
