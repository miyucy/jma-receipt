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
       PROGRAM-ID.             ORCGG02.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次統計
      *  コンポーネント名  : 月次統計データ作成
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/11/12    NACL−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-藤原    04.02.17  ファイルの出力先指定
      *  01.00.05    NACL-伊藤    04.02.17  レセ電ファイルの転送エラー
      *                                     メッセージの追加
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *    エラーファイル
           SELECT  TOUKEIERR-FILE    ASSIGN  TOUKEIERR
                                   FILE    STATUS  IS  STS-TOUKEIERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    エラーファイル
       FD  TOUKEIERR-FILE.
       01  TOUKEIERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT5.INC"
                                   REPLACING  //TEIKI01PARA//
                                   BY         //TOUKEIERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    月次統計共通パラメタ
           COPY    "G01COMMON-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-G02.
           03  SPA-G02-AREA.
               05  SPA-GMN-MAX                     PIC 9(04).
               05  SPA-GMN-PAGE                    PIC 9(02).
               05  SPA-GMN-CUR                     PIC 9(02).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-SRYYM               PIC X(07).
                   07  SPA-GMN-FILENM1             PIC X(150).
                   07  SPA-GMN-FILENM2             PIC X(150).
      *                         
                   07  SPA-GMN-NYUGAIKBNLST        OCCURS  2.
                       09  SPA-GMN-NYUGAIKBNL      PIC X(01).
                       09  SPA-GMN-F1L             PIC X(01).
                       09  SPA-GMN-NYUGAIKBNMEIL   PIC X(06).    
                   07  SPA-GMN-NYUGAIKBN-MAX       PIC 9(02).
      *             
                   07  SPA-GMN-NYUGAIKBN-G.
                       09  SPA-GMN-NYUGAIKBN       PIC X(01).
                       09  SPA-GMN-F1              PIC X(01).
                       09  SPA-GMN-NYUGAIKBNMEI    PIC X(06).
      *
                   07  SPA-GMN-FILE1LST            OCCURS  5.
                       09  SPA-GMN-FILE1L          PIC X(01).
                       09  SPA-GMN-F1L             PIC X(01).
                       09  SPA-GMN-FILE1MEIL       PIC X(20).
                   07  SPA-GMN-FILE1-MAX           PIC 9(02).    
      *                                             
                   07  SPA-GMN-FILE1-G.
                       09  SPA-GMN-FILE1           PIC X(01).
                       09  SPA-GMN-F1              PIC X(01).
                       09  SPA-GMN-FILE1MEI        PIC X(20).
      *                                             
                   07  SPA-GMN-FILE2LST            OCCURS  5.
                       09  SPA-GMN-FILE2L          PIC X(01).
                       09  SPA-GMN-F1L             PIC X(01).
                       09  SPA-GMN-FILE2MEIL       PIC X(20).
                   07  SPA-GMN-FILE2-MAX           PIC 9(02).    
      *                                             
                   07  SPA-GMN-FILE2-G.
                       09  SPA-GMN-FILE2           PIC X(01).
                       09  SPA-GMN-F1              PIC X(01).
                       09  SPA-GMN-FILE2MEI        PIC X(20).
      *
                   07  SPA-GMN-DATAKBN.         
                       09  SPA-GMN-DATAKBN1-VALUE  PIC X(01).
                       09  SPA-GMN-DATAKBN2-VALUE  PIC X(01).
                       09  SPA-GMN-DATAKBN3-VALUE  PIC X(01).
      *
                   07  SPA-GMN-KOJINKBN.         
                       09  SPA-GMN-KOJINKBN1-VALUE PIC X(01).
                       09  SPA-GMN-KOJINKBN2-VALUE PIC X(01).
      *
                   07  SPA-GMN-HOUKATUKBN.         
                       09  SPA-GMN-HOUKATUKBN1-VALUE
                                                   PIC X(01).
                       09  SPA-GMN-HOUKATUKBN2-VALUE
                                                   PIC X(01).
      *
                   07  SPA-GMN-CDKBN.         
                       09  SPA-GMN-CDKBN1-VALUE    PIC X(01).
                       09  SPA-GMN-CDKBN2-VALUE    PIC X(01).
      *
               05  SPA-NAIB-G02-AREA.
                   07  SPA-NAI-SRYYM               PIC 9(06).
                   07  SPA-NAI-SRYYMH              PIC X(16).
                   07  SPA-NAI-NYUGAIKBN           PIC X(06).
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-TOUKEIERR         PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-TOUROKU         PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDX2                PIC 9(04).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME.
               05  SYS-THH         PIC 9(02).
               05  SYS-TMM         PIC 9(02).
               05  SYS-TSS         PIC 9(02).
               05  SYS-TDD         PIC 9(02).
           03  SYS-YMD.
               05  SYS-YY          PIC 9(02).
               05  SYS-MM          PIC 9(02).
               05  SYS-DD          PIC 9(02).
           03  WRK-SYSYMD.
               05  WRK-SYSYY       PIC 9(04).
               05  WRK-SYSMM       PIC 9(02).
               05  WRK-SYSDD       PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-TOUKEIERR         PIC X(200).
           03  WRK-SRYYM           PIC X(06).
           03  WRK-CREYMD          PIC X(08).
           03  WRK-GIDMSG          PIC X(70).
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
           03  WRK-HENFLG          PIC 9(01).    
      *     
           03  WRK-SHELL-ARG1.
             05  WRK-SHELL-SRYYM   PIC  X(06).
             05  WRK-SHELL-TERMID  PIC  X(16).
             05  WRK-SHELL-SYSYMD  PIC  X(08).  
      *    入力項目名
           03  WRK-MCP-WIDGET          PIC X(64).
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
           03  WRK-CONS-JOB-SHELLID        PIC X(08)   VALUE "MONTHLY1".
           03  WRK-CONS-JOB-JOBID          PIC 9(07)   VALUE 1.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理
           COPY    "CPSK1001.INC".
      *
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".
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
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *   画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
      *
      *ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    患者番号変換サブ
           COPY    "CPORCSPTNUM.INC".
      *
           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".         
           COPY    "ORCA-DBMETA".
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
           COPY    "G01.INC".
           COPY    "G02.INC".
           COPY    "G99.INC".
           COPY    "GERR.INC".
           COPY    "GID1.INC".
           COPY    "GID2.INC".
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
           MOVE    SPA-FREE        TO  SPA-G02
           MOVE    SPA-WORK        TO  SPA-G01KYOUTU
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
           MOVE    SPA-G01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-G02         TO  SPA-FREE
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
           IF      SPA-MOTOPG          =   "GERR"
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
               IF      SPA-GIDCD       NOT =   SPACE
                   EVALUATE    SPA-GIDCD
                       WHEN    "2001"
                           PERFORM 520-GIDSET-SEC
                           GO  TO  100-INIT-EXT
                   END-EVALUATE
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "G02    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *
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
               IF      SPA-MOTOPG      =   "XA01"  OR  "XB01"
                   MOVE    LNK-COMMON      TO  SPA-KYOUTU
                   MOVE    LNK-SCRSPA      TO  SPA-G02
                   INITIALIZE              SPA-G01KYOUTU
                   GO  TO  300-SCREEN-EXT
               END-IF
      *         
               MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
      *
               INITIALIZE              SPA-G01KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG
      *    作表処理
               WHEN    "GID1"
                   PERFORM 330-GID1-SET-SEC
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
      *
           INITIALIZE              SPA-G02-AREA
      *
      *****IF      SPA-BEDSU       >   ZERO
      *         MOVE    "1"             TO  SPA-GMN-NYUGAIKBNL       (1)
      *         MOVE    "入院"          TO  SPA-GMN-NYUGAIKBNMEIL    (1)
      *         MOVE    "2"             TO  SPA-GMN-NYUGAIKBNL       (2)
      *         MOVE    "入院外"        TO  SPA-GMN-NYUGAIKBNMEIL    (2)
      *         MOVE    2               TO  SPA-GMN-NYUGAIKBN-MAX
      *     ELSE
      *         MOVE    "2"             TO  SPA-GMN-NYUGAIKBNL       (1)
      *         MOVE    "入院外"        TO  SPA-GMN-NYUGAIKBNMEIL    (1)
      *         MOVE    1               TO  SPA-GMN-NYUGAIKBN-MAX
      *****END-IF
      *
           MOVE    "2"             TO  SPA-GMN-NYUGAIKBNL       (1)
           MOVE    "入院外"        TO  SPA-GMN-NYUGAIKBNMEIL    (1)
           MOVE    1               TO  SPA-GMN-NYUGAIKBN-MAX
      *
           MOVE    SPA-GMN-NYUGAIKBNLST (1)
                                   TO  SPA-GMN-NYUGAIKBN-G
      *
           MOVE    "1"             TO  SPA-GMN-FILE1L        (1)
           MOVE    "フロッピィ"    TO  SPA-GMN-FILE1MEIL     (1)
           MOVE    "2"             TO  SPA-GMN-FILE1L        (2)
           MOVE    "ＭＯ"          TO  SPA-GMN-FILE1MEIL     (2)
           MOVE    "3"             TO  SPA-GMN-FILE1L        (3)
           MOVE    "ユーザー指定場所１"
                                   TO  SPA-GMN-FILE1MEIL     (3)
           MOVE    "4"             TO  SPA-GMN-FILE1L        (4)
           MOVE    "ユーザー指定場所２"
                                   TO  SPA-GMN-FILE1MEIL     (4)
           MOVE    "5"             TO  SPA-GMN-FILE1L        (5)
           MOVE    "ユーザー指定場所３"
                                   TO  SPA-GMN-FILE1MEIL     (5)
           MOVE    5               TO  SPA-GMN-FILE1-MAX
      *
           MOVE    SPA-GMN-FILE1LST (1)
                                   TO  SPA-GMN-FILE1-G
      *
           MOVE    "1"             TO  SPA-GMN-FILE2L        (1)
           MOVE    "フロッピィ"    TO  SPA-GMN-FILE2MEIL     (1)
           MOVE    "2"             TO  SPA-GMN-FILE2L        (2)
           MOVE    "ＭＯ"          TO  SPA-GMN-FILE2MEIL     (2)
           MOVE    "3"             TO  SPA-GMN-FILE2L        (3)
           MOVE    "ユーザー指定場所１"
                                   TO  SPA-GMN-FILE2MEIL     (3)
           MOVE    "4"             TO  SPA-GMN-FILE2L        (4)
           MOVE    "ユーザー指定場所２"
                                   TO  SPA-GMN-FILE2MEIL     (4)
           MOVE    "5"             TO  SPA-GMN-FILE2L        (5)
           MOVE    "ユーザー指定場所３"
                                   TO  SPA-GMN-FILE2MEIL     (5)
           MOVE    5               TO  SPA-GMN-FILE2-MAX
      *
           MOVE    SPA-GMN-FILE2LST (1)
                                       TO  SPA-GMN-FILE2-G
      *
           MOVE    "T"             TO  SPA-GMN-DATAKBN1-VALUE
           MOVE    "F"             TO  SPA-GMN-DATAKBN2-VALUE
           MOVE    "F"             TO  SPA-GMN-DATAKBN3-VALUE
           MOVE    "T"             TO  SPA-GMN-HOUKATUKBN1-VALUE
           MOVE    "F"             TO  SPA-GMN-HOUKATUKBN2-VALUE
           MOVE    "T"             TO  SPA-GMN-KOJINKBN1-VALUE
           MOVE    "F"             TO  SPA-GMN-KOJINKBN2-VALUE
           MOVE    "T"             TO  SPA-GMN-CDKBN1-VALUE
           MOVE    "F"             TO  SPA-GMN-CDKBN2-VALUE
      *
           MOVE    1               TO  SPA-GMN-CUR
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＧＩＤ１）ＯＫ処理
      *****************************************************************
       330-GID1-SET-SEC            SECTION.
      *
           IF      SPA-GID1-FLG    =   "OK"
               EVALUATE    SPA-GIDCD
                   WHEN    "6666"
                       MOVE    "JOIN"             TO  MCP-PUTTYPE
                       PERFORM 210-BACK-SYORI-SEC
                   WHEN    "1004"
                       IF    ( SPA-GMN-FILE1       =   "1" OR  "2" )
                       AND   ( SPA-GMN-FILE2       =   "1" OR  "2" )
                           MOVE    SPACE               TO  SPA-GID1-FLG
                           MOVE    "2001"              TO  SPA-GIDCD
                           GO  TO  330-GID1-SET-EXT
                       ELSE
                           PERFORM 500-KAKUTEI-SEC
                       END-IF
                   WHEN    "2001"
                       PERFORM 500-KAKUTEI-SEC
               END-EVALUATE
           END-IF
      *
           MOVE    SPACE           TO  SPA-GID1-FLG
           MOVE    SPACE           TO  SPA-GIDCD
           .
       330-GID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *     戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE    "CHANGE"            TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *     情報削除
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 490-JYOUHOU-DEL-SEC
      *    確定
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 450-KAKUTEI-MAE-SEC
      *    処理確認
               WHEN    "CLICKED"       ALSO    "B13"
                   PERFORM 490-KAKUNIN-SEC
      *    処理区分
               WHEN    "CLICKED"       ALSO    "DATAKBN1"
               WHEN    "CLICKED"       ALSO    "DATAKBN2"
               WHEN    "CLICKED"       ALSO    "DATAKBN3"
                   PERFORM 400-DATAKBN-SEC
      *    作成内容区分
               WHEN    "CLICKED"       ALSO    "HOUKATUKBN1"
               WHEN    "CLICKED"       ALSO    "HOUKATUKBN2"
                   PERFORM 400-HOUKATUKBN-SEC
      *    個人情報
               WHEN    "CLICKED"       ALSO    "KOJINKBN1"
               WHEN    "CLICKED"       ALSO    "KOJINKBN2"
                   PERFORM 400-KOJINKBN-SEC
      *    文字コード
               WHEN    "CLICKED"       ALSO    "CDKBN1"
               WHEN    "CLICKED"       ALSO    "CDKBN2"
                   PERFORM 400-CDKBN-SEC
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           MOVE    ZERO                TO  SPA-GMN-CUR
      *
           MOVE    ZERO                TO  FLG-TOUROKU
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           .
       200-ENTRY-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC       SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *    基本チェック処理
           PERFORM 4102-KIHON-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      410-INPUT-CHK-EXT
           END-IF
      *
           IF      FLG-TOUROKU         =   1
      *        更新前
               PERFORM 4101-KAKUTEI-CHK-SEC
           END-IF
      *
           .
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面をＳＰＡセット処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC       SECTION.
      *
           MOVE    G02-SRYYM            TO  SPA-GMN-SRYYM
           MOVE    G02-NYUGAIKBN        TO  SPA-GMN-NYUGAIKBN-G
           MOVE    G02-FILENM1          TO  SPA-GMN-FILENM1
           MOVE    G02-FILENM2          TO  SPA-GMN-FILENM2
           MOVE    G02-FILE1            TO  SPA-GMN-FILE1-G
           MOVE    G02-FILE2            TO  SPA-GMN-FILE2-G
      *
           .
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC       SECTION.
      *
      *    診療年月
           PERFORM 41021-SRYYM-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    入外区分
           PERFORM 41022-NYUGAIKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    （診療）出力先
           PERFORM 41023-FILE1-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    （病名）出力先
           PERFORM 41024-FILE2-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    （診療）出力ファイル名
           PERFORM 41025-FILENM1-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    （病名）出力ファイル名
           PERFORM 41026-FILENM2-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           .
       4102-KIHON-CHK-EXT.
           EXIT.
           .
      *
      *****************************************************************
      *    診療年月チェック処理
      *****************************************************************
       41021-SRYYM-CHK-SEC           SECTION.
      *
           MOVE    ZERO               TO  SPA-NAI-SRYYM
           MOVE    SPACE              TO  SPA-NAI-SRYYMH
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
               MOVE    SGDAY-SDAY          TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG3(1:16)  TO  SPA-NAI-SRYYMH
           ELSE
               MOVE    "0001"          TO  SPA-ERRCD
           END-IF
           .
       41021-SRYYM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入外区分チェック処理
      *****************************************************************
       41022-NYUGAIKBN-CHK-SEC                SECTION.
      *
           MOVE    ZERO               TO  WRK-HENFLG
           PERFORM VARYING IDY FROM   1   BY  1
                   UNTIL   IDY >      SPA-GMN-NYUGAIKBN-MAX
                   OR      WRK-HENFLG =   1
               IF      SPA-GMN-NYUGAIKBN 
                               =   SPA-GMN-NYUGAIKBNL (IDY)
                   MOVE    SPA-GMN-NYUGAIKBNLST (IDY)
                                      TO  SPA-GMN-NYUGAIKBN-G
                   MOVE    1          TO  WRK-HENFLG
               END-IF
           END-PERFORM
           IF      WRK-HENFLG         =   ZERO
               MOVE    "0002"               TO  SPA-ERRCD
           END-IF
           .
       41022-NYUGAIKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    （診療）出力先チェック処理
      *****************************************************************
       41023-FILE1-CHK-SEC           SECTION.
      *
           IF      SPA-GMN-FILE1     =   SPACE
               MOVE    SPA-GMN-FILE1LST (1)
                                           TO  SPA-GMN-FILE1-G
           ELSE
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SPA-GMN-FILE1-MAX
                   IF        SPA-GMN-FILE1
                                   =   SPA-GMN-FILE1L (IDX)
                       MOVE    SPA-GMN-FILE1MEIL (IDX)
                                           TO  SPA-GMN-FILE1MEI
                       MOVE    SPA-GMN-FILE1-MAX
                                           TO  IDX
                   END-IF
               END-PERFORM        
               IF      SPA-GMN-FILE1MEI  =   SPACE  
                   MOVE    SPA-GMN-FILE1LST (1)
                                               TO  SPA-GMN-FILE1-G
               END-IF
           END-IF
           .
       41023-FILE1-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    （病名）出力先チェック処理
      *****************************************************************
       41024-FILE2-CHK-SEC           SECTION.
      *
           IF      SPA-GMN-FILE2     =   SPACE
               MOVE    SPA-GMN-FILE2LST (1)
                                           TO  SPA-GMN-FILE2-G
           ELSE
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SPA-GMN-FILE2-MAX
                   IF        SPA-GMN-FILE2
                                   =   SPA-GMN-FILE2L (IDX)
                       MOVE    SPA-GMN-FILE2MEIL (IDX)
                                           TO  SPA-GMN-FILE2MEI
                       MOVE    SPA-GMN-FILE2-MAX
                                           TO  IDX
                   END-IF
               END-PERFORM        
               IF      SPA-GMN-FILE2MEI  =   SPACE  
                   MOVE    SPA-GMN-FILE2LST (1)
                                               TO  SPA-GMN-FILE2-G
               END-IF
           END-IF
           .
       41024-FILE2-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    （病名）出力先ファイル名チェック処理
      *****************************************************************
       41025-FILENM1-CHK-SEC           SECTION.
      *
           IF      SPA-GMN-FILENM1     =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       150
                       OR      SPA-GMN-FILENM1 (IDX:1)
                                           =   SPACE
                   IF        SPA-GMN-FILENM1 (IDX:1)
                                               =   "/"
                       MOVE    "0005"              TO  SPA-ERRCD
                       MOVE    4                   TO  SPA-GMN-CUR
                       MOVE    150                 TO  IDX
                   END-IF
               END-PERFORM        
           END-IF
           .
       41025-FILENM1-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    （病名）出力先ファイル名チェック処理
      *****************************************************************
       41026-FILENM2-CHK-SEC           SECTION.
      *
           IF      SPA-GMN-FILENM2     =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       150
                       OR      SPA-GMN-FILENM2 (IDX:1)
                                           =   SPACE
                   IF        SPA-GMN-FILENM2 (IDX:1)
                                               =   "/"
                       MOVE    "0005"              TO  SPA-ERRCD
                       MOVE    6                   TO  SPA-GMN-CUR
                       MOVE    150                 TO  IDX
                   END-IF
               END-PERFORM        
           END-IF
           .
       41026-FILENM2-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    確定ボタン押下時チェック処理
      *****************************************************************
       4101-KAKUTEI-CHK-SEC        SECTION.
      *
           IF    ( SPA-GMN-DATAKBN2-VALUE  =   "T" )
           OR    ( SPA-GMN-DATAKBN1-VALUE  =   "T" )
               IF      SPA-GMN-FILENM1         =   SPACE
                   MOVE    4                   TO  SPA-GMN-CUR
                   MOVE    "0003"              TO  SPA-ERRCD
                   GO  TO  4101-KAKUTEI-CHK-EXT
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-DATAKBN3-VALUE  =   "T" )
           OR    ( SPA-GMN-DATAKBN1-VALUE  =   "T" )
               IF      SPA-GMN-FILENM2         =   SPACE
                   MOVE    6                   TO  SPA-GMN-CUR
                   MOVE    "0004"              TO  SPA-ERRCD
                   GO  TO  4101-KAKUTEI-CHK-EXT
               END-IF
           END-IF  
      *
           .
       4101-KAKUTEI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻るチェック処理
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
                   MOVE    "6666"          TO  SPA-GIDCD
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
      *    戻る処理
      *****************************************************************
       210-BACK-SYORI-SEC              SECTION.
      *
           MOVE    "G01"               TO  SPA-SAKIPG
           MOVE    "G02"               TO  SPA-MOTOPG
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理区分選択処理
      *****************************************************************
       400-DATAKBN-SEC          SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    G02-DATAKBN1  TO  SPA-GMN-DATAKBN1-VALUE
           MOVE    G02-DATAKBN2  TO  SPA-GMN-DATAKBN2-VALUE
           MOVE    G02-DATAKBN3  TO  SPA-GMN-DATAKBN3-VALUE
      *
           MOVE    1             TO  SPA-GMN-CUR     
           .
       400-DATAKBN-EXT.
           EXIT.
      *
      *****************************************************************
      *    作成内容区分選択処理
      *****************************************************************
       400-HOUKATUKBN-SEC          SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    G02-HOUKATUKBN1  TO  SPA-GMN-HOUKATUKBN1-VALUE
           MOVE    G02-HOUKATUKBN2  TO  SPA-GMN-HOUKATUKBN2-VALUE
      *
           MOVE    2             TO  SPA-GMN-CUR     
           .
       400-HOUKATUKBN-EXT.
           EXIT.
      *
      *****************************************************************
      *    個人情報有無選択処理
      *****************************************************************
       400-KOJINKBN-SEC          SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    G02-KOJINKBN1  TO  SPA-GMN-KOJINKBN1-VALUE
           MOVE    G02-KOJINKBN2  TO  SPA-GMN-KOJINKBN2-VALUE
      *
           MOVE    1             TO  SPA-GMN-CUR     
           .
       400-KOJINKBN-EXT.
           EXIT.
      *
      *****************************************************************
      *    文字コード選択処理
      *****************************************************************
       400-CDKBN-SEC             SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    G02-CDKBN1     TO  SPA-GMN-CDKBN1-VALUE
           MOVE    G02-CDKBN2     TO  SPA-GMN-CDKBN2-VALUE
      *
           MOVE    1             TO  SPA-GMN-CUR     
           .
       400-CDKBN-EXT.
           EXIT.
      *
      *****************************************************************
      *    統計データ作成前チェック処理
      *****************************************************************
       450-KAKUTEI-MAE-SEC                SECTION.
      *
      *    入力チェック
           MOVE    1               TO  FLG-TOUROKU
           PERFORM 410-INPUT-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  450-KAKUTEI-MAE-EXT
           END-IF
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
                   MOVE    SPACE             TO  WRK-TOUKEIERR
                   STRING  "月次統計処理中です【"
                                             DELIMITED  BY  SIZE
                           JOB-SHELLMSG      DELIMITED  BY  SPACE
                           "】"              DELIMITED  BY  SIZE      
                                             INTO  WRK-TOUKEIERR
                   END-STRING                          
                   GO  TO  450-KAKUTEI-MAE-EXT
               END-IF
           END-IF    
      *
           MOVE    "1004"              TO  SPA-GIDCD
           .
       450-KAKUTEI-MAE-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新処理
      *****************************************************************
       500-KAKUTEI-SEC                 SECTION.
      *
      *    ジョブ開始セット
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
           MOVE    "TOUKEIER"      TO  TOUKEIERR-FILE-ID
           MOVE    SPA-TERMID      TO  TOUKEIERR-TERMID
      *
      *    医療機関情報の取得
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"          TO  SYS-1001-KANRICD
           MOVE    "*"             TO  SYS-1001-KBNCD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYS-1001-REC    TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI    =   ZERO
               MOVE   MCPDATA-REC  TO  SYS-1001-REC
           ELSE
               MOVE   SPACE        TO  SYS-1001-REC
           END-IF
      *    ファイルデイレクトリ位置指定
           MOVE    "toukei1.sh"    TO  WRK-SHELL-SHELL
           INITIALIZE              ORCSMKPASSAREA
           MOVE    WRK-SHELL-NAME  TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *     
           MOVE    SPA-TERMID      TO  SHELLTBL-ARG1
           MOVE    SPA-HOSPID      TO  SHELLTBL-ARG2
           MOVE     SYS-1001-HOSPCD
                                   TO  SHELLTBL-ARG3
           MOVE    SYS-1001-PREFNUM
                                   TO  SHELLTBL-ARG4
           MOVE    SPA-NAI-SRYYM   TO  SHELLTBL-ARG5
           MOVE    SPA-GMN-NYUGAIKBN 
                                   TO  SHELLTBL-ARG6
           MOVE    SPA-GMN-FILENM1 TO  SHELLTBL-ARG7
           MOVE    SPA-GMN-FILENM2 TO  SHELLTBL-ARG8
           EVALUATE    TRUE
               WHEN    SPA-GMN-DATAKBN1-VALUE  =   "T"
                   MOVE    "0"         TO  SHELLTBL-ARG9
               WHEN    SPA-GMN-DATAKBN2-VALUE  =   "T"
                   MOVE    "1"         TO  SHELLTBL-ARG9
               WHEN    SPA-GMN-DATAKBN3-VALUE  =   "T"
                   MOVE    "2"         TO  SHELLTBL-ARG9
           END-EVALUATE
           EVALUATE    TRUE
               WHEN    SPA-GMN-HOUKATUKBN1-VALUE   =   "T"
                   MOVE    "1"         TO  SHELLTBL-ARG10
               WHEN    SPA-GMN-HOUKATUKBN2-VALUE   =   "T"
                   MOVE    "2"         TO  SHELLTBL-ARG10
           END-EVALUATE
           EVALUATE    TRUE
               WHEN    SPA-GMN-KOJINKBN1-VALUE =   "T"
                   MOVE    "1"         TO  SHELLTBL-ARG11
               WHEN    SPA-GMN-KOJINKBN2-VALUE =   "T"
                   MOVE    "2"         TO  SHELLTBL-ARG11
           END-EVALUATE
           EVALUATE    TRUE
               WHEN    SPA-GMN-CDKBN1-VALUE    =   "T"
                   MOVE    "1"         TO  SHELLTBL-ARG12
               WHEN    SPA-GMN-CDKBN2-VALUE    =   "T"
                   MOVE    "2"         TO  SHELLTBL-ARG12
           END-EVALUATE
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  SHELLTBL-ARG13
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  SHELLTBL-ARG14
           MOVE    TOUKEIERR       TO  SHELLTBL-ARG15
           MOVE    SPA-GMN-FILE1   TO  SHELLTBL-ARG16
           MOVE    SPA-GMN-FILE2   TO  SHELLTBL-ARG17
      *    ipアドレス取得
           MOVE    "DBFETCH"       TO  MCP-FUNC
           MOVE    PATH-METADB-PRIMARY
                                   TO  MCP-PATH
           CALL    "MCPSUB"        USING
                                   MCPAREA
                                   DBMETA
           MOVE    DBMETA-HOST     TO  SHELLTBL-ARG18
      *
           MOVE    SHELLTBL        TO  MCPDATA-REC
           MOVE    "SHELL"         TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL
                                   TO  MCP-PATH
           CALL    "MCPSUB"        USING
                                       MCPAREA
                                       MCPDATA-REC
      *
      *    自動的に情報確認画面を表示
           PERFORM 490-KAKUNIN-SEC      
      *
           .
       500-KAKUTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理確認処理
      *****************************************************************
       490-KAKUNIN-SEC            SECTION.
      *
           MOVE    SPACE               TO  G99
           MOVE    ZERO                TO  G99-COUNT
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
               MOVE    JOB-JOBID       TO  G99-RENNUM   (IDX)
               MOVE    JOB-SHELLMSG    TO  G99-SHORINM  (IDX)
               MOVE    JOB-STARTTIME(1:2)
                                       TO  WRK-HH
               MOVE    JOB-STARTTIME(3:2)
                                       TO  WRK-MM
               MOVE    JOB-STARTTIME(5:2)
                                       TO  WRK-SS
               MOVE    WRK-HENTIME     TO  G99-STARTTIME(IDX)
               MOVE    JOB-ENDTIME(1:2)
                                       TO  WRK-HH
               MOVE    JOB-ENDTIME(3:2)
                                       TO  WRK-MM
               MOVE    JOB-ENDTIME(5:2)
                                       TO  WRK-SS
               MOVE    WRK-HENTIME     TO  G99-ENDTIME  (IDX)
               MOVE    JOB-YOBI        TO  G99-ERRMSG   (IDX)
               IF      JOB-ENDYMD      =   SPACE
                   MOVE    "処理中です"    TO  G99-MSG
               ELSE
                   IF      JOB-ERRCD       =   SPACE
                       CONTINUE
                   ELSE
                       MOVE    SPACE       TO  G99-MSG
                       PERFORM 4901-JOB-ERRSET-SEC
                       IF      G99-MSG     =   SPACE
                           STRING  JOB-YOBI        DELIMITED BY SPACE
                                   "【"            DELIMITED BY SIZE
                                   JOB-SHELLMSG    DELIMITED BY SPACE
                                   "】"            DELIMITED BY SIZE
                                                   INTO  G99-MSG
                           END-STRING   
                       END-IF
                   END-IF                          
               END-IF    
               MOVE    IDX                     TO  G99-COUNT    
           END-IF
      *
           IF      G99-MSG              =   SPACE
               IF      G99-COUNT            >   ZERO    
                   MOVE    "処理は正常に終了しました"
                                                TO  G99-MSG
               ELSE
                   MOVE    "該当する処理はありません"
                                                TO  G99-MSG
               END-IF                                 
               MOVE    "B01"                TO  MCP-WIDGET
           ELSE
               MOVE    "B11"                TO  MCP-WIDGET
           END-IF
      *
           MOVE    "G02"                TO  SPA-MOTOPG
           MOVE    "G99"                TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "G99"                TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
           .
       490-KAKUNIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージセット処理
      *****************************************************************
       4901-JOB-ERRSET-SEC             SECTION.
      *
           EVALUATE    JOB-ERRCD
               WHEN    "0001"
                   MOVE    "【ファイルがありません】" 
                                               TO  G99-MSG
               WHEN    "0002"
                   MOVE    "【ｆｄｄが起動されていません】" 
                                               TO  G99-MSG
               WHEN    "0003"
               WHEN    "0004"
                   MOVE    "【ｆｄｄで処理が失敗しました】" 
                                               TO  G99-MSG
               WHEN    "0011"
                   MOVE    "【媒体がマウントできませんでした】" 
                                               TO  G99-MSG
               WHEN    "0012"
                   MOVE    "【媒体がアンマウントできませんでした】" 
                                               TO  G99-MSG
               WHEN    "0021"
                   MOVE    "【ファイルコピーでエラーが発生しました】" 
                                               TO  G99-MSG
               WHEN    "0127"
                   MOVE    "【スクリプトが実行できませんでした】" 
                                               TO  G99-MSG
           END-EVALUATE
      *
           .
       4901-JOB-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    情報削除画面へ
      *****************************************************************
       490-JYOUHOU-DEL-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-G02             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "G02"               TO  SPA-MOTOPG
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
           IF      SPA-GIDCD       NOT =   SPACE
               PERFORM 520-GIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "G02    "           TO  MCP-WINDOW.
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
           MOVE    SPACE               TO  G02
      *
           MOVE    SPA-GMN-SRYYM       TO  G02-SRYYM
           MOVE    SPA-GMN-FILENM1     TO  G02-FILENM1
           MOVE    SPA-GMN-FILENM2     TO  G02-FILENM2
      *
           MOVE    SPA-GMN-DATAKBN1-VALUE     TO  G02-DATAKBN1
           MOVE    SPA-GMN-DATAKBN2-VALUE     TO  G02-DATAKBN2
           MOVE    SPA-GMN-DATAKBN3-VALUE     TO  G02-DATAKBN3
           MOVE    SPA-GMN-KOJINKBN1-VALUE    TO  G02-KOJINKBN1
           MOVE    SPA-GMN-KOJINKBN2-VALUE    TO  G02-KOJINKBN2
           MOVE    SPA-GMN-HOUKATUKBN1-VALUE  TO  G02-HOUKATUKBN1
           MOVE    SPA-GMN-HOUKATUKBN2-VALUE  TO  G02-HOUKATUKBN2
           MOVE    SPA-GMN-CDKBN1-VALUE       TO  G02-CDKBN1
           MOVE    SPA-GMN-CDKBN2-VALUE       TO  G02-CDKBN2
      *
           MOVE    SPA-GMN-NYUGAIKBN-G     TO  G02-NYUGAIKBN
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-NYUGAIKBN-MAX
               MOVE    SPA-GMN-NYUGAIKBNLST (IDX)
                                           TO  G02-NYUGAIKBN-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-GMN-NYUGAIKBN-MAX   TO  G02-NYUGAIKBN-COUNT
      *
           MOVE    SPA-GMN-FILE1-G     TO  G02-FILE1
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       SPA-GMN-FILE1-MAX
               MOVE    SPA-GMN-FILE1LST (IDX)
                                           TO  G02-FILE1-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-GMN-FILE1-MAX   TO  G02-FILE1-COUNT
      *
           MOVE    SPA-GMN-FILE2-G     TO  G02-FILE2
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       SPA-GMN-FILE2-MAX
               MOVE    SPA-GMN-FILE2LST (IDX)
                                           TO  G02-FILE2-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-GMN-FILE2-MAX TO  G02-FILE2-COUNT
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
           IF    ( SPA-ERRCD           =   SPACE)
             AND ( SPA-GMN-CUR         =   ZERO )
               PERFORM 5011-INPUT-CUR-SEC
           END-IF
      *
         EVALUATE    SPA-GMN-CUR
             WHEN    1
                    MOVE  "SRYYM"      TO  MCP-WIDGET
             WHEN    2
                    MOVE  "NYUGAIKBN"  TO  MCP-WIDGET
             WHEN    3
                    MOVE  "FILE1"      TO  MCP-WIDGET
             WHEN    4
                    MOVE  "FILENM1"    TO  MCP-WIDGET
             WHEN    5
                    MOVE  "FILE2"      TO  MCP-WIDGET
             WHEN    6
                    MOVE  "FILENM2"    TO  MCP-WIDGET
             WHEN    99
                    MOVE  "B12"        TO  MCP-WIDGET
         END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       5011-INPUT-CUR-SEC              SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "SRYYM"
               MOVE    1                   TO  SPA-GMN-CUR
           WHEN    "NYUGAIKBN"
               MOVE    2                   TO  SPA-GMN-CUR
           WHEN    "FILE1"
               MOVE    3                   TO  SPA-GMN-CUR
           WHEN    "FILENM1"
               MOVE    4                   TO  SPA-GMN-CUR
           WHEN    "FILE2"
               MOVE    5                   TO  SPA-GMN-CUR
           WHEN    "FILENM2"
               MOVE    99                  TO  SPA-GMN-CUR
           WHEN    "B12"
               MOVE    99                  TO  SPA-GMN-CUR
           END-EVALUATE
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "FILENM2"
           WHEN    "B12"
               CONTINUE
           WHEN    OTHER
               COMPUTE SPA-GMN-CUR =   SPA-GMN-CUR +   1
           END-EVALUATE
           .
      *
       5011-INPUT-CUR-EXT.
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
                   MOVE    "診療年月入力エラー"        TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "入外区分入力エラー"       TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "（診療）出力ファイル名入力エラー"
                                                       TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "（病名）出力ファイル名入力エラー"
                                                       TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "出力ファイル名に”／”が入力してあります"
                                                       TO  SPA-ERRMSG
               WHEN    "7777"
                   MOVE    WRK-TOUKEIERR               TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  GERR
           MOVE    SPA-ERRCD            TO  GERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  GERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "G02"                TO  SPA-MOTOPG
           MOVE    "GERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "GERR"               TO  MCP-WINDOW
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
      *    ガイドメッセージ表示理
      *****************************************************************
       520-GIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-GIDMSG
      *
           EVALUATE    SPA-GIDCD
               WHEN    "1004"
                   STRING  SPA-NAI-SRYYMH    DELIMITED  BY  SIZE
                           "分統計データ作成処理を行います"
                                             DELIMITED  BY  SIZE 
                                             INTO  WRK-GIDMSG
                   END-STRING
               WHEN    "2001"
                   MOVE    "媒体をドライブにセットして下さい"
                                       TO  WRK-GIDMSG
               WHEN    "6666"
                   MOVE    "統計データ作成中です"
                                       TO  WRK-GIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  GID1
           MOVE    SPA-GIDCD            TO  GID1-ID1CODE
           MOVE    WRK-GIDMSG           TO  GID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "G02"                TO  SPA-MOTOPG
           MOVE    "GID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "GID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-GIDSET-EXT.
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
