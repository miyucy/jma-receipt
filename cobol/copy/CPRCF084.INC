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
      *    労災レセプト明細書（入院）     COPY (CPRCF084.INC)    *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RECE84-REC.
           03  RECE84-KEY.
      *医療機関ＩＤ
               05  RECE84-HOSPID          PIC  X(24).
      *診療年月
               05  RECE84-SRYYM           PIC  9(06).
      *入外区分
               05  RECE84-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE84-PTID            PIC  9(10).
      *レセプト科
               05  RECE84-RECEKA          PIC  X(02).
      *保険ＩＤ        
               05  RECE84-HKNID           PIC  9(10).
      *適用開始年月日
               05  RECE84-TEKSTYMD        PIC  X(08).
      *剤番号
               05  RECE84-ZAINUM          PIC  9(08).
      *診療区分
           03  RECE84-SRYKBN              PIC  X(02).
      *剤識別区分
           03  RECE84-ZAISKBKBN           PIC  X(01).
      *患者番号
           03  RECE84-PTNUM               PIC  X(20).
      *診療科
           03  RECE84-SRYKA               PIC  X(02).
      *保険組合せ番号
           03  RECE84-HKNCOMBI            PIC  9(04).
      *自保区分
           03  RECE84-JIHOKBN             PIC  X(01).
      *剤点数
           03  RECE84-ZAITEN              PIC  9(08).
      *診療コード計
           03  RECE84-SRYCDTOTAL          PIC  9(14).
      *数量計
           03  RECE84-SURYOUTOTAL         PIC  9(07)V9(03).
      *明細数
           03  RECE84-MEISAISU            PIC  9(04).
      *剤回数
           03  RECE84-ZAIKAISU            PIC  9(04).
      *手技点数１
           03  RECE84-SYUTEN1             PIC  9(07).
      *手技点数２
           03  RECE84-SYUTEN2             PIC  9(07).
      *薬剤点数
           03  RECE84-YKZTEN              PIC  9(07).
      *器材点数
           03  RECE84-KIZAITEN            PIC  9(07).
      *ドクターコード
           03  RECE84-DRCD                PIC  X(05).
      *剤請求フラグ
           03  RECE84-ZAIREQFLG           PIC  X(01).
      *逓減率
           03  RECE84-TEIGENRATE          PIC  X(01).
      *コメントコードフラグ
           03  RECE84-COMCDFLG            PIC  X(01).
      *
      *リハビリ
           03  RECE84-RIHABIRI-COMMENT    PIC  X(01).
      *
      *薬剤管理指導料
           03  RECE84-FLG-YAKUKAN-COMMENT PIC  X(01).
      *入院栄養食事指導料
           03  RECE84-FLG-NYUEIYO-COMMENT PIC  X(01).
      *退院前訪問指導料
           03  RECE84-FLG-HOUMON-COMMENT  PIC  X(01).
      *傷病手当金意見書交付料
           03  RECE84-FLG-SYOBYO-COMMENT  PIC  X(01).
      *療養費同意書交付料
           03  RECE84-FLG-RYOYO-COMMENT   PIC  X(01).
      *退院時服薬指導加算を算定時の薬剤管理指導料
           03  RECE84-FLG-TAIIN-COMMENT   PIC  X(01).
      *手術（輸血は除く）
           03  RECE84-FLG-SHUJUTU-COMMENT PIC  X(01).
      *ＣＴ・ＭＲＩ
           03  RECE84-FLG-CTMRI-COMMENT   PIC  X(01).
      *精神科退院前訪問指導料
           03  RECE84-FLG-HOUSEI-COMMENT  PIC  X(01).
      *精神科隔離病室管理加算（入院料加算）
           03  RECE84-FLG-KAKURI-COMMENT  PIC  X(01).
      *労災治療計画加算（入院料加算）
           03  RECE84-FLG-CHIRYO-COMMENT  PIC  X(01).
      *日数回数テーブル
           03  RECE84-DAY-AREA.
      *        診療回数テーブル（1:合計,2:１回,3:２回, 4:３回以上）
             04  RECE84-DAY-TBL           OCCURS  4.
                 05  RECE84-KAISUINF      OCCURS  31.
                     07  RECE84-KAISU     PIC  9(03).
