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
       PROGRAM-ID.             ORCSRECEARGMK.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : リアルタイムプレビュー引数作成処理
      *  コンポーネント名  : 引数作成＆処理実行
      *  管理者            : 
      *  作成日付    作業者        記述
      *  05/03/10    NACL−竹田　  新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-
      *                        引数の整理、レセ処理実行チェック
      *                        プリンタ情報取得、県単独(?)
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
       DATA                    DIVISION.
       WORKING-STORAGE         SECTION.
      *
      *    フラグ領域
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-JOBKANRI                            PIC 9(01).
      *    カウント領域
       01  CNT-AREA.
           03  CNT-IN                                  PIC 9(06).
      *
       01  INDEX-AREA.
           03  IDX                                     PIC 9(03). 
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY          PIC 9(02).
               05  SYS-MM          PIC 9(02).
               05  SYS-DD          PIC 9(02).
           03  SYS-TIME.
               05  SYS-THH         PIC 9(02).
               05  SYS-TMM         PIC 9(02).
               05  SYS-TSS         PIC 9(02).
               05  SYS-TDD         PIC 9(02).
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
      *    印刷管理ＤＢのキー値
       01  WRK-PREV-AREA.
           03  WRK-CONS-PRTKANRI-TBL-KEY
                                   PIC X(08)   VALUE   "RECEPTX".
           03  WRK-CONS-PRTKANRI-TBL-GROUP
                                   PIC X(14)   VALUE   SPACE.
      *
      *    ジョブ管理ＤＢのキー値
           03  WRK-CONS-JOB-SHELLID
                                   PIC X(08)   VALUE   "RECEPTX".
           03  WRK-CONS-JOB-JOBID  PIC 9(07)   VALUE   1.
           03  WRK-CONST-Z         PIC X(16)
               VALUE   "ZZZZZZZZZZZZZZZZ".
      *
           COPY    "CPSHELLTBL.INC".
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
       01  WRK-SHELL-NAME.
           05  FILLER             PIC X(16) VALUE
                                             "scripts/monthly/".
           05  WRK-SHELL-SHELL    PIC X(20).
      *
           COPY    "MCPAREA".
      *
           COPY  "ORCA-DBPATH".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *     
      **************************************************************************
      *
       LINKAGE                 SECTION.
       01  LINK-SHORI-KBN              PIC X(01).
       01  LINK-PTID                   PIC 9(10).
       01  LINK-SRYYM                  PIC X(06).
       01  LINK-NYUGAIKBN              PIC X(01).
       01  LINK-HKNKBN                 PIC X(01).
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
               SPA-AREA.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
      *???
           DISPLAY "ORCSRECEARGMK ST =" LINK-NYUGAIKBN
      *???     
           INITIALIZE                  CNT-AREA
                                       WRK-AREA
      *    作成日・時間の設定
           ACCEPT  SYS-YMD         FROM    DATE
           COMPUTE WRK-SYSYY       =   SYS-YY      +   2000
           MOVE    SYS-MM          TO  WRK-SYSMM
           MOVE    SYS-DD          TO  WRK-SYSDD
           ACCEPT  SYS-TIME        FROM    TIME
      *
           MOVE    SPACE           TO  SHELLTBL
           MOVE   "receipt_prv.sh" TO  WRK-SHELL-SHELL
      *    ファイルデイレクトリ位置指定
           INITIALIZE              ORCSMKPASSAREA
           MOVE    WRK-SHELL-NAME  TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *
           MOVE    ZERO            TO  WRK-SHELL-SRYYM
      *--> MOVE    SPA-TERMID      TO  WRK-SHELL-TERMID
           MOVE    LINK-PTID       TO  WRK-PTID
           MOVE    WRK-PTID        TO  WRK-SHELL-TERMID
           MOVE    SPA-SYSYMD      TO  WRK-SHELL-SYSYMD
           MOVE    WRK-SHELL-ARG1  TO  SHELLTBL-ARG1
           MOVE    "2"             TO  SHELLTBL-ARG2
           MOVE    "0"             TO  SHELLTBL-ARG3
           MOVE    "RECEERR"       TO  SHELLTBL-ARG4
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  SHELLTBL-ARG5
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  SHELLTBL-ARG6
      *------------------>
           MOVE   "SR3201"         TO  SHELLTBL-ARG7
           MOVE    LINK-SRYYM      TO  SHELLTBL-ARG8
           MOVE    WRK-SYSYMD      TO  SHELLTBL-ARG9
           MOVE    SYS-TIME        TO  SHELLTBL-ARG10
           MOVE    "00"            TO  SHELLTBL-ARG14
           MOVE    "0000001"       TO  SHELLTBL-ARG15
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  SHELLTBL-ARG16
           MOVE    WRK-SYSYMD      TO  SHELLTBL-ARG17(1:8)
           MOVE    SYS-TIME        TO  SHELLTBL-ARG17(9:)
           MOVE    "0001"          TO  SHELLTBL-ARG18
           MOVE    LINK-SRYYM      TO  SHELLTBL-ARG19
           MOVE    LINK-SRYYM      TO  SHELLTBL-ARG20
           MOVE    WRK-SHELL-SHELL TO  SHELLTBL-ARG21
           MOVE    "1"             TO  SHELLTBL-ARG22
      *    MOVE    SPA-TERMID      TO  SHELLTBL-ARG23
           MOVE    WRK-PTID        TO  SHELLTBL-ARG23
           MOVE    WRK-CONST-Z     TO  SHELLTBL-ARG23(17:)
           MOVE    SPA-OPID        TO  SHELLTBL-ARG24
      *------------------>
           MOVE    "lp2"           TO  SHELLTBL-ARG25
           MOVE    LINK-PTID       TO  SHELLTBL-ARG26
           MOVE    LINK-NYUGAIKBN  TO  SHELLTBL-ARG27
           MOVE    LINK-HKNKBN     TO  SHELLTBL-ARG28
           MOVE    LINK-SHORI-KBN  TO  SHELLTBL-ARG29
           MOVE    SPA-HOSPID      TO  SHELLTBL-ARG30
           DISPLAY "take arg hospid = "    SPA-HOSPID
           MOVE    SHELLTBL        TO  MCPDATA-REC
           MOVE    "SHELL"         TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL
                                   TO  MCP-PATH
           CALL    "MCPSUB"        USING
                                   MCPAREA
                                   MCPDATA-REC
      *
           DISPLAY "ORCSRECEARGMK ED ="
      *???     
      *
           .
       000-PROC-EXT.
           EXIT PROGRAM
           .
