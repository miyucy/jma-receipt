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
      *    住所                COPY (CPORCSODR.INC)                   *
      *****************************************************************
      *****************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
       01  SODR-AREA.
      *
           03  SODR-HOSPID             PIC X(24).
           03  SODR-PTID               PIC 9(10).
           03  SODR-SRYKA              PIC X(02).
           03  SODR-HKNCOMBI           PIC 9(04).
           03  SODR-SRYYMD             PIC X(08).
      *
           03  SODR-UID8               PIC X(36).
      *
           03  SODR-PROCKBN            PIC X(01).
           03  SODR-IDOKBN             PIC X(02).
      *    0:正常 / 1:２重送信/ 2:ダミーデータ作成 
           03  SODR-NYUKBN-FLG         PIC 9(01).
      *    0:正常 / 1:２重送信/ 2:ダミーデータ作成 
           03  SODR-SYOKAI-FLG         PIC 9(01).
      *    0:正常 / 1:２重送信/ 2:ダミーデータ作成 
           03  SODR-BTUNUM-FLG         PIC 9(01).
      *    0:正常 / 1:２重送信/ 2:ダミーデータ作成 
           03  SODR-BRMNUM-FLG         PIC 9(01).
      *    0:正常 / 1:２重送信/ 2:ダミーデータ作成 
           03  SODR-SAGAKU-FLG         PIC 9(01).
      *    0:正常 / 1:２重送信※/ 1:ダミーデータ作成 
      *    ※１〜３件は正常、４件以上場合はエラー
           03  SODR-DR-FLG             PIC 9(01).
      *
           03  SODR-RC                 PIC S9(02).
