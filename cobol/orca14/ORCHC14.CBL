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
       PROGRAM-ID.             ORCHC14.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 予約登録
      *  コンポーネント名  : 予約一覧表　印刷（ＨＣ１４）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  01/10/26    MCC−多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     02.03.18  帳票ファイル名の変更
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
           COPY    "HC14.INC".
      *
       WORKING-STORAGE             SECTION.
      *
      *     印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
      **** シェル用領域
      *    COPY    "CPCOMMONSHELL.INC".
      *
      *    シェル用領域
      *    COPY    "CPSHELLTBL.INC".
      **** COPY    "ORCA-DBPATH".
      *
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-YYK             PIC X(01).
           03  FLG-KNJHEN          PIC X(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
           03  FLG-SP              PIC 9(01).
           03  FLG-OK              PIC 9(01).
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
      *
           03  IDX2                PIC 9(02).
           03  IDX3                PIC 9(02).
           03  IDXP                PIC 9(02).
           03  IDXM                PIC 9(02).
           03  IDK                 PIC 9(04).
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME            PIC 9(08).
      *
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
           03  WRK-GOKTEN          PIC 9(11).
      *
           03  WRK-PTNUM           PIC X(20).
           03  WRK-PAGE            PIC 9(03).
           03  WRK-LINE            PIC 9(04).
      *
           03  WRK-ZZ9             PIC ZZ9.
           03  WRK-ZZZ9            PIC ZZZ9.
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
      *    出力先プリンタ名割り当て情報
           COPY  "CPSK1031.INC".
      *
      *    診療内容情報
           COPY    "CPSK1012.INC".
      *    診療科
           COPY    "CPSK1005.INC".
      *    職員情報
           COPY    "CPSK1010.INC".
      *    予約確認
           COPY    "CPSK0051.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    予約マスター
       01  YYK-REC.
           COPY    "CPYYK.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *    印刷パラメタ
           COPY    "CPORCSMKPRT.INC".
      *
      *
      *01  MCPDATA-REC                 PIC X(5000).
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    予約用ワークスパ領域
           COPY    "Y01COMMON-SPA".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPA-AREA
           SPA-Y01KYOUTU
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
           MOVE    ZERO                TO  WRK-PAGE
           MOVE    ZERO                TO  WRK-LINE
      *
      *    予約一覧編集
           INITIALIZE                  YYK-KEY
           INITIALIZE                  YYK-REC
           MOVE    SPA-HOSPID          TO  YYK-HOSPID
           MOVE    SPA-Y01-YYKYMDS     TO  YYK-YYKYMD
      *
           MOVE    YYK-REC             TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "YYK-KEY5"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "YYK-KEY5"          TO  ORC-DBPATH
               PERFORM 900-YOYAKU-READ-SEC
           ELSE
               MOVE    1               TO  FLG-YYK
           END-IF
           MOVE    ZERO                TO  IDX
           INITIALIZE                  HC14
           PERFORM
                   UNTIL       FLG-YYK     =   1
               IF     (YYK-YYKID           >   ZERO          )  AND
                      (YYK-YYKYMD          =   SPA-Y01-YYKYMDS )  AND
                      ((SPA-Y01-YYKID       =   ZERO )  OR
                      ((SPA-Y01-YYKID  NOT =   ZERO ) AND
                       (YYK-RAIINZUMI      =   SPACE) ))
                   ADD     1               TO  IDX
                   IF      IDX             >   34
      *                帳票印刷開始処理
                       PERFORM 200-HC14-PRINT-SEC
                       ADD     1           TO  IDX
                   END-IF
      *            明細編集処理
                   PERFORM 300-HC14-HEN-SEC
               END-IF
      *
               MOVE    "YYK-KEY5"          TO  ORC-DBPATH
               PERFORM 900-YOYAKU-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "YYK-KEY5"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF      IDX             >   ZERO
      *        帳票印刷開始処理
               PERFORM 200-HC14-PRINT-SEC
           END-IF
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
           MOVE    "HC14"              TO  HC01PARA-FORM-ID
           MOVE    SPA-TERMID          TO  HC01PARA-TERMID
           MOVE    SYS-TIME            TO  HC01PARA-SYOHMS
      *    変更★★★★★★
      *****MOVE    "001"               TO  HC01PARA-CNT
           MOVE    WRK-PAGE            TO  HC01PARA-CNT
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
           PERFORM 400-SYOKI-PRINT-SEC
      *
      *　　印刷用データ出力
           WRITE  HC14
      *
      ***** MOVE   "HC01.sh"           TO  SHELL-ID
      *     MOVE   "HC14.dia"          TO  SHELL-DIA
      *     MOVE   "HC14.def"          TO  SHELL-DEF
      *     MOVE   HC01PARA            TO  SHELL-DAT
      ***** MOVE   SYS-1031-PRTNM(7)   TO  SHELL-PRTNM 
            CLOSE                       PRT-FILE
      *
            INITIALIZE                 ORCSMKPRTAREA
            MOVE   "HC01.sh"           TO  MKPRT-ID
            MOVE   "HC14.dia"          TO  MKPRT-DIA
            MOVE   "HC14.def"          TO  MKPRT-DEF
            MOVE   HC01PARA            TO  MKPRT-DAT
            MOVE   SYS-1031-PRTNM(7)   TO  MKPRT-PRTNM
            CALL   "ORCSMKPRT"         USING
                                       ORCSMKPRTAREA
      *
      *     印刷用スクリプト処理
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
      **   CALL    "MCPSUB"            USING
      *            MCPAREA
      *****        MCPDATA-REC
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
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *    診療科
           MOVE    SPACE               TO  SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    YYK-SRYKA           TO  SYS-1005-KBNCD
           MOVE    ZERO                TO  SYS-1005-STYUKYMD
           MOVE    ALL "9"             TO  SYS-1005-EDYUKYMD
      *    システム管理検索
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
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
                   MOVE    MCPDATA-REC     TO  SYS-1005-REC
               END-IF
           ELSE
               INITIALIZE                  SYS-1005-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    診療日
           MOVE    SPA-Y01-YYKYMDS     TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
      *
           .
       100-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集処理
      *****************************************************************
       200-HC14-PRINT-SEC                SECTION.
      *
           ADD     1                   TO  WRK-PAGE
           MOVE    WRK-PAGE            TO  WRK-ZZ9
           MOVE    WRK-ZZ9             TO  HC14-PAGE
      *
           IF      SPA-Y01-YYKID       =   ZERO
               MOVE    "予約一覧表"        TO  HC14-TITLE
           ELSE
               MOVE    "未院一覧表"        TO  HC14-TITLE
           END-IF
      *    診療日
           MOVE    WRK-HENYMDG         TO  HC14-SRYYMD
      *
           PERFORM 400-PRINT-SEC
      *
           INITIALIZE                  HC14
           MOVE    ZERO                TO  IDX
           .
       200-HC14-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集処理
      *****************************************************************
       300-HC14-HEN-SEC                SECTION.
      *
      *    番号
           ADD     1                   TO  WRK-LINE
           MOVE    WRK-LINE            TO  WRK-ZZ9
           MOVE    WRK-ZZ9             TO  HC14-NUM   (IDX)
      *    患者番号
           PERFORM 3001-KNJNO-HENSYU-SEC
           MOVE    WRK-PTNUM           TO  HC14-PTNUM  (IDX)
      *    患者名称
           MOVE    YYK-NAME            TO  HC14-NAME   (IDX)
      *    予約時間
           MOVE    YYK-YYKTIME(1:2)    TO  HC14-YYKTIME (IDX)(1:2)
           MOVE    ":"                 TO  HC14-YYKTIME (IDX)(3:1)
           MOVE    YYK-YYKTIME(3:2)    TO  HC14-YYKTIME (IDX)(4:2)
      *    ドクター
      *    職員情報
           MOVE    SPACE               TO  SYS-1010-REC
           MOVE    "1010"              TO  SYS-1010-KANRICD
           MOVE    YYK-DRCD            TO  SYS-1010-KBNCD
           MOVE    SPA-Y01-YYKYMDS     TO  ORC-DBYMD
      *
           MOVE    SYS-1010-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF       MCP-RC              =   ZERO
                MOVE    "SYSKANRI-KEY"    TO  ORC-DBPATH
                PERFORM 900-KANRIMST-READ-SEC
                MOVE    MCPDATA-REC        TO  SYS-1010-REC
           ELSE
               INITIALIZE              SYS-1010-REC
                MOVE    1              TO  FLG-SYSKANRI
           END-IF
           MOVE    SYS-1010-NAME       TO  HC14-DRNAME (IDX)
      *
      *    診療科
           MOVE    SPACE               TO  SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    YYK-SRYKA           TO  SYS-1005-KBNCD
           MOVE    SPA-Y01-YYKYMDS     TO  ORC-DBYMD
      *
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF       MCP-RC             =   ZERO
                MOVE    "SYSKANRI-KEY"     TO  ORC-DBPATH
                PERFORM 900-KANRIMST-READ-SEC
                MOVE    MCPDATA-REC        TO  SYS-1005-REC
           ELSE
               INITIALIZE              SYS-1005-REC
                MOVE    1              TO  FLG-SYSKANRI
           END-IF
           MOVE    SYS-1005-SRYKANAME2     TO  HC14-SRYKA  (IDX)
      *
      *    診療内容をセット
           MOVE    SPACE               TO  SYS-1012-REC
           MOVE    "1012"              TO  SYS-1012-KANRICD
           MOVE    YYK-SRYNAIYO        TO  SYS-1012-KBNCD
           MOVE    SPA-Y01-YYKYMDS     TO  ORC-DBYMD
      *
           MOVE    SYS-1012-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF       MCP-RC             =   ZERO
                MOVE    "SYSKANRI-KEY"    TO  ORC-DBPATH
                PERFORM 900-KANRIMST-READ-SEC
                MOVE    MCPDATA-REC        TO  SYS-1012-REC
           ELSE
               INITIALIZE              SYS-1012-REC
                MOVE    1              TO  FLG-SYSKANRI
           END-IF
           MOVE    SYS-1012-SRYNAIYODSP    TO  HC14-SRYNAIYO  (IDX)
      *
      *    予約確認連絡コード
           MOVE    SPACE               TO  SYS-0051-REC
           MOVE    "0051"              TO  SYS-0051-KANRICD
           MOVE    YYK-KAKREN          TO  SYS-0051-KBNCD
           MOVE    SPA-Y01-YYKYMDS     TO  ORC-DBYMD
      *
           MOVE    SYS-0051-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF       MCP-RC             =   ZERO
                MOVE    "SYSKANRI-KEY"    TO  ORC-DBPATH
                PERFORM 900-KANRIMST-READ-SEC
                MOVE    MCPDATA-REC        TO  SYS-0051-REC
           ELSE
               INITIALIZE              SYS-0051-REC
                MOVE    1              TO  FLG-SYSKANRI
           END-IF
           MOVE    SYS-0051-YYKKAKNAME    TO  HC14-RENRAKU  (IDX)
      *    来院済み
           IF      YYK-RAIINZUMI       =   "1"
               MOVE    "済"            TO  HC14-RAIIN  (IDX)
           END-IF
      *
           EVALUATE    YYK-YYKKBN
               WHEN    "00"
                   MOVE    SPACE           TO  HC14-YOYAKUNAIY (IDX)
               WHEN    "01"
                   MOVE    "患者による予約"
                                           TO  HC14-YOYAKUNAIY (IDX)
               WHEN    "02"
                   MOVE    "医師による予約"
                                           TO  HC14-YOYAKUNAIY (IDX)
           END-EVALUATE
      *
           .
       310-HC14-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスタ編集処理
      *****************************************************************
       3001-KNJNO-HENSYU-SEC           SECTION.
      *
      *    患者番号変換より、患者IDより患者NOを取得する
      *
           INITIALIZE                      ORCSPTIDAREA
           MOVE    SPA-HOSPID          TO  SPTID-HOSPID
           MOVE    YYK-PTID            TO  SPTID-PTID
      *
           CALL    "ORCSPTID"          USING  ORCSPTIDAREA
                                              SPA-1009-TBL
           IF      SPTID-RC        NOT =   ZERO
               MOVE    SPACE           TO  WRK-PTNUM
           ELSE
               MOVE    SPTID-PTNUM     TO  WRK-PTNUM
           END-IF
      *
           .
       3001-KNJNO-HENSYU-EXT.
           EXIT.
      *
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
      *    予約マスター読込
      *****************************************************************
       900-YOYAKU-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-YYK
               MOVE    MCPDATA-REC         TO  YYK-REC
           ELSE
               MOVE    1                   TO  FLG-YYK
           END-IF
           .
      *
       900-YOYAKU-READ-EXT.
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
