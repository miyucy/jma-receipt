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
            02  N01.
              03  N01-HKNJANUM.
                04  N01-VALUE   PIC X(9).
              03  N01-BANTI.
                04  N01-VALUE   PIC X(101).
              03  N01-HKNJANAMETAN1.
                04  N01-VALUE   PIC X(51).
              03  N01-HKNJANAMETAN2.
                04  N01-VALUE   PIC X(21).
              03  N01-HKNJANAMETAN3.
                04  N01-VALUE   PIC X(21).
              03  N01-POST.
                04  N01-VALUE   PIC X(8).
              03  N01-ADRS.
                04  N01-VALUE   PIC X(101).
              03  N01-HKNJANAME.
                04  N01-VALUE   PIC X(101).
              03  N01-TEL.
                04  N01-VALUE   PIC X(16).
              03  N01-KIGO.
                04  N01-VALUE   PIC X(41).
              03  N01-HKNNUMCOMBO.
                04  N01-HKNNUM.
                  05  N01-VALUE   PIC X(31).
                04  N01-COUNT     PIC S9(9)   BINARY.
                04  N01-HKNNUMLST PIC X(30)   OCCURS  100 TIMES.
