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
      *    レセプト明細書（県単用項目ファイル）                  *
      *                               COPY (CPRCF011.INC)        *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RECE11-REC.
           03  RECE11-KEY.
      *医療機関ＩＤ
               05  RECE11-HOSPID          PIC  X(24).
      *診療年月
               05  RECE11-SRYYM           PIC  9(06).
      *入外区分
               05  RECE11-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE11-PTID            PIC  9(10).
      *レセプト科
               05  RECE11-RECEKA          PIC  X(02).
      *審査支払機関
               05  RECE11-TEISYUTUSAKI    PIC  9(01).
      *レセプト種別
               05  RECE11-RECESYUBETU     PIC  9(04).
      *保険者番号        
               05  RECE11-HKNJANUM        PIC  X(08).
      *適用開始年月日
               05  RECE11-TEKSTYMD        PIC  X(08). 
      *帳票データ
           03  RECE11-PRTDATA             PIC  X(4500).
