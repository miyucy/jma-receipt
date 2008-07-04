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
       IDENTIFICATION                  DIVISION.
       PROGRAM-ID.                     ORCSS010.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 共通
      *  コンポーネント名  : 入院行為照会用テーブル作成サブ
      *  管理者            :
      *  作成日付    作業者        記述
      *  06/06/20    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  03.05.00    NACL-太田    07/05/28  グループ診療対応
      *****************************************************************
      *
       ENVIRONMENT                     DIVISION.
       CONFIGURATION                   SECTION.
       INPUT-OUTPUT                    SECTION.
       FILE-CONTROL.
      *
       DATA                            DIVISION.
       FILE                            SECTION.
      *
      *
       WORKING-STORAGE                 SECTION.
      *
       01  FLG-AREA.
           03  FLG-ERR                 PIC 9(01).
           03  FLG-NYUINACCT           PIC 9(01).
      *
       01  IDX-AREA.
           03  IDX0                    PIC 9(05).
           03  IDX1                    PIC 9(05).
           03  IDX2                    PIC 9(05).
           03  IDX3                    PIC 9(05).
           03  IDX-TNSHOUKAI           PIC 9(05).
           03  IDX-DAY                 PIC 9(02).
      *
       01  WRK-AREA.
           03  WRK-SRYYMD.
               05  WRK-SRYYM           PIC X(06).
               05  WRK-SRYDD           PIC 9(02).
           03  WRK-SRYKA               PIC X(02).
           03  WRK-ZAINUM              PIC 9(09).
           03  WRK-KEISANYM.
               05  WRK-KEISANYM9       PIC 9(06).
      *
       01  KEY-AREA.
           03  KEY-SRYKA               PIC X(02).
           03  KEY-HKNCOMBI.
               05  KEY-HKNCOMBI9       PIC 9(04).
           03  KEY-SRYCD               PIC X(09).
           03  KEY-BRMNUM              PIC X(08).
           03  KEY-RM-SAGAKU           PIC X(02).
      *
      *    入院診療行為照会退避領域
       01  TNSHOUKAI-AREA.
           03  TNSHOUKAI-MAX               PIC 9(05).
           03  TNSHOUKAI-OCC               OCCURS  300.
               05  TNSHOUKAI-SRYKA         PIC X(02).
               05  TNSHOUKAI-HKNCOMBI      PIC X(04).
               05  TNSHOUKAI-SRYCD         PIC X(09).
               05  TNSHOUKAI-BRMNUM        PIC X(08).
               05  TNSHOUKAI-RM-SAGAKU     PIC X(02).
               05  TNSHOUKAI-DAY           PIC 9(01)
                                           OCCURS   31.
      *
       01  CONST-AREA.
           03  CONST-TNSHOUKAI-MAX         PIC 9(05)   VALUE   300.
           03  CONST-HKNCOMBICD            PIC X(09) VALUE "099999914".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    入院診療会計マスター
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    入院診療行為照会テーブル
       01  NSRYSRH-REC.
           COPY    "CPNSRYSRH.INC".
      *
      *    入院履歴照会テーブル
       01  NRRKSRH-REC.
           COPY    "CPNRRKSRH.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    科別・保険別入院会計編集サブ
           COPY    "CPORCSS009.INC".
      *
       01  LNKNACCT-REC.
           COPY    "CPNYUINACCT.INC"
                                   REPLACING   //NACCT//
                                   BY          //LNKNACCT//.
      *
      *    入院会計編集サブ
           COPY    "CPORCHCM34S01.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "MCPAREA".
      *
      ****************************************************************
       LINKAGE                         SECTION.
           COPY    "CPORCSS010.INC".
           COPY    "COMMON-SPA".
      *
      ****************************************************************
       PROCEDURE                       DIVISION
           USING
           SS010-AREA
           SPA-AREA
           .
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           PERFORM 990-EXIT-PROGRAM-SEC
      *
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           INITIALIZE                  IDX-AREA
      *                                CNT-AREA
                                       FLG-AREA
                                       WRK-AREA
                                       TNSHOUKAI-AREA
                                       KEY-AREA
                                       SS009-AREA
      *
           PERFORM 800-MCNDATE-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           PERFORM 900-NYUINACCT-KEY17-SEL-SEC
      *
           PERFORM 2001-EDIT-TNSHOUKAI-SEC
      *
           PERFORM 2002-EDIT-TNSHOUKAI-SEC
      *
           PERFORM 2001-EDIT-NSHOUKAI-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    入院診療行為照会退避領域
      *****************************************************************
       2001-EDIT-TNSHOUKAI-SEC         SECTION.
      *
           IF    ( NACCT-ZAIKAISU  >   ZERO )
      *
               MOVE    NYUINACCT-REC   TO  LNKNACCT-REC
               CALL    "ORCSS009"  USING   SS009-AREA
                                           LNKNACCT-REC
                                           SPA-AREA
               IF    ( SS009-RC    =   ZERO )
                   CONTINUE
               ELSE
                   DISPLAY "SS009-RC = " SS009-RC
                   MOVE    1       TO  SS010-RC
                   PERFORM 990-ABORT-SEC
               END-IF
      *
               PERFORM VARYING IDX0    FROM    1   BY  1
                       UNTIL ( IDX0    >   SS009-HENKYAKU-MAX )
      *
                   PERFORM VARYING IDX1    FROM    1   BY  1
                           UNTIL ( IDX1        >   20 )
                            OR   ( SS009-SRYCD (IDX0 IDX1)
                                               =   SPACE )
      *
                       PERFORM 20011-EDIT-TNSHOUKAI-SEC
      *
                   END-PERFORM
      *
               END-PERFORM
      *
           END-IF
      *
           .
       2001-EDIT-TNSHOUKAI-EXT.
           EXIT.
      *****************************************************************
      *    入院診療行為照会退避領域
      *****************************************************************
       20011-EDIT-TNSHOUKAI-SEC        SECTION.
      *
           PERFORM VARYING IDX-DAY FROM    1   BY  1
                   UNTIL ( IDX-DAY >   31 )
      *
               IF    ( SS009-DAY (IDX0 IDX-DAY)    NOT =   ZERO )
      *
                   MOVE    SS009-SRYKA   (IDX0)
                                           TO  KEY-SRYKA
                   MOVE    SS009-HKNCOMBI(IDX0)
                                           TO  KEY-HKNCOMBI
                   MOVE    SS009-SRYCD   (IDX0 IDX1)
                                           TO  KEY-SRYCD
                   MOVE    SS009-BRMNUM-DAY(IDX-DAY)
                                           TO  KEY-BRMNUM
                   MOVE    SS009-SAGAKUCD-DAY(IDX-DAY)
                                           TO  KEY-RM-SAGAKU
                   PERFORM 200111-EDIT-TNSHOUKAI-SEC
      *
               END-IF
      *
           END-PERFORM
      *
           .
       20011-EDIT-TNSHOUKAI-EXT.
           EXIT.
      *****************************************************************
      *    入院診療行為照会退避領域
      *****************************************************************
       200111-EDIT-TNSHOUKAI-SEC        SECTION.
      *
           MOVE    ZERO            TO  IDX-TNSHOUKAI
      *
           PERFORM VARYING IDX3    FROM    1   BY  1
                   UNTIL ( IDX3            >   TNSHOUKAI-MAX )
                    OR   ( IDX-TNSHOUKAI   >   ZERO )
      *
               IF        ( KEY-SRYKA   =   TNSHOUKAI-SRYKA   (IDX3))
                    AND  ( KEY-HKNCOMBI
                                       =   TNSHOUKAI-HKNCOMBI(IDX3))
                    AND  ( KEY-SRYCD   =   TNSHOUKAI-SRYCD   (IDX3))
                    AND  ( KEY-BRMNUM  =   TNSHOUKAI-BRMNUM  (IDX3))
                    AND  ( KEY-RM-SAGAKU
                                       =   TNSHOUKAI-RM-SAGAKU(IDX3))
      *
                       MOVE    IDX3   TO  IDX-TNSHOUKAI
      *
               END-IF
      *
           END-PERFORM
      *
           IF    ( IDX-TNSHOUKAI       =   ZERO )
               IF    ( TNSHOUKAI-MAX  >=  CONST-TNSHOUKAI-MAX )
                   MOVE    2           TO  SS010-RC
                   PERFORM 990-ABORT-SEC
               END-IF
      *
               COMPUTE IDX-TNSHOUKAI   =   TNSHOUKAI-MAX   +   1
      *
               MOVE    KEY-SRYKA       TO  TNSHOUKAI-SRYKA
                                                       (IDX-TNSHOUKAI)
               MOVE    KEY-HKNCOMBI    TO  TNSHOUKAI-HKNCOMBI
                                                       (IDX-TNSHOUKAI)
               MOVE    KEY-SRYCD       TO  TNSHOUKAI-SRYCD
                                                       (IDX-TNSHOUKAI)
               MOVE    KEY-BRMNUM      TO  TNSHOUKAI-BRMNUM
                                                       (IDX-TNSHOUKAI)
               MOVE    KEY-RM-SAGAKU   TO  TNSHOUKAI-RM-SAGAKU
                                                       (IDX-TNSHOUKAI)
               MOVE    IDX-TNSHOUKAI   TO  TNSHOUKAI-MAX
      *
           END-IF
      *
           MOVE    1                   TO  TNSHOUKAI-DAY
                                               (IDX-TNSHOUKAI IDX-DAY)
      *
           .
       200111-EDIT-TNSHOUKAI-EXT.
           EXIT.
      *****************************************************************
      *    入院診療行為照会退避領域（保険組合せ）
      *****************************************************************
       2002-EDIT-TNSHOUKAI-SEC         SECTION.
      *
           PERFORM VARYING IDX-DAY FROM    1   BY  1
                   UNTIL ( IDX-DAY >   31 )
      *
               IF    ( NACCT-DAY (IDX-DAY) NOT =   ZERO )
      *
                   MOVE    SS009-SRYKA-DAY (IDX-DAY)
                                           TO  KEY-SRYKA
                   MOVE    NACCT-DAY (IDX-DAY)
                                           TO  KEY-HKNCOMBI9
                   MOVE    CONST-HKNCOMBICD
                                           TO  KEY-SRYCD
                   MOVE    SS009-BRMNUM-DAY(IDX-DAY)
                                           TO  KEY-BRMNUM
                   MOVE    SS009-SAGAKUCD-DAY(IDX-DAY)
                                           TO  KEY-RM-SAGAKU
                   PERFORM 200111-EDIT-TNSHOUKAI-SEC
      *
               END-IF
      *
           END-PERFORM
      *
           .
       2002-EDIT-TNSHOUKAI-EXT.
           EXIT.
      *****************************************************************
      *    入院診療行為照会テーブル編集処理
      *****************************************************************
       2001-EDIT-NSHOUKAI-SEC          SECTION.
      *
           INITIALIZE  NRRKSRH-REC
           MOVE    SPA-HOSPNUM     TO  NRRKSRH-HOSPNUM
           MOVE    SS010-PTID      TO  NRRKSRH-PTID
           MOVE    SS010-SRYYM     TO  NRRKSRH-SRYYMD
           MOVE    "%"             TO  NRRKSRH-SRYYMD (7:1)
           MOVE    NRRKSRH-REC     TO  MCPDATA-REC
           MOVE    "tbl_nrrksrh"   TO  MCP-TABLE
           MOVE    "del1"          TO  MCP-PATHNAME
           PERFORM 910-DBDELETE-SEC
           IF    ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    3           TO  SS010-RC
               PERFORM 990-EXIT-PROGRAM-SEC
           END-IF
      *
           INITIALIZE                  NSRYSRH-REC
           MOVE    SPA-HOSPNUM     TO  NSRYSRH-HOSPNUM
           MOVE    SS010-PTID      TO  NSRYSRH-PTID
           MOVE    SS010-SRYYM     TO  NSRYSRH-SRYYM
           MOVE    NSRYSRH-REC     TO  MCPDATA-REC
           MOVE    "tbl_nsrysrh"   TO  MCP-TABLE
           MOVE    "del1"          TO  MCP-PATHNAME
           PERFORM 910-DBDELETE-SEC
           IF    ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    4           TO  SS010-RC
               PERFORM 990-EXIT-PROGRAM-SEC
           END-IF
      *
           MOVE    SS010-SRYYM     TO  WRK-KEISANYM
           COMPUTE WRK-ZAINUM  =   WRK-KEISANYM9   *   1000
      *
           PERFORM VARYING IDX3    FROM    1   BY  1
                   UNTIL ( IDX3    >   TNSHOUKAI-MAX )
      *
               COMPUTE WRK-ZAINUM  =   WRK-ZAINUM  +   1
      *
               INITIALIZE  NSRYSRH-REC
               MOVE    SPA-HOSPNUM     TO  NSRYSRH-HOSPNUM
               MOVE    SS010-PTID      TO  NSRYSRH-PTID
               MOVE    WRK-ZAINUM      TO  NSRYSRH-ZAINUM
               MOVE    SS010-SRYYM     TO  NSRYSRH-SRYYM
               MOVE    TNSHOUKAI-SRYKA (IDX3)
                                       TO  NSRYSRH-SRYKA
               MOVE    TNSHOUKAI-HKNCOMBI (IDX3)
                                       TO  NSRYSRH-HKNCOMBINUM
               MOVE    TNSHOUKAI-SRYCD (IDX3)
                                       TO  NSRYSRH-SRYCD
               MOVE    TNSHOUKAI-BRMNUM (IDX3)
                                       TO  NSRYSRH-BRMNUM
               MOVE    TNSHOUKAI-RM-SAGAKU (IDX3)
                                       TO  NSRYSRH-RM-SAGAKU
               MOVE    SMCNDATE-YMD    TO  NSRYSRH-CREYMD
                                           NSRYSRH-UPYMD
               MOVE    SMCNDATE-HMS    TO  NSRYSRH-UPHMS
               MOVE    NSRYSRH-REC     TO  MCPDATA-REC
               MOVE    "tbl_nsrysrh"   TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               PERFORM 910-DBINSERT-SEC
               IF    ( MCP-RC          =   ZERO )
                   CONTINUE
               ELSE
                   MOVE    4           TO  SS010-RC
                   PERFORM 990-EXIT-PROGRAM-SEC
               END-IF
      *
               PERFORM VARYING IDX-DAY FROM    1   BY  1
                       UNTIL ( IDX-DAY >   31 )
      *
                   IF    ( TNSHOUKAI-DAY (IDX3 IDX-DAY) NOT =  ZERO )
                       INITIALIZE                  NRRKSRH-REC
                       MOVE    SPA-HOSPNUM     TO  NRRKSRH-HOSPNUM
                       MOVE    SS010-PTID      TO  NRRKSRH-PTID
                       MOVE    SS010-SRYYM     TO  WRK-SRYYM
                       MOVE    IDX-DAY         TO  WRK-SRYDD
                       MOVE    WRK-SRYYMD      TO  NRRKSRH-SRYYMD
                       MOVE    WRK-ZAINUM      TO  NRRKSRH-ZAINUM
                       MOVE    SMCNDATE-YMD    TO  NRRKSRH-CREYMD
                                                   NRRKSRH-UPYMD
                       MOVE    SMCNDATE-HMS    TO  NRRKSRH-UPHMS
                       MOVE    NRRKSRH-REC     TO  MCPDATA-REC
                       DISPLAY "NRRKSRH-REC =" NRRKSRH-REC
                       MOVE    "tbl_nrrksrh"   TO  MCP-TABLE
                       MOVE    "key"           TO  MCP-PATHNAME
                       PERFORM 910-DBINSERT-SEC
                       IF    ( MCP-RC          =   ZERO )
                           CONTINUE
                       ELSE
                           MOVE    5           TO  SS010-RC
                           PERFORM 990-EXIT-PROGRAM-SEC
                       END-IF
                   END-IF
      *
               END-PERFORM
      *
           END-PERFORM
      *
           .
       2001-EDIT-NSHOUKAI-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
           PERFORM 800-DISPLAY-SEC
      *
           .
       300-END-EXT.
           EXIT.
      *****************************************************************
      *    DISPLAY処理
      *****************************************************************
       800-DISPLAY-SEC                 SECTION.
      *
           PERFORM VARYING IDX3    FROM    1   BY  1
                   UNTIL ( IDX3    >   TNSHOUKAI-MAX )
      *
               PERFORM VARYING IDX-DAY FROM    1   BY  1
                       UNTIL ( IDX-DAY >   31 )
      *
                   IF    ( TNSHOUKAI-DAY (IDX3 IDX-DAY) NOT =  ZERO )
                       DISPLAY "SS010 " TNSHOUKAI-MAX
                               ":"      SS010-PTID
                               " "      TNSHOUKAI-SRYKA(IDX3)
                               " "      TNSHOUKAI-HKNCOMBI(IDX3)
                               " "      TNSHOUKAI-SRYCD(IDX3)
                               " "      SS010-SRYYM
                                        IDX-DAY
                   END-IF
      *
               END-PERFORM
      *
           END-PERFORM
      *
           .
       800-DISPLAY-EXT.
           EXIT.
      *****************************************************************
      *    マシン日付取得サブ
      *****************************************************************
       800-MCNDATE-SEC         SECTION.
      *
           CALL    "ORCSMCNDATE"   USING   ORCSMCNDATEAREA
      *
           .
      *
       800-MCNDATE-EXT.
           EXIT.
      *****************************************************************
      *    入院会計検索処理(KEY17)
      *****************************************************************
       900-NYUINACCT-KEY17-SEL-SEC     SECTION.
      *
           MOVE    ZERO                TO  FLG-NYUINACCT
           INITIALIZE                  NYUINACCT-REC
      *
           MOVE    SPA-HOSPNUM         TO  NACCT-HOSPNUM
           MOVE    SS010-PTID          TO  NACCT-PTID
           MOVE    SS010-SRYYM         TO  NACCT-SRYYM
           MOVE    "1"                 TO  NACCT-NYUGAIKBN
           MOVE    "5"                 TO  NACCT-ZAISKBKBN
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "key17"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  NYUINACCT-REC
           ELSE
               MOVE    1               TO  FLG-NYUINACCT
               INITIALIZE                  NYUINACCT-REC
           END-IF
      *
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "key17"             TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-NYUINACCT-KEY17-SEL-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHも行う)
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHは行わない)
      *****************************************************************
       911-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
      *
       911-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
      *
       910-DBCLOSECURSOR-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＤＥＬＥＴＥ処理
      *****************************************************************
       910-DBDELETE-SEC                 SECTION.
      *
           MOVE    "DBDELETE"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
      *
       910-DBDELETE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＩＮＳＥＲＴ処理
      *****************************************************************
       910-DBINSERT-SEC                 SECTION.
      *
           MOVE    "DBINSERT"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
      *
       910-DBINSERT-EXT.
           EXIT.
      *****************************************************************
      *    ABORT処理
      *****************************************************************
       990-ABORT-SEC                   SECTION.
      *
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "abort"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
      *
           PERFORM 990-EXIT-PROGRAM-SEC
      *
           .
       990-ABORT-EXT.
           EXIT.
      *****************************************************************
      *    EXIT PROGRAM
      *****************************************************************
       990-EXIT-PROGRAM-SEC            SECTION.
      *
           DISPLAY "SS010-RC = " SS010-RC
      *
           EXIT PROGRAM
      *
           .
       990-EXIT-PROGRAM-EXT.
           EXIT.
