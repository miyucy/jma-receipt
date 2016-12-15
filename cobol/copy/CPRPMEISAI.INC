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
        01  RPMEISAI-REC.
            03  RPMEISAI-CONTEXT               PIC S9(9)   BINARY.
            03  RPMEISAI-OBJECT                PIC X(8).
            03  RPMEISAI-MODE                  PIC S9(9)   BINARY.
            03  RPMEISAI-RECORDNAME            PIC X(128).
            03  RPMEISAI-DATA.
              05  RPMEISAI-REPORT-ID           PIC X(30).
              05  RPMEISAI-CUSTOM-ID           PIC X(30).
              05  RPMEISAI-PRINTER             PIC X(20).
      *
      *       患者番号
              05  RPMEISAI-PTNUM             PIC X(20).
      *       患者カナ氏名
              05  RPMEISAI-KANANAME          PIC X(50).
      *       患者氏名
              05  RPMEISAI-NAME              PIC X(50).
      *
      *       医療機関情報
              05  RPMEISAI-HOSP-AREA.
      *         医療機関名称
                07  RPMEISAI-HOSP-NAME-G.
                  09  RPMEISAI-HOSP-NAME       PIC X(120)
                                               OCCURS   3.
      *         医療機関郵便番号
                07  RPMEISAI-HOSP-POST         PIC X(7).
      *         医療機関住所
                07  RPMEISAI-HOSP-ADRS-G.
                  09  RPMEISAI-HOSP-ADRS       PIC X(200)
                                               OCCURS   3.
      *         医療機関電話番号
                07  RPMEISAI-HOSP-TEL          PIC X(15).
      *
              05  RPMEISAI-OCC                 OCCURS 100.
      *
      *         開始診療日
                07  RPMEISAI-STSRYYMD          PIC X(10).
      *         終了診療日
                07  RPMEISAI-EDSRYYMD          PIC X(10).
      *         診療科
                07  RPMEISAI-SRYKANAME         PIC X(100).
      *         保険情報
                07  RPMEISAI-HOKENNAME         PIC X(20).
      *         伝票発行日
                07  RPMEISAI-DENPPRTYMD        PIC X(10).
      *         伝票番号
                07  RPMEISAI-DENPNUM           PIC X(07).
      *
      *         明細情報
                07  RPMEISAI-SRY-ITEM-AREA     OCCURS   500.
      *           連番（剤が変わる度に増加）
                  09   RPMEISAI-GRPNUM         PIC X(03).
      *           診療区分名
                  09   RPMEISAI-SRYKBN         PIC X(10).
      *           診療内容名称
                  09   RPMEISAI-SRYNAME        PIC X(76).
      *           点数記載円立てフラグ
                  09   RPMEISAI-TENSU-MARK     PIC X(1).
      *           点数
                  09   RPMEISAI-TENSU          PIC X(10).
      *           回数
                  09   RPMEISAI-KAISU          PIC X(03).
      *           合計
                  09   RPMEISAI-TOTAL          PIC X(10).
      *
      *       明細情報金額編集フラグ
              05  RPMEISAI-YEN-FLG             PIC X(1).
      *
      *       注意書き
              05  RPMEISAI-CAUTION             PIC X(100)
