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
       PROGRAM-ID.             ORCGW07.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : 自動算定情報（Ｗ０７）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/06/05  薬剤情報提供料の追加
      *  01.00.02    MCC-藤原     01/09/11  削除処理の修正 
      *  01.01.01    MCC-藤原     01/09/21  JOINの修正      
      *  01.01.02    MCC-藤原     01/11/26  項目をコンボボックスに変更
      *  01.02.01    MCC-森脇     02/05/23  チェック機能制御情報の追加
      *  01.02.02    NACL-多々納  02/10/10  外来管理加算チェック追加
      *  01.02.03    NACL-多々納  02/10/31  外来管理加算チェック区分追加
      *  01.02.04    NACL-多々納  02/11/13  一括入力 
      *  01.02.05    NACL-多々納  02/11/20  チェック機能制御初期設定変更
      *  01.02.05    NACL-多々納  03/02/19  療養担当手当て追加
      *  01.02.06    NACL-多々納  03/03/14  特定薬剤治療管理料追加
      *  02.01.01    NACL-森脇    03/10/17  画面変更につき一括変更
      *  02.01.02    NACL-多々納  03/11/07  入院初診料追加
      *  02.01.03    NACL-多々納  04/01/09  包括登録追加
      *  02.01.04    NACL-多々納  04/01/15  数量ゼロ入力追加
      *  02.01.05    NACL-太田    04/01/16  診療行為機能情報タグ追加
      *  02.01.06    NACL-多々納  04/01/23  入院調基チェック追加
      *  02.01.07    NACL-太田    04/01/23  収納機能情報タグ追加
      *  02.01.08    NACL-多々納  04/03/08  時間外加算特例乳幼児他追加
      *  02.01.09    NACL-藤原    04/03/08  生保受給者番号の追加
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    システム管理情報設定用共通パラメタ
           COPY    "W01COMMON-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-W07.
           03  SPA-W07-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-LINE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(03).
               05  SPA-GMN-CUR         PIC 9(02).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-STYUKYMD    PIC X(09).
                   07  SPA-GMN-EDYUKYMD    PIC X(09).
                   07  SPA-GMN-PAGENO      PIC 9(01).
      *
                   07  SPA-GMN-PAGE1-AREA.
      *                自動算定チェック
                       09  SPA-GMN-DATA-TBL            OCCURS  7.
                           11  SPA-GMN-DATA-G.
                               13  SPA-GMN-DATA        PIC X(01).
                               13  SPA-GMN-F1          PIC X(01).
                               13  SPA-GMN-DATAMEI     PIC X(10).
      *
      *                自動算定科
                       09  SPA-GMN-SRYKACD             PIC X(02).
                       09  SPA-GMN-SRYKAMEI            PIC X(20).
      *                入院初診料
                       09  SPA-GMN-NYUSYOSIN-G.
                           11  SPA-GMN-NYUSYOSIN       PIC X(01).
                           11  SPA-GMN-FN              PIC X(01).
                           11  SPA-GMN-NYUSYOSINMEI    PIC X(10).
      *
      *                時間外加算特例乳幼児
                       09  SPA-GMN-JIKANTOKU-NYU-G.
                           11  SPA-GMN-JIKANTOKU-NYU   PIC X(01).
                           11  SPA-GMN-FN              PIC X(01).
                           11  SPA-GMN-JIKANTOKU-NYUMEI    PIC X(10).
      *                画像診断管理加算１
                       09  SPA-GMN-GAZOUKSN1-G.
                           11  SPA-GMN-GAZOUKSN1       PIC X(01).
                           11  SPA-GMN-FN              PIC X(01).
                           11  SPA-GMN-GAZOUKSN1MEI    PIC X(10).
      *
      *                相互作用チェック期間
                       09  SPA-GMN-INTERACT-KIKAN      PIC 9(02).
      *
      *                外来管理加算チェック
                       09  SPA-GMN-GAIKANRIKBN-G.
                           11  SPA-GMN-GAIKANRIKBN-CHK     PIC X(01).
                           11  SPA-GMN-GAIKANRIKBN-H       PIC X(01).
                           11  SPA-GMN-GAIKANRIKBN-MEI     PIC X(20).
                       09  SPA-GMN-GAIKANRIKBN-COMB.
                           11  SPA-GMN-GAIKANRIKBN-LIST    PIC X(22)
                                                           OCCURS  3.
      *                外来カーソル移動
                       09  SPA-GMN-GAIMOVE-G.
                           11  SPA-GMN-GAIMOVE             PIC X(01).
                           11  SPA-GMN-GAIMOVE-F1          PIC X(01).
                           11  SPA-GMN-GAIMOVEMEI          PIC X(20).
                       09  SPA-GMN-GAIMOVE-COMB.
                           11  SPA-GMN-GAIMOVE-LIST        PIC X(22)
                                                           OCCURS  3.
      *                包括まとめ
                       09  SPA-GMN-HOUKATU-G.
                           11  SPA-GMN-HOUKATU             PIC X(01).
                           11  SPA-GMN-HOUKATU-F1          PIC X(01).
                           11  SPA-GMN-HOUKATUMEI          PIC X(28).
                       09  SPA-GMN-HOUKATU-COMB.
                           11  SPA-GMN-HOUKATU-LIST        PIC X(30)
                                                           OCCURS  2.
      *                数量ゼロ入力
                       09  SPA-GMN-SURYOZERO-G.
                           11  SPA-GMN-SURYOZERO           PIC X(01).
                           11  SPA-GMN-SURYOZERO-F1        PIC X(01).
                           11  SPA-GMN-SURYOZEROMEI        PIC X(20).
                       09  SPA-GMN-SURYOZERO-COMB.
                           11  SPA-GMN-SURYOZERO-LIST      PIC X(20)
                                                           OCCURS  2.
      *                入院調基チェック
                       09  SPA-GMN-CHOKICHK-G.
                           11  SPA-GMN-CHOKICHK            PIC X(01).
                           11  SPA-GMN-CHOKICHK-F1         PIC X(01).
                           11  SPA-GMN-CHOKICHKMEI         PIC X(20).
                       09  SPA-GMN-CHOKICHK-COMB.
                           11  SPA-GMN-CHOKICHK-LIST       PIC X(20)
                                                           OCCURS  2.
                   07  SPA-GMN-PAGE2-AREA.
      *                カルテの病名対象
                       09  SPA-GMN-BYOMEIKBN-G.
                           11  SPA-GMN-BYOMEIKBN           PIC X(01).
                           11  SPA-GMN-BYOMEIKBN-F1        PIC X(01).
                           11  SPA-GMN-BYOMEIKBNMEI        PIC X(26).
                       09  SPA-GMN-BYOMEIKBN-COMB.
                           11  SPA-GMN-BYOMEIKBN-LIST      PIC X(28)
                                                           OCCURS  2.
      *                人名辞書使用
                       09  SPA-GMN-JISYOKBN-G.
                           11  SPA-GMN-JISYOKBN            PIC X(01).
                           11  SPA-GMN-JISYOKBN-F1         PIC X(01).
                           11  SPA-GMN-JISYOKBNMEI         PIC X(26).
                       09  SPA-GMN-JISYOKBN-COMB.
                           11  SPA-GMN-JISYOKBN-LIST       PIC X(28)
                                                           OCCURS  2.
      *                患者登録のカルテ発行
                       09  SPA-GMN-HAKKOKBN-G.
                           11  SPA-GMN-HAKKOKBN            PIC X(01).
                           11  SPA-GMN-HAKKOKBN-F1         PIC X(01).
                           11  SPA-GMN-HAKKOKBNMEI         PIC X(26).
                       09  SPA-GMN-HAKKOKBN-COMB.
                           11  SPA-GMN-HAKKOKBN-LIST       PIC X(28)
                                                           OCCURS  3.
      *                自費保険の補助区分
                       09  SPA-GMN-HOJYOKBN-G.
                           11  SPA-GMN-HOJYOKBN            PIC X(01).
                           11  SPA-GMN-HOJYOKBN-F1         PIC X(01).
                           11  SPA-GMN-HOJYOKBNMEI         PIC X(26).
                       09  SPA-GMN-HOJYOKBN-COMB.
                           11  SPA-GMN-HOJYOKBN-LIST       PIC X(28)
                                                           OCCURS  2.
      *                生活保護受給者番号
                       09  SPA-GMN-SEIHO-JKYSNUM-G.
                           11  SPA-GMN-SEIHO-JKYSNUM       PIC X(01).
                           11  SPA-GMN-SEIHO-JKYSNUM-F1    PIC X(01).
                           11  SPA-GMN-SEIHO-JKYSNUMMEI    PIC X(26).
                       09  SPA-GMN-SEIHO-JKYSNUM-COMB.
                           11  SPA-GMN-SEIHO-JKYSNUM-LIST  PIC X(28)
                                                           OCCURS  2.
                   07  SPA-GMN-PAGE3-AREA.
      *                入金管理情報（診療行為機能情報）
                       09  SPA-GMN-SRYNYKNKNRKBN-G.
                           11  SPA-GMN-SRYNYKNKNRKBN       PIC X(01).
                           11  SPA-GMN-SRYNYKNKNRKBN-F1    PIC X(01).
                           11  SPA-GMN-SRYNYKNKNRKBNMEI    PIC X(38).
                       09  SPA-GMN-SRYNYKNKNRKBNLST-G.
                           11  SPA-GMN-SRYNYKNKNRKBN-MAX   PIC 9(03).
                           11  SPA-GMN-SRYNYKNKNRKBNLST    OCCURS  5.
                               13  SPA-GMN-SRYNYKNKNRKBNL  PIC X(01).
                               13                          PIC X(01).
                               13  SPA-GMN-SRYNYKNKNRKBNMEIL
                                                           PIC X(38).
                   07  SPA-GMN-PAGE4-AREA.
      *                入金管理情報（収納機能情報）
                       09  SPA-GMN-SYUNYKNKNRKBN-G.
                           11  SPA-GMN-SYUNYKNKNRKBN       PIC X(01).
                           11  SPA-GMN-SYUNYKNKNRKBN-F1    PIC X(01).
                           11  SPA-GMN-SYUNYKNKNRKBNMEI    PIC X(38).
      *                請求書兼領収書発行区分
                       09  SPA-GMN-SYUSKYPRTKBN-G.
                           11  SPA-GMN-SYUSKYPRTKBN        PIC X(01).
                           11  SPA-GMN-SYUSKYPRTKBN-F1     PIC X(01).
                           11  SPA-GMN-SYUSKYPRTKBNMEI     PIC X(18).
      *
                       09  SPA-GMN-SYUNYKNKNRKBNLST-G.
                           11  SPA-GMN-SYUNYKNKNRKBN-MAX   PIC 9(03).
                           11  SPA-GMN-SYUNYKNKNRKBNLST    OCCURS  5.
                               13  SPA-GMN-SYUNYKNKNRKBNL  PIC X(01).
                               13                          PIC X(01).
                               13  SPA-GMN-SYUNYKNKNRKBNMEIL
                                                           PIC X(38).
                       09  SPA-GMN-SYUSKYPRTKBNLST-G.
                           11  SPA-GMN-SYUSKYPRTKBN-MAX    PIC 9(03).
                           11  SPA-GMN-SYUSKYPRTKBNLST     OCCURS  2.
                               13  SPA-GMN-SYUSKYPRTKBNL   PIC X(01).
                               13                          PIC X(01).
                               13  SPA-GMN-SYUSKYPRTKBNMEIL
                                                           PIC X(18).
      *
                   07  SPA-GMN-DATALST        OCCURS  2.
                       09  SPA-GMN-DATAL      PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-DATAMEIL   PIC X(10).
                   07  SPA-GMN-DATA-MAX       PIC 9(02).
      *
               05  SPA-NAIB-AREA.
                   07  SPA-NAI-STYUKYMD       PIC 9(08).
                   07  SPA-NAI-EDYUKYMD       PIC 9(08).
      *
           COPY    "ENUM-VALUE".
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-OK              PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-GMN-CUR         PIC 9(02).
           03  WRK-WIDGET.
               05  WRK-WIDGET1     PIC X(04).
               05  WRK-WIDGET2     PIC X(02).
           03  WRK-WIDMSG          PIC X(70).
           03  WRK-YMD             PIC X(09).
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
           03  WRK-MCP-WIDGET      PIC X(64).
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY  "CPSYSKANRI.INC".
      *    自動算定情報
           COPY  "CPSK1007.INC".
      *    チェック機能制御
           COPY  "CPSK1008.INC".
      *    患者登録機能制御情報
           COPY  "CPSK1017.INC".
      *    診療科情報
           COPY  "CPSK1005.INC".
      *    診療行為機能情報
           COPY  "CPSK1038.INC".
      *    収納機能情報
           COPY  "CPSK1039.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    日付サブルーチン領域
      *
           COPY  "CPORCSDAY.INC".
      *
           COPY  "CPORCSLNK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "W01.INC".
           COPY    "W02.INC".
           COPY    "W03.INC".
           COPY    "W04.INC".
           COPY    "W05.INC".
           COPY    "W06.INC".
           COPY    "W07.INC".
           COPY    "W08.INC".
           COPY    "W09.INC".
           COPY    "W10.INC".
           COPY    "W11.INC".
           COPY    "W12.INC".
           COPY    "W13.INC".
           COPY    "W14.INC".
           COPY    "W15.INC".
           COPY    "W16.INC".
           COPY    "W20.INC".
           COPY    "W21.INC".
           COPY    "W22.INC".
           COPY    "W23.INC".
           COPY    "W24.INC".
           COPY    "W25.INC".
           COPY    "W26.INC".
           COPY    "W27.INC".
           COPY    "W28.INC".
           COPY    "W98.INC".
           COPY    "W99.INC".
           COPY    "WERR.INC".
           COPY    "WID1.INC".
      *
       PROCEDURE                   DIVISION    USING
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-W01KYOUTU
           MOVE    SPA-FREE        TO  SPA-W07
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN    "PUTG"          ALSO   "CLICKED"
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
           MOVE    SPA-W07         TO  SPA-FREE
           MOVE    SPA-W01KYOUTU   TO  SPA-WORK 
           MOVE    SPA-AREA        TO  SPA-COMMON
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "WERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF      FLG-END             =   1
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               PERFORM 510-GSRAUTH-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE                TO  LINKAREA
      *
           MOVE    SPACE                TO  MCP-PUTTYPE
           MOVE    "W07"                TO  MCP-WINDOW
           PERFORM 900-PUT-WINDOW
           MOVE    1                    TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG
               WHEN    "WID1"
                   PERFORM 330-WID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM 310-SPASET-SEC
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-WID1-SET-SEC            SECTION.
      *
           IF      SPA-WID1-FLG    =   "OK"
               EVALUATE      SPA-WIDCD
                   WHEN   "1001"
      *                自動算定情報の更新
                       PERFORM  491-KOUSHIN-1007-SEC
                       PERFORM  491-KOUSHIN-1008-SEC
                   WHEN   "1002"
      *                自動算定情報の削除
                       PERFORM  4032-DEL-1007-SEC
                       PERFORM  4032-DEL-1008-SEC
                   WHEN   "1003"
      *                患者登録情報の更新
                       PERFORM  491-KOUSHIN-1017-SEC
                   WHEN   "1004"
      *                患者登録情報の削除
                       PERFORM  4032-DEL-1017-SEC
                   WHEN   "1005"
      *                診療行為情報の更新
                       PERFORM  491-KOUSHIN-1038-SEC
                   WHEN   "1006"
      *                診療行為情報の削除
                       PERFORM  4032-DEL-1038-SEC
                   WHEN   "1007"
      *                収納情報の更新
                       PERFORM  491-KOUSHIN-1039-SEC
                   WHEN   "1008"
      *                収納情報の削除
                       PERFORM  4032-DEL-1039-SEC
               END-EVALUATE
           ELSE
               EVALUATE    SPA-W01-KANRICD
                   WHEN    "1007"
                       MOVE    2            TO  SPA-GMN-CUR
                   WHEN    "1017"
                       MOVE    20           TO  SPA-GMN-CUR
                   WHEN    "1038"
                       MOVE    30           TO  SPA-GMN-CUR
               END-EVALUATE
           END-IF
      *
           MOVE    SPACE           TO  SPA-WID1-FLG
           MOVE    SPACE           TO  SPA-WIDCD
           .
       330-WID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           INITIALIZE   SPA-W07
      *
           MOVE    SPA-W01-STYUKYMDH   TO  SPA-GMN-STYUKYMD
           MOVE    SPA-W01-EDYUKYMDH   TO  SPA-GMN-EDYUKYMD
      *
           MOVE    "0"                 TO  SPA-GMN-DATAL(1)
           MOVE    "算定しない"        TO  SPA-GMN-DATAMEIL(1)
           MOVE    "1"                 TO  SPA-GMN-DATAL(2)
           MOVE    "算定する"          TO  SPA-GMN-DATAMEIL(2)
           MOVE    2                   TO  SPA-GMN-DATA-MAX
      *
           MOVE    "0 チェックなし"    TO  SPA-GMN-GAIKANRIKBN-LIST(1)
           MOVE    "1 チェックあり"    TO  SPA-GMN-GAIKANRIKBN-LIST(2)
           MOVE    "2 自動発生なし"    TO  SPA-GMN-GAIKANRIKBN-LIST(3)
      *
           MOVE    "0 標準"            TO  SPA-GMN-GAIMOVE-LIST(1)
           MOVE    "1 保険組合せ"      TO  SPA-GMN-GAIMOVE-LIST(2)
           MOVE    "2 診療科"          TO  SPA-GMN-GAIMOVE-LIST(3)
      *
      *
           MOVE    "0 包括分入力をしない"
                                       TO  SPA-GMN-HOUKATU-LIST(1)
           MOVE    "1 包括分入力をする"
                                       TO  SPA-GMN-HOUKATU-LIST(2)
      *
      *
           MOVE    "0 標準（行削除する）"
                                       TO  SPA-GMN-SURYOZERO-LIST(1)
           MOVE    "1 入力エラーとする"
                                       TO  SPA-GMN-SURYOZERO-LIST(2)
      *
      *    入院調基チェック
           MOVE    "0 チェックしない"
                                       TO  SPA-GMN-CHOKICHK-LIST(1)
           MOVE    "1 チェックする"
                                       TO  SPA-GMN-CHOKICHK-LIST(2)
      *
           MOVE    "0 すべての病名"    TO  SPA-GMN-BYOMEIKBN-LIST(1)
           MOVE    "1 継続病名のみ"    TO  SPA-GMN-BYOMEIKBN-LIST(2)
      *
           MOVE    "0 使用する"        TO  SPA-GMN-JISYOKBN-LIST(1)
           MOVE    "1 使用しない"      TO  SPA-GMN-JISYOKBN-LIST(2)
      *
           MOVE    "0 発行しない"      TO  SPA-GMN-HAKKOKBN-LIST(1)
           MOVE    "1 発行する（保険組合せ指示）"
                                       TO  SPA-GMN-HAKKOKBN-LIST(2)
           MOVE    "2 発行する（保険組合せ自動）"
                                       TO  SPA-GMN-HAKKOKBN-LIST(3)
      *
           MOVE    "0 課税"            TO  SPA-GMN-HOJYOKBN-LIST(1)
           MOVE    "1 非課税"          TO  SPA-GMN-HOJYOKBN-LIST(2)
      *
           MOVE    "0 毎月付番"        TO  SPA-GMN-SEIHO-JKYSNUM-LIST(1)
           MOVE    "1 固定番号"        TO  SPA-GMN-SEIHO-JKYSNUM-LIST(2)
      *
           MOVE    "1 今回請求分のみ入金"
                                       TO  SPA-GMN-SRYNYKNKNRKBNLST(1)
           MOVE    "2 今回分・伝票の古い未収順に入金"
                                       TO  SPA-GMN-SRYNYKNKNRKBNLST(2)
           MOVE    "3 今回分・伝票の新しい未収順に入金"
                                       TO  SPA-GMN-SRYNYKNKNRKBNLST(3)
           MOVE    "4 伝票の古い未収順に入金"
                                       TO  SPA-GMN-SRYNYKNKNRKBNLST(4)
           MOVE    "5 伝票の新しい未収順に入金"
                                       TO  SPA-GMN-SRYNYKNKNRKBNLST(5)
           MOVE    5                   TO  SPA-GMN-SRYNYKNKNRKBN-MAX
      *
           MOVE    "1 伝票の古い未収順に入金"
                                       TO  SPA-GMN-SYUNYKNKNRKBNLST(1)
           MOVE    "2 伝票の新しい未収順に入金"
                                       TO  SPA-GMN-SYUNYKNKNRKBNLST(2)
           MOVE    2                   TO  SPA-GMN-SYUNYKNKNRKBN-MAX
      *
           MOVE    "0 発行しない"      TO  SPA-GMN-SYUSKYPRTKBNLST(1)
           MOVE    "1 発行する"        TO  SPA-GMN-SYUSKYPRTKBNLST(2)
           MOVE    2                   TO  SPA-GMN-SYUSKYPRTKBN-MAX
      *
           EVALUATE    SPA-W01-KANRICD
      *        診療行為情報
               WHEN    "1007"
                   PERFORM 310-SPASET-1007-SEC
      *        患者登録機能制御情報
               WHEN    "1017"
                   PERFORM 310-SPASET-1017-SEC
      *        診療行為機能情報
               WHEN    "1038"
                   PERFORM 310-SPASET-1038-SEC
      *        収納機能情報
               WHEN    "1039"
                   PERFORM 310-SPASET-1039-SEC
           END-EVALUATE
      *
           . 
       31O-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-1007-SEC         SECTION.
      *
      *    自動算定情報
           MOVE    SPACE               TO  SYSKANRI-REC
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1007"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1007-REC
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       6
                   MOVE    SYS-1007-SANTEI(IDX:1)
                                               TO  SPA-GMN-DATA(IDX)
                   PERFORM VARYING IDY     FROM    1   BY  1
                           UNTIL   IDY     >   SPA-GMN-DATA-MAX
                       IF      SPA-GMN-DATA(IDX)
                                           =   SPA-GMN-DATAL(IDY)
                           MOVE    SPA-GMN-DATALST(IDY)
                                               TO SPA-GMN-DATA-G(IDX)
                           MOVE    SPA-GMN-DATA-MAX   TO  IDY
                       END-IF
                   END-PERFORM
               END-PERFORM
           END-IF
      *
      *    チェック機能制御割り当て情報
           MOVE    SPACE               TO  SYSKANRI-REC
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1008"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1008-REC
      *
      *        育児自動算定
               MOVE    SYS-1008-IKUJIEIYO-FLG
                                       TO  SPA-GMN-DATA(7)
               PERFORM VARYING IDY     FROM    1   BY  1
                       UNTIL   IDY     >   SPA-GMN-DATA-MAX
                   IF      SPA-GMN-DATA(7)
                                       =   SPA-GMN-DATAL(IDY)
                       MOVE    SPA-GMN-DATALST(IDY)
                                           TO SPA-GMN-DATA-G(7)
                       MOVE    SPA-GMN-DATA-MAX   TO  IDY
                   END-IF
               END-PERFORM
      *
               IF      SPA-GMN-DATA(7)     =   "1"
      *            育児自動算定診療科
                   MOVE    SYS-1008-IKUJIEIYO-SRYKA
                                           TO  SPA-GMN-SRYKACD
               END-IF
      *
               MOVE    SYS-1008-INTERACT-KIKAN
                                           TO  SPA-GMN-INTERACT-KIKAN
      *        外来管理加算チェック
               MOVE    SYS-1008-GAIKANRIKBN-CHK
                                           TO  SPA-GMN-GAIKANRIKBN-CHK
      *        外来カーソル移動
               MOVE    SYS-1008-GAI-CURSOR-SET-1
                                           TO  SPA-GMN-GAIMOVE
      *        数量ゼロ入力
               MOVE    SYS-1008-SURYOZERO-FLG
                                           TO  SPA-GMN-SURYOZERO
      *        入院調基チェック
               MOVE    SYS-1008-CHOKICHK-FLG
                                           TO  SPA-GMN-CHOKICHK
      *
      *        入院初診料自動発生
               MOVE    SYS-1008-NYU-SYOSIN
                                       TO  SPA-GMN-NYUSYOSIN
      *
      *        包括まとめ
               MOVE    SYS-1008-HOUKATU-FLG
                                       TO  SPA-GMN-HOUKATU
      *
      *        時間外加算特例乳幼児
               MOVE    SYS-1008-JIKANTOKU-NYU-FLG
                                       TO  SPA-GMN-JIKANTOKU-NYU
      *        画像診断管理加算１
               MOVE    SYS-1008-GAZOUKSN1-FLG
                                       TO  SPA-GMN-GAZOUKSN1
           END-IF
      *
      *    入院初診料
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING IDY         FROM    1   BY  1
                   UNTIL   IDY         >   SPA-GMN-DATA-MAX
               IF      SPA-GMN-NYUSYOSIN
                                       =   SPA-GMN-DATAL(IDY)
                   MOVE    SPA-GMN-DATALST(IDY)
                                               TO SPA-GMN-NYUSYOSIN-G
                   MOVE    1                   TO  FLG-OK
                   MOVE    SPA-GMN-DATA-MAX    TO  IDY
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    SPA-GMN-DATALST(01) TO SPA-GMN-NYUSYOSIN-G
           END-IF
      *
      *    初期設定
           PERFORM VARYING IDX    FROM     1   BY  1
                   UNTIL   IDX    >   7
               IF     SPA-GMN-DATA (IDX)   =   "0"  OR  "1"
                   CONTINUE
               ELSE
                   MOVE    SPA-GMN-DATALST(01)
                                       TO  SPA-GMN-DATA-G(IDX)
               END-IF
           END-PERFORM
      *
           EVALUATE    SPA-GMN-GAIMOVE
                WHEN    "1"
                    MOVE    SPA-GMN-GAIMOVE-LIST(2)
                                               TO  SPA-GMN-GAIMOVE-G
                WHEN    "2"
                    MOVE    SPA-GMN-GAIMOVE-LIST(3)
                                               TO  SPA-GMN-GAIMOVE-G
                WHEN    OTHER
                    MOVE    SPA-GMN-GAIMOVE-LIST(1)
                                               TO  SPA-GMN-GAIMOVE-G
            END-EVALUATE
      *
           IF      SPA-GMN-GAIKANRIKBN-CHK   =   SPACE
                MOVE    "1"     TO  SPA-GMN-GAIKANRIKBN-CHK
           END-IF
           EVALUATE    SPA-GMN-GAIKANRIKBN-CHK
                WHEN    "1"
                    MOVE    SPA-GMN-GAIKANRIKBN-LIST(2)
                                               TO  SPA-GMN-GAIKANRIKBN-G
                WHEN    "2"
                    MOVE    SPA-GMN-GAIKANRIKBN-LIST(3)
                                               TO  SPA-GMN-GAIKANRIKBN-G
                WHEN    OTHER
                    MOVE    SPA-GMN-GAIKANRIKBN-LIST(1)
                                               TO  SPA-GMN-GAIKANRIKBN-G
            END-EVALUATE
      *
      *    時間外加算特例乳幼児
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING IDY         FROM    1   BY  1
                   UNTIL   IDY         >   SPA-GMN-DATA-MAX
               IF      SPA-GMN-JIKANTOKU-NYU
                                       =   SPA-GMN-DATAL(IDY)
                   MOVE    SPA-GMN-DATALST(IDY)
                                           TO SPA-GMN-JIKANTOKU-NYU-G
                   MOVE    1                   TO  FLG-OK
                   MOVE    SPA-GMN-DATA-MAX    TO  IDY
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    SPA-GMN-DATALST(01) TO SPA-GMN-JIKANTOKU-NYU-G
           END-IF
      *
      *    画像診断管理加算１
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING IDY         FROM    1   BY  1
                   UNTIL   IDY         >   SPA-GMN-DATA-MAX
               IF      SPA-GMN-GAZOUKSN1
                                       =   SPA-GMN-DATAL(IDY)
                   MOVE    SPA-GMN-DATALST(IDY)
                                           TO SPA-GMN-GAZOUKSN1-G
                   MOVE    1                   TO  FLG-OK
                   MOVE    SPA-GMN-DATA-MAX    TO  IDY
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    SPA-GMN-DATALST(01) TO SPA-GMN-GAZOUKSN1-G
           END-IF
      *
      *    包括まとめ
           IF      SPA-GMN-HOUKATU    =   SPACE
               MOVE    "0"            TO  SPA-GMN-HOUKATU
           END-IF
           EVALUATE    SPA-GMN-HOUKATU
                WHEN    "0"
                    MOVE    SPA-GMN-HOUKATU-LIST(1)
                                               TO  SPA-GMN-HOUKATU-G
                WHEN    "1"
                    MOVE    SPA-GMN-HOUKATU-LIST(2)
                                               TO  SPA-GMN-HOUKATU-G
                WHEN    OTHER
                    MOVE    SPA-GMN-HOUKATU-LIST(1)
                                               TO  SPA-GMN-HOUKATU-G
            END-EVALUATE
      *
      *    数量ゼロ入力
           IF      SPA-GMN-SURYOZERO  =   SPACE
               MOVE    "0"            TO  SPA-GMN-SURYOZERO
           END-IF
           EVALUATE    SPA-GMN-SURYOZERO
                WHEN    "0"
                    MOVE    SPA-GMN-SURYOZERO-LIST(1)
                                               TO  SPA-GMN-SURYOZERO-G
                WHEN    "1"
                    MOVE    SPA-GMN-SURYOZERO-LIST(2)
                                               TO  SPA-GMN-SURYOZERO-G
                WHEN    OTHER
                    MOVE    SPA-GMN-SURYOZERO-LIST(1)
                                               TO  SPA-GMN-SURYOZERO-G
            END-EVALUATE
      *
      *    入院調基チェック
           IF      SPA-GMN-CHOKICHK   =   SPACE
               MOVE    "0"            TO  SPA-GMN-CHOKICHK
           END-IF
           EVALUATE    SPA-GMN-CHOKICHK
                WHEN    "0"
                    MOVE    SPA-GMN-CHOKICHK-LIST(1)
                                               TO  SPA-GMN-CHOKICHK-G
                WHEN    "1"
                    MOVE    SPA-GMN-CHOKICHK-LIST(2)
                                               TO  SPA-GMN-CHOKICHK-G
                WHEN    OTHER
                    MOVE    SPA-GMN-CHOKICHK-LIST(1)
                                               TO  SPA-GMN-CHOKICHK-G
            END-EVALUATE
      *
      *     診療科コードセット
            PERFORM 4102-SRYKACD-CHK-SEC
      *
            MOVE    2                  TO  SPA-GMN-CUR
      *
           . 
       31O-SPASET-1007-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-1017-SEC         SECTION.
      *
      *    患者登録機能制御情報
           MOVE    SPACE               TO  SYSKANRI-REC
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1017"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1017-REC
      *        カルテの病名対象
               MOVE    SYS-1017-KARUTE-BYOMEI
                                       TO  SPA-GMN-BYOMEIKBN
      *        人名辞書使用
               MOVE    SYS-1017-JINMEI-USE
                                       TO  SPA-GMN-JISYOKBN
      *        患者登録のカルテ発行
               MOVE    SYS-1017-KARUTE-HAKKO
                                       TO  SPA-GMN-HAKKOKBN
      *        自費保険の補助区分
               MOVE    SYS-1017-JIHIHKN-TAX
                                       TO  SPA-GMN-HOJYOKBN
      *        生活保護受給者番号
               MOVE    SYS-1017-SEIHO-JKYSNUM
                                       TO  SPA-GMN-SEIHO-JKYSNUM
           END-IF
      *
      *    初期設定
           EVALUATE    SPA-GMN-BYOMEIKBN
                WHEN    "1"
                    MOVE    SPA-GMN-BYOMEIKBN-LIST(2)
                                               TO  SPA-GMN-BYOMEIKBN-G
                WHEN    OTHER
                    MOVE    SPA-GMN-BYOMEIKBN-LIST(1)
                                               TO  SPA-GMN-BYOMEIKBN-G
           END-EVALUATE
      *
           EVALUATE    SPA-GMN-JISYOKBN
                WHEN    "1"
                    MOVE    SPA-GMN-JISYOKBN-LIST(2)
                                               TO  SPA-GMN-JISYOKBN-G
                WHEN    OTHER
                    MOVE    SPA-GMN-JISYOKBN-LIST(1)
                                               TO  SPA-GMN-JISYOKBN-G
           END-EVALUATE
      *
           EVALUATE    SPA-GMN-HAKKOKBN
                WHEN    "1"
                    MOVE    SPA-GMN-HAKKOKBN-LIST(2)
                                               TO  SPA-GMN-HAKKOKBN-G
                WHEN    "2"
                    MOVE    SPA-GMN-HAKKOKBN-LIST(3)
                                               TO  SPA-GMN-HAKKOKBN-G
                WHEN    OTHER
                    MOVE    SPA-GMN-HAKKOKBN-LIST(1)
                                               TO  SPA-GMN-HAKKOKBN-G
           END-EVALUATE
      *
           EVALUATE    SPA-GMN-HOJYOKBN
                WHEN    "1"
                    MOVE    SPA-GMN-HOJYOKBN-LIST(2)
                                               TO  SPA-GMN-HOJYOKBN-G
                WHEN    OTHER
                    MOVE    SPA-GMN-HOJYOKBN-LIST(1)
                                               TO  SPA-GMN-HOJYOKBN-G
           END-EVALUATE
      *
           EVALUATE    SPA-GMN-SEIHO-JKYSNUM
                WHEN    "1"
                    MOVE    SPA-GMN-SEIHO-JKYSNUM-LIST(2)
                                           TO  SPA-GMN-SEIHO-JKYSNUM-G
                WHEN    OTHER
                    MOVE    SPA-GMN-SEIHO-JKYSNUM-LIST(1)
                                           TO  SPA-GMN-SEIHO-JKYSNUM-G
           END-EVALUATE
      *
           MOVE    20                 TO  SPA-GMN-CUR
      *
           . 
       31O-SPASET-1017-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-1038-SEC         SECTION.
      *
      *    診療行為機能情報
           MOVE    SPACE               TO  SYSKANRI-REC
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1038"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1038-REC
           ELSE
               INITIALIZE  SYS-1038-REC
           END-IF
      *
           MOVE    SYS-1038-NYKNKNRKBN TO  SPA-GMN-SRYNYKNKNRKBN
      *
      *    入金管理区分
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING IDY         FROM    1   BY  1
                   UNTIL   IDY         >   SPA-GMN-SRYNYKNKNRKBN-MAX
               IF      SPA-GMN-SRYNYKNKNRKBN
                                       =   SPA-GMN-SRYNYKNKNRKBNL (IDY)
                   MOVE    SPA-GMN-SRYNYKNKNRKBNLST(IDY)
                                       TO  SPA-GMN-SRYNYKNKNRKBN-G
                   MOVE    1           TO  FLG-OK
                   MOVE    SPA-GMN-SRYNYKNKNRKBN-MAX
                                       TO  IDY
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    SPA-GMN-SRYNYKNKNRKBNLST (1)
                                       TO  SPA-GMN-SRYNYKNKNRKBN-G
           END-IF
      *
           MOVE    30                  TO  SPA-GMN-CUR
      *
           . 
       31O-SPASET-1038-EXT.
           EXIT.
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-1039-SEC         SECTION.
      *
      *    収納機能情報
           MOVE    SPACE               TO  SYSKANRI-REC
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1039"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1039-REC
           ELSE
               INITIALIZE  SYS-1039-REC
           END-IF
      *
      *    入金管理区分
           MOVE    SYS-1039-NYKNKNRKBN TO  SPA-GMN-SYUNYKNKNRKBN
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING IDY         FROM    1   BY  1
                   UNTIL   IDY         >   SPA-GMN-SYUNYKNKNRKBN-MAX
               IF      SPA-GMN-SYUNYKNKNRKBN
                                       =   SPA-GMN-SYUNYKNKNRKBNL (IDY)
                   MOVE    SPA-GMN-SYUNYKNKNRKBNLST(IDY)
                                       TO  SPA-GMN-SYUNYKNKNRKBN-G
                   MOVE    1           TO  FLG-OK
                   MOVE    SPA-GMN-SYUNYKNKNRKBN-MAX
                                       TO  IDY
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    SPA-GMN-SYUNYKNKNRKBNLST (1)
                                       TO  SPA-GMN-SYUNYKNKNRKBN-G
           END-IF
      *
      *    請求書兼領収書発行区分
      *    MOVE    SYS-1039-SKYPRTKBN  TO  SPA-GMN-SYUSKYPRTKBN
      *
      *    MOVE    ZERO                TO  FLG-OK
      *    PERFORM VARYING IDY         FROM    1   BY  1
      *            UNTIL   IDY         >   SPA-GMN-SYUSKYPRTKBN-MAX
      *        IF      SPA-GMN-SYUSKYPRTKBN
      *                                =   SPA-GMN-SYUSKYPRTKBNL (IDY)
      *            MOVE    SPA-GMN-SYUSKYPRTKBNLST(IDY)
      *                                TO  SPA-GMN-SYUSKYPRTKBN-G
      *            MOVE    1           TO  FLG-OK
      *            MOVE    SPA-GMN-SYUSKYPRTKBN-MAX
      *                                TO  IDY
      *        END-IF
      *    END-PERFORM
      *    IF      FLG-OK              =   ZERO
      *        MOVE    SPA-GMN-SYUSKYPRTKBNLST (1)
      *                                TO  SPA-GMN-SYUSKYPRTKBN-G
      *    END-IF
      *
           MOVE    40                 TO  SPA-GMN-CUR
      *
           . 
       31O-SPASET-1039-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE   "CHANGE"             TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *    削除
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM  403-DEL-SEC
      *    登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 490-TOUROKU-SEC
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
           MOVE    ZERO                TO  SPA-GMN-CUR
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
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
      *    基本チェック処理
           PERFORM 4102-KIHON-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      410-INPUT-CHK-EXT
           END-IF
      *
           .
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面をＳＰＡセット処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC        SECTION.
      *
      *    自動算定情報
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   7
               MOVE    W07-DATA (IDX)      TO  SPA-GMN-DATA-G (IDX)
           END-PERFORM
      *    入院初診料自動算定
           MOVE    W07-NYUSYOSIN       TO  SPA-GMN-NYUSYOSIN-G
      *    時間外加算特例乳幼児
           MOVE    W07-JIKANTOKUNYU    TO  SPA-GMN-JIKANTOKU-NYU-G
           MOVE    W07-GAZOUKSN1       TO  SPA-GMN-GAZOUKSN1-G
      *
           MOVE    W07-SRYKACD         TO  SPA-GMN-SRYKACD
           MOVE    W07-SRYKAMEI        TO  SPA-GMN-SRYKAMEI
      *
      *    チェック制御
           MOVE    W07-KIKAN           TO  SPA-GMN-INTERACT-KIKAN
           MOVE    W07-GAIKANKBN       TO  SPA-GMN-GAIKANRIKBN-G
           MOVE    W07-GAIMOVE         TO  SPA-GMN-GAIMOVE-G
           MOVE    W07-SURYOZERO       TO  SPA-GMN-SURYOZERO-G
           MOVE    W07-CHOKICHK        TO  SPA-GMN-CHOKICHK-G
      *
           MOVE    W07-HOUKATU         TO  SPA-GMN-HOUKATU-G
      *
      *    患者登録情報
           MOVE    W07-BYOMEIKBN       TO  SPA-GMN-BYOMEIKBN-G
           MOVE    W07-JISYOKBN        TO  SPA-GMN-JISYOKBN-G
           MOVE    W07-HAKKOKBN        TO  SPA-GMN-HAKKOKBN-G
           MOVE    W07-HOJYOKBN        TO  SPA-GMN-HOJYOKBN-G
           MOVE    W07-SEIHO-JKYSNUM   TO  SPA-GMN-SEIHO-JKYSNUM-G
      *
      *    診療行為機能情報
           MOVE    W07-SRYNYKNKNRKBN   TO  SPA-GMN-SRYNYKNKNRKBN-G
      *
      *    収納機能情報
           MOVE    W07-SYUNYKNKNRKBN   TO  SPA-GMN-SYUNYKNKNRKBN-G
           MOVE    W07-SYUSKYPRTKBN    TO  SPA-GMN-SYUSKYPRTKBN-G
      *
           .
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC       SECTION.
      *
           EVALUATE    SPA-W01-KANRICD
               WHEN    "1007"
      *            調剤技術基本料チェック
                   PERFORM 4100-DATA-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
      *            診療科チェック
                   PERFORM 4102-SRYKACD-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
      *            入院初診料自動算定チェック
                   PERFORM 4103-NYUSYOSIN-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
      *            時間外加算特例乳幼児
                   PERFORM 4103-JIKANTOKU-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
      *            画像診断管理加算１
                   PERFORM 4103-GAZOUKSN1-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
      *            相互作用チェック期間
                   PERFORM 4100-KIKAN-CHK2-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
      *            外来管理加算チェック
                   PERFORM 4101-GAIKANRIKBN-CHK2-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
      *            外来カーソル移動チェック
                   PERFORM 4103-GAIMOVE-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
      *            数量ゼロチェック
                   PERFORM 4103-SURYOZERO-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
      *            入院調基チェック
                   PERFORM 4103-CHOKICHK-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
      *            包括入力チェック
                   PERFORM 4103-HOUKATU-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
               WHEN    "1017"
      *            カルテの病名対象チェック
                   PERFORM 4104-BYOMEI-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
      *            人名辞書使用チェック
                   PERFORM 4105-JISYO-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
      *            患者登録のカルテ発行チェック
                   PERFORM 4106-HAKKO-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
      *            自費保険の補助区分チェック
                   PERFORM 4107-HOJYO-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
      *            生活保護受給者番号チェック
                   PERFORM 4112-SEIHO-JKYSNUM-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
               WHEN    "1038"
      *            入金管理区分チェック
                   PERFORM 4108-SRYNYKNKNRKBN-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
               WHEN    "1039"
      *            入金管理区分チェック
                   PERFORM 4109-SYUNYKNKNRKBN-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
      *            請求書兼領収書発行区分区分チェック
      *            PERFORM 4110-SYUSKYPRTKBN-CHK-SEC
      *            IF      SPA-ERRCD       NOT =   SPACE
      *                GO      TO      4102-KIHON-CHK-EXT
      *            END-IF
           END-EVALUATE
      *
           .
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    調剤技術基本料チェック
      *****************************************************************
       4100-DATA-CHK-SEC       SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   7   )
                   OR         (SPA-ERRCD   NOT =   SPACE )
               MOVE    ZERO                TO  FLG-OK
      *
               PERFORM VARYING     IDY     FROM    1   BY  1
                       UNTIL       IDY     >   SPA-GMN-DATA-MAX
                   IF      SPA-GMN-DATA (IDX)  =   SPA-GMN-DATAL(IDY)
                       MOVE    SPA-GMN-DATALST (IDY)
                                               TO  SPA-GMN-DATA-G(IDX)
                       MOVE    1               TO  FLG-OK
                   END-IF
               END-PERFORM
      *
               IF      FLG-OK             =   ZERO
                   EVALUATE    IDX
                       WHEN    1
                           MOVE    "0001"             TO SPA-ERRCD
                       WHEN    2
                           MOVE    "0002"             TO SPA-ERRCD
                       WHEN    3
                           MOVE    "0003"             TO SPA-ERRCD
                       WHEN    4
                           MOVE    "0004"             TO SPA-ERRCD
                       WHEN    5
                           MOVE    "0008"             TO SPA-ERRCD
                       WHEN    6
                           MOVE    "0009"             TO SPA-ERRCD
                       WHEN    7
                           MOVE    "0010"             TO SPA-ERRCD
                   END-EVALUATE
                   MOVE    IDX             TO  SPA-GMN-CUR
                   ADD     1               TO  SPA-GMN-CUR
               END-IF
           END-PERFORM
           .
       4100-DATA-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    相互作用チェック期間チェック処理
      *****************************************************************
       4100-KIKAN-CHK2-SEC       SECTION.
      *
          .
       4100-KIKAN-CHK2-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院初診料自動算定チェック処理
      *****************************************************************
       4103-NYUSYOSIN-CHK-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
      *
           PERFORM VARYING     IDY     FROM    1   BY  1
                   UNTIL       IDY     >   SPA-GMN-DATA-MAX
               IF      SPA-GMN-NYUSYOSIN   =   SPA-GMN-DATAL(IDY)
                   MOVE    SPA-GMN-DATALST (IDY)
                                           TO  SPA-GMN-NYUSYOSIN-G
                   MOVE    1               TO  FLG-OK
               END-IF
           END-PERFORM
      *
           IF      FLG-OK              =   ZERO
               MOVE    "0013"              TO  SPA-ERRCD
               MOVE    13                  TO  SPA-GMN-CUR
           END-IF
      *
          .
       4103-NYUSYOSIN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画像診断管理加算１チェック処理
      *****************************************************************
       4103-GAZOUKSN1-CHK-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
      *
           PERFORM VARYING     IDY     FROM    1   BY  1
                   UNTIL       IDY     >   SPA-GMN-DATA-MAX
               IF      SPA-GMN-GAZOUKSN1   =   SPA-GMN-DATAL(IDY)
                   MOVE    SPA-GMN-DATALST (IDY)
                                           TO  SPA-GMN-GAZOUKSN1-G
                   MOVE    1               TO  FLG-OK
               END-IF
           END-PERFORM
      *
           IF      FLG-OK              =   ZERO
               MOVE    "0018"              TO  SPA-ERRCD
               MOVE    18                  TO  SPA-GMN-CUR
           END-IF
      *
          .
       4103-GAZOUKSN1-CHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    時間外加算特例乳幼児算定チェック処理
      *****************************************************************
       4103-JIKANTOKU-CHK-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
      *
           PERFORM VARYING     IDY     FROM    1   BY  1
                   UNTIL       IDY     >   SPA-GMN-DATA-MAX
               IF      SPA-GMN-JIKANTOKU-NYU   =   SPA-GMN-DATAL(IDY)
                   MOVE    SPA-GMN-DATALST (IDY)
                                           TO  SPA-GMN-JIKANTOKU-NYU-G
                   MOVE    1               TO  FLG-OK
               END-IF
           END-PERFORM
      *
           IF      FLG-OK              =   ZERO
               MOVE    "0017"              TO  SPA-ERRCD
               MOVE    17                  TO  SPA-GMN-CUR
           END-IF
      *
          .
       4103-JIKANTOKU-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    外来管理加算チェック処理
      *****************************************************************
       4101-GAIKANRIKBN-CHK2-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               IF      SPA-GMN-GAIKANRIKBN-CHK
                                      =   SPA-GMN-GAIKANRIKBN-LIST(IDX)
                                                                (1:1)
                   MOVE    SPA-GMN-GAIKANRIKBN-LIST(IDX)
                                          TO  SPA-GMN-GAIKANRIKBN-G
                   MOVE    1              TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    11              TO  SPA-GMN-CUR
               MOVE    "0006"          TO  SPA-ERRCD
               GO      TO      4101-GAIKANRIKBN-CHK2-EXT
           END-IF
      *
          .
       4101-GAIKANRIKBN-CHK2-EXT.
           EXIT.
      *
      *****************************************************************
      *    自動算定科チェック処理
      *****************************************************************
       4102-SRYKACD-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-DATA (7)  =   "1"
               IF      ( SPA-GMN-SRYKACD   =   "0" )
                   OR  ( SPA-GMN-SRYKACD   =   "00" )
                   OR  ( SPA-GMN-SRYKACD   =   SPACE )
                   MOVE    "00"            TO  SPA-GMN-SRYKACD
                   MOVE    "全科"          TO  SPA-GMN-SRYKAMEI
               ELSE
      *            診療科名
                   MOVE    SPACE           TO  SYSKANRI-REC 
                   INITIALIZE                  SYSKANRI-REC
                   MOVE    "1005"          TO  SYS-KANRICD
                   MOVE    SPA-GMN-SRYKACD TO  SYS-KBNCD
                   MOVE    SYSKANRI-REC        TO  MCPDATA-REC
                   MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
                   PERFORM 900-SYSKANRI-INV-SEC
                   IF      FLG-SYSKANRI            =   ZERO
                       MOVE    MCPDATA-REC     TO  SYS-1005-REC
                       MOVE    SYS-1005-SRYKANAME1
                                               TO  SPA-GMN-SRYKAMEI
                   ELSE
                       MOVE    9               TO  SPA-GMN-CUR
                       MOVE    SPACE           TO  SPA-GMN-SRYKAMEI
                       MOVE    "0011"          TO  SPA-ERRCD
                       GO      TO       4102-SRYKACD-CHK-EXT
                   END-IF
               END-IF
           ELSE
               MOVE    SPACE           TO  SPA-GMN-SRYKACD
               MOVE    SPACE           TO  SPA-GMN-SRYKAMEI
           END-IF
           .
       4102-SRYKACD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    外来カーソル移動チェック処理
      *****************************************************************
       4103-GAIMOVE-CHK-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               IF      SPA-GMN-GAIMOVE
                                      =   SPA-GMN-GAIMOVE-LIST(IDX)
                                                                (1:1)
                   MOVE    SPA-GMN-GAIMOVE-LIST(IDX)
                                          TO  SPA-GMN-GAIMOVE-G
                   MOVE    1              TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    12              TO  SPA-GMN-CUR
               MOVE    "0012"          TO  SPA-ERRCD
               GO      TO      4103-GAIMOVE-CHK-EXT
           END-IF
      *
          .
       4103-GAIMOVE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    数量ゼロ入力チェック処理
      *****************************************************************
       4103-SURYOZERO-CHK-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               IF      SPA-GMN-SURYOZERO
                                      =   SPA-GMN-SURYOZERO-LIST(IDX)
                                                                (1:1)
                   MOVE    SPA-GMN-SURYOZERO-LIST(IDX)
                                          TO  SPA-GMN-SURYOZERO-G
                   MOVE    1              TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    14              TO  SPA-GMN-CUR
               MOVE    "0015"          TO  SPA-ERRCD
               GO      TO      4103-SURYOZERO-CHK-EXT
           END-IF
      *
          .
       4103-SURYOZERO-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院調基チェック入力チェック処理
      *****************************************************************
       4103-CHOKICHK-CHK-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               IF      SPA-GMN-CHOKICHK
                                      =   SPA-GMN-CHOKICHK-LIST(IDX)
                                                                (1:1)
                   MOVE    SPA-GMN-CHOKICHK-LIST(IDX)
                                          TO  SPA-GMN-CHOKICHK-G
                   MOVE    1              TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    15              TO  SPA-GMN-CUR
               MOVE    "0016"          TO  SPA-ERRCD
               GO      TO      4103-CHOKICHK-CHK-EXT
           END-IF
      *
          .
       4103-CHOKICHK-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    包括まとめ入力チェック処理
      *****************************************************************
       4103-HOUKATU-CHK-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               IF      SPA-GMN-HOUKATU
                                      =   SPA-GMN-HOUKATU-LIST(IDX)
                                                                (1:1)
                   MOVE    SPA-GMN-HOUKATU-LIST(IDX)
                                          TO  SPA-GMN-HOUKATU-G
                   MOVE    1              TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    16              TO  SPA-GMN-CUR
               MOVE    "0014"          TO  SPA-ERRCD
               GO      TO      4103-HOUKATU-CHK-EXT
           END-IF
      *
          .
       4103-HOUKATU-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    カルテの病名対象チェック処理
      *****************************************************************
       4104-BYOMEI-CHK-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               IF      SPA-GMN-BYOMEIKBN
                                      =   SPA-GMN-BYOMEIKBN-LIST(IDX)
                                                                (1:1)
                   MOVE    SPA-GMN-BYOMEIKBN-LIST(IDX)
                                          TO  SPA-GMN-BYOMEIKBN-G
                   MOVE    1              TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    20              TO  SPA-GMN-CUR
               MOVE    "0020"          TO  SPA-ERRCD
               GO      TO      4104-BYOMEI-CHK-EXT
           END-IF
      *
          .
       4104-BYOMEI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    人名辞書使用チェック処理
      *****************************************************************
       4105-JISYO-CHK-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               IF      SPA-GMN-JISYOKBN
                                      =   SPA-GMN-JISYOKBN-LIST(IDX)
                                                                (1:1)
                   MOVE    SPA-GMN-JISYOKBN-LIST(IDX)
                                          TO  SPA-GMN-JISYOKBN-G
                   MOVE    1              TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    21              TO  SPA-GMN-CUR
               MOVE    "0021"          TO  SPA-ERRCD
               GO      TO      4105-JISYO-CHK-EXT
           END-IF
      *
          .
       4105-JISYO-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者登録のカルテ発行チェック処理
      *****************************************************************
       4106-HAKKO-CHK-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               IF      SPA-GMN-HAKKOKBN
                                      =   SPA-GMN-HAKKOKBN-LIST(IDX)
                                                                (1:1)
                   MOVE    SPA-GMN-HAKKOKBN-LIST(IDX)
                                          TO  SPA-GMN-HAKKOKBN-G
                   MOVE    1              TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    22              TO  SPA-GMN-CUR
               MOVE    "0022"          TO  SPA-ERRCD
               GO      TO      4106-HAKKO-CHK-EXT
           END-IF
      *
          .
       4106-HAKKO-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自費保険の補助区分チェック処理
      *****************************************************************
       4107-HOJYO-CHK-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               IF      SPA-GMN-HOJYOKBN
                                       =   SPA-GMN-HOJYOKBN-LIST(IDX)
                                                                (1:1)
                   MOVE    SPA-GMN-HOJYOKBN-LIST(IDX)
                                          TO  SPA-GMN-HOJYOKBN-G
                   MOVE    1              TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    23              TO  SPA-GMN-CUR
               MOVE    "0023"          TO  SPA-ERRCD
               GO      TO      4107-HOJYO-CHK-EXT
           END-IF
      *
          .
       4107-HOJYO-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入金管理区分チェック処理（診療行為機能情報）
      *****************************************************************
       4108-SRYNYKNKNRKBN-CHK-SEC      SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-SRYNYKNKNRKBN-MAX
               IF      SPA-GMN-SRYNYKNKNRKBN
                                       =   SPA-GMN-SRYNYKNKNRKBNL (IDX)
                   MOVE    SPA-GMN-SRYNYKNKNRKBNLST(IDX)
                                          TO  SPA-GMN-SRYNYKNKNRKBN-G
                   MOVE    1              TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    30              TO  SPA-GMN-CUR
               MOVE    "0024"          TO  SPA-ERRCD
               GO      TO      4108-SRYNYKNKNRKBN-CHK-EXT
           END-IF
      *
           .
       4108-SRYNYKNKNRKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入金管理区分チェック処理（収納行為機能情報）
      *****************************************************************
       4109-SYUNYKNKNRKBN-CHK-SEC      SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-SYUNYKNKNRKBN-MAX
               IF      SPA-GMN-SYUNYKNKNRKBN
                                       =   SPA-GMN-SYUNYKNKNRKBNL (IDX)
                   MOVE    SPA-GMN-SYUNYKNKNRKBNLST(IDX)
                                          TO  SPA-GMN-SYUNYKNKNRKBN-G
                   MOVE    1              TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    40              TO  SPA-GMN-CUR
               MOVE    "0025"          TO  SPA-ERRCD
               GO      TO      4109-SYUNYKNKNRKBN-CHK-EXT
           END-IF
      *
           .
       4109-SYUNYKNKNRKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    請求書兼領収書発行区分チェック処理（収納行為機能情報）
      *****************************************************************
       4110-SYUSKYPRTKBN-CHK-SEC      SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-SYUSKYPRTKBN-MAX
               IF      SPA-GMN-SYUSKYPRTKBN
                                       =   SPA-GMN-SYUSKYPRTKBNL (IDX)
                   MOVE    SPA-GMN-SYUSKYPRTKBNLST(IDX)
                                          TO  SPA-GMN-SYUSKYPRTKBN-G
                   MOVE    1              TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    41              TO  SPA-GMN-CUR
               MOVE    "0026"          TO  SPA-ERRCD
               GO      TO      4110-SYUSKYPRTKBN-CHK-EXT
           END-IF
      *
           .
       4110-SYUSKYPRTKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自費保険の補助区分チェック処理
      *****************************************************************
       4112-SEIHO-JKYSNUM-CHK-SEC      SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               IF      SPA-GMN-SEIHO-JKYSNUM
                                   =   SPA-GMN-SEIHO-JKYSNUM-LIST(IDX)
                                                                (1:1)
                   MOVE    SPA-GMN-SEIHO-JKYSNUM-LIST(IDX)
                                          TO  SPA-GMN-SEIHO-JKYSNUM-G
                   MOVE    1              TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    24              TO  SPA-GMN-CUR
               MOVE    "0027"          TO  SPA-ERRCD
               GO      TO      4112-SEIHO-JKYSNUM-CHK-EXT
           END-IF
      *
          .
       4112-SEIHO-JKYSNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "W01"           TO  SPA-SAKIPG
           MOVE    "W07"           TO  SPA-MOTOPG
      *
           INITIALIZE                  SPA-W01KYOUTU
      *
      ***  MOVE   "CHANGE"         TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG      TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1               TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除確認画面表示処理
      *****************************************************************
       403-DEL-SEC                 SECTION.
      *
           EVALUATE    SPA-W01-KANRICD
               WHEN    "1007"
                   MOVE    "1002"              TO  SPA-WIDCD
               WHEN    "1017"
                   MOVE    "1004"              TO  SPA-WIDCD
               WHEN    "1038"
                   MOVE    "1006"              TO  SPA-WIDCD
               WHEN    "1039"
                   MOVE    "1008"              TO  SPA-WIDCD
           END-EVALUATE
      *
           .    
       403-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除処理１００７
      *****************************************************************
       4032-DEL-1007-SEC           SECTION.
      *
           MOVE    SPACE               TO  SYS-1007-REC
           INITIALIZE                      SYS-1007-REC
           MOVE    "1007"              TO  SYS-1007-KANRICD
           MOVE    "*"                 TO  SYS-1007-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  SYS-1007-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD    TO  SYS-1007-EDYUKYMD
           MOVE    SYS-1007-REC        TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1002"              TO  SPA-ERRCD
               DISPLAY "SYSKANRI-KEY =>" SYS-1007-KEY 
                       ",MCP-RC:" MCP-RC 
               GO  TO  4032-DEL-1007-EXT
           END-IF
      *
      *     MOVE   "JOIN"               TO  MCP-PUTTYPE
      *     PERFORM 210-BACK
           .
       4032-DEL-1007-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除処理１００８
      *****************************************************************
       4032-DEL-1008-SEC           SECTION.
      *
           MOVE    SPACE               TO  SYS-1008-REC
           INITIALIZE                      SYS-1008-REC
           MOVE    "1008"              TO  SYS-1008-KANRICD
           MOVE    "*"                 TO  SYS-1008-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  SYS-1008-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD    TO  SYS-1008-EDYUKYMD
           MOVE    SYS-1008-REC        TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1002"              TO  SPA-ERRCD
               DISPLAY "SYSKANRI-KEY =>" SYS-1008-KEY 
                       ",MCP-RC:" MCP-RC 
               GO  TO  4032-DEL-1008-EXT
           END-IF
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK
           .
       4032-DEL-1008-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除処理１０１７
      *****************************************************************
       4032-DEL-1017-SEC           SECTION.
      *
           MOVE    SPACE               TO  SYS-1017-REC
           INITIALIZE                      SYS-1017-REC
           MOVE    "1017"              TO  SYS-1017-KANRICD
           MOVE    "*"                 TO  SYS-1017-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  SYS-1017-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD    TO  SYS-1017-EDYUKYMD
           MOVE    SYS-1017-REC        TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1002"                  TO  SPA-ERRCD
               DISPLAY "SYSKANRI-KEY =>" SYS-1017-KEY
                       ",MCP-RC:" MCP-RC 
               GO  TO  4032-DEL-1017-EXT
           END-IF
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK
           .
       4032-DEL-1017-EXT.
           EXIT.
      *****************************************************************
      *    削除処理１０３８
      *****************************************************************
       4032-DEL-1038-SEC           SECTION.
      *
           MOVE    SPACE               TO  SYS-1038-REC
           INITIALIZE                      SYS-1038-REC
           MOVE    "1038"              TO  SYS-1038-KANRICD
           MOVE    "*"                 TO  SYS-1038-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  SYS-1038-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD    TO  SYS-1038-EDYUKYMD
           MOVE    SYS-1038-REC        TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1002"              TO  SPA-ERRCD
               DISPLAY "SYSKANRI-KEY =>" SYS-1038-KEY 
                       ",MCP-RC:" MCP-RC 
               GO  TO  4032-DEL-1038-EXT
           END-IF
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK
           .
       4032-DEL-1038-EXT.
           EXIT.
      *****************************************************************
      *    削除処理１０３９
      *****************************************************************
       4032-DEL-1039-SEC           SECTION.
      *
           MOVE    SPACE               TO  SYS-1039-REC
           INITIALIZE                      SYS-1039-REC
           MOVE    "1039"              TO  SYS-1039-KANRICD
           MOVE    "*"                 TO  SYS-1039-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  SYS-1039-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD    TO  SYS-1039-EDYUKYMD
           MOVE    SYS-1039-REC        TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1002"              TO  SPA-ERRCD
               DISPLAY "SYSKANRI-KEY =>" SYS-1039-KEY 
                       ",MCP-RC:" MCP-RC 
               GO  TO  4032-DEL-1039-EXT
           END-IF
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK
           .
       4032-DEL-1039-EXT.
           EXIT.
      *
      *****************************************************************
      *       登録前処理
      *****************************************************************
       490-TOUROKU-SEC             SECTION.
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      490-TOUROKU-EXT
           END-IF
      *
           EVALUATE    SPA-W01-KANRICD
               WHEN    "1007"
                   PERFORM 4900-KANRENCHK-SEC
                   IF      SPA-ERRCD        =   SPACE
                       MOVE    "1001"           TO  SPA-WIDCD
                   END-IF
               WHEN    "1017"
                   IF      SPA-ERRCD        =   SPACE
                       MOVE    "1003"           TO  SPA-WIDCD
                   END-IF
               WHEN    "1038"
                   IF      SPA-ERRCD        =   SPACE
                       MOVE    "1005"           TO  SPA-WIDCD
                   END-IF
               WHEN    "1039"
                   IF      SPA-ERRCD        =   SPACE
                       MOVE    "1007"           TO  SPA-WIDCD
                   END-IF
          END-EVALUATE
      *     
           .
       490-TOUROKU-EXT.
           EXIT.
      *
      ******************************************************************
      *       登録処理
      *****************************************************************
       491-KOUSHIN-1007-SEC        SECTION.
      *
           MOVE    SPACE               TO  SYS-1007-REC
           INITIALIZE                      SYS-1007-REC
           MOVE    "1007"              TO  SYS-1007-KANRICD
           MOVE    "*"                 TO  SYS-1007-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           MOVE    SYS-1007-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1007-REC
           ELSE
               MOVE    SPACE               TO  SYS-1007-REC
               INITIALIZE                      SYS-1007-REC
               MOVE    "1007"              TO  SYS-1007-KANRICD
               MOVE    "*"                 TO  SYS-1007-KBNCD
           END-IF
      *
           MOVE    SPA-W01-STYUKYMD        TO  SYS-1007-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD        TO  SYS-1007-EDYUKYMD
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
               MOVE    SPA-GMN-DATA (IDX)  TO  SYS-1007-SANTEI (IDX:1)
           END-PERFORM 
           MOVE    SYS-1007-REC            TO  SYSKANRI-REC
      *     
           IF      FLG-SYSKANRI            =   ZERO
      *
               PERFORM 800-MCNDATE-SEC
               MOVE    SMCNDATE-YMD            TO  SYS-UPYMD
               MOVE    SMCNDATE-HMS            TO  SYS-UPHMS
      *
               MOVE    SYS-KANRICD             TO  SYSUP-KANRICD
               MOVE    SYS-KBNCD               TO  SYSUP-KBNCD
               MOVE    SPA-W01-SEL-STYUKYMD    TO  SYSUP-STYUKYMD
               MOVE    SPA-W01-SEL-EDYUKYMD    TO  SYSUP-EDYUKYMD
               MOVE    "SYSKANRI-UPD1"         TO  ORC-DBPATH
               MOVE    "DBUPDATE"              TO  MCP-FUNC
           ELSE
      *
               PERFORM 800-MCNDATE-SEC
               MOVE    SMCNDATE-YMD            TO  SYS-CREYMD
                                                   SYS-UPYMD
               MOVE    SMCNDATE-HMS            TO  SYS-UPHMS
      *
               MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
               MOVE    "DBINSERT"              TO  MCP-FUNC
           END-IF
           MOVE    SYSKANRI-REC            TO  MCPDATA-REC
           CALL    "ORCMCPSUB"                 USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1003"                  TO  SPA-ERRCD
               DISPLAY "SYSKANRI-KEY =>" SYS-1017-KEY
                       ",MCP-RC:" MCP-RC 
               GO  TO  490-KOUSHIN-1007-EXT
           END-IF      
      *
      *     MOVE   "JOIN"               TO  MCP-PUTTYPE
      *     PERFORM 210-BACK 
           .
       490-KOUSHIN-1007-EXT.
           EXIT.
      *
      ******************************************************************
      *       登録処理
      *****************************************************************
       491-KOUSHIN-1008-SEC        SECTION.
      *
           MOVE    SPACE               TO  SYS-1008-REC
           INITIALIZE                      SYS-1008-REC
           MOVE    "1008"              TO  SYS-1008-KANRICD
           MOVE    "*"                 TO  SYS-1008-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           MOVE    SYS-1008-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1008-REC
           ELSE
               MOVE    SPACE               TO  SYS-1008-REC
               INITIALIZE                      SYS-1008-REC
               MOVE    "1008"              TO  SYS-1008-KANRICD
               MOVE    "*"                 TO  SYS-1008-KBNCD
           END-IF
      *
           MOVE    SPA-W01-STYUKYMD        TO  SYS-1008-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD        TO  SYS-1008-EDYUKYMD
           MOVE    SPA-GMN-INTERACT-KIKAN  TO  SYS-1008-INTERACT-KIKAN
           MOVE    SPA-GMN-GAIKANRIKBN-CHK TO  SYS-1008-GAIKANRIKBN-CHK
           MOVE    SPA-GMN-DATA(7)         TO  SYS-1008-IKUJIEIYO-FLG
           MOVE    SPA-GMN-SRYKACD         TO  SYS-1008-IKUJIEIYO-SRYKA
           MOVE    SPA-GMN-GAIMOVE         TO  SYS-1008-GAI-CURSOR-SET-1
      *    入院初診料自動発生
           MOVE    SPA-GMN-NYUSYOSIN       TO  SYS-1008-NYU-SYOSIN
      *    包括入力
           MOVE    SPA-GMN-HOUKATU         TO  SYS-1008-HOUKATU-FLG
      *    数量ゼロ入力
           MOVE    SPA-GMN-SURYOZERO       TO  SYS-1008-SURYOZERO-FLG
      *    入院調基チェック
           MOVE    SPA-GMN-CHOKICHK        TO  SYS-1008-CHOKICHK-FLG
      *
      *    時間外加算特例乳幼児
           MOVE    SPA-GMN-JIKANTOKU-NYU   TO
                                           SYS-1008-JIKANTOKU-NYU-FLG
      *    画像診断管理加算１（写真診断）
           MOVE    SPA-GMN-GAZOUKSN1       TO  SYS-1008-GAZOUKSN1-FLG
      *
           MOVE    SYS-1008-REC            TO  SYSKANRI-REC
      *     
           IF      FLG-SYSKANRI            =   ZERO
      *
               PERFORM 800-MCNDATE-SEC
               MOVE    SMCNDATE-YMD            TO  SYS-UPYMD
               MOVE    SMCNDATE-HMS            TO  SYS-UPHMS
      *
               MOVE    SYS-KANRICD             TO  SYSUP-KANRICD
               MOVE    SYS-KBNCD               TO  SYSUP-KBNCD
               MOVE    SPA-W01-SEL-STYUKYMD    TO  SYSUP-STYUKYMD
               MOVE    SPA-W01-SEL-EDYUKYMD    TO  SYSUP-EDYUKYMD
               MOVE    "SYSKANRI-UPD1"         TO  ORC-DBPATH
               MOVE    "DBUPDATE"              TO  MCP-FUNC
           ELSE
      *
               PERFORM 800-MCNDATE-SEC
               MOVE    SMCNDATE-YMD            TO  SYS-CREYMD
                                                   SYS-UPYMD
               MOVE    SMCNDATE-HMS            TO  SYS-UPHMS
      *
               MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
               MOVE    "DBINSERT"              TO  MCP-FUNC
           END-IF
           MOVE    SYSKANRI-REC            TO  MCPDATA-REC
           CALL    "ORCMCPSUB"                 USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1003"                  TO  SPA-ERRCD
               DISPLAY "W07 SYSKANRI-KEY =>" SYS-1008-KEY
                       ",MCP-RC:" MCP-RC 
               GO  TO  490-KOUSHIN-1008-EXT
           END-IF      
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK 
           .
       490-KOUSHIN-1008-EXT.
           EXIT.
      *
      ******************************************************************
      *       登録処理
      *****************************************************************
       491-KOUSHIN-1017-SEC        SECTION.
      *
           MOVE    SPACE               TO  SYS-1017-REC
           INITIALIZE                      SYS-1017-REC
           MOVE    "1017"              TO  SYS-1017-KANRICD
           MOVE    "*"                 TO  SYS-1017-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           MOVE    SYS-1017-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1017-REC
           ELSE
               MOVE    SPACE               TO  SYS-1017-REC
               INITIALIZE                      SYS-1017-REC
               MOVE    "1017"              TO  SYS-1017-KANRICD
               MOVE    "*"                 TO  SYS-1017-KBNCD
           END-IF
      *
           MOVE    SPA-W01-STYUKYMD        TO  SYS-1017-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD        TO  SYS-1017-EDYUKYMD
           MOVE    SPA-GMN-BYOMEIKBN       TO  SYS-1017-KARUTE-BYOMEI
           MOVE    SPA-GMN-JISYOKBN        TO  SYS-1017-JINMEI-USE
           MOVE    SPA-GMN-HAKKOKBN        TO  SYS-1017-KARUTE-HAKKO
           MOVE    SPA-GMN-HOJYOKBN        TO  SYS-1017-JIHIHKN-TAX
           MOVE    SPA-GMN-SEIHO-JKYSNUM   TO  SYS-1017-SEIHO-JKYSNUM
      *
           MOVE    SYS-1017-REC            TO  SYSKANRI-REC
      *
           IF      FLG-SYSKANRI            =   ZERO
      *
               PERFORM 800-MCNDATE-SEC
               MOVE    SMCNDATE-YMD            TO  SYS-UPYMD
               MOVE    SMCNDATE-HMS            TO  SYS-UPHMS
      *
               MOVE    SYS-KANRICD             TO  SYSUP-KANRICD
               MOVE    SYS-KBNCD               TO  SYSUP-KBNCD
               MOVE    SPA-W01-SEL-STYUKYMD    TO  SYSUP-STYUKYMD
               MOVE    SPA-W01-SEL-EDYUKYMD    TO  SYSUP-EDYUKYMD
               MOVE    "SYSKANRI-UPD1"         TO  ORC-DBPATH
               MOVE    "DBUPDATE"              TO  MCP-FUNC
           ELSE
      *
               PERFORM 800-MCNDATE-SEC
               MOVE    SMCNDATE-YMD            TO  SYS-CREYMD
                                                   SYS-UPYMD
               MOVE    SMCNDATE-HMS            TO  SYS-UPHMS
      *
               MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
               MOVE    "DBINSERT"              TO  MCP-FUNC
           END-IF
           MOVE    SYSKANRI-REC            TO  MCPDATA-REC
           CALL    "ORCMCPSUB"                 USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
           IF      MCP-RC              NOT =   ZERO
               MOVE    "1003"                  TO  SPA-ERRCD
               DISPLAY "W07 ERR:" MCP-RC
                        ",SYS-1017-KEY:" SYS-1017-KEY
                        ",MCP-FUNC:" MCP-FUNC
               GO  TO  490-KOUSHIN-1017-EXT
           END-IF
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK
           .
       490-KOUSHIN-1017-EXT.
           EXIT.
      *
      ******************************************************************
      *       登録処理
      *****************************************************************
       491-KOUSHIN-1038-SEC        SECTION.
      *
           MOVE    SPACE               TO  SYS-1038-REC
           INITIALIZE                      SYS-1038-REC
           MOVE    "1038"              TO  SYS-1038-KANRICD
           MOVE    "*"                 TO  SYS-1038-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           MOVE    SYS-1038-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1038-REC
           ELSE
               MOVE    SPACE               TO  SYS-1038-REC
               INITIALIZE                      SYS-1038-REC
               MOVE    "1038"              TO  SYS-1038-KANRICD
               MOVE    "*"                 TO  SYS-1038-KBNCD
           END-IF
      *
           MOVE    SPA-W01-STYUKYMD        TO  SYS-1038-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD        TO  SYS-1038-EDYUKYMD
           MOVE    SPA-GMN-SRYNYKNKNRKBN   TO  SYS-1038-NYKNKNRKBN
      *
           MOVE    SYS-1038-REC            TO  SYSKANRI-REC
      *
           IF      FLG-SYSKANRI            =   ZERO
      *
               PERFORM 800-MCNDATE-SEC
               MOVE    SMCNDATE-YMD            TO  SYS-UPYMD
               MOVE    SMCNDATE-HMS            TO  SYS-UPHMS
      *
               MOVE    SYS-KANRICD             TO  SYSUP-KANRICD
               MOVE    SYS-KBNCD               TO  SYSUP-KBNCD
               MOVE    SPA-W01-SEL-STYUKYMD    TO  SYSUP-STYUKYMD
               MOVE    SPA-W01-SEL-EDYUKYMD    TO  SYSUP-EDYUKYMD
               MOVE    "SYSKANRI-UPD1"         TO  ORC-DBPATH
               MOVE    "DBUPDATE"              TO  MCP-FUNC
           ELSE
      *
               PERFORM 800-MCNDATE-SEC
               MOVE    SMCNDATE-YMD            TO  SYS-CREYMD
                                                   SYS-UPYMD
               MOVE    SMCNDATE-HMS            TO  SYS-UPHMS
      *
               MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
               MOVE    "DBINSERT"              TO  MCP-FUNC
           END-IF
           MOVE    SYSKANRI-REC            TO  MCPDATA-REC
           CALL    "ORCMCPSUB"                 USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
           IF      MCP-RC              NOT =   ZERO
               MOVE    "1003"                  TO  SPA-ERRCD
               DISPLAY "W07 ERR:" MCP-RC
                        ",SYS-1038-KEY:" SYS-1038-KEY
                        ",MCP-FUNC:" MCP-FUNC
               GO  TO  490-KOUSHIN-1038-EXT
           END-IF
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK
           .
       490-KOUSHIN-1038-EXT.
           EXIT.
      ******************************************************************
      *       登録処理
      *****************************************************************
       491-KOUSHIN-1039-SEC        SECTION.
      *
           MOVE    SPACE               TO  SYS-1039-REC
           INITIALIZE                      SYS-1039-REC
           MOVE    "1039"              TO  SYS-1039-KANRICD
           MOVE    "*"                 TO  SYS-1039-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           MOVE    SYS-1039-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1039-REC
           ELSE
               MOVE    SPACE               TO  SYS-1039-REC
               INITIALIZE                      SYS-1039-REC
               MOVE    "1039"              TO  SYS-1039-KANRICD
               MOVE    "*"                 TO  SYS-1039-KBNCD
           END-IF
      *
           MOVE    SPA-W01-STYUKYMD        TO  SYS-1039-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD        TO  SYS-1039-EDYUKYMD
           MOVE    SPA-GMN-SYUNYKNKNRKBN   TO  SYS-1039-NYKNKNRKBN
      *    MOVE    SPA-GMN-SYUSKYPRTKBN    TO  SYS-1039-SKYPRTKBN
      *
           MOVE    SYS-1039-REC            TO  SYSKANRI-REC
      *
           IF      FLG-SYSKANRI            =   ZERO
      *
               PERFORM 800-MCNDATE-SEC
               MOVE    SMCNDATE-YMD            TO  SYS-UPYMD
               MOVE    SMCNDATE-HMS            TO  SYS-UPHMS
      *
               MOVE    SYS-KANRICD             TO  SYSUP-KANRICD
               MOVE    SYS-KBNCD               TO  SYSUP-KBNCD
               MOVE    SPA-W01-SEL-STYUKYMD    TO  SYSUP-STYUKYMD
               MOVE    SPA-W01-SEL-EDYUKYMD    TO  SYSUP-EDYUKYMD
               MOVE    "SYSKANRI-UPD1"         TO  ORC-DBPATH
               MOVE    "DBUPDATE"              TO  MCP-FUNC
           ELSE
      *
               PERFORM 800-MCNDATE-SEC
               MOVE    SMCNDATE-YMD            TO  SYS-CREYMD
                                                   SYS-UPYMD
               MOVE    SMCNDATE-HMS            TO  SYS-UPHMS
      *
               MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
               MOVE    "DBINSERT"              TO  MCP-FUNC
           END-IF
           MOVE    SYSKANRI-REC            TO  MCPDATA-REC
           CALL    "ORCMCPSUB"                 USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
           IF      MCP-RC              NOT =   ZERO
               MOVE    "1003"                  TO  SPA-ERRCD
               DISPLAY "W07 ERR:" MCP-RC
                        ",SYS-1039-KEY:" SYS-1039-KEY
                        ",MCP-FUNC:" MCP-FUNC
               GO  TO  490-KOUSHIN-1039-EXT
           END-IF
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK
           .
       490-KOUSHIN-1039-EXT.
           EXIT.
      *****************************************************************
      *       入力項目の関連チェック処理
      *****************************************************************
       4900-KANRENCHK-SEC           SECTION.
      *
           MOVE    SPACE                TO  SPA-ERRCD
           MOVE    SPA-GMN-CUR          TO  WRK-GMN-CUR
      *
           PERFORM 4100-DATA-CHK-SEC
      *
           IF      SPA-ERRCD            =   SPACE
               IF      SPA-GMN-DATA (3)     =   "1"
               AND     SPA-GMN-DATA (4)     =   "1"
                   MOVE    "0005"               TO  SPA-ERRCD
                   MOVE    4                    TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           IF      SPA-ERRCD            =   SPACE
               MOVE    WRK-GMN-CUR          TO  SPA-GMN-CUR
           END-IF
           .
       4900-KANRENCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
           PERFORM 510-GSRAUTH-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-WIDCD       NOT =   SPACE
               PERFORM 520-WIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "W07    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    SPACE           TO  W07
      *
           MOVE    SPA-GMN-STYUKYMD    TO  W07-YUKOSTYMD
           MOVE    SPA-GMN-EDYUKYMD    TO  W07-YUKOEDYMD
      *
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       7 
               MOVE    SPA-GMN-DATA-G(IDX)     TO  W07-DATA(IDX)
               PERFORM VARYING IDY     FROM    1   BY  1
                       UNTIL   IDY     >       2
                   MOVE    SPA-GMN-DATALST(IDY)
                                       TO  W07-DATALST(IDX IDY)
               END-PERFORM
               MOVE    SPA-GMN-DATA-MAX    TO  W07-COUNT(IDX)
           END-PERFORM
      *
           MOVE    SPA-GMN-SRYKACD     TO  W07-SRYKACD
           MOVE    SPA-GMN-SRYKAMEI    TO  W07-SRYKAMEI
      *    入院初診料
           MOVE    SPA-GMN-NYUSYOSIN-G TO  W07-NYUSYOSIN
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       2
               MOVE    SPA-GMN-DATALST(IDY)
                                       TO  W07-NYUSYOSIN-ITEM(IDY)
           END-PERFORM
           MOVE    SPA-GMN-DATA-MAX    TO  W07-NYUSYOSIN-COUNT
      *
      *    時間外加算特例乳幼児
           MOVE    SPA-GMN-JIKANTOKU-NYU-G TO  W07-JIKANTOKUNYU
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-DATA-MAX
               MOVE    SPA-GMN-DATALST(IDY)
                                       TO  W07-JIKANTOKUNYU-ITEM(IDY)
           END-PERFORM
           MOVE    SPA-GMN-DATA-MAX    TO  W07-JIKANTOKUNYU-COUNT
      *
      *    画像診断管理加算１（写真診断）
           MOVE    SPA-GMN-GAZOUKSN1-G TO  W07-GAZOUKSN1
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-DATA-MAX
               MOVE    SPA-GMN-DATALST(IDY)
                                       TO  W07-GAZOUKSN1-ITEM(IDY)
           END-PERFORM
           MOVE    SPA-GMN-DATA-MAX    TO  W07-GAZOUKSN1-COUNT
      *
           MOVE  SPA-GMN-INTERACT-KIKAN    TO  W07-KIKAN
      *    外来管理加算チェック
           MOVE    SPA-GMN-GAIKANRIKBN-G   TO  W07-GAIKANKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               MOVE    SPA-GMN-GAIKANRIKBN-LIST (IDX)
                                       TO  W07-GAIKANKBN-ITEM(IDX)
           END-PERFORM
           MOVE    3                   TO  W07-GAIKANKBN-COUNT
      *
      *    外来カーソル移動
           MOVE    SPA-GMN-GAIMOVE-G       TO  W07-GAIMOVE
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               MOVE    SPA-GMN-GAIMOVE-LIST (IDX)
                                       TO  W07-GAIMOVE-ITEM(IDX)
           END-PERFORM
           MOVE    3                   TO  W07-GAIMOVE-COUNT
      *
      *    数量ゼロ入力
           MOVE    SPA-GMN-SURYOZERO-G TO  W07-SURYOZERO
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               MOVE    SPA-GMN-SURYOZERO-LIST (IDX)
                                       TO  W07-SURYOZERO-ITEM(IDX)
           END-PERFORM
           MOVE    2                   TO  W07-SURYOZERO-COUNT
      *
      *    入院調基チェック
           MOVE    SPA-GMN-CHOKICHK-G  TO  W07-CHOKICHK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               MOVE    SPA-GMN-CHOKICHK-LIST (IDX)
                                       TO  W07-CHOKICHK-ITEM(IDX)
           END-PERFORM
           MOVE    2                   TO  W07-CHOKICHK-COUNT
      *
      *    包括入力
           MOVE    SPA-GMN-HOUKATU-G       TO  W07-HOUKATU
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               MOVE    SPA-GMN-HOUKATU-LIST (IDX)
                                       TO  W07-HOUKATU-ITEM(IDX)
           END-PERFORM
           MOVE    2                   TO  W07-HOUKATU-COUNT
      *
      *    カルテの病名対象
           MOVE    SPA-GMN-BYOMEIKBN-G     TO  W07-BYOMEIKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               MOVE    SPA-GMN-BYOMEIKBN-LIST (IDX)
                                       TO  W07-BYOMEIKBN-ITEM(IDX)
           END-PERFORM
           MOVE    2               TO  W07-BYOMEIKBN-COUNT
      *
      *    人名辞書使用
           MOVE    SPA-GMN-JISYOKBN-G      TO  W07-JISYOKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               MOVE    SPA-GMN-JISYOKBN-LIST (IDX)
                                       TO  W07-JISYOKBN-ITEM(IDX)
           END-PERFORM
           MOVE    2               TO  W07-JISYOKBN-COUNT
      *
      *    患者登録のカルテ発行
           MOVE    SPA-GMN-HAKKOKBN-G      TO  W07-HAKKOKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               MOVE    SPA-GMN-HAKKOKBN-LIST (IDX)
                                       TO  W07-HAKKOKBN-ITEM(IDX)
           END-PERFORM
           MOVE    3               TO  W07-HAKKOKBN-COUNT
      *
      *    自費保険の補助区分
           MOVE    SPA-GMN-HOJYOKBN-G      TO  W07-HOJYOKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               MOVE    SPA-GMN-HOJYOKBN-LIST (IDX)
                                       TO  W07-HOJYOKBN-ITEM(IDX)
           END-PERFORM
           MOVE    2               TO  W07-HOJYOKBN-COUNT
      *
      *    生活保護受給者番号
           MOVE    SPA-GMN-SEIHO-JKYSNUM-G     TO  W07-SEIHO-JKYSNUM
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               MOVE    SPA-GMN-SEIHO-JKYSNUM-LIST (IDX)
                                       TO  W07-SEIHO-JKYSNUM-ITEM(IDX)
           END-PERFORM
           MOVE    2               TO  W07-SEIHO-JKYSNUM-COUNT
      *
      *    入金管理区分（診療行為機能情報）
           MOVE    SPA-GMN-SRYNYKNKNRKBN-G TO  W07-SRYNYKNKNRKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-SRYNYKNKNRKBN-MAX
               MOVE    SPA-GMN-SRYNYKNKNRKBNLST (IDX)
                                       TO  W07-SRYNYKNKNRKBN-ITEM(IDX)
           END-PERFORM
           MOVE    SPA-GMN-SRYNYKNKNRKBN-MAX
                                       TO  W07-SRYNYKNKNRKBN-COUNT
      *
      *    入金管理区分（収納機能情報）
           MOVE    SPA-GMN-SYUNYKNKNRKBN-G TO  W07-SYUNYKNKNRKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-SYUNYKNKNRKBN-MAX
               MOVE    SPA-GMN-SYUNYKNKNRKBNLST (IDX)
                                       TO  W07-SYUNYKNKNRKBN-ITEM(IDX)
           END-PERFORM
           MOVE    SPA-GMN-SYUNYKNKNRKBN-MAX
                                       TO  W07-SYUNYKNKNRKBN-COUNT
      *
      *    請求書兼領収書発行区分
           MOVE    SPA-GMN-SYUSKYPRTKBN-G TO  W07-SYUSKYPRTKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-SYUSKYPRTKBN-MAX
               MOVE    SPA-GMN-SYUSKYPRTKBNLST (IDX)
                                       TO  W07-SYUSKYPRTKBN-ITEM(IDX)
           END-PERFORM
           MOVE    SPA-GMN-SYUSKYPRTKBN-MAX
                                       TO  W07-SYUSKYPRTKBN-COUNT
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    業務権限非活性処理
      *****************************************************************
       510-GSRAUTH-SEC             SECTION.
      *
           MOVE    WIDGET-INSENSITIVE  TO  W07-B03-STATE
                                           W07-TAGNAME1-STATE
                                           W07-TAGNAME2-STATE
                                           W07-TAGNAME3-STATE
                                           W07-TAGNAME4-STATE
                                           W07-SRYKACD-STATE
      *
           IF      SPA-W01-SELNUM          >   ZERO
               MOVE    WIDGET-NORMAL   TO  W07-B03-STATE
           END-IF 
      *
           EVALUATE    SPA-W01-KANRICD
               WHEN    "1007" 
                   MOVE    WIDGET-NORMAL   TO  W07-TAGNAME1-STATE
               WHEN    "1017" 
                   MOVE    WIDGET-NORMAL   TO  W07-TAGNAME2-STATE
               WHEN    "1038" 
                   MOVE    WIDGET-NORMAL   TO  W07-TAGNAME3-STATE
               WHEN    "1039" 
                   MOVE    WIDGET-NORMAL   TO  W07-TAGNAME4-STATE
           END-EVALUATE
      *
           IF      SPA-GMN-DATA(7)         =   "1"
               MOVE    WIDGET-NORMAL   TO  W07-SRYKACD-STATE
           END-IF
           .
       51O-GSRAUTH-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    SPACE           TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "調剤技術基本料入力エラー"  TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "薬剤情報提供料（一般）入力エラー"
                                                       TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE
                      "薬剤情報提供料（老人手帳記載あり）入力エラー"
                                                       TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE
                       "薬剤情報提供料（老人手帳記載なし）入力エラー"
                                                       TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE
                 "薬剤情報提供料（老人手帳記載）は両方の選択できません"
                                                       TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "外来管理加算チェック区分がありません。"
                                                       TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE
                       "療養担当手当（北海道）入力エラー"
                                                       TO  SPA-ERRMSG
               WHEN    "0009"
                   MOVE
                       "特定薬剤治療管理料入力エラー"  TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE
                       "育児栄養加算自動算定入力エラー"
                                                       TO  SPA-ERRMSG
               WHEN    "0011"
                   MOVE    "自動算定科がありません。"  TO  SPA-ERRMSG
               WHEN    "0012"
                   MOVE    "外来カーソル移動区分がありません。"
                                                       TO  SPA-ERRMSG
               WHEN    "0013"
                   MOVE    "入院初診料入力エラー"
                                                       TO  SPA-ERRMSG
               WHEN    "0014"
                   MOVE    "包括登録入力エラー"
                                                       TO  SPA-ERRMSG
               WHEN    "0015"
                   MOVE    "数量ゼロ入力エラー"
                                                       TO  SPA-ERRMSG
               WHEN    "0016"
                   MOVE    "入院調剤技術基本料チェックエラー"
                                                       TO  SPA-ERRMSG
               WHEN    "0017"
                   MOVE    "時間外加算特例乳幼児チェックエラー"
                                                       TO  SPA-ERRMSG
               WHEN    "0018"
                   MOVE    "画像診断管理加算１（写真診断）"
                                                       TO  SPA-ERRMSG
                   MOVE    "チェックエラー"
                                                   TO  SPA-ERRMSG(33:)
      *
               WHEN    "0020"
                   MOVE    "カルテの病名対象区分がありません。"
                                                       TO  SPA-ERRMSG
               WHEN    "0021"
                   MOVE    "人名辞書使用区分がありません。"
                                                       TO  SPA-ERRMSG
               WHEN    "0022"
                   MOVE    "患者登録のカルテ発行区分がありません。"
                                                       TO  SPA-ERRMSG
               WHEN    "0023"
                   MOVE    "自費保険の補助区分がありません。"
                                                       TO  SPA-ERRMSG
               WHEN    "0024"
                   MOVE    "入金管理区分がありません。"
                                                       TO  SPA-ERRMSG
               WHEN    "0025"
                   MOVE    "入金管理区分がありません。"
                                                       TO  SPA-ERRMSG
               WHEN    "0026"
                   MOVE    "請求書兼領収書発行区分がありません。"
                                                       TO  SPA-ERRMSG
               WHEN    "0027"
                   MOVE    "生活受給者番号がありません。"
                                                       TO  SPA-ERRMSG
               WHEN    "0099"
                   MOVE    "未入力の項目があります"    TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "更新ができませんでした"    TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "削除ができませんでした"    TO  SPA-ERRMSG
               WHEN    "1003"
                   MOVE    "更新ができませんでした"    TO  SPA-ERRMSG
               WHEN    OTHER
                   MOVE    SPA-ERRCD       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE           TO  WERR
           MOVE    SPA-ERRCD       TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG      TO  WERR-ERRMSG
           MOVE    "B01"           TO  MCP-WIDGET
      *
           MOVE    "W07"           TO  SPA-MOTOPG
           MOVE    "WERR"          TO  SPA-SAKIPG
      *
           MOVE    "NEW"           TO  MCP-PUTTYPE
           MOVE    "WERR"          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1               TO  FLG-END
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ガイドメッセージ表示
      *****************************************************************
       520-WIDSET-SEC              SECTION.
      *
           MOVE    SPACE           TO  WRK-WIDMSG
      *
           EVALUATE    SPA-WIDCD
               WHEN    "1001"
                   MOVE    "自動算定・チェック機能制御情報を登録します"
                                                       TO  WRK-WIDMSG
               WHEN    "1002"
                   MOVE    "自動算定・チェック機能制御情報を削除します"
                                                       TO  WRK-WIDMSG
               WHEN    "1003"
                   MOVE    "患者登録機能情報を登録します"
                                                       TO  WRK-WIDMSG
               WHEN    "1004"
                   MOVE    "患者登録機能情報を削除します"
                                                       TO  WRK-WIDMSG
               WHEN    "1005"
                   MOVE    "診療行為機能情報を登録します"
                                                       TO  WRK-WIDMSG
               WHEN    "1006"
                   MOVE    "診療行為機能情報を削除します"
                                                       TO  WRK-WIDMSG
               WHEN    "1007"
                   MOVE    "収納機能情報を登録します"
                                                       TO  WRK-WIDMSG
               WHEN    "1008"
                   MOVE    "収納機能情報を削除します"
                                                       TO  WRK-WIDMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  WID1
           MOVE    SPA-WIDCD           TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG          TO  WID1-ID1MSG
           MOVE    "B12"               TO  MCP-WIDGET
      *
           MOVE    "W07"               TO  SPA-MOTOPG
           MOVE    "WID1"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "WID1"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       520-WIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理    
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
           IF      SPA-GMN-CUR     =   ZERO
               PERFORM 50011-CUR-SET-SEC
           END-IF
      *
           EVALUATE    SPA-GMN-CUR
               WHEN    2
                   MOVE  "DATA01"          TO   MCP-WIDGET
               WHEN    3
                   MOVE  "DATA02"          TO   MCP-WIDGET
               WHEN    4
                   MOVE  "DATA03"          TO   MCP-WIDGET
               WHEN    5
                   MOVE  "DATA04"          TO   MCP-WIDGET
               WHEN    6
                   MOVE  "DATA05"          TO   MCP-WIDGET
               WHEN    7
                   MOVE  "DATA06"          TO   MCP-WIDGET
               WHEN    8
                   MOVE  "DATA07"          TO   MCP-WIDGET
               WHEN    9
                   MOVE  "SRYKACD"         TO   MCP-WIDGET
               WHEN    13
                   MOVE  "NYUSYOSIN"       TO   MCP-WIDGET
               WHEN    10
                   MOVE  "KIKAN"           TO   MCP-WIDGET
               WHEN    11
                   MOVE  "GAIKANKBN"       TO   MCP-WIDGET
               WHEN    12
                   MOVE  "GAIMOVE"         TO   MCP-WIDGET
               WHEN    14
                   MOVE  "SURYOZERO"       TO   MCP-WIDGET
               WHEN    15
                   MOVE  "CHOKICHK"        TO   MCP-WIDGET
               WHEN    16
                   MOVE  "HOUKATU"         TO   MCP-WIDGET
               WHEN    17
                   MOVE  "JIKANTOKUNYU"    TO   MCP-WIDGET
               WHEN    18
                   MOVE  "GAZOUKSN1"       TO   MCP-WIDGET
      *
               WHEN    20
                   MOVE  "BYOMEIKBN"       TO   MCP-WIDGET
               WHEN    21
                   MOVE  "JISYOKBN"        TO   MCP-WIDGET
               WHEN    22
                   MOVE  "HAKKOKBN"        TO   MCP-WIDGET
               WHEN    23
                   MOVE  "HOJYOKBN"        TO   MCP-WIDGET
               WHEN    24
                   MOVE  "SEIHO_JKYSNUM"   TO   MCP-WIDGET
               WHEN    30
                   MOVE  "SRYNYKNKNRKBN"   TO   MCP-WIDGET
               WHEN    40
                   MOVE  "SYUNYKNKNRKBN"   TO   MCP-WIDGET
               WHEN    41
                   MOVE  "SYUSKYPRTKBN"    TO   MCP-WIDGET
      *
               WHEN    99
                   MOVE  "B12"             TO   MCP-WIDGET
           END-EVALUATE
      *
           EVALUATE    SPA-GMN-CUR
               WHEN    2   THRU    13
                   MOVE    0               TO  W07-PAGENO
               WHEN    20  THRU    23
                   MOVE    1               TO  W07-PAGENO
               WHEN    30  THRU    30
                   MOVE    2               TO  W07-PAGENO
               WHEN    40  THRU    41
                   MOVE    3               TO  W07-PAGENO
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソル編集処理
      *****************************************************************
       50011-CUR-SET-SEC           SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
               WHEN    "DATA01"
                   MOVE    3               TO  SPA-GMN-CUR
               WHEN    "DATA02"
                   MOVE    4               TO  SPA-GMN-CUR
               WHEN    "DATA03"
                   MOVE    5               TO  SPA-GMN-CUR
               WHEN    "DATA04"
                   MOVE    6               TO  SPA-GMN-CUR
               WHEN    "DATA05"
                   MOVE    7               TO  SPA-GMN-CUR
               WHEN    "DATA06"
                   MOVE    8               TO  SPA-GMN-CUR
               WHEN    "DATA07"
                   IF      SPA-GMN-DATA(7)     =   "1"
                       MOVE    9           TO  SPA-GMN-CUR
                   ELSE
                       MOVE    13          TO  SPA-GMN-CUR
                   END-IF
               WHEN    "SRYKACD"
                   MOVE    13              TO  SPA-GMN-CUR
               WHEN    "NYUSYOSIN"
                   MOVE    17              TO  SPA-GMN-CUR
               WHEN    "JIKANTOKUNYU"
                   MOVE    18              TO  SPA-GMN-CUR
               WHEN    "GAZOUKSN1"
                   MOVE    10              TO  SPA-GMN-CUR
      *
               WHEN    "KIKAN"
                   MOVE    11              TO  SPA-GMN-CUR
               WHEN    "GAIKANKBN"
                   MOVE    12              TO  SPA-GMN-CUR
               WHEN    "GAIMOVE"
                   MOVE    14              TO  SPA-GMN-CUR
               WHEN    "SURYOZERO"
                   MOVE    15              TO  SPA-GMN-CUR
               WHEN    "CHOKICHK"
                   MOVE    16              TO  SPA-GMN-CUR
               WHEN    "HOUKATU"
                   MOVE    99              TO  SPA-GMN-CUR
      *        患者登録情報
               WHEN    "BYOMEIKBN"
                   MOVE    21              TO  SPA-GMN-CUR
               WHEN    "JISYOKBN"
                   MOVE    22              TO  SPA-GMN-CUR
               WHEN    "HAKKOKBN"
                   MOVE    23              TO  SPA-GMN-CUR
               WHEN    "HOJYOKBN"
                   MOVE    24              TO  SPA-GMN-CUR
               WHEN    "SEIHO_JKYSNUM"
                   MOVE    99              TO  SPA-GMN-CUR
               WHEN    "SRYNYKNKNRKBN"
                   MOVE    99              TO  SPA-GMN-CUR
               WHEN    "SYUNYKNKNRKBN"
      *            MOVE    41              TO  SPA-GMN-CUR
                   MOVE    99              TO  SPA-GMN-CUR
      *        WHEN    "SYUSKYPRTKBN"
      *            MOVE    99              TO  SPA-GMN-CUR
           END-EVALUATE
      *
           .
       50011-CUR-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC         SECTION.
      *
           IF      WRK-YMD  (1:7)  NOT NUMERIC
               INSPECT     WRK-YMD      REPLACING   ALL " " BY  "0"
               MOVE    WRK-YMD(1:1)     TO  WRK-WGO
               MOVE    WRK-YMD(2:2)     TO  WRK-WYY
               MOVE    WRK-YMD(5:2)     TO  WRK-WMM
               MOVE    WRK-YMD(8:2)     TO  WRK-WDD
           ELSE
               MOVE    WRK-YMD(1:7)     TO  WRK-WYMD
           END-IF
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY1-AREA
           MOVE    "12"                TO  LNK-DAY1-IRAI
           MOVE    ZERO                TO  LNK-DAY1-YMD
           MOVE    WRK-WYMD            TO  LNK-DAY1-YMD(2:7)
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY1-AREA
           IF      STS-DAY-RC1     NOT =   ZERO
               MOVE    "0001"          TO  SPA-ERRCD
           ELSE
               MOVE    LNK-DAY1-YMD        TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
           END-IF
           .
       5002-HIZUKE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    和暦西暦変換編集処理
      *****************************************************************
       5002-HIZUKE-HEN-SEC          SECTION.
      *
           IF      WRK-SYMD            =   ALL "9"  OR   SPACE
               MOVE    SPACE               TO  WRK-HGO
               MOVE    WRK-SYMD(3:2)       TO  WRK-HYY
               MOVE    WRK-SYMD(5:2)       TO  WRK-HMM
               MOVE    WRK-SYMD(7:2)       TO  WRK-HDD
               MOVE    WRK-HENYMD          TO  WRK-HENYMDG
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
           END-IF
      *
           .
       5002-HIZUKE-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    マシン日付取得サブ
      *****************************************************************
       800-MCNDATE-SEC         SECTION.
      *
           CALL    "ORCSMCNDATE"   USING   ORCSMCNDATEAREA
      *
           .
      *
       800-MCNDATE-EXT.
           EXIT.
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-SYSKANRI-INV-SEC        SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO            TO  FLG-SYSKANRI
               ELSE
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-SYSKANRI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"      TO  MCP-FUNC.
           CALL   "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
