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
      *
      *    自院病名検索 画面ＳＰＡ 
      *            画面　Ｃ０４で使用 
      *          
      *****************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
      *01  SPA-SCR-REC.
      *
           03  SPA-C04.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-LINE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(04).
               05  SPA-DEL-MAX         PIC 9(04).
               05  SPA-GMN-CUR         PIC 9(02).
               05  SPA-GMN-AREA.
                   07  SPA-GMN.
                       09  SPA-GMN-BUNRUICD-TBL.
                           11  SPA-GMN-BUNRUICD-TBLO   OCCURS   100.
                               13  SPA-GMN-BBUNRUICD   PIC 9(03).
                               13  SPA-GMN-BBUNRUIMEI  PIC X(20).
                           11  SPA-GMN-BUNRUI-MAX      PIC 9(04).
      *
                       09  SPA-GMN-BYOMEI-TBL.
                           11  SPA-GMN-TBLO            OCCURS   700.
                               13  SPA-GMN-TBANGO      PIC 9(03).
                               13  SPA-GMN-TBUNRUIMEI  PIC X(16).
                               13  SPA-GMN-TINPUTCD    PIC X(10).
                               13  SPA-GMN-TBYOMEI     PIC X(81).
      *                 
                       09  SPA-GMN-KOUMOKU.
                           11  SPA-GMN-SELNUM1         PIC 9(03).
                           11  SPA-GMN-SELNUM2         PIC 9(03).
                           11  SPA-GMN-INPUTCD-G.
                               13  SPA-GMN-INPUTCD     OCCURS  6
                                                       PIC X(10).
                           11  SPA-GMN-BYOMEI          PIC X(400).
                           11  SPA-GMN-KENBYOMEI       PIC X(50).
      *
                   07  SPA-NAIB-AREA.
                       09  SPA-NAI-TBL.
                           11  SPA-NAI-TBLO         OCCURS   700.
                               13  SPA-NAI-TRENNUM      PIC 9(03). 
                               13  SPA-NAI-TBUNRUICD    PIC 9(03).                         
                               13  SPA-NAI-TCDSYU       PIC X(01).    
      *                         
                       09  SPA-NAI-SELNUM1              PIC 9(03).
                       09  SPA-NAI-SELNUM2              PIC 9(03).
                       09  SPA-NAI-BYOMEI-G.
                           11  SPA-NAI-BYOMEI           OCCURS  6
                                                        PIC X(80).
