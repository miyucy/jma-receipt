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
      *  薬効ファイル       (CPMEDYAKKO.INC)  
      *****************************************************************
      *****************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *01  MEDYAKKO-REC.
      *
           03  MYAK-KEY.
      *医薬品コード
               05  MYAK-IYAKUHINCD      PIC X(09).
      *連番号
               05  MYAK-RENNUM          PIC 9(04).
      *適応病名
           03  MYAK-TEKIOUBYOMEI        PIC X(400).
      *病名コード数
           03  MYAK-BYOMEICDSU          PIC 9(02).
      *病名コード
           03  MYAK-BYOMEICD-G.
               05  MYAK-BYOMEICD-1      PIC X(07).
               05  MYAK-BYOMEICD-2      PIC X(07).
               05  MYAK-BYOMEICD-3      PIC X(07).
               05  MYAK-BYOMEICD-4      PIC X(07).
               05  MYAK-BYOMEICD-5      PIC X(07).
               05  MYAK-BYOMEICD-6      PIC X(07).
               05  MYAK-BYOMEICD-7      PIC X(07).
               05  MYAK-BYOMEICD-8      PIC X(07).
               05  MYAK-BYOMEICD-9      PIC X(07).
               05  MYAK-BYOMEICD-10     PIC X(07).
               05  MYAK-BYOMEICD-11     PIC X(07).
               05  MYAK-BYOMEICD-12     PIC X(07).
               05  MYAK-BYOMEICD-13     PIC X(07).
               05  MYAK-BYOMEICD-14     PIC X(07).
               05  MYAK-BYOMEICD-15     PIC X(07).
               05  MYAK-BYOMEICD-16     PIC X(07).
               05  MYAK-BYOMEICD-17     PIC X(07).
               05  MYAK-BYOMEICD-18     PIC X(07).
               05  MYAK-BYOMEICD-19     PIC X(07).
               05  MYAK-BYOMEICD-20     PIC X(07).
               05  MYAK-BYOMEICD-21     PIC X(07).
      *
           03  MYAK-BYOMEICD-R          REDEFINES   MYAK-BYOMEICD-G.
               05  MYAK-BYOMEICD        PIC X(07)
                                         OCCURS   21.
      *病名編集フラグ
           03  MYAK-BYOMEIHENFLG        PIC X(01).
      *作成年月日
           03  MYAK-CREYMD              PIC X(08).
      *
      *検索用項目
           03  MYAK-SELNAME             PIC  X(200).
           03  MYAK-SELYUKOSTYMD        PIC  X(8).
           03  MYAK-SELYUKOEDYMD        PIC  X(8).
