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
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.02.04    NACL-森脇    02/07/30  107 薬剤情報マスタの追加
      ************************************************************
        02  M02.
            03  M02-FIXED1.
              04  M02-STATE-G.
                05  M02-G101.
                  06  M02-G101-STATE   PIC S9(9)   BINARY.
                05  M02-G102.
                  06  M02-G102-STATE   PIC S9(9)   BINARY.
                05  M02-G103.
                  06  M02-G103-STATE   PIC S9(9)   BINARY.
                05  M02-G104.
                  06  M02-G104-STATE   PIC S9(9)   BINARY.
                05  M02-G105.
                  06  M02-G105-STATE   PIC S9(9)   BINARY.
                05  M02-G106.
                  06  M02-G106-STATE   PIC S9(9)   BINARY.
      *----(01.02.04)----START----
                05  M02-G107.
                  06  M02-G107-STATE   PIC S9(9)   BINARY.
              04  M02-STATE-R       REDEFINES  M02-STATE-G.
                05  M02-STATE-O     PIC S9(09) BINARY  OCCURS  7.
      *----(01.02.04)----END------
              04  M02-SELNUM.
                05  M02-VALUE   PIC 9(3).
