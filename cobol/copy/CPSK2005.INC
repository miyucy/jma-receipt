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
      *         システム管理マスタ     (CPSK2005.INC)            *
      *         （２００５                                       *
      *         レセプト編集区分                                 *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     02/02/26  レセ電区分、レセ電出力先の追加
      *  01.00.02    MCC-藤原     02/03/28  国保ＯＣＲ区分、国保診療報酬請求書
      *                                     区分の追加
      *  01.00.03    MCC-藤原     02/04/03  県単用項目編集プログラム名の追加
      *  01.00.04    MCC-藤原     02/05/13  病名編集区分１（診療科別）の追加
      *  01.00.05    MCC-藤原     02/06/04  転帰日編集区分の追加
      *  01.00.06    MCC-藤原     02/07/04  出力先プリンタ情報の追加
      *  01.00.07    NACL-藤原    03/01/08  通し番号編集区分の追加
      *  01.00.08    NACL-藤原    03/04/09  続紙区分（入院）の追加
      ************************************************************
       01  SYS-2005-REC.
           03  SYS-2005-KEY.
      *管理コード
               05  SYS-2005-KANRICD     PIC  X(04).
      *区分コード
               05  SYS-2005-KBNCD       PIC  X(08).
      *有効開始年月日
               05  SYS-2005-STYUKYMD    PIC  X(08).
      *有効終了年月日
               05  SYS-2005-EDYUKYMD    PIC  X(08).
      *管理テーブル
           03  SYS-2005-TBL.
      *病名編集区分
               05  SYS-2005-BYOMEIHENKBN
                                        PIC  X(01).
      *国保レセ電出力区分
               05  SYS-2005-KKHRECEKBN  PIC  X(01).
      *社保レセ電出力区分
               05  SYS-2005-SYARECEKBN  PIC  X(01).
      *レセ電データ出力先
               05  SYS-2005-RECEDENOUT  PIC  X(30).
      *国保ＯＣＲ出力区分
               05  SYS-2005-KKHOCRKBN   PIC  X(01).
      *国保診療報酬請求書区分
               05  SYS-2005-KKHPRTKBN   PIC  X(01).
      *県単用プログラム名
               05  SYS-2005-PREFPRGID-G.
                   07  SYS-2005-PREFPRGID    OCCURS  10
                                        PIC  X(15).
      *病名編集区分１
               05  SYS-2005-BYOMEIHENKBN1
                                        PIC  X(01).
      *転帰日編集区分
               05  SYS-2005-TENKIHENKBN PIC  X(01).
      *社保出力先プリンタ名
               05  SYS-2005-SYAPRTNM    PIC  X(16).
      *国保出力先プリンタ名
               05  SYS-2005-KKHPRTNM    PIC  X(16).
      *通し番号編集区分
               05  SYS-2005-RENNUMHENKBN
                                        PIC  X(01).
      *続紙区分（入院）
               05  SYS-2005-NEXTPRTKBN  PIC  X(01).
      *予備
           03  FILLER                   PIC  X(279).
      *端末ＩＤ
           03  SYS-2005-TERMID          PIC  X(16).
      *オペーレータＩＤ
           03  SYS-2005-OPID            PIC  X(16).
      *作成年月日
           03  SYS-2005-CREYMD          PIC  X(08).
      *更新年月日
           03  SYS-2005-UPYMD           PIC  X(08).
      *更新時間
           03  SYS-2005-UPHMS           PIC  X(06).
