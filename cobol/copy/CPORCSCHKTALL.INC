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
      *----------------------------------------------------------*
      *    入院料包括診療チェクパラメタ
      *                                      COPY (CPORCSCHKTALL.INC)
      *----------------------------------------------------------*
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *
       01  ORCSCHKTALLAREA.
      *    処理区分（１：入院包括チェック）
           03  ORCSCHKTALL-KBN             PIC X(01).
      *    処理日付
           03  ORCSCHKTALL-SRYYMD.
               05  ORCSCHKTALL-SRYYM       PIC X(06).
               05  ORCSCHKTALL-SRYDD       PIC X(02).
      *    患者ＩＤ
           03  ORCSCHKTALL-PTID            PIC 9(10).
      *    対象の診療区分
           03  ORCSCHKTALL-HKTSRYKBN       PIC X(02).
           03  ORCSCHKTALL-HKTSRYSYUKBN    PIC X(03).
      *    対象の診療コード
           03  ORCSCHKTALL-HKTSRYCD-G.
               05  ORCSCHKTALL-HKTSRYCD    PIC X(09)
                                           OCCURS   10.
      *
           03  ORCSCHKTALL-OUTAREA.
      *        １：入院料包括あり
               05  ORCSCHKTALL-NYUHKTKBN       PIC 9(01).
      *        １：月内に包括あり
               05  ORCSCHKTALL-NYUHKTCHK       PIC 9(01).
               05  ORCSCHKTALL-NYUHKT-G.
                   07  ORCSCHKTALL-NYUHKT-OCC  OCCURS   31.
      *                ０：包括なし、１：包括あり、９：包括エラー
                       09  ORCSCHKTALL-HKTCHKFLG   PIC 9(01).
      *                包括区分
                       09  ORCSCHKTALL-NYUHKTCD    PIC X(03).
      *        入院料算定無し
               05   ORCSCHKTALL-NYUERR         PIC 9(01).
      *
