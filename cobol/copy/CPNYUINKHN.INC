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
      *    入院料算定マスタ         COPY (CPNYUINKHN.INC)        *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  NYUINKHN-REC.
           03  NYUKHN-KEY.
      *基本点数診療コード
               05  NYUKHN-KHNSRYCD     PIC  X(09).
      *有効開始年月日
               05  NYUKHN-YUKOSTYMD    PIC  X(08).
      *有効終了年月日
               05  NYUKHN-YUKOEDYMD    PIC  X(08).
      *算定診療コード
           03  NYUKHN-INF.
      *一般老人区分
      *（１：一般／２：老人）
               05  NYUKHN-IPROUKBN     PIC  X(01).
      *施設基準区分
      *空白：施設基準を考慮しない
      *  １：特定機能病院
      *  ２：有床診療所で特別看護の届出あり
      *  ３：有床診療所で看護師３人以上
               05  NYUKHN-SSTKIJUNKBN
                                       PIC  X(01).
      *病棟種別区分
               05  NYUKHN-BTUSBTKBN    PIC  X(02).
      *平均在院日数区分
               05  NYUKHN-HEIKINZAIKBN PIC  X(02).
      *看護配置区分
               05  NYUKHN-KANGOHAICHIKBN
                                       PIC  X(02).
      *看護師比率区分
               05  NYUKHN-KANGOHIRITUKBN
                                       PIC  X(02).
      *看護補助配置区分
               05  NYUKHN-KANGOHOJOHAICHIKBN
                                       PIC  X(02).
      *基本点数
               05  NYUKHN-KHNTEN       PIC  9(06).
      *加減算診療コード情報
           03  NYUKHN-KAGENCDINF.
      *加減算診療コード１（１４日以内）
               05  NYUKHN-KAGENSRYCD1  PIC  X(09).
      *加減算診療コード２（３０日以内）
               05  NYUKHN-KAGENSRYCD2  PIC  X(09).
      *加減算診療コード３（３１日以上９０日以内）
               05  NYUKHN-KAGENSRYCD3  PIC  X(09).
      *加減算診療コード４（９１日以上）
               05  NYUKHN-KAGENSRYCD4  PIC  X(09).
      *加減算診療コード５（１８０日以内）
               05  NYUKHN-KAGENSRYCD5  PIC  X(09).
      *加減算診療コード６（１８１日以上１年以内）
               05  NYUKHN-KAGENSRYCD6  PIC  X(09).
      *加減算診療コード７（１８０日以上）
               05  NYUKHN-KAGENSRYCD7  PIC  X(09).
      *加減算診療コード情報再定義
           03  NYUKHN-KAGENCD-R     REDEFINES  NYUKHN-KAGENCDINF.
               05  NYUKHN-KAGENCD-T         OCCURS   7.
                 07  NYUKHN-KAGENCD         PIC  X(09).
      *加減算点数情報
           03  NYUKHN-KAGENTENINF.
      *加減算点数１
               05  NYUKHN-KAGENTEN1    PIC  S9(06).
      *加減算点数２
               05  NYUKHN-KAGENTEN2    PIC  S9(06).
      *加減算点数３
               05  NYUKHN-KAGENTEN3    PIC  S9(06).
      *加減算点数４
               05  NYUKHN-KAGENTEN4    PIC  S9(06).
      *加減算点数５
               05  NYUKHN-KAGENTEN5    PIC  S9(06).
      *加減算点数６
               05  NYUKHN-KAGENTEN6    PIC  S9(06).
      *加減算点数７
               05  NYUKHN-KAGENTEN7    PIC  S9(06).
      *加減算点数情報再定義
           03  NYUKHN-KAGENTEN-R   REDEFINES  NYUKHN-KAGENTENINF.
               05  NYUKHN-KAGENTEN-T         OCCURS   7.
                 07  NYUKHN-KAGENTEN         PIC  S9(06).
      *決定点数情報
           03  NYUKHN-KETTEITENINF.
      *決定診数１
               05  NYUKHN-KETTEITEN1   PIC  9(06).
      *決定点数２
               05  NYUKHN-KETTEITEN2   PIC  9(06).
      *決定点数３
               05  NYUKHN-KETTEITEN3   PIC  9(06).
      *決定点数４
               05  NYUKHN-KETTEITEN4   PIC  9(06).
      *決定点数５
               05  NYUKHN-KETTEITEN5   PIC  9(06).
      *決定点数６
               05  NYUKHN-KETTEITEN6   PIC  9(06).
      *決定点数７
               05  NYUKHN-KETTEITEN7   PIC  9(06).
      *決定点数情報再定義
           03  NYUKHN-KETTEITEN-R   REDEFINES  NYUKHN-KETTEITENINF.
               05  NYUKHN-KETTEITEN-T       OCCURS   7.
                 07  NYUKHN-KETTEI     PIC  9(06).
      *端末ＩＤ
           03  SYU-TERMID              PIC  X(16).
      *オペーレータＩＤ
           03  SYU-OPID                PIC  X(16).
      *作成年月日
           03  SYU-CREYMD              PIC  X(08).
      *更新年月日
           03  SYU-UPYMD               PIC  X(08).
      *更新時間
           03  SYU-UPHMS               PIC  X(06).
      *
