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
       PROGRAM-ID.             ORCSPTID.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : 患者ＩＤ取得処理
      *  返却エラーコード  : 00:正常　10:パラメータ不正・対象データなし
      *                    : 02:システム管理（患者番号採番）読込エラー
      *  管理者            : 
      *  作成日付    作業者        記述
      *  XX.XX.XX    ＮＮＮ        新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者        日付      内容
      *  01.00.01    MCC-太田      01/05/22  患者番号ゼロ詰め処理
      *  01.00.02    MCC-多々納    01/11/27  自由構成区分の追加修正
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                    DIVISION.
      *FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-PTNUM           PIC 9(01).
           03  FLG-OK              PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
      *
      *----(01.00.01) LINE ADD START --------------------------------
      *    ワーク領域
       01  WRK-AREA.
           03  WRK-END             PIC 9(02).
           03  WRK-RENKETA         PIC 9(02).
           03  WRK-PTNUM           PIC X(20).
           03  WRK-ST              PIC 9(02).
      *----(01.00.01) LINE ADD END   --------------------------------
      *
      *    一時領域
      *    患者番号変換マスタ
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *****COPY    "MCPAREA.INC".
           COPY    "MCPAREA".
      *
      *01  MCPDATA-REC                 PIC X(5000).
           COPY    "MCPDATA.INC".
      *     
           COPY    "CPORCMCP.INC".  
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPORCSPTID.INC".
      *
      *----(01.00.01) LINE ADD END   --------------------------------
           01  WRK-1009-TBL.
      *患者番号構成区分
               03  WRK-1009-PTNUMKSIKBN             PIC X(01).
      *    自由構成桁数
               03  WRK-1009-JIYKSI.
      *    自由構成区分
                   05  WRK-1009-JIYKSIKBN           PIC X(01).
      *    自由構成桁数
                   05  WRK-1009-JIYKSIKETA          PIC 9(02).
      *標準構成区分
               03  WRK-1009-HJNKSI.
      *    標準構成区分
                   05  WRK-1009-HJNKSIKBN           PIC X(01).
      *    標準構成年区分
                   05  WRK-1009-HJNKSINENKBN        PIC X(01).
      *    標準構成連番初期化区分
                   05  WRK-1009-HJNKSIRENNUMKBN     PIC X(01).
      *    標準構成連番号桁数
                   05  WRK-1009-HJNKSIRENNUMKETA    PIC 9(02).
      *拡張構成区分
               03  WRK-1009-KKCYKSI.
      *    拡張構成区分
                   05  WRK-1009-KKCKSIKBN           PIC X(01).
      *    拡張構成前桁数
                   05  WRK-1009-KKCKSIMAEKETA       PIC 9(02).
      *    拡張構成連番号桁数
                   05  WRK-1009-KKCKSIRENNUMKETA    PIC 9(02).
      *    拡張構成後桁数
                   05  WRK-1009-KKCKSIATOKETA       PIC 9(02).
      *----(01.00.01) LINE ADD END   --------------------------------
      *
       PROCEDURE                    DIVISION    USING
      *----(01.00.01) LINE MOD START -------------------------------
      *     ORCSPTIDAREA.
           ORCSPTIDAREA
           WRK-1009-TBL.
      *----(01.00.01) LINE MOD END   -------------------------------
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                 SECTION.
      *
           MOVE    ZERO                TO  SPTID-RC
           IF      SPTID-HOSPID         =   ZERO
               MOVE    1               TO  SPTID-HOSPID
           END-IF
      *
           IF     (SPTID-PTNUM      NOT =   SPACE )  AND
                  (SPTID-PTID       NOT =   ZERO  )
               MOVE    1                   TO  SPTID-RC
           ELSE
               IF      SPTID-PTNUM      NOT =   SPACE
                   PERFORM 100-PTID-SET-SEC
               ELSE
                   PERFORM 110-PTNUM-SET-SEC
               END-IF
           END-IF
      *
           EXIT PROGRAM
           .
      *
      *****************************************************************
      *    患者ＩＤ検索処理
      *****************************************************************
       100-PTID-SET-SEC                SECTION.
      *
      *----(01.00.01) LINE ADD START --------------------------------
           PERFORM 120-KETA-CNT-SEC
           IF  SPTID-RC            NOT =   ZERO
               GO  TO                  100-PTID-SET-EXT
           END-IF
      *----(01.00.01) LINE ADD END   --------------------------------
      *
           MOVE    ZERO                TO  FLG-OK
           MOVE    SPTID-HOSPID        TO  PTNUM-HOSPID
           MOVE    SPTID-PTNUM         TO  PTNUM-PTNUM
      *
           MOVE    PTNUM-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTNUM-KEY2"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-PTNUM
           ELSE
               MOVE    2                   TO  FLG-PTNUM
               INITIALIZE                  PTNUM-REC
           END-IF
           PERFORM
               UNTIL      (FLG-PTNUM   NOT =   ZERO )  OR
                          (FLG-OK          =   1    )
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTNUM-KEY2"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  PTNUM-REC
                   MOVE    ZERO                TO  FLG-PTNUM
      *
                   IF      PTNUM-PTNUM         =   SPTID-PTNUM
                       MOVE    1               TO  FLG-OK
                   END-IF
               ELSE
                   MOVE    1                   TO  FLG-PTNUM
                   INITIALIZE                  PTNUM-REC
               END-IF
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTNUM-KEY2"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           IF      FLG-OK              =   1
               MOVE    PTNUM-PTID      TO  SPTID-PTID
           ELSE
               MOVE    FLG-PTNUM       TO  SPTID-RC
      *----(01.00.01) LINE ADD START --------------------------------
      ****     MOVE    WRK-PTNUM       TO  SPTID-PTNUM
      *----(01.00.01) LINE ADD END   --------------------------------
           END-IF
      *
           .
       100-PTID-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号検索処理
      *****************************************************************
       110-PTNUM-SET-SEC                SECTION.
      *
           MOVE    SPTID-HOSPID         TO  PTNUM-HOSPID
           MOVE    SPTID-PTID           TO  PTNUM-PTID
      *
           MOVE    PTNUM-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  PTNUM-REC
                   MOVE    ZERO                TO  FLG-PTNUM
               ELSE
                   MOVE    1                   TO  FLG-PTNUM
                   INITIALIZE                  PTNUM-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTNUM
               INITIALIZE                  PTNUM-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           IF      FLG-PTNUM           =   ZERO
               MOVE    PTNUM-PTNUM     TO  SPTID-PTNUM
           ELSE
               MOVE    2               TO  SPTID-RC
           END-IF
      *
           .
       110-PTNUM-SET-EXT.
           EXIT.
      *
      *----(01.00.01) LINE ADD START --------------------------------
      *****************************************************************
      *    患者ＩＤ検索処理
      *****************************************************************
       120-KETA-CNT-SEC                SECTION.
      *
           INITIALIZE                  WRK-AREA
           MOVE    SPTID-PTNUM         TO  WRK-PTNUM
      *
      *    標準構成時のみ変換
      *****IF  WRK-1009-PTNUMKSIKBN    =   "1"  OR  "3"
           IF  WRK-1009-PTNUMKSIKBN    =   "3"
               GO  TO                  120-KETA-CNT-EXT
           END-IF
      *    自由構成で数字型の時変換
           IF  (WRK-1009-PTNUMKSIKBN   =   "1"  )  AND
               (WRK-1009-JIYKSIKBN NOT =   "2"  )
               GO  TO                  120-KETA-CNT-EXT
           END-IF
      *
      *    パラメータ（IN）の患者番号桁数をカウント
           PERFORM     VARYING   IDX   FROM    1   BY  1
                       UNTIL    (IDX                    >   20   )
                       OR       (SPTID-PTNUM(IDX:1)     =   SPACE)
               MOVE    IDX             TO  WRK-END
           END-PERFORM
      *
      *    自由構成の桁数編集
           IF  WRK-1009-PTNUMKSIKBN    =   "1"
               MOVE    WRK-1009-JIYKSIKETA     TO  WRK-RENKETA
           ELSE
      *    標準構成の桁数
      *    システム管理マスタで設定された桁数をカウント
               MOVE    WRK-1009-HJNKSIRENNUMKETA   TO  WRK-RENKETA
               IF  WRK-1009-HJNKSIKBN      =   "1"  OR  "2"
                   EVALUATE    WRK-1009-HJNKSINENKBN
                   WHEN    "1"
                       ADD     3           TO  WRK-RENKETA
                   WHEN    "2"
                       ADD     4           TO  WRK-RENKETA
                   END-EVALUATE
               END-IF
               IF  WRK-1009-HJNKSIKBN      =   "1"  OR  "3"
                   ADD     1               TO  WRK-RENKETA
               END-IF
           END-IF
      *
      *    パラメータ（IN）の患者番号桁数が設定された桁数を超えた場合
           IF  WRK-END                 >   WRK-RENKETA
               MOVE    1               TO  SPTID-RC
               GO      TO              120-KETA-CNT-EXT
           END-IF
      *    開始位置算出
           COMPUTE     WRK-ST          =   WRK-RENKETA
                                       -   WRK-END   +   1
           IF  ( WRK-ST                =   ZERO )  OR
               ( WRK-ST                >   20   )
               MOVE    1               TO  SPTID-RC
               GO      TO              120-KETA-CNT-EXT
           END-IF
      *    検索するため、患者番号をゼロ詰編集
           MOVE    SPACE               TO  SPTID-PTNUM
           MOVE    ZERO                TO  SPTID-PTNUM (1:WRK-RENKETA)
           MOVE    WRK-PTNUM (1:WRK-END)
                                       TO  SPTID-PTNUM (WRK-ST:)
      *
           .
       120-KETA-CNT-EXT.
           EXIT.
      *
      *----(01.00.01) LINE ADD END   --------------------------------
      *
