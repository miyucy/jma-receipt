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
       PROGRAM-ID.             ORCR0102.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : レセプト帳票ＤＢの印刷
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC-藤原      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     02.03.07  大量印刷用に修正
      *  01.00.02    MCC-藤原     02.03.18  端末ＩＤ
      *                                     X(16)からX(32)に変更
      *  01.00.03    MCC-藤原     02.05.16  個別の時複数診療月で作成するために
      *                                     診療年月を追加
      *  01.00.04    MCC-藤原     02/07/04  社保・国保別出力先プリンタ
      *                                     情報の追加
      *                                     プリンタ名設定のため帳票ファイルの
      *                                     レイアウト変更
      *  01.00.05    NACL-藤原    02/09/12  ディレクトリをサブプロへ
      *
      *  ２００２年１０月改正対応
      *  01.01.01    NACL-藤原    02/09/27  帳票ＩＤをＤＢより編集
      *                                     パラメタに入外区分の追加
      *  01.01.02    NACL-藤原    02/10/21  印刷用ファイルにサイト区分を追加
      *  01.01.03    NACL-藤原    03/01/08  印刷順通し番号を追加
      *  01.01.04    NACL-藤原    03/02/07  頁数のジョブ管理ＤＢへの更新
      *  01.01.05    NACL-藤原    03/02/24  プリンタ名をオンラインより渡す
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
006900*    エラーファイル
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
      *    エラーファイル
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
               05  WRK-PARA-TERMID32             PIC X(32).
               05  WRK-PARA-SYOKBN               PIC X(01).
               05  WRK-PARA-SYAPRTNM             PIC X(16).
               05  WRK-PARA-KKHPRTNM             PIC X(16).
      *
           COPY    "HCM06.INC".
           COPY    "HCM06V01.INC".
           COPY    "HCN06.INC".
           COPY    "HCN061.INC".
           COPY    "HCN062.INC".
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
      *    出力先プリンタ名割り当て情報
           COPY    "CPSK1031.INC".
      *     
      *    レセプト印刷情報
           COPY    "CPSK2005.INC".
      *
           COPY    "CPRCF008.INC".
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
                                             WRK-PARA-TERMID32
                                             WRK-PARA-SYOKBN
                                             WRK-PARA-SYAPRTNM
                                             WRK-PARA-KKHPRTNM
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
           MOVE    "ORCR0102"      TO  JOB-PGID
           MOVE    "レセプト印刷処理"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
      *    出力先プリンタ名割り当て情報処理
      *****PERFORM 110-SYSKANRI-HENSYU-SEC
      *     
           MOVE    "HC06"              TO  HC01PARA-FORM-ID
           MOVE    WRK-PARA-TERMID32   TO  HC01PARA-TERMID
           MOVE    SYS-TIME            TO  HC01PARA-SYOHMS
           MOVE    1                   TO  HC01PARA-CNT
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    出力先プリンタ名割り当て情報処理
      *****************************************************************
       110-SYSKANRI-HENSYU-SEC                   SECTION.
      *
      *    出力先プリンタ名割り当て情報編集
           MOVE    SPACE               TO  SYS-1031-REC
           INITIALIZE                  SYS-1031-REC
           MOVE    "1031"              TO  SYS-1031-KANRICD
           MOVE    "*"                 TO  SYS-1031-KBNCD
           MOVE    SYS-1031-REC        TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1031-REC
           ELSE    
               INITIALIZE                  SYS-1031-REC
           END-IF                                     
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
      *
           IF      SYS-2005-SYAPRTNM   =   SPACE
               MOVE    SYS-1031-PRTNM (4)  TO  SYS-2005-SYAPRTNM
           END-IF                                              
      *
           IF      SYS-2005-KKHPRTNM   =   SPACE
               MOVE    SYS-1031-PRTNM (4)  TO  SYS-2005-KKHPRTNM
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
           IF      CNT-OUT             >   ZERO 
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
      *****MOVE    "HC06"              TO  PRT-PRTID
           MOVE    RECE08-FORMID       TO  PRT-PRTID
      *     
           EVALUATE    RECE08-TEISYUTUSAKI
               WHEN    "0"
               WHEN    "1" 
      *************MOVE    SYS-2005-SYAPRTNM   TO  PRT-PRTNM
                   MOVE    WRK-PARA-SYAPRTNM   TO  PRT-PRTNM
               WHEN    "2" 
      *************MOVE    SYS-2005-KKHPRTNM   TO  PRT-PRTNM
                   MOVE    WRK-PARA-KKHPRTNM   TO  PRT-PRTNM
           END-EVALUATE
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
                   WHEN    "HCM06.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM06
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM06-RENNUM
                       MOVE    HCM06               TO  RECE08-PRTDATA
                   WHEN    "HCM06V01.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM06V01
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM06V01-RENNUM
                       MOVE    HCM06V01            TO  RECE08-PRTDATA
                   WHEN    "HCN06.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCN06
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCN06-RENNUM
                       MOVE    HCN06               TO  RECE08-PRTDATA
                   WHEN    "HCN061.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCN061
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCN061-RENNUM
                       MOVE    HCN061              TO  RECE08-PRTDATA
                   WHEN    "HCN062.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCN062
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCN062-RENNUM
                       MOVE    HCN062              TO  RECE08-PRTDATA
               END-EVALUATE
           END-IF            
      *             
           MOVE    RECE08-PRTDATA      TO  PRT-PRTDATA
           WRITE   PRT-REC
      *
           ADD     1                   TO  CNT-OUT     
      *
           PERFORM 900-RECEPRT-FET-SEC
      *
           .
       2001-RECEPRT-PRINT-EXT.
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
           DISPLAY "*** ORCR0102 IN  "  CNT-IN
           DISPLAY "*** ORCR0102 OUT "  CNT-OUT
      **** DISPLAY "*** ORCR0102 END ***"
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
               DISPLAY "*** ORCR0102 SELECT ERR " MCP-RC 
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
           MOVE    WRK-PARA-SYSYMD     TO  ORC-DBYMD
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
