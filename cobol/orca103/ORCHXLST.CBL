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
       PROGRAM-ID.             ORCHXLST.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : チェクマスタ
      *  コンポーネント名  : チェクマスタ一覧表印刷
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/04/26    MCC−多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-太田    04/03/01  一括印刷対応
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
           COPY    "HCP7LA.INC".
      *
       WORKING-STORAGE             SECTION.
      *
      *     印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
      *    シェル用領域
           COPY    "CPCOMMONSHELL.INC".
      *
      *    シェル用領域
           COPY    "CPSHELLTBL.INC".
           COPY    "ORCA-DBPATH".
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-OUT             PIC 9(02).
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
           03  FLG-CHKMST          PIC 9(01).
           03  FLG-BYOMEI          PIC 9(01).
      *
      *
           03  FLG-OK              PIC 9(01).
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
           03  WRK-DBPATH          PIC X(64).
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
           03  WRK-KEY-SRYCD       PIC  X(09).
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
           03  WRK-SRYCD           PIC X(09).
           03  WRK-BYOMEICD        PIC X(07).
      *
           03  WRK-NAME-G.
               05  WRK-NAME1       PIC X(04).
               05  WRK-NAME        PIC X(100).
      *
      *    印刷内容
       01  HEAD-01.
           03  FILLER                  PIC X(25)   VALUE   SPACE.
           03  H01-MIDASI              PIC X(80).
           03  FILLER                  PIC X(08)   VALUE   "作成日：".
           03  H01-YY                  PIC 9(04).
           03  FILLER                  PIC X(01)   VALUE   ".".
           03  H01-MM                  PIC Z9.
           03  FILLER                  PIC X(01)   VALUE   ".".
           03  H01-DD                  PIC Z9.
           03  FILLER                  PIC X(04)   VALUE   "  P-".
           03  H01-PCNT                PIC ZZ9.
       01  HEAD-02.
           03  FILLER                  PIC X(10)   VALUE   SPACE.
           03  H02-MIDASI1             PIC X(50).
           03  FILLER                  PIC X(01)   VALUE   SPACE.
           03  H02-MIDASI2             PIC X(50).
       01  BODY-01.
           03  B01-SRYCD1              PIC X(09).
           03  B01-YOBI1               PIC X(02).
           03  B01-NAME1               PIC X(50).
           03  FILLER                  PIC X(01).
           03  B01-SRYCD2              PIC X(09).
           03  B01-YOBI2               PIC X(02).
           03  B01-NAME2               PIC X(80).
      *
      *    内容
       01  WRK-HEN-AREA.
           03  WRK-TBL-REC             PIC X(131)   OCCURS  200.
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
      *    チェックマスタ−
       01  CHK-REC.
           COPY    "CPCHK.INC".
      *
      *    病名マスタ−
       01  BYOMEI-REC.
           COPY    "CPBYOMEI.INC".
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    印刷ＤＢ更新サブ
           COPY    "CPORCSPRT.INC".
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
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
           COPY    "CPORCHXLST.INC".
      *
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           ORCHXLSTAREA
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
           INITIALIZE                  CNT-AREA
           INITIALIZE                  HXLST-RCD
      *
           ACCEPT  SYS-TIME            FROM    TIME
      *
      *    各ＤＢ読込
           PERFORM 100-SYORI-SEC
           IF      HXLST-RCD       NOT =   ZERO
               GO      TO      000-PROC-EXT
           END-IF
      *
      *    編集印刷処理
           PERFORM 200-MEISAI-SYORI-SEC
                   UNTIL       FLG-END     =   1
      *
      *    印刷処理
           IF      IDX-P               >   ZERO
               IF    ( HXLST-PROCKBN   =   "1" )
                   PERFORM 400-PRINT-SYORI-SEC
               ELSE
                   PERFORM 410-PRINT-SYORI-SEC
               END-IF
           END-IF
      *
           MOVE    CNT-OUT         TO  HXLST-OUT-CNT
      *
           .
       000-PROC-EXT.
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    印刷処理（オンライン印刷）
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
           MOVE    SPACE               TO  HCP7LA
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
           MOVE    "HCP7LA"            TO  HC01PARA-FORM-ID
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
            WRITE  HCP7LA
      *
            MOVE   "HC01.sh"           TO  SHELL-ID
            MOVE   "HCP7LA.dia"        TO  SHELL-DIA
            MOVE   "HCP7LA.def"        TO  SHELL-DEF
            MOVE   HC01PARA            TO  SHELL-DAT
            MOVE   SYS-1031-PRTNM(6)   TO  SHELL-PRTNM
            CLOSE                       PRT-FILE
      *
      *   印刷用スクリプト処理
           MOVE    SHELL-NAME          TO  SHELLTBL-NAME
           MOVE    SHELL-ARG1          TO  SHELLTBL-ARG1
           MOVE    SHELL-ARG2          TO  SHELLTBL-ARG2
           MOVE    SHELL-ARG3          TO  SHELLTBL-ARG3
           MOVE    SHELL-ARG4          TO  SHELLTBL-ARG4
           MOVE    SHELL-ARG5          TO  SHELLTBL-ARG5
           MOVE    SHELLTBL            TO  MCPDATA-REC
           MOVE    "SHELL"             TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL    TO  MCP-PATH
           CALL    "MCPSUB"            USING
                   MCPAREA
                   MCPDATA-REC
      *
           COMPUTE CNT-OUT         =   CNT-OUT     +   1
      *
           .
       400-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷処理（一括印刷）
      *****************************************************************
       410-PRINT-SYORI-SEC             SECTION.
      *
           MOVE    HXLST-PRTAREA       TO  ORCSPRTAREA
      *
           MOVE    "HCP7LA"            TO  SPRT-PRTID
           MOVE    HCP7LA              TO  SPRT-PRTDATA
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF      SPRT-RETURN         =   ZERO
      *        CONTINUE
               COMPUTE CNT-OUT         =   CNT-OUT     +   1
           ELSE
               MOVE    9               TO  HXLST-RCD
           END-IF
      *
      *
           MOVE    ZERO                TO  IDX-P
           MOVE    SPACE               TO  HCP7LA
      *
           .
       410-PRINT-SYORI-EXT.
           EXIT.
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
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
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
      *
           MOVE    SPACE               TO  CHK-REC
           INITIALIZE                  CHK-REC
      *
           EVALUATE    HXLST-CHKKBN
               WHEN    "1"
               WHEN    "2"
                   MOVE    "1"             TO  CHK-CDKBN
               WHEN    "3"
                   MOVE    "3"             TO  CHK-CDKBN
               WHEN    "4" 
               WHEN    "5"
                   MOVE    "2"             TO  CHK-CDKBN
               WHEN    OTHER
                   MOVE    -1              TO  HXLST-RCD
                   GO      TO      100-SYORI-EXT
           END-EVALUATE
           MOVE    HXLST-CHKKBN        TO  CHK-CHKKBN
           MOVE    HXLST-SRYCD         TO  CHK-SRYCD
      *
           IF    ( HXLST-SRYCD         =   SPACE )
               MOVE    "000000000"     TO  CHK-SRYCD
               MOVE    "999999999"     TO  CHKUP-SRYCD
           ELSE
               IF    ( HXLST-SRYCD-END     =   SPACE  )
                OR   ( HXLST-SRYCD         >   HXLST-SRYCD-END )
                   MOVE    HXLST-SRYCD     TO  CHKUP-SRYCD
               ELSE
                   MOVE    HXLST-SRYCD-END TO  CHKUP-SRYCD
               END-IF
           END-IF
      *
           EVALUATE HXLST-SRTKBN
           WHEN   "1"
               MOVE    "CHK-KEY10"     TO  WRK-DBPATH
           WHEN   "2"
               MOVE    "CHK-KEY8"      TO  WRK-DBPATH
           WHEN   "3"
               MOVE    "CHK-KEY9"      TO  WRK-DBPATH
           WHEN   OTHER
               MOVE    "CHK-KEY10"     TO  WRK-DBPATH
           END-EVALUATE
      *
           MOVE    ZERO                TO  FLG-CHKMST
           MOVE    CHK-REC             TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-DBPATH          TO  ORC-DBPATH
               PERFORM 950-CHK-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-CHKMST
           END-IF
      *
      *    初期クリア
           MOVE    ZERO                TO  IDX-P
           MOVE    SPACE               TO  HCP7LA
      *
           EVALUATE    HXLST-CHKKBN
               WHEN    "1"
                   MOVE
               "＜　薬剤と病名一覧表　＞"
                                       TO  H01-MIDASI
                   MOVE    "薬剤コード"
                                       TO  H02-MIDASI1
                   MOVE    "病名コード"
                                       TO  H02-MIDASI2
               WHEN    "2"
                   MOVE
               "＜　診療行為と病名一覧表　＞"
                                       TO  H01-MIDASI
                   MOVE    "診療行為コード"
                                       TO  H02-MIDASI1
                   MOVE    "病名コード"
                                       TO  H02-MIDASI2
               WHEN    "3"
                   MOVE
               "＜　薬剤と禁忌一覧表　＞"
                                       TO  H01-MIDASI
                   MOVE    "薬剤コード"
                                       TO  H02-MIDASI1
                   MOVE    "禁忌コード"
                                       TO  H02-MIDASI2
               WHEN    "4" 
                   MOVE
               "＜　薬剤と併用禁忌一覧表　＞"
                                       TO  H01-MIDASI
                   MOVE    "薬剤コード"
                                       TO  H02-MIDASI1
                   MOVE    "適用薬剤コード"
                                       TO  H02-MIDASI2
               WHEN    "5"
                   MOVE
               "＜　同一月に併用算定できない診療行為一覧表　＞"
                                       TO  H01-MIDASI
                   MOVE    "診療行為コード"
                                       TO  H02-MIDASI1
                   MOVE    "適用診療行為コード"
                                       TO  H02-MIDASI2
           END-EVALUATE
      *
           MOVE    SPA-SYSYMD(1:4)     TO  H01-YY
           MOVE    SPA-SYSYMD(5:2)     TO  H01-MM
           MOVE    SPA-SYSYMD(7:2)     TO  H01-DD
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
           MOVE    CHK-SRYCD           TO  WRK-KEY-SRYCD
      *    見出し編集
           MOVE    ZERO                TO  WRK-HEN-MAX
           PERFORM 2001-HEAD-HEN-SEC
      *
           PERFORM 2002-MEISAI-HEN-SEC
                   UNTIL     (FLG-END      =   1  )  OR
                             (CHK-SRYCD   NOT =   WRK-KEY-SRYCD)
      *
      *    最大行数のセット
           MOVE    48                  TO  IDX-MAX
      *
      *    編集処理
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   WRK-HEN-MAX
               IF      IDX-P               >=  IDX-MAX
      *
      *            改ページ
                   IF    ( HXLST-PROCKBN   =   "1" )
                       PERFORM 400-PRINT-SYORI-SEC
                   ELSE
                       PERFORM 410-PRINT-SYORI-SEC
                   END-IF
      *
                   MOVE    ZERO                TO  IDX-P
      *            見出し編集
                   ADD     1                   TO  PCNT
                   MOVE    PCNT                TO  H01-PCNT
                   ADD     1                   TO  IDX-P
                   MOVE    HEAD-01             TO  HCP7LA-MOJI  (IDX-P)
                   ADD     1                   TO  IDX-P
                   MOVE    HEAD-02             TO  HCP7LA-MOJI  (IDX-P)
                   ADD     1                   TO  IDX-P
                   MOVE    ALL "-"             TO  HCP7LA-MOJI  (IDX-P)
               END-IF
               ADD     1                   TO  IDX-P
               MOVE    WRK-TBL-REC (IDX)   TO  HCP7LA-MOJI  (IDX-P)
           END-PERFORM
      *
           ADD     1                   TO  IDX-P
           IF      IDX-P               <=  IDX-MAX
               MOVE    ALL "-"             TO  HCP7LA-MOJI  (IDX-P)
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
               MOVE    HEAD-02             TO  WRK-TBL-REC (WRK-HEN-MAX)
               ADD     1                   TO  WRK-HEN-MAX
               MOVE     ALL "-"            TO  WRK-TBL-REC (WRK-HEN-MAX)
           END-IF
      *
           MOVE    SPACE               TO  BODY-01
           MOVE    CHK-SRYCD           TO  B01-SRYCD1
           MOVE    CHK-SRYCD           TO  WRK-SRYCD
           PERFORM 20023-SRYCD-HEN-SEC
           MOVE    WRK-NAME-G          TO  B01-NAME1
      *
           .
       2001-HEAD-HEN-EXT.
           EXIT.
      *****************************************************************
      *    内容編集処理
      *****************************************************************
       2002-MEISAI-HEN-SEC          SECTION.
      *
           PERFORM VARYING     IDX     FROM   1   BY  1
                   UNTIL      (IDX     >   10     )   OR
                              (CHK-CD (IDX)   =   SPACE ) OR
                              (WRK-HEN-MAX    >=  200   )
               MOVE    CHK-CD (IDX)        TO  B01-SRYCD2
               EVALUATE    HXLST-CHKKBN
                   WHEN    "1"
                   WHEN    "2"
      *                病名マスタ読み込み
                       MOVE    CHK-CD (IDX)        TO  WRK-BYOMEICD
                       PERFORM 20024-BYOMEI-HEN-SEC
                   WHEN    "3"
                       CONTINUE
                   WHEN    "4"
                   WHEN    "5"
      *                病名マスタ読み込み
                       MOVE    CHK-CD (IDX)        TO  WRK-SRYCD
                       PERFORM 20023-SRYCD-HEN-SEC
               END-EVALUATE
               MOVE    WRK-NAME-G          TO  B01-NAME2
      *
               INSPECT B01-YOBI1       REPLACING  ALL "  "  BY  "　"
               INSPECT B01-YOBI2       REPLACING  ALL "  "  BY  "　"
               INSPECT B01-NAME1       REPLACING  ALL "  "  BY  "　"
               INSPECT B01-NAME2       REPLACING  ALL "  "  BY  "　"
      *
               ADD     1                   TO  WRK-HEN-MAX
               MOVE    BODY-01             TO  WRK-TBL-REC (WRK-HEN-MAX)
               MOVE    SPACE               TO  BODY-01
           END-PERFORM
      *
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           PERFORM 950-CHK-READ-SEC
      *
           .
       2002-MEISAI-HEN-EXT.
           EXIT.
      *****************************************************************
      *   診療コード処理
      *****************************************************************
       20023-SRYCD-HEN-SEC          SECTION.
      *
           INITIALIZE                  TNS-TENSU-REC
           MOVE    WRK-SRYCD           TO  TNS-SRYCD
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
           MOVE    SPACE               TO  WRK-NAME-G
           MOVE    ZERO                TO  FLG-OK
           PERFORM UNTIL    (FLG-TENSU     =   1  )  OR
                            (FLG-OK        =   1  )
               MOVE    TNS-NAME            TO  WRK-NAME
               IF     (TNS-YUKOSTYMD       <=  SPA-SYSYMD )  AND
                      (TNS-YUKOEDYMD       >=  SPA-SYSYMD )
      *            診療日対象分
                   MOVE    1               TO  FLG-OK
               END-IF
               MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
               PERFORM 910-TENSU-READ-SEC
           END-PERFORM
      *
           IF      FLG-OK              =   ZERO
               MOVE    "削"            TO  WRK-NAME1
           END-IF
      *
           .
       20023-SRYCD-HEN-EXT.
           EXIT.
      *****************************************************************
      *   病名コード処理
      *****************************************************************
       20024-BYOMEI-HEN-SEC          SECTION.
      *
           INITIALIZE                   BYOMEI-REC
           MOVE    WRK-BYOMEICD        TO  BYO-BYOMEICD
      *
           MOVE    BYOMEI-REC          TO  MCPDATA-REC 
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "BYOMEI-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "BYOMEI-KEY"        TO  ORC-DBPATH
               PERFORM 920-BYOMEI-READ-SEC
           ELSE
               INITIALIZE                  BYOMEI-REC
               MOVE    1                   TO  FLG-BYOMEI
           END-IF
           MOVE    BYO-BYOMEI          TO  WRK-NAME-G
      *
           .
       20024-BYOMEI-HEN-EXT.
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
      *****************************************************************
      *    チェックデータ読込
      *****************************************************************
       950-CHK-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  CHK-REC
               MOVE    ZERO                TO  FLG-CHKMST
               MOVE    ZERO                TO  FLG-END
           ELSE
               INITIALIZE                      CHK-REC
               MOVE    1                   TO  FLG-CHKMST
               MOVE    1                   TO  FLG-END
           END-IF
      *
           .
       950-CHK-READ-EXT.
           EXIT.
      *****************************************************************
      *    病名読込
      *****************************************************************
       920-BYOMEI-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  BYOMEI-REC
               MOVE    ZERO                TO  FLG-BYOMEI
           ELSE
               INITIALIZE                      BYOMEI-REC
               MOVE    1                   TO  FLG-BYOMEI
           END-IF
      *
           .
       920-BYOMEI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           .
       300-END-EXT.
           EXIT.
      *
