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
      *    レセプト電算マスター   COPY (CPRECEDEN.INC)            *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  RECEDEN-REC.
      *ＫＥＹ
           03  RECEDEN-KEY.
      *医療機関ＩＤ
               05  RECEDEN-HOSPID           PIC  X(24).
      *診療年月
               05  RECEDEN-SRYYM            PIC  9(06).
      *入外区分
               05  RECEDEN-NYUGAIKBN        PIC  X(01).
      *患者ＩＤ
               05  RECEDEN-PTID             PIC  9(10).
      *レセプト科（空白の時ゼロをセット）
               05  RECEDEN-RECEKA           PIC  X(02).
      *審査支払機関
               05  RECEDEN-TEISYUTUSAKI     PIC  9(01).
      *レセプト種別
               05  RECEDEN-RECESYUBETU      PIC  X(04).
      *保険者番号
               05  RECEDEN-HKNJANUM         PIC  X(08).
      *補助区分（船員保険のときのみ）
               05  RECEDEN-HOJOKBN-KEY      PIC  X(01).
      *適用開始年月日
               05  RECEDEN-TEKSTYMD         PIC  X(08).
      *データ連番
           03  RECEDEN-RENNUM               PIC  9(05).
      *レセ電データ
           03  RECEDEN-RECEDATA             PIC  X(1000).