      ******************************************************************
      *    CPMML0031.INC
      ******************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 外部ファイルに出力するときは、ZZZ編集する
      * 但し、国保の場合のみ「00」を設定する
      ************************************************************
       01  MML0031-VALUES.
           02  MML0031-T.
               05  FILLER               PIC  X(3)   VALUE   "001" .
               05  FILLER               PIC  X(40)  
                   VALUE   "政府管掌" .
               05  FILLER               PIC  X(3)   VALUE   "002" .
               05  FILLER               PIC  X(40)  
                   VALUE   "船員" .
               05  FILLER               PIC  X(3)   VALUE   "003" .
               05  FILLER               PIC  X(40)  
                   VALUE   "日雇" .
               05  FILLER               PIC  X(3)   VALUE   "004" .
               05  FILLER               PIC  X(40)  
                   VALUE   "日雇・特別" .
               05  FILLER               PIC  X(3)   VALUE   "006" .
               05  FILLER               PIC  X(40)  
                   VALUE   "組合" .
               05  FILLER               PIC  X(3)   VALUE   "007" .
               05  FILLER               PIC  X(40)  
                   VALUE   "自衛官等" .
               05  FILLER               PIC  X(3)   VALUE   "031" .
               05  FILLER               PIC  X(40)  
                   VALUE   "国家共済" .
               05  FILLER               PIC  X(3)   VALUE   "032" .
               05  FILLER               PIC  X(40)  
                   VALUE   "地方共済" .
               05  FILLER               PIC  X(3)   VALUE   "033" .
               05  FILLER               PIC  X(40)  
                   VALUE   "警察共済" .
               05  FILLER               PIC  X(3)   VALUE   "034" .
               05  FILLER               PIC  X(40)  
                   VALUE   "教職共済" .
               05  FILLER               PIC  X(3)   VALUE   "060" .
               05  FILLER               PIC  X(40)  
                   VALUE   "国保" .
               05  FILLER               PIC  X(3)   VALUE   "010" .
               05  FILLER               PIC  X(40)  
                   VALUE   "結予３４条" .
               05  FILLER               PIC  X(3)   VALUE   "011" .
               05  FILLER               PIC  X(40)  
                   VALUE   "桔予３５条" .
               05  FILLER               PIC  X(3)   VALUE   "012" .
               05  FILLER               PIC  X(40)  
                   VALUE   "生活保護" .
               05  FILLER               PIC  X(3)   VALUE   "013" .
               05  FILLER               PIC  X(40)  
                   VALUE   "戦傷療養" .
               05  FILLER               PIC  X(3)   VALUE   "014" .
               05  FILLER               PIC  X(40)  
                   VALUE   "戦傷更生" .
               05  FILLER               PIC  X(3)   VALUE   "015" .
               05  FILLER               PIC  X(40)  
                   VALUE   "身障更生" .
               05  FILLER               PIC  X(3)   VALUE   "016" .
               05  FILLER               PIC  X(40)  
                   VALUE   "児童育成" .
               05  FILLER               PIC  X(3)   VALUE   "017" .
               05  FILLER               PIC  X(40)  
                   VALUE   "児童療養" .
               05  FILLER               PIC  X(3)   VALUE   "018" .
               05  FILLER               PIC  X(40)  
                   VALUE   "原爆認定" .
               05  FILLER               PIC  X(3)   VALUE   "019" .
               05  FILLER               PIC  X(40)  
                   VALUE   "原爆一般" .
               05  FILLER               PIC  X(3)   VALUE   "020" .
               05  FILLER               PIC  X(40)  
                   VALUE   "精神２９条" .
               05  FILLER               PIC  X(3)   VALUE   "021" .
               05  FILLER               PIC  X(40)  
                   VALUE   "精神３２条" .
               05  FILLER               PIC  X(3)   VALUE   "022" .
               05  FILLER               PIC  X(40)  
                   VALUE   "麻薬" .
               05  FILLER               PIC  X(3)   VALUE   "023" .
               05  FILLER               PIC  X(40)  
                   VALUE   "母子教育" .
               05  FILLER               PIC  X(3)   VALUE   "027" .
               05  FILLER               PIC  X(40)  
                   VALUE   "老人保険" .
               05  FILLER               PIC  X(3)   VALUE   "041" .
               05  FILLER               PIC  X(40)  
                   VALUE   "老人・県" .
               05  FILLER               PIC  X(3)   VALUE   "042" .
               05  FILLER               PIC  X(40)  
                   VALUE   "老人・市" .
               05  FILLER               PIC  X(3)   VALUE   "051" .
               05  FILLER               PIC  X(40)  
                   VALUE   "特定疾患" .
               05  FILLER               PIC  X(3)   VALUE   "052" .
               05  FILLER               PIC  X(40)  
                   VALUE   "小児慢性" .
               05  FILLER               PIC  X(3)   VALUE   "053" .
               05  FILLER               PIC  X(40)  
                   VALUE   "児童保護" .
               05  FILLER               PIC  X(3)   VALUE   "067" .
               05  FILLER               PIC  X(40)  
                   VALUE   "退職者" .
               05  FILLER               PIC  X(3)   VALUE   "068" .
               05  FILLER               PIC  X(40)  
                   VALUE   "特療費" .
               05  FILLER               PIC  X(3)   VALUE   "069" .
               05  FILLER               PIC  X(40)  
                   VALUE   "退特療費" .
               05  FILLER               PIC  X(3)   VALUE   "063" .
               05  FILLER               PIC  X(40)  
                   VALUE   "特定健保" .
               05  FILLER               PIC  X(3)   VALUE   "072" .
               05  FILLER               PIC  X(40)  
                   VALUE   "国家特定" .
               05  FILLER               PIC  X(3)   VALUE   "073" .
               05  FILLER               PIC  X(40)  
                   VALUE   "地方特定" .
               05  FILLER               PIC  X(3)   VALUE   "074" .
               05  FILLER               PIC  X(40)  
                   VALUE   "警察特定" .
               05  FILLER               PIC  X(3)   VALUE   "075" .
               05  FILLER               PIC  X(40)  
                   VALUE   "教職特定" .
               05  FILLER               PIC  X(3)   VALUE   "0Z1" .
               05  FILLER               PIC  X(40)  
                   VALUE   "自費１" .
               05  FILLER               PIC  X(3)   VALUE   "0Z2" .
               05  FILLER               PIC  X(40)  
                   VALUE   "自費２" .
               05  FILLER               PIC  X(3)   VALUE   "0Z3" .
               05  FILLER               PIC  X(40)  
                   VALUE   "自費３" .
               05  FILLER               PIC  X(3)   VALUE   "039" .
               05  FILLER               PIC  X(40)  
                   VALUE   "後期高齢者" .
               05  FILLER               PIC  X(3)   VALUE   "040" .
               05  FILLER               PIC  X(40)  
                   VALUE   "後期特療費" .
               05  FILLER               PIC  X(3)   VALUE   "975" .
               05  FILLER               PIC  X(40)  
                   VALUE   "公害" .
               05  FILLER               PIC  X(3)   VALUE   "009" .
               05  FILLER               PIC  X(40)  
                   VALUE   "協会けんぽ" .
           02  MML0031-R  REDEFINES   MML0031-T.
             03  MML0031-TX           OCCURS  46.
               05  MML0031-HOKEN      PIC  X(3).
               05  MML0031-NAME       PIC  X(40).
      *
       01  MML0031-TMAX               PIC 9(03)  VALUE    46.
      *
