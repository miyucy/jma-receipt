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
        02  S03.
              03  S03-PTNUM     PIC X(20).
              03  S03-SRYYMD    PIC X(9).
              03  S03-KANANAME  PIC X(50).
              03  S03-NAME      PIC X(50).
              03  S03-SEX       PIC X(4).
              03  S03-BIRTHDAY  PIC X(9).
              03  S03-HKNCOMBI  PIC X(50).
              03  S03-RATE      PIC X(6).
              03  S03-SRYKA     PIC X(10).
              03  S03-NYUGAIKBN PIC X(6).
              03  S03-NAIYO     PIC X(10).
              03  S03-DENPNUM   PIC X(10).
              03  S03-DENPJTI   PIC X(10).
              03  S03-HAKYMD    PIC X(9).
              03  S03-SSUHKNTEN PIC S9(10).
              03  S03-SDOHKNTEN PIC S9(10).
              03  S03-ZTKHKNTEN PIC S9(10).
              03  S03-TYKHKNTEN PIC S9(10).
              03  S03-CSYHKNTEN PIC S9(10).
              03  S03-SYCHKNTEN PIC S9(10).
              03  S03-SJTHKNTEN PIC S9(10).
              03  S03-KNSHKNTEN PIC S9(10).
              03  S03-GZUHKNTEN PIC S9(10).
              03  S03-ETCHKNTEN PIC S9(10).
              03  S03-TOTALHKNTEN
                                PIC S9(10).
              03  S03-SSUTGMONEY
                                PIC S9(10).
              03  S03-SDOTGMONEY
                                PIC S9(10).
              03  S03-ZTKTGMONEY
                                PIC S9(10).
              03  S03-TYKTGMONEY
                                PIC S9(10).
              03  S03-CSYTGMONEY
                                PIC S9(10).
              03  S03-SYCTGMONEY
                                PIC S9(10).
              03  S03-SJTGMONEY PIC S9(10).
              03  S03-KNSTGMONEY
                                PIC S9(10).
              03  S03-GZUTGMONEY
                                PIC S9(10).
              03  S03-ETCTGMONEY
                                PIC S9(10).
              03  S03-HKNTEKMONEY
                                PIC S9(10).
              03  S03-HKNTEKGAI PIC S9(10).
              03  S03-JIHIMSG-G OCCURS  5.
                04  S03-JIHIMSG PIC X(08).
              03  S03-JIHI1     PIC S9(10).
              03  S03-JIHI2     PIC S9(10).
              03  S03-JIHI3     PIC S9(10).
              03  S03-JIHI4     PIC S9(10).
              03  S03-JIHI5     PIC S9(10).
              03  S03-JIHITOTAL PIC S9(10).
              03  S03-JIHI1TAX  PIC S9(10).
              03  S03-JIHI2TAX  PIC S9(10).
              03  S03-JIHI3TAX  PIC S9(10).
              03  S03-JIHI4TAX  PIC S9(10).
              03  S03-JIHI5TAX  PIC S9(10).
              03  S03-JIHITAXTOTAL
                                PIC S9(10).
              03  S03-JIHITAX   PIC S9(10).
              03  S03-YKZFTN    PIC S9(10).
              03  S03-RJNFTN    PIC S9(10).
              03  S03-KOHFTN    PIC S9(10).
              03  S03-FTNTOTAL  PIC S9(10).
              03  S03-RSISHOSHIN
                                PIC S9(10).
              03  S03-RSISAISHIN
                                PIC S9(10).
              03  S03-RSISDO    PIC S9(10).
              03  S03-RSIETC    PIC S9(10).
              03  S03-SYKMONEY  PIC S9(10).
              03  S03-NYUKINGK1 PIC S9(10).
              03  S03-MISYUZAN  PIC S9(10).
              03  S03-ZENMISYU  PIC S9(10).
              03  S03-GOKMISYU  PIC S9(10).
              03  S03-NYUKINGK2 PIC S9(10).
              03  S03-NYUKINYMD.
                04  S03-VALUE   PIC X(10).
              03  S03-NYUKINHOUHOU-COMBO.
                04  S03-NYUKINHOUHOU PIC X(27).
                04  S03-NYUKINHOUHOU-COUNT   PIC S9(9)   BINARY.
                04  S03-NYUKINHOUHOULST      PIC X(27) OCCURS 3 TIMES.
              03  S03-RIREKIIN PIC S9(2).
              03  S03-SCROLLEDWINDOW1.
                04  S03-CLIST1.
                  05  S03-CLIST1-COUNT   PIC S9(9)   BINARY.
                  05  S03-ITEM        OCCURS  10 TIMES.
                  06  S03-TRENNUM PIC X(4).
                  06  S03-TSKYMONY    PIC X(12).
                  06  S03-TNYUKINMONEY    PIC X(12).
                  06  S03-TSYORIYMD   PIC X(11).
                  06  S03-TJTI    PIC X(12).
                  05  S03-SELECT  PIC X       OCCURS  10 TIMES.
