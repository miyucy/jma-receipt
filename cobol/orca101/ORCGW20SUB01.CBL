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
       IDENTIFICATION                            DIVISION.
       PROGRAM-ID.                               ORCGW20SUB01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : 入院基本料算出サブ
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/07/30    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     NACL-太田    03.12.04  看護師３人以上でない場合、
      *                                     有床診療所１群入院基本料１
      *                                     は看護対置適合に置き換える
      *****************************************************************
      *
       ENVIRONMENT                               DIVISION.
       CONFIGURATION                             SECTION.
       INPUT-OUTPUT                              SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-NYUKHN                          PIC 9(01).
           03  FLG-TENSU                           PIC 9(01).
           03  FLG-DBRC                            PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                                PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-TNS-NAME                        PIC X(200).
           03  WRK-DBPATH                          PIC X(20).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    入院料算定マスタ
       01  NYUINKHN-REC.
           COPY  "CPNYUINKHN.INC".
      *
      *    点数マスタ
           COPY  "CPTENSU.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *
      *****************************************************************
      *    連絡領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPW20SUB01.INC".
      *
       PROCEDURE                   DIVISION    USING
                                               W20SUB01-LNK.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
           PERFORM 100-EDIT-SEC
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    編集処理
      *****************************************************************
       100-EDIT-SEC                    SECTION.
      *
           INITIALIZE  NYUINKHN-REC
                       W20SUB01-OT
      *
           EVALUATE    W20SUB01-I-KBN
      *
      *    診療行為コードで検索
           WHEN    "1"
               MOVE    W20SUB01-I-KHNSRYCD TO  NYUKHN-KHNSRYCD
               MOVE    W20SUB01-I-KJNYMD   TO  NYUKHN-YUKOSTYMD
                                               NYUKHN-YUKOEDYMD
               MOVE    "NYUINKHN-KEY"      TO  WRK-DBPATH
      *
      *    看護配置・平均在日数等で検索
           WHEN    "2"
               PERFORM 200-SELKEY-SET-SEC
      *
               MOVE    "NYUINKHN-KEY2"     TO  WRK-DBPATH
           WHEN    OTHER
               MOVE    1                   TO  W20SUB01-O-RC
           END-EVALUATE 
      *
           PERFORM 800-NYUKHN-SEL-SEC
           IF    ( FLG-NYUKHN      =   ZERO )
      *        看護配置・平均在日数等で検索の場合、
      *        有床診療所１群入院基本料１で、入力パラメータの
      *        看護師数区分が空白の場合、看護配置適合に置き換える
               IF    ( W20SUB01-I-KBN          =   "2" )
                 AND ( NYUKHN-KHNSRYCD         =   "190097010" )
                 AND ( W20SUB01-I-KNGSISUKBN   =   "1" )
                   INITIALIZE  NYUINKHN-REC
                   MOVE    "190109670"     TO  NYUKHN-KHNSRYCD
                   MOVE    W20SUB01-I-KJNYMD
                                           TO  NYUKHN-YUKOSTYMD
                                               NYUKHN-YUKOEDYMD
                   MOVE    "NYUINKHN-KEY"  TO  WRK-DBPATH
                   PERFORM 800-NYUKHN-SEL-SEC
                   IF    ( FLG-NYUKHN      =   ZERO )
                       PERFORM 1001-W20SUB01-0-HEN-SEC
                   ELSE
                       MOVE    1       TO  W20SUB01-O-RC
                   END-IF
               END-IF
      *
               PERFORM 1001-W20SUB01-0-HEN-SEC
           ELSE
               MOVE    1               TO  W20SUB01-O-RC
           END-IF
      *
           .
       100-EDIT-EXT.
          EXIT.
      *****************************************************************
      *    入院基本料算出サブ返却値編集処理
      *****************************************************************
       1001-W20SUB01-0-HEN-SEC         SECTION.
      *
           MOVE    ZERO        TO  W20SUB01-O-RC
           MOVE    WRK-TNS-NAME
                               TO  W20SUB01-O-NAME
           MOVE    NYUKHN-KHNSRYCD
                               TO  W20SUB01-O-KHNSRYCD
           MOVE    NYUKHN-KHNTEN
                               TO  W20SUB01-O-KHNTEN
           MOVE    NYUKHN-SSTKIJUNKBN
                               TO  W20SUB01-O-SSTKIJUNKBN
           MOVE    NYUKHN-BTUSBTKBN
                               TO  W20SUB01-O-BTUSBTKBN
           MOVE    NYUKHN-HEIKINZAIKBN
                               TO  W20SUB01-O-HEIKINZAIKBN
           MOVE    NYUKHN-KANGOHAICHIKBN
                               TO  W20SUB01-O-KANGOHAICHIKBN
           MOVE    NYUKHN-KANGOHIRITUKBN
                               TO  W20SUB01-O-KANGOHIRITUKBN
           MOVE    NYUKHN-KANGOHOJOHAICHIKBN
                               TO  W20SUB01-O-KANGOHOJOHAICHIKBN
      *
           .
       1001-W20SUB01-0-HEN-EXT.
          EXIT.
      *****************************************************************
      *    検索キー編集処理
      *****************************************************************
       200-SELKEY-SET-SEC              SECTION.
      *
           MOVE   "1"                  TO  NYUKHN-IPROUKBN
           MOVE   SPACE                TO  NYUKHN-SSTKIJUNKBN
           MOVE   W20SUB01-I-KJNYMD
                                       TO  NYUKHN-YUKOSTYMD
                                           NYUKHN-YUKOEDYMD
      *
      *
           EVALUATE    W20SUB01-I-BTUSBTKBN
      *
      *    一般病棟
           WHEN    "01"
               PERFORM 210-IPPAN-PARA-SET-SEC
      *    精神病棟
           WHEN    "02"
               PERFORM 210-SEISIN-PARA-SET-SEC
      *    結核病棟
           WHEN    "03"
               PERFORM 210-KEKKAKU-PARA-SET-SEC
      *    療養病棟
           WHEN    "04"
               PERFORM 210-RYOYO-PARA-SET-SEC
      *    障害者施設
           WHEN    "05"
               PERFORM 210-SYOGAI-PARA-SET-SEC
      *    専門病院
           WHEN    "06"
               PERFORM 210-SENMON-PARA-SET-SEC
      *    老人病棟
           WHEN    "07"
               PERFORM 210-ROJIN-PARA-SET-SEC
      *    有床診療所入院基本料
           WHEN    "08"
               PERFORM 210-SINRYO-PARA-SET-SEC
      *    有床診療所療養病床入院料
           WHEN    "09"
               PERFORM 210-SINRYORYOYO-PARA-SET-SEC
           END-EVALUATE
      *
           .
       200-SELKEY-SET-EXT.
          EXIT.
      *****************************************************************
      *    一般病棟
      *****************************************************************
       210-IPPAN-PARA-SET-SEC          SECTION.
      *
           MOVE    W20SUB01-I-BTUSBTKBN
                                   TO  NYUKHN-BTUSBTKBN
           MOVE    W20SUB01-I-HEIKINZAIKBN
                                   TO  NYUKHN-HEIKINZAIKBN
           MOVE    W20SUB01-I-KANGOHAICHIKBN
                                   TO  NYUKHN-KANGOHAICHIKBN
           MOVE    W20SUB01-I-KANGOHIRITUKBN
                                   TO  NYUKHN-KANGOHIRITUKBN
      *
           .
       200-IPPAN-PARA-SET-EXT.
          EXIT.
      *****************************************************************
      *    精神病棟
      *****************************************************************
       210-SEISIN-PARA-SET-SEC         SECTION.
      *
           MOVE    W20SUB01-I-BTUSBTKBN
                                   TO  NYUKHN-BTUSBTKBN
           MOVE    W20SUB01-I-HEIKINZAIKBN
                                   TO  NYUKHN-HEIKINZAIKBN
           MOVE    W20SUB01-I-KANGOHAICHIKBN
                                   TO  NYUKHN-KANGOHAICHIKBN
           MOVE    W20SUB01-I-KANGOHIRITUKBN
                                   TO  NYUKHN-KANGOHIRITUKBN
      *
           .
       210-SEISIN-PARA-SET-EXT.
          EXIT.
      *****************************************************************
      *    結核病棟
      *****************************************************************
       210-KEKKAKU-PARA-SET-SEC        SECTION.
      *
           MOVE    W20SUB01-I-BTUSBTKBN
                                   TO  NYUKHN-BTUSBTKBN
           MOVE    W20SUB01-I-HEIKINZAIKBN
                                   TO  NYUKHN-HEIKINZAIKBN
           MOVE    W20SUB01-I-KANGOHAICHIKBN
                                   TO  NYUKHN-KANGOHAICHIKBN
           MOVE    W20SUB01-I-KANGOHIRITUKBN
                                   TO  NYUKHN-KANGOHIRITUKBN
      *
           .
       210-KEKKAKU-PARA-SET-EXT.
          EXIT.
      *****************************************************************
      *    療養病棟
      *****************************************************************
       210-RYOYO-PARA-SET-SEC          SECTION.
      *
           MOVE    W20SUB01-I-BTUSBTKBN
                                   TO  NYUKHN-BTUSBTKBN
           MOVE    W20SUB01-I-KANGOHAICHIKBN
                                   TO  NYUKHN-KANGOHAICHIKBN
           MOVE    W20SUB01-I-KANGOHIRITUKBN
                                   TO  NYUKHN-KANGOHIRITUKBN
           MOVE    W20SUB01-I-KANGOHOJOHAICHIKBN
                                   TO  NYUKHN-KANGOHOJOHAICHIKBN
      *
           .
       210-RYOYO-PARA-SET-EXT.
          EXIT.
      *****************************************************************
      *    障害者施設
      *****************************************************************
       210-SYOGAI-PARA-SET-SEC         SECTION.
      *
           MOVE    W20SUB01-I-BTUSBTKBN
                                   TO  NYUKHN-BTUSBTKBN
           MOVE    W20SUB01-I-KANGOHAICHIKBN
                                   TO  NYUKHN-KANGOHAICHIKBN
           MOVE    W20SUB01-I-KANGOHIRITUKBN
                                   TO  NYUKHN-KANGOHIRITUKBN
      *
           .
       210-SYOGAI-PARA-SET-EXT.
          EXIT.
      *****************************************************************
      *    専門病院
      *****************************************************************
       210-SENMON-PARA-SET-SEC         SECTION.
      *
           MOVE    W20SUB01-I-BTUSBTKBN
                                   TO  NYUKHN-BTUSBTKBN
           MOVE    W20SUB01-I-HEIKINZAIKBN
                                   TO  NYUKHN-HEIKINZAIKBN
           MOVE    W20SUB01-I-KANGOHAICHIKBN
                                   TO  NYUKHN-KANGOHAICHIKBN
           MOVE    W20SUB01-I-KANGOHIRITUKBN
                                   TO  NYUKHN-KANGOHIRITUKBN
      *
           .
       210-SENMON-PARA-SET-EXT.
          EXIT.
      *****************************************************************
      *    老人病棟
      *****************************************************************
       210-ROJIN-PARA-SET-SEC          SECTION.
      *
           MOVE    W20SUB01-I-BTUSBTKBN
                                   TO  NYUKHN-BTUSBTKBN
           MOVE    W20SUB01-I-KANGOHAICHIKBN
                                   TO  NYUKHN-KANGOHAICHIKBN
           MOVE    W20SUB01-I-KANGOHIRITUKBN
                                   TO  NYUKHN-KANGOHIRITUKBN
           MOVE    W20SUB01-I-KANGOHOJOHAICHIKBN
                                   TO  NYUKHN-KANGOHOJOHAICHIKBN
      *
           .
       210-ROJIN-PARA-SET-EXT.
          EXIT.
      *****************************************************************
      *    有床診療所入院基本料
      *****************************************************************
       210-SINRYO-PARA-SET-SEC         SECTION.
      *
      *    IF    ( W20SUB01-I-KNGSISUKBN   =   "1" )
      *        MOVE    "3"         TO  NYUKHN-SSTKIJUNKBN
      *    END-IF
      *
           MOVE    W20SUB01-I-BTUSBTKBN
                                   TO  NYUKHN-BTUSBTKBN
           MOVE    W20SUB01-I-KANGOHAICHIKBN
                                   TO  NYUKHN-KANGOHAICHIKBN
           MOVE    W20SUB01-I-KANGOHOJOHAICHIKBN
                                   TO  NYUKHN-KANGOHOJOHAICHIKBN
      *
           .
       210-SINRYO-PARA-SET-EXT.
          EXIT.
      *****************************************************************
      *    有床診療所療養病床入院料
      *****************************************************************
       210-SINRYORYOYO-PARA-SET-SEC    SECTION.
      *
           MOVE    W20SUB01-I-BTUSBTKBN
                                   TO  NYUKHN-BTUSBTKBN
           MOVE    W20SUB01-I-KANGOHAICHIKBN
                                   TO  NYUKHN-KANGOHAICHIKBN
           MOVE    W20SUB01-I-KANGOHOJOHAICHIKBN
                                   TO  NYUKHN-KANGOHOJOHAICHIKBN
      *
           .
       210-SINRYORYOYO-PARA-SET-EXT.
          EXIT.
      *****************************************************************
      *    入院料算定マスタ検索処理
      *****************************************************************
       800-NYUKHN-SEL-SEC              SECTION.
      *
           MOVE    ZERO                TO  FLG-NYUKHN
      *
           MOVE    NYUINKHN-REC        TO  MCPDATA-REC
      *
      *    入院料算定マスタ検索
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    NOT =   ZERO )
                   MOVE    1           TO  FLG-NYUKHN
           ELSE
               MOVE    MCPDATA-REC TO  NYUINKHN-REC
      *        点数マスタより名称取得
               PERFORM 800-TENSU-SEL-SEC
               IF    ( FLG-TENSU   =   ZERO )
                   MOVE    TNS-NAME
                                   TO  WRK-TNS-NAME
               ELSE
                   MOVE    SPACE   TO  WRK-TNS-NAME
               END-IF
           END-IF
      *
      *    入院料算定マスタクローズ
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
      *
       800-NYUKHN-SEL-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索処理
      *****************************************************************
       800-TENSU-SEL-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-TENSU
      *
           INITIALIZE  TNS-TENSU-REC
      *
           MOVE    NYUKHN-KHNSRYCD
                                   TO  TNS-SRYCD
           MOVE    W20SUB01-I-KJNYMD
                                   TO  ORC-DBYMD
           MOVE    TNS-TENSU-REC   TO  MCPDATA-REC
      *
      *    点数マスタ検索
           MOVE    "TENSU-KEY"     TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    (  FLG-DBRC   NOT =   ZERO )
               MOVE    1           TO  FLG-TENSU
           ELSE
               MOVE    MCPDATA-REC TO  TNS-TENSU-REC
           END-IF
      *
      *    点数マスタクローズ
           MOVE    "TENSU-KEY"     TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
      *
       800-TENSU-SEL-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       900-TBL-SELECT-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           PERFORM 910-DB-SELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    WRK-DBPATH  TO  ORC-DBPATH
               PERFORM 910-DB-READ-SEC
               IF    ( MCP-RC          =   ZERO )
                   CONTINUE
               ELSE
                   MOVE    1       TO  FLG-DBRC
               END-IF
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル読込処理
      *****************************************************************
       900-TBL-READ-SEC                SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           PERFORM 910-DB-READ-SEC
           IF    ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-READ-EXT.
           EXIT.
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       900-TBL-CLOSE-SEC               SECTION.
      *
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           PERFORM 910-DB-CLOSE-SEC
      *
           .
       900-TBL-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       910-DB-SELECT-SEC               SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
      *
       910-DB-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DB-READ-SEC                 SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DB-READ-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DB-CLOSE-SEC                SECTION.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
      *
       910-DB-CLOSE-EXT.
           EXIT.
