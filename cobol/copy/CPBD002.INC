      ************************************************************
      *    日計表用収納マスタ         COPY (CPBD002.INC)     *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     02.02.27  収納ＤＢの変更により修正
      *  01.00.02    NACL-小豆沢  04.01.21  収納ＤＢの変更により修正
      *  01.00.03    NACL-太田    04.03.17  収納ＤＢの変更により修正
      *  01.00.04    NACL-太田    05.08.24  収納ＤＢの変更により修正
      *  01.00.05    NACL-小豆沢  06.07.06  収納ＤＢの変更により修正
      *  01.00.06    NACL-太田    06.09.21  収納ＤＢの変更により修正
      *  04.04.00    NACL-太田    09.03.03  収納ＤＢの変更により修正
      ************************************************************
      *01  BD002-REC.
           03  BD002-KEY.
      *医療機関ＩＤ
               05  BD002-HOSPNUM          PIC 9(2).
      *入外区分
               05  BD002-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  BD002-PTID            PIC  9(10).
      *伝票番号
               05  BD002-DENPNUM         PIC  9(07).
      *伝票枝番最終番号
           03  BD002-DENPLASTNUM         PIC  9(02).
      *診療科
           03  BD002-SRYKA               PIC  X(02).
      *診療日
           03  BD002-SRYYMD              PIC  X(08).
      *伝票状態区分
           03  BD002-DENPJTIKBN          PIC  X(01).
      *伝票作成区分（空白：外来　１：退院時作成　２：定期請求
      *              ３：入院レセプト用ダミー）
           03  BD002-CREATEKBN           PIC  X(01).
      *伝票発行日
           03  BD002-DENPPRTYMD          PIC  X(08).
      *請求期間
           03  BD002-SKY-KIKAN.
      *請求開始日
               05  BD002-SKYSTYMD        PIC  X(08).
      *請求終了日
               05  BD002-SKYEDYMD        PIC  X(08).
      *保険組合せ番号
           03  BD002-HKNCOMBINUM         PIC  X(04).
      *主保険−保険番号
           03  BD002-SYUHKNNUM           PIC  X(03).
      *主保険−患者負担金額
           03  BD002-SYUHKNFTNMONEY      PIC  9(07).
      *主保険−計算負担金
           03  BD002-SYUCOMPFTN          PIC  9(07).
      *主保険−計算負担金（円単位記録用）
           03  BD002-SYUCOMPFTN-ENTANI   PIC  9(07)V9(01).
      *主保険−計算薬剤一部負担金
           03  BD002-SYUCOMPYKZFTN       PIC  9(07).
      *主保険−計算負担金計
           03  BD002-SYUCOMPTOTAL        PIC  9(07).
      *主保険−薬剤負担区分
           03  BD002-SYUYKZFTNKBN        PIC  X(01).
      *公費−負担情報
           03  BD002-KOH-AREA.
      *公費１−保険番号
               05  BD002-KOH1HKNNUM          PIC  X(03).
      *公費１−患者負担金額
               05  BD002-KOH1HKNFTNMONEY     PIC  9(07).
      *公費１−計算負担金
               05  BD002-KOH1COMPFTN         PIC  9(07).
      *公費１−計算負担金（円単位記録用）
               05  BD002-KOH1COMPFTN-ENTANI  PIC  9(07)V9(01).
      *公費１−計算薬剤一部負担金
               05  BD002-KOH1COMPYKZFTN      PIC  9(07).
      *公費１−計算負担金計
               05  BD002-KOH1COMPTOTAL       PIC  9(07).
      *公費１−薬剤負担区分
               05  BD002-KOH1YKZFTNKBN       PIC  X(01).
      *公費２−保険番号
               05  BD002-KOH2HKNNUM          PIC  X(03).
      *公費２−患者負担金額
               05  BD002-KOH2HKNFTNMONEY     PIC  9(07).
      *公費２−計算負担金
               05  BD002-KOH2COMPFTN         PIC  9(07).
      *公費２−計算負担金（円単位記録用）
               05  BD002-KOH2COMPFTN-ENTANI  PIC  9(07)V9(01).
      *公費２−計算薬剤一部負担金
               05  BD002-KOH2COMPYKZFTN      PIC  9(07).
      *公費２−計算負担金計
               05  BD002-KOH2COMPTOTAL       PIC  9(07).
      *公費２−薬剤負担区分
               05  BD002-KOH2YKZFTNKBN       PIC  X(01).
      *公費３−保険番号
               05  BD002-KOH3HKNNUM          PIC  X(03).
      *公費３−患者負担金額
               05  BD002-KOH3HKNFTNMONEY     PIC  9(07).
      *公費３−計算負担金
               05  BD002-KOH3COMPFTN         PIC  9(07).
      *公費３−計算負担金（円単位記録用）
               05  BD002-KOH3COMPFTN-ENTANI  PIC  9(07)V9(01).
      *公費３−計算薬剤一部負担金
               05  BD002-KOH3COMPYKZFTN      PIC  9(07).
      *公費３−計算負担金計
               05  BD002-KOH3COMPTOTAL       PIC  9(07).
      *公費３−薬剤負担区分
               05  BD002-KOH3YKZFTNKBN       PIC  X(01).
      *公費４−保険番号
               05  BD002-KOH4HKNNUM          PIC  X(03).
      *公費４−患者負担金額
               05  BD002-KOH4HKNFTNMONEY     PIC  9(07).
      *公費４−計算負担金
               05  BD002-KOH4COMPFTN         PIC  9(07).
      *公費４−計算負担金（円単位記録用）
               05  BD002-KOH4COMPFTN-ENTANI  PIC  9(07)V9(01).
      *公費４−計算薬剤一部負担金
               05  BD002-KOH4COMPYKZFTN      PIC  9(07).
      *公費４−計算負担金計
               05  BD002-KOH4COMPTOTAL       PIC  9(07).
      *公費４−薬剤負担区分
               05  BD002-KOH4YKZFTNKBN       PIC  X(01).
      *公費負担情報再定義
           03  BD002-KOHFTN-TABLE  REDEFINES   BD002-KOH-AREA.
               05  BD002-KOHFTN-TBL          OCCURS  4.
      *公費−保険番号
                 07  BD002-KOH-HKNNUM          PIC  X(03).
      *公費−患者負担金額
                 07  BD002-KOH-HKNFTNMONEY     PIC  9(07).
      *公費−計算負担金
                 07  BD002-KOH-COMPFTN         PIC  9(07).
      *公費−計算負担金（円単位記録用）
                 07  BD002-KOH-COMPFTN-ENTANI  PIC  9(07)V9(01).
      *公費−計算薬剤一部負担金
                 07  BD002-KOH-COMPYKZFTN      PIC  9(07).
      *公費−計算負担金計
                 07  BD002-KOH-COMPTOTAL       PIC  9(07).
      *公費−薬剤負担区分
                 07  BD002-KOH-YKZFTNKBN       PIC  X(01).
      *患者負担率
           03  BD002-PTFTNRATE           PIC  9(03).
      *部屋ＮＯ
           03  BD002-ROOMNUM             PIC  X(08).
      *病棟コード
           03  BD002-BYOTONUM            PIC  X(02).
      *請求書作成区分
           03  BD002-SKYKUKBN            PIC  X(01).
      *消費税対象金額
           03  BD002-TAX-TAISHOU         PIC  9(07).
      *消費税（内税）
           03  BD002-TAX-MONEY           PIC  9(07).
      *消費税（合計）
           03  BD002-SKYGK               PIC  9(07).
      *請求内容
           03  BD002-SKY-NAIYOU.
               05  BD002-SKY-TBL             OCCURS   17.
      *    保険点数
                   09  BD002-HKNTEN          PIC  9(07).
      *    金額
                   09  BD002-MONEY           PIC  9(07).
      *    適用外金額
                   09  BD002-TGMONEY         PIC  9(07).
      *    適用外金額（消費税あり）
                   09  BD002-TGMONEY-TAX     PIC  9(07).
      *請求内容
           03  BD002-SKY-NAIYOU-R        REDEFINES   BD002-SKY-NAIYOU.
      *診療料(01)
              05  BD002-SSU.
                  09  BD002-SSU-HKNTEN          PIC  9(07).
                  09  BD002-SSU-MONEY           PIC  9(07).
                  09  BD002-SSU-TGMONEY         PIC  9(07).
                  09  BD002-SSU-TGMONEY-TAX     PIC  9(07).
      *指導料(02)
              05  BD002-SDO.
                  09  BD002-SDO-HKNTEN          PIC  9(07).
                  09  BD002-SDO-MONEY           PIC  9(07).
                  09  BD002-SDO-TGMONEY         PIC  9(07).
                  09  BD002-SDO-TGMONEY-TAX     PIC  9(07).
      *在宅料(03)
              05  BD002-ZTK.
                  09  BD002-ZTK-HKNTEN          PIC  9(07).
                  09  BD002-ZTK-MONEY           PIC  9(07).
                  09  BD002-ZTK-TGMONEY         PIC  9(07).
                  09  BD002-ZTK-TGMONEY-TAX     PIC  9(07).
      *投薬料(04)
              05  BD002-TYK.
                  09  BD002-TYK-HKNTEN          PIC  9(07).
                  09  BD002-TYK-MONEY           PIC  9(07).
                  09  BD002-TYK-TGMONEY         PIC  9(07).
                  09  BD002-TYK-TGMONEY-TAX     PIC  9(07).
      *注射料(05)
              05  BD002-CSY.
                  09  BD002-CSY-HKNTEN          PIC  9(07).
                  09  BD002-CSY-MONEY           PIC  9(07).
                  09  BD002-CSY-TGMONEY         PIC  9(07).
                  09  BD002-CSY-TGMONEY-TAX     PIC  9(07).
      *処置料(06)
              05  BD002-SYC.
                  09  BD002-SYC-HKNTEN          PIC  9(07).
                  09  BD002-SYC-MONEY           PIC  9(07).
                  09  BD002-SYC-TGMONEY         PIC  9(07).
                  09  BD002-SYC-TGMONEY-TAX     PIC  9(07).
      *手術料(07)
              05  BD002-SJT.
                  09  BD002-SJT-HKNTEN          PIC  9(07).
                  09  BD002-SJT-MONEY           PIC  9(07).
                  09  BD002-SJT-TGMONEY         PIC  9(07).
                  09  BD002-SJT-TGMONEY-TAX     PIC  9(07).
      *麻酔(08)
              05  BD002-MSI.
                  09  BD002-MSI-HKNTEN          PIC  9(07).
                  09  BD002-MSI-MONEY           PIC  9(07).
                  09  BD002-MSI-TGMONEY         PIC  9(07).
                  09  BD002-MSI-TGMONEY-TAX     PIC  9(07).
      *検査料(09)
              05  BD002-KNS.
                  09  BD002-KNS-HKNTEN          PIC  9(07).
                  09  BD002-KNS-MONEY           PIC  9(07).
                  09  BD002-KNS-TGMONEY         PIC  9(07).
                  09  BD002-KNS-TGMONEY-TAX     PIC  9(07).
      *Ｘ線料(10)
              05  BD002-GZU.
                  09  BD002-GZU-HKNTEN          PIC  9(07).
                  09  BD002-GZU-MONEY           PIC  9(07).
                  09  BD002-GZU-TGMONEY         PIC  9(07).
                  09  BD002-GZU-TGMONEY-TAX     PIC  9(07).
      *リハ(11)
              05  BD002-ETC.
                  09  BD002-ETC-HKNTEN          PIC  9(07).
                  09  BD002-ETC-MONEY           PIC  9(07).
                  09  BD002-ETC-TGMONEY         PIC  9(07).
                  09  BD002-ETC-TGMONEY-TAX     PIC  9(07).
      *精神科専門療法(12)
              05  BD002-SSN.
                  09  BD002-SSN-HKNTEN          PIC  9(07).
                  09  BD002-SSN-MONEY           PIC  9(07).
                  09  BD002-SSN-TGMONEY         PIC  9(07).
                  09  BD002-SSN-TGMONEY-TAX     PIC  9(07).
      *放射線(13)
              05  BD002-HOU.
                  09  BD002-HOU-HKNTEN          PIC  9(07).
                  09  BD002-HOU-MONEY           PIC  9(07).
                  09  BD002-HOU-TGMONEY         PIC  9(07).
                  09  BD002-HOU-TGMONEY-TAX     PIC  9(07).
      *病理診断(14)
              05  BD002-BYR.
                  09  BD002-BYR-HKNTEN          PIC  9(07).
                  09  BD002-BYR-MONEY           PIC  9(07).
                  09  BD002-BYR-TGMONEY         PIC  9(07).
                  09  BD002-BYR-TGMONEY-TAX     PIC  9(07).
      *入院料(15)
              05  BD002-NYN.
                  09  BD002-NYN-HKNTEN          PIC  9(07).
                  09  BD002-NYN-MONEY           PIC  9(07).
                  09  BD002-NYN-TGMONEY         PIC  9(07).
                  09  BD002-NYN-TGMONEY-TAX     PIC  9(07).
      *療養担当手当(16)
              05  BD002-RYO.
                  09  BD002-RYO-HKNTEN          PIC  9(07).
                  09  BD002-RYO-MONEY           PIC  9(07).
                  09  BD002-RYO-TGMONEY         PIC  9(07).
                  09  BD002-RYO-TGMONEY-TAX     PIC  9(07).
      *合計  (17)
              05  BD002-TOTAL.
                  09  BD002-TOTAL-HKNTEN        PIC  9(07).
                  09  BD002-TOTAL-MONEY         PIC  9(07).
                  09  BD002-TOTAL-TGMONEY       PIC  9(07).
                  09  BD002-TOTAL-TGMONEY-TAX   PIC  9(07).
      *処方せん料再掲
           03  BD002-SHOHOU-SAI                 PIC  9(07).
      *保険適用外金額−消費税（再掲）
           03  BD002-TGMONEY-TAX-SAI         PIC  9(07).
      *自費１から１０
           03  BD002-JIHI-NAIYOU.
               05  BD002-JIHI-1              PIC  9(07). 
               05  BD002-JIHI-1-TAX          PIC  9(07). 
               05  BD002-JIHI-2              PIC  9(07). 
               05  BD002-JIHI-2-TAX          PIC  9(07). 
               05  BD002-JIHI-3              PIC  9(07). 
               05  BD002-JIHI-3-TAX          PIC  9(07). 
               05  BD002-JIHI-4              PIC  9(07). 
               05  BD002-JIHI-4-TAX          PIC  9(07). 
               05  BD002-JIHI-5              PIC  9(07). 
               05  BD002-JIHI-5-TAX          PIC  9(07). 
               05  BD002-JIHI-6              PIC  9(07). 
               05  BD002-JIHI-6-TAX          PIC  9(07). 
               05  BD002-JIHI-7              PIC  9(07). 
               05  BD002-JIHI-7-TAX          PIC  9(07). 
               05  BD002-JIHI-8              PIC  9(07). 
               05  BD002-JIHI-8-TAX          PIC  9(07). 
               05  BD002-JIHI-9              PIC  9(07). 
               05  BD002-JIHI-9-TAX          PIC  9(07). 
               05  BD002-JIHI-10             PIC  9(07). 
               05  BD002-JIHI-10-TAX         PIC  9(07). 
           03  BD002-JIHI-NAIYOU-R   REDEFINES  BD002-JIHI-NAIYOU.
               05  BD002-JIHI-TBL            OCCURS   10.
                 07  BD002-JIHI-TAXNASI        PIC  9(07).
                 07  BD002-JIHI-TAXARI         PIC  9(07).
      *自費小計（消費税なし）
           03  BD002-JIHI-TOTAL          PIC  9(07).
      *自費小計（消費税あり）
           03  BD002-JIHI-TOTAL-TAX      PIC  9(07).
      *自費金額消費税
           03  BD002-JIHI-TAX            PIC  9(07).
      *老人一部負担金
           03  BD002-RJN-FTN             PIC  9(07).
      *公費一部負担金
           03  BD002-KOH-FTN             PIC  9(07).
      *公費一部負担金（円単位）
           03  BD002-KOH-FTN-ENTANI      PIC  9(07)V9(01).
      *薬剤一部負担金
           03  BD002-YKZ-FTN             PIC  9(07).
      *レセプト出力用薬剤一部負担金
           03  BD002-RESE-YKZ-FTN        PIC  9(07).
      *公費対象薬剤区分
           03  BD002-KOHTAIYKZKBN        PIC  X(01).
      *調整金
           03  BD002-CHOSEI              PIC S9(07).
           03  BD002-CHOSEI-NAIYOU.
      *調整金内訳１
               05  BD002-CHOSEI1         PIC S9(07).
      *調整金内訳２
               05  BD002-CHOSEI2         PIC S9(07).
           03  BD002-CHOSEI-NAIYOU-R REDEFINES  BD002-CHOSEI-NAIYOU.
               05  BD002-RCHOSEI         PIC S9(07)
                                         OCCURS  2.
      *まとめ入力伝票番号
           03  BD002-GRP-DENPNUM         PIC 9(07).
      *まとめ入力連番
           03  BD002-GRP-RENNUM          PIC 9(02).
      *まとめ入力差額
           03  BD002-GRP-SGKMONEY        PIC S9(07).
      *まとめ発行方法フラグ
           03  BD002-GRP-HAKHOUFLG       PIC  9(01).
      *保証金額
           03  BD002-SECMONEY            PIC  9(07).
      *保険適用金額
           03  BD002-HKNTEKMONEY         PIC  9(07).
      *病院減免事由区分
           03  BD002-DISCOUNT-KBN        PIC  X(02).
      *病院減免事由
           03  BD002-DISCOUNT-BODY       PIC  X(160).
      *割引率区分
           03  BD002-DISCOUNT-RATEKBN    PIC  X(02).
      *定率定額区分
           03  BD002-DISCOUNT-TEIRITU    PIC  X(01).
      *割引率
           03  BD002-DISCOUNT-RATE       PIC  9(07).
      *減免金額
           03  BD002-DISCOUNT-MONEY      PIC  9(07).
      *労災保険−初診料
           03  BD002-RSISHOSHIN-MONEY    PIC  9(07).
      *労災保険−再診料
           03  BD002-RSISAISHIN-MONEY    PIC  9(07).
      *労災保険−指導料
           03  BD002-RSISDO-MONEY        PIC  9(07).
      *労災保険−その他
           03  BD002-RSIETC-MONEY        PIC  9(07).
      *労災保険−消費税（再掲）
           03  BD002-RSI-TAX-SAI         PIC  9(07).
      *労災保険−患者請求分円建て合計額
           03  BD002-RSI-TOTAL           PIC  9(07).
      *労災自賠−請求金額（日計表記載用）
           03  BD002-RSIJIBAI-SKYMONEY   PIC  9(07).
      *請求金額−消費税（再掲）
           03  BD002-SKYMONEY-TAX-SAI    PIC  9(07).
      *請求金額
           03  BD002-SKYMONEY            PIC  9(07).
      *入金合計額
           03  BD002-NYUKIN-TOTAL        PIC  9(07).
      *入金回数
           03  BD002-NYUKIN-KAISU        PIC  9(07).
      *未収理由
           03  BD002-MISYURIYU           PIC  X(02).
      *ドクター
           03  BD002-DRCD-G.
               05  BD002-DRCD-SIK            PIC  X(01).
               05  BD002-DRCD                PIC  X(04).
      *入院初診回数
           03  BD002-NYNSHOKAISU         PIC  9(02).
      *薬剤発券番号
           03  BD002-YKZKENNUM           PIC  9(05).
      *室料差額
           03  BD002-RMSAGAKU            PIC  9(07).
      *室料差額−消費税（再掲）
           03  BD002-RMSAGAKU-TAX-SAI    PIC  9(07).
      *食事１から食事１０
           03  BD002-SHOKUJI-NAIYOU.
               05  BD002-SHOKUJI1-NISSU  PIC  9(02).
               05  BD002-SHOKUJI1        PIC  9(07).
               05  BD002-SHOKUJI2-NISSU  PIC  9(02).
               05  BD002-SHOKUJI2        PIC  9(07).
               05  BD002-SHOKUJI3-NISSU  PIC  9(02).
               05  BD002-SHOKUJI3        PIC  9(07).
               05  BD002-SHOKUJI4-NISSU  PIC  9(02).
               05  BD002-SHOKUJI4        PIC  9(07).
               05  BD002-SHOKUJI5-NISSU  PIC  9(02).
               05  BD002-SHOKUJI5        PIC  9(07).
               05  BD002-SHOKUJI6-NISSU  PIC  9(02).
               05  BD002-SHOKUJI6        PIC  9(07).
               05  BD002-SHOKUJI7-NISSU  PIC  9(02).
               05  BD002-SHOKUJI7        PIC  9(07).
               05  BD002-SHOKUJI8-NISSU  PIC  9(02).
               05  BD002-SHOKUJI8        PIC  9(07).
               05  BD002-SHOKUJI9-NISSU  PIC  9(02).
               05  BD002-SHOKUJI9        PIC  9(07).
               05  BD002-SHOKUJI10-NISSU PIC  9(02).
               05  BD002-SHOKUJI10       PIC  9(07).
           03  BD002-SYOKUJI-NAIYOUR     
                     REDEFINES   BD002-SHOKUJI-NAIYOU.
               05  BD002-SYOKUJI-TBL     OCCURS   10.
                 07  BD002-SHOKUJI-NISSU   PIC  9(02).
                 07  BD002-SHOKUJI         PIC  9(07).
      *食事療養費情報（食事日数・食事療養費・標準負担額）
           03  BD002-SKJ-AREA.
               05  BD002-SYUSKJ-NISSU      PIC  9(02).
               05  BD002-SYUSKJ-RYOYOHI    PIC  9(07).
               05  BD002-SYUSKJ-FTN        PIC  9(07).
               05  BD002-SYUSKJ-FTN-RECE   PIC  9(07).
               05  BD002-SYUSKJ-FTNKBN     PIC  X(01).
           03  BD002-SKJ-AREA2.
               05  BD002-KOH1SKJ-NISSU     PIC  9(02).
               05  BD002-KOH1SKJ-RYOYOHI   PIC  9(07).
               05  BD002-KOH1SKJ-FTN       PIC  9(07).
               05  BD002-KOH1SKJ-FTN-RECE  PIC  9(07).
               05  BD002-KOH1SKJ-FTNKBN    PIC  X(01).
               05  BD002-KOH2SKJ-NISSU     PIC  9(02).
               05  BD002-KOH2SKJ-RYOYOHI   PIC  9(07).
               05  BD002-KOH2SKJ-FTN       PIC  9(07).
               05  BD002-KOH2SKJ-FTN-RECE  PIC  9(07).
               05  BD002-KOH2SKJ-FTNKBN    PIC  X(01).
               05  BD002-KOH3SKJ-NISSU     PIC  9(02).
               05  BD002-KOH3SKJ-RYOYOHI   PIC  9(07).
               05  BD002-KOH3SKJ-FTN       PIC  9(07).
               05  BD002-KOH3SKJ-FTN-RECE  PIC  9(07).
               05  BD002-KOH3SKJ-FTNKBN    PIC  X(01).
               05  BD002-KOH4SKJ-NISSU     PIC  9(02).
               05  BD002-KOH4SKJ-RYOYOHI   PIC  9(07).
               05  BD002-KOH4SKJ-FTN       PIC  9(07).
               05  BD002-KOH4SKJ-FTN-RECE  PIC  9(07).
               05  BD002-KOH4SKJ-FTNKBN    PIC  X(01).
           03  BD002-SKJ-AREA2R          REDEFINES   BD002-SKJ-AREA2.
               05  BD002-SKJ-TBL         OCCURS   4.
                 07  BD002-SKJ-NISSU       PIC  9(02).
                 07  BD002-SKJ-RYOYOHI     PIC  9(07).
                 07  BD002-SKJ-FTN         PIC  9(07).
                 07  BD002-SKJ-FTN-RECE    PIC  9(07).
                 07  BD002-SKJ-FTNKBN      PIC  X(01).
      *食事療養費（保険）
           03  BD002-RYOYOHI-SKJ         PIC  9(07).
      *食事負担額（保険：自己負担）
           03  BD002-SKYMONEY-SKJ        PIC  9(07).
      *食事負担額（保険：自己負担消費税）
           03  BD002-SKYMONEY-SKJ-TAX    PIC  9(07).
      *食事負担額（保険：自己負担合計）
           03  BD002-SKYMONEY-SKJ-KEI    PIC  9(07).
      *食事療養費（自費）
           03  BD002-RYOYOHI-SKJ-JIHI    PIC  9(07).
      *食事負担額（自費：自己負担）
           03  BD002-SKYMONEY-SKJ-JIHI   PIC  9(07).
      *食事負担額（自費：自己負担消費税）
           03  BD002-SKYMONEY-SKJ-JIHI-TAX
                                       PIC  9(07).
      *食事負担額（自費：自己負担合計）
           03  BD002-SKYMONEY-SKJ-JIHI-KEI
                                       PIC  9(07).
      *入院時生活療養費（保険）
           03  BD002-RYOYOHI-LIFE        PIC  9(07).
      *入院時生活療養費負担額（保険：自己負担）
           03  BD002-SKYMONEY-LIFE       PIC  9(07).
      *入院時生活療養費負担額（保険：自己負担消費税）
           03  BD002-SKYMONEY-LIFE-TAX   PIC  9(07).
      *入院時生活療養費負担額（保険：自己負担合計）
           03  BD002-SKYMONEY-LIFE-KEI   PIC  9(07).
      *入院時生活療養費費（自費）
           03  BD002-RYOYOHI-LIFE-JIHI   PIC  9(07).
      *入院時生活療養費負担額（自費：自己負担）
           03  BD002-SKYMONEY-LIFE-JIHI  PIC  9(07).
      *入院時生活療養費負担額（自費：自己負担消費税）
           03  BD002-SKYMONEY-LIFE-JIHI-TAX
                                       PIC  9(07).
      *入院時生活療養費負担額（自費：自己負担合計）
           03  BD002-SKYMONEY-LIFE-JIHI-KEI
                                       PIC  9(07).
      *食事負担（負担額別管理用）
           03  BD002-SKJ-PTFTN           OCCURS 3.
               05  BD002-SKJ-FTNGAKU     PIC  9(05).
               05  BD002-SKJ-FTNDAY      PIC  9(02).
      *再計算区分
           03  BD002-SAIKEISANKBN        PIC  X(01).
      *院外処方区分
           03  BD002-INGAISHOHOKBN       PIC  X(01).
      *同時診療伝票番号
           03  BD002-DOUJI-DENPNUM       PIC  9(07).
      *継続区分
           03  BD002-CONTKBN             PIC  X(01).
      *診療フラグテーブル
           03  BD002-DAY-AREA.
      *        診療フラグテーブル
             04  BD002-DAY-TBL.
      *        診療フラグ（１日から３１日）
               05  BD002-DAY-1           PIC  X(01).
               05  BD002-DAY-2           PIC  X(01).
               05  BD002-DAY-3           PIC  X(01).
               05  BD002-DAY-4           PIC  X(01).
               05  BD002-DAY-5           PIC  X(01).
               05  BD002-DAY-6           PIC  X(01).
               05  BD002-DAY-7           PIC  X(01).
               05  BD002-DAY-8           PIC  X(01).
               05  BD002-DAY-9           PIC  X(01).
               05  BD002-DAY-10          PIC  X(01).
               05  BD002-DAY-11          PIC  X(01).
               05  BD002-DAY-12          PIC  X(01).
               05  BD002-DAY-13          PIC  X(01).
               05  BD002-DAY-14          PIC  X(01).
               05  BD002-DAY-15          PIC  X(01).
               05  BD002-DAY-16          PIC  X(01).
               05  BD002-DAY-17          PIC  X(01).
               05  BD002-DAY-18          PIC  X(01).
               05  BD002-DAY-19          PIC  X(01).
               05  BD002-DAY-20          PIC  X(01).
               05  BD002-DAY-21          PIC  X(01).
               05  BD002-DAY-22          PIC  X(01).
               05  BD002-DAY-23          PIC  X(01).
               05  BD002-DAY-24          PIC  X(01).
               05  BD002-DAY-25          PIC  X(01).
               05  BD002-DAY-26          PIC  X(01).
               05  BD002-DAY-27          PIC  X(01).
               05  BD002-DAY-28          PIC  X(01).
               05  BD002-DAY-29          PIC  X(01).
               05  BD002-DAY-30          PIC  X(01).
               05  BD002-DAY-31          PIC  X(01).
           03  BD002-DAY-AREA-R  REDEFINES   BD002-DAY-AREA.
      *        診療回数テーブル
               05  BD002-DAY-TBL2.
                   07  BD002-DAY         PIC  X(01)
                                         OCCURS   31.
      *複数科まとめ識別伝票番号
           03  BD002-FUKU-DENPNUM        PIC  9(07).
      *複数科まとめ区分（１：継続　２：確定）
           03  BD002-FUKU-KBN            PIC  X(01).
      *在総診区分
           03  BD002-ZAITAKU             PIC  X(01).
      *診療区分別給付外点数
           03  BD002-KYUFUGAI.
               05  BD002-KYUFUGAI-TBL          OCCURS   6.
      *    給付対象外点数
                   09  BD002-KYUFUGAI-TEN      PIC  9(07).
      *診療区分別給付外点数再定義
           03  BD002-KYUFUGAI-R  REDEFINES   BD002-KYUFUGAI.
      *給付対象外点数（初診）
              05  BD002-KYUFUGAI-SHOSHIN-TEN    PIC  9(07).
      *給付対象外点数（指導）
              05  BD002-KYUFUGAI-SIDOU-TEN      PIC  9(07).
      *給付対象外点数（往診）
              05  BD002-KYUFUGAI-OSIN1-TEN      PIC  9(07).
      *給付対象外点数（往診／夜間）
              05  BD002-KYUFUGAI-OSIN2-TEN      PIC  9(07).
      *給付対象外点数（往診／深夜／緊急）
              05  BD002-KYUFUGAI-OSIN3-TEN      PIC  9(07).
      *給付対象外点数（合計）
              05  BD002-KYUFUGAI-GOKEI-TEN      PIC  9(07).
      *日別収納フラグ
           03  BD002-DAYINFFLG           PIC  X(01).
      *入院履歴番号
           03  BD002-NYUIN-RRKNUM        PIC  9(03).
      *会計変更区分
           03  BD002-ACCT-UPDKBN         PIC  X(01).
      *変則助成−患者負担金額
           03  BD002-JYO-HKNFTNMONEY     PIC  9(07).
      *変則助成−計算負担金
           03  BD002-JYO-COMPFTN         PIC  9(07).
      *変則助成−計算負担金（円単位記録用）
           03  BD002-JYO-COMPFTN-ENTANI  PIC  9(07)V9(01).
      *端末ＩＤ
           03  BD002-TERMID              PIC  X(16).
      *オペーレータＩＤ
           03  BD002-OPID                PIC  X(16).
      *作成年月日
           03  BD002-CREYMD              PIC  X(08).
      *更新年月日
           03  BD002-UPYMD               PIC  X(08).
      *更新時間
           03  BD002-UPHMS               PIC  X(06).
      *患者番号
           03  BD002-PTNUM               PIC  X(20).
