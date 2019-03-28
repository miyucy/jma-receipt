      ******************************************************************
      *    CPCLAIM002.INC
      ******************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  CLAIM002-VALUES.
           02  CLAIM002-T.
             03  CLAIM002-T11.
               05  CLAIM002-ORCA-T11   PIC  X(2)   VALUE   "11" .
               05  CLAIM002-CLAIM-T11  PIC  X(3)   VALUE   "110" .
               05  CLAIM002-NAME-T11   PIC  X(40)  
                   VALUE   "初診" .
             03  CLAIM002-T12.
               05  CLAIM002-ORCA-T12   PIC  X(2)   VALUE   "12" .
               05  CLAIM002-CLAIM-T12  PIC  X(3)   VALUE   "120" .
               05  CLAIM002-NAME-T13   PIC  X(40)  
                   VALUE   "再診（再診）" .
             03  CLAIM002-T13.
               05  CLAIM002-ORCA-T13   PIC  X(2)   VALUE   "13" .
               05  CLAIM002-CLAIM-T13  PIC  X(3)   VALUE   "130" .
               05  CLAIM002-NAME-T13   PIC  X(40)  
                   VALUE   "指導料" .
             03  CLAIM002-T14.
               05  CLAIM002-ORCA-T14   PIC  X(2)   VALUE   "14" .
               05  CLAIM002-CLAIM-T14  PIC  X(3)   VALUE   "140" .
               05  CLAIM002-NAME-T14   PIC  X(40)  
                   VALUE   "在宅料" .
             03  CLAIM002-T21.
               05  CLAIM002-ORCA-T21   PIC  X(2)   VALUE   "21" .
               05  CLAIM002-CLAIM-T21  PIC  X(3)   VALUE   "210" .
               05  CLAIM002-NAME-T21   PIC  X(40)  
                   VALUE   "投薬（内服・屯服・調剤）（入院外）" .
             03  CLAIM002-T22.
               05  CLAIM002-ORCA-T22   PIC  X(2)   VALUE   "22" .
               05  CLAIM002-CLAIM-T22  PIC  X(3)   VALUE   "220" .
               05  CLAIM002-NAME-T22   PIC  X(40)  
                   VALUE   "頓服料" .
             03  CLAIM002-T23.
               05  CLAIM002-ORCA-T23   PIC  X(2)   VALUE   "23" .
               05  CLAIM002-CLAIM-T23  PIC  X(3)   VALUE   "230" .
               05  CLAIM002-NAME-T23   PIC  X(40)  
                   VALUE   "外用" .
             03  CLAIM002-T24.
               05  CLAIM002-ORCA-T24   PIC  X(2)   VALUE   "24" .
               05  CLAIM002-CLAIM-T24  PIC  X(3)   VALUE   "240" .
               05  CLAIM002-NAME-T24   PIC  X(40)  
                   VALUE   "処方料" .
             03  CLAIM002-T25.
               05  CLAIM002-ORCA-T25   PIC  X(2)   VALUE   "25" .
               05  CLAIM002-CLAIM-T25  PIC  X(3)   VALUE   "250" .
               05  CLAIM002-NAME-T25   PIC  X(40)  
                   VALUE   "麻薬、毒薬加算" .
             03  CLAIM002-T26.
               05  CLAIM002-ORCA-T26   PIC  X(2)   VALUE   "26" .
               05  CLAIM002-CLAIM-T26  PIC  X(3)   VALUE   "260" .
               05  CLAIM002-NAME-T26   PIC  X(40)  
                   VALUE   "調剤技術基本料" .
             03  CLAIM002-T27.
               05  CLAIM002-ORCA-T27   PIC  X(2)   VALUE   "27" .
               05  CLAIM002-CLAIM-T27  PIC  X(3)   VALUE   "270" .
               05  CLAIM002-NAME-T27   PIC  X(40)  
                   VALUE   "処方箋料" .
             03  CLAIM002-T31.
               05  CLAIM002-ORCA-T31   PIC  X(2)   VALUE   "31" .
               05  CLAIM002-CLAIM-T31  PIC  X(3)   VALUE   "310" .
               05  CLAIM002-NAME-T31   PIC  X(40)  
                   VALUE   "皮下筋注" .
             03  CLAIM002-T32.
               05  CLAIM002-ORCA-T32   PIC  X(2)   VALUE   "32" .
               05  CLAIM002-CLAIM-T32  PIC  X(3)   VALUE   "320" .
               05  CLAIM002-NAME-T32   PIC  X(40)  
                   VALUE   "静注" .
             03  CLAIM002-T33.
               05  CLAIM002-ORCA-T33   PIC  X(2)   VALUE   "33" .
               05  CLAIM002-CLAIM-T33  PIC  X(3)   VALUE   "330" .
               05  CLAIM002-NAME-T33   PIC  X(40)  
                   VALUE   "その他注射" .
             03  CLAIM002-T34.
               05  CLAIM002-ORCA-T34   PIC  X(2)   VALUE   "34" .
               05  CLAIM002-CLAIM-T34  PIC  X(3)   VALUE   "340" .
               05  CLAIM002-NAME-T34   PIC  X(40)  
                   VALUE   "自己注射" .
             03  CLAIM002-T41.
               05  CLAIM002-ORCA-T41   PIC  X(2)   VALUE   "40" .
               05  CLAIM002-CLAIM-T41  PIC  X(3)   VALUE   "400" .
               05  CLAIM002-NAME-T41   PIC  X(40)  
                   VALUE   "処置" .
             03  CLAIM002-T48.
               05  CLAIM002-ORCA-T48   PIC  X(2)   VALUE   "48" .
               05  CLAIM002-CLAIM-T48  PIC  X(3)   VALUE   "480" .
               05  CLAIM002-NAME-T48   PIC  X(40)  
                   VALUE   "処置材料" .
             03  CLAIM002-T49.
               05  CLAIM002-ORCA-T49   PIC  X(2)   VALUE   "49" .
               05  CLAIM002-CLAIM-T49  PIC  X(3)   VALUE   "490" .
               05  CLAIM002-NAME-T49   PIC  X(40)  
                   VALUE   "処置薬剤" .
             03  CLAIM002-T51.
               05  CLAIM002-ORCA-T51   PIC  X(2)   VALUE   "51" .
               05  CLAIM002-CLAIM-T51  PIC  X(3)   VALUE   "510" .
               05  CLAIM002-NAME-T51   PIC  X(40)  
                   VALUE   "手術料" .
             03  CLAIM002-T52.
               05  CLAIM002-ORCA-T52   PIC  X(2)   VALUE   "52" .
               05  CLAIM002-CLAIM-T52  PIC  X(3)   VALUE   "520" .
               05  CLAIM002-NAME-T52   PIC  X(40)  
                   VALUE   "輸血料" .
             03  CLAIM002-T53.
               05  CLAIM002-ORCA-T53   PIC  X(2)   VALUE   "53" .
               05  CLAIM002-CLAIM-T53  PIC  X(3)   VALUE   "530" .
               05  CLAIM002-NAME-T53   PIC  X(40)  
                   VALUE   "ギプス料" .
             03  CLAIM002-T54.
               05  CLAIM002-ORCA-T54   PIC  X(2)   VALUE   "54" .
               05  CLAIM002-CLAIM-T54  PIC  X(3)   VALUE   "540" .
               05  CLAIM002-NAME-T54   PIC  X(40)  
                   VALUE   "麻酔料" .
             03  CLAIM002-T58.
               05  CLAIM002-ORCA-T58   PIC  X(2)   VALUE   "58" .
               05  CLAIM002-CLAIM-T58  PIC  X(3)   VALUE   "580" .
               05  CLAIM002-NAME-T58   PIC  X(40)  
                   VALUE   "手術材料" .
             03  CLAIM002-T59.
               05  CLAIM002-ORCA-T59   PIC  X(2)   VALUE   "59" .
               05  CLAIM002-CLAIM-T59  PIC  X(3)   VALUE   "590" .
               05  CLAIM002-NAME-T59   PIC  X(40)  
                   VALUE   "手術薬剤" .
             03  CLAIM002-T61.
               05  CLAIM002-ORCA-T61   PIC  X(2)   VALUE   "60" .
               05  CLAIM002-CLAIM-T61  PIC  X(3)   VALUE   "600" .
               05  CLAIM002-NAME-T61   PIC  X(40)  
                   VALUE   "検査" .
             03  CLAIM002-T62.
               05  CLAIM002-ORCA-T62   PIC  X(2)   VALUE   "62" .
               05  CLAIM002-CLAIM-T62  PIC  X(3)   VALUE   "620" .
               05  CLAIM002-NAME-T62   PIC  X(40)  
                   VALUE   "病理学的検査料" .
             03  CLAIM002-T63.
               05  CLAIM002-ORCA-T63   PIC  X(2)   VALUE   "63" .
               05  CLAIM002-CLAIM-T63  PIC  X(3)   VALUE   "630" .
               05  CLAIM002-NAME-T63   PIC  X(40)  
                   VALUE   "生体検査料" .
             03  CLAIM002-T64.
               05  CLAIM002-ORCA-T64   PIC  X(2)   VALUE   "64" .
               05  CLAIM002-CLAIM-T64  PIC  X(3)   VALUE   "640" .
               05  CLAIM002-NAME-T64   PIC  X(40)  
                   VALUE   "その他検査料" .
             03  CLAIM002-T68.
               05  CLAIM002-ORCA-T68   PIC  X(2)   VALUE   "68" .
               05  CLAIM002-CLAIM-T68  PIC  X(3)   VALUE   "680" .
               05  CLAIM002-NAME-T68   PIC  X(40)  
                   VALUE   "検査材料" .
             03  CLAIM002-T69.
               05  CLAIM002-ORCA-T69   PIC  X(2)   VALUE   "69" .
               05  CLAIM002-CLAIM-T69  PIC  X(3)   VALUE   "690" .
               05  CLAIM002-NAME-T69   PIC  X(40)  
                   VALUE   "検査薬剤" .
             03  CLAIM002-T71.
               05  CLAIM002-ORCA-T71   PIC  X(2)   VALUE   "71" .
               05  CLAIM002-CLAIM-T71  PIC  X(3)   VALUE   "710" .
               05  CLAIM002-NAME-T71   PIC  X(40)  
                   VALUE   "Ｘ線診断料" .
             03  CLAIM002-T72.
               05  CLAIM002-ORCA-T72   PIC  X(2)   VALUE   "72" .
               05  CLAIM002-CLAIM-T72  PIC  X(3)   VALUE   "720" .
               05  CLAIM002-NAME-T72   PIC  X(40)  
                   VALUE   "核医学診断料" .
             03  CLAIM002-T73.
               05  CLAIM002-ORCA-T73   PIC  X(2)   VALUE   "73" .
               05  CLAIM002-CLAIM-T73  PIC  X(3)   VALUE   "730" .
               05  CLAIM002-NAME-T73   PIC  X(40)  
                   VALUE   "コンピュータ断層診断料" .
             03  CLAIM002-T74.
               05  CLAIM002-ORCA-T74   PIC  X(2)   VALUE   "74" .
               05  CLAIM002-CLAIM-T74  PIC  X(3)   VALUE   "740" .
               05  CLAIM002-NAME-T74   PIC  X(40)  
                   VALUE   "手技料その他" .
             03  CLAIM002-T78.
               05  CLAIM002-ORCA-T78   PIC  X(2)   VALUE   "78" .
               05  CLAIM002-CLAIM-T78  PIC  X(3)   VALUE   "780" .
               05  CLAIM002-NAME-T78   PIC  X(40)  
                   VALUE   "Ｘ線材料" .
             03  CLAIM002-T79.
               05  CLAIM002-ORCA-T79   PIC  X(2)   VALUE   "79" .
               05  CLAIM002-CLAIM-T79  PIC  X(3)   VALUE   "790" .
               05  CLAIM002-NAME-T79   PIC  X(40)  
                   VALUE   "Ｘ線薬剤" .
             03  CLAIM002-T81.
               05  CLAIM002-ORCA-T81   PIC  X(2)   VALUE   "81" .
               05  CLAIM002-CLAIM-T81  PIC  X(3)   VALUE   "810" .
               05  CLAIM002-NAME-T81   PIC  X(40)  
                   VALUE   "理学療法" .
             03  CLAIM002-T82.
               05  CLAIM002-ORCA-T82   PIC  X(2)   VALUE   "80" .
               05  CLAIM002-CLAIM-T82  PIC  X(3)   VALUE   "800" .
               05  CLAIM002-NAME-T82   PIC  X(40)  
                   VALUE   "その他" .
             03  CLAIM002-T83.
               05  CLAIM002-ORCA-T83   PIC  X(2)   VALUE   "83" .
               05  CLAIM002-CLAIM-T83  PIC  X(3)   VALUE   "830" .
               05  CLAIM002-NAME-T83   PIC  X(40)  
                   VALUE   "放射線治療料" .
             03  CLAIM002-T84.
               05  CLAIM002-ORCA-T84   PIC  X(2)   VALUE   "84" .
               05  CLAIM002-CLAIM-T84  PIC  X(3)   VALUE   "840" .
               05  CLAIM002-NAME-T84   PIC  X(40)  
                   VALUE   "その他" .
             03  CLAIM002-T91.
               05  CLAIM002-ORCA-T91   PIC  X(2)   VALUE   "91" .
               05  CLAIM002-CLAIM-T91  PIC  X(3)   VALUE   "910" .
               05  CLAIM002-NAME-T91   PIC  X(40)  
                   VALUE   "室料" .
             03  CLAIM002-T92.
               05  CLAIM002-ORCA-T92   PIC  X(2)   VALUE   "92" .
               05  CLAIM002-CLAIM-T92  PIC  X(3)   VALUE   "920" .
               05  CLAIM002-NAME-T92   PIC  X(40)  
                   VALUE   "看護料" .
             03  CLAIM002-T93.
               05  CLAIM002-ORCA-T93   PIC  X(2)   VALUE   "93" .
               05  CLAIM002-CLAIM-T93  PIC  X(3)   VALUE   "930" .
               05  CLAIM002-NAME-T93   PIC  X(40)  
                   VALUE   "給食料" .
             03  CLAIM002-T94.
               05  CLAIM002-ORCA-T94   PIC  X(2)   VALUE   "94" .
               05  CLAIM002-CLAIM-T94  PIC  X(3)   VALUE   "940" .
               05  CLAIM002-NAME-T94   PIC  X(40)  
                   VALUE   "医学管理料" .
             03  CLAIM002-T95.
               05  CLAIM002-ORCA-T95   PIC  X(2)   VALUE   "XX" .
               05  CLAIM002-CLAIM-T95  PIC  X(3)   VALUE   "950" .
               05  CLAIM002-NAME-T95   PIC  X(40)  
                   VALUE   "入院時一部負担金" .
             03  CLAIM002-T951.
               05  CLAIM002-ORCA-T951  PIC  X(2)   VALUE   "XX" .
               05  CLAIM002-CLAIM-T951 PIC  X(3)   VALUE   "951" .
               05  CLAIM002-NAME-T951  PIC  X(40)  
                   VALUE   "薬剤一部負担金" .
             03  CLAIM002-T952.
               05  CLAIM002-ORCA-T952  PIC  X(2)   VALUE   "XX" .
               05  CLAIM002-CLAIM-T952 PIC  X(3)   VALUE   "952" .
               05  CLAIM002-NAME-T952  PIC  X(40)  
                   VALUE   "食餌一部負担金" .
             03  CLAIM002-T953.
               05  CLAIM002-ORCA-T953  PIC  X(2)   VALUE   "XX" .
               05  CLAIM002-CLAIM-T953 PIC  X(3)   VALUE   "953" .
               05  CLAIM002-NAME-T953  PIC  X(40)  
                   VALUE   "その他一部負担金" .
             03  CLAIM002-T96.
               05  CLAIM002-ORCA-T96   PIC  X(2)   VALUE   "YY" .
               05  CLAIM002-CLAIM-T96  PIC  X(3)   VALUE   "960" .
               05  CLAIM002-NAME-T96   PIC  X(40)  
                   VALUE   "室料差額" .
             03  CLAIM002-T97.
               05  CLAIM002-ORCA-T97   PIC  X(2)   VALUE   "97" .
               05  CLAIM002-CLAIM-T97  PIC  X(3)   VALUE   "970" .
               05  CLAIM002-NAME-T97   PIC  X(40)  
                   VALUE   "重症者加算" .
             03  CLAIM002-T98.
               05  CLAIM002-ORCA-T98   PIC  X(2)   VALUE   "98" .
               05  CLAIM002-CLAIM-T98  PIC  X(3)   VALUE   "980" .
               05  CLAIM002-NAME-T98   PIC  X(40)  
                   VALUE   "ＩＣＵ加算" .
             03  CLAIM002-T99.
               05  CLAIM002-ORCA-T99   PIC  X(2)   VALUE   "99" .
               05  CLAIM002-CLAIM-T99  PIC  X(3)   VALUE   "990" .
               05  CLAIM002-NAME-T99   PIC  X(40)  
                   VALUE   "入院料その他（病衣貸与料など）" .
             03  CLAIM002-T011.
               05  CLAIM002-ORCA-T011  PIC  X(2)   VALUE   "11" .
               05  CLAIM002-CLAIM-T011 PIC  X(3)   VALUE   "011" .
               05  CLAIM002-NAME-T011  PIC  X(40)  
                   VALUE   "分娩介助料" .
             03  CLAIM002-T012.
               05  CLAIM002-ORCA-T012  PIC  X(2)   VALUE   "12" .
               05  CLAIM002-CLAIM-T012 PIC  X(3)   VALUE   "012" .
               05  CLAIM002-NAME-T012  PIC  X(40)  
                   VALUE   "文書料" .
             03  CLAIM002-T013.
               05  CLAIM002-ORCA-T013  PIC  X(2)   VALUE   "13" .
               05  CLAIM002-CLAIM-T013 PIC  X(3)   VALUE   "013" .
               05  CLAIM002-NAME-T013  PIC  X(40)  
                   VALUE   "容器代" .
             03  CLAIM002-T014.
               05  CLAIM002-ORCA-T014  PIC  X(2)   VALUE   "95" .
               05  CLAIM002-CLAIM-T014 PIC  X(3)   VALUE   "014" .
               05  CLAIM002-NAME-T014  PIC  X(40)  
                   VALUE   "自費（消費税なし）" .
             03  CLAIM002-T015.
               05  CLAIM002-ORCA-T015  PIC  X(2)   VALUE   "15" .
               05  CLAIM002-CLAIM-T015 PIC  X(3)   VALUE   "015" .
               05  CLAIM002-NAME-T015  PIC  X(40)  
                   VALUE   "高度先進医療" .
             03  CLAIM002-T016.
               05  CLAIM002-ORCA-T014  PIC  X(2)   VALUE   "96" .
               05  CLAIM002-CLAIM-T014 PIC  X(3)   VALUE   "016" .
               05  CLAIM002-NAME-T014  PIC  X(40)  
                   VALUE   "自費（消費税あり）" .
             03  CLAIM002-T019.
               05  CLAIM002-ORCA-T019  PIC  X(2)   VALUE   "19" .
               05  CLAIM002-CLAIM-T019 PIC  X(3)   VALUE   "019" .
               05  CLAIM002-NAME-T019  PIC  X(40)  
                   VALUE   "その他の自費" .
           02  CLAIM002-R  REDEFINES   CLAIM002-T.
             03  CLAIM002-TX           OCCURS  59.
               05  CLAIM002-ORCA       PIC  X(2).
               05  CLAIM002-CLAIM      PIC  X(3).
               05  CLAIM002-NAME       PIC  X(40).
