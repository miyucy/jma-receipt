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
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
        02  P98.
     *******02  P98-FIXED1.
              03  P98-ADRS.
                04  P98-VALUE   PIC X(101).
              03  P98-POST.
                04  P98-VALUE   PIC X(8).
              03  P98-TADRS-G OCCURS  50.
                  04  P98-TADRS   PIC X(21).
              03  P98-SELNUM.
                04  P98-VALUE   PIC S9(3).
              03  P98-CHK-TADRS011.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS021.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS031.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS041.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS051.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS061.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS012.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS022.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS032.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS052.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS072.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS082.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS092.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS062.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS102.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS013.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS033.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS043.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS053.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS063.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS073.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS083.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS093.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS014.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS024.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS034.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS044.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS054.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS015.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS025.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS035.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS045.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS064.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS074.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS084.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS094.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS104.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS055.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS065.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS075.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS042.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS085.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS091.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS095.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS103.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS105.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS023.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS101.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS071.
                04  P98-VALUE   PIC X.
              03  P98-CHK-TADRS081.
                04  P98-VALUE   PIC X.
