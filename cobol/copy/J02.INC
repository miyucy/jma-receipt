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
        02  J02.
     **** 02  J02-FIXED1.
              03  J02-PTNUM.
                04  J02-VALUE   PIC X(20).
              03  J02-SRYYM.
                04  J02-VALUE   PIC X(6).
              03  J02-KANANAME.
                04  J02-VALUE   PIC X(50).
              03  J02-NAME.
                04  J02-VALUE   PIC X(50).
              03  J02-BIRTHDAY.
                04  J02-VALUE   PIC X(9).
              03  J02-MEISYO.
                04  J02-VALUE   PIC X(50).
              03  J02-NUM.
                04  J02-VALUE   PIC X(3).
              03  J02-HKNCOMBI.
                04  J02-VALUE   PIC X(4).
              03  J02-HKNCOMBIMEI.
                04  J02-VALUE   PIC X(60).
              03  J02-SEX.
                04  J02-VALUE   PIC X(2).
              03  J02-DAY       OCCURS 31.
                04  J02-VALUE   PIC X(2).
              03  J02-RRKSELNUM.
                04  J02-VALUE   PIC X(3).
              03  J02-HENSRYYMD.
                04  J02-VALUE   PIC X(10).
              03  J02-SCROLLEDWINDOW1.
                04  J02-DATALIST.
                  05  J02-DATALIST-COUNT   PIC S9(9)   BINARY.
                  05  J02-DATALIST-ITEM        OCCURS  400 TIMES.
                    06  J02-TNO          PIC X(3).
                    06  J02-TMEISYO      PIC X(60).
                    06  J02-TSURYO       PIC X(13).
                    06  J02-TTENSU       PIC X(7).
                    06  J02-THKNCOMBI    PIC X(4).
                    06  J02-TDAY-G.
                        08  J02-TDAY    PIC X(3)  OCCURS  31.
                  05  J02-DATALIST-SELECT  PIC X   OCCURS  400 TIMES.
              03  J02-SRYKAMEI.
                04  J02-VALUE   PIC X(4).
              03  J02-SCROLLEDWINDOW2.
                04  J02-RRKLIST.
                  05  J02-RRKLIST-COUNT   PIC S9(9)   BINARY.
                  05  J02-ITEM        OCCURS  60 TIMES.
                    06  J02-RRKNO     PIC X(3).
                    06  J02-RRKYMD    PIC X(20).
                  05  J02-RRKLIST-SELECT  PIC X       OCCURS  60 TIMES.
              03  J02-SRYKBNCOMB.
                04  J02-SRYKBN.
                  05  J02-VALUE   PIC X(19).
                04  J02-SRYKBN-COUNT   PIC S9(9)   BINARY.
                04  J02-SRYKBN-ITEM    PIC X(19)    OCCURS  30 TIMES.
              03  J02-SRYKACOMB.
                04  J02-SRYKA.
                  05  J02-VALUE   PIC X(16).
                04  J02-SRYKA-COUNT   PIC S9(9)   BINARY.
                04  J02-SRYKA-ITEM    PIC X(16)   OCCURS  10 TIMES.
              03  J02-NYUGAIKBNCOMB.
                04  J02-NYUGAIKBN.
                  05  J02-VALUE   PIC X(10).
                04  J02-NYUGAIKBN-COUNT   PIC S9(9)   BINARY.
                04  J02-NYUGAIKBN-ITEM    PIC X(10)   OCCURS  2 TIMES.
              03  J02-NYUINMSG2.
                04  J02-NYUINMSG2-STYLE   PIC X(20).
                04  J02-NYUINMSG2-VALUE   PIC X(50).
              03  J02-NYUINMSG1.
                04  J02-NYUINMSG1-STYLE   PIC X(20).
                04  J02-NYUINMSG1-VALUE   PIC X(50).
              03  J02-NYUINKIKAN.
                04  J02-VALUE   PIC X(30).
