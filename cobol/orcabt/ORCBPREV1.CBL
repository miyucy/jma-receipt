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
      *
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCBPREV1.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : プレビュー処理
      *  コンポーネント名  : プレビュー管理ＤＢの更新
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/04/16    MCC-藤原      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
           SELECT  PREVIEW-FILE    ASSIGN
                                         "/etc/jma-receipt/preview.env"
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-PREVIEW.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
006900*    入力ＰＳ環境ファイル
       FD  PREVIEW-FILE.
       01  PREVIEW-RECORD.
           03  PREVIEW-ENV      PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *    印刷用データ
       01  PRT-REC.
           03  PRT-PRTID           PIC X(30).
           03  PRT-PRTNM           PIC X(20).
           03  PRT-SITEKBN         PIC X(01).
      *  01.01.02  ADD START 
           03  PRT-PRTKBN          PIC X(01).
           03  PRT-PSFILE-AREA.
             05  PRT-PSFILE-FOLDER     PIC X(165).
             05  PRT-PSFILE-TBL-KEY    PIC X(08).
             05  PRT-PSFILE-RENNUM     PIC X(04).
             05  PRT-PSFILE-GROUP      PIC X(14).
             05  PRT-PSFILE-SRENNUM    PIC X(04).
             05  PRT-PSFILE-PAGE       PIC X(05).
      *  01.01.02  ADD END
           03  PRT-PRTDATA         PIC X(10000).
      *
      *
      *    印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *    シェル用領域
      *****COPY    "CPCOMMONSHELL.INC".
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME            PIC 9(08).    
      *
      *    スパ領域
       01  STS-AREA.
           03  STS-PRT             PIC X(02).
           03  STS-RECEERR         PIC X(02).
           03  STS-PREVIEW         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-ERR             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-PRTDATA         PIC 9(01).
           03  FLG-PRTKANRI        PIC 9(01).
           03  FLG-PREVIEW         PIC 9(01).
           03  FLG-IN              PIC 9(01).
      *
      *  01.01.02  ADD START 
      *    添字領域
       01  SOEJI-AREA.
           03  IDX                 PIC 9(05).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
      *  01.01.02  ADD END   
      *    カウント領域
       01  CNT-AREA.
           03  CNT-IN              PIC 9(05).
           03  CNT-OUT             PIC 9(10).
      *  01.01.02  ADD START 
           03  CNT-KETA            PIC 9(05).
           03  WRK-MOJISU          PIC 9(05).
      *  01.01.02  ADD END   
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-HC01PARA-CNT    PIC  9(03).
      *
           03  WRK-RECEERR         PIC X(200). 
      *
           03  WRK-PATH            PIC X(64). 
      *
      *  01.01.02  ADD START 
           03  WRK-FILENAME        PIC X(200). 
           03  WRK-FILENAME1       PIC X(200). 
           03  SPA-NAI-ENV         PIC X(200). 
      *  01.01.02  ADD END   
      *
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID      PIC 9(07).
           03  WRK-PARA-SHELLID    PIC X(08).
           03  WRK-PARA-STPAGE     PIC 9(05).
           03  WRK-PARA-EDPAGE     PIC 9(05).
           03  WRK-PARA-PRTFLG     PIC X(01).
           03  WRK-PARA-SYOKBN     PIC X(01).
      *
           03  WRK-IN              PIC X(01).
      *
       01  WRK-TBL-GROUP.
           03  WK-TBL-G           PIC  X(14) OCCURS 5.
      *    印刷用コンスタント領域 
           COPY    "CPPRTCONST.INC".          
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".         
      *
      *    ファイル削除パラメタ
           COPY    "CPORCSFDEL.INC".
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
           COPY    "CPSHELLTBL.INC".
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    出力先プリンタ名割り当て情報
           COPY    "CPSK1031.INC".
      *
      *    印刷管理ＤＢ
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
      *    印刷ＤＢ
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".          
      *    プレビューＤＢ
           COPY    "CPPRVKANRI.INC".          
           COPY    "CPPREVIEW.INC".          
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      ****************************************************************
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(256).
      ****************************************************************
       PROCEDURE           DIVISION
               USING
           COMMAND-PARAM.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
                   UNTIL       FLG-END     =   1
      *
           PERFORM 300-END-SEC
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      * 
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
      *
           ACCEPT  SYS-TIME            FROM    TIME     
      *
           UNSTRING   COMMAND-PARAM    DELIMITED  BY  ","
                                       INTO    LNK-PRTKANRI-RENNUM
                                               LNK-PRTKANRI-TBL-KEY
                                               LNK-PRTKANRI-TBL-GROUP
                                               LNK-PRTKANRI-SHORI-RENNUM
                                               LNK-PRTKANRI-SRYYM
                                               LNK-PRTKANRI-SKYYMD
                                               LNK-PRTKANRI-SHELLID
                                               LNK-PRTKANRI-PRIORITY
                                               LNK-PRTKANRI-TERMID
                                               LNK-PRTKANRI-OPID
                                               LNK-PRTKANRI-PRTNM    
                                               WRK-PARA-JOBID
                                               WRK-PARA-SHELLID
                                               WRK-PARA-STPAGE
                                               WRK-PARA-EDPAGE
                                               WRK-PARA-PRTFLG     
                                               WRK-PARA-SYOKBN
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
      *  10        20        30        40        50        60
