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
              03  S03-PTNUM.
                04  S03-VALUE   PIC X(21).
              03  S03-SRYYMD.
                04  S03-VALUE   PIC X(10).
              03  S03-KANANAME.
                04  S03-VALUE   PIC X(51).
              03  S03-NAME.
                04  S03-VALUE   PIC X(51).
              03  S03-SEX.
                04  S03-VALUE   PIC X(5).
              03  S03-BIRTHDAY.
                04  S03-VALUE   PIC X(10).
              03  S03-HKNCOMBI.
                04  S03-VALUE   PIC X(31).
              03  S03-RATE.
                04  S03-VALUE   PIC X(7).
              03  S03-SRYKA.
                04  S03-VALUE   PIC X(11).
              03  S03-HAKYMD.
                04  S03-VALUE   PIC X(10).
              03  S03-DENPNUM.
                04  S03-VALUE   PIC X(11).
              03  S03-SSUHKNTEN.
                04  S03-VALUE   PIC S9(10).
              03  S03-SJTHKNTEN.
                04  S03-VALUE   PIC S9(10).
              03  S03-SYCHKNTEN.
                04  S03-VALUE   PIC S9(10).
              03  S03-CSYHKNTEN.
                04  S03-VALUE   PIC S9(10).
              03  S03-ZTKHKNTEN.
                04  S03-VALUE   PIC S9(10).
              03  S03-SDOHKNTEN.
                04  S03-VALUE   PIC S9(10).
              03  S03-TOTALHKNTEN.
                04  S03-VALUE   PIC S9(10).
              03  S03-HKNTEKMONEY.
                04  S03-VALUE   PIC S9(10).
              03  S03-HKNTEKGAI.
                04  S03-VALUE   PIC S9(10).
              03  S03-SYKMONEY.
                04  S03-VALUE   PIC S9(10).
              03  S03-FTNTOTAL.
                04  S03-VALUE   PIC S9(10).
              03  S03-RJNFTN.
                04  S03-VALUE   PIC S9(10).
              03  S03-ZENMISYU.
                04  S03-VALUE   PIC S9(10).
              03  S03-GZUHKNTEN.
                04  S03-VALUE   PIC S9(10).
              03  S03-KOHFTN.
                04  S03-VALUE   PIC S9(10).
              03  S03-YKZFTN.
                04  S03-VALUE   PIC S9(10).
              03  S03-JIHI5.
                04  S03-VALUE   PIC S9(10).
              03  S03-JIHI2.
                04  S03-VALUE   PIC S9(10).
              03  S03-JIHI1.
                04  S03-VALUE   PIC S9(10).
              03  S03-ETCHKNTEN.
                04  S03-VALUE   PIC S9(10).
              03  S03-KNSHKNTEN.
                04  S03-VALUE   PIC S9(10).
              03  S03-JIHITAX.
                04  S03-VALUE   PIC S9(10).
              03  S03-JIHITOTAL.
                04  S03-VALUE   PIC S9(10).
              03  S03-JIHI4.
                04  S03-VALUE   PIC S9(10).
              03  S03-JIHI3.
                04  S03-VALUE   PIC S9(10).
              03  S03-DENPJTI.
                04  S03-VALUE   PIC X(11).
              03  S03-NYUKINGK1.
                04  S03-VALUE   PIC S9(10).
              03  S03-GOKMISYU.
                04  S03-VALUE   PIC S9(10).
              03  S03-NAIYO.
                04  S03-VALUE   PIC X(11).
              03  S03-MISYUZAN.
                04  S03-VALUE   PIC S9(10).
              03  S03-NYUKINGK2.
                04  S03-VALUE   PIC S9(10).
              03  S03-NYUKINYMD.
                04  S03-VALUE   PIC X(11).
              03  S03-RIREKIIN.
                04  S03-VALUE   PIC S9(2).
              03  S03-TYKHKNTEN.
                04  S03-VALUE   PIC S9(10).
              03  S03-SSUTGMONEY.
                04  S03-VALUE   PIC S9(10).
              03  S03-SDOTGMONEY.
                04  S03-VALUE   PIC S9(10).
              03  S03-ZTKTGMONEY.
                04  S03-VALUE   PIC S9(10).
              03  S03-TYKTGMONEY.
                04  S03-VALUE   PIC S9(10).
              03  S03-CSYTGMONEY.
                04  S03-VALUE   PIC S9(10).
              03  S03-SYCTGMONEY.
                04  S03-VALUE   PIC S9(10).
              03  S03-SJTGMONEY.
                04  S03-VALUE   PIC S9(10).
              03  S03-KNSTGMONEY.
                04  S03-VALUE   PIC S9(10).
              03  S03-GZUTGMONEY.
                04  S03-VALUE   PIC S9(10).
              03  S03-ETCTGMONEY.
                04  S03-VALUE   PIC S9(10).
              03  S03-NYUKINHOUHOU-COMBO.
                04  S03-NYUKINHOUHOU PIC X(27).
                04  S03-NYUKINHOUHOU-COUNT   PIC S9(9)   BINARY.
                04  S03-NYUKINHOUHOULST      PIC X(27) OCCURS 3 TIMES.
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
              03  S03-JIHIMSG-G OCCURS  5.
                04  S03-JIHIMSG PIC X(20).
              03  S03-JIHITAXTOTAL.
                04  S03-VALUE   PIC S9(10).
              03  S03-JIHI1TAX.
                04  S03-VALUE   PIC S9(10).
              03  S03-JIHI2TAX.
                04  S03-VALUE   PIC S9(10).
              03  S03-JIHI3TAX.
                04  S03-VALUE   PIC S9(10).
              03  S03-JIHI4TAX.
                04  S03-VALUE   PIC S9(10).
              03  S03-JIHI5TAX.
                04  S03-VALUE   PIC S9(10).
              03  S03-RSISHOSHIN.
                04  S03-VALUE   PIC S9(10).
              03  S03-RSISAISHIN.
                04  S03-VALUE   PIC S9(10).
              03  S03-RSISDO.
                04  S03-VALUE   PIC S9(10).
              03  S03-RSIETC.
                04  S03-VALUE   PIC S9(10).
              03  S03-NYUGAIKBN.
                04  S03-VALUE   PIC X(06).
