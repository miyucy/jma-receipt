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
       PROGRAM-ID.             ORCHCM31.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者登録
      *  コンポーネント名  : 支払証明書（日別）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/12/09    NACL−森脇    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.01.01    NACL-森脇    03.03.18  出力先プリンタの変更
      *  01.01.02    NACL-森脇    03/07/15  出力先プリンタサブ追加
      *  02.01.01    NACL-森脇    03/12/10  出力条件修正
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
           COPY    "HCM31.INC".
      *
       WORKING-STORAGE             SECTION.
      *
      *     印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-PARA            PIC 9(01).
           03  FLG-SYUNOU          PIC 9(01).
           03  FLG-SYUMEI          PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME            PIC 9(08).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-PAGE            PIC 9(03).
           03  CNT-LINE            PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
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
           03  WRK-HENSYU-TBL.
               05  WRK-HKNTEN      PIC S9(07)  OCCURS  40.
               05  WRK-SKYMONEY    PIC S9(11)  OCCURS  40.
           03  WRK-GHENSYU-TBL.
               05  WRK-GHKNTEN     PIC S9(07).
               05  WRK-GSKYMONEY   PIC S9(11).
      *
           03  WRK-Z3              PIC ZZZ.
           03  WRK-Z7              PIC ZZZZZZZ.
           03  WRK-Z9              PIC ---,---,---.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    医療機関情報−基本情報 
           COPY    "CPSK1001.INC".
      *
      *    医療機関情報−所在地、連絡先
           COPY    "CPSK1002.INC".
      *
      *    出力先プリンタ名割り当て情報
           COPY  "CPSK1031.INC".
      *
      *    収納
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    収納明細
       01  SYUMEI-REC.
           COPY    "CPSYUMEI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *----(01.01.02)--ADD-START---
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
      *----(01.01.02)--ADD-END-----
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
        LINKAGE                    SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    処方箋共通パラメタ
           COPY    "CPORCHCM31.INC".
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           ORCHCM31AREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
      *    初期処理
           PERFORM 100-INIT-SEC
      *
      *    主処理
           PERFORM 200-MAIN-SEC
                   UNTIL   FLG-END     =   1
      *
           .
       000-PROC-EXT.
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
      *
           ACCEPT  SYS-TIME            FROM    TIME
      *
      *    医療機関情報−基本情報読み込み
           MOVE    SPACE           TO  SYS-1001-REC
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"          TO  SYS-1001-KANRICD
           MOVE    "*"             TO  SYS-1001-KBNCD
           MOVE    SYS-1001-REC    TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1001-REC
           ELSE
               INITIALIZE                  SYS-1001-REC
               MOVE    1               TO  FLG-END
               GO  TO  100-INIT-EXT
           END-IF
      *
      *    医療機関情報−所在地、連絡先読み込み
           MOVE    SPACE           TO  SYS-1002-REC
           INITIALIZE                  SYS-1002-REC
           MOVE    "1002"          TO  SYS-1002-KANRICD
           MOVE    "*"             TO  SYS-1002-KBNCD
           MOVE    SYS-1002-REC    TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1002-REC
           ELSE    
               INITIALIZE                  SYS-1002-REC
               MOVE    1               TO  FLG-END
               GO  TO  100-INIT-EXT
           END-IF
      *
      *    出力先プリンタ名割り当て情報編集
           INITIALIZE                  SYS-1031-REC
           INITIALIZE                  ORCSPRTNMAREA
           MOVE    "2"             TO  ORCSPRTNM-KBN
           MOVE    SPA-SYSYMD      TO  ORCSPRTNM-SRYYMD
           MOVE    "2"             TO  ORCSPRTNM-NYUGAIKBN
           CALL    "ORCSPRTNM"         USING
                                       ORCSPRTNMAREA
                                       SPA-AREA
                                       SYS-1031-REC
           IF      ORCSPRTNM-RC    NOT =   ZERO
               INITIALIZE                  SYS-1031-REC
               MOVE    1               TO  FLG-END
               GO  TO  100-INIT-EXT
           END-IF 
      *
      *    収納マスター読み込み
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPID      TO  SYU-HOSPID
           MOVE    SPA-PTID        TO  SYU-PTID
           MOVE    ORCHCM31-STRSRYYMD
                                   TO  SYU-SKYSTYMD
           MOVE    "99999999"      TO  SYU-SKYEDYMD
      *
           MOVE    SYUNOU-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYUNOU-KEY9"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               PERFORM 900-SYUNOU-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
      *    収納マスターがなくなったら処理終了
           IF      FLG-SYUNOU          =   1
               MOVE    1               TO  FLG-END
               GO  TO  100-INIT-EXT
           END-IF
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
           MOVE    ZERO            TO  CNT-PAGE
           MOVE    ZERO            TO  WRK-GHENSYU-TBL
      *
      *    収納マスターがなくなるまで繰り返す
           PERFORM UNTIL   FLG-SYUNOU  =   1
               INITIALIZE                  HCM31
               MOVE    ZERO            TO  CNT-LINE
               MOVE    ZERO            TO  WRK-HENSYU-TBL
      *
      *        収納マスタがなくなる、明細が４０行になるまで繰り返す
               PERFORM UNTIL  (FLG-SYUNOU  =   1)
                       OR     (CNT-LINE    >   40)
      *            診察日が指定した期間内ならば明細を編集する
                   IF         (SYU-SRYYMD  >=  ORCHCM31-STRSRYYMD)
                       AND    (SYU-SRYYMD  <=  ORCHCM31-ENDSRYYMD)
      *                帳票<明細>編集処理
                       PERFORM 210-PRT-LINE-SEC
                   END-IF
                   IF          CNT-LINE    <=    40
      *                収納マスターFETCH
                       PERFORM 900-SYUNOU-READ-SEC
                   END-IF
               END-PERFORM
      *
      *        帳票<見出>編集処理
               PERFORM 220-PRT-PAGE-SEC
      *        帳票出力処理
               PERFORM 230-PRT-WRITE-SEC
           END-PERFORM
      *
      *    収納明細マスタ閉じる
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           MOVE    "SYUMEI-KEY2"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
      *    収納マスタ閉じる
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           MOVE    "SYUNOU-KEY9"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           MOVE    1               TO  FLG-END
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票<明細>編集処理
      *****************************************************************
       210-PRT-LINE-SEC            SECTION.
      *
           IF          SYU-SRYYMD  NOT =   WRK-SYMD
               COMPUTE CNT-LINE        =   CNT-LINE    +  1
      *        ４０行を超えたら処理抜ける
               IF      CNT-LINE    >    40
                   GO  TO  210-PRT-LINE-EXT
               END-IF
      *        診療日
               MOVE    SYU-SRYYMD          TO  WRK-SYMD
               PERFORM 31012-SEIWA-HEN-SEC
               MOVE    WRK-HENYMDG(11:12)  TO  HCM31-SRYYMD(CNT-LINE)
           END-IF
      *
           COMPUTE WRK-HKNTEN(CNT-LINE)    =   WRK-HKNTEN(CNT-LINE)
                                           +   SYU-TOTAL-HKNTEN
           COMPUTE WRK-GHKNTEN             =   WRK-GHKNTEN
                                           +   SYU-TOTAL-HKNTEN
      *
      *    収納明細マスター読み込み
           INITIALIZE                  SYUMEI-REC
           MOVE    SPA-HOSPID      TO  SMEI-HOSPID
           MOVE    SPA-PTID        TO  SMEI-PTID
           MOVE    SYU-NYUGAIKBN   TO  SMEI-NYUGAIKBN
           MOVE    SYU-DENPNUM     TO  SMEI-DENPNUM
      *
           MOVE    SYUMEI-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYUMEI-KEY2"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               PERFORM 900-SYUMEI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SYUMEI
           END-IF
      *
      *    収納明細マスターがなくなるまで繰り返す
           PERFORM UNTIL   FLG-SYUMEI  =   1
      *        入金または返金がある場合
               IF  SMEI-NYUHEN-MONEY   NOT =   ZERO
                   COMPUTE WRK-SKYMONEY(CNT-LINE)
                                           =   WRK-SKYMONEY(CNT-LINE)
                                           +   SMEI-NYUHEN-MONEY
                   COMPUTE WRK-GSKYMONEY   =   WRK-GSKYMONEY
                                           +   SMEI-NYUHEN-MONEY
               END-IF
      *        収納明細マスターFETCH
               PERFORM 900-SYUMEI-READ-SEC
           END-PERFORM
      *
           .
       210-PRT-LINE-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票<見出>編集処理
      *****************************************************************
       220-PRT-PAGE-SEC            SECTION.
      *
      *    開始診療日
           MOVE    ORCHCM31-STRSRYYMD  TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  HCM31-STRSRYYMD
      *
      *    終了診療日
           MOVE    ORCHCM31-ENDSRYYMD  TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  HCM31-ENDSRYYMD
      *
      *    患者番号
           MOVE    SPA-PTNUM           TO  HCM31-PTNUM
      *
      *    患者名称
           MOVE    SPA-NAME            TO  HCM31-PTNAME
      *
      *    発行日
           MOVE    SPA-SYSYMD          TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  HCM31-HAKKOYMD
      *
      *    頁
           COMPUTE CNT-PAGE            =   CNT-PAGE    +   1
           MOVE    CNT-PAGE            TO  WRK-Z3
           MOVE    WRK-Z3              TO  HCM31-PAGE
      *
      *    医療機関住所
           MOVE    SYS-1002-ADRS       TO  HCM31-HOSPADRS
      *
      *    医療機関名
           MOVE    SYS-1001-HOSPNAME   TO  HCM31-HOSPNAME
      *
      *    医療機関ＴＥＬ
           MOVE    SYS-1002-TEL        TO  HCM31-HOSPTEL
      *
      *    保険テーブルから４０行分セット
           PERFORM VARYING IDX   FROM  1   BY   1
                   UNTIL   IDX   >     40
      *        保険点数
               IF      WRK-HKNTEN(IDX)     NOT =   ZERO
                   MOVE    WRK-HKNTEN(IDX)     TO  WRK-Z7
                   MOVE    WRK-Z7              TO  HCM31-HKNTEN(IDX)
                   MOVE    "点"                TO  HCM31-TEN(IDX)
               END-IF
      *        入返金額
               IF      WRK-SKYMONEY(IDX)   NOT =   ZERO
                   MOVE    WRK-SKYMONEY(IDX)   TO  WRK-Z9
                   MOVE    WRK-Z9              TO  HCM31-SKYMONEY(IDX)
                   MOVE    "円"                TO  HCM31-YEN(IDX)
               END-IF
           END-PERFORM
      *
           IF          FLG-SYUNOU  =   1
      *        合計保険点数
               MOVE    WRK-GHKNTEN     TO  WRK-Z7
               MOVE    WRK-Z7          TO  HCM31-GHKNTEN
      *        合計入返金額
               MOVE    WRK-GSKYMONEY   TO  WRK-Z9
               MOVE    WRK-Z9          TO  HCM31-GSKYMONEY
           END-IF
      *
           .
       220-PRT-PAGE-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票出力処理
      *****************************************************************
       230-PRT-WRITE-SEC           SECTION.
      *
      *    ファイルＯＰＥＮ
           MOVE    "HCM31"         TO  HC01PARA-FORM-ID
           MOVE    SPA-TERMID      TO  HC01PARA-TERMID
           MOVE    SYS-TIME        TO  HC01PARA-SYOHMS
           MOVE    CNT-PAGE        TO  HC01PARA-CNT
           OPEN    OUTPUT              PRT-FILE
           WRITE   HCM31
           CLOSE                       PRT-FILE
      *
           INITIALIZE                  ORCSMKPRTAREA
           MOVE    "HC01.sh"       TO  MKPRT-ID
           MOVE    "HCM31.red"     TO  MKPRT-DIA
           MOVE    SPACE           TO  MKPRT-DEF
           MOVE    HC01PARA        TO  MKPRT-DAT
           MOVE    SYS-1031-PRTNM(9)
                                   TO  MKPRT-PRTNM
           CALL    "ORCSMKPRT"         USING
                                       ORCSMKPRTAREA
      *
           .
       230-PRT-WRITE-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       31012-SEIWA-HEN-SEC         SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY2-AREA
           MOVE    "21"            TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD        TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING
                                       STS-AREA-DAY
                                       LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG
           .
       31012-SEIWA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読み込み
      *****************************************************************
       900-SYSKANRI-READ-SEC       SECTION.
      *
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
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
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納マスターFETCH
      *****************************************************************
       900-SYUNOU-READ-SEC         SECTION.
      *
           MOVE    "SYUNOU-KEY9"   TO  ORC-DBPATH
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
      *----(02.01.01)--ADD-START---
               IF      SYU-DENPJTIKBN      =   "3"
                   GO  TO  900-SYUNOU-READ-SEC
               END-IF
      *----(02.01.01)--ADD-END-----
               MOVE    ZERO            TO  FLG-SYUNOU
           ELSE
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
           .
       900-SYUNOU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納明細マスター読み込み
      *****************************************************************
       900-SYUMEI-READ-SEC         SECTION.
      *
           MOVE    "SYUMEI-KEY2"   TO  ORC-DBPATH
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYUMEI-REC
               MOVE    ZERO            TO  FLG-SYUMEI
           ELSE
               MOVE    1               TO  FLG-SYUMEI
           END-IF
      *
           .
       900-SYUMEI-READ-EXT.
           EXIT.
      *
