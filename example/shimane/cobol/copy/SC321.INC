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
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
       01  SC321.
              03  SC321-HOSPCD        PIC  X(10).
              03  SC321-ADRS          PIC  X(30).
              03  SC321-HOSPNAME      PIC  X(30).
              03  SC321-KAISETUNAME   PIC  X(30).
              03  SC321-PRTYM         PIC  X(16).
              03  SC321-SEIYMD        PIC  X(22).
              03  SC321-CITYNUM       PIC  X(6).
              03  SC321-FTNJANUM      PIC  X(8).
              03  SC321-CITYNAME      PIC  X(20).
              03  SC321-PAGE          PIC  X(3).
              03  SC321-KBN-TBL       OCCURS  3.
                  05  SC321-KBN       PIC  X(2).
              03  SC321-JKYSNUM-TBL   OCCURS  2.
                  05  SC321-JKYSNUM-G     OCCURS  22.
                      07  SC321-JKYSNUM   PIC  X(10).
              03  SC321-NAME-TBL      OCCURS  22.
                  05  SC321-NAME      PIC  X(26).
              03  SC321-HKNJANUM-TBL  OCCURS  22.
                  05  SC321-HKNJANUM  PIC  X(8).
              03  SC321-KIGOBANGO-TBL OCCURS  22.
                  05  SC321-KIGOBANGO PIC  X(36).
              03  SC321-BIRTHDAY-TBL  OCCURS  22.
                  05  SC321-BIRTHDAY  PIC  X(8).
              03  SC321-SRYYM-TBL     OCCURS  22.
                  05  SC321-SRYYM     PIC  X(5).
              03  SC321-NYUGAIKBN-TBL OCCURS  22.
                  05  SC321-NYUGAIKBN PIC  X(1).
              03  SC321-KYURATE-TBL   OCCURS  22.
                  05  SC321-KYURATE   PIC  X(1).
              03  SC321-NISSU-TBL     OCCURS  22.
                  05  SC321-NISSU     PIC  X(2).
              03  SC321-TENSU-TBL     OCCURS  22.
                  05  SC321-TENSU     PIC  X(7).
              03  SC321-KOHFTN-TBL    OCCURS  22.
                  05  SC321-KOHFTN    PIC  X(8).
              03  SC321-GOKEI         PIC  X(6).
              03  SC321-GKENSU-TBL    OCCURS  4.
                  05  SC321-GKENSU    PIC  X(6).
              03  SC321-GNISSU-TBL    OCCURS  4.
                  05  SC321-GNISSU    PIC  X(3).
              03  SC321-GTENSU-TBL    OCCURS  4.
                  05  SC321-GTENSU    PIC  X(9).
              03  SC321-GKOHFTN-TBL   OCCURS  4.
                  05  SC321-GKOHFTN   PIC  X(7).
