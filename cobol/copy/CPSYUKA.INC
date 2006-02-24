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
      *****************************************************************
      *  主科テーブル       (CPSYUKA.INC)
      *****************************************************************
      *  修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
      *01  SYUKA-REC.
           03  SYUKA-KEY.
      *医療機関ＩＤ
               05  SYUKA-HOSPID        PIC X(24).
      *入外区分
               05  SYUKA-NYUGAIKBN     PIC X(01).
      *患者ＩＤ
               05  SYUKA-PTID          PIC 9(10).
      *会計区分
               05  SYUKA-TEN-KBN       PIC X(01).
      *診療年月
               05  SYUKA-SRYYM         PIC 9(06).
      *審査支払機関
               05  SYUKA-TEISYUTUSAKI  PIC 9(01).
      *保険者番号
               05  SYUKA-HKNJANUM      PIC X(08).
      *補助区分
               05  SYUKA-HOJOKBN       PIC X(01).
      *レセプト種別
               05  SYUKA-RECESYUBETU   PIC X(04).
      *診療科
               05  SYUKA-SRYKA         PIC X(02).
      *診療科（入力）
           03  SYUKA-SRYKA-INPUT       PIC X(02).
      *保険組合せ番号
           03  SYUKA-HKNCOMBI-AREA.
               05  SYUKA-HKNCOMBI      PIC 9(04)   OCCURS  10.
      *請求点数合計
           03  SYUKA-TENSU             PIC S9(09).
      *受診回数合計(入院外)
           03  SYUKA-KAISU             PIC 9(03).
      *通算日数合計(入院)
           03  SYUKA-NISSU             PIC 9(03).
      *終了日
           03  SYUKA-EDDAY             PIC 9(02).
      *未請求レセで使う予定
           03  SYUKA-MISEIKYU-FLG      PIC X(02).
      *削除フラグ
           03  SYUKA-DLT-FLG           PIC X(01).
      *端末ＩＤ
           03  SYUKA-TERMID            PIC X(16).
      *オペーレータＩＤ
           03  SYUKA-OPID              PIC X(16).
      *作成年月日
           03  SYUKA-CREYMD            PIC X(08).
      *更新年月日
           03  SYUKA-UPYMD             PIC X(08).
      *更新時間
           03  SYUKA-UPHMS             PIC X(06).
