      ******************************************************************
      *    CPCLAIM007.INC
      ******************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  04.02.01    NACL-多々納  08/03/14  Ｈ２０年４月改正対応
      ************************************************************
       01  CLAIM007-VALUES.
           02  CLAIM007-T.
             03  CLAIM007-T000.
      *        05  FILLER               PIC  X(2)   VALUE   "00" .
               05  FILLER               PIC  X(3)   VALUE   "000" .
               05  FILLER               PIC  X(40)  
                   VALUE   "その他" .
             03  CLAIM007-T110.
      *        05  CLAIM007-ORCA-T110   PIC  X(2)   VALUE   "11" .
               05  CLAIM007-CLAIM-T110  PIC  X(3)   VALUE   "110" .
               05  CLAIM007-NAME-T110   PIC  X(40)  
                   VALUE   "初診" .
             03  CLAIM007-T120.
      *        05  CLAIM007-ORCA-T120   PIC  X(2)   VALUE   "12" .
               05  CLAIM007-CLAIM-T120  PIC  X(3)   VALUE   "120" .
               05  CLAIM007-NAME-T120   PIC  X(40)  
                   VALUE   "再診（再診）" .
             03  CLAIM007-T122.
      *        05  CLAIM007-ORCA-T122   PIC  X(2)   VALUE   "12" .
               05  CLAIM007-CLAIM-T122  PIC  X(3)   VALUE   "122" .
               05  CLAIM007-NAME-T122   PIC  X(40)  
                   VALUE   "再診（外来管理加算）" .
             03  CLAIM007-T123.
      *        05  CLAIM007-ORCA-T123   PIC  X(2)   VALUE   "12" .
               05  CLAIM007-CLAIM-T123  PIC  X(3)   VALUE   "123" .
               05  CLAIM007-NAME-T123   PIC  X(40)  
                   VALUE   "再診（時間外）" .
             03  CLAIM007-T124.
      *        05  CLAIM007-ORCA-T124   PIC  X(2)   VALUE   "12" .
               05  CLAIM007-CLAIM-T124  PIC  X(3)   VALUE   "124" .
               05  CLAIM007-NAME-T124   PIC  X(40)  
                   VALUE   "再診（休日）" .
             03  CLAIM007-T125.
      *        05  CLAIM007-ORCA-T125   PIC  X(2)   VALUE   "12" .
               05  CLAIM007-CLAIM-T125  PIC  X(3)   VALUE   "125" .
               05  CLAIM007-NAME-T125   PIC  X(40)  
                   VALUE   "再診（深夜）" .
             03  CLAIM007-T126.
      *        05  CLAIM007-ORCA-T126   PIC  X(2)   VALUE   "12" .
               05  CLAIM007-CLAIM-T126  PIC  X(3)   VALUE   "126" .
               05  CLAIM007-NAME-T126   PIC  X(40)  
                   VALUE   "再診（夜間・早朝）" .
             03  CLAIM007-T130.
      *        05  CLAIM007-ORCA-T130   PIC  X(2)   VALUE   "13" .
               05  CLAIM007-CLAIM-T130  PIC  X(3)   VALUE   "130" .
               05  CLAIM007-NAME-T130   PIC  X(40)  
                   VALUE   "指導" .
             03  CLAIM007-T140.
      *        05  CLAIM007-ORCA-T140   PIC  X(2)   VALUE   "14" .
               05  CLAIM007-CLAIM-T140  PIC  X(3)   VALUE   "140" .
               05  CLAIM007-NAME-T140   PIC  X(40)  
                   VALUE   "在宅" .
             03  CLAIM007-T210.
      *        05  CLAIM007-ORCA-T210   PIC  X(2)   VALUE   "21" .
               05  CLAIM007-CLAIM-T210  PIC  X(3)   VALUE   "210" .
               05  CLAIM007-NAME-T210   PIC  X(40)  
                   VALUE   "投薬（内服・調剤）（入院外）" .
             03  CLAIM007-T210.
      *        05  CLAIM007-ORCA-T220   PIC  X(2)   VALUE   "22" .
               05  CLAIM007-CLAIM-T220  PIC  X(3)   VALUE   "220" .
               05  CLAIM007-NAME-T220   PIC  X(40)  
                   VALUE   "投薬（屯服）" .
             03  CLAIM007-T230.
      *        05  CLAIM007-ORCA-T230   PIC  X(2)   VALUE   "23" .
               05  CLAIM007-CLAIM-T230  PIC  X(3)   VALUE   "230" .
               05  CLAIM007-NAME-T230   PIC  X(40)  
                   VALUE   "投薬（外用・調剤）（入院外）" .
             03  CLAIM007-T240.
      *        05  FILLER               PIC  X(2)   VALUE   "24" .
               05  FILLER               PIC  X(3)   VALUE   "240" .
               05  FILLER               PIC  X(40)  
                   VALUE   "投薬（調剤）（入院）" .
             03  CLAIM007-T250.
      *        05  FILLER               PIC  X(2)   VALUE   "25" .
               05  FILLER               PIC  X(3)   VALUE   "250" .
               05  FILLER               PIC  X(40)  
                   VALUE   "投薬（処方）" .
             03  CLAIM007-T260.
      *        05  FILLER               PIC  X(2)   VALUE   "26" .
               05  FILLER               PIC  X(3)   VALUE   "260" .
               05  FILLER               PIC  X(40)  
                   VALUE   "投薬（麻毒）" .
             03  CLAIM007-T270.
      *        05  FILLER               PIC  X(2)   VALUE   "27" .
               05  FILLER               PIC  X(3)   VALUE   "270" .
               05  FILLER               PIC  X(40)  
                   VALUE   "投薬（調基）" .
             03  CLAIM007-T300.
      *        05  FILLER               PIC  X(2)   VALUE   "30" .
               05  FILLER               PIC  X(3)   VALUE   "300" .
               05  FILLER               PIC  X(40)  
                   VALUE   "注射（生物学的製剤・精密持続点滴・麻薬）" .
             03  CLAIM007-T311.
      *        05  FILLER               PIC  X(2)   VALUE   "31" .
               05  FILLER               PIC  X(3)   VALUE   "311" .
               05  FILLER               PIC  X(40)  
                   VALUE   "注射（皮下筋肉内）" .
             03  CLAIM007-T321.
      *        05  FILLER               PIC  X(2)   VALUE   "32" .
               05  FILLER               PIC  X(3)   VALUE   "321" .
               05  FILLER               PIC  X(40)  
                   VALUE   "注射（静脈内）" .
             03  CLAIM007-T331.
      *        05  FILLER               PIC  X(2)   VALUE   "33" .
               05  FILLER               PIC  X(3)   VALUE   "331" .
               05  FILLER               PIC  X(40)  
                   VALUE   "注射（その他）" .
             03  CLAIM007-T400.
      *        05  FILLER               PIC  X(2)   VALUE   "40" .
               05  FILLER               PIC  X(3)   VALUE   "400" .
               05  FILLER               PIC  X(40)  
                   VALUE   "処置" .
             03  CLAIM007-T500.
      *        05  FILLER               PIC  X(2)   VALUE   "50" .
               05  FILLER               PIC  X(3)   VALUE   "500" .
               05  FILLER               PIC  X(40)  
                   VALUE   "手術（手術）" .
             03  CLAIM007-T502.
      *        05  FILLER               PIC  X(2)   VALUE   "50" .
               05  FILLER               PIC  X(3)   VALUE   "502" .
               05  FILLER               PIC  X(40)  
                   VALUE   "手術（輸血）" .
             03  CLAIM007-T503.
      *        05  FILLER               PIC  X(2)   VALUE   "50" .
               05  FILLER               PIC  X(3)   VALUE   "503" .
               05  FILLER               PIC  X(40)  
                   VALUE   "手術（ギプス）" .
             03  CLAIM007-T540.
      *        05  FILLER               PIC  X(2)   VALUE   "54" .
               05  FILLER               PIC  X(3)   VALUE   "540" .
               05  FILLER               PIC  X(40)  
                   VALUE   "麻酔" .
             03  CLAIM007-T600.
      *        05  FILLER               PIC  X(2)   VALUE   "60" .
               05  FILLER               PIC  X(3)   VALUE   "600" .
               05  FILLER               PIC  X(40)  
                   VALUE   "検査" .
             03  CLAIM007-T640.
      *        05  FILLER               PIC  X(2)   VALUE   "64" .
               05  FILLER               PIC  X(3)   VALUE   "640" .
               05  FILLER               PIC  X(40)  
                   VALUE   "病理診断" .
             03  CLAIM007-T700.
      *        05  FILLER               PIC  X(2)   VALUE   "70" .
               05  FILLER               PIC  X(3)   VALUE   "700" .
               05  FILLER               PIC  X(40)  
                   VALUE   "画像診断" .
             03  CLAIM007-T800.
      *        05  FILLER               PIC  X(2)   VALUE   "80" .
               05  FILLER               PIC  X(3)   VALUE   "800" .
               05  FILLER               PIC  X(40)  
                   VALUE   "その他" .
             03  CLAIM007-T903.
      *        05  FILLER               PIC  X(2)   VALUE   "90" .
               05  FILLER               PIC  X(3)   VALUE   "903" .
               05  FILLER               PIC  X(40)  
                   VALUE   "入院（入院料）" .
             03  CLAIM007-T906.
      *        05  FILLER               PIC  X(2)   VALUE   "90" .
               05  FILLER               PIC  X(3)   VALUE   "906" .
               05  FILLER               PIC  X(40)  
                   VALUE   "入院（外泊）" .
             03  CLAIM007-T910.
      *        05  FILLER               PIC  X(2)   VALUE   "91" .
               05  FILLER               PIC  X(3)   VALUE   "910" .
               05  FILLER               PIC  X(40)  
                   VALUE   "入院（入院時医学管理下）" .
             03  CLAIM007-T920.
      *        05  FILLER               PIC  X(2)   VALUE   "92" .
               05  FILLER               PIC  X(3)   VALUE   "920" .
               05  FILLER               PIC  X(40)  
                   VALUE   "入院（特定入院料・その他）" .
             03  CLAIM007-T970.
      *        05  FILLER               PIC  X(2)   VALUE   "97" .
               05  FILLER               PIC  X(3)   VALUE   "970" .
               05  FILLER               PIC  X(40)  
                   VALUE   "入院（食事療養）" .
             03  CLAIM007-T971.
      *        05  FILLER               PIC  X(2)   VALUE   "97" .
               05  FILLER               PIC  X(3)   VALUE   "971" .
               05  FILLER               PIC  X(40)  
                   VALUE   "入院（標準負担額）" .
             03  CLAIM007-T014.
      *        05  FILLER               PIC  X(2)   VALUE   "95" .
               05  FILLER               PIC  X(3)   VALUE   "014" .
               05  FILLER               PIC  X(40)  
                   VALUE   "自費（消費税なし）" .
             03  CLAIM007-T016.
      *        05  FILLER               PIC  X(2)   VALUE   "96" .
               05  FILLER               PIC  X(3)   VALUE   "016" .
               05  FILLER               PIC  X(40)  
                   VALUE   "自費（消費税あり）" .
           02  CLAIM007-R  REDEFINES   CLAIM007-T.
             03  CLAIM007-TX           OCCURS  38.
      *        05  CLAIM007-ORCA       PIC  X(2).
               05  CLAIM007-CLAIM      PIC  X(3).
               05  CLAIM007-NAME       PIC  X(40).
       01  CLAIM007-MAX                PIC  9(03)  VALUE   38.
      *
