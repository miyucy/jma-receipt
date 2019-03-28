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
      *       開始診療日
              05  RPMEISAI-STSRYYMD          PIC X(10).
      *       終了診療日
              05  RPMEISAI-EDSRYYMD          PIC X(10).
      *       伝票発行日
              05  RPMEISAI-DENPPRTYMD        PIC X(10).
      *
      *       診療科
              05  RPMEISAI-SRYKANAME         PIC X(30).
      *       保険情報
              05  RPMEISAI-HOKENNAME         PIC X(40).
              05  RPMEISAI-FUTAN-G.
      *         負担割合
                07  RPMEISAI-FUTAN         PIC X(04).
      *         負担割合
                07  RPMEISAI-FUTANMEI      PIC X(02).
      *       伝票番号（一括以外）
              05  RPMEISAI-DENPNUM           PIC X(07).
      *
      *       明細情報
              05   RPMEISAI-SRY-ITEM-AREA  OCCURS   2000.
      *         グループヘッダ（１：伝票番号が変わる度の先頭）
                07   RPMEISAI-GRPHEAD        PIC X(01).
      *         連番（伝票番号が変わる度に増加）（999：伝票情報行）
                07   RPMEISAI-GRPNUM         PIC X(03).
      *         診療区分名
                07   RPMEISAI-SRYKBN         PIC X(10).
      *         名称
                07  RPMEISAI-SRYNAME-G.
      *           剤開始（＊など
                  09  RPMEISAI-ZAIHEN        PIC X(02).
      *           診療内容名称
                  09  RPMEISAI-SRYNAME       PIC X(148).
      *         点数記載円立てフラグ
                07   RPMEISAI-TENSU-MARK     PIC X(1).
      *         点数
                07   RPMEISAI-TENSU          PIC X(09).
      *         回数
                07   RPMEISAI-KAISU          PIC X(03).
      *         合計
                07   RPMEISAI-TOTAL          PIC X(11).
      *         剤終了（１：剤最終行）
                07  RPMEISAI-ZAIEND          PIC X(01).
      *
      *       明細情報金額編集フラグ
              05  RPMEISAI-YEN-FLG           PIC X(1).
      *
      *       注意書き
              05  RPMEISAI-CAUTION           PIC X(100).
