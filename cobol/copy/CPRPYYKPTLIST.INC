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
        01  RPYYKPTLIST-REC.
            03  RPYPL-CONTEXT              PIC S9(9)   BINARY.
            03  RPYPL-OBJECT               PIC X(8).
            03  RPYPL-MODE                 PIC S9(9)   BINARY.
            03  RPYPL-RECORDNAME           PIC X(128).
            03  RPYPL-DATA.
      *       yoyaku_kanja_list
              05  RPYPL-REPORT-ID          PIC X(30).
              05  RPYPL-CUSTOM-ID          PIC X(30).
              05  RPYPL-PRINTER            PIC X(20).
              05  RPYPL-PRTYMD             PIC X(10).
              05  RPYPL-SRYNAIYO-AREA.
                07  RPYPL-SRYNAIYO         PIC X(02).
                07  RPYPL-SRYNAIYONAME     PIC X(20).
              05  RPYPL-DOCTOR-AREA.
                07  RPYPL-DR-CODE          PIC X(5).
                07  RPYPL-DR-NAME          PIC X(50).
                07  RPYPL-DR-KANANAME      PIC X(50).
              05  RPYPL-TBL                OCCURS 6.
                07  RPYPL-TSRYYMD          PIC X(10).
                07  RPYPL-TBL2             OCCURS 1000.
                  09  RPYPL-TYYKTIME         PIC X(5).
                  09  RPYPL-TSRYKA           PIC X(2).
                  09  RPYPL-TSRYKANAME       PIC X(40).
                  09  RPYPL-TSRYNAIYO-AREA.
                    11  RPYPL-TSRYNAIYO      PIC X(02).
                    11  RPYPL-TSRYNAIYONAME  PIC X(20).
                  09  RPYPL-TDOCTOR-AREA.
                    11  RPYPL-TDR-CODE       PIC X(5).
                    11  RPYPL-TDR-NAME       PIC X(50).
                    11  RPYPL-TDR-KANANAME   PIC X(50).
                  09  RPYPL-TPTINF.
                    11  RPYPL-TPTNUM         PIC X(20).
                    11  RPYPL-TYYKNAME       PIC X(50).
                    11  RPYPL-TNAME          PIC X(50).
                    11  RPYPL-TKANANAME      PIC X(50).
                    11  RPYPL-TBIRTHDAY      PIC X(10).
                    11  RPYPL-TSEX           PIC X(1).
                  09  RPYPL-TYYKKBN          PIC X(02).
                  09  RPYPL-TYYKKBNNAME      PIC X(30).
                  09  RPYPL-TKAKREN          PIC X(02).
                  09  RPYPL-TKAKRENNAME      PIC X(20).
                  09  RPYPL-TRAIINZUMI       PIC X(1).
