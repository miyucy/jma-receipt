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
      *    Æþ±¡CLAIM¹àÌÜID  COPY (CPNCLAIMID.INC)                *
      ************************************************************
      ************************************************************
      *  ¥³¥Ô¡¼¶ç½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ     ÆâÍÆ
      ************************************************************
       01  NCLAIMID-AREA.
           03  NCLAIMID-NYUINNM        PIC X(20)   VALUE   "Claim010".
           03  NCLAIMID-NYUIDONM       PIC X(20)   VALUE   "Claim011".
           03  NCLAIMID-ITEM-MAX       PIC 9(03)   VALUE   11.
           03  NCLAIMID-ITEM-VAL.
             05  NCLAIMID-NYUKBN-G.
               07  NCLAIMID-NYUKBNNM
                                PIC X(20)   VALUE   "Claim012".
               07  NCLAIMID-NYUKBNID
                                PIC X(05)   VALUE   "00001".
               07  NCLAIMID-NYUKBNMEI
                                PIC X(100)  VALUE   "Æþ±¡¶èÊ¬".
             05  NCLAIMID-SYOKAI-G.
               07  NCLAIMID-SYOKAINM
                                PIC X(20)   VALUE   "Claim013".
               07  NCLAIMID-SYOKAIID
                                PIC X(05)   VALUE   "00002".
               07  NCLAIMID-SYOKAIMEI
                                PIC X(100)  VALUE   "·ÑÂ³Æþ±¡¶èÊ¬".
             05  NCLAIMID-BTUNUM-G.
               07  NCLAIMID-BTUNUMNM
                                PIC X(20)   VALUE   "Claim014".
               07  NCLAIMID-BTUNUMID
                                PIC X(05)   VALUE   "00003".
               07  NCLAIMID-BTUNUMMEI
                                PIC X(100)  VALUE   "ÉÂÅï".
             05  NCLAIMID-BRMNUM-G.
               07  NCLAIMID-BRMNUMNM
                                PIC X(20)   VALUE   "Claim015".
               07  NCLAIMID-BRMNUMID
                                PIC X(05)   VALUE   "00004".
               07  NCLAIMID-BRMNUMMEI
                                PIC X(100)  VALUE   "ÉÂ¼¼".
             05  NCLAIMID-SAGAKU-G.
               07  NCLAIMID-SAGAKUNM
                                PIC X(20)   VALUE   "Claim016".
               07  NCLAIMID-SAGAKUID
                                PIC X(05)   VALUE   "00005".
               07  NCLAIMID-SAGAKUMEI
                                PIC X(100)  VALUE   "¼¼ÎÁº¹³Û".
             05  NCLAIMID-DR-G.
               07  NCLAIMID-DRNM
                                PIC X(20)   VALUE   "Claim017".
               07  NCLAIMID-DRID
                                PIC X(05)   VALUE   "00006".
               07  NCLAIMID-DRMEI
                                PIC X(100)  VALUE   "Ã´Åö°å".
             05  NCLAIMID-TAIINCD-G.
               07  NCLAIMID-TAIINCDNM
                                PIC X(20)   VALUE   "MML0016".
               07  NCLAIMID-TAIINCDID
                                PIC X(05)   VALUE   "00007".
               07  NCLAIMID-TAIINCDMEI
                                PIC X(100)  VALUE   "Âà±¡»öÍ³".
             05  NCLAIMID-TOKNYUIN-G.
               07  NCLAIMID-TOKNYUINNM
                                PIC X(20)   VALUE  "XXXXXXX".
               07  NCLAIMID-TOKNYUINID
                                PIC X(05)   VALUE  "00008".
               07  NCLAIMID-TOKNYUINMEI
                                PIC X(100)  VALUE  "ÆÃÄêÆþ±¡ÎÁ".
             05  NCLAIMID-NYUINKA-G.
               07  NCLAIMID-NYUINKANM
                                PIC X(20)   VALUE  "XXXXXXX".
               07  NCLAIMID-NYUINKAID
                                PIC X(05)   VALUE  "00009".
               07  NCLAIMID-NYUINKAMEI
                                PIC X(100)  VALUE  "Æþ±¡²Ê".
             05  NCLAIMID-HKNCOMBI-G.
               07  NCLAIMID-HKNCOMBINM
                                PIC X(20)   VALUE  "XXXXXXX".
               07  NCLAIMID-HKNCOMBIID
                                PIC X(05)   VALUE  "00010".
               07  NCLAIMID-HKNCOMBIMEI
                                PIC X(100)  VALUE  "ÊÝ¸±ÁÈ¹ç¤»".
             05  NCLAIMID-UNCHKECK-G.
               07  NCLAIMID-UNCHKECKNM
                                PIC X(20)   VALUE  "XXXXXXX".
               07  NCLAIMID-UNCHKECKID
                                PIC X(05)   VALUE  "99999".
               07  NCLAIMID-UNCHKECKMEI
                                PIC X(100)  VALUE  "ÉÔÌÀ".
           03  NCLAIMID-ITEM-R          REDEFINES   NCLAIMID-ITEM-VAL.
             05  NCLAIMID-ITEM-OCC      OCCURS  11.
               07  NCLAIMID-ITEMNM      PIC X(20).
               07  NCLAIMID-ITEMID      PIC X(05).
               07  NCLAIMID-ITEMMEI     PIC X(100).
