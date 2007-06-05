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
      *    初診／再診判定サブ　　COPY (CPORCSS003.INC)
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
        01  SS003-AREA.
            03  SS003-IN.
                05  SS003-SYORIKBN         PIC X(01).
                05  SS003-HOSPNUM          PIC 9(02).
                05  SS003-PTID             PIC 9(10).
                05  SS003-NYUGAIKBN        PIC X(01).
                05  SS003-DENPNUM          PIC 9(07).
            03  SS003-OT.
                05  SS003-SYOSAISIN-KBN    PIC X(01).
