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
        02  S04.
            03  S04-FIXED2.
              04  S04-PTNUM             PIC X(20).
              04  S04-NAME              PIC X(50).
              04  S04-KKN               PIC X       OCCURS  3.
              04  S04-STRSRYYMD         PIC X(10).
              04  S04-ENDSRYYMD         PIC X(10).
              04  S04-ENDSRYYMD-STATE   PIC S9(9)   BINARY.
              04  S04-CHK               PIC X       OCCURS  2.
