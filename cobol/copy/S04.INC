      *******************************************************************
      * Project code name "ORCA"
      * z”’·‹vxr+ryrÀ”≠”{r«”≠“±´MA standard receipt softwareq≤Î      * Copyright(C) 2002 JMA (Japan Medical Association)
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
        02  S04.
            03  S04-FIXED2.
              04  S04-PTNUM            PIC X(20).
              04  S04-NAME             PIC X(50).
              04  S04-KIKANCOMBO.
                  05  S04-KIKANKBN     PIC X(10).
                  05  S04-KIKAN-COUNT  PIC S9(9)   BINARY.
                  05  S04-KIKA-LIST    PIC X(10)   OCCURS  2.
              04  S04-KKNKBN           PIC X       OCCURS  2.
              04  S04-STRSRYYMD        PIC X(10).
              04  S04-ENDSRYYMD        PIC X(10).
              04  S04-ENDSRYYMD-STATE  PIC S9(9)   BINARY.
              04  S04-LBLSYORIKBN      PIC X(30).
              04  S04-SYORICOMBO.
                  05  S04-SYORIKBN     PIC X(18).
                  05  S04-SYORIKBN-STATE
                                       PIC S9(9)   BINARY.
                  05  S04-SYORI-COUNT  PIC S9(9)   BINARY.
                  05  S04-SYORI-LIST   PIC X(18)   OCCURS  2.
                  05  S04-SYORI-LIST-STATE
                                       PIC S9(9)   BINARY.
              04  S04-DSPCOMBO.
                  05  S04-DSPKBN       PIC X(12).
                  05  S04-DSPKBN-STATE PIC S9(9)   BINARY.
                  05  S04-DSP-COUNT    PIC S9(9)   BINARY.
                  05  S04-DSP-LIST     PIC X(12)   OCCURS  2.
                  05  S04-DSP-LIST-STATE PIC S9(9) BINARY.
              04  S04-PRTKBN           PIC X       OCCURS  2.
