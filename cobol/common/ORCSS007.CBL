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
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCSS007.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 共通
      *  コンポーネント名  : 入院基本料点数チェック
      *  管理者            : 
      *  作成日付    作業者        記述
      *  07/08/21    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  04.07.00    NACL-小豆沢  12/07/20  生活療養の入院料判定追加
      *****************************************************************
      *
      *
       ENVIRONMENT                     DIVISION.
       CONFIGURATION                   SECTION.
       INPUT-OUTPUT                    SECTION.
       FILE-CONTROL.
      *
      *
       DATA                            DIVISION.
       FILE                            SECTION.
      *
      *
       WORKING-STORAGE                 SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-SYSKANRI                    PIC 9(01).
           03  FLG-PTINF                       PIC 9(01).
           03  FLG-PTNYUINRRK                  PIC 9(01).
           03  FLG-NYUINACCT                   PIC 9(01).
           03  FLG-NYUINACT                    PIC 9(01).
           03  FLG-TENSU                       PIC 9(01).
           03  FLG-UNMATCH                     PIC 9(01).
           03  FLG-RYOYO-CHK                   PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                             PIC 9(05).
           03  IDX0                            PIC 9(05).
           03  IDX1                            PIC 9(05).
           03  IDX-NSRY                        PIC 9(05).
           03  IDX-ST                          PIC 9(05).
           03  IDX-ED                          PIC 9(05).
           03  IDX-SEI                         PIC 9(05).
           03  IDX-KSN                         PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-ZAITEN                      PIC 9(05).
           03  WRK-SRYYMD                      PIC X(08).
           03  WRK-SRYCD                       PIC X(09).
           03  WRK-HYOKETU-TEN                 PIC 9(05).
      *    月末日算定領域
           03  WRK-MATSUYMD.
               05  WRK-MATSUYY                 PIC X(04).
               05  WRK-MATSUMM                 PIC X(02).
               05  WRK-MATSUDD                 PIC X(02).
      *
           03  WRK-RYOYO-TABLE.
               05  WRK-RYOYO-TBL               PIC X(01)  OCCURS 31.
           03  WRK-HKNCOMBI-TABLE.
               05  WRK-HKNCOMBI-TBL            PIC X(04)  OCCURS 31.
           03  WRK-HKNCOMBI-TBL9               PIC 9(04).
           03  WRK-HKNCOMBI-TBLX               REDEFINES
                                               WRK-HKNCOMBI-TBL9
                                               PIC X(04).
           03  WRK-RSI-TABLE.
               05  WRK-RSI-TBL                 PIC X(01)  OCCURS 31.
      *
      *    生活療養判定用
       01  TBL-H24-SEIKATSU-AREA.
      *    回復期リハビリテーション病棟入院料１
           03   FILLER                     PIC X(09) VALUE "190150110".
      *    回復期リハビリテーション病棟入院料１（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190719510".
      *    回復期リハビリテーション病棟入院料２
           03   FILLER                     PIC X(09) VALUE "190141610".
      *    回復期リハビリテーション病棟入院料２（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190719710".
      *    回復期リハビリテーション病棟入院料３
           03   FILLER                     PIC X(09) VALUE "190141810".
      *    回復期リハビリテーション病棟入院料３（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190719910".
      *    短期滞在手術基本料２
           03   FILLER                     PIC X(09) VALUE "190076810".
      *    短期滞在手術基本料３
           03   FILLER                     PIC X(09) VALUE "190130410".
      *    有床診療所療養病床入院基本料Ａ
           03   FILLER                     PIC X(09) VALUE "190122010".
      *10  有床診療所療養病床入院基本料Ａ（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190711410".
      *    有床診療所療養病床入院基本料Ｂ
           03   FILLER                     PIC X(09) VALUE "190122110".
      *    有床診療所療養病床入院基本料Ｂ（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190711610".
      *    有床診療所療養病床入院基本料Ｃ
           03   FILLER                     PIC X(09) VALUE "190122210".
      *    有床診療所療養病床入院基本料Ｃ（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190711810".
      *    有床診療所療養病床入院基本料Ｄ
           03   FILLER                     PIC X(09) VALUE "190122310".
      *    有床診療所療養病床入院基本料Ｄ（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190712010".
      *    有床診療所療養病床入院基本料Ｅ
           03   FILLER                     PIC X(09) VALUE "190122410".
      *    有床診療所療養病床入院基本料Ｅ（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190712210".
      *    療養病床以外・有床診療所療養病床入院Ａ
           03   FILLER                     PIC X(09) VALUE "190155210".
      *20  療養病床以外・有床診療所療養病床入院Ａ（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190155310".
      *    療養病床以外・有床診療所療養病床入院Ｂ
           03   FILLER                     PIC X(09) VALUE "190155610".
      *    療養病床以外・有床診療所療養病床入院Ｂ（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190155710".
      *    療養病床以外・有床診療所療養病床入院Ｃ
           03   FILLER                     PIC X(09) VALUE "190156010".
      *    療養病床以外・有床診療所療養病床入院Ｃ（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190156110".
      *    療養病床以外・有床診療所療養病床入院Ｄ
           03   FILLER                     PIC X(09) VALUE "190156410".
      *    療養病床以外・有床診療所療養病床入院Ｄ（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190156510".
      *    療養病床以外・有床診療所療養病床入院Ｅ
           03   FILLER                     PIC X(09) VALUE "190156810".
      *    療養病床以外・有床診療所療養病床入院Ｅ（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190156910".
      *    療養病棟入院基本料１（入院基本料Ａ）
           03   FILLER                     PIC X(09) VALUE "190121310".
      *30  療養病棟入院基本料１（入院基本料Ａ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190700910".
      *    療養病棟入院基本料１（入院基本料Ｂ）
           03   FILLER                     PIC X(09) VALUE "190121410".
      *    療養病棟入院基本料１（入院基本料Ｂ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190701110".
      *    療養病棟入院基本料１（入院基本料Ｃ）
           03   FILLER                     PIC X(09) VALUE "190121510".
      *    療養病棟入院基本料１（入院基本料Ｃ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190701310".
      *    療養病棟入院基本料１（入院基本料Ｄ）
           03   FILLER                     PIC X(09) VALUE "190121610".
      *    療養病棟入院基本料１（入院基本料Ｄ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190701510".
      *    療養病棟入院基本料１（入院基本料Ｅ）
           03   FILLER                     PIC X(09) VALUE "190121710".
      *    療養病棟入院基本料１（入院基本料Ｅ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190701710".
      *    療養病棟入院基本料１（入院基本料Ｆ）
           03   FILLER                     PIC X(09) VALUE "190131610".
      *40  療養病棟入院基本料１（入院基本料Ｆ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190701910".
      *    療養病棟入院基本料１（入院基本料Ｇ）
           03   FILLER                     PIC X(09) VALUE "190131810".
      *    療養病棟入院基本料１（入院基本料Ｇ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190702110".
      *    療養病棟入院基本料１（入院基本料Ｈ）
           03   FILLER                     PIC X(09) VALUE "190132010".
      *    療養病棟入院基本料１（入院基本料Ｈ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190702310".
      *    療養病棟入院基本料１（入院基本料Ｉ）
           03   FILLER                     PIC X(09) VALUE "190132210".
      *    療養病棟入院基本料１（入院基本料Ｉ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190702510".
      *    療養病棟入院基本料２（入院基本料Ａ）
           03   FILLER                     PIC X(09) VALUE "190132410".
      *    療養病棟入院基本料２（入院基本料Ａ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190702710".
      *    療養病棟入院基本料２（入院基本料Ｂ）
           03   FILLER                     PIC X(09) VALUE "190132610".
      *50  療養病棟入院基本料２（入院基本料Ｂ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190702910".
      *    療養病棟入院基本料２（入院基本料Ｃ）
           03   FILLER                     PIC X(09) VALUE "190132810".
      *    療養病棟入院基本料２（入院基本料Ｃ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190703110".
      *    療養病棟入院基本料２（入院基本料Ｄ）
           03   FILLER                     PIC X(09) VALUE "190133010".
      *    療養病棟入院基本料２（入院基本料Ｄ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190703310".
      *    療養病棟入院基本料２（入院基本料Ｅ）
           03   FILLER                     PIC X(09) VALUE "190133210".
      *    療養病棟入院基本料２（入院基本料Ｅ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190703510".
      *    療養病棟入院基本料２（入院基本料Ｆ）
           03   FILLER                     PIC X(09) VALUE "190133410".
      *    療養病棟入院基本料２（入院基本料Ｆ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190703710".
      *    療養病棟入院基本料２（入院基本料Ｆ）
           03   FILLER                     PIC X(09) VALUE "190133610".
      *60  療養病棟入院基本料２（入院基本料Ｇ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190703910".
      *    療養病棟入院基本料２（入院基本料Ｈ）
           03   FILLER                     PIC X(09) VALUE "190133810".
      *    療養病棟入院基本料２（入院基本料Ｈ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190704110".
      *    療養病棟入院基本料２（入院基本料Ｉ）
           03   FILLER                     PIC X(09) VALUE "190134010".
      *    療養病棟入院基本料２（入院基本料Ｉ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190704310".
      *    特定一般病棟・療養病棟入院基本料１（Ａ）
           03   FILLER                     PIC X(09) VALUE "190157210".
      *    特定一般病棟・療養病棟入院基本料１（Ａ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190157310".
      *    特定一般病棟・療養病棟入院基本料１（Ｂ）
           03   FILLER                     PIC X(09) VALUE "190157610".
      *    特定一般病棟・療養病棟入院基本料１（Ｂ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190157710".
      *    特定一般病棟・療養病棟入院基本料１（Ｃ）
           03   FILLER                     PIC X(09) VALUE "190158010".
      *70  特定一般病棟・療養病棟入院基本料１（Ｃ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190158110".
      *    特定一般病棟・療養病棟入院基本料１（Ｄ）
           03   FILLER                     PIC X(09) VALUE "190158410".
      *    特定一般病棟・療養病棟入院基本料１（Ｄ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190158510".
      *    特定一般病棟・療養病棟入院基本料１（Ｅ）
           03   FILLER                     PIC X(09) VALUE "190158810".
      *    特定一般病棟・療養病棟入院基本料１（Ｅ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190158910".
      *    特定一般病棟・療養病棟入院基本料１（Ｆ）
           03   FILLER                     PIC X(09) VALUE "190159210".
      *    特定一般病棟・療養病棟入院基本料１（Ｆ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190159310".
      *    特定一般病棟・療養病棟入院基本料１（Ｇ）
           03   FILLER                     PIC X(09) VALUE "190159610".
      *    特定一般病棟・療養病棟入院基本料１（Ｇ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190159710".
      *    特定一般病棟・療養病棟入院基本料１（Ｈ）
           03   FILLER                     PIC X(09) VALUE "190160010".
      *80  特定一般病棟・療養病棟入院基本料１（Ｈ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190160110".
      *    特定一般病棟・療養病棟入院基本料１（Ｉ）
           03   FILLER                     PIC X(09) VALUE "190160410".
      *    特定一般病棟・療養病棟入院基本料１（Ｉ）（栄管経過措置）
           03   FILLER                     PIC X(09) VALUE "190160510".
      *
      *    有床診療所療養病床入院基本料（特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190122510".
      *    療養病棟入院基本料（特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190121810".
      *
       01  TBL-H24-SEIKATSU-R     REDEFINES  TBL-H24-SEIKATSU-AREA.
           03   TBL-H24-SEISRYCD           PIC X(09)  OCCURS  84.
      *
      *
      *    生活療養判定用（平成２６年追加分）
       01  TBL-H26-SEIKATSU-AREA.
      *    地域包括ケア病棟入院料１
           03   FILLER                     PIC X(09) VALUE "190175310".
      *    地域包括ケア病棟入院料１（特定地域）
           03   FILLER                     PIC X(09) VALUE "190176110".
      *    地域包括ケア病棟入院料２
           03   FILLER                     PIC X(09) VALUE "190175710".
      *    地域包括ケア病棟入院料２（特定地域）
           03   FILLER                     PIC X(09) VALUE "190176510".
      *    地域包括ケア入院医療管理料１
           03   FILLER                     PIC X(09) VALUE "190175510".
      *    地域包括ケア入院医療管理料１（特定地域）
           03   FILLER                     PIC X(09) VALUE "190176310".
      *    地域包括ケア入院医療管理料２
           03   FILLER                     PIC X(09) VALUE "190175910".
      *    地域包括ケア入院医療管理料２（特定地域）
           03   FILLER                     PIC X(09) VALUE "190176710".
      *    療養病棟入院基本料２（入院基本料Ａ）（夜勤時間超過減算）
           03   FILLER                     PIC X(09) VALUE "190166110".
      *    療養病棟入院基本料２（入院基本料Ｂ）（夜勤時間超過減算）
           03   FILLER                     PIC X(09) VALUE "190166310".
      *    療養病棟入院基本料２（入院基本料Ｃ）（夜勤時間超過減算）
           03   FILLER                     PIC X(09) VALUE "190166510".
      *    療養病棟入院基本料２（入院基本料Ｄ）（夜勤時間超過減算）
           03   FILLER                     PIC X(09) VALUE "190166710".
      *    療養病棟入院基本料２（入院基本料Ｅ）（夜勤時間超過減算）
           03   FILLER                     PIC X(09) VALUE "190166910".
      *    療養病棟入院基本料２（入院基本料Ｆ）（夜勤時間超過減算）
           03   FILLER                     PIC X(09) VALUE "190167110".
      *    療養病棟入院基本料２（入院基本料Ｇ）（夜勤時間超過減算）
           03   FILLER                     PIC X(09) VALUE "190167310".
      *    療養病棟入院基本料２（入院基本料Ｈ）（夜勤時間超過減算）
           03   FILLER                     PIC X(09) VALUE "190167510".
      *    療養病棟入院基本料２（入院基本料Ｉ）（夜勤時間超過減算）
           03   FILLER                     PIC X(09) VALUE "190167710".
      *
       01  TBL-H26-SEIKATSU-R     REDEFINES  TBL-H26-SEIKATSU-AREA.
           03   TBL-H26-SEISRYCD           PIC X(09)  OCCURS  17.
      *
      *    生活療養判定用（平成２８年追加分）
       01  TBL-H28-SEIKATSU-AREA.
      *    療養病棟入院基本料２（入院基本料Ａ）（夜勤時間特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190185510".
      *    療養病棟入院基本料２（入院基本料Ａ）（看護職員数等経過措置）
           03   FILLER                     PIC X(09) VALUE "190183710".
      *    療養病棟入院基本料２（入院基本料Ｂ）（夜勤時間特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190185710".
      *    療養病棟入院基本料２（入院基本料Ｂ）（看護職員数等経過措置）
           03   FILLER                     PIC X(09) VALUE "190183910".
      *    療養病棟入院基本料２（入院基本料Ｃ）（夜勤時間特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190185910".
      *    療養病棟入院基本料２（入院基本料Ｃ）（看護職員数等経過措置）
           03   FILLER                     PIC X(09) VALUE "190184110".
      *    療養病棟入院基本料２（入院基本料Ｄ）（夜勤時間特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190186110".
      *    療養病棟入院基本料２（入院基本料Ｄ）（看護職員数等経過措置）
           03   FILLER                     PIC X(09) VALUE "190184310".
      *    療養病棟入院基本料２（入院基本料Ｅ）（夜勤時間特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190186310".
      *    療養病棟入院基本料２（入院基本料Ｅ）（看護職員数等経過措置）
           03   FILLER                     PIC X(09) VALUE "190184510".
      *    療養病棟入院基本料２（入院基本料Ｆ）（夜勤時間特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190186510".
      *    療養病棟入院基本料２（入院基本料Ｆ）（看護職員数等経過措置）
           03   FILLER                     PIC X(09) VALUE "190184710".
      *    療養病棟入院基本料２（入院基本料Ｇ）（夜勤時間特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190186710".
      *    療養病棟入院基本料２（入院基本料Ｇ）（看護職員数等経過措置）
           03   FILLER                     PIC X(09) VALUE "190184910".
      *    療養病棟入院基本料２（入院基本料Ｈ）（夜勤時間特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190186910".
      *    療養病棟入院基本料２（入院基本料Ｈ）（看護職員数等経過措置）
           03   FILLER                     PIC X(09) VALUE "190185110".
      *    療養病棟入院基本料２（入院基本料Ｉ）（夜勤時間特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190187110".
      *    療養病棟入院基本料２（入院基本料Ｉ）（看護職員数等経過措置）
           03   FILLER                     PIC X(09) VALUE "190185310".
      *
       01  TBL-H28-SEIKATSU-R     REDEFINES  TBL-H28-SEIKATSU-AREA.
           03   TBL-H28-SEISRYCD           PIC X(09)  OCCURS  18.
      *
      *    生活療養判定用（平成３０年追加分）
       01  TBL-H30-SEIKATSU-AREA.
      *    地域包括ケア病棟入院料１
           03   FILLER                     PIC X(09) VALUE "190209110".
      *    地域包括ケア入院医療管理料１
           03   FILLER                     PIC X(09) VALUE "190209310".
      *    地域包括ケア病棟入院料２
           03   FILLER                     PIC X(09) VALUE "190209510".
      *    地域包括ケア入院医療管理料２
           03   FILLER                     PIC X(09) VALUE "190209710".
      *    地域包括ケア病棟入院料３
           03   FILLER                     PIC X(09) VALUE "190209910".
      *    地域包括ケア入院医療管理料３
           03   FILLER                     PIC X(09) VALUE "190210110".
      *    地域包括ケア病棟入院料４
           03   FILLER                     PIC X(09) VALUE "190210310".
      *    地域包括ケア入院医療管理料４
           03   FILLER                     PIC X(09) VALUE "190210510".
      *    地域包括ケア病棟入院料１（特定地域）
           03   FILLER                     PIC X(09) VALUE "190210710".
      *    地域包括ケア入院医療管理料１（特定地域）
           03   FILLER                     PIC X(09) VALUE "190210910".
      *    地域包括ケア病棟入院料２（特定地域）
           03   FILLER                     PIC X(09) VALUE "190211110".
      *    地域包括ケア入院医療管理料２（特定地域）
           03   FILLER                     PIC X(09) VALUE "190211310".
      *    地域包括ケア病棟入院料３（特定地域）
           03   FILLER                     PIC X(09) VALUE "190211510".
      *    地域包括ケア入院医療管理料３（特定地域）
           03   FILLER                     PIC X(09) VALUE "190211710".
      *    地域包括ケア病棟入院料４（特定地域）
           03   FILLER                     PIC X(09) VALUE "190211910".
      *    地域包括ケア入院医療管理料４（特定地域）
           03   FILLER                     PIC X(09) VALUE "190212110".
      *    回復期リハビリテーション病棟入院料１
           03   FILLER                     PIC X(09) VALUE "190207910".
      *    回復期リハビリテーション病棟入院料２
           03   FILLER                     PIC X(09) VALUE "190208110".
      *    回復期リハビリテーション病棟入院料３
           03   FILLER                     PIC X(09) VALUE "190208310".
      *    回復期リハビリテーション病棟入院料４
           03   FILLER                     PIC X(09) VALUE "190208510".
      *    回復期リハビリテーション病棟入院料５
           03   FILLER                     PIC X(09) VALUE "190208710".
      *    回復期リハビリテーション病棟入院料６
           03   FILLER                     PIC X(09) VALUE "190208910".
      *    療養病棟入院料２（Ａ）（経過措置１）
           03   FILLER                     PIC X(09) VALUE "190215110".
      *    療養病棟入院料２（Ｂ）（経過措置１）
           03   FILLER                     PIC X(09) VALUE "190215310".
      *    療養病棟入院料２（Ｃ）（経過措置１）
           03   FILLER                     PIC X(09) VALUE "190215510".
      *    療養病棟入院料２（Ｄ）（経過措置１）
           03   FILLER                     PIC X(09) VALUE "190215710".
      *    療養病棟入院料２（Ｅ）（経過措置１）
           03   FILLER                     PIC X(09) VALUE "190215910".
      *    療養病棟入院料２（Ｆ）（経過措置１）
           03   FILLER                     PIC X(09) VALUE "190216110".
      *    療養病棟入院料２（Ｇ）（経過措置１）
           03   FILLER                     PIC X(09) VALUE "190216310".
      *    療養病棟入院料２（Ｈ）（経過措置１）
           03   FILLER                     PIC X(09) VALUE "190216510".
      *    療養病棟入院料２（Ｉ）（経過措置１）
           03   FILLER                     PIC X(09) VALUE "190216710".
      *    療養病棟入院料２（Ａ）（経過措置２）
           03   FILLER                     PIC X(09) VALUE "190202510".
      *    療養病棟入院料２（Ｂ）（経過措置２）
           03   FILLER                     PIC X(09) VALUE "190202710".
      *    療養病棟入院料２（Ｃ）（経過措置２）
           03   FILLER                     PIC X(09) VALUE "190202910".
      *    療養病棟入院料２（Ｄ）（経過措置２）
           03   FILLER                     PIC X(09) VALUE "190203110".
      *    療養病棟入院料２（Ｅ）（経過措置２）
           03   FILLER                     PIC X(09) VALUE "190203310".
      *    療養病棟入院料２（Ｆ）（経過措置２）
           03   FILLER                     PIC X(09) VALUE "190203510".
      *    療養病棟入院料２（Ｇ）（経過措置２）
           03   FILLER                     PIC X(09) VALUE "190203710".
      *    療養病棟入院料２（Ｈ）（経過措置２）
           03   FILLER                     PIC X(09) VALUE "190203910".
      *    療養病棟入院料２（Ｉ）（経過措置２）
           03   FILLER                     PIC X(09) VALUE "190204110".
      *    療養病棟入院料２（Ｉ）（経過措置２・通則８）
           03   FILLER                     PIC X(09) VALUE "190204310".
      *
       01  TBL-H30-SEIKATSU-R     REDEFINES  TBL-H30-SEIKATSU-AREA.
           03   TBL-H30-SEISRYCD           PIC X(09)  OCCURS  41.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *    （病棟情報）
           COPY    "CPSK5001.INC".
      *
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
       01  NYUINACT-REC.
           COPY    "CPNYUINACT.INC".
      *
           COPY    "CPTENSU.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "MCPAREA".
      *
      *    保険算定用年齢・割合計算サブ
           COPY    "CPORCSAGECHK.INC".
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                        SECTION.
      *
           COPY    "CPORCSS007.INC".
      *
           COPY    "COMMON-SPA".
      *
       PROCEDURE                       DIVISION    USING
           SS007-AREA
           SPA-AREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           INITIALIZE                      FLG-AREA
           INITIALIZE                      IDX-AREA
           INITIALIZE                      WRK-AREA
           INITIALIZE                      SS007-OT
      *
      *    初期処理
           PERFORM 100-INIT-SEC
      *
      *    主処理
           PERFORM 200-MAIN-SEC
      *
      *    終了処理
           PERFORM 300-END-SEC
      *
           .
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           MOVE    SS007-SRYYM     TO  WRK-SRYYMD (1:6)
           MOVE    "01"            TO  WRK-SRYYMD (7:2)
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
      *    療養病床入院チェック
           IF      SS007-SRYYM     >=  "201204"
              PERFORM 2001-RYOYO-MAECHK-SEC
           END-IF
      *
           MOVE    ZERO            TO  FLG-UNMATCH
      *
           PERFORM 900-NYUINACCT-KEY17-SEL-SEC
      *
           PERFORM UNTIL ( FLG-NYUINACCT   NOT =   ZERO )
                    OR   ( FLG-UNMATCH     NOT =   ZERO )
      *
               IF    ( NACCT-ZAIKAISU      =   ZERO )
                OR   ( NACCT-SRYCDTOTAL    =   099999916 )
                   CONTINUE
               ELSE
                   PERFORM 2001-NYUINACT-CHK-SEC
               END-IF
      *
               PERFORM 900-NYUINACCT-KEY17-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "key17"             TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
      *    食堂加算算定可能病棟の入院対象日取得
           PERFORM   2002-SHOKUDOU-CHK-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    療養病床入院チェック
      *****************************************************************
       2001-RYOYO-MAECHK-SEC                    SECTION.
      *
           MOVE    ZERO                TO  FLG-RYOYO-CHK
      *
      *    患者年齢計算
           MOVE    SPA-HOSPNUM         TO  PTINF-HOSPNUM
           MOVE    SPA-PTID            TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           INITIALIZE                      ORCSAGECHKAREA
           MOVE    SPA-HOSPNUM         TO  AGECHK-HOSPNUM
           MOVE    SPA-PTID            TO  AGECHK-PTID
           MOVE    WRK-SRYYMD          TO  AGECHK-SRYYMD
           MOVE    PTINF-BIRTHDAY      TO  AGECHK-BIRTHDAY
           CALL    "ORCSAGECHK"            USING
                                           ORCSAGECHKAREA
                                           SPA-AREA
      **     DISPLAY "ORCSS007 AGECHK-NENREI = " AGECHK-NENREI
      *
      *    ６５歳以上の患者について患者入院履歴を検索して療養病床に
      *    入院している該当日を求める（労災、自賠、公務災害は除く）
           IF     AGECHK-NENREI        >=  65
             INITIALIZE                    PTNYUINRRK-REC
             MOVE    SPA-HOSPNUM       TO  PTNYUINRRK-HOSPNUM
             MOVE    SPA-PTID          TO  PTNYUINRRK-PTID
      *      転入日セット（月末日）
             MOVE    SS007-SRYYM       TO  PTNYUINRRK-TENNYUYMD(1:6)
             INITIALIZE                    STS-AREA-DAY
             INITIALIZE                    LNK-DAY7-AREA
             MOVE    "71"              TO  LNK-DAY7-IRAI
             MOVE    SS007-SRYYM       TO  LNK-DAY7-YM
             CALL    "ORCSDAY"   USING     STS-AREA-DAY
                                           LNK-DAY7-AREA
             MOVE    LNK-DAY7-KOYOMI   TO  WRK-MATSUYMD
             MOVE    WRK-MATSUDD       TO  PTNYUINRRK-TENNYUYMD(7:2)
      *      転出日セット（１日）
             MOVE    SS007-SRYYM       TO  PTNYUINRRK-TENSTUYMD(1:6)
             MOVE    "01"              TO  PTNYUINRRK-TENSTUYMD(7:2)
      *
             MOVE    "tbl_ptnyuinrrk"  TO  MCP-TABLE
             MOVE    "key44"           TO  MCP-PATHNAME
             PERFORM 900-PTNYUINRRK-SELECT-SEC
             IF      FLG-PTNYUINRRK      =   ZERO
               MOVE  "tbl_ptnyuinrrk"  TO  MCP-TABLE
               MOVE  "key44"           TO  MCP-PATHNAME
               PERFORM 900-PTNYUINRRK-READ-SEC
               IF  FLG-PTNYUINRRK      =   ZERO
                   PERFORM UNTIL  FLG-PTNYUINRRK  =  1
      *                病棟種別の取得
                       PERFORM    20011-BTUSEL-SEC
      *
                       IF     PTNYUINRRK-TENNYUYMD(1:6) <  SS007-SRYYM
                           MOVE     1  TO  IDX-ST
                       END-IF
                       IF     PTNYUINRRK-TENNYUYMD(1:6) =  SS007-SRYYM
                           MOVE  PTNYUINRRK-TENNYUYMD(7:2)  TO  IDX-ST
                       END-IF
                       IF     PTNYUINRRK-TENSTUYMD(1:6) >  SS007-SRYYM
                           MOVE     WRK-MATSUDD  TO  IDX-ED
                       END-IF
                       IF     PTNYUINRRK-TENSTUYMD(1:6) =  SS007-SRYYM
                           MOVE  PTNYUINRRK-TENSTUYMD(7:2)  TO  IDX-ED
                       END-IF
      **                 DISPLAY   "---------------------"
      **                 DISPLAY   "IDX-ST = " IDX-ST
      **                 DISPLAY   "IDX-ED = " IDX-ED
                       PERFORM   VARYING   IDX   FROM  IDX-ST  BY  1
                                 UNTIL    (IDX   >     IDX-ED)
                           IF   (SYS-5001-BTU-SBT   =    "04")   OR
                                (SYS-5001-BTU-SBT   =    "09")   OR
                               ((SYS-5001-BTU-SBT   =    "08")  AND
                                (SYS-5001-CRYOYOKBN =    "1" ))
                              MOVE   "1"     TO    WRK-RYOYO-TBL(IDX)
                           ELSE
                              MOVE   SPACE   TO    WRK-RYOYO-TBL(IDX)
                           END-IF
                       END-PERFORM
      **                 DISPLAY  "----5----0----5----0----5----0-"
      **                 DISPLAY  WRK-RYOYO-TABLE
                       MOVE  "tbl_ptnyuinrrk"  TO  MCP-TABLE
                       MOVE  "key44"           TO  MCP-PATHNAME
                       PERFORM 900-PTNYUINRRK-READ-SEC
                   END-PERFORM
               END-IF
             END-IF
      *
             MOVE    "tbl_ptnyuinrrk"  TO  MCP-TABLE
             MOVE    "key44"           TO  MCP-PATHNAME
             PERFORM  910-DBCLOSECURSOR-SEC
      *
      *      労災、自賠、公務災害での入院日判定
             INITIALIZE                    NYUINACCT-REC
             MOVE    SPA-HOSPNUM       TO  NACCT-HOSPNUM
             MOVE    SPA-PTID          TO  NACCT-PTID
             MOVE    SS007-SRYYM       TO  NACCT-SRYYM
             MOVE    "5"               TO  NACCT-ZAISKBKBN
             MOVE    "tbl_nyuinacct"   TO  MCP-TABLE
             MOVE    "key17"           TO  MCP-PATHNAME
             PERFORM 900-NYUINACCT-SELECT-SEC
             IF      FLG-NYUINACCT     =   ZERO
                MOVE  "tbl_nyuinacct"  TO  MCP-TABLE
                MOVE  "key17"          TO  MCP-PATHNAME
                PERFORM 900-NYUINACCT-READ-SEC
                IF   FLG-NYUINACCT     =   ZERO
                    PERFORM   VARYING  IDX   FROM   1   BY   1
                       UNTIL  IDX      >     31
                          MOVE   NACCT-DAY (IDX)
                                       TO  WRK-HKNCOMBI-TBL9
                          MOVE   WRK-HKNCOMBI-TBLX
                                       TO  WRK-HKNCOMBI-TBL(IDX)
                    END-PERFORM
                END-IF
             END-IF
      *
             PERFORM   VARYING  IDX   FROM  1  BY  1
               UNTIL   IDX   >  31
                 IF   WRK-HKNCOMBI-TBL(IDX)  NOT =  "0000"
                    IF   IDX    =    1
      *               保険区分取得
                      INITIALIZE                     ORCSAGECHKAREA
                      MOVE    SPA-HOSPNUM        TO  AGECHK-HOSPNUM
                      MOVE    SPA-PTID           TO  AGECHK-PTID
                      MOVE    WRK-SRYYMD         TO  AGECHK-SRYYMD
                      MOVE    PTINF-BIRTHDAY     TO  AGECHK-BIRTHDAY
                      MOVE    WRK-HKNCOMBI-TBL(IDX)
                                                 TO  AGECHK-HKNCOMBINUM
                      CALL    "ORCSAGECHK"           USING
                                                     ORCSAGECHKAREA
                                                     SPA-AREA
      **                DISPLAY  "AGECHK-RC 1 = " AGECHK-RC
                      IF   AGECHK-HKNKBN   =  1  OR  2  OR  4  OR  5
                          MOVE   "1"             TO  WRK-RSI-TBL(IDX)
                      END-IF
                    ELSE
                      MOVE    ZERO      TO   IDX1
                      COMPUTE   IDX1    =    IDX   -  1
                      IF WRK-HKNCOMBI-TBL(IDX1) = WRK-HKNCOMBI-TBL(IDX)
                          MOVE  WRK-RSI-TBL(IDX1)  TO  WRK-RSI-TBL(IDX)
                      ELSE
      *                 保険区分取得
                        INITIALIZE                     ORCSAGECHKAREA
                        MOVE    SPA-HOSPNUM        TO  AGECHK-HOSPNUM
                        MOVE    SPA-PTID           TO  AGECHK-PTID
                        MOVE    WRK-SRYYMD         TO  AGECHK-SRYYMD
                        MOVE    PTINF-BIRTHDAY     TO  AGECHK-BIRTHDAY
                        MOVE    WRK-HKNCOMBI-TBL(IDX)
                                                 TO  AGECHK-HKNCOMBINUM
                        CALL    "ORCSAGECHK"           USING
                                                       ORCSAGECHKAREA
                                                       SPA-AREA
      **                  DISPLAY  "AGECHK-RC 2 = " AGECHK-RC
                        IF   AGECHK-HKNKBN   =  1  OR  2  OR  4  OR  5
                            MOVE   "1"             TO  WRK-RSI-TBL(IDX)
                        END-IF
                      END-IF
                    END-IF
                 END-IF
             END-PERFORM
      *
             PERFORM    VARYING   IDX    FROM   1   BY  1
               UNTIL    IDX    >    31
      **           DISPLAY "IDX = " IDX
      **           DISPLAY " WRK-RSI-TBL(IDX) = " WRK-RSI-TBL(IDX)
             END-PERFORM
      *      入院会計クローズ
             MOVE    "tbl_nyuinacct"   TO  MCP-TABLE
             MOVE    "key17"           TO  MCP-PATHNAME
             PERFORM  910-DBCLOSECURSOR-SEC
      *
           END-IF
      *
           IF    WRK-RYOYO-TABLE      NOT = SPACE
               MOVE     1             TO    FLG-RYOYO-CHK
           END-IF
           .
       2001-RYOYO-MAECHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    病棟情報取得
      *****************************************************************
       20011-BTUSEL-SEC             SECTION.
      *
           INITIALIZE                      SYSKANRI-REC
           MOVE    ZERO                TO  FLG-SYSKANRI
           MOVE    SPA-HOSPNUM         TO  SYS-HOSPNUM
           MOVE    "5001"              TO  SYS-KANRICD
           MOVE    PTNYUINRRK-BTUNUM   TO  SYS-KBNCD
           MOVE    WRK-SRYYMD          TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC    =    ZERO
               MOVE   MCPDATA-REC      TO  SYS-5001-REC
           ELSE
               INITIALIZE                  SYS-5001-REC
           END-IF
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       20011-BTUSEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院診療行為チェック処理
      *****************************************************************
       2001-NYUINACT-CHK-SEC           SECTION.
      *
           MOVE    ZERO            TO  WRK-ZAITEN
                                       WRK-HYOKETU-TEN
      *
           PERFORM 900-NYUINACT-KEY9-SEL-SEC
      *
           PERFORM UNTIL ( FLG-NYUINACT    NOT =   ZERO )
      *
               PERFORM VARYING IDX-NSRY    FROM    1   BY  1
                       UNTIL ( IDX-NSRY    >   5 )
      *
                   IF    ( NSRY-SRYCD (IDX-NSRY)   NOT =   SPACE )
                       MOVE    NSRY-SRYCD (IDX-NSRY)
                                   TO  WRK-SRYCD
                       PERFORM 900-TENSU-KEY-SEL-SEC
                       EVALUATE    TNS-TENSIKIBETU
                       WHEN    3
                           COMPUTE WRK-ZAITEN
                               =   WRK-ZAITEN  +   TNS-TEN
                       WHEN    8
                           COMPUTE WRK-ZAITEN
                                =   WRK-ZAITEN  + ( TNS-TEN *   -1 )
                       WHEN    6
                           MOVE    TNS-TEN     TO  WRK-HYOKETU-TEN
                       END-EVALUATE
                   END-IF
      *
      *            生活療養となる患者が、生活療養以外の入院料を算定
      *            していた場合のチェック
                   IF      SS007-SRYYM     >=  "201204"
                     IF   (IDX-NSRY     =     1)    AND
                        ( NSRY-SRYCD (IDX-NSRY)   NOT =   SPACE )
                       PERFORM    VARYING   IDX-SEI   FROM  1  BY  1
                         UNTIL   (IDX-SEI    >   84)
                           IF  NSRY-SRYCD (IDX-NSRY)
                                       =  TBL-H24-SEISRYCD(IDX-SEI)
                             PERFORM   VARYING  IDX FROM  1  BY  1
                                UNTIL    (IDX   >     31)
                                  IF   (NACCT-DAY(IDX)      =   1 ) AND
                                       (WRK-RYOYO-TBL(IDX)  =  "1") AND
                                       (WRK-RSI-TBL(IDX)    =  SPACE)
                                           MOVE    1    TO  SS007-RC2
                                  END-IF
                             END-PERFORM
                           END-IF
                       END-PERFORM
                     END-IF
                   END-IF
                   IF      SS007-SRYYM     >=  "201404"
                     IF   (IDX-NSRY     =     1)    AND
                        ( NSRY-SRYCD (IDX-NSRY)   NOT =   SPACE )
                       PERFORM    VARYING   IDX-SEI   FROM  1  BY  1
                         UNTIL   (IDX-SEI    >   17)
                           IF  NSRY-SRYCD (IDX-NSRY)
                                       =  TBL-H26-SEISRYCD(IDX-SEI)
                             PERFORM   VARYING  IDX FROM  1  BY  1
                                UNTIL    (IDX   >     31)
                                  IF   (NACCT-DAY(IDX)      =   1 ) AND
                                       (WRK-RYOYO-TBL(IDX)  =  "1") AND
                                       (WRK-RSI-TBL(IDX)    =  SPACE)
                                           MOVE    1    TO  SS007-RC2
                                  END-IF
                             END-PERFORM
                           END-IF
                       END-PERFORM
                     END-IF
                   END-IF
                   IF      SS007-SRYYM     >=  "201604"
                     IF   (IDX-NSRY     =     1)    AND
                        ( NSRY-SRYCD (IDX-NSRY)   NOT =   SPACE )
                       PERFORM    VARYING   IDX-SEI   FROM  1  BY  1
                         UNTIL   (IDX-SEI    >   18)
                           IF  NSRY-SRYCD (IDX-NSRY)
                                       =  TBL-H28-SEISRYCD(IDX-SEI)
                             PERFORM   VARYING  IDX FROM  1  BY  1
                                UNTIL    (IDX   >     31)
                                  IF   (NACCT-DAY(IDX)      =   1 ) AND
                                       (WRK-RYOYO-TBL(IDX)  =  "1") AND
                                       (WRK-RSI-TBL(IDX)    =  SPACE)
                                           MOVE    1    TO  SS007-RC2
                                  END-IF
                             END-PERFORM
                           END-IF
                       END-PERFORM
                     END-IF
                   END-IF
                   IF      SS007-SRYYM     >=  "201804"
                     IF   (IDX-NSRY     =     1)    AND
                        ( NSRY-SRYCD (IDX-NSRY)   NOT =   SPACE )
                       PERFORM    VARYING   IDX-SEI   FROM  1  BY  1
                         UNTIL   (IDX-SEI    >   41)
                           IF  NSRY-SRYCD (IDX-NSRY)
                                       =  TBL-H30-SEISRYCD(IDX-SEI)
                             PERFORM   VARYING  IDX FROM  1  BY  1
                                UNTIL    (IDX   >     31)
                                  IF   (NACCT-DAY(IDX)      =   1 ) AND
                                       (WRK-RYOYO-TBL(IDX)  =  "1") AND
                                       (WRK-RSI-TBL(IDX)    =  SPACE)
                                           MOVE    1    TO  SS007-RC2
                                  END-IF
                             END-PERFORM
                           END-IF
                       END-PERFORM
                     END-IF
                   END-IF
      *
               END-PERFORM
      *
               PERFORM 900-NYUINACT-KEY9-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_nyuinact"      TO  MCP-TABLE
           MOVE    "key9"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           IF    ( WRK-HYOKETU-TEN NOT =   ZERO )
               COMPUTE WRK-ZAITEN
                   =   WRK-ZAITEN
                   -   WRK-ZAITEN * ( WRK-HYOKETU-TEN / 100)
                   +  0.5
           END-IF
      *
      **     DISPLAY "WRK-ZAITEN = " WRK-ZAITEN
      *
           IF    ( NACCT-ZAITEN    NOT =   WRK-ZAITEN )
               MOVE    1               TO  FLG-UNMATCH
           END-IF
      *
           .
       2001-NYUINACT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    食堂加算算定可能病棟の入院対象日取得
      *****************************************************************
       2002-SHOKUDOU-CHK-SEC                    SECTION.
      *
           MOVE    ZERO                TO  FLG-RYOYO-CHK
      *
           INITIALIZE                      PTNYUINRRK-REC
           MOVE    SPA-HOSPNUM         TO  PTNYUINRRK-HOSPNUM
           MOVE    SPA-PTID            TO  PTNYUINRRK-PTID
      *    転入日セット（月末日）
           MOVE    SS007-SRYYM         TO  PTNYUINRRK-TENNYUYMD(1:6)
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY7-AREA
           MOVE    "71"                TO  LNK-DAY7-IRAI
           MOVE    SS007-SRYYM         TO  LNK-DAY7-YM
           CALL    "ORCSDAY"   USING       STS-AREA-DAY
                                           LNK-DAY7-AREA
           MOVE    LNK-DAY7-KOYOMI     TO  WRK-MATSUYMD
           MOVE    WRK-MATSUDD         TO  PTNYUINRRK-TENNYUYMD(7:2)
      *    転出日セット（１日）
           MOVE    SS007-SRYYM         TO  PTNYUINRRK-TENSTUYMD(1:6)
           MOVE    "01"                TO  PTNYUINRRK-TENSTUYMD(7:2)
      *
           MOVE    "tbl_ptnyuinrrk"    TO  MCP-TABLE
           MOVE    "key44"             TO  MCP-PATHNAME
           PERFORM 900-PTNYUINRRK-SELECT-SEC
           IF      FLG-PTNYUINRRK      =   ZERO
             MOVE  "tbl_ptnyuinrrk"    TO  MCP-TABLE
             MOVE  "key44"             TO  MCP-PATHNAME
             PERFORM 900-PTNYUINRRK-READ-SEC
             IF  FLG-PTNYUINRRK        =   ZERO
                 PERFORM UNTIL  FLG-PTNYUINRRK  =  1
      *              病棟種別の取得
                     PERFORM    20011-BTUSEL-SEC
      *
                     IF     PTNYUINRRK-TENNYUYMD(1:6) <  SS007-SRYYM
                         MOVE     1  TO  IDX-ST
                     END-IF
                     IF     PTNYUINRRK-TENNYUYMD(1:6) =  SS007-SRYYM
                         MOVE  PTNYUINRRK-TENNYUYMD(7:2)  TO  IDX-ST
                     END-IF
                     IF     PTNYUINRRK-TENSTUYMD(1:6) >  SS007-SRYYM
                         MOVE     WRK-MATSUDD  TO  IDX-ED
                     END-IF
                     IF     PTNYUINRRK-TENSTUYMD(1:6) =  SS007-SRYYM
                         MOVE  PTNYUINRRK-TENSTUYMD(7:2)  TO  IDX-ED
                     END-IF
      **               DISPLAY   "---------------------"
      **               DISPLAY   "IDX-ST = " IDX-ST
      **               DISPLAY   "IDX-ED = " IDX-ED
                     PERFORM   VARYING   IDX   FROM  IDX-ST  BY  1
                               UNTIL    (IDX   >     IDX-ED)
                         IF  SYS-5001-BTU-SYOKUDOKBN    =   '2'
                             MOVE   "1"     TO  SS007-RC3(IDX)
                         ELSE
                             MOVE   SPACE   TO  SS007-RC3(IDX)
                         END-IF
                     END-PERFORM
      **               DISPLAY  "----5----0----5----0----5----0-"
      **               DISPLAY  SS007-RC3-TBL
                     MOVE  "tbl_ptnyuinrrk"  TO  MCP-TABLE
                     MOVE  "key44"           TO  MCP-PATHNAME
                     PERFORM 900-PTNYUINRRK-READ-SEC
                 END-PERFORM
             END-IF
           END-IF
      *
             MOVE    "tbl_ptnyuinrrk"  TO  MCP-TABLE
             MOVE    "key44"           TO  MCP-PATHNAME
             PERFORM  910-DBCLOSECURSOR-SEC
      *
      *
           .
       2002-SHOKUDOU-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
           MOVE    FLG-UNMATCH     TO  SS007-RC
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込（主キー）
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptinf"     TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               PERFORM 910-DBFETCH-SEC
               IF  MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC TO  PTINF-REC
                   MOVE    ZERO        TO  FLG-PTINF
               ELSE
                   MOVE    1           TO  FLG-PTINF
                   INITIALIZE              PTINF-REC
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
           END-IF
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
           .
       900-PTINF-READ-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索処理
      *****************************************************************
       900-TENSU-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-TENSU
      *
           INITIALIZE                      TNS-TENSU-REC
           MOVE    SPA-HOSPNUM         TO  TNS-HOSPNUM
           MOVE    WRK-SRYCD           TO  TNS-SRYCD
           MOVE    WRK-SRYYMD          TO  TNS-YUKOSTYMD
                                           TNS-YUKOEDYMD
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
           ELSE
               MOVE    1               TO  FLG-TENSU
               INITIALIZE                  TNS-TENSU-REC
           END-IF
      *
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
      *
       900-TENSU-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    入院会計検索処理
      *****************************************************************
       900-NYUINACCT-KEY17-SEL-SEC    SECTION.
      *
           MOVE    ZERO            TO  FLG-NYUINACCT
      *
           INITIALIZE                  NYUINACCT-REC
           MOVE    SPA-HOSPNUM     TO  NACCT-HOSPNUM
           MOVE    SPA-PTID        TO  NACCT-PTID
           MOVE    SS007-SRYYM     TO  NACCT-SRYYM
           MOVE    "1"             TO  NACCT-ZAISKBKBN
           MOVE    NYUINACCT-REC   TO   MCPDATA-REC
           MOVE    "tbl_nyuinacct" TO  MCP-TABLE
           MOVE    "key17"         TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  NYUINACCT-REC
           ELSE
               MOVE    1           TO  FLG-NYUINACCT
               INITIALIZE              NYUINACCT-REC
           END-IF
      *
           .
       900-NYUINACCT-KEY24-SEL-EXT.
            EXIT.
      *****************************************************************
      *    入院会計FETCH処理
      *****************************************************************
       900-NYUINACCT-KEY17-FET-SEC    SECTION.
      *
           MOVE    ZERO            TO  FLG-NYUINACCT
      *
           MOVE    "tbl_nyuinacct" TO  MCP-TABLE
           MOVE    "key17"         TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  NYUINACCT-REC
           ELSE
               MOVE    1           TO  FLG-NYUINACCT
               INITIALIZE              NYUINACCT-REC
           END-IF
      *
           .
       900-NYUINACCT-KEY17-FET-EXT.
            EXIT.
      *
      *****************************************************************
      *    入院会計マスター検索
      *****************************************************************
       900-NYUINACCT-SELECT-SEC        SECTION.
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           PERFORM   911-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-NYUINACCT
           ELSE
               MOVE    1                  TO  FLG-NYUINACCT
           END-IF
      *
           .
       900-NYUINACCT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスター読込
      *****************************************************************
       900-NYUINACCT-READ-SEC        SECTION.
      *
           PERFORM   910-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  NYUINACCT-REC
               MOVE    ZERO               TO  FLG-NYUINACCT
           ELSE
               INITIALIZE                     NYUINACCT-REC
               MOVE    1                  TO  FLG-NYUINACCT
           END-IF
      *
           .
       900-NYUINACCT-READ-EXT.
           EXIT.
      *****************************************************************
      *    入院診療行為検索処理
      *****************************************************************
       900-NYUINACT-KEY9-SEL-SEC       SECTION.
      *
      *    入院診療行為検索処理
           MOVE    ZERO                TO  FLG-NYUINACT
      *
           INITIALIZE                      NYUINACT-REC
           MOVE    NACCT-HOSPNUM       TO  NSRY-HOSPNUM
           MOVE    NACCT-NYUGAIKBN     TO  NSRY-NYUGAIKBN
           MOVE    NACCT-PTID          TO  NSRY-PTID
           MOVE    NACCT-SRYYM         TO  NSRY-SRYYM
           MOVE    NACCT-ZAINUM        TO  NSRY-ZAINUM
           MOVE    NYUINACT-REC        TO  MCPDATA-REC
           MOVE    "tbl_nyuinact"      TO  MCP-TABLE
           MOVE    "key9"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF   (  MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  NYUINACT-REC
           ELSE
               MOVE    1               TO  FLG-NYUINACT
               INITIALIZE                  NYUINACT-REC
           END-IF
      *
           .
       900-NYUINACT-KEY9-SEL-EXT.
            EXIT.
      *****************************************************************
      *    入院診療行為FETCH理
      *****************************************************************
       900-NYUINACT-KEY9-FET-SEC       SECTION.
      *
           MOVE    "tbl_nyuinact"      TO  MCP-TABLE
           MOVE    "key9"              TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF   (  MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  NYUINACT-REC
           ELSE
               MOVE    1               TO  FLG-NYUINACT
               INITIALIZE                  NYUINACT-REC
           END-IF
      *
           .
       900-NYUINACT-KEY9-FET-EXT.
            EXIT.
      *
      *****************************************************************
      *    患者入院履歴検索
      *****************************************************************
       900-PTNYUINRRK-SELECT-SEC        SECTION.
      *
           MOVE    PTNYUINRRK-REC         TO  MCPDATA-REC
           PERFORM   911-DBSELECT-SEC
           IF      MCP-RC                 =   ZERO
               MOVE    ZERO               TO  FLG-PTNYUINRRK
           ELSE
               MOVE    1                  TO  FLG-PTNYUINRRK
           END-IF
      *
           .
       900-PTNYUINRRK-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者入院履歴読込
      *****************************************************************
       900-PTNYUINRRK-READ-SEC        SECTION.
      *
           PERFORM   910-DBFETCH-SEC
           IF      MCP-RC                 =   ZERO
               MOVE    MCPDATA-REC        TO  PTNYUINRRK-REC
               MOVE    ZERO               TO  FLG-PTNYUINRRK
           ELSE
               INITIALIZE                     PTNYUINRRK-REC
               MOVE    1                  TO  FLG-PTNYUINRRK
           END-IF
      *
           .
       900-PTNYUINRRK-READ-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHも行う)
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHは行わない)
      *****************************************************************
       911-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
      *
       911-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC           SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
      *
       910-DBCLOSECURSOR-EXT.
           EXIT.
