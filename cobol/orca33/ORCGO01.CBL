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
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCGO01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院業務
      *  コンポーネント名  : 定期請求（Ｏ０１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/08/21    ひさなが　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-太田    02/12/05  処理結果確認画面への
      *                                     遷移追加等
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
006900*    エラーファイル
           SELECT  TEIKIERR-FILE   ASSIGN  TEIKIERR
                                   FILE    STATUS  IS  STS-TEIKIERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
006900*    エラーファイル
       FD  TEIKIERR-FILE.
       01  TEIKIERR-REC            PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT5.INC"
                                   REPLACING  //TEIKI01PARA//
                                   BY         //TEIKIERR//.
           03                      PIC X(04)   VALUE   ".dat".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
           COPY    "O01COMMON-SPA".
      *
           COPY    "ENUM-VALUE".
      *
      *    画面用ＳＰＡ
       01  SPA-O01.
           03  SPA-O01-AREA.
               05  SPA-GMN-MAX                     PIC 9(04).
               05  SPA-GMN-PAGE                    PIC 9(02).
               05  SPA-GMN-CUR                     PIC 9(02).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-SRYYM               PIC X(07).
                   07  SPA-GMN-IKKATU              PIC X(01).
                   07  SPA-GMN-KOBETU              PIC X(01).
                   07  SPA-GMN-CHK-KIKAN01         PIC X(01).
                   07  SPA-GMN-CHK-KIKAN02         PIC X(01).
                   07  SPA-GMN-CHK-KIKAN03         PIC X(01).
                   07  SPA-GMN-KIKAN01             PIC X(20).
                   07  SPA-GMN-KIKAN02             PIC X(20).
                   07  SPA-GMN-KIKAN03             PIC X(20).
      *
               05  SPA-NAI-O01-AREA.
                   07  SPA-NAI-SRYYM               PIC 9(06).
                   07  SPA-NAI-SRYYMH              PIC X(16).
                   07  SPA-NAI-KIKAN.
                       09  SPA-NAI-KIKAN01ST       PIC X(08).
                       09  SPA-NAI-KIKAN01ED       PIC X(08).
                       09  SPA-NAI-KIKAN02ST       PIC X(08).
                       09  SPA-NAI-KIKAN02ED       PIC X(08).
                       09  SPA-NAI-KIKAN03ST       PIC X(08).
                       09  SPA-NAI-KIKAN03ED       PIC X(08).
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
       01  STS-AREA.
           03  STS-TEIKIERR        PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDX3                PIC 9(04).
           03  IDX4                PIC 9(04).
           03  IDX5                PIC 9(04).
      *
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-TEIKIERR        PIC X(200).
           03  WRK-SRYYM           PIC X(06).
           03  WRK-SRYYM-MOT       PIC X(06).
           03  WRK-CREYMD          PIC X(08).
           03  WRK-OIDMSG          PIC X(70).
           03  WRK-YM              PIC X(07). 
           03  WRK-PATH            PIC X(64).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-SHELL-ARG1.
             05  WRK-SHELL-SRYYM   PIC  X(06).
             05  WRK-SHELL-TERMID  PIC  X(16).
             05  WRK-SHELL-SYSYMD  PIC  X(08).
           03  WRK-SHELL-ARG3.
             05  WRK-SHELL-ARG3-OCC    OCCURS  3.
               07  WRK-SHELL-KIKAN-ST  PIC  X(08).
               07  WRK-SHELL-KIKAN-ED  PIC  X(08).
               07  WRK-SHELL-KIKAN-KBN PIC  X(01).
           03  WRK-KIKAN-YMD.
               05  WRK-KIKAN-STYMD-S   PIC  X(08).
               05  WRK-KIKAN-EDYMD-S   PIC  X(08).
               05  WRK-KIKAN-STYMD-W   PIC  X(09).
               05  WRK-KIKAN-EDYMD-W   PIC  X(09).
      *
       01  WRK-HEN-AREA.
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
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    請求管理マスタ
           COPY    "CPSK5010.INC".
      *
      *    定期請求作成指示コード
           COPY    "CPSK5011.INC".
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
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
           MOVE    SPA-O01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-O01         TO  SPA-FREE
      *
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "OERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF      FLG-END             =   1
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
      ***  MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "O01   "            TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           MOVE    1               TO  SPA-GMN-CUR
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
      *
      *        元の画面へ戻す
               IF      SPA-MOTOPG      =   "XB01"
                   MOVE    LNK-COMMON      TO  SPA-KYOUTU
                   MOVE    LNK-SCRSPA      TO  SPA-O01
                   INITIALIZE              SPA-O01KYOUTU
                   GO  TO  300-SCREEN-EXT
               END-IF
      *         
               MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
      *
               INITIALIZE              SPA-O01KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG
      *    作表処理
               WHEN    "OID1"
                   PERFORM 330-OID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
               WHEN    "O02"
               WHEN    "O03"
                   PERFORM 350-O01SPASET-SEC
                   GO      TO      300-SCREEN-EXT
               WHEN    "O99"
                   PERFORM 340-OID2-SET-SEC
                   GO      TO      300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM 310-SPASET-SEC
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           MOVE    SPA-SYSYMD      TO  WRK-SYMD
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG3(1:16)
                                   TO  SPA-O01-SYSYMH
      *
           MOVE    SPACE           TO  SPA-O01
           INITIALIZE                  SPA-O01
      *
           MOVE    "T"             TO  SPA-GMN-IKKATU
           MOVE    "F"             TO  SPA-GMN-KOBETU
      *
           MOVE    SPA-SYSYMD (1:6)
                                   TO  SPA-NAI-SRYYM
           MOVE    SPA-SYSYMDWH (1:6)
                                   TO  SPA-GMN-SRYYM
           MOVE    SPA-O01-SYSYMH  TO  SPA-NAI-SRYYMH
      *
           MOVE    "F"             TO  SPA-GMN-CHK-KIKAN01
                                       SPA-GMN-CHK-KIKAN02
                                       SPA-GMN-CHK-KIKAN03
      *
      *    定期請求期間取得処理
           PERFORM 3101-TEIKI-KIKAN-GET-SEC
      *
           MOVE    1               TO  SPA-GMN-CUR
      *
           MOVE    "T"             TO  SPA-GMN-CHK-KIKAN01
           MOVE    7               TO  SPA-GMN-CUR
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    定期請求期間取得処理
      *****************************************************************
       3101-TEIKI-KIKAN-GET-SEC        SECTION.
      *
           INITIALIZE                  SPA-NAI-KIKAN.
      *
      *??? 暫定的に請求年月の月初から月末のみの指定とする
      *??? INITIALIZE                      SYS-5010-REC
      *??? MOVE    "5010"              TO  SYS-5010-KANRICD
      *??? MOVE    "*"                 TO  SYS-5010-KBNCD
      *??? MOVE    SPA-SYSYMD          TO  ORC-DBYMD
      *??? MOVE    SYS-5010-REC        TO  MCPDATA-REC
      *??? PERFORM 900-SYSKANRI-INV-SEC
      *
           INITIALIZE                  WRK-KIKAN-YMD
      *
           INITIALIZE                      ORCSGDAYAREA
           MOVE    "1"                 TO  SGDAY-INTYPE
           MOVE    SPA-NAI-SRYYM       TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                       ORCSGDAYAREA
           MOVE    SGDAY-OTDAY         TO  WRK-KIKAN-STYMD-W
           MOVE    SGDAY-SDAY          TO  WRK-SYMD
                                           WRK-KIKAN-STYMD-S
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY1-AREA
           MOVE    "71"                TO   LNK-DAY7-IRAI
           MOVE    WRK-SYMD (1:6)      TO   LNK-DAY7-YM
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY7-AREA
           MOVE    LNK-DAY7-KOYOMI     TO  WRK-SYMD
                                           WRK-KIKAN-EDYMD-S
      *
           INITIALIZE                  ORCSGDAYAREA
           MOVE    WRK-SYMD            TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
           MOVE    SGDAY-OTDAY         TO  WRK-KIKAN-EDYMD-W
      *
           MOVE    SPACE               TO  SPA-GMN-KIKAN01
      *
           STRING  WRK-KIKAN-STYMD-W
                   "〜"
                   WRK-KIKAN-EDYMD-W
                   DELIMITED   BY  SIZE
           INTO    SPA-GMN-KIKAN01
           END-STRING
      *
           MOVE    WRK-KIKAN-STYMD-S   TO  SPA-NAI-KIKAN01ST
           MOVE    WRK-KIKAN-EDYMD-S   TO  SPA-NAI-KIKAN01ED
      *
           MOVE    "指定なし"          TO  SPA-GMN-KIKAN02
           MOVE    "指定なし"          TO  SPA-GMN-KIKAN03
      *
           .
       3101-TEIKI-KIKAN-GET-EXT.
           EXIT.
      *****************************************************************
      *    確認画面（ＯＩＤ１）ＯＫ処理
      *****************************************************************
       330-OID1-SET-SEC            SECTION.
      *
           IF      SPA-OID1-FLG    =   "OK"
               IF      SPA-OIDCD       =   "6666"
                   MOVE    "JOIN"          TO  MCP-PUTTYPE
                   PERFORM 210-BACK-SYORI-SEC
               ELSE
                   PERFORM 450-KOUSHIN-SEC
               END-IF
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
      *    確認画面（ＯＩＤ２）ＯＫ処理
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
      *    戻り画面処理
      *****************************************************************
       350-O01SPASET-SEC           SECTION.
      *
           IF    ( SPA-O01KYOUTU       =   SPACE )
               GO  TO  350-O01SPASET-EXT
           END-IF
      *
           MOVE    SPACE                   TO  SPA-O01
           INITIALIZE                          SPA-O01
      *
           EVALUATE    SPA-O01-FILEKBN
               WHEN    "1"
                   MOVE    "T"             TO  SPA-GMN-IKKATU
                   MOVE    "F"             TO  SPA-GMN-KOBETU
               WHEN    "2"
                   MOVE    "F"             TO  SPA-GMN-IKKATU
                   MOVE    "T"             TO  SPA-GMN-KOBETU
           END-EVALUATE
      *
           IF  (   SPA-O01-FILEKBN     =   "1" )
               MOVE    SPA-O01-SRYYM       TO  SPA-NAI-SRYYM
               IF    ( SPA-O01-SRYYM       =   ZERO )
                   MOVE    SPA-SYSYMDWH (1 : 6)
                                           TO  SPA-GMN-SRYYM
                   MOVE    SPA-SYSYMD   (1 : 6)
                                           TO  SPA-NAI-SRYYM
                   MOVE    SPA-O01-SYSYMH  TO  SPA-NAI-SRYYMH
                   PERFORM 3101-TEIKI-KIKAN-GET-SEC
                   MOVE    "F"                 TO  SPA-GMN-CHK-KIKAN01
                   MOVE    "F"                 TO  SPA-GMN-CHK-KIKAN02
                   MOVE    "F"                 TO  SPA-GMN-CHK-KIKAN03
               ELSE
                   MOVE    SPA-O01-SRYYM   TO  WRK-SYMD (1:6)
                   MOVE    "01"            TO  WRK-SYMD (7:2) 
                   PERFORM 5002-HIZUKE-HEN-SEC
                   MOVE    WRK-HENYMDG(1:6)    TO  SPA-GMN-SRYYM
                   MOVE    WRK-HENYMDG3(1:16)  TO  SPA-NAI-SRYYMH
                   PERFORM 3101-TEIKI-KIKAN-GET-SEC
                   MOVE    SPA-O01-CHK-KIKAN01 TO  SPA-GMN-CHK-KIKAN01
                   MOVE    SPA-O01-CHK-KIKAN02 TO  SPA-GMN-CHK-KIKAN02
                   MOVE    SPA-O01-CHK-KIKAN03 TO  SPA-GMN-CHK-KIKAN03
               END-IF
      *
           ELSE
               MOVE    SPA-SYSYMDWH (1 : 6)
                                           TO  SPA-GMN-SRYYM
               MOVE    SPA-SYSYMD   (1 : 6)
                                           TO  SPA-NAI-SRYYM
               MOVE    SPA-O01-SYSYMH      TO  SPA-NAI-SRYYMH
               PERFORM 3101-TEIKI-KIKAN-GET-SEC
               MOVE    "F"                 TO  SPA-GMN-CHK-KIKAN01
               MOVE    "F"                 TO  SPA-GMN-CHK-KIKAN02
               MOVE    "F"                 TO  SPA-GMN-CHK-KIKAN03
           END-IF
      *
           IF    ( SPA-GMN-IKKATU          =   "T" )
               MOVE    7               TO  SPA-GMN-CUR
           ELSE
               MOVE    2               TO  SPA-GMN-CUR
           END-IF
      *
           .
       350-O01SPASET-EXT.
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
                   MOVE    "CHANGE"            TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *     作成区分
               WHEN    "CLICKED"       ALSO    "B08"
                   MOVE    "F"     TO  SPA-GMN-CHK-KIKAN01
                                       SPA-GMN-CHK-KIKAN02
                                       SPA-GMN-CHK-KIKAN03
                   IF    ( SPA-GMN-IKKATU  =   "T" )
                       MOVE    "F" TO  SPA-GMN-IKKATU
                       MOVE    "T" TO  SPA-GMN-KOBETU
                   ELSE
                       MOVE    "T" TO  SPA-GMN-IKKATU
                       MOVE    "F" TO  SPA-GMN-KOBETU
                   END-IF
      *
                   IF    ( SPA-GMN-IKKATU  =   "T" )
                       MOVE    2   TO  SPA-GMN-CUR
                   ELSE
                       MOVE    7   TO  SPA-GMN-CUR
                   END-IF
      *    情報削除
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 490-JYOUHOU-DEL-SEC
      *    確定
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 450-TOUROKU-SEC
      *    処理確認
               WHEN    "CLICKED"       ALSO    "B13"
                   PERFORM 490-KAKUNIN-SEC
      *    期間１
               WHEN    "CLICKED"       ALSO    "CHK_KIKAN01"
                   PERFORM 400-KIKAN01-SEC
      *    期間２
               WHEN    "CLICKED"       ALSO    "CHK_KIKAN02"
                   PERFORM 400-KIKAN02-SEC
      *    期間３
               WHEN    "CLICKED"       ALSO    "CHK_KIKAN03"
                   PERFORM 400-KIKAN03-SEC
      *    一括作成
               WHEN    "CLICKED"       ALSO    "IKKATU"
                   PERFORM 400-IKKATU-SEC
      *    個別作成
               WHEN    "CLICKED"       ALSO    "KOBETU"
                   PERFORM 400-KOBETU-SEC
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
      *
               WHEN    "ACTIVATE"      ALSO    "SRYYM"
                   PERFORM 4101-SRYYM-CHK-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求年月（一括）チェック処理
      *****************************************************************
       4101-SRYYM-CHK-SEC           SECTION.
      *
           MOVE    2                  TO  SPA-GMN-CUR
      *
           IF      SPA-GMN-IKKATU         =   "F"
               MOVE    "0007"             TO  SPA-ERRCD
               MOVE    3                  TO  SPA-GMN-CUR
               GO  TO  4101-SRYYM-CHK-EXT
           END-IF
      *
           MOVE   SPA-GMN-SRYYM        TO  WRK-SRYYM-MOT
           MOVE   O01-SRYYM            TO  SPA-GMN-SRYYM
      *
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    "1"                 TO  SGDAY-INTYPE
           MOVE    SPA-GMN-SRYYM       TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                       ORCSGDAYAREA
           IF      SGDAY-RC            =   ZERO
               MOVE    SGDAY-OTDAY(1:6)    TO  SPA-GMN-SRYYM
               MOVE    SGDAY-SDAY (1:6)    TO  SPA-NAI-SRYYM
           ELSE
               MOVE    WRK-SRYYM-MOT   TO  SPA-GMN-SRYYM
               MOVE    "0001"          TO  SPA-ERRCD
               GO  TO  4101-SRYYM-CHK-EXT
           END-IF
      *
           MOVE    SGDAY-SDAY          TO  WRK-SYMD
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG3(1:16)  TO  SPA-NAI-SRYYMH
      *
           PERFORM 3101-TEIKI-KIKAN-GET-SEC
      *
      *    MOVE    3                   TO  SPA-GMN-CUR
           MOVE    "T"             TO  SPA-GMN-CHK-KIKAN01
           MOVE    7               TO  SPA-GMN-CUR
      *
           .
       4101-SRYYM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
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
               IF      JOB-ENDYMD      =   SPACE
      *********AND     JOB-TERMID      =   SPA-TERMID
                   MOVE    "6666"          TO  SPA-OIDCD
                   GO  TO  210-BACK-EXT
               END-IF
           END-IF
      *
           PERFORM 210-BACK-SYORI-SEC
           .
       210-BACK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK-SYORI-SEC              SECTION.
      *
      *
           MOVE    "M01"               TO  SPA-SAKIPG
           MOVE    "O01"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  SPA-WORK 
           INITIALIZE                  SPA-KYOTUKEY
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
       210-BACK-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    １期選択処理
      *****************************************************************
       400-KIKAN01-SEC          SECTION.
      *
           MOVE    O01-CHK-KIKAN01 TO  SPA-GMN-CHK-KIKAN01
      *
           MOVE    "T"             TO  SPA-GMN-IKKATU
           MOVE    "F"             TO  SPA-GMN-KOBETU
      *
      *    MOVE    4               TO  SPA-GMN-CUR
           MOVE    7               TO  SPA-GMN-CUR
           .
       400-KIKAN01-EXT.
           EXIT.
      *****************************************************************
      *    ２期選択処理
      *****************************************************************
       400-KIKAN02-SEC          SECTION.
      *
      *??? MOVE    O01-CHK-KIKAN02 TO  SPA-GMN-CHK-KIKAN02
      *
      *??? MOVE    "T"             TO  SPA-GMN-IKKATU
      *??? MOVE    "F"             TO  SPA-GMN-KOBETU
      *
           MOVE    "F"             TO  SPA-GMN-CHK-KIKAN02
      *    MOVE    5               TO  SPA-GMN-CUR
           MOVE    2               TO  SPA-GMN-CUR
           .
       400-KIKAN02-EXT.
           EXIT.
      *****************************************************************
      *    ３期選択処理
      *****************************************************************
       400-KIKAN03-SEC          SECTION.
      *
      *??? MOVE    O01-CHK-KIKAN03 TO  SPA-GMN-CHK-KIKAN03
      *
      *??? MOVE    "T"             TO  SPA-GMN-IKKATU
      *??? MOVE    "F"             TO  SPA-GMN-KOBETU
      *
           MOVE    "F"             TO  SPA-GMN-CHK-KIKAN03
      *    MOVE    7               TO  SPA-GMN-CUR
           MOVE    2               TO  SPA-GMN-CUR
           .
       400-KIKAN03-EXT.
           EXIT.
      *****************************************************************
      *    一括作成選択処理
      *****************************************************************
       400-IKKATU-SEC          SECTION.
      *
           MOVE    O01-IKKATU      TO  SPA-GMN-IKKATU
           MOVE    "F"             TO  SPA-GMN-KOBETU
      *
           MOVE    "F"             TO  SPA-GMN-CHK-KIKAN01
                                       SPA-GMN-CHK-KIKAN02
                                       SPA-GMN-CHK-KIKAN03
      *
           MOVE    2               TO  SPA-GMN-CUR
           .
       400-IKKATU-EXT.
           EXIT.
      *
      *****************************************************************
      *    個別作成選択処理
      *****************************************************************
       400-KOBETU-SEC          SECTION.
      *
           MOVE    O01-KOBETU      TO  SPA-GMN-KOBETU
           MOVE    "F"             TO  SPA-GMN-IKKATU
      *
           MOVE    "F"             TO  SPA-GMN-CHK-KIKAN01
                                       SPA-GMN-CHK-KIKAN02
                                       SPA-GMN-CHK-KIKAN03
      *
           .
       400-KOBETU-EXT.
           EXIT.
      *
      *****************************************************************
      *    作表処理
      *****************************************************************
       450-TOUROKU-SEC                SECTION.
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
               IF      JOB-ENDYMD      =   SPACE
                   MOVE    "7777"          TO  SPA-ERRCD
                   MOVE    SPACE             TO  WRK-TEIKIERR
                   STRING  "定期請求処理中です【"
                                             DELIMITED  BY  SIZE
                           JOB-SHELLMSG      DELIMITED  BY  SPACE
                           "】"              DELIMITED  BY  SIZE      
                                             INTO  WRK-TEIKIERR
                   END-STRING                          
                   GO  TO  450-TOUROKU-EXT
               END-IF
           END-IF    
      *
      *    画面移行用のパラメタ変更
           PERFORM 45011-PARA-HENSYU-SEC
      *
      *    一括作成のときのチェック
           EVALUATE    SPA-GMN-IKKATU
               WHEN    "T"
                   IF    ( SPA-NAI-SRYYM      =   ZERO )
                       MOVE    "0001"              TO  SPA-ERRCD
                       GO  TO  450-TOUROKU-EXT
                   END-IF
      *
                   IF    ( SPA-GMN-CHK-KIKAN01 =   "F" )
                    AND  ( SPA-GMN-CHK-KIKAN02 =   "F" )
                    AND  ( SPA-GMN-CHK-KIKAN03 =   "F" )
                       MOVE    "0020"              TO  SPA-ERRCD
                       GO  TO  450-TOUROKU-EXT
                   END-IF
      *
           END-EVALUATE
      *
      *    ガイドメッセージセット
           IF    ( SPA-O01-FILEKBN     =   "1" )
               MOVE    "1001"              TO  SPA-OIDCD
           ELSE
               MOVE    "1003"              TO  SPA-OIDCD
           END-IF
           .
       450-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新処理
      *****************************************************************
       450-KOUSHIN-SEC                 SECTION.
      *
      *    新規分作成のとき定期請求指示コード更新
      *
           EVALUATE SPA-GMN-IKKATU
           WHEN    "T"
               INITIALIZE                  SYS-5011-REC
               MOVE    "5011"              TO  SYS-5011-KANRICD
               MOVE    "*"                 TO  SYS-5011-KBNCD
               MOVE    SPA-SYSYMD          TO  ORC-DBYMD
               MOVE    SYS-5011-REC        TO  MCPDATA-REC
               PERFORM 900-SYSKANRI-INV-SEC
               IF      FLG-SYSKANRI        =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-5011-REC
               ELSE
                   INITIALIZE                  SYS-5011-REC
                   MOVE    "5011"          TO  SYS-5011-KANRICD
                   MOVE    "*"             TO  SYS-5011-KBNCD
                   MOVE    ZERO            TO  SYS-5011-STYUKYMD
                   MOVE    ALL "9"         TO  SYS-5011-EDYUKYMD
               END-IF 
               MOVE    "1"                 TO  SYS-5011-SYOKBN
               MOVE    SPA-NAI-SRYYM       TO  SYS-5011-SRYYM
               MOVE    SYS-5011-REC        TO  MCPDATA-REC
               IF      FLG-SYSKANRI        =   1
                   MOVE    "DBINSERT"          TO  MCP-FUNC
               ELSE
                   MOVE    "DBUPDATE"          TO  MCP-FUNC
               END-IF
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO 
                   MOVE    "1001"              TO  SPA-ERRCD
                   DISPLAY "5011 SYSKANRI-KEY =>" SYS-5011-KEY 
                   GO  TO  450-KOUSHIN-EXT
               END-IF
      *
      *        ジョブ開始セット
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
               MOVE    "TEIKIERR"          TO  TEIKIERR-FILE-ID
               MOVE    SPA-TERMID          TO  TEIKIERR-TERMID
      *
               OPEN    OUTPUT   TEIKIERR-FILE
               CLOSE   TEIKIERR-FILE
      *
               MOVE    SPACE               TO  SHELLTBL
      *
               MOVE    "teikiseikyu.sh"    TO  WRK-SHELL-SHELL
      *
      *        ファイルデイレクトリ位置指定
               INITIALIZE              ORCSMKPASSAREA
               MOVE    WRK-SHELL-NAME  TO  MKPASS-IN-01
               CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
      *
               MOVE    SPA-NAI-SRYYM   TO  WRK-SHELL-SRYYM
               MOVE    SPA-TERMID      TO  WRK-SHELL-TERMID
               MOVE    SPA-SYSYMD      TO  WRK-SHELL-SYSYMD
               MOVE    WRK-SHELL-ARG1  TO  SHELLTBL-ARG1
               MOVE    "1"             TO  SHELLTBL-ARG2
      *
               MOVE    SPA-NAI-KIKAN01ST
                                       TO  WRK-SHELL-KIKAN-ST (1)
               MOVE    SPA-NAI-KIKAN01ED
                                       TO  WRK-SHELL-KIKAN-ED (1)
               IF    ( SPA-GMN-CHK-KIKAN01 =   "T" )
                   MOVE    "1"         TO  WRK-SHELL-KIKAN-KBN (1)
               ELSE
                   MOVE    SPACE       TO  WRK-SHELL-KIKAN-KBN (1)
               END-IF
      *
               MOVE    SPA-NAI-KIKAN02ST
                                       TO  WRK-SHELL-KIKAN-ST (2)
               MOVE    SPA-NAI-KIKAN02ED
                                       TO  WRK-SHELL-KIKAN-ED (2)
               IF    ( SPA-GMN-CHK-KIKAN02 =   "T" )
                   MOVE    "1"         TO  WRK-SHELL-KIKAN-KBN (2)
               ELSE
                   MOVE    SPACE       TO  WRK-SHELL-KIKAN-KBN (2)
               END-IF
      *
               MOVE    SPA-NAI-KIKAN03ST
                                       TO  WRK-SHELL-KIKAN-ST (3)
               MOVE    SPA-NAI-KIKAN03ED
                                       TO  WRK-SHELL-KIKAN-ED (3)
               IF    ( SPA-GMN-CHK-KIKAN03 =   "T" )
                   MOVE    "1"         TO  WRK-SHELL-KIKAN-KBN (3)
               ELSE
                   MOVE    SPACE       TO  WRK-SHELL-KIKAN-KBN (3)
               END-IF
      *
               MOVE    WRK-SHELL-ARG3
                                       TO  SHELLTBL-ARG3
               MOVE    TEIKIERR        TO  SHELLTBL-ARG4
               MOVE    WRK-CONS-JOB-JOBID
                                       TO  SHELLTBL-ARG5
               MOVE    WRK-CONS-JOB-SHELLID
                                       TO  SHELLTBL-ARG6
               MOVE    "DUMMY"         TO  SHELLTBL-ARG7
               MOVE    SPA-NAI-SRYYM   TO  SHELLTBL-ARG8
               MOVE    SHELLTBL        TO  MCPDATA-REC
               MOVE    "SHELL"         TO  MCP-FUNC
               MOVE    PATH-SHELL-SHELL
                                       TO  MCP-PATH
               CALL    "MCPSUB"        USING
                                           MCPAREA
                                           MCPDATA-REC
      *        情報確認画面を表示
               PERFORM 490-KAKUNIN-SEC
           WHEN    OTHER
                PERFORM 4501-NEXT-GMN-SEC
           END-EVALUATE
      *
           .
       450-KOUSHIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新処理
      *****************************************************************
       4501-NEXT-GMN-SEC            SECTION.       
      *
           MOVE    "O01"               TO  SPA-MOTOPG
      *
           IF      SPA-OID1-FLG        =   "OK"
               IF      SPA-GMN-KOBETU      =   "T"
                   MOVE    "O02"               TO  SPA-SAKIPG
               ELSE
                   MOVE    "O03"               TO  SPA-SAKIPG
               END-IF 
           ELSE
                   MOVE    "O03"               TO  SPA-SAKIPG
           END-IF
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
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
      *    画面移行用のパラメタ変更処理
      *****************************************************************
       45011-PARA-HENSYU-SEC           SECTION.
      *
           IF    ( SPA-GMN-IKKATU          =   "T" )
               MOVE    "1"             TO  SPA-O01-FILEKBN
               MOVE    SPA-NAI-SRYYM   TO  SPA-O01-SRYYM
               MOVE    SPA-GMN-CHK-KIKAN01
                                       TO  SPA-O01-CHK-KIKAN01
               MOVE    SPA-GMN-CHK-KIKAN02
                                       TO  SPA-O01-CHK-KIKAN02
               MOVE    SPA-GMN-CHK-KIKAN03
                                       TO  SPA-O01-CHK-KIKAN03
      *
               INITIALIZE              SPA-O01-KIKAN
               MOVE    SPA-NAI-KIKAN01ST
                                       TO  SPA-O01-KIKAN01ST
               MOVE    SPA-NAI-KIKAN01ED
                                       TO  SPA-O01-KIKAN01ED
           ELSE
               MOVE    "2"             TO  SPA-O01-FILEKBN
               MOVE    ZERO            TO  SPA-O01-SRYYM
               MOVE    "F"             TO  SPA-O01-CHK-KIKAN01
               MOVE    "F"             TO  SPA-O01-CHK-KIKAN02
               MOVE    "F"             TO  SPA-O01-CHK-KIKAN03
               INITIALIZE              SPA-O01-KIKAN
           END-IF
      *
           MOVE    SPA-O01KYOUTU       TO  SPA-WORK
      *
           .
       45011-PARA-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理確認処理
      *****************************************************************
       490-KAKUNIN-SEC            SECTION.
      *
      *    画面移行用のパラメタ
           PERFORM 45011-PARA-HENSYU-SEC
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
           IF    ( SJOBKANRI-RETURN
                                   =   ZERO )
               MOVE    1               TO  IDX1
               MOVE    JOB-JOBID       TO  O99-RENNUM   (IDX1)
               MOVE    JOB-SHELLMSG    TO  O99-SHORINM  (IDX1)
               MOVE    JOB-STARTTIME(1:2)
                                       TO  WRK-HH
               MOVE    JOB-STARTTIME(3:2)
                                       TO  WRK-MM
               MOVE    JOB-STARTTIME(5:2)
                                       TO  WRK-SS
               MOVE    WRK-HENTIME     TO  O99-STARTTIME(IDX1)
               MOVE    JOB-ENDTIME(1:2)
                                       TO  WRK-HH
               MOVE    JOB-ENDTIME(3:2)
                                       TO  WRK-MM
               MOVE    JOB-ENDTIME(5:2)
                                       TO  WRK-SS
               MOVE    WRK-HENTIME     TO  O99-ENDTIME  (IDX1)
               MOVE    JOB-YOBI        TO  O99-ERRMSG   (IDX1)
               IF      JOB-ENDYMD      =   SPACE
                   MOVE    "処理中です"    TO  O99-MSG
               ELSE
                   IF    (  JOB-ERRCD      =   SPACE )
                       CONTINUE
                   ELSE
                       STRING  JOB-YOBI    DELIMITED  BY  SPACE
                               "【"        DELIMITED  BY  SIZE
                              JOB-SHELLMSG DELIMITED  BY  SPACE
                              "】"         DELIMITED  BY  SIZE      
                                           INTO  O99-MSG
                   END-IF                          
               END-IF    
               MOVE    IDX1                TO  O99-COUNT    
           END-IF
      *
           MOVE    WIDGET-INSENSITIVE   TO  O99-B12-STATE
           IF    ( O99-MSG              =   SPACE )
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
           MOVE    "O01"               TO  SPA-MOTOPG
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
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC         SECTION.
      *
           IF      WRK-YM   (1:5)  NOT NUMERIC
               INSPECT     WRK-YM       REPLACING   ALL " " BY  "0"
               MOVE    WRK-YM(1:1)      TO  WRK-WGO
               MOVE    WRK-YM(2:2)      TO  WRK-WYY
               MOVE    WRK-YM(5:2)      TO  WRK-WMM
           ELSE
               MOVE    WRK-YM(1:5)      TO  WRK-WYMD (1:5)
           END-IF
           MOVE    "01"             TO  WRK-WDD
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY1-AREA
           MOVE    "12"                TO  LNK-DAY1-IRAI
           MOVE    ZERO                TO  LNK-DAY1-YMD
           MOVE    WRK-WYMD            TO  LNK-DAY1-YMD(2:7)
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY1-AREA
           IF      STS-DAY-RC1     NOT =   ZERO
               MOVE    "0001"          TO  SPA-ERRCD
           ELSE
               MOVE    LNK-DAY1-YMD        TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
           END-IF
           .
       5002-HIZUKE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    和暦西暦変換編集処理
      *****************************************************************
       5002-HIZUKE-HEN-SEC          SECTION.
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
               CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
               MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG3
           END-IF
      *
           .
       5002-HIZUKE-HEN-EXT.
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
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-OIDCD       NOT =   SPACE
               PERFORM 520-OIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-OIDCD2      NOT =   SPACE
               PERFORM 530-OIDSET2-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "O01    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    SPACE               TO  O01
      *
           MOVE    SPA-GMN-SRYYM       TO  O01-SRYYM
      *
           MOVE    SPA-GMN-IKKATU      TO  O01-IKKATU
           MOVE    SPA-GMN-KOBETU      TO  O01-KOBETU
           MOVE    SPA-GMN-CHK-KIKAN01 TO  O01-CHK-KIKAN01
           MOVE    SPA-GMN-CHK-KIKAN02 TO  O01-CHK-KIKAN02
           MOVE    SPA-GMN-CHK-KIKAN03 TO  O01-CHK-KIKAN03
           MOVE    SPA-GMN-KIKAN01     TO  O01-KIKAN01
           MOVE    SPA-GMN-KIKAN02     TO  O01-KIKAN02
           MOVE    SPA-GMN-KIKAN03     TO  O01-KIKAN03
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
         EVALUATE    SPA-GMN-CUR
             WHEN    1
                    MOVE  "SYOKBN"     TO  MCP-WIDGET
             WHEN    2
                    MOVE  "SRYYM"      TO  MCP-WIDGET
             WHEN    3
                    MOVE  "CHK_KIKAN01"
                                       TO  MCP-WIDGET
             WHEN    4
                    MOVE  "CHK_KIKAN02"
                                       TO  MCP-WIDGET
             WHEN    5
                    MOVE  "CHK_KIKAN03"
                                       TO  MCP-WIDGET
             WHEN    7
                    MOVE  "B12"        TO  MCP-WIDGET
         END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
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
                   MOVE    "入力エラーです"            TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE
                       "作成済のデータがないので再印刷は指定できません"
                                                       TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "対象のデータを選択してありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "対象のデータが選択してあります"
                                                       TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "個別作成のとき入力できません"
                                                       TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "定期請求指示コードが更新できません"
                                                       TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "作成済みの帳票管理ファイルがありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0020"
                   MOVE    "対象の期間を選択してありません"
                                                       TO  SPA-ERRMSG
               WHEN    "7777"
                   MOVE    WRK-TEIKIERR                TO  SPA-ERRMSG
               WHEN    "9999"
                   MOVE    WRK-TEIKIERR                TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  OERR
           MOVE    SPA-ERRCD            TO  OERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  OERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "O01"                TO  SPA-MOTOPG
           MOVE    "OERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "OERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       510-ERRMSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       520-OIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-OIDMSG
      *
           EVALUATE    SPA-OIDCD
               WHEN    "1001"
                   MOVE    SPA-NAI-SRYYMH   TO  WRK-OIDMSG
                   MOVE    "分新規作成処理を行います"
                                            TO  WRK-OIDMSG (17:)
               WHEN    "1003"
                   MOVE    "個別作成分の新規作成処理を行います" 
                                            TO  WRK-OIDMSG
               WHEN    "6666"
                   MOVE    "患者請求作成処理中です"
                                            TO  WRK-OIDMSG
               WHEN    "8888"
                   MOVE    "患者請求作成処理が正常終了しました"
                                            TO  WRK-OIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  OID1
           MOVE    SPA-OIDCD            TO  OID1-ID1CODE
           MOVE    WRK-OIDMSG           TO  OID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "O01"                TO  SPA-MOTOPG
           MOVE    "OID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "OID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-OIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       530-OIDSET2-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-OIDMSG
      *
           EVALUATE    SPA-OIDCD2
               WHEN    "8888"
                   MOVE    "定期請求作成処理が正常終了しました"
                                                       TO  WRK-OIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  OID2
           MOVE    SPA-OIDCD2           TO  OID2-ID1CODE
           MOVE    WRK-OIDMSG           TO  OID2-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "O01"                TO  SPA-MOTOPG
           MOVE    "OID2"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "OID2"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
      *
           .
       530-OIDSET2-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-SYSKANRI-INV-SEC         SECTION.
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
       900-SYSKANRI-INV-EXT.
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
