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
      *    患者定期請求一括処理パラメータ
      *　  COPY  (CPTEIKI1PARA.INC)                              *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  TEIKI2PARA-AREA.
           03  TEIKI2P-PRTJYUN             PIC X(02).
           03  TEIKI2P-BTUNUM-MAX          PIC 9(04).
           03  TEIKI2P-BTUNUM-TBL.
               05  TEIKI2P-BTUNUM-OCC      OCCURS 50.
                   07  TEIKI2P-BTUNUM      PIC X(02).
           03  TEIKI2P-SYSYMD              PIC X(08).
           03  TEIKI2P-TERMID              PIC X(64).
           03  TEIKI2P-JOBID               PIC 9(07).
           03  TEIKI2P-SHELLID             PIC X(08).
           03  TEIKI2P-HOSPID              PIC X(24).
           03  TEIKI2P-STAFFCD             PIC X(05).
           03  TEIKI2P-ERRFILE             PIC X(200).
