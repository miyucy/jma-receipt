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
      *    入院収納マスタ     COPY (CPSYUNYUIN.INC)              *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  SYUNYUIN-REC.
           03  SYUNYUIN-KEY.
      *医療機関ＩＤ
               05  SYUNYUIN-HOSPNUM          PIC 9(2).
      *入外区分
               05  SYUNYUIN-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  SYUNYUIN-PTID            PIC  9(10).
      *伝票番号
               05  SYUNYUIN-DENPNUM         PIC  9(07).
      *部屋ＮＯ
           03  SYUNYUIN-ROOMNUM             PIC  X(08).
      *病棟コード
           03  SYUNYUIN-BYOTONUM            PIC  X(02).
      *室料差額
           03  SYUNYUIN-RMSAGAKU            PIC S9(07).
      *室料差額−消費税（再掲）
           03  SYUNYUIN-RMSAGAKU-TAX-SAI    PIC S9(07).
      *食事１から食事１４
           03  SYUNYUIN-SHOKUJI-NAIYOU.
               05  SYUNYUIN-SHOKUJI1-NISSU  PIC S9(02).
               05  SYUNYUIN-SHOKUJI1        PIC S9(07).
               05  SYUNYUIN-SHOKUJI2-NISSU  PIC S9(02).
               05  SYUNYUIN-SHOKUJI2        PIC S9(07).
               05  SYUNYUIN-SHOKUJI3-NISSU  PIC S9(02).
               05  SYUNYUIN-SHOKUJI3        PIC S9(07).
               05  SYUNYUIN-SHOKUJI4-NISSU  PIC S9(02).
               05  SYUNYUIN-SHOKUJI4        PIC S9(07).
               05  SYUNYUIN-SHOKUJI5-NISSU  PIC S9(02).
               05  SYUNYUIN-SHOKUJI5        PIC S9(07).
               05  SYUNYUIN-SHOKUJI6-NISSU  PIC S9(02).
               05  SYUNYUIN-SHOKUJI6        PIC S9(07).
               05  SYUNYUIN-SHOKUJI7-NISSU  PIC S9(02).
               05  SYUNYUIN-SHOKUJI7        PIC S9(07).
               05  SYUNYUIN-SHOKUJI8-NISSU  PIC S9(02).
               05  SYUNYUIN-SHOKUJI8        PIC S9(07).
               05  SYUNYUIN-SHOKUJI9-NISSU  PIC S9(02).
               05  SYUNYUIN-SHOKUJI9        PIC S9(07).
               05  SYUNYUIN-SHOKUJI10-NISSU PIC S9(02).
               05  SYUNYUIN-SHOKUJI10       PIC S9(07).
               05  SYUNYUIN-SHOKUJI11-NISSU PIC S9(02).
               05  SYUNYUIN-SHOKUJI11       PIC S9(07).
               05  SYUNYUIN-SHOKUJI12-NISSU PIC S9(02).
               05  SYUNYUIN-SHOKUJI12       PIC S9(07).
               05  SYUNYUIN-SHOKUJI13-NISSU PIC S9(02).
               05  SYUNYUIN-SHOKUJI13       PIC S9(07).
               05  SYUNYUIN-SHOKUJI14-NISSU PIC S9(02).
               05  SYUNYUIN-SHOKUJI14       PIC S9(07).
           03  SYUNYUIN-SYOKUJI-NAIYOUR
                       REDEFINES   SYUNYUIN-SHOKUJI-NAIYOU.
               05  SYUNYUIN-SYOKUJI-TBL     OCCURS   14.
                 07  SYUNYUIN-SHOKUJI-NISSU   PIC S9(02).
                 07  SYUNYUIN-SHOKUJI         PIC S9(07).
      *食事療養費情報（食事日数・食事療養費・標準負担額）
           03  SYUNYUIN-SKJ-AREA.
               05  SYUNYUIN-SYUSKJ-NISSU      PIC S9(02).
               05  SYUNYUIN-SYUSKJ-RYOYOHI    PIC S9(07).
               05  SYUNYUIN-SYUSKJ-FTN        PIC S9(07).
               05  SYUNYUIN-SYUSKJ-FTN-RECE   PIC S9(07).
               05  SYUNYUIN-SYUSKJ-FTNKBN     PIC  X(01).
           03  SYUNYUIN-SKJ-AREA2.
               05  SYUNYUIN-KOH1SKJ-NISSU     PIC S9(02).
               05  SYUNYUIN-KOH1SKJ-RYOYOHI   PIC S9(07).
               05  SYUNYUIN-KOH1SKJ-FTN       PIC S9(07).
               05  SYUNYUIN-KOH1SKJ-FTN-RECE  PIC S9(07).
               05  SYUNYUIN-KOH1SKJ-FTNKBN    PIC  X(01).
               05  SYUNYUIN-KOH2SKJ-NISSU     PIC S9(02).
               05  SYUNYUIN-KOH2SKJ-RYOYOHI   PIC S9(07).
               05  SYUNYUIN-KOH2SKJ-FTN       PIC S9(07).
               05  SYUNYUIN-KOH2SKJ-FTN-RECE  PIC S9(07).
               05  SYUNYUIN-KOH2SKJ-FTNKBN    PIC  X(01).
               05  SYUNYUIN-KOH3SKJ-NISSU     PIC S9(02).
               05  SYUNYUIN-KOH3SKJ-RYOYOHI   PIC S9(07).
               05  SYUNYUIN-KOH3SKJ-FTN       PIC S9(07).
               05  SYUNYUIN-KOH3SKJ-FTN-RECE  PIC S9(07).
               05  SYUNYUIN-KOH3SKJ-FTNKBN    PIC  X(01).
               05  SYUNYUIN-KOH4SKJ-NISSU     PIC S9(02).
               05  SYUNYUIN-KOH4SKJ-RYOYOHI   PIC S9(07).
               05  SYUNYUIN-KOH4SKJ-FTN       PIC S9(07).
               05  SYUNYUIN-KOH4SKJ-FTN-RECE  PIC S9(07).
               05  SYUNYUIN-KOH4SKJ-FTNKBN    PIC  X(01).
           03  SYUNYUIN-SKJ-AREA2R
                       REDEFINES   SYUNYUIN-SKJ-AREA2.
               05  SYUNYUIN-SKJ-TBL         OCCURS   4.
                 07  SYUNYUIN-SKJ-NISSU       PIC S9(02).
                 07  SYUNYUIN-SKJ-RYOYOHI     PIC S9(07).
                 07  SYUNYUIN-SKJ-FTN         PIC S9(07).
                 07  SYUNYUIN-SKJ-FTN-RECE    PIC S9(07).
                 07  SYUNYUIN-SKJ-FTNKBN      PIC  X(01).
      *食事療養費（保険）
           03  SYUNYUIN-RYOYOHI-SKJ         PIC S9(07).
      *食事負担額（保険：自己負担）
           03  SYUNYUIN-SKYMONEY-SKJ        PIC S9(07).
      *食事負担額（保険：自己負担消費税）
           03  SYUNYUIN-SKYMONEY-SKJ-TAX    PIC S9(07).
      *食事負担額（保険：自己負担合計）
           03  SYUNYUIN-SKYMONEY-SKJ-KEI    PIC S9(07).
      *食事療養費（自費）
           03  SYUNYUIN-RYOYOHI-SKJ-JIHI    PIC S9(07).
      *食事負担額（自費：自己負担）
           03  SYUNYUIN-SKYMONEY-SKJ-JIHI   PIC S9(07).
      *食事負担額（自費：自己負担消費税）
           03  SYUNYUIN-SKYMONEY-SKJ-JIHI-TAX
                                       PIC S9(07).
      *食事負担額（自費：自己負担合計）
           03  SYUNYUIN-SKYMONEY-SKJ-JIHI-KEI
                                       PIC S9(07).
      *入院時生活療養費（保険）
           03  SYUNYUIN-RYOYOHI-LIFE        PIC S9(07).
      *入院時生活療養費負担額（保険：自己負担）
           03  SYUNYUIN-SKYMONEY-LIFE       PIC S9(07).
      *入院時生活療養費負担額（保険：自己負担消費税）
           03  SYUNYUIN-SKYMONEY-LIFE-TAX   PIC S9(07).
      *入院時生活療養費負担額（保険：自己負担合計）
           03  SYUNYUIN-SKYMONEY-LIFE-KEI   PIC S9(07).
      *入院時生活療養費費（自費）
           03  SYUNYUIN-RYOYOHI-LIFE-JIHI   PIC S9(07).
      *入院時生活療養費負担額（自費：自己負担）
           03  SYUNYUIN-SKYMONEY-LIFE-JIHI  PIC S9(07).
      *入院時生活療養費負担額（自費：自己負担消費税）
           03  SYUNYUIN-SKYMONEY-LIFE-JIHI-TAX
                                       PIC S9(07).
      *入院時生活療養費負担額（自費：自己負担合計）
           03  SYUNYUIN-SKYMONEY-LIFE-JIHI-KEI
                                       PIC S9(07).
      *診療フラグテーブル
           03  SYUNYUIN-DAY-AREA.
      *        診療フラグテーブル
             04  SYUNYUIN-DAY-TBL.
      *        診療フラグ（１日から３１日）
               05  SYUNYUIN-DAY-1           PIC  X(01).
               05  SYUNYUIN-DAY-2           PIC  X(01).
               05  SYUNYUIN-DAY-3           PIC  X(01).
               05  SYUNYUIN-DAY-4           PIC  X(01).
               05  SYUNYUIN-DAY-5           PIC  X(01).
               05  SYUNYUIN-DAY-6           PIC  X(01).
               05  SYUNYUIN-DAY-7           PIC  X(01).
               05  SYUNYUIN-DAY-8           PIC  X(01).
               05  SYUNYUIN-DAY-9           PIC  X(01).
               05  SYUNYUIN-DAY-10          PIC  X(01).
               05  SYUNYUIN-DAY-11          PIC  X(01).
               05  SYUNYUIN-DAY-12          PIC  X(01).
               05  SYUNYUIN-DAY-13          PIC  X(01).
               05  SYUNYUIN-DAY-14          PIC  X(01).
               05  SYUNYUIN-DAY-15          PIC  X(01).
               05  SYUNYUIN-DAY-16          PIC  X(01).
               05  SYUNYUIN-DAY-17          PIC  X(01).
               05  SYUNYUIN-DAY-18          PIC  X(01).
               05  SYUNYUIN-DAY-19          PIC  X(01).
               05  SYUNYUIN-DAY-20          PIC  X(01).
               05  SYUNYUIN-DAY-21          PIC  X(01).
               05  SYUNYUIN-DAY-22          PIC  X(01).
               05  SYUNYUIN-DAY-23          PIC  X(01).
               05  SYUNYUIN-DAY-24          PIC  X(01).
               05  SYUNYUIN-DAY-25          PIC  X(01).
               05  SYUNYUIN-DAY-26          PIC  X(01).
               05  SYUNYUIN-DAY-27          PIC  X(01).
               05  SYUNYUIN-DAY-28          PIC  X(01).
               05  SYUNYUIN-DAY-29          PIC  X(01).
               05  SYUNYUIN-DAY-30          PIC  X(01).
               05  SYUNYUIN-DAY-31          PIC  X(01).
           03  SYUNYUIN-DAY-AREA-R REDEFINES   SYUNYUIN-DAY-AREA.
      *        診療回数テーブル
               05  SYUNYUIN-DAY-TBL2.
                   07  SYUNYUIN-DAY         PIC  X(01)
                                         OCCURS   31.
      *入院履歴番号
           03  SYUNYUIN-NYUIN-RRKNUM        PIC  9(03).
      *入院その他１から５
           03  SYUNYUIN-NYUINETC-INF.
               05  SYUNYUIN-NYUINETC1       PIC S9(07).
               05  SYUNYUIN-NYUINETC2       PIC S9(07).
               05  SYUNYUIN-NYUINETC3       PIC S9(07).
               05  SYUNYUIN-NYUINETC4       PIC S9(07).
               05  SYUNYUIN-NYUINETC5       PIC S9(07).
      *
      *伝票作成区分（検索用）（空白：外来　１：退院時作成　２：定期請求
      *              ３：入院レセプト用ダミー）
           03  SYUNYUIN-SELCREATEKBN        PIC  X(01).
      *診療日（検索用）
           03  SYUNYUIN-SELSRYYMD           PIC  X(08).
      *入外区分（検索用）
           03  SYUNYUIN-SELNYUGAIKBN        PIC  X(01).
