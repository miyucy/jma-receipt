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
      *    レセプト明細書（入院） 県単用項目ファイル             *
      *                               COPY (CPRCF067.INC)        *
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RECE67-REC.
           03  RECE67-KEY.
      *医療機関ＩＤ
               05  RECE67-HOSPID          PIC  X(24).
      *診療年月
               05  RECE67-SRYYM           PIC  9(06).
      *入外区分
               05  RECE67-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE67-PTID            PIC  9(10).
      *レセプト科
               05  RECE67-RECEKA          PIC  X(02).
      *審査支払機関
               05  RECE67-TEISYUTUSAKI    PIC  9(01).
      *レセプト種別
               05  RECE67-RECESYUBETU     PIC  9(04).
      *保険者番号        
               05  RECE67-HKNJANUM        PIC  X(08).
      *補助区分
               05  RECE67-HOJOKBN         PIC  X(01).
      *適用開始年月日
               05  RECE67-TEKSTYMD        PIC  X(08). 
      *主保険−給付割合
           03  RECE67-KYURATE             PIC  9(03).
      *療養の給付情報
           03  RECE67-TOTALTENINF         OCCURS  5.
      *合計点数
               05  RECE67-TOTALTEN        PIC  9(08).
      *負担金額
               05  RECE67-FTNMONEY        PIC  9(09).
      *実日数
               05  RECE67-JNISSU          PIC  9(02).
      *食事療養費情報
           03  RECE67-SHOKUJIINF          OCCURS  5.
      *食事日数
               05  RECE67-SHOKUJINISSU    PIC  9(02).
      *食事療養費
               05  RECE67-SHOKUJIRYOYOHI  PIC  9(09).
      *標準負担額
               05  RECE67-SHOKUJIFTN      PIC  9(09).
      *公費情報
           03  RECE67-KOHINF              OCCURS  4.
      *公費−負担者番号
               05  RECE67-KOHFTNJANUM     PIC  X(08).
      *公費−受給者番号
               05  RECE67-KOHJKYSNUM      PIC  X(20).
      *帳票データ
           03  RECE67-PRTDATA             PIC  X(4500).
