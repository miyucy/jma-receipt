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
      *    レセプト明細書     COPY (CPRCF0442.INC)               *
      *                       診療科違いの同一剤のまとめ用       *  
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RECE442-REC.
           03  RECE442-KEY.
      *医療機関ＩＤ
               05  RECE442-HOSPID          PIC  X(24).
      *診療年月
               05  RECE442-SRYYM           PIC  9(06).
      *入外区分
               05  RECE442-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE442-PTID            PIC  9(10).
      *保険ＩＤ        
               05  RECE442-HKNID           PIC  9(10).
      *適用開始年月日
               05  RECE442-TEKSTYMD        PIC  X(08). 
      *診療区分
               05  RECE442-SRYKBN          PIC  X(02).
      *剤点数
               05  RECE442-ZAITEN          PIC  9(08).
      *診療コード計
               05  RECE442-SRYCDTOTAL      PIC  9(14).
      *数量計
               05  RECE442-SURYOUTOTAL     PIC  9(07)V9(03).
      *明細数
               05  RECE442-MEISAISU        PIC  9(04).
      *コメント剤連番
               05  RECE442-COMRENNUM       PIC  9(05).
      *剤回数
           03  RECE442-ZAIKAISU            PIC  9(04).
      *日数回数テーブル
           03  RECE442-DAY-AREA.
      *        診療回数テーブル（1:合計,2:１回,3:２回, 4:３回以上）
               05  RECE442-DAY-TBL         OCCURS  4.
                   07  RECE442-KAISUINF    OCCURS  31.
                       09  RECE442-KAISU   PIC  9(03).
      *データ
           03  RECE442-REC1                PIC  X(600).
