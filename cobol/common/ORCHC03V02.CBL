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
       PROGRAM-ID.             ORCHC03V02.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者登録
      *  コンポーネント名  : 請求書兼領収書　印刷（ＨＣＮ０３Ｖ０２）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/01/29    NACL−小豆沢  新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-小豆沢  04/01/29  保険適用外の記載と消費税対応
      *****************************************************************
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
      *****COPY    "HC03.INC".
           COPY    "HCM03V02.INC"  REPLACING   //HCM03V02//
                                   BY          //HC03//.
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
           03  FLG-PARA            PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-SYUNOU          PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01).
           03  FLG-PTRSIINF        PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
           03  FLG-SP              PIC 9(01).
           03  FLG-OK              PIC 9(01).
           03  FLG-CHK             PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDX-Z               PIC 9(04).
           03  IDX-S               PIC 9(04).
           03  IDX-MAX             PIC 9(04).
           03  IDXA                PIC 9(04).
           03  IDX-ACT             PIC 9(02).
           03  IDX-REN             PIC 9(04).
           03  IDX-JYU             PIC 9(04).
           03  IDX-JIHI            PIC 9(04).
      *
           03  IDX2                PIC 9(02).
           03  IDX3                PIC 9(02).
           03  IDXP                PIC 9(02).
           03  IDXM                PIC 9(02).
           03  IDK                 PIC 9(04).
           03  IDX2-1              PIC 9(01).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME            PIC 9(08).
      *
      *    一時領域
       01  WRK-AREA.
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
      *
           03  WRK-HKNCOMBI        PIC X(40).
      *
           03  WRK-SKYMONEY        PIC S9(11).
           03  WRK-MISYUMONEY      PIC S9(11).
           03  WRK-MISYU           PIC S9(11).
           03  WRK-GOKTEN          PIC S9(11).
      *
           03  WRK-DENPNUM         PIC 9(07).
      *
           03  WRK-WARI            PIC 9(02)V9.
      *****03  WRK-Z6              PIC ZZZZZZ.
      *****03  WRK-Z62             PIC ZZZ9.9.
           03  WRK-Z6              PIC ZZZ.
           03  WRK-Z62             PIC 9.9.
      *
           03  WRK-ZZZ             PIC ZZZ.
           03  WRK-NO              PIC Z(7).
           03  WRK-Z7-G.
               05  WRK-FIL             PIC X(09).
               05  WRK-Z7              PIC Z,ZZZ,ZZZ.
           03  WRK-Z72-G.
      *****    05  WRK-FIL2            PIC X(09).
      ****     05  WRK-Z72             PIC -,---,---.
               05  WRK-FIL2            PIC X(18).
           03  WRK-Z72                 PIC S9(07).
           03  WRK-Z72-H               PIC Z,ZZZ,ZZZ.
           03  WRK-Z72-HS              REDEFINES   WRK-Z72-H
                                       PIC -,---,---.
      *    自費集計
           03  WRK-JIHI-REC.
               05  WRK-JIHI            PIC S9(07)   OCCURS  5.
           03  WRK-JIHI-TOTAL          PIC S9(08).
      *
      *    複数科まとめ集計
           03  WRK-HKNTEN-KIN              PIC 9(07).
           03  WRK-HKNTEN-KEI              PIC 9(07)V99.
           03  WRK-NYUKIN                  PIC 9(07).
      *
           03  WRK-SRYKA-MEI               PIC X(30).
      *
      *    文字変換
           03  WRK-ZENKAKU-G.
               05  WRK-ZENKAKU         PIC X(02)   OCCURS   10.
           03  WRK-MOJI                PIC X(10).
           03  WRK-MOJISU              PIC 9(02).
      *
      *   日本語数字
       01  TBL-SUJI-AREA.
           03  FILLER          PIC X(20)   VALUE
              "１２３４５６７８９０".
       01  TBL-SUJI-R          REDEFINES   TBL-SUJI-AREA.
           03  TBL-SUJI        PIC X(02)   OCCURS   10.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    医療機関情報−基本情報 
           COPY    "CPSK1001.INC".
      *    医療機関情報−所在地、連絡先 
           COPY    "CPSK1002.INC".
      *
           COPY    "CPSK1005.INC".
      *
           COPY    "CPSK1010.INC".
      *
           COPY    "CPSK1013.INC".
      *
      *    労災医療機関情報
           COPY    "CPSK4001.INC".
      *
      *    出力先プリンタ名割り当て情報
           COPY  "CPSK1031.INC".
      *
      *    患者マスタ
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    保険マスタ
       01  PTHKNINF-REC.
           COPY    "CPPTHKNINF.INC".
      *
      *    収納
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    保険組合せ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    保険マスタ
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *    診療行為マスタ−
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    診療会計マスタ−
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    受診履歴
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *    保存用収納ワーク
       01  WRK-SYUNOU-REC.
           COPY    "CPSYUNOU.INC"  REPLACING
                                     //SYU-// BY //WRK-SYU-//.
      *
      *    患者労災保険情報
       01  PTRSIINF-REC.
           COPY    "CPPTRSIINF.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    印刷パラメタ
           COPY    "CPORCSMKPRT.INC".
      *
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
      *
      *01  MCPDATA-REC                 PIC X(5000).
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
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
      *    処方箋共通パラメタ
           COPY    "CPORCHC03.INC".
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           ORCHC03AREA
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
      *
      *    各ＤＢ読込
           PERFORM 100-SYORI-SEC
      *
      *    帳票印刷開始処理
           PERFORM 400-SYOKI-PRINT-SEC
      *
      *    帳票編集処理
           PERFORM 300-HC03-HEN-SEC
      *
      *    帳票印刷処理
           PERFORM 400-PRINT-SEC
      *
           .
       000-PROC-EXT.
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    帳票印刷開始処理
      *****************************************************************
       400-SYOKI-PRINT-SEC             SECTION.
      *
      *    ファイルＯＰＥＮ
           MOVE    "HC03"              TO  HC01PARA-FORM-ID
           MOVE    SPA-TERMID          TO  HC01PARA-TERMID
           MOVE    SYS-TIME            TO  HC01PARA-SYOHMS
      *    変更★★★★★★
           MOVE    "001"               TO  HC01PARA-CNT
           OPEN    OUTPUT               PRT-FILE
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
      *
      *　　印刷用データ出力
              WRITE  HC03
      *
      ******MOVE   "HC01.sh"           TO  SHELL-ID
      *     MOVE   "HC03.dia"          TO  SHELL-DIA
      *     MOVE   "HC03.def"          TO  SHELL-DEF
      *     MOVE   HC01PARA            TO  SHELL-DAT
      ***** MOVE   SYS-1031-PRTNM(3)   TO  SHELL-PRTNM 
            CLOSE                       PRT-FILE
      *
            INITIALIZE                 ORCSMKPRTAREA
            MOVE   "HC01.sh"           TO  MKPRT-ID
      ***** MOVE   "HC03.dia"          TO  MKPRT-DIA
      ***** MOVE   "HC03.def"          TO  MKPRT-DEF
            MOVE   "HCM03V02.red"      TO  MKPRT-DIA
            MOVE   SPACE               TO  MKPRT-DEF
            MOVE   HC01PARA            TO  MKPRT-DAT
            MOVE   SYS-1031-PRTNM(3)   TO  MKPRT-PRTNM
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
      **********   MCPDATA-REC
      *
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
      *    医療機関情報−所在地、連絡先
           MOVE    SPACE               TO  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    ZERO                TO  SYS-1001-STYUKYMD
           MOVE    ALL "9"             TO  SYS-1001-EDYUKYMD
      *    システム管理検索
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
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
                   MOVE    MCPDATA-REC     TO  SYS-1001-REC
               END-IF
           ELSE
               INITIALIZE                  SYS-1001-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *
      *    医療機関情報−所在地、連絡先
           MOVE    SPACE               TO  SYS-1002-REC
           MOVE    "1002"              TO  SYS-1002-KANRICD
           MOVE    "*"                 TO  SYS-1002-KBNCD
           MOVE    ZERO                TO  SYS-1002-STYUKYMD
           MOVE    ALL "9"             TO  SYS-1002-EDYUKYMD
      *    システム管理検索
           MOVE    SYS-1002-REC        TO  MCPDATA-REC
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
                   MOVE    MCPDATA-REC     TO  SYS-1002-REC
               END-IF
           ELSE
               INITIALIZE                  SYS-1002-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    出力先プリンタ名割り当て情報編集
           INITIALIZE                      SYS-1031-REC
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "2"                 TO  ORCSPRTNM-KBN
           MOVE    SPA-SRYYMD          TO  ORCSPRTNM-SRYYMD
           MOVE    "2"                 TO  ORCSPRTNM-NYUGAIKBN
           CALL    "ORCSPRTNM"         USING
                                           ORCSPRTNMAREA
                                           SPA-AREA
                                           SYS-1031-REC
      *
      **** 出力先プリンタ名割り当て情報編集
      *    MOVE    SPACE               TO  SYS-1031-REC
      *    INITIALIZE                  SYS-1031-REC
      *    MOVE    "1031"              TO  SYS-1031-KANRICD
      *    MOVE    "*"                 TO  SYS-1031-KBNCD
      *    MOVE    SYS-1031-REC        TO  MCPDATA-REC
      *    MOVE    "DBSELECT"          TO  MCP-FUNC
      *    MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
      *    MOVE    SPA-SRYYMD          TO  ORC-DBYMD
      *    CALL    "ORCMCPSUB"          USING
      *                                 MCPAREA
      *                                 ORCMCPAREA
      *                                 MCPDATA-REC
      *    IF      MCP-RC              =   ZERO
      *        MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
      *        PERFORM 900-KANRIMST-READ-SEC
      *        IF      MCP-RC              =   ZERO
      *            MOVE    MCPDATA-REC     TO  SYS-1031-REC
      *        END-IF
      *    ELSE
      *        INITIALIZE                  SYS-1031-REC
      *        MOVE    1               TO  FLG-SYSKANRI
      *    END-IF
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
      *    CALL    "ORCMCPSUB"          USING
      *                                 MCPAREA
      *                                 ORCMCPAREA
      *****                             MCPDATA-REC
      *
      *    労災医療機関情報編集
           MOVE    SPACE               TO  SYS-4001-REC
           INITIALIZE                  SYS-4001-REC
           MOVE    "4001"              TO  SYS-4001-KANRICD
           MOVE    "*"                 TO  SYS-4001-KBNCD
           MOVE    SYS-4001-REC        TO  MCPDATA-REC
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
                   MOVE    MCPDATA-REC     TO  SYS-4001-REC
               END-IF
           ELSE
               INITIALIZE                  SYS-4001-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    収納マスタ検索
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-PTID            TO  SYU-PTID
           MOVE    ORCHC03-DENPNUM     TO  SYU-DENPNUM
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           MOVE    SPACE                TO  WRK-SRYKA-MEI
      *    診療科名編集
           PERFORM 1000-SRYKAMEI-HEN-SEC
      *
      *    複数科まとめがある時、収納を集計する
           IF      ORCHC03-FUKU-DENPNUM    NOT =   ZERO
               PERFORM 1001-FUKU-SYUNOU-SEC
           END-IF
      *
      *    保険組合せマスター検索
           INITIALIZE                      HKNCOMBI-REC
           MOVE    SPA-HOSPID          TO  COMB-HOSPID
           MOVE    SPA-PTID            TO  COMB-PTID
           MOVE    SYU-HKNCOMBINUM     TO  COMB-HKNCOMBINUM
           PERFORM 910-HKNCOMBI-READ-SEC
           IF      FLG-HKNCOMBI        =   1
                DISPLAY "*** HKNCOMBI  ERR:"   COMB-KEY "."
           END-IF
           PERFORM 1001-HKNCOMBI-HEN-SEC
      *
           IF    ( COMB-HKNNUM         =   "971" OR "973" )
      *
      *        患者労災保険情報検索
               INITIALIZE                      PTRSIINF-REC
               MOVE    SPA-HOSPID          TO  PTRSI-HOSPID
               MOVE    SPA-PTID            TO  PTRSI-PTID
               MOVE    COMB-HKNID          TO  PTRSI-HKNID
               PERFORM 910-PTRSIINF-READ-SEC
           ELSE
               INITIALIZE                      PTRSIINF-REC
           END-IF
      *
      *
           .
       100-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ名称編集処理
      *****************************************************************
       1001-HKNCOMBI-HEN-SEC             SECTION.
      *
           MOVE    SPACE               TO  WRK-HKNCOMBI
      *
           STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                   "　"                    DELIMITED  BY  SIZE
                   COMB-KOH1-TANSEIDONAME  DELIMITED  BY  SPACE
                   "　"                    DELIMITED  BY  SIZE
                   COMB-KOH2-TANSEIDONAME  DELIMITED  BY  SPACE
                   "　"                    DELIMITED  BY  SIZE
                   COMB-KOH3-TANSEIDONAME  DELIMITED  BY  SPACE
                   "　"                    DELIMITED  BY  SIZE
                   COMB-KOH4-TANSEIDONAME  DELIMITED  BY  SPACE
                         INTO              WRK-HKNCOMBI
           END-STRING
      *
           .
       1001-HKNCOMBI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科名編集処理
      *****************************************************************
       1000-SRYKAMEI-HEN-SEC                SECTION.
      *
      *    診療科
           MOVE    SPACE               TO  SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    SYU-SRYKA           TO  SYS-1005-KBNCD
           MOVE    ZERO                TO  SYS-1005-STYUKYMD
           MOVE    ALL "9"             TO  SYS-1005-EDYUKYMD
      *    システム管理検索
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
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
           ELSE
               INITIALIZE                  SYS-1005-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI              =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1005-REC
               IF      WRK-SRYKA-MEI       =   SPACE
                   MOVE    SYS-1005-SRYKANAME2
                                               TO  WRK-SRYKA-MEI
               ELSE
                   IF      WRK-SRYKA-MEI(19:2) NOT =   SPACE
                       CONTINUE
                   ELSE
                       STRING  WRK-SRYKA-MEI   DELIMITED  BY  SPACE
                               "、"            DELIMITED  BY  SIZE
                               SYS-1005-SRYKANAME2
                                               DELIMITED  BY  SPACE
                               INTO                WRK-SRYKA-MEI
                       END-STRING
                   END-IF
               END-IF
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
       1000-SRYKAMEI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    複数科まとめ編集処理
      *****************************************************************
       1001-FUKU-SYUNOU-SEC                SECTION.
      *
           MOVE    SPACE                TO  WRK-SRYKA-MEI
           INITIALIZE                  WRK-SYUNOU-REC
      *
      *    収納マスタ検索
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-PTID            TO  SYU-PTID
           MOVE    ORCHC03-FUKU-DENPNUM
                                       TO  SYU-FUKU-DENPNUM
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY12"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYUNOU-KEY12"      TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
           MOVE    ZERO                TO  FLG-CHK
           PERFORM UNTIL    FLG-SYUNOU     =   1
      *
               IF      FLG-CHK             =   ZERO
                   MOVE    SYUNOU-REC          TO  WRK-SYUNOU-REC
      *            入金額はクリアしておく
                   MOVE    ZERO                TO  WRK-SYU-NYUKIN-TOTAL
                   MOVE    ZERO                TO  WRK-SYU-CHOSEI
                   MOVE    1                   TO  FLG-CHK
               ELSE
                   PERFORM 10011-SYUNOU-ADD-SEC
               END-IF
      *        今回入力分以外の入金額集計
               IF      SYU-DENPNUM     NOT =   ORCHC03-DENPNUM
      *            入金額
                   ADD     SYU-NYUKIN-TOTAL    TO  WRK-SYU-NYUKIN-TOTAL
      *            調整金
                   ADD     SYU-CHOSEI          TO  WRK-SYU-CHOSEI
               END-IF
      *
      *        診療科名編集
               PERFORM 1000-SRYKAMEI-HEN-SEC
      *
               MOVE    "SYUNOU-KEY12"      TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    調整金
           COMPUTE WRK-SYU-CHOSEI       =   WRK-SYU-CHOSEI
                                        +   ORCHC03-KON-CHOSEI
      *    保険適用金額再計算
      *
      *    集計の点数から負担額計算
           COMPUTE WRK-HKNTEN-KEI      =  (WRK-SYU-TOTAL-HKNTEN  *  10 )
                                       *  (SPA-FTNRATE   /  100)
           COMPUTE WRK-HKNTEN-KIN      =  (WRK-HKNTEN-KEI
                                       +   5  )
                                       /   10
           COMPUTE WRK-HKNTEN-KIN      =   WRK-HKNTEN-KIN
                                       *   10
           MOVE    WRK-HKNTEN-KIN      TO  WRK-SYU-HKNTEKMONEY
      *
      *    合計した収納を編集
           MOVE    WRK-SYUNOU-REC       TO  SYUNOU-REC
      *
           .
       1001-FUKU-SYUNOU-EXT.
           EXIT.
      *
      *****************************************************************
      *    合計請求額計算処理
      *****************************************************************
       10011-SYUNOU-ADD-SEC           SECTION.
      *
      *    請求額
           ADD     SYU-SKYMONEY        TO  WRK-SYU-SKYMONEY
      *    点数
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   12
               ADD     SYU-HKNTEN (IDX)    TO  WRK-SYU-HKNTEN (IDX)
               ADD     SYU-MONEY  (IDX)    TO  WRK-SYU-MONEY  (IDX)
               ADD     SYU-TGMONEY (IDX)   TO  WRK-SYU-TGMONEY(IDX)
               ADD     SYU-TGMONEY-TAX (IDX)
                                           TO  WRK-SYU-TGMONEY-TAX(IDX)
           END-PERFORM
      *    自費
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               ADD     SYU-JIHI-TAXNASI (IDX)
                                           TO  WRK-SYU-JIHI-TAXNASI(IDX)
               ADD     SYU-JIHI-TAXARI (IDX)
                                           TO  WRK-SYU-JIHI-TAXARI (IDX)
           END-PERFORM
           ADD     SYU-JIHI-TOTAL      TO  WRK-SYU-JIHI-TOTAL
           ADD     SYU-JIHI-TOTAL-TAX  TO  WRK-SYU-JIHI-TOTAL-TAX
           ADD     SYU-JIHI-TAX        TO  WRK-SYU-JIHI-TAX
      *
      *    各金額
           ADD     SYU-RJN-FTN         TO  WRK-SYU-RJN-FTN
           ADD     SYU-KOH-FTN         TO  WRK-SYU-KOH-FTN
           ADD     SYU-YKZ-FTN         TO  WRK-SYU-YKZ-FTN
           .
       10011-SYUNOU-ADD-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集処理
      *****************************************************************
       300-HC03-HEN-SEC                SECTION.
      *
           INITIALIZE                  HC03
      *
      *    伝票番号
           MOVE    ORCHC03-DENPNUM     TO  WRK-NO  
           MOVE    WRK-NO              TO  HC03-NO
      *    診療科
      *****MOVE    SYS-1005-SRYKANAME2 TO  HC03-MIDASI
           MOVE    WRK-SRYKA-MEI(1:20) TO  HC03-MIDASI
      *    患者番号
           MOVE    SPA-PTNUM           TO  HC03-KNJNO
      *    患者名称
           MOVE    SPA-NAME            TO  HC03-KNJNAMW
      *    保険種別
           MOVE    WRK-HKNCOMBI        TO  HC03-HOKEN
      *    負担割合
           IF      SYU-PTFTNRATE       >   ZERO
               COMPUTE WRK-WARI        =   SYU-PTFTNRATE   /   10
               IF      SYU-PTFTNRATE(3:1)  =   ZERO
                   MOVE    WRK-WARI            TO  WRK-Z6
                   MOVE    WRK-Z6              TO  HC03-FUTAN
               ELSE
                   MOVE    WRK-WARI            TO  WRK-Z62
                   MOVE    WRK-Z62             TO  HC03-FUTAN
               END-IF
           END-IF
      *    診療日
           MOVE    SYU-SRYYMD          TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  HC03-SRYYMD
      *    発行日
           MOVE    SYU-DENPPRTYMD      TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  HC03-HAKYMD
      *
      *    医療機関住所
           MOVE    SYS-1002-ADRS       TO  HC03-IRYOADRS
      *    医療機関名
           MOVE    SYS-1001-HOSPNAME   TO  HC03-IRYOMEI
      *    医療機関ＴＥＬ
           MOVE    SYS-1002-TEL        TO  HC03-IRYOTEL
      *    自費名称編集
           PERFORM 3102-JIHIMSG-HEN-SEC
      *
           MOVE    SPACE               TO  WRK-Z7-G
           MOVE    SPACE               TO  WRK-Z72-G
      *    診療科
           MOVE    SYU-HKNTEN (01)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO1
      *    指導科
           MOVE    SYU-HKNTEN (02)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO2
      *    在宅科
           MOVE    SYU-HKNTEN (03)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO3
      *    投薬科
           MOVE    SYU-HKNTEN (04)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO4
      *    注射科
           MOVE    SYU-HKNTEN (05)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO5
      *    処置科
           MOVE    SYU-HKNTEN (06)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO6
      *    手術科
           MOVE    SYU-HKNTEN (07)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO7
      *    検査科
           MOVE    SYU-HKNTEN (08)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO8
      *    Ｘ線科
           MOVE    SYU-HKNTEN (09)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G          TO  HC03-HKNRYO9
      *    その他料
           MOVE    SYU-HKNTEN (10)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HKNRYO10
      *    合計点数
           COMPUTE WRK-GOKTEN          =   SYU-HKNTEN (01)
                                       +   SYU-HKNTEN (02)
                                       +   SYU-HKNTEN (03)
                                       +   SYU-HKNTEN (04)
                                       +   SYU-HKNTEN (05)
                                       +   SYU-HKNTEN (06)
                                       +   SYU-HKNTEN (07)
                                       +   SYU-HKNTEN (08)
                                       +   SYU-HKNTEN (09)
                                       +   SYU-HKNTEN (10)
           MOVE    WRK-GOKTEN          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-GOKTEN
      *
      *    労災・自賠の時、点数表示なし
           IF    ( COMB-HKNNUM             =    "971"  OR  "973" )
               MOVE    SPACE               TO  HC03-HKNRYO1
               MOVE    SPACE               TO  HC03-HKNRYO2
               MOVE    SPACE               TO  HC03-HKNRYO3
               MOVE    SPACE               TO  HC03-HKNRYO4
               MOVE    SPACE               TO  HC03-HKNRYO5
               MOVE    SPACE               TO  HC03-HKNRYO6
               MOVE    SPACE               TO  HC03-HKNRYO7
               MOVE    SPACE               TO  HC03-HKNRYO8
               MOVE    SPACE               TO  HC03-HKNRYO9
               MOVE    SPACE               TO  HC03-HKNRYO10
               MOVE    ALL "*"             TO  HC03-GOKTEN
           END-IF
      *
      *    保険適用分
           MOVE    SYU-HKNTEKMONEY     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HOKENBUN
      *
      *    保険適用外編集
           PERFORM     VARYING   IDX-JIHI FROM  1  BY  1
                       UNTIL     IDX  >  10
               MOVE   ZERO      TO    WRK-Z72
               COMPUTE   WRK-Z72   =   SYU-TGMONEY(IDX-JIHI)  +
                                       SYU-TGMONEY-TAX(IDX-JIHI)
               PERFORM   800-HENKAN-SEC
               MOVE    WRK-Z72-G           TO  HC03-JIHIBUN(IDX-JIHI)
           END-PERFORM
      *
      *    保険適用外消費税（再掲）
           MOVE    SYU-TGMONEY-TAX-SAI     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G               TO  HC03-HOKENZEI
      *
           IF    ( COMB-HKNNUM             =    "971"
                                           OR   "973" )
      *        労災・自賠の時、点数表示なし
               EVALUATE    TRUE
               WHEN      ( COMB-HKNNUM             =    "971" )
                   AND   ( SYS-4001-RSIIRYOKBN NOT =   "1" )
      *
               WHEN      ( COMB-HKNNUM             =    "973" )
                   AND   ( PTRSI-HKNKBN        =    "4" ) 
                   AND   ( SYU-PTFTNRATE   NOT =   ZERO  )
      *
                   COMPUTE WRK-GOKTEN      =    SYU-HKNTEKMONEY
                                           +    SYU-RSISHOSHIN-MONEY
                                           +    SYU-RSISAISHIN-MONEY
                                           +    SYU-RSISDO-MONEY
                                           +    SYU-RSIETC-MONEY
                   MOVE    WRK-GOKTEN      TO  WRK-Z72
                   PERFORM 800-HENKAN-SEC
                   MOVE    WRK-Z72-G           TO  HC03-HOKENBUN
               WHEN    OTHER
                   MOVE    SPACE               TO  HC03-HOKENBUN
               END-EVALUATE
           END-IF
      *
      *    保険適用外分
           MOVE    ZERO                TO  WRK-GOKTEN
      **** PERFORM VARYING     IDX     FROM    1   BY  1
      *            UNTIL       IDX     >   10
      *        COMPUTE WRK-GOKTEN      =   WRK-GOKTEN
      *                                +  (SYU-TGMONEY (IDX)
      *                                +   SYU-TGMONEY-TAX  (IDX) )
      *****END-PERFORM
           COMPUTE WRK-GOKTEN          =   SYU-TGMONEY (12)
                                       +   SYU-TGMONEY-TAX  (12)
      *****MOVE    SYU-TOTAL-TGMONEY   TO  WRK-Z72
           MOVE    WRK-GOKTEN          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-HOKENGAI
      *    自費１
           MOVE    ZERO                TO  WRK-JIHI-REC
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               COMPUTE WRK-JIHI (IDX)      =   SYU-JIHI-TAXNASI (IDX)
                                           +   SYU-JIHI-TAXARI  (IDX)
           END-PERFORM
      *
           MOVE    WRK-JIHI (1)        TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-JIHI1
           MOVE    WRK-JIHI (2)        TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-JIHI2
           MOVE    WRK-JIHI (3)        TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-JIHI3
           MOVE    WRK-JIHI (4)        TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-JIHI4
           MOVE    WRK-JIHI (5)        TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-JIHI5
      *    自費計
           COMPUTE WRK-JIHI-TOTAL      =   SYU-JIHI-TOTAL
                                       +   SYU-JIHI-TOTAL-TAX
           MOVE    WRK-JIHI-TOTAL      TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-JIHI6
      *    自費消費税
           MOVE    SYU-JIHI-TAX        TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-JIHI7
      *    自費合計
           COMPUTE WRK-GOKTEN          =   WRK-JIHI-TOTAL
                                       +   SYU-JIHI-TAX
           MOVE    WRK-GOKTEN          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-JIHI8
      *    薬剤一部負担
           MOVE    SYU-YKZ-FTN         TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-YAKUZAI
      *    老人一部負担金
           MOVE    SYU-RJN-FTN         TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-ROUJIN
      *    公費一部負担金
           MOVE    SYU-KOH-FTN         TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-KOUHI
      *    複数科まとめの時、＊とする
           IF      ORCHC03-FUKU-DENPNUM    >   ZERO
               IF      SYU-RJN-FTN         >   ZERO
                   MOVE    ALL "*"             TO  HC03-ROUJIN
               END-IF
               IF      SYU-KOH-FTN         >   ZERO
                   MOVE    ALL "*"             TO  HC03-KOUHI
               END-IF
           END-IF
      *
      *    調整金
           MOVE    SYU-CHOSEI          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-CHOSEI
      *    今回請求額
           MOVE    ORCHC03-SEIKYU      TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-KONSEIKYU
           MOVE    ORCHC03-SEIKYU      TO  WRK-SKYMONEY
      *    複数科まとめの時、まとめ額
           IF      ORCHC03-FUKU-DENPNUM    >   ZERO
               MOVE    ORCHC03-KON-SEIKYU  TO  WRK-Z72
               PERFORM 800-HENKAN-SEC
               MOVE    WRK-Z72-G           TO  HC03-KONSEIKYU
               MOVE    ORCHC03-KON-SEIKYU  TO  WRK-SKYMONEY
           END-IF
      *
      *    今回入金額
      *****MOVE    SYU-NYUKIN-TOTAL    TO  WRK-Z7
           MOVE    ORCHC03-NYUKIN      TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-KONNYUKIN
      *    複数科まとめの時、まとめ額
           IF      ORCHC03-FUKU-DENPNUM    >   ZERO
               MOVE    SPACE               TO  HC03-KONNYUKIN
               MOVE    SPACE               TO  WRK-Z7-G
               COMPUTE WRK-NYUKIN          =   SYU-NYUKIN-TOTAL
                                           +   ORCHC03-NYUKIN
               MOVE    WRK-NYUKIN          TO  WRK-Z72
               PERFORM 800-HENKAN-SEC
               MOVE    WRK-Z72-G          TO  HC03-KONNYUKIN
           END-IF
      *    前回未収額計算
      *!!! PERFORM 3101-MISYU-HEN-SEC
           MOVE    ORCHC03-ZENMISYU    TO  WRK-MISYUMONEY
           MOVE    WRK-MISYUMONEY      TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-ZENMISYU
      *    合計請求額
           COMPUTE WRK-GOKTEN          =   WRK-SKYMONEY
                                       +   WRK-MISYUMONEY
           MOVE    WRK-GOKTEN          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HC03-GOUKEIGAK
      *
      *    発行区分
           EVALUATE    ORCHC03-HAKKOFLG
               WHEN    1
                   MOVE    "（再）"        TO  HC03-MIDASHI
               WHEN    2
                   MOVE    "（訂正）"      TO  HC03-MIDASHI
           END-EVALUATE
      *
           .
       300-HC03-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    半角全角変換処理
      *****************************************************************
       800-HENKAN-SEC             SECTION.
     *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"                 TO  KANACHK-SYORI
      *****MOVE    WRK-Z72             TO  KANACHK-MAE-INPUT
           IF      WRK-Z72             <   ZERO
               MOVE    WRK-Z72             TO  WRK-Z72-HS
               MOVE    WRK-Z72-HS          TO  KANACHK-MAE-INPUT
           ELSE
               MOVE    WRK-Z72             TO  WRK-Z72-H
               MOVE    WRK-Z72-H           TO  KANACHK-MAE-INPUT
           END-IF
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF      KANACHK-RC          =   ZERO
               MOVE    KANACHK-OUT-INPUT(1:18)    TO  WRK-Z72-G
           END-IF
           .
       800-HENKAN-EXT.
           EXIT.
      *
      *****************************************************************
      *    未収金額編集処理
      *****************************************************************
       3101-MISYU-HEN-SEC             SECTION.
      *
           MOVE    ZERO                TO  WRK-MISYUMONEY
           MOVE    SYU-DENPNUM         TO  WRK-DENPNUM
      *    収納テーブル読み込み
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-PTID            TO  SYU-PTID
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
           MOVE    ZERO                TO  WRK-MISYUMONEY
           PERFORM
               UNTIL     FLG-SYUNOU    =   1
               IF      ORCHC03-FUKU-DENPNUM    =   ZERO
                   IF      SYU-DENPNUM     NOT =   WRK-DENPNUM
                       COMPUTE WRK-MISYU       =   SYU-SKYMONEY
                                               -   SYU-NYUKIN-TOTAL
                       ADD     WRK-MISYU           TO  WRK-MISYUMONEY
                   END-IF
               ELSE
                   IF      SYU-FUKU-DENPNUM    =   ORCHC03-FUKU-DENPNUM
                       CONTINUE
                   ELSE
                       COMPUTE WRK-MISYU       =   SYU-SKYMONEY
                                               -   SYU-NYUKIN-TOTAL
                       ADD     WRK-MISYU           TO  WRK-MISYUMONEY
                   END-IF
               END-IF
      *
               MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       3101-MISYU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    自費名称編集処理
      *****************************************************************
       3102-JIHIMSG-HEN-SEC             SECTION.
      *
      *    医療機関情報−所在地、連絡先
           MOVE    SPACE               TO  SYS-1013-REC
           MOVE    "1013"              TO  SYS-1013-KANRICD
           MOVE    ZERO                TO  SYS-1013-STYUKYMD
           MOVE    ALL "9"             TO  SYS-1013-EDYUKYMD
      *    システム管理検索
           MOVE    SYS-1013-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-1013-REC
               END-IF
           ELSE
               INITIALIZE                  SYS-1013-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           PERFORM
               UNTIL       FLG-SYSKANRI    =   1
               IF      SPA-NYUGAIKBN       =   SYS-1013-KBNCD(1:1)
                   EVALUATE    SYS-1013-KBNCD(2:1)
                       WHEN    "1"
                           MOVE    SYS-1013-JIHINAME   TO  HC03-JIHIMSG1
                       WHEN    "2"
                           MOVE    SYS-1013-JIHINAME   TO  HC03-JIHIMSG2
                       WHEN    "3"
                           MOVE    SYS-1013-JIHINAME   TO  HC03-JIHIMSG3
                       WHEN    "4"
                           MOVE    SYS-1013-JIHINAME   TO  HC03-JIHIMSG4
                       WHEN    "5"
                           MOVE    SYS-1013-JIHINAME   TO  HC03-JIHIMSG5
                   END-EVALUATE
               END-IF
      *
               MOVE    "SYSKANRI-KEY2"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-1013-REC
               END-IF
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       3102-JIHIMSG-HEN-EXT.
           EXIT.
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       31012-SEIWA-HEN-SEC        SECTION.
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG
           .
       31012-SEIWA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    全角変換処理
      *****************************************************************
       2009-HENKAN-SEC                 SECTION.
      *
           MOVE    ALL "　"            TO  WRK-ZENKAKU-G
      *
           PERFORM VARYING     IDK     FROM    1   BY  1
                   UNTIL       IDK     >   WRK-MOJISU
               IF      WRK-MOJI (IDK:1)    NUMERIC
                   MOVE    WRK-MOJI(IDK:1)     TO  IDX2-1
                   IF      IDX2-1              =   ZERO
                       MOVE    10                  TO  IDX2
                   ELSE
                       MOVE    IDX2-1              TO  IDX2
                   END-IF
                   MOVE    TBL-SUJI (IDX2)     TO  WRK-ZENKAKU(IDK)
               ELSE
                   IF      WRK-MOJI (IDK:1)    =   "."
                       MOVE    "．"            TO  WRK-ZENKAKU(IDK)
                   END-IF
               END-IF
           END-PERFORM
           .
       2009-HENKAN-EXT.
           EXIT.
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
      *
      *****************************************************************
      *    患者マスター読み込み
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTINF-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  PTINF-REC
                   MOVE    ZERO            TO  FLG-PTINF
               ELSE
                   MOVE    1               TO  FLG-PTINF
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTINF
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *****************************************************************
      *    収納マスター読込
      *****************************************************************
       980-SYUNOU-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
               MOVE    ZERO            TO  FLG-SYUNOU
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
           .
       980-SYUNOU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスター読み込み
      *****************************************************************
       910-HKNCOMBI-READ-SEC         SECTION.
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  HKNCOMBI-REC
                   MOVE    ZERO            TO  FLG-HKNCOMBI
               ELSE
                   MOVE    1               TO  FLG-HKNCOMBI
               END-IF
           ELSE
               MOVE    1               TO  FLG-HKNCOMBI
           END-IF
     *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       910-HKNCOMBI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者労災保険情報読み込み
      *****************************************************************
       910-PTRSIINF-READ-SEC         SECTION.
      *
           MOVE    PTRSIINF-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  PTRSIINF-REC
                   MOVE    ZERO            TO  FLG-PTRSIINF
               ELSE
                   MOVE    1               TO  FLG-PTRSIINF
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTRSIINF
           END-IF
     *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       910-PTRSIINF-READ-EXT.
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
