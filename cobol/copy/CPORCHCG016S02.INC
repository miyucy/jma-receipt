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
      *    指定診療行為件数調サブパラメタ　COPY (CPORCHCG016S02.INC)
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  HCG016S02-AREA.
           03  HCG016S02-OT-AREA.
               05  HCG016S02-HENKYAKU-MAX      PIC 9(05).
               05  HCG016S02-HENKYAKU-TBL      OCCURS  200.
                   07  HCG016S02-SRYKA         PIC  X(02).
                   07  HCG016S02-HKNCOMBI      PIC  X(04).
                   07  HCG016S02-SRYKBN        PIC  X(02).
                   07  HCG016S02-SRYSYUKBN     PIC  X(03).
                   07  HCG016S02-ZAITEN        PIC  9(08).
                   07  HCG016S02-ZAIKAISU      PIC  9(07).
                   07  HCG016S02-MEISAISU      PIC  9(07).
                   07  HCG016S02-SRYCDTOTAL    PIC  9(14).
                   07  HCG016S02-SURYOUTOTAL   PIC  9(07)V9(03).
                   07  HCG016S02-RUIKEITOTAL   PIC  9(15)V9(03).
                   07  HCG016S02-SRYCD-OCC     OCCURS  20.
                       09  HCG016S02-SURYO     PIC  9(05).
                       09  HCG016S02-SRYCD     PIC  X(09).
                   07  HCG016S02-DAY-TBL.
                       09  HCG016S02-DAY       PIC  9(03)
                                               OCCURS  31.
           03  HCG016S02-RC                    PIC S9(9) BINARY.
