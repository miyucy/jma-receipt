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
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCSDTCKARGMK.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : リアルタイムプレビュー引数作成処理
      *  コンポーネント名  : 引数作成＆処理実行(データチェック)
      *  管理者            : 
      *  作成日付    作業者        記述
      *  05/03/10    NACL−竹田    新規作成
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
       WORKING-STORAGE         SECTION.
      *
      *    エラーファイル 名称領域 
           COPY    "CPERRFL.INC"   REPLACING  //ERRFLPARA//
                                   BY         //RECEERR//.
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECEERR         PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-JOBKANRI        PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
       01  WRK-AREA.
           03  WRK-SYSYMD.
               05  WRK-SYSYY           PIC 9(04).
               05  WRK-SYSMM           PIC 9(02).  
               05  WRK-SYSDD           PIC 9(02).  
      *シェルＩＤ
           03  WRK-SHELLID             PIC X(08).
           03  WRK-PTID                PIC 9(16).
      *
      *    プレビュー用ワーク追加
           03  WRK-SHELL-ARG1.
             05  WRK-SHELL-SRYYM   PIC X(06).
             05  WRK-SHELL-TERMID  PIC X(16).
             05  WRK-SHELL-SYSYMD  PIC X(08).
      *
           03  WRK-MCP-TABLE           PIC X(64).
           03  WRK-MCP-PATHNAME        PIC X(64).
      *     
      *    印刷管理ＤＢのキー値
       01  WRK-PREV-AREA.
           03  WRK-CONS-PRTKANRI-TBL-KEY
                                   PIC X(08)   VALUE   "RECEPTX".
      *
      *    ジョブ管理ＤＢのキー値
           03  WRK-CONS-JOB-SHELLID
                                   PIC X(08)   VALUE   "RECEPTX".
           03  WRK-CONS-JOB-JOBID  PIC 9(07)   VALUE   1.
           03  WRK-CONST-Z         PIC X(16)
               VALUE   "ZZZZZZZZZZZZZZZZ".
      *
      *    ジョブ管理ＤＢのキー値（レセプト）
           03  WRK-CONS-JOB-SHELLID1
                                   PIC X(08)   VALUE   "RECEPT1".
           03  WRK-CONS-JOB-SHELLID2
                                   PIC X(08)   VALUE   "RECEPT2".
      *
           COPY    "CPSHELLTBL.INC".
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
       01  WRK-LNK-AREA.
           COPY    "CPORCSPRTLNK.INC".             
      *
       01  WRK-SHELL-NAME.
           05  FILLER             PIC X(16) VALUE
                                             "scripts/monthly/".
           05  WRK-SHELL-SHELL    PIC X(20).
      *
           COPY    "MCPAREA".
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
           COPY    "CPSK2005.INC".
           COPY    "CPSK200501.INC".
      *
           COPY    "CPSK4001.INC".
      *
      *    出力先プリンタ名割り当て情報
           COPY    "CPSK1031.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *???
       01  LINK-ERRCD                  PIC X(04).
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
      *
      *     LINK-HKNKBN
      *     ０：医保  １：労災  ２：自賠責
      *     LINK-PTRSI-HKNKBN
      *     １：労災  ２：自賠責
       LINKAGE                 SECTION.
       01  LINK-SHORI-KBN              PIC X(01).
       01  LINK-PTID                   PIC 9(10).
       01  LINK-SRYYM                  PIC X(06).
       01  LINK-NYUGAIKBN              PIC X(01).
       01  LINK-HKNKBN                 PIC X(01).
       01  LINK-PTRSI-HKNKBN           PIC X(01).
       01  LINK-PRTKBN                 PIC X(01).
      *01  LINK-ERRCD                  PIC X(04).
           COPY    "COMMON-SPA".
      *
      **************************************************************************
       PROCEDURE           DIVISION
               USING
               LINK-SHORI-KBN
               LINK-PTID
               LINK-SRYYM
               LINK-NYUGAIKBN
               LINK-HKNKBN
               LINK-PTRSI-HKNKBN
               LINK-PRTKBN
      *        LINK-ERRCD
               SPA-AREA.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           EXIT PROGRAM
           .
      * 
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *???
           DISPLAY "ORCSDTCKARGMK ST =" LINK-NYUGAIKBN " " LINK-HKNKBN
                                    " " LINK-PTRSI-HKNKBN
                                    " " LINK-PRTKBN
      *???     
           INITIALIZE                  WRK-AREA
                                       FLG-AREA
                                       LINK-ERRCD
      *
           INITIALIZE                  SYS-2001-REC
                                       SYS-2005-REC
                                       SYS-200501-REC
                                       SYS-4001-REC
      *
      *    作成日・時間の設定
           INITIALIZE                  ORCSMCNDATEAREA
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
      *
      *    県番号の取得
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"          TO  SYS-1001-KANRICD
           MOVE    "*"             TO  SYS-1001-KBNCD
           MOVE    LINK-SRYYM      TO  SYS-1001-STYUKYMD (1:6)
           MOVE    "01"            TO  SYS-1001-STYUKYMD (7:2)
           MOVE    SYS-1001-STYUKYMD
                                   TO  SYS-1001-EDYUKYMD
