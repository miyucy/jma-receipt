      ******************************************************************
      * Project code name "ORCA"
      * Æü°åÉ¸½à¥ì¥»¥×¥È¥½¥Õ¥È¡ÊJMA standard receipt software¡Ë
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
      ******************************************************************
      *    ¥ê¥Ï¥Ó¥ê³«»ÏÆü¥³¥á¥ó¥ÈÊÔ½¸¥µ¥Ö   COPY (CPORCSRIHASTDAY.INC)
      ******************************************************************
      *  ¥³¥Ô¡¼¶ç½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      ******************************************************************
       01  ORCSRIHASTDAYAREA.
      *
      *°åÎÅµ¡´Ø£É£Ä
           03  LNK-RIHASTDAY-HOSPNUM              PIC  9(02).
      *Æþ³°¶èÊ¬
           03  LNK-RIHASTDAY-NYUGAIKBN            PIC  X(01).
      *´µ¼Ô£É£Ä
           03  LNK-RIHASTDAY-PTID                 PIC  9(10).
      *¿ÇÎÅ²Ê
           03  LNK-RIHASTDAY-SRYKA                PIC  X(02).
      *¿ÇÎÅÇ¯·î
           03  LNK-RIHASTDAY-SRYYM                PIC  X(06).
      *ÊÝ¸±ÁÈ¹ç¤»
           03  LNK-RIHASTDAY-HKNCOMBI             PIC  9(04).
      *
      *ÊÖµÑ¹àÌÜ
      *£±¡§¿´Âç·ì´É¼À´µ¡¡£²¡§Ç¾·ì´É¼À´µÅù¡¡£³¡§±¿Æ°´ï¡¡£´¡§¸ÆµÛ´ï
      *£µ¡§ÀÝ¿©¡¡£¶¡§ÆñÉÂ´µ¼Ô¡¡£·¡§¾ã³²»ù¡Ê¼Ô¡Ë
           03  LNK-RIHASTDAY-OUT-AREA.
              04  LNK-RIHASTDAY-OUT-OCC           OCCURS   7.
                 05  LNK-RIHASTDAY-OUT-OCC2       OCCURS 100.
                    06  LNK-RIHASTDAY-MARK        PIC  X(01).
                    06  LNK-RIHASTDAY-YUKOKETA    PIC  9(03).
                    06  LNK-RIHASTDAY-COM         PIC  X(200).
                 05  LNK-RIHASTDAY-OUT-OCC3.
                    06  LNK-RIHASTDAY-SRYCD       PIC  X(09)
                                                  OCCURS  50.
                 05  LNK-RIHASTDAY-IDX            PIC  9(03).
      *
      *Éüµ¢¥³¡¼¥É
           03  LNK-RIHASTDAY-RC                   PIC  9(02).
      *
