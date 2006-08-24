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
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
       01  SYUPARA01-AREA.
           03  SYUPARA01-NYUGAIKBN         PIC X(01).
           03  SYUPARA01-NYU-MISYU         PIC S9(10).
           03  SYUPARA01-GAI-MISYU         PIC S9(10).
           03  SYUPARA01-NYU-NYUKIN        PIC S9(10).
           03  SYUPARA01-GAI-NYUKIN        PIC S9(10).
      *    発行フラグ（０：新規、１：再発行、２：訂正、３：入金 ４：月別）
           03  SYUPARA01-HAKKOFLG          PIC 9(01).
           03  SYUPARA01-SKYSUMFLG         PIC 9(01).
           03  SYUPARA01-ZEROSKYKBN        PIC X(01).
           03  SYUPARA01-DENPPRTYMD        PIC X(08).
