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
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCGJ023.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 会計カード
      *  コンポーネント名  : カルテメッセージ（Ｊ０２３）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/02/05    MCC−多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     NACL-多々納  02/08/06  アフターケア対応追加
      * 01.00.02     NACL-多々納  02/08/18  自賠責追加
      * 01.00.03     NACL-多々納  03/03/06  入外区分追加
      *****************************************************************
      *
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
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    会計照会共通パラメタ
           COPY    "J01COMMON-SPA".
      *
      *    画面スパ領域
           COPY    "J02SCR-SPA".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01).
           03  FLG-RECECOM         PIC 9(01).
           03  FLG-EXAMPLE         PIC 9(01).
           03  FLG-JYURRK          PIC 9(01).
           03  FLG-PTRSIINF        PIC 9(01).
      *
           03  FLG-HKNCOMBICHK     PIC 9(01).
           03  FLG-OK              PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD            PIC X(08).
           03  WRK-HKNCOMBI        PIC 9(04).
           03  WRK-HKNCOMBIMEI     PIC X(100).
           03  WRK-HKNKBN-MEI      PIC X(02).
      *
           03  WRK-SRYKA           PIC X(02).
           03  WRK-SRYKAMEI        PIC X(20).
      *
           03  WRK-SELNUM          PIC 9(03).
           03  WRK-SELNUM2         PIC 9(03).
      *
           03  WRK-ZZZ             PIC ZZZ.
           03  WRK-ZZ              PIC ZZ.
      *
           03  WRK-DBPATH          PIC X(20).
      *
           03  WRK-JIDMSG          PIC X(80).
      *
      *    保険組合せワーク
           03  WRK-J023-HKNCOMB-COMB.
               05  WRK-J023-HKN-LIST    OCCURS  10.
                   07  WRK-J023-THKNCOMBINUM    PIC X(04).
                   07  WRK-J023-THKNCOMBY1      PIC X(01).
                   07  WRK-J023-THKNCOMBIMEI    PIC X(100).
                   07  WRK-J023-FLG             PIC X(01).
                   07  WRK-J023-RSI-HKNKBN      PIC X(01).
                05  WRK-J023-HKNMAX              PIC 9(04).
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
      *
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    レセプトコメント
       01  RECECOM-REC.
           COPY    "CPRECECOM.INC".
      *
      *    雛形
       01  EXAMPLE-REC.
           COPY    "CPEXAMPLE.INC".
      *
      *    受診履歴
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *    患者労災保険情報
       01  PTRSIINF-REC.
           COPY    "CPPTRSIINF.INC".
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    ＤＢ検索
      *01  MCPDATA-REC                 PIC X(5000).
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "J02.INC".
           COPY    "J021.INC".
           COPY    "J022.INC".
           COPY    "J023.INC".
           COPY    "J024.INC".
           COPY    "J03.INC".
           COPY    "J04.INC".
           COPY    "J041.INC".
           COPY    "J042.INC".
           COPY    "J98.INC".
           COPY    "J99.INC".
           COPY    "JERR.INC".
           COPY    "JID1.INC".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA.
           MOVE    SPA-FREE        TO  SPA-J02
           MOVE    SPA-WORK        TO  SPA-J01KYOUTU
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN     "PUTG"           ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-J01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-J02         TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
      *    INITIALIZE                  CNT-AREA
      *    INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "JERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *
      *        初期画面編集
               PERFORM 300-SCREEN-SEC
               IF      FLG-END         =   1
                   GO      TO      100-INIT-EXT
               END-IF
      *
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE   "NEW"                TO  MCP-PUTTYPE.
           MOVE   "J023"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
      *
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
      *
           EVALUATE    SPA-MOTOPG(1:4)
      *            文例画面より
               WHEN    "J024"
                   IF      SPA-J024-SELNUM     NOT =   ZERO
                       MOVE    1                   TO  SPA-J023-CUR
                       MOVE    SPACE               TO  SPA-JIDCD
                       GO      TO      300-SCREEN-EXT
                   END-IF
                   MOVE    1                   TO  SPA-J023-CUR
                   GO      TO      300-SCREEN-EXT
      *            確認画面より
               WHEN    "JID1"
                   PERFORM 3003-JID1-SET-SEC
                   MOVE    SPACE           TO  SPA-JIDCD
                   GO      TO      300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM                     310-SPA-SET-SEC
      *
           MOVE    1                   TO  SPA-J023-CUR
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *     確認画面よりの処理
      *****************************************************************
       3003-JID1-SET-SEC                  SECTION.
      *
           EVALUATE    SPA-JIDCD
               WHEN    "0101"
               WHEN    "0105"
      *            コメント登録の確認
                   IF      SPA-JID1-FLG        =   "OK"
                       PERFORM 2121-TOUROKU-SYORI-SEC
                   ELSE
                       MOVE    1                   TO  SPA-J023-CUR
                   END-IF
               WHEN    "0104"
      *            コメント削除の確認
                   IF      SPA-JID1-FLG        =   "OK"
                       PERFORM 2401-COMMENT-DELSYORI-SEC
                   ELSE
                       MOVE    1                   TO  SPA-J023-CUR
                   END-IF
               WHEN    "0102"
               WHEN    "0103"
               WHEN    "0106"
      *            文例の確認
                   IF      SPA-JID1-FLG        =   "OK"
                       PERFORM 2801-BUNREI-SYORI-SEC
                   ELSE
                       MOVE    1                   TO  SPA-J023-CUR
                   END-IF
      *
           END-EVALUATE
           .
       3003-JID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       310-SPA-SET-SEC                  SECTION.
      *
           INITIALIZE                  SPA-J023-AREA
      *
           MOVE    SPA-NAI-SRYYM       TO  SPA-J023-SRYYMS
           MOVE    SPA-GMN-SRYYM       TO  SPA-J023-SRYYM
           IF      SPA-GMN-PTID        =   ZERO
               MOVE    2               TO  SPA-J023-SYORI
               GO      TO      310-SPA-SET-EXT
           END-IF
      *
      *     保険組合せ
            PERFORM 3101-HKNCOMBI-HEN-SEC
      *
      *     診療科
            PERFORM 3102-SRYKA-HEN-SEC
      *
      *     コメント編集編集
            PERFORM 3103-RECECOM-HEN-SEC
      *
      *     コメント初期編集
      ******PERFORM 314-RECECOM-SYOKI-SEC
      *
      *     初期編集
            PERFORM 314-SYOKI-SEC
      *
      *
           .
       310-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せ名称編集処理
      *****************************************************************
       3101-HKNCOMBI-HEN-SEC        SECTION.
      *
           INITIALIZE                  SPA-J023-HKNCOMB-COMB
           MOVE    ZERO                TO  SPA-J023-HKNMAX
           MOVE    ZERO                TO  FLG-HKNCOMBICHK
      *
      *    保険組合マスター編集
           MOVE    SPACE               TO  HKNCOMBI-REC
           INITIALIZE                  HKNCOMBI-REC
           MOVE    SPA-HOSPID          TO  COMB-HOSPID
           MOVE    SPA-GMN-PTID        TO  COMB-PTID
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNCOMBI-KEY2"     TO  ORC-DBPATH
               PERFORM 910-HKNCOMBI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-HKNCOMBI
               INITIALIZE                  HKNCOMBI-REC
           END-IF
           PERFORM
                   UNTIL      (FLG-HKNCOMBI        =   1      )
      *
      *        対象の保険組合せのみ編集
               MOVE    ZERO                TO  FLG-HKNCOMBICHK
               IF      COMB-DELKBN         =   "1"
                   CONTINUE
               ELSE
                   IF      (SPA-J023-SRYYMS >=  COMB-TEKSTYMD(1:6)) AND
                           (SPA-J023-SRYYMS <=  COMB-TEKEDYMD(1:6))
                       MOVE    1                   TO  FLG-HKNCOMBICHK
                   END-IF
               END-IF
      *
               IF      FLG-HKNCOMBICHK    =    1
                   ADD     1                   TO  SPA-J023-HKNMAX
                   MOVE    COMB-HKNCOMBINUM    TO  SPA-J023-THKNCOMBINUM
                                                  (SPA-J023-HKNMAX)
                   PERFORM 31011-HKNCOMBI-HEN-SEC
                   MOVE    WRK-HKNCOMBIMEI     TO  SPA-J023-THKNCOMBIMEI
                                                  (SPA-J023-HKNMAX)
               END-IF
      *
               MOVE    "HKNCOMBI-KEY2"     TO  ORC-DBPATH
               PERFORM 910-HKNCOMBI-READ-SEC
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "HKNCOMBI-KEY2"     TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
      *
           .
       3101-HKNCOMBI-HEN-EXT.
      *
           EXIT.
      *
      *****************************************************************
      *    保険組合せ名称編集処理
      *****************************************************************
       31011-HKNCOMBI-HEN-SEC             SECTION.
      *
           MOVE    SPACE               TO  WRK-HKNCOMBIMEI
      *
           STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                   " "                     DELIMITED  BY  SIZE
                   COMB-KOH1-TANSEIDONAME  DELIMITED  BY  SPACE
                   " "                     DELIMITED  BY  SIZE
                   COMB-KOH2-TANSEIDONAME  DELIMITED  BY  SPACE
                   " "                     DELIMITED  BY  SIZE
                   COMB-KOH3-TANSEIDONAME  DELIMITED  BY  SPACE
                   " "                     DELIMITED  BY  SIZE
                   COMB-KOH4-TANSEIDONAME  DELIMITED  BY  SPACE
                         INTO              WRK-HKNCOMBIMEI
           END-STRING
      *    主保険がない時
           IF      COMB-SYU-TANSEIDONAME   =   SPACE
               MOVE    SPACE               TO  WRK-HKNCOMBIMEI
               STRING  COMB-KOH1-TANSEIDONAME  DELIMITED  BY  SPACE
                       " "                     DELIMITED  BY  SIZE
                       COMB-KOH2-TANSEIDONAME  DELIMITED  BY  SPACE
                       " "                     DELIMITED  BY  SIZE
                       COMB-KOH3-TANSEIDONAME  DELIMITED  BY  SPACE
                       " "                     DELIMITED  BY  SIZE
                       COMB-KOH4-TANSEIDONAME  DELIMITED  BY  SPACE
                         INTO              WRK-HKNCOMBIMEI
               END-STRING
           END-IF
      *
      *    労災の時、コメントの追加
           IF      COMB-HKNNUM         =   "971"  OR  "973"
      *        患者保険情報検索
               INITIALIZE                      PTRSIINF-REC
               MOVE    SPA-HOSPID          TO  PTRSI-HOSPID
               MOVE    SPA-GMN-PTID        TO  PTRSI-PTID
               MOVE    COMB-HKNID          TO  PTRSI-HKNID
               MOVE    PTRSIINF-REC        TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    "PTRSIINF-KEY"     TO  ORC-DBPATH
                   PERFORM 993-PTRSIINF-NEXT-SEC
               ELSE
                   INITIALIZE                      PTRSIINF-REC
                   MOVE    1                   TO  FLG-PTRSIINF
               END-IF
               MOVE    SPACE               TO  WRK-HKNKBN-MEI
               EVALUATE    PTRSI-HKNKBN
                   WHEN    "1"
                       MOVE    "短"        TO  WRK-HKNKBN-MEI
                   WHEN    "2"
                       MOVE    "傷"        TO  WRK-HKNKBN-MEI
                   WHEN    "3"
                       MOVE    "ア"        TO  WRK-HKNKBN-MEI
               END-EVALUATE
               IF      PTRSI-COMMENT       =   SPACE
                   MOVE    SPACE               TO  WRK-HKNCOMBIMEI
                   STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                           " "                     DELIMITED  BY  SIZE
                           WRK-HKNKBN-MEI          DELIMITED  BY  SPACE
                           INTO              WRK-HKNCOMBIMEI
                   END-STRING
               ELSE
                   MOVE    SPACE               TO  WRK-HKNCOMBIMEI
                   STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                           " "                     DELIMITED  BY  SIZE
                           WRK-HKNKBN-MEI          DELIMITED  BY  SPACE
                           "（"                    DELIMITED  BY  SIZE
                           PTRSI-COMMENT           DELIMITED  BY  SPACE
                           "）"                    DELIMITED  BY  SIZE
                           INTO              WRK-HKNCOMBIMEI
                   END-STRING
               END-IF
      *
               MOVE    PTRSI-HKNKBN        TO  SPA-J023-RSI-THKNKBN
                                                      (SPA-J023-HKNMAX)
           END-IF
      *
           .
       31011-HKNCOMBI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科編集処理
      *****************************************************************
       3102-SRYKA-HEN-SEC        SECTION.
      *
           INITIALIZE                   SPA-J023-SRYKA-AREA
      *
      *    最初に全科指定を挿入
           ADD     1                   TO  SPA-J023-SRYKAMAX
           MOVE    "00"                TO  SPA-J023-SRYKAL
                                                  (SPA-J023-SRYKAMAX)
           MOVE    "全科指定"          TO  SPA-J023-SRYKAMEIL
                                                  (SPA-J023-SRYKAMAX)
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   41  )  OR
                              (SPA-GMN-SRYKAL (IDX)
                                           =   SPACE )  OR
                              (SPA-J023-SRYKAMAX   =   41 )
               IF      SPA-GMN-SRYKAL (IDX)  =   "00"
                   CONTINUE
               ELSE
                   ADD     1                   TO  SPA-J023-SRYKAMAX
                   MOVE    SPA-GMN-SRYKAL (IDX)
                                           TO  SPA-J023-SRYKAL
                                                  (SPA-J023-SRYKAMAX)
                   MOVE    SPA-GMN-SRYKAMEIL (IDX)
                                           TO  SPA-J023-SRYKAMEIL
                                                  (SPA-J023-SRYKAMAX)
               END-IF
           END-PERFORM
      *
           .
       3102-SRYKA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメント編集処理
      *****************************************************************
        3103-RECECOM-HEN-SEC        SECTION.
      *
           INITIALIZE                  SPA-J023-RECECOMLIST-G
      *
           MOVE    SPACE               TO  RECECOM-REC
           INITIALIZE                  RECECOM-REC
           MOVE    SPA-HOSPID          TO  RECECOM-HOSPID
           MOVE    SPA-GMN-PTID        TO  RECECOM-PTID
           MOVE    SPA-GMN-NYUGAIKBN   TO  RECECOM-NYUGAIKBN
      *
           MOVE    RECECOM-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "RECECOM-KEY2"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "RECECOM-KEY2"     TO  ORC-DBPATH
               PERFORM 920-RECECOM-READ-SEC
           ELSE
               MOVE    1               TO  FLG-RECECOM
               INITIALIZE                  RECECOM-REC
           END-IF
           MOVE    ZERO                TO  IDX
           PERFORM
                   UNTIL       FLG-RECECOM        =   1
               ADD     1                   TO  IDX
               MOVE    IDX                 TO  SPA-J023-RECE-MAX
               MOVE    IDX                 TO  SPA-J023-TRENNUM (IDX)
               MOVE    RECECOM-SRYKA       TO  SPA-J023-NSRYKA  (IDX)
               MOVE    RECECOM-SRYYM       TO  SPA-J023-NSRYYM  (IDX)
               MOVE    RECECOM-HKNCOMBI    TO  SPA-J023-NHKNCOMBI(IDX)
               MOVE    RECECOM-COMMENT     TO  SPA-J023-TCOMMENT(IDX)
      *        診療年月
               MOVE    RECECOM-SRYYM       TO  WRK-SYMD(1:6)
               MOVE    "01"                TO  WRK-SYMD(7:2)
               PERFORM 800-SEIWA-HEN-SEC
               MOVE    WRK-HENYMDG (1:6)   TO  SPA-J023-TSRYYM (IDX)
      *        診療科
               MOVE    RECECOM-SRYKA       TO  WRK-SRYKA
               PERFORM 810-SRYKA-SET-SEC
               MOVE    WRK-SRYKAMEI        TO  SPA-J023-TSRYKA (IDX)
      *        保険組合せ番号
               MOVE    RECECOM-HKNCOMBI    TO  WRK-HKNCOMBI
               PERFORM 820-HKNCOMBI-SET-SEC
               MOVE    WRK-HKNCOMBIMEI     TO  SPA-J023-THKNCOMBI(IDX)
      *        診療日
               IF      RECECOM-SRYDD       =   ZERO
                   MOVE    SPACE               TO  SPA-J023-TSRYDD (IDX)
               ELSE
                   MOVE    RECECOM-SRYDD       TO  SPA-J023-TSRYDD (IDX)
               END-IF
      *
               MOVE    "RECECOM-KEY2"      TO  ORC-DBPATH
               PERFORM 920-RECECOM-READ-SEC
           END-PERFORM
      *
           MOVE    SPACE               TO  SPA-J023-COMMENT
           MOVE    ZERO                TO  SPA-J023-SELNUM
           MOVE    ZERO                TO  SPA-J023-BUNNUM
           MOVE    SPACE               TO  SPA-J023-HKNCOMBI-G
           MOVE    ZERO                TO  SPA-J023-JYURRKNUM
      *
           .
       3103-RECECOM-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期編集処理
      *****************************************************************
       314-SYOKI-SEC             SECTION.
      *
           INITIALIZE                  SPA-J023-JYURRK-LIST
           MOVE    ZERO                TO  SPA-J023-JYURRKNUM
      *
      *    保険組合せの再編集
           INITIALIZE                  WRK-J023-HKNCOMB-COMB
           MOVE    ZERO                TO  WRK-J023-HKNMAX
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >    SPA-J023-HKNMAX
               MOVE    SPA-J023-THKNCOMBINUM(IDX)
                                      TO  WRK-J023-THKNCOMBINUM(IDX)
               MOVE    SPA-J023-THKNCOMBIMEI(IDX)
                                      TO  WRK-J023-THKNCOMBIMEI(IDX)
               MOVE    SPA-J023-RSI-THKNKBN  (IDX)
                                      TO  WRK-J023-RSI-HKNKBN  (IDX)
           END-PERFORM
           MOVE    SPA-J023-HKNMAX     TO  WRK-J023-HKNMAX
      *
      *    受診歴を検索する  医療機関、患者ＩＤ
           INITIALIZE                  JYURRK-REC
           MOVE    SPA-HOSPID          TO  JYURRK-HOSPID
           MOVE    SPA-GMN-PTID        TO  JYURRK-PTID
           MOVE    SPA-NYUGAIKBN       TO  JYURRK-NYUGAIKBN
           MOVE    SPA-J023-SRYYMS     TO  JYURRK-SRYYMD(1:6)
           MOVE    "01"                TO  JYURRK-SRYYMD(7:2)
           MOVE    SPA-J023-SRYYMS     TO  JYURRK-UPSRYYMD(1:6)
           MOVE    "31"                TO  JYURRK-UPSRYYMD(7:2)
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "JYURRK-KEY13"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "JYURRK-KEY13"      TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           MOVE    ZERO                TO  WRK-HKNCOMBI
           MOVE    SPACE               TO  WRK-SRYKA
           PERFORM
               UNTIL    FLG-JYURRK     =   1
      *
               PERFORM VARYING     IDX     FROM    1   BY  1
                       UNTIL       IDX     >   WRK-J023-HKNMAX
                   IF      JYURRK-HKNCOMBINUM
                                       =   WRK-J023-THKNCOMBINUM(IDX)
                       MOVE    "1"             TO  WRK-J023-FLG (IDX)
                       MOVE    WRK-J023-HKNMAX TO  IDX
                   END-IF
               END-PERFORM
      *
               MOVE    "JYURRK-KEY13"    TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           END-PERFORM
      *
      *    受診のあった保険組合せのみ表示する
           INITIALIZE                  SPA-J023-HKNCOMB-COMB
           MOVE    ZERO                TO  SPA-J023-HKNMAX
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >    10
               IF      WRK-J023-FLG  (IDX)  =   "1"
                   ADD     1                TO  SPA-J023-HKNMAX
                   MOVE    WRK-J023-THKNCOMBINUM(IDX)
                                      TO  SPA-J023-THKNCOMBINUM
                                                (SPA-J023-HKNMAX)
                   MOVE    WRK-J023-THKNCOMBIMEI(IDX)
                                      TO  SPA-J023-THKNCOMBIMEI
                                                (SPA-J023-HKNMAX)
                   MOVE    WRK-J023-RSI-HKNKBN  (IDX)
                                      TO  SPA-J023-RSI-THKNKBN
                                                (SPA-J023-HKNMAX)
               END-IF
           END-PERFORM
      *
      *    初期編集
           MOVE    SPA-J023-SRYKA-LIST(01)
                                       TO  SPA-J023-SRYKA-G
           MOVE    SPA-J023-HKN-LIST(01)
                                       TO  SPA-J023-HKNCOMBI-G
      *    労災保険区分がアフターケアの時、履歴日を表示する
           MOVE    SPA-J023-RSI-THKNKBN (01)
                                       TO  SPA-J023-RSI-HKNKBN
           IF      SPA-J023-RSI-HKNKBN =   "3"
               PERFORM 31401-AFTER-JYURRK-SEC
           END-IF
      *
           .
       314-SYOKI-EXT.
           EXIT.
      *
      *****************************************************************
      *    労災保険区分がアフターケアの時、履歴日編集処理
      *****************************************************************
       31401-AFTER-JYURRK-SEC          SECTION.
      *
      *
      *    受診歴を検索する  医療機関、患者ＩＤ
           INITIALIZE                  JYURRK-REC
           MOVE    SPA-HOSPID          TO  JYURRK-HOSPID
           MOVE    SPA-GMN-PTID        TO  JYURRK-PTID
           MOVE    SPA-NYUGAIKBN       TO  JYURRK-NYUGAIKBN
           MOVE    SPA-J023-SRYYMS     TO  JYURRK-SRYYMD(1:6)
           MOVE    "01"                TO  JYURRK-SRYYMD(7:2)
           MOVE    SPA-J023-SRYYMS     TO  JYURRK-UPSRYYMD(1:6)
           MOVE    "31"                TO  JYURRK-UPSRYYMD(7:2)
           MOVE    SPA-J023-HKNCOMBINUM
                                       TO  JYURRK-HKNCOMBINUM
           IF      SPA-J023-SRYKA      =   "00"
               MOVE    "JYURRK-KEY17"      TO  WRK-DBPATH
           ELSE
               MOVE    "JYURRK-KEY18"      TO  WRK-DBPATH
           END-IF
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-DBPATH          TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           INITIALIZE                  SPA-J023-JYURRK-LIST
           PERFORM
               UNTIL    FLG-JYURRK     =   1
               PERFORM VARYING     IDY     FROM    1   BY  1
                       UNTIL       IDY     >   10
                   IF      SPA-J023-JYURRKYMD (IDY)
                                          =    JYURRK-SRYYMD
                       MOVE    10              TO  IDY
                   ELSE
                       IF      SPA-J023-JYURRKYMD (IDY)  =   SPACE
                           MOVE    JYURRK-SRYYMD   TO
                                               SPA-J023-JYURRKYMD(IDY)
                           MOVE    JYURRK-SRYYMD   TO  WRK-SYMD
                           PERFORM 800-SEIWA-HEN-SEC
                           MOVE    WRK-HENYMDG     TO
                                               SPA-J023-JYURRKYMDW(IDY)
                           MOVE    10              TO  IDY
                       END-IF
                   END-IF
               END-PERFORM
      *
               MOVE    WRK-DBPATH          TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           END-PERFORM
      *
           MOVE    ZERO                TO  SPA-J023-RRKMAX
           PERFORM VARYING     IDY     FROM    1   BY  1
                   UNTIL       IDY     >   10
               IF      SPA-J023-JYURRKYMD (IDY)    NOT =   SPACE
                   MOVE    IDY        TO  SPA-J023-TRRKNUM (IDY)
                   MOVE    IDY        TO  SPA-J023-RRKMAX
               END-IF
           END-PERFORM
      *
           .
       31401-AFTER-JYURRK-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメント初期編集処理
      *****************************************************************
       314-RECECOM-SYOKI-SEC             SECTION.
      *
      *    初期表示
           IF     SPA-J023-RECE-MAX        >   ZERO
               IF     (SPA-J023-NSRYYM (01)    =   SPA-NAI-SRYYM ) AND
                      (SPA-J023-NSRYKA (01)    =   "00"  OR
                                                   SPA-J01-SRYKA )
      *            当月分が既に登録済みの時
                   PERFORM VARYING     IDY     FROM    1   BY  1
                           UNTIL       IDY     >   SPA-J023-SRYKAMAX
                       IF      SPA-J023-NSRYKA (01)
                                               =   SPA-J023-SRYKAL
                                                                 (IDY)
                           MOVE    SPA-J023-SRYKA-LIST (IDY)
                                                   TO  SPA-J023-SRYKA-G
                           MOVE    SPA-J023-SRYKAMAX
                                                   TO  IDY
                       END-IF
                   END-PERFORM
      *
                   PERFORM VARYING     IDY     FROM    1   BY  1
                           UNTIL       IDY     >   SPA-J023-HKNMAX
                       IF      SPA-J023-NHKNCOMBI (01)
                                               =   SPA-J023-THKNCOMBINUM
                                                                 (IDY)
                           MOVE    SPA-J023-HKN-LIST(IDY)
                                               TO  SPA-J023-HKNCOMBI-G
                           MOVE    SPA-J023-HKNMAX
                                               TO  IDY
                       END-IF
                   END-PERFORM
      *
                   MOVE    SPA-J023-TCOMMENT (01)  TO  SPA-J023-COMMENT
               ELSE
                   MOVE    SPACE               TO  SPA-J023-COMMENT
               END-IF
           ELSE
               MOVE    SPACE               TO  SPA-J023-COMMENT
           END-IF
      *
           IF      SPA-J023-COMMENT        =   SPACE
               MOVE    SPA-J023-SRYKA-LIST(01)
                                           TO  SPA-J023-SRYKA-G
      *        当月分が未登録の時、当月使用している保険と組合せ
               PERFORM 3141-JYURRK-CHK-SEC
      *
               PERFORM VARYING     IDY     FROM    1   BY  1
                       UNTIL       IDY     >   SPA-J023-HKNMAX
                   IF      WRK-HKNCOMBI(1:4)
                                           =   SPA-J023-THKNCOMBINUM
                                                                 (IDY)
                       MOVE    SPA-J023-HKN-LIST(IDY)
                                               TO  SPA-J023-HKNCOMBI-G
                       MOVE    SPA-J023-HKNMAX     TO  IDY
                   END-IF
               END-PERFORM
               IF      WRK-HKNCOMBI        =   ZERO
                   MOVE    SPA-J023-HKN-LIST(01)
                                           TO  SPA-J023-HKNCOMBI-G
               END-IF
           END-IF
      *
           .
       314-RECECOM-SYOKI-EXT.
           EXIT.
      *
      *****************************************************************
      *   受診履歴より診療科決定処理
      *****************************************************************
       3141-JYURRK-CHK-SEC             SECTION.
      *
      *    受診歴を検索する  医療機関、患者ＩＤ
           INITIALIZE                  JYURRK-REC
           MOVE    SPA-HOSPID          TO  JYURRK-HOSPID
           MOVE    SPA-GMN-PTID        TO  JYURRK-PTID
           MOVE    SPA-NYUGAIKBN       TO  JYURRK-NYUGAIKBN
           MOVE    SPA-J023-SRYYMS     TO  JYURRK-SRYYMD(1:6)
           MOVE    "01"                TO  JYURRK-SRYYMD(7:2)
           MOVE    SPA-J023-SRYYMS     TO  JYURRK-UPSRYYMD(1:6)
           MOVE    "31"                TO  JYURRK-UPSRYYMD(7:2)
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "JYURRK-KEY13"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "JYURRK-KEY13"      TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           MOVE    ZERO                TO  WRK-HKNCOMBI
           MOVE    SPACE               TO  WRK-SRYKA
           PERFORM
               UNTIL    FLG-JYURRK     =   1
               MOVE    JYURRK-HKNCOMBINUM  TO  WRK-HKNCOMBI
               MOVE    JYURRK-SRYKA        TO  WRK-SRYKA
      *
               MOVE    "JYURRK-KEY13"    TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           END-PERFORM
      *
      *
           .
       3141-JYURRK-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科名編集処理
      *****************************************************************
       810-SRYKA-SET-SEC             SECTION.
      *
           PERFORM VARYING     IDY     FROM    1   BY  1
                   UNTIL       IDY     >   SPA-J023-SRYKAMAX
               IF      WRK-SRYKA           =   SPA-J023-SRYKAL  (IDY)
                   MOVE    SPA-J023-SRYKAMEIL (IDY)
                                               TO  WRK-SRYKAMEI
                   MOVE    SPA-J023-SRYKAMAX   TO  IDY
               END-IF
           END-PERFORM
      *
           IF      WRK-SRYKA           =   ZERO
               MOVE    SPACE               TO  WRK-SRYKAMEI
           END-IF
      *
           .
       810-SRYKA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せ名編集処理
      *****************************************************************
       820-HKNCOMBI-SET-SEC             SECTION.
      *
      *    保険組合マスター編集
           MOVE    SPACE               TO  HKNCOMBI-REC
           INITIALIZE                  HKNCOMBI-REC
           MOVE    SPA-HOSPID          TO  COMB-HOSPID
           MOVE    SPA-GMN-PTID        TO  COMB-PTID
           MOVE    WRK-HKNCOMBI        TO  COMB-HKNCOMBINUM
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
               PERFORM 910-HKNCOMBI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-HKNCOMBI
               INITIALIZE                  HKNCOMBI-REC
           END-IF
           IF      FLG-HKNCOMBI        =   ZERO
               PERFORM 31011-HKNCOMBI-HEN-SEC
           ELSE
               MOVE    SPACE               TO  WRK-HKNCOMBIMEI
           END-IF
      *
           .
       820-HKNCOMBI-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦和暦編集処理
      *****************************************************************
       800-SEIWA-HEN-SEC             SECTION.
      *
           IF      WRK-SYMD            =   ALL "9"  OR   SPACE
               MOVE    SPACE               TO  WRK-HGO
               MOVE    WRK-SYMD(3:2)       TO  WRK-HYY
               MOVE    WRK-SYMD(5:2)       TO  WRK-HMM
               MOVE    WRK-SYMD(7:2)       TO  WRK-HDD
               MOVE    WRK-HENYMD          TO  WRK-HENYMDG
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
           END-IF
           .
       800-SEIWA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC                  SECTION.
      *
           MOVE    SPACE               TO  J023
      *
      *    画面編集
           MOVE    SPA-J023-SRYYM      TO  J023-SRYYM
           MOVE    SPA-J023-COMMENT    TO  J023-COMMENT
      *
      *    診療科
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-J023-SRYKAMAX
               MOVE    SPA-J023-SRYKA-LIST (IDX)
                                           TO  J023-SRYKA-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-J023-SRYKAMAX   TO  J023-SRYKA-COUNT
           MOVE    SPA-J023-SRYKA-G    TO  J023-SRYKA
      *    保険組合せ
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-J023-HKNMAX
               MOVE    SPA-J023-HKN-LIST(IDX)
                                           TO  J023-HKNCOMBI-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-J023-HKNMAX     TO  J023-HKNCOMBI-COUNT
           MOVE    SPA-J023-HKNCOMBI-G TO  J023-HKNCOMBI
      *
           EVALUATE    SPA-J023-SYORI
               WHEN    0
                   MOVE    SPACE               TO  J023-MIDASI
                   MOVE    SPACE               TO  J023-MIDASI-STYLE
               WHEN    1
                   MOVE    "＜変　更＞"        TO  J023-MIDASI
                   MOVE    "red"               TO  J023-MIDASI-STYLE
               WHEN    2
                   MOVE    "＜文　例＞"        TO  J023-MIDASI
                   MOVE    "red"               TO  J023-MIDASI-STYLE
           END-EVALUATE
      *
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-J023-RECE-MAX
               MOVE    SPA-J023-TRENNUM (IDX)  TO  WRK-ZZZ
               MOVE    WRK-ZZZ                 TO  J023-TRENNUM (IDX)
               MOVE    SPA-J023-TSRYYM  (IDX)  TO  J023-TSRYYM  (IDX)
               MOVE    SPA-J023-TSRYKA  (IDX)  TO  J023-TSRYKA  (IDX)
               MOVE    SPA-J023-THKNCOMBI(IDX) TO  J023-THKNCOMBI(IDX)
               IF      SPA-J023-TSRYDD  (IDX)  =   ZERO
                   MOVE    SPACE               TO  J023-TSRYDD  (IDX)
               ELSE
                   MOVE    SPA-J023-TSRYDD  (IDX)
                                               TO  J023-TSRYDD  (IDX)
               END-IF
               MOVE    SPA-J023-TCOMMENT(IDX)  TO  J023-TCOMMENT (IDX)
      *
               IF      SPA-J023-SELNUM     =   SPA-J023-TRENNUM (IDX)
                   MOVE    "T"             TO  J023-RECE-SELECT (IDX)
               ELSE
                   MOVE    "F"             TO  J023-RECE-SELECT (IDX)
               END-IF
           END-PERFORM
           MOVE    SPA-J023-RECE-MAX   TO  J023-RECE-COUNT
      *
           MOVE    SPA-J023-SELNUM     TO  J023-SELNUM
           MOVE    SPA-J023-BUNNUM     TO  J023-BUNNUM
      *
      *
      *    受診履歴
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-J023-RRKMAX
               MOVE    SPA-J023-TRRKNUM   (IDX)  TO  WRK-ZZ
               MOVE    WRK-ZZ                  TO  J023-TJYURRKNUM(IDX)
               MOVE    SPA-J023-JYURRKYMDW(IDX)
                                               TO  J023-TJYURRKYMD(IDX)
      *
               IF      SPA-J023-JYURRKNUM  =   SPA-J023-TRRKNUM (IDX)
                   MOVE    "T"             TO  J023-JYURRK-SELECT (IDX)
               ELSE
                   MOVE    "F"             TO  J023-JYURRK-SELECT (IDX)
               END-IF
           END-PERFORM
           MOVE    SPA-J023-RRKMAX     TO  J023-JYURRK-COUNT
      *
           MOVE    SPA-J023-JYURRKNUM  TO  J023-JYURRKNUM
      *
           PERFORM 5001-MAPCUR-SEC
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
      *
           EVALUATE    SPA-J023-CUR
               WHEN    1
                   MOVE    "COMMENT"           TO  MCP-WIDGET
               WHEN    2
                   MOVE    "SRYKA"            TO  MCP-WIDGET
               WHEN    3
                   MOVE    "HKNCOMBI"          TO  MCP-WIDGET
               WHEN    4
                   MOVE    "SELNUM"            TO  MCP-WIDGET
               WHEN    5
                   MOVE    "BUNNUM"            TO  MCP-WIDGET
               WHEN    6
                   MOVE    "B12"               TO  MCP-WIDGET
               WHEN    7
                   MOVE    "B08"               TO  MCP-WIDGET
               WHEN    8
                   MOVE    "B05"               TO  MCP-WIDGET
               WHEN    9
                   MOVE    "JYURRKNUM"         TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *        クリア
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 220-CLEA-SEC
      *        コメント削除
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM 240-COMMENT-DEL-SEC
      *        変更
               WHEN    "CLICKED"       ALSO    "B04"
                   PERFORM 210-HENKOU-SEC
      *        コピー
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM 250-COPY-SEC
      *        文例選択画面へ
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 250-BUNREI-J024-SEC
      *        文例登録
               WHEN    "CLICKED"       ALSO    "B08"
                   PERFORM 280-BUNREI-ADD-SEC
      *        内容確定
               WHEN    "CLICKED"       ALSO    "B10"
                   PERFORM 209-COMMENT-SEC
      *        登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 212-TOUROKU-SEC
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        診療科
               WHEN    "ACTIVATE"      ALSO    "SRYKA"
                   PERFORM 400-SRYKA-SEC
      *        保険組合せ
               WHEN    "ACTIVATE"      ALSO    "HKNCOMBI"
                   PERFORM 410-HKNCOMBI-SEC
      *        選択番号
               WHEN    "ACTIVATE"      ALSO    "SELNUM"
                   PERFORM 420-SELNUM-SEC
      *        文例番号
               WHEN    "ACTIVATE"      ALSO    "BUNNUM"
                   PERFORM 430-BUNNUM-SEC
      *        明細選択
               WHEN    ANY             ALSO    "RECELIST"
                   PERFORM 440-RECELIST-SEC
      *        受診履歴選択番号
               WHEN    "ACTIVATE"      ALSO    "JYURRKNUM"
                   PERFORM 450-JYURRKNUM-SEC
      *        受診履歴選択
               WHEN    ANY             ALSO    "JYURRKLIST"
                   PERFORM 460-RECELIST-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメント確定処理
      *****************************************************************
       209-COMMENT-SEC                    SECTION.
      *
           MOVE    1                   TO  SPA-J023-CUR
      *
           MOVE    J023-COMMENT        TO  SPA-J023-COMMENT
           PERFORM 800-COMMENT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      209-COMMENT-EXT
           END-IF
      *
           IF      SPA-GMN-PTID        =   ZERO
               MOVE    7                   TO  SPA-J023-CUR
           ELSE
               MOVE    6                   TO  SPA-J023-CUR
           END-IF
      *
           .
       209-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科処理
      *****************************************************************
       400-SRYKA-SEC                    SECTION.
      *
           MOVE    2                   TO  SPA-J023-CUR
      *
           MOVE    J023-SRYKA          TO  SPA-J023-SRYKA-G
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING    IDX      FROM    1   BY  1
                   UNTIL      IDX      >   SPA-J023-SRYKAMAX
               IF      SPA-J023-SRYKA      =   SPA-J023-SRYKAL (IDX)
                   MOVE    SPA-J023-SRYKA-LIST (IDX)
                                           TO  SPA-J023-SRYKA-G
                   MOVE    1               TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    "0001"              TO  SPA-ERRCD
           ELSE
               MOVE    3                   TO  SPA-J023-CUR
           END-IF
      *
           .
       400-SRYKA-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ処理
      *****************************************************************
       410-HKNCOMBI-SEC                 SECTION.
      *
           MOVE    3                   TO  SPA-J023-CUR
      *
           MOVE    J023-HKNCOMBI       TO  SPA-J023-HKNCOMBI-G
      *
           MOVE    ZERO                TO  FLG-OK
           MOVE    SPACE               TO  SPA-J023-RSI-HKNKBN
           PERFORM VARYING    IDX      FROM    1   BY  1
                   UNTIL      IDX      >   SPA-J023-HKNMAX
               IF      SPA-J023-HKNCOMBINUM    =
                                           SPA-J023-THKNCOMBINUM (IDX)
                   MOVE    SPA-J023-HKN-LIST  (IDX)
                                           TO  SPA-J023-HKNCOMBI-G
                   MOVE    SPA-J023-RSI-THKNKBN (IDX)
                                           TO  SPA-J023-RSI-HKNKBN
                   MOVE    1               TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    "0002"              TO  SPA-ERRCD
               GO      TO      410-HKNCOMBI-EXT
           END-IF
      *
      *    労災保険区分がアフターケアの時、履歴日を表示する
           IF      SPA-J023-RSI-HKNKBN =   "3"
               PERFORM 31401-AFTER-JYURRK-SEC
               IF      SPA-J023-RRKMAX     =   ZERO
                   MOVE    "0012"              TO  SPA-ERRCD
                   GO      TO      410-HKNCOMBI-EXT
               END-IF
               MOVE    9                   TO  SPA-J023-CUR
           ELSE
               INITIALIZE                  SPA-J023-JYURRK-LIST
               MOVE    ZERO                TO  SPA-J023-RRKMAX
               MOVE    ZERO                TO  SPA-J023-JYURRKNUM
               MOVE    6                   TO  SPA-J023-CUR
           END-IF
      *
           .
       410-HKNCOMBI-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択番号処理
      *****************************************************************
       420-SELNUM-SEC                 SECTION.
      *
           MOVE    4                   TO  SPA-J023-CUR
      *
           MOVE    J023-SELNUM         TO  SPA-J023-SELNUM
      *
           IF      SPA-J023-SELNUM     =   ZERO
               GO      TO      420-SELNUM-EXT
           END-IF
           IF      SPA-J023-SELNUM     >   SPA-J023-RECE-MAX
               MOVE    "0002"              TO  SPA-ERRCD
               GO      TO      420-SELNUM-EXT
           END-IF
      *
           EVALUATE    SPA-J023-SYORI
      *        変更処理
               WHEN    1
                   PERFORM 2101-HENKOU-SYORI-SEC
      *        コピー処理
               WHEN    3
                   PERFORM 2501-COPY-SYORI-SEC
      *
               WHEN    OTHER
                   MOVE    8                   TO  SPA-J023-CUR
           END-EVALUATE
      *
           .
       420-SELNUM-EXT.
           EXIT.
      *
      *****************************************************************
      *    明細選択処理
      *****************************************************************
       440-RECELIST-SEC                 SECTION.
      *
           MOVE    ZERO                TO  WRK-SELNUM
           MOVE    ZERO                TO  WRK-SELNUM2
      *
           PERFORM VARYING     IDX     FROM   1   BY  1
                   UNTIL       IDX     >   SPA-J023-RECE-MAX
              IF      J023-RECE-SELECT (IDX)   =  "T"
                  IF      SPA-J023-TRENNUM  (IDX)  =   SPA-J023-SELNUM
                      MOVE    SPA-J023-TRENNUM  (IDX)  TO  WRK-SELNUM
                  ELSE
                      MOVE    SPA-J023-TRENNUM  (IDX)  TO  WRK-SELNUM2
                  END-IF
              END-IF
           END-PERFORM
      *
           IF      WRK-SELNUM2     NOT =   ZERO
               MOVE    WRK-SELNUM2         TO  SPA-J023-SELNUM
           ELSE
               MOVE    WRK-SELNUM          TO  SPA-J023-SELNUM
           END-IF
      *
           MOVE    SPA-J023-SELNUM     TO  J023-SELNUM
           PERFORM 420-SELNUM-SEC
      *
           .
       440-RECELIST-EXT.
           EXIT.
      *
      *****************************************************************
      *    文例番号処理
      *****************************************************************
       430-BUNNUM-SEC                 SECTION.
      *
           MOVE    5                   TO  SPA-J023-CUR
      *
           MOVE    J023-BUNNUM         TO  SPA-J023-BUNNUM
      *
           MOVE    7                   TO  SPA-J023-CUR
      *
           .
       430-BUNNUM-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴選択番号処理
      *****************************************************************
       450-JYURRKNUM-SEC                 SECTION.
      *
           MOVE    9                   TO  SPA-J023-CUR
      *
           MOVE    J023-JYURRKNUM      TO  SPA-J023-JYURRKNUM
      *
           IF      SPA-J023-JYURRKNUM  =   ZERO
               GO      TO      450-JYURRKNUM-EXT
           END-IF
           IF      SPA-J023-JYURRKNUM  >   SPA-J023-RRKMAX
               MOVE    "0015"              TO  SPA-ERRCD
               GO      TO      450-JYURRKNUM-EXT
           END-IF
      *
           MOVE    6                   TO  SPA-J023-CUR
      *
           .
       450-JYURRKNUM-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    明細選択処理
      *****************************************************************
       460-RECELIST-SEC                 SECTION.
      *
           MOVE    ZERO                TO  WRK-SELNUM
           MOVE    ZERO                TO  WRK-SELNUM2
      *
           PERFORM VARYING     IDX     FROM   1   BY  1
                   UNTIL       IDX     >   SPA-J023-RRKMAX
              IF      J023-JYURRK-SELECT (IDX)   =  "T"
                  IF      SPA-J023-TRRKNUM(IDX)
                                                 =   SPA-J023-JYURRKNUM
                      MOVE    SPA-J023-TRRKNUM(IDX)  TO  WRK-SELNUM
                  ELSE
                      MOVE    SPA-J023-TRRKNUM(IDX)  TO  WRK-SELNUM2
                  END-IF
              END-IF
           END-PERFORM
      *
           IF      WRK-SELNUM2     NOT =   ZERO
               MOVE    WRK-SELNUM2         TO  SPA-J023-JYURRKNUM
           ELSE
               MOVE    WRK-SELNUM          TO  SPA-J023-JYURRKNUM
           END-IF
      *
           MOVE    SPA-J023-JYURRKNUM  TO  J023-JYURRKNUM
           PERFORM 450-JYURRKNUM-SEC
      *
           .
       460-RECELIST-EXT.
           EXIT.
      *
      *****************************************************************
      *    クリア　処理
      *****************************************************************
       220-CLEA-SEC                   SECTION.
      *
           PERFORM                     310-SPA-SET-SEC
      *
           MOVE    1                  TO  SPA-J023-CUR
           .
       220-CLEA-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録　処理
      *****************************************************************
       212-TOUROKU-SEC                   SECTION.
      *
           IF      SPA-GMN-PTID        =   ZERO
               MOVE    "0011"              TO  SPA-ERRCD
               GO      TO      212-TOUROKU-EXT
           END-IF
      *
           MOVE    J023-COMMENT        TO  SPA-J023-COMMENT
      *
           IF      SPA-J023-HKNCOMBINUM    =   SPACE  AND
                   SPA-J023-HKNMAX         =   ZERO
               MOVE    "0006"              TO  SPA-ERRCD
               GO      TO      212-TOUROKU-EXT
           END-IF
           IF      SPA-J023-HKNCOMBINUM    =   SPACE
               MOVE    "0002"              TO  SPA-ERRCD
               GO      TO      212-TOUROKU-EXT
           END-IF
      *    アフターケアの時、受診日を選択すること
           IF      SPA-J023-RSI-HKNKBN     =   "3"
               IF      SPA-J023-JYURRKNUM  =   ZERO
                   MOVE    "0014"              TO  SPA-ERRCD
                   MOVE    9                   TO  SPA-J023-CUR
                   GO      TO      212-TOUROKU-EXT
               END-IF
           END-IF
      *
           IF      SPA-J023-COMMENT    =   SPACE
               MOVE    "0007"              TO  SPA-ERRCD
               GO      TO      212-TOUROKU-EXT
           END-IF
           PERFORM 800-COMMENT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      212-TOUROKU-EXT
           END-IF
      *
           PERFORM 2130-HKNCOMBI-CHK-SEC
      *
           PERFORM 2120-RECECOM-SEL-SEC
           IF      FLG-RECECOM         =   ZERO
               MOVE    "0105"              TO  SPA-JIDCD
           ELSE
               MOVE    "0101"              TO  SPA-JIDCD
           END-IF
      *
           .
       212-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診のチェック処理
      *****************************************************************
       2130-HKNCOMBI-CHK-SEC          SECTION.
      *
      *
      *    受診歴を検索する  医療機関、患者ＩＤ
           INITIALIZE                  JYURRK-REC
           MOVE    SPA-HOSPID          TO  JYURRK-HOSPID
           MOVE    SPA-GMN-PTID        TO  JYURRK-PTID
           MOVE    SPA-NYUGAIKBN       TO  JYURRK-NYUGAIKBN
           MOVE    SPA-J023-SRYYMS     TO  JYURRK-SRYYMD(1:6)
           MOVE    "01"                TO  JYURRK-SRYYMD(7:2)
           MOVE    SPA-J023-SRYYMS     TO  JYURRK-UPSRYYMD(1:6)
           MOVE    "31"                TO  JYURRK-UPSRYYMD(7:2)
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "JYURRK-KEY13"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "JYURRK-KEY13"      TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM
               UNTIL   (FLG-JYURRK     =   1  )  OR
                       (FLG-OK         =   1  )
               IF      SPA-J023-SRYKA      =   "00"
                   IF      SPA-J023-HKNCOMBINUM
                                           =   JYURRK-HKNCOMBINUM
                       PERFORM 21301-HKNCOBMI-RSCHK-SEC
                   END-IF
               ELSE
                   IF     (SPA-J023-HKNCOMBINUM
                                           =   JYURRK-HKNCOMBINUM) AND
                          (SPA-J023-SRYKA  =   JYURRK-SRYKA      )
                       PERFORM 21301-HKNCOBMI-RSCHK-SEC
                   END-IF
               END-IF
      *
               MOVE    "JYURRK-KEY13"    TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           END-PERFORM
      *
           IF      FLG-OK              =   ZERO
               MOVE    "0012"          TO  SPA-ERRCD
           END-IF
      *
           .
       2130-HKNCOMBI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険チェック処理
      *****************************************************************
       21301-HKNCOBMI-RSCHK-SEC        SECTION.
      *
           IF      SPA-J023-RSI-HKNKBN =   "3"
               IF      SPA-J023-JYURRKYMD (SPA-J023-JYURRKNUM)
                                           =   JYURRK-SRYYMD
                   MOVE    1                   TO  FLG-OK
               END-IF
           ELSE
               MOVE    1                   TO  FLG-OK
           END-IF
      *
           .
       21301-HKNCOBMI-RSCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプトコメントチェック処理
      *****************************************************************
       2120-RECECOM-SEL-SEC          SECTION.
      *
      *
           MOVE    SPACE               TO  RECECOM-REC
           INITIALIZE                  RECECOM-REC
           MOVE    SPA-HOSPID          TO  RECECOM-HOSPID
           MOVE    SPA-GMN-PTID        TO  RECECOM-PTID
           MOVE    SPA-GMN-NYUGAIKBN   TO  RECECOM-NYUGAIKBN
           MOVE    SPA-J023-SRYKA      TO  RECECOM-SRYKA
           MOVE    SPA-J023-SRYYMS     TO  RECECOM-SRYYM
           MOVE    SPA-J023-HKNCOMBINUM
                                       TO  RECECOM-HKNCOMBI
           IF      SPA-J023-RSI-HKNKBN     =   "3"
               MOVE    SPA-J023-JYURRKYMD (SPA-J023-JYURRKNUM)(7:2)
                                           TO  RECECOM-SRYDD
           ELSE
               MOVE    ZERO                TO  RECECOM-SRYDD
           END-IF
      *
           MOVE    RECECOM-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "RECECOM-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "RECECOM-KEY"      TO  ORC-DBPATH
               PERFORM 920-RECECOM-READ-SEC
           ELSE
               MOVE    1               TO  FLG-RECECOM
               INITIALIZE                  RECECOM-REC
           END-IF
      *
           .
       2120-RECECOM-SEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録　処理
      *****************************************************************
       2121-TOUROKU-SYORI-SEC          SECTION.
      *
           PERFORM 2120-RECECOM-SEL-SEC
           IF      FLG-RECECOM         =   ZERO
      *        更新
               MOVE    SPA-J023-COMMENT    TO  RECECOM-COMMENT
      *
               MOVE    RECECOM-REC         TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "RECECOM-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "J023 RECECOM UPD ERR:" MCP-RC "."
               END-IF
           ELSE
      *        追加
               MOVE    SPACE               TO  RECECOM-REC
               INITIALIZE                  RECECOM-REC
               MOVE    SPA-HOSPID          TO  RECECOM-HOSPID
               MOVE    SPA-GMN-PTID        TO  RECECOM-PTID
               MOVE    SPA-GMN-NYUGAIKBN   TO  RECECOM-NYUGAIKBN
               MOVE    SPA-J023-SRYKA      TO  RECECOM-SRYKA
               MOVE    SPA-J023-SRYYMS     TO  RECECOM-SRYYM
               MOVE    SPA-J023-HKNCOMBINUM
                                           TO  RECECOM-HKNCOMBI
               IF      SPA-J023-RSI-HKNKBN     =   "3"
                   MOVE    SPA-J023-JYURRKYMD (SPA-J023-JYURRKNUM)(7:2)
                                               TO  RECECOM-SRYDD
               ELSE
                   MOVE    ZERO                TO  RECECOM-SRYDD
               END-IF
               MOVE    SPA-J023-COMMENT    TO  RECECOM-COMMENT
      *
               MOVE    RECECOM-REC         TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "RECECOM-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "J023 RECECOM INS ERR:" MCP-RC "."
               END-IF
           END-IF
      *
      *    再表示
           PERFORM                     310-SPA-SET-SEC
      *
           MOVE    1                   TO  SPA-J023-CUR
      *    コメント編集編集
      *    PERFORM 3103-RECECOM-HEN-SEC
      *
      *    MOVE    SPA-NAI-SRYYM       TO  SPA-J023-SRYYMS
      *    MOVE    SPA-GMN-SRYYM       TO  SPA-J023-SRYYM
      *
      *    MOVE    SPACE              TO  SPA-J023-COMMENT
      *    MOVE    ZERO               TO  SPA-J023-SYORI
      *    MOVE    1                  TO  SPA-J023-CUR
      *
           .
       2121-TOUROKU-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    文例選択画面へ　処理
      *****************************************************************
       250-BUNREI-J024-SEC                   SECTION.
      *
           MOVE    SPACE               TO  SPA-MOTOPG
      *
           MOVE    SPA-J01KYOUTU       TO  SPA-WORK
           MOVE    SPA-AREA            TO  SPA-COMMON
           MOVE    SPA-J02             TO  SPA-FREE
      *
           MOVE    "LINK"              TO  MCP-STATUS
           MOVE    SPACE               TO  MCP-EVENT
      *
           CALL    "ORCGJ024"          USING
                                       MCPAREA
                                       SPAAREA
                                       LINKAREA
                                       SCRAREA.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-J02
           MOVE    SPA-WORK        TO  SPA-J01KYOUTU
      *
      *    カーソル移動
           MOVE    "SELNUM"            TO  MCP-WIDGET
      *
           MOVE    "J023"              TO  SPA-MOTOPG
           MOVE    "J024"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "J024"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
      *
       250-BUNREI-J024-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメントチェック処理
      *****************************************************************
       800-COMMENT-CHK-SEC                   SECTION.
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    SPA-J023-COMMENT    TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   1     )
      *        全角以外エラー
               MOVE    "0013"          TO  SPA-ERRCD
           ELSE
               MOVE    KANACHK-OUT-INPUT   TO  SPA-J023-COMMENT
           END-IF
           .
      *
       800-COMMENT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    文例登録　処理
      *****************************************************************
       280-BUNREI-ADD-SEC                   SECTION.
      *
           MOVE    J023-COMMENT        TO  SPA-J023-COMMENT
      *
           IF      SPA-J023-COMMENT    =   SPACE
               MOVE    "0007"              TO  SPA-ERRCD
               GO      TO      280-BUNREI-ADD-EXT
           END-IF
           PERFORM 800-COMMENT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      280-BUNREI-ADD-EXT
           END-IF
      *
           IF      SPA-J023-BUNNUM     =   ZERO
               MOVE    "0102"              TO  SPA-JIDCD
           ELSE
               PERFORM 28001-EXAMPLE-CHK-SEC
               IF      FLG-EXAMPLE         =   ZERO
                   MOVE    "0103"              TO  SPA-JIDCD
               ELSE
                   MOVE    "0106"              TO  SPA-JIDCD
               END-IF
           END-IF
      *
           .
       280-BUNREI-ADD-EXT.
           EXIT.
      *
      *****************************************************************
      *    雛形有無チェック処理
      *****************************************************************
       28001-EXAMPLE-CHK-SEC                   SECTION.
      *
      *
      *    雛形有無
           MOVE    SPACE               TO  EXAMPLE-REC
           INITIALIZE                  EXAMPLE-REC
           MOVE    SPA-HOSPID          TO  EXAMPLE-HOSPID
           MOVE    "1"                 TO  EXAMPLE-KUBUN
           MOVE    SPA-J023-BUNNUM     TO  EXAMPLE-RENNUM
      *
           MOVE    EXAMPLE-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "EXAMPLE-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "EXAMPLE-KEY"       TO  ORC-DBPATH
               PERFORM 930-EXAMPLE-READ-SEC
           ELSE
               MOVE    1               TO  FLG-EXAMPLE
               INITIALIZE                  EXAMPLE-REC
           END-IF
      *
           .
       28001-EXAMPLE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    文例登録　処理
      *****************************************************************
       2801-BUNREI-SYORI-SEC                   SECTION.
      *
           IF      SPA-J023-BUNNUM     =   ZERO
      *        最大連番決定
               MOVE    SPACE               TO  EXAMPLE-REC
               INITIALIZE                  EXAMPLE-REC
               MOVE    SPA-HOSPID          TO  EXAMPLE-HOSPID
               MOVE    "1"                 TO  EXAMPLE-KUBUN
      *
               MOVE    EXAMPLE-REC         TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "EXAMPLE-KEY2"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    "EXAMPLE-KEY2"      TO  ORC-DBPATH
                   PERFORM 930-EXAMPLE-READ-SEC
               ELSE
                   MOVE    1               TO  FLG-EXAMPLE
                   INITIALIZE                  EXAMPLE-REC
               END-IF
               MOVE    EXAMPLE-RENNUM      TO  SPA-J023-BUNNUM
               IF      SPA-J023-BUNNUM     =   999
                   MOVE    "0010"              TO  SPA-ERRCD
                   GO      TO      2801-BUNREI-SYORI-EXT
               END-IF
               ADD     1                   TO  SPA-J023-BUNNUM
           END-IF
      *
      *    雛形有無
           PERFORM 28001-EXAMPLE-CHK-SEC
           IF      FLG-EXAMPLE         =   ZERO
      *        更新
               MOVE    SPA-J023-COMMENT    TO  EXAMPLE-COMMENT
      *
               MOVE    EXAMPLE-REC         TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "EXAMPLE-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "J023 EXAMPLE UPD ERR:" MCP-RC "."
               END-IF
           ELSE
      *        追加
               MOVE    SPACE               TO  EXAMPLE-REC
               INITIALIZE                  EXAMPLE-REC
               MOVE    SPA-HOSPID          TO  EXAMPLE-HOSPID
               MOVE    "1"                 TO  EXAMPLE-KUBUN
               MOVE    SPA-J023-BUNNUM     TO  EXAMPLE-RENNUM
               MOVE    SPA-J023-COMMENT    TO  EXAMPLE-COMMENT
      *
               MOVE    EXAMPLE-REC         TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "EXAMPLE-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "J023 EXAMPLE INS ERR:" MCP-RC "."
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  SPA-J023-COMMENT
           MOVE    ZERO                TO  SPA-J023-SELNUM
           MOVE    ZERO                TO  SPA-J023-BUNNUM
           MOVE    1                   TO  SPA-J023-CUR
      *
           .
       2801-BUNREI-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメント削除　処理
      *****************************************************************
       240-COMMENT-DEL-SEC                   SECTION.
      *
           IF      SPA-GMN-PTID        =   ZERO
               MOVE    "0011"              TO  SPA-ERRCD
               GO      TO      240-COMMENT-DEL-EXT
           END-IF
      *
           IF      SPA-J023-SELNUM     =   ZERO    OR
                                       >   SPA-J023-RECE-MAX
               MOVE    "0003"              TO  SPA-ERRCD
               GO      TO      240-COMMENT-DEL-EXT
           END-IF
      *
           MOVE    "0104"              TO  SPA-JIDCD
           .
       240-COMMENT-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメント削除処理
      *****************************************************************
       2401-COMMENT-DELSYORI-SEC                   SECTION.
      *
           MOVE    SPA-J023-SELNUM     TO  IDX
      *
           MOVE    SPACE               TO  RECECOM-REC
           INITIALIZE                  RECECOM-REC
           MOVE    SPA-HOSPID          TO  RECECOM-HOSPID
           MOVE    SPA-GMN-PTID        TO  RECECOM-PTID
           MOVE    SPA-GMN-NYUGAIKBN   TO  RECECOM-NYUGAIKBN
           MOVE    SPA-J023-NSRYKA (IDX)
                                      TO  RECECOM-SRYKA
           MOVE    SPA-J023-NSRYYM (IDX)
                                       TO  RECECOM-SRYYM
           MOVE    SPA-J023-NHKNCOMBI (IDX)
                                       TO  RECECOM-HKNCOMBI
           MOVE    SPA-J023-TSRYDD (IDX)
                                       TO  RECECOM-SRYDD
           IF      SPA-J023-TSRYDD (IDX)   =   SPACE
               MOVE    ZERO                TO  RECECOM-SRYDD
           END-IF
      *
           MOVE    RECECOM-REC         TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "RECECOM-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "J023 RECECOM DEL ERR:" MCP-RC "."
           END-IF
      *
      *    再表示
           PERFORM                     310-SPA-SET-SEC
      *
           .
       2401-COMMENT-DELSYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    変更　処理
      *****************************************************************
       210-HENKOU-SEC                   SECTION.
      *
           IF      SPA-GMN-PTID        =   ZERO
               MOVE    "0011"              TO  SPA-ERRCD
               GO      TO      210-HENKOU-EXT
           END-IF
      *
           IF      SPA-J023-SELNUM     >   SPA-J023-RECE-MAX
               MOVE    "0003"              TO  SPA-ERRCD
               GO      TO      210-HENKOU-EXT
           END-IF
      *
           MOVE    1                   TO  SPA-J023-SYORI
           IF      SPA-J023-SELNUM     =   ZERO
               MOVE    4               TO  SPA-J023-CUR
           ELSE
               PERFORM 2101-HENKOU-SYORI-SEC
           END-IF
      *
           .
       210-HENKOU-EXT.
           EXIT.
      *
      *****************************************************************
      *    変更　処理
      *****************************************************************
       2101-HENKOU-SYORI-SEC                   SECTION.
      *
           MOVE    SPA-J023-TSRYYM  (SPA-J023-SELNUM)
                                       TO  SPA-J023-SRYYM
           MOVE    SPA-J023-NSRYYM  (SPA-J023-SELNUM)
                                       TO  SPA-J023-SRYYMS
      *
      *    保険組合せ
           PERFORM 3101-HKNCOMBI-HEN-SEC
      *
      *    診療科
           PERFORM 3102-SRYKA-HEN-SEC
      *
      *    初期編集
           PERFORM 314-SYOKI-SEC
      *
           MOVE    SPA-J023-NSRYKA  (SPA-J023-SELNUM)
                                       TO  J023-SRYKA
           PERFORM 400-SRYKA-SEC
           MOVE    SPA-J023-NHKNCOMBI  (SPA-J023-SELNUM)
                                       TO  J023-HKNCOMBI
           PERFORM 410-HKNCOMBI-SEC
           MOVE    SPA-J023-TCOMMENT(SPA-J023-SELNUM)
                                       TO  SPA-J023-COMMENT
      *
      *    アフターケアの時診療日を選択させる
           IF       SPA-J023-TSRYDD (SPA-J023-SELNUM)  =   "00" OR
                                                           SPACE
               CONTINUE
           ELSE
               PERFORM VARYING     IDX     FROM    1   BY  1
                       UNTIL       IDX     >   SPA-J023-RRKMAX
                   IF      SPA-J023-JYURRKYMD (IDX)(7:2)
                                           =   SPA-J023-TSRYDD
                                                  (SPA-J023-SELNUM)
                       MOVE    IDX             TO  SPA-J023-JYURRKNUM
                       MOVE    SPA-J023-RRKMAX
                                               TO  IDX
                   END-IF
               END-PERFORM
           END-IF
      *
           MOVE    1                   TO  SPA-J023-CUR
           .
       2101-HENKOU-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    コピー　処理
      *****************************************************************
       250-COPY-SEC                   SECTION.
      *
           IF      SPA-GMN-PTID        =   ZERO
               MOVE    "0011"              TO  SPA-ERRCD
               GO      TO      250-COPY-EXT
           END-IF
      *
           IF      SPA-J023-SELNUM     >   SPA-J023-RECE-MAX
               MOVE    "0003"              TO  SPA-ERRCD
               GO      TO      250-COPY-EXT
           END-IF
      *
           MOVE    3                   TO  SPA-J023-SYORI
           IF      SPA-J023-SELNUM     =   ZERO
               MOVE    4               TO  SPA-J023-CUR
           ELSE
               PERFORM 2501-COPY-SYORI-SEC
           END-IF
      *
           .
       250-COPY-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメントコピー処理
      *****************************************************************
       2501-COPY-SYORI-SEC                   SECTION.
      *
           MOVE    SPA-J023-TCOMMENT(SPA-J023-SELNUM)
                                       TO  SPA-J023-COMMENT
      *
           MOVE    1                   TO  SPA-J023-CUR
           .
       2501-COPY-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "J02"               TO  SPA-SAKIPG
           MOVE    "J023"              TO  SPA-MOTOPG
      *
      *****MOVE   "BACK"               TO  MCP-PUTTYPE
           MOVE    "JOIN"              TO  MCP-PUTTYPE.
           MOVE   "J02"                TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
            PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO      TO      500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-JIDCD       NOT =   SPACE
               PERFORM 520-JIDSET-SEC
               GO      TO      500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "J023"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "診療科選択エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "保険組合せ選択エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "選択番号が有りません"
                                       TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "文例登録番号エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "診療年月に診療行為がありません。"
                                       TO  SPA-ERRMSG
                   MOVE    "コメントは登録できません。"
                                       TO  SPA-ERRMSG(33:)
               WHEN    "0007"
                   MOVE    "コメント内容が未入力です。入力して下さい"
                                       TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE
                   "文例が９９９件あります。これ以上追加できません"
                                       TO  SPA-ERRMSG
               WHEN    "0011"
                   MOVE
                   "患者が選択されてません。文例の処理しかできません"
                                       TO  SPA-ERRMSG
               WHEN    "0012"
                   MOVE
                   "対象の診療科と保険組合せは受診が有りません。"
                                       TO  SPA-ERRMSG
               WHEN    "0013"
                   MOVE    "コメントは全角で入力して下さい"
                                       TO  SPA-ERRMSG
               WHEN    "0014"
                   MOVE    "アフターケアの時、診療日を選択して下さい"
                                       TO  SPA-ERRMSG
               WHEN    "0015"
                   MOVE    "アフターケア診療日選択番号がありません"
                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  JERR
           MOVE    SPA-ERRCD           TO  JERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  JERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "J023"              TO  SPA-MOTOPG
           MOVE    "JERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "JERR"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       520-JIDSET-SEC              SECTION.
      *
           EVALUATE    SPA-JIDCD
               WHEN    "0101"
                   MOVE    "診療年月のレセプトコメントを入力します。"
                                       TO  WRK-JIDMSG
                   MOVE    "よろしいですか？"
                                       TO  WRK-JIDMSG(41:)
               WHEN    "0102"
                   MOVE    "文例へ追加登録します。"
                                       TO  WRK-JIDMSG
                   MOVE    "よろしいですか？"
                                       TO  WRK-JIDMSG(23:)
               WHEN    "0103"
                   MOVE    "文例登録番号の文例を更新します。"
                                       TO  WRK-JIDMSG
                   MOVE    "よろしいですか？"
                                       TO  WRK-JIDMSG(39:)
               WHEN    "0106"
                   MOVE    "文例を文例登録番号で追加します。"
                                       TO  WRK-JIDMSG
                   MOVE    "よろしいですか？"
                                       TO  WRK-JIDMSG(39:)
               WHEN    "0104"
                   MOVE    "選択されているコメントを削除します。"
                                       TO  WRK-JIDMSG
                   MOVE    "よろしいですか？"
                                       TO  WRK-JIDMSG(37:)
               WHEN    "0105"
                   MOVE    "選択されているコメントを変更します。"
                                       TO  WRK-JIDMSG
                   MOVE    "よろしいですか？"
                                       TO  WRK-JIDMSG(37:)
               WHEN    OTHER
                   MOVE    SPA-ERRCD
                                       TO  WRK-JIDMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  SPA-JID1-FLG
      *
           MOVE    SPACE               TO  JID1
           MOVE    SPA-JIDCD           TO  JID1-ID1CODE
           MOVE    WRK-JIDMSG          TO  JID1-ID1MSG
           MOVE    "B12"               TO  MCP-WIDGET
      *
           MOVE    "J023"              TO  SPA-MOTOPG
           MOVE    "JID1"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "JID1"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       520-JIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスター読込
      *****************************************************************
       910-HKNCOMBI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  HKNCOMBI-REC
               MOVE    ZERO                TO  FLG-HKNCOMBI
           ELSE
               INITIALIZE                      HKNCOMBI-REC
               MOVE    1                   TO  FLG-HKNCOMBI
           END-IF
      *
           .
       910-HKNCOMBI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプトコメント読込
      *****************************************************************
       920-RECECOM-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  RECECOM-REC
               MOVE    ZERO                TO  FLG-RECECOM
           ELSE
               INITIALIZE                      RECECOM-REC
               MOVE    1                   TO  FLG-RECECOM
           END-IF
      *
           .
       920-RECECOM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    雛形読込
      *****************************************************************
       930-EXAMPLE-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  EXAMPLE-REC
               MOVE    ZERO                TO  FLG-EXAMPLE
           ELSE
               INITIALIZE                      EXAMPLE-REC
               MOVE    1                   TO  FLG-EXAMPLE
           END-IF
      *
           .
       930-EXAMPLE-READ-EXT.
           EXIT.
      *****************************************************************
      *    受診履歴マスター読込
      *****************************************************************
       970-JYURRK-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  JYURRK-REC
               MOVE    ZERO            TO  FLG-JYURRK
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           .
       970-JYURRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者労災保険情報読み込み
      *****************************************************************
       993-PTRSIINF-NEXT-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTRSIINF-REC
               MOVE    ZERO            TO  FLG-PTRSIINF
           ELSE
               INITIALIZE                  PTRSIINF-REC
               MOVE    1               TO  FLG-PTRSIINF
           END-IF
      *
           .
       993-PTRSIINF-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL   "ORCMCPSUB"   USING
                                MCPAREA
                                ORCMCPAREA
                                MCPDATA-REC.
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
      *
