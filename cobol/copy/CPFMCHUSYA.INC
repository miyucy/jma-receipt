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
        01  FMCHUSYA-REC.
            03  FMCHUSYA-CONTEXT                PIC S9(9)   BINARY.
            03  FMCHUSYA-OBJECT                 PIC X(8).
            03  FMCHUSYA-MODE                   PIC S9(9)   BINARY.
            03  FMCHUSYA-RECORDNAME             PIC X(128).
            03  FMCHUSYA-DATA.
              05  FMCHUSYA-FORM-ID              PIC X(30).
              05  FMCHUSYA-CUSTOM-ID            PIC X(30).
              05  FMCHUSYA-PRINTER              PIC X(20).
      *       1:前回処方、空白：今回処方、2:頭書のみ、3:院内分
      *       4:中途終了時（院外）、5:中途終了時（院内）
      *       A:処方内容変更、B:前回処方（院外）
      *       C:前回処方（院内）、D:前回処方（選択）
              05  FMCHUSYA-KBN                  PIC X(1).
      *       診療日
              05  FMCHUSYA-SRYYMD               PIC X(10).
      *       診療時刻
              05  FMCHUSYA-SRYTIME              PIC X(5).
      *       交付日
              05  FMCHUSYA-KOFYMD               PIC X(10).
      *       診療科（日レセ）
              05  FMCHUSYA-SRYKA                PIC X(2).
              05  FMCHUSYA-SRYKANAME            PIC X(40).
              05  FMCHUSYA-BTUNUM               PIC X(2).
              05  FMCHUSYA-BTUNAME              PIC X(20).
              05  FMCHUSYA-BRMNUM               PIC X(6).
      *       ページ編集(1:編集する）
              05  FMCHUSYA-PAGE                 PIC X(1).
      *
              05  FMCHUSYA-PTINF.
                07  FMCHUSYA-PTNUM              PIC X(20).
                07  FMCHUSYA-NAME               PIC X(50).
                07  FMCHUSYA-KANANAME           PIC X(50).
                07  FMCHUSYA-BIRTHDAY           PIC X(10).
                07  FMCHUSYA-SEX                PIC X(1).
                07  FMCHUSYA-TABOO              PIC X(100)  OCCURS  2.
                07  FMCHUSYA-ALLERGY            PIC X(100)  OCCURS  2.
                07  FMCHUSYA-KANSENSYO          PIC X(100)  OCCURS  2.
                07  FMCHUSYA-COMMENT            PIC X(100)  OCCURS  2.
              05  FMCHUSYA-HKNCOMBI-AREA.
                07  FMCHUSYA-HKNCOMBI           PIC X(4).
                07  FMCHUSYA-HKNNUM             PIC X(3).
      *             保険の種類名称
                07  FMCHUSYA-HKNNAME            PIC X(20).
                07  FMCHUSYA-HOKEN-AGE          PIC X(3).
                07  FMCHUSYA-HOKEN-RATE         PIC X(3).
      *         負担割合区分
                07  FMCHUSYA-HOKEN-RATEKBN      PIC X(1).
      *         1:高齢者一般、2:高齢者７割、3:６歳未満
                07  FMCHUSYA-BIKOU-FTN          PIC X(1).
                07  FMCHUSYA-HOKEN-G.
                  09  FMCHUSYA-HKNJANUM         PIC X(8).
                  09  FMCHUSYA-KIGO             PIC X(80).
                  09  FMCHUSYA-NUM              PIC X(80).
                  09  FMCHUSYA-HOJOKBN          PIC X(1).
                  09  FMCHUSYA-HONKZKKBN        PIC X(1).
                  09  FMCHUSYA-TEKSTYMD         PIC X(10).
                  09  FMCHUSYA-TEKEDYMD         PIC X(10).
                07  FMCHUSYA-KOHI-AREA          OCCURS  4.
                  09  FMCHUSYA-KOH-HKNNUM        PIC X(3).
                  09  FMCHUSYA-KOH-TANSEIDONAME  PIC X(20).
                  09  FMCHUSYA-KOH-FTNJANUM      PIC X(8).
                  09  FMCHUSYA-KOH-JKYSNUM       PIC X(20).
                  09  FMCHUSYA-KOH-TEKSTYMD      PIC X(10).
                  09  FMCHUSYA-KOH-TEKEDYMD      PIC X(10).
                07  FMCHUSYA-ROSAI-AREA.
                  09  FMCHUSYA-RSI-HKNKBN       PIC X(1).
                  09  FMCHUSYA-RSI-KOFUNUM      PIC X(14).
                  09  FMCHUSYA-RSI-RYOSTYMD     PIC X(10).
                  09  FMCHUSYA-RSI-RYOEDYMD     PIC X(10).
                  09  FMCHUSYA-RSI-SHOBYOYMD    PIC X(10).
              05  FMCHUSYA-HOSP-AREA.
                07  FMCHUSYA-PREFNUM             PIC X(2).
                07  FMCHUSYA-HOSPCD              PIC X(7).
                07  FMCHUSYA-HOSP-NAME-G.
                  09  FMCHUSYA-HOSP-NAME         PIC X(120)
                                                OCCURS   3.
                07  FMCHUSYA-HOSP-POST           PIC X(7).
      *         住所
                07  FMCHUSYA-HOSP-ADRS-G.
                  09  FMCHUSYA-HOSP-ADRS         PIC X(200)
                                                OCCURS   3.
                07  FMCHUSYA-HOSP-TEL            PIC X(15).
              05  FMCHUSYA-DOCTOR-AREA.
                07  FMCHUSYA-DR-CODE             PIC X(5).
                07  FMCHUSYA-DR-NAME             PIC X(50).
                07  FMCHUSYA-DR-KANANAME         PIC X(50).
                07  FMCHUSYA-DR-MAYAKULICENSE    PIC X(15).
      *
      *       1:麻薬を記載した注射せん
              05  FMCHUSYA-MAYAKU                PIC X(1).
      *       回数
              05  FMCHUSYA-KAISU                 PIC X(2).
      *       注射名
              05  FMCHUSYA-CHUSYAMEI             PIC X(100).
              05  FMCHUSYA-ZAI-AREA              OCCURS  50 TIMES.
                07  FMCHUSYA-SRYKBN              PIC X(2).
                07  FMCHUSYA-ZAIKAISU            PIC X(3).
      *         日分、回分
                07  FMCHUSYA-ZAITANINAME         PIC X(04).
                07  FMCHUSYA-MEDICATION          OCCURS  50 TIMES.
      *           薬剤名
                  09  FMCHUSYA-YKZNAME           PIC X(210).
      *           数量(ZZZZ9.99999) 一般名処方で換算値の設定がある場合換算後の数量
                  09  FMCHUSYA-SURYO             PIC X(12).
                  09  FMCHUSYA-SRYCD             PIC X(9).
              05  FMCHUSYA-MEMO                  PIC X(110)
                                                OCCURS  3 TIMES.
              05  FMCHUSYA-OPID                  PIC X(16).
