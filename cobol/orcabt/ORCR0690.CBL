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
       PROGRAM-ID.             ORCR0690.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
000600*  サブシステム名    : レセプト（入院）
000700*  コンポーネント名  : 摘要欄編集
000800*  管理者            : 
      *  作成日付    作業者        記述
      *  02/12/10    NACL−藤原　  新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-藤原    03.01.20  未実施減算のときの▲表示
      *                                     検査の回数の編集
      *                                     画像診断のフィルムを手技に表示
      *  01.00.02    NACL-藤原    03.01.28  検査のとき加算は検査数の対象と
      *                                     しない
      *  01.00.03    NACL-藤原    03.01.30  乳幼児加算の時手技に表示
      *  01.00.04    NACL-藤原    03.02.04  検査に加算があるときまとめない
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    レセプト０２データ
           SELECT  RECE62-FILE     ASSIGN  RECE01PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE62-KEY
                                   FILE    STATUS  IS  STS-RECE62.
      *    レセプト０４データ
           SELECT  RECE64-FILE     ASSIGN  RECE64PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE64-KEY
                                   FILE    STATUS  IS  STS-RECE64.
      *    レセプト０５データ
           SELECT  RECE65-FILE     ASSIGN  RECE65PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE65-KEY
                                   FILE    STATUS  IS  STS-RECE65.
      *    レセプト０６データ
           SELECT  RECE66-FILE     ASSIGN  RECE66PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE66-KEY
                                   FILE    STATUS  IS  STS-RECE66.
      *    レセプト０６´データ
           SELECT  RECE66X-FILE     ASSIGN  RECE66PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE66X-KEY
                                   FILE    STATUS  IS  STS-RECE66.
