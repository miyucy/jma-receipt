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
      ************************************************************
      *    Æþ±¡CLAIM¹àÌÜID  COPY (CPNORDERID.INC)                *
      ************************************************************
      ************************************************************
      *  ¥³¥Ô¡¼¶ç½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ     ÆâÍÆ
      ************************************************************
       01  NORDERID-AREA.
           03  NORDERID-ORDER-NYUIN        PIC X(02) VALUE "01".
           03  NORDERID-ORDER-KYUSYOKU     PIC X(02) VALUE "02".
      *
           03  NORDERID-MAX                PIC 9(03) VALUE 12.
      *
           03  NORDERID-VAL.
               05  NORDERID-NYUIN-G.
                   07  NORDERID-NYUINCL1   PIC X(02) VALUE "01".
                   07  NORDERID-NYUINCL2   PIC X(03) VALUE "001".
                   07  NORDERID-NYUINID    PIC X(04) VALUE "0101".
                   07  NORDERID-NYUINMES1  PIC X(30) VALUE "Æþ±¡".
                   07  NORDERID-NYUINMES2  PIC X(10) VALUE "Æþ±¡".
      *
               05  NORDERID-TAIIN-G.
                   07  NORDERID-TAIINCL1   PIC X(02) VALUE "01".
                   07  NORDERID-TAIINCL2   PIC X(03) VALUE "002".
                   07  NORDERID-TAIINID    PIC X(04) VALUE "0102".
                   07  NORDERID-TAIINMES1  PIC X(30) VALUE "Âà±¡".
                   07  NORDERID-TAIINMES2  PIC X(10) VALUE "Âà±¡".
      *
               05  NORDERID-IDOBTU-G.
                   07  NORDERID-IDOBTUCL1  PIC X(02) VALUE "01".
                   07  NORDERID-IDOBTUCL2  PIC X(03) VALUE "003".
                   07  NORDERID-IDOBTUID   PIC X(04) VALUE "0103".
                   07  NORDERID-IDOBTUMES1 PIC X(30) VALUE "Å¾Åï".
                   07  NORDERID-IDOBTUMES2 PIC X(10) VALUE "Å¾Åï".
      *
               05  NORDERID-IDOKA-G.
                   07  NORDERID-IDOKACL1   PIC X(02) VALUE "01".
                   07  NORDERID-IDOKACL2   PIC X(03) VALUE "004".
                   07  NORDERID-IDOKAID    PIC X(04) VALUE "0104".
                   07  NORDERID-IDOKAMES1  PIC X(30) VALUE "Å¾²Ê".
                   07  NORDERID-IDOKAMES2  PIC X(10) VALUE "Å¾²Ê".
      *
               05  NORDERID-IDOBRM-G.
                   07  NORDERID-IDOBRMCL1  PIC X(02) VALUE "01".
                   07  NORDERID-IDOBRMCL2  PIC X(03) VALUE "005".
                   07  NORDERID-IDOBRMID   PIC X(04) VALUE "0105".
                   07  NORDERID-IDOBRMMES1 PIC X(30) VALUE "Å¾¼¼".
                   07  NORDERID-IDOBRMMES2 PIC X(10) VALUE "Å¾¼¼".
      *
               05  NORDERID-IDODR-G.
                   07  NORDERID-IDODRCL1   PIC X(02) VALUE "01".
                   07  NORDERID-IDODRCL2   PIC X(03) VALUE "008".
                   07  NORDERID-IDODRID    PIC X(04) VALUE "0106".
                   07  NORDERID-IDODRMES1  PIC X(30) VALUE "Ã´Åö°å".
                   07  NORDERID-IDODRMES2  PIC X(10) VALUE "Ã´Åö°å".
      *
               05  NORDERID-GAIHK-G.
                   07  NORDERID-GAIHKCL1   PIC X(02) VALUE "01".
                   07  NORDERID-GAIHKCL2   PIC X(03) VALUE "006".
                   07  NORDERID-GAIHKID    PIC X(04) VALUE "0201".
                   07  NORDERID-GAIHKMES1  PIC X(30) VALUE "³°Çñ".
                   07  NORDERID-GAIHKMES2  PIC X(10) VALUE "³°Çñ".
      *
      *        05  NORDERID-GCURE-G.
      *            07  NORDERID-GCURECL1   PIC X(02) VALUE "01".
      *            07  NORDERID-GCURECL2   PIC X(03) VALUE "000".
      *            07  NORDERID-GCUREID    PIC X(04) VALUE "0202".
      *            07  NORDERID-GCUREMES1  PIC X(30) 
      *                                    VALUE "¼£ÎÅ¤Î°Ù¤Î³°Çñ".
      *            07  NORDERID-GCUREMES2  PIC X(10) VALUE "¼£³°Çñ".
      *
      *        05  NORDERID-GSENT-G.
      *            07  NORDERID-GSENTCL1   PIC X(02) VALUE "01".
      *            07  NORDERID-GSENTCL2   PIC X(03) VALUE "000".
      *            07  NORDERID-GSENTID    PIC X(04) VALUE "0203".
      *            07  NORDERID-GSENTMES1  PIC X(30) 
      *                                    VALUE "ÁªÄêÆþ±¡Ãæ¤Î³°Çñ".
      *            07  NORDERID-GSENTMES2  PIC X(10) VALUE "Áª³°Çñ".
      *
      *        05  NORDERID-GOTHC-G.
      *            07  NORDERID-GOTHCCL1   PIC X(02) VALUE "01".
      *            07  NORDERID-GOTHCCL2   PIC X(03) VALUE "000".
      *            07  NORDERID-GOTHCID    PIC X(04) VALUE "0204".
      *            07  NORDERID-GOTHCMES1  PIC X(30) 
      *                                    VALUE "Â¾°åÎÅµ¡´Ø¼õ¿Ç".
      *            07  NORDERID-GOTHCMES2  PIC X(10) VALUE "Â¾¼õ¿Ç".
      *
               05  NORDERID-GBACK-G.
                   07  NORDERID-GBACKCL1   PIC X(02) VALUE "01".
                   07  NORDERID-GBACKCL2   PIC X(03) VALUE "007".
                   07  NORDERID-GBACKID    PIC X(04) VALUE "0205".
                   07  NORDERID-GBACKMES1  PIC X(30) VALUE "µ¢±¡".
                   07  NORDERID-GBACKMES2  PIC X(10) VALUE "µ¢±¡".
      *
               05  NORDERID-FNORL-G.
                   07  NORDERID-FNORLCL1   PIC X(02) VALUE "02".
                   07  NORDERID-FNORLCL2   PIC X(03) VALUE "009".
                   07  NORDERID-FNORLID    PIC X(04) VALUE "0301".
                   07  NORDERID-FNORLMES1  PIC X(30)
                                           VALUE "¿©»öÎÅÍÜ¤Î¤ß".
                   07  NORDERID-FNORLMES2  PIC X(10) VALUE "¿©»öÎÅÍÜ".
      *
               05  NORDERID-FSPCL-G.
                   07  NORDERID-FSPCLCL1   PIC X(02) VALUE "02".
                   07  NORDERID-FSPCLCL2   PIC X(03) VALUE "010".
                   07  NORDERID-FSPCLID    PIC X(04) VALUE "0302".
                   07  NORDERID-FSPCLMES1  PIC X(30)
                                           VALUE "¿©»öÎÅÍÜ¡ÜÆÃ¿©".
                   07  NORDERID-FSPCLMES2  PIC X(10) VALUE "ÆÃÊÌ¿©".
      *
               05  NORDERID-FSELE-G.
                   07  NORDERID-FSELECL1   PIC X(02) VALUE "02".
                   07  NORDERID-FSELECL2   PIC X(03) VALUE "011".
                   07  NORDERID-FSELEID    PIC X(04) VALUE "0303".
                   07  NORDERID-FSELEMES1  PIC X(30)
                                           VALUE "¿©»öÎÅÍÜ¡ÜÁªÂò¿©".
                   07  NORDERID-FSELEMES2  PIC X(10) VALUE "ÁªÂò¿©".
      *
      *        05  NORDERID-FSPSL-G.
      *            07  NORDERID-FSPSLCL1   PIC X(02) VALUE "02".
      *            07  NORDERID-FSPSLCL2   PIC X(03) VALUE "000".
      *            07  NORDERID-FSPSLID    PIC X(04) VALUE "0304".
      *            07  NORDERID-FSPSLMES1  PIC X(30)
      *                                VALUE "¿©»öÎÅÍÜ¡ÜÆÃ¿©¡ÜÁªÂò¿©".
      *            07  NORDERID-FSPSLMES2  PIC X(10) VALUE "ÆÃ¿©¡ÜÁª¿©".
      *
               05  NORDERID-FSTOP-G.
                   07  NORDERID-FSTOPCL1   PIC X(02) VALUE "02".
                   07  NORDERID-FSTOPCL2   PIC X(03) VALUE "012".
                   07  NORDERID-FSTOPID    PIC X(04) VALUE "0305".
                   07  NORDERID-FSTOPMES1  PIC X(30) VALUE "¿©»ß¤á".
                   07  NORDERID-FSTOPMES2  PIC X(10) VALUE "¿©»ß¤á".
      *
           03  NORDERID-R  REDEFINES       NORDERID-VAL.
               05  NORDERID-OCC            OCCURS    12.
                   07  NORDERID-CLAIMID.
                       09  NORDERID-CLAIMIDH   PIC X(02).
                       09  NORDERID-CLAIMIDT   PIC X(03).
                   07  NORDERID-ORCAID         PIC X(04).
                   07  NORDERID-ORCAMES1       PIC X(30).
                   07  NORDERID-ORCAMES2       PIC X(10).
      *
