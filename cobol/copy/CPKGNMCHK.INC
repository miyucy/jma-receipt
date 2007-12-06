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
      *         記号チェック初期パターン     (CPKGNMCHK.INC)    *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  KGNMCHK-AREA.
           03   KGNMCHK-H001-KGSUJI       PIC X(01)   VALUE   "1".
           03   KGNMCHK-H001-KGKANJI      PIC X(01)   VALUE   "1".
           03   KGNMCHK-H001-KGABT        PIC X(01)   VALUE   "1".
           03   KGNMCHK-H001-KGHYPN       PIC X(01)   VALUE   "1".
           03   KGNMCHK-H001-KGKAKKO      PIC X(01)   VALUE   "1".
           03   KGNMCHK-H001-KGETC        PIC X(01)   VALUE   "1".
           03   KGNMCHK-H001-KGKANJINASHI PIC X(01)   VALUE   "2".
      *
           03   KGNMCHK-H001-NM1SUJI      PIC X(01)   VALUE   "1".
           03   KGNMCHK-H001-NM1KANJI     PIC X(01)   VALUE   "2".
           03   KGNMCHK-H001-NM1ABT       PIC X(01)   VALUE   "2".
           03   KGNMCHK-H001-NM1HYPN      PIC X(01)   VALUE   "2".
           03   KGNMCHK-H001-NM1KAKKO     PIC X(01)   VALUE   "2".
           03   KGNMCHK-H001-NM1ETC       PIC X(01)   VALUE   "2".
           03   KGNMCHK-H001-NMSUJINASHI  PIC X(01)   VALUE   "2".
      *
           03   KGNMCHK-H001-NM2SUJI      PIC X(01)   VALUE   "1".
           03   KGNMCHK-H001-NM2KANJI     PIC X(01)   VALUE   "2".
           03   KGNMCHK-H001-NM2ABT       PIC X(01)   VALUE   "1".
           03   KGNMCHK-H001-NM2HYPN      PIC X(01)   VALUE   "1".
           03   KGNMCHK-H001-NM2KAKKO     PIC X(01)   VALUE   "2".
           03   KGNMCHK-H001-NM2ETC       PIC X(01)   VALUE   "2".
      ****
           03   KGNMCHK-H031-KGSUJI       PIC X(01)   VALUE   "1".
           03   KGNMCHK-H031-KGKANJI      PIC X(01)   VALUE   "1".
           03   KGNMCHK-H031-KGABT        PIC X(01)   VALUE   "1".
           03   KGNMCHK-H031-KGHYPN       PIC X(01)   VALUE   "1".
           03   KGNMCHK-H031-KGKAKKO      PIC X(01)   VALUE   "1".
           03   KGNMCHK-H031-KGETC        PIC X(01)   VALUE   "1".
           03   KGNMCHK-H031-KGKANJINASHI PIC X(01)   VALUE   "1".
      *
           03   KGNMCHK-H031-NM1SUJI      PIC X(01)   VALUE   "1".
           03   KGNMCHK-H031-NM1KANJI     PIC X(01)   VALUE   "1".
           03   KGNMCHK-H031-NM1ABT       PIC X(01)   VALUE   "1".
           03   KGNMCHK-H031-NM1HYPN      PIC X(01)   VALUE   "2".
           03   KGNMCHK-H031-NM1KAKKO     PIC X(01)   VALUE   "1".
           03   KGNMCHK-H031-NM1ETC       PIC X(01)   VALUE   "2".
           03   KGNMCHK-H031-NMSUJINASHI  PIC X(01)   VALUE   "2".
      *
           03   KGNMCHK-H031-NM2SUJI      PIC X(01)   VALUE   "1".
           03   KGNMCHK-H031-NM2KANJI     PIC X(01)   VALUE   "1".
           03   KGNMCHK-H031-NM2ABT       PIC X(01)   VALUE   "1".
           03   KGNMCHK-H031-NM2HYPN      PIC X(01)   VALUE   "1".
           03   KGNMCHK-H031-NM2KAKKO     PIC X(01)   VALUE   "1".
           03   KGNMCHK-H031-NM2ETC       PIC X(01)   VALUE   "2".
      ****
           03   KGNMCHK-H033-KGSUJI       PIC X(01)   VALUE   "1".
           03   KGNMCHK-H033-KGKANJI      PIC X(01)   VALUE   "1".
           03   KGNMCHK-H033-KGABT        PIC X(01)   VALUE   "1".
           03   KGNMCHK-H033-KGHYPN       PIC X(01)   VALUE   "1".
           03   KGNMCHK-H033-KGKAKKO      PIC X(01)   VALUE   "1".
           03   KGNMCHK-H033-KGETC        PIC X(01)   VALUE   "1".
           03   KGNMCHK-H033-KGKANJINASHI PIC X(01)   VALUE   "2".
      *
           03   KGNMCHK-H033-NM1SUJI      PIC X(01)   VALUE   "1".
           03   KGNMCHK-H033-NM1KANJI     PIC X(01)   VALUE   "2".
           03   KGNMCHK-H033-NM1ABT       PIC X(01)   VALUE   "1".
           03   KGNMCHK-H033-NM1HYPN      PIC X(01)   VALUE   "2".
           03   KGNMCHK-H033-NM1KAKKO     PIC X(01)   VALUE   "2".
           03   KGNMCHK-H033-NM1ETC       PIC X(01)   VALUE   "2".
           03   KGNMCHK-H033-NMSUJINASHI  PIC X(01)   VALUE   "2".
      *
           03   KGNMCHK-H033-NM2SUJI      PIC X(01)   VALUE   "1".
           03   KGNMCHK-H033-NM2KANJI     PIC X(01)   VALUE   "2".
           03   KGNMCHK-H033-NM2ABT       PIC X(01)   VALUE   "1".
           03   KGNMCHK-H033-NM2HYPN      PIC X(01)   VALUE   "1".
           03   KGNMCHK-H033-NM2KAKKO     PIC X(01)   VALUE   "2".
           03   KGNMCHK-H033-NM2ETC       PIC X(01)   VALUE   "2".
      ****
           03   KGNMCHK-H006-KGSUJI       PIC X(01)   VALUE   "1".
           03   KGNMCHK-H006-KGKANJI      PIC X(01)   VALUE   "2".
           03   KGNMCHK-H006-KGABT        PIC X(01)   VALUE   "2".
           03   KGNMCHK-H006-KGHYPN       PIC X(01)   VALUE   "2".
           03   KGNMCHK-H006-KGKAKKO      PIC X(01)   VALUE   "2".
           03   KGNMCHK-H006-KGETC        PIC X(01)   VALUE   "2".
           03   KGNMCHK-H006-KGKANJINASHI PIC X(01)   VALUE   "1".
      *
           03   KGNMCHK-H006-NM1SUJI      PIC X(01)   VALUE   "1".
           03   KGNMCHK-H006-NM1KANJI     PIC X(01)   VALUE   "2".
           03   KGNMCHK-H006-NM1ABT       PIC X(01)   VALUE   "2".
           03   KGNMCHK-H006-NM1HYPN      PIC X(01)   VALUE   "2".
           03   KGNMCHK-H006-NM1KAKKO     PIC X(01)   VALUE   "2".
           03   KGNMCHK-H006-NM1ETC       PIC X(01)   VALUE   "2".
           03   KGNMCHK-H006-NMSUJINASHI  PIC X(01)   VALUE   "2".
      *
           03   KGNMCHK-H006-NM2SUJI      PIC X(01)   VALUE   "1".
           03   KGNMCHK-H006-NM2KANJI     PIC X(01)   VALUE   "2".
           03   KGNMCHK-H006-NM2ABT       PIC X(01)   VALUE   "2".
           03   KGNMCHK-H006-NM2HYPN      PIC X(01)   VALUE   "1".
           03   KGNMCHK-H006-NM2KAKKO     PIC X(01)   VALUE   "2".
           03   KGNMCHK-H006-NM2ETC       PIC X(01)   VALUE   "2".
      ****
           03   KGNMCHK-HDEF-KGSUJI       PIC X(01)   VALUE   "1".
           03   KGNMCHK-HDEF-KGKANJI      PIC X(01)   VALUE   "1".
           03   KGNMCHK-HDEF-KGABT        PIC X(01)   VALUE   "1".
           03   KGNMCHK-HDEF-KGHYPN       PIC X(01)   VALUE   "1".
           03   KGNMCHK-HDEF-KGKAKKO      PIC X(01)   VALUE   "1".
           03   KGNMCHK-HDEF-KGETC        PIC X(01)   VALUE   "1".
           03   KGNMCHK-HDEF-KGKANJINASHI PIC X(01)   VALUE   "1".
      *
           03   KGNMCHK-HDEF-NM1SUJI      PIC X(01)   VALUE   "1".
           03   KGNMCHK-HDEF-NM1KANJI     PIC X(01)   VALUE   "1".
           03   KGNMCHK-HDEF-NM1ABT       PIC X(01)   VALUE   "1".
           03   KGNMCHK-HDEF-NM1HYPN      PIC X(01)   VALUE   "1".
           03   KGNMCHK-HDEF-NM1KAKKO     PIC X(01)   VALUE   "1".
           03   KGNMCHK-HDEF-NM1ETC       PIC X(01)   VALUE   "1".
           03   KGNMCHK-HDEF-NMSUJINASHI  PIC X(01)   VALUE   "2".
      *
           03   KGNMCHK-HDEF-NM2SUJI      PIC X(01)   VALUE   "1".
           03   KGNMCHK-HDEF-NM2KANJI     PIC X(01)   VALUE   "1".
           03   KGNMCHK-HDEF-NM2ABT       PIC X(01)   VALUE   "1".
           03   KGNMCHK-HDEF-NM2HYPN      PIC X(01)   VALUE   "1".
           03   KGNMCHK-HDEF-NM2KAKKO     PIC X(01)   VALUE   "1".
           03   KGNMCHK-HDEF-NM2ETC       PIC X(01)   VALUE   "1".