006900*    エラーファイル
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
      *    レセプト０６データ
       FD  RECE66-FILE.
       01  RECE66-REC. 
           COPY    "CPRCF066.INC".
      *
      *    レセプト０６´データ
       FD  RECE66X-FILE.
       01  RECE66X-REC. 
           COPY    "CPRCF066.INC"  REPLACING  //RECE66//
                                   BY         //RECE66X//.
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
                                   BY         //RECE64//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE65//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE66//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *     
      *    フラグ領域
       01  STS-AREA.
           03  SPA-STS             PIC 9(04).
           03  STS-RECE62          PIC X(02).
           03  STS-RECE64          PIC X(02).
           03  STS-RECE65          PIC X(02).
           03  STS-RECE66          PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-RECE62          PIC 9(01).
           03  FLG-RECE64          PIC 9(01).
           03  FLG-RECE65          PIC 9(01).
           03  FLG-SP              PIC 9(01).
           03  FLG-NOPRT           PIC 9(01).
           03  FLG-SYOSIN          PIC 9(01).
           03  FLG-KEIKNRKSN       PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-KENSA           PIC 9(01).
           03  FLG-TEIGEN          PIC 9(01).
           03  FLG-COMMENT         PIC 9(01).
           03  FLG-COMMENT2        PIC 9(01).
           03  FLG-HIKAKIN         PIC 9(01).
           03  FLG-DSAISHIN        PIC 9(01).
           03  FLG-SRYCD1          PIC 9(01).
           03  FLG-OK              PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-RECE62          PIC 9(06).
           03  CNT-RECE64          PIC 9(06).
           03  CNT-RECE65          PIC 9(06).
           03  CNT-RECE66          PIC 9(06).
      *
           03  CNT-SRYKBN60        PIC 9(03).     
      *
      *    添字領域
       01  IDX-AREA.
           03  IDW                 PIC 9(04). 
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
      *    点数回数編集用     
           03  IDA                 PIC 9(04).
           03  IDB                 PIC 9(04).
      *    剤診療行為コード別編集用     
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
      *     
           03  WRK-SYU-INDEX       PIC 9(04).
           03  WRK-YKZ-INDEX       PIC 9(04).
           03  WRK-KIZ-INDEX       PIC 9(04).
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
           03  WRK-RECEERR         PIC X(200).
      *
           03  WRK-LINENUM         PIC 9(05).
      *
           03  WRK-TENSUGOKEI      PIC 9(07).
      *    剤印字行数
           03  WRK-TBLMAX          PIC 9(03).
      *    剤明細総数（診療行為コード別）
           03  WRK-ZAIWMAX-G.
               05  WRK-ZAIWMAX     PIC 9(03)   OCCURS  6.
      *    剤印字対象数
           03  CNT-ZAITAISYO       PIC 9(03).
      * 
           03  WRK-YUKOKETA        PIC  9(02).
           03  WRK-NAME            PIC  X(200).
      *
           03  WRK-RECE65          PIC 9(01).     
      *
      *    数字半角全角変換用     
           03  WRK-NUM                         PIC 9(01).
           03  WRK-CHAR-IDX                    PIC 9(02).
           03  WRK-CHAR-HENKAN-AREA.
               05  WRK-CHAR-X                  PIC X(10).
               05  WRK-CHAR-N                  PIC X(20).
               05  WRK-CHAR-CNT                PIC 9(02).
               05  WRK-CHAR-FLG                PIC 9(01). 
               05  WRK-CHAR-N-CNT              PIC 9(02).
      *
           03  WRK-EDIT-AREA.
               05  WRK-CLM                     PIC 9(03).
               05  WRK-WCLM                    PIC 9(03).
      *
           03  WRK-RECE62-KEY.
               05  WRK-R02-HOSPID              PIC  X(24).
               05  WRK-R02-SRYYM               PIC  9(06).
               05  WRK-R02-NYUGAIKBN           PIC  X(01).
               05  WRK-R02-PTID                PIC  9(10).
               05  WRK-R02-RECEKA              PIC  X(02).
               05  WRK-R02-TEISYUTUSAKI        PIC  9(01).
               05  WRK-R02-RECESYUBETU         PIC  9(04).
               05  WRK-R02-HKNJANUM-KEY        PIC  X(08).
               05  WRK-R02-TEKSTYMD            PIC  X(08). 
      *
           03  WRK-KOUI                        PIC X(210).
      *
           03  WRK-ZAI.
               05  WRK-ZAI-MK                  PIC X(02).
               05  WRK-ZAI-NAME.
                   07  FILLER                  PIC X(28).
                   07  WRK-ZAI-TNSKAI          PIC X(22).
      *
           03  WRK-TNSKAI.
               05  WRK-ZAITEN                  PIC X(14).
               05  WRK-X                       PIC X(02).
               05  WRK-ZAIKAISU                PIC X(06).
      *
           03  WRK-ZAITENX                     PIC ZZZZZZ9.
           03  WRK-ZAIKAISUX                   PIC ZZ9.
           03  WRK-TNSKAI-ST                   PIC 9(02).
           03  WRK-TNSKAI-KETA                 PIC 9(02).
      *
           03  WRK-SRYCD                       PIC X(01).
      *     
           03  WRK-R05IDX                      PIC 9(02).
      *
      *    検査の回数
           03  WRK-KENSA-KAISU                 PIC 9(05). 
      *     
           03  WRK-WLINETEK                    PIC 9(03).
           03  WRK-SRYSURYOW                   PIC X(20).
           03  WRK-ZAIIDX                      PIC 9(03).
           03  WRK-NAMEKETA                    PIC 9(03).
           03  WRK-YOHAKU                      PIC 9(03).
           03  WRK-WKETA                       PIC 9(03).
      *    分画数編集用     
           03  WRK-BUNKAKUKETA                 PIC 9(02).
           03  WRK-BUNKAKU-N                   PIC X(06).
           03  WRK-SRYKAISU-X                  PIC ZZ9.
      *    数量編集用     
           03  WRK-SURYOKETA                   PIC 9(02).
           03  WRK-SURYOKETA1                  PIC 9(02).
           03  WRK-SURYOKETA2                  PIC 9(02).
           03  WRK-SURYOST                     PIC 9(02).
           03  WRK-SURYO                       PIC 9(05)V9(03).
           03  WRK-SURYO-R  REDEFINES  WRK-SURYO.
               05  WRK-SURYO-S1                PIC 9(05).
               05  WRK-SURYO-S2                PIC 9(03).
           03  WRK-SURYO-X.
               05  WRK-SURYO-Z1                PIC ZZZZZ.
               05  WRK-SURYO-Z2                PIC X(01).
               05  WRK-SURYO-Z3                PIC ZZZ.
           03  WRK-SURYO-N.
               05  WRK-SURYO-N1                PIC X(10).
               05  WRK-SURYO-N2                PIC X(02).
               05  WRK-SURYO-N3                PIC X(06).
      *    剤診療行為コード別編集用     
           03  WRK-WIDX1                       PIC 9(03).
           03  WRK-WIDX2                       PIC 9(03).
      *     
           03  WRK-SRYKBN                      PIC X(02).
           03  WRK-Z9                          PIC ZZZ9.
      *
      *    剤の診療種別区分
           03  WRK-SRYSYUKBN                   PIC X(03).
      *
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
      *    剤・診療行為テーブル
       01  TBL-ZAI-AREA.
           03  TBL-ZAI-OCC         OCCURS   100.
               05  TBL-ZAI         PIC X(52).
               05  TBL-ZAI-IDX     PIC 9(01).
      *
      *    検査をまとめるテーブル
       01  WRK-KAISU-G.
           03  WRK-KAKSU-OCC               OCCURS  4.
               05  WRK-KAISU               PIC 9(03).  
           03  WRK-KAISU1                  PIC 9(02).
       01  WRK-HOUKNSKBN                   PIC 9(01).
       01  WRK-KOHBUNRI                    PIC 9(01).
      *
       01  WRK-RECE64-ZAITEN               PIC 9(08). 
      *         
       01  WRK-RECE64-MAX                  PIC 9(03).
       01  WRK-SUM-KAISU-TABLE.
           03  WRK-SUM-KAISU               PIC 9(04)
                                                  OCCURS  31.
       01  WRK-RECE64-FLG-TABLE.
           03  WRK-RECE64-FLG              PIC 9(01)
                                                  OCCURS  100.
       01  WRK-RECE64-TABLE.
           03  WRK-RECE64-TBL              OCCURS  100.
               05  WRK-RECE64-HOUKNSKBN           PIC 9(01).
               05  WRK-RECE64-KOHBUNRI            PIC 9(01).
               05  WRK-RECE64-REC                 PIC X(500).
               05  WRK-RECE64-DAY-AREA.
                   07  WRK-RECE64-DAY-TBL         OCCURS  4.
                       09  WRK-RECE64-KAISUINF    OCCURS  31.
                           11  WRK-RECE64-KAISU   PIC  9(03).
      *             
      *    検査のとき適用の編集に使用
       01  WRK-KENSA-MAX                   PIC 9(04).
       01  TBL-NAME-AREA.
           03  TBL-NAME-REC      OCCURS 100.
               05  TBL-SRYCD               PIC  X(09).
               05  TBL-SRYSURYO            PIC  9(05)V9(03).
      *        単位コード/単位名称有効桁数/単位名称
               05  TBL-TANICD              PIC  9(03).
               05  TBL-TANIMOJISU          PIC  9(01).
               05  TBL-TANINAME            PIC  X(24).
               05  TBL-NAMEINF.
      *            漢字有効桁数/漢字名称
                   07  TBL-YUKOKETA        PIC  9(02).
                   07  TBL-NAME            PIC  X(200).
      *        データ区分情報
               05  TBL-DATAKBN             PIC  9(01).
      *
      *     検査の項目数用
        01  WRK-KOUMOKUSU               PIC 9(02). 
        01  WRK-TNS-HOUKNSKBN           PIC 9(02).
        01  WRK-CONS-KENSACOMMENT-AREA.
            03  WRK-CONS-KENSACOMMENT-G.
                05  FILLER                 PIC X(50)   VALUE
                "血液化学検査".                        
                05  FILLER                 PIC X(50)   VALUE
                "内分泌学的検査".                        
                05  FILLER                 PIC X(50)   VALUE
                "肝炎ウイルス関連検査".                        
                05  FILLER                 PIC X(50)   VALUE
                "腫瘍マーカーのうちα−フェトプロテイン等".                        
                05  FILLER                 PIC X(50)   VALUE
                "腫瘍マーカー".                        
                05  FILLER                 PIC X(50)   VALUE
                "出血・凝固検査".                        
                05  FILLER                 PIC X(50)   VALUE
                "自己抗体検査".                        
                05  FILLER                 PIC X(50)   VALUE
                "内分泌負荷試験".                        
            03  WRK-CONS-KENSACOMMENT-R    REDEFINES
                                           WRK-CONS-KENSACOMMENT-G.
                05  WRK-CONS-KENSACOMMENT  PIC X(50)   OCCURS  8.
      *          
       01  TBL-ZAIW-AREA.
      *    剤の先頭の診療コード
           03  TBL-ZAIW-SRYCD1             PIC X(09).
      *     
      *    診療行為別テーブル
      *    １：ユーザーコメント、２：コメント、
      *    ３：診療行為、４：薬剤、５：特定器材                     
           03  TBL-ZAIW-OCC                OCCURS 5.  
               05  TBL-ZAIW-REC            OCCURS 100.
                   07  TBL-ZAIW-SRYACTINF.
      *                診療コード/数量/回数
                       09  TBL-ZAIW-SRYCD           PIC  X(09).
                       09  TBL-ZAIW-SRYSURYO        PIC  9(05)V9(03).
                       09  TBL-ZAIW-SRYKAISU        PIC  9(03).
      *                単位コード/単位名称有効桁数/単位名称
                       09  TBL-ZAIW-TANICD          PIC  9(03).
                       09  TBL-ZAIW-TANIMOJISU      PIC  9(01).
                       09  TBL-ZAIW-TANINAME        PIC  X(24).
      *                点数識別区分/点数/明細請求フラグ
                       09  TBL-ZAIW-TENSIKIBETU     PIC  9(01).
                       09  TBL-ZAIW-TEN             PIC  9(09)V9(02).
                       09  TBL-ZAIW-MEISKYFLG       PIC  X(01).
      *                自動算定区分/名称入力番号/点数欄集計先識別
                       09  TBL-ZAIW-AUTOKBN         PIC  X(01).
                       09  TBL-ZAIW-INPUTNUM        PIC  9(03).
                       09  TBL-ZAIW-TENTTLKBN       PIC  9(03).
                   07  TBL-ZAIW-NAMEINF.
      *                漢字有効桁数/漢字名称
                       09  TBL-ZAIW-YUKOKETA        PIC  9(02).
                       09  TBL-ZAIW-NAME            PIC  X(200).
      *                データ区分情報
                   07  TBL-ZAIW-DATAKBNINF.
                       09  TBL-ZAIW-DATAKBN         PIC  9(01).
      *
       01  TBL-ZAI-MAX         PIC  9(03)  VALUE   100.              
      *
      *   日本語数字
       01  TBL-SUJI-AREA.
           03  FILLER          PIC X(20)   VALUE
              "１２３４５６７８９０".
       01  TBL-SUJI-R          REDEFINES   TBL-SUJI-AREA.
           03  TBL-SUJI        PIC X(02)   OCCURS   10.
      *
      *   印字しない診療行為テーブル
       01  TBL-NOSRYCD-AREA.
      *    初診（病院）
           03  FILLER          PIC X(09)   VALUE   "111000110".
      *    初診（診療所）
           03  FILLER          PIC X(09)   VALUE   "111003610".
      *    初診（病院）
           03  FILLER          PIC X(09)   VALUE   "111700110".
      *    初診（診療所）
           03  FILLER          PIC X(09)   VALUE   "111700210".
      *    再診（乳幼児）加算
      ***     03  FILLER          PIC X(09)   VALUE   "112000970".
      *    再診（幼児）加算
      ***     03  FILLER          PIC X(09)   VALUE   "112001070".
      *    時間外（再診）
      ***     03  FILLER          PIC X(09)   VALUE   "112001110".
      *    休診（再診）
      ***     03  FILLER          PIC X(09)   VALUE   "112001210".
      *    深夜（再診）
      ***     03  FILLER          PIC X(09)   VALUE   "112001310".
      *    外来管理加算
      ***     03  FILLER          PIC X(09)   VALUE   "112005610".
      *    再診（乳幼児）（時間外等）加算
      ***     03  FILLER          PIC X(09)   VALUE   "112006970".
      *    再診（幼児）（時間外等）加算
      ***     03  FILLER          PIC X(09)   VALUE   "112007070".
      *    継続管理加算
      **** 03  FILLER          PIC X(09)   VALUE   "112007170".
      *    時間外（再診）
      ***     03  FILLER          PIC X(09)   VALUE   "112701010".
      *    休日（再診）
      ***     03  FILLER          PIC X(09)   VALUE   "112701110".
      *    深夜（再診）
      ***     03  FILLER          PIC X(09)   VALUE   "112701210".
      *    継続管理加算
      *    03  FILLER          PIC X(09)   VALUE   "112702270".
      *    処方料（７種類以上）
           03  FILLER          PIC X(09)   VALUE   "120002610".
      *    処方料（その他）
           03  FILLER          PIC X(09)   VALUE   "120001210".
      *    処方料（麻・向・覚・毒）
           03  FILLER          PIC X(09)   VALUE   "120001310".
      *    調基（その他）
           03  FILLER          PIC X(09)   VALUE   "120001810".
      *    調基（入院）
           03  FILLER          PIC X(09)   VALUE   "120001710".
      *    調剤・処方料（麻・向・覚・毒）
           03  FILLER          PIC X(09)   VALUE   "120002030".
      *    調剤料（外用薬）
           03  FILLER          PIC X(09)   VALUE   "120001010".
      *    調剤料（内用薬・浸煎薬・頓服薬）
           03  FILLER          PIC X(09)   VALUE   "120000710".
      *    調剤料（入院）
           03  FILLER          PIC X(09)   VALUE   "120001110".
      *    調剤料（麻・向・覚・毒）（入院）
           03  FILLER          PIC X(09)   VALUE   "120000410".
      *    調剤料（麻・向・覚・毒）（入院外）
           03  FILLER          PIC X(09)   VALUE   "120000110".
      *    再診（１回目）
           03  FILLER          PIC X(09)   VALUE   "112009210".
      *    同日再診（１回目）
      ***     03  FILLER          PIC X(09)   VALUE   "112010150".
      *    電話等再診（１回目）
      ***     03  FILLER          PIC X(09)   VALUE   "112009750".
      *    同日電話等再診（１回目）
      ***     03  FILLER          PIC X(09)   VALUE   "112010650".
      *    老人再診（１回目）
           03  FILLER          PIC X(09)   VALUE   "112703710".
      *    老人同日再診（１回目）
      ***     03  FILLER          PIC X(09)   VALUE   "112704450".
      *    老人電話等再診（１回目）
      ***     03  FILLER          PIC X(09)   VALUE   "112704150".
      *    老人同日電話等再診（１回目）
      ***     03  FILLER          PIC X(09)   VALUE   "112704850".
      *    外来管理加算（３回目まで）
           03  FILLER          PIC X(09)   VALUE   "112011010".
      *    老人外来管理加算（３回目まで）
           03  FILLER          PIC X(09)   VALUE   "112705310".
      *    実日数算定
           03  FILLER          PIC X(09)   VALUE   "099409901".
      *    初診料ダミー
           03  FILLER          PIC X(09)   VALUE   "099110001".
      *    再診料ダミー
           03  FILLER          PIC X(09)   VALUE   "099120001".
      *    初診料算定科：
           03  FILLER          PIC X(09)   VALUE   "830000020".
      *    再診料算定科：
           03  FILLER          PIC X(09)   VALUE   "830000021".
       01  TBL-NOSRYCD-R       REDEFINES   TBL-NOSRYCD-AREA.
            03  TBL-NOSRYCD     PIC X(09)   OCCURS   24.       
      *
       01  TBL-NOSRYCD-MAX     PIC 9(02)   VALUE   24.         
      *
      *    固定値
       01  CONST-AREA.
      *    画像診断の単位の変更（枚→回）
           03  WRK-CONS-TANICD PIC 9(03)   VALUE   006.
           03  WRK-CONS-TANINAME
                               PIC X(02)   VALUE   "回".
           03  WRK-CONS-BUNKAKU-MOJISU
                               PIC 9(02)   VALUE   4.                    
           03  WRK-CONS-BUNKAKU
                               PIC X(04)   VALUE   "分画".                          
      *    継続管理加算
           03  CONS-KEIZOKU    PIC X(09)   VALUE   "112007170".
           03  CONS-KEIZOKU1   PIC X(09)   VALUE   "112702270".
      *    外来管理加算
           03  CONS-GAIRAI     PIC X(09)   VALUE   "112005610".
      *    薬剤料逓減
           03  CONS-TEIGEN     PIC X(09)   VALUE   "630010002".
      *    薬剤（減）
           03  CONS-YKZ20      PIC X(09)   VALUE   "820000047".
      *---- (01.00.05) LINE ADD START --------------------------------
      *フリーコメント
      *    電話再診（　回）
           03  CONS-COMMENT1   PIC X(09)   VALUE   "840000001".
      *    同日複数再診（　回） 
           03  CONS-COMMENT2   PIC X(09)   VALUE   "840000002".
      *    フリーコメント 
           03  CONS-COMMENT3   PIC X(09)   VALUE   "810000001".
      *    複数診療科受診
           03  CONS-COMMENT4   PIC X(09)   VALUE   "099999901".
      *    集団検診から
           03  CONS-COMMENT5   PIC X(09)   VALUE   "820000003".
      *    老人検診から
           03  CONS-COMMENT6   PIC X(09)   VALUE   "820000004".
      *    学校検診から
           03  CONS-COMMENT7   PIC X(09)   VALUE   "820000005".
      *    健康診断から
           03  CONS-COMMENT8   PIC X(09)   VALUE   "820000006".
      *---- (01.00.05) LINE ADD END   --------------------------------
      *---- (01.01.07) LINE ADD START --------------------------------
      *同日再診関係
      *    【老】同日再診（診療所）
           03  CONS-DSAISHIN1  PIC X(09)   VALUE   "112700850".
      *    同日再診（診療所） 
           03  CONS-DSAISHIN2  PIC X(09)   VALUE   "112003350".
      *    【老】同日電話等再診（診療所）
           03  CONS-DSAISHIN3  PIC X(09)   VALUE   "112700950".
      *    同日電話等再診（診療所）
           03  CONS-DSAISHIN4  PIC X(09)   VALUE   "112003150".
      *---- (01.01.07) LINE ADD END   --------------------------------
      *皮下筋肉注射
           03  CONS-HIKAKIN    PIC X(09)   VALUE   "130000510".
      *初診加算     
      *    初診（診療所）紹介患者加算
           03  WRK-CONS-SYOSIN-KASAN1  PIC X(09)   VALUE 
                                                   "111003770".                
      *    老人初診（診療所）紹介患者加算
           03  WRK-CONS-SYOSIN-KASAN2  PIC X(09)   VALUE 
                                                   "111700470".
      *    初診（乳幼児）加算
           03  WRK-CONS-SYOSIN-KASAN3  PIC X(09)   VALUE 
                                                   "111000370".
      *    初診（育児栄養指導）加算
           03  WRK-CONS-SYOSIN-KASAN4  PIC X(09)   VALUE 
                                                   "111000470".
      *    小児科外来診療料（初診時診療時の紹介患者）加算
           03  WRK-CONS-SYOSIN-KASAN5  PIC X(09)   VALUE 
                                                   "111010370".
      *    小児科外来診療料（紹介患者加算３）
           03  WRK-CONS-SYOSIN-KASAN6  PIC X(09)   VALUE 
                                                   "111010870".
      *    小児科外来診療料（紹介患者加算４）
           03  WRK-CONS-SYOSIN-KASAN7  PIC X(09)   VALUE 
                                                   "111010970".
      *    小児科外来診療料（紹介患者加算５）
           03  WRK-CONS-SYOSIN-KASAN8  PIC X(09)   VALUE 
                                                   "111011070".
      *    小児科外来診療料（紹介患者加算６）
           03  WRK-CONS-SYOSIN-KASAN9  PIC X(09)   VALUE 
                                                   "111011170".
      *    未実施減算
           03  CONS-GENZAN1            PIC X(09)   VALUE   "190080470".
           03  CONS-GENZAN2            PIC X(09)   VALUE   "190799670".
           03  CONS-GENZAN3            PIC X(09)   VALUE   "190080570".
           03  CONS-GENZAN4            PIC X(09)   VALUE   "190799770".
           03  CONS-GENZAN5            PIC X(09)   VALUE   "190111690".
           03  CONS-GENZAN6            PIC X(09)   VALUE   "190809090".
           03  CONS-GENZAN7            PIC X(09)   VALUE   "190111790".
           03  CONS-GENZAN8            PIC X(09)   VALUE   "190809190".
      *    検査の回数に集計しない診療行為
      *    採血（Ｂ−Ａ）
           03  WRK-CONS-SAIKETSU1      PIC X(09)   VALUE "160101210".
      *    採血（Ｂ−Ｖ）
           03 WRK-CONS-SAIKETSU2       PIC X(09)   VALUE "160095710".
      *    採血（Ｂ−Ｃ）
           03 WRK-CONS-SAIKETSU3       PIC X(09)   VALUE "160095810".
      *
      *    フィルム料（乳幼児）加算
           03  WRK-CONS-FILM-YOUJI-KASAN
                                       PIC X(09)   VALUE 
                                                   "799990070".
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
      *    点数
           COPY    "CPTENSU.INC".
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
           INITIALIZE                  SPA-AREA
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  TBL-ZAI-AREA
           INITIALIZE                  TBL-ZAIW-AREA
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
           MOVE    "ORCR0690"      TO  JOB-PGID
           MOVE    "摘要欄編集"    TO  JOB-SHELLMSG
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
           MOVE    "RECE620"           TO  RECE01PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE01PARA-TERMID
      *
           MOVE    "RECE641"           TO  RECE64PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE64PARA-TERMID
      *
           MOVE    "RECE651"           TO  RECE65PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE65PARA-TERMID
      *
           MOVE    "RECE660"           TO  RECE66PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE66PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
           OPEN    I-O                 RECE62-FILE
      *
           OPEN    INPUT               RECE64-FILE
      *
           OPEN    INPUT               RECE65-FILE
      *
           OPEN    OUTPUT              RECE66X-FILE
           CLOSE                       RECE66X-FILE
      *
           OPEN    I-O                 RECE66-FILE
      *
           .
       110-FILE-OPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *        行カウンタ初期化
           MOVE    ZERO                TO  WRK-LINENUM
      *    検査回数初期化
           MOVE    ZERO                TO   WRK-KENSA-KAISU
      *
           MOVE    ZERO                TO  CNT-SRYKBN60   
           INITIALIZE                      WRK-RECE64-TABLE
                                           WRK-RECE64-MAX 
                                           WRK-SUM-KAISU-TABLE
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
           MOVE    RECE62-HKNJANUM-KEY TO  RECE64-HKNJANUM
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
               UNTIL  ( SPA-STS              =   2                   )
               OR     ( FLG-RECE64           =   1                   )
               OR     ( RECE62-HOSPID    NOT =   RECE64-HOSPID       )
               OR     ( RECE62-SRYYM     NOT =   RECE64-SRYYM        )
               OR     ( RECE62-NYUGAIKBN NOT =   RECE64-NYUGAIKBN    )
               OR     ( RECE62-PTID      NOT =   RECE64-PTID         )
               OR     ( RECE62-RECEKA    NOT =   RECE64-RECEKA       )
               OR     ( RECE62-TEISYUTUSAKI
                                         NOT =   RECE64-TEISYUTUSAKI )
               OR     ( RECE62-RECESYUBETU
                                         NOT =   RECE64-RECESYUBETU  )
               OR     ( RECE62-HKNJANUM-KEY
                                         NOT =   RECE64-HKNJANUM     )
               OR     ( RECE62-HOJOKBN-KEY
                                         NOT =   RECE64-HOJOKBN      )
               OR     ( RECE62-TEKSTYMD  NOT =   RECE64-TEKSTYMD     )
      *
               MOVE    ZERO                  TO  FLG-SRYCD1
      *
               INITIALIZE                      TBL-ZAIW-AREA
               MOVE    ZERO                TO  WRK-ZAIWMAX-G
               MOVE    ZERO                TO  WRK-TBLMAX
               MOVE    ZERO                TO  WRK-TENSUGOKEI
               MOVE    ZERO                TO  FLG-SYOSIN
      *****    MOVE    RECE64-SRYKBN       TO  WRK-SRYKBN
               MOVE    ZERO                TO  FLG-TEIGEN
                                               FLG-COMMENT
                                               FLG-COMMENT2
                                               FLG-HIKAKIN 
               MOVE    ZERO                TO  WRK-RECE65
                                               IDY                           
               MOVE    SPACE               TO  WRK-SRYSYUKBN
      *         
               PERFORM 2002-TBLZAIW-TAIHI-SEC
      *
      *        レセプト０４剤編集前処理
               PERFORM 2001-RECE64-ZAIHEN-MAE-SEC
      *
               IF      SPA-STS          =   ZERO
      * 
      *            レセプト０４ファイル編集処理
                   EVALUATE    RECE64-SRYKBN
      *                初診
                       WHEN    "11"
                           PERFORM 2003-SRYKBN11-HENSYU-SEC
      *                再診
                       WHEN    "12"
                           PERFORM 2004-SRYKBN12-HENSYU-SEC
      *                検査
                       WHEN    "60"
                           PERFORM 2006-SRYKBN60-CHECK-SEC 
      *                それ以外
                       WHEN    OTHER
                           PERFORM 2005-SRYKBNELSE-HENSYU-SEC
                   END-EVALUATE
      *
                   ADD     1               TO  CNT-RECE64
      *
                   PERFORM 990-RECE64-NEXT-SEC
               END-IF     
           END-PERFORM
      *
      *    検査があるときまとめる
           IF      WRK-RECE64-MAX          >   ZERO
               PERFORM 2007-SRYKBN60-HENSYU-SEC
           END-IF         
      *
      *    検査のとき回数を編集する
           IF      WRK-KENSA-KAISU        >   ZERO
               MOVE    WRK-KENSA-KAISU        TO  RECE62-KAISU  (17)
               REWRITE RECE62-REC
           END-IF
      *
           PERFORM 990-RECE62-READ-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０４より剤編集前処理
      *****************************************************************
       2001-RECE64-ZAIHEN-MAE-SEC     SECTION.
      *
           MOVE    SPACE               TO  WRK-ZAI
           MOVE    "＊"                TO  WRK-ZAI-MK
           MOVE    ZERO                TO  WRK-CLM
      *    点数・回数セット
           MOVE    RECE64-ZAITEN       TO  WRK-ZAITENX
           MOVE    RECE64-ZAIKAISU     TO  WRK-ZAIKAISUX
      *    必要有効桁数・開始位置・回数編集
           PERFORM 810-TENSUKAI-HEN-SEC
      *
           .
       2001-RECE64-ZAIHEN-MAE-EXT.
           EXIT.
      *
      *****************************************************************
      *    剤　明細テーブル退避処理
      *****************************************************************
       2002-TBLZAIW-TAIHI-SEC    SECTION.
      *
      *    パラメータ０５ファイルより編集
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
           MOVE    RECE64-ZAIREN       TO  RECE65-ZAIREN
           START   RECE65-FILE
               KEY IS    >=   RECE65-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE65
               NOT INVALID
                   PERFORM 990-RECE65-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( SPA-STS              =   2                   )
               OR     ( FLG-RECE65           =   1                   )
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
               OR     ( RECE64-ZAIREN    NOT =   RECE65-ZAIREN       )
      *
               PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX               >   5     )
                         OR      ( RECE65-SRYCD(IDX) =   SPACE )
                         OR      ( SPA-STS           =   2     ) 
      *
                   IF      RECE65-SRYCD (IDX) (1:1)  =   "1"
                       IF      TBL-DATAKBN (IDX)         =   "2"
                           MOVE    1                     TO  FLG-SRYCD1
                       END-IF
                   ELSE
                       MOVE    1                     TO  FLG-SRYCD1
                   END-IF
      *                     
                   IF      RECE64-SRYKBN     <   "31"
                       MOVE    1             TO  IDY
                   ELSE                          
                       EVALUATE    RECE65-SRYCD (IDX) (1:1)
                           WHEN    "0"
                             IF      RECE65-SRYCD (IDX) (1:3) = "059"
                                 MOVE   4              TO  IDY
                             ELSE
                                 IF      IDY           =   ZERO
                                     MOVE    1             TO  IDY
                                 END-IF
                           END-IF    
                           WHEN    "8"
                               IF      IDY           =   ZERO
                                   MOVE    2             TO  IDY
                               END-IF    
                           WHEN    "1"
                               MOVE    3             TO  IDY
                           WHEN    "6"
                               MOVE    5             TO  IDY
                           WHEN    "7"
                               IF    ( RECE64-SRYKBN     =   "70" )
                               AND   ( RECE65-DATAKBN (IDX)
                                                         =   "3"  )
                                   MOVE    3                 TO  IDY
                               ELSE
                                   IF      RECE65-SRYCD (IDX)    =
                                             WRK-CONS-FILM-YOUJI-KASAN
                                       MOVE    3             TO  IDY
                                   ELSE
                                       MOVE    4             TO  IDY
                                   END-IF
                               END-IF
                           WHEN    OTHER
                               DISPLAY "ORCR0690 SRYCD="
                                                 RECE65-SRYCD (IDX) 
                               MOVE    "診療行為コードが範囲外です"
                                                 TO  WRK-RECEERR
                               PERFORM 500-ERR-HENSYU-SEC
                               MOVE    2             TO  SPA-STS
                               GO  TO  2002-TBLZAIW-TAIHI-EXT
                       END-EVALUATE
                   END-IF            
                   ADD     1                 TO  WRK-ZAIWMAX (IDY)
                                                 WRK-ZAIWMAX (6)
                   IF      WRK-ZAIWMAX (IDY) >   TBL-ZAI-MAX 
                       MOVE    "テーブルがオーバーしました"
                                                 TO  WRK-RECEERR
                       PERFORM 500-ERR-HENSYU-SEC
                       MOVE    2                 TO  SPA-STS
                       GO  TO  2002-TBLZAIW-TAIHI-EXT
                   ELSE
      *                先頭の診療行為コード編集              
                       IF      WRK-RECE65        =   ZERO
                           MOVE    RECE65-SRYCD (IDX)
                                                 TO  TBL-ZAIW-SRYCD1 
                           MOVE    RECE65-SRYSYUKBN
                                                 TO  WRK-SRYSYUKBN
                           MOVE    1             TO  WRK-RECE65
                       END-IF
      *                                                         
                       MOVE    WRK-ZAIWMAX (IDY) TO  IDZ
                       MOVE    RECE65-SRYACTINF (IDX)
                                     TO  TBL-ZAIW-SRYACTINF (IDY IDZ)
                       MOVE    RECE65-NAMEINF   (IDX)
                                     TO  TBL-ZAIW-NAMEINF   (IDY IDZ)
                       MOVE    RECE65-DATAKBNINF(IDX)
                                     TO  TBL-ZAIW-DATAKBNINF(IDY IDZ)
                       IF      RECE65-SRYCD (IDX) (1:1)
                                                 =   "1"
                       AND     RECE64-SRYKBN     =   "70"
                       AND     RECE65-TANICD(IDX)
                                                 =   WRK-CONS-TANICD
                           MOVE    WRK-CONS-TANINAME TO 
                                         TBL-ZAIW-TANINAME  (IDY IDZ) 
                       END-IF                     
      *
      *---- (01.00.05) LINE ADD START --------------------------------
                       IF      RECE65-SRYCD(IDX) =   CONS-COMMENT1   OR
                                                     CONS-COMMENT2   OR
                                                     CONS-COMMENT3   OR
                                                     CONS-COMMENT4   
                           MOVE    1             TO  FLG-COMMENT
                       END-IF 
                       IF      RECE65-SRYCD(IDX) =   CONS-COMMENT5   OR
                                                     CONS-COMMENT6   OR
                                                     CONS-COMMENT7   OR
                                                     CONS-COMMENT8     
                           MOVE    1             TO  FLG-COMMENT2      
                       END-IF                                          
      *---- (01.00.05) LINE ADD END --------------------------------
      *
                       IF      RECE65-SRYCD(IDX) =   CONS-TEIGEN
                           MOVE    1             TO  FLG-TEIGEN
                       END-IF
                       IF    ( RECE64-SRYKBN     =   "90" OR "92"      )
                       AND   ( RECE65-SRYCD(IDX) =   CONS-GENZAN1  OR 
                                                     CONS-GENZAN2  OR
                                                     CONS-GENZAN3  OR
                                                     CONS-GENZAN4  OR
                                                     CONS-GENZAN5  OR
                                                     CONS-GENZAN6  OR
                                                     CONS-GENZAN7  OR
                                                     CONS-GENZAN8      )
                           MOVE    1             TO  FLG-TEIGEN
                       END-IF
                       IF    ( RECE64-SRYKBN     =   "31"         )
                       AND   ( RECE65-SRYCD(IDX) =   CONS-HIKAKIN )
                           MOVE    1             TO  FLG-HIKAKIN
                       END-IF  
                   END-IF
               END-PERFORM
               ADD     1                 TO  CNT-RECE65
      *
               PERFORM 990-RECE65-NEXT-SEC
           END-PERFORM
      *
           .
       2002-TBLZAIW-TAIHI-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療区分（１１）編集処理
      *****************************************************************
       2003-SRYKBN11-HENSYU-SEC    SECTION.
      *
      *    剤　明細テーブルチェック
           INITIALIZE                    TBL-ZAI-AREA
           MOVE    ZERO              TO  WRK-TBLMAX
           MOVE    ZERO              TO  WRK-TENSUGOKEI
           MOVE    ZERO              TO  CNT-ZAITAISYO
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       1  
               PERFORM VARYING IDX2    FROM    1   BY  1
                         UNTIL IDX2    >   WRK-ZAIWMAX (IDX1)  
                   MOVE    IDX1          TO  WRK-WIDX1
                   MOVE    IDX2          TO  WRK-WIDX2
                   PERFORM 20031-SRYKBN11-CHECK-SEC
                   IF  FLG-NOPRT         =   ZERO
      *            レセプト０５剤編集処理
                       PERFORM 430-TBLZAI-HEN-SEC
                   END-IF
               END-PERFORM
           END-PERFORM    
      *
           IF  WRK-TBLMAX           >   ZERO
      *        点数・回数セット処理
               MOVE    WRK-TBLMAX       TO  IDY
               PERFORM 440-TNSKAI-SET-SEC
               MOVE    IDY              TO  WRK-TBLMAX
      *        剤・診療行為テーブル出力処理
               PERFORM 450-RECE66-OUT-SEC
           END-IF
      *
           .
       2003-SRYKBN11-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    明細印字チェック 診療区分（１１） 処理
      *****************************************************************
       20031-SRYKBN11-CHECK-SEC        SECTION.
      * 
           MOVE    ZERO          TO  FLG-NOPRT
      *
      *    服用方法でないこと
           IF  TBL-ZAIW-SRYCD (WRK-WIDX1 WRK-WIDX2)(1:3)   =   "001"
               MOVE    1             TO  FLG-NOPRT
           END-IF
      *
      *    診療行為テーブルに存在した場合、印字しないこと
           PERFORM   VARYING   IDY   FROM    1   BY  1
                     UNTIL   ( IDY           >   TBL-NOSRYCD-MAX )
                     OR      ( FLG-NOPRT     =    1              )
      *
               IF  TBL-ZAIW-SRYCD (WRK-WIDX1 WRK-WIDX2)
                                             =   TBL-NOSRYCD (IDY)
                   MOVE    1                 TO  FLG-NOPRT
      *            ＊初診の場合
                   IF  TBL-NOSRYCD (IDY)     =   "111000110"
                                             OR  "111003610"
                                             OR  "111700110"
                                             OR  "111700210"
                       MOVE    1             TO  FLG-SYOSIN
      *                一つの剤に他の明細も存在する場合
                       IF  RECE64-MEISAISU       >   1
                           MOVE    ZERO          TO  FLG-NOPRT
                       END-IF
                   END-IF
               END-IF
           END-PERFORM
      *
      *    初診加算の時だけ印刷＋検診
           IF      FLG-NOPRT                 =   ZERO
               IF      TBL-ZAIW-SRYCD (WRK-WIDX1 WRK-WIDX2)
                                             =   WRK-CONS-SYOSIN-KASAN1
                                             OR  WRK-CONS-SYOSIN-KASAN2
                                             OR  WRK-CONS-SYOSIN-KASAN3
                                             OR  WRK-CONS-SYOSIN-KASAN4
                                             OR  WRK-CONS-SYOSIN-KASAN5
                                             OR  WRK-CONS-SYOSIN-KASAN6
                                             OR  WRK-CONS-SYOSIN-KASAN7
                                             OR  WRK-CONS-SYOSIN-KASAN8
                                             OR  WRK-CONS-SYOSIN-KASAN9
                                             OR  CONS-COMMENT5         
                                             OR  CONS-COMMENT6         
                                             OR  CONS-COMMENT7         
                                             OR  CONS-COMMENT8         
                   MOVE    TBL-ZAIW-SRYCD (WRK-WIDX1 WRK-WIDX2)
                                             TO  TNS-SRYCD
                   MOVE    TNS-TENSU-REC     TO  MCPDATA-REC
                   MOVE    RECE65-SRYYM      TO  ORC-DBYMD(1:6)
                   MOVE    "01"              TO  ORC-DBYMD(7:2)
                   PERFORM 900-TENSU-INV-SEC
      *            点数・回数セット
                   MOVE    TNS-TEN           TO  WRK-ZAITENX
                   MOVE    RECE64-ZAIKAISU   TO  WRK-ZAIKAISUX
      *            必要有効桁数・開始位置・回数編集
                   PERFORM 810-TENSUKAI-HEN-SEC
               ELSE    
                   MOVE    1                 TO  FLG-NOPRT
               END-IF
           END-IF                                          
      *
      *    識別が点数の場合
           IF  FLG-NOPRT                     =   ZERO
               IF      TBL-ZAIW-TENSIKIBETU (WRK-WIDX1 WRK-WIDX2)
                                             =   3
                   ADD     TBL-ZAIW-TEN (WRK-WIDX1 WRK-WIDX2)
                                             TO  WRK-TENSUGOKEI
               END-IF
           END-IF
      *
           .
       20031-SRYKBN11-CHECK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    レセプト０４ファイル  診療区分（１２）編集処理
      *****************************************************************
       2004-SRYKBN12-HENSYU-SEC    SECTION.
      *
      *    剤　明細テーブルチェック
           INITIALIZE                    TBL-ZAI-AREA
           MOVE    ZERO              TO  WRK-TBLMAX
           MOVE    ZERO              TO  WRK-TENSUGOKEI
           MOVE    ZERO              TO  CNT-ZAITAISYO
           MOVE    ZERO              TO  FLG-KEIKNRKSN
           MOVE    ZERO              TO  FLG-DSAISHIN
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       1  
                   OR     (FLG-KEIKNRKSN   =   1)
                   PERFORM VARYING IDX2    FROM    1   BY  1
                       UNTIL   IDX2    >   WRK-ZAIWMAX (IDX1)  
                       OR      FLG-KEIKNRKSN   =   1           
                   MOVE    IDX1          TO  WRK-WIDX1
                   MOVE    IDX2          TO  WRK-WIDX2
                   PERFORM 20041-SRYKBN12-CHECK-SEC
                   IF  FLG-NOPRT         =   ZERO
      *                レセプト０５剤編集処理
                       PERFORM 430-TBLZAI-HEN-SEC
                   END-IF
               END-PERFORM    
           END-PERFORM
      *
      *
      *    ------------------------
      *     診療区分１２　例外処理
      *    ------------------------
      *****点数が不明だから明細に印字する必要がある
      *****IF  WRK-TBLMAX           =   ZERO
      ***  再診のとき
           IF  ( RECE62-KHNTEN  (2)      =   ZERO )  AND
               ( RECE62-KAISU   (2)      >   ZERO )
                   CONTINUE
      *            PERFORM 20042-SRYKBN12-REIGAI-SEC
      ***  END-IF
           ELSE
      *        継続管理加算のとき
               IF ((FLG-KEIKNRKSN     =   1)  OR
                   (FLG-DSAISHIN      =   1)) AND  
                   (WRK-TBLMAX        >   1) 
                   PERFORM 20042-SRYKBN12-REIGAI-SEC
               END-IF
           END-IF    
      *
           IF  WRK-TBLMAX           >   ZERO
      *        剤明細数と印字対象明細数が異なる場合
               IF  RECE64-MEISAISU   NOT =   CNT-ZAITAISYO
                   PERFORM 400-TENSU-SAIKEISAN-SEC
               END-IF
      *        点数・回数セット処理
               MOVE    WRK-TBLMAX       TO  IDY
               PERFORM 440-TNSKAI-SET-SEC
               MOVE    IDY              TO  WRK-TBLMAX
      *        剤・診療行為テーブル出力処理
               PERFORM 450-RECE66-OUT-SEC
           END-IF
      *
           .
       2004-SRYKBN12-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    明細印字チェック 診療区分（１２） 処理
      *****************************************************************
       20041-SRYKBN12-CHECK-SEC        SECTION.
      * 
           MOVE    ZERO              TO  FLG-NOPRT
      *
      *    服用方法でないこと
           IF  TBL-ZAIW-SRYCD (WRK-WIDX1 WRK-WIDX2)(1:3)
                                     =   "001"
               MOVE    1                 TO  FLG-NOPRT
           END-IF
      *
      *    診療行為テーブルに存在した場合、印字しないこと
           PERFORM   VARYING   IDY   FROM    1   BY  1
                     UNTIL   ( IDY           >   TBL-NOSRYCD-MAX )
                     OR      ( FLG-NOPRT     =    1              )
               IF  TBL-ZAIW-SRYCD (WRK-WIDX1 WRK-WIDX2) 
                                         =   TBL-NOSRYCD (IDY)
                   MOVE    1                 TO  FLG-NOPRT
      *            一つの剤に他の明細も存在する場合
                   IF  RECE64-MEISAISU       >   1
                       MOVE    ZERO          TO  FLG-NOPRT
                   END-IF
      *            ＊再診ダミーの場合
                   IF  TBL-ZAIW-SRYCD (WRK-WIDX1 WRK-WIDX2)           
                                         =   "099120001"              
                       MOVE    1             TO  FLG-NOPRT            
                   END-IF                                             
               END-IF
           END-PERFORM
      *
           IF  FLG-NOPRT             =   ZERO
      *        識別が点数の場合
               IF  TBL-ZAIW-TENSIKIBETU (WRK-WIDX1 WRK-WIDX2)
                                     =   3
                   ADD     TBL-ZAIW-TEN (WRK-WIDX1 WRK-WIDX2)
                                         TO  WRK-TENSUGOKEI
               END-IF
      *        継続管理加算
      *********IF  TBL-ZAIW-SRYCD (WRK-WIDX1 WRK-WIDX2)
      *                                  =   CONS-KEIZOKU    OR
      *                                      CONS-KEIZOKU1 
      *            MOVE    1                 TO  FLG-KEIKNRKSN
      *********END-IF
      *        同日再診（同日電話再診含む）
               IF  TBL-ZAIW-SRYCD (WRK-WIDX1 WRK-WIDX2)
                                         =   CONS-DSAISHIN1  OR
                                             CONS-DSAISHIN2  OR
                                             CONS-DSAISHIN3  OR
                                             CONS-DSAISHIN4
                   MOVE    1                 TO  FLG-DSAISHIN
               END-IF
           END-IF    
      *
           .
       20041-SRYKBN12-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療区分１２　例外処理
      *****************************************************************
       20042-SRYKBN12-REIGAI-SEC        SECTION.
      *
           MOVE    SPACE               TO  WRK-ZAI
           MOVE    "＊"                TO  WRK-ZAI-MK
           INITIALIZE                      TBL-ZAI-AREA
           MOVE    ZERO                TO  WRK-TBLMAX
           MOVE    ZERO                TO  WRK-TENSUGOKEI
           MOVE    ZERO                TO  CNT-ZAITAISYO
      *     
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       5  
               PERFORM VARYING IDX2    FROM    1   BY  1
                       UNTIL   IDX2    >   WRK-ZAIWMAX (IDX1)  
                   MOVE    IDX1          TO  WRK-WIDX1
                   MOVE    IDX2          TO  WRK-WIDX2
      *            外来管理加算以外は印字
                   IF  TBL-ZAIW-SRYCD (IDX1 IDX2)  NOT =   CONS-GAIRAI
      *                レセプト０５剤編集処理
                       PERFORM 430-TBLZAI-HEN-SEC
                       ADD     TBL-ZAIW-TEN (IDX1 IDX2)
                                           TO  WRK-TENSUGOKEI
                   END-IF
               END-PERFORM
           END-PERFORM    
      *
           .
       20042-SRYKBN12-REIGAI-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０４ファイル  診療区分（その他）編集処理
      *****************************************************************
       2005-SRYKBNELSE-HENSYU-SEC    SECTION.
      *    処方のとき
           IF  RECE64-SRYKBN         =   "25"
               IF    ( RECE62-KHNTEN  (19)     =   ZERO )  AND
                     ( WRK-ZAIWMAX    (6)      >   1    )
                   PERFORM 20042-SRYKBNELSE-REIGAI-SEC
               ELSE
                   PERFORM 20052-SRYKBNELSE-CHECK-SEC
               END-IF
           ELSE            
      *
      *        検査のとき剤が一つ以上なら”、”で編集
               IF  RECE64-SRYKBN         =   "60"
      *********AND  WRK-ZAIWMAX (6)      >   1
                   PERFORM 20051-SRYKBNELSE-KENSA-SEC
               ELSE 
                   PERFORM 20052-SRYKBNELSE-CHECK-SEC
               END-IF
           END-IF    
      *
           IF  WRK-TBLMAX           >   ZERO
               IF      RECE64-SRYKBN      >=  "33"
                   CONTINUE
               ELSE        
                   MOVE    WRK-TBLMAX       TO  IDY
                   PERFORM 440-TNSKAI-SET-SEC
                   MOVE    IDY              TO  WRK-TBLMAX
               END-IF    
      *        剤・診療行為テーブル出力処理
               PERFORM 450-RECE66-OUT-SEC
           END-IF
      *
           .
       2005-SRYKBNELSE-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    剤　明細テーブル編集　 診療区分（その他）検査のとき処理
      *****************************************************************
       20051-SRYKBNELSE-KENSA-SEC      SECTION.
      *
           MOVE    WRK-ZAIWMAX (3)     TO  WRK-KENSA-MAX
           MOVE    ZERO                TO  WRK-TNS-HOUKNSKBN
                                           WRK-KOUMOKUSU
      *     
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       WRK-ZAIWMAX (3)
               MOVE    TBL-ZAIW-NAMEINF (3 IDX)  TO  TBL-NAMEINF (IDX)
               MOVE    TBL-ZAIW-SRYSURYO(3 IDX)  TO  TBL-SRYSURYO(IDX)
               MOVE    TBL-ZAIW-TANICD  (3 IDX)  TO  TBL-TANICD  (IDX)
               MOVE    TBL-ZAIW-TANIMOJISU(3 IDX)
                                             TO  TBL-TANIMOJISU(IDX)
               MOVE    TBL-ZAIW-TANINAME(3 IDX)  TO  TBL-TANINAME(IDX)
               MOVE    TBL-ZAIW-SRYCD   (3 IDX)  TO  TBL-SRYCD   (IDX)
               MOVE    TBL-ZAIW-DATAKBN (3 IDX)  TO  TBL-DATAKBN (IDX)
               IF      TBL-YUKOKETA (IDX)      =   ZERO
                   PERFORM VARYING IDZ FROM   200 BY  -1
                           UNTIL   IDZ <      1
                       IF      TBL-NAME (IDX) (IDZ:1)    NOT =   SPACE
                           COMPUTE TBL-YUKOKETA (IDX)    =
                                   IDZ     /   2
                           MOVE    1          TO  IDZ
                       END-IF
                   END-PERFORM
               END-IF             
           END-PERFORM
      ***  MOVE    TBL-ZAIW-SRYCD   (1)  TO  TBL-SRYCD
      *
           COMPUTE WRK-ZAIWMAX (6)   =   WRK-ZAIWMAX  (6)     -   
                                         WRK-ZAIWMAX  (3) 
           INITIALIZE                    TBL-ZAIW-OCC (3)
           MOVE    ZERO              TO  WRK-ZAIWMAX  (3)
      *
      *    剤が一つ以上のとき’、’で名称を編集する
      *
           MOVE    1                 TO  IDX
               
           PERFORM UNTIL   IDX     >       WRK-KENSA-MAX
               MOVE    TBL-SRYCD(IDX)       TO      TNS-SRYCD
               MOVE    TNS-TENSU-REC        TO      MCPDATA-REC
               MOVE    RECE65-SRYYM         TO      ORC-DBYMD(1:6)
               MOVE    "01"                 TO      ORC-DBYMD(7:2)
               PERFORM 900-TENSU-INV-SEC
               IF      TNS-HOUKNSKBN        =   ZERO
                   ADD     1                        TO  WRK-ZAIWMAX (3)
                   MOVE    WRK-ZAIWMAX (3)          TO  IDZ
                   MOVE    TBL-NAMEINF (IDX)   TO
                                    TBL-ZAIW-NAMEINF (3 IDZ)
                   MOVE    TBL-SRYSURYO(IDX)   TO
                                    TBL-ZAIW-SRYSURYO(3 IDZ)
                   MOVE    TBL-TANICD  (IDX)   TO
                                    TBL-ZAIW-TANICD  (3 IDZ)
                   MOVE    TBL-TANIMOJISU(IDX) TO
                                    TBL-ZAIW-TANIMOJISU(3 IDZ)
                   MOVE    TBL-TANINAME(IDX)   TO
                                    TBL-ZAIW-TANINAME(3 IDZ)
                   MOVE    TBL-SRYCD   (IDX)   TO
                                    TBL-ZAIW-SRYCD   (3 IDZ)
                   MOVE    TBL-DATAKBN (IDX)   TO
                                    TBL-ZAIW-DATAKBN (3 IDZ)
                   ADD     1                   TO  IDX                     
               ELSE
                   IF      IDX             =   1
                       MOVE    TNS-HOUKNSKBN    
                                           TO  WRK-TNS-HOUKNSKBN         
                   END-IF                                
                   MOVE    ZERO            TO  WRK-YUKOKETA
                   MOVE    SPACE           TO  WRK-NAME
                   MOVE    TBL-SRYCD (IDX) TO  WRK-SRYCD
                   PERFORM     UNTIL   IDX >       WRK-KENSA-MAX
                               OR      TBL-SRYCD (IDX) (1:1)
                                           NOT =   WRK-SRYCD
      *                次の名称があるとき”、”＋名称をつける
                       IF      WRK-YUKOKETA    >   ZERO
                           STRING  WRK-NAME    DELIMITED  BY  SPACE
                                   "，"        DELIMITED  BY  SIZE
                                   INTO        WRK-NAME
                           END-STRING        
                           ADD     2           TO  WRK-YUKOKETA
      *              
                           COMPUTE IDZ     =   WRK-YUKOKETA        +
                                               TBL-YUKOKETA (IDX)  *  2
                           IF      IDZ             >   38
                               ADD     1               TO
                                                   WRK-ZAIWMAX (3)
                               MOVE    WRK-ZAIWMAX (3) TO  IDZ
                               MOVE    WRK-NAME        TO
                                           TBL-ZAIW-NAME(3 IDZ)
                               COMPUTE TBL-ZAIW-YUKOKETA (3 IDZ) 
                                           =   WRK-YUKOKETA   /   2  
                               MOVE    SPACE           TO  WRK-NAME
                               MOVE    ZERO            TO  WRK-YUKOKETA
                           END-IF
                       END-IF
      *
                       IF      TBL-YUKOKETA (IDX)  >   19
                           ADD     1               TO  WRK-ZAIWMAX (3)
                           MOVE    WRK-ZAIWMAX (3) TO  IDZ
                           MOVE    TBL-NAME (IDX) (1:38)   TO
                                       TBL-ZAIW-NAME    (3 IDZ)
                           MOVE    19                      TO  
                                       TBL-ZAIW-YUKOKETA(3 IDZ)
                           MOVE    TBL-NAME (IDX) (39:)    TO  WRK-NAME
                           COMPUTE WRK-YUKOKETA    =  
                                   ( TBL-YUKOKETA (IDX) -   19 )  *   2                                           
                       ELSE
                           STRING  WRK-NAME        DELIMITED  BY  SPACE
                                   TBL-NAME    (IDX)
                                                   DELIMITED  BY  SPACE
                                   INTO            WRK-NAME
                           END-STRING
                           COMPUTE WRK-YUKOKETA =  WRK-YUKOKETA   +
                                       TBL-YUKOKETA (IDX)  *   2
                       END-IF
      *                 
                       IF      TBL-DATAKBN (IDX)   NOT =   "2"
                           ADD     1           TO  WRK-KOUMOKUSU 
                       END-IF
                       ADD     1           TO  IDX
                   END-PERFORM                            
                   ADD     1               TO  WRK-ZAIWMAX (3)
                   MOVE    WRK-ZAIWMAX (3) TO  IDZ
                   MOVE    WRK-NAME    TO  TBL-ZAIW-NAME (3 IDZ)
                   COMPUTE TBL-ZAIW-YUKOKETA (3 IDZ) 
                                       =   WRK-YUKOKETA   /   2
               END-IF                                        
           END-PERFORM
      *
      *    検査の項目数をコメントにセット
           IF      WRK-TNS-HOUKNSKBN  >   ZERO
               INITIALIZE                 WRK-CHAR-HENKAN-AREA
               MOVE    1                  TO  WRK-CHAR-FLG
               MOVE    WRK-KOUMOKUSU      TO  WRK-Z9
               MOVE    WRK-Z9 (3:2)       TO  WRK-CHAR-X
               MOVE    2                  TO  WRK-CHAR-CNT
               PERFORM 800-NUM-ZENKAKU-HENKAN-SEC
               ADD     1                  TO  WRK-ZAIWMAX (2)
                                              WRK-ZAIWMAX (6)
               MOVE    WRK-ZAIWMAX (2)    TO  IDZ   
               STRING  WRK-CONS-KENSACOMMENT (WRK-TNS-HOUKNSKBN)
                                          DELIMITED  BY  SPACE
                       "（"               DELIMITED  BY  SIZE
                       WRK-CHAR-N         DELIMITED  BY  SPACE
                       "項目）"           DELIMITED  BY  SIZE
                                          INTO    TBL-ZAIW-NAME (2 IDZ)
               PERFORM VARYING IDX FROM   200 BY  -1
                       UNTIL   IDX <      1
                   IF      TBL-ZAIW-NAME (2 IDZ) (IDX:1)
                                              NOT =   SPACE
                       COMPUTE TBL-ZAIW-YUKOKETA (2 IDZ)    =
                                                  IDX     /   2
                       MOVE    1          TO  IDX
                   END-IF
               END-PERFORM
               MOVE    "88888888"         TO  TBL-ZAIW-SRYCD(2 IDZ)
           END-IF                                    
      *
           COMPUTE WRK-ZAIWMAX (6)   =   WRK-ZAIWMAX  (6)     +   
                                         WRK-ZAIWMAX  (3) 
           MOVE    TBL-ZAIW-SRYCD1   TO  TBL-ZAIW-SRYCD (3 1) 
      *
           PERFORM 20052-SRYKBNELSE-CHECK-SEC
           .
       20051-SRYKBNELSE-KENSA-EXT.
           EXIT.
      *****************************************************************
      *    剤　明細テーブルチェック 診療区分（その他） 処理
      *****************************************************************
       20052-SRYKBNELSE-CHECK-SEC      SECTION.
      *
           INITIALIZE                    TBL-ZAI-AREA
           MOVE    ZERO              TO  WRK-TBLMAX
           MOVE    ZERO              TO  WRK-TENSUGOKEI
           MOVE    ZERO              TO  CNT-ZAITAISYO
           MOVE    SPACE             TO  WRK-ZAI
           MOVE    "＊"              TO  WRK-ZAI-MK
      *     
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       5
               IF      RECE64-SRYKBN   <=   "33"
                   MOVE    "＊"            TO  WRK-ZAI-MK
               END-IF    
                   IF   (( RECE64-SRYKBN     =   "31"  AND
                           FLG-HIKAKIN       =   1          )  OR 
                         ( RECE64-SRYKBN     =   "32"       )     )
                   AND  (  IDX1              =   3                )
                       CONTINUE
                   ELSE    
                       IF      RECE64-SRYKBN     =   "31"  AND
                               FLG-HIKAKIN       =   ZERO  AND
                               WRK-ZAIWMAX (3)   >   ZERO  AND
                               IDX1              >   3
                           MOVE    SPACE             TO  WRK-ZAI-MK
                       END-IF            
                       PERFORM VARYING IDX2    FROM    1   BY  1
                               UNTIL   IDX2    >   WRK-ZAIWMAX (IDX1)  
                           MOVE    ZERO          TO  FLG-NOPRT
                           MOVE    IDX1          TO  WRK-WIDX1
                           MOVE    IDX2          TO  WRK-WIDX2
                           PERFORM 200521-SEYKBNELSE-MEISAI-SEC
                           IF  FLG-NOPRT         =   ZERO
      *                        レセプト０５剤編集処理
                               PERFORM 430-TBLZAI-HEN-SEC
                           END-IF    
                       END-PERFORM
                   END-IF    
               IF      WRK-ZAIWMAX (IDX1)    >   ZERO        
                   MOVE    SPACE             TO  WRK-ZAI
               END-IF    
      *             
      *        点数・回数セット処理（診療行為）
               IF      IDX1              =   3
               AND     WRK-ZAIWMAX(IDX1) >   ZERO
                   IF      RECE64-SRYKBN     >=  "33"       
                       MOVE    RECE64-SYUTEN1    TO  WRK-ZAITENX
                       MOVE    RECE64-ZAIKAISU   TO  WRK-ZAIKAISUX
                       PERFORM 810-TENSUKAI-HEN-SEC
                       MOVE    WRK-TBLMAX        TO  IDY
                       PERFORM 440-TNSKAI-SET-SEC
                       MOVE    IDY               TO  WRK-TBLMAX 
                   END-IF
               END-IF    
      *        点数・回数セット処理（特定器材）
               IF      IDX1              =   4
               AND     WRK-ZAIWMAX(IDX1) >   ZERO
                   IF      RECE64-SRYKBN     >=  "33"   
                       MOVE    RECE64-KIZAITEN   TO  WRK-ZAITENX
                       MOVE    RECE64-ZAIKAISU   TO  WRK-ZAIKAISUX
                       PERFORM 810-TENSUKAI-HEN-SEC
                       MOVE    WRK-TBLMAX        TO  IDY
                       PERFORM 440-TNSKAI-SET-SEC
                       MOVE    IDY               TO  WRK-TBLMAX 
                   END-IF
               END-IF     
      *        点数・回数セット処理（薬剤）
               IF      IDX1              =   5
               AND     WRK-ZAIWMAX(IDX1) >   ZERO
                   IF      RECE64-SRYKBN     >=  "31"   
      *****************IF      RECE64-SRYKBN     =   "31"    OR  
      **                                             "32"    OR  "33"  
      **               AND     RECE64-YKZTEN     <=  20
      **                   ADD     1                 TO  WRK-TBLMAX
      **                   MOVE    "＊"              TO
      **                               TBL-ZAI (WRK-TBLMAX)(1:2)
      *****************END-IF     
      *                点数・回数セット
                       IF      RECE64-SRYKBN     >=   "33"
                           MOVE    RECE64-YKZTEN     TO  WRK-ZAITENX
                           MOVE    RECE64-ZAIKAISU   TO  WRK-ZAIKAISUX
                           PERFORM 810-TENSUKAI-HEN-SEC
                           MOVE    WRK-TBLMAX        TO  IDY
                           PERFORM 440-TNSKAI-SET-SEC
                           MOVE    IDY               TO  WRK-TBLMAX 
                       END-IF          
                   END-IF
               END-IF        
           END-PERFORM
      *             
      *    検査のとき回数を集計
           IF      WRK-ZAIWMAX(3)     >   ZERO
           AND     RECE64-SRYKBN      =   "60"
               IF      TBL-ZAIW-SRYCD (3 1)   =   WRK-CONS-SAIKETSU1
                                              OR  WRK-CONS-SAIKETSU2
                                              OR  WRK-CONS-SAIKETSU3 
                   CONTINUE
               ELSE
                   MOVE    TBL-ZAIW-SRYCD (3 1)
                                             TO  TNS-SRYCD
                   MOVE    TNS-TENSU-REC     TO  MCPDATA-REC
                   MOVE    RECE65-SRYYM      TO  ORC-DBYMD(1:6)
                   MOVE    "01"              TO  ORC-DBYMD(7:2)
                   PERFORM 900-TENSU-INV-SEC
                   IF      TNS-KNSJISKBN     =   "2"
                       CONTINUE
                   ELSE 
                       ADD     RECE64-ZAIKAISU   TO  WRK-KENSA-KAISU
                   END-IF
               END-IF
           END-IF     
      *
           .
       20052-SRYKBNELSE-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    明細印字チェック 診療区分（その他） 処理
      *****************************************************************
       200521-SEYKBNELSE-MEISAI-SEC        SECTION.
      *
           MOVE    ZERO          TO  FLG-NOPRT
      *
      *    服用方法でないこと
           IF  TBL-ZAIW-SRYCD (WRK-WIDX1 WRK-WIDX2)(1:3)
                                 =   "001"
               MOVE    1             TO  FLG-NOPRT
           END-IF
      *    診療行為テーブルに存在した場合、印字しないこと
           PERFORM   VARYING   IDY   FROM    1   BY  1
                     UNTIL   ( IDY           >   TBL-NOSRYCD-MAX )
                     OR      ( FLG-NOPRT     =    1 )
      *
               IF  TBL-ZAIW-SRYCD (WRK-WIDX1 WRK-WIDX2)
                                =   TBL-NOSRYCD (IDY)
                   MOVE    1                 TO  FLG-NOPRT
               END-IF
           END-PERFORM
      *
           .
       200521-SEYKBNELSE-MEISAI-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療区分（その他）　例外処理
      *****************************************************************
       20042-SRYKBNELSE-REIGAI-SEC        SECTION.
      *
           MOVE    SPACE               TO  WRK-ZAI
           MOVE    "＊"                TO  WRK-ZAI-MK
           INITIALIZE                    TBL-ZAI-AREA
           MOVE    ZERO              TO  WRK-TBLMAX
           MOVE    ZERO              TO  WRK-TENSUGOKEI
           MOVE    ZERO              TO  CNT-ZAITAISYO
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       5  
               PERFORM VARYING IDX2    FROM    1   BY  1
                       UNTIL   IDX2    >   WRK-ZAIWMAX (IDX1)  
                   MOVE    IDX1          TO  WRK-WIDX1
                   MOVE    IDX2          TO  WRK-WIDX2
      *            レセプト０５剤編集処理
                   PERFORM 430-TBLZAI-HEN-SEC
                   ADD     TBL-ZAIW-TEN (IDX IDX1) TO  WRK-TENSUGOKEI
               END-PERFORM    
           END-PERFORM
      *
           .
       20042-SRYKBNELSE-REIGAI-EXT.
           EXIT.
      *
      *****************************************************************
      *    検査チェック処理
      *****************************************************************
       2006-SRYKBN60-CHECK-SEC         SECTION.
      *
      *    薬剤やコメントがあればまとめない
           IF      FLG-SRYCD1          =   1
               PERFORM 2005-SRYKBNELSE-HENSYU-SEC
           ELSE
      *
      *        包括対象でないときまとめない         
               MOVE    TBL-ZAIW-SRYCD (3 1) TO      TNS-SRYCD
               MOVE    TNS-TENSU-REC        TO      MCPDATA-REC
               MOVE    RECE64-SRYYM         TO      ORC-DBYMD(1:6)
               MOVE    "01"                 TO      ORC-DBYMD(7:2)
               PERFORM 900-TENSU-INV-SEC
               IF      TNS-HOUKNSKBN        =   ZERO
                   PERFORM 2005-SRYKBNELSE-HENSYU-SEC
               ELSE    
                   PERFORM 2006-SRYKBN60-TAIHI-SEC
               END-IF
           END-IF        
           .
       2006-SRYKBN60-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    検査まとめ対象待避処理
      *****************************************************************
       2006-SRYKBN60-TAIHI-SEC         SECTION.
      *
           ADD     1               TO  WRK-RECE64-MAX
           MOVE    RECE64-REC      TO  WRK-RECE64-REC (WRK-RECE64-MAX)
           MOVE    RECE64-DAY-AREA TO  WRK-RECE64-DAY-AREA
                                                      (WRK-RECE64-MAX)
           MOVE    TNS-HOUKNSKBN   TO  WRK-RECE64-HOUKNSKBN
                                                      (WRK-RECE64-MAX)
           MOVE    RECE64-KOHBUNRI TO  WRK-RECE64-KOHBUNRI
                                                      (WRK-RECE64-MAX)
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       31
               ADD      RECE64-KAISU (1 IDX)    TO  WRK-SUM-KAISU (IDX)
           END-PERFORM                                                       
           .
       2006-SRYKBN60-TAIHI-EXT.
           EXIT.
      *
      *****************************************************************
      *    検査まとめ処理
      *****************************************************************
       2007-SRYKBN60-HENSYU-SEC         SECTION.
      *     
      *    検査のまとめ処理
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       31
               INITIALIZE                  WRK-RECE64-FLG-TABLE
                                           WRK-KAISU-G
                                           WRK-HOUKNSKBN
                                           WRK-KOHBUNRI
      *
               IF      WRK-SUM-KAISU (IDX)   >   ZERO
                   PERFORM VARYING IDY FROM    1   BY  1
                           UNTIL   IDY >       WRK-RECE64-MAX
                       IF      WRK-RECE64-KAISU (IDY 1 IDX)    
                                               >   ZERO
                           IF      WRK-KAISU (1)   =   ZERO
                               MOVE    WRK-RECE64-KAISU (IDY 1 IDX)
                                                   TO  WRK-KAISU (1)
                               MOVE    WRK-RECE64-KAISU (IDY 2 IDX)
                                                   TO  WRK-KAISU (2)
                               MOVE    WRK-RECE64-KAISU (IDY 3 IDX)
                                                   TO  WRK-KAISU (3)
                               MOVE    WRK-RECE64-KAISU (IDY 4 IDX)
                                                   TO  WRK-KAISU (4)
                               MOVE    WRK-RECE64-HOUKNSKBN (IDY)
                                                   TO  WRK-HOUKNSKBN                    
                               MOVE    WRK-RECE64-KOHBUNRI (IDY)
                                                   TO  WRK-KOHBUNRI                  
                           END-IF
                           IF      WRK-RECE64-KAISU (IDY 2 IDX)
                                                   =   WRK-KAISU (2)
                           AND     WRK-RECE64-KAISU (IDY 3 IDX)
                                                   =   WRK-KAISU (3)
                           AND     WRK-RECE64-KAISU (IDY 4 IDX)
                                                   =   WRK-KAISU (4)
                           AND     WRK-RECE64-HOUKNSKBN (IDY)
                                                   =   WRK-HOUKNSKBN
                           AND     WRK-RECE64-KOHBUNRI  (IDY)
                                                   =   WRK-KOHBUNRI
                               MOVE    ZERO        TO
                                           WRK-RECE64-KAISU (IDY 1 IDX)
                               COMPUTE WRK-SUM-KAISU (IDX) 
                                                   =
                                                   WRK-SUM-KAISU (IDX) - 
                                                   WRK-KAISU   (1)                                       
                               MOVE    "1"         TO  WRK-RECE64-FLG 
                                                       (IDY)
                           END-IF
                       END-IF
                   END-PERFORM
                   IF      WRK-KAISU (1)      >   ZERO
                       ADD     1                  TO  WRK-KAISU1
                   END-IF
      *
      *            同じ検査が月に何日あるか
                   COMPUTE IDX1    =   IDX     +   1
                   PERFORM VARYING IDZ FROM    IDX1    BY  1
                           UNTIL   IDZ >       31
                       MOVE    ZERO                TO  FLG-OK                            
                       PERFORM VARYING IDW FROM    1   BY  1
                               UNTIL   IDW >       WRK-RECE64-MAX
                               OR      FLG-OK      =   1
                           IF      WRK-RECE64-FLG   (IDW)  =   "1"
                               IF      WRK-RECE64-KAISU (IDW 2 IDZ)
                                                   =   WRK-KAISU (2)
                               AND     WRK-RECE64-KAISU (IDW 3 IDZ)
                                                   =   WRK-KAISU (3)
                               AND     WRK-RECE64-KAISU (IDW 4 IDZ)
                                                   =   WRK-KAISU (4)                  
                                   MOVE    2               TO  FLG-OK                                    
                               ELSE                    
                                   MOVE    1               TO  FLG-OK                                    
                               END-IF
                           END-IF
                       END-PERFORM
      *                同じ検査が同じ回数で全てあるとき                 
                       IF      FLG-OK          =   2
                           PERFORM VARYING IDW FROM    1   BY  1
                                   UNTIL   IDW >       WRK-RECE64-MAX
                               IF      WRK-RECE64-FLG   (IDW)  =   "1"
                                   MOVE    ZERO    TO  WRK-RECE64-KAISU
                                                      (IDW 1 IDZ)
                                   COMPUTE WRK-SUM-KAISU (IDZ) 
                                                   =
                                                   WRK-SUM-KAISU (IDZ) - 
                                                   WRK-KAISU   (1)                                       
                               END-IF
                           END-PERFORM
                           ADD     1              TO  WRK-KAISU1                                                               
                       END-IF  
                   END-PERFORM
      *
      *            同じ検査をまとめて出力する
                   MOVE    ZERO                  TO  FLG-SRYCD1
      *
                   INITIALIZE                      TBL-ZAIW-AREA
                   MOVE    ZERO                TO  WRK-ZAIWMAX-G
                   MOVE    ZERO                TO  WRK-TBLMAX
                   MOVE    ZERO                TO  WRK-TENSUGOKEI
                   MOVE    ZERO                TO  FLG-SYOSIN
      *****        MOVE    RECE64-SRYKBN       TO  WRK-SRYKBN
                   MOVE    ZERO                TO  FLG-TEIGEN
                                                   FLG-COMMENT
                                                   FLG-COMMENT2
                                                   FLG-HIKAKIN 
                   MOVE    ZERO                TO  WRK-RECE65
                                                   IDY
                   MOVE    SPACE               TO  WRK-SRYSYUKBN
      *                                             
                   MOVE    SPACE               TO  RECE64-REC
                   INITIALIZE                      RECE64-REC
                   MOVE    ZERO                TO  WRK-RECE64-ZAITEN
                   PERFORM VARYING IDW FROM    1   BY  1
                           UNTIL   IDW >       WRK-RECE64-MAX
                       IF      WRK-RECE64-FLG   (IDW)  =   "1"
                           MOVE    WRK-RECE64-REC    (IDW) 
                                               TO  RECE64-REC
                           ADD     RECE64-ZAITEN 
                                               TO  WRK-RECE64-ZAITEN
                           PERFORM 2002-TBLZAIW-TAIHI-SEC
                       END-IF
                   END-PERFORM    
                   COMPUTE RECE64-ZAIKAISU     =
                               WRK-KAISU (1)   *   WRK-KAISU1                
                   MOVE    WRK-RECE64-ZAITEN       TO  RECE64-SYUTEN1
                                                       RECE64-ZAITEN                                                        
      *
      *            レセプト０４剤編集前処理
                   PERFORM 2001-RECE64-ZAIHEN-MAE-SEC
      *
                   IF      SPA-STS          =   ZERO
                       PERFORM 20051-SRYKBNELSE-KENSA-SEC
      *                剤・診療行為テーブル出力処理
                       PERFORM 450-RECE66-OUT-SEC
                   END-IF    
               END-IF
           END-PERFORM                        
           .
       2007-SRYKBN60-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数再計算処理
      *****************************************************************
       400-TENSU-SAIKEISAN-SEC    SECTION.
      *
           MOVE    SPACE               TO  WRK-ZAI
           MOVE    "＊"                TO  WRK-ZAI-MK
      *    点数・回数セット
           MOVE    WRK-TENSUGOKEI      TO  WRK-ZAITENX
           MOVE    RECE64-ZAIKAISU     TO  WRK-ZAIKAISUX
      *    必要有効桁数・開始位置・回数編集
           PERFORM 810-TENSUKAI-HEN-SEC
      *
           .
       400-TENSU-SAIKEISAN-EXT.
           EXIT.
      *
      *****************************************************************
      *    明細空白処理
      *****************************************************************
       410-MEISAI-SPACE-SEC   SECTION.
      *
           PERFORM   VARYING   IDY   FROM    1   BY  1
                     UNTIL     IDY   >       WRK-TBLMAX
               IF  IDY                   =   1
                   MOVE    SPACE         TO  TBL-ZAI (IDY)(3:)
               ELSE
                   INITIALIZE                TBL-ZAI (IDY)
               END-IF
           END-PERFORM
           MOVE    1                 TO  WRK-TBLMAX
      *
           .
       410-MEISAI-SPACE-EXT.
           EXIT.
      *****************************************************************
      *    剤テーブル編集処理
      *****************************************************************
       430-TBLZAI-HEN-SEC     SECTION.
      *
      *    数量編集
           PERFORM 4301-SURYO-HEN1-SEC
      *
      *    分画数編集
           PERFORM 4301-BUNKAKU-HEN1-SEC
      *
      *    明細編集・明細桁数計算
           PERFORM 4302-MEISAI-KETA-HEN1-SEC
      *
      *    剤・診療行為テーブル編集処理
           PERFORM 4303-ZAITBL-TENSO-SEC
      *    
      *    明細が１行に収まりきらない場合
           IF  WRK-WCLM            >   50
               MOVE    SPACE             TO  WRK-ZAI-NAME
               MOVE    WRK-KOUI (51:)    TO  WRK-ZAI-NAME
               PERFORM 4303-ZAITBL-TENSO-SEC
           END-IF
      *
           ADD     1               TO  CNT-ZAITAISYO
      *
           .
       430-TBLZAI-HEN-EXT.
           EXIT.
      *     
      *****************************************************************
      *    数量編集処理
      *****************************************************************
       4301-SURYO-HEN1-SEC        SECTION.
      *
           MOVE    SPACE           TO  WRK-SURYO-X
           MOVE    ZERO            TO  WRK-SURYOST
           MOVE    ZERO            TO  WRK-SURYOKETA
           MOVE    ZERO            TO  WRK-SURYOKETA1
           MOVE    ZERO            TO  WRK-SURYOKETA2
           MOVE    SPACE           TO  WRK-SURYO-N
           MOVE    SPACE           TO  WRK-SRYSURYOW
      *
           IF      TBL-ZAIW-SRYSURYO (WRK-WIDX1 WRK-WIDX2)
                                   =   ZERO
               GO  TO  4301-SURYO-HEN1-EXT  
           END-IF
      * 
      *    数字表示用編集（半角）
           MOVE    TBL-ZAIW-SRYSURYO (WRK-WIDX1 WRK-WIDX2)
                                   TO  WRK-SURYO
           MOVE    WRK-SURYO-S1    TO  WRK-SURYO-Z1
           MOVE    ZERO            TO  FLG-SP
           PERFORM   VARYING   IDY   FROM    3   BY  -1
                     UNTIL     IDY           =   ZERO
             IF  WRK-SURYO-S2(IDY:1) NOT =   ZERO
                 MOVE    1               TO  FLG-SP
             END-IF
             IF  FLG-SP                  =   1
                 MOVE    WRK-SURYO-S2(IDY:1)
                                         TO  WRK-SURYO-Z3(IDY:1)
             END-IF
           END-PERFORM
           IF  WRK-SURYO-Z3          NOT =   SPACE
               MOVE    "."               TO  WRK-SURYO-Z2
           END-IF
      *    表示文字数カウント
           PERFORM   VARYING   IDY   FROM    1   BY  1
                     UNTIL     IDY           >   9
             IF  WRK-SURYO-X (IDY:1)   NOT =   SPACE
                 IF  WRK-SURYOST           =   ZERO
                     MOVE    IDY           TO  WRK-SURYOST
                 END-IF
      *          数量桁数カウント(６桁目：ピリオド)
                 ADD     1                 TO  WRK-SURYOKETA
                 IF  IDY                   <   6
                     ADD     1             TO  WRK-SURYOKETA1
                 END-IF
                 IF  IDY                   >   6
                     ADD     1             TO  WRK-SURYOKETA2
                 END-IF
             END-IF
           END-PERFORM
           IF  WRK-SURYOST             =   6
               MOVE    "0"             TO  WRK-SURYO-Z1(5:1)
               MOVE    5               TO  WRK-SURYOST
               MOVE    1               TO  WRK-SURYOKETA1
               ADD     1               TO  WRK-SURYOKETA
           END-IF
      *    全角変換
           IF  WRK-SURYOKETA1          >   ZERO
               INITIALIZE              WRK-CHAR-HENKAN-AREA
               MOVE    WRK-SURYO-Z1 (WRK-SURYOST:WRK-SURYOKETA1)
                                       TO  WRK-CHAR-X
               MOVE    WRK-SURYOKETA1  TO  WRK-CHAR-CNT
               PERFORM 800-NUM-ZENKAKU-HENKAN-SEC
               MOVE    WRK-CHAR-N      TO  WRK-SURYO-N1
           END-IF
           IF  WRK-SURYOKETA2          >   ZERO
               MOVE    "．"            TO  WRK-SURYO-N2
               INITIALIZE              WRK-CHAR-HENKAN-AREA
               MOVE    WRK-SURYO-Z3 (1:WRK-SURYOKETA2)
                                       TO  WRK-CHAR-X
               MOVE    WRK-SURYOKETA2  TO  WRK-CHAR-CNT
               PERFORM 800-NUM-ZENKAKU-HENKAN-SEC
               MOVE    WRK-CHAR-N      TO  WRK-SURYO-N3
           END-IF
           STRING      WRK-SURYO-N1    DELIMITED   BY  " "
                       WRK-SURYO-N2    DELIMITED   BY  " "
                       WRK-SURYO-N3    DELIMITED   BY  " "
                       INTO            WRK-SRYSURYOW
           END-STRING
      *
           .
       4301-SURYO-HEN1-EXT.
           EXIT.
      *     
      *****************************************************************
      *    分画数編集処理
      *****************************************************************
       4301-BUNKAKU-HEN1-SEC        SECTION.
      *
           MOVE    ZERO            TO  WRK-BUNKAKUKETA
           MOVE    SPACE           TO  WRK-BUNKAKU-N
      *
           IF      TBL-ZAIW-SRYCD (WRK-WIDX1 WRK-WIDX2) (1:1)
                                   =   "7"
           AND     TBL-ZAIW-TANICD(WRK-WIDX1 WRK-WIDX2)
                                   =   WRK-CONS-TANICD 
           AND     TBL-ZAIW-SRYKAISU(WRK-WIDX1 WRK-WIDX2)
                                   >   1
               CONTINUE
           ELSE                            
               GO  TO  4301-BUNKAKU-HEN1-EXT  
           END-IF
      * 
      *    表示用編集（半角）
           MOVE    TBL-ZAIW-SRYKAISU (WRK-WIDX1 WRK-WIDX2)
                                   TO  WRK-SRYKAISU-X
      *    全角変換
           INITIALIZE              WRK-CHAR-HENKAN-AREA
           MOVE    WRK-SRYKAISU-X  TO  WRK-CHAR-X
           MOVE    3               TO  WRK-CHAR-CNT
           MOVE    1               TO  WRK-CHAR-FLG
           PERFORM 800-NUM-ZENKAKU-HENKAN-SEC
           STRING  WRK-CHAR-N      DELIMITED BY  SPACE
                   "分画"          DELIMITED  BY  SIZE
                                   INTO  WRK-BUNKAKU-N
           COMPUTE WRK-BUNKAKUKETA =   WRK-CHAR-N-CNT  +  4
      *
           .
       4301-BUNKAKU-HEN1-EXT.
           EXIT.
      *
      *****************************************************************
      *    明細・明細桁　編集処理
      *****************************************************************
       4302-MEISAI-KETA-HEN1-SEC    SECTION.
      *
           MOVE    SPACE           TO  WRK-KOUI
      *
           IF  TBL-ZAIW-TANINAME (WRK-WIDX1 WRK-WIDX2)
                                   =   SPACE
      *        < 名称 >
               MOVE    TBL-ZAIW-NAME (WRK-WIDX1 WRK-WIDX2)
                                   TO  WRK-KOUI
      *        < 名称*2 >
               COMPUTE WRK-WCLM  =
                       TBL-ZAIW-YUKOKETA (WRK-WIDX1 WRK-WIDX2) *  2
           ELSE
      *        名称の長さ
               COMPUTE   WRK-NAMEKETA  =
                         TBL-ZAIW-YUKOKETA (WRK-WIDX1 WRK-WIDX2)
                         *   2
      *        -----------------------------------
      *        １明細に数量単位まで収まるかどうか
      *        -----------------------------------
               EVALUATE    TRUE
               WHEN    WRK-NAMEKETA    >   50
      *            明細行
                   MOVE    TBL-ZAIW-NAME (WRK-WIDX1 WRK-WIDX2)
                                       TO  WRK-KOUI
                   MOVE    WRK-KOUI    TO  WRK-ZAI-NAME
                   PERFORM 4303-ZAITBL-TENSO-SEC
      *
                   MOVE    SPACE       TO  WRK-KOUI
                   MOVE    SPACE       TO  WRK-ZAI-NAME
                   COMPUTE WRK-NAMEKETA    =   WRK-NAMEKETA  -  50
      *   　       < 名称後半 + 空白 + 数量 + 単位 + 分画数>
                   STRING  TBL-ZAIW-NAME     (WRK-WIDX1 WRK-WIDX2)(51:)
                                              DELIMITED  BY  " "
                           "  "               DELIMITED  BY  SIZE
                           WRK-SRYSURYOW      DELIMITED  BY  " "
                           TBL-ZAIW-TANINAME (WRK-WIDX1 WRK-WIDX2)
                                              DELIMITED  BY  " "
                           "  "               DELIMITED  BY  SIZE
                           WRK-BUNKAKU-N      DELIMITED  BY  " "
                           INTO               WRK-KOUI
                   END-STRING
                   COMPUTE   WRK-WCLM
                         =   ( WRK-SURYOKETA                  *   2 )
                         +   ( TBL-ZAIW-TANIMOJISU (WRK-WIDX1 WRK-WIDX2)
                                                              *   2 )
                         +   WRK-NAMEKETA  +  2
                   IF      WRK-BUNKAKUKETA        >   ZERO
                       COMPUTE   WRK-WCLM    =   WRK-WCLM         +
                                                 WRK-BUNKAKUKETA  +
                                                 2
                   END-IF                                             
      *
               WHEN    WRK-NAMEKETA    =   50
      *            数量・単位　次行印字処理
                   PERFORM 43021-SURYO-NEXTPRT-SEC
      *
               WHEN    WRK-NAMEKETA    <   50
      *            間の空白分を足し込む
                   COMPUTE   WRK-NAMEKETA  =   WRK-NAMEKETA   +   2
                   IF  WRK-NAMEKETA    <   50
      *                余白
                       COMPUTE   WRK-YOHAKU  =   50  -   WRK-NAMEKETA
      *                数量・分画数桁数
                       COMPUTE   WRK-WKETA   =
                         ( WRK-SURYOKETA                  * 2 )
                             +
                         ( TBL-ZAIW-TANIMOJISU (WRK-WIDX1 WRK-WIDX2)
                                                          * 2 )
                       IF      WRK-BUNKAKUKETA   >   ZERO
                           COMPUTE   WRK-WKETA   =   WRK-WKETA        +
                                                     WRK-BUNKAKUKETA  +
                                                     2
                       END-IF                                             
      *
                       IF  WRK-YOHAKU        >=  WRK-WKETA
      *                    < 名称 + 空白 + 数量 + 単位 + 空白 + 分画数>
                          STRING  TBL-ZAIW-NAME (WRK-WIDX1 WRK-WIDX2)
                                                (1:WRK-NAMEKETA)
                                                  DELIMITED  BY  SIZE
                                   WRK-SRYSURYOW  DELIMITED  BY  " "
                                   TBL-ZAIW-TANINAME
                                                 (WRK-WIDX1 WRK-WIDX2)
                                                  DELIMITED  BY  " "
                                   "  "           DELIMITED  BY  SIZE
                                   WRK-BUNKAKU-N  DELIMITED  BY  " "
                                   INTO           WRK-KOUI
                           END-STRING
      *                    < 名称*2 + 空白*2 + 数量 + 単位*2 + 空白 + 分画数>
                           COMPUTE   WRK-WCLM     =
                               ( TBL-ZAIW-YUKOKETA 
                                         (WRK-WIDX1 WRK-WIDX2)  * 2 )
                             + ( WRK-SURYOKETA                  * 2 )
                             + ( TBL-ZAIW-TANIMOJISU 
                                         (WRK-WIDX1 WRK-WIDX2)  * 2 )
                             +  2
                           IF      WRK-BUNKAKUKETA   >   ZERO
                               COMPUTE   WRK-WCLM   =   WRK-WCLM      +
                                                     WRK-BUNKAKUKETA  +
                                                     2
                           END-IF                                             
                       ELSE
      *                    数量・単位　次行印字処理
                           PERFORM 43021-SURYO-NEXTPRT-SEC
                       END-IF
                   ELSE
      *                数量・単位　次行印字処理
                       PERFORM 43021-SURYO-NEXTPRT-SEC
                   END-IF
               END-EVALUATE
           END-IF
           MOVE    WRK-KOUI        TO  WRK-ZAI-NAME
      *
           .
       4302-MEISAI-KETA-HEN1-EXT.
           EXIT.
      *
      *****************************************************************
      *    数量・単位　次行編集処理
      *****************************************************************
       43021-SURYO-NEXTPRT-SEC    SECTION.
      *
      *    < 名称 >
           MOVE    TBL-ZAIW-NAME (WRK-WIDX1 WRK-WIDX2)
                                      TO  WRK-KOUI
           MOVE    WRK-KOUI           TO  WRK-ZAI-NAME
           PERFORM 4303-ZAITBL-TENSO-SEC
      *
           MOVE    SPACE              TO  WRK-KOUI
           MOVE    SPACE              TO  WRK-ZAI-NAME
      *    < 空白 + 数量 + 単位 + 空白 + 分画数>
           STRING  "    "             DELIMITED  BY  SIZE
                   WRK-SRYSURYOW      DELIMITED  BY  " "
                   TBL-ZAIW-TANINAME (WRK-WIDX1 WRK-WIDX2)
                                      DELIMITED  BY  " "
                   "  "               DELIMITED  BY  SIZE
                   WRK-BUNKAKU-N      DELIMITED  BY  " "
                   INTO               WRK-KOUI
           END-STRING
           COMPUTE   WRK-WCLM
                 =   ( WRK-SURYOKETA                  *   2 )
                 +   ( TBL-ZAIW-TANIMOJISU (WRK-WIDX1 WRK-WIDX2)
                                                      *   2 )
                 +   4
           IF      WRK-BUNKAKUKETA   >   ZERO
               COMPUTE   WRK-WCLM   =   WRK-WCLM         +
                                        WRK-BUNKAKUKETA  +
                                        2
           END-IF                                             
      *
           .
       43021-SURYO-NEXTPRT-EXT.
           EXIT.
      *
      *****************************************************************
      *    剤・診療行為テーブル編集処理
      *****************************************************************
       4303-ZAITBL-TENSO-SEC    SECTION.
      *
           ADD     1                 TO  WRK-TBLMAX
           IF  WRK-TBLMAX           >   100
               DISPLAY "*** ORCR0690 TBL-ZAI INDEX[100] OVER  ***"
      *         ACCEPT   WRK-IN       FROM    CONSOLE
           END-IF
           MOVE    WRK-ZAI           TO  TBL-ZAI (WRK-TBLMAX)
           MOVE    IDX1              TO  TBL-ZAI-IDX(WRK-TBLMAX)
           MOVE    SPACE             TO  WRK-ZAI
      *
           .
       4303-ZAITBL-TENSO-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数回数セット処理
      *****************************************************************
       440-TNSKAI-SET-SEC          SECTION.
      *
      *---- (01.00.05) LINE ADD START --------------------------------
           IF     (FLG-COMMENT        =   1)     AND
                  (RECE64-SRYKBN      =   "99")
               GO  TO  440-TNSKAI-SET-EXT
           END-IF
           IF     (FLG-COMMENT2       =   1)                           
               GO  TO  440-TNSKAI-SET-EXT                              
           END-IF                                                      
      *---- (01.00.05) LINE ADD END   --------------------------------
      *         
           MOVE    WRK-TNSKAI-ST     TO  IDA
           COMPUTE   IDA             =   IDA     -   2
           MOVE    WRK-TNSKAI-KETA   TO  IDB
      *****MOVE    WRK-TBLMAX       TO  IDY
      *
      *    最終明細に点数・回数を印字するスペース有り
           MOVE    TBL-ZAI (IDY)(3:)     TO  WRK-ZAI-NAME
           IF  WRK-ZAI-NAME (IDA:)       =   SPACE
               COMPUTE   WRK-TNSKAI-ST   =   22
                                         -   WRK-TNSKAI-KETA
               ADD     1                 TO  WRK-TNSKAI-ST
               MOVE    WRK-TNSKAI (WRK-TNSKAI-ST:IDB)
                                         TO  WRK-ZAI-TNSKAI
                                                    (WRK-TNSKAI-ST:)
               MOVE    WRK-ZAI-NAME      TO  TBL-ZAI (IDY)(3:)
           ELSE
      *    最終明細に点数・回数を印字するスペース無し
               ADD     1                 TO  IDY
               IF  IDY                   >   100
                   DISPLAY "*** ORCR0690 TBL-ZAI INDEX[100] OVER  ***"
      *             ACCEPT   WRK-IN       FROM    CONSOLE
               END-IF
               MOVE    SPACE             TO  WRK-ZAI
               MOVE    WRK-TNSKAI        TO  WRK-ZAI-TNSKAI
               MOVE    WRK-ZAI           TO  TBL-ZAI (IDY)
               MOVE    IDX1              TO  TBL-ZAI-IDX(IDY)
               MOVE    SPACE             TO  WRK-ZAI
           END-IF
      *
           .
       440-TNSKAI-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０６出力処理
      *****************************************************************
       450-RECE66-OUT-SEC    SECTION.
      *
           PERFORM   VARYING   IDY   FROM    1   BY  1
                     UNTIL     IDY   >   WRK-TBLMAX
      *
               ADD     1                 TO  WRK-LINENUM
               MOVE    SPACE             TO  RECE66-REC
               INITIALIZE                    RECE66-REC
               MOVE    RECE62-KEY        TO  RECE66-KEY
               MOVE    RECE64-KOHBUNRI   TO  RECE66-KOHBUNRI
               MOVE    RECE64-ZAINUM     TO  RECE66-ZAINUM
               MOVE    WRK-LINENUM       TO  RECE66-LINENUM
               MOVE    WRK-TBLMAX       TO  RECE66-ZAIMEISAISU
               MOVE    RECE64-PTNUM      TO  RECE66-PTNUM
               MOVE    RECE64-SRYKA      TO  RECE66-SRYKA
               MOVE    RECE64-SRYKBN     TO  RECE66-SRYKBN
               MOVE    RECE64-ZAISKBKBN  TO  RECE66-ZAISKBKBN
               IF    RECE64-ZAISKBKBN  =   "1" OR "2" OR "4"
                   MOVE   RECE64-ZAINUM  TO  RECE66-ZAISKBBAN
               END-IF
               MOVE    TBL-ZAI (IDY)     TO  RECE66-TEKIYO-INF
      *
               IF      RECE64-SRYKBN      =  "33"
                  IF   WRK-SRYSYUKBN      =  "330" OR "331"
                     EVALUATE  TBL-ZAI-IDX(IDY)
                       WHEN   1
                         MOVE   7        TO  RECE66-TENTEKIKBN
                       WHEN   2
                         MOVE   9        TO  RECE66-TENTEKIKBN
                       WHEN   3
                         MOVE   1        TO  RECE66-TENTEKIKBN
                       WHEN   4
                         MOVE   5        TO  RECE66-TENTEKIKBN
                       WHEN   5
                         MOVE   3        TO  RECE66-TENTEKIKBN
                     END-EVALUATE
                     MOVE   RECE64-ZAINUM  TO  RECE66-TENTEKIBAN
                  END-IF
                  IF   WRK-SRYSYUKBN      =  "340"
                     EVALUATE  TBL-ZAI-IDX(IDY)
                       WHEN   1
                         MOVE   8        TO  RECE66-TENTEKIKBN
                       WHEN   2
                         MOVE  10        TO  RECE66-TENTEKIKBN
                       WHEN   3
                         MOVE   2        TO  RECE66-TENTEKIKBN
                       WHEN   4
                         MOVE   6        TO  RECE66-TENTEKIKBN
                       WHEN   5
                         MOVE   4        TO  RECE66-TENTEKIKBN
                     END-EVALUATE
                     MOVE   RECE64-ZAINUM  TO  RECE66-TENTEKIBAN
                  END-IF
               END-IF
      *
      *---------適用欄並び替え用の編集（表用番号等）-----------------
               IF      IDY               =   1
      *
                 INITIALIZE                           TNS-TENSU-REC
                 IF        TBL-ZAIW-SRYCD1(1:1)  =   "6"  OR  "7"
                     MOVE    ALL "9"            TO
                                            TNS-CDKBN-KBN
                                            TNS-CDKBN-SYO 
                                            TNS-CDKBN-BU
                                            TNS-CDKBN-KBNNUM
                                            TNS-CDKBN-KBNNUM-EDA
                                            TNS-CDKBN-KOUBAN 
                                            TNS-KOUHYOJYUNNUM
                 ELSE  
                     MOVE    TBL-ZAIW-SRYCD1   TO  TNS-SRYCD
                     MOVE    TNS-TENSU-REC     TO  MCPDATA-REC
                     MOVE    RECE64-SRYYM      TO  ORC-DBYMD(1:6)
                     MOVE    "01"              TO  ORC-DBYMD(7:2)
                     PERFORM 900-TENSU-INV-SEC
                     IF      FLG-TENSU            =       1
                         INITIALIZE               TNS-TENSU-REC
                         DISPLAY   "TENSU FETCH ERR" 
                     END-IF
                 END-IF
               END-IF
               MOVE    TNS-CDKBN-SYO       TO  RECE66-CDKBN-SYO
               MOVE    TNS-CDKBN-BU        TO  RECE66-CDKBN-BU
               MOVE    TNS-CDKBN-KBN       TO  RECE66-CDKBN-KBN
               MOVE    TNS-CDKBN-KBNNUM    TO  RECE66-CDKBN-KBNNUM
               MOVE    TNS-CDKBN-KBNNUM-EDA
                                           TO  RECE66-CDKBN-KBNNUM-EDA
               MOVE    TNS-CDKBN-KOUBAN    TO  RECE66-CDKBN-KOUBAN
               IF      RECE64-SRYKBN           =   "21"
               AND     TBL-ZAIW-SRYCD1     NOT =   CONS-TEIGEN
                   CONTINUE
               ELSE
                   MOVE    TNS-KOUHYOJYUNNUM
                                           TO  RECE66-KOUHYOJUNNUM
               END-IF
      *
      *--------------------------------------------------------------
               MOVE    RECE64-ZAITEN     TO  RECE66-ZAITEN
      *
               IF      TNS-SRYKBN        =   "60"
                       MOVE   TNS-KNSJISKBN  TO  RECE66-KNSJISKBN
               ELSE
                       MOVE   ZERO           TO  RECE66-KNSJISKBN
               END-IF
      *
               WRITE   RECE66-REC
      *         
               IF  STS-RECE66        NOT =   ZERO
                   DISPLAY "*** ORCR0690 RECE66 WRITE ERR  ***"
                   MOVE   WRK-TBLMAX     TO  IDY
      ***          MOVE    2             TO  SPA-STS                       
               ELSE
                   ADD     1             TO  CNT-RECE66
               END-IF    
           END-PERFORM
      *     
           INITIALIZE                    TBL-ZAI-AREA
      *
           .
       450-RECE66-OUT-EXT.
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
           CLOSE                       RECE64-FILE
           CLOSE                       RECE65-FILE
           CLOSE                       RECE66-FILE     
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
           DISPLAY "RECE66  CNT " CNT-RECE66 
           DISPLAY "*** ORCR0690 END ***"
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    数値半角→全角変換処理
      *****************************************************************
       800-NUM-ZENKAKU-HENKAN-SEC    SECTION.
      *
      *    FLG=1のとき空白は編集しない
      *
           MOVE    1                   TO  WRK-CHAR-IDX
           MOVE    ZERO                TO  WRK-CHAR-N-CNT
      *     
           PERFORM VARYING     IDZ     FROM    1   BY  1
                   UNTIL       IDZ     >   WRK-CHAR-CNT
               IF      WRK-CHAR-FLG        =   1
               AND     WRK-CHAR-X (IDZ:1)  =   SPACE
                   CONTINUE
               ELSE        
                   IF    WRK-CHAR-X (IDZ:1)  IS  NUMERIC
                       IF      WRK-CHAR-X (IDZ:1)  =   "0"
                           MOVE    TBL-SUJI (10)
                                       TO  WRK-CHAR-N (WRK-CHAR-IDX:)
                       ELSE
                           MOVE    WRK-CHAR-X (IDZ:1)  TO  WRK-NUM
                           MOVE    TBL-SUJI (WRK-NUM)
                                       TO  WRK-CHAR-N (WRK-CHAR-IDX:)
                       END-IF                    
                   ELSE
                       MOVE    "  "    TO  WRK-CHAR-N (WRK-CHAR-IDX:)
                   END-IF
                   ADD     2           TO  WRK-CHAR-IDX
                                           WRK-CHAR-N-CNT
               END-IF    
           END-PERFORM
      *
           .
       800-NUM-ZENKAKU-HENKAN-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数・回数編集処理
      *****************************************************************
       810-TENSUKAI-HEN-SEC    SECTION.
      *    点数編集
           INITIALIZE                      WRK-CHAR-HENKAN-AREA
           MOVE    WRK-ZAITENX         TO  WRK-CHAR-X
           MOVE    7                   TO  WRK-CHAR-CNT
           PERFORM 800-NUM-ZENKAKU-HENKAN-SEC
           MOVE    WRK-CHAR-N          TO  WRK-ZAITEN
      *    回数編集
           INITIALIZE                      WRK-CHAR-HENKAN-AREA
           MOVE    WRK-ZAIKAISUX       TO  WRK-CHAR-X
           MOVE    3                   TO  WRK-CHAR-CNT
           PERFORM 800-NUM-ZENKAKU-HENKAN-SEC
           MOVE    WRK-CHAR-N          TO  WRK-ZAIKAISU
           MOVE    "×"                TO  WRK-X
      *
      *    薬剤料逓減・未実施減算のとき点数のまえに▲を表示
           IF      FLG-TEIGEN          =   1
               PERFORM VARYING IDZ FROM    13  BY  -2
                       UNTIL   IDZ <       3
                   IF      WRK-ZAITEN (IDZ:2)  =   SPACE
                       MOVE    "▲"        TO  WRK-ZAITEN (IDZ:2)
                       MOVE    1           TO  IDZ
                   END-IF
               END-PERFORM
           END-IF
      *
      *
      *    必要有効桁数（点数ZZZZZZZ X 数量ZZZ の全角の桁数）
           MOVE    ZERO                TO  WRK-TNSKAI-KETA
           PERFORM VARYING   IDZ     FROM    1   BY  1
                   UNTIL     IDZ     >       22
               IF      WRK-TNSKAI (IDZ:1)      NOT =   SPACE
                   COMPUTE WRK-TNSKAI-KETA   =   22  -  IDZ     +   1
                   MOVE    22                  TO  IDZ
               END-IF 
           END-PERFORM
      *    開始位置を取得
           COMPUTE   WRK-TNSKAI-ST     =   ( 50  -  WRK-TNSKAI-KETA )
                                       +   1
      *
           .
       810-TENSUKAI-HEN-EXT.
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
