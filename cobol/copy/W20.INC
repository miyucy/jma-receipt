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
        02  W20.
            03  W20-FIXED6.
              04  W20-B02-STATE            PIC S9(9)   BINARY.
              04  W20-B05-STATE            PIC S9(9)   BINARY.
              04  W20-B06-STATE            PIC S9(9)   BINARY.
              04  W20-B07-STATE            PIC S9(9)   BINARY.
              04  W20-B08-STATE            PIC S9(9)   BINARY.
              04  W20-B09                  PIC X(04).
              04  W20-B09-STATE            PIC S9(9)   BINARY.
              04  W20-B12-STATE            PIC S9(9)   BINARY.
              04  W20-BTU-NUM              PIC S9(2).
      *
              04  W20-BTU-NAME             PIC X(20).
              04  W20-BTU-NAME-STT         PIC S9(9)   BINARY.
      *
              04  W20-BTU-TANNAME          PIC X(10).
              04  W20-BTU-TANNAME-STT      PIC S9(9)   BINARY.
      *
              04  W20-CMB-BTU-TOKUTEINYUIN.
      *
                05  W20-BTU-TOKUTEINYUIN   PIC X(33).
                05  W20-BTU-TOKUTEINYUIN-STT
                                           PIC S9(9)   BINARY.
      *
                05  W20-BTU-TOKUTEINYUIN-CNT
                                           PIC S9(9)   BINARY.
                05  W20-BTU-TOKUTEINYUIN-ITM
                                           PIC X(33)   OCCURS  15.
                05  W20-BTU-TOKUTEINYUIN-ITM-STT
                                           PIC S9(9)   BINARY.
      *
              04  W20-CMB-BTU-KA.
      *
                05  W20-BTU-KA             PIC X(23).
                05  W20-BTU-KA-STT         PIC S9(9)   BINARY.
      *
                05  W20-BTU-KA-CNT         PIC S9(9)   BINARY.
                05  W20-BTU-KA-ITM         PIC X(23)   OCCURS  99.
                05  W20-BTU-KA-ITM-STT     PIC S9(9)   BINARY.
      *
              04  W20-CMB-BTU-SBT.
      *
                05  W20-BTU-SBT            PIC X(23).
                05  W20-BTU-SBT-STT        PIC S9(9)   BINARY.
      *
                05  W20-BTU-SBT-CNT        PIC S9(9)   BINARY.
                05  W20-BTU-SBT-ITM        PIC X(23)   OCCURS  15.
                05  W20-BTU-SBT-ITM-STT    PIC S9(9)   BINARY.
      *
              04  W20-CMB-BTU-HEIKINZAIKBN.
      *
                05  W20-BTU-HEIKINZAIKBN   PIC X(15).
                05  W20-BTU-HEIKINZAIKBN-STT
                                           PIC S9(9)   BINARY.
      *
                05  W20-BTU-HEIZAIKBN-CNT  PIC S9(9)  BINARY.
                05  W20-BTU-HEIZAIKBN-ITM  PIC X(15)  OCCURS  15.
                05  W20-BTU-HEIZAIKBN-ITM-STT
                                           PIC S9(9)   BINARY.
      *
              04  W20-CMB-BTU-KNGHAICHIKBN.
      *
                05  W20-BTU-KNGHAICHIKBN   PIC X(17).
                05  W20-BTU-KNGHAICHIKBN-STT
                                           PIC S9(9)   BINARY.
      *
                05  W20-BTU-KNGHAICHIKBN-CNT
                                           PIC S9(9)   BINARY.
                05  W20-BTU-KNGHAICHIKBN-ITM 
                                           PIC X(17)   OCCURS  20.
                05  W20-BTU-KNGHAICHIKBN-ITM-STT
                                           PIC S9(9)   BINARY.
      *
              04  W20-CMB-BTU-KNGHIRITUKBN.
      *
                05  W20-BTU-KNGHIRITUKBN
                                           PIC X(23).
                05  W20-BTU-KNGHIRITUKBN-STT
                                           PIC S9(9)   BINARY.
      *
                05  W20-BTU-KNGHIRIT-CNT
                                           PIC S9(9)   BINARY.
                05  W20-BTU-KNGHIRIT-ITM
                                           PIC X(23)   OCCURS  10.
                05  W20-BTU-KNGHIRIT-ITM-STT
                                           PIC S9(9)   BINARY.
      *
              04  W20-CMB-BTU-KNGHJOHAI.
      *
                05  W20-BTU-KNGHJOHAI      PIC X(15).
                05  W20-BTU-KNGHJOHAI-STT  PIC S9(9)   BINARY.
      *
                05  W20-BTU-KNGHJOHAI-CNT  PIC S9(9)   BINARY.
                05  W20-BTU-KNGHJOHAI-ITM  PIC X(15)   OCCURS  10.
                05  W20-BTU-KNGHJOHAI-ITM-STT
                                           PIC S9(9)   BINARY.
      *
              04  W20-CMB-BTU-KNGHJOKSN.
      *
                05  W20-BTU-KNGHJOKSN      PIC X(13).
                05  W20-BTU-KNGHJOKSN-STT  PIC S9(9)   BINARY.
      *
                05  W20-BTU-KNGHJOKSN-CNT  PIC S9(9)   BINARY.
                05  W20-BTU-KNGHJOKSN-ITM  PIC X(13)   OCCURS  10.
                05  W20-BTU-KNGHJOKSN-ITM-STT
                                           PIC S9(9)   BINARY.
      *
              04  W20-CMB-BTU-YAKANKNGKSN.
      *
                05  W20-BTU-YAKANKNGKSN    PIC X(23).
                05  W20-BTU-YAKANKNGKSN-STT
                                           PIC S9(9)   BINARY.
      *
                05  W20-BTU-YKNKNGKSN-CNT  PIC S9(9)   BINARY.
                05  W20-BTU-YKNKNGKSN-ITM  PIC X(23)   OCCURS  10.
                05  W20-BTU-YKNKNGKSN-ITM-STT
                                           PIC S9(9)   BINARY.
      *
              04  W20-CHK-BTU-SYOKUDOKBN   PIC X.
              04  W20-CHK-BTU-SYOKUDOKBN-STT
                                           PIC S9(9)   BINARY.
      *
              04  W20-CHK-BTU-KNGSISUKBN   PIC X.
              04  W20-CHK-BTU-KNGSISUKBN-STT
                                           PIC S9(9)   BINARY.
      *
              04  W20-CHK-BTU-HIKSISUKBN   PIC X.
              04  W20-CHK-BTU-HIKSISUKBN-STT
                                           PIC S9(9)   BINARY.
      *
              04  W20-YUKOSTYMD            PIC X(09).
              04  W20-YUKOSTYMD-STT        PIC S9(9)   BINARY.
      *
              04  W20-YUKOEDYMD            PIC X(09).
              04  W20-YUKOEDYMD-STT        PIC S9(9)   BINARY.
      *
              04  W20-CMB-BTU-EDKBN.
      *
                05  W20-BTU-EDKBN          PIC X(8).
                05  W20-BTU-EDKBN-STT      PIC S9(9)   BINARY.
      *
                05  W20-BTU-EDKBN-CNT      PIC S9(9)   BINARY.
                05  W20-BTU-EDKBN-ITM      PIC X(8)   OCCURS  2.
                05  W20-BTU-EDKBN-ITM-STT  PIC S9(9)   BINARY.
      *
      *
              04  W20-CMB-BTU-KHNRYO.
      *
                05  W20-BTU-KHNRYO         PIC X(63).
                05  W20-BTU-KHNRYO-STT
                                           PIC S9(9)   BINARY.
      *
                05  W20-BTU-KHNRYO-CNT     PIC S9(9)  BINARY.
                05  W20-BTU-KHNRYO-ITM     PIC X(63)  OCCURS  50.
                05  W20-BTU-KHNRYO-ITM-STT
                                           PIC S9(9)   BINARY.
      *
      *
              04  W20-BTU-KHNTEN           PIC S9(6).
              04  W20-BTU-KHNTEN-STT       PIC S9(9)   BINARY.
              04  W20-SELNUM               PIC S9(2).
              04  W20-SCROLLEDWINDOW28.
                05  W20-BTULST-TBL.
                  06  W20-BTULST-CNT
                                           PIC S9(9)   BINARY.
                  06  W20-BTULST-OCC       OCCURS  50.
                    07  W20-TBTU-NUM       PIC X(04).
                    07  W20-TBTU-NAME      PIC X(20).
                    07  W20-TBTU-SBT       PIC X(20).
                    07  W20-TBTU-TOKUTEINYUIN
                                           PIC X(10).
                    07  W20-TBTU-KA        PIC X(20).
                    07  W20-TBTU-KHNRYO    PIC X(30).
                    07  W20-TBTU-KHNTEN    PIC X(12).
                    07  W20-TBTU-NINZU     PIC X(10).
                    07  W20-TBTU-KNGHAIKBN
                                           PIC X(14).
                    07  W20-TBTU-KNGHIRIT
                                           PIC X(20).
                    07  W20-TBTU-HEIZAIKBN
                                           PIC X(12).
                    07  W20-TBTU-KNGHJOKSN
                                           PIC X(10).
                    07  W20-TBTU-KNGHJOHAI
                                           PIC X(12).
                    07  W20-TBTU-YAKANKNGKSN
                                           PIC X(20).
                    07  W20-TBTU-SYOKUDOKBN
                                           PIC X(06).
                    07  W20-TBTU-KNGSISUKBN
                                           PIC X(08).
                    07  W20-TBTU-HIKSISUKBN
                                           PIC X(08).
                    07  W20-TYUKOSTYMD     PIC X(09).
                    07  W20-TYUKOEDYMD     PIC X(09).
                  06  W20-BTULST-SEL       PIC X   OCCURS  50.
              04  W20-SCROLLEDWINDOW29.
                05  W20-RIREKILST-TBL.
                  06  W20-RIREKILST-CNT    PIC S9(9)   BINARY.
                  06  W20-RIREKILST-OCC    OCCURS  20.
                    07  W20-TSELNUM        PIC X(04).
                    07  W20-TRIREKI        PIC X(22).
                  06  W20-RIREKILST-SEL    PIC X   OCCURS  20.
