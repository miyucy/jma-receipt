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
       PROGRAM-ID.             ORCHCN03.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院
      *  コンポーネント名  : 入院請求書兼領収書　印刷（ＨＣＭＮ０３）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/10/24    NACL−森脇    新規作成
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
      *    印刷用データ
           SELECT  PRT-FILE        ASSIGN  HC01PARA
                                   FILE    STATUS  IS  STS-PARA.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    印刷用データ
       FD  PRT-FILE.
           COPY    "HCN03.INC".
      *
       WORKING-STORAGE             SECTION.
      *
      *     印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
      *
      *    ステータス領域
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
           03  WRK-Z6              PIC ZZZZZZ.
           03  WRK-Z62             PIC ZZZ9.9.
      *
           03  WRK-ZZZ             PIC ZZZ.
           03  WRK-NO              PIC Z(7).
           03  WRK-Z7-G.
               05  WRK-FIL             PIC X(09).
               05  WRK-Z7              PIC Z,ZZZ,ZZZ.
           03  WRK-Z72-G.
               05  WRK-FIL2            PIC X(09).
               05  WRK-Z72             PIC -,---,---.
      *
           03  WRK-ZHENSYU-G.
               05  WRK-ZHENSYU9        PIC X(09).
               05  WRK-ZHENSYU18       PIC X(18).
      *    自費集計
           03  WRK-JIHI-REC.
               05  WRK-JIHI            PIC S9(07)   OCCURS  5.
           03  WRK-JIHI-TOTAL          PIC S9(08).
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
      *    帳票カウント
       01  PRT-CNT                     PIC 9(10)   VALUE   ZERO.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    医療機関情報−基本情報 
           COPY    "CPSK1001.INC".
      *    医療機関情報−所在地、連絡先 
           COPY    "CPSK1002.INC".
      *    診療科目情報
           COPY    "CPSK1005.INC".
      *    請求書自費名称情報
           COPY    "CPSK1013.INC".
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
      *    請求書兼領収書共通パラメタ
           COPY    "CPORCHCN03.INC".
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           ORCHCN03AREA
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
           MOVE    "HCN3"              TO  HC01PARA-FORM-ID
           MOVE    SPA-TERMID          TO  HC01PARA-TERMID
           MOVE    SYS-TIME            TO  HC01PARA-SYOHMS
      *    変更★★★★★★
           COMPUTE PRT-CNT =   PRT-CNT +   1
           MOVE    PRT-CNT              TO  HC01PARA-CNT
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
      *　　印刷用データ出力
            WRITE  HCN03
      *
            CLOSE                      PRT-FILE
      *
            INITIALIZE                 ORCSMKPRTAREA
            MOVE   "HC01.sh"           TO  MKPRT-ID
            MOVE   "HCN03.red"         TO  MKPRT-DIA
            MOVE   SPACE               TO  MKPRT-DEF
            MOVE   HC01PARA            TO  MKPRT-DAT
            MOVE   SYS-1031-PRTNM(9)   TO  MKPRT-PRTNM
            CALL   "ORCSMKPRT"         USING
                                       ORCSMKPRTAREA
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
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
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
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
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
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
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
      *
      *    収納マスタ検索
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-PTID            TO  SYU-PTID
           MOVE    ORCHCN03-DENPNUM    TO  SYU-DENPNUM
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
           .
       100-SYORI-EXT.
           EXIT.
      *
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
      *    帳票編集処理
      *****************************************************************
       300-HC03-HEN-SEC                SECTION.
      *
           INITIALIZE                  HCN03
      *
      *    伝票番号
           MOVE    SYU-DENPNUM         TO  WRK-NO
           MOVE    WRK-NO              TO  HCN03-NO
      *    診療科
           MOVE    SYS-1005-SRYKANAME2 TO  HCN03-MIDASI
      *    患者番号
           MOVE    SPA-PTNUM           TO  HCN03-KNJNO
      *    患者名称
           MOVE    SPA-NAME            TO  HCN03-KNJNAMW
      *    保険種別
           MOVE    WRK-HKNCOMBI        TO  HCN03-HOKEN
      *    負担割合
           IF      SYU-PTFTNRATE       >   ZERO
               COMPUTE WRK-WARI        =   SYU-PTFTNRATE   /   10
               IF      SYU-PTFTNRATE(3:1)  =   ZERO
                   MOVE    WRK-WARI            TO  WRK-Z6
                   MOVE    WRK-Z6              TO  HCN03-FUTAN
               ELSE
                   MOVE    WRK-WARI            TO  WRK-Z62
                   MOVE    WRK-Z62             TO  HCN03-FUTAN
               END-IF
           END-IF
      *    請求開始日
           MOVE    SYU-SKYSTYMD        TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  HCN03-NYUINSTRYMD
      *    請求終了日
           MOVE    SYU-SKYEDYMD        TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  HCN03-NYUINENDYMD
      *    発行日
           MOVE    SYU-DENPPRTYMD      TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  HCN03-HAKYMD
      *
      *    医療機関住所
           MOVE    SYS-1002-ADRS       TO  HCN03-IRYOADRS
      *    医療機関名
           MOVE    SYS-1001-HOSPNAME   TO  HCN03-IRYOMEI
      *    医療機関ＴＥＬ
           MOVE    SYS-1002-TEL        TO  HCN03-IRYOTEL
      *    自費名称編集
           PERFORM 3102-JIHIMSG-HEN-SEC
      *
           MOVE    SPACE               TO  WRK-Z7-G
           MOVE    SPACE               TO  WRK-Z72-G
           MOVE    SPACE               TO  WRK-ZHENSYU-G
      *
      *    請求内容
           PERFORM VARYING     IDX     FROM  1   BY  1
                   UNTIL       IDX     >     12
               MOVE    SYU-HKNTEN(IDX)     TO  WRK-Z7
               MOVE    WRK-Z7              TO  WRK-ZHENSYU9
               PERFORM 800-HENKAN-SEC
               MOVE    WRK-ZHENSYU18       TO  HCN03-HKNRYO(IDX)
           END-PERFORM
      *
      *    労災・自賠の時、点数表示なし
           IF  COMB-HKNNUM     =    "971" OR "973"
               PERFORM VARYING     IDX     FROM  1   BY  1
                       UNTIL       IDX     >     11
                   MOVE    SPACE           TO  HCN03-HKNRYO(IDX)
               END-PERFORM
               MOVE    ALL "*"             TO  HCN03-HKNRYO(12)
           END-IF
      *
      *    保険適用分
      *    （労災・自賠の時、点数表示なし）
           EVALUATE    COMB-HKNNUM
           WHEN    "971"
               MOVE    SPACE           TO  HCN03-HOKENBUN
           WHEN    "973"
               COMPUTE WRK-GOKTEN      =    SYU-HKNTEKMONEY
                                       +    SYU-RSISHOSHIN-MONEY
                                       +    SYU-RSISAISHIN-MONEY
                                       +    SYU-RSISDO-MONEY
                                       +    SYU-RSIETC-MONEY
               MOVE    WRK-GOKTEN          TO  WRK-Z7
               MOVE    WRK-Z7              TO  WRK-ZHENSYU9
               PERFORM 800-HENKAN-SEC
               MOVE    WRK-ZHENSYU18       TO  HCN03-HOKENBUN
           WHEN    OTHER
               MOVE    SYU-HKNTEKMONEY     TO  WRK-Z7
               MOVE    WRK-Z7              TO  WRK-ZHENSYU9
               PERFORM 800-HENKAN-SEC
               MOVE    WRK-ZHENSYU18       TO  HCN03-HOKENBUN
           END-EVALUATE
      *
      *    保険適用外分
           MOVE    ZERO                TO  WRK-GOKTEN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   10
               COMPUTE WRK-GOKTEN      =   WRK-GOKTEN
                                       +  (SYU-TGMONEY (IDX)
                                       +   SYU-TGMONEY-TAX  (IDX) )
           END-PERFORM
           MOVE    WRK-GOKTEN          TO  WRK-Z72
           MOVE    WRK-Z72             TO  WRK-ZHENSYU9
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-ZHENSYU18       TO  HCN03-HOKENGAI
      *    自費
           MOVE    ZERO                TO  WRK-JIHI-REC
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               COMPUTE WRK-JIHI (IDX)      =   SYU-JIHI-TAXNASI (IDX)
                                           +   SYU-JIHI-TAXARI  (IDX)
               MOVE    WRK-JIHI (IDX)      TO  WRK-Z72
               MOVE    WRK-Z72             TO  WRK-ZHENSYU9
               PERFORM 800-HENKAN-SEC
               MOVE    WRK-ZHENSYU18       TO  HCN03-JIHI(IDX)
           END-PERFORM
      *
      *    自費計
           COMPUTE WRK-JIHI-TOTAL      =   SYU-JIHI-TOTAL
                                       +   SYU-JIHI-TOTAL-TAX
           MOVE    WRK-JIHI-TOTAL      TO  WRK-Z7
           MOVE    WRK-Z7              TO  WRK-ZHENSYU9
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-ZHENSYU18       TO  HCN03-JIHI(6)
      *    自費消費税
           MOVE    SYU-JIHI-TAX        TO  WRK-Z7
           MOVE    WRK-Z7              TO  WRK-ZHENSYU9
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-ZHENSYU18       TO  HCN03-JIHI(7)
      *    自費合計
           COMPUTE WRK-GOKTEN          =   WRK-JIHI-TOTAL
                                       +   SYU-JIHI-TAX
           MOVE    WRK-GOKTEN          TO  WRK-Z7
           MOVE    WRK-Z7              TO  WRK-ZHENSYU9
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-ZHENSYU18       TO  HCN03-JIHI(8)
      *    食事負担額
           MOVE    SYU-SKYMONEY-SKJ    TO  WRK-Z7
           MOVE    WRK-Z7              TO  WRK-ZHENSYU9
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-ZHENSYU18       TO  HCN03-SYOKUJI
      *    老人一部負担金
           MOVE    SYU-RJN-FTN         TO  WRK-Z7
           MOVE    WRK-Z7              TO  WRK-ZHENSYU9
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-ZHENSYU18       TO  HCN03-ROUJIN
      *    公費一部負担金
           MOVE    SYU-KOH-FTN         TO  WRK-Z7
           MOVE    WRK-Z7              TO  WRK-ZHENSYU9
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-ZHENSYU18       TO  HCN03-KOUHI
      *    室料差額
           MOVE    SYU-RMSAGAKU        TO  WRK-Z7
           MOVE    WRK-Z7              TO  WRK-ZHENSYU9
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-ZHENSYU18       TO  HCN03-RMSAGAKU
      *    調整金
           MOVE    SYU-CHOSEI          TO  WRK-Z72
           MOVE    WRK-Z72             TO  WRK-ZHENSYU9
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-ZHENSYU18       TO  HCN03-CHOSEI
      *    今回請求額
           MOVE    ORCHCN03-SEIKYU     TO  WRK-Z72
           MOVE    WRK-Z72             TO  WRK-ZHENSYU9
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-ZHENSYU18       TO  HCN03-KONSEIKYU
           MOVE    ORCHCN03-SEIKYU     TO  WRK-SKYMONEY
      *    今回入金額
           MOVE    ORCHCN03-NYUKIN     TO  WRK-Z7
           MOVE    WRK-Z7              TO  WRK-ZHENSYU9
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-ZHENSYU18       TO  HCN03-KONNYUKIN
           .
       310-HC03-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    半角全角変換処理
      *****************************************************************
       800-HENKAN-SEC             SECTION.
     *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"                 TO  KANACHK-SYORI
           MOVE    WRK-ZHENSYU9        TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF      KANACHK-RC          =   ZERO
               MOVE    KANACHK-OUT-INPUT(1:18)    TO  WRK-ZHENSYU18
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
               IF      SYU-DENPNUM     NOT =   WRK-DENPNUM
                   COMPUTE WRK-MISYU       =   SYU-SKYMONEY
                                           -   SYU-NYUKIN-TOTAL
                   ADD     WRK-MISYU           TO  WRK-MISYUMONEY
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
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
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
           PERFORM UNTIL       FLG-SYSKANRI    =   1
               IF      SPA-NYUGAIKBN       =   SYS-1013-KBNCD(1:1)
                   EVALUATE    SYS-1013-KBNCD(2:1)
                       WHEN    "1"
                           MOVE    SYS-1013-JIHINAME  TO
                                                      HCN03-JIHIMSG (1)
                       WHEN    "2"
                           MOVE    SYS-1013-JIHINAME  TO
                                                      HCN03-JIHIMSG (2)
                       WHEN    "3"
                           MOVE    SYS-1013-JIHINAME  TO
                                                      HCN03-JIHIMSG (3)
                       WHEN    "4"
                           MOVE    SYS-1013-JIHINAME  TO
                                                      HCN03-JIHIMSG (4)
                       WHEN    "5"
                           MOVE    SYS-1013-JIHINAME  TO
                                                      HCN03-JIHIMSG (5)
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
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           .
       300-END-EXT.
           EXIT.
      *
