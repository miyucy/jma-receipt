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
       PROGRAM-ID.             ORHCML12.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 点数マスタ
      *  コンポーネント名  : 点数マスタ一覧表・薬剤分類区分あり（HCML01）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/08/22    NACL-森脇     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.01.01     NACL-森脇    04/03/16  点数の桁修正
      *  01.01.02    NACL-森脇    06/07/27  フラグ追加、MONFUNC対応
      *  03.05.01    NACL-森脇    07/05/29  グループ診療対応
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *    エラーファイル
           SELECT  TENSUERR-FILE   ASSIGN  TENSUERR
                                   FILE    STATUS  IS  STS-TENSUERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    エラーファイル
       FD  TENSUERR-FILE.
       01  TENSUERR-REC            PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *    シェル用領域
           COPY    "CPCOMMONSHELL.INC".
           COPY    "CPSHELLTBL.INC".
           COPY    "ORCA-DBPATH".
      *----(03.05.01)--UPD-START---
      *    エラーファイル 名称領域 
      *     COPY    "CPCOMMONDAT2.INC"
      *                             REPLACING  //RECE01PARA//
      *                             BY         //TENSUERR//.
      *     03  FILLER              PIC X(04)   VALUE   ".dat".
           COPY    "CPERRFL.INC"   REPLACING  //ERRFLPARA//
                                   BY         //TENSUERR//.
      *----(03.05.01)--UPD-END-----
      *     
           COPY    "HCML01.INC".
      *
      *    スパ領域
       01  STS-AREA.
           03  STS-TENSUERR        PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-TENSUPLUS       PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-LINE            PIC 9(02).
           03  CNT-PAGE            PIC 9(06).
      *
      *    集計領域
       01  SUM-AREA.
           03  SUM-PAGE            PIC 9(10).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
      *----(03.05.01)--ADD-START---
           03  WRK-PARA-HOSPNUM    PIC 9(02).
      *----(03.05.01)--ADD-END-----
           03  WRK-PARA-JOBID      PIC 9(07).
           03  WRK-PARA-SHELLID    PIC X(08).
           COPY    "CPHCMLSHELL.INC"
                                   REPLACING  //SHELL-//
                                   BY         //WRK-PARA-//.
      *
       01  INEX-AREA.
           03  IDX                 PIC 9(02).
      *
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-PATH            PIC X(64).
           03  WRK-TENSUERR        PIC X(200).
      *
           03  WRK-LNKYMD          PIC X(10).
           03  WRK-MSTYMDH         PIC X(10).
      *
           03  WRK-SYSYMD.
               05  WRK-SYSYY       PIC 9(04).
               05  WRK-SYSMM       PIC 9(02).
               05  WRK-SYSDD       PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-HENYMDG         PIC X(22).
      *
           03  WRK-NAME            PIC X(100).
      *
           03  WRK-PAGE            PIC ZZ,ZZ9.
      *----(01.01.01)--UPD-START---
           03  WRK-TEN             PIC ZZZ,ZZZ,ZZ9.99.
      *----(01.01.01)--UPD-END-----
           03  WRK-CSYYOURYO       PIC ZZ,ZZ9.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    医療機関名
           COPY  "CPSK1001.INC".
      *
      *    出力先プリンタ名割り当て情報
           COPY  "CPSK1031.INC".
      *
      *    高額請求資料用薬剤分類情報
           COPY  "CPSK1036.INC".
      *
      *    点数マスタ
           COPY    "CPTENSU.INC".
      *
      *    点数付加情報マスタ
       01  TENSUPLUS-REC.
           COPY    "CPTENSUPLUS.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    印刷ＤＢ更新サブ
           COPY    "CPORCSPRT.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "MCPAREA".
           COPY    "COMMON-SPA".
      *    LIKE使用KEY対応
           COPY    "CPORCSADDSIGN.INC".
      *
      ****************************************************************
       LINKAGE                     SECTION.
       01  COMMAND-PARAM.
           02  FILLER              PIC X(256).
      ****************************************************************
       PROCEDURE               DIVISION
               USING
           COMMAND-PARAM.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
                   UNTIL   FLG-END     =   1
      *
           PERFORM 300-END-SEC
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  SUM-AREA
grpsys     INITIALIZE                  SPA-AREA
      *
           PERFORM 100-DBOPEN-SEC
      *
           UNSTRING   COMMAND-PARAM    DELIMITED  BY  ","
                                       INTO    LNK-PRTKANRI-RENNUM
                                               LNK-PRTKANRI-TBL-KEY
                                               LNK-PRTKANRI-TBL-GROUP
                                               LNK-PRTKANRI-SHORI-RENNUM
                                               LNK-PRTKANRI-SRYYM
                                               LNK-PRTKANRI-SKYYMD
                                               LNK-PRTKANRI-SHELLID
                                               LNK-PRTKANRI-PRIORITY
                                               LNK-PRTKANRI-TERMID
                                               LNK-PRTKANRI-OPID
                                               LNK-PRTKANRI-PRTNM
                                               WRK-PARA-JOBID
                                               WRK-PARA-SHELLID
                                               WRK-PARA-AREA
      *----(03.05.01)--ADD-START---
                                               WRK-PARA-HOSPNUM
                                               TENSUERR
           END-UNSTRING
           MOVE    WRK-PARA-HOSPNUM    TO  SPA-HOSPNUM
      *----(03.05.01)--ADD-END-----
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
      *----(03.05.01)--ADD-START---
           MOVE    WRK-PARA-HOSPNUM
                                   TO  JOB-HOSPNUM
      *----(03.05.01)--ADD-END-----
           MOVE    "ORHCML12"      TO  JOB-PGID
           MOVE    "点数マスタ一覧表・薬剤分類区分"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
                                       SPA-AREA
      *
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  WRK-LNKYMD
           PERFORM 831-YMDCONV12-SEC
           MOVE    WRK-LNKYMD      TO  WRK-MSTYMDH
      *
      *----(03.05.01)--UPD-START---
      *     MOVE    "TENSERR"       TO  TENSUERR-FILE-ID
      *     MOVE    LNK-PRTKANRI-TERMID
      *                             TO  TENSUERR-TERMID
      *     MOVE    WRK-PARA-HOSPNUM    TO  TENSUERR-HOSPNUM
      *----(03.05.01)--UPD-END-----
      *
      *    パラメタ編集処理
           PERFORM 110-PARA-HENSYU-SEC
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタ編集処理
      *****************************************************************
       110-PARA-HENSYU-SEC         SECTION.
      *
      *    医療機関名称編集
           MOVE    SPACE           TO  SYS-1001-REC
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"          TO  SYS-1001-KANRICD
           MOVE    "*"             TO  SYS-1001-KBNCD
           MOVE    WRK-PARA-MSTYMD TO  SYS-1001-STYUKYMD
                                       SYS-1001-EDYUKYMD
      *----(03.05.01)--UPD-START---
           MOVE    WRK-PARA-HOSPNUM    TO  SYS-1001-HOSPNUM
      *----(03.05.01)--UPD-END-----
           MOVE    SYS-1001-REC    TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF          FLG-SYSKANRI    =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1001-REC
               IF          SYS-1001-HOSPNAME   =   LOW-VALUE
                   MOVE    SPACE           TO  SYS-1001-HOSPNAME
               END-IF
           ELSE
               INITIALIZE                  SYS-1001-REC
               MOVE    "医療機関名称が取得できませんでした。"
                                       TO  WRK-TENSUERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
           .
      *
       110-PARA-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    帳票印刷開始処理
           PERFORM 900-DBSELECT-SEC
      *
           PERFORM UNTIL   FLG-TENSU   =   1
      *        帳票編集<見出し>処理
               PERFORM 310-HEAD-HEN-SEC
      *        帳票編集<明細>処理
               PERFORM 320-BODY-HEN-SEC
      *        帳票印刷処理
               PERFORM 390-PRINT-OUT-SEC
           END-PERFORM
      *
           PERFORM 900-DBCLOSE-SEC
      *
           MOVE    1               TO  FLG-END
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<ヘッダー部>処理
      *****************************************************************
       310-HEAD-HEN-SEC            SECTION.
      *
           MOVE    ZERO            TO  CNT-LINE
           ADD     1               TO  CNT-PAGE
      *
           MOVE    SPACE           TO  HCML01
      *
           MOVE    SYS-1001-HOSPNAME
                                   TO  HCML01-HOSPNAME
           MOVE    WRK-MSTYMDH     TO  HCML01-MSTYMD
           MOVE    CNT-PAGE        TO  WRK-PAGE
           MOVE    WRK-PAGE        TO  HCML01-PAGE
      *
           .
       310-HEAD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<明細行>処理
      *****************************************************************
       320-BODY-HEN-SEC            SECTION.
      *
           MOVE    ZERO            TO  CNT-LINE
      *
           PERFORM UNTIL   FLG-TENSU   =   1
                   OR      CNT-LINE    =   15
      *        点数付加情報検索
               PERFORM 900-TENSUPLUS-READ-SEC
      *        高額請求資料用薬剤分類情報
               PERFORM 900-SYS1036-READ-SEC
      *
               IF          FLG-SYSKANRI    =   1
                   MOVE    TNS-NAME        TO  WRK-NAME
               ELSE
                   MOVE    SPACE           TO  WRK-NAME
                   STRING  TNS-NAME            DELIMITED  BY  SPACE
                           "（"                DELIMITED  BY  SIZE
                           SYS-1036-BUNRUIMEI  DELIMITED  BY  SPACE
                           "）"                DELIMITED  BY  SIZE
                                               INTO    WRK-NAME
                   END-STRING
               END-IF
      *
               ADD     1               TO  CNT-LINE
      *
               MOVE    TNS-TEN         TO  WRK-TEN
               MOVE    WRK-TEN         TO  HCML01-TEN(CNT-LINE)
               MOVE    TNS-CSYYOURYO   TO  WRK-CSYYOURYO
               MOVE    WRK-CSYYOURYO   TO  HCML01-CSYYOURYO(CNT-LINE)
      *
               MOVE    TNS-SRYCD       TO  HCML01-SRYCD(CNT-LINE)
               MOVE    WRK-NAME        TO  HCML01-NAME(CNT-LINE)
               MOVE    TNS-TANINAME    TO  HCML01-TANINAME(CNT-LINE)
               MOVE    TNS-YUKOSTYMD   TO  HCML01-YUKOSTYMD(CNT-LINE)
               MOVE    TNS-YUKOEDYMD   TO  HCML01-YUKOEDYMD(CNT-LINE)
               MOVE    TNS-YAKKAKJNCD  TO  HCML01-YAKKAKJNCD(CNT-LINE)
               MOVE    "-"             TO  HCML01-NYORO(CNT-LINE)
               IF          TNS-KEIKASOCHIYMD
                                       NOT =  "00000000"
                   MOVE    TNS-KEIKASOCHIYMD
                                       TO HCML01-KEIKASOCHIYMD(CNT-LINE)
               END-IF
      *        麻毒区分
               EVALUATE  TNS-MADOKUKBN
               WHEN  "0"
                   MOVE  SPACE         TO  HCML01-MADOKUKBN(CNT-LINE)
               WHEN  "1"
                   MOVE  "麻毒"        TO  HCML01-MADOKUKBN(CNT-LINE)
               WHEN  "2"
                   MOVE  "毒薬"        TO  HCML01-MADOKUKBN(CNT-LINE)
               WHEN  "3"
                   MOVE  "覚せい剤"    TO  HCML01-MADOKUKBN(CNT-LINE)
               WHEN  "5"
                   MOVE  "向精神薬"    TO  HCML01-MADOKUKBN(CNT-LINE)
               WHEN  OTHER
                   MOVE  "＊＊＊＊"    TO  HCML01-MADOKUKBN(CNT-LINE)
               END-EVALUATE
      *        神経破壊剤
               EVALUATE  TNS-SINKEIHAKAIKBN
               WHEN  "0"
                   MOVE  SPACE    TO  HCML01-SINKEIHAKAIKBN(CNT-LINE)
               WHEN  "1"
                   MOVE  "神経破壊"
                                  TO  HCML01-SINKEIHAKAIKBN(CNT-LINE)
               WHEN  OTHER
                   MOVE  "＊＊＊＊"
                                  TO  HCML01-SINKEIHAKAIKBN(CNT-LINE)
               END-EVALUATE
      *        生物学的製剤
               EVALUATE  TNS-SEIBUTUGAKUKBN
               WHEN  "0"
                   MOVE  SPACE    TO  HCML01-SEIBUTUGAKUKBN(CNT-LINE)
               WHEN  "1"
                   MOVE  "生物製剤"
                                  TO  HCML01-SEIBUTUGAKUKBN(CNT-LINE)
               WHEN  OTHER
                   MOVE  "＊＊＊＊"
                                  TO  HCML01-SEIBUTUGAKUKBN(CNT-LINE)
               END-EVALUATE
      *        造影剤(造影補助剤) 
               EVALUATE  TNS-ZOEIZAIKBN
               WHEN  "0"
                   MOVE  SPACE        TO  HCML01-ZOEIZAIKBN(CNT-LINE)
               WHEN  "1"
                   MOVE  "造影剤"     TO  HCML01-ZOEIZAIKBN(CNT-LINE)
               WHEN  "2"
                   MOVE  "造影補助"   TO  HCML01-ZOEIZAIKBN(CNT-LINE)
               WHEN  OTHER
                   MOVE  "＊＊＊＊"   TO  HCML01-ZOEIZAIKBN(CNT-LINE)
               END-EVALUATE
      *        薬剤 
               EVALUATE  TNS-YKZKBN
               WHEN  "1"
                   MOVE  "内用"       TO  HCML01-YKZKBN(CNT-LINE)
               WHEN  "3"
                   MOVE  "その他"     TO  HCML01-YKZKBN(CNT-LINE)
               WHEN  "4"
                   MOVE  "注射"       TO  HCML01-YKZKBN(CNT-LINE)
               WHEN  "6"
                   MOVE  "外用"       TO  HCML01-YKZKBN(CNT-LINE)
               WHEN  "8"
                   MOVE  "歯科薬剤"   TO  HCML01-YKZKBN(CNT-LINE)
               WHEN  "9"
                   MOVE  "歯科特定"   TO  HCML01-YKZKBN(CNT-LINE)
               WHEN  OTHER
                   MOVE  "＊＊＊＊"   TO  HCML01-YKZKBN(CNT-LINE)
               END-EVALUATE
      *        剤型
               EVALUATE  TNS-ZAIGATAKBN
               WHEN  "0"
                   MOVE  SPACE        TO  HCML01-ZAIGATAKBN(CNT-LINE)
               WHEN  "1"
                   MOVE  "散剤"       TO  HCML01-ZAIGATAKBN(CNT-LINE)
               WHEN  "2"
                   MOVE  "顆粒剤"     TO  HCML01-ZAIGATAKBN(CNT-LINE)
               WHEN  "3"
                   MOVE  "液剤"       TO  HCML01-ZAIGATAKBN(CNT-LINE)
               WHEN  OTHER
                   MOVE  "＊＊＊＊"   TO  HCML01-ZAIGATAKBN(CNT-LINE)
               END-EVALUATE
      *
               PERFORM 900-DBFETCH-SEC
      *
           END-PERFORM
      *
           .
       320-BODY-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       390-PRINT-OUT-SEC           SECTION.
      *
           INITIALIZE                  ORCSPRTAREA
           MOVE    "INS"           TO  SPRT-MODE
           MOVE    LNK-PRTKANRI-RENNUM
                                   TO  SPRT-RENNUM
           MOVE    LNK-PRTKANRI-TBL-KEY
                                   TO  SPRT-TBL-KEY
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                   TO  SPRT-TBL-GROUP
           MOVE    LNK-PRTKANRI-SRYYM
                                   TO  SPRT-SRYYM
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  SPRT-SKYYMD
           MOVE    LNK-PRTKANRI-SHELLID
                                   TO  SPRT-SHELLID
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                   TO  SPRT-SHORI-RENNUM
           MOVE    LNK-PRTKANRI-PRIORITY
                                   TO  SPRT-PRIORITY
           MOVE    "HCML01"        TO  SPRT-PRTID
           MOVE    "点数マスタ一覧表・薬剤分類区分"
                                   TO  SPRT-TITLE
           MOVE    HCML01          TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID
                                   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM
                                   TO  SPRT-PRTNM
           MOVE    "1"             TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
                                       SPA-AREA
           IF      SPRT-RETURN         =   ZERO
               CONTINUE
           ELSE
               MOVE    "印刷ＤＢに更新できませんでした"
                                       TO  WRK-TENSUERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       390-PRINT-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC          SECTION.
      *
           OPEN    INPUT   TENSUERR-FILE
      *
           IF          STS-TENSUERR    =   ZERO
               CONTINUE
           ELSE
               OPEN    OUTPUT              TENSUERR-FILE
      *
               MOVE    WRK-TENSUERR    TO  TENSUERR-REC
               WRITE   TENSUERR-REC
      *
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
      *----(03.05.01)--ADD-START---
               MOVE    WRK-PARA-HOSPNUM
                                       TO  JOB-HOSPNUM
      *----(03.05.01)--ADD-END-----
               MOVE    WRK-TENSUERR    TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"           USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
                                           SPA-AREA
           END-IF
      *
           CLOSE   TENSUERR-FILE
           MOVE    1               TO  FLG-END
      * 
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           DISPLAY "*** ORHCML12 END ***"
      *     
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    CNT-PAGE        TO  JOB-UPDCNT
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
      *----(03.05.01)--ADD-START---
           MOVE    WRK-PARA-HOSPNUM
                                   TO  JOB-HOSPNUM
      *----(03.05.01)--ADD-END-----
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
                                       SPA-AREA
      *
           PERFORM 900-DBDISCONNECT-SEC
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *   和暦年月日→西暦年月日（機能１２）
      *****************************************************************
       831-YMDCONV12-SEC           SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY2-AREA
           MOVE    "21"            TO  LNK-DAY2-IRAI
           MOVE    WRK-LNKYMD      TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING
                                       STS-AREA-DAY
                                       LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD1
                                   TO  WRK-LNKYMD
           .
      *
       831-YMDCONV12-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ　検索 
      *****************************************************************
       900-DBSELECT-SEC            SECTION.
      *  
           INITIALIZE                  TNS-TENSU-REC
           MOVE    "600000000"     TO  TNS-SRYCD
           MOVE    "699999999"     TO  TNSUP-SRYCD
      *
           MOVE    WRK-PARA-MSTYMD     TO  TNS-YUKOSTYMD
                                           TNS-YUKOEDYMD
           EVALUATE    WRK-PARA-SYUKBN
           WHEN    1
           WHEN    4
               MOVE    "key23s"  TO  WRK-PATH
           WHEN    2
               MOVE    "key23m"  TO  WRK-PATH
           WHEN    3
               MOVE    "key23k"  TO  WRK-PATH
           END-EVALUATE
      *
      *----(03.05.01)--UPD-START---
           MOVE    WRK-PARA-HOSPNUM    TO  TNS-HOSPNUM
      *----(03.05.01)--UPD-END-----
           MOVE    TNS-TENSU-REC   TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "tbl_tensu"     TO  MCP-TABLE
           MOVE    WRK-PATH        TO  MCP-PATHNAME
