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
       01  SC12.
              03  SC12-PRTYM            PIC  X(16).
              03  SC12-PAGE             PIC  X(3).
              03  SC12-SRYKA            PIC  X(16).
              03  SC12-FTNJANUM         PIC  X(8).
              03  SC12-CITYNAME         PIC  X(20).
              03  SC12-SEIYMD           PIC  X(22).
              03  SC12-HOSPCD           PIC  X(7).
              03  SC12-ADRS             PIC  X(30).
              03  SC12-HOSPNAME         PIC  X(30).
              03  SC12-KAISETUNAME      PIC  X(30).
              03  SC12-GKENSU-TBL       OCCURS  6.
                  05  SC12-GKENSU       PIC  X(6).
              03  SC12-GOKEI            PIC  X(6).
              03  SC12-GNISSU-TBL       OCCURS  6.
                  05  SC12-GNISSU       PIC  X(3).
              03  SC12-GTENSU-TBL       OCCURS  6.
                  05  SC12-GTENSU       PIC  X(9).
              03  SC12-GYKZFTN-TBL      OCCURS  6.
                  05  SC12-GYKZFTN      PIC  X(7).
              03  SC12-GSKYMONEY-TBL    OCCURS  6.
                  05  SC12-GSKYMONEY    PIC  X(7).
              03  SC12-GKOUJYO-TBL      OCCURS  6.
                  05  SC12-GKOUJYO      PIC  X(7).
              03  SC12-GCHOKBN-TBL      OCCURS  6.
                  05  SC12-GCHOKBN      PIC  X(5).
              03  SC12-JKYSNUM-TBL      OCCURS  23.
                  05  SC12-JKYSNUM      PIC  X(40).
              03  SC12-NAME-TBL         OCCURS  23.
                  05  SC12-NAME         PIC  X(32).
              03  SC12-HKNJANUM-TBL     OCCURS  23.
                  05  SC12-HKNJANUM     PIC  X(8).
              03  SC12-KIGOBANGO-TBL    OCCURS  23.
                  05  SC12-KIGOBANGO    PIC  X(36).
              03  SC12-SRYYM-TBL        OCCURS  23.
                  05  SC12-SRYYM        PIC  X(4).
              03  SC12-NYUGAIKBN-TBL    OCCURS  23.
                  05  SC12-NYUGAIKBN    PIC  X(1).
              03  SC12-KYURATE-TBL      OCCURS  23.
                  05  SC12-KYURATE      PIC  X(1).
              03  SC12-CHOKBN-TBL       OCCURS  23.
                  05  SC12-CHOKBN       PIC  X(2).
              03  SC12-SRYKMK-TBL       OCCURS  23.
                  05  SC12-SRYKMK       PIC  X(2).
              03  SC12-NISSU-TBL        OCCURS  23.
                  05  SC12-NISSU        PIC  X(2).
              03  SC12-TENSU-TBL        OCCURS  23.
                  05  SC12-TENSU        PIC  X(7).
              03  SC12-YKZFTN-TBL       OCCURS  23.
                  05  SC12-YKZFTN       PIC  X(6).
              03  SC12-SKYMONEY-TBL     OCCURS  23.
                  05  SC12-SKYMONEY     PIC  X(6).
              03  SC12-KOUJYO-TBL       OCCURS  23.
                  05  SC12-KOUJYO       PIC  X(6).