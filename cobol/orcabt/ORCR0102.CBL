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
      *  01.01.06    NACL-藤原    03/03/03  再印刷機能のためにパラメタを追加
      *  01.01.07    NACL-藤原    03/03/14  住所を５０文字に変更のため
      *                                     HCM06V02.redを追加
      *
      *  ２００３．４改正対応
      *  01.02.01    NACL-藤原    03/04/17  改正対応の外来レセ
      *                                     HCM09.redを追加
      *  01.02.02    NACL-藤原    03/05/16  印刷ＤＢに患者ＩＤも編集する
      *  01.02.03    NACL-藤原    03/04/17  山形レセHCRCP060.redを追加
      *  01.02.04    NACL-藤原    03/08/28  入院外の続紙の対応
      *                                     出力内容指定の処理の追加
      *　プレビュー機能追加
      *  01.03.01    NACL-藤原    03/07/07  プレビュー機能追加
      *  01.03.02    NACL-藤原    03/10/09  福岡レセHCRCP400.redを追加
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
           03  PRT-PRTKBN          PIC X(01).
           03  PRT-OUT             PIC X(165).
           03  PRT-TBL-KEY         PIC X(08).
           03  PRT-RENNUM          PIC 9(04).
           03  PRT-TBL-GROUP       PIC X(14).
           03  PRT-SHORI-RENNUM    PIC 9(04).
           03  PRT-PAGE            PIC 9(05).
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
           03  FLG-PRTKANRI        PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-IN              PIC 9(04).
           03  CNT-OUT             PIC 9(04).
      *
       01  INDEX-AREA.
           03  IDX                     PIC 9(03). 
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
               05  WRK-PARA-SYAPRTNM             PIC X(16).
               05  WRK-PARA-KKHPRTNM             PIC X(16). 
               05  WRK-PARA-SYAPRTNM-NEXT        PIC X(16).
               05  WRK-PARA-KKHPRTNM-NEXT        PIC X(16). 
               05  WRK-PARA-PRTKBN               PIC X(01). 
      *
           COPY    "CPORCSPRTLNK.INC".
      *
           COPY    "HCM06.INC".
           COPY    "HCM06V01.INC".
           COPY    "HCM06V02.INC".
           COPY    "HCN06.INC".
           COPY    "HCN061.INC".
           COPY    "HCN062.INC".
           COPY    "HCM09.INC".
           COPY    "HCRCP060.INC".
           COPY    "HCRCP400.INC".
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".         
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
      *    医療機関情報
           COPY  "CPSK1001.INC".
      *
      *    患者番号構成管理情報
           COPY  "CPSK1009.INC".
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
      *    患者番号変換サブ
           COPY    "CPORCSPTID.INC".
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
                                             WRK-PARA-SYOKBN
                                             WRK-PARA-SYAPRTNM
                                             WRK-PARA-KKHPRTNM
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
                                             WRK-PARA-SYAPRTNM-NEXT
                                             WRK-PARA-KKHPRTNM-NEXT
                                             WRK-PARA-PRTKBN
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
      *    レセプト通し番号情報処理
           PERFORM 110-SYSKANRI-HENSYU-SEC
      *     
           MOVE    "HC06"              TO  HC01PARA-FORM-ID
           MOVE    LNK-PRTKANRI-TERMID TO  HC01PARA-TERMID
           MOVE    SYS-TIME            TO  HC01PARA-SYOHMS
           MOVE    1                   TO  HC01PARA-CNT
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト印刷情報処理
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
      *
      *    医療機関ＩＤ編集
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
           ELSE
               MOVE    "医療機関情報が取得できませんでした。"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
      *    患者番号構成管理情報編集
           MOVE    SPACE               TO  SYS-1009-REC
           INITIALIZE                  SYS-1009-REC
           MOVE    "1009"              TO  SYS-1009-KANRICD
           MOVE    "*"                 TO  SYS-1009-KBNCD
           MOVE    SYS-1009-REC        TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1009-REC
               MOVE    SYS-1009-PTNUMKSIKBN
                                           TO  SPA-1009-PTNUMKSIKBN
               MOVE    SYS-1009-HJNKSIKBN  TO  SPA-1009-HJNKSIKBN
               MOVE    SYS-1009-HJNKSINENKBN 
                                           TO  SPA-1009-HJNKSINENKBN
               MOVE    SYS-1009-HJNKSIRENNUMKBN
                                           TO  SPA-1009-HJNKSIRENNUMKBN
               MOVE    SYS-1009-HJNKSIRENNUMKETA
                                           TO  SPA-1009-HJNKSIRENNUMKETA
           ELSE
               MOVE    "患者番号構成管理情報が取得できませんでした"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                   TO  FLG-END
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
      *********MOVE    "scripts/daily/HCALL2.sh"
               MOVE    "scripts/daily/HCALL_prv.sh"
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
      *        最新以外の帳票ＤＢを削除
               PERFORM 2003-PRTDATA-DEL-SEC
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
           MOVE    RECE08-FORMID       TO  PRT-PRTID
      *     
           EVALUATE    RECE08-TEISYUTUSAKI ALSO    RECE08-RENNUM
               WHEN    "0"                 ALSO    1
               WHEN    "1"                 ALSO    1
                   MOVE    WRK-PARA-SYAPRTNM   TO  PRT-PRTNM
               WHEN    "2"                 ALSO    1
                   MOVE    WRK-PARA-KKHPRTNM   TO  PRT-PRTNM
               WHEN    "0"                 ALSO    ANY
               WHEN    "1"                 ALSO    ANY
                   MOVE    WRK-PARA-SYAPRTNM-NEXT
                                               TO  PRT-PRTNM
               WHEN    "2"                 ALSO    ANY
                   MOVE    WRK-PARA-KKHPRTNM-NEXT
                                               TO  PRT-PRTNM
           END-EVALUATE
           MOVE    "1"                 TO  PRT-SITEKBN
           MOVE    WRK-PARA-PRTKBN     TO  PRT-PRTKBN
           MOVE    "/var/tmp/"          TO  PRT-OUT
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  PRT-TBL-KEY
           MOVE    LNK-PRTKANRI-RENNUM TO  PRT-RENNUM
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  PRT-TBL-GROUP
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                       TO  PRT-SHORI-RENNUM
           ADD     1                   TO  WRK-RENNUM
           MOVE    WRK-RENNUM          TO  PRT-PAGE
      *
      *    通し番号印刷のときのみ編集
           IF      SYS-2005-RENNUMHENKBN   =   "1"
      *********ADD     1                   TO  WRK-RENNUM
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
                   WHEN    "HCM06V02.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM06V02
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM06V02-RENNUM
                       MOVE    HCM06V02            TO  RECE08-PRTDATA
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
                   WHEN    "HCM09.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCM09
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCM09-RENNUM
                       MOVE    HCM09               TO  RECE08-PRTDATA
                   WHEN    "HCRCP060.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCRCP060
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCRCP060-RENNUM
                       MOVE    HCRCP060            TO  RECE08-PRTDATA
                   WHEN    "HCRCP400.red"                  
                       MOVE    RECE08-PRTDATA      TO  HCRCP400
                       MOVE    WRK-HEN-RENNUM-AREA TO  HCRCP400-RENNUM
                       MOVE    HCRCP400            TO  RECE08-PRTDATA
               END-EVALUATE
           END-IF            
      *             
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
           MOVE    RECE08-SRYYM        TO  SPRT-SRYYM
           MOVE    LNK-PRTKANRI-SKYYMD TO  SPRT-SKYYMD
           MOVE    LNK-PRTKANRI-SHELLID 
                                       TO  SPRT-SHELLID
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                       TO  SPRT-SHORI-RENNUM
           COMPUTE  SPRT-PRIORITY      =   LNK-PRTKANRI-PRIORITY
                                       *   10
           IF      WRK-PARA-SYOKBN     =   "1"
               COMPUTE  SPRT-PRIORITY      =   SPRT-PRIORITY      
                                           +   1
           ELSE
               COMPUTE  SPRT-PRIORITY      =   SPRT-PRIORITY      
                                           +   2
           END-IF
           MOVE    RECE08-FORMID       TO  SPRT-PRTID
           MOVE    RECE08-PRTDATA      TO  SPRT-PRTDATA
      *         
           EVALUATE    RECE08-FORMID   ALSO    RECE08-NYUGAIKBN
               WHEN    "HCM06.red"     ALSO    ANY                  
               WHEN    "HCM06V01.red"  ALSO    ANY                
               WHEN    "HCM06V02.red"  ALSO    ANY                
               WHEN    "HCM09.red"     ALSO    ANY             
               WHEN    "HCRCP060.red"  ALSO    ANY                
               WHEN    "HCRCP400.red"  ALSO    ANY                
               WHEN    "HCN061.red"    ALSO    "2"              
               WHEN    "HCN062.red"    ALSO    "2"              
                   MOVE    "医科レセプト（入院外）"    TO  SPRT-TITLE
               WHEN    "HCN06.red"     ALSO    ANY             
               WHEN    "HCN061.red"    ALSO    "1"              
               WHEN    "HCN062.red"    ALSO    "1"              
                   MOVE    "医科レセプト（入院）"      TO  SPRT-TITLE
               END-EVALUATE
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           EVALUATE    RECE08-TEISYUTUSAKI ALSO    RECE08-RENNUM
               WHEN    "0"                 ALSO    1
               WHEN    "1"                 ALSO    1
                   MOVE    WRK-PARA-SYAPRTNM   TO  SPRT-PRTNM
               WHEN    "2"                 ALSO    1
                   MOVE    WRK-PARA-KKHPRTNM   TO  SPRT-PRTNM
               WHEN    "0"                 ALSO    ANY
               WHEN    "1"                 ALSO    ANY
                   MOVE    WRK-PARA-SYAPRTNM-NEXT
                                               TO  SPRT-PRTNM
               WHEN    "2"                 ALSO    ANY
                   MOVE    WRK-PARA-KKHPRTNM-NEXT
                                               TO  SPRT-PRTNM
           END-EVALUATE
           MOVE    "1"                 TO  SPRT-SITEKBN
           MOVE    "1"                 TO  SPRT-PRTFLG
      *    
           INITIALIZE                       ORCSPTIDAREA
           MOVE    SYS-1001-HOSPID     TO  SPTID-HOSPID
           PERFORM VARYING IDX FROM    20  BY  -1
                   UNTIL   IDX <       1
               IF      RECE08-PTNUM (IDX:1)
                                       NOT =   "Z"
                   MOVE    RECE08-PTNUM (1:IDX)    TO  SPTID-PTNUM
                   CALL    "ORCSPTID"           USING   ORCSPTIDAREA
                                                        SPA-1009-TBL
                   IF      SPTID-RC            =   ZERO
                       MOVE    SPTID-PTID          TO   SPRT-PTID
                   END-IF
                   MOVE    1                       TO  IDX
               END-IF
           END-PERFORM    
      *
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
       2002-RECEPRT-CLEAR-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票ＤＢクリア処理
      *****************************************************************
       2003-PRTDATA-DEL-SEC            SECTION.
      *
           MOVE    SPACE               TO  PRTKANRI-REC
           INITIALIZE                     PRTKANRI-REC
           MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  PRTKANRI-PRIORITY
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  PRTKANRI-TBL-GROUP
           MOVE    PRTKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           IF      WRK-PARA-SYOKBN     =   "1"
                   MOVE    PATH-TBL-PRTKANRI-KEY4
                                           TO  MCP-PATH
           ELSE
                   MOVE    PATH-TBL-PRTKANRI-KEY5
                                           TO  MCP-PATH
           END-IF
      *
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC         NOT  =   ZERO
               MOVE    1               TO  FLG-PRTKANRI
           ELSE
               PERFORM 900-PRTKANRI-FET-SEC
           END-IF
      *
           PERFORM UNTIL   (FLG-PRTKANRI  =   1         )
      *        最新以外の帳票ＤＢを削除
               MOVE    SPACE           TO  PRTDATA-REC
               INITIALIZE                  PRTDATA-REC
               MOVE    PRTKANRI-TBL-KEY
                                       TO  PRTDATA-TBL-KEY
               MOVE    PRTKANRI-TBL-GROUP
                                       TO  PRTDATA-TBL-GROUP
               MOVE    PRTDATA-REC     TO  MCPDATA-REC
               MOVE    "DBDELETE"      TO  MCP-FUNC
               MOVE    PATH-TBL-PRTDATA-DEL11
                                           TO  MCP-PATH
               CALL    "MCPSUB"            USING
                                           MCPAREA
                                           MCPDATA-REC
      *
               PERFORM 900-PRTKANRI-FET-SEC
      *
           END-PERFORM
           .
       2003-PRTDATA-DEL-EXT.
           EXIT.
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
           DISPLAY "*** ORCR0102 END ***"
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
      *     印刷管理ＤＢ読み込み
      *****************************************************************
       900-PRTKANRI-FET-SEC            SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           IF      WRK-PARA-SYOKBN     =   "1"
                   MOVE    PATH-TBL-PRTKANRI-KEY4
                                           TO  MCP-PATH
           ELSE
                   MOVE    PATH-TBL-PRTKANRI-KEY5
                                           TO  MCP-PATH
           END-IF
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  PRTKANRI-REC
               MOVE    ZERO                TO  FLG-PRTKANRI
           ELSE
               MOVE    1                   TO  FLG-PRTKANRI
           END-IF
           .
       900-PRTKANRI-FET-EXT.
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
