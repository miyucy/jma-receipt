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
                  06  Q01-STAGE                PIC X(03).
                  06  Q01-EDAGE                PIC X(03).
                  06  Q01-KJYNYMD              PIC X(10).
                  06  Q01-CMB-SEX.
                    07  Q01-SEX                PIC X(10).
                    07  Q01-SEX-COUNT          PIC S9(9)   BINARY.
                    07  Q01-SEX-ITEM           PIC X(10)   OCCURS  3.
                  06  Q01-STLASTYMD            PIC X(10).
                  06  Q01-EDLASTYMD            PIC X(10).
                  06  Q01-STPTNUM              PIC X(20).
                  06  Q01-EDPTNUM              PIC X(20).
                  06  Q01-CHKTSTPT             PIC X.
                  06  Q01-POST-TBL.
                    07  Q01-POST               PIC X(07)   OCCURS 5.
                  06  Q01-JYUSHO-TBL.
                    07  Q01-JYUSHO             PIC X(50)   OCCURS 5.
                  06  Q01-KANANAME-TBL.
                    07  Q01-KANANAME           PIC X(50)   OCCURS 5.
                  06  Q01-NAME-TBL.
                    07  Q01-NAME               PIC X(50)   OCCURS 5.
                  06  Q01-CMB-CONDITION1-TBL.
                    07  Q01-CMB-CONDITION1-OCC             OCCURS 3.
                      08  Q01-CONDITION1           PIC X(23).
                      08  Q01-CMB-CONDITION1-COUNT PIC S9(9)
                                                           BINARY.
                      08  Q01-CMB-CONDITION1-ITEM  PIC X(23)
                                                           OCCURS 10.
                  06  Q01-CMB-CONDITION2-TBL.
                    07  Q01-CMB-CONDITION2-OCC             OCCURS 3.
                      08  Q01-CONDITION2           PIC X(23).
                      08  Q01-CMB-CONDITION2-COUNT PIC S9(9)
                                                           BINARY.
                      08  Q01-CMB-CONDITION2-ITEM  PIC X(23)
                                                           OCCURS 10.
                  06  Q01-CMB-CONDITION3-TBL.
                    07  Q01-CMB-CONDITION3-OCC             OCCURS 3.
                      08  Q01-CONDITION3           PIC X(23).
                      08  Q01-CMB-CONDITION3-COUNT PIC S9(9)
                                                           BINARY.
                      08  Q01-CMB-CONDITION3-ITEM  PIC X(23)
                                                           OCCURS 10.
                  06  Q01-COMMENT-TBL.
                    07  Q01-COMMENT            PIC X(50)   OCCURS 3.
                05  Q01-FIXED17.
                  06  Q01-CMB-HONKZKKBN.
                    07  Q01-HONKZKKBN          PIC X(10).
                    07  Q01-CMB-HONKZKKBN-COUNT
                                               PIC S9(9)   BINARY.
                    07  Q01-CMB-HONKZKKBN-ITEM
                                               PIC X(10)   OCCURS 5.
                  06  Q01-HKNJANUM-TBL.
                    07  Q01-HKNJANUM           PIC X(08)   OCCURS 5.
                  06  Q01-CMB-HKNNUM-TBL.
                    07  Q01-CMB-HKNNUM-OCC                 OCCURS 5.
                      08  Q01-HKNNUM           PIC X(20).
                      08  Q01-CMB-HKNNUM-COUNT PIC S9(9)   BINARY.
                      08  Q01-CMB-HKNNUM-ITEM  PIC X(20)   OCCURS  50.
                  06  Q01-KIGO-TBL.
                    07  Q01-KIGO               PIC X(40)   OCCURS 5.
                  06  Q01-NUM-TBL.
                    07  Q01-NUM                PIC X(40)   OCCURS 5.
                  06  Q01-CMB-KOHNUM-TBL.
                    07  Q01-CMB-KOHNUM-OCC                 OCCURS 5.
                      08  Q01-KOHNUM           PIC X(20).
                      08  Q01-CMB-KOHNUM-COUNT PIC S9(9)   BINARY.
                      08  Q01-CMB-KOHNUM-ITEM  PIC X(20)   OCCURS 150.
                  06  Q01-FTNJANUM-TBL.
                    07  Q01-FTNJANUM           PIC X(8)    OCCURS 5.
                  06  Q01-RDKOHNUM-AND         PIC X.
                  06  Q01-RDKOHNUM-OR          PIC X.
                05  Q01-FIXED18.
                  06  Q01-CMB-BYOBUN.
                    07  Q01-BYOBUN             PIC X(24).
                    07  Q01-BYOBUN-STATE       PIC S9(9)   BINARY.
                    07  Q01-CMB-BYOBUN-COUNT   PIC S9(9)   BINARY.
                    07  Q01-CMB-BYOBUN-ITEM    PIC X(24)   OCCURS  100.
                    07  Q01-CMB-BYOBUN-STATE   PIC S9(9)   BINARY.
                  06  Q01-RDBYOMEI-U           PIC X.
                  06  Q01-RDBYOMEI-U-STATE     PIC S9(9)   BINARY.
                  06  Q01-RDBYOMEI-A           PIC X.
                  06  Q01-RDBYOMEI-A-STATE     PIC S9(9)   BINARY.
                  06  Q01-BYOMEISEL            PIC X(80).
                  06  Q01-BYOMEICD-TBL.
                    07  Q01-BYOMEICD           PIC X(20)    OCCURS 5.
                  06  Q01-BYOMEI-TBL.
                    07  Q01-BYOMEI             PIC X(80)    OCCURS 5.
                  06  Q01-SCR-BYOLST.
                    07  Q01-BYOLST.
                      08  Q01-BYOLST-COUNT     PIC S9(9)   BINARY.
                      08  Q01-BYOLST-ITEM  OCCURS  200 TIMES.
                        09  Q01-BYOLST-BYOMEICD
                                               PIC X(20).
                        09  Q01-BYOLST-BYOMEI  PIC X(80).
                      08  Q01-BYOLST-SELECT-TBL.
                        09  Q01-BYOLST-SELECT  PIC X   OCCURS  200.
                  06  Q01-SRYACTSEL            PIC X(80).
                  06  Q01-SRYCD-TBL.
                    07  Q01-SRYCD-OCC   OCCURS   5.
                      08  Q01-SRYCD         PIC X(20).
                  06  Q01-SRYACT-TBL.
                    07  Q01-SRYACT-OCC   OCCURS   5.
                      08  Q01-SRYACT        PIC X(80).
                  06  Q01-SCR-SRYLST.
                    07  Q01-SRYLST.
                      08  Q01-SRYLST-COUNT     PIC S9(9)   BINARY.
                      08  Q01-SRYLST-ITEM  OCCURS  200 TIMES.
                        09  Q01-SRYLST-SRYCD
                                               PIC X(09).
                        09  Q01-SRYLST-SRYACT  PIC X(80).
                      08  Q01-SRYLST-SELECT-TBL.
                        09  Q01-SRYLST-SELECT  PIC X   OCCURS  200.
                  06  Q01-RDBYOMEI-AND         PIC X.
                  06  Q01-RDBYOMEI-OR          PIC X.
                  06  Q01-RDSRYACT-AND         PIC X.
                  06  Q01-RDSRYACT-OR          PIC X.
                05  Q01-FIXED19.
                  06  Q01-CMB-KMK-TBL.
                    07  Q01-CMB-KMK-OCC    OCCURS  3.
                      08  Q01-CMB-KMK          PIC X(30).
                      08  Q01-CMB-KMK-COUNT    PIC S9(9) BINARY.
                      08  Q01-CMB-KMK-ITEM     PIC X(30) OCCURS  10.
                  06  Q01-RDIO-TBL.
                    07  Q01-RDIO-OCC       OCCURS  3.
                      08  Q01-RDIO1            PIC X.
                      08  Q01-RDIO2            PIC X.
