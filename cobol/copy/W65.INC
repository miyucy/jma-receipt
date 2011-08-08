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
       02  W65.
      *     02  W65-FIXED6.
              03  W65-B06-STATE                  PIC S9(9) BINARY.
              03  W65-B07-STATE                  PIC S9(9) BINARY.
              03  W65-B08-STATE                  PIC S9(9) BINARY.
              03  W65-KJNYMD                     PIC X(10).
              03  W65-SELNUM1                    PIC X(50).
              03  W65-CMB-KOHNUM.
                04  W65-KOHNUM             PIC X(64).
                04  W65-KOHNUM-STATE       PIC S9(9) BINARY.
                04  W65-KOHNUM-COUNT       PIC S9(9) BINARY.
                04  W65-KOHNUM-ITEM        PIC X(64) OCCURS 200.
                04  W65-KOHNUM-ITEM-STATE  PIC S9(9) BINARY.
              03  W65-NB1.
                04  W65-NB1-PAGENO               PIC S9(9) BINARY.
                04  W65-FXD7.
                  05  W65-CMB-JNISSUKBN.
                    06  W65-JNISSUKBN            PIC X(80).
                    06  W65-JNISSUKBN-COUNT      PIC S9(9) BINARY.
                    06  W65-JNISSUKBN-ITEM       PIC X(80)   OCCURS  10.
                  05  W65-CMB-JNISSUTAIKBN.
                    06  W65-JNISSUTAIKBN         PIC X(40).
                    06  W65-JNISSUTAIKBN-STATE   PIC S9(9) BINARY.
                    06  W65-JNISSUTAIKBN-COUNT   PIC S9(9) BINARY.
                    06  W65-JNISSUTAIKBN-ITEM    PIC X(40)   OCCURS  10.
                    06  W65-JNISSUTAIKBN-ITEM-STATE   PIC S9(9) BINARY.
                  05  W65-CMB-TOTALTENKBN.
                    06  W65-TOTALTENKBN          PIC X(80).
                    06  W65-TOTALTENKBN-COUNT    PIC S9(9) BINARY.
                    06  W65-TOTALTENKBN-ITEM     PIC X(80)   OCCURS  10.
                  05  W65-CMB-TOTALTENTAIKBN.
                    06  W65-TOTALTENTAIKBN       PIC X(40).
                    06  W65-TOTALTENTAIKBN-STATE PIC S9(9) BINARY.
                    06  W65-TOTALTENTAIKBN-COUNT PIC S9(9) BINARY.
                    06  W65-TOTALTENTAIKBN-ITEM  PIC X(40)   OCCURS  10.
                    06  W65-TOTALTENTAIKBN-ITEM-STATE PIC S9(9) BINARY.
                  05  W65-CMB-SYUKEIKBN.
                    06  W65-SYUKEIKBN            PIC X(80).
                    06  W65-SYUKEIKBN-COUNT      PIC S9(9) BINARY.
                    06  W65-SYUKEIKBN-ITEM       PIC X(80)   OCCURS  10.
                  05  W65-CMB-SYUKEITAIKBN.
                    06  W65-SYUKEITAIKBN         PIC X(40).
                    06  W65-SYUKEITAIKBN-STATE   PIC S9(9) BINARY.
                    06  W65-SYUKEITAIKBN-COUNT   PIC S9(9) BINARY.
                    06  W65-SYUKEITAIKBN-ITEM    PIC X(40)   OCCURS  10.
                    06  W65-SYUKEITAIKBN-ITEM-STATE   PIC S9(9) BINARY.
                  05  W65-CMB-FTNKEIKBNG.
                    06  W65-FTNKEIKBNG           PIC X(80).
                    06  W65-FTNKEIKBNG-COUNT     PIC S9(9) BINARY.
                    06  W65-FTNKEIKBNG-ITEM      PIC X(80)   OCCURS  10.
                  05  W65-CMB-FTNKEITAIKBNG.
                    06  W65-FTNKEITAIKBNG        PIC X(40).
                    06  W65-FTNKEITAIKBNG-STATE  PIC S9(9) BINARY.
                    06  W65-FTNKEITAIKBNG-COUNT  PIC S9(9) BINARY.
                    06  W65-FTNKEITAIKBNG-ITEM   PIC X(40)   OCCURS  10.
                    06  W65-FTNKEITAIKBNG-ITEM-STATE  PIC S9(9) BINARY.
                  05  W65-CMB-FTNKEIKBNN.
                    06  W65-FTNKEIKBNN           PIC X(80).
                    06  W65-FTNKEIKBNN-COUNT     PIC S9(9) BINARY.
                    06  W65-FTNKEIKBNN-ITEM      PIC X(80)   OCCURS  10.
                  05  W65-CMB-FTNKEITAIKBNN.
                    06  W65-FTNKEITAIKBNN        PIC X(40).
                    06  W65-FTNKEITAIKBNN-STATE  PIC S9(9) BINARY.
                    06  W65-FTNKEITAIKBNN-COUNT  PIC S9(9) BINARY.
                    06  W65-FTNKEITAIKBNN-ITEM   PIC X(40)   OCCURS  10.
                    06  W65-FTNKEITAIKBNN-ITEM-STATE  PIC S9(9) BINARY.
                  05  W65-CMB-FTNMONEYKBNG.
                    06  W65-FTNMONEYKBNG         PIC X(80).
                    06  W65-FTNMONEYKBNG-COUNT   PIC S9(9) BINARY.
                    06  W65-FTNMONEYKBNG-ITEM    PIC X(80)   OCCURS  10.
                  05  W65-CMB-FTNMONEYTAIKBNG.
                    06  W65-FTNMONEYTAIKBNG      PIC X(40).
                    06  W65-FTNMONEYTAIKBNG-STATE PIC S9(9) BINARY.
                    06  W65-FTNMONEYTAIKBNG-COUNT PIC S9(9) BINARY.
                    06  W65-FTNMONEYTAIKBNG-ITEM PIC X(40)   OCCURS  10.
                    06  W65-FTNMONEYTAIKBNG-ITEM-STATE PIC S9(9) BINARY.
                  05  W65-CMB-FTNMONEYKBNN.
                    06  W65-FTNMONEYKBNN         PIC X(80).
                    06  W65-FTNMONEYKBNN-COUNT   PIC S9(9) BINARY.
                    06  W65-FTNMONEYKBNN-ITEM    PIC X(80)   OCCURS  10.
                  05  W65-CMB-FTNMONEYTAIKBNN.
                    06  W65-FTNMONEYTAIKBNN      PIC X(40).
                    06  W65-FTNMONEYTAIKBNN-STATE PIC S9(9) BINARY.
                    06  W65-FTNMONEYTAIKBNN-COUNT PIC S9(9) BINARY.
                    06  W65-FTNMONEYTAIKBNN-ITEM PIC X(40)   OCCURS  10.
                    06  W65-FTNMONEYTAIKBNN-ITEM-STATE PIC S9(9) BINARY.
                  05  W65-CMB-FTNZEROKBNG.
                    06  W65-FTNZEROKBNG          PIC X(80).
                    06  W65-FTNZEROKBNG-COUNT    PIC S9(9) BINARY.
                    06  W65-FTNZEROKBNG-ITEM     PIC X(80)   OCCURS  10.
                  05  W65-CMB-FTNZEROTAIKBNG.
                    06  W65-FTNZEROTAIKBNG       PIC X(40).
                    06  W65-FTNZEROTAIKBNG-STATE PIC S9(9) BINARY.
                    06  W65-FTNZEROTAIKBNG-COUNT PIC S9(9) BINARY.
                    06  W65-FTNZEROTAIKBNG-ITEM  PIC X(40)   OCCURS  10.
                    06  W65-FTNZEROTAIKBNG-ITEM-STATE PIC S9(9) BINARY.
                  05  W65-CMB-FTNZEROKBNN.
                    06  W65-FTNZEROKBNN          PIC X(80).
                    06  W65-FTNZEROKBNN-COUNT    PIC S9(9) BINARY.
                    06  W65-FTNZEROKBNN-ITEM     PIC X(80)   OCCURS  10.
                  05  W65-CMB-FTNZEROTAIKBNN.
                    06  W65-FTNZEROTAIKBNN       PIC X(40).
                    06  W65-FTNZEROTAIKBNN-STATE PIC S9(9) BINARY.
                    06  W65-FTNZEROTAIKBNN-COUNT PIC S9(9) BINARY.
                    06  W65-FTNZEROTAIKBNN-ITEM  PIC X(40)   OCCURS  10.
                    06  W65-FTNZEROTAIKBNN-ITEM-STATE PIC S9(9) BINARY.
                  05  W65-CMB-SKJKBN.
                    06  W65-SKJKBN               PIC X(80).
                    06  W65-SKJKBN-COUNT         PIC S9(9) BINARY.
                    06  W65-SKJKBN-ITEM          PIC X(80)   OCCURS  10.
                  05  W65-CMB-SKJTAIKBN.
                    06  W65-SKJTAIKBN            PIC X(40).
                    06  W65-SKJTAIKBN-STATE      PIC S9(9) BINARY.
                    06  W65-SKJTAIKBN-COUNT      PIC S9(9) BINARY.
                    06  W65-SKJTAIKBN-ITEM       PIC X(40)   OCCURS  10.
                    06  W65-SKJTAIKBN-ITEM-STATE      PIC S9(9) BINARY.
                  05  W65-CMB-OCRKBN.
                    06  W65-OCRKBN               PIC X(80).
                    06  W65-OCRKBN-COUNT         PIC S9(9) BINARY.
                    06  W65-OCRKBN-ITEM          PIC X(80)   OCCURS  10.
                  05  W65-CMB-OCRTAIKBN.
                    06  W65-OCRTAIKBN            PIC X(40).
                    06  W65-OCRTAIKBN-STATE      PIC S9(9) BINARY.
                    06  W65-OCRTAIKBN-COUNT      PIC S9(9) BINARY.
                    06  W65-OCRTAIKBN-ITEM       PIC X(40)   OCCURS  10.
                    06  W65-OCRTAIKBN-ITEM-STATE      PIC S9(9) BINARY.
                  05  W65-CMB-SAIKEIKBN.
                    06  W65-SAIKEIKBN            PIC X(80).
                    06  W65-SAIKEIKBN-COUNT      PIC S9(9) BINARY.
                    06  W65-SAIKEIKBN-ITEM       PIC X(80)   OCCURS  10.
                  05  W65-CMB-SAIKEITAIKBN.
                    06  W65-SAIKEITAIKBN         PIC X(40).
                    06  W65-SAIKEITAIKBN-STATE   PIC S9(9) BINARY.
                    06  W65-SAIKEITAIKBN-COUNT   PIC S9(9) BINARY.
                    06  W65-SAIKEITAIKBN-ITEM    PIC X(40)   OCCURS  10.
                    06  W65-SAIKEITAIKBN-ITEM-STATE   PIC S9(9) BINARY.
                04  W65-FXD8.
                  05  W65-CMB-HKNFTNKBNK.
                    06  W65-HKNFTNKBNK           PIC X(80).
                    06  W65-HKNFTNKBNK-COUNT     PIC S9(9) BINARY.
                    06  W65-HKNFTNKBNK-ITEM      PIC X(80)   OCCURS  10.
                  05  W65-CMB-HKNFTNTAIKBNK.
                    06  W65-HKNFTNTAIKBNK        PIC X(40).
                    06  W65-HKNFTNTAIKBNK-STATE  PIC S9(9) BINARY.
                    06  W65-HKNFTNTAIKBNK-COUNT  PIC S9(9) BINARY.
                    06  W65-HKNFTNTAIKBNK-ITEM   PIC X(40)   OCCURS  10.
                    06  W65-HKNFTNTAIKBNK-ITEM-STATE  PIC S9(9) BINARY.
                  05  W65-CMB-HKNFTNKBNY.
                    06  W65-HKNFTNKBNY           PIC X(80).
                    06  W65-HKNFTNKBNY-COUNT     PIC S9(9) BINARY.
                    06  W65-HKNFTNKBNY-ITEM      PIC X(80)   OCCURS  10.
                  05  W65-CMB-HKNFTNTAIKBNY.
                    06  W65-HKNFTNTAIKBNY        PIC X(40).
                    06  W65-HKNFTNTAIKBNY-STATE  PIC S9(9) BINARY.
                    06  W65-HKNFTNTAIKBNY-COUNT  PIC S9(9) BINARY.
                    06  W65-HKNFTNTAIKBNY-ITEM   PIC X(40)   OCCURS  10.
                    06  W65-HKNFTNTAIKBNY-ITEM-STATE  PIC S9(9) BINARY.
                  05  W65-CMB-RECEKSIKBNG.
                    06  W65-RECEKSIKBNG          PIC X(80).
                    06  W65-RECEKSIKBNG-COUNT    PIC S9(9) BINARY.
                    06  W65-RECEKSIKBNG-ITEM     PIC X(80)   OCCURS  10.
                  05  W65-CMB-RECEKSITAIKBNG.
                    06  W65-RECEKSITAIKBNG       PIC X(40).
                    06  W65-RECEKSITAIKBNG-STATE PIC S9(9) BINARY.
                    06  W65-RECEKSITAIKBNG-COUNT PIC S9(9) BINARY.
                    06  W65-RECEKSITAIKBNG-ITEM  PIC X(40)   OCCURS  10.
                    06  W65-RECEKSITAIKBNG-ITEM-STATE PIC S9(9) BINARY.
                  05  W65-CMB-RECEKSIKBNN.
                    06  W65-RECEKSIKBNN          PIC X(80).
                    06  W65-RECEKSIKBNN-COUNT    PIC S9(9) BINARY.
                    06  W65-RECEKSIKBNN-ITEM     PIC X(80)   OCCURS  10.
                  05  W65-CMB-RECEKSITAIKBNN.
                    06  W65-RECEKSITAIKBNN       PIC X(40).
                    06  W65-RECEKSITAIKBNN-STATE PIC S9(9) BINARY.
                    06  W65-RECEKSITAIKBNN-COUNT PIC S9(9) BINARY.
                    06  W65-RECEKSITAIKBNN-ITEM  PIC X(40)   OCCURS  10.
                    06  W65-RECEKSITAIKBNN-ITEM-STATE PIC S9(9) BINARY.
                  05  W65-CMB-CHKJGNKBNG.
                    06  W65-CHKJGNKBNG           PIC X(80).
                    06  W65-CHKJGNKBNG-COUNT     PIC S9(9) BINARY.
                    06  W65-CHKJGNKBNG-ITEM      PIC X(80)   OCCURS  10.
                  05  W65-CMB-CHKJGNTAIKBNG.
                    06  W65-CHKJGNTAIKBNG        PIC X(40).
                    06  W65-CHKJGNTAIKBNG-STATE  PIC S9(9) BINARY.
                    06  W65-CHKJGNTAIKBNG-COUNT  PIC S9(9) BINARY.
                    06  W65-CHKJGNTAIKBNG-ITEM   PIC X(40)   OCCURS  10.
                    06  W65-CHKJGNTAIKBNG-ITEM-STATE  PIC S9(9) BINARY.
                  05  W65-CMB-CHKJGNKBNN.
                    06  W65-CHKJGNKBNN           PIC X(80).
                    06  W65-CHKJGNKBNN-COUNT     PIC S9(9) BINARY.
                    06  W65-CHKJGNKBNN-ITEM      PIC X(80)   OCCURS  10.
                  05  W65-CMB-CHKJGNTAIKBNN.
                    06  W65-CHKJGNTAIKBNN        PIC X(40).
                    06  W65-CHKJGNTAIKBNN-STATE  PIC S9(9) BINARY.
                    06  W65-CHKJGNTAIKBNN-COUNT  PIC S9(9) BINARY.
                    06  W65-CHKJGNTAIKBNN-ITEM   PIC X(40)   OCCURS  10.
                    06  W65-CHKJGNTAIKBNN-ITEM-STATE  PIC S9(9) BINARY.
                  05  W65-CMB-KOHSKYKBNG.
                    06  W65-KOHSKYKBNG           PIC X(80).
                    06  W65-KOHSKYKBNG-COUNT     PIC S9(9) BINARY.
                    06  W65-KOHSKYKBNG-ITEM      PIC X(80)   OCCURS  10.
                  05  W65-CMB-KOHSKYTAIKBNG.
                    06  W65-KOHSKYTAIKBNG        PIC X(40).
                    06  W65-KOHSKYTAIKBNG-STATE  PIC S9(9) BINARY.
                    06  W65-KOHSKYTAIKBNG-COUNT  PIC S9(9) BINARY.
                    06  W65-KOHSKYTAIKBNG-ITEM   PIC X(40)   OCCURS  10.
                    06  W65-KOHSKYTAIKBNG-ITEM-STATE  PIC S9(9) BINARY.
                  05  W65-CMB-KOHSKYKBNN.
                    06  W65-KOHSKYKBNN           PIC X(80).
                    06  W65-KOHSKYKBNN-COUNT     PIC S9(9) BINARY.
                    06  W65-KOHSKYKBNN-ITEM      PIC X(80)   OCCURS  10.
                  05  W65-CMB-KOHSKYTAIKBNN.
                    06  W65-KOHSKYTAIKBNN        PIC X(40).
                    06  W65-KOHSKYTAIKBNN-STATE  PIC S9(9) BINARY.
                    06  W65-KOHSKYTAIKBNN-COUNT  PIC S9(9) BINARY.
                    06  W65-KOHSKYTAIKBNN-ITEM   PIC X(40)   OCCURS  10.
                    06  W65-KOHSKYTAIKBNN-ITEM-STATE  PIC S9(9) BINARY.
                04  W65-FXD9.
                  05  W65-CMB-JYUHENKBN.
                    06  W65-JYUHENKBN            PIC X(80).
                    06  W65-JYUHENKBN-COUNT      PIC S9(9) BINARY.
                    06  W65-JYUHENKBN-ITEM       PIC X(80)   OCCURS  10.
                  05  W65-CMB-JYUHENTAIKBN.
                    06  W65-JYUHENTAIKBN         PIC X(40).
                    06  W65-JYUHENTAIKBN-STATE   PIC S9(9) BINARY.
                    06  W65-JYUHENTAIKBN-COUNT   PIC S9(9) BINARY.
                    06  W65-JYUHENTAIKBN-ITEM    PIC X(40)   OCCURS  10.
                    06  W65-JYUHENTAIKBN-ITEM-STATE   PIC S9(9) BINARY.
                  05  W65-CMB-JGNFTNKBN.
                    06  W65-JGNFTNKBN            PIC X(80).
                    06  W65-JGNFTNKBN-COUNT      PIC S9(9) BINARY.
                    06  W65-JGNFTNKBN-ITEM       PIC X(80)   OCCURS  10.
                  05  W65-CMB-JGNFTNTAIKBN.
                    06  W65-JGNFTNTAIKBN         PIC X(40).
                    06  W65-JGNFTNTAIKBN-STATE   PIC S9(9) BINARY.
                    06  W65-JGNFTNTAIKBN-COUNT   PIC S9(9) BINARY.
                    06  W65-JGNFTNTAIKBN-ITEM    PIC X(40)   OCCURS  10.
                    06  W65-JGNFTNTAIKBN-ITEM-STATE   PIC S9(9) BINARY.
                  05  W65-CMB-PTJGNKBN.
                    06  W65-PTJGNKBN             PIC X(80).
                    06  W65-PTJGNKBN-COUNT       PIC S9(9) BINARY.
                    06  W65-PTJGNKBN-ITEM        PIC X(80)   OCCURS  10.
                  05  W65-CMB-PTJGNTAIKBN.
                    06  W65-PTJGNTAIKBN          PIC X(40).
                    06  W65-PTJGNTAIKBN-STATE    PIC S9(9) BINARY.
                    06  W65-PTJGNTAIKBN-COUNT    PIC S9(9) BINARY.
                    06  W65-PTJGNTAIKBN-ITEM     PIC X(40)   OCCURS  10.
                    06  W65-PTJGNTAIKBN-ITEM-STATE    PIC S9(9) BINARY.
                  05  W65-CMB-IRYOKEIKBNG.
                    06  W65-IRYOKEIKBNG          PIC X(80).
                    06  W65-IRYOKEIKBNG-COUNT    PIC S9(9) BINARY.
                    06  W65-IRYOKEIKBNG-ITEM     PIC X(80)   OCCURS  10.
                  05  W65-CMB-IRYOKEITAIKBNG.
                    06  W65-IRYOKEITAIKBNG       PIC X(40).
                    06  W65-IRYOKEITAIKBNG-STATE PIC S9(9) BINARY.
                    06  W65-IRYOKEITAIKBNG-COUNT PIC S9(9) BINARY.
                    06  W65-IRYOKEITAIKBNG-ITEM  PIC X(40)   OCCURS  10.
                    06  W65-IRYOKEITAIKBNG-ITEM-STATE PIC S9(9) BINARY.
                  05  W65-CMB-IRYOKEIKBNN.
                    06  W65-IRYOKEIKBNN          PIC X(80).
                    06  W65-IRYOKEIKBNN-COUNT    PIC S9(9) BINARY.
                    06  W65-IRYOKEIKBNN-ITEM     PIC X(80)   OCCURS  10.
                  05  W65-CMB-IRYOKEITAIKBNN.
                    06  W65-IRYOKEITAIKBNN       PIC X(40).
                    06  W65-IRYOKEITAIKBNN-STATE PIC S9(9) BINARY.
                    06  W65-IRYOKEITAIKBNN-COUNT PIC S9(9) BINARY.
                    06  W65-IRYOKEITAIKBNN-ITEM  PIC X(40)   OCCURS  10.
                    06  W65-IRYOKEITAIKBNN-ITEM-STATE PIC S9(9) BINARY.
                  05  W65-CMB-SKJKEIKBN.
                    06  W65-SKJKEIKBN            PIC X(80).
                    06  W65-SKJKEIKBN-COUNT      PIC S9(9) BINARY.
                    06  W65-SKJKEIKBN-ITEM       PIC X(80)   OCCURS  10.
                  05  W65-CMB-SKJKEITAIKBN.
                    06  W65-SKJKEITAIKBN         PIC X(40).
                    06  W65-SKJKEITAIKBN-STATE   PIC S9(9) BINARY.
                    06  W65-SKJKEITAIKBN-COUNT   PIC S9(9) BINARY.
                    06  W65-SKJKEITAIKBN-ITEM    PIC X(40)   OCCURS  10.
                    06  W65-SKJKEITAIKBN-ITEM-STATE   PIC S9(9) BINARY.
                04  W65-FXD10.
                  05  W65-CMB-SKJRYOKBNHON.
                    06  W65-SKJRYOKBNHON         PIC X(80).
                    06  W65-SKJRYOKBNHON-COUNT   PIC S9(9) BINARY.
                    06  W65-SKJRYOKBNHON-ITEM    PIC X(80)   OCCURS  10.
                  05  W65-CMB-SKJRYOTAIKBNHON.
                    06  W65-SKJRYOTAIKBNHON      PIC X(40).
                    06  W65-SKJRYOTAIKBNHON-STATE PIC S9(9) BINARY.
                    06  W65-SKJRYOTAIKBNHON-COUNT PIC S9(9) BINARY.
                    06  W65-SKJRYOTAIKBNHON-ITEM PIC X(40)   OCCURS  10.
                    06  W65-SKJRYOTAIKBNHON-ITEM-STATE PIC S9(9) BINARY.
                  05  W65-CMB-SEIRYOKBNHON.
                    06  W65-SEIRYOKBNHON         PIC X(80).
                    06  W65-SEIRYOKBNHON-COUNT   PIC S9(9) BINARY.
                    06  W65-SEIRYOKBNHON-ITEM    PIC X(80)   OCCURS  10.
                  05  W65-CMB-SEIRYOTAIKBNHON.
                    06  W65-SEIRYOTAIKBNHON      PIC X(40).
                    06  W65-SEIRYOTAIKBNHON-STATE PIC S9(9) BINARY.
                    06  W65-SEIRYOTAIKBNHON-COUNT PIC S9(9) BINARY.
                    06  W65-SEIRYOTAIKBNHON-ITEM PIC X(40)   OCCURS  10.
                    06  W65-SEIRYOTAIKBNHON-ITEM-STATE PIC S9(9) BINARY.
                  05  W65-CMB-SEIKANKBNHON.
                    06  W65-SEIKANKBNHON         PIC X(80).
                    06  W65-SEIKANKBNHON-COUNT   PIC S9(9) BINARY.
                    06  W65-SEIKANKBNHON-ITEM    PIC X(80)   OCCURS  10.
                  05  W65-CMB-SEIKANTAIKBNHON.
                    06  W65-SEIKANTAIKBNHON      PIC X(40).
                    06  W65-SEIKANTAIKBNHON-STATE PIC S9(9) BINARY.
                    06  W65-SEIKANTAIKBNHON-COUNT PIC S9(9) BINARY.
                    06  W65-SEIKANTAIKBNHON-ITEM PIC X(40)   OCCURS  10.
                    06  W65-SEIKANTAIKBNHON-ITEM-STATE PIC S9(9) BINARY.
                  05  W65-CMB-SKJRYOKBNTSY.
                    06  W65-SKJRYOKBNTSY         PIC X(80).
                    06  W65-SKJRYOKBNTSY-COUNT   PIC S9(9) BINARY.
                    06  W65-SKJRYOKBNTSY-ITEM    PIC X(80)   OCCURS  10.
                  05  W65-CMB-SKJRYOTAIKBNTSY.
                    06  W65-SKJRYOTAIKBNTSY      PIC X(40).
                    06  W65-SKJRYOTAIKBNTSY-STATE PIC S9(9) BINARY.
                    06  W65-SKJRYOTAIKBNTSY-COUNT PIC S9(9) BINARY.
                    06  W65-SKJRYOTAIKBNTSY-ITEM PIC X(40)   OCCURS  10.
                    06  W65-SKJRYOTAIKBNTSY-ITEM-STATE PIC S9(9) BINARY.
                  05  W65-CMB-SEIRYOKBNTSY.
                    06  W65-SEIRYOKBNTSY         PIC X(80).
                    06  W65-SEIRYOKBNTSY-COUNT   PIC S9(9) BINARY.
                    06  W65-SEIRYOKBNTSY-ITEM    PIC X(80)   OCCURS  10.
                  05  W65-CMB-SEIRYOTAIKBNTSY.
                    06  W65-SEIRYOTAIKBNTSY      PIC X(40).
                    06  W65-SEIRYOTAIKBNTSY-STATE PIC S9(9) BINARY.
                    06  W65-SEIRYOTAIKBNTSY-COUNT PIC S9(9) BINARY.
                    06  W65-SEIRYOTAIKBNTSY-ITEM PIC X(40)   OCCURS  10.
                    06  W65-SEIRYOTAIKBNTSY-ITEM-STATE PIC S9(9) BINARY.
                  05  W65-CMB-SEIKANKBNTSY.
                    06  W65-SEIKANKBNTSY         PIC X(80).
                    06  W65-SEIKANKBNTSY-COUNT   PIC S9(9) BINARY.
                    06  W65-SEIKANKBNTSY-ITEM    PIC X(80)   OCCURS  10.
                  05  W65-CMB-SEIKANTAIKBNTSY.
                    06  W65-SEIKANTAIKBNTSY      PIC X(40).
                    06  W65-SEIKANTAIKBNTSY-STATE PIC S9(9) BINARY.
                    06  W65-SEIKANTAIKBNTSY-COUNT PIC S9(9) BINARY.
                    06  W65-SEIKANTAIKBNTSY-ITEM PIC X(40)   OCCURS  10.
                    06  W65-SEIKANTAIKBNTSY-ITEM-STATE PIC S9(9) BINARY.
                  05  W65-CMB-SKJRYOKBNTNK.
                    06  W65-SKJRYOKBNTNK         PIC X(80).
                    06  W65-SKJRYOKBNTNK-COUNT   PIC S9(9) BINARY.
                    06  W65-SKJRYOKBNTNK-ITEM    PIC X(80)   OCCURS  10.
                  05  W65-CMB-SKJRYOTAIKBNTNK.
                    06  W65-SKJRYOTAIKBNTNK      PIC X(40).
                    06  W65-SKJRYOTAIKBNTNK-STATE PIC S9(9) BINARY.
                    06  W65-SKJRYOTAIKBNTNK-COUNT PIC S9(9) BINARY.
                    06  W65-SKJRYOTAIKBNTNK-ITEM PIC X(40)   OCCURS  10.
                    06  W65-SKJRYOTAIKBNTNK-ITEM-STATE PIC S9(9) BINARY.
                  05  W65-CMB-SEIRYOKBNTNK.
                    06  W65-SEIRYOKBNTNK         PIC X(80).
                    06  W65-SEIRYOKBNTNK-COUNT   PIC S9(9) BINARY.
                    06  W65-SEIRYOKBNTNK-ITEM    PIC X(80)   OCCURS  10.
                  05  W65-CMB-SEIRYOTAIKBNTNK.
                    06  W65-SEIRYOTAIKBNTNK      PIC X(40).
                    06  W65-SEIRYOTAIKBNTNK-STATE PIC S9(9) BINARY.
                    06  W65-SEIRYOTAIKBNTNK-COUNT PIC S9(9) BINARY.
                    06  W65-SEIRYOTAIKBNTNK-ITEM PIC X(40)   OCCURS  10.
                    06  W65-SEIRYOTAIKBNTNK-ITEM-STATE PIC S9(9) BINARY.
                  05  W65-CMB-SEIKANKBNTNK.
                    06  W65-SEIKANKBNTNK         PIC X(80).
                    06  W65-SEIKANKBNTNK-COUNT   PIC S9(9) BINARY.
                    06  W65-SEIKANKBNTNK-ITEM    PIC X(80)   OCCURS  10.
                  05  W65-CMB-SEIKANTAIKBNTNK.
                    06  W65-SEIKANTAIKBNTNK      PIC X(40).
                    06  W65-SEIKANTAIKBNTNK-STATE PIC S9(9) BINARY.
                    06  W65-SEIKANTAIKBNTNK-COUNT PIC S9(9) BINARY.
                    06  W65-SEIKANTAIKBNTNK-ITEM PIC X(40)   OCCURS  10.
                    06  W65-SEIKANTAIKBNTNK-ITEM-STATE PIC S9(9) BINARY.
              03  W65-YUKOSTYMD                  PIC X(10).
              03  W65-YUKOSTYMD-STATE            PIC S9(9) BINARY.
              03  W65-YUKOEDYMD                  PIC X(10).
              03  W65-YUKOEDYMD-STATE            PIC S9(9) BINARY.
              03  W65-SELNUM2 PIC S9(2).
              03  W65-SELNUM2-STATE              PIC S9(9) BINARY.
              03  W65-LBLMODE-STYLE              PIC X(20).
              03  W65-LBLMODE                    PIC X(40).
              03  W65-SCRW1.
                04  W65-KOHLST.
                  05  W65-KOHLST-COUNT           PIC S9(9) BINARY.
                  05  W65-KOHLST-ROW             PIC S9(9) BINARY.
                  05  W65-KOHLST-ROWATTR         PIC S9(9) BINARY.
                  05  W65-KOHLST-ITEM            OCCURS  100.
                    06  W65-TKNO                 PIC X(4).
                    06  W65-TKKOHNUM             PIC X(3).
                    06  W65-TKKOHNAME            PIC X(100).
                    06  W65-TKYUKSTYMD           PIC X(10).
                    06  W65-TKYUKEDYMD           PIC X(10).
                  05  W65-KOHLST-SELECT          PIC X  OCCURS  100.
              03  W65-SCRW29.
                04  W65-RIREKILST.
                  05  W65-RIREKILST-COUNT   PIC S9(9) BINARY.
                  05  W65-RIREKILST-ROW     PIC S9(9) BINARY.
                  05  W65-RIREKILST-ROWATTR PIC S9(9) BINARY.
                  05  W65-RIREKILST-ITEM    OCCURS  20.
                    06  W65-TRNO            PIC X(3).
                    06  W65-TRKIKAN         PIC X(30).
                  05  W65-RIREKILST-SELECT  PIC X   OCCURS  20.
