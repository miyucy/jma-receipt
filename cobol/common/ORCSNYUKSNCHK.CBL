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
       PROGRAM-ID.             ORCSNYUKSNCHK.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : 入院料加算チェック
      *  管理者            : 
      *  12/04/21    NACL−太田    新規作成
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
       DATA                        DIVISION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-NYUKSNCHK       PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                PIC 9(05).
           03  IDX-KHN             PIC 9(05).
      *
       01  WRK-AREA.
           03  WRK-SRYCD                       PIC X(09).
           03  WRK-KHN-G.
             04  WRK-KHN-MAX                   PIC 9(03).
             04  WRK-KHN-OCC                   OCCURS  10.
               05  WRK-KHN-SRYCD               PIC X(09).
               05  WRK-KHN-KSNKBN.
                   07  WRK-KHN-KSNKBN9         PIC 9(03).
               05  WRK-KHN-KHNKBN              PIC 9(02).
               05  WRK-KHN-CDKBN-KBNNUM        PIC 9(03).
               05  WRK-KHN-CDKBN-KBNNUM-EDA    PIC 9(02).
      *
           03  WRK-KSN-G.
               05  WRK-KSN-SRYCD               PIC X(09).
               05  WRK-KSN-KSNKBN.
                   07  WRK-KSN-KSNKBN9         PIC 9(03).
               05  WRK-KSN-KHNKBN              PIC 9(02).
               05  WRK-KSN-CDKBN-KBNNUM        PIC 9(03).
               05  WRK-KSN-CDKBN-KBNNUM-EDA    PIC 9(02).
      *
       01  CONST-AREA.
           03  CONST-H240401       PIC X(08)   VALUE   "20120401".
           03  CONST-H180701       PIC X(08)   VALUE   "20060701".
      *
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
           COPY   "CPSYSKANRI.INC".
           COPY   "CPSK5110.INC".
           COPY   "CPSK5111.INC".
      *
           COPY   "CPTENSU.INC".
      *
       01  NYUKSNCHK-REC.
           COPY   "CPNYUKSNCHK.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY   "CPORCSNYUKSNCHK.INC".
           COPY   "COMMON-SPA".
      *
      *****************************************************************
      *
       PROCEDURE                   DIVISION    USING
                                   SNYUKSNCHK-LNK
                                   SPA-AREA
           .
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
           PERFORM 100-INIT-SEC
      *
           IF    ( SNYUKSNCHK-ERR    = ZERO )
               PERFORM 200-MAIN-SEC
           END-IF
      *
           PERFORM 300-END-SEC
      *
           .
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           MOVE    ZERO                    TO  SNYUKSNCHK-ERR
      *
           MOVE    SNYUKSNCHK-KHN-SRYCD    TO  WRK-SRYCD
           EVALUATE    WRK-SRYCD
           WHEN    "099999950"
               MOVE    "190097010"         TO  WRK-SRYCD
           WHEN    "099999951"
               MOVE    "190097210"         TO  WRK-SRYCD
           WHEN    "099999952"
               MOVE    "190135110"         TO  WRK-SRYCD
           WHEN    "099999953"
               MOVE    "190121310"         TO  WRK-SRYCD
           WHEN    "099999954"
               MOVE    "190132410"         TO  WRK-SRYCD
           WHEN    SPACE
               IF    ( SNYUKSNCHK-BTUSBT   =   "04" )
                AND  ( SNYUKSNCHK-SRYYMD  >=   CONST-H180701 )
                   MOVE    "190121310"     TO  WRK-SRYCD
               END-IF
               IF    ( SNYUKSNCHK-BTUSBT   =   "09" )
                AND  ( SNYUKSNCHK-SRYYMD  >=   CONST-H180701 )
                   MOVE    "190122010"     TO  WRK-SRYCD
               END-IF
           END-EVALUATE
           IF    ( WRK-SRYCD               NOT =   SPACE )
               PERFORM 1001-KHNCD-EDIT-SEC
           END-IF
      *
           IF    ( SNYUKSNCHK-BTU-TOKKBN   NOT =   SPACE )
               INITIALIZE      SYSKANRI-REC
               MOVE    "5110"              TO  SYS-KANRICD
               MOVE    SNYUKSNCHK-BTU-TOKKBN
                                           TO  SYS-KBNCD
               PERFORM 900-SYSKANRI-KEY10-SEL-SEC
               MOVE    SYSKANRI-REC        TO  SYS-5110-REC
               MOVE    SYS-5110-SRYCD      TO  WRK-SRYCD
               PERFORM 1001-KHNCD-EDIT-SEC
           END-IF
      *
           IF    ( SNYUKSNCHK-BRM-TOKKBN   NOT =   SPACE )
               INITIALIZE      SYSKANRI-REC
               MOVE    "5111"              TO  SYS-KANRICD
               MOVE    SNYUKSNCHK-BRM-TOKKBN
                                           TO  SYS-KBNCD
               PERFORM 900-SYSKANRI-KEY10-SEL-SEC
               MOVE    SYSKANRI-REC        TO  SYS-5111-REC
               MOVE    SYS-5111-SRYCD      TO  WRK-SRYCD
               PERFORM 1001-KHNCD-EDIT-SEC
           END-IF
      *
           EVALUATE    TRUE
           WHEN  ( SNYUKSNCHK-BTUSBT   =   SPACE )
               CONTINUE
           WHEN  ( SNYUKSNCHK-BTUSBT   =   "01" )
               IF    ( SNYUKSNCHK-RYOYOKBN     =   "1" )
                OR   ( SNYUKSNCHK-BTU-TOKKBN   =   "33"
                                                OR "34" )
                   MOVE    "190121310"     TO  WRK-SRYCD
                   PERFORM 1001-KHNCD-EDIT-SEC
               END-IF
           WHEN  ( SNYUKSNCHK-BTUSBT   =   "08" )
               IF    ( SNYUKSNCHK-RYOYOKBN     =  "1" OR "2" OR "3" )
                   MOVE    "190122010"     TO  WRK-SRYCD
                   PERFORM 1001-KHNCD-EDIT-SEC
               END-IF
           WHEN  ( SNYUKSNCHK-BTUSBT   =   "09" )
               EVALUATE    SNYUKSNCHK-RYOYOKBN
               WHEN    "1"
                   MOVE    "190097010"     TO  WRK-SRYCD
                   PERFORM 1001-KHNCD-EDIT-SEC
               WHEN    "2"
                   MOVE    "190097210"     TO  WRK-SRYCD
                   PERFORM 1001-KHNCD-EDIT-SEC
               WHEN    "3"
                   MOVE    "190135110"     TO  WRK-SRYCD
                   PERFORM 1001-KHNCD-EDIT-SEC
               END-EVALUATE
           END-EVALUATE
      *
           MOVE    SNYUKSNCHK-KSN-SRYCD    TO  WRK-KSN-SRYCD
           EVALUATE    WRK-KSN-SRYCD
           WHEN    "190100170"
           WHEN    "190145370"
               MOVE    "190100070"         TO  WRK-KSN-SRYCD
           WHEN    "190145970"
           WHEN    "190146070"
               MOVE    "190136010"         TO  WRK-KSN-SRYCD
           WHEN    "190146170"
               MOVE    "190145810"         TO  WRK-KSN-SRYCD
           WHEN   "190146870"
               MOVE    "190110070"         TO  WRK-KSN-SRYCD
           WHEN    "190147470"
               MOVE    "190147210"         TO  WRK-KSN-SRYCD
           END-EVALUATE
      *
           MOVE    WRK-KSN-SRYCD           TO  WRK-SRYCD
           PERFORM 900-TENSU-KEY-SEL-SEC
           IF    ( FLG-TENSU               =   ZERO )
               MOVE    TNS-NYUKHNKSNKBN    TO  WRK-KSN-KSNKBN9
               MOVE    TNS-NYUKHNKBN       TO  WRK-KSN-KHNKBN
               MOVE    TNS-CDKBN-KBNNUM    TO  WRK-KSN-CDKBN-KBNNUM
               MOVE    TNS-CDKBN-KBNNUM-EDA TO WRK-KSN-CDKBN-KBNNUM-EDA
           ELSE
               MOVE    1                   TO  SNYUKSNCHK-ERR
           END-IF
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院料編集処理
      *****************************************************************
       1001-KHNCD-EDIT-SEC                    SECTION.
      *
           PERFORM 900-TENSU-KEY-SEL-SEC
           IF    ( FLG-TENSU               =   ZERO )
               COMPUTE WRK-KHN-MAX =   WRK-KHN-MAX     +   1
               MOVE    TNS-SRYCD           TO  WRK-KHN-SRYCD
                                                          (WRK-KHN-MAX)
               MOVE    TNS-NYUKHNKSNKBN    TO  WRK-KHN-KSNKBN9
                                                          (WRK-KHN-MAX)
               MOVE    TNS-NYUKHNKBN       TO  WRK-KHN-KHNKBN
                                                          (WRK-KHN-MAX)
               MOVE    TNS-CDKBN-KBNNUM    TO  WRK-KHN-CDKBN-KBNNUM
                                                          (WRK-KHN-MAX)
               MOVE    TNS-CDKBN-KBNNUM-EDA TO WRK-KHN-CDKBN-KBNNUM-EDA
                                                          (WRK-KHN-MAX)
               IF    ( SNYUKSNCHK-SRYYMD   >=  CONST-H240401 )
                   EVALUATE    TRUE
                   WHEN  ( TNS-CDKBN-KBNNUM    =   108 )
                    AND  ( TNS-CDKBN-KOUBAN    =    10 )
                       MOVE    109         TO  WRK-KHN-CDKBN-KBNNUM
                                                          (WRK-KHN-MAX)
                       MOVE    ZERO        TO  WRK-KHN-CDKBN-KBNNUM-EDA
                                                          (WRK-KHN-MAX)
                   WHEN  ( TNS-CDKBN-KBNNUM    =   109 )
                    AND  ( TNS-CDKBN-KOUBAN    =    11 )
                       MOVE    108         TO  WRK-KHN-CDKBN-KBNNUM
                                                          (WRK-KHN-MAX)
                       MOVE    ZERO        TO  WRK-KHN-CDKBN-KBNNUM-EDA
                                                          (WRK-KHN-MAX)
                   END-EVALUATE
               END-IF
           END-IF
      *
           .
       1001-KHNCD-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           MOVE    1               TO  SNYUKSNCHK-ERR
      *
           PERFORM VARYING IDX-KHN FROM    1   BY  1
                   UNTIL ( IDX-KHN >   WRK-KHN-MAX )
                    OR   ( SNYUKSNCHK-ERR  =   ZERO )
      *
               EVALUATE    TRUE
               WHEN  ( WRK-KHN-KSNKBN9 (IDX-KHN) >   0 )
                AND  ( WRK-KSN-KSNKBN9 >   0 )
                   PERFORM 2001-KSNCHK-SEC
               WHEN  ( WRK-KSN-CDKBN-KBNNUM  >=   100 )
                AND  ( WRK-KSN-CDKBN-KBNNUM  <=   199 )
               WHEN  ( WRK-KSN-CDKBN-KBNNUM  >=   300 )
                AND  ( WRK-KSN-CDKBN-KBNNUM  <=   400 )
                   IF   SNYUKSNCHK-SRYYMD  <=   "20140331"
                      PERFORM 2001-KBNNUMCHK-SEC
                   END-IF
               WHEN    OTHER
                   MOVE    ZERO        TO  SNYUKSNCHK-ERR
               END-EVALUATE
      *
           DISPLAY IDX-KHN ": KHN-SRYCD [" WRK-KHN-SRYCD(IDX-KHN) "]"
                   "KHN-KSNKBN[" WRK-KHN-KSNKBN(IDX-KHN) "]"
                   "KHN-KHNKBN[" WRK-KHN-KHNKBN(IDX-KHN) "]"
                   "KHN-CDKBN-KBNNUM[" WRK-KHN-CDKBN-KBNNUM(IDX-KHN) "]"
                 "/ KSN-SRYCD [" WRK-KSN-SRYCD  "]"
                   "KSN-KSNKBN[" WRK-KSN-KSNKBN "]"
                   "KSN-KHNKBN[" WRK-KSN-KHNKBN "]"
                   "KSN-CDKBN-KBNNUM[" WRK-KSN-CDKBN-KBNNUM "]"
                   "ERR[" SNYUKSNCHK-ERR "]"

      *
           END-PERFORM
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    入院料加算テーブルによるチェック
      *****************************************************************
       2001-KSNCHK-SEC                 SECTION.
      *
           PERFORM 900-NYUKSNCHK-KEY-SEL-SEC
           IF    ( NYUKSNCHK-CHKKBN    =   "1" OR "2" )
               MOVE    ZERO        TO  SNYUKSNCHK-ERR
           END-IF
      *
           .
       2001-KSNCHK-EXT.
           EXIT.
      *****************************************************************
      *    区分番号による妥当性チェック
      *****************************************************************
       2001-KBNNUMCHK-SEC              SECTION.
      *
           IF    ( WRK-KHN-CDKBN-KBNNUM (IDX-KHN)
                                   =   WRK-KSN-CDKBN-KBNNUM )
            AND  ( WRK-KHN-CDKBN-KBNNUM-EDA (IDX-KHN)
                                   =   WRK-KSN-CDKBN-KBNNUM-EDA )
               MOVE    ZERO        TO  SNYUKSNCHK-ERR
               IF    ( WRK-KHN-KHNKBN  (IDX-KHN)
                                       >   ZERO )
                AND  ( WRK-KSN-KHNKBN  >   ZERO )
                   IF    ( WRK-KHN-KHNKBN  (IDX-KHN)
                                   NOT =   WRK-KSN-KHNKBN )
                       MOVE    1   TO  SNYUKSNCHK-ERR
                   END-IF
               END-IF
           END-IF
      *
           .
       2001-KBNNUMCHK-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
      *
           .
       300-END-EXT.
           EXIT.
      *****************************************************************
      *    入院料加算チェックテーブル検索処理(KEY)
      *****************************************************************
       900-NYUKSNCHK-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-NYUKSNCHK
      *
           INITIALIZE                      NYUKSNCHK-REC
           MOVE    WRK-KHN-KSNKBN (IDX-KHN)
                                       TO  NYUKSNCHK-NYUINKBN
           MOVE    WRK-KSN-KSNKBN      TO  NYUKSNCHK-KSNKBN
           MOVE    SNYUKSNCHK-SRYYMD   TO  NYUKSNCHK-YUKOSTYMD
                                           NYUKSNCHK-YUKOEDYMD
           MOVE    NYUKSNCHK-REC       TO  MCPDATA-REC
           MOVE    "tbl_nyuksnchk"     TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  NYUKSNCHK-REC
           ELSE
               INITIALIZE                  NYUKSNCHK-REC
               MOVE    1               TO  FLG-NYUKSNCHK
           END-IF
      *
      *
           MOVE    "tbl_nyuksnchk"     TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-NYUKSNCHK-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索処理
      *****************************************************************
       900-TENSU-KEY-SEL-SEC       SECTION.
      *
           MOVE    ZERO            TO  FLG-TENSU
      *
           INITIALIZE                  TNS-TENSU-REC
      *
           MOVE    WRK-SRYCD       TO  TNS-SRYCD
           MOVE    SNYUKSNCHK-SRYYMD
                                   TO  TNS-YUKOSTYMD
                                       TNS-YUKOEDYMD
           MOVE    SPA-HOSPNUM     TO  TNS-HOSPNUM
           MOVE    TNS-TENSU-REC   TO  MCPDATA-REC
      *
           MOVE    "tbl_tensu"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  TNS-TENSU-REC
           ELSE
               INITIALIZE              TNS-TENSU-REC
               MOVE    1           TO  FLG-TENSU
           END-IF
      *
      *    点数マスタクローズ
           MOVE    "tbl_tensu"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
      *
       900-TENSU-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理検索処理(KEY10)
      *****************************************************************
       900-SYSKANRI-KEY10-SEL-SEC      SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    SPA-HOSPNUM     TO  SYS-HOSPNUM
           MOVE    SNYUKSNCHK-SRYYMD
                                   TO  SYS-STYUKYMD
                                       SYS-EDYUKYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key10"         TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SYSKANRI-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
               INITIALIZE              SYSKANRI-REC
           END-IF
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key10"         TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-SYSKANRI-KEY10-SEL-EXT.
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
