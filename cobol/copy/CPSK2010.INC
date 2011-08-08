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
      *         システム管理マスタ     (CPSK2010.INC)            *
      *         （２０１０）                                     *
      *         公費付加情報                                     *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  SYS-2010-REC.
           03  SYS-2010-KEY.
               05  SYS-2010-HOSPNUM         PIC  9(02).
      *管理コード
               05  SYS-2010-KANRICD         PIC  X(04).
      *区分コード
               05  SYS-2010-KBNCD           PIC  X(08).
      *有効開始年月日
               05  SYS-2010-STYUKYMD        PIC  X(08).
      *有効終了年月日
               05  SYS-2010-EDYUKYMD        PIC  X(08).
      *
      *実日数省略記載
           03  SYS-2010-JNISSUKBN           PIC  X(01).
           03  SYS-2010-JNISSU-TAIKBN       PIC  X(01).
      *請求点省略記載
           03  SYS-2010-TOTALTENKBN         PIC  X(01).
           03  SYS-2010-TOTALTEN-TAIKBN     PIC  X(01).
      *一部負担金省略記載
           03  SYS-2010-FTNMONEYKBN-G       PIC  X(01).
           03  SYS-2010-FTNMONEY-TAIKBN-G   PIC  X(01).
           03  SYS-2010-FTNMONEYKBN-N       PIC  X(01).
           03  SYS-2010-FTNMONEY-TAIKBN-N   PIC  X(01).
      *一部負担金０円記載（記録）
           03  SYS-2010-FTNZEROKBN-G        PIC  X(01).
           03  SYS-2010-FTNZERO-TAIKBN-G    PIC  X(01).
           03  SYS-2010-FTNZEROKBN-N        PIC  X(01).
           03  SYS-2010-FTNZERO-TAIKBN-N    PIC  X(01).
      *入院食事療養省略記載
           03  SYS-2010-SKJKBN              PIC  X(01).
           03  SYS-2010-SKJ-TAIKBN          PIC  X(01).
      *ＯＣＲ実日数請求点省略記載
           03  SYS-2010-OCRKBN              PIC  X(01).
           03  SYS-2010-OCR-TAIKBN          PIC  X(01).
      *月途中受給者証変更時負担計算
           03  SYS-2010-JYUHENKBN           PIC  X(01).
           03  SYS-2010-JYUHEN-TAIKBN       PIC  X(01).
      *請求書公費再掲欄記載
           03  SYS-2010-SAIKEIKBN           PIC  X(01).
           03  SYS-2010-SAIKEI-TAIKBN       PIC  X(01).
      *全国公費併用分請求点集計
           03  SYS-2010-SYUKEIKBN           PIC  X(01).
           03  SYS-2010-SYUKEI-TAIKBN       PIC  X(01).
      *日・月上限額負担計算
           03  SYS-2010-JGNFTNKBN           PIC  X(01).
           03  SYS-2010-JGNFTN-TAIKBN       PIC  X(01).
      *
      *一部負担金金額集計
           03  SYS-2010-FTNKEIKBN-G         PIC  X(01).
           03  SYS-2010-FTNKEI-TAIKBN-G     PIC  X(01).
           03  SYS-2010-FTNKEIKBN-N         PIC  X(01).
           03  SYS-2010-FTNKEI-TAIKBN-N     PIC  X(01).
      *保険欄−一部負担金記載（高齢者）
           03  SYS-2010-HKNFTNKBN-K         PIC  X(01).
           03  SYS-2010-HKNFTN-TAIKBN-K     PIC  X(01).
      *保険欄−一部負担金記載（70歳未満）
           03  SYS-2010-HKNFTNKBN-Y         PIC  X(01).
           03  SYS-2010-HKNFTN-TAIKBN-Y     PIC  X(01).
      *設定と異なる記載設定
           03  SYS-2010-RECEKSIKBN-G        PIC  X(01).
           03  SYS-2010-RECEKSI-TAIKBN-G    PIC  X(01).
           03  SYS-2010-RECEKSIKBN-N        PIC  X(01).
           03  SYS-2010-RECEKSI-TAIKBN-N    PIC  X(01).
      *チェック対象上限額設定
           03  SYS-2010-CHKJGNKBN-G         PIC  X(01).
           03  SYS-2010-CHKJGN-TAIKBN-G     PIC  X(01).
           03  SYS-2010-CHKJGNKBN-N         PIC  X(01).
           03  SYS-2010-CHKJGN-TAIKBN-N     PIC  X(01).
      *公費請求テーブル作成
           03  SYS-2010-KOHSKYKBN-G         PIC  X(01).
           03  SYS-2010-KOHSKY-TAIKBN-G     PIC  X(01).
           03  SYS-2010-KOHSKYKBN-N         PIC  X(01).
           03  SYS-2010-KOHSKY-TAIKBN-N     PIC  X(01).
      *
      *患者登録−所得者情報−月上限額入力
           03  SYS-2010-PTJGNKBN            PIC  X(01).
           03  SYS-2010-PTJGN-TAIKBN        PIC  X(01).
      *設定額未満・以上で異なる負担金計算
           03  SYS-2010-IRYOKEIKBN-G        PIC  X(01).
           03  SYS-2010-IRYOKEI-TAIKBN-G    PIC  X(01).
           03  SYS-2010-IRYOKEIKBN-N        PIC  X(01).
           03  SYS-2010-IRYOKEI-TAIKBN-N    PIC  X(01).
           03  SYS-2010-SKJKEIKBN           PIC  X(01).
           03  SYS-2010-SKJKEI-TAIKBN       PIC  X(01).
      *本人タブ：食事療養・生活療養（食事）・生活療養（環境）
           03  SYS-2010-SKJRYOKBN-HON       PIC  X(01).
           03  SYS-2010-SKJRYO-TAIKBN-HON   PIC  X(01).
           03  SYS-2010-SEIRYOKBN-HON       PIC  X(01).
           03  SYS-2010-SEIRYO-TAIKBN-HON   PIC  X(01).
           03  SYS-2010-SEIKANKBN-HON       PIC  X(01).
           03  SYS-2010-SEIKAN-TAIKBN-HON   PIC  X(01).
      *低所得タブ：食事療養・生活療養（食事）・生活療養（環境）
           03  SYS-2010-SKJRYOKBN-TSY       PIC  X(01).
           03  SYS-2010-SKJRYO-TAIKBN-TSY   PIC  X(01).
           03  SYS-2010-SEIRYOKBN-TSY       PIC  X(01).
           03  SYS-2010-SEIRYO-TAIKBN-TSY   PIC  X(01).
           03  SYS-2010-SEIKANKBN-TSY       PIC  X(01).
           03  SYS-2010-SEIKAN-TAIKBN-TSY   PIC  X(01).
      *低年金タブ：食事療養・生活療養（食事）・生活療養（環境）
           03  SYS-2010-SKJRYOKBN-TNK       PIC  X(01).
           03  SYS-2010-SKJRYO-TAIKBN-TNK   PIC  X(01).
           03  SYS-2010-SEIRYOKBN-TNK       PIC  X(01).
           03  SYS-2010-SEIRYO-TAIKBN-TNK   PIC  X(01).
           03  SYS-2010-SEIKANKBN-TNK       PIC  X(01).
           03  SYS-2010-SEIKAN-TAIKBN-TNK   PIC  X(01).
      *
      *予備
           03  SYS-2010-YOBI                PIC  X(430).
      *端末ＩＤ
           03  SYS-2010-TERMID              PIC  X(16).
      *オペレータＩＤ
           03  SYS-2010-OPID                PIC  X(16).
      *作成年月日
           03  SYS-2010-CREYMD              PIC  X(08).
      *更新年月日
           03  SYS-2010-UPYMD               PIC  X(08).
      *更新時間
           03  SYS-2010-UPHMS               PIC  X(06).
      *主キー更新用項目
           03  SYS-2010-UPD-KEY.
               05  SYS-2010-UPD-HOSPNUM     PIC 9(2).
               05  SYS-2010-UPD-KANRICD     PIC X(04).
               05  SYS-2010-UPD-KBNCD       PIC X(08).
               05  SYS-2010-UPD-STYUKYMD    PIC X(08).
               05  SYS-2010-UPD-EDYUKYMD    PIC X(08).
