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
        02  W03.
            03  W03-FIXED2.
              04  W03-CD01-G      OCCURS  25.
                05  W03-CD.
                  06  W03-VALUE   PIC X(5).
              04  W03-DSPNAME-G   OCCURS 25.
                05  W03-DSPNAME.
                  06  W03-VALUE   PIC X(101).
              04  W03-STYUKYMD.
                05  W03-VALUE     PIC X(10).
              04  W03-EDYUKYMD.
                05  W03-VALUE     PIC X(10).
              04  W03-SSTKIJUN-G  OCCURS  25.
                05  W03-SSTKIJUN.
                  06  W03-VALUE   PIC 9(1).