grpsys     MOVE    SPA-HOSPNUM     TO  SYS-1001-HOSPNUM
           MOVE    SYS-1001-REC    TO  MCPDATA-REC
           MOVE    "tbl_syskanri"  TO  WRK-MCP-TABLE
           MOVE    "key10"         TO  WRK-MCP-PATHNAME
           PERFORM 900-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI    =   ZERO
               MOVE   MCPDATA-REC      TO  SYS-1001-REC
           ELSE
               INITIALIZE                  SYS-1001-REC
           END-IF
      *
      *    出力先プリンタ名割り当て情報編集
           INITIALIZE                      SYSKANRI-REC
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "2"                 TO  ORCSPRTNM-KBN
           MOVE    SPA-SYSYMD          TO  ORCSPRTNM-SRYYMD
           MOVE    "2"                 TO  ORCSPRTNM-NYUGAIKBN
           CALL    "ORCSPRTNM"         USING
                                           ORCSPRTNMAREA
                                           SPA-AREA
                                           SYSKANRI-REC
           IF      ORCSPRTNM-RC    NOT =   ZERO
               INITIALIZE                  SYSKANRI-REC
           END-IF
           MOVE    SYSKANRI-REC        TO  SYS-1031-REC
      *
      *    ジョブ管理チェック処理
           PERFORM 1001-JOBKANRI-CHK-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ管理チェック処理
      *****************************************************************
       1001-JOBKANRI-CHK-SEC       SECTION.
      *
           MOVE    "CHK"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID1
                                   TO  JOB-SHELLID
grpsys     PERFORM 900-CALL-ORCSJOB-SEC
           IF      SJOBKANRI-RETURN
                                   =   ZERO
               IF      JOB-ENDYMD      =   SPACE
                   MOVE    "7777"          TO  LINK-ERRCD
               END-IF
           END-IF    
      *
           IF      LINK-ERRCD      =   SPACE 
               MOVE    "CHK"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-CONS-JOB-JOBID
                                       TO  JOB-JOBID
               MOVE    WRK-CONS-JOB-SHELLID2
                                       TO  JOB-SHELLID
grpsys         PERFORM 900-CALL-ORCSJOB-SEC
               IF      SJOBKANRI-RETURN
                                       =   ZERO
                   IF      JOB-ENDYMD      =   SPACE
                       MOVE    "7777"          TO  LINK-ERRCD
                   END-IF
               END-IF
           END-IF    
           .
       1001-JOBKANRI-CHK-EXT.
           EXIT.
           .
      * 
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           MOVE    LINK-PTID       TO  WRK-PTID
      *
           MOVE    "ORPRVERR"      TO  RECEERR-FILE-ID
           MOVE    WRK-PTID        TO  RECEERR-TERMID
