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
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCGR01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト
      *  コンポーネント名  : レセプト作成-個別指示（Ｒ０１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/05/24  患者番号ゼロ詰め処理
      *  01.00.02    MCC-藤原     01/06/27  追加・変更時の項目チェック追加
      *  01.00.03    MCC-藤原     01/07/16  前回表示・クリアのボタン追加
      *  01.00.04    MCC-藤原     01/07/16  日付画面用チェックサブ追加
      *  01.00.05    MCC-小豆沢   01/08/02  ＤＢＣＯＭＭＩＴ追加
      *  01.00.06    MCC-藤原     01/09/11  番号の編集追加
      *  01.01.01    MCC-藤原     01/09/21  JOINの修正
      *  01.01.02    MCC-小豆沢   01/11/28  SPA-TERMIDの桁数変更に伴う
      *                                     部分参照に変更      
      *  01.01.03    MCC-藤原     01/11/28  氏名検索への遷移の修正
      *  01.01.04    MCC-藤原     02/01/31  ジョブ管理ＤＢの追加
      *  01.01.05    MCC-藤原     02/02/19  処理中でも処理を終了できるように
      *                                     修正
      *  01.01.06    MCC-藤原     02/02/21  処理中のときのメッセージに
      *                                     プログラム名も表示
      *  01.01.07    MCC-藤原     02/02/26  レセプト管理ファイルを
      *                                     索引ファイルからＤＢへ変更
      *  01.01.08    MCC-藤原     02/04/03  県単用項目編集プログラム名の追加
      *  01.01.09    MCC-藤原     02/04/10  SRYACCT-KEY7をKEY9に変更
      *  01.01.10    MCC-藤原     02/05/30  情報削除ボタン追加
      *  01.01.11    MCC-藤原     02/06/06  処理結果画面追加
      *  01.01.12    MCC-藤原     02/06/17  労災・自賠責の処理を追加
      *  01.01.13    MCC-藤原     02/07/05  労災・医保の対象があるかチェック
      *  01.01.14    NACL-藤原    02/07/18  確定のとき自動的に情報確認画面を表示
      *  01.01.15    NACL-藤原    02.09.06  タイマー機能の追加
      *
      *  01.02.01    NACL-藤原    02/09/12  ディレクトリをサブプロへ
      *  01.02.02    NACL-藤原    02/09/24  ２００２．１０改正対応
      *  01.02.03    NACL-藤原    02/11/06  前回作成のときの年月のチェック
      *　入院機能追加　
      *  01.03.01    NACL-藤原    02/12/11  入外区分追加 
      *  01.03.02    NACL-藤原    03/02/27  入院用県単用項目編集プログラム名の追加
      *
      *  ２００３．４改正対応
      *  01.03.01    NACL-藤原    03/04/17  対象がないときエラーを表示する
      *  01.03.02    NACL-藤原    03/05/22  県番号をパラメタに追加
      *
      *  労災・自賠責入院機能追加
      *  01.04.01    NACL-藤原    03/06/05  労災・自賠責の入院対象が
      *                                     あるかチェック
      *  01.04.02    NACL-藤原    03/08/05  外来レセ電処理の追加
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 

      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    レセプト作成指示共通パラメタ
           COPY    "R01COMMON-SPA".
      *
      *   
           COPY    "ENUM-VALUE".
      *
      *    画面用ＳＰＡ
       01  SPA-R01.
           03  SPA-R01-AREA.
               05  SPA-GMN-MAX                     PIC 9(04).
               05  SPA-GMN-PAGE                    PIC 9(02).
               05  SPA-GMN-CUR                     PIC 9(02).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-SYOKBN              PIC X(20).
                   07  SPA-GMN-TBL.
                       09  SPA-GMN-TBL-G           OCCURS   100.
                           11  SPA-GMN-TRENNUM     PIC 9(03).
                           11  SPA-GMN-TPTNUM      PIC X(20).
                           11  SPA-GMN-TNAME       PIC X(50).
                           11  SPA-GMN-TSRYYM      PIC X(06).
                           11  SPA-GMN-TNYUGAIKBN  PIC X(01).
                   07  SPA-GMN-KOUMOKU.
                       09  SPA-GMN-RENNUM          PIC 9(03).
                       09  SPA-GMN-PTNUM           PIC X(20).
                       09  SPA-GMN-NAME            PIC X(50).
      *----(01.00.04) LINE UPD START ----------------------------------
      ***              09  SPA-GMN-SRYYM           PIC X(06).
                       09  SPA-GMN-SRYYM           PIC X(07).
      *----(01.00.04) LINE UPD END   ----------------------------------
                       09  SPA-GMN-NYUGAIKBN       PIC X(01).
      *
               05  SPA-NAI-SELNO                   PIC 9(03).                   
      *
               05  SPA-NAIB-R01-AREA.
                   07  SPA-NAI-HYO-SRYYM           PIC 9(06).
                   07  SPA-NAI-HYO-SRYYMH          PIC X(06).
                   07  SPA-NAI-KOUMOKU.
                       09  SPA-NAI-PTID            PIC 9(10).
                       09  SPA-NAI-SRYYM           PIC 9(06).
      * 
                   07  SPA-NAI-TBL.
                       09  SPA-NAI-TBL-G           OCCURS   100.
                           11  SPA-NAI-TPTID       PIC 9(10).
                           11  SPA-NAI-TSRYYM      PIC 9(06).
      *
                   07  SPA-NAI-SYOKBN              PIC X(01).                     
      *
       01  SPA-RECE07-REC. 
           COPY    "CPRCF007.INC"  REPLACING  //RECE07//
                                   BY         //SPA-RECE07//.
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-RECE07          PIC 9(01).
           03  FLG-SRYACCT         PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01). 
           03  FLG-CHK             PIC 9(01).
           03  FLG-NYUINACCT       PIC 9(01).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECEERR         PIC X(02).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDXX                PIC 9(04).
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
       01  KEY-AREA                            VALUE   LOW-VALUE.
           03  KEY-NEW.
               05  KEY-N-PTID                          PIC 9(10).
               05  KEY-N-HKNCOMBI                      PIC 9(04).
               05  KEY-N-SRYKA                         PIC X(02).
           03  KEY-OLD.
               05  KEY-O-PTID                          PIC 9(10).
               05  KEY-O-HKNCOMBI                      PIC 9(04).
               05  KEY-O-SRYKA                         PIC X(02).
      *
      *    画面用ワーク
       01  WRK-GMN-SORT.
           03  WRK-GMN-TBL.
               05  WRK-GMN-TBL-G           OCCURS   100.
                   07  WRK-GMN-TRENNUM     PIC 9(03).
                   07  WRK-GMN-TPTNUM      PIC X(20).
                   07  WRK-GMN-TNAME       PIC X(50).
                   07  WRK-GMN-TSRYYM      PIC X(06).
                   07  WRK-GMN-TNYUGAIKBN  PIC X(01).
      * 
           03  WRK-NAI-TBL.
               05  WRK-NAI-TBL-G           OCCURS   100.
                   07  WRK-NAI-TPTID       PIC 9(10).
                   07  WRK-NAI-TSRYYM      PIC 9(06).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-MOTOPG          PIC X(08).
           03  WRK-SELNO           PIC 9(03).
           03  WRK-NUM             PIC ZZ9.
           03  WRK-GMN-CUR         PIC 9(02).
           03  WRK-RECEERR         PIC X(200).
           03  WRK-RIDMSG          PIC X(70).
           03  WRK-YM              PIC X(07). 
           03  WRK-PATH            PIC X(64).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-SHELL-ARG1.
             05  WRK-SHELL-SRYYM   PIC  X(06).
             05  WRK-SHELL-TERMID  PIC  X(16).
             05  WRK-SHELL-SYSYMD  PIC  X(08).  
           03  WRK-RECEKBN         PIC X(06).
           03  WRK-NYUGAIKBN       PIC X(10).
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
           03  WRK-HENTIME.
               05  WRK-HH          PIC X(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-MM          PIC X(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-SS          PIC X(02).
      *
      *    スパ領域（ワーク）
           COPY    "COMMON-SPA"
                                   REPLACING  //SPA-//
                                   BY         //WRK-SPA-//.
      *                             
       01  WRK-SHELL-NAME.
           05  FILLER             PIC X(16) VALUE
                                             "scripts/monthly/".
           05  WRK-SHELL-SHELL    PIC X(20).         
      *
       01  WRK-CONS-AREA.
      *    ジョブ管理ＤＢのキー値  
           03  WRK-CONS-JOB-SHELLID
                                   PIC X(08)   VALUE   "RECEPT1".
           03  WRK-CONS-JOB-JOBID  PIC 9(07)   VALUE   1.
      *
      *    労災保険番号 
           03  WRK-CONS-ROUSAI-HKNNUM
                                   PIC X(03)   VALUE   "971". 
      *
      *    自賠責保険番号 
           03  WRK-CONS-JIBAISEKI-HKNNUM
                                   PIC X(03)   VALUE   "973". 
      *
           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".         
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    医療機関情報
           COPY    "CPSK1001.INC".
      *
           COPY    "CPSK2001.INC".
      *
           COPY    "CPSK2002.INC".
      *
           COPY    "CPSK2003.INC".
      *
           COPY    "CPSK2005.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    診療会計
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    レセプト管理     
       01  RECE07-REC. 
           COPY    "CPRCF007.INC".
      *
      *    入院会計
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *----(01.00.04) LINE ADD START ----------------------------------
      *
      *   画面日付変換サブ
          COPY    "CPORCSGDAY.INC".
      *----(01.00.04) LINE ADD END   ----------------------------------
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *     
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "R01.INC".
           COPY    "R02.INC".
           COPY    "R03.INC".
           COPY    "R04.INC".
           COPY    "R98.INC".
           COPY    "R99.INC".
           COPY    "RERR.INC".
           COPY    "RID1.INC".
           COPY    "RID2.INC".
           COPY    "RID3.INC".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-R01
           MOVE    SPA-WORK        TO  SPA-R01KYOUTU
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN     "PUTG"           ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-R01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-R01         TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "RERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF      FLG-END             =   1
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
      *****    IF      SPA-RIDCD2      NOT =   SPACE
      *            PERFORM 530-RIDSET2-SEC
      *            GO  TO  100-INIT-EXT
      *****    END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
      ***  MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "R01    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
      ***  MOVE    1               TO  SPA-GMN-CUR
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
      *
      *        元の画面へ戻す
               IF      SPA-MOTOPG      =   "XB01"
                   MOVE    LNK-COMMON      TO  SPA-KYOTUKEY
                   MOVE    LNK-SCRSPA      TO  SPA-R01
                   MOVE    SPA-WORK        TO  SPA-R01KYOUTU
                   GO  TO  300-SCREEN-EXT
               END-IF
               MOVE    SPA-MOTOPG          TO  WRK-MOTOPG
      *
               IF      WRK-MOTOPG(1:3)     =  "P97"  
                   MOVE    LNK-COMMON      TO  SPA-KYOUTU
                   MOVE    LNK-SCRSPA      TO  SPA-R01
                   MOVE    SPA-WORK        TO  SPA-R01KYOUTU
                   PERFORM 3101-U01SPASET-SEC
                   GO      TO      300-SCREEN-EXT
               END-IF
      *         
               MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
           END-IF
      *
           EVALUATE    SPA-MOTOPG
      *    作表処理
               WHEN    "RID1"
                   PERFORM 330-RID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
               WHEN    "R99"
                   PERFORM 340-RID2-SET-SEC
                   GO      TO      300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM 310-SPASET-SEC
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＬＤ外の項目入力編集処理
      *****************************************************************
       3101-U01SPASET-SEC              SECTION.
      *
           MOVE    LNK-KYOUTU          TO  WRK-SPA-KYOUTU
      *    受付、患者検索より
           IF      WRK-SPA-PTNUM       NOT =   SPACE
                   MOVE    WRK-SPA-PTNUM   TO  R01-PTNUM
               PERFORM 4103-PTNUM-CHK-SEC
               MOVE    5                   TO  SPA-GMN-CUR
           END-IF
           .
       3101-U01SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
      *
           INITIALIZE              SPA-R01-AREA
      *
           EVALUATE    SPA-R01-RECEKBN
               WHEN    "0"
                   MOVE    "医　保"    TO  WRK-RECEKBN
               WHEN    "3"
                   MOVE    "労　災"    TO  WRK-RECEKBN
               WHEN    "4"
                   MOVE    "自賠責"    TO  WRK-RECEKBN
           END-EVALUATE
           EVALUATE    SPA-R01-NYUGAIKBN
               WHEN    "1"
                   MOVE    "（入院）"        TO  WRK-NYUGAIKBN
               WHEN    "2"
                   MOVE    "（入院外）"      TO  WRK-NYUGAIKBN
           END-EVALUATE  
           STRING  WRK-RECEKBN        DELIMITED  BY  SIZE 
                   WRK-NYUGAIKBN      DELIMITED  BY  SPACE
                   INTO    SPA-GMN-SYOKBN
           END-STRING
      *             
      *****IF      SPA-SYSYMD(7:2)     >=  "10"
           IF      SPA-SYSYMD(7:2)     >   "10"
               MOVE    SPA-SYSYMD(1:6)     TO  SPA-NAI-HYO-SRYYM
               MOVE    SPA-SYSYMDWH(1:6)   TO  SPA-NAI-HYO-SRYYMH
           ELSE
               INITIALIZE                     STS-AREA-DAY
               INITIALIZE                     LNK-DAY6-AREA
               MOVE  "61"                     TO  LNK-DAY6-IRAI
               MOVE  SPA-SYSYMD               TO  LNK-DAY6-KIJUN
               MOVE  "2"                      TO  LNK-DAY6-ZOGENPTN
               MOVE  -1                       TO  LNK-DAY6-ZOGEN
               CALL  "ORCSDAY"                USING   STS-AREA-DAY
                                              LNK-DAY6-AREA
               MOVE    LNK-DAY6-KEISAN(1:6)   TO  SPA-NAI-HYO-SRYYM
               MOVE    LNK-DAY6-KEISAN        TO  WRK-SYMD  
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG(1:6)       TO  SPA-NAI-HYO-SRYYMH
           END-IF
      *                 
           MOVE    1               TO  SPA-GMN-PAGE
           MOVE    4               TO  SPA-GMN-CUR
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-RID1-SET-SEC            SECTION.
      *
           IF      SPA-RID1-FLG    =   "OK"
               IF      SPA-RIDCD       =   "6666"
                   MOVE    "JOIN"          TO  MCP-PUTTYPE
                   PERFORM 210-BACK-SYORI-SEC
               ELSE    
                   IF      SPA-RIDCD       =   "1002"
                       PERFORM 450-KOUSHIN-SEC
                   ELSE
                       IF      SPA-RIDCD       =   "1003"
                          PERFORM 460-CLEAR-SEC
                       ELSE
                          PERFORM 480-ZENKAI-HYOUJI-SEC
                       END-IF
                   END-IF
               END-IF
           END-IF    
      *
           MOVE    SPACE           TO  SPA-RID1-FLG
                                       SPA-R99-FLG
           MOVE    SPACE           TO  SPA-RIDCD      
           .
       330-RID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ２）ＯＫ処理
      *****************************************************************
       340-RID2-SET-SEC            SECTION.
      *
           IF      SPA-R99-FLG     =   "OK"
               PERFORM 4501-NEXT-GMN-SEC
           END-IF    
      *
           MOVE    SPACE           TO  SPA-RID1-FLG
                                       SPA-R99-FLG
           MOVE    SPACE           TO  SPA-RIDCD
           MOVE    SPACE           TO  SPA-RIDCD2      
           .
       340-RID2-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE    "CHANGE"            TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *       追加
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 420-TUIKA-SEC
      *    変更
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM 430-HENKOU-SEC
      *    削除
               WHEN    "CLICKED"       ALSO    "B04"
                   PERFORM 440-SAKUJYO-SEC
      *    クリア
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 460-CLEAR-RID-SEC
      *    前回作成分表示
               WHEN    "CLICKED"       ALSO    "B08"
                   PERFORM 480-ZENKAI-HYOUJI-RID-SEC
      *    氏名検索
               WHEN    "CLICKED"       ALSO    "B09"
                   PERFORM 480-KENSAKU-SEC
      *     情報削除
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 490-JYOUHOU-DEL-SEC
      *    登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 450-TOUROKU-SEC
      *    処理確認
               WHEN    "CLICKED"       ALSO    "B13"
                   PERFORM 490-KAKUNIN-SEC
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *
               WHEN    "ACTIVATE"      ALSO    "RENNUM"
                   PERFORM 4102-RENNUM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "PTNUM"
                   PERFORM 4103-PTNUM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SRYYM"
                   PERFORM 4104-SRYYM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NYUGAIKBN"
                   PERFORM 4105-NYUGAIKBN-CHK-SEC
               WHEN    ANY             ALSO    "RECELST"
                   PERFORM 4106-RECESEL-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    番号選択　入力処理
      *****************************************************************
       4102-RENNUM-CHK-SEC         SECTION.
      *
           INITIALIZE                 SPA-GMN-KOUMOKU
                                      SPA-NAI-KOUMOKU
           MOVE    ZERO               TO  SPA-NAI-SELNO                           
      *
           MOVE    3                  TO  SPA-GMN-CUR
      *
           MOVE    R01-RENNUM         TO  SPA-GMN-RENNUM
      *
           IF      SPA-GMN-RENNUM      =   ZERO
               IF      SPA-GMN-MAX         =   100
                   MOVE    "0002"              TO  SPA-ERRCD
               ELSE
                   MOVE    4                   TO  SPA-GMN-CUR 
               END-IF
               GO  TO  4102-RENNUM-CHK-EXT
           END-IF
      *
           IF      SPA-GMN-RENNUM      >   SPA-GMN-MAX
               MOVE    "0001"          TO  SPA-ERRCD
               GO      TO      4102-RENNUM-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-RENNUM      TO  SPA-NAI-SELNO
      *
           PERFORM 41021-RENNUM-HENSYU-SEC
      *
           .
       4102-RENNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択項目編集処理
      *****************************************************************
       41021-RENNUM-HENSYU-SEC            SECTION.
      *
                
           MOVE    SPA-GMN-TPTNUM     (SPA-GMN-RENNUM)
                                       TO  SPA-GMN-PTNUM
           MOVE    SPA-NAI-TPTID      (SPA-GMN-RENNUM)
                                       TO  SPA-NAI-PTID
           MOVE    SPA-GMN-TNAME      (SPA-GMN-RENNUM)
                                       TO  SPA-GMN-NAME
           MOVE    SPA-GMN-TSRYYM     (SPA-GMN-RENNUM)
                                       TO  SPA-GMN-SRYYM
           MOVE    SPA-NAI-TSRYYM     (SPA-GMN-RENNUM)
                                       TO  SPA-NAI-SRYYM
           MOVE    SPA-GMN-TNYUGAIKBN (SPA-GMN-RENNUM)
                                       TO  SPA-GMN-NYUGAIKBN
      *
           MOVE    4                   TO  SPA-GMN-CUR 
      *
           .
       41021-RENNUM-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号チェック処理
      *****************************************************************
       4103-PTNUM-CHK-SEC            SECTION.
      *
           MOVE    4                   TO  SPA-GMN-CUR
      *
           MOVE    R01-PTNUM           TO  SPA-GMN-PTNUM
      *
           MOVE    SPACE               TO  SPA-GMN-NAME
           MOVE    ZERO                TO  SPA-NAI-PTID 
      *
           INITIALIZE                  ORCSPTIDAREA
           MOVE    SPA-HOSPID          TO  SPTID-HOSPID
           MOVE    SPA-GMN-PTNUM       TO  SPTID-PTNUM
           CALL    "ORCSPTID"          USING   ORCSPTIDAREA
      *----(01.01.01) LINE ADD START ----------------------------------
                                               SPA-1009-TBL
      *----(01.01.01) LINE ADD END   ----------------------------------
           IF      SPTID-RC        NOT =   ZERO
               MOVE    "0003"          TO  SPA-ERRCD
               GO  TO                  4103-PTNUM-CHK-EXT
           END-IF
      *----(01.00.01) LINE ADD START ----------------------------------
           MOVE    SPTID-PTNUM         TO  SPA-GMN-PTNUM
      *----(01.00.01) LINE ADD END   ----------------------------------
           MOVE    SPTID-PTID          TO  SPA-NAI-PTID
      *
      *    患者マスター存在チェック
           MOVE    SPA-HOSPID          TO  PTINF-HOSPID
           MOVE    SPA-NAI-PTID        TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           IF      FLG-PTINF           NOT =   ZERO
               MOVE    "0001"              TO  SPA-ERRCD
               GO      TO      4103-PTNUM-CHK-EXT
           END-IF
      *
           MOVE    PTINF-NAME        TO  SPA-GMN-NAME
      *
           MOVE    5                 TO  SPA-GMN-CUR
           .
       4103-PTNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療年月チェック処理
      *****************************************************************
       4104-SRYYM-CHK-SEC          SECTION.
      *
           MOVE    5                  TO  SPA-GMN-CUR
      *
           MOVE   R01-SRYYM           TO  SPA-GMN-SRYYM
      *
      *----(01.00.04) LINE MOD START  ----------------------------------
      ***  MOVE    SPA-GMN-SRYYM     TO  WRK-YM
      ***  PERFORM 5002-HIZUKE-CHK-SEC
      ***  IF      SPA-ERRCD            =   SPACE
      ***      MOVE    WRK-SYMD   (1:6)     TO  SPA-NAI-SRYYM 
      ***      MOVE    WRK-HENYMDG(1:6)     TO  SPA-GMN-SRYYM
      ***  ELSE    
      ***      GO  TO  4104-SRYYM-CHK-EXT
      ***  END-IF
      *
           IF      SPA-GMN-SRYYM      =   SPACE
               MOVE    SPA-NAI-HYO-SRYYM   TO  SPA-NAI-SRYYM
               MOVE    SPA-NAI-HYO-SRYYMH  TO  SPA-GMN-SRYYM
           ELSE
      *    日付画面チェックサブ
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN-SRYYM       TO  SGDAY-INDAY
               MOVE    "1"                 TO  SGDAY-INTYPE
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY(1:6)    TO  SPA-GMN-SRYYM
                   MOVE    SGDAY-SDAY (1:6)    TO  SPA-NAI-SRYYM
               ELSE
                   MOVE    "0001"          TO  SPA-ERRCD
                   GO  TO  4104-SRYYM-CHK-EXT
               END-IF
           END-IF
      *----(01.00.04) LINE MOD END   ----------------------------------
      *
           MOVE    6                   TO  SPA-GMN-CUR
      *
           .
       4104-SRYYM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入外区分  入力処理
      *****************************************************************
       4105-NYUGAIKBN-CHK-SEC                SECTION.
      *   
           MOVE    6                   TO  SPA-GMN-CUR
      *
           MOVE    R01-NYUGAIKBN       TO  SPA-GMN-NYUGAIKBN
      *
           IF      SPA-GMN-NYUGAIKBN    =   SPACE
      *********MOVE    "2"                  TO  SPA-GMN-NYUGAIKBN
               MOVE    SPA-R01-NYUGAIKBN    TO  SPA-GMN-NYUGAIKBN
           END-IF
      *
      *****IF      SPA-GMN-NYUGAIKBN    =   SPACE   OR  "1" OR  "2"
           IF      SPA-GMN-NYUGAIKBN    =   SPA-R01-NYUGAIKBN
               CONTINUE
           ELSE
               MOVE    "0001"               TO  SPA-ERRCD
               GO  TO  4105-NYUGAIKBN-CHK-EXT
           END-IF 
      *
      *    診療会計チェック
           MOVE    ZERO                TO  FLG-CHK
      *     
           INITIALIZE                  SRYACCT-REC
           MOVE    SPA-HOSPID          TO  ACCT-HOSPID
           MOVE    SPA-NAI-PTID        TO  ACCT-PTID
           MOVE    SPA-NAI-SRYYM       TO  ACCT-SRYYM
           MOVE    SPA-GMN-NYUGAIKBN   TO  ACCT-NYUGAIKBN
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACCT-KEY9"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACCT-KEY9"      TO  ORC-DBPATH
               PERFORM 900-SRYACCT-READ-SEC
           ELSE
               INITIALIZE                  SRYACCT-REC
               MOVE    1                   TO  FLG-SRYACCT
           END-IF
      *
           PERFORM             UNTIL   FLG-SRYACCT     =   1
                               OR      FLG-CHK         =   1
               PERFORM 41051-SRYACCT-CHK-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYACCT-KEY9"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    入院のとき診療会計に存在しないとき入院会計をチェック                                  
           IF      FLG-CHK             =   ZERO
               IF      SPA-R01-NYUGAIKBN   =   "1"
                   PERFORM 41052-NYUINACCT-CHK-SEC
               END-IF
           END-IF
      *          
           IF      FLG-CHK             =   ZERO
               MOVE    "0006"              TO  SPA-ERRCD
           ELSE 
               MOVE    4                   TO  SPA-GMN-CUR
           END-IF    
           .
       4105-NYUGAIKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計チェック処理
      *****************************************************************
       41051-SRYACCT-CHK-SEC           SECTION.
      * 
           MOVE    KEY-NEW             TO  KEY-OLD
      *     
      *    保険組合せ読込み
           INITIALIZE                  HKNCOMBI-REC
           MOVE    ACCT-HOSPID         TO  COMB-HOSPID
           MOVE    ACCT-PTID           TO  COMB-PTID
           MOVE    ACCT-HKNCOMBI       TO  COMB-HKNCOMBINUM 
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           PERFORM  910-HKNCOMBI-INV-SEC
      *
           IF      FLG-HKNCOMBI        =   ZERO
               EVALUATE    SPA-R01-RECEKBN
                   WHEN    "0"
                       IF      COMB-HKNNUM =   WRK-CONS-ROUSAI-HKNNUM
                       OR      COMB-HKNNUM =   WRK-CONS-JIBAISEKI-HKNNUM
                           CONTINUE
                       ELSE    
                           MOVE    "1"         TO  FLG-CHK
                       END-IF
                   WHEN    "3"
                       IF      COMB-HKNNUM =   WRK-CONS-ROUSAI-HKNNUM
                           MOVE    "1"         TO  FLG-CHK
                       END-IF
                   WHEN    "4"
                       IF      COMB-HKNNUM =   WRK-CONS-JIBAISEKI-HKNNUM
                           MOVE    "1"         TO  FLG-CHK
                       END-IF
               END-EVALUATE
           END-IF        
      *
           PERFORM UNTIL   FLG-SRYACCT     =   1
                   OR      FLG-CHK         =   1 
                   OR      KEY-NEW     NOT =   KEY-OLD
               MOVE    "SRYACCT-KEY9"      TO  ORC-DBPATH
               PERFORM 900-SRYACCT-READ-SEC
           END-PERFORM
           .
       41051-SRYACCT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計チェック処理
      *****************************************************************
       41052-NYUINACCT-CHK-SEC           SECTION.
      *     
      *    入院会計読込み（基本）
           INITIALIZE                  NYUINACCT-REC
           MOVE    SPA-HOSPID          TO  NACCT-HOSPID
           MOVE    SPA-NAI-PTID        TO  NACCT-PTID
           MOVE    SPA-NAI-SRYYM       TO  NACCT-SRYYM
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "NYUINACCT-KEY14"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "NYUINACCT-KEY14"   TO  ORC-DBPATH
               PERFORM  900-NYUINACCT-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-NYUINACCT    
           END-IF
      *
           PERFORM             UNTIL    FLG-NYUINACCT  =   "1"
                               OR       FLG-CHK        =   "1"           
      *    保険組合せ読込み
               IF      NACCT-ZAISKBKBN     =   "5"
                 PERFORM VARYING IDXX    FROM    1   BY  1
                         UNTIL   IDXX    >       31
                         OR      FLG-CHK =       "1"
                   IF      NACCT-DAY (IDXX)      >   ZERO    
                       INITIALIZE                  HKNCOMBI-REC
                       MOVE    ACCT-HOSPID         TO  COMB-HOSPID
                       MOVE    ACCT-PTID           TO  COMB-PTID
                       MOVE    NACCT-DAY (IDXX)    TO  COMB-HKNCOMBINUM 
                       MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
                       PERFORM  910-HKNCOMBI-INV-SEC
      *
                       IF      FLG-HKNCOMBI        =   ZERO
                         EVALUATE    SPA-R01-RECEKBN
                           WHEN    "0"
                               IF      COMB-HKNNUM =
                                               WRK-CONS-ROUSAI-HKNNUM
                               OR      COMB-HKNNUM =
                                               WRK-CONS-JIBAISEKI-HKNNUM
                                   CONTINUE
                               ELSE    
                                   MOVE    "1"         TO  FLG-CHK
                               END-IF
                           WHEN    "3"
                               IF      COMB-HKNNUM =
                                               WRK-CONS-ROUSAI-HKNNUM
                                   MOVE    "1"         TO  FLG-CHK
                               END-IF
                           WHEN    "4"
                               IF      COMB-HKNNUM =
                                               WRK-CONS-JIBAISEKI-HKNNUM
                                   MOVE    "1"         TO  FLG-CHK
                               END-IF
                         END-EVALUATE
                       END-IF
                   END-IF
                 END-PERFORM
                 MOVE    1                   TO  FLG-NYUINACCT 
               ELSE            
                 MOVE    "NYUINACCT-KEY14"   TO  ORC-DBPATH
                 PERFORM  900-NYUINACCT-READ-SEC
               END-IF
           END-PERFORM    
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "NYUINACCT-KEY14"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *****IF      FLG-NYUINACCT       =   ZERO
      *****    MOVE    "1"                 TO  FLG-CHK
      *****END-IF
           .
       41052-NYUINACCT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       4106-RECESEL-SEC       SECTION.
      *        行選択
           MOVE    ZERO                TO  WRK-SELNO
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       100
               IF      R01-SELECT (IDX)    =   "T"
                   IF      IDX             =   SPA-NAI-SELNO
                       CONTINUE
                   ELSE        
                       MOVE    IDX             TO  WRK-SELNO
                       MOVE    100             TO  IDX
                   END-IF
               END-IF    
           END-PERFORM
      *
           IF      WRK-SELNO           >   ZERO
               MOVE    WRK-SELNO           TO  SPA-NAI-SELNO
           END-IF
      *
      *
           INITIALIZE                  SPA-GMN-KOUMOKU
           INITIALIZE                  SPA-NAI-KOUMOKU
      *
           MOVE    SPA-GMN-TRENNUM (SPA-NAI-SELNO)
                                       TO  SPA-GMN-RENNUM
      *
           PERFORM 41021-RENNUM-HENSYU-SEC
           .
       41015-SRYACTSEL-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
      *    ジョブ管理チェック処理
           MOVE    "CHK"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA 
                                   JOBKANRI-REC 
           IF      SJOBKANRI-RETURN
                                   =   ZERO
               IF      JOB-ENDYMD      =   SPACE
      *********AND     JOB-TERMID      =   SPA-TERMID
                   MOVE    "6666"          TO  SPA-RIDCD
                   GO  TO  210-BACK-EXT
               END-IF
           END-IF
      *
           PERFORM 210-BACK-SYORI-SEC         
           .
       210-BACK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK-SYORI-SEC              SECTION.
      *
           MOVE    "R03"               TO  SPA-SAKIPG
           MOVE    "R01"               TO  SPA-MOTOPG
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    追加　処理
      *****************************************************************
       420-TUIKA-SEC                SECTION.
      *
           IF      SPA-GMN-RENNUM      >   ZERO
               MOVE    "0005"              TO  SPA-ERRCD
               GO  TO  420-TUIKA-EXT
           END-IF
      *
           IF      SPA-GMN-MAX      =   100
               MOVE    "0002"               TO  SPA-ERRCD
               GO      TO      420-TUIKA-EXT
           END-IF
      *
           PERFORM 4203-KOMOKUCHK-SEC
           IF      SPA-ERRCD    NOT =   SPACE
               GO  TO  420-TUIKA-EXT
           END-IF    
      *
           PERFORM 4204-SRYYM-CHK-SEC
           IF      SPA-ERRCD    NOT =   SPACE
               GO  TO  420-TUIKA-EXT
           END-IF    
      *
           COMPUTE IDY     =   SPA-GMN-MAX  +   1
           PERFORM 4202-INTBL-CHK-SEC
           IF      SPA-ERRCD        NOT =   SPACE
              GO  TO  420-TUIKA-EXT
           END-IF
      *    
           ADD     1                TO  SPA-GMN-MAX
           MOVE    SPA-GMN-MAX      TO
                                SPA-GMN-TRENNUM   (SPA-GMN-MAX)
           MOVE    SPA-GMN-MAX          TO  IDX
           PERFORM 4201-INTBL-SET-SEC
      *
           MOVE    4                TO  SPA-GMN-CUR  
      *
           .
       420-TUIKA-EXT.
           EXIT.
      *
      *****************************************************************
      *       入力項目の関連チェック処理
      *****************************************************************
       4203-KOMOKUCHK-SEC           SECTION.
      *
           MOVE    SPACE                TO  SPA-ERRCD
           MOVE    SPA-GMN-CUR          TO  WRK-GMN-CUR
      * 
           PERFORM 4103-PTNUM-CHK-SEC
           IF      SPA-ERRCD            =   SPACE
               PERFORM 4104-SRYYM-CHK-SEC
           END-IF
           IF      SPA-ERRCD            =   SPACE
               PERFORM 4105-NYUGAIKBN-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD            =   SPACE
               MOVE    WRK-GMN-CUR          TO  SPA-GMN-CUR
           END-IF             
           .
       4203-KOMOKUCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       診療年月の改正前・後の重複チェック処理
      *****************************************************************
       4204-SRYYM-CHK-SEC           SECTION.
      *
      *    追加のときまたは１行
           IF    ( SPA-GMN-MAX      =   ZERO         )
           OR    ( SPA-GMN-MAX      =   1       AND 
                   SPA-GMN-RENNUM   =   1            )
               IF      SPA-NAI-SRYYM    <   200210
                   MOVE    "1"              TO  SPA-NAI-SYOKBN
               ELSE
                   MOVE    "2"              TO  SPA-NAI-SYOKBN
               END-IF
           ELSE
               IF      SPA-NAI-SYOKBN   =   "1"
                   IF      SPA-NAI-SRYYM    <   200210
                       CONTINUE
                   ELSE
                       MOVE    "0007"           TO  SPA-ERRCD
                   END-IF                                  
               ELSE
                   IF      SPA-NAI-SRYYM    >=  200210
                       CONTINUE
                   ELSE
                       MOVE    "0007"           TO  SPA-ERRCD
                   END-IF                                  
               END-IF
           END-IF              
           .
       4204-SRYYM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力項目重複チェック処理
      *****************************************************************
       4202-INTBL-CHK-SEC                SECTION.
      *
           MOVE    SPACE                   TO  SPA-ERRCD
      * 
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       100
               IF      IDX         =   IDY 
                   CONTINUE
               ELSE
                   IF      SPA-NAI-TPTID     (IDX) =   SPA-NAI-PTID
                   AND     SPA-GMN-TSRYYM    (IDX) =   SPA-GMN-SRYYM
                   AND     SPA-GMN-TNYUGAIKBN(IDX) =
                                                   SPA-GMN-NYUGAIKBN
                       MOVE    "0002"              TO  SPA-ERRCD
                       MOVE    100                 TO  IDX
                   END-IF
               END-IF
           END-PERFORM
           .                   
       4202-INTBL-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力項目編集処理
      *****************************************************************
       4201-INTBL-SET-SEC                SECTION.
      *
      *
           MOVE    SPA-GMN-PTNUM        TO  SPA-GMN-TPTNUM     (IDX)
           MOVE    SPA-NAI-PTID         TO  SPA-NAI-TPTID      (IDX)
           MOVE    SPA-GMN-NAME         TO  SPA-GMN-TNAME      (IDX)
           MOVE    SPA-GMN-SRYYM        TO  SPA-GMN-TSRYYM     (IDX)
           MOVE    SPA-NAI-SRYYM        TO  SPA-NAI-TSRYYM     (IDX)
           MOVE    SPA-GMN-NYUGAIKBN    TO  SPA-GMN-TNYUGAIKBN (IDX)
      *
           INITIALIZE                   SPA-GMN-KOUMOKU
                                        SPA-NAI-KOUMOKU
           MOVE    ZERO                 TO  SPA-NAI-SELNO                             
      *
          .
       4201-INTBL-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    変更　処理
      *****************************************************************
       430-HENKOU-SEC              SECTION.
      *
           IF      SPA-GMN-RENNUM  =   ZERO
               MOVE    "0004"              TO  SPA-ERRCD
               GO  TO  430-HENKOU-EXT
           END-IF
      *
           PERFORM 4203-KOMOKUCHK-SEC
           IF      SPA-ERRCD    NOT =   SPACE
               GO  TO  430-HENKOU-EXT
           END-IF    
      *
           PERFORM 4204-SRYYM-CHK-SEC
           IF      SPA-ERRCD    NOT =   SPACE
               GO  TO  430-HENKOU-EXT
           END-IF    
      * 
           MOVE    SPA-GMN-RENNUM  TO  IDY
      *
           PERFORM 4202-INTBL-CHK-SEC
           IF      SPA-ERRCD        NOT =   SPACE
              GO  TO  430-HENKOU-EXT
           END-IF
      *
           MOVE    SPA-GMN-RENNUM  TO  IDX
      *
           PERFORM 4201-INTBL-SET-SEC
      *
           MOVE    4                   TO  SPA-GMN-CUR 
      *
          .
       430-HENKOU-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除　処理
      *****************************************************************
       440-SAKUJYO-SEC             SECTION.
      *
           IF      SPA-GMN-RENNUM  =   ZERO
               MOVE    "0004"              TO  SPA-ERRCD
               GO  TO  440-SAKUJYO-EXT
           END-IF
      *
           MOVE    SPA-GMN-RENNUM  TO  IDX
           INITIALIZE              SPA-GMN-TBL-G (IDX)
           INITIALIZE              SPA-NAI-TBL-G (IDX)
      *
           INITIALIZE              WRK-GMN-SORT
           MOVE    SPA-GMN-TBL     TO  WRK-GMN-TBL
           MOVE    SPA-NAI-TBL     TO  WRK-NAI-TBL
           INITIALIZE              SPA-GMN-TBL
           INITIALIZE              SPA-NAI-TBL
           MOVE    ZERO            TO  IDX2
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   100
               IF      WRK-GMN-TRENNUM  (IDX)     =   ZERO
                   CONTINUE
               ELSE
                   ADD     1                   TO  IDX2
                   MOVE    WRK-GMN-TBL-G (IDX)  TO
                                               SPA-GMN-TBL-G (IDX2)
                   MOVE    WRK-NAI-TBL-G (IDX)  TO
                                               SPA-NAI-TBL-G (IDX2)
                   MOVE    IDX2                TO
                                               SPA-GMN-TRENNUM(IDX2)
               END-IF
           END-PERFORM
           MOVE    IDX2                TO  SPA-GMN-MAX
      *
           INITIALIZE                  SPA-GMN-KOUMOKU
                                       SPA-NAI-KOUMOKU
      *
           MOVE    4                   TO  SPA-GMN-CUR  
      *
          .
       440-SAKUJYO-EXT.
           EXIT.
      *
      *****************************************************************
      *    クリア　確認処理
      *****************************************************************
       460-CLEAR-RID-SEC             SECTION.
      *
           MOVE    "1003"             TO  SPA-RIDCD
          .
       460-CLEAR-RID-EXT.
           EXIT.
      *
      *****************************************************************
      *    クリア　処理
      *****************************************************************
       460-CLEAR-SEC             SECTION.
      *
           MOVE    ZERO                  TO  SPA-GMN-MAX
           INITIALIZE                    SPA-GMN-TBL
                                         SPA-NAI-TBL
                                         SPA-GMN-KOUMOKU
           MOVE    ZERO                  TO  SPA-NAI-SELNO                              
      *
           MOVE    3                     TO  SPA-GMN-CUR  
      *
          .
       460-CLEAR-EXT.
           EXIT.
      *
      *****************************************************************
      *    前回作成分表示　確認処理
      *****************************************************************
       480-ZENKAI-HYOUJI-RID-SEC      SECTION.
      *
           MOVE    "1004"             TO  SPA-RIDCD
          .
       460-CLEAR-RID-EXT.
           EXIT.
      *
      *****************************************************************
      *    前回作成分表示　処理
      *****************************************************************
       480-ZENKAI-HYOUJI-SEC             SECTION.
      *
           MOVE    ZERO                TO  SPA-NAI-SELNO
      *     
      *        レセプト指示コード
           INITIALIZE                  SYS-2001-REC
           MOVE    "2001"              TO  SYS-2001-KANRICD
           MOVE    "*"                 TO  SYS-2001-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-2001-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-2001-REC
               IF      SYS-2001-SYOKBN     =   "1"    
                   MOVE    "0011"                 TO  SPA-ERRCD
                   GO  TO  480-ZENKAI-HYOUJI-EXT
               ELSE
                   IF      SYS-2001-RECEKBN    =   SPA-R01-RECEKBN
                       CONTINUE
                   ELSE     
                       MOVE    "0012"                 TO  SPA-ERRCD
                       GO  TO  480-ZENKAI-HYOUJI-EXT
                   END-IF 
                   IF      SYS-2001-NYUGAIKBN  =
                                           SPA-R01-NYUGAIKBN
                       CONTINUE
                   ELSE     
                       MOVE    "0013"                 TO  SPA-ERRCD
                       GO  TO  480-ZENKAI-HYOUJI-EXT
                   END-IF    
               END-IF
           END-IF
      *
      *        レセプト指示（個別指示）コード読み込み
           INITIALIZE                      SYS-2002-REC
           MOVE    "2002"              TO  SYS-2002-KANRICD
           MOVE    ZERO                TO  ORC-DBYMD
           MOVE    SYS-2002-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    ZERO                  TO  SPA-GMN-MAX
           INITIALIZE                    SPA-GMN-TBL
                                         SPA-NAI-TBL
                                         SPA-GMN-KOUMOKU
      *
           PERFORM             UNTIL       FLG-SYSKANRI    =   1
               MOVE    MCPDATA-REC     TO  SYS-2002-REC
               ADD     1               TO  SPA-GMN-MAX
               MOVE    SPA-GMN-MAX     TO  SPA-GMN-TRENNUM(SPA-GMN-MAX)
               MOVE    SYS-2002-NYUGAIKBN
                                       TO  SPA-GMN-TNYUGAIKBN
                                                          (SPA-GMN-MAX)
      *
               MOVE    SYS-2002-PTID   TO  SPA-NAI-TPTID  (SPA-GMN-MAX)
               INITIALIZE                  ORCSPTIDAREA
               MOVE    SPA-HOSPID      TO  SPTID-HOSPID
               MOVE    SPA-NAI-TPTID (SPA-GMN-MAX)
                                       TO  SPTID-PTID
               CALL    "ORCSPTID"      USING   ORCSPTIDAREA
                                                SPA-1009-TBL
               IF      SPTID-RC        =   ZERO
                   MOVE    SPTID-PTNUM TO  SPA-GMN-TPTNUM(SPA-GMN-MAX)
               END-IF
               MOVE    SPA-HOSPID      TO  PTINF-HOSPID
               MOVE    SPA-NAI-TPTID (SPA-GMN-MAX)
                                       TO  PTINF-PTID
               PERFORM 900-PTINF-READ-SEC
               IF      FLG-PTINF       =   ZERO
                   MOVE    PTINF-NAME  TO  SPA-GMN-TNAME (SPA-GMN-MAX)
               END-IF
      *
               MOVE    SYS-2002-SRYYM  TO  SPA-NAI-TSRYYM (SPA-GMN-MAX)
               MOVE    SPA-NAI-TSRYYM (SPA-GMN-MAX)
                                       TO  WRK-SYMD(1:6)
               MOVE    "01"            TO  WRK-SYMD(7:2)
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG(1:6)
                                       TO  SPA-GMN-TSRYYM(SPA-GMN-MAX)
      *
               MOVE    "SYSKANRI-KEY2" TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    １行目のとき
           IF      SPA-GMN-MAX      >   ZERO 
               IF      SPA-NAI-TSRYYM (1)
                                        <   200210
                   MOVE    "1"              TO  SPA-NAI-SYOKBN
               ELSE
                   MOVE    "2"              TO  SPA-NAI-SYOKBN
               END-IF
           END-IF
      *
           MOVE    3                   TO  SPA-GMN-CUR 
      *
          .
       480-ZENKAI-HYOUJI-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    作表処理
      *****************************************************************
       450-TOUROKU-SEC                SECTION.
      *
      *    ジョブ管理チェック処理
           MOVE    "CHK"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA 
                                   JOBKANRI-REC 
           IF      SJOBKANRI-RETURN
                                   =   ZERO
               IF      JOB-ENDYMD      =   SPACE
                   MOVE    "7777"          TO  SPA-ERRCD
                   MOVE    SPACE             TO  WRK-RECEERR
                   STRING  "レセプト作成処理中です【"
                                             DELIMITED  BY  SIZE
                           JOB-SHELLMSG      DELIMITED  BY  SPACE
                           "】"              DELIMITED  BY  SIZE      
                                             INTO  WRK-RECEERR
                   END-STRING                          
                   GO  TO  450-TOUROKU-EXT
               END-IF
           END-IF    
      *
           IF      SPA-GMN-MAX        =   ZERO
               MOVE    "0010"             TO  SPA-ERRCD
           ELSE
               MOVE    "1002"             TO  SPA-RIDCD
           END-IF
           .
       450-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    再印刷チェック処理
      *****************************************************************
       4501-REPRINT-CHK-SEC         SECTION.
      *
           INITIALIZE              SPA-RECE07-KEY
                                   SPA-RECE07-RECEKBN
                                   SPA-RECE07-NYUGAIKBN
                                   SPA-RECE07-SRYYM
      *
           INITIALIZE                  RECE07-REC
           IF      SPA-R01-RECEKBN     =   "0" OR  "1" OR  "2"
               MOVE    "HC06"              TO  RECE07-PRTID
           ELSE
               IF      SPA-R01-RECEKBN     =   "3"
                   MOVE    "HC21"              TO  RECE07-PRTID
               END-IF
               IF      SPA-R01-RECEKBN     =   "4"
                   MOVE    "HC23"              TO  RECE07-PRTID
               END-IF
           END-IF            
           IF      SPA-R01-FILEKBN         =   "1"
               MOVE    SPA-R01-SRYYM       TO  RECE07-SRYYM
               MOVE    "1"                 TO  RECE07-SYOKBN
      *********MOVE    "2"                 TO  RECE07-NYUGAIKBN
               MOVE    SPA-R01-NYUGAIKBN   TO  RECE07-NYUGAIKBN
               MOVE    SPA-R01-RECEKBN     TO  RECE07-RECEKBN
               MOVE    "RECEKANRI-KEY7"    TO  WRK-PATH
           ELSE
      *********MOVE    ZERO                TO  RECE07-SRYYM
               MOVE    "2"                 TO  RECE07-SYOKBN
               MOVE    SPA-R01-NYUGAIKBN   TO  RECE07-NYUGAIKBN
      *********MOVE    "RECEKANRI-KEY2"    TO  WRK-PATH
               MOVE    "RECEKANRI-KEY5"    TO  WRK-PATH
           END-IF
           MOVE    RECE07-REC          TO  MCPDATA-REC
           PERFORM 900-RECE07-INV-SEC
           IF      FLG-RECE07          =   ZERO
               MOVE    RECE07-KEY          TO  SPA-RECE07-KEY
               MOVE    RECE07-RECEKBN      TO  SPA-RECE07-RECEKBN
               MOVE    RECE07-SRYYM        TO  SPA-RECE07-SRYYM
               MOVE    RECE07-NYUGAIKBN    TO  SPA-RECE07-NYUGAIKBN
           END-IF
      *
           .
       4501-REPRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新処理
      *****************************************************************
       450-KOUSHIN-SEC                 SECTION.
      *
      *    レセプト指示更新
           INITIALIZE                  SYS-2001-REC
           MOVE    "2001"              TO  SYS-2001-KANRICD
           MOVE    "*"                 TO  SYS-2001-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-2001-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-2001-REC
           ELSE
               INITIALIZE                      SYS-2001-REC
               MOVE    "2001"              TO  SYS-2001-KANRICD
               MOVE    "*"                 TO  SYS-2001-KBNCD
               MOVE    ALL ZERO            TO  SYS-2001-STYUKYMD
               MOVE    ALL "9"             TO  SYS-2001-EDYUKYMD
           END-IF 
           MOVE    "2"                 TO  SYS-2001-SYOKBN
           MOVE    SPA-R01-RECEKBN     TO  SYS-2001-RECEKBN
           MOVE    SPA-R01-NYUGAIKBN   TO  SYS-2001-NYUGAIKBN
           MOVE    SYS-2001-REC        TO  MCPDATA-REC
           IF      FLG-SYSKANRI        =   1
               MOVE    "DBINSERT"          TO  MCP-FUNC
           ELSE
              MOVE    "DBUPDATE"          TO  MCP-FUNC
           END-IF
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO 
               MOVE    "1003"              TO  SPA-ERRCD
               DISPLAY "2001 SYSKANRI-KEY =>" SYS-2001-KEY 
               GO  TO  450-KOUSHIN-EXT
           END-IF
      *
      *    個別指示削除処理
           INITIALIZE                  SYS-2002-REC
           MOVE    "2002"              TO  SYS-2002-KANRICD
           MOVE    "001"               TO  SYS-2002-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-2002-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               INITIALIZE                      SYS-2002-REC
               MOVE    "2002"                  TO  SYS-2002-KANRICD
               MOVE    SYS-2002-REC            TO  MCPDATA-REC
               MOVE    SPA-SYSYMD              TO  ORC-DBYMD
               MOVE    "DBDELETE"              TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY2"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"              USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
      *
               IF      MCP-RC              NOT =   ZERO 
                   MOVE    "1001"                  TO  SPA-ERRCD
                   DISPLAY "SYSKANRI-KEY =>" SYS-2002-KEY 
                   GO  TO  450-KOUSHIN-EXT
               END-IF
           END-IF
      *
      *    個別指示登録処理
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       SPA-GMN-MAX 
                   INITIALIZE                  SYS-2002-REC
                   MOVE    "2002"              TO  SYS-2002-KANRICD
                   MOVE    IDX (2:3)           TO  SYS-2002-KBNCD
                   MOVE    ZERO                TO  SYS-2002-STYUKYMD
                   MOVE    ALL "9"             TO  SYS-2002-EDYUKYMD
                   MOVE    SPA-GMN-TPTNUM(IDX) TO  SYS-2002-PTNUM
                   MOVE    SPA-NAI-TPTID (IDX) TO  SYS-2002-PTID
                   MOVE    SPA-NAI-TSRYYM(IDX) TO  SYS-2002-SRYYM
                   MOVE    SPA-GMN-TNYUGAIKBN(IDX)
                                               TO  SYS-2002-NYUGAIKBN
                   MOVE    SYS-2002-REC        TO  MCPDATA-REC
                   MOVE    "DBINSERT"          TO  MCP-FUNC
                   MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
      *
                   IF      MCP-RC          NOT =   ZERO 
                       MOVE    "1002"              TO  SPA-ERRCD
                       DISPLAY "2002 SYSKANRI-KEY =>" SYS-2002-KEY 
                       GO  TO  450-KOUSHIN-EXT
                   END-IF
           END-PERFORM
      *
      *----(01.00.05) LINE ADD START ----------------------------------
      ***     MOVE    "DBCOMMIT"          TO  MCP-FUNC
      ***     CALL    "ORCMCPSUB"          USING
      ***                                  MCPAREA
      ***                                  ORCMCPAREA
      ***                                  MCPDATA-REC
      *----(01.00.05) LINE ADD END   ----------------------------------
      *
      *    ジョブ開始セット
           MOVE    "DEL"               TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID  TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                       TO  JOB-SHELLID
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA 
                                       JOBKANRI-REC
      *
           MOVE    "JBS"               TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID  TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                       TO  JOB-SHELLID
           MOVE    SPA-TERMID          TO  JOB-TERMID                        
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA 
                                       JOBKANRI-REC
      *
      *****印刷用スクリプト処理
      *     EVALUATE    SPA-R01-RECEKBN
      *         WHEN    "0"
      *             MOVE    "recept1.sh"        TO  SHELL-SHELL
      *         WHEN    "3"
      *             MOVE    "recept6.sh"        TO  SHELL-SHELL
      *         WHEN    "4"
      *             MOVE    "recept8.sh"        TO  SHELL-SHELL
      *     END-EVALUATE        
      *     MOVE   SHELL-NAME          TO  SHELL-NAME
      *     
      *    MOVE    ZERO                TO  SHELL-SRYYM
      *    MOVE    SPA-TERMID          TO  SHELL-TERMID
      *    MOVE    SPA-SYSYMD          TO  SHELL-SYSYMD
      *     
      *    MOVE    "2"                 TO  SHELL-SYOKBN
      *     
      **** MOVE    "0"                 TO  SHELL-RECEKBN
      *****MOVE    SPA-R01-RECEKBN     TO  SHELL-RECEKBN
      *     
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    SPA-TERMID          TO  RECEERR-TERMID
      *****MOVE    RECEERR             TO  SHELL-ERRFILE
      *
           OPEN    OUTPUT   RECEERR-FILE
           CLOSE   RECEERR-FILE
      *
      *    県番号の取得
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"          TO  SYS-1001-KANRICD
           MOVE    "*"             TO  SYS-1001-KBNCD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYS-1001-REC    TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI    =   ZERO
               MOVE   MCPDATA-REC  TO  SYS-1001-REC
           ELSE
               MOVE   SPACE        TO  SYS-1001-REC
           END-IF
      *
      *    カスタマイズＰＧ・レセ電情報の設定
           INITIALIZE                  SYS-2005-REC
           MOVE    "2005"          TO  SYS-2005-KANRICD
           MOVE    "*"             TO  SYS-2005-KBNCD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYS-2005-REC    TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI    =   ZERO
               MOVE   MCPDATA-REC  TO  SYS-2005-REC
           ELSE
               MOVE   SPACE        TO  SYS-2005-REC
           END-IF
           IF      SYS-2005-PREFPRGID (1) (1:1)
                                   NOT =  "S"
                   MOVE  "NOPG"    TO  SYS-2005-PREFPRGID (1)
           END-IF
           IF      SYS-2005-PREFPRGID (2) (1:1)
                                   NOT =  "S"
                   MOVE  "NOPG"    TO  SYS-2005-PREFPRGID (2)
           END-IF
                   IF      SYS-2005-KKHRECEKBN =   SPACE
                       MOVE    ZERO            TO  SYS-2005-KKHRECEKBN      
                   END-IF
                   IF      SYS-2005-SYARECEKBN =   SPACE
                       MOVE    ZERO            TO  SYS-2005-SYARECEKBN      
                   END-IF
      *
      *    作成日・時間の設定
           ACCEPT  SYS-YMD         FROM    DATE
           COMPUTE WRK-SYSYY       =   SYS-YY      +   2000
           MOVE    SYS-MM              TO  WRK-SYSMM
           MOVE    SYS-DD              TO  WRK-SYSDD
           ACCEPT  SYS-TIME            FROM    TIME
      *
           MOVE    SPACE           TO  SHELLTBL
           EVALUATE    SPA-R01-RECEKBN
               WHEN    "0"
                   IF      SPA-R01-NYUGAIKBN   =   "1"
                       MOVE    "recept9.sh"    TO  WRK-SHELL-SHELL
                   ELSE
                       MOVE    "recept1.sh"    TO  WRK-SHELL-SHELL
                   END-IF                        
               WHEN    "3"
                   IF      SPA-R01-NYUGAIKBN   =   "1"
                       MOVE    "recept10.sh"   TO  WRK-SHELL-SHELL
                   ELSE
                       MOVE    "recept6.sh"    TO  WRK-SHELL-SHELL
                   END-IF
               WHEN    "4"
                   IF      SPA-R01-NYUGAIKBN   =   "1"
                       MOVE    "recept11.sh"   TO  WRK-SHELL-SHELL
                   ELSE
                       MOVE    "recept8.sh"    TO  WRK-SHELL-SHELL
                   END-IF
           END-EVALUATE        
      *    ファイルデイレクトリ位置指定
           INITIALIZE              ORCSMKPASSAREA
           MOVE    WRK-SHELL-NAME  TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *     
           MOVE    ZERO            TO  WRK-SHELL-SRYYM
           MOVE    SPA-TERMID      TO  WRK-SHELL-TERMID
           MOVE    SPA-SYSYMD      TO  WRK-SHELL-SYSYMD
           MOVE    WRK-SHELL-ARG1  TO  SHELLTBL-ARG1
           MOVE    "2"             TO  SHELLTBL-ARG2
           MOVE    SPA-R01-RECEKBN TO  SHELLTBL-ARG3
           MOVE    RECEERR         TO  SHELLTBL-ARG4
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  SHELLTBL-ARG5
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  SHELLTBL-ARG6
           IF      SPA-R01-NYUGAIKBN   =   "1"
               MOVE    SYS-2005-PREFPRGID (2)
                                       TO  SHELLTBL-ARG7
           ELSE
               MOVE    SYS-2005-PREFPRGID (1)
                                       TO  SHELLTBL-ARG7
           END-IF
           MOVE    SPA-NAI-TSRYYM (1)
                                   TO  SHELLTBL-ARG8
           MOVE    WRK-SYSYMD      TO  SHELLTBL-ARG9
           MOVE    SYS-TIME        TO  SHELLTBL-ARG10
           MOVE    SYS-1001-PREFNUM
                                   TO  SHELLTBL-ARG11
           IF      SYS-2005-SYARECEKBN
                                   =   ZERO
               MOVE    "0"             TO  SHELLTBL-ARG12
           ELSE
               MOVE    "1"             TO  SHELLTBL-ARG12
           END-IF
           IF      SYS-2005-KKHRECEKBN
                                   =   ZERO
               MOVE    "0"             TO  SHELLTBL-ARG13
           ELSE
               MOVE    "1"             TO  SHELLTBL-ARG13
           END-IF
           MOVE    SHELLTBL        TO  MCPDATA-REC
           MOVE    "SHELL"         TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL
                                   TO  MCP-PATH
           CALL    "MCPSUB"        USING
                                       MCPAREA
                                       MCPDATA-REC
      *
      *    自動的に情報確認画面を表示
           PERFORM 490-KAKUNIN-SEC      
           .
       450-KOUSHIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷画面へ遷移
      *****************************************************************
       4501-NEXT-GMN-SEC            SECTION.
      *
      *    画面移行用のパラメタ変更
      *
           MOVE    SPA-NAI-TSRYYM (1)  TO  SPA-R01-SRYYM
      *
           MOVE    SPA-R01KYOUTU       TO  SPA-WORK       
      * 
           MOVE    "R01"               TO  SPA-MOTOPG
      *
           IF      SPA-R01-RECEKBN     =   "0" OR  "1" OR  "2"
               MOVE    "R02"               TO  SPA-SAKIPG
           ELSE  
               MOVE    "R04"               TO  SPA-SAKIPG
           END-IF    
      *
      ***  MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           MOVE   SPA-SAKIPG           TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       4501-NEXT-GMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理確認処理
      *****************************************************************
       490-KAKUNIN-SEC            SECTION.
      *
           MOVE    SPACE               TO  R99
           MOVE    ZERO                TO  R99-COUNT
                                           R99-PROGRESSBAR-VALUE  
      *
      *    ジョブ管理チェック処理
           MOVE    "CHK"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA 
                                   JOBKANRI-REC 
           IF      SJOBKANRI-RETURN
                                   =   ZERO
               MOVE    1               TO  IDX                     
               MOVE    JOB-JOBID       TO  R99-RENNUM   (IDX)
               MOVE    JOB-SHELLMSG    TO  R99-SHORINM  (IDX)
               MOVE    JOB-STARTTIME(1:2)
                                       TO  WRK-HH
               MOVE    JOB-STARTTIME(3:2)
                                       TO  WRK-MM
               MOVE    JOB-STARTTIME(5:2)
                                       TO  WRK-SS
               MOVE    WRK-HENTIME     TO  R99-STARTTIME(IDX)
               MOVE    JOB-ENDTIME(1:2)
                                       TO  WRK-HH
               MOVE    JOB-ENDTIME(3:2)
                                       TO  WRK-MM
               MOVE    JOB-ENDTIME(5:2)
                                       TO  WRK-SS
               MOVE    WRK-HENTIME     TO  R99-ENDTIME  (IDX)
               MOVE    JOB-YOBI        TO  R99-ERRMSG   (IDX)
               IF      JOB-ENDYMD      =   SPACE
                   MOVE    "処理中です"    TO  R99-MSG
               ELSE
                   IF      JOB-ERRCD       =   SPACE
                     IF      JOB-UPDCNT      =   ZERO    
                         MOVE    "対象データがありませんでした"
                                                       TO  R99-MSG
                     ELSE
                       PERFORM 4501-REPRINT-CHK-SEC
                       IF      SPA-RECE07-PRTID    =   SPACE
                           MOVE    "対象のレセプトが作成されていません"
                                               TO  R99-MSG
                       ELSE                    
                           MOVE    SPA-RECE07-KEY
                                          TO  SPA-R01-RECE07-KEY
                           MOVE    SPA-RECE07-RECEKBN
                                          TO  SPA-R01-RECE07-RECEKBN
                           MOVE    SPA-RECE07-SRYYM
                                          TO  SPA-R01-RECE07-SRYYM
                           MOVE    SPA-RECE07-NYUGAIKBN
                                          TO  SPA-R01-RECE07-NYUGAIKBN
                       END-IF
                     END-IF
                   ELSE
                       STRING  JOB-YOBI    DELIMITED  BY  SPACE
                               "【"        DELIMITED  BY  SIZE
                              JOB-SHELLMSG DELIMITED  BY  SPACE
                              "】"         DELIMITED  BY  SIZE      
                                           INTO  R99-MSG
                   END-IF                          
               END-IF    
               MOVE    IDX                     TO  R99-COUNT    
           END-IF
      *     
           MOVE    WIDGET-INSENSITIVE   TO  R99-B12-STATE
           IF      R99-MSG              =   SPACE
               IF      R99-COUNT            >   ZERO    
                   MOVE    WIDGET-NORMAL        TO  R99-B12-STATE
                   MOVE    "B12"                TO  MCP-WIDGET
                   MOVE    "処理は正常に終了しました"
                                                TO  R99-MSG
               ELSE
                   MOVE    "B01"                TO  MCP-WIDGET
                   MOVE    "該当する処理はありません"
                                                TO  R99-MSG
               END-IF                                 
           ELSE                                        
               MOVE    "B11"                TO  MCP-WIDGET
           END-IF                                 
      *
           MOVE    "R01"                TO  SPA-MOTOPG
           MOVE    "R99"                TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "R99"                TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
           .
       490-KAKUNIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    氏名検索へ
      *****************************************************************
       480-KENSAKU-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-R01             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "R01"               TO  SPA-MOTOPG
           MOVE    "P97"               TO  SPA-SAKIPG
      *
      *    氏名をクリアする
           MOVE    SPACE               TO  SPA-NAME
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
           MOVE    "P97"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       480-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    情報削除画面へ
      *****************************************************************
       490-JYOUHOU-DEL-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-R01             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "R01"               TO  SPA-MOTOPG
           MOVE    "XB01"              TO  SPA-SAKIPG
      *
           MOVE    WRK-CONS-JOB-SHELLID
                                       TO  SPA-JOB-SHELLID
      *          
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   "XB01   "            TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       490-JYOUHOU-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC         SECTION.
      *
           IF      WRK-YM          =   SPACE
               MOVE    SPA-NAI-HYO-SRYYM   TO  WRK-SYMD    (1:6)
               MOVE    SPA-NAI-HYO-SRYYMH  TO  WRK-HENYMDG (1:6)
               GO  TO  5002-HIZUKE-CHK-EXT
           END-IF
      * 
           IF      WRK-YM   (1:5)  NOT NUMERIC
               INSPECT     WRK-YM       REPLACING   ALL " " BY  "0"         
               MOVE    WRK-YM(1:1)      TO  WRK-WGO
               MOVE    WRK-YM(2:2)      TO  WRK-WYY
               MOVE    WRK-YM(5:2)      TO  WRK-WMM
           ELSE
               MOVE    WRK-YM(1:5)      TO  WRK-WYMD (1:5)
           END-IF
           MOVE    "01"             TO  WRK-WDD
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY1-AREA
           MOVE    "12"                TO  LNK-DAY1-IRAI
           MOVE    ZERO                TO  LNK-DAY1-YMD
           MOVE    WRK-WYMD            TO  LNK-DAY1-YMD(2:7)
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY1-AREA
           IF      STS-DAY-RC1     NOT =   ZERO
               MOVE    "0001"          TO  SPA-ERRCD
           ELSE
               MOVE    LNK-DAY1-YMD        TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
           END-IF
           .
       5002-HIZUKE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    和暦西暦変換編集処理
      *****************************************************************
       5002-HIZUKE-HEN-SEC          SECTION.
      *
           IF      WRK-SYMD            =   ALL "9"  OR   SPACE
               MOVE    SPACE               TO  WRK-HGO
               MOVE    WRK-SYMD(3:2)       TO  WRK-HYY
               MOVE    WRK-SYMD(5:2)       TO  WRK-HMM
               MOVE    WRK-SYMD(7:2)       TO  WRK-HDD
               MOVE    WRK-HENYMD          TO  WRK-HENYMDG
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
           END-IF
      *
           .
       5002-HIZUKE-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-RIDCD       NOT =   SPACE
               PERFORM 520-RIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-RIDCD2      NOT =   SPACE
               PERFORM 530-RIDSET2-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "R01    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      * 
           MOVE    SPACE               TO  R01
      *
           MOVE    SPA-GMN-SYOKBN      TO  R01-SYOKBN
           MOVE    "red"               TO  R01-SYOKBN-STYLE
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX                 >   SPA-GMN-MAX
               IF      SPA-GMN-TRENNUM    (IDX)    NOT =   ZERO
                   MOVE    SPA-GMN-TRENNUM    (IDX)
                                               TO  WRK-NUM
                   MOVE    WRK-NUM             TO  R01-TRENNUM   (IDX)
               END-IF
               MOVE    SPA-GMN-TSRYYM     (IDX)
                                               TO  R01-TSRYYM    (IDX)
               MOVE    SPA-GMN-TPTNUM     (IDX)
                                               TO  R01-TPTNUM    (IDX)
               MOVE    SPA-GMN-TNAME      (IDX)
                                               TO  R01-TNAME     (IDX)
               MOVE    SPA-GMN-TNYUGAIKBN (IDX)
                                               TO  R01-TNYUGAIKBN(IDX)
      *         
               IF      IDX             =   SPA-NAI-SELNO
                   MOVE    "T"             TO  R01-SELECT (IDX)
               ELSE
                   MOVE    "F"             TO  R01-SELECT (IDX)
               END-IF
           END-PERFORM
           MOVE    SPA-GMN-MAX            TO  R01-COUNT
      *
           MOVE    SPA-GMN-RENNUM         TO  R01-RENNUM
           MOVE    SPA-GMN-PTNUM          TO  R01-PTNUM
           MOVE    SPA-GMN-NAME           TO  R01-NAME
           MOVE    SPA-GMN-SRYYM         TO  R01-SRYYM
           MOVE    SPA-GMN-NYUGAIKBN      TO  R01-NYUGAIKBN
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
         EVALUATE    SPA-GMN-CUR
             WHEN    3
                    MOVE  "RENNUM"     TO  MCP-WIDGET
             WHEN    4
                    MOVE  "PTNUM"      TO  MCP-WIDGET
             WHEN    5
                    MOVE  "SRYYM"     TO  MCP-WIDGET
             WHEN    6
                    MOVE  "NYUGAIKBN"  TO  MCP-WIDGET
             WHEN    7
                    MOVE  "B12"        TO  MCP-WIDGET   
         END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "入力エラーです"            TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "追加できません"            TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "ＩＤ取得サブでエラー"      TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "対象のデータを選択してありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "対象のデータが選択してあります"
                                                       TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "対象の診療会計がありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE
                       "改正前と改正後のレセプトは同時に処理できません"
                                                       TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "対象のデータが入力してありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0011"
                   MOVE    "前回は個別作成のデータではありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0012"
                   MOVE    "前回とはレセプトの種類が違います"
                                                       TO  SPA-ERRMSG
               WHEN    "0013"
                   MOVE    "前回とは入外区分が違います"
                                                       TO  SPA-ERRMSG
               WHEN    "0015"
                   MOVE    "対象のレセプトが作成されいてません"
                                                       TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "レセプト指示コード（個別）が削除できません"
                                                       TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "レセプト指示コード（個別）が更新できません"
                                                       TO  SPA-ERRMSG
               WHEN    "1003"
                   MOVE    "レセプト指示コード（管理）が更新できません"
                                                       TO  SPA-ERRMSG
               WHEN    "7777"
                   MOVE    WRK-RECEERR                 TO  SPA-ERRMSG
               WHEN    "9999"
                   MOVE    WRK-RECEERR                 TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  RERR
           MOVE    SPA-ERRCD            TO  RERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  RERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "R01"                TO  SPA-MOTOPG
           MOVE    "RERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "RERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       510-ERRMSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       520-RIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-RIDMSG
      *
           EVALUATE    SPA-RIDCD
               WHEN    "1002"
                   MOVE    "個別作成で作表します"        TO  WRK-RIDMSG
               WHEN    "1003"
                   MOVE    "入力をすべてクリアします"    TO  WRK-RIDMSG
               WHEN    "1004"
                   MOVE    "前回個別作成分を表示します"  TO  WRK-RIDMSG
               WHEN    "6666"
                   MOVE    "レセプト作成処理中です"      TO  WRK-RIDMSG
               WHEN    "9999"
                   MOVE    WRK-RECEERR                 TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  RID1
           MOVE    SPA-RIDCD            TO  RID1-ID1CODE
           MOVE    WRK-RIDMSG           TO  RID1-ID1MSG
           MOVE    "戻る"               TO  RID1-B01-LABEL
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "R01"                TO  SPA-MOTOPG
           MOVE    "RID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "RID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-RIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       530-RIDSET2-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-RIDMSG
      *
           EVALUATE    SPA-RIDCD2
               WHEN    "8888"
                   MOVE    "レセプト作成が正常終了しました"
                                                       TO  WRK-RIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  RID2
           MOVE    SPA-RIDCD2           TO  RID2-ID1CODE
           MOVE    WRK-RIDMSG           TO  RID2-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "R01"                TO  SPA-MOTOPG
           MOVE    "RID2"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "RID2"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       530-RIDSET2-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト管理読込（キー）
      *****************************************************************
       900-RECE07-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
      *****MOVE    "RECEKANRI-KEY2"    TO  ORC-DBPATH
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
      *****    MOVE    "RECEKANRI-KEY2"    TO  ORC-DBPATH
               MOVE    WRK-PATH            TO  ORC-DBPATH
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
      *****MOVE    "RECEKANRI-KEY2"    TO  ORC-DBPATH
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-RECE07-INV-EXT.
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
               CALL    "ORCMCPSUB"          USING
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
      *    管理マスター読込（キー）
      *****************************************************************
       900-SYSKANRI-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-SYSKANRI
               ELSE
                   MOVE    1                   TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-SYSKANRI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ　ＲＥＡＤ
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為マスタ読込
      *****************************************************************
       910-SRYACCT-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACCT-KEY9"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SRYACCT-KEY9"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-SRYACCT
                   MOVE    MCPDATA-REC         TO  SRYACCT-REC
               ELSE
                   MOVE    1                   TO  FLG-SRYACCT
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SRYACCT
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYACCT-KEY9"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       910-SRYACCT-INV-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    診療行為マスタ　ＲＥＡＤ
      *****************************************************************
       900-SRYACCT-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-SRYACCT
               MOVE    MCPDATA-REC         TO  SRYACCT-REC
           ELSE
               MOVE    1               TO  FLG-SRYACCT
           END-IF
      *
           IF      FLG-SRYACCT         =   ZERO
               MOVE    ACCT-PTID           TO  KEY-N-PTID 
               MOVE    ACCT-HKNCOMBI       TO  KEY-N-HKNCOMBI
               MOVE    ACCT-SRYKA          TO  KEY-N-SRYKA
           END-IF
           .
       900-SRYACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスタ　ＲＥＡＤ
      *****************************************************************
       900-NYUINACCT-READ-SEC          SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-NYUINACCT
               MOVE    MCPDATA-REC         TO  NYUINACCT-REC
           ELSE
               MOVE    1               TO  FLG-NYUINACCT
           END-IF
      *
           IF      FLG-NYUINACCT       =   ZERO
               MOVE    NACCT-PTID          TO  KEY-N-PTID 
      *********MOVE    NACCT-HKNCOMBI      TO  KEY-N-HKNCOMBI
               MOVE    NACCT-SRYKA         TO  KEY-N-SRYKA
           END-IF
           .
       900-NYUINACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスタ読込
      *****************************************************************
       910-HKNCOMBI-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-HKNCOMBI
                   MOVE    MCPDATA-REC         TO  HKNCOMBI-REC
                   IF      COMB-DELKBN         =   "1"
                       MOVE    1                   TO  FLG-HKNCOMBI
                   END-IF
               ELSE
                   MOVE    1                   TO  FLG-HKNCOMBI
                   INITIALIZE                      HKNCOMBI-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-HKNCOMBI
               INITIALIZE                      HKNCOMBI-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       910-HKNCOMBI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL   "ORCMCPSUB"   USING
                                MCPAREA
                                ORCMCPAREA
                                MCPDATA-REC.
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
      *
