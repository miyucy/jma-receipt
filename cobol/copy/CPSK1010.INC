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
      *         システム管理マスタ     (CPSK1010.INC)   *
      *         （１０１０）                            *
      *         職員情報                                *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 00-00-01     MCC-森脇     02/05/07  予備の修正
      *                                     麻薬ライセンスの追加
      ************************************************************
       01  SYS-1010-REC.
           03  SYS-1010-KEY.
      *管理コード
               05  SYS-1010-KANRICD     PIC  X(04).
      *区分コード
               05  SYS-1010-KBNCD       PIC  X(08).
      *有効開始年月日
               05  SYS-1010-STYUKYMD    PIC  X(08).
      *有効終了年月日
               05  SYS-1010-EDYUKYMD    PIC  X(08).
      *管理テーブル
           03  SYS-1010-TBL.
      *オペレータＩＤ
               05  SYS-1010-USERID      PIC  X(16).
      *フリガナ
               05  SYS-1010-KANANAME    PIC  X(80).
      *氏名
               05  SYS-1010-NAME        PIC  X(80).
      *医籍登録番号
               05  SYS-1010-ISEKINUM    PIC  X(08).
      *保険医登録番号（社保）
               05  SYS-1010-HKNDRNUMS   PIC  X(08).
      *保険医登録番号（国保）
               05  SYS-1010-HKNDRNUMK   PIC  X(12).
      *専門科コード
               05  SYS-1010-SEMONKACD  OCCURS  5.
                   07                   PIC  X(02).
      *業務処理権限
               05  SYS-1010-GSRAUTH     PIC  X(70).
      *管理者権限フラグ
               05  SYS-1010-KANRIAUTHFLG  PIC  X(01).
      *麻薬ライセンス
               05  SYS-1010-MAYAKULICENSE    PIC  X(40).
      *予備
           03                           PIC  X(175).
      *端末ＩＤ
           03  SYS-1010-TERMID          PIC  X(16).
      *オペーレータＩＤ
           03  SYS-1010-OPID            PIC  X(16).
      *作成年月日
           03  SYS-1010-CREYMD          PIC  X(08).
      *更新年月日
           03  SYS-1010-UPYMD           PIC  X(08).
      *更新時間
           03  SYS-1010-UPHMS           PIC  X(06).
