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
      *  レセプトコメントマスター       (CPRECECOM.INC)
      *****************************************************************
      *  修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
      *01  RECECOM-REC.
           03  RECECOM-KEY.
      *医療機関ＩＤ
               05  RECECOM-HOSPID        PIC X(24).
      *患者ＩＤ
               05  RECECOM-PTID          PIC 9(10).
      *診療科
               05  RECECOM-SRYKA         PIC X(02).
      *診療年月
               05  RECECOM-SRYYM         PIC X(06).
      *保険組合せ番号
               05  RECECOM-HKNCOMBI      PIC 9(04).
      *診療日
               05  RECECOM-SRYDD         PIC X(02).
      *コメント
           03  RECECOM-COMMENT           PIC X(800).
      *端末ＩＤ
           03  RECECOM-TERMID            PIC X(16).
      *オペーレータＩＤ
           03  RECECOM-OPID              PIC X(16).
      *作成年月日
           03  RECECOM-CREYMD            PIC X(08).
      *更新年月日
           03  RECECOM-UPYMD             PIC X(08).
      *更新時間
           03  RECECOM-UPHMS             PIC X(06).
