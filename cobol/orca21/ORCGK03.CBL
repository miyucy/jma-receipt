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
       PROGRAM-ID.                 ORCGK03.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 診療行為入力
      *  コンポーネント名  : 請求確認　（Ｋ０３）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC−多々納  01/05/21  今回請求額がゼロ以上であること
      *  01.00.02    MCC−多々納  01/06/29  年齢表示
      *  01.00.03    MCC−多々納  01/08/20  処方せんをＡ５（ＨＣ１９）へ
      *                                     画面変更に伴う修正
      *  02.00.00    MCC−多々納  01/12/17  請求額がゼロの時、ゼロ表示へ
      *  02.00.01    MCC−多々納  02/02/01  ドクターを追加
      *  02.00.02    NACL−多々納 02/08/26  薬剤情報発行を追加
      *  02.00.03    NACL−多々納 02/08/29  同一剤が同一履歴に存在する時
      *                                     受診履歴に編集しない
      *  02.00.04    NACL−多々納 02/09/13  自賠責追加
      *  02.00.05    NACL-多々納  02/11/11  ＤＵＭＭＹ診察料追加
      *  02.00.06    NACL-多々納  02/11/15  自費消費税対応修正
      *  02.00.07    NACL-多々納  02/12/05  初診料算定日追加
      *  02.00.08    NACL-多々納  02/12/11  ドクターエラーカーソル位置修正
      *  02.00.09    NACL-多々納  02/12/16  ドクター未入力ＯＫ追加
      *  02.00.10    NACL-多々納  02/12/17  診療種別の判定追加
      *  02.00.11    NACL-多々納  02/12/18  継続の時今回請求額を編集する
      *  02.00.12    NACL-多々納  03/01/08  入金額の上限修正
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    パラメタデータ
           SELECT  PARA-FILE       ASSIGN  FILE-NAME2
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-PARA.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *    パラメタデータ
       FD  PARA-FILE.
       01  PARA-REC.
           03  PARA-KEY.
               05  PARA-FILEMEI         PIC X(08).
               05  PARA-EDANUM          PIC 9(03).
           03  PARA-DATA-REC            PIC X(60000).
      *
       WORKING-STORAGE             SECTION.
      *    パラメタファイル名
       01  FILE-NAME2.
           03  FILLER              PIC X(09)   VALUE   "/var/tmp/".
           03  FILLER              PIC X(09)   VALUE   "K01PARA".
           03  FILE-TERMID2        PIC X(32)   VALUE   SPACE.
           03  FILLER              PIC X(06)   VALUE   ".TXT".
      *
      *    画面色等
           COPY    "ENUM-VALUE".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    診療行為用共通パラメタ
           COPY    "K01COMMON-SPA".
      *
      *    画面スパ領域
           COPY    "K03SCR-SPA".
      *
      *    画面スパ領域
      *01  SPA-K03.
      *    03  SPA-K03-AREA.
      *        05  SPA-GMN-PAGE                  PIC 9(02).
      *        05  SPA-MAX-PAGE                  PIC 9(02).
      *        05  SPA-GMN-LINE                  PIC 9(02).
      *        05  SPA-GMN-MAX                   PIC 9(02).
      *        05  SPA-GMN-CUR                   PIC 9(02).
      *        05  SPA-GMN-AREA.
      *
      *            07  SPA-GMN-HAKYMD            PIC X(09).
      *            07  SPA-GMN-DENPNUM           PIC X(07).
      *
      *            07  SPA-GMN-HKNRYO            PIC 9(07)  OCCURS  11.
      *            07  SPA-GMN-TGMONEY           PIC 9(07)  OCCURS  11.
      *
      *            07  SPA-GMN-HKNTEKI           PIC 9(10).
      *            07  SPA-GMN-ROUFTN            PIC 9(07).
      *            07  SPA-GMN-KOHFTN            PIC 9(07).
      *            07  SPA-GMN-JIHI1             PIC 9(07).
      *            07  SPA-GMN-JIHI2             PIC 9(07).
      *            07  SPA-GMN-JIHI3             PIC 9(07).
      *            07  SPA-GMN-JIHI4             PIC 9(07).
      *            07  SPA-GMN-JIHI5             PIC 9(07).
      *            07  SPA-GMN-JIHIKEI           PIC 9(07).
      *            07  SPA-GMN-JIHITAX1          PIC 9(07).
      *            07  SPA-GMN-JIHITAX2          PIC 9(07).
      *            07  SPA-GMN-JIHITAX3          PIC 9(07).
      *            07  SPA-GMN-JIHITAX4          PIC 9(07).
      *            07  SPA-GMN-JIHITAX5          PIC 9(07).
      *            07  SPA-GMN-JIHITAXKEI        PIC 9(07).
      *            07  SPA-GMN-JIHIZEI           PIC 9(07).
      *            07  SPA-GMN-HKNGAI            PIC 9(07).
      *            07  SPA-GMN-ICHIFTN           PIC 9(07).
      *            07  SPA-GMN-JIHIGOK           PIC 9(07).
      *            07  SPA-GMN-YKZFTN            PIC 9(07).
      *            07  SPA-GMN-CHOSEI            PIC S9(07).
      *            07  SPA-GMN-CHOSEI-X          PIC  X(10).
      *            07  SPA-GMN-SEIKYU            PIC S9(07).
      *            07  SPA-GMN-ZENMISYU          PIC S9(07).
      *            07  SPA-GMN-SEIGOK            PIC S9(07).
      *            07  SPA-GMN-NYUKIN            PIC S9(07).
      *            07  SPA-GMN-NYUKIN-X          PIC  X(10).
      *
      *            07  SPA-GMN-ROUSYOSIN         PIC S9(07).
      *            07  SPA-GMN-ROUSAISIN         PIC S9(07).
      *            07  SPA-GMN-ROUSIDOU          PIC S9(07).
      *            07  SPA-GMN-ROUETC            PIC S9(07).
      *
      *            07  SPA-GMN-HAKFLG-G.
      *                09  SPA-GMN-HAKFLG            PIC X(01).
      *                09  SPA-GMN-HAKFLGF           PIC X(01).
      *                09  SPA-GMN-HAKFLGMSG         PIC X(16).
      *            07  SPA-GMN-HAKFLG-LIST.
      *                09  SPA-GMN-HAKFLGLST        PIC X(18)
      *                                             OCCURS   2.
      *
      *            07  SPA-GMN-SYOHOPRTFLG-G.
      *                09  SPA-GMN-SYOHOPRTFLG      PIC X(01).
      *                09  SPA-GMN-SYOHOH           PIC X(01).
      *                09  SPA-GMN-SYOHOPRTMSG      PIC X(16).
      *            07  SPA-GMN-SYOHOPRT-LIST.
      *                09  SPA-GMN-SYOHOPRTLST        PIC X(18)
      *                                             OCCURS   3.
      *            薬剤情報
      *            07  SPA-GMN-YAKJYOFLG-G.
      *                09  SPA-GMN-YAKJYOFLG        PIC X(01).
      *                09  SPA-GMN-YAKJYOH          PIC X(01).
      *                09  SPA-GMN-YAKJYOFLGMSG     PIC X(16).
      *            07  SPA-GMN-YAKUJYO-LIST.
      *                09  SPA-GMN-YAKJYOLST        PIC X(18)
      *                                             OCCURS   3.
      *
      *            07  SPA-GMN-JIHIMSG           PIC X(20)
      *                                          OCCURS   5.
      *            07  SPA-GMN-DRCD-G.
      *                09  SPA-GMN-DRCD        PIC X(04).
      *                09  SPA-GMN-F1          PIC X(01).
      *                09  SPA-GMN-DRCDMEI     PIC X(20).
      *            07  SPA-GMN-DRCDLST                    OCCURS  10.
      *                09  SPA-GMN-DRCDL       PIC X(04).
      *                09  SPA-GMN-F1L         PIC X(01).
      *                09  SPA-GMN-DRCDMEIL    PIC X(20).
      *            07  SPA-DRCD-MAX            PIC 9(04).
      *
      *        05  SPA-NAI-AREA.
      *            07  SPA-NAI-SEIKYU            PIC S9(07).
      *            07  SPA-KON-SKYMONEY          PIC S9(07).
      *            07  SPA-NAI-CHOSEI            PIC X(01).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-SYUNOU          PIC 9(01).
           03  FLG-WKSRYACT        PIC 9(01).
           03  FLG-SRYACT          PIC 9(01).
           03  FLG-SRYACCT         PIC 9(01).
           03  FLG-SYUMEI          PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-PTCOM           PIC 9(01).
           03  FLG-JYURRK          PIC 9(01).
           03  FLG-SRYKARRK        PIC 9(01).
           03  FLG-UKETUKE         PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-SANTEI          PIC 9(01).
           03  FLG-PARA            PIC 9(01).
      *
           03  FLG-OK              PIC 9(01).
           03  FLG-CHK             PIC 9(01).
           03  FLG-ERR             PIC 9(01).
           03  FLG-ARI             PIC 9(01).
           03  FLG-SINKI           PIC 9(01).
      *
           03  FLG-SYOSIN-DUMMY    PIC 9(01).
      *
           03  FLG-TOKTEI          PIC 9(01).
      *
           03  FLG-CLAIM           PIC 9(01).
           03  FLG-CLAIM-OK        PIC 9(01).
      *
           03  FLG-CHK-OK          PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(02).
           03  IDX-P               PIC 9(04).
           03  IDX-KOUI            PIC 9(04).
           03  IDX-SIN             PIC 9(04).
           03  IDX-ATO             PIC 9(04).
           03  IDX-YAKUZAI         PIC 9(04).
           03  IDX-Y2              PIC 9(02).
      *
           03  IDX-1               PIC 9(04).
           03  IDX-2               PIC 9(02).
           03  IDX-3               PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYSYMD.
               05  WRK-SYSYY       PIC 9(04).
               05  WRK-SYSMM       PIC 9(02).
               05  WRK-SYSDD       PIC 9(02).
      *
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WFIL1       PIC X(01).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WFIL2       PIC X(01).
               05  WRK-WDD         PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *
      *****03  WRK-Z9              PIC Z,ZZZ,ZZZ.
           03  WRK-Z99             PIC --,---,--9.
           03  WRK-Z9              PIC --,---,---.
           03  WRK-Z92             PIC --,---,---.
      *
           03  WRK-KIN             PIC 9(07).
      *    診療行為計算用
           03  WRK-TENSU           PIC 9(08).
           03  WRK-ZAITEN          PIC 9(08).
           03  WRK-SRYKAISUKEI     PIC 9(03).
           03  WRK-SRYSURYOKEI     PIC 9(07)V9(03).
           03  WRK-MEISAISU        PIC 9(07).
           03  WRK-SRYCD           PIC 9(09).
           03  WRK-SRYCDKEI        PIC 9(14).
           03  WRK-SRYYMD          PIC X(08).
      *
           03  WRK-ZAINUM          PIC 9(08).
           03  WRK-H-ZAINUM        PIC 9(08).
      *    診療会計用集計
           03  WRK-WKSRY-AREA.
               05  WRK-SYUTEN1             PIC  9(07).
               05  WRK-SYUTEN2             PIC  9(07).
               05  WRK-YKZTEN              PIC  9(07).
               05  WRK-KIZAITEN            PIC  9(07).
               05  WRK-JIHIMONEY           PIC  9(08).
      *
           03  WRK-SEIKYU              PIC S9(07).
      *
           03  WRK-DENPNUM         PIC 9(07).
           03  WRK-MEIBAN          PIC 9(03).
      *    回数
           03  WRK-KAISU           PIC 9(08).
      *
           03  WRK-ERRMSG          PIC X(40).
           03  WRK-MCP-PUTTYPE     PIC X(8).
      *
           03  WRK-TIME1.
               05  WRK-TIME11      PIC 9(08).
      *
           03  WRK-TIME2.
               05  WRK-TIME22      PIC 9(04).
      *
           03  WRK-JYURRK-RENNUM           PIC 9(01).
           03  WRK-JYURRK-EDANUM           PIC 9(01).
           03  WRK-JYURRK-DOUJI-RENNUM     PIC 9(01).
           03  WRK-KAIKEI-RENNUM           PIC  9(03).
      *
           03  WRK-PATH                    PIC X(64).
      *
           03  WRK-KIDMSG          PIC X(80).
           03  WRK-RENNUM-KEY          PIC 9(01).
      *
      *請求金額
           03  WRK-KON-SKYMONEY        PIC  9(07).
      *請求金額
           03  WRK-SKYMONEY            PIC  9(07).
      *入金合計額
           03  WRK-NYUKIN-TOTAL        PIC  9(07).
      *入金回数
           03  WRK-NYUKIN-KAISU        PIC  9(07).
      *伝票番号枝番
           03  WRK-DENPEDANUM          PIC  9(02).
      *入金連番
           03  WRK-NYUKINRENNUM        PIC  9(02).
      *伝票状態区分
           03  WRK-DENPJTIKBN          PIC  X(01).
      *
      *    処方せんＰＧ名
           03  WRK-SYOHOU-PG           PIC X(20).
      *    請求書ＰＧ名
           03  WRK-SEIKYU-PG           PIC X(20).
      *    入力項目名
           03  WRK-MCP-WIDGET          PIC X(64).
      *
           03  WRK-GMN-SELNUM          PIC 9(02).
      *
           03  WRK-PTID                   PIC X(10).
      *    診療種別
           03  WRK-SRYSYUKBN              PIC X(03).
           03  WRK-MAE-SRYSYUKBN          PIC X(03).
      *
      *    診療行為内容比較用テーブル
       01  TBL-AREA.
           03  TBL-MAE-AREA.
               05  TBL-MAE-REC     OCCURS   30.
                   07  TBL-MAE-SRYCD       PIC  X(09).
                   07  TBL-MAE-SRYSURYO    PIC  9(05)V9(03).
                   07  TBL-MAE-SRYKAISU    PIC  9(03).
                   07  TBL-MAE-INPUTCOMENT PIC  X(40).
                   07  TBL-MAE-ATAI-G.
                       09  TBL-MAE-ATAI    PIC  X(08)  OCCURS  3.
           03  TBL-ATO-AREA.
               05  TBL-ATO-REC     OCCURS   30.
                   07  TBL-ATO-SRYCD       PIC  X(09).
                   07  TBL-ATO-SRYSURYO    PIC  9(05)V9(03).
                   07  TBL-ATO-SRYKAISU    PIC  9(03).
                   07  TBL-ATO-INPUTCOMENT PIC  X(40).
                   07  TBL-ATO-ATAI-G.
                       09  TBL-ATO-ATAI    PIC  X(08)  OCCURS  3.
      *
      *    剤テーブル領域
       01  WRK-TBL-ZAINUM-AREA.
           03  WRK-TBL-ZAINUM-G            OCCURS   100.
               05  WRK-TBL-ZAINUM          PIC 9(08).
           03  WRK-TBL-IDX                 PIC 9(04).
           03  FLG-ZAINUM                  PIC 9(01).
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
      *
       01  WRK-SYSTIME.
           03  WRK-SYSTIME-X       PIC X(08).
      *
      *    ＣＬＡＩＭファイル名
       01  CLAIM-FILE.
           03  FILLER              PIC X(30)   VALUE
               "scripts/claim/HL02.sh".
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK0041.INC".
      *
           COPY    "CPSK1013.INC".
      *    ドクター
           COPY    "CPSK1010.INC".
      *    帳票ＰＧ
           COPY    "CPSK1032.INC".
      *
      *　　（ＣＬＡＩＭ接続）
           COPY    "CPSK9000.INC".
           COPY    "CPSK9001.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    収納マスタワーク
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    診療行為マスター
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    収納明細マスタ−
       01  SYUMEI-REC.
           COPY    "CPSYUMEI.INC".
      *
      *    診療会計マスタ−
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    患者コメント
       01  PTCOM-REC.
           COPY    "CPPTCOM.INC".
      *
      *    受診履歴
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *    診療科履歴
       01  SRYKARRK-REC.
           COPY    "CPSRYKARRK.INC".
      *
      *    ワーク診療行為マスタ−
       01  WKSRYACT-REC.
           COPY    "CPWKSRYACT.INC".
      *
      *    受診内容
       01  UKETUKE-REC.
           COPY    "CPUKETUKE.INC".
      *
      *    算定履歴
       01  SANTEI-REC.
           COPY    "CPSANTEI.INC".
      *
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *    診療行為マスタワーク
       01  LNK-WKSRYACT-AREA.
           02  LNK-WKSRYACT-REC      OCCURS   30.
           COPY    "CPWKSRYACT.INC"  REPLACING
                                     //WKSRY-// BY //LNK-WKSRY-//.
       01  LNK-WKSRYACT-MAX           PIC 9(04).
      *
      *    診療行為マスタワーク
       01  WRK-WKSRYACT-REC.
           COPY    "CPWKSRYACT.INC"  REPLACING
                                    //WKSRY-// BY //WRK-WKSRY-//.
      *
      *    保存用収納ワーク
       01  WRK-SYUNOU-REC.
           COPY    "CPSYUNOU.INC"  REPLACING
                                     //SYU-// BY //WRK-SYU-//.
      *
      *    受診履歴
       01  TBL-JYURRK-AREA.
           02  TBL-JYURRK-REC        OCCURS   10.
           COPY    "CPJYURRK.INC"  REPLACING
                                     //JYURRK-// BY //TBL-JYURRK-//.
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
      *D   COPY    "CPORCSDAY.INC".
      *D   COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *    負担金額計算用パラメタ
           COPY    "CPORCS01.INC".
      *
      *    処方箋印刷パラメタ
           COPY    "CPORCHC02.INC".
      *
      *    処方箋印刷パラメタ（Ａ５）
           COPY    "CPORCHC19.INC".
      *
      *    請求書印刷パラメタ
           COPY    "CPORCHC03.INC".
      *
      *    薬情報印刷パラメタ
           COPY    "CPORCSCH30.INC".
      *
      *   診療科算定履歴更新サブ
           COPY    "CPORCSKARRK.INC".
      *
      *   算定履歴更新サブ
           COPY    "CPORCSSANTEI.INC".
      *
      *    ＤＢ検索
      *01  MCPDATA-REC                 PIC X(5000).
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *===> For Claim Start
           COPY    "CPSHELLTBL.INC".
           COPY    "ORCA-DBPATH".
      *===> For Claim End
      *
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
           COPY    "K01.INC".
           COPY    "K02.INC".
           COPY    "K02N.INC".
           COPY    "K021.INC".
           COPY    "K022.INC".
           COPY    "K023.INC".
           COPY    "K03.INC".
           COPY    "K04.INC".
           COPY    "K05.INC".
           COPY    "K051.INC".
           COPY    "K052.INC".
           COPY    "K06.INC".
           COPY    "K07.INC".
           COPY    "K08.INC".
           COPY    "K09.INC".
           COPY    "K10.INC".
           COPY    "K98.INC".
           COPY    "K99.INC".
           COPY    "K03X.INC".
           COPY    "KERR.INC".
           COPY    "KERR2.INC".
           COPY    "KID1.INC".
           COPY    "KID2.INC".
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
           INITIALIZE                  STS-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA.
           MOVE    SPA-FREE        TO  SPA-K03
           MOVE    SPA-WORK        TO  SPA-K01KYOUTU
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
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
           MOVE    SPA-K01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-K03         TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
      *    DISPLAY "*** ORCSNPL    START  ***"
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "KERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *
      *        初期画面編集
               PERFORM 300-SCREEN-SEC
               IF      FLG-END             =   1
                   GO      TO      100-INIT-EXT
               END-IF
      *
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
      *****MOVE   "NEW"                TO  MCP-PUTTYPE.
           MOVE   SPACE                TO  MCP-PUTTYPE.
           MOVE   "K03"                TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
      *
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC             SECTION.
      *
      *    内部画面より
           EVALUATE    SPA-MOTOPG
               WHEN    "KID1"
      *            確認画面より
                   PERFORM 30010-KID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
      *        ＣＬＡＩＭ画面より
               WHEN    "K03X"
                   IF      SPA-K03X-FLG        =   SPACE
                       MOVE    1                   TO  SPA-GMN-CUR
                   ELSE
                       PERFORM 3009-CLAIM-SYORI-SEC
                   END-IF
                   GO      TO                  300-SCREEN-EXT
           END-EVALUATE
      *
           MOVE    SPACE               TO  SPA-KIDCD
      *
           INITIALIZE                  SPA-K03-AREA
           INITIALIZE                  SYUNOU-REC
           MOVE    ZERO                TO  IDX-KOUI
      *
           MOVE    SPA-TERMID          TO  FILE-TERMID2
           OPEN    INPUT               PARA-FILE
           PERFORM 980-PARA-READ-SEC
      *
      *****INITIALIZE                      PARA-KEY
      *    MOVE    SPA-TERMID          TO  PARA-TERMID
      *    START   PARA-FILE
      *        KEY IS    >=   PARA-KEY
      *        INVALID
      *            MOVE    1               TO  FLG-PARA
      *        NOT INVALID
      *            PERFORM 990-PARA-NEXT-SEC
      *****END-START
           PERFORM
               UNTIL   FLG-PARA        NOT =   ZERO 
               IF      PARA-FILEMEI        =   "SYUNOU"
                   MOVE    PARA-DATA-REC       TO  SYUNOU-REC
               END-IF
      *        診療行為カウント
               IF      PARA-FILEMEI        =   "WKSRYACT"
                   ADD     1                   TO  IDX-KOUI
               END-IF
      *
               PERFORM 980-PARA-READ-SEC
           END-PERFORM
           CLOSE                        PARA-FILE
      *
           PERFORM                 310-SPA-SET-SEC
      *
           MOVE    1               TO  SPA-GMN-CUR
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＫＩＤ１）ＯＫ処理
      *****************************************************************
       30010-KID1-SET-SEC          SECTION.
      *
           EVALUATE    SPA-KIDCD
      *        削除確認
               WHEN    "0101"
                   IF      SPA-KID1-FLG        =   "OK"
      *                訂正時、受診履歴等の削除
                       MOVE    ZERO                TO  FLG-CLAIM-OK
                       PERFORM 4500-TOROKU-SYORI-SEC
                   END-IF
           END-EVALUATE
           MOVE    SPACE               TO  SPA-KIDCD
           .
       30010-KID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       310-SPA-SET-SEC                  SECTION.
      *
      *    訂正の時、前の請求額を求める
           IF      SPA-SYORIFLG        =   ZERO
               MOVE    ZERO                TO  WRK-SKYMONEY
               MOVE    ZERO                TO  WRK-NYUKIN-TOTAL
           ELSE
               MOVE    SYUNOU-REC          TO  WRK-SYUNOU-REC
      *
               MOVE    SYUNOU-REC          TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
                   PERFORM 980-SYUNOU-READ-SEC
               ELSE
                   MOVE    1               TO  FLG-SYUNOU
               END-IF
      *        請求金額
               MOVE    SYU-SKYMONEY        TO  WRK-SKYMONEY
      *        入金合計額
               MOVE    SYU-NYUKIN-TOTAL    TO  WRK-NYUKIN-TOTAL
      *
               MOVE    WRK-SYUNOU-REC      TO  SYUNOU-REC
           END-IF
      *
      *
      *    発行日
           MOVE    SPA-SYSYMDWH        TO  SPA-GMN-HAKYMD
      *    伝票番号
      *    MOVE    SYU-DENPNUM          TO  SPA-GMN-DENPNUM
           IF      SPA-SYORIFLG        =   1
               MOVE    SPA-DENPNUM         TO  SPA-GMN-DENPNUM
           END-IF
      *
      *    保険料
           MOVE    ZERO                TO  SPA-GMN-HKNRYO (11)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   10
               MOVE    SYU-HKNTEN (IDX)    TO  SPA-GMN-HKNRYO (IDX)
               ADD     SYU-HKNTEN (IDX)    TO  SPA-GMN-HKNRYO (11)
      *    保険適用外
               COMPUTE SPA-GMN-TGMONEY (IDX)   =   SYU-TGMONEY (IDX)
                                               +   SYU-TGMONEY-TAX(IDX)
      *    保険適用外
      *        ADD     SYU-TGMONEY (IDX)       TO  SPA-GMN-HKNGAI
      *        ADD     SYU-TGMONEY-TAX (IDX)   TO  SPA-GMN-HKNGAI
           END-PERFORM
      *    保険適用外
           COMPUTE SPA-GMN-HKNGAI      =   SYU-TGMONEY (12)
                                       +   SYU-TGMONEY-TAX (12)
      *保険適用金額
           MOVE    SYU-HKNTEKMONEY     TO  SPA-GMN-HKNTEKI
      *    老人一部負担金
           MOVE    SYU-RJN-FTN         TO  SPA-GMN-ROUFTN
           MOVE    SYU-KOH-FTN         TO  SPA-GMN-KOHFTN
      *    自費１
           MOVE    SYU-JIHI-1          TO  SPA-GMN-JIHI1
           MOVE    SYU-JIHI-2          TO  SPA-GMN-JIHI2
           MOVE    SYU-JIHI-3          TO  SPA-GMN-JIHI3
           MOVE    SYU-JIHI-4          TO  SPA-GMN-JIHI4
           MOVE    SYU-JIHI-5          TO  SPA-GMN-JIHI5
      *    自費計
           MOVE    SYU-JIHI-TOTAL      TO  SPA-GMN-JIHIKEI
      *    自費（消費税あり）
           MOVE    SYU-JIHI-1-TAX      TO  SPA-GMN-JIHITAX1
           MOVE    SYU-JIHI-2-TAX      TO  SPA-GMN-JIHITAX2
           MOVE    SYU-JIHI-3-TAX      TO  SPA-GMN-JIHITAX3
           MOVE    SYU-JIHI-4-TAX      TO  SPA-GMN-JIHITAX4
           MOVE    SYU-JIHI-5-TAX      TO  SPA-GMN-JIHITAX5
      *    自費計（消費税あり）
           MOVE    SYU-JIHI-TOTAL-TAX  TO  SPA-GMN-JIHITAXKEI
      *    自費消費税
           MOVE    SYU-JIHI-TAX        TO  SPA-GMN-JIHIZEI
      *    自費合計
           COMPUTE SPA-GMN-JIHIGOK     =   SPA-GMN-JIHIKEI
                                       +   SPA-GMN-JIHIZEI
      *    薬剤一部負担
           MOVE    SYU-YKZ-FTN         TO  SPA-GMN-YKZFTN
      *
      *    一部負担金
           COMPUTE SPA-GMN-ICHIFTN     =   SPA-GMN-ROUFTN
                                       +   SPA-GMN-KOHFTN
                                       +   SPA-GMN-YKZFTN
      *    調整金
           MOVE    SYU-CHOSEI          TO  SPA-GMN-CHOSEI
           MOVE    SPA-GMN-CHOSEI      TO  WRK-Z92
           MOVE    WRK-Z92             TO  SPA-GMN-CHOSEI-X
      *    前回未収
           MOVE    SPA-MISYUMONEY      TO  SPA-GMN-ZENMISYU
      *
      *    労災初診
           MOVE    SYU-RSISHOSHIN-MONEY    TO  SPA-GMN-ROUSYOSIN
      *    労災再診
           MOVE    SYU-RSISAISHIN-MONEY    TO  SPA-GMN-ROUSAISIN
      *    労災指導
           MOVE    SYU-RSISDO-MONEY        TO  SPA-GMN-ROUSIDOU
      *    労災その他
           MOVE    SYU-RSIETC-MONEY        TO  SPA-GMN-ROUETC
      *
           MOVE    SYU-SKYMONEY        TO  SPA-KON-SKYMONEY
           IF      SPA-SYORIFLG        =   1
      *        今回請求額 − 前回請求額
               COMPUTE SPA-NAI-SEIKYU      =   SYU-SKYMONEY
                                           -   WRK-SKYMONEY
      *        クリアの時、ゼロとする
               IF      IDX-KOUI            =   ZERO
                   MOVE    ZERO            TO  SPA-NAI-SEIKYU
               END-IF
           ELSE
               MOVE    SYU-SKYMONEY        TO  SPA-NAI-SEIKYU
           END-IF
      *
      *    初期今回請求額
           COMPUTE SPA-NAI-SEIKYU      =   SPA-NAI-SEIKYU
                                       -   SYU-CHOSEI
      *
      *    合計請求額計算処理
           PERFORM 3101-SEIKYU-KEI-SEC
      *
      *    請求書発行フラグ
           MOVE    "0:発行なし"        TO  SPA-GMN-HAKFLGLST (01)
           MOVE    "1:発行あり"        TO  SPA-GMN-HAKFLGLST (02)
           MOVE    SPA-SKYPRTFLG       TO  SPA-GMN-HAKFLG
           IF     (SPA-GMN-HAKFLG      =   SPACE )  OR
                  (SPA-GMN-SEIGOK      =   ZERO  )
               MOVE    "0"             TO  SPA-GMN-HAKFLG
           END-IF
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               IF      SPA-GMN-HAKFLG      =   SPA-GMN-HAKFLGLST(IDX)
                                                                (1:1)
                   MOVE    SPA-GMN-HAKFLGLST(IDX)  TO  SPA-GMN-HAKFLG-G
               END-IF
           END-PERFORM
      *
      *    院外処方せん発行フラグ
           MOVE    SPA-SYOHOPRTFLG     TO  SPA-GMN-SYOHOPRTFLG
           MOVE    "0:発行なし"        TO  SPA-GMN-SYOHOPRTLST (01)
           MOVE    "1:発行あり"        TO  SPA-GMN-SYOHOPRTLST (02)
           MOVE    "2:院内処方発行"    TO  SPA-GMN-SYOHOPRTLST (03)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               IF      SPA-GMN-SYOHOPRTFLG     =   SPA-GMN-SYOHOPRTLST
                                                          (IDX) (1:1)
                   MOVE    SPA-GMN-SYOHOPRTLST(IDX)
                                           TO  SPA-GMN-SYOHOPRTFLG-G
               END-IF
           END-PERFORM
      *
      *    薬剤情報発行行フラグ
           MOVE    SPA-YAKJYOPRTFLG    TO  SPA-GMN-YAKJYOFLG
           MOVE    "0:発行なし"        TO  SPA-GMN-YAKJYOLST (01)
           MOVE    "1:発行あり"        TO  SPA-GMN-YAKJYOLST (02)
           MOVE    "2:院外分発行"      TO  SPA-GMN-YAKJYOLST (03)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               IF      SPA-GMN-YAKJYOFLG       =   SPA-GMN-YAKJYOLST
                                                          (IDX) (1:1)
                   MOVE    SPA-GMN-YAKJYOLST(IDX)
                                           TO  SPA-GMN-YAKJYOFLG-G
               END-IF
           END-PERFORM
      *
      *    自費名称編集
           PERFORM 3102-JIHIMSG-HEN-SEC
      *
      *    ドクター編集
           PERFORM 3103-DRCD-HEN-SEC
      *
            .
       310-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    自費名称編集処理
      *****************************************************************
       3102-JIHIMSG-HEN-SEC             SECTION.
      *
      *    医療機関情報−所在地、連絡先
           MOVE    SPACE               TO  SYS-1013-REC
           MOVE    "1013"              TO  SYS-1013-KANRICD
           MOVE    ZERO                TO  SYS-1013-STYUKYMD
           MOVE    ALL "9"             TO  SYS-1013-EDYUKYMD
      *    システム管理検索
           MOVE    SYS-1013-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"      TO  ORC-DBPATH
               PERFORM 960-KANRIMST-READ-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-1013-REC
               END-IF
           ELSE
               INITIALIZE                  SYS-1013-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           PERFORM
               UNTIL       FLG-SYSKANRI    =   1
               IF      SPA-NYUGAIKBN       =   SYS-1013-KBNCD(1:1)
                   EVALUATE    SYS-1013-KBNCD(2:1)
                       WHEN    "1"
                           MOVE    SYS-1013-JIHINAME   
                                               TO  SPA-GMN-JIHIMSG (1)
                       WHEN    "2"
                           MOVE    SYS-1013-JIHINAME
                                               TO  SPA-GMN-JIHIMSG (2)
                       WHEN    "3"
                           MOVE    SYS-1013-JIHINAME
                                               TO  SPA-GMN-JIHIMSG (3)
                       WHEN    "4"
                           MOVE    SYS-1013-JIHINAME
                                               TO  SPA-GMN-JIHIMSG (4)
                       WHEN    "5"
                           MOVE    SYS-1013-JIHINAME
                                               TO  SPA-GMN-JIHIMSG (5)
                   END-EVALUATE
               END-IF
      *
               MOVE    "SYSKANRI-KEY2"      TO  ORC-DBPATH
               PERFORM 960-KANRIMST-READ-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-1013-REC
               END-IF
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       3102-JIHIMSG-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ドクター編集処理
      *****************************************************************
       3103-DRCD-HEN-SEC                  SECTION.
      *
      *    職員情報（ドクター）
           MOVE    SPACE               TO  SYS-1010-REC
           INITIALIZE                  SYS-1010-REC
           MOVE    "1010"              TO  SYS-1010-KANRICD
           MOVE    ZERO                TO  SYS-1010-STYUKYMD
           MOVE    ALL "9"             TO  SYS-1010-EDYUKYMD
      *    システム管理検索
           MOVE    SYS-1010-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 960-KANRIMST-READ-SEC
           ELSE
               INITIALIZE                  SYS-1010-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    ZERO                TO  IDX
           PERFORM
                   UNTIL       (IDX            >=   10  )  OR
                               (FLG-SYSKANRI   =   1    )
               MOVE    MCPDATA-REC             TO  SYS-1010-REC
               IF      SYS-1010-KBNCD(1:1)     =   "1"
                   ADD     1                 TO  IDX
                   MOVE    SYS-1010-KBNCD(2:4)
                                             TO  SPA-GMN-DRCDL (IDX)
                   MOVE    SYS-1010-NAME     TO  SPA-GMN-DRCDMEIL(IDX)
               END-IF
      *
               MOVE    "SYSKANRI-KEY2"    TO  ORC-DBPATH
               PERFORM 960-KANRIMST-READ-SEC
           END-PERFORM
      *
           MOVE    IDX                 TO  SPA-DRCD-MAX
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-DRCD-MAX
               IF      SPA-DRCD(2:4)   =   SPA-GMN-DRCDL (IDX)
                   MOVE    SPA-GMN-DRCDLST(IDX) TO  SPA-GMN-DRCD-G
                   MOVE    SPA-DRCD-MAX         TO  IDX
               END-IF
           END-PERFORM
      *
           .
       3103-DRCD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    合計請求額計算処理
      *****************************************************************
       3101-SEIKYU-KEI-SEC                  SECTION.
      *
      *    今回請求額
           COMPUTE SPA-GMN-SEIKYU      =   SPA-NAI-SEIKYU
                                       +   SPA-GMN-CHOSEI
      *
      *    今回入金
           IF      SPA-GMN-SEIKYU      <   ZERO
               MOVE    ZERO            TO  SPA-GMN-NYUKIN
           ELSE
               MOVE    SPA-GMN-SEIKYU  TO  SPA-GMN-NYUKIN
           END-IF
      *
      *    合計請求額
           COMPUTE SPA-GMN-SEIGOK      =   SPA-GMN-SEIKYU
                                       +   SPA-GMN-ZENMISYU
           .
       3101-SEIKYU-KEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＣＬＡＭＥ画面よりの処理
      *****************************************************************
       3009-CLAIM-SYORI-SEC              SECTION.
      *
           IF      SPA-K03X-FLG        =  "OK"
               MOVE    1               TO  FLG-CLAIM
           ELSE
               MOVE    ZERO            TO  FLG-CLAIM
           END-IF
      *
      *    更新処理
           MOVE    1                   TO  FLG-CLAIM-OK
           PERFORM 4500-TOROKU-SYORI-SEC
      *
          .
       3009-CLAIM-SYORI-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC                  SECTION.
      *
           MOVE    SPACE               TO  K03
      *
           MOVE    SPA-PTNUM           TO  K03-PTNUM
           MOVE    SPA-KANANAME        TO  K03-KANANAME
           MOVE    SPA-NAME            TO  K03-NAME
           MOVE    SPA-SEX             TO  K03-SEX
           MOVE    SPA-HKNCOMBIMEI
                                       TO  K03-HKNCOMBI
           MOVE    SPA-FTNRATEMEI      TO  K03-FTNRATE
           MOVE    SPA-SRYYMDW         TO  K03-SRYYMD
           MOVE    SPA-BIRTHDAYW       TO  K03-BIRTHDAY
           MOVE    SPA-SRYKAMEI        TO  K03-SRYKA
      *
      *    年齢
           MOVE    SPA-NENREI-HEN      TO  K03-NENREI
      *
      *    処理
           EVALUATE    SPA-SYORIFLG
               WHEN    0
                   MOVE    SPACE           TO  K03-SYORIMEI-VALUE
               WHEN    1
                   MOVE    "red"           TO  K03-SYORIMEI-STYLE
                   MOVE    "［訂　正］"    TO  K03-SYORIMEI-VALUE
           END-EVALUATE
      *
      *
           MOVE    SPA-GMN-HAKYMD      TO  K03-HAKYMD
           MOVE    SPA-GMN-DENPNUM     TO  K03-DENPNUM(1:)
      *    診療料
           MOVE    SPA-GMN-HKNRYO (01) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-SSUHKNTEN
      *    指導料
           MOVE    SPA-GMN-HKNRYO (02) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-SDOHKNTEN
      *    在宅料
           MOVE    SPA-GMN-HKNRYO (03) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-ZTKHKNTEN
      *    投薬料
           MOVE    SPA-GMN-HKNRYO (04) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-TYKHKNTEN
      *    注射料
           MOVE    SPA-GMN-HKNRYO (05) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-CSYHKNTEN
      *    処置料
           MOVE    SPA-GMN-HKNRYO (06) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-SYCHKNTEN
      *    手術料
           MOVE    SPA-GMN-HKNRYO (07) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-SJTHKNTEN
      *    検査料
           MOVE    SPA-GMN-HKNRYO (08) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-KNSHKNTEN
      *    Ｘ線料
           MOVE    SPA-GMN-HKNRYO (09) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-GZUHKNTEN
      *    その他
           MOVE    SPA-GMN-HKNRYO (10) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-ETCHKNTEN
      *    合計点数
           MOVE    SPA-GMN-HKNRYO (11) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-TOTALHKNTEN
      *    保険適用外
      *    診療料
           MOVE    SPA-GMN-TGMONEY (01) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-SUUTGMONEY
      *    指導料
           MOVE    SPA-GMN-TGMONEY (02) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-SDOTGMONEY
      *    在宅料
           MOVE    SPA-GMN-TGMONEY (03) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-ZTKTGMONEY
      *    投薬料
           MOVE    SPA-GMN-TGMONEY (04) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-TYKTGMONEY
      *    注射料
           MOVE    SPA-GMN-TGMONEY (05) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-CSYTGMONEY
      *    処置料
           MOVE    SPA-GMN-TGMONEY (06) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-SYCTGMONEY
      *    手術料
           MOVE    SPA-GMN-TGMONEY (07) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-SJTGMONEY
      *    検査料
           MOVE    SPA-GMN-TGMONEY (08) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-KNSTGMONEY
      *    Ｘ線料
           MOVE    SPA-GMN-TGMONEY (09) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-GZUTGMONEY
      *    その他
           MOVE    SPA-GMN-TGMONEY (10) TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-ETCTGMONEY
      *
      *    自費
           MOVE    SPA-GMN-JIHI1       TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-JIHI1
           MOVE    SPA-GMN-JIHI2       TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-JIHI2
           MOVE    SPA-GMN-JIHI3       TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-JIHI3
           MOVE    SPA-GMN-JIHI4       TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-JIHI4
           MOVE    SPA-GMN-JIHI5       TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-JIHI5
      *    自費計
           MOVE    SPA-GMN-JIHIKEI     TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-JIHIGOK
      *    自費（消費税あり）
           MOVE    SPA-GMN-JIHITAX1    TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-JIHITAX1
           MOVE    SPA-GMN-JIHITAX2    TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-JIHITAX2
           MOVE    SPA-GMN-JIHITAX3    TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-JIHITAX3
           MOVE    SPA-GMN-JIHITAX4    TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-JIHITAX4
           MOVE    SPA-GMN-JIHITAX5    TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-JIHITAX5
      *    自費計
           MOVE    SPA-GMN-JIHITAXKEI  TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-JIHITAXGOK
      *    自費税
           MOVE    SPA-GMN-JIHIZEI     TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-JIHITAX
      *    自費合計
      **** MOVE    SPA-GMN-JIHIGOK     TO  WRK-Z9
      *****MOVE    WRK-Z9              TO  K03-JIHITOTAL
      *    薬剤一部負担金
           MOVE    SPA-GMN-YKZFTN      TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-YKZFTN
      *    老人一部負担金
           MOVE    SPA-GMN-ROUFTN      TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-RJNFTN
      *    公費一部負担金
           MOVE    SPA-GMN-KOHFTN      TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-KOHFTN
      *    一部負担金計
           MOVE    SPA-GMN-ICHIFTN     TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-FTNTOTAL
      *    保険適用分
           MOVE    SPA-GMN-HKNTEKI     TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-HKNTEKMONEY
      *    保険適用外
           MOVE    SPA-GMN-HKNGAI      TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-HKNTEKGAI
      *    調整金
      *    MOVE    SPA-GMN-CHOSEI      TO  WRK-Z92
      *    MOVE    WRK-Z92             TO  K03-CHOSEI
           MOVE    SPA-GMN-CHOSEI-X    TO  K03-CHOSEI
      *    今回請求額
      *    継続の時今回請求額をゼロする
      *    IF      SPA-CONTKBN         =   "1"
      *        MOVE    SPACE               TO  K03-SKYMONEY
      *        MOVE    SPACE               TO  K03-NYUKIN
      *****ELSE
               MOVE    SPA-GMN-SEIKYU      TO  WRK-Z99
               MOVE    WRK-Z99             TO  K03-SKYMONEY
               MOVE    SPA-GMN-NYUKIN      TO  WRK-Z99
               MOVE    WRK-Z99             TO  K03-NYUKIN
      *****END-IF
      *
      *    前回未収
           MOVE    SPA-GMN-ZENMISYU    TO  WRK-Z92
           MOVE    WRK-Z92             TO  K03-MISYUZAN
      *    合計請求額
           MOVE    SPA-GMN-SEIGOK      TO  WRK-Z99
           MOVE    WRK-Z99             TO  K03-GOKSKY
      *    請求書発行
           MOVE    SPA-GMN-HAKFLG-G    TO  K03-HAKFLG
           MOVE    SPA-GMN-HAKFLGLST(1)    TO  K03-HAKFLG-ITEM (1)
           MOVE    SPA-GMN-HAKFLGLST(2)    TO  K03-HAKFLG-ITEM (2)
           MOVE    2                   TO  K03-HAKFLG-COUNT
      *    請求書発行
           MOVE    SPA-GMN-SYOHOPRTFLG-G   TO  K03-SYOHOPRTFLG
           MOVE    SPA-GMN-SYOHOPRTLST(1)  TO  K03-SYOHOPRT-ITEM (1)
           MOVE    SPA-GMN-SYOHOPRTLST(2)  TO  K03-SYOHOPRT-ITEM (2)
           MOVE    SPA-GMN-SYOHOPRTLST(3)  TO  K03-SYOHOPRT-ITEM (3)
           MOVE    3                   TO  K03-SYOHOPRT-COUNT
      *    薬剤情報発行
           MOVE    SPA-GMN-YAKJYOFLG-G     TO  K03-YAKJYOFLG
           MOVE    SPA-GMN-YAKJYOLST (1)   TO  K03-YAKJYOFLG-ITEM (1)
           MOVE    SPA-GMN-YAKJYOLST (2)   TO  K03-YAKJYOFLG-ITEM (2)
           MOVE    SPA-GMN-YAKJYOLST (3)   TO  K03-YAKJYOFLG-ITEM (3)
           MOVE    3                   TO  K03-YAKJYOFLG-COUNT
      *
      *
      *    自費名称
           MOVE    SPA-GMN-JIHIMSG(1)  TO  K03-JIHIMSG1
           MOVE    SPA-GMN-JIHIMSG(2)  TO  K03-JIHIMSG2
           MOVE    SPA-GMN-JIHIMSG(3)  TO  K03-JIHIMSG3
           MOVE    SPA-GMN-JIHIMSG(4)  TO  K03-JIHIMSG4
           MOVE    SPA-GMN-JIHIMSG(5)  TO  K03-JIHIMSG5
      *
      *    ドクター
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-DRCD-MAX
               MOVE    SPA-GMN-DRCDLST (IDX)  TO  K03-DRCD-ITEM(IDX)
           END-PERFORM
           MOVE    SPA-DRCD-MAX        TO  K03-DRCD-COUNT
           MOVE    SPA-GMN-DRCD-G      TO  K03-DRCD
      *
      *    労災初診
           MOVE    SPA-GMN-ROUSYOSIN   TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-ROUSYOSIN
      *    労災再診
           MOVE    SPA-GMN-ROUSAISIN   TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-ROUSAISIN
      *    労災指導
           MOVE    SPA-GMN-ROUSIDOU    TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-ROUSIDOU
      *    労災その他
           MOVE    SPA-GMN-ROUETC      TO  WRK-Z9
           MOVE    WRK-Z9              TO  K03-ROUETC
      *
           PERFORM 5001-MAPCUR-SEC
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
      *    カーソル指定のない時、入力した項目の次ぎへ
           IF     (SPA-ERRCD           =   SPACE)  AND
                  (SPA-GMN-CUR         =   ZERO )
               PERFORM 50011-INPUT-CUR-SEC
           END-IF
      *
           EVALUATE    SPA-GMN-CUR
               WHEN    01
                   MOVE    "NYUKIN"          TO  MCP-WIDGET
               WHEN    02
                   MOVE    "HAKFLG"          TO  MCP-WIDGET
               WHEN    03
                   MOVE    "SYOHOPRTFLG"      TO  MCP-WIDGET
               WHEN    04
                   MOVE    "YAKJYOFLG"       TO  MCP-WIDGET
               WHEN    05
                   MOVE    "DRCD"            TO  MCP-WIDGET
               WHEN    06
                   MOVE    "CHOSEI"          TO  MCP-WIDGET
               WHEN    07
                   MOVE    "B12"             TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       50011-INPUT-CUR-SEC          SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
      *        入金
               WHEN    "NYUKIN"
                   MOVE    02          TO  SPA-GMN-CUR
      *        調整金
               WHEN    "CHOSEI"
                   MOVE    07          TO  SPA-GMN-CUR
      *       請求発行
               WHEN    "HAKFLG"
                   MOVE    03          TO  SPA-GMN-CUR
      *       院外処方せん発行フラグ
               WHEN    "SYOHOPRTFLG"
                   MOVE    04          TO  SPA-GMN-CUR
      *       薬剤情報発行フラグ
               WHEN    "YAKJYOFLG"
                   IF      (SPA-GMN-SYOHOPRTFLG    =   ZERO )  OR
                           (SPA-DRCD-MAX           =   ZERO )
                       MOVE    7                 TO  SPA-GMN-CUR
                   ELSE
                       MOVE    5                 TO  SPA-GMN-CUR
                   END-IF
      *       ドクター
               WHEN    "DRCD"
                   MOVE    07          TO  SPA-GMN-CUR
           END-EVALUATE
           .
      *
       50011-INPUT-CUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *        調整
               WHEN    "CLICKED"       ALSO    "B02"
                   MOVE    "1"         TO  SPA-NAI-CHOSEI
                   MOVE    6           TO  SPA-GMN-CUR
      *        登録
               WHEN    "CLICKED"       ALSO    "B12"
                    PERFORM 450-TOROKU-SEC
           END-EVALUATE
          .
      *
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
      *    入力個所のセット
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           MOVE    ZERO                TO  SPA-GMN-CUR
      *
      **** MOVE    ZERO                TO  FLG-TOUROKU
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
      *
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC          SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *    基本チェックと別画面処理
           PERFORM 4102-KIHON-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      410-INPUT-CHK-EXT
           END-IF
           .
      *
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ＳＰＡ編集処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC          SECTION.
      *
      *    調整金
           MOVE    K03-CHOSEI          TO  SPA-GMN-CHOSEI-X
      *    入金額
           MOVE    K03-NYUKIN          TO  SPA-GMN-NYUKIN-X
      *
           MOVE    K03-HAKFLG          TO  SPA-GMN-HAKFLG-G
           MOVE    K03-SYOHOPRTFLG     TO  SPA-GMN-SYOHOPRTFLG-G
           MOVE    K03-YAKJYOFLG       TO  SPA-GMN-YAKJYOFLG-G
           MOVE    K03-DRCD            TO  SPA-GMN-DRCD-G
           .
      *
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェックと別画面処理
      *****************************************************************
       4102-KIHON-CHK-SEC          SECTION.
      *
      *    調整金
           PERFORM 410-CHOSEI-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    入金
           PERFORM 450-NYUKIN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    請求発行
           PERFORM 420-SKYKUKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    院外処方せん発行フラグ
           PERFORM 430-SYOHOPRTFLG-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    薬剤情報発行フラグ
           PERFORM 430-YAKJYOFLG-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    ドクター
           PERFORM 440-DRCD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
           .
      *
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入金  入力　処理
      *****************************************************************
       450-NYUKIN-CHK-SEC                SECTION.
      *
      *
           INITIALIZE                      ORCSNUMAREA
           MOVE    SPA-GMN-NYUKIN-X    TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-SEISUU         >   7     )   OR
                  (SNUM-SYOKBN         =   "1"   )
               MOVE    "0007"                  TO  SPA-ERRCD
           ELSE
               MOVE    SNUM-OUTNUM             TO  SPA-GMN-NYUKIN
               MOVE    SPA-GMN-NYUKIN          TO  WRK-Z99
               MOVE    WRK-Z99                 TO  SPA-GMN-NYUKIN-X
      *        今回入金がゼロ以上であること
               IF      SPA-GMN-NYUKIN          <   ZERO
                   MOVE    "0007"              TO  SPA-ERRCD
                   MOVE    1                   TO  SPA-GMN-CUR
                   GO      TO      450-NYUKIN-CHK-EXT
               END-IF
      *        今回入金が請求額以下であること
               IF    ((SPA-GMN-SEIKYU          >=  ZERO  )  AND
                      (SPA-GMN-NYUKIN          >   SPA-GMN-SEIKYU)) OR
                     ((SPA-GMN-SEIKYU          <   ZERO  )  AND
                      (SPA-GMN-NYUKIN          >   ZERO  ))
                   MOVE    "0008"              TO  SPA-ERRCD
                   MOVE    1                   TO  SPA-GMN-CUR
                   GO      TO      450-NYUKIN-CHK-EXT
               END-IF
           END-IF
           .
       450-NYUKIN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    調整金入力　処理
      *****************************************************************
       410-CHOSEI-CHK-SEC                SECTION.
      *
      *
           INITIALIZE                      ORCSNUMAREA
           MOVE    SPA-GMN-CHOSEI-X    TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-SEISUU         >   7     )   OR
                  (SNUM-SYOKBN         =   "1"   )
               MOVE    "0001"              TO  SPA-ERRCD
               MOVE    6                   TO  SPA-GMN-CUR
           ELSE
               MOVE    SNUM-OUTNUM         TO  SPA-GMN-CHOSEI
               MOVE    SPA-GMN-CHOSEI      TO  WRK-Z92
               MOVE    WRK-Z92             TO  SPA-GMN-CHOSEI-X
               IF      SPA-GMN-CHOSEI      NOT =   ZERO
      *            今回請求額がゼロ以上であること
                   COMPUTE WRK-SEIKYU      =   SPA-GMN-CHOSEI
                                           +   SPA-NAI-SEIKYU
                   IF     (WRK-SEIKYU          <   ZERO )  AND
                          (SPA-NAI-SEIKYU      >   ZERO )
                       MOVE    "0004"                  TO  SPA-ERRCD
                       MOVE    06                      TO  SPA-GMN-CUR
                       GO      TO      410-CHOSEI-CHK-EXT
                   END-IF
               END-IF
      *        合計再計算
               PERFORM 3101-SEIKYU-KEI-SEC
      *        合計額がゼロ以下の時、発行なしとする
      *
               EVALUATE    WRK-MCP-WIDGET
      *        調整金
               WHEN    "CHOSEI"
                   IF      SPA-GMN-SEIGOK      <=  ZERO
                       MOVE    SPA-GMN-HAKFLGLST(1)
                                               TO  SPA-GMN-HAKFLG-G
                   END-IF
               END-EVALUATE
           END-IF
           .
       410-CHOSEI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求発行入力　処理
      *****************************************************************
       420-SKYKUKBN-CHK-SEC              SECTION.
      *
      *
           IF      SPA-GMN-HAKFLG      =   SPACE
               MOVE    ZERO                TO  SPA-GMN-HAKFLG
           END-IF
      *
           IF      SPA-GMN-HAKFLG      =   "1" OR  ZERO
               CONTINUE
           ELSE
               MOVE    "0006"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-GMN-CUR
           END-IF
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               IF      SPA-GMN-HAKFLG      =   SPA-GMN-HAKFLGLST(IDX)
                                                                (1:1)
                   MOVE    SPA-GMN-HAKFLGLST(IDX)  TO  SPA-GMN-HAKFLG-G
               END-IF
           END-PERFORM
           .
       420-SKYKUKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    院外処方せん発行フラグ入力　処理
      *****************************************************************
       430-SYOHOPRTFLG-CHK-SEC              SECTION.
      *
           IF      SPA-GMN-SYOHOPRTFLG   =   SPACE
               MOVE    ZERO              TO  SPA-GMN-SYOHOPRTFLG-G
           END-IF
      *
           EVALUATE    SPA-GMN-SYOHOPRTFLG
               WHEN    ZERO
               WHEN    1
               WHEN    2
                   CONTINUE
               WHEN    OTHER
                   MOVE    "0009"            TO  SPA-ERRCD
                   MOVE    3                 TO  SPA-GMN-CUR
           END-EVALUATE
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               IF      SPA-GMN-SYOHOPRTFLG     =   SPA-GMN-SYOHOPRTLST
                                                          (IDX) (1:1)
                   MOVE    SPA-GMN-SYOHOPRTLST(IDX)
                                           TO  SPA-GMN-SYOHOPRTFLG-G
               END-IF
           END-PERFORM
      *
           .
       430-SYOHOPRTFLG-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ドクター入力　処理
      *****************************************************************
       440-DRCD-CHK-SEC              SECTION.
      *
           IF      SPA-GMN-DRCD-G      =   SPACE
               MOVE    SPACE               TO  SPA-DRCD
               GO      TO      440-DRCD-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-CHK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-DRCD-MAX
               IF      SPA-GMN-DRCD        =   SPA-GMN-DRCDL (IDX)
                   MOVE    SPA-GMN-DRCDLST (IDX)
                                           TO  SPA-GMN-DRCD-G
                   MOVE    1               TO  FLG-CHK
                   MOVE    SPA-DRCD-MAX    TO  IDX
               END-IF
           END-PERFORM
      *
           IF      FLG-CHK             =   1
      *        ＳＰＡ変更
               MOVE    "1"                 TO  SPA-DRCD(1:1)
               MOVE    SPA-GMN-DRCD        TO  SPA-DRCD(2:)
           ELSE
               MOVE    "0011"              TO  SPA-ERRCD
               MOVE    5                   TO  SPA-GMN-CUR
           END-IF
      *
           .
       440-DRCD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    薬剤情報発行フラグ入力　処理
      *****************************************************************
       430-YAKJYOFLG-CHK-SEC              SECTION.
      *
           IF      SPA-GMN-YAKJYOFLG   =   SPACE
               MOVE    ZERO                TO  SPA-GMN-YAKJYOFLG
           END-IF
      *
           MOVE    ZERO                TO  FLG-CHK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   3   )  OR
                              (FLG-CHK NOT =   ZERO )
               IF      SPA-GMN-YAKJYOFLG   =   SPA-GMN-YAKJYOLST (IDX)
                                                               (1:1)
                   MOVE    SPA-GMN-YAKJYOLST (IDX)
                                           TO  SPA-GMN-YAKJYOFLG-G
                   MOVE    1               TO  FLG-CHK
               END-IF
           END-PERFORM
      *
           IF      FLG-CHK               =   ZERO
               MOVE    "0010"            TO  SPA-ERRCD
               MOVE    4                 TO  SPA-GMN-CUR
           END-IF
      *
           .
       430-YAKJYOFLG-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                        SECTION.
      *
      *    調整金
           MOVE    SPA-GMN-CHOSEI      TO  SPA-K03-CHOSEI
      *    請求書作成区分
      *D   MOVE    SPA-GMN-HAKFLG      TO  SPA-K03-SKYKUKBN
      *
           MOVE    "NO"                TO  SPA-ERRMSG(1:2)
      *
           MOVE    "K02"               TO  SPA-SAKIPG
           MOVE    "K03"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPA-K01KYOUTU       TO  SPA-WORK
      *
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
      **** MOVE    "JOIN"              TO  MCP-PUTTYPE.
           MOVE    "K02"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    確定　処理
      *****************************************************************
       450-TOROKU-SEC             SECTION.
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           IF      SPA-ERRCD      NOT =   SPACE
               GO      TO      450-TOROKU-EXT
           END-IF
      *
           MOVE    ZERO                TO  IDX-KOUI
           MOVE    SPA-TERMID          TO  FILE-TERMID2
           OPEN    INPUT               PARA-FILE
           PERFORM 980-PARA-READ-SEC
      *
           PERFORM
               UNTIL   FLG-PARA        NOT =   ZERO 
               IF      PARA-FILEMEI        =   "SYUNOU"
      *            パラメタの収納データ読込
                   MOVE    PARA-DATA-REC       TO  SYUNOU-REC
               END-IF
      *        診療行為カウント
               IF      PARA-FILEMEI        =   "WKSRYACT"
                   ADD     1                   TO  IDX-KOUI
               END-IF
      *
               PERFORM 980-PARA-READ-SEC
           END-PERFORM
      *
           CLOSE                        PARA-FILE
      *
      *    訂正時、受診履歴等の削除
           IF      SPA-SYORIFLG         =   1
      *        訂正時、診療行為が無かった時、確認表示へ
               IF      IDX-KOUI         =   ZERO
                   MOVE    "0101"           TO  SPA-KIDCD
                   GO      TO      450-TOROKU-EXT
               END-IF
           END-IF
      *    ＣＬＡＩＭ接続チェック処理
           PERFORM 4905-CLAIM-CHK-SEC
           IF      FLG-CLAIM           =   2
                GO      TO      450-TOROKU-EXT
           END-IF
      *
      *    更新処理
           MOVE    ZERO                TO  FLG-CLAIM-OK
           PERFORM 4500-TOROKU-SYORI-SEC
           .
       450-TOROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録・更新処理
      *****************************************************************
       4500-TOROKU-SYORI-SEC             SECTION.
      *
      *    登録・更新処理
           IF      SPA-KIDCD           =   SPACE
               PERFORM 45001-TOROKU-KOUSIN-SEC
               IF     (SPA-ERRCD       NOT =   SPACE )   OR
                      (SPA-KIDCD       NOT =   SPACE )
                   GO  TO      4500-TOROKU-SYORI-EXT
               END-IF
               IF      FLG-CLAIM-OK        =   ZERO
                   MOVE    "CHANGE"            TO  WRK-MCP-PUTTYPE
               ELSE
                   MOVE    "JOIN"              TO  WRK-MCP-PUTTYPE
               END-IF
           ELSE
      *        訂正時、受診履歴等の削除
               PERFORM 450012-TEISEI-DELETE-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   GO  TO      4500-TOROKU-SYORI-EXT
               END-IF
               MOVE    "JOIN"              TO  WRK-MCP-PUTTYPE
           END-IF
      *
      *    共通のキーをクリアする
      *
           MOVE    SPACE               TO  SPA-ERRMSG
           INITIALIZE                      SPA-KYOTUKEY
           INITIALIZE                      SPA-K01KYOUTU
           MOVE    SPA-K01KYOUTU       TO  SPA-WORK
      *
           MOVE    SPACE               TO  LINKAREA
      *
      *****MOVE    "K01"               TO  SPA-SAKIPG
           MOVE    "K02"               TO  SPA-SAKIPG
           MOVE    "K03"               TO  SPA-MOTOPG
      *
      *****MOVE    "CHANGE"            TO  MCP-PUTTYPE
           MOVE    WRK-MCP-PUTTYPE     TO  MCP-PUTTYPE
           MOVE    "K02"               TO  MCP-WINDOW
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
       4500-TOROKU-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録・更新処理
      *****************************************************************
       45001-TOROKU-KOUSIN-SEC          SECTION.
      *
           MOVE    ZERO                TO  IDX-KOUI
           MOVE    SPA-TERMID          TO  FILE-TERMID2
           OPEN    INPUT               PARA-FILE
           PERFORM 980-PARA-READ-SEC
      *
           PERFORM
               UNTIL   FLG-PARA        NOT =   ZERO 
               IF      PARA-FILEMEI        =   "SYUNOU"
      *            パラメタの収納データ読込
                   MOVE    PARA-DATA-REC       TO  SYUNOU-REC
               END-IF
      *        診療行為カウント
               IF      PARA-FILEMEI        =   "WKSRYACT"
                   ADD     1                   TO  IDX-KOUI
               END-IF
      *
               PERFORM 980-PARA-READ-SEC
           END-PERFORM
      *
           CLOSE                        PARA-FILE
      *
      *    訂正時、受診履歴等の削除
           IF      SPA-SYORIFLG         =   1
               PERFORM 450011-TEISEI-SYORI-SEC
           END-IF
      *
      *    収納マスタを更新する
           PERFORM 4501-SYUNOU-OUT-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO  TO      45001-TOROKU-KOUSIN-EXT
           END-IF
      *
      *    剤番号テーブル
           INITIALIZE                  WRK-TBL-ZAINUM-AREA
      *    受診履歴初期処理
           PERFORM 45001-JYURRK-SYORI1-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO  TO      45001-TOROKU-KOUSIN-EXT
           END-IF
      *
           IF      SPA-SYORIFLG        =   ZERO
      *    診療科履歴初期処理
               PERFORM 45009-SRYKARRK-SYOKI-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   GO  TO      45001-TOROKU-KOUSIN-EXT
               END-IF
           END-IF
      *
      *    初診料算定のみの時初診料を算定する
           IF      SPA-SYOSIN-YMD  NOT =   SPACE
               MOVE    SPA-SYOSIN-YMD      TO  WRK-SRYYMD
               MOVE    SPA-SYOSIN-SRYCD    TO  WRK-SRYCD
               MOVE    WRK-SRYCD           TO  TNS-SRYCD
               PERFORM 910-TENSU-READ-SEC
      *
               IF      TNS-SANTEIRRKKBN    NOT =   ZERO
                   MOVE    ZERO            TO  FLG-TOKTEI
                   MOVE    1               TO  WRK-KAISU
                   PERFORM 45021-SANTEI-UPD-SEC
               END-IF
           END-IF
           MOVE    SPACE               TO  WRK-SRYYMD
      *
      *    診療行為マスター更新
           MOVE    ZERO                TO  FLG-PARA
           MOVE    SPACE               TO  LNK-WKSRYACT-AREA
           MOVE    ZERO                TO  IDX-KOUI
      *
           MOVE    SPA-TERMID          TO  FILE-TERMID2
           OPEN    INPUT               PARA-FILE
           PERFORM 980-PARA-READ-SEC
      *
           PERFORM
                   UNTIL       FLG-PARA   =    1
               IF      PARA-FILEMEI        =   "WKSRYACT"
                   MOVE    PARA-DATA-REC    TO  WRK-WKSRYACT-REC
      *
                   IF     (IDX-KOUI        >   ZERO  )  AND
                          (WRK-WKSRY-ZAINUM     NOT =
                                           LNK-WKSRY-ZAINUM (IDX-KOUI))
      *                剤毎に処理を行う
                       PERFORM 4501-SRYACT-KOU-SEC
                       PERFORM 45001-JYURRK-SYORI2-SEC
                       MOVE    SPACE           TO  LNK-WKSRYACT-AREA
                       MOVE    ZERO            TO  IDX-KOUI
                   END-IF
                   ADD     1               TO  IDX-KOUI
                   MOVE    PARA-DATA-REC   TO  LNK-WKSRYACT-REC
                                                            (IDX-KOUI)
               ELSE
                   IF      IDX-KOUI        >   ZERO
                       PERFORM 4501-SRYACT-KOU-SEC
                       PERFORM 45001-JYURRK-SYORI2-SEC
                       MOVE    SPACE           TO  LNK-WKSRYACT-AREA
                       MOVE    ZERO            TO  IDX-KOUI
                   END-IF
               END-IF
      *
               PERFORM 980-PARA-READ-SEC
           END-PERFORM
      *
           CLOSE                       PARA-FILE
      *
           IF      IDX-KOUI        >   ZERO
               PERFORM 4501-SRYACT-KOU-SEC
               PERFORM 45001-JYURRK-SYORI2-SEC
           END-IF
      *
      *    受診履歴作成終了処理
           PERFORM 45001-JYURRK-SYORI3-SEC
      *
      *
           IF      SPA-SYORIFLG        =   ZERO
      *        診療科履歴作成終了処理
               PERFORM 45009-SRYKARRK-OUT-SEC
           END-IF
      *
      *    ワーク診療行為マスタ−が存在した時、削除する
           PERFORM 45002-WKSRYACT-DEL-SEC
      *    受診内容データに時間を設定し、更新する
           PERFORM 45003-UKETUKE-SEC
      *
      *    各帳票印刷
           PERFORM 45009-PRINT-SEC
      *
      *    ＣＬＡＩＭ送信
           IF      FLG-CLAIM           =   1
               PERFORM 4906-CLAIM-SOUSIN-SEC
           END-IF
      *
           .
       45001-TOROKU-KOUSIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納マスタ更新処理
      *****************************************************************
       4501-SYUNOU-OUT-SEC             SECTION.
      *
      *    パラメタの収納データ読込
      *    MOVE    SPACE               TO  PARA-REC
      *    MOVE    SPA-TERMID          TO  PARA-TERMID
      *    MOVE    "SYUNOU"            TO  PARA-FILEMEI
      *    MOVE    01                  TO  PARA-EDANUM
      *    PERFORM 980-PARA-READ-SEC
      *    IF      FLG-PARA            =   ZERO
      *        MOVE    PARA-DATA-REC       TO  SYUNOU-REC
      *    ELSE
      *        MOVE    "0001"              TO  SPA-ERRCD
      *        GO      TO      4501-SYUNOU-OUT-EXT
      **** END-IF
      *
           IF      SPA-SYORIFLG        =   ZERO
      *        システム管理より、伝票番号を取得する
               PERFORM 45001-DENPNUM-SET-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   GO      TO      4501-SYUNOU-OUT-EXT
               END-IF
      *
           ELSE
               MOVE    SPA-DENPNUM     TO  WRK-DENPNUM
           END-IF
      *
           MOVE    WRK-DENPNUM         TO  SYU-DENPNUM
      *    伝票番号発行日
           MOVE    SPA-SYSYMD          TO  SYU-DENPPRTYMD
      *
      *    調整金
           MOVE    SPA-GMN-CHOSEI      TO  SYU-CHOSEI
      *    請求書作成区分
           MOVE    SPA-GMN-HAKFLG      TO  SYU-SKYKUKBN
      *    請求額
           COMPUTE SYU-SKYMONEY        =   SPA-KON-SKYMONEY
                                       +   SYU-CHOSEI
           MOVE    SYU-SKYMONEY        TO  WRK-KON-SKYMONEY
      *    入金額
      *****MOVE    SPA-GMN-SEIKYU      TO  SYU-NYUKIN-TOTAL
           MOVE    SPA-GMN-NYUKIN      TO  SYU-NYUKIN-TOTAL
      *    入金回数
           MOVE    1                   TO  SYU-NYUKIN-KAISU
      *    伝票状態区分
           MOVE    SYU-DENPJTIKBN      TO  WRK-DENPJTIKBN
           IF      SYU-SKYMONEY        =   ZERO
               MOVE    SPACE               TO  SYU-DENPJTIKBN
           ELSE
               IF      SYU-SKYMONEY        <=  SYU-NYUKIN-TOTAL
                   MOVE    "1"                 TO  SYU-DENPJTIKBN
               ELSE
                   MOVE    "2"                 TO  SYU-DENPJTIKBN
               END-IF
           END-IF
      *    継続区分判定
           IF      SPA-SYORIFLG        =   ZERO
               IF      SPA-CONTKBN         =   "1"
                   MOVE    "7"                 TO  SYU-DENPJTIKBN
                   IF      SPA-DOUJI-DENPNUM   =   ZERO
                       MOVE    SYU-DENPNUM     TO  SPA-DOUJI-DENPNUM
                   END-IF
      ********     入金額を今回請求額とする
      *********    MOVE    SYU-SKYMONEY        TO  SYU-NYUKIN-TOTAL
               END-IF
      *        継続区分
               MOVE    SPA-CONTKBN         TO  SYU-CONTKBN
           ELSE
      *        継続区分
               IF      SPA-CONTKBN         =   SYU-CONTKBN
                   MOVE    SYU-DOUJI-DENPNUM   TO  SPA-DOUJI-DENPNUM
                   IF      SPA-CONTKBN         =   "1"
                       IF      WRK-DENPJTIKBN      =   "7"
                           MOVE    "7"             TO  SYU-DENPJTIKBN
                       END-IF
                   END-IF
               ELSE
                   EVALUATE    SPA-CONTKBN
      *                継続区分がなくなった時
                       WHEN    "0"
      *********************MOVE    "1"         TO  SYU-DENPJTIKBN
                           MOVE    ZERO        TO  SPA-DOUJI-DENPNUM
      *                継続区分に変更
                       WHEN    "1"
                           MOVE    "7"         TO  SYU-DENPJTIKBN
                           MOVE    SYU-DENPNUM TO  SPA-DOUJI-DENPNUM
                   END-EVALUATE
               END-IF
      *        継続区分
               MOVE    SPA-CONTKBN         TO  SYU-CONTKBN
           END-IF
      *
      *    院外処方区分
           MOVE    SPA-INGAIKBN        TO  SYU-INGAISHOHOKBN
      *    同時診療伝票番号
           MOVE    SPA-DOUJI-DENPNUM   TO  SYU-DOUJI-DENPNUM
      *
           IF      SPA-SYORIFLG        =   ZERO
      *
               MOVE    SYUNOU-REC          TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   MOVE    SYUNOU-REC          TO  MCPDATA-REC
                   MOVE    "DBUPDATE"          TO  MCP-FUNC
                   MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
               END-IF
      *****ELSE
      *        MOVE    SYUNOU-REC          TO  MCPDATA-REC
      *        MOVE    "DBUPDATE"          TO  MCP-FUNC
      *        MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
      *        CALL    "MCPDBSUB"          USING
      *                                    MCPAREA
      *                                    MCPDATA-REC
      *        IF      MCP-RC          NOT =   ZERO
      *            MOVE    SYUNOU-REC          TO  MCPDATA-REC
      *            MOVE    "DBINSERT"          TO  MCP-FUNC
      *            MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
      *            CALL    "MCPDBSUB"          USING
      *                                        MCPAREA
      *                                        MCPDATA-REC
      ******** END-IF
           END-IF
           MOVE    SYUNOU-REC          TO  WRK-SYUNOU-REC
      *
      *    訂正の時、収納を読み、あれば更新、なければ追加とする
           IF      SPA-SYORIFLG    NOT =   ZERO
      *
               MOVE    SYUNOU-REC          TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
                   PERFORM 980-SYUNOU-READ-SEC
               ELSE
                   MOVE    1               TO  FLG-SYUNOU
               END-IF
               MOVE    "DBCLOSE"           TO  MCP-FUNC
               MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *        請求金額
               MOVE    SYU-SKYMONEY        TO  WRK-SKYMONEY
      *        入金合計額
               MOVE    SYU-NYUKIN-TOTAL    TO  WRK-NYUKIN-TOTAL
      *        入金回数
               MOVE    SYU-NYUKIN-KAISU    TO  WRK-NYUKIN-KAISU
      *
               MOVE    WRK-SYUNOU-REC      TO  SYUNOU-REC
      *        入金合計額
               IF      SPA-GMN-NYUKIN      >   ZERO
                   COMPUTE SYU-NYUKIN-TOTAL    =   WRK-NYUKIN-TOTAL
                                               +   SPA-GMN-NYUKIN
                   MOVE    WRK-NYUKIN-KAISU    TO  SYU-NYUKIN-KAISU
                   ADD   1                     TO  SYU-NYUKIN-KAISU
               ELSE
                   MOVE    WRK-NYUKIN-TOTAL    TO  SYU-NYUKIN-TOTAL
                   MOVE    WRK-NYUKIN-KAISU    TO  SYU-NYUKIN-KAISU
               END-IF
      *        伝票状態区分
               IF      SYU-DENPJTIKBN  NOT =   "7"
                   IF      SYU-SKYMONEY        >   SYU-NYUKIN-TOTAL
                       MOVE    "2"             TO  SYU-DENPJTIKBN
                   ELSE
                       MOVE    "1"             TO  SYU-DENPJTIKBN
                   END-IF
               END-IF
               IF      FLG-SYUNOU          =   ZERO
                   MOVE    SYUNOU-REC          TO  MCPDATA-REC
                   MOVE    "DBUPDATE"          TO  MCP-FUNC
                   MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
      *            収納明細マスター作成
                   PERFORM 45001-SINMEI-SYORI2-SEC
               ELSE
                   MOVE    SYUNOU-REC          TO  MCPDATA-REC
                   MOVE    "DBINSERT"          TO  MCP-FUNC
                   MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
      *
      *            収納明細マスター作成
                   PERFORM 45001-SINMEI-SYORI-SEC
               END-IF
           END-IF
      *
      *
           IF      SPA-SYORIFLG        =   ZERO
      *        収納明細マスター作成
               PERFORM 45001-SINMEI-SYORI-SEC
      *
      *        継続が確定した時、伝票状態区分を更新する
               IF      SPA-CONTKBN         =   "2"
                   PERFORM 45011-SYUNOU-UPD-SEC
               END-IF
           END-IF
      *
           MOVE    WRK-SYUNOU-REC      TO  SYUNOU-REC
      *
           .
       4501-SYUNOU-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *   伝票状態区分更新処理
      *****************************************************************
       45011-SYUNOU-UPD-SEC            SECTION.
      *
      *    同時診療伝票番号を検索する
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY3"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYUNOU-KEY3"       TO  ORC-DBPATH
               PERFORM 900-SYUNOU-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SYUNOU
           END-IF
           PERFORM UNTIL    FLG-SYUNOU     =   1
               IF      SYU-DENPJTIKBN      =   "7"
      *            伝票状態区分
                   MOVE    "1"                 TO  SYU-DENPJTIKBN
               END-IF
      *        収納明細更新
               PERFORM 45012-SYUMEI-UPD-SEC
      *
               MOVE    SYUNOU-REC          TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "K03 SYUNOU UPD ERR:"  MCP-RC
               END-IF
      *
               MOVE    "SYUNOU-KEY3"       TO  ORC-DBPATH
               PERFORM 900-SYUNOU-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUNOU-KEY3"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       45011-SYUNOU-UPD-EXT.
           EXIT.
      *
      *****************************************************************
      *   伝票状態区分更新処理
      *****************************************************************
       45012-SYUMEI-UPD-SEC                SECTION.
      *
           INITIALIZE                      SYUMEI-REC
           MOVE    SYU-HOSPID          TO  SMEI-HOSPID
           MOVE    SYU-NYUGAIKBN       TO  SMEI-NYUGAIKBN
           MOVE    SYU-PTID            TO  SMEI-PTID
           MOVE    SYU-DENPNUM         TO  SMEI-DENPNUM
      *
           MOVE    SYUMEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUMEI-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYUMEI-KEY2"       TO  ORC-DBPATH
               PERFORM 900-SYUMEI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SYUMEI
           END-IF
           PERFORM UNTIL    FLG-SYUMEI     =   1
               IF      SMEI-JOUTAIKBN      =   "7"
      *            伝票状態区分
                   MOVE    "1"                 TO  SMEI-JOUTAIKBN
               END-IF
      *
               MOVE    SYUMEI-REC          TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "SYUMEI-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "K03 SYUMEI UPD ERR:"  MCP-RC
               END-IF
      *
               MOVE    "SYUMEI-KEY2"       TO  ORC-DBPATH
               PERFORM 900-SYUMEI-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUMEI-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       45012-SYUMEI-UPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理より、伝票番号取得処理
      *****************************************************************
       45001-DENPNUM-SET-SEC            SECTION.
      *
           INITIALIZE                  SYS-0041-REC.
           MOVE    "0041"              TO  SYS-0041-KANRICD
           MOVE    "*"                 TO  SYS-0041-KBNCD
           MOVE    ZERO                TO  SYS-0041-STYUKYMD
           MOVE    ALL "9"             TO  SYS-0041-EDYUKYMD
      *
           MOVE    SYS-0041-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 960-KANRIMST-READ-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  SYS-0041-REC
               ELSE
                   INITIALIZE                  SYS-0041-REC
               END-IF
           ELSE
               INITIALIZE                  SYS-0041-REC
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF      FLG-SYSKANRI        =   ZERO
               ADD     1                   TO  SYS-0041-DENPNUMMAX
               MOVE    SYS-0041-DENPNUMMAX
                                           TO  WRK-DENPNUM
      *
               MOVE    SYS-0041-REC        TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC         NOT  =   ZERO
                   MOVE    "0005"              TO  SPA-ERRCD
                   DISPLAY "K03 SYSKANRI UPDATE:" MCP-RC
               END-IF
           ELSE
               MOVE    "0005"              TO  SPA-ERRCD
               DISPLAY "K03 DENPNUM-SET ERR:" MCP-RC
           END-IF
      *
           .
       45001-DENPNUM-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納明細マスター作成処理
      *****************************************************************
       45001-SINMEI-SYORI-SEC          SECTION.
      *
           MOVE    SPACE               TO  SYUMEI-REC
           INITIALIZE                      SYUMEI-REC
           MOVE    SYU-HOSPID          TO  SMEI-HOSPID
           MOVE    SYU-NYUGAIKBN       TO  SMEI-NYUGAIKBN
           MOVE    SYU-PTID            TO  SMEI-PTID
      *伝票番号
           MOVE    SYU-DENPNUM         TO  SMEI-DENPNUM
      *伝票番号枝番
           MOVE    01                  TO  SMEI-DENPEDANUM
      *伝票状態区分
           MOVE    SPACE               TO  SMEI-MEISAIJOUTAIKBN
      *請求発行日（発行日の西暦）
           MOVE    SPA-SYSYMD          TO  SMEI-SKYPRINTYMD
      *請求再発行日
           MOVE    SPACE               TO  SMEI-SKYREPRINTYMD
      *領収書発行日
           MOVE    SMEI-SKYPRINTYMD    TO  SMEI-RYOSYUPRINTYMD
      *領収書再発行日
           MOVE    SPACE               TO  SMEI-RYOSYUREPRINTYMD
      *請求金額
           MOVE    WRK-KON-SKYMONEY    TO  SMEI-SKYMONEY
      *入返金日
           MOVE    SMEI-SKYPRINTYMD    TO  SMEI-NYUHEN-YMD
      *入金連番
           MOVE    01                  TO  SMEI-NYUKINRENNUM
      *
      *    入金額がゼロの時、入金力なし
           IF      SPA-GMN-NYUKIN      =   ZERO
               CONTINUE
           ELSE
      *入返金区分
               MOVE    "1"                 TO  SMEI-NYUHEN-KBN
      *入返金額
               MOVE    SPA-GMN-NYUKIN      TO  SMEI-NYUHEN-MONEY
      *入金方法
               MOVE    "01"                TO  SMEI-NYUKIN-HOHO
           END-IF
      *状態区分
           IF      SYU-SKYMONEY        =   ZERO
               MOVE    SPACE               TO  SMEI-JOUTAIKBN
           ELSE
               MOVE    "1"                 TO  SMEI-JOUTAIKBN
           END-IF
      *    継続区分判定
           IF      SPA-CONTKBN         =   "1"
               MOVE    "7"                 TO  SMEI-JOUTAIKBN
           END-IF
      *
           MOVE    SYUMEI-REC          TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "SYUMEI-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               MOVE    "0005"          TO  SPA-ERRCD
               DISPLAY "K03 SINMEI-SYORI ERR:" SPA-ERRCD
           END-IF
      *
           .
       45001-SINMEI-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納明細マスター作成処理（訂正時）
      *****************************************************************
       45001-SINMEI-SYORI2-SEC          SECTION.
      *
           INITIALIZE                      SYUMEI-REC
           MOVE    SYU-HOSPID          TO  SMEI-HOSPID
           MOVE    SYU-NYUGAIKBN       TO  SMEI-NYUGAIKBN
           MOVE    SYU-PTID            TO  SMEI-PTID
           MOVE    SYU-DENPNUM         TO  SMEI-DENPNUM
      *
           MOVE    SYUMEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUMEI-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYUMEI-KEY2"       TO  ORC-DBPATH
               PERFORM 900-SYUMEI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SYUMEI
           END-IF
           MOVE    ZERO                TO  WRK-DENPEDANUM
           MOVE    ZERO                TO  WRK-NYUKINRENNUM
           PERFORM UNTIL    FLG-SYUMEI     =   1
               IF      SMEI-DENPEDANUM     >   WRK-DENPEDANUM
                   MOVE    SMEI-DENPEDANUM     TO  WRK-DENPEDANUM
               END-IF
               IF      SMEI-NYUKINRENNUM   >   WRK-NYUKINRENNUM
                   MOVE    SMEI-NYUKINRENNUM   TO  WRK-NYUKINRENNUM
               END-IF
      *
               MOVE    "SYUMEI-KEY2"       TO  ORC-DBPATH
               PERFORM 900-SYUMEI-READ-SEC
           END-PERFORM
      *
           MOVE    SPACE               TO  SYUMEI-REC
           INITIALIZE                      SYUMEI-REC
           MOVE    SYU-HOSPID          TO  SMEI-HOSPID
           MOVE    SYU-NYUGAIKBN       TO  SMEI-NYUGAIKBN
           MOVE    SYU-PTID            TO  SMEI-PTID
      *伝票番号
           MOVE    SYU-DENPNUM         TO  SMEI-DENPNUM
      *伝票番号枝番
           ADD     1                   TO  WRK-DENPEDANUM
           MOVE    WRK-DENPEDANUM      TO  SMEI-DENPEDANUM
      *入金連番
           ADD     1                   TO  WRK-NYUKINRENNUM
           MOVE    WRK-NYUKINRENNUM    TO  SMEI-NYUKINRENNUM
      *伝票状態区分
           MOVE    SPACE               TO  SMEI-MEISAIJOUTAIKBN
      *請求発行日（発行日の西暦）
           MOVE    SPA-SYSYMD          TO  SMEI-SKYPRINTYMD
      *請求再発行日
           MOVE    SPACE               TO  SMEI-SKYREPRINTYMD
      *領収書発行日
           MOVE    SPACE               TO  SMEI-RYOSYUPRINTYMD
      *領収書再発行日
           MOVE    SPACE               TO  SMEI-RYOSYUREPRINTYMD
      *請求金額
           IF      SYU-SKYMONEY    NOT =   WRK-SKYMONEY
               COMPUTE SMEI-SKYMONEY       =   SYU-SKYMONEY
                                           -   WRK-SKYMONEY
           ELSE
               MOVE    ZERO                TO  SMEI-SKYMONEY
           END-IF
      *
      *入返金日
           MOVE    SMEI-SKYPRINTYMD    TO  SMEI-NYUHEN-YMD 
      *
      *    入金額がゼロの時、入金力なし
           IF      SPA-GMN-NYUKIN      =   ZERO
               CONTINUE
           ELSE
      *入返金区分
               MOVE    "1"                 TO  SMEI-NYUHEN-KBN
      *入返金額
               MOVE    SPA-GMN-NYUKIN      TO  SMEI-NYUHEN-MONEY
      *入金方法
               MOVE    "01"                TO  SMEI-NYUKIN-HOHO
           END-IF
      *状態区分
           MOVE    "8"                 TO  SMEI-JOUTAIKBN
      *
           MOVE    SYUMEI-REC          TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "SYUMEI-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               MOVE    "0005"          TO  SPA-ERRCD
               DISPLAY "K03 SINMEI-SYORI ERR:" SPA-ERRCD
           END-IF
      *
           .
       45001-SINMEI-SYORI2-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴作成処理（初期処理）
      *****************************************************************
       45001-JYURRK-SYORI1-SEC          SECTION.
      *
      *    訂正時、受診履歴等の削除
           IF      SPA-SYORIFLG         =   1
      *********PERFORM 450011-TEISEI-SYORI-SEC
               GO      TO      45001-JYURRK-SYORI1-EXT
           END-IF
      *
      *    受診履歴の同日作成分カウント
           MOVE    ZERO                TO  WRK-JYURRK-RENNUM
           MOVE    ZERO                TO  WRK-JYURRK-EDANUM
           MOVE    ZERO                TO  WRK-JYURRK-DOUJI-RENNUM
           IF      SPA-DOUJI-RENNUM    NOT =   ZERO
               MOVE    SPA-DOUJI-RENNUM    TO  WRK-JYURRK-RENNUM
           END-IF
           MOVE    ZERO                TO  WRK-KAIKEI-RENNUM
      *
           MOVE    SPACE               TO  JYURRK-REC
           INITIALIZE                      JYURRK-REC
           MOVE    SYU-HOSPID          TO  JYURRK-HOSPID
           MOVE    SYU-PTID            TO  JYURRK-PTID
           MOVE    SPA-NYUGAIKBN       TO  JYURRK-NYUGAIKBN
           MOVE    SYU-SRYKA           TO  JYURRK-SRYKA
           MOVE    SYU-SRYYMD          TO  JYURRK-SRYYMD
           IF      SPA-DOUJI-RENNUM    =   ZERO
               MOVE    "JYURRK-KEY4"       TO  WRK-PATH
           ELSE
               MOVE    SPA-DOUJI-RENNUM    TO  JYURRK-RENNUM
               MOVE    "JYURRK-KEY5"       TO  WRK-PATH
           END-IF
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-PATH            TO  ORC-DBPATH
               PERFORM 970-JYURRK-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-JYURRK
           END-IF
           PERFORM
                   UNTIL       FLG-JYURRK      =   1
               IF      SPA-DOUJI-RENNUM    =   ZERO
                   MOVE    JYURRK-RENNUM       TO  WRK-JYURRK-RENNUM
               ELSE
                   MOVE    JYURRK-DOUJI-RENNUM TO
                                           WRK-JYURRK-DOUJI-RENNUM
               END-IF
      *
               MOVE    WRK-PATH            TO  ORC-DBPATH
               PERFORM 970-JYURRK-NEXT-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    連番の設定
           IF      SPA-DOUJI-RENNUM    =   ZERO
               ADD     1                   TO  WRK-JYURRK-RENNUM
           END-IF
           IF      SPA-CONTKBN         =   "1"  OR  "2"
               ADD     1                   TO  WRK-JYURRK-DOUJI-RENNUM
           ELSE
               MOVE    ZERO                TO  WRK-JYURRK-DOUJI-RENNUM
           END-IF
      *    初期編集
           PERFORM 45001-JYURRK-SYOKI-SEC
      *
           .
       45001-JYURRK-SYORI1-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴作成処理（初期）
      *****************************************************************
       45001-JYURRK-SYOKI-SEC          SECTION.
      *    枝番
           ADD     1                   TO  WRK-JYURRK-EDANUM
      *
      *受診履歴レコードの作成
           MOVE    SPACE               TO  JYURRK-REC
           INITIALIZE                      JYURRK-REC
           MOVE    SYU-HOSPID          TO  JYURRK-HOSPID
           MOVE    SYU-PTID            TO  JYURRK-PTID
           MOVE    SPA-NYUGAIKBN       TO  JYURRK-NYUGAIKBN
           MOVE    SYU-SRYKA           TO  JYURRK-SRYKA
           MOVE    SYU-SRYYMD          TO  JYURRK-SRYYMD
           MOVE    WRK-JYURRK-RENNUM   TO  JYURRK-RENNUM
           MOVE    WRK-JYURRK-DOUJI-RENNUM
                                       TO  JYURRK-DOUJI-RENNUM
           MOVE    WRK-JYURRK-EDANUM   TO  JYURRK-EDANUM
      *    会計連番
           COMPUTE JYURRK-KAIKEI-RENNUM
                                       =   WRK-KAIKEI-RENNUM
                                       +   1
      *
           MOVE    "1"                 TO  JYURRK-LASTKBN
      *
           MOVE    SPA-DRCD            TO  JYURRK-DRCD
           MOVE    SPA-HKNCOMBINUM     TO  JYURRK-HKNCOMBINUM
           MOVE    SYU-DENPNUM         TO  JYURRK-DENPNUM
      *
      *    労災用に保険区分をセットする
           MOVE    SPA-HKNKBN          TO  JYURRK-HKNKBN
           IF      SPA-HKNKBN          =   "1"
               EVALUATE    SPA-RSI-HKNKBN
                   WHEN    "1"
                   WHEN    "2"
                   WHEN    "3"
      *                 労災
                       MOVE    "1"                 TO  JYURRK-HKNKBN
                   WHEN    "4"
      *                 自賠責
                       MOVE    "2"                 TO  JYURRK-HKNKBN
               END-EVALUATE
           END-IF
      *
           MOVE    ZERO                TO  IDX-YAKUZAI
           .
       45001-JYURRK-SYOKI-EXT.
           EXIT.
      *
      *****************************************************************
      *    訂正時、受診履歴等の削除処理
      *****************************************************************
       450011-TEISEI-SYORI-SEC          SECTION.
      *
           MOVE    ZERO                TO  WRK-JYURRK-RENNUM
           MOVE    ZERO                TO  WRK-JYURRK-EDANUM
           MOVE    ZERO                TO  WRK-JYURRK-DOUJI-RENNUM
           MOVE    ZERO                TO  WRK-KAIKEI-RENNUM
      *
           MOVE    SPACE               TO  JYURRK-REC
           INITIALIZE                      JYURRK-REC
           MOVE    SYU-HOSPID          TO  JYURRK-HOSPID
           MOVE    SYU-PTID            TO  JYURRK-PTID
           MOVE    SPA-NYUGAIKBN       TO  JYURRK-NYUGAIKBN
           MOVE    SYU-SRYKA           TO  JYURRK-SRYKA
           MOVE    SPA-DENPNUM         TO  JYURRK-DENPNUM
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "JYURRK-KEY6"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "JYURRK-KEY6"       TO  ORC-DBPATH
               PERFORM 970-JYURRK-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-JYURRK
           END-IF
           PERFORM
                   UNTIL       FLG-JYURRK      =   1
               IF      SPA-DOUJI-RENNUM    =   JYURRK-DOUJI-RENNUM
                   MOVE    JYURRK-RENNUM       TO  WRK-JYURRK-RENNUM
                   MOVE    JYURRK-DOUJI-RENNUM TO
                                               WRK-JYURRK-DOUJI-RENNUM
      *
      *            算定履歴の回数をクリアする
      ************ PERFORM 4500113-TEISEI-SANTEI-SEC
      *
      *            診療会計マスタの診療回数をクリアする
                   PERFORM 4500112-TEISEI-SRYACCT-SEC
      *
      *            最終フラグクリア
                   MOVE    ZERO                TO  JYURRK-LASTKBN
      *            会計連番
                   MOVE    JYURRK-KAIKEI-RENNUM
                                               TO  WRK-KAIKEI-RENNUM
      *
                   MOVE    JYURRK-REC          TO  MCPDATA-REC
                   MOVE    "DBUPDATE"          TO  MCP-FUNC
                   MOVE    "JYURRK-KEY"        TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
               END-IF
      *
               MOVE    "JYURRK-KEY6"            TO  ORC-DBPATH
               PERFORM 970-JYURRK-NEXT-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "JYURRK-KEY6"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    初期編集
           IF      SPA-CONTKBN         =   "1" OR  "2"
               IF      WRK-JYURRK-DOUJI-RENNUM =   ZERO
                   ADD     1               TO  WRK-JYURRK-DOUJI-RENNUM
               END-IF
           ELSE
               MOVE    ZERO                TO  WRK-JYURRK-DOUJI-RENNUM
           END-IF
           PERFORM 45001-JYURRK-SYOKI-SEC
      *
           .
       450011-TEISEI-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    診療会計マスタの診療回数クリア処理
      *****************************************************************
       4500112-TEISEI-SRYACCT-SEC          SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX         >   15  )  OR
                              (JYURRK-ZAINUM (IDX) =   ZERO )
      *
               INITIALIZE                      SRYACCT-REC
               MOVE    JYURRK-HOSPID       TO  ACCT-HOSPID
               MOVE    SPA-NYUGAIKBN       TO  ACCT-NYUGAIKBN
               MOVE    JYURRK-PTID         TO  ACCT-PTID
               MOVE    JYURRK-SRYKA        TO  ACCT-SRYKA
               MOVE    JYURRK-SRYYMD(1:6)  TO  ACCT-SRYYM
               MOVE    JYURRK-ZAINUM (IDX) TO  ACCT-ZAINUM
      *
               MOVE    SRYACCT-REC         TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "SRYACCT-KEY5"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    "SRYACCT-KEY5"      TO  ORC-DBPATH
                   PERFORM 930-SRYACCT-NEXT-SEC
               ELSE
                   MOVE    1                   TO  FLG-SRYACCT
               END-IF
               PERFORM
                   UNTIL   (FLG-SRYACCT        =   1    ) OR
                           (FLG-OK             =   1    )
      *
                   MOVE    JYURRK-SRYYMD(7:2)      TO  IDX-2
                   EVALUATE    JYURRK-RENNUM
                       WHEN    1
                           MOVE    2               TO  IDX-1
                       WHEN    2
                           MOVE    3               TO  IDX-1
                       WHEN    OTHER
                           MOVE    4               TO  IDX-1
                   END-EVALUATE
      *
      *            算定履歴の削除処理
                   MOVE    ACCT-DAY (IDX-1 IDX-2)  TO  WRK-KAISU
                   PERFORM 4500113-TEISEI-SANTEI-SEC
      *
      *            剤回数　変更
                   COMPUTE ACCT-ZAIKAISU       =   ACCT-ZAIKAISU
                                               -   ACCT-DAY
                                                       (IDX-1 IDX-2)
                   COMPUTE ACCT-DAY (1 IDX-2)  =   ACCT-DAY (1 IDX-2)
                                               -   ACCT-DAY
                                                       (IDX-1 IDX-2)
                   MOVE    ZERO                TO  ACCT-DAY
                                                       (IDX-1 IDX-2)
      *            回数がゼロの時、削除
                   IF      ACCT-ZAIKAISU       =   ZERO
      *
                       INITIALIZE                  SRYACT-REC
                       MOVE    ACCT-HOSPID         TO  SRY-HOSPID
                       MOVE    ACCT-NYUGAIKBN      TO  SRY-NYUGAIKBN
                       MOVE    ACCT-PTID           TO  SRY-PTID
                       MOVE    ACCT-SRYKA          TO  SRY-SRYKA
                       MOVE    ACCT-SRYYM          TO  SRY-SRYYM
                       MOVE    ACCT-ZAINUM         TO  SRY-ZAINUM
                       MOVE    SRYACT-REC          TO  MCPDATA-REC
                       MOVE    "DBDELETE"          TO  MCP-FUNC
                       MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"          USING
                                                    MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
                       IF      MCP-RC          NOT =   ZERO
                            DISPLAY "K03 SRYACT DEL ERR:" MCP-RC
                       END-IF
      *
                       MOVE    SRYACCT-REC         TO  MCPDATA-REC
                       MOVE    "DBDELETE"          TO  MCP-FUNC
                       MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"          USING
                                                    MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
                       IF      MCP-RC          NOT =   ZERO
                            DISPLAY "K03 SRYACCT DEL ERR:" MCP-RC
                       END-IF
                   ELSE
      *
                       MOVE    SRYACCT-REC         TO  MCPDATA-REC
                       MOVE    "DBUPDATE"          TO  MCP-FUNC
                       MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"          USING
                                                    MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
                       IF      MCP-RC          NOT =   ZERO
                            DISPLAY "K03 SRYACCT UPD ERR:" MCP-RC
                       END-IF
                   END-IF
      *
                   MOVE    "SRYACCT-KEY5"      TO  ORC-DBPATH
                   PERFORM 930-SRYACCT-NEXT-SEC
               END-PERFORM
               MOVE    "DBCLOSE"           TO  MCP-FUNC
               MOVE    "SRYACCT-KEY5"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           END-PERFORM
      *
           .
       4500112-TEISEI-SRYACCT-EXT.
           EXIT.
      *
      *****************************************************************
      *    算定履歴の回数クリア処理
      *****************************************************************
       4500113-TEISEI-SANTEI-SEC          SECTION.
      *
      *    PERFORM VARYING     IDX     FROM    1   BY  1
      *            UNTIL      (IDX         >   15  )  OR
      *                       (JYURRK-ZAINUM (IDX) =   ZERO )
      *
               INITIALIZE                      SRYACT-REC
               MOVE    JYURRK-HOSPID       TO  SRY-HOSPID
               MOVE    SPA-NYUGAIKBN       TO  SRY-NYUGAIKBN
               MOVE    JYURRK-PTID         TO  SRY-PTID
               MOVE    JYURRK-SRYKA        TO  SRY-SRYKA
               MOVE    JYURRK-SRYYMD(1:6)  TO  SRY-SRYYM
               MOVE    JYURRK-ZAINUM (IDX) TO  SRY-ZAINUM
      *
               MOVE    SRYACT-REC          TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
                   PERFORM 915-SRYACT-NEXT-SEC
               ELSE
                   MOVE    1                   TO  FLG-SRYACT
               END-IF
               PERFORM
                   UNTIL   FLG-SRYACT          =   1
      *
                   PERFORM VARYING     IDY     FROM    1   BY  1
                           UNTIL      (IDY     >   5   )  OR
                                      (SRY-SRYCD (IDY) =   SPACE)
      *
      *            手技料の時、算定歴を判定する
                   IF      SRY-SRYCD (IDY)(1:1)    =   "1"
      *                ダミー追加
                       OR (SRY-SRYCD (IDY)         =   "099110001" )
                       MOVE    SRY-SRYCD (IDY)     TO  WRK-SRYCD
      *
                       MOVE    WRK-SRYCD           TO  TNS-SRYCD
                       PERFORM 910-TENSU-READ-SEC
      *                算定用の診療コードへ変更
                       PERFORM 45020-SANTEI-SRYCD-SEC
                       IF      SRY-SRYCD (IDY) NOT =   WRK-SRYCD
                           MOVE    WRK-SRYCD           TO  TNS-SRYCD
                           PERFORM 910-TENSU-READ-SEC
                       END-IF
      *
                       IF      TNS-SANTEIRRKKBN    NOT =   ZERO
                           PERFORM 45001131-SANTEI-DEL-SEC
                       END-IF
                   END-IF
      *
                   END-PERFORM
      *
                   MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
                   PERFORM 915-SRYACT-NEXT-SEC
      *
               END-PERFORM
      *
               MOVE    "DBCLOSE"           TO  MCP-FUNC
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
      *****END-PERFORM
      *
           .
       4500113-TEISEI-SANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    算定履歴回数減処理
      *****************************************************************
       45001131-SANTEI-DEL-SEC          SECTION.
      *
           INITIALIZE                  ORCSSANTEIAREA
           MOVE    "3"                 TO  SSANTEI-SYORI
           MOVE    "K03"               TO  SSANTEI-PG
           MOVE    WRK-SRYCD           TO  SSANTEI-SRYCD
           MOVE    SPA-PTID            TO  SSANTEI-PTID
           MOVE    SPA-SRYYMD          TO  SSANTEI-SRYYMD
           MOVE    WRK-KAISU           TO  SSANTEI-KAISU
           CALL    "ORCSSANTEI"        USING
                                       ORCSSANTEIAREA
                                       SPA-AREA
      *
           .
       45001131-SANTEI-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    訂正時、受診履歴等の削除処理
      *****************************************************************
       450012-TEISEI-DELETE-SEC          SECTION.
      *
           MOVE    SPA-TERMID          TO  FILE-TERMID2
           OPEN    INPUT               PARA-FILE
           PERFORM 980-PARA-READ-SEC
      *
           PERFORM
               UNTIL   FLG-PARA        NOT =   ZERO 
               IF      PARA-FILEMEI        =   "SYUNOU"
      *            パラメタの収納データ読込
                   MOVE    PARA-DATA-REC       TO  SYUNOU-REC
               END-IF
      *
               PERFORM 980-PARA-READ-SEC
           END-PERFORM
      *
           CLOSE                        PARA-FILE
      *
      *    削除処理
           PERFORM 4500121-TEISEI-SRYACTDEL-SEC
      *
      *    診療科履歴変更
           INITIALIZE                  ORCSKARRKAREA
           MOVE    SPA-SRYYMD(1:6)     TO  SKARRK-SRYYM
      *
           CALL    "ORCSKARRK"         USING
                                       ORCSKARRKAREA
                                       SPA-AREA.
      *
           .
       450012-TEISEI-DELETE-EXT.
           EXIT.
      *****************************************************************
      *    削除処理
      *****************************************************************
       4500121-TEISEI-SRYACTDEL-SEC          SECTION.
      *
      *    受診履歴の連番をすべて削除する
           MOVE    SPACE               TO  JYURRK-REC
           INITIALIZE                      JYURRK-REC
           MOVE    SYU-HOSPID          TO  JYURRK-HOSPID
           MOVE    SYU-PTID            TO  JYURRK-PTID
           MOVE    SPA-NYUGAIKBN       TO  JYURRK-NYUGAIKBN
           MOVE    SYU-SRYKA           TO  JYURRK-SRYKA
           MOVE    SPA-SRYYMD          TO  JYURRK-SRYYMD
           MOVE    SPA-RENNUM          TO  JYURRK-RENNUM
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "JYURRK-KEY5"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "JYURRK-KEY5"       TO  ORC-DBPATH
               PERFORM 970-JYURRK-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-JYURRK
           END-IF
           PERFORM
                   UNTIL       FLG-JYURRK      =   1
               MOVE    ZERO                TO  WRK-JYURRK-RENNUM
               MOVE    ZERO                TO  WRK-JYURRK-EDANUM
               MOVE    ZERO                TO  WRK-JYURRK-DOUJI-RENNUM
               MOVE    ZERO                TO  WRK-KAIKEI-RENNUM
      *
      *        算定履歴の回数をクリアする
      *********PERFORM 4500113-TEISEI-SANTEI-SEC
      *
      *        診療会計マスタの診療回数をクリアする
               PERFORM 4500112-TEISEI-SRYACCT-SEC
      *        会計連番
               MOVE    JYURRK-RENNUM       TO  WRK-JYURRK-RENNUM
               MOVE    JYURRK-DOUJI-RENNUM TO  WRK-JYURRK-DOUJI-RENNUM
               MOVE    JYURRK-KAIKEI-RENNUM
                                           TO  WRK-KAIKEI-RENNUM
      *
      *        受診履歴・収納削除
               PERFORM 4500114-TEISEI-JYURRKDEL-SEC
      *
               MOVE    "JYURRK-KEY5"            TO  ORC-DBPATH
               PERFORM 970-JYURRK-NEXT-SEC
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "JYURRK-KEY5"       TO  ORC-DBPATH
      *    CALL    "ORCMCPSUB"          USING
      *                                 MCPAREA
      *                                 ORCMCPAREA
      *                                 MCPDATA-REC
      *
      *
      *    受診履歴の連番変更する
           MOVE    SPACE               TO  JYURRK-REC
           INITIALIZE                      JYURRK-REC
           MOVE    SYU-HOSPID          TO  JYURRK-HOSPID
           MOVE    SYU-PTID            TO  JYURRK-PTID
           MOVE    SPA-NYUGAIKBN       TO  JYURRK-NYUGAIKBN
           MOVE    SPA-SRYKA           TO  JYURRK-SRYKA
           MOVE    SPA-SRYYMD          TO  JYURRK-SRYYMD
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "JYURRK-KEY9"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "JYURRK-KEY9"       TO  ORC-DBPATH
               PERFORM 970-JYURRK-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-JYURRK
           END-IF
           MOVE    SPACE               TO  TBL-JYURRK-AREA
           MOVE    ZERO                TO  IDX 
           MOVE    ZERO                TO  WRK-RENNUM-KEY
           MOVE    ZERO                TO  WRK-JYURRK-RENNUM
           PERFORM
                   UNTIL       FLG-JYURRK      =   1
               IF      JYURRK-RENNUM       =   WRK-RENNUM-KEY
                   CONTINUE
               ELSE
                   ADD     1                   TO  WRK-JYURRK-RENNUM
                   MOVE    JYURRK-RENNUM       TO  WRK-RENNUM-KEY
               END-IF
      *
               IF      JYURRK-RENNUM       =   WRK-JYURRK-RENNUM
                   CONTINUE
               ELSE
      *
                   MOVE    JYURRK-REC          TO  MCPDATA-REC
                   MOVE    "DBDELETE"          TO  MCP-FUNC
                   MOVE    "JYURRK-KEY"        TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
      *
                   MOVE    WRK-JYURRK-RENNUM   TO  JYURRK-RENNUM
                   MOVE    JYURRK-REC          TO  MCPDATA-REC
                   MOVE    "DBINSERT"          TO  MCP-FUNC
                   MOVE    "JYURRK-KEY"        TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
      *            診療会計修正
                   IF      JYURRK-LASTKBN      =   1
                       PERFORM 4500115-TEISEI-SRYACTUPD-SEC
                   END-IF
      *
               END-IF
      *
               MOVE    "JYURRK-KEY9"            TO  ORC-DBPATH
               PERFORM 970-JYURRK-NEXT-SEC
           END-PERFORM
      *
      *
           .
       450012-TEISEI-DELETE-EXT.
           EXIT.
      *****************************************************************
      *    受診履歴削除処理
      *****************************************************************
       4500114-TEISEI-JYURRKDEL-SEC          SECTION.
      *
           MOVE    SYUNOU-REC          TO  WRK-SYUNOU-REC
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   WRK-KAIKEI-RENNUM
      *
               MOVE    ZERO                TO  FLG-JYURRK
               PERFORM VARYING     IDY     FROM    1   BY  1
                       UNTIL       FLG-JYURRK  NOT =   ZERO
                   MOVE    SPACE               TO  JYURRK-REC
                   INITIALIZE                      JYURRK-REC
                   MOVE    WRK-SYU-HOSPID      TO  JYURRK-HOSPID
                   MOVE    WRK-SYU-PTID        TO  JYURRK-PTID
                   MOVE    SPA-NYUGAIKBN       TO  JYURRK-NYUGAIKBN
                   MOVE    WRK-SYU-SRYKA       TO  JYURRK-SRYKA
                   MOVE    SPA-SRYYMD          TO  JYURRK-SRYYMD
                   MOVE    SPA-RENNUM          TO  JYURRK-RENNUM
                   MOVE    WRK-JYURRK-DOUJI-RENNUM
                                               TO  JYURRK-DOUJI-RENNUM
                   MOVE    IDX                 TO  JYURRK-KAIKEI-RENNUM
                   MOVE    IDY                 TO  JYURRK-EDANUM
      *
                   MOVE    JYURRK-REC          TO  MCPDATA-REC
                   MOVE    "DBSELECT"          TO  MCP-FUNC
                   MOVE    "JYURRK-KEY"        TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                   IF      MCP-RC              =   ZERO
                       MOVE    "JYURRK-KEY"        TO  ORC-DBPATH
                       PERFORM 970-JYURRK-NEXT-SEC
                   ELSE
                       MOVE    1                   TO  FLG-JYURRK
                   END-IF
                   IF      FLG-JYURRK          =   ZERO
      *                収納削除
                       MOVE    WRK-SYUNOU-REC      TO  SYUNOU-REC
                       MOVE    JYURRK-DENPNUM      TO  SYU-DENPNUM
                       MOVE    SYUNOU-REC          TO  MCPDATA-REC
                       MOVE    "DBDELETE"          TO  MCP-FUNC
                       MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"         USING
                                                   MCPAREA
                                                   ORCMCPAREA
                                                   MCPDATA-REC
      *
      *                受診履歴削除
                       MOVE    JYURRK-REC          TO  MCPDATA-REC
                       MOVE    "DBDELETE"          TO  MCP-FUNC
                       MOVE    "JYURRK-KEY"        TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"         USING
                                                   MCPAREA
                                                   ORCMCPAREA
                                                   MCPDATA-REC
                   END-IF
               END-PERFORM
           END-PERFORM
      *
           MOVE    ZERO                TO  FLG-JYURRK
      *
           .
       4500114-TEISEI-JYURRKDEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計修正処理
      *****************************************************************
       4500115-TEISEI-SRYACTUPD-SEC          SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX         >   15  )  OR
                              (JYURRK-ZAINUM (IDX)   =   ZERO)
      *
               INITIALIZE                          SRYACCT-REC
               MOVE    JYURRK-HOSPID       TO  ACCT-HOSPID
               MOVE    SPA-NYUGAIKBN       TO  ACCT-NYUGAIKBN
               MOVE    JYURRK-PTID         TO  ACCT-PTID
               MOVE    JYURRK-SRYKA        TO  ACCT-SRYKA
               MOVE    JYURRK-SRYYMD(1:6)  TO  ACCT-SRYYM
               MOVE    JYURRK-ZAINUM (IDX) TO  ACCT-ZAINUM
      *
               MOVE    SRYACCT-REC         TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "SRYACCT-KEY5"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    "SRYACCT-KEY5"      TO  ORC-DBPATH
                   PERFORM 930-SRYACCT-NEXT-SEC
               ELSE
                   MOVE    1                   TO  FLG-SRYACCT
               END-IF
               PERFORM
                   UNTIL   (FLG-SRYACCT        =   1    ) OR
                           (FLG-OK             =   1    )
      *
                   MOVE    JYURRK-SRYYMD(7:2)      TO  IDX-2
                   EVALUATE    JYURRK-RENNUM
                       WHEN    1
                           MOVE    2               TO  IDX-1
                       WHEN    2
                           MOVE    3               TO  IDX-1
                       WHEN    OTHER
                           MOVE    4               TO  IDX-1
                   END-EVALUATE
                       EVALUATE    WRK-RENNUM-KEY
                           WHEN    1
                               MOVE    2               TO  IDX-3
                           WHEN    2
                               MOVE    3               TO  IDX-3
                           WHEN    OTHER
                               MOVE    4               TO  IDX-3
                       END-EVALUATE
      *                剤回数　変更
                       MOVE    ACCT-DAY (IDX-3 IDX-2)
                                              TO  ACCT-DAY (IDX-1 IDX-2)
                       MOVE    ZERO           TO  ACCT-DAY (IDX-3 IDX-2)
      *
                       MOVE    SRYACCT-REC       TO  MCPDATA-REC
                       MOVE    "DBUPDATE"        TO  MCP-FUNC
                       MOVE    "SRYACCT-KEY"     TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"       USING
                                                 MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
      *
                       IF      MCP-RC          NOT =   ZERO
                            DISPLAY "K03 SRYACCT UPD ERR:" MCP-RC
                       END-IF
      *
                   MOVE    "SRYACCT-KEY5"      TO  ORC-DBPATH
                   PERFORM 930-SRYACCT-NEXT-SEC
               END-PERFORM
               MOVE    "DBCLOSE"           TO  MCP-FUNC
               MOVE    "SRYACCT-KEY5"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           END-PERFORM
      *
           .
       4500115-TEISEI-SRYACTUPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴作成処理（明細編集）
      *****************************************************************
       45001-JYURRK-SYORI2-SEC          SECTION.
      *
      *    診療区分領域の編集
           EVALUATE    LNK-WKSRY-SRYKBN (1)
               WHEN   "11"
               WHEN   "12"
               WHEN   "13"
               WHEN   "14"
                   MOVE    "01"        TO  JYURRK-SRYKBN1
               WHEN   "21"
                   MOVE    "01"        TO  JYURRK-SRYKBN2
               WHEN   "22"
                   MOVE    "01"        TO  JYURRK-SRYKBN3
               WHEN   "23"
                   MOVE    "01"        TO  JYURRK-SRYKBN4
               WHEN   "31"
               WHEN   "32"
               WHEN   "33"
                   MOVE    "01"        TO  JYURRK-SRYKBN5
               WHEN   "40"
                   MOVE    "01"        TO  JYURRK-SRYKBN6
               WHEN   "50"
                   MOVE    "01"        TO  JYURRK-SRYKBN7
               WHEN   "54"
                   MOVE    "01"        TO  JYURRK-SRYKBN8
               WHEN   "60"
                   MOVE    "01"        TO  JYURRK-SRYKBN9
               WHEN   "70"
                   MOVE    "01"        TO  JYURRK-SRYKBN10
               WHEN   "80"
               WHEN   "93"
               WHEN   "95"
               WHEN   "96"
               WHEN   "99"
                   MOVE    "01"        TO  JYURRK-SRYKBN11
           END-EVALUATE
      *D   IF     LNK-WKSRY-SRYKBN (1)    =   "11"  OR  "12"
      *D       CONTINUE
      *D   ELSE
      *    同一の剤の判定
           MOVE    ZERO                TO  FLG-ZAINUM
           PERFORM VARYING WRK-TBL-IDX     FROM    1   BY  1
                   UNTIL  (WRK-TBL-IDX     >   100 )  OR
                          (FLG-ZAINUM      =   1   )
               IF      WRK-TBL-ZAINUM (WRK-TBL-IDX)    =   WRK-ZAINUM
                   MOVE    1               TO  FLG-ZAINUM
               ELSE
                   IF      WRK-TBL-ZAINUM (WRK-TBL-IDX)    =   ZERO
                       MOVE    WRK-ZAINUM      TO  WRK-TBL-ZAINUM
                                                      (WRK-TBL-IDX)
                       MOVE    100             TO  WRK-TBL-IDX
                   END-IF
               END-IF
           END-PERFORM
      *
           IF      FLG-ZAINUM          =   ZERO
               ADD     1       TO    IDX-YAKUZAI
               IF      IDX-YAKUZAI   >    15
      *            受診履歴作成処理
                   PERFORM 45001-JYURRK-SYORI3-SEC
                   PERFORM 45001-JYURRK-SYOKI-SEC
      *
      *************IF      SPA-SYORIFLG        =   ZERO
      *                 診療科履歴作成終了処理
      *                PERFORM 45009-SRYKARRK-OUT-SEC
      ************ END-IF
                   MOVE    1             TO  IDX-YAKUZAI
               END-IF
               MOVE    WRK-ZAINUM        TO  JYURRK-ZAINUM(IDX-YAKUZAI)
           END-IF
      *D   END-IF
      *
      *    初診料履歴のみ算定時、初診日２へセット
           IF      SPA-SYOSIN-YMD  NOT =   SPACE
               MOVE    SPA-SYOSIN-YMD      TO  KARRK-SYOSINYMD2
           END-IF
      *    初診料算定日設定処理
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   IDX-KOUI
      *
      *        診療科更新（初診料算定時、初診日２へセット
               IF      LNK-WKSRY-SRYKBN (IDX)  =   "11"
                   MOVE    SYU-SRYYMD          TO  KARRK-SYOSINYMD2
               END-IF
      *
               PERFORM VARYING     IDY     FROM    1   BY  1
                       UNTIL      (IDY     >   5   )  OR
                                  (LNK-WKSRY-SRYCD (IDX IDY) =   SPACE)
                   EVALUATE    LNK-WKSRY-SRYCD (IDX IDY)
      *                小児科外来診療料
                       WHEN    "113003510"
                       WHEN    "113003710"
                           MOVE    SYU-SRYYMD      TO  KARRK-SYOSINYMD2
      *                検診等より
                       WHEN    "820000003"
                       WHEN    "820000004"
                       WHEN    "820000005"
                       WHEN    "820000006"
                           IF      KARRK-SYOSINYMD2    =   SPACE
                               MOVE    SYU-SRYYMD  TO  KARRK-SYOSINYMD2
                               MOVE    1           TO  FLG-SYOSIN-DUMMY
                           END-IF
                   END-EVALUATE
               END-PERFORM
           END-PERFORM
      *
      *****診療科更新（初診料算定時、初診日２へセット
      *    IF      LNK-WKSRY-SRYKBN (1)     =   "11"
      *        MOVE    SYU-SRYYMD          TO  KARRK-SYOSINYMD2
      **** END-IF
           .
       45001-JYURRK-SYORI2-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴作成処理（ファイル書き出し）
      *****************************************************************
       45001-JYURRK-SYORI3-SEC          SECTION.
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "JYURRK-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               MOVE    "0005"          TO  SPA-ERRCD
               DISPLAY "K03 JYURRK-SYORI3 ERR:" MCP-RC 
                        ",KEY:" JYURRK-KEY "."
           END-IF
      *
           .
       45001-JYURRK-SYORI3-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科初期処理（初期処理）
      *****************************************************************
       45009-SRYKARRK-SYOKI-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-SYOSIN-DUMMY
      *
           MOVE    SPACE               TO  SRYKARRK-REC
           INITIALIZE                      SRYKARRK-REC
           MOVE    SYU-HOSPID          TO  KARRK-HOSPID
           MOVE    SYU-PTID            TO  KARRK-PTID
           MOVE    SYU-SRYKA           TO  KARRK-SRYKA
      *
           MOVE    SRYKARRK-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYKARRK-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYKARRK-KEY"      TO  ORC-DBPATH
               PERFORM 975-SRYKARRK-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SRYKARRK
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYKARRK-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      FLG-SRYKARRK        =   ZERO
               IF      KARRK-LASTYMD       <   SYU-SRYYMD
                   MOVE    SYU-SRYYMD      TO  KARRK-LASTYMD
               END-IF
           END-IF
      *
      *    診療科新規作成
           IF      FLG-SRYKARRK           =   1
      *
               MOVE    SPACE               TO  SRYKARRK-REC
               INITIALIZE                      SRYKARRK-REC
               MOVE    SYU-HOSPID          TO  KARRK-HOSPID
               MOVE    SYU-PTID            TO  KARRK-PTID
               MOVE    SYU-SRYKA           TO  KARRK-SRYKA
               MOVE    SYU-SRYYMD          TO  KARRK-SYOSINYMD1
               MOVE    SYU-SRYYMD          TO  KARRK-LASTYMD
               IF     (SPA-SYOSIN-YMD  NOT =   SPACE  )  AND
                      (SYU-SRYYMD          >   SPA-SYOSIN-YMD )
                   MOVE    SPA-SYOSIN-YMD      TO  KARRK-SYOSINYMD1
               END-IF
           END-IF
      *
           .
       45009-SRYKARRK-SYOKI-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科履歴作成終了処理
      *****************************************************************
       45009-SRYKARRK-OUT-SEC            SECTION.
      *
           IF      FLG-SRYKARRK           =   ZERO
      *        更新
               MOVE    SRYKARRK-REC        TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "SRYKARRK-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "K03 SRYKARRK UPD ERR:"  MCP-RC
                           ",KEY:" KARRK-KEY  ";"
               END-IF
           ELSE
      *        新規
               MOVE    SRYKARRK-REC        TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "SRYKARRK-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "K03 SRYKARRK INS ERR:"  MCP-RC
                           ",KEY:" KARRK-KEY  ";"
               END-IF
           END-IF
      *
           .
       45009-SRYKARRK-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為マスター更新処理
      *****************************************************************
       4501-SRYACT-KOU-SEC            SECTION.
      *
      *
           MOVE    ZERO                TO  FLG-SINKI
      *    診療会計マスター処理
           PERFORM 4501-SRYACCT-SYORI-SEC
      *
      *    診療コードがない時、処理をしない
           IF      WRK-MEISAISU        =   ZERO
               GO      TO      4501-SRYACT-KOU-EXT
           END-IF
      *
      *    診療行為マスター処理 
           IF      FLG-SINKI           =   1
               PERFORM 4501-SRYACT-SYORI-SEC
           END-IF
      *
      *    算定履歴更新処理
           PERFORM 4502-SANTEI-SYORI-SEC
           .
       4501-SRYACT-KOU-EXT.
           EXIT.
      *
      *****************************************************************
      *     診療会計マスター処理
      *****************************************************************
       4501-SRYACCT-SYORI-SEC              SECTION.
      *
      *    診療コード計計算
           MOVE    ZERO                TO  WRK-ZAITEN
           MOVE    ZERO                TO  WRK-SRYKAISUKEI
           MOVE    ZERO                TO  WRK-SRYSURYOKEI
           MOVE    ZERO                TO  WRK-MEISAISU
           MOVE    ZERO                TO  WRK-SRYCDKEI
           INITIALIZE                      WRK-WKSRY-AREA
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   IDX-KOUI
      *        剤点数計
               MOVE    LNK-WKSRY-ZAITENKEI(IDX)    TO  WRK-ZAITEN
      *        回数計
               MOVE    LNK-WKSRY-ZAIKAIKEI(IDX)    TO  WRK-SRYKAISUKEI
      *        手技料１
               MOVE    LNK-WKSRY-SYUTEN1  (IDX)    TO  WRK-SYUTEN1
      *        手技料２
               MOVE    LNK-WKSRY-SYUTEN2  (IDX)    TO  WRK-SYUTEN2
      *        薬剤
               MOVE    LNK-WKSRY-YKZTEN  (IDX)     TO  WRK-YKZTEN
      *        器材
               MOVE    LNK-WKSRY-KIZAITEN (IDX)    TO  WRK-KIZAITEN
      *        自費
               IF      LNK-WKSRY-JIHIMONEYTOTAL (IDX)  NOT =   ZERO
      *************MOVE    LNK-WKSRY-JIHIMONEY (IDX)  TO  WRK-JIHIMONEY
                   MOVE    LNK-WKSRY-JIHIMONEYTOTAL (IDX) 
                                                   TO  WRK-JIHIMONEY
               END-IF
      *
               PERFORM VARYING     IDY     FROM    1   BY  1
                       UNTIL      (IDY     >   5   )  OR
                                  (LNK-WKSRY-SRYCD (IDX IDY) =   SPACE)
                   IF      LNK-WKSRY-SRYCD (IDX IDY)     NUMERIC
                       MOVE    LNK-WKSRY-SRYCD (IDX IDY)
                                               TO  WRK-SRYCD
                       ADD     WRK-SRYCD       TO  WRK-SRYCDKEI
                       ADD     LNK-WKSRY-SRYSURYO (IDX IDY)
                                               TO  WRK-SRYSURYOKEI
                       ADD     1               TO  WRK-MEISAISU
                   ELSE
                       IF      LNK-WKSRY-SRYCD(IDX IDY)(1:1) =  "S"
                           ADD     1               TO  WRK-MEISAISU
                       END-IF
                   END-IF
               END-PERFORM
           END-PERFORM
      *
      *    剤点数がゼロの時、自費を点数へ
           IF      WRK-ZAITEN          =   ZERO
               MOVE   WRK-JIHIMONEY        TO  WRK-ZAITEN
           END-IF
      *
      *    診療コードがない時、処理をしない
           IF      WRK-MEISAISU        =   ZERO
               GO      TO      4501-SRYACCT-SYORI-EXT
           END-IF 
      *
           MOVE    ZERO                TO  WRK-ZAINUM
           MOVE    ZERO                TO  FLG-OK
      *    診療会計マスターを特定する
           INITIALIZE                          SRYACCT-REC
           MOVE    LNK-WKSRY-HOSPID (01)   TO  ACCT-HOSPID
           MOVE    LNK-WKSRY-NYUGAIKBN(01) TO  ACCT-NYUGAIKBN
           MOVE    LNK-WKSRY-PTID   (01)   TO  ACCT-PTID
           MOVE    LNK-WKSRY-SRYKA  (01)   TO  ACCT-SRYKA
           MOVE    LNK-WKSRY-SRYYMD (01)(1:6)
                                           TO  ACCT-SRYYM
           MOVE    LNK-WKSRY-SRYKBN (01)   TO  ACCT-SRYKBN
      *    診療種別により判定を追加する
           IF     (LNK-WKSRY-SRYSYUKBN (01) =  SPACE )  OR
                  (LNK-WKSRY-SRYSYUKBN (01) =   "210"  OR
                                                "230" )
               MOVE    SPACE                   TO  WRK-SRYSYUKBN
           ELSE
               MOVE    LNK-WKSRY-SRYSYUKBN(01) TO  WRK-SRYSYUKBN
           END-IF
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACCT-KEY3"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACCT-KEY3"      TO  ORC-DBPATH
               PERFORM 930-SRYACCT-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-SRYACCT
           END-IF
           PERFORM
               UNTIL   (FLG-SRYACCT        =   1    ) OR
                       (FLG-OK             =   1    )
      *
      *        診療コード計を比較する
               MOVE     ZERO                TO  FLG-CHK-OK
               IF     (ACCT-HKNCOMBI        =   SPA-HKNCOMBINUM) AND
                      (ACCT-SRYCDTOTAL      =   WRK-SRYCDKEI   ) AND
                      (ACCT-ZAITEN          =   WRK-ZAITEN     ) AND
                      (ACCT-MEISAISU        =   WRK-MEISAISU   )
      *            数量計をゼロで作成していたものがあったので、
      *            ゼロを１で判定する
                 IF     (ACCT-SURYOUTOTAL     =   WRK-SRYSURYOKEI)  OR
                        (WRK-SRYSURYOKEI      =   1     AND
                         ACCT-SURYOUTOTAL     =   ZERO OR 1 )
                   MOVE    ACCT-ZAINUM      TO  WRK-H-ZAINUM
      *            診療行為内容の比較処理
                   PERFORM 45012-SRYACCT-CHK-SEC
      *
      *            同一診療会計マスターあり
                   IF      FLG-OK          =   1
      *                新規追加
                       MOVE    WRK-H-ZAINUM        TO  WRK-ZAINUM
                   END-IF
                 END-IF
               END-IF
               IF      FLG-OK              =   ZERO
                   MOVE    "SRYACCT-KEY3"      TO  ORC-DBPATH
                   PERFORM 930-SRYACCT-NEXT-SEC
               END-IF
           END-PERFORM
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYACCT-KEY3"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF      WRK-ZAINUM          =   ZERO
      *        剤番号取得処理
               PERFORM 45013-ZAINUM-SET-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   GO      TO      4501-SRYACCT-SYORI-EXT
               END-IF
           END-IF
      *    診療会計マスター更新用読み込み
           INITIALIZE                          SRYACCT-REC
           MOVE    LNK-WKSRY-HOSPID (01)   TO  ACCT-HOSPID
           MOVE    LNK-WKSRY-NYUGAIKBN(01) TO  ACCT-NYUGAIKBN
           MOVE    LNK-WKSRY-PTID   (01)   TO  ACCT-PTID
           MOVE    LNK-WKSRY-SRYKA  (01)   TO  ACCT-SRYKA
           MOVE    LNK-WKSRY-SRYYMD (01)(1:6)
                                           TO  ACCT-SRYYM
           MOVE    LNK-WKSRY-SRYKBN (01)   TO  ACCT-SRYKBN
           MOVE    WRK-ZAINUM              TO  ACCT-ZAINUM
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
               PERFORM 930-SRYACCT-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-SRYACCT
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF      FLG-SRYACCT         =   1
      *        診療会計マスター新規編集処理
               PERFORM 45015-SRYACCT-SRY-SEC
      *        診療会計マスター編集処理
               PERFORM 45014-SRYACCT-HEN-SEC
      *
               MOVE    SRYACCT-REC         TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "SYRACCT INS ERR:" MCP-RC
                   MOVE    "0005"              TO  SPA-ERRCD
               END-IF
      *        新規のときのみ、診療行為マスターを追加する
               MOVE    1                   TO  FLG-SINKI
           ELSE
      *        診療会計マスター編集処理
               PERFORM 45014-SRYACCT-HEN-SEC
      *
               MOVE    SRYACCT-REC         TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "SYRACCT UPDTE ERR:" MCP-RC
                   MOVE    "0005"              TO  SPA-ERRCD
               END-IF   
               MOVE    ZERO                TO  FLG-SINKI
           END-IF
      *
           .
      *
       4501-SRYACCT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *   診療行為内容の比較処理
      *****************************************************************
       45012-SRYACCT-CHK-SEC          SECTION.
      *
           MOVE    ZERO                TO  IDX-SIN
           INITIALIZE                      TBL-MAE-AREA 
      *    診療会計マスターから診療行為マスターを検索する
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
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               PERFORM 915-SRYACT-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-SRYACT
           END-IF
           PERFORM UNTIL     (FLG-SRYACT       =   1  )
      *        診療種別により判定を追加する
               IF     (SRY-SRYSYUKBN       =  SPACE )  OR
                      (SRY-SRYSYUKBN       =  "210"  OR
                                              "230" )
                   MOVE    SPACE           TO  WRK-MAE-SRYSYUKBN
               ELSE
                   MOVE    SRY-SRYSYUKBN   TO  WRK-MAE-SRYSYUKBN
               END-IF
      *        診療種別区分判定
               IF       WRK-SRYSYUKBN       =   WRK-MAE-SRYSYUKBN
                   MOVE     1               TO  FLG-CHK-OK
               ELSE
                   MOVE     ZERO            TO  FLG-CHK-OK
               END-IF
               IF      FLG-CHK-OK          =   1
      *
               PERFORM VARYING     IDX2    FROM    1   BY  1
                       UNTIL      (IDX2        >   5   )  OR
                                  (SRY-SRYCD(IDX2)     =   SPACE )
                   ADD     1                   TO  IDX-SIN
                   MOVE    SRY-SRYCD   (IDX2)  TO  TBL-MAE-SRYCD
                                                             (IDX-SIN)
                   MOVE    SRY-SRYSURYO(IDX2)  TO  TBL-MAE-SRYSURYO
                                                             (IDX-SIN)
                   MOVE    SRY-SRYKAISU(IDX2)  TO  TBL-MAE-SRYKAISU
                                                             (IDX-SIN)
                   IF      SRY-SRYCD (IDX2)(1:1)   =   "8"
                       MOVE    SRY-HOSPID          TO  PTCOM-HOSPID
                       MOVE    SRY-PTID            TO  PTCOM-PTID
                       MOVE    SRY-ZAINUM          TO  PTCOM-ZAINUM
                       MOVE    SRY-SRYCD (IDX2)    TO  PTCOM-SRYCD
                       MOVE    SRY-INPUTNUM(IDX2)  TO  PTCOM-RENNUM
                       PERFORM 950-PTCOM-READ-SEC
                       IF      FLG-PTCOM           =   ZERO
                           MOVE    PTCOM-INPUTCOMENT   TO
                                               TBL-MAE-INPUTCOMENT
                                                            (IDX-SIN)
                           MOVE    PTCOM-INPUTCHI-AREA TO
                                               TBL-MAE-ATAI-G
                                                            (IDX-SIN)
                       END-IF
                   END-IF
               END-PERFORM
      *
               END-IF
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               PERFORM 915-SRYACT-NEXT-SEC
           END-PERFORM
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    診療行為内容のみテーブルに保存する
           MOVE    ZERO                TO  IDX-ATO
           INITIALIZE                      TBL-ATO-AREA 
           PERFORM VARYING     IDX1    FROM    1   BY  1
                   UNTIL       IDX1        >   IDX-KOUI
               PERFORM VARYING     IDX2    FROM    1   BY  1
                       UNTIL      (IDX2        >   5          )  OR
                                  (LNK-WKSRY-SRYCD(IDX1 IDX2) =  SPACE)
                   ADD     1                   TO  IDX-ATO
                   MOVE    LNK-WKSRY-SRYCD (IDX1 IDX2)
                                               TO  TBL-ATO-SRYCD
                                                             (IDX-ATO)
                   MOVE    LNK-WKSRY-SRYSURYO(IDX1 IDX2)
                                               TO  TBL-ATO-SRYSURYO
                                                             (IDX-ATO)
                   MOVE    LNK-WKSRY-SRYKAISU(IDX1 IDX2)
                                               TO  TBL-ATO-SRYKAISU
                                                             (IDX-ATO)
                   MOVE    LNK-WKSRY-INPUTCOMENT(IDX1 IDX2)
                                               TO  TBL-ATO-INPUTCOMENT
                                                             (IDX-ATO)
                   MOVE    LNK-WKSRY-INPUTCHI-G(IDX1 IDX2)
                                               TO  TBL-ATO-ATAI-G
                                                             (IDX-ATO)
               END-PERFORM
           END-PERFORM
      *
      *    診療行為数が違う
           IF      IDX-SIN         NOT =   IDX-ATO
               GO      TO      45012-SRYACCT-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-ERR
           PERFORM VARYING     IDX1    FROM    1   BY  1
                   UNTIL      (IDX1        >   IDX-ATO  )  OR
                              (FLG-ERR     =   1        )
               MOVE    ZERO                TO  FLG-ARI
               PERFORM VARYING     IDX2    FROM    1   BY  1
                       UNTIL      (IDX2        >   IDX-SIN  )  OR
                                  (FLG-ARI     =   1        )
                   IF      TBL-ATO-REC (IDX1)  =   TBL-MAE-REC(IDX2)
                        MOVE    1                  TO  FLG-ARI
                   END-IF
               END-PERFORM
               IF      FLG-ARI             =   ZERO
                    MOVE    1                  TO  FLG-ERR
               END-IF
           END-PERFORM
           IF      FLG-ERR             =   ZERO
               MOVE    1               TO  FLG-OK
           END-IF
           .
      *
       45012-SRYACCT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *   剤番号取得処理
      *****************************************************************
       45013-ZAINUM-SET-SEC          SECTION.
      *
      *    患者マスターより、最終剤番号を再番し、患者マスターを更新する
           INITIALIZE                      PTINF-REC
           MOVE    SPA-HOSPID          TO  PTINF-HOSPID
           MOVE    SPA-PTID            TO  PTINF-PTID
           PERFORM 940-PTINF-READ-SEC
           IF      FLG-PTINF           =   1
               MOVE    "0002"          TO  SPA-ERRCD
               DISPLAY "K03 ZAINUM-SET ERR:" SPA-ERRCD
               GO      TO      45013-ZAINUM-SET-EXT
           END-IF
      *
      *    最大剤番号
           ADD     1                   TO  PTINF-MAXZAINUM
           MOVE    PTINF-MAXZAINUM     TO  WRK-ZAINUM
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "PTINF UPDTE ERR:"   MCP-RC
               MOVE    "0005"              TO  SPA-ERRCD
           END-IF 
      *
           .
      *
       45013-ZAINUM-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *   診療会計マスター新規編集処理
      *****************************************************************
       45015-SRYACCT-SRY-SEC          SECTION.
      *
           MOVE    SPACE               TO  SRYACCT-REC
           INITIALIZE                      SRYACCT-REC
           MOVE    LNK-WKSRY-HOSPID (01)   TO  ACCT-HOSPID
           MOVE    LNK-WKSRY-NYUGAIKBN(01) TO  ACCT-NYUGAIKBN
           MOVE    LNK-WKSRY-PTID   (01)   TO  ACCT-PTID
           MOVE    LNK-WKSRY-SRYKA  (01)   TO  ACCT-SRYKA
           MOVE    LNK-WKSRY-SRYYMD (01)(1:6)
                                           TO  ACCT-SRYYM
           MOVE    LNK-WKSRY-SRYKBN (01)   TO  ACCT-SRYKBN
           MOVE    WRK-ZAINUM          TO  ACCT-ZAINUM
           MOVE    SPA-HKNCOMBINUM     TO  ACCT-HKNCOMBI
      *    剤点数
           MOVE    WRK-ZAITEN          TO  ACCT-ZAITEN
      *    診療コード計
           MOVE    WRK-SRYCDKEI        TO  ACCT-SRYCDTOTAL
      *    数量計
           MOVE    WRK-SRYSURYOKEI     TO  ACCT-SURYOUTOTAL
      *    明細数
           MOVE    WRK-MEISAISU        TO  ACCT-MEISAISU
      *    手技点数１
           MOVE    WRK-SYUTEN1         TO  ACCT-SYUTEN1
      *    手技点数２
           MOVE    WRK-SYUTEN2         TO  ACCT-SYUTEN2
      *    薬剤点数
           MOVE    WRK-YKZTEN          TO  ACCT-YKZTEN
      *    器材点数
           MOVE    WRK-KIZAITEN        TO  ACCT-KIZAITEN
           .
      *
       45015-SRYACCT-SRY-EXT.
           EXIT.
      *
      *****************************************************************
      *   診療会計マスター編集処理
      *****************************************************************
       45014-SRYACCT-HEN-SEC          SECTION.
      *
      *    剤回数
           ADD     WRK-SRYKAISUKEI     TO  ACCT-ZAIKAISU
      *    回数セット
           MOVE    SPA-SRYYMD(7:2)     TO  IDX2
           ADD     WRK-SRYKAISUKEI     TO  ACCT-DAY  (1 IDX2)
      *
           COMPUTE IDX1                =   WRK-JYURRK-RENNUM
                                       +   1
           IF      IDX1                >   4
               MOVE    4                   TO  IDX1
           END-IF
           ADD     WRK-SRYKAISUKEI     TO  ACCT-DAY  (IDX1 IDX2)
           .
      *
       45014-SRYACCT-HEN-EXT.
           EXIT.
      *****************************************************************
      *    診療行為マスター処理
      *****************************************************************
       4501-SRYACT-SYORI-SEC          SECTION.
      *
      *
           MOVE    ZERO                TO  WRK-MEIBAN
      *    新規分のみ、作成する
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   IDX-KOUI
               INITIALIZE                          SRYACT-REC
               MOVE    LNK-WKSRY-HOSPID  (IDX) TO  SRY-HOSPID
               MOVE    LNK-WKSRY-NYUGAIKBN (IDX)   TO  SRY-NYUGAIKBN
               MOVE    LNK-WKSRY-PTID   (IDX)  TO  SRY-PTID
               MOVE    LNK-WKSRY-SRYKA  (IDX)  TO  SRY-SRYKA
               MOVE    LNK-WKSRY-SRYYMD (IDX)(1:6)
                                               TO  SRY-SRYYM
      *        剤番号
               MOVE    WRK-ZAINUM              TO  SRY-ZAINUM
      *        連番号
               MOVE    IDX                     TO  SRY-RENNUM
               MOVE    LNK-WKSRY-SRYSYUKBN(IDX)
                                               TO  SRY-SRYSYUKBN
               MOVE    LNK-WKSRY-SRYKBN (IDX)  TO  SRY-SRYKBN
               MOVE    LNK-WKSRY-JIHIMONEYTOTAL (IDX)
                                               TO  SRY-JIHIMONEYTOTAL
               PERFORM VARYING IDX-SIN     FROM    1   BY  1
                       UNTIL   IDX-SIN     >   5
                   MOVE    LNK-WKSRY-SRYCD (IDX IDX-SIN)
                                               TO  SRY-SRYCD (IDX-SIN)
                   MOVE    LNK-WKSRY-SRYSURYO(IDX IDX-SIN)
                                               TO  SRY-SRYSURYO
                                                            (IDX-SIN)
                   MOVE    LNK-WKSRY-SRYKAISU(IDX IDX-SIN)
                                               TO  SRY-SRYKAISU
                                                            (IDX-SIN)
                   MOVE    LNK-WKSRY-AUTOKBN(IDX IDX-SIN)
                                               TO  SRY-AUTOKBN
                                                            (IDX-SIN)
                   MOVE    LNK-WKSRY-JIHIMONEY (IDX IDX-SIN)
                                               TO  SRY-JIHIMONEY
                                                            (IDX-SIN)
      *            患者コメント作成
                   IF      LNK-WKSRY-SRYCD (IDX IDX-SIN)(1:1)  =   "8"
                       PERFORM 45011-PTCOM-SYROI-SEC
                   END-IF
               END-PERFORM
      *
      *
               MOVE    SRYACT-REC          TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "SRYACT-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "K03 SRYACT INS ERR:" SRY-KEY  "."
                   DISPLAY "MCP-RC:" MCP-RC ":" 
                   MOVE    "0005"          TO  SPA-ERRCD
               END-IF
      *
           END-PERFORM
           .
      *
       4501-SRYACT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者コメント作成処理
      *****************************************************************
       45011-PTCOM-SYROI-SEC           SECTION.
      *
      *    入力があれば作成
           IF     (LNK-WKSRY-INPUTCHI-G (IDX IDX-SIN)  =  SPACE ) AND
                  (LNK-WKSRY-INPUTCOMENT(IDX IDX-SIN)  =  SPACE )
               GO      TO      45011-PTCOM-SYROI-EXT
           END-IF
      *
           ADD     1                   TO  WRK-MEIBAN
           INITIALIZE                  PTCOM-REC
      *医療機関ＩＤ
           MOVE    SRY-HOSPID          TO  PTCOM-HOSPID
      *患者ＩＤ
           MOVE    SRY-PTID            TO  PTCOM-PTID
      *剤番号
           MOVE    SRY-ZAINUM          TO  PTCOM-ZAINUM
      *診療コード
           MOVE    LNK-WKSRY-SRYCD (IDX IDX-SIN)
                                       TO  PTCOM-SRYCD
      *コメント枝番番号
           MOVE    WRK-MEIBAN          TO  PTCOM-RENNUM
      *入力コメント
           MOVE    LNK-WKSRY-INPUTCOMENT(IDX IDX-SIN)
                                       TO  PTCOM-INPUTCOMENT
      *入力値
           MOVE    LNK-WKSRY-INPUTCHI-G  (IDX IDX-SIN)
                                       TO  PTCOM-INPUTCHI-AREA
      *
           MOVE    PTCOM-REC           TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "PTCOM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "K03 PTCOM INS ERR:" PTCOM-KEY
               MOVE    "0005"          TO  SPA-ERRCD
           END-IF
      *
      *    明細番号
           MOVE    WRK-MEIBAN          TO  SRY-INPUTNUM  (IDX-SIN)
      *
           .
       45011-PTCOM-SYROI-EXT.
           EXIT.
      *
      *****************************************************************
      *     算定履歴更新処理
      *****************************************************************
       4502-SANTEI-SYORI-SEC              SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   IDX-KOUI
               PERFORM VARYING     IDY     FROM    1   BY  1
                       UNTIL      (IDY     >   5   )  OR
                                  (LNK-WKSRY-SRYCD (IDX IDY) =   SPACE)
      *            手技料の時、算定歴を判定する
                   IF    ((LNK-WKSRY-SRYCD (IDX IDY)(1:1)  =   "1" )
                       OR (LNK-WKSRY-SRYCD (IDX IDY) =   "099110001" ))
      *            自費の時、履歴なし
                   AND    (LNK-WKSRY-SRYKBN(IDX)   NOT =   "95"  AND
                                                           "96"  )
                       MOVE    LNK-WKSRY-SRYCD (IDX IDY)
                                                   TO  WRK-SRYCD
      *
                       MOVE    WRK-SRYCD           TO  TNS-SRYCD
                       PERFORM 910-TENSU-READ-SEC
      *                算定用の診療コードへ変更
                       PERFORM 45020-SANTEI-SRYCD-SEC
                       IF      LNK-WKSRY-SRYCD (IDX IDY)
                                               NOT =   WRK-SRYCD
                           MOVE    WRK-SRYCD           TO  TNS-SRYCD
                           PERFORM 910-TENSU-READ-SEC
                       END-IF
      *
                       IF      TNS-SANTEIRRKKBN    NOT =   ZERO
      *                    特定薬剤治療管理の初回日があれば編集
                           MOVE    1               TO  FLG-TOKTEI
                           MOVE    LNK-WKSRY-ZAIKAIKEI(IDX)
                                                   TO  WRK-KAISU
                           PERFORM 45021-SANTEI-UPD-SEC
                       END-IF
                   END-IF
               END-PERFORM
           END-PERFORM
      *
      *    検診等より診療行為の発生した時、仮の初診料を算定する
      *    IF      FLG-SYOSIN-DUMMY    =   1
      *        MOVE    "099110001"         TO  WRK-SRYCD
      *        MOVE    WRK-SRYCD           TO  TNS-SRYCD
      *        PERFORM 910-TENSU-READ-SEC
      *
      *        IF      TNS-SANTEIRRKKBN    NOT =   ZERO
      *            MOVE    ZERO            TO  FLG-TOKTEI
      *            MOVE    1               TO  WRK-KAISU
      *            PERFORM 45021-SANTEI-UPD-SEC
      *        END-IF
      *        MOVE    ZERO                TO  FLG-SYOSIN-DUMMY
      **** END-IF
           .
       4502-SANTEI-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    算定用の診療コードへ変更処理
      *****************************************************************
       45020-SANTEI-SRYCD-SEC              SECTION.
      *
      *    包括逓減区分判定
           EVALUATE    TNS-HOUKATUTEIGENKBN
      *        頭部
               WHEN    201
                   MOVE    "099700101"         TO  WRK-SRYCD
      *        躯幹
               WHEN    202
                   MOVE    "099700102"         TO  WRK-SRYCD
      *        四肢
               WHEN    203
                   MOVE    "099700103"         TO  WRK-SRYCD
           END-EVALUATE
           .
       45020-SANTEI-SRYCD-EXT.
           EXIT.
      *
      *****************************************************************
      *    算定履歴更新処理
      *****************************************************************
       45021-SANTEI-UPD-SEC              SECTION.
      *
           IF      WRK-SRYYMD          =   SPACE
               MOVE    SPA-SRYYMD          TO  WRK-SRYYMD
           END-IF
      *
           INITIALIZE                  ORCSSANTEIAREA
           MOVE    "1"                 TO  SSANTEI-SYORI
           MOVE    "K03"               TO  SSANTEI-PG
           MOVE    WRK-SRYCD           TO  SSANTEI-SRYCD
           MOVE    WRK-SRYYMD          TO  SSANTEI-SRYYMD
           MOVE    SPA-PTID            TO  SSANTEI-PTID
           IF     (FLG-TOKTEI          =   1   )  OR
                  (SPA-TOKTEI-YMD  NOT =   SPACE)
               MOVE    SPA-TOKTEI-YMD  TO  SSANTEI-SYOKAIYMD
           END-IF
           MOVE    WRK-KAISU           TO  SSANTEI-KAISU
      *    初診料算定日
           IF      KARRK-SYOSINYMD2    =   SPACE
               MOVE    KARRK-SYOSINYMD1    TO  SSANTEI-SYOYMD
           ELSE
               MOVE    KARRK-SYOSINYMD2    TO  SSANTEI-SYOYMD
           END-IF
           CALL    "ORCSSANTEI"        USING
                                       ORCSSANTEIAREA
                                       SPA-AREA
      *
           .
       45021-SANTEI-UPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    ワーク診療行為マスタ−削除処理
      *****************************************************************
       45002-WKSRYACT-DEL-SEC              SECTION.
      *
      *    作成済みのワーク診療行為マスタ−を削除する
           MOVE    SPACE               TO  WKSRYACT-REC
           MOVE    SPA-HOSPID          TO  WKSRY-HOSPID
           MOVE    SPA-PTID            TO  WKSRY-PTID
           MOVE    SPA-NYUGAIKBN       TO  WKSRY-NYUGAIKBN
           MOVE    SPA-SRYKA           TO  WKSRY-SRYKA
           MOVE    SPA-SRYYMD          TO  WKSRY-SRYYMD
      *****MOVE    SPA-HKNCOMBINUM     TO  WKSRY-HKNCOMBI
           MOVE    SPA-WKSRY-HKNCOMBI  TO  WKSRY-HKNCOMBI
      *
           MOVE    WKSRYACT-REC        TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "WKSRYACT-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    IF      MCP-RC          NOT =   ZERO
      *D       DISPLAY "K03 WKSRYACT DEL ERR:" MCP-RC
      *D       MOVE    "0003"          TO  SPA-ERRCD
      *    END-IF
      *
           .
       45002-WKSRYACT-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診内容ファイル更新処理
      *****************************************************************
       45003-UKETUKE-SEC            SECTION.
      *
      *
           ACCEPT  WRK-TIME11           FROM  TIME
           MOVE    WRK-TIME1(1:4)       TO  WRK-TIME2(1:4)
      *    受診内容ファイルを特定する
           INITIALIZE                      UKETUKE-REC
           MOVE    SPA-HOSPID          TO  UKE-HOSPID
           MOVE    SPA-SYSYMD          TO  UKE-UKEYMD
           MOVE    SPA-PTID            TO  UKE-PTID
           MOVE    UKETUKE-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "UKETUKE-KEY2"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "UKETUKE-KEY2"      TO  ORC-DBPATH
               PERFORM 976-UKETUKE-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-UKETUKE
           END-IF
           PERFORM
                   UNTIL       FLG-UKETUKE     =    1
               IF       SPA-SRYKA          =   UKE-SRYKA
                   IF      UKE-KAIKEITIME      =   ZERO
                       MOVE    WRK-TIME22          TO  UKE-KAIKEITIME
                       MOVE    UKETUKE-REC         TO  MCPDATA-REC
                       MOVE    "DBUPDATE"          TO  MCP-FUNC
                       MOVE    "UKETUKE-KEY"       TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"          USING
                                                    MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
                       MOVE    1                   TO  FLG-UKETUKE
                   END-IF
               END-IF
      *
               IF      FLG-UKETUKE         =   ZERO
                   MOVE    "UKETUKE-KEY2"      TO  ORC-DBPATH
                   PERFORM 976-UKETUKE-NEXT-SEC
               END-IF
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "UKETUKE-KEY2"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       45003-UKETUKE-EXT.
           EXIT.
      *
      *****************************************************************
      *    各帳票印刷処理
      *****************************************************************
       45009-PRINT-SEC              SECTION.
      *
      *    帳票プログラム取得
           PERFORM 4901-PRINT-PG-SEC
      *
      *    処方箋印刷（Ａ４）
      *****MOVE    WRK-JYURRK-RENNUM   TO  ORCHC02-RENNUM
      *    MOVE    SPACE               TO  ORCHC02-KBN
      *
      *    IF      SPA-GMN-SYOHOPRTFLG =   "1"
      *        CALL    "ORCHC02"           USING   MCPAREA
      *                                            SPA-AREA
      *                                            ORCHC02AREA
      *****END-IF
      *
      *    処方箋印刷（Ａ５）
           INITIALIZE                      ORCHC19AREA
           MOVE    WRK-JYURRK-RENNUM   TO  ORCHC19-RENNUM
           MOVE    SPACE               TO  ORCHC19-KBN
           IF      SPA-GMN-SYOHOPRTFLG =   "2"
               MOVE    "3"                 TO  ORCHC19-KBN
           END-IF
      *
           IF      SPA-GMN-SYOHOPRTFLG =   "1"  OR  "2"
               CALL    WRK-SYOHOU-PG       USING   SPA-AREA
                                                   ORCHC19AREA
           END-IF
      *
      *    請求書印刷
           INITIALIZE                      ORCHC03AREA
           MOVE    WRK-DENPNUM         TO  ORCHC03-DENPNUM
           MOVE    SPA-GMN-SEIKYU      TO  ORCHC03-SEIKYU
           MOVE    SPA-GMN-NYUKIN      TO  ORCHC03-NYUKIN
           IF      SPA-GMN-HAKFLG      =   "1"
               CALL    WRK-SEIKYU-PG       USING   SPA-AREA
                                                   ORCHC03AREA
           END-IF
      *
      *    薬情報出力
           IF      SPA-GMN-YAKJYOFLG   =   "1"  OR  "2"
               INITIALIZE                      ORCSCH30AREA
               MOVE    WRK-JYURRK-RENNUM   TO  ORCSCH30-RENNUM
               MOVE    SPA-GMN-YAKJYOFLG   TO  ORCSCH30-KBN
               CALL    "ORCSCH30"          USING   SPA-AREA
                                                   ORCSCH30AREA
           END-IF
           .
       45009-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票プログラム取得処理
      *****************************************************************
       4901-PRINT-PG-SEC              SECTION.
      *
      *    請求書
           MOVE    SPACE               TO  WRK-SEIKYU-PG
           MOVE    SPACE               TO  SYS-1032-REC
           INITIALIZE                      SYS-1032-REC
           MOVE    "1032"              TO  SYS-1032-KANRICD
           MOVE    "00000003"          TO  SYS-1032-KBNCD
      *
           MOVE    SYS-1032-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 960-KANRIMST-READ-SEC
           ELSE
               INITIALIZE                  SYS-1010-REC
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
      *    処方せん
           MOVE    SPACE               TO  WRK-SYOHOU-PG
           MOVE    SPACE               TO  SYS-1032-REC
           INITIALIZE                      SYS-1032-REC
           MOVE    "1032"              TO  SYS-1032-KANRICD
           MOVE    "00000002"          TO  SYS-1032-KBNCD
      *
           MOVE    SYS-1032-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 960-KANRIMST-READ-SEC
           ELSE
               INITIALIZE                  SYS-1010-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1032-REC
      *        独自開発分
               IF      SYS-1032-ORCACSTCHK     =   "T"
                   MOVE    SYS-1032-ORCACSTNM  TO  WRK-SYOHOU-PG
               ELSE
      *        ＯＲＣＡ標準分
                   MOVE    SYS-1032-ORCAORGNM  TO  WRK-SYOHOU-PG
               END-IF
           END-IF
           IF      WRK-SYOHOU-PG       =   SPACE
               MOVE    "ORCHC19"           TO  WRK-SYOHOU-PG
           END-IF
      *
           .
      *
       4901-PRINT-PG-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＣＬＡＩＭ接続情報取得処理
      *****************************************************************
       4905-CLAIM-CHK-SEC               SECTION.
      *
           INITIALIZE                  SPA-K03X-AREA
      *
           MOVE    ZERO                TO  FLG-CLAIM
      *    ＣＬＡＩＭ接続判定
           MOVE    SPACE               TO  SYS-9000-REC
           INITIALIZE                  SYS-9000-REC
           MOVE    "9000"              TO  SYS-9000-KANRICD
           MOVE    "*"                 TO  SYS-9000-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
      *    システム管理検索
           MOVE    SYS-9000-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 960-KANRIMST-READ-SEC
           ELSE
               INITIALIZE                  SYS-9000-REC
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF      FLG-SYSKANRI        =   1
               CONTINUE
           ELSE
               MOVE    MCPDATA-REC         TO  SYS-9000-REC
               MOVE    SYS-9000-CODE       TO  SPA-GMN-SCODE
               MOVE    1                   TO  SPA-K03X-GMN-SEL
               IF      SYS-9000-SETUZOKU   =   ZERO
                   CONTINUE
               ELSE
                   MOVE    SYS-9000-CODE       TO  SPA-K03X-CODE
                   IF      SYS-9000-SYNBUTTON (02) =   "T"
                       MOVE    2               TO  FLG-CLAIM
                   ELSE
                       MOVE    1               TO  FLG-CLAIM
                   END-IF
               END-IF
           END-IF
      *
           IF      FLG-CLAIM           =   2
               CONTINUE
           ELSE
               GO      TO      4905-CLAIM-CHK-EXT
           END-IF
      *
      *    ＣＬＡＩＭ接続情報
           MOVE    SPA-K01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-K03         TO  SPA-FREE
      *
           MOVE    "LINK"              TO  MCP-STATUS
           MOVE    SPACE               TO  MCP-EVENT
      *
           CALL    "ORCGK03X"          USING
                                       MCPAREA
                                       SPAAREA
                                       LINKAREA
                                       SCRAREA.
      *
           MOVE    SPA-COMMON          TO  SPA-AREA
           MOVE    SPA-FREE            TO  SPA-K03
           MOVE    SPA-WORK            TO  SPA-K01KYOUTU
     *
           MOVE    "K03"               TO  SPA-MOTOPG
           MOVE    "K03X"              TO  SPA-SAKIPG
      *    カーソル移動
           MOVE    "SELNUM"            TO  MCP-WIDGET
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "K03X"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       4905-CLAIM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＣＬＡＩＭ接続情報取得処理
      *****************************************************************
       4906-CLAIM-SOUSIN-SEC               SECTION.
      *
           MOVE    SPACE               TO  SYS-9001-REC
           INITIALIZE                  SYS-9001-REC
           MOVE    "9001"              TO  SYS-9001-KANRICD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
      *    システム管理検索
           MOVE    SYS-9001-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 960-KANRIMST-READ-SEC
           ELSE
               INITIALIZE                  SYS-9001-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       (IDX            >   10   )  OR
                               (FLG-SYSKANRI   =   1    )
               MOVE    MCPDATA-REC           TO  SYS-9001-REC
               MOVE    SYS-9001-KBNCD (1:2)  TO  WRK-GMN-SELNUM
               IF      WRK-GMN-SELNUM        =   SPA-K03X-GMN-SEL
                 MOVE    SYS-9001-ADDRESS    TO  SHELLTBL-ARG7
                 MOVE    SYS-9001-PORT2      TO  SHELLTBL-ARG8
                 MOVE    99                    TO  IDX
               END-IF
      *
               MOVE    "SYSKANRI-KEY2"       TO  ORC-DBPATH
               PERFORM 960-KANRIMST-READ-SEC
           END-PERFORM
      *
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    フィアルデイレクトリ位置指定
           INITIALIZE                  ORCSMKPASSAREA
           MOVE    CLAIM-FILE          TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"        USING   ORCSMKPASSAREA
      *
           MOVE    MKPASS-OT-01        TO  SHELLTBL-NAME
      *
           MOVE    "1"                 TO  SHELLTBL-ARG1
           MOVE    SPA-PTID            TO  WRK-PTID
           MOVE    WRK-PTID            TO  SHELLTBL-ARG2
           MOVE    SPA-SRYKA           TO  SHELLTBL-ARG3
           MOVE    SPA-SRYYMD          TO  SHELLTBL-ARG4
           MOVE    SPA-HKNCOMBINUM     TO  SHELLTBL-ARG5
           MOVE    SPA-HOSPID          TO  SHELLTBL-ARG6
           MOVE    SHELLTBL            TO  MCPDATA-REC
           MOVE    "SHELL"             TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL    TO  MCP-PATH
           CALL    "MCPSUB"            USING
                   MCPAREA
                   MCPDATA-REC
      *
           .
       4906-CLAIM-SOUSIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO      TO      500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-KIDCD       NOT =   SPACE
               PERFORM 520-KIDSET-SEC
               GO      TO      500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "K03"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "調整金は整数７桁で入力して下さい。"
                                       TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "患者マスタがありません。処理順エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "伝票番号取得エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE
                   "今回請求額がゼロ以下になります。"
                                       TO  SPA-ERRMSG(1:)
                   MOVE
                   "調整金を再入力して下さい"
                                       TO  SPA-ERRMSG(33:)
               WHEN    "0005"
                   MOVE    "更新エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "請求書兼領収書選択エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "入金額は整数で入力して下さい。"
                                       TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "入金額は今回請求額以下にして下さい。"
                                       TO  SPA-ERRMSG
               WHEN    "0009"
                   MOVE    "院外処方せん選択エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "薬剤情報選択エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0011"
                   MOVE    "ドクター選択エラー"
                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  KERR
           MOVE    SPA-ERRCD           TO  KERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  KERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "K03"               TO  SPA-MOTOPG
           MOVE    "KERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "KERR"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       520-KIDSET-SEC              SECTION.
      *
           EVALUATE    SPA-KIDCD
               WHEN    "0101"
                   MOVE
                   "継続分も含め受診履歴を削除します。"
                                       TO  WRK-KIDMSG(1:34)
                   MOVE
                   "よろしいですか？"
                                       TO  WRK-KIDMSG(35:)
           END-EVALUATE
      *
           MOVE    SPACE               TO  KID1
           MOVE    SPA-KIDCD           TO  KID1-ID1CODE
           MOVE    WRK-KIDMSG          TO  KID1-ID1MSG
      *
           MOVE    "戻る"              TO  KID1-B01
           MOVE    "ＯＫ"              TO  KID1-B12
      *
           MOVE    "B12"               TO  MCP-WIDGET
      *
           MOVE    "K03"               TO  SPA-MOTOPG
           MOVE    "KID1"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "KID1"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       520-KIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納マスター読込
      *****************************************************************
       900-SYUNOU-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SYUNOU-REC
               MOVE    ZERO                TO  FLG-SYUNOU
           ELSE
               INITIALIZE                      SYUNOU-REC
               MOVE    1                   TO  FLG-SYUNOU
           END-IF
      *
           .
       900-SYUNOU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納明細マスター読込
      *****************************************************************
       900-SYUMEI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SYUMEI-REC
               MOVE    ZERO                TO  FLG-SYUMEI
           ELSE
               INITIALIZE                      SYUMEI-REC
               MOVE    1                   TO  FLG-SYUMEI
           END-IF
      *
           .
       900-SYUMEI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為マスター読込
      *****************************************************************
       915-SRYACT-NEXT-SEC         SECTION.
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
       915-SRYACT-NEXT-EXT.
           EXIT.
      *****************************************************************
      *    診療会計マスター読込
      *****************************************************************
       930-SRYACCT-NEXT-SEC         SECTION.
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
       930-SRYACCT-NEXT-EXT.
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
      *
      *****************************************************************
      *    患者コメントマスター読込
      *****************************************************************
       950-PTCOM-READ-SEC         SECTION.
      *
           MOVE    PTCOM-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTCOM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTCOM-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC        TO  PTCOM-REC
                   MOVE    ZERO               TO  FLG-PTCOM
               ELSE
                   MOVE    1                  TO  FLG-PTCOM
               END-IF
           ELSE
               MOVE    1              TO  FLG-PTCOM
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTCOM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       950-PTCOM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       960-KANRIMST-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-SYSKANRI
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           .
       960-KANRIMST-READ-EXT.
           EXIT.
      *****************************************************************
      *    受診履歴順読み
      *****************************************************************
       970-JYURRK-NEXT-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  JYURRK-REC 
               MOVE    ZERO                TO  FLG-JYURRK
           ELSE
               MOVE    1                   TO  FLG-JYURRK
           END-IF
      *
           .
       970-JYURRK-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科歴データ順読み
      *****************************************************************
       975-SRYKARRK-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SRYKARRK-REC 
               MOVE    ZERO                TO  FLG-SRYKARRK
           ELSE
               MOVE    1                   TO  FLG-SRYKARRK
           END-IF
      *
           .
       975-SRYKARRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診内容データ読み込み
      *****************************************************************
       976-UKETUKE-NEXT-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  UKETUKE-REC 
               MOVE    ZERO                TO  FLG-UKETUKE
           ELSE
               MOVE    1                   TO  FLG-UKETUKE
           END-IF
      *
           .
       976-UKETUKE-NEXT-EXT.
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
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
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
      *    算定歴マスタ読み込み
      *****************************************************************
       920-SANTEI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SANTEI-REC
               MOVE    ZERO                TO  FLG-SANTEI
           ELSE
               INITIALIZE                      SANTEI-REC
               MOVE    1                   TO  FLG-SANTEI
           END-IF
      *
           .
       920-SANTEI-READ-EXT.
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
      *
      *****************************************************************
      *    パラメタデータ順読み
      *****************************************************************
       980-PARA-READ-SEC         SECTION.
      *
           READ    PARA-FILE 
               AT  END
                   MOVE    1           TO  FLG-PARA
               NOT AT  END 
                   MOVE    ZERO        TO  FLG-PARA
           END-READ
      *
           .
       980-PARA-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタデータ順読み
      *****************************************************************
      *990-PARA-NEXT-SEC           SECTION.
      *
      *    READ    PARA-FILE       NEXT
      *        AT  END
      *            MOVE    1           TO  FLG-PARA
      *        NOT AT  END
      *            MOVE    ZERO        TO  FLG-PARA
      *    END-READ
      *
      *    .
      *990-PARA-NEXT-EXT.
      *    EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
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
      *****************************************************************
      *    ＤＢＣＯＮＮＥＣＴ　処理
      *****************************************************************
      *990-DBDISCONNECT-SEC              SECTION.
      *
      *    MOVE    "DBDISCONNECT"      TO  MCP-FUNC
      *    CALL    "ORCMCPSUB"          USING
      *                                 MCPAREA
      *                                 ORCMCPAREA
      *                                 MCPDATA-REC
      *
      *    MOVE    "DBOPEN"           TO  MCP-FUNC
      *    CALL    "ORCMCPSUB"          USING
      *                                 MCPAREA
      *                                 ORCMCPAREA
      *                                 MCPDATA-REC
      *
      *    .
      *990-DBDISCONNECT-EXT.
      *****EXIT.
      *
