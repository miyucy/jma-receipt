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
      *****************************************************************
      *
      *     印刷用データ 名称領域      CPCOMMONPRT.INC
      *            
      *****************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     02/02/04  処理時間の追加
      *                                     連番X(03)から9(06)に変更
      *  01.00.02    MCC-藤原     02/03/18  端末ＩＤ
      *                                     X(16)からX(32)に変更
      *****************************************************************
       01  HC01PARA.
           03  FILLER                  PIC  X(09) VALUE "/var/tmp/".
           03  HC01PARA-FORM-ID        PIC  X(04).
           03  FILLER                  PIC  X(01) VALUE ".".
      *****03  HC01PARA-TERMID         PIC  X(16).
           03  HC01PARA-TERMID         PIC  X(64).
           03  FILLER                  PIC  X(01) VALUE ".".
           03  HC01PARA-SYOHMS         PIC  9(08).
           03  FILLER                  PIC  X(01) VALUE ".".
           03  HC01PARA-CNT            PIC  9(06).
           03  FILLER                  PIC  X(04) VALUE ".dat".
