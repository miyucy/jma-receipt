      *******************************************************************
      * Project code name "ORCA"
      * Æü°åÉ¸½à¥ì¥»¥×¥È¥½¥Õ¥È¡ÊJMA standard receipt software¡Ë
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
      ************************************************************
      *    ÆþÂà±¡ÅÐÏ¿¡ÝÀÁµá³ÎÇ§²èÌÌ
      ************************************************************
      *  ¥³¥Ô¡¼¶ç½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      ************************************************************
      *
        02  I04.
      *     02  I04-FIXED3.
              03  I04-PTNUM.
                04  I04-VALUE   PIC X(20).
              03  I04-KANANAME.
                04  I04-VALUE   PIC X(50).
              03  I04-SEX.
                04  I04-VALUE   PIC X(2).
              03  I04-HKNCOMBI.
                04  I04-VALUE   PIC X(60).
              03  I04-FTNRATE.
                04  I04-VALUE   PIC X(5).
              03  I04-NAME.
                04  I04-VALUE   PIC X(50).
              03  I04-BIRTHDAY.
                04  I04-VALUE   PIC X(9).
              03  I04-NENREI.
                04  I04-VALUE   PIC X(7).
              03  I04-SRYKA.
                04  I04-VALUE   PIC X(10).
              03  I04-HAKYMD.
                04  I04-VALUE   PIC X(9).
              03  I04-NYUINYMD.
                04  I04-VALUE   PIC X(14).
              03  I04-TAIINYMD.
                04  I04-VALUE   PIC X(14).
              03  I04-SSUHKNTEN.
                04  I04-VALUE   PIC X(10).
              03  I04-SDOHKNTEN.
                04  I04-VALUE   PIC X(10).
              03  I04-ZTKHKNTEN.
                04  I04-VALUE   PIC X(10).
              03  I04-TYKHKNTEN.
                04  I04-VALUE   PIC X(10).
              03  I04-CSYHKNTEN.
                04  I04-VALUE   PIC X(10).
              03  I04-SYCHKNTEN.
                04  I04-VALUE   PIC X(10).
              03  I04-SJTHKNTEN.
                04  I04-VALUE   PIC X(10).
              03  I04-KNSHKNTEN.
                04  I04-VALUE   PIC X(10).
              03  I04-GZUHKNTEN.
                04  I04-VALUE   PIC X(10).
              03  I04-ETCHKNTEN.
                04  I04-VALUE   PIC X(10).
              03  I04-NYUHKNTEN.
                04  I04-VALUE   PIC X(10).
              03  I04-TOTALHKNTEN.
                04  I04-VALUE   PIC X(10).
              03  I04-SUUTGMONEY.
                04  I04-VALUE   PIC X(10).
              03  I04-SDOTGMONEY.
                04  I04-VALUE   PIC X(10).
              03  I04-ZTKTGMONEY.
                04  I04-VALUE   PIC X(10).
              03  I04-TYKTGMONEY.
                04  I04-VALUE   PIC X(10).
              03  I04-CSYTGMONEY.
                04  I04-VALUE   PIC X(10).
              03  I04-SYCTGMONEY.
                04  I04-VALUE   PIC X(10).
              03  I04-SJTGMONEY.
                04  I04-VALUE   PIC X(10).
              03  I04-KNSTGMONEY.
                04  I04-VALUE   PIC X(10).
              03  I04-GZUTGMONEY.
                04  I04-VALUE   PIC X(10).
              03  I04-ETCTGMONEY.
                04  I04-VALUE   PIC X(10).
              03  I04-NYUTGMONEY.
                04  I04-VALUE   PIC X(10).
              03  I04-JIHIMSG1.
                04  I04-VALUE   PIC X(12).
              03  I04-JIHIMSG2.
                04  I04-VALUE   PIC X(12).
              03  I04-JIHIMSG3.
                04  I04-VALUE   PIC X(12).
              03  I04-JIHIMSG4.
                04  I04-VALUE   PIC X(12).
              03  I04-JIHIMSG5.
                04  I04-VALUE   PIC X(12).
              03  I04-JIHI1.
                04  I04-VALUE   PIC X(10).
              03  I04-JIHI2.
                04  I04-VALUE   PIC X(10).
              03  I04-JIHI3.
                04  I04-VALUE   PIC X(10).
              03  I04-JIHI4.
                04  I04-VALUE   PIC X(10).
              03  I04-JIHI5.
                04  I04-VALUE   PIC X(10).
              03  I04-JIHIGOK.
                04  I04-VALUE   PIC X(10).
              03  I04-JIHITAX1.
                04  I04-VALUE   PIC X(10).
              03  I04-JIHITAX2.
                04  I04-VALUE   PIC X(10).
              03  I04-JIHITAX3.
                04  I04-VALUE   PIC X(10).
              03  I04-JIHITAX4.
                04  I04-VALUE   PIC X(10).
              03  I04-JIHITAX5.
                04  I04-VALUE   PIC X(10).
              03  I04-JIHITAXGOK.
                04  I04-VALUE   PIC X(10).
              03  I04-JIHITAX.
                04  I04-VALUE   PIC X(10).
              03  I04-RYOYOHI-SKJ.
                04  I04-VALUE   PIC X(10).
              03  I04-SKYMONEY-SKJ.
                04  I04-VALUE   PIC X(10).
              03  I04-RJNFTN.
                04  I04-VALUE   PIC X(10).
              03  I04-KOHFTN.
                04  I04-VALUE   PIC X(10).
              03  I04-FTNTOTAL.
                04  I04-VALUE   PIC X(10).
              03  I04-ROUSYOSIN.
                04  I04-VALUE   PIC X(10).
              03  I04-ROUSAISIN.
                04  I04-VALUE   PIC X(10).
              03  I04-ROUSIDOU.
                04  I04-VALUE   PIC X(10).
              03  I04-ROUETC.
                04  I04-VALUE   PIC X(10).
              03  I04-SKYMONEY.
                04  I04-VALUE   PIC X(10).
              03  I04-NYUKIN.
                04  I04-VALUE   PIC X(10).
              03  I04-NYUKIN-STT
                                PIC S9(9)   BINARY.
              03  I04-HKNTEKMONEY.
                04  I04-VALUE   PIC X(10).
              03  I04-HKNTEKGAI.
                04  I04-VALUE   PIC X(10).
              03  I04-MISYUZAN-GAI.
                04  I04-VALUE   PIC X(10).
              03  I04-MISYUZAN-NYU.
                04  I04-VALUE   PIC X(10).
              03  I04-GOKSKY.
                04  I04-VALUE   PIC X(10).
              03  I04-RMSAGAKU.
                04  I04-VALUE   PIC X(10).
              03  I04-CHOSEI.
                04  I04-VALUE   PIC X(10).
              03  I04-CHOSEI-STT
                                PIC S9(9)   BINARY.
              03  I04-SELNUM.
                04  I04-VALUE   PIC S9(2).
              03  I04-CMB-SKYPRTOUT.
                04  I04-SKYPRTOUT.
                  05  I04-VALUE PIC X(20).
                04  I04-SKYPRTOUT-CNT
                                PIC S9(9)   BINARY.
                04  I04-SKYPRTOUT-ITM
                                PIC X(20)   OCCURS  2 TIMES.
              03  I04-CMB-TAIPRTOUT.
                04  I04-TAIPRTOUT.
                  05  I04-VALUE PIC X(20).
                04  I04-TAIPRTOUT-CNT
                                PIC S9(9)   BINARY.
                04  I04-TAIPRTOUT-ITM    PIC X(20)   OCCURS  2 TIMES.
              03  I04-CMB-DR.
                04  I04-DR.
                  05  I04-VALUE   PIC X(29).
                04  I04-DR-CNT   PIC S9(9)   BINARY.
                04  I04-DR-ITM    PIC X(29)   OCCURS  50 TIMES.
              03  I04-SCROLLEDWINDOW1.
                04  I04-HKNCOMBILST.
                  05  I04-HKNCOMBILST-CNT  PIC S9(9)   BINARY.
                  05  I04-HKNCOMBILST-ITM  OCCURS  15 TIMES.
                    06  I04-TSELNUM        PIC X(02).
                    06  I04-THKNCOMBI      PIC X(50).
                  05  I04-HKNCOMBILST-SELECT
                                           PIC X     OCCURS  15 TIMES.
