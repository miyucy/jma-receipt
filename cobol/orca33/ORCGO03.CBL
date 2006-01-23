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
       PROGRAM-ID.             ORCGO03.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院業務
      *  コンポーネント名  : 定期請求作成−印刷指示（Ｏ０３）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/08/21    ひさなが      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-太田    03.07.01  出力先プリンタサブ追加
      *  01.00.01    NACL-太田    03.07.10  印刷処理時処理確認画面へ遷移
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
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    帳票出力用パラメタ
       01  WRK-PARA-AREA.
           03  WRK-PARA-PRTJYUN    PIC X(02).
           03  WRK-PARA-BTUNUM-MAX PIC 9(04).
           03  WRK-PARA-BTUNUM-TBL.
               05  WRK-PARA-BTUNUM-OCC OCCURS  50.
                   07  WRK-PARA-BTUNUM PIC X(02).
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    定期請求作成指示共通パラメタ
           COPY    "O01COMMON-SPA".
      *
      *    定期請求共通ＳＰＡ
           COPY    "O01SCR-SPA".
      *   
           COPY    "ENUM-VALUE".
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-TEIKIKANRI      PIC 9(01).
           03  FLG-TEIKIPRT        PIC 9(01).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-TEIKIERR        PIC X(02).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDX3                PIC 9(04).
           03  IDX4                PIC 9(04).
           03  IDX5                PIC 9(04).
           03  IDX-CMB             PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-WIDGET.
               05  WRK-WIDGET1     PIC X(03).
               05  WRK-WIDGET2     PIC 9(02).
               05  FILLER          PIC X(01).
               05  WRK-WIDGET3     PIC 9(02). 
           03  WRK-OIDMSG          PIC X(70).
           03  WRK-Z9              PIC ZZZ9.
           03  WRK-YM              PIC X(07). 
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-TEIKIERR        PIC X(200).
           03  WRK-HENFLG          PIC 9(01).
      *     
           03  WRK-JYUNI           PIC 9(02).
           03  WRK-CNT             PIC 9(05).
           03  WRK-CMB-CD          PIC X(10).
           03  WRK-CMB-ITM-G.
               05  WRK-CMB-ITM     PIC X(200).
           03  WRK-MCP-WIDGET      PIC X(64).
      *
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMDG1        PIC X(09).
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
       01  WRK-CONS-AREA.
      *    １頁の最大行数
           03  WRK-CONS-LINE-MAX   PIC 9(02)   VALUE   36.   
      *    ジョブ管理ＤＢのキー値  
           03  WRK-CONS-JOB-SHELLID
                                   PIC X(08)   VALUE   "TEIKI2".
           03  WRK-CONS-JOB-JOBID  PIC 9(07)   VALUE   1.
      *
           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".         
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK5000.INC".
      *
           COPY    "CPSK5001.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    定期請求管理
       01  TEIKIKANRI-REC.
           COPY    "CPTEIKIKANRI.INC".
      *
      *    定期請求管理
       01  TEIKIPRT-REC.
           COPY    "CPTEIKIPRT.INC".
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    半角チェックサブ
           COPY    "CPORCSKANACHK.INC".
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
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
           COPY    "O04.INC".
           COPY    "O05.INC".
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
           MOVE    SPA-FREE        TO  SPA-O01FREE
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
           MOVE    SPA-O01FREE     TO  SPA-FREE
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
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
      ***  MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "O03    "           TO  MCP-WINDOW.
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
           MOVE    1               TO  SPA-GMN-O03-CUR
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
      *
      *        元の画面へ戻す
               IF      SPA-MOTOPG      =   "XB01"
                   MOVE    LNK-COMMON      TO  SPA-KYOUTU
                   MOVE    SPA-WORK        TO  SPA-O01KYOUTU
                   MOVE    LNK-SCRSPA      TO  SPA-O01FREE
                   GO  TO  300-SCREEN-EXT
               END-IF
      *         
               MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
           END-IF
      *
           EVALUATE    SPA-MOTOPG
           WHEN    "O04"
           WHEN    "O99"
               GO  TO      300-SCREEN-EXT
      *    作表処理
           WHEN    "OID1"
               PERFORM 330-OID1-SET-SEC
               GO  TO      300-SCREEN-EXT
           WHEN    "OID2"
               PERFORM 340-OID2-SET-SEC
               GO  TO      300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM 310-SPASET-SEC
      *
      *****MOVE    1               TO  SPA-GMN-O03-PAGE
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
           INITIALIZE              SPA-O03-AREA
      *
           PERFORM 900-TEIKIKANRI-READ-SEC
      *
      *    処理区分
           MOVE    "T"             TO  SPA-GMN-O03-SYOKBN
      *
      *    ファイル作成区分
           EVALUATE    TEIKIKANRI-SYOKBN
               WHEN    "1"
                   MOVE    SPACE               TO  WRK-SYMD
                   MOVE    TEIKIKANRI-SRYYM    TO  WRK-SYMD (1 : 6)
                   MOVE    "01"                TO  WRK-SYMD (7 : 2)
                   PERFORM 5002-HIZUKE-HEN-SEC
                   STRING  WRK-HENYMDG3(1:16) DELIMITED  BY  SIZE
                           "一括作成分"       DELIMITED  BY  SIZE
                           INTO    SPA-GMN-O03-FILEKBN
                   END-STRING
               WHEN    "2"
                   MOVE    "個別作成分"    TO  SPA-GMN-O03-FILEKBN
           END-EVALUATE
      *
      *    ファイル作成日
           MOVE    TEIKIKANRI-CREYMD   TO  WRK-SYMD
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG3        TO  SPA-GMN-O03-CREYMD
      *
      *    請求書発行区分
           MOVE    "1"               TO  SPA-GMN-O03-SKYPRTKBNL    (1)
           MOVE    "すべて発行"
                                     TO  SPA-GMN-O03-SKYPRTKBNMEIL (1)
           MOVE    "2"               TO  SPA-GMN-O03-SKYPRTKBNL    (2)
           MOVE    "請求があるもののみ"
                                     TO  SPA-GMN-O03-SKYPRTKBNMEIL (2)
      *
           MOVE    2                 TO  SPA-GMN-O03-SKYPRTKBN-MAX
      *
           MOVE    SPA-GMN-O03-SKYPRTKBNLST(01)
                                     TO  SPA-GMN-O03-SKYPRTKBN-G
      *
      *    印刷順
           MOVE    "01"                  TO  SPA-GMN-O03-PRTJYUNL    (1)
           MOVE    "病棟番号・カナ氏名順"
                                         TO  SPA-GMN-O03-PRTJYUNMEIL (1)
           MOVE    "02"                  TO  SPA-GMN-O03-PRTJYUNL    (2)
           MOVE    "病棟番号・患者番号順"
                                         TO  SPA-GMN-O03-PRTJYUNMEIL (2)
           MOVE    "03"                  TO  SPA-GMN-O03-PRTJYUNL    (3)
           MOVE    "カナ氏名順"          TO  SPA-GMN-O03-PRTJYUNMEIL (3)
           MOVE    "04"                  TO  SPA-GMN-O03-PRTJYUNL    (4)
           MOVE    "患者番号順"          TO  SPA-GMN-O03-PRTJYUNMEIL (4)
      *
           MOVE    SPA-GMN-O03-PRTJYUNLST(01)
                                         TO  SPA-GMN-O03-PRTJYUN-G
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
           INITIALIZE                  SYS-5000-REC
           MOVE    "5000"          TO  SYS-5000-KANRICD
           MOVE    "*"             TO  SYS-5000-KBNCD
           MOVE    SYS-5000-REC    TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           MOVE    MCPDATA-REC     TO  SYS-5000-REC
      *
           MOVE    SYS-5000-SKYPRTKBN
                                   TO  WRK-CMB-CD
           PERFORM 4200-SKYPRTKBNLST-CHK-SEC
           IF    ( WRK-CMB-ITM NOT =   SPACE )
               MOVE    WRK-CMB-ITM TO   SPA-GMN-O03-SKYPRTKBN-G
           END-IF
      *
           IF    ( SPA-GMN-O03-PRTJYUN     =   "01"    OR  "02" )
               PERFORM 3101-PAGE-HENSYU-01-SEC
           ELSE
               PERFORM 3101-PAGE-HENSYU-02-SEC
           END-IF    
      *
           MOVE    199             TO  SPA-GMN-O03-CUR
      *
           MOVE    1               TO  SPA-GMN-O03-PAGE
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    頁・件数の編集処理（レセプト種別）
      *****************************************************************
       3101-PAGE-HENSYU-01-SEC            SECTION.
      *
      *    処理区分
           MOVE    "T"                 TO  SPA-GMN-O03-SYOKBN
      *
           INITIALIZE                  SPA-GMN-O03-TBL
                                       SPA-GMN-O03-TBL1
                                       SPA-NAI-O03-TBL   
           MOVE    ZERO                TO  SPA-GMN-O03-PAGEH
                                           SPA-GMN-O03-KENSUH
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >       2 )
               PERFORM VARYING IDX2    FROM    1   BY  1
                       UNTIL ( IDX2    >   WRK-CONS-LINE-MAX )
                   MOVE    "F" TO  SPA-GMN-O03-TCHK-VALUE (IDX1 IDX2)
               END-PERFORM
           END-PERFORM
      *
           MOVE    SPACE               TO  SYS-5001-KEY
           MOVE    "5001"              TO  SYS-5001-KANRICD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
      *
           MOVE    SYS-5001-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF    ( MCP-RC              =   ZERO )
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               INITIALIZE                  SYS-5001-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    1                   TO  IDX1
           MOVE    ZERO                TO  IDX2
      *
           PERFORM    UNTIL      ( FLG-SYSKANRI    =   1 )
                      OR         ( IDX1            >   2 )
      *
               COMPUTE IDX2    =   IDX2    +   1
      *
               MOVE    MCPDATA-REC   TO  SYS-5001-REC
      *
               COMPUTE WRK-JYUNI   = ( IDX1 - 1 ) * WRK-CONS-LINE-MAX
                                   +   IDX2
      *
               MOVE    WRK-JYUNI TO  SPA-NAI-O03-PRTJYUNI (IDX1 IDX2)
               MOVE    SYS-5001-BTU-NUM
                                 TO  SPA-NAI-O03-BTUNUM   (IDX1 IDX2)
      *
               MOVE    SYS-5001-BTU-NAME
                                 TO  SPA-GMN-O03-TSYURUINAME (IDX1 IDX2)
               MOVE    "T"       TO  SPA-GMN-O03-TCHK-VALUE  (IDX1 IDX2)
      *
               MOVE    "SYSKANRI-KEY2"       TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
      *
               IF    ( IDX2    >=  WRK-CONS-LINE-MAX )
                   COMPUTE IDX1    =   IDX1    +   1
                   MOVE    ZERO    TO  IDX2
               END-IF
      *
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    ページ・件数を定期請求管理情報より取得
           MOVE    SPACE               TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TEIKIKANRI-ALL"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF    ( MCP-RC              =   ZERO )
               MOVE    "TEIKIKANRI-ALL"    TO  ORC-DBPATH
               PERFORM 900-TEIKIKANRI-NEXT-SEC
           ELSE
               INITIALIZE                  TEIKIKANRI-REC
               MOVE    1               TO  FLG-TEIKIKANRI
           END-IF
      *
           PERFORM UNTIL ( FLG-TEIKIKANRI  NOT =   ZERO )
      *
               COMPUTE SPA-GMN-O03-PAGEH
                   =   SPA-GMN-O03-PAGEH   +   TEIKIKANRI-PAGE
               COMPUTE SPA-GMN-O03-KENSUH
                   =   SPA-GMN-O03-KENSUH  +   TEIKIKANRI-KENSU
      *
               PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   2 )
                   PERFORM VARYING IDX2    FROM    1   BY  1
                           UNTIL ( IDX2    >   WRK-CONS-LINE-MAX )
                       IF    ( TEIKIKANRI-BTUNUM
                                   =   SPA-NAI-O03-BTUNUM   (IDX1 IDX2))
                           MOVE    TEIKIKANRI-PAGE
                                   TO  SPA-GMN-O03-TPAGE (IDX1 IDX2)
                           MOVE    TEIKIKANRI-KENSU
                                   TO  SPA-GMN-O03-TKENSU (IDX1 IDX2)
                           MOVE    2                   TO  IDX1
                           MOVE    WRK-CONS-LINE-MAX   TO  IDX2
                       END-IF
                   END-PERFORM
               END-PERFORM
      *
               MOVE    "TEIKIKANRI-ALL"    TO  ORC-DBPATH
               PERFORM 900-TEIKIKANRI-NEXT-SEC
      *
           END-PERFORM
      *
      *    カーソルクロース
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           MOVE    "TEIKIKANRI-ALL"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       3101-PAGE-HENSYU-01-EXT.
           EXIT.
      *
      *****************************************************************
      *    頁・件数の編集処理（カナ氏名・患者番号）
      *****************************************************************
       3101-PAGE-HENSYU-02-SEC            SECTION.
      *
      *    処理区分
           MOVE    "T"                 TO  SPA-GMN-O03-SYOKBN
      *
           INITIALIZE                  SPA-GMN-O03-TBL
                                       SPA-GMN-O03-TBL1
                                       SPA-NAI-O03-TBL   
           MOVE    ZERO                TO  SPA-GMN-O03-PAGEH
                                           SPA-GMN-O03-KENSUH
      *
           PERFORM VARYING IDX1 FROM    1   BY  1
                   UNTIL ( IDX1 >       2 )
               PERFORM VARYING IDX2    FROM    1   BY  1
                       UNTIL ( IDX2    >   WRK-CONS-LINE-MAX )
                   MOVE    "F" TO  SPA-GMN-O03-TCHK-VALUE (IDX1 IDX2)
               END-PERFORM
           END-PERFORM
      *
      *
           EVALUATE    SPA-GMN-O03-PRTJYUN
           WHEN    "03"
               MOVE    "01"            TO  SPA-NAI-O03-PRTJYUNI    (1 1)
               MOVE    "カナ氏名"      TO  SPA-GMN-O03-TSYURUINAME (1 1)
               MOVE    "T"             TO  SPA-GMN-O03-TCHK-VALUE  (1 1)
           WHEN    "04"
               MOVE    "01"            TO  SPA-NAI-O03-PRTJYUNI    (1 1)
               MOVE    "患者番号"      TO  SPA-GMN-O03-TSYURUINAME (1 1)
               MOVE    "T"             TO  SPA-GMN-O03-TCHK-VALUE  (1 1)
           END-EVALUATE
      *
      *
      *    ページ・件数を定期請求管理情報より取得
           MOVE    SPACE               TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TEIKIKANRI-ALL"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF    ( MCP-RC               =   ZERO )
               MOVE    "TEIKIKANRI-ALL" TO  ORC-DBPATH
               PERFORM 900-TEIKIKANRI-NEXT-SEC
           ELSE
               INITIALIZE                  TEIKIKANRI-REC
               MOVE    1               TO  FLG-TEIKIKANRI
           END-IF
      *
           PERFORM UNTIL ( FLG-TEIKIKANRI  NOT =   ZERO )
      *
               COMPUTE SPA-GMN-O03-PAGEH
                   =   SPA-GMN-O03-PAGEH   +   TEIKIKANRI-PAGE
               COMPUTE SPA-GMN-O03-KENSUH
                   =   SPA-GMN-O03-KENSUH  +   TEIKIKANRI-KENSU
      *
               COMPUTE SPA-GMN-O03-TPAGE (1 1)
                   =   SPA-GMN-O03-TPAGE (1 1)     +   TEIKIKANRI-PAGE
               COMPUTE SPA-GMN-O03-TKENSU (1 1)
                   =   SPA-GMN-O03-TKENSU (1 1)    +   TEIKIKANRI-KENSU
      *
               MOVE    "TEIKIKANRI-ALL" TO  ORC-DBPATH
               PERFORM 900-TEIKIKANRI-NEXT-SEC
      *
           END-PERFORM
      *
      *    カーソルクロース
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           MOVE    "TEIKIKANRI-ALL"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           MOVE    1               TO  SPA-GMN-O03-PAGE
           .
       3101-PAGE-HENSYU-02-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-OID1-SET-SEC            SECTION.
      *
           IF      SPA-OID1-FLG    =   "OK"
               EVALUATE    SPA-OIDCD
                   WHEN    "6666"
                       MOVE    "JOIN"           TO  MCP-PUTTYPE
                       PERFORM 210-BACK-SYORI-SEC
                   WHEN    "1001"
                   WHEN    "1002"
                       PERFORM 450-PRINT-SEC
                   WHEN    "8888"
                       CONTINUE    
               END-EVALUATE        
           END-IF
      *
           MOVE    SPACE           TO  SPA-OID1-FLG
           MOVE    SPACE           TO  SPA-OIDCD
           .
       330-OID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ２）ＯＫ処理
      *****************************************************************
       340-OID2-SET-SEC            SECTION.
      *
           MOVE    SPACE           TO  SPA-OID1-FLG
                                       SPA-O99-FLG
           MOVE    SPACE           TO  SPA-OIDCD
           MOVE    SPACE           TO  SPA-OIDCD2      
           .
       340-OID2-SET-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           MOVE    MCP-WIDGET      TO  WRK-MCP-WIDGET
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE    "CHANGE"            TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *        前頁
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 460-MAEGMN-SEC
      *        次頁
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 470-ATOGMN-SEC
      *     処理区分
               WHEN    "CLICKED"       ALSO    "B08"
               WHEN    "CLICKED"       ALSO    "SYOKBN"
                   PERFORM 410-SYOKBN-CHK-SEC
      *     請求確認画面へ
               WHEN    "CLICKED"       ALSO    "B09"
                   PERFORM 490-O04-SENI-SEC
      *     情報削除
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 490-JYOUHOU-DEL-SEC
      *     印刷
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 450-PRINT-GIDMSG-SEC
      *     処理確認
               WHEN    "CLICKED"       ALSO    "B13"
                   PERFORM 490-KAKUNIN-SEC
      *     個別出力
               WHEN    "CLICKED"       ALSO    "CHK01"
               WHEN    "CLICKED"       ALSO    "CHK02"
               WHEN    "CLICKED"       ALSO    "CHK03"
               WHEN    "CLICKED"       ALSO    "CHK04"
               WHEN    "CLICKED"       ALSO    "CHK05"
               WHEN    "CLICKED"       ALSO    "CHK06"
               WHEN    "CLICKED"       ALSO    "CHK07"
               WHEN    "CLICKED"       ALSO    "CHK08"
               WHEN    "CLICKED"       ALSO    "CHK09"
               WHEN    "CLICKED"       ALSO    "CHK10"
               WHEN    "CLICKED"       ALSO    "CHK11"
               WHEN    "CLICKED"       ALSO    "CHK12"
               WHEN    "CLICKED"       ALSO    "CHK13"
               WHEN    "CLICKED"       ALSO    "CHK14"
               WHEN    "CLICKED"       ALSO    "CHK15"
               WHEN    "CLICKED"       ALSO    "CHK16"
               WHEN    "CLICKED"       ALSO    "CHK17"
               WHEN    "CLICKED"       ALSO    "CHK18"
               WHEN    "CLICKED"       ALSO    "CHK19"
               WHEN    "CLICKED"       ALSO    "CHK20"
               WHEN    "CLICKED"       ALSO    "CHK21"
               WHEN    "CLICKED"       ALSO    "CHK22"
               WHEN    "CLICKED"       ALSO    "CHK23"
               WHEN    "CLICKED"       ALSO    "CHK24"
               WHEN    "CLICKED"       ALSO    "CHK25"
               WHEN    "CLICKED"       ALSO    "CHK26"
               WHEN    "CLICKED"       ALSO    "CHK27"
               WHEN    "CLICKED"       ALSO    "CHK28"
               WHEN    "CLICKED"       ALSO    "CHK29"
               WHEN    "CLICKED"       ALSO    "CHK30"
               WHEN    "CLICKED"       ALSO    "CHK31"
               WHEN    "CLICKED"       ALSO    "CHK32"
               WHEN    "CLICKED"       ALSO    "CHK33"
               WHEN    "CLICKED"       ALSO    "CHK34"
               WHEN    "CLICKED"       ALSO    "CHK35"
               WHEN    "CLICKED"       ALSO    "CHK36"
                   MOVE    MCP-WIDGET          TO  WRK-WIDGET
                   MOVE    WRK-WIDGET2         TO  IDX2
                   PERFORM 420-CHK-CHK-SEC
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
           MOVE    MCP-WIDGET      TO  WRK-MCP-WIDGET
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
           WHEN    "ACTIVATE"      ALSO    "PRTJYUN"
               PERFORM 4105-PRTJYUN-CHK-SEC
           WHEN    OTHER
      *        入力チェック処理
               PERFORM 410-INPUT-CHK-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC          SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
      *    基本チェック処理
           PERFORM 4102-KIHON-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  410-INPUT-CHK-EXT
           END-IF
      *
           .
      *
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ＳＰＡ編集処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC            SECTION.
      *
      *    請求書発行区分
           MOVE    O03-SKYPRTKBN   TO  SPA-GMN-O03-SKYPRTKBN-G
      *
           .
      *
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC              SECTION.
      *
      *    請求書発行区分チェック
           PERFORM 4105-SKYPRTKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
           .
      *
       4102-KIHON-CHK-EXT.
           EXIT.
      *****************************************************************
      *    請求書発行区分チェック
      *****************************************************************
       4105-SKYPRTKBN-CHK-SEC          SECTION.
      *
           MOVE    SPA-GMN-O03-SKYPRTKBN   TO  WRK-CMB-CD
           PERFORM 4200-SKYPRTKBNLST-CHK-SEC
           IF    ( WRK-CMB-ITM     NOT =   SPACE )
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-O03-SKYPRTKBN-G
           ELSE
               MOVE    SPA-GMN-O03-SKYPRTKBNLST (1)
                                       TO  SPA-GMN-O03-SKYPRTKBN-G
           END-IF
      *
           .
       4105-SKYPRTKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    印刷順入力処理
      *****************************************************************
       4105-PRTJYUN-CHK-SEC             SECTION.
      *
           MOVE    3                   TO  SPA-GMN-O03-CUR
      *
           MOVE    O03-PRTJYUN         TO  SPA-GMN-O03-PRTJYUN-G
      *
           IF    ( SPA-GMN-O03-PRTJYUNMEI  =   SPACE )
               MOVE    "0001"              TO  SPA-ERRCD
           ELSE
               MOVE    ZERO                TO  WRK-HENFLG
               PERFORM VARYING IDX1    FROM    1   BY  1
                     UNTIL   ( IDX1  >   5 )
                     OR      ( SPA-GMN-O03-PRTJYUNLST  (IDX1)
                                           =   SPACE )
                   IF    ( SPA-GMN-O03-PRTJYUN
                                     =   SPA-GMN-O03-PRTJYUNL (IDX1) )
                       MOVE    1           TO  WRK-HENFLG
                       MOVE    5           TO  IDX1
                   END-IF
               END-PERFORM
           END-IF
      *
           IF    ( WRK-HENFLG          =   ZERO )
               MOVE    "0001"              TO  SPA-ERRCD
           END-IF
      *
           IF    ( SPA-ERRCD           =   SPACE )
               IF    ( SPA-GMN-O03-PRTJYUN =   "01"    OR  "02" )
                   PERFORM 3101-PAGE-HENSYU-01-SEC
               ELSE
                   PERFORM 3101-PAGE-HENSYU-02-SEC
               END-IF
           END-IF
           .
       4105-PRTJYUN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求書発行区分コンボチェック
      *****************************************************************
       4200-SKYPRTKBNLST-CHK-SEC       SECTION.
      *
           MOVE    SPACE               TO  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
               UNTIL ( IDX-CMB     >   SPA-GMN-O03-SKYPRTKBN-MAX )
                OR   ( WRK-CMB-CD  =   SPA-GMN-O03-SKYPRTKBNL (IDX-CMB))
      *
               CONTINUE
      *
           END-PERFORM
      *
           IF    ( IDX-CMB     <=  SPA-GMN-O03-SKYPRTKBN-MAX )
               MOVE    SPA-GMN-O03-SKYPRTKBNLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
           END-IF
      *
           .
       4200-SKYPRTKBNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    戻る前処理
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
           IF    ( SJOBKANRI-RETURN
                                   =   ZERO )
               IF    ( JOB-ENDYMD      =   SPACE )
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
           MOVE    "O01"               TO  SPA-SAKIPG
           MOVE    "O03"               TO  SPA-MOTOPG
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
      *    処理区分  入力処理
      *****************************************************************
       410-SYOKBN-CHK-SEC                SECTION.
      *   
           MOVE    1                   TO  SPA-GMN-O03-CUR
      *
           EVALUATE    SPA-GMN-O03-SYOKBN
      *    *指定印刷
           WHEN    "T"
               MOVE    "F"             TO  SPA-GMN-O03-SYOKBN
               MOVE    4               TO  SPA-GMN-O03-CUR
               PERFORM VARYING IDX1    FROM    1   BY  1
                       UNTIL ( IDX1    >       2 )
                   PERFORM VARYING IDX2  FROM    1   BY  1
                           UNTIL ( IDX2  >       WRK-CONS-LINE-MAX )
                           OR    ( SPA-NAI-O03-PRTJYUNI (IDX1 IDX2)
                                           =   SPACE )
                       MOVE    "F"
                               TO  SPA-GMN-O03-TCHK-VALUE (IDX1 IDX2)
                   END-PERFORM
               END-PERFORM
      *
      *    *全件印刷
           WHEN    "F"
               MOVE    "T"             TO  SPA-GMN-O03-SYOKBN
               MOVE    199             TO  SPA-GMN-O03-CUR
               INITIALIZE                  SPA-GMN-O03-TBL
               PERFORM VARYING IDX1    FROM    1   BY  1
                       UNTIL ( IDX1    >   2 )
                   PERFORM VARYING IDX2    FROM    1   BY  1
                           UNTIL ( IDX2    >   WRK-CONS-LINE-MAX )
                       MOVE    "F" 
                           TO  SPA-GMN-O03-TCHK-VALUE (IDX1 IDX2)
                   END-PERFORM
               END-PERFORM
      *
               PERFORM VARYING IDX1    FROM    1   BY  1
                       UNTIL ( IDX1    >       2 )
                   PERFORM VARYING IDX2  FROM    1   BY  1
                           UNTIL ( IDX2  >       WRK-CONS-LINE-MAX )
                           OR    ( SPA-NAI-O03-PRTJYUNI (IDX1 IDX2)
                                           =   SPACE )
                       MOVE    "T"
                               TO  SPA-GMN-O03-TCHK-VALUE (IDX1 IDX2)
                   END-PERFORM
               END-PERFORM
           END-EVALUATE 
      *
           .
       410-SYOKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    個別出力  入力処理
      *****************************************************************
       420-CHK-CHK-SEC                 SECTION.
      *
           IF    ( SPA-GMN-O03-SYOKBN      =   "T" )
               MOVE    "0006"          TO  SPA-ERRCD
               MOVE    2               TO  SPA-GMN-O03-CUR
               GO  TO  420-CHK-CHK-EXT
           END-IF
      *
           MOVE    1                   TO  SPA-GMN-O03-CUR
      *
           COMPUTE SPA-GMN-O03-CUR         =   SPA-GMN-O03-CUR +
                                           IDX2 *  3
      *
           MOVE    SPA-GMN-O03-PAGE        TO  IDX1
      *
           IF    ( O03-TCHK-VALUE (IDX2)   =   "T" )
           AND   ( SPA-GMN-O03-TPAGE  (IDX1 IDX2)
                                       =   ZERO )
               MOVE    "0002"          TO  SPA-ERRCD
           ELSE
               MOVE    O03-TCHK-VALUE (IDX2)
                               TO  SPA-GMN-O03-TCHK-VALUE (IDX1 IDX2)
           END-IF
      *
           ADD     1                   TO  SPA-GMN-O03-CUR
      *
           .
       420-CHK-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    出力前処理
      *****************************************************************
       450-PRINT-GIDMSG-SEC                SECTION.
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
               IF    ( JOB-ENDYMD      =   SPACE )
                   MOVE    "7777"          TO  SPA-ERRCD
                   GO  TO  450-PRINT-GIDMSG-EXT
               END-IF
           END-IF
      *
      *    請求データが選択されているか
           MOVE    ZERO                TO  IDX3
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   2 )
               PERFORM VARYING IDX2    FROM    1   BY  1
                     UNTIL ( IDX2  >   WRK-CONS-LINE-MAX )
                   IF    ( SPA-GMN-O03-TCHK-VALUE (IDX1 IDX2)  =   "T" )
                       MOVE    1                   TO  IDX3
                       MOVE    WRK-CONS-LINE-MAX   TO  IDX2
                   END-IF
               END-PERFORM
           END-PERFORM
           IF  (   IDX3                =   ZERO )
               MOVE    "0008"          TO  SPA-ERRCD
               GO  TO  450-PRINT-GIDMSG-EXT
           END-IF
      *
      *    ガイドメッセージセット
           EVALUATE    SPA-GMN-O03-SYOKBN
               WHEN    "T"
                   MOVE    "1001"              TO  SPA-OIDCD
               WHEN    "F"
                   MOVE    "1002"              TO  SPA-OIDCD
           END-EVALUATE
      *
           .
       450-PRINT-GIDMSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    出力処理
      *****************************************************************
       450-PRINT-SEC                SECTION.
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
      *    帳票ファイル作成処理
           PERFORM 4501-PRTJYUN-PRINT-SEC
      *
           MOVE    "TEIKIERR"      TO  TEIKIERR-FILE-ID
           MOVE    SPA-TERMID      TO  TEIKIERR-TERMID
      *
           MOVE    SPACE           TO  SHELLTBL
           MOVE    "teiki2.sh"     TO  WRK-SHELL-SHELL
      *    ファイルデイレクトリ位置指定
           INITIALIZE              ORCSMKPASSAREA
           MOVE    WRK-SHELL-NAME  TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *
           MOVE    WRK-PARA-PRTJYUN
                                   TO  SHELLTBL-ARG1
           MOVE    WRK-PARA-BTUNUM-MAX
                                   TO  SHELLTBL-ARG2
           MOVE    WRK-PARA-BTUNUM-TBL
                                   TO  SHELLTBL-ARG3
           MOVE    SPA-SYSYMD      TO  SHELLTBL-ARG4
           MOVE    SPA-TERMID      TO  SHELLTBL-ARG5
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  SHELLTBL-ARG6
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  SHELLTBL-ARG7
           MOVE    SPA-HOSPID      TO  SHELLTBL-ARG8
           MOVE    SPA-STAFFCD     TO  SHELLTBL-ARG9
           MOVE    TEIKIERR
                                   TO  SHELLTBL-ARG10
           MOVE    SPA-GMN-O03-SKYPRTKBN
                                   TO  SHELLTBL-ARG11
      *
           MOVE    SHELLTBL        TO  MCPDATA-REC
           MOVE    "SHELL"         TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL
                                   TO  MCP-PATH
           CALL    "MCPSUB"        USING
                                   MCPAREA
                                   MCPDATA-REC
      *
           PERFORM 490-KAKUNIN-SEC
      *
           .
       450-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷順出力処理
      *****************************************************************
       4501-PRTJYUN-PRINT-SEC         SECTION.
      *
      *    印刷用パラメタ
           INITIALIZE                      WRK-PARA-AREA
      *
           MOVE    SPA-GMN-O03-PRTJYUN     TO  WRK-PARA-PRTJYUN
      *
           MOVE    ZERO                TO  WRK-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   2 )
               PERFORM VARYING IDX2    FROM    1   BY  1
                       UNTIL ( IDX2    >   WRK-CONS-LINE-MAX )
                   IF    ( SPA-GMN-O03-TCHK-VALUE (IDX1 IDX2)
                                   =   "T" )
                     AND ( SPA-GMN-O03-TKENSU  (IDX1 IDX2) > ZERO )
                       COMPUTE WRK-CNT =   WRK-CNT +   1
                       MOVE    SPA-NAI-O03-BTUNUM (IDX1 IDX2)
                                       TO  WRK-PARA-BTUNUM (WRK-CNT)
                       MOVE    WRK-CNT TO  WRK-PARA-BTUNUM-MAX
                   END-IF
               END-PERFORM
           END-PERFORM
           .
       4501-PRTJYUN-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    前頁　処理
      *****************************************************************
       460-MAEGMN-SEC             SECTION.
      *
           IF      SPA-GMN-O03-PAGE       =   1
               MOVE    "0009"             TO  SPA-ERRCD
               GO  TO  460-MAEGMN-EXT
           END-IF
           COMPUTE SPA-GMN-O03-PAGE   =   SPA-GMN-O03-PAGE    -   1
      *
           MOVE    199                  TO  SPA-GMN-O03-CUR
           .
       460-MAEGMN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    次頁　処理
      *****************************************************************
       470-ATOGMN-SEC                    SECTION.
      *
           IF    ( SPA-NAI-O03-BTUNUM (2 1)   NOT =   SPACE )
               IF    ( SPA-GMN-O03-PAGE       =   2 )
                   MOVE    "0010"      TO  SPA-ERRCD
                   GO  TO  470-ATOGMN-EXT
               END-IF
           ELSE
                   MOVE    "0010"      TO  SPA-ERRCD
                   GO  TO  470-ATOGMN-EXT
           END-IF
      *
      *
           COMPUTE SPA-GMN-O03-PAGE    =   SPA-GMN-O03-PAGE    +   1
      *
      *
           MOVE    199                 TO  SPA-GMN-O03-CUR
           .
       470-ATOGMN-EXT.
           EXIT.
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
               IF    ( JOB-ENDYMD      =   SPACE )
                   MOVE    "処理中です"    TO  O99-MSG
               ELSE
                   IF    ( JOB-ERRCD       =   SPACE )
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
               IF    ( O99-COUNT            >   ZERO )
                   MOVE    "B01"                TO  MCP-WIDGET
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
           MOVE    "O03"                TO  SPA-MOTOPG
           MOVE    "O99"                TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "O99"                TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
      *
           .
       490-KAKUNIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求確認画面遷移処理
      *****************************************************************
       490-O04-SENI-SEC                SECTION.
      *
           MOVE    "O04"               TO  SPA-SAKIPG
           MOVE    "O03"               TO  SPA-MOTOPG
           MOVE    "O03"               TO  SPA-O01-MOTOPG
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           MOVE   SPA-SAKIPG           TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       490-O04-SENI-EXT.
           EXIT.
      *****************************************************************
      *    情報削除画面へ
      *****************************************************************
       490-JYOUHOU-DEL-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-O01FREE         TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "O03"               TO  SPA-MOTOPG
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
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "O03    "           TO  MCP-WINDOW.
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
           INITIALIZE     O03
      *
           MOVE    SPA-GMN-O03-SYOKBN         TO  O03-SYOKBN-VALUE
           EVALUATE    SPA-GMN-O03-SYOKBN
               WHEN    "T"
                   MOVE    "全件印刷"         TO  O03-SYOKBN-LABEL
               WHEN    "F"
                   MOVE    "指定印刷"         TO  O03-SYOKBN-LABEL
           END-EVALUATE      
      *
           MOVE    SPA-GMN-O03-FILEKBN     TO  O03-FILEKBN
      *
           MOVE    SPA-GMN-O03-CREYMD      TO  O03-CREYMD
      *
           MOVE    SPA-GMN-O03-PAGEH       TO  O03-PAGE
      *
           MOVE    SPA-GMN-O03-KENSUH      TO  O03-KENSU
      *
           MOVE    SPA-GMN-O03-SKYPRTKBN-G   TO  O03-SKYPRTKBN
           PERFORM VARYING IDX1    FROM    1       BY  1
                   UNTIL ( IDX1            >   5 )
                   OR    ( SPA-GMN-O03-SKYPRTKBNL    (IDX1)  =   SPACE )
               MOVE    SPA-GMN-O03-SKYPRTKBNLST(IDX1)
                                   TO  O03-SKYPRTKBNLST (IDX1)
               MOVE    IDX1        TO  O03-SKYPRTKBN-COUNT
           END-PERFORM
      *
           MOVE    SPA-GMN-O03-PRTJYUN-G   TO  O03-PRTJYUN
           PERFORM VARYING IDX1    FROM    1       BY  1
                   UNTIL ( IDX1            >   5 )
                   OR    ( SPA-GMN-O03-PRTJYUNL    (IDX1)  =   SPACE )
               MOVE    SPA-GMN-O03-PRTJYUNLST(IDX1)
                                   TO  O03-PRTJYUNLST (IDX1)
               MOVE    IDX1        TO  O03-PRTJYUN-COUNT
           END-PERFORM
      *
           MOVE    SPA-GMN-O03-PAGE        TO  IDX1
      *
           PERFORM VARYING   IDX2     FROM    1   BY  1
                   UNTIL   ( IDX2     >       WRK-CONS-LINE-MAX )
      *
               IF    ( SPA-NAI-O03-PRTJYUNI (IDX1 IDX2)    =   SPACE )
                   MOVE    WIDGET-INSENSITIVE
                                           TO  O03-TCHK-STATE (IDX2)
               ELSE 
                   MOVE    WIDGET-NORMAL   TO  O03-TCHK-STATE (IDX2)
               END-IF
      *
               MOVE    SPA-GMN-O03-TKENSU      (IDX1 IDX2)
                                           TO  O03-TKENSU     (IDX2)
               MOVE    SPA-GMN-O03-TPAGE       (IDX1 IDX2)
                                           TO  O03-TPAGE      (IDX2)
               MOVE    SPA-GMN-O03-TCHK-VALUE  (IDX1 IDX2)
                                           TO  O03-TCHK-VALUE (IDX2) 
               MOVE    SPA-GMN-O03-TSYURUINAME (IDX1 IDX2)
                                           TO  O03-TCHK-LABEL (IDX2)
           END-PERFORM
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
           IF    ( SPA-GMN-O03-CUR         =   ZERO )
               PERFORM 50011-GMN-CUR-SET-SEC
           END-IF
      *
           EVALUATE    SPA-GMN-O03-CUR
             WHEN    1
                    MOVE  "SYOKBN"     TO  MCP-WIDGET
             WHEN    2
      *             MOVE  "PREFKBN"    TO  MCP-WIDGET
             WHEN    3
                    MOVE  "PRTJYUNI"   TO  MCP-WIDGET
             WHEN    4
                    MOVE  "CHK01"       TO  MCP-WIDGET
             WHEN    5
      *             MOVE  "STDATA01"     TO  MCP-WIDGET
             WHEN    6
      *             MOVE  "EDDATA01"     TO  MCP-WIDGET
             WHEN    7
                    MOVE  "CHK02"       TO  MCP-WIDGET
             WHEN    8
      *             MOVE  "STDATA02"     TO  MCP-WIDGET
             WHEN    9
      *             MOVE  "EDDATA02"     TO  MCP-WIDGET
             WHEN    10
                    MOVE  "CHK03"       TO  MCP-WIDGET
             WHEN    11
      *             MOVE  "STDATA03"     TO  MCP-WIDGET
             WHEN    12
      *             MOVE  "EDDATA03"     TO  MCP-WIDGET
             WHEN    13
                    MOVE  "CHK04"       TO  MCP-WIDGET
             WHEN    14
      *             MOVE  "STDATA04"     TO  MCP-WIDGET
             WHEN    15
      *             MOVE  "EDDATA04"     TO  MCP-WIDGET
             WHEN    16
                    MOVE  "CHK05"       TO  MCP-WIDGET
             WHEN    17
      *             MOVE  "STDATA05"     TO  MCP-WIDGET
             WHEN    18
      *             MOVE  "EDDATA05"     TO  MCP-WIDGET
             WHEN    19
                    MOVE  "CHK06"       TO  MCP-WIDGET
             WHEN    20
      *             MOVE  "STDATA06"     TO  MCP-WIDGET
             WHEN    21
      *             MOVE  "EDDATA06"     TO  MCP-WIDGET
             WHEN    22
                    MOVE  "CHK07"       TO  MCP-WIDGET
             WHEN    23
      *             MOVE  "STDATA07"     TO  MCP-WIDGET
             WHEN    24
      *             MOVE  "EDDATA07"     TO  MCP-WIDGET
             WHEN   25
                    MOVE  "CHK08"       TO  MCP-WIDGET
             WHEN    26
      *             MOVE  "STDATA08"     TO  MCP-WIDGET
             WHEN    27
      *             MOVE  "EDDATA08"     TO  MCP-WIDGET
             WHEN    28
                    MOVE  "CHK09"       TO  MCP-WIDGET
             WHEN    29
      *             MOVE  "STDATA09"     TO  MCP-WIDGET
             WHEN    30
      *             MOVE  "EDDATA09"     TO  MCP-WIDGET
             WHEN    31
                    MOVE  "CHK10"      TO  MCP-WIDGET
             WHEN    32
      *             MOVE  "STDATA10"    TO  MCP-WIDGET
             WHEN    33
      *             MOVE  "EDDATA10"    TO  MCP-WIDGET
             WHEN    34
                    MOVE  "CHK11"      TO  MCP-WIDGET
             WHEN    35
      *             MOVE  "STDATA11"    TO  MCP-WIDGET
             WHEN    36
      *             MOVE  "EDDATA11"    TO  MCP-WIDGET
             WHEN    37
                    MOVE  "CHK12"      TO  MCP-WIDGET
             WHEN    38
      *             MOVE  "STDATA12"    TO  MCP-WIDGET
             WHEN    39
      *             MOVE  "EDDATA12"    TO  MCP-WIDGET
             WHEN    40
                    MOVE  "CHK13"      TO  MCP-WIDGET
             WHEN    41
      *             MOVE  "STDATA13"    TO  MCP-WIDGET
             WHEN    42
      *             MOVE  "EDDATA13"    TO  MCP-WIDGET
             WHEN    43
                    MOVE  "CHK14"      TO  MCP-WIDGET
             WHEN    44
      *             MOVE  "STDATA14"    TO  MCP-WIDGET
             WHEN    45
      *             MOVE  "EDDATA14"    TO  MCP-WIDGET
             WHEN    46
                    MOVE  "CHK15"      TO  MCP-WIDGET
             WHEN    47
      *             MOVE  "STDATA15"    TO  MCP-WIDGET
             WHEN    48
      *             MOVE  "EDDATA15"    TO  MCP-WIDGET
             WHEN    49
                    MOVE  "CHK16"      TO  MCP-WIDGET
             WHEN    50
      *             MOVE  "STDATA16"    TO  MCP-WIDGET
             WHEN    51
      *             MOVE  "EDDATA16"    TO  MCP-WIDGET
             WHEN    52
                    MOVE  "CHK17"      TO  MCP-WIDGET
             WHEN    53
      *             MOVE  "STDATA17"     TO  MCP-WIDGET
             WHEN    54
      *             MOVE  "EDDATA17"     TO  MCP-WIDGET
             WHEN    55
                    MOVE  "CHK18"      TO  MCP-WIDGET
             WHEN    56
      *             MOVE  "STDATA18"     TO  MCP-WIDGET
             WHEN    57
      *             MOVE  "EDDATA18"     TO  MCP-WIDGET
             WHEN    58
                    MOVE  "CHK19"      TO  MCP-WIDGET
             WHEN    59
      *             MOVE  "STDATA19"     TO  MCP-WIDGET
             WHEN    60
      *             MOVE  "EDDATA19"     TO  MCP-WIDGET
             WHEN    61
                    MOVE  "CHK20"       TO  MCP-WIDGET
             WHEN    62
      *             MOVE  "STDATA20"    TO  MCP-WIDGET
             WHEN    63
      *             MOVE  "EDDATA20"    TO  MCP-WIDGET
             WHEN    64
                    MOVE  "CHK21"       TO  MCP-WIDGET
             WHEN    65
      *             MOVE  "STDATA21"    TO  MCP-WIDGET
             WHEN    66
      *             MOVE  "EDDATA21"    TO  MCP-WIDGET
             WHEN    67
                    MOVE  "CHK22"       TO  MCP-WIDGET
             WHEN    68
      *             MOVE  "STDATA22"    TO  MCP-WIDGET
             WHEN    69
      *             MOVE  "EDDATA22"    TO  MCP-WIDGET
             WHEN    70
                    MOVE  "CHK23"       TO  MCP-WIDGET
             WHEN    71
      *             MOVE  "STDATA23"    TO  MCP-WIDGET
             WHEN    72
      *             MOVE  "EDDATA23"    TO  MCP-WIDGET
             WHEN    73
                    MOVE  "CHK24"       TO  MCP-WIDGET
             WHEN    74
      *             MOVE  "STDATA24"    TO  MCP-WIDGET
             WHEN    75
      *             MOVE  "EDDATA24"    TO  MCP-WIDGET
             WHEN    76
                    MOVE  "CHK25"       TO  MCP-WIDGET
             WHEN    77
      *             MOVE  "STDATA25"    TO  MCP-WIDGET
             WHEN    78
      *             MOVE  "EDDATA25"    TO  MCP-WIDGET
             WHEN    79
                    MOVE  "CHK26"       TO  MCP-WIDGET
             WHEN    80
      *             MOVE  "STDATA26"    TO  MCP-WIDGET
             WHEN    81
      *             MOVE  "EDDATA26"    TO  MCP-WIDGET
             WHEN    82
                    MOVE  "CHK27"      TO  MCP-WIDGET
             WHEN    83
      *             MOVE  "STDATA27"     TO  MCP-WIDGET
             WHEN    84
      *             MOVE  "EDDATA27"     TO  MCP-WIDGET
             WHEN    85
                    MOVE  "CHK28"      TO  MCP-WIDGET
             WHEN    86
      *             MOVE  "STDATA28"     TO  MCP-WIDGET
             WHEN    87
      *             MOVE  "EDDATA28"     TO  MCP-WIDGET
             WHEN    88
                    MOVE  "CHK29"      TO  MCP-WIDGET
             WHEN    89
      *             MOVE  "STDATA29"     TO  MCP-WIDGET
             WHEN    90
      *             MOVE  "EDDATA29"     TO  MCP-WIDGET
             WHEN    91
                    MOVE  "CHK30"       TO  MCP-WIDGET
             WHEN    92
      *             MOVE  "STDATA30"    TO  MCP-WIDGET
             WHEN    93
      *             MOVE  "EDDATA30"    TO  MCP-WIDGET
             WHEN    94
                    MOVE  "CHK31"       TO  MCP-WIDGET
             WHEN    95
      *             MOVE  "STDATA31"    TO  MCP-WIDGET
             WHEN    96
      *             MOVE  "EDDATA31"    TO  MCP-WIDGET
             WHEN    97
                    MOVE  "CHK32"       TO  MCP-WIDGET
             WHEN    98
      *             MOVE  "STDATA32"    TO  MCP-WIDGET
             WHEN    99
      *             MOVE  "EDDATA32"    TO  MCP-WIDGET
             WHEN    101
                    MOVE  "STDATA33"    TO  MCP-WIDGET
             WHEN    102
      *             MOVE  "EDDATA33"    TO  MCP-WIDGET
             WHEN    100
      *             MOVE  "CHK33"       TO  MCP-WIDGET
             WHEN    103
                    MOVE  "CHK34"       TO  MCP-WIDGET
             WHEN    104
      *             MOVE  "STDATA34"    TO  MCP-WIDGET
             WHEN    105
      *             MOVE  "EDDATA34"    TO  MCP-WIDGET
             WHEN    106
                    MOVE  "CHK35"       TO  MCP-WIDGET
             WHEN    107
      *             MOVE  "STDATA35"    TO  MCP-WIDGET
             WHEN    108
      *             MOVE  "EDDATA35"    TO  MCP-WIDGET
             WHEN    109
                    MOVE  "CHK36"       TO  MCP-WIDGET
             WHEN    110
      *             MOVE  "STDATA36"    TO  MCP-WIDGET
             WHEN    111
      *             MOVE  "EDDATA36"    TO  MCP-WIDGET
             WHEN    199
                    MOVE  "B12"        TO  MCP-WIDGET   
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *****************************************************************
      *    入力カーソル位置編集処理
      *****************************************************************
       50011-GMN-CUR-SET-SEC           SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "SKYPRTKBN"
               MOVE    3           TO  SPA-GMN-O03-CUR
           END-EVALUATE
      *
           .
       50011-GMN-CUR-SET-EXT.
           EXIT.
      *
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
                   MOVE    "印刷する請求書がありません" 
                                                       TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE  "印刷用パラメタファイルが作成できませんでした"
                                                       TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "一括出力のとき入力できません"
                                                       TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "個別出力のとき入力できません"
                                                       TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "印刷する請求書が選択してありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0009"
                   MOVE    "前頁はありません"         TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "次頁はありません"         TO  SPA-ERRMSG
               WHEN    "7777"
                   MOVE    "請求書印刷中です"
                                                       TO  SPA-ERRMSG
               WHEN    "9999"
                   MOVE    WRK-TEIKIERR                TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  OERR
           MOVE    SPA-ERRCD            TO  OERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  OERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "O03"                TO  SPA-MOTOPG
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
               WHEN    "1002"
                   MOVE    "印刷処理を開始します。よろしいですか"
                                       TO  WRK-OIDMSG
               WHEN    "6666"
                   MOVE    "請求書印刷中です"      TO  WRK-OIDMSG
               WHEN    "8888"
                   MOVE    "処理が正常に終了しました"
                                                     TO  WRK-OIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  OID1
           MOVE    SPA-OIDCD            TO  OID1-ID1CODE
           MOVE    WRK-OIDMSG           TO  OID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "O03"                TO  SPA-MOTOPG
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
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC         SECTION.
      *
           IF      WRK-YM   (1:5)  NOT NUMERIC
               INSPECT     WRK-YM       REPLACING   ALL " "
                                                    BY  "0"
               MOVE    WRK-YM(1:1)      TO  WRK-WGO
               MOVE    WRK-YM(2:2)      TO  WRK-WYY
               MOVE    WRK-YM(5:2)      TO  WRK-WMM
           ELSE
               MOVE    WRK-YM(1:5)      TO  WRK-WYMD (1:5)
           END-IF
           MOVE    01                  TO  WRK-WDD
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
               MOVE    WRK-HENYMD          TO  WRK-HENYMDG1
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG1
               MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG3
               
           END-IF
      *
           .
       5002-HIZUKE-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    定期請求管理ファイル読込
      *****************************************************************
       900-TEIKIKANRI-READ-SEC              SECTION.
      *
           MOVE    SPACE               TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TEIKIKANRI-ALL"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "TEIKIKANRI-ALL"    TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-TEIKIKANRI
                   MOVE    MCPDATA-REC         TO  TEIKIKANRI-REC
               ELSE
                   MOVE    1                   TO  FLG-TEIKIKANRI
                   INITIALIZE  TEIKIKANRI-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-TEIKIKANRI
               INITIALIZE  TEIKIKANRI-REC
           END-IF
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           MOVE    "TEIKIKANRI-ALL"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       900-TEIKIKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    定期請求管理ファイル読込
      *****************************************************************
       900-TEIKIKANRI-NEXT-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-TEIKIKANRI
               MOVE    MCPDATA-REC         TO  TEIKIKANRI-REC
           ELSE
               MOVE    1                   TO  FLG-TEIKIKANRI
           END-IF
      *
           .
       900-TEIKIKANRI-NEXT-EXT.
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
      *
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       900-SYSKANRI-INV-SEC         SECTION.
      * 
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           CALL    "ORCMCPSUB"     USING
                                   MCPAREA
                                   ORCMCPAREA
                                   MCPDATA-REC
           IF      MCP-RC          =   ZERO
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               INITIALIZE          MCPDATA-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       960-KANRIMST-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ　ＲＥＡＤ
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               INITIALIZE              MCPDATA-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************`PN@`PN@ ******
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
