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
      *    診療行為算定歴チェック　   COPY (CPORCGI4A.INC)
      *                              (ORCGI4A で使用）
      *
      *----------------------------------------------------------*
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *
      ************************************************************
      *
       01  ORCGI4AAREA.
      *入力
      *    1:入力分   2:自動追加分 3：チェック分
           03  LNK-GI4A-KBN            PIC X(01).
      *    訂正フラグ（１：訂正）
           03  LNK-GI4A-SYORIFLG       PIC 9(01).
      *    診療コード
           03  LNK-GI4A-SRYCD          PIC X(09).
      *    現在ＳＰＡＩＤＸ（1:入力分の時）
           03  LNK-GI4A-GMN-IDX        PIC 9(04).
      *    回数
           03  LNK-GI4A-KAISU          PIC 9(03).
      *    訂正時の診療コード
           03  LNK-GI4A-TEISEI-AREA.
               05  LNK-GI4A-TEISEI-OCC      OCCURS   100.
                   07  LNK-GI4A-TEI-SRYCD   PIC X(09).
                   07  LNK-GI4A-TEI-KAISU   PIC 9(03).
      *    労災のリハビリ（０：チェックあり、１：３月以内なし）
           03  LNK-GI4A-CHKFLG         PIC 9(01).
      *出力
      *    最大件数
           03  LNK-GI4A-MAXCNT         PIC 9(04).
      *    現在件数
           03  LNK-GI4A-CNT            PIC 9(04).
      *
      *    最大件数(日）
           03  LNK-GI4A-DAYMAXCNT      PIC 9(04).
      *    現在件数（日）
           03  LNK-GI4A-DAYCNT         PIC 9(04).
      *    訂正後回数
           03  LNK-GI4A-ATO-CNT        PIC 9(04).
      *    エラーコード
           03  LNK-GI4A-ERRCD          PIC X(04).
      *    エラー診療メッセージ
           03  LNK-GI4A-ERRMSG         PIC X(100).
      *
