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
       01  SC322.
              03  SC322-JKYSNUM-TBL   OCCURS  2.
                  05  SC322-JKYSNUM-G     OCCURS  21.
                      07  SC322-JKYSNUM   PIC  X(10).
              03  SC322-NAME-TBL      OCCURS  21.
                  05  SC322-NAME      PIC  X(26).
              03  SC322-HKNJANUM-TBL  OCCURS  21.
                  05  SC322-HKNJANUM  PIC  X(8).
              03  SC322-KIGOBANGO-TBL OCCURS  21.
                  05  SC322-KIGOBANGO PIC  X(36).
              03  SC322-SRYYM-TBL     OCCURS  21.
                  05  SC322-SRYYM     PIC  X(5).
              03  SC322-NYUGAIKBN-TBL OCCURS  21.
                  05  SC322-NYUGAIKBN PIC  X(1).
              03  SC322-KYURATE-TBL   OCCURS  21.
                  05  SC322-KYURATE   PIC  X(1).
              03  SC322-CHOKBN-TBL     OCCURS  21.
                  05  SC322-CHOKBN    PIC  X(2).
              03  SC322-NISSU-TBL     OCCURS  21.
                  05  SC322-NISSU     PIC  X(2).
              03  SC322-TENSU-TBL     OCCURS  21.
                  05  SC322-TENSU     PIC  X(7).
              03  SC322-YKZFTN-TBL    OCCURS  21.
                  05  SC322-YKZFTN    PIC  X(6).
              03  SC322-SKYMONEY-TBL  OCCURS  21.
                  05  SC322-SKYMONEY  PIC  X(6).
              03  SC322-GOKEI    PIC  X(6).
              03  SC322-GKENSU-TBL    OCCURS  6.
                  05  SC322-GKENSU    PIC  X(6).
              03  SC322-GNISSU-TBL    OCCURS  6.
                  05  SC322-GNISSU    PIC  X(3).
              03  SC322-GTENSU-TBL    OCCURS  6.
                  05  SC322-GTENSU    PIC  X(9).
              03  SC322-GYKZFTN-TBL   OCCURS  6.
                  05  SC322-GYKZFTN   PIC  X(7).
              03  SC322-GSKYMONEY-TBL OCCURS  6.
                  05  SC322-GSKYMONEY PIC  X(7).
              03  SC322-HOSPCD        PIC  X(10).
              03  SC322-ADRS          PIC  X(30).
              03  SC322-HOSPNAME      PIC  X(30).
              03  SC322-KAISETUNAME   PIC  X(30).
              03  SC322-PRTYM         PIC  X(16).
              03  SC322-SEIYMD        PIC  X(22).
              03  SC322-CITYNUM       PIC  X(6).
              03  SC322-FTNJANUM      PIC  X(8).
              03  SC322-CITYNAME      PIC  X(20).
              03  SC322-PAGE          PIC  X(3).
              03  SC322-KBN-TBL       OCCURS  3.
                  05  SC322-KBN       PIC  X(2).
              03  SC322-SRYKA    PIC  X(16).
