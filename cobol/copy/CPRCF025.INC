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
      *    レセプト電算・ 合計レコード         (CPRCF025.INC)    *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RECE25-REC.
      *レコード共通
           03  RECE25-KYOTU-AREA.
      *レコード長
               05  RECE25-LENGTH          PIC  9(04).
      *レコード種別
               05  RECE25-SYUBETU         PIC  9(02).
      *レセプト番号
               05  RECE25-RECENUM         PIC  9(06).
      *レコード番号
               05  RECE25-RECNUM          PIC  9(03).
      *合計点数情報
           03  RECE25-TOTALTENINF.
               05  RECE25-TOTALTENINF-TBL   OCCURS  3.
      *合計点数
                   07  RECE25-TOTALTEN    PIC  X(08).
      *負担金額情報
           03  RECE25-FTNMONEYINF.
      *負担金額（第一公費）
               05  RECE25-FTNMONEY-KOH1   PIC  X(08).
      *負担金額（第二公費）
               05  RECE25-FTNMONEY-KOH2   PIC  X(08).
      *負担金額（医療保険）
               05  RECE25-FTNMONEY-HKN    PIC  X(09).
      *老人減免区分
           03  RECE25-RJNGENMENKBN        PIC  X(01).
      *老人外来金額
           03  RECE25-RJNGAIFTN           PIC  X(06).
      *老人入院金額情報
           03  RECE25-RJNNYUFTNINF.
      *予備        
               05  RECE25-YOBI1           PIC  X(08).
      *老人入院金額
               05  RECE25-RJNNYUFTN       PIC  X(06).
      *国保減免区分
           03  RECE25-KKHGENMENKBN        PIC  X(01).
      *国保減額割合
           03  RECE25-KKHGENGAKURATE      PIC  X(03).
      *国保減額金額
           03  RECE25-KKHGENGAKU          PIC  X(06).
      *割引点数単価
           03  RECE25-DISCOUNTTENTNK      PIC  X(02).
      *食事療養費情報
           03  RECE25-SHOKUJIINF.
               05  RECE25-SHOKUJIINF-TBL  OCCURS  3.
      *食事日数
                   07  RECE25-SHOKUJINISSU    PIC  X(02).
      *食事療養費
                   07  RECE25-SHOKUJIRYOYOHI  PIC  X(08).
      *標準負担区分
           03  RECE25-SHOKUJIFTNKBN       PIC  X(01).
      *予備        
           03  RECE25-YOBI2               PIC  X(01).
      *老人第二情報
           03  RECE25-ROU2INF.
      *合計点数（老人第二）
               05  RECE25-TOTALTEN-ROU2   PIC  X(08).
      *負担金額（老人第二）
               05  RECE25-FTNMONEY-ROU2   PIC  X(08).
      *食事日数（老人第二）
               05  RECE25-SHOKUJINISSU-ROU2
                                          PIC  X(02).
      *食事療養費（老人第二）
               05  RECE25-SHOKUJIRYOYOHI-ROU2
                                          PIC  X(08).
      *負担金額情報（老人第一、第二）
           03  RECE25-FTNMONEYINF-ROU.
               05  RECE25-FTNMONEY-ROUTBL   OCCURS  4.
      *負担金額
                   07  RECE25-FTNMONEY-ROU  PIC  X(06).
      *薬剤一部負担金情報
           03  RECE25-YKZFTNINF.
               05  RECE25-YKZFTNINF-TBL     OCCURS  4.
      *薬剤一部負担金
                   07  RECE25-YKZFTN        PIC  X(05).
      *予備        
           03  RECE25-YOBI3               PIC  X(57).
      *改行コード
           03  RECE25-RETURNCD            PIC  X(01).
      