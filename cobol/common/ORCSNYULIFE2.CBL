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
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCSNYULIFE2.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院
      *  コンポーネント名  : 入院時生活療養費負担額取得サブ
      *                      （平成２８年４月改正対応）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  16/02/17    NACL−小豆沢  新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  03.05.00    NACL-太田    07/05/10  グループ診療対応
      *              NACL-小豆沢  07/07/12  患者所得情報の取得をサブ
      *                                     ルーチンに変更
      *  04.01.00    NACL-小豆沢  07/12/17  短期滞在手術基本料２の入院
      *                                     翌日食事算定対応
      *平成２０年４月改定対応
      *  04.02.00    NACL-小豆沢  08/03/05  後期高齢者の判定変更
      *                                     生活療養の入院料判定追加
      *                                       短期滞在手術基本料３
      *                                       回復期リハビリテーション病棟入院料１
      *                                       回復期リハビリテーション病棟入院料２
      *  04.02.00    NACL-小豆沢  08/04/11  後期高齢者の判定をサブルーチン使用
      *                                     に変更
      *  04.02.00    NACL-小豆沢  08/05/02  特別入院基本料算定時にＡＤＬ入力から
      *                                     医療度の高い患者を判定
      *平成２７年１月難病対応
      *  04.07.00    NACL-小豆沢  15/06/02  地域包括ケア病棟入院料及び
      *                                     地域包括ケア入院医療管理料の
      *                                     算定で難病公費の算定時に
      *                                     医療度の高い患者とする判定追加
      *平成２８年４月改正対応
      *  04.08.00    NACL-小豆沢  16/02/17  ORCSNYULIFE.CBL -->  ORCSNYULIFE2.CBL
      *                                   ・経腸栄養対応の為、食事の返却を
      *                                     朝昼夕に分割
      *                                   ・難病、又は小児慢性特定疾患は
      *                                     医療度の高い患者とする
      *平成２９年１０月改正対応
      *  05.00.00    NACL-小豆沢  17/08/16  居住費金額変更対応
      *                                     境界層対応
      *                                     生活療養負担コード分割対応
      *  05.00.00    NACL-小豆沢  17/08/24  特定入院料の算定要件外で算定
      *                                     する療養病棟入院基本料Ｉの
      *                                     コード判定追加
      *  05.00.00    NACL-小豆沢  17/11/22  患者年齢６３歳以下は生活療養
      *                                     対象外のリターンコード返却
      *平成３０年４月改正対応
      *  05.00.00    NACL-小豆沢  18/02/27  生活療養食事負担額変更対応
      *                                     居住費負担額変更対応
      *  05.00.00    NACL-小豆沢  18/03/07  生活療養の医療度判定変更
      *  05.00.00    NACL-小豆沢  18/11/14  難病判定に急性増悪による転棟
      *                                     のシステム予約コード入力追加
      *****************************************************************
      *
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                        DIVISION.
      *FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-NYUINACCT               PIC 9(01).
           03  FLG-NYUINACT                PIC 9(01).
           03  FLG-PTINF                   PIC 9(01).
           03  FLG-PTHKNINF                PIC 9(01).
           03  FLG-PTKOHINF                PIC 9(01).
           03  FLG-SYSKANRI                PIC 9(01).
           03  FLG-OK                      PIC 9(01).
           03  FLG-RJN                     PIC 9(01).
           03  FLG-SEI                     PIC 9(01).
           03  FLG-PTNYUINRRK              PIC 9(01).
           03  FLG-HKNCOMBI                PIC 9(01).
           03  FLG-NANBYO                  PIC 9(01).
      *    添字領域
       01  IDX-AREA.
           03  IDX                         PIC 9(04).
           03  IDX1                        PIC 9(04).
           03  TSY90-IDX                   PIC 9(02).
           03  IDX-RJN                     PIC 9(02).
           03  IDX-SEI                     PIC 9(04).
           03  IDX-SEI2                    PIC 9(04).
           03  IDX-T                       PIC 9(04).
           03  IDX-ST                      PIC 9(02).
           03  IDX-ED                      PIC 9(02).
      *
      *    コンスタント値
      *    平成２８年度改定生活療養判定用
      *  （医療度の高い生活療養を上位にまとめているので、データの並びに注意すること）
      *  （特別入院基本料は特別な判定があることからデータの最後とする）
       01  TBL-H28-SEIKATSU-AREA.
      *  医療度の高い生活療養
      *    回復期リハビリテーション病棟入院料１（生活療養）
           03   FILLER                     PIC X(09) VALUE "190150210".
      *    回復期リハビリテーション病棟入院料２（生活療養）
           03   FILLER                     PIC X(09) VALUE "190141710".
      *    回復期リハビリテーション病棟入院料３（生活療養）
           03   FILLER                     PIC X(09) VALUE "190141910".
      *    短期滞在手術基本料２（生活療養）
           03   FILLER                     PIC X(09) VALUE "190125310".
      *    有床診療所療養病床入院基本料Ａ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190124310".
      *    有床診療所療養病床入院基本料Ｂ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190124410".
      *    有床診療所療養病床入院基本料Ｃ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190124510".
      *    療養病床以外・有床診療所療養病床入院Ａ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190155410".
      *    療養病床以外・有床診療所療養病床入院Ｂ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190155810".
      *10  療養病床以外・有床診療所療養病床入院Ｃ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190156210".
      *    療養病棟入院基本料１（入院基本料Ａ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190123710".
      *    療養病棟入院基本料１（入院基本料Ｂ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190123810".
      *    療養病棟入院基本料１（入院基本料Ｃ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190123910".
      *    療養病棟入院基本料１（入院基本料Ｄ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190124010".
      *    療養病棟入院基本料１（入院基本料Ｅ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190124110".
      *    療養病棟入院基本料１（入院基本料Ｆ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190131710".
      *    療養病棟入院基本料２（入院基本料Ａ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190132510".
      *    療養病棟入院基本料２（入院基本料Ｂ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190132710".
      *    療養病棟入院基本料２（入院基本料Ｃ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190132910".
      *20  療養病棟入院基本料２（入院基本料Ｄ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190133110".
      *    療養病棟入院基本料２（入院基本料Ｅ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190133310".
      *    療養病棟入院基本料２（入院基本料Ｆ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190133510".
      *    療養病棟入院基本料２（入院基本料Ａ）（生活療養）（夜勤時間超過減算）
           03   FILLER                     PIC X(09) VALUE "190166210".
      *    療養病棟入院基本料２（入院基本料Ｂ）（生活療養）（夜勤時間超過減算）
           03   FILLER                     PIC X(09) VALUE "190166410".
      *    療養病棟入院基本料２（入院基本料Ｃ）（生活療養）（夜勤時間超過減算）
           03   FILLER                     PIC X(09) VALUE "190166610".
      *    療養病棟入院基本料２（入院基本料Ｄ）（生活療養）（夜勤時間超過減算）
           03   FILLER                     PIC X(09) VALUE "190166810".
      *    療養病棟入院基本料２（入院基本料Ｅ）（生活療養）（夜勤時間超過減算）
           03   FILLER                     PIC X(09) VALUE "190167010".
      *    療養病棟入院基本料２（入院基本料Ｆ）（生活療養）（夜勤時間超過減算）
           03   FILLER                     PIC X(09) VALUE "190167210".
      *    療養病棟入院基本料２（入院基本料Ａ）（生活療養）（看護職員数等経過措置）
           03   FILLER                     PIC X(09) VALUE "190183810".
      *30  療養病棟入院基本料２（入院基本料Ｂ）（生活療養）（看護職員数等経過措置）
           03   FILLER                     PIC X(09) VALUE "190184010".
      *    療養病棟入院基本料２（入院基本料Ｃ）（生活療養）（看護職員数等経過措置）
           03   FILLER                     PIC X(09) VALUE "190184210".
      *    療養病棟入院基本料２（入院基本料Ｄ）（生活療養）（看護職員数等経過措置）
           03   FILLER                     PIC X(09) VALUE "190184410".
      *    療養病棟入院基本料２（入院基本料Ｅ）（生活療養）（看護職員数等経過措置）
           03   FILLER                     PIC X(09) VALUE "190184610".
      *    療養病棟入院基本料２（入院基本料Ｆ）（生活療養）（看護職員数等経過措置）
           03   FILLER                     PIC X(09) VALUE "190184810".
      *    療養病棟入院基本料２（入院基本料Ａ）（生活療養）（夜勤時間特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190185610".
      *    療養病棟入院基本料２（入院基本料Ｂ）（生活療養）（夜勤時間特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190185810".
      *    療養病棟入院基本料２（入院基本料Ｃ）（生活療養）（夜勤時間特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190186010".
      *    療養病棟入院基本料２（入院基本料Ｄ）（生活療養）（夜勤時間特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190186210".
      *    療養病棟入院基本料２（入院基本料Ｅ）（生活療養）（夜勤時間特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190186410".
      *40  療養病棟入院基本料２（入院基本料Ｆ）（生活療養）（夜勤時間特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190186610".
      *
      *  医療度の高くない生活療養
      *41  有床診療所療養病床入院基本料Ｄ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190124610".
      *    有床診療所療養病床入院基本料Ｅ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190124710".
      *    療養病床以外・有床診療所療養病床入院Ｄ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190156610".
      *    療養病床以外・有床診療所療養病床入院Ｅ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190157010".
      *    療養病棟入院基本料１（入院基本料Ｇ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190131910".
      *    療養病棟入院基本料１（入院基本料Ｈ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190132110".
      *    療養病棟入院基本料１（入院基本料Ｉ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190132310".
      *    療養病棟入院基本料２（入院基本料Ｇ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190133710".
      *    療養病棟入院基本料２（入院基本料Ｈ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190133910".
      *50  療養病棟入院基本料２（入院基本料Ｉ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190134110".
      *    療養病棟入院基本料２（入院基本料Ｇ）（生活療養）（夜勤時間超過減算）
           03   FILLER                     PIC X(09) VALUE "190167410".
      *    療養病棟入院基本料２（入院基本料Ｈ）（生活療養）（夜勤時間超過減算）
           03   FILLER                     PIC X(09) VALUE "190167610".
      *    療養病棟入院基本料２（入院基本料Ｉ）（生活療養）（夜勤時間超過減算）
           03   FILLER                     PIC X(09) VALUE "190167810".
      *    療養病棟入院基本料２（入院基本料Ｇ）（生活療養）（看護職員数等経過措置）
           03   FILLER                     PIC X(09) VALUE "190185010".
      *    療養病棟入院基本料２（入院基本料Ｈ）（生活療養）（看護職員数等経過措置）
           03   FILLER                     PIC X(09) VALUE "190185210".
      *    療養病棟入院基本料２（入院基本料Ｉ）（生活療養）（看護職員数等経過措置）
           03   FILLER                     PIC X(09) VALUE "190185410".
      *    療養病棟入院基本料２（入院基本料Ｇ）（生活療養）（夜勤時間特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190186810".
      *    療養病棟入院基本料２（入院基本料Ｈ）（生活療養）（夜勤時間特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190187010".
      *    療養病棟入院基本料２（入院基本料Ｉ）（生活療養）（夜勤時間特別入院基本料）
           03   FILLER                     PIC X(09) VALUE "190187210".
      *60  短手３
           03   FILLER                     PIC X(09) VALUE "190177710".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190177910".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190178110".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190178310".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190178510".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190178710".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190178910".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190179110".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190179310".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190179510".
      *70  短手３
           03   FILLER                     PIC X(09) VALUE "190179710".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190179910".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190180110".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190180310".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190180510".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190180710".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190180910".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190181110".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190181310".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190181510".
      *80  短手３
           03   FILLER                     PIC X(09) VALUE "190181710".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190181910".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190182110".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190196010".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190196210".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190196410".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190196810".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190196910".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190197010".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190197410".
      *90  短手３
           03   FILLER                     PIC X(09) VALUE "190197510".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190197610".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190197810".
      *93  短手３
           03   FILLER                     PIC X(09) VALUE "190198010".
      *94  地域包括ケア病棟入院料１（生活療養）
           03   FILLER                     PIC X(09) VALUE "190175410".
      *    地域包括ケア入院医療管理料１（生活療養）
           03   FILLER                     PIC X(09) VALUE "190175610".
      *    地域包括ケア病棟入院料２（生活療養）
           03   FILLER                     PIC X(09) VALUE "190175810".
      *    地域包括ケア入院医療管理料２（生活療養）
           03   FILLER                     PIC X(09) VALUE "190176010".
      *    地域包括ケア病棟入院料１（生活療養）（特定地域）
           03   FILLER                     PIC X(09) VALUE "190176210".
      *    地域包括ケア入院医療管理料１（生活療養）（特定地域）
           03   FILLER                     PIC X(09) VALUE "190176410".
      *    地域包括ケア病棟入院料２（生活療養）（特定地域）
           03   FILLER                     PIC X(09) VALUE "190176610".
      *101 地域包括ケア入院医療管理料２（生活療養）（特定地域）
           03   FILLER                     PIC X(09) VALUE "190176810".
      *
      *102 有床診療所療養病床入院基本料（特別入院基本料）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190124810".
      *103 療養病棟入院基本料（特別入院基本料）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190124210".
      *
       01  TBL-H28-SEIKATSU-R     REDEFINES  TBL-H28-SEIKATSU-AREA.
           03   TBL-H28-SEISRYCD           PIC X(09)  OCCURS  103.
      *
      *
      *    平成３０年度改定生活療養判定用
      *  （医療度の高い生活療養を上位にまとめているので、データの並びに注意すること）
      *  （特別入院基本料は特別な判定があることからデータの最後とする）
       01  TBL-H30-SEIKATSU-AREA.
      *  医療度の高い生活療養
      *    回復期リハビリテーション病棟入院料１（生活療養）
           03   FILLER                     PIC X(09) VALUE "190208010".
      *    回復期リハビリテーション病棟入院料２（生活療養）
           03   FILLER                     PIC X(09) VALUE "190208210".
      *    回復期リハビリテーション病棟入院料３（生活療養）
           03   FILLER                     PIC X(09) VALUE "190208410".
      *    回復期リハビリテーション病棟入院料４（生活療養）
           03   FILLER                     PIC X(09) VALUE "190208610".
      *    回復期リハビリテーション病棟入院料５（生活療養）
           03   FILLER                     PIC X(09) VALUE "190208810".
      *    回復期リハビリテーション病棟入院料６（生活療養）
           03   FILLER                     PIC X(09) VALUE "190209010".
      *    短期滞在手術基本料２（生活療養）
           03   FILLER                     PIC X(09) VALUE "190125310".
      *    有床診療所療養病床入院基本料Ａ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190124310".
      *    有床診療所療養病床入院基本料Ｂ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190124410".
      *10  有床診療所療養病床入院基本料Ｃ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190124510".
      *    療養病床以外・有床診療所療養病床入院Ａ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190155410".
      *    療養病床以外・有床診療所療養病床入院Ｂ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190155810".
      *    療養病床以外・有床診療所療養病床入院Ｃ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190156210".
      *    療養病棟入院料１（入院料Ａ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190123710".
      *    療養病棟入院料１（入院料Ｂ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190123810".
      *    療養病棟入院料１（入院料Ｃ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190123910".
      *    療養病棟入院料１（入院料Ｄ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190124010".
      *    療養病棟入院料１（入院料Ｅ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190124110".
      *    療養病棟入院料１（入院料Ｆ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190131710".
      *20  療養病棟入院料２（入院料Ａ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190132510".
      *    療養病棟入院料２（入院料Ｂ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190132710".
      *    療養病棟入院料２（入院料Ｃ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190132910".
      *    療養病棟入院料２（入院料Ｄ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190133110".
      *    療養病棟入院料２（入院料Ｅ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190133310".
      *    療養病棟入院料２（入院料Ｆ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190133510".
      *    療養病棟入院料２（入院料Ａ）（生活療養）（経過措置２）
           03   FILLER                     PIC X(09) VALUE "190202610".
      *    療養病棟入院料２（入院料Ｂ）（生活療養）（経過措置２）
           03   FILLER                     PIC X(09) VALUE "190202810".
      *    療養病棟入院料２（入院料Ｃ）（生活療養）（経過措置２）
           03   FILLER                     PIC X(09) VALUE "190203010".
      *    療養病棟入院料２（入院料Ｄ）（生活療養）（経過措置２）
           03   FILLER                     PIC X(09) VALUE "190203210".
      *30  療養病棟入院料２（入院料Ｅ）（生活療養）（経過措置２）
           03   FILLER                     PIC X(09) VALUE "190203410".
      *    療養病棟入院料２（入院料Ｆ）（生活療養）（経過措置２）
           03   FILLER                     PIC X(09) VALUE "190203610".
      *    療養病棟入院料２（入院基本料Ａ）（生活療養）（経過措置１）
           03   FILLER                     PIC X(09) VALUE "190215210".
      *    療養病棟入院料２（入院基本料Ｂ）（生活療養）（経過措置１）
           03   FILLER                     PIC X(09) VALUE "190215410".
      *    療養病棟入院料２（入院基本料Ｃ）（生活療養）（経過措置１）
           03   FILLER                     PIC X(09) VALUE "190215610".
      *    療養病棟入院料２（入院基本料Ｄ）（生活療養）（経過措置１）
           03   FILLER                     PIC X(09) VALUE "190215810".
      *    療養病棟入院料２（入院基本料Ｅ）（生活療養）（経過措置１）
           03   FILLER                     PIC X(09) VALUE "190216010".
      *37  療養病棟入院料２（入院基本料Ｆ）（生活療養）（経過措置１）
           03   FILLER                     PIC X(09) VALUE "190216210".
      *
      *  医療度の高くない生活療養
      *38  有床診療所療養病床入院基本料Ｄ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190124610".
      *    有床診療所療養病床入院基本料Ｅ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190124710".
      *40  療養病床以外・有床診療所療養病床入院Ｄ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190156610".
      *    療養病床以外・有床診療所療養病床入院Ｅ（生活療養）
           03   FILLER                     PIC X(09) VALUE "190157010".
      *    療養病棟入院料１（入院料Ｇ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190131910".
      *    療養病棟入院料１（入院料Ｈ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190132110".
      *    療養病棟入院料１（入院料Ｉ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190132310".
      *    療養病棟入院料２（入院料Ｇ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190133710".
      *    療養病棟入院料２（入院料Ｈ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190133910".
      *    療養病棟入院料２（入院料Ｉ）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190134110".
      *    療養病棟入院料２（入院料Ｇ）（生活療養）（経過措置２）
           03   FILLER                     PIC X(09) VALUE "190203810".
      *    療養病棟入院料２（入院料Ｈ）（生活療養）（経過措置２）
           03   FILLER                     PIC X(09) VALUE "190204010".
      *50  療養病棟入院料２（入院料Ｉ）（生活療養）（経過措置２）
           03   FILLER                     PIC X(09) VALUE "190204210".
      *    療養病棟入院料２（入院料Ｉ）（生活療養）（経過措置２・通則８）
           03   FILLER                     PIC X(09) VALUE "190204410".
      *    療養病棟入院料２（入院料Ｇ）（生活療養）（経過措置１）
           03   FILLER                     PIC X(09) VALUE "190216410".
      *    療養病棟入院料２（入院料Ｈ）（生活療養）（経過措置１）
           03   FILLER                     PIC X(09) VALUE "190216610".
      *    療養病棟入院料２（入院料Ｉ）（生活療養）（経過措置１）
           03   FILLER                     PIC X(09) VALUE "190216810".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190178110".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190178310".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190178510".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190178910".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190179110".
      *60  短手３
           03   FILLER                     PIC X(09) VALUE "190179310".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190179710".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190179910".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190180110".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190180310".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190180710".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190181110".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190181310".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190181510".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190181710".
      *70  短手３
           03   FILLER                     PIC X(09) VALUE "190181910".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190182110".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190196010".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190196410".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190196810".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190196910".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190197010".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190197410".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190197510".
      *    短手３
           03   FILLER                     PIC X(09) VALUE "190197610".
      *80  短手３
           03   FILLER                     PIC X(09) VALUE "190197810".
      *81  短手３
           03   FILLER                     PIC X(09) VALUE "190198010".
      *82  地域包括ケア病棟入院料１（生活療養）
           03   FILLER                     PIC X(09) VALUE "190209210".
      *    地域包括ケア入院医療管理料１（生活療養）
           03   FILLER                     PIC X(09) VALUE "190209410".
      *    地域包括ケア病棟入院料２（生活療養）
           03   FILLER                     PIC X(09) VALUE "190209610".
      *    地域包括ケア入院医療管理料２（生活療養）
           03   FILLER                     PIC X(09) VALUE "190209810".
      *    地域包括ケア病棟入院料３（生活療養）
           03   FILLER                     PIC X(09) VALUE "190210010".
      *    地域包括ケア入院医療管理料３（生活療養）
           03   FILLER                     PIC X(09) VALUE "190210210".
      *    地域包括ケア病棟入院料４（生活療養）
           03   FILLER                     PIC X(09) VALUE "190210410".
      *    地域包括ケア入院医療管理料４（生活療養）
           03   FILLER                     PIC X(09) VALUE "190210610".
      *90  地域包括ケア病棟入院料１（生活療養）（特定地域）
           03   FILLER                     PIC X(09) VALUE "190210810".
      *    地域包括ケア入院医療管理料１（生活療養）（特定地域）
           03   FILLER                     PIC X(09) VALUE "190211010".
      *    地域包括ケア病棟入院料２（生活療養）（特定地域）
           03   FILLER                     PIC X(09) VALUE "190211210".
      *    地域包括ケア入院医療管理料２（生活療養）（特定地域）
           03   FILLER                     PIC X(09) VALUE "190211410".
      *    地域包括ケア病棟入院料３（生活療養）（特定地域）
           03   FILLER                     PIC X(09) VALUE "190211610".
      *    地域包括ケア入院医療管理料３（生活療養）（特定地域）
           03   FILLER                     PIC X(09) VALUE "190211810".
      *    地域包括ケア病棟入院料４（生活療養）（特定地域）
           03   FILLER                     PIC X(09) VALUE "190212010".
      *97  地域包括ケア入院医療管理料４（生活療養）（特定地域）
           03   FILLER                     PIC X(09) VALUE "190212210".
      *
      *98  有床診療所療養病床入院基本料（特別入院基本料）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190124810".
      *99  療養病棟入院基本料（特別入院基本料）（生活療養）
           03   FILLER                     PIC X(09) VALUE "190124210".
      *
       01  TBL-H30-SEIKATSU-R     REDEFINES  TBL-H30-SEIKATSU-AREA.
           03   TBL-H30-SEISRYCD           PIC X(09)  OCCURS  99.
      *
      *
      *    一時領域
       01  WRK-AREA.
      *
           03  WRK-YMD.
               05  WRK-YYMM                PIC X(06).
               05  WRK-DD                  PIC 9(02).
           03  WRK-RJN-TBL.
               05  WRK-RJN                 PIC 9(01)   OCCURS   31.
      *    救急搬送診療料を算定し、かつ、入院料未算定の日
           03  WRK-KYUKYU-DAY              PIC 9(02).
           03  WRK-KYUKYU-YMD              PIC X(08).
           03  WRK-KYUKYU-NYUINCD          PIC X(09).
      *
      *    保険組合せ退避
           03  WRK-NYUIN-TABLE.
               05  WRK-NYUIN-TBL           OCCURS  31.
                   07  WRK-HKNCOMBI-DAY    PIC 9(03).
      *    算定要件外区分退避
           03  WRK-SANTEIYOUKENKBN-TABLE.
               05  WRK-SANTEIYOUKENKBN     PIC X(01)  OCCURS  31.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK5000.INC".
      *
      *    入院診療会計マスタ−
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    入院診療行為マスター
       01  NYUINACT-REC.
           COPY    "CPNYUINACT.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    患者公費情報マスタ−
       01  PTKOHINF-REC.
           COPY    "CPPTKOHINF.INC".
      *
      *    患者保険情報マスタ−
       01  PTHKNINF-REC.
           COPY    "CPPTHKNINF.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    年金
       01  TNKRRK-REC.
           COPY    "CPTNKRRK.INC".
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    保険算定用年齢・割合計算サブ
           COPY    "CPORCSAGECHK.INC".
      *
      *    患者所得情報編集サブ
           COPY    "CPORCSSYOTOKU.INC".
      *
      *    入院料未算定日取得サブ
           COPY    "CPORCSNYUINDAY.INC".
      *
      *    医療区分取得サブ
           COPY    "CPORCSS008.INC".
      *
      *    特定入院料コード取得サブ
           COPY  "CPORCSTOKNYUIN.INC".
      *
      *    食事負担据え置き対象取得パラメタ
           COPY    "CPORCSSKJKEEP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    入院会計作成用パラメタ
           COPY    "CPORCSNYULIFE2.INC".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
       PROCEDURE                   DIVISION    USING
           ORCSNYULIFE2-AREA
           SPA-AREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  LNK-NYULIFE2-HENKYAKU-AREA
           MOVE    ZERO                TO  LNK-NYULIFE2-RC
      *
      *    パラメータチェック
           PERFORM 100-PRM-CHK-SEC
           IF    ( LNK-NYULIFE2-RC       NOT =   ZERO )
               GO  TO  000-PROC-EXT
           END-IF
      *
      *    主処理
           IF      LNK-NYULIFE2-RC      =    ZERO
               PERFORM 200-MAIN-SEC
           END-IF
      *
      **     PERFORM    VARYING IDX   FROM   1   BY  1
      **                UNTIL IDX   >   31
      **       DISPLAY "IDX = " IDX
      **       DISPLAY "LNK-NYULIFE2-KBN = " LNK-NYULIFE2-KBN(IDX)
      **       DISPLAY "LNK-NYULIFE2-FTNKBN2 = " LNK-NYULIFE2-FTNKBN2(IDX)
      **       PERFORM   VARYING   IDX-T   FROM  1  BY  1
      **         UNTIL   IDX-T   >   3
      **         DISPLAY "IDX-T = " IDX-T
      **         DISPLAY "LNK-NYULIFE2-SKJ-SRYCD =" LNK-NYULIFE2-SKJ-SRYCD
      **                                                      (IDX IDX-T)
      **         DISPLAY "LNK-NYULIFE2-SKJ-MONEY =" LNK-NYULIFE2-SKJ-MONEY
      **                                                      (IDX IDX-T)
      **       END-PERFORM
      **     END-PERFORM
           .
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    パラメータチェック
      *****************************************************************
       100-PRM-CHK-SEC                     SECTION.
      *
      *    算定年月チェック
           IF     (LNK-NYULIFE2-SANTEIYM    =   SPACE)   OR
                  (LNK-NYULIFE2-SANTEIYM    <=  "201603")
               MOVE    1               TO  LNK-NYULIFE2-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *    患者マスター検索
           INITIALIZE                       PTINF-REC
           MOVE    LNK-NYULIFE2-HOSPNUM  TO  PTINF-HOSPNUM
           MOVE    LNK-NYULIFE2-PTID     TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           IF      FLG-PTINF            NOT =   ZERO
               MOVE    2                TO  LNK-NYULIFE2-RC
               GO  TO  100-PRM-CHK-EXT
           ELSE
      *        保険年齢のチェック（入院会計マスター検索）
               INITIALIZE                   ORCSAGECHKAREA
               MOVE    LNK-NYULIFE2-HOSPNUM  TO  AGECHK-HOSPNUM
               MOVE    LNK-NYULIFE2-PTID     TO  AGECHK-PTID
               MOVE    LNK-NYULIFE2-SANTEIYM TO  AGECHK-SRYYMD(1:6)
               MOVE    "01"                  TO  AGECHK-SRYYMD(7:2)
               MOVE    PTINF-BIRTHDAY        TO  AGECHK-BIRTHDAY
               CALL   "ORCSAGECHK"    USING      ORCSAGECHKAREA
                                                 SPA-AREA
               IF      AGECHK-NENREI         <=  63
                   MOVE    4                TO  LNK-NYULIFE2-RC
                   GO  TO  100-PRM-CHK-EXT
               END-IF
           END-IF
      *
      *    入院中のチェック（入院会計マスター検索）
           INITIALIZE                      NYUINACCT-REC
           MOVE    LNK-NYULIFE2-HOSPNUM  TO  NACCT-HOSPNUM
           MOVE    LNK-NYULIFE2-PTID     TO  NACCT-PTID
           MOVE    LNK-NYULIFE2-SANTEIYM TO  NACCT-SRYYM
           MOVE    "5"                  TO  NACCT-ZAISKBKBN
           MOVE    "tbl_nyuinacct"      TO  MCP-TABLE
           MOVE    "key17"              TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT        NOT =   ZERO
               MOVE    3                TO  LNK-NYULIFE2-RC
           ELSE
               MOVE    "tbl_nyuinacct"  TO  MCP-TABLE
               MOVE    "key17"          TO  MCP-PATHNAME
               PERFORM 910-NYUINACCT-READ-SEC
               IF   FLG-NYUINACCT       =   ZERO
      *             難病公費判定用に保険組合せ番号を退避
                    PERFORM    VARYING   IDX1   FROM   1   BY   1
                               UNTIL     IDX1   >      31
                        MOVE   NACCT-DAY (IDX1) TO 
                                            WRK-HKNCOMBI-DAY(IDX1)
                    END-PERFORM
               ELSE
                    MOVE    3           TO  LNK-NYULIFE2-RC
               END-IF
           END-IF
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
           .
       100-PRM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    主取得
      *****************************************************************
       200-MAIN-SEC            SECTION.
      *
      *    医療区分取得サブの呼出し（特別入院基本料算定時の医療区分判定用）
           INITIALIZE                      SS008-AREA
           MOVE    LNK-NYULIFE2-HOSPNUM     TO  SPA-HOSPNUM
           MOVE    LNK-NYULIFE2-PTID        TO  SPA-PTID
           MOVE    LNK-NYULIFE2-SANTEIYM    TO  SS008-SRYYM
           CALL   "ORCSS008"       USING   SS008-AREA
                                           SPA-AREA
      *
      *    救急搬送診療料を算定し、かつ、入院料未算定の日を特定し、
      *    該当日の食事が生活療養に該当するか判定（サブプロより取得）
           MOVE    ZERO                    TO  WRK-KYUKYU-DAY
           MOVE    SPACE                   TO  WRK-KYUKYU-YMD
           INITIALIZE                          ORCSNYUINDAY-AREA
           MOVE    LNK-NYULIFE2-HOSPNUM     TO  LNK-NYUINDAY-HOSPNUM
           MOVE    LNK-NYULIFE2-PTID        TO  LNK-NYUINDAY-PTID
           MOVE    LNK-NYULIFE2-SANTEIYM    TO  LNK-NYUINDAY-SANTEIYM
           CALL    "ORCSNYUINDAY"      USING   ORCSNYUINDAY-AREA
                                               SPA-AREA
           IF      LNK-NYUINDAY-RC         =   ZERO
                   PERFORM    VARYING   IDX1   FROM   1   BY   1
                      UNTIL   IDX1   >   31
                         IF   (LNK-NYUINDAY-KBN(IDX1)   =   "1")   AND
                              (LNK-NYUINDAY-KYUKYU-KBN(IDX1)   =   "1")
                             MOVE    IDX1  TO  WRK-KYUKYU-DAY
                             MOVE    LNK-NYULIFE2-SANTEIYM
                                           TO  WRK-KYUKYU-YMD(1:6)
                             MOVE    WRK-KYUKYU-DAY
                                           TO  WRK-KYUKYU-YMD(7:2)
                         END-IF
                   END-PERFORM
           END-IF
           IF   WRK-KYUKYU-DAY             NOT =   ZERO
      *      患者入院履歴から算定入院料の取得
             INITIALIZE                          PTNYUINRRK-REC
             MOVE   LNK-NYULIFE2-HOSPNUM   TO  PTNYUINRRK-HOSPNUM
             MOVE   LNK-NYULIFE2-PTID      TO  PTNYUINRRK-PTID
             MOVE   LNK-NYULIFE2-SANTEIYM  TO  PTNYUINRRK-TENNYUYMD(1:6)
             MOVE   "99"                   TO  PTNYUINRRK-TENNYUYMD(7:2)
             MOVE   LNK-NYULIFE2-SANTEIYM  TO  PTNYUINRRK-TENSTUYMD(1:6)
             MOVE   "01"                   TO  PTNYUINRRK-TENSTUYMD(7:2)
             MOVE   "tbl_ptnyuinrrk"       TO  MCP-TABLE
             MOVE   "key44"                TO  MCP-PATHNAME
             PERFORM 910-PTNYUINRRK-SELECT-SEC
             IF      FLG-PTNYUINRRK        =   ZERO
               MOVE    "tbl_ptnyuinrrk"    TO  MCP-TABLE
               MOVE    "key44"             TO  MCP-PATHNAME
               PERFORM 910-PTNYUINRRK-READ-SEC
               PERFORM  UNTIL  
                  ( FLG-PTNYUINRRK         =   1  )
      *
                   IF  (PTNYUINRRK-TENNYUYMD  <=  WRK-KYUKYU-YMD) AND
                       (WRK-KYUKYU-YMD        <=  PTNYUINRRK-TENSTUYMD)
      *               特定入院料コードをサブプロより取得
                      INITIALIZE             ORCSTOKNYUIN-AREA
                      MOVE  PTNYUINRRK-TOKUTEI-KBN
                                           TO  LNK-TOKNYUIN-KBN
                      MOVE  PTNYUINRRK-TOKUTEI-NYUIN
                                           TO  LNK-TOKNYUIN-NYUIN
                      MOVE  PTNYUINRRK-BTUNUM
                                           TO  LNK-TOKNYUIN-BTUNUM
                      MOVE  PTNYUINRRK-TOKU-SANTEIYOUKENKBN
                                       TO  LNK-TOKNYUIN-SANTEIYOUKENKBN
      *                DISPLAY "PTNYUINRRK-TOKU-SANTEIYOUKENKBN = "
      *                         PTNYUINRRK-TOKU-SANTEIYOUKENKBN
                      MOVE  WRK-KYUKYU-YMD(1:6)
                                           TO  LNK-TOKNYUIN-SANTEIYM
                      CALL  "ORCSTOKNYUIN"   USING    ORCSTOKNYUIN-AREA
                                                      SPA-AREA
                      IF    LNK-TOKNYUIN-RC   =    ZERO
                         IF    LNK-TOKNYUIN-GAI-SRYCD =  SPACE
                              MOVE   LNK-TOKNYUIN-SRYCD
                                           TO  WRK-KYUKYU-NYUINCD
                         ELSE
                              MOVE   LNK-TOKNYUIN-GAI-SRYCD
                                           TO  WRK-KYUKYU-NYUINCD
                         END-IF
                   END-IF
      *
                   END-IF
                   MOVE    "tbl_ptnyuinrrk"    TO  MCP-TABLE
                   MOVE    "key44"             TO  MCP-PATHNAME
                   PERFORM 910-PTNYUINRRK-READ-SEC
      *
               END-PERFORM
             END-IF
      *
             MOVE    "tbl_ptnyuinrrk"      TO  MCP-TABLE
             MOVE    "key44"               TO  MCP-PATHNAME
             PERFORM   900-CLOSE-SEC
           END-IF
      *
      *    患者入院履歴から特定入院料の算定要件区分取得
           MOVE   SPACE                  TO  WRK-SANTEIYOUKENKBN-TABLE
           INITIALIZE                        PTNYUINRRK-REC
           MOVE   LNK-NYULIFE2-HOSPNUM   TO  PTNYUINRRK-HOSPNUM
           MOVE   LNK-NYULIFE2-PTID      TO  PTNYUINRRK-PTID
           MOVE   LNK-NYULIFE2-SANTEIYM  TO  PTNYUINRRK-TENNYUYMD(1:6)
           MOVE   "99"                   TO  PTNYUINRRK-TENNYUYMD(7:2)
           MOVE   LNK-NYULIFE2-SANTEIYM  TO  PTNYUINRRK-TENSTUYMD(1:6)
           MOVE   "01"                   TO  PTNYUINRRK-TENSTUYMD(7:2)
           MOVE   "tbl_ptnyuinrrk"       TO  MCP-TABLE
           MOVE   "key44"                TO  MCP-PATHNAME
           PERFORM 910-PTNYUINRRK-SELECT-SEC
           IF      FLG-PTNYUINRRK        =   ZERO
             MOVE    "tbl_ptnyuinrrk"    TO  MCP-TABLE
             MOVE    "key44"             TO  MCP-PATHNAME
             PERFORM 910-PTNYUINRRK-READ-SEC
             PERFORM  UNTIL   ( FLG-PTNYUINRRK         =   1  )
      *
                IF (PTNYUINRRK-TENNYUYMD(1:6)  =  LNK-NYULIFE2-SANTEIYM)
                AND
                   (PTNYUINRRK-TENSTUYMD(1:6)  =  LNK-NYULIFE2-SANTEIYM)
                    MOVE   PTNYUINRRK-TENNYUYMD(7:2)   TO  IDX-ST
                    MOVE   PTNYUINRRK-TENSTUYMD(7:2)   TO  IDX-ED
                END-IF
                IF (PTNYUINRRK-TENNYUYMD(1:6)  <  LNK-NYULIFE2-SANTEIYM)
                AND
                   (PTNYUINRRK-TENSTUYMD(1:6)  =  LNK-NYULIFE2-SANTEIYM)
                    MOVE   1                           TO  IDX-ST
                    MOVE   PTNYUINRRK-TENSTUYMD(7:2)   TO  IDX-ED
                END-IF
                IF (PTNYUINRRK-TENNYUYMD(1:6)  =  LNK-NYULIFE2-SANTEIYM)
                AND
                   (PTNYUINRRK-TENSTUYMD(1:6)  >  LNK-NYULIFE2-SANTEIYM)
                    MOVE   PTNYUINRRK-TENNYUYMD(7:2)   TO  IDX-ST
                    MOVE   31                          TO  IDX-ED
                END-IF
                IF (PTNYUINRRK-TENNYUYMD(1:6)  <  LNK-NYULIFE2-SANTEIYM)
                AND
                   (PTNYUINRRK-TENSTUYMD(1:6)  >  LNK-NYULIFE2-SANTEIYM)
                    MOVE   1                           TO  IDX-ST
                    MOVE   31                          TO  IDX-ED
                END-IF
      *
      **          DISPLAY "IDX-ST = " IDX-ST
      **          DISPLAY "IDX-ED = " IDX-ED
      **          DISPLAY "PTNYUINRRK-TOKU-SANTEIYOUKENKBN = "
      **                   PTNYUINRRK-TOKU-SANTEIYOUKENKBN
                PERFORM    VARYING   IDX1  FROM   IDX-ST  BY  1
                  UNTIL   (IDX1    >  IDX-ED)
      **                DISPLAY "SET IDX1 = " IDX1
                      IF    PTNYUINRRK-TOKU-SANTEIYOUKENKBN  =  "1"
                         MOVE  "1"    TO  WRK-SANTEIYOUKENKBN(IDX1)
                      ELSE
                         MOVE  SPACE  TO  WRK-SANTEIYOUKENKBN(IDX1)
                      END-IF
                END-PERFORM
      *
                MOVE    "tbl_ptnyuinrrk"    TO  MCP-TABLE
                MOVE    "key44"             TO  MCP-PATHNAME
                PERFORM 910-PTNYUINRRK-READ-SEC
             END-PERFORM
           END-IF
      *
           MOVE     "tbl_ptnyuinrrk"      TO  MCP-TABLE
           MOVE     "key44"               TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *    食事負担据え置き対象取得サブ
           INITIALIZE                      ORCSSKJKEEP-AREA
           MOVE    LNK-NYULIFE2-HOSPNUM    TO  LNK-SKJKEEP-HOSPNUM
           MOVE    LNK-NYULIFE2-PTID       TO  LNK-SKJKEEP-PTID
           MOVE    LNK-NYULIFE2-SANTEIYM   TO  LNK-SKJKEEP-SANTEIYM
           CALL    "ORCSSKJKEEP"    USING      ORCSSKJKEEP-AREA
                                               SPA-AREA

      *    入院時生活療養費の該当日と軽減区分２（入院料判定）を取得
           MOVE    ZERO                    TO  FLG-OK
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-NYULIFE2-HOSPNUM    TO  NACCT-HOSPNUM
           MOVE    LNK-NYULIFE2-PTID       TO  NACCT-PTID
           MOVE    LNK-NYULIFE2-SANTEIYM   TO  NACCT-SRYYM
           MOVE    "1"                     TO  NACCT-ZAISKBKBN
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key17"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   UNTIL   (FLG-NYUINACCT    =   1)
                   IF    NACCT-SRYCDTOTAL     =    99999916
                       CONTINUE
                   ELSE
      *             （平成２８年４月から平成３０年３月まで）
                     IF  (LNK-NYULIFE2-SANTEIYM >=  "201604")  AND
                         (LNK-NYULIFE2-SANTEIYM <=  "201803")
      *                生活療養に該当する入院料を判定し、
      *                返却値の対象区分を設定する
                       PERFORM    210-NYUINACT-GET-SEC
                       MOVE       ZERO        TO   FLG-SEI
                                                   IDX-SEI2
                       PERFORM    VARYING   IDX-SEI  FROM 1  BY  1
                         UNTIL   (IDX-SEI   >  103)    OR
                                 (FLG-SEI   =    1)
                             IF  NSRY-SRYCD(1) = TBL-H28-SEISRYCD
                                                        (IDX-SEI)
                                 MOVE   1        TO   FLG-SEI
                                 MOVE   IDX-SEI  TO   IDX-SEI2
                             END-IF
                       END-PERFORM
                       IF   FLG-SEI    =    1
                          PERFORM    VARYING   IDX1   FROM   1   BY   1
                                  UNTIL     IDX1   >   31
                            IF     NACCT-DAY(IDX1)  NOT =  ZERO
                               MOVE   "1"    TO   LNK-NYULIFE2-KBN(IDX1)
                               MOVE    1     TO   FLG-OK
      *                        病状の程度、治療の内容をしん酌して標準
      *                        負担額を軽減する患者の判定（入院料判断）
                               IF  (IDX-SEI2   >=   1 )   AND
                                   (IDX-SEI2   <=   40)
                                   MOVE   "1"   TO   
                                             LNK-NYULIFE2-FTNKBN2(IDX1)
                               END-IF
      *                        難病公費の判定追加（以下入院料の場合のみ）
      *                        ・地域包括ケア病棟入院料
      *                        ・地域包括ケア入院医療管理料
                               IF  (IDX-SEI2   >=   94)   AND
                                   (IDX-SEI2   <=  101)
      *                          難病公費を使用されているか判定
                                 MOVE   ZERO       TO   FLG-NANBYO
                                 IF  WRK-HKNCOMBI-DAY(IDX1) NOT =  ZERO
                                     INITIALIZE            HKNCOMBI-REC
                                     MOVE   LNK-NYULIFE2-HOSPNUM
                                                   TO  COMB-HOSPNUM
                                     MOVE   LNK-NYULIFE2-PTID 
                                                   TO  COMB-PTID
                                     MOVE   WRK-HKNCOMBI-DAY(IDX1)
                                                   TO  COMB-HKNCOMBINUM
                                     MOVE   "tbl_hkncombi"
                                                   TO  MCP-TABLE
                                     MOVE    "key" TO  MCP-PATHNAME
                                     PERFORM 910-HKNCOMBI-SELECT-SEC
                                     IF   FLG-HKNCOMBI      =   ZERO
                                       MOVE  "tbl_hkncombi"
                                                   TO  MCP-TABLE
                                       MOVE  "key"  TO  MCP-PATHNAME
                                       PERFORM   910-HKNCOMBI-READ-SEC
                                       IF  FLG-HKNCOMBI         =  ZERO
                                         IF  (COMB-KOHHKNNUM(1) = "054")
                                          OR (COMB-KOHHKNNUM(2) = "054")
                                          OR (COMB-KOHHKNNUM(3) = "054")
                                          OR (COMB-KOHHKNNUM(4) = "054")
                                             MOVE  1    TO   FLG-NANBYO
                                         END-IF
                                       END-IF
                                     END-IF
      *                              保険組合せクローズ
                                     MOVE    "tbl_hkncombi"
                                                        TO  MCP-TABLE
                                     MOVE    "key"      TO  MCP-PATHNAME
                                     PERFORM   900-CLOSE-SEC
                                 END-IF
      *
                                 IF   FLG-NANBYO  =   1
                                   MOVE   "1"   TO   
                                             LNK-NYULIFE2-FTNKBN2(IDX1)
                                 END-IF
                               END-IF
      *                        病状の程度、治療の内容をしん酌して標準
      *                        負担額を軽減する患者の判定（特別入院基本料算定時の
      *                                                    ＡＤＬ入力判断）
                               IF (IDX-SEI2   =  102  OR 103)    AND
                                  (SS008-MEDKBNDAY(IDX1)  =  "2" OR
                                                             "3" )
                                   MOVE   "1"   TO   
                                             LNK-NYULIFE2-FTNKBN2(IDX1)
                               END-IF
      *                        算定要件外で療養病棟入院基本料のＩを算定時
      *                        は医療区分と難病公費のダブルチェック
      **                         DISPLAY "IDX-SEI2 = " IDX-SEI2
      **                         DISPLAY "IDX1 = " IDX1
      **                         DISPLAY "WRK-SANTEIYOUKENKBN = "
      **                                 WRK-SANTEIYOUKENKBN(IDX1)
                               IF (IDX-SEI2       =  47 OR 50 OR
                                                     53 OR 56 OR 59) AND
                                 ((SS008-MEDKBNDAY(IDX1) = "2" OR
                                                           "3"))  AND
                                  (WRK-SANTEIYOUKENKBN(IDX1) = "1")
                                 MOVE   ZERO       TO   FLG-NANBYO
                                 IF  LNK-SKJKEEP-KBN(IDX1)  =   "1"
                                     MOVE  1    TO   FLG-NANBYO
                                 END-IF
                                 IF  FLG-NANBYO          =   1 
                                   MOVE   "1"   TO   
                                             LNK-NYULIFE2-FTNKBN2(IDX1)
                                 END-IF
                               END-IF
                            END-IF
                          END-PERFORM
                       END-IF
                     END-IF
      *
      *             （平成３０年４月から）
                     IF  LNK-NYULIFE2-SANTEIYM >=  "201804"
      *                生活療養に該当する入院料を判定し、
      *                返却値の対象区分を設定する
                       PERFORM    210-NYUINACT-GET-SEC
                       MOVE       ZERO        TO   FLG-SEI
                                                   IDX-SEI2
                       PERFORM    VARYING   IDX-SEI  FROM 1  BY  1
                         UNTIL   (IDX-SEI   >  99)    OR
                                 (FLG-SEI   =    1)
                             IF  NSRY-SRYCD(1) = TBL-H30-SEISRYCD
                                                        (IDX-SEI)
                                 MOVE   1        TO   FLG-SEI
                                 MOVE   IDX-SEI  TO   IDX-SEI2
                             END-IF
                       END-PERFORM
                       IF   FLG-SEI    =    1
                          PERFORM    VARYING   IDX1   FROM   1   BY   1
                                  UNTIL     IDX1   >   31
                            IF     NACCT-DAY(IDX1)  NOT =  ZERO
                               MOVE   "1"    TO   LNK-NYULIFE2-KBN(IDX1)
                               MOVE    1     TO   FLG-OK
      *                        病状の程度、治療の内容をしん酌して標準
      *                        負担額を軽減する患者の判定（入院料判断）
                               IF  (IDX-SEI2   >=   1 )   AND
                                   (IDX-SEI2   <=   37)
                                   MOVE   "1"   TO   
                                             LNK-NYULIFE2-FTNKBN2(IDX1)
                               END-IF
      *                        難病公費の判定追加（以下入院料の場合のみ）
      *                        ・地域包括ケア病棟入院料
      *                        ・地域包括ケア入院医療管理料
                               IF  (IDX-SEI2   >=   82)   AND
                                   (IDX-SEI2   <=   97)
      *                          難病公費を使用されているか判定
                                 MOVE   ZERO       TO   FLG-NANBYO
                                 IF  WRK-HKNCOMBI-DAY(IDX1) NOT =  ZERO
                                     INITIALIZE            HKNCOMBI-REC
                                     MOVE   LNK-NYULIFE2-HOSPNUM
                                                   TO  COMB-HOSPNUM
                                     MOVE   LNK-NYULIFE2-PTID 
                                                   TO  COMB-PTID
                                     MOVE   WRK-HKNCOMBI-DAY(IDX1)
                                                   TO  COMB-HKNCOMBINUM
                                     MOVE   "tbl_hkncombi"
                                                   TO  MCP-TABLE
                                     MOVE    "key" TO  MCP-PATHNAME
                                     PERFORM 910-HKNCOMBI-SELECT-SEC
                                     IF   FLG-HKNCOMBI      =   ZERO
                                       MOVE  "tbl_hkncombi"
                                                   TO  MCP-TABLE
                                       MOVE  "key"  TO  MCP-PATHNAME
                                       PERFORM   910-HKNCOMBI-READ-SEC
                                       IF  FLG-HKNCOMBI         =  ZERO
                                         IF  (COMB-KOHHKNNUM(1) = "054")
                                          OR (COMB-KOHHKNNUM(2) = "054")
                                          OR (COMB-KOHHKNNUM(3) = "054")
                                          OR (COMB-KOHHKNNUM(4) = "054")
                                             MOVE  1    TO   FLG-NANBYO
                                         END-IF
                                       END-IF
                                     END-IF
      *                              保険組合せクローズ
                                     MOVE    "tbl_hkncombi"
                                                        TO  MCP-TABLE
                                     MOVE    "key"      TO  MCP-PATHNAME
                                     PERFORM   900-CLOSE-SEC
                                 END-IF
      *
                                 IF   FLG-NANBYO  =   1
                                   MOVE   "1"   TO   
                                             LNK-NYULIFE2-FTNKBN2(IDX1)
                                 END-IF
                               END-IF
      *                        病状の程度、治療の内容をしん酌して標準
      *                        負担額を軽減する患者の判定（特別入院基本料算定時の
      *                                                    ＡＤＬ入力判断）
                               IF (IDX-SEI2   =  98  OR  99)    AND
                                  (SS008-MEDKBNDAY(IDX1)  =  "2" OR
                                                             "3" )
                                   MOVE   "1"   TO   
                                             LNK-NYULIFE2-FTNKBN2(IDX1)
                               END-IF
      *                        算定要件外で療養病棟入院基本料のＩを算定時
      *                        は医療区分と難病公費のダブルチェック
      **                         DISPLAY "IDX-SEI2 = " IDX-SEI2
      **                         DISPLAY "IDX1 = " IDX1
      **                         DISPLAY "WRK-SANTEIYOUKENKBN = "
      **                                 WRK-SANTEIYOUKENKBN(IDX1)
                               IF (IDX-SEI2       =  44 OR 47 OR
                                                     50 OR 51 OR
                                                     54) AND
                                 ((SS008-MEDKBNDAY(IDX1) = "2" OR
                                                           "3"))  AND
                                  (WRK-SANTEIYOUKENKBN(IDX1) = "1")
                                 MOVE   ZERO       TO   FLG-NANBYO
                                 IF  LNK-SKJKEEP-KBN(IDX1)  =   "1"
                                     MOVE  1    TO   FLG-NANBYO
                                 END-IF
                                 IF  FLG-NANBYO          =   1 
                                   MOVE   "1"   TO   
                                             LNK-NYULIFE2-FTNKBN2(IDX1)
                                 END-IF
                               END-IF
      *                        急性増悪により療養病棟入院基本料のＩの算定時
      *                        は食事負担据え置き（システム予約入力）
                               IF (IDX-SEI2       =  44 OR 47 OR
                                                     50 OR 51 OR
                                                     54)
                                 MOVE   ZERO       TO   FLG-NANBYO
                                 IF (LNK-SKJKEEP-KBN(IDX1)  =   "1") AND
                                    (LNK-SKJKEEP-NANBYOKBN(IDX1) = "2")
                                     MOVE  1    TO   FLG-NANBYO
                                 END-IF
                                 IF  FLG-NANBYO          =   1 
                                   MOVE   "1"   TO   
                                             LNK-NYULIFE2-FTNKBN2(IDX1)
                                 END-IF
                               END-IF
                            END-IF
                          END-PERFORM
                       END-IF
                     END-IF
      *
                   END-IF
      *
                   MOVE    "tbl_nyuinacct"      TO  MCP-TABLE
                   MOVE    "key17"              TO  MCP-PATHNAME
                   PERFORM 910-NYUINACCT-READ-SEC
               END-PERFORM
           END-IF
      *
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *    短期滞在手術基本料２（短期滞在手術基本料３）の入院料未算定日
      *    について生活療養の該当日と軽減区分２の情報を取得（サブプロより取得）
           INITIALIZE                          ORCSNYUINDAY-AREA
           MOVE    LNK-NYULIFE2-HOSPNUM     TO  LNK-NYUINDAY-HOSPNUM
           MOVE    LNK-NYULIFE2-PTID        TO  LNK-NYUINDAY-PTID
           MOVE    LNK-NYULIFE2-SANTEIYM    TO  LNK-NYUINDAY-SANTEIYM
           CALL    "ORCSNYUINDAY"      USING   ORCSNYUINDAY-AREA
                                               SPA-AREA
           IF      LNK-NYUINDAY-RC         =   ZERO
               IF    LNK-NYUINDAY-TANKI2-TBL   NOT =    SPACE
                   PERFORM    VARYING   IDX1   FROM   1   BY   1
                      UNTIL   IDX1   >   31
                         IF    LNK-NYUINDAY-TANKI2-KBN(IDX1)   =   "2"
                               MOVE   "1"   TO   LNK-NYULIFE2-KBN(IDX1)
                               MOVE   "1"   TO
                                             LNK-NYULIFE2-FTNKBN2(IDX1)
                               IF   LNK-NYUINDAY-TANKI3-KBN(IDX1) = "2"
                                    MOVE   SPACE  TO
                                              LNK-NYULIFE2-FTNKBN2(IDX1)
                               END-IF
                               MOVE    1    TO   FLG-OK
                         END-IF
                   END-PERFORM
               END-IF
           END-IF
      *
      *−−−−医療機関食事情報取得ここから−−−−−−−−−−−
      *医療機関食事情報の取得（システム管理テーブルより）
           MOVE    ZERO                TO  FLG-SYSKANRI
           INITIALIZE                      SYSKANRI-REC
           MOVE    LNK-NYULIFE2-HOSPNUM TO  SYS-HOSPNUM
           MOVE    "5000"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    LNK-NYULIFE2-SANTEIYM
                                       TO  SYS-STYUKYMD(1:6)
           MOVE    "01"                TO  SYS-STYUKYMD(7:2)
           MOVE    SYS-STYUKYMD        TO  SYS-EDYUKYMD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"  TO  MCP-TABLE
               MOVE    "key10"         TO  MCP-PATHNAME
               PERFORM  910-SYSKANRI-READ-SEC
      *        食事情報の退避
               IF     SYS-5000-SHOKUJIRYOYOCD  NOT =  SPACE
                   PERFORM    VARYING   IDX1  FROM  1  BY  1
                          UNTIL     IDX1   >    31
                       IF    LNK-NYULIFE2-KBN(IDX1)   =   "1"
      *                   入院時食事療養費
                           IF   SYS-5000-SHOKUJIRYOYOCD  = "197000110"
                                MOVE   "1"     TO  
                                          LNK-NYULIFE2-SKJKBN(IDX1)
                           ELSE
                                MOVE   "2"     TO  
                                          LNK-NYULIFE2-SKJKBN(IDX1)
                           END-IF
                       END-IF
                   END-PERFORM
               END-IF
           END-IF
      *    システム管理クローズ
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *−−−−医療機関食事情報取得取得ここまで−−−−−−−−−−−
      *
      *
           IF    FLG-OK   =    1
      *
      *        老人適用のチェック
               IF      LNK-NYULIFE2-SANTEIYM <=  "200803"
      *          （平成２０年３月以前は老人保健の判定チェック）
                   MOVE    ZERO                 TO  FLG-RJN 
                   INITIALIZE                       PTKOHINF-REC
                   MOVE    LNK-NYULIFE2-HOSPNUM  TO  PTKOH-HOSPNUM
                   MOVE    LNK-NYULIFE2-PTID     TO  PTKOH-PTID
                   MOVE    "027"                TO  PTKOH-KOHNUM
                   MOVE    "tbl_ptkohinf"       TO  MCP-TABLE
                   MOVE    "key4"               TO  MCP-PATHNAME
                   PERFORM 910-PTKOHINF-SELECT-SEC
                   IF      FLG-PTKOHINF         =   ZERO
                       MOVE    "tbl_ptkohinf"       TO  MCP-TABLE
                       MOVE    "key4"               TO  MCP-PATHNAME
                       PERFORM   910-PTKOHINF-READ-SEC
                       PERFORM   UNTIL   (FLG-PTKOHINF   =   1)
                           IF    PTKOH-SAKJOKBN     =    SPACE
                                 MOVE   1           TO   FLG-RJN
                           END-IF
                           MOVE    "tbl_ptkohinf"   TO  MCP-TABLE
                           MOVE    "key4"           TO  MCP-PATHNAME
                           PERFORM 910-PTKOHINF-READ-SEC
                       END-PERFORM
                   END-IF
      *            患者公費情報クローズ
                   MOVE    "tbl_ptkohinf"       TO  MCP-TABLE
                   MOVE    "key4"               TO  MCP-PATHNAME
                   PERFORM   900-CLOSE-SEC
               ELSE
      *          （平成２０年４月以降はサブルーチンによりチェック）
                   PERFORM  VARYING    IDX-RJN    FROM   1   BY  1
                     UNTIL  IDX-RJN    >   31
                       INITIALIZE                   ORCSAGECHKAREA
                       MOVE    LNK-NYULIFE2-HOSPNUM  TO  AGECHK-HOSPNUM
                       MOVE    LNK-NYULIFE2-PTID     TO  AGECHK-PTID
                       MOVE    LNK-NYULIFE2-SANTEIYM TO  WRK-YYMM
                       MOVE    IDX-RJN              TO  WRK-DD
                       MOVE    WRK-YMD              TO  AGECHK-SRYYMD
                       CALL   "ORCSAGECHK"          USING
                                                    ORCSAGECHKAREA
                                                    SPA-AREA
                       IF      AGECHK-ROUJIN2    =   1
                           MOVE   1              TO  WRK-RJN(IDX-RJN)
                       END-IF
                   END-PERFORM
               END-IF
      *
      *−−−−サブルーチンでの患者所得情報の取得ここから−−−−−
               INITIALIZE                          ORCSSYOTOKUAREA
               MOVE    LNK-NYULIFE2-HOSPNUM    TO  LNK-SYOTOKU-HOSPNUM
               MOVE    LNK-NYULIFE2-PTID       TO  LNK-SYOTOKU-PTID
               MOVE    LNK-NYULIFE2-SANTEIYM   TO  LNK-SYOTOKU-SRYYM
               MOVE    "1"                     TO  LNK-SYOTOKU-SKJCHKFLG
               CALL   "ORCSSYOTOKU"    USING    ORCSSYOTOKUAREA
                                                SPA-AREA
               IF    LNK-SYOTOKU-RC    =        ZERO
                    PERFORM   VARYING   IDX1   FROM   1  BY  1
                              UNTIL     IDX1   >    31
      *                  DISPLAY "IDX1 = " IDX1
      *                  DISPLAY "AGEKBN,SKJKBN,KKSKBN = "
      *                           LNK-SYOTOKU-AGEKBN(IDX1)
      *                          ","
      *                           LNK-SYOTOKU-SKJKBN(IDX1)
      *                          ","
      *                           LNK-SYOTOKU-KKSKBN(IDX1)
                        EVALUATE   LNK-SYOTOKU-SKJKBN(IDX1)
                            WHEN  "1"
                                MOVE  "3"  TO LNK-NYULIFE2-FTNKBN1(IDX1)
                            WHEN  "2"
                                MOVE  "1"  TO LNK-NYULIFE2-FTNKBN1(IDX1)
                            WHEN  "3"
                                MOVE  "2"  TO LNK-NYULIFE2-FTNKBN1(IDX1)
                            WHEN  "4"
                                MOVE  "4"  TO LNK-NYULIFE2-FTNKBN1(IDX1)
                        END-EVALUATE
                    END-PERFORM
               ELSE
                    DISPLAY "ORCSSYTOKU RC = " LNK-SYOTOKU-RC
               END-IF
      *−−−−サブルーチンでの患者所得情報の取得ここまで−−−−−
      *
      *
      *−−−−食事療養、環境療養コード、単価設定ここから−−−−−
            PERFORM   VARYING   IDX-T   FROM   1  BY  1
              UNTIL   IDX-T     >  3
               INITIALIZE                        NYUINACCT-REC
               MOVE    LNK-NYULIFE2-HOSPNUM  TO  NACCT-HOSPNUM
               MOVE    LNK-NYULIFE2-PTID     TO  NACCT-PTID
               MOVE    LNK-NYULIFE2-SANTEIYM TO  NACCT-SRYYM
               MOVE    "tbl_nyuinacct"       TO  MCP-TABLE
               EVALUATE   IDX-T
                   WHEN   1
                       MOVE    "key30"       TO  MCP-PATHNAME
                   WHEN   2
                       MOVE    "key31"       TO  MCP-PATHNAME
                   WHEN   3
                       MOVE    "key32"       TO  MCP-PATHNAME
               END-EVALUATE
               PERFORM 910-NYUINACCT-SELECT-SEC
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               EVALUATE   IDX-T
                   WHEN   1
                       MOVE    "key30"       TO  MCP-PATHNAME
                   WHEN   2
                       MOVE    "key31"       TO  MCP-PATHNAME
                   WHEN   3
                       MOVE    "key32"       TO  MCP-PATHNAME
               END-EVALUATE
               PERFORM   910-NYUINACCT-READ-SEC
      *
      *       入院会計クローズ
               MOVE    "tbl_nyuinacct"             TO  MCP-TABLE
               EVALUATE   IDX-T
                   WHEN   1
                       MOVE    "key30"       TO  MCP-PATHNAME
                   WHEN   2
                       MOVE    "key31"       TO  MCP-PATHNAME
                   WHEN   3
                       MOVE    "key32"       TO  MCP-PATHNAME
               END-EVALUATE
               PERFORM   900-CLOSE-SEC
      *
               PERFORM   VARYING   IDX1   FROM   1  BY  1
                 UNTIL   IDX1   >    31
                  IF   LNK-NYULIFE2-KBN(IDX1)   =   "1"
                    EVALUATE  LNK-NYULIFE2-SKJKBN(IDX1)
                        WHEN  "1"
                            IF    NACCT-DAY(IDX1) NOT =  3
                              MOVE  "197001310"   TO
                                            LNK-NYULIFE2-SKJ-SRYCD
                                                            (IDX1 IDX-T)
                              MOVE   554          TO
                                            LNK-NYULIFE2-SKJ-MONEY
                                                            (IDX1 IDX-T)
                            ELSE
                              MOVE  "197003510"   TO
                                            LNK-NYULIFE2-SKJ-SRYCD
                                                            (IDX1 IDX-T)
                              MOVE   500          TO
                                            LNK-NYULIFE2-SKJ-MONEY
                                                            (IDX1 IDX-T)
                            END-IF
                            MOVE  "197001410"   TO
                                            LNK-NYULIFE2-KAN-SRYCD(IDX1)
                            MOVE   398          TO
                                            LNK-NYULIFE2-KAN-MONEY(IDX1)
                        WHEN  "2"
                            MOVE  "197001710"   TO
                                            LNK-NYULIFE2-SKJ-SRYCD
                                                            (IDX1 IDX-T)
                            MOVE   420          TO
                                            LNK-NYULIFE2-SKJ-MONEY
                                                            (IDX1 IDX-T)
                            MOVE  "197001810"   TO
                                            LNK-NYULIFE2-KAN-SRYCD(IDX1)
                            MOVE   398          TO
                                            LNK-NYULIFE2-KAN-MONEY(IDX1)
                    END-EVALUATE
                  END-IF
               END-PERFORM
      *−−−−食事療養、環境療養コード、単価設定ここまで−−−−−
      *
      *−−−−食事負担、環境療養負担コード、単価設定ここから−−−
      *        生活療養食事標準負担額設定（一般所得者）
               PERFORM   VARYING   IDX1   FROM   1  BY  1
                 UNTIL   IDX1   >    31
                 IF   LNK-NYULIFE2-KBN(IDX1)   =   "1"
                    EVALUATE  LNK-NYULIFE2-SKJKBN(IDX1)
                        WHEN  "1"
                            MOVE  "197002010"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                            MOVE   460          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                        WHEN  "2"
                            MOVE  "197002110"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                            MOVE   420          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                    END-EVALUATE
                 END-IF
               END-PERFORM
      *
      *        生活療養食事標準負担額設定（軽減ありの患者）（平成２９年９月迄）
               IF   LNK-NYULIFE2-SANTEIYM <=  "201709"
                PERFORM   VARYING   IDX1   FROM   1  BY  1
                 UNTIL   IDX1   >    31
                 IF   LNK-NYULIFE2-KBN(IDX1)   =   "1"
                    EVALUATE  LNK-NYULIFE2-FTNKBN2(IDX1)
                        WHEN  SPACE
      *                   所得の状況による軽減
                            EVALUATE   LNK-NYULIFE2-FTNKBN1(IDX1)
                                WHEN   "1"
                                WHEN   "2"
      *                           （低２）
                                    MOVE  "197002210"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                    MOVE   210          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                WHEN   "3"
      *                           （低１）
                                    IF  (FLG-RJN         =  0)   AND
                                        (WRK-RJN(IDX1)   =  0)                                        
                                       MOVE  "197002310"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                       MOVE   130          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                    ELSE
                                       MOVE  "197002410"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                       MOVE   130          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                    END-IF
                                WHEN   "4"
      *                           （低１−老齢福祉年金受給者）
                                    MOVE  "197002510"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                    MOVE   100          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                            END-EVALUATE
                        WHEN  "1"
      *                   病状の程度による軽減
                            EVALUATE   LNK-NYULIFE2-FTNKBN1(IDX1)
                                WHEN   SPACE
      *                           （医療区分２、３（一般））
                                    MOVE  "197002710"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                    IF    LNK-NYULIFE2-SANTEIYM
                                                        >= "201604"
                                       MOVE   360      TO
                                           LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                    END-IF
      *                             難病等据え置き患者の置換
                                    EVALUATE     LNK-SKJKEEP-KBN(IDX1)
                                        WHEN     "1"
                                           MOVE  "197003610"   TO
                                              LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                           MOVE   260      TO
                                             LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                        WHEN     "2"
                                           MOVE  "197003710"   TO
                                              LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                           MOVE   260      TO
                                             LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                    END-EVALUATE
                                WHEN   "1"
      *                           （医療区分２、３（低２　９０日以下））
                                    MOVE  "197002810"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                    MOVE   210          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                WHEN   "2"
      *                           （医療区分２、３（低２　９０日超））
                                    MOVE  "197002910"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                    MOVE   160          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                WHEN   "3"
                                WHEN   "4"
      *                           （医療区分２、３（低１））
                                    MOVE  "197003010"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                    MOVE   100          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                            END-EVALUATE
                    END-EVALUATE
                 END-IF
                END-PERFORM
               END-IF
      *
      *        生活療養食事標準負担額設定（軽減ありの患者）（平成２９年１０月以降）
               IF   LNK-NYULIFE2-SANTEIYM >=  "201710"
                PERFORM   VARYING   IDX1   FROM   1  BY  1
                 UNTIL   IDX1   >    31
                 IF   LNK-NYULIFE2-KBN(IDX1)   =   "1"
                    EVALUATE  LNK-NYULIFE2-FTNKBN2(IDX1)
      *             （医療区分１）
                      WHEN  SPACE
                        EVALUATE    LNK-SYOTOKU-AGEKBN(IDX1)
      *                   ７０歳未満
                          WHEN    "2"
                            EVALUATE   LNK-NYULIFE2-FTNKBN1(IDX1)
      *                         低所得オ
                                WHEN   "1"
                                WHEN   "2"
                                    MOVE  "197003910"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                    MOVE   210          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
      *                             境界層患者
                                    IF   LNK-SYOTOKU-KKSKBN(IDX1) = "1"
                                      MOVE  "197004010"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                      MOVE   100          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                    END-IF
                            END-EVALUATE
      *                   ７０歳以上
                          WHEN    "1"
                            EVALUATE   LNK-NYULIFE2-FTNKBN1(IDX1)
      *                         低所得２
                                WHEN   "1"
                                WHEN   "2"
                                    MOVE  "197002210"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                    MOVE   210          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
      *                         低所得１
                                WHEN   "3"
                                    IF  (FLG-RJN         =  0)   AND
                                        (WRK-RJN(IDX1)   =  0)                                        
                                       MOVE  "197002310"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                       MOVE   130          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                    ELSE
                                       MOVE  "197002410"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                       MOVE   130          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                    END-IF
      *                             境界層患者
                                    IF   LNK-SYOTOKU-KKSKBN(IDX1) = "1"
                                      MOVE  "197004110"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                      MOVE   100          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                    END-IF
      *                         低所得１−老齢福祉年金受給者
                                WHEN   "4"
                                    MOVE  "197002510"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                    MOVE   100          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                            END-EVALUATE
                        END-EVALUATE
      *             （医療区分２、３）
                      WHEN  "1"
      *                   一般所得者
                          IF   LNK-NYULIFE2-FTNKBN1(IDX1)  =  SPACE
                              MOVE  "197002710"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                              IF    LNK-NYULIFE2-SANTEIYM
                                                      >= "201604"
                                       MOVE   360      TO
                                           LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                              END-IF
      *                       平成３０年改正
                              IF    LNK-NYULIFE2-SANTEIYM
                                                      >= "201804"
                                  IF   LNK-NYULIFE2-SKJKBN(IDX1)  =  "1"
                                       MOVE  "197005110"   TO
                                             LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                       MOVE   460      TO
                                           LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                  ELSE
                                       MOVE  "197005210"   TO
                                             LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                       MOVE   420      TO
                                           LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                  END-IF
                              END-IF
      *                       難病等据え置き患者の置換
                              EVALUATE     LNK-SKJKEEP-KBN(IDX1)
                                  WHEN     "1"
                                      MOVE  "197003610"   TO
                                              LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                      MOVE   260      TO
                                             LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                  WHEN     "2"
                                      MOVE  "197003710"   TO
                                              LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                      MOVE   260      TO
                                             LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                              END-EVALUATE
                          END-IF
      *
                          EVALUATE    LNK-SYOTOKU-AGEKBN(IDX1)
      *                     ７０歳未満
                            WHEN    "2"
                              EVALUATE   LNK-NYULIFE2-FTNKBN1(IDX1)
      *                         低所得オ　９０日以下
                                WHEN   "1"
                                    MOVE  "197004210"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                    MOVE   210          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
      *                             難病患者の置換
                                    IF   LNK-SKJKEEP-KBN(IDX1)  =  "1"
                                       MOVE  "197004310"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                       MOVE   210          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                    END-IF
      *                         低所得オ　９０日超
                                WHEN   "2"
                                    MOVE  "197004410"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                    MOVE   160          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
      *                             難病患者の置換
                                    IF   LNK-SKJKEEP-KBN(IDX1)  =  "1"
                                       MOVE  "197004510"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                       MOVE   160          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                    END-IF
                              END-EVALUATE
      *                       境界層患者
                              IF  (LNK-NYULIFE2-FTNKBN1(IDX1) = "1" OR
                                                                "2") AND 
                                  (LNK-SYOTOKU-KKSKBN(IDX1)   = "1")
                                  MOVE  "197004610"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                        (IDX1 IDX-T)
                                  MOVE   100          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                              END-IF
      *
      *                     ７０歳以上
                            WHEN    "1"
                              EVALUATE   LNK-NYULIFE2-FTNKBN1(IDX1)
      *                         低所得２　９０日以下
                                WHEN   "1"
                                    MOVE  "197002810"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                    MOVE   210          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
      *                             難病患者の置換
                                    IF   LNK-SKJKEEP-KBN(IDX1)  =  "1"
                                       MOVE  "197004710"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                       MOVE   210          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                    END-IF
      *                         低所得２　９０日超
                                WHEN   "2"
                                    MOVE  "197002910"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                    MOVE   160          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
      *                             難病患者の置換
                                    IF   LNK-SKJKEEP-KBN(IDX1)  =  "1"
                                       MOVE  "197004810"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                       MOVE   160          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                    END-IF
      *                         低所得１
                                WHEN   "3"
                                    MOVE  "197003010"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                    MOVE   100          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
      *                             難病患者の置換
                                    IF   LNK-SKJKEEP-KBN(IDX1)  =  "1"
                                      MOVE  "197004910"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                      MOVE   100          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                    END-IF
      *                             境界層患者
                                    IF   LNK-SYOTOKU-KKSKBN(IDX1) = "1"
                                      MOVE  "197005010"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                      MOVE   100          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                                    END-IF
      *                         低所得１−老齢福祉年金受給者
                                WHEN   "4"
                                    MOVE  "197002510"   TO
                                         LNK-NYULIFE2-SKJFTN-SRYCD
                                                            (IDX1 IDX-T)
                                    MOVE   100          TO
                                         LNK-NYULIFE2-SKJFTN-MONEY
                                                            (IDX1 IDX-T)
                              END-EVALUATE
      *
                          END-EVALUATE
                    END-EVALUATE
                 END-IF
                END-PERFORM
               END-IF
      *
            END-PERFORM
      *
      *      生活療養環境療養標準負担額設定
             IF   LNK-NYULIFE2-SANTEIYM <=  "201709"
      *        平成２９年９月迄
               PERFORM   VARYING   IDX1   FROM   1  BY  1
               UNTIL   IDX1   >    31
                IF   LNK-NYULIFE2-KBN(IDX1)   =   "1"
                    IF  LNK-NYULIFE2-FTNKBN2(IDX1)   =   SPACE
                        MOVE  "197001910"       TO
                                        LNK-NYULIFE2-KANFTN-SRYCD(IDX1)
                        MOVE  320       TO
                                        LNK-NYULIFE2-KANFTN-MONEY(IDX1)
                    END-IF
      *             老齢福祉年金受給者は環境療養患者負担無しに置換え
                    IF  LNK-NYULIFE2-FTNKBN1(IDX1)   =   "4"
                        MOVE  SPACE  TO  LNK-NYULIFE2-KANFTN-SRYCD(IDX1)
                        MOVE  ZERO   TO  LNK-NYULIFE2-KANFTN-MONEY(IDX1)
                    END-IF
      *             精神病床１年超で医療区分２、３は患者負担無しに置換え
                    IF (LNK-NYULIFE2-FTNKBN2(IDX1)   =  "1")   AND
                       (LNK-SKJKEEP-KBN(IDX1)        =  "2")
                        MOVE  SPACE  TO  LNK-NYULIFE2-KANFTN-SRYCD(IDX1)
                        MOVE  ZERO   TO  LNK-NYULIFE2-KANFTN-MONEY(IDX1)
                    END-IF
                END-IF
               END-PERFORM
             ELSE
      *        平成２９年１０月以降
               PERFORM   VARYING   IDX1   FROM   1  BY  1
               UNTIL   IDX1   >    31
                IF   LNK-NYULIFE2-KBN(IDX1)   =   "1"
      *             医療区分１（１日３７０円）
                    IF  LNK-NYULIFE2-FTNKBN2(IDX1)   =   SPACE
                        MOVE  "197001910"       TO
                                        LNK-NYULIFE2-KANFTN-SRYCD(IDX1)
                        MOVE  370       TO
                                        LNK-NYULIFE2-KANFTN-MONEY(IDX1)
                    END-IF
      *             医療区分２、３（１日２００円）
                    IF  LNK-NYULIFE2-FTNKBN2(IDX1)   =  "1"
                        MOVE  "197003810"       TO
                                        LNK-NYULIFE2-KANFTN-SRYCD(IDX1)
                        MOVE  200       TO
                                        LNK-NYULIFE2-KANFTN-MONEY(IDX1)
      *                 平成３０年改正　医療区分２、３（１日３７０円）
                        IF   LNK-NYULIFE2-SANTEIYM >=  "201804"
                             MOVE  370       TO
                                        LNK-NYULIFE2-KANFTN-MONEY(IDX1)
                        END-IF
                    END-IF
      *             境界層患者は環境療養患者負担無しに置換え
                    IF  LNK-SYOTOKU-KKSKBN(IDX1)   =   "1"
                        MOVE  SPACE  TO  LNK-NYULIFE2-KANFTN-SRYCD(IDX1)
                        MOVE  ZERO   TO  LNK-NYULIFE2-KANFTN-MONEY(IDX1)
                    END-IF
      *             老齢福祉年金受給者は環境療養患者負担無しに置換え
                    IF  LNK-NYULIFE2-FTNKBN1(IDX1)   =   "4"
                        MOVE  SPACE  TO  LNK-NYULIFE2-KANFTN-SRYCD(IDX1)
                        MOVE  ZERO   TO  LNK-NYULIFE2-KANFTN-MONEY(IDX1)
                    END-IF
      *             指定難病で医療区分２、３は患者負担無しに置換え
                    IF (LNK-NYULIFE2-FTNKBN2(IDX1)   =  "1")   AND
                       (LNK-SKJKEEP-KBN(IDX1)        =  "1")
                        MOVE  SPACE  TO  LNK-NYULIFE2-KANFTN-SRYCD(IDX1)
                        MOVE  ZERO   TO  LNK-NYULIFE2-KANFTN-MONEY(IDX1)
                    END-IF
                END-IF
               END-PERFORM
             END-IF
      *
      *−−−−食事負担、環境療養負担コード、単価設定ここまで−−−
      *
           END-IF
      *
           IF   FLG-OK   =   ZERO
               MOVE   4      TO   LNK-NYULIFE2-RC
           END-IF
      *
      *     PERFORM   VARYING  IDX1   FROM  1   BY  1
      *               UNTIL  IDX1   >   31
      *          DISPLAY "IDX1 = " IDX1
      *          DISPLAY "LNK-SKJKEEP-KBN(IDX1) = "
      *                   LNK-SKJKEEP-KBN(IDX1)
      *          DISPLAY "LNK-NYULIFE2-KBN(IDX1) = " 
      *                   LNK-NYULIFE2-KBN(IDX1)
      *          DISPLAY "LNK-NYULIFE2-FTNKBN1(IDX1) = " 
      *                   LNK-NYULIFE2-FTNKBN1(IDX1)
      *          DISPLAY "LNK-NYULIFE2-FTNKBN2(IDX1) = " 
      *                   LNK-NYULIFE2-FTNKBN2(IDX1)
      *          DISPLAY  "LNK-NYULIFE2-SKJ-SRYCD(IDX1) = "
      *                    LNK-NYULIFE2-SKJ-SRYCD(IDX1)
      *          DISPLAY "LNK-NYULIFE2-SKJ-MONEY(IDX1) = "
      *                   LNK-NYULIFE2-SKJ-MONEY(IDX1)
      *          DISPLAY  "LNK-NYULIFE2-SKJFTN-SRYCD(IDX1) = "
      *                    LNK-NYULIFE2-SKJFTN-SRYCD(IDX1)
      *          DISPLAY "LNK-NYULIFE2-SKJFTN-MONEY(IDX1) = "
      *                   LNK-NYULIFE2-SKJFTN-MONEY(IDX1)
      *          DISPLAY  "LNK-NYULIFE2-KAN-SRYCD(IDX1) = "
      *                    LNK-NYULIFE2-KAN-SRYCD(IDX1)
      *          DISPLAY "LNK-NYULIFE2-KAN-MONEY(IDX1) = "
      *                   LNK-NYULIFE2-KAN-MONEY(IDX1)
      *          DISPLAY  "LNK-NYULIFE2-KANFTN-SRYCD(IDX1) = "
      *                    LNK-NYULIFE2-KANFTN-SRYCD(IDX1)
      *          DISPLAY "LNK-NYULIFE2-KANFTN-MONEY(IDX1) = "
      *                   LNK-NYULIFE2-KANFTN-MONEY(IDX1)
      *     END-PERFORM
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院診療行為取得
      *****************************************************************
       210-NYUINACT-GET-SEC            SECTION.
      *
           INITIALIZE                      NYUINACT-REC
           MOVE    NACCT-HOSPNUM       TO  NSRY-HOSPNUM
           MOVE    NACCT-NYUGAIKBN     TO  NSRY-NYUGAIKBN
           MOVE    NACCT-PTID          TO  NSRY-PTID
           MOVE    NACCT-SRYYM         TO  NSRY-SRYYM
           MOVE    NACCT-ZAINUM        TO  NSRY-ZAINUM
           MOVE    "tbl_nyuinact"      TO  MCP-TABLE
           MOVE    "key9"              TO  MCP-PATHNAME
           PERFORM 910-NYUINACT-SELECT-SEC
           IF      FLG-NYUINACT        =   ZERO
               MOVE    "tbl_nyuinact"  TO  MCP-TABLE
               MOVE    "key9"          TO  MCP-PATHNAME
               PERFORM   910-NYUINACT-READ-SEC
           END-IF
      *
      *    入院行為クローズ
           MOVE     "tbl_nyuinact"     TO  MCP-TABLE
           MOVE     "key9"             TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
           .
       210-NYUINACT-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスター読込
      *****************************************************************
       910-SYSKANRI-READ-SEC         SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-5000-REC
               MOVE    ZERO                TO  FLG-SYSKANRI
           ELSE
               INITIALIZE                      SYS-5000-REC
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           .
       910-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptinf"         TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM   900-DBFETCH-SEC
               IF      MCP-RC          =   ZERO
                   MOVE    MCPDATA-REC TO  PTINF-REC
                   MOVE    ZERO        TO  FLG-PTINF
               ELSE
                   INITIALIZE              PTINF-REC
                   MOVE    1           TO  FLG-PTINF
               END-IF
           ELSE
               INITIALIZE                  PTINF-REC
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスター検索
      *****************************************************************
       910-HKNCOMBI-SELECT-SEC        SECTION.
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-HKNCOMBI
           ELSE
               MOVE    1                  TO  FLG-HKNCOMBI
           END-IF
      *
           .
       910-HKNCOMBI-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスター読込
      *****************************************************************
       910-HKNCOMBI-READ-SEC         SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  HKNCOMBI-REC
               MOVE    ZERO                TO  FLG-HKNCOMBI
           ELSE
               INITIALIZE                      HKNCOMBI-REC
               MOVE    1                   TO  FLG-HKNCOMBI
           END-IF
      *
           .
       910-HKNCOMBI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者保険情報マスター検索
      *****************************************************************
       910-PTHKNINF-SELECT-SEC        SECTION.
      *
           MOVE    PTHKNINF-REC        TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-PTHKNINF
           ELSE
               MOVE    1                  TO  FLG-PTHKNINF
           END-IF
      *
           .
       910-PTHKNINF-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者保険情報マスター読込
      *****************************************************************
       910-PTHKNINF-READ-SEC        SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  PTHKNINF-REC
               MOVE    ZERO               TO  FLG-PTHKNINF
           ELSE
               INITIALIZE                     PTHKNINF-REC
               MOVE    1                  TO  FLG-PTHKNINF
           END-IF
      *
           .
       910-PTHKNINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者公費情報マスター検索
      *****************************************************************
       910-PTKOHINF-SELECT-SEC        SECTION.
      *
           MOVE    PTKOHINF-REC        TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-PTKOHINF
           ELSE
               MOVE    1                  TO  FLG-PTKOHINF
           END-IF
      *
           .
       910-PTKOHINF-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者公費情報マスター読込
      *****************************************************************
       910-PTKOHINF-READ-SEC        SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  PTKOHINF-REC
               MOVE    ZERO               TO  FLG-PTKOHINF
           ELSE
               INITIALIZE                     PTKOHINF-REC
               MOVE    1                  TO  FLG-PTKOHINF
           END-IF
      *
           .
       910-PTKOHINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスター検索
      *****************************************************************
       910-NYUINACCT-SELECT-SEC        SECTION.
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-NYUINACCT
           ELSE
               MOVE    1                  TO  FLG-NYUINACCT
           END-IF
      *
           .
       910-NYUINACCT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスター読込
      *****************************************************************
       910-NYUINACCT-READ-SEC        SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  NYUINACCT-REC
               MOVE    ZERO               TO  FLG-NYUINACCT
               IF      WRK-KYUKYU-DAY     NOT =   ZERO
                   IF   WRK-KYUKYU-NYUINCD   = NACCT-SRYCDTOTAL(6:9)
                        MOVE   1          TO  NACCT-DAY(WRK-KYUKYU-DAY)  
                   END-IF
               END-IF
           ELSE
               INITIALIZE                     NYUINACCT-REC
               MOVE    1                  TO  FLG-NYUINACCT
           END-IF
      *
           .
       910-NYUINACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院診療行為マスター検索
      *****************************************************************
       910-NYUINACT-SELECT-SEC        SECTION.
      *
           MOVE    NYUINACT-REC        TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-NYUINACT
           ELSE
               MOVE    1                  TO  FLG-NYUINACT
           END-IF
      *
           .
       910-NYUINACT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院診療行為マスター読込
      *****************************************************************
       910-NYUINACT-READ-SEC         SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  NYUINACT-REC
               MOVE    ZERO                TO  FLG-NYUINACT
           ELSE
               INITIALIZE                      NYUINACT-REC
               MOVE    1                   TO  FLG-NYUINACT
           END-IF
      *
           .
       910-NYUINACT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者入院履歴マスター検索
      *****************************************************************
       910-PTNYUINRRK-SELECT-SEC        SECTION.
      *
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-PTNYUINRRK
           ELSE
               MOVE    1                  TO  FLG-PTNYUINRRK
           END-IF
      *
           .
       910-PTNYUINRRK-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者入院履歴マスター読込
      *****************************************************************
       910-PTNYUINRRK-READ-SEC        SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  PTNYUINRRK-REC
               MOVE    ZERO               TO  FLG-PTNYUINRRK
           ELSE
               INITIALIZE                     PTNYUINRRK-REC
               MOVE    1                  TO  FLG-PTNYUINRRK
           END-IF
      *
           .
       910-PTNYUINRRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＳＥＬＥＣＴ処理
      *****************************************************************
       900-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
           .
       900-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＦＥＴＣＨ処理
      *****************************************************************
       900-DBFETCH-SEC                SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルアクセス処理
      *****************************************************************
       900-ORCDBMAIN-SEC               SECTION.
      *
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
      *
       910-ORCDBMAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       900-CLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR"      TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
      *
           .
      *
       900-CLOSE-SEC-EXT.
           EXIT.
