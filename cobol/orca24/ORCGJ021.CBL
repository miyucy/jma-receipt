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
       PROGRAM-ID.                 ORCGJ021.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 会計照会
      *  コンポーネント名  : 保険組合せ変更（Ｊ０２１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/09/24    NACL−多々納  新規作成
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
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01).
           03  FLG-SRYACCT         PIC 9(01).
           03  FLG-SANTEI          PIC 9(01).
           03  FLG-JYURRK          PIC 9(01).
           03  FLG-SYUNOU          PIC 9(01).
      *
           03  FLG-HKNCOMBICHK     PIC 9(01).
           03  FLG-OK              PIC 9(01).
           03  FLG-ATO-ROUJIN      PIC 9(01).
           03  FLG-MAE-ROUJIN      PIC 9(01).
           03  FLG-KOUSIN          PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *
           03  WRK-PTFTNRATE       PIC 9(03).
           03  WRK-HKNCOMBI        PIC 9(04).
           03  WRK-HKNCOMBIMEI     PIC X(100).
           03  WRK-HKNKBN-MEI      PIC X(02).
      *
           03  WRK-SRYKA           PIC X(02).
           03  WRK-SRYKAMEI        PIC X(20).
      *
      *
           03  WRK-ZZZ             PIC ZZZ.
           03  WRK-ZZ              PIC ZZ.
      *
           03  WRK-DBPATH          PIC X(20).
           03  WRK-MCP-WIDGET      PIC X(64).
      *
           03  WRK-JIDMSG          PIC X(80).
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
      *    受診履歴
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *    診療会計マスタ−
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    算定履歴
       01  SANTEI-REC.
           COPY    "CPSANTEI.INC".
      *
      *    収納マスタ
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
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
      *    保険算定年齢パラメタ
           COPY    "CPORCSAGECHK.INC".
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
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
      *    終了フラグのある時、終了とする
           IF      SPA-J021-ENDFLG    =   1
               PERFORM 210-BACK
               GO      TO      100-INIT-EXT
           END-IF
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
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
               IF      FLG-END         =   1
                   GO      TO      100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE   "NEW"                TO  MCP-PUTTYPE.
           MOVE   "J021"               TO  MCP-WINDOW.
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
           EVALUATE    SPA-MOTOPG(1:4)
               WHEN    "JID1"
                   PERFORM 3003-JID1-SET-SEC
                   MOVE    SPACE           TO  SPA-JIDCD
                   GO      TO      300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM                     310-SPA-SET-SEC
      *
           MOVE    1                   TO  SPA-J021-CUR
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
      *            変更の確認
                   IF      SPA-JID1-FLG        =   "OK"
                       PERFORM 30031-HENKOU-SYORI-SEC
                   ELSE
                       MOVE    1                   TO  SPA-J021-CUR
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
           INITIALIZE                  SPA-J021-AREA
      *
      *     保険組合せ
            PERFORM 3101-HKNCOMBI-HEN-SEC
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
           INITIALIZE                  SPA-J021-TBL
           MOVE    ZERO                TO  SPA-J021-MAX
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
                   IF      (SPA-NAI-SRYYM  >=  COMB-TEKSTYMD(1:6)) AND
                           (SPA-NAI-SRYYM  <=  COMB-TEKEDYMD(1:6))
                       MOVE    1                   TO  FLG-HKNCOMBICHK
                   END-IF
               END-IF
      *        労災・自賠責は対象外
               IF      COMB-HKNNUM         =   "971"  OR
                                               "973"
                  MOVE    ZERO                 TO  FLG-HKNCOMBICHK
               END-IF
      *
               IF      FLG-HKNCOMBICHK    =    1
                   ADD     1                   TO  SPA-J021-MAX
                   MOVE    COMB-HKNCOMBINUM    TO  SPA-J021-THKNCOMBI
                                                    (SPA-J021-MAX)
                   MOVE    COMB-TEKSTYMD       TO  SPA-NAI-TEKSTYMD
                                                    (SPA-J021-MAX)
                   MOVE    COMB-TEKEDYMD       TO  SPA-NAI-TEKEDYMD
                                                    (SPA-J021-MAX)
      *            老人判定
                   IF    ((COMB-KOH1HKNNUM     =   "027"  )  OR
                          (COMB-KOH2HKNNUM     =   "027"  )  OR
                          (COMB-KOH3HKNNUM     =   "027"  )  OR
                          (COMB-KOH4HKNNUM     =   "027"  ) )  OR
                         ( SPA-J02-ROUJIN      =   1        )
                       MOVE    1               TO  SPA-NAI-TROUJIN
                                                      (SPA-J021-MAX)
                   END-IF
      *
      *            保険算定年齢チェック等
                   INITIALIZE                  ORCSAGECHKAREA
                   MOVE    SPA-HOSPID          TO  AGECHK-HOSPID
                   MOVE    SPA-GMN-PTID        TO  AGECHK-PTID
                   MOVE    SPA-NAI-SRYYM       TO  AGECHK-SRYYMD(1:6)
                   MOVE    "01"                TO  AGECHK-SRYYMD(7:2)
                   MOVE    SPA-BIRTHDAY        TO  AGECHK-BIRTHDAY
                   MOVE    COMB-HKNCOMBINUM    TO  AGECHK-HKNCOMBINUM
                   CALL    "ORCSAGECHK"        USING
                                                ORCSAGECHKAREA
                   IF      AGECHK-FTNRATE  NOT =   ZERO
      *                負担率
                       MOVE    AGECHK-FTNRATE      TO  SPA-NAI-FTNWARI
                                                         (SPA-J021-MAX)
                       MOVE    AGECHK-FTNRATEMEI   TO  SPA-J021-TFTNRATE
                                                         (SPA-J021-MAX)
                   END-IF
                   MOVE    COMB-TEKSTYMD       TO  WRK-SYMD
                   PERFORM 800-SEIWA-HEN-SEC
                   MOVE    WRK-HENYMDG         TO  SPA-J021-TTEKSTYMD
                                                        (SPA-J021-MAX)
      *
                   MOVE    COMB-TEKEDYMD       TO  WRK-SYMD
                   PERFORM 800-SEIWA-HEN-SEC
                   MOVE    WRK-HENYMDG         TO  SPA-J021-TTEKEDYMD
                                                         (SPA-J021-MAX)
                   PERFORM 31011-HKNCOMBI-HEN-SEC
                   MOVE    WRK-HKNCOMBIMEI     TO  SPA-J021-THKNCOMBIMEI
                                                         (SPA-J021-MAX)
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
           .
       31011-HKNCOMBI-HEN-EXT.
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
           MOVE    SPACE               TO  J021
      *
      *    画面編集
           IF      SPA-J021-MAE-HKNCOMBI   =   ZERO
               CONTINUE
           ELSE
               MOVE    SPA-J021-MAE-HKNCOMBI   TO  J021-MAE-HKNCOMBI
           END-IF
           MOVE    SPA-J021-MAE-HKNCOMBIMEI 
                                           TO  J021-MAE-HKNCOMBIMEI
           MOVE    SPA-J021-MAE-FTNRATE    TO  J021-MAE-FTNRATE
           IF      SPA-J021-ATO-HKNCOMBI   =   ZERO
               CONTINUE
           ELSE
               MOVE    SPA-J021-ATO-HKNCOMBI   TO  J021-ATO-HKNCOMBI
           END-IF
           MOVE    SPA-J021-ATO-HKNCOMBIMEI 
                                           TO  J021-ATO-HKNCOMBIMEI
           MOVE    SPA-J021-ATO-FTNRATE    TO  J021-ATO-FTNRATE
      *
      *    保険組合せ
           PERFORM VARYING   IDX       FROM    1   BY  1
                   UNTIL     IDX       >   SPA-J021-MAX
               MOVE    SPA-J021-THKNCOMBI (IDX) TO  J021-NUM     (IDX)
               MOVE    SPA-J021-THKNCOMBIMEI (IDX)
                                                TO  J021-HKNKUMI (IDX)
               MOVE    SPA-J021-TTEKSTYMD (IDX) TO  J021-TEKSTYMD(IDX)
               MOVE    SPA-J021-TTEKEDYMD (IDX) TO  J021-TEKEDYMD(IDX)
               MOVE    SPA-J021-TFTNRATE  (IDX) TO  J021-FTNRATE (IDX)
           END-PERFORM
           MOVE    SPA-J021-MAX        TO  J021-HKNLIST-COUNT
      *
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
           IF      SPA-J021-CUR        =   ZERO
               EVALUATE    WRK-MCP-WIDGET
                   WHEN    "MAE_HKNCOMBI"
                       MOVE    2           TO  SPA-J021-CUR
                   WHEN    "ATO_HKNCOMBI"
                       MOVE    3           TO  SPA-J021-CUR
                   WHEN    OTHER
                       MOVE    1           TO  SPA-J021-CUR
               END-EVALUATE
           END-IF
      *
           EVALUATE    SPA-J021-CUR
               WHEN    1
                   MOVE    "MAE_HKNCOMBI"      TO  MCP-WIDGET
               WHEN    2
                   MOVE    "ATO_HKNCOMBI"      TO  MCP-WIDGET
               WHEN    3
                   MOVE    "B12"               TO  MCP-WIDGET
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
      *    入力個所のセット
           PERFORM 210-GMN-INPUT-SEC
      *
           MOVE    ZERO                TO  FLG-KOUSIN
      *    入力チェック処理
           PERFORM 220-INPUT-CHK-SEC
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       210-GMN-INPUT-SEC               SECTION.
      *
           MOVE    ZERO                TO  SPA-J021-CUR
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
      *
      *    入力項目の決定
           PERFORM 2001-INPUT-SET-SEC
      *    画面をＳＰＡへ編集
           PERFORM 2002-GMNSPA-SET-SEC
      *
           .
       210-GMN-INPUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力項目の決定
      *****************************************************************
       2001-INPUT-SET-SEC               SECTION.
      *
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        保険組合せ
               WHEN    ANY             ALSO    "HKNLIST"
                   PERFORM 410-HKNCOMBI-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せ処理
      *****************************************************************
       410-HKNCOMBI-SEC               SECTION.
      *
           MOVE    ZERO                TO  WRK-HKNCOMBI
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-J021-MAX
               IF      J021-HKNLIST-SELECT (IDX)   =  "T"
                   MOVE    SPA-J021-THKNCOMBI  (IDX)  TO  WRK-HKNCOMBI
               END-IF
           END-PERFORM
           IF      WRK-HKNCOMBI    NOT =   ZERO
               IF      SPA-J021-MAE-HKNCOMBI   =   SPACE  OR  ZERO
                   MOVE    WRK-HKNCOMBI        TO  SPA-J021-MAE-HKNCOMBI
                   MOVE    WRK-HKNCOMBI        TO  J021-MAE-HKNCOMBI
                   MOVE    "MAE_HKNCOMBI"      TO  WRK-MCP-WIDGET
               ELSE
                   IF      SPA-J021-ATO-HKNCOMBI   =   SPACE OR  ZERO
                       MOVE    WRK-HKNCOMBI    TO  SPA-J021-ATO-HKNCOMBI
                       MOVE    WRK-HKNCOMBI    TO  J021-ATO-HKNCOMBI
                       MOVE    "ATO_HKNCOMBI"  TO  WRK-MCP-WIDGET
                   END-IF
               END-IF
           END-IF
      *
      *
           .
       410-HKNCOMBI-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面項目→ＳＰＡ編集処理
      *****************************************************************
       2002-GMNSPA-SET-SEC               SECTION.
      *
           MOVE    J021-MAE-HKNCOMBI   TO  SPA-J021-MAE-HKNCOMBI
           MOVE    J021-ATO-HKNCOMBI   TO  SPA-J021-ATO-HKNCOMBI
      *
           .
       2002-GMNSPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       220-INPUT-CHK-SEC               SECTION.
      *
      *    前保険組合せ
           PERFORM 4001-MAE-HKNCOMBI-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      220-INPUT-CHK-EXT
           END-IF
      *    後保険組合せ
           PERFORM 4002-ATO-HKNCOMBI-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      220-INPUT-CHK-EXT
           END-IF
      *    登録時
           IF      FLG-KOUSIN          =   1
               PERFORM 4003-KANREI-CHK-SEC
           END-IF
      *
      *
           .
       220-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    前保険組合せチェック処理
      *****************************************************************
       4001-MAE-HKNCOMBI-SEC               SECTION.
      *
           IF      SPA-J021-MAE-HKNCOMBI   =   SPACE
               MOVE    SPACE               TO  SPA-J021-MAE-HKNCOMBIMEI
               MOVE    SPACE               TO  SPA-J021-MAE-FTNRATE
               GO      TO      4001-MAE-HKNCOMBI-EXT
           END-IF
      *
           INITIALIZE                      ORCSNUMAREA
           MOVE    SPA-J021-MAE-HKNCOMBI
                                       TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-MINKBN     NOT =   SPACE )   OR
                  (SNUM-SYOKBN     NOT =   SPACE )
               MOVE    "0001"              TO  SPA-ERRCD
               MOVE    1                   TO  SPA-J021-CUR
               GO      TO      4001-MAE-HKNCOMBI-EXT
           ELSE
               MOVE    SNUM-OUTEDT(12:4)   TO  SPA-J021-MAE-HKNCOMBI
           END-IF
      *
           MOVE    ZERO                TO  FLG-OK
           MOVE    ZERO                TO  FLG-MAE-ROUJIN
           PERFORM VARYING    IDX      FROM    1   BY  1
                   UNTIL      IDX      >   SPA-J021-MAX
               IF      SPA-J021-MAE-HKNCOMBI   =
                                           SPA-J021-THKNCOMBI (IDX)
                   MOVE    SPA-J021-THKNCOMBIMEI  (IDX)
                                           TO  SPA-J021-MAE-HKNCOMBIMEI
                   MOVE    SPA-J021-TFTNRATE (IDX)
                                           TO  SPA-J021-MAE-FTNRATE
                   MOVE    SPA-NAI-TROUJIN (IDX)
                                           TO  FLG-MAE-ROUJIN
                   MOVE    1               TO  FLG-OK
               END-IF
           END-PERFORM
      **   IF      FLG-OK              =   ZERO
      *        MOVE    "0001"              TO  SPA-ERRCD
      *        MOVE    1                   TO  SPA-J021-CUR
      *        GO      TO      4001-MAE-HKNCOMBI-EXT
      ***  END-IF
      *
      *    受診履歴が存在すること
           INITIALIZE                  JYURRK-REC
           MOVE    SPA-HOSPID          TO  JYURRK-HOSPID
           MOVE    SPA-GMN-PTID        TO  JYURRK-PTID
           MOVE    SPA-NYUGAIKBN       TO  JYURRK-NYUGAIKBN
           MOVE    SPA-J01-SRYKA       TO  JYURRK-SRYKA
           MOVE    SPA-J021-MAE-HKNCOMBI
                                       TO  JYURRK-HKNCOMBINUM
           MOVE    SPA-NAI-SRYYM       TO  JYURRK-SRYYMD(1:6)
           MOVE    "01"                TO  JYURRK-SRYYMD(7:2)
           MOVE    SPA-NAI-SRYYM       TO  JYURRK-UPSRYYMD(1:6)
           MOVE    "31"                TO  JYURRK-UPSRYYMD(7:2)
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "JYURRK-KEY18"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "JYURRK-KEY18"      TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           IF      FLG-JYURRK          =   1
               MOVE    "0002"              TO  SPA-ERRCD
               MOVE    1                   TO  SPA-J021-CUR
               GO      TO      4001-MAE-HKNCOMBI-EXT
           END-IF
           IF      FLG-OK              =   ZERO
      *        今回対象外の時、保険組合せより保険を判定する
               PERFORM 40012-MAE-HKNCHK-SEC
           END-IF
      *
           .
       4001-MAE-HKNCOMBI-EXT.
           EXIT.
      *
      *****************************************************************
      *    後保険組合せチェック処理
      *****************************************************************
       40012-MAE-HKNCHK-SEC               SECTION.
      *
      *
      *    保険組合検索
           MOVE    SPACE               TO  HKNCOMBI-REC
           INITIALIZE                  HKNCOMBI-REC
           MOVE    SPA-HOSPID          TO  COMB-HOSPID
           MOVE    SPA-GMN-PTID        TO  COMB-PTID
           MOVE    SPA-J021-MAE-HKNCOMBI
                                       TO  COMB-HKNCOMBINUM
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
           IF      FLG-HKNCOMBI        =   1
               MOVE    "0001"              TO  SPA-ERRCD
               MOVE    1                   TO  SPA-J021-CUR
               GO      TO      40012-MAE-HKNCHK-EXT
           END-IF
      *    労災・自賠責は対象外
           IF      COMB-HKNNUM         =   "971"  OR
                                           "973"
               MOVE    "0001"              TO  SPA-ERRCD
               MOVE    1                   TO  SPA-J021-CUR
               GO      TO      40012-MAE-HKNCHK-EXT
           END-IF
      *
           PERFORM 31011-HKNCOMBI-HEN-SEC
           MOVE    WRK-HKNCOMBIMEI     TO  SPA-J021-MAE-HKNCOMBIMEI
           IF      COMB-DELKBN         =   "1"
               MOVE    SPACE               TO  SPA-J021-MAE-HKNCOMBIMEI
               STRING  "（削除）"          DELIMITED  BY  SIZE
                       WRK-HKNCOMBIMEI     DELIMITED  BY  SIZE
                                       INTO    SPA-J021-MAE-HKNCOMBIMEI
               END-STRING
           END-IF
           IF      COMB-GAI-KFTNRATE   >   ZERO
               MOVE    COMB-GAI-KFTNRATE   TO  WRK-ZZZ
               MOVE    WRK-ZZZ             TO  SPA-J021-MAE-FTNRATE
               MOVE    "%"                 TO  SPA-J021-MAE-FTNRATE(4:)
           END-IF
      *
      *    老人判定
           IF    ((COMB-KOH1HKNNUM     =   "027"  )  OR
                  (COMB-KOH2HKNNUM     =   "027"  )  OR
                  (COMB-KOH3HKNNUM     =   "027"  )  OR
                  (COMB-KOH4HKNNUM     =   "027"  ) )  OR
                  ( SPA-J02-ROUJIN     =   1        )
               MOVE    1               TO  FLG-MAE-ROUJIN
           END-IF
      *
           .
       40012-MAE-HKNCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    後保険組合せチェック処理
      *****************************************************************
       4002-ATO-HKNCOMBI-SEC               SECTION.
      *
           IF      SPA-J021-ATO-HKNCOMBI   =   SPACE
               MOVE    SPACE               TO  SPA-J021-ATO-HKNCOMBIMEI
               MOVE    SPACE               TO  SPA-J021-ATO-FTNRATE
               GO      TO      4002-ATO-HKNCOMBI-EXT
           END-IF
      *
           INITIALIZE                      ORCSNUMAREA
           MOVE    SPA-J021-ATO-HKNCOMBI
                                       TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-MINKBN     NOT =   SPACE )   OR
                  (SNUM-SYOKBN     NOT =   SPACE )
               MOVE    "0003"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-J021-CUR
               GO      TO      4002-ATO-HKNCOMBI-EXT
           ELSE
               MOVE    SNUM-OUTEDT(12:4)   TO  SPA-J021-ATO-HKNCOMBI
           END-IF
      *
           MOVE    ZERO                TO  FLG-ATO-ROUJIN
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING    IDX      FROM    1   BY  1
                   UNTIL     (IDX          >   SPA-J021-MAX)  OR
                             (FLG-OK       =   1    )
               IF      SPA-J021-ATO-HKNCOMBI   =
                                           SPA-J021-THKNCOMBI (IDX)
                   MOVE    SPA-J021-THKNCOMBIMEI  (IDX)
                                           TO  SPA-J021-ATO-HKNCOMBIMEI
                   MOVE    SPA-J021-TFTNRATE (IDX)
                                           TO  SPA-J021-ATO-FTNRATE
                   MOVE    SPA-NAI-TROUJIN (IDX)
                                           TO  FLG-ATO-ROUJIN
      *
                   IF     (SPA-NAI-TEKSTYMD (IDX)(1:6)
                                           <=  SPA-NAI-SRYYM  )  AND
                          (SPA-NAI-TEKEDYMD (IDX)(1:6)
                                           >=  SPA-NAI-SRYYM  )
                       CONTINUE
                   ELSE
                       MOVE    "0008"              TO  SPA-ERRCD
                   END-IF
                   MOVE    1               TO  FLG-OK
               END-IF
           END-PERFORM
           IF      SPA-ERRCD       NOT =   SPACE
               MOVE    2                   TO  SPA-J021-CUR
               GO      TO      4002-ATO-HKNCOMBI-EXT
           END-IF
           IF      FLG-OK              =   ZERO
               MOVE    "0003"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-J021-CUR
               GO      TO      4002-ATO-HKNCOMBI-EXT
           END-IF
      *
           IF      FLG-ATO-ROUJIN      NOT =   ZERO
               IF     (FLG-MAE-ROUJIN      =   FLG-ATO-ROUJIN )  OR
                      (SPA-J02-ROUJIN      =   1              )
                   CONTINUE
               ELSE
                   MOVE    "0004"              TO  SPA-ERRCD
                   MOVE    2                   TO  SPA-J021-CUR
                   GO      TO      4002-ATO-HKNCOMBI-EXT
               END-IF
           END-IF
           .
       4002-ATO-HKNCOMBI-EXT.
           EXIT.
      *
      *****************************************************************
      *    関連チェック処理
      *****************************************************************
       4003-KANREI-CHK-SEC                    SECTION.
      *
           IF      SPA-J021-MAE-HKNCOMBI   =   SPACE  OR  ZERO
               MOVE    "0005"              TO  SPA-ERRCD
               MOVE    1                   TO  SPA-J021-CUR
               GO      TO      4003-KANREI-CHK-EXT
           END-IF
      *
      *
           IF      SPA-J021-ATO-HKNCOMBI   =   SPACE  OR  ZERO
               MOVE    "0006"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-J021-CUR
               GO      TO      4003-KANREI-CHK-EXT
           END-IF
      *
           IF      SPA-J021-ATO-HKNCOMBI   =   SPA-J021-MAE-HKNCOMBI
               MOVE    "0007"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-J021-CUR
               GO      TO      4003-KANREI-CHK-EXT
           END-IF
      *
           .
       4003-KANREI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    クリア　処理
      *****************************************************************
       220-CLEA-SEC                   SECTION.
      *
           PERFORM                     310-SPA-SET-SEC
      *
           MOVE    1                  TO  SPA-J021-CUR
           .
       220-CLEA-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録　処理
      *****************************************************************
       212-TOUROKU-SEC                   SECTION.
      *
           MOVE    ZERO                TO  SPA-J021-CUR
           MOVE    SPACE               TO  WRK-MCP-WIDGET
      *    画面をＳＰＡへ編集
           PERFORM 2002-GMNSPA-SET-SEC
      *
           MOVE    1                   TO  FLG-KOUSIN
      *    入力チェック処理
           PERFORM 220-INPUT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      212-TOUROKU-EXT
           END-IF
      *
           MOVE    "0101"              TO  SPA-JIDCD
      *
           .
       212-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せ一括変更処理
      *****************************************************************
       30031-HENKOU-SYORI-SEC          SECTION.
      *
      *    保険組合検索
           MOVE    SPACE               TO  HKNCOMBI-REC
           INITIALIZE                  HKNCOMBI-REC
           MOVE    SPA-HOSPID          TO  COMB-HOSPID
           MOVE    SPA-GMN-PTID        TO  COMB-PTID
           MOVE    SPA-J021-ATO-HKNCOMBI
                                       TO  COMB-HKNCOMBINUM
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
           IF      FLG-HKNCOMBI        =   1
               MOVE    "0003"              TO  SPA-ERRCD
               GO      TO      30031-HENKOU-SYORI-EXT
           END-IF
      *    負担率
      *    保険算定年齢チェック等
           MOVE    COMB-GAI-KFTNRATE   TO  WRK-PTFTNRATE
           INITIALIZE                  ORCSAGECHKAREA
           MOVE    SPA-HOSPID          TO  AGECHK-HOSPID
           MOVE    SPA-GMN-PTID        TO  AGECHK-PTID
           MOVE    SPA-NAI-SRYYM       TO  AGECHK-SRYYMD(1:6)
           MOVE    "01"                TO  AGECHK-SRYYMD(7:2)
           MOVE    SPA-BIRTHDAY        TO  AGECHK-BIRTHDAY
           MOVE    SPA-J021-ATO-HKNCOMBI
                                       TO  AGECHK-HKNCOMBINUM
           CALL    "ORCSAGECHK"        USING
                                       ORCSAGECHKAREA
           IF      AGECHK-FTNRATE  NOT =   ZERO
               MOVE    AGECHK-FTNRATE      TO  WRK-PTFTNRATE
           END-IF
      *
      *    受診履歴
           PERFORM 300311-JYURRK-UPD-SEC
      *
      *    診療会計
           PERFORM 300312-SRYACCT-UPD-SEC
      *
      *    算定履歴
           PERFORM 300314-SANTEI-UPD-SEC
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    1               TO  SPA-J021-ENDFLG
      *        処理終了のメッセージを表示する
               MOVE    "0010"          TO  SPA-ERRCD
               PERFORM 510-ERRSET-SEC
           END-IF
           .
       30031-HENKOU-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴変更処理
      *****************************************************************
       300311-JYURRK-UPD-SEC          SECTION.
      *
      *    受診履歴
           INITIALIZE                  JYURRK-REC
           MOVE    SPA-HOSPID          TO  JYURRK-HOSPID
           MOVE    SPA-GMN-PTID        TO  JYURRK-PTID
           MOVE    SPA-NYUGAIKBN       TO  JYURRK-NYUGAIKBN
           MOVE    SPA-J01-SRYKA       TO  JYURRK-SRYKA
           MOVE    SPA-J021-MAE-HKNCOMBI
                                       TO  JYURRK-HKNCOMBINUM
           MOVE    SPA-NAI-SRYYM       TO  JYURRK-SRYYMD(1:6)
           MOVE    "01"                TO  JYURRK-SRYYMD(7:2)
           MOVE    SPA-NAI-SRYYM       TO  JYURRK-UPSRYYMD(1:6)
           MOVE    "31"                TO  JYURRK-UPSRYYMD(7:2)
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "JYURRK-KEY18"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "JYURRK-KEY18"      TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           PERFORM UNTIL     FLG-JYURRK    =   1
      *
      *        収納変更（伝票番号より）
               PERFORM 300313-SYUNOU-UPD-SEC
      *
      *        保険組合せ変更
               MOVE    SPA-J021-ATO-HKNCOMBI   TO  JYURRK-HKNCOMBINUM
      *
               MOVE    JYURRK-REC          TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "JYURRK-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "J021 JYURRK UPD ERR:"   MCP-RC
                           ",KEY:" JYURRK-KEY
                   MOVE    "0011"              TO  SPA-ERRCD
               END-IF
      *
               MOVE    "JYURRK-KEY18"      TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "JYURRK-KEY18"      TO  ORC-DBPATH
      *    CALL    "ORCMCPSUB"          USING
      *                                 MCPAREA
      *                                 ORCMCPAREA
      *                                 MCPDATA-REC
      *
           .
       300311-JYURRK-UPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計変更処理
      *****************************************************************
       300312-SRYACCT-UPD-SEC          SECTION.
      *
      *    診療会計
           INITIALIZE                  SRYACCT-REC
           MOVE    SPA-HOSPID          TO  ACCT-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  ACCT-NYUGAIKBN
           MOVE    SPA-GMN-PTID        TO  ACCT-PTID
           MOVE    SPA-J01-SRYKA       TO  ACCT-SRYKA
           MOVE    SPA-NAI-SRYYM       TO  ACCT-SRYYM
           MOVE    SPA-J021-MAE-HKNCOMBI
                                       TO  ACCT-HKNCOMBI
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACCT-KEY11"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACCT-KEY11"     TO  ORC-DBPATH
               PERFORM 980-SRYACCT-READ-SEC
           ELSE
               INITIALIZE                  SRYACCT-REC
               MOVE    1               TO  FLG-SRYACCT
           END-IF
      *
           PERFORM
               UNTIL   FLG-SRYACCT     =   1
               MOVE    SPA-J021-ATO-HKNCOMBI  TO  ACCT-HKNCOMBI
      *
               MOVE    SRYACCT-REC         TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "J021 SRYACCT UPD ERR:"   MCP-RC
                           ",KEY:" ACCT-KEY
                   MOVE    "0011"              TO  SPA-ERRCD
               END-IF
      *
               MOVE    "SRYACCT-KEY11"         TO  ORC-DBPATH
               PERFORM 980-SRYACCT-READ-SEC
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SRYACCT-KEY11"     TO  ORC-DBPATH
      *    CALL    "ORCMCPSUB"          USING
      *                                 MCPAREA
      *                                 ORCMCPAREA
      *                                 MCPDATA-REC
      *
           .
       300312-SRYACCT-UPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納変更処理
      *****************************************************************
       300313-SYUNOU-UPD-SEC          SECTION.
      *
      *    収納
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    SPA-GMN-PTID        TO  SYU-PTID
           MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    JYURRK-DENPNUM      TO  SYU-DENPNUM
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           ELSE
               MOVE    SPACE               TO  SYUNOU-REC
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
      *    CALL    "ORCMCPSUB"          USING
      *                                     MCPAREA
      *                                     ORCMCPAREA
      *                                     MCPDATA-REC
      *
           IF     (FLG-SYUNOU          =   ZERO  )  AND
                  (SYU-HKNCOMBINUM     =   SPA-J021-MAE-HKNCOMBI)
               CONTINUE
           ELSE
               GO      TO      300313-SYUNOU-UPD-EXT
           END-IF
      *
           MOVE    SPA-J021-ATO-HKNCOMBI
                                       TO  SYU-HKNCOMBINUM
           MOVE    WRK-PTFTNRATE       TO  SYU-PTFTNRATE
      *    保険情報
           MOVE    COMB-HKNNUM         TO  SYU-SYUHKNNUM
           MOVE    COMB-KOH1HKNNUM     TO  SYU-KOH1HKNNUM
           MOVE    COMB-KOH2HKNNUM     TO  SYU-KOH2HKNNUM
           MOVE    COMB-KOH3HKNNUM     TO  SYU-KOH3HKNNUM
           MOVE    COMB-KOH4HKNNUM     TO  SYU-KOH4HKNNUM
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "J021 SYUNOU UPD ERR:"   MCP-RC
                       ",KEY:" SYU-KEY
                MOVE    "0011"              TO  SPA-ERRCD
           END-IF
      *
           .
       300313-SYUNOU-UPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    算定履歴変更処理
      *****************************************************************
       300314-SANTEI-UPD-SEC          SECTION.
      *
      *    算定履歴
           INITIALIZE                  SANTEI-REC
           MOVE    SPA-HOSPID          TO  SANTEI-HOSPID
           MOVE    SPA-GMN-PTID        TO  SANTEI-PTID
           MOVE    SPA-NAI-SRYYM       TO  SANTEI-SRYYM
           MOVE    SPA-J021-MAE-HKNCOMBI
                                       TO  SANTEI-HKNCOMBINUM 
      *
           MOVE    SANTEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SANTEI-KEY6"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SANTEI-KEY6"       TO  ORC-DBPATH
               PERFORM 920-SANTEI-READ-SEC
           ELSE
               MOVE    SPACE               TO  SANTEI-REC
               INITIALIZE                  SANTEI-REC
               MOVE    1               TO  FLG-SANTEI
           END-IF
           PERFORM
               UNTIL    FLG-SANTEI     =   1
               IF     (SANTEI-SRYKA        NOT =   SPACE  AND
                       SPA-J01-SRYKA       NOT =   SANTEI-SRYKA ) OR
                      (SANTEI-NYUGAIKBN    NOT =   SPACE  AND
                       SPA-NYUGAIKBN       NOT =   SANTEI-NYUGAIKBN )
                   CONTINUE
               ELSE
                   MOVE    SPA-J021-ATO-HKNCOMBI
                                               TO  SANTEI-HKNCOMBINUM 
      *
                   MOVE    SANTEI-REC          TO  MCPDATA-REC
                   MOVE    "DBUPDATE"          TO  MCP-FUNC
                   MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                   IF      MCP-RC          NOT =   ZERO
                       DISPLAY "J021 SANTEI UPD ERR:"   MCP-RC
                               ",KEY:" SANTEI-KEY
                       MOVE    "0011"              TO  SPA-ERRCD
                   END-IF
      *
               END-IF
               MOVE    "SANTEI-KEY6"       TO  ORC-DBPATH
               PERFORM 920-SANTEI-READ-SEC
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SANTEI-KEY6"       TO  ORC-DBPATH
      *    CALL    "ORCMCPSUB"          USING
      *                                     MCPAREA
      *                                     ORCMCPAREA
      *                                     MCPDATA-REC
      *
           .
       300314-SANTEI-UPD-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "J02"               TO  SPA-SAKIPG
           MOVE    "J021"              TO  SPA-MOTOPG
      *
           MOVE    "JOIN"              TO  MCP-PUTTYPE
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
           MOVE    "J021"              TO  MCP-WINDOW.
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
                   MOVE    "変更前の保険組合せは変更できません"
                                       TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "この保険組合せでは受診はありません"
                                       TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "変更後の保険組合せがありません"
                                       TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "一般から老人保険への変更はできません。"
                                       TO  SPA-ERRMSG
                   MOVE    "診療行為の訂正で変更して下さい。"
                                       TO  SPA-ERRMSG(39:)
               WHEN    "0005"
                   MOVE    "変更前保険組合せを入力して下さい。"
                                       TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "変更後保険組合せを入力して下さい。"
                                       TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "変更前と変更後が同じです。変更して下さい"
                                       TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "変更後の保険組合せは対象外です。"
                                       TO  SPA-ERRMSG
                   MOVE    "変更して下さい"
                                       TO  SPA-ERRMSG(33:)
               WHEN    "0010"
                   MOVE    "保険組合せの変更が終了しました。"
                                       TO  SPA-ERRMSG
                   MOVE    "収納で請求額の変更して下さい。"
                                       TO  SPA-ERRMSG(33:)
               WHEN    "0011"
                   MOVE    "変換エラーです。"
                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  JERR
           MOVE    SPA-ERRCD           TO  JERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  JERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "J021"              TO  SPA-MOTOPG
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
                   MOVE    "保険組合せをすべて変更します。"
                                       TO  WRK-JIDMSG
                   MOVE
                   "変更後の取消しはできません。よろしいですか？"
                                       TO  WRK-JIDMSG(31:)
               WHEN    OTHER
                   MOVE    SPA-JIDCD
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
           MOVE    "J021"              TO  SPA-MOTOPG
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
      *    診療会計マスター次読込
      *****************************************************************
       980-SRYACCT-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SRYACCT-REC
               MOVE    ZERO                TO  FLG-SRYACCT
           ELSE
               INITIALIZE                      SRYACCT-REC
               MOVE    1                   TO  FLG-SRYACCT
           END-IF
      *
           .
       980-SRYACCT-READ-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    算定歴マスタ読み込み
      *****************************************************************
       920-SANTEI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SANTEI-REC
               MOVE    ZERO                TO  FLG-SANTEI
           ELSE
               INITIALIZE                      SANTEI-REC
               MOVE    1                   TO  FLG-SANTEI
           END-IF
      *
           .
       920-SANTEI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納マスター読込
      *****************************************************************
       980-SYUNOU-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
               MOVE    ZERO            TO  FLG-SYUNOU
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
           .
       980-SYUNOU-READ-EXT.
           EXIT.
      *
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
