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
      *         システム管理マスタ     (CPSK5003.INC)   *
      *         （５００３）                            *
      *         病棟入院料加算情報設定                  *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  SYS-5003-REC.
           03  SYS-5003-KEY.
      *管理コード
               05  SYS-5003-KANRICD            PIC X(04).
      *区分コード
               05  SYS-5003-KBNCD              PIC X(08).
      *有効開始年月日
               05  SYS-5003-STYUKYMD           PIC X(08).
      *有効終了年月日
               05  SYS-5003-EDYUKYMD           PIC X(08).
      *管理テーブル
           03  SYS-5003-TBL.
      *          難病患者等特別入院診療加算
               05  SYS-5003-NANBYO.
                   07  SYS-5003-NANBYO-CD      PIC X(09).
                   07  SYS-5003-NANBYO-KBN     PIC X(01).
      *          特殊疾患入院施設管理加算
               05  SYS-5003-TOKUSYU.
                   07  SYS-5003-TOKUSYU-CD     PIC X(09).
                   07  SYS-5003-TOKUSYU-KBN    PIC X(01).
      *          療養病棟療養環境加算
               05  SYS-5003-YORYO              OCCURS  3.
                   07  SYS-5003-YORYO-CD       PIC X(09).
                   07  SYS-5003-YORYO-KBN      PIC X(01).
      *          児童・思春期精神科入院医療管理加算
               05  SYS-5003-JIDO.
                   07  SYS-5003-JIDO-CD        PIC X(09).
                   07  SYS-5003-JIDO-KBN       PIC X(01).
      *          精神科応急入院施設管理加算
               05  SYS-5003-SEISIN.
                   07  SYS-5003-SEISIN-CD      PIC X(09).
                   07  SYS-5003-SEISIN-KBN     PIC X(01).
      *          看護配置加算
               05  SYS-5003-KANGO              OCCURS  5.
                   07  SYS-5003-KANGO-CD       PIC X(09).
                   07  SYS-5003-KANGO-KBN      PIC X(01).
           03  SYS-5003-TBLR     REDEFINES     SYS-5003-TBL.
               05  SYS-5003-KSN                OCCURS  12.
                   07  SYS-5003-KSNCD          PIC X(09).
                   07  SYS-5003-KSNKBN         PIC X(01).
      *予備
           03                              PIC  X(380).
      *端末ＩＤ
           03  SYS-5003-TERMID             PIC  X(16).
      *オペーレータＩＤ
           03  SYS-5003-OPID               PIC  X(16).
      *作成年月日
           03  SYS-5003-CREYMD             PIC  X(08).
      *更新年月日
           03  SYS-5003-UPYMD              PIC  X(08).
      *更新時間
           03  SYS-5003-UPHMS              PIC  X(06).