grpsys     CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
grpsys                                     SPA-AREA
           IF          MCP-RC      =   ZERO
               PERFORM 900-DBFETCH-SEC
           ELSE
               MOVE    1               TO  FLG-TENSU
           END-IF
           .
       900-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *     点数マスタを検索処理
      *****************************************************************
       900-DBFETCH-SEC             SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           MOVE    "tbl_tensu"     TO  MCP-TABLE
           MOVE    WRK-PATH        TO  MCP-PATHNAME
grpsys     CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
grpsys                                     SPA-AREA
           IF          MCP-RC      =   ZERO
               MOVE    ZERO            TO  FLG-TENSU
               MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
           ELSE
               MOVE    1               TO  FLG-TENSU
           END-IF
           .
       900-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ　クローズ処理
      *****************************************************************
       900-DBCLOSE-SEC             SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           MOVE    "tbl_tensu"     TO  MCP-TABLE
           MOVE    WRK-PATH        TO  MCP-PATHNAME
grpsys     CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
grpsys                                     SPA-AREA
           .
       900-DBCLOSE-EXT.
           EXIT.
      *
      ******************************************************************
      *    点数付加情報マスター読込
      *****************************************************************
       900-TENSUPLUS-READ-SEC      SECTION.
      *
           INITIALIZE                  TENSUPLUS-REC
           MOVE    TNS-SRYCD       TO  TNSP-SRYCD
           MOVE    TNS-YUKOSTYMD   TO  TNSP-YUKOSTYMD
           MOVE    TNS-YUKOEDYMD   TO  TNSP-YUKOEDYMD
      *
      *----(03.05.01)--UPD-START---
           MOVE    WRK-PARA-HOSPNUM    TO  TNSP-HOSPNUM
      *----(03.05.01)--UPD-END-----
           MOVE    TENSUPLUS-REC   TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "tbl_tensuplus" TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
