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
        02  W14.
                04  W14-FIXED2.
                  05  W14-STYUKYMD.
                    06  W14-VALUE   PIC X(9).
                  05  W14-EDYUKYMD.
                    06  W14-VALUE   PIC X(9).
                04  W14-CD-G   OCCURS 25.
                  05  W14-CD.
                    06  W14-VALUE   PIC X(4).
                04  W14-SHELLID-G   OCCURS 25.
                  05  W14-SHELLID.
                    06  W14-VALUE   PIC X(20).
                04  W14-SHORIMSG-G   OCCURS 25.
                  05  W14-SHORIMSG.
                    06  W14-VALUE   PIC X(40).
                04  W14-CHKBTN01-G   OCCURS 25.
                  05  W14-CHK.
                    06  W14-CHKG     OCCURS 4.
                      07  W14-CHKBTN   PIC X.
                04  W14-PRTKBN11     PIC X.
                04  W14-PRTKBN12     PIC X.
                04  W14-PRTKBN21     PIC X.
                04  W14-PRTKBN22     PIC X.