----+-*--+----+----+----+----+----+----+----+----+----+----+----+----+
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
           MOVE    "ORCBPREV1"         TO  JOB-PGID
           MOVE    "プレビュー設定処理"
                                       TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
      *    出力先プリンタ名割り当て情報処理
      *****PERFORM 110-SYSKANRI-HENSYU-SEC
      *
      *    印刷管理ＤＢ読み込み処理
           PERFORM 900-PRTKANRI-SELECT-SEC
      *
      *    プレビュー用前処理
           MOVE    ZERO            TO  WRK-MOJISU
           IF      WRK-PARA-PRTFLG     =   "2"  OR "3"
             IF    LNK-PRTKANRI-TBL-KEY    NOT =   SPACE
               PERFORM VARYING     IDX     FROM    8   BY  -1
                       UNTIL       IDX     <       1
                   IF      LNK-PRTKANRI-TBL-KEY(IDX:1)
                                           NOT =   SPACE
                       MOVE    IDX     TO  WRK-MOJISU
                       MOVE    1       TO  IDX
                   END-IF
               END-PERFORM
               DISPLAY "delete cancel"
      *        PERFORM 900-PRVKANRI-DELETE-SEC
             END-IF
           END-IF
      *
      *    プレビューDB履歴更新処理
           PERFORM 120-PRVKANRI-RRKUPD-SEC
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    プレビューDB履歴更新処理
      *****************************************************************
      *  10        20        30        40        50        60
