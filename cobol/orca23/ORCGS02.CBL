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
       PROGRAM-ID.                 ORCGS02.
      **************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 収納登録
      *  コンポーネント名  : 請求一覧（S02）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−小豆沢   新規作成 
      **************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC−小豆沢  01/04/18  伝票発行日の修正
      *  01.00.02    MCC−小豆沢  01/04/18  再計算処理時の引き渡しパラメタ
      *                                     作成時に自動算定区分の判定を
      *                                     追加
      *  01.00.03    MCC−小豆沢  01/04/18  薬剤料逓減入力時の再計算修正
      *  01.00.04    MCC−小豆沢  01/04/18  診療行為テーブル読み込み条件
      *                                     を修正
      *  01.00.05    MCC−小豆沢  01/06/05  再計算処理時の引き渡しパラメタ
      *                                     作成時に診療種別区分の判定を
      *                                     追加
      *  01.00.06    MCC−小豆沢  01/06/05  再計算処理時の引き渡しパラメタ
      *                                     作成時に診療行為コードの判定を
      *                                     追加（薬剤であることの判定）
      *  01.00.07    MCC−小豆沢  01/07/12  保険適用外金額対応
      *                                     診療種別区分　.950　消費税なし
      *                                                   .960　消費税あり
      *  01.00.07    MCC−小豆沢  01/07/16  ＪＤ入金の削除 
      *                                     調整金のボタン中止      
      *  01.00.08    MCC−多々納  01/08/23  診療行為よりの遷移を追加
      *  01.00.09    MCC−小豆沢  01/09/19  コラムリストの選択追加
      *  01.01.01    MCC-藤原     01/11/07  患者番号、診療科、請求年月を
      *                                     入力項目に変更
      *                                     S01の削除
      *  01.01.01    MCC-多々納   01/12/12  画面遷移の修正
      *  01.01.03    MCC-小豆沢   01/12/13  再計算時の薬剤判定の修正
      *  01.01.04    MCC-多々納   02/01/31  選択番号の表示修正
      *  01.01.05    MCC-小豆沢   02/03/19  請求書再発行時に請求額と入金額
      *                                     のセット
      *  01.01.06    MCC-多々納   02/04/25  自費の判定に’０９６’を追加
      *  01.01.07    MCC-小豆沢   02/05/30  労災保険対応を追加
      *  01.01.08    MCC-多々納   02/06/05  患者氏名での検索を追加
      *  01.01.09    MCC-多々納   02/07/19  患者検索エラーメッセージ修正
      *  01.01.10    NACL-多々納  02/09/02  請求書をカスタマイズに修正
      *  01.01.11    NACL-小豆沢  02/09/12  自費の再計算時に薬剤、器材の
      *                                     集計を追加
      *  01.01.12    NACL-門脇    02/09/17  自賠責対応
      *  01.01.13    NACL-多々納  02/09/18  保険表示修正
      *  01.01.14    NACL-藤原    02/11/05  入外区分追加
      *  01.01.15    NACL-門脇    02.11.21  自賠責（ポリネック等の対応）
      *  01.01.16    NACL-太田    02.12.11  診療科・入外区分を判断して
      *                                     初期表示するよう修正
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
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
       01  SPA-S02.
      *
           03  SPA-S02-AREA.
               05  SPA-GMN-PAGE                  PIC 9(02).
               05  SPA-GMN-MAX                   PIC 9(04).
               05  SPA-GMN-CUR                   PIC 9(02).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-SRYKALST        OCCURS  99.
                       09  SPA-GMN-SRYKAL      PIC X(02).
                       09  SPA-GMN-F1L         PIC X(01).
                       09  SPA-GMN-SRYKAMEIL   PIC X(16).
                   07  SPA-GMN-SRYKA-MAX       PIC 9(02).
                   07  SPA-GMN-NYUGAIKBNLST    OCCURS  3.
                       11  SPA-GMN-NYUGAIKBNL  PIC X(01).
                       11  SPA-GMN-F1L         PIC X(01).
                       11  SPA-GMN-NYUGAIKBNMEIL
                                               PIC X(06).    
                   07  SPA-GMN-NYUGAIKBN-MAX   PIC 9(02).
                   07  SPA-GMN-SRYYM           PIC X(07).
                   07  SPA-GMN-HEAD.    
                       09  SPA-GMN-PTID        PIC 9(10).
                       09  SPA-GMN-PTNUM       PIC X(20).
                       09  SPA-GMN-KANANAME    PIC X(100).
                       09  SPA-GMN-SEX         PIC X(02).
                       09  SPA-GMN-NAME        PIC X(100).
                       09  SPA-GMN-BIRTHDAY    PIC X(09).
      *************    09  SPA-GMN-SRYKA       PIC X(16).
                       09  SPA-GMN-SRYKA-G.
                           11  SPA-GMN-SRYKA   PIC X(02).
                           11  SPA-GMN-F1      PIC X(01).
                           11  SPA-GMN-SRYKAMEI
                                               PIC X(16).
                       09  SPA-GMN-NYUGAIKBN-G.
                           11  SPA-GMN-NYUGAIKBN
                                               PIC X(01).
                           11  SPA-GMN-F1      PIC X(01).
                           11  SPA-GMN-NYUGAIKBNMEI
                                               PIC X(06).
      *
                   07  SPA-GMN-TBL.
                       09  SPA-GMN-TBLREC  OCCURS   60.
                           11  SPA-GMN-TBANGO      PIC 9(03).
                           11  SPA-GMN-TDENPNUM    PIC 9(07).
                           11  SPA-GMN-TNYUGAIKBN  PIC X(04).
      ******************** 11  SPA-GMN-TSRYKA      PIC X(02).
      ******************** 11  SPA-GMN-TSRYKAMEI   PIC X(10).
                           11  SPA-GMN-THKNCOMBI   PIC X(36).
                           11  SPA-GMN-TFTNRATE    PIC X(08).
                           11  SPA-GMN-TSRYYMD     PIC X(15).
                           11  SPA-GMN-TSKYEDYMD   PIC X(06).
                           11  SPA-GMN-THAKYMD     PIC X(09).
                           11  SPA-GMN-TSEIKYU     PIC 9(10).
                           11  SPA-GMN-TMISYU      PIC S9(10).
                           11  SPA-GMN-TJYOTAI     PIC X(10).
      *
                   07  SPA-GMN-INPUT.
                       09  SPA-GMN-SELBAN          PIC 9(05).
      *
               05  SPA-NAI-AREA.
                   07  SPA-NAI-SRYYM               PIC X(06).
                   07  SPA-NAI-TBL.
                       09  SPA-NAI-TBLREC  OCCURS  60.
                           11  SPA-NAI-SRYYMD      PIC  X(08).
                           11  SPA-NAI-HAKYMD      PIC  X(08).
                           11  SPA-NAI-SKYEDYMD    PIC  X(08).
                           11  SPA-NAI-TNYUGAIKBN  PIC  X(01).
      *                         
                   07  SPA-NAI-SELNO               PIC 9(03).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-SYUNOU          PIC X(02).
           03  STS-SYUMEI          PIC X(02).
           03  STS-SINKOU          PIC X(02).
           03  STS-SINKAI          PIC X(02).
           03  STS-HKNMST          PIC X(02).
           03  STS-HKNKUMI         PIC X(02).
           03  STS-KANRIMST        PIC X(02).
           03  STS-PARA            PIC X(02).
           03  STS-S02-KEY         PIC X(02).
           03  STS-ERRMSG-KEY      PIC X(02).
           03  STS-RTNCD9          PIC X(02).
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYUNOU          PIC 9(01).
           03  FLG-SYUMEI          PIC 9(01).
           03  FLG-SINKOU          PIC 9(01).
           03  FLG-SINKAI          PIC 9(01).
           03  FLG-HKNMST          PIC 9(01).
           03  FLG-HKNKUMI         PIC 9(01).
           03  FLG-PARA            PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-JYURRK          PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-PTRSIINF        PIC 9(01).
      *
           03  FLG-SYORI           PIC 9(01).
      *
           03  FLG-ERR             PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
           03  CNT-ENT             PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  WRK-MAP-INDEX PIC 9(02). 
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDG                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDX3                PIC 9(04).
           03  IDX4                PIC 9(04).
           03  IDX5                PIC 9(04).
           03  IDX6                PIC 9(04).
           03  IDX7                PIC 9(04).
           03  IDX8                PIC 9(04).
           03  IDX9                PIC 9(04).
           03  IDX10               PIC 9(04).
           03  IDX11               PIC 9(04).
           03  IDX12               PIC 9(04).
           03  IDX13               PIC 9(04).
           03  IDX14               PIC 9(04).
           03  IDXA                PIC 9(04).                           010112
           03  SAI-IDX             PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SELNO           PIC 9(03). 
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-SAIKEISAN-YMD.
               05  WRK-SAIKEISAN-YY PIC 9(04).
               05  WRK-SAIKEISAN-MM PIC 9(02).
               05  WRK-SAIKEISAN-DD PIC 9(02).
      *----(01.00.03) LINE ADD START -------------------------------
           03  WRK-TYK-HKNTEN       PIC S9(07).
      *----(01.00.03) LINE ADD END   -------------------------------
      *
      *    保険組合せ名称
           03  WRK-KUMINO          PIC X(04).
           03  WRK-HKNKUMI         PIC X(40).
           03  WRK-HKNKBN-MEI      PIC X(04).
      *
           03  WRK-ZAIKAISU        PIC 9(07).
      *
           03  WRK-MAE-SEIKYUGK    PIC 9(07).
           03  WRK-ATO-SEIKYUGK    PIC 9(07).
      *
      *    診療行為名称
           03  WRK-SRYSYUMEI       PIC X(40).
           03  WRK-TEKEDYMD        PIC X(08).
      *
           03  WRK-SYORINO         PIC X(02).
      *
           03  WRK-ERRMSG          PIC X(40).
      *
           03  WRK-MOTOPG          PIC X(08).
      *
           03  WRK-SAGAKU          PIC S9(07).
      *     
           03  WRK-TBANGO-W        PIC ZZZ.
           03  WRK-TSEIKYU-W       PIC ZZZZZZZZZZ.
           03  WRK-TMISYU-W        PIC ----------.
           03  WRK-SELBAN-W        PIC ZZZZ.  
      *    請求書ＰＧ名
           03  WRK-SEIKYU-PG           PIC X(20).
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
           03  WRK-HENYMDG         PIC X(09).
      *
       01  WK-GMN-RITU.
           03  WK-GMN-FTNRITU      PIC ZZZ.
           03  WK-GMN-PA           PIC X(01).
           03  FILLER              PIC X(01).
      *
      *    再計算時の剤番号退避用テーブル
       01  ZAIBAN-TABLE.
           03  ZAIBAN-TBL          OCCURS 100.
               05  TBL-SRYKBN      PIC  X(02).
               05  TBL-ZAIBAN      PIC  9(08).
               05  TBL-ZAIKAISU    PIC  9(07).
      *----(01.00.03) LINE MOD START -------------------------------
      *        05  TBL-ZAITEN      PIC  9(08).
               05  TBL-ZAITEN      PIC  S9(08).
               05  TBL-SYUTEN      PIC  9(08).                          010112
      *----(01.00.03) LINE MOD END   -------------------------------
      *
      *----(01.00.07) LINE ADD START -------------------------------
      *    再計算時の保険適用外金額退避用テーブル
       01  HKNTEKGAI-TABLE.
           03  HKNTEKGAI-TBL       OCCURS 11.
               05  TBL-TGMONEY     PIC  9(08).
               05  TBL-TGMONEY-TAX PIC  9(08).
       01  JIHI-TABLE.
           03  JIHI-TBL            OCCURS 5.
               05  TBL-JIHI-TAXNASI     PIC  9(08).
               05  TBL-JIHI-TAXARI      PIC  9(08).
      *----(01.00.07) LINE ADD END   -------------------------------
      *
       01  WK-DENPNUM-TABLE.
           03  DENPNUM-TBL          OCCURS 100.
               05  WK-DENPNUM      PIC  X(07).
               05  WK-IDX          PIC  9(07).
      *
       01  RSI-TABLE.
           03  WK-RSISHOSHIN-TENSU PIC  9(08).
           03  WK-RSISAISHIN-TENSU PIC  9(08).
           03  WK-RSISDO-TENSU     PIC  9(08).
           03  WK-RSIETC-TENSU     PIC  9(08).
      *
           03  WK-RSISHOSHIN       PIC  9(08).                          010112
           03  WK-RSISAISHIN       PIC  9(08).                          010112
           03  WK-RSISDO           PIC  9(08).                          010112
           03  WK-RSIETC           PIC  9(08).                          010112
      *
           03  WK-SYUTEN-KEI       PIC  9(08).                          010112
           03  WRK-TEN             PIC  9(08).                          010112
      *     
      *    スパ領域 ワーク
           COPY "COMMON-SPA"       REPLACING //SPA-//
                                   BY        //WRK-SPA-//.
      * 
      **************************************************************
      *    ファイルレイアウト
      **************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1005.INC".
      *
           COPY    "CPSK1010.INC".
      *    帳票ＰＧ
           COPY    "CPSK1032.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *    患者番号変換
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *    診療行為マスタ−
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    患者コメント
       01  PTCOM-REC.
           COPY    "CPPTCOM.INC".
      *
      *    診療会計マスタ−
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    収納マスター
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *    収納明細マスター
       01  SYUMEI-REC.
           COPY    "CPSYUMEI.INC".
      *    収納明細マスター
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *    受診履歴マスター
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *    点数
           COPY    "CPTENSU.INC".
      *
      *    患者労災保険情報
       01  PTRSIINF-REC.
           COPY    "CPPTRSIINF.INC".
      *
      *
      **************************************************************
      *    サブプロ用　領域
      **************************************************************
      *
      *   画面日付変換サブ
          COPY    "CPORCSGDAY.INC".
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *   患者番号変換サブ
           COPY    "CPORCSPTNUM.INC".
      *    負担金額計算用パラメタ
           COPY    "CPORCS01.INC".
      *    請求書印刷パラメタ
           COPY    "CPORCHC03.INC".
      *    ＤＢ検索
      *01  MCPDATA-REC                 PIC X(5000).
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *
       01  LNK-SYUNOU-REC.
           COPY "CPSYUNOU.INC" REPLACING  //SYU-// BY //LNK-SYU-//.
       01  WK-SYUNOU-REC-T.
           02 WK-SYUNOU-REC.
           COPY "CPSYUNOU.INC" REPLACING  //SYU-// BY //WK-SYU-//.
       01  WK-JYURRK-REC-T.
           02 WK-JYURRK-REC    OCCURS  100.
           COPY "CPJYURRK.INC" REPLACING  //JYURRK-// BY
                                                   //WK-JYURRK-//.
      *
           COPY "CPORCS01.INC" REPLACING  //LNK-// BY //WK-//.
      *
      **************************************************************
      *    連絡　領域
      **************************************************************
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
           COPY    "SERR.INC".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *
      **************************************************************
      *    主　　処理
      **************************************************************
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-S02
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
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-S02         TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      **************************************************************
      *    初期　処理
      **************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "SERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF      FLG-END             =   1
                   GO      TO      100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  MCP-PUTTYPE
           MOVE    "S02"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
          .
       100-INIT-EXT.
           EXIT.
      *
      **************************************************************
      *    初期画面処理
      **************************************************************
       300-SCREEN-SEC              SECTION.
      *
      *****INITIALIZE                  SPA-S02
      *
      *    他画面より
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
               MOVE    SPA-MOTOPG          TO  WRK-MOTOPG
      *        元画面表示
               IF      WRK-MOTOPG(1:3)     =   "Y01"  OR  "U01"
                                                      OR  "P97"
                   MOVE    LNK-COMMON      TO  SPA-KYOUTU
                   MOVE    LNK-SCRSPA      TO  SPA-S02
                   MOVE    SPA-WORK        TO  SPA-S01KYOUTU
               END-IF
      *        予約の時、そのまま画面表示へ
               IF      WRK-MOTOPG(1:3)     =   "Y01"
                   GO      TO      300-SCREEN-EXT
               END-IF
      *        外部より選択がある時
               IF      WRK-MOTOPG(1:3)     =   "U01"  OR
                                               "P97"
                   PERFORM 3101-P97SPASET-SEC
                   GO      TO      300-SCREEN-EXT
               END-IF
      *
               MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
           END-IF
      *
      *
           MOVE    SPA-WORK        TO  SPA-S01KYOUTU
      *
           EVALUATE    SPA-MOTOPG
               WHEN    "K02"
               WHEN    "K02N"
                   PERFORM                 310-SPA-SET-SEC
                   IF      SPA-PTNUM       NOT =   SPACE
                       MOVE    SPA-PTNUM       TO  S02-PTNUM
                       PERFORM 4102-PTNUM-CHK-SEC
      *                収納編集
                       MOVE    SPA-SRYKAMEI    TO  SPA-GMN-SRYKAMEI
                       MOVE    SPA-SRYKA       TO  SPA-GMN-SRYKA
                       MOVE    SPA-NYUGAIKBN   TO  SPA-GMN-NYUGAIKBN
      *                MOVE    SPA-NYUGAIKBN   TO  SPA-GMN-NYUGAIKBN
                       PERFORM 3101-COMBO-SYOKI-SET-SEC
                       PERFORM 300-SYUNOU-HENSYU-SEC
                       MOVE    1               TO   SPA-GMN-CUR
                   END-IF
               WHEN    "U02"
                   PERFORM                 310-SPA-SET-SEC
                   IF      SPA-PTNUM       NOT =   SPACE
                       MOVE    SPA-PTNUM       TO  S02-PTNUM
                       PERFORM 4102-PTNUM-CHK-SEC
      *                収納編集
                       MOVE    SPA-SRYKAMEI    TO  SPA-GMN-SRYKAMEI
                       MOVE    SPA-SRYKA       TO  SPA-GMN-SRYKA
      *                受診履歴より診療科決定
                       PERFORM 3103-JYURRK-CHK-SEC
                       IF    ( SPA-BEDSU   >   ZERO )
                           MOVE    "0"         TO  SPA-GMN-NYUGAIKBN
                       ELSE
                           MOVE    "2"         TO  SPA-GMN-NYUGAIKBN
                       END-IF
                       PERFORM 3101-COMBO-SYOKI-SET-SEC
                       PERFORM 300-SYUNOU-HENSYU-SEC
                       MOVE    1               TO   SPA-GMN-CUR
                   END-IF
               WHEN    "S03"
                   PERFORM 320-S03SPASET-SEC
               WHEN    OTHER
                   PERFORM 310-SPA-SET-SEC
           END-EVALUATE
      *
      *****PERFORM                     310-SPA-SET-SEC
           .
       300-SCREEN-EXT.
           EXIT.
      *****************************************************************
      *    ＬＤ外の項目入力編集処理
      *****************************************************************
       3101-P97SPASET-SEC              SECTION.
      *
           MOVE    LNK-KYOUTU          TO  WRK-SPA-KYOUTU
      *    受付、患者検索より
           IF      WRK-SPA-PTNUM       =   SPA-GMN-PTNUM
               CONTINUE
           ELSE
               IF      WRK-SPA-PTNUM       NOT =   SPACE
      *            初期表示へ
                   MOVE    WRK-SPA-PTNUM   TO  S02-PTNUM
                   PERFORM 4102-PTNUM-CHK-SEC
               END-IF
           END-IF
      *
           IF      SPA-GMN-PTID        =   ZERO
               MOVE    2                   TO  SPA-GMN-CUR
           ELSE
               MOVE    3                   TO  SPA-GMN-CUR
           END-IF
           .
       3101-P97SPASET-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    コンボ初期値設定処理
      *****************************************************************
       3101-COMBO-SYOKI-SET-SEC        SECTION.
      *
           PERFORM VARYING IDX14   FROM    1   BY  1
               UNTIL     ( IDX14   >       SPA-GMN-SRYKA-MAX )
               IF    ( SPA-GMN-SRYKA   =   SPA-GMN-SRYKAL (IDX14) )
                   MOVE    SPA-GMN-SRYKALST (IDX14)
                                       TO  SPA-GMN-SRYKA-G
                   MOVE    SPA-GMN-SRYKA-MAX
                                       TO  IDX14
               END-IF
           END-PERFORM
      *
           PERFORM VARYING IDX14   FROM    1   BY  1
               UNTIL     ( IDX14   >       SPA-GMN-NYUGAIKBN-MAX )
               IF    ( SPA-GMN-NYUGAIKBN
                                   =   SPA-GMN-NYUGAIKBNL (IDX14) )
                   MOVE    SPA-GMN-NYUGAIKBNLST (IDX14)
                                       TO  SPA-GMN-NYUGAIKBN-G
                   MOVE    SPA-GMN-NYUGAIKBN-MAX
                                       TO  IDX14
               END-IF
           END-PERFORM
      *
      *
           .
       3101-COMBO-SYOKI-SET-EXT.
           EXIT.
      **************************************************************
      *    画面編集処理
      **************************************************************
       310-SPA-SET-SEC                  SECTION.
      *
           INITIALIZE                  SPA-S02
      *
      *    患者情報（診療行為で患者番号を入力したとき） 
           IF     (SPA-MOTOPG2         =   "K02" OR "K02N" OR "U02" )
           AND    (SPA-PTNUM       NOT =   SPACE    )
      **       MOVE    SPA-PTNUM           TO  SPA-GMN-PTNUM
      *        MOVE    SPA-PTID            TO  SPA-GMN-PTID
      *        MOVE    SPA-KANANAME        TO  SPA-GMN-KANANAME
      **       MOVE    SPA-SEX             TO  SPA-GMN-SEX
               MOVE    SPA-SRYYMDW(1:6)    TO  SPA-GMN-SRYYM
               MOVE    SPA-SRYYMD (1:6)    TO  SPA-NAI-SRYYM
      **       MOVE    SPA-NAME            TO  SPA-GMN-NAME
      **       MOVE    SPA-BIRTHDAYW       TO  SPA-GMN-BIRTHDAY
               MOVE    SPA-SRYKAMEI        TO  SPA-GMN-SRYKAMEI
               MOVE    SPA-SRYKA           TO  SPA-GMN-SRYKA
               MOVE    SPA-NYUGAIKBN       TO  SPA-GMN-NYUGAIKBN
      **       PERFORM 300-SYUNOU-HENSYU-SEC
               MOVE    1                   TO  SPA-GMN-CUR
           ELSE
               MOVE    SPA-SYSYMDWH(1:6)    TO  SPA-GMN-SRYYM
               MOVE    SPA-SYSYMD  (1:6)    TO  SPA-NAI-SRYYM
               MOVE    2                    TO  SPA-GMN-CUR
           END-IF
      *
      *****MOVE    "2"                 TO  SPA-NYUGAIKBN
      *
           PERFORM 3101-SRYKA-SPA-SEC
      *
           PERFORM 3102-NYUGAIKBN-SPA-SEC
      *
           .
       310-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科ＳＰＡ画面編集処理
      *****************************************************************
       3101-SRYKA-SPA-SEC              SECTION.
      *    
           MOVE    SPACE               TO  SYS-KEY
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    SPA-NAI-SRYYM       TO  ORC-DBYMD
      *    システム管理検索
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               INITIALIZE                  SYS-1005-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       (IDX            >   99   )  OR
                               (FLG-SYSKANRI   =   1    )
               MOVE    MCPDATA-REC           TO  SYS-1005-REC
               MOVE    SYS-1005-KBNCD (1:2)  TO
                                             SPA-GMN-SRYKAL    (IDX)
               MOVE    SYS-1005-SRYKANAME1   TO
                                             SPA-GMN-SRYKAMEIL (IDX)
               MOVE    IDX                   TO
                                             SPA-GMN-SRYKA-MAX
      *
               MOVE    "SYSKANRI-KEY2"       TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       3101-SRYKA-SPA-EXT.
           EXIT.
      *
      *****************************************************************
      *    入外区分ＳＰＡ画面編集処理
      *****************************************************************
       3102-NYUGAIKBN-SPA-SEC          SECTION.
      *
           MOVE    "0"                 TO  SPA-GMN-NYUGAIKBNL       (1)
           MOVE    "全部"              TO  SPA-GMN-NYUGAIKBNMEIL    (1)
           MOVE    "1"                 TO  SPA-GMN-NYUGAIKBNL       (2)
           MOVE    "入院"              TO  SPA-GMN-NYUGAIKBNMEIL    (2)
           MOVE    "2"                 TO  SPA-GMN-NYUGAIKBNL       (3)
           MOVE    "外来"              TO  SPA-GMN-NYUGAIKBNMEIL    (3)
           MOVE    3                   TO  SPA-GMN-NYUGAIKBN-MAX
      *
           .
       3102-NYUGAIKBN-SPA-EXT.
           EXIT.
      *
      *****************************************************************
      *   受診履歴より診療科決定処理
      *****************************************************************
       3103-JYURRK-CHK-SEC             SECTION.
      *
      *    受診歴を検索する  医療機関、患者ＩＤ
           INITIALIZE                  JYURRK-REC
           MOVE    SPA-HOSPID          TO  JYURRK-HOSPID
           MOVE    SPA-GMN-PTID        TO  JYURRK-PTID
           MOVE    SPA-NYUGAIKBN       TO  JYURRK-NYUGAIKBN
           MOVE    SPA-NAI-SRYYM       TO  JYURRK-SRYYMD(1:6)
           MOVE    "31"                TO  JYURRK-SRYYMD(7:2)
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "JYURRK-KEY10"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "JYURRK-KEY10"      TO  ORC-DBPATH
               PERFORM 960-JYURRK-READ-SEC
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           DISPLAY "SPA-NAI-SRYYM = " SPA-NAI-SRYYM
           DISPLAY "JYURRK-SRYYMD = " JYURRK-SRYYMD
           PERFORM
               UNTIL   FLG-JYURRK          =   1
               IF      SPA-NAI-SRYYM       =   JYURRK-SRYYMD(1:6)
                   MOVE    JYURRK-SRYKA        TO  SPA-GMN-SRYKA
                   MOVE    JYURRK-NYUGAIKBN    TO  SPA-GMN-NYUGAIKBN
               END-IF
      *
               MOVE    "JYURRK-KEY10"      TO  ORC-DBPATH
               PERFORM 960-JYURRK-READ-SEC
               DISPLAY "FLG-JYURRK = " FLG-JYURRK
           END-PERFORM
           .
      *
       3103-JYURRK-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求確認戻り画面編集処理
      *****************************************************************
       320-S03SPASET-SEC          SECTION.
      * 
           INITIALIZE                  SPA-S02
      *
           MOVE    SPA-S01-PTNUM       TO  SPA-GMN-PTNUM
           MOVE    SPA-S01-PTID        TO  SPA-GMN-PTID
           MOVE    SPA-S01-KANANAME    TO  SPA-GMN-KANANAME
           MOVE    SPA-S01-SEX         TO  SPA-GMN-SEX
           MOVE    SPA-S01-SRYYMW      TO  SPA-GMN-SRYYM
           MOVE    SPA-S01-SRYYM       TO  SPA-NAI-SRYYM
           MOVE    SPA-S01-NAME        TO  SPA-GMN-NAME
           MOVE    SPA-S01-BIRTHDAYW   TO  SPA-GMN-BIRTHDAY
           MOVE    SPA-S01-SRYKAMEI    TO  SPA-GMN-SRYKAMEI
           MOVE    SPA-S01-SRYKA       TO  SPA-GMN-SRYKA
           MOVE    SPA-S01-HNYUGAIKBN  TO  SPA-GMN-NYUGAIKBN 
      *     
           PERFORM 300-SYUNOU-HENSYU-SEC
      *
           PERFORM 3101-SRYKA-SPA-SEC
      *
           PERFORM 3102-NYUGAIKBN-SPA-SEC
      *
           PERFORM 3101-COMBO-SYOKI-SET-SEC
      *
           IF    ( SPA-MOTOPG2         =   "K02" OR "K02N" )
           AND   ( SPA-PTNUM       NOT =   SPACE )
               MOVE    2                   TO  SPA-GMN-CUR
           ELSE        
               MOVE    1                   TO  SPA-GMN-CUR
           END-IF    
           .
       320-S03SPASET-EXT.
           EXIT.
      *
      **************************************************************
      *    収納マスタ編集処理
      **************************************************************
       300-SYUNOU-HENSYU-SEC                  SECTION.
      *
           MOVE    ZERO                TO  SPA-GMN-MAX
           INITIALIZE                      SPA-GMN-TBL
                                           SPA-NAI-TBL
      *     
             MOVE    ZERO                TO  IDX
      *
      *    収納マスターを編集（入院分）
           IF      SPA-GMN-NYUGAIKBN   =   "0" OR  "1"    
             INITIALIZE                      SYUNOU-REC
             MOVE    SPA-HOSPID          TO  SYU-HOSPID
      *****  MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
             MOVE    "1"                 TO  SYU-NYUGAIKBN
             MOVE    SPA-GMN-PTID        TO  SYU-PTID
             MOVE    SYUNOU-REC          TO  MCPDATA-REC
             MOVE    "DBSELECT"          TO  MCP-FUNC
             MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
             CALL    "ORCMCPSUB"          USING
                                          MCPAREA
                                          ORCMCPAREA
                                          MCPDATA-REC
             IF      MCP-RC              =    ZERO
                 MOVE    "SYUNOU-KEY2"         TO  ORC-DBPATH
                 PERFORM 900-SYUNOU-NEXT-SEC
             ELSE
                 MOVE    1                    TO  FLG-SYUNOU
             END-IF
      *     
             PERFORM    UNTIL      (FLG-SYUNOU      =   1  )  
                 MOVE    ZERO               TO  FLG-SYORI
                 IF     (SPA-GMN-SRYKA   NOT =   SPACE    )  AND
                        (SPA-GMN-SRYKA   NOT =   SYU-SRYKA)
                     MOVE    1                 TO  FLG-SYORI
                 END-IF
      *
                 IF     (SPA-NAI-SRYYM  NOT =   SPACE   )
                   IF   (SPA-NAI-SRYYM  NOT =   SYU-SKYSTYMD(1:6))
                         MOVE    1     TO      FLG-SYORI
                   END-IF
                 END-IF
      *
                 IF      FLG-SYORI           =   ZERO
                     PERFORM 3101-SIN-HEN-SEC
                 END-IF
      *
                 MOVE    "SYUNOU-KEY2"         TO  ORC-DBPATH
                 PERFORM 900-SYUNOU-NEXT-SEC
             END-PERFORM
      *
             MOVE    "DBCLOSE"           TO  MCP-FUNC
             MOVE    "SYUNOU-KEY2"        TO  ORC-DBPATH
             CALL    "ORCMCPSUB"          USING
                                          MCPAREA
                                          ORCMCPAREA
                                          MCPDATA-REC
           END-IF                                     
      *
      *    収納マスターを編集（外来分）
           IF      SPA-GMN-NYUGAIKBN   =   "0" OR  "2"    
             INITIALIZE                      SYUNOU-REC
             MOVE    SPA-HOSPID          TO  SYU-HOSPID
             MOVE    "2"                 TO  SYU-NYUGAIKBN
             MOVE    SPA-GMN-PTID        TO  SYU-PTID
             MOVE    SYUNOU-REC          TO  MCPDATA-REC
             MOVE    "DBSELECT"          TO  MCP-FUNC
             MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
             CALL    "ORCMCPSUB"          USING
                                          MCPAREA
                                          ORCMCPAREA
                                          MCPDATA-REC
             IF      MCP-RC              =    ZERO
                 MOVE    "SYUNOU-KEY2"         TO  ORC-DBPATH
                 PERFORM 900-SYUNOU-NEXT-SEC
             ELSE
                 MOVE    1                    TO  FLG-SYUNOU
             END-IF
      *     
             PERFORM    UNTIL      (FLG-SYUNOU      =   1  )  
                 MOVE    ZERO               TO  FLG-SYORI
                 IF     (SPA-GMN-SRYKA   NOT =   SPACE    )  AND
                        (SPA-GMN-SRYKA   NOT =   SYU-SRYKA)
                     MOVE    1                 TO  FLG-SYORI
                 END-IF
      *
                 IF     (SPA-NAI-SRYYM  NOT =   SPACE   )
                   IF   (SPA-NAI-SRYYM  NOT =   SYU-SRYYMD(1:6))
                         MOVE    1     TO      FLG-SYORI
                   END-IF
                 END-IF
      *
                 IF      FLG-SYORI           =   ZERO
                     PERFORM 3101-SIN-HEN-SEC
                 END-IF
      *
                 MOVE    "SYUNOU-KEY2"         TO  ORC-DBPATH
                 PERFORM 900-SYUNOU-NEXT-SEC
             END-PERFORM
      *
             MOVE    "DBCLOSE"           TO  MCP-FUNC
             MOVE    "SYUNOU-KEY2"        TO  ORC-DBPATH
             CALL    "ORCMCPSUB"          USING
                                          MCPAREA
                                          ORCMCPAREA
                                          MCPDATA-REC
           END-IF                                     
     *
           MOVE    IDX                 TO  SPA-GMN-MAX
     *
           .
       300-SYUNOU-HENSYU-EXT.
           EXIT.
      *
      **************************************************************
      *   収納マスターより画面内容編集処理
      **************************************************************
       3101-SIN-HEN-SEC             SECTION.
      *
      *    収納マスタ内容編集
           ADD     1                   TO  IDX
      *     
           MOVE    IDX                 TO  SPA-GMN-TBANGO  (IDX)
      *
           MOVE    SYU-DENPNUM         TO  SPA-GMN-TDENPNUM (IDX)
           MOVE    SYU-NYUGAIKBN       TO  SPA-NAI-TNYUGAIKBN  (IDX)
           EVALUATE    SYU-NYUGAIKBN
               WHEN    "1"
                   MOVE    "入"        TO  SPA-GMN-TNYUGAIKBN  (IDX)
               WHEN    "2"
                   MOVE    "外"        TO  SPA-GMN-TNYUGAIKBN  (IDX)
           END-EVALUATE
      *    診療日
           EVALUATE    SYU-NYUGAIKBN
               WHEN    "1"
                   MOVE    SYU-SKYSTYMD    TO  SPA-NAI-SRYYMD   (IDX)
                   MOVE    SYU-SKYSTYMD    TO  WRK-SYMD
                   PERFORM 31011-SEIWA-HEN-SEC
                   MOVE    WRK-HENYMDG     TO  SPA-GMN-TSRYYMD  (IDX)
                   MOVE    SYU-SKYEDYMD    TO  SPA-NAI-SKYEDYMD (IDX)
                   MOVE    SYU-SKYEDYMD    TO  WRK-SYMD
                   PERFORM 31011-SEIWA-HEN-SEC
                   MOVE    "-"         TO  SPA-GMN-TSRYYMD  (IDX) (10:1)
                   MOVE    WRK-HENYMDG (5:5)
                                       TO  SPA-GMN-TSRYYMD  (IDX) (11:5)
               WHEN    "2" 
                   MOVE    SYU-SRYYMD      TO  SPA-NAI-SRYYMD   (IDX)
                   MOVE    SYU-SRYYMD      TO  WRK-SYMD
                   PERFORM 31011-SEIWA-HEN-SEC
                   MOVE    WRK-HENYMDG     TO  SPA-GMN-TSRYYMD  (IDX)
           END-EVALUATE        
      *    発行日
      *----(01.00.01) LINE MOD START -------------------------------
      *    MOVE    SYU-SRYYMD          TO  SPA-NAI-HAKYMD   (IDX)
      *    MOVE    SYU-SRYYMD          TO  WRK-SYMD
           MOVE    SYU-DENPPRTYMD      TO  SPA-NAI-HAKYMD   (IDX)
           MOVE    SYU-DENPPRTYMD      TO  WRK-SYMD
      *----(01.00.01) LINE MOD END   -------------------------------
           PERFORM 31011-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  SPA-GMN-THAKYMD  (IDX)
      *    請求金額
           MOVE    SYU-SKYMONEY        TO  SPA-GMN-TSEIKYU  (IDX)
      *    未収金額
           COMPUTE SPA-GMN-TMISYU(IDX) =   SYU-SKYMONEY
                                       -   SYU-NYUKIN-TOTAL
      *
      *    保険組合せより（保険と負担）
           MOVE    SYU-HKNCOMBINUM     TO  WRK-KUMINO
           PERFORM 510-HKNKUMI-MEI-SEC
           MOVE    WRK-HKNKUMI         TO  SPA-GMN-THKNCOMBI (IDX)
      *
      *    患者負担率
           IF      SYU-PTFTNRATE       =   ZERO
                   MOVE    SPACE       TO  SPA-GMN-TFTNRATE (IDX)
           ELSE
                   MOVE    SPACE       TO  WK-GMN-RITU
                   MOVE    SYU-PTFTNRATE TO  WK-GMN-FTNRITU
                   MOVE    "%"         TO  WK-GMN-PA
                   MOVE    WK-GMN-RITU TO  SPA-GMN-TFTNRATE (IDX)
           END-IF
      *
      *    伝票状態区分
           EVALUATE   SYU-DENPJTIKBN
               WHEN   SPACE
                      MOVE  "請求額なし"  TO  SPA-GMN-TJYOTAI (IDX)
               WHEN   "1"
                      MOVE  "入金済"      TO  SPA-GMN-TJYOTAI (IDX)
               WHEN   "2"
                      MOVE  "未入金"      TO  SPA-GMN-TJYOTAI (IDX)
               WHEN   "3"
                      MOVE  "請求取消し"  TO  SPA-GMN-TJYOTAI (IDX)
               WHEN   "7"
                      MOVE  "継続"        TO  SPA-GMN-TJYOTAI (IDX)
           END-EVALUATE
      *
           .
       3101-SINKAI-SPA-EXT.
           EXIT.
      *
      *
      **************************************************************
      *    西暦和暦編集処理
      **************************************************************
       31011-SEIWA-HEN-SEC             SECTION.
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
           .
       31011-SEIWA-HEN-EXT.
           EXIT.
      **************************************************************
      *    自画面編集処理
      **************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LNK-KYOUTU
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "S02    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *
      **************************************************************
      *    画面編集処理
      **************************************************************
       500-GMNHEN-SEC                  SECTION.
      *
           MOVE    SPACE               TO  S02
      *
           MOVE    SPA-GMN-PTNUM       TO  S02-PTNUM
           MOVE    SPA-GMN-KANANAME    TO  S02-KANANAME
           MOVE    SPA-GMN-NAME        TO  S02-NAME
           MOVE    SPA-GMN-SEX         TO  S02-SEX
           MOVE    SPA-GMN-SRYYM       TO  S02-SRYYM
           MOVE    SPA-GMN-BIRTHDAY    TO  S02-BIRTHDAY
           MOVE    SPA-GMN-SRYKA-G     TO  S02-SRYKA
           DISPLAY "SPA-GMN-SRYKA-G =  "   SPA-GMN-SRYKA-G
           DISPLAY "S02-SRYKA       =  "   S02-SRYKA
           MOVE    SPA-GMN-NYUGAIKBN-G TO  S02-NYUGAIKBN
      *     
           PERFORM VARYING   IDX     FROM    1   BY  1
                   UNTIL     IDX     >       SPA-GMN-SRYKA-MAX
                   OR        SPA-GMN-SRYKAL  (IDX)   =   SPACE 
               MOVE    SPA-GMN-SRYKALST (IDX)
                                          TO  S02-SRYKALST(IDX)
               MOVE    IDX                TO  S02-SRYKA-COUNT
           END-PERFORM
      *     
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       SPA-GMN-NYUGAIKBN-MAX
                   OR          SPA-GMN-NYUGAIKBNL  (IDX)  =   SPACE
               MOVE    SPA-GMN-NYUGAIKBNLST (IDX)
                                           TO  S02-NYUGAIKBN-ITEM (IDX)
               MOVE    IDX                 TO  S02-NYUGAIKBN-COUNT
           END-PERFORM
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       SPA-GMN-MAX
               MOVE    SPA-GMN-TBANGO (IDX)    TO  WRK-TBANGO-W
               MOVE    WRK-TBANGO-W            TO  S02-NUM       (IDX)
               MOVE    SPA-GMN-TDENPNUM(IDX)   TO  S02-DENPNUM   (IDX)
               MOVE    SPA-GMN-TNYUGAIKBN(IDX) TO  S02-NYUGAI    (IDX)
               MOVE    SPA-GMN-THKNCOMBI(IDX)  TO  S02-HKN       (IDX)
               MOVE    SPA-GMN-TFTNRATE(IDX)   TO  S02-FTNRATE   (IDX)
               MOVE    SPA-GMN-THAKYMD (IDX)   TO  S02-SKYSTYMD  (IDX)
               MOVE    SPA-GMN-TSRYYMD (IDX)   TO  S02-SRYYMD2   (IDX)
               MOVE    SPA-GMN-TSEIKYU(IDX)    TO  WRK-TSEIKYU-W
               MOVE    WRK-TSEIKYU-W           TO  S02-SKYMONEY  (IDX)
               MOVE    SPA-GMN-TMISYU (IDX)    TO  WRK-TMISYU-W 
               MOVE    WRK-TMISYU-W            TO  S02-MISYUMONEY(IDX)
               MOVE    SPA-GMN-TJYOTAI (IDX)   TO  S02-DENPJTI   (IDX)
      *         
               IF      IDX             =   SPA-NAI-SELNO
                   MOVE    "T"             TO  S02-SELECT (IDX)
               ELSE
                   MOVE    "F"             TO  S02-SELECT (IDX)
               END-IF
           END-PERFORM
           MOVE    SPA-GMN-MAX         TO  S02-COUNT
      *
           MOVE    SPA-GMN-SELBAN      TO  WRK-SELBAN-W
           MOVE    WRK-SELBAN-W        TO  S02-SELNUM
      *
      *    
      *    IF      SPA-MOTOPG2         =   "K02"
      *    AND     SPA-PTNUM       NOT =   SPACE
      *        MOVE    WIDGET-INSENSITIVE  TO  S02-PTNUM-STATE
      *****ELSE
               MOVE    WIDGET-NORMAL       TO  S02-PTNUM-STATE
      *****END-IF
           MOVE    WIDGET-INSENSITIVE      TO  S02-B03S-STATE
      *
           PERFORM 5001-MAPCUR-SEC
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      **************************************************************
      *    画面カーソルセット処理
      **************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
           EVALUATE    SPA-GMN-CUR
               WHEN    1
                   MOVE    "SELNUM"    TO  MCP-WIDGET  
               WHEN    2
                   MOVE    "PTNUM"     TO  MCP-WIDGET
               WHEN    3
                   MOVE    "SRYYM"     TO  MCP-WIDGET
               WHEN    4
                   MOVE    "SRYKA"     TO  MCP-WIDGET
               WHEN    5
                   MOVE    "NYUGAIKBN" TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      **************************************************************
      *    画面遷移処理
      **************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT         ALSO    MCP-WIDGET
      *    戻る
               WHEN    "CLICKED"         ALSO    "B01"
                   PERFORM 210-BACK
      *    クリア
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 420-CLEA-SEC
      *    前回患者処理
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM 430-MAEKPTNUM-SEC
      *
      *    再発行
               WHEN    "CLICKED"         ALSO    "B02S"
                   PERFORM 420-SAIHAKKOU-SEC
      *    請求取消処理
               WHEN    "CLICKED"         ALSO    "B03S"
                   PERFORM 430-TORIKESI-SEC
      *    再計算
               WHEN    "CLICKED"         ALSO    "B04"
                   PERFORM 440-SAIKEI-SEC
      *    返金
               WHEN    "CLICKED"         ALSO    "B05"
                   PERFORM 450-HENKIN-SEC
      *    入金
               WHEN    "CLICKED"         ALSO    "B05S"
                   PERFORM 460-NYUKIN-SEC
      *    入金取消
               WHEN    "CLICKED"         ALSO    "B08"
                   PERFORM 470-NYUDEL-SEC
      *    調整金
      **       WHEN    "CLICKED"         ALSO    "B10"
      **           PERFORM 480-CHOSEI-SEC
      *    修正履歴
               WHEN    "CLICKED"         ALSO    "B11S"
                   PERFORM 490-RIREKI-SEC
      *     確定
               WHEN    "CLICKED"         ALSO    "B12"
                   PERFORM 490-KAKUTEI-SEC
      *    ＪＤ入金
      ***      WHEN    "CLICKED"         ALSO    "B13"
      ***          PERFORM 490-JD-NYUKIN-SEC
      *    前月表示
      *****    WHEN    "CLICKED"         ALSO    "B14"
               WHEN    "CLICKED"         ALSO    "B06"
                   PERFORM 490-ZENGETU-SEC
      *    次月表示
      *****    WHEN    "CLICKED"         ALSO    "B15"
               WHEN    "CLICKED"         ALSO    "B07"
                   PERFORM 490-JIGETU-SEC
      *    氏名検索（Ｐ９７）
               WHEN    "CLICKED"       ALSO    "B09"
                   PERFORM 470-SIMEIKEN-SEC
      *    予約登録へ（Ｙ０２）
               WHEN    "CLICKED"       ALSO    "B10"
                   PERFORM 480-YOYAKU-SEC
      *    受付一覧へ（Ｕ０１）
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 490-UKEICHI-SEC
           END-EVALUATE
           .
       200-GMNSENI-EXT.
           EXIT.
      *
      **************************************************************
      *    会話　処理
      **************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        選択番号
               WHEN    ANY             ALSO    "THLIST"
                   PERFORM 4105-LSTSEL-SEC
               WHEN    "ACTIVATE"      ALSO    "SELNUM"
                   PERFORM 4101-SELNUM-CHK-SEC
      *        患者番号
               WHEN    "ACTIVATE"      ALSO    "PTNUM"
                   PERFORM 4102-PTNUM-CHK-SEC
      *        診療科
               WHEN    "ACTIVATE"      ALSO    "SRYKA"
                   PERFORM 4103-SRYKA-CHK-SEC
      *        請求年月
               WHEN    "ACTIVATE"      ALSO    "SRYYM"
                   PERFORM 4104-SRYYM-CHK-SEC
      *        入外区分
               WHEN    "ACTIVATE"      ALSO    "NYUGAIKBN"
                   PERFORM 4106-NYUGAIKBN-CHK-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      **************************************************************
      *    番号選択入力処理
      **************************************************************
       4101-SELNUM-CHK-SEC             SECTION.
      *
           MOVE    1                 TO  SPA-GMN-CUR
      *
           MOVE    ZERO              TO  SPA-NAI-SELNO     
      *     
           MOVE    S02-SELNUM        TO  SPA-GMN-SELBAN
      *     
           INITIALIZE                      ORCSNUMAREA
           MOVE    SPA-GMN-SELBAN       TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-MINKBN     NOT =   SPACE )   OR
                  (SNUM-SYOKBN     NOT =   SPACE )
               MOVE    "0001"              TO  SPA-ERRCD
      *        GO      TO      4102-PTNUM-CHK-EXT
               GO      TO      4101-SELNUM-CHK-EXT
           ELSE
               MOVE    SNUM-OUTNUM     TO  SPA-GMN-SELBAN
           END-IF
           IF      SPA-GMN-SELBAN      =   ZERO   OR
                                       >   SPA-GMN-MAX
               MOVE    "0001"              TO  SPA-ERRCD
               GO      TO      4101-SELNUM-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-SELBAN     TO  SPA-NAI-SELNO     
           .
       4101-SELNUM-CHK-EXT.
           EXIT.
      *
      **************************************************************
      *    患者番号チェック処理
      **************************************************************
       4102-PTNUM-CHK-SEC            SECTION.
      *
           MOVE    2                   TO  SPA-GMN-CUR
      *
           INITIALIZE                  SPA-GMN-HEAD
                                       SPA-GMN-TBL
                                       SPA-GMN-INPUT
                                       SPA-NAI-TBL
                                       SPA-GMN-MAX
                                       SPA-NAI-SELNO
      *
           MOVE    S02-PTNUM           TO  SPA-GMN-PTNUM
      *
      *****INITIALIZE                      ORCSPTIDAREA
      *    MOVE    SPA-HOSPID          TO  SPTID-HOSPID
      *    MOVE    SPA-GMN-PTNUM       TO  SPTID-PTNUM
      *    CALL    "ORCSPTID"          USING   ORCSPTIDAREA
      *----(01.00.01) LINE ADD START -------------------------------
      *                                        SPA-1009-TBL
      *----(01.00.01) LINE ADD END   -------------------------------
      *    IF      SPTID-RC        NOT =   ZERO
      *        MOVE    "0032"          TO  SPA-ERRCD
      *        GO  TO                  4102-PTNUM-CHK-EXT
      *****END-IF
      *
           INITIALIZE                      ORCSPTNUMAREA
           MOVE    SPA-GMN-PTNUM       TO  SPTNUM-PTNUM
           CALL    "ORCSPTNUM"         USING   ORCSPTNUMAREA
                                               SPA-AREA
           EVALUATE    SPTNUM-RC
               WHEN    00
                   MOVE    SPTNUM-PTNUM        TO  SPTID-PTNUM
                   MOVE    SPTNUM-PTID         TO  SPTID-PTID
               WHEN   10
                   MOVE    "0031"              TO  SPA-ERRCD
                   GO      TO     4102-PTNUM-CHK-EXT
               WHEN    20
      *            氏名検索へ
                   MOVE    SPACE               TO  LINKAREA
                   MOVE    SPA-KYOUTU          TO  LNK-COMMON
                   MOVE    SPA-S02             TO  LNK-SCRSPA
      *
                   MOVE    "S02"               TO  SPA-MOTOPG
                   MOVE    "P97"               TO  SPA-SAKIPG
      *            氏名セット
                   MOVE    SPA-GMN-PTNUM       TO  SPA-NAME
                   MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
                   MOVE    "CHANGE"            TO  MCP-PUTTYPE
                   MOVE    "P97"               TO  MCP-WINDOW
                   PERFORM 900-PUT-WINDOW
                   MOVE    1                   TO  FLG-END
                   GO      TO     4102-PTNUM-CHK-EXT
               WHEN    OTHER
                   MOVE    "0031"          TO  SPA-ERRCD
                   GO      TO     4102-PTNUM-CHK-EXT
           END-EVALUATE
      *
           MOVE    SPTID-PTID          TO  SPA-GMN-PTID
      *----(01.00.01) LINE ADD START -------------------------------
           MOVE    SPTID-PTNUM         TO  SPA-GMN-PTNUM
      *----(01.00.01) LINE ADD END   -------------------------------
      *
      *    患者マスター存在チェック
           MOVE    SPA-HOSPID          TO  PTINF-HOSPID
           MOVE    SPA-GMN-PTID        TO  PTINF-PTID

           PERFORM 900-PTINF-READ-SEC
           IF      FLG-PTINF       NOT =   ZERO
               MOVE    SPACE               TO  SPA-GMN-NAME
               MOVE    "0031"              TO  SPA-ERRCD
               GO      TO      4102-PTNUM-CHK-EXT
           END-IF
      *
           MOVE    PTINF-NAME        TO  SPA-GMN-NAME
           MOVE    PTINF-KANANAME    TO  SPA-GMN-KANANAME
           EVALUATE    PTINF-SEX
               WHEN    "1" 
                   MOVE    "男"          TO  SPA-GMN-SEX
               WHEN    "2"
                   MOVE    "女"          TO  SPA-GMN-SEX
           END-EVALUATE
           MOVE    PTINF-BIRTHDAY    TO  WRK-SYMD
           PERFORM 31011-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG       TO  SPA-GMN-BIRTHDAY
      *    前回患者
           MOVE    SPA-GMN-PTID        TO  SPA-LAST-PTID
           MOVE    SPA-GMN-PTNUM       TO  SPA-LAST-PTNUM
      *
      *    受診歴チェック処理
           PERFORM 3103-JYURRK-CHK-SEC
      *
      *    入外区分
           IF    ( SPA-BEDSU       >   ZERO )
               MOVE    "0"             TO  SPA-GMN-NYUGAIKBN
           ELSE
               IF    ( SPA-GMN-NYUGAIKBN
                                   =   SPACE )
                   MOVE    "2"         TO  SPA-GMN-NYUGAIKBN
               END-IF
           END-IF
      *
           PERFORM 3101-COMBO-SYOKI-SET-SEC
      *
           PERFORM 300-SYUNOU-HENSYU-SEC
           IF    ( SPA-GMN-MAX     = ZERO )
               MOVE    "0020"      TO  SPA-ERRCD
               MOVE    3           TO  SPA-GMN-CUR
           ELSE
               MOVE    1           TO  SPA-GMN-CUR
           END-IF
      *
           .
       4102-PTNUM-CHK-EXT.
           EXIT.
      *
      **************************************************************
      *    診療科入力処理
      **************************************************************
       4103-SRYKA-CHK-SEC             SECTION.
      *
           MOVE    4                  TO  SPA-GMN-CUR  
      *
      *****INITIALIZE                 SPA-GMN-TBL
      *                               SPA-GMN-MAX
      *                               SPA-NAI-TBL
      *                               SPA-GMN-INPUT
      *****                           SPA-NAI-SELNO
      *                                 
           MOVE    S02-SRYKA          TO  SPA-GMN-SRYKA-G
      *
           IF      SPA-GMN-SRYKAMEI   =   SPACE
               MOVE    "0030"               TO  SPA-ERRCD
               GO  TO  4103-SRYKA-CHK-EXT
           END-IF
      *
           MOVE    1                  TO  FLG-ERR
           PERFORM VARYING IDX14   FROM    1   BY  1
               UNTIL     ( IDX14   >       SPA-GMN-SRYKA-MAX )
               IF    ( SPA-GMN-SRYKA   =   SPA-GMN-SRYKAL (IDX14) )
                   MOVE    ZERO        TO  FLG-ERR
                   MOVE    SPA-GMN-SRYKA-MAX
                                       TO  IDX14
               END-IF
           END-PERFORM
      *
           IF    ( FLG-ERR     NOT =   ZERO )
               MOVE    "0030"               TO  SPA-ERRCD
               GO  TO  4103-SRYKA-CHK-EXT
           END-IF
      *
           IF      SPA-GMN-PTID        =   ZERO
           OR      SPA-NAI-SRYYM       =   ZERO
               MOVE    "0050"              TO  SPA-ERRCD
               GO  TO  4103-SRYKA-CHK-EXT
           END-IF
      *
           PERFORM 300-SYUNOU-HENSYU-SEC
           IF    ( SPA-GMN-MAX     >   ZERO )
               MOVE    1           TO  SPA-GMN-CUR
           END-IF
      *
           .
       4103-SRYKA-CHK-EXT.
           EXIT.
      *
      **************************************************************
      *    診療年月入力処理
      **************************************************************
       4104-SRYYM-CHK-SEC            SECTION.
      *
           MOVE    3                  TO  SPA-GMN-CUR
      *
           INITIALIZE                 SPA-GMN-TBL
                                      SPA-GMN-MAX
                                      SPA-NAI-AREA
                                      SPA-GMN-INPUT
      *     
           MOVE    S02-SRYYM          TO  SPA-GMN-SRYYM
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    SPA-GMN-SRYYM       TO  SGDAY-INDAY
           MOVE    "1"                 TO  SGDAY-INTYPE
           CALL    "ORCSGDAY"          USING
                                       ORCSGDAYAREA
           IF      SGDAY-RC            =   ZERO
               MOVE    SGDAY-OTDAY(1:6)    TO  SPA-GMN-SRYYM
               MOVE    SGDAY-OTDAY(1:6)    TO  SPA-SRYYMDW
               MOVE    SGDAY-SDAY          TO  SPA-NAI-SRYYM
      ******** MOVE    SGDAY-SDAY          TO  SPA-SRYYMD
           ELSE
               MOVE    "0033"              TO  SPA-ERRCD
               GO  TO  4104-SRYYM-CHK-EXT
           END-IF
      *
      *    受診歴チェック処理
           PERFORM 3103-JYURRK-CHK-SEC
      *
      *    入外区分
           IF    ( SPA-BEDSU       >   ZERO )
               MOVE    "0"             TO  SPA-GMN-NYUGAIKBN
           ELSE
               IF    ( SPA-GMN-NYUGAIKBN
                                   =   SPACE )
                   MOVE    "2"         TO  SPA-GMN-NYUGAIKBN
               END-IF
           END-IF
      *
           PERFORM 3101-COMBO-SYOKI-SET-SEC
      *
           PERFORM 300-SYUNOU-HENSYU-SEC
           IF    ( SPA-GMN-MAX     >   ZERO )
               MOVE    1           TO  SPA-GMN-CUR
           END-IF
      *
           .
       4104-SRYYM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       4105-LSTSEL-SEC       SECTION.
      *        行選択
           MOVE    ZERO                TO  WRK-SELNO
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-MAX
               IF      S02-SELECT (IDX)    =   "T"
                   IF      IDX             =   SPA-NAI-SELNO
                       CONTINUE
                   ELSE        
                       MOVE    IDX             TO  WRK-SELNO
                       MOVE    200             TO  IDX
                   END-IF
               END-IF    
           END-PERFORM
      *
           IF      WRK-SELNO           >   ZERO
               MOVE    WRK-SELNO           TO  SPA-NAI-SELNO
           END-IF
      *
           MOVE    SPA-GMN-TBANGO (SPA-NAI-SELNO)
                                       TO  SPA-GMN-SELBAN
           .
       4105-LSTSEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    入外区分  入力処理
      *****************************************************************
       4106-NYUGAIKBN-CHK-SEC                SECTION.
      *   
           MOVE    5                   TO  SPA-GMN-CUR
      *
           INITIALIZE                 SPA-GMN-TBL
                                      SPA-GMN-MAX
                                      SPA-NAI-TBL
                                      SPA-GMN-INPUT
                                      SPA-NAI-SELNO
      *
           MOVE    S02-NYUGAIKBN      TO  SPA-GMN-NYUGAIKBN-G
      *
      *
           IF      SPA-GMN-NYUGAIKBN  =   SPACE
               MOVE    "0034"             TO  SPA-ERRCD
               GO  TO  4106-NYUGAIKBN-CHK-EXT
           END-IF
      *
           MOVE    1                  TO  FLG-ERR
           PERFORM VARYING IDX14   FROM    1   BY  1
               UNTIL     ( IDX14   >       SPA-GMN-NYUGAIKBN-MAX )
               IF    ( SPA-GMN-NYUGAIKBN
                                   =   SPA-GMN-NYUGAIKBNL (IDX14) )
                   MOVE    ZERO        TO  FLG-ERR
                   MOVE    SPA-GMN-NYUGAIKBN-MAX
                                       TO  IDX14
               END-IF
           END-PERFORM
      *
           IF    ( FLG-ERR     NOT =   ZERO )
               MOVE    "0050"               TO  SPA-ERRCD
               GO  TO  4106-NYUGAIKBN-CHK-EXT
           END-IF
      *
           IF      SPA-GMN-PTID        =   ZERO
           OR      SPA-NAI-SRYYM       =   ZERO
           OR      SPA-GMN-SRYKA       =   SPACE
               MOVE    "0050"              TO  SPA-ERRCD
               GO  TO  4106-NYUGAIKBN-CHK-EXT
           END-IF
      *
           PERFORM 300-SYUNOU-HENSYU-SEC
           IF    ( SPA-GMN-MAX     >   ZERO )
               MOVE    1           TO  SPA-GMN-CUR
           END-IF
      *
           .
       4106-NYUGAIKBN-CHK-EXT.
           EXIT.
      *
      **************************************************************
      *    戻る　処理
      **************************************************************
       210-BACK                    SECTION.
      *
      *    診療行為より遷移時、診療行為へ
           MOVE    SPACE               TO  LINKAREA
           IF      SPA-MOTOPG2         =   "K02" OR "K02N" OR "U02"
               MOVE    SPA-MOTOPG2         TO  SPA-SAKIPG
               MOVE    "S02"               TO  SPA-MOTOPG
               MOVE    SPACE               TO  SPA-MOTOPG2
               MOVE    SPACE               TO  LINKAREA
               MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
           ELSE
               MOVE    "M01"               TO  SPA-SAKIPG
               MOVE    "S02"               TO  SPA-MOTOPG
               INITIALIZE                  SPA-KYOTUKEY
               MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
           END-IF
      *
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
      **************************************************************
      *    再発行処理
      **************************************************************
       420-SAIHAKKOU-SEC           SECTION.
      *
           IF      SPA-GMN-SELBAN      =   ZERO
               GO      TO      420-SAIHAKKOU-EXT
           END-IF
      *    収納マスタを読み込みし、診療日の取込み
      *    選択された伝票番号から再発行を行う
           INITIALIZE                      SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
      *****MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                       TO  SYU-NYUGAIKBN
           MOVE    SPA-GMN-PTID        TO  SYU-PTID
           MOVE    SPA-GMN-TDENPNUM (SPA-GMN-SELBAN)
                                       TO  SYU-DENPNUM
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYUNOU-KEY"    TO  ORC-DBPATH
               PERFORM 900-SYUNOU-NEXT-SEC
               MOVE    "DBCLOSE"       TO  MCP-FUNC 
               MOVE    "SYUNOU-KEY"    TO  ORC-DBPATH
               CALL    "ORCMCPSUB"      USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           ELSE
               MOVE    1               TO  FLG-SYUNOU
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC 
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *                                 
           IF      FLG-SYUNOU          =   ZERO
               IF      SYU-DENPJTIKBN      =   "3"
                       MOVE    "0010"      TO  SPA-ERRCD
               ELSE
      *            帳票プログラム取得
                   PERFORM 4201-PRINT-PG-SEC
      *
                       MOVE   SPA-AREA     TO  WRK-SPA-AREA
                       MOVE   SYU-SRYYMD   TO  WRK-SPA-SRYYMD
                       MOVE   SPA-GMN-PTID TO  WRK-SPA-PTID
                       MOVE   SPA-GMN-PTNUM TO WRK-SPA-PTNUM
                       MOVE   SPA-GMN-NAME TO  WRK-SPA-NAME
                       MOVE   SPA-GMN-SRYKA TO WRK-SPA-SRYKA
                       MOVE   SPA-GMN-SRYKAMEI
                                           TO  WRK-SPA-SRYKAMEI     
                       MOVE   SYU-DENPNUM  TO  ORCHC03-DENPNUM
                       MOVE   SYU-SKYMONEY TO  ORCHC03-SEIKYU
                       MOVE   SYU-NYUKIN-TOTAL
                                           TO  ORCHC03-NYUKIN
      *****************CALL  "ORCHC03"     USING   WRK-SPA-AREA
                       CALL  WRK-SEIKYU-PG     USING
                                                   WRK-SPA-AREA
                                                   ORCHC03AREA
                       MOVE   SPACE        TO  SPA-SRYYMD(7:2)
               END-IF
           END-IF
      *
           MOVE    "01"                TO  WRK-SYORINO
      *
      ***     MOVE    "S02"               TO  SPA-MOTOPG
      ***     MOVE    "S03"               TO  SPA-SAKIPG
      *
      ***     MOVE   "CHANGE"             TO  MCP-PUTTYPE.
      ***     MOVE   "S03    "            TO  MCP-WINDOW.
      *
      ***     PERFORM 900-PUT-WINDOW.
      *
      ***     MOVE    1                   TO  FLG-END
      *
           .
       420-SAIHAKKOU-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票プログラム取得処理
      *****************************************************************
       4201-PRINT-PG-SEC              SECTION.
      *
      *    請求書
           MOVE    SPACE               TO  WRK-SEIKYU-PG
      *
           MOVE    SPACE               TO  SYS-1032-REC
           INITIALIZE                      SYS-1032-REC
           MOVE    "1032"              TO  SYS-1032-KANRICD
           MOVE    "00000003"          TO  SYS-1032-KBNCD
      *
           MOVE    SYS-1032-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           EVALUATE    SYU-NYUGAIKBN
               WHEN    "1"
                   MOVE    SYU-SKYSTYMD        TO  ORC-DBYMD
               WHEN    "2"
                   MOVE    SYU-SRYYMD          TO  ORC-DBYMD
           END-EVALUATE        
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               INITIALIZE                  SYS-1032-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1032-REC
      *        独自開発分
               IF      SYS-1032-ORCACSTCHK     =   "T"
                   MOVE    SYS-1032-ORCACSTNM  TO  WRK-SEIKYU-PG
               ELSE
      *        ＯＲＣＡ標準分
                   MOVE    SYS-1032-ORCAORGNM  TO  WRK-SEIKYU-PG
               END-IF
           END-IF
           IF      WRK-SEIKYU-PG       =   SPACE
               MOVE    "ORCHC03"           TO  WRK-SEIKYU-PG
           END-IF
      *
           .
      *
       4201-PRINT-PG-EXT.
           EXIT.
      *
      *
      **************************************************************
      *    請求取消処理
      **************************************************************
       430-TORIKESI-SEC           SECTION.
      *
           IF      SPA-GMN-SELBAN      =   ZERO
               GO      TO      430-TORIKESI-EXT
           END-IF
      *
           MOVE    "02"                TO  WRK-SYORINO
      *
      *    収納マスタと収納明細の請求金額を０円に変更する
      *
           INITIALIZE                      SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
      *****MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                       TO  SYU-NYUGAIKBN
           MOVE    SPA-GMN-PTID        TO  SYU-PTID
           MOVE    SPA-GMN-TDENPNUM (SPA-GMN-SELBAN)
                                       TO  SYU-DENPNUM
           PERFORM 900-SYUNOU-READ-SEC                            
      *
           IF      FLG-SYUNOU          =   ZERO
                   IF  (SYU-DENPJTIKBN     =     "1"   OR   "3")
                        MOVE    "0003"     TO    SPA-ERRCD
                   ELSE
                        MOVE    "3"        TO    SYU-DENPJTIKBN
                        MOVE    ZERO       TO    SYU-SKYMONEY
                        MOVE    SYUNOU-REC          TO  MCPDATA-REC
                        MOVE    "DBUPDATE"          TO  MCP-FUNC
                        MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
                        CALL    "ORCMCPSUB"          USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                        IF      MCP-RC          NOT =   ZERO
                            MOVE    "1002"              TO  SPA-ERRCD
                            GO  TO  430-TORIKESI-EXT
                        END-IF
      *     
                        INITIALIZE                   SYUMEI-REC
                        MOVE SPA-HOSPID          TO  SMEI-HOSPID
      ******************MOVE SPA-NYUGAIKBN       TO  SMEI-NYUGAIKBN
                        MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                                 TO  SMEI-NYUGAIKBN
                        MOVE SPA-GMN-PTID        TO  SMEI-PTID
                        MOVE SPA-GMN-TDENPNUM (SPA-GMN-SELBAN)
                                                 TO  SMEI-DENPNUM
                        MOVE SYUMEI-REC          TO  MCPDATA-REC
                        MOVE "DBSELECT"          TO  MCP-FUNC
                        MOVE "SYUMEI-KEY2"       TO  ORC-DBPATH
                        CALL "ORCMCPSUB"          USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
                        IF      MCP-RC              =    ZERO
                           MOVE    "SYUMEI-KEY2"    TO   ORC-DBPATH
                           PERFORM 900-SYUMEI-READ-SEC
                        ELSE
                           MOVE    1                TO  FLG-SYUMEI
                        END-IF
                        PERFORM VARYING IDX FROM 1  BY 1
                          UNTIL   (FLG-SYUMEI   =      1)
                                  MOVE "SYUMEI-KEY2" TO ORC-DBPATH
                                  PERFORM   900-SYUMEI-READ-SEC
                        END-PERFORM
                        MOVE    "DBCLOSE"           TO  MCP-FUNC
                        MOVE    "SYUMEI-KEY2"       TO  ORC-DBPATH
                        CALL    "ORCMCPSUB"          USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                        PERFORM    4301-SMEI-SAKUSEI-SEC
                   END-IF
           END-IF
     *
           IF      SPA-ERRCD            =   SPACE
     **********PERFORM    310-SPA-SET-SEC
               PERFORM 300-SYUNOU-HENSYU-SEC
               MOVE    1                   TO  SPA-GMN-CUR
           END-IF
           .
       430-TORIKESI-EXT.
           EXIT.
      *
      **************************************************************
      *    請求取消処理（収納明細レコード作成）
      **************************************************************
       4301-SMEI-SAKUSEI-SEC           SECTION.
      *
           MOVE    SPACE               TO  SYUMEI-REC
           INITIALIZE                      SYUMEI-REC
           MOVE    SPA-HOSPID          TO  SMEI-HOSPID
      *****MOVE    SPA-NYUGAIKBN       TO  SMEI-NYUGAIKBN
           MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                       TO  SMEI-NYUGAIKBN
           MOVE    SPA-GMN-PTID        TO  SMEI-PTID
      *伝票番号
           MOVE    SPA-GMN-TDENPNUM (SPA-GMN-SELBAN)
                                       TO  SMEI-DENPNUM
      *伝票番号枝番
           MOVE    IDX                 TO  SMEI-DENPEDANUM
      *入金連番
           MOVE    ZERO                TO  SMEI-NYUKINRENNUM
      *伝票状態区分
           MOVE    SPACE               TO  SMEI-MEISAIJOUTAIKBN
      *請求発行日（発行日の西暦）
           MOVE    SPACE               TO  SMEI-SKYPRINTYMD
      *請求再発行日
           MOVE    SPACE               TO  SMEI-SKYREPRINTYMD
      *領収書発行日
           MOVE    SPACE               TO  SMEI-RYOSYUPRINTYMD
      *領収書再発行日
           MOVE    SPACE               TO  SMEI-RYOSYUREPRINTYMD
      *請求金額
           IF  SPA-GMN-TSEIKYU(SPA-GMN-SELBAN)   NOT =   ZERO
            COMPUTE SMEI-SKYMONEY = SPA-GMN-TSEIKYU(SPA-GMN-SELBAN)
                                               *  -1
           END-IF
      *入返金区分
           MOVE    SPACE               TO  SMEI-NYUHEN-KBN
      *入返金額
           MOVE    ZERO                TO  SMEI-NYUHEN-MONEY
      *入返金日
           MOVE    SPA-SYSYMD          TO  SMEI-NYUHEN-YMD
      *入金方法
           MOVE    "00"                TO  SMEI-NYUKIN-HOHO
      *状態区分
           MOVE    "5"                 TO  SMEI-JOUTAIKBN
      *
           MOVE    SYUMEI-REC          TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "SYUMEI-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF      MCP-RC          NOT =   ZERO
               MOVE    "1001"              TO  SPA-ERRCD
           END-IF
           .
       4301-SMEI-SAKUSEI-EXT.
           EXIT.
      *
      *
      **************************************************************
      *    再計算処理
      **************************************************************
       440-SAIKEI-SEC           SECTION.
      *
           IF      SPA-GMN-SELBAN      =   ZERO
               GO      TO      440-SAIKEI-EXT
           END-IF
      *
           MOVE    "03"                TO  WRK-SYORINO
      *
      *    共通パラメタ更新・画面遷移
      *    PERFORM 4901-PARA-HEN-SEC
      *
      *------------------------------------------------------------
      *    診療日に該当する診療会計マスタ・診療行為マスタを検索し
      *    患者負担算定サブの必要項目をセットする
      *------------------------------------------------------------
      *
           MOVE     SPACE      TO      LNK-ORCS01-REC
           INITIALIZE                  LNK-ORCS01-REC
           MOVE    ZERO                TO  IDY
      *
      *    収納マスタを読み込み診療日の再取込み
           INITIALIZE                      SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
      *****MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                       TO  SYU-NYUGAIKBN
           MOVE    SPA-GMN-PTID        TO  SYU-PTID
           MOVE    SPA-GMN-TDENPNUM (SPA-GMN-SELBAN)
                                       TO  SYU-DENPNUM
           PERFORM 900-SYUNOU-READ-SEC
      *                                 
           IF      FLG-SYUNOU          =   1
                   MOVE   SPACE        TO  WRK-SAIKEISAN-YMD
                   MOVE   ZERO         TO  WRK-MAE-SEIKYUGK
           ELSE
                   MOVE   SYU-SRYYMD   TO  WRK-SAIKEISAN-YMD
                   MOVE   SYU-SKYMONEY TO  WRK-MAE-SEIKYUGK
           END-IF
           IF      SYU-DENPJTIKBN      =   "3"
                   MOVE    "0005"      TO  SPA-ERRCD
                   GO       TO             440-SAIKEI-EXT
           END-IF
      *
           MOVE    SPA-HOSPID          TO  JYURRK-HOSPID
           MOVE    SPA-GMN-PTID        TO  JYURRK-PTID
           MOVE    SPA-GMN-SRYKA       TO  JYURRK-SRYKA
           MOVE    SYU-SRYYMD          TO  JYURRK-SRYYMD
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "JYURRK-KEY4"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE      2       TO     SAI-IDX
               MOVE    "JYURRK-KEY4"   TO  ORC-DBPATH
               PERFORM   960-JYURRK-READ-SEC
               PERFORM   UNTIL   (FLG-JYURRK   =   1)    OR
                                 (JYURRK-DENPNUM = SYU-DENPNUM)
                   ADD   1       TO     SAI-IDX
                   MOVE    "JYURRK-KEY4"       TO  ORC-DBPATH
                   PERFORM   960-JYURRK-READ-SEC
               END-PERFORM
           END-IF
      *    取り込んだ診療日から該当患者の診療会計マスタを検索し
      *    診療区分と剤番号を剤番号テーブルに退避する
      *   （保険組合せが同じデータに限る）
           MOVE    ZERO                TO  FLG-SINKAI
           INITIALIZE                      SRYACCT-REC
           MOVE    SPA-HOSPID          TO  ACCT-HOSPID
      *****MOVE    SPA-NYUGAIKBN       TO  ACCT-NYUGAIKBN
           MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                       TO  ACCT-NYUGAIKBN
           MOVE    SPA-GMN-PTID        TO  ACCT-PTID
           MOVE    SPA-GMN-SRYKA       TO  ACCT-SRYKA
           MOVE    SYU-SRYYMD (1:6)    TO  ACCT-SRYYM
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACCT-KEY2"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACCT-KEY2"  TO  ORC-DBPATH
               PERFORM SINKAI-NEXT-SEC
           ELSE
               MOVE    1               TO      FLG-SINKAI
           END-IF
           MOVE    1                   TO      IDX
           MOVE    SPACE               TO      ZAIBAN-TABLE
           INITIALIZE                          ZAIBAN-TABLE
           MOVE    SPACE               TO      HKNTEKGAI-TABLE
           INITIALIZE                          HKNTEKGAI-TABLE
           MOVE    SPACE               TO      JIHI-TABLE
           INITIALIZE                          JIHI-TABLE
      *
           MOVE     ZERO               TO      WK-RSISHOSHIN            010112
                                               WK-RSISAISHIN            010112
                                               WK-RSISDO                010112
                                               WK-RSIETC                010112
                                               WK-SYUTEN-KEI            010112
      *
           PERFORM      4401-SINKAI-SET-SEC
               UNTIL   (FLG-SINKAI     =       1      ) OR
                       (IDX            >       100    )
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYACCT-KEY2"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      * 剤番号テーブルに退避した内容から収納マスタのレイアウトに点数を
      * 再セットする（薬剤一部負担金の計算領域もセット）
           MOVE           SPACE               TO    SYU-SKY-NAIYOU
           INITIALIZE                               SYU-SKY-NAIYOU
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       5
               MOVE           ZERO         TO    SYU-JIHI-TAXNASI(IDX)
               MOVE           ZERO         TO    SYU-JIHI-TAXARI (IDX)
           END-PERFORM    
           MOVE           ZERO                TO    SYU-JIHI-TOTAL
                                                    SYU-JIHI-TOTAL-TAX
                                                    SYU-JIHI-TAX
                                                    SYU-RJN-FTN
                                                    SYU-KOH-FTN
                                                    SYU-YKZ-FTN
                                                    SYU-HKNTEKMONEY
                                                    SYU-SKYMONEY
      *----(01.00.03) LINE ADD START -------------------------------
           MOVE           ZERO                TO    WRK-TYK-HKNTEN
      *----(01.00.03) LINE ADD END   -------------------------------
           PERFORM        VARYING      IDX    FROM    1    BY    1
                   UNTIL       (TBL-SRYKBN(IDX)   =   SPACE)    OR
                               (IDX               >   100)
               EVALUATE    TBL-SRYKBN  (IDX)
      *            診療
                   WHEN    "11"
                   WHEN    "12"
                    COMPUTE SYU-HKNTEN (01) =  SYU-HKNTEN (01)  +
                           (TBL-ZAITEN (IDX) *   TBL-ZAIKAISU (IDX))
      *            指導
                   WHEN    "13"
                    COMPUTE SYU-HKNTEN (02) =  SYU-HKNTEN (02)  +
                          (TBL-ZAITEN (IDX)  *   TBL-ZAIKAISU (IDX))
      *            在宅
                   WHEN    "14"
                    COMPUTE SYU-HKNTEN (03) =  SYU-HKNTEN (03)  +
                          (TBL-ZAITEN (IDX)  *   TBL-ZAIKAISU (IDX))
      *            投薬
                   WHEN    "21"   THRU  "27"
      *----(01.00.03) LINE MOD START -------------------------------
      *             COMPUTE SYU-HKNTEN (04) =  SYU-HKNTEN (04)  +
      *                   (TBL-ZAITEN (IDX)  *   TBL-ZAIKAISU (IDX))
                    COMPUTE WRK-TYK-HKNTEN  =  WRK-TYK-HKNTEN   +
                          (TBL-ZAITEN (IDX)  *   TBL-ZAIKAISU (IDX))
      *----(01.00.03) LINE MOD END   -------------------------------
      *            注射
                   WHEN    "31"
                   WHEN    "32"
                   WHEN    "33"
                    COMPUTE SYU-HKNTEN (05) =  SYU-HKNTEN (05)  +
                          (TBL-ZAITEN (IDX)  *   TBL-ZAIKAISU (IDX))
      *            処置
                   WHEN    "40"
                    COMPUTE SYU-HKNTEN (06)   =  SYU-HKNTEN (06)  +
                          (TBL-ZAITEN (IDX)  *   TBL-ZAIKAISU (IDX))
      *            手術
                   WHEN    "50"
                   WHEN    "54"
                    COMPUTE SYU-HKNTEN (07)   =  SYU-HKNTEN (07)  +
                          (TBL-ZAITEN (IDX)  *   TBL-ZAIKAISU (IDX))
      *            検査
                   WHEN    "60"
                    COMPUTE SYU-HKNTEN (08)   =  SYU-HKNTEN (08)  +
                          (TBL-ZAITEN (IDX)  *   TBL-ZAIKAISU (IDX))
      *            Ｘ線
                   WHEN    "70"
                    COMPUTE SYU-HKNTEN (09)   =  SYU-HKNTEN (09)  +
                          (TBL-ZAITEN (IDX)  *   TBL-ZAIKAISU (IDX))
      *            その他
                   WHEN    "80"
                    COMPUTE SYU-HKNTEN (10)   =  SYU-HKNTEN (10)  +
                          (TBL-ZAITEN (IDX)  *   TBL-ZAIKAISU (IDX))
               END-EVALUATE
               IF  TBL-SRYKBN(IDX)       =   "21"   OR  "22"  OR  "23"
                   MOVE    SPA-HOSPID         TO   SRY-HOSPID
      *************MOVE    SPA-NYUGAIKBN      TO   SRY-NYUGAIKBN
                   MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                              TO   SRY-NYUGAIKBN
                   MOVE    SPA-GMN-PTID       TO   SRY-PTID
                   MOVE    SPA-GMN-SRYKA      TO   SRY-SRYKA
                   MOVE    WRK-SAIKEISAN-YMD(1:6)
                                              TO   SRY-SRYYM
                   MOVE    TBL-ZAIBAN(IDX)    TO   SRY-ZAINUM
                   MOVE    SRYACT-REC         TO   MCPDATA-REC
                   MOVE    "DBSELECT"         TO   MCP-FUNC
                   MOVE    "SRYACT-KEY2"      TO   ORC-DBPATH
                   CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                   IF      MCP-RC             =    ZERO
                     MOVE    "SRYACT-KEY2"    TO   ORC-DBPATH
                     PERFORM SINKOU-READ-SEC
                   ELSE
                     MOVE    1                    TO  FLG-SINKOU
                   END-IF
      *----(01.00.04) LINE MOD START -------------------------------
      *            IF      FLG-SINKOU          =   SPACE
                   IF      FLG-SINKOU          =   ZERO
      *----(01.00.04) LINE MOD END   -------------------------------
                       PERFORM  UNTIL
                           (FLG-SINKOU         =  1)              OR
                           (SPA-HOSPID     NOT = SRY-HOSPID)      OR
      *********************(SPA-NYUGAIKBN  NOT = SRY-NYUGAIKBN) OR
                           (SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                           NOT = SRY-NYUGAIKBN) OR 
                           (SPA-GMN-PTID   NOT = SRY-PTID)        OR
                           (SPA-GMN-SRYKA  NOT = SRY-SRYKA)       OR
                           (TBL-SRYKBN(IDX)   NOT = SRY-SRYKBN) OR
                           (TBL-ZAIBAN(IDX)   NOT = SRY-ZAINUM)
      *                    薬剤セット
      *----(01.00.05) LINE MOD START -------------------------------
      ***                  PERFORM    4402-YAKUZAI-SET-SEC
                           EVALUATE   SYU-INGAISHOHOKBN
                               WHEN   "0"
                                   EVALUATE   SRY-SRYSYUKBN
                                       WHEN   "210"
                                       WHEN   "220"
                                       WHEN   "230"
                                       WHEN   "290"
                                       WHEN   "211"
                                       WHEN   "221"
                                       WHEN   "231"
                                       WHEN   "291"
                                       WHEN   "   "
                                          PERFORM  4402-YAKUZAI-SET-SEC
                                   END-EVALUATE       
                               WHEN   "1"
                                   EVALUATE   SRY-SRYSYUKBN
                                       WHEN   "211"
                                       WHEN   "221"
                                       WHEN   "231"
                                       WHEN   "291"
                                          PERFORM  4402-YAKUZAI-SET-SEC
                                   END-EVALUATE       
                           END-EVALUATE
      *----(01.00.05) LINE MOD END   -------------------------------
                           MOVE   "SRYACT-KEY2"  TO  MCP-FUNC
                           PERFORM    SINKOU-READ-SEC
                       END-PERFORM
                   END-IF
               END-IF
      *----(01.00.07) LINE ADD START -------------------------------
               IF  TBL-SRYKBN(IDX)       =   "95"   OR  "96"
                   MOVE    SPA-HOSPID         TO   SRY-HOSPID
      *************MOVE    SPA-NYUGAIKBN      TO   SRY-NYUGAIKBN
                   MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                              TO   SRY-NYUGAIKBN
                   MOVE    SPA-GMN-PTID       TO   SRY-PTID
                   MOVE    SPA-GMN-SRYKA      TO   SRY-SRYKA
                   MOVE    WRK-SAIKEISAN-YMD(1:6)
                                              TO   SRY-SRYYM
                   MOVE    TBL-ZAIBAN(IDX)    TO   SRY-ZAINUM
                   MOVE    SRYACT-REC         TO   MCPDATA-REC
                   MOVE    "DBSELECT"         TO   MCP-FUNC
                   MOVE    "SRYACT-KEY2"      TO   ORC-DBPATH
                   CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                   IF      MCP-RC             =    ZERO
                     MOVE    "SRYACT-KEY2"    TO   ORC-DBPATH
                     PERFORM SINKOU-READ-SEC
                   ELSE
                     MOVE    1                    TO  FLG-SINKOU
                   END-IF
                   IF      FLG-SINKOU          =   ZERO
                       PERFORM  UNTIL
                           (FLG-SINKOU       =  1)              OR
                           (SPA-HOSPID   NOT = SRY-HOSPID)      OR
      *********************(SPA-NYUGAIKBN  NOT = SRY-NYUGAIKBN) OR
                           (SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                           NOT = SRY-NYUGAIKBN) OR 
                           (SPA-GMN-PTID     NOT = SRY-PTID)        OR
                           (SPA-GMN-SRYKA    NOT = SRY-SRYKA)       OR
                           (TBL-SRYKBN(IDX)   NOT = SRY-SRYKBN) OR
                           (TBL-ZAIBAN(IDX)   NOT = SRY-ZAINUM)
      *                    保険適用外金額セット
                           PERFORM    4404-HKNTEKGAI-TBL-SEC
                           MOVE   "SRYACT-KEY2"  TO  MCP-FUNC
                           PERFORM    SINKOU-READ-SEC
                       END-PERFORM
                   END-IF
               END-IF
      *
               IF  SYU-SYUHKNNUM       =   "973"                        010112
                 IF  TBL-SRYKBN(IDX)       =   "95"   OR  "96"          010112
                   CONTINUE                                             010112
                 ELSE                                                   010112
                   MOVE    SPA-HOSPID         TO   SRY-HOSPID           010112
      *************MOVE    SPA-NYUGAIKBN      TO   SRY-NYUGAIKBN        010112
                   MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                              TO   SRY-NYUGAIKBN
                   MOVE    SPA-GMN-PTID       TO   SRY-PTID             010112
                   MOVE    SPA-GMN-SRYKA      TO   SRY-SRYKA            010112
                   MOVE    WRK-SAIKEISAN-YMD(1:6)                       010112
                                              TO   SRY-SRYYM            010112
                   MOVE    TBL-ZAIBAN(IDX)    TO   SRY-ZAINUM           010112
                   MOVE    SRYACT-REC         TO   MCPDATA-REC          010112
                   MOVE    "DBSELECT"         TO   MCP-FUNC             010112
                   MOVE    "SRYACT-KEY2"      TO   ORC-DBPATH           010112
                   CALL    "ORCMCPSUB"         USING                    010112
                                               MCPAREA                  010112
                                               ORCMCPAREA               010112
                                               MCPDATA-REC              010112
                   IF      MCP-RC             =    ZERO                 010112
                     MOVE    "SRYACT-KEY2"    TO   ORC-DBPATH           010112
                     PERFORM SINKOU-READ-SEC                            010112
                   ELSE                                                 010112 
                     MOVE    1                    TO  FLG-SINKOU        010112
                   END-IF                                               010112
                   IF      FLG-SINKOU          =   ZERO                 010112
                       PERFORM  UNTIL                                   010112
                           (FLG-SINKOU       =  1)              OR      010112
                           (SPA-HOSPID   NOT = SRY-HOSPID)      OR      010112
      *********************(SPA-NYUGAIKBN  NOT = SRY-NYUGAIKBN) OR      010112 
                           (SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                           NOT = SRY-NYUGAIKBN) OR 
                           (SPA-GMN-PTID     NOT = SRY-PTID)        OR  010112
                           (SPA-GMN-SRYKA    NOT = SRY-SRYKA)       OR  010112
                           (TBL-SRYKBN(IDX)   NOT = SRY-SRYKBN) OR      010112
                           (TBL-ZAIBAN(IDX)   NOT = SRY-ZAINUM)         010112
      *                    手技点計算
                           PERFORM    4406-SYUTEN-KEISAN-SEC            010112
                           MOVE   "SRYACT-KEY2"  TO  MCP-FUNC           010112
                           PERFORM    SINKOU-READ-SEC                   010112
                       END-PERFORM                                      010112
                   END-IF                                               010112
                 END-IF                                                 010112
               END-IF                                                   010112
      *----(01.00.07) LINE ADD END   -------------------------------
               MOVE    "DBCLOSE"           TO  MCP-FUNC
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           END-PERFORM
      *----(01.00.07) LINE ADD START -------------------------------
      *    労災保険処理
           IF  SYU-SYUHKNNUM       =   "971"                            010112
             IF      SYU-RSISHOSHIN-MONEY     NOT =    ZERO
                   MOVE    ZERO           TO  WK-RSISHOSHIN-TENSU
                   COMPUTE WK-RSISHOSHIN-TENSU  =  SYU-RSISHOSHIN-MONEY
                                                   / 10
                   COMPUTE SYU-HKNTEN (01)      =  SYU-HKNTEN (01)   -
                                                   WK-RSISHOSHIN-TENSU
             END-IF
             IF      SYU-RSISAISHIN-MONEY     NOT =    ZERO
                   MOVE    ZERO           TO  WK-RSISAISHIN-TENSU
                   COMPUTE WK-RSISAISHIN-TENSU  =  SYU-RSISAISHIN-MONEY
                                                    / 10
                   COMPUTE SYU-HKNTEN (01)      =  SYU-HKNTEN (01)   -
                                                   WK-RSISAISHIN-TENSU
             END-IF
             IF      SYU-RSISDO-MONEY       NOT =    ZERO
                   MOVE    ZERO           TO  WK-RSISDO-TENSU
                   COMPUTE WK-RSISDO-TENSU   =   SYU-RSISDO-MONEY / 10
                   COMPUTE SYU-HKNTEN (02)   =   SYU-HKNTEN (02)   -
                                              WK-RSISDO-TENSU
             END-IF
             IF      SYU-RSIETC-MONEY       NOT =    ZERO
                   MOVE    ZERO           TO  WK-RSIETC-TENSU
                   COMPUTE WK-RSIETC-TENSU   =   SYU-RSIETC-MONEY / 10
                   COMPUTE SYU-HKNTEN (10)   =   SYU-HKNTEN (10)   -
                                                 WK-RSIETC-TENSU
             END-IF
           END-IF                                                       010112
      *    自賠責保険処理
           IF  SYU-SYUHKNNUM       =   "973"                            010112
             COMPUTE  SYU-RSISHOSHIN-MONEY  =  WK-RSISHOSHIN     * 10   010112
             IF      SYU-RSISHOSHIN-MONEY     NOT =    ZERO             010112
                   MOVE    ZERO           TO  WK-RSISHOSHIN-TENSU       010112
                   COMPUTE WK-RSISHOSHIN-TENSU  =  SYU-RSISHOSHIN-MONEY 010112
                                                   / 10                 010112
                   COMPUTE SYU-HKNTEN (01)      =  SYU-HKNTEN (01)   -  010112
                                                   WK-RSISHOSHIN-TENSU  010112
             END-IF                                                     010112
             COMPUTE  SYU-RSISAISHIN-MONEY  =  WK-RSISAISHIN     * 10   010112
             IF      SYU-RSISAISHIN-MONEY     NOT =    ZERO             010112
                   MOVE    ZERO           TO  WK-RSISAISHIN-TENSU       010112
                   COMPUTE WK-RSISAISHIN-TENSU  =  SYU-RSISAISHIN-MONEY 010112
                                                    / 10                010112
                   COMPUTE SYU-HKNTEN (01)      =  SYU-HKNTEN (01)   -  010112
                                                   WK-RSISAISHIN-TENSU  010112
             END-IF                                                     010112
             IF      SYU-RSISDO-MONEY       NOT =    ZERO               010112
                   MOVE    ZERO           TO  WK-RSISDO-TENSU           010112
                   COMPUTE WK-RSISDO-TENSU   =   SYU-RSISDO-MONEY / 10  010112
                   COMPUTE SYU-HKNTEN (02)   =   SYU-HKNTEN (02)   -    010112
                                              WK-RSISDO-TENSU           010112
             END-IF                                                     010112
             IF      SYU-RSIETC-MONEY       NOT =    ZERO               010112
                   MOVE    ZERO           TO  WK-RSIETC-TENSU           010112
                   COMPUTE WK-RSIETC-TENSU   =   SYU-RSIETC-MONEY / 10  010112
                   COMPUTE SYU-HKNTEN (10)   =   SYU-HKNTEN (10)   -    010112
                                                 WK-RSIETC-TENSU        010112
             END-IF                                                     010112
      *
             COMPUTE   LNK-S01-SYUTEN  =   WK-SYUTEN-KEI                010112
                                       -   WK-RSISHOSHIN                010112
                                       -   WK-RSISAISHIN                010112
                                       -   WK-RSISDO                    010112
                                       -   WK-RSIETC                    010112
           END-IF                                                       010112
      *----(01.00.03) LINE ADD END -------------------------------
      *
      *----(01.00.03) LINE ADD START -------------------------------
           MOVE    WRK-TYK-HKNTEN      TO  SYU-HKNTEN (04)
      *----(01.00.03) LINE ADD END -------------------------------
      *----(01.00.07) LINE ADD START -------------------------------
      *    保険適用外金額の集計テーブルから収納テーブルへのセット
           PERFORM    4405-HKNTEKGAI-SET-SEC
      *----(01.00.07) LINE ADD END   -------------------------------
      *
      *    患者負担額計算処理
           MOVE    "1"                 TO  LNK-S01-SAIKEISAN-KBN
           MOVE    SYU-DENPNUM         TO  LNK-S01-SAIKEISAN-DENPYO
           MOVE    SYUNOU-REC          TO      LNK-SYUNOU-REC
      *    CALL    "ORCS01NEW"         USING   MCPAREA
           CALL    "ORCS01"            USING   MCPAREA
                                               LNK-ORCS01-REC
                                               LNK-SYUNOU-REC
           MOVE    LNK-SYUNOU-REC      TO      SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
      *****MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                       TO  SYU-NYUGAIKBN
           MOVE    SPA-GMN-PTID            TO  SYU-PTID
           MOVE    SPA-GMN-TDENPNUM (SPA-GMN-SELBAN)
                                       TO  SYU-DENPNUM
           PERFORM 900-SYUNOU-READ-SEC
      *                                 
           MOVE    LNK-SYUNOU-REC      TO      SYUNOU-REC
           MOVE    SYU-SKYMONEY        TO      WRK-ATO-SEIKYUGK
      *    伝票状態区分の再セット
           IF      SYU-SKYMONEY        =       ZERO
                   MOVE    SPACE       TO      SYU-DENPJTIKBN
           ELSE
               IF      SYU-SKYMONEY    >       SYU-NYUKIN-TOTAL
                       MOVE    "2"         TO      SYU-DENPJTIKBN
               ELSE    
                       MOVE    "1"         TO      SYU-DENPJTIKBN
               END-IF
           END-IF
      *    収納マスタの更新
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    再計算分の収納明細マスタ作成
           INITIALIZE                      SYUMEI-REC
           MOVE    SPA-HOSPID          TO  SMEI-HOSPID
      *****MOVE    SPA-NYUGAIKBN       TO  SMEI-NYUGAIKBN
           MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                       TO  SMEI-NYUGAIKBN
           MOVE    SPA-GMN-PTID            TO  SMEI-PTID
           MOVE    SPA-GMN-TDENPNUM (SPA-GMN-SELBAN)
                                       TO  SMEI-DENPNUM
           MOVE    SYUMEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUMEI-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =    ZERO
                 MOVE    "SYUMEI-KEY2"      TO  ORC-DBPATH
                 PERFORM 900-SYUMEI-READ-SEC
           ELSE
                 MOVE    1                    TO  FLG-SYUMEI
           END-IF
           IF      FLG-SYUMEI    =     1
                 CONTINUE
           ELSE
                 PERFORM   VARYING  IDX  FROM   1  BY   1
                     UNTIL (FLG-SYUMEI   =      1 )
                            MOVE      "SYUMEI-KEY2"  TO  ORC-DBPATH
                            PERFORM   900-SYUMEI-READ-SEC
                 END-PERFORM
                 PERFORM    4403-SMEI-SAKUSEI-SEC
                 MOVE    "DBCLOSE"           TO  MCP-FUNC
                 MOVE    "SYUMEI-KEY2"       TO  ORC-DBPATH
                 CALL    "ORCMCPSUB"          USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
           END-IF
      *     
      *****PERFORM    310-SPA-SET-SEC.
           PERFORM 300-SYUNOU-HENSYU-SEC
           MOVE    1                   TO  SPA-GMN-CUR
           .
       440-SAIKEI-EXT.
           EXIT.
      *
      **************************************************************
      *    診療会計マスタの取込み
      **************************************************************
       4401-SINKAI-SET-SEC           SECTION.
      *
           IF    (ACCT-ZAITEN            NOT = ZERO  )           AND
                 (ACCT-SRYYM(1:6)    =   WRK-SAIKEISAN-YMD(1:6)) AND
                 (ACCT-HKNCOMBI      =  SYU-HKNCOMBINUM)         AND
                 (ACCT-DAY(SAI-IDX WRK-SAIKEISAN-DD)  NOT = ZERO)
      *
             MOVE    ACCT-SRYKBN   TO  TBL-SRYKBN(IDX)
             MOVE    ACCT-ZAINUM   TO  TBL-ZAIBAN(IDX)
             MOVE    ACCT-DAY(SAI-IDX WRK-SAIKEISAN-DD)
                                   TO  TBL-ZAIKAISU(IDX)
      *----(01.00.03) LINE MOD START -------------------------------
      *      MOVE    ACCT-ZAITEN   TO  TBL-ZAITEN(IDX)
             IF     (ACCT-SRYCDTOTAL   =    630010002)   AND
                    (ACCT-MEISAISU     =    1)
                 COMPUTE   TBL-ZAITEN(IDX)  =  TBL-ZAITEN(IDX) +
                                              (ACCT-ZAITEN * -1)
             ELSE
                 MOVE  ACCT-ZAITEN   TO  TBL-ZAITEN(IDX)
             END-IF 
             IF   (   ACCT-SRYKBN       =   "95"  OR  "96"   )          010112
             OR   ((  ACCT-SRYCDTOTAL   =    630010002      )  AND      010112
                   (  ACCT-MEISAISU     =    1              ))          010112
                CONTINUE                                                010112
             ELSE                                                       010112 
                MOVE   ACCT-SYUTEN1  TO  TBL-SYUTEN(IDX)                010112
             END-IF                                                     010112
      *----(01.00.03) LINE MOD END   -------------------------------
             ADD     1             TO  IDX
      * 
           END-IF
           MOVE    "SRYACCT-KEY2"         TO  ORC-DBPATH
           PERFORM SINKAI-NEXT-SEC
           .
       4401-SINKAI-SET-EXT.
           EXIT.
      *
      **************************************************************
      *    薬剤コードのセット
      **************************************************************
       4402-YAKUZAI-SET-SEC           SECTION.
      *
           PERFORM     VARYING    IDZ    FROM    1     BY    1
                         UNTIL   (IDZ              >   5    )    OR
                                 (SRY-SRYCD(IDZ)   =   SPACE)
      *----(01.00.02) LINE MOD START -------------------------------
      *        MOVE    SRY-SRYKBN          TO  LNK-S01-SRYKBN (1 IDY)
      *        MOVE    SRY-ZAINUM          TO  LNK-S01-ZAIBAN (1 IDY)
      *        MOVE    SRY-SRYCD(IDZ)      TO  LNK-S01-SRYCD  (1 IDY)
      *        MOVE    SRY-SRYSURYO(IDZ)   TO  LNK-S01-SURYOU (1 IDY)
      *        MOVE    TBL-ZAIKAISU(IDX)   TO  LNK-S01-KAISUU (1 IDY)
      *        MOVE    TBL-ZAITEN(IDX)     TO  LNK-S01-TENSUU (1 IDY)
               IF     (SRY-AUTOKBN(IDZ)    =   SPACE)     AND
      *----(01.00.06) LINE ADD START -------------------------------
                      (SRY-SRYCD(IDZ)(1:1) =   "6"  )
      *----(01.00.06) LINE ADD END   -------------------------------
                   ADD     1              TO       IDY
                   MOVE    SRY-SRYKBN         TO  LNK-S01-SRYKBN(1 IDY)
                   MOVE    SRY-ZAINUM         TO  LNK-S01-ZAIBAN(1 IDY)
                   MOVE    SRY-SRYCD(IDZ)     TO  LNK-S01-SRYCD (1 IDY)
                   MOVE    SRY-SRYSURYO(IDZ)  TO  LNK-S01-SURYOU(1 IDY)
                   MOVE    TBL-ZAIKAISU(IDX)  TO  LNK-S01-KAISUU(1 IDY)
                   MOVE    TBL-ZAITEN(IDX)    TO  LNK-S01-TENSUU(1 IDY)
               END-IF
      *----(01.00.02) LINE MOD END   -------------------------------
           END-PERFORM
           .
       4402-YAKUZAI-SET-EXT.
           EXIT.
      *
      *************************************************************
      *    再計算処理（収納明細レコード作成）
      *************************************************************
       4403-SMEI-SAKUSEI-SEC           SECTION.
      *
           MOVE    SPACE               TO  SYUMEI-REC
           INITIALIZE                      SYUMEI-REC
           MOVE    SPA-HOSPID          TO  SMEI-HOSPID
      *****MOVE    SPA-NYUGAIKBN       TO  SMEI-NYUGAIKBN
           MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                       TO  SMEI-NYUGAIKBN
           MOVE    SPA-GMN-PTID        TO  SMEI-PTID
      *伝票番号
           MOVE    SPA-GMN-TDENPNUM (SPA-GMN-SELBAN)
                                       TO  SMEI-DENPNUM
      *伝票番号枝番
           MOVE    IDX                 TO  SMEI-DENPEDANUM
      *入金連番
           MOVE    ZERO                TO  SMEI-NYUKINRENNUM
      *伝票状態区分
           MOVE    SPACE               TO  SMEI-MEISAIJOUTAIKBN
      *請求発行日（発行日の西暦）
           MOVE    SPACE               TO  SMEI-SKYPRINTYMD
      *請求再発行日
           MOVE    SPACE               TO  SMEI-SKYREPRINTYMD
      *領収書発行日
           MOVE    SPACE               TO  SMEI-RYOSYUPRINTYMD
      *領収書再発行日
           MOVE    SPACE               TO  SMEI-RYOSYUREPRINTYMD
      *請求金額
           IF      WRK-ATO-SEIKYUGK    NOT =   WRK-MAE-SEIKYUGK
                   COMPUTE   SMEI-SKYMONEY =   WRK-ATO-SEIKYUGK   -
                                               WRK-MAE-SEIKYUGK
           ELSE
                   MOVE    ZERO        TO  SMEI-SKYMONEY
           END-IF
      *入返金区分
           MOVE    SPACE               TO  SMEI-NYUHEN-KBN
      *入返金額
           MOVE    ZERO                TO  SMEI-NYUHEN-MONEY
      *入返金日
           MOVE    SPA-SYSYMD          TO  SMEI-NYUHEN-YMD
      *入金方法
           MOVE    "00"                TO  SMEI-NYUKIN-HOHO
      *状態区分
           MOVE    "3"                 TO  SMEI-JOUTAIKBN
      *
           MOVE    SYUMEI-REC          TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "SYUMEI-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       4403-SMEI-SAKUSEI-EXT.
           EXIT.
      *
      **************************************************************
      *    保険適用外のテーブル領域セット
      **************************************************************
       4404-HKNTEKGAI-TBL-SEC          SECTION.
      *
           EVALUATE    SRY-SRYKBN
               WHEN    "95"
                   PERFORM     VARYING    IDZ    FROM    1     BY    1
                                 UNTIL   (IDZ         >   5    )   OR
       	                                  (SRY-SRYCD(IDZ)  =   SPACE)
                       IF    SRY-SRYCD (IDZ) (1:3)   =   "095"
                                                     OR  "096"
                           IF    SRY-SRYCD (IDZ) (4:2)    =   "00"
                                                     OR       "91"      010112
                                                     OR       "92"      010112
                                                     OR       "93"
                               MOVE    SPACE         TO   TNS-TENSU-REC
                               INITIALIZE                 TNS-TENSU-REC
                               MOVE    SRY-SRYCD(IDZ) TO   TNS-SRYCD
                               MOVE    WRK-SAIKEISAN-YMD TO  ORC-DBYMD
                               PERFORM    TENSU-READ-SEC
                               IF      MCP-RC         =    ZERO
                                   EVALUATE    TNS-GAITENTTLKBN
                                       WHEN    1
                                           ADD   SRY-JIHIMONEY(IDZ)
                                              TO   TBL-JIHI-TAXNASI(1)
                                       WHEN    2
                                           ADD   SRY-JIHIMONEY(IDZ)
                                              TO   TBL-JIHI-TAXNASI(2)
                                       WHEN    3
                                           ADD   SRY-JIHIMONEY(IDZ)
                                              TO   TBL-JIHI-TAXNASI(3)
                                       WHEN    4
                                           ADD   SRY-JIHIMONEY(IDZ)
                                              TO   TBL-JIHI-TAXNASI(4)
                                       WHEN    5
                                           ADD   SRY-JIHIMONEY(IDZ)
                                              TO   TBL-JIHI-TAXNASI(5)
                                   END-EVALUATE
                               END-IF
                           ELSE
                               EVALUATE   SRY-SRYCD (IDZ) (4:2)
                                   WHEN   "11"
                                   WHEN   "12"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(1)
                                   WHEN   "13"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(2)
                                   WHEN   "14"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(3)
                                   WHEN   "21"   THRU  "27"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(4)
                                   WHEN   "31"
                                   WHEN   "32"
                                   WHEN   "33"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(5)
                                   WHEN   "40"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(6)
                                   WHEN   "50"
                                   WHEN   "54"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(7)
                                   WHEN   "60"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(8)
                                   WHEN   "70"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(9)
                                   WHEN   "80"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(10)
                               END-EVALUATE
                           END-IF
                       ELSE
                           MOVE    SPACE          TO   TNS-TENSU-REC
                           INITIALIZE                  TNS-TENSU-REC
                           MOVE    SRY-SRYCD(IDZ) TO   TNS-SRYCD
                           MOVE    WRK-SAIKEISAN-YMD   TO   ORC-DBYMD
                           PERFORM    TENSU-READ-SEC
                           IF      MCP-RC         =    ZERO
                               EVALUATE   TNS-SRYKBN
                                   WHEN   "11"
                                   WHEN   "12"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(1)
                                   WHEN   "13"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(2)
                                   WHEN   "14"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(3)
                                   WHEN   "21"   THRU  "27"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(4)
                                   WHEN   "31"
                                   WHEN   "32"
                                   WHEN   "33"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(5)
                                   WHEN   "40"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(6)
                                   WHEN   "50"
                                   WHEN   "54"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(7)
                                   WHEN   "60"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(8)
                                   WHEN   "70"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(9)
                                   WHEN   "80"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(10)
                                   WHEN   OTHER
                                     IF   TNS-SRYCD(1:1)    =   "6"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(4)
                                     END-IF
                                     IF   TNS-SRYCD(1:1)    =   "7"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                   TO   TBL-TGMONEY(10)
                                     END-IF
                               END-EVALUATE
                           END-IF
                       END-IF
                   END-PERFORM
               WHEN    "96"
                   PERFORM     VARYING    IDZ    FROM   1    BY   1
                                 UNTIL   (IDZ        >   5    )   OR
                                         (SRY-SRYCD(IDZ)  =   SPACE)
                       IF    SRY-SRYCD (IDZ) (1:3)   =   "095"
                                                     OR  "096"
                           IF    SRY-SRYCD (IDZ) (4:2)    =   "00"
                                                     OR       "91"      010112
                                                     OR       "92"      010112
                                                     OR       "93"
                               MOVE    SPACE         TO   TNS-TENSU-REC
                               INITIALIZE                 TNS-TENSU-REC
                               MOVE    SRY-SRYCD(IDZ) TO   TNS-SRYCD
                               MOVE    WRK-SAIKEISAN-YMD TO  ORC-DBYMD
                               PERFORM    TENSU-READ-SEC
                               IF      MCP-RC         =    ZERO
                                   EVALUATE    TNS-GAITENTTLKBN
                                       WHEN    1
                                           ADD   SRY-JIHIMONEY(IDZ)
                                              TO   TBL-JIHI-TAXARI(1)
                                       WHEN    2
                                           ADD   SRY-JIHIMONEY(IDZ)
                                              TO   TBL-JIHI-TAXARI(2)
                                       WHEN    3
                                           ADD   SRY-JIHIMONEY(IDZ)
                                              TO   TBL-JIHI-TAXARI(3)
                                       WHEN    4
                                           ADD   SRY-JIHIMONEY(IDZ)
                                              TO   TBL-JIHI-TAXARI(4)
                                       WHEN    5
                                           ADD   SRY-JIHIMONEY(IDZ)
                                              TO   TBL-JIHI-TAXARI(5)
                                   END-EVALUATE
                               END-IF
                           ELSE
                               EVALUATE   SRY-SRYCD (IDZ) (4:2)
                                   WHEN   "11"
                                   WHEN   "12"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO  TBL-TGMONEY-TAX(1)
                                   WHEN   "13"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO  TBL-TGMONEY-TAX(2)
                                   WHEN   "14"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO  TBL-TGMONEY-TAX(3)
                                   WHEN   "21"   THRU  "27"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO  TBL-TGMONEY-TAX(4)
                                   WHEN   "31"
                                   WHEN   "32"
                                   WHEN   "33"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO  TBL-TGMONEY-TAX(5)
                                   WHEN   "40"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO  TBL-TGMONEY-TAX(6)
                                   WHEN   "50"
                                   WHEN   "54"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO  TBL-TGMONEY-TAX(7)
                                   WHEN   "60"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO  TBL-TGMONEY-TAX(8)
                                   WHEN   "70"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO  TBL-TGMONEY-TAX(9)
                                   WHEN   "80"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO TBL-TGMONEY-TAX(10)
                               END-EVALUATE
                           END-IF
                       ELSE
                           MOVE    SPACE          TO   TNS-TENSU-REC
                           INITIALIZE                  TNS-TENSU-REC
                           MOVE    SRY-SRYCD(IDZ) TO   TNS-SRYCD
                           MOVE    WRK-SAIKEISAN-YMD   TO   ORC-DBYMD
                           PERFORM    TENSU-READ-SEC
                           IF      MCP-RC         =    ZERO
                               EVALUATE   TNS-SRYKBN
                                   WHEN   "11"
                                   WHEN   "12"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO  TBL-TGMONEY-TAX(1)
                                   WHEN   "13"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO  TBL-TGMONEY-TAX(2)
                                   WHEN   "14"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO  TBL-TGMONEY-TAX(3)
                                   WHEN   "21"   THRU  "27"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO  TBL-TGMONEY-TAX(4)
                                   WHEN   "31"
                                   WHEN   "32"
                                   WHEN   "33"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO  TBL-TGMONEY-TAX(5)
                                   WHEN   "40"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO  TBL-TGMONEY-TAX(6)
                                   WHEN   "50"
                                   WHEN   "54"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO  TBL-TGMONEY-TAX(7)
                                   WHEN   "60"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO  TBL-TGMONEY-TAX(8)
                                   WHEN   "70"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO  TBL-TGMONEY-TAX(9)
                                   WHEN   "80"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                                 TO TBL-TGMONEY-TAX(10)
                                   WHEN   OTHER
                                     IF   TNS-SRYCD(1:1)    =   "6"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                               TO   TBL-TGMONEY-TAX(4)
                                     END-IF
                                     IF   TNS-SRYCD(1:1)    =   "7"
                                       ADD    SRY-JIHIMONEY(IDZ)
                                               TO   TBL-TGMONEY-TAX(10)
                                     END-IF
                               END-EVALUATE
                           END-IF
                       END-IF
                   END-PERFORM
           END-EVALUATE
           .
       4404-HKNTEKGAI-TBL-EXT.
           EXIT.
      *
      **************************************************************
      *    保険適用外金額の集計テーブルから収納テーブルへのセット
      **************************************************************
       4405-HKNTEKGAI-SET-SEC          SECTION.
      *
      *  保険適用外
           PERFORM     VARYING   IDZ    FROM   1    BY    1
                         UNTIL   IDZ    >      11
                  MOVE   TBL-TGMONEY(IDZ)      TO  SYU-TGMONEY(IDZ)
                  MOVE   TBL-TGMONEY-TAX(IDZ)  TO  SYU-TGMONEY-TAX(IDZ)
           END-PERFORM
      *
      *  自費１から５
           PERFORM     VARYING   IDZ    FROM    1    BY    1
                         UNTIL   IDZ    >       5
                  MOVE   TBL-JIHI-TAXNASI(IDZ) TO SYU-JIHI-TAXNASI(IDZ)
                  MOVE   TBL-JIHI-TAXARI(IDZ)  TO SYU-JIHI-TAXARI(IDZ)
           END-PERFORM
           .
       4405-HKNTEKGAI-SET-EXT.
           EXIT.
      *
      **************************************************************
      *    負担金額の手技点算出
      **************************************************************
       4406-SYUTEN-KEISAN-SEC          SECTION.
      *
           IF    SRY-RENNUM     =     1                                 010112
      *                                                                 010112
               ADD  TBL-SYUTEN(IDX)    TO  WK-SYUTEN-KEI                010112
      *                                                                 010112
           END-IF                                                       010112
      *                                                                 010112
           PERFORM   VARYING   IDXA   FROM   1   BY   1                 010112
                       UNTIL    (IDXA            >       5)  OR         010112
                                (SRY-SRYCD(IDXA) =   SPACE)             010112
      *                                                                 010112
                    MOVE    SPACE             TO   TNS-TENSU-REC        010112
                    INITIALIZE                     TNS-TENSU-REC        010112
                    MOVE    SRY-SRYCD(IDXA)   TO   TNS-SRYCD            010112
                    MOVE    WRK-SAIKEISAN-YMD TO   ORC-DBYMD            010112 
                    PERFORM    TENSU-READ-SEC                           010112
                    IF      MCP-RC         =    ZERO                    010112
      *                                                                 010112
                         COMPUTE  WRK-TEN     =   TNS-TEN  /  10        010112
      *                                                                 010112
                         IF   SRY-SRYCD(IDXA) =  "101110010"  OR        010112
                                                 "101110020"  OR        010112
                                                 "101110030"            010112
                           COMPUTE WK-RSISHOSHIN = WK-RSISHOSHIN +      010112
                                  (WRK-TEN  *   TBL-ZAIKAISU (IDX))     010112
                         END-IF                                         010112 
                         IF   SRY-SRYCD(IDXA) =  "101120030"  OR        010112
                                                 "101120040"  OR        010112
                                                 "101120050"  OR        010112
                                                 "101120060"            010112
                           COMPUTE WK-RSISAISHIN = WK-RSISAISHIN +      010112
                                  (WRK-TEN  *   TBL-ZAIKAISU (IDX))     010112
                         END-IF                                         010112
                         IF   SRY-SRYCD(IDXA) =  "101130010"  OR        010112
                                                 "101130020"  OR        010112
                                                 "101130030"  OR        010112
                                                 "101130040"  OR        010112
                                                 "101130050"  OR        010112
                                                 "101130060"  OR        010112
                                                 "101130070"  OR        010112
                                                 "101130080"  OR        010112
                                                 "101130090"  OR        010112
                                                 "101130100"            010112
                           COMPUTE WK-RSISDO = WK-RSISDO +              010112
                                  (WRK-TEN  *   TBL-ZAIKAISU (IDX))     010112
                         END-IF                                         010112
                         IF    SRY-SRYCD (IDXA)(1:5)   =   "09591"      010112
                                                     OR    "09592"      010112
                                                     OR    "09593"
                           COMPUTE WK-RSIETC = WK-RSIETC +              010112
                                  (WRK-TEN  *   TBL-ZAIKAISU (IDX))     010112
                         END-IF                                         010112
      *                                                                 010112
                    END-IF                                              010112
      *                                                                 010112
           END-PERFORM                                                  010112
           .                                                            010112
       4406-SYUTEN-KEISAN-EXT.
           EXIT.
      *
      **************************************************************
      *    返金処理
      **************************************************************
       450-HENKIN-SEC           SECTION.
      *
           IF      SPA-GMN-SELBAN      =   ZERO
               GO      TO      450-HENKIN-EXT
           END-IF
      *
           MOVE    "04"                TO  WRK-SYORINO
      *
      *    収納マスタの請求金額と入金合計額を比較して
      *    入金合計額が多ければ、収納マスタの入金合計額
      *    を請求金額と同じにして、収納明細マスタを作成する
      *
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
      *****MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                       TO  SYU-NYUGAIKBN
           MOVE    SPA-GMN-PTID        TO  SYU-PTID
           MOVE    SPA-GMN-TDENPNUM (SPA-GMN-SELBAN)
                                       TO  SYU-DENPNUM
           PERFORM 900-SYUNOU-READ-SEC                            
      *
           IF      FLG-SYUNOU          =   ZERO
             IF    SYU-SKYMONEY        <  SYU-NYUKIN-TOTAL
                MOVE    ZERO                TO    WRK-SAGAKU
                COMPUTE WRK-SAGAKU = SYU-SKYMONEY - SYU-NYUKIN-TOTAL
                MOVE    SYU-SKYMONEY        TO    SYU-NYUKIN-TOTAL
                MOVE    SYUNOU-REC          TO  MCPDATA-REC
                MOVE    "DBUPDATE"          TO  MCP-FUNC
                MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
                CALL    "ORCMCPSUB"          USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   MOVE    "1002"              TO  SPA-ERRCD
                   GO  TO  450-HENKIN-EXT
                END-IF     
      *
                INITIALIZE                      SYUMEI-REC
                MOVE    SPA-HOSPID          TO  SMEI-HOSPID
      **********MOVE    SPA-NYUGAIKBN       TO  SMEI-NYUGAIKBN
                MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                            TO  SMEI-NYUGAIKBN
                MOVE    SPA-GMN-PTID        TO  SMEI-PTID
                MOVE    SPA-GMN-TDENPNUM (SPA-GMN-SELBAN)
                                            TO  SMEI-DENPNUM
                MOVE    SYUMEI-REC          TO  MCPDATA-REC
                MOVE    "DBSELECT"          TO  MCP-FUNC
                MOVE    "SYUMEI-KEY2"       TO  ORC-DBPATH
                CALL    "ORCMCPSUB"          USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                IF      MCP-RC              =    ZERO
                    MOVE    "SYUMEI-KEY2"   TO   ORC-DBPATH
                    PERFORM 900-SYUMEI-READ-SEC
                ELSE
                    MOVE    1                    TO  FLG-SYUMEI
                END-IF
      *
                PERFORM   VARYING  IDX  FROM   1  BY   1
                    UNTIL  (FLG-SYUMEI   =      1)
                            MOVE   "SYUMEI-KEY2"  TO  ORC-DBPATH  
                            PERFORM   900-SYUMEI-READ-SEC
                END-PERFORM
      *
                MOVE    "DBCLOSE"           TO  MCP-FUNC
                MOVE    "SYUMEI-KEY2"       TO  ORC-DBPATH
                CALL    "ORCMCPSUB"          USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
      *
                PERFORM    4501-SMEI-SAKUSEI-SEC
             ELSE
                MOVE    "0004"     TO    SPA-ERRCD
             END-IF
           END-IF
     *
           IF      SPA-ERRCD          =   SPACE 
     ******    PERFORM    310-SPA-SET-SEC
               PERFORM 300-SYUNOU-HENSYU-SEC
               MOVE    1                   TO  SPA-GMN-CUR
           END-IF
           .
       450-HENKIN-EXT.
           EXIT.
      *
      *************************************************************
      *    返金処理（収納明細レコード作成）
      *************************************************************
       4501-SMEI-SAKUSEI-SEC           SECTION.
      *
           MOVE    SPACE               TO  SYUMEI-REC
           INITIALIZE                      SYUMEI-REC
           MOVE    SPA-HOSPID          TO  SMEI-HOSPID
      *****MOVE    SPA-NYUGAIKBN       TO  SMEI-NYUGAIKBN
           MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                       TO  SMEI-NYUGAIKBN
           MOVE    SPA-GMN-PTID        TO  SMEI-PTID
      *伝票番号
           MOVE    SPA-GMN-TDENPNUM (SPA-GMN-SELBAN) (1:7)
                                       TO  SMEI-DENPNUM
      *伝票番号枝番
           MOVE    IDX                 TO  SMEI-DENPEDANUM
      *入金連番
           MOVE    ZERO                TO  SMEI-NYUKINRENNUM
      *伝票状態区分
           MOVE    SPACE               TO  SMEI-MEISAIJOUTAIKBN
      *請求発行日（発行日の西暦）
           MOVE    SPACE               TO  SMEI-SKYPRINTYMD
      *請求再発行日
           MOVE    SPACE               TO  SMEI-SKYREPRINTYMD
      *領収書発行日
           MOVE    SPACE               TO  SMEI-RYOSYUPRINTYMD
      *領収書再発行日
           MOVE    SPACE               TO  SMEI-RYOSYUREPRINTYMD
      *請求金額
           MOVE    ZERO                TO  SMEI-SKYMONEY
      *入返金区分
           MOVE    "2"                 TO  SMEI-NYUHEN-KBN
      *入返金額
           MOVE    WRK-SAGAKU          TO  SMEI-NYUHEN-MONEY
      *入返金日
           MOVE    SPA-SYSYMD          TO  SMEI-NYUHEN-YMD
      *入金方法
           MOVE    "00"                TO  SMEI-NYUKIN-HOHO
      *状態区分
           MOVE    "4"                 TO  SMEI-JOUTAIKBN
      *
           MOVE    SYUMEI-REC          TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "SYUMEI-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               MOVE    "1001"              TO  SPA-ERRCD
           END-IF     
           .
       4501-SMEI-SAKUSEI-EXT.
           EXIT.
      *
      *************************************************************
      *    入金処理
      *************************************************************
       460-NYUKIN-SEC           SECTION.
      *
           IF      SPA-GMN-SELBAN      =   ZERO
               GO      TO      460-NYUKIN-EXT
           END-IF
      *
           MOVE    "05"                TO  WRK-SYORINO
      *
      *収納請求額のチェックを行う
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
      *****MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                       TO  SYU-NYUGAIKBN
           MOVE    SPA-GMN-PTID        TO  SYU-PTID
           MOVE    SPA-GMN-TDENPNUM (SPA-GMN-SELBAN) (1:7)
                                       TO  SYU-DENPNUM
           PERFORM 900-SYUNOU-READ-SEC
      *                                 
           IF      FLG-SYUNOU          =   1
                   CONTINUE
           ELSE
      *収納請求額がゼロの時はエラー
             IF    SYU-SKYMONEY        =  ZERO
                   MOVE    "0006"     TO    SPA-ERRCD
                   GO    TO    460-NYUKIN-EXT
             END-IF
      *収納請求額が収納入金額より少なければエラー
             IF    SYU-SKYMONEY        <= SYU-NYUKIN-TOTAL
                   MOVE    "0006"     TO    SPA-ERRCD
                   GO    TO    460-NYUKIN-EXT
             END-IF
           END-IF
      *
      *****MOVE    SPA-GMN-THKNCOMBI(SPA-GMN-SELBAN) TO
      *****                            SPA-HKNCOMBIMEI
      *****MOVE    SPA-GMN-TSRYKAMEI(SPA-GMN-SELBAN) TO
      *****                            SPA-SRYKAMEI
      *****MOVE    SPA-GMN-TDENPNUM(SPA-GMN-SELBAN)  TO
      *****                            SPA-S01-DENPNUM
      *
           INITIALIZE                  SPA-S01KYOUTU
           MOVE    "05"                TO  SPA-S01-SYORINO
           PERFORM 4901-SPAKYOTUKEY-SET-SEC
      *
           MOVE    "S02"               TO  SPA-MOTOPG
           MOVE    "S03"               TO  SPA-SAKIPG
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "S03    "            TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       460-NYUKIN-EXT.
           EXIT.
      *
      *************************************************************
      *    入金取消
      *************************************************************
       470-NYUDEL-SEC           SECTION.
      *
           IF      SPA-GMN-SELBAN      =   ZERO
               GO      TO      470-NYUDEL-EXT
           END-IF
      *
           MOVE    "06"                TO  WRK-SYORINO
      *
      *    収納マスタと収納明細の入金額を０円に変更する
      *
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
      *****MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                       TO  SYU-NYUGAIKBN
           MOVE    SPA-GMN-PTID        TO  SYU-PTID
           MOVE    SPA-GMN-TDENPNUM (SPA-GMN-SELBAN)
                                       TO  SYU-DENPNUM
           PERFORM 900-SYUNOU-READ-SEC
      *     
           IF      FLG-SYUNOU          =   1
                   CONTINUE
           ELSE
             IF (SYU-DENPJTIKBN =     SPACE  OR  "2"  OR  "3")   OR
                (SYU-NYUKIN-KAISU  NOT =        1      )
                  MOVE    "0002"     TO    SPA-ERRCD
             ELSE
                  MOVE    "2"        TO    SYU-DENPJTIKBN
                  MOVE    ZERO       TO    SYU-NYUKIN-TOTAL
                  MOVE    ZERO       TO    SYU-NYUKIN-KAISU
                  MOVE    SYUNOU-REC          TO  MCPDATA-REC
                  MOVE    "DBUPDATE"          TO  MCP-FUNC
                  MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
                  CALL    "ORCMCPSUB"          USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                  MOVE    SPA-HOSPID          TO  SMEI-HOSPID
      ************MOVE    SPA-NYUGAIKBN       TO  SMEI-NYUGAIKBN
                  MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                              TO  SMEI-NYUGAIKBN
                  MOVE    SPA-GMN-PTID        TO  SMEI-PTID
                  MOVE    SPA-GMN-TDENPNUM (SPA-GMN-SELBAN)
                                              TO  SMEI-DENPNUM
                  MOVE    1                   TO  SMEI-DENPEDANUM
                  MOVE    SYUMEI-REC          TO  MCPDATA-REC
                  MOVE    "DBSELECT"          TO  MCP-FUNC
                  MOVE    "SYUMEI-KEY"        TO  ORC-DBPATH
                  CALL    "ORCMCPSUB"          USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                  IF      MCP-RC              =    ZERO
                    MOVE    "SYUMEI-KEY"         TO  ORC-DBPATH
                    PERFORM 900-SYUMEI-READ-SEC
                  ELSE
                    MOVE    1                    TO  FLG-SYUMEI
                  END-IF
                  IF      FLG-SYUMEI    =     1
                      CONTINUE
                  ELSE
                      MOVE      SPACE    TO   SMEI-NYUHEN-KBN
                      MOVE      ZERO     TO   SMEI-NYUHEN-MONEY
      *>                MOVE      SPACE    TO   SMEI-NYUHEN-YMD
                      MOVE      SPA-SYSYMD TO   SMEI-NYUHEN-YMD
                      MOVE      SPACE    TO   SMEI-NYUKIN-HOHO
                      MOVE      "6"      TO   SMEI-JOUTAIKBN
                      MOVE    SYUMEI-REC      TO  MCPDATA-REC
                      MOVE    "DBUPDATE"      TO  MCP-FUNC
                      MOVE    "SYUMEI-KEY"    TO  ORC-DBPATH
                      CALL    "ORCMCPSUB"      USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                      MOVE    "DBCLOSE"       TO  MCP-FUNC
                      MOVE    "SYUMEI-KEY"    TO  ORC-DBPATH
                      CALL    "ORCMCPSUB"      USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                  END-IF
             END-IF
           END-IF
      *****PERFORM    310-SPA-SET-SEC.
           PERFORM 300-SYUNOU-HENSYU-SEC
           MOVE    1                   TO  SPA-GMN-CUR
           .
       470-NYUDEL-EXT.
           EXIT.
      *
      *************************************************************
      *    調整金
      *************************************************************
       480-CHOSEI-SEC           SECTION.
      *
           IF      SPA-GMN-SELBAN      =   ZERO
               GO      TO      480-CHOSEI-EXT
           END-IF
      *
           MOVE    "07"                TO  WRK-SYORINO
      *
      *****MOVE    SPA-GMN-THKNCOMBI(SPA-GMN-SELBAN) TO
      *****                            SPA-HKNCOMBIMEI
      *****MOVE    SPA-GMN-TSRYKAMEI(SPA-GMN-SELBAN) TO
      *****                            SPA-SRYKAMEI
      *****MOVE    SPA-GMN-TDENPNUM(SPA-GMN-SELBAN)  TO
      *****                            SPA-S01-DENPNUM
      *
           INITIALIZE                  SPA-S01KYOUTU
           MOVE    "07"                TO  SPA-S01-SYORINO
           PERFORM 4901-SPAKYOTUKEY-SET-SEC
      *
           MOVE    "S02"               TO  SPA-MOTOPG
           MOVE    "S03"               TO  SPA-SAKIPG
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "S03    "            TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       480-CHOSEI-EXT.
           EXIT.
      *************************************************************
      *    履歴修正
      *************************************************************
       490-RIREKI-SEC           SECTION.
      *
           IF      SPA-GMN-SELBAN      =   ZERO
               GO      TO      490-RIREKI-EXT
           END-IF
      *
           MOVE    "08"                TO  WRK-SYORINO
      *収納請求額のチェックを行う
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
      *****MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                       TO  SYU-NYUGAIKBN
           MOVE    SPA-GMN-PTID        TO  SYU-PTID
           MOVE    SPA-GMN-TDENPNUM (SPA-GMN-SELBAN) (1:7)
                                       TO  SYU-DENPNUM
           PERFORM 900-SYUNOU-READ-SEC
      *     
           IF      FLG-SYUNOU          =   1
                   CONTINUE
           ELSE
      *収納請求額がゼロならばエラー
             IF    SYU-SKYMONEY      =  ZERO
                   MOVE    "0007"     TO    SPA-ERRCD
                   GO    TO    490-RIREKI-EXT
             END-IF
      *収納伝票状態のチェック（請求取消）はエラー
             IF    SYU-DENPJTIKBN     =     "3"
                   MOVE    "0007"     TO    SPA-ERRCD
                   GO    TO    490-RIREKI-EXT
             END-IF
           END-IF
      *
      *****MOVE    SPA-GMN-THKNCOMBI(SPA-GMN-SELBAN) TO
      *****                            SPA-HKNCOMBIMEI
      *****MOVE    SPA-GMN-TSRYKAMEI(SPA-GMN-SELBAN) TO
      *****                            SPA-SRYKAMEI
      *****MOVE    SPA-GMN-TDENPNUM(SPA-GMN-SELBAN)  TO
      *****                            SPA-S01-DENPNUM
      *
           INITIALIZE                  SPA-S01KYOUTU
           MOVE    "08"                TO  SPA-S01-SYORINO
           PERFORM 4901-SPAKYOTUKEY-SET-SEC
      *
           MOVE    "S02"               TO  SPA-MOTOPG
           MOVE    "S03"               TO  SPA-SAKIPG
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "S03    "            TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       490-RIREKI-EXT.
           EXIT.
      *
      *************************************************************
      *    変更確定　処理
      *************************************************************
       490-KAKUTEI-SEC                 SECTION.
      *
           IF      SPA-GMN-SELBAN      =   ZERO
               GO      TO      490-KAKUTEI-EXT
           END-IF
      *
      *****MOVE    SPA-GMN-THKNCOMBI(SPA-GMN-SELBAN) TO
      *****                            SPA-HKNCOMBIMEI
      *****MOVE    SPA-GMN-TSRYKAMEI(SPA-GMN-SELBAN) TO
      *****                            SPA-SRYKAMEI
           MOVE    SPA-GMN-TDENPNUM(SPA-GMN-SELBAN)  TO
                                       SPA-S01-DENPNUM
      *
           INITIALIZE                  SPA-S01KYOUTU
           MOVE    "09"                TO  SPA-S01-SYORINO
           PERFORM 4901-SPAKYOTUKEY-SET-SEC
      *
           MOVE    "S02"               TO  SPA-MOTOPG
           MOVE    "S03"               TO  SPA-SAKIPG
           MOVE    SPA-S01KYOUTU       TO  SPA-WORK
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "S03    "            TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       490-KAKUTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *       収納共通ＳＰＡ編集処理
      *****************************************************************
       4901-SPAKYOTUKEY-SET-SEC               SECTION.
      *
           MOVE    SPA-GMN-PTNUM       TO  SPA-S01-PTNUM
           MOVE    SPA-GMN-PTID        TO  SPA-S01-PTID
           MOVE    SPA-GMN-KANANAME    TO  SPA-S01-KANANAME
           MOVE    SPA-GMN-NAME        TO  SPA-S01-NAME
           MOVE    SPA-GMN-SEX         TO  SPA-S01-SEX
           MOVE    SPA-GMN-BIRTHDAY    TO  SPA-S01-BIRTHDAYW
           MOVE    SPA-GMN-SRYKA       TO  SPA-S01-SRYKA
           MOVE    SPA-GMN-SRYKAMEI    TO  SPA-S01-SRYKAMEI
           MOVE    SPA-GMN-SRYYM       TO  SPA-S01-SRYYMW
           MOVE    SPA-NAI-SRYYM       TO  SPA-S01-SRYYM
           MOVE    SPA-GMN-THKNCOMBI(SPA-GMN-SELBAN)
                                       TO  SPA-S01-HKNCOMBIMEI
           MOVE    SPA-GMN-TFTNRATE (SPA-GMN-SELBAN)
                                       TO  SPA-S01-FTNRATEMEI
           MOVE    SPA-GMN-TDENPNUM (SPA-GMN-SELBAN)
                                       TO  SPA-S01-DENPNUM
           MOVE    SPA-NAI-TNYUGAIKBN (SPA-GMN-SELBAN)
                                       TO  SPA-S01-NYUGAIKBN
           MOVE    SPA-GMN-NYUGAIKBN   TO  SPA-S01-HNYUGAIKBN
      *
           MOVE    SPA-S01KYOUTU       TO  SPA-WORK          
          .
       4901-SPAKYOTUKEY-SET-EXT.
           EXIT.
      *
      **************************************************************
      *    前月表示処理
      **************************************************************
       490-ZENGETU-SEC                 SECTION.
      *
           IF      SPA-GMN-PTID        =   ZERO
           OR      SPA-GMN-SRYKA       =   SPACE
           OR      SPA-NAI-SRYYM       =   ZERO
               GO  TO  490-ZENGETU-EXT
           END-IF    
      *
      *   前月の月算出
           MOVE    "61"                TO  LNK-DAY6-IRAI
           MOVE    SPA-NAI-SRYYM       TO  LNK-DAY6-KIJUN (1:6)
           MOVE    "01"                TO  LNK-DAY6-KIJUN (7:2)
           MOVE    "2"                 TO  LNK-DAY6-ZOGENPTN
           MOVE    -1                  TO  LNK-DAY6-ZOGEN 
           CALL  "ORCSDAY"    USING    STS-AREA-DAY  LNK-DAY6-AREA
           IF      STS-DAY-RC1         NOT =   ZERO
              MOVE 0                   TO  LNK-DAY6-KEISAN
           END-IF
           MOVE    LNK-DAY6-KEISAN(1:6)    TO  SPA-NAI-SRYYM
           MOVE    LNK-DAY6-KEISAN         TO  SPA-SRYYMD
      *
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    LNK-DAY6-KEISAN     TO  LNK-DAY2-YMD
           CALL  "ORCSDAY"   USING    STS-AREA-DAY  LNK-DAY2-AREA
           IF      STS-DAY-RC1         =   ZERO
               MOVE    LNK-DAY2-EDTYMD1(1:6)   TO  SPA-GMN-SRYYM
               MOVE    LNK-DAY2-EDTYMD1        TO  SPA-SRYYMDW
           END-IF
      *
           PERFORM 300-SYUNOU-HENSYU-SEC
           INITIALIZE              SPA-GMN-INPUT
      *
           MOVE    ZERO              TO  SPA-NAI-SELNO     
      *
           .
       490-ZENGETU-EXT.
           EXIT.
      *
      *
      **************************************************************
      *    次月表示処理
      **************************************************************
       490-JIGETU-SEC                 SECTION.
      *
           IF      SPA-GMN-PTID        =   ZERO
           OR      SPA-GMN-SRYKA       =   SPACE
           OR      SPA-NAI-SRYYM       =   ZERO
               GO  TO  490-JIGETU-EXT
           END-IF    
      *
      *   次月算出
           MOVE    "61"                TO  LNK-DAY6-IRAI
           MOVE    SPA-NAI-SRYYM       TO  LNK-DAY6-KIJUN (1:6)
           MOVE    "01"                TO  LNK-DAY6-KIJUN (7:2)
           MOVE    "2"                 TO  LNK-DAY6-ZOGENPTN
           MOVE    1                   TO  LNK-DAY6-ZOGEN 
           CALL    "ORCSDAY"  USING    STS-AREA-DAY  LNK-DAY6-AREA
           IF      STS-DAY-RC1         NOT =   ZERO
              MOVE 0                   TO  LNK-DAY6-KEISAN
           END-IF
           MOVE    LNK-DAY6-KEISAN(1:6)    TO  SPA-NAI-SRYYM
           MOVE    LNK-DAY6-KEISAN         TO  SPA-SRYYMD
      *
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    LNK-DAY6-KEISAN     TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"  USING    STS-AREA-DAY  LNK-DAY2-AREA
           IF      STS-DAY-RC1         =   ZERO
               MOVE    LNK-DAY2-EDTYMD1(1:6)   TO  SPA-GMN-SRYYM
               MOVE    LNK-DAY2-EDTYMD1        TO  SPA-SRYYMDW
           END-IF
      *
           PERFORM 300-SYUNOU-HENSYU-SEC
           INITIALIZE              SPA-GMN-INPUT
      *
           MOVE    ZERO              TO  SPA-NAI-SELNO     
      *
           .
       490-JIGETU-EXT.
           EXIT.
      *
      *
      **************************************************************
      *    共通パラメタ更新・画面遷移処理
      **************************************************************
       4901-PARA-HEN-SEC                 SECTION.
      *
       4901-PARA-HEN-EXT.
           EXIT.
      *
      **************************************************************
      *    保険組合せ名称編集処理
      **************************************************************
       510-HKNKUMI-MEI-SEC           SECTION.
      *
           MOVE    SPACE               TO  WRK-HKNKUMI
      *
           INITIALIZE                  HKNCOMBI-REC
           MOVE    SPA-HOSPID          TO  COMB-HOSPID
           MOVE    SPA-GMN-PTID        TO  COMB-PTID
           MOVE    WRK-KUMINO          TO  COMB-HKNCOMBINUM
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNCOMBI-KEY"  TO  ORC-DBPATH
               PERFORM 910-HKNCOMBI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-HKNKUMI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF     (FLG-HKNKUMI         =   ZERO         )
               CONTINUE
           ELSE
               GO      TO      510-HKNKUMI-MEI-EXT
           END-IF
      *
           IF      COMB-SYU-TANSEIDONAME   =   SPACE
               STRING  COMB-KOH1-TANSEIDONAME  DELIMITED  BY  SPACE
                       " "                 DELIMITED  BY  SIZE
                       COMB-KOH2-TANSEIDONAME   DELIMITED BY  SPACE
                       " "                 DELIMITED  BY  SIZE
                       COMB-KOH3-TANSEIDONAME  DELIMITED  BY  SPACE
                       " "                 DELIMITED  BY  SIZE
                       COMB-KOH4-TANSEIDONAME  DELIMITED  BY  SPACE
                             INTO              WRK-HKNKUMI
               END-STRING
           ELSE
               STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                       " "                 DELIMITED  BY  SIZE
                       COMB-KOH1-TANSEIDONAME  DELIMITED  BY  SPACE
                       " "                 DELIMITED  BY  SIZE
                       COMB-KOH2-TANSEIDONAME   DELIMITED BY  SPACE
                       " "                 DELIMITED  BY  SIZE
                       COMB-KOH3-TANSEIDONAME  DELIMITED  BY  SPACE
                       " "                 DELIMITED  BY  SIZE
                       COMB-KOH4-TANSEIDONAME  DELIMITED  BY  SPACE
                             INTO              WRK-HKNKUMI
               END-STRING
           END-IF
      *
      *    労災の時、コメントの追加
           IF      COMB-HKNNUM         =   "971"  OR  "973"
      *        患者保険情報検索
               INITIALIZE                      PTRSIINF-REC
               MOVE    SPA-HOSPID          TO  PTRSI-HOSPID
               MOVE    SPA-GMN-PTID        TO  PTRSI-PTID
               MOVE    COMB-HKNID          TO  PTRSI-HKNID
               MOVE    PTRSIINF-REC        TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    "PTRSIINF-KEY"     TO  ORC-DBPATH
                   PERFORM 993-PTRSIINF-NEXT-SEC
               ELSE
                   INITIALIZE                      PTRSIINF-REC
                   MOVE    1                   TO  FLG-PTRSIINF
               END-IF
               MOVE    SPACE               TO  WRK-HKNKBN-MEI
               EVALUATE    PTRSI-HKNKBN
                   WHEN    "1"
                       MOVE    "短"        TO  WRK-HKNKBN-MEI
                   WHEN    "2"
                       MOVE    "傷"        TO  WRK-HKNKBN-MEI
                   WHEN    "3"
                       MOVE    "ア"        TO  WRK-HKNKBN-MEI
               END-EVALUATE
               IF      PTRSI-COMMENT       =   SPACE
                   MOVE    SPACE               TO  WRK-HKNKUMI
                   STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                           " "                     DELIMITED  BY  SIZE
                           WRK-HKNKBN-MEI          DELIMITED  BY  SPACE
                           INTO              WRK-HKNKUMI
                   END-STRING
               ELSE
                   MOVE    SPACE               TO  WRK-HKNKUMI
                   STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                           " "                     DELIMITED  BY  SIZE
                           WRK-HKNKBN-MEI          DELIMITED  BY  SPACE
                           "（"                    DELIMITED  BY  SIZE
                           PTRSI-COMMENT           DELIMITED  BY  SPACE
                           "）"                    DELIMITED  BY  SIZE
                           INTO              WRK-HKNKUMI
                   END-STRING
               END-IF
      *
           END-IF
      *
           .
       510-HKNKUMI-MEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    クリア画面へ
      *****************************************************************
       420-CLEA-SEC        SECTION.
      *
           INITIALIZE                  SPA-S02-AREA
           IF      SPA-SRYYMD          =   SPACE
               MOVE    SPA-SYSYMDWH(1:6)   TO  SPA-GMN-SRYYM
               MOVE    SPA-SYSYMD  (1:6)   TO  SPA-NAI-SRYYM
           ELSE
               MOVE    SPA-SRYYMDW(1:6)    TO  SPA-GMN-SRYYM
               MOVE    SPA-SRYYMD (1:6)    TO  SPA-NAI-SRYYM
           END-IF
      *
           PERFORM 3101-SRYKA-SPA-SEC
           PERFORM 3102-NYUGAIKBN-SPA-SEC
           MOVE    2                   TO  SPA-GMN-CUR
      *
           .
       420-CLEA-EXT.
           EXIT.
      *
      *****************************************************************
      *    前回患者処理
      *****************************************************************
       430-MAEKPTNUM-SEC              SECTION.
      *
           IF      SPA-LAST-PTNUM      =   SPACE
               GO      TO      430-MAEKPTNUM-EXT
           END-IF
      *
           MOVE    SPA-LAST-PTNUM      TO  S02-PTNUM
           PERFORM 4102-PTNUM-CHK-SEC
      *
           .
       430-MAEKPTNUM-EXT.
           EXIT.
      *****************************************************************
      *    氏名検索へ
      *****************************************************************
       470-SIMEIKEN-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-S02             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "S02"               TO  SPA-MOTOPG
           MOVE    "P97"               TO  SPA-SAKIPG
      *
      *    氏名をクリアする
           MOVE    SPACE               TO  SPA-PTNUM
           MOVE    ZERO                TO  SPA-PTID
           MOVE    SPACE               TO  SPA-NAME
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
           MOVE    "P97"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       470-SIMEIKEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    予約登録へ
      *****************************************************************
       480-YOYAKU-SEC             SECTION.
      *
      *    戻り時、画面を元へ戻す
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-S02             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "S02"               TO  SPA-MOTOPG
           MOVE    "S02"               TO  SPA-MOTOPG3
           MOVE    "Y01"               TO  SPA-SAKIPG
      *
           MOVE    SPACE               TO  SPA-KYOTUKEY
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "Y01"                TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       480-YOYAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    受付一覧へ
      *****************************************************************
       490-UKEICHI-SEC             SECTION.
      *
      *    戻り時、画面を元へ戻す
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-S02             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "S02"               TO  SPA-MOTOPG
           MOVE    "U01"               TO  SPA-SAKIPG
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "U01    "            TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       490-UKEICHI-EXT.
           EXIT.
      *
      **************************************************************
      *    エラーメッセージ表示理
      **************************************************************
       510-ERRSET-SEC              SECTION.
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "入力エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "入金取消が可能なデータではありません"
                                       TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "請求取消が可能なデータではありません"
                                       TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "返金はできません"
                                       TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "請求取消済みの為、再計算はできません"
                                       TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "入金はできません"
                                       TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "履歴修正はできません"
                                       TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "Ｊデビットでの入金はできません"
                                       TO  SPA-ERRMSG
               WHEN    "0009" 
                   MOVE    "診療月以前のデータなし"
                                       TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "請求取消し済みの為、再発行はできません"
                                       TO  SPA-ERRMSG
               WHEN    "0020"
                   MOVE    "対象の診療年月に収納はありません"
                                       TO  SPA-ERRMSG
               WHEN    "0030"
                   MOVE    "診療科目入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "0031"
                   MOVE    "該当の患者が存在しません。"
                                               TO  SPA-ERRMSG
      *******  WHEN    "0032"
      ************ MOVE    "ＩＤ取得サブでエラー" 
      ********                                 TO  SPA-ERRMSG
               WHEN    "0033"
                   MOVE    "診療年月入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "0034"
                   MOVE    "入外区分入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "0050"
                  MOVE "患者番号・診療科・診療年月の入力がありません" 
                                               TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "収納明細の更新処理でエラーになりました"
                                               TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "収納の更新処理でエラーになりました"
                                               TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  SERR
           MOVE    SPA-ERRCD            TO  SERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  SERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "S02"                TO  SPA-MOTOPG
           MOVE    "SERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "SERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *     
      **************************************************************
      *    患者マスター読込（主キー）
      **************************************************************
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
                   MOVE    MCPDATA-REC         TO  PTINF-REC
                   MOVE    ZERO                TO  FLG-PTINF
               ELSE
                   MOVE    1                   TO  FLG-PTINF
                   INITIALIZE                  PTINF-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
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
      **************************************************************
      *    診療行為マスター読込
      **************************************************************
       SINKOU-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACT-REC
               MOVE    ZERO            TO  FLG-SINKOU
           ELSE
               MOVE    1               TO  FLG-SINKOU
           END-IF
      *
           .
       SINKOU-READ-EXT.
           EXIT.
      **************************************************************
      *    診療会計マスター読込
      **************************************************************
       SINKAI-NEXT-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACCT-REC
               MOVE    ZERO            TO  FLG-SINKAI
           ELSE
               MOVE    1               TO  FLG-SINKAI
           END-IF
      *
           .
       SINKAI-NEXT-EXT.
           EXIT.
      *
      *
      **************************************************************
      *    システム管理マスタ読み込み処理
      **************************************************************
       900-KANRIMST-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1005-REC
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-KANRIMST-READ-EXT.
           EXIT.
      *     
      **************************************************************
      *    収納マスター読込（主キー）
      **************************************************************
       900-SYUNOU-READ-SEC         SECTION.
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =    ZERO
               MOVE    "SYUNOU-KEY"         TO  ORC-DBPATH
               PERFORM 900-SYUNOU-NEXT-SEC
           ELSE
               MOVE    1                    TO  FLG-SYUNOU
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-SYUNOU-READ-EXT.
           EXIT.
      *     
      *
      **************************************************************
      *    収納マスター読込（ＮＥＸＴ）
      **************************************************************
       900-SYUNOU-NEXT-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =  ZERO
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
               MOVE    ZERO            TO FLG-SYUNOU
           ELSE
               MOVE    1               TO FLG-SYUNOU
           END-IF 
      *
           .
       900-SYUNOU-NEXT-EXT.
           EXIT.
      **************************************************************
      *    保険組合せマスター読込
      **************************************************************
       910-HKNCOMBI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  HKNCOMBI-REC
               MOVE    ZERO            TO  FLG-HKNKUMI
           ELSE
               INITIALIZE                  HKNCOMBI-REC
               MOVE    1               TO  FLG-HKNKUMI
           END-IF
      *
           .
       910-HKNCOMBI-READ-EXT.
           EXIT.
      *
      **************************************************************
      *    収納明細読込
      **************************************************************
       900-SYUMEI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYUMEI-REC
               MOVE    ZERO            TO  FLG-SYUMEI
           ELSE
               INITIALIZE                  SYUMEI-REC
               MOVE    1               TO  FLG-SYUMEI
           END-IF
      *
           .
       900-SYUMEI-READ-EXT.
           EXIT.
      *
      **************************************************************
      *    保険番号マスター読込
      **************************************************************
       950-HKNMST-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  HKNNUM-REC
               MOVE    ZERO            TO  FLG-HKNMST
           ELSE
               INITIALIZE                  HKNNUM-REC
               MOVE    1               TO  FLG-HKNMST
           END-IF
      *
           .
       950-HKNMST-READ-EXT.
           EXIT.
      *
      **************************************************************
      *    受診履歴マスター読込
      **************************************************************
       960-JYURRK-READ-SEC         SECTION.
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
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           .
       960-JYURRK-READ-EXT.
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
      *****************************************************************
      *    患者労災保険情報読み込み
      *****************************************************************
       993-PTRSIINF-NEXT-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTRSIINF-REC
               MOVE    ZERO            TO  FLG-PTRSIINF
           ELSE
               INITIALIZE                  PTRSIINF-REC
               MOVE    1               TO  FLG-PTRSIINF
           END-IF
      *
           .
       993-PTRSIINF-NEXT-EXT.
           EXIT.
      *****************************************************************
      *    収納マスター読込
      *****************************************************************
       980-SYUNOU-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
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
      *
      **************************************************************
      *    ＰＵＴ　処理
      **************************************************************
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
