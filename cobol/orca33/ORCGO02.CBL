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
      *
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCGO02.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者請求業務
      *  コンポーネント名  : エラーメッセージ（Ｏ０２）
      *  管理者            : 
      *  02/08/21    ひさなが　   新規作成
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
      *FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    画面用ＳＰＡ
           COPY    "O01SCR-SPA".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-ERR             PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
      *
      *    配列 領域
       01  TABLE-AREA.
           03  TABLE01.
               05  TABLE01-W             OCCURS  50 TIMES.
                   07  TABLE01-PTNUM     PIC X(20).
                   07  TABLE01-NAME      PIC X(68).
                   07  TABLE01-SEIYM     PIC X(06).
                   07  TABLE01-SAKKBN    PIC X(10).
      *
      *    メッセージ領域
       01  T-MESSAGE-AREA.
           03  T-MESSAGE-001       PIC X(24)   VALUE
               "患者番号入力エラーです。".
           03  T-MESSAGE-002       PIC X(24)   VALUE
               "請求年月入力エラーです。".
           03  T-MESSAGE-003       PIC X(24)   VALUE
               "作成区分入力エラーです。".
           03  T-MESSAGE-004       PIC X(24)   VALUE
               "未設定の項目があります。".
           03  T-MESSAGE-051       PIC X(22)   VALUE
               "患者請求を作成します。".
      *
      *****************************************************************
      *    ファイル連絡　領域
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    患者マスタ
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    患者番号
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
           COPY    "CPORCSGDAY.INC".
      *   患者番号変換サブ 
           COPY    "CPORCSPTID.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    MCPAREA.
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "O01.INC".
           COPY    "O02.INC".
           COPY    "O03.INC".
           COPY    "O99.INC".
           COPY    "OERR.INC".
           COPY    "OID1.INC".
           COPY    "OID2.INC".
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
           MOVE    SPA-FREE        TO  SPA-O01.
           MOVE    SPACE           TO  SPA-ERRCD.
           MOVE    ZERO            TO  FLG-END.
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN    "PUTG"          ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *    画面遷移がない時、画面表示へ
           IF  FLG-END   =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF.
      *
           MOVE    SPA-AREA        TO  SPA-COMMON.
           MOVE    SPA-O01         TO  SPA-FREE.
      *
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA.
      *    エラー画面より
           IF  SPA-MOTOPG   =   "OERR"  OR  "OID1"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5011-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF.
      *
           IF  SPA-GMN-KBN   =   "OK"
               PERFORM 490-KOUSHIN-SEC
           ELSE
               MOVE    SPACE               TO  MCP-PUTTYPE
               MOVE    "O02"               TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    1                   TO  FLG-END
           END-IF.
      *
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-GMN-LIST01-S.
           MOVE    ZERO                TO  SPA-GMN-LIST01-CNT.
           MOVE    SPACE               TO  SPA-GMN-PTNUM-K.
           MOVE    SPACE               TO  SPA-GMN-NAME-K.
           MOVE    SPACE               TO  SPA-GMN-SEIYM-K.
           MOVE    SPACE               TO  SPA-GMN-SAKKBN.
      *
      *    他のＬＤより
           IF  LINKAREA   NOT =   SPACE
               MOVE    LNK-KYOUTU              TO  SPA-KYOUTU
               MOVE    LNK-SCRSPA              TO  SPA-O01
           END-IF.
      *
           MOVE    1                       TO  SPA-GMN-CUR.
      *
           PERFORM 310-SPASET-SEC.
      *
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           MOVE    SPA-MOTOPG          TO  SPA-NAI-MOTOPG.
           MOVE    1                   TO  SPA-GMN-CUR.
           MOVE    1                   TO  SPA-GMN-PAGE.
      *
           IF  SPA-NAME   NOT =   SPACE
               MOVE    SPA-PTNUM           TO  SPA-GMN-PTNUM-K
               MOVE    SPA-NAME            TO  SPA-GMN-NAME-K
               MOVE    SPACE               TO  SPA-NAME
               MOVE    2                   TO  SPA-GMN-CUR
           ELSE
               MOVE    SPACE               TO  SPA-GMN-SAKKBN-S
               MOVE    "1"                 TO  SPA-GMN-SAKKBN-1 (1)
               MOVE    "該当月全て"        TO  SPA-GMN-SAKKBN-3 (1)
               MOVE    "2"                 TO  SPA-GMN-SAKKBN-1 (2)
               MOVE    "１期分のみ"        TO  SPA-GMN-SAKKBN-3 (2)
               MOVE    "3"                 TO  SPA-GMN-SAKKBN-1 (3)
               MOVE    "１〜２期分"        TO  SPA-GMN-SAKKBN-3 (3)
           END-IF.
      *
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE   "CHANGE"             TO  MCP-PUTTYPE
                   PERFORM 210-BACK
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 530-PF02-SEC
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM 530-PF03-SEC
               WHEN    "CLICKED"       ALSO    "B04"
                   PERFORM 530-PF04-SEC
               WHEN    "CLICKED"       ALSO    "B09"
                   PERFORM 530-PF09-SEC
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 530-RIDSET2-SEC
               WHEN    OTHER
                   MOVE    1                   TO  SPA-GMN-CUR
           END-EVALUATE.
      *
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
               WHEN    "ACTIVATE"      ALSO    "PTNUM"
                   PERFORM T-000-PTNUM-SEC
               WHEN    "ACTIVATE"      ALSO    "SEIYM"
                   PERFORM T-000-SEIYM-SEC
               WHEN    "ACTIVATE"      ALSO    "SAKKBN"
                   PERFORM T-000-SAKKBN-SEC
               WHEN    ANY             ALSO    "LIST01"
                   PERFORM T-000-LIST01-SEC
               WHEN    OTHER
                   MOVE    1                   TO  SPA-GMN-CUR
           END-EVALUATE.
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "O01"               TO  SPA-SAKIPG.
           MOVE    SPACE               TO  SPA-MOTOPG2.
           MOVE    "O02"               TO  SPA-MOTOPG.
      *
           MOVE    SPACE               TO  LINKAREA.
           INITIALIZE                  SPA-KYOTUKEY.
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU.
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    対象データ抽出処理
      *****************************************************************
       490-KOUSHIN-SEC           SECTION.
      *
      *
      *
       490-KOUSHIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC.
      *
           MOVE    SPACE           TO  LINKAREA.
           MOVE    "CURRENT"       TO  MCP-PUTTYPE.
           MOVE    "O02"           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面内容編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    SPACE                   TO  O02.
      *
           MOVE    SPA-GMN-PTNUM-K         TO  O02-PTNUM.
           MOVE    SPA-GMN-NAME-K          TO  O02-NAME.
           MOVE    SPA-GMN-SEIYM-K         TO  O02-SEIYM.
           MOVE    SPA-GMN-SAKKBN          TO  O02-SAKKBN.
      *
           PERFORM VARYING IDX FROM   1   BY  1
                   UNTIL   IDX >      10
               IF  SPA-GMN-SAKKBN-L (IDX)   NOT =   SPACE
                   MOVE    IDX                 TO  O02-SAKKBN-COUNT
                   MOVE    SPA-GMN-SAKKBN-L (IDX)
                                               TO  O02-SAKKBN-ITEM (IDX)
               END-IF
           END-PERFORM.
      *
           PERFORM VARYING IDX FROM   1   BY  1
                   UNTIL   IDX >      50
               IF  SPA-GMN-LIST01 (IDX)   NOT =   SPACE
                   MOVE    IDX               TO  O02-LIST01-COUNT
                   MOVE    SPA-GMN-T-PTNUM (IDX)
                                             TO  O02-VALUE1 (IDX)
                   MOVE    SPA-GMN-T-NAME (IDX)
                                             TO  O02-VALUE2 (IDX)
                   MOVE    SPA-GMN-T-SEIYM (IDX)
                                             TO  O02-VALUE3 (IDX)
                   MOVE    SPA-GMN-T-SAKKBN (IDX)
                                             TO  O02-VALUE4 (IDX)
                   MOVE    SPA-GMN-T-BTN01 (IDX)
                                             TO  O02-LIST01-SELECT (IDX)
               END-IF
           END-PERFORM.
      *
           PERFORM 5011-MAPCUR-SEC.
      *
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5011-MAPCUR-SEC              SECTION.
      *
           EVALUATE    SPA-GMN-CUR
               WHEN    01
                   MOVE    "PTNUM"         TO  MCP-WIDGET
               WHEN    02
                   MOVE    "SEIYM"         TO  MCP-WIDGET
               WHEN    03
                   MOVE    "SAKKBN"        TO  MCP-WIDGET
           END-EVALUATE.
      *
       5011-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＦ０２押下
      *****************************************************************
       530-PF02-SEC                 SECTION.
      *
           MOVE    "02"                TO  SPA-GMN-PFK.
      *
           MOVE    SPACE               TO  SPA-GMN-LIST01-S.
           MOVE    ZERO                TO  SPA-GMN-LIST01-CNT.
           MOVE    SPACE               TO  SPA-GMN-PTNUM-K.
           MOVE    SPACE               TO  SPA-GMN-NAME-K.
           MOVE    SPACE               TO  SPA-GMN-SEIYM-K.
           MOVE    SPACE               TO  SPA-GMN-SAKKBN.
      *
           MOVE    ZERO                TO  FLG-END.
      *
       530-PF02-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＦ０３押下
      *****************************************************************
       530-PF03-SEC                 SECTION.
      *
           MOVE    "03"                TO  SPA-GMN-PFK.
      *
           MOVE    ZERO                TO  IDY.
           MOVE    SPACE               TO  TABLE01.
           PERFORM VARYING IDX FROM   1   BY  1
                   UNTIL   IDX >      SPA-GMN-LIST01-CNT
               IF  SPA-GMN-T-BTN01 (IDX)   NOT =   "T"
                   ADD     1                    TO  IDY
                   MOVE    SPA-GMN-T-PTNUM (IDX)
                                                TO  TABLE01-PTNUM (IDY)
                   MOVE    SPA-GMN-T-NAME (IDX)
                                                TO  TABLE01-NAME (IDY)
                   MOVE    SPA-GMN-T-SEIYM (IDX)
                                                TO  TABLE01-SEIYM (IDY)
                   MOVE    SPA-GMN-T-SAKKBN (IDX)
                                                TO  TABLE01-SAKKBN (IDY)
               END-IF
           END-PERFORM.
      *
           MOVE    SPACE               TO  SPA-GMN-LIST01-S.
           MOVE    ZERO                TO  SPA-GMN-LIST01-CNT.
           PERFORM VARYING IDX FROM   1   BY  1
                   UNTIL   IDX >      50
               IF  TABLE01-W (IDX)   NOT =   SPACE
                   MOVE    IDX                TO  SPA-GMN-LIST01-CNT
                   MOVE    TABLE01-PTNUM (IDX)
                                              TO  SPA-GMN-T-PTNUM (IDX)
                   MOVE    TABLE01-NAME (IDX)
                                              TO  SPA-GMN-T-NAME (IDX)
                   MOVE    TABLE01-SEIYM (IDX)
                                              TO  SPA-GMN-T-SEIYM (IDX)
                   MOVE    TABLE01-SAKKBN (IDX)
                                              TO  SPA-GMN-T-SAKKBN (IDX)
               END-IF
           END-PERFORM.
      *
           MOVE    ZERO                TO  FLG-END.
      *
       530-PF03-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＦ０４押下
      *****************************************************************
       530-PF04-SEC                 SECTION.
      *
           MOVE    "04"                TO  SPA-GMN-PFK.
      *
           IF  (SPA-GMN-PTNUM-K   =   SPACE)   OR
               (SPA-GMN-SEIYM-K   =   SPACE)   OR
               (SPA-GMN-SAKKBN    =   SPACE)
               MOVE    "0004"                TO  OERR-ERRCODE
               MOVE    T-MESSAGE-004         TO  OERR-ERRMSG
               MOVE    "B01"                 TO  MCP-WIDGET
               MOVE    "O02"                 TO  SPA-MOTOPG
               MOVE    "OERR"                TO  SPA-SAKIPG
               MOVE    "NEW"                 TO  MCP-PUTTYPE
               MOVE    "OERR"                TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    1                     TO  SPA-GMN-CUR
               MOVE    1                     TO  FLG-END
           ELSE
               ADD     1                     TO  SPA-GMN-LIST01-CNT
               MOVE    SPA-GMN-LIST01-CNT    TO  IDX
               MOVE    SPA-GMN-PTNUM-K       TO  SPA-GMN-T-PTNUM (IDX)
               MOVE    SPA-GMN-NAME-K        TO  SPA-GMN-T-NAME (IDX)
               MOVE    SPA-GMN-SEIYM-K       TO  SPA-GMN-T-SEIYM (IDX)
               MOVE    SPA-GMN-SAKKBN        TO  SPA-GMN-T-SAKKBN (IDX)
      *
               MOVE    SPACE                 TO  SPA-GMN-PTNUM-K
               MOVE    SPACE                 TO  SPA-GMN-NAME-K
               MOVE    SPACE                 TO  SPA-GMN-SEIYM-K
               MOVE    SPACE                 TO  SPA-GMN-SAKKBN
               MOVE    ZERO                  TO  FLG-END
           END-IF.
      *
       530-PF04-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＦ０９押下
      *****************************************************************
       530-PF09-SEC                 SECTION.
      *
           MOVE    "09"                TO  SPA-GMN-PFK.
      *
           MOVE    SPACE               TO  LINKAREA.
           MOVE    SPA-KYOUTU          TO  LNK-COMMON.
           MOVE    SPA-O01             TO  LNK-SCRSPA.
           MOVE    "O02"               TO  SPA-MOTOPG.
           MOVE    "P97"               TO  SPA-SAKIPG.
      *    氏名をクリアする
           MOVE    SPACE               TO  SPA-NAME.
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU.
           MOVE    "CHANGE"            TO  MCP-PUTTYPE.
           MOVE    "P97"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       530-PF09-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認メッセージ表示
      *****************************************************************
       530-RIDSET2-SEC              SECTION.
           IF  SPA-GMN-LIST01-CNT   =   ZERO
               MOVE    "0004"                TO  OERR-ERRCODE
               MOVE    T-MESSAGE-004         TO  OERR-ERRMSG
               MOVE    "B01"                 TO  MCP-WIDGET
               MOVE    "O02"                 TO  SPA-MOTOPG
               MOVE    "OERR"                TO  SPA-SAKIPG
               MOVE    "NEW"                 TO  MCP-PUTTYPE
               MOVE    "OERR"                TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    1                     TO  SPA-GMN-CUR
               MOVE    1                     TO  FLG-END
           ELSE
               MOVE    "O02"                 TO  SPA-MOTOPG
               MOVE    "O03"                 TO  SPA-SAKIPG
               INITIALIZE                    SPA-KYOTUKEY
               INITIALIZE                    SPA-WORK
               MOVE    SPACE                 TO  LINKAREA
               MOVE    SPA-KYOUTU            TO  LNK-KYOUTU
               MOVE    "CHANGE"              TO  MCP-PUTTYPE
               MOVE    "O03"                 TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    1                     TO  FLG-END
           END-IF.
      *
       530-RIDSET2-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL   "ORCMCPSUB"       USING
                                    MCPAREA
                                    ORCMCPAREA
                                    MCPDATA-REC.
      *
       900-PUT-WINDOW-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号 確認処理
      *****************************************************************
       T-000-PTNUM-SEC                   SECTION.
      *
           MOVE    2                   TO  SPA-GMN-CUR.
           MOVE    1                   TO  FLG-ERR.
      *
           INITIALIZE                  ORCSPTIDAREA.
           MOVE    SPA-HOSPID          TO  SPTID-HOSPID.
           MOVE    O02-PTNUM           TO  SPTID-PTNUM.
           CALL    "ORCSPTID"          USING   ORCSPTIDAREA
                                               SPA-1009-TBL.
           IF  SPTID-RC   =   ZERO
               MOVE    SPTID-PTNUM         TO  SPA-GMN-PTNUM-K
               MOVE    SPTID-PTID          TO  SPA-GMN-PTID-K
      *
               MOVE    SPA-HOSPID          TO  PTINF-HOSPID
               MOVE    SPTID-PTID          TO  PTINF-PTID
               MOVE    PTINF-REC           TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "PTINF-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF  MCP-RC   =   ZERO
                   MOVE    "DBFETCH"           TO  MCP-FUNC
                   MOVE    "PTINF-KEY"         TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                   IF  MCP-RC   =   ZERO
                       MOVE    MCPDATA-REC         TO  PTINF-REC
                       MOVE    PTINF-NAME          TO  SPA-GMN-NAME-K
                       MOVE    ZERO                TO  FLG-ERR
                   END-IF
               END-IF
           END-IF.
      *
           IF  FLG-ERR   =   1   
               MOVE    "0001"                TO  OERR-ERRCODE
               MOVE    T-MESSAGE-001         TO  OERR-ERRMSG
               MOVE    "B01"                 TO  MCP-WIDGET
               MOVE    "O02"                 TO  SPA-MOTOPG
               MOVE    "OERR"                TO  SPA-SAKIPG
               MOVE    "NEW"                 TO  MCP-PUTTYPE
               MOVE    "OERR"                TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    1                     TO  SPA-GMN-CUR
               MOVE    1                     TO  FLG-END
           END-IF.
      *
      *****************************************************************
      *    請求年月 確認処理
      *****************************************************************
       T-000-SEIYM-SEC                   SECTION.
      *
           MOVE    3                   TO  SPA-GMN-CUR.
           MOVE    1                   TO  FLG-ERR.
      *
           INITIALIZE                  ORCSGDAYAREA.
           MOVE    "1"                 TO  SGDAY-INTYPE.
           MOVE    O02-SEIYM           TO  SGDAY-INDAY.
           CALL    "ORCSGDAY"          USING   ORCSGDAYAREA.
           IF  SGDAY-RC   =   ZERO
               MOVE    SGDAY-SDAY(1:6)       TO  SPA-GMN-SEIYM-K
      *
               INITIALIZE                    STS-AREA-DAY
               INITIALIZE                    LNK-DAY1-AREA
               MOVE    ZERO                  TO  LNK-DAY1-YMD
               MOVE    "11"                  TO  LNK-DAY1-IRAI
               MOVE    SGDAY-SDAY            TO  LNK-DAY1-YMD-X
               CALL    "ORCSDAY"             USING   STS-AREA-DAY
                                                     LNK-DAY1-AREA
      *
               IF  STS-DAY-RC1   =   ZERO
                   MOVE    SGDAY-OTDAY(1:6)         TO  SPA-GMN-SEIYM-K
                   MOVE    ZERO                     TO  FLG-ERR
               END-IF
           END-IF.
      *
           IF  FLG-ERR   =   1   
               MOVE    "0002"                TO  OERR-ERRCODE
               MOVE    T-MESSAGE-002         TO  OERR-ERRMSG
               MOVE    "B01"                 TO  MCP-WIDGET
               MOVE    "O02"                 TO  SPA-MOTOPG
               MOVE    "OERR"                TO  SPA-SAKIPG
               MOVE    "NEW"                 TO  MCP-PUTTYPE
               MOVE    "OERR"                TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    2                     TO  SPA-GMN-CUR
               MOVE    1                     TO  FLG-END
           END-IF.
      *
       T-000-SEIYM-EXT.
           EXIT.
      *
      *****************************************************************
      *    作成区分 確認処理
      *****************************************************************
       T-000-SAKKBN-SEC                  SECTION.
      *
           MOVE    1                   TO  SPA-GMN-CUR.
           MOVE    1                   TO  FLG-ERR.
           MOVE    O02-SAKKBN          TO  SPA-GMN-SAKKBN.
      *
           IF  O02-SAKKBN   NOT =   SPACE
               PERFORM VARYING IDX FROM   1   BY  1
                       UNTIL   IDX >      10
                   IF  SPA-GMN-SAKKBN-C   =   SPA-GMN-SAKKBN-1 (IDX)
                       MOVE    SPA-GMN-SAKKBN-L (IDX)
                                                    TO  SPA-GMN-SAKKBN
                       MOVE    99                   TO  IDX
                       MOVE    ZERO                 TO  FLG-ERR
                   END-IF
               END-PERFORM
           END-IF.
      *
           IF  FLG-ERR   =   1
               MOVE    "0003"                TO  OERR-ERRCODE
               MOVE    T-MESSAGE-003         TO  OERR-ERRMSG
               MOVE    "B01"                 TO  MCP-WIDGET
               MOVE    "O02"                 TO  SPA-MOTOPG
               MOVE    "OERR"                TO  SPA-SAKIPG
               MOVE    "NEW"                 TO  MCP-PUTTYPE
               MOVE    "OERR"                TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    3                     TO  SPA-GMN-CUR
               MOVE    1                     TO  FLG-END
           END-IF.
      *
       T-000-SAKKBN-EXT.
           EXIT.
      *
      *****************************************************************
      *    指示項目クリック 確認処理
      *****************************************************************
       T-000-LIST01-SEC                  SECTION.
      *
           PERFORM VARYING IDX FROM   1   BY  1
                   UNTIL   IDX >      SPA-GMN-LIST01-CNT
               MOVE  O02-LIST01-SELECT (IDX)   TO  SPA-GMN-T-BTN01 (IDX)
           END-PERFORM.
      *
       T-000-LIST01-EXT.
           EXIT.
