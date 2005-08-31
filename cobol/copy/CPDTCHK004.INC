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
      *    データチェック中間ファイル     COPY (CPDTCHK004.INC)  *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  DTCHK004-REC.
      *
           03  DTCHK004-KEY                PIC X(100).
           03  DTCHK004-KEY-R1        REDEFINES    DTCHK004-KEY.
               05  DTCHK004-R1-PTNUM       PIC X(20).
               05  DTCHK004-R1-PTID        PIC 9(10).
               05  DTCHK004-R1-HKNKBN      PIC X(01).
               05  DTCHK004-R1-ERRCD       PIC X(06).
               05  DTCHK004-R1-ERRCD-SEQ   PIC 9(05).
               05  DTCHK004-R1-DUMMY       PIC X(58).
           03  DTCHK004-KEY-R2        REDEFINES    DTCHK004-KEY.
               05  DTCHK004-R2-KANANAME    PIC X(50).
               05  DTCHK004-R2-PTNUM       PIC X(20).
               05  DTCHK004-R2-PTID        PIC 9(10).
               05  DTCHK004-R2-HKNKBN      PIC X(01).
               05  DTCHK004-R2-ERRCD       PIC X(06).
               05  DTCHK004-R2-ERRCD-SEQ   PIC 9(05).
               05  DTCHK004-R2-DUMMY       PIC X(08).
           03  DTCHK004-KEY-R3        REDEFINES    DTCHK004-KEY.
               05  DTCHK004-R3-HKNKBN      PIC X(01).
               05  DTCHK004-R3-PTNUM       PIC X(20).
               05  DTCHK004-R3-PTID        PIC 9(10).
               05  DTCHK004-R3-ERRCD       PIC X(06).
               05  DTCHK004-R3-ERRCD-SEQ   PIC 9(05).
               05  DTCHK004-R3-DUMMY       PIC X(58).
           03  DTCHK004-KEY-R4        REDEFINES    DTCHK004-KEY.
               05  DTCHK004-R4-HKNKBN      PIC X(01).
               05  DTCHK004-R4-KANANAME    PIC X(50).
               05  DTCHK004-R4-PTNUM       PIC X(20).
               05  DTCHK004-R4-PTID        PIC 9(10).
               05  DTCHK004-R4-ERRCD       PIC X(06).
               05  DTCHK004-R4-ERRCD-SEQ   PIC 9(05).
               05  DTCHK004-R4-DUMMY       PIC X(08).
      *
      *患者番号
           03  DTCHK004-PTNUM         PIC X(20).
      *
      *患者ＩＤ
           03  DTCHK004-PTID          PIC 9(10).
      *氏名
           03  DTCHK004-NAME          PIC X(100).
      *
      *複数保険区分
           03  DTCHK004-MULHKNKBN     PIC  X(01).
      *
      *保険区分
           03  DTCHK004-HKNKBN        PIC  X(01).
      *
      *他保険エラー区分
           03  DTCHK004-HKNOTHERS     PIC  X(01).
      *
      *生年月日
           03  DTCHK004-BIRTHDAY      PIC  X(08).
      *
      *エラーコード
           03  DTCHK004-ERRCD         PIC X(06).
      *
      *同一エラーコード内連番
           03  DTCHK004-ERRCD-SEQ     PIC 9(05).
      *
      *エラーメッセージ
           03  DTCHK004-ERRMSG        PIC X(500).
