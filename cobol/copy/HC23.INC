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
            01  HC23.
              03  HC23-SYOSHINMONEY      PIC  X(7).
              03  HC23-SAISHINMONEY      PIC  X(7).
              03  HC23-SRYKBN            PIC  X(2)   OCCURS  26.
              03  HC23-SHIDOMONEY        PIC  X(7).
              03  HC23-KASANMONEY        PIC  X(7).
              03  HC23-SAISINKAISU       PIC  X(2).
              03  HC23-SHIDOKAISU        PIC  X(2).
              03  HC23-TEKIYO2           PIC  X(52)  OCCURS  26.
              03  HC23-TEKIYO1           PIC  X(24)  OCCURS  6.
              03  HC23-SYOKEIMONEY       PIC  X(7).
              03  HC23-OTHERMONEY        PIC  X(7).
              03  HC23-SEIKYU            PIC  X(2)   OCCURS  2.
              03  HC23-TSUINMM           PIC  X(2)   OCCURS  2.
              03  HC23-SHINDANSYOMONEY   PIC  X(7).
              03  HC23-MEISAISYOMONEY    PIC  X(7).
              03  HC23-SHINDANSYOSUU     PIC  X(3).
              03  HC23-MEISAISYOSUU      PIC  X(3).
              03  HC23-TSUINSUU          PIC  X(2)   OCCURS  2.
              03  HC23-JITSUNISSU        PIC  X(2).
              03  HC23-NAME              PIC  X(26).
              03  HC23-SEINENGAPPI       PIC  X(2).
              03  HC23-NENNREI           PIC  X(2).
              03  HC23-SEIKYUGAKUTOTAL   PIC  X(7).
              03  HC23-HAKKOUYY          PIC  X(2).
              03  HC23-HAKKOUMM          PIC  X(2).
              03  HC23-HOSPJYUSYO        PIC  X(40).
              03  HC23-HOSPNAME          PIC  X(30).
              03  HC23-TEL               PIC  X(15).
              03  HC23-ISYA              PIC  X(40).
              03  HC23-MEIJI             PIC  X(2).
              03  HC23-TAISYO            PIC  X(2).
              03  HC23-SYOUWA            PIC  X(3).
              03  HC23-HEISEI            PIC  X(3).
              03  HC23-MAN               PIC  X(3).
              03  HC23-WOMAN             PIC  X(3).
              03  HC23-TENKI             PIC  X(2)   OCCURS  5.
              03  HC23-TSUIN1            PIC  X(2)   OCCURS  31.
              03  HC23-TSUIN2            PIC  X(2)   OCCURS  31.
              03  HC23-KAISU             PIC  X(3)   OCCURS  35.
              03  HC23-KOUTEN            PIC  X(7)   OCCURS  35.
              03  HC23-KHNTEN            PIC  X(3)   OCCURS  35.
              03  HC23-SYOBYO            PIC  X(44)  OCCURS  3.
              03  HC23-JYUSYOUBI
                  05  HC23-JYUSYOUBIYY   PIC  X(2).
                  05  HC23-JYUSYOUBIMM   PIC  X(2).
                  05  HC23-JYUSYOUBIDD   PIC  X(2).
              03  HC23-SYOSHINBI
                  05  HC23-SYOSHINBIYY   PIC  X(2).
                  05  HC23-SYOSHINBIMM   PIC  X(2).
                  05  HC23-SYOSHINBIDD   PIC  X(2).
              03  HC23-STR
                  05  HC23-STRYY         PIC  X(2).
                  05  HC23-STRMM         PIC  X(2).
                  05  HC23-STRDD         PIC  X(2).
              03  HC23-END
                  05  HC23-ENDYY         PIC  X(2).
                  05  HC23-ENDMM         PIC  X(2).
                  05  HC23-ENDDD         PIC  X(2).
              03  HC23-SEIKYU
                  05  HC23-SEIKYUYY      PIC  X(2).
                  05  HC23-SEIKYUMM      PIC  X(2).
                  05  HC23-SEIKYUDD      PIC  X(2).
              03  HC23-SEIKYUGAKU        PIC  X(9)   OCCURS  5.