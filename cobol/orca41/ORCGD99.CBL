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
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCGD99.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : データチェックサブ
      *  コンポーネント名  : 処理結果
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/05/22    ひさなが 　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    ひさなが     03/07/29  チェック内容全件印刷追加
      *
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
       01  SPA-D01.
           03  SPA-D01-AREA.
               05  SPA-GMN-PAGE               PIC 9(02).
               05  SPA-GMN-MAX                PIC 9(03).
               05  SPA-GMN-CUR                PIC 9(02).
               05  SPA-GMN-KBN                PIC X(02).
               05  SPA-GMN-RUN                PIC 9(01).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-HOSPID         PIC X(24).
                   07  SPA-GMN-SRYYMD         PIC X(08).
                   07  SPA-GMN-SRYYMD-S       PIC X(08).
                   07  SPA-GMN-SRYYM-D        PIC X(16).
                   07  SPA-GMN-NYUGAIKBN-DSP.
                       09  SPA-GMN-NYUGAIKBN      PIC X(01).
                       09  SPA-GMN-NYUGAIKBN-AKI  PIC X(01).
                       09  SPA-GMN-NYUGAIKBN-MSG  PIC X(14).
                   07  SPA-GMN-TBLG.
                       09  SPA-GMN-TBL1       OCCURS  5.
                           11  SPA-GMN-NYUGAIKBN-K    PIC X(01).
                           11  SPA-GMN-NYUGAIKBN-FL   PIC X(01).
                           11  SPA-GMN-NYUGAIKBN-M    PIC X(14).
                       09  SPA-GMN-TBL2       OCCURS  20.
                           11  SPA-GMN-MSG            PIC X(40).
                           11  SPA-GMN-CHKKBN         PIC X(20).
                           11  SPA-GMN-TBL3       OCCURS  5.
                               13  SPA-GMN-CHKKBN-K   PIC X(01).
                               13  SPA-GMN-CHKKBN-FL  PIC X(01).
                               13  SPA-GMN-CHKKBN-M   PIC X(18).
               05  SPA-NAI-AREA.
                   07  SPA-NAI-MOTOPG         PIC X(08).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
      *
       01  WRK-AREA.
           03  WRK-PAGE            PIC ZZZZZZZZZ9.
      *     
       01  WRK-HEN-AREA.
           03  WRK-HENTIME.
               05  WRK-HH          PIC X(02).
               05  FILLER          PIC X(01)   VALUE   ":".
               05  WRK-MM          PIC X(02).
               05  FILLER          PIC X(01)   VALUE   ":".
               05  WRK-SS          PIC X(02).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *     
           COPY    "CPORCMCP.INC".  
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
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
           COPY    "D01.INC".
           COPY    "D99.INC".
           COPY    "DERR.INC".
           COPY    "DID1.INC".
           COPY    "DID2.INC".
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
           MOVE    SPA-FREE        TO  SPA-D01.
      * 
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN      OTHER
                   PERFORM 200-GMNSENI
           END-EVALUATE.
      *
           MOVE    SPA-AREA        TO  SPA-COMMON.
           MOVE    SPA-D01         TO  SPA-FREE.
      *
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      * 
      *
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *    処理状態
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 490-KAKUNIN-SEC
           END-EVALUATE.
      *
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    SPA-MOTOPG          TO  SPA-SAKIPG.
           MOVE    "D99"               TO  SPA-MOTOPG.
      *
           MOVE    "JOIN"              TO  MCP-PUTTYPE.
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW,
      *
           MOVE    1                   TO  FLG-END.
      *
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理確認処理
      *****************************************************************
       490-KAKUNIN-SEC            SECTION.
      *
           MOVE    SPACE               TO  D99.
           MOVE    ZERO                TO  D99-COUNT.
      *        
      *    ジョブ管理チェック処理
           MOVE    "CHK"           TO  SJOBKANRI-MODE.
           INITIALIZE                  JOBKANRI-REC.
           MOVE    1               TO  JOB-JOBID.
           MOVE    "ORCBSD1"       TO  JOB-SHELLID.
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC. 
           IF  SJOBKANRI-RETURN   =   ZERO
               MOVE    JOB-JOBID           TO  D99-RENNUM   (1)
               MOVE    JOB-SHELLMSG        TO  D99-SHORINM  (1)
               MOVE    JOB-STARTTIME(1:2)  TO  WRK-HH
               MOVE    JOB-STARTTIME(3:2)  TO  WRK-MM
               MOVE    JOB-STARTTIME(5:2)  TO  WRK-SS
               MOVE    WRK-HENTIME         TO  D99-STARTTIME (1)
               MOVE    JOB-ENDTIME(1:2)    TO  WRK-HH
               MOVE    JOB-ENDTIME(3:2)    TO  WRK-MM
               MOVE    JOB-ENDTIME(5:2)    TO  WRK-SS
               MOVE    WRK-HENTIME         TO  D99-ENDTIME  (1)
               MOVE    JOB-UPDCNT          TO  WRK-PAGE
               MOVE    WRK-PAGE            TO  D99-PAGE     (1)
               MOVE    JOB-YOBI            TO  D99-ERRMSG   (1)
               IF  JOB-ENDYMD   =   SPACE
                   MOVE    "処理中です"    TO  D99-MSG
               ELSE
                   IF  JOB-ERRCD   =   SPACE
                       CONTINUE
                   ELSE
                       STRING  JOB-YOBI     DELIMITED  BY  SPACE
                               "【"         DELIMITED  BY  SIZE
                               JOB-SHELLMSG DELIMITED  BY  SPACE
                               "】"         DELIMITED  BY  SIZE
                                            INTO  D99-MSG
                    END-IF
               END-IF    
               MOVE    1                    TO  D99-COUNT
           END-IF.
      *
           IF  D99-MSG   =   SPACE
               MOVE    "B01"                TO  MCP-WIDGET
               IF  D99-COUNT   >   ZERO    
                   MOVE    "処理は正常に終了しました"
                                                TO  D99-MSG
               ELSE
                   MOVE    "該当する処理はありません"
                                                TO  D99-MSG
               END-IF                                 
           ELSE                                        
               MOVE    "B11"                TO  MCP-WIDGET
           END-IF.                                 
      *
           MOVE    SPACE               TO  LINKAREA.
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "D99    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
       490-KAKUNIN-EXT.
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
