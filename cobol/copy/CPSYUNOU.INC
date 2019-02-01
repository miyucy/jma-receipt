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
      *    収納マスタ         COPY (CPSYUNOU.INC)       *
      *  01.00.01    NACL-小豆沢   04/07/04  まとめ入力差額追加
      *                                      まとめ入力伝票番号追加
      *                                      まとめ入力連番追加
      *  01.00.02    NACL-小豆沢   05/07/13  自費項目の追加
      *                                      減免金額の追加
      *                                      変則助成項目の追加
      *  01.00.03    NACL-小豆沢   06/07/06  部別の項目追加
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  SYUNOU-REC.
           03  SYU-KEY.
      *医療機関ＩＤ
               05  SYU-HOSPNUM          PIC 9(2).
      *入外区分
               05  SYU-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  SYU-PTID            PIC  9(10).
      *伝票番号
               05  SYU-DENPNUM         PIC  9(07).
      *伝票枝番最終番号
           03  SYU-DENPLASTNUM         PIC  9(02).
      *診療科
           03  SYU-SRYKA               PIC  X(02).
      *診療日
           03  SYU-SRYYMD              PIC  X(08).
      *伝票状態区分
           03  SYU-DENPJTIKBN          PIC  X(01).
      *伝票作成区分（空白：外来　１：退院時作成　２：定期請求
      *              ３：入院レセプト用ダミー）
           03  SYU-CREATEKBN           PIC  X(01).
      *伝票発行日
           03  SYU-DENPPRTYMD          PIC  X(08).
      *請求期間
           03  SYU-SKY-KIKAN.
      *請求開始日
               05  SYU-SKYSTYMD        PIC  X(08).
      *請求終了日
               05  SYU-SKYEDYMD        PIC  X(08).
      *保険組合せ番号
           03  SYU-HKNCOMBINUM         PIC  X(04).
      *主保険−保険番号
           03  SYU-SYUHKNNUM           PIC  X(03).
      *主保険−患者負担金額
           03  SYU-SYUHKNFTNMONEY      PIC S9(07).
      *主保険−計算負担金
           03  SYU-SYUCOMPFTN          PIC S9(07).
      *主保険−計算負担金（円単位記録用）
           03  SYU-SYUCOMPFTN-ENTANI   PIC S9(07)V9(01).
      *主保険−計算薬剤一部負担金
           03  SYU-SYUCOMPYKZFTN       PIC S9(07).
      *主保険−計算負担金計
           03  SYU-SYUCOMPTOTAL        PIC S9(07).
      *主保険−薬剤負担区分
           03  SYU-SYUYKZFTNKBN        PIC  X(01).
      *公費−負担情報
           03  SYU-KOH-AREA.
      *公費１−保険番号
               05  SYU-KOH1HKNNUM          PIC  X(03).
      *公費１−患者負担金額
               05  SYU-KOH1HKNFTNMONEY     PIC S9(07).
      *公費１−計算負担金
               05  SYU-KOH1COMPFTN         PIC S9(07).
      *公費１−計算負担金（円単位記録用）
               05  SYU-KOH1COMPFTN-ENTANI  PIC S9(07)V9(01).
      *公費１−計算薬剤一部負担金
               05  SYU-KOH1COMPYKZFTN      PIC S9(07).
      *公費１−計算負担金計
               05  SYU-KOH1COMPTOTAL       PIC S9(07).
      *公費１−薬剤負担区分
               05  SYU-KOH1YKZFTNKBN       PIC  X(01).
      *公費２−保険番号
               05  SYU-KOH2HKNNUM          PIC  X(03).
      *公費２−患者負担金額
               05  SYU-KOH2HKNFTNMONEY     PIC S9(07).
      *公費２−計算負担金
               05  SYU-KOH2COMPFTN         PIC S9(07).
      *公費２−計算負担金（円単位記録用）
               05  SYU-KOH2COMPFTN-ENTANI  PIC S9(07)V9(01).
      *公費２−計算薬剤一部負担金
               05  SYU-KOH2COMPYKZFTN      PIC S9(07).
      *公費２−計算負担金計
               05  SYU-KOH2COMPTOTAL       PIC S9(07).
      *公費２−薬剤負担区分
               05  SYU-KOH2YKZFTNKBN       PIC  X(01).
      *公費３−保険番号
               05  SYU-KOH3HKNNUM          PIC  X(03).
      *公費３−患者負担金額
               05  SYU-KOH3HKNFTNMONEY     PIC S9(07).
      *公費３−計算負担金
               05  SYU-KOH3COMPFTN         PIC S9(07).
      *公費３−計算負担金（円単位記録用）
               05  SYU-KOH3COMPFTN-ENTANI  PIC S9(07)V9(01).
      *公費３−計算薬剤一部負担金
               05  SYU-KOH3COMPYKZFTN      PIC S9(07).
      *公費３−計算負担金計
               05  SYU-KOH3COMPTOTAL       PIC S9(07).
      *公費３−薬剤負担区分
               05  SYU-KOH3YKZFTNKBN       PIC  X(01).
      *公費４−保険番号
               05  SYU-KOH4HKNNUM          PIC  X(03).
      *公費４−患者負担金額
               05  SYU-KOH4HKNFTNMONEY     PIC S9(07).
      *公費４−計算負担金
               05  SYU-KOH4COMPFTN         PIC S9(07).
      *公費４−計算負担金（円単位記録用）
               05  SYU-KOH4COMPFTN-ENTANI  PIC S9(07)V9(01).
      *公費４−計算薬剤一部負担金
               05  SYU-KOH4COMPYKZFTN      PIC S9(07).
      *公費４−計算負担金計
               05  SYU-KOH4COMPTOTAL       PIC S9(07).
      *公費４−薬剤負担区分
               05  SYU-KOH4YKZFTNKBN       PIC  X(01).
      *公費負担情報再定義
           03  SYU-KOHFTN-TABLE  REDEFINES   SYU-KOH-AREA.
               05  SYU-KOHFTN-TBL          OCCURS  4.
      *公費−保険番号
                 07  SYU-KOH-HKNNUM          PIC  X(03).
      *公費−患者負担金額
                 07  SYU-KOH-HKNFTNMONEY     PIC S9(07).
      *公費−計算負担金
                 07  SYU-KOH-COMPFTN         PIC S9(07).
      *公費−計算負担金（円単位記録用）
                 07  SYU-KOH-COMPFTN-ENTANI  PIC S9(07)V9(01).
      *公費−計算薬剤一部負担金
                 07  SYU-KOH-COMPYKZFTN      PIC S9(07).
      *公費−計算負担金計
                 07  SYU-KOH-COMPTOTAL       PIC S9(07).
      *公費−薬剤負担区分
                 07  SYU-KOH-YKZFTNKBN       PIC  X(01).
      *患者負担率
           03  SYU-PTFTNRATE           PIC  9(03).
      *部屋ＮＯ
           03  SYU-ROOMNUM             PIC  X(08).
      *病棟コード
           03  SYU-BYOTONUM            PIC  X(02).
      *請求書作成区分
           03  SYU-SKYKUKBN            PIC  X(01).
      *消費税対象金額
           03  SYU-TAX-TAISHOU         PIC S9(07).
      *消費税（内税）
           03  SYU-TAX-MONEY           PIC S9(07).
      *消費税（合計）
           03  SYU-SKYGK               PIC S9(07).
      *請求内容
           03  SYU-SKY-NAIYOU.
               05  SYU-SKY-TBL             OCCURS   17.
      *    保険点数
                   09  SYU-HKNTEN          PIC S9(07).
      *    金額
                   09  SYU-MONEY           PIC S9(07).
      *    適用外金額
                   09  SYU-TGMONEY         PIC S9(07).
      *    適用外金額（消費税あり）
                   09  SYU-TGMONEY-TAX     PIC S9(07).
      *請求内容
           03  SYU-SKY-NAIYOU-R        REDEFINES   SYU-SKY-NAIYOU.
      *診療料(01)
              05  SYU-SSU.
                  09  SYU-SSU-HKNTEN          PIC S9(07).
                  09  SYU-SSU-MONEY           PIC S9(07).
                  09  SYU-SSU-TGMONEY         PIC S9(07).
                  09  SYU-SSU-TGMONEY-TAX     PIC S9(07).
      *指導料(02)
              05  SYU-SDO.
                  09  SYU-SDO-HKNTEN          PIC S9(07).
                  09  SYU-SDO-MONEY           PIC S9(07).
                  09  SYU-SDO-TGMONEY         PIC S9(07).
                  09  SYU-SDO-TGMONEY-TAX     PIC S9(07).
      *在宅料(03)
              05  SYU-ZTK.
                  09  SYU-ZTK-HKNTEN          PIC S9(07).
                  09  SYU-ZTK-MONEY           PIC S9(07).
                  09  SYU-ZTK-TGMONEY         PIC S9(07).
                  09  SYU-ZTK-TGMONEY-TAX     PIC S9(07).
      *投薬料(04)
              05  SYU-TYK.
                  09  SYU-TYK-HKNTEN          PIC S9(07).
                  09  SYU-TYK-MONEY           PIC S9(07).
                  09  SYU-TYK-TGMONEY         PIC S9(07).
                  09  SYU-TYK-TGMONEY-TAX     PIC S9(07).
      *注射料(05)
              05  SYU-CSY.
                  09  SYU-CSY-HKNTEN          PIC S9(07).
                  09  SYU-CSY-MONEY           PIC S9(07).
                  09  SYU-CSY-TGMONEY         PIC S9(07).
                  09  SYU-CSY-TGMONEY-TAX     PIC S9(07).
      *処置料(06)
              05  SYU-SYC.
                  09  SYU-SYC-HKNTEN          PIC S9(07).
                  09  SYU-SYC-MONEY           PIC S9(07).
                  09  SYU-SYC-TGMONEY         PIC S9(07).
                  09  SYU-SYC-TGMONEY-TAX     PIC S9(07).
      *手術料(07)
              05  SYU-SJT.
                  09  SYU-SJT-HKNTEN          PIC S9(07).
                  09  SYU-SJT-MONEY           PIC S9(07).
                  09  SYU-SJT-TGMONEY         PIC S9(07).
                  09  SYU-SJT-TGMONEY-TAX     PIC S9(07).
      *麻酔(08)
              05  SYU-MSI.
                  09  SYU-MSI-HKNTEN          PIC S9(07).
                  09  SYU-MSI-MONEY           PIC S9(07).
                  09  SYU-MSI-TGMONEY         PIC S9(07).
                  09  SYU-MSI-TGMONEY-TAX     PIC S9(07).
      *検査料(09)
              05  SYU-KNS.
                  09  SYU-KNS-HKNTEN          PIC S9(07).
                  09  SYU-KNS-MONEY           PIC S9(07).
                  09  SYU-KNS-TGMONEY         PIC S9(07).
                  09  SYU-KNS-TGMONEY-TAX     PIC S9(07).
      *Ｘ線料(10)
              05  SYU-GZU.
                  09  SYU-GZU-HKNTEN          PIC S9(07).
                  09  SYU-GZU-MONEY           PIC S9(07).
                  09  SYU-GZU-TGMONEY         PIC S9(07).
                  09  SYU-GZU-TGMONEY-TAX     PIC S9(07).
      *リハ(11)
              05  SYU-ETC.
                  09  SYU-ETC-HKNTEN          PIC S9(07).
                  09  SYU-ETC-MONEY           PIC S9(07).
                  09  SYU-ETC-TGMONEY         PIC S9(07).
                  09  SYU-ETC-TGMONEY-TAX     PIC S9(07).
      *精神科専門療法(12)
              05  SYU-SSN.
                  09  SYU-SSN-HKNTEN          PIC S9(07).
                  09  SYU-SSN-MONEY           PIC S9(07).
                  09  SYU-SSN-TGMONEY         PIC S9(07).
                  09  SYU-SSN-TGMONEY-TAX     PIC S9(07).
      *放射線(13)
              05  SYU-HOU.
                  09  SYU-HOU-HKNTEN          PIC S9(07).
                  09  SYU-HOU-MONEY           PIC S9(07).
                  09  SYU-HOU-TGMONEY         PIC S9(07).
                  09  SYU-HOU-TGMONEY-TAX     PIC S9(07).
      *病理診断(14)
              05  SYU-BYR.
                  09  SYU-BYR-HKNTEN          PIC S9(07).
                  09  SYU-BYR-MONEY           PIC S9(07).
                  09  SYU-BYR-TGMONEY         PIC S9(07).
                  09  SYU-BYR-TGMONEY-TAX     PIC S9(07).
      *入院料(15)
              05  SYU-NYN.
                  09  SYU-NYN-HKNTEN          PIC S9(07).
                  09  SYU-NYN-MONEY           PIC S9(07).
                  09  SYU-NYN-TGMONEY         PIC S9(07).
                  09  SYU-NYN-TGMONEY-TAX     PIC S9(07).
      *療養担当手当(16)
              05  SYU-RYO.
                  09  SYU-RYO-HKNTEN          PIC S9(07).
                  09  SYU-RYO-MONEY           PIC S9(07).
                  09  SYU-RYO-TGMONEY         PIC S9(07).
                  09  SYU-RYO-TGMONEY-TAX     PIC S9(07).
      *合計  (17)
              05  SYU-TOTAL.
                  09  SYU-TOTAL-HKNTEN        PIC S9(07).
                  09  SYU-TOTAL-MONEY         PIC S9(07).
                  09  SYU-TOTAL-TGMONEY       PIC S9(07).
                  09  SYU-TOTAL-TGMONEY-TAX   PIC S9(07).
      *処方せん料再掲
           03  SYU-SHOHOU-SAI                 PIC S9(07).
      *保険適用外金額−消費税（再掲）
           03  SYU-TGMONEY-TAX-SAI         PIC S9(07).
      *自費１から１０
           03  SYU-JIHI-NAIYOU.
               05  SYU-JIHI-1              PIC S9(07). 
               05  SYU-JIHI-1-TAX          PIC S9(07). 
               05  SYU-JIHI-2              PIC S9(07). 
               05  SYU-JIHI-2-TAX          PIC S9(07). 
               05  SYU-JIHI-3              PIC S9(07). 
               05  SYU-JIHI-3-TAX          PIC S9(07). 
               05  SYU-JIHI-4              PIC S9(07). 
               05  SYU-JIHI-4-TAX          PIC S9(07). 
               05  SYU-JIHI-5              PIC S9(07). 
               05  SYU-JIHI-5-TAX          PIC S9(07). 
               05  SYU-JIHI-6              PIC S9(07). 
               05  SYU-JIHI-6-TAX          PIC S9(07). 
               05  SYU-JIHI-7              PIC S9(07). 
               05  SYU-JIHI-7-TAX          PIC S9(07). 
               05  SYU-JIHI-8              PIC S9(07). 
               05  SYU-JIHI-8-TAX          PIC S9(07). 
               05  SYU-JIHI-9              PIC S9(07). 
               05  SYU-JIHI-9-TAX          PIC S9(07). 
               05  SYU-JIHI-10             PIC S9(07). 
               05  SYU-JIHI-10-TAX         PIC S9(07). 
           03  SYU-JIHI-NAIYOU-R           REDEFINES  SYU-JIHI-NAIYOU.
               05  SYU-JIHI-TBL            OCCURS   10.
                 07  SYU-JIHI-TAXNASI        PIC S9(07).
                 07  SYU-JIHI-TAXARI         PIC S9(07).
      *自費小計（消費税なし）
           03  SYU-JIHI-TOTAL          PIC S9(07).
      *自費小計（消費税あり）
           03  SYU-JIHI-TOTAL-TAX      PIC S9(07).
      *自費金額消費税
           03  SYU-JIHI-TAX            PIC S9(07).
      *老人一部負担金
           03  SYU-RJN-FTN             PIC S9(07).
      *公費一部負担金
           03  SYU-KOH-FTN             PIC S9(07).
      *公費一部負担金（円単位）
           03  SYU-KOH-FTN-ENTANI      PIC S9(07)V9(01).
      *薬剤一部負担金
           03  SYU-YKZ-FTN             PIC S9(07).
      *レセプト出力用薬剤一部負担金
           03  SYU-RESE-YKZ-FTN        PIC S9(07).
      *公費対象薬剤区分
           03  SYU-KOHTAIYKZKBN        PIC  X(01).
      *調整金
           03  SYU-CHOSEI              PIC S9(07).
           03  SYU-CHOSEI-NAIYOU.
      *調整金内訳１
               05  SYU-CHOSEI1         PIC S9(07).
      *調整金内訳２
               05  SYU-CHOSEI2         PIC S9(07).
           03  SYU-CHOSEI-NAIYOU-R REDEFINES  SYU-CHOSEI-NAIYOU.
               05  SYU-RCHOSEI         PIC S9(07)
                                       OCCURS  2.
      *まとめ入力伝票番号
           03  SYU-GRP-DENPNUM         PIC 9(07).
      *まとめ入力連番
           03  SYU-GRP-RENNUM          PIC 9(02).
      *まとめ入力差額
           03  SYU-GRP-SGKMONEY        PIC S9(07).
      *まとめ発行方法フラグ
           03  SYU-GRP-HAKHOUFLG       PIC  9(01).
      *保証金額
           03  SYU-SECMONEY            PIC S9(07).
      *保険適用金額
           03  SYU-HKNTEKMONEY         PIC S9(07).
      *病院減免事由区分
           03  SYU-DISCOUNT-KBN        PIC  X(02).
      *病院減免事由
           03  SYU-DISCOUNT-BODY       PIC  X(160).
      *割引率区分
           03  SYU-DISCOUNT-RATEKBN    PIC  X(02).
      *定率定額区分
           03  SYU-DISCOUNT-TEIRITU    PIC  X(01).
      *割引率
           03  SYU-DISCOUNT-RATE       PIC S9(07).
      *減免金額
           03  SYU-DISCOUNT-MONEY      PIC S9(07).
      *労災保険−初診料
           03  SYU-RSISHOSHIN-MONEY    PIC S9(07).
      *労災保険−再診料
           03  SYU-RSISAISHIN-MONEY    PIC S9(07).
      *労災保険−指導料
           03  SYU-RSISDO-MONEY        PIC S9(07).
      *労災保険−その他
           03  SYU-RSIETC-MONEY        PIC S9(07).
      *労災保険−消費税（再掲）
           03  SYU-RSI-TAX-SAI         PIC S9(07).
      *労災保険−患者請求分円建て合計額
           03  SYU-RSI-TOTAL           PIC S9(07).
      *労災自賠−請求金額（日計表記載用）
           03  SYU-RSIJIBAI-SKYMONEY   PIC S9(07).
      *請求金額−消費税（再掲）
           03  SYU-SKYMONEY-TAX-SAI    PIC S9(07).
      *請求金額
           03  SYU-SKYMONEY            PIC S9(07).
      *入金合計額
           03  SYU-NYUKIN-TOTAL        PIC S9(07).
      *入金回数
           03  SYU-NYUKIN-KAISU        PIC S9(07).
      *未収理由
           03  SYU-MISYURIYU           PIC  X(02).
      *ドクター
           03  SYU-DRCD-G.
               05  SYU-DRCD-SIK            PIC  X(01).
               05  SYU-DRCD                PIC  X(04).
      *入院初診回数
           03  SYU-NYNSHOKAISU         PIC S9(02).
      *薬剤発券番号
           03  SYU-YKZKENNUM           PIC  9(05).
      *室料差額
           03  SYU-RMSAGAKU            PIC S9(07).
      *室料差額−消費税（再掲）
           03  SYU-RMSAGAKU-TAX-SAI    PIC S9(07).
      *食事１から食事１４
           03  SYU-SHOKUJI-NAIYOU.
               05  SYU-SHOKUJI1-NISSU  PIC S9(02).
               05  SYU-SHOKUJI1        PIC S9(07).
               05  SYU-SHOKUJI2-NISSU  PIC S9(02).
               05  SYU-SHOKUJI2        PIC S9(07).
               05  SYU-SHOKUJI3-NISSU  PIC S9(02).
               05  SYU-SHOKUJI3        PIC S9(07).
               05  SYU-SHOKUJI4-NISSU  PIC S9(02).
               05  SYU-SHOKUJI4        PIC S9(07).
               05  SYU-SHOKUJI5-NISSU  PIC S9(02).
               05  SYU-SHOKUJI5        PIC S9(07).
               05  SYU-SHOKUJI6-NISSU  PIC S9(02).
               05  SYU-SHOKUJI6        PIC S9(07).
               05  SYU-SHOKUJI7-NISSU  PIC S9(02).
               05  SYU-SHOKUJI7        PIC S9(07).
               05  SYU-SHOKUJI8-NISSU  PIC S9(02).
               05  SYU-SHOKUJI8        PIC S9(07).
               05  SYU-SHOKUJI9-NISSU  PIC S9(02).
               05  SYU-SHOKUJI9        PIC S9(07).
               05  SYU-SHOKUJI10-NISSU PIC S9(02).
               05  SYU-SHOKUJI10       PIC S9(07).
               05  SYU-SHOKUJI11-NISSU PIC S9(02).
               05  SYU-SHOKUJI11       PIC S9(07).
               05  SYU-SHOKUJI12-NISSU PIC S9(02).
               05  SYU-SHOKUJI12       PIC S9(07).
               05  SYU-SHOKUJI13-NISSU PIC S9(02).
               05  SYU-SHOKUJI13       PIC S9(07).
               05  SYU-SHOKUJI14-NISSU PIC S9(02).
               05  SYU-SHOKUJI14       PIC S9(07).
           03  SYU-SYOKUJI-NAIYOUR     REDEFINES   SYU-SHOKUJI-NAIYOU.
               05  SYU-SYOKUJI-TBL     OCCURS   14.
                 07  SYU-SHOKUJI-NISSU   PIC S9(02).
                 07  SYU-SHOKUJI         PIC S9(07).
      *食事療養費情報（食事日数・食事療養費・標準負担額）
           03  SYU-SKJ-AREA.
               05  SYU-SYUSKJ-NISSU      PIC S9(02).
               05  SYU-SYUSKJ-RYOYOHI    PIC S9(07).
               05  SYU-SYUSKJ-FTN        PIC S9(07).
               05  SYU-SYUSKJ-FTN-RECE   PIC S9(07).
               05  SYU-SYUSKJ-FTNKBN     PIC  X(01).
           03  SYU-SKJ-AREA2.
               05  SYU-KOH1SKJ-NISSU     PIC S9(02).
               05  SYU-KOH1SKJ-RYOYOHI   PIC S9(07).
               05  SYU-KOH1SKJ-FTN       PIC S9(07).
               05  SYU-KOH1SKJ-FTN-RECE  PIC S9(07).
               05  SYU-KOH1SKJ-FTNKBN    PIC  X(01).
               05  SYU-KOH2SKJ-NISSU     PIC S9(02).
               05  SYU-KOH2SKJ-RYOYOHI   PIC S9(07).
               05  SYU-KOH2SKJ-FTN       PIC S9(07).
               05  SYU-KOH2SKJ-FTN-RECE  PIC S9(07).
               05  SYU-KOH2SKJ-FTNKBN    PIC  X(01).
               05  SYU-KOH3SKJ-NISSU     PIC S9(02).
               05  SYU-KOH3SKJ-RYOYOHI   PIC S9(07).
               05  SYU-KOH3SKJ-FTN       PIC S9(07).
               05  SYU-KOH3SKJ-FTN-RECE  PIC S9(07).
               05  SYU-KOH3SKJ-FTNKBN    PIC  X(01).
               05  SYU-KOH4SKJ-NISSU     PIC S9(02).
               05  SYU-KOH4SKJ-RYOYOHI   PIC S9(07).
               05  SYU-KOH4SKJ-FTN       PIC S9(07).
               05  SYU-KOH4SKJ-FTN-RECE  PIC S9(07).
               05  SYU-KOH4SKJ-FTNKBN    PIC  X(01).
           03  SYU-SKJ-AREA2R          REDEFINES   SYU-SKJ-AREA2.
               05  SYU-SKJ-TBL         OCCURS   4.
                 07  SYU-SKJ-NISSU       PIC S9(02).
                 07  SYU-SKJ-RYOYOHI     PIC S9(07).
                 07  SYU-SKJ-FTN         PIC S9(07).
                 07  SYU-SKJ-FTN-RECE    PIC S9(07).
                 07  SYU-SKJ-FTNKBN      PIC  X(01).
      *食事療養費（保険）
           03  SYU-RYOYOHI-SKJ         PIC S9(07).
      *食事負担額（保険：自己負担）
           03  SYU-SKYMONEY-SKJ        PIC S9(07).
      *食事負担額（保険：自己負担消費税）
           03  SYU-SKYMONEY-SKJ-TAX    PIC S9(07).
      *食事負担額（保険：自己負担合計）
           03  SYU-SKYMONEY-SKJ-KEI    PIC S9(07).
      *食事療養費（自費）
           03  SYU-RYOYOHI-SKJ-JIHI    PIC S9(07).
      *食事負担額（自費：自己負担）
           03  SYU-SKYMONEY-SKJ-JIHI   PIC S9(07).
      *食事負担額（自費：自己負担消費税）
           03  SYU-SKYMONEY-SKJ-JIHI-TAX
                                       PIC S9(07).
      *食事負担額（自費：自己負担合計）
           03  SYU-SKYMONEY-SKJ-JIHI-KEI
                                       PIC S9(07).
      *入院時生活療養費（保険）
           03  SYU-RYOYOHI-LIFE        PIC S9(07).
      *入院時生活療養費負担額（保険：自己負担）
           03  SYU-SKYMONEY-LIFE       PIC S9(07).
      *入院時生活療養費負担額（保険：自己負担消費税）
           03  SYU-SKYMONEY-LIFE-TAX   PIC S9(07).
      *入院時生活療養費負担額（保険：自己負担合計）
           03  SYU-SKYMONEY-LIFE-KEI   PIC S9(07).
      *入院時生活療養費費（自費）
           03  SYU-RYOYOHI-LIFE-JIHI   PIC S9(07).
      *入院時生活療養費負担額（自費：自己負担）
           03  SYU-SKYMONEY-LIFE-JIHI  PIC S9(07).
      *入院時生活療養費負担額（自費：自己負担消費税）
           03  SYU-SKYMONEY-LIFE-JIHI-TAX
                                       PIC S9(07).
      *入院時生活療養費負担額（自費：自己負担合計）
           03  SYU-SKYMONEY-LIFE-JIHI-KEI
                                       PIC S9(07).
      *食事負担（負担額別管理用）
           03  SYU-SKJ-PTFTN           OCCURS 3.
               05  SYU-SKJ-FTNGAKU     PIC S9(05).
               05  SYU-SKJ-FTNDAY      PIC S9(02).
      *再計算区分
           03  SYU-SAIKEISANKBN        PIC  X(01).
      *院外処方区分
           03  SYU-INGAISHOHOKBN       PIC  X(01).
      *同時診療伝票番号
           03  SYU-DOUJI-DENPNUM       PIC  9(07).
      *継続区分
           03  SYU-CONTKBN             PIC  X(01).
      *診療フラグテーブル
           03  SYU-DAY-AREA.
      *        診療フラグテーブル
             04  SYU-DAY-TBL.
      *        診療フラグ（１日から３１日）
               05  SYU-DAY-1           PIC  X(01).
               05  SYU-DAY-2           PIC  X(01).
               05  SYU-DAY-3           PIC  X(01).
               05  SYU-DAY-4           PIC  X(01).
               05  SYU-DAY-5           PIC  X(01).
               05  SYU-DAY-6           PIC  X(01).
               05  SYU-DAY-7           PIC  X(01).
               05  SYU-DAY-8           PIC  X(01).
               05  SYU-DAY-9           PIC  X(01).
               05  SYU-DAY-10          PIC  X(01).
               05  SYU-DAY-11          PIC  X(01).
               05  SYU-DAY-12          PIC  X(01).
               05  SYU-DAY-13          PIC  X(01).
               05  SYU-DAY-14          PIC  X(01).
               05  SYU-DAY-15          PIC  X(01).
               05  SYU-DAY-16          PIC  X(01).
               05  SYU-DAY-17          PIC  X(01).
               05  SYU-DAY-18          PIC  X(01).
               05  SYU-DAY-19          PIC  X(01).
               05  SYU-DAY-20          PIC  X(01).
               05  SYU-DAY-21          PIC  X(01).
               05  SYU-DAY-22          PIC  X(01).
               05  SYU-DAY-23          PIC  X(01).
               05  SYU-DAY-24          PIC  X(01).
               05  SYU-DAY-25          PIC  X(01).
               05  SYU-DAY-26          PIC  X(01).
               05  SYU-DAY-27          PIC  X(01).
               05  SYU-DAY-28          PIC  X(01).
               05  SYU-DAY-29          PIC  X(01).
               05  SYU-DAY-30          PIC  X(01).
               05  SYU-DAY-31          PIC  X(01).
           03  SYU-DAY-AREA-R          REDEFINES   SYU-DAY-AREA.
      *        診療回数テーブル
               05  SYU-DAY-TBL2.
                   07  SYU-DAY         PIC  X(01)
                                         OCCURS   31.
      *複数科まとめ識別伝票番号
           03  SYU-FUKU-DENPNUM        PIC  9(07).
      *複数科まとめ区分（１：継続　２：確定）
           03  SYU-FUKU-KBN            PIC  X(01).
      *在総診区分
           03  SYU-ZAITAKU             PIC  X(01).
      *診療区分別給付外点数
           03  SYU-KYUFUGAI.
               05  SYU-KYUFUGAI-TBL          OCCURS   6.
      *    給付対象外点数
                   09  SYU-KYUFUGAI-TEN      PIC S9(07).
      *診療区分別給付外点数再定義
           03  SYU-KYUFUGAI-R      REDEFINES   SYU-KYUFUGAI.
      *給付対象外点数（初診）
              05  SYU-KYUFUGAI-SHOSHIN-TEN    PIC S9(07).
      *給付対象外点数（指導）
              05  SYU-KYUFUGAI-SIDOU-TEN      PIC S9(07).
      *給付対象外点数（往診）
              05  SYU-KYUFUGAI-OSIN1-TEN      PIC S9(07).
      *給付対象外点数（往診／夜間）
              05  SYU-KYUFUGAI-OSIN2-TEN      PIC S9(07).
      *給付対象外点数（往診／深夜／緊急）
              05  SYU-KYUFUGAI-OSIN3-TEN      PIC S9(07).
      *給付対象外点数（合計）
              05  SYU-KYUFUGAI-GOKEI-TEN      PIC S9(07).
      *日別収納フラグ
           03  SYU-DAYINFFLG           PIC  X(01).
      *分娩管理フラグ
           03  SYU-BUNBENINFFLG        PIC  X(01).
      *入院履歴番号
           03  SYU-NYUIN-RRKNUM        PIC  9(03).
      *会計変更区分
           03  SYU-ACCT-UPDKBN         PIC  X(01).
      *変則助成−患者負担金額
           03  SYU-JYO-HKNFTNMONEY     PIC S9(07).
      *変則助成−計算負担金
           03  SYU-JYO-COMPFTN         PIC S9(07).
      *変則助成−計算負担金（円単位記録用）
           03  SYU-JYO-COMPFTN-ENTANI  PIC S9(07)V9(01).
      *保険適用区分
           03  SYU-HKNTEKKBN           PIC  X(01).
      *入院その他１から５
           03  SYU-NYUINETC-INF.
               05  SYU-NYUINETC1       PIC S9(07).
               05  SYU-NYUINETC2       PIC S9(07).
               05  SYU-NYUINETC3       PIC S9(07).
               05  SYU-NYUINETC4       PIC S9(07).
               05  SYU-NYUINETC5       PIC S9(07).
      *端末ＩＤ
           03  SYU-TERMID              PIC  X(16).
      *オペーレータＩＤ
           03  SYU-OPID                PIC  X(16).
      *作成年月日
           03  SYU-CREYMD              PIC  X(08).
      *更新年月日
           03  SYU-UPYMD               PIC  X(08).
      *更新時間
           03  SYU-UPHMS               PIC  X(06).
      *
      *診療年月日（検索用）
           03  SYU-UPSRYYMD            PIC  X(08).
      *公費ＩＤ（検索用）
           03  SYU-SELKOHID            PIC  9(10).
      *入外区分（検索用）
           03  SYU-SELNYUGAIKBN        PIC  X(01).
