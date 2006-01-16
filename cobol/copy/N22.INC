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
            02  N22.
              03  N22-FIXED17.
                05  N22-KENCD          PIC X(9).
                05  N22-KENNAME        PIC X(100).
                05  N22-TBL.
                  07  N22-KEKKALST.
                    09  N22-COUNT      PIC S9(9)   BINARY.
                    09  N22-ROW        PIC S9(9)   BINARY.
                    09  N22-ROWATTR    PIC S9(9)   BINARY.
                    09  N22-ITEM                   OCCURS  100 TIMES.
                      11  N22-TNO      PIC X(5).
                      11  N22-TYJCD    PIC X(12).
                      11  N22-TGAZO    PIC X(5).
                      11  N22-TMAKER   PIC X(50).
                      11  N22-TSELLER  PIC X(50).
                    09  N22-SELECT     PIC X       OCCURS  100 TIMES.
                05  N22-SELNUM         PIC S9(3).
                05  N22-MESSAGE-STYLE  PIC X(20).
                05  N22-MESSAGE        PIC X(100).
                05  N22-GAZOKBNCOMBO.
                  07  N22-GAZOKBN      PIC X(14).
                  07  N22-GAZOKBN-COUNT
                                       PIC S9(9)   BINARY.
                  07  N22-GAZOKBNLST   PIC X(14)   OCCURS  4 TIMES.
                05  N22-COPYKBNCOMBO.
                  07  N22-COPYKBN      PIC X(14).
                  07  N22-COPYKBN-COUNT
                                       PIC S9(9)   BINARY.
                  07  N22-COPYKBNLST   PIC X(14)   OCCURS  3 TIMES.
                05  N22-GAZO           PIC X(8)    OCCURS  3 TIMES.
                05  N22-GAZOLABEL      PIC X(14)   OCCURS  3 TIMES.
