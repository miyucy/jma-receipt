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
      *    ＤＰＣ調査対応     順序番号情報 (CPRCF900.INC)      *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  04.00.01    NACL-小豆沢  xx/xx/xx  グループ診療対応
      ************************************************************
      *01  RECE900-REC.
           03  RECE900-KEY.
      *医療機関ＩＤ
               05  RECE900-HOSPNUM         PIC  9(02).
      *診療年月
               05  RECE900-SRYYM           PIC  9(06).
      *患者ＩＤ
               05  RECE900-PTID            PIC  9(10).
      *診療区分        
               05  RECE900-SRYKBN          PIC  X(02).
      *順序番号        
           03  RECE900-RENNUM              PIC  9(04).
