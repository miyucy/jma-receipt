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
        02  Y01.
      ***   02  Y01-FIXED1.
              03  Y01-CALENDAR1.
                04  Y01-YEAR    PIC S9(9)   BINARY.
                04  Y01-MONTH   PIC S9(9)   BINARY.
                04  Y01-DAY PIC S9(9)   BINARY.
              03  Y01-SELNUM.
                04  Y01-VALUE   PIC X(4).
              03  Y01-PTNUM-G.
                04  Y01-PTNUM-STATE   PIC S9(9)   BINARY.
                04  Y01-PTNUM         PIC X(21).
              03  Y01-YYKNAME-G.
                04  Y01-YYKNAME-STATE   PIC S9(9)   BINARY.
                04  Y01-YYKNAME         PIC X(31).
              03  Y01-VIEWPORT1.
                04  Y01-FIXED2.
                  05  Y01-KENSUU01.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU02.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU03.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU04.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU05.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU06.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU07.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU08.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU09.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU10.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU11.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU12.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU13.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU14.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU15.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU16.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU17.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU18.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU19.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU20.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU21.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU22.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU23.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU24.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU25.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU26.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU27.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU28.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU29.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU30.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU31.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU32.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU33.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU34.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU35.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU36.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU37.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU38.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU39.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU40.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU41.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU42.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU43.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU44.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU45.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU46.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU47.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU48.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU49.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU50.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU51.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU52.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU53.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU54.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU55.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU56.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU57.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU58.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU59.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU60.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU61.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU62.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU63.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU64.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU65.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU66.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU67.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU68.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU69.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU70.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU71.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU72.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU73.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU74.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU75.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU76.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU77.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU78.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU79.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU80.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU81.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU82.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU83.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU84.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU85.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU86.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU87.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU88.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU89.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU90.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU91.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU92.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU93.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU94.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU95.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU96.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU97.
                    06  Y01-VALUE   PIC X(6).
                  05  Y01-KENSUU98.
                    06  Y01-VALUE   PIC X(6).
              03  Y01-SEX.
                04  Y01-VALUE   PIC X(3).
              03  Y01-BARTHDAY.
                04  Y01-VALUE   PIC X(10).
              03  Y01-TAIYYMM.
                04  Y01-VALUE   PIC X(13).
              03  Y01-TAIYMD.
                04  Y01-VALUE   PIC X(17).
              03  Y01-TAIKENSUU.
                04  Y01-VALUE   PIC X(7).
              03  Y01-DAY1.
                04  Y01-VALUE   PIC X(6).
              03  Y01-DAY2.
                04  Y01-VALUE   PIC X(6).
              03  Y01-DAY3.
                04  Y01-VALUE   PIC X(6).
              03  Y01-DAY4.
                04  Y01-VALUE   PIC X(6).
              03  Y01-DAY5.
                04  Y01-VALUE   PIC X(6).
              03  Y01-DAY6.
                04  Y01-VALUE   PIC X(6).
              03  Y01-DAY7.
                04  Y01-VALUE   PIC X(6).
              03  Y01-YYKYMD.
                04  Y01-VALUE   PIC X(11).
              03  Y01-YYKTIME.
                04  Y01-VALUE   PIC X(6).
              03  Y01-DRNAME-COMBO.
                04  Y01-DRNAME.
                  05  Y01-VALUE   PIC X(28).
                04  Y01-DRNAME-COUNT   PIC S9(9)   BINARY.
                04  Y01-DRNAME-LST     PIC X(27)   OCCURS  10 TIMES.
              03  Y01-SRYNAIYO-COMBO.
                04  Y01-SRYNAIYO.
                  05  Y01-VALUE   PIC X(22).
                04  Y01-SRYNAIYO-COUNT   PIC S9(9)   BINARY.
                04  Y01-SRYNAIYO-LST     PIC X(21)   OCCURS  10 TIMES.
              03  Y01-SCROLLEDWINDOW3.
                04  Y01-PTLIST.
                  05  Y01-PTLIST-COUNT   PIC S9(9)   BINARY.
                  05  Y01-ITEM        OCCURS  50 TIMES.
                    06  Y01-TBANGO       PIC X(3).
                    06  Y01-TYYKTIME     PIC X(5).
                    06  Y01-TNAME        PIC X(20).
                    06  Y01-TKAMEI       PIC X(4).
                    06  Y01-TRAIINZUMI   PIC X(4).
                  05  Y01-PTLIST-SELECT  PIC X       OCCURS  50 TIMES.
              03  Y01-SRYKA-COMB.
                04  Y01-SRYKA.
                  05  Y01-VALUE   PIC X(17).
                04  Y01-SRYKA-COUNT   PIC S9(9)   BINARY.
                04  Y01-SRYKA-LST      PIC X(16)   OCCURS  10 TIMES.
              03  Y01-YYKKBN-COMB.
                04  Y01-YYKKBN.
                  05  Y01-VALUE   PIC X(29).
                04  Y01-YYKKBN-COUNT   PIC S9(9)   BINARY.
                04  Y01-YYKKBN-LST      PIC X(28)   OCCURS  10 TIMES.
              03  Y01-KAKREN-COMB.
                04  Y01-KAKREN.
                  05  Y01-VALUE   PIC X(23).
                04  Y01-KAKREN-COUNT   PIC S9(9)   BINARY.
                04  Y01-KAKREN-LST      PIC X(22)   OCCURS  10 TIMES.
