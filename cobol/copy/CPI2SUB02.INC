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
       01  I2SUB02-AREA.
           03  I2SUB02-API-FLG     PIC 9(01).
           03  I2SUB02-MODE        PIC X(01).
           03  I2SUB02-BASEYMD     PIC X(08).
           03  I2SUB02-PTID        PIC 9(10).
           03  I2SUB02-NAME        PIC X(30).
           03  I2SUB02-ADRS        PIC X(100).
           03  I2SUB02-STNYUINYMD  PIC X(08).
           03  I2SUB02-EDNYUINYMD  PIC X(08).
           03  I2SUB02-STTAIINYMD  PIC X(08).
           03  I2SUB02-EDTAIINYMD  PIC X(08).
           03  I2SUB02-SRYKA       PIC X(02).
           03  I2SUB02-STAGE       PIC 9(03).
           03  I2SUB02-EDAGE       PIC 9(03).
           03  I2SUB02-STBIRTHDAY  PIC X(08).
           03  I2SUB02-EDBIRTHDAY  PIC X(08).
           03  I2SUB02-BTUNUM      PIC X(02).
           03  I2SUB02-JOTAI       PIC X(01).
           03  I2SUB02-SEIKYUJOTAI PIC X(01).
           03  I2SUB02-TEIKIYM     PIC X(06).
           03  I2SUB02-KBT         PIC X(01).
           03  I2SUB02-TSTPT       PIC X(1).
           03  I2SUB02-TAIINCD     PIC X(02).
           03  I2SUB02-DEATHKBN    PIC X(01).
           03  I2SUB02-SORT-OCC    OCCURS 3.
      *
      *    1:病棟・病室/2:患者番号/3:カナ氏名
      *    4,5:入院日/6,7:退院日
               05  I2SUB02-SORT-CD PIC X(01).
      *    1:昇順/2:降順
               05  I2SUB02-SORT-ORDER
                                   PIC X(01).
           03  I2SUB02-MEMO        PIC X(2000).
           03  I2SUB02-LAST-TEIKIYM
                                   PIC X(06).
           03  I2SUB02-LAST-KBT
                                   PIC X(01).
           03  I2SUB02-SELYMD      PIC X(08).
           03  I2SUB02-SELHMS      PIC X(08).
           03  I2SUB02-ORCA-UID    PIC X(64).
           03  I2SUB02-RC          PIC 9(02).
