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
      *----------------------------------------------------------------*
      *    レセ電診療科コードテーブル   COPY (CMRECEDENSRYKACD.INC)      *
      *----------------------------------------------------------------*
      *****************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  03.03.01    NACL-藤原    06/10/16  心療内科に修正
      *
      *  04.05.01    NACL-藤原    10/03/23  平成２２年４月改正対応
      *****************************************************************
      *
      *    レセ電診療科コードテーブル
       01  TBL-RECEDENSRYKACD-AREA.
               05  FILLER          PIC X(02)   VALUE   "01". 
               05  FILLER          PIC X(20)   VALUE   "内科".
               05  FILLER          PIC X(02)   VALUE   "02". 
               05  FILLER          PIC X(20)   VALUE   "精神科".
               05  FILLER          PIC X(02)   VALUE   "03". 
               05  FILLER          PIC X(20)   VALUE   "神経科".
               05  FILLER          PIC X(02)   VALUE   "04". 
               05  FILLER          PIC X(20)   VALUE   "神経内科".
               05  FILLER          PIC X(02)   VALUE   "05". 
               05  FILLER          PIC X(20)   VALUE   "呼吸器科".
               05  FILLER          PIC X(02)   VALUE   "06". 
               05  FILLER          PIC X(20)   VALUE   "消化器科".
               05  FILLER          PIC X(02)   VALUE   "07". 
               05  FILLER          PIC X(20)   VALUE   "胃腸科".
               05  FILLER          PIC X(02)   VALUE   "08". 
               05  FILLER          PIC X(20)   VALUE   "循環器科".
               05  FILLER          PIC X(02)   VALUE   "09". 
               05  FILLER          PIC X(20)   VALUE   "小児科".
               05  FILLER          PIC X(02)   VALUE   "10". 
               05  FILLER          PIC X(20)   VALUE   "外科".
               05  FILLER          PIC X(02)   VALUE   "11". 
               05  FILLER          PIC X(20)   VALUE   "整形外科".
               05  FILLER          PIC X(02)   VALUE   "12". 
               05  FILLER          PIC X(20)   VALUE   "形成外科".
               05  FILLER          PIC X(02)   VALUE   "13". 
               05  FILLER          PIC X(20)   VALUE   "美容外科".
               05  FILLER          PIC X(02)   VALUE   "14". 
               05  FILLER          PIC X(20)   VALUE   "脳神経外科".
               05  FILLER          PIC X(02)   VALUE   "15". 
               05  FILLER          PIC X(20)   VALUE   "呼吸器外科".
               05  FILLER          PIC X(02)   VALUE   "16". 
               05  FILLER          PIC X(20)   VALUE   "心臓血管外科".
               05  FILLER          PIC X(02)   VALUE   "17". 
               05  FILLER          PIC X(20)   VALUE   "小児外科".
               05  FILLER          PIC X(02)   VALUE   "18". 
               05  FILLER          PIC X(20)   VALUE   "皮膚泌尿器科".
               05  FILLER          PIC X(02)   VALUE   "19". 
               05  FILLER          PIC X(20)   VALUE   "皮膚科".
               05  FILLER          PIC X(02)   VALUE   "20". 
               05  FILLER          PIC X(20)   VALUE   "泌尿器科".
               05  FILLER          PIC X(02)   VALUE   "21". 
               05  FILLER          PIC X(20)   VALUE   "性病科".
               05  FILLER          PIC X(02)   VALUE   "22". 
               05  FILLER          PIC X(20)   VALUE   "こう門科".
               05  FILLER          PIC X(02)   VALUE   "23". 
               05  FILLER          PIC X(20)   VALUE   "産婦人科".
               05  FILLER          PIC X(02)   VALUE   "24". 
               05  FILLER          PIC X(20)   VALUE   "産科".
               05  FILLER          PIC X(02)   VALUE   "25". 
               05  FILLER          PIC X(20)   VALUE   "婦人科".
               05  FILLER          PIC X(02)   VALUE   "26". 
               05  FILLER          PIC X(20)   VALUE   "眼科".
               05  FILLER          PIC X(02)   VALUE   "27". 
               05  FILLER          PIC X(20)   VALUE   "耳鼻いんこう科".
               05  FILLER          PIC X(02)   VALUE   "28". 
               05  FILLER          PIC X(20)   VALUE   "気管食道科".
               05  FILLER          PIC X(02)   VALUE   "30". 
               05  FILLER          PIC X(20)   VALUE   "放射線科".
               05  FILLER          PIC X(02)   VALUE   "31". 
               05  FILLER          PIC X(20)   VALUE   "麻酔科".
               05  FILLER          PIC X(02)   VALUE   "33". 
               05  FILLER          PIC X(20)   VALUE   "心療内科".
               05  FILLER          PIC X(02)   VALUE   "34". 
               05  FILLER          PIC X(20)   VALUE   "アレルギー科".
               05  FILLER          PIC X(02)   VALUE   "35". 
               05  FILLER          PIC X(20)   VALUE   "リウマチ科".
               05  FILLER          PIC X(02)   VALUE   "36". 
               05  FILLER          PIC X(20)   VALUE
                                               "リハビリテーション科".
               05  FILLER          PIC X(02)   VALUE   "37". 
               05  FILLER          PIC X(20)   VALUE   "病理診断科".
               05  FILLER          PIC X(02)   VALUE   "38". 
               05  FILLER          PIC X(20)   VALUE   "臨床検査科".
               05  FILLER          PIC X(02)   VALUE   "39". 
               05  FILLER          PIC X(20)   VALUE   "救急科".
      *
       01  TBL-RECEDENSRYKACD-AREA-R   REDEFINES
                                               TBL-RECEDENSRYKACD-AREA.
           03  TBL-RECEDENSRYKACD-OCC  OCCURS      37
                                       INDEXED TBL-RECEDENSRYKACD-IDX.
               05  TBL-RECEDEN-SRYKACD
                                   PIC X(02).
               05  TBL-RECEDEN-SRYKANAME
                                   PIC X(20).
      *
       01  TBL-RECEDENSRYKACD-MAX  PIC 9(02)   VALUE   37.

