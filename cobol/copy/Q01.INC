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
          02  Q01.
            03  Q01-FIXED12.
              04  Q01-STSRYYMD                 PIC X(10).
              04  Q01-EDSRYYMD                 PIC X(10).
              04  Q01-NOTEBOOK3.
                05  Q01-PAGENO                 PIC S9(9)   BINARY.
                05  Q01-FIXED16.
                  06  Q01-STBIRTHDAY           PIC X(10).
                  06  Q01-EDBIRTHDAY           PIC X(10).
                  06  Q01-STAGE                PIC X(4).
                  06  Q01-EDAGE                PIC X(4).
                  06  Q01-KJYNYMD              PIC X(10).
                  06  Q01-CNB-SEX.
                    07  Q01-SEX                PIC X(11).
                    07  Q01-SEX-COUNT          PIC S9(9)   BINARY.
                    07  Q01-SEX-ITEM           PIC X(10)   OCCURS  3.
                  06  Q01-STLASTYMD            PIC X(10).
                  06  Q01-EDLASTYMD            PIC X(10).
                  06  Q01-STPTNUM              PIC X(21).
                  06  Q01-EDPTNUM              PIC X(21).
                  06  Q01-CHKTSTPT             PIC X.
                  06  Q01-POST-TBL.
                    07  Q01-POST               PIC X(08)   OCCURS 5.
                  06  Q01-JYUSHO-TBL.
                    07  Q01-JYUSHO             PIC X(51)   OCCURS 5.
                  06  Q01-KANANAME-TBL.
                    07  Q01-KANANAME           PIC X(51)   OCCURS 5.
                  06  Q01-NAME-TBL.
                    07  Q01-NAME               PIC X(51)   OCCURS 5.
                  06  Q01-COMMENT-TBL.
                    07  Q01-COMMENT            PIC X(51)   OCCURS 3.
                05  Q01-FIXED17.
                  06  Q01-HKNJANUM-TBL.
                    07  Q01-HKNJANUM           PIC X(09)   OCCURS 5.
                  06  Q01-CNB-HKNNUM-TBL.
                    07  Q01-CNB-HKNNUM-OCC                 OCCURS 5.
                      08  Q01-HKNNUM           PIC X(21).
                      08  Q01-CNB-HKNNUM-COUNT PIC S9(9)   BINARY.
                      08  Q01-CNB-HKNNUM-ITEM  PIC X(20)   OCCURS  50.
                  06  Q01-KIGO-TBL.
                    07  Q01-KIGO               PIC X(41)   OCCURS 5.
                  06  Q01-NUM-TBL.
                    07  Q01-NUM                PIC X(41)   OCCURS 5.
                  06  Q01-CNB-KOHNUM-TBL.
                    07  Q01-CNB-KOHNUM-OCC                 OCCURS 5.
                      08  Q01-KOHNUM           PIC X(21).
                      08  Q01-CNB-KOHNUM-COUNT PIC S9(9)   BINARY.
                      08  Q01-CNB-KOHNUM-ITEM  PIC X(20)   OCCURS  50.
                  06  Q01-FTNJANUM-TBL.
                    07  Q01-FTNJANUM           PIC X(9)    OCCURS 5.
                05  Q01-FIXED18.
                  06  Q01-CNB-BYOBUN.
                    07  Q01-BYOBUN             PIC X(21).
                    07  Q01-BYOBUN-STATE       PIC S9(9)   BINARY.
                    07  Q01-CNB-BYOBUN-COUNT   PIC S9(9)   BINARY.
                    07  Q01-CNB-BYOBUN-ITEM    PIC X(20)   OCCURS  100.
                    07  Q01-CNB-BYOBUN-STATE   PIC S9(9)   BINARY.
                  06  Q01-RDBYOMEI-U           PIC X.
                  06  Q01-RDBYOMEI-U-STATE     PIC S9(9)   BINARY.
                  06  Q01-RDBYOMEI-A           PIC X.
                  06  Q01-RDBYOMEI-A-STATE     PIC S9(9)   BINARY.
                  06  Q01-BYOMEISEL            PIC X(81).
                  06  Q01-BYOMEICD-TBL.
                    07  Q01-BYOMEICD           PIC X(21)    OCCURS 5.
                  06  Q01-BYOMEI-TBL.
                    07  Q01-BYOMEI             PIC X(81)    OCCURS 5.
                  06  Q01-SCR-BYOLST.
                    07  Q01-BYOLST.
                      08  Q01-BYOLST-COUNT     PIC S9(9)   BINARY.
                      08  Q01-BYOLST-ITEM  OCCURS  200 TIMES.
                        09  Q01-BYOLST-BYOMEICD
                                               PIC X(21).
                        09  Q01-BYOLST-BYOMEI  PIC X(81).
                      08  Q01-BYOLST-SELECT-TBL.
                        09  Q01-BYOLST-SELECT  PIC X   OCCURS  200.
                  06  Q01-SRYACTSEL            PIC X(81).
                  06  Q01-SRYCD-TBL.
                    07  Q01-SRYCD-OCC   OCCURS   5.
                      08  Q01-SRYCD         PIC X(21).
                  06  Q01-SRYACT-TBL.
                    07  Q01-SRYACT-OCC   OCCURS   5.
                      08  Q01-SRYACT        PIC X(81).
                  06  Q01-SCR-SRYLST.
                    07  Q01-SRYLST.
                      08  Q01-SRYLST-COUNT     PIC S9(9)   BINARY.
                      08  Q01-SRYLST-ITEM  OCCURS  200 TIMES.
                        09  Q01-SRYLST-SRYCD
                                               PIC X(10).
                        09  Q01-SRYLST-SRYACT  PIC X(81).
                      08  Q01-SRYLST-SELECT-TBL.
                        09  Q01-SRYLST-SELECT  PIC X   OCCURS  200.
                05  Q01-FIXED19.
                  06  Q01-CNB-KMK-TBL.
                    07  Q01-CNB-KMK-OCC    OCCURS  3.
                      08  Q01-CNB-KMK          PIC X(31).
                      08  Q01-CNB-KMK-COUNT    PIC S9(9) BINARY.
                      08  Q01-CNB-KMK-ITEM     PIC X(30) OCCURS  10.
                  06  Q01-RDIO-TBL.
                    07  Q01-RDIO-OCC       OCCURS  3.
                      08  Q01-RDIO1            PIC X.
                      08  Q01-RDIO2            PIC X.
