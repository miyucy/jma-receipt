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
        02  I01.
            03  I01-FIXED6.
              04  I01-B07-STT                      PIC S9(9)   BINARY.
              04  I01-B08-STT                      PIC S9(9)   BINARY.
              04  I01-B12-STT                      PIC S9(9)   BINARY.
              04  I01-PTNUM                        PIC X(20).
              04  I01-NAME                         PIC X(60).
              04  I01-SEX                          PIC X(4).
              04  I01-BIRTHDAY                     PIC X(9).
              04  I01-AGE                          PIC X(8).
              04  I01-CMB-SYORIKBN.
                05  I01-SYORIKBN                   PIC X(23).
                05  I01-SYORIKBN-CNT               PIC S9(9)   BINARY.
                05  I01-SYORIKBN-ITM               PIC X(23)
                                                   OCCURS  10.
              04  I01-IDOYMD                       PIC X(10).
              04  I01-IDOYMD-STT                   PIC S9(9)   BINARY.
              04  I01-MAEIDOYMD                    PIC X(9).
              04  I01-BRMNUM                       PIC X(6).
              04  I01-BRMNUM-STT                   PIC S9(9)   BINARY.
              04  I01-CMB-BTUNAME.
                05  I01-BTUNAME                    PIC X(23).
                05  I01-BTUNAME-STT                PIC S9(9)   BINARY.
                05  I01-BTUNAME-CNT                PIC S9(9)   BINARY.
                05  I01-BTUNAME-ITM                PIC X(23)
                                                   OCCURS  50.
                05  I01-BTUNAME-ITM-STT            PIC S9(9)   BINARY.
              04  I01-CMB-SAGAKU.
                05  I01-SAGAKU                     PIC X(23).
                05  I01-SAGAKU-STT                 PIC S9(9)   BINARY.
                05  I01-SAGAKU-CNT                 PIC S9(9)   BINARY.
                05  I01-SAGAKU-ITM                 PIC X(23)
                                                   OCCURS  20.
                05  I01-SAGAKU-ITM-STT             PIC S9(9)   BINARY.
              04  I01-NYUINYMD                     PIC X(10).
              04  I01-NYUINYMD-STT                 PIC S9(9)   BINARY.
              04  I01-CMB-NYUINKA.
                05  I01-NYUINKA                    PIC X(27).
                05  I01-NYUINKA-STT                PIC S9(9)   BINARY.
                05  I01-NYUINKA-CNT                PIC S9(9)   BINARY.
                05  I01-NYUINKA-ITM                PIC X(27)
                                                   OCCURS  99.
                05  I01-NYUINKA-ITM-STT            PIC S9(9)   BINARY.
              04  I01-CMB-SHOKAI.
                05  I01-SHOKAI                     PIC X(8).
                05  I01-SHOKAI-STT                 PIC S9(9)   BINARY.
                05  I01-SHOKAI-CNT                 PIC S9(9)   BINARY.
                05  I01-SHOKAI-ITM                 PIC X(8)
                                                   OCCURS  5.
                05  I01-SHOKAI-ITM-STT             PIC S9(9)   BINARY.
              04  I01-SHONUM                       PIC S9(2).
              04  I01-SHONUM-STT                   PIC S9(9)   BINARY.
              04  I01-LBL-SHONYUINYMD              PIC X(16).
              04  I01-TAIINYMD                     PIC X(10).
              04  I01-TAIINYMD-STT                 PIC S9(9)   BINARY.
              04  I01-CMB-DR-TBL.
                05 I01-CMB-DR-OCC                  OCCURS 3.
                  06  I01-DR                       PIC X(29).
                  06  I01-DR-STT                   PIC S9(9)   BINARY.
                  06  I01-DR-CNT                   PIC S9(9)   BINARY.
                  06  I01-DR-ITM                   PIC X(29)
                                                   OCCURS  50.
                  06  I01-DR-ITM-STT               PIC S9(9)   BINARY.
              04  I01-CMB-HKNCOMBI.
                05  I01-HKNCOMBI                   PIC X(51).
                05  I01-HKNCOMBI-STT               PIC S9(9)   BINARY.
                05  I01-HKNCOMBI-CNT               PIC S9(9)   BINARY.
                05  I01-HKNCOMBI-ITM               PIC X(51)
                                                   OCCURS  30.
                05  I01-HKNCOMBI-ITM-STT           PIC S9(9)   BINARY.
              04  I01-CMB-TOKNYUIN.
                05  I01-TOKNYUIN                   PIC X(51).
                05  I01-TOKNYUIN-STT               PIC S9(9)   BINARY.
                05  I01-TOKNYUIN-CNT               PIC S9(9)   BINARY.
                05  I01-TOKNYUIN-ITM               PIC X(51)
                                                   OCCURS  30.
                05  I01-TOKNYUIN-ITM-STT           PIC S9(9)   BINARY.
              04  I01-MAEUKE                       PIC S9(5).
              04  I01-MAEUKE-STT                   PIC S9(9)   BINARY.
              04  I01-CMB-SEIKYU.
                05  I01-SEIKYU                     PIC X(24).
                05  I01-SEIKYU-STT                 PIC S9(9)   BINARY.
                05  I01-SEIKYU-CNT                 PIC S9(9)   BINARY.
                05  I01-SEIKYU-ITM                 PIC X(24)
                                                   OCCURS  5.
                05  I01-SEIKYU-ITM-STT             PIC S9(9)   BINARY.
              04  I01-CMB-DISPKBN.
                05  I01-DISPKBN                    PIC X(11).
                05  I01-DISPKBN-STT                PIC S9(9)   BINARY.
                05  I01-DISPKBN-CNT                PIC S9(9)   BINARY.
                05  I01-DISPKBN-ITM                PIC X(11)
                                                   OCCURS  5.
                05  I01-DISPKBN-ITM-STT            PIC S9(9)   BINARY.
              04  I01-SELNUM                       PIC S9(2).
              04  I01-SCROLLEDWINDOW1.
                05  I01-NYUREKILST.
                  06  I01-NYUREKILST-CNT           PIC S9(9)   BINARY.
                  06  I01-NYUREKILST-ITM           OCCURS  50.
                    07  I01-TSELNUM                PIC X(4).
                    07  I01-TSHOKAI                PIC X(2).
                    07  I01-TSHONUM                PIC X(4).
                    07  I01-TBTUNAME               PIC X(20).
                    07  I01-TBRMNUM                PIC X(6).
                    07  I01-TNYUINYMD              PIC X(9).
                    07  I01-TTAIINYMD              PIC X(11).
                    07  I01-TNYUINKA               PIC X(20).
                    07  I01-TBYOMEI                PIC X(40).
                    07  I01-TTENKI                 PIC X(4).
                    07  I01-TNISSU                 PIC X(5).
                    07  I01-TTUSAN                 PIC X(5).
                  06  I01-NYUREKILST-SELECT        PIC X
                                                   OCCURS  50.
