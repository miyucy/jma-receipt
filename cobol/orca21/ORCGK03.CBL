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
      *  02.00.13    NACL-多々納  03/02/13  訂正時の診療科履歴修正
      *  02.00.14    NACL-多々納  03/03/04  複数診療科まとめ追加
      *                                     収納明細削除追加
      *  02.00.15    NACL-多々納  03/03/05  排他制御処理追加
      *  02.00.16    NACL-多々納  03/08/27  剤明細５０へ変更
      *  02.00.17    NACL-多々納  04/01/07  更新をサブプロへ他
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
           03  FILLER              PIC X(07)   VALUE   "K01PARA".
           03  FILE-TERMID2        PIC X(64)   VALUE   SPACE.
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
      *    複数科まとめ有無
           03  FLG-FUKU-FLG              PIC 9(01).
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
           03  WRK-DEL-RENNUM              PIC 9(01).
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
      *差額
           03  WRK-SAGAKU              PIC S9(07).
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
      *    複数科集計用
           03  WRK-SYUKEI-AREA.
               05  WRK-SUM-SKYMONEY            PIC  9(07).
               05  WRK-SUM-HKNTEN              PIC  9(07).
      *
               05  WRK-SUM-MONEY               PIC  9(07).
               05  WRK-SUM-TGMONEY             PIC  9(07).
               05  WRK-SUM-TGMONEY-TAX         PIC  9(07).
               05  WRK-SUM-JIHI-TOTAL          PIC  9(07).
               05  WRK-SUM-JIHI-TOTAL-TAX      PIC  9(07).
               05  WRK-SUM-JIHI-TAX            PIC  9(07).
               05  WRK-SUM-YKZ-FTN             PIC  9(07).
      *
               05  WRK-HKNTEN-KIN              PIC 9(07).
      *
               05  WRK-HKNTEN-KEI              PIC 9(07)V99.
      *    保険組合せ保存
           03  WRK-HZN-HKNCOMBINUM     PIC X(04).
           03  WRK-HZN-HKNKBN          PIC X(01).
      *
      *    診療行為内容比較用テーブル
      *01  TBL-AREA.
      *    03  TBL-MAE-AREA.
      *        05  TBL-MAE-REC     OCCURS   30.
      *            07  TBL-MAE-SRYCD       PIC  X(09).
      *            07  TBL-MAE-SRYSURYO    PIC  9(05)V9(03).
      *            07  TBL-MAE-SRYKAISU    PIC  9(03).
      *            07  TBL-MAE-INPUTCOMENT PIC  X(40).
      *            07  TBL-MAE-ATAI-G.
      *                09  TBL-MAE-ATAI    PIC  X(08)  OCCURS  3.
      *    03  TBL-ATO-AREA.
      *        05  TBL-ATO-REC     OCCURS   30.
      *            07  TBL-ATO-SRYCD       PIC  X(09).
      *            07  TBL-ATO-SRYSURYO    PIC  9(05)V9(03).
      *            07  TBL-ATO-SRYKAISU    PIC  9(03).
      *            07  TBL-ATO-INPUTCOMENT PIC  X(40).
      *            07  TBL-ATO-ATAI-G.
      *****            09  TBL-ATO-ATAI    PIC  X(08)  OCCURS  3.
      *
      *    剤テーブル領域
       01  WRK-TBL-ZAINUM-AREA.
           03  WRK-TBL-ZAINUM-G            OCCURS   100.
               05  WRK-TBL-ZAINUM          PIC 9(08).
           03  WRK-TBL-IDX                 PIC 9(04).
           03  FLG-ZAINUM                  PIC 9(01).
      *
      *    まとめテーブル領域
       01  TBL-FUKU-AREA.
           03  TBL-FUKU-OCCURS             OCCURS   5.
               05  TBL-FUKU-DENPNUM        PIC 9(07).
               05  TBL-FUKU-MATKBN         PIC X(01).
               05  TBL-FUKU-CNT            PIC 9(04).
               05  TBL-FUKU-SRYKA          PIC X(01).
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
           02  LNK-WKSRYACT-REC      OCCURS   50.
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
      *    ドクター編集処理パラメタ
           COPY    "CPORCSDRSET.INC".
      *
      *    診療会計剤チェックパラメタ
           COPY    "CPORCSCZAICHK.INC".
      *
      *    排他制御サブパラメタ
           COPY    "CPORCSLOCK.INC".
      *
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    診療行為外来更新パラメタ領域
           COPY    "CPORCSCGAIRAI.INC".
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
           MOVE    SPA-COMMON      TO  SPA-AREA
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
      *    複数科の差額ある時、調整へ
           IF      SPA-GMN-FUKUSAGAKU  NOT =   ZERO
               MOVE    6               TO  SPA-GMN-CUR
           END-IF
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
      *TEST
           DISPLAY "K03 SYU-DENPNUM:" SYU-DENPNUM
                  ",SPA-SYORIFLG:" SPA-SYORIFLG
      *TEST
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
      *    複数科編集
           PERFORM 3104-FUKU-HEN-SEC
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
      *    MOVE    SPACE               TO  SYS-1010-REC
      *    INITIALIZE                  SYS-1010-REC
      *    MOVE    "1010"              TO  SYS-1010-KANRICD
      *    MOVE    ZERO                TO  SYS-1010-STYUKYMD
      *    MOVE    ALL "9"             TO  SYS-1010-EDYUKYMD
      *    システム管理検索
      *    MOVE    SYS-1010-REC        TO  MCPDATA-REC
      *    MOVE    "DBSELECT"          TO  MCP-FUNC
      *    MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
      *    MOVE    SPA-SRYYMD          TO  ORC-DBYMD
      *    CALL    "ORCMCPSUB"          USING
      *                                 MCPAREA
      *                                 ORCMCPAREA
      *                                 MCPDATA-REC
      *    IF      MCP-RC              =   ZERO
      *        MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
      *        PERFORM 960-KANRIMST-READ-SEC
      *    ELSE
      *        INITIALIZE                  SYS-1010-REC
      *        MOVE    1               TO  FLG-SYSKANRI
      *    END-IF
      *    MOVE    ZERO                TO  IDX
      *    PERFORM
      *            UNTIL       (IDX            >=   10  )  OR
      *                        (FLG-SYSKANRI   =   1    )
      *        MOVE    MCPDATA-REC             TO  SYS-1010-REC
      *        IF      SYS-1010-KBNCD(1:1)     =   "1"
      *            ADD     1                 TO  IDX
      *            MOVE    SYS-1010-KBNCD(2:4)
      *                                      TO  SPA-GMN-DRCDL (IDX)
      *            MOVE    SYS-1010-NAME     TO  SPA-GMN-DRCDMEIL(IDX)
      *        END-IF
      *
      *        MOVE    "SYSKANRI-KEY2"    TO  ORC-DBPATH
      *        PERFORM 960-KANRIMST-READ-SEC
      *    END-PERFORM
      *
      *    MOVE    IDX                 TO  SPA-DRCD-MAX
      *
      *    PERFORM VARYING     IDX     FROM    1   BY  1
      *            UNTIL       IDX     >   SPA-DRCD-MAX
      *        IF      SPA-DRCD(2:4)   =   SPA-GMN-DRCDL (IDX)
      *            MOVE    SPA-GMN-DRCDLST(IDX) TO  SPA-GMN-DRCD-G
      *            MOVE    SPA-DRCD-MAX         TO  IDX
      *        END-IF
      **** END-PERFORM
      *
      *    ドクター編集
           INITIALIZE                  ORCSDRSETAREA
           MOVE    "1"                 TO  ORCSDR-KBN
           MOVE    SPA-SRYYMD          TO  ORCSDR-SYSYMD
           MOVE    SPA-SRYKA           TO  ORCSDR-SRYKA
           MOVE    SPA-DRCD(2:4)       TO  ORCSDR-IN-DRCD
           CALL    "ORCSDRSET"         USING
                                       SPA-AREA
                                       ORCSDRSETAREA
           MOVE    ORCSDR-DRCD-TBL-G   TO  SPA-GMN-DRCDLST-G
           MOVE    ORCSDR-DRCD-MAX     TO  SPA-DRCD-MAX
           MOVE    ORCSDR-IN-DRCD-G    TO  SPA-GMN-DRCD-G
      *
      *
           .
       3103-DRCD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    複数科編集処理
      *****************************************************************
       3104-FUKU-HEN-SEC                  SECTION.
      *
           INITIALIZE                  SPA-FUKU-AREA
      *    当日の複数科まとめの有無判定
           PERFORM 31040-FUKU-CHK-SEC
      *
      *    対象がない時
           IF      SPA-FUKU-DENPNUM    =   ZERO
               GO      TO      3104-FUKU-HEN-EXT
           END-IF
      *    新規時、まとめ集計をする
           IF      SPA-SYORIFLG        =   ZERO
               PERFORM 31041-FUKU-SYUKEI-SEC
           END-IF
      *
      *    訂正で確定によりメッセージ表示
           EVALUATE    SPA-FUKU-MATKBN
               WHEN    "1"
                   MOVE    "＜複数科の継続中＞"    TO  SPA-GMN-FUKUMSG
               WHEN    "2"
                   MOVE    "＜複数科の確定済＞"    TO  SPA-GMN-FUKUMSG
               WHEN    OTHER
                   MOVE    SPACE                   TO  SPA-GMN-FUKUMSG
           END-EVALUATE
      *
           .
       3104-FUKU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    対象のまとめ判定処理
      *****************************************************************
       31040-FUKU-CHK-SEC                  SECTION.
      *
      *    訂正で、訂正分の時
           INITIALIZE                      TBL-FUKU-AREA
           INITIALIZE                      SPA-FUKU-AREA
           IF      SPA-SYORIFLG        =   1
               IF      SYU-FUKU-DENPNUM    NOT =   ZERO
                   ADD     1               TO  SPA-FUKU-CNT
               END-IF
               MOVE    SYU-FUKU-DENPNUM    TO  SPA-FUKU-DENPNUM
               MOVE    SYU-FUKU-KBN        TO  SPA-FUKU-MATKBN
           END-IF
      *
           MOVE    SYUNOU-REC          TO  WRK-SYUNOU-REC
      *
           INITIALIZE                      SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-PTID            TO  SYU-PTID
           MOVE    SPA-SRYYMD          TO  SYU-SRYYMD
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY11"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYUNOU-KEY11"      TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SYUNOU
           END-IF
           PERFORM UNTIL    FLG-SYUNOU     =   1
      *        複数伝票番号あるもの
               IF      SYU-FUKU-DENPNUM    NOT =   ZERO
      *            保険が同じ時対象とする
                   IF     (SYU-HKNCOMBINUM     =   SPA-HKNCOMBINUM)
                       PERFORM 310401-HKNCOBMI-CHK-SEC
                   END-IF
               END-IF
      *
               MOVE    "SYUNOU-KEY11"      TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           END-PERFORM
      *
      *    複数科判定
           PERFORM 310402-FUKU-HEN-SEC
      *
           MOVE    WRK-SYUNOU-REC          TO  SYUNOU-REC
      *
           .
       31040-FUKU-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    対象の保険組合せ編集処理
      *****************************************************************
       310401-HKNCOBMI-CHK-SEC                  SECTION.
      *
      *    伝票番号毎にテーブルに保存する
           PERFORM VARYING    IDX2     FROM    1   BY   1
                   UNTIL      IDX2     >   5
               IF      TBL-FUKU-DENPNUM (IDX2)  =   ZERO
                   MOVE    SYU-FUKU-DENPNUM     TO  TBL-FUKU-DENPNUM
                                                                (IDX2)
               END-IF
               IF      SYU-FUKU-DENPNUM    =   TBL-FUKU-DENPNUM (IDX2)
                   MOVE    SYU-FUKU-KBN    TO  TBL-FUKU-MATKBN  (IDX2)
                   ADD     1               TO  TBL-FUKU-CNT     (IDX2)
                   IF      SYU-SRYKA       =   SPA-SRYKA
                       MOVE    "1"             TO  TBL-FUKU-SRYKA(IDX2)
                   END-IF
                   MOVE    5                   TO   IDX2
               END-IF
           END-PERFORM
           .
       310401-HKNCOBMI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    対象の保険組合せ編集処理
      *****************************************************************
       310402-FUKU-HEN-SEC                  SECTION.
      *
           PERFORM VARYING    IDX2     FROM    1   BY   1
                   UNTIL     (IDX2     >   5    )  OR
                             (TBL-FUKU-DENPNUM (IDX2)  =   ZERO)
      *        訂正の時は同じ伝票番号を対象とする
               IF      SPA-SYORIFLG        =   1
                   IF      SPA-FUKU-DENPNUM    =   TBL-FUKU-DENPNUM
                                                               (IDX2)
                       MOVE    TBL-FUKU-MATKBN (IDX2)
                                                TO  SPA-FUKU-MATKBN
                       MOVE    TBL-FUKU-CNT (IDX2)
                                                TO  SPA-FUKU-CNT
                       MOVE    5                TO  IDX2
                   END-IF
      *
               ELSE
      *            同じ科で、確定がない時
                   IF      TBL-FUKU-SRYKA(IDX2)     =   "1"
                       IF      TBL-FUKU-MATKBN (IDX2)   =   "1"
                           MOVE    "1"          TO  SPA-FUKU-SYORI
                       END-IF
                   ELSE
                       IF      TBL-FUKU-MATKBN (IDX2)   =   "1"
      *                    科が違うもの
                           MOVE    TBL-FUKU-DENPNUM (IDX2)
                                                TO  SPA-FUKU-DENPNUM
                           MOVE    TBL-FUKU-MATKBN (IDX2)
                                                TO  SPA-FUKU-MATKBN
                           MOVE    TBL-FUKU-CNT (IDX2)
                                                TO  SPA-FUKU-CNT
                       END-IF
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       310402-FUKU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    対象のまとめ集計処理
      *****************************************************************
       31041-FUKU-SYUKEI-SEC                  SECTION.
      *
           MOVE    SYUNOU-REC          TO  WRK-SYUNOU-REC
           INITIALIZE                      SYUNOU-REC
           INITIALIZE                      WRK-SYUKEI-AREA
      *
      *    対象のまとめを集計
           INITIALIZE                      SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-PTID            TO  SYU-PTID
           MOVE    SPA-FUKU-DENPNUM    TO  SYU-FUKU-DENPNUM
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY12"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYUNOU-KEY12"      TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SYUNOU
           END-IF
           PERFORM UNTIL    FLG-SYUNOU     =   1
      *
               PERFORM 310411-SYUNOU-ADD-SEC
      *
               MOVE    "SYUNOU-KEY12"      TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           END-PERFORM
      *    今回入力分集計
           MOVE    WRK-SYUNOU-REC      TO  SYUNOU-REC
           PERFORM 310411-SYUNOU-ADD-SEC
      *
      *    集計の点数から負担額計算
           COMPUTE WRK-HKNTEN-KEI      =  (WRK-SUM-HKNTEN  *  10 )
                                       *  (SPA-FTNRATE   /  100)
           COMPUTE WRK-HKNTEN-KIN      =  (WRK-HKNTEN-KEI
                                       +   5   )
                                       /   10
           COMPUTE WRK-HKNTEN-KIN      =   WRK-HKNTEN-KIN
                                       *   10
      *    今回請求額計算
           COMPUTE WRK-SKYMONEY        =   WRK-HKNTEN-KIN
                                       +   WRK-SUM-MONEY
                                       +   WRK-SUM-TGMONEY
                                       +   WRK-SUM-TGMONEY-TAX
                                       +   WRK-SUM-JIHI-TOTAL
                                       +   WRK-SUM-JIHI-TOTAL-TAX
                                       +   WRK-SUM-JIHI-TAX
                                       +   WRK-SUM-YKZ-FTN
           IF      WRK-SUM-SKYMONEY    NOT =   WRK-SKYMONEY
               COMPUTE SPA-GMN-FUKUSAGAKU  =   WRK-SKYMONEY
                                           -   WRK-SUM-SKYMONEY
           ELSE
               MOVE    ZERO                TO  SPA-GMN-FUKUSAGAKU
           END-IF
      *
           IF      SPA-GMN-FUKUSAGAKU  NOT =   ZERO
               MOVE    "まとめ計算差額"    TO  SPA-GMN-FUKUMDS
           END-IF
      *T??
           MOVE    "今回まとめ請求額"  TO  SPA-GMN-FUKUZENMDS
           MOVE    WRK-SKYMONEY        TO  SPA-MAT-SKYMONEY
           MOVE    WRK-SKYMONEY        TO  WRK-Z9
           MOVE    WRK-Z9              TO  SPA-GMN-FUKUZENMDS(19:)
      *
           .
       31041-FUKU-SYUKEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    合計請求額計算処理
      *****************************************************************
       310411-SYUNOU-ADD-SEC           SECTION.
      *
      *    請求額
           ADD     SYU-SKYMONEY        TO  WRK-SUM-SKYMONEY
      *    点数
           ADD     SYU-TOTAL-HKNTEN    TO  WRK-SUM-HKNTEN
      *    各金額
           ADD     SYU-TOTAL-MONEY     TO  WRK-SUM-MONEY
           ADD     SYU-TOTAL-TGMONEY   TO  WRK-SUM-TGMONEY
           ADD     SYU-TOTAL-TGMONEY-TAX   TO  WRK-SUM-TGMONEY-TAX
      *
           ADD     SYU-JIHI-TOTAL      TO  WRK-SUM-JIHI-TOTAL
           ADD     SYU-JIHI-TOTAL-TAX  TO  WRK-SUM-JIHI-TOTAL-TAX
           ADD     SYU-JIHI-TAX        TO  WRK-SUM-JIHI-TAX
           ADD     SYU-YKZ-FTN         TO  WRK-SUM-YKZ-FTN
           .
       310411-SYUNOU-ADD-EXT.
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
           MOVE    SPA-GMN-DENPNUM     TO  K03-DENPNUM
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
      *    複数診療科まとめ
           MOVE    SPA-GMN-FUKUSAGAKU  TO  WRK-Z92
           MOVE    WRK-Z92             TO  K03-FUKUSAGAKU
           MOVE    SPA-GMN-FUKUMDS     TO  K03-FUKUMDS
           IF      SPA-GMN-FUKUMSG     =   SPACE
               MOVE    SPACE               TO  K03-FUKUMSG
           ELSE
               MOVE    "red"               TO  K03-FUKUMSG-STYLE
               MOVE    SPA-GMN-FUKUMSG     TO  K03-FUKUMSG-VALUE
           END-IF
           MOVE    SPA-GMN-FUKUZENMDS  TO  K03-FUKUZENMDS
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
               WHEN    08
                   MOVE    "B09"             TO  MCP-WIDGET
               WHEN    09
                   MOVE    "B10"             TO  MCP-WIDGET
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
      *            複数科継続中の時、確定へ
                   IF     (SPA-FUKU-DENPNUM    NOT =   ZERO )  AND
                          (SPA-SYORIFLG            =   ZERO )
                       MOVE    09              TO  SPA-GMN-CUR
                   END-IF
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
      *                複数科継続中の時、確定へ
                       IF     (SPA-FUKU-DENPNUM    NOT =   ZERO )  AND
                              (SPA-SYORIFLG            =   ZERO )
                           MOVE    09              TO  SPA-GMN-CUR
                       END-IF
                   ELSE
                       MOVE    5                 TO  SPA-GMN-CUR
                   END-IF
      *       ドクター
               WHEN    "DRCD"
                   MOVE    07          TO  SPA-GMN-CUR
      *            複数科継続中の時、確定へ
                   IF     (SPA-FUKU-DENPNUM    NOT =   ZERO )  AND
                          (SPA-SYORIFLG            =   ZERO )
                       MOVE    09              TO  SPA-GMN-CUR
                   END-IF
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
                    MOVE    ZERO                TO  SPA-GMN-SYORI
                    PERFORM 450-TOROKU-SEC
      *        複数診療科継続
               WHEN    "CLICKED"       ALSO    "B09"
                    PERFORM 460-FUKU-KEIZOKU-SEC
      *        複数診療科確定
               WHEN    "CLICKED"       ALSO    "B10"
                    PERFORM 460-FUKU-KAKUATEI-SEC
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
      *
      *        合計額がゼロ以下の時、発行なしとする
               EVALUATE    WRK-MCP-WIDGET
      *        調整金
               WHEN    "CHOSEI"
                   IF      SPA-GMN-SEIGOK      <=  ZERO
                       MOVE    SPA-GMN-HAKFLGLST(1)
                                               TO  SPA-GMN-HAKFLG-G
                   END-IF
      *            複数科まとめの時、入金額を変更する
                   IF      SPA-GMN-FUKUZENMDS  NOT =   SPACE
                       COMPUTE WRK-SAGAKU  =   SPA-GMN-CHOSEI
                                           -   SPA-GMN-FUKUSAGAKU
                       COMPUTE WRK-SKYMONEY    =   SPA-MAT-SKYMONEY
                                               +   WRK-SAGAKU
                       MOVE    SPACE           TO  SPA-GMN-FUKUZENMDS
                       MOVE    "今回まとめ請求額"
                                               TO  SPA-GMN-FUKUZENMDS
                       MOVE    WRK-SKYMONEY    TO  WRK-Z9
                       MOVE    WRK-Z9          TO  SPA-GMN-FUKUZENMDS
                                                               (19:)
      *                入金額を変更する
                       MOVE    SPA-GMN-SEIKYU  TO  SPA-GMN-NYUKIN
                       MOVE    SPA-GMN-NYUKIN  TO  WRK-Z99
                       MOVE    WRK-Z99         TO  SPA-GMN-NYUKIN-X
                   END-IF
      *
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
      *****MOVE    ZERO                TO  FLG-CHK
      *    PERFORM VARYING     IDX     FROM    1   BY  1
      *            UNTIL       IDX     >   SPA-DRCD-MAX
      *        IF      SPA-GMN-DRCD        =   SPA-GMN-DRCDL (IDX)
      *            MOVE    SPA-GMN-DRCDLST (IDX)
      *                                    TO  SPA-GMN-DRCD-G
      *            MOVE    1               TO  FLG-CHK
      *            MOVE    SPA-DRCD-MAX    TO  IDX
      *        END-IF
      *****END-PERFORM
      *
      *    ドクター編集
           INITIALIZE                  ORCSDRSETAREA
           MOVE    "2"                 TO  ORCSDR-KBN
           MOVE    SPA-SRYYMD          TO  ORCSDR-SYSYMD
           MOVE    SPA-SRYKA           TO  ORCSDR-SRYKA
           MOVE    SPA-GMN-DRCD-G      TO  ORCSDR-IN-DRCD-G
           MOVE    SPA-DRCD-MAX        TO  ORCSDR-DRCD-MAX
           MOVE    SPA-GMN-DRCDLST-G   TO  ORCSDR-DRCD-TBL-G
           CALL   "ORCSDRSET"          USING
                                       SPA-AREA
                                       ORCSDRSETAREA
           MOVE    ORCSDR-DRCD-TBL-G   TO  SPA-GMN-DRCDLST-G
           MOVE    ORCSDR-IN-DRCD-G    TO  SPA-GMN-DRCD-G
           MOVE    ORCSDR-DRCD-MAX     TO  SPA-DRCD-MAX
           IF      ORCSDR-ERRCD        =   ZERO
               MOVE    1                   TO  FLG-CHK
           ELSE
               MOVE    ZERO                TO  FLG-CHK
           END-IF
      *
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
           ELSE
      *        診療行為が無かった時、終了とする
               IF      IDX-KOUI         =   ZERO
                   PERFORM 4909-NASI-SYORI-SEC
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
       4909-NASI-SYORI-SEC             SECTION.
      *
      *    初診料算定がある時は、算定履歴と診療科履歴を作成する
           IF      SPA-SYOSIN-YMD  NOT =   SPACE
      *        外来更新処理
               INITIALIZE                  ORCSCGAIRAIAREA
      *        初診算定日登録
               MOVE    "3"                 TO  ORCSCGAIRAI-KBN
               CALL    "ORCSCGAIRAI"       USING
                                            SPA-AREA
                                           ORCSCGAIRAIAREA
      *
           END-IF
      *
           PERFORM 4900-END-SYORI-SEC
      *
           .
       4909-NASI-SYORI-EXT.
           EXIT.
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
      *    排他制御解除処理
           PERFORM 990-LOCK-OUT-SEC
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
      *    複数診療科継続処理
      *****************************************************************
       460-FUKU-KEIZOKU-SEC             SECTION.
      *
      *    請求書発行なし
           IF      SPA-GMN-HAKFLG  NOT =   "1"
               MOVE    "0024"              TO  SPA-ERRCD
               MOVE    07                  TO  SPA-GMN-CUR
               GO      TO      460-FUKU-KEIZOKU-EXT
           END-IF
           MOVE    ZERO                TO  FLG-FUKU-FLG
      *    一般保険で、主保険単独の時のみ
           IF      SPA-HKNKBN          =   ZERO
               IF     (SPA-HKNNUM      NOT =   SPACE )  AND
                      (SPA-KOH1HKNNUM      =   SPACE )  AND
                      (SPA-KOH2HKNNUM      =   SPACE )  AND
                      (SPA-KOH3HKNNUM      =   SPACE )  AND
                      (SPA-KOH4HKNNUM      =   SPACE )
                   MOVE    1               TO  FLG-FUKU-FLG
               END-IF
               IF     (SPA-HKNNUM      NOT =   SPACE )  AND
                      (SPA-KOH1HKNNUM      =   "027" )  AND
                      (SPA-KOH2HKNNUM      =   SPACE )  AND
                      (SPA-KOH3HKNNUM      =   SPACE )  AND
                      (SPA-KOH4HKNNUM      =   SPACE )
                   MOVE    1               TO  FLG-FUKU-FLG
               END-IF
           END-IF
      *    保険継続分
           IF      SPA-CONTKBN         =   "1"  OR  "2"
               MOVE    ZERO            TO  FLG-FUKU-FLG
           END-IF
      *    複数科まとめ有無
           IF      FLG-FUKU-FLG        =   ZERO
               MOVE    "0020"              TO  SPA-ERRCD
               MOVE    07                  TO  SPA-GMN-CUR
               GO      TO      460-FUKU-KEIZOKU-EXT
           END-IF
      *    訂正の時
           IF      SPA-SYORIFLG        =   1
               IF      SPA-FUKU-MATKBN     =   "2"
                   MOVE    "0021"              TO  SPA-ERRCD
                   MOVE    07                  TO  SPA-GMN-CUR
                   GO      TO      460-FUKU-KEIZOKU-EXT
               END-IF
           END-IF
      *    複数科まとめ中
           IF      SPA-FUKU-SYORI      =   "1"
               MOVE    "0025"              TO  SPA-ERRCD
               MOVE    07                  TO  SPA-GMN-CUR
               GO      TO      460-FUKU-KEIZOKU-EXT
           END-IF
      *
           MOVE    1                   TO  SPA-GMN-SYORI
      *    確定　処理
           PERFORM 450-TOROKU-SEC
           .
       460-FUKU-KEIZOKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    複数診療科確定処理
      *****************************************************************
       460-FUKU-KAKUATEI-SEC             SECTION.
      *
      *    請求書発行なし
           IF      SPA-GMN-HAKFLG  NOT =   "1"
               MOVE    "0024"              TO  SPA-ERRCD
               MOVE    07                  TO  SPA-GMN-CUR
               GO      TO      460-FUKU-KAKUATEI-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-FUKU-FLG
      *    一般保険で、主保険単独の時のみ
           IF      SPA-HKNKBN          =   ZERO
               IF     (SPA-HKNNUM      NOT =   SPACE )  AND
                      (SPA-KOH1HKNNUM      =   SPACE )  AND
                      (SPA-KOH2HKNNUM      =   SPACE )  AND
                      (SPA-KOH3HKNNUM      =   SPACE )  AND
                      (SPA-KOH4HKNNUM      =   SPACE )
                   MOVE    1               TO  FLG-FUKU-FLG
               END-IF
               IF     (SPA-HKNNUM      NOT =   SPACE )  AND
                      (SPA-KOH1HKNNUM      =   "027" )  AND
                      (SPA-KOH2HKNNUM      =   SPACE )  AND
                      (SPA-KOH3HKNNUM      =   SPACE )  AND
                      (SPA-KOH4HKNNUM      =   SPACE )
                   MOVE    1               TO  FLG-FUKU-FLG
               END-IF
           END-IF
      *    保険継続分
           IF      SPA-CONTKBN         =   "1"  OR  "2"
               MOVE    ZERO            TO  FLG-FUKU-FLG
           END-IF
      *    複数科まとめ有無
           IF      FLG-FUKU-FLG        =   ZERO
               MOVE    "0020"              TO  SPA-ERRCD
               MOVE    07                  TO  SPA-GMN-CUR
               GO      TO      460-FUKU-KAKUATEI-EXT
           END-IF
      *    複数科継続なし
           IF      SPA-FUKU-MATKBN     =   SPACE
               MOVE    "0022"              TO  SPA-ERRCD
               MOVE    07                  TO  SPA-GMN-CUR
               GO      TO      460-FUKU-KAKUATEI-EXT
           END-IF
      *    複数科まとめ中
           IF      SPA-FUKU-SYORI      =   "1"
               MOVE    "0025"              TO  SPA-ERRCD
               MOVE    07                  TO  SPA-GMN-CUR
               GO      TO      460-FUKU-KAKUATEI-EXT
           END-IF
      *
      *    訂正の時
           IF      SPA-SYORIFLG        =   1
               MOVE    ZERO            TO  FLG-OK
      *        継続中で１件の時
               IF     (SPA-FUKU-MATKBN     =   "1" )  AND
                      (SPA-FUKU-CNT        =   1   )
                   MOVE    1               TO  FLG-OK
               END-IF
      *        継続中で複数件の時、基準でないこと
               IF     (SPA-FUKU-MATKBN     =   "1" )  AND
                      (SPA-FUKU-CNT        >   1   )  AND
                      (SPA-FUKU-DENPNUM    NOT =   SPA-DENPNUM)
                   MOVE    1               TO  FLG-OK
               END-IF
               IF      FLG-OK              =   ZERO
                   MOVE    "0023"              TO  SPA-ERRCD
                   MOVE    07                  TO  SPA-GMN-CUR
                   GO      TO      460-FUKU-KAKUATEI-EXT
               END-IF
           END-IF
      *
           MOVE    2                   TO  SPA-GMN-SYORI
      *    確定　処理
           PERFORM 450-TOROKU-SEC
           .
       460-FUKU-KAKUATEI-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    診療行為なしの終了処理
      *****************************************************************
       4900-END-SYORI-SEC          SECTION.
      *
           MOVE    "CHANGE"            TO  WRK-MCP-PUTTYPE
      *
      *    排他制御解除処理
           PERFORM 990-LOCK-OUT-SEC
      *
      *    共通のキーをクリアする
           MOVE    SPACE               TO  SPA-ERRMSG
           INITIALIZE                      SPA-KYOTUKEY
           INITIALIZE                      SPA-K01KYOUTU
           MOVE    SPA-K01KYOUTU       TO  SPA-WORK
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "K02"               TO  SPA-SAKIPG
           MOVE    "K03"               TO  SPA-MOTOPG
      *
           MOVE    WRK-MCP-PUTTYPE     TO  MCP-PUTTYPE
           MOVE    "K02"               TO  MCP-WINDOW
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       4900-END-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録・更新処理
      *****************************************************************
       45001-TOROKU-KOUSIN-SEC          SECTION.
      *
      *    外来更新処理
           INITIALIZE                  ORCSCGAIRAIAREA
      *    登録・更新
           MOVE    "1"                 TO  ORCSCGAIRAI-KBN
      *    調整金
           MOVE    SPA-GMN-CHOSEI      TO  ORCSCGAIRAI-CHOSEI
      *    請求書作成区分
           MOVE    SPA-GMN-HAKFLG      TO  ORCSCGAIRAI-HAKFLG
      *    今回請求額
           MOVE    SPA-KON-SKYMONEY    TO  ORCSCGAIRAI-KON-SKYMONEY
      *    入金額
           MOVE    SPA-GMN-NYUKIN      TO  ORCSCGAIRAI-NYUKIN
      *    複数科まとめ
           MOVE    SPA-GMN-SYORI       TO  ORCSCGAIRAI-SYORI
           CALL    "ORCSCGAIRAI"       USING
                                       SPA-AREA
                                       ORCSCGAIRAIAREA
           IF      SPA-ERRCD       NOT =   SPACE
               GO  TO      45001-TOROKU-KOUSIN-EXT
           END-IF
      *
      *    伝票番号を編集する
           MOVE    ORCSCGAIRAI-DENPNUM TO  WRK-DENPNUM
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
      *    訂正時、受診履歴等の削除処理
      *****************************************************************
       450012-TEISEI-DELETE-SEC          SECTION.
      *
      *    外来更新処理
           INITIALIZE                  ORCSCGAIRAIAREA
      *    削除
           MOVE    "2"                 TO  ORCSCGAIRAI-KBN
           CALL    "ORCSCGAIRAI"       USING
                                       SPA-AREA
                                       ORCSCGAIRAIAREA
      *
           .
       450012-TEISEI-DELETE-EXT.
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
           IF      SPA-GMN-SYORI       =   ZERO
               IF      SPA-GMN-HAKFLG      =   "1"
                   CALL    WRK-SEIKYU-PG       USING   SPA-AREA
                                                   ORCHC03AREA
               END-IF
           END-IF
      *    複数科まとめ請求書印刷
           IF     (SPA-GMN-HAKFLG      =   "1"  )  AND
                  (SPA-FUKU-DENPNUM    >   ZERO )  AND
                  (SPA-GMN-SYORI       =   2    )
               INITIALIZE                      ORCHC03AREA
               MOVE    WRK-DENPNUM         TO  ORCHC03-DENPNUM
               MOVE    SPA-GMN-SEIKYU      TO  ORCHC03-SEIKYU
               MOVE    SPA-GMN-NYUKIN      TO  ORCHC03-NYUKIN
               MOVE    SPA-FUKU-DENPNUM    TO  ORCHC03-FUKU-DENPNUM
      *        訂正・継続中の時
               IF     (SPA-SYORIFLG        =   1    )  AND
                      (SPA-FUKU-MATKBN     =   "1"  )
                   COMPUTE SPA-MAT-SKYMONEY    =   SPA-MAT-SKYMONEY
                                               +   SPA-KON-SKYMONEY
               END-IF
      *
      *        まとめ請求額＋調整金
               IF      SPA-GMN-CHOSEI      =   ZERO
                   MOVE    ZERO                TO  WRK-SAGAKU
               ELSE
                   COMPUTE WRK-SAGAKU          =   SPA-GMN-CHOSEI
                                               -   SPA-GMN-FUKUSAGAKU
               END-IF
               COMPUTE WRK-SKYMONEY        =   SPA-MAT-SKYMONEY
                                           +   WRK-SAGAKU
               MOVE    WRK-SAGAKU          TO  ORCHC03-KON-CHOSEI
               MOVE    WRK-SKYMONEY        TO  ORCHC03-KON-SEIKYU
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
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "1"                 TO  ORCSPRTNM-KBN
           MOVE    "00000003"          TO  ORCSPRTNM-KBNCD
           MOVE    SPA-SRYYMD          TO  ORCSPRTNM-SRYYMD
           CALL    "ORCSPRTNM"         USING
                                           ORCSPRTNMAREA
                                           SPA-AREA
                                           SYS-1032-REC
           IF      ORCSPRTNM-RC    NOT =   ZERO
               MOVE    "1031"              TO  SPA-ERRCD
               GO      TO      4901-PRINT-PG-EXT
           END-IF
           MOVE    ORCSPRTNM-PRTPG     TO  WRK-SEIKYU-PG
      *
      *    処方せん
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "1"                 TO  ORCSPRTNM-KBN
           MOVE    "00000002"          TO  ORCSPRTNM-KBNCD
           MOVE    SPA-SRYYMD          TO  ORCSPRTNM-SRYYMD
           CALL    "ORCSPRTNM"         USING
                                           ORCSPRTNMAREA
                                           SPA-AREA
                                           SYS-1032-REC
           IF      ORCSPRTNM-RC    NOT =   ZERO
               MOVE    "1030"              TO  SPA-ERRCD
               GO      TO      4901-PRINT-PG-EXT
           END-IF
           MOVE    ORCSPRTNM-PRTPG     TO  WRK-SYOHOU-PG
      *
      **** 請求書
      *    MOVE    SPACE               TO  WRK-SEIKYU-PG
      *    MOVE    SPACE               TO  SYS-1032-REC
      *    INITIALIZE                      SYS-1032-REC
      *    MOVE    "1032"              TO  SYS-1032-KANRICD
      *    MOVE    "00000003"          TO  SYS-1032-KBNCD
      *
      *    MOVE    SYS-1032-REC        TO  MCPDATA-REC
      *    MOVE    "DBSELECT"          TO  MCP-FUNC
      *    MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
      *    MOVE    SPA-SRYYMD          TO  ORC-DBYMD
      *    CALL    "ORCMCPSUB"          USING
      *                                 MCPAREA
      *                                 ORCMCPAREA
      *                                 MCPDATA-REC
      *    IF      MCP-RC              =   ZERO
      *        MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
      *        PERFORM 960-KANRIMST-READ-SEC
      *    ELSE
      *        INITIALIZE                  SYS-1010-REC
      *        MOVE    1               TO  FLG-SYSKANRI
      *    END-IF
      *    IF      FLG-SYSKANRI        =   ZERO
      *        MOVE    MCPDATA-REC         TO  SYS-1032-REC
      *        独自開発分
      *        IF      SYS-1032-ORCACSTCHK     =   "T"
      *            MOVE    SYS-1032-ORCACSTNM  TO  WRK-SEIKYU-PG
      *        ELSE
      *        ＯＲＣＡ標準分
      *            MOVE    SYS-1032-ORCAORGNM  TO  WRK-SEIKYU-PG
      *        END-IF
      *    END-IF
      *    IF      WRK-SEIKYU-PG       =   SPACE
      *        MOVE    "ORCHC03"           TO  WRK-SEIKYU-PG
      *    END-IF
      *
      *    処方せん
      *    MOVE    SPACE               TO  WRK-SYOHOU-PG
      *    MOVE    SPACE               TO  SYS-1032-REC
      *    INITIALIZE                      SYS-1032-REC
      *    MOVE    "1032"              TO  SYS-1032-KANRICD
      *    MOVE    "00000002"          TO  SYS-1032-KBNCD
      *
      *    MOVE    SYS-1032-REC        TO  MCPDATA-REC
      *    MOVE    "DBSELECT"          TO  MCP-FUNC
      *    MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
      *    MOVE    SPA-SRYYMD          TO  ORC-DBYMD
      *    CALL    "ORCMCPSUB"          USING
      *                                 MCPAREA
      *                                 ORCMCPAREA
      *                                 MCPDATA-REC
      *    IF      MCP-RC              =   ZERO
      *        MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
      *        PERFORM 960-KANRIMST-READ-SEC
      *    ELSE
      *        INITIALIZE                  SYS-1010-REC
      *        MOVE    1               TO  FLG-SYSKANRI
      *    END-IF
      *    IF      FLG-SYSKANRI        =   ZERO
      *        MOVE    MCPDATA-REC         TO  SYS-1032-REC
      *        独自開発分
      *        IF      SYS-1032-ORCACSTCHK     =   "T"
      *            MOVE    SYS-1032-ORCACSTNM  TO  WRK-SYOHOU-PG
      *        ELSE
      *        ＯＲＣＡ標準分
      *            MOVE    SYS-1032-ORCAORGNM  TO  WRK-SYOHOU-PG
      *        END-IF
      *    END-IF
      *    IF      WRK-SYOHOU-PG       =   SPACE
      *        MOVE    "ORCHC19"           TO  WRK-SYOHOU-PG
      *****END-IF
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
      ***  MOVE    "1"                 TO  SHELLTBL-ARG1
           MOVE    SPA-GMN-SCODE       TO  SHELLTBL-ARG1
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
               WHEN    "0020"
                   MOVE    "複数科まとめのできない保険です。"
                                       TO  SPA-ERRMSG
                   MOVE    "登録を押下して下さい。"
                                       TO  SPA-ERRMSG(33:)
               WHEN    "0021"
                   MOVE    "既に複数科まとめの確定済です。"
                                       TO  SPA-ERRMSG
                   MOVE    "登録を押下して下さい。"
                                       TO  SPA-ERRMSG(31:)
               WHEN    "0022"
                   MOVE    "複数科まとめの継続がありません。"
                                       TO  SPA-ERRMSG
                   MOVE    "登録を押下して下さい。"
                                       TO  SPA-ERRMSG(33:)
               WHEN    "0023"
                   MOVE    "複数科まとめ確定へ変更できません。"
                                       TO  SPA-ERRMSG
                   MOVE    "登録を押下して下さい。"
                                       TO  SPA-ERRMSG(35:)
               WHEN    "0024"
                   MOVE    "複数科まとめは請求書発行ありの時"
                                       TO  SPA-ERRMSG
                   MOVE    "選択して下さい。"
                                       TO  SPA-ERRMSG(33:)
               WHEN    "0025"
                   MOVE    "複数科まとめ継続中の科です。"
                                       TO  SPA-ERRMSG
                   MOVE    "複数科選択はできません。"
                                       TO  SPA-ERRMSG(33:)
               WHEN    "1030"
                   MOVE    "処方せんプログラムがありません。"
                                       TO  SPA-ERRMSG
                   MOVE    "システム管理を確認して下さい。"
                                       TO  SPA-ERRMSG(33:)
               WHEN    "1031"
                   MOVE    "請求書プログラムがありません。"
                                       TO  SPA-ERRMSG
                   MOVE    "システム管理を確認して下さい。"
                                       TO  SPA-ERRMSG(31:)
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
      *    排他制御解除処理
      *****************************************************************
       990-LOCK-OUT-SEC         SECTION.
      *
      *    排他制御解除処理
           MOVE    2                   TO  SLOCK-MODE
           CALL    "ORCSLOCK"          USING
                                       MCPAREA
                                       SPA-AREA
                                       ORCSLOCKAREA
           .
       990-LOCK-OUT-EXT.
           EXIT.
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
