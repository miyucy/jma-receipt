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
       PROGRAM-ID.                     ORCGQSUB03.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者照会
      *  コンポーネント名  : 患者照会サブ（診療情報編集）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/08/04    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-JYURRK                          PIC 9(01).
           03  FLG-SRYKARRK                        PIC 9(01).
           03  FLG-PTNYUINRRK                      PIC 9(01).
           03  FLG-HKNCOMBI                        PIC 9(01).
           03  FLG-SYSKANRI                        PIC 9(01).
           03  FLG-NYUIN                           PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                                PIC 9(05).
           03  IDX1                                PIC 9(05).
           03  IDX2                                PIC 9(05).
           03  IDX3                                PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-HKNCOMBI                        PIC X(04).
           03  WRK-HKNNUM                          PIC X(03).
           03  WRK-HKNCOMBI-MEI                    PIC X(10).
           03  WRK-SRYKA                           PIC X(02).
           03  WRK-LASTYMD                         PIC X(08).
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    受診履歴
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *    診療科履歴
       01  SRYKARRK-REC.
           COPY    "CPSRYKARRK.INC".
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPQSUB03.INC".
      *
       PROCEDURE                   DIVISION    USING
           QSUB03-LNK.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE              QSUB03-OT-AREA
                                   FLG-AREA
                                   IDX-AREA
                                   WRK-AREA
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           EXIT PROGRAM
           .
      *
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           MOVE    ZERO            TO  FLG-NYUIN
      *
           MOVE    SPACE           TO  WRK-HKNCOMBI
      *
           PERFORM 2001-NYUIN-CHK-SEC
      *
           IF    ( FLG-NYUIN       =   ZERO )
               PERFORM 2001-GAIRAI-CHK-SEC
           END-IF
      *
           PERFORM 2001-HKNCOMBI-HEN-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    入院情報チェック処理
      *****************************************************************
       2001-NYUIN-CHK-SEC              SECTION.
      *
      *    入院履歴判定
           INITIALIZE                      PTNYUINRRK-REC
           MOVE    QSUB03-HOSPID       TO  PTNYUINRRK-HOSPID
           MOVE    QSUB03-PTID         TO  PTNYUINRRK-PTID
           MOVE    QSUB03-KJNYMD       TO  PTNYUINRRK-NYUINYMD
           MOVE    QSUB03-KJNYMD       TO  PTNYUINRRK-TAIINYMD
      *
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "PTNYUINRRK-KEY11"  TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
      *
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
      *
               MOVE    PTNYUINRRK-NYUINKA
                                       TO  WRK-SRYKA
               MOVE    PTNYUINRRK-HKNCOMBINUM
                                       TO  WRK-HKNCOMBI
               MOVE    1               TO  FLG-NYUIN
           END-IF
      *
           MOVE    "PTNYUINRRK-KEY11"  TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       2001-NYUIN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    外来情報チェック処理
      *****************************************************************
       2001-GAIRAI-CHK-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-LASTYMD
      *
      *    診療科歴を検索
           INITIALIZE                      SRYKARRK-REC
           MOVE    QSUB03-HOSPID       TO  KARRK-HOSPID
           MOVE    QSUB03-PTID         TO  KARRK-PTID
      *
           MOVE    SRYKARRK-REC        TO  MCPDATA-REC
           MOVE    "SRYKARRK-KEY3"     TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
      *
               MOVE    MCPDATA-REC     TO  SRYKARRK-REC
      *
               MOVE    KARRK-LASTYMD   TO  WRK-LASTYMD
               MOVE    KARRK-SRYKA     TO  WRK-SRYKA
           END-IF
      *
           MOVE    "SRYKARRK-KEY3"     TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( WRK-LASTYMD     NOT =   SPACE )
      *
      *        保険の判定
               PERFORM 20011-JYURRK-HKN-HEN-SEC
           END-IF
      *
           .
       2001-GAIRAI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    保険編集処理（外来）
      *****************************************************************
       20011-JYURRK-HKN-HEN-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-JYURRK
      *
           INITIALIZE                      JYURRK-REC
           MOVE    QSUB03-HOSPID       TO  JYURRK-HOSPID
           MOVE    "2"                 TO  JYURRK-NYUGAIKBN
           MOVE    QSUB03-PTID         TO  JYURRK-PTID
           MOVE    WRK-LASTYMD         TO  JYURRK-SRYYMD
           MOVE    WRK-SRYKA           TO  JYURRK-SRYKA
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "JYURRK-KEY4"       TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  JYURRK-REC
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           PERFORM UNTIL ( FLG-JYURRK  =   1 )
      *
               IF    ( JYURRK-HKNCOMBINUM  NOT =   "9999" )
                   MOVE    JYURRK-HKNCOMBINUM
                                           TO  WRK-HKNCOMBI
                   MOVE    1               TO  FLG-JYURRK
               ELSE
                   MOVE    "JYURRK-KEY4"   TO  ORC-DBPATH
                   PERFORM 910-DBFETCH-SEC 
                   IF    ( MCP-RC          =   ZERO )
                       MOVE    MCPDATA-REC TO  JYURRK-REC
                   ELSE
                       INITIALIZE              JYURRK-REC
                       MOVE    1           TO  FLG-JYURRK
                   END-IF
               END-IF
           END-PERFORM
      *
           MOVE    "JYURRK-KEY4"       TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       20011-JYURRK-HKN-HEN-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ編集処理
      *****************************************************************
       2001-HKNCOMBI-HEN-SEC           SECTION.
      *
           MOVE    SPACE               TO  WRK-HKNCOMBI-MEI
           MOVE    SPACE               TO  WRK-HKNNUM
      *
           IF    ( WRK-HKNCOMBI    NOT =   SPACE )
               PERFORM 20011-HKNCOMBI-CHK1-SEC
           END-IF
      *
           IF    ( WRK-HKNCOMBI-MEI    =   SPACE )
               PERFORM 20011-HKNCOMBI-CHK2-SEC
           END-IF
      *
           .
       2001-HKNCOMBI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ編集処理
      *****************************************************************
       20011-HKNCOMBI-CHK1-SEC         SECTION.
      *
           INITIALIZE                      HKNCOMBI-REC
           MOVE    QSUB03-HOSPID       TO  COMB-HOSPID
           MOVE    QSUB03-PTID         TO  COMB-PTID
           MOVE    WRK-HKNCOMBI        TO  COMB-HKNCOMBINUM
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
      *
               MOVE    MCPDATA-REC     TO  HKNCOMBI-REC
      *
               IF       (  COMB-DELKBN NOT =   "1"  )
                  AND   (( QSUB03-KJNYMD  >=  COMB-TEKSTYMD )
                  AND    ( QSUB03-KJNYMD  <=  COMB-TEKEDYMD ))
                   PERFORM 200111-HKNCOMBI-MEI-SEC
               END-IF
           END-IF
      *
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       20011-HKNCOMBI-CHK1-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ編集処理
      *****************************************************************
       20011-HKNCOMBI-CHK2-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-HKNCOMBI
      *
           INITIALIZE                      HKNCOMBI-REC
           MOVE    QSUB03-HOSPID       TO  COMB-HOSPID
           MOVE    QSUB03-PTID         TO  COMB-PTID
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    "HKNCOMBI-KEY2"     TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  HKNCOMBI-REC
           ELSE
               MOVE    1               TO  FLG-HKNCOMBI
               INITIALIZE                  HKNCOMBI-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-HKNCOMBI    =   1 )
      *
               IF   (  COMB-DELKBN     NOT =   "1"  )  
                AND (( QSUB03-KJNYMD      >=   COMB-TEKSTYMD ) 
                 AND ( QSUB03-KJNYMD      <=   COMB-TEKEDYMD ))
                   IF    ( WRK-HKNNUM      =   SPACE )
                    OR   ( COMB-HKNNUM     =   "971"  OR  "973")
                       PERFORM 200111-HKNCOMBI-MEI-SEC
                   END-IF
               END-IF
      *
               MOVE    "HKNCOMBI-KEY2" TO  ORC-DBPATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC TO  HKNCOMBI-REC
               ELSE
                   MOVE    1           TO  FLG-HKNCOMBI
                   INITIALIZE              HKNCOMBI-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    "HKNCOMBI-KEY2"     TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       20011-HKNCOMBI-CHK2-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ名称編集処理
      *****************************************************************
       200111-HKNCOMBI-MEI-SEC             SECTION.
      *
      *    主保険がない時
           IF    ( COMB-SYU-TANSEIDONAME   =   SPACE )
               MOVE    COMB-KOH1-TANSEIDONAME  TO  WRK-HKNCOMBI-MEI
           ELSE
               MOVE    COMB-SYU-TANSEIDONAME   TO  WRK-HKNCOMBI-MEI
               MOVE    COMB-HKNNUM             TO  WRK-HKNNUM
           END-IF
      *
           .
       200111-HKNCOMBI-MEI-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
           MOVE    WRK-HKNCOMBI        TO  QSUB03-HKNCOMBI
           MOVE    WRK-HKNNUM          TO  QSUB03-HKNNUM
           MOVE    WRK-HKNCOMBI-MEI    TO  QSUB03-HKNCOMBIMEI
           MOVE    WRK-SRYKA           TO  QSUB03-SRYKA
           MOVE    WRK-LASTYMD         TO  QSUB03-LASTYMD
      *
           .
       300-END-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHも行う)
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
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
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
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
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBCLOSE-EXT.
           EXIT.
