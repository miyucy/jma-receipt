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
       PROGRAM-ID.                 ORCGE02.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : ＣＳＶ作成
      *  コンポーネント名  : ＣＳＶ作成（Ｅ０２）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  01/09/15    ひさなが 　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     ひさなが     02/05/10  ジョブ管理検索追加
      * 01.00.03     ひさなが     02/09/13  ディレクトリをサブプロへ
      *
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    ＣＳＶ作成条件用ファイル 
           SELECT  EIE00-FILE      ASSIGN  EIE00PARA
                                   FILE    STATUS  IS  STS-EIE00.
      *    ＣＳＶ作成条件１〜６０ファイル 
           SELECT  EIE01-FILE      ASSIGN  EIE01PARA
                                   FILE    STATUS  IS  STS-EIE01.
      *    抽出項目１〜６０ファイル
           SELECT  EIE02-FILE      ASSIGN  EIE02PARA
                                   FILE    STATUS  IS  STS-EIE02.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    ＣＳＶ作成条件用ファイル
       FD  EIE00-FILE.
       01  EIE00-REC               PIC X(200). 
      *    ＣＳＶ作成条件１〜６０ファイル 
       FD  EIE01-FILE.
       01  EIE01-REC               PIC X(250).
      *    抽出項目１〜６０ファイル
       FD  EIE02-FILE.
       01  EIE02-REC               PIC X(128).
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    ＣＳＶ作成条件用ファイル 名称領域 
           COPY    "CPCOMMONDAT4.INC"
                                   REPLACING  //ORCGD//
                                   BY         //EIE00//.
      *
      *    ＣＳＶ作成条件１〜６０ファイル 名称領域 
           COPY    "CPCOMMONDAT4.INC"
                                   REPLACING  //ORCGD//
                                   BY         //EIE01//.
      *
      *    抽出項目１〜６０ファイル 名称領域 
           COPY    "CPCOMMONDAT4.INC"
                                   REPLACING  //ORCGD//
                                   BY         //EIE02//.
      *
      *    データチェック シェル領域 
           COPY    "CPCOMMONSHELL5.INC".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
       01  SPA-E02.
           03  SPA-E02-AREA.
               05  SPA-GMN-PAGE               PIC 9(02).
               05  SPA-GMN-MAX-A              PIC 9(03).
               05  SPA-GMN-MAX-B              PIC 9(03).
               05  SPA-GMN-CUR                PIC 9(03).
               05  SPA-GMN-KBN                PIC X(02).
               05  SPA-GMN-RUN                PIC 9(01).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-SRYYM          PIC X(06).
                   07  SPA-GMN-TBLNM          PIC X(20).
                   07  SPA-GMN-FILE-ID        PIC X(128).
                   07  SPA-GMN-FILE-KEY       PIC X(64).
               05  SPA-NAI-AREA.
                   07  SPA-NAI-MOTOPG         PIC X(08).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-FIL             PIC 9(01).
           03  FLG-SEL             PIC X(01).
      *
      *    エンドステータス領域
       01  STS-AREA.
           03  STS-EIE00           PIC X(02).
           03  STS-EIE01           PIC X(02).
           03  STS-EIE02           PIC X(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                PIC 9(03).
           03  IDX2                PIC 9(03).
           03  IDX3                PIC 9(03).
           03  IDX4                PIC 9(03).
           03  IDX7                PIC 9(03).
           03  IDX8                PIC 9(03).
           03  IDX9                PIC 9(03).
      *
      *    メッセージ領域
       01  T-MESSAGE-AREA.
           03  T-MESSAGE-01        PIC X(60)   VALUE
               "指定された条件でＣＳＶ出力中のためしばらくお待ちください
      -        "。  ".
           03  T-MESSAGE-02        PIC X(30)   VALUE
               "指定された条件でのＣＳＶ出力は".
           03  T-MESSAGE-03        PIC X(16)   VALUE
               "に終了しました。".
           03  T-MESSAGE-04        PIC X(28)   VALUE
               "抽出項目未設定テーブルあり。".
           03  T-MESSAGE-05        PIC X(42)   VALUE
               "指定された条件でＣＳＶ出力処理を行います。".
      *
      *    作業テーブル名称領域
       01  WK-TBL0.
           03  WK-TBLSET0       OCCURS  500.
               11  WK-TBL-BTN-A    PIC X(001).
               11  WK-TBL-MSG-A    PIC X(128).
               11  WK-TBL-BTN-B    PIC X(001).
               11  WK-TBL-MSG-B    PIC X(128).
       01  WK-TBL1.
           03  WK-TBLSET1       OCCURS  60.
               05  WK-TBL-MSG      PIC X(20).
               05  WK-TBL-KBN1     PIC X(01).
               05  WK-TBL-KBN2     PIC X(01).
       01  WK-TBL2.
           03  WK-TBLSET2       OCCURS  500.
               05  WK-TBL-MSG-C    PIC X(128).
               05  WK-TBL-BTN-C    PIC X(001).
       01  WK-TBL3.
           03  WK-TBL-MSG-D     PIC X(128).
           03  WK-TBL-SW-CNT    PIC 9(003).
           03  WK-TBL-SW-SW     PIC X(001).
      *
      *    シェル用領域
           COPY    "CPSHELLTBL.INC".
           COPY    "ORCA-DBPATH".
      *
      *    ジョブ管理
       01  WRK-JOBKANRI-AREA.
           03  WRK-JOBKANRI-MODE       PIC X(03).
           03  WRK-JOBKANRI-RETURN     PIC S9(03).
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    フィアルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
      *
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
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
           COPY    "E01.INC".
           COPY    "E02.INC".
           COPY    "EERR.INC".
           COPY    "EID1.INC".
           COPY    "EID2.INC".
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
           MOVE    SPA-FREE        TO  SPA-E02.
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
                   PERFORM 530-RIDSET2-SEC
                   IF  SPA-GMN-RUN   =   ZERO   OR   2
                       PERFORM 200-ENTRY
                   END-IF
           END-EVALUATE.
      *    画面遷移がない時、画面表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF.
      *
           MOVE    SPA-AREA        TO  SPA-COMMON.
           MOVE    SPA-E02         TO  SPA-FREE.
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
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "EERR" OR "EID1" OR "EID2"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5011-MAPCUR-SEC
               IF  (SPA-GMN-RUN   =   ZERO   OR   2)   AND
                   (SPA-GMN-KBN   =   "OK")
                   MOVE    "CHK"               TO  WRK-JOBKANRI-MODE
                   INITIALIZE                      JOBKANRI-REC
                   MOVE    1                   TO  JOB-JOBID
                   MOVE    "ORCBSE1"           TO  JOB-SHELLID
                   MOVE    ALL "*"             TO  JOB-TERMID
                   CALL    "ORCSJOB"           USING
                                               WRK-JOBKANRI-AREA  
                                               JOBKANRI-REC
                   IF  WRK-JOBKANRI-RETURN   =   ZERO
                       INITIALIZE                      WRK-JOBKANRI-AREA
                       MOVE    "DEL"               TO  WRK-JOBKANRI-MODE
                       INITIALIZE                      JOBKANRI-REC
                       MOVE    1                   TO  JOB-JOBID
                       MOVE    "ORCBSE1"           TO  JOB-SHELLID
                       MOVE    ALL "*"             TO  JOB-TERMID
                       CALL    "ORCSJOB"           USING
                                                   WRK-JOBKANRI-AREA
                                                   JOBKANRI-REC
                   END-IF
                   INITIALIZE                      WRK-JOBKANRI-AREA
                   MOVE    "JBS"               TO  WRK-JOBKANRI-MODE
                   INITIALIZE                      JOBKANRI-REC
                   MOVE    1                   TO  JOB-JOBID
                   MOVE    "ORCBSE1"           TO  JOB-SHELLID
                   MOVE    ALL "*"             TO  JOB-TERMID
                   MOVE    "ＣＳＶ出力"        TO  JOB-SHELLMSG
                   CALL    "ORCSJOB"           USING
                                               WRK-JOBKANRI-AREA
                                               JOBKANRI-REC
      *修正/*開始*02.09.13*********************************************
      *             MOVE    "orcbse01.sh"       TO  SHELL-SHELL
                   INITIALIZE                      ORCSMKPASSAREA
                   MOVE    "scripts/allways/orcbse01.sh"
                                               TO  MKPASS-IN-01
                   CALL    "ORCSMKPASS"     USING  ORCSMKPASSAREA
                   MOVE    MKPASS-OT-01        TO  SHELL-NAME
      *修正/*終了*02.09.13*********************************************
                   MOVE    SPA-SYSYMD(1:6)     TO  SHELL-SRYYM
                   MOVE    SPA-TERMID          TO  SHELL-TERMID
                   MOVE    SPA-SYSYMD          TO  SHELL-SYSYMD
                   MOVE    ZERO                TO  SHELL-SYOKBN
                   MOVE    ZERO                TO  SHELL-RECEKBN
                   MOVE    SPACE               TO  SHELL-ERRFILE
                   MOVE    SHELL-NAME          TO  SHELLTBL-NAME
                   MOVE    SHELL-ARG1          TO  SHELLTBL-ARG1
                   MOVE    SHELL-ARG2          TO  SHELLTBL-ARG2
                   MOVE    SHELL-ARG3          TO  SHELLTBL-ARG3
                   MOVE    SHELL-ARG4          TO  SHELLTBL-ARG4
                   MOVE    SHELLTBL            TO  MCPDATA-REC
                   MOVE    "SHELL"             TO  MCP-FUNC
                   MOVE    PATH-SHELL-SHELL    TO  MCP-PATH
                   CALL    "MCPSUB"            USING
                                               MCPAREA
                                               MCPDATA-REC
                   MOVE    1                   TO  FLG-END
                   MOVE    SPACE               TO  SPA-MOTOPG
                   MOVE    SPACE               TO  SPA-GMN-KBN
               END-IF
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF.
      *
           MOVE    SPACE               TO  LINKAREA.
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "E02"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           INITIALIZE              SPA-E02.
           INITIALIZE              WK-TBL0.
      *
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF.
      *
           MOVE    1                       TO  SPA-GMN-CUR.
      *
           PERFORM 310-SPASET-SEC.
      *
           PERFORM T-000-READCHEK-SEC.
      *
           PERFORM T-000-SETECHEK-SEC.
      *
           PERFORM T-001-READCHEK-SEC.
      *
           PERFORM T-000-SETTABLE-SEC.
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
      *
           MOVE    1                   TO  SPA-GMN-CUR.
      *
           MOVE    1                   TO  SPA-GMN-PAGE.
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
                   PERFORM T-001-WRITCHEK-SEC
                   PERFORM T-000-WRITCHEK-SEC
                   PERFORM 210-BACK
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM T-001-WRITCHEK-SEC
                   PERFORM T-000-WRITCHEK-SEC
                   PERFORM T-001-HANTCHEK-SEC
                   PERFORM T-000-SETECHEK-SEC
                   PERFORM T-001-READCHEK-SEC
                   PERFORM T-000-SETTABLE-SEC
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM T-001-CHUSYUTU-SEC
               WHEN    "CLICKED"       ALSO    "B04"
                   PERFORM T-001-TORIYAME-SEC
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM T-002-CHUSYUTU-SEC
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM T-002-TORIYAME-SEC
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM T-002-AGARU-SEC
               WHEN    "CLICKED"       ALSO    "B08"
                   PERFORM T-002-SAGARU-SEC
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM T-001-WRITCHEK-SEC
                   PERFORM T-000-WRITCHEK-SEC
                   PERFORM 530-RIDSET3-SEC
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM T-001-WRITCHEK-SEC
                   PERFORM T-000-WRITCHEK-SEC
                   MOVE    SPACE                TO    SPA-ERRCD
                   PERFORM VARYING IDX1  FROM  1  BY 1
                           UNTIL   IDX1  >    60
                           IF    (WK-TBL-KBN1 (IDX1)     = "*")
                           AND   (WK-TBL-KBN2 (IDX1) NOT = "*")
                               MOVE    "0002"          TO  SPA-ERRCD
                               MOVE    61              TO  IDX1
                           END-IF
                   END-PERFORM
                   IF      SPA-ERRCD  NOT = SPACE
                       PERFORM 500-SET-SCREEN
                   ELSE
                       PERFORM 530-RIDSET2-SEC
                   END-IF
               WHEN    "CLICKED"       ALSO    "B13"
                   PERFORM 530-RIDSET2-SEC
               WHEN      ANY           ALSO    "CLIST1"
                   PERFORM T-000-CLST1CHK-SEC
               WHEN      ANY           ALSO    "CLIST2"
                   PERFORM T-000-CLST2CHK-SEC
               WHEN    OTHER
                   MOVE    1               TO  SPA-GMN-CUR
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
               WHEN    "ACTIVATE"      ALSO    "SRYYM"
               WHEN    "CHANGED"       ALSO    "SRYYM"
                   PERFORM T-000-SNENCHEK-SEC
               WHEN    "ACTIVATE"      ALSO    "FILENAME"
               WHEN    "CHANGED"       ALSO    "FILENAME"
                   PERFORM T-000-NAMECHEK-SEC
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM T-002-AGARU-SEC
               WHEN    "CLICKED"       ALSO    "B08"
                   PERFORM T-002-SAGARU-SEC
               WHEN      ANY           ALSO    "CLIST1"
                   PERFORM T-000-CLST1CHK-SEC
               WHEN      ANY           ALSO    "CLIST2"
                   PERFORM T-000-CLST2CHK-SEC
               WHEN    OTHER
                   MOVE    1               TO  SPA-GMN-CUR
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
           MOVE    "E01"               TO  SPA-SAKIPG.
           MOVE    SPACE               TO  SPA-MOTOPG2.
           MOVE    "E02"               TO  SPA-MOTOPG.
      *
           MOVE    SPACE               TO  LINKAREA. 
           INITIALIZE                  SPA-KYOTUKEY.
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU.
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW.
           MOVE    "CHANGE"            TO  MCP-PUTTYPE.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC.
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF.
      *
           MOVE    SPACE           TO  LINKAREA.
           MOVE    "CURRENT"       TO  MCP-PUTTYPE.
           MOVE    "E02"           TO  MCP-WINDOW.
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
           MOVE    SPACE               TO  E02.
      *
           MOVE    SPA-GMN-TBLNM       TO  E02-CHKMSG000.
           MOVE    SPA-GMN-SRYYM       TO  E02-SRYYM.
           MOVE    SPA-GMN-FILE-ID     TO  E02-FILENAME.
           IF      SPA-GMN-MAX-A NOT =  ZERO
               PERFORM VARYING IDX7  FROM  1  BY 1
                       UNTIL   IDX7  >   SPA-GMN-MAX-A
                       MOVE    WK-TBL-MSG-A (IDX7)(1:25)
                               TO  E02-VALUE1 (IDX7)(1:25)
                       MOVE    WK-TBL-BTN-A (IDX7)
                               TO  E02-SELECT1 (IDX7)
                       MOVE    IDX7
                               TO  E02-COUNT1
               END-PERFORM
           END-IF.
      *
           IF      SPA-GMN-MAX-B NOT =  ZERO
               PERFORM VARYING IDX7  FROM  1  BY 1
                       UNTIL   IDX7  >   SPA-GMN-MAX-B
                       MOVE    WK-TBL-MSG-B (IDX7)(1:25)
                               TO  E02-VALUE2 (IDX7)(1:25)
                       MOVE    WK-TBL-BTN-B (IDX7)
                               TO  E02-SELECT2 (IDX7)
                       MOVE    IDX7
                               TO  E02-COUNT2
               END-PERFORM
           END-IF.
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
           MOVE    "B12"           TO  MCP-WIDGET.
      *
       5011-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRMSG.
           EVALUATE    SPA-ERRCD
               WHEN    "0002"
                   MOVE    T-MESSAGE-04        TO  SPA-ERRMSG
               WHEN    OTHER
                   MOVE    SPACE               TO  SPA-ERRMSG
           END-EVALUATE.
      *
           MOVE    SPACE               TO  EERR.
           MOVE    SPA-ERRCD           TO  EERR-ERRCODE.
           MOVE    SPA-ERRMSG          TO  EERR-ERRMSG.
           MOVE    "B01"               TO  MCP-WIDGET.
      *
           MOVE    "E02"               TO  SPA-MOTOPG.
           MOVE    "EERR"              TO  SPA-SAKIPG.
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "EERR"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       510-ERRMSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認メッセージ表示理
      *****************************************************************
       530-RIDSET2-SEC              SECTION.
      *
      *    ジョブ管理チェック処理
      *
           MOVE    "CHK"              TO  WRK-JOBKANRI-MODE.
           INITIALIZE                     JOBKANRI-REC.
           MOVE    1                  TO  JOB-JOBID.
           MOVE    "ORCBSE1"          TO  JOB-SHELLID.
           MOVE    ALL "*"            TO  JOB-TERMID.
           CALL    "ORCSJOB"          USING
                                      WRK-JOBKANRI-AREA  
                                      JOBKANRI-REC.
           MOVE    SPACE              TO  EID2.
           MOVE    ZERO               TO  SPA-GMN-RUN.
           IF  WRK-JOBKANRI-RETURN   =   ZERO
               IF  JOB-ENDYMD            =   SPACE
                   MOVE    "7777"             TO  EID2-ID2CODE
                   MOVE    T-MESSAGE-01       TO  EID2-ID2MSG
                   MOVE    1                  TO  SPA-GMN-RUN
               ELSE
                   IF  MCP-WIDGET             =   "B13"
                       MOVE    "8888"             TO  EID2-ID2CODE
                       MOVE    T-MESSAGE-02       TO  EID2-ID2MSG(1:30)
                       MOVE    JOB-ENDTIME(1:2)   TO  EID2-ID2MSG(31:2)
                       MOVE    "時"               TO  EID2-ID2MSG(33:2)
                       MOVE    JOB-ENDTIME(3:2)   TO  EID2-ID2MSG(35:2)
                       MOVE    "分"               TO  EID2-ID2MSG(37:2)
                       MOVE    T-MESSAGE-03       TO  EID2-ID2MSG(39:16)
                       MOVE    2                  TO  SPA-GMN-RUN
                   END-IF
               END-IF
               IF  MCP-WIDGET   =   "B01"   OR   "B13"
                   MOVE    "E02"               TO  SPA-MOTOPG
                   MOVE    "EID2"              TO  SPA-SAKIPG
                   MOVE    "NEW"               TO  MCP-PUTTYPE
                   MOVE    "EID2"              TO  MCP-WINDOW
                   PERFORM 900-PUT-WINDOW
                   MOVE    1                   TO  FLG-END
               END-IF
           END-IF.
      *
           IF  MCP-WIDGET             =   "B12"
               IF  SPA-GMN-RUN        NOT =   1
                   MOVE    "1001"                TO  EID1-ID1CODE
                   MOVE    T-MESSAGE-05          TO  EID1-ID1MSG
                   MOVE    "E02"                 TO  SPA-MOTOPG
                   MOVE    "EID1"                TO  SPA-SAKIPG
                   MOVE    "NEW"                 TO  MCP-PUTTYPE
                   MOVE    "EID1"                TO  MCP-WINDOW
               ELSE
                   MOVE    "E02"                 TO  SPA-MOTOPG
                   MOVE    "EID2"                TO  SPA-SAKIPG
                   MOVE    "NEW"                 TO  MCP-PUTTYPE
                   MOVE    "EID2"                TO  MCP-WINDOW
               END-IF
               PERFORM 900-PUT-WINDOW
               MOVE    1                     TO  FLG-END
           END-IF.
      *
       530-RIDSET2-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ管理表示理
      *****************************************************************
       530-RIDSET3-SEC              SECTION.
      *
      *    画面移行用のパラメタ変更
           MOVE    "E02"               TO  SPA-MOTOPG.
           MOVE    "XB01"              TO  SPA-SAKIPG.
           INITIALIZE                  SPA-KYOTUKEY.
           INITIALIZE                  SPA-WORK.
           MOVE    "ORCBSE1"           TO  SPA-JOB-SHELLID.
           MOVE    SPACE               TO  LINKAREA.
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU.
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "XB01"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       530-RIDSET3-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"                   TO  MCP-FUNC.
           CALL   "ORCMCPSUB"                    USING
                                                 MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC.
      *
       900-PUT-WINDOW-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療年月 確認処理
      *****************************************************************
       T-000-SNENCHEK-SEC                SECTION.
      *
           IF      (WK-TBL-MSG (IDX2)(1:6) = "JYURRK")
           OR      (WK-TBL-MSG (IDX2)(1:8) = "PTBYOMEI")
           OR      (WK-TBL-MSG (IDX2)(1:7) = "SRYACCT")
           OR      (WK-TBL-MSG (IDX2)(1:6) = "SRYACT")
           OR      (WK-TBL-MSG (IDX2)(1:8) = "WKSRYACT")
           OR      (WK-TBL-MSG (IDX2)(1:6) = "SANTEI")
           OR      (WK-TBL-MSG (IDX2)(1:6) = "SEIKYU")
           OR      (WK-TBL-MSG (IDX2)(1:5) = "BD002")
               MOVE    E02-SRYYM(1:6)      TO  SPA-GMN-SRYYM
           ELSE
               MOVE    SPACE               TO  SPA-GMN-SRYYM
           END-IF.
      *
           IF  SPA-GMN-SRYYM =  "******"
               MOVE    SPACE               TO  SPA-GMN-SRYYM
           END-IF.
      *
       T-000-SNENCHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイル名 確認処理
      *****************************************************************
       T-000-NAMECHEK-SEC                SECTION.
      *
           MOVE    E02-FILENAME        TO  SPA-GMN-FILE-ID.
      *
       T-000-NAMECHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｂ０３クリック 処理
      *****************************************************************
       T-001-CHUSYUTU-SEC                SECTION.
      *
           IF      FLG-SEL  =  "A"
               MOVE    ZERO                   TO    IDX7
               MOVE    ZERO                   TO    IDX8
      *
               PERFORM VARYING IDX9  FROM  1  BY 1
                       UNTIL   IDX9  >   SPA-GMN-MAX-A
                   IF      WK-TBL-BTN-A (IDX9)  =  "T"
                       COMPUTE  IDX7          = IDX7          + 1
                       COMPUTE  SPA-GMN-MAX-B = SPA-GMN-MAX-B + 1
                       MOVE    WK-TBL-MSG-A (IDX9)
                               TO  WK-TBL-MSG-B (SPA-GMN-MAX-B)
                       MOVE    "F"
                               TO  WK-TBL-BTN-A (IDX9)
                   ELSE
                       COMPUTE  IDX8 = IDX8 + 1
                       MOVE    WK-TBL-MSG-A (IDX9)
                               TO  WK-TBL-MSG-A (IDX8)
                   END-IF
               END-PERFORM
      *         
               COMPUTE  IDX8 = SPA-GMN-MAX-A + 1
      *
               PERFORM VARYING IDX9  FROM  IDX8  BY 1
                       UNTIL   IDX9  >   500
                   MOVE    SPACE              TO  WK-TBL-MSG-A (IDX9)
                   MOVE    "F"                TO  WK-TBL-BTN-A (IDX9)
               END-PERFORM
      *
               COMPUTE  SPA-GMN-MAX-A = SPA-GMN-MAX-A - IDX7
               MOVE    SPACE               TO  FLG-SEL
      *
           END-IF.
      *
       T-001-CHUSYUTU-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｂ０４クリック 処理
      *****************************************************************
       T-001-TORIYAME-SEC                SECTION.
      *
           IF      FLG-SEL  =  "D"
               MOVE    ZERO                   TO    IDX7
               MOVE    ZERO                   TO    IDX8
      *
               PERFORM VARYING IDX9  FROM  1  BY 1
                       UNTIL   IDX9  >   SPA-GMN-MAX-B
                   IF      WK-TBL-BTN-B (IDX9)  =  "T"
                       COMPUTE  IDX7 = IDX7 + 1
                       MOVE    "F"
                               TO  WK-TBL-BTN-B (IDX9)
                   ELSE
                       COMPUTE  IDX8 = IDX8 + 1
                       MOVE    WK-TBL-MSG-B (IDX9)
                               TO  WK-TBL-MSG-B (IDX8)
                   END-IF
               END-PERFORM
      *
               COMPUTE  IDX8 = SPA-GMN-MAX-B + 1
      *
               PERFORM VARYING IDX9  FROM  IDX8  BY 1
                       UNTIL   IDX9  >   500
                   MOVE    SPACE            TO  WK-TBL-MSG-B (IDX9)
                   MOVE    "F"              TO  WK-TBL-BTN-B (IDX9)
               END-PERFORM
      *
               COMPUTE  SPA-GMN-MAX-B = SPA-GMN-MAX-B - IDX7
               MOVE    SPACE             TO  FLG-SEL
               PERFORM T-000-SETTABLE-SEC
      *
           END-IF.
      *
       T-001-TORIYAME-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｂ０５クリック 処理
      *****************************************************************
       T-002-CHUSYUTU-SEC                SECTION.
      *
           PERFORM VARYING IDX9  FROM  1  BY 1
                   UNTIL   IDX9  >   SPA-GMN-MAX-A
               COMPUTE  SPA-GMN-MAX-B = SPA-GMN-MAX-B + 1
               MOVE    WK-TBL-MSG-A (IDX9)
                       TO  WK-TBL-MSG-B (SPA-GMN-MAX-B)
               MOVE    SPACE
                       TO  WK-TBL-MSG-A (IDX9)
               MOVE    "F"
                       TO  WK-TBL-BTN-A (IDX9)
           END-PERFORM.
      *
           MOVE    ZERO             TO  SPA-GMN-MAX-A.
           MOVE    SPACE            TO  FLG-SEL.
      *
       T-002-CHUSYUTU-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｂ０６クリック 処理
      *****************************************************************
       T-002-TORIYAME-SEC                SECTION.
      *
           PERFORM VARYING IDX9  FROM  1  BY 1
                   UNTIL   IDX9  >   SPA-GMN-MAX-B
               MOVE    SPACE            TO  WK-TBL-MSG-B (IDX9)
               MOVE    "F"              TO  WK-TBL-BTN-B (IDX9)
           END-PERFORM.
      *
           MOVE    ZERO             TO  SPA-GMN-MAX-B.
           MOVE    SPACE            TO  FLG-SEL.
           PERFORM T-000-SETTABLE-SEC.
      *
       T-002-TORIYAME-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｂ０７クリック 処理
      *****************************************************************
       T-002-AGARU-SEC                   SECTION.
      *
           MOVE    ZERO              TO  WK-TBL-SW-CNT.
           MOVE    SPACE             TO  WK-TBL-SW-SW.
      *
           PERFORM VARYING IDX9  FROM  1  BY 1
                   UNTIL   IDX9  >   SPA-GMN-MAX-B
               IF      WK-TBL-BTN-B (IDX9)  =  "T"
                   COMPUTE  WK-TBL-SW-CNT = WK-TBL-SW-CNT + 1
               END-IF
           END-PERFORM.
      *
           IF      WK-TBL-BTN-B (1)  =  "T"
               MOVE    "*"               TO  WK-TBL-SW-SW
           END-IF.
      *
           IF      (WK-TBL-SW-CNT  >  1)
           AND     (WK-TBL-SW-SW  =  "*")
               NEXT SENTENCE
           ELSE
               MOVE    1                 TO  IDX9
               PERFORM UNTIL   IDX9  >   SPA-GMN-MAX-B
                   IF      WK-TBL-BTN-B (IDX9)  =  "T"
                       COMPUTE  IDX7 = IDX9 - 1
                       IF      IDX7  >  ZERO
                           MOVE    WK-TBL-MSG-B (IDX9)
                                   TO  WK-TBL-MSG-D
                           MOVE    "F"
                                   TO  WK-TBL-BTN-B (IDX9)
                           MOVE    WK-TBL-MSG-B (IDX7)
                                   TO  WK-TBL-MSG-B (IDX9)
                           MOVE    WK-TBL-MSG-D
                                   TO  WK-TBL-MSG-B (IDX7)
                           MOVE    "T"
                                   TO  WK-TBL-BTN-B (IDX7)
                       END-IF
                   END-IF
                   COMPUTE  IDX9 = IDX9 + 1
               END-PERFORM
           END-IF.
      *
       T-002-AGARU-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｂ０８クリック 処理
      *****************************************************************
       T-002-SAGARU-SEC                  SECTION.
      *
           MOVE    ZERO              TO  WK-TBL-SW-CNT.
           MOVE    SPACE             TO  WK-TBL-SW-SW.
      *
           PERFORM VARYING IDX9  FROM  1  BY 1
                   UNTIL   IDX9  >   SPA-GMN-MAX-B
               IF      WK-TBL-BTN-B (IDX9)  =  "T"
                   COMPUTE  WK-TBL-SW-CNT = WK-TBL-SW-CNT + 1
               END-IF
           END-PERFORM.
      *
           IF      WK-TBL-BTN-B (SPA-GMN-MAX-B)  =  "T"
               MOVE    "*"               TO  WK-TBL-SW-SW
           END-IF.
      *
           IF      (WK-TBL-SW-CNT  >  1)
           AND     (WK-TBL-SW-SW  =  "*")
               NEXT SENTENCE
           ELSE
               MOVE    SPA-GMN-MAX-B     TO  IDX9
               PERFORM UNTIL   IDX9  <   1
                   IF      WK-TBL-BTN-B (IDX9)  =  "T"
                       COMPUTE  IDX7 = IDX9 + 1
                       IF      IDX7  NOT >  SPA-GMN-MAX-B
                           MOVE    WK-TBL-MSG-B (IDX9)
                                   TO  WK-TBL-MSG-D
                           MOVE    "F"
                                   TO  WK-TBL-BTN-B (IDX9)
                           MOVE    WK-TBL-MSG-B (IDX7)
                                   TO  WK-TBL-MSG-B (IDX9)
                           MOVE    WK-TBL-MSG-D
                                   TO  WK-TBL-MSG-B (IDX7)
                           MOVE    "T"
                                   TO  WK-TBL-BTN-B (IDX7)
                       END-IF
                   END-IF
                   COMPUTE  IDX9 = IDX9 - 1
               END-PERFORM
           END-IF.
      *
       T-002-SAGARU-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル項目クリック 処理
      *****************************************************************
       T-000-CLST1CHK-SEC                SECTION.
      *
           IF      FLG-SEL  =  " " OR "A"
               MOVE    SPACE            TO  FLG-SEL
               PERFORM VARYING IDX9  FROM  1  BY 1
                       UNTIL   IDX9  >   SPA-GMN-MAX-A
                   MOVE    E02-SELECT1 (IDX9) TO  WK-TBL-BTN-A (IDX9)
                   IF      E02-SELECT1 (IDX9)  =  "T"
                       MOVE    "A"              TO  FLG-SEL
                   END-IF
               END-PERFORM
           END-IF.
      *
       T-000-CLST1CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    抽出項目クリック 処理
      *****************************************************************
       T-000-CLST2CHK-SEC                SECTION.
      *
           IF      FLG-SEL  =  " " OR "D"
               MOVE    SPACE            TO  FLG-SEL
               PERFORM VARYING IDX9  FROM  1  BY 1
                       UNTIL   IDX9  >   SPA-GMN-MAX-B
                   MOVE    E02-SELECT2 (IDX9) TO  WK-TBL-BTN-B (IDX9)
                   IF      E02-SELECT2 (IDX9)  =  "T"
                       MOVE    "D"              TO  FLG-SEL
                   END-IF
               END-PERFORM
           END-IF.
      *
       T-000-CLST2CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル名称 セット処理
      *****************************************************************
       T-000-SETTABLE-SEC                SECTION.
      *
           IF      SPA-GMN-MAX-B  NOT =  ZERO
               PERFORM VARYING IDX9  FROM  1  BY 1
                       UNTIL   IDX9  >   SPA-GMN-MAX-B
                   PERFORM VARYING IDX7  FROM  1  BY 1
                           UNTIL   IDX7  >   500
                       IF      WK-TBL-MSG-B (IDX9)
                               =  WK-TBL-MSG-C (IDX7)
                           MOVE    "T"
                                   TO  WK-TBL-BTN-C (IDX7)
                           MOVE    501
                                   TO  IDX7
                       END-IF
                   END-PERFORM
               END-PERFORM
           END-IF.
      *
           MOVE    ZERO             TO  IDX8.
           MOVE    ZERO             TO  SPA-GMN-MAX-A.
      *
           PERFORM VARYING IDX9  FROM  1  BY 1
                   UNTIL   IDX9  >   500
               EVALUATE    WK-TBL-BTN-C (IDX9)
                   WHEN    "T"
                       MOVE    "F"
                               TO  WK-TBL-BTN-C (IDX9)
                   WHEN    "F"
                       COMPUTE  IDX8 = IDX8 + 1
                       MOVE    IDX8
                               TO  SPA-GMN-MAX-A
                       MOVE    WK-TBL-MSG-C (IDX9)
                               TO  WK-TBL-MSG-A (IDX8)
               END-EVALUATE
           END-PERFORM.
      *         
           COMPUTE  IDX8 = SPA-GMN-MAX-A + 1.
      *
           PERFORM VARYING IDX9  FROM  IDX8  BY 1
                   UNTIL   IDX9  >   500
               MOVE    SPACE            TO  WK-TBL-MSG-A (IDX9)
               MOVE    "F"              TO  WK-TBL-BTN-A (IDX9)
           END-PERFORM.
      *
       T-000-SETTABLE-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＣＳＶ作成条件 入力処理
      *****************************************************************
       T-000-READCHEK-SEC                SECTION.
      *
           MOVE    "ORCE00.CNV"          TO  EIE00PARA-FILE.
           MOVE    SPACE                 TO  WK-TBL1.
           MOVE    ZERO                  TO  IDX2.
      *
           OPEN    INPUT                   EIE00-FILE.
      *
           IF      STS-EIE00         =   ZERO
               PERFORM VARYING IDX1  FROM  1  BY 1
                       UNTIL   IDX1  >    60
                   READ    EIE00-FILE
                           AT   END
                                MOVE    61    TO  IDX1
                           NOT  AT  END
                                PERFORM T-000-READCHEK1-SEC
                   END-READ
               END-PERFORM
           END-IF.
      *
           CLOSE                           EIE00-FILE.
      *
       T-000-READCHEK-EXT.
           EXIT.
      *
      ********************
       T-000-READCHEK1-SEC               SECTION.
      *
           MOVE    EIE00-REC(1:20)      TO  WK-TBL-MSG (IDX1).
           MOVE    EIE00-REC(22:1)      TO  WK-TBL-KBN1 (IDX1).
           MOVE    EIE00-REC(24:1)      TO  WK-TBL-KBN2 (IDX1).
           IF      (IDX2            =   ZERO)  AND
                   (EIE00-REC(22:1) =   "*")
               MOVE    IDX1                 TO    IDX2
           END-IF.
           MOVE    ALL SPACE            TO  EIE01PARA-FILE.
           STRING  WK-TBL-MSG (IDX1)    DELIMITED  BY    SPACE
                   ".SLT"               DELIMITED  BY    SIZE
                                        INTO       EIE01PARA-FILE.
           OPEN    INPUT                EIE01-FILE.
           IF      STS-EIE01         =   ZERO
               READ    EIE01-FILE
                       NOT  AT  END
                   READ    EIE01-FILE
                           NOT  AT  END
                       MOVE    "*"              TO  WK-TBL-KBN2 (IDX1)
                   END-READ
               END-READ
           END-IF.
           CLOSE                        EIE01-FILE.
      *
       T-000-READCHEK1-EXT.
           EXIT.
      *
      *****************************************************************
      *    作成条件 入力処理
      *****************************************************************
       T-001-READCHEK-SEC                SECTION.
      *
           OPEN    INPUT                   EIE01-FILE.
      *
           MOVE    ZERO                    TO  SPA-GMN-MAX-B.
      *
           IF      STS-EIE01         =   ZERO
              READ    EIE01-FILE
                      NOT  AT  END
                           MOVE    EIE01-REC(1:6)
                                   TO  SPA-GMN-SRYYM
                           MOVE    EIE01-REC(8:128)
                                   TO  SPA-GMN-FILE-ID
                           MOVE    EIE01-REC(137:64)
                                   TO  SPA-GMN-FILE-KEY
                           PERFORM VARYING IDX1  FROM  1  BY 1
                                   UNTIL   IDX1  >   500
                               READ    EIE01-FILE
                                 AT   END
                                      MOVE    501
                                              TO  IDX1
                                 NOT  AT  END
                                      MOVE    EIE01-REC
                                              TO  WK-TBL-MSG-B (IDX1)
                                      MOVE    IDX1
                                              TO  SPA-GMN-MAX-B
                               END-READ
                           END-PERFORM
              END-READ
           END-IF.
      *
           CLOSE                           EIE01-FILE.
      *
       T-001-READCHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＣＳＶ作成条件 更新出力処理
      *****************************************************************
       T-000-WRITCHEK-SEC                SECTION.
      *
           OPEN    OUTPUT                  EIE00-FILE.
      *
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >    60
               IF      WK-TBL-MSG (IDX1)  NOT =  SPACE
                   MOVE    WK-TBL-MSG (IDX1)
                           TO  EIE00-REC(1:20)
                   MOVE    WK-TBL-KBN1 (IDX1)
                           TO  EIE00-REC(22:1)
                   MOVE    WK-TBL-KBN2 (IDX1)
                           TO  EIE00-REC(24:1)
                   WRITE   EIE00-REC
               END-IF
           END-PERFORM.
      *
           CLOSE                           EIE00-FILE.
      *
       T-000-WRITCHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    作成条件 出力処理
      *****************************************************************
       T-001-WRITCHEK-SEC                SECTION.
      *
           OPEN    OUTPUT                  EIE01-FILE.
      *
           MOVE    SPACE                   TO  EIE01-REC.
           MOVE    SPA-GMN-SRYYM           TO  EIE01-REC.
           MOVE    SPA-GMN-FILE-ID         TO  EIE01-REC(8:128).
           MOVE    SPA-GMN-FILE-KEY        TO  EIE01-REC(137:64).
           WRITE   EIE01-REC.
      *
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >     SPA-GMN-MAX-B
               MOVE    SPACE                   TO  EIE01-REC
               MOVE    WK-TBL-MSG-B (IDX1)     TO  EIE01-REC
               WRITE   EIE01-REC
           END-PERFORM.
      *
           CLOSE                           EIE01-FILE.
      *
           IF      SPA-GMN-MAX-B NOT =  ZERO
                MOVE    "*"                   TO  WK-TBL-KBN2 (IDX2)
           ELSE
                MOVE    SPACE                 TO  WK-TBL-KBN2 (IDX2)
           END-IF.
      *
       T-001-WRITCHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    作成テーブル 判定処理
      *****************************************************************
       T-001-HANTCHEK-SEC                SECTION.
      *
           IF      SPA-GMN-MAX-B NOT =  ZERO
                MOVE    "*"                   TO  WK-TBL-KBN2 (IDX2)
           END-IF.
      *
           COMPUTE   IDX3 = IDX2 + 1.
           MOVE    ZERO                  TO  IDX2.
      *
           PERFORM VARYING IDX1  FROM  IDX3  BY 1
                   UNTIL   IDX1  >    60
               IF      WK-TBL-KBN1 (IDX1) =   "*"
                   MOVE    IDX1                  TO  IDX2
                   MOVE    61                    TO  IDX1
               END-IF
           END-PERFORM.
      *
           IF      IDX2 =   ZERO
               PERFORM VARYING IDX1  FROM  1  BY 1
                       UNTIL   IDX1  >    60
                   IF      WK-TBL-KBN1 (IDX1) =   "*"
                       MOVE    IDX1                  TO  IDX2
                       MOVE    61                    TO  IDX1
                   END-IF
               END-PERFORM
           END-IF.
      *      
       T-001-HANITCHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル項目名 設定処理
      *****************************************************************
       T-000-SETECHEK-SEC                SECTION.
      *
           MOVE    SPACE                 TO  SPA-GMN-AREA.
           MOVE    WK-TBL-MSG (IDX2)     TO  SPA-GMN-TBLNM.
           MOVE    ALL SPACE             TO  EIE01PARA-FILE.
           STRING  WK-TBL-MSG (IDX2)     DELIMITED  BY    SPACE
                   ".SLT"                DELIMITED  BY    SIZE
                                         INTO       EIE01PARA-FILE.
           MOVE    ALL SPACE             TO  EIE02PARA-FILE.
           STRING  WK-TBL-MSG (IDX2)     DELIMITED  BY    SPACE
                   ".CNV"                DELIMITED  BY    SIZE
                                         INTO       EIE02PARA-FILE.
           MOVE    ALL SPACE             TO  SPA-GMN-FILE-ID.
           STRING  "/tmp/"               DELIMITED  BY    SIZE
                   WK-TBL-MSG (IDX2)     DELIMITED  BY    SPACE
                   ".TXT"                DELIMITED  BY    SIZE
                                         INTO       SPA-GMN-FILE-ID.
           MOVE    ALL SPACE             TO  SPA-GMN-FILE-KEY.
           STRING  WK-TBL-MSG (IDX2)     DELIMITED  BY    SPACE
                   "-ALL"                DELIMITED  BY    SIZE
                                         INTO       SPA-GMN-FILE-KEY.
      *
           MOVE    1                     TO  IDX4.
           MOVE    ZERO                  TO  FLG-FIL.
           MOVE    SPACE                 TO  FLG-SEL.
           MOVE    SPACE                 TO  WK-TBL2.
      *     
           OPEN    INPUT                 EIE02-FILE.
      *
           IF  STS-EIE02   =   ZERO
               PERFORM UNTIL   FLG-FIL  =    1
                   READ    EIE02-FILE
                           AT   END
                                MOVE    1
                                        TO  FLG-FIL
                           NOT  AT  END
                                MOVE    EIE02-REC
                                        TO  WK-TBL-MSG-C (IDX4)
                                MOVE    "F"
                                        TO  WK-TBL-BTN-C (IDX4)
                                COMPUTE   IDX4 = IDX4 + 1
                   END-READ
               END-PERFORM
           END-IF.
      *
           CLOSE                           EIE02-FILE.
      *
       T-000-SETECHEK-EXT.
           EXIT.
      *
