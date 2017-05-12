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
        01  FMSHOHON-REC.
            03  FMSHOHON-CONTEXT                PIC S9(9)   BINARY.
            03  FMSHOHON-OBJECT                 PIC X(8).
            03  FMSHOHON-MODE                   PIC S9(9)   BINARY.
            03  FMSHOHON-RECORDNAME             PIC X(128).
            03  FMSHOHON-DATA.
              05  FMSHOHON-FORM-ID              PIC X(30).
              05  FMSHOHON-CUSTOM-ID            PIC X(30).
              05  FMSHOHON-PRINTER              PIC X(20).
      *       1:前回処方、空白：今回処方、2:頭書のみ、3:院内分
      *       4:中途終了時（院外）、5:中途終了時（院内）
      *       A:処方内容変更、B:前回処方（院外）
      *       C:前回処方（院内）、D:前回処方（選択）
              05  FMSHOHON-KBN                  PIC X(1).
      *       診療日
              05  FMSHOHON-SRYYMD               PIC X(10).
      *       診療時刻
              05  FMSHOHON-SRYTIME              PIC X(5).
      *       交付日
              05  FMSHOHON-KOFYMD               PIC X(10).
      *       診療科（日レセ）
              05  FMSHOHON-SRYKA                PIC X(2).
              05  FMSHOHON-SRYKANAME            PIC X(40).
              05  FMSHOHON-BTUNUM               PIC X(2).
              05  FMSHOHON-BTUNAME              PIC X(20).
              05  FMSHOHON-BRMNUM               PIC X(6).
      *       ページ編集(1:編集する）
              05  FMSHOHON-PAGE                 PIC X(1).
      *
              05  FMSHOHON-PTINF.
                07  FMSHOHON-PTNUM              PIC X(20).
                07  FMSHOHON-NAME               PIC X(50).
                07  FMSHOHON-KANANAME           PIC X(50).
                07  FMSHOHON-BIRTHDAY           PIC X(10).
                07  FMSHOHON-SEX                PIC X(1).
                07  FMSHOHON-TABOO              PIC X(100)  OCCURS  2.
                07  FMSHOHON-ALLERGY            PIC X(100)  OCCURS  2.
                07  FMSHOHON-KANSENSYO          PIC X(100)  OCCURS  2.
                07  FMSHOHON-COMMENT            PIC X(100)  OCCURS  2.
              05  FMSHOHON-HKNCOMBI-AREA.
                07  FMSHOHON-HKNCOMBI           PIC X(4).
                07  FMSHOHON-HKNNUM             PIC X(3).
      *             保険の種類名称
                07  FMSHOHON-HKNNAME            PIC X(20).
                07  FMSHOHON-HOKEN-AGE          PIC X(3).
                07  FMSHOHON-HOKEN-RATE         PIC X(3).
      *         負担割合区分
                07  FMSHOHON-HOKEN-RATEKBN      PIC X(1).
      *         1:高齢者一般、2:高齢者７割、3:６歳未満
                07  FMSHOHON-BIKOU-FTN          PIC X(1).
                07  FMSHOHON-HOKEN-G.
                  09  FMSHOHON-HKNJANUM         PIC X(8).
                  09  FMSHOHON-KIGO             PIC X(80).
                  09  FMSHOHON-NUM              PIC X(80).
                  09  FMSHOHON-HOJOKBN          PIC X(1).
                  09  FMSHOHON-HONKZKKBN        PIC X(1).
                  09  FMSHOHON-TEKSTYMD         PIC X(10).
                  09  FMSHOHON-TEKEDYMD         PIC X(10).
                07  FMSHOHON-KOHI-AREA          OCCURS  4.
                  09  FMSHOHON-KOH-HKNNUM        PIC X(3).
                  09  FMSHOHON-KOH-TANSEIDONAME  PIC X(20).
                  09  FMSHOHON-KOH-FTNJANUM      PIC X(8).
                  09  FMSHOHON-KOH-JKYSNUM       PIC X(20).
                  09  FMSHOHON-KOH-TEKSTYMD      PIC X(10).
                  09  FMSHOHON-KOH-TEKEDYMD      PIC X(10).
                07  FMSHOHON-ROSAI-AREA.
                  09  FMSHOHON-RSI-HKNKBN       PIC X(1).
                  09  FMSHOHON-RSI-KOFUNUM      PIC X(14).
                  09  FMSHOHON-RSI-RYOSTYMD     PIC X(10).
                  09  FMSHOHON-RSI-RYOEDYMD     PIC X(10).
                  09  FMSHOHON-RSI-SHOBYOYMD    PIC X(10).
              05  FMSHOHON-HOSP-AREA.
                07  FMSHOHON-PREFNUM             PIC X(2).
                07  FMSHOHON-HOSPCD              PIC X(7).
                07  FMSHOHON-HOSP-NAME-G.
                  09  FMSHOHON-HOSP-NAME         PIC X(120)
                                                OCCURS   3.
                07  FMSHOHON-HOSP-POST           PIC X(7).
      *         住所
                07  FMSHOHON-HOSP-ADRS-G.
                  09  FMSHOHON-HOSP-ADRS         PIC X(200)
                                                OCCURS   3.
                07  FMSHOHON-HOSP-TEL            PIC X(15).
              05  FMSHOHON-DOCTOR-AREA.
                07  FMSHOHON-DR-CODE             PIC X(5).
                07  FMSHOHON-DR-NAME             PIC X(50).
                07  FMSHOHON-DR-KANANAME         PIC X(50).
                07  FMSHOHON-DR-MAYAKULICENSE    PIC X(15).
      *
      *       1:麻薬を記載した指示せん
              05  FMSHOHON-MAYAKU                PIC X(1).
      *       1:臨時
              05  FMSHOHON-RINJI                 PIC X(1).
              05  FMSHOHON-ZAI-AREA              OCCURS  50 TIMES.
                07  FMSHOHON-SRYKBN              PIC X(2).
                07  FMSHOHON-ZAIKAISU            PIC X(3).
      *         日分、回分
                07  FMSHOHON-ZAITANINAME         PIC X(04).
                07  FMSHOHON-MEDICATION          OCCURS  50 TIMES.
      *           薬剤名
                  09  FMSHOHON-YKZNAME           PIC X(210).
      *           数量(ZZZZ9.99999) 一般名処方で換算値の設定がある場合換算後の数量
                  09  FMSHOHON-SURYO             PIC X(12).
                  09  FMSHOHON-SRYCD             PIC X(9).
              05  FMSHOHON-MEMO                  PIC X(110)
                                                OCCURS  3 TIMES.
              05  FMSHOHON-OPID                  PIC X(16).
