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
       PROGRAM-ID.                 ORCGO01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者請求業務
      *  コンポーネント名  : 定期請求（Ｏ０１）
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
           COPY    "O01COMMON-SPA".     
      *   
           COPY    "ENUM-VALUE".
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-ERR             PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
      *
      *    年月日 領域
       01  WRK-HEN-AREA.
           03  WRK-YMD             PIC 9(08).
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMDG3        PIC X(22).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
           03  WRK-HENTIME.
               05  WRK-HH          PIC X(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-MM          PIC X(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-SS          PIC X(02).
      *
      *    メッセージ領域
       01  T-MESSAGE-AREA.
           03  T-MESSAGE-001       PIC X(24)   VALUE
               "請求年月入力エラーです。".
           03  T-MESSAGE-002       PIC X(24)   VALUE
               "作成条件入力エラーです。".
           03  T-MESSAGE-051       PIC X(22)   VALUE
               "患者請求を作成します。".
           03  T-MESSAGE-052       PIC X(24)   VALUE
               "個別作成指示に移ります。".
      *                             
       01  WRK-SHELL-NAME.
           05  FILLER             PIC X(16) VALUE
                                             "scripts/monthly/".
           05  WRK-SHELL-SHELL    PIC X(20).         
      *              
      *
       01  WRK-CONS-AREA.
      *    ジョブ管理ＤＢのキー値  
           03  WRK-CONS-JOB-SHELLID
                                   PIC X(08)   VALUE   "TEIKI1".
           03  WRK-CONS-JOB-JOBID  PIC 9(07)   VALUE   1.
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
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *   画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".         
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
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-O01
           MOVE    SPA-WORK        TO  SPA-O01KYOUTU
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
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
           END-EVALUATE
      *     
      *    画面遷移がない時、画面表示へ
           IF  FLG-END   =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF.
      *
           MOVE    SPA-O01KYOUTU   TO  SPA-WORK
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
           IF  SPA-MOTOPG   =   "OERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5011-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF      FLG-END             =   1
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF.
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "O01    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
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
      *    他のＬＤより
           IF  LINKAREA   NOT =   SPACE
               MOVE    LNK-KYOUTU      TO  SPA-KYOUTU
               MOVE    SPA-MOTOPG      TO  SPA-MOTOPG2
               INITIALIZE              SPA-O01KYOUTU
           END-IF.
      *
           MOVE    1                       TO  SPA-GMN-CUR. 
      *
           EVALUATE    SPA-MOTOPG
               WHEN    "OID1"
                   PERFORM 330-OID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
               WHEN    "O99"
                   PERFORM 340-OID2-SET-SEC
                   GO      TO      300-SCREEN-EXT
           END-EVALUATE

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
           INITIALIZE              SPA-O01.
      *
           MOVE    SPA-MOTOPG          TO  SPA-NAI-MOTOPG.
           MOVE    1                   TO  SPA-GMN-CUR.
           MOVE    1                   TO  SPA-GMN-PAGE.
      *
           MOVE    SPACE               TO  SPA-GMN-SEIYM.
           MOVE    SPACE               TO  SPA-GMN-KKBN01.
           MOVE    SPACE               TO  SPA-GMN-KKBN02.
           MOVE    SPACE               TO  SPA-GMN-KKBN03.
           MOVE    SPACE               TO  SPA-GMN-KKBN04.
           MOVE    SPACE               TO  SPA-GMN-KKBN05.
           MOVE    "指定なし"          TO  SPA-GMN-KIKAN01.
           MOVE    "指定なし"          TO  SPA-GMN-KIKAN02.
           MOVE    "指定なし"          TO  SPA-GMN-KIKAN03.
           MOVE    "F"                 TO  SPA-GMN-CHKBUTON01.
           MOVE    "F"                 TO  SPA-GMN-CHKBUTON02.
           MOVE    "F"                 TO  SPA-GMN-CHKBUTON03.
           MOVE    "F"                 TO  SPA-GMN-CHKBUTON04.
           MOVE    "F"                 TO  SPA-GMN-CHKBUTON05.
      *
           MOVE    SPACE               TO  SYS-5010-REC.
           INITIALIZE                      SYS-5010-REC.
           MOVE    "5010"              TO  SYS-5010-KANRICD.
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD.
           MOVE    SYS-5010-REC        TO  MCPDATA-REC.
           PERFORM 900-SYSKANRI-SEC.
      *
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-OID1-SET-SEC            SECTION.
      *
           IF  SPA-GMN-KBN   =   "OK"
               PERFORM 490-KOUSHIN-SEC
           END-IF
      *
           MOVE    SPACE           TO  SPA-OID1-FLG
                                       SPA-O99-FLG
           MOVE    SPACE           TO  SPA-OIDCD
           MOVE    SPACE           TO  SPA-OIDCD2      
           .
       330-OID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ２）ＯＫ処理
      *****************************************************************
       340-OID2-SET-SEC            SECTION.
      *
           IF      SPA-O99-FLG     =   "OK"
               PERFORM 4501-NEXT-GMN-SEC
           END-IF    
      *
           MOVE    SPACE           TO  SPA-OID1-FLG
                                       SPA-O99-FLG
           MOVE    SPACE           TO  SPA-OIDCD
           MOVE    SPACE           TO  SPA-OIDCD2      
           .
       340-OID2-SET-EXT.
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
               WHEN    "CLICKED"       ALSO    "CHKBUTON01"
                   PERFORM T-000-CHKBUTON01-SEC
               WHEN    "CLICKED"       ALSO    "CHKBUTON02"
                   PERFORM T-000-CHKBUTON02-SEC
               WHEN    "CLICKED"       ALSO    "CHKBUTON03"
                   PERFORM T-000-CHKBUTON03-SEC
               WHEN    "CLICKED"       ALSO    "CHKBUTON04"
                   PERFORM T-000-CHKBUTON04-SEC
               WHEN    "CLICKED"       ALSO    "CHKBUTON05"
                   PERFORM T-000-CHKBUTON05-SEC
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
               WHEN    "ACTIVATE"      ALSO    "SEIYM"
                   PERFORM T-000-SEIYM-SEC
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
           MOVE    "M01"               TO  SPA-SAKIPG.
           MOVE    SPACE               TO  SPA-MOTOPG2.
           MOVE    "O01"               TO  SPA-MOTOPG.
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
      *    個別作成、抽出処理
      *****************************************************************
       490-KOUSHIN-SEC           SECTION.
      *
           IF  SPA-GMN-KKBN01   =   "1"
      *
      *            ジョブ開始セット
                   MOVE    "DEL"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    WRK-CONS-JOB-JOBID
                                           TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA 
                                           JOBKANRI-REC
      *
                   MOVE    "JBS"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    WRK-CONS-JOB-JOBID
                                           TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   MOVE    SPA-TERMID      TO  JOB-TERMID                        
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA 
                                          JOBKANRI-REC
      *
      *            印刷用スクリプト処理
                   MOVE    SPACE           TO  SHELLTBL
                   MOVE    "teikiseikyu.sh"    TO  WRK-SHELL-SHELL
                   MOVE    WRK-CONS-JOB-JOBID
                                           TO  SHELLTBL-ARG1
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  SHELLTBL-ARG2
      *            ファイルデイレクトリ位置指定
                   INITIALIZE              ORCSMKPASSAREA
                   MOVE    WRK-SHELL-NAME  TO  MKPASS-IN-01
                   CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
                   MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
                   MOVE    SHELLTBL        TO  MCPDATA-REC
                   MOVE    "SHELL"         TO  MCP-FUNC
                   MOVE    PATH-SHELL-SHELL
                                           TO  MCP-PATH
                   CALL    "MCPSUB"        USING
                                               MCPAREA
                                               MCPDATA-REC
      *            情報確認画面を表示                                                   
                   PERFORM 490-KAKUNIN-SEC
           END-IF.
      *
       490-KOUSHIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新処理
      *****************************************************************
       4501-NEXT-GMN-SEC            SECTION.       
      * 
           MOVE    "O01"               TO  SPA-MOTOPG
           MOVE    "O03"               TO  SPA-SAKIPG
      *
           MOVE   "JOIN"              TO  MCP-PUTTYPE
           MOVE   SPA-SAKIPG           TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       4501-NEXT-GMN-EXT.
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
           MOVE    "O01"           TO  MCP-WINDOW.
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
           MOVE    SPACE                   TO  O01.
      *
           MOVE    SPA-GMN-CHKBUTON01      TO  O01-CHKBUTON01.
           MOVE    SPA-GMN-CHKBUTON02      TO  O01-CHKBUTON02.
           MOVE    SPA-GMN-CHKBUTON03      TO  O01-CHKBUTON03.
           MOVE    SPA-GMN-CHKBUTON04      TO  O01-CHKBUTON04.
           MOVE    SPA-GMN-CHKBUTON05      TO  O01-CHKBUTON05.
           MOVE    SPA-GMN-SEIYM           TO  O01-SEIYM.
           MOVE    SPA-GMN-KIKAN01         TO  O01-KIKAN01.
           MOVE    SPA-GMN-KIKAN02         TO  O01-KIKAN02.
           MOVE    SPA-GMN-KIKAN03         TO  O01-KIKAN03.
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
                   MOVE    "SEIYM"         TO  MCP-WIDGET
               WHEN    02
                   MOVE    "CHKBUTON02"    TO  MCP-WIDGET
               WHEN    03
                   MOVE    "CHKBUTON03"    TO  MCP-WIDGET
               WHEN    04
                   MOVE    "CHKBUTON04"    TO  MCP-WIDGET
               WHEN    05
                   MOVE    "B12"           TO  MCP-WIDGET
           END-EVALUATE.
      *
       5011-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認メッセージ表示
      *****************************************************************
       530-RIDSET2-SEC              SECTION.
      *
           IF  (SPA-GMN-KKBN01   =   SPACE)  AND
               (SPA-GMN-KKBN05   =   SPACE)
               MOVE    "0002"                TO  OERR-ERRCODE
               MOVE    T-MESSAGE-002         TO  OERR-ERRMSG
               MOVE    "B01"                 TO  MCP-WIDGET
               MOVE    "O01"                 TO  SPA-MOTOPG
               MOVE    "OERR"                TO  SPA-SAKIPG
               MOVE    "NEW"                 TO  MCP-PUTTYPE
               MOVE    "OERR"                TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    1                     TO  SPA-GMN-CUR
               MOVE    1                     TO  FLG-END
           ELSE
               IF  (SPA-GMN-KKBN01   =   "1")  AND
                   ((SPA-GMN-SEIYM    =   SPACE)  OR
                    ((SPA-GMN-CHKBUTON02   =   "F")  AND
                     (SPA-GMN-CHKBUTON03   =   "F")  AND
                     (SPA-GMN-CHKBUTON04   =   "F")))
                   MOVE    "0002"                TO  OERR-ERRCODE
                   MOVE    T-MESSAGE-002         TO  OERR-ERRMSG
                   MOVE    "B01"                 TO  MCP-WIDGET
                   MOVE    "O01"                 TO  SPA-MOTOPG
                   MOVE    "OERR"                TO  SPA-SAKIPG
                   MOVE    "NEW"                 TO  MCP-PUTTYPE
                   MOVE    "OERR"                TO  MCP-WINDOW
                   PERFORM 900-PUT-WINDOW
                   MOVE    1                     TO  SPA-GMN-CUR
                   MOVE    1                     TO  FLG-END
               ELSE
                   IF  SPA-GMN-KKBN01   =   "1"
                       MOVE    SPACE                 TO  OID1
                       MOVE    "1001"                TO  OID1-ID1CODE
                       MOVE    T-MESSAGE-051         TO  OID1-ID1MSG
                       MOVE    "B12"                 TO  MCP-WIDGET
                       MOVE    "O01"                 TO  SPA-MOTOPG
                       MOVE    "OID1"                TO  SPA-SAKIPG
                       MOVE    "NEW"                 TO  MCP-PUTTYPE
                       MOVE    "OID1"                TO  MCP-WINDOW
                       PERFORM 900-PUT-WINDOW
                       MOVE    1                     TO  FLG-END
                   ELSE
                       MOVE    SPACE                 TO  LINKAREA
                       MOVE    SPA-KYOUTU            TO  LNK-COMMON
                       MOVE    SPA-O01               TO  LNK-SCRSPA
                       MOVE    "O01"                 TO  SPA-MOTOPG
                       MOVE    "O02"                 TO  SPA-SAKIPG
                       MOVE    SPA-KYOUTU            TO  LNK-KYOUTU
                       MOVE    "CHANGE"              TO  MCP-PUTTYPE
                       MOVE    "O02"                 TO  MCP-WINDOW
                       PERFORM 900-PUT-WINDOW
                       MOVE    1                     TO  FLG-END
                   END-IF
               END-IF
           END-IF.
      *
       530-RIDSET2-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理確認処理
      *****************************************************************
       490-KAKUNIN-SEC            SECTION.
      *                                      
           MOVE    SPACE               TO  O99
           MOVE    ZERO                TO  O99-COUNT
                                           O99-PROGRESSBAR-VALUE
      *
      *    ジョブ管理チェック処理
           MOVE    "CHK"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA 
                                   JOBKANRI-REC 
           IF      SJOBKANRI-RETURN
                                   =   ZERO
               MOVE    1               TO  IDX                     
               MOVE    JOB-JOBID       TO  O99-RENNUM   (IDX)
               MOVE    JOB-SHELLMSG    TO  O99-SHORINM  (IDX)
               MOVE    JOB-STARTTIME(1:2)
                                       TO  WRK-HH
               MOVE    JOB-STARTTIME(3:2)
                                       TO  WRK-MM
               MOVE    JOB-STARTTIME(5:2)
                                       TO  WRK-SS
               MOVE    WRK-HENTIME     TO  O99-STARTTIME(IDX)
               MOVE    JOB-ENDTIME(1:2)
                                       TO  WRK-HH
               MOVE    JOB-ENDTIME(3:2)
                                       TO  WRK-MM
               MOVE    JOB-ENDTIME(5:2)
                                       TO  WRK-SS
               MOVE    WRK-HENTIME     TO  O99-ENDTIME  (IDX)
               MOVE    JOB-YOBI        TO  O99-ERRMSG   (IDX)
               IF      JOB-ENDYMD      =   SPACE
                   MOVE    "処理中です"    TO  O99-MSG
               ELSE
                   IF      JOB-ERRCD       =   SPACE
                       CONTINUE
                   ELSE
                       STRING  JOB-YOBI    DELIMITED  BY  SPACE
                               "【"        DELIMITED  BY  SIZE
                              JOB-SHELLMSG DELIMITED  BY  SPACE
                              "】"         DELIMITED  BY  SIZE      
                                           INTO  O99-MSG
                   END-IF                          
               END-IF    
               MOVE    IDX                     TO  O99-COUNT    
           END-IF
      *
           MOVE    WIDGET-INSENSITIVE   TO  O99-B12-STATE
           IF      O99-MSG              =   SPACE
               IF      O99-COUNT            >   ZERO    
                   MOVE    WIDGET-NORMAL        TO  O99-B12-STATE
                   MOVE    "B12"                TO  MCP-WIDGET
                   MOVE    "処理は正常に終了しました"
                                                TO  O99-MSG
               ELSE
                   MOVE    "B01"                TO  MCP-WIDGET
                   MOVE    "該当する処理はありません"
                                                TO  O99-MSG
               END-IF                                 
           ELSE                                        
               MOVE    "B11"                TO  MCP-WIDGET
           END-IF
      *
           MOVE    "O01"                TO  SPA-MOTOPG
           MOVE    "O99"                TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "O99"                TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
           .
       490-KAKUNIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    情報削除画面へ
      *****************************************************************
       490-JYOUHOU-DEL-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-O01             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "R03"               TO  SPA-MOTOPG
           MOVE    "XB01"              TO  SPA-SAKIPG
      *
           MOVE    WRK-CONS-JOB-SHELLID
                                       TO  SPA-JOB-SHELLID
      *          
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   "XB01   "            TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       490-JYOUHOU-DEL-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    管理マスター読込
      *****************************************************************
       900-SYSKANRI-SEC               SECTION.
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
                   MOVE    MCPDATA-REC         TO  SYS-5010-REC
               END-IF
           END-IF.
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC.
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
       900-SYSKANRI-EXT.
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
      *    一括作成 確認処理
      *****************************************************************
       T-000-CHKBUTON01-SEC              SECTION.
      *
           EVALUATE    SPA-GMN-CHKBUTON01
               WHEN    "T"
                   MOVE    "F"       TO  SPA-GMN-CHKBUTON01
                   MOVE    "F"       TO  SPA-GMN-CHKBUTON02
                   MOVE    "F"       TO  SPA-GMN-CHKBUTON03
                   MOVE    "F"       TO  SPA-GMN-CHKBUTON04
                   MOVE    "T"       TO  SPA-GMN-CHKBUTON05
                   MOVE    SPACE     TO  SPA-GMN-SEIYM
                   MOVE    SPACE     TO  SPA-GMN-KIKAN01
                   MOVE    SPACE     TO  SPA-GMN-KIKAN02
                   MOVE    SPACE     TO  SPA-GMN-KIKAN03
                   MOVE    SPACE     TO  SPA-GMN-KKBN01
                   MOVE    SPACE     TO  SPA-GMN-KKBN02
                   MOVE    SPACE     TO  SPA-GMN-KKBN03
                   MOVE    SPACE     TO  SPA-GMN-KKBN04
                   MOVE    "1"       TO  SPA-GMN-KKBN05
               WHEN    OTHER
                   MOVE    "T"       TO  SPA-GMN-CHKBUTON01
                   MOVE    "F"       TO  SPA-GMN-CHKBUTON05
                   MOVE    "1"       TO  SPA-GMN-KKBN01
                   MOVE    SPACE     TO  SPA-GMN-KKBN05
           END-EVALUATE.
      *
       T-000-CHKBUTON01-EXT.
           EXIT.
      *
      *****************************************************************
      *    １期 確認処理
      *****************************************************************
       T-000-CHKBUTON02-SEC              SECTION.
      *
           MOVE    3                   TO  SPA-GMN-CUR.
      *
           IF  SPA-GMN-KKBN02   NOT =   SPACE
               EVALUATE    SPA-GMN-CHKBUTON02
                   WHEN    "T"
                       MOVE    "F"       TO  SPA-GMN-CHKBUTON02
                   WHEN    OTHER
                       MOVE    "T"       TO  SPA-GMN-CHKBUTON02
               END-EVALUATE
           END-IF.
      *
       T-000-CHKBUTON02-EXT.
           EXIT.
      *
      *****************************************************************
      *    ２期 確認処理
      *****************************************************************
       T-000-CHKBUTON03-SEC              SECTION.
      *
           MOVE    4                   TO  SPA-GMN-CUR.
      *
           IF  SPA-GMN-KKBN03   NOT =   SPACE
               EVALUATE    SPA-GMN-CHKBUTON03
                   WHEN    "T"
                       MOVE    "F"       TO  SPA-GMN-CHKBUTON03
                   WHEN    OTHER
                       MOVE    "T"       TO  SPA-GMN-CHKBUTON03
               END-EVALUATE
           END-IF.
      *
       T-000-CHKBUTON03-EXT.
           EXIT.
      *
      *****************************************************************
      *    ３期 確認処理
      *****************************************************************
       T-000-CHKBUTON04-SEC              SECTION.
      *
           MOVE    5                   TO  SPA-GMN-CUR.
      *
           IF  SPA-GMN-KKBN04   NOT =   SPACE
               EVALUATE    SPA-GMN-CHKBUTON04
                   WHEN    "T"
                       MOVE    "F"       TO  SPA-GMN-CHKBUTON04
                   WHEN    OTHER
                       MOVE    "T"       TO  SPA-GMN-CHKBUTON04
               END-EVALUATE
           END-IF.
      *
       T-000-CHKBUTON04-EXT.
           EXIT.
      *
      *****************************************************************
      *    個別作成 確認処理
      *****************************************************************
       T-000-CHKBUTON05-SEC              SECTION.
      *
           EVALUATE    SPA-GMN-CHKBUTON05
               WHEN    "T"
                   MOVE    "F"       TO  SPA-GMN-CHKBUTON05
                   MOVE    "T"       TO  SPA-GMN-CHKBUTON01
                   MOVE    SPACE     TO  SPA-GMN-KKBN05
                   MOVE    "1"       TO  SPA-GMN-KKBN01
               WHEN    OTHER
                   MOVE    "T"       TO  SPA-GMN-CHKBUTON05
                   MOVE    "F"       TO  SPA-GMN-CHKBUTON04
                   MOVE    "F"       TO  SPA-GMN-CHKBUTON03
                   MOVE    "F"       TO  SPA-GMN-CHKBUTON02
                   MOVE    "F"       TO  SPA-GMN-CHKBUTON01
                   MOVE    "1"       TO  SPA-GMN-KKBN05
                   MOVE    SPACE     TO  SPA-GMN-KKBN04
                   MOVE    SPACE     TO  SPA-GMN-KKBN03
                   MOVE    SPACE     TO  SPA-GMN-KKBN02
                   MOVE    SPACE     TO  SPA-GMN-KKBN01
                   MOVE    SPACE     TO  SPA-GMN-KIKAN03
                   MOVE    SPACE     TO  SPA-GMN-KIKAN02
                   MOVE    SPACE     TO  SPA-GMN-KIKAN01
                   MOVE    SPACE     TO  SPA-GMN-SEIYM
           END-EVALUATE.
      *
       T-000-CHKBUTON05-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求年月 確認処理
      *****************************************************************
       T-000-SEIYM-SEC                   SECTION.
      *
           MOVE    2                   TO  SPA-GMN-CUR.
           MOVE    1                   TO  FLG-ERR.
      *
           INITIALIZE                  ORCSGDAYAREA.
           MOVE    "1"                 TO  SGDAY-INTYPE.
           MOVE    O01-SEIYM           TO  SGDAY-INDAY.
           CALL    "ORCSGDAY"          USING   ORCSGDAYAREA.
           IF  SGDAY-RC   =   ZERO
               MOVE    SGDAY-SDAY(1:6)       TO  SPA-GMN-SEIYM
               MOVE    SGDAY-SDAY            TO  WRK-YMD
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
                   MOVE    SGDAY-OTDAY(1:6)         TO  SPA-GMN-SEIYM
                   MOVE    ZERO                     TO  FLG-ERR
               END-IF
           END-IF.
      *
           IF  FLG-ERR   =   1
               MOVE    "0001"                TO  OERR-ERRCODE
               MOVE    T-MESSAGE-001         TO  OERR-ERRMSG
               MOVE    "B01"                 TO  MCP-WIDGET
               MOVE    "O01"                 TO  SPA-MOTOPG
               MOVE    "OERR"                TO  SPA-SAKIPG
               MOVE    "NEW"                 TO  MCP-PUTTYPE
               MOVE    "OERR"                TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    1                     TO  SPA-GMN-CUR
               MOVE    1                     TO  FLG-END
           ELSE
               DISPLAY "  **SYS-5010-SEIKYU-DAY1=" SYS-5010-SEIKYU-DAY1
               DISPLAY "  **SYS-5010-SEIKYU-DAY2=" SYS-5010-SEIKYU-DAY2
               DISPLAY "  **SYS-5010-SEIKYU-DAY3=" SYS-5010-SEIKYU-DAY3
               IF  SYS-5010-SEIKYU-DAY1   NOT =   ZERO
                   MOVE    "1"                   TO   SPA-GMN-KKBN02
                   INITIALIZE                    ORCSGDAYAREA
                   MOVE    SPACE                 TO  SGDAY-INTYPE
                   MOVE    "01"                  TO  WRK-YMD(7:2)
                   MOVE    WRK-YMD               TO  SGDAY-INDAY
                   CALL    "ORCSGDAY"            USING   ORCSGDAYAREA
                   IF  SGDAY-RC   =   ZERO
                       MOVE    SGDAY-OTDAY
                                               TO  SPA-GMN-KIKAN01(1:9)
                   END-IF
                   MOVE    "〜"                TO  SPA-GMN-KIKAN01(10:2)
                   INITIALIZE                    ORCSGDAYAREA
                   MOVE    SPACE                 TO  SGDAY-INTYPE
                   MOVE    SYS-5010-SEIKYU-DAY1  TO  WRK-YMD(7:2)
                   MOVE    WRK-YMD               TO  SGDAY-INDAY
                   CALL    "ORCSGDAY"            USING   ORCSGDAYAREA
                   IF  SGDAY-RC   =   ZERO
                       MOVE    SGDAY-OTDAY
                                               TO  SPA-GMN-KIKAN01(12:9)
                   END-IF
               END-IF
               IF  SYS-5010-SEIKYU-DAY2   NOT =   ZERO
                   MOVE    "1"                   TO   SPA-GMN-KKBN03
                   INITIALIZE                    ORCSGDAYAREA
                   MOVE    SPACE                 TO  SGDAY-INTYPE
                   COMPUTE WRK-YMD  =  WRK-YMD  +  1
                   MOVE    WRK-YMD               TO  SGDAY-INDAY
                   CALL    "ORCSGDAY"            USING   ORCSGDAYAREA
                   IF  SGDAY-RC   =   ZERO
                       MOVE    SGDAY-OTDAY
                                               TO  SPA-GMN-KIKAN02(1:9)
                   END-IF
                   MOVE    "〜"                TO  SPA-GMN-KIKAN02(10:2)
                   INITIALIZE                    ORCSGDAYAREA
                   MOVE    SPACE                 TO  SGDAY-INTYPE
                   MOVE    SYS-5010-SEIKYU-DAY2  TO  WRK-YMD(7:2)
                   MOVE    WRK-YMD               TO  SGDAY-INDAY
                   CALL    "ORCSGDAY"            USING   ORCSGDAYAREA
                   IF  SGDAY-RC   =   ZERO
                       MOVE    SGDAY-OTDAY
                                               TO  SPA-GMN-KIKAN02(12:9)
                   END-IF
               END-IF
               IF  SYS-5010-SEIKYU-DAY3   NOT =   ZERO
                   MOVE    "1"                   TO   SPA-GMN-KKBN04
                   INITIALIZE                    ORCSGDAYAREA
                   MOVE    SPACE                 TO  SGDAY-INTYPE
                   COMPUTE WRK-YMD  =  WRK-YMD  +  1
                   MOVE    WRK-YMD               TO  SGDAY-INDAY
                   CALL    "ORCSGDAY"            USING   ORCSGDAYAREA
                   IF  SGDAY-RC   =   ZERO
                       MOVE    SGDAY-OTDAY
                                               TO  SPA-GMN-KIKAN03(1:9)
                   END-IF
                   MOVE    "〜"                TO  SPA-GMN-KIKAN03(10:2)
                   INITIALIZE                    ORCSGDAYAREA
                   MOVE    SPACE                 TO  SGDAY-INTYPE
                   MOVE    SYS-5010-SEIKYU-DAY3  TO  WRK-YMD(7:2)
                   MOVE    WRK-YMD               TO  SGDAY-INDAY
                   CALL    "ORCSGDAY"            USING   ORCSGDAYAREA
                   IF  SGDAY-RC   =   ZERO
                       MOVE    SGDAY-OTDAY
                                               TO  SPA-GMN-KIKAN03(12:9)
                   END-IF
               END-IF
           END-IF.
      *
       T-000-SEIYM-EXT.
           EXIT.
      *