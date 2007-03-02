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
      *    診療行為包括診療チェクパラメタ
      *                                      COPY (CPORCSCHKTCHK.INC)
      *----------------------------------------------------------*
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *
       01  ORCSCHKTCHKAREA.
      *    処理区分（１：全体チェック、２：自動発生分チェック）
           03  ORCSCHKTCHK-SYORI          PIC X(01).
      *    ＰＧ名
           03  ORCSCHKTCHK-PG             PIC X(06).
      *
           03  ORCSCHKTCHK-OUTAREA.
      *        包括対象あり
               05  ORCSCHKTCHK-HKTFLG     PIC 9(01).
      *        エラーあり
               05  ORCSCHKTCHK-HKTERR     PIC 9(01).
      *
