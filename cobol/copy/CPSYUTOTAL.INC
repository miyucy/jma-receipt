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
      *    収納合計マスタ         COPY (CPSYUTOTAL.INC)       *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-小豆沢   05/07/13  自費項目の追加
      *                                      減免金額の追加
      *                                      変則助成項目の追加
      *  01.00.02    NACL-小豆沢   06/07/06  部別の項目追加
      ************************************************************
      *01  SYUTTL-REC.
           03  SYUTTL-KEY.
      *医療機関ＩＤ
               05  SYUTTL-HOSPNUM          PIC 9(2).
      *入外区分
               05  SYUTTL-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  SYUTTL-PTID            PIC  9(10).
      *伝票番号
               05  SYUTTL-DENPNUM         PIC  9(07).
      *診療科（合計分の為００で固定）
           03  SYUTTL-SRYKA               PIC  X(02).
      *同時入力診療科
           03  SYUTTL-DOUJI-SRYKA         PIC  X(02)
                                          OCCURS  10.
      *診療日
           03  SYUTTL-SRYYMD              PIC  X(08).
      *伝票状態区分
           03  SYUTTL-DENPJTIKBN          PIC  X(01).
      *伝票作成区分（空白：外来　１：退院時作成　２：定期請求
      *              ３：入院レセプト用ダミー）
           03  SYUTTL-CREATEKBN           PIC  X(01).
      *伝票発行日
           03  SYUTTL-DENPPRTYMD          PIC  X(08).
      *請求期間
           03  SYUTTL-SKY-KIKAN.
      *請求開始日
               05  SYUTTL-SKYSTYMD        PIC  X(08).
      *請求終了日
               05  SYUTTL-SKYEDYMD        PIC  X(08).
      *保険組合せ番号
           03  SYUTTL-HKNCOMBINUM         PIC  X(04).
      *主保険−保険番号
           03  SYUTTL-SYUHKNNUM           PIC  X(03).
      *主保険−患者負担金額
           03  SYUTTL-SYUHKNFTNMONEY      PIC S9(07).
      *主保険−計算負担金
           03  SYUTTL-SYUCOMPFTN          PIC S9(07).
      *主保険−計算負担金（円単位記録用）
           03  SYUTTL-SYUCOMPFTN-ENTANI   PIC S9(07)V9(01).
      *主保険−計算薬剤一部負担金
           03  SYUTTL-SYUCOMPYKZFTN       PIC S9(07).
      *主保険−計算負担金計
           03  SYUTTL-SYUCOMPTOTAL        PIC S9(07).
      *主保険−薬剤負担区分
           03  SYUTTL-SYUYKZFTNKBN        PIC  X(01).
      *公費−負担情報
           03  SYUTTL-KOH-AREA.
      *公費１−保険番号
               05  SYUTTL-KOH1HKNNUM          PIC  X(03).
      *公費１−患者負担金額
               05  SYUTTL-KOH1HKNFTNMONEY     PIC S9(07).
      *公費１−計算負担金
               05  SYUTTL-KOH1COMPFTN         PIC S9(07).
      *公費１−計算負担金（円単位記録用）
               05  SYUTTL-KOH1COMPFTN-ENTANI  PIC S9(07)V9(01).
      *公費１−計算薬剤一部負担金
               05  SYUTTL-KOH1COMPYKZFTN      PIC S9(07).
      *公費１−計算負担金計
               05  SYUTTL-KOH1COMPTOTAL       PIC S9(07).
      *公費１−薬剤負担区分
               05  SYUTTL-KOH1YKZFTNKBN       PIC  X(01).
      *公費２−保険番号
               05  SYUTTL-KOH2HKNNUM          PIC  X(03).
      *公費２−患者負担金額
               05  SYUTTL-KOH2HKNFTNMONEY     PIC S9(07).
      *公費２−計算負担金
               05  SYUTTL-KOH2COMPFTN         PIC S9(07).
      *公費２−計算負担金（円単位記録用）
               05  SYUTTL-KOH2COMPFTN-ENTANI  PIC S9(07)V9(01).
      *公費２−計算薬剤一部負担金
               05  SYUTTL-KOH2COMPYKZFTN      PIC S9(07).
      *公費２−計算負担金計
               05  SYUTTL-KOH2COMPTOTAL       PIC S9(07).
      *公費２−薬剤負担区分
               05  SYUTTL-KOH2YKZFTNKBN       PIC  X(01).
      *公費３−保険番号
               05  SYUTTL-KOH3HKNNUM          PIC  X(03).
      *公費３−患者負担金額
               05  SYUTTL-KOH3HKNFTNMONEY     PIC S9(07).
      *公費３−計算負担金
               05  SYUTTL-KOH3COMPFTN         PIC S9(07).
      *公費３−計算負担金（円単位記録用）
               05  SYUTTL-KOH3COMPFTN-ENTANI  PIC S9(07)V9(01).
      *公費３−計算薬剤一部負担金
               05  SYUTTL-KOH3COMPYKZFTN      PIC S9(07).
      *公費３−計算負担金計
               05  SYUTTL-KOH3COMPTOTAL       PIC S9(07).
      *公費３−薬剤負担区分
               05  SYUTTL-KOH3YKZFTNKBN       PIC  X(01).
      *公費４−保険番号
               05  SYUTTL-KOH4HKNNUM          PIC  X(03).
      *公費４−患者負担金額
               05  SYUTTL-KOH4HKNFTNMONEY     PIC S9(07).
      *公費４−計算負担金
               05  SYUTTL-KOH4COMPFTN         PIC S9(07).
      *公費４−計算負担金（円単位記録用）
               05  SYUTTL-KOH4COMPFTN-ENTANI  PIC S9(07)V9(01).
      *公費４−計算薬剤一部負担金
               05  SYUTTL-KOH4COMPYKZFTN      PIC S9(07).
      *公費４−計算負担金計
               05  SYUTTL-KOH4COMPTOTAL       PIC S9(07).
      *公費４−薬剤負担区分
               05  SYUTTL-KOH4YKZFTNKBN       PIC  X(01).
      *公費負担情報再定義
           03  SYUTTL-KOHFTN-TABLE  REDEFINES   SYUTTL-KOH-AREA.
               05  SYUTTL-KOHFTN-TBL          OCCURS  4.
      *公費−保険番号
                 07  SYUTTL-KOH-HKNNUM          PIC  X(03).
      *公費−患者負担金額
                 07  SYUTTL-KOH-HKNFTNMONEY     PIC S9(07).
      *公費−計算負担金
                 07  SYUTTL-KOH-COMPFTN         PIC S9(07).
      *公費−計算負担金（円単位記録用）
                 07  SYUTTL-KOH-COMPFTN-ENTANI  PIC S9(07)V9(01).
      *公費−計算薬剤一部負担金
                 07  SYUTTL-KOH-COMPYKZFTN      PIC S9(07).
      *公費−計算負担金計
                 07  SYUTTL-KOH-COMPTOTAL       PIC S9(07).
      *公費−薬剤負担区分
                 07  SYUTTL-KOH-YKZFTNKBN       PIC  X(01).
      *患者負担率
           03  SYUTTL-PTFTNRATE           PIC  9(03).
      *請求書作成区分
           03  SYUTTL-SKYKUKBN            PIC  X(01).
      *請求内容
           03  SYUTTL-SKY-NAIYOU.
               05  SYUTTL-SKY-TBL             OCCURS   17.
      *    保険点数
                   09  SYUTTL-HKNTEN          PIC S9(07).
      *    金額
                   09  SYUTTL-MONEY           PIC S9(07).
      *    適用外金額
                   09  SYUTTL-TGMONEY         PIC S9(07).
      *    適用外金額（消費税あり）
                   09  SYUTTL-TGMONEY-TAX     PIC S9(07).
      *請求内容
           03  SYUTTL-SKY-NAIYOU-R        REDEFINES   SYUTTL-SKY-NAIYOU.
      *診療料(01)
              05  SYUTTL-SSU.
                  09  SYUTTL-SSU-HKNTEN          PIC S9(07).
                  09  SYUTTL-SSU-MONEY           PIC S9(07).
                  09  SYUTTL-SSU-TGMONEY         PIC S9(07).
                  09  SYUTTL-SSU-TGMONEY-TAX     PIC S9(07).
      *指導料(02)
              05  SYUTTL-SDO.
                  09  SYUTTL-SDO-HKNTEN          PIC S9(07).
                  09  SYUTTL-SDO-MONEY           PIC S9(07).
                  09  SYUTTL-SDO-TGMONEY         PIC S9(07).
                  09  SYUTTL-SDO-TGMONEY-TAX     PIC S9(07).
      *在宅料(03)
              05  SYUTTL-ZTK.
                  09  SYUTTL-ZTK-HKNTEN          PIC S9(07).
                  09  SYUTTL-ZTK-MONEY           PIC S9(07).
                  09  SYUTTL-ZTK-TGMONEY         PIC S9(07).
                  09  SYUTTL-ZTK-TGMONEY-TAX     PIC S9(07).
      *投薬料(04)
              05  SYUTTL-TYK.
                  09  SYUTTL-TYK-HKNTEN          PIC S9(07).
                  09  SYUTTL-TYK-MONEY           PIC S9(07).
                  09  SYUTTL-TYK-TGMONEY         PIC S9(07).
                  09  SYUTTL-TYK-TGMONEY-TAX     PIC S9(07).
      *注射料(05)
              05  SYUTTL-CSY.
                  09  SYUTTL-CSY-HKNTEN          PIC S9(07).
                  09  SYUTTL-CSY-MONEY           PIC S9(07).
                  09  SYUTTL-CSY-TGMONEY         PIC S9(07).
                  09  SYUTTL-CSY-TGMONEY-TAX     PIC S9(07).
      *処置料(06)
              05  SYUTTL-SYC.
                  09  SYUTTL-SYC-HKNTEN          PIC S9(07).
                  09  SYUTTL-SYC-MONEY           PIC S9(07).
                  09  SYUTTL-SYC-TGMONEY         PIC S9(07).
                  09  SYUTTL-SYC-TGMONEY-TAX     PIC S9(07).
      *手術料(07)
              05  SYUTTL-SJT.
                  09  SYUTTL-SJT-HKNTEN          PIC S9(07).
                  09  SYUTTL-SJT-MONEY           PIC S9(07).
                  09  SYUTTL-SJT-TGMONEY         PIC S9(07).
                  09  SYUTTL-SJT-TGMONEY-TAX     PIC S9(07).
      *麻酔(08)
              05  SYUTTL-MSI.
                  09  SYUTTL-MSI-HKNTEN          PIC S9(07).
                  09  SYUTTL-MSI-MONEY           PIC S9(07).
                  09  SYUTTL-MSI-TGMONEY         PIC S9(07).
                  09  SYUTTL-MSI-TGMONEY-TAX     PIC S9(07).
      *検査料(09)
              05  SYUTTL-KNS.
                  09  SYUTTL-KNS-HKNTEN          PIC S9(07).
                  09  SYUTTL-KNS-MONEY           PIC S9(07).
                  09  SYUTTL-KNS-TGMONEY         PIC S9(07).
                  09  SYUTTL-KNS-TGMONEY-TAX     PIC S9(07).
      *Ｘ線料(10)
              05  SYUTTL-GZU.
                  09  SYUTTL-GZU-HKNTEN          PIC S9(07).
                  09  SYUTTL-GZU-MONEY           PIC S9(07).
                  09  SYUTTL-GZU-TGMONEY         PIC S9(07).
                  09  SYUTTL-GZU-TGMONEY-TAX     PIC S9(07).
      *リハ(11)
              05  SYUTTL-ETC.
                  09  SYUTTL-ETC-HKNTEN          PIC S9(07).
                  09  SYUTTL-ETC-MONEY           PIC S9(07).
                  09  SYUTTL-ETC-TGMONEY         PIC S9(07).
                  09  SYUTTL-ETC-TGMONEY-TAX     PIC S9(07).
      *精神科専門療法(12)
              05  SYUTTL-SSN.
                  09  SYUTTL-SSN-HKNTEN          PIC S9(07).
                  09  SYUTTL-SSN-MONEY           PIC S9(07).
                  09  SYUTTL-SSN-TGMONEY         PIC S9(07).
                  09  SYUTTL-SSN-TGMONEY-TAX     PIC S9(07).
      *放射線(13)
              05  SYUTTL-HOU.
                  09  SYUTTL-HOU-HKNTEN          PIC S9(07).
                  09  SYUTTL-HOU-MONEY           PIC S9(07).
                  09  SYUTTL-HOU-TGMONEY         PIC S9(07).
                  09  SYUTTL-HOU-TGMONEY-TAX     PIC S9(07).
      *病理診断(14)
              05  SYUTTL-BYR.
                  09  SYUTTL-BYR-HKNTEN          PIC S9(07).
                  09  SYUTTL-BYR-MONEY           PIC S9(07).
                  09  SYUTTL-BYR-TGMONEY         PIC S9(07).
                  09  SYUTTL-BYR-TGMONEY-TAX     PIC S9(07).
      *入院料(15)
              05  SYUTTL-NYN.
                  09  SYUTTL-NYN-HKNTEN          PIC S9(07).
                  09  SYUTTL-NYN-MONEY           PIC S9(07).
                  09  SYUTTL-NYN-TGMONEY         PIC S9(07).
                  09  SYUTTL-NYN-TGMONEY-TAX     PIC S9(07).
      *療養担当手当(16)
              05  SYUTTL-RYO.
                  09  SYUTTL-RYO-HKNTEN          PIC S9(07).
                  09  SYUTTL-RYO-MONEY           PIC S9(07).
                  09  SYUTTL-RYO-TGMONEY         PIC S9(07).
                  09  SYUTTL-RYO-TGMONEY-TAX     PIC S9(07).
      *合計  (17)
              05  SYUTTL-TOTAL.
                  09  SYUTTL-TOTAL-HKNTEN        PIC S9(07).
                  09  SYUTTL-TOTAL-MONEY         PIC S9(07).
                  09  SYUTTL-TOTAL-TGMONEY       PIC S9(07).
                  09  SYUTTL-TOTAL-TGMONEY-TAX   PIC S9(07).
      *処方せん料再掲
           03  SYUTTL-SHOHOU-SAI                 PIC S9(07).
      *保険適用外金額−消費税（再掲）
           03  SYUTTL-TGMONEY-TAX-SAI         PIC S9(07).
      *自費１から１０
           03  SYUTTL-JIHI-NAIYOU.
               05  SYUTTL-JIHI-1              PIC S9(07). 
               05  SYUTTL-JIHI-1-TAX          PIC S9(07). 
               05  SYUTTL-JIHI-2              PIC S9(07). 
               05  SYUTTL-JIHI-2-TAX          PIC S9(07). 
               05  SYUTTL-JIHI-3              PIC S9(07). 
               05  SYUTTL-JIHI-3-TAX          PIC S9(07). 
               05  SYUTTL-JIHI-4              PIC S9(07). 
               05  SYUTTL-JIHI-4-TAX          PIC S9(07). 
               05  SYUTTL-JIHI-5              PIC S9(07). 
               05  SYUTTL-JIHI-5-TAX          PIC S9(07). 
               05  SYUTTL-JIHI-6              PIC S9(07). 
               05  SYUTTL-JIHI-6-TAX          PIC S9(07). 
               05  SYUTTL-JIHI-7              PIC S9(07). 
               05  SYUTTL-JIHI-7-TAX          PIC S9(07). 
               05  SYUTTL-JIHI-8              PIC S9(07). 
               05  SYUTTL-JIHI-8-TAX          PIC S9(07). 
               05  SYUTTL-JIHI-9              PIC S9(07). 
               05  SYUTTL-JIHI-9-TAX          PIC S9(07). 
               05  SYUTTL-JIHI-10             PIC S9(07). 
               05  SYUTTL-JIHI-10-TAX         PIC S9(07). 
           03  SYUTTL-JIHI-NAIYOU-R           REDEFINES
                                              SYUTTL-JIHI-NAIYOU.
               05  SYUTTL-JIHI-TBL            OCCURS  10.
                 07  SYUTTL-JIHI-TAXNASI        PIC S9(07).
                 07  SYUTTL-JIHI-TAXARI         PIC S9(07).
      *自費小計（消費税なし）
           03  SYUTTL-JIHI-TOTAL          PIC S9(07).
      *自費小計（消費税あり）
           03  SYUTTL-JIHI-TOTAL-TAX      PIC S9(07).
      *自費金額消費税
           03  SYUTTL-JIHI-TAX            PIC S9(07).
      *老人一部負担金
           03  SYUTTL-RJN-FTN             PIC S9(07).
      *公費一部負担金
           03  SYUTTL-KOH-FTN             PIC S9(07).
      *公費一部負担金（円単位）
           03  SYUTTL-KOH-FTN-ENTANI      PIC S9(07)V9(01).
      *調整金
           03  SYUTTL-CHOSEI              PIC S9(07).
           03  SYUTTL-CHOSEI-NAIYOU.
      *調整金内訳１
               05  SYUTTL-CHOSEI1         PIC S9(07).
      *調整金内訳２
               05  SYUTTL-CHOSEI2         PIC S9(07).
           03  SYUTTL-CHOSEI-NAIYOU-R REDEFINES  SYUTTL-CHOSEI-NAIYOU.
               05  SYUTTL-RCHOSEI         PIC S9(07)
                                          OCCURS  2.
      *まとめ入力差額
           03  SYUTTL-GRP-SGKMONEY        PIC S9(07).
      *保険適用金額
           03  SYUTTL-HKNTEKMONEY         PIC S9(07).
      *病院減免事由区分
           03  SYUTTL-DISCOUNT-KBN        PIC  X(02).
      *病院減免事由
           03  SYUTTL-DISCOUNT-BODY       PIC  X(160).
      *割引率区分
           03  SYUTTL-DISCOUNT-RATEKBN    PIC  X(02).
      *定率定額区分
           03  SYUTTL-DISCOUNT-TEIRITU    PIC  X(01).
      *割引率
           03  SYUTTL-DISCOUNT-RATE       PIC S9(07).
      *減免金額
           03  SYUTTL-DISCOUNT-MONEY      PIC S9(07).
      *労災保険−初診料
           03  SYUTTL-RSISHOSHIN-MONEY    PIC S9(07).
      *労災保険−再診料
           03  SYUTTL-RSISAISHIN-MONEY    PIC S9(07).
      *労災保険−指導料
           03  SYUTTL-RSISDO-MONEY        PIC S9(07).
      *労災保険−その他
           03  SYUTTL-RSIETC-MONEY        PIC S9(07).
      *労災保険−消費税（再掲）
           03  SYUTTL-RSI-TAX-SAI         PIC S9(07).
      *労災保険−患者請求分円建て合計額
           03  SYUTTL-RSI-TOTAL           PIC S9(07).
      *労災自賠−請求金額（日計表記載用）
           03  SYUTTL-RSIJIBAI-SKYMONEY   PIC S9(07).
      *請求金額−消費税（再掲）
           03  SYUTTL-SKYMONEY-TAX-SAI    PIC S9(07).
      *請求金額
           03  SYUTTL-SKYMONEY            PIC S9(07).
      *入金合計額
           03  SYUTTL-NYUKIN-TOTAL        PIC S9(07).
      *入金回数
           03  SYUTTL-NYUKIN-KAISU        PIC S9(07).
      *未収理由
           03  SYUTTL-MISYURIYU           PIC  X(02).
      *在総診区分
           03  SYUTTL-ZAITAKU             PIC  X(01).
      *診療区分別給付外点数
           03  SYUTTL-KYUFUGAI.
               05  SYUTTL-KYUFUGAI-TBL          OCCURS   6.
      *    給付対象外点数
                   09  SYUTTL-KYUFUGAI-TEN      PIC S9(07).
      *診療区分別給付外点数再定義
           03  SYUTTL-KYUFUGAI-R      REDEFINES   SYUTTL-KYUFUGAI.
      *給付対象外点数（初診）
              05  SYUTTL-KYUFUGAI-SHOSHIN-TEN    PIC S9(07).
      *給付対象外点数（指導）
              05  SYUTTL-KYUFUGAI-SIDOU-TEN      PIC S9(07).
      *給付対象外点数（往診）
              05  SYUTTL-KYUFUGAI-OSIN1-TEN      PIC S9(07).
      *給付対象外点数（往診／夜間）
              05  SYUTTL-KYUFUGAI-OSIN2-TEN      PIC S9(07).
      *給付対象外点数（往診／深夜／緊急）
              05  SYUTTL-KYUFUGAI-OSIN3-TEN      PIC S9(07).
      *給付対象外点数（合計）
              05  SYUTTL-KYUFUGAI-GOKEI-TEN      PIC S9(07).
      *保険適用区分
           03  SYUTTL-HKNTEKKBN           PIC  X(01).
      *端末ＩＤ
           03  SYUTTL-TERMID              PIC  X(16).
      *オペーレータＩＤ
           03  SYUTTL-OPID                PIC  X(16).
      *作成年月日
           03  SYUTTL-CREYMD              PIC  X(08).
      *更新年月日
           03  SYUTTL-UPYMD               PIC  X(08).
      *更新時間
           03  SYUTTL-UPHMS               PIC  X(06).
      *
