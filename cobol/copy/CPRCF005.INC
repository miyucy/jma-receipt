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
      *    レセプト明細書     COPY (CPRCF05.INC)        *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01.06.29  保険者番号・
      *                                     適用開始年月日の追加
      *  01.00.02    NACL-藤原    03.01.17  データ区分の追加
      ************************************************************
      *01  RECE05-REC.
           03  RECE05-KEY.
      *医療機関ＩＤ
               05  RECE05-HOSPID          PIC  X(24).
      *診療年月
               05  RECE05-SRYYM           PIC  9(06).
      *入外区分
               05  RECE05-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE05-PTID            PIC  9(10).
      *レセプト科
               05  RECE05-RECEKA          PIC  X(02).
      *審査支払機関
               05  RECE05-TEISYUTUSAKI    PIC  9(01).
      *レセプト種別
               05  RECE05-RECESYUBETU     PIC  9(04).
      *保険者番号        
               05  RECE05-HKNJANUM        PIC  X(08).
      *適用開始年月日
               05  RECE05-TEKSTYMD        PIC  X(08). 
      *剤番号
               05  RECE05-ZAINUM          PIC  9(05).
      *連番号
               05  RECE05-RENNUM          PIC  9(02).
      *公費分離区分
           03  RECE05-KOHBUNRI            PIC  9(01).
      *患者番号
           03  RECE05-PTNUM               PIC  X(20).
      *診療科
           03  RECE05-SRYKA               PIC  X(02).
      *診療区分
           03  RECE05-SRYKBN              PIC  X(02).
      *診療種別区分
           03  RECE05-SRYSYUKBN           PIC  X(03).
      *自費金額
           03  RECE05-JIHIMONEY           PIC  9(07).
      *診療行為情報
           03  RECE05-SRYACTINF           OCCURS  5.
      *診療コード
               05  RECE05-SRYCD           PIC  X(09).
      *数量
               05  RECE05-SRYSURYO        PIC  9(05)V9(03).
      *回数
               05  RECE05-SRYKAISU        PIC  9(03).
      *単位コード
               05  RECE05-TANICD          PIC  9(03).
      *単位名称有効桁数
               05  RECE05-TANIMOJISU      PIC  9(01).
      *単位名称
               05  RECE05-TANINAME        PIC  X(24).
      *点数識別区分
               05  RECE05-TENSIKIBETU     PIC  9(01).
      *点数
               05  RECE05-TEN             PIC  9(09)V9(02).
      *明細請求フラグ
               05  RECE05-MEISKYFLG       PIC  X(01).
      *自動算定区分
               05  RECE05-AUTOKBN         PIC  X(01).
      *名称入力番号
               05  RECE05-INPUTNUM        PIC  9(03).
      *点数欄集計先識別
               05  RECE05-TENTTLKBN       PIC  9(03).
      *名称情報
           03  RECE05-NAMEINF             OCCURS  5.
      *漢字有効桁数
               05  RECE05-YUKOKETA        PIC  9(02).
      *漢字名称
               05  RECE05-NAME            PIC  X(200).
      *データ区分情報
          03  RECE05-DATAKBNINF           OCCURS  5.
              05  RECE05-DATAKBN          PIC  9(01).

