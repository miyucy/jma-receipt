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
      *  予約マスター       (CPYYK.INC) 
      *****************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  YYK-REC.
           03  YYK-KEY.
      *医療機関ＩＤ
               05  YYK-HOSPNUM          PIC 9(2).
      *診療内容
               05  YYK-SRYNAIYO        PIC X(02).
      *ドクターコード
               05  YYK-DRCD            PIC X(05).
      *予約年月日
               05  YYK-YYKYMD          PIC X(08).
      *キー予約時間
               05  YYK-KEYYYKTIME      PIC 9(04).
      *予約ＩＤ
               05  YYK-YYKID           PIC 9(02).
      *予約件数（ＩＤ＝００）
           03  YYK-NAIYOU1.
      *予約最大件数
               05  YYK-YYKMAXCNT       PIC 9(03).
      *予約件数
               05  YYK-YYKCNT          PIC 9(03).
      *予約時間
           03  YYK-YYKTIME             PIC 9(04).
      *患者ＩＤ
           03  YYK-PTID                PIC 9(10).
      *患者氏名
           03  YYK-NAME                PIC X(100).
      *診療科
           03  YYK-SRYKA               PIC X(02).
      *予約区分
           03  YYK-YYKKBN              PIC X(02).
      *確認連絡
           03  YYK-KAKREN              PIC X(02).
      *来院済
           03  YYK-RAIINZUMI           PIC X(01).
      *端末ＩＤ
           03  YYK-TERMID              PIC  X(16).
      *オペーレータＩＤ
           03  YYK-OPID                PIC  X(16).
      *作成年月日
           03  YYK-CREYMD              PIC  X(08).
      *更新年月日
           03  YYK-UPYMD               PIC  X(08).
      *更新時間
           03  YYK-UPHMS               PIC  X(06).
