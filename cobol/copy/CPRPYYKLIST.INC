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
        01  RPYYKLIST-REC.
            03  RPYL-CONTEXT                   PIC S9(9)   BINARY.
            03  RPYL-OBJECT                    PIC X(8).
            03  RPYL-MODE                      PIC S9(9)   BINARY.
            03  RPYL-RECORDNAME                PIC X(128).
            03  RPYL-DATA.
      *       yoyaku_list
              05  RPYL-REPORT-ID               PIC X(30).
              05  RPYL-CUSTOM-ID               PIC X(30).
              05  RPYL-PRINTER                 PIC X(20).
              05  RPYL-PRTYMD                  PIC X(10).
              05  RPYL-SRYYMD                  PIC X(10).
      *       処理区分（１：予約一覧、２：未院一覧）
              05  RPYL-HAKKOKBN                PIC X(01).
              05  RPYL-SRYNAIYO-AREA.
                07  RPYL-SRYNAIYO              PIC X(02).
                07  RPYL-SRYNAIYONAME          PIC X(20).
              05  RPYL-DOCTOR-AREA.
                07  RPYL-DR-CODE               PIC X(5).
                07  RPYL-DR-NAME               PIC X(50).
                07  RPYL-DR-KANANAME           PIC X(50).
              05  RPYL-TBL                     OCCURS 1000.
                07  RPYL-TYYKTIME              PIC X(5).
                07  RPYL-TSRYKA                PIC X(2).
                07  RPYL-TSRYKANAME            PIC X(40).
                07  RPYL-TSRYNAIYO-AREA.
                  09  RPYL-TSRYNAIYO           PIC X(02).
                  09  RPYL-TSRYNAIYONAME       PIC X(20).
                07  RPYL-TDOCTOR-AREA.
                  09  RPYL-TDR-CODE            PIC X(5).
                  09  RPYL-TDR-NAME            PIC X(50).
                  09  RPYL-TDR-KANANAME        PIC X(50).
                07  RPYL-TPTINF.
                  09  RPYL-TPTNUM              PIC X(20).
      *           予約患者氏名
                  09  RPYL-TYYKNAME            PIC X(50).
      *           患者情報
                  09  RPYL-TNAME               PIC X(50).
                  09  RPYL-TKANANAME           PIC X(50).
                  09  RPYL-TBIRTHDAY           PIC X(10).
                  09  RPYL-TSEX                PIC X(1).
                07  RPYL-TYYKKBN               PIC X(02).
                07  RPYL-TYYKKBNNAME           PIC X(30).
                07  RPYL-TKAKREN               PIC X(02).
                07  RPYL-TKAKRENNAME           PIC X(20).
                07  RPYL-TRAIINZUMI            PIC X(1).
