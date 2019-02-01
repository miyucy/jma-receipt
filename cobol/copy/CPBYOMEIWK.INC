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
      *  編集用病名マスター (CPBYOMEIWK.INC)
      *****************************************************************
      *****************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *01  BYOMEIWK-REC.
      *
      *処理区分
           03  BYOWK-SYORIKBN          PIC X.
           03  BYOWK-KEY.
      *病名コード
               05  BYOWK-BYOMEICD      PIC X(07).
      *病名
           03  BYOWK-BYOMEI            PIC X(200).
      *病名文字数
           03  BYOWK-BYOMEIMOJI        PIC 9(03).
      *省略病名
           03  BYOWK-TANBYOMEI         PIC X(200).
      *省略病名文字数
           03  BYOWK-TANBYOMEIMOJI     PIC 9(03).
      *病名カナ
           03  BYOWK-BYOMEIKANA        PIC X(200).
      *移行先コード
           03  BYOWK-IKOSAKICD         PIC X(07).
      *特定疾患コード
           03  BYOWK-TOKSKNCD          PIC 9(02).
      *疑いフラグ
           03  BYOWK-UTAGAIFLG         PIC X(01).
      *単独使用禁止区分
           03  BYOWK-TANDOKUKBN        PIC 9(02).
      *保険請求外区分
           03  BYOWK-HKNSKYKBN         PIC 9(01).
      *病名管理区分
           03  BYOWK-HYOJUNCD          PIC X(08).
      *採択区分
           03  BYOWK-SAITAKUKBN        PIC X(01).
      *病名交換用コード
           03  BYOWK-BYOMEICHGCD       PIC X(04).
      *ＩＣＤ１０
           03  BYOWK-ICD10             PIC X(05).
      *収載年月日
           03  BYOWK-SYUSAIYMD         PIC X(08).
      *変更年月日
           03  BYOWK-CHGYMD            PIC X(08).
      *廃止年月日
           03  BYOWK-HAISIYMD          PIC X(08).
      *端末ＩＤ
           03  BYOWK-TERMID            PIC X(32).
      *オペーレータＩＤ
           03  BYOWK-OPID              PIC X(16).
      *作成年月日
           03  BYOWK-CREYMD            PIC X(08).
      *更新年月日
           03  BYOWK-UPYMD             PIC X(08).
      *更新時間
           03  BYOWK-UPHMS             PIC X(06).
