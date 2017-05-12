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
        01  FMSHIJI-REC.
            03  FMSHIJI-CONTEXT                PIC S9(9)   BINARY.
            03  FMSHIJI-OBJECT                 PIC X(8).
            03  FMSHIJI-MODE                   PIC S9(9)   BINARY.
            03  FMSHIJI-RECORDNAME             PIC X(128).
            03  FMSHIJI-DATA.
              05  FMSHIJI-FORM-ID              PIC X(30).
              05  FMSHIJI-CUSTOM-ID            PIC X(30).
              05  FMSHIJI-PRINTER              PIC X(20).
      *       1:前回処方、空白：今回処方、2:頭書のみ、3:院内分
      *       4:中途終了時（院外）、5:中途終了時（院内）
      *       A:処方内容変更、B:前回処方（院外）
      *       C:前回処方（院内）、D:前回処方（選択）
              05  FMSHIJI-KBN                  PIC X(1).
      *       診療日
              05  FMSHIJI-SRYYMD               PIC X(10).
      *       診療時刻
              05  FMSHIJI-SRYTIME              PIC X(5).
      *       交付日
              05  FMSHIJI-KOFYMD               PIC X(10).
      *       診療科（日レセ）
              05  FMSHIJI-SRYKA                PIC X(2).
              05  FMSHIJI-SRYKANAME            PIC X(40).
              05  FMSHIJI-BTUNUM               PIC X(2).
              05  FMSHIJI-BTUNAME              PIC X(20).
              05  FMSHIJI-BRMNUM               PIC X(6).
      *       ページ編集(1:編集する）
              05  FMSHIJI-PAGE                 PIC X(1).
      *
              05  FMSHIJI-PTINF.
                07  FMSHIJI-PTNUM              PIC X(20).
                07  FMSHIJI-NAME               PIC X(50).
                07  FMSHIJI-KANANAME           PIC X(50).
                07  FMSHIJI-BIRTHDAY           PIC X(10).
                07  FMSHIJI-SEX                PIC X(1).
                07  FMSHIJI-TABOO              PIC X(100)  OCCURS  2.
                07  FMSHIJI-ALLERGY            PIC X(100)  OCCURS  2.
                07  FMSHIJI-KANSENSYO          PIC X(100)  OCCURS  2.
                07  FMSHIJI-COMMENT            PIC X(100)  OCCURS  2.
              05  FMSHIJI-HKNCOMBI-AREA.
                07  FMSHIJI-HKNCOMBI           PIC X(4).
                07  FMSHIJI-HKNNUM             PIC X(3).
      *             保険の種類名称
                07  FMSHIJI-HKNNAME            PIC X(20).
                07  FMSHIJI-HOKEN-AGE          PIC X(3).
                07  FMSHIJI-HOKEN-RATE         PIC X(3).
      *         負担割合区分
                07  FMSHIJI-HOKEN-RATEKBN      PIC X(1).
      *         1:高齢者一般、2:高齢者７割、3:６歳未満
                07  FMSHIJI-BIKOU-FTN          PIC X(1).
                07  FMSHIJI-HOKEN-G.
                  09  FMSHIJI-HKNJANUM         PIC X(8).
                  09  FMSHIJI-KIGO             PIC X(80).
                  09  FMSHIJI-NUM              PIC X(80).
                  09  FMSHIJI-HOJOKBN          PIC X(1).
                  09  FMSHIJI-HONKZKKBN        PIC X(1).
                  09  FMSHIJI-TEKSTYMD         PIC X(10).
                  09  FMSHIJI-TEKEDYMD         PIC X(10).
                07  FMSHIJI-KOHI-AREA          OCCURS  4.
                  09  FMSHIJI-KOH-HKNNUM        PIC X(3).
                  09  FMSHIJI-KOH-TANSEIDONAME  PIC X(20).
                  09  FMSHIJI-KOH-FTNJANUM      PIC X(8).
                  09  FMSHIJI-KOH-JKYSNUM       PIC X(20).
                  09  FMSHIJI-KOH-TEKSTYMD      PIC X(10).
                  09  FMSHIJI-KOH-TEKEDYMD      PIC X(10).
                07  FMSHIJI-ROSAI-AREA.
                  09  FMSHIJI-RSI-HKNKBN       PIC X(1).
                  09  FMSHIJI-RSI-KOFUNUM      PIC X(14).
                  09  FMSHIJI-RSI-RYOSTYMD     PIC X(10).
                  09  FMSHIJI-RSI-RYOEDYMD     PIC X(10).
                  09  FMSHIJI-RSI-SHOBYOYMD    PIC X(10).
              05  FMSHIJI-HOSP-AREA.
                07  FMSHIJI-PREFNUM             PIC X(2).
                07  FMSHIJI-HOSPCD              PIC X(7).
                07  FMSHIJI-HOSP-NAME-G.
                  09  FMSHIJI-HOSP-NAME         PIC X(120)
                                                OCCURS   3.
                07  FMSHIJI-HOSP-POST           PIC X(7).
      *         住所
                07  FMSHIJI-HOSP-ADRS-G.
                  09  FMSHIJI-HOSP-ADRS         PIC X(200)
                                                OCCURS   3.
                07  FMSHIJI-HOSP-TEL            PIC X(15).
              05  FMSHIJI-DOCTOR-AREA.
                07  FMSHIJI-DR-CODE             PIC X(5).
                07  FMSHIJI-DR-NAME             PIC X(50).
                07  FMSHIJI-DR-KANANAME         PIC X(50).
                07  FMSHIJI-DR-MAYAKULICENSE    PIC X(15).
      *
      *       1:麻薬を記載した指示せん
              05  FMSHIJI-MAYAKU               PIC X(1).
              05  FMSHIJI-ZAI-AREA              OCCURS  50 TIMES.
                07  FMSHIJI-SRYKBN              PIC X(2).
                07  FMSHIJI-ZAIKAISU            PIC X(3).
      *         日分、回分
                07  FMSHIJI-ZAITANINAME         PIC X(04).
                07  FMSHIJI-MEDICATION          OCCURS  50 TIMES.
      *           薬剤名
                  09  FMSHIJI-YKZNAME           PIC X(210).
      *           数量(ZZZZ9.99999) 一般名処方で換算値の設定がある場合換算後の数量
                  09  FMSHIJI-SURYO             PIC X(12).
                  09  FMSHIJI-SRYCD             PIC X(9).
              05  FMSHIJI-MEMO                  PIC X(110)
                                                OCCURS  3 TIMES.
              05  FMSHIJI-OPID                  PIC X(16).