grpsys     MOVE    SPA-HOSPNUM     TO  RECEERR-HOSPNUM
      *
           OPEN    OUTPUT   RECEERR-FILE
           CLOSE   RECEERR-FILE
      *    
           MOVE   "dtck_prv.sh"    TO  WRK-SHELL-SHELL
           MOVE    ZERO            TO  WRK-SHELL-SRYYM
           MOVE    WRK-PTID        TO  WRK-SHELL-TERMID
           MOVE    SPA-SYSYMD      TO  WRK-SHELL-SYSYMD
      *
           MOVE    SPACE           TO  SHELLTBL
      *    ファイルデイレクトリ位置指定
           INITIALIZE              ORCSMKPASSAREA
           MOVE    WRK-SHELL-NAME  TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *
      *------------------> recept1.sh $1 - $11
           MOVE    WRK-SHELL-ARG1  TO  SHELLTBL-ARG1
           MOVE    "2"             TO  SHELLTBL-ARG2
           EVALUATE    LINK-HKNKBN
               WHEN    "0"
                   MOVE    "0"             TO  SHELLTBL-ARG3
               WHEN    "1"
                   MOVE    "3"             TO  SHELLTBL-ARG3
               WHEN    "2"
                   MOVE    SYS-4001-JIBAIKBN
                                           TO  SHELLTBL-ARG3
               WHEN    "3"
                   MOVE    "6"             TO  SHELLTBL-ARG3
           END-EVALUATE 
           MOVE    RECEERR         TO  SHELLTBL-ARG4
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  SHELLTBL-ARG5
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  SHELLTBL-ARG6
           IF       LINK-NYUGAIKBN =   "1"
               MOVE    SYS-2005-PREFPRGID (2)
                                       TO  SHELLTBL-ARG7
           ELSE
               MOVE    SYS-2005-PREFPRGID (1)
                                       TO  SHELLTBL-ARG7
           END-IF
           MOVE    LINK-SRYYM      TO  SHELLTBL-ARG8
           MOVE    SMCNDATE-YMD    TO  SHELLTBL-ARG9
           MOVE    SMCNDATE-HMS    TO  SHELLTBL-ARG10
           MOVE    SYS-1001-PREFNUM
                                   TO  SHELLTBL-ARG11
           MOVE    LINK-PTRSI-HKNKBN
                                   TO  SHELLTBL-ARG12
           EVALUATE   LINK-NYUGAIKBN   ALSO    LINK-HKNKBN
               WHEN   "1"              ALSO    "1"
                   MOVE    SYS-200501-FRAME-ROUPRTKBN-N
                                                   TO  SHELLTBL-ARG13
               WHEN   "2"              ALSO    "1"
                   MOVE    SYS-200501-FRAME-ROUPRTKBN
                                                   TO  SHELLTBL-ARG13
               WHEN   "1"              ALSO    "2"
                   MOVE    SYS-2005-FRAME-JIBAIPRTKBN-N
                                                   TO  SHELLTBL-ARG13
               WHEN   "2"              ALSO    "2"
                   MOVE    SYS-2005-FRAME-JIBAIPRTKBN
                                                   TO  SHELLTBL-ARG13
           END-EVALUATE
           EVALUATE   LINK-NYUGAIKBN   ALSO    LINK-HKNKBN
               WHEN   "1"              ALSO    "2"
                   MOVE    SYS-200501-JIBAIPRTKBN-N
                                                   TO  SHELLTBL-ARG14
               WHEN   "2"              ALSO    "2"
                   MOVE    SYS-200501-JIBAIPRTKBN  TO  SHELLTBL-ARG14
               WHEN   OTHER
                   MOVE    "0"                     TO  SHELLTBL-ARG14
           END-EVALUATE
      *
      *------------------> recept2.sh $11 - $26 (#24 は除く)
           EVALUATE   LINK-NYUGAIKBN   ALSO    LINK-HKNKBN
               WHEN   "1"              ALSO    "0"
               WHEN   "1"              ALSO    "3"
                   MOVE    SYS-2005-SYAPRTNM-N
                                   TO  SHELLTBL-ARG15
                   MOVE    SYS-2005-SYAPRTNM-NEXT-N
                                   TO  SHELLTBL-ARG16
                   STRING  SYS-2005-KKHPRTNM-N DELIMITED  BY  SPACE
                           "#/"                    DELIMITED  BY  SIZE
                           SYS-200501-KOUIKIPRTNM-N
                                                   DELIMITED  BY  SPACE
                                           INTO    SHELLTBL-ARG28
                   END-STRING
                   STRING  SYS-2005-KKHPRTNM-NEXT-N
                                                   DELIMITED  BY  SPACE
                           "#/"                    DELIMITED  BY  SIZE
                           SYS-200501-KOUIKIPRTNM-NEXT-N
                                                   DELIMITED  BY  SPACE
                                           INTO    SHELLTBL-ARG29
                   END-STRING
               WHEN   "2"              ALSO    "0"
               WHEN   "2"              ALSO    "3"
                   MOVE    SYS-2005-SYAPRTNM
                                   TO  SHELLTBL-ARG15
                   MOVE    SYS-2005-SYAPRTNM-NEXT
                                   TO  SHELLTBL-ARG16
                   STRING  SYS-2005-KKHPRTNM       DELIMITED  BY  SPACE
                           "#/"                    DELIMITED  BY  SIZE
                           SYS-200501-KOUIKIPRTNM  DELIMITED  BY  SPACE
                                           INTO    SHELLTBL-ARG28
                   END-STRING
                   STRING  SYS-2005-KKHPRTNM-NEXT
                                                   DELIMITED  BY  SPACE
                           "#/"                    DELIMITED  BY  SIZE
                           SYS-200501-KOUIKIPRTNM-NEXT
                                                   DELIMITED  BY  SPACE
                                           INTO    SHELLTBL-ARG29
                   END-STRING
               WHEN   "1"              ALSO    "1"
                   MOVE    SYS-2005-ROUPRTNM-N
                                   TO  SHELLTBL-ARG15
                   MOVE    SYS-2005-ROUPRTNM-NEXT-N
                                   TO  SHELLTBL-ARG16
               WHEN   "1"              ALSO    "2"
                   MOVE    SYS-2005-JBAIPRTNM-N
                                   TO  SHELLTBL-ARG15
                   MOVE    SYS-2005-JBAIPRTNM-NEXT-N
                                   TO  SHELLTBL-ARG16
               WHEN   "2"              ALSO    "1"
                   MOVE    SYS-2005-ROUPRTNM
                                   TO  SHELLTBL-ARG15
                   MOVE    SYS-2005-ROUPRTNM-NEXT
                                   TO  SHELLTBL-ARG16
               WHEN   "2"              ALSO    "2"
                   MOVE    SYS-2005-JBAIPRTNM
                                   TO  SHELLTBL-ARG15
                   MOVE    SYS-2005-JBAIPRTNM-NEXT
                                   TO  SHELLTBL-ARG16
           END-EVALUATE
      *                                     
           MOVE    SPACE           TO  LNK-PRTKANRI-AREA
           INITIALIZE                  LNK-PRTKANRI-AREA
           MOVE    1               TO  LNK-PRTKANRI-RENNUM
           MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                   TO  LNK-PRTKANRI-TBL-KEY
           MOVE    LINK-PTID       TO  LNK-PRTKANRI-TBL-GROUP
           MOVE    1               TO  LNK-PRTKANRI-SHORI-RENNUM
           MOVE    LINK-SRYYM      TO  LNK-PRTKANRI-SRYYM 
           MOVE    SPA-SYSYMD      TO  LNK-PRTKANRI-SKYYMD
           MOVE    "dpck_prv.sh"
                                   TO  LNK-PRTKANRI-SHELLID
           IF      LINK-NYUGAIKBN  =   "1"
               MOVE    1               TO  LNK-PRTKANRI-PRIORITY
           ELSE
               MOVE    2               TO  LNK-PRTKANRI-PRIORITY
           END-IF
           MOVE    WRK-PTID        TO  LNK-PRTKANRI-TERMID
           MOVE    WRK-CONST-Z     TO  LNK-PRTKANRI-TERMID(17:)
           MOVE    SPA-OPID        TO  LNK-PRTKANRI-OPID
           MOVE    SYS-1031-PRTNM (11)
                                   TO  LNK-PRTKANRI-PRTNM
           MOVE    LNK-PRTKANRI-RENNUM
                                   TO  SHELLTBL-ARG17
           MOVE    LNK-PRTKANRI-TBL-KEY
                                   TO  SHELLTBL-ARG18
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                   TO  SHELLTBL-ARG19
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                   TO  SHELLTBL-ARG20
           MOVE    LNK-PRTKANRI-SRYYM
                                   TO  SHELLTBL-ARG21
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  SHELLTBL-ARG22
           MOVE    LNK-PRTKANRI-SHELLID
                                   TO  SHELLTBL-ARG23
           MOVE    LNK-PRTKANRI-PRIORITY
                                   TO  SHELLTBL-ARG24
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  SHELLTBL-ARG25
           MOVE    LNK-PRTKANRI-OPID
                                   TO  SHELLTBL-ARG26
           MOVE    LNK-PRTKANRI-PRTNM
                                   TO  SHELLTBL-ARG27
      *------------------>
           MOVE    LINK-PTID       TO  SHELLTBL-ARG30
           MOVE    LINK-NYUGAIKBN  TO  SHELLTBL-ARG31
           MOVE    LINK-HKNKBN     TO  SHELLTBL-ARG32
           MOVE    LINK-SHORI-KBN  TO  SHELLTBL-ARG33
grpsys     MOVE    SPA-HOSPNUM     TO  SHELLTBL-ARG34
           MOVE    SYS-200501-COMMENT-ROU-KSIKBN
                                   TO  SHELLTBL-ARG35
           MOVE    LINK-PRTKBN     TO  SHELLTBL-ARG36
           MOVE    SHELLTBL        TO  MCPDATA-REC
           MOVE    "SHELL"         TO  MCP-FUNC
           MOVE    "shell"         TO  MCP-TABLE
           MOVE    "shell"         TO  MCP-PATHNAME
grpsys     PERFORM 900-ORCDBMAIN-SEC
      *
           DISPLAY "ORCSDTCKARGMK ED ="
      *???     
      *
           .
       200-MAIN-EXT.
           EXIT.
           .
      *
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    WRK-MCP-TABLE       TO  MCP-TABLE
           MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
grpsys     PERFORM 900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-MCP-TABLE       TO  MCP-TABLE
               MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
               PERFORM 900-SYSKANRI-READ-N-SEC
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    WRK-MCP-TABLE       TO  MCP-TABLE
           MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
grpsys     PERFORM 900-CLOSE-SEC
      *
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読込（ＮＥＸＴ）
      *****************************************************************
       900-SYSKANRI-READ-N-SEC         SECTION.
      *
grpsys     PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-SYSKANRI
               MOVE    MCPDATA-REC         TO  SYSKANRI-REC 
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
           .
       900-SYSKANRI-READ-N-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ管理ＤＢ制御処理
      *****************************************************************
       900-CALL-ORCSJOB-SEC            SECTION.
      *
grpsys     MOVE    SPA-HOSPNUM     TO  JOB-HOSPNUM
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA 
                                   JOBKANRI-REC
                                   SPA-AREA
           .
       900-CALL-ORCSJOB-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＳＥＬＥＣＴ処理
      *****************************************************************
       900-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
           .
       900-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＦＥＴＣＨ処理
      *****************************************************************
       900-DBFETCH-SEC                SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       900-CLOSE-SEC               SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルアクセス処理
      *****************************************************************
       900-ORCDBMAIN-SEC               SECTION.
      *
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
      *
       900-ORCDBMAIN-EXT.
           EXIT.