grpsys     CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
grpsys                                     SPA-AREA
           IF          MCP-RC      =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "tbl_tensuplus" TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
grpsys         CALL    "ORCDBMAIN"     USING   MCPAREA
                                               MCPDATA-REC
grpsys                                         SPA-AREA
               IF          MCP-RC      =   ZERO
                   MOVE    MCPDATA-REC     TO  TENSUPLUS-REC
                   MOVE    ZERO            TO  FLG-TENSUPLUS
               ELSE
                   INITIALIZE                  TENSUPLUS-REC
                   MOVE    1               TO  FLG-TENSUPLUS
               END-IF
           ELSE
               INITIALIZE                  TENSUPLUS-REC
               MOVE    1               TO  FLG-TENSUPLUS
           END-IF
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           MOVE    "tbl_tensuplus" TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
grpsys     CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
grpsys                                     SPA-AREA
      *
           .
       900-TENSUPLUS-READ-EXT.
           EXIT.
      *
      ****************************************************************
      *    高額請求資料用薬剤分類情報
      ****************************************************************
       900-SYS1036-READ-SEC        SECTION.
      *
           MOVE    SPACE           TO  SYS-1036-REC
           INITIALIZE                  SYS-1036-REC
           MOVE    "1036"          TO  SYS-1036-KANRICD
           MOVE    TNSP-TENPUYAKKBN    TO  SYS-1036-KBNCD
           MOVE    WRK-PARA-MSTYMD     TO  SYS-1036-STYUKYMD
                                           SYS-1036-EDYUKYMD
      *----(03.05.01)--UPD-START---
           MOVE    WRK-PARA-HOSPNUM    TO  SYS-1036-HOSPNUM
      *----(03.05.01)--UPD-END-----
           MOVE    SYS-1036-REC    TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1036-REC
           END-IF
      *
           .
       900-SYS1036-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読み込み
      *****************************************************************
       800-SYSKANRI-READ-SEC       SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key10"         TO  MCP-PATHNAME
