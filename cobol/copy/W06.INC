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
         02  W06.
                03  W06-FIXED1.
                  04  W06-YUKOSTYMD       PIC X(9).
                  04  W06-YUKOEDYMD       PIC X(9).
                  04  W06-KBNCD           PIC X(5).
                  04  W06-KBNNAME         PIC X(20).
                  04  W06-USERID          PIC X(16).
                  04  W06-KANANAME        PIC X(80).
                  04  W06-NAME            PIC X(80).
                  04  W06-ISEKINUM        PIC X(8).
                  04  W06-HKNDRNUMS       PIC X(8).
                  04  W06-HKNDRNUMK       PIC X(12).
                  04  W06-MAYAKULICENSE   PIC X(40).
                  04  W06-SEMONKACOMBO        OCCURS  5.
                    05  W06-SEMONKACD.
                      06  W06-CD-VALUE    PIC X(17).
                    05  W06-CD-COUNT      PIC S9(9)   BINARY.
                    05  W06-CD-ITEM       PIC X(17)   OCCURS  50.
                  04  W06-CHK01            PIC X.
                  04  W06-CHK02            PIC X.
                  04  W06-CHK03            PIC X.
                  04  W06-CHK04            PIC X.
                  04  W06-CHK05            PIC X.
                  04  W06-CHK06            PIC X.
                  04  W06-CHK07            PIC X.
                  04  W06-CHK08            PIC X.
                  04  W06-CHK09            PIC X.
                  04  W06-CHK27           PIC X.
                  04  W06-CHK28           PIC X.
                  04  W06-CHK29           PIC X.
                  04  W06-CHK30           PIC X.
                  04  W06-CHK31           PIC X.
                  04  W06-CHK32           PIC X.
                  04  W06-CHK10           PIC X.
                  04  W06-CHK11           PIC X.
                  04  W06-CHK12           PIC X.
                  04  W06-CHK13           PIC X.
                  04  W06-CHK14           PIC X.
                  04  W06-CHK15           PIC X.
                  04  W06-CHK16           PIC X.
                  04  W06-CHK17           PIC X.
                  04  W06-CHK18           PIC X.
                  04  W06-CHK19.
                    05  W06-CHK19-VALUE   PIC X.
                    05  W06-CHK19-STATE   PIC S9(9)   BINARY.
                  04  W06-CHK20           PIC X.
                  04  W06-CHK21           PIC X.
                  04  W06-CHK22           PIC X.
                  04  W06-CHK23           PIC X.
                  04  W06-CHK24           PIC X.
                  04  W06-CHK25           PIC X.
                  04  W06-CHK26           PIC X.
                  04  W06-KANRIAUTHCOMBO.
                    05  W06-KANRIAUTHFLG.
                      06  W06-FLG-VALUE   PIC X(12).
                    05  W06-FLG-COUNT     PIC S9(9)   BINARY.
                    05  W06-FLG-ITEM      PIC X(12)   OCCURS  2.
                  04  W06-B03.
                    05  W06-B03-STATE     PIC S9(9)   BINARY.
