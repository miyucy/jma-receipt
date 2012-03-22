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
      *    入院料加算チェックサブ      COPY (CPORCSNYUKSN.INC)        *
      *****************************************************************
      *****************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
       01  SNYUKSNCHK-LNK.
           03  SNYUKSNCHK-BTUSBT       PIC X(02).
      *    基本料の診療コード
           03  SNYUKSNCHK-KHN-SRYCD    PIC X(09).
      *    病棟の特定入院料コード
           03  SNYUKSNCHK-BTU-TOKKBN   PIC X(02).
      *    病室の特定入院料コード
           03  SNYUKSNCHK-BRM-TOKKBN   PIC X(02).
      *    療養区分
           03  SNYUKSNCHK-RYOYOKBN     PIC X(01).
      *    加算の診療コード
           03  SNYUKSNCHK-KSN-SRYCD    PIC X(09).
      *
      *    診療日
           03  SNYUKSNCHK-SRYYMD       PIC X(08).
      *    １：エラー（０：正常）
           03  SNYUKSNCHK-ERR          PIC 9(01).
