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
      *****************************************************************
      *  自院病名マスター       (CPUSERBYOMEI.INC)
      *****************************************************************
      *  修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
      *01  USERBYOMEI-REC.
           03  USBYO-KEY.
      *医療機関ＩＤ
               05  USBYO-HOSPID        PIC X(24).
      *コード種別
               05  USBYO-CDSYU         PIC X(01).
      *病名入力コード
               05  USBYO-BYOMEIINPUTCD PIC X(20).
      *分類コード
           03  USBYO-BUNRUICD          PIC X(03).
      *表示連番
           03  USBYO-DSPSEQ            PIC 9(02).
      *病名コード数
           03  USBYO-BYOMEICDSU        PIC 9(01).
      *病名コード
           03  USBYO-BYOMEICD-G.
               05  USBYO-BYOMEICD-1    PIC X(07).
               05  USBYO-BYOMEICD-2    PIC X(07).
               05  USBYO-BYOMEICD-3    PIC X(07).
               05  USBYO-BYOMEICD-4    PIC X(07).
               05  USBYO-BYOMEICD-5    PIC X(07).
               05  USBYO-BYOMEICD-6    PIC X(07).
      *
           03  USBYO-BYOMEICD-R        REDEFINES   USBYO-BYOMEICD-G.
               05  USBYO-BYOMEICD      PIC X(07)
                                       OCCURS   6.
      *疑いフラグ
           03  USBYO-UTAGAIFLG         PIC X(01).
      *慢性区分
           03  USBYO-MANSEIKBN         PIC 9(02).
      *病名
           03  USBYO-BYOMEI            PIC X(160).
      *病名文字数
           03  USBYO-BYOMEIMOJI        PIC 9(02).
      *カルテ病名
           03  USBYO-CHARTBYOMEI       PIC X(160).
      *カルテ病名文字数
           03  USBYO-CHARTBYOMEIMOJI   PIC 9(02).
      *病名編集フラグ
           03  USBYO-BYOMEIHENFLG      PIC X(01).
      *保険病名フラグ
           03  USBYO-HKNBYOMEIFLG      PIC X(01).
      *端末ＩＤ
           03  USBYO-TERMID            PIC X(16).
      *オペーレータＩＤ
           03  USBYO-OPID              PIC X(16).
      *作成年月日
           03  USBYO-CREYMD            PIC X(08).
      *更新年月日
           03  USBYO-UPYMD             PIC X(08).
      *更新時間
           03  USBYO-UPHMS             PIC X(06).
