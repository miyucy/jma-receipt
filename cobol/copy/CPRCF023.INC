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
      *    レセプト電算・ 傷病名レコード       (CPRCF023.INC)    *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RECE23-REC.
      *レコード共通
           03  RECE23-KYOTU-AREA.
      *レコード長
               05  RECE23-LENGTH          PIC  9(04).
      *レコード種別    
               05  RECE23-SYUBETU         PIC  9(02).
      *レセプト番号
               05  RECE23-RECENUM         PIC  9(06).
      *レコード番号
               05  RECE23-RECNUM          PIC  9(03).
      *実日数情報
           03  RECE23-JNISSUINF.
             05  RECE23-JNISSUINF-TBL     OCCURS  3.
      *実日数
               07  RECE23-JNISSU          PIC  X(02).
      *傷病名情報
           03  RECE23-SYOBYO-AREA.
      *傷病名データ
               05  RECE23-SYOBYOF         OCCURS  3.
      *傷病名コード
                   07  RECE23-BYOMEICD    PIC  X(07).
      *修飾語コード１
                   07  RECE23-SYUSYOKUCD1 PIC  X(04).
      *修飾語コード２
                   07  RECE23-SYUSYOKUCD2 PIC  X(04).
      *診療開始日
                   07  RECE23-SRYYMD      PIC  X(06).
      *転帰区分
                   07  RECE23-TENKIKBN    PIC  X(01).
      *病名
                   07  RECE23-BYOMEI      PIC  X(40).
      *診療開始日（年号）
                   07  RECE23-SRYNENGO    PIC  X(01).
      *予備        
                   07  RECE23-YOBI        PIC  X(13).
      *実日数（第二老人）
                   07  RECE23-JNISSU-ROU  PIC  X(02).
      *予備        
           03  RECE23-YOBI1               PIC  X(01).
      *改行コード
           03  RECE23-RETURNCD            PIC  X(01).
      