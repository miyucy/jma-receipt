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
       PROGRAM-ID.                 ORCGO03.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者請求業務
      *  コンポーネント名  : エラーメッセージ（Ｏ０３）
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
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
      *
      *
       01  WRK-HEN-AREA.
           03  WRK-PAGE            PIC ZZZZZZZZZ9.
           03  WRK-HENTIME.
               05  WRK-HH          PIC X(02).
               05  FILLER          PIC X(01)   VALUE   ":".
               05  WRK-MM          PIC X(02).
               05  FILLER          PIC X(01)   VALUE   ":".
               05  WRK-SS          PIC X(02).
      *
      *    メッセージ領域
       01  T-MESSAGE-AREA.
           03  T-MESSAGE-001       PIC X(22)   VALUE
               "印刷順入力エラーです。".
           03  T-MESSAGE-002       PIC X(52)   VALUE
               "指定された条件で実行中のためしばらくお待ちください。".
           03  T-MESSAGE-003       PIC X(20)   VALUE
               "印刷処理を行います。".
           03  T-MESSAGE-051       PIC X(22)   VALUE
               "患者請求を作成します。".
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
      *    シェル用領域
           COPY    "CPSHELLTBL.INC".
           COPY    "ORCA-DBPATH".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    印刷ＤＢ更新サブ
           COPY    "CPORCSPRT.INC".
      *
      *    シェル用領域
           COPY    "CPSHELLTBL.INC".
           COPY    "ORCA-DBPATH".
      *
      *    出力先プリンタ名割り当て情報
           COPY    "CPSK1031.INC".
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    請求管理マスタ
           COPY    "CPSK5010.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
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
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
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
           MOVE    SPA-WORK        TO  SPA-O01KYOUTU
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
      *???
           DISPLAY "STATUS=" MCP-STATUS "EVENT=" MCP-EVENT "##"
      *???     
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
           MOVE    "O03    "           TO  MCP-WINDOW.
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
               MOVE    LNK-KYOUTU              TO  SPA-KYOUTU
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
           MOVE    SPA-MOTOPG              TO  SPA-NAI-MOTOPG.
           MOVE    1                       TO  SPA-GMN-CUR.
           MOVE    1                       TO  SPA-GMN-PAGE.
      *
           MOVE    SPACE                   TO  SPA-GMN-PRJUN-S.
           MOVE    "1"                     TO  SPA-GMN-PRJUN-1 (1).
           MOVE    "カナ氏名順"            TO  SPA-GMN-PRJUN-3 (1).
           MOVE    "2"                     TO  SPA-GMN-PRJUN-1 (2).
           MOVE    "患者番号順"            TO  SPA-GMN-PRJUN-3 (2).
           MOVE    "3"                     TO  SPA-GMN-PRJUN-1 (3).
           MOVE    "請求期間＋カナ氏名順"  TO  SPA-GMN-PRJUN-3 (3).
           MOVE    "4"                     TO  SPA-GMN-PRJUN-1 (4).
           MOVE    "請求期間＋患者番号順"  TO  SPA-GMN-PRJUN-3 (4).
      *
      *    ここを作成済請求件数取り込みに変更する
           MOVE    "H14. 1.01〜H14. 1.15"  TO  SPA-GMN-T-KIKAN (1).
           MOVE    "5件"                   TO  SPA-GMN-T-KENSU (1).
           MOVE    "6枚"                   TO  SPA-GMN-T-MAISU (1).
           MOVE    "H14. 1.16〜H14. 1.20"  TO  SPA-GMN-T-KIKAN (2).
           MOVE    "1件"                   TO  SPA-GMN-T-KENSU (2).
           MOVE    "3枚"                   TO  SPA-GMN-T-MAISU (2).
           MOVE    "その他"                TO  SPA-GMN-T-KIKAN (3).
           MOVE    "7件"                   TO  SPA-GMN-T-KENSU (3).
           MOVE    "7枚"                   TO  SPA-GMN-T-MAISU (3).
           MOVE    "テストでの表示０１"    TO  SPA-GMN-T-KIKAN (4).
           MOVE    "10件"                  TO  SPA-GMN-T-KENSU (4).
           MOVE    "66枚"                  TO  SPA-GMN-T-MAISU (4).
           MOVE    "テストでの表示０２"    TO  SPA-GMN-T-KIKAN (5).
           MOVE    "8件"                   TO  SPA-GMN-T-KENSU (5).
           MOVE    "1枚"                   TO  SPA-GMN-T-MAISU (5).
           MOVE    "テストでの表示０３３"  TO  SPA-GMN-T-KIKAN (6).
           MOVE    "9件"                   TO  SPA-GMN-T-KENSU (6).
           MOVE    "2枚"                   TO  SPA-GMN-T-MAISU (6).
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
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM 530-RIDSET4-SEC
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 530-RIDSET3-SEC
               WHEN    "CLICKED"       ALSO    "B12"
                   IF  SPA-GMN-PRJUN   NOT =   SPACE
                       PERFORM 530-RIDSET2-SEC
                   ELSE
                       MOVE    "9999"             TO  OERR-ERRCODE
                       MOVE    T-MESSAGE-001      TO  OERR-ERRMSG
                       MOVE    "B01"              TO  MCP-WIDGET
                       MOVE    "O03"              TO  SPA-MOTOPG
                       MOVE    "OERR"             TO  SPA-SAKIPG
                       MOVE    "NEW"              TO  MCP-PUTTYPE
                       MOVE    "OERR"             TO  MCP-WINDOW
                       PERFORM 900-PUT-WINDOW
                       MOVE    1                   TO  FLG-END
                   END-IF
               WHEN    "CLICKED"       ALSO    "B13"
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
               WHEN    "ACTIVATE"      ALSO    "PRJUN"
                   PERFORM T-000-PRJUN-SEC
               WHEN    ANY             ALSO    "LIST02"
                   PERFORM T-000-LIST02-SEC
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
           MOVE    "O03"               TO  SPA-MOTOPG.
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
      *       登録更新処理
      *****************************************************************
       490-KOUSHIN-SEC           SECTION.
      *
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
           MOVE    "O03"           TO  MCP-WINDOW.
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
           MOVE    SPACE                   TO  O03.
      *
           MOVE    SPA-GMN-PRJUN           TO  O03-PRJUN.
      *
           PERFORM VARYING IDX FROM   1   BY  1
                   UNTIL   IDX >      10
               IF  SPA-GMN-PRJUN-L (IDX)   NOT =   SPACE
                   MOVE    IDX                 TO  O03-PRJUN-COUNT
                   MOVE    SPA-GMN-PRJUN-L (IDX)
                                               TO  O03-PRJUN-ITEM (IDX)
               END-IF
           END-PERFORM.
      *
           PERFORM VARYING IDX FROM   1   BY  1
                   UNTIL   IDX >      50
               IF  SPA-GMN-LIST02 (IDX)   NOT =   SPACE
                   MOVE    IDX               TO  O03-LIST11-COUNT
                   MOVE    SPA-GMN-T-KIKAN (IDX)
                                             TO  O03-VALUE1 (IDX)
                   MOVE    SPA-GMN-T-KENSU (IDX)
                                             TO  O03-VALUE2 (IDX)
                   MOVE    SPA-GMN-T-MAISU (IDX)
                                             TO  O03-VALUE3 (IDX)
                   MOVE    SPA-GMN-T-BYBTN02 (IDX)
                                             TO  O03-LIST11-SELECT (IDX)
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
                   MOVE    "PRJUN"         TO  MCP-WIDGET
               WHEN    02
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
      *    ジョブ管理チェック処理
      *
           MOVE    "CHK"              TO  SJOBKANRI-MODE.
           INITIALIZE                     JOBKANRI-REC.
           MOVE    1                  TO  JOB-JOBID.
           MOVE    "ORCBSO1"          TO  JOB-SHELLID.
           MOVE    SPA-TERMID         TO  JOB-TERMID.
           CALL    "ORCSJOB"          USING
                                      ORCSJOBKANRIAREA  
                                      JOBKANRI-REC.
           MOVE    SPACE              TO  OID2.
           MOVE    SPACE              TO  O99.
           MOVE    ZERO               TO  SPA-GMN-RUN.
           IF  SJOBKANRI-RETURN   =   ZERO
               IF  JOB-ENDYMD   =   SPACE
                   MOVE    "7777"             TO  OID2-ID2CODE
                   MOVE    T-MESSAGE-002      TO  OID2-ID2MSG
                   MOVE    1                  TO  SPA-GMN-RUN
               ELSE
                   MOVE    2                  TO  SPA-GMN-RUN
               END-IF
               IF  MCP-WIDGET   =   "B13"
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
               COMPUTE O99-PROGRESSBAR-VALUE  =
                           JOB-STEPCNT  /   13     *   100
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
                   MOVE   100                   TO
                                            O99-PROGRESSBAR-VALUE                             
               ELSE
                   MOVE    "B01"                TO  MCP-WIDGET
                   MOVE    "該当する処理はありません"
                                                TO  O99-MSG
               END-IF                                 
           ELSE                                        
               MOVE    "B11"                TO  MCP-WIDGET
           END-IF
      *
           MOVE    "R03"                TO  SPA-MOTOPG
           MOVE    "R99"                TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "R99"                TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
               END-IF
           END-IF.
      *
           IF  MCP-WIDGET   =   "B12"
               IF  SPA-GMN-RUN        NOT =   1
                   MOVE    "1001"                TO  OID1-ID1CODE
                   MOVE    T-MESSAGE-003         TO  OID1-ID1MSG
                   MOVE    "O03"                 TO  SPA-MOTOPG
                   MOVE    "OID1"                TO  SPA-SAKIPG
                   MOVE    "NEW"                 TO  MCP-PUTTYPE
                   MOVE    "OID1"                TO  MCP-WINDOW
               ELSE
                   MOVE    "O03"                 TO  SPA-MOTOPG
                   MOVE    "OID2"                TO  SPA-SAKIPG
                   MOVE    "NEW"                 TO  MCP-PUTTYPE
                   MOVE    "OID2"                TO  MCP-WINDOW
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
           MOVE    "O03"               TO  SPA-MOTOPG.
           MOVE    "XB01"              TO  SPA-SAKIPG.
           INITIALIZE                  SPA-KYOTUKEY.
           INITIALIZE                  SPA-WORK.
           MOVE    "ORCBSO1"           TO  SPA-JOB-SHELLID.
           MOVE    SPACE               TO  LINKAREA.
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU.
           MOVE    SPA-O01-AREA        TO  LNK-SCRSPA.
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
      *    印刷管理表示理
      *****************************************************************
       530-RIDSET4-SEC              SECTION.
      *
      *    画面移行用のパラメタ変更
           MOVE    "O03"               TO  SPA-MOTOPG.
           MOVE    "XA01"              TO  SPA-SAKIPG.
           INITIALIZE                  SPA-KYOTUKEY.
           INITIALIZE                  SPA-WORK.
           MOVE    "ORCBSO1"           TO  SPA-JOB-SHELLID.
           MOVE    "ORCBSO1"           TO  SPA-PRTKANRI-TBL-KEY.
           MOVE    SPACE               TO  LINKAREA.
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU.
           MOVE    SPA-O01-AREA        TO  LNK-SCRSPA.
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "XA01"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       530-RIDSET4-EXT.
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
      *    印刷順 確認処理
      *****************************************************************
       T-000-PRJUN-SEC                   SECTION.
      *
           MOVE    2                   TO  SPA-GMN-CUR.
           MOVE    1                   TO  FLG-ERR.
           MOVE    O03-PRJUN           TO  SPA-GMN-PRJUN.
      *
           IF  O03-PRJUN   NOT =   SPACE
               PERFORM VARYING IDX FROM   1   BY  1
                       UNTIL   IDX >      10
                   IF  SPA-GMN-PRJUN-C   =   SPA-GMN-PRJUN-1 (IDX)
                       MOVE    SPA-GMN-PRJUN-L (IDX)
                                                    TO  SPA-GMN-PRJUN
                       MOVE    99                   TO  IDX
                       MOVE    ZERO                 TO  FLG-ERR
                   END-IF
               END-PERFORM
           END-IF.
      *
           IF  FLG-ERR   =   1
               MOVE    "0001"                TO  OERR-ERRCODE
               MOVE    T-MESSAGE-001         TO  OERR-ERRMSG
               MOVE    "B01"                 TO  MCP-WIDGET
               MOVE    "O03"                 TO  SPA-MOTOPG
               MOVE    "OERR"                TO  SPA-SAKIPG
               MOVE    "NEW"                 TO  MCP-PUTTYPE
               MOVE    "OERR"                TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    1                     TO  SPA-GMN-CUR
               MOVE    1                     TO  FLG-END
           END-IF.
      *
       T-000-PRJUN-EXT.
           EXIT.
      *
      *****************************************************************
      *    指示項目クリック 確認処理
      *****************************************************************
       T-000-LIST02-SEC                  SECTION.
      *
           PERFORM VARYING IDX FROM   1   BY  1
                   UNTIL   IDX >      SPA-GMN-LIST01-CNT
               MOVE  O03-LIST11-SELECT (IDX) TO  SPA-GMN-T-BYBTN02 (IDX)
           END-PERFORM.
      *
       T-000-LIST02-EXT.
           EXIT.
