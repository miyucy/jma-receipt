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
      ******************************************************************
      *    ＡＰＩリクエスト予約情報　　       COPY (CPAPPTXMLV2REQ.INC)
      ******************************************************************
        01  XML-APPOINTREQ.
            02  APNTREQ-CONTEXT            PIC S9(9)   BINARY.
            02  APNTREQ-OBJECT             PIC X(36).
            02  APNTREQ-MODE               PIC S9(9)   BINARY.
            02  APNTREQ-RECORDNAME         PIC X(128).
            02  APNTREQ-APPOINT.
      *       患者番号
              03  APNTREQ-PATIENTID    PIC X(20).
      *       予約氏名
              03  APNTREQ-APPOINT-NAME     PIC X(100).
      *       予約カナ氏名
              03  APNTREQ-APPOINT-KANANAME PIC X(100).
      *       予約日
              03  APNTREQ-APPOINT-DATE PIC X(10).
      *       予約時間
              03  APNTREQ-APPOINT-TIME PIC X(8).
      *       予約ＩＤ
              03  APNTREQ-APPOINT-ID   PIC X(5).
      *       診療科
              03  APNTREQ-APPOINT-DEP-CODE PIC X(2).
      *       ドクターコード
              03  APNTREQ-APPOINT-DR-CODE  PIC X(5).
      *       診療内容区分コード
              03  APNTREQ-APPOINT-DEP-INFO PIC X(2).
      *       予約内容コード
              03  APNTREQ-APPOINT-INFO PIC X(2).
      *       予約メモ
              03  APNTREQ-APPOINT-MEMO PIC X(100).
