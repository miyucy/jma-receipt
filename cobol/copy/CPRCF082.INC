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
      *    労災レセプト明細書（入院）     COPY (CPRCF082.INC)    *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RECE82-REC.
           03  RECE82-KEY.
      *医療機関ＩＤ
               05  RECE82-HOSPID          PIC  X(24).
      *診療年月
               05  RECE82-SRYYM           PIC  9(06).
      *入外区分
               05  RECE82-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE82-PTID            PIC  9(10).
      *レセプト科
               05  RECE82-RECEKA          PIC  X(02).
      *保険ＩＤ        
               05  RECE82-HKNID           PIC  9(10).
      *適用開始年月日
               05  RECE82-TEKSTYMD        PIC  X(08).
      *レセプト種別
           03  RECE82-RECESYUBETU         PIC  9(04).
      *患者番号
           03  RECE82-PTNUM               PIC  X(20).
      *診療科情報
           03  RECE82-SRYKAINF            OCCURS  20.
      *診療科
               05  RECE82-SRYKA           PIC  X(02).
      *カナ氏名
           03  RECE82-KANANAME            PIC  X(50).
      *漢字氏名
           03  RECE82-NAME                PIC  X(100).
      *性別
           03  RECE82-SEX                 PIC  X(01).
      *生年月日
           03  RECE82-BIRTHDAY            PIC  9(08).
      *死亡区分
           03  RECE82-DEATHKBN            PIC  X(01).
      *年齢
           03  RECE82-AGE                 PIC  9(03).
      *
      *主保険情報
           03  RECE82-HKN.
      *主保険−労災保険区分
               05  RECE82-HKNKBN          PIC  X(01).
      *主保険−保険番号
               05  RECE82-HKNNUM          PIC  X(03).
      *主保険−患者交付番号
               05  RECE82-KOFUNUM         PIC  X(14).
      *主保険−事業所名称
               05  RECE82-JIGYOUNAME      PIC  X(80).
      *主保険−所在地都道府県名
               05  RECE82-PREFNAME        PIC  X(20).
      *主保険−所在地都道府県区分
               05  RECE82-PREFKBN         PIC  X(01).
      *主保険−所在地郡市区名
               05  RECE82-CITYNAME        PIC  X(80).
      *主保険−所在地郡市区区分
               05  RECE82-CITYKBN         PIC  X(01).
      *主保険−新継再別
               05  RECE82-SINKEI          PIC  X(01).
      *主保険−転記事由
               05  RECE82-TENKI           PIC  X(01).
      *主保険−傷病年月日
               05  RECE82-SHOBYOYMD       PIC  X(08).
      *主保険−四肢特例区分
               05  RECE82-SISIKBN         PIC  X(01).
      *主保険−療養開始年月日
               05  RECE82-RYOSTYMD        PIC  X(08).
      *主保険−療養終了年月日
               05  RECE82-RYOEDYMD        PIC  X(08).
      *主保険−労災コメント
               05  RECE82-COMMENT         PIC  X(200).
      *主保険−災害区分
               05  RECE82-SAIGAIKBN       PIC  X(01).
      *
      *保険組合せ番号
           03  RECE82-HKNCOMBI            PIC  9(04).
      *
      *実日数
           03  RECE82-JNISSU              PIC  9(03).
      *
      *診療区分別点数情報
           03  RECE82-SRYKBNINF           OCCURS  30.
      *基本点数
               05  RECE82-KHNTEN          PIC  9(08).
      *回数
               05  RECE82-KAISU           PIC  9(05).
      *明細点数
               05  RECE82-TENSU           PIC  9(08).
      *明細点数（薬剤等）
               05  RECE82-TENSU-YAK       PIC  9(08).
      *
      *入院年月日
           03  RECE82-NYUINYMD            PIC  X(08).
      *
      *医療機関種別
           03  RECE82-HOSPSBT             PIC  X(01).
      *
      *病棟種別情報
           03  RECE82-BYOTOSYUBETUINF     OCCURS 31.
      *病棟番号
               05  RECE82-BYOTONUM        PIC  X(02).
      *病棟種別
               05  RECE82-BYOTOSYUBETU    PIC  X(02).
      *
      *入院基本料種別情報
           03  RECE82-NYUSYUINF           OCCURS  20.
      *入院基本料種別
               05  RECE82-NYUSYUBETU      PIC  X(10).
      *
      *入院基本料情報
           03  RECE82-NYUKHNINF           OCCURS  10.
      *入院基本料・加算
               05  RECE82-NYUKHNRYO       PIC  9(08).
      *入院日数
               05  RECE82-NYUKHNNISSU     PIC  9(02).
      *合計点数
               05  RECE82-NYUKHNKEI       PIC  9(08).
      *入院基本料情報２
           03  RECE82-NYUKHNINF2.
      *合計点数２
               05  RECE82-NYUKHNKEI2      PIC S9(08).
      *
      *特定入院基本料情報
           03  RECE82-NYUTOKINF           OCCURS  10.
      *特定入院料・その他（点）
               05  RECE82-NYUTOKRYO       PIC  9(08).
      *特定入院料・その他（略称）
               05  RECE82-NYUTOKRYO-RYAKU PIC  X(10).
      *入院日数
               05  RECE82-NYUTOKNISSU     PIC  9(02).
      *合計点数
               05  RECE82-NYUTOKKEI       PIC  9(08).
      *特定入院基本料情報２
           03  RECE82-NYUTOKINF2.
      *合計点数２
               05  RECE82-NYUTOKKEI2      PIC S9(08).
      *
      *入院基本料点数計
           03  RECE82-NYUTOTALTEN         PIC  9(08).
      *
      *合計点数
           03  RECE82-TOTALTEN            PIC  9(08).
      *合計点数（薬剤等）
           03  RECE82-TOTALTEN-YAK        PIC  9(08).
      *
      *診療区分別金額情報
           03  RECE82-SRYKBNINF2          OCCURS  5.
      *明細金額
               05  RECE82-KINGAKU2        PIC  9(09).
      *小計
           03  RECE82-KINGAKU2-SYO        PIC  9(09).
      *
      *診療区分別金額情報（その他）（自賠責のみ）
           03  RECE82-SRYKBNINF3          OCCURS  5.
      *明細金額（その他）
               05  RECE82-KINGAKU3        PIC  9(09).
      *小計（その他）
           03  RECE82-KINGAKU3-SYO        PIC  9(09).
      *入院室料加算（その他）
           03  RECE82-HEYA-NINZU          PIC  9(02).
           03  RECE82-HEYA-NISSU          PIC  9(02).
      *
      *食事種別情報
           03  RECE82-SHOKUJISYUINF       OCCURS   3.
      *食事種別
               05  RECE82-SHOKUJISYUBETU  PIC  X(04).
      *
      *食事基本料情報
           03  RECE82-SHOKUJIKHNINF       OCCURS   4.
      *食事基本料
               05  RECE82-SHOKUJIKHNRYO   PIC  9(09).
      *食事日数
               05  RECE82-SHOKUJIKHNNISSU PIC  9(02).
      *合計日数（食事）
           03  RECE82-SHOKUJITOTALDAY     PIC  9(02).
      *合計金額（食事）（ハ又はホ）
           03  RECE82-SHOKUJITOTALKIN     PIC  9(09).
      *
      *診断書料
           03  RECE82-SINDAN-TUU          PIC  9(02).
           03  RECE82-SINDAN-KIN          PIC  9(09).
      *明細書料
           03  RECE82-MEISAI-TUU          PIC  9(02).
           03  RECE82-MEISAI-KIN          PIC  9(09).
      *
      *合計金額（イ又はＡ）
           03  RECE82-TOTALKIN            PIC  9(09).
      *合計金額（薬剤等）（Ｂ）
           03  RECE82-TOTALKIN-YAK        PIC  9(09).
      *合計金額（Ｃ）
           03  RECE82-TOTALKIN2           PIC  9(09).
      *合計金額（他）（Ｄ）
           03  RECE82-TOTALKIN-ETC        PIC  9(09).
      *
      *初診時間区分
           03  RECE82-SHOSHINTIME         PIC  X(01).
      *初診乳児区分
           03  RECE82-SHOSHIN-NYU         PIC  X(01).
      *初診年月日
           03  RECE82-SHOSHINYMD          PIC  X(08).
      *救急医療管理加算区分
           03  RECE82-KYUKYU-PRTKBN       PIC  X(01).
      *救急医療管理加算算定日
           03  RECE82-KYUKYUYMD           PIC  X(08).
      *自賠責加算率
           03  RECE82-KSNRATE             PIC  9(03).
      *日別手技点・薬剤等点数情報
           03  RECE82-TENSUINF            OCCURS  31.
               05  RECE82-SYUTEN-JI       PIC  9(08).
               05  RECE82-YKZTEN-JI       PIC  9(08).
      *コメントカウントフラグ
           03  RECE82-COMCNTFLG           PIC  X(01).
      *診療回数テーブル
           03  RECE82-DAY-AREA.
               05  RECE82-DAY             PIC  9(03)
                                               OCCURS   31.
      *レセプト種別不明エラー情報
           03  RECE82-ERR-AREA.
               05  RECE82-ERR-ERRKBN      PIC 9(01).
               05  RECE82-ERR-DAY         PIC 9(02).
               05  RECE82-ERR-HKNCOMBINUM PIC 9(04).
               05  RECE82-ERR-TEKSTYMD    PIC 9(08).
               05  RECE82-ERR-TEKEDYMD    PIC 9(08).
      *予備
           03  RECE82-FILLER              PIC  X(82).
      *
