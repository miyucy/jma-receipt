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
      ************************************************************
      *    入院CLAIM項目ID  COPY (CPNCLAIMID.INC)                *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付     内容
      ************************************************************
       01  NCLAIMID-AREA.
           03  NCLAIMID-NYUIN-DAT      PIC X(20)   VALUE   "Claim010".
           03  NCLAIMID-CHAILD-MAX     PIC 9(03)   VALUE   8.
           03  NCLAIMID-CHAILD-VAL.
             05  NCLAIMID-ORDER-G.
               07  NCLAIMID-ORDERNM    PIC X(20)   VALUE   "Claim011".
               07  NCLAIMID-ORDERID    PIC X(05)   VALUE   "10011".
             05  NCLAIMID-NYUKBN-G.
               07  NCLAIMID-NYUKBNNM   PIC X(20)   VALUE   "Claim012".
               07  NCLAIMID-NYUKBNID   PIC X(05)   VALUE   "10012".
             05  NCLAIMID-SYOKAI-G.
               07  NCLAIMID-SYOKAINM   PIC X(20)   VALUE   "Claim013".
               07  NCLAIMID-SYOKAIID   PIC X(05)   VALUE   "10013".
             05  NCLAIMID-BTUNUM-G.
               07  NCLAIMID-BTUNUMNM   PIC X(20)   VALUE   "Claim014".
               07  NCLAIMID-BTUNUMID   PIC X(05)   VALUE   "10014".
             05  NCLAIMID-BRMNUM-G.
               07  NCLAIMID-BRMNUMNM   PIC X(20)   VALUE   "Claim015".
               07  NCLAIMID-BRMNUMID   PIC X(05)   VALUE   "10015".
             05  NCLAIMID-SAGAKU-G.
               07  NCLAIMID-SAGAKUNM   PIC X(20)   VALUE   "Claim016".
               07  NCLAIMID-SAGAKUID   PIC X(05)   VALUE   "10016".
             05  NCLAIMID-DR-G.
               07  NCLAIMID-DRNM       PIC X(20)   VALUE   "Claim017".
               07  NCLAIMID-DRID       PIC X(05)   VALUE   "10017".
             05  NCLAIMID-TAIINCD-G.
               07  NCLAIMID-TAIINCD    PIC X(20)   VALUE   "MML0016".
               07  NCLAIMID-TAIINCDID  PIC X(05)   VALUE   "20016".
           03  NCLAIMID-CHAILD-R       REDEFINES   NCLAIMID-CHAILD-VAL.
             05  NCLAIMID-CHAILD-OCC   OCCURS  8.
               07  NCLAIMID-CHAILDNM   PIC X(20).
               07  NCLAIMID-CHAILDID   PIC X(05).
