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
      *    紹介履歴　        　 COPY (CPSYKRRK.INC)     *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  SYKRRK-REC.
      *キー
           03  SYK-KEY.
      *医療機関ＩＤ
               05  SYK-HOSPNUM              PIC 9(2).
      *患者ＩＤ
               05  SYK-PTID                PIC  9(10).
      *紹介区分
               05  SYK-SYKKBN              PIC  X(01).
      *紹介年月日
               05  SYK-SYKYMD              PIC  X(08).
      *紹介医療機関ＩＤ
           03  SYK-SYKIRYID                PIC  X(10).
      *紹介医療機関名称
           03  SYK-SYKIRYNAME              PIC  X(100).
      *紹介科
           03  SYK-SYKKA                   PIC  X(02).
      *ＳＯＡＰ
           03  SYK-SOAP                    PIC  X(100).
      *端末ＩＤ
           03  SYK-TERMID                  PIC  X(16).
      *オペレータＩＤ
           03  SYK-OPID                    PIC  X(16).
      *作成年月日
           03  SYK-CREYMD                  PIC  X(08).
      *更新年月日
           03  SYK-UPYMD                   PIC  X(08).
      *更新時間
           03  SYK-UPHMS                   PIC  X(06).
