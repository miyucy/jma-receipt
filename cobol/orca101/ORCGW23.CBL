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
       PROGRAM-ID.                 ORCGW23.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : 定期請求情報（Ｗ２３）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02.08.01    ひさなが 　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    システム管理情報設定用共通パラメタ
           COPY    "W01COMMON-SPA".
      *
       01  SPA-W23.
           03  SPA-W23-AREA.
               05  SPA-GMN-PAGE               PIC 9(02).
               05  SPA-GMN-MAX                PIC 9(03).
               05  SPA-GMN-CUR                PIC 9(02).
               05  SPA-GMN-KBN                PIC X(02).
               05  SPA-GMN-RUN                PIC 9(01).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-SEIKYU01       PIC 9(02).
                   07  SPA-GMN-SEIKYU02       PIC 9(02).
                   07  SPA-GMN-SEIKYU03       PIC 9(02).
                   07  SPA-GMN-RESEIKYUKBN    PIC X(01).
               05  SPA-NAI-AREA.
                   07  SPA-NAI-MOTOPG         PIC X(08).
      *
       01  WRK-HEN-AREA.
           03  WRK-DAY             PIC 9(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-ERR             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
      *    メッセージ領域
       01  T-MESSAGE-AREA.
           03  T-MESSAGE-800-01    PIC X(16)   VALUE
               "入力エラーです。".
           03  T-MESSAGE-800-02    PIC X(24)   VALUE
               "更新ができませんでした。".
           03  T-MESSAGE-800-03    PIC X(26)   VALUE
               "定期請求情報を更新します。".
      *
      *****************************************************************
      *    ファイル連絡　領域
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    請求管理マスタ
           COPY    "CPSK5010.INC".
      *
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
           COPY    "CPORCSGDAY.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
      *
        LINKAGE                     SECTION.
      *
      *     テーブルアクセス
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "W01.INC".
           COPY    "W02.INC".
           COPY    "W03.INC".
           COPY    "W04.INC".
           COPY    "W05.INC".
           COPY    "W06.INC".
           COPY    "W07.INC". 
           COPY    "W08.INC". 
           COPY    "W09.INC".
           COPY    "W10.INC".
           COPY    "W11.INC".
           COPY    "W12.INC".
           COPY    "W13.INC".
           COPY    "W14.INC".
           COPY    "W15.INC".
           COPY    "W20.INC".
           COPY    "W21.INC".
           COPY    "W22.INC".
           COPY    "W23.INC".
           COPY    "W24.INC".
           COPY    "W25.INC".
           COPY    "W26.INC".
           COPY    "W27.INC".
           COPY    "WERR.INC".
           COPY    "WID1.INC".
      *
      *
       PROCEDURE                   DIVISION    USING
                                               MCPAREA
                                               SPAAREA
                                               LINKAREA
                                               SCRAREA.
      *****************************************************************
      *    主    処    理
      *****************************************************************
      *
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA.
           MOVE    SPA-WORK        TO  SPA-W01KYOUTU.
           MOVE    SPA-FREE        TO  SPA-W23.
      *
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
           MOVE    SPA-W01KYOUTU   TO  SPA-WORK.
           MOVE    SPA-AREA        TO  SPA-COMMON.
           MOVE    SPA-W23         TO  SPA-FREE.
      *
       000-PROC-SEC-EXT.
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                   SECTION.
      *
           INITIALIZE                  FLG-AREA.
      *    エラー画面より
           IF  SPA-MOTOPG   =   "WERR"  OR  "WID1"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5011-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF.
      *
           IF  SPA-WID1-FLG   =   "OK"
               PERFORM 490-KOUSHIN-SEC
           ELSE
               MOVE    SPACE               TO  MCP-PUTTYPE
               MOVE    "W23"               TO  MCP-WINDOW
      *
               PERFORM 900-PUT-WINDOW
      *
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
           INITIALIZE              SPA-W23.
      *
      *    他のＬＤより
           IF  LINKAREA   NOT =   SPACE
               MOVE    LNK-KYOUTU              TO  SPA-KYOUTU
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
           MOVE    SPACE               TO  SYS-5010-REC.
           INITIALIZE                      SYS-5010-REC.
           MOVE    "5010"                  TO  SYS-5010-KANRICD.
           MOVE    SPA-W01-STYUKYMD        TO  ORC-DBYMD.
           MOVE    SYS-5010-REC            TO  MCPDATA-REC.
           PERFORM 900-SYSKANRI-INV-SEC.
           IF  FLG-SYSKANRI   =   ZERO
               MOVE    MCPDATA-REC             TO  SYS-5010-REC
               MOVE    SYS-5010-SEIKYU-DAY1    TO  SPA-GMN-SEIKYU01
               MOVE    SYS-5010-SEIKYU-DAY2    TO  SPA-GMN-SEIKYU02
               MOVE    SYS-5010-SEIKYU-DAY3    TO  SPA-GMN-SEIKYU03
               MOVE    SYS-5010-RESEIKYUKBN    TO  SPA-GMN-RESEIKYUKBN
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
               WHEN    "ACTIVATE"      ALSO    "SEIKYU01"
                   PERFORM T-000-YMDCHEK1-SEC
               WHEN    "ACTIVATE"      ALSO    "SEIKYU02"
                   PERFORM T-000-YMDCHEK2-SEC
               WHEN    "ACTIVATE"      ALSO    "SEIKYU03"
                   PERFORM T-000-YMDCHEK3-SEC
               WHEN    "ACTIVATE"      ALSO    "RESEIKYUKBN"
                   PERFORM T-000-RESEIKYUKBN-SEC
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
           MOVE    "W01"               TO  SPA-SAKIPG.
           MOVE    SPACE               TO  SPA-MOTOPG2.
           MOVE    "W23"               TO  SPA-MOTOPG.
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
      *       登録処理
      *****************************************************************
       490-KOUSHIN-SEC           SECTION.
      *
           MOVE    SPACE                   TO  SYS-5010-REC.
           INITIALIZE                          SYS-5010-REC.
           MOVE    "5010"                  TO  SYS-5010-KANRICD.
           MOVE    SPA-W01-STYUKYMD        TO  ORC-DBYMD.
           MOVE    SYS-5010-REC            TO  MCPDATA-REC.
           PERFORM 900-SYSKANRI-INV-SEC.
           IF  FLG-SYSKANRI   =   ZERO
               MOVE    MCPDATA-REC             TO  SYS-5010-REC
           ELSE
               MOVE    SPACE                   TO  SYS-5010-REC
               INITIALIZE                      SYS-5010-REC
           END-IF.
           MOVE   "5010"                   TO  SYS-5010-KANRICD.
           MOVE    "*"                     TO  SYS-5010-KBNCD.
           MOVE    SPA-W01-STYUKYMD        TO  SYS-5010-STYUKYMD.
           MOVE    SPA-W01-EDYUKYMD        TO  SYS-5010-EDYUKYMD.
           MOVE    SPA-GMN-SEIKYU01        TO  SYS-5010-SEIKYU-DAY1.
           MOVE    SPA-GMN-SEIKYU02        TO  SYS-5010-SEIKYU-DAY2.
           MOVE    SPA-GMN-SEIKYU03        TO  SYS-5010-SEIKYU-DAY3.
           MOVE    SPA-GMN-RESEIKYUKBN     TO  SYS-5010-RESEIKYUKBN.
           MOVE    SPA-TERMID              TO  SYS-5010-TERMID.
           MOVE    SPA-OPID                TO  SYS-5010-OPID.
           IF  FLG-SYSKANRI   =   ZERO
               MOVE    SPA-SYSYMD              TO  SYS-5010-UPYMD
           ELSE
               MOVE    SPA-SYSYMD              TO  SYS-5010-CREYMD
           END-IF.
      *
           MOVE    SYS-5010-REC            TO  MCPDATA-REC.
           MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH.
           IF  FLG-SYSKANRI   =   ZERO
               MOVE    "DBUPDATE"              TO  MCP-FUNC
           ELSE
               MOVE    "DBINSERT"              TO  MCP-FUNC
           END-IF.
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC.
           IF  MCP-RC   NOT =   ZERO 
               MOVE    "1003"                  TO  WERR-ERRCODE
               MOVE    T-MESSAGE-800-02        TO  WERR-ERRMSG
               MOVE    "B01"                   TO  MCP-WIDGET
               MOVE    "W23"                   TO  SPA-MOTOPG
               MOVE    "WERR"                  TO  SPA-SAKIPG
               MOVE    "NEW"                   TO  MCP-PUTTYPE
               MOVE    "WERR"                  TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    1                       TO  SPA-GMN-CUR
               MOVE    1                       TO  FLG-END
           ELSE
               MOVE    "JOIN"                  TO  MCP-PUTTYPE
               PERFORM 210-BACK
           END-IF.      
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
           MOVE    "W23"           TO  MCP-WINDOW.
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
           MOVE    SPACE                   TO  W23.
      *
           IF  SPA-GMN-SEIKYU01   NOT =   ZERO
               MOVE    SPA-GMN-SEIKYU01        TO  W23-SEIKYU01
           END-IF.
           IF  SPA-GMN-SEIKYU02   NOT =   ZERO
               MOVE    SPA-GMN-SEIKYU02        TO  W23-SEIKYU02
           END-IF.
           IF  SPA-GMN-SEIKYU03   NOT =   ZERO
               MOVE    SPA-GMN-SEIKYU03        TO  W23-SEIKYU03
           END-IF.
           MOVE    SPA-GMN-RESEIKYUKBN     TO  W23-RESEIKYUKBN.
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
                   MOVE    "SEIKYU01"      TO  MCP-WIDGET
               WHEN    02
                   MOVE    "SEIKYU02"      TO  MCP-WIDGET
               WHEN    03
                   MOVE    "SEIKYU03"      TO  MCP-WIDGET
               WHEN    04
                   MOVE    "RESEIKYUKBN"   TO  MCP-WIDGET
               WHEN    05
                   MOVE    "B12"           TO  MCP-WIDGET
           END-EVALUATE.
      *
       5011-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認メッセージ表示理
      *****************************************************************
       530-RIDSET2-SEC              SECTION.
      *
           MOVE    ZERO                  TO  FLG-ERR.
           IF  (SPA-GMN-SEIKYU01   =   ZERO)  AND
               (SPA-GMN-SEIKYU02   =   ZERO)  AND
               (SPA-GMN-SEIKYU03   =   ZERO)
               MOVE    1                     TO  FLG-ERR
           END-IF.
           IF  (SPA-GMN-SEIKYU02   NOT =   ZERO)  AND
               (SPA-GMN-SEIKYU03       =   ZERO)  AND
               (SPA-GMN-SEIKYU01   NOT <   SPA-GMN-SEIKYU02)
               MOVE    1                     TO  FLG-ERR
           END-IF.
           IF  (SPA-GMN-SEIKYU02   NOT =   ZERO)  AND
               (SPA-GMN-SEIKYU03   NOT =   ZERO)  AND
               ((SPA-GMN-SEIKYU01   NOT <   SPA-GMN-SEIKYU02)  OR
                (SPA-GMN-SEIKYU02   NOT <   SPA-GMN-SEIKYU03))
               MOVE    1                     TO  FLG-ERR
           END-IF.
           IF  FLG-ERR   =   ZERO
               MOVE    SPACE                 TO  WID1
               MOVE    "1001"                TO  WID1-ID1CODE
               MOVE    T-MESSAGE-800-03      TO  WID1-ID1MSG
               MOVE    "B12"                 TO  MCP-WIDGET
               MOVE    "W23"                 TO  SPA-MOTOPG
               MOVE    "WID1"                TO  SPA-SAKIPG
               MOVE    "NEW"                 TO  MCP-PUTTYPE
               MOVE    "WID1"                TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    1                     TO  FLG-END
           ELSE
               MOVE    "0001"                TO  WERR-ERRCODE
               MOVE    T-MESSAGE-800-01      TO  WERR-ERRMSG
               MOVE    "B01"                 TO  MCP-WIDGET
               MOVE    "W23"                 TO  SPA-MOTOPG
               MOVE    "WERR"                TO  SPA-SAKIPG
               MOVE    "NEW"                 TO  MCP-PUTTYPE
               MOVE    "WERR"                TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    1                     TO  SPA-GMN-CUR
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
           MOVE   "PUTWINDOW"                   TO  MCP-FUNC.
           CALL   "ORCMCPSUB"                   USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC.
      *
       900-PUT-WINDOW-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-SYSKANRI-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           IF  MCP-RC   =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF  MCP-RC   =   ZERO
                   MOVE    ZERO                TO  FLG-SYSKANRI
               ELSE
                   MOVE    1                   TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF.
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC.
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
       900-SYSKANRI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求日 確認処理
      *****************************************************************
       T-000-YMDCHEK1-SEC                SECTION.
      *
           MOVE    2                   TO  SPA-GMN-CUR.
           MOVE    ZERO                TO  FLG-ERR.
           MOVE    ZERO                TO  WRK-DAY.
      *
           IF  W23-SEIKYU01   NOT =   SPACE
               IF  W23-SEIKYU01(2:1)   NOT =   SPACE
                   MOVE    W23-SEIKYU01(1:2)   TO  WRK-DAY
               ELSE
                   MOVE    ZERO                TO  WRK-DAY(1:1)
                   MOVE    W23-SEIKYU01(1:1)   TO  WRK-DAY(2:1)
               END-IF
               IF  ((WRK-DAY       <   01)    OR
                    (WRK-DAY       >   31))  AND
                   (WRK-DAY   NOT =   99)
                   MOVE    1                     TO  FLG-ERR
               END-IF
           END-IF.
      *
           IF  FLG-ERR   =   ZERO
               MOVE    WRK-DAY               TO  SPA-GMN-SEIKYU01
           ELSE
               MOVE    "0001"                TO  WERR-ERRCODE
               MOVE    T-MESSAGE-800-01      TO  WERR-ERRMSG
               MOVE    "B01"                 TO  MCP-WIDGET
               MOVE    "W23"                 TO  SPA-MOTOPG
               MOVE    "WERR"                TO  SPA-SAKIPG
               MOVE    "NEW"                 TO  MCP-PUTTYPE
               MOVE    "WERR"                TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    1                     TO  SPA-GMN-CUR
               MOVE    1                     TO  FLG-END
           END-IF.
      *
       T-000-YMDCHEK1-EXT.
           EXIT.
      *
      *********
      *
       T-000-YMDCHEK2-SEC                SECTION.
      *
           MOVE    3                   TO  SPA-GMN-CUR.
           MOVE    ZERO                TO  FLG-ERR.
           MOVE    ZERO                TO  WRK-DAY.
      *
           IF  W23-SEIKYU02   NOT =   SPACE
               IF  W23-SEIKYU02(2:1)   NOT =   SPACE
                   MOVE    W23-SEIKYU02(1:2)   TO  WRK-DAY
               ELSE
                   MOVE    ZERO                TO  WRK-DAY(1:1)
                   MOVE    W23-SEIKYU02(1:1)   TO  WRK-DAY(2:1)
               END-IF
               IF  ((WRK-DAY       <   01)    OR
                    (WRK-DAY       >   31))  AND
                   (WRK-DAY   NOT =   99)
                   MOVE    1                     TO  FLG-ERR
               ELSE
                   IF  (W23-SEIKYU01       =   SPACE)  OR
                       (W23-SEIKYU01(1:2)  =   "99")
                       MOVE    1                     TO  FLG-ERR
                   END-IF
               END-IF
           END-IF.
      *
           IF  FLG-ERR   =   ZERO
               MOVE    WRK-DAY               TO  SPA-GMN-SEIKYU02
           ELSE
               MOVE    "0001"                TO  WERR-ERRCODE
               MOVE    T-MESSAGE-800-01      TO  WERR-ERRMSG
               MOVE    "B01"                 TO  MCP-WIDGET
               MOVE    "W23"                 TO  SPA-MOTOPG
               MOVE    "WERR"                TO  SPA-SAKIPG
               MOVE    "NEW"                 TO  MCP-PUTTYPE
               MOVE    "WERR"                TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    1                     TO  SPA-GMN-CUR
               MOVE    1                     TO  FLG-END
           END-IF.
      *
       T-000-YMDCHEK2-EXT.
           EXIT.
      *
      *********
      *
       T-000-YMDCHEK3-SEC                SECTION.
      *
           MOVE    4                   TO  SPA-GMN-CUR.
           MOVE    ZERO                TO  FLG-ERR.
           MOVE    ZERO                TO  WRK-DAY.
      *
           IF  W23-SEIKYU03   NOT =   SPACE
               IF  W23-SEIKYU03(2:1)   NOT =   SPACE
                   MOVE    W23-SEIKYU03(1:2)   TO  WRK-DAY
               ELSE
                   MOVE    ZERO                TO  WRK-DAY(1:1)
                   MOVE    W23-SEIKYU03(1:1)   TO  WRK-DAY(2:1)
               END-IF
               IF  ((WRK-DAY       <   01)    OR
                    (WRK-DAY       >   31))  AND
                   (WRK-DAY   NOT =   99)
                   MOVE    1                     TO  FLG-ERR
               ELSE
                   IF  (W23-SEIKYU01       =   SPACE)  OR
                       (W23-SEIKYU01(1:2)  =   "99")   OR
                       (W23-SEIKYU02       =   SPACE)  OR
                       (W23-SEIKYU02(1:2)  =   "99")
                       MOVE    1                     TO  FLG-ERR
                   END-IF
               END-IF
           END-IF.
      *
           IF  FLG-ERR   =   ZERO
               MOVE    WRK-DAY               TO  SPA-GMN-SEIKYU03
           ELSE
               MOVE    "0001"                TO  WERR-ERRCODE
               MOVE    T-MESSAGE-800-01      TO  WERR-ERRMSG
               MOVE    "B01"                 TO  MCP-WIDGET
               MOVE    "W23"                 TO  SPA-MOTOPG
               MOVE    "WERR"                TO  SPA-SAKIPG
               MOVE    "NEW"                 TO  MCP-PUTTYPE
               MOVE    "WERR"                TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    1                     TO  SPA-GMN-CUR
               MOVE    1                     TO  FLG-END
           END-IF.
      *
       T-000-YMDCHEK3-EXT.
           EXIT.
      *
      *****************************************************************
      *    再請求区分 確認処理
      *****************************************************************
       T-000-RESEIKYUKBN-SEC             SECTION.
      *
           MOVE    5                   TO  SPA-GMN-CUR.
           MOVE    ZERO                TO  FLG-ERR.
      *
           IF  W23-RESEIKYUKBN   NOT =   "1"  AND  "2"
               MOVE    1                     TO  FLG-ERR
           END-IF.
      *
           IF  FLG-ERR   =   ZERO
               MOVE    W23-RESEIKYUKBN       TO  SPA-GMN-RESEIKYUKBN
           ELSE
               MOVE    "0001"                TO  WERR-ERRCODE
               MOVE    T-MESSAGE-800-01      TO  WERR-ERRMSG
               MOVE    "B01"                 TO  MCP-WIDGET
               MOVE    "W23"                 TO  SPA-MOTOPG
               MOVE    "WERR"                TO  SPA-SAKIPG
               MOVE    "NEW"                 TO  MCP-PUTTYPE
               MOVE    "WERR"                TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    4                     TO  SPA-GMN-CUR
               MOVE    1                     TO  FLG-END
           END-IF.
      *
       T-000-RESEIKYUKBN-EXT.
           EXIT.
      *
