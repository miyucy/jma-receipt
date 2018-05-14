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
      *      レセプト記載要領マスター     COPY (CPRECEKISAI.INC) *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RKISAI-REC.
           03  RKISAI-KEY.
      *        グループ番号
               05  RKISAI-C-GROUP              PIC X(09).
      *        開始年月
               05  RKISAI-STYM                 PIC X(06).
      *        終了年月
               05  RKISAI-EDYM                 PIC X(06).
      *        記載事項番号
               05  RKISAI-KISAINUM             PIC 9(02).
      *        連番号
               05  RKISAI-RENNUM               PIC 9(02).
      *    コメントコード
           03  RKISAI-C-CD                     PIC X(09).
      *    処理区分
      *      0:
      *      1:入力（選択肢）
      *      2:入力（自動発生）
      *      3:レセプト（自動記載）
           03  RKISAI-SYORIKBN                 PIC 9(01).
      *    作成年月日
           03  RKISAI-CREYMD                   PIC X(08).
      *    更新年月日
           03  RKISAI-UPYMD                    PIC X(08).
      *    更新時間
           03  RKISAI-UPHMS                    PIC X(06).
      *更新用
           03  RKISAI-UP-KEY.
               05  RKISAI-UPC-GROUP            PIC X(09).
               05  RKISAI-UPSTYM               PIC X(06).
               05  RKISAI-UPEDYM               PIC X(06).
               05  RKISAI-UPKISAINUM           PIC 9(02).
               05  RKISAI-UPRENNUM             PIC 9(02).
