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
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCT0020.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 定期請求
      *  コンポーネント名  : 請求書出力
      *  管理者            :
      *  作成日付    作業者        記述
      *  02/12/19    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-太田    03.03.13  入院請求書複数枚一括印刷対応
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
      *
      *    エラーファイル
           SELECT  TEIKIERR-FILE   ASSIGN  TEIKIERR
                                   FILE    STATUS  IS  STS-TEIKIERR.
      *
       DATA                    DIVISION.
       FILE                    SECTION.
      *
      *    エラーファイル
       FD  TEIKIERR-FILE.
       01  TEIKIERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT5.INC"
                                   REPLACING  //TEIKI01PARA//
                                   BY         //TEIKIERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-TEIKIERR                            PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-SYSKANRI                            PIC 9(01).
           03  FLG-PTINF                               PIC 9(01).
           03  FLG-SYUNOU                              PIC 9(01).
           03  FLG-TEIKIPRT                            PIC 9(01).
           03  FLG-TAISYO                              PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-OUT1                                PIC 9(06).
      *
       01  INDEX-AREA.
           03  IDX1                                    PIC 9(04). 
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME.
               05  SYS-THH         PIC 9(02).
               05  SYS-TMM         PIC 9(02).
               05  SYS-TSS         PIC 9(02).
               05  SYS-TDD         PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-DBPATH                      PIC X(100).
           03  WRK-PARA.
               05  WRK-PARA-PRTJYUN            PIC X(02).
               05  WRK-PARA-BTUNUM-MAX         PIC 9(04).
               05  WRK-PARA-BTUNUM-TBL.
                   07  WRK-PARA-BTUNUM-OCC     OCCURS 50.
                       09  WRK-PARA-BTUNUM     PIC X(02).
               05  WRK-PARA-SYSYMD             PIC X(08).
               05  WRK-PARA-TERMID             PIC X(64).
               05  WRK-PARA-JOBID              PIC 9(07).
               05  WRK-PARA-SHELLID            PIC X(08).
      *
           03  WRK-TEIKIERR            PIC X(200).
      *
           03  WRK-YMD.
               05  WRK-YY              PIC 9(04).
               05  WRK-MM              PIC 9(02).
               05  WRK-DD              PIC 9(02).
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    収納マスター
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    定期請求印刷
       01  TEIKIPRT-REC.
           COPY    "CPTEIKIPRT.INC".
      *
      *    帳票サブ < 請求書兼領収書 >
           COPY    "CPORCHCN03.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *    患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      ****************************************************************
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(2000).
      ****************************************************************
       PROCEDURE           DIVISION
               USING
           COMMAND-PARAM.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC    UNTIL   FLG-END =   1 
      *
           PERFORM 300-TERM-SEC
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  CNT-AREA
                                       WRK-AREA
                                       SYS-AREA
      *
           ACCEPT  SYS-TIME    FROM    TIME
      *
           UNSTRING   COMMAND-PARAM    DELIMITED  BY  ","
                                       INTO    WRK-PARA-PRTJYUN
                                               WRK-PARA-BTUNUM-MAX
                                               WRK-PARA-BTUNUM-TBL
                                               WRK-PARA-SYSYMD
                                               WRK-PARA-TERMID
                                               WRK-PARA-JOBID
                                               WRK-PARA-SHELLID
      *
           DISPLAY "WRK-PARA-PRTJYUN     = " WRK-PARA-PRTJYUN     
           DISPLAY "WRK-PARA-BTUNUM-MAX  = " WRK-PARA-BTUNUM-MAX  
           DISPLAY "WRK-PARA-BTUNUM-TBL  = " WRK-PARA-BTUNUM-TBL  
           DISPLAY "WRK-PARA-SYSYMD      = " WRK-PARA-SYSYMD      
           DISPLAY "WRK-PARA-TERMID      = " WRK-PARA-TERMID      
           DISPLAY "WRK-PARA-JOBID       = " WRK-PARA-JOBID       
           DISPLAY "WRK-PARA-SHELLID     = " WRK-PARA-SHELLID     
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCT0020"      TO  JOB-PGID
           MOVE    "請求書出力"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           MOVE    ZERO                TO  FLG-END
      *
           MOVE    "TEIKIERR"          TO  TEIKIERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  TEIKIERR-TERMID
      *
           .
       100-INIT-EXT.
           EXIT.
      * 
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    出力順を取得
           MOVE    SPACE           TO  WRK-DBPATH
           EVALUATE    WRK-PARA-PRTJYUN
           WHEN    "01"
               MOVE    "TEIKIPRT-KEY2" TO  WRK-DBPATH
           WHEN    "02"
               MOVE    "TEIKIPRT-KEY3" TO  WRK-DBPATH
           WHEN    "03"
               MOVE    "TEIKIPRT-KEY4" TO  WRK-DBPATH
           WHEN    "04"
               MOVE    "TEIKIPRT-KEY5" TO  WRK-DBPATH
           WHEN    OTHER
                MOVE  "出力順の取得に失敗しました"
                                   TO  WRK-TEIKIERR
                PERFORM 500-ERR-HENSYU-SEC
                GO  TO  200-MAIN-EXT
           END-EVALUATE
      *
      *    定期請求印刷情報検索
           MOVE    SPACE               TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF    ( MCP-RC              =   ZERO )
               MOVE    WRK-DBPATH      TO  ORC-DBPATH
               PERFORM 900-TEIKIPRT-NEXT-SEC
           ELSE
               INITIALIZE                  TEIKIPRT-REC
               MOVE    1               TO  FLG-TEIKIPRT
           END-IF
      *
           INITIALIZE    ORCHCN03AREA
           MOVE    WRK-PARA-SYSYMD     TO  ORCHCN03-SYSYMD
           MOVE    WRK-PARA-TERMID     TO  ORCHCN03-TERMID
      *
           PERFORM UNTIL ( FLG-TEIKIPRT    NOT =   ZERO )
      *
               PERFORM 20011-HENSYU-SEC
               IF    ( FLG-END     =   1 )
                   GO  TO  200-MAIN-EXT
               END-IF
      *
               MOVE    WRK-DBPATH      TO  ORC-DBPATH
               PERFORM 900-TEIKIPRT-NEXT-SEC
      *
           END-PERFORM
      *
           MOVE     CNT-OUT1           TO  ORCHCN03-CNT
      *
      *    入院請求書印刷
           CALL    "ORCHCN03"  USING   ORCHCN03AREA
      *
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           MOVE    1                   TO  FLG-END
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *   編集処理
      *****************************************************************
       20011-HENSYU-SEC              SECTION.
      *
           IF    ( WRK-PARA-PRTJYUN    = "01"  OR  "02" )
               MOVE    ZERO            TO  FLG-TAISYO
      *        該当病棟でない場合は読み飛ばす
               PERFORM VARYING IDX1    FROM    1   BY  1
                       UNTIL ( IDX1    >   WRK-PARA-BTUNUM-MAX )
      *
                   IF    ( TEIKIPRT-BTUNUM =   WRK-PARA-BTUNUM (IDX1) )
                       MOVE    1       TO  FLG-TAISYO
                       MOVE    WRK-PARA-BTUNUM-MAX
                                       TO  IDX1
                   END-IF
      *
               END-PERFORM
               IF    ( FLG-TAISYO      =   ZERO )
                   GO  TO  20011-HENSYU-EXT
               END-IF
           END-IF
      *
      *    収納データを検索する
           INITIALIZE  SYUNOU-REC
           MOVE    TEIKIPRT-HOSPID     TO  SYU-HOSPID
           MOVE    "1"                 TO  SYU-NYUGAIKBN
           MOVE    TEIKIPRT-PTID       TO  SYU-PTID
           MOVE    TEIKIPRT-DENPNUM    TO  SYU-DENPNUM
      *
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           PERFORM 900-SYUNOU-READ-SEC
           IF    ( FLG-SYUNOU      NOT =   ZERO )
                MOVE  "収納情報の取得に失敗しました"
                                   TO  WRK-TEIKIERR
                PERFORM 500-ERR-HENSYU-SEC
                GO  TO  20011-HENSYU-EXT
           END-IF
      *
           COMPUTE CNT-OUT1    =   CNT-OUT1    +   1
      *
      *    請求書サブ患者情報パラメタ設定
           MOVE    SYU-SKYSTYMD        TO  ORCHCN03-KJNYMD    (CNT-OUT1)
           MOVE    TEIKIPRT-HOSPID     TO  ORCHCN03-HOSPID    (CNT-OUT1)
           MOVE    TEIKIPRT-PTID       TO  ORCHCN03-PTID      (CNT-OUT1)
           MOVE    TEIKIPRT-PTNUM      TO  ORCHCN03-PTNUM     (CNT-OUT1)
           MOVE    "1"                 TO  ORCHCN03-NYUGAIKBN (CNT-OUT1)
      *
           MOVE    SYU-DENPNUM         TO  ORCHCN03-DENPNUM   (CNT-OUT1)
           MOVE    SYU-SKYMONEY        TO  ORCHCN03-SEIKYU    (CNT-OUT1)
           MOVE    ZERO                TO  ORCHCN03-NYUKIN    (CNT-OUT1)
      *
           .
       20011-HENSYU-EXT.
           EXIT. 
      *
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC                SECTION.
      *
           OPEN    INPUT   TEIKIERR-FILE
           IF      STS-TEIKIERR         =   ZERO
               CLOSE   TEIKIERR-FILE
           ELSE
               OPEN    OUTPUT              TEIKIERR-FILE
      *
               MOVE    WRK-TEIKIERR         TO  TEIKIERR-REC
               WRITE   TEIKIERR-REC
               CLOSE   TEIKIERR-FILE
      *         
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-TEIKIERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA  
                                       JOBKANRI-REC
           END-IF
      *                             
           MOVE    1                   TO  FLG-END
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
           IF      CNT-OUT1            =   ZERO 
               MOVE    "処理対象のデータがありませんでした"
                                           TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *     
           DISPLAY "TEIKI01  CNT " CNT-OUT1 
           DISPLAY "*** ORCT0010 END ***"
      ***  ACCEPT  WRK-IN FROM CONSOLE 
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       910-SYSKANRI-INV-SEC         SECTION.
      *
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
                   MOVE    ZERO                TO  FLG-SYSKANRI
               ELSE
                   MOVE    1                   TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
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
       910-SYSKANRI-INV-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    収納マスター読込（主キー）
      *****************************************************************
       900-SYUNOU-READ-SEC         SECTION.
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  SYUNOU-REC
                   MOVE    ZERO                TO  FLG-SYUNOU
               ELSE
                   MOVE    1                   TO  FLG-SYUNOU
                   INITIALIZE                  SYUNOU-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYUNOU
               INITIALIZE                  SYUNOU-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-SYUNOU-READ-EXT.
           EXIT.
      *****************************************************************
      *    定期請求印刷情報ファイル読込
      *****************************************************************
       900-TEIKIPRT-NEXT-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-TEIKIPRT
               MOVE    MCPDATA-REC         TO  TEIKIPRT-REC
           ELSE
               MOVE    1                   TO  FLG-TEIKIPRT
           END-IF
      *
           .
       900-TEIKIPRT-NEXT-EXT.
           EXIT.
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
