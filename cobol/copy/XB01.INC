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
        02  XB01.
              03  XB01-SELNO.
                04  XB01-VALUE             PIC 9(4).
              03  XB01-SCROLLEDWINDOW2.
                04  XB01-LIST.
                  05  XB01-COUNT           PIC S9(9)   BINARY.
                  05  XB01-ITEM            OCCURS  100 TIMES.
                    07  XB01-NO            PIC X(4).
                    07  XB01-JOBNAME       PIC X(40).
                    07  XB01-JOBID         PIC X(4).
                    07  XB01-SHELLID       PIC X(9).
                    07  XB01-STARTYMD      PIC X(9).
                    07  XB01-STARTTIME     PIC X(8).
                    07  XB01-ENDYMD        PIC X(9).
                    07  XB01-ENDTIME       PIC X(8).
                    07  XB01-STEPSTARTTIME PIC X(8).
                    07  XB01-STEPENDTIME   PIC X(8).
                    07  XB01-ERRCD         PIC X(4).
                  05  XB01-SELECT          PIC X   OCCURS  100 TIMES.
