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
          03  Z91.
                04  Z91-FIXED2.
                    05  Z91-SRYCHK             PIC X.
                    05  Z91-SRY                PIC X       OCCURS  2.
                    05  Z91-SRYSTRCOMBO.
                        06  Z91-SRYSTR         PIC X(17).
                        06  Z91-SRYSTR-STATE   PIC S9(9)   BINARY.
                        06  Z91-SRYSTR-COUNT   PIC S9(9)   BINARY.
                        06  Z91-SRYSTR-ITEM    PIC X(17)   OCCURS  13.
                    05  Z91-SRYENDCOMBO.
                        06  Z91-SRYEND         PIC X(17).
                        06  Z91-SRYEND-STATE   PIC S9(9)   BINARY.
                        06  Z91-SRYEND-COUNT   PIC S9(9)   BINARY.
                        06  Z91-SRYEND-ITEM    PIC X(17)   OCCURS  13.
                    05  Z91-IYKCHKALL          PIC X.
                    05  Z91-IYKCHK             PIC X       OCCURS  6.
                    05  Z91-TOKCHK             PIC X.
                    05  Z91-COMCHKALL          PIC X.
                    05  Z91-COMCHK             PIC X       OCCURS  3.
                    05  Z91-MSTYMD             PIC X(10).
                    05  Z91-KEI                PIC X       OCCURS  2.
                    05  Z91-CYU-G                          OCCURS  2.
                        06  Z91-CYU            PIC X.
                        06  Z91-CYU-STATE      PIC S9(9)   BINARY.
                    05  Z91-SYU                PIC X       OCCURS  3.