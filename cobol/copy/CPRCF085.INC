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
      *    労災レセプト明細書（入院）     COPY (CPRCF085.INC)    *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RECE85-REC.
           03  RECE85-KEY.
      *医療機関ＩＤ
               05  RECE85-HOSPID          PIC  X(24).
      *診療年月
               05  RECE85-SRYYM           PIC  9(06).
      *入外区分
               05  RECE85-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE85-PTID            PIC  9(10).
      *レセプト科
               05  RECE85-RECEKA          PIC  X(02).
      *保険ＩＤ        
               05  RECE85-HKNID           PIC  9(10).
      *適用開始年月日
               05  RECE85-TEKSTYMD        PIC  X(08).
      *剤番号
               05  RECE85-ZAINUM          PIC  9(08).
      *連番号
               05  RECE85-RENNUM          PIC  9(02).
      *患者番号
           03  RECE85-PTNUM               PIC  X(20).
      *診療科
           03  RECE85-SRYKA               PIC  X(02).
      *診療区分
           03  RECE85-SRYKBN              PIC  X(02).
      *診療種別区分
           03  RECE85-SRYSYUKBN           PIC  X(03).
      *自費金額
           03  RECE85-JIHIMONEY           PIC  9(07).
      *診療行為情報
           03  RECE85-SRYACTINF           OCCURS  5.
      *診療コード
               05  RECE85-SRYCD           PIC  X(09).
      *数量
               05  RECE85-SRYSURYO        PIC  9(05)V9(03).
      *回数
               05  RECE85-SRYKAISU        PIC  9(03).
      *単位コード
               05  RECE85-TANICD          PIC  9(03).
      *単位名称有効桁数
               05  RECE85-TANIMOJISU      PIC  9(01).
      *単位名称
               05  RECE85-TANINAME        PIC  X(24).
      *点数識別区分
               05  RECE85-TENSIKIBETU     PIC  9(01).
      *点数
               05  RECE85-TEN             PIC  9(09)V9(02).
      *明細請求フラグ
               05  RECE85-MEISKYFLG       PIC  X(01).
      *自動算定区分
               05  RECE85-AUTOKBN         PIC  X(01).
      *名称入力番号
               05  RECE85-INPUTNUM        PIC  9(03).
      *点数欄集計先識別
               05  RECE85-TENTTLKBN       PIC  9(03).
      *名称情報
           03  RECE85-NAMEINF             OCCURS  5.
      *漢字有効桁数
               05  RECE85-YUKOKETA        PIC  9(02).
      *漢字名称
               05  RECE85-NAME            PIC  X(200).
      *識別フラグ情報
           03  RECE85-SIKFLGINF           OCCURS  5.
      *識別フラグ
               05  RECE85-SIKFLG          PIC  X(01).
      *データ区分情報
          03  RECE85-DATAKBNINF           OCCURS  5.
      *データ区分
              05  RECE85-DATAKBN          PIC  9(01).
      *包括対象検査情報
          03  RECE85-HOUKNSKBNINF         OCCURS  5.
      *包括対象検査
              05  RECE85-HOUKNSKBN        PIC  9(02).
      *検査等実施判断情報
          03  RECE85-KNSJISKBNINF         OCCURS  5.
      *検査等実施判断
              05  RECE85-KNSJISKBN        PIC  9(01).
      *各種番号等情報
          03  RECE85-CDKBNINF             OCCURS  5.
      *各種番号等
              05  RECE85-CDKBN-KBN        PIC  X(01).
              05  RECE85-CDKBN-SYO        PIC  9(01).
              05  RECE85-CDKBN-BU         PIC  9(02).
              05  RECE85-CDKBN-KBNNUM     PIC  9(03).
              05  RECE85-CDKBN-KBNNUM-EDA PIC  9(02).
              05  RECE85-CDKBN-KOUBAN     PIC  9(02).
              05  RECE85-KOUHYOJYUNNUM    PIC  9(09).
