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
      *
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCR0710.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
000600*  サブシステム名    : レセプト（入院）
000700*  コンポーネント名  : レセプト印刷用ファイル作成
000800*  管理者            : 
      *  作成日付    作業者        記述
      *  02/12/10    NACL−藤原　  新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    レセプト０２データ
           SELECT  RECE62-FILE     ASSIGN  RECE62PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE62-KEY
                                   FILE    STATUS  IS  STS-RECE62.
      *    レセプト０３１データ
           SELECT  RECE631-FILE     ASSIGN  RECE63PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE631-KEY
                                   FILE    STATUS  IS  STS-RECE63.
      *    レセプト０６１データ
           SELECT  RECE661-FILE     ASSIGN  RECE66PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE661-KEY
                                   FILE    STATUS  IS  STS-RECE66.
      *                             
           SELECT  RECE69-FILE     ASSIGN  RECE69PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE69-KEY
                                   FILE    STATUS  IS  STS-RECE69.
      *    レセプト（県単用項目）データ
           SELECT  RECE67-FILE     ASSIGN  RECE67PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE67-KEY
                                   FILE    STATUS  IS  STS-RECE67.
      *
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    レセプト０２データ
       FD  RECE62-FILE.
       01  RECE62-REC.
           COPY    "CPRCF062.INC".
      *
      *    レセプト０３１データ
       FD  RECE631-FILE.
       01  RECE631-REC.
           COPY    "CPRCF0631.INC".
      *
      *    レセプト０６１データ
       FD  RECE661-FILE.
       01  RECE661-REC. 
           COPY    "CPRCF0661.INC".
      *
      *    レセプト０９データ
       FD  RECE69-FILE.
       01  RECE69-REC. 
           COPY    "CPRCF069.INC".
      *
      *    レセプト（県単用項目）データ
       FD  RECE67-FILE.
       01  RECE67-REC. 
           COPY    "CPRCF067.INC".
      *
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *    シェル用領域
           COPY    "CPCOMMONSHELL.INC".
      *
      *     レセプト明細ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE62//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE63//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE66//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE69//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE67//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03                      PIC X(04)   VALUE   ".dat".
      *
      *       
           COPY    "HCN06.INC"     REPLACING  //HCN06//
                                   BY         //HC06//.
            COPY    "HCN061.INC"   REPLACING  //HCN061//
                                   BY         //HC061//.
      *     COPY    "HCN062.INC".
      *
      *    スパ領域
       01  SPA-AREA.
           03  SPA-STS                 PIC 9(04).
           03  SPA-ERRCD               PIC X(04).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECE62          PIC X(02).
           03  STS-RECE63          PIC X(02).
           03  STS-RECE66          PIC X(02).
           03  STS-RECE69          PIC X(02).
           03  STS-RECE67          PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(03).
           03  FLG-RECE62          PIC 9(01).
           03  FLG-RECE631         PIC 9(01).
           03  FLG-RECE661         PIC 9(01).
           03  FLG-RECE08          PIC 9(01).
           03  FLG-RECE69          PIC 9(01).
           03  FLG-RECE67          PIC 9(01).
           03  FLG-KANRIMST        PIC 9(01).
           03  FLG-HKNNUM          PIC 9(01).
           03  FLG-KUGIRI          PIC 9(01).
           03  FLG-RECE07          PIC 9(01).
           03  FLG-SEIKYU          PIC 9(01).
           03  FLG-RECECOM         PIC 9(01).
           03  FLG-ERR             PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
      *
           03  FLG-TENKI           PIC 9(01).     
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
           03  CNT-RECE62          PIC 9(06).
           03  CNT-RECE03          PIC 9(06).
           03  CNT-RECE661         PIC 9(06).
           03  CNT-RECE69          PIC 9(06).
           03  CNT-OUT             PIC 9(06).
           03  CNT-ZAIMEISAISU     PIC 9(03).
           03  CNT-PAGE            PIC 9(03).
           03  CNT-KENSU           PIC 9(03). 
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME.
               05  SYS-THH         PIC 9(02).
               05  SYS-TMM         PIC 9(02).
               05  SYS-TSS         PIC 9(02).
               05  SYS-TDD         PIC 9(02).
           03  SYS-YMD.
               05  SYS-YY          PIC 9(02).
               05  SYS-MM          PIC 9(02).
               05  SYS-DD          PIC 9(02).
           03  WRK-SYSYMD.
               05  WRK-SYSYY       PIC 9(04).
               05  WRK-SYSMM       PIC 9(02).
               05  WRK-SYSDD       PIC 9(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDW                 PIC 9(04).
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDA                 PIC 9(04).
           03  IDB                 PIC 9(04).
           03  IDX1                PIC 9(02).
           03  IDX2                PIC 9(02).
           03  IDX3                PIC 9(02).
           03  IDXP                PIC 9(02).
           03  IDY1                PIC 9(03).
           03  IDY2                PIC 9(03).
           03  IDY3                PIC 9(03).
      *     
           03  SEIHIDX             PIC 9(02).
           03  KAKKIDX             PIC 9(02).
           03  SESNIDX             PIC 9(02).
      *
      *    
       01  KEY-AREA                          VALUE   LOW-VALUE.          
           03  KEY-NEW.
               05  KEY-NEW1.
                   07  KEY-N-HOSPID    PIC  X(24).
                   07  KEY-N-SRYYM     PIC  9(06).
                   07  KEY-N-NYUGAIKBN PIC  X(01).
                   07  KEY-N-PTID      PIC  9(10).
                   07  KEY-N-RECEKA    PIC  X(02).
               05  KEY-N-TEISYUTUSAKI  PIC  9(01).
               05  KEY-N-RECESYUBETU   PIC  9(04).
           03  KEY-OLD.
               05  KEY-OLD1.
                   07  KEY-O-HOSPID    PIC  X(24).
                   07  KEY-O-SRYYM     PIC  9(06).
                   07  KEY-O-NYUGAIKBN PIC  X(01).
                   07  KEY-O-PTID      PIC  9(10).
                   07  KEY-O-RECEKA    PIC  X(02).
               05  KEY-O-TEISYUTUSAKI  PIC  9(01).
               05  KEY-O-RECESYUBETU   PIC  9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-PARA.
               05  WRK-PARA-SRYYM   PIC  X(06).
               05  WRK-PARA-TERMID  PIC  X(16).
               05  WRK-PARA-SYSYMD  PIC  X(08).
               05  WRK-PARA-RECEKBN PIC  X(01).
               05  WRK-PARA-RECEYM  PIC  X(06). 
               05  WRK-PARA-JOBID   PIC  9(07).
               05  WRK-PARA-SHELLID PIC  X(08).
      *
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *
           03  WRK-RECEERR         PIC X(200).
      *
           03  WRK-RECENUM          PIC 9(06). 
      *
           03  WRK-HKNJANUM        PIC X(08).
           03  WRK-KYURATE-9       PIC 9(03).
           03  WRK-KYURATE         PIC Z9.
           03  WRK-BEDSU           PIC ZZ9.
      *
           03  WRK-ERRMSG          PIC X(40).
      *
           03  WRK-1033-TABLE.
               05  WRK-1033-TBL    OCCURS  5.
                   07  WRK-1033-HKNJANUM-G.
                       09  WRK-1033-HKNJANUM
                                   PIC X(08) OCCURS  20.
                   07  WRK-1033-STYUKYMD
                                   PIC X(08).
                   07  WRK-1033-EDYUKYMD 
                                   PIC X(08).                                       
      *
      *    県単用項目ファイル用ワーク     
           COPY    "HC06.INC"     REPLACING  //HC06//
                                   BY         //RECE67-HC06//.
      *
       01  WRK-HENSYU-AREA.
           03  WRK-HENYMDG         PIC X(22).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HMM         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HDD         PIC Z9.
      *
           03  WRK-HENTIME.
               05  WRK-THH         PIC 99.
               05  FILLER          PIC X(01)   VALUE  ":".
               05  WRK-TMM         PIC 99.
      *
           03  WRK-BYO-OLD.
               05  WRK-BO-SYUBYOFLG            PIC X(01).
               05  WRK-BO-SRYYMD               PIC X(08).
               05  WRK-BO-TENKIKBN             PIC X(01).
               05  WRK-BO-TENKIYMD             PIC X(08).
      *
      *    1桁目:生保 2桁目:結核 3桁目:精神
           03  WRK-3SYU-KBN.
               05  WRK-3SYU        PIC X(03).
      *
           03  WRK-EDIT-AREA.
      *        傷病名連番     
               05  WRK-LINE                    PIC 9(02).
      *        編集傷病名文字数 
               05  WRK-CLM                     PIC 9(03).
      *        ワーク編集傷病名文字数 
               05  WRK-WCLM                    PIC 9(03).
      *        病名文字数         
               05  WRK-MOJISU                  PIC 9(03).
      *        編集開始位置         
               05  WRK-STCLM                   PIC 9(03).
      *        傷病名欄編集行         
               05  WRK-LINEBYO                 PIC 9(02).
      *        適用欄編集行         
               05  WRK-LINETEK                 PIC 9(02).
      *        前行の続きのとき（傷病名）         
               05  WRK-CONTINUE                PIC 9(01).
      *    傷病名編集
           03  WRK-BYOMEI                      PIC X(150).
           03  WRK-BYOMEIW                     PIC X(150).
      *    傷病名編集フラグ（疑い）
           03  WRK-HENFLG1                     PIC X(01).
      *    傷病名編集フラグ（急性）
           03  WRK-HENFLG2                     PIC X(01). 
      *    傷病名編集（傷病名欄）
           03  WRK-BYOMEI1                     PIC X(54).
           03  WRK-BYOMEI1-W   REDEFINES       WRK-BYOMEI1.
               05  WRK-BYOMEI1-NO              PIC X(06).
               05  WRK-BYOMEI1-NAME            PIC X(48).
               
      *    傷病名編集（適用欄）
           03  WRK-BYOMEI2                     PIC X(52).
           03  WRK-BYOMEI2-W   REDEFINES       WRK-BYOMEI2.
               05  WRK-BYOMEI2-NO              PIC X(08).
               05  WRK-BYOMEI2-NAME            PIC X(44).
               05  WRK-BYOMEI2-NAMEW   REDEFINES   WRK-BYOMEI2-NAME.
                   07  FILLER                  PIC X(20).
                   07  WRK-BYOMEI2-ELSE.
                       09  WRK-BYOMEI2-YMD     PIC X(20).
                       09  WRK-BYOMEI2-TENKI   PIC X(04).
               05  WRK-BYOMEI2R-NAMEW  REDEFINES   WRK-BYOMEI2-NAME.
                   07  FILLER                  PIC X(14).
                   07  WRK-BYOMEI2R-ELSE.
                       09  WRK-BYOMEI2R-YMD    PIC X(20).
                       09  WRK-BYOMEI2R-TENKI  PIC X(04).
                       09  WRK-BYOMEI2R-TENKIYMD
                                               PIC X(06).
      *                 
      *    保険履歴編集（適用欄）
           03  WRK-HKN-RIREKI-AREA.
               05  WRK-HKN-RIREKI-TBL          OCCURS  50.  
                   07  WRK-HKN-RIREKI          PIC X(52).
                   07  WRK-HKN-RIREKI-W   REDEFINES    WRK-HKN-RIREKI.
                       09  WRK-HKN-MEISYO      PIC X(12).
                       09  WRK-HKN-TEKSTYMD.
                           11  WRK-HKN-TEKSTYY PIC X(08).
                           11  WRK-HKN-TEKSTMD PIC X(12).
                       09  WRK-HKN-FL.
                           11  WRK-HKN-FL1     PIC X(04).
                           11  WRK-HKN-TEKEDYMD
                                               PIC X(12).
                           11  WRK-HKN-FL2     PIC X(04).
           03  WRK-RIREKI-MAX                  PIC 9(02).                
           03  WRK-HKN-NUM                     PIC X(50).
           03  WRK-HKN-KIGO                    PIC X(50).
           03  WRK-HKN-TEISYUTUSAKI            PIC X(04).    
           03  WRK-SRYYMST                     PIC X(12).
           03  WRK-SRYYMED                     PIC X(12).   
      *
           03  WRK-WLINETEK                    PIC 9(03).
           03  WRK-TNSIDX                      PIC 9(02).
           03  WRK-R061-ZAINUM-O               PIC 9(05).
           03  WRK-R061-SRYKBN-O               PIC X(02).
           03  WRK-R061-KOHBUNRI-O             PIC 9(01).
      *
      *****03  WRK-IN                          PIC X(01).
      *
           03  WRK-SRYYMD                      PIC X(08).
           03  WRK-KGKZ                        PIC ZZZ,ZZZ,ZZZ.
           03  WRK-KGK9                        PIC ZZZ,ZZZ,ZZ9.
           03  WRK-KGK7                        PIC ZZZZ,ZZ9.
           03  WRK-KGK6                        PIC ZZZ,ZZ9.
           03  WRK-KGK4                        PIC ZZZ9.
           03  WRK-KGK2                        PIC Z9.
      *
      *    レセプトコメント編集
           03  WRK-COMMENT-G.
               05  WRK-COMMENT                 PIC X(50)
                                               OCCURS  8.
           03  WRK-COMM                        PIC X(400).
           03  WRK-COMM1                       PIC X(400).
           03  WRK-COL                         PIC 9(03). 
           03  WRK-RECECOM         PIC 9(01).
           03  WRK-RECEHEN         PIC 9(01).
      *
       01  WRK-BYOMEI-AREA.     
      *    傷病名最大文字数（傷病名欄）
           03  WRK-BYOMEI1-MAX     PIC 9(02)   VALUE   48.
      *    傷病名最大文字数（適用欄）
           03  WRK-BYOMEI2-MAX     PIC 9(02)   VALUE   44.
      *    適用欄最大行数
           03  WRK-TEKIYOU-LINE    PIC 9(02)   VALUE   35.
      *    傷病名欄最大行数
           03  WRK-BYOMEI-LINE     PIC 9(02)   VALUE   5.
      *    適用欄（続紙）最大行数
           03  WRK-TEKIYOU1-LINE   PIC 9(02)   VALUE   140.
      *    適用欄（続紙）最大行数
           03  WRK-TEKIYOU2-LINE   PIC 9(02)   VALUE   110.
      *
      *   特記事項
       01  TBL-TOKKI-AREA.
           03  FILLER          PIC X(02)   VALUE   "01".
           03  FILLER          PIC X(10)   VALUE   "０１公".
           03  FILLER          PIC X(02)   VALUE   "02".
           03  FILLER          PIC X(10)   VALUE   "０２長".
           03  FILLER          PIC X(02)   VALUE   "03".
           03  FILLER          PIC X(10)   VALUE   "０３長処".
           03  FILLER          PIC X(02)   VALUE   "04".
           03  FILLER          PIC X(10)   VALUE   "０４老保".
           03  FILLER          PIC X(02)   VALUE   "05".
           03  FILLER          PIC X(10)   VALUE   "０５高度".
           03  FILLER          PIC X(02)   VALUE   "07".
           03  FILLER          PIC X(10)   VALUE   "０７老併".
           03  FILLER          PIC X(02)   VALUE   "08".
           03  FILLER          PIC X(10)   VALUE   "０８老健".
           03  FILLER          PIC X(02)   VALUE   "09".
           03  FILLER          PIC X(10)   VALUE   "０９施".
           03  FILLER          PIC X(02)   VALUE   "10".
           03  FILLER          PIC X(10)   VALUE   "１０第三".
           03  FILLER          PIC X(02)   VALUE   "11".
           03  FILLER          PIC X(10)   VALUE   "１１薬治".
           03  FILLER          PIC X(02)   VALUE   "12".
           03  FILLER          PIC X(10)   VALUE   "１２材治".
       01  TBL-TOKKI-R         REDEFINES   TBL-TOKKI-AREA.
           03  TBL-TOKKI       OCCURS   11.
               05  TBL-TOKKICD             PIC X(02).
               05  TBL-TOKKINAME           PIC X(10).
      *
      *   退職者保険番号
       01  WRK-RETIRE-AREA.
      *        組合
           03  WRK-RETIRE1         PIC X(03)   VALUE  "063".
      *        国公
           03  WRK-RETIRE2         PIC X(03)   VALUE  "072".
      *        地公
           03  WRK-RETIRE3         PIC X(03)   VALUE  "073".
      *        警察
           03  WRK-RETIRE4         PIC X(03)   VALUE  "074".
      *        公学・私学
           03  WRK-RETIRE5         PIC X(03)   VALUE  "075".
      *        国保
           03  WRK-RETIRE6         PIC X(03)   VALUE  "067".
      *
      *    疑い編集
       01  WRK-UTAGAI-AREA.
      *    疑い
           03  WRK-CONS-UTAGAI     PIC X(06)   VALUE   "の疑い".
           03  WRK-CONS-UTAGAI-MOJISU
                                   PIC 9(02)   VALUE   6.       
      *    急性
           03  WRK-CONS-KYUSEI     PIC X(04)   VALUE   "急性".      
           03  WRK-CONS-KYUSEI-MOJISU
                                   PIC 9(02)   VALUE   4.       
      *
      *    区切り線
       01  WRK-LINE-AREA.
           03  WRK-KUGIRI1         PIC X(52)   VALUE
               ALL "−".
           03  WRK-KUGIRI2.
               05  FILLER          PIC X(22)   VALUE
                                   "＝＝＝＝＝＝＝　以下　".
               05  WRK-KUGIRI2-KOHNAME         PIC X(10).
               05  FILLER          PIC X(20)   VALUE
                                   "　適用分　＝＝＝＝＝".
           03  WRK-KUGIRI3         PIC X(52)   VALUE
               ALL "−".
      *
      *    改行コード
       01  WRK-CONS-RETURN          PIC X(01)   VALUE   X"0A".
      *
      *
       01  WRK-TENSU-AREA.
           03  WRK-KHNTEN.
               05  WRK-KHNTENZ     PIC  ZZZZZZZ.
           03  WRK-KAISU.
               05  WRK-KAISUZ      PIC  ZZZ.
           03  WRK-KOUTEN.
               05  WRK-KOUTENZ     PIC  ZZZZZZZ.
           03  WRK-TENSU.
               05  WRK-TENSUZ      PIC  ZZZZZZZ.
           03  WRK-JINISSU.
               05  WRK-JINISSUZ    PIC  ZZ.
      *
       01  WRK-CNT                 PIC  9(5).
      *
      *    患者情報（ワーク）
       01  WRK-PTINF-REC.
           COPY    "CPPTINF.INC"      REPLACING  //PTINF//
                                      BY         //WRK-PTINF//.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK2005.INC".
      *     
      *    県内扱い保険者情報
           COPY    "CPSK1033.INC".
      *
      *    医療機関情報
           COPY    "CPSK1001.INC".
           COPY    "CPSK1002.INC".
      *
           COPY    "CPRCF008.INC".
      *
           COPY    "CPRCF010.INC".
      *
      *    保険マスタ
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    レセプトコメントマスタ
       01  RECECOM-REC.
           COPY    "CPRECECOM.INC".
      *
      *    レセプト管理     
       01  RECE07-REC. 
           COPY    "CPRCF007.INC".
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    半角チェックサブ
           COPY    "CPORCSKANACHK.INC".
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
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
                   UNTIL       SPA-STS     =   2
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  SPA-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  SYS-1001-REC
           INITIALIZE                  SYS-1002-REC
      *
           MOVE    COMMAND-PARAM       TO  WRK-PARA
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCR0710"      TO  JOB-PGID
           MOVE    "印刷データ編集"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
      *    ファイルＯＰＥＮ処理
           PERFORM 110-FILE-OPEN-SEC
      *
      *    システム管理マスタ（医療機関情報）
           PERFORM 120-HOSPINF-GET-SEC
      *
           MOVE    ZERO                TO  WRK-RECENUM
      *
           IF      SPA-STS             =   ZERO
              PERFORM 990-RECE62-READ-SEC
           END-IF
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイルＯＰＥＮ処理
      *****************************************************************
       110-FILE-OPEN-SEC          SECTION.
      *
           MOVE    "RECE620"           TO  RECE62PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE62PARA-TERMID
      *
           MOVE    "RECE631"           TO  RECE63PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE63PARA-TERMID
      *
           MOVE    "RECE661"           TO  RECE66PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE66PARA-TERMID
      *
           MOVE    "RECE690"           TO  RECE69PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE69PARA-TERMID
      *
           MOVE    "RECE670"           TO  RECE67PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE67PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
           OPEN    INPUT               RECE62-FILE
           IF  STS-RECE62          NOT =   ZERO
               DISPLAY "*** ORCR0710 RECE62 OPEN ERR  ***"
               MOVE    2               TO  SPA-STS
           END-IF
      *
           OPEN    INPUT               RECE631-FILE
           IF  STS-RECE63          NOT =   ZERO
               DISPLAY "*** ORCR0710 RECE631 OPEN ERR  ***"
               MOVE    2               TO  SPA-STS
           END-IF
      *
           OPEN    INPUT               RECE661-FILE
           IF  STS-RECE66          NOT =   ZERO
               DISPLAY "*** ORCR0710 RECE661 OPEN ERR  ***"
               MOVE    2               TO  SPA-STS
           END-IF
      *
           OPEN    INPUT               RECE69-FILE
           IF  STS-RECE69            NOT =   ZERO
               DISPLAY "*** ORCR0710 RECE69 OPEN ERR  ***" STS-RECE69
               MOVE    2               TO  SPA-STS
           END-IF
      *
           OPEN    INPUT               RECE67-FILE
           IF  STS-RECE67            NOT =   ZERO
               DISPLAY "*** ORCR0710 RECE67 OPEN ERR  ***" STS-RECE67
               MOVE    2               TO  SPA-STS
           END-IF
           .
       110-FILE-OPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    医療機関情報検索
      *****************************************************************
       120-HOSPINF-GET-SEC            SECTION.
      *
           ACCEPT  SYS-YMD         FROM    DATE
           COMPUTE WRK-SYSYY       =   SYS-YY      +   2000
           MOVE    SYS-MM              TO  WRK-SYSMM
           MOVE    SYS-DD              TO  WRK-SYSDD
           ACCEPT  SYS-TIME            FROM    TIME
      *
      *    医療機関情報
           MOVE    SPACE            TO  SYSKANRI-REC
           INITIALIZE                   SYSKANRI-REC
           MOVE    "1001"           TO  SYS-KANRICD
           MOVE    "*"              TO  SYS-KBNCD
           PERFORM 960-KANRIMST-READ-SEC
           IF      FLG-KANRIMST     =   ZERO
               MOVE    MCPDATA-REC   TO  SYS-1001-REC
           ELSE    
               MOVE    "医療機関情報が取得できませんでした。"
                                     TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    2               TO  SPA-STS
               GO  TO  120-HOSPINF-GET-EXT
           END-IF    
      *    医療機関情報（所在地ほか）
           MOVE    SPACE            TO  SYSKANRI-REC
           INITIALIZE                   SYSKANRI-REC
           MOVE    "1002"           TO  SYS-KANRICD
           MOVE    "*"              TO  SYS-KBNCD
           PERFORM 960-KANRIMST-READ-SEC
           IF      FLG-KANRIMST     =   ZERO
               MOVE    MCPDATA-REC      TO  SYS-1002-REC
           ELSE    
               MOVE    "医療機関情報（所在地）が取得できませんでした。"
                                        TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    2               TO  SPA-STS
               GO  TO  120-HOSPINF-GET-EXT
           END-IF
      *         
      *    レセプト編集区分情報
           MOVE    SPACE            TO  SYSKANRI-REC
           INITIALIZE                   SYSKANRI-REC
           MOVE    "2005"           TO  SYS-KANRICD
           MOVE    "*"              TO  SYS-KBNCD
           PERFORM 960-KANRIMST-READ-SEC
           IF      FLG-KANRIMST     =   ZERO
               MOVE    MCPDATA-REC      TO  SYS-2005-REC
           ELSE    
               MOVE    SPACE            TO  SYS-2005-REC
           END-IF
           IF      SYS-2005-BYOMEIHENKBN    =   SPACE
               MOVE    ZERO             TO  SYS-2005-BYOMEIHENKBN
           END-IF
           IF      SYS-2005-TENKIHENKBN     =   SPACE
               MOVE    ZERO             TO  SYS-2005-TENKIHENKBN
           END-IF
      * 
      *    県内扱い保険者情報
           MOVE    SPACE            TO  WRK-1033-TABLE
      *     
           MOVE    SPACE            TO  SYSKANRI-REC
           INITIALIZE                   SYSKANRI-REC
           MOVE    "1033"           TO  SYS-KANRICD
           MOVE    "*"              TO  SYS-KBNCD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY5"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY5"     TO  ORC-DBPATH
               PERFORM 900-KANRIMST-NEXT-SEC
           ELSE
               MOVE    1               TO  FLG-KANRIMST
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM             UNTIL   FLG-KANRIMST   =   1
                               OR      IDX            >=  5
               MOVE    MCPDATA-REC         TO  SYS-1033-REC
               IF      SYS-1033-EDYUKYMD   <   "20021001"
                   CONTINUE
               ELSE    
                   ADD     1              TO  IDX
                   MOVE    SYS-1033-STYUKYMD
                                          TO  WRK-1033-STYUKYMD   (IDX)
                   MOVE    SYS-1033-EDYUKYMD
                                          TO  WRK-1033-EDYUKYMD   (IDX)
                   MOVE    SYS-1033-TBL   TO  WRK-1033-HKNJANUM-G (IDX)
               END-IF    
      *
               MOVE    "SYSKANRI-KEY5"    TO  ORC-DBPATH
               PERFORM 900-KANRIMST-NEXT-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY5"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       120-HOSPINF-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           PERFORM         UNTIL   FLG-RECE62     =   1
                           OR      SPA-STS        =   2 
      *
      *        患者情報読込処理      
               PERFORM 2001-PTINF-HEN-SEC 
      *        患者番号別保険履歴情報編集処理      
               PERFORM 2001-RIREKI-HEN-SEC 
               MOVE    KEY-NEW         TO  KEY-OLD
               PERFORM         UNTIL   FLG-RECE62     =   1
                               OR      SPA-STS        =   2
                               OR      KEY-NEW1   NOT =   KEY-OLD1
      *            レセプト種別別件数カウント
                   MOVE    ZERO            TO  CNT-KENSU
                   MOVE    KEY-NEW         TO  KEY-OLD
                   PERFORM         UNTIL   FLG-RECE62     =   1
                                   OR      SPA-STS        =   2
                                   OR      KEY-NEW    NOT =   KEY-OLD
      *
                       ADD     1                      TO  CNT-KENSU
      *                                      
                       PERFORM 2001-SYORI-SEC
      *
                       PERFORM 990-RECE62-READ-SEC
                   END-PERFORM
               END-PERFORM    
           END-PERFORM
      *
           MOVE    2               TO  SPA-STS
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *        患者情報読込処理      
      *****************************************************************
        2001-PTINF-HEN-SEC       SECTION.
      *
           MOVE    KEY-N-HOSPID        TO  PTINF-HOSPID
           MOVE    KEY-N-PTID          TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           MOVE    PTINF-REC           TO  WRK-PTINF-REC
           . 
        2001-PTINF-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号別保険履歴情報編集処理
      *****************************************************************
       2001-RIREKI-HEN-SEC      SECTION.
      *
      *    診療年月編集
           MOVE    RECE62-SRYYM        TO  WRK-SYMD (1:6)
           MOVE    "01"                TO  WRK-SYMD (7:2)
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    LNK-DAY2-EDTYMD3 (11:12)
                                       TO  WRK-SRYYMST
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY7-AREA
           MOVE    "71"                TO  LNK-DAY7-IRAI
           MOVE    RECE62-SRYYM        TO  LNK-DAY7-YM
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY7-AREA
           MOVE    LNK-DAY7-KOYOMI     TO  WRK-SYMD 
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    LNK-DAY2-EDTYMD3 (11:12)
                                       TO  WRK-SRYYMED
      *
           MOVE    SPACE               TO  WRK-HKN-RIREKI-AREA
           MOVE    ZERO                TO  WRK-RIREKI-MAX
                                           CNT-RECE69
      *     
           INITIALIZE                      RECE69-REC
           MOVE    RECE62-HOSPID       TO  RECE69-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE69-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE69-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE69-PTID
           MOVE    RECE62-RECEKA       TO  RECE69-RECEKA
      *
           START   RECE69-FILE
               KEY IS    >=   RECE69-KEY
               INVALID
                   MOVE    1            TO  FLG-RECE69
               NOT INVALID
                   PERFORM 990-RECE69-NEXT-SEC
           END-START
           PERFORM UNTIL ( FLG-RECE69           =   1                )
                   OR    ( RECE62-HOSPID    NOT =   RECE69-HOSPID    )
                   OR    ( RECE62-SRYYM     NOT =   RECE69-SRYYM     )
                   OR    ( RECE62-NYUGAIKBN NOT =   RECE69-NYUGAIKBN )
                   OR    ( RECE62-PTID      NOT =   RECE69-PTID      )
                   OR    ( RECE62-RECEKA    NOT =   RECE69-RECEKA    )
      *
               ADD     1                  TO  CNT-RECE69
      *
               ADD     1                  TO  WRK-RIREKI-MAX
               IF      WRK-RIREKI-MAX     >   50
                   MOVE    "保険履歴情報がテーブルオーバーしました"
                                              TO  WRK-RECEERR
                   PERFORM 500-ERR-HENSYU-SEC
                   MOVE    2               TO  SPA-STS
                   GO  TO  2001-RIREKI-HEN-EXT
               END-IF    
      *
               EVALUATE    RECE69-TEISYUTUSAKI
                   WHEN    "1"
                       MOVE    "社保"     TO  WRK-HKN-TEISYUTUSAKI
                   WHEN    OTHER
                       MOVE    SPACE      TO  WRK-HKN-TEISYUTUSAKI   
               END-EVALUATE          
               IF      RECE69-NUM         =   SPACE
               AND     RECE69-KIGO        =   SPACE        
                   STRING  WRK-HKN-TEISYUTUSAKI   DELIMITED  BY  SPACE
                           RECE69-TANSEIDONAME    DELIMITED  BY  SPACE
                              INTO    WRK-HKN-RIREKI (WRK-RIREKI-MAX)
               ELSE               
                   INITIALIZE              ORCSKANACHKAREA
                   MOVE    "2"             TO  KANACHK-SYORI 
                   MOVE    RECE69-KIGO     TO  KANACHK-MAE-INPUT
                   CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
                   IF      KANACHK-RC      =   ZERO
                       MOVE    KANACHK-OUT-INPUT(1:KANACHK-MAX)
                                           TO  WRK-HKN-KIGO
                   END-IF    
                   INITIALIZE              ORCSKANACHKAREA
                   MOVE    "2"             TO  KANACHK-SYORI 
                   MOVE    RECE69-NUM      TO  KANACHK-MAE-INPUT
                   CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
                   IF      KANACHK-RC      =   ZERO
                       MOVE    KANACHK-OUT-INPUT(1:KANACHK-MAX)
                                               TO  WRK-HKN-NUM
                   END-IF    
                   STRING  WRK-HKN-TEISYUTUSAKI   DELIMITED  BY  SPACE
                           RECE69-TANSEIDONAME    DELIMITED  BY  SPACE
                           "　"                   DELIMITED  BY  SIZE
                           WRK-HKN-KIGO           DELIMITED  BY  SPACE
                           "−"                   DELIMITED  BY  SIZE
                           WRK-HKN-NUM            DELIMITED  BY  SPACE
                              INTO    WRK-HKN-RIREKI (WRK-RIREKI-MAX)
                   END-STRING           
               END-IF                   
               IF      WRK-HKN-RIREKI (WRK-RIREKI-MAX)(13:)
                                          NOT =   SPACE
                   ADD     1                   TO  WRK-RIREKI-MAX
                   IF      WRK-RIREKI-MAX     >   50
                       MOVE    "保険履歴情報がテーブルオーバーしました"
                                                   TO  WRK-RECEERR
                       PERFORM 500-ERR-HENSYU-SEC
                       MOVE    2               TO  SPA-STS
                       GO  TO  2001-RIREKI-HEN-EXT
                   END-IF    
               END-IF                             
      *
               MOVE    RECE69-TEKSTYMDX   TO  WRK-SYMD
               PERFORM 31012-SEIWA-HEN-SEC
               IF      RECE69-TEKSTYMDX(1:6)  =   RECE62-SRYYM                      
                   MOVE    LNK-DAY2-EDTYMD3(11:12)    TO  
                                  WRK-HKN-TEKSTYMD(WRK-RIREKI-MAX)(9:)
               ELSE
                   MOVE    LNK-DAY2-EDTYMD3-G(1:2)    TO  
                                  WRK-HKN-TEKSTYMD(WRK-RIREKI-MAX)(1:2)
                   MOVE    LNK-DAY2-EDTYMD3(5:18)     TO  
                                  WRK-HKN-TEKSTYMD(WRK-RIREKI-MAX)(3:)
               END-IF                                    
      *  
               IF      RECE69-TEKEDYMDX(1:6)  =   RECE62-SRYYM                      
                   MOVE    RECE69-TEKEDYMDX   TO  WRK-SYMD
                   PERFORM 31012-SEIWA-HEN-SEC
                   MOVE    LNK-DAY2-EDTYMD3(11:12)    TO
                                      WRK-HKN-TEKEDYMD(WRK-RIREKI-MAX)
                   MOVE    "から"             TO
                                      WRK-HKN-FL1     (WRK-RIREKI-MAX)
                   MOVE    "まで"             TO
                                      WRK-HKN-FL2     (WRK-RIREKI-MAX)                                     
               ELSE
                   MOVE    "から有効"         TO
                                      WRK-HKN-FL      (WRK-RIREKI-MAX) 
               END-IF                                    
      *
               PERFORM 990-RECE69-NEXT-SEC
           END-PERFORM
      *
           IF      CNT-RECE69             =   1
               MOVE    SPACE                  TO  WRK-HKN-RIREKI-AREA
               MOVE    ZERO                   TO  WRK-RIREKI-MAX
           END-IF          
      *
           .
       2001-RIREKI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       2001-SYORI-SEC                SECTION.
      *
           MOVE    1         TO  CNT-PAGE
      *
      *    医療保険・公費のフラグ
           MOVE    SPACE              TO  WRK-3SYU-KBN
           MOVE    ZERO               TO  SEIHIDX
           MOVE    ZERO               TO  KAKKIDX
           MOVE    ZERO               TO  SESNIDX
           PERFORM   VARYING   IDX  FROM    1   BY  1
                     UNTIL   ( IDX                >    4    )
                     OR      ( RECE62-KOHID(IDX)  =   SPACE )
      *        生保
               IF  RECE62-KOHNUM (IDX)  =   "012"
                   MOVE    "1"          TO  WRK-3SYU (1:1)
                   MOVE     IDX         TO  SEIHIDX
               END-IF
      *        結核
               IF  RECE62-KOHNUM (IDX)  =   "010"  OR  "011"
                   MOVE    "1"          TO  WRK-3SYU (2:1)
                   MOVE     IDX         TO  KAKKIDX
               END-IF
      *        精神
               IF  RECE62-KOHNUM (IDX)  =   "020"  OR  "021"
                   MOVE    "1"          TO  WRK-3SYU (3:1)
                   MOVE     IDX         TO  SESNIDX
               END-IF
           END-PERFORM
      *
      *    県単用項目ファイル読込処理
           PERFORM 301-RECE67-HENSYU-SEC
      *
      *    帳票編集<ヘッダー部>処理
           PERFORM 310-HC101-HEAD-HEN-SEC
      *
      *    帳票編集<点数>処理
           PERFORM 330-HC101-TENSU-HEN-SEC
      *
      *    帳票編集<補足>処理
           PERFORM 350-HC101-HOSOKU-HEN-SEC
      *
      *    帳票編集<傷病名>処理
           PERFORM 320-HC101-BYOMEI-HEN-SEC
      *
      *    帳票編集<剤>処理
           PERFORM 340-HC101-ZAI-HEN-SEC
      *
      *    帳票編集<コメント>処理
           PERFORM 360-HC101-COMMENT-HEN-SEC 
      *
      *    帳票編集<保険履歴情報>処理
           PERFORM 370-HC101-HKN-RIREKI-HEN-SEC 
      *
      *    帳票印刷処理
           PERFORM 390-PRINT-OUT-SEC
      *
           .
       2001-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    県単用項目ファイル読込処理
      *****************************************************************
       301-RECE67-HENSYU-SEC           SECTION.
      *
           MOVE    SPACE               TO  RECE67-HC06
      *       
           INITIALIZE                      RECE67-REC
           MOVE    RECE62-HOSPID       TO  RECE67-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE67-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE67-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE67-PTID
           MOVE    RECE62-RECEKA       TO  RECE67-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE67-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE67-RECESYUBETU
           MOVE    RECE62-HKNJANUM-KEY TO  RECE67-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE67-HOJOKBN
           MOVE    RECE62-TEKSTYMD     TO  RECE67-TEKSTYMD
           PERFORM 990-RECE67-READ-SEC
           IF      FLG-RECE67          =   ZERO
               MOVE    RECE67-PRTDATA      TO  RECE67-HC06
           END-IF    
           .
       301-RECE67-HENSYU-EXT.
           EXIT.
      *     
      *****************************************************************
      *    帳票編集<ヘッダー部>処理
      *****************************************************************
       310-HC101-HEAD-HEN-SEC          SECTION.
      *
           INITIALIZE                      HC06
           MOVE    SPACE               TO  HC06
      *
      *    患者番号
           MOVE    RECE62-PTNUM        TO  HC06-PTNUM
      *
      *    提出先
           IF      RECE62-RECESYUBETU  =    "0000"  OR  "8888"
               MOVE    SPACE           TO  HC06-TEISYUTUSAKI
           ELSE    
               EVALUATE    RECE62-TEISYUTUSAKI
                   WHEN    1
                       MOVE    "１社"          TO  HC06-TEISYUTUSAKI
                   WHEN    2
                       MOVE    "２国"          TO  HC06-TEISYUTUSAKI
                   WHEN    OTHER
                       MOVE    SPACE           TO  HC06-TEISYUTUSAKI
               END-EVALUATE
           END-IF    
      *
      *    診療年月（診療年月日として退避）
           MOVE    RECE62-SRYYM        TO  WRK-SYMD
           MOVE    "01"                TO  WRK-SDD
           MOVE    WRK-SYMD            TO  WRK-SRYYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    LNK-DAY2-EDTYMD1-Y  TO  HC06-SRYY 
           MOVE    LNK-DAY2-EDTYMD1-M  TO  HC06-SRYM 
      *
      *    県番
           MOVE    SYS-1001-PREFNUM    TO  HC06-PREFNUM
      *
      *    医療機関コード
           MOVE    SYS-1001-HOSPCDN    TO  HC06-HOSPCDN
      *
      *    保険種別１
           PERFORM 3110-HKNSBT1-SET-SEC
      *
      *    保険種別２
           PERFORM 3110-HKNSBT2-SET-SEC
      *
      *    本人・家族
           PERFORM 3110-HONKZK-SET-SEC
      *
      *    老人保険−市町村番号
           MOVE    RECE62-RJNFTNJANUM  TO  HC06-RJNFTNJANUM
      *
      *    老人保険−受給者番号
           MOVE    RECE62-RJNJKYSNUM   TO  HC06-RJNJKYSNUM
      *
      *    保険者番号・公費−負担者番号・受給者番号・診療実日数・記号番号
           PERFORM 3110-KANREN-NUM-SET-SEC
      *
      *    給付割合
           PERFORM 3110-KYURATE-SET-SEC
      *
      *    カナ氏名
           MOVE    RECE62-KANANAME     TO  HC06-KANANAME
      *
      *    氏名
           MOVE    RECE62-NAME         TO  HC06-NAME
      *
      *    性別
           EVALUATE    RECE62-SEX
           WHEN    "1"
               MOVE    "１"            TO  HC06-SEXNUM
               MOVE    "男"            TO  HC06-SEXN
           WHEN    "2"
               MOVE    "２"            TO  HC06-SEXNUM
               MOVE    "女"            TO  HC06-SEXN
           END-EVALUATE
      *
      *    生年月日
           MOVE    RECE62-BIRTHDAY     TO  WRK-SYMD
           PERFORM 31012-SE-WA-YMDEDIT-SEC
           INITIALIZE              ORCSKANACHKAREA
           MOVE    "2"             TO  KANACHK-SYORI 
           MOVE    LNK-DAY1-GENGO    TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      KANACHK-RC      =   ZERO
               MOVE    KANACHK-OUT-INPUT(1:KANACHK-MAX)
                                       TO  HC06-BIRTHDAY(1:)
           END-IF    
           MOVE    RECE62-BIRTHDAY     TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    LNK-DAY2-EDTYMD2 (1:2)
                                       TO  HC06-BIRTHDAY(3:2)
           MOVE    LNK-DAY2-EDTYMD2 (5:)
                                       TO  HC06-BIRTHDAY(5:)
      *
      *    特記事項
           PERFORM 3110-TOKKI-SET-SEC
      *
      *    職務上の事由
           EVALUATE    RECE62-HKNNUM
               WHEN    "002"
               WHEN    "031"  THRU  "034"
                   EVALUATE    RECE62-HOJOKBN
                       WHEN    "1"
                       WHEN    "A"
                       WHEN    "D"
                           MOVE    "職務上"              TO  HC06-JIYU
                       WHEN    "2"
                       WHEN    "B"
                       WHEN    "E"
                           MOVE    "下船後３ヶ月以内"    TO  HC06-JIYU
                       WHEN    "3"
                       WHEN    "C"
                       WHEN    "F"
                           MOVE    "通勤災害"            TO  HC06-JIYU
                   END-EVALUATE
           END-EVALUATE        
      *
      *    医療機関所在地
           MOVE    SYS-1002-ADRS       TO  HC06-HOSPADRS
      *
      *    医療機関名称
           MOVE    SYS-1001-HOSPNAME   TO  HC06-HOSPNAME
      *
      *    医療機関ＴＥＬ
           MOVE    SYS-1002-TEL        TO  HC06-HOSPTEL
      *
      *     診療科
      *     IF  RECE62-SRYKA        NOT =   SPACE
      *         MOVE    SPACE           TO  HC06-SRYKA
      *     ELSE
               MOVE    SPACE           TO  HC06-SRYKA
      *     END-IF
      *
      *    病床数
           MOVE    SYS-1001-BEDSU      TO  WRK-BEDSU
           MOVE    WRK-BEDSU           TO  HC06-BEDSU
      *
      *    県単用項目
           IF      CNT-PAGE            =   1
           AND     FLG-RECE67          =   ZERO
               INSPECT RECE67-HC06-HEAD1-G  REPLACING   ALL "  "
                                                        BY  "　" 
               INSPECT RECE67-HC06-HEAD2-G  REPLACING   ALL "  "
                                                        BY  "　" 
               INSPECT RECE67-HC06-HEAD3-G  REPLACING   ALL "  "
                                                        BY  "　" 
               MOVE    RECE67-HC06-HEAD1-G TO  HC06-HEAD1-G
               MOVE    RECE67-HC06-HEAD2-G TO  HC06-HEAD2-G
               MOVE    RECE67-HC06-HEAD3-G TO  HC06-HEAD3-G
           END-IF
      *
           .
       310-HC101-HEAD-HEN-EXT.
           EXIT.
      *     
      *****************************************************************
      *    帳票編集<続紙ヘッダー部>処理
      *****************************************************************
       310-HC102-HEAD-HEN-SEC          SECTION.
      *
           INITIALIZE                      HC061
           MOVE    SPACE               TO  HC061
      *
      *    患者番号
           MOVE    RECE62-PTNUM        TO  HC061-PTNUM
      *
      *    提出先
           MOVE    HC06-TEISYUTUSAKI   TO  HC061-TEISYUTUSAKI
      *
      *    診療年月
           MOVE    HC06-SRYY           TO  HC061-SRYY 
           MOVE    HC06-SRYM           TO  HC061-SRYM 
      *
      *    県番
           MOVE    SYS-1001-PREFNUM    TO  HC061-PREFNUM
      *
      *    医療機関コード
           MOVE    SYS-1001-HOSPCDN    TO  HC061-HOSPCDN
      *
      *    保険種別１
           MOVE    HC06-HKNSBT1        TO  HC061-HKNSBT1  
      *
      *    保険種別２
           MOVE    HC06-HKNSBT2        TO  HC061-HKNSBT2  
      *
      *    本人・家族
           MOVE    HC06-HONKZK         TO  HC061-HONKZK
      *
      *    老人保険−市町村番号
           MOVE    HC06-RJNFTNJANUM    TO  HC061-RJNFTNJANUM
      *
      *    老人保険−受給者番号
           MOVE    HC06-RJNJKYSNUM     TO  HC061-RJNJKYSNUM
      * 
      *    保険者番号・記号番号
           MOVE    HC06-HKNJANUM       TO  HC061-HKNJANUM
           MOVE    HC06-KIGO           TO  HC061-KIGO
           MOVE    HC06-NUM            TO  HC061-NUM
      *     
      *    公費−負担者番号・受給者番号
           IF      HC06-KOHJKYSNUM1N   =   SPACE
               MOVE    HC06-KOHJKYSNUM1    TO  HC061-KOHJKYSNUM1
           ELSE
               MOVE    HC06-KOHJKYSNUM1N   TO  HC061-KOHJKYSNUM1N
           END-IF
           IF      HC06-KOHJKYSNUM2N   =   SPACE
               MOVE    HC06-KOHJKYSNUM2    TO  HC061-KOHJKYSNUM2
           ELSE
               MOVE    HC06-KOHJKYSNUM2N   TO  HC061-KOHJKYSNUM2N
           END-IF
           IF      HC06-KOHFTNJANUM1N  =   SPACE
               MOVE    HC06-KOHFTNJANUM1   TO  HC061-KOHFTNJANUM1
           ELSE
               MOVE    HC06-KOHFTNJANUM1N  TO  HC061-KOHFTNJANUM1N
           END-IF
           IF      HC06-KOHFTNJANUM2N  =   SPACE
               MOVE    HC06-KOHFTNJANUM2   TO  HC061-KOHFTNJANUM2
           ELSE
               MOVE    HC06-KOHFTNJANUM2N  TO  HC061-KOHFTNJANUM2N
           END-IF
      *
      *    給付割合
           MOVE    HC06-KYURATE        TO  HC061-KYURATE
      *
      *    氏名
           MOVE    HC06-NAME           TO  HC061-NAME
           .
       310-HC102-HEAD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票  <保険種別１>編集処理
      *****************************************************************
       3110-HKNSBT1-SET-SEC              SECTION.
      *
      *    不明分・自費は編集しない
           IF      RECE62-RECESYUBETU     =    "0000"  OR
                                               "8888"
               CONTINUE
           ELSE                                        
               EVALUATE    RECE62-RECESYUBETU (2:1)
                   WHEN    "1"
                       EVALUATE    RECE62-TEISYUTUSAKI
                           WHEN    1
                               MOVE    "１社"      TO  HC06-HKNSBT1
                           WHEN    2
                               MOVE    "１国"      TO  HC06-HKNSBT1
                       END-EVALUATE
                   WHEN    "2"
                       MOVE    "２公費"        TO  HC06-HKNSBT1
                   WHEN    "3"
                       MOVE    "３老人"        TO  HC06-HKNSBT1
                   WHEN    "4"
                       MOVE    "４退職"        TO  HC06-HKNSBT1
               END-EVALUATE
           END-IF    
      *
           .
       310-HKNSBT1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票  <保険種別２>編集処理
      *****************************************************************
       3110-HKNSBT2-SET-SEC              SECTION.
      *
      *    不明分・自費は編集しない
           IF      RECE62-RECESYUBETU     =    "0000"  OR
                                               "8888"
               CONTINUE
           ELSE                                        
               EVALUATE    RECE62-RECESYUBETU (3:1)
                   WHEN    "1"
                       MOVE    "１単独"        TO  HC06-HKNSBT2
                   WHEN    "2"
                       MOVE    "２２併"        TO  HC06-HKNSBT2
                   WHEN    "3"
                       MOVE    "３３併"        TO  HC06-HKNSBT2
               END-EVALUATE
           END-IF    
      *
           .
       310-HKNSBT2-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票  <本人・家族>編集処理
      *****************************************************************
       3110-HONKZK-SET-SEC             SECTION.
      *
      *    不明分・自費は編集しない
           IF      RECE62-RECESYUBETU     =    "0000"  OR
                                               "8888"
               CONTINUE
           ELSE                                        
               EVALUATE    RECE62-RECESYUBETU (4:1)
                   WHEN    "1"
                       MOVE    "１本入"     TO  HC06-HONKZK
                   WHEN    "3"
                       MOVE    "３三入"     TO  HC06-HONKZK
                   WHEN    "5"
                       MOVE    "５家入"     TO  HC06-HONKZK
                   WHEN    "7"
                       MOVE    "７高入９"   TO  HC06-HONKZK
                   WHEN    "9"
                       MOVE    "９高入８"   TO  HC06-HONKZK
               END-EVALUATE
           END-IF    
      *
           .
       310-HONKZK-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票  主保険−保険者番号８桁
      *          公費−負担者番号  ８桁
      *          記号・番号　診療実日数     編集処理
      *****************************************************************
       3110-KANREN-NUM-SET-SEC        SECTION.
      *
      *    <保険者番号>
           MOVE    SPACE              TO  WRK-HKNJANUM
      *     
           IF      WRK-3SYU-KBN           =   ALL "1" AND 
                   RECE62-HKNNUM          =   SPACE            
      *        ３種の場合（８桁）
               MOVE    RECE62-KOHFTNJANUM(SEIHIDX)  TO  WRK-HKNJANUM
           ELSE
               IF  RECE62-TEISYUTUSAKI    =   "2"
                   IF      RECE62-HKNJANUM (1:2)  =   "67"
                       MOVE    RECE62-HKNJANUM  TO  WRK-HKNJANUM
                   ELSE
      *            国保の場合（６桁右詰に編集）
                       MOVE    SPACE              TO  WRK-HKNJANUM(1:2)
                       MOVE    RECE62-HKNJANUM    TO  WRK-HKNJANUM(3:)
                   END-IF
               ELSE
                   IF  RECE62-HKNNUM      =   "001"
      *                政府管掌の場合（４桁右詰に編集）
                       MOVE    SPACE            TO  WRK-HKNJANUM(1:4)
                       MOVE    RECE62-HKNJANUM  TO  WRK-HKNJANUM(5:)
                   ELSE
      *                他の保険の場合（８桁）
                       MOVE    RECE62-HKNJANUM  TO  WRK-HKNJANUM
                   END-IF
               END-IF
           END-IF
             MOVE   WRK-HKNJANUM    TO    HC06-HKNJANUM
      *
      *    <記号・番号>
           IF      WRK-3SYU-KBN           =   ALL "1" AND 
                   RECE62-HKNNUM          =   SPACE            
      *        ３種の場合（８桁）
               INITIALIZE              ORCSKANACHKAREA
               MOVE    "2"             TO  KANACHK-SYORI 
               MOVE    RECE62-KOHJKYSNUM(SEIHIDX)
                                       TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
               IF      KANACHK-RC      =   ZERO
                   MOVE    KANACHK-OUT-INPUT(1:KANACHK-MAX)
                                           TO  HC06-KIGO
               END-IF    
           ELSE 
               INITIALIZE              ORCSKANACHKAREA
               MOVE    "2"             TO  KANACHK-SYORI 
               MOVE    RECE62-KIGO       TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
               IF      KANACHK-RC      =   ZERO
                   MOVE    KANACHK-OUT-INPUT(1:KANACHK-MAX)
                                           TO  HC06-KIGO
               END-IF    
               INITIALIZE              ORCSKANACHKAREA
               MOVE    "2"             TO  KANACHK-SYORI 
               MOVE    RECE62-NUM      TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
               IF      KANACHK-RC      =   ZERO
                   MOVE    KANACHK-OUT-INPUT(1:KANACHK-MAX)
                                           TO  HC06-NUM
               END-IF    
           END-IF
      *
      *    <公費負担者番号・公費受給者番号>
      *    
           IF      WRK-3SYU-KBN           =   ALL "1" AND 
                   RECE62-HKNNUM          =   SPACE            
      *        ３種の場合
               IF  KAKKIDX         >   SESNIDX
                   MOVE    SESNIDX     TO  IDA
                   MOVE    KAKKIDX     TO  IDB
               ELSE
                   MOVE    KAKKIDX     TO  IDA
                   MOVE    SESNIDX     TO  IDB
               END-IF
               COMPUTE IDX1     =   SEIHIDX    +   1
               COMPUTE IDX2     =   IDA        +   1
               COMPUTE IDX3     =   IDB        +   1
           ELSE    
      *        ３種以外の場合
               MOVE    1               TO  IDA
               MOVE    2               TO  IDB
               MOVE    1               TO  IDX1
               MOVE    2               TO  IDX2
               MOVE    3               TO  IDX3
           END-IF
      *    公負１
           INITIALIZE              ORCSKANACHKAREA
           MOVE    "1"             TO  KANACHK-SYORI 
           MOVE    RECE62-KOHFTNJANUM(IDA)
                                   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      KANACHK-RC      =   ZERO
               IF      KANACHK-SYUBETU =   1
                   MOVE    RECE62-KOHFTNJANUM(IDA)
                                       TO  HC06-KOHFTNJANUM1
               ELSE
                   MOVE    RECE62-KOHFTNJANUM(IDA)
                                       TO  HC06-KOHFTNJANUM1N
               END-IF                        
           END-IF    
      *    公負２
           INITIALIZE              ORCSKANACHKAREA
           MOVE    "1"             TO  KANACHK-SYORI 
           MOVE    RECE62-KOHFTNJANUM(IDB)
                                   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      KANACHK-RC      =   ZERO
               IF      KANACHK-SYUBETU =   1
                   MOVE    RECE62-KOHFTNJANUM(IDB)
                                       TO  HC06-KOHFTNJANUM2
               ELSE
                   MOVE    RECE62-KOHFTNJANUM(IDB)
                                       TO  HC06-KOHFTNJANUM2N
               END-IF                        
           END-IF    
      *    公受１
           INITIALIZE              ORCSKANACHKAREA
           MOVE    "1"             TO  KANACHK-SYORI 
           MOVE    RECE62-KOHJKYSNUM(IDA)
                                   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      KANACHK-RC      =   ZERO
               IF      KANACHK-SYUBETU =   1
                   MOVE    RECE62-KOHJKYSNUM(IDA)
                                       TO  HC06-KOHJKYSNUM1
               ELSE
                   MOVE    RECE62-KOHJKYSNUM(IDA)
                                       TO  HC06-KOHJKYSNUM1N
               END-IF                        
           END-IF    
      *    公受２
           INITIALIZE              ORCSKANACHKAREA
           MOVE    "1"             TO  KANACHK-SYORI 
           MOVE    RECE62-KOHJKYSNUM(IDB)
                                   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      KANACHK-RC      =   ZERO
               IF      KANACHK-SYUBETU =   1
                   MOVE    RECE62-KOHJKYSNUM(IDB)
                                       TO  HC06-KOHJKYSNUM2
               ELSE
                   MOVE    RECE62-KOHJKYSNUM(IDB)
                                       TO  HC06-KOHJKYSNUM2N
               END-IF                        
           END-IF    
      *
      *    <診療実日数>
           IF      CNT-PAGE        =   1
               MOVE    RECE62-JNISSU (IDX1)
                                       TO  WRK-JINISSUZ
               MOVE    WRK-JINISSU     TO  HC06-JINISSU
               IF  RECE62-JNISSU (IDX1)
                                   NOT =   RECE62-JNISSU (IDX2)
                   MOVE    RECE62-JNISSU (IDX2)
                                           TO  WRK-JINISSUZ
                   MOVE    WRK-JINISSU     TO  HC06-JINISSU1
               END-IF
               IF  RECE62-JNISSU (IDX1)
                                   NOT =   RECE62-JNISSU (IDX3)
                   MOVE    RECE62-JNISSU (IDX3)
                                           TO  WRK-JINISSUZ
                   MOVE    WRK-JINISSU     TO  HC06-JINISSU2
               END-IF
           END-IF
      *
           .
       3110-KANREN-NUM-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票  <給付割合>　編集処理
      *****************************************************************
       3110-KYURATE-SET-SEC        SECTION.
      *
           MOVE   SPACE              TO  HC06-KYURATE
      *          
      *    国保OR退職者のみ印字
           IF  ((RECE62-TEISYUTUSAKI =   "2"  )       AND
                (RECE62-RJNHKNNUM    =   SPACE)           )  OR
               ( RECE62-HKNNUM       =   WRK-RETIRE1  OR
                                         WRK-RETIRE2  OR
                                         WRK-RETIRE3  OR
                                         WRK-RETIRE4  OR
                                         WRK-RETIRE5  OR
                                         WRK-RETIRE6      )
               IF      RECE62-AGE        <   70                          
                   COMPUTE WRK-KYURATE-9   =   (100 -   RECE62-KYURATE)
                                               / 10 
                   IF      WRK-KYURATE-9       >   ZERO
                       MOVE   "給割"               TO  HC06-KYURATE
                       MOVE    WRK-KYURATE-9       TO  WRK-KYURATE
                       INITIALIZE              ORCSKANACHKAREA
                       MOVE    "2"             TO  KANACHK-SYORI 
                       MOVE    WRK-KYURATE     TO  KANACHK-MAE-INPUT
                       CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
                       IF      KANACHK-RC      =   ZERO
                           MOVE    KANACHK-OUT-INPUT(1:KANACHK-MAX)
                                               TO  HC06-KYURATE(5:)
                       END-IF    
                   END-IF
               END-IF    
           END-IF
           .
       3110-KYURATE-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票  <特記事項>　編集処理
      *****************************************************************
       3110-TOKKI-SET-SEC          SECTION.
      *
           MOVE    ZERO                TO  IDZ
      *     
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL ( IDX                 >   5     )
                   OR    ( RECE62-TOKKI(IDX)   =   SPACE )
                   OR    ( IDZ                 =   4     ) 
      *
               MOVE    SPACE                   TO  HC06-TOKKI (IDX)
               PERFORM VARYING IDX2    FROM    1   BY  1
                       UNTIL ( IDX2            >   11    )
                       OR    ( HC06-TOKKI (IDX)
                                           NOT =   SPACE )
                   IF      RECE62-TOKKI(IDX)   =   TBL-TOKKICD(IDX2)
                       ADD     1                TO  IDZ
                       MOVE    TBL-TOKKINAME(IDX2)
                                                TO  HC06-TOKKI (IDZ)
                   END-IF
               END-PERFORM
           END-PERFORM
      *
      *    県単用項目
           IF      FLG-RECE67           =   ZERO
               PERFORM VARYING IDX     FROM    1   BY  1
                       UNTIL   IDX                 >   4
                       OR      IDZ                 =   4     
                       OR      RECE67-HC06-TOKKI(IDX)  =   SPACE
                   ADD     1                    TO  IDZ    
                   MOVE    RECE67-HC06-TOKKI (IDX)           
                                                TO  HC06-TOKKI (IDZ)
               END-PERFORM
           END-IF
      *
           .
       3110-TOKKI-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<傷病名>処理
      *****************************************************************
       320-HC101-BYOMEI-HEN-SEC      SECTION.
      *
      *    パラメータ０３ファイルより編集
           MOVE    LOW-VALUE           TO  WRK-BYO-OLD
      *     
           INITIALIZE                  WRK-EDIT-AREA
           MOVE    SPACE               TO  WRK-BYOMEI1
                                           WRK-BYOMEI2
           MOVE    ZERO                TO  FLG-TENKI                                
      *     
           INITIALIZE                      RECE631-REC
           MOVE    RECE62-HOSPID       TO  RECE631-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE631-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE631-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE631-PTID
           MOVE    RECE62-RECEKA       TO  RECE631-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE631-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE631-RECESYUBETU
           MOVE    RECE62-HKNJANUM-KEY TO  RECE631-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE631-HOJOKBN
           MOVE    RECE62-TEKSTYMD     TO  RECE631-TEKSTYMD
      *
           START   RECE631-FILE
               KEY IS    >=   RECE631-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE631
               NOT INVALID
                   PERFORM 990-RECE631-NEXT-SEC
           END-START
      *
           PERFORM
               UNTIL  ( FLG-RECE631          =   1                    )
               OR     ( RECE62-HOSPID    NOT =   RECE631-HOSPID       )
               OR     ( RECE62-SRYYM     NOT =   RECE631-SRYYM        )
               OR     ( RECE62-NYUGAIKBN NOT =   RECE631-NYUGAIKBN    )
               OR     ( RECE62-PTID      NOT =   RECE631-PTID         )
               OR     ( RECE62-RECEKA    NOT =   RECE631-RECEKA       )
               OR     ( RECE62-TEISYUTUSAKI
                                         NOT =   RECE631-TEISYUTUSAKI )
               OR     ( RECE62-RECESYUBETU
                                         NOT =   RECE631-RECESYUBETU  )
               OR     ( RECE62-HKNJANUM-KEY
                                         NOT =   RECE631-HKNJANUM     )
               OR     ( RECE62-HOJOKBN-KEY
                                         NOT =   RECE631-HOJOKBN      )
               OR     ( RECE62-TEKSTYMD  NOT =   RECE631-TEKSTYMD     )
      *    
      *        病名編集処理
               PERFORM 3210-BYOMEI-SET-SEC
      *
           END-PERFORM
      *
           MOVE    1               TO  FLG-RECE631     
      *
           IF  WRK-LINEBYO      <  WRK-BYOMEI-LINE
               IF  WRK-BYOMEI1-NAME  NOT =   SPACE
                   PERFORM 3221-BYOMEI1-OUT-SEC
               END-IF
           ELSE
               IF  WRK-BYOMEI2-NAME  NOT =   SPACE
                   MOVE    1             TO  FLG-TENKI
                   PERFORM 3222-BYOMEI2-OUT-SEC
                   MOVE    ZERO          TO  FLG-TENKI
               END-IF
           END-IF
      *
           .
       320-HC101-BYOMEI-HEN-EXT.
           EXIT.
      ****************************************************************
      *     病名編集処理
      ****************************************************************
       3210-BYOMEI-SET-SEC           SECTION.
      * 
      *    連結表示のとき
           IF      SYS-2005-BYOMEIHENKBN    =   "0"
      *        前のデータと同一主病名フラグ・診療開始日・転帰区分
               IF  ( RECE631-SYUBYOFLG    =   WRK-BO-SYUBYOFLG )  AND
                   ( RECE631-SRYYMD       =   WRK-BO-SRYYMD    )  AND
                   ( RECE631-TENKIKBN     =   WRK-BO-TENKIKBN  )  AND 
                   ( RECE631-TENKIYMD     =   WRK-BO-TENKIYMD  )   
      *
      *            病名をつなげると何桁になるかを計算（，＋病名）
                   IF  WRK-CLM           =   ZERO
                       MOVE    WRK-CLM   TO  WRK-WCLM
                   ELSE
                       COMPUTE WRK-WCLM  =   WRK-CLM   +   2
                   END-IF
                   COMPUTE     WRK-WCLM  =
                              ( RECE631-BYOMEIMOJI  *   2 )
                                                    +   WRK-WCLM
      *
                   EVALUATE    TRUE
      *                傷病名欄に編集
                       WHEN    WRK-LINEBYO     <   WRK-BYOMEI-LINE
                           IF  WRK-WCLM          >   WRK-BYOMEI1-MAX
                               PERFORM 3221-BYOMEI1-OUT-SEC
                           ELSE
                               IF  WRK-CLM       >   ZERO
      *                            前の病名の直後に編集
                                   COMPUTE WRK-STCLM =   WRK-CLM   +
                                                         1
                                   MOVE    "，"  TO  WRK-BYOMEI1-NAME
                                                           (WRK-STCLM:)
                                   COMPUTE WRK-CLM   =   WRK-CLM   +
                                                         2
                               END-IF
                           END-IF
      *                適用欄に編集
                       WHEN    WRK-LINEBYO     >=  WRK-BYOMEI-LINE
                           IF  WRK-WCLM          >   WRK-BYOMEI2-MAX
                               MOVE    1             TO  FLG-TENKI
                               PERFORM 3222-BYOMEI2-OUT-SEC
                               MOVE    ZERO          TO  FLG-TENKI
                           ELSE
                               IF  WRK-CLM       >   ZERO
      *                        前の病名の直後に編集
                                   COMPUTE WRK-STCLM =   WRK-CLM   +
                                                         1
                                   MOVE    "，"  TO  WRK-BYOMEI2-NAME
                                                       (WRK-STCLM:)
                                   COMPUTE WRK-CLM   =   WRK-CLM   +
                                                         2
                               END-IF
                           END-IF
                   END-EVALUATE
               ELSE
      *            主病名フラグ・診療開始日・転帰区分 が異なる場合
                   IF      WRK-BYO-OLD        =   LOW-VALUE
                       CONTINUE
                   ELSE
                       IF  WRK-LINEBYO       <  WRK-BYOMEI-LINE
                           IF  WRK-BYOMEI1-NAME  NOT =   SPACE
                               PERFORM 3221-BYOMEI1-OUT-SEC
                           END-IF
                       ELSE
                           IF  WRK-BYOMEI2   NOT =   SPACE
                               MOVE    1             TO  FLG-TENKI
                               PERFORM 3222-BYOMEI2-OUT-SEC
                               MOVE    ZERO          TO  FLG-TENKI 
                           END-IF
                       END-IF
                   END-IF    
               END-IF
           ELSE
                IF  WRK-LINEBYO       <   WRK-BYOMEI-LINE
                    IF  WRK-BYOMEI1-NAME  NOT =   SPACE
                        PERFORM 3221-BYOMEI1-OUT-SEC
                    END-IF
                ELSE
                    IF  WRK-BYOMEI2   NOT =   SPACE
                        MOVE    1             TO  FLG-TENKI
                        PERFORM 3222-BYOMEI2-OUT-SEC
                        MOVE    ZERO          TO  FLG-TENKI
                    END-IF
                END-IF
           END-IF
      *
      *    主病名との区切り線編集処理     
           PERFORM 3211-SYUBYOFLG-HENSYU-SEC
      *
      *    対象病名を編集
           COMPUTE     WRK-STCLM         =   WRK-CLM   +   1
      *    単病名文字数を計算
           COMPUTE WRK-MOJISU          =   RECE631-BYOMEIMOJI   *   2
           MOVE    RECE631-BYOMEI      TO  WRK-BYOMEI
      *
      *
           EVALUATE    TRUE
      *        傷病名欄に編集
               WHEN    WRK-LINEBYO     <   WRK-BYOMEI-LINE
                   MOVE    WRK-BYOMEI      TO  WRK-BYOMEI1-NAME
                                                          (WRK-STCLM:)
                   IF      WRK-MOJISU       >   WRK-BYOMEI1-MAX
                       MOVE    RECE631-SRYYMD  TO  WRK-BO-SRYYMD
                       MOVE    RECE631-TENKIKBN
                                               TO  WRK-BO-TENKIKBN
                       MOVE    RECE631-TENKIYMD
                                               TO  WRK-BO-TENKIYMD
                       PERFORM 3221-BYOMEI1-OUT-SEC
                       IF      WRK-LINEBYO     <   WRK-BYOMEI-LINE 
                           MOVE    WRK-BYOMEI(49:) TO  WRK-BYOMEI1-NAME
                                                          (WRK-STCLM:)
                           MOVE    1               TO  WRK-CONTINUE
                       ELSE
                           MOVE    WRK-BYOMEI(49:) TO  WRK-BYOMEI2-NAME
                                                          (WRK-STCLM:)
                           MOVE    1               TO  WRK-CONTINUE    
                       END-IF                                   
                   END-IF    
      *        適用欄に編集
               WHEN    WRK-LINEBYO     >=  WRK-BYOMEI-LINE
                   MOVE    WRK-BYOMEI      TO  WRK-BYOMEI2-NAME
                                                          (WRK-STCLM:)
                   IF      WRK-MOJISU       >   WRK-BYOMEI2-MAX 
                       MOVE    RECE631-SRYYMD  TO  WRK-BO-SRYYMD
                       MOVE    RECE631-TENKIKBN
                                               TO  WRK-BO-TENKIKBN
                       MOVE    RECE631-TENKIYMD
                                               TO  WRK-BO-TENKIYMD
                       PERFORM  3222-BYOMEI2-OUT-SEC
                       MOVE    1               TO  WRK-CONTINUE
                       MOVE    WRK-BYOMEI(45:) TO  WRK-BYOMEI2-NAME
                                                          (WRK-STCLM:)
                   END-IF                                       
           END-EVALUATE
      *
           COMPUTE     WRK-CLM           =   WRK-MOJISU
                                         +   WRK-CLM
      *     
           MOVE    RECE631-SYUBYOFLG     TO  WRK-BO-SYUBYOFLG
           MOVE    RECE631-SRYYMD        TO  WRK-BO-SRYYMD
           MOVE    RECE631-TENKIKBN      TO  WRK-BO-TENKIKBN
           MOVE    RECE631-TENKIYMD      TO  WRK-BO-TENKIYMD
      *
           PERFORM 990-RECE631-NEXT-SEC
      *
           .
       3210-BYOMEI-SET-EXT.
           EXIT.
      ****************************************************************
      *      主病名と副病名の区切り線の編集
      ****************************************************************
       3211-SYUBYOFLG-HENSYU-SEC         SECTION.
      *
      *    主病名との区切り線（副傷病名があるときのみ）     
           IF      WRK-BYO-OLD        =   LOW-VALUE
               CONTINUE
           ELSE
               IF      FLG-RECE631             =   ZERO
               AND     RECE631-SYUBYOFLG   NOT =   WRK-BO-SYUBYOFLG 
               AND     WRK-BO-SYUBYOFLG        =   "1"
                   IF      WRK-LINEBYO     <   WRK-BYOMEI-LINE
                       ADD     1           TO  WRK-LINEBYO
                       MOVE    WRK-KUGIRI3 TO
                                       HC06-BYOMEI(WRK-LINEBYO)(2:52)
                   ELSE
                       IF      WRK-LINETEK >=   WRK-TEKIYOU-LINE
                           PERFORM 34120-PAGE-SEC
                       END-IF    
                       ADD     1           TO  WRK-LINETEK
                       MOVE    WRK-KUGIRI1 TO
                                           HC06-TEKIYO (WRK-LINETEK)
                   END-IF
               END-IF
           END-IF        
      *
           .
       3210-BYOMEI-SET-EXT.
           EXIT.
      ****************************************************************
      *     傷病名１出力処理
      *      WRK-CONTINUE = 1 の場合、２行編集の２行目
      ****************************************************************
       3221-BYOMEI1-OUT-SEC        SECTION.
      *
      *    傷病名欄の行カウント
           ADD     1               TO  WRK-LINEBYO
      *
           IF  WRK-CONTINUE        =   ZERO
      *        病名の項番カウント
               ADD     1                   TO  WRK-LINE
      *        項番
               INITIALIZE              ORCSKANACHKAREA
               MOVE    "2"             TO  KANACHK-SYORI 
               MOVE    "("             TO  KANACHK-MAE-INPUT (1:1)
               MOVE    WRK-LINE (2:1)  TO  KANACHK-MAE-INPUT (2:1)
               MOVE    ")"             TO  KANACHK-MAE-INPUT (3:1)
               CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
               IF      KANACHK-RC      =   ZERO
                   MOVE    KANACHK-OUT-INPUT(1:KANACHK-MAX)
                                           TO  WRK-BYOMEI1-NO 
               END-IF    
      *        診療開始日
               MOVE    WRK-BYOMEI1-NO      TO  HC06-SRYYMD
                                                    (WRK-LINEBYO)
               MOVE    WRK-BO-SRYYMD       TO  WRK-SYMD
               PERFORM 31012-SEIWA-HEN-SEC
               MOVE    LNK-DAY2-EDTYMD3 (5:)
                                           TO  HC06-SRYYMD
                                                    (WRK-LINEBYO)(7:)
      *        転帰
               MOVE    WRK-BYOMEI1-NO    TO  HC06-TENKI(WRK-LINEBYO)
               EVALUATE    WRK-BO-TENKIKBN
               WHEN    "1"
                   MOVE    "治ゆ"    TO  HC06-TENKI(WRK-LINEBYO)(7:)
               WHEN    "2"
                   MOVE    "死亡"    TO  HC06-TENKI(WRK-LINEBYO)(7:)
               WHEN    "3"
                   MOVE    "中止"    TO  HC06-TENKI(WRK-LINEBYO)(7:)
               WHEN    OTHER
                   MOVE    SPACE     TO  HC06-TENKI(WRK-LINEBYO)
               END-EVALUATE
      *        転帰日
               IF      WRK-BO-TENKIYMD     =   SPACE
                   CONTINUE 
               ELSE
                   MOVE    WRK-BO-TENKIYMD TO  WRK-SYMD
                   PERFORM 31012-SEIWA-HEN-SEC
                   MOVE    LNK-DAY2-EDTYMD3 (17:)
                                           TO  HC06-TENKIYMD
                                                    (WRK-LINEBYO)
               END-IF                                     
           END-IF
      *    病名
           MOVE    WRK-BYOMEI1     TO  HC06-BYOMEI(WRK-LINEBYO)
      *
      *    クリア
           MOVE    SPACE           TO  WRK-BYOMEI1
           MOVE    ZERO            TO  WRK-CLM
           MOVE    ZERO            TO  WRK-CONTINUE
      *
           .
       3221-BYOMEI1-OUT-EXT.
           EXIT.
      ****************************************************************
      *     傷病名２出力処理
      *      WRK-CONTINUE = 0 の場合、２行編集の１行目
      ****************************************************************
       3222-BYOMEI2-OUT-SEC        SECTION.
      *
      *    適用欄の行カウント
           IF      WRK-LINETEK     >=   WRK-TEKIYOU-LINE
               PERFORM 34120-PAGE-SEC
           END-IF    
           ADD     1               TO  WRK-LINETEK
      
      *
           IF  WRK-CONTINUE        =   ZERO
      *        病名の項番カウント
               ADD     1                   TO  WRK-LINE
      *        項番
               INITIALIZE              ORCSKANACHKAREA
               MOVE    "2"             TO  KANACHK-SYORI 
               IF  WRK-LINE            <   10
                   MOVE    "("             TO  KANACHK-MAE-INPUT (1:1)
                   MOVE    WRK-LINE (2:1)  TO  KANACHK-MAE-INPUT (2:1)
                   MOVE    ")"             TO  KANACHK-MAE-INPUT (3:1)
               ELSE    
                   MOVE    "("             TO  KANACHK-MAE-INPUT (1:1)
                   MOVE    WRK-LINE (1:2)  TO  KANACHK-MAE-INPUT (2:2)
                   MOVE    ")"             TO  KANACHK-MAE-INPUT (4:1)
               END-IF
               CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
               IF      KANACHK-RC      =   ZERO
                   MOVE    KANACHK-OUT-INPUT(1:KANACHK-MAX)
                                           TO  WRK-BYOMEI2-NO 
               END-IF    
           END-IF    
      *
      *    診療開始日・転帰を印字するスペースが有る場合
           IF      SYS-2005-TENKIHENKBN    =   ZERO
               IF  WRK-BYOMEI2-ELSE    =   SPACE
      *            診療年月日・転帰　編集処理
                   PERFORM 32221-SRYYMD-TENKI-HEN-SEC
                   MOVE    ZERO            TO  FLG-TENKI
               END-IF
           ELSE
               IF  WRK-BYOMEI2R-ELSE   =   SPACE
      *            診療年月日・転帰　編集処理
                   PERFORM 32221-SRYYMD-TENKI-HEN-SEC
                   MOVE    ZERO            TO  FLG-TENKI
               END-IF
           END-IF    
      *
           INSPECT WRK-BYOMEI2
                           REPLACING    ALL   "  "   BY   "　"
           IF      CNT-PAGE        =   1
               MOVE    WRK-BYOMEI2 TO  HC06-TEKIYO  (WRK-LINETEK)
           ELSE    
               MOVE    WRK-BYOMEI2 TO  HC061-TEKIYO (WRK-LINETEK)
           END-IF    
      *
      *    最後の病名に印字するスペースがなかったとき 
           IF       FLG-TENKI              =   1     
      *        診療年月日・転帰　編集処理
               MOVE    SPACE           TO  WRK-BYOMEI2
               PERFORM 32221-SRYYMD-TENKI-HEN-SEC
      *        適用欄の行カウント
               IF      WRK-LINETEK     >=   WRK-TEKIYOU-LINE
                   PERFORM 34120-PAGE-SEC
               END-IF    
               ADD     1               TO  WRK-LINETEK
               INSPECT WRK-BYOMEI2
                               REPLACING    ALL   "  "   BY   "　"
               IF      CNT-PAGE        =   1
                   MOVE    WRK-BYOMEI2 TO  HC06-TEKIYO  (WRK-LINETEK)
               ELSE    
                   MOVE    WRK-BYOMEI2 TO  HC061-TEKIYO (WRK-LINETEK)
               END-IF    
           END-IF
      *
      *
      *    クリア
           MOVE    SPACE           TO  WRK-BYOMEI2
           MOVE    ZERO            TO  WRK-CLM
           MOVE    ZERO            TO  WRK-CONTINUE
      *
           .
       3222-BYOMEI2-OUT-EXT.
           EXIT.
      *****************************************************************
      *    診療年月日・転帰　編集処理
      *****************************************************************
       32221-SRYYMD-TENKI-HEN-SEC    SECTION.
      *
      *    転帰日を編集しないとき
           IF      SYS-2005-TENKIHENKBN    =   ZERO
      *        診療開始日
               MOVE    WRK-BO-SRYYMD       TO  WRK-SYMD
               PERFORM 31012-SEIWA-HEN-SEC
               MOVE    LNK-DAY2-EDTYMD3 (5:)
                                           TO  WRK-BYOMEI2-YMD
      *        転帰
               EVALUATE    WRK-BO-TENKIKBN
               WHEN    "1"
                   MOVE    "治ゆ"          TO  WRK-BYOMEI2-TENKI
               WHEN    "2"
                   MOVE    "死亡"          TO  WRK-BYOMEI2-TENKI
               WHEN    "3"
                   MOVE    "中止"          TO  WRK-BYOMEI2-TENKI
               WHEN    OTHER
                   MOVE    SPACE           TO  WRK-BYOMEI2-TENKI
               END-EVALUATE
           ELSE
      *        診療開始日
               MOVE    WRK-BO-SRYYMD       TO  WRK-SYMD
               PERFORM 31012-SEIWA-HEN-SEC
               MOVE    LNK-DAY2-EDTYMD3 (5:)
                                           TO  WRK-BYOMEI2R-YMD
      *        転帰
               EVALUATE    WRK-BO-TENKIKBN
               WHEN    "1"
                   MOVE    "治ゆ"          TO  WRK-BYOMEI2R-TENKI
               WHEN    "2"
                   MOVE    "死亡"          TO  WRK-BYOMEI2R-TENKI
               WHEN    "3"
                   MOVE    "中止"          TO  WRK-BYOMEI2R-TENKI
               WHEN    OTHER
                   MOVE    SPACE           TO  WRK-BYOMEI2R-TENKI
               END-EVALUATE
      *        転帰日
               IF      WRK-BO-TENKIYMD     =   SPACE
                   CONTINUE 
               ELSE
                   MOVE    WRK-BO-TENKIYMD     TO  WRK-SYMD
                   PERFORM 31012-SEIWA-HEN-SEC
                   MOVE    LNK-DAY2-EDTYMD3 (17:)
                                               TO  WRK-BYOMEI2R-TENKIYMD
               END-IF                                
           END-IF                                     
      *
           .
       32221-SRYYMD-TENKI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    帳票編集<点数>処理
      *****************************************************************
       330-HC101-TENSU-HEN-SEC      SECTION.
      *
           EVALUATE  RECE62-SHOSHINTIME
               WHEN  "1"
                     MOVE  "（時間外）"   TO  HC06-SHOSHINTIME
               WHEN  "2"
                     MOVE  "（深夜）"     TO  HC06-SHOSHINTIME
               WHEN  "3"
                     MOVE  "（休日）"     TO  HC06-SHOSHINTIME
           END-EVALUATE
      *     
           IF      RECE62-HKNNUM      =   SPACE
               IF      SEIHIDX            >   ZERO 
                   COMPUTE IDX1    =   SEIHIDX   +   1
                   MOVE    2                  TO  IDX2
                   IF      IDX1               =   IDX2
                       MOVE    ZERO               TO  IDX2
                   END-IF
               ELSE
                   MOVE    2                  TO  IDX1
                   MOVE    3                  TO  IDX2
               END-IF 
           ELSE 
               MOVE    1                  TO  IDX1
               MOVE    2                  TO  IDX2
           END-IF      
      *
      *    １１初診〜８０他         
           PERFORM   VARYING   IDX   FROM    1   BY  1
                     UNTIL     IDX       >   22
      *        <回数>
               MOVE    RECE62-KAISU(IDX)         TO  WRK-KAISUZ
               MOVE    WRK-KAISU                 TO  HC06-KAISU   (IDX)
      *        <点数・公費点数>
               MOVE    RECE62-TENSU(IDX IDX1)    TO  WRK-TENSUZ
               MOVE    WRK-TENSU                 TO  HC06-TENSU   (IDX)
               IF      IDX2                      >   ZERO
                   MOVE    RECE62-TENSU(IDX IDX2)
                                                 TO  WRK-KOUTENZ
                   MOVE    WRK-KOUTEN            TO  HC06-KOUTEN  (IDX)
               END-IF
           END-PERFORM
      *
      *    ９０入院            
      **     PERFORM   VARYING   IDX   FROM    23   BY  1
      **               UNTIL     IDX       >   32
      *        <単価>
      **         MOVE    RECE62-KHNTEN (IDX)   TO  WRK-KHNTENZ
      **         MOVE    WRK-KHNTEN            TO  HC06-KHNTEN  (IDX)
      *        <回数>
      *         MOVE    RECE62-KAISU(IDX)     TO  WRK-KAISUZ
      **         MOVE    WRK-KAISU             TO  HC06-KAISU   (IDX)
      *        <点数・公費点数>
      **         MOVE    RECE62-TENSU(IDX IDX1)
      **                                       TO  WRK-TENSUZ
      **         MOVE    WRK-TENSU             TO  HC06-TENSU   (IDX)
      **         IF      IDX2                  >   ZERO
      **             MOVE    RECE62-TENSU(IDX IDX2)
      **                                       TO  WRK-KOUTENZ
      **             MOVE    WRK-KOUTEN        TO  HC06-KOUTEN  (IDX)
      **         END-IF
      **     END-PERFORM
      *
      *        <入院年月日>
           MOVE    RECE62-NYUINYMD     TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    LNK-DAY2-EDTYMD1-Y  TO  HC06-NYUINYY
           MOVE    LNK-DAY2-EDTYMD1-M  TO  HC06-NYUINMM
           MOVE    LNK-DAY2-EDTYMD1-D  TO  HC06-NYUINDD
      *
      *        <医療機関種別>
           EVALUATE    RECE62-HOSPSBT
               WHEN    "1"
                   MOVE    "病"        TO  HC06-NYUINHOSPKBN
               WHEN    "2"
                   MOVE    "診"        TO  HC06-NYUINHOSPKBN
           END-EVALUATE        
      *
      *       <入院基本料種別>
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       11
                   OR      RECE62-NYUSYUBETU (IDX) =   SPACE
               MOVE    RECE62-NYUSYUBETU (IDX)
                                     TO  HC06-NYUINNAIYO (IDX)
           END-PERFORM
      *
      *    ９７食事            
           PERFORM   VARYING   IDX   FROM    1   BY  1
                     UNTIL     IDX       >   3
               MOVE    RECE62-SHOKUJISYUBETU (IDX)
                                             TO  HC06-SYOKJN  (IDX)          
           END-PERFORM          
           PERFORM   VARYING   IDX   FROM    1   BY  1
                     UNTIL     IDX       >   4
               IF      RECE62-SHOKUJIKHNRYO (IDX)    >   ZERO      
                   MOVE    RECE62-SHOKUJIKHNRYO (IDX)
                                             TO  WRK-KGK4
                   MOVE    WRK-KGK4          TO  HC06-SYOGAK (IDX)          
                   MOVE    RECE62-SHOKUJIKHNNISSU (IDX)
                                             TO  WRK-KGK2
                   MOVE    WRK-KGK2          TO  HC06-SYOKAISU (IDX)
               END-IF                                        
           END-PERFORM          
      *
      *        <請求点・一部負担金・食事日数・請求額・標準負担額>
      *
           IF  WRK-3SYU-KBN           =   ALL "1" AND 
               RECE62-HKNNUM          =   SPACE            
               IF  KAKKIDX         >   SESNIDX
                   MOVE    SESNIDX     TO  IDA
                   MOVE    KAKKIDX     TO  IDB
               ELSE
                   MOVE    KAKKIDX     TO  IDA
                   MOVE    SESNIDX     TO  IDB
               END-IF
               COMPUTE IDX1     =   SEIHIDX    +   1
               COMPUTE IDX2     =   IDA        +   1
               COMPUTE IDX3     =   IDB        +   1
           ELSE
               MOVE    1               TO  IDX1
               MOVE    2               TO  IDX2
               MOVE    3               TO  IDX3
           END-IF    
      *    保険
           IF      RECE62-TOTALTEN (IDX1)     >   ZERO
               MOVE    RECE62-TOTALTEN (IDX1) TO  WRK-KGK6
               MOVE    WRK-KGK6               TO  HC06-TOTALTEN(1)
               IF      RECE62-FTNMONEY (IDX1) >   ZERO
                   MOVE    RECE62-FTNMONEY (IDX1) TO  WRK-KGK7
                   MOVE    WRK-KGK7               TO  HC06-FTNMONEY(1)
               END-IF
           END-IF
           IF      RECE62-KOUREI-SAIKEI  >   ZERO
               MOVE    "("                    TO  HC06-FTNMONEYSAI(1:1)
               MOVE   RECE62-KOUREI-SAIKEI   TO  WRK-KGK7
               MOVE   WRK-KGK7                TO  HC06-FTNMONEYSAI(3:8)
               MOVE    ")"                    TO
                                              HC06-FTNMONEYSAI(11:1)
           END-IF    
           IF      RECE62-SHOKUJINISSU (IDX1)   >   ZERO
               MOVE    RECE62-SHOKUJINISSU (IDX1)
                                               TO  WRK-KGK2
               MOVE    WRK-KGK2                TO  HC06-SYONISSU(1)
               IF      RECE62-SHOKUJIRYOYOHI (IDX1)
                                               >   ZERO
                   MOVE    RECE62-SHOKUJIRYOYOHI (IDX1) TO  WRK-KGK6
                   MOVE    WRK-KGK6            TO  HC06-SYOTOTALTEN(1)
               END-IF
               IF      RECE62-SHOKUJIFTN (IDX1) >   ZERO
                   MOVE    RECE62-SHOKUJIFTN (IDX1)
                                               TO  WRK-KGK7
                   MOVE    WRK-KGK7            TO  HC06-SYOFTNMONEY(1)
               END-IF
           END-IF
      *    公費１
           IF    ( RECE62-TOTALTEN (IDX2) >   ZERO                     )
           AND   ((RECE62-TOTALTEN (IDX2)
                                      NOT =   RECE62-TOTALTEN (IDX1)) OR
                  (RECE62-FTNMONEY (IDX2)
                                      NOT =   RECE62-FTNMONEY (IDX1))  )
               IF    RECE62-FTNMONEY (IDX2)   >   ZERO
                   MOVE    RECE62-FTNMONEY (IDX2) TO  WRK-KGK7
                   MOVE    WRK-KGK7               TO  HC06-FTNMONEY(2)
               END-IF
      *         
              IF      RECE62-SHOKUJINISSU (IDX2)     >   ZERO
                   MOVE    RECE62-SHOKUJINISSU (IDX2) TO  WRK-KGK2
                   MOVE    WRK-KGK2            TO  HC06-SYONISSU(2)
                   IF      RECE62-SHOKUJIRYOYOHI (IDX2) >   ZERO
                       MOVE    RECE62-SHOKUJIRYOYOHI (IDX2)
                                               TO  WRK-KGK6
                       MOVE    WRK-KGK6        TO  HC06-SYOTOTALTEN(2)
                   END-IF
                   IF      RECE62-SHOKUJIFTN (IDX2) >   ZERO
                       MOVE    RECE62-SHOKUJIFTN (IDX2)
                                               TO  WRK-KGK7
                       MOVE    WRK-KGK7        TO  HC06-SYOFTNMONEY(2)
                   END-IF
               END-IF
           END-IF
      *     
           IF      RECE62-TOTALTEN (IDX2) >   ZERO                     
           AND     RECE62-TOTALTEN (IDX2)
                                      NOT =   RECE62-TOTALTEN (IDX1)   
               MOVE    RECE62-TOTALTEN (IDX2) TO  WRK-KGK6
               MOVE    WRK-KGK6               TO  HC06-TOTALTEN(2)
           END-IF
      *    公費２
           IF    (RECE62-TOTALTEN (IDX3) >   ZERO                      )
           AND   ((RECE62-TOTALTEN (IDX3)
                                      NOT =   RECE62-TOTALTEN (IDX1)) OR
                  (RECE62-FTNMONEY (IDX3)
                                      NOT =   RECE62-FTNMONEY (IDX1))  )
      *
             IF    RECE62-FTNMONEY (IDX3)
                                      NOT =   RECE62-FTNMONEY (IDX2)
      *
               IF    RECE62-FTNMONEY (IDX3)   >   ZERO
                   MOVE    RECE62-FTNMONEY (IDX3) TO  WRK-KGK7
                   MOVE    WRK-KGK7               TO  HC06-FTNMONEY(3)
               END-IF
      *         
               IF      RECE62-SHOKUJINISSU (IDX3)  >   ZERO
                   MOVE    RECE62-SHOKUJINISSU (IDX3)
                                               TO  WRK-KGK2
                   MOVE    WRK-KGK2            TO  HC06-SYONISSU(3)
                   IF      RECE62-SHOKUJIRYOYOHI (IDX3)
                                               >   ZERO
                       MOVE    RECE62-SHOKUJIRYOYOHI (IDX3)
                                               TO  WRK-KGK6
                       MOVE    WRK-KGK6        TO  HC06-SYOTOTALTEN(3)
                   END-IF
                   IF      RECE62-SHOKUJIFTN (IDX3) >   ZERO
                       MOVE    RECE62-SHOKUJIFTN (IDX3)
                                               TO  WRK-KGK7
                       MOVE    WRK-KGK7        TO  HC06-SYOFTNMONEY(3)
                   END-IF
               END-IF
      *
             END-IF
      * 
           END-IF
           IF      RECE62-TOTALTEN (IDX3) >   ZERO                      
           AND     RECE62-TOTALTEN (IDX3)
                                      NOT =   RECE62-TOTALTEN (IDX1)
               MOVE    RECE62-TOTALTEN (IDX3) TO  WRK-KGK6
               MOVE    WRK-KGK6               TO  HC06-TOTALTEN(3)
           END-IF
      *
           .
       330-HC101-TENSU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<剤>処理
      *****************************************************************
       340-HC101-ZAI-HEN-SEC      SECTION.
      *
      *    摘要欄に病名が表示されている場合、１行あける
           IF  WRK-LINETEK             >   ZERO
      *
               IF  WRK-LINETEK          >=   WRK-TEKIYOU-LINE
                   PERFORM 34120-PAGE-SEC
               END-IF    
               ADD     1               TO  WRK-LINETEK
               IF      CNT-PAGE        =   1   
                   MOVE    WRK-KUGIRI1 TO  HC06-TEKIYO  (WRK-LINETEK)
               ELSE    
                   MOVE    WRK-KUGIRI1 TO  HC061-TEKIYO (WRK-LINETEK)
               END-IF    
           END-IF
      *
           IF      RECE62-TEISYOTOKU   =   SPACE
           OR      RECE62-KOUREI       =   SPACE
               CONTINUE
           ELSE
               IF  WRK-LINETEK           >   WRK-TEKIYOU-LINE
                   PERFORM 34120-PAGE-SEC
               END-IF    
               ADD     1               TO  WRK-LINETEK
               EVALUATE    RECE62-TEISYOTOKU
                   WHEN    "1"
                       IF      CNT-PAGE        =   1   
                           MOVE    "低所得１"
                                       TO  HC06-TEKIYO (WRK-LINETEK)
                       ELSE                
                           MOVE    "低所得１"
                                       TO  HC061-TEKIYO(WRK-LINETEK)
                       END-IF                
                   WHEN    "2"
                       IF      CNT-PAGE        =   1   
                           MOVE    "低所得２"
                                       TO  HC06-TEKIYO (WRK-LINETEK)
                       ELSE                
                           MOVE    "低所得２"
                                       TO  HC061-TEKIYO(WRK-LINETEK)
                       END-IF                
               END-EVALUATE        
           END-IF
      *         
           MOVE    ZERO                TO  WRK-R061-ZAINUM-O
           MOVE    SPACE               TO  WRK-R061-SRYKBN-O
           MOVE    ZERO                TO  WRK-R061-KOHBUNRI-O
           MOVE    ZERO                TO  CNT-RECE661
      *
      *    パラメータ０６ファイルより編集
           INITIALIZE                      RECE661-REC
           MOVE    RECE62-HOSPID       TO  RECE661-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE661-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE661-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE661-PTID
           MOVE    RECE62-RECEKA       TO  RECE661-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE661-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE661-RECESYUBETU
           MOVE    RECE62-HKNJANUM-KEY TO  RECE661-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE661-HOJOKBN
           MOVE    RECE62-TEKSTYMD     TO  RECE661-TEKSTYMD
      *
           START   RECE661-FILE
               KEY IS    >=   RECE661-KEY
               INVALID
                   MOVE    1            TO  FLG-RECE661
               NOT INVALID
                   PERFORM 990-RECE661-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( FLG-RECE661           =   1 )
               OR     ( RECE62-HOSPID    NOT =   RECE661-HOSPID      )
               OR     ( RECE62-SRYYM     NOT =   RECE661-SRYYM       )
               OR     ( RECE62-NYUGAIKBN NOT =   RECE661-NYUGAIKBN   )
               OR     ( RECE62-PTID      NOT =   RECE661-PTID        )
               OR     ( RECE62-RECEKA    NOT =   RECE661-RECEKA      )
               OR     ( RECE62-TEISYUTUSAKI
                                         NOT =   RECE661-TEISYUTUSAKI)
               OR     ( RECE62-RECESYUBETU
                                         NOT =   RECE661-RECESYUBETU )
               OR     ( RECE62-HKNJANUM-KEY
                                         NOT =   RECE661-HKNJANUM    )
               OR     ( RECE62-HOJOKBN-KEY
                                         NOT =   RECE661-HOJOKBN     )
               OR     ( RECE62-TEKSTYMD  NOT =   RECE661-TEKSTYMD    )
      *
               MOVE    ZERO                  TO  FLG-KUGIRI
               IF  RECE661-ZAINUM        NOT =   WRK-R061-ZAINUM-O
                   MOVE    ZERO              TO  CNT-ZAIMEISAISU
               END-IF
               ADD     1                     TO  CNT-ZAIMEISAISU
      *
      *        レセプト０６ファイル編集処理
               PERFORM 3410-RECE661-HENSYU-SEC
      *
               MOVE    RECE661-ZAINUM        TO  WRK-R061-ZAINUM-O
               MOVE    RECE661-SRYKBN        TO  WRK-R061-SRYKBN-O
               MOVE    RECE661-KOHBUNRI      TO  WRK-R061-KOHBUNRI-O
      *
               PERFORM 990-RECE661-NEXT-SEC
           END-PERFORM
      *
           .
       340-HC101-ZAI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    レセプト０６ファイル編集処理
      *****************************************************************
       3410-RECE661-HENSYU-SEC           SECTION.
      *
           IF  CNT-ZAIMEISAISU           =   1
      *        次の行為明細数を追加すると何行になるか
               COMPUTE   WRK-WLINETEK    =   WRK-LINETEK
                                         +   RECE661-ZAIMEISAISU
               IF  CNT-RECE661           >   1
      *            公費分離区分が変更している場合、公費区切り線分を追加
                   IF  RECE661-KOHBUNRI  NOT =   WRK-R061-KOHBUNRI-O
                       ADD     1             TO  WRK-WLINETEK
                       MOVE    2             TO  FLG-KUGIRI
                   ELSE
      *                診療区分が変更している場合、診療区切り線分を追加
                       IF  RECE661-SRYKBN    NOT =   WRK-R061-SRYKBN-O
                           ADD     1             TO  WRK-WLINETEK
                           MOVE    1             TO  FLG-KUGIRI
                       END-IF
                   END-IF
               END-IF
      *
               IF  WRK-WLINETEK          >   WRK-TEKIYOU-LINE
                   PERFORM 34120-PAGE-SEC
      *
      *            区切り線
                   IF  FLG-KUGIRI        =   2
                       PERFORM 34110-KUGIRI-LINE-SEC
                   END-IF
      *            診療区分
                   ADD     1               TO  WRK-LINETEK
                   IF      CNT-PAGE        =   1   
                       MOVE    RECE661-SRYKBN  TO  HC06-SRYKBN
                                                       (WRK-LINETEK)
                   ELSE                                    
                       MOVE    RECE661-SRYKBN  TO  HC061-SRYKBN
                                                       (WRK-LINETEK)
                   END-IF                                    
               ELSE
      *            区切り線
                   IF  FLG-KUGIRI    NOT =   ZERO
                       PERFORM 34110-KUGIRI-LINE-SEC
                   END-IF
      *            診療区分
                   ADD     1             TO  WRK-LINETEK
                   IF  RECE661-SRYKBN    NOT =   WRK-R061-SRYKBN-O
                       IF      CNT-PAGE        =   1   
                           MOVE    RECE661-SRYKBN  TO  HC06-SRYKBN
                                                       (WRK-LINETEK)
                       ELSE                                    
                           MOVE    RECE661-SRYKBN  TO  HC061-SRYKBN
                                                       (WRK-LINETEK)
                       END-IF                                    
                   END-IF
               END-IF
           ELSE
               ADD     1                 TO  WRK-LINETEK
           END-IF
      *
      *    明細
           INSPECT RECE661-TEKIYO-INF
                           REPLACING    ALL   "  "   BY   "　"
           IF      CNT-PAGE        =   1   
               MOVE    RECE661-TEKIYO-INF  TO  HC06-TEKIYO (WRK-LINETEK)
           ELSE    
               MOVE    RECE661-TEKIYO-INF  TO  HC061-TEKIYO(WRK-LINETEK)
           END-IF  
      *
           .
       3410-RECE661-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    区切り線　編集処理
      *****************************************************************
       34110-KUGIRI-LINE-SEC       SECTION.
      *
           ADD     1               TO  WRK-LINETEK
      *
           EVALUATE    FLG-KUGIRI
           WHEN    2
               PERFORM 34110-KOHNAME-SET-SEC
               IF      CNT-PAGE        =   1   
                   MOVE    WRK-KUGIRI2 TO  HC06-TEKIYO  (WRK-LINETEK)
               ELSE    
                   MOVE    WRK-KUGIRI2 TO  HC061-TEKIYO (WRK-LINETEK)
               END-IF    
           WHEN    1
               IF      CNT-PAGE        =   1   
                   MOVE    WRK-KUGIRI1 TO  HC06-TEKIYO  (WRK-LINETEK)
               ELSE    
                   MOVE    WRK-KUGIRI1 TO  HC061-TEKIYO (WRK-LINETEK)
               END-IF    
           END-EVALUATE
      *
           .
       34110-KUGIRI-LINE-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    改ページ処理
      *****************************************************************
       34120-PAGE-SEC       SECTION.
      *
      *    帳票印刷処理
           PERFORM 390-PRINT-OUT-SEC
      *     
      *    帳票編集<ヘッダー部>処理
           ADD     1             TO  CNT-PAGE
           PERFORM 310-HC102-HEAD-HEN-SEC
           MOVE    ZERO          TO  WRK-LINETEK
      *
           .
       34120-PAGE-EXT.
           EXIT.
      *
      *****************************************************************
      *    区切り線　公費名セット処理
      *****************************************************************
       34110-KOHNAME-SET-SEC          SECTION.
      *
           MOVE    SPACE              TO  WRK-KUGIRI2-KOHNAME
      *
           MOVE    SPACE              TO  HKNNUM-REC
           MOVE    SYS-1001-HOSPID    TO  HKN-HOSPID
           MOVE    RECE62-KOHNUM (RECE661-KOHBUNRI)
                                      TO  HKN-HKNNUM
           MOVE    WRK-SRYYMD         TO  HKN-TEKSTYMD
                                          HKN-TEKEDYMD
      *
           MOVE    HKNNUM-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"         TO  MCP-FUNC
           MOVE    "HKNNUM-KEY5"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF      MCP-RC             =   ZERO
               MOVE    "HKNNUM-KEY5"  TO  ORC-DBPATH
               PERFORM 910-HKNMST-NEXT-SEC
           ELSE
               MOVE    1              TO  FLG-HKNNUM
           END-IF
           MOVE    "DBCLOSE"          TO  MCP-FUNC
           MOVE    "HKNNUM-KEY5"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           IF      FLG-HKNNUM         =   ZERO   
               MOVE    HKN-TANSEIDONAME  TO  WRK-KUGIRI2-KOHNAME
               INSPECT WRK-KUGIRI2-KOHNAME
                       REPLACING    ALL   "  "   BY   "　"
           END-IF
      *
           .
       34110-KOHNAME-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<補足>処理
      *****************************************************************
       350-HC101-HOSOKU-HEN-SEC      SECTION.
      *
      *    県単用項目
           IF      FLG-RECE67           =   ZERO
               INSPECT RECE67-HC06-BODY     REPLACING   ALL "  "
                                                        BY  "　" 
               MOVE    RECE67-HC06-BODY     TO  HC06-BODY
           END-IF
      *
           .
       350-HC101-HOSOKU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<コメント>処理
      *****************************************************************
       360-HC101-COMMENT-HEN-SEC      SECTION.
      *
           MOVE    ZERO                TO  WRK-RECECOM
      *     
           INITIALIZE                      RECECOM-REC
           MOVE    RECE62-HOSPID       TO  RECECOM-HOSPID
           MOVE    RECE62-SRYYM        TO  RECECOM-SRYYM
           MOVE    RECE62-PTID         TO  RECECOM-PTID
      * 
           MOVE    RECECOM-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "RECECOM-KEY1"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "RECECOM-KEY1"      TO  ORC-DBPATH
               PERFORM 900-RECECOM-READ-SEC
           ELSE
               INITIALIZE                  RECECOM-REC
               MOVE    1               TO  FLG-RECECOM
           END-IF
      *
           PERFORM             UNTIL   FLG-RECECOM   =   1
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       10
                       OR      RECE62-HKNCOMBI (IDY) =   ZERO
                   IF      RECECOM-HKNCOMBI    =   RECE62-HKNCOMBI(IDY)
                       PERFORM 3601-COMMENT-HENSYU-SEC                 
                       MOVE    10                  TO  IDY
                   END-IF
               END-PERFORM
      *                 
               PERFORM 900-RECECOM-READ-SEC
           END-PERFORM
      *
           .
       360-HC101-COMMENT-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメントの改行コード削除処理
      *****************************************************************
       3601-COMMENT-HENSYU-SEC    SECTION.
      *                                          
           MOVE    RECECOM-COMMENT TO  WRK-COMM
           MOVE    ZERO            TO  WRK-RECEHEN                      
      *
           PERFORM     UNTIL       WRK-RECEHEN  =   1      
      *
               MOVE    SPACE           TO  WRK-COMMENT-G
                                           WRK-COMM1
               MOVE    ZERO            TO  WRK-COL
      *
               IF      WRK-COMM (1:1)  =   WRK-CONS-RETURN
                   MOVE    WRK-COMM (2:)   TO  WRK-COMM1
               ELSE             
                   INSPECT WRK-COMM    TALLYING    WRK-COL
                                               FOR ALL WRK-CONS-RETURN
                   IF      WRK-COL         >   ZERO
                       PERFORM VARYING IDX FROM    1   BY  1
                               UNTIL   IDX >       400
                           IF      WRK-COMM(IDX:1) =   WRK-CONS-RETURN
                               COMPUTE IDY1     =   IDX     -   1
                               COMPUTE IDY2     =   IDX     +   1   
                               MOVE    WRK-COMM (1:IDY1)
                                                TO  WRK-COMMENT-G
                               MOVE    WRK-COMM (IDY2:)
                                                TO  WRK-COMM1
                               MOVE    400      TO  IDX
                           END-IF
                       END-PERFORM                                                                                  
                   ELSE
                       MOVE    WRK-COMM        TO  WRK-COMMENT-G
                       MOVE    1               TO  WRK-RECEHEN
                   END-IF
      *                                       
                   IF      WRK-COMMENT-G   >   SPACE
      *                摘要欄に１行あける
                     IF      WRK-RECECOM         =   ZERO
                       MOVE    1               TO  WRK-RECECOM
                       IF  WRK-LINETEK         >   ZERO
                           IF      WRK-LINETEK >=  WRK-TEKIYOU-LINE
                               PERFORM 34120-PAGE-SEC
                           ELSE
                               ADD     1           TO  WRK-LINETEK
                               IF      CNT-PAGE        =   1   
                                   MOVE    WRK-KUGIRI1     TO 
                                               HC06-TEKIYO (WRK-LINETEK)
                               ELSE                 
                                   MOVE    WRK-KUGIRI1     TO 
                                               HC061-TEKIYO(WRK-LINETEK)
                               END-IF                
                           END-IF
                       END-IF
                     END-IF
      *                 
                     PERFORM VARYING IDX FROM    1   BY  1
                             UNTIL   IDX >       8
                           OR      WRK-COMMENT (IDX)   =   SPACE
                       IF      WRK-LINETEK      >=
                                                WRK-TEKIYOU-LINE
                           PERFORM 34120-PAGE-SEC
                       END-IF
                       ADD     1               TO  WRK-LINETEK
                       IF      CNT-PAGE        =   1   
                           MOVE    WRK-COMMENT (IDX)
                                       TO  HC06-TEKIYO (WRK-LINETEK)
                       ELSE                
                           MOVE    WRK-COMMENT (IDX)
                                       TO  HC061-TEKIYO(WRK-LINETEK)
                       END-IF                
                     END-PERFORM
                 END-IF
               END-IF  
               MOVE    WRK-COMM1       TO  WRK-COMM
           END-PERFORM   
      *
           .
       3601-COMMENT-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<保険履歴情報>処理
      *****************************************************************
       370-HC101-HKN-RIREKI-HEN-SEC      SECTION.
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       WRK-RIREKI-MAX  
      *        摘要欄に１行あける
               IF      IDX                 =   1
                   IF  WRK-LINETEK             >   ZERO
                       IF      WRK-LINETEK         >=  WRK-TEKIYOU-LINE
                           PERFORM 34120-PAGE-SEC
                       ELSE
                           ADD     1               TO  WRK-LINETEK
                           IF      CNT-PAGE        =   1   
                               MOVE    WRK-KUGIRI1     TO 
                                               HC06-TEKIYO (WRK-LINETEK)
                           ELSE                    
                               MOVE    WRK-KUGIRI1     TO 
                                               HC061-TEKIYO(WRK-LINETEK)
                           END-IF                    
                       END-IF
                   END-IF
               END-IF
      *
      *
               IF      WRK-LINETEK        >=  WRK-TEKIYOU-LINE
                   PERFORM 34120-PAGE-SEC
               END-IF
               ADD     1               TO  WRK-LINETEK
               INSPECT WRK-HKN-RIREKI-TBL (IDX)    REPLACING   ALL "  "
                                                               BY  "　"  
               IF      CNT-PAGE        =   1   
                   MOVE    WRK-HKN-RIREKI-TBL (IDX)
                                       TO  HC06-TEKIYO (WRK-LINETEK)
               ELSE                        
                   MOVE    WRK-HKN-RIREKI-TBL (IDX)
                                       TO  HC061-TEKIYO(WRK-LINETEK)
               END-IF                        
           END-PERFORM
      *
           .
       370-HC101-HKN-RIREKI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       390-PRINT-OUT-SEC                SECTION.
      *
           MOVE    ZERO                 TO  FLG-ERR
      *
           ADD     1                    TO  WRK-RECENUM
      * 
      *    レセプト明細管理ＤＢ
           PERFORM 3901-RECE08-INSERT-SEC
      *
      *    レセプト帳票管理ファイル出力
           IF      FLG-ERR              =   ZERO
               PERFORM 3903-RECE07-WRITE-SEC
           END-IF
      *
      *    請求管理ＤＢ更新
           IF      FLG-ERR              =   ZERO   AND 
                   CNT-PAGE             =   1
               PERFORM 3904-RECE10-HENSYU-SEC
           END-IF
      *
           IF      FLG-ERR              =   1
               MOVE    2                    TO  SPA-STS
           END-IF
           .
       390-PRINT-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト明細ＤＢ
      *****************************************************************
       3901-RECE08-INSERT-SEC        SECTION.
      *
           INITIALIZE                  RECE08-REC
           MOVE    "HC06"              TO  RECE08-PRTID
           MOVE    WRK-PARA-SRYYM      TO  RECE08-RECEYM
           MOVE    WRK-SYSYMD          TO  RECE08-CREYMD
           MOVE    SYS-TIME (1:6)      TO  RECE08-CREHMS
           IF      RECE62-TEISYUTUSAKI =   "2"
               IF      RECE62-HKNJANUM-KEY (1:2)   =   "67"
                   MOVE    RECE62-HKNJANUM-KEY (3:2)
                                           TO  RECE08-PREFNUM
               ELSE
                   MOVE    RECE62-HKNJANUM-KEY (1:2)
                                           TO  RECE08-PREFNUM
               END-IF
               IF      RECE08-PREFNUM  =   SYS-1001-PREFNUM
                   MOVE    "1"             TO  RECE08-PREFKBN
               ELSE
                   MOVE    "2"             TO  RECE08-PREFKBN
                   MOVE    RECE62-SRYYM        TO  WRK-SYMD (1:6)
                   MOVE    "01"                TO  WRK-SYMD (7:2)
                   PERFORM VARYING IDX FROM    1   BY  1
                           UNTIL   IDX >       5
                           OR      WRK-1033-STYUKYMD (IDX) =   SPACE
                       IF      WRK-1033-STYUKYMD   (IDX) <=  WRK-SYMD
                       AND     WRK-1033-EDYUKYMD   (IDX) >=  WRK-SYMD      
                           PERFORM VARYING IDY FROM    1   BY  1
                                   UNTIL   IDY >       20
                                   OR      WRK-1033-HKNJANUM (IDX IDY)
                                                       =   SPACE     
                               IF      RECE62-HKNJANUM-KEY = 
                                       WRK-1033-HKNJANUM (IDX IDY)
                                   MOVE    "1"     TO  RECE08-PREFKBN
                                   MOVE    20      TO  IDY
                                   MOVE    5       TO  IDX
                               END-IF
                           END-PERFORM
                       END-IF            
                   END-PERFORM
               END-IF        
           ELSE
               MOVE    "0"             TO  RECE08-PREFKBN
               MOVE    "00"            TO  RECE08-PREFNUM
           END-IF
           MOVE    RECE62-HKNJANUM-KEY TO  RECE08-HKNJANUM   
           MOVE    RECE62-TEKSTYMD     TO  RECE08-TEKSTYMD
           MOVE    RECE62-TEISYUTUSAKI TO  RECE08-TEISYUTUSAKI
           IF      RECE62-PTNUM        =   SPACE
               MOVE    ZERO                TO  RECE08-RECESYUBETU
           ELSE      
               MOVE    RECE62-RECESYUBETU  TO  RECE08-RECESYUBETU
           END-IF    
           MOVE    RECE62-PTNUM        TO  RECE08-PTNUM
           PERFORM VARYING IDX FROM    20  BY  -1
                   UNTIL   IDX <       1
               IF      RECE08-PTNUM (IDX:1)    NOT =   SPACE
                   MOVE    1               TO  IDX 
               ELSE  
                   MOVE    "Z"             TO  RECE08-PTNUM (IDX:1)
               END-IF
           END-PERFORM 
           MOVE    RECE62-SRYYM        TO  RECE08-SRYYM
           MOVE    CNT-PAGE            TO  RECE08-RENNUM
           MOVE    WRK-RECENUM         TO  RECE08-RECENUM
           MOVE    RECE08-REC          TO  MCPDATA-REC
           PERFORM 900-RECE08-READ-SEC
           IF      FLG-RECE08          =   ZERO
               DISPLAY "ORCR0710 MCP-RC=" MCP-RC " " RECE08-KEY 
               STRING   "レセプト明細に更新できません　患者番号＝"
                                               DELIMITED  BY  SIZE
                        RECE62-PTNUM           DELIMITED  BY  SIZE  
                                               INTO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                  TO  FLG-ERR
           ELSE    
               IF      RECE08-TEISYUTUSAKI =   "1"
                   EVALUATE    RECE62-HKNNUM                   
                       WHEN    "001"
                           MOVE    "1"             TO  RECE08-HKNKBN
                       WHEN    "002"
                           MOVE    "2"             TO  RECE08-HKNKBN
                       WHEN    "003"
                           MOVE    "3"             TO  RECE08-HKNKBN
                       WHEN    "004"
                           MOVE    "4"             TO  RECE08-HKNKBN
                       WHEN    "031"  THRU  "034"
                           MOVE    "5"             TO  RECE08-HKNKBN
                       WHEN    "006"
                           MOVE    "6"             TO  RECE08-HKNKBN
                       WHEN    "007"               
                           MOVE    "7"             TO  RECE08-HKNKBN
                       WHEN    "063"
                       WHEN    "072"  THRU  "075"
                           MOVE    "8"             TO  RECE08-HKNKBN
                   END-EVALUATE
               END-IF                      
               MOVE    RECE62-KANANAME     TO  RECE08-KANANAME
               MOVE    "1"                 TO  RECE08-NYUGAIKBN
               MOVE    WRK-PARA-TERMID     TO  RECE08-TERMID
               MOVE    ZERO                TO  RECE08-PRTJYUN
                                               RECE08-PRTRENNUM
               IF      CNT-PAGE            =   1                                 
                   MOVE    "HCN06.red"         TO  RECE08-FORMID
                   MOVE    HC06                TO  RECE08-PRTDATA
               ELSE
                   MOVE    "HCN061.red"        TO  RECE08-FORMID
                   MOVE    HC061               TO  RECE08-PRTDATA
               END-IF        
               MOVE    "RECEPRT-KEY"       TO  ORC-DBPATH
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    RECE08-REC          TO  MCPDATA-REC
               CALL    "ORCMCPSUB"              USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
      *
               IF      MCP-RC     =   ZERO
                   ADD     1                 TO  CNT-OUT 
               ELSE 
                   DISPLAY "ORCR0710 RECE08=" MCP-RC " " RECE08-KEY 
                   STRING
                        "レセプト明細に更新できませんでした　患者番号＝"
                                               DELIMITED  BY  SIZE
                        RECE62-PTNUM           DELIMITED  BY  SIZE  
                                               INTO  WRK-RECEERR
                   PERFORM 500-ERR-HENSYU-SEC
                   MOVE    1                  TO  FLG-ERR
               END-IF
           END-IF    
           .
       3901-RECE08-INSERT-EXT.
           EXIT.
      *
      *****************************************************************
      *    出力処理
      *****************************************************************
       3903-RECE07-WRITE-SEC        SECTION.
      *
           INITIALIZE                      RECE07-REC
           MOVE    RECE08-PRTID        TO  RECE07-PRTID
           IF      WRK-PARA-SRYYM      =   ZERO
               MOVE    "2"                 TO  RECE07-SYOKBN
           ELSE
               MOVE    "1"                 TO  RECE07-SYOKBN
           END-IF         
           MOVE    WRK-PARA-RECEYM     TO  RECE07-SRYYM
           MOVE    RECE08-CREYMD       TO  RECE07-CREYMD
           MOVE    RECE08-CREHMS       TO  RECE07-CREHMS
           MOVE    RECE08-TEISYUTUSAKI TO  RECE07-TEISYUTUSAKI
           MOVE    RECE08-RECESYUBETU  TO  RECE07-RECESYUBETU
           MOVE    RECE08-NYUGAIKBN    TO  RECE07-NYUGAIKBN
           MOVE    RECE07-REC          TO  MCPDATA-REC 
           PERFORM 900-RECE07-READ-SEC
           IF      FLG-RECE07          =   1
               INITIALIZE                      RECE07-REC
               MOVE    RECE08-PRTID        TO  RECE07-PRTID
               IF      WRK-PARA-SRYYM      =   ZERO
                   MOVE    "2"                 TO  RECE07-SYOKBN
               ELSE
                   MOVE    "1"                 TO  RECE07-SYOKBN
               END-IF         
               MOVE    WRK-PARA-RECEYM     TO  RECE07-SRYYM
               MOVE    RECE08-CREYMD       TO  RECE07-CREYMD
               MOVE    RECE08-CREHMS       TO  RECE07-CREHMS
               MOVE    RECE08-TEISYUTUSAKI TO  RECE07-TEISYUTUSAKI
               MOVE    RECE08-RECESYUBETU  TO  RECE07-RECESYUBETU
               MOVE    1                   TO  RECE07-PAGE
               MOVE    1                   TO  RECE07-KENSU
               MOVE    WRK-PARA-RECEKBN    TO  RECE07-RECEKBN
               MOVE    RECE08-NYUGAIKBN    TO  RECE07-NYUGAIKBN 
               MOVE    RECE08-TERMID       TO  RECE07-TERMID
           ELSE
               ADD     1                   TO  RECE07-PAGE
               IF      CNT-KENSU           =   1
               AND     CNT-PAGE            =   1
                   ADD     1                   TO  RECE07-KENSU
               END-IF
           END-IF
      *
           MOVE    RECE07-REC          TO  MCPDATA-REC
           MOVE    "RECEKANRI-KEY"     TO  ORC-DBPATH
           IF      FLG-RECE07          =   1    
               MOVE    "DBINSERT"          TO  MCP-FUNC 
           ELSE
               MOVE    "DBUPDATE"          TO  MCP-FUNC
           END-IF 
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC      
      *
           IF      MCP-RC     =   ZERO
               CONTINUE
           ELSE
               DISPLAY "ORCR0710 RECEKANRI MCP-RC= "  MCP-RC   
               IF      FLG-SEIKYU          =   1    
               MOVE    "レセプト管理ＤＢに追加できませんでした"
                                               TO  WRK-RECEERR
               ELSE
               MOVE    "レセプト管理ＤＢに更新できませんでした"
                                               TO  WRK-RECEERR
               END-IF 
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                  TO  FLG-ERR
           END-IF
           .
       3903-RECE07-WRITE-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求管理ＤＢ更新
      *****************************************************************
       3904-RECE10-HENSYU-SEC        SECTION.
      * 
      *    テスト患者のとき更新しない
           IF      WRK-PTINF-TSTPTNUMKBN   =   "1"
               GO  TO  3904-RECE10-HENSYU-EXT
           END-IF
      * 
      *    レセプト種別不明または自費のとき更新しない
           IF      RECE62-RECESYUBETU      =   "0000"  OR  "8888"
               GO  TO  3904-RECE10-HENSYU-EXT
           END-IF
      *          
           INITIALIZE                  RECE10-REC
           MOVE    RECE62-HOSPID       TO  RECE10-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE10-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE10-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE10-PTID
           IF      RECE62-RECEKA       =   SPACE
               MOVE    ZERO            TO  RECE10-RECEKA
           ELSE
               MOVE    RECE62-RECEKA   TO  RECE10-RECEKA
           END-IF
           MOVE    RECE62-TEISYUTUSAKI TO  RECE10-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE10-RECESYUBETU
           IF      RECE62-HKNJANUM-KEY =   SPACE
               MOVE    ZERO            TO  RECE10-HKNJANUM
           ELSE
               MOVE    RECE62-HKNJANUM-KEY
                                       TO  RECE10-HKNJANUM
           END-IF
           IF      RECE62-TEKSTYMD     =   SPACE
               MOVE    ZERO            TO  RECE10-TEKSTYMD
           ELSE
               MOVE    RECE62-TEKSTYMD TO  RECE10-TEKSTYMD
           END-IF
      *
           PERFORM 900-SEIKYU-INV-SEC
           IF      FLG-SEIKYU          =   ZERO
               MOVE    MCPDATA-REC         TO  RECE10-REC
               MOVE    WRK-PARA-SYSYMD     TO  RECE10-UPDYMD
               IF      RECE10-SKYKBN       =   "2"
                   MOVE    "1"                 TO  RECE10-SKYKBN
               END-IF 
               MOVE    "2"                 TO  RECE10-TEISEIKBN
           ELSE
               MOVE    "1"                 TO  RECE10-SKYKBN
               MOVE    RECE62-PTNUM        TO  RECE10-PTNUM
               MOVE    RECE62-HKNNUM       TO  RECE10-HKNNUM
                                               RECE10-HKNNUM-S
               MOVE    RECE62-RJNHKNNUM    TO  RECE10-RJNHKNNUM
               MOVE    RECE62-HONKZKKBN    TO  RECE10-HONKZKKBN
               MOVE    RECE62-HOJOKBN      TO  RECE10-HOJOKBN
               MOVE    RECE62-CONTKBN      TO  RECE10-CONTKBN
               MOVE    RECE62-KIGO         TO  RECE10-KIGO
               MOVE    RECE62-NUM          TO  RECE10-NUM
               MOVE    ZERO                TO  RECE10-SKYYM
                                               RECE10-HENREIYM
                                               RECE10-TEISEIKBN
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       4
                   MOVE    RECE62-KOHNUM (IDX) TO
                                       RECE10-KOHNUM (IDX)
               END-PERFORM
               MOVE    RECE62-HKNNUM   TO  RECE10-HKNNUM-S
               IF      RECE62-HKNJANUM-KEY =   SPACE
                   MOVE    ZERO            TO  RECE10-HKNJANUM-S
               ELSE
                   IF      RECE62-HKNJANUM-KEY(1:2)    =   "67"
                       MOVE    RECE62-HKNJANUM-KEY(3:)
                                           TO  RECE10-HKNJANUM-S
                       MOVE    "067"       TO  RECE10-HKNNUM-S
                   ELSE
                       MOVE    RECE62-HKNJANUM-KEY
                                           TO  RECE10-HKNJANUM-S
                   END-IF
               END-IF
               MOVE    RECE08-PREFKBN      TO  RECE10-PREFKBN
               MOVE    RECE08-PREFNUM      TO  RECE10-PREFNUM
               MOVE    WRK-PARA-SYSYMD     TO  RECE10-CREYMD
               MOVE    ZERO                TO  RECE10-UPDYMD
           END-IF
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       5
               MOVE    RECE62-JNISSUINF (IDX)  TO
                                       RECE10-JNISSUINF (IDX)
               MOVE    RECE62-TOTALTENINF (IDX)    TO 
                                       RECE10-TOTALTENINF (IDX)
               MOVE    RECE62-FTNMONEYINF(IDX) TO
                                       RECE10-FTNMONEYINF (IDX)
               MOVE    RECE62-SHOKUJIINF (IDX) TO
                                       RECE10-SHOKUJIINF (IDX)
           END-PERFORM
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       30
               MOVE    RECE62-SRYKBNINF (IDX)  TO
                                       RECE10-SRYKBNINF (IDX)
           END-PERFORM
      *    給付割合
           IF      RECE62-KYURATE  >   ZERO
               COMPUTE WRK-KYURATE-9   =
                              (100     -   RECE62-KYURATE)
                                               / 10 
               MOVE    WRK-KYURATE-9   TO  RECE10-KYURATE
           ELSE
               MOVE    ZERO            TO  RECE10-KYURATE
           END-IF             
      *     
           MOVE    RECE62-AGE          TO  RECE10-AGE  
           MOVE    RECE62-KOUREI      TO  RECE10-ZAITAKU    
      *
           MOVE    RECE10-REC          TO  MCPDATA-REC
           MOVE    "SEIKYU-KEY"        TO  ORC-DBPATH
           IF      FLG-SEIKYU          =   1    
               MOVE    "DBINSERT"          TO  MCP-FUNC
           ELSE
               MOVE    "DBUPDATE"          TO  MCP-FUNC
           END-IF 
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC      
      *
           IF      MCP-RC     =   ZERO
               CONTINUE
           ELSE
               DISPLAY "ORCR0710 SEIKYU MCP-RC= "  MCP-RC   
               IF      FLG-SEIKYU          =   1    
               MOVE    "請求管理ＤＢに追加できませんでした"
                                               TO  WRK-RECEERR
               ELSE
               MOVE    "請求管理ＤＢに更新できませんでした"
                                               TO  WRK-RECEERR
               END-IF 
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                  TO  FLG-ERR
           END-IF
           .
       3904-RECE10-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       31012-SEIWA-HEN-SEC        SECTION.
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA
      *     MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG
           .
       31012-SEIWA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦→和暦日付編集
      *****************************************************************
       31012-SE-WA-YMDEDIT-SEC        SECTION.
      *
           MOVE    SPACE               TO  STS-AREA-DAY
           INITIALIZE                      STS-AREA-DAY
           MOVE    SPACE               TO  LNK-DAY1-AREA
           MOVE    "11"                TO  LNK-DAY1-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY1-YMD
           CALL    "ORCSDAY"   USING   STS-AREA-DAY  LNK-DAY1-AREA
           IF  STS-DAY-RC1             =   ZERO
               MOVE    LNK-DAY1-YMD        TO  WRK-SYMD
           ELSE
               MOVE    SPACE               TO  WRK-SYMD
           END-IF
           .
       31012-SE-WA-YMDEDIT-EXT.
           EXIT.
057400*
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
           CLOSE                       RECE62-FILE
           CLOSE                       RECE631-FILE
           CLOSE                       RECE661-FILE
      *
           IF      CNT-OUT            =   ZERO 
               MOVE    "対象データがありませんでした" TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
           DISPLAY "*** ORCR0710 IN   "  CNT-RECE62
           DISPLAY "*** ORCR0710 OUT  "  CNT-OUT
           DISPLAY "*** ORCR0710 END ***"
      ***     ACCEPT  WRK-IN
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
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０２データ順検索処理
      *****************************************************************
       990-RECE62-READ-SEC           SECTION.
      *
           READ    RECE62-FILE       NEXT
               AT  END
                   MOVE    1                   TO  FLG-RECE62
                   MOVE    HIGH-VALUE          TO  KEY-NEW
               NOT AT  END
                   MOVE    ZERO                TO  FLG-RECE62
                   IF      RECE62-TOTALTEN (1) =   ZERO
                   AND     RECE62-TOTALTEN (2) =   ZERO 
                   AND     RECE62-TOTALTEN (3) =   ZERO 
                   AND     RECE62-TOTALTEN (4) =   ZERO
                   AND     RECE62-TOTALTEN (5) =   ZERO
                       GO  TO  990-RECE62-READ-SEC
                   ELSE    
                       ADD     1                   TO  CNT-RECE62
                       MOVE    RECE62-HOSPID       TO  KEY-N-HOSPID
                       MOVE    RECE62-SRYYM        TO  KEY-N-SRYYM
                       MOVE    RECE62-NYUGAIKBN    TO  KEY-N-NYUGAIKBN
                       MOVE    RECE62-PTID         TO  KEY-N-PTID
                       MOVE    RECE62-RECEKA       TO  KEY-N-RECEKA
                       MOVE    RECE62-TEISYUTUSAKI TO
                                                   KEY-N-TEISYUTUSAKI
                       MOVE    RECE62-RECESYUBETU  TO  KEY-N-RECESYUBETU
                   END-IF    
           END-READ
      *
           .
       990-RECE62-READ-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０３１データ読み
      ****************************************************************
       990-RECE631-NEXT-SEC           SECTION.
      *
           READ    RECE631-FILE      NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE631
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE631
                   IF      RECE631-TENKIKBN     =   "8"
                       GO  TO  990-RECE631-NEXT-SEC
                   END-IF
           END-READ
      *
           .
       990-RECE631-NEXT-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０６１データ読み
      ****************************************************************
       990-RECE661-NEXT-SEC           SECTION.
      *
           READ    RECE661-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE661
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE661
                   ADD     1         TO  CNT-RECE661
                   IF      RECE661-SRYKBN    =   "54"
                       MOVE    "50"          TO  RECE661-SRYKBN
                   END-IF    
           END-READ
      *
           .
       990-RECE661-NEXT-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０９データ読み
      ****************************************************************
       990-RECE69-NEXT-SEC           SECTION.
      *
           READ    RECE69-FILE      NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE69
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE69
           END-READ
      *
           .
       990-RECE69-NEXT-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト１１データ読み
      ****************************************************************
       990-RECE67-READ-SEC           SECTION.
      *
           READ    RECE67-FILE
               INVALID
                   MOVE    1           TO  FLG-RECE67
               NOT INVALID
                   MOVE    ZERO        TO  FLG-RECE67
           END-READ
      *
           .
       990-RECE67-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト管理読込処理
      *****************************************************************
       900-RECE07-READ-SEC           SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
      *****MOVE    "RECEKANRI-KEY"     TO  ORC-DBPATH
           MOVE    "RECEKANRI-KEY4"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
      *****    MOVE    "RECEKANRI-KEY"     TO  ORC-DBPATH
               MOVE    "RECEKANRI-KEY4"    TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-RECE07
                   MOVE    MCPDATA-REC         TO  RECE07-REC
               ELSE
                   MOVE    1                   TO  FLG-RECE07
               END-IF
           ELSE
               MOVE    1                   TO  FLG-RECE07
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
      *****MOVE    "RECEKANRI-KEY"     TO  ORC-DBPATH
           MOVE    "RECEKANRI-KEY4"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-RECE07-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト印刷読込処理
      *****************************************************************
       900-RECE08-READ-SEC           SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "RECEPRT-KEY9"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "RECEPRT-KEY9"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-RECE08
               ELSE
                   MOVE    1                   TO  FLG-RECE08
               END-IF
           ELSE
               MOVE    1                   TO  FLG-RECE08
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "RECEPRT-KEY9"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-RECE08-READ-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       960-KANRIMST-READ-SEC         SECTION.
      *
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
           MOVE    WRK-PARA-SRYYM  TO  ORC-DBYMD (1:6)
           MOVE    "01"            TO  ORC-DBYMD (7:2) 
           CALL    "ORCMCPSUB"     USING
                                   MCPAREA
                                   ORCMCPAREA
                                   MCPDATA-REC
           IF      MCP-RC          =   ZERO
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               MOVE    "DBFETCH"       TO  MCP-FUNC
               CALL    "ORCMCPSUB"     USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
               IF      MCP-RC          =   ZERO
                   MOVE    ZERO            TO  FLG-KANRIMST
               ELSE
                   MOVE    1               TO  FLG-KANRIMST
               END-IF
           ELSE
               MOVE    1               TO  FLG-KANRIMST
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       960-KANRIMST-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読み込み処理
      *****************************************************************
       900-KANRIMST-NEXT-SEC         SECTION.
      *
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-KANRIMST
           ELSE
               MOVE    1               TO  FLG-KANRIMST
           END-IF
      *
           .
       900-KANRIMST-NEXT-EXT.
           EXIT.
      *****************************************************************
      *    保険番号マスタ次検索処理
      *****************************************************************
       910-HKNMST-NEXT-SEC              SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  HKNNUM-REC
               MOVE    ZERO            TO  FLG-HKNNUM
           ELSE
               INITIALIZE              HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
           .
       910-HKNMST-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求マスター読込（主キー）
      *****************************************************************
       900-SEIKYU-INV-SEC         SECTION.
      *
           MOVE    RECE10-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SEIKYU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SEIKYU-KEY"        TO  ORC-DBPATH
               PERFORM 900-SEIKYU-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SEIKYU
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SEIKYU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-SEIKYU-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求マスター読込
      *****************************************************************
       900-SEIKYU-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SEIKYU
           ELSE
               MOVE    1               TO  FLG-SEIKYU
           END-IF
      *
           .
       900-SEIKYU-READ-EXT.
           EXIT.
      *****************************************************************
      *    レセプトコメントマスタ　ＲＥＡＤ
      *****************************************************************
       900-RECECOM-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-RECECOM
               MOVE    MCPDATA-REC     TO  RECECOM-REC
           ELSE
               MOVE    1               TO  FLG-RECECOM
           END-IF
           .
       900-RECECOM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込（主キー）
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTINF-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  PTINF-REC
                   MOVE    ZERO                TO  FLG-PTINF
               ELSE
                   MOVE    1                   TO  FLG-PTINF
                   INITIALIZE                  PTINF-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *      
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
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
