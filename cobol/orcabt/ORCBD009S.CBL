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
       PROGRAM-ID.                     ORCBD009S.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : 入院オーダーエラーリスト編集サブ
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/11/11    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
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
       WORKING-STORAGE                 SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-KHNERR              PIC 9(01).
           03  FLG-ORDER               PIC 9(01).
      *
      *    カウント領域
      *01  CNT-AREA.
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                    PIC 9(05).
           03  IDX-CMB                 PIC 9(05).
           03  IDX-MAX                 PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-CMB-CD              PIC X(10).
           03  WRK-CMB-ITM-G.
               05  WRK-CMB-IDX         PIC 9(05).
               05  WRK-CMB-ITM         PIC X(200).
               05  WRK-CMB-ITM2        PIC X(200).
           03  WRK-STR                 PIC X(500).
      *
       01  ERR-ORDER-REC.
           02  ERR-ORDER-MAX           PIC 9(03).
           02  ERR-ORDER-OCC           OCCURS   30.
           COPY    "CPORDER.INC"       REPLACING  //ORDER-//
                                       BY         //ERR-ORDER-//.
       01  CONST-AREA.
           03  CONST-ERRCD-MAX             PIC 9(05)   VALUE 100.
           03  CONST-ERRCDUNCHK            PIC X(03)   VALUE "901".
           03  CONST-ORDER-MAX             PIC 9(05)   VALUE 30.
           03  CONST-ITEM-MAX              PIC 9(05)   VALUE 80.
      *
      *    項目IDコピー句
           COPY    "CPNCLAIMID.INC".
      *
      *    ORDERIDコピー句
           COPY    "CPNORDERID.INC".
      *
      *    エラーコード
           COPY    "CPNCLAIMERRCD.INC".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    オーダーテーブル
       01  ORDER-REC.
           COPY    "CPORDER.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    入院異動チェックサブ
           COPY    "CPORCSODR.INC".
       01  SORDER-REC.
           02  SORDER-MAX              PIC 9(03).
           02  SORDER-OCC              OCCURS   30.
           COPY    "CPORDER.INC"       REPLACING  //ORDER-//
                                       BY         //SORDER-//.
      *
           COPY    "MCPDATA.INC".
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                         SECTION.
      *
      *    入院オーダーエラーリスト編集サブ
           COPY    "CPORCBD009S.INC".
       01  LNK-ORDER-REC.
           COPY    "CPORDER.INC"       REPLACING  //ORDER-//
                                       BY         //LNK-ORDER-//.
      *
      ******************************************************************
      *
       PROCEDURE                       DIVISION
                                       USING
                                               ORCSBD009SAREA
                                               LNK-ORDER-REC.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           INITIALIZE                  WRK-AREA
           INITIALIZE                  FLG-AREA
      *    INITIALIZE                  CNT-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  ORCSBD009SAREA
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           PERFORM 4101-EDIT-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    編集処理
      *****************************************************************
       4101-EDIT-SEC                   SECTION.
      *
           IF    ( LNK-ORDER-STATUS-ORDER  =   "4" )
               PERFORM 41011-DIRECT-UPD-KHNCHK-SEC
               IF    ( FLG-KHNERR  NOT =   ZERO )
                   GO  TO  4101-EDIT-EXT
               END-IF
           ELSE
               PERFORM 41011-KHNERR-HEN-SEC
           END-IF
      *
           .
       4101-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    基本項目エラー時編集処理
      *****************************************************************
       41011-KHNERR-HEN-SEC            SECTION.
      *
           INITIALIZE                  ERR-ORDER-REC
      *
           PERFORM 900-ORDER-KEY6-SEL-SEC
      *
           PERFORM UNTIL ( FLG-ORDER   NOT =   ZERO )
      *
               IF    ( ERR-ORDER-MAX   >=  CONST-ORDER-MAX )
                   CONTINUE
               ELSE
                   COMPUTE ERR-ORDER-MAX   =   ERR-ORDER-MAX   +   1
                   MOVE    ORDER-REC   TO  ERR-ORDER-OCC (ERR-ORDER-MAX)
               END-IF
      *
               PERFORM 900-ORDER-KEY6-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_order"         TO  MCP-TABLE
           MOVE    "key6"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           PERFORM 410111-EDIT-ERRMES-SEC
      *
           .
       41011-KHNERR-HEN-EXT.
           EXIT.
      *****************************************************************
      *    直接更新時基本項目チェック処理
      *****************************************************************
       41011-DIRECT-UPD-KHNCHK-SEC     SECTION.
      *
           MOVE    ZERO            TO  FLG-KHNERR
      *
           INITIALIZE                  SODR-AREA
           INITIALIZE                  SORDER-REC
      *
           MOVE    LNK-ORDER-HOSPID    TO  SODR-HOSPID
           MOVE    LNK-ORDER-KARTE-KEY TO  SODR-UID8
           MOVE    LNK-ORDER-ORDERNUM  TO  SODR-ORDERNUM
           CALL    "ORCSODRS02"        USING   SODR-AREA
                                               SORDER-REC
           IF    ( SODR-ERRCD  NOT =   SPACE )
      *
               MOVE    1           TO  FLG-KHNERR
               MOVE    SORDER-REC  TO  ERR-ORDER-REC
               PERFORM 410111-EDIT-ERRMES-SEC
      *
           END-IF
      *
           .
       41011-DIRECT-UPD-KHNCHK-EXT.
           EXIT.
      *****************************************************************
      *    エラーメッセージ編集処理
      *****************************************************************
       410111-EDIT-ERRMES-SEC          SECTION.
      *
           MOVE    ZERO                TO  IDX-MAX
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   ERR-ORDER-MAX )
      *
               MOVE    ERR-ORDER-OCC (IDX0)    TO  ORDER-REC
      *
               IF    ( IDX0        =   1 )
                   IF    ( ORDER-ERRCD-ORDER   NOT =   SPACE )
                       MOVE    ORDER-ERRCD-ORDER   TO  BD009S-ERRCD (1)
                       MOVE    ORDER-ERRCD-ORDER   TO  WRK-CMB-CD
                       PERFORM 4200-ERRCD-CHK-SEC
                       MOVE    WRK-CMB-ITM         TO  BD009S-ERRMES(1)
                       MOVE    1                   TO  IDX-MAX
                   END-IF
               END-IF
      *
               IF    ( ORDER-ERRCD-ITEM    NOT =   SPACE )
                   IF    ( IDX-MAX    >=   CONST-ERRCD-MAX )
                       CONTINUE
                   ELSE
                       COMPUTE IDX-MAX =   IDX-MAX +   1
      *
                       MOVE    ORDER-ERRCD-ITEM
                                           TO  BD009S-ERRCD (IDX-MAX)
                       IF    ( ORDER-ERRCD-ITEM (2:)
                                           =   CONST-ERRCDUNCHK )
                           MOVE    ORDER-ERRCD-ITEM    TO  WRK-CMB-CD
                           PERFORM 4200-ERRCD-CHK-SEC
                           MOVE    WRK-CMB-ITM         TO  WRK-STR
                           MOVE    ORDER-ITEMID        TO  WRK-CMB-CD
                           PERFORM 4200-NCLAIMID-CHK-SEC
                           STRING  WRK-STR         DELIMITED BY SPACE
                                   "［"            DELIMITED BY SIZE
                                   WRK-CMB-ITM     DELIMITED BY SPACE
                                   "］"            DELIMITED BY SIZE
                           INTO                BD009S-ERRMES(IDX-MAX)
                           END-STRING
                       ELSE
                           MOVE    ORDER-ERRCD-ITEM    TO  WRK-CMB-CD
                           PERFORM 4200-ERRCD-CHK-SEC
                           MOVE    WRK-CMB-ITM
                                           TO  BD009S-ERRMES(IDX-MAX)
                       END-IF
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           MOVE    IDX-MAX             TO  BD009S-ERR-CNT
      *
           .
       410111-EDIT-ERRMES-EXT.
           EXIT.
      *****************************************************************
      *    オーダーエラーコードチェック処理
      *****************************************************************
       4200-ERRCD-CHK-SEC              SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB         >   NCLAIMERRCD-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( NCLAIMERRCDL (IDX-CMB) =   WRK-CMB-CD )
                   MOVE    NCLAIMERRCDLMEI  (IDX-CMB)
                                       TO  WRK-CMB-ITM
                   MOVE    IDX-CMB     TO  WRK-CMB-IDX
               END-IF
      *
           END-PERFORM
      *
           .
       4200-ERRCD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    オーダー項目名称チェック処理
      *****************************************************************
       4200-NCLAIMID-CHK-SEC         SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB         >   NCLAIMID-ITEM-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( NCLAIMID-ITEMJMA (IDX-CMB)  =   WRK-CMB-CD )
                   MOVE    NCLAIMID-ITEMMES  (IDX-CMB)
                                       TO  WRK-CMB-ITM
                   MOVE    IDX-CMB     TO  WRK-CMB-IDX
               END-IF
      *
           END-PERFORM
      *
           .
       4200-NCLAIMID-CHK-EXT.
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
      *    入院オーダー検索(KEY6)
      *****************************************************************
       900-ORDER-KEY6-SEL-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-ORDER
      *
           INITIALIZE                      ORDER-REC
           MOVE    LNK-ORDER-HOSPID    TO  ORDER-HOSPID
           MOVE    LNK-ORDER-KARTE-KEY TO  ORDER-KARTE-KEY
           MOVE    LNK-ORDER-ORDERNUM  TO  ORDER-ORDERNUM
           MOVE    ORDER-REC           TO  MCPDATA-REC
           MOVE    "tbl_order"         TO  MCP-TABLE
           MOVE    "key6"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  ORDER-REC
           ELSE
               INITIALIZE                  ORDER-REC
               MOVE    1               TO  FLG-ORDER
           END-IF
      *
           .
       900-ORDER-KEY6-SEL-EXT.
           EXIT.
      *****************************************************************
      *    入院オーダーFETCH(KEY6)
      *****************************************************************
       900-ORDER-KEY6-FET-SEC          SECTION.
      *
           MOVE    "tbl_order"     TO  MCP-TABLE
           MOVE    "key6"          TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  ORDER-REC
           ELSE
               INITIALIZE              ORDER-REC
               MOVE    1           TO  FLG-ORDER
           END-IF
      *
           .
       900-ORDER-KEY6-FET-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
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
      *    ＤＢ検索処理
      *****************************************************************
       911-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC           SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBCLOSECURSOR-EXT.
           EXIT.