----+-*--+----+----+----+----+----+----+----+----+----+----+----+----+
       120-PRVKANRI-RRKUPD-SEC                   SECTION.
      *    TBLキーセット
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  PRVKANRI-TBL-KEY
      *    MOVE    PRTKANRI-RENNUM     TO  PRVKANRI-RENNUM
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  PRVKANRI-TBL-GROUP
           MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  PRVKANRI-RECE-FLG
           MOVE    WRK-PARA-SYOKBN     TO  PRVKANRI-SHORI-KBN
           MOVE    PRVKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    PATH-TBL-PRVKANRI-KEY4
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC             =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    PATH-TBL-PRVKANRI-KEY4
                                           TO  MCP-PATH
               CALL    "MCPSUB"            USING
                                               MCPAREA
                                               MCPDATA-REC
               IF      MCP-RC              =   ZERO
             DISPLAY "take group fetch ok"
                   MOVE    ZERO            TO  FLG-PREVIEW
                   MOVE    MCPDATA-REC     TO  PRVKANRI-REC
                   MOVE    PRVKANRI-T-G    TO  WRK-TBL-GROUP
               ELSE  
                   MOVE    1               TO  FLG-PREVIEW
                   MOVE    SPACE           TO  WRK-TBL-GROUP
               END-IF 
           ELSE 
               MOVE    1                   TO  FLG-PREVIEW
           END-IF
           .
       120-PRVKANRI-RRKUPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    出力先プリンタ名割り当て情報処理
      *****************************************************************
       110-SYSKANRI-HENSYU-SEC                   SECTION.
      *
      *    出力先プリンタ名割り当て情報編集
           MOVE    SPACE               TO  SYS-1031-REC
           INITIALIZE                  SYS-1031-REC
           MOVE    "1031"              TO  SYS-1031-KANRICD
           MOVE    "*"                 TO  SYS-1031-KBNCD
           MOVE    SYS-1031-REC        TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1031-REC
           ELSE    
               INITIALIZE                  SYS-1031-REC
           END-IF                                     
           .
       110-PARA-HENSYU-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    印刷用ファイル作成  
           MOVE    "HC99"          TO  HC01PARA-FORM-ID
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  HC01PARA-TERMID
           MOVE    SYS-TIME        TO  HC01PARA-SYOHMS
           MOVE    1               TO  HC01PARA-CNT
      *+   OPEN    OUTPUT              PRT-FILE
      *        最新以外の帳票管理ＤＢを削除
               MOVE    SPACE           TO  PRVKANRI-REC
               INITIALIZE                  PRVKANRI-REC
               MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  PRVKANRI-TBL-KEY
               MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  PRVKANRI-RECE-FLG
               MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  PRVKANRI-TBL-GROUP
               MOVE    WRK-PARA-SYOKBN TO  PRVKANRI-SHORI-KBN
               MOVE    PRVKANRI-REC    TO  MCPDATA-REC
               MOVE    "DBDELETE"      TO  MCP-FUNC
               MOVE    PATH-TBL-PRVKANRI-DEL12
                                           TO  MCP-PATH
               CALL    "MCPSUB"            USING
                                           MCPAREA
                                           MCPDATA-REC
      *
      *        最新以外の帳票管理ＤＢを削除
               MOVE    SPACE           TO  PREVIEW-REC
               INITIALIZE                  PREVIEW-REC
               MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  PREVIEW-TBL-KEY
               MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  PRVKANRI-RECE-FLG
               MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  PREVIEW-TBL-GROUP
               MOVE    WRK-PARA-SYOKBN TO  PRVKANRI-SHORI-KBN
               MOVE    PREVIEW-REC     TO  MCPDATA-REC
               MOVE    "DBDELETE"      TO  MCP-FUNC
      *     ラージオブジェクト対応までコメント★
      *        MOVE    PATH-TBL-PREVIEW-DEL12
      *                                    TO  MCP-PATH
      *        CALL    "MCPSUB"            USING
      *                                    MCPAREA
      *                                    MCPDATA-REC
      * end ラージオブジェクト対応までコメント★
      *
      *
           PERFORM                     UNTIL   FLG-PRTKANRI =   1
                                       OR      FLG-END      =   1   
      *        印刷ＤＢ編集処理
               PERFORM 900-PRTDATA-SELECT-SEC
               PERFORM                     UNTIL   FLG-PRTDATA  =   1
                                           OR      FLG-END      =   1
                   PERFORM 2001-PRTDATA-PRINT-SEC
                   PERFORM 900-PRTDATA-FET-SEC
               END-PERFORM    
               PERFORM 2003-PRTKANRI-UPD-SEC
               PERFORM 900-PRTKANRI-FET-SEC
           END-PERFORM                                
      *
      *+   CLOSE                       PRT-FILE
      *     
      *   印刷用スクリプト処理
      *
      *    IF      CNT-OUT             >   ZERO
      *    AND     FLG-ERR             =   ZERO 
      *
      *        MOVE    SPACE           TO  SHELLTBL
      *        ファイルデイレクトリ位置指定
      *        INITIALIZE              ORCSMKPASSAREA
      *        MOVE    "scripts/daily/HCALL_prv.sh"
      *                                TO  MKPASS-IN-01
      *        CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
      *        MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *         
      *        MOVE    HC01PARA        TO  SHELLTBL-ARG1
      *        MOVE    SHELLTBL        TO  MCPDATA-REC
      *        MOVE    "SHELL"         TO  MCP-FUNC
      *        MOVE    PATH-SHELL-SHELL
      *                                TO  MCP-PATH
      *        CALL    "MCPSUB"        USING
      *                                    MCPAREA
      *                                    MCPDATA-REC
      *    END-IF                                                
      *
           MOVE    1                   TO  FLG-END     
           .
       200-MAIN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       2001-PRTDATA-PRINT-SEC          SECTION.
      *
           MOVE    SPACE               TO  PRT-REC 
           MOVE    PRTDATA-PRTID       TO  PRT-PRTID
           IF      PRTDATA-PRTNM       =   SPACE
               MOVE    PRTKANRI-PRTNM      TO  PRT-PRTNM
           ELSE
               MOVE    PRTDATA-PRTNM       TO  PRT-PRTNM
           END-IF
           EVALUATE    PRTDATA-SITEKBN
               WHEN    "1"
               WHEN    "2"               
                   MOVE    PRTDATA-SITEKBN     TO  PRT-SITEKBN
               WHEN    OTHER
                   SET     PRTCONST-IDX        TO  1
                   SEARCH  PRTCONST-TX VARYING PRTCONST-IDX
                       AT  END
                           MOVE    "2"         TO  PRT-SITEKBN
                       WHEN    PRTCONST-PRTID (PRTCONST-IDX)
                                               =   PRTDATA-PRTID
                           MOVE    "1"         TO  PRT-SITEKBN
                   END-SEARCH
           END-EVALUATE                                                                
      *  01.01.02  SATRT
           MOVE WRK-PARA-PRTFLG                TO  PRT-PRTKBN
           MOVE    ZERO                        TO  CNT-KETA
           MOVE    "/var/tmp/"                 TO  PRT-PSFILE-FOLDER
           MOVE    LNK-PRTKANRI-TBL-KEY        TO  PRT-PSFILE-TBL-KEY
           MOVE    PRTDATA-RENNUM              TO  PRT-PSFILE-RENNUM
           MOVE    LNK-PRTKANRI-TBL-GROUP      TO  PRT-PSFILE-GROUP 
           MOVE    PRTDATA-SHORI-RENNUM        TO  PRT-PSFILE-SRENNUM
           MOVE    PRTDATA-PAGE                TO  PRT-PSFILE-PAGE  
      *  01.01.02  END
           MOVE    PRTDATA-PRTDATA             TO  PRT-PRTDATA
      *    WRITE   PRT-REC
      *
      *  01.01.02  SATRT
           IF   WRK-PARA-PRTFLG        =   "2"  OR  "3"  OR  "4"
             DISPLAY "takeda PRVKANRI-INS"
                PERFORM 2004-PRVKANRI-INS-SEC
           END-IF
      *  01.01.02  END
      *
           ADD     1                   TO  CNT-OUT     
      *
           PERFORM 2002-PRTDATA-UPD-SEC
           .
       2001-PRTDATA-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷フラグセット処理
      *****************************************************************
       2002-PRTDATA-UPD-SEC          SECTION.
      *
      *    印刷フラグセット
           MOVE    "1"                 TO  PRTDATA-PRTFLG
      *
           MOVE    PRTDATA-REC         TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    PATH-TBL-PRTDATA-KEY
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC             =   ZERO
               CONTINUE
           ELSE
               MOVE    "印刷ＤＢの更新でエラーになりました"
                                          TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
          END-IF    
           .
       2001-PRTDATA-UPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷フラグセット処理
      *****************************************************************
       2003-PRTKANRI-UPD-SEC          SECTION.
      *
           MOVE    "1"                 TO  PRTKANRI-PRTFLG
           MOVE    PRTKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    PATH-TBL-PRTKANRI-KEY
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC               =   ZERO
               CONTINUE
           ELSE
               MOVE    "印刷管理ＤＢの更新でエラーになりました"
                                        TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF    
           .
       2003-PRTKANRI-UPD-EXT.
           EXIT.
      *
      *  01.01.02  SATRT
      *****************************************************************
      *    プレビューＤＢ削除処理
      *****************************************************************
       900-PRVKANRI-DELETE-SEC        SECTION.
      *
      *    TBLキーセット
           DISPLAY "BPRT DELETE KEY= " LNK-PRTKANRI-TBL-KEY
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  PRVKANRI-TBL-KEY
      *
           MOVE    PRVKANRI-REC         TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    PATH-TBL-PRVKANRI-DEL11
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC             =   ZERO
               CONTINUE
           ELSE
               MOVE    "プレビューＤＢの削除でエラーになりました"
                                          TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
          END-IF    
           .
       900-PRVKANRI-DELETE-EXT.
           EXIT.
      *
      *****************************************************************
      *    プレビューＤＢ追加処理
      *****************************************************************
       2004-PRVKANRI-INS-SEC          SECTION.
      *
      *    TBLキーセット
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  PRVKANRI-TBL-KEY
           MOVE    PRTKANRI-RENNUM     TO  PRVKANRI-RENNUM
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  PRVKANRI-TBL-GROUP
           MOVE    PRTDATA-SHORI-RENNUM
                                       TO  PRVKANRI-SHORI-RENNUM
           MOVE    PRT-PSFILE-AREA     TO  PRVKANRI-FILENAME
      *    STRING  PRT-PSFILE-FOLDER   DELIMITED  BY  SPACE
      *            PRT-PSFILE-TBL-KEY  DELIMITED  BY  SPACE
      *            PRT-PSFILE-RENNUM   DELIMITED  BY  SPACE
      *            PRT-PSFILE-GROUP    DELIMITED  BY  SPACE
      *            PRT-PSFILE-SRENNUM  DELIMITED  BY  SPACE
      *            PRT-PSFILE-PAGE     DELIMITED  BY  SPACE
      *                                INTO   PRVKANRI-FILENAME
      *    END-STRING
           MOVE    WRK-PARA-SHELLID    TO  PRVKANRI-SHELLID
           MOVE    PRTDATA-PAGE        TO  PRVKANRI-PAGE
      *    MOVE    PRTDATA-PRTID       TO  PRVKANRI-PRTID
           MOVE    PRTKANRI-TITLE      TO  PRVKANRI-TITLE
           MOVE    PRTDATA-PTID        TO  PRVKANRI-PTID
           MOVE    WRK-PARA-PRTFLG     TO  PRVKANRI-SHORI-MOD-FLG
      *    MOVE    PRTKANRI-SRYYM      TO  PRVKANRI-SRYYM
           MOVE    PRTDATA-SRYYM       TO  PRVKANRI-SRYYM
           MOVE    PRTKANRI-SKYYMD     TO  PRVKANRI-SKYYMD
           MOVE    PRTKANRI-PRTNM      TO  PRVKANRI-PRTNM
           MOVE    PRTKANRI-TBL-GROUP  TO  
                                       PRVKANRI-TBL-GROUP-RRK(1)
           MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  PRVKANRI-RECE-FLG
           MOVE    WRK-PARA-SYOKBN     TO  PRVKANRI-SHORI-KBN
           MOVE    WK-TBL-G(1)         TO  
                                       PRVKANRI-TBL-GROUP-RRK(2)
           MOVE    WK-TBL-G(2)         TO  
                                       PRVKANRI-TBL-GROUP-RRK(3)
           MOVE    WK-TBL-G(3)         TO  
                                       PRVKANRI-TBL-GROUP-RRK(4)
           MOVE    WK-TBL-G(4)         TO  
                                       PRVKANRI-TBL-GROUP-RRK(5)
           MOVE    PRTKANRI-OPID       TO  PRVKANRI-OPID
           MOVE    SYS-TIME            TO  PRVKANRI-CREYMD
           MOVE    SPACE               TO  PRVKANRI-UPYMD
           MOVE    SPACE               TO  PRVKANRI-UPHMS
      *
           PERFORM 900-PRVKANRI-INV-SEC
           IF      FLG-PREVIEW         =   ZERO  
               GO  TO                  2004-PRVKANRI-INS-EXT
           END-IF
           MOVE    PRVKANRI-REC        TO  MCPDATA-REC
           DISPLAY "take priority i = [" PRVKANRI-RECE-FLG "]"
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    PATH-TBL-PRVKANRI-KEY
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC             =   ZERO
               CONTINUE
           ELSE
               MOVE    "プレビューＤＢの追加でエラーになりました"
                                          TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
          END-IF    
           .
       2004-PRVKANRI-INS-EXT.
           EXIT.
      *
      *  01.01.02  END