grpsys     CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
grpsys                                     SPA-AREA
           IF          MCP-RC          =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "tbl_syskanri"  TO  MCP-TABLE
               MOVE    "key10"         TO  MCP-PATHNAME
grpsys         CALL    "ORCDBMAIN"     USING   MCPAREA
                                               MCPDATA-REC
grpsys                                         SPA-AREA
               IF          MCP-RC          =   ZERO
                   MOVE    ZERO            TO  FLG-SYSKANRI
               ELSE
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key10"         TO  MCP-PATHNAME
grpsys     CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
grpsys                                     SPA-AREA
      *
           .
       800-SYSKANRI-READ-EXT.
           EXIT.
      *      
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC              SECTION.
      *
           MOVE    "DBOPEN"        TO  MCP-FUNC.
           MOVE    LOW-VALUE       TO  MCP-TABLE.
           MOVE    LOW-VALUE       TO  MCP-PATHNAME.
grpsys     CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
grpsys                                     SPA-AREA
      *
           MOVE    "DBSTART"       TO  MCP-FUNC.
           MOVE    LOW-VALUE       TO  MCP-TABLE.
           MOVE    LOW-VALUE       TO  MCP-PATHNAME.
grpsys     CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
grpsys                                     SPA-AREA
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC        SECTION.
      *
           MOVE    "DBCOMMIT"      TO  MCP-FUNC.
           MOVE    LOW-VALUE       TO  MCP-TABLE.
           MOVE    LOW-VALUE       TO  MCP-PATHNAME.
grpsys     CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
grpsys                                     SPA-AREA
      *
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC.
           MOVE    LOW-VALUE       TO  MCP-TABLE.
           MOVE    LOW-VALUE       TO  MCP-PATHNAME.
grpsys     CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
grpsys                                     SPA-AREA
           .
       900-DBCLOSE-EXT.
           EXIT.
