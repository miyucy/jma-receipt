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
           03  FLG-PTNYUINRRK          PIC 9(01).
           03  FLG-HIT                 PIC 9(01).
      *
       01  IDX-AREA.
           03  IDX0                    PIC 9(05).
           03  IDX1                    PIC 9(05).
           03  IDX2                    PIC 9(05).
           03  IDX3                    PIC 9(05).
           03  IDX4                    PIC 9(05).
           03  IDX5                    PIC 9(05).
           03  IDX-TNSHOUKAI           PIC 9(05).
           03  IDX-DAY                 PIC 9(02).
           03  IDX-NRRK                PIC 9(05).
      *
       01  WRK-AREA.
           03  WRK-BOMYMD              PIC X(08).
           03  WRK-EOMYMD              PIC X(08).
           03  WRK-SRYYMD.
               05  WRK-SRYYM           PIC X(06).
               05  WRK-SRYDD           PIC 9(02).
           03  WRK-SRYKA               PIC X(02).
           03  WRK-ZAINUM              PIC 9(09).
           03  WRK-KEISANYM.
               05  WRK-KEISANYM9       PIC 9(06).
           03  WRK-ZAISKBKBN           PIC X(01).
           03  WRK-SRYCD               PIC X(09).
      *
       01  KEY-AREA.
           03  KEY-SRYKA               PIC X(02).
           03  KEY-HKNCOMBI.
               05  KEY-HKNCOMBI9       PIC 9(04).
           03  KEY-SRYKBN              PIC X(02).
           03  KEY-SRYCD               PIC X(09).
           03  KEY-SRYSURYO            PIC 9(05).
           03  KEY-BRMNUM              PIC X(08).
           03  KEY-RM-SAGAKU           PIC X(02).
           03  KEY-RRKNUM              PIC 9(03).
      *
      *    入院履歴退避領域
       01  TNRRK-AREA.
           03  TNRRK-MAX                   PIC 9(05).
           03  TNRRK-OCC                   OCCURS  31.
               05  TNRRK-SKYKBN            PIC X(01).
               05  TNRRK-RRKNUM            PIC 9(03).
               05  TNRRK-NYUINYMD          PIC X(08).
               05  TNRRK-DOUJITSUKBN       PIC X(01).
               05  TNRRK-TENNYUYMD.
                   07  TNRRK-TENNYUYM      PIC X(06).
                   07  TNRRK-TENNYUDD      PIC 9(02).
               05  TNRRK-TENSTUYMD.
                   07  TNRRK-TENSTUYM      PIC X(06).
                   07  TNRRK-TENSTUDD      PIC 9(02).
      *
      *    入院診療行為照会退避領域
       01  TNSHOUKAI-AREA.
           03  TNSHOUKAI-MAX               PIC 9(05).
           03  TNSHOUKAI-OCC               OCCURS  300.
               05  TNSHOUKAI-SRYKA         PIC X(02).
               05  TNSHOUKAI-HKNCOMBI      PIC X(04).
               05  TNSHOUKAI-SRYKBN        PIC X(02).
               05  TNSHOUKAI-SRYCD         PIC X(09).
               05  TNSHOUKAI-SRYSURYO      PIC 9(05).
               05  TNSHOUKAI-BRMNUM        PIC X(08).
               05  TNSHOUKAI-RM-SAGAKU     PIC X(02).
               05  TNSHOUKAI-DAY-G.
                   07  TNSHOUKAI-DAY-OCC   OCCURS   31.
                       09  TNSHOUKAI-DAY-RRKNUM
                                           PIC 9(03).
                       09  TNSHOUKAI-DAY   PIC 9(01)
                                           OCCURS   31.
      *
       01  CONST-AREA.
           03  CONST-TNSHOUKAI-MAX         PIC 9(05)   VALUE   300.
           03  CONST-TNRRK-MAX             PIC 9(05)   VALUE   31.
           03  CONST-HKNCOMBICD            PIC X(09) VALUE "099999914".
           03  CONST-GAIHAKUCD             PIC X(09) VALUE "099999911".
      *
       01  TNACCT-REC.
           COPY    "CPNYUINACCT.INC"       REPLACING   //NACCT//
                                           BY          //TNACCT//.
      *
        01 TCOMBNACCT-REC.
           COPY    "CPNYUINACCT.INC"       REPLACING   //NACCT//
                                           BY          //TCOMBNACCT//.
        01 TGIHAKUNACCT-REC.
           COPY    "CPNYUINACCT.INC"       REPLACING   //NACCT//
                                           BY          //TGIHAKUNACCT//.
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    入院履歴マスタ
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
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
      *    日付編集サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
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
                                       TNRRK-AREA
      *
           PERFORM 800-MCNDATE-SEC
      *
           PERFORM 900-NYUINACCT-KEY54-SEL-SEC
      *
           INITIALIZE  NRRKSRH-REC
           MOVE    SPA-HOSPNUM     TO  NRRKSRH-HOSPNUM
           MOVE    SS010-PTID      TO  NRRKSRH-PTID
           MOVE    NACCT-SRYYM     TO  NRRKSRH-SRYYMD
           MOVE    "31"            TO  NRRKSRH-SRYYMD (7:)
           MOVE    NRRKSRH-REC     TO  MCPDATA-REC
           MOVE    "tbl_nrrksrh"   TO  MCP-TABLE
           MOVE    "del3"          TO  MCP-PATHNAME
           PERFORM 910-DBDELETE-SEC
           IF    ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    6           TO  SS010-RC
               PERFORM 990-EXIT-PROGRAM-SEC
           END-IF
      *
           INITIALIZE                  NSRYSRH-REC
           MOVE    SPA-HOSPNUM     TO  NSRYSRH-HOSPNUM
           MOVE    SS010-PTID      TO  NSRYSRH-PTID
           MOVE    NACCT-SRYYM     TO  NSRYSRH-SRYYM
           MOVE    NSRYSRH-REC     TO  MCPDATA-REC
           MOVE    "tbl_nsrysrh"   TO  MCP-TABLE
           MOVE    "del3"          TO  MCP-PATHNAME
           PERFORM 910-DBDELETE-SEC
           IF    ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    7           TO  SS010-RC
               PERFORM 990-EXIT-PROGRAM-SEC
           END-IF
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
           MOVE    SS010-SRYYM     TO  WRK-BOMYMD
           MOVE    "01"            TO  WRK-BOMYMD (7:2)
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY7-AREA
           MOVE    "71"                TO   LNK-DAY7-IRAI
           MOVE    SS010-SRYYM         TO   LNK-DAY7-YM
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                       LNK-DAY7-AREA
           MOVE    LNK-DAY7-KOYOMI TO  WRK-EOMYMD
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           PERFORM 2001-EDIT-TNRRK-SEC
      *
           MOVE    "5"                 TO  WRK-ZAISKBKBN
           PERFORM 900-NYUINACCT-KEY17-SEL-SEC
           MOVE    NYUINACCT-REC       TO  TCOMBNACCT-REC
      *
           MOVE    "2"                 TO  WRK-ZAISKBKBN
           PERFORM 900-NYUINACCT-KEY17-SEL-SEC
           MOVE    NYUINACCT-REC       TO  TGIHAKUNACCT-REC
      *
           PERFORM VARYING IDX-NRRK    FROM    1   BY  1
                   UNTIL ( IDX-NRRK    >   TNRRK-MAX )
      *
               MOVE    TCOMBNACCT-REC  TO  TNACCT-REC
               PERFORM 2001-EDIT-NACCT-SEC
      *
               PERFORM 2001-EDIT-TNSHOUKAI-SEC
      *
               MOVE    CONST-HKNCOMBICD    TO  WRK-SRYCD
               PERFORM 2002-EDIT-TNSHOUKAI-SEC
      *
               MOVE    TGIHAKUNACCT-REC    TO  TNACCT-REC
               PERFORM 2001-EDIT-NACCT-SEC
               MOVE    CONST-GAIHAKUCD     TO  WRK-SRYCD
               PERFORM 2002-EDIT-TNSHOUKAI-SEC
      *
           END-PERFORM
      *
           PERFORM 2001-EDIT-NSHOUKAI-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴退避領域
      *****************************************************************
       2001-EDIT-TNRRK-SEC           SECTION.
      *
           PERFORM 900-PTNYUINRRK-KEY24-SEL-SEC
      *
           PERFORM UNTIL ( FLG-PTNYUINRRK  NOT =   ZERO )
                    OR   ( TNRRK-MAX        >=   CONST-TNRRK-MAX )
      *
               COMPUTE TNRRK-MAX =   TNRRK-MAX +   1
      *
               MOVE    PTNYUINRRK-RRKNUM
                                   TO  TNRRK-RRKNUM   (TNRRK-MAX)
               MOVE    PTNYUINRRK-NYUINYMD
                                   TO  TNRRK-NYUINYMD (TNRRK-MAX)
               MOVE    PTNYUINRRK-DOUJITSUKBN
                                   TO  TNRRK-DOUJITSUKBN (TNRRK-MAX)
      *
               IF    ( PTNYUINRRK-NYUINYMD (1:6)
                                           =  SS010-SRYYM )
                   MOVE    PTNYUINRRK-NYUINYMD
                                   TO  TNRRK-TENNYUYMD(TNRRK-MAX)
               ELSE
                   MOVE    WRK-BOMYMD
                                   TO  TNRRK-TENNYUYMD(TNRRK-MAX)
               END-IF
      *
               IF    ( PTNYUINRRK-TAIINYMD (1:6)
                                           =  SS010-SRYYM )
                   MOVE    PTNYUINRRK-TAIINYMD
                                   TO  TNRRK-TENSTUYMD(TNRRK-MAX)
               ELSE
                   MOVE    WRK-EOMYMD
                                   TO  TNRRK-TENSTUYMD(TNRRK-MAX)
               END-IF
      *
               IF    ( PTNYUINRRK-TAIINYMD
                                   =   TNRRK-TENSTUYMD(TNRRK-MAX))
                   MOVE    "1"         TO  TNRRK-SKYKBN (TNRRK-MAX)
               ELSE
                   MOVE    "2"         TO  TNRRK-SKYKBN (TNRRK-MAX)
               END-IF
      *
               PERFORM 900-PTNYUINRRK-KEY24-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_ptnyuinrrk"    TO  MCP-TABLE
           MOVE    "key24"             TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       2001-EDIT-TNRRK-EXT.
           EXIT.
      *****************************************************************
      *    入院会計編集処理（剤回数調整）
      *****************************************************************
       2001-EDIT-NACCT-SEC             SECTION.
      *
           MOVE    TNACCT-REC      TO  NYUINACCT-REC
           MOVE    ZERO            TO  NACCT-ZAIKAISU
           INITIALIZE                  NACCT-DAY-AREA
           PERFORM VARYING IDX-DAY FROM    1   BY  1
                   UNTIL ( IDX-DAY >   31 )
      *
               MOVE    1           TO  FLG-HIT
      *
               MOVE    SS010-SRYYM TO  WRK-SRYYM
               MOVE    IDX-DAY     TO  WRK-SRYDD
      *
               IF    ( IDX-DAY     >=  TNRRK-TENNYUDD(IDX-NRRK))
                AND  ( IDX-DAY     <=  TNRRK-TENSTUDD(IDX-NRRK))
                   CONTINUE
               ELSE
                   MOVE    ZERO    TO  FLG-HIT
               END-IF
      *
               IF    ( NACCT-ZAISKBKBN =   "2" )
                AND  ( TNRRK-NYUINYMD    (IDX-NRRK)
                                           =   WRK-SRYYMD )
                AND  ( TNRRK-DOUJITSUKBN (IDX-NRRK)
                                           =   "1" )
                   MOVE    ZERO    TO  FLG-HIT
               END-IF
      *
               IF    ( FLG-HIT     =   1 )
      *
                   MOVE    TNACCT-DAY (IDX-DAY)
                                       TO  NACCT-DAY (IDX-DAY)
                   COMPUTE NACCT-ZAIKAISU
                       =   NACCT-ZAIKAISU
                       +   TNACCT-DAY (IDX-DAY)
               END-IF
      *
           END-PERFORM
      *
           .
       2001-EDIT-NACCT-EXT.
           EXIT.
      *****************************************************************
      *    入院診療行為照会退避領域
      *****************************************************************
       2001-EDIT-TNSHOUKAI-SEC         SECTION.
      *
           IF    ( NACCT-ZAIKAISU  >   ZERO )
      *
               MOVE    "1"             TO  SS009-REQUEST
               MOVE    TNRRK-RRKNUM   (IDX-NRRK)
                                       TO  SS009-RRKNUM
               MOVE    TNRRK-SKYKBN   (IDX-NRRK)
                                       TO  SS009-SKYKBN
               MOVE    TNRRK-TENNYUYMD(IDX-NRRK)
                                       TO  SS009-STYMD
               MOVE    TNRRK-TENSTUYMD(IDX-NRRK)
                                       TO  SS009-EDYMD
               MOVE    "1"             TO  SS009-EXGAIHAKU
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
                   MOVE    SS009-SRYKBN  (IDX0)
                                           TO  KEY-SRYKBN
                   MOVE    SS009-SRYCD   (IDX0 IDX1)
                                           TO  KEY-SRYCD
                   MOVE    SS009-SURYO   (IDX0 IDX1)
                                           TO  KEY-SRYSURYO
                   MOVE    SS009-BRMNUM-DAY(IDX-DAY)
                                           TO  KEY-BRMNUM
                   MOVE    SS009-SAGAKUCD-DAY(IDX-DAY)
                                           TO  KEY-RM-SAGAKU
                   MOVE    SS009-RRKNUM    TO  KEY-RRKNUM
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
                    AND  ( KEY-SRYKBN  =   TNSHOUKAI-SRYKBN  (IDX3))
                    AND  ( KEY-SRYCD   =   TNSHOUKAI-SRYCD   (IDX3))
                    AND  ( KEY-SRYSURYO =  TNSHOUKAI-SRYSURYO(IDX3))
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
               MOVE    KEY-SRYKBN      TO  TNSHOUKAI-SRYKBN
                                                       (IDX-TNSHOUKAI)
               MOVE    KEY-SRYCD       TO  TNSHOUKAI-SRYCD
                                                       (IDX-TNSHOUKAI)
               MOVE    KEY-SRYSURYO    TO  TNSHOUKAI-SRYSURYO
                                                       (IDX-TNSHOUKAI)
               MOVE    KEY-BRMNUM      TO  TNSHOUKAI-BRMNUM
                                                       (IDX-TNSHOUKAI)
               MOVE    KEY-RM-SAGAKU   TO  TNSHOUKAI-RM-SAGAKU
                                                       (IDX-TNSHOUKAI)
               MOVE    IDX-TNSHOUKAI   TO  TNSHOUKAI-MAX
      *
           END-IF
      *
           MOVE    ZERO                TO  IDX5
           PERFORM VARYING IDX4    FROM    1   BY  1
                   UNTIL ( IDX4    >   31 )
                    OR   ( IDX5    >   ZERO )
      *
               IF    ( TNSHOUKAI-DAY-RRKNUM(IDX-TNSHOUKAI  IDX4)
                                       =   ZERO )
                   MOVE    KEY-RRKNUM
                                   TO  TNSHOUKAI-DAY-RRKNUM
                                           (IDX-TNSHOUKAI  IDX4)
                       MOVE    IDX4    TO  IDX5
               ELSE
                   IF    ( TNSHOUKAI-DAY-RRKNUM
                                           (IDX-TNSHOUKAI IDX4)
                                   =   KEY-RRKNUM )
                       MOVE    IDX4    TO  IDX5
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           IF    ( IDX5            >   ZERO )
               MOVE    1           TO  TNSHOUKAI-DAY
                                      (IDX-TNSHOUKAI IDX5 IDX-DAY)
           END-IF
      *
           .
       200111-EDIT-TNSHOUKAI-EXT.
           EXIT.
      *****************************************************************
      *    入院診療行為照会退避領域（保険組合せ・外泊）
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
                   MOVE    SS009-HKNCOMBI-DAY (IDX-DAY)
                                           TO  KEY-HKNCOMBI9
                   MOVE    "00"
                                           TO  KEY-SRYKBN
                   MOVE    WRK-SRYCD       TO  KEY-SRYCD
                   MOVE    1               TO  KEY-SRYSURYO
                   MOVE    SS009-BRMNUM-DAY(IDX-DAY)
                                           TO  KEY-BRMNUM
                   MOVE    SS009-SAGAKUCD-DAY(IDX-DAY)
                                           TO  KEY-RM-SAGAKU
                   MOVE    SS009-RRKNUM    TO  KEY-RRKNUM
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
               MOVE    TNSHOUKAI-SRYKBN (IDX3)
                                       TO  NSRYSRH-SRYKBN
               MOVE    TNSHOUKAI-SRYCD (IDX3)
                                       TO  NSRYSRH-SRYCD
               MOVE    TNSHOUKAI-SRYSURYO (IDX3)
                                       TO  NSRYSRH-SRYSURYO
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
               PERFORM VARYING IDX5  FROM    1   BY  1
                       UNTIL ( IDX5  >   31 )
                        OR   ( TNSHOUKAI-DAY-RRKNUM (IDX3 IDX5)
                                     =   ZERO )
      *
                   PERFORM VARYING IDX-DAY FROM    1   BY  1
                           UNTIL ( IDX-DAY >   31 )
      *
                       IF    ( TNSHOUKAI-DAY (IDX3 IDX5 IDX-DAY)
                                       NOT =  ZERO )
                           INITIALIZE                  NRRKSRH-REC
                           MOVE    SPA-HOSPNUM     TO  NRRKSRH-HOSPNUM
                           MOVE    SS010-PTID      TO  NRRKSRH-PTID
                           MOVE    SS010-SRYYM     TO  WRK-SRYYM
                           MOVE    IDX-DAY         TO  WRK-SRYDD
                           MOVE    WRK-SRYYMD      TO  NRRKSRH-SRYYMD
                           MOVE    WRK-ZAINUM      TO  NRRKSRH-ZAINUM
                           MOVE    TNSHOUKAI-DAY-RRKNUM (IDX3 IDX5)
                                                   TO  NRRKSRH-RRKNUM
                           MOVE    SMCNDATE-YMD    TO  NRRKSRH-CREYMD
                                                       NRRKSRH-UPYMD
                           MOVE    SMCNDATE-HMS    TO  NRRKSRH-UPHMS
                           MOVE    NRRKSRH-REC     TO  MCPDATA-REC
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
                   END-PERFORM
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
      *    PERFORM 800-DISPLAY-SEC
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
               PERFORM VARYING IDX5  FROM    1   BY  1
                       UNTIL ( IDX5  >   31 )
                        OR   ( TNSHOUKAI-DAY-RRKNUM (IDX3 IDX5)
                                     =   ZERO )
      *
                   PERFORM VARYING IDX-DAY FROM    1   BY  1
                           UNTIL ( IDX-DAY >   31 )
      *
                       IF    ( TNSHOUKAI-DAY (IDX3 IDX5 IDX-DAY)
                                       NOT =  ZERO)
                           DISPLAY "SS010 " TNSHOUKAI-MAX
                                   ":"      SS010-PTID
                                   " "      TNSHOUKAI-SRYKA(IDX3)
                                   " "      TNSHOUKAI-HKNCOMBI(IDX3)
                                   " "      TNSHOUKAI-SRYKBN(IDX3)
                                   " "      TNSHOUKAI-SRYCD(IDX3)
                                   " "      TNSHOUKAI-SRYSURYO(IDX3)
                                   " "      SS010-SRYYM
                                            IDX-DAY
                       END-IF
      *
                   END-PERFORM
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
      *    入院会計検索処理
      *****************************************************************
       900-NYUINACCT-KEY54-SEL-SEC     SECTION.
      *
           MOVE    ZERO                TO  FLG-NYUINACCT
           INITIALIZE                  NYUINACCT-REC
      *
           MOVE    SPA-HOSPNUM         TO  NACCT-HOSPNUM
           MOVE    SS010-PTID          TO  NACCT-PTID
           MOVE    "1"                 TO  NACCT-NYUGAIKBN
           MOVE    "5"                 TO  NACCT-ZAISKBKBN
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "key54"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  NYUINACCT-REC
           ELSE
               MOVE    1               TO  FLG-NYUINACCT
               INITIALIZE                  NYUINACCT-REC
           END-IF
      *
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "key54"             TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-NYUINACCT-KEY54-SEL-EXT.
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
           MOVE    WRK-ZAISKBKBN       TO  NACCT-ZAISKBKBN
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
      *    入院履歴検索処理
      *****************************************************************
       900-PTNYUINRRK-KEY24-SEL-SEC    SECTION.
      *
           MOVE    ZERO                TO  FLG-PTNYUINRRK
           INITIALIZE                      PTNYUINRRK-REC
      *
           MOVE    SPA-HOSPNUM         TO  PTNYUINRRK-HOSPNUM
           MOVE    SS010-PTID          TO  PTNYUINRRK-PTID
           MOVE    WRK-EOMYMD          TO  PTNYUINRRK-NYUINYMD
           MOVE    WRK-BOMYMD          TO  PTNYUINRRK-TAIINYMD
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "tbl_ptnyuinrrk"    TO  MCP-TABLE
           MOVE    "key24"             TO  MCP-PATHNAME
           PERFORM 911-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
           ELSE
               MOVE    1               TO  FLG-PTNYUINRRK
               INITIALIZE                  PTNYUINRRK-REC
           END-IF
      *
      *
           .
       900-PTNYUINRRK-KEY24-SEL-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴FETCH処理
      *****************************************************************
       900-PTNYUINRRK-KEY24-FET-SEC     SECTION.
      *
           MOVE    "tbl_ptnyuinrrk"    TO  MCP-TABLE
           MOVE    "key24"             TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
           ELSE
               MOVE    1               TO  FLG-PTNYUINRRK
               INITIALIZE                  PTNYUINRRK-REC
           END-IF
      *
           .
       900-PTNYUINRRK-KEY24-FET-EXT.
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
      **     DISPLAY "SS010-RC = " SS010-RC
      *
           EXIT PROGRAM
      *
           .
       990-EXIT-PROGRAM-EXT.
           EXIT.
