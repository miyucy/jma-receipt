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
       PROGRAM-ID.             ORCR0040.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト
      *  コンポーネント名  : レセプトコメント編集
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/04/23    MCC-小豆沢    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-門脇    02.11.28  同日複数再診、電話再診の
      *                                     コメント差込み
      *  01.00.02    NACL-門脇    02.11.29  複数診療科受診の
      *                                     コメント差込み
      *  01.00.03    NACL-門脇    03.02.04  剤まとめ対応等
      *  01.00.04    NACL-門脇    03.02.06  コメントカウントフラグでの
      *                                     判定追加
      *  01.00.05    NACL-藤原    03.03.12  補助区分の追加
      *  01.00.06    NACL-門脇    03.03.03  剤番号桁修正対応
      *  01.00.07    NACL-門脇    03.03.12  ＣＴ・ＭＲＩの実施日追加
      *  01.00.08    NACL-門脇    03.04.04  傷病手当金意見書交付料の交付日編集
      *                                     療養費同意書交付料の交付日編集
      *  01.00.09    NACL-門脇    03.04.24  輸血はコメント編集対象外とする
      *  01.00.10    NACL-門脇    03.05.28  受診履歴キーの変更
      *  01.00.11    NACL-門脇    03.06.19  複数診療科受診の編集修正
      *  01.00.12    NACL-門脇    03.07.15  乳幼児・幼児のコメント編集
      *  01.00.13    NACL-門脇    03.08.20  公費受診日のコメント編集
      *  01.00.14    NACL-門脇    03.09.24  コメント編集修正
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    レセプト０２データ
           SELECT  RECE02-FILE     ASSIGN  RECE01PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE02-KEY
                                   FILE    STATUS  IS  STS-RECE02.
      *    レセプト０４データ（ＩＮ）
           SELECT  RECE04-FILE     ASSIGN  RECE04PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE04-KEY
                                   FILE    STATUS  IS  STS-RECE04.
      *    レセプト０５データ（ＩＮ）
           SELECT  RECE05-FILE     ASSIGN  RECE05PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE05-KEY
                                   FILE    STATUS  IS  STS-RECE05.
      *    レセプト０４データ（ＯＵＴ）
           SELECT  RECE041-FILE    ASSIGN  RECE041PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE041-KEY
                                   FILE    STATUS  IS  STS-RECE041.
           SELECT  RECE0441-FILE   ASSIGN  RECE041PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE0441-KEY
                                   FILE    STATUS  IS  STS-RECE041.
      *    レセプト０５データ（ＯＵＴ）
           SELECT  RECE051-FILE    ASSIGN  RECE051PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE051-KEY
                                   FILE    STATUS  IS  STS-RECE051.
           SELECT  RECE0551-FILE   ASSIGN  RECE051PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE0551-KEY
                                   FILE    STATUS  IS  STS-RECE051.
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    レセプト０２データ
       FD  RECE02-FILE.
       01  RECE02-REC.
           COPY    "CPRCF002.INC".
      *
      *    レセプト０４データ
       FD  RECE04-FILE.
       01  RECE04-REC.
           COPY    "CPRCF004.INC".
      *
      *    レセプト０５データ
       FD  RECE05-FILE.
       01  RECE05-REC.
           COPY    "CPRCF005.INC".
      *
       FD  RECE041-FILE.
       01  RECE041-REC. 
           COPY    "CPRCF004.INC"  REPLACING   //RECE04//
                                   BY          //RECE041//.
      *
       FD  RECE051-FILE.
       01  RECE051-REC. 
           COPY    "CPRCF005.INC"  REPLACING   //RECE05//
                                   BY          //RECE051//.
      *
       FD  RECE0441-FILE.
       01  RECE0441-REC. 
           COPY    "CPRCF004.INC"  REPLACING   //RECE04//
                                   BY          //RECE0441//.
      *
       FD  RECE0551-FILE.
       01  RECE0551-REC. 
           COPY    "CPRCF005.INC"  REPLACING   //RECE05//
                                   BY          //RECE0551//.
      *
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC".
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE04//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE05//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE041//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE051//.
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
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECE02          PIC X(02).
           03  STS-RECE04          PIC X(02).
           03  STS-RECE041         PIC X(02).
           03  STS-RECE05          PIC X(02).
           03  STS-RECE051         PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-RECE02          PIC 9(01).
           03  FLG-RECE04          PIC 9(01).
           03  FLG-RECE05          PIC 9(01).
           03  FLG-WRKRECE05       PIC 9(01).
           03  FLG-SHIDOU-COMMENT  PIC 9(01).
           03  FLG-COMMENT         PIC 9(02).
           03  FLG-SANTEI          PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-JYURRK          PIC 9(01).
           03  FLG-FIRST           PIC 9(01).
           03  FLG-ARI             PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-RECE02          PIC 9(06).
           03  CNT-RECE04          PIC 9(06).
           03  CNT-RECE05          PIC 9(06).
           03  CNT-JINZOU          PIC 9(06).
           03  CNT-RIHA            PIC 9(06).
           03  CNT-JUSHIN          PIC 9(06).
           03  CNT-SANTEIKA        PIC 9(06).
           03  CNT-IN-COMMIT       PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  DAY-IDX             PIC 9(04).
           03  DAY-IDX2            PIC 9(02).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDX-RECE05          PIC 9(04).
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
           03  WRK-ZAINUM          PIC 9(08).
           03  WRK-RECEERR         PIC X(200).
      *
           03  TBL-SANTEI-DAY.
               05  TB-SANTEI-DAY     PIC 9(02)   OCCURS  31.
      *
           03  WRK-HKNCOMBINUMX      PIC X(04).
           03  WRK-HKNCOMBINUM9      REDEFINES  WRK-HKNCOMBINUMX
                                     PIC 9(04).
      *
           03  WRK-SRYYMDX.
               05  WRK-SRYYM         PIC 9(06).
               05  WRK-SRYDD         PIC 9(02).
      *
           03  WRK-SRYCD             PIC X(09).
      *
       01  WRK-RECE04-REC. 
           COPY    "CPRCF004.INC"  REPLACING   //RECE04//
                                   BY          //WRK-RECE04//.
      *
       01  WRK-RECE05-REC. 
           COPY    "CPRCF005.INC"  REPLACING   //RECE05//
                                   BY          //WRK-RECE05//.
      *
       01  COM-RECE05-REC. 
           COPY    "CPRCF005.INC"  REPLACING   //RECE05//
                                   BY          //COM//.
      *
       01  WRK-SRYACTINF-AREA.
           03  WRK-SRYACTINF                   OCCURS  50.
               05  WK-RECE05-SRYCD           PIC  X(09).
               05  WK-RECE05-SRYSURYO        PIC  9(05)V9(03).
               05  WK-RECE05-SRYKAISU        PIC  9(03).
               05  WK-RECE05-TANICD          PIC  9(03).
               05  WK-RECE05-TANIMOJISU      PIC  9(01).
               05  WK-RECE05-TANINAME        PIC  X(24).
               05  WK-RECE05-TENSIKIBETU     PIC  9(01).
               05  WK-RECE05-TEN             PIC  9(09)V9(02).
               05  WK-RECE05-MEISKYFLG       PIC  X(01).
               05  WK-RECE05-AUTOKBN         PIC  X(01).
               05  WK-RECE05-INPUTNUM        PIC  9(03).
               05  WK-RECE05-TENTTLKBN       PIC  9(03).
      *
       01  WRK-NAMEINF-AREA.
           03  WRK-NAMEINF                     OCCURS 50.         
               05  WK-RECE05-YUKOKETA        PIC  9(02).
               05  WK-RECE05-NAME            PIC  X(200).
      *
       01  WRK-DATAKBNINF-AREA.
           03  WRK-DATAKBNINF                  OCCURS 50.         
               05  WK-RECE05-DATAKBN         PIC  9(01).
      *
       01  WRK-FREE-AREA.
           03  WRK-FREEINF                     OCCURS 49.         
               05  WK-FREE-YUKOKETA          PIC  9(02).
               05  WK-FREE-NAME              PIC  X(200).
      *
       01  WRK-FREE-AREA2.                                              
           03  WRK-FREEINF2                    OCCURS 50.               
               05  WK-FREE-YUKOKETA2         PIC  9(02).                
               05  WK-FREE-NAME2             PIC  X(200).               
      *
      *理学療法剤番号退避領域
       01  WRK-TAIHI-ZAINUM.
           03  WRK-TAIHI-ZAINUM-T              OCCURS  5.
               05  WRK-RIGA1-SHU-ZAINUM      PIC  9(08).   
               05  WRK-RIGA1-KO-ZAINUM       PIC  9(08).   
               05  WRK-RIGA2-SHU-ZAINUM      PIC  9(08).   
               05  WRK-RIGA2-KO-ZAINUM       PIC  9(08).   
               05  WRK-RIGA3-SHU-ZAINUM      PIC  9(08).   
               05  WRK-RIGA3-KO-ZAINUM       PIC  9(08).   
               05  WRK-RIGA4-SHU-ZAINUM      PIC  9(08).   
               05  WRK-RIGA4-KO-ZAINUM       PIC  9(08).   
               05  WRK-SAGYO1-SHU-ZAINUM     PIC  9(08).   
               05  WRK-SAGYO2-SHU-ZAINUM     PIC  9(08).   
               05  WRK-SAGYO1-KO-ZAINUM      PIC  9(08).   
               05  WRK-SAGYO2-KO-ZAINUM      PIC  9(08).   
               05  WRK-GENGO1-SHU-ZAINUM     PIC  9(08).   
               05  WRK-GENGO1-KO-ZAINUM      PIC  9(08).   
               05  WRK-GENGO2-SHU-ZAINUM     PIC  9(08).   
               05  WRK-GENGO2-KO-ZAINUM      PIC  9(08).   
      *
       01  WRK-TAIHI-ZAINUM-R     REDEFINES   WRK-TAIHI-ZAINUM.
           03  WRK-RIHA-ZAINUM-T               OCCURS  5.
               05  WRK-RIHA-ZAINUM   PIC 9(08)   OCCURS   16.       
      *
      *
      *人工腎臓実施カレンダー
       01  WRK-JINZOU-AREA.
           03  WRK-JINZOU-T                    OCCURS   5.
             05  WRK-JINZOU                    PIC  X(01)  OCCURS 31.   
             05  WRK-JINZOU-HKNCOMBI           PIC  9(04).
      *
      *再診４回目以降実施カレンダー
       01  WRK-SAISHIN4-AREA.
           03  WRK-SAISHIN4-T                  OCCURS   5.
             05  WRK-SAISHIN4                  PIC  X(01)  OCCURS 31.   
      *
      *理学療法実施カレンダー
       01  WRK-RIGAKU-AREA.
           03  WRK-RIGAKU-T                    OCCURS  5.
             05  WRK-RIGA1-SHU                 PIC  X(01)  OCCURS 31.   
             05  WRK-RIGA1-KO                  PIC  X(01)  OCCURS 31.   
             05  WRK-RIGA2-SHU                 PIC  X(01)  OCCURS 31.   
             05  WRK-RIGA2-KO                  PIC  X(01)  OCCURS 31.   
             05  WRK-RIGA3-SHU                 PIC  X(01)  OCCURS 31.   
             05  WRK-RIGA3-KO                  PIC  X(01)  OCCURS 31.   
             05  WRK-RIGA4-SHU                 PIC  X(01)  OCCURS 31.   
             05  WRK-RIGA4-KO                  PIC  X(01)  OCCURS 31.   
             05  WRK-SAGYO1-SHU                PIC  X(01)  OCCURS 31.   
             05  WRK-SAGYO2-SHU                PIC  X(01)  OCCURS 31.   
             05  WRK-SAGYO1-KO                 PIC  X(01)  OCCURS 31.   
             05  WRK-SAGYO2-KO                 PIC  X(01)  OCCURS 31.   
             05  WRK-GENGO1-SHU                PIC  X(01)  OCCURS 31.   
             05  WRK-GENGO1-KO                 PIC  X(01)  OCCURS 31.   
             05  WRK-GENGO2-SHU                PIC  X(01)  OCCURS 31.   
             05  WRK-GENGO2-KO                 PIC  X(01)  OCCURS 31.   
      *
       01  WRK-RIGAKU-R        REDEFINES     WRK-RIGAKU-AREA.
           02  WRK-RIGAKU-OCC                  OCCURS    5.
             03  WRK-RIGAKU-OCC2               OCCURS   16.
               04  WRK-RIGAKU-OCC3             OCCURS   31.
                 05  WRK-RIGAKU                PIC  X(01).
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
      *    慢性とう痛疾患
           03  CONS-MANSEI          PIC X(09) VALUE "113006510".
      *    初診料算定科：
           03  CONS-SYOSINSANTEIKA  PIC X(09) VALUE "830000020".
      *    再診料算定科：
           03  CONS-SAISINSANTEIKA  PIC X(09) VALUE "830000021".
      *
      *
      *   再診（４回目以降／人工腎臓）診療行為テーブル
       01  TBL-JINSAI4-AREA.
           03  FILLER          PIC X(09)   VALUE   "112009510".
           03  FILLER          PIC X(09)   VALUE   "112009610".
           03  FILLER          PIC X(09)   VALUE   "112012610".
           03  FILLER          PIC X(09)   VALUE   "112704010".
           03  FILLER          PIC X(09)   VALUE   "112706610".
           03  FILLER          PIC X(09)   VALUE   "112010450".
           03  FILLER          PIC X(09)   VALUE   "112010550".
           03  FILLER          PIC X(09)   VALUE   "112704750".
           03  FILLER          PIC X(09)   VALUE   "112007710".
           03  FILLER          PIC X(09)   VALUE   "112007810".
           03  FILLER          PIC X(09)   VALUE   "112012310".
           03  FILLER          PIC X(09)   VALUE   "112702610".
           03  FILLER          PIC X(09)   VALUE   "112706310".
           03  FILLER          PIC X(09)   VALUE   "112008650".
           03  FILLER          PIC X(09)   VALUE   "112008750".
           03  FILLER          PIC X(09)   VALUE   "112703350".
      *
       01  TBL-JINSAI4-R       REDEFINES   TBL-JINSAI4-AREA.
            03  TBL-JINSAI4    PIC X(09)   OCCURS  16.       
      *
       01  TBL-JINSAI4-MAX     PIC 9(02)   VALUE   16.  
      *
      *
      *   人工腎臓診療行為テーブル
       01  TBL-JINZOU-AREA.
           03  FILLER          PIC X(09)   VALUE    "140036710".
           03  FILLER          PIC X(09)   VALUE    "140007710".
      *
       01  TBL-JINZOU-R        REDEFINES   TBL-JINZOU-AREA.
            03  TBL-JINZOU     PIC X(09)   OCCURS   2.       
      *
       01  TBL-JINZOU-MAX      PIC 9(02)   VALUE    2.  
      *
      *
      *   リハビリ診療行為テーブル
       01  TBL-RIHA-AREA.
           03  FILLER          PIC X(09)   VALUE    "180706910".
           03  FILLER          PIC X(09)   VALUE    "180022210".
           03  FILLER          PIC X(09)   VALUE    "180706810".
           03  FILLER          PIC X(09)   VALUE    "180022110".
           03  FILLER          PIC X(09)   VALUE    "180707110".
           03  FILLER          PIC X(09)   VALUE    "180022410".
           03  FILLER          PIC X(09)   VALUE    "180707010".
           03  FILLER          PIC X(09)   VALUE    "180022310".
           03  FILLER          PIC X(09)   VALUE    "180707310".
           03  FILLER          PIC X(09)   VALUE    "180022610".
           03  FILLER          PIC X(09)   VALUE    "180707210".
           03  FILLER          PIC X(09)   VALUE    "180022510".
           03  FILLER          PIC X(09)   VALUE    "180707510".
           03  FILLER          PIC X(09)   VALUE    "180022810".
           03  FILLER          PIC X(09)   VALUE    "180707410".
           03  FILLER          PIC X(09)   VALUE    "180022710".
           03  FILLER          PIC X(09)   VALUE    "180708210".
           03  FILLER          PIC X(09)   VALUE    "180023710".
           03  FILLER          PIC X(09)   VALUE    "180708410".
           03  FILLER          PIC X(09)   VALUE    "180023910".
           03  FILLER          PIC X(09)   VALUE    "180708110".
           03  FILLER          PIC X(09)   VALUE    "180023610".
           03  FILLER          PIC X(09)   VALUE    "180708310".
           03  FILLER          PIC X(09)   VALUE    "180023810".
           03  FILLER          PIC X(09)   VALUE    "180024910".
           03  FILLER          PIC X(09)   VALUE    "180024810".
           03  FILLER          PIC X(09)   VALUE    "180025110".
           03  FILLER          PIC X(09)   VALUE    "180025010".
      *
       01  TBL-RIHA-R          REDEFINES   TBL-RIHA-AREA.
            03  TBL-RIHA       PIC X(09)   OCCURS   28.       
      *
       01  TBL-RIHA-MAX        PIC 9(02)   VALUE    28.  
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
      *    電話等再診（病院）(１回目）
           03  FILLER          PIC X(09)   VALUE   "112007950".
      *    電話等再診（病院）(２回目又は３回目）
           03  FILLER          PIC X(09)   VALUE   "112008050".
      *    電話等再診（病院）(４回目以降）
           03  FILLER          PIC X(09)   VALUE   "112008150".
      *    電話等再診（病院）(４回目以降）（１５歳未満）
           03  FILLER          PIC X(09)   VALUE   "112008250".
      *    電話等再診（病院）(４回目以降）（厚生労働大臣が定める者）
           03  FILLER          PIC X(09)   VALUE   "112012450".
      *    老：電話等再診（病院）(１回目）
           03  FILLER          PIC X(09)   VALUE   "112702750".
      *    老：電話等再診（病院）(２回目又は３回目）
           03  FILLER          PIC X(09)   VALUE   "112702850".
      *    老：電話等再診（病院）(４回目以降）
           03  FILLER          PIC X(09)   VALUE   "112702950".
      *    老：電話等再診（病院）(４回目以降）（厚生労働大臣が定める者）
           03  FILLER          PIC X(09)   VALUE   "112706450".
      *    同日電話等再診（病院）(１回目）
           03  FILLER          PIC X(09)   VALUE   "112008850".
      *    同日電話等再診（病院）(２回目又は３回目）
           03  FILLER          PIC X(09)   VALUE   "112008950".
      *    同日電話等再診（病院）(４回目以降）
           03  FILLER          PIC X(09)   VALUE   "112009050".
      *    同日電話等再診（病院）(４回目以降）（１５歳未満）
           03  FILLER          PIC X(09)   VALUE   "112009150".
      *    同日電話等再診（病院）(４回目以降）（厚生労働大臣が定める者）
           03  FILLER          PIC X(09)   VALUE   "112012550".
      *    老：同日電話等再診（病院）(１回目）
           03  FILLER          PIC X(09)   VALUE   "112703450".
      *    老：同日電話等再診（病院）(２回目又は３回目）
           03  FILLER          PIC X(09)   VALUE   "112703550".
      *    老：同日電話等再診（病院）(４回目以降）
           03  FILLER          PIC X(09)   VALUE   "112703650".
      *    老：同日電話等再診（病院）(４回目以降）（厚生労働大臣が定める者）
           03  FILLER          PIC X(09)   VALUE   "112706550".
      *
       01  TBL-DENWA-R         REDEFINES   TBL-DENWA-AREA.
            03  TBL-DENWA      PIC X(09)   OCCURS   36.       
      *
       01  TBL-DENWA-MAX       PIC 9(02)   VALUE    36.  
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
      *    同日電話等再診（病院）(１回目）
           03  FILLER          PIC X(09)   VALUE   "112008850".
      *    同日電話等再診（病院）(２回目又は３回目）
           03  FILLER          PIC X(09)   VALUE   "112008950".
      *    同日電話等再診（病院）(４回目以降）
           03  FILLER          PIC X(09)   VALUE   "112009050".
      *    同日電話等再診（病院）(４回目以降）（１５歳未満）
           03  FILLER          PIC X(09)   VALUE   "112009150".
      *    同日電話等再診（病院）(４回目以降）（厚生労働大臣が定める者）
           03  FILLER          PIC X(09)   VALUE   "112012550".
      *    老：同日電話等再診（病院）(１回目）
           03  FILLER          PIC X(09)   VALUE   "112703450".
      *    老：同日電話等再診（病院）(２回目又は３回目）
           03  FILLER          PIC X(09)   VALUE   "112703550".
      *    老：同日電話等再診（病院）(４回目以降）
           03  FILLER          PIC X(09)   VALUE   "112703650".
      *    老：同日電話等再診（病院）(４回目以降）（厚生労働大臣が定める者）
           03  FILLER          PIC X(09)   VALUE   "112706550".
      *    同日再診（病院）(１回目）
           03  FILLER          PIC X(09)   VALUE   "112008350".
      *    同日再診（病院）(２回目又は３回目）
           03  FILLER          PIC X(09)   VALUE   "112008450".
      *    同日再診（病院）(４回目以降）
           03  FILLER          PIC X(09)   VALUE   "112008550".
      *    同日再診（病院）(４回目以降）（１５歳未満）
           03  FILLER          PIC X(09)   VALUE   "112008650".
      *    同日再診（病院）(４回目以降）（厚生労働大臣が定める者）
           03  FILLER          PIC X(09)   VALUE   "112008750".
      *    老：同日再診（病院）(１回目）
           03  FILLER          PIC X(09)   VALUE   "112703050".
      *    老：同日再診（病院）(２回目又は３回目）
           03  FILLER          PIC X(09)   VALUE   "112703150".
      *    老：同日再診（病院）(４回目以降）
           03  FILLER          PIC X(09)   VALUE   "112703250".
      *    老：同日再診（病院）(４回目以降）（厚生労働大臣が定める者）
           03  FILLER          PIC X(09)   VALUE   "112703350".
      *
       01  TBL-DOUJITU-R       REDEFINES   TBL-DOUJITU-AREA.
            03  TBL-DOUJITU    PIC X(09)   OCCURS   36.       
      *
       01  TBL-DOUJITU-MAX     PIC 9(02)   VALUE    36.  
      *
      *    複数診療科受診の退避テーブル
       01  TBL-JUSHIN-INF.
           03  TBL-JUSHIN-INF2      OCCURS    50.
               05  TBL-JUSHIN-SRYKA       PIC X(02).
               05  TBL-JUSHIN-SRYKANAME   PIC X(80).
               05  TBL-JUSHIN-ARI         PIC X(01).
               05  TBL-JUSHIN-DAY         PIC X(01)   OCCURS  31.
      *
       01  TBL-COUNT-INF.
           03  TBL-COUNT-INF2       OCCURS     5.
               05  CNT-DENWA              PIC 9(06).
               05  CNT-DOUJITU            PIC 9(06).
               05  TBL-COUNT-HKNCOMBI     PIC 9(04).
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
           MOVE    "ORCR0040"      TO  JOB-PGID
           MOVE    "コメント編集"    TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 990-RECE02-READ-SEC
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
           MOVE    "RECE020"           TO  RECE01PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE01PARA-TERMID
      *
           MOVE    "RECE04W"           TO  RECE04PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE04PARA-TERMID
      *
           MOVE    "RECE050"           TO  RECE05PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE05PARA-TERMID
      *
           MOVE    "RECE041"           TO  RECE041PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE041PARA-TERMID
      *
           MOVE    "RECE051"           TO  RECE051PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE051PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
           OPEN    INPUT               RECE02-FILE
      *
           OPEN    INPUT               RECE04-FILE
      *
           OPEN    INPUT               RECE05-FILE
      *
           OPEN    OUTPUT              RECE0441-FILE
           CLOSE                       RECE0441-FILE
      *
           OPEN    OUTPUT              RECE0551-FILE
           CLOSE                       RECE0551-FILE
      *
           OPEN    OUTPUT              RECE041-FILE
      *
           OPEN    OUTPUT              RECE051-FILE
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
           MOVE       ZERO             TO  CNT-SANTEIKA
           INITIALIZE                      TBL-COUNT-INF
           INITIALIZE                      WRK-SAISHIN4-AREA
           INITIALIZE                      WRK-JINZOU-AREA
           INITIALIZE                      WRK-RIGAKU-AREA
           INITIALIZE                      WRK-TAIHI-ZAINUM
      *
           IF   RECE02-COMCNTFLG   =   "1"
      *
             INITIALIZE                      RECE04-REC
             MOVE    RECE02-HOSPID       TO  RECE04-HOSPID
             MOVE    RECE02-SRYYM        TO  RECE04-SRYYM
             MOVE    RECE02-NYUGAIKBN    TO  RECE04-NYUGAIKBN
             MOVE    RECE02-PTID         TO  RECE04-PTID
             MOVE    RECE02-RECEKA       TO  RECE04-RECEKA
             MOVE    RECE02-TEISYUTUSAKI TO  RECE04-TEISYUTUSAKI
             MOVE    RECE02-RECESYUBETU  TO  RECE04-RECESYUBETU
             MOVE    RECE02-HKNJANUM-KEY TO  RECE04-HKNJANUM
             MOVE    RECE02-HOJOKBN-KEY  TO  RECE04-HOJOKBN
             MOVE    RECE02-TEKSTYMD     TO  RECE04-TEKSTYMD
             MOVE    ZERO                TO  RECE04-ZAINUM
      *
             START   RECE04-FILE
                 KEY IS    >=   RECE04-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE04
                 NOT INVALID
                     PERFORM 990-RECE04-NEXT-SEC
             END-START
             PERFORM
               UNTIL  ( FLG-RECE04           =   1                   )
               OR     ( RECE02-HOSPID    NOT =   RECE04-HOSPID       )
               OR     ( RECE02-SRYYM     NOT =   RECE04-SRYYM        )
               OR     ( RECE02-NYUGAIKBN NOT =   RECE04-NYUGAIKBN    )
               OR     ( RECE02-PTID      NOT =   RECE04-PTID         )
               OR     ( RECE02-RECEKA    NOT =   RECE04-RECEKA       )
               OR     ( RECE02-TEISYUTUSAKI
                                         NOT =   RECE04-TEISYUTUSAKI )
               OR     ( RECE02-RECESYUBETU
                                         NOT =   RECE04-RECESYUBETU  )
               OR     ( RECE02-HKNJANUM-KEY
                                         NOT =   RECE04-HKNJANUM     )
               OR     ( RECE02-HOJOKBN-KEY
                                         NOT =   RECE04-HOJOKBN      )
               OR     ( RECE02-TEKSTYMD  NOT =   RECE04-TEKSTYMD     )
      *
               EVALUATE      RECE04-SRYKBN
                   WHEN      "11"
      *            （初診料算定科：のカウント）
                      MOVE    CONS-SYOSINSANTEIKA  TO  WRK-SRYCD
                      PERFORM    2001-SANTEIKA-COUNT-SEC
                   WHEN      "12"
      *            （再診料算定科：のカウント）
                      MOVE    CONS-SAISINSANTEIKA  TO  WRK-SRYCD
                      PERFORM    2001-SANTEIKA-COUNT-SEC
      *
      *            （電話再診のカウント）
                      PERFORM    2001-DENWA-COUNT-SEC
      *            （同日再診のカウント）
                      PERFORM    2001-DOUJITU-COUNT-SEC
      *
      *            （再診４回目のカウント）
                      PERFORM    2001-SAISHIN4-COUNT-SEC
                   WHEN      "40"
      *            （人工腎臓のカウント）
                      PERFORM    2001-JINZOU-COUNT-SEC
                   WHEN      "80"
      *            （リハビリのカウント）
                      PERFORM    2001-RIHA-COUNT-SEC
               END-EVALUATE
      *
               PERFORM 990-RECE04-NEXT-SEC
      *
             END-PERFORM
      *
           END-IF
      *
      ******
      *
      *    乳幼児・幼児のコメント
      *
           IF   RECE02-NYUYOJIFLG   NOT =   SPACE
      *
              PERFORM   2001-NYUYOJI-COMMENT-SEC
      *
           END-IF
      *
      *    公費受診日のコメント
      *
           IF   RECE02-KOHJNISSUTBLINF    =   ALL " "
              CONTINUE
           ELSE
              PERFORM   2001-KOHJYUSIN-COMMENT-SEC
           END-IF
      *
      *    複数診療科受診
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
             MOVE    RECE02-SRYYM        TO  ORC-DBYMD(1:6)
             MOVE    "01"                TO  ORC-DBYMD(7:2)
             CALL    "ORCMCPSUB"         USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
             IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"  TO  ORC-DBPATH 
               PERFORM   SYSKANRI-READ-SEC
               PERFORM   VARYING   IDX    FROM   1   BY   1
                          UNTIL   (IDX             >      50)
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
             INITIALIZE                        MCPAREA
             MOVE    "DBCLOSE"         TO      MCP-FUNC
             MOVE    "SYSKANRI-KEY2"   TO      ORC-DBPATH
             CALL    "ORCMCPSUB"       USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
      *      複数の診療科受診があるか判定
             MOVE       ZERO       TO   IDZ  
             INITIALIZE            WRK-FREE-AREA
      *
             PERFORM   VARYING   IDX    FROM   1   BY   1
                            UNTIL   (IDX             >      50)
               IF   TBL-JUSHIN-ARI (IDX)  =  "1"
                   ADD       1     TO   CNT-JUSHIN
                   PERFORM  2001-FREE-COMMENT-SEC
               END-IF
             END-PERFORM
      *      複数診療科受診のコメント編集
             IF    CNT-JUSHIN  >   1
                    PERFORM   2001-JUSHIN-COMMENT-SEC
             END-IF
      *
           END-IF
      *
      *    電話再診・同日複数再診
      *
           PERFORM   VARYING   IDX    FROM   1   BY   1
                          UNTIL   (IDX             >      5)
      *
              IF         CNT-DENWA(IDX)     >   ZERO
              AND        CNT-DOUJITU(IDX)   >   ZERO
                         PERFORM    2001-DENWA-DOUJITU-COMMENT-SEC
              ELSE
                  IF         CNT-DENWA(IDX)     >   ZERO
                  AND        CNT-DOUJITU(IDX)   =   ZERO
                         PERFORM    2001-DENWA-COMMENT-SEC
                  ELSE
                      IF         CNT-DENWA(IDX)     =   ZERO
                      AND        CNT-DOUJITU(IDX)   >   ZERO
                         PERFORM    2001-DOUJITU-COMMENT-SEC
                      END-IF
                  END-IF
              END-IF
      *
           END-PERFORM
      *
      *    人工腎臓の判定
      *
           PERFORM    2001-JINZOU-HANTEI-SEC
      *
      *
      *    パラメータ０４ファイルより編集
           INITIALIZE                      RECE04-REC
           MOVE    RECE02-HOSPID       TO  RECE04-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE04-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE04-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE04-PTID
           MOVE    RECE02-RECEKA       TO  RECE04-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE04-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE04-RECESYUBETU
           MOVE    RECE02-HKNJANUM-KEY TO  RECE04-HKNJANUM
           MOVE    RECE02-HOJOKBN-KEY  TO  RECE04-HOJOKBN
           MOVE    RECE02-TEKSTYMD     TO  RECE04-TEKSTYMD
           MOVE    ZERO                TO  RECE04-ZAINUM
      *
           START   RECE04-FILE
               KEY IS    >=   RECE04-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE04
               NOT INVALID
                   PERFORM 990-RECE04-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( FLG-RECE04           =   1                   )
               OR     ( RECE02-HOSPID    NOT =   RECE04-HOSPID       )
               OR     ( RECE02-SRYYM     NOT =   RECE04-SRYYM        )
               OR     ( RECE02-NYUGAIKBN NOT =   RECE04-NYUGAIKBN    )
               OR     ( RECE02-PTID      NOT =   RECE04-PTID         )
               OR     ( RECE02-RECEKA    NOT =   RECE04-RECEKA       )
               OR     ( RECE02-TEISYUTUSAKI
                                         NOT =   RECE04-TEISYUTUSAKI )
               OR     ( RECE02-RECESYUBETU
                                         NOT =   RECE04-RECESYUBETU  )
               OR     ( RECE02-HKNJANUM-KEY
                                         NOT =   RECE04-HKNJANUM     )
               OR     ( RECE02-HOJOKBN-KEY
                                         NOT =   RECE04-HOJOKBN      )
               OR     ( RECE02-TEKSTYMD  NOT =   RECE04-TEKSTYMD     )
      *
               EVALUATE      RECE04-SRYKBN
                   WHEN      "13"
                      MOVE   ZERO   TO  FLG-COMMENT
      *            （慢性疼痛疾患管理料算定日のセット）
                      IF   FLG-COMMENT  =  ZERO
                         PERFORM    2001-SHIDOU-HANTEI-SEC
                      END-IF
      *            （傷病手当金意見書交付料交付日のセット）
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-SYOBYO-HANTEI-SEC
                      END-IF
      *            （療養費同意書交付料交付日のセット）
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-RYOYO-HANTEI-SEC
                      END-IF
                      IF   FLG-COMMENT  =  ZERO
                         MOVE       RECE04-REC    TO   RECE041-REC
                         WRITE      RECE041-REC
                         ADD     1          TO      CNT-RECE04
                         PERFORM    2001-RECE05-TENSOU-SEC
                      END-IF
                   WHEN      "50"
      *            （手術日のセット）
                      PERFORM    2001-SHUJUTSU-HANTEI-SEC
                   WHEN      "70"
      *            （ＣＴ・ＭＲＩ実施日のセット）
                      PERFORM    2001-CTMRI-HANTEI-SEC
                   WHEN      "80"
      *            （リハビリのセット）
                      COMPUTE  WRK-KOHBUNRI 
                                 =    RECE04-KOHBUNRI  +  1
                      MOVE    ZERO     TO    FLG-ARI
                      PERFORM   VARYING   IDX    FROM   1   BY   1
                            UNTIL   (IDX             >      16)
                             OR     (FLG-ARI         =       1)
                          IF  RECE04-ZAINUM  =  
                                   WRK-RIHA-ZAINUM(WRK-KOHBUNRI IDX)
                              MOVE    1    TO   FLG-ARI 
                          END-IF
                      END-PERFORM
                      IF  FLG-ARI  =  1
                          PERFORM   2001-RIHA-COMMENT-SEC
                      ELSE
                          MOVE       RECE04-REC    TO   RECE041-REC
                          WRITE      RECE041-REC
                          ADD     1          TO      CNT-RECE04
                          PERFORM    2001-RECE05-TENSOU-SEC
                      END-IF
                   WHEN   OTHER
                      MOVE       RECE04-REC    TO   RECE041-REC
                      WRITE      RECE041-REC
                      ADD     1          TO      CNT-RECE04
                      PERFORM    2001-RECE05-TENSOU-SEC
               END-EVALUATE
      *
               PERFORM 990-RECE04-NEXT-SEC
      *
           END-PERFORM
      *
      *
           PERFORM 990-RECE02-READ-SEC
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
      *    算定科：のカウント
      *****************************************************************
       2001-SANTEIKA-COUNT-SEC          SECTION.
      *
           INITIALIZE                          SRYACT-REC
           MOVE    RECE04-HOSPID       TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN    TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID         TO      SRY-PTID
           MOVE    RECE04-SRYYM        TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM       TO      SRY-ZAINUM
           MOVE    WRK-SRYCD           TO      SRY-SRYCD (1)
           MOVE    WRK-SRYCD           TO      SRY-SRYCD (2)
           MOVE    WRK-SRYCD           TO      SRY-SRYCD (3)
           MOVE    WRK-SRYCD           TO      SRY-SRYCD (4)
           MOVE    WRK-SRYCD           TO      SRY-SRYCD (5)
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
                   ADD   RECE04-ZAIKAISU  
                                 TO   CNT-SANTEIKA
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
       2001-SANTEIKA-COUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴テーブルから診療科毎の受診日を検索セット
      *****************************************************************
       2001-JUSHIN-KENSAKU-SEC             SECTION.
      *
      *    受診歴の検索
           INITIALIZE                      JYURRK-REC
           MOVE    RECE02-HOSPID       TO  JYURRK-HOSPID
           MOVE    RECE02-PTID         TO  JYURRK-PTID
           MOVE    RECE02-NYUGAIKBN    TO  JYURRK-NYUGAIKBN
           MOVE    TBL-JUSHIN-SRYKA(IDX)
                                       TO  JYURRK-SRYKA
           MOVE    RECE02-SRYYM        TO  JYURRK-SRYYMD(1:6)
           MOVE    "01"                TO  JYURRK-SRYYMD(7:2)
           MOVE    RECE02-SRYYM        TO  JYURRK-UPSRYYMD(1:6)
           MOVE    "31"                TO  JYURRK-UPSRYYMD(7:2)
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "JYURRK-KEY24"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING   MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "JYURRK-KEY24"  TO  ORC-DBPATH 
               PERFORM   JYURRK-READ-SEC
               PERFORM   UNTIL   FLG-JYURRK   =    1
                   IF    JYURRK-HKNKBN    =       "0"
                      MOVE   JYURRK-HKNCOMBINUM
                                       TO  WRK-HKNCOMBINUMX
                      IF  WRK-HKNCOMBINUM9  =  RECE02-HKNCOMBI(1) OR
                                               RECE02-HKNCOMBI(2) OR
                                               RECE02-HKNCOMBI(3) OR
                                               RECE02-HKNCOMBI(4) OR
                                               RECE02-HKNCOMBI(5) OR
                                               RECE02-HKNCOMBI(6) OR
                                               RECE02-HKNCOMBI(7) OR
                                               RECE02-HKNCOMBI(8) OR
                                               RECE02-HKNCOMBI(9) OR
                                               RECE02-HKNCOMBI(10)
                            MOVE   JYURRK-SRYYMD   TO   WRK-SRYYMDX
                            IF   RECE02-JNISSUTBL(WRK-SRYDD) = SPACE
                               CONTINUE
                            ELSE
                               MOVE   "1"     TO    
                                        TBL-JUSHIN-ARI (IDX)
                               MOVE   "1"     TO    
                                        TBL-JUSHIN-DAY (IDX WRK-SRYDD)
                            END-IF
                      END-IF      
                   END-IF
      *
                   MOVE    "JYURRK-KEY24"  TO  ORC-DBPATH 
                   PERFORM   JYURRK-READ-SEC
               END-PERFORM
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "JYURRK-KEY24"    TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           .
       2001-JUSHIN-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    複数診療科受診の科・日付の編集
      *****************************************************************
       2001-FREE-COMMENT-SEC          SECTION.
      *
           ADD      1                      TO  IDZ
           MOVE     ZERO                   TO  WRK-KETA
                                               WRK-KETA-TAIHI
                                               WRK-KETA2
      *
           IF  TBL-JUSHIN-SRYKANAME(IDX)  NOT =  SPACE
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
                          PERFORM  2001-FREE-COMMENT-KAIGYO-SEC
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
                          PERFORM  2001-FREE-COMMENT-KAIGYO-SEC
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
                          PERFORM  2001-FREE-COMMENT-KAIGYO-SEC
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
                          PERFORM  2001-FREE-COMMENT-KAIGYO-SEC
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
       2001-FREE-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    複数診療科受診の科・日付の編集（改行）
      *****************************************************************
       2001-FREE-COMMENT-KAIGYO-SEC          SECTION.
      *
           ADD      1              TO  IDZ
      *
           MOVE    WRK-KETA-TAIHI  TO  WRK-KETA
           MOVE    WRK-KETA2       TO  WK-FREE-YUKOKETA(IDZ)
           MOVE    ALL "　"        TO  WK-FREE-NAME(IDZ)(1:WRK-KETA)
      *
           .
       2001-FREE-COMMENT-KAIGYO-EXT.
           EXIT.
      *
      *****************************************************************
      *    複数診療科受診のコメント編集
      *****************************************************************
       2001-JUSHIN-COMMENT-SEC          SECTION.
      *
      *    ＲＥＣＥ０５ファイルの内容をテーブルに退避
           MOVE    ZERO                TO  IDX-RECE05
           MOVE    SPACE               TO  WRK-SRYACTINF-AREA
           INITIALIZE                      WRK-SRYACTINF-AREA
           MOVE    SPACE               TO  WRK-NAMEINF-AREA
           INITIALIZE                      WRK-NAMEINF-AREA
      *
           ADD     1                   TO  IDX-RECE05
           MOVE    SPACE               TO  COM-RECE05-REC
           INITIALIZE                      COM-RECE05-REC
           MOVE    "810000001"         TO  COM-SRYCD(1)
           MOVE    ZERO                TO  COM-SRYSURYO(1)
           MOVE    7                   TO  COM-YUKOKETA(1)
           MOVE    "複数診療科受診"    TO  COM-NAME(1)
           MOVE    COM-SRYACTINF(1)    TO  WRK-SRYACTINF
                                               (IDX-RECE05)
           MOVE    COM-NAMEINF(1)      TO  WRK-NAMEINF
                                               (IDX-RECE05)
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX               >   49    )
                         OR      ( WK-FREE-NAME(IDX) =   SPACE )
                ADD    1                  TO  IDX-RECE05
                MOVE   "810000001"        TO  COM-SRYCD(2)
                MOVE   ZERO               TO  COM-SRYSURYO(2)
                MOVE   COM-SRYACTINF(2)   TO  WRK-SRYACTINF(IDX-RECE05)
                MOVE   WRK-FREEINF(IDX)   TO  WRK-NAMEINF(IDX-RECE05)
           END-PERFORM 
      *
      *    科・日付の編集を含んだ内容で中間ファイルの再作成
           MOVE       ZERO             TO      FLG-WRKRECE05
           MOVE       ZERO             TO      IDX
           MOVE       ZERO             TO      IDX-RECE05
           MOVE       ZERO             TO      WRK-RENNUM
           MOVE       ZERO             TO      WRK-CNT-MEISAI
           PERFORM    UNTIL     FLG-WRKRECE05  =    1
                INITIALIZE                       RECE051-REC
                MOVE    RECE02-HOSPID        TO  RECE051-HOSPID
                MOVE    RECE02-SRYYM         TO  RECE051-SRYYM
                MOVE    RECE02-NYUGAIKBN     TO  RECE051-NYUGAIKBN
                MOVE    RECE02-PTID          TO  RECE051-PTID
                MOVE    RECE02-RECEKA        TO  RECE051-RECEKA
                MOVE    RECE02-TEISYUTUSAKI  TO  RECE051-TEISYUTUSAKI
                MOVE    RECE02-RECESYUBETU   TO  RECE051-RECESYUBETU
                MOVE    RECE02-HKNJANUM-KEY  TO  RECE051-HKNJANUM
                MOVE    RECE02-HOJOKBN-KEY   TO  RECE051-HOJOKBN
                MOVE    RECE02-TEKSTYMD      TO  RECE051-TEKSTYMD
      *         MOVE    ZERO                 TO  RECE051-ZAINUM
                MOVE    99999999             TO  RECE051-ZAINUM
                MOVE    "99"                 TO  RECE051-SRYKBN
                ADD     1                    TO  WRK-RENNUM
                MOVE    WRK-RENNUM           TO  RECE051-RENNUM
                PERFORM  VARYING   IDX   FROM   1   BY   1
                         UNTIL   (IDX       >    5)   OR
                                 (FLG-WRKRECE05   =   1)
                   ADD         1             TO    IDX-RECE05
                   IF  WK-RECE05-SRYCD(IDX-RECE05) = SPACE
                       MOVE    1             TO    FLG-WRKRECE05
                   ELSE
                       MOVE  WRK-SRYACTINF(IDX-RECE05)
                                        TO   RECE051-SRYACTINF(IDX)  
                       MOVE  WRK-NAMEINF(IDX-RECE05)
                                        TO   RECE051-NAMEINF(IDX)
                       ADD   1          TO   WRK-CNT-MEISAI
                   END-IF  
                END-PERFORM
                WRITE   RECE051-REC
                ADD     1                    TO  CNT-RECE05
           END-PERFORM     
      *
      *
           INITIALIZE                      RECE041-REC
           MOVE    RECE02-HOSPID       TO  RECE041-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE041-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE041-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE041-PTID
           MOVE    RECE02-RECEKA       TO  RECE041-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE041-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE041-RECESYUBETU
           MOVE    RECE02-HKNJANUM-KEY TO  RECE041-HKNJANUM
           MOVE    RECE02-HOJOKBN-KEY  TO  RECE041-HOJOKBN
           MOVE    RECE02-TEKSTYMD     TO  RECE041-TEKSTYMD
      *    MOVE    ZERO                TO  RECE041-ZAINUM
           MOVE    99999999            TO  RECE041-ZAINUM
      *    MOVE    WRK-RECE04-KOHBUNRI TO  RECE041-KOHBUNRI
           MOVE    "99"                TO  RECE041-SRYKBN
      *
           MOVE    WRK-CNT-MEISAI      TO  RECE041-MEISAISU
      *
           WRITE   RECE041-REC
           ADD     1                   TO  CNT-RECE04
      *
           .
       2001-JUSHIN-COMMENT-EXT.
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
              MOVE    RECE04-HOSPID     TO      SRY-HOSPID
              MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
              MOVE    RECE04-PTID       TO      SRY-PTID
              MOVE    RECE04-SRYYM      TO      SRY-SRYYM
              MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
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
                      COMPUTE  WRK-KOHBUNRI 
                                 =    RECE04-KOHBUNRI  +  1
                      ADD   RECE04-ZAIKAISU  
                                 TO   CNT-DENWA(WRK-KOHBUNRI)
                      MOVE  RECE04-HKNCOMBI
                                 TO   TBL-COUNT-HKNCOMBI(WRK-KOHBUNRI)
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
              MOVE    RECE04-HOSPID     TO      SRY-HOSPID
              MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
              MOVE    RECE04-PTID       TO      SRY-PTID
              MOVE    RECE04-SRYYM      TO      SRY-SRYYM
              MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
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
                      COMPUTE  WRK-KOHBUNRI 
                                 =    RECE04-KOHBUNRI  +  1
                      ADD   RECE04-ZAIKAISU  
                                 TO   CNT-DOUJITU(WRK-KOHBUNRI)
                      MOVE  RECE04-HKNCOMBI
                                 TO   TBL-COUNT-HKNCOMBI(WRK-KOHBUNRI)
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
           END-PERFORM
           .
       2001-DOUJITU-COUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    電話再診・同日複数再診のコメント編集
      *****************************************************************
       2001-DENWA-DOUJITU-COMMENT-SEC          SECTION.
      *
           INITIALIZE                      RECE041-REC
           MOVE    RECE02-HOSPID       TO  RECE041-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE041-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE041-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE041-PTID
           MOVE    RECE02-RECEKA       TO  RECE041-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE041-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE041-RECESYUBETU
           MOVE    RECE02-HKNJANUM-KEY TO  RECE041-HKNJANUM
           MOVE    RECE02-HOJOKBN-KEY  TO  RECE041-HOJOKBN
           MOVE    RECE02-TEKSTYMD     TO  RECE041-TEKSTYMD
           COMPUTE WRK-ZAINUM    =  99999990  +  IDX
           MOVE    WRK-ZAINUM          TO  RECE041-ZAINUM
      *    MOVE    99999999            TO  RECE041-ZAINUM
           COMPUTE WRK-KOHBUNRI  =  IDX  -  1
           MOVE    WRK-KOHBUNRI        TO  RECE041-KOHBUNRI
           MOVE    "99"                TO  RECE041-SRYKBN
      *
           MOVE    2                   TO  RECE041-MEISAISU
      *
           MOVE    TBL-COUNT-HKNCOMBI(IDX)
                                       TO  RECE041-HKNCOMBI
      *
           WRITE   RECE041-REC
           ADD     1                   TO  CNT-RECE04
      *
           INITIALIZE                      RECE051-REC
           MOVE    RECE02-HOSPID       TO  RECE051-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE051-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE051-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE051-PTID
           MOVE    RECE02-RECEKA       TO  RECE051-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE051-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE051-RECESYUBETU
           MOVE    RECE02-HKNJANUM-KEY TO  RECE051-HKNJANUM
           MOVE    RECE02-HOJOKBN-KEY  TO  RECE051-HOJOKBN
           MOVE    RECE02-TEKSTYMD     TO  RECE051-TEKSTYMD
           COMPUTE WRK-ZAINUM    =  99999990  +  IDX
           MOVE    WRK-ZAINUM          TO  RECE051-ZAINUM
      *    MOVE    99999999            TO  RECE051-ZAINUM
           MOVE    "99"                TO  RECE051-SRYKBN
      *    電話再診のコメントの挿入
           MOVE    SPACE                TO  COM-RECE05-REC
           INITIALIZE                       COM-RECE05-REC
           MOVE    "840000001"          TO  COM-SRYCD(1)
           MOVE    ZERO                 TO  COM-SRYSURYO(1)
           MOVE    9                    TO  COM-YUKOKETA(1)
           MOVE    "電話再診（　　回）" TO  COM-NAME(1)
           MOVE    CNT-DENWA(IDX)       TO  DAY-IDX
           MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(11:4)
           MOVE    COM-SRYACTINF(1)     TO  RECE051-SRYACTINF(1)
           MOVE    COM-NAMEINF(1)       TO  RECE051-NAMEINF(1)
      *    同日複数再診のコメントの挿入
           MOVE    "840000002"          TO  COM-SRYCD(2)
           MOVE    ZERO                 TO  COM-SRYSURYO(2)
           MOVE    11                   TO  COM-YUKOKETA(2)
           MOVE    "同日複数再診（　　回）"  TO COM-NAME(2)
           MOVE    CNT-DOUJITU(IDX)     TO  DAY-IDX
           MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(2)(15:4)
           MOVE    COM-SRYACTINF(2)     TO  RECE051-SRYACTINF(2)
           MOVE    COM-NAMEINF(2)       TO  RECE051-NAMEINF(2)
      *
           WRITE   RECE051-REC
           ADD     1                    TO  CNT-RECE05
      *
           .
       2001-DENWA-DOUJITU-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    電話再診のコメント編集
      *****************************************************************
       2001-DENWA-COMMENT-SEC          SECTION.
      *
           INITIALIZE                      RECE041-REC
           MOVE    RECE02-HOSPID       TO  RECE041-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE041-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE041-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE041-PTID
           MOVE    RECE02-RECEKA       TO  RECE041-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE041-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE041-RECESYUBETU
           MOVE    RECE02-HKNJANUM-KEY TO  RECE041-HKNJANUM
           MOVE    RECE02-HOJOKBN-KEY  TO  RECE041-HOJOKBN
           MOVE    RECE02-TEKSTYMD     TO  RECE041-TEKSTYMD
           COMPUTE WRK-ZAINUM    =  99999990  +  IDX
           MOVE    WRK-ZAINUM          TO  RECE041-ZAINUM
      *    MOVE    99999999            TO  RECE041-ZAINUM
           COMPUTE WRK-KOHBUNRI  =  IDX  -  1
           MOVE    WRK-KOHBUNRI        TO  RECE041-KOHBUNRI
           MOVE    "99"                TO  RECE041-SRYKBN
      *
           MOVE    1                   TO  RECE041-MEISAISU
      *
           MOVE    TBL-COUNT-HKNCOMBI(IDX)
                                       TO  RECE041-HKNCOMBI
      *
           WRITE   RECE041-REC
           ADD     1                   TO  CNT-RECE04
      *
           INITIALIZE                      RECE051-REC
           MOVE    RECE02-HOSPID       TO  RECE051-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE051-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE051-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE051-PTID
           MOVE    RECE02-RECEKA       TO  RECE051-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE051-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE051-RECESYUBETU
           MOVE    RECE02-HKNJANUM-KEY TO  RECE051-HKNJANUM
           MOVE    RECE02-HOJOKBN-KEY  TO  RECE051-HOJOKBN
           MOVE    RECE02-TEKSTYMD     TO  RECE051-TEKSTYMD
           COMPUTE WRK-ZAINUM    =  99999990  +  IDX
           MOVE    WRK-ZAINUM          TO  RECE051-ZAINUM
      *    MOVE    99999999            TO  RECE051-ZAINUM
           MOVE    "99"                TO  RECE051-SRYKBN
      *    電話再診のコメントの挿入
           MOVE    SPACE                TO  COM-RECE05-REC
           INITIALIZE                       COM-RECE05-REC
           MOVE    "840000001"          TO  COM-SRYCD(1)
           MOVE    ZERO                 TO  COM-SRYSURYO(1)
           MOVE    9                    TO  COM-YUKOKETA(1)
           MOVE    "電話再診（　　回）" TO  COM-NAME(1)
           MOVE    CNT-DENWA(IDX)       TO  DAY-IDX
           MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(11:4)
           MOVE    COM-SRYACTINF(1)     TO  RECE051-SRYACTINF(1)
           MOVE    COM-NAMEINF(1)       TO  RECE051-NAMEINF(1)
           WRITE   RECE051-REC
           ADD     1                    TO  CNT-RECE05
      *
           .
       2001-DENWA-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    同日複数再診のコメント編集
      *****************************************************************
       2001-DOUJITU-COMMENT-SEC          SECTION.
      *
           INITIALIZE                      RECE041-REC
           MOVE    RECE02-HOSPID       TO  RECE041-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE041-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE041-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE041-PTID
           MOVE    RECE02-RECEKA       TO  RECE041-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE041-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE041-RECESYUBETU
           MOVE    RECE02-HKNJANUM-KEY TO  RECE041-HKNJANUM
           MOVE    RECE02-HOJOKBN-KEY  TO  RECE041-HOJOKBN
           MOVE    RECE02-TEKSTYMD     TO  RECE041-TEKSTYMD
           COMPUTE WRK-ZAINUM    =  99999990  +  IDX
           MOVE    WRK-ZAINUM          TO  RECE041-ZAINUM
      *    MOVE    99999999            TO  RECE041-ZAINUM
           COMPUTE WRK-KOHBUNRI  =  IDX  -  1
           MOVE    WRK-KOHBUNRI        TO  RECE041-KOHBUNRI
           MOVE    "99"                TO  RECE041-SRYKBN
      *
           MOVE    1                   TO  RECE041-MEISAISU
      *
           MOVE    TBL-COUNT-HKNCOMBI(IDX)
                                       TO  RECE041-HKNCOMBI
      *
           WRITE   RECE041-REC
           ADD     1                   TO  CNT-RECE04
      *
           INITIALIZE                      RECE051-REC
           MOVE    RECE02-HOSPID       TO  RECE051-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE051-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE051-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE051-PTID
           MOVE    RECE02-RECEKA       TO  RECE051-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE051-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE051-RECESYUBETU
           MOVE    RECE02-HKNJANUM-KEY TO  RECE051-HKNJANUM
           MOVE    RECE02-HOJOKBN-KEY  TO  RECE051-HOJOKBN
           MOVE    RECE02-TEKSTYMD     TO  RECE051-TEKSTYMD
           COMPUTE WRK-ZAINUM    =  99999990  +  IDX
           MOVE    WRK-ZAINUM          TO  RECE051-ZAINUM
      *    MOVE    99999999            TO  RECE051-ZAINUM
           MOVE    "99"                TO  RECE051-SRYKBN
      *    同日複数再診のコメントの挿入
           MOVE    SPACE                TO  COM-RECE05-REC
           INITIALIZE                       COM-RECE05-REC
           MOVE    "840000002"          TO  COM-SRYCD(1)
           MOVE    ZERO                 TO  COM-SRYSURYO(1)
           MOVE    11                   TO  COM-YUKOKETA(1)
           MOVE    "同日複数再診（　　回）"  TO COM-NAME(1)
           MOVE    CNT-DOUJITU(IDX)     TO  DAY-IDX
           MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(15:4)
           MOVE    COM-SRYACTINF(1)     TO  RECE051-SRYACTINF(1)
           MOVE    COM-NAMEINF(1)       TO  RECE051-NAMEINF(1)
           WRITE   RECE051-REC
           ADD     1                    TO  CNT-RECE05
      *
           .
       2001-DOUJITU-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    再診４回目以降のカウント
      *****************************************************************
       2001-SAISHIN4-COUNT-SEC          SECTION.
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                     UNTIL   ( IDX           >   TBL-JINSAI4-MAX )
      *
              INITIALIZE                        SRYACT-REC
              MOVE    RECE04-HOSPID     TO      SRY-HOSPID
              MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
              MOVE    RECE04-PTID       TO      SRY-PTID
              MOVE    RECE04-SRYYM      TO      SRY-SRYYM
              MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
              MOVE    TBL-JINSAI4(IDX)  TO      SRY-SRYCD (1)
              MOVE    TBL-JINSAI4(IDX)  TO      SRY-SRYCD (2)
              MOVE    TBL-JINSAI4(IDX)  TO      SRY-SRYCD (3)
              MOVE    TBL-JINSAI4(IDX)  TO      SRY-SRYCD (4)
              MOVE    TBL-JINSAI4(IDX)  TO      SRY-SRYCD (5)
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
                      COMPUTE  WRK-KOHBUNRI 
                                 =    RECE04-KOHBUNRI  +  1
                      PERFORM  VARYING   IDX1  FROM  1  BY  1
                               UNTIL     IDX1  >   31
                          IF   RECE04-KAISU(1 IDX1)  NOT = ZERO
                              MOVE  "1"  TO  
                                    WRK-SAISHIN4(WRK-KOHBUNRI IDX1)
                          END-IF
                      END-PERFORM
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
           END-PERFORM
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
           PERFORM   VARYING   IDX   FROM    1   BY  1
                     UNTIL   ( IDX           >   TBL-JINZOU-MAX )
      *
              INITIALIZE                        SRYACT-REC
              MOVE    RECE04-HOSPID     TO      SRY-HOSPID
              MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
              MOVE    RECE04-PTID       TO      SRY-PTID
              MOVE    RECE04-SRYYM      TO      SRY-SRYYM
              MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
              MOVE    TBL-JINZOU(IDX)   TO      SRY-SRYCD (1)
              MOVE    TBL-JINZOU(IDX)   TO      SRY-SRYCD (2)
              MOVE    TBL-JINZOU(IDX)   TO      SRY-SRYCD (3)
              MOVE    TBL-JINZOU(IDX)   TO      SRY-SRYCD (4)
              MOVE    TBL-JINZOU(IDX)   TO      SRY-SRYCD (5)
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
                      MOVE    RECE04-REC    TO      WRK-RECE04-REC
                      COMPUTE  WRK-KOHBUNRI 
                                 =    RECE04-KOHBUNRI  +  1
                      PERFORM  VARYING   IDX1  FROM  1  BY  1
                               UNTIL     IDX1  >   31
                          IF   RECE04-KAISU(1 IDX1)  NOT = ZERO
                               MOVE  "1"  TO  
                                     WRK-JINZOU(WRK-KOHBUNRI IDX1)
                          END-IF
                      END-PERFORM
                      MOVE   RECE04-HKNCOMBI  TO
                                     WRK-JINZOU-HKNCOMBI(WRK-KOHBUNRI)
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
           END-PERFORM
      *
           .
       2001-JINZOU-COUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    リハビリのカウント
      *****************************************************************
       2001-RIHA-COUNT-SEC          SECTION.
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                     UNTIL   ( IDX           >   TBL-RIHA-MAX )
      *
              INITIALIZE                        SRYACT-REC
              MOVE    RECE04-HOSPID     TO      SRY-HOSPID
              MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
              MOVE    RECE04-PTID       TO      SRY-PTID
              MOVE    RECE04-SRYYM      TO      SRY-SRYYM
              MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (1)
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (2)
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (3)
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (4)
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (5)
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
                     EVALUATE    IDX
                        WHEN   1  
                        WHEN   2
                           MOVE    1    TO    IDX2   
                        WHEN   3  
                        WHEN   4
                           MOVE    2    TO    IDX2   
                        WHEN   5  
                        WHEN   6
                           MOVE    3    TO    IDX2   
                        WHEN   7  
                        WHEN   8
                           MOVE    4    TO    IDX2   
                        WHEN   9  
                        WHEN  10
                           MOVE    5    TO    IDX2   
                        WHEN  11  
                        WHEN  12
                           MOVE    6    TO    IDX2   
                        WHEN  13  
                        WHEN  14
                           MOVE    7    TO    IDX2   
                        WHEN  15  
                        WHEN  16
                           MOVE    8    TO    IDX2   
                        WHEN  17  
                        WHEN  18
                           MOVE    9    TO    IDX2   
                        WHEN  19  
                        WHEN  20
                           MOVE   10    TO    IDX2   
                        WHEN  21  
                        WHEN  22
                           MOVE   11    TO    IDX2   
                        WHEN  23  
                        WHEN  24
                           MOVE   12    TO    IDX2   
                        WHEN  25  
                           MOVE   13    TO    IDX2
                        WHEN  26
                           MOVE   14    TO    IDX2   
                        WHEN  27  
                           MOVE   15    TO    IDX2
                        WHEN  28
                           MOVE   16    TO    IDX2   
                     END-EVALUATE
                     COMPUTE  WRK-KOHBUNRI 
                                 =    RECE04-KOHBUNRI  +  1
                     IF  RECE04-ZAINUM  >  
                                     WRK-RIHA-ZAINUM(WRK-KOHBUNRI IDX2)
                         MOVE  RECE04-ZAINUM  TO  
                                     WRK-RIHA-ZAINUM(WRK-KOHBUNRI IDX2)
                     END-IF
                     PERFORM  VARYING   IDX1  FROM  1  BY  1
                              UNTIL     IDX1  >   31
                         IF   RECE04-KAISU(1 IDX1)  NOT = ZERO
                              MOVE  "1"  TO  
                                    WRK-RIGAKU(WRK-KOHBUNRI IDX2 IDX1)
                         END-IF
                     END-PERFORM
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
           END-PERFORM
      *
           .
       2001-RIHA-COUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    人工腎臓の判定
      *****************************************************************
       2001-JINZOU-HANTEI-SEC          SECTION.
      *
      *    人工腎臓と再診の突き合わせ
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                     UNTIL   ( IDX           >   5  )
      *
              MOVE       ZERO             TO     CNT-JINZOU
              PERFORM    VARYING    IDY   FROM   1   BY   1
                      UNTIL      IDY   >    31
                  IF   (WRK-JINZOU(IDX IDY)    =   "1")  AND
                       (WRK-SAISHIN4(IDX IDY)  =   "1")
                       ADD     1           TO   CNT-JINZOU
                  END-IF
              END-PERFORM
      *
              IF      CNT-JINZOU        NOT =      ZERO
                  PERFORM    2001-JINZOU-COMMENT-SEC
              END-IF
      *
           END-PERFORM
      *
           .
       2001-JINZOU-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    人工腎臓のコメント編集
      *****************************************************************
       2001-JINZOU-COMMENT-SEC          SECTION.
      *
           INITIALIZE                      RECE041-REC
           MOVE    RECE02-HOSPID       TO  RECE041-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE041-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE041-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE041-PTID
           MOVE    RECE02-RECEKA       TO  RECE041-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE041-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE041-RECESYUBETU
           MOVE    RECE02-HKNJANUM-KEY TO  RECE041-HKNJANUM
           MOVE    RECE02-HOJOKBN-KEY  TO  RECE041-HOJOKBN
           MOVE    RECE02-TEKSTYMD     TO  RECE041-TEKSTYMD
           COMPUTE WRK-ZAINUM    =  99999980  +  IDX
           MOVE    WRK-ZAINUM          TO  RECE041-ZAINUM
           COMPUTE WRK-KOHBUNRI  =  IDX  -  1
           MOVE    WRK-KOHBUNRI        TO  RECE041-KOHBUNRI
           MOVE    WRK-RECE04-SRYKBN   TO  RECE041-SRYKBN
      *
           MOVE    1                   TO  RECE041-MEISAISU
      *
           MOVE    WRK-JINZOU-HKNCOMBI(IDX)
                                       TO  RECE041-HKNCOMBI
      *
           WRITE   RECE041-REC
           ADD     1                   TO  CNT-RECE04
      *
           INITIALIZE                      RECE051-REC
           MOVE    RECE02-HOSPID       TO  RECE051-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE051-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE051-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE051-PTID
           MOVE    RECE02-RECEKA       TO  RECE051-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE051-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE051-RECESYUBETU
           MOVE    RECE02-HKNJANUM-KEY TO  RECE051-HKNJANUM
           MOVE    RECE02-HOJOKBN-KEY  TO  RECE051-HOJOKBN
           MOVE    RECE02-TEKSTYMD     TO  RECE051-TEKSTYMD
           COMPUTE WRK-ZAINUM    =  99999980  +  IDX
           MOVE    WRK-ZAINUM          TO  RECE051-ZAINUM
           MOVE    WRK-RECE04-SRYKBN   TO  RECE051-SRYKBN
      *    人工腎臓コメントの挿入
           ADD     1                    TO  IDX-RECE05
           MOVE    SPACE                TO  COM-RECE05-REC
           INITIALIZE                       COM-RECE05-REC
           MOVE    "810000001"          TO  COM-SRYCD(1)
           MOVE    ZERO                 TO  COM-SRYSURYO(1)
           MOVE    14                   TO  COM-YUKOKETA(1)
           MOVE    "再診４回目以降実施回数　　回"  TO COM-NAME(1)
           MOVE    CNT-JINZOU           TO  DAY-IDX
           MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(23:4)
           MOVE    COM-SRYACTINF(1)     TO  RECE051-SRYACTINF(1)
           MOVE    COM-NAMEINF(1)       TO  RECE051-NAMEINF(1)
           WRITE   RECE051-REC
           ADD     1                    TO  CNT-RECE05
      *
           .
       2001-JINZOU-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    乳幼児・幼児のコメント編集
      *****************************************************************
       2001-NYUYOJI-COMMENT-SEC          SECTION.
      *
           INITIALIZE                      RECE041-REC
           MOVE    RECE02-HOSPID       TO  RECE041-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE041-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE041-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE041-PTID
           MOVE    RECE02-RECEKA       TO  RECE041-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE041-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE041-RECESYUBETU
           MOVE    RECE02-HKNJANUM-KEY TO  RECE041-HKNJANUM
           MOVE    RECE02-HOJOKBN-KEY  TO  RECE041-HOJOKBN
           MOVE    RECE02-TEKSTYMD     TO  RECE041-TEKSTYMD
           MOVE    99999990            TO  RECE041-ZAINUM
           MOVE    "99"                TO  RECE041-SRYKBN
      *
           MOVE    1                   TO  RECE041-MEISAISU
      *
           WRITE   RECE041-REC
           ADD     1                   TO  CNT-RECE04
      *
           INITIALIZE                      RECE051-REC
           MOVE    RECE02-HOSPID       TO  RECE051-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE051-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE051-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE051-PTID
           MOVE    RECE02-RECEKA       TO  RECE051-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE051-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE051-RECESYUBETU
           MOVE    RECE02-HKNJANUM-KEY TO  RECE051-HKNJANUM
           MOVE    RECE02-HOJOKBN-KEY  TO  RECE051-HOJOKBN
           MOVE    RECE02-TEKSTYMD     TO  RECE051-TEKSTYMD
           MOVE    99999990            TO  RECE051-ZAINUM
           MOVE    "99"                TO  RECE051-SRYKBN
      *    コメントの挿入
           MOVE    SPACE                TO  COM-RECE05-REC
           INITIALIZE                       COM-RECE05-REC
           EVALUATE  RECE02-NYUYOJIFLG
              WHEN   "1"
                 MOVE    "840000003"    TO  COM-SRYCD(1)
                 MOVE     ZERO          TO  COM-SRYSURYO(1)
                 MOVE     11            TO  COM-YUKOKETA(1)
                 MOVE    "　　月　　日まで乳幼児" 
                                        TO  COM-NAME(1)
              WHEN   "2"
                 MOVE    "840000004"    TO  COM-SRYCD(1)
                 MOVE     ZERO          TO  COM-SRYSURYO(1)
                 MOVE     10            TO  COM-YUKOKETA(1)
                 MOVE    "　　月　　日まで幼児" 
                                        TO  COM-NAME(1)
           END-EVALUATE
      *
           MOVE    RECE02-BIRTHDAY(5:2) TO  DAY-IDX2
           MOVE    TBL-DAY(DAY-IDX2)    TO  COM-NAME(1)(1:4)
           MOVE    RECE02-BIRTHDAY(7:2) TO  DAY-IDX2
           COMPUTE    DAY-IDX2   =   DAY-IDX2  -   1
           MOVE    TBL-DAY(DAY-IDX2)    TO  COM-NAME(1)(7:4)
      *
           MOVE    COM-SRYACTINF(1)     TO  RECE051-SRYACTINF(1)
           MOVE    COM-NAMEINF(1)       TO  RECE051-NAMEINF(1)
           WRITE   RECE051-REC
           ADD     1                    TO  CNT-RECE05
      *
           .
       2001-NYUYOJI-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費受診日のコメント編集
      *****************************************************************
       2001-KOHJYUSIN-COMMENT-SEC          SECTION.
      *
           INITIALIZE                TBL-SANTEI-DAY
      *
           MOVE    ZERO          TO  DAY-IDX
           PERFORM    VARYING    IDX  FROM   1   BY   1
                      UNTIL     (IDX      >   31)  OR
                                (DAY-IDX  >   31)
                IF   RECE02-KOHJNISSUTBL(IDX)  NOT = SPACE
                      ADD   1     TO   DAY-IDX
                      MOVE  IDX   TO   TB-SANTEI-DAY(DAY-IDX)
                END-IF
           END-PERFORM
      *
           MOVE       ZERO       TO   IDZ
           INITIALIZE            WRK-FREE-AREA2
      *
           MOVE       5          TO   FLG-COMMENT
      *
           PERFORM  2001-FREE-COMMENT2-SEC
      *
      *    ＲＥＣＥ０５ファイルの内容をテーブルに退避
           MOVE    ZERO                TO  IDX-RECE05
           MOVE    SPACE               TO  WRK-SRYACTINF-AREA
           INITIALIZE                      WRK-SRYACTINF-AREA
           MOVE    SPACE               TO  WRK-NAMEINF-AREA
           INITIALIZE                      WRK-NAMEINF-AREA
      *
           MOVE    SPACE               TO  COM-RECE05-REC
           INITIALIZE                      COM-RECE05-REC
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX                >   50    )
                         OR      ( WK-FREE-NAME2(IDX) =   SPACE )
                ADD    1                  TO  IDX-RECE05
                MOVE   "810000001"        TO  COM-SRYCD(1)
                MOVE   ZERO               TO  COM-SRYSURYO(1)
                MOVE   COM-SRYACTINF(1)   TO  WRK-SRYACTINF(IDX-RECE05)
                MOVE   WRK-FREEINF2(IDX)  TO  WRK-NAMEINF(IDX-RECE05)
           END-PERFORM 
      *
      *    受診日の編集を含んだ内容で中間ファイルの再作成
           MOVE       ZERO             TO      FLG-WRKRECE05
           MOVE       ZERO             TO      IDX
           MOVE       ZERO             TO      IDX-RECE05
           MOVE       ZERO             TO      WRK-RENNUM
           MOVE       ZERO             TO      WRK-CNT-MEISAI
           PERFORM    UNTIL     FLG-WRKRECE05  =    1
                INITIALIZE                       RECE051-REC
                MOVE    RECE02-HOSPID        TO  RECE051-HOSPID
                MOVE    RECE02-SRYYM         TO  RECE051-SRYYM
                MOVE    RECE02-NYUGAIKBN     TO  RECE051-NYUGAIKBN
                MOVE    RECE02-PTID          TO  RECE051-PTID
                MOVE    RECE02-RECEKA        TO  RECE051-RECEKA
                MOVE    RECE02-TEISYUTUSAKI  TO  RECE051-TEISYUTUSAKI
                MOVE    RECE02-RECESYUBETU   TO  RECE051-RECESYUBETU
                MOVE    RECE02-HKNJANUM-KEY  TO  RECE051-HKNJANUM
                MOVE    RECE02-HOJOKBN-KEY   TO  RECE051-HOJOKBN
                MOVE    RECE02-TEKSTYMD      TO  RECE051-TEKSTYMD
                MOVE    99999980             TO  RECE051-ZAINUM
                MOVE    "99"                 TO  RECE051-SRYKBN
                ADD     1                    TO  WRK-RENNUM
                MOVE    WRK-RENNUM           TO  RECE051-RENNUM
                PERFORM  VARYING   IDX   FROM   1   BY   1
                         UNTIL   (IDX       >    5)   OR
                                 (FLG-WRKRECE05   =   1)
                   ADD         1             TO    IDX-RECE05
                   IF  WK-RECE05-SRYCD(IDX-RECE05) = SPACE
                       MOVE    1             TO    FLG-WRKRECE05
                   ELSE
                       MOVE  WRK-SRYACTINF(IDX-RECE05)
                                        TO   RECE051-SRYACTINF(IDX)  
                       MOVE  WRK-NAMEINF(IDX-RECE05)
                                        TO   RECE051-NAMEINF(IDX)
                       ADD   1          TO   WRK-CNT-MEISAI
                   END-IF  
                END-PERFORM
                WRITE   RECE051-REC
                ADD     1                    TO  CNT-RECE05
           END-PERFORM
      *
      *
           INITIALIZE                      RECE041-REC
           MOVE    RECE02-HOSPID       TO  RECE041-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE041-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE041-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE041-PTID
           MOVE    RECE02-RECEKA       TO  RECE041-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE041-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE041-RECESYUBETU
           MOVE    RECE02-HKNJANUM-KEY TO  RECE041-HKNJANUM
           MOVE    RECE02-HOJOKBN-KEY  TO  RECE041-HOJOKBN
           MOVE    RECE02-TEKSTYMD     TO  RECE041-TEKSTYMD
           MOVE    99999980            TO  RECE041-ZAINUM
           MOVE    "99"                TO  RECE041-SRYKBN
      *
           MOVE    WRK-CNT-MEISAI      TO  RECE041-MEISAISU
      *
           WRITE   RECE041-REC
           ADD     1                   TO  CNT-RECE04
      *
           .
       2001-KOHJYUSIN-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    慢性疼痛疾患管理料があるか判定
      *****************************************************************
       2001-SHIDOU-HANTEI-SEC          SECTION.
      *
           IF   RECE04-FLG-SHIDOU-COMMENT   =    "1"
      *
             MOVE     ZERO     TO     FLG-SHIDOU-COMMENT
      *
      *      算定履歴検索
             INITIALIZE                  SANTEI-REC
             MOVE    RECE04-HOSPID       TO  SANTEI-HOSPID
             MOVE    RECE04-PTID         TO  SANTEI-PTID
             MOVE    RECE04-SRYYM        TO  SANTEI-SRYYM
             MOVE    CONS-MANSEI         TO  SANTEI-SRYCD
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
                       IF     SANTEI-FSANTEIYMD(1:6)  =  RECE04-SRYYM   
                             MOVE    1    TO      FLG-SHIDOU-COMMENT
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
             IF      FLG-SHIDOU-COMMENT    =      1
                 MOVE       99      TO     FLG-COMMENT
                 PERFORM    2001-SHIDOU-COMMENT-SEC
             END-IF         
      *
           END-IF
      *
           .
       2001-SHIDOU-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    慢性疼痛疾患管理料のコメント編集
      *****************************************************************
       2001-SHIDOU-COMMENT-SEC          SECTION.
      *
           PERFORM   2001-SANTEI-DAY-SEC
      *
           MOVE       RECE04-REC    TO   RECE041-REC
           ADD     1                TO   RECE041-MEISAISU
           WRITE      RECE041-REC
           ADD     1                TO   CNT-RECE04
      *
           INITIALIZE                      RECE05-REC
           MOVE    RECE04-HOSPID       TO  RECE05-HOSPID
           MOVE    RECE04-SRYYM        TO  RECE05-SRYYM
           MOVE    RECE04-NYUGAIKBN    TO  RECE05-NYUGAIKBN
           MOVE    RECE04-PTID         TO  RECE05-PTID
           MOVE    RECE04-RECEKA       TO  RECE05-RECEKA
           MOVE    RECE04-TEISYUTUSAKI TO  RECE05-TEISYUTUSAKI
           MOVE    RECE04-RECESYUBETU  TO  RECE05-RECESYUBETU
           MOVE    RECE04-HKNJANUM     TO  RECE05-HKNJANUM
           MOVE    RECE04-HOJOKBN      TO  RECE05-HOJOKBN
           MOVE    RECE04-TEKSTYMD     TO  RECE05-TEKSTYMD
           MOVE    RECE04-ZAINUM       TO  RECE05-ZAINUM
           START   RECE05-FILE
                 KEY IS    >=   RECE05-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE05
                 NOT INVALID
                     PERFORM 990-RECE05-NEXT-SEC
           END-START
      *
           MOVE    RECE05-REC       TO      RECE051-REC
           MOVE    RECE05-SRYACTINF(1)  TO  RECE051-SRYACTINF(1)
           MOVE    RECE05-SRYACTINF(2)  TO  RECE051-SRYACTINF(3)
           MOVE    RECE05-SRYACTINF(3)  TO  RECE051-SRYACTINF(4)
           MOVE    RECE05-SRYACTINF(4)  TO  RECE051-SRYACTINF(5)
           MOVE    RECE05-NAMEINF(1)    TO  RECE051-NAMEINF(1)
           MOVE    RECE05-NAMEINF(2)    TO  RECE051-NAMEINF(3)
           MOVE    RECE05-NAMEINF(3)    TO  RECE051-NAMEINF(4)
           MOVE    RECE05-NAMEINF(4)    TO  RECE051-NAMEINF(5)
           MOVE    RECE05-DATAKBNINF(1) TO  RECE051-DATAKBNINF(1)
           MOVE    RECE05-DATAKBNINF(2) TO  RECE051-DATAKBNINF(3)
           MOVE    RECE05-DATAKBNINF(3) TO  RECE051-DATAKBNINF(4)
           MOVE    RECE05-DATAKBNINF(4) TO  RECE051-DATAKBNINF(5)
      *
           MOVE    SPACE                TO  RECE051-SRYACTINF(2)
           INITIALIZE                       RECE051-SRYACTINF(2)
           MOVE    "810000001"          TO  RECE051-SRYCD(2)
           MOVE    ZERO                 TO  RECE051-SRYSURYO(2)
           MOVE    15                   TO  RECE051-YUKOKETA(2)
           MOVE    "慢性疼痛疾患管理算定日　　　日"
                                        TO  RECE051-NAME(2)
           MOVE     TB-SANTEI-DAY(1)    TO  DAY-IDX
           MOVE     TBL-DAY(DAY-IDX)    TO  RECE051-NAME(2)(25:4)
           WRITE    RECE051-REC
           ADD      1                    TO  CNT-RECE05
      *
           .
       2001-SHIDOU-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    傷病手当金意見書交付料があるか判定
      *****************************************************************
       2001-SYOBYO-HANTEI-SEC          SECTION.
      *
           IF      RECE04-FLG-SYOBYO-COMMENT   =    "1"
                MOVE       4       TO     FLG-COMMENT
                PERFORM    2001-SHUJUTSU-ETC2-COMMENT-SEC
           END-IF
      *
           .
       2001-SYOBYO-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    療養費同意書交付料があるか判定
      *****************************************************************
       2001-RYOYO-HANTEI-SEC          SECTION.
      *
           IF      RECE04-FLG-RYOYO-COMMENT    =    "1"
                MOVE       4       TO     FLG-COMMENT
                PERFORM    2001-SHUJUTSU-ETC2-COMMENT-SEC
           END-IF
      *
           .
       2001-RYOYO-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    手術日のコメントがあるか判定
      *****************************************************************
       2001-SHUJUTSU-HANTEI-SEC          SECTION.
      *
           IF     RECE04-FLG-SHUJUTU-COMMENT   =    SPACE
               MOVE       1       TO     FLG-COMMENT
               PERFORM    2001-SHUJUTSU-ETC-COMMENT-SEC
           ELSE
               MOVE       RECE04-REC    TO   RECE041-REC
               WRITE      RECE041-REC
               ADD     1          TO      CNT-RECE04
               PERFORM    2001-RECE05-TENSOU-SEC
           END-IF
      *
           .
       2001-SHUJUTSU-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＣＴ・ＭＲＩがあるか判定
      *****************************************************************
       2001-CTMRI-HANTEI-SEC          SECTION.
      *
           IF      RECE04-FLG-CTMRI-COMMENT   =    "1"
                MOVE       2       TO     FLG-COMMENT
                PERFORM    2001-SHUJUTSU-ETC-COMMENT-SEC
           ELSE
                MOVE       RECE04-REC    TO   RECE041-REC
                WRITE      RECE041-REC
                ADD     1          TO      CNT-RECE04
                PERFORM    2001-RECE05-TENSOU-SEC
           END-IF
      *
           .
       2001-CTMRI-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    手術日等のコメント編集（差込：上）
      *****************************************************************
       2001-SHUJUTSU-ETC-COMMENT-SEC          SECTION.
      *
           PERFORM   2001-SANTEI-DAY-SEC
      *
           MOVE       ZERO       TO   IDZ                               
           INITIALIZE            WRK-FREE-AREA2                         
      *
           PERFORM  2001-FREE-COMMENT2-SEC                              
      *
      *    ※明細が５以上の場合
           INITIALIZE                      RECE05-REC
           MOVE    RECE04-HOSPID       TO  RECE05-HOSPID
           MOVE    RECE04-SRYYM        TO  RECE05-SRYYM
           MOVE    RECE04-NYUGAIKBN    TO  RECE05-NYUGAIKBN
           MOVE    RECE04-PTID         TO  RECE05-PTID
           MOVE    RECE04-RECEKA       TO  RECE05-RECEKA
           MOVE    RECE04-TEISYUTUSAKI TO  RECE05-TEISYUTUSAKI
           MOVE    RECE04-RECESYUBETU  TO  RECE05-RECESYUBETU
           MOVE    RECE04-HKNJANUM     TO  RECE05-HKNJANUM
           MOVE    RECE04-HOJOKBN      TO  RECE05-HOJOKBN
           MOVE    RECE04-TEKSTYMD     TO  RECE05-TEKSTYMD
           MOVE    RECE04-ZAINUM       TO  RECE05-ZAINUM
           START   RECE05-FILE
                 KEY IS    >=   RECE05-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE05
                 NOT INVALID
                     PERFORM 990-RECE05-NEXT-SEC
                     MOVE    RECE05-REC  TO  WRK-RECE05-REC
           END-START
      *
      *    ＲＥＣＥ０５ファイルの内容をテーブルに退避
           MOVE    ZERO                 TO  IDX-RECE05
           MOVE    SPACE                TO  WRK-SRYACTINF-AREA
           INITIALIZE                       WRK-SRYACTINF-AREA
           MOVE    SPACE                TO  WRK-NAMEINF-AREA
           INITIALIZE                       WRK-NAMEINF-AREA
           MOVE    SPACE                TO  WRK-DATAKBNINF-AREA
           INITIALIZE                       WRK-DATAKBNINF-AREA
      *
           MOVE    SPACE               TO  COM-RECE05-REC
           INITIALIZE                      COM-RECE05-REC
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX                >   50    )
                         OR      ( WK-FREE-NAME2(IDX) =   SPACE )
                ADD    1                  TO  IDX-RECE05
                MOVE   "810000001"        TO  COM-SRYCD(1)
                MOVE   ZERO               TO  COM-SRYSURYO(1)
                MOVE   COM-SRYACTINF(1)   TO  WRK-SRYACTINF(IDX-RECE05)
                MOVE   WRK-FREEINF2(IDX)  TO  WRK-NAMEINF(IDX-RECE05)
           END-PERFORM 
      *
           PERFORM
             UNTIL  ( FLG-RECE05           =   1                   )
             OR     ( RECE04-HOSPID    NOT =   RECE05-HOSPID       )
             OR     ( RECE04-SRYYM     NOT =   RECE05-SRYYM        )
             OR     ( RECE04-NYUGAIKBN NOT =   RECE05-NYUGAIKBN    )
             OR     ( RECE04-PTID      NOT =   RECE05-PTID         )
             OR     ( RECE04-RECEKA    NOT =   RECE05-RECEKA       )
             OR     ( RECE04-TEISYUTUSAKI
                                       NOT =   RECE05-TEISYUTUSAKI )
             OR     ( RECE04-RECESYUBETU
                                       NOT =   RECE05-RECESYUBETU  )
             OR     ( RECE04-HKNJANUM  NOT =   RECE05-HKNJANUM     )
             OR     ( RECE04-HOJOKBN   NOT =   RECE05-HOJOKBN      )
             OR     ( RECE04-TEKSTYMD  NOT =   RECE05-TEKSTYMD     )
             OR     ( RECE04-ZAINUM    NOT =   RECE05-ZAINUM       )
      *
             PERFORM   VARYING   IDX   FROM    1   BY  1
                       UNTIL   ( IDX               >   5     )
                       OR      ( RECE05-SRYCD(IDX) =   SPACE )
                  ADD    1             TO      IDX-RECE05
                  MOVE   RECE05-SRYACTINF(IDX) TO
                                           WRK-SRYACTINF(IDX-RECE05)
                  MOVE   RECE05-NAMEINF(IDX)   TO
                                           WRK-NAMEINF(IDX-RECE05)     
                  MOVE   RECE05-DATAKBNINF(IDX) TO
                                           WRK-DATAKBNINF(IDX-RECE05)
             END-PERFORM 
      *
             PERFORM 990-RECE05-NEXT-SEC
      *
           END-PERFORM
      *
      *    手術日コメントを含んだ内容で中間ファイルの再作成
           MOVE       ZERO             TO      FLG-WRKRECE05
           MOVE       ZERO             TO      IDX
           MOVE       ZERO             TO      IDX-RECE05
           MOVE       ZERO             TO      WRK-RENNUM
           MOVE       ZERO             TO      WRK-CNT-MEISAI
           PERFORM    UNTIL     FLG-WRKRECE05  =    1
                  INITIALIZE                        RECE051-REC
                  MOVE    WRK-RECE05-KEY       TO   RECE051-KEY
                  ADD     1                    TO   WRK-RENNUM
                  MOVE    WRK-RENNUM           TO   RECE051-RENNUM
                  MOVE    WRK-RECE05-KOHBUNRI  TO   RECE051-KOHBUNRI
                  MOVE    WRK-RECE05-PTNUM     TO   RECE051-PTNUM
                  MOVE    WRK-RECE05-SRYKA     TO   RECE051-SRYKA
                  MOVE    WRK-RECE05-SRYKBN    TO   RECE051-SRYKBN
                  MOVE    WRK-RECE05-SRYSYUKBN TO   RECE051-SRYSYUKBN
                  MOVE    WRK-RECE05-JIHIMONEY TO   RECE051-JIHIMONEY
                  PERFORM  VARYING   IDX   FROM   1   BY   1
                           UNTIL   (IDX       >    5)   OR
                                   (FLG-WRKRECE05   =   1)
                     ADD         1             TO    IDX-RECE05
                     IF  WK-RECE05-SRYCD(IDX-RECE05) = SPACE
                         MOVE    1             TO    FLG-WRKRECE05
                     ELSE
                         MOVE  WRK-SRYACTINF(IDX-RECE05)
                                          TO   RECE051-SRYACTINF(IDX)  
                         MOVE  WRK-NAMEINF(IDX-RECE05)
                                          TO   RECE051-NAMEINF(IDX)
                         MOVE  WRK-DATAKBNINF(IDX-RECE05)
                                          TO   RECE051-DATAKBNINF(IDX)
                         ADD   1          TO   WRK-CNT-MEISAI
                     END-IF  
                  END-PERFORM
                  WRITE   RECE051-REC
                  ADD     1                    TO  CNT-RECE05
           END-PERFORM     
      *
           MOVE    RECE04-REC        TO      RECE041-REC
           MOVE    WRK-CNT-MEISAI    TO      RECE041-MEISAISU
           WRITE   RECE041-REC
           ADD     1                 TO      CNT-RECE04
      *
           .
       2001-SHUJUTSU-ETC-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    手術日等のコメント編集２（差込：下）
      *****************************************************************
       2001-SHUJUTSU-ETC2-COMMENT-SEC          SECTION.
      *
           PERFORM   2001-SANTEI-DAY-SEC
      *
           MOVE       ZERO       TO   IDZ                               
           INITIALIZE            WRK-FREE-AREA2                         
      *
           PERFORM  2001-FREE-COMMENT2-SEC                              
      *
      *    ※明細が５以上の場合
           INITIALIZE                      RECE05-REC
           MOVE    RECE04-HOSPID       TO  RECE05-HOSPID
           MOVE    RECE04-SRYYM        TO  RECE05-SRYYM
           MOVE    RECE04-NYUGAIKBN    TO  RECE05-NYUGAIKBN
           MOVE    RECE04-PTID         TO  RECE05-PTID
           MOVE    RECE04-RECEKA       TO  RECE05-RECEKA
           MOVE    RECE04-TEISYUTUSAKI TO  RECE05-TEISYUTUSAKI
           MOVE    RECE04-RECESYUBETU  TO  RECE05-RECESYUBETU
           MOVE    RECE04-HKNJANUM     TO  RECE05-HKNJANUM
           MOVE    RECE04-HOJOKBN      TO  RECE05-HOJOKBN
           MOVE    RECE04-TEKSTYMD     TO  RECE05-TEKSTYMD
           MOVE    RECE04-ZAINUM       TO  RECE05-ZAINUM
           START   RECE05-FILE
                 KEY IS    >=   RECE05-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE05
                 NOT INVALID
                     PERFORM 990-RECE05-NEXT-SEC
                     MOVE    RECE05-REC  TO  WRK-RECE05-REC
           END-START
      *
      *    ＲＥＣＥ０５ファイルの内容をテーブルに退避
           MOVE    ZERO                 TO  IDX-RECE05
           MOVE    SPACE                TO  WRK-SRYACTINF-AREA
           INITIALIZE                       WRK-SRYACTINF-AREA
           MOVE    SPACE                TO  WRK-NAMEINF-AREA
           INITIALIZE                       WRK-NAMEINF-AREA
           MOVE    SPACE                TO  WRK-DATAKBNINF-AREA
           INITIALIZE                       WRK-DATAKBNINF-AREA
      *
           MOVE    RECE04-MEISAISU      TO  MAX-MEISAISU
      *
           MOVE    SPACE               TO  COM-RECE05-REC
           INITIALIZE                      COM-RECE05-REC
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX                >   50    )
                         OR      ( WK-FREE-NAME2(IDX) =   SPACE )
                COMPUTE  MAX-MEISAISU        =   MAX-MEISAISU  +  1
                MOVE   "810000001"        TO  COM-SRYCD(1)
                MOVE   ZERO               TO  COM-SRYSURYO(1)
                MOVE   COM-SRYACTINF(1)   TO  WRK-SRYACTINF
                                                         (MAX-MEISAISU)
                MOVE   WRK-FREEINF2(IDX)  TO  WRK-NAMEINF(MAX-MEISAISU)
           END-PERFORM 
      *
           PERFORM
             UNTIL  ( FLG-RECE05           =   1                   )
             OR     ( RECE04-HOSPID    NOT =   RECE05-HOSPID       )
             OR     ( RECE04-SRYYM     NOT =   RECE05-SRYYM        )
             OR     ( RECE04-NYUGAIKBN NOT =   RECE05-NYUGAIKBN    )
             OR     ( RECE04-PTID      NOT =   RECE05-PTID         )
             OR     ( RECE04-RECEKA    NOT =   RECE05-RECEKA       )
             OR     ( RECE04-TEISYUTUSAKI
                                       NOT =   RECE05-TEISYUTUSAKI )
             OR     ( RECE04-RECESYUBETU
                                       NOT =   RECE05-RECESYUBETU  )
             OR     ( RECE04-HKNJANUM  NOT =   RECE05-HKNJANUM     )
             OR     ( RECE04-HOJOKBN   NOT =   RECE05-HOJOKBN      )
             OR     ( RECE04-TEKSTYMD  NOT =   RECE05-TEKSTYMD     )
             OR     ( RECE04-ZAINUM    NOT =   RECE05-ZAINUM       )
      *
             PERFORM   VARYING   IDX   FROM    1   BY  1
                       UNTIL   ( IDX               >   5     )
                       OR      ( RECE05-SRYCD(IDX) =   SPACE )
                  ADD    1             TO      IDX-RECE05
                  MOVE   RECE05-SRYACTINF(IDX) TO
                                           WRK-SRYACTINF(IDX-RECE05)
                  MOVE   RECE05-NAMEINF(IDX)   TO
                                           WRK-NAMEINF(IDX-RECE05)     
                  MOVE   RECE05-DATAKBNINF(IDX) TO
                                           WRK-DATAKBNINF(IDX-RECE05)
             END-PERFORM 
      *
             PERFORM 990-RECE05-NEXT-SEC
      *
           END-PERFORM
      *
      *    手術日コメントを含んだ内容で中間ファイルの再作成
           MOVE       ZERO             TO      FLG-WRKRECE05
           MOVE       ZERO             TO      IDX
           MOVE       ZERO             TO      IDX-RECE05
           MOVE       ZERO             TO      WRK-RENNUM
           MOVE       ZERO             TO      WRK-CNT-MEISAI
           PERFORM    UNTIL     FLG-WRKRECE05  =    1
                  INITIALIZE                        RECE051-REC
                  MOVE    WRK-RECE05-KEY       TO   RECE051-KEY
                  ADD     1                    TO   WRK-RENNUM
                  MOVE    WRK-RENNUM           TO   RECE051-RENNUM
                  MOVE    WRK-RECE05-KOHBUNRI  TO   RECE051-KOHBUNRI
                  MOVE    WRK-RECE05-PTNUM     TO   RECE051-PTNUM
                  MOVE    WRK-RECE05-SRYKA     TO   RECE051-SRYKA
                  MOVE    WRK-RECE05-SRYKBN    TO   RECE051-SRYKBN
                  MOVE    WRK-RECE05-SRYSYUKBN TO   RECE051-SRYSYUKBN
                  MOVE    WRK-RECE05-JIHIMONEY TO   RECE051-JIHIMONEY
                  PERFORM  VARYING   IDX   FROM   1   BY   1
                           UNTIL   (IDX       >    5)   OR
                                   (FLG-WRKRECE05   =   1)
                     ADD         1             TO    IDX-RECE05
                     IF  WK-RECE05-SRYCD(IDX-RECE05) = SPACE
                         MOVE    1             TO    FLG-WRKRECE05
                     ELSE
                         MOVE  WRK-SRYACTINF(IDX-RECE05)
                                          TO   RECE051-SRYACTINF(IDX)  
                         MOVE  WRK-NAMEINF(IDX-RECE05)
                                          TO   RECE051-NAMEINF(IDX)
                         MOVE  WRK-DATAKBNINF(IDX-RECE05)
                                          TO   RECE051-DATAKBNINF(IDX)
                         ADD   1          TO   WRK-CNT-MEISAI
                     END-IF  
                  END-PERFORM
                  WRITE   RECE051-REC
                  ADD     1                    TO  CNT-RECE05
           END-PERFORM     
      *
           MOVE    RECE04-REC        TO      RECE041-REC
           MOVE    WRK-CNT-MEISAI    TO      RECE041-MEISAISU
           WRITE   RECE041-REC
           ADD     1                 TO      CNT-RECE04
      *
           .
       2001-SHUJUTSU-ETC2-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    算定日の確定
      *****************************************************************
       2001-SANTEI-DAY-SEC          SECTION.
      *
           INITIALIZE                TBL-SANTEI-DAY
      *
           MOVE    ZERO          TO  DAY-IDX
           PERFORM    VARYING    IDX  FROM   1   BY   1
                      UNTIL     (IDX      >   31)  OR
                                (DAY-IDX  >   31)
                IF   RECE04-KAISU(1 IDX)  NOT = ZERO
                      ADD   1     TO   DAY-IDX
                      MOVE  IDX   TO   TB-SANTEI-DAY(DAY-IDX)
                END-IF
           END-PERFORM
      *
           .
       2001-SANTEI-DAY-EXT.
           EXIT.
      *
      *****************************************************************
      *    手術日等の日付の編集
      *****************************************************************
       2001-FREE-COMMENT2-SEC          SECTION.                         
      *
           ADD      1          TO    IDZ
      *
           EVALUATE   FLG-COMMENT
              WHEN    1
                 MOVE     4          TO    WRK-KETA
                                           WRK-KETA-TAIHI
                 MOVE     2          TO    WRK-KETA2
                 MOVE    WRK-KETA2   TO    WK-FREE-YUKOKETA2(IDZ)
                 MOVE    "手術"  TO    WK-FREE-NAME2(IDZ)(1:WRK-KETA)
              WHEN    2
                 MOVE     4          TO    WRK-KETA
                                           WRK-KETA-TAIHI
                 MOVE     2          TO    WRK-KETA2
                 MOVE    WRK-KETA2   TO    WK-FREE-YUKOKETA2(IDZ)
                 MOVE    "実施"  TO    WK-FREE-NAME2(IDZ)(1:WRK-KETA)
               WHEN    4
                 MOVE     4          TO    WRK-KETA
                                           WRK-KETA-TAIHI
                 MOVE     2          TO    WRK-KETA2
                 MOVE    WRK-KETA2   TO    WK-FREE-YUKOKETA2(IDZ)
                 MOVE    "交付"  TO    WK-FREE-NAME2(IDZ)(1:WRK-KETA)
               WHEN    5
                 MOVE     4          TO    WRK-KETA
                                           WRK-KETA-TAIHI
                 MOVE     2          TO    WRK-KETA2
                 MOVE    WRK-KETA2   TO    WK-FREE-YUKOKETA2(IDZ)
                 MOVE    "福祉"  TO    WK-FREE-NAME2(IDZ)(1:WRK-KETA)
           END-EVALUATE
      *
           MOVE      ZERO          TO  FLG-FIRST
      *
           PERFORM   VARYING   IDX    FROM   1   BY   1
                          UNTIL   (IDX                 >    31)
                           OR     (TB-SANTEI-DAY(IDX)  =  ZERO)
      *
                 IF  FLG-FIRST  =  ZERO
                    IF  TB-SANTEI-DAY(IDX)     <  10 
      *
                       MOVE   TB-SANTEI-DAY(IDX)  TO  IDY
      *
                       ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                       MOVE    "　"
                           TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                       ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                       MOVE    TBL-DAY(IDY)(3:2)     
                           TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                       ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                       MOVE    "日"
                           TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                    ELSE
      *
                       MOVE   TB-SANTEI-DAY(IDX)  TO  IDY
      *
                       ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                       MOVE    "　"
                           TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                       ADD   2  TO  WK-FREE-YUKOKETA2(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                       MOVE    TBL-DAY(IDY)     
                           TO  WK-FREE-NAME2(IDZ)(WRK-KETA:4)
      *
                       ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                       MOVE    "日"
                           TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                    END-IF
                    MOVE      1              TO  FLG-FIRST
                 ELSE
                    IF  TB-SANTEI-DAY(IDX)     <  10 
      *
                       MOVE   TB-SANTEI-DAY(IDX)  TO  IDY
      *
                       IF    WK-FREE-YUKOKETA2(IDZ)  =  25
                          PERFORM  2001-FREE-COMMENT2-KAIGYO-SEC
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    "、"
                                    TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                       ELSE
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "、"
                                    TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                       END-IF
      *
                       IF    WK-FREE-YUKOKETA2(IDZ)  =  24 OR 25
                          PERFORM  2001-FREE-COMMENT2-KAIGYO-SEC
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    TBL-DAY(IDY)(3:2)     
                                    TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "日"
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2) 
                       ELSE
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    TBL-DAY(IDY)(3:2)     
                                    TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "日"
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2) 
                       END-IF
                    ELSE
      *
                       MOVE   TB-SANTEI-DAY(IDX)  TO  IDY
      *
                       IF    WK-FREE-YUKOKETA2(IDZ)  =  25
                          PERFORM  2001-FREE-COMMENT2-KAIGYO-SEC
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    "、"
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                       ELSE
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "、"
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                       END-IF
      *
                       IF    WK-FREE-YUKOKETA2(IDZ)  =  23 OR 24 OR 25
                          PERFORM  2001-FREE-COMMENT2-KAIGYO-SEC
                          ADD   2  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    TBL-DAY(IDY)     
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:4)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                          MOVE    "日"
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                       ELSE
                          ADD   2  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    TBL-DAY(IDY)     
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:4)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                          MOVE    "日"
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                       END-IF
                    END-IF
                 END-IF
      *
           END-PERFORM
           .
       2001-FREE-COMMENT2-EXT.
           EXIT.
      *
      *****************************************************************
      *    手術日等の日付の編集（改行）
      *****************************************************************
       2001-FREE-COMMENT2-KAIGYO-SEC          SECTION.                  
      *
           ADD      1              TO  IDZ
      *
           MOVE    WRK-KETA-TAIHI  TO  WRK-KETA
           MOVE    WRK-KETA2       TO  WK-FREE-YUKOKETA2(IDZ)
           MOVE    ALL "　"        TO  WK-FREE-NAME2(IDZ)(1:WRK-KETA)
      *
           .
       2001-FREE-COMMENT2-KAIGYO-EXT.
           EXIT.
      *
      *****************************************************************
      *    リハビリのコメント編集
      *****************************************************************
       2001-RIHA-COMMENT-SEC          SECTION.
      *
           MOVE    RECE04-REC        TO      RECE041-REC
           ADD     1                 TO      RECE041-MEISAISU
           WRITE   RECE041-REC
           ADD     1                 TO      CNT-RECE04
      *
      *      ※明細が５以上の場合
             INITIALIZE                      RECE05-REC
             MOVE    RECE04-HOSPID       TO  RECE05-HOSPID
             MOVE    RECE04-SRYYM        TO  RECE05-SRYYM
             MOVE    RECE04-NYUGAIKBN    TO  RECE05-NYUGAIKBN
             MOVE    RECE04-PTID         TO  RECE05-PTID
             MOVE    RECE04-RECEKA       TO  RECE05-RECEKA
             MOVE    RECE04-TEISYUTUSAKI TO  RECE05-TEISYUTUSAKI
             MOVE    RECE04-RECESYUBETU  TO  RECE05-RECESYUBETU
             MOVE    RECE04-HKNJANUM     TO  RECE05-HKNJANUM
             MOVE    RECE04-HOJOKBN      TO  RECE05-HOJOKBN
             MOVE    RECE04-TEKSTYMD     TO  RECE05-TEKSTYMD
             MOVE    RECE04-ZAINUM       TO  RECE05-ZAINUM
             START   RECE05-FILE
                 KEY IS    >=   RECE05-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE05
                 NOT INVALID
                     PERFORM 990-RECE05-NEXT-SEC
                     MOVE    RECE05-REC  TO  WRK-RECE05-REC
             END-START
      *
      *      ＲＥＣＥ０５ファイルの内容をテーブルに退避
             MOVE    ZERO                 TO  IDX-RECE05
             MOVE    SPACE                TO  WRK-SRYACTINF-AREA
             INITIALIZE                       WRK-SRYACTINF-AREA
             MOVE    SPACE                TO  WRK-NAMEINF-AREA
             INITIALIZE                       WRK-NAMEINF-AREA
             MOVE    SPACE                TO  WRK-DATAKBNINF-AREA
             INITIALIZE                       WRK-DATAKBNINF-AREA
      *      リハビリコメントの挿入
      *      ADD     1                    TO  IDX-RECE05
             MOVE    SPACE                TO  COM-RECE05-REC
             INITIALIZE                       COM-RECE05-REC
             MOVE    "810000001"          TO  COM-SRYCD(1)
             MOVE    ZERO                 TO  COM-SRYSURYO(1)
             MOVE    7                    TO  COM-YUKOKETA(1)
             MOVE    "実施日数　　日"     TO  COM-NAME(1)
             MOVE    ZERO                 TO  CNT-RIHA
             EVALUATE   RECE04-ZAINUM
                 WHEN   WRK-RIGA1-SHU-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA1-SHU(WRK-KOHBUNRI IDX) 
                                                      NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA2-SHU-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA2-SHU(WRK-KOHBUNRI IDX) 
                                                      NOT = SPACE
                                ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA3-SHU-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA3-SHU(WRK-KOHBUNRI IDX) 
                                                      NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA4-SHU-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA4-SHU(WRK-KOHBUNRI IDX) 
                                                      NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA1-KO-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA1-KO(WRK-KOHBUNRI IDX) 
                                                     NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA2-KO-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA2-KO(WRK-KOHBUNRI IDX) 
                                                     NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA3-KO-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA3-KO(WRK-KOHBUNRI IDX) 
                                                     NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA4-KO-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA4-KO(WRK-KOHBUNRI IDX) 
                                                     NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO1-SHU-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO1-SHU(WRK-KOHBUNRI IDX) 
                                                       NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO2-SHU-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO2-SHU(WRK-KOHBUNRI IDX) 
                                                       NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO1-KO-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO1-KO(WRK-KOHBUNRI IDX) 
                                                      NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO2-KO-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO2-KO(WRK-KOHBUNRI IDX) 
                                                      NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO1-SHU-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO1-SHU(WRK-KOHBUNRI IDX) 
                                                       NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO2-SHU-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO2-SHU(WRK-KOHBUNRI IDX) 
                                                       NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO1-KO-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO1-KO(WRK-KOHBUNRI IDX) 
                                                      NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO2-KO-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO2-KO(WRK-KOHBUNRI IDX) 
                                                      NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   OTHER
                        CONTINUE
             END-EVALUATE
             IF      CNT-RIHA             NOT =    ZERO
               MOVE    CNT-RIHA             TO  DAY-IDX
               MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(9:4)
               COMPUTE  MAX-MEISAISU        =   RECE04-MEISAISU  +  1
               MOVE    COM-SRYACTINF(1)     TO  WRK-SRYACTINF
                                                     (MAX-MEISAISU)
               MOVE    COM-NAMEINF(1)       TO  WRK-NAMEINF
                                                     (MAX-MEISAISU)
             END-IF
      *
             PERFORM
               UNTIL  ( FLG-RECE05           =   1                   )
               OR     ( RECE04-HOSPID    NOT =   RECE05-HOSPID       )
               OR     ( RECE04-SRYYM     NOT =   RECE05-SRYYM        )
               OR     ( RECE04-NYUGAIKBN NOT =   RECE05-NYUGAIKBN    )
               OR     ( RECE04-PTID      NOT =   RECE05-PTID         )
               OR     ( RECE04-RECEKA    NOT =   RECE05-RECEKA       )
               OR     ( RECE04-TEISYUTUSAKI
                                         NOT =   RECE05-TEISYUTUSAKI )
               OR     ( RECE04-RECESYUBETU
                                         NOT =   RECE05-RECESYUBETU  )
               OR     ( RECE04-HKNJANUM  NOT =   RECE05-HKNJANUM     )
               OR     ( RECE04-HOJOKBN   NOT =   RECE05-HOJOKBN      )
               OR     ( RECE04-TEKSTYMD  NOT =   RECE05-TEKSTYMD     )
               OR     ( RECE04-ZAINUM    NOT =   RECE05-ZAINUM       )
      *
               PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX               >   5     )
                         OR      ( RECE05-SRYCD(IDX) =   SPACE )
                    ADD    1             TO      IDX-RECE05
                    MOVE   RECE05-SRYACTINF(IDX) TO
                                             WRK-SRYACTINF(IDX-RECE05)
                    MOVE   RECE05-NAMEINF(IDX)   TO
                                             WRK-NAMEINF(IDX-RECE05)     
                    MOVE   RECE05-DATAKBNINF(IDX) TO
                                             WRK-DATAKBNINF(IDX-RECE05)
               END-PERFORM 
      *
               PERFORM 990-RECE05-NEXT-SEC
      *
             END-PERFORM
      *
      *      リハビリコメントを含んだ内容で中間ファイルの再作成
             MOVE       ZERO             TO      FLG-WRKRECE05
             MOVE       ZERO             TO      IDX
             MOVE       ZERO             TO      IDX-RECE05
             MOVE       ZERO             TO      WRK-RENNUM
             PERFORM    UNTIL     FLG-WRKRECE05  =    1
                    INITIALIZE                        RECE051-REC
                    MOVE    WRK-RECE05-KEY       TO   RECE051-KEY
                    ADD     1                    TO   WRK-RENNUM
                    MOVE    WRK-RENNUM           TO   RECE051-RENNUM
                    MOVE    WRK-RECE05-KOHBUNRI  TO   RECE051-KOHBUNRI
                    MOVE    WRK-RECE05-PTNUM     TO   RECE051-PTNUM
                    MOVE    WRK-RECE05-SRYKA     TO   RECE051-SRYKA
                    MOVE    WRK-RECE05-SRYKBN    TO   RECE051-SRYKBN
                    MOVE    WRK-RECE05-SRYSYUKBN TO   RECE051-SRYSYUKBN
                    MOVE    WRK-RECE05-JIHIMONEY TO   RECE051-JIHIMONEY
                    PERFORM  VARYING   IDX   FROM   1   BY   1
                             UNTIL   (IDX       >    5)   OR
                                     (FLG-WRKRECE05   =   1)
                       ADD         1             TO    IDX-RECE05
                       IF  WK-RECE05-SRYCD(IDX-RECE05) = SPACE
                           MOVE    1             TO    FLG-WRKRECE05
                       ELSE
                           MOVE  WRK-SRYACTINF(IDX-RECE05)
                                            TO   RECE051-SRYACTINF(IDX)  
                           MOVE  WRK-NAMEINF(IDX-RECE05)
                                            TO   RECE051-NAMEINF(IDX)
                           MOVE  WRK-DATAKBNINF(IDX-RECE05)
                                            TO   RECE051-DATAKBNINF(IDX)
                       END-IF  
                    END-PERFORM
                    WRITE   RECE051-REC
                    ADD     1                    TO  CNT-RECE05
             END-PERFORM     
      *
           .
       2001-RIHA-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０５転送処理
      *****************************************************************
       2001-RECE05-TENSOU-SEC     SECTION.
      *
           INITIALIZE                      RECE05-REC
           MOVE    RECE04-HOSPID       TO  RECE05-HOSPID
           MOVE    RECE04-SRYYM        TO  RECE05-SRYYM
           MOVE    RECE04-NYUGAIKBN    TO  RECE05-NYUGAIKBN
           MOVE    RECE04-PTID         TO  RECE05-PTID
           MOVE    RECE04-RECEKA       TO  RECE05-RECEKA
           MOVE    RECE04-TEISYUTUSAKI TO  RECE05-TEISYUTUSAKI
           MOVE    RECE04-RECESYUBETU  TO  RECE05-RECESYUBETU
           MOVE    RECE04-HKNJANUM     TO  RECE05-HKNJANUM
           MOVE    RECE04-HOJOKBN      TO  RECE05-HOJOKBN
           MOVE    RECE04-TEKSTYMD     TO  RECE05-TEKSTYMD
           MOVE    RECE04-ZAINUM       TO  RECE05-ZAINUM
           START   RECE05-FILE
               KEY IS    >=   RECE05-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE05
               NOT INVALID
                   PERFORM 990-RECE05-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( FLG-RECE05           =   1                   )
               OR     ( RECE04-HOSPID    NOT =   RECE05-HOSPID       )
               OR     ( RECE04-SRYYM     NOT =   RECE05-SRYYM        )
               OR     ( RECE04-NYUGAIKBN NOT =   RECE05-NYUGAIKBN    )
               OR     ( RECE04-PTID      NOT =   RECE05-PTID         )
               OR     ( RECE04-RECEKA    NOT =   RECE05-RECEKA       )
               OR     ( RECE04-TEISYUTUSAKI
                                         NOT =   RECE05-TEISYUTUSAKI )
               OR     ( RECE04-RECESYUBETU
                                         NOT =   RECE05-RECESYUBETU  )
               OR     ( RECE04-HKNJANUM  NOT =   RECE05-HKNJANUM     )
               OR     ( RECE04-HOJOKBN   NOT =   RECE05-HOJOKBN      )
               OR     ( RECE04-TEKSTYMD  NOT =   RECE05-TEKSTYMD     )
               OR     ( RECE04-ZAINUM    NOT =   RECE05-ZAINUM       )
      *
      *
               MOVE          RECE05-REC       TO      RECE051-REC
               WRITE         RECE051-REC
               ADD     1                 TO  CNT-RECE05
      *
               PERFORM 990-RECE05-NEXT-SEC
      *
           END-PERFORM
      *
           .
       2001-RECE05-TENSOU-EXT.
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
           DISPLAY "RECE02  IN  " CNT-RECE02 
           DISPLAY "RECE04  CNT " CNT-RECE04 
           DISPLAY "RECE05  CNT " CNT-RECE05 
           DISPLAY "*** ORCR0040 END ***"
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
           CLOSE                       RECE02-FILE
      *
           CLOSE                       RECE04-FILE
      *
           CLOSE                       RECE05-FILE
      *
           CLOSE                       RECE041-FILE     
           CLOSE                       RECE051-FILE     
      *
           .
       310-FILE-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０２データ順検索処理
      *****************************************************************
       990-RECE02-READ-SEC           SECTION.
      *
           READ    RECE02-FILE         NEXT
               AT  END
                   MOVE    1           TO  FLG-END
                   MOVE    2           TO  SPA-STS
               NOT AT  END
                   ADD     1           TO  CNT-RECE02
                   ADD     1           TO  CNT-IN-COMMIT
                   MOVE    ZERO        TO  FLG-END
           END-READ
      *
           .
       990-RECE02-READ-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０４データ読み
      ****************************************************************
       990-RECE04-NEXT-SEC           SECTION.
      *
           READ    RECE04-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE04
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE04
           END-READ
      *
           .
       990-RECE04-NEXT-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０５データ読み
      ****************************************************************
       990-RECE05-NEXT-SEC           SECTION.
      *
           READ    RECE05-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE05
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE05
           END-READ
      *
           .
       990-RECE05-NEXT-EXT.
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
