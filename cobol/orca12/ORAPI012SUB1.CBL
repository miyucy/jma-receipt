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
       PROGRAM-ID.             ORAPI012SUB1.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者登録
      *  コンポーネント名  : 保険補助区分名称取得サブ
      *  管理者            : 
      *  作成日付    作業者        記述
      *  17/07/XX    NACL-多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
      *INPUT-OUTPUT                SECTION.
      *FILE-CONTROL.
      *
       DATA                    DIVISION.
      *FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
      *
      *    カウント領域
      *01  CNT-AREA.
      *
      *    添字領域
      *01  IDX-AREA.
      *    03  IDX                 PIC 9(04).
      *
      *    一時領域
      *01  WRK-AREA.
      *
       01  WRK-HENSYU-AREA.
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HMM         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HDD         PIC Z9.
      *
           03  WRK-HENTIME.
               05  WRK-THH         PIC 99.
               05  FILLER          PIC X(01)   VALUE  ":".
               05  WRK-TMM         PIC 99.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *
      *    数字変換領域
      *    COPY    "CPORCSNUM.INC".
      *
      *   日付変換サブ
      *    COPY    "CPORCSDAY.INC".
      *    COPY    "CPORCSLNK.INC".
      *    ＤＢ検索
      *    COPY    "MCPDATA.INC".
      *
      *
      *    COPY    "MCPAREA".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    パラメタ
           COPY    "CPORAPI012SUB1.INC".
      *    スパ領域
           COPY    "COMMON-SPA".
      *
       PROCEDURE                   DIVISION    USING
           ORAPI012SUB1AREA
           SPA-AREA.
      *
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  API012SUB1-OUT-AREA
      **   INITIALIZE                  WRK-AREA
           INITIALIZE                  FLG-AREA
      *
      *    補助区分名称取得
           PERFORM 100-HOJOKBN-HEN-SEC
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    補助区分名称取得処理
      *****************************************************************
       100-HOJOKBN-HEN-SEC               SECTION.
      *
      *
           EVALUATE    API012SUB1-HKNNUM
      *    船員
               WHEN    "002"
               EVALUATE    API012SUB1-HOJOKBN
                   WHEN    "1"
                       MOVE    "職務" 
                                           TO  API012SUB1-HOJOKBN-NAME
                   WHEN    "2"
                       MOVE    "下船" 
                                           TO  API012SUB1-HOJOKBN-NAME
                   WHEN    "3"
                       MOVE    "通勤" 
                                           TO  API012SUB1-HOJOKBN-NAME
                   WHEN    "7"
                       MOVE    "３割" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    30          TO  API012SUB1-RATE
                   WHEN    "8"
                       MOVE    "２割" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    20          TO  API012SUB1-RATE
                   WHEN    "9"
                       MOVE    "１割" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    10          TO  API012SUB1-RATE
                   WHEN    "A"
                       MOVE    "１割職務" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    10          TO  API012SUB1-RATE
                   WHEN    "B"
                       MOVE    "１割下船" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    10          TO  API012SUB1-RATE
                   WHEN    "C"
                       MOVE    "１割通勤" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    10          TO  API012SUB1-RATE
                   WHEN    "D"
                       MOVE    "２割職務" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    20          TO  API012SUB1-RATE
                   WHEN    "E"
                       MOVE    "２割下船" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    20          TO  API012SUB1-RATE
                   WHEN    "F"
                       MOVE    "２割通勤" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    20          TO  API012SUB1-RATE
                   WHEN    "G"
                       MOVE    "３割職務" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    30          TO  API012SUB1-RATE
                   WHEN    "H"
                       MOVE    "３割下船" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    30          TO  API012SUB1-RATE
                   WHEN    "I"
                       MOVE    "３割通勤" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    30          TO  API012SUB1-RATE
                   WHEN    SPACE
                       CONTINUE
                   WHEN    OTHER
                       MOVE    1           TO  API012SUB1-ERRCD
               END-EVALUATE
      *    後期高齢者
               WHEN    "039"
               WHEN    "040"
               EVALUATE    API012SUB1-HOJOKBN
                   WHEN    "1"
                       MOVE    "１割" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    10          TO  API012SUB1-RATE
                   WHEN    "3"
                       MOVE    "３割" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    30          TO  API012SUB1-RATE
                   WHEN    OTHER
                       MOVE    1           TO  API012SUB1-ERRCD
               END-EVALUATE
      *        共済
               WHEN    "031"
               WHEN    "032"
               WHEN    "033"
               WHEN    "034"
               EVALUATE    API012SUB1-HOJOKBN
                   WHEN    "2"
                       MOVE    "下船３月"
                                           TO  API012SUB1-HOJOKBN-NAME
                   WHEN    "7"
                       MOVE    "３割" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    30          TO  API012SUB1-RATE
                   WHEN    "8"
                       MOVE    "２割" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    20          TO  API012SUB1-RATE
                   WHEN    "9"
                       MOVE    "１割" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    10          TO  API012SUB1-RATE
                   WHEN    "B"
                       MOVE    "１割下船" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    10          TO  API012SUB1-RATE
                   WHEN    "E"
                       MOVE    "２割下船" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    20          TO  API012SUB1-RATE
                   WHEN    "H"
                       MOVE    "３割下船" 
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    30          TO  API012SUB1-RATE
                   WHEN    SPACE
                       CONTINUE
                   WHEN    OTHER
                       MOVE    1           TO  API012SUB1-ERRCD
               END-EVALUATE
      *        国保
               WHEN    "060"
               WHEN    "068"
               EVALUATE    API012SUB1-HOJOKBN
                   WHEN    "0"
                       MOVE    "無し"
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    00          TO  API012SUB1-RATE
                   WHEN    "1"
                       MOVE    "１割"
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    10          TO  API012SUB1-RATE
                   WHEN    "2"
                       MOVE    "２割"
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    20          TO  API012SUB1-RATE
                   WHEN    "3"
                       MOVE    "３割"
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    30          TO  API012SUB1-RATE
                   WHEN    "4"
                       MOVE    "外１割 入０割"
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    10          TO  API012SUB1-RATE
                   WHEN    "5"
                       MOVE    "外２割 入１割"
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    20          TO  API012SUB1-RATE
                   WHEN    "6"
                       MOVE    "外３割 入２割"
                                           TO  API012SUB1-HOJOKBN-NAME
                       MOVE    30          TO  API012SUB1-RATE
                   WHEN    SPACE
                       CONTINUE
                   WHEN    OTHER
                       MOVE    1           TO  API012SUB1-ERRCD
               END-EVALUATE
      *        治験
               WHEN    "900"
               WHEN    "901"
               EVALUATE    API012SUB1-HOJOKBN
                   WHEN    "1"
                       MOVE    "課税"
                                           TO  API012SUB1-HOJOKBN-NAME
                   WHEN    "2"
                       MOVE    "非課税"
                                           TO  API012SUB1-HOJOKBN-NAME
                   WHEN    OTHER
                       MOVE    1           TO  API012SUB1-ERRCD
               END-EVALUATE
      *        自費
               WHEN    "980"   THRU   "989"
               EVALUATE    API012SUB1-HOJOKBN
                   WHEN    "1"
                       MOVE    "課税"
                                           TO  API012SUB1-HOJOKBN-NAME
                   WHEN    "2"
                       MOVE    "非課税"
                                           TO  API012SUB1-HOJOKBN-NAME
                   WHEN    OTHER
                       MOVE    1           TO  API012SUB1-ERRCD
               END-EVALUATE
      *
               WHEN    OTHER
                   IF      API012SUB1-HKNNUM(1:1)  =   "9"
                       CONTINUE
                   ELSE
      *            協会等
                   EVALUATE    API012SUB1-HOJOKBN
                       WHEN    "9"
                           MOVE    "１割" 
                                           TO  API012SUB1-HOJOKBN-NAME
                           MOVE    10      TO  API012SUB1-RATE
                       WHEN    "8"
                           MOVE    "２割" 
                                           TO  API012SUB1-HOJOKBN-NAME
                           MOVE    20      TO  API012SUB1-RATE
                       WHEN    "7"
                           MOVE    "３割" 
                                           TO  API012SUB1-HOJOKBN-NAME
                           MOVE    30      TO  API012SUB1-RATE
                       WHEN    SPACE
                           CONTINUE
                       WHEN    OTHER
                           MOVE    1           TO  API012SUB1-ERRCD
                   END-EVALUATE
                   END-IF
           END-EVALUATE
      *
           .
       100-HAKKOU-EXT.
           EXIT.
      *
      *
      *
