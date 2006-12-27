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
      *----------------------------------------------------------*
      *    診療行為点数投薬附加情報チェックパラメタ
      *                                          COPY (CPORCSC98.INC)
      *----------------------------------------------------------*
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *
       01  ORCSC98AREA.
      *    ＰＧ名
           03  LNK-SC98-PG             PIC X(06).
      *
           03  LNK-SC98-INAREA.
      *        年齢 
               05  LNK-SC98-NENREI.
                   07  LNK-SC98-NENREI-YY     PIC 9(03).
                   07  LNK-SC98-NENREI-MM     PIC 9(02).
                   07  LNK-SC98-NENREI-DD     PIC 9(02).
           03  LNK-SC98-OUTAREA.
      *        エラー内容
               05  LNK-SC98-ERRMSG         PIC X(100).
      *
