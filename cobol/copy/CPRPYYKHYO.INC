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
        01  RPYYKHYO-REC.
            03  RPYH-CONTEXT                PIC S9(9)   BINARY.
            03  RPYH-OBJECT                 PIC X(8).
            03  RPYH-MODE                   PIC S9(9)   BINARY.
            03  RPYH-RECORDNAME             PIC X(128).
            03  RPYH-DATA.
      *     yoyaku_hyo
              05  RPYH-REPORT-ID            PIC X(30).
              05  RPYH-CUSTOM-ID            PIC X(30).
              05  RPYH-PRINTER              PIC X(20).
              05  RPYH-KOFYMD               PIC X(10).
              05  RPYH-PTINF.
                07  RPYH-PTNUM              PIC X(20).
                07  RPYH-NAME               PIC X(50).
                07  RPYH-KANANAME           PIC X(50).
                07  RPYH-BIRTHDAY           PIC X(10).
                07  RPYH-SEX                PIC X(1).
              05  RPYH-HOSP-AREA.
                07  RPYH-HOSP-NAME-G.
                  09  RPYH-HOSP-NAME        PIC X(40)
                                            OCCURS   2.
                07  RPYH-HOSP-POST          PIC X(7).
                07  RPYH-HOSP-ADRS-G.
                  09  RPYH-HOSP-ADRS        PIC X(40)
                                            OCCURS   2.
                07  RPYH-HOSP-TEL           PIC X(15).
              05  RPYH-MEMO                 PIC X(100).
              05  RPYH-TBL                  OCCURS 50.
                07  RPYH-TYYKYMD            PIC X(10).
      *         ex."12:59"
                07  RPYH-TYYKTIME           PIC X(05).
                07  RPYH-TSRYKA             PIC X(02).
                07  RPYH-TSRYKANAME         PIC X(40).
                07  RPYH-TDOCTOR-AREA.
                  09  RPYH-TDR-CODE         PIC X(5).
                  09  RPYH-TDR-NAME         PIC X(50).
                  09  RPYH-TDR-KANANAME     PIC X(50).
                07  RPYH-TCOMMENT           PIC X(80) OCCURS 6.
