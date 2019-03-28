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
      *         短期滞在手術等基本料３                           *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  TANKI3-AREA.
           03  TANKI3-VAL.
      *        短手３（終夜睡眠ポリグラフィー１（携帯用装置））
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "97".
               05  FILLER          PIC X(09)   VALUE "190177610".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "20180331".
      *        短手３（終夜睡眠ポリグラフィー１（携帯用装置））（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "98".
               05  FILLER          PIC X(09)   VALUE "190177710".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "20180331".
      *        短手３（終夜睡眠ポリグラフィー２（多点感圧センサ））
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "99".
               05  FILLER          PIC X(09)   VALUE "190177810".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "20180331".
      *        短手３（終夜睡眠ポリグラフィー２（多点感圧センサ））（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "9A".
               05  FILLER          PIC X(09)   VALUE "190177910".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "20180331".
      *        短手３（終夜睡眠ポリグラフィー３（１及び２以外））
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "9B".
               05  FILLER          PIC X(09)   VALUE "190178010".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（終夜睡眠ポリグラフィー３（１及び２以外））（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "9C".
               05  FILLER          PIC X(09)   VALUE "190178110".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（小児食物アレルギー負荷検査）
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "9D".
               05  FILLER          PIC X(09)   VALUE "190178210".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（小児食物アレルギー負荷検査）（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "9E".
               05  FILLER          PIC X(09)   VALUE "190178310".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（前立腺針生検法）
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "9F".
               05  FILLER          PIC X(09)   VALUE "190178410".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（前立腺針生検法）（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "9G".
               05  FILLER          PIC X(09)   VALUE "190178510".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（腋臭症手術（皮膚有毛部切除術））
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "9H".
               05  FILLER          PIC X(09)   VALUE "190178610".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "20180331".
      *        短手３（腋臭症手術（皮膚有毛部切除術））（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "9I".
               05  FILLER          PIC X(09)   VALUE "190178710".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "20180331".
      *        短手３（関節鏡下手根管開放手術）
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "9J".
               05  FILLER          PIC X(09)   VALUE "190178810".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（関節鏡下手根管開放手術）（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "9K".
               05  FILLER          PIC X(09)   VALUE "190178910".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（胸腔鏡下交感神経節切除術（両側））
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "9L".
               05  FILLER          PIC X(09)   VALUE "190179010".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（胸腔鏡下交感神経節切除術（両側））（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "9M".
               05  FILLER          PIC X(09)   VALUE "190179110".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（水晶体再建術・眼内レンズ挿入・その他のもの）
      *        20140401-20160331
      *        短手３（水晶体再建術・眼内レンズ挿入・その他・片側）
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "9N".
               05  FILLER          PIC X(09)   VALUE "190179210".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（水晶体再建術・眼内レンズ挿入・その他のもの）（生活療養） 
      *        20140401-20160331
      *        短手３（水晶体再建術・眼内レンズ挿入・その他・片側）（生活療養） 
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "9O".
               05  FILLER          PIC X(09)   VALUE "190179310".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（水晶体再建術・眼内レンズ挿入・その他・両側） 
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "AY".
               05  FILLER          PIC X(09)   VALUE "190195910".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（水晶体再建術・眼内レンズ挿入・その他・両側）（生活療養） 
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "AZ".
               05  FILLER          PIC X(09)   VALUE "190196010".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（水晶体再建術・水晶体嚢拡張リング・縫着なし）
      *        20140701-20160331
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "AW".
               05  FILLER          PIC X(09)   VALUE "190182750".
               05  FILLER          PIC X(08)   VALUE "20140701".
               05  FILLER          PIC X(08)   VALUE "20160331".
      *        短手３（水晶体再建術・水晶体嚢拡張リング・縫着なし）（生活療養）
      *        20140701-20160331
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "AX".
               05  FILLER          PIC X(09)   VALUE "190182850".
               05  FILLER          PIC X(08)   VALUE "20140701".
               05  FILLER          PIC X(08)   VALUE "20160331".
      *        短手３（水晶体再建術（眼内レンズ挿入しない場合））  
      *        20140401-20160331
      *        短手３（水晶体再建術（眼内レンズ挿入しない・片側））
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "9P".
               05  FILLER          PIC X(09)   VALUE "190179410".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "20180331".
      *        短手３（水晶体再建術（眼内レンズ挿入しない場合））（生活療養）  
      *        20140401-20160331
      *        短手３（水晶体再建術（眼内レンズ挿入しない・片側））（生活療養）
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "9Q".
               05  FILLER          PIC X(09)   VALUE "190179510".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "20180331".
      *        短手３（水晶体再建術（眼内レンズ挿入しない・両側））
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "B0".
               05  FILLER          PIC X(09)   VALUE "190196110".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "20180331".
      *        短手３（水晶体再建術（眼内レンズ挿入しない・両側））（生活療養）
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "B1".
               05  FILLER          PIC X(09)   VALUE "190196210".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "20180331".
      *        短手３（乳腺腫瘍摘出術（長径５ｃｍ未満））
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "9R".
               05  FILLER          PIC X(09)   VALUE "190179610".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（乳腺腫瘍摘出術（長径５ｃｍ未満））（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "9S".
               05  FILLER          PIC X(09)   VALUE "190179710".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（経皮的シャント拡張術・血栓除去術）
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "B2".
               05  FILLER          PIC X(09)   VALUE "190196310".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（経皮的シャント拡張術・血栓除去術）（生活療養）
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "B3".
               05  FILLER          PIC X(09)   VALUE "190196410".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（下肢静脈瘤手術（抜去切除術））
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "9T".
               05  FILLER          PIC X(09)   VALUE "190179810".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（下肢静脈瘤手術（抜去切除術））（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "9U".
               05  FILLER          PIC X(09)   VALUE "190179910".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（下肢静脈瘤手術（硬化療法））
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "9V".
               05  FILLER          PIC X(09)   VALUE "190180010".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（下肢静脈瘤手術（硬化療法））（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "9W".
               05  FILLER          PIC X(09)   VALUE "190180110".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（下肢静脈瘤手術（高位結紮術））
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "9X".
               05  FILLER          PIC X(09)   VALUE "190180210".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（下肢静脈瘤手術（高位結紮術））（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "9Y".
               05  FILLER          PIC X(09)   VALUE "190180310".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（鼠径ヘルニア手術（３歳未満））
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "B4".
               05  FILLER          PIC X(09)   VALUE "190196510".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（鼠径ヘルニア手術（３歳未満））（生活療養）
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "B5".
               05  FILLER          PIC X(09)   VALUE "190196810".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（鼠径ヘルニア手術（３歳以上６歳未満））
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "B6".
               05  FILLER          PIC X(09)   VALUE "190196610".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（鼠径ヘルニア手術（３歳以上６歳未満））（生活療養）
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "B7".
               05  FILLER          PIC X(09)   VALUE "190196910".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（鼠径ヘルニア手術（６歳以上１５歳未満））
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "B8".
               05  FILLER          PIC X(09)   VALUE "190196710".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（鼠径ヘルニア手術（６歳以上１５歳未満））（生活療養）
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "B9".
               05  FILLER          PIC X(09)   VALUE "190197010".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（鼠径ヘルニア手術（１５歳未満））
      *        20140401-20160331
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "9Z".
               05  FILLER          PIC X(09)   VALUE "190180410".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "20160331".
      *        短手３（鼠径ヘルニア手術（１５歳未満））（生活療養）
      *        20140401-20160331
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "A0".
               05  FILLER          PIC X(09)   VALUE "190180510".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "20160331".
      *        短手３（鼠径ヘルニア手術（１５歳以上））
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "A1".
               05  FILLER          PIC X(09)   VALUE "190180610".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（鼠径ヘルニア手術（１５歳以上）（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "A2".
               05  FILLER          PIC X(09)   VALUE "190180710".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（腹腔鏡下鼠径ヘルニア手術（３歳未満））
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "BA".
               05  FILLER          PIC X(09)   VALUE "190197110".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（腹腔鏡下鼠径ヘルニア手術（３歳未満））（生活療養）
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "BB".
               05  FILLER          PIC X(09)   VALUE "190197410".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（腹腔鏡下鼠径ヘルニア手術（３歳以上６歳未満））
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "BC".
               05  FILLER          PIC X(09)   VALUE "190197210".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（腹腔鏡下鼠径ヘルニア手術（３歳以上６歳未満））（生活療養）
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "BD".
               05  FILLER          PIC X(09)   VALUE "190197510".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（腹腔鏡下鼠径ヘルニア手術（６歳以上１５歳未満））
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "BE".
               05  FILLER          PIC X(09)   VALUE "190197310".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（腹腔鏡下鼠径ヘルニア手術（６歳以上１５歳未満））（生活療養）
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "BF".
               05  FILLER          PIC X(09)   VALUE "190197610".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（腹腔鏡下鼠径ヘルニア手術（１５歳未満））
      *        20140401-20160331
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "A3".
               05  FILLER          PIC X(09)   VALUE "190180810".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "20160331".
      *        短手３（腹腔鏡下鼠径ヘルニア手術（１５歳未満））（生活療養）
      *        20140401-20160331
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "A4".
               05  FILLER          PIC X(09)   VALUE "190180910".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "20160331".
      *        短手３（腹腔鏡下鼠径ヘルニア手術（１５歳以上））
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "A5".
               05  FILLER          PIC X(09)   VALUE "190181010".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（腹腔鏡下鼠径ヘルニア手術（１５歳以上））（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "A6".
               05  FILLER          PIC X(09)   VALUE "190181110".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（内視鏡的結腸ポリープ・粘膜切除術２ｃｍ未満）
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "A7".
               05  FILLER          PIC X(09)   VALUE "190181210".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（内視鏡的結腸ポリープ・粘膜切除術２ｃｍ未満）（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "A8".
               05  FILLER          PIC X(09)   VALUE "190181310".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（内視鏡的結腸ポリープ・粘膜切除術２ｃｍ以上）
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "A9".
               05  FILLER          PIC X(09)   VALUE "190181410".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（内視鏡的結腸ポリープ・粘膜切除術２ｃｍ以上）（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "AA".
               05  FILLER          PIC X(09)   VALUE "190181510".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（痔核手術（硬化療法（四段階注射法）））
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "AB".
               05  FILLER          PIC X(09)   VALUE "190181610".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（痔核手術（硬化療法（四段階注射法）））（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "AC".
               05  FILLER          PIC X(09)   VALUE "190181710".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（体外衝撃波腎・尿管結石破砕術）
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "BG".
               05  FILLER          PIC X(09)   VALUE "190197710".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（体外衝撃波腎・尿管結石破砕術）（生活療養）
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "BH".
               05  FILLER          PIC X(09)   VALUE "190197810".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（子宮頸部（腟部）切除術）
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "AD".
               05  FILLER          PIC X(09)   VALUE "190181810".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（子宮頸部（腟部）切除術）（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "AE".
               05  FILLER          PIC X(09)   VALUE "190181910".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（子宮鏡下子宮筋腫摘出術）
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "AF".
               05  FILLER          PIC X(09)   VALUE "190182010".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（子宮鏡下子宮筋腫摘出術）（生活療養）
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "AG".
               05  FILLER          PIC X(09)   VALUE "190182110".
               05  FILLER          PIC X(08)   VALUE "20140401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（ガンマナイフによる定位放射線治療）
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "0".
               05  FILLER          PIC X(02)   VALUE "BI".
               05  FILLER          PIC X(09)   VALUE "190197910".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
      *        短手３（ガンマナイフによる定位放射線治療）（生活療養）
      *        20160401-99999999
               05  FILLER          PIC X(01)   VALUE "1".
               05  FILLER          PIC X(02)   VALUE "BJ".
               05  FILLER          PIC X(09)   VALUE "190198010".
               05  FILLER          PIC X(08)   VALUE "20160401".
               05  FILLER          PIC X(08)   VALUE "99999999".
           03  TANKI3-R  REDEFINES TANKI3-VAL.
               05  TANKI3-OCC      OCCURS      70.
                   07  TANKI3-LIFEKBN          PIC X(01).
                   07  TANKI3-TOKCD            PIC X(02).
                   07  TANKI3-TANKICD          PIC X(09).
                   07  TANKI3-YUKOSTYMD        PIC X(08).
                   07  TANKI3-YUKOEDYMD        PIC X(08).
       01  TANKI3-MAX                          PIC 9(03)   VALUE 70.
