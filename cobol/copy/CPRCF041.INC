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
      *    レセプト明細書     COPY (CPRCF041.INC)                *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.01.01   NACL-門脇     03.02.06  コメントカウントフラグの追加
      *  01.01.02   NACL-門脇     03.06.19  実日数テーブルの追加
      ************************************************************
      *01  RECE41-REC.
           03  RECE41-KEY.
      *医療機関ＩＤ
               05  RECE41-HOSPID          PIC  X(24).
      *診療年月
               05  RECE41-SRYYM           PIC  9(06).
      *入外区分
               05  RECE41-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE41-PTID            PIC  9(10).
      *レセプト科
               05  RECE41-RECEKA          PIC  X(02).
      *保険ＩＤ        
               05  RECE41-HKNID           PIC  9(10).
      *適用開始年月日
               05  RECE41-TEKSTYMD        PIC  X(08). 
      *レセプト種別
           03  RECE41-RECESYUBETU         PIC  9(04).
      *患者番号
           03  RECE41-PTNUM               PIC  X(20).
      *診療科情報
           03  RECE41-SRYKAINF            OCCURS  20.
      *診療科
               05  RECE41-SRYKA           PIC  X(02).
      *カナ氏名
           03  RECE41-KANANAME            PIC  X(50).
      *漢字氏名
           03  RECE41-NAME                PIC  X(100).
      *性別
           03  RECE41-SEX                 PIC  X(01).
      *生年月日
           03  RECE41-BIRTHDAY            PIC  9(08).
      *死亡区分
           03  RECE41-DEATHKBN            PIC  X(01).
      *
      *主保険情報
           03  RECE41-HKN.
      *主保険−労災保険区分
               05  RECE41-HKNKBN          PIC  X(01).
      *主保険−保険番号
               05  RECE41-HKNNUM          PIC  X(03).
      *主保険−患者交付番号
               05  RECE41-KOFUNUM         PIC  X(14).
      *主保険−事業所名称
               05  RECE41-JIGYOUNAME      PIC  X(80).
      *主保険−所在地都道府県名
               05  RECE41-PREFNAME        PIC  X(20).
      *主保険−所在地都道府県区分
               05  RECE41-PREFKBN         PIC  X(01).
      *主保険−所在地郡市区名
               05  RECE41-CITYNAME        PIC  X(80).
      *主保険−所在地郡市区区分
               05  RECE41-CITYKBN         PIC  X(01).
      *主保険−新継再別
               05  RECE41-SINKEI          PIC  X(01).
      *主保険−転記事由
               05  RECE41-TENKI           PIC  X(01).
      *主保険−傷病年月日
               05  RECE41-SHOBYOYMD       PIC  X(08).
      *主保険−四肢特例区分
               05  RECE41-SISIKBN         PIC  X(01).
      *主保険−療養開始年月日
               05  RECE41-RYOSTYMD        PIC  X(08).
      *主保険−療養終了年月日
               05  RECE41-RYOEDYMD        PIC  X(08).
      *主保険−損傷区分
               05  RECE41-SONSHOUKBN      PIC  X(02).
      *主保険−損傷区分−枝番
               05  RECE41-SONSHOUKBN-EDANUM  PIC  X(01).
      *主保険−診察年月日
               05  RECE41-SINSATUYMD      PIC  X(08).
      *主保険−労災コメント
               05  RECE41-COMMENT         PIC  X(200).
      *主保険−災害区分
               05  RECE41-SAIGAIKBN       PIC  X(01).
      *
      *保険組合せ番号
           03  RECE41-HKNCOMBI            PIC  9(04).
      *
      *病棟区分
           03  RECE41-BYOTOKBN            PIC  X(02).
      *
      *実日数
           03  RECE41-JNISSU              PIC  9(03).
      *
      *診療区分別点数情報
           03  RECE41-SRYKBNINF           OCCURS  50.
      *基本点数
               05  RECE41-KHNTEN          PIC  9(08).
      *回数
               05  RECE41-KAISU           PIC  9(05).
      *明細点数
               05  RECE41-TENSU           PIC  9(08).
      *明細点数（薬剤等）
               05  RECE41-TENSU-YAK       PIC  9(08).
      *合計点数
           03  RECE41-TOTALTEN            PIC  9(08).
      *合計点数（薬剤等）
           03  RECE41-TOTALTEN-YAK        PIC  9(08).
      *合計金額
           03  RECE41-TOTALKIN            PIC  9(09).
      *合計金額（薬剤等）
           03  RECE41-TOTALKIN-YAK        PIC  9(09). 
      *
      *診療区分別金額情報
           03  RECE41-SRYKBNINF2          OCCURS  10.
      *回数
               05  RECE41-KAISU2          PIC  9(05).
      *初再診年月日
               05  RECE41-SYOSAIYMD2      PIC  X(08).
      *明細金額
               05  RECE41-KINGAKU2        PIC  9(09).
      *合計金額
           03  RECE41-TOTALKIN2           PIC  9(09).
      *合計金額（その他）
           03  RECE41-TOTALKIN2-ETC       PIC  9(09).
      *
      *診断書料
           03  RECE41-SINDAN-TUU          PIC  9(02).
           03  RECE41-SINDAN-KIN          PIC  9(09).
      *明細書料
           03  RECE41-MEISAI-TUU          PIC  9(02).
           03  RECE41-MEISAI-KIN          PIC  9(09).
      *
      *食事療養費情報
           03  RECE41-SHOKUJIINF.
      *食事日数
               05  RECE41-SHOKUJINISSU    PIC  9(02).
      *食事療養費
               05  RECE41-SHOKUJIRYOYOHI  PIC  9(09).
      *標準負担額
               05  RECE41-SHOKUJIFTN      PIC  9(09).
      *標準負担区分
           03  RECE41-SHOKUJIFTNKBN       PIC  X(01).
      *
      *初診時間区分
           03  RECE41-SHOSHINTIME         PIC  X(01).
      *初診乳児区分
           03  RECE41-SHOSHIN-NYU         PIC  X(01).
      *初診年月日
           03  RECE41-SHOSHINYMD          PIC  X(08).
      *再診時間区分
           03  RECE41-SAISHINTIME         PIC  X(01).
      *再診摘要印刷区分
           03  RECE41-SAISHIN-PRTKBN      PIC  X(01).
      *再診摘要印刷区分２
           03  RECE41-SAISHIN-PRTKBN2     PIC  X(01).
      *外来管理加算摘要印刷区分
           03  RECE41-GAIRAIKSN-PRTKBN    PIC  X(01).
      *継続管理加算印刷区分
           03  RECE41-KEIZOKU-PRTKBN      PIC  X(01).
      *救急医療管理加算区分
           03  RECE41-KYUKYU-PRTKBN       PIC  X(01).
      *救急医療管理加算算定日
           03  RECE41-KYUKYUYMD           PIC  X(08).
      *外来管理加算（特例:５２）
           03  RECE41-GAITOKU-PRTKBN1     PIC  X(01).
           03  RECE41-GAITOKU-TEN1        PIC  9(03).
           03  RECE41-GAITOKU-KAISU1      PIC  9(02).
      *外来管理加算（特例:２６）
           03  RECE41-GAITOKU-PRTKBN2     PIC  X(01).
           03  RECE41-GAITOKU-TEN2        PIC  9(03).
           03  RECE41-GAITOKU-KAISU2      PIC  9(02).
      *検査区分
           03  RECE41-KENSAKBN            PIC  X(01).
      *前回検査年月日
           03  RECE41-KENSAYMD-ZEN        PIC  X(08).
      *自賠責加算率
           03  RECE41-KSNRATE             PIC  9(03).
      *通院日情報
           03  RECE41-TUUININF            OCCURS  31.
               05  RECE41-TUUIN-DAY       PIC  X(01).
      *通院日数計
           03  RECE41-TUUIN-KEI           PIC  9(02).
      *日別手技点・薬剤等点数情報
           03  RECE41-TENSUINF            OCCURS  31.
               05  RECE41-SYUTEN-JI       PIC  9(09).
               05  RECE41-YKZTEN-JI       PIC  9(09).
      *コメントカウントフラグ
           03  RECE41-COMCNTFLG           PIC  X(01).
      *
      *実日数テーブル情報
           03  RECE41-JNISSUTBLINF        OCCURS 31.
      *実日数テーブル
               05  RECE41-JNISSUTBL       PIC  X(01).
      *
      *予備
           03  RECE41-FILLER              PIC  X(82).
      *
