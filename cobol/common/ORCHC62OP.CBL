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
       PROGRAM-ID.             ORCHC62OP.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : お薬手帳印刷
      *  コンポーネント名  : お薬手帳印刷（ＨＣ６２）バッチ起動
      *  管理者            : 
      *  作成日付    作業者        記述
      *  08/10/10    NACL−森脇    新規作成
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
      *    パラメタ退避ファイル
           SELECT  PARA01-FILE     ASSIGN  OPPARA01
                                   ORGANIZATION    IS  SEQUENTIAL
                                   FILE    STATUS  IS  STS-PARA01.
      *
      *    パラメタ退避ファイル
           SELECT  PARA02-FILE     ASSIGN  OPPARA02
                                   ORGANIZATION    IS  SEQUENTIAL
                                   FILE    STATUS  IS  STS-PARA02.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
       FD  PARA01-FILE.
           COPY    "COMMON-SPA"    REPLACING
                                   //SPA-//    BY //PSPA-//.
      *
       FD  PARA02-FILE.
           COPY    "CPORCHC62.INC" REPLACING   //ORCHC62//
                                   BY          //PORCHC62//.
      *
      *
       WORKING-STORAGE             SECTION.
      *
           COPY    "CPCOMMONDAT5.INC"  REPLACING
                                       //TEIKI01PARA// BY //OPPARA01//.
      *
           COPY    "CPCOMMONDAT5.INC"  REPLACING
                                       //TEIKI01PARA// BY //OPPARA02//.
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA01          PIC X(02).
           03  STS-PARA02          PIC X(02).
      *
       01  CONST-AREA.
           03  CONST-SHELL         PIC X(29)   VALUE
               "scripts/daily/online-print.sh".
      *
           COPY    "CPSHELLTBL.INC".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
           COPY    "CPONPRTID.INC".
      *
       01  UIDIO-AREA.
           03  C-RET                   PIC X(2).
           03  C-UID                   PIC X(36).
       01  ST                          PIC 9(2).
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY    "CPMKPASS.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "COMMON-SPA".
           COPY    "CPORCHC62.INC".
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           ORCHC62AREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           PERFORM 800-ORCUIDSET-SEC
      *
           MOVE    SPA-HOSPNUM     TO  OPPARA01-HOSPNUM
           MOVE    1               TO  OPPARA01-FILE-NO
           MOVE    C-UID           TO  OPPARA01-TERMID
      *
           MOVE    SPA-HOSPNUM     TO  OPPARA02-HOSPNUM
           MOVE    2               TO  OPPARA02-FILE-NO
           MOVE    C-UID           TO  OPPARA02-TERMID
      *
           OPEN    OUTPUT              PARA01-FILE
           MOVE    SPA-AREA        TO  PSPA-AREA
           WRITE   PSPA-AREA
           CLOSE   PARA01-FILE
      *
           OPEN    OUTPUT              PARA02-FILE
           MOVE    ORCHC62AREA     TO  PORCHC62AREA
           WRITE   PORCHC62AREA
           CLOSE   PARA02-FILE
      *
           MOVE    SPACE           TO  SHELLTBL
      *
           INITIALIZE                  ORCSMKPASSAREA
           MOVE    CONST-SHELL     TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"    USING
                                   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *
           MOVE    ONPRTID-ORCHC62
                                   TO  SHELLTBL-ARG1
           MOVE    OPPARA01        TO  SHELLTBL-ARG2
           MOVE    OPPARA02        TO  SHELLTBL-ARG3
      *
           MOVE    SHELLTBL        TO  MCPDATA-REC
           MOVE    "SHELL"         TO  MCP-FUNC
           MOVE    "shell"         TO  MCP-TABLE
           MOVE    "shell"         TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    UID取得処理
      *****************************************************************
       800-ORCUIDSET-SEC               SECTION.
      *
           INITIALIZE                  UIDIO-AREA
           CALL    "orcuidset"         USING
                                       ST
                                       UIDIO-AREA
      *
           .
       800-ORCUIDSET-EXT.
           EXIT.
