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
      *    レセプト明細書     COPY (CPRCF008.INC)                *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01.06.29  適用開始年月日の追加
      *  01.01.01    MCC-藤原     02.01.29  ファイルレイアウト変更
      *  01.01.02    MCC-藤原     02.05.16  個別の時複数診療月で作成するために
      *                                     診療年月を追加
      *  01.01.03    MCC-小豆沢   02.05.27  社保の出力順変更用に保険区分追加
      *                                     １：政府　　　２：船員　３：日雇
      *                                     ４：特例日雇　５：共済　６：組合
      *                                     ７：自衛官　　８：特定組合
      *  01.01.04    MCC-藤原     02.07.01  帳票データX(10000)に変更
      *                                     RECENUMをＫＥＹ項目に変更      
      *************************************************************
       01  RECE08-REC.
      *ＫＥＹ
           03  RECE08-KEY.
      *帳票ＩＤ
               05  RECE08-PRTID            PIC  X(04).
      *診療年月（検索用ＫＥＹ　一括：診療年月、個別：ゼロ）
               05  RECE08-RECEYM           PIC  X(06).
      *作成日
               05  RECE08-CREYMD           PIC  X(08).
      *作成時間
               05  RECE08-CREHMS           PIC  X(06).
      *県内・県外区分（１：県内　２：県外　）
               05  RECE08-PREFKBN          PIC  X(01).
      *県番号
               05  RECE08-PREFNUM          PIC  X(02).
      *保険者番号        
               05  RECE08-HKNJANUM         PIC  X(08).
      *適用開始年月日
               05  RECE08-TEKSTYMD         PIC  X(08). 
      *審査支払機関
               05  RECE08-TEISYUTUSAKI     PIC  X(01).
      *レセプト種別
               05  RECE08-RECESYUBETU      PIC  X(04).
      *患者番号
               05  RECE08-PTNUM            PIC  X(20).
      *診療年月
               05  RECE08-SRYYM            PIC  X(06).
      *連番
               05  RECE08-RENNUM           PIC  9(02).
      *連番号
               05  RECE08-RECENUM          PIC  9(06).
      *保険区分（社保提出時のみ）
           03  RECE08-HKNKBN               PIC  X(01).
      *患者カナ氏名
           03  RECE08-KANANAME             PIC  X(100).
      *端末ＩＤ
           03  RECE08-TERMID               PIC  X(32).
      *出力順識別番号
           03  RECE08-PRTJYUN              PIC  9(02).
      *出力順連番
           03  RECE08-PRTRENNUM            PIC  9(06).
      *帳票データ
           03  RECE08-PRTDATA              PIC  X(10000).
      *　　検索用項目
           03  RECE08-STKANANAME           PIC  X(100).
           03  RECE08-EDKANANAME           PIC  X(100).
