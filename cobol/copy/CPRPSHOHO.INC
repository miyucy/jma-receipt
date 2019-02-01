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
        01  RPSHOHO-REC.
            03  RPSHOHO-CONTEXT                PIC S9(9)   BINARY.
            03  RPSHOHO-OBJECT                 PIC X(8).
            03  RPSHOHO-MODE                   PIC S9(9)   BINARY.
            03  RPSHOHO-RECORDNAME             PIC X(128).
            03  RPSHOHO-DATA.
              05  RPSHOHO-REPORT-ID            PIC X(30).
              05  RPSHOHO-CUSTOM-ID            PIC X(30).
              05  RPSHOHO-PRINTER              PIC X(20).
      *       1:前回処方、空白：今回処方、2:頭書のみ、3:院内分
      *       4:中途終了時（院外）、5:中途終了時（院内）
      *       A:処方内容変更、B:前回処方（院外）
      *       C:前回処方（院内）、D:前回処方（選択）
              05  RPSHOHO-KBN                  PIC X(1).
      *       診療日
              05  RPSHOHO-SRYYMD               PIC X(10).
      *       交付日
              05  RPSHOHO-KOFYMD               PIC X(10).
      *       診療科（日レセ）
              05  RPSHOHO-SRYKA                PIC X(2).
              05  RPSHOHO-SRYKANAME            PIC X(40).
      *       ページ編集(1:編集する）
              05  RPSHOHO-PAGE                 PIC X(1).
      *
              05  RPSHOHO-PTINF.
                07  RPSHOHO-PTNUM              PIC X(20).
                07  RPSHOHO-NAME               PIC X(50).
                07  RPSHOHO-KANANAME           PIC X(50).
                07  RPSHOHO-BIRTHDAY           PIC X(10).
                07  RPSHOHO-SEX                PIC X(1).
                07  RPSHOHO-TABOO              PIC X(100)  OCCURS  2.
                07  RPSHOHO-ALLERGY            PIC X(100)  OCCURS  2.
                07  RPSHOHO-KANSENSYO          PIC X(100)  OCCURS  2.
                07  RPSHOHO-COMMENT            PIC X(100)  OCCURS  2.
              05  RPSHOHO-HKNCOMBI-AREA.
                07  RPSHOHO-HKNCOMBI           PIC X(4).
                07  RPSHOHO-HKNNUM             PIC X(3).
      *             保険の種類名称
                07  RPSHOHO-HKNNAME            PIC X(20).
                07  RPSHOHO-HOKEN-AGE          PIC X(3).
                07  RPSHOHO-HOKEN-RATE         PIC X(3).
      *         負担割合区分
                07  RPSHOHO-HOKEN-RATEKBN      PIC X(1).
      *         1:高齢者一般、2:高齢者７割、3:６歳未満
                07  RPSHOHO-BIKOU-FTN          PIC X(1).
                07  RPSHOHO-HOKEN-G.
                  09  RPSHOHO-HKNJANUM         PIC X(8).
                  09  RPSHOHO-KIGO             PIC X(80).
                  09  RPSHOHO-NUM              PIC X(80).
                  09  RPSHOHO-HOJOKBN          PIC X(1).
                  09  RPSHOHO-HONKZKKBN        PIC X(1).
                  09  RPSHOHO-TEKSTYMD         PIC X(10).
                  09  RPSHOHO-TEKEDYMD         PIC X(10).
                07  RPSHOHO-ROSAI-AREA.
                  09  RPSHOHO-RSI-HKNKBN       PIC X(1).
                  09  RPSHOHO-RSI-KOFUNUM      PIC X(14).
                  09  RPSHOHO-RSI-RYOSTYMD     PIC X(10).
                  09  RPSHOHO-RSI-RYOEDYMD     PIC X(10).
                  09  RPSHOHO-RSI-SHOBYOYMD    PIC X(10).
                07  RPSHOHO-KOHI-AREA          OCCURS  4.
                  09  RPSHOHO-KOH-HKNNUM        PIC X(3).
                  09  RPSHOHO-KOH-TANSEIDONAME  PIC X(20).
                  09  RPSHOHO-KOH-FTNJANUM      PIC X(8).
                  09  RPSHOHO-KOH-JKYSNUM       PIC X(20).
                  09  RPSHOHO-KOH-TEKSTYMD      PIC X(10).
                  09  RPSHOHO-KOH-TEKEDYMD      PIC X(10).
              05  RPSHOHO-HOSP-AREA.
                07  RPSHOHO-PREFNUM             PIC X(2).
                07  RPSHOHO-HOSPCD              PIC X(7).
                07  RPSHOHO-HOSP-NAME-G.
                  09  RPSHOHO-HOSP-NAME         PIC X(120)
                                                OCCURS   3.
                07  RPSHOHO-HOSP-POST           PIC X(7).
      *         住所
                07  RPSHOHO-HOSP-ADRS-G.
                  09  RPSHOHO-HOSP-ADRS         PIC X(200)
                                                OCCURS   3.
                07  RPSHOHO-HOSP-TEL            PIC X(15).
              05  RPSHOHO-DOCTOR-AREA.
                07  RPSHOHO-DR-CODE             PIC X(5).
                07  RPSHOHO-DR-NAME             PIC X(50).
                07  RPSHOHO-DR-KANANAME         PIC X(50).
                07  RPSHOHO-DR-MAYAKULICENSE    PIC X(15).
      *
      *       1:保険医療機関へ疑義照会した上で調剤
      *       2:保険医療機関へ情報提供
              05  RPSHOHO-ZANSIJI              PIC X(1).
      *       1:麻薬を記載した処方せん
              05  RPSHOHO-MAYAKU               PIC X(1).
      *       1:変更不可保険医名の記載が必要
              05  RPSHOHO-KOUHATUFUKA-IN       PIC X(1).
              05  RPSHOHO-ZAI-AREA              OCCURS  50 TIMES.
                07  RPSHOHO-SRYKBN              PIC X(2).
                07  RPSHOHO-ZAIKAISU            PIC X(3).
      *         日分、回分
                07  RPSHOHO-ZAITANINAME         PIC X(04).
                07  RPSHOHO-MEDICATION          OCCURS  50 TIMES.
      *           薬剤名
                  09  RPSHOHO-YKZNAME           PIC X(210).
      *           数量(ZZZZ9.99999) 一般名処方で換算値の設定がある場合換算後の数量
                  09  RPSHOHO-SURYO             PIC X(12).
      *           一般名処方で換算値の設定がある場合換算後の単位
                  09  RPSHOHO-TANINAME          PIC X(12).
                  09  RPSHOHO-SRYCD             PIC X(9).
      *           1:一般名記載
                  09  RPSHOHO-KISAIKBN          PIC X(1).
                  09  RPSHOHO-YAKKAKJNCD        PIC X(13).
      *           1:変更不可
                  09  RPSHOHO-FUKA              PIC X(1).
              05  RPSHOHO-MEMO2   PIC X(40)     OCCURS  4  TIMES.
              05  RPSHOHO-MEMO    PIC X(100)    OCCURS  50 TIMES.
