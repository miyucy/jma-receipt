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
      *    ORCGW20サブプロ（入院基本料算定）     COPY (CPW20SUB01.INC)       *
      ************************************************************
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
       01  W20SUB01-LNK.
           03  W20SUB01-IN.
      *
      *        処理区分
               05  W20SUB01-I-KBN              PIC X(01).
      *        基準日
               05  W20SUB01-I-KJNYMD           PIC X(08).
      *
      *        検索キー１
               05  W20SUB01-I-KEY1.
      *
      *            基本診療行為コード
                   07  W20SUB01-I-KHNSRYCD     PIC X(09).
      *
      *        検索キー２
               05  W20SUB01-I-KEY2.
      *            特定機能病院区分
                   07  W20SUB01-I-TOKKINOHOSPKBN
                                               PIC X(01).
      *            特別看護届出区分
                   07  W20SUB01-I-TOKKNGTDKKBN PIC X(01).
      *            看護師数区分
                   07  W20SUB01-I-KNGSISUKBN   PIC X(01).
      *            病棟種別
                   07  W20SUB01-I-BTUSBTKBN    PIC X(02).
      *            平均在院日数
                   07  W20SUB01-I-HEIKINZAIKBN PIC X(02).
      *            看護配置
                   07  W20SUB01-I-KANGOHAICHIKBN
                                               PIC X(02).
      *            看護比率
                   07  W20SUB01-I-KANGOHIRITUKBN
                                               PIC X(02).
      *            看護補助配置
                   07  W20SUB01-I-KANGOHOJOHAICHIKBN
                                               PIC X(02).
           03  W20SUB01-OT.
      *
      *        リターンコード（０：正常／１：該当なし等）
               05  W20SUB01-O-RC               PIC 9(01).
      *        診療行為コード
               05  W20SUB01-O-KHNSRYCD         PIC  X(09).
      *        診療行為名称
               05  W20SUB01-O-NAME             PIC X(200).
      *        基本点数
               05  W20SUB01-O-KHNTEN           PIC  9(06).
      *        施設基準区分
               05  W20SUB01-O-SSTKIJUNKBN      PIC X(01).
      *        病棟種別
               05  W20SUB01-O-BTUSBTKBN        PIC X(02).
      *        平均在院日数
               05  W20SUB01-O-HEIKINZAIKBN     PIC X(02).
      *        看護配置
               05  W20SUB01-O-KANGOHAICHIKBN
                                               PIC X(02).
      *        看護比率
               05  W20SUB01-O-KANGOHIRITUKBN
                                               PIC X(02).
      *        看護補助配置
               05  W20SUB01-O-KANGOHOJOHAICHIKBN
                                               PIC X(02).
