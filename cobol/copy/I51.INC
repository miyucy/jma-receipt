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
        02  I51.
      *     02  I51-FIXED3.
              03  I51-PTNUM.
                04  I51-VALUE   PIC X(20).
              03  I51-KANANAME.
                04  I51-VALUE   PIC X(50).
              03  I51-SEX.
                04  I51-VALUE   PIC X(2).
              03  I51-HKNCOMBI.
                04  I51-VALUE   PIC X(60).
              03  I51-FTNRATE.
                04  I51-VALUE   PIC X(5).
              03  I51-NAME.
                04  I51-VALUE   PIC X(50).
              03  I51-BIRTHDAY.
                04  I51-VALUE   PIC X(9).
              03  I51-NENREI.
                04  I51-VALUE   PIC X(7).
              03  I51-SRYKA.
                04  I51-VALUE   PIC X(10).
              03  I51-SANTEISTYMD.
                04  I51-VALUE   PIC X(14).
              03  I51-SANTEIEDYMD.
                04  I51-VALUE   PIC X(14).
              03  I51-SSUHKNTEN.
                04  I51-VALUE   PIC X(10).
              03  I51-SDOHKNTEN.
                04  I51-VALUE   PIC X(10).
              03  I51-ZTKHKNTEN.
                04  I51-VALUE   PIC X(10).
              03  I51-TYKHKNTEN.
                04  I51-VALUE   PIC X(10).
              03  I51-CSYHKNTEN.
                04  I51-VALUE   PIC X(10).
              03  I51-SYCHKNTEN.
                04  I51-VALUE   PIC X(10).
              03  I51-SJTHKNTEN.
                04  I51-VALUE   PIC X(10).
              03  I51-KNSHKNTEN.
                04  I51-VALUE   PIC X(10).
              03  I51-GZUHKNTEN.
                04  I51-VALUE   PIC X(10).
              03  I51-ETCHKNTEN.
                04  I51-VALUE   PIC X(10).
              03  I51-NYUHKNTEN.
                04  I51-VALUE   PIC X(10).
              03  I51-TOTALHKNTEN.
                04  I51-VALUE   PIC X(10).
              03  I51-SUUTGMONEY.
                04  I51-VALUE   PIC X(10).
              03  I51-SDOTGMONEY.
                04  I51-VALUE   PIC X(10).
              03  I51-ZTKTGMONEY.
                04  I51-VALUE   PIC X(10).
              03  I51-TYKTGMONEY.
                04  I51-VALUE   PIC X(10).
              03  I51-CSYTGMONEY.
                04  I51-VALUE   PIC X(10).
              03  I51-SYCTGMONEY.
                04  I51-VALUE   PIC X(10).
              03  I51-SJTGMONEY.
                04  I51-VALUE   PIC X(10).
              03  I51-KNSTGMONEY.
                04  I51-VALUE   PIC X(10).
              03  I51-GZUTGMONEY.
                04  I51-VALUE   PIC X(10).
              03  I51-ETCTGMONEY.
                04  I51-VALUE   PIC X(10).
              03  I51-JIHIMSG1.
                04  I51-VALUE   PIC X(12).
              03  I51-JIHIMSG2.
                04  I51-VALUE   PIC X(12).
              03  I51-JIHIMSG3.
                04  I51-VALUE   PIC X(12).
              03  I51-JIHIMSG4.
                04  I51-VALUE   PIC X(12).
              03  I51-JIHIMSG5.
                04  I51-VALUE   PIC X(12).
              03  I51-JIHI1.
                04  I51-VALUE   PIC X(10).
              03  I51-JIHI2.
                04  I51-VALUE   PIC X(10).
              03  I51-JIHI3.
                04  I51-VALUE   PIC X(10).
              03  I51-JIHI4.
                04  I51-VALUE   PIC X(10).
              03  I51-JIHI5.
                04  I51-VALUE   PIC X(10).
              03  I51-JIHIGOK.
                04  I51-VALUE   PIC X(10).
              03  I51-JIHITAX1.
                04  I51-VALUE   PIC X(10).
              03  I51-JIHITAX2.
                04  I51-VALUE   PIC X(10).
              03  I51-JIHITAX3.
                04  I51-VALUE   PIC X(10).
              03  I51-JIHITAX4.
                04  I51-VALUE   PIC X(10).
              03  I51-JIHITAX5.
                04  I51-VALUE   PIC X(10).
              03  I51-JIHITAXGOK.
                04  I51-VALUE   PIC X(10).
              03  I51-JIHITAX.
                04  I51-VALUE   PIC X(10).
              03  I51-RYOYOHI-SKJ.
                04  I51-VALUE   PIC X(10).
              03  I51-SKYMONEY-SKJ.
                04  I51-VALUE   PIC X(10).
              03  I51-RJNFTN.
                04  I51-VALUE   PIC X(10).
              03  I51-KOHFTN.
                04  I51-VALUE   PIC X(10).
              03  I51-FTNTOTAL.
                04  I51-VALUE   PIC X(10).
              03  I51-ROUSYOSIN.
                04  I51-VALUE   PIC X(10).
              03  I51-ROUSAISIN.
                04  I51-VALUE   PIC X(10).
              03  I51-ROUSIDOU.
                04  I51-VALUE   PIC X(10).
              03  I51-ROUETC.
                04  I51-VALUE   PIC X(10).
              03  I51-SKYMONEY.
                04  I51-VALUE   PIC X(10).
              03  I51-HKNTEKMONEY.
                04  I51-VALUE   PIC X(10).
              03  I51-HKNTEKGAI.
                04  I51-VALUE   PIC X(10).
              03  I51-MISYUZAN-GAI.
                04  I51-VALUE   PIC X(10).
              03  I51-MISYUZAN-NYU.
                04  I51-VALUE   PIC X(10).
              03  I51-GOKSKY.
                04  I51-VALUE   PIC X(10).
              03  I51-RMSAGAKU.
                04  I51-VALUE   PIC X(10).
              03  I51-SELNUM.
                04  I51-VALUE   PIC S9(2).
              03  I51-SCROLLEDWINDOW1.
                04  I51-HKNCOMBILST.
                  05  I51-HKNCOMBILST-CNT  PIC S9(9)   BINARY.
                  05  I51-HKNCOMBILST-ITM  OCCURS  15 TIMES.
                    06  I51-TSELNUM        PIC X(02).
                    06  I51-THKNCOMBI      PIC X(50).
                  05  I51-HKNCOMBILST-SELECT
                                           PIC X     OCCURS  15 TIMES.
