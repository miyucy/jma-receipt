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
        02  W31.
            03  W31-FIXED6.
              04  W31-STYUKYMD             PIC X(10).
              04  W31-EDYUKYMD             PIC X(10).
              04  W31-CHK-MEDKBN-OCC       OCCURS  40.
                05  W31-CHK-MEDKBN         PIC X(01).
                05  W31-CHK-LBLMEDKBN      PIC X(60).
                05  W31-CHK-MEDKBN-STATE   PIC S9(9)   BINARY.
