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
       IDENTIFICATION                            DIVISION.
       PROGRAM-ID.                               ORCGZ03.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 点数マスタ設定
      *  コンポーネント名  : 点数マスタ診療行為設定画面（Ｚ０３）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-多々納   01/07/03  日付入力チェックサブ追加
      *  01.00.02    MCC-多々納   01/07/04  老人一般コード振替追加
      *                                         （Ｚ９０）
      *  01.01.01    MCC-藤原     01/09/26  JOINの修正      
      *  01.01.02    MCC-藤原     01/10/29  採血料区分の修正      
      *  01.01.03    MCC-多々納   02/03/17  施設基準不適合の追加  
      *  01.01.04    MCC-多々納   02/07/18  服用方法画面追加
      *  01.01.05    NACL-多々納  02/10/09  診療種別の最大数を１００へ
      *                                     半角空白→全角空白追加
      *****************************************************************
      *
       ENVIRONMENT                               DIVISION.
       CONFIGURATION                             SECTION.
       INPUT-OUTPUT                              SECTION.
       FILE-CONTROL.
      *
      *
       DATA                                      DIVISION.
      *FILE                                      SECTION.
      *
       WORKING-STORAGE                           SECTION.
      *
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    点数マスタ設定用共通パラメタ
           COPY    "Z01COMMON-SPA".
      *
      *
      *    第一画面ＳＰＡエリア
           COPY    "Z01SCR-SPA".
      *
      *    ＳＰＡエリア
           COPY    "Z03SCR-SPA".
      *
      *
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                           PIC 9(01).
           03  FLG-SRYCDCHG        PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-TENSUPLUS       PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR                           PIC 9(06).
           03  CNT-PAGE                          PIC 9(02).
           03  CNT-ERRCHK                        PIC 9(03).
           03  CNT-STRING                        PIC 9(03).
      *
           03  CNT-CHK                           PIC 9(04).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                               PIC 9(04).
           03  IDX-1                             PIC 9(04).
           03  IDX-2                             PIC 9(04).
           03  IDXX                              PIC 9(04).
           03  IDXY                              PIC 9(02).
      *
      *    ワーク領域
       01  WRK-AREA.
           03  WRK-GMN-CUR                       PIC X(30).
           03  WRK-ZIDMSG                        PIC X(70).
           03  WRK-SNUM-INX                      PIC X(26).
           03  WRK-STRINGTBL.
               05  WRK-STRING                    PIC X(01)  OCCURS 200.
           03  WRK-LNKYMD                        PIC X(10).
           03  WRK-WYMD.
               05  WRK-WGO                       PIC X(01).
               05  WRK-WYY                       PIC 9(02).
               05  WRK-WMM                       PIC 9(02).
               05  WRK-WDD                       PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *
           03  WRK-SRYKBN              PIC X(03).
      *
           03  WRK-AGEKSNKGN           PIC X(02).
           03  WRK-AGEKSNJGN           PIC X(02).
      *
           03  WRK-YMD             PIC X(08).
           03  WRK-OTYMD           PIC X(08).
      *
           03  WRK-MAE-INPUT       PIC X(400).
           03  WRK-OUT-INPUT       PIC X(400).
      *
      *    診療種別名テーブル
           COPY    "CPORCSSRYSYU.INC".
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
      *  画面の項目順テーブル
       01  TBL-GMN-JUN.
      *    有効開始年月日
           03  FILLER          PIC X(30)  VALUE   "YUKOSTYMD".
      *    有効終了年月日
           03  FILLER          PIC X(30)  VALUE   "YUKOEDYMD".
      *    診療区分
           03  FILLER          PIC X(30)  VALUE   "SRYKBN".
      *    診療種別
           03  FILLER          PIC X(30)  VALUE   "SRYSYUKBN".
      *    データ区分
           03  FILLER          PIC X(30)  VALUE   "DATAKBN".
      *    カナ氏名チェック
           03  FILLER          PIC X(30)  VALUE   "KANANAME".
      *    氏名チェック
           03  FILLER          PIC X(30)  VALUE   "NAME".
      *    正式名称
           03  FILLER          PIC X(30)  VALUE   "FORMALNAME".
      *    点数
           03  FILLER          PIC X(30)  VALUE   "TEN".
           03  FILLER          PIC X(30)  VALUE   "TENSIKIBETU".
           03  FILLER          PIC X(30)  VALUE   "OLDTEN".
           03  FILLER          PIC X(30)  VALUE   "OLDTENSKB".
           03  FILLER          PIC X(30)  VALUE   "TANICD".
     ******03  FILLER          PIC X(30)  VALUE   "TANINAME".
           03  FILLER          PIC X(30)  VALUE   "HKNTEKKBN".
           03  FILLER          PIC X(30)  VALUE   "BYOKANRENKBN".
           03  FILLER          PIC X(30)  VALUE   "SDOKNRYO".
           03  FILLER          PIC X(30)  VALUE   "YKZKNRKBN".
           03  FILLER          PIC X(30)  VALUE   "NYUGAITEKKBN".
           03  FILLER          PIC X(30)  VALUE   "ROUTEKKBN".
           03  FILLER          PIC X(30)  VALUE   "HOSPSRYKBN".
           03  FILLER          PIC X(30)  VALUE   "OSINKBN".
           03  FILLER          PIC X(30)  VALUE   "BYOSYOKBN".
           03  FILLER          PIC X(30)  VALUE   "SANTEIRRKKBN".
           03  FILLER          PIC X(30)  VALUE   "TIMEKSNKBN".
           03  FILLER          PIC X(30)  VALUE   "GAIKANRIKBN".
           03  FILLER          PIC X(30)  VALUE   "TSUSOKUAGE".
           03  FILLER          PIC X(30)  VALUE   "KGNAGE".
           03  FILLER          PIC X(30)  VALUE   "JGNAGE".
      *    入力チェック区分
           03  FILLER          PIC X(30)  VALUE   "SAIKETUKBN".
           03  FILLER          PIC X(30)  VALUE   "INPCHKKBN".
      *    回数、年齢
           03  FILLER          PIC X(30)  VALUE   "JITUDAY".
           03  FILLER          PIC X(30)  VALUE   "DAYCNT".
           03  FILLER          PIC X(30)  VALUE   "JGNCNT".
           03  FILLER          PIC X(30)  VALUE   "JGNCNT1D".
           03  FILLER          PIC X(30)  VALUE   "JGNCNT1W".
           03  FILLER          PIC X(30)  VALUE   "JGNCNTETCM".
           03  FILLER          PIC X(30)  VALUE   "JGNCNTETC".
           03  FILLER          PIC X(30)  VALUE   "JGNCNTERR".
           03  FILLER          PIC X(30)  VALUE   "KZMCOMPSIKIBETU".
           03  FILLER          PIC X(30)  VALUE   "KZMKGN".
           03  FILLER          PIC X(30)  VALUE   "KZMJGN".
           03  FILLER          PIC X(30)  VALUE   "KZM".
           03  FILLER          PIC X(30)  VALUE   "KZMTEN".
           03  FILLER          PIC X(30)  VALUE   "KZMERR".
           03  FILLER          PIC X(30)  VALUE   "CHUKSNCD".
           03  FILLER          PIC X(30)  VALUE   "CHUKSNTSUBAN".
      *        年齢加算
           03  FILLER          PIC X(30)  VALUE   "AGEKSNKGN1".
           03  FILLER          PIC X(30)  VALUE   "AGEKSNJGN1".
           03  FILLER          PIC X(30)  VALUE   "AGEKSNSRYCD1".
           03  FILLER          PIC X(30)  VALUE   "AGEKSNKGN2".
           03  FILLER          PIC X(30)  VALUE   "AGEKSNJGN2".
           03  FILLER          PIC X(30)  VALUE   "AGEKSNSRYCD2".
           03  FILLER          PIC X(30)  VALUE   "AGEKSNKGN3".
           03  FILLER          PIC X(30)  VALUE   "AGEKSNJGN3".
           03  FILLER          PIC X(30)  VALUE   "AGEKSNSRYCD3".
           03  FILLER          PIC X(30)  VALUE   "AGEKSNKGN4".
           03  FILLER          PIC X(30)  VALUE   "AGEKSNJGN4".
           03  FILLER          PIC X(30)  VALUE   "AGEKSNSRYCD4".
      *    手術、検査、入院
           03  FILLER          PIC X(30)  VALUE   "TUSOKUGAIKBN".
           03  FILLER          PIC X(30)  VALUE   "LASERKSN".
           03  FILLER          PIC X(30)  VALUE   "CHPMESUKSN".
           03  FILLER          PIC X(30)  VALUE   "MICMESUKSN".
           03  FILLER          PIC X(30)  VALUE   "SEKIZUISOKUTEI".
           03  FILLER          PIC X(30)  VALUE   "KEIBUJYUTU".
           03  FILLER          PIC X(30)  VALUE   "AUTOHOUGO".
           03  FILLER          PIC X(30)  VALUE   "AUTOFUNGO".
           03  FILLER          PIC X(30)  VALUE   "CHPGYOKOSOTIKSN".
           03  FILLER          PIC X(30)  VALUE   "SHORTSTAYOPE".
      *    施設基準不適合区分
           03  FILLER          PIC X(30)  VALUE   "KIJUNTEIGENKBN".
      *     基準不適合逓減対象施設基準コード
           03  FILLER          PIC X(30)  VALUE   "KIJUNTEIGENCD".
           03  FILLER          PIC X(30)  VALUE   "KNSJISKBN".
           03  FILLER          PIC X(30)  VALUE   "KNSJISGRPKBN".
           03  FILLER          PIC X(30)  VALUE   "KENTAICOMMENT".
           03  FILLER          PIC X(30)  VALUE   "TEIGENKBN".
           03  FILLER          PIC X(30)  VALUE   "HOKATUTEIGENKBN".
           03  FILLER          PIC X(30)  VALUE   "HOUKNSKBN".
           03  FILLER          PIC X(30)  VALUE   "CHPNAISIKSN".
           03  FILLER          PIC X(30)  VALUE   "NYUKHNKBN".
           03  FILLER          PIC X(30)  VALUE   "NYUKHNKSNKBN".
           03  FILLER          PIC X(30)  VALUE   "KANGOKSN".
           03  FILLER          PIC X(30)  VALUE   "CHIIKIKSN".
           03  FILLER          PIC X(30)  VALUE   "SSTKIJUNCD1".
           03  FILLER          PIC X(30)  VALUE   "SSTKIJUNCD2".
           03  FILLER          PIC X(30)  VALUE   "SSTKIJUNCD3".
           03  FILLER          PIC X(30)  VALUE   "SSTKIJUNCD4".
           03  FILLER          PIC X(30)  VALUE   "SSTKIJUNCD5".
           03  FILLER          PIC X(30)  VALUE   "SSTKIJUNCD6".
           03  FILLER          PIC X(30)  VALUE   "SSTKIJUNCD7".
           03  FILLER          PIC X(30)  VALUE   "SSTKIJUNCD8".
           03  FILLER          PIC X(30)  VALUE   "SSTKIJUNCD9".
           03  FILLER          PIC X(30)  VALUE   "SSTKIJUNCD10".
           03  FILLER          PIC X(30)  VALUE   "GAITENTTLKBN".
           03  FILLER          PIC X(30)  VALUE   "NYUTENTTLSKB".
           03  FILLER          PIC X(30)  VALUE   "KOUHYOJYUNNUM".
           03  FILLER          PIC X(30)  VALUE   "CDKBN_KBN".
           03  FILLER          PIC X(30)  VALUE   "CDKBN_SYO".
           03  FILLER          PIC X(30)  VALUE   "CDKBN_BU".
           03  FILLER          PIC X(30)  VALUE   "CDKBN_KBNNUM".
           03  FILLER          PIC X(30)  VALUE   "CDKBN_KBNNUM_EDA".
           03  FILLER          PIC X(30)  VALUE   "CDKBN_KOUBAN".
           03  FILLER          PIC X(30)  VALUE   "KOKUCHI_KBN".
           03  FILLER          PIC X(30)  VALUE   "KOKUCHI_SYO".
           03  FILLER          PIC X(30)  VALUE   "KOKUCHI_BU".
           03  FILLER          PIC X(30)  VALUE   "KOKUCHI_KBNNUM".
           03  FILLER          PIC X(30)  VALUE   "KOKUCHI_KBNNUM_EDA".
           03  FILLER          PIC X(30)  VALUE   "KOKUCHI_KOUBAN".
           03  FILLER          PIC X(30)  VALUE   "KOKUJISKBKBN1".
           03  FILLER          PIC X(30)  VALUE   "KOKUJISKBKBN2".
      *
       01  TBL-GMN-JUN-R       REDEFINES   TBL-GMN-JUN.
      *****03  TBL-GMN-OCC                 OCCURS  107
           03  TBL-GMN-OCC                 OCCURS  108
                                           INDEXED  IDX-GMN.
               05  TBL-WIDGET              PIC X(30).
      *
      *    単位の項目順テーブル
           COPY    "CMTANICD.INC".
      *
      *    指導管理コードテーブル
       01  TBL-SDOKNRYO-AREA.
           03  FILLER              PIC X(02)   VALUE   "00".
           03  FILLER              PIC X(50)   VALUE
               "指導管理加算以外".
           03  FILLER              PIC X(02)   VALUE   "01".
           03  FILLER              PIC X(50)   VALUE
               "特定疾患療養指導料".
           03  FILLER              PIC X(02)   VALUE   "02".
           03  FILLER              PIC X(50)   VALUE
               "ウイルス疾患指導料".
           03  FILLER              PIC X(02)   VALUE   "03".
           03  FILLER              PIC X(50)   VALUE
               "在宅自己注射指導管理料".
           03  FILLER              PIC X(02)   VALUE   "04".
           03  FILLER              PIC X(50)   VALUE
               "在宅自己腹膜灌流指導管理料".
           03  FILLER              PIC X(02)   VALUE   "05".
           03  FILLER              PIC X(50)   VALUE
               "特定薬剤治療管理料".
           03  FILLER              PIC X(02)   VALUE   "06".
           03  FILLER              PIC X(50)   VALUE
               "小児特定疾患カウンセリング料".
           03  FILLER              PIC X(02)   VALUE   "07".
           03  FILLER              PIC X(50)   VALUE
               "放射線治療管理料".
           03  FILLER              PIC X(02)   VALUE   "08".
           03  FILLER              PIC X(50)   VALUE
               "老人慢性疾患生活指導料".
           03  FILLER              PIC X(02)   VALUE   "09".
           03  FILLER              PIC X(50)   VALUE
               "退院時指導料".
           03  FILLER              PIC X(02)   VALUE   "10".
           03  FILLER              PIC X(50)   VALUE
               "寝たきり老人訪問看護・指導料".
           03  FILLER              PIC X(02)   VALUE   "11".
           03  FILLER              PIC X(50)   VALUE
               "投薬特別指導料".
           03  FILLER              PIC X(02)   VALUE   "12".
           03  FILLER              PIC X(50)   VALUE
               "在宅酸素療法指導管理料".
           03  FILLER              PIC X(02)   VALUE   "13".
           03  FILLER              PIC X(50)   VALUE
               "在宅中心静脈栄養法指導管理料".
           03  FILLER              PIC X(02)   VALUE   "14".
           03  FILLER              PIC X(50)   VALUE
               "皮膚科特定疾患指導管理料（１）".
           03  FILLER              PIC X(02)   VALUE   "15".
           03  FILLER              PIC X(50)   VALUE
               "歯科口腟衛生指導料".
           03  FILLER              PIC X(02)   VALUE   "16".
           03  FILLER              PIC X(50)   VALUE
               "有床義歯指導料（一般）".
           03  FILLER              PIC X(02)   VALUE   "17".
           03  FILLER              PIC X(50)   VALUE
               "歯槽膿漏指導管理料".
           03  FILLER              PIC X(02)   VALUE   "18".
           03  FILLER              PIC X(50)   VALUE
               "歯科口腟疾患指導料".
           03  FILLER              PIC X(02)   VALUE   "19".
           03  FILLER              PIC X(50)   VALUE
               "在宅自己腹膜灌流指導管理（集中的指導）".
           03  FILLER              PIC X(02)   VALUE   "20".
           03  FILLER              PIC X(50)   VALUE
               "在宅酸素療法指導管理（チアノーゼ型）".
           03  FILLER              PIC X(02)   VALUE   "21".
           03  FILLER              PIC X(50)   VALUE
               "寝たきり老人訪問指導管理料".
           03  FILLER              PIC X(02)   VALUE   "22".
           03  FILLER              PIC X(50)   VALUE
               "歯科矯正管理料".
           03  FILLER              PIC X(02)   VALUE   "23".
           03  FILLER              PIC X(50)   VALUE
               "有床義歯指導料（老人）".
           03  FILLER              PIC X(02)   VALUE   "24".
           03  FILLER              PIC X(50)   VALUE
               "在宅成分栄養管理栄養法指導管理料".
           03  FILLER              PIC X(02)   VALUE   "25".
           03  FILLER              PIC X(50)   VALUE
               "在宅自己導尿指導管理料".
           03  FILLER              PIC X(02)   VALUE   "26".
           03  FILLER              PIC X(50)   VALUE
               "痴呆患者在宅療養指導料".
           03  FILLER              PIC X(02)   VALUE   "27".
           03  FILLER              PIC X(50)   VALUE
               "寝たきり老人訪問リハビリテーション指導管理料".
           03  FILLER              PIC X(02)   VALUE   "28".
           03  FILLER              PIC X(50)   VALUE
               "悪性腫瘍特異物治療管理料".
           03  FILLER              PIC X(02)   VALUE   "29".
           03  FILLER              PIC X(50)   VALUE
               "心臓ペースメーカー指導管理料".
           03  FILLER              PIC X(02)   VALUE   "30".
           03  FILLER              PIC X(50)   VALUE
               "在宅悪性腫瘍患者指導管理料".
           03  FILLER              PIC X(02)   VALUE   "31".
           03  FILLER              PIC X(50)   VALUE
               "在宅人工呼吸指導管理料".
           03  FILLER              PIC X(02)   VALUE   "32".
           03  FILLER              PIC X(50)   VALUE
               "在宅寝たきり患者処置指導管理料".
           03  FILLER              PIC X(02)   VALUE   "33".
           03  FILLER              PIC X(50)   VALUE
               "寝たきり老人患者処置指導管理料".
           03  FILLER              PIC X(02)   VALUE   "34".
           03  FILLER              PIC X(50)   VALUE
               "小児科療養指導料".
           03  FILLER              PIC X(02)   VALUE   "35".
           03  FILLER              PIC X(50)   VALUE
               "皮膚科特定疾患指導管理料（２）".
           03  FILLER              PIC X(02)   VALUE   "36".
           03  FILLER              PIC X(50)   VALUE
               "てんかん指導料".
           03  FILLER              PIC X(02)   VALUE   "37".
           03  FILLER              PIC X(50)   VALUE
               "在宅自己疼痛管理指導管理料".
           03  FILLER              PIC X(02)   VALUE   "38".
           03  FILLER              PIC X(50)   VALUE
               "難病外来指導管理料".
           03  FILLER              PIC X(02)   VALUE   "39".
           03  FILLER              PIC X(50)   VALUE
               "在宅時医学管理料".
           03  FILLER              PIC X(02)   VALUE   "40".
           03  FILLER              PIC X(50)   VALUE
               "老人慢性疾患外来総合診療料".
           03  FILLER              PIC X(02)   VALUE   "41".
           03  FILLER              PIC X(50)   VALUE
               "皮膚科特定疾患指導管理料（３）".
           03  FILLER              PIC X(02)   VALUE   "42".
           03  FILLER              PIC X(50)   VALUE
               "在宅血液透析指導管理料".
           03  FILLER              PIC X(02)   VALUE   "43".
           03  FILLER              PIC X(50)   VALUE
               "在宅持続陽圧式呼吸療法指導管理料".
           03  FILLER              PIC X(02)   VALUE   "44".
           03  FILLER              PIC X(50)   VALUE
               "老人慢性疾患外来共同指導料".
      *
       01  TBL-SDOKNRYO-AREA-R     REDEFINES   TBL-SDOKNRYO-AREA.
           03  TBL-SDOKNRYO-OCC        OCCURS  45      INDEXED  SDO-IDX.
               05  TBL-SDOKNRYO        PIC X(02).
               05  TBL-SDOKNRYOMEI     PIC X(50).
       01  SDO-MAX                     PIC 9(04)   VALUE   45.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    点数マスタ
           COPY    "CPTENSU.INC".
      *    点数マスタ付加コード
        01 TENSUPLUS-REC.
           COPY    "CPTENSUPLUS.INC".
      *    入力コード
        01  INPUTCD-REC.
           COPY    "CPINPUTCD.INC".
      *    老人一般コード振替
        01  SRYCDCHG-REC.
            COPY    "CPSRYCDCHG.INC".
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *----(01.02.03) LINE ADD START ----------------------------------
      *   画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *----(01.02.03) LINE ADD END   ----------------------------------
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    ＤＢ検索
      *01  MCPDATA-REC                 PIC X(5000).
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "Z01.INC".
           COPY    "Z02.INC".
           COPY    "Z03.INC".
           COPY    "Z04.INC".
           COPY    "Z05.INC".
           COPY    "Z06.INC".
           COPY    "Z90.INC".
           COPY    "Z91.INC".
           COPY    "Z97.INC".
           COPY    "Z98.INC".
           COPY    "Z99.INC".
           COPY    "ZERR.INC".
           COPY    "ZID1.INC".
           COPY    "ZID2.INC".
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
       000-PROC-SEC                              SECTION.
      *
           MOVE    SPA-COMMON                    TO  SPA-AREA.
           MOVE    SPA-WORK                      TO  SPA-Z01KYOUTU
           MOVE    SPA-FREE                      TO  SPA-Z01FREE
           MOVE    SPA-Z01SONOTA                 TO  SPA-Z03
      *
           MOVE    SPACE                         TO  SPA-ERRCD.
           MOVE    ZERO                          TO  FLG-END.
      *
      *    診療種別テーブルセット
           PERFORM 1001-SRYKBN-SET-SEC
      *
           EVALUATE    MCP-STATUS       ALSO    MCP-EVENT
               WHEN    "LINK"           ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN    "PUTG"           ALSO   "CLICKED"
                   PERFORM 200-GMNSENI-SEC
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY-SEC
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END                       =   ZERO
               PERFORM 500-SET-SCREEN-SEC
           END-IF.
      *    
      *    
           MOVE    SPA-Z01KYOUTU                 TO  SPA-WORK
           MOVE    SPA-AREA                      TO  SPA-COMMON
           MOVE    SPA-Z03                       TO  SPA-Z01SONOTA 
           MOVE    SPA-Z01FREE                   TO  SPA-FREE
      *
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                              SECTION.
      *
           INITIALIZE                            FLG-AREA.
           INITIALIZE                            CNT-AREA.
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "ZERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF      FLG-END         =   1
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
      **     MOVE  SPA-GMN-CUR           TO  MCP-WIDGET
      *
           MOVE    SPACE                         TO  LINKAREA.
      *
      ***  MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    SPACE                TO  MCP-PUTTYPE
           MOVE    "Z03"                         TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                             TO  FLG-END.
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療種別テーブルセット処理
      *****************************************************************
       1001-SRYKBN-SET-SEC             SECTION.
      * 
      *    診療種別テーブルセット
           CALL    "ORCSSRYSYU"        USING
                                       MSYU-DATA-REC
      *
           .
       1001-SRYKBN-SET-EXT.
           EXIT.
      *
     *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           EVALUATE    SPA-MOTOPG
      *    更新処理
               WHEN    "ZID1"
                   PERFORM 330-ZID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
      *           入力ＣＤより
               WHEN    "Z99"
               WHEN    "Z90"
                   MOVE  "YUKOSTYMD"             TO  SPA-GMN-CUR
                   GO      TO      300-SCREEN-EXT
           END-EVALUATE
      *
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
       310-SPASET-SEC              SECTION.
      *    点数マスタ該当データ読み出し
           INITIALIZE                            SPA-GMN-AREA
      *
           MOVE  0                               TO  SPA-GMN-PAGENO
           MOVE  SPA-Z01-SRYCD                   TO  SPA-GMN-SRYCDH
      *
           MOVE  SPA-Z01-YUKOSTYMD               TO  SPA-NAI-YUKOSTYMD
           IF  SPA-Z01-SYORIKBN                  =  2
               MOVE  SPA-Z01-YUKOSTYMDH          TO  SPA-GMN-YUKOSTYMDH
           END-IF
           MOVE  SPA-Z01-YUKOSTYMDH              TO  SPA-GMN-YUKOSTYMD
      *
           MOVE  SPA-Z01-YUKOEDYMD               TO  SPA-NAI-YUKOEDYMD
           IF  SPA-Z01-SYORIKBN                  =  2
                MOVE  SPA-Z01-YUKOEDYMDH         TO  SPA-GMN-YUKOEDYMDH
           END-IF
           MOVE  SPA-Z01-YUKOEDYMDH              TO  SPA-GMN-YUKOEDYMD
      *
           INITIALIZE                            TNS-TENSU-REC
           MOVE  SPA-Z01-SRYCD                   TO  TNS-SRYCD
      *****IF    SPA-Z01-SYORIKBN                =   2
      *        MOVE  SPA-Z01-YUKOSTYMD           TO  TNS-YUKOSTYMD
      *        MOVE  SPA-Z01-YUKOEDYMD           TO  TNS-YUKOEDYMD
      *****ELSE
               IF  SPA-Z01-SELNUM                 =   ZERO
                   MOVE  ALL "9"                 TO  TNS-YUKOSTYMD
                   MOVE  ALL "9"                 TO  TNS-YUKOEDYMD
               ELSE
                   MOVE  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                 TO  TNS-YUKOSTYMD
                   MOVE  SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                 TO  TNS-YUKOEDYMD
               END-IF
      *****END-IF
           PERFORM  811-TENSUSEL-SEC
      *
           IF  MCP-RC                            =   ZERO
               PERFORM  812-TENSUFET-SEC
               IF  MCP-RC                        =   ZERO
                   MOVE    ZERO                 TO  FLG-TENSU
                   PERFORM 3001-SPASET-SEC
               ELSE
                   INITIALIZE                  TNS-TENSU-REC
                   MOVE    1                   TO  FLG-TENSU
               END-IF
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *    各リストボックス編集
           PERFORM 30012-COB-HEN-SEC
      *
           PERFORM  813-TENSUCLS-SEC
      *
      *    点数マスタ付加情報検索
           IF      FLG-TENSU           =   ZERO
               MOVE    SPACE               TO  TENSUPLUS-REC
               MOVE    TNS-SRYCD           TO  TNSP-SRYCD
               MOVE    TNS-YUKOSTYMD       TO  TNSP-YUKOSTYMD
               MOVE    TNS-YUKOEDYMD       TO  TNSP-YUKOEDYMD
      *
               MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC               =   ZERO
                   MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
                   PERFORM 990-TENSUPLUS-READ-SEC
               ELSE
                   INITIALIZE                 TENSUPLUS-REC
               END-IF
               MOVE    "DBCLOSE"           TO  MCP-FUNC
               MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           ELSE
               INITIALIZE                 TENSUPLUS-REC
           END-IF
      *
           PERFORM  3002-SPASET-TENSUPLUS-SEC
      *
      *
           MOVE  "YUKOSTYMD"             TO  SPA-GMN-CUR
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ情報をＳＰＡにセット
      *****************************************************************
       3001-SPASET-SEC                     SECTION.
      *
           MOVE  MCPDATA-REC               TO  TNS-TENSU-REC
           MOVE  TNS-NAME                  TO  SPA-GMN-NAMEH
      *
           MOVE  TNS-SRYKBN                TO  SPA-GMN-SRYKBN   
           MOVE  TNS-SRYSYUKBN             TO  SPA-GMN-SRYSYUKBN
           MOVE  TNS-DATAKBN               TO  SPA-GMN-DATAKBN  
           MOVE  TNS-KANANAME              TO  SPA-GMN-KANANAME
           MOVE  TNS-NAME                  TO  SPA-GMN-NAME
           MOVE  TNS-TEN                   TO  SPA-GMN-TEN
           MOVE  TNS-TENSIKIBETU           TO  SPA-GMN-TENSIKIBETU
           MOVE  TNS-OLDTEN                TO  SPA-GMN-OLDTEN
           MOVE  TNS-OLDTENSKB             TO  SPA-GMN-OLDTENSKB
           MOVE  TNS-TANICD                TO  SPA-GMN-TANICD
           MOVE  TNS-TANINAME              TO  SPA-GMN-TANINAME
           MOVE  TNS-HKNTEKKBN             TO  SPA-GMN-HKNTEKKBN   
           MOVE  TNS-BYOKANRENKBN          TO  SPA-GMN-BYOKANRENKBN
           MOVE  TNS-SDOKNRYO              TO  SPA-GMN-SDOKNRYO    
           MOVE  TNS-YKZKNRKBN             TO  SPA-GMN-YKZKNRKBN   
           MOVE  TNS-NYUGAITEKKBN          TO  SPA-GMN-NYUGAITEKKBN
           MOVE  TNS-ROUTEKKBN             TO  SPA-GMN-ROUTEKKBN   
           MOVE  TNS-HOSPSRYKBN            TO  SPA-GMN-HOSPSRYKBN  
           MOVE  TNS-OSINKBN               TO  SPA-GMN-OSINKBN     
           MOVE  TNS-BYOSYOKBN             TO  SPA-GMN-BYOSYOKBN   
           MOVE  TNS-SANTEIRRKKBN          TO  SPA-GMN-SANTEIRRKKBN
           MOVE  TNS-TIMEKSNKBN            TO  SPA-GMN-TIMEKSNKBN  
           MOVE  TNS-GAIKANRIKBN           TO  SPA-GMN-GAIKANRIKBN 
           MOVE  TNS-TSUSOKUAGE            TO  SPA-GMN-TSUSOKUAGE  
           MOVE  TNS-KGNAGE                TO  SPA-GMN-KGNAGE      
           MOVE  TNS-JGNAGE                TO  SPA-GMN-JGNAGE      
      *                                         
           MOVE  TNS-JITUDAY               TO  SPA-GMN-JITUDAY        
           MOVE  TNS-DAYCNT                TO  SPA-GMN-DAYCNT         
           MOVE  TNS-JGNCNT                TO  SPA-GMN-JGNCNT         
           MOVE  TNS-JGNCNT1D              TO  SPA-GMN-JGNCNT1D       
           MOVE  TNS-JGNCNT1W              TO  SPA-GMN-JGNCNT1W       
           MOVE  TNS-JGNCNTETCM            TO  SPA-GMN-JGNCNTETCM     
           MOVE  TNS-JGNCNTETC             TO  SPA-GMN-JGNCNTETC      
           MOVE  TNS-JGNCNTERR             TO  SPA-GMN-JGNCNTERR      
           MOVE  TNS-KZMCOMPSIKIBETU       TO  SPA-GMN-KZMCOMPSIKIBETU
           MOVE  TNS-KZMKGN                TO  SPA-GMN-KZMKGN         
           MOVE  TNS-KZMJGN                TO  SPA-GMN-KZMJGN         
           MOVE  TNS-KZM                   TO  SPA-GMN-KZM            
           MOVE  TNS-KZMTEN                TO  SPA-GMN-KZMTEN         
           MOVE  TNS-KZMERR                TO  SPA-GMN-KZMERR         
           MOVE  TNS-CHUKSNCD              TO  SPA-GMN-CHUKSNCD       
           MOVE  TNS-CHUKSNTUBAN           TO  SPA-GMN-CHUKSNTSUBAN   
           PERFORM  VARYING  IDXX
                    FROM  1  BY  1  UNTIL  IDXX  >  4
               MOVE  TNS-AGEKSNKGN(IDXX)   TO  SPA-GMN-AGEKSNKGN(IDXX)
               MOVE  TNS-AGEKSNJGN(IDXX)   TO  SPA-GMN-AGEKSNJGN(IDXX) 
               MOVE  TNS-AGEKSNSRYCD(IDXX) TO  SPA-GMN-AGEKSNSRYCD
                                                                (IDXX) 
           END-PERFORM
      *                                          
           MOVE  TNS-TUSOKUGAIKBN          TO  SPA-GMN-TUSOKUGAIKBN    
           MOVE  TNS-LASERKBN              TO  SPA-GMN-LASERKSN        
           MOVE  TNS-CHPMESUKSN            TO  SPA-GMN-CHPMESUKSN      
           MOVE  TNS-MICMESUKSN            TO  SPA-GMN-MICMESUKSN      
           MOVE  TNS-SEKIZUISOKUTEI        TO  SPA-GMN-SEKIZUISOKUTEI  
           MOVE  TNS-KEIBUJYUTU            TO  SPA-GMN-KEIBUJYUTU      
           MOVE  TNS-AUTOHOUGO             TO  SPA-GMN-AUTOHOUGO       
           MOVE  TNS-AUTOFUNGO             TO  SPA-GMN-AUTOFUNGO       
           MOVE  TNS-CHPGYOKOSOTIKSN       TO  SPA-GMN-CHPGYOKOSOTIKSN 
           MOVE  TNS-SHORTSTAYOPE          TO  SPA-GMN-SHORTSTAYOPE    
      *    施設基準不適合区分
           MOVE  TNS-KIJUNTEIGENKBN        TO  SPA-GMN-KIJUNTEIGENKBN
      *    基準不適合逓減対象施設基準コード
           MOVE  TNS-KIJUNTEIGENCD         TO  SPA-GMN-KIJUNTEIGENCD
           MOVE  TNS-KNSJISKBN             TO  SPA-GMN-KNSJISKBN       
           MOVE  TNS-KNSJISGRPKBN          TO  SPA-GMN-KNSJISGRPKBN    
           MOVE  TNS-KENTAICOMMENT         TO  SPA-GMN-KENTAICOMMENT   
           MOVE  TNS-TEIGENKBN             TO  SPA-GMN-TEIGENKBN       
           MOVE  TNS-HOUKATUTEIGENKBN      TO  SPA-GMN-HOKATUTEIGENKBN 
           MOVE  TNS-HOUKNSKBN             TO  SPA-GMN-HOUKNSKBN       
           MOVE  TNS-CHPNAISIKSN           TO  SPA-GMN-CHPNAISIKSN     
           MOVE  TNS-NYUKHNKBN             TO  SPA-GMN-NYUKHNKBN
           MOVE  TNS-NYUKHNKSNKBN          TO  SPA-GMN-NYUKHNKSNKBN
           MOVE  TNS-KANGOKSN              TO  SPA-GMN-KANGOKSN 
           MOVE  TNS-CHIIKIKSN             TO  SPA-GMN-CHIIKIKSN       
      *                                          
           PERFORM  VARYING  IDXX
                    FROM  1  BY  1  UNTIL  IDXX  >  10
               MOVE  TNS-SSTKIJUNCD(IDXX)  TO  SPA-GMN-SSTKIJUNCD(IDXX)
           END-PERFORM
           MOVE  TNS-GAITENTTLKBN          TO  SPA-GMN-GAITENTTLKBN    
           MOVE  TNS-NYUTENTTLKBN          TO  SPA-GMN-NYUTENTTLSKB   
           MOVE  TNS-KOUHYOJYUNNUM         TO  SPA-GMN-KOUHYOJYUNNUM   
           MOVE  TNS-CDKBN-KBN             TO  SPA-GMN-CDKBN-KBN       
           MOVE  TNS-CDKBN-SYO             TO  SPA-GMN-CDKBN-SYO       
           MOVE  TNS-CDKBN-BU              TO  SPA-GMN-CDKBN-BU        
           MOVE  TNS-CDKBN-KBNNUM          TO  SPA-GMN-CDKBN-KBNNUM    
           MOVE  TNS-CDKBN-KBNNUM-EDA      TO  SPA-GMN-CDKBN-KBNNUM-EDA
           MOVE  TNS-CDKBN-KOUBAN          TO  SPA-GMN-CDKBN-KOUBAN    
           MOVE  TNS-KOKUCHI-KBN           TO  SPA-GMN-KOKUCHI-KBN     
           MOVE  TNS-KOKUCHI-SYO           TO  SPA-GMN-KOKUCHI-SYO     
           MOVE  TNS-KOKUCHI-BU            TO  SPA-GMN-KOKUCHI-BU      
           MOVE  TNS-KOKUCHI-KBNNUM        TO  SPA-GMN-KOKUCHI-KBNNUM  
           MOVE  TNS-KOKUCHI-KBNNUM-EDA    TO
                                           SPA-GMN-KOKUCHI-KBNNUM-EDA
           MOVE  TNS-KOKUCHI-KOUBAN        TO  SPA-GMN-KOKUCHI-KOUBAN  
           MOVE  TNS-KOKUJISKBKBN1         TO  SPA-GMN-KOKUJISKBKBN1   
           MOVE  TNS-KOKUJISKBKBN2         TO  SPA-GMN-KOKUJISKBKBN2   
      *    正式名称
           MOVE  TNS-FORMALNAME            TO  SPA-GMN-FORMALNAME
      *    各リストボックス編集
      *****PERFORM 30012-COB-HEN-SEC
           .
      *
       3001-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ情報をＳＰＡにセット（点数マスタ付加情報）
      *****************************************************************
       3002-SPASET-TENSUPLUS-SEC       SECTION.
      *    入力チェック区分
           MOVE    TNSP-INPCHKKBN      TO  SPA-GMN-INPCHKKBN
      *    採血区分
           MOVE    TNSP-SAIKETUKBN     TO  SPA-GMN-SAIKETUKBN
      *    採血料区分一覧
           MOVE    "0:　　　　"        TO  SPA-GMN-SAIKETUCOMB (01)
      ***  MOVE    "1:抹消採血"        TO  SPA-GMN-SAIKETUCOMB (02)
           MOVE    "1:末梢採血"        TO  SPA-GMN-SAIKETUCOMB (02)
           MOVE    "2:静脈採血"        TO  SPA-GMN-SAIKETUCOMB (03)
           MOVE    "3:動脈採血"        TO  SPA-GMN-SAIKETUCOMB (04)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   4
               IF      SPA-GMN-SAIKETUKBN  =   SPA-GMN-SAIKETUCOMB
                                                            (IDX)(1:1)
                   MOVE    SPA-GMN-SAIKETUCOMB (IDX)
                                           TO  SPA-GMN-SAIKETUKBN-G
                   MOVE    4               TO  IDX
               END-IF
           END-PERFORM
           .
      *
       3002-SPASET-TENSUPLUS-EXT.
           EXIT.
      *
      *****************************************************************
      *   各リストボックス編集処理
      *****************************************************************
       30012-COB-HEN-SEC            SECTION.
      *
      *    診療区分・診療種別
           MOVE    1                   TO  IDX-1
           MOVE    1                   TO  IDX-2
           MOVE    SPACE               TO  SPA-GMN-SRYKBNCOB(IDX-1)
           MOVE    SPACE               TO  SPA-GMN-SRYSYUKBNCOB
                                                             (IDX-2)
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   100  )   OR
                              (MSYU-SRYKBN (IDX)   =   SPACE )
      *        診療区分
               IF      (IDX-1          =   1    )  OR
                       (SPA-GMN-SRYKBN-L(IDX-1)(1:2)
                                   NOT =   MSYU-SRYKBN (IDX))
                   ADD     1               TO  IDX-1
                   MOVE    MSYU-SRYKBN (IDX)
                                           TO  SPA-GMN-SRYKBN-L(IDX-1)
                   EVALUATE    MSYU-SRYKBN (IDX)
                       WHEN    "11"
                       WHEN    "12"
                           MOVE    "診察"      TO  SPA-GMN-SRYKBNME-L
                                                               (IDX-1)
                       WHEN    "13"
                           MOVE    "指導"      TO  SPA-GMN-SRYKBNME-L
                                                               (IDX-1)
                       WHEN    "14"
                           MOVE    "在宅"      TO  SPA-GMN-SRYKBNME-L
                                                               (IDX-1)
                       WHEN    "21"
                       WHEN    "22"
                       WHEN    "23"
                       WHEN    "24"
                           MOVE    "薬剤"      TO  SPA-GMN-SRYKBNME-L
                                                               (IDX-1)
                       WHEN    "25"
                           MOVE    "処方"      TO  SPA-GMN-SRYKBNME-L
                                                               (IDX-1)
                       WHEN    "26"
                           MOVE    "麻毒"      TO  SPA-GMN-SRYKBNME-L
                                                               (IDX-1)
                       WHEN    "27"
                           MOVE    "調基"      TO  SPA-GMN-SRYKBNME-L
                                                               (IDX-1)
                       WHEN    "31"
                       WHEN    "32"
                       WHEN    "33"
                           MOVE    "注射"      TO  SPA-GMN-SRYKBNME-L
                                                               (IDX-1)
                       WHEN    "40"
                           MOVE    "処置"      TO  SPA-GMN-SRYKBNME-L
                                                               (IDX-1)
                       WHEN    "50"
                           MOVE    "手術"  TO  SPA-GMN-SRYKBNME-L
                                                               (IDX-1)
                       WHEN    "54"
                           MOVE    "麻酔"  TO  SPA-GMN-SRYKBNME-L
                                                               (IDX-1)
                       WHEN    "60"
                           MOVE    "検査"      TO  SPA-GMN-SRYKBNME-L
                                                               (IDX-1)
                       WHEN    "70"
                           MOVE    "画像診断"  TO  SPA-GMN-SRYKBNME-L
                                                               (IDX-1)
                       WHEN    "80"
                           MOVE    "その他"    TO  SPA-GMN-SRYKBNME-L
                                                               (IDX-1)
                       WHEN    "93"
                           MOVE    "老人負担"  TO  SPA-GMN-SRYKBNME-L
                                                               (IDX-1)
                       WHEN    "95"
                           MOVE    "保険外"    TO  SPA-GMN-SRYKBNME-L
                                                               (IDX-1)
                       WHEN    "96"
                           MOVE    "保険外"    TO  SPA-GMN-SRYKBNME-L
                                                               (IDX-1)
                       WHEN    OTHER
                           MOVE    "その他"    TO  SPA-GMN-SRYKBNME-L
                                                               (IDX-1)
                   END-EVALUATE
               END-IF
      *        診療種別
               ADD     1                   TO  IDX-2
               MOVE    MSYU-SRYSYUKBN (IDX)    TO  SPA-GMN-SRYSYUKBNCOB
                                                           (IDX-2)(1:3)
               MOVE    MSYU-SRYMEI    (IDX)    TO  SPA-GMN-SRYSYUKBNCOB
                                                           (IDX-2)(5:)
           END-PERFORM
      *
           ADD     1                   TO  IDX-1
           MOVE    "90"                 TO  SPA-GMN-SRYKBN-L(IDX-1)
           MOVE    "入院"              TO  SPA-GMN-SRYKBNME-L (IDX-1)
           ADD     1                   TO  IDX-2
           MOVE    "900 入院"          TO  SPA-GMN-SRYSYUKBNCOB(IDX-2)
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   100
               IF      SPA-GMN-SRYKBN      =   SPA-GMN-SRYKBN-L(IDX)
                   MOVE    SPA-GMN-SRYKBNCOB (IDX) TO  SPA-GMN-SRYKBN-G
                   MOVE    100             TO  IDX
               END-IF
           END-PERFORM
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   100
               IF      SPA-GMN-SRYSYUKBN   =   SPA-GMN-SRYSYUKBNCOB
                                                         (IDX)(1:3)
                   MOVE    SPA-GMN-SRYSYUKBNCOB (IDX)
                                           TO  SPA-GMN-SRYSYUKBN-G
                   MOVE    100             TO  IDX
               END-IF
           END-PERFORM
      *
      *    データ区分
           MOVE    "0 なし"            TO  SPA-GMN-DATAKBNCOB (1)
           MOVE    "1 手技"            TO  SPA-GMN-DATAKBNCOB (2)
           MOVE    "2 加算"            TO  SPA-GMN-DATAKBNCOB (3)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               IF      SPA-GMN-DATAKBN     =   SPA-GMN-DATAKBNCOB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-DATAKBNCOB (IDX)
                                           TO  SPA-GMN-DATAKBN-G
                   MOVE    3               TO  IDX
               END-IF
           END-PERFORM
      *
      *    データ規格
           MOVE    1               TO  IDX-1
           MOVE    "000 "          TO  SPA-GMN-TANICDCOB(IDX-1)
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       MTANI-MAX
               ADD     1               TO  IDX-1
               MOVE    MTANI-TANICD  (IDX)
                                       TO  SPA-GMN-TANICDCOB(IDX-1)(1:3)
               MOVE    MTANI-TANINAME(IDX)
                                       TO  SPA-GMN-TANICDCOB(IDX-1)(5:)
           END-PERFORM
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   90
               IF      SPA-GMN-TANICD     =   SPA-GMN-TANICDCOB
                                                         (IDX)(1:3)
                   MOVE    SPA-GMN-TANICDCOB (IDX)
                                           TO  SPA-GMN-TANICD-G
                   MOVE    90              TO  IDX
               END-IF
           END-PERFORM
      *
      *    点数識別
           MOVE    "0     "            TO  SPA-GMN-TENSIKIBETUCOB (1)
           MOVE    "1 金額"            TO  SPA-GMN-TENSIKIBETUCOB (2)
           MOVE    "3 点数"            TO  SPA-GMN-TENSIKIBETUCOB (3)
           MOVE    "4 都道府県購入価格"
                                       TO  SPA-GMN-TENSIKIBETUCOB (4)
           MOVE    "5 ％加算"          TO  SPA-GMN-TENSIKIBETUCOB (5)
           MOVE    "6 ％減算"          TO  SPA-GMN-TENSIKIBETUCOB (6)
           MOVE    "7 減点診療行為"    TO  SPA-GMN-TENSIKIBETUCOB (7)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   7 
               IF      SPA-GMN-TENSIKIBETU =   SPA-GMN-TENSIKIBETUCOB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-TENSIKIBETUCOB (IDX)
                                           TO  SPA-GMN-TENSIKIBETU-G
                   MOVE    7               TO  IDX
               END-IF
           END-PERFORM
      *
      *    旧点数識別
           MOVE    "0     "            TO  SPA-GMN-OLDTENSKBCOB (1)
           MOVE    "1 金額"            TO  SPA-GMN-OLDTENSKBCOB (2)
           MOVE    "3 点数"            TO  SPA-GMN-OLDTENSKBCOB (3)
           MOVE    "4 都道府県購入価格"
                                       TO  SPA-GMN-OLDTENSKBCOB (4)
           MOVE    "5 ％加算"          TO  SPA-GMN-OLDTENSKBCOB (5)
           MOVE    "6 ％減算"          TO  SPA-GMN-OLDTENSKBCOB (6)
           MOVE    "7 減点診療行為"    TO  SPA-GMN-OLDTENSKBCOB (7)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   7 
               IF      SPA-GMN-OLDTENSKB =   SPA-GMN-OLDTENSKBCOB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-OLDTENSKBCOB (IDX)
                                           TO  SPA-GMN-OLDTENSKB-G
                   MOVE    7               TO  IDX
               END-IF
           END-PERFORM
      *
      *    保険適用
           MOVE    "0 保険適用なし"    TO  SPA-GMN-HKNTEKKBNCOB (1)
           MOVE    "1 保険適用あり"    TO  SPA-GMN-HKNTEKKBNCOB (2)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               IF      SPA-GMN-HKNTEKKBN   =   SPA-GMN-HKNTEKKBNCOB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-HKNTEKKBNCOB (IDX)
                                           TO  SPA-GMN-HKNTEKKBN-G
                   MOVE    2               TO  IDX
               END-IF
           END-PERFORM
      *
      *    入外区分
           MOVE    "0 入院・入院外"  TO  SPA-GMN-NYUGAITEKKBNCOB (1)
           MOVE    "1 入院"          TO  SPA-GMN-NYUGAITEKKBNCOB (2)
           MOVE    "2 入院外"        TO  SPA-GMN-NYUGAITEKKBNCOB (3)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               IF      SPA-GMN-NYUGAITEKKBN
                                           =   SPA-GMN-NYUGAITEKKBNCOB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-NYUGAITEKKBNCOB (IDX)
                                           TO  SPA-GMN-NYUGAITEKKBN-G
                   MOVE    3               TO  IDX
               END-IF
           END-PERFORM
      *
      *    老人適応
           MOVE    "0 社会保険・老人保健"
                                         TO  SPA-GMN-ROUTEKKBNCOB (1)
           MOVE    "1 社会保険のみ"
                                         TO  SPA-GMN-ROUTEKKBNCOB (2)
           MOVE    "2 老人保健のみ"
                                         TO  SPA-GMN-ROUTEKKBNCOB (3)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               IF      SPA-GMN-ROUTEKKBN   =   SPA-GMN-ROUTEKKBNCOB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-ROUTEKKBNCOB (IDX)
                                           TO  SPA-GMN-ROUTEKKBN-G
                   MOVE    3               TO  IDX
               END-IF
           END-PERFORM
      *
      *    病院適応
           MOVE    "0 病院・診療所"
                                         TO  SPA-GMN-HOSPSRYKBNCOB (1)
           MOVE    "1 病院のみ"
                                         TO  SPA-GMN-HOSPSRYKBNCOB (2)
           MOVE    "2 診療所のみ"
                                         TO  SPA-GMN-HOSPSRYKBNCOB (3)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               IF      SPA-GMN-HOSPSRYKBN  =   SPA-GMN-HOSPSRYKBNCOB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-HOSPSRYKBNCOB (IDX)
                                           TO  SPA-GMN-HOSPSRYKBN-G
                   MOVE    3               TO  IDX
               END-IF
           END-PERFORM
      *
      *    往診区分
           MOVE    "0 往診対象外"
                                         TO  SPA-GMN-OSINKBNCOB (1)
           MOVE    "1 往診料、訪問診療"
                                         TO  SPA-GMN-OSINKBNCOB (2)
           MOVE    "2 診療時間加算"
                                         TO  SPA-GMN-OSINKBNCOB (3)
           MOVE    "3 夜間加算・深夜加算"
                                         TO  SPA-GMN-OSINKBNCOB (4)
           MOVE    "4 特別往診加算"
                                         TO  SPA-GMN-OSINKBNCOB (5)
           MOVE    "6 特別往診料"
                                         TO  SPA-GMN-OSINKBNCOB (6)
           MOVE    "7 死亡診診加算"
                                         TO  SPA-GMN-OSINKBNCOB (7)
           MOVE    "8 緊急加算"
                                         TO  SPA-GMN-OSINKBNCOB (8)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   8
               IF      SPA-GMN-OSINKBN  =   SPA-GMN-OSINKBNCOB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-OSINKBNCOB (IDX)
                                           TO  SPA-GMN-OSINKBN-G
                   MOVE    8               TO  IDX
               END-IF
           END-PERFORM
      *
      *    算定履歴
           MOVE    "0 算定履歴なし"
                                         TO  SPA-GMN-SANTEIRRKKBNCOB (1)
           MOVE    "1 診療科、入外区分の指定なし"
                                         TO  SPA-GMN-SANTEIRRKKBNCOB (2)
           MOVE    "2 入外区分の指定"
                                         TO  SPA-GMN-SANTEIRRKKBNCOB (3)
           MOVE    "3 診療科の指定"
                                         TO  SPA-GMN-SANTEIRRKKBNCOB (4)
           MOVE    "4 診療科、入外区分の指定"
                                         TO  SPA-GMN-SANTEIRRKKBNCOB (5)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               IF      SPA-GMN-SANTEIRRKKBN  =   SPA-GMN-SANTEIRRKKBNCOB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-SANTEIRRKKBNCOB (IDX)
                                           TO  SPA-GMN-SANTEIRRKKBN-G
                   MOVE    5               TO  IDX
               END-IF
           END-PERFORM
      *
      *    時間外
           IF      SPA-GMN-DATAKBN       =   1  OR  ZERO
               MOVE    "0 時間外算定不可"
                                         TO  SPA-GMN-TIMEKSNKBNCOB (1)
               MOVE    "1 時間外算定可能"
                                         TO  SPA-GMN-TIMEKSNKBNCOB (2)
               MOVE    "2 初診料の休日に係る"
                                         TO  SPA-GMN-TIMEKSNKBNCOB (3)
           END-IF
           IF      SPA-GMN-DATAKBN        =   2
               MOVE    "0 時間外算定不可"
                                         TO  SPA-GMN-TIMEKSNKBNCOB (1)
               MOVE    "1 時間外加算"
                                         TO  SPA-GMN-TIMEKSNKBNCOB (2)
               MOVE    "2 休日加算"
                                         TO  SPA-GMN-TIMEKSNKBNCOB (3)
               MOVE    "3 初診料の休日加算"
                                         TO  SPA-GMN-TIMEKSNKBNCOB (4)
               MOVE    "4 深夜加算"
                                         TO  SPA-GMN-TIMEKSNKBNCOB (5)
               MOVE    "5 時間外特定加算"
                                         TO  SPA-GMN-TIMEKSNKBNCOB (6)
           END-IF
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   6
               IF      SPA-GMN-TIMEKSNKBN  =   SPA-GMN-TIMEKSNKBNCOB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-TIMEKSNKBNCOB (IDX)
                                           TO  SPA-GMN-TIMEKSNKBN-G
                   MOVE    6               TO  IDX
               END-IF
           END-PERFORM
      *
      *    外来管理加算
           MOVE    "0 外来管理加算が算定できる"
                                         TO  SPA-GMN-GAIKANRIKBNCOB (1)
           MOVE    "1 外来管理加算が算定できない"
                                         TO  SPA-GMN-GAIKANRIKBNCOB (2)
           MOVE    "2 外来管理加算"
                                         TO  SPA-GMN-GAIKANRIKBNCOB (3)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               IF      SPA-GMN-GAIKANRIKBN  =   SPA-GMN-GAIKANRIKBNCOB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-GAIKANRIKBNCOB (IDX)
                                           TO  SPA-GMN-GAIKANRIKBN-G
                   MOVE    3               TO  IDX
               END-IF
           END-PERFORM
      *
      *    傷病名関連
           MOVE    "00 "
                                         TO  SPA-GMN-BYOKANRENKBNCOB (1)
           MOVE    "03 皮膚科特定疾病指導管理料（１）"
                                         TO  SPA-GMN-BYOKANRENKBNCOB (2)
           MOVE    "04 皮膚科特定疾病指導管理料（２）"
                                         TO  SPA-GMN-BYOKANRENKBNCOB (3)
           MOVE    "05 特定疾患療養指導料及び老人慢性疾患生活指導"
                                         TO  SPA-GMN-BYOKANRENKBNCOB (4)
           MOVE    "06 皮膚科特定疾病指導管理料（３）"
                                         TO  SPA-GMN-BYOKANRENKBNCOB (5)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               IF      SPA-GMN-BYOKANRENKBN  =   SPA-GMN-BYOKANRENKBNCOB
                                                         (IDX)(1:2)
                   MOVE    SPA-GMN-BYOKANRENKBNCOB (IDX)
                                           TO  SPA-GMN-BYOKANRENKBN-G
                   MOVE    5               TO  IDX
               END-IF
           END-PERFORM
      *
      *    医薬品関連
           MOVE    "0"
                                           TO  SPA-GMN-YKZKNRKBNCOB (1)
           MOVE    "1 麻毒、覚せい剤、向精神薬加算"
                                           TO  SPA-GMN-YKZKNRKBNCOB (2)
           MOVE    "3 神経ブロック"
                                           TO  SPA-GMN-YKZKNRKBNCOB (3)
           MOVE    "4 生物学的製剤"
                                           TO  SPA-GMN-YKZKNRKBNCOB (4)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               IF      SPA-GMN-YKZKNRKBN   =   SPA-GMN-YKZKNRKBNCOB
                                                         (IDX)(1:2)
                   MOVE    SPA-GMN-YKZKNRKBNCOB (IDX)
                                           TO  SPA-GMN-YKZKNRKBN-G
                   MOVE    5               TO  IDX
               END-IF
           END-PERFORM
      *    指導管理コード
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       SDO-MAX
               MOVE    TBL-SDOKNRYO  (IDX)
                                       TO  SPA-GMN-SDOKNRYOCOB(IDX)
                                                             (1:2)
               MOVE    TBL-SDOKNRYOMEI(IDX)
                                       TO  SPA-GMN-SDOKNRYOCOB(IDX)
                                                            (4:)
           END-PERFORM
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   50
               IF      SPA-GMN-SDOKNRYO    =   SPA-GMN-SDOKNRYOCOB
                                                         (IDX)(1:3)
                   MOVE    SPA-GMN-SDOKNRYOCOB (IDX)
                                           TO  SPA-GMN-SDOKNRYO-G
                   MOVE    50              TO  IDX
               END-IF
           END-PERFORM
      *
      *
           .
      *
       30012-COB-HEN-EXT.
           EXIT.
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-ZID1-SET-SEC            SECTION.
      *
           IF      SPA-ZID1-FLG    =   "OK"
               IF      SPA-ZIDCD            =   "0001"
                   PERFORM  4031-DEL-SEC
               ELSE
                   PERFORM  4121-TOUROKU-SEC
               END-IF
           END-IF
      *
           IF      SPA-ERRCD       NOT =  SPACE
               PERFORM 510-ERRSET-SEC
           END-IF
           MOVE    SPACE           TO  SPA-ZID1-FLG
           MOVE    SPACE           TO  SPA-ZIDCD
           .
       330-ZID1-SET-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI-SEC                           SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE  "CHANGE"      TO  MCP-PUTTYPE
                   PERFORM  401-BACK-SEC
      *        削除
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM  403-DEL-SEC
      *        入力コード設定
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM  405-INPUTCD-SEC
      *        老人一般コード振替設定
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM  407-SRYCDCHG-SEC
      *        確定
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM  412-TOUROKU-SEC
      *        基本情報
               WHEN    "CLICKED"       ALSO    "BJ1"
                   MOVE  0                       TO  SPA-GMN-PAGENO
      *        回数、年齢
               WHEN    "CLICKED"       ALSO    "BJ2"
                   MOVE  1                       TO  SPA-GMN-PAGENO
      *        手術、検査、入院
               WHEN    "CLICKED"       ALSO    "BJ3"
                   MOVE  2                       TO  SPA-GMN-PAGENO
      *        各種番号等
               WHEN    "CLICKED"       ALSO    "BJ4"
                   MOVE  3                       TO  SPA-GMN-PAGENO
           END-EVALUATE.
      *
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY-SEC                             SECTION.
      *
           IF  MCP-EVENT                         =  "ACTIVATE"
               MOVE  ZERO                        TO  CNT-ERRCHK
               PERFORM  2001-ENTRY-SET-SEC
           END-IF
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力項目確定処理
      *****************************************************************
       2001-ENTRY-SET-SEC                             SECTION.
      *
           MOVE    ZERO                TO  CNT-CHK
           SET     IDX-GMN             TO  1
           SEARCH      TBL-GMN-OCC     VARYING   IDX-GMN
                   AT  END
                       MOVE    "1001"          TO  SPA-ERRCD
                   WHEN    MCP-WIDGET          =   TBL-WIDGET (IDX-GMN)
      **               SET     IDX-GMN         TO  CNT-CHK
                       SET     CNT-CHK         TO  IDX-GMN
           END-SEARCH 
           IF      CNT-CHK             >   ZERO
               PERFORM  500-ERRCHK-SEC
           END-IF
           .
      *
       2001-ENTRY-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN-SEC             SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-ZIDCD       NOT =   SPACE
               PERFORM 520-ZIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
      ***     MOVE  SPA-GMN-CUR           TO  MCP-WIDGET
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "Z03    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面セット処理
      *****************************************************************
       500-GMNHEN-SEC                            SECTION.
      *     画面ワークエリアにセット
           INITIALIZE                            Z03.
      *
           MOVE  SPA-GMN-PAGENO                TO  Z03-PAGENO
           MOVE  SPA-GMN-SRYCDH                TO  Z03-SRYCDH
           MOVE  SPA-GMN-NAMEH                 TO  Z03-NAMEH
           MOVE  SPA-GMN-YUKOSTYMDH            TO  Z03-YUKOSTYMDH
           MOVE  SPA-GMN-YUKOEDYMDH            TO  Z03-YUKOEDYMDH
      *                                         
           MOVE  SPA-GMN-YUKOSTYMD             TO  Z03-YUKOSTYMD
           MOVE  SPA-GMN-YUKOEDYMD             TO  Z03-YUKOEDYMD
           MOVE  SPA-GMN-SRYKBN-G              TO  Z03-SRYKBN   
           MOVE  SPA-GMN-SRYSYUKBN-G           TO  Z03-SRYSYUKBN
           MOVE  SPA-GMN-DATAKBN-G             TO  Z03-DATAKBN  
           MOVE  SPA-GMN-KANANAME              TO  Z03-KANANAME
           MOVE  SPA-GMN-NAME                  TO  Z03-NAME
           MOVE  SPA-GMN-TEN                   TO  Z03-TEN
           MOVE  SPA-GMN-TENSIKIBETU-G         TO  Z03-TENSIKIBETU
           MOVE  SPA-GMN-OLDTEN                TO  Z03-OLDTEN
           MOVE  SPA-GMN-OLDTENSKB-G           TO  Z03-OLDTENSKB
           MOVE  SPA-GMN-TANICD-G              TO  Z03-TANICD
      *****MOVE  SPA-GMN-TANINAME              TO  Z03-TANINAME
           MOVE  SPA-GMN-HKNTEKKBN-G           TO  Z03-HKNTEKKBN   
           MOVE  SPA-GMN-BYOKANRENKBN-G        TO  Z03-BYOKANRENKBN
           MOVE  SPA-GMN-SDOKNRYO-G            TO  Z03-SDOKNRYO    
           MOVE  SPA-GMN-YKZKNRKBN-G           TO  Z03-YKZKNRKBN   
           MOVE  SPA-GMN-NYUGAITEKKBN-G        TO  Z03-NYUGAITEKKBN
           MOVE  SPA-GMN-ROUTEKKBN-G           TO  Z03-ROUTEKKBN   
           MOVE  SPA-GMN-HOSPSRYKBN-G          TO  Z03-HOSPSRYKBN  
           MOVE  SPA-GMN-OSINKBN-G             TO  Z03-OSINKBN     
           MOVE  SPA-GMN-BYOSYOKBN             TO  Z03-BYOSYOKBN   
           MOVE  SPA-GMN-SANTEIRRKKBN-G        TO  Z03-SANTEIRRKKBN
           MOVE  SPA-GMN-TIMEKSNKBN-G          TO  Z03-TIMEKSNKBN  
           MOVE  SPA-GMN-GAIKANRIKBN-G         TO  Z03-GAIKANRIKBN 
           MOVE  SPA-GMN-TSUSOKUAGE            TO  Z03-TSUSOKUAGE  
           MOVE  SPA-GMN-KGNAGE                TO  Z03-KGNAGE      
           MOVE  SPA-GMN-JGNAGE                TO  Z03-JGNAGE      
      *
           MOVE  SPA-GMN-FORMALNAME            TO  Z03-FORMALNAME
           MOVE  SPA-GMN-INPCHKKBN             TO  Z03-INPCHKKBN
      *    採血料区分
           MOVE  SPA-GMN-SAIKETUKBN-G          TO  Z03-SAIKETUKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   4
               MOVE    SPA-GMN-SAIKETUCOMB (IDX)
                                          TO  Z03-SAIKETUKBN-ITEM(IDX)
               MOVE    IDX                TO  Z03-SAIKETUKBN-COUNT
           END-PERFORM
      *    診療区分
           MOVE    ZERO                TO  IDX-1
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   100
               IF      SPA-GMN-SRYKBNCOB (IDX) NOT =   SPACE
                   ADD     1               TO  IDX-1
                   MOVE    SPA-GMN-SRYKBNCOB (IDX)
                                           TO  Z03-SRYKBN-ITEM(IDX-1)
                   MOVE    IDX-1           TO  Z03-SRYKBN-COUNT
               END-IF
           END-PERFORM
           MOVE    ZERO                TO  IDX-1
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   100
               IF      SPA-GMN-SRYSYUKBNCOB (IDX) NOT =   SPACE
                   ADD     1               TO  IDX-1
                   MOVE    SPA-GMN-SRYSYUKBNCOB (IDX)
                                           TO  Z03-SRYSYUKBN-ITEM(IDX-1)
                   MOVE    IDX-1           TO  Z03-SRYSYUKBN-COUNT
               END-IF
           END-PERFORM
      *    データ区分
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               MOVE    SPA-GMN-DATAKBNCOB (IDX)
                                           TO  Z03-DATAKBN-ITEM (IDX)
               MOVE    IDX                 TO  Z03-DATAKBN-COUNT
           END-PERFORM
      *    データ規格
           MOVE    ZERO                TO  IDX-1
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   90
               IF      SPA-GMN-TANICDCOB (IDX) NOT =   SPACE
                   ADD     1               TO  IDX-1
                   MOVE    SPA-GMN-TANICDCOB (IDX)
                                           TO  Z03-TANICD-ITEM (IDX-1)
                   MOVE    IDX-1           TO  Z03-TANICD-COUNT
               END-IF
           END-PERFORM
      *    点数識別
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   7
               MOVE    SPA-GMN-TENSIKIBETUCOB (IDX)
                                       TO  Z03-TENSIKIBETU-ITEM (IDX)
               MOVE    IDX             TO  Z03-TENSIKIBETU-COUNT
           END-PERFORM
      *     旧点数識別
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   7
               MOVE    SPA-GMN-OLDTENSKBCOB (IDX)
                                           TO  Z03-OLDTENSKB-ITEM (IDX)
               MOVE    IDX                 TO  Z03-OLDTENSKB-COUNT
           END-PERFORM
      *
      *    保険適用
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               MOVE    SPA-GMN-HKNTEKKBNCOB (IDX)
                                           TO  Z03-HKNTEKKBN-ITEM (IDX)
               MOVE    IDX                 TO  Z03-HKNTEKKBN-COUNT
           END-PERFORM
      *    傷病名
           MOVE    ZERO                TO  IDX-1
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               IF      SPA-GMN-BYOKANRENKBNCOB (IDX)   NOT =   SPACE
                   ADD     1               TO  IDX-1
                   MOVE    SPA-GMN-BYOKANRENKBNCOB (IDX)
                                           TO  Z03-BYOKANRENKBN-ITEM
                                                         (IDX-1)
                   MOVE    IDX             TO  Z03-BYOKANRENKBN-COUNT
               END-IF
           END-PERFORM
      *    指導管理
           MOVE    ZERO                TO  IDX-1
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   50
               IF      SPA-GMN-SDOKNRYOCOB (IDX)   NOT =   SPACE
                   ADD     1               TO  IDX-1
                   MOVE    SPA-GMN-SDOKNRYOCOB (IDX)
                                           TO  Z03-SDOKNRYO-ITEM
                                                         (IDX-1)
                   MOVE    IDX             TO  Z03-SDOKNRYO-COUNT
               END-IF
           END-PERFORM
      *    医薬品関連
           MOVE    ZERO                TO  IDX-1
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               IF      SPA-GMN-YKZKNRKBNCOB (IDX)   NOT =   SPACE
                   ADD     1               TO  IDX-1
                   MOVE    SPA-GMN-YKZKNRKBNCOB (IDX)
                                           TO  Z03-YKZKNRKBN-ITEM
                                                         (IDX-1)
                   MOVE    IDX             TO  Z03-YKZKNRKBN-COUNT
               END-IF
           END-PERFORM
      *
      *    入外区分
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               MOVE    SPA-GMN-NYUGAITEKKBNCOB (IDX)
                                       TO  Z03-NYUGAITEKKBN-ITEM (IDX)
               MOVE    IDX                 TO  Z03-NYUGAITEKKBN-COUNT
           END-PERFORM
      *    老人適応
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               MOVE    SPA-GMN-ROUTEKKBNCOB (IDX)
                                           TO  Z03-ROUTEKKBN-ITEM (IDX)
               MOVE    IDX                 TO  Z03-ROUTEKKBN-COUNT
           END-PERFORM
      *
      *    病院適応
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               MOVE    SPA-GMN-HOSPSRYKBNCOB (IDX)
                                           TO  Z03-HOSPSRYKBN-ITEM (IDX)
               MOVE    IDX                 TO  Z03-HOSPSRYKBN-COUNT
           END-PERFORM
      *    往診区分
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   8
               MOVE    SPA-GMN-OSINKBNCOB (IDX)
                                           TO  Z03-OSINKBN-ITEM (IDX)
               MOVE    IDX                 TO  Z03-OSINKBN-COUNT
           END-PERFORM
      *    算定履歴
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               MOVE    SPA-GMN-SANTEIRRKKBNCOB (IDX)
                                       TO  Z03-SANTEIRRKKBN-ITEM (IDX)
               MOVE    IDX                 TO  Z03-SANTEIRRKKBN-COUNT
           END-PERFORM
      *    時間外
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   6  )  OR
                              (SPA-GMN-TIMEKSNKBNCOB (IDX) =  SPACE )
               MOVE    SPA-GMN-TIMEKSNKBNCOB (IDX)
                                           TO  Z03-TIMEKSNKBN-ITEM (IDX)
               MOVE    IDX                 TO  Z03-TIMEKSNKBN-COUNT
           END-PERFORM
      *    外来管理加算
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               MOVE    SPA-GMN-GAIKANRIKBNCOB (IDX)
                                       TO  Z03-GAIKANRIKBN-ITEM (IDX)
               MOVE    IDX             TO  Z03-GAIKANRIKBN-COUNT
           END-PERFORM
      *
      *
           MOVE  SPA-GMN-JITUDAY               TO  Z03-JITUDAY        
           MOVE  SPA-GMN-DAYCNT                TO  Z03-DAYCNT         
           MOVE  SPA-GMN-JGNCNT                TO  Z03-JGNCNT         
           MOVE  SPA-GMN-JGNCNT1D              TO  Z03-JGNCNT1D       
           MOVE  SPA-GMN-JGNCNT1W              TO  Z03-JGNCNT1W       
           MOVE  SPA-GMN-JGNCNTETCM            TO  Z03-JGNCNTETCM     
           MOVE  SPA-GMN-JGNCNTETC             TO  Z03-JGNCNTETC      
           MOVE  SPA-GMN-JGNCNTERR             TO  Z03-JGNCNTERR      
           MOVE  SPA-GMN-KZMCOMPSIKIBETU       TO  Z03-KZMCOMPSIKIBETU
           MOVE  SPA-GMN-KZMKGN                TO  Z03-KZMKGN         
           MOVE  SPA-GMN-KZMJGN                TO  Z03-KZMJGN         
           MOVE  SPA-GMN-KZM                   TO  Z03-KZM            
           MOVE  SPA-GMN-KZMTEN                TO  Z03-KZMTEN         
           MOVE  SPA-GMN-KZMERR                TO  Z03-KZMERR         
           MOVE  SPA-GMN-CHUKSNCD              TO  Z03-CHUKSNCD       
           MOVE  SPA-GMN-CHUKSNTSUBAN          TO  Z03-CHUKSNTSUBAN   
           MOVE  SPA-GMN-AGEKSNKGN(1)          TO  Z03-AGEKSNKGN1
           MOVE  SPA-GMN-AGEKSNJGN(1)          TO  Z03-AGEKSNJGN1
           MOVE  SPA-GMN-AGEKSNSRYCD(1)        TO  Z03-AGEKSNSRYCD1
           MOVE  SPA-GMN-AGEKSNKGN(2)          TO  Z03-AGEKSNKGN2
           MOVE  SPA-GMN-AGEKSNJGN(2)          TO  Z03-AGEKSNJGN2
           MOVE  SPA-GMN-AGEKSNSRYCD(2)        TO  Z03-AGEKSNSRYCD2
           MOVE  SPA-GMN-AGEKSNKGN(3)          TO  Z03-AGEKSNKGN3
           MOVE  SPA-GMN-AGEKSNJGN(3)          TO  Z03-AGEKSNJGN3
           MOVE  SPA-GMN-AGEKSNSRYCD(3)        TO  Z03-AGEKSNSRYCD3
           MOVE  SPA-GMN-AGEKSNKGN(4)          TO  Z03-AGEKSNKGN4
           MOVE  SPA-GMN-AGEKSNJGN(4)          TO  Z03-AGEKSNJGN4
           MOVE  SPA-GMN-AGEKSNSRYCD(4)        TO  Z03-AGEKSNSRYCD4
      *                                          
           MOVE  SPA-GMN-TUSOKUGAIKBN          TO  Z03-TUSOKUGAIKBN    
           MOVE  SPA-GMN-LASERKSN              TO  Z03-LASERKSN        
           MOVE  SPA-GMN-CHPMESUKSN            TO  Z03-CHPMESUKSN      
           MOVE  SPA-GMN-MICMESUKSN            TO  Z03-MICMESUKSN      
           MOVE  SPA-GMN-SEKIZUISOKUTEI        TO  Z03-SEKIZUISOKUTEI  
           MOVE  SPA-GMN-KEIBUJYUTU            TO  Z03-KEIBUJYUTU      
           MOVE  SPA-GMN-AUTOHOUGO             TO  Z03-AUTOHOUGO       
           MOVE  SPA-GMN-AUTOFUNGO             TO  Z03-AUTOFUNGO       
           MOVE  SPA-GMN-CHPGYOKOSOTIKSN       TO  Z03-CHPGYOKOSOTIKSN 
           MOVE  SPA-GMN-SHORTSTAYOPE          TO  Z03-SHORTSTAYOPE    
      *    施設基準不適合区分
           MOVE  SPA-GMN-KIJUNTEIGENKBN    TO  Z03-KIJUNTEIGENKBN
      *     基準不適合逓減対象施設基準コード
           MOVE  SPA-GMN-KIJUNTEIGENCD     TO  Z03-KIJUNTEIGENCD    
           MOVE  SPA-GMN-KNSJISKBN             TO  Z03-KNSJISKBN       
           MOVE  SPA-GMN-KNSJISGRPKBN          TO  Z03-KNSJISGRPKBN    
           MOVE  SPA-GMN-KENTAICOMMENT         TO  Z03-KENTAICOMMENT   
           MOVE  SPA-GMN-TEIGENKBN             TO  Z03-TEIGENKBN       
           MOVE  SPA-GMN-HOKATUTEIGENKBN       TO  Z03-HOKATUTEIGENKBN 
           MOVE  SPA-GMN-HOUKNSKBN             TO  Z03-HOUKNSKBN       
           MOVE  SPA-GMN-CHPNAISIKSN           TO  Z03-CHPNAISIKSN     
           MOVE  SPA-GMN-NYUKHNKBN             TO  Z03-NYUKHNKBN
           MOVE  SPA-GMN-NYUKHNKSNKBN          TO  Z03-NYUKHNKSNKBN
           MOVE  SPA-GMN-KANGOKSN              TO  Z03-KANGOKSN 
           MOVE  SPA-GMN-CHIIKIKSN             TO  Z03-CHIIKIKSN       
      *                                          
           MOVE  SPA-GMN-SSTKIJUNCD(1)         TO  Z03-SSTKIJUNCD1     
           MOVE  SPA-GMN-SSTKIJUNCD(2)         TO  Z03-SSTKIJUNCD2     
           MOVE  SPA-GMN-SSTKIJUNCD(3)         TO  Z03-SSTKIJUNCD3     
           MOVE  SPA-GMN-SSTKIJUNCD(4)         TO  Z03-SSTKIJUNCD4     
           MOVE  SPA-GMN-SSTKIJUNCD(5)         TO  Z03-SSTKIJUNCD5     
           MOVE  SPA-GMN-SSTKIJUNCD(6)         TO  Z03-SSTKIJUNCD6     
           MOVE  SPA-GMN-SSTKIJUNCD(7)         TO  Z03-SSTKIJUNCD7     
           MOVE  SPA-GMN-SSTKIJUNCD(8)         TO  Z03-SSTKIJUNCD8     
           MOVE  SPA-GMN-SSTKIJUNCD(9)         TO  Z03-SSTKIJUNCD9     
           MOVE  SPA-GMN-SSTKIJUNCD(10)        TO  Z03-SSTKIJUNCD10    
           MOVE  SPA-GMN-GAITENTTLKBN          TO  Z03-GAITENTTLKBN    
           MOVE  SPA-GMN-NYUTENTTLSKB          TO  Z03-NYUTENTTLSKB
           MOVE  SPA-GMN-KOUHYOJYUNNUM         TO  Z03-KOUHYOJYUNNUM   
           MOVE  SPA-GMN-CDKBN-KBN             TO  Z03-CDKBN-KBN       
           MOVE  SPA-GMN-CDKBN-SYO             TO  Z03-CDKBN-SYO       
           MOVE  SPA-GMN-CDKBN-BU              TO  Z03-CDKBN-BU        
           MOVE  SPA-GMN-CDKBN-KBNNUM          TO  Z03-CDKBN-KBNNUM    
           MOVE  SPA-GMN-CDKBN-KBNNUM-EDA      TO  Z03-CDKBN-KBNNUM-EDA
           MOVE  SPA-GMN-CDKBN-KOUBAN          TO  Z03-CDKBN-KOUBAN    
           MOVE  SPA-GMN-KOKUCHI-KBN           TO  Z03-KOKUCHI-KBN     
           MOVE  SPA-GMN-KOKUCHI-SYO           TO  Z03-KOKUCHI-SYO     
           MOVE  SPA-GMN-KOKUCHI-BU            TO  Z03-KOKUCHI-BU      
           MOVE  SPA-GMN-KOKUCHI-KBNNUM        TO  Z03-KOKUCHI-KBNNUM  
           MOVE  SPA-GMN-KOKUCHI-KBNNUM-EDA    TO
                                               Z03-KOKUCHI-KBNNUM-EDA
           MOVE  SPA-GMN-KOKUCHI-KOUBAN        TO  Z03-KOKUCHI-KOUBAN  
           MOVE  SPA-GMN-KOKUJISKBKBN1         TO  Z03-KOKUJISKBKBN1   
           MOVE  SPA-GMN-KOKUJISKBKBN2         TO  Z03-KOKUJISKBKBN2   
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
      **     EVALUATE    SPA-GMN-CUR
      **          WHEN   1
      **              MOVE  "STYUKYMD"   TO  MCP-WIDGET
      **     END-EVALUATE
      *
           MOVE    SPA-GMN-CUR           TO  MCP-WIDGET
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示処理
      *****************************************************************
       510-ERRSET-SEC                            SECTION.
           MOVE    SPACE                         TO  SPA-ERRMSG.
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "漢字名称を入力してください"
                                                 TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "数字のみ入力可能です"
                                                 TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "入力エラー"
                                                 TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "投入された年月日に誤りがあります"
                                                 TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "年月日の大小関係に誤りがあります"
                                                 TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "有効年月日を入力してください"
                                                 TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "有効年月日が重複しています"
                                                 TO  SPA-ERRMSG
               WHEN    "0009"
                   MOVE    "登録処理が失敗しました"
                                                 TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "改正の終了年月日はＡＬＬ９のみ入力できます"
                                                 TO  SPA-ERRMSG
               WHEN    "0011"
                   MOVE    "診療区分が登録されていません"
                                                 TO  SPA-ERRMSG
               WHEN    "0012"
                   MOVE    "診療種別が登録されていません"
                                                 TO  SPA-ERRMSG
               WHEN    "0013"
                   MOVE    "単位がありません"
                                                 TO  SPA-ERRMSG
               WHEN    "0014"
                   MOVE    "採血料区分は入力できません。"
                                                 TO  SPA-ERRMSG
               WHEN    "0020"
                   MOVE    "老人一般コード変換更新エラー"
                                                 TO  SPA-ERRMSG
               WHEN    "0021"
                   MOVE    "老人一般コード変換はできません"
                                                 TO  SPA-ERRMSG
               WHEN    "0015"
                   MOVE    "削除処理が失敗しました"
                                                 TO  SPA-ERRMSG
               WHEN    "0016"
                   MOVE    "点数マスタ付加情報が更新できません"
                                                 TO  SPA-ERRMSG
               WHEN    "0017"
                   MOVE    "すべて全角で入力して下さい。"
                                                 TO  SPA-ERRMSG
           END-EVALUATE.
      *
           MOVE    SPACE                         TO  ZERR
           MOVE    SPA-ERRCD                     TO  ZERR-ERRCODE
           MOVE    SPA-ERRMSG                TO  ZERR-ERRMSG
      *
           MOVE    "Z03"                         TO  SPA-MOTOPG
           MOVE    "ZERR"                        TO  SPA-SAKIPG
      *
           MOVE    "NEW"                         TO  MCP-PUTTYPE
           MOVE    "ZERR"                        TO  MCP-WINDOW
           MOVE    "B01"                         TO  MCP-WIDGET
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                             TO  FLG-END
           .    
      *
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       520-ZIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-ZIDMSG
      *
           EVALUATE    SPA-ZIDCD
               WHEN    "0001"
                   MOVE    "削除します。よろしいですか？"
                                                       TO  WRK-ZIDMSG
               WHEN    "0002"
                   MOVE    "更新します。よろしいですか？"
                                                       TO  WRK-ZIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  ZID1
           MOVE    SPA-ZIDCD            TO  ZID1-ID1CODE
           MOVE    WRK-ZIDMSG           TO  ZID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "Z03"                TO  SPA-MOTOPG
           MOVE    "ZID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "ZID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-ZIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       401-BACK-SEC                              SECTION.
      *
           MOVE  "Z01"                           TO  SPA-SAKIPG.
      *
           MOVE  "Z03"                           TO  SPA-MOTOPG.
      *
      ***  MOVE  "CHANGE"                        TO  MCP-PUTTYPE.
           MOVE  SPA-SAKIPG                      TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                             TO  FLG-END.
       401-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除確認画面表示処理
      *****************************************************************
       403-DEL-SEC                               SECTION.
      *
           MOVE    "0001"              TO  SPA-ZIDCD
      *
           .    
       403-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除処理
      *****************************************************************
       4031-DEL-SEC                              SECTION.
      *
      *    点数マスタ削除
           MOVE  SPA-Z01-SRYCD               TO  TNS-SRYCD
           MOVE  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                             TO  TNS-YUKOSTYMD
           MOVE  SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                             TO  TNS-YUKOEDYMD
           PERFORM  816-TENSUDEL-SEC
           IF     MCP-RC               NOT =   ZERO
               DISPLAY "TNS DEL ERR!!"
               MOVE    "0015"                TO  SPA-ERRCD
               GO      TO      4031-DEL-EXT
           END-IF
      *
      *    点数付加情報削除
           MOVE    SPA-Z01-SRYCD       TO  TNSP-SRYCD
           MOVE    SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                       TO  TNSP-YUKOSTYMD
           MOVE    SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                       TO  TNSP-YUKOEDYMD
           MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    入力コード削除
           IF     (SPA-Z01-SELNUM      =   1    )  AND
                  (SPA-Z01-MAX         =   1    )
               MOVE  SPA-HOSPID                  TO  ICD-HOSPID
               MOVE  SPA-Z01-SRYCD               TO  ICD-SRYCD
               MOVE  INPUTCD-REC                 TO  MCPDATA-REC
               MOVE  "DBDELETE"                  TO  MCP-FUNC
               MOVE  "INPUTCD-KEY4"              TO  ORC-DBPATH
               CALL  "ORCMCPSUB"                  USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
      *
      *        一般老人コード削除
               PERFORM VARYING     IDX     FROM    1   BY  1
                       UNTIL      (IDX     >   5  )    OR
                                  (SPA-Z90-IPNSRYCD (IDX)  =   SPACE )
                   MOVE    SPA-Z90-IPNSRYCD (IDX)  TO  CHG-IPNSRYCD
                   MOVE    SPA-Z90-RJNSRYCD (IDX)  TO  CHG-RJNSRYCD
      *
                   MOVE    SRYCDCHG-REC        TO  MCPDATA-REC
                   MOVE    "DBDELETE"          TO  MCP-FUNC
                   MOVE    "SRYCDCHG-KEY"      TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                    MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
               END-PERFORM
           END-IF
      *
      *
           MOVE  "JOIN"               TO  MCP-PUTTYPE
           PERFORM  401-BACK-SEC
           .
       4031-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力コード　設定処理
      *****************************************************************
       405-INPUTCD-SEC                              SECTION.
      *
           MOVE    SPA-Z01KYOUTU       TO  SPA-WORK
           MOVE    SPA-AREA            TO  SPA-COMMON
           MOVE    SPA-Z03             TO  SPA-Z01SONOTA
           MOVE    SPA-Z01FREE         TO  SPA-FREE
      *
           MOVE    "LINK"              TO  MCP-STATUS
           MOVE    SPACE               TO  MCP-EVENT
      *
           CALL    "ORCGZ99"           USING
                                       MCPAREA
                                       SPAAREA
                                       LINKAREA
                                       SCRAREA
      *
           MOVE    SPA-COMMON          TO  SPA-AREA
           MOVE    SPA-WORK            TO  SPA-Z01KYOUTU
           MOVE    SPA-FREE            TO  SPA-Z01FREE
           MOVE    SPA-Z01SONOTA       TO  SPA-Z03
      *
      *    初期カーソル
           MOVE    "INPUTCD01"         TO  MCP-WIDGET
      *
           MOVE    "Z99"               TO  SPA-SAKIPG.
           MOVE    "Z03"               TO  SPA-MOTOPG.
      *
           MOVE    SPA-MOTOPG          TO  SPA-Z99GMN-MOTOPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                             TO  FLG-END.
      *
       405-INPUTCD-EXT.
           EXIT.
      *        
      *
      *****************************************************************
      *    老人一般コード振替設定処理
      *****************************************************************
       407-SRYCDCHG-SEC                SECTION.
      *
           EVALUATE    SPA-GMN-ROUTEKKBN
               WHEN    1
               WHEN    2
                   CONTINUE
               WHEN    OTHER
                   MOVE    "0021"              TO  SPA-ERRCD
                   GO      TO      407-SRYCDCHG-EXT
           END-EVALUATE
      *
      *    Ｚ９０初期画面編集
           MOVE    SPACE               TO  SPA-Z90GMN-AREA.
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               MOVE    SPA-Z90-SRYCDCHG (IDX)
                               TO  SPA-Z90GMN-SRYCDCHG (IDX)
               MOVE    SPA-Z90-SRYNAME  (IDX)
                               TO  SPA-Z90GMN-SRYNAME (IDX)
           END-PERFORM
           MOVE    1                   TO  SPA-Z90GMN-CUR
      *
      *    画面編集
           MOVE    SPACE               TO  Z90
           MOVE    SPA-Z01-SRYCD       TO  Z90-SRYCD
           MOVE    SPA-Z01-NAMEH       TO  Z90-SRYNAME
           PERFORM VARYING  IDX    FROM  1  BY  1  
                   UNTIL    IDX        >  5
               MOVE    SPA-Z90GMN-SRYCDCHG (IDX) TO  Z90-SRYCDCHG (IDX)
               MOVE    SPA-Z90GMN-SRYNAME  (IDX) TO  Z90-SRYCDNAME(IDX)
           END-PERFORM
      *
      *    初期カーソル
           MOVE    "SRYCDCHG1"         TO  MCP-WIDGET
      *
           MOVE    "Z90"               TO  SPA-SAKIPG
      *
           MOVE    "Z03"               TO  SPA-MOTOPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                             TO  FLG-END.
      *
       407-SRYCDCHG-EXT.
           EXIT.
      *****************************************************************
      *    登録処理
      *****************************************************************
       412-TOUROKU-SEC                           SECTION.
      *
      *    エラーチェック
           MOVE    SPA-GMN-CUR                   TO  WRK-GMN-CUR 
      * 
           PERFORM  VARYING  CNT-ERRCHK
                    FROM  1  BY  1  UNTIL  CNT-ERRCHK  >  109
               MOVE    CNT-ERRCHK          TO  CNT-CHK
               PERFORM  500-ERRCHK-SEC
               IF  SPA-ERRCD                 NOT =  SPACE
                   EVALUATE  TRUE
                       WHEN  CNT-ERRCHK <  32
                           MOVE  0               TO  SPA-GMN-PAGENO
                       WHEN  CNT-ERRCHK <  60
                           MOVE  1               TO  SPA-GMN-PAGENO
                       WHEN  CNT-ERRCHK <  82
                           MOVE  2               TO  SPA-GMN-PAGENO
                       WHEN  OTHER
                           MOVE  3               TO  SPA-GMN-PAGENO
                   END-EVALUATE
                   GO                            TO  412-TOUROKU-EXT
               END-IF
           END-PERFORM
           IF  SPA-ERRCD                     =  SPACE
               MOVE  "B12"                   TO  MCP-WIDGET
               MOVE  WRK-GMN-CUR             TO  SPA-GMN-CUR    
           END-IF
      *
           IF  SPA-GMN-YUKOSTYMD               =  SPACE  OR
               SPA-GMN-YUKOEDYMD               =  SPACE
               MOVE  0                           TO  SPA-GMN-PAGENO
               MOVE    "YUKOSTYMD"               TO  SPA-GMN-CUR
               MOVE    "0005"                    TO  SPA-ERRCD
               GO                                TO  412-TOUROKU-EXT
           END-IF
      *
           IF  SPA-NAI-YUKOSTYMD               >= SPA-NAI-YUKOEDYMD
               MOVE  0                           TO  SPA-GMN-PAGENO
               MOVE    "YUKOSTYMD"               TO  SPA-GMN-CUR
               MOVE    "0005"                    TO  SPA-ERRCD
               GO                                TO  412-TOUROKU-EXT
           END-IF
      *
      *    有効期限範囲チェック
           IF      SPA-Z01-SYORIKBN    =   2
      *        前チェック
               IF      SPA-Z01-SELNUM      >   1
                   MOVE    SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM - 1)
                                           TO  WRK-YMD
      *            対象日＋１日
                   PERFORM 800-DAYSET-SEC
                   IF      SPA-NAI-YUKOSTYMD   NOT =   WRK-OTYMD
                       MOVE    "YUKOSTYMD"         TO  SPA-GMN-CUR
                       MOVE    "0011"              TO  SPA-ERRCD
                       GO      TO      412-TOUROKU-EXT
                   END-IF
               END-IF
      *        後チェック
               IF      SPA-Z01-SELNUM      <   SPA-Z01-MAX
                   MOVE    SPA-NAI-YUKOEDYMD
                                           TO  WRK-YMD
      *            対象日＋１日
                   PERFORM 800-DAYSET-SEC
                   IF      SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM + 1)
                                               NOT =   WRK-OTYMD
                       MOVE    "YUKOEDYMD"         TO  SPA-GMN-CUR
                       MOVE    "0011"              TO  SPA-ERRCD
                       GO      TO      412-TOUROKU-EXT
                   END-IF
               END-IF
           END-IF
      *
           IF  SPA-Z01-SYORIKBN                  =  3
               IF  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM) >=
                   SPA-NAI-YUKOSTYMD
                   MOVE  0                       TO  SPA-GMN-PAGENO
                   MOVE    "YUKOSTYMD"           TO  SPA-GMN-CUR
                   MOVE    "0008"                TO  SPA-ERRCD
                   GO                            TO  412-TOUROKU-EXT
               END-IF
      *
               IF  SPA-NAI-YUKOEDYMD    NOT    =  99999999
                   MOVE  0                       TO  SPA-GMN-PAGENO
                   MOVE    "YUKOEDYMD"           TO  SPA-GMN-CUR
                   MOVE    "0010"                TO  SPA-ERRCD
                   GO                            TO  412-TOUROKU-EXT
               END-IF
           END-IF
      *
           IF  SPA-GMN-NAME                    =  SPACE
               MOVE  0                           TO  SPA-GMN-PAGENO
               MOVE    "NAME"                    TO  SPA-GMN-CUR
               MOVE    "0001"                    TO  SPA-ERRCD
               GO                                TO  412-TOUROKU-EXT
           END-IF
      *
           MOVE    "0002"                        TO  SPA-ZIDCD
           .    
       412-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録処理
      *****************************************************************
       4121-TOUROKU-SEC                          SECTION.
      *
      *    改正時処理
           IF  SPA-Z01-SYORIKBN                  =  3
      *
      *        データＵＰＤＡＴＥ
               INITIALIZE                        TNS-TENSU-REC
      *
               MOVE  SPA-Z01-SRYCD               TO  TNS-SRYCD
               MOVE  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                 TO  TNS-YUKOSTYMD
               MOVE  SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                 TO  TNS-YUKOEDYMD
               PERFORM  811-TENSUSEL-SEC
      *
               IF  MCP-RC                        =   ZERO
                   PERFORM  812-TENSUFET-SEC
                   IF  MCP-RC                    =   ZERO
                       MOVE  MCPDATA-REC         TO  TNS-TENSU-REC
                       MOVE  SPA-NAI-YUKOSTYMD   TO  WRK-LNKYMD
                       PERFORM  833-YMDCONV61-SEC
                       IF  STS-DAY-RC1            =  ZERO
                           MOVE  WRK-SYMD        TO  TNS-YUKOEDYMD
                       ELSE
                           MOVE   0              TO  SPA-GMN-PAGENO
                           MOVE    "YUKOSTYMD"   TO  SPA-GMN-CUR
                           MOVE    "0004"        TO  SPA-ERRCD
                          GO                     TO  4121-TOUROKU-EXT
                       END-IF
                       MOVE  SPA-Z01-SRYCD       TO  TNSUP-SRYCD
                       MOVE  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                 TO  TNSUP-YUKOSTYMD
                       MOVE  SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                 TO  TNSUP-YUKOEDYMD
                       PERFORM  815-TENSUUPD-SEC
                       IF  MCP-RC          NOT   =   ZERO
                           MOVE    "B12"         TO  SPA-GMN-CUR
                           MOVE    "0009"        TO  SPA-ERRCD
                           PERFORM  813-TENSUCLS-SEC
                           GO                    TO  4121-TOUROKU-EXT
                       END-IF
                   ELSE
                       MOVE    "B12"             TO  SPA-GMN-CUR
                       MOVE    "0009"            TO  SPA-ERRCD
                       PERFORM  813-TENSUCLS-SEC
                       GO                        TO  4121-TOUROKU-EXT
                   END-IF
               ELSE
                   MOVE    "B12"                 TO  SPA-GMN-CUR
                   MOVE    "0009"                TO  SPA-ERRCD
                   PERFORM  813-TENSUCLS-SEC
                   GO                            TO  4121-TOUROKU-EXT
               END-IF
               PERFORM  813-TENSUCLS-SEC
           END-IF
      *
      *　  登録処理
           IF  SPA-Z01-SYORIKBN                  =  2
      *        データＵＰＤＡＴＥ
               INITIALIZE                        TNS-TENSU-REC
      *
               MOVE  SPA-Z01-SRYCD               TO  TNS-SRYCD
               MOVE  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                 TO  TNS-YUKOSTYMD
               MOVE  SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                 TO  TNS-YUKOEDYMD
               PERFORM  811-TENSUSEL-SEC
      *
               IF  MCP-RC                        =   ZERO
                   PERFORM  812-TENSUFET-SEC
                   IF  MCP-RC                    =   ZERO
                       MOVE  MCPDATA-REC         TO  TNS-TENSU-REC
                       MOVE  SPA-NAI-YUKOSTYMD   TO  TNS-YUKOSTYMD
                       MOVE  SPA-NAI-YUKOEDYMD   TO  TNS-YUKOEDYMD
                       PERFORM  4121-KOUMOKUISO-SEC
                       MOVE  SPA-Z01-SRYCD       TO  TNSUP-SRYCD
                       MOVE  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                 TO  TNSUP-YUKOSTYMD
                       MOVE  SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                 TO  TNSUP-YUKOEDYMD
                       PERFORM  815-TENSUUPD-SEC
                       IF  MCP-RC          NOT   =   ZERO
                           MOVE    "B12"         TO  SPA-GMN-CUR
                           MOVE    "0009"        TO  SPA-ERRCD
                           PERFORM  813-TENSUCLS-SEC
                           GO                    TO  4121-TOUROKU-EXT
                       END-IF
                   ELSE
                       MOVE    "B12"             TO  SPA-GMN-CUR
                       MOVE    "0009"            TO  SPA-ERRCD
                       PERFORM  813-TENSUCLS-SEC
                       GO                        TO  4121-TOUROKU-EXT
                   END-IF
               ELSE
                   MOVE    "B12"                 TO  SPA-GMN-CUR
                   MOVE    "0009"                TO  SPA-ERRCD
                   PERFORM  813-TENSUCLS-SEC
                   GO                            TO  4121-TOUROKU-EXT
               END-IF
               PERFORM  813-TENSUCLS-SEC
           ELSE
      *        データＩＮＳＥＲＴ
               INITIALIZE                        TNS-TENSU-REC
               MOVE  SPA-Z01-SRYCD               TO  TNS-SRYCD
               MOVE  SPA-NAI-YUKOSTYMD         TO  TNS-YUKOSTYMD
               MOVE  SPA-NAI-YUKOEDYMD         TO  TNS-YUKOEDYMD
               PERFORM  4121-KOUMOKUISO-SEC
               PERFORM  814-TENSUINS-SEC
               IF  MCP-RC                   NOT  =   ZERO
                   MOVE    "B12"                 TO  SPA-GMN-CUR
                   MOVE    "0009"                TO  SPA-ERRCD
                   GO                            TO  4121-TOUROKU-EXT
               END-IF
           END-IF
      *
      *    点数マスタ付加情報更新
           PERFORM 4129-TENSUPLUS-UPD-SEC
      *
      *  入力コード更新
           CALL    "ORCGZS01"                    USING
                                                 MCPAREA
                                                 SPAAREA
           IF      SPA-ERRCD           NOT =   SPACE
               GO                          TO  4121-TOUROKU-EXT
           END-IF
      *
      *    老人一般コード変換マスタ更新
           PERFORM 41212-SRYCDCHG-UPD-SEC
      *
      *    前画面に戻る
      *
           MOVE  "JOIN"               TO  MCP-PUTTYPE
           PERFORM  401-BACK-SEC
           .
       4121-TOUROKU-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    登録処理
      *****************************************************************
       4121-KOUMOKUISO-SEC                       SECTION.
      *
           MOVE  SPA-GMN-SRYKBN          TO  TNS-SRYKBN         
           MOVE  SPA-GMN-SRYSYUKBN       TO  TNS-SRYSYUKBN      
           MOVE  SPA-GMN-DATAKBN         TO  TNS-DATAKBN        
      *
           MOVE  SPA-GMN-KANANAME        TO  TNS-KANANAME       
                                                     WRK-STRINGTBL
           MOVE  100                     TO  CNT-STRING
           PERFORM 891-STRCOUNT-SEC
           MOVE  CNT-STRING              TO  TNS-KANAYUKOKETA
           MOVE  SPA-GMN-NAME            TO  TNS-NAME           
                                                    WRK-STRINGTBL
           MOVE  100                     TO  CNT-STRING
           PERFORM  891-STRCOUNT-SEC
           MOVE  CNT-STRING              TO  TNS-YUKOKETA
      *    正式名称
           MOVE  SPA-GMN-FORMALNAME      TO  TNS-FORMALNAME           
                                                    WRK-STRINGTBL
           MOVE  200                     TO  CNT-STRING
           PERFORM  891-STRCOUNT-SEC
           MOVE  CNT-STRING              TO  TNS-FORMALYUKOKETA
      *
           MOVE  SPA-GMN-TEN             TO  TNS-TEN
      *
           MOVE  SPA-GMN-TENSIKIBETU     TO  TNS-TENSIKIBETU
           MOVE  SPA-GMN-OLDTEN          TO  TNS-OLDTEN
           MOVE  SPA-GMN-OLDTENSKB       TO  TNS-OLDTENSKB
           MOVE  SPA-GMN-TANICD          TO  TNS-TANICD
           MOVE  SPA-GMN-TANINAME        TO  TNS-TANINAME
           MOVE  SPA-GMN-HKNTEKKBN       TO  TNS-HKNTEKKBN
           MOVE  SPA-GMN-BYOKANRENKBN    TO  TNS-BYOKANRENKBN
      *
           MOVE  SPA-GMN-SDOKNRYO        TO  TNS-SDOKNRYO
           MOVE  SPA-GMN-YKZKNRKBN       TO  TNS-YKZKNRKBN
           MOVE  SPA-GMN-NYUGAITEKKBN    TO  TNS-NYUGAITEKKBN
           MOVE  SPA-GMN-ROUTEKKBN       TO  TNS-ROUTEKKBN
           MOVE  SPA-GMN-HOSPSRYKBN      TO  TNS-HOSPSRYKBN
           MOVE  SPA-GMN-OSINKBN         TO  TNS-OSINKBN
      *
           MOVE  SPA-GMN-BYOSYOKBN       TO  TNS-BYOSYOKBN
      *
           MOVE  SPA-GMN-SANTEIRRKKBN    TO  TNS-SANTEIRRKKBN
      *
           MOVE  SPA-GMN-SANTEIRRKKBN    TO  TNS-SANTEIRRKKBN
      *
           MOVE  SPA-GMN-TIMEKSNKBN      TO  TNS-TIMEKSNKBN
      *
           MOVE  SPA-GMN-GAIKANRIKBN     TO  TNS-GAIKANRIKBN
      *
           MOVE  SPA-GMN-TSUSOKUAGE      TO  TNS-TSUSOKUAGE
      *
           IF    SPA-GMN-KGNAGE            =   SPACE
               MOVE    ZERO              TO  SPA-GMN-KGNAGE
           END-IF
           MOVE  SPA-GMN-KGNAGE          TO  TNS-KGNAGE         
           IF    SPA-GMN-JGNAGE            =   SPACE
               MOVE    ZERO              TO  SPA-GMN-JGNAGE
           END-IF
           MOVE  SPA-GMN-JGNAGE          TO  TNS-JGNAGE         
           MOVE  SPA-GMN-JITUDAY         TO  TNS-JITUDAY
           MOVE  SPA-GMN-DAYCNT          TO  TNS-DAYCNT         
           MOVE  SPA-GMN-JGNCNT          TO  TNS-JGNCNT         
           MOVE  SPA-GMN-JGNCNT1D        TO  TNS-JGNCNT1D       
           MOVE  SPA-GMN-JGNCNT1W        TO  TNS-JGNCNT1W       
           MOVE  SPA-GMN-JGNCNTETCM      TO  TNS-JGNCNTETCM     
           MOVE  SPA-GMN-JGNCNTETC       TO  TNS-JGNCNTETC      
      *
           MOVE  SPA-GMN-JGNCNTERR       TO  TNS-JGNCNTERR      
           MOVE  SPA-GMN-KZMCOMPSIKIBETU TO  TNS-KZMCOMPSIKIBETU
      *
           MOVE  SPA-GMN-KZMKGN          TO  TNS-KZMKGN         
           MOVE  SPA-GMN-KZMJGN          TO  TNS-KZMJGN         
           MOVE  SPA-GMN-KZM             TO  TNS-KZM            
           MOVE  SPA-GMN-KZMTEN          TO  TNS-KZMTEN         
      *
           MOVE  SPA-GMN-KZMERR          TO  TNS-KZMERR         
      *
           MOVE  SPA-GMN-CHUKSNCD        TO  TNS-CHUKSNCD       
           MOVE  SPA-GMN-CHUKSNTSUBAN    TO  TNS-CHUKSNTUBAN    

           PERFORM  VARYING  IDXX
                    FROM  1  BY  1  UNTIL  IDXX  >  4
               MOVE  SPA-GMN-AGEKSNKGN(IDXX)   TO  TNS-AGEKSNKGN(IDXX)
               MOVE  SPA-GMN-AGEKSNJGN(IDXX)   TO  TNS-AGEKSNJGN(IDXX)
               MOVE  SPA-GMN-AGEKSNSRYCD(IDXX) TO
                                               TNS-AGEKSNSRYCD(IDXX)
           END-PERFORM
      *                                          
           MOVE  SPA-GMN-TUSOKUGAIKBN          TO  TNS-TUSOKUGAIKBN
      *
           MOVE  SPA-GMN-LASERKSN              TO  TNS-LASERKBN
      *
           MOVE  SPA-GMN-CHPMESUKSN            TO  TNS-CHPMESUKSN      
      *
           MOVE  SPA-GMN-MICMESUKSN            TO  TNS-MICMESUKSN      
      *
           MOVE  SPA-GMN-SEKIZUISOKUTEI        TO  TNS-SEKIZUISOKUTEI  
      *
           MOVE  SPA-GMN-KEIBUJYUTU            TO  TNS-KEIBUJYUTU      
      *
           MOVE  SPA-GMN-AUTOHOUGO             TO  TNS-AUTOHOUGO       
      *
           MOVE  SPA-GMN-AUTOFUNGO             TO  TNS-AUTOFUNGO       
      *
           MOVE  SPA-GMN-CHPGYOKOSOTIKSN       TO  TNS-CHPGYOKOSOTIKSN 
      *
           MOVE  SPA-GMN-SHORTSTAYOPE          TO  TNS-SHORTSTAYOPE    
      *    施設基準不適合区分
           MOVE  SPA-GMN-KIJUNTEIGENKBN        TO  TNS-KIJUNTEIGENKBN
      *     基準不適合逓減対象施設基準コード
           MOVE  SPA-GMN-KIJUNTEIGENCD         TO  TNS-KIJUNTEIGENCD
      *
           MOVE  SPA-GMN-KNSJISKBN             TO  TNS-KNSJISKBN       
      *
           MOVE  SPA-GMN-KNSJISGRPKBN          TO  TNS-KNSJISGRPKBN    
      *
           MOVE  SPA-GMN-KENTAICOMMENT         TO  TNS-KENTAICOMMENT   
      *
           MOVE  SPA-GMN-TEIGENKBN             TO  TNS-TEIGENKBN       
      *
           MOVE  SPA-GMN-HOKATUTEIGENKBN       TO  TNS-HOUKATUTEIGENKBN
      *
           MOVE  SPA-GMN-HOUKNSKBN             TO  TNS-HOUKNSKBN       
      *
           MOVE  SPA-GMN-CHPNAISIKSN           TO  TNS-CHPNAISIKSN     
      *
           MOVE  SPA-GMN-NYUKHNKBN             TO  TNS-NYUKHNKBN
      *
           MOVE  SPA-GMN-NYUKHNKSNKBN          TO  TNS-NYUKHNKSNKBN
      *
           MOVE  SPA-GMN-KANGOKSN              TO  TNS-KANGOKSN 
      *
           MOVE  SPA-GMN-CHIIKIKSN             TO  TNS-CHIIKIKSN 
      *
           PERFORM  VARYING  IDXX
                    FROM  1  BY  1  UNTIL  IDXX  >  10
               MOVE  SPA-GMN-SSTKIJUNCD(IDXX)  TO  TNS-SSTKIJUNCD
                                                           (IDXX)
           END-PERFORM
      *
           MOVE  SPA-GMN-GAITENTTLKBN          TO  TNS-GAITENTTLKBN
           MOVE  SPA-GMN-NYUTENTTLSKB          TO  TNS-NYUTENTTLKBN
           MOVE  SPA-GMN-KOUHYOJYUNNUM         TO  TNS-KOUHYOJYUNNUM
           MOVE  SPA-GMN-CDKBN-KBN             TO  TNS-CDKBN-KBN
           MOVE  SPA-GMN-CDKBN-SYO             TO  TNS-CDKBN-SYO
           MOVE  SPA-GMN-CDKBN-BU              TO  TNS-CDKBN-BU
           MOVE  SPA-GMN-CDKBN-KBNNUM          TO  TNS-CDKBN-KBNNUM
           MOVE  SPA-GMN-CDKBN-KBNNUM-EDA      TO  TNS-CDKBN-KBNNUM-EDA
           MOVE  SPA-GMN-CDKBN-KOUBAN          TO  TNS-CDKBN-KOUBAN
      *
           MOVE  SPA-GMN-KOKUCHI-KBN           TO  TNS-KOKUCHI-KBN
           MOVE  SPA-GMN-KOKUCHI-SYO           TO  TNS-KOKUCHI-SYO
           MOVE  SPA-GMN-KOKUCHI-BU            TO  TNS-KOKUCHI-BU
           MOVE  SPA-GMN-KOKUCHI-KBNNUM        TO  TNS-KOKUCHI-KBNNUM
           MOVE  SPA-GMN-KOKUCHI-KBNNUM-EDA  TO  TNS-KOKUCHI-KBNNUM-EDA
           MOVE  SPA-GMN-KOKUCHI-KOUBAN        TO  TNS-KOKUCHI-KOUBAN
      *
           MOVE  SPA-GMN-KOKUJISKBKBN1         TO  TNS-KOKUJISKBKBN1
           MOVE  SPA-GMN-KOKUJISKBKBN2         TO  TNS-KOKUJISKBKBN2 
           .    
      *
       4121-KOUMOKUISO-EXT.
           EXIT.
      *
      *****************************************************************
      *     点数マスタ付加情報更新処理
      *****************************************************************
       4129-TENSUPLUS-UPD-SEC                       SECTION.
      *
      *    点数マスタ付加情報検索
           IF      SPA-Z01-SYORIKBN    =   2  OR  3
               MOVE    SPACE               TO  TENSUPLUS-REC
               MOVE    SPA-Z01-SRYCD       TO  TNSP-SRYCD
               MOVE    SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                           TO  TNSP-YUKOSTYMD
               MOVE    SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                           TO  TNSP-YUKOEDYMD
      *
               MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC               =   ZERO
                   MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
                   PERFORM 990-TENSUPLUS-READ-SEC
               ELSE
                   MOVE    1               TO  FLG-TENSUPLUS
               END-IF
               MOVE    "DBCLOSE"           TO  MCP-FUNC
               MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           END-IF
      *
      *    有効期限更新
           IF      FLG-TENSUPLUS       =   ZERO
               EVALUATE    SPA-Z01-SYORIKBN
                   WHEN    3
      *                改正時処理
                       MOVE    WRK-SYMD            TO  TNSP-YUKOEDYMD
      *
                       MOVE    SPA-Z01-SRYCD       TO  TNSPUP-SRYCD
                       MOVE    SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                   TO  TNSPUP-YUKOSTYMD
                       MOVE    SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                   TO  TNSPUP-YUKOEDYMD
                       MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
                       MOVE    "DBUPDATE"          TO  MCP-FUNC
                       MOVE    "TENSUPLUS-UPD1"    TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"          USING
                                                    MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
                       IF      MCP-RC           NOT =   ZERO
                           MOVE    "0016"          TO  SPA-ERRCD
                           GO      TO      4129-TENSUPLUS-UPD-EXT
                       END-IF
                   WHEN    2
      *                更新時処理
                       MOVE    SPA-NAI-YUKOSTYMD   TO  TNSP-YUKOSTYMD
                       MOVE    SPA-NAI-YUKOEDYMD   TO  TNSP-YUKOEDYMD
                       PERFORM 41291-TENSUPLUS-HEN-SEC
      *
                       MOVE    SPA-Z01-SRYCD       TO  TNSPUP-SRYCD
                       MOVE    SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                   TO  TNSPUP-YUKOSTYMD
                       MOVE    SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                   TO  TNSPUP-YUKOEDYMD
                       MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
                       MOVE    "DBUPDATE"          TO  MCP-FUNC
                       MOVE    "TENSUPLUS-UPD1"    TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"          USING
                                                    MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
                       IF      MCP-RC           NOT =   ZERO
                           MOVE    "0016"          TO  SPA-ERRCD
                           GO      TO      4129-TENSUPLUS-UPD-EXT
                       END-IF
               END-EVALUATE
           END-IF
      *
      *    新規追加
           IF     (FLG-TENSUPLUS       =   1   )  OR
                  (SPA-Z01-SYORIKBN    =   3  OR  1 )
               INITIALIZE                      TENSUPLUS-REC
               MOVE    SPA-Z01-SRYCD       TO  TNSP-SRYCD
               MOVE    SPA-NAI-YUKOSTYMD   TO  TNSP-YUKOSTYMD
               MOVE    SPA-NAI-YUKOEDYMD   TO  TNSP-YUKOEDYMD
               PERFORM 41291-TENSUPLUS-HEN-SEC
               MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
               IF      MCP-RC             NOT  =   ZERO
                   MOVE    "B12"          TO  SPA-GMN-CUR
                   MOVE    "0016"         TO  SPA-ERRCD
               END-IF
           END-IF
      *
           .
       4129-TENSUPLUS-UPD-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *  点数マスタ付加情報編集
      *****************************************************************
       41291-TENSUPLUS-HEN-SEC          SECTION.
      *
      *    採血料区分
           MOVE    SPA-GMN-SAIKETUKBN      TO  TNSP-SAIKETUKBN
      *
           MOVE    SPA-GMN-INPCHKKBN       TO  TNSP-INPCHKKBN
           .
       41291-TENSUPLUS-HEN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *  老人一般コード変換マスタ更新
      *****************************************************************
       41212-SRYCDCHG-UPD-SEC          SECTION.
      *
      *    コード削除
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   5  )    OR
                              (SPA-Z90-IPNSRYCD (IDX)  =   SPACE )
               MOVE    SPA-Z90-IPNSRYCD (IDX)  TO  CHG-IPNSRYCD
               MOVE    SPA-Z90-RJNSRYCD (IDX)  TO  CHG-RJNSRYCD
      *
               MOVE    SRYCDCHG-REC        TO  MCPDATA-REC
               MOVE    "DBDELETE"          TO  MCP-FUNC
               MOVE    "SRYCDCHG-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
           END-PERFORM
      *
      *    レコード追加
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   5  )    OR
                              (SPA-Z90-SRYCDCHG (IDX)  =   SPACE )  OR
                              (SPA-ERRCD           NOT =   SPACE )
               INITIALIZE                  SRYCDCHG-REC 
               EVALUATE    SPA-GMN-ROUTEKKBN
                   WHEN    1
                       MOVE    SPA-Z01-SRYCD           TO  CHG-IPNSRYCD
                       MOVE    SPA-Z90-SRYCDCHG (IDX)  TO  CHG-RJNSRYCD
                   WHEN    2
                       MOVE    SPA-Z90-SRYCDCHG (IDX)  TO  CHG-IPNSRYCD
                       MOVE    SPA-Z01-SRYCD           TO  CHG-RJNSRYCD
               END-EVALUATE
      *
               IF      CHG-IPNSRYCD        NOT =   SPACE
      *
                   MOVE    SRYCDCHG-REC        TO  MCPDATA-REC
                   MOVE    "DBINSERT"          TO  MCP-FUNC
                   MOVE    "SRYCDCHG-KEY"      TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                    MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
                   IF      MCP-RC          NOT =   ZERO
                       MOVE    "0020"              TO  SPA-ERRCD
                   END-IF
               END-IF
           END-PERFORM
           .    
      *
       41212-SRYCDCHG-UPD-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *  　項目別エラーチェック
      *****************************************************************
       500-ERRCHK-SEC                            SECTION.
      *
           SET     IDX-GMN             TO  CNT-CHK
           MOVE    TBL-WIDGET (IDX-GMN)    TO  SPA-GMN-CUR
           MOVE    Z03-PAGENO              TO  SPA-GMN-PAGENO
      *
           EVALUATE    TBL-WIDGET (IDX-GMN)
      *        有効開始年月日チェック
               WHEN    "YUKOSTYMDCHK"
                   PERFORM  501-YUKOSTYMDCHK-SEC
      *        有効終了年月日チェック
               WHEN    "YUKOEDYMDCHK"
                   PERFORM  502-YUKOEDYMDCHK-SEC
      *        診療区分
               WHEN    "SRYKBN"
                   PERFORM 503-SRYKBN-CHK-SEC
      *        診療種別
               WHEN    "SRYSYUKBN"
                   PERFORM 504-SRYSYUKBN-CHK-SEC
      *        データ区分
               WHEN    "DATAKBN"
                   PERFORM 5041-DATAKBN-CHK-SEC
      *        カナ氏名チェック
               WHEN    "KANANAME"
                   MOVE  Z03-KANANAME            TO  SPA-GMN-KANANAME
                   MOVE    SPA-GMN-KANANAME      TO  WRK-MAE-INPUT
                   PERFORM 400-ZENCHK-SEC
                   MOVE    WRK-OUT-INPUT         TO  SPA-GMN-KANANAME
      *        氏名チェック
               WHEN    "NAME"
                   MOVE  Z03-NAME                TO  SPA-GMN-NAME
                   MOVE    SPA-GMN-NAME          TO  WRK-MAE-INPUT
                   PERFORM 400-ZENCHK-SEC
                   MOVE    WRK-OUT-INPUT         TO  SPA-GMN-NAME
      *        正式名
               WHEN    "FORMALNAME"
                   MOVE  Z03-FORMALNAME          TO  SPA-GMN-FORMALNAME
                   MOVE    SPA-GMN-FORMALNAME    TO  WRK-MAE-INPUT
                   PERFORM 400-ZENCHK-SEC
                   MOVE    WRK-OUT-INPUT         TO  SPA-GMN-FORMALNAME
      *        金額
               WHEN    "TEN"
                   MOVE   Z03-TEN                TO  SPA-GMN-TEN
      *        金額種別
               WHEN    "TENSIKIBETU"
                   MOVE  Z03-TENSIKIBETU     TO  SPA-GMN-TENSIKIBETU-G
      *        旧金額
               WHEN    "OLDTEN"
                   MOVE   Z03-OLDTEN             TO  SPA-GMN-OLDTEN
      *        旧金額種別
               WHEN    "OLDTENSKB"
                   MOVE  Z03-OLDTENSKB           TO  SPA-GMN-OLDTENSKB-G
      *        単位コード
               WHEN   "TANICD"
                   PERFORM 5012-TANICD-CHK-SEC
      *        単位名称
      ****     WHEN   "TANINAME"
      ****         MOVE  Z03-TANINAME          TO  SPA-GMN-TANINAME-G
      *        保険適用
               WHEN    "HKNTEKKBN"
                   MOVE  Z03-HKNTEKKBN     TO  SPA-GMN-HKNTEKKBN-G
      *        傷病名関連
               WHEN    "BYOKANRENKBN"
                   MOVE  Z03-BYOKANRENKBN  TO  SPA-GMN-BYOKANRENKBN-G
      *        指導管理料
               WHEN    "SDOKNRYO"
                   MOVE  Z03-SDOKNRYO      TO  SPA-GMN-SDOKNRYO-G
      *        医薬品関連
               WHEN    "YKZKNRKBN"
                   MOVE  Z03-YKZKNRKBN     TO  SPA-GMN-YKZKNRKBN-G
      *        入外適用
               WHEN    "NYUGAITEKKBN"
                   MOVE  Z03-NYUGAITEKKBN    TO  SPA-GMN-NYUGAITEKKBN-G
      *        老人適用
               WHEN    "ROUTEKKBN"
                   MOVE  Z03-ROUTEKKBN           TO  SPA-GMN-ROUTEKKBN-G
                   IF    SPA-GMN-ROUTEKKBN       =   1  OR  2  OR  ZERO
                         CONTINUE
                   ELSE
                       MOVE    "0003"            TO  SPA-ERRCD
                   END-IF
      *        病院診療所
               WHEN    "HOSPSRYKBN"
                   MOVE  Z03-HOSPSRYKBN      TO  SPA-GMN-HOSPSRYKBN-G
      *        往診
               WHEN    "OSINKBN"
                   MOVE  Z03-OSINKBN         TO  SPA-GMN-OSINKBN-G
      *        病床数
               WHEN    "BYOSYOKBN"
                   MOVE  Z03-BYOSYOKBN       TO  SPA-GMN-BYOSYOKBN
      *        算定履歴
               WHEN    "SANTEIRRKKBN"
                   MOVE  Z03-SANTEIRRKKBN    TO  SPA-GMN-SANTEIRRKKBN-G
      *        時間加算
               WHEN    "TIMEKSNKBN"
                   MOVE  Z03-TIMEKSNKBN      TO  SPA-GMN-TIMEKSNKBN-G
      *        外来管理加算
               WHEN    "GAIKANRIKBN"
                   MOVE  Z03-GAIKANRIKBN     TO  SPA-GMN-GAIKANRIKBN-G
      *        通則年齢
               WHEN    "TSUSOKUAGE"
                   MOVE  Z03-TSUSOKUAGE      TO  SPA-GMN-TSUSOKUAGE
                   IF    SPA-GMN-TSUSOKUAGE      =   0  OR  1
                       CONTINUE
                   ELSE
                       MOVE    "0025"        TO  SPA-ERRCD
                   END-IF
      *        下限年齢
               WHEN    "KGNAGE"
                   MOVE  Z03-KGNAGE          TO  SPA-GMN-KGNAGE
                   PERFORM 5026-KGNAGE-CHK-SEC
      *        上限年齢
               WHEN    "JGNAGE"
                   MOVE    Z03-JGNAGE        TO  SPA-GMN-JGNAGE
                   PERFORM 5027-JGNAGE-CHK-SEC
      *        採血料区分
               WHEN    "SAIKETUKBN"
                   MOVE    Z03-SAIKETUKBN   TO  SPA-GMN-SAIKETUKBN-G
                   PERFORM 5030-SAIKETUKBN-CHK-SEC
      *        入力チェック区分
               WHEN    "INPCHKKBN"
                   MOVE    Z03-INPCHKKBN       TO  SPA-GMN-INPCHKKBN
                   IF      SPA-ERRCD           =   SPACE
                       MOVE    1               TO  SPA-GMN-PAGENO
                   END-IF
      *
      *        実日数
               WHEN    "JITUDAY"
                   MOVE  Z03-JITUDAY             TO  SPA-GMN-JITUDAY
      *        日数・回数
               WHEN    "DAYCNT"
                   MOVE  Z03-DAYCNT              TO  SPA-GMN-DAYCNT
      *        上限回数月
               WHEN    "JGNCNT"
                   MOVE  Z03-JGNCNT              TO  SPA-GMN-JGNCNT
      *        上限回数日
               WHEN    "JGNCNT1D"
                   MOVE  Z03-JGNCNT1D            TO  SPA-GMN-JGNCNT1D
      *        上限回数週
               WHEN    "JGNCNT1W"
                   MOVE  Z03-JGNCNT1W            TO  SPA-GMN-JGNCNT1W
      *        他月数
               WHEN    "JGNCNTETCM"
                   MOVE  Z03-JGNCNTETCM          TO  SPA-GMN-JGNCNTETCM
      *        他
               WHEN    "JGNCNTETC"
                   MOVE  Z03-JGNCNTETC           TO  SPA-GMN-JGNCNTETC 
      *        上限エラー処理
               WHEN    "JGNCNTERR"
                   MOVE  Z03-JGNCNTERR           TO  SPA-GMN-JGNCNTERR
      *        きざみ値識別
               WHEN    "KZMCOMPSIKIBETU"
                   MOVE  Z03-KZMCOMPSIKIBETU     TO
                                             SPA-GMN-KZMCOMPSIKIBETU
      *        きざみ値下限値
               WHEN    "KZMKGN"
                   MOVE  Z03-KZMKGN              TO  SPA-GMN-KZMKGN
      *        きざみ値上限値
               WHEN    "KZMJGN"
                   MOVE  Z03-KZMJGN              TO  SPA-GMN-KZMJGN
      *        きざみ値
               WHEN    "KZM"
                   MOVE  Z03-KZM                 TO  SPA-GMN-KZM    
      *        きざみ値きざみ点数
               WHEN    "KZMTEN"
                   MOVE  Z03-KZMTEN              TO  SPA-GMN-KZMTEN
      *        きざみ値エラー処理
               WHEN    "KZMERR"
                   MOVE  Z03-KZMERR              TO  SPA-GMN-KZMERR
      *        注加算コード
               WHEN    "CHUKSNCD"
                   MOVE  Z03-CHUKSNCD            TO  SPA-GMN-CHUKSNCD
                   PERFORM 5042-CHUKSNCD-CHK-SEC
      *        注加算通番
               WHEN    "CHUKSNTSUBAN"
                   MOVE  Z03-CHUKSNTSUBAN      TO  SPA-GMN-CHUKSNTSUBAN
                   IF    SPA-GMN-CHUKSNTSUBAN  =   SPACE
                       MOVE    ZERO            TO  SPA-GMN-CHUKSNTSUBAN
                   END-IF
                   IF    SPA-GMN-CHUKSNTSUBAN    >=  "0"  AND  <=  "9"
                       CONTINUE
                   ELSE
                       MOVE    "0003"                TO  SPA-ERRCD
                   END-IF
      *        年齢加算
               WHEN    "AGEKSNKGN1"
                   MOVE  Z03-AGEKSNKGN1      TO  WRK-AGEKSNKGN
                   PERFORM 5044-AGEKSNKGN-CHK-SEC
                   MOVE    WRK-AGEKSNKGN     TO  SPA-GMN-AGEKSNKGN(1)
               WHEN    "AGEKSNJGN1"
                   MOVE  Z03-AGEKSNJGN1      TO  WRK-AGEKSNJGN
                   PERFORM 5045-AGEKSNJGN-CHK-SEC
                   MOVE    WRK-AGEKSNJGN     TO  SPA-GMN-AGEKSNJGN(1)
               WHEN    "AGEKSNSRYCD1"
                   MOVE  Z03-AGEKSNSRYCD1    TO  SPA-GMN-AGEKSNSRYCD(1)
               WHEN    "AGEKSNKGN2"
                   MOVE  Z03-AGEKSNKGN2      TO  WRK-AGEKSNKGN
                   PERFORM 5044-AGEKSNKGN-CHK-SEC
                   MOVE    WRK-AGEKSNKGN     TO  SPA-GMN-AGEKSNKGN(2)
               WHEN    "AGEKSNJGN2"
                   MOVE  Z03-AGEKSNJGN2      TO  WRK-AGEKSNJGN
                   PERFORM 5045-AGEKSNJGN-CHK-SEC
                   MOVE    WRK-AGEKSNJGN     TO  SPA-GMN-AGEKSNJGN(2)
               WHEN    "AGEKSNSRYCD2"
                   MOVE  Z03-AGEKSNSRYCD2    TO  SPA-GMN-AGEKSNSRYCD(2)
               WHEN    "AGEKSNKGN3"
                   MOVE  Z03-AGEKSNKGN3      TO  WRK-AGEKSNKGN
                   PERFORM 5044-AGEKSNKGN-CHK-SEC
                   MOVE    WRK-AGEKSNKGN     TO  SPA-GMN-AGEKSNKGN(3)
               WHEN    "AGEKSNJGN3"
                   MOVE  Z03-AGEKSNJGN3      TO  WRK-AGEKSNJGN
                   PERFORM 5045-AGEKSNJGN-CHK-SEC
                   MOVE    WRK-AGEKSNJGN     TO  SPA-GMN-AGEKSNJGN(3)
               WHEN    "AGEKSNSRYCD3"
                   MOVE  Z03-AGEKSNSRYCD3    TO  SPA-GMN-AGEKSNSRYCD(3)
               WHEN    "AGEKSNKGN4"
                   MOVE  Z03-AGEKSNKGN4      TO  WRK-AGEKSNKGN
                   PERFORM 5044-AGEKSNKGN-CHK-SEC
                   MOVE    WRK-AGEKSNKGN     TO  SPA-GMN-AGEKSNKGN(4)
               WHEN    "AGEKSNJGN4"
                   MOVE  Z03-AGEKSNJGN4      TO  WRK-AGEKSNJGN
                   PERFORM 5045-AGEKSNJGN-CHK-SEC
                   MOVE    WRK-AGEKSNJGN     TO  SPA-GMN-AGEKSNJGN(4)
               WHEN    "AGEKSNSRYCD4"
                   MOVE  Z03-AGEKSNSRYCD4    TO  SPA-GMN-AGEKSNSRYCD(4)
                   MOVE  2                   TO  SPA-GMN-PAGENO
      *
      *        通則加算対象外
               WHEN    "TUSOKUGAIKBN"
                   MOVE  Z03-TUSOKUGAIKBN    TO  SPA-GMN-TUSOKUGAIKBN
      *        レーザー照射
               WHEN    "LASERKSN"
                   MOVE  Z03-LASERKSN        TO  SPA-GMN-LASERKSN
      *        超音波メス
               WHEN    "CHPMESUKSN"
                   MOVE  Z03-CHPMESUKSN      TO  SPA-GMN-CHPMESUKSN
      *        マイクロ波メス
               WHEN    "MICMESUKSN"
                   MOVE  Z03-MICMESUKSN      TO  SPA-GMN-MICMESUKSN 
      *        脊髄測定
               WHEN    "SEKIZUISOKUTEI"
                   MOVE  Z03-SEKIZUISOKUTEI  TO
                                             SPA-GMN-SEKIZUISOKUTEI
      *        頸部術
               WHEN    "KEIBUJYUTU6"
                   MOVE  Z03-KEIBUJYUTU      TO  SPA-GMN-KEIBUJYUTU
      *        自動縫合器
               WHEN    "AUTOHOUGO"
                   MOVE  Z03-AUTOHOUGO       TO  SPA-GMN-AUTOHOUGO
      *        自動吻合器
               WHEN    "AUTOFUNGO"
                   MOVE  Z03-AUTOFUNGO       TO  SPA-GMN-AUTOFUNGO
      *        超音波石灰装置
               WHEN    "CHPGYOKOSOTIKSN"
                   MOVE  Z03-CHPGYOKOSOTIKSN TO
                                             SPA-GMN-CHPGYOKOSOTIKSN
      *        手術帰宅加算
               WHEN    "SHORTSTAYOPE"
                   MOVE  Z03-SHORTSTAYOPE    TO  SPA-GMN-SHORTSTAYOPE
      *        施設基準不適合区分
               WHEN    "KIJUNTEIGENKBN"
                   MOVE  Z03-KIJUNTEIGENKBN  TO  SPA-GMN-KIJUNTEIGENKBN
      *        基準不適合逓減対象施設基準コード
               WHEN    "KIJUNTEIGENCD"
                   MOVE  Z03-KIJUNTEIGENCD   TO  SPA-GMN-KIJUNTEIGENCD
      *        検査等実施判断
               WHEN    "KNSJISKBN"
                   MOVE  Z03-KNSJISKBN       TO  SPA-GMN-KNSJISKBN
      *        検査等実施判断グループ
               WHEN    "KNSJISGRPKBN"
                   MOVE  Z03-KNSJISGRPKBN    TO  SPA-GMN-KNSJISGRPKBN
      *        検体検査コメント
               WHEN    "KENTAICOMMENT"
                   MOVE  Z03-KENTAICOMMENT   TO  SPA-GMN-KENTAICOMMENT
      *        逓減対象
               WHEN    "TEIGENKBN"
                   MOVE  Z03-TEIGENKBN       TO  SPA-GMN-TEIGENKBN
      *        包括逓減
               WHEN    "HOKATUTEIGENKBN"
                   MOVE  Z03-HOKATUTEIGENKBN TO
                                             SPA-GMN-HOKATUTEIGENKBN
      *        包括対象検査
               WHEN    "HOUKNSKBN"
                   MOVE  Z03-HOUKNSKBN       TO  SPA-GMN-HOUKNSKBN
      *        超音波内視鏡
               WHEN    "CHPNAISIKSN"
                   MOVE  Z03-CHPNAISIKSN     TO  SPA-GMN-CHPNAISIKSN
      *        入院基本料区分
               WHEN    "NYUKHNKBN"
                   MOVE  Z03-NYUKHNKBN       TO  SPA-GMN-NYUKHNKBN
      *        入院基本料加算区分
               WHEN    "NYUKHNKSNKBN"
                   MOVE  Z03-NYUKHNKSNKBN    TO  SPA-GMN-NYUKHNKSNKBN
      *        看護加算
               WHEN    "KANGOKSN"
                   MOVE  Z03-KANGOKSN        TO  SPA-GMN-KANGOKSN
      *        地域加算
               WHEN    "CHIIKIKSN"
                   MOVE  Z03-CHIIKIKSN       TO  SPA-GMN-CHIIKIKSN
                   MOVE  3                   TO  SPA-GMN-PAGENO
      *
      *        施設基準コード１〜１０
               WHEN    "SSTKIJUNCD1"
                   MOVE  Z03-SSTKIJUNCD1     TO  SPA-GMN-SSTKIJUNCD(1)
               WHEN    "SSTKIJUNCD2"
                   MOVE  Z03-SSTKIJUNCD2     TO  SPA-GMN-SSTKIJUNCD(2)
               WHEN    "SSTKIJUNCD3"
                   MOVE  Z03-SSTKIJUNCD3     TO  SPA-GMN-SSTKIJUNCD(3)
               WHEN    "SSTKIJUNCD4"
                   MOVE  Z03-SSTKIJUNCD4     TO  SPA-GMN-SSTKIJUNCD(4)
               WHEN    "SSTKIJUNCD5"
                   MOVE  Z03-SSTKIJUNCD5     TO  SPA-GMN-SSTKIJUNCD(5)
               WHEN    "SSTKIJUNCD6"
                   MOVE  Z03-SSTKIJUNCD6     TO  SPA-GMN-SSTKIJUNCD(6)
               WHEN    "SSTKIJUNCD7"
                   MOVE  Z03-SSTKIJUNCD7     TO  SPA-GMN-SSTKIJUNCD(7)
               WHEN    "SSTKIJUNCD6"
                   MOVE  Z03-SSTKIJUNCD8     TO  SPA-GMN-SSTKIJUNCD(8)
               WHEN    "SSTKIJUNCD9"
                   MOVE  Z03-SSTKIJUNCD9     TO  SPA-GMN-SSTKIJUNCD(9)
               WHEN    "SSTKIJUNCD10"
                   MOVE  Z03-SSTKIJUNCD10    TO  SPA-GMN-SSTKIJUNCD(10)
      *        点数欄集計先識別（外来）
               WHEN    "GAITENTTLKBN"
                   MOVE  Z03-GAITENTTLKBN    TO  SPA-GMN-GAITENTTLKBN
      *        点数欄集計先識別（入院）
               WHEN    "NYUTENTTLSKB"
                   MOVE  Z03-NYUTENTTLSKB    TO  SPA-GMN-NYUTENTTLSKB
      *        公表順序番号
               WHEN    "KOUHYOJYUNNUM"
                   MOVE  Z03-KOUHYOJYUNNUM   TO  SPA-GMN-KOUHYOJYUNNUM
      *        コード表用番号
               WHEN    "CDKBN-KBN"
                   MOVE  Z03-CDKBN-KBN       TO  SPA-GMN-CDKBN-KBN
               WHEN    "CDKBN-SYO"
                   MOVE  Z03-CDKBN-SYO       TO  SPA-GMN-CDKBN-SYO
               WHEN    "CDKBN-BU"
                   MOVE  Z03-CDKBN-BU        TO  SPA-GMN-CDKBN-BU
               WHEN    "CDKBN-KBNNUM"
                   MOVE  Z03-CDKBN-KBNNUM    TO  SPA-GMN-CDKBN-KBNNUM
               WHEN    "CDKBN-KBNNUM-EDA"
                   MOVE  Z03-CDKBN-KBNNUM-EDA    TO
                                             SPA-GMN-CDKBN-KBNNUM-EDA
               WHEN    "CDKBN-KOUBAN"
                   MOVE  Z03-CDKBN-KOUBAN    TO  SPA-GMN-CDKBN-KOUBAN    
      *        告示・通知関連番号
               WHEN    "KOKUCHI-KBN "
                   MOVE  Z03-KOKUCHI-KBN     TO  SPA-GMN-KOKUCHI-KBN
               WHEN    "KOKUCHI-SYO"
                   MOVE  Z03-KOKUCHI-SYO     TO  SPA-GMN-KOKUCHI-SYO
               WHEN    "KOKUCHI-BU"
                   MOVE  Z03-KOKUCHI-BU      TO  SPA-GMN-KOKUCHI-BU
               WHEN    "KOKUCHI-KBNNUM"
                   MOVE  Z03-KOKUCHI-KBNNUM  TO  SPA-GMN-KOKUCHI-KBNNUM
               WHEN    "KOKUCHI-KBNNUM-EDA"
                   MOVE  Z03-KOKUCHI-KBNNUM-EDA  TO
                                             SPA-GMN-KOKUCHI-KBNNUM-EDA
               WHEN    "KOKUCHI-KOUBAN"
                   MOVE  Z03-KOKUCHI-KOUBAN  TO  SPA-GMN-KOKUCHI-KOUBAN
      *        告示等識別区分
               WHEN    "KOKUJISKBKBN1"
                   MOVE  Z03-KOKUJISKBKBN1   TO  SPA-GMN-KOKUJISKBKBN1
               WHEN    "KOKUJISKBKBN2"
                   MOVE  Z03-KOKUJISKBKBN2   TO  SPA-GMN-KOKUJISKBKBN2
       END-EVALUATE.
      *
      *    次のカーソル設定
           IF      SPA-ERRCD           =   SPACE
               SET     IDX-GMN             TO  CNT-CHK
               SET     IDX-GMN             UP  BY  1
     **********IF      IDX-GMN             >   107
               IF      IDX-GMN             >   108
                   MOVE  "B12"                   TO  SPA-GMN-CUR
               ELSE
                   MOVE    TBL-WIDGET (IDX-GMN)    TO  SPA-GMN-CUR
               END-IF
      *        採血料区分は、検査の時のみカーソル移動とする
               IF      SPA-GMN-CUR         =   "SAIKETUKBN"
                   IF      SPA-GMN-SRYKBN  NOT =   "60"
                       MOVE    TBL-WIDGET (IDX-GMN + 1) TO  SPA-GMN-CUR
                   END-IF
               END-IF
           END-IF
           .    
      *
       500-ERRCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    半角チェック処理
      *****************************************************************
       400-ZENCHK-SEC             SECTION.
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    WRK-MAE-INPUT       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   1     )
      *        全角半角混在エラー
               MOVE    "0017"              TO  SPA-ERRCD
               MOVE    WRK-MAE-INPUT       TO  WRK-OUT-INPUT 
           ELSE
               MOVE    KANACHK-OUT-INPUT   TO  WRK-OUT-INPUT 
           END-IF
           .
      *
       400-ZENCHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *  　有効開始年月日チェック
      *****************************************************************
       501-YUKOSTYMDCHK-SEC                      SECTION.
      *
           MOVE  Z03-YUKOSTYMD           TO  SPA-GMN-YUKOSTYMD
      *
           IF  SPA-GMN-YUKOSTYMD                 =  SPACE
               MOVE    "0000000"                 TO  SPA-GMN-YUKOSTYMD
           END-IF.
      *
           MOVE  SPA-GMN-YUKOSTYMD               TO  WRK-LNKYMD
           PERFORM  831-YMDCONV12-SEC
           IF      SPA-ERRCD           =   SPACE
               MOVE    WRK-SYMD            TO  SPA-NAI-YUKOSTYMD
               MOVE    WRK-LNKYMD          TO  SPA-GMN-YUKOSTYMD
           ELSE
                GO      TO      501-YUKOSTYMDCHK-EXT
           END-IF
      *****IF  STS-DAY-RC1                       =  ZERO
      *         MOVE  WRK-SYMD                   TO  SPA-NAI-YUKOSTYMD
      *    ELSE
      *         MOVE    "0004"                   TO  SPA-ERRCD
      *         GO      TO      501-YUKOSTYMDCHK-EXT
      *    END-IF
      *
      *    MOVE  SPA-NAI-YUKOSTYMD               TO  WRK-LNKYMD
      *    PERFORM  832-YMDCONV21-SEC
      *****MOVE  WRK-HENYMDG                     TO  SPA-GMN-YUKOSTYMD
           .    
      *
       501-YUKOSTYMDCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　有効終了年月日チェック
      *****************************************************************
       502-YUKOEDYMDCHK-SEC                      SECTION.
      *
           MOVE  Z03-YUKOEDYMD                   TO  SPA-GMN-YUKOEDYMD
      *
           IF  SPA-GMN-YUKOEDYMD                 =  SPACE
               MOVE   "9999999"                  TO  SPA-GMN-YUKOEDYMD
           END-IF.
      *
           MOVE  SPA-GMN-YUKOEDYMD               TO  WRK-LNKYMD
           PERFORM  831-YMDCONV12-SEC
           IF      SPA-ERRCD           =   SPACE
               MOVE    WRK-SYMD            TO  SPA-NAI-YUKOEDYMD
               MOVE    WRK-LNKYMD          TO  SPA-GMN-YUKOEDYMD
           ELSE
               GO      TO      502-YUKOEDYMDCHK-EXT
           END-IF
      *
      *****IF  STS-DAY-RC1                       =  ZERO
      *        MOVE  WRK-SYMD                    TO  SPA-NAI-YUKOEDYMD
      *    ELSE
      *        MOVE    "0004"                    TO  SPA-ERRCD
      *        GO                                TO  502-YUKOEDYMDCHK-EXT
      *    END-IF
      *
      *    MOVE  SPA-NAI-YUKOEDYMD               TO  WRK-LNKYMD
      *    PERFORM  832-YMDCONV21-SEC
      *****MOVE  WRK-HENYMDG                     TO  SPA-GMN-YUKOEDYMD
           .    
      *
       502-YUKOEDYMDCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　診療区分チェック
      *****************************************************************
       503-SRYKBN-CHK-SEC                      SECTION.
      *
           MOVE    Z03-SRYKBN          TO  SPA-GMN-SRYKBN-G
      *
           IF     (SPA-Z01-SRYCD (1:1) NOT =   "1" )  AND
                  (SPA-GMN-SRYKBN          =   SPACE)
               GO      TO  503-SRYKBN-CHK-EXT
           END-IF
      *
           SET     MSYU-IDX            TO  1
           SEARCH      MSYU-TBL-OCC    VARYING   MSYU-IDX
                   AT  END
                       MOVE    "0011"          TO  SPA-ERRCD
                   WHEN    SPA-GMN-SRYKBN      =   MSYU-SRYKBN
                                                           (MSYU-IDX)
                       CONTINUE
           END-SEARCH
      *
      *    入院のチェック
           IF      SPA-GMN-SRYKBN      =   "90"
               MOVE    SPACE           TO  SPA-ERRCD
           END-IF
      *
           .
      *
       503-SRYKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　診療種別チェック
      *****************************************************************
       504-SRYSYUKBN-CHK-SEC                      SECTION.
      *
           MOVE    Z03-SRYSYUKBN       TO  SPA-GMN-SRYSYUKBN-G
      *
           IF     (SPA-Z01-SRYCD (1:1) NOT =   "1" )  AND
                  (SPA-GMN-SRYSYUKBN       =   SPACE)
               GO      TO  504-SRYSYUKBN-CHK-EXT
           END-IF
      *
           SET     MSYU-IDX            TO  1
           SEARCH      MSYU-TBL-OCC    VARYING   MSYU-IDX
                   AT  END
                       MOVE    "0012"              TO  SPA-ERRCD
                       MOVE    SPACE               TO  WRK-SRYKBN
                   WHEN    SPA-GMN-SRYSYUKBN   =   MSYU-SRYSYUKBN 
                                                           (MSYU-IDX)
                       MOVE    MSYU-SRYKBN (MSYU-IDX)    TO  WRK-SRYKBN
           END-SEARCH
      *
      *    入院のチェック
           IF      WRK-SRYKBN          =   SPACE
               IF      SPA-GMN-SRYSYUKBN   =   "900"
                   MOVE    "90"                TO  WRK-SRYKBN
                   MOVE    SPACE               TO  SPA-ERRCD
               END-IF
           END-IF
      *
           IF      WRK-SRYKBN      NOT =   SPACE
               IF      WRK-SRYKBN      NOT =   SPA-GMN-SRYKBN
                   MOVE    WRK-SRYKBN          TO  SPA-GMN-SRYKBN
                   PERFORM VARYING     IDX     FROM    1   BY  1
                           UNTIL       IDX     >   100
                       IF      SPA-GMN-SRYKBN  =   SPA-GMN-SRYKBN-L(IDX)
                           MOVE    SPA-GMN-SRYKBNCOB (IDX)
                                               TO  SPA-GMN-SRYKBN-G
                           MOVE    100             TO  IDX
                       END-IF
                   END-PERFORM
               END-IF
           END-IF
           .
      *
       504-SRYSYUKBN-CHK-EXT.
           EXIT.
      *        
      *****************************************************************
      *  　データ区分チェック
      *****************************************************************
       5041-DATAKBN-CHK-SEC            SECTION.
      *
           MOVE    Z03-DATAKBN         TO  SPA-GMN-DATAKBN-G
           IF      SPA-GMN-DATAKBN     =   0  OR  1  OR  2
               CONTINUE
           ELSE
               MOVE    "0003"              TO  SPA-ERRCD
               GO      TO      5041-DATAKBN-CHK-EXT
           END-IF
      *
      *    時間外
           MOVE    SPACE               TO  SPA-GMN-TIMEKSNKBNCOB-G
           IF      SPA-GMN-DATAKBN     =   1  OR  ZERO
               MOVE    "0 時間外算定不可"
                                         TO  SPA-GMN-TIMEKSNKBNCOB (1)
               MOVE    "1 時間外算定可能"
                                         TO  SPA-GMN-TIMEKSNKBNCOB (2)
               MOVE    "2 初診料の休日に係る"
                                         TO  SPA-GMN-TIMEKSNKBNCOB (3)
           END-IF
           IF      SPA-GMN-DATAKBN        =   2
               MOVE    "0 時間外算定不可"
                                         TO  SPA-GMN-TIMEKSNKBNCOB (1)
               MOVE    "1 時間外加算"
                                         TO  SPA-GMN-TIMEKSNKBNCOB (2)
               MOVE    "2 休日加算"
                                         TO  SPA-GMN-TIMEKSNKBNCOB (3)
               MOVE    "3 初診料の休日加算"
                                         TO  SPA-GMN-TIMEKSNKBNCOB (4)
               MOVE    "4 深夜加算"
                                         TO  SPA-GMN-TIMEKSNKBNCOB (5)
               MOVE    "5 時間外特定加算"
                                         TO  SPA-GMN-TIMEKSNKBNCOB (6)
           END-IF
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   6
               IF      SPA-GMN-TIMEKSNKBN  =   SPA-GMN-TIMEKSNKBNCOB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-TIMEKSNKBNCOB (IDX)
                                           TO  SPA-GMN-TIMEKSNKBN-G
                   MOVE    6               TO  IDX
               END-IF
           END-PERFORM
           .
      *
       5041-DATAKBN-CHK-EXT.
           EXIT.
      *        
      *****************************************************************
      *  　単位コードチェック
      *****************************************************************
       5012-TANICD-CHK-SEC                      SECTION.
      *
           MOVE  Z03-TANICD              TO  SPA-GMN-TANICD-G
      *
           IF      SPA-GMN-TANICD      =   SPACE
               MOVE    ZERO            TO  SPA-GMN-TANICD
           END-IF
      *
           INITIALIZE                      ORCSNUMAREA
           MOVE    SPA-GMN-TANICD      TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-MINKBN     NOT =   SPACE )   OR
                  (SNUM-SYOKBN     NOT =   SPACE )
               MOVE    "0002"                  TO  SPA-ERRCD
           ELSE
               MOVE    SNUM-OUTEDT(13:3)       TO  SPA-GMN-TANICD
           END-IF
      *
           IF      SPA-GMN-TANICD      =   ZERO
               MOVE    SPACE               TO  SPA-GMN-TANINAME
               GO      TO              5012-TANICD-CHK-EXT
           END-IF
      *
           SET     MTANI-IDX           TO  1
           SEARCH      MTANI-TBL-OCC    VARYING   MTANI-IDX
                   AT  END
                       MOVE    "0013"              TO  SPA-ERRCD
                       MOVE    SPACE               TO  SPA-GMN-TANINAME
                   WHEN    SPA-GMN-TANICD      =   MTANI-TANICD 
                                                           (MTANI-IDX)
                       MOVE    MTANI-TANINAME (MTANI-IDX)
                                               TO  SPA-GMN-TANINAME
           END-SEARCH
           .
      *
       5012-TANICD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　下限年齢チェック
      *****************************************************************
       5026-KGNAGE-CHK-SEC                      SECTION.
      *
           IF      SPA-GMN-KGNAGE      =   SPACE
               MOVE    ZERO            TO  SPA-GMN-KGNAGE
           END-IF
      *
           INITIALIZE                      ORCSNUMAREA
           MOVE    SPA-GMN-KGNAGE      TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-MINKBN     NOT =   SPACE )   OR
                  (SNUM-SYOKBN     NOT =   SPACE )
               MOVE    "0002"              TO  SPA-ERRCD
           ELSE
               MOVE    SNUM-OUTEDT(14:2)       TO  SPA-GMN-KGNAGE
           END-IF
           .
      *
       5026-KGNAGE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　上限年齢チェック
      *****************************************************************
       5027-JGNAGE-CHK-SEC                      SECTION.
      *
           IF      SPA-GMN-JGNAGE      =   SPACE
               MOVE    ZERO            TO  SPA-GMN-JGNAGE
           END-IF
      *
           IF      SPA-GMN-JGNAGE      =   "AA"
               CONTINUE
           ELSE
               MOVE    SPA-GMN-JGNAGE      TO  WRK-SNUM-INX
      *
               INITIALIZE                      ORCSNUMAREA
               MOVE    SPA-GMN-JGNAGE      TO  SNUM-INX
               CALL    "ORCSNUM"           USING
                                           ORCSNUMAREA
               IF     (SNUM-RC         NOT =   ZERO  )   OR
                      (SNUM-MINKBN     NOT =   SPACE )   OR
                      (SNUM-SYOKBN     NOT =   SPACE )
                   MOVE    "0002"              TO  SPA-ERRCD
               ELSE
                   MOVE    SNUM-OUTEDT(14:2)       TO  SPA-GMN-JGNAGE
               END-IF
           END-IF
           .    
      *
       5027-JGNAGE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　注加算コードチェック処理
      *****************************************************************
       5042-CHUKSNCD-CHK-SEC                            SECTION.
      *
           IF      SPA-GMN-CHUKSNCD    =   SPACE
               MOVE    ZERO                TO  SPA-GMN-CHUKSNCD
            END-IF
      *
           INITIALIZE                      ORCSNUMAREA
           MOVE    SPA-GMN-CHUKSNCD    TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-MINKBN     NOT =   SPACE )   OR
                  (SNUM-SYOKBN     NOT =   SPACE )
               MOVE    "0002"              TO  SPA-ERRCD
           ELSE
               MOVE    SNUM-OUTEDT(12:4)       TO  SPA-GMN-CHUKSNCD
           END-IF
           .    
      *
       5042-CHUKSNCD-CHK-EXT.
      *
      *****************************************************************
      *  　上限年齢チェック
      *****************************************************************
       5044-AGEKSNKGN-CHK-SEC                      SECTION.
      *
           IF      WRK-AGEKSNKGN       =   SPACE
               MOVE    ZERO            TO  WRK-AGEKSNKGN
           END-IF
      *
           IF      WRK-AGEKSNKGN       =   "AA"
               CONTINUE
           ELSE
               INITIALIZE                      ORCSNUMAREA
               MOVE    WRK-AGEKSNKGN       TO  SNUM-INX
               CALL    "ORCSNUM"           USING
                                           ORCSNUMAREA
               IF     (SNUM-RC         NOT =   ZERO  )   OR
                      (SNUM-MINKBN     NOT =   SPACE )   OR
                      (SNUM-SYOKBN     NOT =   SPACE )
                   MOVE    "0002"              TO  SPA-ERRCD
               ELSE
                   MOVE    SNUM-OUTEDT(14:2)       TO  WRK-AGEKSNKGN
               END-IF
           END-IF
           .    
      *
       5044-AGEKSNKGN-CHK-EXT.
           EXIT.
      *****************************************************************
      *  　上限年齢チェック
      *****************************************************************
       5045-AGEKSNJGN-CHK-SEC                      SECTION.
      *
           IF      WRK-AGEKSNJGN       =   SPACE
               MOVE    ZERO            TO  WRK-AGEKSNJGN
           END-IF
      *
           IF      WRK-AGEKSNJGN       =   "AA"
               CONTINUE
           ELSE
               INITIALIZE                      ORCSNUMAREA
               MOVE    WRK-AGEKSNJGN       TO  SNUM-INX
               CALL    "ORCSNUM"           USING
                                           ORCSNUMAREA
               IF     (SNUM-RC         NOT =   ZERO  )   OR
                      (SNUM-MINKBN     NOT =   SPACE )   OR
                      (SNUM-SYOKBN     NOT =   SPACE )
                   MOVE    "0002"              TO  SPA-ERRCD
               ELSE
                   MOVE    SNUM-OUTEDT(14:2)       TO  WRK-AGEKSNJGN
               END-IF
           END-IF
           .    
      *
       5045-AGEKSNJGN-CHK-EXT.
           EXIT.
      *****************************************************************
      *  採血料区分  チェック
      *****************************************************************
       5030-SAIKETUKBN-CHK-SEC        SECTION.
      *
      *    採血料区分は、検査の時のみ入力可能
           IF      SPA-GMN-SAIKETUKBN  NOT =   0
               IF      SPA-GMN-SRYKBN      =   "60"
                   CONTINUE
               ELSE
                   MOVE    "0014"              TO  SPA-ERRCD
               END-IF
           END-IF
           .    
      *
       5030-SAIKETUKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *  　数字項目入力チェック
      *****************************************************************
       507-NUMCHK-SEC                            SECTION.
      *
      *    IF  WRK-SNUM-INX                   NOT    =   SPACE
      *        PERFORM  821-NUMCONV-SEC
      *        IF  (SNUM-RC         NOT          =  ZERO  )   OR
      *            (SNUM-MINKBN     NOT          =  SPACE )   OR
      *            (SNUM-SYOKBN     NOT          =  SPACE )
      *            MOVE  "0002"                  TO  SPA-ERRCD
      *************MOVE  MCP-WIDGET              TO  SPA-GMN-CUR
      *            MOVE  Z03-PAGENO              TO  SPA-GMN-PAGENO
      *        END-IF
      *    END-IF.
           .    
      *
       507-NUMCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　処理
      *****************************************************************
      *
      *****************************************************************
      *    点数マスタＳＥＬＥＣＴ処理（診療行為、有効期間）
      *****************************************************************
       811-TENSUSEL-SEC                          SECTION.
               MOVE  TNS-TENSU-REC               TO  MCPDATA-REC
               MOVE  TNS-YUKOSTYMD               TO  ORC-DBYMD
               MOVE  "DBSELECT"                  TO  MCP-FUNC
               MOVE  "TENSU-KEY"                 TO  ORC-DBPATH
               CALL  "ORCMCPSUB"                  USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
           .    
      *
       811-TENSUSEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタＦＥＴＣＨ処理（診療行為、有効期間）
      *****************************************************************
       812-TENSUFET-SEC                          SECTION.
               MOVE  TNS-TENSU-REC               TO  MCPDATA-REC
               MOVE  "DBFETCH"                   TO  MCP-FUNC
               MOVE  "TENSU-KEY"                 TO  ORC-DBPATH
               CALL  "ORCMCPSUB"                  USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
           .    
      *
       812-TENSUFET-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタＣＬＯＳＥ処理（診療行為、有効期間）
      *****************************************************************
       813-TENSUCLS-SEC                          SECTION.
               MOVE  TNS-TENSU-REC               TO  MCPDATA-REC
               MOVE  "DBCLOSE"                   TO  MCP-FUNC
               MOVE  "TENSU-KEY"                 TO  ORC-DBPATH
               CALL  "ORCMCPSUB"                  USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
           .    
      *
       813-TENSUCLS-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタＩＮＳ処理
      *****************************************************************
       814-TENSUINS-SEC                          SECTION.
               MOVE  TNS-TENSU-REC               TO  MCPDATA-REC
               MOVE  "DBINSERT"                  TO  MCP-FUNC
               MOVE  "TENSU-KEY"                 TO  ORC-DBPATH
               CALL  "ORCMCPSUB"                  USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
           .    
      *
       814-TENSUINS-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタＵＰＤ処理
      *****************************************************************
       815-TENSUUPD-SEC                          SECTION.
               MOVE  TNS-TENSU-REC               TO  MCPDATA-REC
               MOVE  "DBUPDATE"                  TO  MCP-FUNC
               MOVE  "TENSU-UPD1"                TO  ORC-DBPATH
               CALL  "ORCMCPSUB"                  USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
           .    
      *
       815-TENSUUPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタＤＥＬ処理
      *****************************************************************
       816-TENSUDEL-SEC                          SECTION.
               MOVE  TNS-TENSU-REC               TO  MCPDATA-REC
               MOVE  "DBDELETE"                  TO  MCP-FUNC
               MOVE  "TENSU-KEY"                 TO  ORC-DBPATH
               CALL  "ORCMCPSUB"                  USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
           .    
      *
       816-TENSUDEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ付加情報読込
      *****************************************************************
       990-TENSUPLUS-READ-SEC          SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  TENSUPLUS-REC
               MOVE    ZERO            TO  FLG-TENSUPLUS
           ELSE
               INITIALIZE                  TENSUPLUS-REC
               MOVE    1               TO  FLG-TENSUPLUS
           END-IF
           .    
      *
       990-TENSUPLUS-READ-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    数字変換処理
      *****************************************************************
      *
       821-NUMCONV-SEC                          SECTION.
      *
           INITIALIZE                            ORCSNUMAREA.
           IF      WRK-SNUM-INX        =   SPACE
               MOVE    ZERO                TO  WRK-SNUM-INX
           END-IF
           MOVE    WRK-SNUM-INX                  TO  SNUM-INX.
           CALL    "ORCSNUM"                     USING
                                                 ORCSNUMAREA.
           .    
      *
       821-NUMCONV-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付変換　処理
      *****************************************************************
      *****************************************************************
      *     対象日＋１日計算処理
      *****************************************************************
       800-DAYSET-SEC                  SECTION.
      *
           INITIALIZE                      STS-AREA-DAY
           EVALUATE    WRK-YMD
               WHEN    ZERO
                   MOVE    ZERO            TO  WRK-OTYMD
               WHEN    "99999999"
                   MOVE    ALL "9"         TO  WRK-OTYMD
               WHEN    OTHER
                   INITIALIZE                  STS-AREA-DAY
                   INITIALIZE                  LNK-DAY6-AREA
                   MOVE    "61"                TO  LNK-DAY6-IRAI
                   MOVE    WRK-YMD             TO  LNK-DAY6-KIJUN
                   MOVE    "1"                 TO  LNK-DAY6-ZOGENPTN
                   MOVE    1                   TO  LNK-DAY6-ZOGEN
                   CALL  "ORCSDAY"             USING   STS-AREA-DAY
                                                       LNK-DAY6-AREA
                  MOVE    LNK-DAY6-KEISAN      TO  WRK-OTYMD
           END-EVALUATE
      *
           .
       800-DAYSET-EXT.
           EXIT.
      *
      *****************************************************************
      *   和暦年月日→西暦年月日（機能１２）
      *****************************************************************
       831-YMDCONV12-SEC                         SECTION.
      *
           INITIALIZE                            STS-AREA-DAY
           EVALUATE  WRK-LNKYMD(1:7)
               WHEN  ZERO
                   MOVE  ZERO                    TO  WRK-SYMD
               WHEN  "9999999"
                   MOVE  ALL "9"                 TO  WRK-SYMD
               WHEN  OTHER
      *
      *************IF  WRK-LNKYMD(1:7)           NOT NUMERIC
      *                MOVE    WRK-LNKYMD(1:1)   TO  WRK-WGO
      *                MOVE    WRK-LNKYMD(2:2)   TO  WRK-WYY
      *                MOVE    WRK-LNKYMD(5:2)   TO  WRK-WMM
      *                MOVE    WRK-LNKYMD(8:2)   TO  WRK-WDD
      *                INSPECT  WRK-WYMD  REPLACING   ALL " " BY  "0"
      *            ELSE
      *                MOVE    WRK-LNKYMD(1:7)   TO  WRK-WYMD
      *            END-IF
      *            INITIALIZE                    LNK-DAY1-AREA
      *            MOVE  "12"                    TO  LNK-DAY1-IRAI
      *            MOVE  ZERO                    TO  LNK-DAY1-YMD
      *            MOVE  WRK-WYMD                TO  LNK-DAY1-YMD(2:7)
      *            CALL  "ORCSDAY"               USING   STS-AREA-DAY
      *                                          LNK-DAY1-AREA
      *            IF      STS-DAY-RC1           =   ZERO
      *                MOVE    LNK-DAY1-YMD        TO  WRK-SYMD
      *************END-IF
      *----(01.00.01) LINE ADD START --------------------------------
      *            日付画面チェックサブ
                   INITIALIZE                      ORCSGDAYAREA
                   MOVE    WRK-LNKYMD          TO  SGDAY-INDAY
                   CALL    "ORCSGDAY"          USING
                                               ORCSGDAYAREA
                   IF      SGDAY-RC            =   ZERO
                       MOVE    SGDAY-OTDAY         TO  WRK-LNKYMD
                       MOVE    SGDAY-SDAY          TO  WRK-SYMD
                   ELSE
                       MOVE    "0004"              TO  SPA-ERRCD
                   END-IF
      *----(01.00.01) LINE ADD END   --------------------------------
           END-EVALUATE
           .    
      *
       831-YMDCONV12-EXT.
           EXIT.
      *
      *****************************************************************
      *   西暦→和暦（機能２１）
      *****************************************************************
       832-YMDCONV21-SEC                          SECTION.
      *
      *
           INITIALIZE                            STS-AREA-DAY
           EVALUATE  WRK-LNKYMD(1:8)
               WHEN  ZERO 
               WHEN  "99999999"
                   MOVE    WRK-LNKYMD            TO  WRK-HENYMDG
               WHEN  OTHER
                  INITIALIZE                     STS-AREA-DAY
                  INITIALIZE                     LNK-DAY2-AREA
                  MOVE  "21"                     TO  LNK-DAY2-IRAI
                  MOVE  WRK-LNKYMD(1:8)          TO  LNK-DAY2-YMD
                  CALL  "ORCSDAY"                USING   STS-AREA-DAY
                                                 LNK-DAY2-AREA
                  MOVE    LNK-DAY2-EDTYMD1       TO  WRK-HENYMDG
           END-EVALUATE
           .    
      *
       832-YMDCONV21-EXT.
           EXIT.
      *
      *****************************************************************
      *   西暦→日数１日マイナス（機能６１）
      *****************************************************************
       833-YMDCONV61-SEC                          SECTION.
      *
           INITIALIZE                            STS-AREA-DAY
           EVALUATE  WRK-LNKYMD(1:8)
               WHEN  ZERO
                   MOVE  ZERO                    TO  WRK-SYMD
               WHEN  "99999999"
                   MOVE  ALL "9"                 TO  WRK-SYMD
               WHEN  OTHER
                  INITIALIZE                     STS-AREA-DAY
                  INITIALIZE                     LNK-DAY6-AREA
                  MOVE  "61"                     TO  LNK-DAY6-IRAI
                  MOVE  WRK-LNKYMD(1:8)          TO  LNK-DAY6-KIJUN
                  MOVE  "1"                      TO  LNK-DAY6-ZOGENPTN
                  MOVE  -1                       TO  LNK-DAY6-ZOGEN
                  CALL  "ORCSDAY"                USING   STS-AREA-DAY
                                                 LNK-DAY6-AREA
                  MOVE    LNK-DAY6-KEISAN        TO  WRK-SYMD
           END-EVALUATE
           .    
      *
       833-YMDCONV61-EXT.
           EXIT.
      *
      *****************************************************************
      *   文字数カウント処理（全角のみ）
      *****************************************************************
       891-STRCOUNT-SEC                         SECTION.
      *
           PERFORM  UNTIL  WRK-STRING(CNT-STRING)  NOT  =  SPACE
                    OR  CNT-STRING  =  1
               COMPUTE  CNT-STRING  =  CNT-STRING  -  1
           END-PERFORM
      *
           IF  CNT-STRING                        =  1
               MOVE  ZERO                        TO  CNT-STRING
           ELSE
               COMPUTE  CNT-STRING               =  CNT-STRING  /  2
           END-IF
           .    
       891-STRCOUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW                            SECTION.
      *
           MOVE   "PUTWINDOW"                    TO  MCP-FUNC.
           CALL   "ORCMCPSUB"                     USING  MCPAREA
                                                         ORCMCPAREA
                                                         MCPDATA-REC.
      *
       900-PUT-WINDOW-EXT.
           EXIT.
      *
