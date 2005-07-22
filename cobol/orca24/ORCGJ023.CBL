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
      *  コンポーネント名  : レセコメント（Ｊ０２３）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/02/05    MCC−多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     NACL-多々納  02/08/06  アフターケア対応追加
      * 01.00.02     NACL-多々納  02/08/18  自賠責追加
      * 01.00.03     NACL-多々納  03/03/06  入外区分追加
      * 01.00.04     NACL-多々納  05/07/11  複写機能追加・共通化
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
           03  FLG-PTNYUINRRK      PIC 9(01).
           03  FLG-NYUINACCT       PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
           03  FLG-HKNCOMBICHK     PIC 9(01).
           03  FLG-OK              PIC 9(01).
           03  FLG-COPY-END        PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDH                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDX-D1              PIC 9(04).
           03  IDX-D2              PIC 9(04).
           03  IDX-D3              PIC 9(04).
           03  IDX-Z               PIC 9(04).
           03  IDX-S               PIC 9(04).
           03  IDX-S2              PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD            PIC X(08).
           03  WRK-HKNCOMBI        PIC 9(04).
           03  WRK-HKNCOMBIMEI     PIC X(100).
           03  WRK-HKNCOMBIMEI-H   PIC X(100).
           03  WRK-HKNKBN-MEI      PIC X(02).
      *
           03  WRK-SRYKA           PIC X(02).
           03  WRK-SRYKAMEI        PIC X(20).
      *    保険組合せ再設定
           03  WRK-HKN-IDX         PIC 9(04).
           03  WRK-HKN-IDX1        PIC 9(04).
      *
           03  WRK-SELNUM-CHK-G.
               05  WRK-SELNUM-CHK  PIC 9(03)   OCCURS  100.
           03  WRK-HEN-SELNUM      PIC X(40).
           03  WRK-HEN-SELNUM-2    PIC X(40).
      *
           03  WRK-SELNUM          PIC 9(03).
           03  WRK-SELNUM2         PIC 9(03).
      *
           03  WRK-SELNUM-X        PIC X(03).
           03  WRK-J023-SELNUM-X   PIC X(40).
      *
           03  WRK-ZZZ             PIC ZZZ.
           03  WRK-ZZ              PIC ZZ.
      *
           03  WRK-DBPATH          PIC X(20).
           03  WRK-MCP-WIDGET      PIC X(64).
      *
           03  WRK-JIDMSG          PIC X(80).
      *
           03  WRK-COPYYM.
               05  WRK-COPYYY          PIC 9(04).
               05  WRK-COPYMM          PIC 9(02).
      *
      *    コラムリスト位置
           03  WRK-J023-RECE-ROW       PIC S9(09).
           03  FLG-GMN-INIT            PIC  9(01).
      *
      *    保険組合せワーク
           03  WRK-J023-HKNCOMB-COMB.
               05  WRK-J023-HKN-LIST    OCCURS  30.
                   07  WRK-J023-THKNCOMBINUM    PIC X(04).
                   07  WRK-J023-THKNCOMBY1      PIC X(01).
                   07  WRK-J023-THKNCOMBIMEI    PIC X(100).
                   07  WRK-J023-FLG             PIC X(01).
                   07  WRK-J023-RSI-HKNKBN      PIC X(01).
                05  WRK-J023-HKNMAX              PIC 9(04).
      *    一括削除編集
           03  WRK-SELNUM-G.
               05  WRK-SEL-OCC         OCCURS   100.
                   07  WRK-TSELNUM-X    PIC X(03).
                   07  WRK-TSELNUM      PIC 9(03).
                   07  WRK-TSELH        PIC X(01).
           03  WRK-SELNUM-AREA.
               05  WRK-SELNUM-OCC    OCCURS   100.
                   07  WRK-SEL         PIC 9(01).
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
      *    システム管理マスタ
           COPY    "CPSK1001.INC".
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    レセプトコメント
       01  RECECOM-REC.
           COPY    "CPRECECOM.INC".
      *    保存用レセプトコメント
       01  HZN-RECECOM-REC.
           COPY    "CPRECECOM.INC"  REPLACING
                                     //RECECOM-// BY //HZN-RECECOM-//.
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
      *    入院会計マスタ−
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
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
           COPY    "CPORCXKANACONV.INC".
      *
      *    画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    保険組合せセット領域
           COPY    "CPORCSHKNSET.INC".
      *
      *    レセプト作成管理マスタ更新サブ
           COPY    "CPORCSRECEUPD.INC".
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
           COPY    "J025.INC".
           COPY    "J026.INC".
           COPY    "J03.INC".
           COPY    "J04.INC".
           COPY    "J041.INC".
           COPY    "J042.INC".
           COPY    "J98.INC".
           COPY    "J99.INC".
           COPY    "JERR.INC".
           COPY    "JID1.INC".
           COPY    "JID2.INC".
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
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
      *    エラー画面より
           IF      SPA-MOTOPG          =   "JERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *
      *        初期画面編集
               PERFORM 300-SCREEN-SEC
      *        画面編集
               IF      FLG-END         =   ZERO
                   PERFORM 500-GMNHEN-SEC
               END-IF
           END-IF
      *
           IF      FLG-END         =   ZERO
               MOVE    SPACE               TO  LINKAREA
               MOVE   "NEW"                TO  MCP-PUTTYPE
               MOVE   "J023"               TO  MCP-WINDOW
      *
               PERFORM 900-PUT-WINDOW
      *
               MOVE    1                   TO  FLG-END
           END-IF
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
           EVALUATE    SPA-MOTOPG(1:4)
      *            文例画面より
               WHEN    "J024"
                   IF      SPA-J024-SELNUM     NOT =   ZERO
                       MOVE    1                   TO  SPA-J023-CUR
                       MOVE    SPACE               TO  SPA-JIDCD
                   ELSE
                       MOVE    1                   TO  SPA-J023-CUR
                   END-IF
      *            確認画面より
               WHEN    "JID1"
                   PERFORM 3003-JID1-SET-SEC
                   MOVE    SPACE               TO  SPA-JIDCD
      *            初期画面表示
               WHEN    OTHER
                   PERFORM                     310-SPA-SET-SEC
                   MOVE    1                   TO  SPA-J023-CUR
           END-EVALUATE
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
               WHEN    "0201"
               WHEN    "0205"
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
       310-SPA-SET-SEC                 SECTION.
      *
           MOVE    1                   TO  FLG-GMN-INIT
      *
           INITIALIZE                  SPA-J023-AREA
      *
           MOVE    SPA-NAI-SRYYM       TO  SPA-J023-SRYYMS
           MOVE    SPA-GMN-SRYYM       TO  SPA-J023-SRYYM
           MOVE    SPA-GMN-NYUGAIKBN   TO  SPA-J023-NYUGAIKBN
           IF      SPA-GMN-PTID        =   ZERO
      *        文例登録のみ
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
      *     入院判定
            PERFORM 3105-NYUGAI-HEN-SEC
      *
      *     コメント編集編集
           MOVE    ZERO                TO  SPA-J023-NEXT
           MOVE    1                   TO  SPA-J023-PAGE
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
           MOVE    SPA-J023-SRYYMS     TO  SPA-SRYYMD(1:6)
           MOVE    "00"                TO  SPA-SRYYMD(7:2)
           MOVE    SPA-GMN-PTID        TO  SPA-PTID
      *
           INITIALIZE                  ORCSHKNSETAREA
           MOVE    "1"                 TO  ORCSHKN-KBN
           MOVE    SPACE               TO  ORCSHKN-KBN2
           CALL    "ORCSHKNSET"        USING
                                       SPA-AREA
                                       ORCSHKNSETAREA
      *
           MOVE    ORCSHKN-HKN-MAX     TO  SPA-J023-HKNMAX
      *
           MOVE    ZERO                TO  IDH
           PERFORM VARYING     IDX     FROM   1   BY  1
                   UNTIL      (IDX     >   ORCSHKN-HKN-MAX )  OR
                              (IDH     >=  30              )
               ADD     1                   TO  IDH
               MOVE    ORCSHKN-GMN-HKNCOMBINUM (IDX)
                                           TO  SPA-J023-THKNCOMBINUM
                                                                (IDH)
               MOVE    ORCSHKN-GMN-HKNCOMBIMEI (IDX)
                                           TO  SPA-J023-THKNCOMBIMEI
                                                               (IDH)
               MOVE    ORCSHKN-NAI-RSI-HKNKBN  (IDX)
                                           TO  SPA-J023-RSI-THKNKBN
                                                               (IDH)
      *
               MOVE    IDH             TO  SPA-J023-HKNMAX
           END-PERFORM
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
               MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
               PERFORM 990-DBCLOSE-SEC
      *
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
      *******  MOVE    PTRSI-HKNKBN        TO  SPA-J023-RSI-THKNKBN
      *******                                         (SPA-J023-HKNMAX)
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
      *    入院判定編集処理
      *****************************************************************
       3105-NYUGAI-HEN-SEC        SECTION.
      *
           IF     (SPA-BEDKBN          =   ZERO ) OR
                  (SPA-J023-SRYYMS     =   SPA-GMN-SRYYM)
               CONTINUE
           ELSE
               INITIALIZE                  SYS-1001-REC
               MOVE    "1001"              TO  SYS-1001-KANRICD
               MOVE    "*"                 TO  SYS-1001-KBNCD
               MOVE    SYS-1001-REC        TO  MCPDATA-REC
      *        システム管理検索
               MOVE    SPA-J023-SRYYMS     TO  ORC-DBYMD(1:6)
               MOVE    "01"                TO  ORC-DBYMD(7:2)
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
                   PERFORM 900-SYSKANRI-READ-SEC
               ELSE
                   INITIALIZE                  SYS-1001-REC
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
               IF      FLG-SYSKANRI        =   ZERO
                   MOVE    MCPDATA-REC         TO  SYS-1001-REC
      *            病床数
                   MOVE    SYS-1001-BEDSU          TO  SPA-BEDSU
               END-IF
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 990-DBCLOSE-SEC
           END-IF
      *
           IF      SPA-BEDSU           >   ZERO
               MOVE    "1 入院"            TO  SPA-J023-NYUGAIKBN-LST(1)
               MOVE    "2 外来"            TO  SPA-J023-NYUGAIKBN-LST(2)
               MOVE    2                   TO  SPA-J023-NYUGAI-MAX
           ELSE
               MOVE    "2 外来"            TO  SPA-J023-NYUGAIKBN-LST(1)
               MOVE    1                   TO  SPA-J023-NYUGAI-MAX
           END-IF
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-J023-NYUGAI-MAX
               IF      SPA-J023-NYUGAIKBN  =   SPA-J023-NYUGAIKBN-LST
                                                           (IDX)(1:1)
                   MOVE    SPA-J023-NYUGAIKBN-LST (IDX)
                                           TO  SPA-J023-NYUGAIKBN-G
               END-IF
           END-PERFORM
      *
           .
       3105-NYUGAI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメント編集処理
      *****************************************************************
        3103-RECECOM-HEN-SEC        SECTION.
      *
           MOVE    1                   TO  FLG-GMN-INIT
           INITIALIZE                  SPA-J023-RECECOMLIST-G
      *
           MOVE    SPACE               TO  RECECOM-REC
           INITIALIZE                  RECECOM-REC
           MOVE    SPA-HOSPID          TO  RECECOM-HOSPID
           MOVE    SPA-GMN-PTID        TO  RECECOM-PTID
           MOVE    SPA-J023-NYUGAIKBN  TO  RECECOM-NYUGAIKBN
      *
           MOVE    RECECOM-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "RECECOM-KEY2"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
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
           MOVE    ZERO                TO  SPA-J023-NEXT
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  IDX-S2
           IF      SPA-J023-PAGE       =   ZERO
               MOVE    1               TO  SPA-J023-PAGE
           END-IF
           COMPUTE IDX-S               =  (SPA-J023-PAGE  -  1 )
                                       *   100
                                       +   1
           PERFORM
                   UNTIL       FLG-RECECOM        =   1
               ADD     1               TO  IDX-S2
               IF      IDX-S2          >=  IDX-S
                   ADD     1                   TO  IDX
                   IF      IDX                 >   100
                       MOVE    1               TO  SPA-J023-NEXT
                       MOVE    1               TO  FLG-RECECOM
                   ELSE
                       PERFORM 31031-RECECOM-SPAHEN-SEC
                   END-IF
               END-IF
      *
               IF      FLG-RECECOM         =   ZERO
                   MOVE    "RECECOM-KEY2"      TO  ORC-DBPATH
                   PERFORM 920-RECECOM-READ-SEC
               END-IF
           END-PERFORM
           MOVE    "RECECOM-KEY2"      TO  ORC-DBPATH
           PERFORM 990-DBCLOSE-SEC
      *
           MOVE    SPACE               TO  SPA-J023-COMMENT
           MOVE    ZERO                TO  SPA-J023-BUNNUM
           MOVE    SPACE               TO  SPA-J023-HKNCOMBI-G
           MOVE    ZERO                TO  SPA-J023-JYURRKNUM
           INITIALIZE                      SPA-J023-COPY-AREA
           INITIALIZE                      SPA-J023-SELNUM-X
           INITIALIZE                      SPA-J023-SELNUM-G
      *
           .
       3103-RECECOM-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメント編集処理
      *****************************************************************
       31031-RECECOM-SPAHEN-SEC             SECTION.
      *
           MOVE    IDX                 TO  SPA-J023-RECE-MAX
           MOVE    IDX                 TO  SPA-J023-TRENNUM (IDX)
           MOVE    RECECOM-SRYKA       TO  SPA-J023-NSRYKA  (IDX)
           MOVE    RECECOM-SRYYM       TO  SPA-J023-NSRYYM  (IDX)
           MOVE    RECECOM-HKNCOMBI    TO  SPA-J023-NHKNCOMBI(IDX)
           MOVE    RECECOM-COMMENT     TO  SPA-J023-TCOMMENT(IDX)
      *    診療年月
           MOVE    RECECOM-SRYYM       TO  WRK-SYMD(1:6)
           MOVE    "01"                TO  WRK-SYMD(7:2)
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG (1:6)   TO  SPA-J023-TSRYYM (IDX)
      *    診療科
           MOVE    RECECOM-SRYKA       TO  WRK-SRYKA
           PERFORM 810-SRYKA-SET-SEC
           MOVE    WRK-SRYKAMEI        TO  SPA-J023-TSRYKA (IDX)
      *    保険組合せ番号
           MOVE    RECECOM-HKNCOMBI    TO  WRK-HKNCOMBI
           PERFORM 820-HKNCOMBI-SET-SEC
           IF      FLG-HKNCOMBI        =   ZERO
               IF     (RECECOM-SRYYM       >=  COMB-TEKSTYMD(1:6)) AND
                      (RECECOM-SRYYM       <=  COMB-TEKEDYMD(1:6))
                   CONTINUE
               ELSE
                   MOVE    WRK-HKNCOMBIMEI TO  WRK-HKNCOMBIMEI-H
                   MOVE    SPACE           TO  WRK-HKNCOMBIMEI
                   STRING  "※"                DELIMITED  BY  SIZE
                           WRK-HKNCOMBIMEI-H   DELIMITED  BY  "  "
                           INTO                WRK-HKNCOMBIMEI
                   END-STRING
               END-IF
           END-IF
           PERFORM 830-HKNCOMBIMEI-CHK-SEC
           MOVE    WRK-HKNCOMBIMEI     TO  SPA-J023-THKNCOMBI(IDX)
      *    診療日
           IF      RECECOM-SRYDD       =   ZERO
               MOVE    SPACE               TO  SPA-J023-TSRYDD (IDX)
           ELSE
               MOVE    RECECOM-SRYDD       TO  SPA-J023-TSRYDD (IDX)
           END-IF
      *
           .
       31031-RECECOM-SPAHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期編集処理
      *****************************************************************
       314-SYOKI-SEC             SECTION.
      *
           MOVE    ZERO                TO  WRK-HKN-IDX
           MOVE    ZERO                TO  WRK-HKN-IDX1
      *    保険組合せの再編集
           PERFORM 314-SYOKI-HEN-SEC
      *
           INITIALIZE                  SPA-J023-JYURRK-LIST
           MOVE    ZERO                TO  SPA-J023-JYURRKNUM
      *    初期編集
           MOVE    SPA-J023-SRYKA-LIST(01)
                                       TO  SPA-J023-SRYKA-G
      *    保険組合せの初期表示
           IF      WRK-HKN-IDX         =   ZERO
               MOVE    WRK-HKN-IDX1        TO  WRK-HKN-IDX
           END-IF
           IF      WRK-HKN-IDX         =   ZERO
               MOVE    1                   TO  WRK-HKN-IDX
           END-IF
           MOVE    SPA-J023-HKN-LIST (WRK-HKN-IDX)
                                       TO  SPA-J023-HKNCOMBI-G
      *    労災保険区分がアフターケアの時、履歴日を表示する
           MOVE    SPA-J023-RSI-THKNKBN (WRK-HKN-IDX)
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
      *    保険組合せの再編集処理
      *****************************************************************
       314-SYOKI-HEN-SEC             SECTION.
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
           MOVE    SPA-J023-NYUGAIKBN  TO  JYURRK-NYUGAIKBN
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
           MOVE    "JYURRK-KEY13"      TO  ORC-DBPATH
           PERFORM 990-DBCLOSE-SEC
      *
      *    入院の時、入院の保険組合せ編集
           IF      SPA-J023-NYUGAIKBN   =   "1"
               PERFORM 3141-NYUINACCT-SYOKI-SEC
           END-IF
      *
      *    受診のあった保険組合せのみ表示する
           INITIALIZE                  SPA-J023-HKNCOMB-COMB
           MOVE    ZERO                TO  SPA-J023-HKNMAX
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >    WRK-J023-HKNMAX
      *        診療年月がシステム年月以前の時のみ、受診履歴の判定
               IF     (SPA-J023-SRYYMS     <   SPA-SYSYMD(1:6) ) AND
                      (WRK-J023-FLG (IDX)  =   SPACE           )
                   CONTINUE
               ELSE
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
               IF      WRK-J023-FLG  (IDX)  =   "2"
      *            入院の保険組合せを初期表示
                   IF      WRK-HKN-IDX      =   ZERO
                       MOVE    SPA-J023-HKNMAX  TO  WRK-HKN-IDX
                   END-IF
               END-IF
               IF      WRK-J023-FLG  (IDX)  =   "1"
      *            保険組合せを初期表示
                   IF      WRK-HKN-IDX1     =   ZERO
                       MOVE    SPA-J023-HKNMAX  TO  WRK-HKN-IDX1
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       314-SYOKI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院の保険組合せ編集処理
      *****************************************************************
       3141-NYUINACCT-SYOKI-SEC          SECTION.
      *    入院の保険組合せ編集
      *    入院会計を検索する  医療機関、患者ＩＤ、年月
           INITIALIZE                  NYUINACCT-REC.
           MOVE    SPA-HOSPID          TO  NACCT-HOSPID
           MOVE    SPA-GMN-PTID        TO  NACCT-PTID
           MOVE    SPA-J023-SRYYMS     TO  NACCT-SRYYM
      *    保険レコード
           MOVE    "5"                 TO  NACCT-ZAISKBKBN
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "NYUINACCT-KEY17"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "NYUINACCT-KEY17"   TO  ORC-DBPATH
               PERFORM 980-NYUINACCT-READ-SEC
           ELSE
               INITIALIZE                  NYUINACCT-REC
               MOVE    1               TO  FLG-NYUINACCT
           END-IF
      *
           PERFORM UNTIL    FLG-NYUINACCT     =   1
               PERFORM VARYING     IDX1    FROM    1   BY  1
                       UNTIL       IDX1    >   31
                   MOVE    ZERO                TO  WRK-HKNCOMBI
                   MOVE    NACCT-DAY (IDX1)    TO  WRK-HKNCOMBI
                   PERFORM VARYING     IDX     FROM    1   BY  1
                           UNTIL       IDX     >   WRK-J023-HKNMAX
                       IF      WRK-J023-THKNCOMBINUM(IDX)
                                                   =   WRK-HKNCOMBI
                           MOVE    "2"             TO  WRK-J023-FLG(IDX)
                           MOVE    WRK-J023-HKNMAX TO  IDX
                       END-IF
                   END-PERFORM
               END-PERFORM
      *
               MOVE    "NYUINACCT-KEY17"   TO  ORC-DBPATH
               PERFORM 980-NYUINACCT-READ-SEC
           END-PERFORM.
           MOVE    "NYUINACCT-KEY17"   TO  ORC-DBPATH
           PERFORM 990-DBCLOSE-SEC
      *
           .
       3141-NYUINACCT-SYOKI-EXT.
           EXIT.
      *
      *****************************************************************
      *    労災保険区分がアフターケアの時、履歴日編集処理
      *****************************************************************
       31401-AFTER-JYURRK-SEC          SECTION.
      *
      *    受診歴を検索する  医療機関、患者ＩＤ
           INITIALIZE                  JYURRK-REC
           MOVE    SPA-HOSPID          TO  JYURRK-HOSPID
           MOVE    SPA-GMN-PTID        TO  JYURRK-PTID
           MOVE    SPA-J023-NYUGAIKBN  TO  JYURRK-NYUGAIKBN
           MOVE    SPA-J023-SRYKA      TO  JYURRK-SRYKA
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
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           PERFORM 990-DBCLOSE-SEC
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
           MOVE    SPA-J023-NYUGAIKBN  TO  JYURRK-NYUGAIKBN
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
           MOVE    "JYURRK-KEY13"      TO  ORC-DBPATH
           PERFORM 990-DBCLOSE-SEC
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
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           PERFORM 990-DBCLOSE-SEC
           IF      FLG-HKNCOMBI        =   ZERO
               IF      COMB-DELKBN             =   SPACE
                   PERFORM 31011-HKNCOMBI-HEN-SEC
               ELSE
                   MOVE    1                   TO  FLG-HKNCOMBI
                   MOVE    WRK-HKNCOMBI        TO  WRK-HKNCOMBIMEI
               END-IF
           ELSE
               MOVE    SPACE               TO  WRK-HKNCOMBIMEI
               MOVE    WRK-HKNCOMBI        TO  WRK-HKNCOMBIMEI
           END-IF
      *
           .
       820-HKNCOMBI-SET-EXT.
           EXIT.
      *****************************************************************
      *    コメントチェック処理
      *****************************************************************
       830-HKNCOMBIMEI-CHK-SEC                   SECTION.
      *
           INITIALIZE                  ORCXKANACONVAREA
           MOVE    50                  TO  KANACONV-LEN
           MOVE    1000                TO  KANACONV-STLEN
           MOVE    0                   TO  KANACONV-CONV-FLAG
           MOVE    0                   TO  KANACONV-CHAR-TYPE
           MOVE    WRK-HKNCOMBIMEI     TO  KANACONV-INDATA
           CALL    "kanaconv"          USING ORCXKANACONVAREA
           IF     (KANACONV-RETURN     =   ZERO )
               MOVE    KANACONV-OUTDATA
                                       TO  WRK-HKNCOMBIMEI
           ELSE
               MOVE    KANACONV-OUTDATA
                                       TO  WRK-HKNCOMBIMEI
           END-IF
           .
      *
       830-COMMENT-CHK-EXT.
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
      *    コラムリスト位置保存
           IF      FLG-GMN-INIT        =   1
               MOVE    ZERO                TO  WRK-J023-RECE-ROW
           ELSE
               MOVE    J023-RECE-ROW       TO  WRK-J023-RECE-ROW
           END-IF
      *
           MOVE    SPACE               TO  J023
      *
      *    コラムリストの位置指定
           MOVE    ZERO                TO  J023-RECE-ROW
           MOVE    ZERO                TO  J023-RECE-ROWATTR
           IF      WRK-J023-RECE-ROW   NOT =   ZERO
               MOVE    WRK-J023-RECE-ROW   TO  J023-RECE-ROW
           END-IF
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
      *    入外区分
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-J023-NYUGAI-MAX
               MOVE    SPA-J023-NYUGAIKBN-LST(IDX)
                                           TO  J023-NYUGAIKBN-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-J023-NYUGAI-MAX     TO  J023-NYUGAIKBN-COUNT
           MOVE    SPA-J023-NYUGAIKBN-G    TO  J023-NYUGAIKBN
      *
           EVALUATE    SPA-J023-SYORI
               WHEN    0
                   MOVE    SPACE               TO  J023-MIDASI
                   MOVE    SPACE               TO  J023-MIDASI-STYLE
               WHEN    1
               WHEN    5
                   MOVE    "＜変　更＞"        TO  J023-MIDASI
                   MOVE    "red"               TO  J023-MIDASI-STYLE
               WHEN    2
                   MOVE    "＜文　例＞"        TO  J023-MIDASI
                   MOVE    "red"               TO  J023-MIDASI-STYLE
           END-EVALUATE
      *    複写
           MOVE    SPA-J023-COPYYM     TO  J023-COPYSRYYM
           MOVE    SPA-J023-COPYTUKI   TO  J023-COPYTUKI
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
               MOVE    "F"             TO  J023-RECE-SELECT (IDX)
               PERFORM VARYING     IDX2    FROM    1   BY  1
                       UNTIL       IDX2    >   SPA-J023-SELNUM-MAX
                   IF      SPA-J023-SELNUM (IDX2)
                                           =   SPA-J023-TRENNUM (IDX)
                       MOVE    "T"         TO  J023-RECE-SELECT (IDX)
                       MOVE    SPA-J023-SELNUM-MAX TO  IDX2
                   END-IF
               END-PERFORM
           END-PERFORM
           MOVE    SPA-J023-RECE-MAX   TO  J023-RECE-COUNT
      *
           MOVE    SPA-J023-SELNUM-X   TO  J023-SELNUM
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
           IF      SPA-J023-CUR        =   ZERO
               PERFORM 50011-INPUT-CUR-SEC
           END-IF
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
               WHEN    10
                   MOVE    "COPYSRYYM"         TO  MCP-WIDGET
               WHEN    11
                   MOVE    "COPYTUKI"          TO  MCP-WIDGET
               WHEN    12
                   MOVE    "NYUGAIKBN"         TO  MCP-WIDGET
               WHEN    13
                   MOVE    "B03"               TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       50011-INPUT-CUR-SEC          SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
               WHEN    "COPYSRYYM"
                   MOVE    11          TO  SPA-J023-CUR
               WHEN    "COPYTUKI"
                   MOVE    6           TO  SPA-J023-CUR
               WHEN    OTHER
                   MOVE    6           TO  SPA-J023-CUR
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
               WHEN    "CLICKED"       ALSO    "B09"
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
      *        前月 
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 270-BACK-MONTH-SEC
      *        次月 
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 280-NEXT-MONTH-SEC
      *        前頁
               WHEN    "CLICKED"       ALSO    "B06S"
                   PERFORM 290-BACK-PAGE-SEC
      *        次月頁
               WHEN    "CLICKED"       ALSO    "B07S"
                   PERFORM 291-NEXT-PAGE-SEC
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
      *        入外区分
               WHEN    "ACTIVATE"      ALSO    "NYUGAIKBN"
                   PERFORM 410-NYUGAIKBN-SEC
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
                   PERFORM 460-JYURRKLIST-SEC
      *        その他
               WHEN    OTHER
                   PERFORM 490-ENTRY-SYORI-SEC
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
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-GMN-PTID        =   ZERO
                   MOVE    7                   TO  SPA-J023-CUR
               ELSE
                   MOVE    6                   TO  SPA-J023-CUR
               END-IF
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
               GO      TO      400-SRYKA-EXT
           ELSE
               MOVE    3                   TO  SPA-J023-CUR
           END-IF
      *
      *    労災保険区分がアフターケアの時、履歴日を表示する
           IF      SPA-J023-RSI-HKNKBN =   "3"
               PERFORM 31401-AFTER-JYURRK-SEC
               IF      SPA-J023-RRKMAX     =   ZERO
                   MOVE    "0012"              TO  SPA-ERRCD
                   GO      TO      400-SRYKA-EXT
               END-IF
               MOVE    9                   TO  SPA-J023-CUR
           ELSE
               INITIALIZE                  SPA-J023-JYURRK-LIST
               MOVE    ZERO                TO  SPA-J023-RRKMAX
               MOVE    ZERO                TO  SPA-J023-JYURRKNUM
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
      *    入外区分処理
      *****************************************************************
       410-NYUGAIKBN-SEC                 SECTION.
      *
           MOVE    12                  TO  SPA-J023-CUR
      *
           MOVE    J023-NYUGAIKBN      TO  SPA-J023-NYUGAIKBN-G
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-J023-NYUGAI-MAX
               IF      SPA-J023-NYUGAIKBN  =   SPA-J023-NYUGAIKBN-LST
                                                           (IDX)(1:1)
                   MOVE    SPA-J023-NYUGAIKBN-LST (IDX)
                                           TO  SPA-J023-NYUGAIKBN-G
                   MOVE    1               TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    "0002"              TO  SPA-ERRCD
               GO      TO      410-NYUGAIKBN-EXT
           END-IF
      *
      *    保険組合せ
           PERFORM 3101-HKNCOMBI-HEN-SEC
      *
      *     コメント編集編集
           MOVE    ZERO                TO  SPA-J023-NEXT
           MOVE    1                   TO  SPA-J023-PAGE
           PERFORM 3103-RECECOM-HEN-SEC
      *
      *    初期編集
           PERFORM 314-SYOKI-SEC
      *
           .
       410-NYUGAIKBN-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択番号処理
      *****************************************************************
       420-SELNUM-SEC                 SECTION.
      *
           MOVE    4                   TO  SPA-J023-CUR
      *
           MOVE    J023-SELNUM         TO  SPA-J023-SELNUM-X
      *
           IF      SPA-J023-SELNUM-X   =   SPACE
               INITIALIZE                      SPA-J023-SELNUM-G
               GO      TO      420-SELNUM-EXT
           END-IF
      *
           PERFORM 4201-SELNUM-CHK-SEC
      *
           IF     (SPA-ERRCD           =   SPACE )  AND
                  (SPA-J023-SELNUM-MAX =   1     )
               EVALUATE    SPA-J023-SYORI
      *        変更処理
               WHEN    1
               WHEN    5
                   PERFORM 2101-HENKOU-SYORI-SEC
      *        コピー処理
               WHEN    3
                   PERFORM 2501-COPY-SYORI-SEC
      *
               WHEN    OTHER
                   MOVE    8                   TO  SPA-J023-CUR
               END-EVALUATE
           ELSE
               IF      SPA-J023-SELNUM-MAX >   1
                   MOVE    13                  TO  SPA-J023-CUR
               END-IF
           END-IF
           .
       420-SELNUM-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択番号処理
      *****************************************************************
       4201-SELNUM-CHK-SEC                 SECTION.
      *
           INITIALIZE                      WRK-SELNUM-G
           MOVE    ZERO                TO  IDX-D1
           MOVE    ZERO                TO  IDX-D3
           MOVE    1                   TO  IDX-D2
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   40  )   OR
                              (SPA-ERRCD   NOT =   SPACE )
               EVALUATE    SPA-J023-SELNUM-X(IDX:1)
                   WHEN    ","
                   WHEN    "."
                       IF      IDX-D1          >   ZERO
                           ADD     1               TO  IDX-D2
                           MOVE    ZERO            TO  IDX-D1
                           MOVE    ZERO            TO  IDX-D3
                       END-IF
                   WHEN    "0"  THRU  "9" 
                       ADD     1               TO  IDX-D1
                       IF      IDX-D1          >   3
                           MOVE    "0003"          TO  SPA-ERRCD
                       ELSE
                           MOVE    SPA-J023-SELNUM-X(IDX:1)
                                               TO  WRK-TSELNUM-X(IDX-D2)
                                                            (IDX-D1:1)
                       END-IF
                   WHEN    "-"
                       MOVE    "-"             TO  WRK-TSELH(IDX-D2)
                       IF      IDX-D1          >   ZERO
                           ADD     1               TO  IDX-D2
                           MOVE    ZERO            TO  IDX-D1
                           MOVE    ZERO            TO  IDX-D3
                       END-IF
                   WHEN    SPACE
                       CONTINUE
                   WHEN    OTHER
                       MOVE    "0003"          TO  SPA-ERRCD
               END-EVALUATE
           END-PERFORM
      *
           PERFORM VARYING     IDX-D2      FROM    1   BY  1
                   UNTIL      (IDX-D2      >   100  )  OR
                              (WRK-TSELNUM-X(IDX-D2)    =   SPACE  )  OR
                              (SPA-ERRCD   NOT =   SPACE  )
               INITIALIZE                      ORCSNUMAREA
               MOVE    WRK-TSELNUM-X (IDX-D2)  TO  SNUM-INX
               CALL    "ORCSNUM"           USING
                                           ORCSNUMAREA
               IF     (SNUM-RC         NOT =   ZERO  )   OR
                      (SNUM-MINKBN     NOT =   SPACE )   OR
                      (SNUM-SYOKBN     NOT =   SPACE )
                   MOVE    "0003"              TO  SPA-ERRCD
               ELSE
                   MOVE    SNUM-OUTNUM         TO  WRK-TSELNUM(IDX-D2)
                   IF      WRK-TSELNUM (IDX-D2) >=  01  AND
                                               <=  SPA-J023-RECE-MAX
                       CONTINUE
                   ELSE
                       MOVE    "0003"          TO  SPA-ERRCD
                   END-IF
      *
                   IF     (IDX-D2          >   1   )  AND
                          (WRK-TSELH(IDX-D2 - 1 )   =   "-" )
                       IF      WRK-TSELNUM (IDX-D2 - 1)  >
                                                   WRK-TSELNUM(IDX-D2)
                           MOVE    "0003"              TO  SPA-ERRCD
                       END-IF
                   END-IF
               END-IF
           END-PERFORM
      *
           INITIALIZE                      SPA-J023-SELNUM-G
           INITIALIZE                      WRK-SELNUM-AREA
           MOVE    ZERO                TO  IDX
           PERFORM VARYING     IDX-D2      FROM    1   BY  1
                   UNTIL      (IDX-D2      >   100  )  OR
                              (WRK-TSELNUM-X(IDX-D2)
                                               =   SPACE  )  OR
                              (SPA-ERRCD   NOT =   SPACE  )
               IF     (IDX-D2                  >   1   )  AND
                      (WRK-TSELH (IDX-D2 - 1)   =   "-" )
                   COMPUTE IDX-Z           =   WRK-TSELNUM(IDX-D2 - 1)
                                           +   1
                   PERFORM VARYING     IDX2    FROM    IDX-Z  BY  1
                           UNTIL       IDX2    >=  WRK-TSELNUM(IDX-D2)
                       MOVE    1               TO  WRK-SEL (IDX2)
                   END-PERFORM
               END-IF
               MOVE    WRK-TSELNUM(IDX-D2)     TO  IDX2
               MOVE    1                       TO  WRK-SEL (IDX2)
           END-PERFORM
           MOVE    ZERO                TO  IDX
           PERFORM VARYING     IDX-D2  FROM    1   BY  1
                   UNTIL      (IDX-D2  >   100  )  OR
                              (SPA-ERRCD   NOT =   SPACE )
               IF      WRK-SEL (IDX-D2)    =   1
                   ADD     1               TO  IDX
                   IF      IDX             >   12
                       MOVE    "0038"          TO  SPA-ERRCD
                   ELSE
                       MOVE    IDX-D2          TO  SPA-J023-SELNUM(IDX)
                       MOVE    IDX             TO  SPA-J023-SELNUM-MAX
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       4201-SELNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    明細選択処理
      *****************************************************************
       440-RECELIST-SEC                 SECTION.
      *
           MOVE    ZERO                TO  WRK-SELNUM
           MOVE    ZERO                TO  WRK-SELNUM-CHK-G
           MOVE    ZERO                TO  IDX2
      *
           PERFORM VARYING     IDX     FROM   1   BY  1
                   UNTIL       IDX     >   SPA-J023-RECE-MAX
               IF      J023-RECE-SELECT (IDX)   =  "T"
                   ADD     1               TO  IDX2
                   MOVE    SPA-J023-TRENNUM  (IDX)
                                           TO  WRK-SELNUM-CHK (IDX2)
              END-IF
           END-PERFORM
      *
           MOVE    SPACE               TO  WRK-HEN-SELNUM
           PERFORM VARYING     IDX     FROM   1   BY  1
                   UNTIL      (IDX     >   100 )  OR
                              (WRK-SELNUM-CHK (IDX)   =   ZERO) OR
                              (SPA-ERRCD   NOT =   SPACE )
               IF      SPA-J023-SYORI      =   1  OR  3
                                                  OR  5
      *            変更・コピー処理の時、番号置換え
                   IF      SPA-J023-SELNUM (1) =   WRK-SELNUM-CHK (IDX)
                       CONTINUE
                   ELSE
                       MOVE    WRK-SELNUM-CHK (IDX)    TO  WRK-SELNUM
                       PERFORM 4401-SELNUM-CHK-HEN-SEC
                   END-IF
               ELSE
                   MOVE    WRK-SELNUM-CHK (IDX)    TO  WRK-SELNUM
                   PERFORM 4401-SELNUM-CHK-HEN-SEC
               END-IF
           END-PERFORM
      *
           MOVE    WRK-HEN-SELNUM      TO  SPA-J023-SELNUM-X
      *
           IF      SPA-J023-SELNUM-X   =   SPACE
               INITIALIZE                  SPA-J023-SELNUM-G
           ELSE
               PERFORM 4201-SELNUM-CHK-SEC
           END-IF
      *
           IF     (SPA-ERRCD           =   SPACE )  AND
                  (SPA-J023-SELNUM-MAX =   1     )
               EVALUATE    SPA-J023-SYORI
      *        変更処理
               WHEN    1
               WHEN    5
                   PERFORM 2101-HENKOU-SYORI-SEC
      *        コピー処理
               WHEN    3
                   PERFORM 2501-COPY-SYORI-SEC
               WHEN    OTHER
                   MOVE    8                   TO  SPA-J023-CUR
               END-EVALUATE
           ELSE
               MOVE    13                  TO  SPA-J023-CUR
           END-IF
      *
           .
       440-RECELIST-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択番号編集処理
      *****************************************************************
       4401-SELNUM-CHK-HEN-SEC             SECTION.
      *
           MOVE    WRK-SELNUM          TO  WRK-ZZZ
           MOVE    SPACE               TO  WRK-SELNUM-X
           MOVE    ZERO                TO  IDX-D1
           PERFORM VARYING     IDX-D2  FROM    1   BY  1
                   UNTIL       IDX-D2  >   3
               IF      WRK-ZZZ(IDX-D2:1)    NOT =   SPACE
                   ADD     1                    TO  IDX-D1
                   MOVE    WRK-ZZZ(IDX-D2:1) TO  WRK-SELNUM-X(IDX-D1:1)
               END-IF
           END-PERFORM
           COMPUTE IDX-D2              =   40  -  IDX-D1
           IF      WRK-HEN-SELNUM (IDX-D2:)    NOT =   SPACE
               MOVE    "0037"              TO  SPA-ERRCD
               MOVE    SPACE               TO  WRK-SELNUM-X
           END-IF
      *
           MOVE    WRK-HEN-SELNUM      TO  WRK-HEN-SELNUM-2
           MOVE    SPACE               TO  WRK-HEN-SELNUM
           IF      WRK-HEN-SELNUM-2    =   SPACE
               STRING  WRK-SELNUM-X        DELIMITED   BY  SPACE
                       INTO                WRK-HEN-SELNUM
               END-STRING
           ELSE
               IF      WRK-SELNUM-X        =   SPACE
                   MOVE    WRK-HEN-SELNUM-2    TO  WRK-HEN-SELNUM
               ELSE
                   STRING  WRK-HEN-SELNUM-2    DELIMITED   BY  SPACE
                           ","                 DELIMITED   BY  SIZE
                           WRK-SELNUM-X        DELIMITED   BY  SPACE
                           INTO                WRK-HEN-SELNUM
                   END-STRING
               END-IF
           END-IF
      *
           .
       4401-SELNUM-CHK-HEN-EXT.
           EXIT.
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
               CONTINUE
           ELSE
               IF      SPA-J023-JYURRKNUM  >   SPA-J023-RRKMAX
                   MOVE    "0015"              TO  SPA-ERRCD
               ELSE
                   MOVE    6                   TO  SPA-J023-CUR
               END-IF
           END-IF
      *
           .
       450-JYURRKNUM-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    明細選択処理
      *****************************************************************
       460-JYURRKLIST-SEC                 SECTION.
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
       460-JYURRKLIST-EXT.
           EXIT.
      *
      *****************************************************************
      *    その他処理
      *****************************************************************
       490-ENTRY-SYORI-SEC                   SECTION.
      *
      *    入力個所のセット
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           MOVE    ZERO                TO  SPA-J023-CUR
      *
      *    入力チェック処理
           PERFORM 4901-INPUT-CHK-SEC
           .
       490-ENTRY-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェックと別画面処理
      *****************************************************************
       4901-INPUT-CHK-SEC          SECTION.
      *
      *    入力個所のセット
           MOVE    J023-COMMENT        TO  SPA-J023-COMMENT
           MOVE    J023-COPYSRYYM      TO  SPA-J023-COPYYM
           MOVE    J023-COPYTUKI       TO  SPA-J023-COPYTUKI
      *
      *    コメント
           PERFORM 800-COMMENT-CHK-SEC
      *    複写年月
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-J023-COPYYM     =   SPACE
                   MOVE    SPACE           TO  SPA-J023-NAI-COPYYM
               ELSE
                   PERFORM 49011-COPYYM-CHK-SEC
               END-IF
           END-IF
      *    複写月数
           IF      SPA-ERRCD           =   SPACE
               PERFORM 49012-COPYTUKI-CHK-SEC
           END-IF
      *
           .
       4901-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    複写年月チェック処理
      *****************************************************************
       49011-COPYYM-CHK-SEC                   SECTION.
      *
           INITIALIZE                      ORCSGDAYAREA
           MOVE    SPA-J023-COPYYM     TO  SGDAY-INDAY
           MOVE    "1"                 TO  SGDAY-INTYPE
           CALL    "ORCSGDAY"          USING
                                       ORCSGDAYAREA
           IF      SGDAY-RC            =   ZERO
               MOVE    SGDAY-OTDAY(1:6)    TO  SPA-J023-COPYYM
               MOVE    SGDAY-SDAY(1:6)     TO  SPA-J023-NAI-COPYYM
           ELSE
               MOVE    "0030"              TO  SPA-ERRCD
               MOVE    10                  TO  SPA-J023-CUR
           END-IF
      *
           IF      SPA-J023-RSI-HKNKBN =   "3"
               MOVE    "0033"              TO  SPA-ERRCD
               MOVE    10                  TO  SPA-J023-CUR
           END-IF
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-J023-NAI-COPYYM <=  SPA-J023-SRYYMS
                   MOVE    "0034"              TO  SPA-ERRCD
                   MOVE    10                  TO  SPA-J023-CUR
               END-IF
           END-IF
           .
       49011-COPYYM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    複写月数チェック処理
      *****************************************************************
       49012-COPYTUKI-CHK-SEC                   SECTION.
      *
           IF      SPA-J023-COPYTUKI   >   12
               MOVE    "0031"              TO  SPA-ERRCD
               MOVE    11                  TO  SPA-J023-CUR
           ELSE
               IF      SPA-J023-COPYTUKI   >   ZERO
                   IF      SPA-J023-NAI-COPYYM     =   SPACE
                       MOVE    "0032"              TO  SPA-ERRCD
                       MOVE    10                  TO  SPA-J023-CUR
                   END-IF
               END-IF
           END-IF
           .
       49012-COPYTUKI-CHK-EXT.
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
      *    入力チェック処理
           PERFORM 4901-INPUT-CHK-SEC
      *
           IF      SPA-GMN-PTID        =   ZERO
               MOVE    "0011"              TO  SPA-ERRCD
               GO      TO      212-TOUROKU-EXT
           END-IF
      *
           IF     (SPA-J023-HKNCOMBINUM    =   SPACE ) AND
                  (SPA-J023-HKNMAX         =   ZERO  )
               MOVE    "0006"              TO  SPA-ERRCD
           END-IF
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-J023-HKNCOMBINUM    =   SPACE
                   MOVE    "0002"              TO  SPA-ERRCD
               END-IF
           END-IF
      *    アフターケアの時、受診日を選択すること
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-J023-RSI-HKNKBN     =   "3"
                   IF      SPA-J023-JYURRKNUM  =   ZERO
                       MOVE    "0014"              TO  SPA-ERRCD
                       MOVE    9                   TO  SPA-J023-CUR
                   END-IF
               END-IF
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-J023-COMMENT    =   SPACE
                   MOVE    "0007"              TO  SPA-ERRCD
                   MOVE    1                   TO  SPA-J023-CUR
               END-IF
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 2130-HKNCOMBI-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 2120-RECECOM-SEL-SEC
               IF      FLG-RECECOM         =   ZERO
                   MOVE    "0105"              TO  SPA-JIDCD
               ELSE
                   IF      SPA-J023-SYORI      =   5
                       MOVE    "0105"              TO  SPA-JIDCD
                   ELSE
                       MOVE    "0101"              TO  SPA-JIDCD
                   END-IF
               END-IF
      *        複写月
               IF      SPA-J023-COPYYM     NOT =   SPACE
                   IF      FLG-RECECOM         =   ZERO
                       MOVE    "0205"              TO  SPA-JIDCD
                   ELSE
                       MOVE    "0201"              TO  SPA-JIDCD
                   END-IF
               END-IF
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
      *    受診歴を検索する  医療機関、患者ＩＤ
           INITIALIZE                  JYURRK-REC
           MOVE    SPA-HOSPID          TO  JYURRK-HOSPID
           MOVE    SPA-GMN-PTID        TO  JYURRK-PTID
           MOVE    SPA-J023-NYUGAIKBN  TO  JYURRK-NYUGAIKBN
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
           MOVE    "JYURRK-KEY13"      TO  ORC-DBPATH
           PERFORM 990-DBCLOSE-SEC
           IF      FLG-OK              =   ZERO
      *    入院の時、入院の保険組合せ
               IF      SPA-J023-NYUGAIKBN   =   "1"
                   PERFORM 21301-NYUINACCT-CHK-SEC
               END-IF
           END-IF
      *
           IF      FLG-OK              =   ZERO
               IF     (SPA-J023-SRYYMS     <   SPA-SYSYMD(1:6)) OR
                      (SPA-J023-RSI-HKNKBN =   "3"           )
                   MOVE    "0012"          TO  SPA-ERRCD
               END-IF
           END-IF
      *
           .
       2130-HKNCOMBI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院の保険組合せチェック処理
      *****************************************************************
       21301-NYUINACCT-CHK-SEC        SECTION.
           INITIALIZE                  NYUINACCT-REC.
           MOVE    SPA-HOSPID          TO  NACCT-HOSPID
           MOVE    SPA-GMN-PTID        TO  NACCT-PTID
           MOVE    SPA-J023-SRYYMS     TO  NACCT-SRYYM
      *    保険レコード
           MOVE    "5"                 TO  NACCT-ZAISKBKBN
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "NYUINACCT-KEY17"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "NYUINACCT-KEY17"   TO  ORC-DBPATH
               PERFORM 980-NYUINACCT-READ-SEC
           ELSE
               INITIALIZE                  NYUINACCT-REC
               MOVE    1               TO  FLG-NYUINACCT
           END-IF
      *
           PERFORM UNTIL   (FLG-NYUINACCT     =   1 )  OR
                           (FLG-OK            =   1 )
               PERFORM VARYING     IDX1    FROM    1   BY  1
                       UNTIL      (IDX1    >   31   )  OR
                                  (FLG-OK      =   1 )
                   MOVE    ZERO                TO  WRK-HKNCOMBI
                   MOVE    NACCT-DAY (IDX1)    TO  WRK-HKNCOMBI
                   IF      SPA-J023-HKNCOMBINUM
                                               =   WRK-HKNCOMBI
                       MOVE    1                   TO  FLG-OK
                   END-IF
               END-PERFORM
      *
               MOVE    "NYUINACCT-KEY17"   TO  ORC-DBPATH
               PERFORM 980-NYUINACCT-READ-SEC
           END-PERFORM.
           MOVE    "NYUINACCT-KEY17"   TO  ORC-DBPATH
           PERFORM 990-DBCLOSE-SEC
      *
      *
           .
       21301-NYUINACCT-CHK-EXT.
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
           MOVE    SPACE               TO  RECECOM-REC
           INITIALIZE                  RECECOM-REC
           MOVE    SPA-HOSPID          TO  RECECOM-HOSPID
           MOVE    SPA-GMN-PTID        TO  RECECOM-PTID
           MOVE    SPA-J023-NYUGAIKBN  TO  RECECOM-NYUGAIKBN
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
           MOVE    "RECECOM-KEY"       TO  ORC-DBPATH
           PERFORM 990-DBCLOSE-SEC
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
      *    更新日取得
           INITIALIZE                  ORCSMCNDATEAREA
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
      *
           PERFORM 2120-RECECOM-SEL-SEC
           IF      FLG-RECECOM         =   ZERO
      *        更新
               MOVE    SPA-J023-COMMENT    TO  RECECOM-COMMENT
      *
               MOVE    SMCNDATE-YMD        TO  RECECOM-UPYMD
               MOVE    SMCNDATE-HMS        TO  RECECOM-UPHMS
      *
               MOVE    RECECOM-REC         TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "RECECOM-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "J023 RECECOM UPD ERR:" MCP-RC
                           ",KEY:"   RECECOM-KEY    "."
                   MOVE    "0020"              TO  SPA-ERRCD
               END-IF
           ELSE
      *        追加
               MOVE    SPACE               TO  RECECOM-REC
               INITIALIZE                  RECECOM-REC
               MOVE    SPA-HOSPID          TO  RECECOM-HOSPID
               MOVE    SPA-GMN-PTID        TO  RECECOM-PTID
               MOVE    SPA-J023-NYUGAIKBN  TO  RECECOM-NYUGAIKBN
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
               MOVE    SMCNDATE-YMD        TO  RECECOM-CREYMD
               MOVE    SMCNDATE-YMD        TO  RECECOM-UPYMD
               MOVE    SMCNDATE-HMS        TO  RECECOM-UPHMS
      *
      *
               MOVE    RECECOM-REC         TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "RECECOM-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "J023 RECECOM INS ERR:" MCP-RC
                           ",KEY:"   RECECOM-KEY    "."
                   MOVE    "0020"              TO  SPA-ERRCD
               END-IF
           END-IF
      *    変更前の保険組合せが無効の時、削除
           IF     (SPA-ERRCD           =   SPACE )  AND
                  (SPA-J023-SYORI      =   5     )  AND
                  (SPA-J023-SELNUM (1) NOT =   ZERO) AND
                  (SPA-J023-NHKNCOMBI(1)
                                   NOT =   SPA-J023-HKNCOMBINUM)
               MOVE    1               TO  IDX2
               PERFORM 24011-COMMENT-DELETE-SEC
           END-IF
      *    複写処理
           IF     (SPA-ERRCD           =   SPACE ) AND
                  (SPA-J023-COPYYM NOT =   SPACE )  AND
                  (SPA-J023-RSI-HKNKBN NOT =   "3")
               PERFORM 21213-COPY-RECECOME-SEC
           END-IF
      *
      *    レセプト作成管理マスタ更新
           IF      SPA-ERRCD           =   SPACE
               PERFORM 21212-RECEUPD-UPDATE-SEC
           END-IF
      *
      *    再表示
           IF      SPA-ERRCD           =   SPACE
               PERFORM                     310-SPA-SET-SEC
               MOVE    1                   TO  SPA-J023-CUR
           END-IF
      *
           .
       2121-TOUROKU-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    レセコメント複写処理
      *****************************************************************
       21213-COPY-RECECOME-SEC           SECTION.
      *
           MOVE    RECECOM-REC         TO  HZN-RECECOM-REC
      *
           MOVE    RECECOM-HKNCOMBI    TO  WRK-HKNCOMBI
           PERFORM 820-HKNCOMBI-SET-SEC
      *
           MOVE    SPA-J023-NAI-COPYYM TO  WRK-COPYYM
           IF      SPA-J023-COPYTUKI   =   ZERO
               MOVE    1                   TO  SPA-J023-COPYTUKI
           END-IF
           IF     (WRK-COPYYM          >=  COMB-TEKSTYMD(1:6)) AND
                  (WRK-COPYYM          <=  COMB-TEKEDYMD(1:6))
               MOVE    ZERO                TO  FLG-COPY-END
           ELSE
               MOVE    1                   TO  FLG-COPY-END
           END-IF
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   SPA-J023-COPYTUKI )  OR
                              (FLG-COPY-END   =   1    )   OR
                              (SPA-ERRCD  NOT =   SPACE)
      *        複写
               PERFORM 212131-RECECOME-COPY-SEC
      *
               COMPUTE WRK-COPYMM      =   WRK-COPYMM
                                       +   1
               IF      WRK-COPYMM      >   12
                   COMPUTE WRK-COPYYY      =   WRK-COPYYY
                                           +   1
                   MOVE    1               TO  WRK-COPYMM
               END-IF
      *        保険組合せの有効期間外は複写なし
               IF     (WRK-COPYYM          >=  COMB-TEKSTYMD(1:6)) AND
                      (WRK-COPYYM          <=  COMB-TEKEDYMD(1:6))
                   MOVE    ZERO                TO  FLG-COPY-END
               ELSE
                   MOVE    1                   TO  FLG-COPY-END
               END-IF
           END-PERFORM
      *
           .
       21213-COPY-RECECOME-EXT.
           EXIT.
      *****************************************************************
      *    レセコメント複写処理
      *****************************************************************
       212131-RECECOME-COPY-SEC           SECTION.
      *
           MOVE    HZN-RECECOM-REC     TO  RECECOM-REC
           MOVE    WRK-COPYYM          TO  RECECOM-SRYYM
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
           MOVE    "RECECOM-KEY"       TO  ORC-DBPATH
           PERFORM 990-DBCLOSE-SEC
      *
           IF      FLG-RECECOM         =   ZERO
      *        更新
               MOVE    SPA-J023-COMMENT    TO  RECECOM-COMMENT
      *
               MOVE    SMCNDATE-YMD        TO  RECECOM-UPYMD
               MOVE    SMCNDATE-HMS        TO  RECECOM-UPHMS
      *
               MOVE    RECECOM-REC         TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "RECECOM-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "J023 RECECOM UPD ERR:" MCP-RC
                           ",KEY:"   RECECOM-KEY    "."
                   MOVE    "0020"              TO  SPA-ERRCD
               END-IF
           ELSE
      *        追加
               MOVE    HZN-RECECOM-REC     TO  RECECOM-REC
               MOVE    WRK-COPYYM          TO  RECECOM-SRYYM
      *
               MOVE    SMCNDATE-YMD        TO  RECECOM-CREYMD
               MOVE    SMCNDATE-YMD        TO  RECECOM-UPYMD
               MOVE    SMCNDATE-HMS        TO  RECECOM-UPHMS
      *
               MOVE    RECECOM-REC         TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "RECECOM-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "J023 RECECOM INS ERR:" MCP-RC
                           ",KEY:"   RECECOM-KEY    "."
                   MOVE    "0020"              TO  SPA-ERRCD
               END-IF
           END-IF
      *
           .
       212131-RECECOME-COPY-EXT.
           EXIT.
      *****************************************************************
      *    レセプト作成管理マスタ更新処理
      *****************************************************************
        21212-RECEUPD-UPDATE-SEC           SECTION.
      *
           INITIALIZE                      ORCSRECEUPDAREA
           MOVE    "1"                 TO  LNK-UPD-SYORI
           MOVE    SPA-HOSPID          TO  LNK-UPD-HOSPID
           MOVE    SPA-GMN-PTID        TO  LNK-UPD-PTID
           MOVE    SPA-TERMID          TO  LNK-UPD-TERMID
           MOVE    SPA-OPID            TO  LNK-UPD-OPID
           CALL    "ORCSRECEUPD"       USING    ORCSRECEUPDAREA
           IF      LNK-UPD-RC      NOT =   ZERO
               MOVE    "0020"              TO  SPA-ERRCD
               DISPLAY "LNK-UPD-RC =>" LNK-UPD-RC
           END-IF
      *
           .
        21212-RECEUPD-UPDATE-EXT.
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
       800-COMMENT-CHK-SEC             SECTION.
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
      *    出力桁数（全角の最大桁数の指定（省略可））
           MOVE    800                 TO  KANACHK-MAX-CNT
           MOVE    SPA-J023-COMMENT    TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   1     )
      *        全角以外エラー
               MOVE    "0013"          TO  SPA-ERRCD
               IF      KANACHK-RC2         =   7
                   MOVE    KANACHK-OUT-INPUT   TO  SPA-J023-COMMENT
               END-IF
           ELSE
               MOVE    KANACHK-OUT-INPUT   TO  SPA-J023-COMMENT
           END-IF
      *
      ***  INITIALIZE                  ORCXKANACONVAREA
      *    MOVE    800                 TO  KANACONV-LEN
      *    MOVE    1000                TO  KANACONV-STLEN
      *    MOVE    1                   TO  KANACONV-CONV-FLAG
      *    MOVE    15                  TO  KANACONV-CHAR-TYPE
      *    MOVE    SPA-J023-COMMENT    TO  KANACONV-INDATA
      *    CALL    "kanaconv"          USING ORCXKANACONVAREA
      *    IF     (KANACONV-RETURN     =   ZERO )
      *        MOVE    KANACONV-OUTDATA
      *                                TO  SPA-J023-COMMENT
      *    ELSE
      *        MOVE    KANACONV-OUTDATA
      *                                TO  SPA-J023-COMMENT
      *        MOVE    "0013"          TO  SPA-ERRCD
      *****END-IF
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
               MOVE    1                   TO  SPA-J023-CUR
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
           MOVE    "EXAMPLE-KEY"       TO  ORC-DBPATH
           PERFORM 990-DBCLOSE-SEC
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
      *    更新日取得
           INITIALIZE                  ORCSMCNDATEAREA
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
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
               MOVE    "EXAMPLE-KEY2"      TO  ORC-DBPATH
               PERFORM 990-DBCLOSE-SEC
      *
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
               MOVE    SMCNDATE-YMD        TO  EXAMPLE-UPYMD
               MOVE    SMCNDATE-HMS        TO  EXAMPLE-UPHMS
      *
      *
               MOVE    EXAMPLE-REC         TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "EXAMPLE-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "J023 EXAMPLE UPD ERR:" MCP-RC
                           ",KEY:"   EXAMPLE-KEY    "."
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
               MOVE    SMCNDATE-YMD        TO  EXAMPLE-CREYMD
               MOVE    SMCNDATE-YMD        TO  EXAMPLE-UPYMD
               MOVE    SMCNDATE-HMS        TO  EXAMPLE-UPHMS
      *
      *
               MOVE    EXAMPLE-REC         TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "EXAMPLE-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "J023 EXAMPLE INS ERR:" MCP-RC
                           ",KEY:"   EXAMPLE-KEY    "."
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  SPA-J023-COMMENT
           MOVE    SPACE               TO  SPA-J023-SELNUM-X
           MOVE    ZERO                TO  SPA-J023-SELNUM-G
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
           IF      SPA-J023-SELNUM-MAX =   ZERO
               MOVE    4               TO  SPA-J023-CUR
           ELSE
               IF      SPA-J023-SELNUM(1)  =   ZERO
                   MOVE    "0003"              TO  SPA-ERRCD
               ELSE
                   MOVE    "0104"              TO  SPA-JIDCD
               END-IF
           END-IF
           .
       240-COMMENT-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメント削除処理
      *****************************************************************
       2401-COMMENT-DELSYORI-SEC                   SECTION.
      *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL       IDX2    >   SPA-J023-SELNUM-MAX
               IF      SPA-J023-SELNUM (IDX2)  NOT =   ZERO
                   PERFORM 24011-COMMENT-DELETE-SEC
               END-IF
           END-PERFORM
      *
      *    レセプト作成管理マスタ更新
           IF      SPA-ERRCD           =   SPACE
               PERFORM 21212-RECEUPD-UPDATE-SEC
           END-IF
      *
      *    再表示
           PERFORM                     310-SPA-SET-SEC
           .
       2401-COMMENT-DELSYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメント削除処理
      *****************************************************************
       24011-COMMENT-DELETE-SEC                   SECTION.
      *
           MOVE    SPA-J023-SELNUM (IDX2)  TO  IDX
      *
           MOVE    SPACE               TO  RECECOM-REC
           INITIALIZE                  RECECOM-REC
           MOVE    SPA-HOSPID          TO  RECECOM-HOSPID
           MOVE    SPA-GMN-PTID        TO  RECECOM-PTID
           MOVE    SPA-J023-NYUGAIKBN  TO  RECECOM-NYUGAIKBN
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
               DISPLAY "J023 RECECOM DEL ERR:" MCP-RC 
                           ",KEY:"   RECECOM-KEY    "."
           END-IF
      *
           .
       24011-COMMENT-DELETE-EXT.
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
           IF     SPA-J023-SELNUM-MAX  >   1
               MOVE    "0036"              TO  SPA-ERRCD
               GO      TO      210-HENKOU-EXT
           END-IF
      *
           MOVE    1                   TO  SPA-J023-SYORI
           IF      SPA-J023-SELNUM-MAX =   ZERO
               MOVE    4               TO  SPA-J023-CUR
           ELSE
               MOVE    SPA-J023-SELNUM(1)  TO  WRK-SELNUM
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
           MOVE    SPA-J023-TSRYYM  (WRK-SELNUM)
                                       TO  SPA-J023-SRYYM
           MOVE    SPA-J023-NSRYYM  (WRK-SELNUM)
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
           MOVE    SPA-J023-NSRYKA  (WRK-SELNUM)
                                       TO  J023-SRYKA
           PERFORM 400-SRYKA-SEC
           MOVE    SPA-J023-NHKNCOMBI  (WRK-SELNUM)
                                       TO  J023-HKNCOMBI
           PERFORM 410-HKNCOMBI-SEC
           IF      SPA-ERRCD           =   "0002"
               MOVE    "0039"              TO  SPA-ERRCD
               MOVE    3                   TO  SPA-J023-CUR
               MOVE    5                   TO  SPA-J023-SYORI
           END-IF
      *
      *    選択行からレセコメント検索編集
           PERFORM 2103-RECECOM-HEN-SEC
      *
      *    アフターケアの時診療日を選択させる
           IF       SPA-J023-TSRYDD (WRK-SELNUM)       =   "00" OR
                                                           SPACE
               CONTINUE
           ELSE
               PERFORM VARYING     IDX     FROM    1   BY  1
                       UNTIL       IDX     >   SPA-J023-RRKMAX
                   IF      SPA-J023-JYURRKYMD (IDX)(7:2)
                                           =   SPA-J023-TSRYDD
                                                  (WRK-SELNUM)
                       MOVE    IDX             TO  SPA-J023-JYURRKNUM
                       MOVE    SPA-J023-RRKMAX
                                               TO  IDX
                   END-IF
               END-PERFORM
           END-IF
      *
           IF      SPA-ERRCD          =   SPACE
               MOVE    1                   TO  SPA-J023-CUR
           END-IF
           .
       2101-HENKOU-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプトコメント編集処理
      *****************************************************************
       2103-RECECOM-HEN-SEC          SECTION.
      *
           MOVE    SPACE               TO  RECECOM-REC
           INITIALIZE                  RECECOM-REC
           MOVE    SPA-HOSPID          TO  RECECOM-HOSPID
           MOVE    SPA-GMN-PTID        TO  RECECOM-PTID
           MOVE    SPA-J023-NYUGAIKBN  TO  RECECOM-NYUGAIKBN
           MOVE    SPA-J023-NSRYYM  (WRK-SELNUM)
                                       TO  RECECOM-SRYYM
           MOVE    SPA-J023-NSRYKA  (WRK-SELNUM)
                                       TO  RECECOM-SRYKA
           MOVE    SPA-J023-NHKNCOMBI(WRK-SELNUM)
                                       TO  RECECOM-HKNCOMBI
           IF      SPA-J023-TSRYDD  (WRK-SELNUM)   =   SPACE
               MOVE    ZERO            TO  RECECOM-SRYDD
           ELSE
               MOVE    SPA-J023-TSRYDD  (WRK-SELNUM)
                                       TO  RECECOM-SRYDD
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
           MOVE    "RECECOM-KEY"       TO  ORC-DBPATH
           PERFORM 990-DBCLOSE-SEC
      *
           MOVE    RECECOM-COMMENT     TO  SPA-J023-COMMENT
           .
       2103-RECECOM-HEN-EXT.
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
           IF     SPA-J023-SELNUM-MAX  >   1
               MOVE    "0036"              TO  SPA-ERRCD
               GO      TO      250-COPY-EXT
           END-IF
      *
           MOVE    3                   TO  SPA-J023-SYORI
           IF     SPA-J023-SELNUM-MAX  =   ZERO
               MOVE    4               TO  SPA-J023-CUR
           ELSE
               MOVE    SPA-J023-SELNUM(1)  TO  WRK-SELNUM
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
           IF      WRK-SELNUM          =   ZERO
               MOVE   1                TO  WRK-SELNUM
           END-IF
      *    選択行からレセコメント検索編集
           PERFORM 2103-RECECOM-HEN-SEC
      **** MOVE    SPA-J023-TCOMMENT(WRK-SELNUM)
      ****                             TO  SPA-J023-COMMENT
      *
           MOVE    1                   TO  SPA-J023-CUR
           .
       2501-COPY-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    前月分処理
      *****************************************************************
       270-BACK-MONTH-SEC               SECTION.
      *
           IF      SPA-GMN-PTID        =   ZERO
               MOVE    "0011"              TO  SPA-ERRCD
               GO      TO      270-BACK-MONTH-EXT
           END-IF
      *
           INITIALIZE                     STS-AREA-DAY
           INITIALIZE                     LNK-DAY6-AREA
           MOVE    "61"                   TO  LNK-DAY6-IRAI
           MOVE    SPA-J023-SRYYMS        TO  LNK-DAY6-KIJUN (1:6)
           MOVE    "01"                   TO  LNK-DAY6-KIJUN (7:2)
           MOVE    "2"                    TO  LNK-DAY6-ZOGENPTN
           MOVE    -1                     TO  LNK-DAY6-ZOGEN
           CALL    "ORCSDAY"              USING   STS-AREA-DAY
                                                  LNK-DAY6-AREA
           MOVE    LNK-DAY6-KEISAN(1:6)   TO  SPA-J023-SRYYMS
      *
           MOVE    SPA-J023-SRYYMS        TO  WRK-SYMD (1:6)
           MOVE    "01"                   TO  WRK-SYMD (7:2)  
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG (1:6)      TO  SPA-J023-SRYYM
      *
      *     保険組合せ
            PERFORM 3101-HKNCOMBI-HEN-SEC
      *
      *     入院判定
            PERFORM 3105-NYUGAI-HEN-SEC
      *
      *     初期編集
            PERFORM 314-SYOKI-SEC
      *
           .
      *
       270-BACK-MONTH-EXT.
           EXIT.
      *
      *****************************************************************
      *    次月分処理
      *****************************************************************
       280-NEXT-MONTH-SEC               SECTION.
      *
           IF      SPA-GMN-PTID        =   ZERO
               MOVE    "0011"              TO  SPA-ERRCD
               GO      TO      280-NEXT-MONTH-EXT
           END-IF
      * 
      *     次月診療年月         
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY6-AREA
           MOVE    "61"                TO  LNK-DAY6-IRAI
           MOVE    SPA-J023-SRYYMS     TO  LNK-DAY6-KIJUN (1:6)
           MOVE    "01"                TO  LNK-DAY6-KIJUN (7:2)  
           MOVE    "2"                 TO  LNK-DAY6-ZOGENPTN
           MOVE    1                   TO  LNK-DAY6-ZOGEN
           CALL    "ORCSDAY"           USING
                                           STS-AREA-DAY
                                           LNK-DAY6-AREA
           MOVE    LNK-DAY6-KEISAN(1:6)
                                       TO  SPA-J023-SRYYMS
      * 
           MOVE    SPA-J023-SRYYMS     TO  WRK-SYMD (1:6)
           MOVE    "01"                TO  WRK-SYMD (7:2)
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG (1:6)   TO  SPA-J023-SRYYM
      *
      *     保険組合せ
            PERFORM 3101-HKNCOMBI-HEN-SEC
      *
      *     入院判定
            PERFORM 3105-NYUGAI-HEN-SEC
      *
      *     初期編集
            PERFORM 314-SYOKI-SEC
           .
      *
       280-NEXT-MONTH-EXT.
           EXIT.
      *
      *****************************************************************
      *    前頁処理
      *****************************************************************
       290-BACK-PAGE-SEC               SECTION.
      *
           IF      SPA-J023-PAGE       >   1
               COMPUTE SPA-J023-PAGE       =   SPA-J023-PAGE
                                           -   1
      *        コメント編集編集
               PERFORM 3103-RECECOM-HEN-SEC
            END-IF
           .
      *
       290-BACK-PAGE-EXT.
           EXIT.
      *
      *****************************************************************
      *    次頁処理
      *****************************************************************
       291-NEXT-PAGE-SEC               SECTION.
      *
           IF      SPA-J023-NEXT       =   1
               COMPUTE SPA-J023-PAGE       =   SPA-J023-PAGE
                                           +   1
      *        コメント編集編集
               PERFORM 3103-RECECOM-HEN-SEC
            END-IF
           .
      *
       291-NEXT-PAGE-EXT.
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
               WHEN    "0036"
                   MOVE    "選択番号が複数選択されています。"
                                       TO  SPA-ERRMSG
                   MOVE    "削除のみ可能です。"
                                       TO  SPA-ERRMSG(31:)
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
               WHEN    "0030"
                   MOVE    "複写開始年月暦日エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0031"
                   MOVE    "複写月数は１２までです。"
                                       TO  SPA-ERRMSG
               WHEN    "0032"
                   MOVE    "複写開始年月が未入力です。"
                                       TO  SPA-ERRMSG
               WHEN    "0032"
                   MOVE    "複写開始年月が未入力です。"
                                       TO  SPA-ERRMSG
               WHEN    "0033"
                   MOVE    "アフターケアは複写できません。"
                                       TO  SPA-ERRMSG
               WHEN    "0034"
                   MOVE    "複写開始年月＞診療年月で入力して下さい。"
                                       TO  SPA-ERRMSG
               WHEN    "0035"
                   MOVE    "複数選択は削除のみ有効です。"
                                       TO  SPA-ERRMSG
               WHEN    "0037"
                   MOVE    "これ以上選択できません。削除して下さい。"
                                       TO  SPA-ERRMSG
               WHEN    "0038"
                   MOVE    "複数選択は１２行までです。削除して下さい。"
                                       TO  SPA-ERRMSG
               WHEN    "0039"
                   MOVE    "保険組合せでの受診履歴がありません。"
                                       TO  SPA-ERRMSG
                   MOVE    "保険組合せを選択し直して下さい。"
                                       TO  SPA-ERRMSG(37:)
               WHEN    "0020"
                   MOVE    "更新エラーです。"
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
               WHEN    "0201"
                   MOVE    "診療年月のレセプトコメントの登録と、"
                                       TO  WRK-JIDMSG
                   MOVE    "複写月数分のコメントの複写をします。"
                                       TO  WRK-JIDMSG(37:)
               WHEN    "0205"
                   MOVE    "選択されているコメントの変更と、"
                                       TO  WRK-JIDMSG
                   MOVE    "複写月数分のコメントの複写をします。"
                                       TO  WRK-JIDMSG(33:)
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
      *    システム管理マスタ読み込み処理
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-SYSKANRI-READ-EXT.
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
      *****************************************************************
      *    入院会計読み込み
      *****************************************************************
       980-NYUINACCT-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  NYUINACCT-REC
               MOVE    ZERO            TO  FLG-NYUINACCT
           ELSE
               INITIALIZE                  NYUINACCT-REC
               MOVE    1               TO  FLG-NYUINACCT
           END-IF
      *
           .
       980-NYUINACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＣＬＯＳＥ処理
      *****************************************************************
       990-DBCLOSE-SEC             SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       990-DBCLOSE-EXT.
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
