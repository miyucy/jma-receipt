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
      *    レセプト明細書     COPY (CPRCF045.INC)                *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RECE45-REC.
           03  RECE45-KEY.
      *医療機関ＩＤ
               05  RECE45-HOSPID          PIC  X(24).
      *診療年月
               05  RECE45-SRYYM           PIC  9(06).
      *入外区分
               05  RECE45-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE45-PTID            PIC  9(10).
      *レセプト科
               05  RECE45-RECEKA          PIC  X(02).
      *保険ＩＤ        
               05  RECE45-HKNID           PIC  9(10).
      *適用開始年月日
               05  RECE45-TEKSTYMD        PIC  X(08). 
      *剤番号
               05  RECE45-ZAINUM          PIC  9(05).
      *連番号
               05  RECE45-RENNUM          PIC  9(02).
      *患者番号
           03  RECE45-PTNUM               PIC  X(20).
      *診療科
           03  RECE45-SRYKA               PIC  X(02).
      *診療区分
           03  RECE45-SRYKBN              PIC  X(02).
      *診療種別区分
           03  RECE45-SRYSYUKBN           PIC  X(03).
      *自費金額
           03  RECE45-JIHIMONEY           PIC  9(07).
      *診療行為情報
           03  RECE45-SRYACTINF           OCCURS  5.
      *診療コード
               05  RECE45-SRYCD           PIC  X(09).
      *数量
               05  RECE45-SRYSURYO        PIC  9(05)V9(03).
      *回数
               05  RECE45-SRYKAISU        PIC  9(03).
      *単位コード
               05  RECE45-TANICD          PIC  9(03).
      *単位名称有効桁数
               05  RECE45-TANIMOJISU      PIC  9(01).
      *単位名称
               05  RECE45-TANINAME        PIC  X(24).
      *点数識別区分
               05  RECE45-TENSIKIBETU     PIC  9(01).
      *点数
               05  RECE45-TEN             PIC  9(09)V9(02).
      *明細請求フラグ
               05  RECE45-MEISKYFLG       PIC  X(01).
      *自動算定区分
               05  RECE45-AUTOKBN         PIC  X(01).
      *名称入力番号
               05  RECE45-INPUTNUM        PIC  9(03).
      *点数欄集計先識別
               05  RECE45-TENTTLKBN       PIC  9(03).
      *名称情報
           03  RECE45-NAMEINF             OCCURS  5.
      *漢字有効桁数
               05  RECE45-YUKOKETA        PIC  9(02).
      *漢字名称
               05  RECE45-NAME            PIC  X(200).
      *識別フラグ情報
           03  RECE45-SIKFLGINF           OCCURS  5.
      *識別フラグ
               05  RECE45-SIKFLG          PIC  X(01).
      