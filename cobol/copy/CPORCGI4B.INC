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
      *    診療コードチェック　   COPY (CPORCGI4B.INC)
      *                              (ORCGI4B で使用）
      *
      *----------------------------------------------------------*
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *
       01  ORCGI4BAREA.
      *
      *    1:追加分（追加ＯＫ時、'２'へ変更）３：チェックのみ
           03  LNK-GI4B-KBN            PIC X(01).
      *    訂正フラグ（１：訂正）
           03  LNK-GI4B-SYORIFLG       PIC 9(01).
      *
      *    診療コード
           03  LNK-GI4B-SRYCD          PIC X(09).
      *    対象・追加ＩＤＸ
           03  LNK-GI4B-GMN-IDX        PIC 9(04).
      *    処理ＰＧ名
           03  LNK-GI4B-PG             PIC X(03).
      *
           03  LNK-GI4B-AREA.
      *        年齢 
               05  LNK-GI4B-NENREI.
                   07  LNK-GI4B-NENREI-YY     PIC 9(03).
                   07  LNK-GI4B-NENREI-MM     PIC 9(02).
                   07  LNK-GI4B-NENREI-DD     PIC 9(02).
      *        １５歳未満再診科算定有り（初診・再診のみ使用）
               05  LNK-GI4B-15MIMAN-ARI       PIC  9(01).
      *        老人区分
               05  LNK-GI4B-ROUJIN            PIC 9(01).
      *        最終受診科
               05  LNK-GI4B-LSTSRYKA          PIC  X(02).
      *        最終受診科
               05  LNK-GI4B-LSTSRYKAMEI       PIC  X(20).
      *    訂正時の診療コード
           03  LNK-GI4B-TEISEI-AREA.
               05  LNK-GI4B-TEISEI-OCC      OCCURS   100.
                   07  LNK-GI4B-TEI-SRYCD   PIC X(09).
                   07  LNK-GI4B-TEI-KAISU   PIC 9(03).
      *
           03  LNK-GI4B-ERRAREA.
      *        エラーコード（入外適用区分）
               05  LNK-GI4B-ERRCD1         PIC X(04).
      *        エラーコード（老人適用区分）
               05  LNK-GI4B-ERRCD2         PIC X(04).
      *        エラーコード（算定回数）
               05  LNK-GI4B-ERRCD3         PIC X(04).
      *        エラーコード（施設基準適合分）
               05  LNK-GI4B-ERRCD4         PIC X(04).
      *        エラーコード（対象年齢）
               05  LNK-GI4B-ERRCD5         PIC X(04).
      *        エラーコード（病床数）
               05  LNK-GI4B-ERRCD6         PIC X(04).
      *        エラーコード（併用算定）
               05  LNK-GI4B-ERRCD7         PIC X(04).
      *        エラーコード
               05  LNK-GI4B-ERRCD8         PIC X(04).
      *        エラーコード
               05  LNK-GI4B-ERRCD9         PIC X(04).
      *        エラーコード
               05  LNK-GI4B-ERRCD10        PIC X(04).
           03  LNK-GI4B-ERRAREA-R      REDEFINES   LNK-GI4B-ERRAREA.
               05  LNK-GI4B-ERRCD          PIC X(04)
                                           OCCURS  10.
      *    エラーメッセージ（併用算定）
           03  LNK-GI4B-ERRMSG         PIC X(100).
      *
