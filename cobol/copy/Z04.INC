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
        02  Z04.
      ***  02  Z04-FIXED6.
              03  Z04-SRYCDH.
                04  Z04-VALUE   PIC X(9).
              03  Z04-NAMEH.
                04  Z04-VALUE   PIC X(100).
              03  Z04-YUKOSTYMDH.
                04  Z04-VALUE   PIC X(9).
              03  Z04-YUKOEDYMDH.
                04  Z04-VALUE   PIC X(9).
              03  Z04-KANANAME.
                04  Z04-VALUE   PIC X(100).
              03  Z04-SHONAME.
                04  Z04-VALUE   PIC X(100).
              03  Z04-NAME.
                04  Z04-VALUE   PIC X(100).
              03  Z04-TEN.
                04  Z04-VALUE   PIC S9(8)V9(2).
              03  Z04-OLDTEN.
                04  Z04-VALUE   PIC S9(8)V9(2).
              03  Z04-YAKKAKJNCD.
                04  Z04-VALUE   PIC X(12).
              03  Z04-SYOMEIKANREN.
                04  Z04-VALUE   PIC X(9).
              03  Z04-KEIKASOCHIYMD.
                04  Z04-VALUE   PIC X(10).
              03  Z04-YUKOSTYMD.
                04  Z04-VALUE   PIC X(10).
              03  Z04-YUKOEDYMD.
                04  Z04-VALUE   PIC X(10).
              03  Z04-CSYYOURYO.
                04  Z04-VALUE   PIC S9(5).
              03  Z04-KOUHYOJYUNNUM.
                04  Z04-VALUE   PIC S9(9).
              03  Z04-MADOKUKBN-COMBO.
                04  Z04-MADOKUKBN.
                  05  Z04-VALUE   PIC X(16).
                04  Z04-MADOKUKBN-COUNT   PIC S9(9)   BINARY.
                04  Z04-MADOKUKBNLST   PIC X(16)   OCCURS  5 TIMES.
              03  Z04-SINKEIHAKAIKBN-COMBO.
                04  Z04-SINKEIHAKAIKBN.
                  05  Z04-VALUE   PIC X(18).
                04  Z04-SINKEIHAKAIKBN-COUNT   PIC S9(9)   BINARY.
                04  Z04-SINKEIHAKAIKBNLST    PIC X(18)   OCCURS  2.
              03  Z04-SEIBUTUGAKUKBN-COMBO.
                04  Z04-SEIBUTUGAKUKBN.
                  05  Z04-VALUE   PIC X(32).
                04  Z04-SEIBUTUGAKUKBN-COUNT   PIC S9(9)   BINARY.
                04  Z04-SEIBUTUGAKUKBNLST   PIC X(32)   OCCURS  2 TIMES.
              03  Z04-ZOEIZAIKBN-COMBO.
                04  Z04-ZOEIZAIKBN.
                  05  Z04-VALUE   PIC X(26).
                04  Z04-ZOEIZAIKBN-COUNT   PIC S9(9)   BINARY.
                04  Z04-ZOEIZAIKBNLST  PIC X(26)   OCCURS  3 TIMES.
              03  Z04-YKZKBN-COMBO.
                04  Z04-YKZKBN.
                  05  Z04-VALUE   PIC X(16).
                04  Z04-YKZKBN-COUNT   PIC S9(9)   BINARY.
                04  Z04-YKZKBNLST    PIC X(16)   OCCURS  6 TIMES.
              03  Z04-LONGTOYOKBN.
                04  Z04-VALUE   PIC S9(1).
              03  Z04-TENSIKIBETU-COMBO.
                04  Z04-TENSIKIBETU.
                  05  Z04-VALUE   PIC X(20).
                04  Z04-TENSIKIBETU-COUNT   PIC S9(9)   BINARY.
                04  Z04-TENSIKIBETULST  PIC X(20)   OCCURS  3 TIMES.
              03  Z04-OLDTENSKB-COMBO.
                04  Z04-OLDTENSKB.
                  05  Z04-VALUE   PIC X(20).
                04  Z04-OLDTENSKB-COUNT   PIC S9(9)   BINARY.
                04  Z04-OLDTENSKBLST   PIC X(20)   OCCURS  3 TIMES.
              03  Z04-SYUSAISKB.
                04  Z04-VALUE   PIC S9(1).
              03  Z04-FORMALNAME.
                04  Z04-VALUE   PIC X(200).
              03  Z04-INPCHKKBN.
                04  Z04-VALUE   PIC S9(1).
              03  Z04-ZAIGATAKBN-COMBO.
                04  Z04-ZAIGATAKBN.
                  05  Z04-VALUE   PIC X(36).
                04  Z04-ZAIGATAKBN-COUNT   PIC S9(9)   BINARY.
                04  Z04-ZAIGATAKBNLST   PIC X(36)   OCCURS  4 TIMES.
              03  Z04-KOUHATUKBN-COMB.
                04  Z04-KOUHATUKBN.
                  05  Z04-VALUE   PIC X(20).
                04  Z04-KOUHATUKBN-COUNT   PIC S9(9)   BINARY.
                04  Z04-KOUHATUKBN-ITEM   PIC X(20)   OCCURS  2 TIMES.
              03  Z04-TANICD-COMBO.
                04  Z04-TANICD.
                  05  Z04-VALUE   PIC X(14).
                04  Z04-TANICD-COUNT   PIC S9(9)   BINARY.
                04  Z04-TANICDLST   PIC X(14)   OCCURS  90 TIMES.
              03  Z04-BUNRUIKBN-COMBO.
                04  Z04-BUNRUIKBN.
                  05  Z04-VALUE   PIC X(43).
                04  Z04-BUNRUIKBN-COUNT   PIC S9(9)   BINARY.
                04  Z04-BUNRUIKBNLST   PIC X(43)   OCCURS  20 TIMES.
