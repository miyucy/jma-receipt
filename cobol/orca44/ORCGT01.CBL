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
       PROGRAM-ID.             ORCGT01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 総括表
      *  コンポーネント名  : 総括表作成（Ｔ０１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/08/10  再印刷の追加  
      *  01.00.02    MCC-藤原     01/09/16  請求年月日の追加
      *  01.00.03    MCC-藤原     01/09/19  帳票のエラーが０件のとき表示しない 
      *  01.02.01    MCC-藤原     01/09/21  JOINの修正      
      *  01.02.02    MCC-藤原     02/03/14  決定通知書・未請求一覧の追加      
      *  01.02.03    MCC-藤原     02/03/30  国保診療報酬請求書のパターン別印刷
      *  01.03.01    MCC-藤原     02/04/15  印刷管理・印刷ＤＢ・ジョブ管理ＤＢ
      *                                     の追加
      *  01.03.02    MCC-藤原     02/05/09  処理結果画面に頁数の追加
      *  01.03.03    MCC-藤原     02/05/15  処理前にジョブ管理を削除する
      *  01.03.04    MCC-藤原     02/05/16  再印刷ボタン追加
      *  01.03.05    MCC-藤原     02/05/21  情報削除ボタン追加
      *  01.03.05    MCC-藤原     02/06/04  レセプト処理中は処理できないようにする
      *  01.03.06    NACL-藤原    02/07/25  確定のとき自動的に情報確認画面を表示
      *  01.03.07    NACL-藤原    02/08/30  印刷指示項目の追加
      *  01.03.08    NACL-藤原    02/09/05  端末ＩＤを固定にする
      * 
      *  01.03.09    NACL-藤原    02/09/12  ディレクトリをサブプロへ
      *  01.03.10    NACL-藤原    02/10/07  ２００２年１０月改正対応
      *
      *  01.04.01    NACL-藤原    03/03/05  入院対応
      *  01.04.02    NACL-藤原    03.05.06  地方公費ＤＢ対応済フラグ
      *                                     の追加
      *                                     印刷開始・終了頁の編集の修正
      *  01.04.03    NACL-藤原    03.05.14  印刷する・しないのボタン追加
      *  01.04.04    NACL-藤原    03.05.19  国保総括に個別指定の
      *                                     保険者番号を追加
      * レセ電機能追加
      *  01.05.01    NACL-藤原    03.08.06  レセ電処理の追加
      *  01.05.02    NACL-藤原    03.09.02  メッセージコードの修正
      *  01.05.03    NACL-藤原    03.09.24  レセ電ファイルの出力先指定の修正
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
       WORKING-STORAGE             SECTION.
      *
      *****レセプト明細ファイル シェル領域 
      *****COPY    "CPCOMMONSHELL1.INC".
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
           COPY    "T01COMMON-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-T01.
           03  SPA-T01-AREA.
               05  SPA-GMN-MAX                     PIC 9(04).
               05  SPA-GMN-PAGE                    PIC 9(02).
               05  SPA-GMN-CUR                     PIC 9(02).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-SKYYM               PIC X(07).
                   07  SPA-GMN-SRYYM               PIC X(20).
                   07  SPA-GMN-SKYYMD              PIC X(10).
                   07  SPA-GMN-PRTKBN1.
                       09  SPA-GMN-PRTKBN1-STYLE   PIC X(20).
                       09  SPA-GMN-PRTKBN1-VALUE   PIC X(04). 
                   07  SPA-GMN-PRTKBN2.
                       09  SPA-GMN-PRTKBN2-STYLE   PIC X(20).
                       09  SPA-GMN-PRTKBN2-VALUE   PIC X(04).
                   07  SPA-GMN-HKNJANUM            PIC X(08).
                   07  SPA-GMN-HKNJAMEI            PIC X(40). 
      *
               05  SPA-NAIB-T01-AREA.
                   07  SPA-NAI-WIDGET              PIC X(08). 
                   07  SPA-NAI-SKYYM               PIC 9(06).
                   07  SPA-NAI-SRYYM               PIC 9(06).
                   07  SPA-NAI-SKYYMD              PIC 9(08).
                   07  SPA-NAI-PRTKBN1             PIC X(01).
                   07  SPA-NAI-PRTKBN2             PIC X(01).
                   07  SPA-NAI-HKNJANUM            PIC X(08). 
      *
               05  SPA-STATE.             
                   07  SPA-B06-STATE               PIC S9(09)  BINARY.
                   07  SPA-B07-STATE               PIC S9(09)  BINARY.
                   07  SPA-SRYYM-STATE             PIC S9(09)  BINARY.
                   07  SPA-DATAKBN1-STATE          PIC S9(09)  BINARY.
                   07  SPA-DATAKBN2-STATE          PIC S9(09)  BINARY.
                   07  SPA-DATAKBN3-STATE          PIC S9(09)  BINARY.
                   07  SPA-DATAKBN4-STATE          PIC S9(09)  BINARY.
                   07  SPA-DATAKBN5-STATE          PIC S9(09)  BINARY.
      *
               05  SPA-DATAKBN.         
                   07  SPA-DATAKBN1-VALUE          PIC X(01).
                   07  SPA-DATAKBN2-VALUE          PIC X(01).
                   07  SPA-DATAKBN3-VALUE          PIC X(01).
                   07  SPA-DATAKBN4-VALUE          PIC X(01).
                   07  SPA-DATAKBN5-VALUE          PIC X(01).
      *
      *   
           COPY    "ENUM-VALUE".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECEERR         PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-HKNJAINF        PIC 9(01).
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
           03  WRK-PRTKANRI-RENNUM PIC 9(04).
           03  WRK-RECEERR         PIC X(200).
           03  WRK-SKYYM           PIC X(06).
           03  WRK-CREYMD          PIC X(08).
           03  WRK-TIDMSG          PIC X(70).
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
           03  WRK-PAGE            PIC ZZZZZZZZZ9.   
      *     
           03  WRK-SHELL-ARG1.
             05  WRK-SHELL-SRYYM   PIC  X(06).
             05  WRK-SHELL-TERMID  PIC  X(16).
             05  WRK-SHELL-SYSYMD  PIC  X(08).  
      *       
           03  WRK-SHELL-RECEKBN   PIC X(01).
      *  
           03  WRK-STPAGE          PIC 9(05).
           03  WRK-EDPAGE          PIC 9(05).
      *      
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY          PIC 9(02).
               05  SYS-MM          PIC 9(02).
               05  SYS-DD          PIC 9(02).
           03  WRK-SYSYMD.
               05  WRK-SYSYY       PIC 9(04).
               05  WRK-SYSMM       PIC 9(02).
               05  WRK-SYSDD       PIC 9(02).
           03  SYS-TIME            PIC X(06).
      *
       01  WRK-3004-AREA.
           03  WRK-3004-MAX        PIC 9(02).
           03  WRK-3004-TBL        OCCURS  25.
               05  WRK-3004-SHELLID
                                   PIC  X(020).
               05  WRK-3004-CHK.
                   07  WRK-3004-CHKFLG
                                   PIC  X(01)
                                        OCCURS   4.
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
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".
      *
      *    県単独事業用シェル
       01  WRK-SHELL-KENTAN.
           03  FILLER             PIC X(15) VALUE
                                             "scripts/kentan/".
           03  WRK-SHELL-SHELL    PIC X(30).
      *                             
       01  WRK-SHELL-NAME         PIC X(50).
      *
       01  WRK-LNK-AREA.
           COPY    "CPORCSPRTLNK.INC".             
      *              
      *
       01  WRK-CONS-AREA.
      *    システム管理ＤＢ（３００３）のキー値  
           03  WRK-CONS-3003-KBNCD PIC X(08)   VALUE   "044".
      *    印刷管理ＤＢのキー値  
           03  WRK-CONS-PRTKANRI-TBL-KEY
                                   PIC X(08)   VALUE   "SOKATU".
           03  WRK-CONS-PRTKANRI-TBL-GROUP
                                   PIC X(14)   VALUE   SPACE.
      *    ジョブ管理ＤＢのキー値  
           03  WRK-CONS-JOB-SHELLID
                                   PIC X(08)   VALUE   "SOKATU".
           03  WRK-CONS-JOB-JOBID  PIC 9(07)   VALUE   ZERO.
      *     
      *    ジョブ管理ＤＢのキー値（レセプト）  
           03  WRK-CONS-JOB-SHELLID-RECEPT1
                                   PIC X(08)   VALUE   "RECEPT1".
           03  WRK-CONS-JOB-JOBID-RECEPT1
                                   PIC 9(07)   VALUE   1.
      *    
      *    固定端末ＩＤ
           03  WRK-CONS-TERMID.
               05  FILLER          PIC X(08)   VALUE   "0100007F". 
               05  FILLER          PIC X(56)   VALUE   ALL "Z".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1031.INC".
      *
           COPY    "CPSK2001.INC".
      *
           COPY    "CPSK2003.INC".
      *
           COPY    "CPSK2005.INC".
      *
           COPY    "CPSK3003.INC".
      *
           COPY    "CPSK3004.INC".
      *
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".          
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    保険者
       01  HKNJAINF-REC.
           COPY    "CPHKNJAINF.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *   日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
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
           COPY    "T01.INC".
           COPY    "T99.INC".
           COPY    "TERR.INC".
           COPY    "TID1.INC".
           COPY    "TID2.INC".
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
           MOVE    SPA-FREE        TO  SPA-T01
           MOVE    SPA-WORK        TO  SPA-T01KYOUTU
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
           MOVE    SPA-T01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-T01         TO  SPA-FREE
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
           IF      SPA-MOTOPG          =   "TERR"
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
           MOVE    "T01    "           TO  MCP-WINDOW.
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
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
      *
      *        元の画面へ戻す
               IF      SPA-MOTOPG      =   "XA01"  OR  "XB01"
                   MOVE    LNK-COMMON      TO  SPA-KYOUTU
                   MOVE    LNK-SCRSPA      TO  SPA-T01
                   INITIALIZE              SPA-T01KYOUTU
                   GO  TO  300-SCREEN-EXT
               END-IF
      *
               MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
               INITIALIZE              SPA-T01KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG
      *    作表処理
               WHEN    "T99" 
                   GO      TO      300-SCREEN-EXT
               WHEN    "TID1"
                   PERFORM 330-TID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
               WHEN    "TID2"
                   PERFORM 340-TID2-SET-SEC
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
           INITIALIZE              SPA-T01-AREA
      *
      *    レセプト指示コード
           INITIALIZE                  SYS-2001-REC
           MOVE    "2001"              TO  SYS-2001-KANRICD
           MOVE    "*"                 TO  SYS-2001-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-2001-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-2001-REC
               IF      SYS-2001-SYOKBN     =   "1"
                   MOVE    SYS-2001-SRYYM      TO  SPA-NAI-SRYYM
                                                   WRK-SYMD (1:6)
                   MOVE    "01"                TO  WRK-SYMD (7:2) 
                   PERFORM 5002-HIZUKE-HEN-SEC
                   MOVE    WRK-HENYMDG3(1:16)  TO  SPA-GMN-SRYYM
               END-IF     
           END-IF
           IF      SPA-NAI-SRYYM      =   ZERO
               MOVE    "請求書対象データなし"  TO  SPA-GMN-SRYYM
           END-IF    
      *
      *    レセ電処理区分
           MOVE    SPACE               TO  SYS-2005-REC 
           INITIALIZE                      SYS-2005-REC
           MOVE    "2005"              TO  SYS-2005-KANRICD
           MOVE    "*"                 TO  SYS-2005-KBNCD
           MOVE    SPA-NAI-SKYYM       TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2)
           MOVE    SYS-2005-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-2005-REC
           ELSE
               INITIALIZE                   SYS-2005-REC
           END-IF
           IF      SYS-2005-SYARECEKBN =   "1"
               MOVE    WIDGET-NORMAL      TO  SPA-B06-STATE
           ELSE
               MOVE    WIDGET-INSENSITIVE TO  SPA-B06-STATE
           END-IF
           IF      SYS-2005-KKHRECEKBN =   "1"
               MOVE    WIDGET-NORMAL      TO  SPA-B07-STATE
           ELSE
               MOVE    WIDGET-INSENSITIVE TO  SPA-B07-STATE
           END-IF
      *
           MOVE    WIDGET-INSENSITIVE TO  SPA-SRYYM-STATE
           MOVE    WIDGET-NORMAL      TO  SPA-DATAKBN1-STATE
                                          SPA-DATAKBN2-STATE
                                          SPA-DATAKBN4-STATE
                                          SPA-DATAKBN5-STATE
                                          SPA-DATAKBN3-STATE       
           IF      SPA-NAI-SRYYM      =   ZERO
               MOVE    WIDGET-INSENSITIVE  TO  SPA-DATAKBN1-STATE
                                               SPA-DATAKBN3-STATE
           END-IF
           IF      SPA-NAI-SRYYM      =   ZERO
               MOVE    "F"                TO  SPA-DATAKBN1-VALUE
               MOVE    "T"                TO  SPA-DATAKBN2-VALUE  
               MOVE    "F"                TO  SPA-DATAKBN4-VALUE  
               MOVE    "F"                TO  SPA-DATAKBN5-VALUE  
               MOVE    "F"                TO  SPA-DATAKBN3-VALUE  
           ELSE
               MOVE    "T"                TO  SPA-DATAKBN1-VALUE
               MOVE    "F"                TO  SPA-DATAKBN2-VALUE  
               MOVE    "F"                TO  SPA-DATAKBN4-VALUE  
               MOVE    "F"                TO  SPA-DATAKBN5-VALUE  
               MOVE    "F"                TO  SPA-DATAKBN3-VALUE  
           END-IF
      *
      *    標準総括表印刷指示
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-NAI-SKYYM       TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2)
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-3003-REC 
           ELSE
               INITIALIZE                      SYS-3003-REC
           END-IF
           MOVE    SYS-3003-PRTKBN1    TO  SPA-NAI-PRTKBN1        
           IF      SYS-3003-PRTKBN1    =   SPACE
               MOVE    "有"                 TO  SPA-GMN-PRTKBN1-VALUE
               MOVE   "blue"                TO  SPA-GMN-PRTKBN1-STYLE
           ELSE
               MOVE    "無"                 TO  SPA-GMN-PRTKBN1-VALUE
               MOVE   "red"                 TO  SPA-GMN-PRTKBN1-STYLE
           END-IF      
           MOVE    SYS-3003-PRTKBN2    TO  SPA-NAI-PRTKBN2        
           IF      SYS-3003-PRTKBN2    =   SPACE
               MOVE    "有"                 TO  SPA-GMN-PRTKBN2-VALUE
               MOVE   "blue"                TO  SPA-GMN-PRTKBN2-STYLE
           ELSE
               MOVE    "無"                 TO  SPA-GMN-PRTKBN2-VALUE
               MOVE   "red"                 TO  SPA-GMN-PRTKBN2-STYLE
           END-IF
      *      
      *    地方公費ＤＢ対応済フラグ
           IF      SYS-3003-KOHSKY-FLG =   "1"
               MOVE    WIDGET-NORMAL      TO  SPA-DATAKBN1-STATE
                                              SPA-DATAKBN2-STATE
                                              SPA-DATAKBN4-STATE
                                              SPA-DATAKBN5-STATE
                                              SPA-DATAKBN3-STATE       
               MOVE    "T"                TO  SPA-DATAKBN1-VALUE
               MOVE    "F"                TO  SPA-DATAKBN2-VALUE  
               MOVE    "F"                TO  SPA-DATAKBN4-VALUE  
               MOVE    "F"                TO  SPA-DATAKBN5-VALUE  
               MOVE    "F"                TO  SPA-DATAKBN3-VALUE  
           END-IF
      *
           MOVE    ZERO            TO  SPA-NAI-HKNJANUM
      *
           MOVE    1               TO  SPA-GMN-PAGE
           MOVE    1               TO  SPA-GMN-CUR
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-TID1-SET-SEC            SECTION.
      *
           IF      SPA-TID1-FLG    =   "OK"
               EVALUATE    SPA-TIDCD
                   WHEN    "6666"
                       MOVE    "JOIN"          TO  MCP-PUTTYPE
                       PERFORM 210-BACK-SYORI-SEC
                   WHEN    "1011"
                   WHEN    "1012"
                   WHEN    "1013"
                       PERFORM 480-PRINT-SEC
               END-EVALUATE        
           END-IF
      *
           MOVE    1               TO  SPA-GMN-CUR
      *
           MOVE    SPACE           TO  SPA-TID1-FLG
           MOVE    SPACE           TO  SPA-TIDCD
           .
       330-TID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＴＩＤ２）ＯＫ処理
      *****************************************************************
       340-TID2-SET-SEC            SECTION.
      *
           IF      SPA-TID1-FLG    =   "OK"    OR  "NO"
               EVALUATE    SPA-TIDCD
                   WHEN    "1010"
                   WHEN    "1014"
                       PERFORM 460-RECEDEN-SEC
                   WHEN    OTHER
                       PERFORM 450-PRINT-SEC
               END-EVALUATE 
           END-IF
      *
           MOVE    1               TO  SPA-GMN-CUR
      *
           MOVE    SPACE           TO  SPA-TID1-FLG
           MOVE    SPACE           TO  SPA-TIDCD
           .
       340-TID2-SET-EXT.
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
                   MOVE   "CHANGE"         TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *     再印刷
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM 450-REPRINT-SEC
      *     社保レセ電処理
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 460-RECEDEN-GID-SEC
      *     国保レセ電処理
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 460-RECEDEN-GID-SEC
      *     未請求一覧
               WHEN    "CLICKED"       ALSO    "B08"
                   PERFORM 480-PRINT-GID-SEC
      *     決定通知書（社保）
               WHEN    "CLICKED"       ALSO    "B09"
                   PERFORM 480-PRINT-GID-SEC
      *     決定通知書（国保）
               WHEN    "CLICKED"       ALSO    "B10"
                   PERFORM 480-PRINT-GID-SEC
      *     情報削除
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 490-JYOUHOU-DEL-SEC
      *     印刷
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 450-PRINT-GID-SEC
      *    処理確認
               WHEN    "CLICKED"       ALSO    "B13"
                   PERFORM 490-KAKUNIN-SEC
      *    帳票区分１
               WHEN    "CLICKED"       ALSO    "DATAKBN1"
                   PERFORM 400-DATAKBN1-SEC
      *    帳票区分２
               WHEN    "CLICKED"       ALSO    "DATAKBN2"
                   PERFORM 400-DATAKBN2-SEC
      *    帳票区分３
               WHEN    "CLICKED"       ALSO    "DATAKBN3"
                   PERFORM 400-DATAKBN3-SEC
      *    帳票区分４
               WHEN    "CLICKED"       ALSO    "DATAKBN4"
                   PERFORM 400-DATAKBN4-SEC
      *    帳票区分５
               WHEN    "CLICKED"       ALSO    "DATAKBN5"
                   PERFORM 400-DATAKBN5-SEC
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
               WHEN    "ACTIVATE"      ALSO    "SKYYM"
                   PERFORM 4101-SKYYM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SKYYMD"
                   PERFORM 4102-SKYYMD-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "HKNJANUM"
                   PERFORM 4103-HKNJANUM-CHK-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票区分１選択処理
      *****************************************************************
       400-DATAKBN1-SEC          SECTION.
      *
           MOVE    T01-DATAKBN1-VALUE  TO  SPA-DATAKBN1-VALUE
      *
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
           MOVE    T01-DATAKBN2-VALUE  TO  SPA-DATAKBN2-VALUE
      *
           .
       400-DATAKBN2-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票区分３選択処理
      *****************************************************************
       400-DATAKBN3-SEC          SECTION.
      *
           MOVE    T01-DATAKBN3-VALUE  TO  SPA-DATAKBN3-VALUE
      *
           .
       400-DATAKBN3-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    帳票区分４選択処理
      *****************************************************************
       400-DATAKBN4-SEC          SECTION.
      *
           MOVE    T01-DATAKBN4-VALUE  TO  SPA-DATAKBN4-VALUE
      *
           .
       400-DATAKBN4-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    帳票区分５選択処理
      *****************************************************************
       400-DATAKBN5-SEC          SECTION.
      *
           MOVE    T01-DATAKBN5-VALUE  TO  SPA-DATAKBN5-VALUE
      *
           .
       400-DATAKBN5-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    請求年月チェック処理
      *****************************************************************
       4101-SKYYM-CHK-SEC           SECTION.
      *
           MOVE    1                TO  SPA-GMN-CUR
      *
           MOVE    ZERO             TO  SPA-NAI-SKYYM
           MOVE    T01-SKYYM        TO  SPA-GMN-SKYYM
      *
           IF      SPA-GMN-SKYYM    =   SPACE
               MOVE    "0001"          TO  SPA-ERRCD
               GO  TO  4101-SKYYM-CHK-EXT
           ELSE 
      *        日付画面チェックサブ
               INITIALIZE                      ORCSGDAYAREA
               MOVE    "1"                 TO  SGDAY-INTYPE
               MOVE    SPA-GMN-SKYYM       TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY(1:6)    TO  SPA-GMN-SKYYM
                   MOVE    SGDAY-SDAY (1:6)    TO  SPA-NAI-SKYYM
               ELSE
                   MOVE    "0003"          TO  SPA-ERRCD
                   GO  TO  4101-SKYYM-CHK-EXT
               END-IF
      *
               MOVE    2                   TO  SPA-GMN-CUR
           END-IF
      *
           .
       4101-SKYYM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求年月日チェック処理
      *****************************************************************
       4102-SKYYMD-CHK-SEC           SECTION.
      *
           MOVE    2                TO  SPA-GMN-CUR
      *
           MOVE    T01-SKYYMD       TO  SPA-GMN-SKYYMD
      *
           IF      SPA-GMN-SKYYMD   =   SPACE
               MOVE    "0002"          TO  SPA-ERRCD
               GO  TO  4102-SKYYMD-CHK-EXT
           ELSE 
      *        日付画面チェックサブ
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN-SKYYMD      TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY         TO  SPA-GMN-SKYYMD
                   MOVE    SGDAY-SDAY          TO  SPA-NAI-SKYYMD
               ELSE
                   MOVE    "0004"          TO  SPA-ERRCD
                   GO  TO  4102-SKYYMD-CHK-EXT
               END-IF
      *
               MOVE    7                   TO  SPA-GMN-CUR
           END-IF
      *
           .
       4102-SKYYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険者番号チェック処理
      *****************************************************************
       4103-HKNJANUM-CHK-SEC           SECTION.
      *
           MOVE    3                TO  SPA-GMN-CUR
      *
           MOVE    T01-HKNJANUM     TO  SPA-GMN-HKNJANUM
      *
           MOVE    SPACE            TO  SPA-GMN-HKNJAMEI
           MOVE    ZERO             TO  SPA-NAI-HKNJANUM 
      *
           IF      SPA-GMN-HKNJANUM =   SPACE
               GO  TO  4103-HKNJANUM-CHK-EXT
           ELSE 
               MOVE    SPACE           TO  HKNJAINF-REC
               INITIALIZE                  HKNJAINF-REC
               MOVE    SPA-HOSPID      TO  HKNJA-HOSPID
               MOVE    SPA-GMN-HKNJANUM
                                       TO  HKNJA-HKNJANUM
               MOVE    HKNJAINF-REC    TO  MCPDATA-REC
               PERFORM 900-HKNJAINF-INV-SEC
               IF      FLG-HKNJAINF        =   ZERO
                   MOVE    HKNJA-HKNJANAME     TO SPA-GMN-HKNJAMEI
                   MOVE    SPA-GMN-HKNJANUM    TO  SPA-NAI-HKNJANUM
               ELSE
                   MOVE    "0005"          TO  SPA-ERRCD
                   GO  TO  4103-HKNJANUM-CHK-EXT
               END-IF
      *
               MOVE    7                   TO  SPA-GMN-CUR
           END-IF
      *
           .
       4103-HKNJANUM-CHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *        
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-NAI-SKYYM       TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2)
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-3003-REC 
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SYS-3003-JOBID
      *            ジョブ管理チェック処理
                   MOVE    "CHK"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    IDX             TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA  
                                           JOBKANRI-REC
                   IF      SJOBKANRI-RETURN
                                           =   ZERO
                       IF      JOB-ENDYMD      =   SPACE
      *********        AND     JOB-TERMID      =   SPA-TERMID
                           MOVE    "6666"          TO  SPA-TIDCD
                           GO  TO  210-BACK-EXT
                       END-IF
                   END-IF
               END-PERFORM
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
      *
           MOVE    "M01"               TO  SPA-SAKIPG
           MOVE    "T01"               TO  SPA-MOTOPG
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
      *    作表処理
      *****************************************************************
       450-PRINT-GID-SEC                SECTION.
      *
      *    ジョブ管理チェック        
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-NAI-SKYYM       TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2)
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-3003-REC 
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SYS-3003-JOBID
      *            ジョブ管理チェック処理
                   MOVE    "CHK"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    IDX             TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA  
                                           JOBKANRI-REC
                   IF      SJOBKANRI-RETURN
                                           =   ZERO
                       IF      JOB-ENDYMD      =   SPACE
                           MOVE    "7777"          TO  SPA-ERRCD
                           MOVE    SPACE           TO  WRK-RECEERR
                           STRING  "処理中です【"  DELIMITED  BY  SIZE
                                   JOB-SHELLMSG    DELIMITED  BY  SPACE
                                   "】"            DELIMITED  BY  SIZE      
                                                   INTO  WRK-RECEERR
                           MOVE    SYS-3003-JOBID  TO  IDX
                       END-IF
                   END-IF    
               END-PERFORM
           END-IF
      *
      *
      *    ジョブ管理チェック（レセプト）
           IF      SPA-ERRCD           =   SPACE         
               MOVE    "CHK"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-CONS-JOB-JOBID-RECEPT1
                                       TO  JOB-JOBID
               MOVE    WRK-CONS-JOB-SHELLID-RECEPT1
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
                   END-IF
               END-IF    
           END-IF    
      *
           IF      SPA-ERRCD           =   SPACE
               IF      T01-DATAKBN3-VALUE    =   "T"
                   CONTINUE
               ELSE
                   IF      SPA-NAI-SKYYM       =   ZERO
                       MOVE    "0001"              TO  SPA-ERRCD
                   END-IF    
               END-IF    
           END-IF    
      *
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-NAI-SKYYMD      =   ZERO
                   MOVE    "0002"              TO  SPA-ERRCD
               END-IF    
           END-IF    
      *
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-GMN-HKNJANUM    =   SPACE
                   MOVE    ZERO                TO  SPA-NAI-HKNJANUM
               ELSE
                   IF      SPA-GMN-HKNJAMEI        =   SPACE    
                   MOVE    "0005"              TO  SPA-ERRCD
               END-IF    
           END-IF    
      *
           IF      SPA-ERRCD           =   SPACE
      *    ガイドメッセージセット
               EVALUATE    TRUE
                   WHEN    T01-DATAKBN1-VALUE    =   "T" 
                       MOVE    "1001"              TO  SPA-TIDCD
                   WHEN    T01-DATAKBN2-VALUE    =   "T" 
                       MOVE    "1002"              TO  SPA-TIDCD
                   WHEN    T01-DATAKBN3-VALUE    =   "T" 
                       MOVE    "1003"              TO  SPA-TIDCD
                   WHEN    T01-DATAKBN4-VALUE    =   "T" 
                       MOVE    "1004"              TO  SPA-TIDCD
                   WHEN    T01-DATAKBN5-VALUE    =   "T" 
                       MOVE    "1005"              TO  SPA-TIDCD
               END-EVALUATE
           END-IF
           .
       450-PRINT-GID-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷編集処理
      *****************************************************************
       450-PRINT-SEC                   SECTION.
      * 
      *    ＪＯＢＩＤ（３００３）削除処理
      **** MOVE    SPACE               TO  SYS-3003-REC 
      *     INITIALIZE                      SYS-3003-REC
      *     MOVE    "3003"              TO  SYS-3003-KANRICD
      *     MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
      *     MOVE    SPA-NAI-*SKYYM       TO  ORC-DBYMD (1:6)
      *     MOVE    "01"                TO  ORC-DBYMD (7:2)
      *     MOVE    SYS-3003-REC        TO  MCPDATA-REC
      *     PERFORM 900-SYSKANRI-INV-SEC
      *     IF      FLG-SYSKANRI        =   ZERO
      *         MOVE    MCPDATA-REC         TO  SYS-3003-REC
      *         MOVE    SYS-3003-REC        TO  MCPDATA-REC
      *         MOVE    "DBDELETE"          TO  MCP-FUNC
      *         MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
      *         CALL    "ORCMCPSUB"         USING
      *                                     MCPAREA
      *                                     ORCMCPAREA
      *                                     MCPDATA-REC
      *         IF      MCP-RC              =   ZERO
      *             CONTINUE
      *         ELSE                                 
      *             MOVE    "1005"              TO  SPA-ERRCD
      *             GO  TO  450-PRINT-EXT
      *         END-IF
      **** END-IF                 
      * 
      *    ジョブ管理削除処理
           MOVE    "ALL"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING   ORCSJOBKANRIAREA  
                                           JOBKANRI-REC
           IF      SJOBKANRI-RETURN    =   ZERO
               CONTINUE
           ELSE
               MOVE    "1004"              TO  SPA-ERRCD
               GO  TO  450-PRINT-EXT
           END-IF             
      *
           ACCEPT  SYS-YMD         FROM    DATE
           COMPUTE WRK-SYSYY       =   SYS-YY      +   2000
           MOVE    SYS-MM              TO  WRK-SYSMM
           MOVE    SYS-DD              TO  WRK-SYSDD
           ACCEPT  SYS-TIME            FROM    TIME
      *
           MOVE    ZERO                TO  WRK-CONS-JOB-JOBID     
                                           WRK-PRTKANRI-RENNUM
           MOVE    SPACE               TO  WRK-CONS-PRTKANRI-TBL-GROUP                                
      *     
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
      *****MOVE    SPA-TERMID          TO  RECEERR-TERMID
           MOVE    WRK-CONS-TERMID     TO  RECEERR-TERMID
      *     
      *    出力先プリンタ名割り当て情報編集
           MOVE    SPACE               TO  SYS-1031-REC
           INITIALIZE                  SYS-1031-REC
           MOVE    "1031"              TO  SYS-1031-KANRICD
           MOVE    "*"                 TO  SYS-1031-KBNCD
           MOVE    SYS-1031-REC        TO  MCPDATA-REC
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1031-REC
           ELSE    
               INITIALIZE                  SYS-1031-REC
           END-IF
      *
      *    県単独事業
           INITIALIZE                  WRK-3004-AREA
      *      
           MOVE    SPACE               TO  SYS-3004-REC 
           INITIALIZE                      SYS-3004-REC
           MOVE    "3004"              TO  SYS-3004-KANRICD
           MOVE    "*"                 TO  SYS-3004-KBNCD
           MOVE    SPA-NAI-SKYYM       TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2)
           MOVE    SYS-3004-REC        TO  MCPDATA-REC
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
           MOVE    ZERO                TO  IDX
           PERFORM         UNTIL       FLG-SYSKANRI    =   1
               MOVE    MCPDATA-REC     TO  SYS-3004-REC
               IF      SYS-3004-SHELLID    =   SPACE
               OR      SYS-3004-SHORIMSG   =   SPACE
               OR      SYS-3004-CHK        =   ALL "F"
                   CONTINUE
               ELSE
                   ADD     1               TO  IDX
                   MOVE    SYS-3004-SHELLID
                                           TO  WRK-3004-SHELLID (IDX) 
                   MOVE    SYS-3004-CHK    TO  WRK-3004-CHK     (IDX) 
               END-IF
      *
               MOVE    "SYSKANRI-KEY2" TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *     
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           MOVE    IDX                 TO  WRK-3004-MAX
      *
      *    国保診療報酬請求書印刷区分
           MOVE    SPACE               TO  SYS-2005-REC 
           INITIALIZE                      SYS-2005-REC
           MOVE    "2005"              TO  SYS-2005-KANRICD
           MOVE    "*"                 TO  SYS-2005-KBNCD
           MOVE    SPA-NAI-SKYYM       TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2)
           MOVE    SYS-2005-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-2005-REC
           ELSE
               INITIALIZE                   SYS-2005-REC
           END-IF
      *
      *    印刷ＤＢのＫＥＹ用     
           MOVE    WRK-SYSYMD          TO
                                   WRK-CONS-PRTKANRI-TBL-GROUP (1:8)
           MOVE    SYS-TIME            TO
                                   WRK-CONS-PRTKANRI-TBL-GROUP (9:)
      *     
      *    総括表印刷（社保）
           EVALUATE    TRUE
               WHEN    T01-DATAKBN1-VALUE    =   "T" 
               WHEN    T01-DATAKBN2-VALUE    =   "T" 
               WHEN    T01-DATAKBN4-VALUE    =   "T"
                   IF      SPA-NAI-PRTKBN1       =   SPACE  
                       MOVE    "1"                 TO  WRK-SHELL-RECEKBN
                       PERFORM 45013-SOKATU-SYORI-SEC
                   END-IF     
           END-EVALUATE                                               
      *     
      *    総括表印刷（国保）
           EVALUATE    TRUE
               WHEN    T01-DATAKBN1-VALUE    =   "T" 
               WHEN    T01-DATAKBN2-VALUE    =   "T" 
               WHEN    T01-DATAKBN5-VALUE    =   "T" 
                   IF      SPA-NAI-PRTKBN2       =   SPACE
                       MOVE    "2"                 TO  WRK-SHELL-RECEKBN
                       PERFORM 45013-SOKATU-SYORI-SEC
                   END-IF    
           END-EVALUATE                                               
      *     
      *    県単独事業（総括）
           EVALUATE    TRUE
               WHEN    T01-DATAKBN1-VALUE    =   "T" 
               WHEN    T01-DATAKBN2-VALUE    =   "T" 
               WHEN    T01-DATAKBN4-VALUE    =   "T" 
               WHEN    T01-DATAKBN5-VALUE    =   "T" 
                   PERFORM VARYING IDX FROM    1   BY  1
                           UNTIL   IDX >       WRK-3004-MAX
                       EVALUATE    TRUE
                           WHEN    T01-DATAKBN1-VALUE    =   "T" 
                           WHEN    T01-DATAKBN2-VALUE    =   "T" 
                              IF      WRK-3004-CHKFLG (IDX 1) =   "T"   
                              OR      WRK-3004-CHKFLG (IDX 2) =   "T"
                                  PERFORM 45010-KENTAN-SOKATU-SYORI-SEC
                              END-IF             
                           WHEN    T01-DATAKBN4-VALUE    =   "T" 
                             IF      WRK-3004-CHKFLG (IDX 1) =   "T"
                                  PERFORM 45010-KENTAN-SOKATU-SYORI-SEC
                             END-IF 
                           WHEN    T01-DATAKBN5-VALUE    =   "T" 
                             IF      WRK-3004-CHKFLG (IDX 2) =   "T"
                                  PERFORM 45010-KENTAN-SOKATU-SYORI-SEC
                             END-IF
                     END-EVALUATE                    
                  END-PERFORM  
           END-EVALUATE
      *          
      *    県単独事業（請求書）        
           EVALUATE    TRUE
             WHEN    T01-DATAKBN1-VALUE    =   "T" 
             WHEN    T01-DATAKBN3-VALUE    =   "T" 
      *
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       WRK-3004-MAX
                 IF      WRK-3004-CHKFLG (IDX 3) =   "T"                
                   PERFORM 45011-JOBKANRI-HENSYU-SEC
      *             
                   MOVE    SPACE           TO  SHELLTBL
      *                                   
                   MOVE    WRK-3004-SHELLID (IDX)
                                           TO  WRK-SHELL-SHELL
      *            ファイルデイレクトリ位置指定
                   INITIALIZE              ORCSMKPASSAREA
                   MOVE    WRK-SHELL-KENTAN
                                           TO  MKPASS-IN-01
                   CALL    "ORCSMKPASSSITE"    USING   ORCSMKPASSAREA
                   MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *                                     
                   MOVE    SPACE           TO  LNK-PRTKANRI-AREA
                   INITIALIZE                  LNK-PRTKANRI-AREA
                   ADD     1               TO  WRK-PRTKANRI-RENNUM
                   MOVE    WRK-PRTKANRI-RENNUM
                                           TO  LNK-PRTKANRI-RENNUM 
                   MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                           TO  LNK-PRTKANRI-TBL-KEY 
                   MOVE    WRK-CONS-PRTKANRI-TBL-GROUP
                                           TO  LNK-PRTKANRI-TBL-GROUP
                   MOVE    SPA-NAI-SKYYM   TO  LNK-PRTKANRI-SRYYM 
                   MOVE    SPA-NAI-SKYYMD  TO  LNK-PRTKANRI-SKYYMD
                   MOVE    WRK-3004-SHELLID (IDX)
                                           TO  LNK-PRTKANRI-SHELLID
                   MOVE    ZERO            TO  LNK-PRTKANRI-PRIORITY
      *************MOVE    SPA-TERMID      TO  LNK-PRTKANRI-TERMID
                   MOVE    WRK-CONS-TERMID TO  LNK-PRTKANRI-TERMID
                   MOVE    SPA-OPID        TO  LNK-PRTKANRI-OPID
                   MOVE    SYS-1031-PRTNM (5)
                                           TO  LNK-PRTKANRI-PRTNM
                   MOVE    LNK-PRTKANRI-RENNUM
                                           TO  SHELLTBL-ARG1       
                   MOVE    LNK-PRTKANRI-TBL-KEY
                                           TO  SHELLTBL-ARG2     
                   MOVE    LNK-PRTKANRI-TBL-GROUP
                                           TO  SHELLTBL-ARG3       
                   MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                           TO  SHELLTBL-ARG4       
                   MOVE    LNK-PRTKANRI-SRYYM
                                           TO  SHELLTBL-ARG5       
                   MOVE    LNK-PRTKANRI-SKYYMD
                                           TO  SHELLTBL-ARG6       
                   MOVE    LNK-PRTKANRI-SHELLID
                                           TO  SHELLTBL-ARG7       
                   MOVE    LNK-PRTKANRI-PRIORITY
                                           TO  SHELLTBL-ARG8      
                   MOVE    LNK-PRTKANRI-TERMID
                                           TO  SHELLTBL-ARG9       
                   MOVE    LNK-PRTKANRI-OPID
                                           TO  SHELLTBL-ARG10      
                   MOVE    LNK-PRTKANRI-PRTNM
                                           TO  SHELLTBL-ARG11      
      *                 
                   MOVE    WRK-CONS-JOB-JOBID
                                           TO  SHELLTBL-ARG12
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  SHELLTBL-ARG13         
                   MOVE    SPA-HOSPID      TO  SHELLTBL-ARG14
                   MOVE    RECEERR         TO  SHELLTBL-ARG15
                   MOVE    SHELLTBL        TO  MCPDATA-REC
                   MOVE    "SHELL"         TO  MCP-FUNC
                   MOVE    PATH-SHELL-SHELL
                                           TO  MCP-PATH
                   CALL    "MCPSUB"        USING
                                               MCPAREA
                                               MCPDATA-REC       
                 END-IF
             END-PERFORM                                                    
           END-EVALUATE
      *
      *
      *    印刷処理
      *
           IF      SPA-TID1-FLG        =   "OK"
           PERFORM 45011-JOBKANRI-HENSYU-SEC
      *                                   
      *****MOVE    RECEERR             TO  SHELL-ERRFILE
      *
           MOVE    0                   TO  WRK-STPAGE
           MOVE    99999               TO  WRK-EDPAGE
      *             
           MOVE    SPACE               TO  SHELLTBL
           MOVE    "/scripts/allways/print.sh"
                                       TO  WRK-SHELL-NAME
      *    ファイルデイレクトリ位置指定
           INITIALIZE                  ORCSMKPASSAREA
           MOVE    WRK-SHELL-NAME      TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"        USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01        TO  SHELLTBL-NAME
      *                               
           MOVE    SPACE               TO  LNK-PRTKANRI-AREA
           INITIALIZE                      LNK-PRTKANRI-AREA
           MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                       TO  LNK-PRTKANRI-TBL-KEY 
           MOVE    WRK-CONS-PRTKANRI-TBL-GROUP
                                       TO  LNK-PRTKANRI-TBL-GROUP
           MOVE    ZERO                TO  LNK-PRTKANRI-RENNUM
           MOVE    ZERO                TO  LNK-PRTKANRI-SHORI-RENNUM
           MOVE    SPA-NAI-SKYYM       TO  LNK-PRTKANRI-SRYYM 
           MOVE    SPA-NAI-SKYYMD      TO  LNK-PRTKANRI-SKYYMD
           MOVE    "print.sh"          TO  LNK-PRTKANRI-SHELLID
           MOVE    ZERO                TO  LNK-PRTKANRI-PRIORITY
           MOVE    SPA-TERMID          TO  LNK-PRTKANRI-TERMID
           MOVE    SPA-OPID            TO  LNK-PRTKANRI-OPID
           MOVE    LNK-PRTKANRI-RENNUM TO  SHELLTBL-ARG1       
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  SHELLTBL-ARG2     
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  SHELLTBL-ARG3       
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                       TO  SHELLTBL-ARG4       
           MOVE    LNK-PRTKANRI-SRYYM  TO  SHELLTBL-ARG5       
           MOVE    LNK-PRTKANRI-SKYYMD TO  SHELLTBL-ARG6       
           MOVE    LNK-PRTKANRI-SHELLID
                                       TO  SHELLTBL-ARG7       
           MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  SHELLTBL-ARG8      
           MOVE    LNK-PRTKANRI-TERMID TO  SHELLTBL-ARG9       
           MOVE    LNK-PRTKANRI-OPID   TO  SHELLTBL-ARG10      
           MOVE    LNK-PRTKANRI-PRTNM  TO  SHELLTBL-ARG11      
      *                 
           MOVE    RECEERR             TO  SHELLTBL-ARG12
           MOVE    WRK-CONS-JOB-JOBID  TO  SHELLTBL-ARG13
           MOVE    WRK-CONS-JOB-SHELLID
                                       TO  SHELLTBL-ARG14
           MOVE    WRK-STPAGE          TO  SHELLTBL-ARG15
           MOVE    WRK-EDPAGE          TO  SHELLTBL-ARG16
           MOVE    SHELLTBL            TO  MCPDATA-REC
           MOVE    "SHELL"             TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL    TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           END-IF       
      *
      *    ＪＯＢＩＤ更新処理
      *
           PERFORM 45012-JOBID-UPD-SEC
      *     
      *    情報確認画面を表示                                                   
           PERFORM 490-KAKUNIN-SEC
           .
       450-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    総括処理        
      *****************************************************************
       45013-SOKATU-SYORI-SEC       SECTION.
      *
           PERFORM 45011-JOBKANRI-HENSYU-SEC
      *                                 
      *****MOVE    "recept3.sh"        TO  SHELL-SHELL
      *    MOVE    SPA-NAI-SKYYM       TO  SHELL-SRYYM 
      *****MOVE    SPA-TERMID          TO  SHELL-TERMID
      *    MOVE    WRK-CONS-TERMID     TO  SHELL-TERMID
      *    MOVE    SPA-NAI-SKYYMD      TO  SHELL-SYSYMD    
      *****MOVE    "0"                 TO  SHELL-RECEKBN
      *****IF      T01-DATAKBN4-VALUE  =   "T"
      *****    MOVE    "1"                 TO  SHELL-RECEKBN
      *****END-IF    
      *****IF      T01-DATAKBN5-VALUE  =   "T"
      *****    MOVE    "2"                 TO  SHELL-RECEKBN
      *****END-IF    
      *    MOVE    RECEERR             TO  SHELL-ERRFILE
      *             
           MOVE    SPACE           TO  SHELLTBL
           MOVE    "scripts/monthly/recept3.sh"
                                       TO  WRK-SHELL-NAME
      *    ファイルデイレクトリ位置指定
           INITIALIZE                  ORCSMKPASSAREA
           MOVE    WRK-SHELL-NAME      TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"        USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01        TO  SHELLTBL-NAME
      *                                 
           MOVE    SPACE           TO  LNK-PRTKANRI-AREA
           INITIALIZE                  LNK-PRTKANRI-AREA
           ADD     1               TO  WRK-PRTKANRI-RENNUM
           MOVE    WRK-PRTKANRI-RENNUM
                                   TO  LNK-PRTKANRI-RENNUM 
           MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                   TO  LNK-PRTKANRI-TBL-KEY 
           MOVE    WRK-CONS-PRTKANRI-TBL-GROUP
                                   TO  LNK-PRTKANRI-TBL-GROUP
           MOVE    SPA-NAI-SKYYM   TO  LNK-PRTKANRI-SRYYM 
           MOVE    SPA-NAI-SKYYMD  TO  LNK-PRTKANRI-SKYYMD
           MOVE    "recept3.sh"    TO  LNK-PRTKANRI-SHELLID
           MOVE    ZERO            TO  LNK-PRTKANRI-PRIORITY
      *****MOVE    SPA-TERMID      TO  LNK-PRTKANRI-TERMID
           MOVE    WRK-CONS-TERMID TO  LNK-PRTKANRI-TERMID 
           MOVE    SPA-OPID        TO  LNK-PRTKANRI-OPID
           MOVE    SYS-1031-PRTNM (5)
                                   TO  LNK-PRTKANRI-PRTNM
           MOVE    LNK-PRTKANRI-RENNUM
                                   TO  SHELLTBL-ARG1       
           MOVE    LNK-PRTKANRI-TBL-KEY
                                   TO  SHELLTBL-ARG2     
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                   TO  SHELLTBL-ARG3       
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                   TO  SHELLTBL-ARG4       
           MOVE    LNK-PRTKANRI-SRYYM
                                   TO  SHELLTBL-ARG5       
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  SHELLTBL-ARG6       
           MOVE    LNK-PRTKANRI-SHELLID
                                   TO  SHELLTBL-ARG7       
           MOVE    LNK-PRTKANRI-PRIORITY
                                   TO  SHELLTBL-ARG8      
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  SHELLTBL-ARG9       
           MOVE    LNK-PRTKANRI-OPID
                                   TO  SHELLTBL-ARG10      
           MOVE    LNK-PRTKANRI-PRTNM
                                   TO  SHELLTBL-ARG11      
      *                 
           MOVE    SPA-NAI-SKYYM   TO  WRK-SHELL-SRYYM 
           MOVE    WRK-CONS-TERMID TO  WRK-SHELL-TERMID
           MOVE    SPA-NAI-SKYYMD  TO  WRK-SHELL-SYSYMD    
           MOVE    WRK-SHELL-ARG1  TO  SHELLTBL-ARG12
           MOVE    WRK-SHELL-RECEKBN
                                   TO  SHELLTBL-ARG13
           MOVE    SPA-HOSPID      TO  SHELLTBL-ARG14
           IF      SYS-2005-KKHPRTKBN  =   "1"
               MOVE    "1"             TO  SHELLTBL-ARG15
           ELSE
               MOVE    "0"             TO  SHELLTBL-ARG15
           END-IF
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  SHELLTBL-ARG16
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  SHELLTBL-ARG17         
           MOVE    RECEERR         TO  SHELLTBL-ARG18
           MOVE    SPA-NAI-SKYYM   TO  SHELLTBL-ARG19
           IF      SPA-BEDSU       =   ZERO
               MOVE    "2"             TO  SHELLTBL-ARG20
           ELSE
               MOVE    "1"             TO  SHELLTBL-ARG20
           END-IF
           IF      SPA-DATAKBN5-VALUE    =   "T" 
               MOVE    SPA-NAI-HKNJANUM
                                   TO  SHELLTBL-ARG21
           ELSE
               MOVE    "00000000"  TO  SHELLTBL-ARG21
           END-IF
           MOVE    SHELLTBL        TO  MCPDATA-REC
           MOVE    "SHELL"         TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL
                                   TO  MCP-PATH
           CALL    "MCPSUB"        USING
                                   MCPAREA
                                   MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "ERROR MCP-RC=" MCP-RC 
           END-IF
      *
           .
       45013-SOKATU-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    県単独事業（総括）処理        
      *****************************************************************
       45010-KENTAN-SOKATU-SYORI-SEC       SECTION.
      *
           PERFORM 45011-JOBKANRI-HENSYU-SEC
      *            
           MOVE    SPACE       TO  SHELLTBL
      *                                   
           MOVE    WRK-3004-SHELLID (IDX)
                               TO  WRK-SHELL-SHELL
      *    ファイルデイレクトリ位置指定
           INITIALIZE              ORCSMKPASSAREA
           MOVE    WRK-SHELL-KENTAN
                               TO  MKPASS-IN-01
           CALL    "ORCSMKPASSSITE"    USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *
           MOVE    SPACE       TO  LNK-PRTKANRI-AREA
           INITIALIZE              LNK-PRTKANRI-AREA
           ADD     1           TO  WRK-PRTKANRI-RENNUM
           MOVE    WRK-PRTKANRI-RENNUM
                               TO  LNK-PRTKANRI-RENNUM 
           MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                               TO  LNK-PRTKANRI-TBL-KEY 
           MOVE    WRK-CONS-PRTKANRI-TBL-GROUP
                               TO  LNK-PRTKANRI-TBL-GROUP
           MOVE    SPA-NAI-SKYYM   TO  LNK-PRTKANRI-SRYYM 
           MOVE    SPA-NAI-SKYYMD  TO  LNK-PRTKANRI-SKYYMD
           MOVE    WRK-3004-SHELLID (IDX)
                                   TO  LNK-PRTKANRI-SHELLID
           MOVE    ZERO            TO  LNK-PRTKANRI-PRIORITY
      *****MOVE    SPA-TERMID      TO  LNK-PRTKANRI-TERMID
           MOVE    WRK-CONS-TERMID TO  LNK-PRTKANRI-TERMID
           MOVE    SPA-OPID        TO  LNK-PRTKANRI-OPID
           MOVE    SYS-1031-PRTNM (5)
                                   TO  LNK-PRTKANRI-PRTNM
           MOVE    LNK-PRTKANRI-RENNUM
                                   TO  SHELLTBL-ARG1       
           MOVE    LNK-PRTKANRI-TBL-KEY
                                   TO  SHELLTBL-ARG2     
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                   TO  SHELLTBL-ARG3       
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                   TO  SHELLTBL-ARG4       
           MOVE    LNK-PRTKANRI-SRYYM
                                   TO  SHELLTBL-ARG5       
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  SHELLTBL-ARG6       
           MOVE    LNK-PRTKANRI-SHELLID
                                   TO  SHELLTBL-ARG7       
           MOVE    LNK-PRTKANRI-PRIORITY
                                   TO  SHELLTBL-ARG8      
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  SHELLTBL-ARG9       
           MOVE    LNK-PRTKANRI-OPID
                                   TO  SHELLTBL-ARG10      
           MOVE    LNK-PRTKANRI-PRTNM
                                   TO  SHELLTBL-ARG11      
      *                 
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  SHELLTBL-ARG12
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  SHELLTBL-ARG13         
           MOVE    "0"         TO  WRK-SHELL-RECEKBN
           IF      T01-DATAKBN4-VALUE  =   "T"
               MOVE    "1"         TO  WRK-SHELL-RECEKBN
           END-IF    
           IF      T01-DATAKBN5-VALUE  =   "T"
               MOVE    "2"         TO  WRK-SHELL-RECEKBN
           END-IF    
           MOVE    WRK-SHELL-RECEKBN
                                   TO  SHELLTBL-ARG14
           MOVE    SPA-HOSPID      TO  SHELLTBL-ARG15
           MOVE    RECEERR         TO  SHELLTBL-ARG16
           MOVE    SPA-NAI-SKYYM   TO  SHELLTBL-ARG17
           IF      WRK-3004-CHKFLG (IDX 2)
                                       =   "T"
               IF      SPA-DATAKBN5-VALUE  =   "T" 
                   MOVE    SPA-NAI-HKNJANUM
                                       TO  SHELLTBL-ARG18
               ELSE
                   MOVE    "00000000"  TO  SHELLTBL-ARG18
               END-IF
           END-IF
           MOVE    SHELLTBL    TO  MCPDATA-REC
           MOVE    "SHELL"     TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL
                               TO  MCP-PATH
           CALL    "MCPSUB"        USING
                                   MCPAREA
                                   MCPDATA-REC                         
            .
       45010-KENTAN-SOKATU-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ開始セット処理
      *****************************************************************
       45011-JOBKANRI-HENSYU-SEC       SECTION.
      *
           ADD     1               TO  WRK-CONS-JOB-JOBID
      *       
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
           .
       45011-JOBKANRI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＪＯＢＩＤ更新処理
      *****************************************************************
       45012-JOBID-UPD-SEC    SECTION.
      *
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-NAI-SKYYM       TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2)
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-3003-REC
           ELSE       
               MOVE    SPACE               TO  SYS-3003-REC 
               INITIALIZE                      SYS-3003-REC
               MOVE    "3003"              TO  SYS-3003-KANRICD
               MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
               MOVE    ZERO                TO  SYS-3003-STYUKYMD
               MOVE    ALL "9"             TO  SYS-3003-EDYUKYMD
           END-IF    
           MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                       TO  SYS-3003-TBL-KEY
           MOVE    WRK-CONS-PRTKANRI-TBL-GROUP
                                       TO  SYS-3003-TBL-GROUP
           MOVE    WRK-CONS-JOB-JOBID  TO  SYS-3003-JOBID                                      
      *
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           IF      FLG-SYSKANRI        =   ZERO     
               MOVE    "DBUPDATE"          TO  MCP-FUNC
           ELSE
               MOVE    "DBINSERT"          TO  MCP-FUNC
           END-IF         
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "SYSKANRI 3003  ERR KEY = ["
                                  MCP-RC  " " SYS-3003-KEY  "]"   
      *****    MOVE    "1010"          TO  SPA-ERRCD
           END-IF
      *
           .
       45012-JOBID-UPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセ電前処理
      *****************************************************************
       460-RECEDEN-GID-SEC                SECTION.
      *
      *    ジョブ管理チェック        
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-NAI-SKYYM       TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2)
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-3003-REC 
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SYS-3003-JOBID
      *            ジョブ管理チェック処理
                   MOVE    "CHK"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    IDX             TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA  
                                           JOBKANRI-REC
                   IF      SJOBKANRI-RETURN
                                           =   ZERO
                       IF      JOB-ENDYMD      =   SPACE
                           MOVE    "7777"          TO  SPA-ERRCD
                           MOVE    SPACE           TO  WRK-RECEERR
                           STRING  "処理中です【"  DELIMITED  BY  SIZE
                                   JOB-SHELLMSG    DELIMITED  BY  SPACE
                                   "】"            DELIMITED  BY  SIZE      
                                                   INTO  WRK-RECEERR
                           MOVE    SYS-3003-JOBID  TO  IDX
                       END-IF
                   END-IF    
               END-PERFORM
           END-IF
      *
      *
      *    ジョブ管理チェック（レセプト）
           IF      SPA-ERRCD           =   SPACE         
               MOVE    "CHK"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-CONS-JOB-JOBID-RECEPT1
                                       TO  JOB-JOBID
               MOVE    WRK-CONS-JOB-SHELLID-RECEPT1
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
                   END-IF
               END-IF    
           END-IF    
      *
           IF      SPA-ERRCD           =   SPACE
               IF      T01-DATAKBN3-VALUE    =   "T"
                   CONTINUE
               ELSE
                   IF      SPA-NAI-SKYYM       =   ZERO
                       MOVE    "0001"              TO  SPA-ERRCD
                   END-IF    
               END-IF    
           END-IF    
      *
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-NAI-SKYYMD      =   ZERO
                   MOVE    "0002"              TO  SPA-ERRCD
               END-IF    
           END-IF    
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    MCP-WIDGET          TO  SPA-NAI-WIDGET
      *        ガイドメッセージセット
               EVALUATE    MCP-WIDGET
                   WHEN    "B06"
                       MOVE    "1010"              TO  SPA-TIDCD
                   WHEN    "B07"
                       MOVE    "1014"              TO  SPA-TIDCD
               END-EVALUATE
           END-IF
      *
           .
       460-RECEDEN-GID-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセ電出力処理
      *****************************************************************
       460-RECEDEN-SEC                SECTION.
      * 
      *    ジョブ管理削除処理
           MOVE    "ALL"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING   ORCSJOBKANRIAREA  
                                           JOBKANRI-REC
           IF      SJOBKANRI-RETURN    =   ZERO
               CONTINUE
           ELSE
               MOVE    "1004"              TO  SPA-ERRCD
               GO  TO  460-RECEDEN-EXT
           END-IF             
      *
           ACCEPT  SYS-YMD         FROM    DATE
           COMPUTE WRK-SYSYY       =   SYS-YY      +   2000
           MOVE    SYS-MM              TO  WRK-SYSMM
           MOVE    SYS-DD              TO  WRK-SYSDD
           ACCEPT  SYS-TIME            FROM    TIME
      *
           MOVE    ZERO                TO  WRK-CONS-JOB-JOBID     
                                           WRK-PRTKANRI-RENNUM
           MOVE    SPACE               TO  WRK-CONS-PRTKANRI-TBL-GROUP                                
      *     
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-CONS-TERMID     TO  RECEERR-TERMID
      *     
      *    出力先プリンタ名割り当て情報編集
           MOVE    SPACE               TO  SYS-1031-REC
           INITIALIZE                  SYS-1031-REC
           MOVE    "1031"              TO  SYS-1031-KANRICD
           MOVE    "*"                 TO  SYS-1031-KBNCD
           MOVE    SYS-1031-REC        TO  MCPDATA-REC
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1031-REC
           ELSE    
               INITIALIZE                  SYS-1031-REC
           END-IF
      *
      *    国保診療報酬請求書印刷区分
           MOVE    SPACE               TO  SYS-2005-REC 
           INITIALIZE                      SYS-2005-REC
           MOVE    "2005"              TO  SYS-2005-KANRICD
           MOVE    "*"                 TO  SYS-2005-KBNCD
           MOVE    SPA-NAI-SKYYM       TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2)
           MOVE    SYS-2005-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-2005-REC
           ELSE
               INITIALIZE                   SYS-2005-REC
           END-IF
           IF      SYS-2005-RECEDENOUT  =   SPACE
               MOVE    "/var/tmp/"      TO  SYS-2005-RECEDENOUT
           END-IF    
      *
      *    印刷ＤＢのＫＥＹ用     
           MOVE    WRK-SYSYMD          TO
                                   WRK-CONS-PRTKANRI-TBL-GROUP (1:8)
           MOVE    SYS-TIME            TO
                                   WRK-CONS-PRTKANRI-TBL-GROUP (9:)
      *
           PERFORM 45011-JOBKANRI-HENSYU-SEC
      *                                 
      *    MOVE    RECEERR             TO  SHELL-ERRFILE
      *             
           MOVE    SPACE           TO  SHELLTBL
           MOVE    "scripts/monthly/recept4.sh"
                                       TO  WRK-SHELL-NAME
      *    ファイルデイレクトリ位置指定
           INITIALIZE                  ORCSMKPASSAREA
           MOVE    WRK-SHELL-NAME      TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"        USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01        TO  SHELLTBL-NAME
      *                                 
           MOVE    SPACE           TO  LNK-PRTKANRI-AREA
           INITIALIZE                  LNK-PRTKANRI-AREA
           ADD     1               TO  WRK-PRTKANRI-RENNUM
           MOVE    WRK-PRTKANRI-RENNUM
                                   TO  LNK-PRTKANRI-RENNUM 
           MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                   TO  LNK-PRTKANRI-TBL-KEY 
           MOVE    WRK-CONS-PRTKANRI-TBL-GROUP
                                   TO  LNK-PRTKANRI-TBL-GROUP
           MOVE    SPA-NAI-SKYYM   TO  LNK-PRTKANRI-SRYYM 
           MOVE    SPA-NAI-SKYYMD  TO  LNK-PRTKANRI-SKYYMD
           MOVE    "recept4.sh"    TO  LNK-PRTKANRI-SHELLID
           MOVE    ZERO            TO  LNK-PRTKANRI-PRIORITY
           MOVE    SPA-TERMID      TO  LNK-PRTKANRI-TERMID
           MOVE    SPA-OPID        TO  LNK-PRTKANRI-OPID
           MOVE    SYS-1031-PRTNM (5)
                                   TO  LNK-PRTKANRI-PRTNM
           MOVE    LNK-PRTKANRI-RENNUM
                                   TO  SHELLTBL-ARG1       
           MOVE    LNK-PRTKANRI-TBL-KEY
                                   TO  SHELLTBL-ARG2     
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                   TO  SHELLTBL-ARG3       
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                   TO  SHELLTBL-ARG4       
           MOVE    LNK-PRTKANRI-SRYYM
                                   TO  SHELLTBL-ARG5       
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  SHELLTBL-ARG6       
           MOVE    LNK-PRTKANRI-SHELLID
                                   TO  SHELLTBL-ARG7       
           MOVE    LNK-PRTKANRI-PRIORITY
                                   TO  SHELLTBL-ARG8      
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  SHELLTBL-ARG9       
           MOVE    LNK-PRTKANRI-OPID
                                   TO  SHELLTBL-ARG10      
           MOVE    LNK-PRTKANRI-PRTNM
                                   TO  SHELLTBL-ARG11      
           EVALUATE    SPA-NAI-WIDGET     
               WHEN    "B06"
                   MOVE    "1"         TO  SHELLTBL-ARG12
               WHEN    "B07"
                   MOVE    "2"         TO  SHELLTBL-ARG12
           END-EVALUATE
           STRING  SYS-2005-RECEDENOUT DELIMITED  BY  SPACE
                   "/"                 DELIMITED  BY  SIZE
                               INTO    SHELLTBL-ARG13
           END-STRING
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  SHELLTBL-ARG14
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  SHELLTBL-ARG15         
           MOVE    RECEERR         TO  SHELLTBL-ARG16
           MOVE    SHELLTBL        TO  MCPDATA-REC
           MOVE    "SHELL"         TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL
                                   TO  MCP-PATH
           CALL    "MCPSUB"        USING
                                   MCPAREA
                                   MCPDATA-REC
      *
      *    印刷処理
      *
           IF      SPA-TID1-FLG        =   "OK"
               PERFORM 45011-JOBKANRI-HENSYU-SEC
      *
               MOVE    0                   TO  WRK-STPAGE
               MOVE    99999               TO  WRK-EDPAGE
      *             
               MOVE    SPACE               TO  SHELLTBL
               MOVE    "/scripts/allways/print.sh"
                                           TO  WRK-SHELL-NAME
      *        ファイルデイレクトリ位置指定
               INITIALIZE                  ORCSMKPASSAREA
               MOVE    WRK-SHELL-NAME      TO  MKPASS-IN-01
               CALL    "ORCSMKPASS"        USING   ORCSMKPASSAREA
               MOVE    MKPASS-OT-01        TO  SHELLTBL-NAME
      *                               
               MOVE    SPACE               TO  LNK-PRTKANRI-AREA
               INITIALIZE                      LNK-PRTKANRI-AREA
               MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                           TO  LNK-PRTKANRI-TBL-KEY 
               MOVE    WRK-CONS-PRTKANRI-TBL-GROUP
                                           TO  LNK-PRTKANRI-TBL-GROUP
               MOVE    ZERO                TO  LNK-PRTKANRI-RENNUM
               MOVE    ZERO                TO  LNK-PRTKANRI-SHORI-RENNUM
               MOVE    SPA-NAI-SKYYM       TO  LNK-PRTKANRI-SRYYM 
               MOVE    SPA-NAI-SKYYMD      TO  LNK-PRTKANRI-SKYYMD
               MOVE    "print.sh"          TO  LNK-PRTKANRI-SHELLID
               MOVE    ZERO                TO  LNK-PRTKANRI-PRIORITY
               MOVE    SPA-TERMID          TO  LNK-PRTKANRI-TERMID
               MOVE    SPA-OPID            TO  LNK-PRTKANRI-OPID
               MOVE    LNK-PRTKANRI-RENNUM TO  SHELLTBL-ARG1       
               MOVE    LNK-PRTKANRI-TBL-KEY
                                           TO  SHELLTBL-ARG2     
               MOVE    LNK-PRTKANRI-TBL-GROUP
                                           TO  SHELLTBL-ARG3       
               MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                           TO  SHELLTBL-ARG4       
               MOVE    LNK-PRTKANRI-SRYYM  TO  SHELLTBL-ARG5       
               MOVE    LNK-PRTKANRI-SKYYMD TO  SHELLTBL-ARG6       
               MOVE    LNK-PRTKANRI-SHELLID
                                           TO  SHELLTBL-ARG7       
               MOVE    LNK-PRTKANRI-PRIORITY
                                           TO  SHELLTBL-ARG8      
               MOVE    LNK-PRTKANRI-TERMID TO  SHELLTBL-ARG9       
               MOVE    LNK-PRTKANRI-OPID   TO  SHELLTBL-ARG10      
               MOVE    LNK-PRTKANRI-PRTNM  TO  SHELLTBL-ARG11      
      *                 
               MOVE    RECEERR             TO  SHELLTBL-ARG12
               MOVE    WRK-CONS-JOB-JOBID  TO  SHELLTBL-ARG13
               MOVE    WRK-CONS-JOB-SHELLID
                                           TO  SHELLTBL-ARG14
               MOVE    WRK-STPAGE          TO  SHELLTBL-ARG15
               MOVE    WRK-EDPAGE          TO  SHELLTBL-ARG16
               MOVE    SHELLTBL            TO  MCPDATA-REC
               MOVE    "SHELL"             TO  MCP-FUNC
               MOVE    PATH-SHELL-SHELL    TO  MCP-PATH
               CALL    "MCPSUB"            USING
                                           MCPAREA
                                           MCPDATA-REC
           END-IF       
      *
      *    ＪＯＢＩＤ更新処理
      *
           PERFORM 45012-JOBID-UPD-SEC
      *     
      *    情報確認画面を表示                                                   
           PERFORM 490-KAKUNIN-SEC
           .
       460-RECEDEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷前処理（チェック・集計表）
      *****************************************************************
       480-PRINT-GID-SEC                SECTION.
      *
      *    ジョブ管理チェック（レセプト）
           MOVE    "CHK"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID-RECEPT1
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID-RECEPT1
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC 
          IF      SJOBKANRI-RETURN =   ZERO
               IF      JOB-ENDYMD      =   SPACE
                   MOVE    "7777"          TO  SPA-ERRCD
                   MOVE    SPACE             TO  WRK-RECEERR
                   STRING  "レセプト作成処理中です【"
                                             DELIMITED  BY  SIZE
                           JOB-SHELLMSG      DELIMITED  BY  SPACE
                           "】"              DELIMITED  BY  SIZE      
                                             INTO  WRK-RECEERR
               END-IF
           END-IF    
      *
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-NAI-SKYYM       =   ZERO
                   MOVE    "0001"              TO  SPA-ERRCD
                   GO  TO  480-PRINT-GID-EXT
               END-IF    
           END-IF    
      *
           IF      SPA-ERRCD           =   SPACE
      *    ガイドメッセージセット
               EVALUATE    MCP-WIDGET
                   WHEN    "B08" 
                       MOVE    "1011"              TO  SPA-TIDCD
                   WHEN    "B09" 
                       MOVE    "1012"              TO  SPA-TIDCD
                   WHEN    "B10" 
                       MOVE    "1013"              TO  SPA-TIDCD
               END-EVALUATE
           END-IF
           .
       480-PRINT-GID-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷処理（チェック・集計表）
      *****************************************************************
       480-PRINT-SEC                 SECTION.
      *                                 
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    SPA-TERMID          TO  RECEERR-TERMID
      *****MOVE    RECEERR             TO  SHELL-ERRFILE
           OPEN    OUTPUT   RECEERR-FILE
           CLOSE   RECEERR-FILE
      *
           MOVE    SPACE               TO  SHELLTBL 
           EVALUATE    SPA-TIDCD
               WHEN    "1011"
                   MOVE    "scripts/monthly/recept5.sh" 
                                               TO  WRK-SHELL-NAME
                   MOVE    "0"                 TO  WRK-SHELL-RECEKBN
               WHEN    "1012"
                   MOVE    "1"                 TO  WRK-SHELL-RECEKBN
                   MOVE    "scripts/monthly/sokatsu.sh"
                                               TO  WRK-SHELL-NAME
               WHEN    "1013"
                   MOVE    "scripts/monthly/sokatsu.sh"
                                               TO  WRK-SHELL-NAME
                   MOVE    "2"                 TO  WRK-SHELL-RECEKBN
           END-EVALUATE
      *    ファイルデイレクトリ位置指定
           INITIALIZE                  ORCSMKPASSAREA
           MOVE    WRK-SHELL-NAME      TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"        USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01        TO  SHELLTBL-NAME
      *     
           MOVE    SPA-NAI-SKYYM       TO  WRK-SHELL-SRYYM 
           MOVE    SPA-TERMID          TO  WRK-SHELL-TERMID
           MOVE    SPA-SYSYMD          TO  WRK-SHELL-SYSYMD    
           MOVE    WRK-SHELL-ARG1      TO  SHELLTBL-ARG1
           MOVE    WRK-SHELL-RECEKBN   TO  SHELLTBL-ARG2
           MOVE    RECEERR             TO  SHELLTBL-ARG3
           MOVE    SPA-HOSPID          TO  SHELLTBL-ARG4
           MOVE    SPA-TERMID          TO  SHELLTBL-ARG5
           MOVE    SHELLTBL            TO  MCPDATA-REC
           MOVE    "SHELL"             TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL    TO  MCP-PATH
           CALL    "MCPSUB"            USING   MCPAREA
                                               MCPDATA-REC                         
          .
       480-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    情報削除画面へ
      *****************************************************************
       490-JYOUHOU-DEL-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-T01             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "T01"               TO  SPA-MOTOPG
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
      *
      *****************************************************************
      *    再印刷画面へ
      *****************************************************************
       450-REPRINT-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-T01             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "T01"               TO  SPA-MOTOPG
           MOVE    "XA01"              TO  SPA-SAKIPG
      *
           MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                       TO  SPA-PRTKANRI-TBL-KEY
      *          
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   "XA01   "            TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       450-REPRINT-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    処理確認処理
      *****************************************************************
       490-KAKUNIN-SEC            SECTION.
      *
           MOVE    SPACE               TO  T99
           MOVE    ZERO                TO  T99-COUNT
      *        
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-NAI-SKYYM       TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2)
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-3003-REC 
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SYS-3003-JOBID
      *            ジョブ管理チェック処理
                   MOVE    "CHK"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    IDX             TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA  
                                           JOBKANRI-REC 
                   IF      SJOBKANRI-RETURN    =   ZERO
                       MOVE    JOB-JOBID       TO  T99-RENNUM   (IDX)
                       MOVE    JOB-SHELLMSG    TO  T99-SHORINM  (IDX)
                       MOVE    JOB-STARTTIME(1:2)
                                               TO  WRK-HH
                       MOVE    JOB-STARTTIME(3:2)
                                               TO  WRK-MM
                       MOVE    JOB-STARTTIME(5:2)
                                               TO  WRK-SS
                       MOVE    WRK-HENTIME     TO  T99-STARTTIME(IDX)
                       MOVE    JOB-ENDTIME(1:2)
                                               TO  WRK-HH
                       MOVE    JOB-ENDTIME(3:2)
                                               TO  WRK-MM
                       MOVE    JOB-ENDTIME(5:2)
                                               TO  WRK-SS
                       MOVE    WRK-HENTIME     TO  T99-ENDTIME  (IDX)
                       MOVE    JOB-UPDCNT      TO  WRK-PAGE
                       MOVE    WRK-PAGE        TO  T99-PAGE     (IDX)
                       MOVE    JOB-YOBI        TO  T99-ERRMSG   (IDX)
                       IF      JOB-ENDYMD      =   SPACE
                           MOVE    "処理中です"    TO  T99-MSG
                       ELSE
                           IF      JOB-ERRCD       =   SPACE
                               CONTINUE
                           ELSE
                               STRING  JOB-YOBI    DELIMITED  BY  SPACE
                                       "【"        DELIMITED  BY  SIZE
                                      JOB-SHELLMSG DELIMITED  BY  SPACE
                                      "】"         DELIMITED  BY  SIZE      
                                                   INTO  T99-MSG
                           END-IF                          
                       END-IF    
                       MOVE    IDX                     TO  T99-COUNT    
                   END-IF
               END-PERFORM
           END-IF
           IF      T99-MSG              =   SPACE
               MOVE    "B01"                TO  MCP-WIDGET
               IF      T99-COUNT            >   ZERO    
                   MOVE    "処理は正常に終了しました"
                                                TO  T99-MSG
               ELSE
                   MOVE    "該当する処理はありません"
                                                TO  T99-MSG
               END-IF                                 
           ELSE                                        
               MOVE    "B11"                TO  MCP-WIDGET
           END-IF                                 
      *
           MOVE    "T01"                TO  SPA-MOTOPG
           MOVE    "T99"                TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "T99"                TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
           .
       490-KAKUNIN-EXT.
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
           IF      SPA-TIDCD       NOT =   SPACE
               EVALUATE    SPA-TIDCD
                   WHEN    "1001"
                   WHEN    "1002"
                   WHEN    "1003"  
                   WHEN    "1004"
                   WHEN    "1005"
                   WHEN    "1010"
                   WHEN    "1014"  
                       PERFORM 530-TID2SET-SEC
                       GO  TO  500-SET-SCREEN-EXT
                   WHEN    OTHER
                       PERFORM 520-TIDSET-SEC
                       GO  TO  500-SET-SCREEN-EXT
               END-EVALUATE
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "T01    "           TO  MCP-WINDOW.
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
           MOVE    SPACE               TO  T01
      *
           MOVE    SPA-GMN-SKYYM       TO  T01-SKYYM
           MOVE    SPA-GMN-SRYYM       TO  T01-SRYYM-VALUE
           MOVE    SPA-GMN-SKYYMD      TO  T01-SKYYMD
           MOVE    SPA-GMN-HKNJANUM    TO  T01-HKNJANUM
           MOVE    SPA-GMN-HKNJAMEI    TO  T01-HKNJAMEI
      *
           MOVE    SPA-B06-STATE       TO  T01-B06-STATE
           MOVE    SPA-B07-STATE       TO  T01-B07-STATE
           MOVE    SPA-SRYYM-STATE     TO  T01-SRYYM-STATE
           MOVE    SPA-DATAKBN1-STATE  TO  T01-DATAKBN1-STATE
           MOVE    SPA-DATAKBN2-STATE  TO  T01-DATAKBN2-STATE
           MOVE    SPA-DATAKBN3-STATE  TO  T01-DATAKBN3-STATE
           MOVE    SPA-DATAKBN4-STATE  TO  T01-DATAKBN4-STATE
           MOVE    SPA-DATAKBN5-STATE  TO  T01-DATAKBN5-STATE
           MOVE    SPA-DATAKBN1-VALUE  TO  T01-DATAKBN1-VALUE
           MOVE    SPA-DATAKBN2-VALUE  TO  T01-DATAKBN2-VALUE
           MOVE    SPA-DATAKBN3-VALUE  TO  T01-DATAKBN3-VALUE
           MOVE    SPA-DATAKBN4-VALUE  TO  T01-DATAKBN4-VALUE
           MOVE    SPA-DATAKBN5-VALUE  TO  T01-DATAKBN5-VALUE
      *
           MOVE    SPA-GMN-PRTKBN1-VALUE
                                       TO  T01-PRTKBN1-VALUE
           MOVE    SPA-GMN-PRTKBN1-STYLE
                                       TO  T01-PRTKBN1-STYLE                                 
           MOVE    SPA-GMN-PRTKBN2-VALUE
                                       TO  T01-PRTKBN2-VALUE
           MOVE    SPA-GMN-PRTKBN2-STYLE
                                       TO  T01-PRTKBN2-STYLE                                 
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
                    MOVE  "SKYYM"      TO  MCP-WIDGET   
             WHEN    2
                    MOVE  "SKYYMD"     TO  MCP-WIDGET   
             WHEN    3
                    MOVE  "HKNJANUM"   TO  MCP-WIDGET   
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
                   MOVE    "請求年月が未入力です" 
                                               TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "請求年月日が未入力です" 
                                               TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "請求年月入力エラー" 
                                               TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "請求年月日入力エラー" 
                                               TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "保険者番号入力エラー" 
                                               TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "レセプトが作成されていません"
                                                       TO  SPA-ERRMSG
               WHEN    "0012"
                   MOVE    "再印刷できない帳票です"    TO  SPA-ERRMSG
               WHEN    "1004"
                   MOVE    "ジョブ管理ＤＢが削除できませんでした"
                                                       TO  SPA-ERRMSG
               WHEN    "1005"
                   MOVE
                   "システム管理ＤＢ（３００３）が削除できませんでした"
                                                       TO  SPA-ERRMSG
               WHEN    "7777"
                   MOVE    WRK-RECEERR                 TO  SPA-ERRMSG
               WHEN    "9999"
                   MOVE    WRK-RECEERR                 TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  TERR
           MOVE    SPA-ERRCD            TO  TERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  TERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "T01"                TO  SPA-MOTOPG
           MOVE    "TERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "TERR"               TO  MCP-WINDOW
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
       520-TIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-TIDMSG
      *
           EVALUATE    SPA-TIDCD
               WHEN    "1011"
                   MOVE    "チェックリストの印刷処理を行います"
                                       TO  WRK-TIDMSG
               WHEN    "1012"
                   MOVE    "集計表（社保）の印刷処理を行います"
                                       TO  WRK-TIDMSG
               WHEN    "1013"
                   MOVE    "集計表（国保）の印刷処理を行います"
                                       TO  WRK-TIDMSG
               WHEN    "6666"
                   MOVE    "印刷処理中です"
                                            TO  WRK-TIDMSG
               WHEN    "8888"
                   MOVE    "処理が正常終了しました"
                                            TO  WRK-TIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  TID1
           MOVE    SPA-TIDCD            TO  TID1-ID1CODE
           MOVE    WRK-TIDMSG           TO  TID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "T01"                TO  SPA-MOTOPG
           MOVE    "TID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "TID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-TIDSET-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       530-TID2SET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-TIDMSG
      *
           EVALUATE    SPA-TIDCD
               WHEN    "1001"
                   MOVE    "総括表・請求書の印刷処理を行います"
                                       TO  WRK-TIDMSG
               WHEN    "1002"
                   MOVE    "総括表の印刷処理を行います"
                                       TO  WRK-TIDMSG
               WHEN    "1003"
                   MOVE    "請求書の印刷処理を行います"
                                       TO  WRK-TIDMSG
               WHEN    "1004"
                   MOVE    "総括表（社保）の印刷処理を行います"
                                       TO  WRK-TIDMSG
               WHEN    "1005"
                   MOVE    "総括表（国保）の印刷処理を行います" 
                                       TO  WRK-TIDMSG
               WHEN    "1010"
                   MOVE    "社保分のレセプト電算データを作成します"
                                       TO  WRK-TIDMSG
                   MOVE    "（症状詳記の印刷を指定）"
                                       TO  WRK-TIDMSG (39:)
               WHEN    "1014"
                   MOVE    "国保分のレセプト電算データを作成します"
                                       TO  WRK-TIDMSG
                   MOVE    "（症状詳記の印刷を指定）"
                                       TO  WRK-TIDMSG (39:)
           END-EVALUATE
      *
           MOVE    SPACE                TO  TID2
           MOVE    SPA-TIDCD            TO  TID2-ID1CODE
           MOVE    WRK-TIDMSG           TO  TID2-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "T01"                TO  SPA-MOTOPG
           MOVE    "TID2"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "TID2"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       530-TID2SET-EXT.
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
      *    保険者マスター読込（キー）
      *****************************************************************
       900-HKNJAINF-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNJAINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "HKNJAINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-HKNJAINF
                   MOVE    MCPDATA-REC         TO  HKNJAINF-REC
               ELSE
                   MOVE    1                   TO  FLG-HKNJAINF
               END-IF
           ELSE
               MOVE    1                   TO  FLG-HKNJAINF
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNJAINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-HKNJAINF-INV-EXT.
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
