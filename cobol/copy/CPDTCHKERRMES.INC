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
      *    データチェックエラーメッセージ COPY (CPDTCHKERRMES.INC)*
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  ERRMES-AREA.
      *
         03  ERRMES-VAL.
      *
      *    ** 010xxx 保険者番号抜け
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "010001".
           05 PIC  X(30)   VALUE   "該当患者の保険者番号が未入力で".
           05 PIC  X(30)   VALUE   "す                            ".
           05 PIC  X(30)   VALUE   "                              ".
      *
      *    ** 020xxx 被保険者記号・番号抜け
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "020001".
           05 PIC  X(30)   VALUE   "該当患者の保険情報に記号又は番".
           05 PIC  X(30)   VALUE   "号が未入力です                ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "020002".
           05 PIC  X(30)   VALUE   "該当患者の保険情報の記号に全角".
           05 PIC  X(30)   VALUE   "文字以外が入力されています    ".
           05 PIC  X(30)   VALUE   "                              ".
      *
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "020003".
           05 PIC  X(30)   VALUE   "該当患者の保険情報の番号に全角".
           05 PIC  X(30)   VALUE   "文字以外が入力されています    ".
           05 PIC  X(30)   VALUE   "                              ".
      *
      *    ** 030xxx 公費負担者番号・受給者番号抜け
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "030001".
           05 PIC  X(30)   VALUE   "該当患者の公費情報に受給者番号".
           05 PIC  X(30)   VALUE   "又は負担者番号が未入力です    ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "030002".
           05 PIC  X(30)   VALUE   "該当患者の公費情報の負担者番号".
           05 PIC  X(30)   VALUE   "に全角文字と半角文字が混在して".
           05 PIC  X(30)   VALUE   "います                        ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "030003".
           05 PIC  X(30)   VALUE   "該当患者の公費情報の受給者番号".
           05 PIC  X(30)   VALUE   "に全角文字と半角文字が混在して".
           05 PIC  X(30)   VALUE   "います                        ".
      *
      *    ** 040xxx 保険適応年齢
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "040001".
           05 PIC  X(30)   VALUE   "該当患者は１５歳未満ですが本人".
           05 PIC  X(30)   VALUE   "で登録されています            ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "040002".
           05 PIC  X(30)   VALUE   "該当患者は老人保険の適応年齢誤".
           05 PIC  X(30)   VALUE   "りです                        ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "040003".
           05 PIC  X(30)   VALUE   "該当患者は老人保険が未設定です".
           05 PIC  X(30)   VALUE   "                              ".
           05 PIC  X(30)   VALUE   "                              ".
      *
      *    ** 050xxx 患者病名
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "050001".
           05 PIC  X(30)   VALUE   "該当患者は病名が未入力です    ".
           05 PIC  X(30)   VALUE   "                              ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "050002".
           05 PIC  X(30)   VALUE   "該当患者の患者病名情報は診療年".
           05 PIC  X(30)   VALUE   "月に対応する入院病名が入力され".
           05 PIC  X(30)   VALUE   "ていません                    ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "050003".
           05 PIC  X(30)   VALUE   "該当患者の患者病名情報は診療年".
           05 PIC  X(30)   VALUE   "月に対応する外来病名が入力され".
           05 PIC  X(30)   VALUE   "ていません                    ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "050004".
           05 PIC  X(30)   VALUE   "患者病名情報テーブルの病名が未".
           05 PIC  X(30)   VALUE   "設定です                      ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "050005".
           05 PIC  X(30)   VALUE   "該当患者は病名に全角文字以外が".
           05 PIC  X(30)   VALUE   "入力されています              ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "050006".
           05 PIC  X(30)   VALUE   "患者病名情報テーブルの病名文字".
           05 PIC  X(30)   VALUE   "数が未設定です                ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "050007".
           05 PIC  X(30)   VALUE   "該当患者は病名に対応する病名コ".
           05 PIC  X(30)   VALUE   "ードが入力されていません      ".
           05 PIC  X(30)   VALUE   "                              ".
      *
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "050008".
           05 PIC  X(30)   VALUE   "該当患者は転帰区分と転帰日の関".
           05 PIC  X(30)   VALUE   "係誤り                        ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "050009".
           05 PIC  X(30)   VALUE   "該当患者はカルテ病名に全角文字".
           05 PIC  X(30)   VALUE   "以外が入力されています        ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "050010".
           05 PIC  X(30)   VALUE   "レセ電算データの場合、病名文字".
           05 PIC  X(30)   VALUE   "数が１７文字を超えています    ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "050011".
           05 PIC  X(30)   VALUE   "レセ電算データの場合、病名文字".
           05 PIC  X(30)   VALUE   "数が２０文字を超えています    ".
           05 PIC  X(30)   VALUE   "                              ".
      *
      *    ** 060xxx 診療開始日
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "060001".
           05 PIC  X(30)   VALUE   "初診算定日から開始になる病名が".
           05 PIC  X(30)   VALUE   "存在しません                  ".
           05 PIC  X(30)   VALUE   "                              ".
      *
      *    ** 070xxx 疑い病名
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "070001".
           05 PIC  X(30)   VALUE   "該当患者は患者病名情報に古い診".
           05 PIC  X(30)   VALUE   "療開始日の疑い病名が入力されて".
           05 PIC  X(30)   VALUE   "います                        ".
      *
      *    ** 080xxx 薬剤と病名
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "080001".
           05 PIC  X(30)   VALUE   "薬剤の適応病名未入力です      ".
           05 PIC  X(30)   VALUE   "                              ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "080002".
           05 PIC  X(30)   VALUE   "適応病名に対応する入外区分が入".
           05 PIC  X(30)   VALUE   "院の病名で入力されていません  ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "080003".
           05 PIC  X(30)   VALUE   "適応病名に対応する入外区分が外".
           05 PIC  X(30)   VALUE   "来の病名で入力されていません  ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "080004".
           05 PIC  X(30)   VALUE   "適応病名が有効な期間で登録され".
           05 PIC  X(30)   VALUE   "ていません                    ".
           05 PIC  X(30)   VALUE   "                              ".
      *
      *    ** 090xxx 診療行為と病名
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "090001".
           05 PIC  X(30)   VALUE   "診療行為の適応病名未入力です  ".
           05 PIC  X(30)   VALUE   "                              ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "090002".
           05 PIC  X(30)   VALUE   "適応病名に対応する入外区分が入".
           05 PIC  X(30)   VALUE   "院の病名で入力されていません  ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "090003".
           05 PIC  X(30)   VALUE   "適応病名に対応する入外区分が外".
           05 PIC  X(30)   VALUE   "来の病名で入力されていません  ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "090004".
           05 PIC  X(30)   VALUE   "適応病名が有効な期間で登録され".
           05 PIC  X(30)   VALUE   "ていません                    ".
           05 PIC  X(30)   VALUE   "                              ".
      *
      *    ** 010xxx 併用禁忌の薬剤
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "100001".
           05 PIC  X(30)   VALUE   "禁忌の薬剤が入力されています  ".
           05 PIC  X(30)   VALUE   "                              ".
           05 PIC  X(30)   VALUE   "                              ".
      *
      *    ** 110xxx 併用算定の診療行為
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "110001".
           05 PIC  X(30)   VALUE   "診療行為が併用算定の誤りです  ".
           05 PIC  X(30)   VALUE   "                              ".
           05 PIC  X(30)   VALUE   "                              ".
      *
      *    ** 120xxx 実日数
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "120001".
           05 PIC  X(30)   VALUE   "該当患者は実日数を越えた回数を".
           05 PIC  X(30)   VALUE   "算定しています                ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "120002".
           05 PIC  X(30)   VALUE   "入院していない日に入院診療があ".
           05 PIC  X(30)   VALUE   "ります                        ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "120003".
           05 PIC  X(30)   VALUE   "外泊のときに入院調剤料が発生し".
           05 PIC  X(30)   VALUE   "ています                      ".
           05 PIC  X(30)   VALUE   "                              ".
      *
      *    ** 130xxx 患者氏名
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "130001".
           05 PIC  X(30)   VALUE   "該当患者は漢字氏名に全角文字以".
           05 PIC  X(30)   VALUE   "外が入力されています          ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "130002".
           05 PIC  X(30)   VALUE   "該当患者はカナ氏名に全角文字以".
           05 PIC  X(30)   VALUE   "外が入力されています          ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "130003".
           05 PIC  X(30)   VALUE   "該当患者は漢字氏名が未入力です".
           05 PIC  X(30)   VALUE   "                              ".
           05 PIC  X(30)   VALUE   "                              ".
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "130004".
           05 PIC  X(30)   VALUE   "該当患者はカナ氏名が未入力です".
           05 PIC  X(30)   VALUE   "                              ".
           05 PIC  X(30)   VALUE   "                              ".
      *
      *    ** 140xxx 保険組合せ有効期間
      *                            +---------+---------+---------+.
           05 PIC  X(06)   VALUE   "140001".
           05 PIC  X(30)   VALUE   "保険組合せが存在しません      ".
           05 PIC  X(30)   VALUE   "                              ".
           05 PIC  X(30)   VALUE   "                              ".
      *
           05 PIC  X(06)   VALUE   "140002".
           05 PIC  X(30)   VALUE   "保険の適用が切れている期間があ".
           05 PIC  X(30)   VALUE   "ります                        ".
           05 PIC  X(30)   VALUE   "                              ".
      *
         03  ERRMES-RED    REDEFINES   ERRMES-VAL.
           05 ERRMES-OCC   OCCURS  42.
              07  ERRMES-CD            PIC X(06).
              07  ERRMES-MESSAGE       PIC X(90).
         03  ERRMES-MAX                PIC 9(05)   VALUE   42.
