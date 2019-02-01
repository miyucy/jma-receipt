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
      *-------------------------------------------------*
      *    単位コードテーブル   COPY (CMTANICD.INC)     *
      *-------------------------------------------------*
      *****************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     MCC-多々納   02/03/19  124 菌種追加(H14.4改正)
      * 01.00.02     NACL-多々納  02/12/13  060 シート追加(H14.12改正)
      * 01.00.03     NACL-多々納  04/12/22  000 単位なし追加
      * 01.00.04     NACL-多々納  06/03/15  125 から 128追加(H18.4改正）
      * 04.08.00     NACL-多々納  16/08/30  061 カセット追加
      *****************************************************************
       01  MTANI-DATA-REC.
           03  FILLER          PIC X(03)  VALUE   "000".
           03  FILLER          PIC X(24)  VALUE   SPACE.
      *
           03  FILLER          PIC X(03)  VALUE   "001".
           03  FILLER          PIC X(24)  VALUE   "分".
      *
           03  FILLER          PIC X(03)  VALUE   "002".
           03  FILLER          PIC X(24)  VALUE   "回".
      *
           03  FILLER          PIC X(03)  VALUE   "003".
           03  FILLER          PIC X(24)  VALUE   "種".
      *
           03  FILLER          PIC X(03)  VALUE   "004".
           03  FILLER          PIC X(24)  VALUE   "箱".
      *
           03  FILLER          PIC X(03)  VALUE   "005".
           03  FILLER          PIC X(24)  VALUE   "巻".
      *
           03  FILLER          PIC X(03)  VALUE   "006".
           03  FILLER          PIC X(24)  VALUE   "枚".
      *
           03  FILLER          PIC X(03)  VALUE   "007".
           03  FILLER          PIC X(24)  VALUE   "本".
      *
           03  FILLER          PIC X(03)  VALUE   "008".
           03  FILLER          PIC X(24)  VALUE   "組".
      *
           03  FILLER          PIC X(03)  VALUE   "009".
           03  FILLER          PIC X(24)  VALUE   "セット".
      *
           03  FILLER          PIC X(03)  VALUE   "010".
           03  FILLER          PIC X(24)  VALUE   "個".
      *
           03  FILLER          PIC X(03)  VALUE   "011".
           03  FILLER          PIC X(24)  VALUE   "裂".
      *
           03  FILLER          PIC X(03)  VALUE   "012".
           03  FILLER          PIC X(24)  VALUE   "方向".
      *
           03  FILLER          PIC X(03)  VALUE   "013".
           03  FILLER          PIC X(24)  VALUE   "トローチ".
      *
           03  FILLER          PIC X(03)  VALUE   "014".
           03  FILLER          PIC X(24)  VALUE   "アンプル".
      *
           03  FILLER          PIC X(03)  VALUE   "015".
           03  FILLER          PIC X(24)  VALUE   "カプセル".
      *
           03  FILLER          PIC X(03)  VALUE   "016".
           03  FILLER          PIC X(24)  VALUE   "錠".
      *
           03  FILLER          PIC X(03)  VALUE   "017".
           03  FILLER          PIC X(24)  VALUE   "丸".
      *
           03  FILLER          PIC X(03)  VALUE   "018".
           03  FILLER          PIC X(24)  VALUE   "包".
      *
           03  FILLER          PIC X(03)  VALUE   "019".
           03  FILLER          PIC X(24)  VALUE   "瓶".
      *
           03  FILLER          PIC X(03)  VALUE   "020".
           03  FILLER          PIC X(24)  VALUE   "袋".
      *
           03  FILLER          PIC X(03)  VALUE   "021".
           03  FILLER          PIC X(24)  VALUE   "瓶（袋）".
      *
           03  FILLER          PIC X(03)  VALUE   "022".
           03  FILLER          PIC X(24)  VALUE   "管".
      *
           03  FILLER          PIC X(03)  VALUE   "023".
           03  FILLER          PIC X(24)  VALUE   "シリンジ".
      *
           03  FILLER          PIC X(03)  VALUE   "024".
           03  FILLER          PIC X(24)  VALUE   "回分".
      *
           03  FILLER          PIC X(03)  VALUE   "025".
           03  FILLER          PIC X(24)  VALUE   "テスト分".
      *
           03  FILLER          PIC X(03)  VALUE   "026".
           03  FILLER          PIC X(24)  VALUE   "ガラス筒".
      *
           03  FILLER          PIC X(03)  VALUE   "027".
           03  FILLER          PIC X(24)  VALUE   "桿錠".
      *
           03  FILLER          PIC X(03)  VALUE   "028".
           03  FILLER          PIC X(24)  VALUE   "単位".
      *
           03  FILLER          PIC X(03)  VALUE   "029".
           03  FILLER          PIC X(24)  VALUE   "万単位".
      *
           03  FILLER          PIC X(03)  VALUE   "030".
           03  FILLER          PIC X(24)  VALUE   "フィート".
      *
           03  FILLER          PIC X(03)  VALUE   "031".
           03  FILLER          PIC X(24)  VALUE   "滴".
      *
           03  FILLER          PIC X(03)  VALUE   "032".
           03  FILLER          PIC X(24)  VALUE   "ｍｇ".
      *
           03  FILLER          PIC X(03)  VALUE   "033".
           03  FILLER          PIC X(24)  VALUE   "ｇ".
      *
           03  FILLER          PIC X(03)  VALUE   "034".
           03  FILLER          PIC X(24)  VALUE   "Ｋｇ".
      *
           03  FILLER          PIC X(03)  VALUE   "035".
           03  FILLER          PIC X(24)  VALUE   "ｃｃ".
      *
           03  FILLER          PIC X(03)  VALUE   "036".
           03  FILLER          PIC X(24)  VALUE   "ｍＬ".
      *
           03  FILLER          PIC X(03)  VALUE   "037".
           03  FILLER          PIC X(24)  VALUE   "Ｌ".
      *
           03  FILLER          PIC X(03)  VALUE   "038".
           03  FILLER          PIC X(24)  VALUE   "ｍＬＶ".
      *
           03  FILLER          PIC X(03)  VALUE   "039".
           03  FILLER          PIC X(24)  VALUE   "バイアル".
      *
           03  FILLER          PIC X(03)  VALUE   "040".
           03  FILLER          PIC X(24)  VALUE   "ｃｍ".
      *
           03  FILLER          PIC X(03)  VALUE   "041".
           03  FILLER          PIC X(24)  VALUE   "ｃｍ２".
      *
           03  FILLER          PIC X(03)  VALUE   "042".
           03  FILLER          PIC X(24)  VALUE   "ｍ".
      *
           03  FILLER          PIC X(03)  VALUE   "043".
           03  FILLER          PIC X(24)  VALUE   "μＣｉ".
      *
           03  FILLER          PIC X(03)  VALUE   "044".
           03  FILLER          PIC X(24)  VALUE   "ｍＣｉ".
      *
           03  FILLER          PIC X(03)  VALUE   "045".
           03  FILLER          PIC X(24)  VALUE   "μｇ".
      *
           03  FILLER          PIC X(03)  VALUE   "046".
           03  FILLER          PIC X(24)  VALUE   "管（瓶）".
      *
           03  FILLER          PIC X(03)  VALUE   "047".
           03  FILLER          PIC X(24)  VALUE   "筒".
      *
           03  FILLER          PIC X(03)  VALUE   "048".
           03  FILLER          PIC X(24)  VALUE   "ＧＢｑ".
      *
           03  FILLER          PIC X(03)  VALUE   "049".
           03  FILLER          PIC X(24)  VALUE   "ＭＢｑ".
      *
           03  FILLER          PIC X(03)  VALUE   "050".
           03  FILLER          PIC X(24)  VALUE   "ＫＢｑ".
      *
           03  FILLER          PIC X(03)  VALUE   "051".
           03  FILLER          PIC X(24)  VALUE   "キット".
      *
           03  FILLER          PIC X(03)  VALUE   "052".
           03  FILLER          PIC X(24)  VALUE   "国際単位".
      *
           03  FILLER          PIC X(03)  VALUE   "053".
           03  FILLER          PIC X(24)  VALUE   "患者当り".
      *
           03  FILLER          PIC X(03)  VALUE   "054".
           03  FILLER          PIC X(24)  VALUE   "気圧".
      *
           03  FILLER          PIC X(03)  VALUE   "055".
           03  FILLER          PIC X(24)  VALUE   "缶".
      *
           03  FILLER          PIC X(03)  VALUE   "056".
           03  FILLER          PIC X(24)  VALUE   "手術当り".
      *
           03  FILLER          PIC X(03)  VALUE   "057".
           03  FILLER          PIC X(24)  VALUE   "容器".
      *
           03  FILLER          PIC X(03)  VALUE   "058".
           03  FILLER          PIC X(24)  VALUE   "ｍＬ（ｇ）".
      *
           03  FILLER          PIC X(03)  VALUE   "059".
           03  FILLER          PIC X(24)  VALUE   "ブリスター".
      *
           03  FILLER          PIC X(03)  VALUE   "060".
           03  FILLER          PIC X(24)  VALUE   "シート".
      *H28.8
           03  FILLER          PIC X(03)  VALUE   "061".
           03  FILLER          PIC X(24)  VALUE   "カセット".
      *
      *
           03  FILLER          PIC X(03)  VALUE   "101".
           03  FILLER          PIC X(24)  VALUE   "分画".
      *
           03  FILLER          PIC X(03)  VALUE   "102".
           03  FILLER          PIC X(24)  VALUE   "染色".
      *
           03  FILLER          PIC X(03)  VALUE   "103".
           03  FILLER          PIC X(24)  VALUE   "種類".
      *
           03  FILLER          PIC X(03)  VALUE   "104".
           03  FILLER          PIC X(24)  VALUE   "株".
      *
           03  FILLER          PIC X(03)  VALUE   "105".
           03  FILLER          PIC X(24)  VALUE   "菌株".
      *
           03  FILLER          PIC X(03)  VALUE   "106".
           03  FILLER          PIC X(24)  VALUE   "照射".
      *
           03  FILLER          PIC X(03)  VALUE   "107".
           03  FILLER          PIC X(24)  VALUE   "臓器".
      *
           03  FILLER          PIC X(03)  VALUE   "108".
           03  FILLER          PIC X(24)  VALUE   "件".
      *
           03  FILLER          PIC X(03)  VALUE   "109".
           03  FILLER          PIC X(24)  VALUE   "部位".
      *
           03  FILLER          PIC X(03)  VALUE   "110".
           03  FILLER          PIC X(24)  VALUE   "肢".
      *
           03  FILLER          PIC X(03)  VALUE   "111".
           03  FILLER          PIC X(24)  VALUE   "局所".
      *
           03  FILLER          PIC X(03)  VALUE   "112".
           03  FILLER          PIC X(24)  VALUE   "種目".
      *
           03  FILLER          PIC X(03)  VALUE   "113".
           03  FILLER          PIC X(24)  VALUE   "スキャン".
      *
           03  FILLER          PIC X(03)  VALUE   "114".
           03  FILLER          PIC X(24)  VALUE   "コマ".
      *
           03  FILLER          PIC X(03)  VALUE   "115".
           03  FILLER          PIC X(24)  VALUE   "処理".
      *
           03  FILLER          PIC X(03)  VALUE   "116".
           03  FILLER          PIC X(24)  VALUE   "指".
      *
           03  FILLER          PIC X(03)  VALUE   "117".
           03  FILLER          PIC X(24)  VALUE   "歯".
      *
           03  FILLER          PIC X(03)  VALUE   "118".
           03  FILLER          PIC X(24)  VALUE   "面".
      *
           03  FILLER          PIC X(03)  VALUE   "119".
           03  FILLER          PIC X(24)  VALUE   "側".
      *
           03  FILLER          PIC X(03)  VALUE   "120".
           03  FILLER          PIC X(24)  VALUE   "個所".
      *
           03  FILLER          PIC X(03)  VALUE   "121".
           03  FILLER          PIC X(24)  VALUE   "日".
      *
           03  FILLER          PIC X(03)  VALUE   "122".
           03  FILLER          PIC X(24)  VALUE   "椎間".
      *
           03  FILLER          PIC X(03)  VALUE   "123".
           03  FILLER          PIC X(24)  VALUE   "筋".
      *
           03  FILLER          PIC X(03)  VALUE   "124".
           03  FILLER          PIC X(24)  VALUE   "菌種".
      *
           03  FILLER          PIC X(03)  VALUE   "125".
           03  FILLER          PIC X(24)  VALUE   "項目".
      *
           03  FILLER          PIC X(03)  VALUE   "126".
           03  FILLER          PIC X(24)  VALUE   "箇所".
      *
           03  FILLER          PIC X(03)  VALUE   "127".
           03  FILLER          PIC X(24)  VALUE   "椎弓".
      *
           03  FILLER          PIC X(03)  VALUE   "128".
           03  FILLER          PIC X(24)  VALUE   "食".
      *H30.4
           03  FILLER          PIC X(03)  VALUE   "131".
           03  FILLER          PIC X(24)  VALUE   "月".
      *
           03  FILLER          PIC X(03)  VALUE   "140".
           03  FILLER          PIC X(24)  VALUE   "神経".
      *H24.4
           03  FILLER          PIC X(03)  VALUE   "158".
           03  FILLER          PIC X(24)  VALUE   "椎体".
      *
      *
       01  MTANI-DATA-REC-R         REDEFINES   MTANI-DATA-REC.
      *****03  MTANI-TBL-OCC        OCCURS    59   INDEXED   MTANI-IDX.
      **** 03  MTANI-TBL-OCC        OCCURS    83   INDEXED   MTANI-IDX.
           03  MTANI-TBL-OCC        OCCURS    93   INDEXED   MTANI-IDX.
               05  MTANI-TANICD        PIC X(03).
               05  MTANI-TANINAME      PIC X(24).
      *
       01  MTANI-MAX                   PIC 9(04)   VALUE   93.
      *