057400*
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC                SECTION.
      *
           OPEN    INPUT   RECEERR-FILE
           IF      STS-RECEERR         =   ZERO
               CLOSE   RECEERR-FILE
           ELSE
               OPEN    OUTPUT              RECEERR-FILE
      *
               MOVE    WRK-RECEERR         TO  RECEERR-REC
               WRITE   RECEERR-REC
               CLOSE   RECEERR-FILE
      *         
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA  
                                       JOBKANRI-REC
           END-IF
      *
           MOVE    1                   TO  FLG-END
                                           FLG-ERR
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *     
      *  10        20        30        40        50        60
----+-*--+----+----+----+----+----+----+----+----+----+----+----+----+
      *     
           OPEN    INPUT      PREVIEW-FILE
           IF      STS-PREVIEW         =   ZERO
                   PERFORM 900-IN-READ-SEC
                   CLOSE   PREVIEW-FILE
           ELSE
                   MOVE    1              TO  FLG-IN
           END-IF
           MOVE    SPACE               TO  SPA-NAI-ENV
           IF      FLG-IN      =   ZERO
                   STRING  PREVIEW-ENV         DELIMITED  BY  SPACE
                           "/"                 DELIMITED  BY  SPACE
                                       INTO    SPA-NAI-ENV
                   END-STRING
           ELSE
                   MOVE "/tmp/"
                               TO  SPA-NAI-ENV
           END-IF
      *     
           PERFORM VARYING     IDY     FROM    1   BY  1
                       UNTIL       IDY     >       10
             PERFORM VARYING   IDZ     FROM    1   BY  1
                       UNTIL       IDZ     >        5
              IF   WK-TBL-G(IDZ)       NOT  =  SPACE
                   MOVE  SPACE         TO  WRK-FILENAME
                   STRING
                      "/var/tmp/"         DELIMITED  BY  SPACE
                      LNK-PRTKANRI-TBL-KEY
                                          DELIMITED  BY  SPACE
                      IDY                 DELIMITED  BY  SPACE
                      WK-TBL-G(IDZ)       DELIMITED  BY  SPACE
                      "*"                 DELIMITED  BY  SPACE
                                          INTO   WRK-FILENAME
                   END-STRING
                   MOVE    ZERO            TO  IF-RESULT
                   MOVE    WRK-FILENAME
                                           TO  IF-FILENAME
      *            CALL    "orcfiledel"    USING
      *                                    ORCSFDELAREA
                   MOVE  SPACE         TO  WRK-FILENAME1
                   STRING
                      SPA-NAI-ENV         DELIMITED  BY  SPACE
                      LNK-PRTKANRI-TBL-KEY
                                          DELIMITED  BY  SPACE
                      IDY                 DELIMITED  BY  SPACE
                      WK-TBL-G(IDZ)       DELIMITED  BY  SPACE
                      "*"                 DELIMITED  BY  SPACE
                                          INTO   WRK-FILENAME1
                   END-STRING
               MOVE    SPACE           TO  SHELLTBL
      *        ファイルデイレクトリ位置指定
               INITIALIZE              ORCSMKPASSAREA
               MOVE    "scripts/allways/orc_file_del.sh"
                                       TO  MKPASS-IN-01
               CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
               MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *         
               MOVE    WRK-FILENAME    TO  SHELLTBL-ARG1
               MOVE    WRK-FILENAME1   TO  SHELLTBL-ARG2
               MOVE    SHELLTBL        TO  MCPDATA-REC
               MOVE    "SHELL"         TO  MCP-FUNC
               MOVE    PATH-SHELL-SHELL
                                       TO  MCP-PATH
               CALL    "MCPSUB"        USING
                                           MCPAREA
                                           MCPDATA-REC
              END-IF
             END-PERFORM
           END-PERFORM
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
      **** MOVE    CNT-OUT         TO  JOB-UPDCNT                        
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           DISPLAY "*** ORCBPREV1 IN  "  CNT-IN
           DISPLAY "*** ORCBPREV1 OUT "  CNT-OUT
      **** DISPLAY "*** ORCBPREV1 END ***"
      *****ACCEPT WRK-IN
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    PS環境ファイル読込み処理
      *****************************************************************
       900-IN-READ-SEC          SECTION.
      *
          READ    PREVIEW-FILE
              AT  END
                  MOVE    1               TO  FLG-IN
              NOT AT  END
                  MOVE    ZERO            TO  FLG-IN
          END-READ
      *
          .
       900-IN-READ-EXT.
          EXIT.
      *
      *****************************************************************
      *     印刷管理ＤＢ読み込み
      *****************************************************************
       900-PRTKANRI-SELECT-SEC          SECTION.
      *
           INITIALIZE                      PRTKANRI-REC
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  PRTKANRI-TBL-KEY
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  PRTKANRI-TBL-GROUP
           MOVE    PRTKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    PATH-TBL-PRTKANRI-KEY2
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC             =   ZERO
               PERFORM 900-PRTKANRI-FET-SEC
           ELSE 
               MOVE    1                   TO  FLG-PRTKANRI
                                               FLG-END
           END-IF
           .
       900-PRTKANRI-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *     印刷ＤＢ読み込み
      *****************************************************************
       900-PRVKANRI-INV-SEC            SECTION.
      *
           MOVE    PRVKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    PATH-TBL-PRVKANRI-KEY
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC             =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    PATH-TBL-PRVKANRI-KEY
                                           TO  MCP-PATH
               CALL    "MCPSUB"            USING
                                               MCPAREA
                                               MCPDATA-REC
               IF      MCP-RC              =   ZERO
             DISPLAY "take fetch ok"
                   MOVE    ZERO                TO  FLG-PREVIEW
               ELSE  
             DISPLAY "take fetch ng"
                   MOVE    1                   TO  FLG-PREVIEW
               END-IF 
           ELSE 
               MOVE    1                   TO  FLG-PREVIEW
           END-IF
           .
       900-PRVKANRI-INV-EXT.
           EXIT.
      *      
      *****************************************************************
      *     印刷管理ＤＢ読み込み
      *****************************************************************
       900-PRTKANRI-FET-SEC            SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           MOVE    PATH-TBL-PRTKANRI-KEY2
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *                                  
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  PRTKANRI-REC
               IF      LNK-PRTKANRI-RENNUM  =   ZERO
                   CONTINUE
               ELSE
                   IF      LNK-PRTKANRI-RENNUM   NOT = 
                                           PRTKANRI-RENNUM
                       GO  TO  900-PRTKANRI-FET-SEC
                   END-IF
               END-IF                                             
               IF      LNK-PRTKANRI-SHORI-RENNUM   =   ZERO
                   CONTINUE
               ELSE
                   IF      LNK-PRTKANRI-SHORI-RENNUM   NOT = 
                                           PRTKANRI-SHORI-RENNUM
                       GO  TO  900-PRTKANRI-FET-SEC
                   END-IF
               END-IF                                             
               MOVE    ZERO                TO  FLG-PRTKANRI
                                               FLG-END
           ELSE
               MOVE    1                   TO  FLG-PRTKANRI
                                               FLG-END 
           END-IF
           .
       900-PRTKANRI-FET-EXT.
           EXIT.
      *
      *****************************************************************
      *     印刷ＤＢ読み込み
      *****************************************************************
       900-PRTDATA-SELECT-SEC          SECTION.
      *
           INITIALIZE                      PRTDATA-REC
           MOVE    PRTKANRI-RENNUM     TO  PRTDATA-RENNUM
           MOVE    PRTKANRI-SHORI-RENNUM
                                       TO  PRTDATA-SHORI-RENNUM
           MOVE    PRTKANRI-TBL-GROUP  TO  PRTDATA-TBL-GROUP
           MOVE    PRTKANRI-TBL-KEY    TO  PRTDATA-TBL-KEY
           MOVE    WRK-PARA-STPAGE     TO  PRTDATAXX-STPAGE
           MOVE    WRK-PARA-EDPAGE     TO  PRTDATAXX-EDPAGE
      *
           MOVE    PRTDATA-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    PATH-TBL-PRTDATA-KEY2
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC             =   ZERO
               PERFORM 900-PRTDATA-FET-SEC
           ELSE 
               MOVE    1                   TO  FLG-PRTDATA
           END-IF
           .
       900-PRTDATA-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *     印刷ＤＢ読み込み
      *****************************************************************
       900-PRTDATA-FET-SEC            SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           MOVE    PATH-TBL-PRTDATA-KEY2
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *                                  
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  PRTDATA-REC
               ADD     1                   TO  CNT-IN
               MOVE    ZERO                TO  FLG-PRTDATA
           ELSE  
               MOVE    1                   TO  FLG-PRTDATA
           END-IF 
           .
       900-PRTDATA-FET-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスタ読み込み
      *****************************************************************
       800-SYSKANRI-READ-SEC           SECTION.
      *
           MOVE    LNK-PRTKANRI-SRYYM  TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2) 
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO            TO  FLG-SYSKANRI
               ELSE
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       800-SYSKANRI-READ-EXT.
           EXIT.
      *      
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
      *
           MOVE    "DBOPEN"            TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       900-DBCLOSE-EXT.
           EXIT.
