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
       IDENTIFICATION                  DIVISION.
       PROGRAM-ID.                     ORCSPREF.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 共通
      *  コンポーネント名  : 都道府県名取得
      *  管理者            :
      *  作成日付    作業者        記述
      *  08/11/23    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                     DIVISION.
       CONFIGURATION                   SECTION.
       INPUT-OUTPUT                    SECTION.
       FILE-CONTROL.
      *
       DATA                            DIVISION.
       FILE                            SECTION.
      *
      *
       WORKING-STORAGE                 SECTION.
      *
       01  FLG-AREA.
           03  FLG-ERR                 PIC 9(01).
      *
       01  IDX-AREA.
           03  IDX0                    PIC 9(05).
      *
       01  WRK-AREA.
           03  WRK-DUMMY               PIC X(01).
      *
       01  CONST-AREA.
           03  CONST-PREF-G.
             05  CONST-PREF01 PIC X(22) VALUE "01北海道    北海道    ".
             05  CONST-PREF02 PIC X(22) VALUE "02青森県    青森      ".
             05  CONST-PREF03 PIC X(22) VALUE "03岩手県    岩手      ".
             05  CONST-PREF04 PIC X(22) VALUE "04宮城県    宮城      ".
             05  CONST-PREF05 PIC X(22) VALUE "05秋田県    秋田      ".
             05  CONST-PREF06 PIC X(22) VALUE "06山形県    山形      ".
             05  CONST-PREF07 PIC X(22) VALUE "07福島県    福島      ".
             05  CONST-PREF08 PIC X(22) VALUE "08茨城県    茨城      ".
             05  CONST-PREF09 PIC X(22) VALUE "09栃木県    栃木      ".
             05  CONST-PREF10 PIC X(22) VALUE "10群馬県    群馬      ".
             05  CONST-PREF11 PIC X(22) VALUE "11埼玉県    埼玉      ".
             05  CONST-PREF12 PIC X(22) VALUE "12千葉県    千葉      ".
             05  CONST-PREF13 PIC X(22) VALUE "13東京都    東京都    ".
             05  CONST-PREF14 PIC X(22) VALUE "14神奈川県  神奈川    ".
             05  CONST-PREF15 PIC X(22) VALUE "15新潟県    新潟      ".
             05  CONST-PREF16 PIC X(22) VALUE "16富山県    富山      ".
             05  CONST-PREF17 PIC X(22) VALUE "17石川県    石川      ".
             05  CONST-PREF18 PIC X(22) VALUE "18福井県    福井      ".
             05  CONST-PREF19 PIC X(22) VALUE "19山梨県    山梨      ".
             05  CONST-PREF20 PIC X(22) VALUE "20長野県    長野      ".
             05  CONST-PREF21 PIC X(22) VALUE "21岐阜県    岐阜      ".
             05  CONST-PREF22 PIC X(22) VALUE "22静岡県    静岡      ".
             05  CONST-PREF23 PIC X(22) VALUE "23愛知県    愛知      ".
             05  CONST-PREF24 PIC X(22) VALUE "24三重県    三重      ".
             05  CONST-PREF25 PIC X(22) VALUE "25滋賀県    滋賀      ".
             05  CONST-PREF26 PIC X(22) VALUE "26京都府    京都府    ".
             05  CONST-PREF27 PIC X(22) VALUE "27大阪府    大阪府    ".
             05  CONST-PREF28 PIC X(22) VALUE "28兵庫県    兵庫      ".
             05  CONST-PREF29 PIC X(22) VALUE "29奈良県    奈良      ".
             05  CONST-PREF30 PIC X(22) VALUE "30和歌山県  和歌山    ".
             05  CONST-PREF31 PIC X(22) VALUE "31鳥取県    鳥取      ".
             05  CONST-PREF32 PIC X(22) VALUE "32島根県    島根      ".
             05  CONST-PREF33 PIC X(22) VALUE "33岡山県    岡山      ".
             05  CONST-PREF34 PIC X(22) VALUE "34広島県    広島      ".
             05  CONST-PREF35 PIC X(22) VALUE "35山口県    山口      ".
             05  CONST-PREF36 PIC X(22) VALUE "36徳島県    徳島      ".
             05  CONST-PREF37 PIC X(22) VALUE "37香川県    香川      ".
             05  CONST-PREF38 PIC X(22) VALUE "38愛媛県    愛媛      ".
             05  CONST-PREF39 PIC X(22) VALUE "39高知県    高知      ".
             05  CONST-PREF40 PIC X(22) VALUE "40福岡県    福岡      ".
             05  CONST-PREF41 PIC X(22) VALUE "41佐賀県    佐賀      ".
             05  CONST-PREF42 PIC X(22) VALUE "42長崎県    長崎      ".
             05  CONST-PREF43 PIC X(22) VALUE "43熊本県    熊本      ".
             05  CONST-PREF44 PIC X(22) VALUE "44大分県    大分      ".
             05  CONST-PREF45 PIC X(22) VALUE "45宮崎県    宮崎      ".
             05  CONST-PREF46 PIC X(22) VALUE "46鹿児島県  鹿児島    ".
             05  CONST-PREF47 PIC X(22) VALUE "47沖縄県    沖縄      ".
           03    CONST-PREF-R    REDEFINES  CONST-PREF-G.
             05  CONST-PREF-OCC         OCCURS 47.
                 07  CONST-PREFNUM      PIC X(02).
                 07  CONST-PREFNAME1    PIC X(10).
                 07  CONST-PREFNAME2    PIC X(10).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *
      ****************************************************************
       LINKAGE                         SECTION.
           COPY    "CPORCSPREF.INC".
           COPY    "COMMON-SPA".
      *
      ****************************************************************
       PROCEDURE                       DIVISION
           USING
           SPREF-AREA
           SPA-AREA
           .
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           EXIT PROGRAM
      *
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           INITIALIZE                  IDX-AREA
                                       FLG-AREA
                                       WRK-AREA
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   47 )
      *
               MOVE    CONST-PREFNUM (IDX0)
                                   TO  SPREF-PREFNUM (IDX0)
               MOVE    CONST-PREFNAME1(IDX0)
                                   TO  SPREF-PREFNAME1(IDX0)
               MOVE    CONST-PREFNAME2(IDX0)
                                   TO  SPREF-PREFNAME2(IDX0)
      *
           END-PERFORM
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
      *
           .
       300-END-EXT.
           EXIT.
