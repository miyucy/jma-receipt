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
           03  DTCHK004-KEY.
      *患者番号
               05  DTCHK004-PTNUM     PIC X(20).
      *
      *エラーコード
               05  DTCHK004-ERRCD     PIC X(06).
      *同一エラーコード内連番
               05  DTCHK004-ERRCD-SEQ PIC 9(05).
      *
      *患者ＩＤ
           03  DTCHK004-PTID          PIC 9(10).
      *
      *氏名
           03  DTCHK004-NAME          PIC X(100).
      *
      *生年月日
           03  DTCHK004-BIRTHDAY      PIC  X(08).
      *
      *エラーメッセージ
           03  DTCHK004-ERRMSG        PIC X(500).
