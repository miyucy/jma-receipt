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
      ************************************************************
      *    新収納マスタ         COPY (CPSYUMAIN.INC)             *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  SYUMAIN-REC.
           03  SYUMAIN-KEY.
      *医療機関ＩＤ
               05  SYUMAIN-HOSPNUM          PIC 9(2).
      *入外区分
               05  SYUMAIN-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  SYUMAIN-PTID            PIC  9(10).
      *伝票番号
               05  SYUMAIN-DENPNUM         PIC  9(07).
      *伝票枝番最終番号
           03  SYUMAIN-DENPLASTNUM         PIC  9(02).
      *診療科
           03  SYUMAIN-SRYKA               PIC  X(02).
      *診療日
           03  SYUMAIN-SRYYMD              PIC  X(08).
      *伝票状態区分
           03  SYUMAIN-DENPJTIKBN          PIC  X(01).
      *伝票作成区分（空白：外来　１：退院時作成　２：定期請求
      *              ３：入院レセプト用ダミー）
           03  SYUMAIN-CREATEKBN           PIC  X(01).
      *伝票発行日
           03  SYUMAIN-DENPPRTYMD          PIC  X(08).
      *請求期間
           03  SYUMAIN-SKY-KIKAN.
      *請求開始日
               05  SYUMAIN-SKYSTYMD        PIC  X(08).
      *請求終了日
               05  SYUMAIN-SKYEDYMD        PIC  X(08).
      *保険組合せ番号
           03  SYUMAIN-HKNCOMBINUM         PIC  X(04).
      *主保険−保険番号
           03  SYUMAIN-SYUHKNNUM           PIC  X(03).
      *主保険−患者負担金額
           03  SYUMAIN-SYUHKNFTNMONEY      PIC S9(07).
      *主保険−計算負担金
           03  SYUMAIN-SYUCOMPFTN          PIC S9(07).
      *主保険−計算負担金（円単位記録用）
           03  SYUMAIN-SYUCOMPFTN-ENTANI   PIC S9(07)V9(01).
      *主保険−計算薬剤一部負担金
           03  SYUMAIN-SYUCOMPYKZFTN       PIC S9(07).
      *主保険−計算負担金計
           03  SYUMAIN-SYUCOMPTOTAL        PIC S9(07).
      *主保険−薬剤負担区分
           03  SYUMAIN-SYUYKZFTNKBN        PIC  X(01).
      *公費−負担情報
           03  SYUMAIN-KOH-AREA.
      *公費１−保険番号
               05  SYUMAIN-KOH1HKNNUM          PIC  X(03).
      *公費１−患者負担金額
               05  SYUMAIN-KOH1HKNFTNMONEY     PIC S9(07).
      *公費１−計算負担金
               05  SYUMAIN-KOH1COMPFTN         PIC S9(07).
      *公費１−計算負担金（円単位記録用）
               05  SYUMAIN-KOH1COMPFTN-ENTANI  PIC S9(07)V9(01).
      *公費１−計算薬剤一部負担金
               05  SYUMAIN-KOH1COMPYKZFTN      PIC S9(07).
      *公費１−計算負担金計
               05  SYUMAIN-KOH1COMPTOTAL       PIC S9(07).
      *公費１−薬剤負担区分
               05  SYUMAIN-KOH1YKZFTNKBN       PIC  X(01).
      *公費２−保険番号
               05  SYUMAIN-KOH2HKNNUM          PIC  X(03).
      *公費２−患者負担金額
               05  SYUMAIN-KOH2HKNFTNMONEY     PIC S9(07).
      *公費２−計算負担金
               05  SYUMAIN-KOH2COMPFTN         PIC S9(07).
      *公費２−計算負担金（円単位記録用）
               05  SYUMAIN-KOH2COMPFTN-ENTANI  PIC S9(07)V9(01).
      *公費２−計算薬剤一部負担金
               05  SYUMAIN-KOH2COMPYKZFTN      PIC S9(07).
      *公費２−計算負担金計
               05  SYUMAIN-KOH2COMPTOTAL       PIC S9(07).
      *公費２−薬剤負担区分
               05  SYUMAIN-KOH2YKZFTNKBN       PIC  X(01).
      *公費３−保険番号
               05  SYUMAIN-KOH3HKNNUM          PIC  X(03).
      *公費３−患者負担金額
               05  SYUMAIN-KOH3HKNFTNMONEY     PIC S9(07).
      *公費３−計算負担金
               05  SYUMAIN-KOH3COMPFTN         PIC S9(07).
      *公費３−計算負担金（円単位記録用）
               05  SYUMAIN-KOH3COMPFTN-ENTANI  PIC S9(07)V9(01).
      *公費３−計算薬剤一部負担金
               05  SYUMAIN-KOH3COMPYKZFTN      PIC S9(07).
      *公費３−計算負担金計
               05  SYUMAIN-KOH3COMPTOTAL       PIC S9(07).
      *公費３−薬剤負担区分
               05  SYUMAIN-KOH3YKZFTNKBN       PIC  X(01).
      *公費４−保険番号
               05  SYUMAIN-KOH4HKNNUM          PIC  X(03).
      *公費４−患者負担金額
               05  SYUMAIN-KOH4HKNFTNMONEY     PIC S9(07).
      *公費４−計算負担金
               05  SYUMAIN-KOH4COMPFTN         PIC S9(07).
      *公費４−計算負担金（円単位記録用）
               05  SYUMAIN-KOH4COMPFTN-ENTANI  PIC S9(07)V9(01).
      *公費４−計算薬剤一部負担金
               05  SYUMAIN-KOH4COMPYKZFTN      PIC S9(07).
      *公費４−計算負担金計
               05  SYUMAIN-KOH4COMPTOTAL       PIC S9(07).
      *公費４−薬剤負担区分
               05  SYUMAIN-KOH4YKZFTNKBN       PIC  X(01).
      *公費負担情報再定義
           03  SYUMAIN-KOHFTN-TABLE  REDEFINES   SYUMAIN-KOH-AREA.
               05  SYUMAIN-KOHFTN-TBL          OCCURS  4.
      *公費−保険番号
                 07  SYUMAIN-KOH-HKNNUM          PIC  X(03).
      *公費−患者負担金額
                 07  SYUMAIN-KOH-HKNFTNMONEY     PIC S9(07).
      *公費−計算負担金
                 07  SYUMAIN-KOH-COMPFTN         PIC S9(07).
      *公費−計算負担金（円単位記録用）
                 07  SYUMAIN-KOH-COMPFTN-ENTANI  PIC S9(07)V9(01).
      *公費−計算薬剤一部負担金
                 07  SYUMAIN-KOH-COMPYKZFTN      PIC S9(07).
      *公費−計算負担金計
                 07  SYUMAIN-KOH-COMPTOTAL       PIC S9(07).
      *公費−薬剤負担区分
                 07  SYUMAIN-KOH-YKZFTNKBN       PIC  X(01).
      *患者負担率
           03  SYUMAIN-PTFTNRATE           PIC  9(03).
      *請求書作成区分
           03  SYUMAIN-SKYKUKBN            PIC  X(01).
      *消費税対象金額
           03  SYUMAIN-TAX-TAISHOU         PIC S9(07).
      *消費税（内税）
           03  SYUMAIN-TAX-MONEY           PIC S9(07).
      *消費税（合計）
           03  SYUMAIN-SKYGK               PIC S9(07).
      *請求内容
           03  SYUMAIN-SKY-NAIYOU.
               05  SYUMAIN-SKY-TBL             OCCURS   17.
      *    保険点数
                   09  SYUMAIN-HKNTEN          PIC S9(07).
      *    金額
                   09  SYUMAIN-MONEY           PIC S9(07).
      *    適用外金額
                   09  SYUMAIN-TGMONEY         PIC S9(07).
      *    適用外金額（消費税あり）
                   09  SYUMAIN-TGMONEY-TAX     PIC S9(07).
      *請求内容
           03  SYUMAIN-SKY-NAIYOU-R    REDEFINES   SYUMAIN-SKY-NAIYOU.
      *診療料(01)
              05  SYUMAIN-SSU.
                  09  SYUMAIN-SSU-HKNTEN          PIC S9(07).
                  09  SYUMAIN-SSU-MONEY           PIC S9(07).
                  09  SYUMAIN-SSU-TGMONEY         PIC S9(07).
                  09  SYUMAIN-SSU-TGMONEY-TAX     PIC S9(07).
      *指導料(02)
              05  SYUMAIN-SDO.
                  09  SYUMAIN-SDO-HKNTEN          PIC S9(07).
                  09  SYUMAIN-SDO-MONEY           PIC S9(07).
                  09  SYUMAIN-SDO-TGMONEY         PIC S9(07).
                  09  SYUMAIN-SDO-TGMONEY-TAX     PIC S9(07).
      *在宅料(03)
              05  SYUMAIN-ZTK.
                  09  SYUMAIN-ZTK-HKNTEN          PIC S9(07).
                  09  SYUMAIN-ZTK-MONEY           PIC S9(07).
                  09  SYUMAIN-ZTK-TGMONEY         PIC S9(07).
                  09  SYUMAIN-ZTK-TGMONEY-TAX     PIC S9(07).
      *投薬料(04)
              05  SYUMAIN-TYK.
                  09  SYUMAIN-TYK-HKNTEN          PIC S9(07).
                  09  SYUMAIN-TYK-MONEY           PIC S9(07).
                  09  SYUMAIN-TYK-TGMONEY         PIC S9(07).
                  09  SYUMAIN-TYK-TGMONEY-TAX     PIC S9(07).
      *注射料(05)
              05  SYUMAIN-CSY.
                  09  SYUMAIN-CSY-HKNTEN          PIC S9(07).
                  09  SYUMAIN-CSY-MONEY           PIC S9(07).
                  09  SYUMAIN-CSY-TGMONEY         PIC S9(07).
                  09  SYUMAIN-CSY-TGMONEY-TAX     PIC S9(07).
      *処置料(06)
              05  SYUMAIN-SYC.
                  09  SYUMAIN-SYC-HKNTEN          PIC S9(07).
                  09  SYUMAIN-SYC-MONEY           PIC S9(07).
                  09  SYUMAIN-SYC-TGMONEY         PIC S9(07).
                  09  SYUMAIN-SYC-TGMONEY-TAX     PIC S9(07).
      *手術料(07)
              05  SYUMAIN-SJT.
                  09  SYUMAIN-SJT-HKNTEN          PIC S9(07).
                  09  SYUMAIN-SJT-MONEY           PIC S9(07).
                  09  SYUMAIN-SJT-TGMONEY         PIC S9(07).
                  09  SYUMAIN-SJT-TGMONEY-TAX     PIC S9(07).
      *麻酔(08)
              05  SYUMAIN-MSI.
                  09  SYUMAIN-MSI-HKNTEN          PIC S9(07).
                  09  SYUMAIN-MSI-MONEY           PIC S9(07).
                  09  SYUMAIN-MSI-TGMONEY         PIC S9(07).
                  09  SYUMAIN-MSI-TGMONEY-TAX     PIC S9(07).
      *検査料(09)
              05  SYUMAIN-KNS.
                  09  SYUMAIN-KNS-HKNTEN          PIC S9(07).
                  09  SYUMAIN-KNS-MONEY           PIC S9(07).
                  09  SYUMAIN-KNS-TGMONEY         PIC S9(07).
                  09  SYUMAIN-KNS-TGMONEY-TAX     PIC S9(07).
      *Ｘ線料(10)
              05  SYUMAIN-GZU.
                  09  SYUMAIN-GZU-HKNTEN          PIC S9(07).
                  09  SYUMAIN-GZU-MONEY           PIC S9(07).
                  09  SYUMAIN-GZU-TGMONEY         PIC S9(07).
                  09  SYUMAIN-GZU-TGMONEY-TAX     PIC S9(07).
      *リハ(11)
              05  SYUMAIN-ETC.
                  09  SYUMAIN-ETC-HKNTEN          PIC S9(07).
                  09  SYUMAIN-ETC-MONEY           PIC S9(07).
                  09  SYUMAIN-ETC-TGMONEY         PIC S9(07).
                  09  SYUMAIN-ETC-TGMONEY-TAX     PIC S9(07).
      *精神科専門療法(12)
              05  SYUMAIN-SSN.
                  09  SYUMAIN-SSN-HKNTEN          PIC S9(07).
                  09  SYUMAIN-SSN-MONEY           PIC S9(07).
                  09  SYUMAIN-SSN-TGMONEY         PIC S9(07).
                  09  SYUMAIN-SSN-TGMONEY-TAX     PIC S9(07).
      *放射線(13)
              05  SYUMAIN-HOU.
                  09  SYUMAIN-HOU-HKNTEN          PIC S9(07).
                  09  SYUMAIN-HOU-MONEY           PIC S9(07).
                  09  SYUMAIN-HOU-TGMONEY         PIC S9(07).
                  09  SYUMAIN-HOU-TGMONEY-TAX     PIC S9(07).
      *病理診断(14)
              05  SYUMAIN-BYR.
                  09  SYUMAIN-BYR-HKNTEN          PIC S9(07).
                  09  SYUMAIN-BYR-MONEY           PIC S9(07).
                  09  SYUMAIN-BYR-TGMONEY         PIC S9(07).
                  09  SYUMAIN-BYR-TGMONEY-TAX     PIC S9(07).
      *入院料(15)
              05  SYUMAIN-NYN.
                  09  SYUMAIN-NYN-HKNTEN          PIC S9(07).
                  09  SYUMAIN-NYN-MONEY           PIC S9(07).
                  09  SYUMAIN-NYN-TGMONEY         PIC S9(07).
                  09  SYUMAIN-NYN-TGMONEY-TAX     PIC S9(07).
      *療養担当手当(16)
              05  SYUMAIN-RYO.
                  09  SYUMAIN-RYO-HKNTEN          PIC S9(07).
                  09  SYUMAIN-RYO-MONEY           PIC S9(07).
                  09  SYUMAIN-RYO-TGMONEY         PIC S9(07).
                  09  SYUMAIN-RYO-TGMONEY-TAX     PIC S9(07).
      *合計  (17)
              05  SYUMAIN-TOTAL.
                  09  SYUMAIN-TOTAL-HKNTEN        PIC S9(07).
                  09  SYUMAIN-TOTAL-MONEY         PIC S9(07).
                  09  SYUMAIN-TOTAL-TGMONEY       PIC S9(07).
                  09  SYUMAIN-TOTAL-TGMONEY-TAX   PIC S9(07).
      *処方せん料再掲
           03  SYUMAIN-SHOHOU-SAI                 PIC S9(07).
      *保険適用外金額−消費税（再掲）
           03  SYUMAIN-TGMONEY-TAX-SAI         PIC S9(07).
      *自費１から１０
           03  SYUMAIN-JIHI-NAIYOU.
               05  SYUMAIN-JIHI-1              PIC S9(07). 
               05  SYUMAIN-JIHI-1-TAX          PIC S9(07). 
               05  SYUMAIN-JIHI-2              PIC S9(07). 
               05  SYUMAIN-JIHI-2-TAX          PIC S9(07). 
               05  SYUMAIN-JIHI-3              PIC S9(07). 
               05  SYUMAIN-JIHI-3-TAX          PIC S9(07). 
               05  SYUMAIN-JIHI-4              PIC S9(07). 
               05  SYUMAIN-JIHI-4-TAX          PIC S9(07). 
               05  SYUMAIN-JIHI-5              PIC S9(07). 
               05  SYUMAIN-JIHI-5-TAX          PIC S9(07). 
               05  SYUMAIN-JIHI-6              PIC S9(07). 
               05  SYUMAIN-JIHI-6-TAX          PIC S9(07). 
               05  SYUMAIN-JIHI-7              PIC S9(07). 
               05  SYUMAIN-JIHI-7-TAX          PIC S9(07). 
               05  SYUMAIN-JIHI-8              PIC S9(07). 
               05  SYUMAIN-JIHI-8-TAX          PIC S9(07). 
               05  SYUMAIN-JIHI-9              PIC S9(07). 
               05  SYUMAIN-JIHI-9-TAX          PIC S9(07). 
               05  SYUMAIN-JIHI-10             PIC S9(07). 
               05  SYUMAIN-JIHI-10-TAX         PIC S9(07). 
           03  SYUMAIN-JIHI-NAIYOU-R   REDEFINES  SYUMAIN-JIHI-NAIYOU.
               05  SYUMAIN-JIHI-TBL            OCCURS   10.
                 07  SYUMAIN-JIHI-TAXNASI        PIC S9(07).
                 07  SYUMAIN-JIHI-TAXARI         PIC S9(07).
      *自費小計（消費税なし）
           03  SYUMAIN-JIHI-TOTAL          PIC S9(07).
      *自費小計（消費税あり）
           03  SYUMAIN-JIHI-TOTAL-TAX      PIC S9(07).
      *自費金額消費税
           03  SYUMAIN-JIHI-TAX            PIC S9(07).
      *老人一部負担金
           03  SYUMAIN-RJN-FTN             PIC S9(07).
      *公費一部負担金
           03  SYUMAIN-KOH-FTN             PIC S9(07).
      *公費一部負担金（円単位）
           03  SYUMAIN-KOH-FTN-ENTANI      PIC S9(07)V9(01).
      *薬剤一部負担金
           03  SYUMAIN-YKZ-FTN             PIC S9(07).
      *レセプト出力用薬剤一部負担金
           03  SYUMAIN-RESE-YKZ-FTN        PIC S9(07).
      *公費対象薬剤区分
           03  SYUMAIN-KOHTAIYKZKBN        PIC  X(01).
      *調整金
           03  SYUMAIN-CHOSEI              PIC S9(07).
           03  SYUMAIN-CHOSEI-NAIYOU.
      *調整金内訳１
               05  SYUMAIN-CHOSEI1         PIC S9(07).
      *調整金内訳２
               05  SYUMAIN-CHOSEI2         PIC S9(07).
           03  SYUMAIN-CHOSEI-NAIYOU-R REDEFINES  SYUMAIN-CHOSEI-NAIYOU.
               05  SYUMAIN-RCHOSEI         PIC S9(07)
                                           OCCURS  2.
      *まとめ入力伝票番号
           03  SYUMAIN-GRP-DENPNUM         PIC 9(07).
      *まとめ入力連番
           03  SYUMAIN-GRP-RENNUM          PIC 9(02).
      *まとめ入力差額
           03  SYUMAIN-GRP-SGKMONEY        PIC S9(07).
      *まとめ発行方法フラグ
           03  SYUMAIN-GRP-HAKHOUFLG       PIC  9(01).
      *保証金額
           03  SYUMAIN-SECMONEY            PIC S9(07).
      *保険適用金額
           03  SYUMAIN-HKNTEKMONEY         PIC S9(07).
      *病院減免事由区分
           03  SYUMAIN-DISCOUNT-KBN        PIC  X(02).
      *病院減免事由
           03  SYUMAIN-DISCOUNT-BODY       PIC  X(160).
      *割引率区分
           03  SYUMAIN-DISCOUNT-RATEKBN    PIC  X(02).
      *定率定額区分
           03  SYUMAIN-DISCOUNT-TEIRITU    PIC  X(01).
      *割引率
           03  SYUMAIN-DISCOUNT-RATE       PIC S9(07).
      *減免金額
           03  SYUMAIN-DISCOUNT-MONEY      PIC S9(07).
      *労災保険−初診料
           03  SYUMAIN-RSISHOSHIN-MONEY    PIC S9(07).
      *労災保険−再診料
           03  SYUMAIN-RSISAISHIN-MONEY    PIC S9(07).
      *労災保険−指導料
           03  SYUMAIN-RSISDO-MONEY        PIC S9(07).
      *労災保険−その他
           03  SYUMAIN-RSIETC-MONEY        PIC S9(07).
      *労災保険−消費税（再掲）
           03  SYUMAIN-RSI-TAX-SAI         PIC S9(07).
      *労災保険−患者請求分円建て合計額
           03  SYUMAIN-RSI-TOTAL           PIC S9(07).
      *労災自賠−請求金額（日計表記載用）
           03  SYUMAIN-RSIJIBAI-SKYMONEY   PIC S9(07).
      *請求金額−消費税（再掲）
           03  SYUMAIN-SKYMONEY-TAX-SAI    PIC S9(07).
      *請求金額
           03  SYUMAIN-SKYMONEY            PIC S9(07).
      *入金合計額
           03  SYUMAIN-NYUKIN-TOTAL        PIC S9(07).
      *入金回数
           03  SYUMAIN-NYUKIN-KAISU        PIC S9(07).
      *未収理由
           03  SYUMAIN-MISYURIYU           PIC  X(02).
      *ドクター
           03  SYUMAIN-DRCD-G.
               05  SYUMAIN-DRCD-SIK            PIC  X(01).
               05  SYUMAIN-DRCD                PIC  X(04).
      *入院初診回数
           03  SYUMAIN-NYNSHOKAISU         PIC S9(02).
      *薬剤発券番号
           03  SYUMAIN-YKZKENNUM           PIC  9(05).
      *食事負担（負担額別管理用）
           03  SYUMAIN-SKJ-PTFTN           OCCURS 3.
               05  SYUMAIN-SKJ-FTNGAKU     PIC S9(05).
               05  SYUMAIN-SKJ-FTNDAY      PIC S9(02).
      *再計算区分
           03  SYUMAIN-SAIKEISANKBN        PIC  X(01).
      *院外処方区分
           03  SYUMAIN-INGAISHOHOKBN       PIC  X(01).
      *同時診療伝票番号
           03  SYUMAIN-DOUJI-DENPNUM       PIC  9(07).
      *継続区分
           03  SYUMAIN-CONTKBN             PIC  X(01).
      *複数科まとめ識別伝票番号
           03  SYUMAIN-FUKU-DENPNUM        PIC  9(07).
      *複数科まとめ区分（１：継続　２：確定）
           03  SYUMAIN-FUKU-KBN            PIC  X(01).
      *在総診区分
           03  SYUMAIN-ZAITAKU             PIC  X(01).
      *診療区分別給付外点数
           03  SYUMAIN-KYUFUGAI.
               05  SYUMAIN-KYUFUGAI-TBL          OCCURS   6.
      *    給付対象外点数
                   09  SYUMAIN-KYUFUGAI-TEN      PIC S9(07).
      *診療区分別給付外点数再定義
           03  SYUMAIN-KYUFUGAI-R      REDEFINES   SYUMAIN-KYUFUGAI.
      *給付対象外点数（初診）
              05  SYUMAIN-KYUFUGAI-SHOSHIN-TEN    PIC S9(07).
      *給付対象外点数（指導）
              05  SYUMAIN-KYUFUGAI-SIDOU-TEN      PIC S9(07).
      *給付対象外点数（往診）
              05  SYUMAIN-KYUFUGAI-OSIN1-TEN      PIC S9(07).
      *給付対象外点数（往診／夜間）
              05  SYUMAIN-KYUFUGAI-OSIN2-TEN      PIC S9(07).
      *給付対象外点数（往診／深夜／緊急）
              05  SYUMAIN-KYUFUGAI-OSIN3-TEN      PIC S9(07).
      *給付対象外点数（合計）
              05  SYUMAIN-KYUFUGAI-GOKEI-TEN      PIC S9(07).
      *日別収納フラグ
           03  SYUMAIN-DAYINFFLG           PIC  X(01).
      *分娩管理フラグ
           03  SYUMAIN-BUNBENINFFLG        PIC  X(01).
      *会計変更区分
           03  SYUMAIN-ACCT-UPDKBN         PIC  X(01).
      *変則助成−患者負担金額
           03  SYUMAIN-JYO-HKNFTNMONEY     PIC S9(07).
      *変則助成−計算負担金
           03  SYUMAIN-JYO-COMPFTN         PIC S9(07).
      *変則助成−計算負担金（円単位記録用）
           03  SYUMAIN-JYO-COMPFTN-ENTANI  PIC S9(07)V9(01).
      *請求入金区分（０：請求金額＝入金合計額／１：請求金額≠入金合計額）
           03  SYUMAIN-SKYNYUKINKBN        PIC  X(01).
      *保険適用区分
           03  SYUMAIN-HKNTEKKBN           PIC  X(01).
      *端末ＩＤ
           03  SYUMAIN-TERMID              PIC  X(16).
      *オペーレータＩＤ
           03  SYUMAIN-OPID                PIC  X(16).
      *作成年月日
           03  SYUMAIN-CREYMD              PIC  X(08).
      *更新年月日
           03  SYUMAIN-UPYMD               PIC  X(08).
      *更新時間
           03  SYUMAIN-UPHMS               PIC  X(06).
      *
      *診療年月日（検索用）
           03  SYUMAIN-UPSRYYMD            PIC  X(08).
      *
      *入院履歴番号
           03  SYUMAIN-SELNYUIN-RRKNUM     PIC  9(03).
      *診療年月日（検索用）
           03  SYUMAIN-SELKOHID            PIC  9(10).
      *入外区分（検索用）
           03  SYUMAIN-SELNYUGAIKBN        PIC  X(01).
