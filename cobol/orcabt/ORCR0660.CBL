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
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCR0660.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト（入院）
      *  コンポーネント名  : レセプトコメント編集
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/12/13    NaCl-門脇     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
           SELECT  RECE62-FILE     ASSIGN  RECE62PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE62-KEY
                                   FILE    STATUS  IS  STS-RECE62.
      *
           SELECT  RECE64-FILE     ASSIGN  RECE64PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE64-KEY
                                   FILE    STATUS  IS  STS-RECE64.
      *
           SELECT  RECE65-FILE     ASSIGN  RECE65PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE65-KEY
                                   FILE    STATUS  IS  STS-RECE65.
      *
           SELECT  RECE641-FILE    ASSIGN  RECE641PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE641-KEY
                                   FILE    STATUS  IS  STS-RECE641.
           SELECT  RECE6441-FILE   ASSIGN  RECE641PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE6441-KEY
                                   FILE    STATUS  IS  STS-RECE641.
      *
           SELECT  RECE651-FILE    ASSIGN  RECE651PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE651-KEY
                                   FILE    STATUS  IS  STS-RECE651.
           SELECT  RECE6551-FILE   ASSIGN  RECE651PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE6551-KEY
                                   FILE    STATUS  IS  STS-RECE651.
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    レセプト０２データ
       FD  RECE62-FILE.
       01  RECE62-REC.
           COPY    "CPRCF062.INC".
      *
      *    レセプト０４データ
       FD  RECE64-FILE.
       01  RECE64-REC.
           COPY    "CPRCF064.INC".
      *
      *    レセプト０５データ
       FD  RECE65-FILE.
       01  RECE65-REC.
           COPY    "CPRCF065.INC".
      *
       FD  RECE641-FILE.
       01  RECE641-REC. 
           COPY    "CPRCF064.INC"  REPLACING   //RECE64//
                                   BY          //RECE641//.
      *
       FD  RECE651-FILE.
       01  RECE651-REC. 
           COPY    "CPRCF065.INC"  REPLACING   //RECE65//
                                   BY          //RECE651//.
      *
       FD  RECE6441-FILE.
       01  RECE6441-REC. 
           COPY    "CPRCF064.INC"  REPLACING   //RECE64//
                                   BY          //RECE6441//.
      *
       FD  RECE6551-FILE.
       01  RECE6551-REC. 
           COPY    "CPRCF065.INC"  REPLACING   //RECE65//
                                   BY          //RECE6551//.
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE62//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE64//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE65//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE641//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE651//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    スパ領域
       01  SPA2-AREA.
           03  SPA-STS              PIC 9(04).
           03  SPA-ERRCD            PIC X(04).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECE            PIC X(02).
           03  STS-RECE62          PIC X(02).
           03  STS-RECE64          PIC X(02).
           03  STS-RECE641         PIC X(02).
           03  STS-RECE65          PIC X(02).
           03  STS-RECE651         PIC X(02).
           03  STS-PARA            PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-RECE62          PIC 9(01).
           03  FLG-RECE64          PIC 9(01).
           03  FLG-RECE65          PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-SHUJUTU-COMMENT PIC 9(01).
           03  FLG-WRKRECE65       PIC 9(01).
           03  FLG-JINZOU-COMMENT  PIC 9(01).
           03  FLG-SHIDOU-COMMENT  PIC 9(01).
           03  FLG-SANTEI          PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-JYURRK          PIC 9(01).
           03  FLG-FIRST           PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-RECE62          PIC 9(06).
           03  CNT-RECE64          PIC 9(06).
           03  CNT-RECE65          PIC 9(06).
           03  CNT-JINZOU          PIC 9(06).
           03  CNT-RIHA            PIC 9(06).
           03  CNT-RIGA1-KO        PIC 9(06).
           03  CNT-RIGA2-KO        PIC 9(06).
           03  CNT-RIGA3-KO        PIC 9(06).
           03  CNT-RIGA4-KO        PIC 9(06).
           03  CNT-RIGA1-SHU       PIC 9(06).
           03  CNT-RIGA2-SHU       PIC 9(06).
           03  CNT-RIGA3-SHU       PIC 9(06).
           03  CNT-RIGA4-SHU       PIC 9(06).
           03  CNT-SAGYO1-KO       PIC 9(06).
           03  CNT-SAGYO2-KO       PIC 9(06).
           03  CNT-SAGYO1-SHU      PIC 9(06).
           03  CNT-SAGYO2-SHU      PIC 9(06).
           03  CNT-GENGO1-KO       PIC 9(06).
           03  CNT-GENGO2-KO       PIC 9(06).
           03  CNT-GENGO1-SHU      PIC 9(06).
           03  CNT-GENGO2-SHU      PIC 9(06).
           03  CNT-JUSHIN          PIC 9(06).
           03  CNT-SANTEIKA        PIC 9(06).
           03  CNT-IN-COMMIT       PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  DAY-IDX             PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDX-RECE65          PIC 9(04).
      *     
      *    一時領域
       01  WRK-AREA.
           03  WRK-PARA.
               05  WRK-PARA-SRYYM              PIC  X(06).
               05  WRK-PARA-TERMID             PIC  X(16).
               05  WRK-PARA-SYSYMD             PIC  X(08).
               05  WRK-PARA-JOBID              PIC  9(07).
               05  WRK-PARA-SHELLID            PIC  X(08).
      *
           03  WRK-RENNUM          PIC 9(02).
           03  WRK-CNT-MEISAI      PIC 9(04).
           03  WRK-KETA            PIC 9(04).
           03  WRK-KETA-TAIHI      PIC 9(04).
           03  WRK-KETA2           PIC 9(04).
           03  WRK-KOHBUNRI        PIC 9(01).
           03  WRK-ZAINUM          PIC 9(05).
           03  WRK-RECEERR         PIC X(200).
      *
           03  TBL-SHUJUTSU-DAY.
               05  TB-SHUJUTSU-DAY PIC 9(02)   OCCURS  10.
      *
           03  WRK-HKNCOMBINUMX      PIC X(04).
           03  WRK-HKNCOMBINUM9      REDEFINES  WRK-HKNCOMBINUMX
                                     PIC 9(04).
      *
           03  WRK-SRYYMDX.
               05  WRK-SRYYM         PIC 9(06).
               05  WRK-SRYDD         PIC 9(02).
      *
       01  WRK-RECE64-REC. 
           COPY    "CPRCF064.INC"  REPLACING   //RECE64//
                                   BY          //WRK-RECE64//.
      *
       01  WRK-RECE65-REC. 
           COPY    "CPRCF065.INC"  REPLACING   //RECE65//
                                   BY          //WRK-RECE65//.
      *
       01  COM-RECE65-REC. 
           COPY    "CPRCF065.INC"  REPLACING   //RECE65//
                                   BY          //COM//.
      *
       01  WRK-SRYACTINF-AREA.
           03  WRK-SRYACTINF                   OCCURS  50.
               05  WK-RECE65-SRYCD           PIC  X(09).
               05  WK-RECE65-SRYSURYO        PIC  9(05)V9(03).
               05  WK-RECE65-SRYKAISU        PIC  9(03).
               05  WK-RECE65-TANICD          PIC  9(03).
               05  WK-RECE65-TANIMOJISU      PIC  9(01).
               05  WK-RECE65-TANINAME        PIC  X(24).
               05  WK-RECE65-TENSIKIBETU     PIC  9(01).
               05  WK-RECE65-TEN             PIC  9(09)V9(02).
               05  WK-RECE65-MEISKYFLG       PIC  X(01).
               05  WK-RECE65-AUTOKBN         PIC  X(01).
               05  WK-RECE65-INPUTNUM        PIC  9(03).
               05  WK-RECE65-TENTTLKBN       PIC  9(03).
      *
       01  WRK-NAMEINF-AREA.
           03  WRK-NAMEINF                     OCCURS 50.         
               05  WK-RECE65-YUKOKETA        PIC  9(02).
               05  WK-RECE65-NAME            PIC  X(200).
      *
       01  WRK-FREE-AREA.
           03  WRK-FREEINF                     OCCURS 49.         
               05  WK-FREE-YUKOKETA          PIC  9(02).
               05  WK-FREE-NAME              PIC  X(200).
      *
      *理学療法剤番号退避領域
       01  WRK-TAIHI-ZAINUM.
           03  WRK-RIGA1-SHU-ZAINUM          PIC  9(08).   
           03  WRK-RIGA1-KO-ZAINUM           PIC  9(08).   
           03  WRK-RIGA2-SHU-ZAINUM          PIC  9(08).   
           03  WRK-RIGA2-KO-ZAINUM           PIC  9(08).   
           03  WRK-RIGA3-SHU-ZAINUM          PIC  9(08).   
           03  WRK-RIGA3-KO-ZAINUM           PIC  9(08).   
           03  WRK-RIGA4-SHU-ZAINUM          PIC  9(08).   
           03  WRK-RIGA4-KO-ZAINUM           PIC  9(08).   
           03  WRK-SAGYO1-SHU-ZAINUM         PIC  9(08).   
           03  WRK-SAGYO1-KO-ZAINUM          PIC  9(08).   
           03  WRK-SAGYO2-SHU-ZAINUM         PIC  9(08).   
           03  WRK-SAGYO2-KO-ZAINUM          PIC  9(08).   
           03  WRK-GENGO1-SHU-ZAINUM         PIC  9(08).   
           03  WRK-GENGO1-KO-ZAINUM          PIC  9(08).   
           03  WRK-GENGO2-SHU-ZAINUM         PIC  9(08).   
           03  WRK-GENGO2-KO-ZAINUM          PIC  9(08).   
      *
      *人工腎臓実施カレンダー
       01  WRK-JINZOU-AREA.
           03  WRK-JINZOU                    PIC  X(01)  OCCURS 31.   
      *
      *再診４回目以降実施カレンダー
       01  WRK-SAISHIN4-AREA.
           03  WRK-SAISHIN4                  PIC  X(01)  OCCURS 31.   
      *
      *算定科実施カレンダー
       01  WRK-SANTEIKA-AREA.
           03  WRK-SANTEIKA                  PIC  X(01)  OCCURS 31.
      *
      *理学療法実施カレンダー
       01  WRK-RIGAKU-AREA.
           03  WRK-RIGA1-SHU                 PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA1-KO                  PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA2-SHU                 PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA2-KO                  PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA3-SHU                 PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA3-KO                  PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA4-SHU                 PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA4-KO                  PIC  X(01)  OCCURS 31.   
           03  WRK-SAGYO1-SHU                PIC  X(01)  OCCURS 31.   
           03  WRK-SAGYO1-KO                 PIC  X(01)  OCCURS 31.   
           03  WRK-SAGYO2-SHU                PIC  X(01)  OCCURS 31.   
           03  WRK-SAGYO2-KO                 PIC  X(01)  OCCURS 31.   
           03  WRK-GENGO1-SHU                PIC  X(01)  OCCURS 31.   
           03  WRK-GENGO1-KO                 PIC  X(01)  OCCURS 31.   
           03  WRK-GENGO2-SHU                PIC  X(01)  OCCURS 31.   
           03  WRK-GENGO2-KO                 PIC  X(01)  OCCURS 31.   
      *
      *
      *    日付全角変換領域
       01  TBL-DAY-AREA.
           03  FILLER              PIC X(04)  VALUE "　１".
           03  FILLER              PIC X(04)  VALUE "　２".
           03  FILLER              PIC X(04)  VALUE "　３".
           03  FILLER              PIC X(04)  VALUE "　４".
           03  FILLER              PIC X(04)  VALUE "　５".
           03  FILLER              PIC X(04)  VALUE "　６".
           03  FILLER              PIC X(04)  VALUE "　７".
           03  FILLER              PIC X(04)  VALUE "　８".
           03  FILLER              PIC X(04)  VALUE "　９".
           03  FILLER              PIC X(04)  VALUE "１０".
           03  FILLER              PIC X(04)  VALUE "１１".
           03  FILLER              PIC X(04)  VALUE "１２".
           03  FILLER              PIC X(04)  VALUE "１３".
           03  FILLER              PIC X(04)  VALUE "１４".
           03  FILLER              PIC X(04)  VALUE "１５".
           03  FILLER              PIC X(04)  VALUE "１６".
           03  FILLER              PIC X(04)  VALUE "１７".
           03  FILLER              PIC X(04)  VALUE "１８".
           03  FILLER              PIC X(04)  VALUE "１９".
           03  FILLER              PIC X(04)  VALUE "２０".
           03  FILLER              PIC X(04)  VALUE "２１".
           03  FILLER              PIC X(04)  VALUE "２２".
           03  FILLER              PIC X(04)  VALUE "２３".
           03  FILLER              PIC X(04)  VALUE "２４".
           03  FILLER              PIC X(04)  VALUE "２５".
           03  FILLER              PIC X(04)  VALUE "２６".
           03  FILLER              PIC X(04)  VALUE "２７".
           03  FILLER              PIC X(04)  VALUE "２８".
           03  FILLER              PIC X(04)  VALUE "２９".
           03  FILLER              PIC X(04)  VALUE "３０".
           03  FILLER              PIC X(04)  VALUE "３１".
       01  TBL-DAY-AREA-R          REDEFINES   TBL-DAY-AREA.
           03  TBL-DAY             PIC X(04)   OCCURS   31.
      *
       01  MAX-MEISAISU            PIC 9(07).
      *
      *    固定値
       01  CONST-AREA.
      *    手術日コメント
           03  CONS-SHUJUTU-COMMENT PIC X(09) VALUE "840000042".
      *    人工腎臓１
           03  CONS-JINZOU1         PIC X(09) VALUE "140036710".
      *    人工腎臓２
           03  CONS-JINZOU2         PIC X(09) VALUE "140007710".
      *    再診（４回目以降／人工腎臓）
           03  CONS-SAISHIN41       PIC X(09) VALUE "112009610".
           03  CONS-SAISHIN42       PIC X(09) VALUE "112009510".
           03  CONS-SAISHIN43       PIC X(09) VALUE "112012750".
           03  CONS-SAISHIN44       PIC X(09) VALUE "112706610".
      *    慢性とう痛疾患
           03  CONS-MANSEI          PIC X(09) VALUE "113006510".
      *    理学療法
           03  CONS-RIGA1-SHU1      PIC X(09) VALUE "180706910".
           03  CONS-RIGA1-SHU2      PIC X(09) VALUE "180022210".
           03  CONS-RIGA1-KO1       PIC X(09) VALUE "180706810".
           03  CONS-RIGA1-KO2       PIC X(09) VALUE "180022110".
           03  CONS-RIGA2-SHU1      PIC X(09) VALUE "180707110".
           03  CONS-RIGA2-SHU2      PIC X(09) VALUE "180022410".
           03  CONS-RIGA2-KO1       PIC X(09) VALUE "180707010".
           03  CONS-RIGA2-KO2       PIC X(09) VALUE "180022310".
           03  CONS-RIGA3-SHU1      PIC X(09) VALUE "180707310".
           03  CONS-RIGA3-SHU2      PIC X(09) VALUE "180022610".
           03  CONS-RIGA3-KO1       PIC X(09) VALUE "180707210".
           03  CONS-RIGA3-KO2       PIC X(09) VALUE "180022510".
           03  CONS-RIGA4-SHU1      PIC X(09) VALUE "180707510".
           03  CONS-RIGA4-SHU2      PIC X(09) VALUE "180022810".
           03  CONS-RIGA4-KO1       PIC X(09) VALUE "180707410".
           03  CONS-RIGA4-KO2       PIC X(09) VALUE "180022710".
           03  CONS-SAGYO1-SHU1     PIC X(09) VALUE "180708210".
           03  CONS-SAGYO1-SHU2     PIC X(09) VALUE "180023710".
           03  CONS-SAGYO1-KO1      PIC X(09) VALUE "180708110".
           03  CONS-SAGYO1-KO2      PIC X(09) VALUE "180023610".
           03  CONS-SAGYO2-SHU1     PIC X(09) VALUE "180708410".
           03  CONS-SAGYO2-SHU2     PIC X(09) VALUE "180023910".
           03  CONS-SAGYO2-KO1      PIC X(09) VALUE "180708310".
           03  CONS-SAGYO2-KO2      PIC X(09) VALUE "180023810".
           03  CONS-GENGO1-SHU      PIC X(09) VALUE "180024910".
           03  CONS-GENGO1-KO       PIC X(09) VALUE "180024810".
           03  CONS-GENGO2-SHU      PIC X(09) VALUE "180025110".
           03  CONS-GENGO2-KO       PIC X(09) VALUE "180025010".
      *    初診料算定科：
           03  CONS-SYOSINSANTEIKA  PIC X(09) VALUE "830000020".
      *    再診料算定科：
           03  CONS-SAISINSANTEIKA  PIC X(09) VALUE "830000021".
      *
      *
      *   電話再診対象診療行為テーブル
       01  TBL-DENWA-AREA.
      *    電話等再診（診療所）（１回目）
           03  FILLER          PIC X(09)   VALUE   "112009750".
      *    電話等再診（診療所）（２回目又は３回目）
           03  FILLER          PIC X(09)   VALUE   "112009850".
      *    電話等再診（診療所）（４回目以降）
           03  FILLER          PIC X(09)   VALUE   "112009950".
      *    電話等再診（診療所）（４回目以降）(１５歳未満）
           03  FILLER          PIC X(09)   VALUE   "112010050".
      *    電話等再診（診療所）（４回目以降）(厚生労働大臣が定める者）
           03  FILLER          PIC X(09)   VALUE   "112012750".
      *    老：電話等再診（診療所）（１回目）
           03  FILLER          PIC X(09)   VALUE   "112704150".
      *    老：電話等再診（診療所）（２回目又は３回目）
           03  FILLER          PIC X(09)   VALUE   "112704250".
      *    老：電話等再診（診療所）（４回目以降）
           03  FILLER          PIC X(09)   VALUE   "112704350".
      *    老：電話等再診（診療所）（４回目以降）(厚生労働大臣が定める者）
           03  FILLER          PIC X(09)   VALUE   "112706750".
      *    同日電話等再診（診療所）（１回目）
           03  FILLER          PIC X(09)   VALUE   "112010650".
      *    同日電話等再診（診療所）（２回目又は３回目）
           03  FILLER          PIC X(09)   VALUE   "112010750".
      *    同日電話等再診（診療所）（４回目以降）
           03  FILLER          PIC X(09)   VALUE   "112010850".
      *    同日電話等再診（診療所）（４回目以降）(１５歳未満）
           03  FILLER          PIC X(09)   VALUE   "112010950".
      *    同日電話等再診（診療所）（４回目以降）(厚生労働大臣が定める者）
           03  FILLER          PIC X(09)   VALUE   "112012850".
      *    老：同日電話等再診（診療所）（１回目）
           03  FILLER          PIC X(09)   VALUE   "112704850".
      *    老：同日電話等再診（診療所）（２回目又は３回目）
           03  FILLER          PIC X(09)   VALUE   "112704950".
      *    老：同日電話等再診（診療所）（４回目以降）
           03  FILLER          PIC X(09)   VALUE   "112705050".
      *    老：同日電話等再診（診療所）（４回目以降）(厚生労働大臣が定める者）
           03  FILLER          PIC X(09)   VALUE   "112706850".
      *
       01  TBL-DENWA-R         REDEFINES   TBL-DENWA-AREA.
            03  TBL-DENWA      PIC X(09)   OCCURS   18.       
      *
       01  TBL-DENWA-MAX       PIC 9(02)   VALUE    18.  
      *
      *
      *   同日再診対象診療行為テーブル
       01  TBL-DOUJITU-AREA.
      *    同日再診（診療所）（１回目）
           03  FILLER          PIC X(09)   VALUE   "112010150".
      *    同日再診（診療所）（２回目又は３回目）
           03  FILLER          PIC X(09)   VALUE   "112010250".
      *    同日再診（診療所）（４回目以降）
           03  FILLER          PIC X(09)   VALUE   "112010350".
      *    同日再診（診療所）（４回目以降）(１５歳未満）
           03  FILLER          PIC X(09)   VALUE   "112010450".
      *    同日再診（診療所）（４回目以降）(厚生労働大臣が定める者）
           03  FILLER          PIC X(09)   VALUE   "112010550".
      *    老：同日再診（診療所）（１回目）
           03  FILLER          PIC X(09)   VALUE   "112704450".
      *    老：同日再診（診療所）（２回目又は３回目）
           03  FILLER          PIC X(09)   VALUE   "112704550".
      *    老：同日再診（診療所）（４回目以降）
           03  FILLER          PIC X(09)   VALUE   "112704650".
      *    老：同日再診（診療所）（４回目以降）(厚生労働大臣が定める者）
           03  FILLER          PIC X(09)   VALUE   "112704750".
      *    同日電話等再診（診療所）（１回目）
           03  FILLER          PIC X(09)   VALUE   "112010650".
      *    同日電話等再診（診療所）（２回目又は３回目）
           03  FILLER          PIC X(09)   VALUE   "112010750".
      *    同日電話等再診（診療所）（４回目以降）
           03  FILLER          PIC X(09)   VALUE   "112010850".
      *    同日電話等再診（診療所）（４回目以降）(１５歳未満）
           03  FILLER          PIC X(09)   VALUE   "112010950".
      *    同日電話等再診（診療所）（４回目以降）(厚生労働大臣が定める者）
           03  FILLER          PIC X(09)   VALUE   "112012850".
      *    老：同日電話等再診（診療所）（１回目）
           03  FILLER          PIC X(09)   VALUE   "112704850".
      *    老：同日電話等再診（診療所）（２回目又は３回目）
           03  FILLER          PIC X(09)   VALUE   "112704950".
      *    老：同日電話等再診（診療所）（４回目以降）
           03  FILLER          PIC X(09)   VALUE   "112705050".
      *    老：同日電話等再診（診療所）（４回目以降）(厚生労働大臣が定める者）
           03  FILLER          PIC X(09)   VALUE   "112706850".
      *
       01  TBL-DOUJITU-R       REDEFINES   TBL-DOUJITU-AREA.
            03  TBL-DOUJITU    PIC X(09)   OCCURS   18.       
      *
       01  TBL-DOUJITU-MAX     PIC 9(02)   VALUE    18.  
      *
      *
      *    複数診療科受診の退避テーブル
       01  TBL-JUSHIN-INF.
           03  TBL-JUSHIN-INF2      OCCURS    10.
               05  TBL-JUSHIN-SRYKA       PIC X(02).
               05  TBL-JUSHIN-SRYKANAME   PIC X(80).
               05  TBL-JUSHIN-ARI         PIC X(01).
               05  TBL-JUSHIN-DAY         PIC X(01)   OCCURS  31.
      *
       01  TBL-COUNT-INF.
           03  TBL-COUNT-INF2       OCCURS     5.
               05  CNT-DENWA              PIC 9(06).
               05  CNT-DOUJITU            PIC 9(06).
      *
      *
      *    パス名領域
       01  WRK-PATH                        PIC X(64).
      *
           COPY    "MCPAREA".
      *
           COPY    "COMMON-SPA".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    診療科目情報
           COPY    "CPSK1005.INC".
      *
      *    点数
           COPY    "CPTENSU.INC".
      *
      *    診療会計
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    診療行為
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    算定履歴
       01  SANTEI-REC.
           COPY    "CPSANTEI.INC".
      *
      *    受診履歴
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *     
      *    数値変換サブ
           COPY    "CPORCSNUM.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      ****************************************************************
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(256).
      ****************************************************************
       PROCEDURE           DIVISION
               USING
           COMMAND-PARAM.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
                   UNTIL   SPA-STS  =   2
      *
           PERFORM 300-END-SEC
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  SPA2-AREA
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
      *
      *    ファイルＯＰＥＮ処理
      *
           PERFORM 110-FILE-OPEN-SEC
           PERFORM 120-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCR0660"      TO  JOB-PGID
           MOVE    "コメント編集"    TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 990-RECE62-READ-SEC
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイルＯＰＥＮ処理
      *****************************************************************
       110-FILE-OPEN-SEC          SECTION.
      *
           MOVE    COMMAND-PARAM       TO  WRK-PARA
      *
           MOVE    "RECE620"           TO  RECE62PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE62PARA-TERMID
      *
           MOVE    "RECE640"           TO  RECE64PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE64PARA-TERMID
      *
           MOVE    "RECE650"           TO  RECE65PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE65PARA-TERMID
      *
           MOVE    "RECE641"           TO  RECE641PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE641PARA-TERMID
      *
           MOVE    "RECE651"           TO  RECE651PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE651PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
           OPEN    INPUT               RECE62-FILE
      *
           OPEN    INPUT               RECE64-FILE
      *
           OPEN    INPUT               RECE65-FILE
      *
           OPEN    OUTPUT              RECE6441-FILE
           CLOSE                       RECE6441-FILE
      *
           OPEN    OUTPUT              RECE6551-FILE
           CLOSE                       RECE6551-FILE
      *
           OPEN    OUTPUT              RECE641-FILE
      *
           OPEN    OUTPUT              RECE651-FILE
      *
           .
       110-FILE-OPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    複数診療科受診
           MOVE       ZERO             TO  CNT-SANTEIKA
           INITIALIZE                      WRK-SANTEIKA-AREA
      *    算定科の取得
           INITIALIZE                      RECE64-REC
           MOVE    RECE62-HOSPID       TO  RECE64-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE64-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE64-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE64-PTID
           MOVE    RECE62-RECEKA       TO  RECE64-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE64-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE64-RECESYUBETU
           MOVE    RECE62-HKNJANUM     TO  RECE64-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE64-HOJOKBN
           MOVE    RECE62-TEKSTYMD     TO  RECE64-TEKSTYMD
           MOVE    ZERO                TO  RECE64-ZAINUM
      *
           START   RECE64-FILE
               KEY IS    >=   RECE64-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE64
               NOT INVALID
                   PERFORM 990-RECE64-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( FLG-RECE64           =   1                   )
               OR     ( RECE62-HOSPID    NOT =   RECE64-HOSPID       )
               OR     ( RECE62-SRYYM     NOT =   RECE64-SRYYM        )
               OR     ( RECE62-NYUGAIKBN NOT =   RECE64-NYUGAIKBN    )
               OR     ( RECE62-PTID      NOT =   RECE64-PTID         )
               OR     ( RECE62-RECEKA    NOT =   RECE64-RECEKA       )
               OR     ( RECE62-TEISYUTUSAKI
                                         NOT =   RECE64-TEISYUTUSAKI )
               OR     ( RECE62-RECESYUBETU
                                         NOT =   RECE64-RECESYUBETU  )
               OR     ( RECE62-HKNJANUM  NOT =   RECE64-HKNJANUM     )
               OR     ( RECE62-HOJOKBN-KEY
                                         NOT =   RECE64-HOJOKBN      )
               OR     ( RECE62-TEKSTYMD  NOT =   RECE64-TEKSTYMD     )
      *
               EVALUATE      RECE64-SRYKBN
                   WHEN      "11"
      *            （初診料算定科：のカウント）
                      PERFORM    2001-SYOSINSANTEIKA-COUNT-SEC
                   WHEN      "12"
      *            （再診料算定科：のカウント）
                      PERFORM    2001-SAISINSANTEIKA-COUNT-SEC
               END-EVALUATE
      *
               PERFORM 990-RECE64-NEXT-SEC
      *
           END-PERFORM
      *
           PERFORM    VARYING    IDX   FROM   1   BY   1
                                    UNTIL      IDX   >    31
                   IF    WRK-SANTEIKA(IDX)  =   "1"  
                       ADD     1           TO   CNT-SANTEIKA
                   END-IF
           END-PERFORM 
      *
           IF   CNT-SANTEIKA   >  ZERO
      *
             MOVE       ZERO             TO  CNT-JUSHIN
             INITIALIZE                      TBL-JUSHIN-INF
      *      診療科の取得
             INITIALIZE                      SYS-1005-REC
             MOVE    "1005"              TO  SYS-1005-KANRICD
             MOVE    ZERO                TO  SYS-1005-STYUKYMD
             MOVE    ALL "9"             TO  SYS-1005-EDYUKYMD
             MOVE    SYS-1005-REC        TO  MCPDATA-REC
             MOVE    "DBSELECT"          TO  MCP-FUNC
             MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
             MOVE    RECE62-SRYYM        TO  ORC-DBYMD(1:6)
             MOVE    "01"                TO  ORC-DBYMD(7:2)
             CALL    "ORCMCPSUB"         USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
             IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"  TO  ORC-DBPATH 
               PERFORM   SYSKANRI-READ-SEC
               PERFORM   VARYING   IDX    FROM   1   BY   1
                          UNTIL   (IDX             >      10)
                            OR    (FLG-SYSKANRI    =       1)
                   MOVE    SYS-1005-KBNCD  TO TBL-JUSHIN-SRYKA(IDX)
                   MOVE    SYS-1005-SRYKANAME   
                                           TO TBL-JUSHIN-SRYKANAME(IDX)
      *            受診履歴テーブルから診療科毎の受診日を検索セット
                   PERFORM   2001-JUSHIN-KENSAKU-SEC
      *
                   MOVE    "SYSKANRI-KEY2"  TO  ORC-DBPATH 
                   PERFORM   SYSKANRI-READ-SEC
               END-PERFORM
             END-IF
      *
      *      複数の診療科受診があるか判定
             MOVE       ZERO       TO   IDZ  
             INITIALIZE            WRK-FREE-AREA
      *
             PERFORM   VARYING   IDX    FROM   1   BY   1
                            UNTIL   (IDX             >      10)
               IF   TBL-JUSHIN-ARI (IDX)  =  "1"
                   ADD       1     TO   CNT-JUSHIN
                   PERFORM  2002-FREE-COMMENT-SEC
               END-IF
             END-PERFORM
      *      複数診療科受診のコメント編集
             IF    CNT-JUSHIN  >   1
                    PERFORM   2002-JUSHIN-COMMENT-SEC
             END-IF
      *
           END-IF
      *
      *    電話再診・同日複数再診
           INITIALIZE                      TBL-COUNT-INF
      *
           INITIALIZE                      RECE64-REC
           MOVE    RECE62-HOSPID       TO  RECE64-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE64-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE64-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE64-PTID
           MOVE    RECE62-RECEKA       TO  RECE64-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE64-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE64-RECESYUBETU
           MOVE    RECE62-HKNJANUM     TO  RECE64-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE64-HOJOKBN   
           MOVE    RECE62-TEKSTYMD     TO  RECE64-TEKSTYMD
           MOVE    ZERO                TO  RECE64-ZAINUM
      *
           START   RECE64-FILE
               KEY IS    >=   RECE64-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE64
               NOT INVALID
                   PERFORM 990-RECE64-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( FLG-RECE64           =   1                   )
               OR     ( RECE62-HOSPID    NOT =   RECE64-HOSPID       )
               OR     ( RECE62-SRYYM     NOT =   RECE64-SRYYM        )
               OR     ( RECE62-NYUGAIKBN NOT =   RECE64-NYUGAIKBN    )
               OR     ( RECE62-PTID      NOT =   RECE64-PTID         )
               OR     ( RECE62-RECEKA    NOT =   RECE64-RECEKA       )
               OR     ( RECE62-TEISYUTUSAKI
                                         NOT =   RECE64-TEISYUTUSAKI )
               OR     ( RECE62-RECESYUBETU
                                         NOT =   RECE64-RECESYUBETU  )
               OR     ( RECE62-HKNJANUM  NOT =   RECE64-HKNJANUM     )
               OR     ( RECE62-HOJOKBN-KEY
                                         NOT =   RECE64-HOJOKBN      )
               OR     ( RECE62-TEKSTYMD  NOT =   RECE64-TEKSTYMD     )
      *
               EVALUATE      RECE64-SRYKBN
                   WHEN      "12"
      *            （電話再診のカウント）
                      PERFORM    2001-DENWA-COUNT-SEC
      *            （同日再診のカウント）
                      PERFORM    2001-DOUJITU-COUNT-SEC
               END-EVALUATE
      *
               PERFORM 990-RECE64-NEXT-SEC
      *
           END-PERFORM
      *
           PERFORM   VARYING   IDX    FROM   1   BY   1
                          UNTIL   (IDX             >      5)
      *
              IF         CNT-DENWA(IDX)     >   ZERO
              AND        CNT-DOUJITU(IDX)   >   ZERO
                         PERFORM    2002-DENWA-DOUJITU-COMMENT-SEC
              ELSE
                  IF         CNT-DENWA(IDX)     >   ZERO
                  AND        CNT-DOUJITU(IDX)   =   ZERO
                         PERFORM    2002-DENWA-COMMENT-SEC
                  ELSE
                      IF         CNT-DENWA(IDX)     =   ZERO
                      AND        CNT-DOUJITU(IDX)   >   ZERO
                         PERFORM    2002-DOUJITU-COMMENT-SEC
                      END-IF
                  END-IF
              END-IF
      *
           END-PERFORM
      *
      *    人工腎臓の判定
           INITIALIZE                      RECE64-REC
           MOVE    RECE62-HOSPID       TO  RECE64-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE64-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE64-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE64-PTID
           MOVE    RECE62-RECEKA       TO  RECE64-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE64-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE64-RECESYUBETU
           MOVE    RECE62-HKNJANUM     TO  RECE64-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE64-HOJOKBN
           MOVE    RECE62-TEKSTYMD     TO  RECE64-TEKSTYMD
           MOVE    ZERO                TO  RECE64-ZAINUM
      *
           START   RECE64-FILE
               KEY IS    >=   RECE64-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE64
               NOT INVALID
                   PERFORM 990-RECE64-NEXT-SEC
           END-START
           MOVE    ZERO              TO      FLG-JINZOU-COMMENT
           INITIALIZE                        WRK-JINZOU-AREA
           INITIALIZE                        WRK-SAISHIN4-AREA
           INITIALIZE                        WRK-RIGAKU-AREA
           INITIALIZE                        WRK-TAIHI-ZAINUM
           PERFORM
               UNTIL  ( FLG-RECE64           =   1                   )
               OR     ( RECE62-HOSPID    NOT =   RECE64-HOSPID       )
               OR     ( RECE62-SRYYM     NOT =   RECE64-SRYYM        )
               OR     ( RECE62-NYUGAIKBN NOT =   RECE64-NYUGAIKBN    )
               OR     ( RECE62-PTID      NOT =   RECE64-PTID         )
               OR     ( RECE62-RECEKA    NOT =   RECE64-RECEKA       )
               OR     ( RECE62-TEISYUTUSAKI
                                         NOT =   RECE64-TEISYUTUSAKI )
               OR     ( RECE62-RECESYUBETU
                                         NOT =   RECE64-RECESYUBETU  )
               OR     ( RECE62-HKNJANUM  NOT =   RECE64-HKNJANUM     )
               OR     ( RECE62-HOJOKBN-KEY 
                                         NOT =   RECE64-HOJOKBN      )
               OR     ( RECE62-TEKSTYMD  NOT =   RECE64-TEKSTYMD     )
      *
               MOVE          SPACE       TO      RECE641-REC
               INITIALIZE    RECE641-REC
               EVALUATE      RECE64-SRYKBN
                   WHEN      "12"
      *            （再診４回目のカウント）
                      PERFORM    2001-SAISHIN4-COUNT-SEC
                   WHEN      "40"
      *            （人工腎臓のカウント）
                      PERFORM    2001-JINZOU-COUNT-SEC
                   WHEN      "80"
                      PERFORM    2001-RIHA-COUNT-SEC
               END-EVALUATE
      *
               PERFORM 990-RECE64-NEXT-SEC
      *
           END-PERFORM
      *
           PERFORM    2001-JINZOU-HANTEI-SEC
           IF         FLG-JINZOU-COMMENT    =     1
                      PERFORM    2002-JINZOU-COMMENT-SEC
           END-IF
      *
      *    パラメータ０４ファイルより編集
           INITIALIZE                      RECE64-REC
           MOVE    RECE62-HOSPID       TO  RECE64-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE64-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE64-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE64-PTID
           MOVE    RECE62-RECEKA       TO  RECE64-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE64-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE64-RECESYUBETU
           MOVE    RECE62-HKNJANUM     TO  RECE64-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE64-HOJOKBN
           MOVE    RECE62-TEKSTYMD     TO  RECE64-TEKSTYMD
           MOVE    ZERO                TO  RECE64-ZAINUM
      *
           START   RECE64-FILE
               KEY IS    >=   RECE64-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE64
               NOT INVALID
                   PERFORM 990-RECE64-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( FLG-RECE64           =   1                   )
               OR     ( RECE62-HOSPID    NOT =   RECE64-HOSPID       )
               OR     ( RECE62-SRYYM     NOT =   RECE64-SRYYM        )
               OR     ( RECE62-NYUGAIKBN NOT =   RECE64-NYUGAIKBN    )
               OR     ( RECE62-PTID      NOT =   RECE64-PTID         )
               OR     ( RECE62-RECEKA    NOT =   RECE64-RECEKA       )
               OR     ( RECE62-TEISYUTUSAKI
                                         NOT =   RECE64-TEISYUTUSAKI )
               OR     ( RECE62-RECESYUBETU
                                         NOT =   RECE64-RECESYUBETU  )
               OR     ( RECE62-HKNJANUM  NOT =   RECE64-HKNJANUM     )
               OR     ( RECE62-HOJOKBN-KEY
                                         NOT =   RECE64-HOJOKBN      )
               OR     ( RECE62-TEKSTYMD  NOT =   RECE64-TEKSTYMD     )
      *
               MOVE          SPACE       TO      RECE641-REC
               INITIALIZE    RECE641-REC
               EVALUATE      RECE64-SRYKBN
                   WHEN      "13"
                      PERFORM    2001-SHIDOU-HANTEI-SEC
                      IF      FLG-SHIDOU-COMMENT    =      1
                          PERFORM    2001-SHIDOU-COMMENT-SEC
                      ELSE
                          MOVE       RECE64-REC    TO   RECE641-REC
                          WRITE      RECE641-REC
                          ADD     1          TO      CNT-RECE64
                          PERFORM    2002-RECE65-TENSOU-SEC
                      END-IF         
                   WHEN      "50"
      *            （手術日のセット）
                      PERFORM    2001-SHUJUTSU-HANTEI-SEC
                      IF     (FLG-SHUJUTU-COMMENT   =      1)  AND
                             (RECE64-SYUTEN1    NOT =   ZERO)
                          PERFORM    2001-SHUJUTSU-COMMENT-SEC
                      ELSE
                          MOVE       RECE64-REC    TO   RECE641-REC
                          WRITE      RECE641-REC
                          ADD     1          TO      CNT-RECE64
                          PERFORM    2002-RECE65-TENSOU-SEC
                      END-IF
                   WHEN      "80"
      *            （リハビリのセット）
                      IF  RECE64-ZAINUM    =   WRK-RIGA1-SHU-ZAINUM OR
                                               WRK-RIGA1-KO-ZAINUM  OR
                                               WRK-RIGA2-SHU-ZAINUM OR
                                               WRK-RIGA2-KO-ZAINUM  OR
                                               WRK-RIGA3-SHU-ZAINUM OR
                                               WRK-RIGA3-KO-ZAINUM  OR
                                               WRK-RIGA4-SHU-ZAINUM OR
                                               WRK-RIGA4-KO-ZAINUM  OR
                                               WRK-SAGYO1-SHU-ZAINUM OR
                                               WRK-SAGYO1-KO-ZAINUM  OR
                                               WRK-SAGYO2-SHU-ZAINUM OR
                                               WRK-SAGYO2-KO-ZAINUM  OR
                                               WRK-GENGO1-SHU-ZAINUM OR
                                               WRK-GENGO1-KO-ZAINUM  OR
                                               WRK-GENGO2-SHU-ZAINUM OR
                                               WRK-GENGO2-KO-ZAINUM
                          PERFORM   2001-RIHA-COMMENT-SEC
                      ELSE
                          MOVE       RECE64-REC    TO   RECE641-REC
                          WRITE      RECE641-REC
                          ADD     1          TO      CNT-RECE64
                          PERFORM    2002-RECE65-TENSOU-SEC
                      END-IF
      *
                   WHEN   OTHER
                      MOVE       RECE64-REC    TO   RECE641-REC
                      WRITE      RECE641-REC
                      ADD     1          TO      CNT-RECE64
                      PERFORM    2002-RECE65-TENSOU-SEC
               END-EVALUATE
      *
               PERFORM 990-RECE64-NEXT-SEC
      *
           END-PERFORM
      *
      *
           PERFORM 990-RECE62-READ-SEC
      *
           IF  CNT-IN-COMMIT   =    300
                 MOVE  ZERO          TO      CNT-IN-COMMIT
                 PERFORM 900-DBCOMMIT-SEC
                 PERFORM 900-DBSTART-SEC
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    初診料算定科：のカウント
      *****************************************************************
       2001-SYOSINSANTEIKA-COUNT-SEC          SECTION.
      *
           INITIALIZE                          SRYACT-REC
           MOVE    RECE64-HOSPID       TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN    TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID         TO      SRY-PTID
           MOVE    RECE64-SRYYM        TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM       TO      SRY-ZAINUM
           MOVE    CONS-SYOSINSANTEIKA TO      SRY-SRYCD (1)
           MOVE    CONS-SYOSINSANTEIKA TO      SRY-SRYCD (2)
           MOVE    CONS-SYOSINSANTEIKA TO      SRY-SRYCD (3)
           MOVE    CONS-SYOSINSANTEIKA TO      SRY-SRYCD (4)
           MOVE    CONS-SYOSINSANTEIKA TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    RECE64-REC        TO      WRK-RECE64-REC
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                            MOVE  MCPDATA-REC    TO   SRYACCT-REC
                            PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                   MOVE  "1" TO  WRK-SANTEIKA(IDX)
                                END-IF
                            END-PERFORM
                       END-IF
                   END-IF
               END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           .
       2001-SYOSINSANTEIKA-COUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    再診料算定科：のカウント
      *****************************************************************
       2001-SAISINSANTEIKA-COUNT-SEC          SECTION.
      *
           INITIALIZE                          SRYACT-REC
           MOVE    RECE64-HOSPID       TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN    TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID         TO      SRY-PTID
           MOVE    RECE64-SRYYM        TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM       TO      SRY-ZAINUM
           MOVE    CONS-SAISINSANTEIKA TO      SRY-SRYCD (1)
           MOVE    CONS-SAISINSANTEIKA TO      SRY-SRYCD (2)
           MOVE    CONS-SAISINSANTEIKA TO      SRY-SRYCD (3)
           MOVE    CONS-SAISINSANTEIKA TO      SRY-SRYCD (4)
           MOVE    CONS-SAISINSANTEIKA TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    RECE64-REC        TO      WRK-RECE64-REC
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                            MOVE  MCPDATA-REC    TO   SRYACCT-REC
                            PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                   MOVE  "1" TO  WRK-SANTEIKA(IDX)
                                END-IF
                            END-PERFORM
                       END-IF
                   END-IF
               END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           .
       2001-SAISINSANTEIKA-COUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴テーブルから診療科毎の受診日を検索セット
      *****************************************************************
       2001-JUSHIN-KENSAKU-SEC             SECTION.
      *
      *    受診歴の検索
           INITIALIZE                      JYURRK-REC
           MOVE    RECE62-HOSPID       TO  JYURRK-HOSPID
           MOVE    RECE62-PTID         TO  JYURRK-PTID
           MOVE    RECE62-NYUGAIKBN    TO  JYURRK-NYUGAIKBN
           MOVE    TBL-JUSHIN-SRYKA(IDX)
                                       TO  JYURRK-SRYKA
           MOVE    RECE62-SRYYM        TO  JYURRK-SRYYMD(1:6)
           MOVE    "01"                TO  JYURRK-SRYYMD(7:2)
           MOVE    RECE62-SRYYM        TO  JYURRK-UPSRYYMD(1:6)
           MOVE    "31"                TO  JYURRK-UPSRYYMD(7:2)
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "JYURRK-KEY12"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING   MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "JYURRK-KEY12"  TO  ORC-DBPATH 
               PERFORM   JYURRK-READ-SEC
               PERFORM   UNTIL   FLG-JYURRK   =    1
                   IF    JYURRK-HKNKBN    =       "0"
                      MOVE   JYURRK-HKNCOMBINUM
                                       TO  WRK-HKNCOMBINUMX
                      IF  WRK-HKNCOMBINUM9  =  RECE62-HKNCOMBI(1) OR
                                               RECE62-HKNCOMBI(2) OR
                                               RECE62-HKNCOMBI(3) OR
                                               RECE62-HKNCOMBI(4) OR
                                               RECE62-HKNCOMBI(5) OR
                                               RECE62-HKNCOMBI(6) OR
                                               RECE62-HKNCOMBI(7) OR
                                               RECE62-HKNCOMBI(8) OR
                                               RECE62-HKNCOMBI(9) OR
                                               RECE62-HKNCOMBI(10)
                            MOVE   JYURRK-SRYYMD   TO   WRK-SRYYMDX
                            MOVE   "1"     TO    
                                        TBL-JUSHIN-ARI (IDX)
                            MOVE   "1"     TO    
                                        TBL-JUSHIN-DAY (IDX WRK-SRYDD)
                      END-IF      
                   END-IF
      *
                   MOVE    "JYURRK-KEY12"  TO  ORC-DBPATH 
                   PERFORM   JYURRK-READ-SEC
               END-PERFORM
           END-IF
      *
           .
       2001-JUSHIN-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    複数診療科受診の科・日付の編集
      *****************************************************************
       2002-FREE-COMMENT-SEC          SECTION.
      *
           ADD      1                      TO  IDZ
           MOVE     ZERO                   TO  WRK-KETA
                                               WRK-KETA-TAIHI
                                               WRK-KETA2
      *
           INITIALIZE                      ORCSKANACHKAREA
           MOVE    "2"                     TO  KANACHK-SYORI 
           MOVE  TBL-JUSHIN-SRYKANAME(IDX) TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      KANACHK-RC      =   ZERO
               COMPUTE WRK-KETA          =   KANACHK-MAX
               COMPUTE WRK-KETA-TAIHI    =   KANACHK-MAX
               COMPUTE WRK-KETA2         =   KANACHK-MAX  /  2
               MOVE    WRK-KETA2   TO  WK-FREE-YUKOKETA(IDZ)
               MOVE    KANACHK-OUT-INPUT(1:KANACHK-MAX)
                                   TO  WK-FREE-NAME(IDZ)(1:KANACHK-MAX)
           END-IF    
      *
           MOVE      ZERO          TO  FLG-FIRST
      *
           PERFORM   VARYING   IDY    FROM   1   BY   1
                          UNTIL   (IDY             >      31)
      *
             IF  TBL-JUSHIN-DAY(IDX IDY) =  "1"
                 IF  FLG-FIRST  =  ZERO
                    IF  IDY     <  10 
                       ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                       MOVE    "　"
                           TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
      *
                       ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                       MOVE    TBL-DAY(IDY)(3:2)     
                           TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
      *
                       ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                       MOVE    "日"
                           TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
                    ELSE
                       ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                       MOVE    "　"
                           TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
      *
                       ADD   2  TO  WK-FREE-YUKOKETA(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                       MOVE    TBL-DAY(IDY)     
                           TO  WK-FREE-NAME(IDZ)(WRK-KETA:4)
      *
                       ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                       MOVE    "日"
                           TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
                    END-IF
                    MOVE      1              TO  FLG-FIRST
                 ELSE
                    IF  IDY     <  10 
                       IF    WK-FREE-YUKOKETA(IDZ)  =  25
                          PERFORM  2002-FREE-COMMENT-KAIGYO-SEC
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    "、"
                                    TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
                       ELSE
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "、"
                                    TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
      *
                       END-IF
      *
                       IF    WK-FREE-YUKOKETA(IDZ)  =  24 OR 25
                          PERFORM  2002-FREE-COMMENT-KAIGYO-SEC
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    TBL-DAY(IDY)(3:2)     
                                    TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "日"
                                   TO  WK-FREE-NAME(IDZ)(WRK-KETA:2) 
                       ELSE
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    TBL-DAY(IDY)(3:2)     
                                    TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "日"
                                   TO  WK-FREE-NAME(IDZ)(WRK-KETA:2) 
                       END-IF
                    ELSE
                       IF    WK-FREE-YUKOKETA(IDZ)  =  25
                          PERFORM  2002-FREE-COMMENT-KAIGYO-SEC
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    "、"
                                   TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
                       ELSE
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "、"
                                   TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
                       END-IF
      *
                       IF    WK-FREE-YUKOKETA(IDZ)  =  23 OR 24 OR 25
                          PERFORM  2002-FREE-COMMENT-KAIGYO-SEC
                          ADD   2  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    TBL-DAY(IDY)     
                                   TO  WK-FREE-NAME(IDZ)(WRK-KETA:4)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                          MOVE    "日"
                                   TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
                       ELSE
                          ADD   2  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    TBL-DAY(IDY)     
                                   TO  WK-FREE-NAME(IDZ)(WRK-KETA:4)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                          MOVE    "日"
                                   TO  WK-FREE-NAME(IDZ)(WRK-KETA:2)
                       END-IF
                    END-IF
                 END-IF
             END-IF
      *
           END-PERFORM
           .
       2002-FREE-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    複数診療科受診の科・日付の編集（改行）
      *****************************************************************
       2002-FREE-COMMENT-KAIGYO-SEC          SECTION.
      *
           ADD      1              TO  IDZ
      *
           MOVE    WRK-KETA-TAIHI  TO  WRK-KETA
           MOVE    WRK-KETA2       TO  WK-FREE-YUKOKETA(IDZ)
           MOVE    ALL "　"        TO  WK-FREE-NAME(IDZ)(1:WRK-KETA)
      *
           .
       2002-FREE-COMMENT-KAIGYO-EXT.
           EXIT.
      *
      *****************************************************************
      *    複数診療科受診のコメント編集
      *****************************************************************
       2002-JUSHIN-COMMENT-SEC          SECTION.
      *
      *    ＲＥＣＥ０５ファイルの内容をテーブルに退避
           MOVE    ZERO                TO  IDX-RECE65
           MOVE    SPACE               TO  WRK-SRYACTINF-AREA
           INITIALIZE                      WRK-SRYACTINF-AREA
           MOVE    SPACE               TO  WRK-NAMEINF-AREA
           INITIALIZE                      WRK-NAMEINF-AREA
      *
           ADD     1                   TO  IDX-RECE65
           MOVE    SPACE               TO  COM-RECE65-REC
           INITIALIZE                      COM-RECE65-REC
           MOVE    "099999901"         TO  COM-SRYCD(1)
           MOVE    ZERO                TO  COM-SRYSURYO(1)
           MOVE    7                   TO  COM-YUKOKETA(1)
           MOVE    "複数診療科受診"    TO  COM-NAME(1)
           MOVE    COM-SRYACTINF(1)    TO  WRK-SRYACTINF
                                               (IDX-RECE65)
           MOVE    COM-NAMEINF(1)      TO  WRK-NAMEINF
                                               (IDX-RECE65)
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX               >   49    )
                         OR      ( WK-FREE-NAME(IDX) =   SPACE )
                ADD    1                  TO  IDX-RECE65
                MOVE   "810000002"        TO  COM-SRYCD(2)
                MOVE   ZERO               TO  COM-SRYSURYO(2)
                MOVE   COM-SRYACTINF(2)   TO  WRK-SRYACTINF(IDX-RECE65)
                MOVE   WRK-FREEINF(IDX)   TO  WRK-NAMEINF(IDX-RECE65)
           END-PERFORM 
      *
      *    科・日付の編集を含んだ内容で中間ファイルの再作成
           MOVE       ZERO             TO      FLG-WRKRECE65
           MOVE       ZERO             TO      IDX
           MOVE       ZERO             TO      IDX-RECE65
           MOVE       ZERO             TO      WRK-RENNUM
           MOVE       ZERO             TO      WRK-CNT-MEISAI
           PERFORM    UNTIL     FLG-WRKRECE65  =    1
                INITIALIZE                       RECE651-REC
                MOVE    RECE62-HOSPID        TO  RECE651-HOSPID
                MOVE    RECE62-SRYYM         TO  RECE651-SRYYM
                MOVE    RECE62-NYUGAIKBN     TO  RECE651-NYUGAIKBN
                MOVE    RECE62-PTID          TO  RECE651-PTID
                MOVE    RECE62-RECEKA        TO  RECE651-RECEKA
                MOVE    RECE62-TEISYUTUSAKI  TO  RECE651-TEISYUTUSAKI
                MOVE    RECE62-RECESYUBETU   TO  RECE651-RECESYUBETU
                MOVE    RECE62-HKNJANUM      TO  RECE651-HKNJANUM
                MOVE    RECE62-HOJOKBN-KEY   TO  RECE651-HOJOKBN
                MOVE    RECE62-TEKSTYMD      TO  RECE651-TEKSTYMD
                MOVE    ZERO                 TO  RECE651-ZAINUM
                MOVE    "99"                 TO  RECE651-SRYKBN
                ADD     1                    TO  WRK-RENNUM
                MOVE    WRK-RENNUM           TO  RECE651-RENNUM
                PERFORM  VARYING   IDX   FROM   1   BY   1
                         UNTIL   (IDX       >    5)   OR
                                 (FLG-WRKRECE65   =   1)
                   ADD         1             TO    IDX-RECE65
                   IF  WK-RECE65-SRYCD(IDX-RECE65) = SPACE
                       MOVE    1             TO    FLG-WRKRECE65
                   ELSE
                       MOVE  WRK-SRYACTINF(IDX-RECE65)
                                        TO   RECE651-SRYACTINF(IDX)  
                       MOVE  WRK-NAMEINF(IDX-RECE65)
                                        TO   RECE651-NAMEINF(IDX)
                       ADD   1          TO   WRK-CNT-MEISAI
                   END-IF  
                END-PERFORM
                WRITE   RECE651-REC
                ADD     1                    TO  CNT-RECE65
           END-PERFORM     
      *
      *
           INITIALIZE                      RECE641-REC
           MOVE    RECE62-HOSPID       TO  RECE641-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE641-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE641-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE641-PTID
           MOVE    RECE62-RECEKA       TO  RECE641-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE641-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE641-RECESYUBETU
           MOVE    RECE62-HKNJANUM     TO  RECE641-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE641-HOJOKBN 
           MOVE    RECE62-TEKSTYMD     TO  RECE641-TEKSTYMD
           MOVE    ZERO                TO  RECE641-ZAINUM
      *    MOVE    WRK-RECE64-KOHBUNRI TO  RECE641-KOHBUNRI
           MOVE    "99"                TO  RECE641-SRYKBN
      *
           MOVE    WRK-CNT-MEISAI      TO  RECE641-MEISAISU
      *
           WRITE   RECE641-REC
           ADD     1                   TO  CNT-RECE64
      *
           .
       2002-JUSHIN-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    電話再診のカウント
      *****************************************************************
       2001-DENWA-COUNT-SEC          SECTION.
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                     UNTIL   ( IDX           >   TBL-DENWA-MAX )
      *
              INITIALIZE                        SRYACT-REC
              MOVE    RECE64-HOSPID     TO      SRY-HOSPID
              MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
              MOVE    RECE64-PTID       TO      SRY-PTID
              MOVE    RECE64-SRYYM      TO      SRY-SRYYM
              MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
              MOVE    TBL-DENWA(IDX)    TO      SRY-SRYCD (1)
              MOVE    TBL-DENWA(IDX)    TO      SRY-SRYCD (2)
              MOVE    TBL-DENWA(IDX)    TO      SRY-SRYCD (3)
              MOVE    TBL-DENWA(IDX)    TO      SRY-SRYCD (4)
              MOVE    TBL-DENWA(IDX)    TO      SRY-SRYCD (5)
      *
              MOVE    SRYACT-REC        TO      MCPDATA-REC
              MOVE    "DBSELECT"        TO      MCP-FUNC
              MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
              CALL    "ORCMCPSUB"       USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
              IF  MCP-RC                =       ZERO
                  MOVE    "DBFETCH"     TO      MCP-FUNC
                  MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
                  CALL    "ORCMCPSUB"           USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                  IF      MCP-RC        =       ZERO
                      MOVE    RECE64-REC        TO      WRK-RECE64-REC
                      MOVE    MCPDATA-REC       TO      SRYACT-REC
                      INITIALIZE                        SRYACCT-REC
                      MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                      MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                      MOVE    SRY-PTID          TO      ACCT-PTID
                      MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                      MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                      MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                      MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                      MOVE    SRYACCT-REC       TO      MCPDATA-REC
                      MOVE    "DBSELECT"        TO      MCP-FUNC
                      MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                      CALL    "ORCMCPSUB"       USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                      IF      MCP-RC    =       ZERO
                          MOVE    "DBFETCH"     TO      MCP-FUNC
                          MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                          CALL    "ORCMCPSUB"           USING
                                                        MCPAREA
                                                        ORCMCPAREA
                                                        MCPDATA-REC
                          IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC    TO   SRYACCT-REC
                               COMPUTE  WRK-KOHBUNRI 
                                          =    RECE64-KOHBUNRI  +  1
                               ADD   ACCT-ZAIKAISU  
                                          TO   CNT-DENWA(WRK-KOHBUNRI)
                          END-IF
                      END-IF
                  END-IF
              END-IF
      *
              INITIALIZE                        MCPAREA
              MOVE    "DBCLOSE"         TO      MCP-FUNC
              MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
              CALL    "ORCMCPSUB"       USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
              INITIALIZE                        MCPAREA
              MOVE    "DBCLOSE"         TO      MCP-FUNC
              MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
              CALL    "ORCMCPSUB"       USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           END-PERFORM
           .
       2001-DENWA-COUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    同日再診のカウント
      *****************************************************************
       2001-DOUJITU-COUNT-SEC          SECTION.
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                     UNTIL   ( IDX           >   TBL-DOUJITU-MAX )
      *
              INITIALIZE                        SRYACT-REC
              MOVE    RECE64-HOSPID     TO      SRY-HOSPID
              MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
              MOVE    RECE64-PTID       TO      SRY-PTID
              MOVE    RECE64-SRYYM      TO      SRY-SRYYM
              MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
              MOVE    TBL-DOUJITU(IDX)  TO      SRY-SRYCD (1)
              MOVE    TBL-DOUJITU(IDX)  TO      SRY-SRYCD (2)
              MOVE    TBL-DOUJITU(IDX)  TO      SRY-SRYCD (3)
              MOVE    TBL-DOUJITU(IDX)  TO      SRY-SRYCD (4)
              MOVE    TBL-DOUJITU(IDX)  TO      SRY-SRYCD (5)
      *
              MOVE    SRYACT-REC        TO      MCPDATA-REC
              MOVE    "DBSELECT"        TO      MCP-FUNC
              MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
              CALL    "ORCMCPSUB"       USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
              IF  MCP-RC                =       ZERO
                  MOVE    "DBFETCH"     TO      MCP-FUNC
                  MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
                  CALL    "ORCMCPSUB"           USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                  IF      MCP-RC        =       ZERO
                      MOVE    RECE64-REC        TO      WRK-RECE64-REC
                      MOVE    MCPDATA-REC       TO      SRYACT-REC
                      INITIALIZE                        SRYACCT-REC
                      MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                      MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                      MOVE    SRY-PTID          TO      ACCT-PTID
                      MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                      MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                      MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                      MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                      MOVE    SRYACCT-REC       TO      MCPDATA-REC
                      MOVE    "DBSELECT"        TO      MCP-FUNC
                      MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                      CALL    "ORCMCPSUB"       USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                      IF      MCP-RC    =       ZERO
                          MOVE    "DBFETCH"     TO      MCP-FUNC
                          MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                          CALL    "ORCMCPSUB"           USING
                                                        MCPAREA
                                                        ORCMCPAREA
                                                        MCPDATA-REC
                          IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC    TO   SRYACCT-REC
                               COMPUTE  WRK-KOHBUNRI 
                                          =    RECE64-KOHBUNRI  +  1
                               ADD   ACCT-ZAIKAISU  
                                          TO   CNT-DOUJITU(WRK-KOHBUNRI)
                          END-IF
                      END-IF
                  END-IF
              END-IF
      *
              INITIALIZE                        MCPAREA
              MOVE    "DBCLOSE"         TO      MCP-FUNC
              MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
              CALL    "ORCMCPSUB"       USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
              INITIALIZE                        MCPAREA
              MOVE    "DBCLOSE"         TO      MCP-FUNC
              MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
              CALL    "ORCMCPSUB"       USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           END-PERFORM
           .
       2001-DOUJITU-COUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    電話再診・同日複数再診のコメント編集
      *****************************************************************
       2002-DENWA-DOUJITU-COMMENT-SEC          SECTION.
      *
           INITIALIZE                      RECE641-REC
           MOVE    RECE62-HOSPID       TO  RECE641-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE641-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE641-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE641-PTID
           MOVE    RECE62-RECEKA       TO  RECE641-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE641-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE641-RECESYUBETU
           MOVE    RECE62-HKNJANUM     TO  RECE641-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE641-HOJOKBN
           MOVE    RECE62-TEKSTYMD     TO  RECE641-TEKSTYMD
           COMPUTE WRK-ZAINUM    =  99990  +  IDX
           MOVE    WRK-ZAINUM          TO  RECE641-ZAINUM
      *    MOVE    99999               TO  RECE641-ZAINUM
           COMPUTE WRK-KOHBUNRI  =  IDX  -  1
           MOVE    WRK-KOHBUNRI        TO  RECE641-KOHBUNRI
      *    MOVE    WRK-RECE64-KOHBUNRI TO  RECE641-KOHBUNRI
           MOVE    "99"                TO  RECE641-SRYKBN
      *
           MOVE    2                   TO  RECE641-MEISAISU
      *
           WRITE   RECE641-REC
           ADD     1                   TO  CNT-RECE64
      *
           INITIALIZE                      RECE651-REC
           MOVE    RECE62-HOSPID       TO  RECE651-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE651-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE651-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE651-PTID
           MOVE    RECE62-RECEKA       TO  RECE651-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE651-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE651-RECESYUBETU
           MOVE    RECE62-HKNJANUM     TO  RECE651-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE651-HOJOKBN
           MOVE    RECE62-TEKSTYMD     TO  RECE651-TEKSTYMD
           COMPUTE WRK-ZAINUM    =  99990  +  IDX
           MOVE    WRK-ZAINUM          TO  RECE651-ZAINUM
      *    MOVE    99999               TO  RECE651-ZAINUM
           MOVE    "99"                TO  RECE651-SRYKBN
      *    電話再診のコメントの挿入
           MOVE    SPACE                TO  COM-RECE65-REC
           INITIALIZE                       COM-RECE65-REC
           MOVE    "840000001"          TO  COM-SRYCD(1)
           MOVE    ZERO                 TO  COM-SRYSURYO(1)
           MOVE    9                    TO  COM-YUKOKETA(1)
           MOVE    "電話再診（　　回）" TO  COM-NAME(1)
           MOVE    CNT-DENWA(IDX)       TO  DAY-IDX
           MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(11:4)
           MOVE    COM-SRYACTINF(1)     TO  RECE651-SRYACTINF(1)
           MOVE    COM-NAMEINF(1)       TO  RECE651-NAMEINF(1)
      *    同日複数再診のコメントの挿入
           MOVE    "840000002"          TO  COM-SRYCD(2)
           MOVE    ZERO                 TO  COM-SRYSURYO(2)
           MOVE    11                   TO  COM-YUKOKETA(2)
           MOVE    "同日複数再診（　　回）"  TO COM-NAME(2)
           MOVE    CNT-DOUJITU(IDX)     TO  DAY-IDX
           MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(2)(15:4)
           MOVE    COM-SRYACTINF(2)     TO  RECE651-SRYACTINF(2)
           MOVE    COM-NAMEINF(2)       TO  RECE651-NAMEINF(2)
      *
           WRITE   RECE651-REC
           ADD     1                    TO  CNT-RECE65
      *
           .
       2002-DENWA-DOUJITU-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    電話再診のコメント編集
      *****************************************************************
       2002-DENWA-COMMENT-SEC          SECTION.
      *
           INITIALIZE                      RECE641-REC
           MOVE    RECE62-HOSPID       TO  RECE641-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE641-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE641-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE641-PTID
           MOVE    RECE62-RECEKA       TO  RECE641-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE641-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE641-RECESYUBETU
           MOVE    RECE62-HKNJANUM     TO  RECE641-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE641-HOJOKBN
           MOVE    RECE62-TEKSTYMD     TO  RECE641-TEKSTYMD
           COMPUTE WRK-ZAINUM    =  99990  +  IDX
           MOVE    WRK-ZAINUM          TO  RECE641-ZAINUM
      *    MOVE    99999               TO  RECE641-ZAINUM
           COMPUTE WRK-KOHBUNRI  =  IDX  -  1
           MOVE    WRK-KOHBUNRI        TO  RECE641-KOHBUNRI
      *    MOVE    WRK-RECE64-KOHBUNRI TO  RECE641-KOHBUNRI
           MOVE    "99"                TO  RECE641-SRYKBN
      *
           MOVE    1                   TO  RECE641-MEISAISU
      *
           WRITE   RECE641-REC
           ADD     1                   TO  CNT-RECE64
      *
           INITIALIZE                      RECE651-REC
           MOVE    RECE62-HOSPID       TO  RECE651-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE651-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE651-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE651-PTID
           MOVE    RECE62-RECEKA       TO  RECE651-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE651-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE651-RECESYUBETU
           MOVE    RECE62-HKNJANUM     TO  RECE651-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE651-HOJOKBN
           MOVE    RECE62-TEKSTYMD     TO  RECE651-TEKSTYMD
           COMPUTE WRK-ZAINUM    =  99990  +  IDX
           MOVE    WRK-ZAINUM          TO  RECE651-ZAINUM
      *    MOVE    99999               TO  RECE651-ZAINUM
           MOVE    "99"                TO  RECE651-SRYKBN
      *    電話再診のコメントの挿入
           MOVE    SPACE                TO  COM-RECE65-REC
           INITIALIZE                       COM-RECE65-REC
           MOVE    "840000001"          TO  COM-SRYCD(1)
           MOVE    ZERO                 TO  COM-SRYSURYO(1)
           MOVE    9                    TO  COM-YUKOKETA(1)
           MOVE    "電話再診（　　回）" TO  COM-NAME(1)
           MOVE    CNT-DENWA(IDX)       TO  DAY-IDX
           MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(11:4)
           MOVE    COM-SRYACTINF(1)     TO  RECE651-SRYACTINF(1)
           MOVE    COM-NAMEINF(1)       TO  RECE651-NAMEINF(1)
           WRITE   RECE651-REC
           ADD     1                    TO  CNT-RECE65
      *
           .
       2002-DENWA-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    同日複数再診のコメント編集
      *****************************************************************
       2002-DOUJITU-COMMENT-SEC          SECTION.
      *
           INITIALIZE                      RECE641-REC
           MOVE    RECE62-HOSPID       TO  RECE641-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE641-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE641-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE641-PTID
           MOVE    RECE62-RECEKA       TO  RECE641-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE641-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE641-RECESYUBETU
           MOVE    RECE62-HKNJANUM     TO  RECE641-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE641-HOJOKBN
           MOVE    RECE62-TEKSTYMD     TO  RECE641-TEKSTYMD
           COMPUTE WRK-ZAINUM    =  99990  +  IDX
           MOVE    WRK-ZAINUM          TO  RECE641-ZAINUM
      *    MOVE    99999               TO  RECE641-ZAINUM
           COMPUTE WRK-KOHBUNRI  =  IDX  -  1
           MOVE    WRK-KOHBUNRI        TO  RECE641-KOHBUNRI
      *    MOVE    WRK-RECE64-KOHBUNRI TO  RECE641-KOHBUNRI
           MOVE    "99"                TO  RECE641-SRYKBN
      *
           MOVE    1                   TO  RECE641-MEISAISU
      *
           WRITE   RECE641-REC
           ADD     1                   TO  CNT-RECE64
      *
           INITIALIZE                      RECE651-REC
           MOVE    RECE62-HOSPID       TO  RECE651-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE651-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE651-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE651-PTID
           MOVE    RECE62-RECEKA       TO  RECE651-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE651-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE651-RECESYUBETU
           MOVE    RECE62-HKNJANUM     TO  RECE651-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE651-HOJOKBN
           MOVE    RECE62-TEKSTYMD     TO  RECE651-TEKSTYMD
           COMPUTE WRK-ZAINUM    =  99990  +  IDX
           MOVE    WRK-ZAINUM          TO  RECE651-ZAINUM
      *    MOVE    99999               TO  RECE651-ZAINUM
           MOVE    "99"                TO  RECE651-SRYKBN
      *    同日複数再診のコメントの挿入
           MOVE    SPACE                TO  COM-RECE65-REC
           INITIALIZE                       COM-RECE65-REC
           MOVE    "840000002"          TO  COM-SRYCD(1)
           MOVE    ZERO                 TO  COM-SRYSURYO(1)
           MOVE    11                   TO  COM-YUKOKETA(1)
           MOVE    "同日複数再診（　　回）"  TO COM-NAME(1)
           MOVE    CNT-DOUJITU(IDX)     TO  DAY-IDX
           MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(15:4)
           MOVE    COM-SRYACTINF(1)     TO  RECE651-SRYACTINF(1)
           MOVE    COM-NAMEINF(1)       TO  RECE651-NAMEINF(1)
           WRITE   RECE651-REC
           ADD     1                    TO  CNT-RECE65
      *
           .
       2002-DOUJITU-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    再診４回目以降のカウント
      *****************************************************************
       2001-SAISHIN4-COUNT-SEC          SECTION.
      *
      *再診（４回目以降／人工腎臓）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAISHIN41    TO      SRY-SRYCD (1)
           MOVE    CONS-SAISHIN41    TO      SRY-SRYCD (2)
           MOVE    CONS-SAISHIN41    TO      SRY-SRYCD (3)
           MOVE    CONS-SAISHIN41    TO      SRY-SRYCD (4)
           MOVE    CONS-SAISHIN41    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-SAISHIN4(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *再診（４回目以降／１５才未満）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAISHIN42    TO      SRY-SRYCD (1)
           MOVE    CONS-SAISHIN42    TO      SRY-SRYCD (2)
           MOVE    CONS-SAISHIN42    TO      SRY-SRYCD (3)
           MOVE    CONS-SAISHIN42    TO      SRY-SRYCD (4)
           MOVE    CONS-SAISHIN42    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-SAISHIN4(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *再診（４回目以降／厚生大臣）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAISHIN43    TO      SRY-SRYCD (1)
           MOVE    CONS-SAISHIN43    TO      SRY-SRYCD (2)
           MOVE    CONS-SAISHIN43    TO      SRY-SRYCD (3)
           MOVE    CONS-SAISHIN43    TO      SRY-SRYCD (4)
           MOVE    CONS-SAISHIN43    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-SAISHIN4(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *再診（４回目以降／厚生大臣／老人）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAISHIN44    TO      SRY-SRYCD (1)
           MOVE    CONS-SAISHIN44    TO      SRY-SRYCD (2)
           MOVE    CONS-SAISHIN44    TO      SRY-SRYCD (3)
           MOVE    CONS-SAISHIN44    TO      SRY-SRYCD (4)
           MOVE    CONS-SAISHIN44    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-SAISHIN4(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           .
       2001-SAISHIN4-COUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    人工腎臓のカウント
      *****************************************************************
       2001-JINZOU-COUNT-SEC          SECTION.
      *
      *人工腎臓１について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-JINZOU1      TO      SRY-SRYCD (1)
           MOVE    CONS-JINZOU1      TO      SRY-SRYCD (2)
           MOVE    CONS-JINZOU1      TO      SRY-SRYCD (3)
           MOVE    CONS-JINZOU1      TO      SRY-SRYCD (4)
           MOVE    CONS-JINZOU1      TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    RECE64-REC        TO      WRK-RECE64-REC
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE   MCPDATA-REC    TO  SRYACCT-REC
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1"  TO  WRK-JINZOU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *人工腎臓２について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-JINZOU2      TO      SRY-SRYCD (1)
           MOVE    CONS-JINZOU2      TO      SRY-SRYCD (2)
           MOVE    CONS-JINZOU2      TO      SRY-SRYCD (3)
           MOVE    CONS-JINZOU2      TO      SRY-SRYCD (4)
           MOVE    CONS-JINZOU2      TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    RECE64-REC        TO      WRK-RECE64-REC
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE   MCPDATA-REC    TO  SRYACCT-REC
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1"  TO  WRK-JINZOU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           .
       2001-JINZOU-COUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    人工腎臓の判定
      *****************************************************************
       2001-JINZOU-HANTEI-SEC          SECTION.
      *
      *    人工腎臓と再診の突き合わせ
           MOVE       ZERO             TO     CNT-JINZOU
           PERFORM    VARYING    IDX   FROM   1   BY   1
                      UNTIL      IDX   >    31
                  IF   (WRK-JINZOU(IDX)    =   "1")  AND
                       (WRK-SAISHIN4(IDX)  =   "1")
                       ADD     1           TO   CNT-JINZOU
                  END-IF
           END-PERFORM
      *
           IF      CNT-JINZOU        NOT =      ZERO
               MOVE    1         TO      FLG-JINZOU-COMMENT
           END-IF
      *
           .
       2001-JINZOU-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    人工腎臓のコメント編集
      *****************************************************************
       2002-JINZOU-COMMENT-SEC          SECTION.
      *
           INITIALIZE                      RECE641-REC
           MOVE    RECE62-HOSPID       TO  RECE641-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE641-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE641-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE641-PTID
           MOVE    RECE62-RECEKA       TO  RECE641-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE641-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE641-RECESYUBETU
           MOVE    RECE62-HKNJANUM     TO  RECE641-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE641-HOJOKBN
           MOVE    RECE62-TEKSTYMD     TO  RECE641-TEKSTYMD
           MOVE    ZERO                TO  RECE641-ZAINUM
           MOVE    WRK-RECE64-KOHBUNRI TO  RECE641-KOHBUNRI
           MOVE    WRK-RECE64-SRYKBN   TO  RECE641-SRYKBN
      *
           MOVE    1                   TO  RECE641-MEISAISU
      *
           WRITE   RECE641-REC
           ADD     1                   TO  CNT-RECE64
      *
           INITIALIZE                      RECE651-REC
           MOVE    RECE62-HOSPID       TO  RECE651-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE651-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE651-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE651-PTID
           MOVE    RECE62-RECEKA       TO  RECE651-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE651-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE651-RECESYUBETU
           MOVE    RECE62-HKNJANUM     TO  RECE651-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE651-HOJOKBN
           MOVE    RECE62-TEKSTYMD     TO  RECE651-TEKSTYMD
           MOVE    ZERO                TO  RECE651-ZAINUM
           MOVE    WRK-RECE64-SRYKBN   TO  RECE651-SRYKBN
      *    人工腎臓コメントの挿入
           ADD     1                    TO  IDX-RECE65
           MOVE    SPACE                TO  COM-RECE65-REC
           INITIALIZE                       COM-RECE65-REC
           MOVE    "810000001"          TO  COM-SRYCD(1)
           MOVE    ZERO                 TO  COM-SRYSURYO(1)
           MOVE    14                   TO  COM-YUKOKETA(1)
           MOVE    "再診４回目以降実施回数　　回"  TO COM-NAME(1)
           MOVE    CNT-JINZOU           TO  DAY-IDX
           MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(23:4)
           MOVE    COM-SRYACTINF(1)     TO  RECE651-SRYACTINF(1)
           MOVE    COM-NAMEINF(1)       TO  RECE651-NAMEINF(1)
           WRITE   RECE651-REC
           ADD     1                    TO  CNT-RECE65
      *
           .
       2002-JINZOU-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    指導管理料のコメントがあるか判定
      *****************************************************************
       2001-SHIDOU-HANTEI-SEC          SECTION.
      *
           MOVE    ZERO              TO      FLG-SHIDOU-COMMENT
      *
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    "113006510"       TO      SRY-SRYCD (1)
           MOVE    "113006510"       TO      SRY-SRYCD (2)
           MOVE    "113006510"       TO      SRY-SRYCD (3)
           MOVE    "113006510"       TO      SRY-SRYCD (4)
           MOVE    "113006510"       TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                NOT  =  ZERO
               CONTINUE
           ELSE
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC   TO  SRYACT-REC
                   MOVE    1         TO      FLG-SHIDOU-COMMENT
               END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *
      ***  IF  RECE64-SRYYM       >=  "200210"
      *
      *      算定履歴検索
             INITIALIZE                  SANTEI-REC
             MOVE    RECE64-HOSPID       TO  SANTEI-HOSPID
             MOVE    RECE64-PTID         TO  SANTEI-PTID
             MOVE    RECE64-SRYYM        TO  SANTEI-SRYYM
             MOVE    "113006510"         TO  SANTEI-SRYCD
             MOVE    ZERO                TO  SANTEI-NYUGAIKBN
             MOVE    ZERO                TO  SANTEI-SRYKA
             MOVE    ZERO                TO  SANTEI-HKNCOMBINUM
             MOVE    SANTEI-REC          TO  MCPDATA-REC
             MOVE    "DBSELECT"          TO  MCP-FUNC
             MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
             CALL    "ORCMCPSUB"         USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
             IF      MCP-RC              =   ZERO
                  MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
                  PERFORM        SANTEI-READ-SEC
                  PERFORM   UNTIL   FLG-SANTEI  =   1
      *
                     IF     SANTEI-FSANTEIYMD(1:6)  =  RECE64-SRYYM   
                           CONTINUE
                     ELSE
                           MOVE    ZERO    TO      FLG-SHIDOU-COMMENT
                     END-IF
      * 
                     MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
                     PERFORM        SANTEI-READ-SEC
                  END-PERFORM
             END-IF
      *
             MOVE    "DBCLOSE"           TO  MCP-FUNC
             MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
             CALL    "ORCMCPSUB"         USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
      *
      ***  END-IF
      *
           .
       2001-SHIDOU-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    手術日のコメントがあるか判定
      *****************************************************************
       2001-SHUJUTSU-HANTEI-SEC          SECTION.
      *
           MOVE    ZERO              TO      FLG-SHUJUTU-COMMENT
      *
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    "840000042"       TO      SRY-SRYCD (1)
           MOVE    "840000042"       TO      SRY-SRYCD (2)
           MOVE    "840000042"       TO      SRY-SRYCD (3)
           MOVE    "840000042"       TO      SRY-SRYCD (4)
           MOVE    "840000042"       TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                NOT  =  ZERO
               MOVE      1           TO      FLG-SHUJUTU-COMMENT
           ELSE
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC   TO  SRYACT-REC
               ELSE
                   MOVE    1         TO      FLG-SHUJUTU-COMMENT
               END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           .
       2001-SHUJUTSU-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    指導管理料のコメント編集
      *****************************************************************
       2001-SHIDOU-COMMENT-SEC          SECTION.
      *
           PERFORM   2001-SHIDOU-DAY-SEC
      *
             MOVE       RECE64-REC    TO   RECE641-REC
             ADD     1                TO   RECE641-MEISAISU
             WRITE      RECE641-REC
             ADD     1                TO   CNT-RECE64
      *
             INITIALIZE                      RECE65-REC
             MOVE    RECE64-HOSPID       TO  RECE65-HOSPID
             MOVE    RECE64-SRYYM        TO  RECE65-SRYYM
             MOVE    RECE64-NYUGAIKBN    TO  RECE65-NYUGAIKBN
             MOVE    RECE64-PTID         TO  RECE65-PTID
             MOVE    RECE64-RECEKA       TO  RECE65-RECEKA
             MOVE    RECE64-TEISYUTUSAKI TO  RECE65-TEISYUTUSAKI
             MOVE    RECE64-RECESYUBETU  TO  RECE65-RECESYUBETU
             MOVE    RECE64-HKNJANUM     TO  RECE65-HKNJANUM
             MOVE    RECE64-HOJOKBN      TO  RECE65-HOJOKBN
             MOVE    RECE64-TEKSTYMD     TO  RECE65-TEKSTYMD
             MOVE    RECE64-ZAINUM       TO  RECE65-ZAINUM
             START   RECE65-FILE
                 KEY IS    >=   RECE65-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE65
                 NOT INVALID
                     PERFORM 990-RECE65-NEXT-SEC
             END-START
      *
             MOVE    RECE65-REC       TO      RECE651-REC
             MOVE    RECE65-SRYACTINF(1)  TO  RECE651-SRYACTINF(1)
             MOVE    RECE65-SRYACTINF(2)  TO  RECE651-SRYACTINF(3)
             MOVE    RECE65-SRYACTINF(3)  TO  RECE651-SRYACTINF(4)
             MOVE    RECE65-SRYACTINF(4)  TO  RECE651-SRYACTINF(5)
             MOVE    RECE65-NAMEINF(1)    TO  RECE651-NAMEINF(1)
             MOVE    RECE65-NAMEINF(2)    TO  RECE651-NAMEINF(3)
             MOVE    RECE65-NAMEINF(3)    TO  RECE651-NAMEINF(4)
             MOVE    RECE65-NAMEINF(4)    TO  RECE651-NAMEINF(5)
      *
             MOVE    SPACE                TO  RECE651-SRYACTINF(2)
             INITIALIZE                       RECE651-SRYACTINF(2)
             MOVE    "810000001"          TO  RECE651-SRYCD(2)
             MOVE    ZERO                 TO  RECE651-SRYSURYO(2)
             MOVE    15                   TO  RECE651-YUKOKETA(2)
             MOVE    "慢性疼痛疾患管理算定日　　　日"
                                          TO  RECE651-NAME(2)
             MOVE     TB-SHUJUTSU-DAY(1)  TO  DAY-IDX
             MOVE     TBL-DAY(DAY-IDX)    TO  RECE651-NAME(2)(25:4)
             WRITE    RECE651-REC
             ADD      1                    TO  CNT-RECE65
      *    
      *
           .
       2001-SHIDOU-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    手術日のコメント編集
      *****************************************************************
       2001-SHUJUTSU-COMMENT-SEC          SECTION.
      *
           PERFORM   2001-SHUJUTSU-DAY-SEC
      *
      **     ※明細が５以上の場合
             INITIALIZE                      RECE65-REC
             MOVE    RECE64-HOSPID       TO  RECE65-HOSPID
             MOVE    RECE64-SRYYM        TO  RECE65-SRYYM
             MOVE    RECE64-NYUGAIKBN    TO  RECE65-NYUGAIKBN
             MOVE    RECE64-PTID         TO  RECE65-PTID
             MOVE    RECE64-RECEKA       TO  RECE65-RECEKA
             MOVE    RECE64-TEISYUTUSAKI TO  RECE65-TEISYUTUSAKI
             MOVE    RECE64-RECESYUBETU  TO  RECE65-RECESYUBETU
             MOVE    RECE64-HKNJANUM     TO  RECE65-HKNJANUM
             MOVE    RECE64-HOJOKBN      TO  RECE65-HOJOKBN
             MOVE    RECE64-TEKSTYMD     TO  RECE65-TEKSTYMD
             MOVE    RECE64-ZAINUM       TO  RECE65-ZAINUM
             START   RECE65-FILE
                 KEY IS    >=   RECE65-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE65
                 NOT INVALID
                     PERFORM 990-RECE65-NEXT-SEC
                     MOVE    RECE65-REC  TO  WRK-RECE65-REC
             END-START
      *
      *      ＲＥＣＥ０５ファイルの内容をテーブルに退避
             MOVE    ZERO                 TO  IDX-RECE65
             MOVE    SPACE                TO  WRK-SRYACTINF-AREA
             INITIALIZE                       WRK-SRYACTINF-AREA
             MOVE    SPACE                TO  WRK-NAMEINF-AREA
             INITIALIZE                       WRK-NAMEINF-AREA
      *        手術日コメントの挿入
             PERFORM  VARYING      IDX    FROM  1   BY   1
                      UNTIL       (IDX    >     10)      OR
                                  (TB-SHUJUTSU-DAY(IDX)  =  ZERO)
                 ADD     1                    TO  IDX-RECE65
                 MOVE    SPACE                TO  COM-RECE65-REC
                 INITIALIZE                       COM-RECE65-REC
                 MOVE    "840000042"          TO  COM-SRYCD(1)
                 MOVE    ZERO                 TO  COM-SRYSURYO(1)
                 MOVE    6                    TO  COM-YUKOKETA(1)
                 MOVE    "手術　　　日"       TO  COM-NAME(1)
                 MOVE    TB-SHUJUTSU-DAY(IDX) TO  DAY-IDX
                 MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(7:4)
                 MOVE    COM-SRYACTINF(1)     TO  WRK-SRYACTINF
                                                       (IDX-RECE65)
                 MOVE    COM-NAMEINF(1)       TO  WRK-NAMEINF
                                                       (IDX-RECE65)
             END-PERFORM
      *
             PERFORM
               UNTIL  ( FLG-RECE65           =   1                   )
               OR     ( RECE64-HOSPID    NOT =   RECE65-HOSPID       )
               OR     ( RECE64-SRYYM     NOT =   RECE65-SRYYM        )
               OR     ( RECE64-NYUGAIKBN NOT =   RECE65-NYUGAIKBN    )
               OR     ( RECE64-PTID      NOT =   RECE65-PTID         )
               OR     ( RECE64-RECEKA    NOT =   RECE65-RECEKA       )
               OR     ( RECE64-TEISYUTUSAKI
                                         NOT =   RECE65-TEISYUTUSAKI )
               OR     ( RECE64-RECESYUBETU
                                         NOT =   RECE65-RECESYUBETU  )
               OR     ( RECE64-HKNJANUM  NOT =   RECE65-HKNJANUM     )
               OR     ( RECE64-HOJOKBN   NOT =   RECE65-HOJOKBN      )
               OR     ( RECE64-TEKSTYMD  NOT =   RECE65-TEKSTYMD     )
               OR     ( RECE64-ZAINUM    NOT =   RECE65-ZAINUM       )
      *
               PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX               >   5     )
                         OR      ( RECE65-SRYCD(IDX) =   SPACE )
                    ADD    1             TO      IDX-RECE65
                    MOVE   RECE65-SRYACTINF(IDX) TO
                                             WRK-SRYACTINF(IDX-RECE65)
                    MOVE   RECE65-NAMEINF(IDX)   TO
                                             WRK-NAMEINF(IDX-RECE65)     
               END-PERFORM 
      *
               PERFORM 990-RECE65-NEXT-SEC
      *
             END-PERFORM
      *
      *      手術日コメントを含んだ内容で中間ファイルの再作成
             MOVE       ZERO             TO      FLG-WRKRECE65
             MOVE       ZERO             TO      IDX
             MOVE       ZERO             TO      IDX-RECE65
             MOVE       ZERO             TO      WRK-RENNUM
             MOVE       ZERO             TO      WRK-CNT-MEISAI
             PERFORM    UNTIL     FLG-WRKRECE65  =    1
                    INITIALIZE                        RECE651-REC
                    MOVE    WRK-RECE65-KEY       TO   RECE651-KEY
                    ADD     1                    TO   WRK-RENNUM
                    MOVE    WRK-RENNUM           TO   RECE651-RENNUM
                    MOVE    WRK-RECE65-KOHBUNRI  TO   RECE651-KOHBUNRI
                    MOVE    WRK-RECE65-PTNUM     TO   RECE651-PTNUM
                    MOVE    WRK-RECE65-SRYKA     TO   RECE651-SRYKA
                    MOVE    WRK-RECE65-SRYKBN    TO   RECE651-SRYKBN
                    MOVE    WRK-RECE65-SRYSYUKBN TO   RECE651-SRYSYUKBN
                    MOVE    WRK-RECE65-JIHIMONEY TO   RECE651-JIHIMONEY
                    PERFORM  VARYING   IDX   FROM   1   BY   1
                             UNTIL   (IDX       >    5)   OR
                                     (FLG-WRKRECE65   =   1)
                       ADD         1             TO    IDX-RECE65
                       IF  WK-RECE65-SRYCD(IDX-RECE65) = SPACE
                           MOVE    1             TO    FLG-WRKRECE65
                       ELSE
                           MOVE  WRK-SRYACTINF(IDX-RECE65)
                                            TO   RECE651-SRYACTINF(IDX)  
                           MOVE  WRK-NAMEINF(IDX-RECE65)
                                            TO   RECE651-NAMEINF(IDX)
                           ADD   1          TO   WRK-CNT-MEISAI
                       END-IF  
                    END-PERFORM
                    WRITE   RECE651-REC
                    ADD     1                    TO  CNT-RECE65
             END-PERFORM     
      *
             MOVE    RECE64-REC        TO      RECE641-REC
             MOVE    WRK-CNT-MEISAI    TO      RECE641-MEISAISU
             WRITE   RECE641-REC
             ADD     1                 TO      CNT-RECE64
      *
           .
       2001-SHUJUTSU-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    指導管理算定日の確定
      *****************************************************************
       2001-SHIDOU-DAY-SEC          SECTION.
      *
           INITIALIZE                TBL-SHUJUTSU-DAY
      *
           INITIALIZE                        SRYACCT-REC
           MOVE    RECE64-HOSPID     TO      ACCT-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      ACCT-NYUGAIKBN
           MOVE    RECE64-PTID       TO      ACCT-PTID
           MOVE    RECE64-SRYKA      TO      ACCT-SRYKA
           MOVE    RECE64-SRYYM      TO      ACCT-SRYYM
           MOVE    RECE64-SRYKBN     TO      ACCT-SRYKBN
           MOVE    RECE64-ZAINUM     TO      ACCT-ZAINUM
      *
           MOVE    SRYACCT-REC       TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =  ZERO
               MOVE    "DBFETCH"      TO     MCP-FUNC
               MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
              IF      MCP-RC        =        ZERO
                   MOVE    ZERO          TO  DAY-IDX
                   MOVE    MCPDATA-REC   TO  SRYACCT-REC
                   PERFORM    VARYING    IDX  FROM   1   BY   1
                              UNTIL     (IDX      >   31)  OR
                                        (DAY-IDX  >   10)
                        IF    ACCT-DAY(1 IDX)  NOT =  ZERO
                              ADD   1     TO   DAY-IDX
                              MOVE  IDX   TO  TB-SHUJUTSU-DAY(DAY-IDX)
                        END-IF
                         CONTINUE
                   END-PERFORM
              END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           .
       2001-SHIDOU-DAY-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    手術日の確定
      *****************************************************************
       2001-SHUJUTSU-DAY-SEC          SECTION.
      *
           INITIALIZE                TBL-SHUJUTSU-DAY
      *
           INITIALIZE                        SRYACCT-REC
           MOVE    RECE64-HOSPID     TO      ACCT-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      ACCT-NYUGAIKBN
           MOVE    RECE64-PTID       TO      ACCT-PTID
           MOVE    RECE64-SRYKA      TO      ACCT-SRYKA
           MOVE    RECE64-SRYYM      TO      ACCT-SRYYM
           MOVE    RECE64-SRYKBN     TO      ACCT-SRYKBN
           MOVE    RECE64-ZAINUM     TO      ACCT-ZAINUM
      *
           MOVE    SRYACCT-REC       TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =  ZERO
               MOVE    "DBFETCH"      TO     MCP-FUNC
               MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
              IF      MCP-RC        =        ZERO
                   MOVE    ZERO          TO  DAY-IDX
                   MOVE    MCPDATA-REC   TO  SRYACCT-REC
                   PERFORM    VARYING    IDX  FROM   1   BY   1
                              UNTIL     (IDX      >   31)  OR
                                        (DAY-IDX  >   10)
                        IF    ACCT-DAY(1 IDX)  NOT =  ZERO
                              ADD   1     TO   DAY-IDX
                              MOVE  IDX   TO  TB-SHUJUTSU-DAY(DAY-IDX)
                        END-IF
                         CONTINUE
                   END-PERFORM
              END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           .
       2001-SHUJUTSU-DAY-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０５転送処理
      *****************************************************************
       2002-RECE65-TENSOU-SEC     SECTION.
      *
           INITIALIZE                      RECE65-REC
           MOVE    RECE64-HOSPID       TO  RECE65-HOSPID
           MOVE    RECE64-SRYYM        TO  RECE65-SRYYM
           MOVE    RECE64-NYUGAIKBN    TO  RECE65-NYUGAIKBN
           MOVE    RECE64-PTID         TO  RECE65-PTID
           MOVE    RECE64-RECEKA       TO  RECE65-RECEKA
           MOVE    RECE64-TEISYUTUSAKI TO  RECE65-TEISYUTUSAKI
           MOVE    RECE64-RECESYUBETU  TO  RECE65-RECESYUBETU
           MOVE    RECE64-HKNJANUM     TO  RECE65-HKNJANUM
           MOVE    RECE64-HOJOKBN      TO  RECE65-HOJOKBN
           MOVE    RECE64-TEKSTYMD     TO  RECE65-TEKSTYMD
           MOVE    RECE64-ZAINUM       TO  RECE65-ZAINUM
           START   RECE65-FILE
               KEY IS    >=   RECE65-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE65
               NOT INVALID
                   PERFORM 990-RECE65-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( FLG-RECE65           =   1                   )
               OR     ( RECE64-HOSPID    NOT =   RECE65-HOSPID       )
               OR     ( RECE64-SRYYM     NOT =   RECE65-SRYYM        )
               OR     ( RECE64-NYUGAIKBN NOT =   RECE65-NYUGAIKBN    )
               OR     ( RECE64-PTID      NOT =   RECE65-PTID         )
               OR     ( RECE64-RECEKA    NOT =   RECE65-RECEKA       )
               OR     ( RECE64-TEISYUTUSAKI
                                         NOT =   RECE65-TEISYUTUSAKI )
               OR     ( RECE64-RECESYUBETU
                                         NOT =   RECE65-RECESYUBETU  )
               OR     ( RECE64-HKNJANUM  NOT =   RECE65-HKNJANUM     )
               OR     ( RECE64-HOJOKBN   NOT =   RECE65-HOJOKBN      )
               OR     ( RECE64-TEKSTYMD  NOT =   RECE65-TEKSTYMD     )
               OR     ( RECE64-ZAINUM    NOT =   RECE65-ZAINUM       )
      *
      *
               MOVE          RECE65-REC       TO      RECE651-REC
               WRITE         RECE651-REC
               ADD     1                 TO  CNT-RECE65
      *
               PERFORM 990-RECE65-NEXT-SEC
      *
           END-PERFORM
      *
           .
       2002-RECE65-TENSOU-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC                SECTION.
      *
           OPEN    INPUT   RECEERR-FILE
           IF      STS-RECEERR         =   ZERO
               CLOSE   RECEERR-FILE
           ELSE
               OPEN    OUTPUT              RECEERR-FILE
      *
               MOVE    WRK-RECEERR         TO  RECEERR-REC
               WRITE   RECEERR-REC
               CLOSE   RECEERR-FILE
      *         
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA  
                                       JOBKANRI-REC
           END-IF
      *                             
           MOVE    1                   TO  FLG-END
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
      *    ファイルＣＬＯＳＥ処理
           PERFORM 310-FILE-CLOSE-SEC
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           DISPLAY "RECE62  IN  " CNT-RECE62 
           DISPLAY "RECE64  CNT " CNT-RECE64 
           DISPLAY "RECE65  CNT " CNT-RECE65 
           DISPLAY "*** ORCR0660 END ***"
      ***     ACCEPT  WRK-IN FROM CONSOLE 
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイルＣＬＯＳＥ処理
      *****************************************************************
       310-FILE-CLOSE-SEC              SECTION.
      *
           CLOSE                       RECE62-FILE
      *
           CLOSE                       RECE64-FILE
      *
           CLOSE                       RECE65-FILE
      *
           CLOSE                       RECE641-FILE     
           CLOSE                       RECE651-FILE     
      *
           .
       310-FILE-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０２データ順検索処理
      *****************************************************************
       990-RECE62-READ-SEC           SECTION.
      *
           READ    RECE62-FILE         NEXT
               AT  END
                   MOVE    1           TO  FLG-END
                   MOVE    2           TO  SPA-STS
               NOT AT  END
                   ADD     1           TO  CNT-RECE62
                   ADD     1           TO  CNT-IN-COMMIT
                   MOVE    ZERO        TO  FLG-END
           END-READ
      *
           .
       990-RECE62-READ-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０４データ読み
      ****************************************************************
       990-RECE64-NEXT-SEC           SECTION.
      *
           READ    RECE64-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE64
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE64
           END-READ
      *
           .
       990-RECE64-NEXT-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０５データ読み
      ****************************************************************
       990-RECE65-NEXT-SEC           SECTION.
      *
           READ    RECE65-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE65
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE65
           END-READ
      *
           .
       990-RECE65-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスター読込（キー）
      *****************************************************************
       900-TENSU-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "TENSU-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-TENSU
                   MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
               ELSE
                   INITIALIZE                  TNS-TENSU-REC
                   MOVE    1                   TO  FLG-TENSU
               END-IF
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-TENSU-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数読込
      *****************************************************************
       TENSU-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
               MOVE    ZERO            TO  FLG-TENSU
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1               TO  FLG-TENSU
           END-IF
      *
           .
       TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    算定歴マスタ読み込み
      *****************************************************************
       SANTEI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SANTEI-REC
               MOVE    ZERO                TO  FLG-SANTEI
           ELSE
               INITIALIZE                      SANTEI-REC
               MOVE    1                   TO  FLG-SANTEI
           END-IF
      *
           .
       SANTEI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスター読込
      *****************************************************************
       SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1005-REC
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               INITIALIZE                  SYS-1005-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴読込
      *****************************************************************
       JYURRK-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  JYURRK-REC
               MOVE    ZERO            TO  FLG-JYURRK
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           .
       JYURRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソルクローズ処理
      *****************************************************************
       CSR-CLOSE-SEC            SECTION.
      *
           INITIALIZE                  MCPAREA
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       CSR-CLOSE-EXT.
           EXIT.
      *      
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       120-DBOPEN-SEC                SECTION.
      *
           MOVE    "DBOPEN"            TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       900-DBCLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　ＣＯＭＭＩＴ処理
      *****************************************************************
       900-DBCOMMIT-SEC            SECTION.
      *
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "MCPSUB"          USING
                                        MCPAREA
                                        MCPDATA-REC.
      *
           .
       900-DBCOMMIT-EXT.
           EXIT.
      *      
      *****************************************************************
      *    ＤＢ　ＳＴＡＲＴ処理
      *****************************************************************
       900-DBSTART-SEC                SECTION.
      *
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       900-DBSTART-EXT.
           EXIT.
      *
      *****************************************************************
      *    リハビリのカウント
      *****************************************************************
       2001-RIHA-COUNT-SEC          SECTION.
      *
      *理学療法（１）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA1-SHU1   TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA1-SHU1   TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA1-SHU1   TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA1-SHU1   TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA1-SHU1   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA1-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA1-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA1-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（１）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA1-SHU2   TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA1-SHU2   TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA1-SHU2   TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA1-SHU2   TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA1-SHU2   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA1-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA1-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA1-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（１）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA1-KO1    TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA1-KO1    TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA1-KO1    TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA1-KO1    TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA1-KO1    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA1-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA1-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA1-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（１）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA1-KO2    TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA1-KO2    TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA1-KO2    TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA1-KO2    TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA1-KO2    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA1-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA1-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA1-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（２）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA2-SHU1   TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA2-SHU1   TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA2-SHU1   TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA2-SHU1   TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA2-SHU1   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA2-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA2-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA2-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（２）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA2-SHU2   TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA2-SHU2   TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA2-SHU2   TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA2-SHU2   TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA2-SHU2   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA2-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA2-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA2-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（２）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA2-KO1    TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA2-KO1    TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA2-KO1    TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA2-KO1    TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA2-KO1    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA2-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA2-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA2-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（２）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA2-KO2    TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA2-KO2    TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA2-KO2    TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA2-KO2    TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA2-KO2    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA2-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA2-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA2-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（３）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA3-SHU1   TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA3-SHU1   TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA3-SHU1   TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA3-SHU1   TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA3-SHU1   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA3-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA3-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA3-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（３）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA3-SHU2   TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA3-SHU2   TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA3-SHU2   TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA3-SHU2   TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA3-SHU2   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA3-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA3-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA3-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（３）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA3-KO1    TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA3-KO1    TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA3-KO1    TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA3-KO1    TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA3-KO1    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA3-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA3-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA3-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（３）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA3-KO2    TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA3-KO2    TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA3-KO2    TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA3-KO2    TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA3-KO2    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA3-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA3-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA3-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（４）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA4-SHU1   TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA4-SHU1   TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA4-SHU1   TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA4-SHU1   TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA4-SHU1   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA4-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA4-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA4-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（４）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA4-SHU2   TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA4-SHU2   TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA4-SHU2   TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA4-SHU2   TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA4-SHU2   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA4-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA4-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA4-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（４）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA4-KO1    TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA4-KO1    TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA4-KO1    TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA4-KO1    TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA4-KO1    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA4-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA4-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA4-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（４）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA4-KO2    TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA4-KO2    TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA4-KO2    TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA4-KO2    TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA4-KO2    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA4-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA4-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA4-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *作業療法（１）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAGYO1-SHU1  TO      SRY-SRYCD (1)
           MOVE    CONS-SAGYO1-SHU1  TO      SRY-SRYCD (2)
           MOVE    CONS-SAGYO1-SHU1  TO      SRY-SRYCD (3)
           MOVE    CONS-SAGYO1-SHU1  TO      SRY-SRYCD (4)
           MOVE    CONS-SAGYO1-SHU1  TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-SAGYO1-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-SAGYO1-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-SAGYO1-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *作業療法（１）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAGYO1-SHU2  TO      SRY-SRYCD (1)
           MOVE    CONS-SAGYO1-SHU2  TO      SRY-SRYCD (2)
           MOVE    CONS-SAGYO1-SHU2  TO      SRY-SRYCD (3)
           MOVE    CONS-SAGYO1-SHU2  TO      SRY-SRYCD (4)
           MOVE    CONS-SAGYO1-SHU2  TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-SAGYO1-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-SAGYO1-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-SAGYO1-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *作業療法（２）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAGYO2-SHU1  TO      SRY-SRYCD (1)
           MOVE    CONS-SAGYO2-SHU1  TO      SRY-SRYCD (2)
           MOVE    CONS-SAGYO2-SHU1  TO      SRY-SRYCD (3)
           MOVE    CONS-SAGYO2-SHU1  TO      SRY-SRYCD (4)
           MOVE    CONS-SAGYO2-SHU1  TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-SAGYO2-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-SAGYO2-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-SAGYO2-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *作業療法（２）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAGYO2-SHU2  TO      SRY-SRYCD (1)
           MOVE    CONS-SAGYO2-SHU2  TO      SRY-SRYCD (2)
           MOVE    CONS-SAGYO2-SHU2  TO      SRY-SRYCD (3)
           MOVE    CONS-SAGYO2-SHU2  TO      SRY-SRYCD (4)
           MOVE    CONS-SAGYO2-SHU2  TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-SAGYO2-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-SAGYO2-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-SAGYO2-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *作業療法（１）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAGYO1-KO1   TO      SRY-SRYCD (1)
           MOVE    CONS-SAGYO1-KO1   TO      SRY-SRYCD (2)
           MOVE    CONS-SAGYO1-KO1   TO      SRY-SRYCD (3)
           MOVE    CONS-SAGYO1-KO1   TO      SRY-SRYCD (4)
           MOVE    CONS-SAGYO1-KO1   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-SAGYO1-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-SAGYO1-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-SAGYO1-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *作業療法（１）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAGYO1-KO2   TO      SRY-SRYCD (1)
           MOVE    CONS-SAGYO1-KO2   TO      SRY-SRYCD (2)
           MOVE    CONS-SAGYO1-KO2   TO      SRY-SRYCD (3)
           MOVE    CONS-SAGYO1-KO2   TO      SRY-SRYCD (4)
           MOVE    CONS-SAGYO1-KO2   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-SAGYO1-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-SAGYO1-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-SAGYO1-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *作業療法（２）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAGYO2-KO1   TO      SRY-SRYCD (1)
           MOVE    CONS-SAGYO2-KO1   TO      SRY-SRYCD (2)
           MOVE    CONS-SAGYO2-KO1   TO      SRY-SRYCD (3)
           MOVE    CONS-SAGYO2-KO1   TO      SRY-SRYCD (4)
           MOVE    CONS-SAGYO2-KO1   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-SAGYO2-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-SAGYO2-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-SAGYO2-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *作業療法（２）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAGYO2-KO2   TO      SRY-SRYCD (1)
           MOVE    CONS-SAGYO2-KO2   TO      SRY-SRYCD (2)
           MOVE    CONS-SAGYO2-KO2   TO      SRY-SRYCD (3)
           MOVE    CONS-SAGYO2-KO2   TO      SRY-SRYCD (4)
           MOVE    CONS-SAGYO2-KO2   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-SAGYO2-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-SAGYO2-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-SAGYO2-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *言語聴覚療法（１）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-GENGO1-SHU   TO      SRY-SRYCD (1)
           MOVE    CONS-GENGO1-SHU   TO      SRY-SRYCD (2)
           MOVE    CONS-GENGO1-SHU   TO      SRY-SRYCD (3)
           MOVE    CONS-GENGO1-SHU   TO      SRY-SRYCD (4)
           MOVE    CONS-GENGO1-SHU   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-GENGO1-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-GENGO1-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-GENGO1-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *言語聴覚療法（１）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-GENGO1-KO    TO      SRY-SRYCD (1)
           MOVE    CONS-GENGO1-KO    TO      SRY-SRYCD (2)
           MOVE    CONS-GENGO1-KO    TO      SRY-SRYCD (3)
           MOVE    CONS-GENGO1-KO    TO      SRY-SRYCD (4)
           MOVE    CONS-GENGO1-KO    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-GENGO1-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-GENGO1-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-GENGO1-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *言語聴覚療法（２）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-GENGO2-SHU   TO      SRY-SRYCD (1)
           MOVE    CONS-GENGO2-SHU   TO      SRY-SRYCD (2)
           MOVE    CONS-GENGO2-SHU   TO      SRY-SRYCD (3)
           MOVE    CONS-GENGO2-SHU   TO      SRY-SRYCD (4)
           MOVE    CONS-GENGO2-SHU   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-GENGO2-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-GENGO2-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-GENGO2-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *言語聴覚療法（２）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE64-HOSPID     TO      SRY-HOSPID
           MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE64-PTID       TO      SRY-PTID
           MOVE    RECE64-SRYYM      TO      SRY-SRYYM
           MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-GENGO2-KO    TO      SRY-SRYCD (1)
           MOVE    CONS-GENGO2-KO    TO      SRY-SRYCD (2)
           MOVE    CONS-GENGO2-KO    TO      SRY-SRYCD (3)
           MOVE    CONS-GENGO2-KO    TO      SRY-SRYCD (4)
           MOVE    CONS-GENGO2-KO    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-GENGO2-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-GENGO2-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-GENGO2-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           .
       2001-RIHA-COUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    リハビリのコメント編集
      *****************************************************************
       2001-RIHA-COMMENT-SEC          SECTION.
      *
           MOVE    RECE64-REC        TO      RECE641-REC
           ADD     1                 TO      RECE641-MEISAISU
           WRITE   RECE641-REC
           ADD     1                 TO      CNT-RECE64
      *
      *      ※明細が５以上の場合
             INITIALIZE                      RECE65-REC
             MOVE    RECE64-HOSPID       TO  RECE65-HOSPID
             MOVE    RECE64-SRYYM        TO  RECE65-SRYYM
             MOVE    RECE64-NYUGAIKBN    TO  RECE65-NYUGAIKBN
             MOVE    RECE64-PTID         TO  RECE65-PTID
             MOVE    RECE64-RECEKA       TO  RECE65-RECEKA
             MOVE    RECE64-TEISYUTUSAKI TO  RECE65-TEISYUTUSAKI
             MOVE    RECE64-RECESYUBETU  TO  RECE65-RECESYUBETU
             MOVE    RECE64-HKNJANUM     TO  RECE65-HKNJANUM
             MOVE    RECE64-HOJOKBN      TO  RECE65-HOJOKBN
             MOVE    RECE64-TEKSTYMD     TO  RECE65-TEKSTYMD
             MOVE    RECE64-ZAINUM       TO  RECE65-ZAINUM
             START   RECE65-FILE
                 KEY IS    >=   RECE65-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE65
                 NOT INVALID
                     PERFORM 990-RECE65-NEXT-SEC
                     MOVE    RECE65-REC  TO  WRK-RECE65-REC
             END-START
      *
      *      ＲＥＣＥ０５ファイルの内容をテーブルに退避
             MOVE    ZERO                 TO  IDX-RECE65
             MOVE    SPACE                TO  WRK-SRYACTINF-AREA
             INITIALIZE                       WRK-SRYACTINF-AREA
             MOVE    SPACE                TO  WRK-NAMEINF-AREA
             INITIALIZE                       WRK-NAMEINF-AREA
      *      リハビリコメントの挿入
      *      ADD     1                    TO  IDX-RECE65
             MOVE    SPACE                TO  COM-RECE65-REC
             INITIALIZE                       COM-RECE65-REC
             MOVE    "840000096"          TO  COM-SRYCD(1)
             MOVE    ZERO                 TO  COM-SRYSURYO(1)
             MOVE    7                    TO  COM-YUKOKETA(1)
             MOVE    "実施日数　　日"     TO  COM-NAME(1)
             MOVE    ZERO                 TO  CNT-RIHA
             EVALUATE   RECE64-ZAINUM
                 WHEN   WRK-RIGA1-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA1-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA2-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA2-SHU(IDX) NOT = SPACE
                                ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA3-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA3-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA4-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA4-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA1-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA1-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA2-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA2-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA3-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA3-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA4-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA4-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO1-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO1-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO2-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO2-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO1-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO1-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO2-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO2-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO1-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO1-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO2-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO2-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO1-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO1-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO2-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO2-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   OTHER
                        CONTINUE
             END-EVALUATE
             IF      CNT-RIHA             NOT =    ZERO
               MOVE    CNT-RIHA             TO  DAY-IDX
               MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(9:4)
               COMPUTE  MAX-MEISAISU        =   RECE64-MEISAISU  +  1
               MOVE    COM-SRYACTINF(1)     TO  WRK-SRYACTINF
                                                     (MAX-MEISAISU)
               MOVE    COM-NAMEINF(1)       TO  WRK-NAMEINF
                                                     (MAX-MEISAISU)
             END-IF
      *
             PERFORM
               UNTIL  ( FLG-RECE65           =   1                   )
               OR     ( RECE64-HOSPID    NOT =   RECE65-HOSPID       )
               OR     ( RECE64-SRYYM     NOT =   RECE65-SRYYM        )
               OR     ( RECE64-NYUGAIKBN NOT =   RECE65-NYUGAIKBN    )
               OR     ( RECE64-PTID      NOT =   RECE65-PTID         )
               OR     ( RECE64-RECEKA    NOT =   RECE65-RECEKA       )
               OR     ( RECE64-TEISYUTUSAKI
                                         NOT =   RECE65-TEISYUTUSAKI )
               OR     ( RECE64-RECESYUBETU
                                         NOT =   RECE65-RECESYUBETU  )
               OR     ( RECE64-HKNJANUM  NOT =   RECE65-HKNJANUM     )
               OR     ( RECE64-HOJOKBN   NOT =   RECE65-HOJOKBN      )
               OR     ( RECE64-TEKSTYMD  NOT =   RECE65-TEKSTYMD     )
               OR     ( RECE64-ZAINUM    NOT =   RECE65-ZAINUM       )
      *
               PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX               >   5     )
                         OR      ( RECE65-SRYCD(IDX) =   SPACE )
                    ADD    1             TO      IDX-RECE65
                    MOVE   RECE65-SRYACTINF(IDX) TO
                                             WRK-SRYACTINF(IDX-RECE65)
                    MOVE   RECE65-NAMEINF(IDX)   TO
                                             WRK-NAMEINF(IDX-RECE65)     
               END-PERFORM 
      *
               PERFORM 990-RECE65-NEXT-SEC
      *
             END-PERFORM
      *
      *      リハビリコメントを含んだ内容で中間ファイルの再作成
             MOVE       ZERO             TO      FLG-WRKRECE65
             MOVE       ZERO             TO      IDX
             MOVE       ZERO             TO      IDX-RECE65
             MOVE       ZERO             TO      WRK-RENNUM
             PERFORM    UNTIL     FLG-WRKRECE65  =    1
                    INITIALIZE                        RECE651-REC
                    MOVE    WRK-RECE65-KEY       TO   RECE651-KEY
                    ADD     1                    TO   WRK-RENNUM
                    MOVE    WRK-RENNUM           TO   RECE651-RENNUM
                    MOVE    WRK-RECE65-KOHBUNRI  TO   RECE651-KOHBUNRI
                    MOVE    WRK-RECE65-PTNUM     TO   RECE651-PTNUM
                    MOVE    WRK-RECE65-SRYKA     TO   RECE651-SRYKA
                    MOVE    WRK-RECE65-SRYKBN    TO   RECE651-SRYKBN
                    MOVE    WRK-RECE65-SRYSYUKBN TO   RECE651-SRYSYUKBN
                    MOVE    WRK-RECE65-JIHIMONEY TO   RECE651-JIHIMONEY
                    PERFORM  VARYING   IDX   FROM   1   BY   1
                             UNTIL   (IDX       >    5)   OR
                                     (FLG-WRKRECE65   =   1)
                       ADD         1             TO    IDX-RECE65
                       IF  WK-RECE65-SRYCD(IDX-RECE65) = SPACE
                           MOVE    1             TO    FLG-WRKRECE65
                       ELSE
                           MOVE  WRK-SRYACTINF(IDX-RECE65)
                                            TO   RECE651-SRYACTINF(IDX)  
                           MOVE  WRK-NAMEINF(IDX-RECE65)
                                            TO   RECE651-NAMEINF(IDX)
                       END-IF  
                    END-PERFORM
                    WRITE   RECE651-REC
                    ADD     1                    TO  CNT-RECE65
             END-PERFORM     
      *
           .
       2001-RIHA-COMMENT-EXT.
           EXIT.
