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
       PROGRAM-ID.             ORCHCSET.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 診療行為
      *  コンポーネント名  : セット一覧表印刷
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/04/28    MCC−多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    印刷用データ
           SELECT  PRT-FILE        ASSIGN  HC01PARA
                                   FILE    STATUS  IS  STS-PARA.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    印刷用データ
       FD  PRT-FILE.
           COPY    "HCPO.INC".
      *
       WORKING-STORAGE             SECTION.
      *
      *     印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
      *    シェル用領域
      **** COPY    "CPCOMMONSHELL.INC".
      *
      *    シェル用領域
      *    COPY    "CPSHELLTBL.INC".
      *****COPY    "ORCA-DBPATH".
      *
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-PARA            PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-INPUTSET        PIC 9(01).
           03  FLG-INPUTCD         PIC 9(01).
      *
           03  FLG-KAISU           PIC 9(01).
           03  FLG-SP              PIC 9(01).
           03  FLG-OK              PIC 9(01).
           03  FLG-ZAITAKU         PIC 9(01).
      *
           03  FLG-PRINT           PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX-P               PIC 9(04).
           03  IDY                 PIC 9(04).
      *
           03  IDX2                PIC 9(04).
           03  IDX-MAX             PIC 9(04).
      *
           03  WRK-HEN-MAX         PIC 9(04).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME            PIC 9(08).
      *
      *    一時領域
       01  WRK-AREA.
      *
           03  WRK-PAGE            PIC 9(03).
           03  PCNT                PIC 9(03).
      *
           03  WRK-KEY-SETCD       PIC  X(06).
      *
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WYY         PIC X(03).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-HENYMDG         PIC X(22).
           03  WRK-SRYYMD          PIC X(08).
      *
           03  WRK-SURYO           PIC 9(05)V9(03).
           03  WRK-SURYO-R         REDEFINES   WRK-SURYO.
               05  WRK-SURYO-S1    PIC 9(05).
               05  WRK-SURYO-S2    PIC 9(03).
      *
           03  WRK-SURYO-X.
               05  WRK-SURYO-Z1    PIC ZZZZ9.
               05  WRK-SURYO-Z2    PIC X(01).
               05  WRK-SURYO-Z3    PIC ZZZ.
           03  WRK-SURYO-N         PIC X(18).
      *
           03  WRK-TANINAME        PIC X(04).
           03  WRK-ZZ              PIC ZZ.
           03  WRK-ZZZ             PIC ZZZ.
           03  WRK-KAISU           PIC 9(05).
      *
           03  WRK-TNS-NAME        PIC X(200).
      *
      *    文字変換
           03  WRK-ZENKAKU-G.
               05  WRK-ZENKAKU         PIC X(02)   OCCURS   10.
           03  WRK-MOJI                PIC X(10).
           03  WRK-MOJISU              PIC 9(02).
           03  WRK-FTNKBN              PIC X(20).
      *
      *    印刷内容
       01  HEAD-01.
           03  FILLER                  PIC X(10)   VALUE   SPACE.
           03  H01-MIDASI              PIC X(50).
           03  FILLER                  PIC X(08)   VALUE   "作成日：".
           03  H01-YY                  PIC 9(04).
           03  FILLER                  PIC X(01)   VALUE   ".".
           03  H01-MM                  PIC Z9.
           03  FILLER                  PIC X(01)   VALUE   ".".
           03  H01-DD                  PIC Z9.
           03  FILLER                  PIC X(04)   VALUE   "  P-".
           03  H01-PCNT                PIC ZZ9.
       01  HEAD-02.
           03  FILLER                  PIC X(02).
           03  H02-SETCD               PIC X(06).
           03  FILLER                  PIC X(02).
           03  H02-DSPNAME             PIC X(100).
       01  HEAD-03.
           03  FILLER                  PIC X(04).
           03  H03-MIDASI              PIC X(14).
           03  H03-INPUTCD-G           OCCURS  5.
               05  H03-INPUTCD         PIC X(10).
               05  H03-YOBI1           PIC X(01).
       01  BODY-01.
           03  B01-YOBI1               PIC X(04).
           03  B01-ZUMIFLG             PIC X(02).
           03  B01-YOBI2               PIC X(02).
           03  B01-SRYCD               PIC X(09).
           03  B01-YOBI3               PIC X(02).
           03  B01-NAME                PIC X(50).
           03  FILLER                  PIC X(01).
           03  B01-HENSYU.
               05  B01-SURYO-HEN           PIC X(15).
               05  B01-KAISU-HEN           PIC X(15).
      *
       01  WRK-HEN-SURYO.
           03  B01-SURYO1              PIC ZZZZ9.999.
      *
       01  WRK-HEN-KAISU.
           03  B01-KAKERU              PIC X(02).
           03  B01-KAISU               PIC ZZZ.
      *
       01  WRK-HEN-SURYO-2.
           03  B01-SURYO12             PIC ZZZZ.
           03  B01-YOBI6               PIC X(02).
           03  B01-SURYO22             PIC ZZZZ.
      *
       01  WRK-HEN-ATAI.
           03  B01-ATAI1               PIC X(08).
           03  B01-ATAI1F              PIC X(01).
           03  B01-ATAI2               PIC X(08).
           03  B01-ATAI2F              PIC X(01).
           03  B01-ATAI3               PIC X(08).
           03  B01-ATAI3F              PIC X(01).
           03  B01-ATAI4               PIC X(08).
      *
      *    内容
       01  WRK-HEN-AREA.
           03  WRK-TBL-REC             PIC X(90)   OCCURS   69.
      *
           03  WRK-PAGE-MAX            PIC 9(03).
      *
      *   日本語数字
       01  TBL-SUJI-AREA.
           03  FILLER          PIC X(20)   VALUE
              "１２３４５６７８９０".
       01  TBL-SUJI-R          REDEFINES   TBL-SUJI-AREA.
           03  TBL-SUJI        PIC X(02)   OCCURS   10.
      *
      *    診療種別名テーブル
           COPY    "CPORCSSRYSYU.INC".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    医療機関情報−基本情報 
           COPY    "CPSK1001.INC".
      *
      *    出力先プリンタ名割り当て情報
           COPY  "CPSK1031.INC".
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *    入力コードマスタ−
       01  INPUTCD-REC.
           COPY    "CPINPUTCD.INC".
      *
      *    入力セットコード
       01  INPUTSET-REC.
           COPY    "CPINPUTSET.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    印刷パラメタ
           COPY    "CPORCSMKPRT.INC".
      *
      *01  MCPDATA-REC                 PIC X(5000).
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    一覧印刷変換領域
           COPY    "CPORCHCSET.INC".
      *
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           ORCHCSETAREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
      *
           ACCEPT  SYS-TIME            FROM    TIME
      *
      *    各ＤＢ読込
           PERFORM 100-SYORI-SEC
      *
      *    編集印刷処理
           PERFORM 200-MEISAI-SYORI-SEC
                   UNTIL       FLG-END     =   1
      *
      *    印刷処理
           IF      IDX-P               >   ZERO
               PERFORM 400-PRINT-SYORI-SEC
           END-IF
      *
           .
       000-PROC-EXT.
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    印刷処理
      *****************************************************************
       400-PRINT-SYORI-SEC             SECTION.
      *
      *    帳票印刷開始処理
           PERFORM 400-SYOKI-PRINT-SEC
      *
      *    帳票印刷処理
           PERFORM 400-PRINT-SEC
      *
           MOVE    ZERO                TO  IDX-P
           MOVE    SPACE               TO  HCPO
      *
           .
       400-PRINT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷開始処理
      *****************************************************************
       400-SYOKI-PRINT-SEC             SECTION.
      *
      *    ファイルＯＰＥＮ
           MOVE    "HCPO"              TO  HC01PARA-FORM-ID
           MOVE    SPA-TERMID          TO  HC01PARA-TERMID
           MOVE    SYS-TIME            TO  HC01PARA-SYOHMS
      *
           ADD     1                   TO  WRK-PAGE
           MOVE    WRK-PAGE            TO  HC01PARA-CNT
           OPEN    OUTPUT              PRT-FILE
      *
           .
       400-SYOKI-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       400-PRINT-SEC                SECTION.
      *
      *　　印刷用データ出力
            WRITE  HCPO
      *
      ****  MOVE   "HC01.sh"           TO  SHELL-ID
      *     MOVE   "HCPO.dia"          TO  SHELL-DIA
      *     MOVE   "HCPO.def"          TO  SHELL-DEF
      *     MOVE   HC01PARA            TO  SHELL-DAT
      ***** MOVE   SYS-1031-PRTNM(6)   TO  SHELL-PRTNM
            CLOSE                       PRT-FILE
      *
            INITIALIZE                 ORCSMKPRTAREA
            MOVE   "HC01.sh"           TO  MKPRT-ID
            MOVE   "HCPO.dia"          TO  MKPRT-DIA
            MOVE   "HCPO.def"          TO  MKPRT-DEF
            MOVE   HC01PARA            TO  MKPRT-DAT
            MOVE   SYS-1031-PRTNM(6)   TO  MKPRT-PRTNM
            CALL   "ORCSMKPRT"         USING
                                       ORCSMKPRTAREA
      *
      *   印刷用スクリプト処理
      *★   ETC-EXEC SHELL   SHELL-AREA 10
      *    MOVE    SHELL-NAME          TO  SHELLTBL-NAME
      *    MOVE    SHELL-ARG1          TO  SHELLTBL-ARG1
      *    MOVE    SHELL-ARG2          TO  SHELLTBL-ARG2
      *    MOVE    SHELL-ARG3          TO  SHELLTBL-ARG3
      *    MOVE    SHELL-ARG4          TO  SHELLTBL-ARG4
      *    MOVE    SHELL-ARG5          TO  SHELLTBL-ARG5
      *    MOVE    SHELLTBL            TO  MCPDATA-REC
      *    MOVE    "SHELL"             TO  MCP-FUNC
      *    MOVE    PATH-SHELL-SHELL    TO  MCP-PATH
      *    CALL    "MCPSUB"            USING
      *            MCPAREA
      ************ MCPDATA-REC
      *
           .
       400-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期編集処理
      *****************************************************************
       100-SYORI-SEC                SECTION.
      *
      *    出力先プリンタ名割り当て情報編集
           MOVE    SPACE               TO  SYS-1031-REC
           INITIALIZE                  SYS-1031-REC
           MOVE    "1031"              TO  SYS-1031-KANRICD
           MOVE    "*"                 TO  SYS-1031-KBNCD
           MOVE    SYS-1031-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-1031-REC
               END-IF
           ELSE
               INITIALIZE                  SYS-1031-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    入力セット検索
           INITIALIZE                      INPUTSET-REC
           MOVE    SPA-HOSPID          TO  ISET-HOSPID
           MOVE    HCSET-STR-SETCD     TO  ISET-SETCD
           MOVE    HCSET-END-SETCD     TO  ISET-UPHMS
      *
      *
           MOVE    INPUTSET-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "INPUTSET-KEY4"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "INPUTSET-KEY4"     TO  ORC-DBPATH
               PERFORM                     900-INPUTSET-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-INPUTSET
               MOVE    1                   TO  FLG-END
           END-IF
      *
      *    初期クリア
           MOVE    ZERO                TO  IDX-P
           MOVE    SPACE               TO  HCPO
      *
           MOVE    "セット登録一覧表"  TO  H01-MIDASI
      *
           MOVE    SPA-SRYYMD(1:4)     TO  H01-YY
           MOVE    SPA-SRYYMD(5:2)     TO  H01-MM
           MOVE    SPA-SRYYMD(7:2)     TO  H01-DD
      *
           .
       100-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    編集印刷処理
      *****************************************************************
       200-MEISAI-SYORI-SEC            SECTION.
      *
           INITIALIZE                  WRK-HEN-AREA
           MOVE    ZERO                TO  IDX
           MOVE    ISET-SETCD          TO  WRK-KEY-SETCD
      *    見出し編集
           MOVE    ZERO                TO  WRK-HEN-MAX
           PERFORM 2001-HEAD-HEN-SEC
      *
           PERFORM 2002-MEISAI-HEN-SEC
                   UNTIL    (FLG-END       =    1    )  OR
                            (ISET-SETCD    NOT =   WRK-KEY-SETCD)
      *
      *    最大行数のセット
           MOVE    69                  TO  IDX-MAX
      *
      *    編集処理
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   WRK-HEN-MAX
               IF      IDX-P               >=  IDX-MAX
      *            改ページ
                   PERFORM 400-PRINT-SYORI-SEC
                   MOVE    ZERO                TO  IDX-P
      *            見出し編集
                   ADD     1                   TO  PCNT
                   MOVE    PCNT                TO  H01-PCNT
                   ADD     1                   TO  IDX-P
                   MOVE    HEAD-01             TO  HCPO-MOJI  (IDX-P)
                   ADD     1                   TO  IDX-P
               END-IF
               ADD     1                   TO  IDX-P
               MOVE    WRK-TBL-REC (IDX)   TO  HCPO-MOJI  (IDX-P)
           END-PERFORM
      *
           ADD     1                   TO  IDX-P
           IF      IDX-P               <=  69
               MOVE    ALL "-"             TO  HCPO-MOJI  (IDX-P)
           END-IF
      *
           .
       200-MEISAI-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    見出し編集処理
      *****************************************************************
       2001-HEAD-HEN-SEC          SECTION.
      *
      *    見出し編集
           IF      IDX-P               =   ZERO
               ADD     1                   TO  PCNT
               MOVE    PCNT                TO  H01-PCNT
               ADD     1                   TO  WRK-HEN-MAX
               MOVE    HEAD-01             TO  WRK-TBL-REC (WRK-HEN-MAX)
               ADD     1                   TO  WRK-HEN-MAX
           END-IF
      *
           MOVE    SPACE               TO  HEAD-02
           MOVE    SPACE               TO  HEAD-03
      *    入力ＣＤ
           MOVE    ISET-SETCD          TO  H02-SETCD
      *
           INITIALIZE                      INPUTCD-REC
           MOVE    SPA-HOSPID          TO  ICD-HOSPID
           MOVE    ISET-SETCD          TO  ICD-SRYCD
      *
           MOVE    INPUTCD-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "INPUTCD-KEY3"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "INPUTCD-KEY3"      TO  ORC-DBPATH
               PERFORM                     920-INPUTCD-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-INPUTCD
           END-IF
      *
           MOVE    ZERO                TO  IDY
           PERFORM
               UNTIL     FLG-INPUTCD       =   1
               IF      ICD-INPUTCD         =   ISET-SETCD
      *            表示名
                   MOVE    ICD-DSPNAME         TO  H02-DSPNAME
               ELSE
                   ADD     1                   TO  IDY
                   IF      IDY                 <=  5
                       MOVE    ICD-INPUTCD     TO  H03-INPUTCD (IDY)
      *****************IF      IDY             >   1
      *                    MOVE    ","         TO  H03-YOBI1 (IDY - 1)
      *****************END-IF
                   END-IF
               END-IF
      *
               MOVE    "INPUTCD-KEY3"      TO  ORC-DBPATH
               PERFORM                     920-INPUTCD-NEXT-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "INPUTCD-KEY3"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           ADD     1                   TO  WRK-HEN-MAX
           MOVE    HEAD-02             TO  WRK-TBL-REC (WRK-HEN-MAX)
           IF      IDY                 >   ZERO
               ADD     1                   TO  WRK-HEN-MAX
               MOVE    "【入力ＣＤ】"      TO  H03-MIDASI
               MOVE    HEAD-03             TO  WRK-TBL-REC (WRK-HEN-MAX)
           END-IF
      *
           .
       2001-HEAD-HEN-EXT.
           EXIT.
      *****************************************************************
      *    内容編集処理
      *****************************************************************
       2002-MEISAI-HEN-SEC          SECTION.
      *
           MOVE    SPACE               TO  BODY-01
           MOVE    ISET-INPUTCD        TO  B01-SRYCD
           EVALUATE    ISET-INPUTCD(1:1)
               WHEN    "S"
      *            約束セット
                   PERFORM 20021-YAKUSOKU-HEN-SEC
               WHEN    "."
      *            診療種別
                   PERFORM 20022-SRYSYUKBN-HEN-SEC
               WHEN    OTHER
      *            点数マスタ
                   PERFORM 20023-SRYCD-HEN-SEC
           END-EVALUATE
      *
           INSPECT B01-YOBI1           REPLACING  ALL "  "  BY  "　"
           INSPECT B01-ZUMIFLG         REPLACING  ALL "  "  BY  "　"
           INSPECT B01-YOBI2           REPLACING  ALL "  "  BY  "　"
           INSPECT B01-YOBI3           REPLACING  ALL "  "  BY  "　"
           INSPECT B01-NAME            REPLACING  ALL "  "  BY  "　"
      *
           ADD     1                   TO  WRK-HEN-MAX
           MOVE    BODY-01             TO  WRK-TBL-REC (WRK-HEN-MAX)
      *
           MOVE    "INPUTSET-KEY4"     TO  ORC-DBPATH
           PERFORM                     900-INPUTSET-READ-SEC
      *
           .
       2002-MEISAI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    約束セット処理
      *****************************************************************
       20021-YAKUSOKU-HEN-SEC          SECTION.
      *
      *
           INITIALIZE                      INPUTCD-REC
           MOVE    SPA-HOSPID          TO  ICD-HOSPID
           MOVE    "6"                 TO  ICD-CDSYU
           MOVE    ISET-SETCD          TO  ICD-INPUTCD
      *
           MOVE    INPUTCD-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "INPUTCD-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "INPUTCD-KEY"       TO  ORC-DBPATH
               PERFORM                     920-INPUTCD-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-INPUTCD
           END-IF
           IF      FLG-INPUTCD         =   ZERO
      *        表示名
               MOVE    ICD-DSPNAME         TO  B01-NAME
           END-IF
      *
           .
       20021-YAKUSOKU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *   診療種別処理
      *****************************************************************
       20022-SRYSYUKBN-HEN-SEC          SECTION.
      *
      *    診療種別テーブルセット
           CALL    "ORCSSRYSYU"        USING
                                       MSYU-DATA-REC
      *
           SET     MSYU-IDX            TO  1
           SEARCH      MSYU-TBL-OCC    VARYING   MSYU-IDX
                   AT   END
                       MOVE    SPACE           TO  B01-NAME
                   WHEN    ISET-INPUTCD(2:3)   =   MSYU-SRYSYUKBN 
                                                           (MSYU-IDX)
                       MOVE    MSYU-SRYMEI (MSYU-IDX)
                                                TO  B01-NAME
           END-SEARCH 
      *
      *
           .
       20022-SRYSYUKBN-HEN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *   診療コード処理
      *****************************************************************
       20023-SRYCD-HEN-SEC          SECTION.
      *
           INITIALIZE                  TNS-TENSU-REC
           MOVE    ISET-INPUTCD        TO  TNS-SRYCD
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
               PERFORM 910-TENSU-READ-SEC
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM UNTIL    (FLG-TENSU     =   1  )  OR
                            (FLG-OK        =   1  )
               MOVE    TNS-NAME            TO  B01-NAME
               IF     (TNS-YUKOSTYMD       <=  SPA-SRYYMD )  AND
                      (TNS-YUKOEDYMD       >=  SPA-SRYYMD )
      *            診療日対象分
                   MOVE    1               TO  FLG-OK
               END-IF
               MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
               PERFORM 910-TENSU-READ-SEC
           END-PERFORM
      *
           IF      FLG-OK              =   ZERO
               MOVE    "削"            TO  B01-ZUMIFLG
           END-IF
      *
           IF      ISET-COMMENT    NOT =   SPACE
               MOVE    ISET-COMMENT        TO  B01-NAME
           END-IF
      *
           MOVE    SPACE               TO  WRK-HEN-SURYO
           MOVE    SPACE               TO  WRK-HEN-SURYO-2
      *    数量
           IF     (ISET-INPUTCD(1:1)   =   "6"  OR  "7" )  OR
                  (ISET-SURYO1         >   1            )
               MOVE    ISET-SURYO1         TO  WRK-SURYO
               MOVE    WRK-SURYO           TO  B01-SURYO1
               MOVE    WRK-HEN-SURYO       TO  B01-SURYO-HEN
           END-IF
      *    分画数
           IF     (ISET-INPUTCD(1:1)   =   "7" )  AND
                  (ISET-SURYO2         >   ZERO)
               MOVE    ISET-SURYO1         TO  WRK-SURYO
               MOVE    WRK-SURYO           TO  B01-SURYO12
               MOVE    ISET-SURYO2         TO  WRK-SURYO
               MOVE    WRK-SURYO           TO  B01-SURYO22
               MOVE    WRK-HEN-SURYO-2     TO  B01-SURYO-HEN
           END-IF
      *    その他
           IF      ISET-ATAI-AREA      NOT =   SPACE
               MOVE    SPACE           TO  B01-HENSYU
               STRING  ISET-ATAI1      DELIMITED  BY  SPACE
                       ","             DELIMITED  BY  SIZE
                       ISET-ATAI2      DELIMITED  BY  SPACE
                       ","             DELIMITED  BY  SIZE
                       ISET-ATAI3      DELIMITED  BY  SPACE
                       ","             DELIMITED  BY  SIZE
                       ISET-ATAI4      DELIMITED  BY  SPACE
                       INTO                    B01-HENSYU
               END-STRING
               GO      TO      20023-SRYCD-HEN-EXT
           END-IF
      *    用法
           IF     (ISET-INPUTCD(1:3)       =   "001"  )  OR
                  (ISET-KAISU               >   1     )
               MOVE    ISET-KAISU          TO  B01-KAISU
               MOVE    "×"                TO  B01-KAKERU
               MOVE    WRK-HEN-KAISU       TO  B01-KAISU-HEN
           END-IF
           .
       20023-SRYCD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読み込み処理
      *****************************************************************
       900-KANRIMST-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-KANRIMST-READ-EXT.
           EXIT.
      *****************************************************************
      *    点数マスター読込
      *****************************************************************
       910-TENSU-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
               MOVE    ZERO                TO  FLG-TENSU
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
           .
       910-TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力コードマスター次読込
      *****************************************************************
       920-INPUTCD-NEXT-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  INPUTCD-REC
               MOVE    ZERO                TO  FLG-INPUTCD
           ELSE
               INITIALIZE                      INPUTCD-REC
               MOVE    1                   TO  FLG-INPUTCD
           END-IF
      *
           .
       920-INPUTCD-NEXT-EXT.
           EXIT.
      *****************************************************************
      *    入力セットデータ次読込
      *****************************************************************
       900-INPUTSET-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  INPUTSET-REC
               MOVE    ZERO                TO  FLG-INPUTSET
               MOVE    ZERO                TO  FLG-END
           ELSE
               INITIALIZE                      INPUTSET-REC
               MOVE    1                   TO  FLG-INPUTSET
               MOVE    1                   TO  FLG-END
           END-IF
      *
           .
       900-INPUTSET-READ-EXT.
           EXIT.
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           .
       300-END-EXT.
           EXIT.
      *
