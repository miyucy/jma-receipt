      *******************************************************************
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
      ********************************************************************
      *****************************************************************
      *    °åÎÅ¶èÊ¬¾ðÊó          COPY (CPMEDKBN.INC)                  *
      *****************************************************************
      *****************************************************************
      *  ¥³¥Ô¡¼¶ç½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      *****************************************************************
       01  MEDH20-AREA.
           03  MEDH20-VAL.
               05  MEDH20-01FL1     PIC X(09)    VALUE  "820000060".
               05  MEDH20-01FL2     PIC X(04)    VALUE  "£°£±".
               05  MEDH20-01FL3     PIC X(06)    VALUE  "¡¡£±¡¡".
               05  MEDH20-01FL4     PIC X(100)   VALUE  
           "£²£´»þ´Ö»ýÂ³¤·¤ÆÅÀÅ©¤ò¼Â»Ü".
               05  MEDH20-02FL1     PIC X(09)    VALUE  "820000076".
               05  MEDH20-02FL2     PIC X(04)    VALUE  "£°£²".
               05  MEDH20-02FL3     PIC X(06)    VALUE  "¡¡£²¡¡".
               05  MEDH20-02FL4     PIC X(100)   VALUE  
           "Ç¢Ï©´¶À÷¾É¤ËÂÐ¤¹¤ë¼£ÎÅ¤ò¼Â»Ü".
               05  MEDH20-03FL1     PIC X(09)    VALUE  "820000077".
               05  MEDH20-03FL2     PIC X(04)    VALUE  "£°£³".
               05  MEDH20-03FL3     PIC X(06)    VALUE  "¡¡£³¡¡".
               05  MEDH20-03FL4     PIC X(100)   VALUE  
           "½ýÉÂÅù¤Ë¤è¤ê¥ê¥Ï¥Ó¥ê¥Æ¡¼¥·¥ç¥ó¤¬É¬Í×¤Ê¾õÂÖ".
               05  MEDH20-04FL1     PIC X(09)    VALUE  "820000078".
               05  MEDH20-04FL2     PIC X(04)    VALUE  "£°£´".
               05  MEDH20-04FL3     PIC X(06)    VALUE  "¡¡£´¡¡".
               05  MEDH20-04FL4     PIC X(100)   VALUE  
           "Ã¦¿å¤ËÂÐ¤¹¤ë¼£ÎÅ¤ò¼Â»Ü¡¢¤«¤Ä¡¢È¯Ç®¤òÈ¼¤¦¾õÂÖ".
               05  MEDH20-05FL1     PIC X(09)    VALUE  "820000079".
               05  MEDH20-05FL2     PIC X(04)    VALUE  "£°£µ".
               05  MEDH20-05FL3     PIC X(06)    VALUE  "¡¡£µ¡¡".
               05  MEDH20-05FL4     PIC X(100)   VALUE  
           "¾Ã²½´ÉÅù¤ÎÂÎÆâ¤«¤é¤Î½Ð·ì¤¬È¿Éü·ÑÂ³".
               05  MEDH20-06FL1     PIC X(09)    VALUE  "820000080".
               05  MEDH20-06FL2     PIC X(04)    VALUE  "£°£¶".
               05  MEDH20-06FL3     PIC X(06)    VALUE  "¡¡£¶¡¡".
               05  MEDH20-06FL4     PIC X(100)   VALUE  
           "ÉÑ²ó¤ÎÓÒÅÇ¤ËÂÐ¤¹¤ë¼£ÎÅ¤ò¼Â»Ü¡¢¤«¤Ä¡¢È¯Ç®¤òÈ¼¤¦¾õÂÖ".
               05  MEDH20-07FL1     PIC X(09)    VALUE  "820000083".
               05  MEDH20-07FL2     PIC X(04)    VALUE  "£°£·".
               05  MEDH20-07FL3     PIC X(06)    VALUE  "¡¡£·¡¡".
               05  MEDH20-07FL4     PIC X(100)   VALUE  
           "¤»¤óÌÑ¤ËÂÐ¤¹¤ë¼£ÎÅ¤ò¼Â»Ü".
               05  MEDH20-08FL1     PIC X(09)    VALUE  "820000087".
               05  MEDH20-08FL2     PIC X(04)    VALUE  "£°£¸".
               05  MEDH20-08FL3     PIC X(06)    VALUE  "¡¡£¸¡¡".
               05  MEDH20-08FL4     PIC X(100)   VALUE  
           "·ÐÉ¡°ß´É¤ä·ÐÄ²±ÉÍÜ¤¬¹Ô¤ï¤ì¤Æ¤ª¤ê¡¢È¯Ç®Ëô¤ÏÓÒÅÇ¤òÈ¼¤¦¾õÂÖ".
               05  MEDH20-09FL1     PIC X(09)    VALUE  "820000090".
               05  MEDH20-09FL2     PIC X(04)    VALUE  "£°£¹".
               05  MEDH20-09FL3     PIC X(06)    VALUE  "¡¡£¹¡¡".
               05  MEDH20-09FL4     PIC X(100)   VALUE  
           "ÉÑ²ó¤Î·ìÅü¸¡ºº¤ò¼Â»Ü".
               05  MEDH20-10FL1     PIC X(09)    VALUE  "820000057".
               05  MEDH20-10FL2     PIC X(04)    VALUE  "£±£°".
               05  MEDH20-10FL3     PIC X(06)    VALUE  "£±£°¡¡".
               05  MEDH20-10FL4     PIC X(100)   VALUE  
           "¥¹¥â¥ó".
               05  MEDH20-11FL1     PIC X(09)    VALUE  "820000066".
               05  MEDH20-11FL2     PIC X(04)    VALUE  "£±£±".
               05  MEDH20-11FL3     PIC X(06)    VALUE  "£±£±¡¡".
               05  MEDH20-11FL4     PIC X(100)   VALUE  
           "¿À·ÐÆñÉÂÅù¤Î´µ¼Ô¡ÊÆÃ¼ì¼À´µÎÅÍÜÉÂÅïÆþ±¡ÎÁ£±¡ËÅù".
               05  MEDH20-12FL1     PIC X(09)    VALUE  "820000058".
               05  MEDH20-12FL2     PIC X(04)    VALUE  "£±£²".
               05  MEDH20-12FL3     PIC X(06)    VALUE  "£±£²¡¡".
               05  MEDH20-12FL4     PIC X(100)   VALUE  
           "°å»ÕµÚ¤Ó´Ç¸î¿¦°÷¤Ë¤è¤ê¡¢¾ï»þ¡¢´Æ»ëµÚ¤Ó´ÉÍý¤ò¼Â»Ü".
               05  MEDH20-13FL1     PIC X(09)    VALUE  "820000059".
               05  MEDH20-13FL2     PIC X(04)    VALUE  "£±£³".
               05  MEDH20-13FL3     PIC X(06)    VALUE  "£±£³¡¡".
               05  MEDH20-13FL4     PIC X(100)   VALUE  
           "Ãæ¿´ÀÅÌ®±ÉÍÜ¤ò¼Â»Ü".
               05  MEDH20-14FL1     PIC X(09)    VALUE  "820000061".
               05  MEDH20-14FL2     PIC X(04)    VALUE  "£±£´".
               05  MEDH20-14FL3     PIC X(06)    VALUE  "£±£´¡¡".
               05  MEDH20-14FL4     PIC X(100)   VALUE  
           "¿Í¹©¸ÆµÛ´ï¤ò»ÈÍÑ".
               05  MEDH20-15FL1     PIC X(09)    VALUE  "820000062".
               05  MEDH20-15FL2     PIC X(04)    VALUE  "£±£µ".
               05  MEDH20-15FL3     PIC X(06)    VALUE  "£±£µ¡¡".
               05  MEDH20-15FL4     PIC X(100)   VALUE  
           "¥É¥ì¡¼¥óË¡Ëô¤Ï¶»¹Ð¼ã¤·¤¯¤ÏÊ¢¹Ð¤ÎÀö¾ô¤ò¼Â»Ü".
               05  MEDH20-16FL1     PIC X(09)    VALUE  "820000063".
               05  MEDH20-16FL2     PIC X(04)    VALUE  "£±£¶".
               05  MEDH20-16FL3     PIC X(06)    VALUE  "£±£¶¡¡".
               05  MEDH20-16FL4     PIC X(100)   VALUE  
           "µ¤´ÉÀÚ³«Ëô¤Ïµ¤´ÉÆâÁÞ´É¤¬¹Ô¤ï¤ì¤Æ¤ª¤ê¡¢¤«¤Ä¡¢È¯Ç®¤òÈ¼¤¦¾õÂÖ".
               05  MEDH20-17FL1     PIC X(09)    VALUE  "820000064".
               05  MEDH20-17FL2     PIC X(04)    VALUE  "£±£·".
               05  MEDH20-17FL3     PIC X(06)    VALUE  "£±£·¡¡".
               05  MEDH20-17FL4     PIC X(100)   VALUE  
           "»ÀÁÇÎÅË¡¤ò¼Â»Ü".
               05  MEDH20-18FL1     PIC X(09)    VALUE  "820000065".
               05  MEDH20-18FL2     PIC X(04)    VALUE  "£±£¸".
               05  MEDH20-18FL3     PIC X(06)    VALUE  "£±£¸¡¡".
               05  MEDH20-18FL4     PIC X(100)   VALUE  
           "´¶À÷¾É¤Î¼£ÎÅ¤ÎÉ¬Í×À­¤«¤é³ÖÎ¥¼¼¤Ç¤Î´ÉÍý¤ò¼Â»Ü".
               05  MEDH20-19FL1     PIC X(09)    VALUE  "820000067".
               05  MEDH20-19FL2     PIC X(04)    VALUE  "£±£¹".
               05  MEDH20-19FL3     PIC X(06)    VALUE  "£±£¹¡¡".
               05  MEDH20-19FL4     PIC X(100)   VALUE  
           "¶Ú¥¸¥¹¥È¥í¥Õ¥£¡¼¾É".
               05  MEDH20-20FL1     PIC X(09)    VALUE  "820000068".
               05  MEDH20-20FL2     PIC X(04)    VALUE  "£²£°".
               05  MEDH20-20FL3     PIC X(06)    VALUE  "£²£°¡¡".
               05  MEDH20-20FL4     PIC X(100)   VALUE  
           "Â¿È¯À­¹Å²½¾É".
               05  MEDH20-21FL1     PIC X(09)    VALUE  "820000069".
               05  MEDH20-21FL2     PIC X(04)    VALUE  "£²£±".
               05  MEDH20-21FL3     PIC X(06)    VALUE  "£²£±¡¡".
               05  MEDH20-21FL4     PIC X(100)   VALUE  
           "¶Ú°à½ÌÀ­Â¦º÷¹Å²½¾É".
               05  MEDH20-22FL1     PIC X(09)    VALUE  "820000070".
               05  MEDH20-22FL2     PIC X(04)    VALUE  "£²£²".
               05  MEDH20-22FL3     PIC X(06)    VALUE  "£²£²¡¡".
               05  MEDH20-22FL4     PIC X(100)   VALUE  
           "¥Ñ¡¼¥­¥ó¥½¥óÉÂ´ØÏ¢¼À´µ".
               05  MEDH20-23FL1     PIC X(09)    VALUE  "820000071".
               05  MEDH20-23FL2     PIC X(04)    VALUE  "£²£³".
               05  MEDH20-23FL3     PIC X(06)    VALUE  "£²£³¡¡".
               05  MEDH20-23FL4     PIC X(100)   VALUE  
           "¤½¤ÎÂ¾¤ÎÆñÉÂ¡Ê¥¹¥â¥óÅù¤ò½ü¤¯¡£¡Ë".
               05  MEDH20-24FL1     PIC X(09)    VALUE  "820000072".
               05  MEDH20-24FL2     PIC X(04)    VALUE  "£²£´".
               05  MEDH20-24FL3     PIC X(06)    VALUE  "£²£´¡¡".
               05  MEDH20-24FL4     PIC X(100)   VALUE  
           "ÀÔ¿ñÂ»½ý".
               05  MEDH20-25FL1     PIC X(09)    VALUE  "820000073".
               05  MEDH20-25FL2     PIC X(04)    VALUE  "£²£µ".
               05  MEDH20-25FL3     PIC X(06)    VALUE  "£²£µ¡¡".
               05  MEDH20-25FL4     PIC X(100)   VALUE  
           "ËýÀ­ÊÄºÉÀ­ÇÙ¼À´µ".
               05  MEDH20-26FL1     PIC X(09)    VALUE  "820000086".
               05  MEDH20-26FL2     PIC X(04)    VALUE  "£²£¶".
               05  MEDH20-26FL3     PIC X(06)    VALUE  "£²£¶¡¡".
               05  MEDH20-26FL4     PIC X(100)   VALUE  
           "¿Í¹©¿ÕÂ¡¡¢»ýÂ³´Ë½ù¼°·ì±ÕßÉ²á¡¢Ê¢ËìÞõÎ®Ëô¤Ï·ìÞù¸ò´¹¤ò¼Â»Ü".
               05  MEDH20-27FL1     PIC X(09)    VALUE  "820000092".
               05  MEDH20-27FL2     PIC X(04)    VALUE  "£²£·".
               05  MEDH20-27FL3     PIC X(06)    VALUE  "£²£·¡¡".
               05  MEDH20-27FL4     PIC X(100)   VALUE  
           "¿À·ÐÆñÉÂÅù¤Î´µ¼Ô¡ÊÆÃ¼ì¼À´µÎÅÍÜÉÂÅïÆþ±¡ÎÁ£²¡ËÅù".
               05  MEDH20-28FL1     PIC X(09)    VALUE  "820000093".
               05  MEDH20-28FL2     PIC X(04)    VALUE  "£²£¸".
               05  MEDH20-28FL3     PIC X(06)    VALUE  "£²£¸¡¡".
               05  MEDH20-28FL4     PIC X(100)   VALUE  
           "´ðËÜ¿ÇÎÅÎÁ¤Î»ÜÀß´ð½àÅù¤ÎÊÌÉ½Âè¸Þ¤Î»°¤Î»°¤Î´µ¼Ô".
               05  MEDH20-29FL1     PIC X(09)    VALUE  "820000074".
               05  MEDH20-29FL2     PIC X(04)    VALUE  "£²£¹".
               05  MEDH20-29FL3     PIC X(06)    VALUE  "£²£¹¡¡".
               05  MEDH20-29FL4     PIC X(100)   VALUE  
           "°­À­¼ðáç".
               05  MEDH20-30FL1     PIC X(09)    VALUE  "820000075".
               05  MEDH20-30FL2     PIC X(04)    VALUE  "£³£°".
               05  MEDH20-30FL3     PIC X(06)    VALUE  "£³£°¡¡".
               05  MEDH20-30FL4     PIC X(100)   VALUE  
           "ÇÙ±ê¤ËÂÐ¤¹¤ë¼£ÎÅ¤ò¼Â»Ü".
               05  MEDH20-31FL1     PIC X(09)    VALUE  "820000081".
               05  MEDH20-31FL2     PIC X(04)    VALUE  "£³£±".
               05  MEDH20-31FL3     PIC X(06)    VALUE  "£³£±¡¡".
               05  MEDH20-31FL4     PIC X(100)   VALUE  
           "êóáì¤ËÂÐ¤¹¤ë¼£ÎÅ¤ò¼Â»Ü".
               05  MEDH20-32FL1     PIC X(09)    VALUE  "820000082".
               05  MEDH20-32FL2     PIC X(04)    VALUE  "£³£²".
               05  MEDH20-32FL3     PIC X(06)    VALUE  "£³£²¡¡".
               05  MEDH20-32FL4     PIC X(100)   VALUE  
           "Ëö¾¿½Û´Ä¾ã³²¤Ë¤è¤ë²¼»èËöÃ¼¤Î³«ÊüÁÏ¤Î¼£ÎÅ¤ò¼Â»Ü".
               05  MEDH20-33FL1     PIC X(09)    VALUE  "820000084".
               05  MEDH20-33FL2     PIC X(04)    VALUE  "£³£³".
               05  MEDH20-33FL3     PIC X(06)    VALUE  "£³£³¡¡".
               05  MEDH20-33FL4     PIC X(100)   VALUE  
           "¤¦¤Ä¾É¾õ¤ËÂÐ¤¹¤ë¼£ÎÅ¤ò¼Â»Ü".
               05  MEDH20-34FL1     PIC X(09)    VALUE  "820000085".
               05  MEDH20-34FL2     PIC X(04)    VALUE  "£³£´".
               05  MEDH20-34FL3     PIC X(06)    VALUE  "£³£´¡¡".
               05  MEDH20-34FL4     PIC X(100)   VALUE  
           "Â¾¼Ô¤ËÂÐ¤¹¤ëË½¹Ô¤¬ËèÆüÇ§¤á¤é¤ì¤ë¾õÂÖ".
               05  MEDH20-35FL1     PIC X(09)    VALUE  "820000088".
               05  MEDH20-35FL2     PIC X(04)    VALUE  "£³£µ".
               05  MEDH20-35FL3     PIC X(06)    VALUE  "£³£µ¡¡".
               05  MEDH20-35FL4     PIC X(100)   VALUE  
           "£±Æü£¸²ó°Ê¾å¤ÎÓ½áâµÛ°ú¤ò¼Â»Ü".
               05  MEDH20-36FL1     PIC X(09)    VALUE  "820000089".
               05  MEDH20-36FL2     PIC X(04)    VALUE  "£³£¶".
               05  MEDH20-36FL3     PIC X(06)    VALUE  "£³£¶¡¡".
               05  MEDH20-36FL4     PIC X(100)   VALUE  
           "µ¤´ÉÀÚ³«Ëô¤Ïµ¤´ÉÆâÁÞ´É¤¬¹Ô¤ï¤ì¤Æ¤¤¤ë¾õÂÖ".
               05  MEDH20-37FL1     PIC X(09)    VALUE  "820000091".
               05  MEDH20-37FL2     PIC X(04)    VALUE  "£³£·".
               05  MEDH20-37FL3     PIC X(06)    VALUE  "£³£·¡¡".
               05  MEDH20-37FL4     PIC X(100)   VALUE  
           "ÁÏ½ý¡¢ÈéÉæÄÙáçËô¤ÏËªÁã±ê¡¢Ç¿Åù¤Î´¶À÷¾É¤ËÂÐ¤¹¤ë¼£ÎÅ¤ò¼Â»Ü".
           03  MEDH20-R    REDEFINES   MEDH20-VAL.
               05  MEDH20-OCC      OCCURS  37.
                   07  MEDH20-CDL  PIC X(09).
                   07  MEDH20-NUML PIC X(04).
                   07  MEDH20-MEIL PIC X(106).
       01  MEDH20-MAX              PIC 9(03)     VALUE  37.

