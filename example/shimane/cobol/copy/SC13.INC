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
       01  SC13.
              03  SC13-PRTYM            PIC  X(16).
              03  SC13-PAGE             PIC  X(3).
              03  SC13-CITYNUM          PIC  X(8).
              03  SC13-FTNJANUM         PIC  X(8).
              03  SC13-CITYNAME         PIC  X(20).
              03  SC13-SEIYMD           PIC  X(22).
              03  SC13-HOSPCD           PIC  X(7).
              03  SC13-ADRS             PIC  X(30).
              03  SC13-HOSPNAME         PIC  X(30).
              03  SC13-KAISETUNAME      PIC  X(30).
              03  SC13-GKENSU-TBL       OCCURS  2.
                  05  SC13-GKENSU       PIC  X(6).
              03  SC13-GOKEI            PIC  X(6).
              03  SC13-GNISSU-TBL       OCCURS  2.
                  05  SC13-GNISSU       PIC  X(3).
              03  SC13-GYKZFTN-TBL      OCCURS  2.
                  05  SC13-GYKZFTN      PIC  X(9).
              03  SC13-GITBFTN-TBL      OCCURS  2.
                  05  SC13-GITBFTN      PIC  X(7).
              03  SC13-GKOUJYO-TBL      OCCURS  2.
                  05  SC13-GKOUJYO      PIC  X(8).
              03  SC13-GCHOKBN-TBL      OCCURS  2.
                  05  SC13-GCHOKBN      PIC  X(5).
              03  SC13-JKYSNUM-TBL      OCCURS  23.
                  05  SC13-JKYSNUM      PIC  X(40).
              03  SC13-NAME-TBL         OCCURS  23.
                  05  SC13-NAME         PIC  X(32).
              03  SC13-HKNJANUM-TBL     OCCURS  23.
                  05  SC13-HKNJANUM     PIC  X(8).
              03  SC13-KIGOBANGO-TBL    OCCURS  23.
                  05  SC13-KIGOBANGO    PIC  X(36).
              03  SC13-ROJKYSNUM-TBL    OCCURS  23.
                  05  SC13-ROJKYSNUM    PIC  X(28).
              03  SC13-SRYYM-TBL        OCCURS  23.
                  05  SC13-SRYYM        PIC  X(4).
              03  SC13-NYUGAIKBN-TBL    OCCURS  23.
                  05  SC13-NYUGAIKBN    PIC  X(1).
              03  SC13-CHOKBN-TBL       OCCURS  23.
                  05  SC13-CHOKBN       PIC  X(2).
              03  SC13-SRYKMK-TBL       OCCURS  23.
                  05  SC13-SRYKMK       PIC  X(2).
              03  SC13-NISSU-TBL        OCCURS  23.
                  05  SC13-NISSU        PIC  X(2).
              03  SC13-YKZFTN-TBL       OCCURS  23.
                  05  SC13-YKZFTN       PIC  X(7).
              03  SC13-ITBFTN-TBL       OCCURS  23.
                  05  SC13-ITBFTN       PIC  X(6).
              03  SC13-KOUJYO-TBL       OCCURS  23.
                  05  SC13-KOUJYO       PIC  X(6).