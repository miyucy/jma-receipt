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
        02  K03.
      ****  02  K03-FIXED3.
              03  K03-PTNUM.
                04  K03-VALUE   PIC X(21).
              03  K03-SRYYMD.
                04  K03-VALUE   PIC X(15).
              03  K03-KANANAME.
                04  K03-VALUE   PIC X(51).
              03  K03-NAME.
                04  K03-VALUE   PIC X(51).
              03  K03-SEX.
                04  K03-VALUE   PIC X(3).
              03  K03-BIRTHDAY.
                04  K03-VALUE   PIC X(10).
              03  K03-HKNCOMBI.
                04  K03-VALUE   PIC X(61).
              03  K03-FTNRATE.
                04  K03-VALUE   PIC X(6).
              03  K03-SRYKA.
                04  K03-VALUE   PIC X(11).
              03  K03-HAKYMD.
                04  K03-VALUE   PIC X(10).
              03  K03-DENPNUM.
                04  K03-VALUE   PIC X(11).
              03  K03-SSUHKNTEN.
                04  K03-VALUE   PIC X(11).
              03  K03-SJTHKNTEN.
                04  K03-VALUE   PIC X(11).
              03  K03-SYCHKNTEN.
                04  K03-VALUE   PIC X(11).
              03  K03-CSYHKNTEN.
                04  K03-VALUE   PIC X(11).
              03  K03-TYKHKNTEN.
                04  K03-VALUE   PIC X(11).
              03  K03-ZTKHKNTEN.
                04  K03-VALUE   PIC X(11).
              03  K03-SDOHKNTEN.
                04  K03-VALUE   PIC X(11).
              03  K03-KNSHKNTEN.
                04  K03-VALUE   PIC X(11).
              03  K03-FTNTOTAL.
                04  K03-VALUE   PIC X(11).
              03  K03-TOTALHKNTEN.
                04  K03-VALUE   PIC X(11).
              03  K03-KOHFTN.
                04  K03-VALUE   PIC X(11).
              03  K03-ETCHKNTEN.
                04  K03-VALUE   PIC X(11).
              03  K03-GZUHKNTEN.
                04  K03-VALUE   PIC X(11).
              03  K03-JIHI1.
                04  K03-VALUE   PIC X(11).
              03  K03-JIHIGOK.
                04  K03-VALUE   PIC X(11).
              03  K03-YKZFTN.
                04  K03-VALUE   PIC X(11).
              03  K03-JIHI5.
                04  K03-VALUE   PIC X(11).
              03  K03-JIHI4.
                04  K03-VALUE   PIC X(11).
              03  K03-JIHI3.
                04  K03-VALUE   PIC X(11).
              03  K03-JIHI2.
                04  K03-VALUE   PIC X(11).
              03  K03-RJNFTN.
                04  K03-VALUE   PIC X(11).
              03  K03-CHOSEI.
                04  K03-VALUE   PIC X(11).
              03  K03-GOKSKY.
                04  K03-VALUE   PIC X(11).
              03  K03-MISYUZAN.
                04  K03-VALUE   PIC X(11).
              03  K03-SKYMONEY.
                04  K03-VALUE   PIC X(11).
              03  K03-JIHITAX.
                04  K03-VALUE   PIC X(11).
              03  K03-HKNTEKGAI.
                04  K03-VALUE   PIC X(11).
              03  K03-HKNTEKMONEY.
                04  K03-VALUE   PIC X(11).
              03  K03-NENREI.
                04  K03-VALUE   PIC X(7).
              03  K03-SUUTGMONEY.
                04  K03-VALUE   PIC X(11).
              03  K03-SDOTGMONEY.
                04  K03-VALUE   PIC X(11).
              03  K03-ZTKTGMONEY.
                04  K03-VALUE   PIC X(11).
              03  K03-TYKTGMONEY.
                04  K03-VALUE   PIC X(11).
              03  K03-CSYTGMONEY.
                04  K03-VALUE   PIC X(11).
              03  K03-SYCTGMONEY.
                04  K03-VALUE   PIC X(11).
              03  K03-SJTGMONEY.
                04  K03-VALUE   PIC X(11).
              03  K03-KNSTGMONEY.
                04  K03-VALUE   PIC X(11).
              03  K03-GZUTGMONEY.
                04  K03-VALUE   PIC X(11).
              03  K03-ETCTGMONEY.
                04  K03-VALUE   PIC X(11).
              03  K03-SYORIMEI.
                04  K03-SYORIMEI-STYLE   PIC X(20).
                04  K03-SYORIMEI-VALUE   PIC X(12).
              03  K03-ROUSYOSIN.
                04  K03-VALUE   PIC X(11).
              03  K03-ROUSAISIN.
                04  K03-VALUE   PIC X(11).
              03  K03-ROUSIDOU.
                04  K03-VALUE   PIC X(11).
              03  K03-ROUETC.
                04  K03-VALUE   PIC X(11).
              03  K03-JIHIMSG1.
                04  K03-VALUE   PIC X(8).
              03  K03-JIHIMSG2.
                04  K03-VALUE   PIC X(8).
              03  K03-JIHIMSG3.
                04  K03-VALUE   PIC X(8).
              03  K03-JIHIMSG4.
                04  K03-VALUE   PIC X(8).
              03  K03-JIHIMSG5.
                04  K03-VALUE   PIC X(8).
              03  K03-JIHITAXGOK.
                04  K03-VALUE   PIC X(11).
              03  K03-JIHITAX1.
                04  K03-VALUE   PIC X(11).
              03  K03-JIHITAX2.
                04  K03-VALUE   PIC X(11).
              03  K03-JIHITAX3.
                04  K03-VALUE   PIC X(11).
              03  K03-JIHITAX4.
                04  K03-VALUE   PIC X(11).
              03  K03-JIHITAX5.
                04  K03-VALUE   PIC X(11).
              03  K03-NYUKIN.
                04  K03-VALUE   PIC X(11).
              03  K03-SYOHOPRTFLGCOMBO.
                04  K03-SYOHOPRTFLG.
                  05  K03-VALUE   PIC X(19).
                04  K03-SYOHOPRT-COUNT   PIC S9(9)   BINARY.
                04  K03-SYOHOPRT-ITEM    PIC X(18)   OCCURS  3 TIMES.
              03  K03-HAKFLGCOMBO.
                04  K03-HAKFLG.
                  05  K03-VALUE   PIC X(19).
                04  K03-HAKFLG-COUNT   PIC S9(9)   BINARY.
                04  K03-HAKFLG-ITEM    PIC X(18)   OCCURS  2 TIMES.
              03  K03-YAKJYOFLGCOMBO.
                04  K03-YAKJYOFLG.
                  05  K03-VALUE   PIC X(19).
                04  K03-YAKJYOFLG-COUNT   PIC S9(9)   BINARY.
                04  K03-YAKJYOFLG-ITEM    PIC X(18)   OCCURS  4 TIMES.
              03  K03-DRCDCOMBO.
                04  K03-DRCD.
                  05  K03-VALUE   PIC X(21).
                04  K03-DRCD-COUNT   PIC S9(9)   BINARY.
                04  K03-DRCD-ITEM    PIC X(20)   OCCURS  10 TIMES.
