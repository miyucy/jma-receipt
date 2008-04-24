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
      *         システム管理マスタ     (CPSK200501.INC)          *
      *         （２００５の区分コード０１のとき）               *
      *         レセプト編集区分                                 *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  SYS-200501-REC.
           03  SYS-200501-KEY.
               05  SYS-200501-HOSPNUM      PIC 9(2).
      *管理コード
               05  SYS-200501-KANRICD      PIC X(04).
      *区分コード
               05  SYS-200501-KBNCD        PIC X(08).
      *有効開始年月日
               05  SYS-200501-STYUKYMD     PIC X(08).
      *有効終了年月日
               05  SYS-200501-EDYUKYMD     PIC X(08).
      *管理テーブル
           03  SYS-200501-TBL.
      *自賠責の様式選択機能（入院外）
               05  SYS-200501-JIBAIPRTKBN  PIC X(01).
      *自賠責の様式選択機能（入院）
               05  SYS-200501-JIBAIPRTKBN-N
                                           PIC X(01).
      *病棟番号記載区分（入院）
               05  SYS-200501-BTUNUM-KSIKBN
                                           PIC X(01).
      *印刷処理後のチェック解除の有無
               05  SYS-200501-PRT-CHECKKBN PIC X(01).
      *レセプト一括作成出力順区分（広域連合）
               05  SYS-200501-PRTJYUNKBN5  PIC X(02).
      *広域連合ＯＣＲ出力区分
               05  SYS-200501-KOUIKIOCRKBN PIC X(01).
      *広域連合作成区分
               05  SYS-200501-KOUIKIKBN    PIC X(01).
      *広域連合レセ電出力区分
               05  SYS-200501-KOUIKIRECEKBN
                                           PIC X(01).
      *レセ電日計表レコード記録条件（広域連合）
               05  SYS-200501-NI-JYOKEN-AREA.  
                   07  SYS-200501-NI-JYOKEN
                                           PIC 9(08)   OCCURS  2.
      *広域連合出力先プリンタ名
               05  SYS-200501-KOUIKIPRTNM  PIC X(16).
      *広域連合出力先プリンタ名（続紙）
               05  SYS-200501-KOUIKIPRTNM-NEXT
                                           PIC X(16).
      *広域連合出力先プリンタ名（入院）
               05  SYS-200501-KOUIKIPRTNM-N
                                           PIC X(16).
      *広域連合出力先プリンタ名（続紙）（入院）
               05  SYS-200501-KOUIKIPRTNM-NEXT-N
                                           PIC X(16).
      *広域連合診療報酬請求書区分
               05  SYS-200501-KOUIKIPRTKBN PIC  X(01).
      *予備
           03  FILLER                      PIC X(410).
      *端末ＩＤ
           03  SYS-200501-TERMID           PIC X(16).
      *オペーレータＩＤ
           03  SYS-200501-OPID             PIC X(16).
      *作成年月日
           03  SYS-200501-CREYMD           PIC X(08).
      *更新年月日
           03  SYS-200501-UPYMD            PIC X(08).
      *更新時間
           03  SYS-200501-UPHMS            PIC X(06).
