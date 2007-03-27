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
      ************************************************************
      *    入院点滴加算抽出パラメタ　　COPY (CPORCSCTENTEK2.INC)
      *                            使用プログラム 
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  ORCSTENTEK2AREA.
      *
      *入力
           03  ORCSTEN2-IN-AREA.
      *患者ＩＤ
               05  ORCSTEN2-PTID               PIC  9(10).
      *診療年月
               05  ORCSTEN2-SRYYM              PIC  X(06).
      *保険組合
               05  ORCSTEN2-HKNCOMBI           PIC 9(04).
      *加算算定
           03  ORCSTEN2-OUT-AREA.
      *        点滴注射加算
               05  ORCSTEN2-KASAN-AREA.
                   07  ORCSTEN2-KASAN-DAY      OCCURS   31.
                     09  ORCSTEN2-KASAN-SRYCD  PIC X(09)
                                               OCCURS   5.
      *エラーコード（１：パラメタエラー、２：会計照会参照エラー）
           03  ORCSTEN2-ERRCD                  PIC 9(01).
      *
