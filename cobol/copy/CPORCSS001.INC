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
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  03.05.01    NACL-藤原    07/04/19  グループ診療対応
      ************************************************************
       01  SS001-AREA.
           03  SS001-HOSPNUM           PIC 9(2).
           03  SS001-PTID              PIC 9(10).
           03  SS001-SRYYM             PIC X(06).
           03  SS001-HKNGRP-G.
               05  SS001-GIHO-FLG      PIC 9(01).
               05  SS001-GRSI-FLG      PIC 9(01).
               05  SS001-GJBI-FLG      PIC 9(01).
               05  SS001-NIHO-FLG      PIC 9(01).
               05  SS001-NRSI-FLG      PIC 9(01).
               05  SS001-NJBI-FLG      PIC 9(01).
