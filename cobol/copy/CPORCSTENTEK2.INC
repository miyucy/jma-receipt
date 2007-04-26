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
      *    入院点滴抽出パラメタ　　COPY (CPORCSCTENTEK2.INC)
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
      *返却項目
           03  ORCSTEN2-OUT-AREA.
      *        点滴注射
               05  ORCSTEN2-TENTEK-AREA.
                   07  ORCSTEN2-TENTEK-DAY          OCCURS   31.
      *              明細数
                     09  ORCSTEN2-TENTEK-MEISAISU   PIC 9(03).
      *              剤点数
                     09  ORCSTEN2-TENTEK-ZAITEN     PIC 9(07).
      *              剤点数
                     09  ORCSTEN2-TENTEK-SRYCD-TOTAL PIC 9(13).
      *              明細返却
                     09  ORCSTEN2-TENTEK-MEISAI       OCCURS  5.
      *                診療行為コード
                       11  ORCSTEN2-TENTEK-SRYCD      PIC X(09).
      *                剤番号
                       11  ORCSTEN2-TENTEK-ZAINUM     PIC 9(08).
      *                名称入力番号
                       11  ORCSTEN2-TENTEK-INPUTNUM   PIC 9(03).
      *        エラーコード（０：正常終了　１：異常終了（または対象なし）
                  07  ORCSTEN2-TENTEK-ERRCD       PIC 9(01).
      *
      *        中心静脈
               05  ORCSTEN2-CHUJOU-AREA.
                   07  ORCSTEN2-CHUJOU-DAY          OCCURS   31.
      *              明細数
                     09  ORCSTEN2-CHUJOU-MEISAISU   PIC 9(03).
      *              剤点数
                     09  ORCSTEN2-CHUJOU-ZAITEN     PIC 9(07).
      *              剤点数
                     09  ORCSTEN2-CHUJOU-SRYCD-TOTAL PIC 9(13).
      *              明細返却
                     09  ORCSTEN2-CHUJOU-MEISAI       OCCURS  5.
      *                診療行為コード
                       11  ORCSTEN2-CHUJOU-SRYCD      PIC X(09).
      *                剤番号
                       11  ORCSTEN2-CHUJOU-ZAINUM     PIC 9(08).
      *                名称入力番号
                       11  ORCSTEN2-CHUJOU-INPUTNUM   PIC 9(03).
      *        エラーコード（０：正常終了　１：異常終了（または対象なし）
                  07  ORCSTEN2-CHUJOU-ERRCD       PIC 9(01).
