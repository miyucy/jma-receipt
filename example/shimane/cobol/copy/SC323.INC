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
       01  SC323.
              03  SC323-HOSPCD        PIC  X(10).
              03  SC323-ADRS          PIC  X(30).
              03  SC323-HOSPNAME      PIC  X(30).
              03  SC323-KAISETUNAME   PIC  X(30).
              03  SC323-PRTYM         PIC  X(16).
              03  SC323-SEIYMD        PIC  X(22).
              03  SC323-CITYNUM       PIC  X(6).
              03  SC323-FTNJANUM      PIC  X(8).
              03  SC323-CITYNAME      PIC  X(20).
              03  SC323-PAGE          PIC  X(3).
              03  SC323-KBN-TBL       OCCURS  3.
                  05  SC323-KBN       PIC  X(2).
              03  SC323-ROFTNJANUM-TBL
                                     OCCURS  23.
                  05  SC323-ROFTNJANUM     PIC  X(8).
              03  SC323-ROJKYSNUM-TBL OCCURS  2.
                  05  SC323-ROJKYSNUM-G    OCCURS  23.
                      07  SC323-ROJKYSNUM  PIC  X(7).
              03  SC323-JKYSNUM-TBL   OCCURS  2.
                  05  SC323-JKYSNUM-G      OCCURS  23.
                      07  SC323-JKYSNUM    PIC  X(7).
              03  SC323-NAME-TBL      OCCURS  23.
                  05  SC323-NAME      PIC  X(26).
              03  SC323-HKNJANUM-TBL  OCCURS  23.
                  05  SC323-HKNJANUM  PIC  X(8).
              03  SC323-KIGOBANGO-TBL OCCURS  23.
                  05  SC323-KIGOBANGO PIC  X(36).
              03  SC323-SRYYM-TBL     OCCURS  23.
                  05  SC323-SRYYM     PIC  X(5).
              03  SC323-NYUGAIKBN-TBL OCCURS  23.
                  05  SC323-NYUGAIKBN PIC  X(1).
              03  SC323-NISSU-TBL     OCCURS  23.
                  05  SC323-NISSU     PIC  X(2).
              03  SC323-YKZFTN-TBL    OCCURS  23.
                  05  SC323-YKZFTN    PIC  X(6).
              03  SC323-ITBFTN-TBL    OCCURS  23.
                  05  SC323-ITBFTN    PIC  X(6).
              03  SC323-GOKEI    PIC  X(6).
              03  SC323-GKENSU-TBL    OCCURS  2.
                  05  SC323-GKENSU    PIC  X(6).
              03  SC323-GNISSU-TBL    OCCURS  2.
                  05  SC323-GNISSU    PIC  X(3).
              03  SC323-GYKZFTN-TBL   OCCURS  2.
                  05  SC323-GYKZFTN   PIC  X(7).
              03  SC323-GITBFTN-TBL   OCCURS  2.
                  05  SC323-GITBFTN   PIC  X(7).
