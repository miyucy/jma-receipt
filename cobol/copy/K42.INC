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
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
        02  K42.
      ****  02  K42-FIXED2.
            03  K42-TITLE          PIC X(120).
              03  K42-PTNUM.
                04  K42-VALUE   PIC X(20).
              03  K42-KANANAME-G.
                04  K42-KANANAME-STYLE   PIC X(20).
                04  K42-KANANAME   PIC X(50).
              03  K42-NAME-G.
                04  K42-NAME-STYLE   PIC X(20).
                04  K42-NAME   PIC X(50).
              03  K42-BIRTHDAY.
                04  K42-VALUE   PIC X(9).
              03  K42-SEX.
                04  K42-VALUE   PIC X(2).
              03  K42-RATE.
                04  K42-VALUE   PIC X(6).
              03  K42-LASTYMD.
                04  K42-VALUE   PIC X(24).
              03  K42-SYOSINYMD.
                04  K42-VALUE   PIC X(24).
              03  K42-MISYUMONEY.
                04  K42-VALUE   PIC X(15).
              03  K42-SRYYMD.
                04  K42-VALUE   PIC X(14).
              03  K42-GOKEITEN.
                04  K42-VALUE   PIC X(15).
              03  K42-NENREI.
                04  K42-VALUE   PIC X(6).
              03  K42-ZAITENTOTAL.
                04  K42-VALUE   PIC X(15).
              03  K42-INGAI.
                04  K42-INGAI-VALUE   PIC X.
                04  K42-INGAI-LABEL   PIC X(10).
              03  K42-DOSELNUM.
                04  K42-VALUE   PIC X(4).
              03  K42-TEISEI.
                04  K42-TEISEI-VALUE   PIC X.
                04  K42-TEISEI-LABEL   PIC X(10).
              03  K42-HKNCOMBICOMB.
                04  K42-HKNCOMBI.
                  05  K42-VALUE   PIC X(65).
                04  K42-HKNCOMBI-COUNT   PIC S9(9)   BINARY.
                04  K42-HKNCOMBI-ITEM    PIC X(65)   OCCURS  15 TIMES.
              03  K42-CONTKBN.
                04  K42-CONTKBN-STYLE   PIC X(20).
                04  K42-CONTKBN-VALUE   PIC X(6).
              03  K42-MODE.
                04  K42-VALUE   PIC X(10).
              03  K42-SRYKACOMB.
                04  K42-SRYKA.
                  05  K42-VALUE   PIC X(16).
                04  K42-SRYKA-COUNT   PIC S9(9)   BINARY.
                04  K42-SRYKA-ITEM    PIC X(16)   OCCURS  40 TIMES.
              03  K42-TABOOCOB.
                04  K42-TABOO.
                  05  K42-VALUE   PIC X(62).
                04  K42-TABOO-COUNT   PIC S9(9)   BINARY.
                04  K42-TABOO-ITEM    PIC X(62)   OCCURS  40 TIMES.
              03  K42-SYORIMEI.
                04  K42-SYORIMEI-STYLE   PIC X(20).
                04  K42-SYORIMEI-VALUE   PIC X(12).
              03  K42-SCROLLEDWINDOW1.
                04  K42-RRKLIST.
                  05  K42-COUNT   PIC S9(9)   BINARY.
                  05  K42-ROW     PIC S9(9)   BINARY.
                  05  K42-ROWATTR PIC S9(9)   BINARY.
                  05  K42-ITEM        OCCURS  150 TIMES.
                    06  K42-NO      PIC X(4).
                    06  K42-RRKYMD  PIC X(13).
                    06  K42-RRKSRYKA  PIC X(2).
                    06  K42-RRKHKNCOMBI  PIC X(04).
                  05  K42-SELECT  PIC X       OCCURS  150 TIMES.
              03  K42-JIKANMSG.
                04  K42-JIKANMSG-STYLE   PIC X(20).
                04  K42-JIKANMSG-VALUE   PIC X(20).
              03  K42-B04S.
                04  K42-B04S-STATE   PIC S9(9)   BINARY.
              03  K42-B05S.
                04  K42-B05S-STATE   PIC S9(9)   BINARY.
              03  K42-B07S.
                04  K42-B07S-STATE   PIC S9(9)   BINARY.
              03  K42-B08S.
                04  K42-B08S-STATE   PIC S9(9)   BINARY.
              03  K42-B09S.
                04  K42-B09S-STATE   PIC S9(9)   BINARY.
              03  K42-B06S.
                04  K42-B06S-LABEL   PIC X(10).
              03  K42-DRNAME.
                04  K42-VALUE   PIC X(50).
              03  K42-SCROLLEDWINDOW2.
                04  K42-BYOMEILST.
                  05  K42-BYOMEI-COUNT   PIC S9(9)   BINARY.
                  05  K42-BYOMEI-ROW PIC S9(9)   BINARY.
                  05  K42-BYOMEI-ROWATTR PIC S9(9)   BINARY.
                  05  K42-ITEM        OCCURS  100 TIMES.
                    06  K42-BYOMEIKA     PIC X(02).
                    06  K42-BYOMEI       PIC X(22).
                  05  K42-BYOMEI-SELECT
                          PIC X       OCCURS  100 TIMES.
              03  K42-LASTMID.
                04  K42-VALUE   PIC X(20).
              03  K42-KOHMSG.
                04  K42-KOHMSG-STYLE   PIC X(20).
                04  K42-KOHMSG-VALUE   PIC X(50).
              03  K42-GRPMEI.
                04  K42-GRPMEI-STYLE   PIC X(20).
                04  K42-GRPMEI-VALUE   PIC X(10).
              03  K42-B12.
                04  K42-B12-STATE   PIC S9(9)   BINARY.
              03  K42-B12S.
                04  K42-B12S-STATE   PIC S9(9)   BINARY.
              03  K42-BC10.
                04  K42-BC10-STYLE  PIC X(20).
                04  K42-BC10-LABEL  PIC X(8).

              03  K42-SCROLLEDWINDOW3.
                04  K42-PANDATABLE1.
                  05  K42-PANDATABLE1-STATE   PIC S9(9)   BINARY.
                  05  K42-PANDATABLE1-STYLE   PIC X(20).
                  05  K42-PANDATABLE1-TROW    PIC S9(9)   BINARY.
                  05  K42-PANDATABLE1-TROWATTR    PIC S9(9)   BINARY.
                  05  K42-PANDATABLE1-TCOLUMN PIC S9(9)   BINARY.
                  05  K42-PANDATABLE1-TVALUE  PIC X(256).
                  05  K42-PANDATABLE1-FGCOLORS
                          PIC X(20)  OCCURS  400 TIMES.
                  05  K42-PANDATABLE1-BGCOLORS
                          PIC X(20)  OCCURS  400 TIMES.
                  05  K42-PANDATABLE1-TDATA           OCCURS  400 TIMES.
                    06  K42-SRYKBN  PIC X(2).
                    06  K42-INPUTCD PIC X(54).
                    06  K42-MEISYO  PIC X(80).
                    06  K42-SURYO   PIC X(60).
