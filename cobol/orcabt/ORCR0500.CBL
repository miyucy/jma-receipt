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
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
      *
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCR0500.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 労災レセプト帳票ＤＢの印刷
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC-藤原      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-藤原    02/09/12  ディレクトリをサブプロへ
      *  01.00.02    NACL-藤原    02/09/27  帳票ＩＤをＤＢより編集
      *                                     パラメタに入外区分の追加
      *  01.00.03    NACL-藤原    02/10/21  印刷用ファイルにサイト区分を追加
      *  01.00.04    NACL-藤原    03/01/10  印刷順通し番号を追加
      *  01.00.05    NACL-門脇    03/01/31  事業所名の長さ変更のため
      *                                     帳票ＩＤ追加
      *  01.00.06    NACL-門脇    03/02/12  医療機関名の長さ変更のため
      *                                     帳票ＩＤ追加
      *  01.00.07    NACL-藤原    03/02/14  頁数のジョブ管理ＤＢへの更新
      *  01.00.08    NACL-藤原    03/02/24  プリンタ名をオンラインより渡す
      *  01.00.09    NACL-藤原    03/03/03  再印刷機能のためにパラメタを追加
      *
      *  労災・自賠責入院機能追加
      *  01.01.01    NACL-藤原    03/07/20  労災・自賠責の入院帳票ＩＤ追加
      *  01.01.02    NACL-門脇    04/01/26  カナ氏名の長さ等修正
      *                                     HCM22V02.REDを追加
      *                                     HCM24V02.REDを追加
      *                                     HCM21V02.REDを追加
      *                                     HCM18V02.REDを追加
      *                                     HCM20V02.REDを追加
      *                                     HCM23V02.REDを追加
      *                                     HCM29V01.REDを追加
      *                                     HCN22V01.REDを追加
      *                                     HCN21V01.REDを追加
      *                                     HCN23V01.REDを追加
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    印刷用データ
           SELECT  PRT-FILE        ASSIGN  HC01PARA
                                   ORGANIZATION    IS  LINE
                                                       SEQUENTIAL 
                                   FILE    STATUS  IS  STS-PRT.
      *
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    印刷用データ
       FD  PRT-FILE.
       01  PRT-REC.
           03  PRT-PRTID           PIC X(30).
           03  PRT-PRTNM           PIC X(20).
           03  PRT-SITEKBN         PIC X(01).
           03  PRT-PRTDATA         PIC X(10000).
      *
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *    シェル用領域
      *****COPY    "CPCOMMONSHELL.INC".
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME            PIC 9(08).    
      *
      *    スパ領域
       01  STS-AREA.
           03  STS-PRT             PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-RECEPRT         PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-IN              PIC 9(04).
           03  CNT-OUT             PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-RECEERR             PIC X(200). 
      *
           03  WRK-PATH                PIC X(64). 
      *
      *    通し番号
           03  WRK-RENNUM              PIC 9(05).
      *
      *    通し番号編集エリア
           03  WRK-HEN-RENNUM-AREA.
               05  WRK-HEN-RENNUM1     PIC ZZZZZZ9.
               05  WRK-HEN-RENNUM-R    REDEFINES   WRK-HEN-RENNUM1.   
                   07  FILLER          PIC X(01).
                   07  WRK-HEN-FL1     PIC X(01).
                   07  WRK-HEN-RENNUM2 PIC ZZZ9.
                   07  WRK-HEN-FL2     PIC X(01).
      *
           03  WRK-PARA.
               05  WRK-PARA-JOBID                PIC 9(07).
               05  WRK-PARA-SHELLID              PIC X(08).
               05  WRK-PARA1.  
                   07  WRK-PARA-SRYYM            PIC X(06).
                   07  WRK-PARA-TERMID           PIC X(16).
                   07  WRK-PARA-SYSYMD           PIC X(08).
               05  WRK-PARA-RECE09-KEY. 
                   07  WRK-PARA-RECE09-PRTID     PIC X(04).
                   07  WRK-PARA-RECE09-SRYYM     PIC X(06).
                   07  WRK-PARA-RECE09-CREYMD    PIC X(08).
                   07  WRK-PARA-RECE09-CREHMS    PIC X(06).
                   07  WRK-PARA-RECE09-PREFKBN   PIC X(01).
                   07  WRK-PARA-RECE09-TEISYUTUSAKI
                                                 PIC X(01).
                   07  WRK-PARA-RECE09-RECESYUBETU
                                                 PIC X(04).
                   07  WRK-PARA-RECE09-NYUGAIKBN PIC X(01).                              
               05  WRK-PARA-TERMID64             PIC X(64).
               05  WRK-PARA-SYOKBN               PIC X(01).
               05  WRK-PARA-PRTNM                PIC X(16).
      *
           COPY    "CPORCSPRTLNK.INC".
      *
      *    労災レセプト
           COPY    "HCM21.INC".
           COPY    "HCM21V01.INC".
           COPY    "HCM21V02.INC".
           COPY    "HCM22.INC".
           COPY    "HCM22V01.INC".
           COPY    "HCM22V02.INC".
           COPY    "HCM24.INC".
           COPY    "HCM24V01.INC".
           COPY    "HCM24V02.INC".
           COPY    "HCM18.INC".
           COPY    "HCM18V01.INC".
           COPY    "HCM18V02.INC".
           COPY    "HCM20.INC".
           COPY    "HCM20V01.INC".
           COPY    "HCM20V02.INC".
      *
           COPY    "HCN21.INC".
           COPY    "HCN21V01.INC".
           COPY    "HCN22.INC".
           COPY    "HCN22V01.INC".
      *
      *    自賠責レセプト
           COPY    "HCM23.INC".
           COPY    "HCM23V01.INC".
           COPY    "HCM23V02.INC".
           COPY    "HCM29.INC".
           COPY    "HCM29V01.INC".
      *
           COPY    "HCN23.INC".
           COPY    "HCN23V01.INC".
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".         
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *     
      *    レセプト印刷情報
           COPY    "CPSK2005.INC".
      *
           COPY    "CPRCF008.INC".
      *
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".          
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    印刷ＤＢ更新サブ
           COPY    "CPORCSPRT.INC".          
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      ****************************************************************
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(2000).
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
                   UNTIL       FLG-END     =   1
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
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
      *
           ACCEPT  SYS-TIME            FROM    TIME     
      *
           UNSTRING    COMMAND-PARAM   DELIMITED  BY  ","
                                       INTO  WRK-PARA-JOBID
                                             WRK-PARA-SHELLID
                                             WRK-PARA1
                                             WRK-PARA-RECE09-KEY
                                             WRK-PARA-TERMID64
                                             WRK-PARA-SYOKBN
                                             WRK-PARA-PRTNM
                                             LNK-PRTKANRI-RENNUM
                                             LNK-PRTKANRI-TBL-KEY
                                             LNK-PRTKANRI-TBL-GROUP
                                             LNK-PRTKANRI-SHORI-RENNUM
                                             LNK-PRTKANRI-SRYYM
                                             LNK-PRTKANRI-SKYYMD
                                             LNK-PRTKANRI-SHELLID
                                             LNK-PRTKANRI-PRIORITY
                                             LNK-PRTKANRI-TERMID
                                             LNK-PRTKANRI-OPID    
                                             LNK-PRTKANRI-PRTNM
           END-UNSTRING                                  
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCR0500"      TO  JOB-PGID
           MOVE    "レセプト印刷処理"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
      *    レセプト通し番号情報処理
           PERFORM 110-SYSKANRI-HENSYU-SEC
      *
           MOVE    "HC21"              TO  HC01PARA-FORM-ID
           MOVE    LNK-PRTKANRI-TERMID TO  HC01PARA-TERMID
           MOVE    SYS-TIME            TO  HC01PARA-SYOHMS
           MOVE    1                   TO  HC01PARA-CNT
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト通し番号情報処理
      *****************************************************************
       110-SYSKANRI-HENSYU-SEC                   SECTION.
      *
      *    レセプト印刷情報編集
           MOVE    SPACE               TO  SYS-2005-REC
           INITIALIZE                  SYS-2005-REC
           MOVE    "2005"              TO  SYS-2005-KANRICD
           MOVE    "*"                 TO  SYS-2005-KBNCD
           MOVE    SYS-2005-REC        TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-2005-REC
           ELSE    
               INITIALIZE                  SYS-2005-REC
           END-IF
           .
       110-PARA-HENSYU-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    通し番号初期値設定
           MOVE    ZERO                TO  WRK-RENNUM 
      *
           MOVE    SPACE               TO  WRK-HEN-RENNUM-AREA
           IF      WRK-PARA-SYOKBN     =   "2"
               MOVE    "["                 TO  WRK-HEN-FL1
               MOVE    "]"                 TO  WRK-HEN-FL2
           END-IF              
      *
      *    帳票印刷処理
      *
           OPEN    OUTPUT              PRT-FILE
      *
      *****MOVE    "RECEPRT-KEY3"      TO  WRK-PATH
           MOVE    "RECEPRT-KEY12"     TO  WRK-PATH
           PERFORM 900-RECEPRT-SELECT-SEC
      *
           PERFORM 2001-RECEPRT-PRINT-SEC
                                       UNTIL   FLG-RECEPRT  =   1
      *
      *****MOVE    "RECEPRT-KEY3"      TO  WRK-PATH
           MOVE    "RECEPRT-KEY12"     TO  WRK-PATH
           PERFORM 900-RECEPRT-CLS-SEC
      *
           CLOSE                       PRT-FILE
      *
      *    帳票クリア処理
      *****MOVE    "RECEPRT-KEY4"      TO  WRK-PATH
           MOVE    "RECEPRT-KEY13"     TO  WRK-PATH
           PERFORM 900-RECEPRT-SELECT-SEC
      *
           PERFORM 2002-RECEPRT-CLEAR-SEC
                                       UNTIL   FLG-RECEPRT  =   1
      *
      *****MOVE    "RECEPRT-KEY4"      TO  WRK-PATH
           MOVE    "RECEPRT-KEY13"     TO  WRK-PATH
           PERFORM 900-RECEPRT-CLS-SEC
      *
      *   印刷用スクリプト処理
      *
           IF      CNT-OUT             >   ZERO 
      *
               MOVE    SPACE           TO  SHELLTBL
      *        ファイルデイレクトリ位置指定
               INITIALIZE              ORCSMKPASSAREA
               MOVE    "scripts/daily/HCALL2.sh"
                                       TO  MKPASS-IN-01
               CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
               MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *         
               MOVE    HC01PARA        TO  SHELLTBL-ARG1
               MOVE    SHELLTBL        TO  MCPDATA-REC
               MOVE    "SHELL"         TO  MCP-FUNC
               MOVE    PATH-SHELL-SHELL
                                       TO  MCP-PATH
               CALL    "MCPSUB"        USING
                                           MCPAREA
                                           MCPDATA-REC
      *
      *        最新以外の帳票管理ＤＢを削除
               MOVE    SPACE           TO  PRTKANRI-REC
               INITIALIZE                  PRTKANRI-REC
               MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  PRTKANRI-PRIORITY
               MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  PRTKANRI-TBL-GROUP
               MOVE    PRTKANRI-REC    TO  MCPDATA-REC
               MOVE    "DBDELETE"      TO  MCP-FUNC
               IF      WRK-PARA-SYOKBN     =   "1"
                   MOVE    PATH-TBL-PRTKANRI-DEL12
                                           TO  MCP-PATH
               ELSE
                   MOVE    PATH-TBL-PRTKANRI-DEL13
                                           TO  MCP-PATH
               END-IF
               CALL    "MCPSUB"            USING
                                           MCPAREA
                                           MCPDATA-REC
      *
      *        最新以外の帳票ＤＢを削除
               MOVE    SPACE           TO  PRTDATA-REC
               INITIALIZE                  PRTDATA-REC
               MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  PRTDATA-PRIORITY
               MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  PRTDATA-TBL-GROUP
               MOVE    PRTDATA-REC     TO  MCPDATA-REC
               MOVE    "DBDELETE"      TO  MCP-FUNC
               IF      WRK-PARA-SYOKBN     =   "1"
                   MOVE    PATH-TBL-PRTDATA-DEL12
                                           TO  MCP-PATH
               ELSE
                   MOVE    PATH-TBL-PRTDATA-DEL13
                                           TO  MCP-PATH
               END-IF
               CALL    "MCPSUB"            USING
                                           MCPAREA
                                           MCPDATA-REC
           END-IF                                                
      *
           MOVE    1                   TO  FLG-END     
           .
       200-MAIN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       2001-RECEPRT-PRINT-SEC          SECTION.
      * 
           MOVE    SPACE               TO  PRT-REC 
      *****EVALUATE    RECE08-RECESYUBETU  ALSO    RECE08-PRTID  
      *        短期給付             
      *        WHEN    "7071"              ALSO    "HC21"
      *        WHEN    "7072"              ALSO    "HC21"
      *        WHEN    "0000"              ALSO    "HC21"
      *            MOVE    "HC22"          TO  PRT-PRTID   
      *        WHEN    "7073"              ALSO    "HC21" 
      *            MOVE    "HC24"          TO  PRT-PRTID   
      *        傷病年金             
      *        WHEN    "7091"              ALSO    "HC21"
      *        WHEN    "7092"              ALSO    "HC21"
      *            MOVE    "HC21"          TO  PRT-PRTID   
      *        WHEN    "7093"              ALSO    "HC21"
      *            MOVE    "HC24"          TO  PRT-PRTID
      *        アフターケア             
      *        WHEN    "7021"              ALSO    "HC21"
      *            MOVE    "HC18"          TO  PRT-PRTID   
      *        WHEN    "7023"              ALSO    "HC21"
      *            MOVE    "HC20"          TO  PRT-PRTID   
      *        自賠責             
      *        WHEN    "7001"              ALSO    "HC23"
      *        WHEN    "0000"              ALSO    "HC23"
      *            MOVE    "HC23"          TO  PRT-PRTID   
      *        WHEN    "7002"              ALSO    "HC23"
      *            MOVE    "HC29"          TO  PRT-PRTID   
      *****END-EVALUATE
           MOVE    RECE08-FORMID       TO  PRT-PRTID
      *****MOVE    SYS-1031-PRTNM(4)   TO  PRT-PRTNM 
           MOVE    WRK-PARA-PRTNM      TO  PRT-PRTNM
      *
      *    通し番号印刷のときのみ編集
           IF      SYS-2005-RENNUMHENKBN   =   "1"
               ADD     1                   TO  WRK-RENNUM
               IF      WRK-PARA-SYOKBN     =   "1"
                   MOVE    WRK-RENNUM          TO  WRK-HEN-RENNUM1
               ELSE
                   MOVE    WRK-RENNUM          TO  WRK-HEN-RENNUM2
               END-IF        
      *         
               EVALUATE    RECE08-FORMID
                   WHEN    "HCM21.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM21
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM21-RENNUM
                       MOVE    HCM21               TO  RECE08-PRTDATA
                   WHEN    "HCM21V01.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM21V01
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM21V01-RENNUM
                       MOVE    HCM21V01            TO  RECE08-PRTDATA
                   WHEN    "HCM21V02.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM21V02
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM21V02-RENNUM
                       MOVE    HCM21V02            TO  RECE08-PRTDATA
                   WHEN    "HCM22.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM22
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM22-RENNUM
                       MOVE    HCM22               TO  RECE08-PRTDATA
                   WHEN    "HCM22V01.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM22V01
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM22V01-RENNUM
                       MOVE    HCM22V01            TO  RECE08-PRTDATA
                   WHEN    "HCM22V02.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM22V02
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM22V02-RENNUM
                       MOVE    HCM22V02            TO  RECE08-PRTDATA
                   WHEN    "HCM24.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM24
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM24-RENNUM
                       MOVE    HCM24               TO  RECE08-PRTDATA
                   WHEN    "HCM24V01.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM24V01
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM24V01-RENNUM
                       MOVE    HCM24V01            TO  RECE08-PRTDATA
                   WHEN    "HCM24V02.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM24V02
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM24V02-RENNUM
                       MOVE    HCM24V02            TO  RECE08-PRTDATA
                   WHEN    "HCM18.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM18
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM18-RENNUM
                       MOVE    HCM18               TO  RECE08-PRTDATA
                   WHEN    "HCM18V01.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM18V01
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM18V01-RENNUM
                       MOVE    HCM18V01            TO  RECE08-PRTDATA
                   WHEN    "HCM18V02.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM18V02
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM18V02-RENNUM
                       MOVE    HCM18V02            TO  RECE08-PRTDATA
                   WHEN    "HCM20.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM20
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM20-RENNUM
                       MOVE    HCM20               TO  RECE08-PRTDATA
                   WHEN    "HCM20V01.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM20V01
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM20V01-RENNUM
                       MOVE    HCM20V01            TO  RECE08-PRTDATA
                   WHEN    "HCM20V02.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM20V02
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM20V02-RENNUM
                       MOVE    HCM20V02            TO  RECE08-PRTDATA
                   WHEN    "HCM23.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM23
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM23-RENNUM
                       MOVE    HCM23               TO  RECE08-PRTDATA
                   WHEN    "HCM23V01.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM23V01
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM23V01-RENNUM
                       MOVE    HCM23V01            TO  RECE08-PRTDATA
                   WHEN    "HCM23V02.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM23V02
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM23V02-RENNUM
                       MOVE    HCM23V02            TO  RECE08-PRTDATA
                   WHEN    "HCM29.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM29
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM29-RENNUM
                       MOVE    HCM29               TO  RECE08-PRTDATA
                   WHEN    "HCM29V01.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM29V01
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM29V01-RENNUM
                       MOVE    HCM29V01            TO  RECE08-PRTDATA
                   WHEN    "HCN21.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCN21
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCN21-RENNUM
                       MOVE    HCN21               TO  RECE08-PRTDATA
                   WHEN    "HCN21V01.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCN21V01
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCN21V01-RENNUM
                       MOVE    HCN21V01            TO  RECE08-PRTDATA
                   WHEN    "HCN22.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCN22
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCN22-RENNUM
                       MOVE    HCN22               TO  RECE08-PRTDATA
                   WHEN    "HCN22V01.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCN22V01
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCN22V01-RENNUM
                       MOVE    HCN22V01            TO  RECE08-PRTDATA
                   WHEN    "HCN23.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCN23
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCN23-RENNUM
                       MOVE    HCN23               TO  RECE08-PRTDATA
                   WHEN    "HCN23V01.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCN23V01
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCN23V01-RENNUM
                       MOVE    HCN23V01            TO  RECE08-PRTDATA
               END-EVALUATE
           END-IF            
           MOVE    RECE08-PRTDATA      TO  PRT-PRTDATA
           WRITE   PRT-REC
      *
           ADD     1                   TO  CNT-OUT     
      *
           PERFORM 390-PRINT-OUT-SEC
      *
           PERFORM 900-RECEPRT-FET-SEC
      *
           .
       2001-RECEPRT-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       390-PRINT-OUT-SEC                SECTION.
      *     
           INITIALIZE                  ORCSPRTAREA
           MOVE    "INS"               TO  SPRT-MODE
           MOVE    LNK-PRTKANRI-RENNUM TO  SPRT-RENNUM
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  SPRT-TBL-KEY
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  SPRT-TBL-GROUP
           IF      WRK-PARA-SYOKBN     =   "1"
               MOVE    LNK-PRTKANRI-SRYYM  TO  SPRT-SRYYM
           ELSE
               MOVE    ZERO                TO  SPRT-SRYYM
           END-IF
           MOVE    LNK-PRTKANRI-SKYYMD TO  SPRT-SKYYMD
           MOVE    LNK-PRTKANRI-SHELLID 
                                       TO  SPRT-SHELLID
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                       TO  SPRT-SHORI-RENNUM
           MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  SPRT-PRIORITY
           MOVE    RECE08-FORMID       TO  SPRT-PRTID
           MOVE    RECE08-PRTDATA      TO  SPRT-PRTDATA
      *
         
           EVALUATE    RECE08-FORMID   ALSO    RECE08-NYUGAIKBN
               WHEN    "HC21"          ALSO    ANY 
               WHEN    "HCM21.red"     ALSO    ANY             
               WHEN    "HCM21V01.red"  ALSO    ANY
               WHEN    "HCM21V02.red"  ALSO    ANY
               WHEN    "HC22"          ALSO    ANY 
               WHEN    "HCM22.red"     ALSO    ANY
               WHEN    "HCM22V01.red"  ALSO    ANY
               WHEN    "HCM22V02.red"  ALSO    ANY
               WHEN    "HC18"          ALSO    ANY 
               WHEN    "HCM18.red"     ALSO    ANY
               WHEN    "HCM18V01.red"  ALSO    ANY
               WHEN    "HCM18V02.red"  ALSO    ANY
               WHEN    "HC20"          ALSO    ANY 
               WHEN    "HCM20.red"     ALSO    ANY
               WHEN    "HCM20V01.red"  ALSO    ANY
               WHEN    "HCM20V02.red"  ALSO    ANY
               WHEN    "HC24"          ALSO    ANY 
               WHEN    "HCM24.red"     ALSO    "2"
               WHEN    "HCM24V01.red"  ALSO    "2"
               WHEN    "HCM24V02.red"  ALSO    "2"
                   MOVE    "労災レセプト（入院外）"    TO  SPRT-TITLE
               WHEN    "HCM23.red"     ALSO    ANY
               WHEN    "HCM23V01.red"  ALSO    ANY
               WHEN    "HCM23V02.red"  ALSO    ANY
               WHEN    "HCM29.red"     ALSO    "2"
               WHEN    "HCM29V01.red"  ALSO    "2"
                   MOVE    "自賠責レセプト（入院外）"  TO  SPRT-TITLE
               WHEN    "HCN21.red"     ALSO    ANY
               WHEN    "HCN21V01.red"  ALSO    ANY
               WHEN    "HCN22.red"     ALSO    ANY
               WHEN    "HCN22V01.red"  ALSO    ANY
               WHEN    "HCM24V01.red"  ALSO    "1"
               WHEN    "HCM24V02.red"  ALSO    "1"
                   MOVE    "労災レセプト（入院）"      TO  SPRT-TITLE
               WHEN    "HCN23.red"     ALSO    ANY
               WHEN    "HCN23V01.red"  ALSO    ANY
               WHEN    "HCM29.red"     ALSO    "1"
               WHEN    "HCM29V01.red"  ALSO    "1"
                   MOVE    "自賠責レセプト（入院）"    TO  SPRT-TITLE
           END-EVALUATE
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    WRK-PARA-PRTNM      TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
           MOVE    "1"                 TO  SPRT-PRTFLG
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF      SPRT-RETURN         =   ZERO
               CONTINUE
           ELSE
               MOVE    "印刷ＤＢに更新できませんでした"
                                          TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC                           
           END-IF                                                              
           .
       390-PRINT-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票クリア処理
      *****************************************************************
       2002-RECEPRT-CLEAR-SEC          SECTION.
      *
      *    出力順エリアのクリア
           MOVE    ZERO                 TO  RECE08-PRTJYUN
           MOVE    ZERO                 TO  RECE08-PRTRENNUM     
      *
           MOVE    RECE08-REC           TO  MCPDATA-REC
           MOVE    "RECEPRT-KEY"        TO  ORC-DBPATH
           MOVE    "DBUPDATE"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF      MCP-RC             =   ZERO
               PERFORM 900-RECEPRT-FET-SEC
           ELSE
               MOVE    "帳票ＤＢの更新でエラーになりました"
                                          TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
          END-IF    
           .
       2001-RECEPRT-CLEAR-EXT.
           EXIT.
      *
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
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    CNT-OUT         TO  JOB-UPDCNT                         
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           DISPLAY "*** ORCR0500 IN  "  CNT-IN
           DISPLAY "*** ORCR0500 OUT "  CNT-OUT
      **** DISPLAY "*** ORCR0500 END ***"
      *****ACCEPT WRK-IN
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *     レセプト管理を主キーで読み込む
      *****************************************************************
       900-RECEPRT-SELECT-SEC          SECTION.
      *
           INITIALIZE                  RECE08-REC
           MOVE    WRK-PARA-RECE09-PRTID    TO  RECE08-PRTID
      *****MOVE    WRK-PARA-RECE09-SRYYM    TO  RECE08-SRYYM
           MOVE    WRK-PARA-RECE09-SRYYM    TO  RECE08-RECEYM
           MOVE    WRK-PARA-RECE09-CREYMD   TO  RECE08-CREYMD
           MOVE    WRK-PARA-RECE09-CREHMS   TO  RECE08-CREHMS
           MOVE    WRK-PARA-RECE09-NYUGAIKBN
                                            TO  RECE08-NYUGAIKBN
      *
           MOVE    RECE08-REC          TO  MCPDATA-REC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *
      *    エラーチェック
           IF      MCP-RC             =   ZERO
               PERFORM 900-RECEPRT-FET-SEC
           ELSE 
               DISPLAY "*** ORCR0500 SELECT ERR " MCP-RC 
               MOVE    1                   TO  FLG-RECEPRT
           END-IF
           .
       900-RECEPRT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *     入力コードマスタを主キーより検索処理
      *****************************************************************
       900-RECEPRT-FET-SEC            SECTION.
      *
           MOVE    WRK-PATH            TO  ORC-DBPATH
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *                                  
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  RECE08-REC
               ADD     1               TO  CNT-IN
               MOVE    ZERO            TO  FLG-RECEPRT
           ELSE
               MOVE    1               TO  FLG-RECEPRT
           END-IF
           .
       900-RECEPRT-FET-EXT.
           EXIT.
      *
      *******************************************************
      *     入力コードマスター クロース１処理
      *****************************************************************
       900-RECEPRT-CLS-SEC            SECTION.
      *
           MOVE    WRK-PATH            TO  ORC-DBPATH
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       900-RECEPRT-CLS-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスタ読み込み
      *****************************************************************
       800-SYSKANRI-READ-SEC           SECTION.
      *
           MOVE    WRK-PARA-SRYYM      TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2)
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
                   MOVE    ZERO            TO  FLG-SYSKANRI
               ELSE
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
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
       800-SYSKANRI-READ-EXT.
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
