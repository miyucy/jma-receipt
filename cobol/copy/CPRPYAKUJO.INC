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
        01  RPYAKUJO-REC.
            03  RPYAKUJO-CONTEXT                PIC S9(9)   BINARY.
            03  RPYAKUJO-OBJECT                 PIC X(8).
            03  RPYAKUJO-MODE                   PIC S9(9)   BINARY.
            03  RPYAKUJO-RECORDNAME             PIC X(128).
            03  RPYAKUJO-DATA.
              05  RPYAKUJO-REPORT-ID            PIC X(30).
              05  RPYAKUJO-CUSTOM-ID            PIC X(30).
              05  RPYAKUJO-PRINTER              PIC X(20).
              05  RPYAKUJO-STYLE                PIC X(1).
      *       診療日
              05  RPYAKUJO-SRYYMD               PIC X(10).
      *       交付日
              05  RPYAKUJO-KOFYMD               PIC X(10).
              05  RPYAKUJO-PTINF.
                07  RPYAKUJO-PTNUM              PIC X(20).
                07  RPYAKUJO-NAME               PIC X(50).
                07  RPYAKUJO-KANANAME           PIC X(50).
                07  RPYAKUJO-BIRTHDAY           PIC X(10).
                07  RPYAKUJO-SEX                PIC X(1).
              05  RPYAKUJO-HOSP-AREA.
                07  RPYAKUJO-HOSP-NAME-G.
                  09  RPYAKUJO-HOSP-NAME         PIC X(120)
                                                 OCCURS   3.
                07  RPYAKUJO-HOSP-POST           PIC X(7).
      *         住所
                07  RPYAKUJO-HOSP-ADRS-G.
                  09  RPYAKUJO-HOSP-ADRS         PIC X(200)
                                                 OCCURS   3.
                07  RPYAKUJO-HOSP-TEL            PIC X(15).
              05  RPYAKUJO-DOCTOR-AREA.
                07  RPYAKUJO-DR-CODE             PIC X(5).
                07  RPYAKUJO-DR-NAME             PIC X(50).
                07  RPYAKUJO-DR-KANANAME         PIC X(50).
              05  RPYAKUJO-SHURUISU              PIC X(3).
              05  RPYAKUJO-YAKUJO-AREA           OCCURS   99.
                07  RPYAKUJO-YKZNAME             PIC X(100).
                07  RPYAKUJO-SRYCD               PIC X(9).
                07  RPYAKUJO-IMAGE-ID            PIC X(36).
                07  RPYAKUJO-EFFECT              PIC X(1000).
                07  RPYAKUJO-SHAPE               PIC X(180).
                07  RPYAKUJO-COLOR               PIC X(180).
                07  RPYAKUJO-MARK                PIC X(180).
                07  RPYAKUJO-CAUTION             PIC X(2000).
                07  RPYAKUJO-YOHO                PIC X(100) OCCURS 30.
                07  RPYAKUJO-FUKUYOJITEN.
                    09  RPYAKUJO-KISHOJI         PIC X(3).
                    09  RPYAKUJO-KISHOJI-TANI    PIC X(2).
                    09  RPYAKUJO-ASA             PIC X(3).
                    09  RPYAKUJO-ASA-TANI        PIC X(2).
                    09  RPYAKUJO-HIRU            PIC X(3).
                    09  RPYAKUJO-HIRU-TANI       PIC X(2).
                    09  RPYAKUJO-YU              PIC X(3).
                    09  RPYAKUJO-YU-TANI         PIC X(2).
                    09  RPYAKUJO-SHUSHINJI       PIC X(3).
                    09  RPYAKUJO-SHUSHINJI-TANI  PIC X(2).
