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
           02  C02.
              03  C02-PTNUM-STATE
                                PIC S9(9)   BINARY.
              03  C02-PTNUM     PIC X(21).
              03  C02-SYSYMD.
                04  C02-VALUE   PIC X(10).
              03  C02-KANANAME.
                04  C02-VALUE   PIC X(31).
              03  C02-NAME.
                04  C02-VALUE   PIC X(31).
              03  C02-SEX.
                04  C02-VALUE   PIC X(3).
              03  C02-BIRTHDAY.
                04  C02-VALUE   PIC X(13).
              03  C02-HKNNAME.
                04  C02-VALUE   PIC X(31).
              03  C02-PTFTNRATE.
                04  C02-VALUE   PIC X(5).
              03  C02-SRYKA-COMBO.
                04  C02-SRYKA   PIC X(22).
                04  C02-SRYKA-COUNT
                                PIC S9(9)   BINARY.
                04  C02-SRYKALST
                                PIC X(22)   OCCURS  10 TIMES.
              03  C02-B03-STATE
                                PIC S9(9)   BINARY.
              03  C02-B09-STATE
                                PIC S9(9)   BINARY.
              03  C02-BANGO.
                04  C02-VALUE   PIC S9(3).
              03  C02-SRYYMD.
                04  C02-VALUE   PIC X(11).
              03  C02-REZEMM.
                04  C02-VALUE   PIC S9(2).
              03  C02-TENKIYMD.
                04  C02-VALUE   PIC X(11).
              03  C02-BYOMEICD-G    OCCURS  6.
                04  C02-BYOMEICD.
                  05  C02-VALUE PIC X(11).
              03  C02-BYOMEI.
                04  C02-VALUE   PIC X(481).
              03  C02-CHARTBYOMEI.
                04  C02-VALUE   PIC X(481).
              03  C02-SYUBYOFLGCOMBO.
                04  C02-SYUBYOFLG.
                  05  C02-VALUE   PIC X(15).
                04  C02-SYUBYOFLG-COUNT   PIC S9(9)   BINARY.
                04  C02-SYUBYOFLG-ITEM    PIC X(14)   OCCURS  5 TIMES.
              03  C02-UTAGAIFLGCOMBO.
                04  C02-UTAGAIFLG.
                  05  C02-VALUE   PIC X(15).
                04  C02-UTAGAIFLG-COUNT   PIC S9(9)   BINARY.
                04  C02-UTAGAIFLG-ITEM    PIC X(14)    OCCURS  5 TIMES.
              03  C02-NYUGAIKBNCOMBO.
                04  C02-NYUGAIKBN.
                  05  C02-VALUE   PIC X(9).
                04  C02-NYUGAIKBN-COUNT   PIC S9(9)   BINARY.
                04  C02-NYUGAIKBN-ITEM    PIC X(8)    OCCURS  5 TIMES.
              03  C02-HKNBYOMEIFLGCOMBO.
                04  C02-HKNBYOMEIFLG.
                  05  C02-VALUE   PIC X(11).
                04  C02-HKNBYOMEIFLG-COUNT PIC S9(9)   BINARY.
                04  C02-HKNBYOMEIFLG-ITEM  PIC X(10)   OCCURS  5 TIMES.
              03  C02-HKNCOMBICOMBO.
                04  C02-HKNCOMBI.
                  05  C02-VALUE   PIC X(41).
                04  C02-HKNCOMBI-COUNT   PIC S9(9)   BINARY.
                04  C02-HKNCOMBI-ITEM    PIC X(40)   OCCURS  10 TIMES.
              03  C02-BYOMEIHENFLG.
                04  C02-VALUE   PIC X(11).
              03  C02-BYOMEIINPUTCD.
                04  C02-VALUE   PIC X(11).
              03  C02-TENKICOMBO.
                04  C02-TENKIKBN.
                  05  C02-VALUE   PIC X(9).
                04  C02-TENKIKBN-COUNT   PIC S9(9)   BINARY.
                04  C02-TENKIKBN-ITEM    PIC X(8)    OCCURS  5 TIMES.
              03  C02-MANSEIFLGCOMBO.
                04  C02-MANSEIFLG.
                  05  C02-VALUE   PIC X(47).
                04  C02-MANSEIFLG-COUNT   PIC S9(9)   BINARY.
                04  C02-MANSEIFLG-ITEM    PIC X(46)   OCCURS  5 TIMES.
              03  C02-SCROLLEDWINDOW6.
                04  C02-HKNCOMBILST.
                  05  C02-HKN-COUNT       PIC S9(9)   BINARY.
                  05  C02-HKN-ITEM        OCCURS  20 TIMES.
                    06  C02-HKNCOMBINUM   PIC X(5).
                    06  C02-HKNCOMBIMEI   PIC X(51).
                  05  C02-HKN-SELECT      PIC X   OCCURS  20 TIMES.
              03  C02-REZEFLGCOMBO.
                04  C02-REZEFLG.
                  05  C02-VALUE   PIC X(13).
                04  C02-REZEFLG-COUNT   PIC S9(9)   BINARY.
                04  C02-REZEFLG-ITEM    PIC X(12)   OCCURS  5 TIMES.
              03  C02-SCROLLEDWINDOW28.
                04  C02-BYOMEILST.
                  05  C02-BYO-COUNT   PIC S9(9)   BINARY.
                  05  C02-BYO-ITEM        OCCURS  200 TIMES.
                    06  C02-TBANGO        PIC X(4).
                    06  C02-TBYOMEI       PIC X(51).
                    06  C02-TSRYYMD       PIC X(10).
                    06  C02-TTENKIYMD     PIC X(10).
                    06  C02-TTENKIKBN     PIC X(7).
                    06  C02-TMANSEIFLG    PIC X(10).
                    06  C02-TSYUBYOFLG    PIC X(7).
                    06  C02-TUTAGAIFLG    PIC X(13).
                    06  C02-TNYUGAIKBN    PIC X(7).
                    06  C02-THKNCOMBI     PIC X(41).
                    06  C02-TREZEFLG      PIC X(11).
                    06  C02-TREZEMM       PIC X(3).
                    06  C02-THKNBYOMEIFLG PIC X(9).
                  05  C02-BYO-SELECT      PIC X   OCCURS  200 TIMES.
