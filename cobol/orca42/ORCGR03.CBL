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
       PROGRAM-ID.             ORCGR03.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト
      *  コンポーネント名  : レセプト作成−作成指示（Ｒ０３）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/07/16  日付画面用チェックサブ追加
      *  01.01.01    MCC-藤原     01/09/21  JOINの修正      
      *  01.01.02    MCC-小豆沢   01/11/28  SPA-TERMIDの桁数変更に伴う
      *                                     部分参照に変更      
      *  01.02.01    MCC-藤原     02.01.31  ジョブ管理ＤＢの追加
      *                                     Ｆ８の追加
      *  01.02.02    MCC-藤原     02/02/19  処理中でも処理を終了できるように
      *                                     修正
      *  01.02.03    MCC-藤原     02/02/21  処理中のときのメッセージに
      *                                     プログラム名も表示
      *  01.02.04    MCC-藤原     02/02/26  レセプト管理ファイルを
      *                                     索引ファイルからＤＢへ変更
      *  01.03.01    MCC-藤原     02/05/30  情報削除ボタン追加
      *  01.03.02    MCC-藤原     02/06/06  処理結果画面追加
      *  01.03.03    MCC-藤原     02/06/13  労災・自賠責の項目を追加
      *  01.03.04    MCC-藤原     02/07/09  生活保護まとめ入力画面追加
      *  01.03.05    NACL-藤原    02/07/18  確定のとき自動的に情報確認画面を表示
      *  01.03.06    NACL-藤原    02.08.30  タイマー機能の追加
      *
      *  01.04.01    NACL-藤原    02/09/12  ディレクトリをサブプロへ
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 

      *
       WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル シェル領域 
      *****COPY    "CPCOMMONSHELL1.INC".
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03                      PIC X(04)   VALUE   ".dat".
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
       01  SPA-R03.
           03  SPA-R03-AREA.
               05  SPA-GMN-MAX                     PIC 9(04).
               05  SPA-GMN-PAGE                    PIC 9(02).
               05  SPA-GMN-CUR                     PIC 9(02).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-SYOKBN              PIC X(01).
                   07  SPA-GMN-SYOKBN-LABEL        PIC X(20).
      *----(01.00.01) LINE UPD START ----------------------------------
      ********     07  SPA-GMN-SRYYM               PIC X(06).
                   07  SPA-GMN-SRYYM               PIC X(07).
      *----(01.00.01) LINE UPD END   ----------------------------------
                   07  SPA-GMN-IKKATU              PIC X(01).
                   07  SPA-GMN-KOBETU              PIC X(01).
      *
                   07  SPA-DATAKBN.         
                       09  SPA-DATAKBN1-VALUE      PIC X(01).
                       09  SPA-DATAKBN2-VALUE      PIC X(01).
                       09  SPA-DATAKBN3-VALUE      PIC X(01).
                       09  SPA-DATAKBN11-VALUE     PIC X(01).
                       09  SPA-DATAKBN21-VALUE     PIC X(01).
                       09  SPA-DATAKBN22-VALUE     PIC X(01).
                       09  SPA-DATAKBN23-VALUE     PIC X(01).
                       09  SPA-DATAKBN31-VALUE     PIC X(01).
      *
               05  SPA-NAIB-R03-AREA.
                   07  SPA-NAI-SRYYM               PIC 9(06).
                   07  SPA-NAI-SRYYMH              PIC X(16).
      *
       01  SPA-RECE07-REC. 
           COPY    "CPRCF007.INC"  REPLACING  //RECE07//
                                   BY         //SPA-RECE07//.
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECEERR         PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-RECE07          PIC 9(01).
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
      *
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-RECEERR         PIC X(200).
           03  WRK-SRYYM           PIC X(06).
           03  WRK-CREYMD          PIC X(08).
           03  WRK-RIDMSG          PIC X(70).
           03  WRK-YM              PIC X(07). 
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
      *     
           03  WRK-SHELL-ARG1.
             05  WRK-SHELL-SRYYM   PIC  X(06).
             05  WRK-SHELL-TERMID  PIC  X(16).
             05  WRK-SHELL-SYSYMD  PIC  X(08).  
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMDG3        PIC X(22).
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
       01  WRK-SHELL-NAME.
           05  FILLER             PIC X(16) VALUE
                                             "scripts/monthly/".
           05  WRK-SHELL-SHELL    PIC X(20).         
      *              
      *
       01  WRK-CONS-AREA.
      *    ジョブ管理ＤＢのキー値  
           03  WRK-CONS-JOB-SHELLID
                                   PIC X(08)   VALUE   "RECEPT1".
           03  WRK-CONS-JOB-JOBID  PIC 9(07)   VALUE   1.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK2001.INC".
      *
           COPY    "CPSK2003.INC".
      *
           COPY    "CPSK2005.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    レセプト管理     
       01  RECE07-REC. 
           COPY    "CPRCF007.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
            COPY    "CPORCSDAY.INC".
            COPY    "CPORCSLNK.INC".
      *----(01.00.01) LINE ADD START ----------------------------------
      *
      *   画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".         
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
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-R03
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
           MOVE    SPA-R03         TO  SPA-FREE
      *
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
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
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
      ***  MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "R03    "           TO  MCP-WINDOW.
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
           MOVE    1               TO  SPA-GMN-CUR
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
      *
      *        元の画面へ戻す
               IF      SPA-MOTOPG      =   "XB01"
                   MOVE    LNK-COMMON      TO  SPA-KYOUTU
                   MOVE    LNK-SCRSPA      TO  SPA-R03
                   INITIALIZE              SPA-R01KYOUTU
                   GO  TO  300-SCREEN-EXT
               END-IF
      *         
               MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
      *
               INITIALIZE              SPA-R01KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG
      *    作表処理
               WHEN    "RID1"
                   PERFORM 330-RID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
               WHEN    "R04"
               WHEN    "R02"
               WHEN    "R01"
               WHEN    "R98"
                   PERFORM 350-R02SPASET-SEC
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
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
      *
           INITIALIZE              SPA-R03-AREA
      ***                          SPA-R01KYOUTU
      *
           MOVE    "F"                 TO  SPA-GMN-IKKATU
           MOVE    "F"                 TO  SPA-GMN-KOBETU
           MOVE    "F"                 TO  SPA-DATAKBN1-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN2-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN3-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN11-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN21-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN22-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN23-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN31-VALUE
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
               EVALUATE    SYS-2001-SYOKBN
                   WHEN    "1"
                       MOVE    "T"                 TO  SPA-GMN-IKKATU
                       MOVE    "F"                 TO  SPA-GMN-KOBETU
                   WHEN    "2"
                       MOVE    "F"                 TO  SPA-GMN-IKKATU
                       MOVE    "T"                 TO  SPA-GMN-KOBETU
               END-EVALUATE
               EVALUATE    SYS-2001-SYOKBN ALSO    SYS-2001-RECEKBN
                   WHEN    "1"             ALSO    " "             
                   WHEN    "1"             ALSO    "0"             
                       MOVE    "T"             TO  SPA-DATAKBN1-VALUE
                   WHEN    "1"             ALSO    "1"             
                       MOVE    "T"             TO  SPA-DATAKBN2-VALUE
                   WHEN    "1"             ALSO    "2"             
                       MOVE    "T"             TO  SPA-DATAKBN3-VALUE
                   WHEN    "1"             ALSO    "3"             
                       MOVE    "T"             TO  SPA-DATAKBN11-VALUE
                   WHEN    "1"             ALSO    "7"             
                       MOVE    "T"             TO  SPA-DATAKBN31-VALUE
                   WHEN    "2"             ALSO    " "             
                   WHEN    "2"             ALSO    "0"             
                       MOVE    "T"             TO  SPA-DATAKBN21-VALUE
                   WHEN    "2"             ALSO    "3"             
                       MOVE    "T"             TO  SPA-DATAKBN22-VALUE
                   WHEN    "2"             ALSO    "7"             
                       MOVE    "T"             TO  SPA-DATAKBN23-VALUE
               END-EVALUATE
               IF      SYS-2001-SYOKBN     =   "1"
                   MOVE    SYS-2001-SRYYM      TO  SPA-NAI-SRYYM
                                                   WRK-SYMD (1:6)
                   MOVE    "01"                TO  WRK-SYMD (7:2) 
                   PERFORM 5002-HIZUKE-HEN-SEC
                   MOVE    WRK-HENYMDG(1:6)    TO  SPA-GMN-SRYYM
                   MOVE    WRK-HENYMDG3(1:16)  TO  SPA-NAI-SRYYMH
               END-IF     
           ELSE
               MOVE    "T"                 TO  SPA-GMN-IKKATU
               MOVE    "F"                 TO  SPA-GMN-KOBETU
               MOVE    "T"                 TO  SPA-DATAKBN1-VALUE
           END-IF
      *
           MOVE    "T"                 TO  SPA-GMN-SYOKBN
           EVALUATE    SPA-GMN-SYOKBN
               WHEN    "T"
                   MOVE    "レセプト新規作成" TO  SPA-GMN-SYOKBN-LABEL
               WHEN    "F"
                   MOVE    "作成済レセプト再印刷"
                                              TO  SPA-GMN-SYOKBN-LABEL
           END-EVALUATE      
      *
           IF      SPA-GMN-IKKATU          =   "T" 
               MOVE    7               TO  SPA-GMN-CUR
           ELSE 
               MOVE    2               TO  SPA-GMN-CUR
           END-IF
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
                   PERFORM 450-KOUSHIN-SEC
               END-IF    
           END-IF
      *
           MOVE    SPACE           TO  SPA-RID1-FLG
                                       SPA-R99-FLG
           MOVE    SPACE           TO  SPA-RIDCD
           MOVE    SPACE           TO  SPA-RIDCD2      
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
      *    戻り画面処理
      *****************************************************************
       350-R02SPASET-SEC          SECTION.
      *
           IF      SPA-R01KYOUTU       =   SPACE
               GO  TO  350-R02SPASET-EXT
           END-IF
      *   
           EVALUATE    SPA-R01-FILEKBN
               WHEN    "1"
                   MOVE    "T"                 TO  SPA-GMN-IKKATU
                   MOVE    "F"                 TO  SPA-GMN-KOBETU
               WHEN    "2"
                   MOVE    "F"                 TO  SPA-GMN-IKKATU
                   MOVE    "T"                 TO  SPA-GMN-KOBETU
           END-EVALUATE
      *
           MOVE    "F"                 TO  SPA-DATAKBN1-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN2-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN3-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN11-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN21-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN22-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN23-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN31-VALUE
      *
           EVALUATE    SPA-R01-FILEKBN ALSO    SPA-R01-RECEKBN
               WHEN    "1"             ALSO    " "             
               WHEN    "1"             ALSO    "0"             
                   MOVE    "T"             TO  SPA-DATAKBN1-VALUE
               WHEN    "1"             ALSO    "1"             
                   MOVE    "T"             TO  SPA-DATAKBN2-VALUE
               WHEN    "1"             ALSO    "2"             
                   MOVE    "T"             TO  SPA-DATAKBN3-VALUE
               WHEN    "1"             ALSO    "3"             
                   MOVE    "T"             TO  SPA-DATAKBN11-VALUE
               WHEN    "1"             ALSO    "7"             
                   MOVE    "T"             TO  SPA-DATAKBN31-VALUE
               WHEN    "2"             ALSO    " "             
               WHEN    "2"             ALSO    "0"             
                   MOVE    "T"             TO  SPA-DATAKBN21-VALUE
               WHEN    "2"             ALSO    "3"             
                   MOVE    "T"             TO  SPA-DATAKBN22-VALUE
               WHEN    "2"             ALSO    "7"             
                   MOVE    "T"             TO  SPA-DATAKBN23-VALUE
           END-EVALUATE
      *        
           MOVE    SPA-R01-SRYYM       TO  SPA-NAI-SRYYM
           IF      SPA-R01-SRYYM       =   ZERO
               INITIALIZE                  SPA-GMN-SRYYM
                                           SPA-NAI-SRYYMH
           ELSE   
               MOVE    SPA-R01-SRYYM       TO  WRK-SYMD (1:6)
               MOVE    "01"                TO  WRK-SYMD (7:2) 
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG(1:6)    TO  SPA-GMN-SRYYM
               MOVE    WRK-HENYMDG3(1:16)  TO  SPA-NAI-SRYYMH
           END-IF    
      *
           MOVE    SPA-R01-SYOKBN      TO  SPA-GMN-SYOKBN
           EVALUATE    SPA-GMN-SYOKBN
               WHEN    "T"
                   MOVE    "レセプト新規作成" TO  SPA-GMN-SYOKBN-LABEL
               WHEN    "F"
                   MOVE    "作成済レセプト再印刷"
                                              TO  SPA-GMN-SYOKBN-LABEL
           END-EVALUATE      
      *
           IF      SPA-GMN-IKKATU          =   "T" 
               MOVE    7               TO  SPA-GMN-CUR
           ELSE 
               MOVE    2               TO  SPA-GMN-CUR
           END-IF
           .
       350-R02SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *     戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE    "CHANGE"            TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *     情報削除
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 490-JYOUHOU-DEL-SEC
      *    確定
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 450-TOUROKU-SEC
      *    処理確認
               WHEN    "CLICKED"       ALSO    "B13"
                   PERFORM 490-KAKUNIN-SEC
      *     まとめ入力
               WHEN    "CLICKED"       ALSO    "B09"
                    PERFORM 460-SEH-ENTRY-SEC
      *     印刷区分
               WHEN    "CLICKED"       ALSO    "B07"
                    PERFORM 470-SYOKBN-SEC
               WHEN    "CLICKED"       ALSO    "SYOKBN"
                   PERFORM 410-SYOKBN-CHK-SEC
      *     作成区分
               WHEN    "CLICKED"       ALSO    "B08"
                   MOVE    "F"                 TO  SPA-DATAKBN1-VALUE
                   MOVE    "F"                 TO  SPA-DATAKBN2-VALUE
                   MOVE    "F"                 TO  SPA-DATAKBN3-VALUE
                   MOVE    "F"                 TO  SPA-DATAKBN11-VALUE
                   MOVE    "F"                 TO  SPA-DATAKBN21-VALUE
                   MOVE    "F"                 TO  SPA-DATAKBN22-VALUE
                   MOVE    "F"                 TO  SPA-DATAKBN23-VALUE
                   MOVE    "F"                 TO  SPA-DATAKBN31-VALUE
                   IF      SPA-GMN-IKKATU      =   "T"
                       MOVE    "F"             TO  SPA-GMN-IKKATU
                       MOVE    "T"             TO  SPA-GMN-KOBETU
                       MOVE    "T"             TO  SPA-DATAKBN21-VALUE
                   ELSE
                       MOVE    "T"             TO  SPA-GMN-IKKATU
                       MOVE    "F"             TO  SPA-GMN-KOBETU
                       MOVE    "T"             TO  SPA-DATAKBN1-VALUE 
                   END-IF
                   IF      SPA-GMN-IKKATU      =   "T"
                       MOVE    2                   TO  SPA-GMN-CUR
                   ELSE
                       MOVE    7                   TO  SPA-GMN-CUR    
                   END-IF            
      *    帳票区分１
               WHEN    "CLICKED"       ALSO    "DATAKBN1"
                   PERFORM 400-DATAKBN1-SEC
      *    帳票区分２
               WHEN    "CLICKED"       ALSO    "DATAKBN2"
                   PERFORM 400-DATAKBN2-SEC
      *    帳票区分３
               WHEN    "CLICKED"       ALSO    "DATAKBN3"
                   PERFORM 400-DATAKBN3-SEC
      *    帳票区分１
               WHEN    "CLICKED"       ALSO    "DATAKBN11"
                   PERFORM 400-DATAKBN11-SEC
      *    帳票区分１
               WHEN    "CLICKED"       ALSO    "DATAKBN21"
                   PERFORM 400-DATAKBN21-SEC
      *    帳票区分２
               WHEN    "CLICKED"       ALSO    "DATAKBN22"
                   PERFORM 400-DATAKBN22-SEC
      *    帳票区分３
               WHEN    "CLICKED"       ALSO    "DATAKBN23"
                   PERFORM 400-DATAKBN23-SEC
      *    帳票区分３
               WHEN    "CLICKED"       ALSO    "DATAKBN31"
                   PERFORM 400-DATAKBN31-SEC
      *    一括作成
               WHEN    "CLICKED"       ALSO    "IKKATU"
                   PERFORM 400-IKKATU-SEC
      *    個別作成
               WHEN    "CLICKED"       ALSO    "KOBETU"
                   PERFORM 400-KOBETU-SEC
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
               WHEN    "ACTIVATE"      ALSO    "SRYYM"
                   PERFORM 4101-SRYYM-CHK-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療年月（一括）チェック処理
      *****************************************************************
       4101-SRYYM-CHK-SEC           SECTION.
      *
           MOVE    2                  TO  SPA-GMN-CUR
      *
           IF      SPA-GMN-IKKATU         =   "F"
               MOVE    "0007"             TO  SPA-ERRCD
               MOVE    3                  TO  SPA-GMN-CUR
               GO  TO  4101-SRYYM-CHK-EXT
           END-IF
      *
           MOVE   R03-SRYYM           TO  SPA-GMN-SRYYM
           MOVE    ZERO               TO  SPA-NAI-SRYYM
           MOVE    SPACE              TO  SPA-NAI-SRYYMH
      *
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    "1"                 TO  SGDAY-INTYPE
           MOVE    SPA-GMN-SRYYM       TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                       ORCSGDAYAREA
           IF      SGDAY-RC            =   ZERO
               MOVE    SGDAY-OTDAY(1:6)    TO  SPA-GMN-SRYYM
               MOVE    SGDAY-SDAY (1:6)    TO  SPA-NAI-SRYYM
           ELSE
               MOVE    "0001"          TO  SPA-ERRCD
               GO  TO  4101-SRYYM-CHK-EXT
           END-IF
           MOVE    SGDAY-SDAY         TO  WRK-SYMD
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG3(1:16)   TO  SPA-NAI-SRYYMH
      *----(01.00.01) LINE MOD END   ----------------------------------
      *
           MOVE    7                   TO  SPA-GMN-CUR
      *
           .
       4101-SRYYM-CHK-EXT.
           EXIT.
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
           MOVE    "M01"               TO  SPA-SAKIPG
           MOVE    "R03"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  SPA-WORK 
           INITIALIZE                  SPA-KYOTUKEY
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
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
      *    処理区分  入力処理
      *****************************************************************
       410-SYOKBN-CHK-SEC                SECTION.
      *   
           MOVE    1                   TO  SPA-GMN-CUR
      *
           MOVE    R03-SYOKBN-VALUE    TO  SPA-GMN-SYOKBN
           EVALUATE    SPA-GMN-SYOKBN
               WHEN    "T"
                   MOVE    "レセプト新規作成" TO  SPA-GMN-SYOKBN-LABEL
               WHEN    "F"
                   MOVE    "作成済レセプト再印刷"
                                              TO  SPA-GMN-SYOKBN-LABEL
           END-EVALUATE      
      *     
           MOVE    2               TO  SPA-GMN-CUR
           .
       410-SYOKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票区分１選択処理
      *****************************************************************
       400-DATAKBN1-SEC          SECTION.
      *
           MOVE    R03-DATAKBN1  TO  SPA-DATAKBN1-VALUE
      *
           MOVE    "T"           TO  SPA-GMN-IKKATU
           MOVE    "F"           TO  SPA-GMN-KOBETU
      *
           MOVE    2             TO  SPA-GMN-CUR     
           .
       400-DATAKBN1-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    帳票区分２選択処理
      *****************************************************************
       400-DATAKBN2-SEC          SECTION.
      *
           MOVE    R03-DATAKBN2  TO  SPA-DATAKBN2-VALUE
      *
           MOVE    "T"           TO  SPA-GMN-IKKATU
           MOVE    "F"           TO  SPA-GMN-KOBETU
      *
           MOVE    2             TO  SPA-GMN-CUR     
           .
       400-DATAKBN2-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票区分３選択処理
      *****************************************************************
       400-DATAKBN3-SEC          SECTION.
      *
           MOVE    R03-DATAKBN3 TO  SPA-DATAKBN3-VALUE
      *
           MOVE    "T"           TO  SPA-GMN-IKKATU
           MOVE    "F"           TO  SPA-GMN-KOBETU
      *
           MOVE    2             TO  SPA-GMN-CUR     
           .
       400-DATAKBN3-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票区分１選択処理
      *****************************************************************
       400-DATAKBN11-SEC          SECTION.
      *
           MOVE    R03-DATAKBN11  TO  SPA-DATAKBN11-VALUE
      *
           MOVE    "T"           TO  SPA-GMN-IKKATU
           MOVE    "F"           TO  SPA-GMN-KOBETU
      *
           MOVE    2             TO  SPA-GMN-CUR     
           .
       400-DATAKBN1-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票区分３選択処理
      *****************************************************************
       400-DATAKBN31-SEC          SECTION.
      *
           MOVE    R03-DATAKBN31 TO  SPA-DATAKBN31-VALUE
      *
           MOVE    "T"           TO  SPA-GMN-IKKATU
           MOVE    "F"           TO  SPA-GMN-KOBETU
      *
           MOVE    2             TO  SPA-GMN-CUR     
           .
       400-DATAKBN31-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票区分１選択処理
      *****************************************************************
       400-DATAKBN21-SEC          SECTION.
      *
           MOVE    R03-DATAKBN21  TO  SPA-DATAKBN21-VALUE
      *
           MOVE    "F"           TO  SPA-GMN-IKKATU
           MOVE    "T"           TO  SPA-GMN-KOBETU
      *
           MOVE    7             TO  SPA-GMN-CUR     
           .
       400-DATAKBN21-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    帳票区分２選択処理
      *****************************************************************
       400-DATAKBN22-SEC          SECTION.
      *
           MOVE    R03-DATAKBN22  TO  SPA-DATAKBN22-VALUE
      *
           MOVE    "F"           TO  SPA-GMN-IKKATU
           MOVE    "T"           TO  SPA-GMN-KOBETU
      *
           MOVE    7             TO  SPA-GMN-CUR     
           .
       400-DATAKBN22-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票区分３選択処理
      *****************************************************************
       400-DATAKBN23-SEC          SECTION.
      *
           MOVE    R03-DATAKBN23 TO  SPA-DATAKBN23-VALUE
      *
           MOVE    "F"           TO  SPA-GMN-IKKATU
           MOVE    "T"           TO  SPA-GMN-KOBETU
      *
           MOVE    7             TO  SPA-GMN-CUR     
           .
       400-DATAKBN23-EXT.
           EXIT.
      *
      *****************************************************************
      *    一括作成選択処理
      *****************************************************************
       400-IKKATU-SEC          SECTION.
      *
           MOVE    R03-IKKATU  TO  SPA-GMN-IKKATU
      *     
           MOVE    "T"                 TO  SPA-DATAKBN1-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN2-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN3-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN11-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN21-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN22-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN23-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN31-VALUE
      *
           MOVE    2             TO  SPA-GMN-CUR     
           .
       400-IKKATU-EXT.
           EXIT.
      *
      *****************************************************************
      *    個別作成選択処理
      *****************************************************************
       400-KOBETU-SEC          SECTION.
      *
           MOVE    R03-KOBETU  TO  SPA-GMN-KOBETU
      *     
           MOVE    "F"                 TO  SPA-DATAKBN1-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN2-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN3-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN11-VALUE
           MOVE    "T"                 TO  SPA-DATAKBN21-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN22-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN23-VALUE
           MOVE    "F"                 TO  SPA-DATAKBN31-VALUE
           .
       400-KOBETU-EXT.
           EXIT.
      *
      *****************************************************************
      *    生活保護まとめ入力処理
      *****************************************************************
       460-SEH-ENTRY-SEC       SECTION.
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
           MOVE    "R03"               TO  SPA-MOTOPG
           MOVE    "R98"               TO  SPA-SAKIPG
      *
      *    画面移行用のパラメタ変更
           PERFORM 45011-PARA-HENSYU-SEC
      *
           MOVE    SPA-R01KYOUTU       TO  SPA-WORK       
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   SPA-SAKIPG           TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       460-SEH-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理区分変更処理
      *****************************************************************
       470-SYOKBN-SEC          SECTION.
      *   
           MOVE    1                   TO  SPA-GMN-CUR
      *
           EVALUATE    R03-SYOKBN-VALUE
               WHEN    "T"
                   MOVE    "F"             TO  SPA-GMN-SYOKBN
               WHEN    "F"
                   MOVE    "T"             TO  SPA-GMN-SYOKBN
           END-EVALUATE
      *             
           EVALUATE    SPA-GMN-SYOKBN
               WHEN    "T"
                   MOVE    "レセプト新規作成" TO  SPA-GMN-SYOKBN-LABEL
               WHEN    "F"
                   MOVE    "作成済レセプト再印刷"
                                              TO  SPA-GMN-SYOKBN-LABEL
           END-EVALUATE      
      *     
           MOVE    2               TO  SPA-GMN-CUR
           .
       470-SYOKBN-EXT.
           EXIT.
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
      *    画面移行用のパラメタ変更
           PERFORM 45011-PARA-HENSYU-SEC
      *     
      *    一括作成のときのチェック
           EVALUATE    SPA-GMN-IKKATU
               WHEN    "T"
                   IF      SPA-NAI-SRYYM      =   ZERO
                       MOVE    "0001"              TO  SPA-ERRCD
                       GO  TO  450-TOUROKU-EXT
                   END-IF
           END-EVALUATE
      *   
      *    再印刷のときのチェック
           EVALUATE    SPA-GMN-SYOKBN     
               WHEN    "F"
                   PERFORM 4501-REPRINT-CHK-SEC
      *
                   IF      SPA-RECE07-SRYYM    =   SPACE
                       MOVE    "0002"              TO  SPA-ERRCD
                       GO  TO  450-TOUROKU-EXT
                   ELSE                    
                       MOVE    SPA-RECE07-KEY TO   SPA-R01-RECE07-KEY
                       MOVE    SPA-RECE07-RECEKBN
                                              TO  SPA-R01-RECE07-RECEKBN
                   END-IF    
           END-EVALUATE
      *
      *    ガイドメッセージセット
           IF      SPA-R01-RECEKBN       =   "3"
               EVALUATE    SPA-GMN-SYOKBN    ALSO    SPA-R01-FILEKBN
                   WHEN    "T"               ALSO    "1" 
                       MOVE    "1005"              TO  SPA-RIDCD
                   WHEN    "F"               ALSO    "1"
                       MOVE    "1006"              TO  SPA-RIDCD
                   WHEN    "T"               ALSO    "2" 
                       MOVE    "1007"              TO  SPA-RIDCD
                   WHEN    "F"               ALSO    "2"
                       MOVE    "1008"              TO  SPA-RIDCD
               END-EVALUATE
           ELSE
               EVALUATE    SPA-GMN-SYOKBN    ALSO    SPA-R01-FILEKBN
                   WHEN    "T"               ALSO    "1" 
                       MOVE    "1001"              TO  SPA-RIDCD
                   WHEN    "F"               ALSO    "1"
                       MOVE    "1002"              TO  SPA-RIDCD
                   WHEN    "T"               ALSO    "2" 
                       MOVE    "1003"              TO  SPA-RIDCD
                   WHEN    "F"               ALSO    "2"
                       MOVE    "1004"              TO  SPA-RIDCD
               END-EVALUATE
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
      *
      *
           INITIALIZE                  RECE07-REC
           IF      SPA-R01-RECEKBN     =   "0" OR  "1" OR  "2"
               MOVE    "HC06"              TO  RECE07-PRTID
           ELSE
               IF      SPA-R01-RECEKBN     =   "3"
                   MOVE    "HC21"              TO  RECE07-PRTID
               END-IF
      *???         IF      SPA-R01-RECEKBN     =   "7"
      *???             MOVE    "HC18"              TO  RECE07-PRTID
      *???         END-IF
           END-IF            
           IF      SPA-R01-FILEKBN         =   "1"
               MOVE    SPA-R01-SRYYM       TO  RECE07-SRYYM
           ELSE
               MOVE    ZERO                TO  RECE07-SRYYM
           END-IF
           MOVE    RECE07-REC          TO  MCPDATA-REC
           PERFORM 900-RECE07-INV-SEC
           IF      FLG-RECE07          =   ZERO
               MOVE    RECE07-KEY          TO  SPA-RECE07-KEY
               MOVE    RECE07-RECEKBN      TO  SPA-RECE07-RECEKBN
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
      *    新規分作成のときレセプト指示コード更新
      *
           EVALUATE    SPA-GMN-SYOKBN    ALSO    SPA-GMN-IKKATU
               WHEN    "T"               ALSO    "T"
                   INITIALIZE                  SYS-2001-REC
                   MOVE    "2001"              TO  SYS-2001-KANRICD
                   MOVE    "*"                 TO  SYS-2001-KBNCD
                   MOVE    SPA-SYSYMD          TO  ORC-DBYMD
                   MOVE    SYS-2001-REC        TO  MCPDATA-REC
                   PERFORM 900-SYSKANRI-INV-SEC
                   IF      FLG-SYSKANRI        =   ZERO
                       MOVE    MCPDATA-REC     TO  SYS-2001-REC
                   ELSE
                       INITIALIZE                  SYS-2001-REC
                       MOVE    "2001"          TO  SYS-2001-KANRICD
                       MOVE    "*"             TO  SYS-2001-KBNCD
                       MOVE    ZERO            TO  SYS-2001-STYUKYMD
                       MOVE    ALL "9"         TO  SYS-2001-EDYUKYMD
                   END-IF 
                   MOVE    "1"                 TO  SYS-2001-SYOKBN
                   MOVE    SPA-R01-RECEKBN     TO  SYS-2001-RECEKBN
                   MOVE    SPA-NAI-SRYYM       TO  SYS-2001-SRYYM
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
                       MOVE    "1001"              TO  SPA-ERRCD
                       DISPLAY "2001 SYSKANRI-KEY =>" SYS-2001-KEY 
                       GO  TO  450-KOUSHIN-EXT
                   END-IF
      *
      *            ジョブ開始セット
                   MOVE    "DEL"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    WRK-CONS-JOB-JOBID
                                           TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA 
                                           JOBKANRI-REC
      *
                   MOVE    "JBS"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    WRK-CONS-JOB-JOBID
                                           TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   MOVE    SPA-TERMID      TO  JOB-TERMID                        
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA 
                                          JOBKANRI-REC
      *
      *            印刷用スクリプト処理
      *************EVALUATE    SPA-R01-RECEKBN
      *                WHEN    "0"
      *                WHEN    "1"
      *                WHEN    "2"
      *                    MOVE    "recept1.sh"    TO  SHELL-SHELL
      *                WHEN    "3"
      *                WHEN    "4"
      *                WHEN    "5"
      *                WHEN    "6"
      *                    MOVE    "recept6.sh"    TO  SHELL-SHELL
      *                WHEN    "7"
      *                    MOVE    "recept8.sh"    TO  SHELL-SHELL
      *            END-EVALUATE        
      *            MOVE    SHELL-NAME          TO  SHELL-NAME
      *            
      *            MOVE    SPA-NAI-SRYYM       TO  SHELL-SRYYM
      *            MOVE    SPA-TERMID          TO  SHELL-TERMID
      *            MOVE    SPA-SYSYMD          TO  SHELL-SYSYMD
      *            MOVE    "1"                 TO  SHELL-SYOKBN
      *************MOVE    SPA-R01-RECEKBN     TO  SHELL-RECEKBN
      *****        IF      SPA-DATAKBN1-VALUE  =   "T"
      *                 MOVE    "0"                 TO  SHELL-RECEKBN
      *             ELSE
      *                IF      SPA-DATAKBN2-VALUE  =   "T"
      *                    MOVE    "1"             TO  SHELL-RECEKBN
      *                ELSE
      *                    MOVE    "2"             TO  SHELL-RECEKBN
      *                END-IF
      *****        END-IF
                   MOVE    "RECEERR"           TO  RECEERR-FILE-ID
                   MOVE    SPA-TERMID          TO  RECEERR-TERMID
      *************MOVE    RECEERR             TO  SHELL-ERRFILE
      *
                   OPEN    OUTPUT   RECEERR-FILE
                   CLOSE   RECEERR-FILE
      *
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
      *
      *★★        ETC-EXEC SHELL SHELL-AREA 10
                   MOVE    SPACE           TO  SHELLTBL
                   EVALUATE    SPA-R01-RECEKBN
                       WHEN    "0"
                       WHEN    "1"
                       WHEN    "2"
                           MOVE    "recept1.sh"    TO  WRK-SHELL-SHELL
                       WHEN    "3"
                       WHEN    "4"
                       WHEN    "5"
                       WHEN    "6"
                           MOVE    "recept6.sh"    TO  WRK-SHELL-SHELL
                       WHEN    "7"
                           MOVE    "recept8.sh"    TO  WRK-SHELL-SHELL
                   END-EVALUATE        
      *            ファイルデイレクトリ位置指定
                   INITIALIZE              ORCSMKPASSAREA
                   MOVE    WRK-SHELL-NAME  TO  MKPASS-IN-01
                   CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
                   MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *             
                   MOVE    SPA-NAI-SRYYM   TO  WRK-SHELL-SRYYM
                   MOVE    SPA-TERMID      TO  WRK-SHELL-TERMID
                   MOVE    SPA-SYSYMD      TO  WRK-SHELL-SYSYMD
                   MOVE    WRK-SHELL-ARG1  TO  SHELLTBL-ARG1
                   MOVE    "1"             TO  SHELLTBL-ARG2
                   MOVE    SPA-R01-RECEKBN TO  SHELLTBL-ARG3
                   MOVE    RECEERR         TO  SHELLTBL-ARG4
                   MOVE    WRK-CONS-JOB-JOBID
                                           TO  SHELLTBL-ARG5
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  SHELLTBL-ARG6
                   MOVE    SYS-2005-PREFPRGID (1)
                                           TO  SHELLTBL-ARG7
                   MOVE    SHELLTBL        TO  MCPDATA-REC
                   MOVE    "SHELL"         TO  MCP-FUNC
                   MOVE    PATH-SHELL-SHELL
                                           TO  MCP-PATH
                   CALL    "MCPSUB"        USING
                                               MCPAREA
                                               MCPDATA-REC
      *            情報確認画面を表示                                                   
                   PERFORM 490-KAKUNIN-SEC
                WHEN    OTHER
                    PERFORM 4501-NEXT-GMN-SEC
           END-EVALUATE
      *
           .
       450-KOUSHIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新処理
      *****************************************************************
       4501-NEXT-GMN-SEC            SECTION.       
      * 
           MOVE    "R03"               TO  SPA-MOTOPG
      *
           IF      SPA-RID1-FLG        =   "OK"
               IF      SPA-GMN-SYOKBN      =   "T"     AND
                       SPA-GMN-KOBETU      =   "T"
                   MOVE    "R01"               TO  SPA-SAKIPG
               ELSE
                   IF      SPA-R01-RECEKBN     =   "0" OR  "1" OR  "2"
                       MOVE    "R02"               TO  SPA-SAKIPG
                   ELSE
                       MOVE    "R04"               TO  SPA-SAKIPG
                   END-IF        
               END-IF 
           ELSE
               IF      SPA-R01-RECEKBN     =   "0" OR  "1" OR  "2"
                   MOVE    "R02"               TO  SPA-SAKIPG
               ELSE
                   MOVE    "R04"               TO  SPA-SAKIPG
               END-IF        
           END-IF
      *
      *    画面移行用のパラメタ変更
      *****PERFORM 45011-PARA-HENSYU-SEC
      *
      *****MOVE    SPA-R01KYOUTU       TO  SPA-WORK       
      *
           MOVE   "JOIN"              TO  MCP-PUTTYPE
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
      *    画面移行用のパラメタ変更処理
      *****************************************************************
       45011-PARA-HENSYU-SEC            SECTION.       
      *    
      *****MOVE    SPACE               TO  SPA-R01KYOUTU
      *****INITIALIZE    SPA-R01KYOUTU
      *
           MOVE    SPA-GMN-SYOKBN      TO  SPA-R01-SYOKBN
      *
           MOVE    "0"                 TO  SPA-R01-RECEKBN
           EVALUATE    TRUE
               WHEN    SPA-DATAKBN1-VALUE  =   "T"
                   MOVE    "0"                 TO  SPA-R01-RECEKBN
               WHEN    SPA-DATAKBN2-VALUE  =   "T"
                   MOVE    "1"                 TO  SPA-R01-RECEKBN
               WHEN    SPA-DATAKBN3-VALUE  =   "T"
                   MOVE    "2"                 TO  SPA-R01-RECEKBN
               WHEN    SPA-DATAKBN11-VALUE =   "T"
                   MOVE    "3"                 TO  SPA-R01-RECEKBN
               WHEN    SPA-DATAKBN31-VALUE =   "T"
                   MOVE    "7"                 TO  SPA-R01-RECEKBN
               WHEN    SPA-DATAKBN21-VALUE  =   "T"
                   MOVE    "0"                 TO  SPA-R01-RECEKBN
               WHEN    SPA-DATAKBN22-VALUE  =   "T"
                   MOVE    "3"                 TO  SPA-R01-RECEKBN
               WHEN    SPA-DATAKBN23-VALUE  =   "T"
                   MOVE    "7"                 TO  SPA-R01-RECEKBN
           END-EVALUATE
      *
           IF      SPA-GMN-IKKATU          =   "T"
               MOVE    "1"                 TO  SPA-R01-FILEKBN
           ELSE
               MOVE    "2"                 TO  SPA-R01-FILEKBN
           END-IF
      *
           MOVE    SPA-NAI-SRYYM       TO  SPA-R01-SRYYM
      *
      *
           MOVE    SPA-R01KYOUTU       TO  SPA-WORK       
      *
           .
       45011-PARA-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理確認処理
      *****************************************************************
       490-KAKUNIN-SEC            SECTION.
      *                                      
      *    画面移行用のパラメタ
           PERFORM 45011-PARA-HENSYU-SEC
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
                       PERFORM 4501-REPRINT-CHK-SEC
                       IF      SPA-RECE07-PRTID    =   SPACE
                           MOVE    "対象のレセプトが作成されていません"
                                               TO  R99-MSG
                       ELSE                    
                           MOVE    SPA-RECE07-KEY
                                              TO  SPA-R01-RECE07-KEY
                           MOVE    SPA-RECE07-RECEKBN
                                              TO  SPA-R01-RECE07-RECEKBN
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
           MOVE    "R03"                TO  SPA-MOTOPG
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
      *    情報削除画面へ
      *****************************************************************
       490-JYOUHOU-DEL-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-R03             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "R03"               TO  SPA-MOTOPG
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
               MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG3
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
           MOVE    "R03    "           TO  MCP-WINDOW.
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
           MOVE    SPACE               TO  R03
      *
           MOVE    SPA-GMN-SRYYM       TO  R03-SRYYM
      *
           MOVE    SPA-GMN-SYOKBN         TO  R03-SYOKBN-VALUE
           MOVE    SPA-GMN-SYOKBN-LABEL   TO  R03-SYOKBN-LABEL
           MOVE    SPA-GMN-IKKATU         TO  R03-IKKATU
           MOVE    SPA-GMN-KOBETU         TO  R03-KOBETU
           MOVE    SPA-DATAKBN1-VALUE     TO  R03-DATAKBN1
           MOVE    SPA-DATAKBN2-VALUE     TO  R03-DATAKBN2
           MOVE    SPA-DATAKBN3-VALUE     TO  R03-DATAKBN3
           MOVE    SPA-DATAKBN11-VALUE    TO  R03-DATAKBN11
           MOVE    SPA-DATAKBN31-VALUE    TO  R03-DATAKBN31
           MOVE    SPA-DATAKBN21-VALUE    TO  R03-DATAKBN21
           MOVE    SPA-DATAKBN22-VALUE    TO  R03-DATAKBN22
           MOVE    SPA-DATAKBN23-VALUE    TO  R03-DATAKBN23
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
             WHEN    1
                    MOVE  "SYOKBN"     TO  MCP-WIDGET
             WHEN    2
                    MOVE  "SRYYM"      TO  MCP-WIDGET
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
                   MOVE
                       "作成済のデータがないので再印刷は指定できません"
                                                       TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "対象のデータを選択してありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "対象のデータが選択してあります"
                                                       TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "個別作成のとき入力できません"
                                                       TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "レセプト指示コードが更新できません"
                                                       TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "作成済みの帳票管理ファイルがありません"
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
           MOVE    "R03"                TO  SPA-MOTOPG
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
               WHEN    "1001"
                   MOVE    SPA-NAI-SRYYMH   TO  WRK-RIDMSG
                   MOVE    "分新規作成処理を行います"
                                            TO  WRK-RIDMSG (17:)
               WHEN    "1002"
                   MOVE    SPA-NAI-SRYYMH   TO  WRK-RIDMSG
                   MOVE    "分再印刷処理を行います"
                                            TO  WRK-RIDMSG (17:)
               WHEN    "1003"
                   MOVE    "個別作成分の新規作成処理を行います" 
                                            TO  WRK-RIDMSG
               WHEN    "1004"
                   MOVE    "個別作成分の再印刷処理を行います"
                                            TO  WRK-RIDMSG
               WHEN    "1005"
                   MOVE    SPA-NAI-SRYYMH   TO  WRK-RIDMSG
                   MOVE    "分新規作成処理（労災）を行います"
                                            TO  WRK-RIDMSG (17:)
               WHEN    "1006"
                   MOVE    SPA-NAI-SRYYMH   TO  WRK-RIDMSG
                   MOVE    "分再印刷処理（労災）を行います"
                                            TO  WRK-RIDMSG (17:)
               WHEN    "1007"
                   MOVE    "個別作成分の新規作成処理（労災）を行います" 
                                            TO  WRK-RIDMSG
               WHEN    "1008"
                   MOVE    "個別作成分の再印刷処理（労災）を行います"
                                            TO  WRK-RIDMSG
               WHEN    "6666"
                   MOVE    "レセプト作成処理中です"
                                            TO  WRK-RIDMSG
               WHEN    "8888"
                   MOVE    "レセプト作成が正常終了しました"
                                            TO  WRK-RIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  RID1
           MOVE    SPA-RIDCD            TO  RID1-ID1CODE
           MOVE    WRK-RIDMSG           TO  RID1-ID1MSG
           MOVE    "戻る"               TO  RID1-B01-LABEL
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "R03"                TO  SPA-MOTOPG
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
           MOVE    "R03"                TO  SPA-MOTOPG
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
           MOVE    "RECEKANRI-KEY2"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "RECEKANRI-KEY2"    TO  ORC-DBPATH
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
           MOVE    "RECEKANRI-KEY2"    TO  ORC-DBPATH
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
